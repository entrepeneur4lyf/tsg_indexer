// -*- coding: utf-8 -*-
// ------------------------------------------------------------------------------------------------
// Copyright © 2022, stack-graphs authors.
// Licensed under either of Apache License, Version 2.0, or MIT license, at your option.
// Please see the LICENSE-APACHE or LICENSE-MIT files in this distribution for license details.
// ------------------------------------------------------------------------------------------------

use anyhow::anyhow;
use clap::Parser;
use tree_sitter_stack_graphs::cli::database::default_user_database_path_for_crate;
use tree_sitter_stack_graphs::cli::provided_languages::Subcommands;
use tree_sitter_stack_graphs::NoCancellation;

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let mut lcs = Vec::new();
    for r in [
        tree_sitter_stack_graphs_typescript::try_language_configuration_typescript(&NoCancellation),
        tree_sitter_stack_graphs_typescript::try_language_configuration_tsx(&NoCancellation),
    ] {
        let lc = match r {
            Ok(lc) => lc,
            Err(err) => {
                eprintln!("{}", err.display_pretty());
                return Err(anyhow!("Language configuration error"));
            }
        };
        lcs.push(lc);
    }
    let default_db_path = default_user_database_path_for_crate(env!("CARGO_PKG_NAME"))?;
    cli.subcommand.run(default_db_path, lcs)
}

#[derive(Parser)]
#[clap(about, version)]
pub struct Cli {
    #[clap(subcommand)]
    subcommand: Subcommands,
}
