>>SOURCE FORMAT FREE
       SEND-CONNECTION-LOGIC.
           *> Check if request already exists
           MOVE 'N' TO WS-DUPLICATE-FOUND
           MOVE 'N' TO WS-ALREADY-CONNECTED
           OPEN INPUT PENDING-REQUESTS-FILE

           IF LS-PENDING-STAT = "35"
               *> fix: create if file does not exist
               CLOSE PENDING-REQUESTS-FILE
               OPEN OUTPUT PENDING-REQUESTS-FILE
               CLOSE PENDING-REQUESTS-FILE
               
               MOVE 'N' TO WS-DUPLICATE-FOUND
           ELSE
               MOVE 'N' TO WS-EOF-REQ
               MOVE 0 TO REQUEST-ID
               READ PENDING-REQUESTS-FILE NEXT RECORD
                   AT END MOVE 'Y' TO WS-EOF-REQ
               END-READ

               PERFORM UNTIL WS-EOF-REQ = 'Y' OR WS-DUPLICATE-FOUND = 'Y'
                   IF (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(LNK-USER-NAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(PR-USERNAME)) OR (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(PR-USERNAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(LNK-USER-NAME))
                       MOVE 'Y' TO WS-DUPLICATE-FOUND
                   END-IF

                   READ PENDING-REQUESTS-FILE NEXT RECORD
                       AT END MOVE 'Y' TO WS-EOF-REQ
                   END-READ
               END-PERFORM

               CLOSE PENDING-REQUESTS-FILE
           END-IF

           OPEN INPUT ESTABLISHED-CONNECTIONS-FILE
           IF LS-ESTABLISHED-CONNECTIONS-STAT = "35"
               CLOSE ESTABLISHED-CONNECTIONS-FILE
               OPEN OUTPUT ESTABLISHED-CONNECTIONS-FILE
               CLOSE ESTABLISHED-CONNECTIONS-FILE

               MOVE 'N' TO WS-ALREADY-CONNECTED
           ELSE
               MOVE 'N' TO WS-EOF-CONNECTIONS
               PERFORM UNTIL WS-EOF-CONNECTIONS = 'Y' OR WS-ALREADY-CONNECTED = 'Y'
                   READ ESTABLISHED-CONNECTIONS-FILE
                       AT END
                           MOVE 'Y' TO WS-EOF-CONNECTIONS
                       NOT AT END
                           IF (FUNCTION TRIM(LNK-USER-NAME) = FUNCTION TRIM(CONNECTION-USER-ONE) AND FUNCTION TRIM(PR-USERNAME) = FUNCTION TRIM(CONNECTION-USER-TWO)) OR (FUNCTION TRIM(PR-USERNAME) = FUNCTION TRIM(CONNECTION-USER-ONE) AND FUNCTION TRIM(LNK-USER-NAME) = FUNCTION TRIM(CONNECTION-USER-TWO))
                               MOVE 'Y' TO WS-ALREADY-CONNECTED
                           END-IF
                   END-READ
               END-PERFORM
               CLOSE ESTABLISHED-CONNECTIONS-FILE
           END-IF

           EVALUATE TRUE
               WHEN WS-DUPLICATE-FOUND = 'Y'
                   MOVE "You already have a pending connection with this user." TO OUT-RECORD
                   PERFORM DISPLAY-AND-WRITE
               WHEN WS-ALREADY-CONNECTED = 'Y'
                   MOVE "You already have a connection with this user." TO OUT-RECORD
                   PERFORM DISPLAY-AND-WRITE
               WHEN OTHER
                   PERFORM FIND-POSSIBLE-INDEX
               
                   OPEN I-O PENDING-REQUESTS-FILE
                   MOVE SPACES TO PENDING-REQUESTS-RECORD
                   MOVE LS-MIN-AVAILABLE-INDEX TO REQUEST-ID
                   MOVE LNK-USER-NAME TO SENDER-USERNAME
                   MOVE PR-USERNAME TO RECIPIENT-USERNAME
    
                   WRITE PENDING-REQUESTS-RECORD
                       INVALID KEY
                           DISPLAY "Write Failed: " LS-PENDING-STAT
                   END-WRITE
                   
                   CLOSE PENDING-REQUESTS-FILE
    
                   MOVE "Connection request sent successfully." TO OUT-RECORD
                   PERFORM DISPLAY-AND-WRITE
           END-EVALUATE.

       FIND-POSSIBLE-INDEX.
           OPEN INPUT PENDING-REQUESTS-FILE
           PERFORM VARYING LS-POSSIBLE-REQUESTS-INDEX FROM 1 BY 1 UNTIL LS-POSSIBLE-REQUESTS-INDEX > 25 OR LS-FOUND-AVAILABLE-INDEX = 'Y'
                  MOVE LS-POSSIBLE-REQUESTS-INDEX TO REQUEST-ID
                  READ PENDING-REQUESTS-FILE
                       KEY IS REQUEST-ID
                       INVALID KEY
                           MOVE LS-POSSIBLE-REQUESTS-INDEX TO LS-MIN-AVAILABLE-INDEX
                           MOVE 'Y' TO LS-FOUND-AVAILABLE-INDEX
                  END-READ
           END-PERFORM
           CLOSE PENDING-REQUESTS-FILE.
           