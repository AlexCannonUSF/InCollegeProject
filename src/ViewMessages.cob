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
       05 MESSAGE-TIMESTAMP    PIC X(25).

WORKING-STORAGE SECTION.
01 WS-EOF-MSG              PIC X VALUE 'N'.
77 WS-MESSAGE-FILE-STATUS  PIC XX VALUE "00".

LOCAL-STORAGE SECTION.
01 LS-MSG-COUNT            PIC 99 VALUE 0.
01 LS-RECEIVED-MESSAGES    OCCURS 0 TO 1000 DEPENDING ON LS-MSG-COUNT.
       05 LS-MESSAGE-SENDER       PIC X(30).
       05 LS-MESSAGE-RECIPIENT    PIC X(30).
       05 LS-MESSAGE-CONTENT      PIC X(200).
       05 LS-MESSAGE-TIMESTAMP    PIC X(25).
       05 LS-MESSAGE-MONTH        PIC 9(2).
       05 LS-MESSAGE-DAY          PIC 9(2).
       05 LS-MESSAGE-YEAR         PIC 9(4).
       05 LS-MESSAGE-HOUR         PIC 9(2).
       05 LS-MESSAGE-MINUTE       PIC 9(2).
       05 LS-MESSAGE-SECOND       PIC 9(2).
01 LS-INDEX              PIC 9(4) VALUE 0.

LINKAGE SECTION.
01 LNK-USER-NAME   PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.
MAIN.
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
                   IF FUNCTION TRIM(MESSAGE-RECIPIENT) = FUNCTION TRIM(LNK-USER-NAME)
                       ADD 1 TO LS-MSG-COUNT
                       *> Message display format goes here
                       *> MESSAGE-SENDER
                       *> MESSAGE-CONTENT, MESSAGE-TIMESTAMP
*> 
                       MOVE FUNCTION TRIM(MESSAGE-SENDER) TO LS-MESSAGE-SENDER(LS-MSG-COUNT)
                       MOVE FUNCTION TRIM(MESSAGE-RECIPIENT) TO LS-MESSAGE-RECIPIENT(LS-MSG-COUNT)
                       MOVE FUNCTION TRIM(MESSAGE-CONTENT) TO LS-MESSAGE-CONTENT(LS-MSG-COUNT)
                       MOVE FUNCTION TRIM(MESSAGE-TIMESTAMP) TO LS-MESSAGE-TIMESTAMP(LS-MSG-COUNT)

                       UNSTRING FUNCTION TRIM(MESSAGE-TIMESTAMP)
                           DELIMITED BY "/" OR " @ " OR ":"
                           INTO
                               LS-MESSAGE-MONTH(LS-MSG-COUNT), 
                               LS-MESSAGE-DAY(LS-MSG-COUNT),
                               LS-MESSAGE-YEAR(LS-MSG-COUNT),
                               LS-MESSAGE-HOUR(LS-MSG-COUNT),
                               LS-MESSAGE-MINUTE(LS-MSG-COUNT),
                               LS-MESSAGE-SECOND(LS-MSG-COUNT)
                       END-UNSTRING
                   END-IF
           END-READ
       END-PERFORM

       CLOSE MESSAGE-FILE

       SORT LS-RECEIVED-MESSAGES ON DESCENDING LS-MESSAGE-YEAR LS-MESSAGE-MONTH LS-MESSAGE-DAY LS-MESSAGE-HOUR LS-MESSAGE-MINUTE

       PERFORM VARYING LS-INDEX FROM 1 BY 1 UNTIL LS-INDEX > LS-MSG-COUNT
           DISPLAY "From: " LS-MESSAGE-SENDER(LS-INDEX)
           DISPLAY "Message: " FUNCTION TRIM(LS-MESSAGE-CONTENT(LS-INDEX))
           DISPLAY "Sent: " LS-MESSAGE-TIMESTAMP(LS-INDEX)
           IF LS-INDEX < LS-MSG-COUNT
               DISPLAY "---"
           END-IF
       END-PERFORM

       IF LS-MSG-COUNT = 0
           DISPLAY "You have no messages at this time."
           DISPLAY "---------------------"
       ELSE
           DISPLAY "---------------------"
       END-IF

       GOBACK.
       
END PROGRAM ViewMessages.