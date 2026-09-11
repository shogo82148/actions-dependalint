# actions-dependalint

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
name: reviewdog
on:
  push:
    paths:
      - .github/dependabot.yml
      - .github/workflows/dependalint.yml
  pull_request:
    paths:
      - .github/dependabot.yml
      - .github/workflows/dependalint.yml

  dependalint:
    name: runner / dependalint
    runs-on: ubuntu-slim
    steps:
      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
      - uses: shogo82148/actions-dependalint@5a2eeef8cd5d8354b4e8446822649e9b37c177c1 # v0.1.0
        with:
          reporter: github-check
```
