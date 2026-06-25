import { unified } from "unified";
import remarkParse from "remark-parse";
import remarkGfm from "remark-gfm";
import path from "node:path/posix";
import { readFileSync } from "node:fs";
import rehypeRaw from "rehype-raw";
import remarkRehype from "remark-rehype";
import { Root, RootContent } from "hast";
import remarkDirective from "remark-directive";
import { visit } from "unist-util-visit";

import {
  Content,
  ImageCarouselContent,
  IncludedFileContent,
  PlaceHolderContent,
  getContentFromNode,
} from "./classes.ts";

const tagsWithChildren = [
  "p",
  "pre",
  "ol",
  "ul",
  "details",
  "div",
  "table",
  "footer",
];

const processor = unified()
  .use(remarkParse)
  .use(remarkGfm)
  .use(remarkDirective)
  .use(remarkDirectiveToHast)
  .use(remarkRehype, { allowDangerousHtml: true })
  .use(rehypeRaw);

function walkTreeManually(
  node: Root | RootContent,
  items: Content[],
  currentDirectory: string,
  shouldProcessIncludes: boolean,
): void {
  if (!node || !("children" in node) || !node.children) {
    return;
  }

  for (let i = 0; i < node.children.length; i++) {
    const child = node.children[i];

    if (child.type === "element" && tagsWithChildren.includes(child.tagName)) {
      const listItems: RootContent[] = child.children || [];
      const childrenOfTaggedItems: Content[] = [];
      for (const item of listItems) {
        if (item.type === "element")
          walkTreeManually(
            item,
            childrenOfTaggedItems,
            currentDirectory,
            child.tagName != "footer",
          );
      }

      var transformedNode = getContentFromNode(
        child,
        currentDirectory,
        child.tagName != "footer",
      );

      if (transformedNode instanceof IncludedFileContent) {
        items.push(...transformedNode.content);
      } else if (!(transformedNode instanceof PlaceHolderContent))
        items.push(transformedNode);

      continue;
    }

    if (child.type === "element") {
      var transformedNode = getContentFromNode(
        child,
        currentDirectory,
        shouldProcessIncludes,
      );
      if (
        transformedNode != undefined &&
        transformedNode instanceof IncludedFileContent
      ) {
        items.pop();
        items.push(...transformedNode.content);
      } else if (transformedNode instanceof ImageCarouselContent) {
        if (items.at(-1) instanceof ImageCarouselContent) {
          (items.at(-1) as ImageCarouselContent).children.push(
            ...transformedNode.children,
          );
        } else if (
          items.at(-1) instanceof PlaceHolderContent &&
          items.at(-2) instanceof ImageCarouselContent
        )
          (items.at(-2) as ImageCarouselContent).children.push(
            ...transformedNode.children,
          );
        else items.push(transformedNode);
      } else if (!(transformedNode instanceof PlaceHolderContent))
        items.push(transformedNode);
    }

    walkTreeManually(
      child,
      items,
      currentDirectory,
      child.type === "element" ? child.tagName != "footer" : true,
    );
  }
}

function remarkDirectiveToHast() {
  return (tree: any) => {
    visit(tree, (node) => {
      if (
        node.type === "containerDirective" ||
        node.type === "leafDirective" ||
        node.type === "textDirective"
      ) {
        node.data = node.data || {};

        node.data.hName = "div";
        node.data.hProperties = {
          ...(node.data.hProperties || {}),
          "data-name": node.name,
          className: ["directive-container", `directive-${node.name}`],
        };
      }
    });
  };
}

export function compileScreen(rootDirectory: string, screenName: string) {
  const inputFilePath = path.resolve(rootDirectory, `${screenName}.md`);
  const rawMarkdown = readFileSync(inputFilePath, "utf-8");

  const ast = processor.parse(rawMarkdown);
  const runAst = processor.runSync(ast);

  const items: Content[] = [];
  walkTreeManually(runAst, items, rootDirectory, true);

  return items;
}
