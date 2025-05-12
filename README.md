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

python3 -c "import re; f='yourfile.json'; d=open(f).read(); open(f, 'w').write(re.sub(r'\"\\s*(.*?)\\s*\"\\s*:', r'\"\\1\":', d))"
