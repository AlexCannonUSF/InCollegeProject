>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ProfileCreate.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ProfileFile ASSIGN TO "data/profiles.dat"
        ORGANIZATION IS SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD ProfileFile.
01 Profile-Record.
   05 Username      PIC X(20) VALUE SPACES.
   05 Name          PIC X(50) VALUE SPACES.
   05 University    PIC X(50) VALUE SPACES.
   05 Major         PIC X(50) VALUE SPACES.
   05 GradYear      PIC 9(4).
   05 About         PIC X(200) VALUE SPACES.
   05 JobTitle      OCCURS 3 TIMES PIC X(50) VALUE SPACES.
   05 Company       OCCURS 3 TIMES PIC X(50) VALUE SPACES.
   05 Dates         OCCURS 3 TIMES PIC X(30) VALUE SPACES.
   05 Desc          OCCURS 3 TIMES PIC X(200) VALUE SPACES.
   05 Degree        OCCURS 3 TIMES PIC X(50) VALUE SPACES.
   05 Univ          OCCURS 3 TIMES PIC X(50) VALUE SPACES.
   05 Years         OCCURS 3 TIMES PIC X(30) VALUE SPACES.

WORKING-STORAGE SECTION.
01 I          PIC 9.
01 WS-FNAME   PIC X(25) VALUE SPACES.
01 WS-LNAME   PIC X(25) VALUE SPACES.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    OPEN OUTPUT ProfileFile
    MOVE LNK-USER-NAME TO Username

    DISPLAY "--- Create/Edit Profile ---"

    DISPLAY "Enter first name:"
    ACCEPT WS-FNAME
    DISPLAY FUNCTION TRIM(WS-FNAME)

    DISPLAY "Enter last name:"
    ACCEPT WS-LNAME
    DISPLAY FUNCTION TRIM(WS-LNAME)

    STRING
        FUNCTION TRIM(WS-FNAME)
        SPACE
        FUNCTION TRIM(WS-LNAME)
        INTO Name
    END-STRING

    DISPLAY "Enter university:"
    ACCEPT University
    DISPLAY FUNCTION TRIM(University)

    DISPLAY "Enter major:"
    ACCEPT Major
    DISPLAY FUNCTION TRIM(Major)

    DISPLAY "Enter graduation year (YYYY):"
    ACCEPT GradYear
    DISPLAY FUNCTION TRIM(GradYear)

    DISPLAY "Enter About Me:"
    ACCEPT About
    DISPLAY FUNCTION TRIM(About)

    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Experience #" I " - Job Title (blank to skip):"
        ACCEPT JobTitle(I)
        DISPLAY FUNCTION TRIM(JobTitle(I))

        DISPLAY "Company:"
        ACCEPT Company(I)
        DISPLAY FUNCTION TRIM(Company(I))

        DISPLAY "Dates:"
        ACCEPT Dates(I)
        DISPLAY FUNCTION TRIM(Dates(I))

        DISPLAY "Description:"
        ACCEPT Desc(I)
        DISPLAY FUNCTION TRIM(Desc(I))
    END-PERFORM

    PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
        DISPLAY "Education #" I " - Degree (blank to skip):"
        ACCEPT Degree(I)
        DISPLAY FUNCTION TRIM(Degree(I))

        DISPLAY "University:"
        ACCEPT Univ(I)
        DISPLAY FUNCTION TRIM(Univ(I))

        DISPLAY "Years attended:"
        ACCEPT Years(I)
        DISPLAY FUNCTION TRIM(Years(I))
    END-PERFORM

    WRITE Profile-Record
    CLOSE ProfileFile

    DISPLAY "Profile created successfully."
    GOBACK.

END PROGRAM ProfileCreate.