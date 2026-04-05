>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ViewMessages.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

       SELECT MESSAGE-FILE ASSIGN TO "data/Messages.dat"
       ORGANIZATION IS LINE SEQUENTIAL
       FILE STATUS IS WS-MESSAGE-FILE-STATUS.

DATA DIVISION.
FILE SECTION.
FD MESSAGE-FILE.
01 MESSAGE-RECORD.
       05 MESSAGE-SENDER       PIC X(30).
       05 MESSAGE-RECIPIENT    PIC X(30).
       05 MESSAGE-CONTENT      PIC X(200).
       05 MESSAGE-TIMESTAMP    PIC X(20).

WORKING-STORAGE SECTION.
01 WS-EOF-MSG              PIC X VALUE 'N'.
77 WS-MESSAGE-FILE-STATUS  PIC XX VALUE "00".
01 WS-MSG-COUNT            PIC 99 VALUE 0.

LINKAGE SECTION.
01 LNK-USER-NAME   PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.
MAIN.
       MOVE 0 TO WS-MSG-COUNT
       MOVE 'N' TO WS-EOF-MSG

       OPEN INPUT MESSAGE-FILE
       IF WS-MESSAGE-FILE-STATUS = "35"
           DISPLAY "--- Your Messages ---"
           DISPLAY "You have no messages at this time."
           DISPLAY "---------------------"
           GOBACK
       END-IF

       DISPLAY "--- Your Messages ---"
       PERFORM UNTIL WS-EOF-MSG = 'Y'
           READ MESSAGE-FILE
               AT END
                   MOVE 'Y' TO WS-EOF-MSG
               NOT AT END
                   IF WS-MSG-COUNT > 0
                       DISPLAY ""
                   END-IF

                   IF FUNCTION TRIM(MESSAGE-RECIPIENT) = FUNCTION TRIM(LNK-USER-NAME)
                       ADD 1 TO WS-MSG-COUNT
                       *> Message display format goes here
                       *> MESSAGE-SENDER
                       *> MESSAGE-CONTENT, MESSAGE-TIMESTAMP
                       DISPLAY "From: " FUNCTION TRIM(MESSAGE-SENDER)
                       DISPLAY "Message: " FUNCTION TRIM(MESSAGE-CONTENT)
                       DISPLAY "Sent: " FUNCTION TRIM(MESSAGE-TIMESTAMP)
                       DISPLAY "---" WITH NO ADVANCING
                   END-IF
           END-READ
       END-PERFORM

       CLOSE MESSAGE-FILE

       IF WS-MSG-COUNT = 0
           DISPLAY "You have no messages at this time."
           DISPLAY "---------------------"
       ELSE
           DISPLAY "------------------"
       END-IF

       GOBACK.
       
END PROGRAM ViewMessages.