#!/bin/bash

dir=$(circleci env subst "${INSTALL_DIR}")
version=$(circleci env subst "${CLI_VERSION}")

dir=${dir:-"/usr/local/bin"}
curl -sSL https://raw.githubusercontent.com/manifest-cyber/cli/main/install.sh | sudo sh -s -- -b "${dir}" "${version}"
