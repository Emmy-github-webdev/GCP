# Automating manual steps via shell script:

We can directly use below shell script and it will migrate all our bitbucket repo’s to GitHub.

<br>

This shell script reads the repo to be migrated from text file bitbucket_repos.txt, so we need to make a text file named as bitbucket_repos.txt with all repo’s(clone url’s) that we need to migrate.

## Prerequisite for executing shell script:

1. Setup git auto login(no user password entry again and again) for 1 hour(bitbucket)

> git config — global credential.helper cache
> git config — global credential.helper ‘cache — timeout=3600’

2. copy paste the above shell script in file bitbucket_to_github_migration.sh

3. Edit shell script i.e. replace user and apikey in below line with your actual

<br>

_user and apikey for GitHub login :_ to _https://user@apikey@github.com/${name_of_github_org}/${gh_repo}_

4. Make your input file bitbucket_repos.txt which contains all bitbucket clone url’s of repo’s that needs to be migrated. Once repo url in each line.

5. Keep the input file and shell script in same directory.

6. Run Shell script:

> bash bitbucket_to_github_migration.sh