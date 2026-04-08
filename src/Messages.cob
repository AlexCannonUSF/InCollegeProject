>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. Messages.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE     PIC 9 VALUE 0.
01 EXIT-FLAG       PIC X VALUE 'N'.

LINKAGE SECTION.
01 LNK-USER-NAME   PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.
MAIN.
       MOVE 'N' TO EXIT-FLAG.
       PERFORM UNTIL EXIT-FLAG = 'Y'
           PERFORM DISPLAY-MENU
           ACCEPT USER-CHOICE
           DISPLAY USER-CHOICE

           EVALUATE USER-CHOICE
               WHEN 1
                   CALL "SendMessage" USING LNK-USER-NAME
               WHEN 2
                   CALL "ViewMessages" USING LNK-USER-NAME
               WHEN 3
                   MOVE 'Y' TO EXIT-FLAG
               WHEN OTHER
                   DISPLAY "Invalid choice. Please try again."
           END-EVALUATE
       END-PERFORM.
       GOBACK.

DISPLAY-MENU.
       DISPLAY "--- Messages Menu ---"
       DISPLAY "1. Send a New Message"
       DISPLAY "2. View My Message"
       DISPLAY "3. Back to Main Menu"
       DISPLAY "Enter your choice: ".
END PROGRAM Messages.