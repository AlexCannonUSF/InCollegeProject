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
01 WS-LOG-TEXT PIC X(300) VALUE SPACES.
01 WS-INPUT-LEN PIC 9(4) VALUE 0.

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
    MOVE SPACES TO WS-FNAME
    MOVE SPACES TO WS-LNAME

    MOVE LNK-USER-NAME TO Username

    DISPLAY "--- Create/Edit Profile ---"
    MOVE "--- Create/Edit Profile ---" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    PERFORM UNTIL FUNCTION TRIM(WS-FNAME) NOT = ""
        DISPLAY "Enter first name (required):"
        MOVE "Enter first name (required):" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 25 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN WS-FNAME
        INSPECT WS-FNAME REPLACING ALL X"0D" BY SPACE
        INSPECT WS-FNAME REPLACING ALL X"0A" BY SPACE

        IF FUNCTION TRIM(WS-FNAME) = ""
            DISPLAY "First name cannot be blank."
            MOVE "First name cannot be blank." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM
    DISPLAY FUNCTION TRIM(WS-FNAME)
    MOVE SPACES TO WS-LOG-TEXT
    STRING FUNCTION TRIM(WS-FNAME) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    PERFORM UNTIL FUNCTION TRIM(WS-LNAME) NOT = ""
        DISPLAY "Enter last name (required):"
        MOVE "Enter last name (required):" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 25 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN WS-LNAME
        INSPECT WS-LNAME REPLACING ALL X"0D" BY SPACE
        INSPECT WS-LNAME REPLACING ALL X"0A" BY SPACE

        IF FUNCTION TRIM(WS-LNAME) = ""
            DISPLAY "Last name cannot be blank."
            MOVE "Last name cannot be blank." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM
    DISPLAY FUNCTION TRIM(WS-LNAME)
    MOVE SPACES TO WS-LOG-TEXT
    STRING FUNCTION TRIM(WS-LNAME) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    
    MOVE SPACES TO Name
    STRING
        FUNCTION TRIM(WS-FNAME)
        SPACE
        FUNCTION TRIM(WS-LNAME)
        INTO Name
    END-STRING

    PERFORM UNTIL FUNCTION TRIM(University) NOT = ""
        DISPLAY "Enter university (required):"
        MOVE "Enter university (required):" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 50 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN University
        INSPECT University REPLACING ALL X"0D" BY SPACE
        INSPECT University REPLACING ALL X"0A" BY SPACE

        IF FUNCTION TRIM(University) = ""
            DISPLAY "University cannot be blank."
            MOVE "University cannot be blank." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM
    DISPLAY FUNCTION TRIM(University)
    MOVE SPACES TO WS-LOG-TEXT
    STRING FUNCTION TRIM(University) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    PERFORM UNTIL FUNCTION TRIM(Major) NOT = ""
        DISPLAY "Enter major (required):"
        MOVE "Enter major (required):" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 50 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN Major
        INSPECT Major REPLACING ALL X"0D" BY SPACE
        INSPECT Major REPLACING ALL X"0A" BY SPACE

        IF FUNCTION TRIM(Major) = ""
            DISPLAY "Major cannot be blank."
            MOVE "Major cannot be blank." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM
    DISPLAY FUNCTION TRIM(Major)
    MOVE SPACES TO WS-LOG-TEXT
    STRING FUNCTION TRIM(Major) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    PERFORM UNTIL 1 = 2
        DISPLAY "Enter graduation year (YYYY):"
        MOVE "Enter graduation year (YYYY):" TO WS-LOG-TEXT
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 10 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN WS-GRAD-RAW
        INSPECT WS-GRAD-RAW REPLACING ALL X"0D" BY SPACE
        INSPECT WS-GRAD-RAW REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(WS-GRAD-RAW)
        MOVE SPACES TO WS-LOG-TEXT
        STRING FUNCTION TRIM(WS-GRAD-RAW) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT

        IF FUNCTION LENGTH(FUNCTION TRIM(WS-GRAD-RAW)) = 4
            AND FUNCTION TRIM(WS-GRAD-RAW) IS NUMERIC
            MOVE FUNCTION TRIM(WS-GRAD-RAW) TO WS-GRAD-NUM
            MOVE WS-GRAD-NUM TO GradYear
            EXIT PERFORM
        ELSE
            DISPLAY "Invalid year. Please enter 4 digits."
            MOVE "Invalid year. Please enter 4 digits." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM

    DISPLAY "Enter About Me:"
    MOVE "Enter About Me:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    MOVE 200 TO WS-INPUT-LEN
    CALL "TestInput" USING WS-INPUT-LEN About
    INSPECT About REPLACING ALL X"0D" BY SPACE
    INSPECT About REPLACING ALL X"0A" BY SPACE
    DISPLAY FUNCTION TRIM(About)
    MOVE SPACES TO WS-LOG-TEXT
    STRING FUNCTION TRIM(About) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
    CALL "TestOutput" USING "A" WS-LOG-TEXT

    *> FIX #2: "blank to skip" truly skips the rest of that experience
    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Experience #" I " - Job Title (blank to skip):"
        MOVE SPACES TO WS-LOG-TEXT
        STRING "Experience #" DELIMITED BY SIZE I DELIMITED BY SIZE " - Job Title (blank to skip):" DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 50 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN JobTitle(I)
        INSPECT JobTitle(I) REPLACING ALL X"0D" BY SPACE
        INSPECT JobTitle(I) REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(JobTitle(I))
        MOVE SPACES TO WS-LOG-TEXT
        STRING FUNCTION TRIM(JobTitle(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT

        IF FUNCTION TRIM(JobTitle(I)) = ""
            MOVE SPACES TO Company(I)
            MOVE SPACES TO Dates(I)
            MOVE SPACES TO Desc(I)
        ELSE
            DISPLAY "Company:"
            MOVE "Company:" TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            MOVE 50 TO WS-INPUT-LEN
            CALL "TestInput" USING WS-INPUT-LEN Company(I)
            INSPECT Company(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Company(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Company(I))
            MOVE SPACES TO WS-LOG-TEXT
            STRING FUNCTION TRIM(Company(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
            CALL "TestOutput" USING "A" WS-LOG-TEXT

            DISPLAY "Dates:"
            MOVE "Dates:" TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            MOVE 30 TO WS-INPUT-LEN
            CALL "TestInput" USING WS-INPUT-LEN Dates(I)
            INSPECT Dates(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Dates(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Dates(I))
            MOVE SPACES TO WS-LOG-TEXT
            STRING FUNCTION TRIM(Dates(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
            CALL "TestOutput" USING "A" WS-LOG-TEXT

            DISPLAY "Description:"
            MOVE "Description:" TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            MOVE 200 TO WS-INPUT-LEN
            CALL "TestInput" USING WS-INPUT-LEN Desc(I)
            INSPECT Desc(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Desc(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Desc(I))
            MOVE SPACES TO WS-LOG-TEXT
            STRING FUNCTION TRIM(Desc(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM

    *> FIX #2: "blank to skip" truly skips the rest of that education
    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Education #" I " - Degree (blank to skip):"
        MOVE SPACES TO WS-LOG-TEXT
        STRING "Education #" DELIMITED BY SIZE I DELIMITED BY SIZE " - Degree (blank to skip):" DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        MOVE 50 TO WS-INPUT-LEN
        CALL "TestInput" USING WS-INPUT-LEN Degree(I)
        INSPECT Degree(I) REPLACING ALL X"0D" BY SPACE
        INSPECT Degree(I) REPLACING ALL X"0A" BY SPACE
        DISPLAY FUNCTION TRIM(Degree(I))
        MOVE SPACES TO WS-LOG-TEXT
        STRING FUNCTION TRIM(Degree(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT

        IF FUNCTION TRIM(Degree(I)) = ""
            MOVE SPACES TO Univ(I)
            MOVE SPACES TO Years(I)
        ELSE
            DISPLAY "University:"
            MOVE "University:" TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            MOVE 50 TO WS-INPUT-LEN
            CALL "TestInput" USING WS-INPUT-LEN Univ(I)
            INSPECT Univ(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Univ(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Univ(I))
            MOVE SPACES TO WS-LOG-TEXT
            STRING FUNCTION TRIM(Univ(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
            CALL "TestOutput" USING "A" WS-LOG-TEXT

            DISPLAY "Years attended:"
            MOVE "Years attended:" TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            MOVE 30 TO WS-INPUT-LEN
            CALL "TestInput" USING WS-INPUT-LEN Years(I)
            INSPECT Years(I) REPLACING ALL X"0D" BY SPACE
            INSPECT Years(I) REPLACING ALL X"0A" BY SPACE
            DISPLAY FUNCTION TRIM(Years(I))
            MOVE SPACES TO WS-LOG-TEXT
            STRING FUNCTION TRIM(Years(I)) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
            CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-IF
    END-PERFORM

    PERFORM UPDATE-IN-MEMORY
    DISPLAY "Profile created successfully."
    MOVE "Profile created successfully." TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
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
            MOVE "Cannot create profile. Profile limit reached." TO WS-LOG-TEXT
            CALL "TestOutput" USING "A" WS-LOG-TEXT
            EXIT PARAGRAPH
        END-IF
        ADD 1 TO LK-PROFILE-COUNT
        MOVE LK-PROFILE-COUNT TO WS-INDEX
    END-IF

    MOVE PROFILE-RECORD TO LK-PROF-ROW(WS-INDEX).

END PROGRAM ProfileCreate.