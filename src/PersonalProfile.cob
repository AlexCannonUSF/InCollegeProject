>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ProfileFile ASSIGN TO "../data/profiles.dat"
        ORGANIZATION IS SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD ProfileFile.
01 Profile-Record.
   05 Username      PIC X(20).
   05 Name          PIC X(50).
   05 University    PIC X(50).
   05 Major         PIC X(50).
   05 GradYear      PIC 9(4).
   05 About         PIC X(200).
   05 JobTitle      OCCURS 3 TIMES PIC X(50).
   05 Company       OCCURS 3 TIMES PIC X(50).
   05 Dates         OCCURS 3 TIMES PIC X(30).
   05 Desc          OCCURS 3 TIMES PIC X(200).
   05 Degree        OCCURS 3 TIMES PIC X(50).
   05 Univ          OCCURS 3 TIMES PIC X(50).
   05 Years         OCCURS 3 TIMES PIC X(30).

WORKING-STORAGE SECTION.
01 EOF-FLAG   PIC X VALUE 'N'.
01 FOUND-FLAG PIC X VALUE 'N'.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    PERFORM SEARCH-PROFILE

    IF FOUND-FLAG = 'N'
        DISPLAY "No profile exists for user: " FUNCTION TRIM(LNK-USER-NAME)
        GOBACK
    END-IF

    DISPLAY "----------------------------------"
    DISPLAY "Welcome to Your Personal Profile"
    DISPLAY "----------------------------------"
    DISPLAY "Name: " FUNCTION TRIM(Name)
    DISPLAY "University: " FUNCTION TRIM(University)
    DISPLAY "Major: " FUNCTION TRIM(Major)
    DISPLAY "Graduation Year: " GradYear
    DISPLAY "About Me: " FUNCTION TRIM(About)

    PERFORM DISPLAY-EXPERIENCE
    PERFORM DISPLAY-EDUCATION

    GOBACK.

SEARCH-PROFILE.
    MOVE 'N' TO FOUND-FLAG
    MOVE 'N' TO EOF-FLAG

    OPEN INPUT ProfileFile
    PERFORM UNTIL EOF-FLAG = 'Y' OR FOUND-FLAG = 'Y'
        READ ProfileFile
            AT END
                MOVE 'Y' TO EOF-FLAG
            NOT AT END
                IF FUNCTION TRIM(Username)
                   = FUNCTION TRIM(LNK-USER-NAME)
                    MOVE 'Y' TO FOUND-FLAG
                END-IF
        END-READ
    END-PERFORM
    CLOSE ProfileFile.

DISPLAY-EXPERIENCE.
    DISPLAY "Experience:"
    IF FUNCTION TRIM(JobTitle(1)) = ""
        DISPLAY "No work experience found."
    ELSE
        DISPLAY "Title: " FUNCTION TRIM(JobTitle(1))
        DISPLAY "Company: " FUNCTION TRIM(Company(1))
        DISPLAY "Dates: " FUNCTION TRIM(Dates(1))
        DISPLAY "Description: " FUNCTION TRIM(Desc(1))
    END-IF.

DISPLAY-EDUCATION.
    DISPLAY "Education:"
    IF FUNCTION TRIM(Degree(1)) = ""
        DISPLAY "No education history found."
    ELSE
        DISPLAY "Degree: " FUNCTION TRIM(Degree(1))
        DISPLAY "University: " FUNCTION TRIM(Univ(1))
        DISPLAY "Years: " FUNCTION TRIM(Years(1))
    END-IF.

END PROGRAM PersonalProfile.