>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ProfileFile ASSIGN TO "data/profiles.dat"
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
77 EOF-FLAG    PIC X VALUE "N".
77 FOUND-FLAG  PIC X VALUE "N".
77 I           PIC 9(1) VALUE 1.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    PERFORM SEARCH-PROFILE
    IF FOUND-FLAG = "N"
        DISPLAY "No profile exists for user: "
                FUNCTION TRIM(LNK-USER-NAME)
        GOBACK
    END-IF
    DISPLAY "Welcome to Your Personal Profile Page"
    DISPLAY "Name: " FUNCTION TRIM(Name)
    DISPLAY "University: " FUNCTION TRIM(University)
    DISPLAY "Major: " FUNCTION TRIM(Major)
    DISPLAY "Graduation Year: " GradYear
    DISPLAY "About Me: " FUNCTION TRIM(About)
    PERFORM WORK-EXPERIENCE
    PERFORM EDUCATION
    GOBACK.

SEARCH-PROFILE.
    MOVE "N" TO FOUND-FLAG
    MOVE "N" TO EOF-FLAG
    OPEN INPUT ProfileFile
    PERFORM UNTIL EOF-FLAG = "Y" OR FOUND-FLAG = "Y"
        READ ProfileFile
            AT END
                MOVE "Y" TO EOF-FLAG
            NOT AT END
                IF FUNCTION TRIM(Username)
                   = FUNCTION TRIM(LNK-USER-NAME)
                    MOVE "Y" TO FOUND-FLAG
                    EXIT PERFORM
                END-IF
        END-READ
    END-PERFORM
    CLOSE ProfileFile

    IF FOUND-FLAG = "N"
        DISPLAY "Profile not found for: "
                FUNCTION TRIM(LNK-USER-NAME)
    END-IF
    EXIT PARAGRAPH.

WORK-EXPERIENCE.
    DISPLAY "Experience:"
    IF FUNCTION TRIM(JobTitle(1)) = SPACE
       AND FUNCTION TRIM(JobTitle(2)) = SPACE
       AND FUNCTION TRIM(JobTitle(3)) = SPACE
        DISPLAY "No work experience found."
    ELSE
        PERFORM VARYING I FROM 1 BY 1
            UNTIL I > 3 OR FUNCTION TRIM(JobTitle(I)) = SPACE
            DISPLAY "Title: " FUNCTION TRIM(JobTitle(I))
            DISPLAY "Company: " FUNCTION TRIM(Company(I))
            DISPLAY "Dates: " FUNCTION TRIM(Dates(I))
            DISPLAY "Description: " FUNCTION TRIM(Desc(I))
        END-PERFORM
    END-IF.

EDUCATION.
    DISPLAY "Education:"
    IF FUNCTION TRIM(Degree(1)) = SPACE
       AND FUNCTION TRIM(Degree(2)) = SPACE
       AND FUNCTION TRIM(Degree(3)) = SPACE
        DISPLAY "No education history found."
    ELSE
        PERFORM VARYING I FROM 1 BY 1
            UNTIL I > 3 OR FUNCTION TRIM(Degree(I)) = SPACE
            DISPLAY "Degree: " FUNCTION TRIM(Degree(I))
            DISPLAY "University: " FUNCTION TRIM(Univ(I))
            DISPLAY "Years: " FUNCTION TRIM(Years(I))
        END-PERFORM
    END-IF.

END PROGRAM PersonalProfile.
