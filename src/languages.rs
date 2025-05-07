use tree_sitter as ts;

/// Supported programming languages
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Language {
    Rust,
    Python,
    JavaScript,
    TypeScript,
    Java,
    Swift,
    ObjectiveC,
    CSS,
    Scala,
    Zig,
    YAML,
    Go,
    PHP,
    XML,
    JSDoc,
    Bash,
    JSON,
    HTML,
    Regex,
    CSharp,
    Ruby,
    Markdown,
    Lua,
    Dart,
    Unknown,
}

impl Language {
    /// Determine language from file extension
    pub fn from_extension(ext: &str) -> Self {
        match ext.to_lowercase().as_str() {
            "rs" => Self::Rust,
            "py" => Self::Python,
            "js" => Self::JavaScript,
            "jsx" => Self::JavaScript,
            "ts" => Self::TypeScript,
            "tsx" => Self::TypeScript,
            "java" => Self::Java,
            "swift" => Self::Swift,
            "m" | "mm" => Self::ObjectiveC,
            "css" => Self::CSS,
            "scala" => Self::Scala,
            "zig" => Self::Zig,
            "yaml" | "yml" => Self::YAML,
            "go" => Self::Go,
            "php" => Self::PHP,
            "xml" => Self::XML,
            "sh" | "bash" => Self::Bash,
            "json" => Self::JSON,
            "html" | "htm" => Self::HTML,
            "cs" => Self::CSharp,
            "rb" => Self::Ruby,
            "md" | "markdown" => Self::Markdown,
            "lua" => Self::Lua,
            "dart" => Self::Dart,
            _ => Self::Unknown,
        }
    }

    /// Get the appropriate tree-sitter parser for this language
    pub fn get_parser(&self) -> Option<ts::Parser> {
        let mut parser = ts::Parser::new();

        match self {
            Self::Rust => {
                parser.set_language(&tree_sitter_rust::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Python => {
                parser.set_language(&tree_sitter_python::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::JavaScript => {
                parser.set_language(&tree_sitter_javascript::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::TypeScript => {
                parser.set_language(&tree_sitter_typescript::LANGUAGE_TSX.into()).ok()?;
                Some(parser)
            }
            Self::Java => {
                parser.set_language(&tree_sitter_java::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Go => {
                parser.set_language(&tree_sitter_go::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::PHP => {
                parser.set_language(&tree_sitter_php::LANGUAGE_PHP.into()).ok()?;
                Some(parser)
            }
            Self::XML => {
                parser.set_language(&tree_sitter_xml::LANGUAGE_XML.into()).ok()?;
                Some(parser)
            }
            Self::Swift => {
                parser.set_language(&tree_sitter_swift::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::ObjectiveC => {
                parser.set_language(&tree_sitter_objc::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::CSS => {
                parser.set_language(&tree_sitter_css::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Scala => {
                parser.set_language(&tree_sitter_scala::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Zig => {
                parser.set_language(&tree_sitter_zig::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::YAML => {
                parser.set_language(&tree_sitter_yaml::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::JSDoc => {
                parser.set_language(&tree_sitter_jsdoc::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Bash => {
                parser.set_language(&tree_sitter_bash::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::JSON => {
                parser.set_language(&tree_sitter_json::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::HTML => {
                parser.set_language(&tree_sitter_html::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Regex => {
                parser.set_language(&tree_sitter_regex::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::CSharp => {
                parser.set_language(&tree_sitter_c_sharp::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Ruby => {
                parser.set_language(&tree_sitter_ruby::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Markdown => {
                parser.set_language(&tree_sitter_md::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Lua => {
                parser.set_language(&tree_sitter_lua::LANGUAGE.into()).ok()?;
                Some(parser)
            }
            Self::Dart => {
                parser.set_language(&tree_sitter_dart::language()).ok()?;
                Some(parser)
            }
            Self::Unknown => None,
        }
    }

    /// Get the stack-graphs language definition if available in the stack-graphs/languages directory
    pub fn get_stack_graphs_language(&self) -> Option<&'static str> {
        match self {
            Self::JavaScript => Some("javascript"),
            Self::TypeScript => Some("typescript"),
            Self::Python => Some("python"),
            Self::Java => Some("java"),
            Self::Rust => Some("rust"),
            Self::Go => Some("go"),
            Self::Ruby => Some("ruby"),
            Self::PHP => Some("php"),
            Self::CSharp => Some("csharp"),
            Self::Swift => Some("swift"),
            Self::ObjectiveC => Some("objc"),
            Self::CSS => Some("css"),
            Self::Scala => Some("scala"),
            Self::Zig => Some("zig"),
            Self::YAML => Some("yaml"),
            Self::XML => Some("xml"),
            Self::Bash => Some("bash"),
            Self::JSON => Some("json"),
            Self::HTML => Some("html"),
            Self::Markdown => Some("markdown"),
            Self::Lua => Some("lua"),
            Self::Dart => Some("dart"),
            _ => None,
        }
    }

    /// Get the name of the language
    pub fn name(&self) -> &'static str {
        match self {
            Self::Rust => "Rust",
            Self::Python => "Python",
            Self::JavaScript => "JavaScript",
            Self::TypeScript => "TypeScript",
            Self::Java => "Java",
            Self::Swift => "Swift",
            Self::ObjectiveC => "Objective-C",
            Self::CSS => "CSS",
            Self::Scala => "Scala",
            Self::Zig => "Zig",
            Self::YAML => "YAML",
            Self::Go => "Go",
            Self::PHP => "PHP",
            Self::XML => "XML",
            Self::JSDoc => "JSDoc",
            Self::Bash => "Bash",
            Self::JSON => "JSON",
            Self::HTML => "HTML",
            Self::Regex => "Regex",
            Self::CSharp => "C#",
            Self::Ruby => "Ruby",
            Self::Markdown => "Markdown",
            Self::Lua => "Lua",
            Self::Dart => "Dart",
            Self::Unknown => "Unknown",
        }
    }
    
    /// Get the primary file extension for this language
    pub fn get_extension(&self) -> &'static str {
        match self {
            Self::Rust => "rs",
            Self::Python => "py",
            Self::JavaScript => "js",
            Self::TypeScript => "ts",
            Self::Java => "java",
            Self::Swift => "swift",
            Self::ObjectiveC => "m",
            Self::CSS => "css",
            Self::Scala => "scala",
            Self::Zig => "zig",
            Self::YAML => "yaml",
            Self::Go => "go",
            Self::PHP => "php",
            Self::XML => "xml",
            Self::JSDoc => "js", // JSDoc is typically inside JavaScript files
            Self::Bash => "sh",
            Self::JSON => "json",
            Self::HTML => "html",
            Self::Regex => "regex",
            Self::CSharp => "cs",
            Self::Ruby => "rb",
            Self::Markdown => "md",
            Self::Lua => "lua",
            Self::Dart => "dart",
            Self::Unknown => "txt",
        }
    }
    
    /// Get all file extensions associated with this language
    pub fn get_all_extensions(&self) -> Vec<&'static str> {
        match self {
            Self::Rust => vec!["rs"],
            Self::Python => vec!["py", "pyw"],
            Self::JavaScript => vec!["js", "jsx", "mjs"],
            Self::TypeScript => vec!["ts", "tsx"],
            Self::Java => vec!["java"],
            Self::Swift => vec!["swift"],
            Self::ObjectiveC => vec!["m", "mm"],
            Self::CSS => vec!["css"],
            Self::Scala => vec!["scala", "sc"],
            Self::Zig => vec!["zig"],
            Self::YAML => vec!["yaml", "yml"],
            Self::Go => vec!["go"],
            Self::PHP => vec!["php", "phtml", "php3", "php4", "php5", "php7", "phps"],
            Self::XML => vec!["xml"],
            Self::JSDoc => vec!["js"], // JSDoc is typically inside JavaScript files
            Self::Bash => vec!["sh", "bash"],
            Self::JSON => vec!["json"],
            Self::HTML => vec!["html", "htm"],
            Self::Regex => vec!["regex"],
            Self::CSharp => vec!["cs"],
            Self::Ruby => vec!["rb", "rbw"],
            Self::Markdown => vec!["md", "markdown"],
            Self::Lua => vec!["lua"],
            Self::Dart => vec!["dart"],
            Self::Unknown => vec!["txt"],
        }
    }
}