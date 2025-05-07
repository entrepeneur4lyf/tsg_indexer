# TSG Indexer

A library for indexing code repositories using Tree-sitter Stack Graphs, designed to be used in MCP servers and other tools.

## Overview

TSG Indexer is a library that uses [tree-sitter-stack-graphs](https://github.com/github/stack-graphs) to analyze code repositories and build a graph representation of the code structure. This graph captures the relationships between definitions and references across files, enabling powerful code navigation and analysis.

## Features

- Support for multiple languages:
  - Rust
  - Python
  - JavaScript
  - TypeScript
  - Java
  - Swift
  - Objective-C
  - CSS
  - Scala
  - Zig
  - YAML
  - Go
  - PHP
  - XML
  - JSDoc
  - Bash
  - JSON
  - HTML
  - C#
  - Ruby
  - Markdown
  - Lua
  - Dart
  - And more!
- Recursive directory traversal
- Multiple output formats:
  - JSON
  - DOT graph
- Feature flags for optional functionality:
  - `cli` - Command-line interface support
  - `lsp` - Language Server Protocol support

## Installation

Add to your Cargo.toml:

```toml
[dependencies]
tsg_indexer = { version = "0.1.0", features = ["cli", "lsp"] }
```

Or clone and build the repository:

```bash
# Clone the repository
git clone https://github.com/yourusername/tsg_indexer.git
cd tsg_indexer

# Build the project
cargo build --release
```

## Library Usage

```rust
use tsg_indexer::{IndexerConfig, run_indexer};
use std::path::PathBuf;

fn main() -> anyhow::Result<()> {
    // Create configuration
    let config = IndexerConfig {
        path: PathBuf::from("src/"),
        format: "json".to_string(),
        output: Some(PathBuf::from("output.json")),
        verbose: true,
    };
    
    // Run the indexer
    run_indexer(config)
}
```

## CLI Usage

When built with the `cli` feature:

```bash
# Index a single file
tsg_indexer_cli examples/test_rust.rs

# Index a directory recursively
tsg_indexer_cli src/

# Output in DOT format
tsg_indexer_cli --format dot src/

# Output to a file
tsg_indexer_cli --output graph.json src/

# Verbose mode
tsg_indexer_cli --verbose src/
```

## Use with MCP Servers

This library is designed to be used in Model Control Protocol (MCP) servers for code indexing and navigation capabilities. It provides the core functionality needed for parsing and analyzing code repositories with tree-sitter and stack-graphs.

### MCP Integration

To integrate with an MCP server:

1. Add tsg_indexer as a dependency with appropriate features
2. Use the library's API to index code and build stack graphs
3. Leverage the graph data for code navigation, reference finding, and more

## Example

```bash
# Index the examples directory (with CLI feature enabled)
tsg_indexer_cli examples/

# The output will show the graph structure in JSON format by default
```

## Contributing

Contributions are welcome! Here are some ways you can contribute:

- Report bugs
- Add support for more languages
- Improve error handling
- Add more output formats
- Optimize performance

## License

MIT License

## Acknowledgments

- [tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- [stack-graphs](https://github.com/github/stack-graphs)