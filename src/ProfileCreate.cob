>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ProfileCreate.

DATA DIVISION.
WORKING-STORAGE SECTION.

77 WS-INDEX PIC 9(2) VALUE 1.
77 WS-FOUND PIC X VALUE "N".
77 WS-GRAD-RAW PIC X(10) VALUE SPACES.
77 WS-GRAD-NUM PIC 9(4) VALUE 0.

LINKAGE SECTION.
01 PROFILE-RECORD.
   05 LK-PROF-ROW OCCURS 10 TIMES.
      10 Username PIC X(10).
      10 Name PIC X(25).
      10 University PIC X(25).
      10 Major PIC X(25).
      10 GradYear PIC X(4).
      10 About PIC X(200).
      10 JobTitle PIC X(25).
      10 Company PIC X(25).
      10 Dates PIC X(15).
      10 Desc PIC X(100).
      10 Degree PIC X(25).
      10 Univ PIC X(25).
      10 Years PIC X(15).
01 LK-PROFILE-COUNT PIC 9(2).
01 LK-USERNAME PIC X(10).

PROCEDURE DIVISION USING PROFILE-RECORD LK-PROFILE-COUNT LK-USERNAME.
MAIN.
    MOVE "N" TO WS-FOUND
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > LK-PROFILE-COUNT OR WS-FOUND = "Y"
        IF FUNCTION TRIM(LK-PROF-ROW(WS-INDEX).Username) = FUNCTION TRIM(LK-USERNAME)
            MOVE "Y" TO WS-FOUND
        END-IF
    END-PERFORM

    IF WS-FOUND = "Y"
        DISPLAY "A profile already exists for this user."
        GOBACK
    END-IF

    ADD 1 TO LK-PROFILE-COUNT
    MOVE LK-USERNAME TO LK-PROF-ROW(LK-PROFILE-COUNT).Username

    DISPLAY "Enter your name: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Name

    DISPLAY "Enter your university: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).University

    DISPLAY "Enter your major: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Major

    DISPLAY "Enter your graduation year: "
    ACCEPT WS-GRAD-RAW

    INSPECT WS-GRAD-RAW REPLACING ALL SPACE BY ""
    INSPECT WS-GRAD-RAW REPLACING ALL "-" BY ""
    MOVE FUNCTION NUMVAL(WS-GRAD-RAW) TO WS-GRAD-NUM
    IF WS-GRAD-NUM < 2020 OR WS-GRAD-NUM > 2030
        DISPLAY "Invalid graduation year."
        SUBTRACT 1 FROM LK-PROFILE-COUNT
        GOBACK
    END-IF
    MOVE WS-GRAD-RAW(1:4) TO LK-PROF-ROW(LK-PROFILE-COUNT).GradYear

    DISPLAY "Enter a short 'About' section: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).About

    DISPLAY "Enter your job title: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).JobTitle
    DISPLAY "Enter your company: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Company
    DISPLAY "Enter your dates of employment: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Dates
    DISPLAY "Enter a short description of your job: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Desc

    DISPLAY "Enter your degree: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Degree
    DISPLAY "Enter your university for education: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Univ
    DISPLAY "Enter your years attended: "
    ACCEPT LK-PROF-ROW(LK-PROFILE-COUNT).Years

    DISPLAY "Profile created successfully!"
    GOBACK.