# Devops

git remote set-url origin git@github.com:Arbaz6400test/Devops.git       #set fork repo


git remote add upstream git@github.com:Arbaz6400/Devops.git             #set add upstream 


 
git remote -v
origin	git@github.com:Arbaz6400test/Devops.git (fetch)
origin	git@github.com:Arbaz6400test/Devops.git (push)
upstream	git@github.com:Arbaz6400/Devops.git (fetch)
upstream	git@github.com:Arbaz6400/Devops.git (push)

Fork url should appear as origin and target URL as upstream  


For the script, ensure you are on UAT, then start the replications 

#!/bin/bash

# Step 1: Clean all JSON files in the topics/ folder using Python
for file in topics/*.json; do
  python3 -c "
import re
f = '$file'
d = open(f).read()
open(f, 'w').write(re.sub(r'\"\\s*(.*?)\\s*\"\\s*:', r'\"\\1\":', d))
"
done

# Step 2: Now process each file with awk (you can customize the awk logic)
for file in topics/*.json; do
  awk '{ print $0 }' "$file"
done
