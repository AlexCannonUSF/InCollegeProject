>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. SkillMenu.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE      PIC 9.
01 EXIT-FLAG        PIC X VALUE 'N'.

PROCEDURE DIVISION.

MAIN-LOGIC.
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
        ACCEPT USER-CHOICE
        DISPLAY USER-CHOICE                             
        EVALUATE USER-CHOICE
            WHEN 1
                DISPLAY "This skill is under construction."
            WHEN 2
                DISPLAY "This skill is under construction."
            WHEN 3
                DISPLAY "This skill is under construction."
            WHEN 4
                DISPLAY "This skill is under construction."
            WHEN 5
                DISPLAY "This skill is under construction."
            WHEN 6
                MOVE 'Y' TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-MENU.
    DISPLAY "Learn a New Skill:".
    DISPLAY "Skill 1".
    DISPLAY "Skill 2".
    DISPLAY "Skill 3".
    DISPLAY "Skill 4".
    DISPLAY "Skill 5".
    DISPLAY "Go Back".
    DISPLAY "Enter your choice:".

END PROGRAM SkillMenu.
