#!/bin/bash

dir=$(circleci env subst "${MANIFEST_INSTALL_DIR}")
version=$(circleci env subst "${MANIFEST_CLI_VERSION}")
generator=$(circleci env subst "${MANIFEST_GENERATOR}")
generator_version=$(circleci env subst "${MANIFEST_GENERATOR_VERSION}")
generator_version=${generator_version:-"latest"}

# only accept syft versions equal or lower than v0.92.0
if [[ "${generator}" == "syft" ]]; then
    gversion=${generator_version#"v"}
    if [[ "${gversion}" > "0.92.0" ]]; then
        echo "syft versions equal or lower than v0.92.0 are supported"
        exit 1
    fi
fi

dir=${dir:-"/usr/local/bin"}
curl -sSL https://raw.githubusercontent.com/manifest-cyber/cli/main/install.sh | sudo sh -s -- -b "${dir}" "${version}"

if [[ -n "${generator}" ]]; then
    sudo manifest install -g "${generator}" -v "${generator_version}" || exit 1
fi
