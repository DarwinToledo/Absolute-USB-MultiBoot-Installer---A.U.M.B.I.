#===========================================================
#SELECTIONS PAGE FUNCTIONS 2
#===========================================================

; On Selection of Linux Distro
Function OnSelectDistro
  Pop $Distro

  ${If} $Removal == "Yes"
   ShowWindow $ForceShowAll 0
  ${Else}
   ShowWindow $ForceShowAll 1
  ${EndIf}

  ${NSD_GetText} $Distro $DistroName ; Was ${NSD_LB_GetSelection} $Distro $DistroName
  StrCpy $DistroName "$DistroName"
  StrCpy $Checker "No"
  ${If} $Removal == "Yes"
  StrCpy $ISOFileName "$DistroName"
  StrCpy $ISOTest "$DistroName"
  ${Else}
  Call SetISOFileName
  StrCpy $ISOFileName "$ISOFileName"
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or iso?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, iso etc...
  ${NSD_SetText} $LabelISOSelection "$(BW2_STEP3)"
  ${NSD_SetText} $ISOFileTxt "$(BW_ISO_1)"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made
  ${EndIf}

; Redraw Home page Links as necessary
  ${NSD_SetText} $DistroLink "$(VTO_HOME1)"
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "Yes"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}

; Autodetect ISO's in same folder and select if they exist
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${StrContains} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"
  ${GetFileName} "$TheISO" $JustISO
  ${GetBaseName} "$JustISO" $JustISOName
  ${GetParent} "$TheISO" $JustISOPath
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "$(WE_SELECT1)"
  EnableWindow $ISOSelection 0
  SetCtlColors $ISOFileTxt 009900 FFFFFF
  ${NSD_SetText} $ISOFileTxt $ISOFile
  ${NSD_SetText} $LabelISOSelection "$(DONE_STEP3)"
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next
  Call EnableNext

 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${AndIf} $WILD == "*"
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO
  ${NSD_SetText} $DownloadISO "$(RL_DL3)"
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF
  ${NSD_SetText} $ISOFileTxt "$(BW_ISO_2)"
  ${NSD_SetText} $LabelISOSelection "$(PEND_STEP3)"
  Call EnableNext

 ${Else}
  Call EnableNext
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO
  ${NSD_SetText} $DownloadISO "$(RL_DL4)"
 ${EndIf}

 ${If} $DownLink == "NONE"
  ${OrIf} $Removal == "Yes"
  ShowWindow $DownloadISO 0
 ${Else}
  ShowWindow $DownloadISO 1
 ${EndIf}

FunctionEnd

; On Selection of ISO File
Function ISOBrowse
 ${If} $ShowingAll == "Yes"
  StrCpy $ISOFileName "*.iso"
 ${ElseIf} $ShowingAll != "Yes"
  Call SetISOFileName
 ${EndIf}

 nsDialogs::SelectFileDialog open "" $(IsoFile)
 Pop $TheISO
 ${NSD_SetText} $ISOFileTxt $TheISO
 SetCtlColors $ISOFileTxt 009900 FFFFFF
 EnableWindow $DownloadISO 0
 ${NSD_SetText} $DownloadISO "$(LOCAL_SOMEFILE_SEL)"
 StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next
 StrCpy $ISOFile "$TheISO"
 ${GetFileName} "$TheISO" $JustISO
 ${GetBaseName} "$JustISO" $JustISOName
 ${GetParent} "$TheISO" $JustISOPath
 StrCpy $LocalSelection "Yes"
  Call SetISOSize
  Call SetSpace
  Call CheckSpace
  Call HaveSpacePre
 ${If} $JustISOName == ""
 StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
 ${EndIf}

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "Yes"
 MessageBox MB_OK "$(JUST_ISONAME_ALREDY)"
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BootDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
 FunctionEnd

Function ClearAll
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function InstallorRemove ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "Yes"
  Call RemovalList
  ${Else}
   ${NSD_SetText} $LinuxDistroSelection "$(STEP_2_SELADISTRIB)"
  Call SetISOFileName
  ${EndIf}
FunctionEnd

; On Selection of Uninstaller Option
Function Uninstall
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
    ShowWindow $LabelISOSelection 0
	Call ClearAll
    EnableWindow $ISOFileTxt 0
	ShowWindow $ISOFileTxt 0
	ShowWindow $ISOSelection 0
    ShowWindow $ForceShowAll 0
    ShowWindow $CasperSelection 0
    ShowWindow $CasperSlider 0
    ShowWindow $SlideSpot 0
	StrCpy $Persistence "NULL"

  ${NSD_Check} $Uninstaller
  StrCpy $Removal "Yes"
  ShowWindow $DistroLink 0
  ShowWindow $DownloadISO 0
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	SendMessage $6 ${WM_SETTEXT} 0 "STR:$(BUTTON_REMOVE_TEXT)"
	EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_SetText} $Uninstaller "$(YOURE_UNISTALLERMODE)"
   ${NSD_SetText} $LinuxDistroSelection "$(STEP2_DESTINATIONDISK)"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"
	 Call RemovalList

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1
    ShowWindow $LabelISOSelection 1
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	Call ClearAll
    ${NSD_SetText} $LabelISOSelection "$(STEP3_SELECTISOFILEVAR)"
	${NSD_SetText} $ISOFileTxt "$(DISABLE_AFTER_STEP2)"
     GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	  SendMessage $6 ${WM_SETTEXT} 0 "STR:$(BUTTON_CREATE_TEXT)"
	  EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_Uncheck} $Uninstaller
  StrCpy $Removal "No"
  ${NSD_SetText} $Uninstaller "$(VIEW_OR_REMOVEDISTROS2)"
   ${NSD_SetText} $LinuxDistroSelection "$(STEP2_SELECTADISTRO)"
     SendMessage $Distro ${CB_RESETCONTENT} 0 0  ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"
     Call SetISOFileName
  ${EndIf}
FunctionEnd

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BootDir $DestDrive 2 ;was -1
  StrCpy $DestDisk $DestDrive 2 ;was -1
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes"
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt
  Call EnableNext

  ${NSD_SetText} $LabelDrivePage "$(STEP1_DESTUSBDEV)"

;  ${If} ${FileExists} $BootDir\menu.lst
;  ${AndIf} ${FileExists} $BootDir\syslinux.cfg
;  MessageBox MB_ICONQUESTION|MB_OK "It appears MultibootISOs was previously used on this drive? To use ${NAME} on this device, you must format the drive."
;  ${EndIf}
FunctionEnd

Function GetDiskVolumeName
;Pop $1 ; get parameter
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$9",.r0,1024,,,,,1024)' ;

;Push $0 ; Push result
${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}
FunctionEnd ; GetDiskVolumeName

Function DiskSpace
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
${EndIf}
FunctionEnd

Function DrivesList
 Call GetDiskVolumeName
 Call DiskSpace
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 $VolName $Capacity"
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function FormatYes ; If Format is checked, do something
  ${If} $FormatMe == "Yes"

; Close All Open Explorer Windows
  ;DetailPrint "Closing All Open Explorer Windows"
  ;FindWindow $R0 CabinetWClass
  ;IsWindow $R0 0 +3
  ;SendMessage $R0 ${WM_SYSCOMMAND} 0xF060 0
  ;Goto -3

  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\fat32format.exe "fat32format.exe"
  DetailPrint "$(FORMATING_TEXTDISK)"
  nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
  ;nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format -c$BlockSize $DestDisk"' ;/Q /y
  ${EndIf}
FunctionEnd

Function FormatIt ; Set Format Option
  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
    StrCpy $FormatMe "Yes"
  ${NSD_SetText} $Format "$(WEWILL_FAT32)"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "Yes"

  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  ${NSD_SetText} $Format "$(FORMAT_DESTDIST_DRIVE)"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "Yes"
	Call SetSpace
  ${EndIf}
    Call InstallorRemove
FunctionEnd

Function ShowAllISOs ; Set Show All ISOs Option
  ${NSD_GetState} $ForceShowAll $ShowingAll
  ${If} $ShowingAll == ${BST_CHECKED}
  ${NSD_Check} $ForceShowAll
  StrCpy $ShowingAll "Yes"
  ${NSD_SetText} $ForceShowAll "$(S_SHOW_ALLISOS)"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0

  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "$(SS_SHOW_ALLISOS)"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0
  ${EndIf}
FunctionEnd

Function CheckSpace ; Check total available space so we can set block size
  Call TotalSpace
  ${If} $1 <= 511
  StrCpy $BlockSize 1
  ${ElseIf} $1 >= 512
  ${AndIf} $1 <= 8191
  StrCpy $BlockSize 4
  ${ElseIf} $1 >= 8192
  ${AndIf} $1 <= 16383
  StrCpy $BlockSize 8
  ${ElseIf} $1 >= 16384
  ${AndIf} $1 <= 32767
  StrCpy $BlockSize 16
  ${ElseIf} $1 > 32768
  StrCpy $BlockSize 32
  ${EndIf}
 ; MessageBox MB_ICONSTOP|MB_OK "$0 Drive is $1 MB in size, blocksize = $BlockSize KB."
FunctionEnd

Function TotalSpace
${DriveSpace} "$JustDrive" "/D=T /S=M" $1 ; used to find total space of select disk
 StrCpy $Capacity "$1"
FunctionEnd

Function FreeDiskSpace
${If} $FormatMe == "Yes"
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function SetSpace ; Set space available for persistence
  ;StrCpy $0 '$0'
  Call FreeDiskSpace
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
 ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
  StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
 ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
 ${EndIf}
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value
FunctionEnd

Function HaveSpacePre ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive."
  okay: ; Proceed to execute...
FunctionEnd

Function HaveSpace ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Not enough free space remains. Closing ${NAME}!"
  quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
  ;MessageBox MB_OK "ISO + Persistence will use $SizeOfCasper MB of the $1 MB Free disk space on $JustDrive Drive."
  ;quit ; enable for testing message above
FunctionEnd

!macro DeleteMenuEntry file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from
Push "${STOP}$\r$\n" ; text to stop at
Call DeleteMenuEntry
!macroend
!define DeleteMenuEntry "!insertmacro DeleteMenuEntry"

; DeleteMenuEntry function is based on RemoveAfterLine function, by Afrow UK http://nsis.sourceforge.net/Delete_lines_from_one_line_to_another_line_inclusive, I (Lance), simply created a macro for it.
Function DeleteMenuEntry
 Exch $1 ;end string
 Exch
 Exch $2 ;begin string
 Exch 2
 Exch $3 ;file
 Exch 2
 Push $R0
 Push $R1
 Push $R2
 Push $R3
  GetTempFileName $R2
  FileOpen $R1 $R2 w
  FileOpen $R0 $3 r
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $2 +3
  FileWrite $R1 $R3
  Goto -5
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $1 +4 -3
  FileRead $R0 $R3
  IfErrors Done
  FileWrite $R1 $R3
  ClearErrors
  Goto -4
Done:
   FileClose $R0
   FileClose $R1
   SetDetailsPrint none
   Delete $3
   Rename $R2 $3
   SetDetailsPrint both
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
 Pop $3
 Pop $2
 Pop $1
FunctionEnd

; Custom Distros Installer - Uninstaller Include
!include "InstallDistro.nsh" ; ##################################### ADD NEW DISTRO ########################################
!include "RemoveDistro.nsh" ; ##################################### ADD NEW DISTRO ########################################

Function DoSyslinux ; Install Syslinux on USB
  ${IfNot} ${FileExists} "$BootDir\multiboot\libcom32.c32"
  ${AndIf} ${FileExists} "$BootDir\multiboot\ldlinux.sys"
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}

  IfFileExists "$BootDir\multiboot\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer syslinux
  CreateSyslinux:
  CreateDirectory $BootDir\multiboot\menu ; recursively create the directory structure if it doesn't exist
  CreateDirectory $BootDir\multiboot\ISOS ; create ISOS folder
  DetailPrint $(ExecuteSyslinux)
  ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /multiboot $BootDir' $R8
  DetailPrint "Syslinux Errors $R8"
  Banner::destroy
  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf}
  DetailPrint "Creating Label MULTIBOOT on $DestDisk"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskMULTIBOOT"'

  SkipSyslinux:
  DetailPrint $(SkipSyslinux)

  ${If} ${FileExists} $BootDir\multiboot\syslinux.cfg
   DetailPrint "A Previous MultiBoot Installation was detected... proceeding to add your new selections."
   Call AddDir
  ${Else}
; Create and Copy files to your destination
  DetailPrint "Adding required files to the $BootDir\multiboot directory..."
  CopyFiles "$PLUGINSDIR\syslinux.cfg"     "$BootDir\multiboot\syslinux.cfg"
  CopyFiles "$PLUGINSDIR\AUMBI.png"        "$BootDir\multiboot\AUMBI.png"
  CopyFiles "$PLUGINSDIR\YUMI-Copying.txt" "$BootDir\multiboot\YUMI-Copying.txt"
  CopyFiles "$PLUGINSDIR\YUMI-Readme.txt"  "$BootDir\multiboot\YUMI-Readme.txt"
  CopyFiles "$PLUGINSDIR\license.txt"      "$BootDir\multiboot\license.txt"
  CopyFiles "$PLUGINSDIR\vesamenu.c32"     "$BootDir\multiboot\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32"         "$BootDir\multiboot\menu.c32"
  CopyFiles "$PLUGINSDIR\chain.c32"        "$BootDir\multiboot\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32"     "$BootDir\multiboot\libcom32.c32"
  CopyFiles "$PLUGINSDIR\libutil.c32"      "$BootDir\multiboot\libutil.c32"
  CopyFiles "$PLUGINSDIR\memdisk"          "$BootDir\multiboot\memdisk"
; Copy these files to multiboot\menu
  DetailPrint "Adding required files to the $BootDir\multiboot\menu directory..."
  CopyFiles "$PLUGINSDIR\vesamenu.c32"     "$BootDir\multiboot\menu\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32"         "$BootDir\multiboot\menu\menu.c32"
  CopyFiles "$PLUGINSDIR\chain.c32"        "$BootDir\multiboot\menu\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32"     "$BootDir\multiboot\menu\libcom32.c32"
  CopyFiles "$PLUGINSDIR\libutil.c32"      "$BootDir\multiboot\menu\libutil.c32"
  CopyFiles "$PLUGINSDIR\memdisk"          "$BootDir\multiboot\menu\memdisk"

  Call AddDir
  ${EndIf}

  ${IfNot} ${FileExists} $BootDir\multiboot\libutil.c32 ; Old Syslinux files need to be replaced
  DetailPrint "Adding required files to the $BootDir\multiboot directory..."
  CopyFiles "$PLUGINSDIR\AUMBI.png"        "$BootDir\multiboot\AUMBI.png"
  CopyFiles "$PLUGINSDIR\YUMI-Copying.txt" "$BootDir\multiboot\AUMBI.rtf"
  CopyFiles "$PLUGINSDIR\YUMI-Readme.txt"  "$BootDir\multiboot\Changelog.txt"
  CopyFiles "$PLUGINSDIR\license.txt"      "$BootDir\multiboot\license.txt"
  CopyFiles "$PLUGINSDIR\vesamenu.c32"     "$BootDir\multiboot\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32"         "$BootDir\multiboot\menu.c32"
  CopyFiles "$PLUGINSDIR\chain.c32"        "$BootDir\multiboot\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32"     "$BootDir\multiboot\libcom32.c32"
  CopyFiles "$PLUGINSDIR\libutil.c32"      "$BootDir\multiboot\libutil.c32"
  CopyFiles "$PLUGINSDIR\memdisk"          "$BootDir\multiboot\memdisk"
; Copy these files to multiboot\menu
  DetailPrint "Adding required files to the $BootDir\multiboot\menu directory..."
  CopyFiles "$PLUGINSDIR\vesamenu.c32"     "$BootDir\multiboot\menu\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32"         "$BootDir\multiboot\menu\menu.c32"
  CopyFiles "$PLUGINSDIR\chain.c32"        "$BootDir\multiboot\menu\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32"     "$BootDir\multiboot\menu\libcom32.c32"
  CopyFiles "$PLUGINSDIR\libutil.c32"      "$BootDir\multiboot\menu\libutil.c32"
  CopyFiles "$PLUGINSDIR\memdisk"          "$BootDir\multiboot\menu\memdisk"
 ${EndIf}

  ${IfNot} ${FileExists} $BootDir\multiboot\menu\vesamenu.c32
; Copy these files to multiboot\menu
  DetailPrint "Adding required files to the $BootDir\multiboot\menu directory..."
  CopyFiles "$PLUGINSDIR\vesamenu.c32"     "$BootDir\multiboot\menu\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32"         "$BootDir\multiboot\menu\menu.c32"
  CopyFiles "$PLUGINSDIR\chain.c32"        "$BootDir\multiboot\menu\chain.c32"
  CopyFiles "$PLUGINSDIR\memdisk"          "$BootDir\multiboot\menu\memdisk"
  ${EndIf}

; Check to ensure menu.c32 exists... now required for ${NAME} V2
  ${IfNot} ${FileExists} $BootDir\multiboot\menu.c32
   DetailPrint "Adding menu.c32. Required for ${NAME}"
   CopyFiles "$PLUGINSDIR\menu.c32"        "$BootDir\multiboot\menu.c32"
  ${EndIf}
FunctionEnd

Function AddDir ; changes to check if user had a version prior to 0.0.0.3 which now includes grub.exe
 ${IfNotThen} ${FileExists} "$BootDir\multiboot\grub.exe" 'CopyFiles "$PLUGINSDIR\grub.exe" "$BootDir\multiboot\grub.exe"'
; Windows/Ubuntu SOURCES conflict fix
 ;${IfNot} ${FileExists} $BootDir\.disk\info
  ; CreateDirectory $BootDir\.disk
  ; CopyFiles "$PLUGINSDIR\info" "$BootDir\.disk\info"
 ;${EndIf}
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

 ${If} ${FileExists} "$BootDir\windows\system32" ; additional safeguard to protect from potential user ignorance.
 MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
 Quit
 ${EndIf}

 ${If} $DistroName == "Try Unlisted ISO (GRUB Partition 4)"
 ${OrIf} $DistroName == "Bitdefender Rescue CD"
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "This option will create a 4th partition table on ($DestDisk)$\r$\n$\r$\nThis partition table will not be recognizable by Windows, and if you ever want to remove it you'll need to use a Linux based environment.$\r$\n$\r$\nIt is up to you to ensure that a 4th partition doesn't already exist on ($DestDisk). If it exists, it could be overwritten.$\r$\n$\r$\nClick YES to accept these actions or NO to Go Back!" IDYES checkpoint
 Quit
 ${EndIf}

checkpoint:
 ${If} $FormatMe == "Yes"
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "NOTE: You must manually close all open Explorer Windows and files in use on ($DestDisk) so that the drive can be successfully Fat32 Formatted!$\r$\n$\r$\n${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1. Fat32 Format ($DestDisk) - All Data will be Irrecoverably Deleted!$\r$\n$\r$\n2. Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n3. Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n4. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Go Back!" IDYES proceed
 Quit
 ${ElseIf} $FormatMe != "Yes"
 ${AndIfNot} ${FileExists} $BootDir\multiboot\syslinux.cfg
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1. Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n2. Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n3. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Go Back!" IDYES proceed
 Quit
 ${EndIf}

proceed:
 ${IfThen} $Removal == "Yes" ${|} Goto removeonly ${|}
 Call HaveSpace ; Got enough Space? Lets Check!
 Call FormatYes ; Format the Drive?
 Call DoSyslinux ; Run Syslinux on the Drive to make it bootable
 Call LocalISODetected

; Copy the config file if it doesn't exist and create the entry in syslinux.cfg
 ${IfNot} ${FileExists} "$BootDir\multiboot\menu\$Config2Use"
 CopyFiles "$PLUGINSDIR\$Config2Use" "$BootDir\multiboot\menu\$Config2Use"
 Call Config2Write
 ${EndIf}

removeonly:
 ${If} $Removal != "Yes"
 !insertmacro Install_Distros ; Install those distros
 ${ElseIf} $Removal == "Yes"
  Call ConfigRemove
 !insertmacro Uninstall_Distros ; Remove those distros
 ${EndIf}

SectionEnd

Function ConfigRemove ; Find and Set Removal Configuration file
  ${If} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\linux.cfg"
  StrCpy $Config2Use "linux.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\system.cfg"
  StrCpy $Config2Use "system.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\antivirus.cfg"
  StrCpy $Config2Use "antivirus.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\netbook.cfg"
  StrCpy $Config2Use "netbook.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\other.cfg"
  StrCpy $Config2Use "other.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\unlisted.cfg"
  StrCpy $Config2Use "unlisted.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\menu.lst"
  StrCpy $Config2Use "menu.lst"
  ${EndIf}
  ; MessageBox MB_OK "$Config2Use"
FunctionEnd

Function Config2Write
 ${If} $Config2Use == "linux.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_LUNIX_DIST)$\r$\nmenu label $(MENU_LABEL_LUNIX_DIST) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/linux.cfg" $R0
 ${ElseIf} $Config2Use == "system.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_SYS_TOOLS) $\r$\nmenu label $(MENU_LABEL_SYS_TOOLS) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/system.cfg" $R0
 ${ElseIf} $Config2Use == "antivirus.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_ANTIVIR)$\r$\nmenu label $(MENU_LABEL_ANTIVIR) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/antivirus.cfg" $R0
 ${ElseIf} $Config2Use == "netbook.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_NETBOOK) $\r$\nmenu label $(MENU_LABEL_NETBOOK) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/netbook.cfg" $R0
 ${ElseIf} $Config2Use == "other.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_OTHER_OS)$\r$\nmenu label $(MENU_LABEL_OTHER_OS) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/other.cfg" $R0
 ${ElseIf} $Config2Use == "unlisted.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED)$\r$\nmenu label  $(MENU_LABEL_UNLISTED) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/unlisted.cfg" $R0
 ${ElseIf} $Config2Use == "menu.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_GRUB)$\r$\nmenu label $(MENU_LABEL_GRUB_LARGE) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/menu.lst" $R0

 ${EndIf}
FunctionEnd

Function NoQuit
MessageBox MB_YESNO "$(ADD_MORE_DISTRO_MB_TEXT)" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call RelGotoPage
    Abort
noskip:
StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
StrCpy $RepeatInstall "YES" ; Set Repeat Install Option to YES
StrCpy $ISOTest "" ; Reset
StrCpy $ISOFile "" ; Reset
StrCpy $Removal "" ; Reset
StrCpy $Persistence "NULL" ; Reset
StrCpy $NameThatISO "" ; Reset NameThatISO ISO Name
StrCpy $Config2Use "" ; Clear Config File to create and write to
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $FileFormat "" ; Clear File Format
StrCpy $DownloadMe 0 ; Ensure Uncheck of Download Option
StrCpy $LocalSelection "" ; Reset Local Selection
StrCpy $ShowingAll ""
StrCpy $FormatMe "" ; Reset Format Option
    StrCmp $R8 4 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 -3 ; Goes back to selections page
    Call RelGotoPage ; change pages
    Abort
End:
FunctionEnd

Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

; --- Stuff to do at startup of script ---
Function .onInit
StrCpy $R9 0 ; we start on page 0
;StrCpy $InstallButton ""
 StrCpy $FileFormat "ISO"
 userInfo::getAccountType
 Pop $Auth
 strCmp $Auth "Admin" done
 Messagebox MB_OK|MB_ICONINFORMATION "Currently you're trying to run this program as: $Auth$\r$\n$\r$\nYou must run this program with administrative rights...$\r$\n$\r$\nRight click the file and select Run As Administrator or Run As (and select an administrative account)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir

  ${FILEONAMELANG} syslinux.cfg

  ${FILEONAME0} syslinux.exe
  ${FILEONAME0} menu.lst
  ${FILEONAME0} grub.exe
  ${FILEONAME0} 7zG.exe
  ${FILEONAME0} 7z.dll

  ${FILEONAME0} vesamenu.c32
  ${FILEONAME0} menu.c32
  ${FILEONAME0} memdisk
  ${FILEONAME0} chain.c32
  ${FILEONAME0} libcom32.c32
  ${FILEONAME0} libutil.c32
  ${FILEONAME0} ifcpu64.c32
  ${FILEONAME0} liveusb

  ${FILEONAME2} info
  ${FILEONAMELANG2} antivirus.cfg
  ${FILEONAMELANG2} system.cfg
  ${FILEONAMELANG2} netbook.cfg
  ${FILEONAMELANG2} linux.cfg
  ${FILEONAMELANG2} other.cfg
  ${FILEONAMELANG2} unlisted.cfg

  ${FILEONAME} AUMBI.png
  ${FILEONAME} AUMBI.rtf
  ${FILEONAME} Changelog.txt
  ${FILEONAME} AUMBI-Copying.txt
  ${FILEONAME} README.txt
  ${FILEONAME} license.txt

FunctionEnd

Function onNotify_CasperSlider
 Pop $Casper
 SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
 ${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function SetISOSize ; Get size of ISO
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
 ;MessageBox MB_OK|MB_ICONINFORMATION "ISO Size: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

  Function .onInstSuccess
           ExecShell "open" "${AUMBI_FINISH_WEBSITE}"
  FunctionEnd

Function AUMBIInit
  ;Aero::Apply
    FindWindow $R0 "#32770" "" $HWNDPARENT
    GetDlgItem $R0 $HWNDPARENT 9116
          SendMessage $R0 ${WM_SETTEXT} 0 "STR:"
          SetCtlColors $R0 0xc9c9c9 transparent

          CreateFont $1 "Segoe UI" "16" "1000"
          SendMessage $R0 ${WM_SETFONT} $1 1
          
          GetDlgItem $R8 $HWNDPARENT 1256
          ShowWindow $R8 ${SW_HIDE}

          GetDlgItem $R7 $HWNDPARENT 1028
          ShowWindow $R7 ${SW_HIDE}
          GetDlgItem $R6 $HWNDPARENT 1035
          ShowWindow $R6 ${SW_HIDE}

FunctionEnd

/*
Function SelPage_Color
SetCtlColors $Dialog 0xFF00FF transparent
FunctionEnd
*/


