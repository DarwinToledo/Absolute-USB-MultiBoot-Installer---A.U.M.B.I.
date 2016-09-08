#===========================================================
# English Language File
# (c)2016 by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_ENGLISH}

        LangString COMPLETED_TEXT           ${RODRILANG} "All Finished, Process is Complete!"

        LangString License_Subtitle         ${RODRILANG} "Please review the license terms before proceeding"
        LangString License_Text_Top         ${RODRILANG} "The software within this program falls under the following Licenses."
        LangString License_Text_Bottom      ${RODRILANG} "You must accept the terms of this License agreement to run this ${NAME}. If you agree, Click I Agree to Continue."
        LangString SelectDist_Title         ${RODRILANG} "Drive Selection and Distro Options Page"
        LangString SelectDist_Subtitle      ${RODRILANG} "Choose your Flash Drive, and a Distro, ISO/ZIP file.$\r$\nAdditional Distributions can be added each time this tool is run."
        LangString DrivePage_Text           ${RODRILANG} "Step 1: Select the drive letter of your USB device."
        LangString Distro_Text              ${RODRILANG} "Step 2: Select a Distribution from the list to put on your USB."
        LangString IsoPage_Text             ${RODRILANG} "Step 3: Select the $FileFormat (Name must be the same as above)."
        LangString IsoPage_Title            ${RODRILANG} "Select Your $FileFormat"
        LangString Casper_Text              ${RODRILANG} "Step 4: Set a Persistent file size for storing changes (Optional)."
        LangString IsoFile                  ${RODRILANG} "$FileFormat file|$ISOFileName" ;$ISOFileName variable previously *.iso
        LangString Extract                  ${RODRILANG} "Extracting the $FileFormat: The progress bar will not move until finished. Please be patient..."
        LangString CreateSysConfig          ${RODRILANG} "Creating configuration files for $DestDisk"
        LangString ExecuteSyslinux          ${RODRILANG} "Executing syslinux on $BootDir"
        LangString SkipSyslinux             ${RODRILANG} "Good Syslinux Exists..."
        LangString WarningSyslinux          ${RODRILANG} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable..."
        LangString WarningSyslinuxOLD       ${RODRILANG} "This YUMI revision uses a newer Syslinux version that is not compatible with earlier revisions.$\r$\nPlease ensure your USB drive doesn't contain earlier revision installs."
        LangString Install_Title            ${RODRILANG} "$InUnStall $ISOFileName"
        LangString Install_SubTitle         ${RODRILANG} "Please wait while we $InUnStall $DistroName on $JustDrive"
        LangString Install_Finish_Sucess    ${RODRILANG} "${NAME} sucessfully $InUnStalled $DistroName on $JustDrive"
        LangString Finish_Install           ${RODRILANG} "$InUnStallation is Complete."
        LangString Finish_Title             ${RODRILANG} "${NAME} has completed the $InUnStallation."
        LangString Finish_Text              ${RODRILANG} "Your Selections have been $InUnStalled on your USB drive.$\r$\n$\r$\nFeel Free to run this tool again to $InUnStall more Distros.$\r$\n$\r$\n${NAME} will keep track of selections you have already $InUnStalled."
        LangString Finish_Link              ${RODRILANG} "Visit the ${NAME} Tutorial Page"
        LangString Create_Button            ${RODRILANG} "Create"

        LangString VIEW_ONREM_DISTROS       ${RODRILANG} "View or Remove Installed Distros?"
        LangString DOWNLOAD_ISOOP           ${RODRILANG} "Download the ISO (Optional)."
        LangString SHOW_ALL_ISOS            ${RODRILANG} "Show All ISOs?"
        LangString RL_BROWSE                ${RODRILANG} "Browse"
        LangString RL_VISIST_OFHOME         ${RODRILANG} "Visit the $OfficialName HomePage"
        LangString BROW_AND_SELFORM         ${RODRILANG} "Browse to and select the $FileFormat"
        LangString RL1_STEP1                ${RODRILANG} "Step 1: ${NAME} Summoned $DestDisk as your USB Device"
        LangString SHOW_ALL_DRIVES          ${RODRILANG} "Show All Drives?"
        LangString VIEW_OR_REMOVEDISTROS    ${RODRILANG} "View or Remove Installed Distros?"
        LangString VIEW_OR_REMOVEDISTROS2   ${RODRILANG} "View or Remove Installed Distros?"
        LangString CLICK_TO_ONLINEHELP      ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"

        LangString RL2_STEP1                ${RODRILANG} "Step 1: Select the Drive Letter of your USB Device."
        LangString SHOW_ALL_DRIVES2         ${RODRILANG} "Show All Drives?"
        LangString RL2_FORMAT               ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"
        LangString RL2_FORMAT2              ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"
        LangString SHOW_ALL_ISOS2           ${RODRILANG} "Show All ISOs?"
        LangString DOWNLOAD_ISOOP2          ${RODRILANG} "Download the ISO (Optional)."
        LangString RL_VISIST_OFHOME2        ${RODRILANG} "Visit the $OfficialName HomePage"
        LangString BROW_AND_SELFORM2        ${RODRILANG} "Browse to and select the $FileFormat"
        LangString RL_BROWSE2               ${RODRILANG} "Browse"
        LangString CLICK_TO_ONLINEHELP2     ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"
        LangString RL2_SHOWING              ${RODRILANG} "Showing All Drives"
        LangString RL2_SHOWALL              ${RODRILANG} "Show All Drives?"
        LangString RL_ODL                   ${RODRILANG} "Opened Download Link"
        LangString RL_DL1                   ${RODRILANG} "Download Link"

        LangString MENU_LABEL_LUNIX_DIST    ${RODRILANG} "Linux Distributions"
        LangString MENU_LABEL_SYS_TOOLS     ${RODRILANG} "System Tools"
        LangString MENU_LABEL_ANTIVIR       ${RODRILANG} "Antivirus Tools"
        LangString MENU_LABEL_NETBOOK       ${RODRILANG} "Netbook Distributions"
        LangString MENU_LABEL_OTHER_OS      ${RODRILANG} "Other OS and Tools"
        LangString MENU_LABEL_UNLISTED      ${RODRILANG} "Unlisted ISO (via SYSLINUX)"
        LangString MENU_LABEL_GRUB          ${RODRILANG} "GRUB Bootable ISOs"
        LangString MENU_LABEL_GRUB_LARGE    ${RODRILANG} "GRUB Bootable ISOs and Windows XP/7/8"

        LangString MB_DL2                   ${RODRILANG} "Launch the Download Link?$\r$\nLet the download finish before moving to step 2."
        LangString RL_DL2                   ${RODRILANG} "Download Link"
        LangString RL2_STEP3                ${RODRILANG} "Step 3: Once your download has finished, Browse and select the ISO."
        LangString BW2_STEP3                ${RODRILANG} "Step 3: Browse and Select your $ISOFileName"
        LangString BW_ISO_1                 ${RODRILANG} "Browse to your $ISOFileName  -->"
        LangString VTO_HOME1                ${RODRILANG} "Visit the $OfficialName Home Page"
        LangString WE_SELECT1               ${RODRILANG} "We Found and Selected the $SomeFileExt."
        LangString DONE_STEP3               ${RODRILANG} "Step 3 DONE: $ISOFileName Found and Selected!"
        LangString RL_DL3                   ${RODRILANG} "Download Link"

        LangString BW_ISO_2                 ${RODRILANG} "Browse to and select the $ISOFileName"
        LangString PEND_STEP3               ${RODRILANG} "Step 3 PENDING: Browse to your $ISOFileName"
        LangString RL_DL4                   ${RODRILANG} "Download Link"

        LangString LOCAL_SOMEFILE_SEL       ${RODRILANG} "Local $SomeFileExt Selected."
        LangString JUST_ISONAME_ALREDY      ${RODRILANG} "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!"
        LangString STEP_2_SELADISTRIB       ${RODRILANG} "Step 2: Select a Distribution to put on $DestDisk"
        LangString BUTTON_REMOVE_TEXT       ${RODRILANG} "Remove"
        LangString YOURE_UNISTALLERMODE     ${RODRILANG} "You're in Uninstaller Mode!"
        LangString STEP2_DESTINATIONDISK    ${RODRILANG} "Step 2: Select a Distribution to remove from $DestDisk"
        LangString STEP3_SELECTISOFILEVAR   ${RODRILANG} "Step 3: Select your $ISOFileName"
        LangString DISABLE_AFTER_STEP2      ${RODRILANG} "Disabled until step 2 is complete"
        LangString BUTTON_CREATE_TEXT       ${RODRILANG} "Create"
        LangString STEP2_SELECTADISTRO      ${RODRILANG} "Step 2: Select a Distribution to put on $DestDisk"

        LangString STEP1_DESTUSBDEV         ${RODRILANG} "Step 1: You Selected $DestDisk as your USB Device"
        LangString FORMATING_TEXTDISK       ${RODRILANG} "Formatting $DestDisk as Fat32 using Fat32format.exe"
        LangString WEWILL_FAT32             ${RODRILANG} "We Will Fat32 Format $DestDisk Drive!"
        LangString FORMAT_DESTDIST_DRIVE    ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"
        LangString S_SHOW_ALLISOS           ${RODRILANG} "Show All ISOs!"
        LangString SS_SHOW_ALLISOS          ${RODRILANG} "Show All ISOs?"

        LangString STEP_2_REMOVEFROMLIST    ${RODRILANG} "Step 2: Select a Distribution from the list to remove from $DestDisk"

!undef RODRILANG