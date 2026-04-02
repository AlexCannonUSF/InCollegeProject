>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. Messages.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE     PIC 9 VALUE 0.
01 EXIT-FLAG       PIC X VALUE 'N'.
77 WS-LOG-TEXT     PIC X(300) VALUE SPACES.
77 WS-CHOICE-LENGTH PIC 9(4) VALUE 1.

LINKAGE SECTION.
01 LNK-USER-NAME   PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.
MAIN.
       MOVE 'N' TO EXIT-FLAG.
       PERFORM UNTIL EXIT-FLAG = 'Y'
           PERFORM DISPLAY-MENU
           CALL "TestInput" USING WS-CHOICE-LENGTH USER-CHOICE
           DISPLAY USER-CHOICE
           MOVE SPACES TO WS-LOG-TEXT
           STRING FUNCTION TRIM(USER-CHOICE) DELIMITED BY SIZE INTO WS-LOG-TEXT END-STRING
           CALL "TestOutput" USING "A" WS-LOG-TEXT

           EVALUATE USER-CHOICE
               WHEN 1
                   CALL "SendMessage" USING LNK-USER-NAME
               WHEN 2
                   CALL "ViewMessages" USING LNK-USER-NAME
               WHEN 3
                   MOVE 'Y' TO EXIT-FLAG
               WHEN OTHER
                   DISPLAY "Invalid choice. Please try again."
                   MOVE "Invalid choice. Please try again." TO WS-LOG-TEXT
                   CALL "TestOutput" USING "A" WS-LOG-TEXT
           END-EVALUATE
       END-PERFORM.
       GOBACK.

DISPLAY-MENU.
       DISPLAY "--- Messages Menu---"
    MOVE "--- Messages Menu---" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
       DISPLAY "1. Send a New Message"
    MOVE "1. Send a New Message" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
       DISPLAY "2. View My Message"
    MOVE "2. View My Message" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
       DISPLAY "3. Back to Main Menu"
    MOVE "3. Back to Main Menu" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
       DISPLAY "Enter your choice: ".
    MOVE "Enter your choice: " TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT.
END PROGRAM Messages.