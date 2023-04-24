#!/bin/bash
echo "Hello $(circleci env subst "${PARAM_TO}")"