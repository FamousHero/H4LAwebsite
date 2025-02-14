#!/bin/bash

# Navigate to the target directory
cd "/code/_site/assets/js" || { echo "Directory not found!"; exit 1; }

# Process each .js file in the directory
for file in *.js; do
    # Check if there are any .js files
    if [[ -f "$file" ]]; then
        echo "Processing file: $file"
        
        # Extract function names using sed
        function_names=$(sed -n 's/function\s\+\([a-zA-Z0-9_]\+\).*/\1/p' "$file")

        if [[ -n "$function_names" ]]; then
            # Start building the export block
            export_block="module.exports = {\n"
            
            # Add each function name with a comma in between
            while IFS= read -r function_name; do
                export_block+="  $function_name,\n"
            done <<< "$function_names"
            
            # Remove the trailing comma and add closing brace
            export_block=$(echo -e "$export_block" | sed '$ s/,$//')
            export_block+="\n};\n"
            
            # Append the export block to the file
            echo -e "$export_block" >> "$file"
            
            echo "Module exports block added to $file"
        else
            echo "No functions found in $file"
        fi
    fi
done

# Run npm test after processing all files
echo "Running npm tests..."
npm run test

# Remove the module.exports block from each .js file
for file in *.js; do
    if [[ -f "$file" ]]; then
        echo "Removing module.exports block from: $file"
        sed -i '/module\.exports = {/,/};/d' "$file"
        echo "Module exports block removed from $file"
    fi
done

echo "Script execution completed."
