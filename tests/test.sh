#!/bin/bash
for input_file in tests/inputs/*.txt; do
    if [$input_file == "tests/test.sh"]; then
        continue
    fi

    echo "" > ./data/accounts.dat
    FILENAME=$(echo $input_file | cut -d '/' -f 3)
    
    ACTUAL_OUTPUT_FILE_NAME=("tests/actual_outputs/$FILENAME")
    IDEAL_OUTPUT_FILE_NAME=("tests/ideal_outputs/$FILENAME")

    ./bin/InCollege < $input_file | tee $ACTUAL_OUTPUT_FILE_NAME
done