# Let's check if there are any changes in the project folder
has_app_changes = git.modified_files.include? "Source/*"

# Then, we should check if tests are updated
has_test_changes = git.modified_files.include? "Tests/*"

# note when PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# note when there is a big PR
warn("Big PR, consider splitting into smaller") if git.lines_of_code > 500

# You've made changes to lib, but didn't write any tests?
if has_app_changes && !has_test_changes
  warn("There're app changes, but not tests. That's OK as long as you're refactoring existing code.", sticky: false)
end

# You've made changes to specs, but no library code has changed?
if !has_app_changes && has_test_changes
  message('We really appreciate pull requests that demonstrate issues, even without a fix. That said, the next step is to try and fix the failing tests!', sticky: false)
end

# Ensure that labels have been used on the PR
# fail "Please add labels to this PR" if github.pr_labels.empty?

# Ensure there is a summary for a PR
fail "Please provide a PR description" if github.pr_body.length < 5

# Note when PR's don't reference a milestone (is removed if it does)
# has_milestone = github.pr_json["milestone"] != nil
# fail "PR does not reference existing milestone" unless has_milestone

# Ensure PR has an assignee
fail "This PR does not have any assignees yet." unless github.pr_json["assignee"]

#
# PLUGIN SECTION
#

# Customize the "* Your contribution here." line. 
# Set the value to nil to stop checking for one.
changelog.placeholder_line = nil

# Have you updated CHANGELOG.md?
changelog.check!

# Lint all commits using defaults
commit_lint.check warn: :all

# This is swiftlint plugin. More info: https://github.com/ashfurrow/danger-swiftlint
#
# This lints all Swift files and leave comments in PR if 
# there is any issue with linting
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true
