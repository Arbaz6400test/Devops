#!/bin/bash

# Define logs
MODLOG="modified_files.log"
SKIPLOG="skipped_files.log"

# Clear previous logs
> "$MODLOG"
> "$SKIPLOG"

# Loop through files in topics/
for file in topics/*; do
  # Skip non-regular files
  [ -f "$file" ] || continue

  # Extract replicationFactor value if it exists
  replicationFactor=$(awk -F: '/"replicationFactor"/ { gsub(/[[:space:]]|,|"/, "", $2); print $2; exit }' "$file")

  if [[ "$replicationFactor" == "3" ]]; then
    echo "$file: replicationFactor is 3, replacing with 4"
    sed -i 's/"replicationFactor"[[:space:]]*:[[:space:]]*3/"replicationFactor": 4/' "$file"
    echo "$file" >> "$MODLOG"
  elif [[ "$replicationFactor" == "4" ]]; then
    echo "$file: replicationFactor already 4, skipping"
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
