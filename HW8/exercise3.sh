
#! /bin/bash

echo "Testing add_abs on 5 and 10 produces output:" >> test_output.txt
./add_abs <<< "5 10" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on 0 and 7 produces output:" >> test_output.txt
./add_abs <<< "0 7" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on -8 and -4 produces output:" >> test_output.txt
./add_abs <<< "-8 -4" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on -2 and 0 produces output:" >> test_output.txt
./add_abs <<< "-2 0" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on -3 and 6 produces output:" >> test_output.txt
./add_abs <<< "-3 6" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on 9 and -11 produces output:" >> test_output.txt
./add_abs <<< "9 -11" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on 0 and 0 produces output:" >> test_output.txt
./add_abs <<< "0 0" >> test_output.txt
echo "" >> test_output.txt
echo "Testing add_abs on -5 and 2 produces output:" >> test_output.txt
./add_abs <<< "-5 2" >> test_output.txt
echo "" >> test_output.txt
