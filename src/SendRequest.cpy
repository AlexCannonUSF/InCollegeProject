>>SOURCE FORMAT FREE
       SEND-CONNECTION-LOGIC.
           *> Check if request already exists
           MOVE 'N' TO WS-DUPLICATE-FOUND
           OPEN INPUT PENDING-REQUESTS-FILE

           IF LS-PENDING-STAT = "35"
               MOVE 'N' TO WS-DUPLICATE-FOUND
               MOVE "00" TO LS-PENDING-STAT
           ELSE
               MOVE 'N' TO WS-EOF-REQ
               PERFORM UNTIL WS-EOF-REQ = 'Y'
                   READ PENDING-REQUESTS-FILE
                       AT END MOVE 'Y' TO WS-EOF-REQ
                       NOT AT END
                           IF (SENDER-USERNAME = LNK-USER-NAME AND RECIPIENT-USERNAME = PR-USERNAME) OR (SENDER-USERNAME = PR-USERNAME AND RECIPIENT-USERNAME = LNK-USER-NAME)
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
               MOVE LNK-USER-NAME TO SENDER-USERNAME
               MOVE PR-USERNAME TO RECIPIENT-USERNAME
               WRITE PENDING-REQUESTS-RECORD
               CLOSE PENDING-REQUESTS-FILE

               MOVE "Connection request sent successfully." TO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           END-IF