IDENTIFICATION DIVISION.
PROGRAM-ID. ProfileCreate.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 I           PIC 9 VALUE 1.
01 WS-FNAME    PIC X(25) VALUE SPACES.
01 WS-LNAME    PIC X(25) VALUE SPACES.
01 WS-FOUND    PIC X VALUE "N".
01 WS-INDEX    PIC 9 VALUE 0.
01 WS-GRAD-RAW PIC X(10) VALUE SPACES.
01 WS-GRAD-NUM PIC 9(4) VALUE 0.

01 PROFILE-RECORD.
    05 Username      PIC X(30) VALUE SPACES.
    05 Name          PIC X(50) VALUE SPACES.
    05 University    PIC X(50) VALUE SPACES.
    05 Major         PIC X(50) VALUE SPACES.
    05 GradYear      PIC 9(4)  VALUE 0.
    05 About         PIC X(200) VALUE SPACES.
    05 JobTitle      OCCURS 3 TIMES PIC X(50) VALUE SPACES.
    05 Company       OCCURS 3 TIMES PIC X(50) VALUE SPACES.
    05 Dates         OCCURS 3 TIMES PIC X(30) VALUE SPACES.
    05 Desc          OCCURS 3 TIMES PIC X(200) VALUE SPACES.
    05 Degree        OCCURS 3 TIMES PIC X(50) VALUE SPACES.
    05 Univ          OCCURS 3 TIMES PIC X(50) VALUE SPACES.
    05 Years         OCCURS 3 TIMES PIC X(30) VALUE SPACES.

LINKAGE SECTION.
01 LNK-USER-NAME     PIC X(30).
77 LK-PROFILE-COUNT  PIC 9.
01 LK-PROFILE-LIST.
    05 LK-PROF-ROW OCCURS 5 TIMES.
        10 LK-USERNAME    PIC X(30).
        10 LK-NAME        PIC X(50).
        10 LK-UNIVERSITY  PIC X(50).
        10 LK-MAJOR       PIC X(50).
        10 LK-GRADYEAR    PIC 9(4).
        10 LK-ABOUT       PIC X(200).
        10 LK-JOBTITLE    OCCURS 3 TIMES PIC X(50).
        10 LK-COMPANY     OCCURS 3 TIMES PIC X(50).
        10 LK-DATES       OCCURS 3 TIMES PIC X(30).
        10 LK-DESC        OCCURS 3 TIMES PIC X(200).
        10 LK-DEGREE      OCCURS 3 TIMES PIC X(50).
        10 LK-UNIV        OCCURS 3 TIMES PIC X(50).
        10 LK-YEARS       OCCURS 3 TIMES PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME LK-PROFILE-COUNT LK-PROFILE-LIST.

MAIN.
    *> FIX #1: Properly initialize record each run
    MOVE SPACES TO PROFILE-RECORD
    MOVE 0 TO GradYear

    MOVE LNK-USER-NAME TO Username

    DISPLAY "--- Create/Edit Profile ---"

    DISPLAY "Enter first name:"
    ACCEPT WS-FNAME
    INSPECT WS-FNAME REPLACING ALL X"0D" BY SPACE
    INSPECT WS-FNAME REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(WS-FNAME)

    DISPLAY "Enter last name:"
    ACCEPT WS-LNAME
    INSPECT WS-LNAME REPLACING ALL X"0D" BY SPACE
    INSPECT WS-LNAME REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(WS-LNAME)

    MOVE SPACES TO Name
    STRING
        FUNCTION TRIM(WS-FNAME)
        SPACE
        FUNCTION TRIM(WS-LNAME)
        INTO Name
    END-STRING

    DISPLAY "Enter university:"
    ACCEPT University
    INSPECT University REPLACING ALL X"0D" BY SPACE
    INSPECT University REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(University)

    DISPLAY "Enter major:"
    ACCEPT Major
    INSPECT Major REPLACING ALL X"0D" BY SPACE
    INSPECT Major REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(Major)

    PERFORM UNTIL 1 = 2
        DISPLAY "Enter graduation year (YYYY):"
        ACCEPT WS-GRAD-RAW
        INSPECT WS-GRAD-RAW REPLACING ALL X"0D" BY SPACE
        INSPECT WS-GRAD-RAW REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(WS-GRAD-RAW)

        IF FUNCTION LENGTH(FUNCTION TRIM(WS-GRAD-RAW)) = 4
            AND FUNCTION TRIM(WS-GRAD-RAW) IS NUMERIC
            MOVE FUNCTION TRIM(WS-GRAD-RAW) TO WS-GRAD-NUM
            MOVE WS-GRAD-NUM TO GradYear
            EXIT PERFORM
        ELSE
            DISPLAY "Invalid year. Please enter 4 digits."
        END-IF
    END-PERFORM

    DISPLAY "Enter About Me:"
    ACCEPT About
    INSPECT About REPLACING ALL X"0D" BY SPACE
    INSPECT About REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(About)

    *> FIX #2: "blank to skip" truly skips the rest of that experience
    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Experience #" I " - Job Title (blank to skip):"
        ACCEPT JobTitle(I)
        INSPECT JobTitle(I) REPLACING ALL X"0D" BY SPACE
        INSPECT JobTitle(I) REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(JobTitle(I))

        IF FUNCTION TRIM(JobTitle(I)) = ""
            MOVE SPACES TO Company(I)
            MOVE SPACES TO Dates(I)
            MOVE SPACES TO Desc(I)
        ELSE
            DISPLAY "Company:"
            ACCEPT Company(I)
            INSPECT Company(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Company(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Company(I))

            DISPLAY "Dates:"
            ACCEPT Dates(I)
            INSPECT Dates(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Dates(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Dates(I))

            DISPLAY "Description:"
            ACCEPT Desc(I)
            INSPECT Desc(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Desc(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Desc(I))
        END-IF
    END-PERFORM

    *> FIX #2: "blank to skip" truly skips the rest of that education
    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Education #" I " - Degree (blank to skip):"
        ACCEPT Degree(I)
        INSPECT Degree(I) REPLACING ALL X"0D" BY SPACE
        INSPECT Degree(I) REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(Degree(I))

        IF FUNCTION TRIM(Degree(I)) = ""
            MOVE SPACES TO Univ(I)
            MOVE SPACES TO Years(I)
        ELSE
            DISPLAY "University:"
            ACCEPT Univ(I)
            INSPECT Univ(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Univ(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Univ(I))

            DISPLAY "Years attended:"
            ACCEPT Years(I)
            INSPECT Years(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Years(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Years(I))
        END-IF
    END-PERFORM

    PERFORM UPDATE-IN-MEMORY
    DISPLAY "Profile created successfully."
    GOBACK.

UPDATE-IN-MEMORY.
    MOVE "N" TO WS-FOUND
    MOVE 0 TO WS-INDEX

    IF LK-PROFILE-COUNT > 0
        PERFORM VARYING I FROM 1 BY 1 UNTIL I > LK-PROFILE-COUNT
            IF FUNCTION TRIM(LK-USERNAME(I)) = FUNCTION TRIM(Username)
                MOVE "Y" TO WS-FOUND
                MOVE I TO WS-INDEX
                EXIT PERFORM
            END-IF
        END-PERFORM
    END-IF

    IF WS-FOUND = "N"
        IF LK-PROFILE-COUNT = 5
            DISPLAY "Cannot create profile. Profile limit reached."
            EXIT PARAGRAPH
        END-IF
        ADD 1 TO LK-PROFILE-COUNT
        MOVE LK-PROFILE-COUNT TO WS-INDEX
    END-IF

    MOVE PROFILE-RECORD TO LK-PROF-ROW(WS-INDEX).

END PROGRAM ProfileCreate.