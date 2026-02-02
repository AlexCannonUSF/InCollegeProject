>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ProfileEdit.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ProfileFile ASSIGN TO "data/profiles.dat"
        ORGANIZATION IS SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD ProfileFile.
01 Profile-Record.
   05 Username   PIC X(20).
   05 Name       PIC X(50).
   05 University PIC X(50).
   05 Major      PIC X(50).
   05 GradYear   PIC 9(4).
   05 About      PIC X(200).
   05 JobTitle   OCCURS 3 TIMES PIC X(50).
   05 Company    OCCURS 3 TIMES PIC X(50).
   05 Dates      OCCURS 3 TIMES PIC X(30).
   05 Desc       OCCURS 3 TIMES PIC X(200).
   05 Degree     OCCURS 3 TIMES PIC X(50).
   05 Univ       OCCURS 3 TIMES PIC X(50).
   05 Years      OCCURS 3 TIMES PIC X(30).

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    OPEN OUTPUT ProfileFile
    MOVE LNK-USER-NAME TO Username

    DISPLAY "Editing profile..."
    DISPLAY "Enter full name:"
    ACCEPT Name
    DISPLAY "Enter university:"
    ACCEPT University
    DISPLAY "Enter major:"
    ACCEPT Major
    DISPLAY "Enter graduation year (YYYY):"
    ACCEPT GradYear
    DISPLAY "Enter About Me:"
    ACCEPT About

    DISPLAY "Enter job title:"
    ACCEPT JobTitle(1)
    DISPLAY "Enter company:"
    ACCEPT Company(1)
    DISPLAY "Enter dates:"
    ACCEPT Dates(1)
    DISPLAY "Enter description:"
    ACCEPT Desc(1)

    DISPLAY "Enter degree:"
    ACCEPT Degree(1)
    DISPLAY "Enter university:"
    ACCEPT Univ(1)
    DISPLAY "Enter years attended:"
    ACCEPT Years(1)

    WRITE Profile-Record
    CLOSE ProfileFile

    DISPLAY "Profile updated successfully."
    GOBACK.

END PROGRAM ProfileEdit.