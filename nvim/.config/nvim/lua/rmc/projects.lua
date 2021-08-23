require("project_nvim").setup({
	detection_methods = { "!.git/worktrees", "!=extras", "!^fixtures", "!build/env.sh" , "pubspec.yaml", "package.json"},
})
