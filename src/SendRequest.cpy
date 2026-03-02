>>SOURCE FORMAT FREE
       SEND-CONNECTION-LOGIC.
           *> Check if request already exists
           MOVE 'N' TO WS-DUPLICATE-FOUND
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
               START PENDING-REQUESTS-FILE KEY >= REQUEST-ID
                   INVALID KEY
                       MOVE 'Y' TO WS-EOF-REQ
               END-START

               PERFORM UNTIL WS-EOF-REQ = 'Y' OR WS-DUPLICATE-FOUND = 'Y'
                   IF (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(LNK-USER-NAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(PR-USERNAME)) OR (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(PR-USERNAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(LNK-USER-NAME))
                       MOVE 'Y' TO WS-DUPLICATE-FOUND
                       MOVE 'Y' TO WS-EOF-REQ
                   END-IF

                   READ PENDING-REQUESTS-FILE NEXT RECORD
                       AT END MOVE 'Y' TO WS-EOF-REQ
                   END-READ
               END-PERFORM

               CLOSE PENDING-REQUESTS-FILE
           END-IF

           IF WS-DUPLICATE-FOUND = 'Y'
               MOVE "You already have a pending connection with this user." TO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           ELSE
               PERFORM FIND-POSSIBLE-INDEX
               
               OPEN OUTPUT PENDING-REQUESTS-FILE
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
           END-IF.

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
           