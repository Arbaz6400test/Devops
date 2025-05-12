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

import re

def clean_json_line(line):
    # Remove spaces inside quotes (e.g., " abc " → "abc")
    line = re.sub(r'"\s*([^"]*?)\s*"', r'"\1"', line)
    
    # Remove spaces before colons (e.g., "key" : → "key":)
    line = re.sub(r'"\s*:\s*', r'":', line)
    
    return line

# Example usage
input_line = '    " replicationFactor " : 3'
output_line = clean_json_line(input_line)
print(output_line)  # Output: '    "replicationFactor":3'
