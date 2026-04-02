>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ViewJobs.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT JOB-POSTINGS-FILE ASSIGN TO "data/JobPostings.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-JOB-FILE-STATUS.

DATA DIVISION.
FILE SECTION.
FD JOB-POSTINGS-FILE.
01 JOB-POSTING-RECORD.
    05 JOB-ID            PIC 9(4).
    05 JOB-POSTED-BY     PIC X(30).
    05 JOB-TITLE         PIC X(50).
    05 JOB-DESCRIPTION   PIC X(200).
    05 JOB-EMPLOYER      PIC X(50).
    05 JOB-LOCATION      PIC X(50).
    05 JOB-SALARY        PIC X(15).

WORKING-STORAGE SECTION.
77 WS-MENU-CHOICE        PIC X(4) VALUE SPACE.
77 WS-ACTION-CHOICE      PIC X VALUE SPACE.
77 WS-JOB-FILE-STATUS    PIC XX VALUE "00".
77 WS-JOB-FILE-EOF       PIC X VALUE "N".
77 WS-JOB-FOUND          PIC X VALUE "N".
77 WS-SELECTED-JOB-ID    PIC 9(4) VALUE 0.
77 WS-LOG-TEXT           PIC X(300) VALUE SPACES.
77 WS-MENU-CHOICE-LENGTH PIC 9(4) VALUE 4.
77 WS-ACTION-CHOICE-LENGTH PIC 9(4) VALUE 1.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    PERFORM DISPLAY-JOB-LIST
    GOBACK.

DISPLAY-JOB-LIST.
    MOVE "N" TO WS-JOB-FILE-EOF

    OPEN INPUT JOB-POSTINGS-FILE
    IF WS-JOB-FILE-STATUS NOT = "00"
        DISPLAY "ERROR: Unable to open job postings file."
        MOVE "ERROR: Unable to open job postings file." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Available Job/Internship Postings:"
    MOVE "Available Job/Internship Postings:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    PERFORM UNTIL WS-JOB-FILE-EOF = "Y"
        READ JOB-POSTINGS-FILE
            AT END
                MOVE "Y" TO WS-JOB-FILE-EOF
            NOT AT END
                DISPLAY "--------------------------------------------"
                MOVE "--------------------------------------------" TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
                DISPLAY "ID: " JOB-ID
                MOVE SPACES TO WS-LOG-TEXT
                STRING "ID: " DELIMITED BY SIZE JOB-ID DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                CALL "TestOutput" USING "A" WS-LOG-TEXT
                DISPLAY "Title: " JOB-TITLE
                MOVE SPACES TO WS-LOG-TEXT
                STRING "Title: " DELIMITED BY SIZE JOB-TITLE DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                CALL "TestOutput" USING "A" WS-LOG-TEXT
                DISPLAY "Employer: " JOB-EMPLOYER
                MOVE SPACES TO WS-LOG-TEXT
                STRING "Employer: " DELIMITED BY SIZE JOB-EMPLOYER DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                CALL "TestOutput" USING "A" WS-LOG-TEXT
                DISPLAY "Location: " JOB-LOCATION
                MOVE SPACES TO WS-LOG-TEXT
                STRING "Location: " DELIMITED BY SIZE JOB-LOCATION DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                CALL "TestOutput" USING "A" WS-LOG-TEXT
                DISPLAY "--------------------------------------------"
                MOVE "--------------------------------------------" TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-READ
    END-PERFORM

    CLOSE JOB-POSTINGS-FILE

    DISPLAY "Enter job ID to view details or R to return to menu:"
    MOVE "Enter job ID to view details or R to return to menu:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    CALL "TestInput" USING WS-MENU-CHOICE-LENGTH WS-MENU-CHOICE
    INSPECT WS-MENU-CHOICE REPLACING ALL X"0D" BY SPACE
    INSPECT WS-MENU-CHOICE REPLACING ALL X"0A" BY SPACE
    DISPLAY "You entered: " FUNCTION TRIM(WS-MENU-CHOICE)
    MOVE SPACES TO WS-LOG-TEXT
    STRING "You entered: " DELIMITED BY SIZE FUNCTION TRIM(WS-MENU-CHOICE) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    IF FUNCTION TRIM(WS-MENU-CHOICE) NOT = "R"
        PERFORM DISPLAY-JOB-DETAILS
    END-IF.

DISPLAY-JOB-DETAILS.
    MOVE "N" TO WS-JOB-FOUND
    MOVE "N" TO WS-JOB-FILE-EOF
    MOVE 0   TO WS-SELECTED-JOB-ID

    OPEN INPUT JOB-POSTINGS-FILE
    IF WS-JOB-FILE-STATUS NOT = "00"
        DISPLAY "ERROR: Unable to reopen job postings file."
        MOVE "ERROR: Unable to reopen job postings file." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        EXIT PARAGRAPH
    END-IF

    PERFORM UNTIL WS-JOB-FILE-EOF = "Y"
        READ JOB-POSTINGS-FILE
            AT END
                MOVE "Y" TO WS-JOB-FILE-EOF
            NOT AT END
                IF FUNCTION NUMVAL(WS-MENU-CHOICE) = JOB-ID
                    DISPLAY "--------------------------------------------"
                    MOVE "--------------------------------------------" TO WS-LOG-TEXT
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Job title: " JOB-TITLE
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Job title: " DELIMITED BY SIZE JOB-TITLE DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Description: " JOB-DESCRIPTION
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Description: " DELIMITED BY SIZE JOB-DESCRIPTION DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Employer: " JOB-EMPLOYER
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Employer: " DELIMITED BY SIZE JOB-EMPLOYER DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Location: " JOB-LOCATION
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Location: " DELIMITED BY SIZE JOB-LOCATION DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Salary: " JOB-SALARY
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Salary: " DELIMITED BY SIZE JOB-SALARY DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "--------------------------------------------"
                    MOVE "--------------------------------------------" TO WS-LOG-TEXT
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    MOVE "Y" TO WS-JOB-FOUND
                    MOVE JOB-ID TO WS-SELECTED-JOB-ID
                    MOVE "Y" TO WS-JOB-FILE-EOF
                END-IF
        END-READ
    END-PERFORM

    CLOSE JOB-POSTINGS-FILE

    IF WS-JOB-FOUND = "N"
        DISPLAY "Job posting not found."
        MOVE "Job posting not found." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        EXIT PARAGRAPH
    END-IF

    MOVE SPACE TO WS-ACTION-CHOICE

    PERFORM UNTIL WS-ACTION-CHOICE = "1"
        OR WS-ACTION-CHOICE = "2"

        DISPLAY "Choose your options:"
        MOVE "Choose your options:" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "1. Apply for this job/internship"
        MOVE "1. Apply for this job/internship" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "2. Return to main menu"
        MOVE "2. Return to main menu" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
            CALL "TestInput" USING WS-ACTION-CHOICE-LENGTH WS-ACTION-CHOICE
        INSPECT WS-ACTION-CHOICE REPLACING ALL X"0D" BY SPACE
        INSPECT WS-ACTION-CHOICE REPLACING ALL X"0A" BY SPACE
        DISPLAY "You entered: " FUNCTION TRIM(WS-ACTION-CHOICE)
        MOVE SPACES TO WS-LOG-TEXT
        STRING "You entered: " DELIMITED BY SIZE FUNCTION TRIM(WS-ACTION-CHOICE) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT

        IF WS-ACTION-CHOICE = "1"
            CALL "ApplyJob" USING LNK-USER-NAME WS-SELECTED-JOB-ID
        ELSE
            IF WS-ACTION-CHOICE = "2"
                EXIT PERFORM
            ELSE
                DISPLAY "Invalid choice. Please try again."
                MOVE "Invalid choice. Please try again." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            END-IF
        END-IF

    END-PERFORM.

END PROGRAM ViewJobs.