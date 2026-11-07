import {
  CodeSnippetContent,
  Content,
  DivContent,
  ExpansionTileContent,
  FooterContent,
  HeadingContent,
  ImageCarouselContent,
  InlineCodeContent,
  LinkContent,
  ParagraphContent,
  SuperHolderContent,
  TableContent,
  TextContent,
} from "./classes.ts";

export interface SearchTerm {
  keyword: string;
  snippet: string;
}

export interface SearchSection {
  anchor?: string;
  heading: string;
  summary: string;
  text: string;
  terms: SearchTerm[];
}

export interface SearchPage {
  route: string;
  pageTitle: string;
  sections: SearchSection[];
}

const summaryLength = 180;

export function plainText(content: Content): string {
  if (content instanceof TextContent) return content.content;
  if (content instanceof InlineCodeContent)
    return `\`${content.children.map(plainText).join("").trim()}\``;
  if (content instanceof LinkContent)
    return content.content.map(plainText).join("");
  if (content instanceof ParagraphContent)
    return content.children.map(plainText).join("");
  if (content instanceof ExpansionTileContent)
    return content.title.map(plainText).join(" ");
  if (content instanceof SuperHolderContent)
    return content.children.map(plainText).join(" ");
  return "";
}

const normalise = (text: string) => text.replace(/\s+/g, " ").trim();

function slugify(text: string): string {
  const slug = text
    .toLowerCase()
    .replace(/`/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
  return slug || "section";
}

function truncate(text: string, length: number): string {
  if (text.length <= length) return text;
  let cut = text.lastIndexOf(" ", length);
  if (cut <= 0) cut = length;
  let result = text.slice(0, cut);
  if ((result.match(/`/g) ?? []).length % 2 === 1)
    result = result.slice(0, result.lastIndexOf("`"));
  return `${result.trimEnd()}…`;
}

export function indexPage(
  route: string,
  fallbackTitle: string,
  items: Content[],
): SearchPage {
  const usedAnchors = new Map<string, number>();
  const uniqueAnchor = (text: string) => {
    const slug = slugify(text);
    const count = usedAnchors.get(slug) ?? 0;
    usedAnchors.set(slug, count + 1);
    return count === 0 ? slug : `${slug}-${count}`;
  };

  const sections: SearchSection[] = [];
  let current: SearchSection = {
    heading: fallbackTitle,
    summary: "",
    text: "",
    terms: [],
  };
  sections.push(current);

  const startSection = (anchor: string, heading: string, summary = "") => {
    current = { anchor, heading, summary, text: "", terms: [] };
    sections.push(current);
  };

  const appendText = (text: string) => {
    const clean = normalise(text);
    if (!clean) return;
    current.text = current.text ? `${current.text} ${clean}` : clean;
  };

  const walk = (content: Content) => {
    if (content instanceof HeadingContent) {
      const heading = normalise(plainText(content));
      content.anchor = uniqueAnchor(heading);
      startSection(content.anchor, heading);
      return;
    }

    if (content instanceof ExpansionTileContent) {
      const heading = normalise(plainText(content));
      content.anchor = uniqueAnchor(heading);

      const parent = current;
      startSection(
        content.anchor,
        heading,
        normalise(content.subtitle.map(plainText).join(" ")),
      );
      content.children.forEach(walk);
      current = parent;
      return;
    }

    if (content instanceof ParagraphContent) {
      const text = normalise(plainText(content));
      if (!current.summary) current.summary = truncate(text, summaryLength);
      appendText(text);
      return;
    }

    if (content instanceof TableContent) {
      for (const row of content.rows) {
        const [keyword, ...description] = row.map(normalise);
        if (keyword && keyword.length <= 60)
          current.terms.push({
            keyword,
            snippet: truncate(description.join(" — "), summaryLength),
          });
        appendText(row.join(" "));
      }
      return;
    }

    if (content instanceof CodeSnippetContent) {
      appendText(content.content);
      return;
    }

    if (content instanceof ImageCarouselContent) {
      appendText(content.children.map((image) => image.altText).join(" "));
      return;
    }

    if (content instanceof FooterContent || content instanceof DivContent)
      return;

    if (content instanceof SuperHolderContent) {
      content.children.forEach(walk);
      return;
    }

    appendText(plainText(content));
  };

  items.forEach(walk);

  return {
    route,
    pageTitle: fallbackTitle,
    sections: sections.filter(
      (section) => section.anchor || section.text || section.terms.length,
    ),
  };
}
