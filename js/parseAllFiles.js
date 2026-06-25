import { readdirSync, statSync, mkdirSync, writeFileSync } from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compileScreen } from "./parser.ts";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const rootDir = "markdowns";

const markdownRootFolder = path.resolve(rootDir);

const hostName = "roonil.github.io";

function getAllMarkdownFiles(dirPath) {
  let results = [];
  const list = readdirSync(dirPath);

  list.forEach((file) => {
    const fullPath = path.join(dirPath, file);
    const stat = statSync(fullPath);

    if (stat && stat.isDirectory()) {
      if (file.toLowerCase() === "include") return;
      results = results.concat(getAllMarkdownFiles(fullPath));
    } else if (file.endsWith(".md")) {
      results.push(fullPath);
    }
  });
  return results;
}

function skipNullReplacer(key, value) {
  if (key === null) return undefined;
  if (value === null || value === undefined) {
    return undefined;
  }

  return value;
}

function generateFullHtmlWrapper(title, canonicalUrl, bodyContentHtml) {
  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  
  <title>${title} | WayVes Wiki</title>
  <link rel="canonical" href="${canonicalUrl}" />
  
  <script type="text/javascript">
    (function() {
      var currentPath = window.location.pathname;
      if (currentPath !== '/' && currentPath !== '/index.html' && !window.location.hash) {
        window.location.replace(window.location.origin + '/#' + currentPath);
      }
    })();
  </script>
</head>
<body>

  <header role="banner">
    <nav aria-label="Global Directory">
      <a href="https://${hostName}">WayVes Wiki Home</a>
    </nav>
  </header>

  <main id="content" role="main">
    <article>
${bodyContentHtml}
    </article>
  </main>

</body>
</html>`;
}

function writeHTML(pageTitle, routePath, nodes) {
  const compiledBodySnippet = nodes.map((node) => node.toHTML()).join("\n");

  const finalHtmlPayload = generateFullHtmlWrapper(
    pageTitle,
    `https://${hostName}/${routePath}/`,
    compiledBodySnippet,
  );

  const fileDestination = path.join(
    __dirname,
    `../web/${routePath}/index.html`,
  );
  mkdirSync(path.dirname(fileDestination), { recursive: true });
  writeFileSync(fileDestination, finalHtmlPayload, "utf8");
}

function computeSeoTitle(routePath) {
  const acronyms = {
    ncs: "NCS",
    cli: "CLI",
    yaml: "YAML",
    glsl: "GLSL",
  };

  const segments = routePath.split("/").map((segment) => {
    let cleanSegment = segment.replace(/-/g, " ");

    return cleanSegment
      .split(" ")
      .map((word) => {
        const lowerWord = word.toLowerCase();
        if (acronyms[lowerWord]) return acronyms[lowerWord];
        return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
      })
      .join(" ");
  });

  if (segments.length === 2 && segments[1].toLowerCase() === "overview") {
    const category = segments[0].endsWith("s")
      ? segments[0].slice(0, -1)
      : segments[0];
    return `${category} Overview`;
  }

  return segments.reverse().join(" - ");
}

function runGlobalWorkspaceBuild() {
  const allTargetMarkdownFiles = getAllMarkdownFiles(markdownRootFolder);

  allTargetMarkdownFiles.forEach((absoluteFilePath) => {
    const pathRelativeFromRoot = path.relative(
      markdownRootFolder,
      absoluteFilePath,
    );
    const dynamicScreenName = pathRelativeFromRoot.replace(/\.md$/, "");

    try {
      const currrentItems = compileScreen(
        path.resolve(rootDir, path.dirname(pathRelativeFromRoot)),
        path.basename(dynamicScreenName),
      );

      const jsonString = JSON.stringify(currrentItems, skipNullReplacer, 2);
      mkdirSync(path.dirname(`jsons/${dynamicScreenName}.json`), {
        recursive: true,
      });
      writeFileSync(`jsons/${dynamicScreenName}.json`, jsonString, "utf-8");

      writeHTML(
        computeSeoTitle(dynamicScreenName),
        dynamicScreenName,
        currrentItems,
      );

      console.log(`Successfully exported: jsons/${dynamicScreenName}.json`);
    } catch (error) {
      console.error(
        `Error compiling screen asset [${dynamicScreenName}]:`,
        error,
      );
    }
  });

  console.log("\n[COMPLETE]: Master workspace build script finished running!");
}

runGlobalWorkspaceBuild();
