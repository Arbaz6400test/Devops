#!/bin/bash

# Define logs
MODLOG="modified_files.log"
SKIPLOG="skipped_files.log"

# Clear previous logs
> "$MODLOG"
> "$SKIPLOG"

# Loop through files in topics/
for file in topics/*; do
  [ -f "$file" ] || continue

  # Extract replicationFactor value
  replicationFactor=$(awk -F: '
  /replicationFactor/ {
    key=$1
    gsub(/[" ,]/, "", key)
    if (key == "replicationFactor") {
      gsub(/[[:space:]]|,|"/, "", $2)
      print $2
      exit
    }
  }' "$file")

  if ! [[ "$replicationFactor" =~ ^[0-9]+$ ]]; then
    echo "$file: replicationFactor not found or not numeric, skipping"
    echo "$file" >> "$SKIPLOG"
    continue
  fi

  if (( replicationFactor > 3 && replicationFactor != 4 )); then
    echo "$file: replicationFactor is $replicationFactor (greater than 3 and not 4), replacing with 4"

    # Replace line: handles leading space, spaces inside quotes, space before colon, and preserves after
    sed -i -E 's/^[[:space:]]*"[[:space:]]*replicationFactor[[:space:]]*" *:([[:space:]]*)'"$replicationFactor"'/\"replicationFactor\":\1 4/' "$file"

    echo "$file" >> "$MODLOG"
  elif (( replicationFactor == 4 )); then
    echo "$file: replicationFactor already 4, skipping"
    echo "$file" >> "$SKIPLOG"
  else
    echo "$file: replicationFactor is $replicationFactor, skipping"
    echo "$file" >> "$SKIPLOG"
  fi
done

# Summary
modified=$(wc -l < "$MODLOG")
skipped=$(wc -l < "$SKIPLOG")
total=$((modified + skipped))

echo ""
echo "Summary:"
echo "Modified files: $modified (logged in $MODLOG)"
echo "Skipped files: $skipped (logged in $SKIPLOG)"
echo "Total files: $total"
