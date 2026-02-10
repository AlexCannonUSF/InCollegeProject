>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. CreateAccount.

DATA DIVISION.
WORKING-STORAGE SECTION.

77 WS-USERNAME PIC X(10) VALUE SPACES.
77 WS-PASSWORD PIC X(20) VALUE SPACES.

77 WS-ATTEMPTS PIC 9 VALUE 0.
77 WS-MAX-ATTEMPTS PIC 9 VALUE 10.
77 WS-OK PIC X VALUE "N".

77 WS-LIMIT-ACCOUNTS PIC 9(2) VALUE 10.

LINKAGE SECTION.
01 LK-STORED.
   05 LK-STORED-USERNAME PIC X(10) OCCURS 10 TIMES.
   05 LK-STORED-PASSWORD PIC X(20) OCCURS 10 TIMES.
01 LK-STORED-COUNT PIC 9(2).
01 LK-CREATE-SUCCESS PIC X.

PROCEDURE DIVISION USING LK-STORED LK-STORED-COUNT LK-CREATE-SUCCESS.
SIGNUP-FLOW.
    IF LK-STORED-COUNT >= WS-LIMIT-ACCOUNTS
        DISPLAY "All permitted accounts have been created, please come back later."
        MOVE "N" TO LK-CREATE-SUCCESS
        GOBACK
    END-IF

    MOVE 0 TO WS-ATTEMPTS
    PERFORM UNTIL WS-OK = "Y"
        DISPLAY "Enter a username: "
        ACCEPT WS-USERNAME
        ADD 1 TO WS-ATTEMPTS
        IF WS-ATTEMPTS > WS-MAX-ATTEMPTS
            DISPLAY "Too many attempts. Returning to menu."
            MOVE "N" TO LK-CREATE-SUCCESS
            GOBACK
        END-IF

        CALL "DataStore" USING LK-STORED LK-STORED-COUNT WS-USERNAME WS-PASSWORD WS-OK
        IF WS-OK = "N"
            DISPLAY "That username is already taken."
        END-IF
    END-PERFORM

    MOVE 0 TO WS-ATTEMPTS
    MOVE "N" TO WS-OK
    PERFORM UNTIL WS-OK = "Y"
        DISPLAY "Enter password: "
        ACCEPT WS-PASSWORD
        ADD 1 TO WS-ATTEMPTS
        IF WS-ATTEMPTS > WS-MAX-ATTEMPTS
            DISPLAY "Too many attempts. Returning to menu."
            MOVE "N" TO LK-CREATE-SUCCESS
            GOBACK
        END-IF

        IF WS-PASSWORD = SPACES OR WS-PASSWORD = ""
            DISPLAY ""
            DISPLAY "Password cannot be blank."
            MOVE "N" TO WS-OK
        ELSE
            IF FUNCTION LENGTH(FUNCTION TRIM(WS-PASSWORD)) < 8
                DISPLAY "Password does not meet requirements."
                MOVE "N" TO WS-OK
            ELSE
                IF WS-PASSWORD = "password"
                    DISPLAY "Password does not meet requirements."
                    MOVE "N" TO WS-OK
                ELSE
                    IF WS-PASSWORD = "Password"
                        DISPLAY "Password does not meet requirements."
                        MOVE "N" TO WS-OK
                    ELSE
                        IF WS-PASSWORD = "PASSWORD"
                            DISPLAY "Password does not meet requirements."
                            MOVE "N" TO WS-OK
                        ELSE
                            MOVE "Y" TO WS-OK
                        END-IF
                    END-IF
                END-IF
            END-IF
        END-IF
    END-PERFORM

    ADD 1 TO LK-STORED-COUNT
    MOVE WS-USERNAME TO LK-STORED-USERNAME(LK-STORED-COUNT)
    MOVE WS-PASSWORD TO LK-STORED-PASSWORD(LK-STORED-COUNT)
    DISPLAY "Account created successfully!"
    MOVE "Y" TO LK-CREATE-SUCCESS
    GOBACK.