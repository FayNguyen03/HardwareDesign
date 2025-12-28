! /bin/bash
INPUT_FILE="$1"
OUTPUT_FILE="$2"
if [ -f "$INPUT_FILE" ]; then
	echo "File '$INPUT_FILE' exists."
else
	echo "File '$INPUT_FILE' does not exist."
	exit 1
fi
echo "New file: $OUTPUT_FILE"
touch "$OUTPUT_FILE"
while IFS= read -r line; do
    echo "$line" >> "$OUTPUT_FILE"
done < "$INPUT_FILE"
echo "Content of '$INPUT_FILE' has been copied line by line to '$OUTPUT_FILE'."
