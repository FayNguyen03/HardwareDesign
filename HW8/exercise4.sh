#! /bin/bash
cd test_input
for input_file in test_input*.txt;
do
	file_name="${input_file/input/output}"
	output_file="../test_output/${file_name}"
	../add_abs < "$input_file" > "$output_file"
done

