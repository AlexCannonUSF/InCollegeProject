IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

DATA DIVISION.
WORKING-STORAGE SECTION.
77 FOUND-FLAG  PIC X VALUE "N".
77 I           PIC 9(1) VALUE 1.
77 IDX         PIC 9 VALUE 0.

01 PROFILE-RECORD.
    05 Username      PIC X(30).
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

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(30).
77 LK-PROFILE-COUNT PIC 9.
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
    PERFORM SEARCH-PROFILE
    IF FOUND-FLAG = "N"
        DISPLAY "No profile exists for user: " FUNCTION TRIM(LNK-USER-NAME)
        GOBACK
    END-IF

    DISPLAY "--- Your Profile ---"
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
    MOVE 0 TO IDX

    IF LK-PROFILE-COUNT = 0
        EXIT PARAGRAPH
    END-IF

    PERFORM VARYING I FROM 1 BY 1 UNTIL I > LK-PROFILE-COUNT OR FOUND-FLAG = "Y"
        IF FUNCTION TRIM(LK-USERNAME(I)) = FUNCTION TRIM(LNK-USER-NAME)
            MOVE "Y" TO FOUND-FLAG
            MOVE I TO IDX
        END-IF
    END-PERFORM

    IF FOUND-FLAG = "Y"
        MOVE LK-PROF-ROW(IDX) TO PROFILE-RECORD
    END-IF.

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