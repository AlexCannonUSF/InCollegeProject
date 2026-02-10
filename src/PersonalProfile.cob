>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PersonalProfile.

DATA DIVISION.
WORKING-STORAGE SECTION.
77 IDX PIC 9(2) VALUE 1.
77 FOUND-FLAG PIC X VALUE "N".

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
01 LNK-USER-NAME PIC X(10).

PROCEDURE DIVISION USING PROFILE-RECORD LK-PROFILE-COUNT LNK-USER-NAME.
MAIN.
    MOVE "N" TO FOUND-FLAG
    PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > LK-PROFILE-COUNT OR FOUND-FLAG = "Y"
        IF FUNCTION TRIM(LK-PROF-ROW(IDX).Username) = FUNCTION TRIM(LNK-USER-NAME)
            MOVE "Y" TO FOUND-FLAG
            DISPLAY ""
            DISPLAY "Username: " FUNCTION TRIM(LK-PROF-ROW(IDX).Username)
            DISPLAY "Name: " FUNCTION TRIM(LK-PROF-ROW(IDX).Name)
            DISPLAY "University: " FUNCTION TRIM(LK-PROF-ROW(IDX).University)
            DISPLAY "Major: " FUNCTION TRIM(LK-PROF-ROW(IDX).Major)
            DISPLAY "Grad Year: " FUNCTION TRIM(LK-PROF-ROW(IDX).GradYear)
            DISPLAY "About: " FUNCTION TRIM(LK-PROF-ROW(IDX).About)
            DISPLAY ""
            DISPLAY "Experience:"
            DISPLAY "  Title: " FUNCTION TRIM(LK-PROF-ROW(IDX).JobTitle)
            DISPLAY "  Company: " FUNCTION TRIM(LK-PROF-ROW(IDX).Company)
            DISPLAY "  Dates: " FUNCTION TRIM(LK-PROF-ROW(IDX).Dates)
            DISPLAY "  Description: " FUNCTION TRIM(LK-PROF-ROW(IDX).Desc)
            DISPLAY ""
            DISPLAY "Education:"
            DISPLAY "  Degree: " FUNCTION TRIM(LK-PROF-ROW(IDX).Degree)
            DISPLAY "  University: " FUNCTION TRIM(LK-PROF-ROW(IDX).Univ)
            DISPLAY "  Years: " FUNCTION TRIM(LK-PROF-ROW(IDX).Years)
        END-IF
    END-PERFORM

    IF FOUND-FLAG = "N"
        DISPLAY "Profile not found."
    END-IF

    GOBACK.