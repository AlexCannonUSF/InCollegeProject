>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WorkCount         PIC 9(2) VALUE 0.
01 EduCount          PIC 9(2) VALUE 0.
01 UserProfile.
   05 Name            PIC X(50).
   05 University       PIC X(50).
   05 Major           PIC X(50).
   05 GraduationYear  PIC 9(4).
   05 AboutMe         PIC X(200).
   05 WorkExperience   OCCURS 0 TO 3 TIMES DEPENDING ON WorkCount.
      10 JobTitle      PIC X(50).
      10 Company   PIC X(50).
      10 Dates   PIC X(30).
      10 Description PIC X(200).
   05 EducationHistory OCCURS 0 TO 3 TIMES DEPENDING ON EduCount.
      10 Degree        PIC X(50).
      10 University PIC X(50).
      10 Years      PIC X(30).
77 I PIC 9(2) VALUE 0.
PROCEDURE DIVISION.
MAIN.
    DISPLAY 'Welcome to Your Personal Profile Page'.
    DISPLAY 'Name: ' FUNCTION TRIM(Name).                                
    DISPLAY 'University: ' FUNCTION TRIM(University).
    DISPLAY 'Major: ' FUNCTION (Major).
    DISPLAY 'Graduation Year: ' FUNCTION TRIM(GraduationYear).
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
            DISPLAY 'Title: ' FUNCTION TRIM(WorkExperience(I).JobTitle).
            DISPLAY 'Company: ' FUNCTION TRIM(WorkExperience(I).Company).
            DISPLAY 'Dates: ' FUNCTION TRIM(WorkExperience(I).Dates).
            DISPLAY 'Description: ' FUNCTION TRIM(WorkExperience(I).Description).
        END-PERFORM.
    END-IF.

DISPLAY-EDUCATION.
    DISPLAY "Education:".
    IF EduCount = 0 THEN
        DISPLAY 'No education history.'
    ELSE
        PERFORM VARYING I FROM 1 BY 1 UNTIL I > EduCount
            DISPLAY 'Degree: ' FUNCTION TRIM(EducationHistory(I).Degree).
            DISPLAY 'University: ' FUNCTION TRIM(EducationHistory(I).University).
            DISPLAY 'Years: ' FUNCTION TRIM(EducationHistory(I).Years).
        END-PERFORM.
    END-IF.