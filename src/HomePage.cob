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
        EVALUATE USER-CHOICE
            WHEN 1
                PERFORM JOB-SEARCH
            WHEN 2
                PERFORM FIND-SOMEONE
            WHEN 3
                PERFORM LEARN-SKILL
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
        END-EVALUATE
    END-PERFORM
    STOP RUN.

DISPLAY-WELCOME.
    DISPLAY "Welcome, " LNK-USER-NAME "!".
    DISPLAY SPACE.

DISPLAY-MENU.
    DISPLAY "Search for a job".
    DISPLAY "Find someone you know".
    DISPLAY "Learn a new skill".
    DISPLAY "Enter your choice:".
    DISPLAY SPACE.

JOB-SEARCH.
    DISPLAY "Job search/internship is under construction.".
    DISPLAY SPACE.

FIND-SOMEONE.
    DISPLAY "Find someone you know is under construction.".
    DISPLAY SPACE.

LEARN-SKILL.
    DISPLAY "Learn a new skill is under construction.".
    DISPLAY SPACE.

END PROGRAM HomePage.