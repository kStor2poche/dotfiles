use std::process::Command;

fn get_workspaces() -> &'static str {
    let get_ws_command: &'static str = Command::new("swaymsg").arg("-t").arg("get_workspaces")
        .output().expect("Could not retrieve workspaces").stdout;
}
fn main() {
    println!(get_workspaces());
}
