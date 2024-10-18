use std::error::Error;
use std::fs::{self, DirEntry};
use std::io::Write;
use std::path::Path;
use std::process::{Command, Stdio};

// Function to read tmux config files and extract relevant keybindings
fn process_file(path: &Path) -> Result<Vec<String>, Box<dyn Error>> {
    let content = fs::read_to_string(path)?;

    // Filter keybinding-related lines
    let keybindings: Vec<String> = content
        .lines()
        .filter(|line| {
            line.starts_with("bind") || (line.starts_with("set -g") && line.contains('^'))
        })
        .map(|line| line.to_string())
        .collect();

    Ok(keybindings)
}

// Function to recursively collect all tmux config files
fn visit_dirs(dir: &Path, file_list: &mut Vec<DirEntry>) -> std::io::Result<()> {
    if dir.is_dir() {
        for entry in fs::read_dir(dir)? {
            let entry = entry?;
            let path = entry.path();
            if path.is_dir() {
                visit_dirs(&path, file_list)?;
            } else {
                file_list.push(entry);
            }
        }
    }
    Ok(())
}

fn main() -> Result<(), Box<dyn Error>> {
    // Path to the tmux configuration directory
    let config_dir = std::env::var("HOME").unwrap() + "/.config/tmux/";

    // Collect all tmux config files in the directory
    let mut file_list = Vec::new();
    visit_dirs(Path::new(&config_dir), &mut file_list)?;

    // Collect all keybindings from the config files
    let mut all_keybindings = Vec::new();
    for entry in file_list {
        if let Ok(keybindings) = process_file(&entry.path()) {
            all_keybindings.extend(keybindings);
        }
    }

    // Join keybindings into a single string for rofi input
    let rofi_input = all_keybindings.join("\n");

    // Spawn rofi to display the keybindings
    let mut rofi_command = Command::new("rofi")
        .arg("-dmenu")
        .arg("-p")
        .arg("Tmux Keybindings")
        .stdin(Stdio::piped())
        .spawn()
        .expect("Failed to start rofi");

    if let Some(stdin) = rofi_command.stdin.as_mut() {
        stdin.write_all(rofi_input.as_bytes())?;
    }

    rofi_command.wait()?;
    Ok(())
}

