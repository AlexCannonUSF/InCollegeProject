>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. ProfileEdit.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 PROFILE-EXISTS PIC X VALUE 'N'.

LINKAGE SECTION.
01 LNK-USER-NAME PIC X(20).

PROCEDURE DIVISION USING LNK-USER-NAME.

MAIN.
    *> Try to display profile (sets existence implicitly)
    CALL "PersonalProfile" USING LNK-USER-NAME

    *> Always allow overwrite/create
    DISPLAY "Proceeding to Create/Edit Profile..."
    CALL "ProfileCreate" USING LNK-USER-NAME

    DISPLAY "Profile saved successfully."
    GOBACK.

END PROGRAM ProfileEdit.