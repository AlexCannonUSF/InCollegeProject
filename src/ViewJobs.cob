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
77 WS-MENU-CHOICE       PIC X(4) VALUE SPACE.
77 WS-JOB-FILE-STATUS   PIC XX VALUE "00".
77 WS-JOB-FILE-EOF      PIC X VALUE "N".
77 WS-JOB-FOUND         PIC X VALUE "N".

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
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Available Job/Internship Postings:"

    PERFORM UNTIL WS-JOB-FILE-EOF = "Y"
        READ JOB-POSTINGS-FILE
            AT END
                MOVE "Y" TO WS-JOB-FILE-EOF
            NOT AT END
                DISPLAY "--------------------------------------------"
                DISPLAY "ID: " JOB-ID
                DISPLAY "Title: " JOB-TITLE
                DISPLAY "Employer: " JOB-EMPLOYER
                DISPLAY "Location: " JOB-LOCATION
                DISPLAY "--------------------------------------------"
        END-READ
    END-PERFORM

    CLOSE JOB-POSTINGS-FILE

    DISPLAY "Enter job ID to view details or R to return to menu:"
    ACCEPT WS-MENU-CHOICE
    DISPLAY "You entered: " WS-MENU-CHOICE

    IF WS-MENU-CHOICE NOT = "R"
        PERFORM DISPLAY-JOB-DETAILS
    END-IF.


DISPLAY-JOB-DETAILS.
    MOVE "N" TO WS-JOB-FOUND
    MOVE "N" TO WS-JOB-FILE-EOF

    OPEN INPUT JOB-POSTINGS-FILE
    IF WS-JOB-FILE-STATUS NOT = "00"
        DISPLAY "ERROR: Unable to reopen job postings file."
        EXIT PARAGRAPH
    END-IF

    PERFORM UNTIL WS-JOB-FILE-EOF = "Y"
        READ JOB-POSTINGS-FILE
            AT END
                MOVE "Y" TO WS-JOB-FILE-EOF
            NOT AT END
                IF FUNCTION NUMVAL(WS-MENU-CHOICE) = JOB-ID
                    DISPLAY "--------------------------------------------"
                    DISPLAY "Job title: " JOB-TITLE
                    DISPLAY "Description: " JOB-DESCRIPTION
                    DISPLAY "Employer: " JOB-EMPLOYER
                    DISPLAY "Location: " JOB-LOCATION
                    DISPLAY "Salary: " JOB-SALARY
                    DISPLAY "--------------------------------------------"
                    MOVE "Y" TO WS-JOB-FOUND
                    MOVE "Y" TO WS-JOB-FILE-EOF
                END-IF
        END-READ
    END-PERFORM

    CLOSE JOB-POSTINGS-FILE

    IF WS-JOB-FOUND = "N"
        DISPLAY "Job posting not found."
        EXIT PARAGRAPH
    END-IF

    PERFORM UNTIL WS-MENU-CHOICE = "1"
        OR WS-MENU-CHOICE = "2"

        DISPLAY "Choose your options:"
        DISPLAY "1. Apply for this job/internship"
        DISPLAY "2. Return to main menu"
        ACCEPT WS-MENU-CHOICE
        DISPLAY "You entered: " WS-MENU-CHOICE

        IF WS-MENU-CHOICE = "1"
            DISPLAY "Applying feature is under construction."
        ELSE IF WS-MENU-CHOICE = "2"
            EXIT PERFORM
        ELSE
            DISPLAY "Invalid choice. Please try again."
        END-IF

    END-PERFORM.