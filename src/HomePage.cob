IDENTIFICATION DIVISION.
PROGRAM-ID. HomePage.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 USER-CHOICE PIC 9 VALUE 0.
01 EXIT-FLAG   PIC X VALUE 'N'.

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
    PERFORM UNTIL EXIT-FLAG = 'Y'
        PERFORM DISPLAY-MENU
        ACCEPT USER-CHOICE
        DISPLAY USER-CHOICE

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
                DISPLAY "Search for a job is under construction."
            WHEN 4
                Call "Search"
            WHEN 5
                CALL "ViewRequests" USING LNK-USER-NAME
            WHEN 6
                CALL "SkillMenu"
            WHEN 7
                MOVE 'Y' TO EXIT-FLAG
            WHEN OTHER
                DISPLAY "Invalid choice. Please try again."
        END-EVALUATE
    END-PERFORM
    GOBACK.

DISPLAY-MENU.
    DISPLAY "1. Create/Edit My Profile"
    DISPLAY "2. View My Profile"
    DISPLAY "3. Search for a job"
    DISPLAY "4. Find someone you know"
    DISPLAY "5. View my pending connection requests"
    DISPLAY "6. Learn a new skill"
    DISPLAY "7. Logout"
    DISPLAY "Enter your choice:".

END PROGRAM HomePage.