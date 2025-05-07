use std::fs;
use std::path::Path;
use anyhow::Result;
use log::info;
use stack_graphs::graph::StackGraph;

/// Output the stack graph as JSON
pub fn output_json(stack_graph: &StackGraph, output_path: Option<&Path>) -> Result<()> {
    // Create a simplified JSON representation of the stack graph
    // Since we can't directly access private fields, we'll just provide a summary
    let output = serde_json::json!({
        "summary": {
            "files": stack_graph.iter_files().count(),
            "description": "Tree-sitter Stack Graph representation of indexed code"
        },
        "files": stack_graph.iter_files().map(|file_handle| {
            serde_json::json!({
                "name": stack_graph[file_handle].to_string(),
            })
        }).collect::<Vec<_>>(),
    });
    
    let json_str = serde_json::to_string_pretty(&output)?;
    
    match output_path {
        Some(path) => {
            fs::write(path, json_str)?;
            info!("Stack graph written to: {}", path.display());
        }
        None => {
            println!("{}", json_str);
        }
    }
    
    Ok(())
}

/// Output the stack graph as DOT format for visualization
pub fn output_dot(stack_graph: &StackGraph, output_path: Option<&Path>) -> Result<()> {
    // Create a simplified DOT graph representation
    let mut dot_graph = String::new();
    dot_graph.push_str("digraph StackGraph {\n");
    
    // Add file nodes
    for file_handle in stack_graph.iter_files() {
        let file_name = stack_graph[file_handle].to_string();
        
        // Create a node for each file
        dot_graph.push_str(&format!("  file_{} [label=\"{}\"];\n", 
            file_handle.as_u32(), file_name));
    }
    
    dot_graph.push_str("}\n");
    
    match output_path {
        Some(path) => {
            fs::write(path, dot_graph)?;
            info!("Stack graph written to: {}", path.display());
        }
        None => {
            println!("{}", dot_graph);
        }
    }
    
    Ok(())
}