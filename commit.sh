#!/bin/sh
 
set -e
 
repo_dir="$PWD/repo"
#change it to any other Repo
repo_submodule='https://github.com/JameelNabbo/SmartWorm'
 
git init "$repo_dir"
cd "$repo_dir"
git submodule add "$repo_submodule" pwned
mkdir modules
cp -r .git/modules/pwned modules
cp ../pwned.sh modules/pwned/hooks/post-checkout
git config -f .gitmodules submodule.pwned.update checkout
git config -f .gitmodules --rename-section submodule.pwned submodule.../../modules/pwned
git add modules
git submodule add "$repo_submodule"
git add SmartWorm
git commit -am pwned
echo "All done, now \`git clone --recurse-submodules \"$repo_dir\" dest_dir\`”
