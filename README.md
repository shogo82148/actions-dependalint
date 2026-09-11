# action-composite-template

## Input

```yaml
inputs:
  github_token:
    description: "GITHUB_TOKEN"
    default: "${{ github.token }}"
  workdir:
    description: "Working directory relative to the root directory."
    default: "."
  ### Flags for reviewdog ###
  tool_name:
    description: "Tool name to use for reviewdog reporter."
    default: "dependalint"
  level:
    description: "Report level for reviewdog [info,warning,error]."
    default: "error"
  reporter:
    description: "Reporter of reviewdog command [github-check,github-pr-review,github-pr-check,sarif]."
    default: "github-check"
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is `added` except that sarif reporter uses `nofilter`.
    default: ""
  fail_level:
    description: |
      If set to `none`, always use exit code 0 for reviewdog. Otherwise, exit code 1 for reviewdog if it finds at least 1 issue with severity greater than or equal to the given level.
      Possible values: [none,any,info,warning,error]
      Default is `none`.
    default: "none"
  reviewdog_flags:
    description: "Additional reviewdog flags."
    default: ""
  output_dir:
    description: "Output directory of reviewdog result. Useful for -reporter=sarif"
    default: "../reviewdog-results"
  ### Flags for dependalint ###
  dependalint_flags:
    description: "Additional flags for dependalint."
    default: ""
```

## Usage

```yaml

```
