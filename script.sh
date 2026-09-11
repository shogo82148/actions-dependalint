#!/bin/bash
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

mkdir -p "${INPUT_OUTPUT_DIR}"
OUTPUT_FILE_NAME="reviewdog-${INPUT_TOOL_NAME}"
if [[ "${INPUT_REPORTER}" == "sarif" ]]; then
  OUTPUT_FILE_NAME="${OUTPUT_FILE_NAME}.sarif"
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo '::group::🐶 Installing dependalint ... https://github.com/shogo82148/dependalint'
TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"
wget -O - -q https://raw.githubusercontent.com/shogo82148/dependalint/cf6fc978e1d0ef66d4389c4fd9623c13cc9ee619/install.sh | sh -s -- -b "${TEMP_PATH}"
dependalint -version
echo '::endgroup::'

echo '::group:: Running dependalint with reviewdog 🐶 ...'
# shellcheck disable=SC2086
dependalint ${INPUT_DEPENDALINT_FLAGS} |
  reviewdog -efm="%f:%l:%c: %m" \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-level="${INPUT_FAIL_LEVEL}" \
    -level="${INPUT_LEVEL}" \
    ${INPUT_REVIEWDOG_FLAGS} |
  tee "${INPUT_OUTPUT_DIR}/${OUTPUT_FILE_NAME}"

exit_code=${PIPESTATUS[1]}
echo '::endgroup::'
exit "$exit_code"
