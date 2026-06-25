import type { Root, Element, Text, RootContent, ElementContent } from "hast";
import { toText } from "hast-util-to-text";
import path from "path";

import { toString } from "hast-util-to-string";
import { compileScreen } from "./parser";

export enum MarkdownBlockType {
  Paragraph = "p",
  MarkdownOrderedList = "ol",
  MarkdownUnorderedList = "ul",
  ListItem = "li",
  InlineCode = "code",
  ExpansionTile = "details",
  CodeSnippet = "pre",
  Div = "div",
  Table = "table",
  Anchor = "a",
  Image = "img",
  HorizontalDivider = "hr",
  Heading1 = "h1",
  Heading2 = "h2",
  Heading3 = "h3",
  Heading4 = "h4",
  Heading5 = "h5",
  Heading6 = "h6",
  Footer = "footer",
  Unknown = "",
}

export class Content {
  type: string;

  constructor(blockType: string) {
    this.type = blockType;
  }

  toHTML(): string {
    return "";
  }
}

export class SuperHolderContent extends Content {
  children: Content[];

  getReducedChildren(contentList: Content[]) {
    return contentList
      .filter((e) => !(e instanceof PlaceHolderContent))
      .reduce<
        Content[]
      >((acc, child) => (child instanceof IncludedFileContent ? acc.push(...child.content) : child instanceof ImageCarouselContent && acc.at(-1) instanceof ImageCarouselContent ? (acc.at(-1) as ImageCarouselContent).children.push(...child.children) : acc.push(child), acc), []);
  }

  constructor(blockType: string, children: Content[]) {
    super(blockType);
    this.children = this.getReducedChildren(children);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("");
    return `<${this.type}>${innerHTML}</${this.type}>`;
  }
}

export class DivContent extends SuperHolderContent {
  className: string;

  constructor(className: string, children: Content[]) {
    super("div", children);

    this.className = className;
  }
}

export class FooterLinkContent extends Content {
  pathName: string;
  route: string;

  constructor(pathName: string, route: string) {
    super("footerLink");
    this.pathName = pathName;
    this.route = route;
  }
}

export class FooterContent extends Content {
  previous: FooterLinkContent | undefined;
  next: FooterLinkContent | undefined;

  constructor(
    previous: FooterLinkContent | undefined,
    next: FooterLinkContent | undefined,
  ) {
    super("footer");
    this.previous = previous;
    this.next = next;
  }

  override toHTML(): string {
    if (!this.previous && !this.next) {
      return "";
    }

    let linksHTML = "";

    if (this.previous) {
      const escapedPrevPath = this.previous.pathName;
      const escapedPrevRoute = this.previous.route;
      const cleanRoute = escapedPrevRoute.endsWith("/")
        ? escapedPrevRoute
        : `${escapedPrevRoute}/`;

      linksHTML += `    <a href="${cleanRoute}" rel="prev">← Prev: ${escapedPrevPath}</a>\n`;
    }

    if (this.next) {
      const escapedNextPath = this.next.pathName;
      const escapedNextRoute = this.next.route;
      const cleanRoute = escapedNextRoute.endsWith("/")
        ? escapedNextRoute
        : `${escapedNextRoute}/`;

      linksHTML += `    <a href="${cleanRoute}" rel="next">Next: ${escapedNextPath} →</a>\n`;
    }

    return `<footer role="contentinfo">
  <nav aria-label="Wiki Pagination">
${linksHTML}  </nav>
</footer>`;
  }
}

export class PlaceHolderContent extends Content {
  constructor() {
    super("placeholder");
  }
}

export class TextContent extends Content {
  content: string;

  constructor(content: string) {
    super("text");
    this.content = content;
  }

  override toHTML(): string {
    let escaped = this.content
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");

    return escaped.replace(/`([^`]+)`/g, "<code>$1</code>");
  }
}

export class ParagraphContent extends SuperHolderContent {
  constructor(children: Content[]) {
    super("paragraph", children);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("");
    return `<p>${innerHTML}</p>`;
  }
}

export class InlineCodeContent extends SuperHolderContent {
  constructor(children: Content[]) {
    super("inlineCodeBlock", children);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("\n");

    return `<code>${innerHTML}</code>`;
  }
}

export class HeadingContent extends ParagraphContent {
  depth: number;
  constructor(children: Content[], depth: number) {
    super(children);
    this.depth = depth;
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("\n");

    return `<h${this.depth}>
    ${innerHTML}
    </h${this.depth}>`;
  }
}

export class LinkContent extends Content {
  altText: string;
  content: Content[];

  constructor(content: Content[], altText: string) {
    super("link");
    this.content = content;
    this.altText = altText;
  }

  override toHTML(): string {
    const innerHTML = this.content.map((c) => c.toHTML()).join("\n");

    return `<a href="${this.altText}" target="_blank" rel="noopener noreferrer">${innerHTML}</a>`;
  }
}

export class IncludedFileContent extends LinkContent {
  constructor(content: Content[], altText: string) {
    super(content, altText);
  }
}

export class ImageContent extends Content {
  altText: string;
  staticUrl: string;
  animatedUrl: string;

  constructor(staticUrl: string, animatedUrl: string, altText: string) {
    super("image");

    this.staticUrl = "/assets" + staticUrl;
    this.animatedUrl = "/assets" + animatedUrl;
    this.altText = altText;
  }
}

export class ImageCarouselContent extends Content {
  children: ImageContent[];

  constructor(children: ImageContent[]) {
    super("imageCarousel");
    this.children = children;
  }

  override toHTML(): string {
    const imagesHTML = this.children
      .map((img) => {
        const escapedAlt = img.altText;
        const escapedStatic = img.staticUrl;
        const escapedAnim = img.animatedUrl;

        return `    <figure style="display: inline-block; margin: 10px; max-width: 100%;">
      <a href="${escapedAnim}" title="View animation for ${escapedAlt}">
        <img src="${escapedStatic}" alt="${escapedAlt}" loading="lazy" style="max-width: 100%; height: auto;" />
      </a>
      <figcaption>${escapedAlt}</figcaption>
    </figure>`;
      })
      .join("\n");

    return `<section class="image-carousel" aria-label="Shader Preview Images">
${imagesHTML}
</section>`;
  }
}

export class ListItemContent extends SuperHolderContent {
  constructor(children: Content[]) {
    super("listItem", children);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("\n");

    return `<li>
      ${innerHTML}
    </li>`;
  }
}

export class ListContent extends SuperHolderContent {
  ordered: boolean;

  constructor(children: Content[], isOrdered: boolean) {
    super("markdownList", children);

    this.ordered = isOrdered;
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("\n");

    return `<${this.ordered ? "ol" : "ul"}>
    ${innerHTML}
    </${this.ordered ? "ol" : "ul"}>`;
  }
}

export class AdmonitionContent extends SuperHolderContent {
  constructor(type: string, children: Content[]) {
    super(type, children);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("");

    return `<aside class="admonition ${this.type}" aria-label="${this.type.toUpperCase()}">
    <strong>${this.type.toUpperCase()}:</strong>
    ${innerHTML}
    </aside>`;
  }
}

function getTextFromContent(content: Content): string {
  if (content instanceof InlineCodeContent)
    return `\`${content.children.map((e) => getTextFromContent(e)).join(" ")}\``.trim();

  if (content instanceof SuperHolderContent)
    return content.children
      .map((e) => getTextFromContent(e))
      .join(" ")
      .trim();

  if (content instanceof TextContent) return content.content.trim();

  return "";
}

export class TableContent extends Content {
  headers: string[];
  rows: string[][];

  constructor(headers: Content[], rows: Content[][][]) {
    super("table");
    const newRows: string[][] = [];
    const newHeaders: string[] = [];

    for (const content of headers) {
      newHeaders.push(getTextFromContent(content));
    }

    for (const row of rows) {
      let rowText: string[] = [];
      for (const content of row) {
        rowText.push(
          content
            .map((e) => getTextFromContent(e).replaceAll("\\n", "\n"))
            .join(" "),
        );
      }
      newRows.push(rowText);
    }

    this.rows = newRows;
    this.headers = newHeaders;
  }

  override toHTML(): string {
    const renderCellText = (cellText: string): string => {
      let escaped = cellText
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");

      return escaped.replace(/`([^`]+)`/g, "<code>$1</code>");
    };

    const headerRow = this.headers
      .map((heading) => `<th>${renderCellText(heading)}</th>`)
      .join("");

    const bodyRows = this.rows
      .map((rowCells) => {
        const tdCells = rowCells
          .map((cell) => `<td>${renderCellText(cell)}</td>`)
          .join("");
        return `  <tr>${tdCells}</tr>`;
      })
      .join("\n");

    return `<table>
  <thead>
    <tr>${headerRow}</tr>
  </thead>
  <tbody>
${bodyRows}
  </tbody>
</table>`;
  }
}

export class CodeSnippetContent extends Content {
  language: string;
  content: string;

  constructor(content: string, language: string) {
    super("codeSnippet");
    this.language = language;
    this.content = content;
  }

  override toHTML(): string {
    return `<pre><code class="language-${this.language}">
${this.content}
</code></pre>`;
  }
}

export class HorizontalDividerContent extends Content {
  constructor() {
    super("horizontalDivider");
  }

  override toHTML(): string {
    return "<hr />";
  }
}

export class ExpansionTileContent extends SuperHolderContent {
  title: Content[];
  subtitle: Content[];

  constructor(title: Content[], subtitle: Content[], children: Content[]) {
    super("expansionTile", children);
    this.title = super.getReducedChildren(title);

    this.subtitle = super.getReducedChildren(subtitle);
  }

  override toHTML(): string {
    const innerHTML = this.children.map((c) => c.toHTML()).join("\n");
    const innerTitle = this.title.map((c) => c.toHTML()).join("\n");
    const innerSubtitle = this.subtitle.map((c) => c.toHTML()).join("\n");
    return `<details open>
    <summary>
      <strong>${innerTitle}</strong>
      <span>${innerSubtitle}</span>
    </summary>
    ${innerHTML}
  </details>`;
  }

  public toJSON(): Record<string, any> {
    return {
      type: this.type,
      title: this.title,
      subtitle: this.subtitle,
      children: this.children,
    };
  }
}

function getTitleAndSubtitleFromExpansionNode(
  expansionTileNode: Element,
  currentDirectory: string,
  shouldProcessIncludes: boolean,
): Content[][] {
  var title = undefined;
  var subtitle = undefined;

  var summaryItem: Element | undefined = expansionTileNode.children.find(
    (value) => value.type === "element" && value.tagName === "summary",
  ) as Element | undefined;

  var h6Item: Element | undefined = summaryItem?.children.find(
    (value) => value.type === "element" && value.tagName === "h6",
  ) as Element | undefined;

  title = summaryItem?.children
    .filter(
      (e) => e.type === "text" || (e.type === "element" && e.tagName != "h6"),
    )
    .map((e) =>
      getContentFromNode(e as Element, currentDirectory, shouldProcessIncludes),
    );
  subtitle = h6Item?.children.map((e) =>
    getContentFromNode(e as Element, currentDirectory, shouldProcessIncludes),
  );

  return [title ?? [], subtitle ?? []];
}

const upperCaseTitleStrings: Array<string> = ["ncs", "glsl", "cli", "yaml"];

export function formatPathToPascalTitle(
  currentDirectory: string,
  linkPath: string,
): string {
  const absoluteCurrentDir = path.resolve(currentDirectory.trim());
  const absoluteTargetFile = path.resolve(absoluteCurrentDir, linkPath);
  const absoluteTargetDir = path.dirname(absoluteTargetFile);

  const ext = path.extname(absoluteTargetFile);
  const rawFile = path.basename(absoluteTargetFile, ext);
  const parentFolderName = path.basename(absoluteTargetDir);

  const toPascalCase = (str: string): string => {
    const cleanStr = str.replace(/[./\\]/g, " ").trim();
    if (!cleanStr) return "";
    return cleanStr
      .split(/[-_\s]+/)
      .map((word) =>
        upperCaseTitleStrings.includes(word.toLowerCase())
          ? word.toUpperCase()
          : word.charAt(0).toUpperCase() + word.slice(1).toLowerCase(),
      )
      .join(" ");
  };

  const cleanFileTitle = toPascalCase(rawFile);

  if (absoluteCurrentDir === absoluteTargetDir) {
    return cleanFileTitle;
  }

  const cleanDirTitle = toPascalCase(parentFolderName);
  return cleanDirTitle
    ? `${cleanDirTitle} - ${cleanFileTitle}`
    : cleanFileTitle;
}

function getBeamerRoute(directoryPath: string, linkPath: string): string {
  const absoluteTarget = path.resolve(directoryPath.trim(), linkPath);

  const rootMarkdownsDir = directoryPath.split(path.sep);

  const relativeFromRoot = path.relative(
    rootMarkdownsDir
      .slice(0, rootMarkdownsDir.indexOf("markdowns") + 1)
      .join(path.sep),
    absoluteTarget,
  );

  const ext = path.extname(relativeFromRoot);
  const routeWithoutExt = relativeFromRoot.slice(0, -ext.length);

  return "/" + routeWithoutExt.replace(/\\/g, "/");
}

export function getContentFromNode(
  node: Element | Text,
  currentDirectory: string,
  shouldProcessIncludes: boolean,
): Content {
  if (node.type === "text")
    return node.value.trim() != ""
      ? new TextContent(node.value)
      : new PlaceHolderContent();

  const blockType: MarkdownBlockType = node.tagName as MarkdownBlockType;

  switch (blockType) {
    case MarkdownBlockType.InlineCode:
      return new InlineCodeContent(
        node.children
          .filter((d) => d.type === "element" || d.type === "text")
          .map((e) =>
            getContentFromNode(e, currentDirectory, shouldProcessIncludes),
          ),
      );

    case MarkdownBlockType.Heading1:
    case MarkdownBlockType.Heading2:
    case MarkdownBlockType.Heading3:
    case MarkdownBlockType.Heading4:
    case MarkdownBlockType.Heading5:
    case MarkdownBlockType.Heading6:
      return new HeadingContent(
        node.children
          .filter((d) => d.type === "element" || d.type === "text")
          .map((e) =>
            getContentFromNode(e, currentDirectory, shouldProcessIncludes),
          ),
        /^h[1-6]$/.test(node.tagName)
          ? parseInt(node.tagName.charAt(1), 10)
          : 0,
      );
    case MarkdownBlockType.Paragraph:
      const paragraphChildren = node.children
        .filter((d) => d.type === "element" || d.type === "text")
        .map((e) =>
          getContentFromNode(e, currentDirectory, shouldProcessIncludes),
        );

      if (
        paragraphChildren.length === 1 &&
        paragraphChildren[0] instanceof IncludedFileContent
      )
        return paragraphChildren[0];

      return new ParagraphContent(paragraphChildren);

    case MarkdownBlockType.Image:
      return new PlaceHolderContent();

    case MarkdownBlockType.Footer:
      const links: ParagraphContent = node.children
        .filter((e) => e.type === "element")
        .map((e) =>
          getContentFromNode(e, currentDirectory, false),
        )[0] as ParagraphContent;

      const previousLink = (links.children as LinkContent[]).find(
        (linkContent) =>
          (linkContent.content as TextContent[]).find(
            (textContent) => textContent.content.toLowerCase() === "prev",
          ) != undefined,
      );

      const nextLink = (links.children as LinkContent[]).find(
        (linkContent) =>
          (linkContent.content as TextContent[]).find(
            (textContent) => textContent.content.toLowerCase() === "next",
          ) != undefined,
      );

      const previousFooter =
        previousLink === undefined
          ? undefined
          : new FooterLinkContent(
              formatPathToPascalTitle(currentDirectory, previousLink!.altText),
              getBeamerRoute(currentDirectory, previousLink.altText),
            );

      const nextFooter =
        nextLink === undefined
          ? undefined
          : new FooterLinkContent(
              formatPathToPascalTitle(currentDirectory, nextLink!.altText),
              getBeamerRoute(currentDirectory, nextLink.altText),
            );

      return new FooterContent(previousFooter, nextFooter);

    case MarkdownBlockType.Anchor:
      if ((node.properties.href as string).includes(".md")) {
        if (shouldProcessIncludes)
          return new IncludedFileContent(
            compileScreen(
              currentDirectory,
              (node.properties.href as string).replace(/\.md$/, ""),
            ),
            "f",
          );
      }
      const imageNodes = node.children.filter(
        (e) => e.type === "element" && e.tagName == "img",
      ) as Element[];

      if (imageNodes != undefined && imageNodes.length != 0) {
        return new ImageCarouselContent(
          imageNodes.map(
            (imageNode) =>
              new ImageContent(
                imageNode.properties.src as string,
                node.properties.href as string,
                imageNode.properties.alt as string,
              ),
          ),
        );
      }

      return new LinkContent(
        node.children.map((n) =>
          getContentFromNode(
            n as Element,
            currentDirectory,
            shouldProcessIncludes,
          ),
        ),
        node.properties.href as string,
      );

    case MarkdownBlockType.HorizontalDivider:
      return new HorizontalDividerContent();

    case MarkdownBlockType.CodeSnippet:
      const codeNode = node.children?.find(
        (c): c is Element => c.type === "element" && c.tagName === "code",
      );

      if (!codeNode) return new PlaceHolderContent();
      let language = "glsl";
      const classList = codeNode.properties?.className;

      if (Array.isArray(classList)) {
        const langClass = classList.find((c) =>
          (c as string).startsWith("language-"),
        ) as string;
        if (langClass) {
          language = langClass.replace("language-", "");
        }
      }
      const multiLineCodeString = toString(codeNode).replace(/\n$/, "");

      return new CodeSnippetContent(multiLineCodeString, language);

    case MarkdownBlockType.Table:
      const headers: Content[] = [];
      const rows: Content[][][] = [];

      const thead = node.children.find(
        (c): c is Element => c.type === "element" && c.tagName === "thead",
      );

      if (thead) {
        const headerRow = thead.children.find(
          (c): c is Element => c.type === "element" && c.tagName === "tr",
        );
        if (headerRow) {
          headerRow.children.forEach((cell) => {
            if (cell.type === "element" && cell.tagName === "th") {
              headers.push(
                ...cell.children.map((e) =>
                  getContentFromNode(
                    e as Element,
                    currentDirectory,
                    shouldProcessIncludes,
                  ),
                ),
              );
            }
          });
        }
      }

      const tbody = node.children.find(
        (c): c is Element => c.type === "element" && c.tagName === "tbody",
      );

      if (tbody) {
        tbody.children.forEach((row) => {
          if (row.type === "element" && row.tagName === "tr") {
            const rowData: Content[][] = [];

            row.children.forEach((cell) => {
              if (cell.type === "element" && cell.tagName === "td") {
                rowData.push(
                  cell.children.map((e) =>
                    getContentFromNode(
                      e as Element,
                      currentDirectory,
                      shouldProcessIncludes,
                    ),
                  ),
                );
              }
            });

            if (rowData.length > 0) {
              rows.push(rowData);
            }
          }
        });
      }

      return new TableContent(headers, rows);

    case MarkdownBlockType.ExpansionTile:
      var titleAndSubtitle = getTitleAndSubtitleFromExpansionNode(
        node,
        currentDirectory,
        shouldProcessIncludes,
      );
      return new ExpansionTileContent(
        titleAndSubtitle[0],
        titleAndSubtitle[1],
        node.children
          .map((e) =>
            getContentFromNode(
              e as Text | Element,
              currentDirectory,
              shouldProcessIncludes,
            ),
          )
          .filter((e): e is Content => e !== undefined),
      );

    case MarkdownBlockType.Div:
      if (node.properties?.dataName) {
        return new AdmonitionContent(
          node.properties.dataName as string,
          node.children.map((e) =>
            getContentFromNode(
              e as Element | Text,
              currentDirectory,
              shouldProcessIncludes,
            ),
          ),
        );
      }

      return new DivContent(
        (node?.properties?.className as Array<any>)[0] as string,
        node.children
          .filter((e) => e.type === "element" || e.type === "text")
          .map((e) =>
            getContentFromNode(e, currentDirectory, shouldProcessIncludes),
          ),
      );

    case MarkdownBlockType.MarkdownOrderedList:
    case MarkdownBlockType.MarkdownUnorderedList:
      return new ListContent(
        node.children
          .map((e) =>
            getContentFromNode(
              e as Element | Text,
              currentDirectory,
              shouldProcessIncludes,
            ),
          )
          .filter((e): e is Content => e !== undefined),
        node.tagName === "ol",
      );
    case MarkdownBlockType.ListItem:
      return new ListItemContent(
        node.children
          .map((e) =>
            getContentFromNode(
              e as Element | Text,
              currentDirectory,
              shouldProcessIncludes,
            ),
          )
          .filter((e): e is Content => e !== undefined),
      );
    case MarkdownBlockType.Unknown:
      return new PlaceHolderContent();
  }
}
