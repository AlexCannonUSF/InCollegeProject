>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. MyApplications.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT JOB-APP-FILE ASSIGN TO "data/JobApplications.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-APP-FILE-STATUS.

    SELECT JOB-POSTINGS-FILE ASSIGN TO "data/JobPostings.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-JOB-FILE-STATUS.

DATA DIVISION.
FILE SECTION.

FD JOB-APP-FILE.
01 JOB-APP-RECORD.
    05 APP-USERNAME PIC X(30).
    05 APP-JOB-ID   PIC 9(4).

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
77 WS-APP-FILE-STATUS     PIC XX VALUE "00".
77 WS-JOB-FILE-STATUS     PIC XX VALUE "00".
77 WS-APP-EOF             PIC X VALUE "N".
77 WS-JOB-EOF             PIC X VALUE "N".
77 WS-FOUND-ANY           PIC X VALUE "N".
77 WS-JOB-FOUND           PIC X VALUE "N".
77 WS-CURRENT-APP-JOB-ID  PIC 9(4) VALUE 0.
77 WS-LOG-TEXT            PIC X(300) VALUE SPACES.

LINKAGE SECTION.
01 LNK-USERNAME PIC X(30).

PROCEDURE DIVISION USING LNK-USERNAME.

MAIN.
    DISPLAY "--- Your Job Applications ---"
    MOVE "--- Your Job Applications ---" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Application Summary for " FUNCTION TRIM(LNK-USERNAME)
    MOVE SPACES TO WS-LOG-TEXT
    STRING "Application Summary for " DELIMITED BY SIZE FUNCTION TRIM(LNK-USERNAME) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    OPEN INPUT JOB-APP-FILE

    IF WS-APP-FILE-STATUS NOT = "00"
        DISPLAY "No applications found."
        MOVE "No applications found." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        GOBACK
    END-IF

    MOVE "N" TO WS-APP-EOF
    MOVE "N" TO WS-FOUND-ANY

    PERFORM UNTIL WS-APP-EOF = "Y"
        READ JOB-APP-FILE
            AT END
                MOVE "Y" TO WS-APP-EOF
            NOT AT END
                IF FUNCTION TRIM(APP-USERNAME) = FUNCTION TRIM(LNK-USERNAME)
                    MOVE "Y" TO WS-FOUND-ANY
                    MOVE APP-JOB-ID TO WS-CURRENT-APP-JOB-ID
                    PERFORM DISPLAY-APPLIED-JOB-DETAILS
                END-IF
        END-READ
    END-PERFORM

    CLOSE JOB-APP-FILE

    IF WS-FOUND-ANY = "N"
        DISPLAY "You have not applied to any jobs yet."
        MOVE "You have not applied to any jobs yet." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
    END-IF

    GOBACK.

DISPLAY-APPLIED-JOB-DETAILS.
    MOVE "N" TO WS-JOB-FOUND
    MOVE "N" TO WS-JOB-EOF

    OPEN INPUT JOB-POSTINGS-FILE

    IF WS-JOB-FILE-STATUS NOT = "00"
        DISPLAY "Applied Job ID: " WS-CURRENT-APP-JOB-ID
        MOVE SPACES TO WS-LOG-TEXT
        STRING "Applied Job ID: " DELIMITED BY SIZE WS-CURRENT-APP-JOB-ID DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "Job details file could not be opened."
        MOVE "Job details file could not be opened." TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        EXIT PARAGRAPH
    END-IF

    PERFORM UNTIL WS-JOB-EOF = "Y"
        READ JOB-POSTINGS-FILE
            AT END
                MOVE "Y" TO WS-JOB-EOF
            NOT AT END
                IF JOB-ID = WS-CURRENT-APP-JOB-ID
                    DISPLAY "--------------------------------------------"
                    MOVE "--------------------------------------------" TO WS-LOG-TEXT
                    CALL "TestOutput" USING "A" WS-LOG-TEXT
                    DISPLAY "Job ID: " JOB-ID
                    MOVE SPACES TO WS-LOG-TEXT
                    STRING "Job ID: " DELIMITED BY SIZE JOB-ID DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
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
                    MOVE "Y" TO WS-JOB-FOUND
                    MOVE "Y" TO WS-JOB-EOF
                END-IF
        END-READ
    END-PERFORM

    CLOSE JOB-POSTINGS-FILE

    IF WS-JOB-FOUND = "N"
        DISPLAY "--------------------------------------------"
        MOVE "--------------------------------------------" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "Job ID: " WS-CURRENT-APP-JOB-ID
        MOVE SPACES TO WS-LOG-TEXT
        STRING "Job ID: " DELIMITED BY SIZE WS-CURRENT-APP-JOB-ID DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "This job is no longer available in JobPostings.dat"
        MOVE "This job is no longer available in JobPostings.dat" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        DISPLAY "--------------------------------------------"
        MOVE "--------------------------------------------" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
    END-IF.

END PROGRAM MyApplications.