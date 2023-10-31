#!/bin/bash

labels=$(circleci env subst "${MANIFEST_LABELS}")
generator=$(circleci env subst "${MANIFEST_GENERATOR}")
name=$(circleci env subst "${MANIFEST_SOURCE_NAME}")
version=$(circleci env subst "${MANIFEST_SOURCE_VERSION}")
format=$(circleci env subst "${MANIFEST_FORMAT}")
sources=$(circleci env subst "${MANIFEST_SOURCE}")
ptargs=$(circleci env subst "${MANIFEST_ARGS}")

sources=${sources//,/}

manifest sbom --label="${labels}" --generator="${generator}" --name="${name}" --version="${version}" --output="${format}" "${sources}" -- "${ptargs}"
