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

!undef RODRILANG