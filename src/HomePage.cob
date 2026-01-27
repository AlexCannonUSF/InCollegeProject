>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. HomePage.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE      PIC 9.
01 EXIT-FLAG        PIC X VALUE 'N'.

LINKAGE SECTION.
01 LNK-USER-NAME    PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN-LOGIC.
    PERFORM DISPLAY-WELCOME.
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
        ACCEPT USER-CHOICE
        DISPLAY "You entered: " USER-CHOICE
        EVALUATE USER-CHOICE
            WHEN 1
                PERFORM JOB-SEARCH
            WHEN 2
                PERFORM FIND-SOMEONE
            WHEN 3
                PERFORM LEARN-SKILL
                CALL 'SkillMenu' 
            WHEN 4
                PERFORM LOGOUT
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-WELCOME.
    DISPLAY "Welcome, " FUNCTION TRIM(LNK-USER-NAME) "!".
    DISPLAY SPACE.

DISPLAY-MENU.
    DISPLAY "1. Search for a job".
    DISPLAY "2. Find someone you know".
    DISPLAY "3. Learn a new skill".
    DISPLAY "4. Logout".
    DISPLAY "Enter your choice:".

JOB-SEARCH.
    DISPLAY "Job search/internship is under construction.".

FIND-SOMEONE.
    DISPLAY "Find someone you know is under construction.".

LEARN-SKILL.
    DISPLAY "Learn a new skill is under construction.".

LOGOUT.
    DISPLAY "Logging out...".
    MOVE 'Y' TO EXIT-FLAG.

END PROGRAM HomePage.