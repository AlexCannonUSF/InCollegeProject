>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. SkillMenu.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE      PIC 9.
01 EXIT-FLAG        PIC X VALUE 'N'.
77 WS-LOG-TEXT      PIC X(300) VALUE SPACES.
77 WS-CHOICE-LENGTH PIC 9(4) VALUE 1.

PROCEDURE DIVISION.

MAIN-LOGIC.
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
        CALL "TestInput" USING WS-CHOICE-LENGTH USER-CHOICE
        DISPLAY FUNCTION TRIM(USER-CHOICE)                            
        MOVE SPACES TO WS-LOG-TEXT
        STRING FUNCTION TRIM(USER-CHOICE) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
        EVALUATE USER-CHOICE
            WHEN 1
                DISPLAY "This skill is under construction."
                MOVE "This skill is under construction." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            WHEN 2
                DISPLAY "This skill is under construction."
                MOVE "This skill is under construction." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            WHEN 3
                DISPLAY "This skill is under construction."
                MOVE "This skill is under construction." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            WHEN 4
                DISPLAY "This skill is under construction."
                MOVE "This skill is under construction." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            WHEN 5
                DISPLAY "This skill is under construction."
                MOVE "This skill is under construction." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
            WHEN 6
                MOVE 'Y' TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
                MOVE "Invalid choice. Please try again." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-MENU.
    DISPLAY "Learn a New Skill:".
    MOVE "Learn a New Skill:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Skill 1".
    MOVE "Skill 1" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Skill 2".
    MOVE "Skill 2" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Skill 3".
    MOVE "Skill 3" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Skill 4".
    MOVE "Skill 4" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Skill 5".
    MOVE "Skill 5" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Go Back".
    MOVE "Go Back" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Enter your choice:".
    MOVE "Enter your choice:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT.

END PROGRAM SkillMenu.
