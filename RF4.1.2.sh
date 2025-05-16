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
        count++
    }
}

END {
    print "\nSummary:"
    print "modified files: " modified " (logged in modified_files.log)"
    print "skipped files: " skipped " (logged in skipped_files.log)"
    print "Total files    : " modified + skipped
}
' topics/*
