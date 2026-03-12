# Epic 6: Persistence Verification

## To verify that job listings are saved correctly and persist after the program is closed, follow these steps:

1. Run the program using input from the file 'tests/epoch_6/Positive-Successful-Job-Post.txt'.

2. Run cat data/JobPostings.dat to see the added job, pay attention to its ID indicated by the first 4 digits.

3. Run the program using input from the file 'tests/epoch_6/Positive-Successful-Job-Post-No-Salary.txt'

4. Run cat data/JobPostings.dat to see the added job, pay attention to its ID indicated by the first 4 digits.

5. The program should automatically assign the next sequential JOB-ID to the second job. (e.g., if the last job was 0001, then the new one will be 0002).

## The order in which these tests are run do not matter. Each test case exits the program, effectively restarting the program.