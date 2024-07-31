#!bin/sh

# Get env
info="${INPUT_INFO}"
type="${INPUT_TYPE}"
fallback="${INPUT_FALLBACK}"

# tag function
label_tag() {
    prev=$(git describe --tags $(git rev-list --tags --max-count=1))
    if [ -z "$prev" ]; then
        echo "$fallback"
    else
        echo "$prev"
    fi
}

# commit function
label_commit() {
    count=$(git rev-list --all --count)
    if [ "$type" == "semver" ]; then
        echo "1.0.${count}"
    else
        echo "$count"
    fi
}

# main
echo "info = ${info}, type = ${type}, fallback = ${fallback}"
if [ "$type" == "tag" ]; then
    label_tag
else
    label_commit
fi