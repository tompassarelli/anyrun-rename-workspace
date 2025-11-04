use abi_stable::std_types::{ROption, RString, RVec};
use anyrun_plugin::*;

#[init]
fn init(_config_dir: RString) {}

#[info]
fn info() -> PluginInfo {
    PluginInfo {
        name: "Rename workspace:".into(),
        icon: "insert-text".into(),
    }
}

#[get_matches]
fn get_matches(input: RString) -> RVec<Match> {
    if input.is_empty() {
        vec![].into()
    } else {
        vec![Match {
            title: input.clone(),
            icon: ROption::RNone,
            use_pango: false,
            description: ROption::RNone,
            id: ROption::RNone,
        }]
        .into()
    }
}

#[handler]
fn handler(selection: Match) -> HandleResult {
    HandleResult::Stdout(selection.title.into_bytes())
}
