>>SOURCE FORMAT FREE
       SEND-CONNECTION-LOGIC.
           *> Check if request already exists
           MOVE 'N' TO WS-DUPLICATE-FOUND
           OPEN INPUT PENDING-REQUESTS-FILE

           IF LS-PENDING-STAT = "35"
               *> fix: create if file does not exist
               OPEN OUTPUT PENDING-REQUESTS-FILE
               CLOSE PENDING-REQUESTS-FILE

               MOVE 'N' TO WS-DUPLICATE-FOUND
           ELSE
               MOVE 'N' TO WS-EOF-REQ
               PERFORM UNTIL WS-EOF-REQ = 'Y'
                   READ PENDING-REQUESTS-FILE
                       AT END
                           MOVE 'Y' TO WS-EOF-REQ
                       NOT AT END
                           IF (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(LNK-USER-NAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(PR-USERNAME)) OR (FUNCTION TRIM(SENDER-USERNAME) = FUNCTION TRIM(PR-USERNAME) AND FUNCTION TRIM(RECIPIENT-USERNAME) = FUNCTION TRIM(LNK-USER-NAME))
                               MOVE 'Y' TO WS-DUPLICATE-FOUND
                               MOVE 'Y' TO WS-EOF-REQ
                           END-IF
                   END-READ
               END-PERFORM
               CLOSE PENDING-REQUESTS-FILE
           END-IF

           IF WS-DUPLICATE-FOUND = 'Y'
               MOVE "You already have a pending connection with this user." TO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           ELSE
               OPEN EXTEND PENDING-REQUESTS-FILE
               MOVE SPACES TO PENDING-REQUESTS-RECORD
               MOVE LNK-USER-NAME TO SENDER-USERNAME
               MOVE PR-USERNAME TO RECIPIENT-USERNAME
               WRITE PENDING-REQUESTS-RECORD
               CLOSE PENDING-REQUESTS-FILE

               MOVE "Connection request sent successfully." TO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           END-IF.