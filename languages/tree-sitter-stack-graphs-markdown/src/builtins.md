# Markdown Elements and Syntax

This document showcases standard Markdown syntax elements for tree-sitter-stack-graphs.

## Headings

# Heading Level 1
## Heading Level 2
### Heading Level 3
#### Heading Level 4
##### Heading Level 5
###### Heading Level 6

Alternate Heading 1
==================

Alternate Heading 2
------------------

## Text Formatting

This is a paragraph with **bold text**, *italic text*, and ***bold italic text***.

You can also use __underscores__ for _emphasis_ instead of asterisks.

~~Strikethrough~~ is also supported.

## Links

[Inline Link](https://example.com)

[Link with Title](https://example.com "Link Title")

<https://example.com> - Autolink

[Reference Link][ref]

[ref]: https://example.com "Reference Link"

## Images

![Inline Image](image.jpg)

![Image with Title](image.jpg "Image Title")

![Reference Image][img-ref]

[img-ref]: image.jpg "Reference Image"

## Lists

### Unordered Lists

* Item 1
* Item 2
  * Nested Item 1
  * Nested Item 2
* Item 3

- Alternative syntax
- For unordered lists

### Ordered Lists

1. First item
2. Second item
   1. Nested ordered item
   2. Another nested item
3. Third item

### Task Lists

- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task

### Definition Lists

Term 1
: Definition 1

Term 2
: Definition 2
: Another definition for Term 2

## Code

Inline `code` span.

```javascript
// Fenced code block with language
function example() {
  console.log("Hello, world!");
}
```

    // Indented code block
    function indentedExample() {
      return true;
    }

## Blockquotes

> This is a blockquote
>
> > Nested blockquotes are also supported
>
> Back to the original blockquote

## Horizontal Rules

---

***

___

## Tables

| Header 1 | Header 2 | Header 3 |
|----------|:--------:|---------:|
| Left     | Center   | Right    |
| Cell     | Cell     | Cell     |

## Footnotes

Here's a sentence with a footnote[^1].

[^1]: This is the footnote content.

## HTML in Markdown

<div class="custom-class">
  This is a <em>HTML block</em> in Markdown.
</div>

## Escaping Characters

\*Not emphasized\*

\`Not code\`

## YAML Front Matter

---
title: Markdown Example
author: Example Author
date: 2023-05-15
tags: [markdown, example]
---

## Special Elements

### Math (if supported)

$$
E = mc^2
$$

$inline math$

### Emoji (if supported)

:smile: :heart: :+1:

### Highlight (if supported)

==Highlighted text==

### Subscript and Superscript (if supported)

H~2~O and E=mc^2^

### Abbreviations (if supported)

*[HTML]: Hyper Text Markup Language
*[CSS]: Cascading Style Sheets

HTML and CSS are web technologies.

### Comments

<!-- This is a comment that won't be rendered -->

## Anchors and Cross-References

<a name="custom-anchor"></a>

[Link to custom anchor](#custom-anchor)

[Link to heading](#headings)

