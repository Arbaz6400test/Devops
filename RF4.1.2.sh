
read -p "Enter the branch name you want to work on:" branch
git pull origin $branch
git checkout "$branch"

sleep 3

# Step 1: Clean all JSON files in the topics/ folder using Python
for file in topics/*.json; do
  python3 -c "

import re
f = '$file'
d = open(f).read()
open(f, 'w').write(re.sub(r'\"\\s*(.*?)\\s*\"\\s*:', r'\"\\1\":', d))
"
echo "$file:formatting done"
echo "=========================================================================="


done

awk '
BEGIN {
    modified = 0
    skipped = 0
    count = 0
    max_files = 5
    modlog = "modified_files.log"
    skiplog = "skipped_files.log"

    system("echo -n > " modlog)
    system("echo -n > " skiplog)
}

/"replicationFactor"/ {
    if (seen[FILENAME]) next
    seen[FILENAME] = 1

    if (count >= max_files) next

    split($0, a, ":")
    gsub(/[ ,]/, "", a[2])

    if (a[2] >= 3 && a[2] != 4) {
        print FILENAME ": replicationFactor is greater than or equal to 3, replacing with 4"
        system("sed -i \"s/\\\"[[:space:]]*replicationFactor[[:space:]]*\\\"[[:space:]]*:[[:space:]]*[0-9]/\\\"replicationFactor\\\": 4/\" " FILENAME)
        system("echo " FILENAME " >> " modlog)
        modified++
        count++
    } else if (a[2] == 4) {
        print FILENAME ": replicationFactor already 4, skipping"
        system("echo " FILENAME " >> " skiplog)
        skipped++
        
    }
}

END {
    print "\nSummary:"
    print "modified files: " modified " (logged in modified_files.log)"
    print "skipped files: " skipped " (logged in skipped_files.log)"
    print "Total files    : " modified + skipped
}
' topics/*

                                                                                                                                  
                                                                                                                                     
git add .                                                                                                                            
git commit -m "Changes committed to $branch"                                                                                         
print "\nCommit done:"                                                                                                               
git push origin $branch                                                                                                              
echo "==============================================                                                                                 
Changes pushed to $brnch                                                                                                             
==================================================="                                                                                 
                                                                                                                   74,10         Bot 
