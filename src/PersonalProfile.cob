>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 I                 PIC 9(2) VALUE 0.
77 WorkCount         PIC 9(2) VALUE 0.
77 EduCount          PIC 9(2) VALUE 0.
01 UserProfile.
   05 Name            PIC X(50).
   05 UserUniversity  PIC X(50).
   05 Major           PIC X(50).
   05 GraduationYear  PIC 9(4).
   05 AboutMe         PIC X(200).
   05 WorkExperience   OCCURS 3 TIMES.
      10 JobTitle      PIC X(50).
      10 Company       PIC X(50).
      10 Dates         PIC X(30).
      10 Description   PIC X(200).
   05 EducationHistory OCCURS 3 TIMES.
      10 Degree        PIC X(50).
      10 EduUniversity PIC X(50).
      10 Years         PIC X(30).
LINKAGE SECTION.
01 LK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LK-USER-NAME.
MAIN.
    DISPLAY 'Welcome to Your Personal Profile Page'.
    DISPLAY 'Viewing Profile for: ' FUNCTION TRIM(LK-USER-NAME).
    DISPLAY 'Name: ' FUNCTION TRIM(Name).
    DISPLAY 'University: ' FUNCTION TRIM(UserUniversity).
    DISPLAY 'Major: ' FUNCTION TRIM(Major).
    DISPLAY 'Graduation Year: ' GraduationYear.
    DISPLAY 'About Me: ' FUNCTION TRIM(AboutMe).
    PERFORM DISPLAY-WORK-EXPERIENCE.
    PERFORM DISPLAY-EDUCATION.
    GOBACK.

DISPLAY-WORK-EXPERIENCE.
    DISPLAY "Experience:".
    IF WorkCount = 0 THEN
        DISPLAY 'No work experience.'
    ELSE
        PERFORM VARYING I FROM 1 BY 1 UNTIL I > WorkCount
            DISPLAY 'Title: ' FUNCTION TRIM(WorkExperience(I).JobTitle)
            DISPLAY 'Company: ' FUNCTION TRIM(WorkExperience(I).Company)
            DISPLAY 'Dates: ' FUNCTION TRIM(WorkExperience(I).Dates)
            DISPLAY 'Description: ' FUNCTION TRIM(WorkExperience(I).Description)
        END-PERFORM
    END-IF.

DISPLAY-EDUCATION.
    DISPLAY "Education:".
    IF EduCount = 0 THEN
        DISPLAY 'No education history.'
    ELSE
        PERFORM VARYING I FROM 1 BY 1 UNTIL I > EduCount
            DISPLAY 'Degree: ' FUNCTION TRIM(EducationHistory(I).Degree)
            DISPLAY 'University: ' FUNCTION TRIM(EducationHistory(I).EduUniversity)
            DISPLAY 'Years: ' FUNCTION TRIM(EducationHistory(I).Years)
        END-PERFORM
    END-IF.

END PROGRAM PersonalProfile.