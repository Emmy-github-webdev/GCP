##Shell script for migrating all repo’s reading from file### 

#!/bin/bash

name_of_github_org=”orgname”
# TEAM=”Teamname” ##Remove if no team needs to be assigned for repo’s

while IFS=”” read -r p || [ -n “$p” ]
do
git clone — mirror $p
repo=echo $p |cut -d’/’ -f6

echo “Local repo created: $repo”

cd ${repo}

gh_repo=echo $repo|cut -d’.’ -f1

gh repo create ${name_of_github_org}/${gh_repo} — private — team $TEAM

##comment above and use below if no team needs to be assigned for GitHub repo
##gh repo create barcotestemu/${gh_repo} — private
git remote set-url origin https://user@apikey@github.com/${name_of_github_org}/${gh_repo}

git remote add bitbucket $p
git push origin — mirror
done < bitbucket_repos.txt
