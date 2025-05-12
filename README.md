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



sed -i -E 's/^[[:space:]]*"[[:space:]]*replicationFactor[[:space:]]*" *:([[:space:]]*)[0-9]+/\"replicationFactor\":\1 4/' "$file"


system("sed -i -E 's/^[[:space:]]*\"[[:space:]]*replicationFactor[[:space:]]*\" *:([[:space:]]*)[0-9]+/\\\"replicationFactor\\\":\\1 4/' \"" FILENAME "\"")
