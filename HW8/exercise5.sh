#! /bin/bash
cd test_input
for input_file in test_input*.txt;
do
	echo "Testing the ${input_file}:"
	file_name_output="${input_file/input/output}"
	file_name_expected="${file_name_output/test/expected}"
	output_file="../test_output/${file_name_output}"
	expected_file="../expected_output/${file_name_expected}"
	../add_abs < "$input_file" > "$output_file"
	if cmp -s "$output_file" "$expected_file"; then
		
		echo "Output matches expected output."
	else
		echo "Output does not match expected output."
		diff -u "$output_file" "$expected_file"
	fi
done

