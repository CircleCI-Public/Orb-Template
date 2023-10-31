#!/bin/bash

dir=$(circleci env subst "${MANIFEST_INSTALL_DIR}")
version=$(circleci env subst "${MANIFEST_CLI_VERSION}")
generator=$(circleci env subst "${MANIFEST_GENERATOR}")
generator_version=$(circleci env subst "${MANIFEST_GENERATOR_VERSION}")
generator_version=${generator_version:-"latest"}

# only accept syft versions equal or lower than 0.92.0
if [[ "${generator}" == "syft" ]]; then
    if [[ "${generator_version}" > "0.92.0" ]]; then
        echo "Syft version ${generator_version} is not supported. Please use version 0.92.0 or lower."
        exit 1
    fi
fi

dir=${dir:-"/usr/local/bin"}
curl -sSL https://raw.githubusercontent.com/manifest-cyber/cli/main/install.sh | sudo sh -s -- -b "${dir}" "${version}"

if [[ -n "${generator}" ]]; then
    sudo manifest install -g "${generator}" -v "${generator_version}" || exit 1
fi
