>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. HomePage.

DATA DIVISION.
WORKING-STORAGE SECTION.
77 USER-CHOICE PIC X VALUE SPACE.
77 EXIT-FLAG PIC X VALUE "N".

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(10).
01 WS-PROFILE-LIST.
   05 WS-PROF-ROW OCCURS 10 TIMES.
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
01 WS-PROFILE-COUNT PIC 9(2).

PROCEDURE DIVISION USING LNK-USER-NAME WS-PROFILE-LIST WS-PROFILE-COUNT.
MAIN-MENU.
    PERFORM UNTIL EXIT-FLAG = "Y"
        DISPLAY ""
        DISPLAY "Welcome to InCollege!"
        DISPLAY "1) Find Someone You Know"
        DISPLAY "2) Learn a Skill"
        DISPLAY "3) Useful Links"
        DISPLAY "4) InCollege Important Links"
        DISPLAY "5) View Your Profile"
        DISPLAY "6) Exit"
        DISPLAY "Choose an option: "
        ACCEPT USER-CHOICE

        EVALUATE USER-CHOICE
            WHEN "1"
                DISPLAY "Under construction"
            WHEN "2"
                CALL "SkillMenu"
            WHEN "3"
                DISPLAY "Under construction"
            WHEN "4"
                DISPLAY "Under construction"
            WHEN "5"
                CALL "PersonalProfile" USING WS-PROFILE-LIST WS-PROFILE-COUNT LNK-USER-NAME
            WHEN "6"
                MOVE "Y" TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid option. Try again."
        END-EVALUATE
    END-PERFORM

    GOBACK.