IDENTIFICATION DIVISION.
PROGRAM-ID. HomePage.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE PIC 9 VALUE 0.
01 EXIT-FLAG   PIC X VALUE 'N'.
77 WS-USER-CHOICE-LENGTH PIC 9(4) VALUE 1.
77 WS-LOG-TEXT PIC X(300) VALUE SPACES.

77 WS-PROFILE-COUNT PIC 9 VALUE 0.
01 WS-PROFILE-LIST.
    05 WS-PROF-ROW OCCURS 5 TIMES.
        10 WS-USERNAME    PIC X(30).
        10 WS-NAME        PIC X(50).
        10 WS-UNIVERSITY  PIC X(50).
        10 WS-MAJOR       PIC X(50).
        10 WS-GRADYEAR    PIC 9(4).
        10 WS-ABOUT       PIC X(200).
        10 WS-JOBTITLE    OCCURS 3 TIMES PIC X(50).
        10 WS-COMPANY     OCCURS 3 TIMES PIC X(50).
        10 WS-DATES       OCCURS 3 TIMES PIC X(30).
        10 WS-DESC        OCCURS 3 TIMES PIC X(200).
        10 WS-DEGREE      OCCURS 3 TIMES PIC X(50).
        10 WS-UNIV        OCCURS 3 TIMES PIC X(50).
        10 WS-YEARS       OCCURS 3 TIMES PIC X(30).

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    MOVE 'N' TO EXIT-FLAG
    MOVE 0   TO USER-CHOICE

    CALL "ProfileStore" USING "L" WS-PROFILE-COUNT WS-PROFILE-LIST

    DISPLAY "Welcome, " FUNCTION TRIM(LNK-USER-NAME) "!"
        MOVE SPACES TO WS-LOG-TEXT
        STRING "Welcome, " DELIMITED BY SIZE
                     FUNCTION TRIM(LNK-USER-NAME) DELIMITED BY SIZE
                     "!" DELIMITED BY SIZE
            INTO WS-LOG-TEXT
        END-STRING
        CALL "TestOutput" USING "A" WS-LOG-TEXT
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
                CALL "TestInput" USING WS-USER-CHOICE-LENGTH USER-CHOICE
        DISPLAY USER-CHOICE
                MOVE SPACES TO WS-LOG-TEXT
                STRING FUNCTION TRIM(USER-CHOICE) DELIMITED BY SIZE
                    INTO WS-LOG-TEXT
                END-STRING
                CALL "TestOutput" USING "A" WS-LOG-TEXT

        EVALUATE USER-CHOICE
            WHEN 1
                CALL "ProfileEdit" USING LNK-USER-NAME
                                        WS-PROFILE-COUNT
                                        WS-PROFILE-LIST
                CALL "ProfileStore" USING "S"
                                        WS-PROFILE-COUNT
                                        WS-PROFILE-LIST
            WHEN 2
                CALL "PersonalProfile" USING LNK-USER-NAME
                                            WS-PROFILE-COUNT
                                            WS-PROFILE-LIST
            WHEN 3
                CALL "Jobs" USING LNK-USER-NAME
            WHEN 4
                Call "Search" USING LNK-USER-NAME
            WHEN 5
                CALL "ViewRequests" USING LNK-USER-NAME
            WHEN 6
                CALL "ViewNetwork" USING LNK-USER-NAME
            WHEN 7
                CALL "SkillMenu"
            WHEN 8
                CALL "Messages" USING LNK-USER-NAME
            WHEN 9
                MOVE 'Y' TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
                MOVE "Invalid choice. Please try again." TO WS-LOG-TEXT
                CALL "TestOutput" USING "A" WS-LOG-TEXT
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-MENU.
    DISPLAY "1. Create/Edit My Profile"
    MOVE "1. Create/Edit My Profile" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "2. View My Profile"
    MOVE "2. View My Profile" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "3. Job search/internship"
    MOVE "3. Job search/internship" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "4. Find someone you know"
    MOVE "4. Find someone you know" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "5. View my pending connection requests"
    MOVE "5. View my pending connection requests" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "6. View my network"
    MOVE "6. View my network" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "7. Learn a new skill"
    MOVE "7. Learn a new skill" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "8. Messages"
    MOVE "8. Messages" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "9. Logout"
    MOVE "9. Logout" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT
    DISPLAY "Enter your choice:".
    MOVE "Enter your choice:" TO WS-LOG-TEXT
    CALL "TestOutput" USING "A" WS-LOG-TEXT.

END PROGRAM HomePage.
