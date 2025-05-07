use std::fs;
use std::path::{Path, PathBuf};
use anyhow::{Context, Result};
use log::{debug, info};

use crate::languages::Language;

/// TSG Generator - Creates tree-sitter-stack-graphs files dynamically for unsupported languages
pub struct TsgGenerator {
    /// Root directory for TSG file generation
    pub tsg_root: PathBuf,
    /// Whether to overwrite existing TSG files
    pub force_overwrite: bool,
}

impl TsgGenerator {
    /// Create a new TSG generator
    pub fn new<P: AsRef<Path>>(tsg_root: P, force_overwrite: bool) -> Self {
        Self {
            tsg_root: tsg_root.as_ref().to_path_buf(),
            force_overwrite,
        }
    }

    /// Generate TSG files for a given language
    pub fn generate(&self, language: &Language) -> Result<()> {
        let lang_name = language.name().to_lowercase();
        debug!("Generating TSG files for {}", language.name());

        // Create directory structure
        let lang_dir = self.tsg_root.join(format!("tree-sitter-stack-graphs-{}", lang_name));
        let src_dir = lang_dir.join("src");
        
        if lang_dir.exists() && !self.force_overwrite {
            info!("TSG directory already exists for {}, skipping generation", language.name());
            return Ok(());
        }

        fs::create_dir_all(&src_dir).with_context(|| {
            format!("Failed to create directory: {}", src_dir.display())
        })?;

        // Generate the files based on language
        self.generate_tsg_file(language, &src_dir.join("stack-graphs.tsg"))?;
        self.generate_builtins_cfg(language, &src_dir.join("builtins.cfg"))?;
        self.generate_builtins_source(language, &src_dir)?;

        info!("Successfully generated TSG files for {}", language.name());
        Ok(())
    }

    /// Generate the stack-graphs.tsg file
    fn generate_tsg_file(&self, language: &Language, path: &Path) -> Result<()> {
        debug!("Generating stack-graphs.tsg for {}", language.name());
        
        // Get the language-specific node types using tree-sitter grammar
        let mut node_types = Vec::new();
        
        if language.get_parser().is_some() {
            // Try to get node types from the language definition
            // This is a simplification - in practice you'd need more inspection
            node_types = self.get_node_types_for_language(language);
        }
        
        // Generate a basic tsg file with generic patterns
        let tsg_content = self.generate_generic_tsg_content(language, &node_types);
        
        fs::write(path, tsg_content).with_context(|| {
            format!("Failed to write TSG file: {}", path.display())
        })?;
        
        debug!("Successfully created stack-graphs.tsg for {}", language.name());
        Ok(())
    }

    /// Generate the builtins.cfg file with common library elements
    fn generate_builtins_cfg(&self, language: &Language, path: &Path) -> Result<()> {
        debug!("Generating builtins.cfg for {}", language.name());
        
        // Basic template for builtins.cfg
        let cfg_content = format!("# {} standard library types and modules\n\
                                  # This file lists the {} standard library that should be treated as builtins.\n\n\
                                  # This is an auto-generated file. Edit it to add more specific library elements.\n",
                                  language.name(), language.name());
        
        fs::write(path, cfg_content).with_context(|| {
            format!("Failed to write builtins.cfg file: {}", path.display())
        })?;
        
        debug!("Successfully created builtins.cfg for {}", language.name());
        Ok(())
    }

    /// Generate language-specific builtin source file
    fn generate_builtins_source(&self, language: &Language, src_dir: &Path) -> Result<()> {
        debug!("Generating builtins source file for {}", language.name());
        
        // Get the file extension for this language
        let file_ext = language.get_extension();
        
        let source_path = src_dir.join(format!("builtins.{}", file_ext));
        
        // Basic template for builtins source file
        let source_content = format!("// This file contains minimal definitions of {} standard library types\n\
                                     // for use with tree-sitter-stack-graphs.\n\n\
                                     // This is an auto-generated file. Edit it to add more specific library elements.\n",
                                     language.name());
        
        // Create a reference to source_path for the error message
        let path_display = source_path.display().to_string();
        fs::write(&source_path, source_content).with_context(|| {
            format!("Failed to write builtins source file: {}", path_display)
        })?;
        
        debug!("Successfully created builtins source file for {}", language.name());
        Ok(())
    }

    /// Get node types for a language (simplified implementation)
    fn get_node_types_for_language(&self, language: &Language) -> Vec<String> {
        // This is a simplified implementation
        // In practice, you would use tree-sitter's node type inquiry mechanisms
        match language {
            Language::Rust => vec![
                "function_item".to_string(), 
                "struct_item".to_string(),
                "impl_item".to_string(),
                "trait_item".to_string(),
                "mod_item".to_string(),
                "enum_item".to_string(),
            ],
            Language::Python => vec![
                "function_definition".to_string(),
                "class_definition".to_string(),
                "import_statement".to_string(),
            ],
            Language::JavaScript => vec![
                "function_declaration".to_string(),
                "class_declaration".to_string(),
                "method_definition".to_string(),
                "lexical_declaration".to_string(),
            ],
            Language::Go => vec![
                "function_declaration".to_string(),
                "method_declaration".to_string(),
                "type_declaration".to_string(),
            ],
            Language::Ruby => vec![
                "method".to_string(),
                "class".to_string(),
                "module".to_string(),
            ],
            Language::PHP => vec![
                "function_definition".to_string(),
                "class_declaration".to_string(),
                "method_declaration".to_string(),
            ],
            Language::CSharp => vec![
                "method_declaration".to_string(),
                "class_declaration".to_string(),
                "interface_declaration".to_string(),
                "namespace_declaration".to_string(),
            ],
            _ => Vec::new(),
        }
    }

    /// Generate generic TSG content based on language node types
    fn generate_generic_tsg_content(&self, language: &Language, _node_types: &[String]) -> String {
        // Generate a basic tsg template with common patterns
        let mut content = format!("// Tree-sitter Stack Graphs definition for {}\n\
                                 // This file defines how {} constructs are mapped to stack graph nodes and edges.\n\n",
                                 language.name(), language.name());

        // Add generic patterns based on common programming language constructs
        content.push_str("// Function declarations (generic pattern)\n");
        content.push_str("(function 
  name: (_) @name) @function {
  node @function.call
  node return_value
  node drop_scope
  
  attr (@name.def) node_definition = @name
  attr (@name.def) definiens_node = @function
  attr (@name.def) syntax_type = \"function\"
  
  edge @function.after_scope -> @name.def
  edge @name.def -> @function.call
  edge @function.call -> return_value
  edge drop_scope -> @function.bottom
  attr (drop_scope) type = \"drop_scopes\"
  attr (@function.call) pop_scoped_symbol = \"()\"
  edge @function.params.before_scope -> JUMP_TO_SCOPE_NODE
  attr (return_value) is_exported
}\n\n");

        content.push_str("// Class/type declarations (generic pattern)\n");
        content.push_str("(class
  name: (_) @name) @class {
  node @class.after_scope
  node drop_scope
  
  attr (@name.def) node_definition = @name
  attr (@name.def) definiens_node = @class
  attr (@name.def) syntax_type = \"class\"
  
  edge @class.after_scope -> @name.def
  edge drop_scope -> @class.bottom
  attr (drop_scope) type = \"drop_scopes\"
  attr (@name.def) is_exported
}\n\n");

        content.push_str("// Method declarations (generic pattern)\n");
        content.push_str("(method
  name: (_) @name) @method {
  node @method.call
  node return_value
  node drop_scope
  
  attr (@name.def) node_definition = @name
  attr (@name.def) definiens_node = @method
  attr (@name.def) syntax_type = \"method\"
  
  edge @method.after_scope -> @name.def
  edge @name.def -> @method.call
  edge @method.call -> return_value
  edge drop_scope -> @method.bottom
  attr (drop_scope) type = \"drop_scopes\"
  attr (@method.call) pop_scoped_symbol = \"()\"
  edge @method.params.before_scope -> JUMP_TO_SCOPE_NODE
  attr (return_value) is_exported
}\n\n");

        content.push_str("// Imports/includes (generic pattern)\n");
        content.push_str("(import
  path: (_) @path) @import {
  node import_node
  
  attr (import_node) node_definition = @path
  attr (import_node) syntax_type = \"import\"
  
  edge @import.after_scope -> import_node
}\n\n");

        content.push_str("// Variable declarations (generic pattern)\n");
        content.push_str("(variable
  name: (_) @name) @variable {
  attr (@name.def) node_definition = @name
  attr (@name.def) definiens_node = @variable
  attr (@name.def) syntax_type = \"variable\"
  
  edge @variable.after_scope -> @name.def
}\n\n");

        content.push_str("// Identifiers and references (generic pattern)\n");
        content.push_str("(identifier) @id {
  node @id.ref
  
  attr (@id.ref) node_reference = @id
}\n");

        content
    }
}

/// Register a custom language with the TSG generator
pub fn register_language(language: &Language) -> Result<()> {
    // Create the language directory in languages/
    let tsg_root = PathBuf::from("languages");
    let generator = TsgGenerator::new(tsg_root, false);
    
    generator.generate(language)?;
    
    // Update the language map to include the new language
    info!("Registered new language: {}", language.name());
    
    Ok(())
}

/// Check if a language has TSG support available
pub fn has_tsg_support(language: &Language) -> bool {
    let lang_name = language.name().to_lowercase();
    let tsg_dir = PathBuf::from("languages")
        .join(format!("tree-sitter-stack-graphs-{}", lang_name));
    
    tsg_dir.exists()
}