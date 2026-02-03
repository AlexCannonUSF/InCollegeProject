>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. HomePage.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE PIC 9.
01 EXIT-FLAG   PIC X VALUE 'N'.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    DISPLAY "Welcome, " FUNCTION TRIM(LNK-USER-NAME) "!"
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
        ACCEPT USER-CHOICE
        DISPLAY FUNCTION TRIM(USER-CHOICE)

        IF USER-CHOICE = 0
            MOVE 'Y' TO EXIT-FLAG
            EXIT PERFORM
        END-IF

        EVALUATE USER-CHOICE
            WHEN 1
                CALL "ProfileEdit" USING LNK-USER-NAME
            WHEN 2
                CALL "PersonalProfile" USING LNK-USER-NAME
            WHEN 3
                DISPLAY "Search for a job is under construction."
            WHEN 4
                DISPLAY "Find someone you know is under construction."
            WHEN 5
                CALL "SkillMenu"
            WHEN 6
                MOVE 'Y' TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-MENU.
    DISPLAY "1. Create/Edit My Profile"
    DISPLAY "2. View My Profile"
    DISPLAY "3. Search for a job"
    DISPLAY "4. Find someone you know"
    DISPLAY "5. Learn a new skill"
    DISPLAY "6. Logout"
    DISPLAY "Enter your choice:".

END PROGRAM HomePage.