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

function generateFullHtmlWrapper(
  title,
  canonicalUrl,
  bodyContentHtml,
  isRootHomepage = false,
) {
  // 1. If this is the root homepage (https://github.io), output the redirect layout
  if (isRootHomepage) {
    return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WayVes Wiki</title>
  <link rel="canonical" href="${canonicalUrl}" />
  
  <!-- Safe permanent redirect pattern for search bots and human clients -->
  <meta http-equiv="refresh" content="0; url=/getting-started/installation/" />
  <script>window.location.href = "/getting-started/installation/";</script>
</head>
<body>
  <p>Redirecting to the <a href="/getting-started/installation/">WayVes Wiki Installation Guide</a>...</p>
</body>
</html>`;
  }

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <base href="/" />
  
  <title>${title} | WayVes Wiki</title>
  <link rel="canonical" href="${canonicalUrl}" />
  
  <meta name="description" content="Wiki for WayVes Visualiser - an OpenGL-based Shader Framework for Wayland" />
  <meta name="generator" content="Flutter Web via Static Hybrid Pipeline" />
  
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <link rel="icon" type="image/png" href="favicon.png" sizes="48x48" />
  <link rel="manifest" href="manifest.json" />

  <style>
    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      overflow: hidden;
      background-color: #ffffff;
    }

    #seo-fallback-layer {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      padding: 40px;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      transition: opacity 0.3s ease;
      opacity: 0;
      }
  </style>
  
  <script src="/flutter_bootstrap.js" async></script>
</head>
<body>



  <div id="seo-fallback-layer">
    <header role="banner">
      <nav aria-label="Global Directory">
        <a href="/">WayVes Wiki Home</a>
      </nav>
    </header>

    <main id="content" role="main">
      <article>
${bodyContentHtml}
      </article>
    </main>
  </div>
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
