>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. SkillMenu.

DATA DIVISION.
WORKING-STORAGE SECTION.
77 USER-CHOICE PIC X VALUE SPACE.
77 EXIT-FLAG PIC X VALUE "N".

PROCEDURE DIVISION.
MAIN.
    PERFORM UNTIL EXIT-FLAG = "Y"
        DISPLAY ""
        DISPLAY "Learn a Skill"
        DISPLAY "1) Learn about COBOL"
        DISPLAY "2) Learn about Java"
        DISPLAY "3) Learn about Python"
        DISPLAY "4) Exit"
        DISPLAY "Choose an option: "
        ACCEPT USER-CHOICE

        EVALUATE USER-CHOICE
            WHEN "1"
                DISPLAY "Under construction"
            WHEN "2"
                DISPLAY "Under construction"
            WHEN "3"
                DISPLAY "Under construction"
            WHEN "4"
                MOVE "Y" TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid option. Try again."
        END-EVALUATE
    END-PERFORM

    GOBACK.