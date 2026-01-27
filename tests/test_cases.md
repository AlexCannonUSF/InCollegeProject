# Tests ReadMe

## Directories
- `actual_outputs`: Contains the actual outputs of the test cases
- `ideal_outputs`: Contains the correct outputs of the test cases
- `inputs`: Contains the inputs to the test cases

## Running Testcases
- With the docker container and in the directory `/workspaces/InCollegeProject`, run `./tests/test.sh` to run through each test case.
- All outputs of the test cases (assuming no indefinite loops are found in the program) will appear in the `actual_outputs` directory.
- Testing will involve checking that the output files in the `actual_outputs` directory match the output files in the `ideal_outputs` directory.
- Make sure to empty `data/accounts.dat` file before each test case.