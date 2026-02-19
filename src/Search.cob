>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. Search.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT PROFILE-FILE ASSIGN TO "data/profiles.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT INPUT-FILE ASSIGN TO "data/InCollege-Input.txt"
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT OUTPUT-FILE ASSIGN TO "data/InCollege-Output.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

       SELECT PENDING-REQUESTS-FILE ASSIGN TO "data/PendingRequests.dat"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS LS-PENDING-STAT.

DATA DIVISION.
FILE SECTION.
FD     PROFILE-FILE.
01 PROFILE-RECORD.
       05 PR-USERNAME      PIC X(30).
       05 PR-NAME          PIC X(50).
       05 PR-UNIVERSITY    PIC X(50).
       05 PR-MAJOR         PIC X(50).
       05 PR-GRADYEAR      PIC 9(4).
       05 PR-ABOUT         PIC X(200).
       05 PR-JOBTITLE      PIC X(50) OCCURS 3 TIMES.
       05 PR-COMPANY       PIC X(50) OCCURS 3 TIMES.
       05 PR-DATES         PIC X(30) OCCURS 3 TIMES.
       05 PR-DESC          PIC X(200) OCCURS 3 TIMES.
       05 PR-DEGREE        PIC X(50) OCCURS 3 TIMES.
       05 PR-UNIV          PIC X(50) OCCURS 3 TIMES.
       05 PR-YEARS         PIC X(30) OCCURS 3 TIMES.
FD  INPUT-FILE.
01  IN-RECORD              PIC X(80).

FD  OUTPUT-FILE.
01  OUT-RECORD             PIC X(255).

FD PENDING-REQUESTS-FILE.
01 PENDING-REQUESTS-RECORD.
       05 SENDER-USERNAME      PIC X(30).
       05 RECIPIENT-USERNAME   PIC X(30).

WORKING-STORAGE SECTION.
01     WS-SEARCH-QUERY     PIC X(50).
01     WS-EOF-PROFILE      PIC X VALUE 'N'.
01     WS-EOF-REQ          PIC X VALUE 'N'.
01     WS-FOUND-FLAG       PIC X VALUE 'N'.
01     I                   PIC 9 VALUE 1.
01     WS-CONN-CHOICE      PIC X VALUE SPACES.
01     WS-RECIPIENT-USER   PIC X(30).
01     LS-PENDING-STAT     PIC XX.
01     WS-DUPLICATE-FOUND  PIC X VALUE 'N'.

LINKAGE SECTION.
01     LNK-USER-NAME       PIC X(30).

PROCEDURE DIVISION USING LNK-USER-NAME.
MAIN-LOGIC.
       OPEN INPUT PROFILE-FILE
       OPEN EXTEND OUTPUT-FILE
       MOVE "Enter the full name of the person you are looking for:" TO OUT-RECORD
       PERFORM DISPLAY-AND-WRITE

       ACCEPT WS-SEARCH-QUERY
       INSPECT WS-SEARCH-QUERY REPLACING ALL X'0D' BY SPACE
       INSPECT WS-SEARCH-QUERY REPLACING ALL X'0A' BY SPACE

       MOVE SPACES TO OUT-RECORD
       MOVE WS-SEARCH-QUERY TO OUT-RECORD
       PERFORM DISPLAY-AND-WRITE

       *>MOVE "Enter the full name of the person you are looking for:"
           *>TO OUT-RECORD
       *>PERFORM DISPLAY-AND-WRITE

       MOVE 'N' TO WS-EOF-PROFILE
       MOVE 'N' TO WS-FOUND-FLAG

       PERFORM UNTIL WS-EOF-PROFILE = 'Y' OR WS-FOUND-FLAG = 'Y'
           READ PROFILE-FILE
               AT END
                   MOVE 'Y' TO WS-EOF-PROFILE
               NOT AT END
                   IF FUNCTION TRIM(PR-NAME) = FUNCTION TRIM(WS-SEARCH-QUERY)
                       MOVE 'Y' TO WS-FOUND-FLAG
                       PERFORM DISPLAY-PROFILE

                       *> Hide the menu to send a request if user searches themself
                       IF FUNCTION TRIM(PR-USERNAME) NOT = FUNCTION TRIM(LNK-USER-NAME)

                           MOVE SPACES TO WS-CONN-CHOICE
                           PERFORM UNTIL WS-CONN-CHOICE = '1' OR WS-CONN-CHOICE = '2'
                               MOVE "1. Send Connection Request" TO OUT-RECORD
                               PERFORM DISPLAY-AND-WRITE
                               MOVE "2. Back to Main Menu" TO OUT-RECORD
                               PERFORM DISPLAY-AND-WRITE

                               ACCEPT WS-CONN-CHOICE

                               MOVE WS-CONN-CHOICE TO OUT-RECORD
                               PERFORM DISPLAY-AND-WRITE

                               IF WS-CONN-CHOICE = '1'
                                   PERFORM SEND-CONNECTION-LOGIC
                               ELSE IF WS-CONN-CHOICE = '2'
                                   CONTINUE
                               ELSE
                                   MOVE "Invalid input. Please enter 1 or 2." TO OUT-RECORD
                                   PERFORM DISPLAY-AND-WRITE
                               END-IF
                           END-PERFORM
                       ELSE
                           MOVE "This is your own profile." TO OUT-RECORD
                           PERFORM DISPLAY-AND-WRITE
                           *> potential bug fix if program doesn't wait and displays too quickly (uncomment lines below)
                           *> MOVE "Press Enter to return to menu..." TO OUT-RECORD
                           *> PERFORM DISPLAY-AND-WRITE
                           *> ACCEPT WS-CONN-CHOICE
                       END-IF
                   END-IF
           END-READ
       END-PERFORM

       IF WS-FOUND-FLAG = 'N'
           MOVE "No one by that name could be found." TO OUT-RECORD
           PERFORM DISPLAY-AND-WRITE
           *> potential bug fix if program doesn't wait and displays too quickly (uncomment lines below)
           *> MOVE "Press Enter to return to menu..." TO OUT-RECORD
           *> PERFORM DISPLAY-AND-WRITE
           *> ACCEPT WS-CONN-CHOICE
       END-IF

       CLOSE PROFILE-FILE
       CLOSE OUTPUT-FILE

       EXIT PROGRAM.

DISPLAY-PROFILE.
       MOVE " " TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       MOVE "--- Found User Profile ---" TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       
       STRING "Name: " FUNCTION TRIM(PR-NAME) INTO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       
       STRING "University: " FUNCTION TRIM(PR-UNIVERSITY) INTO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       
       STRING "Major: " FUNCTION TRIM(PR-MAJOR) INTO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       
       STRING "Graduation Year: " PR-GRADYEAR INTO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       
       STRING "About Me: " FUNCTION TRIM(PR-ABOUT) INTO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.

       MOVE "Experience: " TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
           IF PR-JOBTITLE(I) NOT = SPACES AND NOT = "None"
               STRING "  Title: " FUNCTION TRIM(PR-JOBTITLE(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
               STRING "  Company: " FUNCTION TRIM(PR-COMPANY(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
               STRING "  Dates: " FUNCTION TRIM(PR-DATES(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
               STRING "  Description: " FUNCTION TRIM(PR-DESC(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           END-IF
       END-PERFORM.

       MOVE "Education: " TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
           IF PR-DEGREE(I) NOT = SPACES AND NOT = "None"
               STRING "  Degree: " FUNCTION TRIM(PR-DEGREE(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
               STRING "  University: " FUNCTION TRIM(PR-UNIV(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
               STRING "  Years: " FUNCTION TRIM(PR-YEARS(I)) INTO OUT-RECORD
               PERFORM DISPLAY-AND-WRITE
           END-IF
       END-PERFORM.
       
       MOVE "-------------------------" TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.
       MOVE " " TO OUT-RECORD.
       PERFORM DISPLAY-AND-WRITE.

DISPLAY-AND-WRITE.
       DISPLAY FUNCTION TRIM(OUT-RECORD)
       *> uncomment the line below if output is not being written to InCollege-Output
       WRITE OUT-RECORD
       MOVE SPACES TO OUT-RECORD.

COPY "SendRequest.cpy".

END PROGRAM Search.