# README for Epic 5 testing

**Before beginning to test:**
* "data/accounts.dat" and "data/profiles.dat" should be empty
* After emptying, open the "test setup" folder and run the "seed_accounts.txt" file as an input only ONCE to create a new "data/accounts.dat" and "data/profiles.dat". This creates 4 new accounts and fills in the mandatory profile fields for an account (First and last name, University, Major, and Graduation Year).
* "data/EstablishedConnections.dat" and "data/PendingRequests.dat" should not exist at the start of each test case

**The "sample input output" folder does the following:**
* Log in to 4 different accounts, each sending a request to 1 account.
* The receiving account will be logged into and: accept, reject, accept, reject requests in that order.
* The account will view their connections and see 2 accounts in their connections.
* The account will be logged out and the program will exit.

**tests folder**
* "inputs" folder has all input test cases. Each file is named after what they test.
* "outputs" folder has all outputs of the test cases. Each file is named exactly as its respective input in the "inputs" folder.