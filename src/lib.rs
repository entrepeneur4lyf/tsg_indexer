pub mod languages;
pub mod indexer;
pub mod output;
pub mod tsg_generator;

use std::path::PathBuf;
use anyhow::{Context, Result};
use log::{error, info, warn};
use stack_graphs::graph::StackGraph;

/// Configuration for the TSG indexer
#[derive(Debug, Clone)]
pub struct IndexerConfig {
    /// Path to a file or directory to index
    pub path: PathBuf,
    
    /// Output format (json or dot)
    pub format: String,
    
    /// Output file path (if not provided, will print to stdout)
    pub output: Option<PathBuf>,
    
    /// Verbose mode
    pub verbose: bool,
    
    /// Whether to generate TSG files for unsupported languages
    pub generate_tsg: bool,
    
    /// Whether to overwrite existing TSG files
    pub force_overwrite: bool,
}

impl Default for IndexerConfig {
    fn default() -> Self {
        Self {
            path: PathBuf::new(),
            format: "json".to_string(),
            output: None,
            verbose: false,
            generate_tsg: false,
            force_overwrite: false,
        }
    }
}

/// Main entry point for the TSG indexer library
pub fn run_indexer(config: IndexerConfig) -> Result<()> {
    if config.verbose {
        info!("Starting TSG indexer");
        info!("Indexing path: {}", config.path.display());
    }
    
    // Check if path exists
    if !config.path.exists() {
        error!("Path does not exist: {}", config.path.display());
        anyhow::bail!("Path does not exist: {}", config.path.display());
    }
    
    // Initialize the TSG generator if enabled
    if config.generate_tsg {
        if config.verbose {
            info!("TSG file generation is enabled");
        }
        
        // Create the TSG generator
        let tsg_root = PathBuf::from("languages");
        let generator = tsg_generator::TsgGenerator::new(tsg_root, config.force_overwrite);
        
        // Scan the path to detect languages
        let detected_languages = if config.path.is_file() {
            let extension = config.path.extension()
                .and_then(|ext| ext.to_str())
                .unwrap_or("");
            
            let language = languages::Language::from_extension(extension);
            if language != languages::Language::Unknown {
                vec![language]
            } else {
                vec![]
            }
        } else {
            // Scan the directory for all file extensions and get unique languages
            let mut detected = std::collections::HashSet::new();
            for entry in walkdir::WalkDir::new(&config.path)
                .into_iter()
                .filter_map(Result::ok)
                .filter(|e| e.file_type().is_file()) {
                
                if let Some(extension) = entry.path().extension().and_then(|ext| ext.to_str()) {
                    let language = languages::Language::from_extension(extension);
                    if language != languages::Language::Unknown {
                        detected.insert(language);
                    }
                }
            }
            detected.into_iter().collect()
        };
        
        // Generate TSG files for detected languages
        for language in &detected_languages {
            if language.get_stack_graphs_language().is_none() {
                if config.verbose {
                    info!("Generating TSG files for detected language: {}", language.name());
                }
                
                match generator.generate(language) {
                    Ok(_) => {
                        if config.verbose {
                            info!("Successfully generated TSG files for {}", language.name());
                        }
                    },
                    Err(e) => {
                        warn!("Failed to generate TSG files for {}: {}", language.name(), e);
                    }
                }
            }
        }
    }
    
    // Create a new stack graph
    let mut stack_graph = StackGraph::new();
    
    // Index the path
    if config.path.is_file() {
        indexer::index_file(&mut stack_graph, &config.path)
            .with_context(|| format!("Failed to index file: {}", config.path.display()))?;
    } else if config.path.is_dir() {
        indexer::index_directory(&mut stack_graph, &config.path)
            .with_context(|| format!("Failed to index directory: {}", config.path.display()))?;
    }
    
    // Output the stack graph
    match config.format.as_str() {
        "json" => output::output_json(&stack_graph, config.output.as_deref())?,
        "dot" => output::output_dot(&stack_graph, config.output.as_deref())?,
        _ => {
            warn!("Unsupported output format: {}. Using JSON instead.", config.format);
            output::output_json(&stack_graph, config.output.as_deref())?
        }
    }
    
    if config.verbose {
        info!("Stack graph created successfully!");
        info!("Number of files: {}", stack_graph.iter_files().count());
    }
    
    Ok(())
}