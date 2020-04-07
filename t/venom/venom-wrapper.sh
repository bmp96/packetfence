#!/bin/bash
set -o nounset -o pipefail

# Wrapper to run venom tests
die() {
    echo "$(basename $0): $@" >&2 ; exit 1
}

log_section() {
   printf '=%.0s' {1..72} ; printf "\n"
   printf "=\t%s\n" "" "$@" ""
}

log_subsection() {
   printf "=\t%s\n" "" "$@" ""
}

# script usage definition
usage() { 
    echo "Usage: $(basename $0) <path_to_test_suite1> [<path_to_test_suite2>]"
    echo "If you want to run all test suites in subdirectories, use <path_to_test_suite_dir/*>"
} 


configure_and_check() {
    # to distinguish if test is running in CI or not
    # in CI, value is set to "yes"
    INTEGRATION_TESTS=${INTEGRATION_TESTS:-no}
    # paths
    VENOM_RESULT_DIR="${VENOM_RESULT_DIR:-${PWD}/results}"
    VENOM_VARS_DIR=${VARS:-${PWD}/vars}
    VENOM_VARS_FILE=${VENOM_VARS_FILE:-${VENOM_VARS_DIR}/all.yml}

    mkdir -vp ${VENOM_RESULT_DIR} || die "mkdir failed: ${VENOM_RESULT_DIR}"
    declare -p VENOM_RESULT_DIR VENOM_VARS_FILE
    VENOM_BINARY="${VENOM_BINARY:-`which venom`}"
    VENOM_FORMAT=${VENOM_FORMAT:-tap}
    VENOM_COMMON_FLAGS="${VENOM_COMMON_FLAGS:---format ${VENOM_FORMAT} --output-dir ${VENOM_RESULT_DIR} --var-from-file ${VENOM_VARS_FILE}}"
    VENOM_EXIT_FLAGS="${VENOM_EXIT_FLAGS:---strict --stop-on-failure}"

    echo -e "Using venom using following variables:"
    echo -e "  VENOM_BINARY=${VENOM_BINARY}"
    echo -e "  VENOM_FLAGS=${VENOM_COMMON_FLAGS} ${VENOM_EXIT_FLAGS}"
    echo ""
}

display_dumps_on_error() {
    # only display dump if we run in a CI
    if [ "$INTEGRATION_TESTS" = "yes" ]; then
        for dump_file in $(find ${VENOM_RESULT_DIR} -name "*.dump"); do
            cat $dump_file
        done
    fi
    die "Error in Venom tests"
}

run_test_suites() {
    local test_suites=$(readlink -e ${@:-.})
    log_section "Running all test suites"
    CMD="${VENOM_BINARY} run ${VENOM_COMMON_FLAGS} ${VENOM_EXIT_FLAGS} ${test_suites}"
    ${CMD} || display_dumps_on_error
}

# Arguments are mandatory
[[ $# -lt 1 ]] && usage && exit 1
configure_and_check

# to get token written by setup test suite
export VENOM_RESULT_DIR
if [ -f "${VENOM_RESULT_DIR}/env" ]; then
    source $VENOM_RESULT_DIR/env
fi
run_test_suites $@

