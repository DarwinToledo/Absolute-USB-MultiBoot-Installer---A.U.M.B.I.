#===========================================================
# English File
# by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_ENGLISH}


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
        LangString Finish_Text              ${RODRILANG} "Your Selections have been $InUnStalled on your USB drive.$\r$\n$\r$\nFeel Free to run this tool again to $InUnStall more Distros.$\r$\n$\r$\nYUMI will keep track of selections you have already $InUnStalled."
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
        LangString CLICK_TO_ONLINEHELP      ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"

        LangString RL2_STEP1                ${RODRILANG} "Step 1: Select the Drive Letter of your USB Device."
        LangString SHOW_ALL_DRIVES2         ${RODRILANG} "Show All Drives?"
        LangString RL2_FORMAT               ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"
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

        ;LangString LABEL           ${RODRILANG} ""

!undef RODRILANG