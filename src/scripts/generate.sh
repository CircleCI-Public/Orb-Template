#!/bin/bash

labels=$(circleci env subst "${MANIFEST_LABELS}")
generator=$(circleci env subst "${MANIFEST_GENERATOR}")
name=$(circleci env subst "${MANIFEST_SOURCE_NAME}")
version=$(circleci env subst "${MANIFEST_SOURCE_VERSION}")
format=$(circleci env subst "${MANIFEST_FORMAT}")
sources=$(circleci env subst "${MANIFEST_SOURCE}")
ptargs=$(circleci env subst "${MANIFEST_ARGS}")
publish=$(circleci env subst "${MANIFEST_PUBLISH}")

sources=${sources//,/}

tptargs=$(echo "${ptargs}" | awk '{$1=$1};1')

if [[ -z "${tptargs}" ]]; then
    manifest sbom --label="${labels}" --generator="${generator}" --name="${name}" --version="${version}" --output="${format}" --publish="${publish}" "${sources}"
else
    manifest sbom --label="${labels}" --generator="${generator}" --name="${name}" --version="${version}" --output="${format}" --publish="${publish}" "${sources}" -- "${ptargs}"
fi
