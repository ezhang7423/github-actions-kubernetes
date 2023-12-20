#!/bin/sh

repo_name=$(basename `git rev-parse --show-toplevel`)
find . -type f -exec sed -i "s/doper/$repo_name/g" {} +
echo "Done!"
