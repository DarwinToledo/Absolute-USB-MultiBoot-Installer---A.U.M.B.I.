#===========================================================
# SELECTION PAGE
#===========================================================

         Function SelectionsPage
                  StrCpy $R8 2
                  !insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle)
                  nsDialogs::Create 1018
                  Pop $Dialog

                  ${If} $RepeatInstall == "YES"
                  ${NSD_SetText} $DestDriveTxt "$DestDrive"

                  ; To Install or Uninstall? That is the question!
                  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(VIEW_ONREM_DISTROS)"
                  Pop $Uninstaller
                  ${NSD_OnClick} $Uninstaller Uninstall

                  ; Distro Selection Starts
                  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text)
                  Pop $LinuxDistroSelection

                  ${NSD_CreateDroplist} 0 70 55% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
                  Pop $Distro
                  ${NSD_OnChange} $Distro OnSelectDistro
                  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox

                  ; Force Show All ISO Option
                  ${NSD_CreateCheckBox} 80% 100 20% 15 "$(SHOW_ALL_ISOS)"
                  Pop $ForceShowAll
                  ${NSD_OnClick} $ForceShowAll ShowAllISOs

                  ; ISO Download Option
                  ${NSD_CreateCheckBox} 60% 60 40% 15 "$(DOWNLOAD_ISOOP)"
                  Pop $DownloadISO
                  ${NSD_OnClick} $DownloadISO DownloadIt

                  ; Clickable Link to Distribution Homepage
                  ${NSD_CreateLink} 60% 80 40% 15 "$(RL_VISIST_OFHOME)"
                  Pop $DistroLink
                  ${NSD_OnClick} $DistroLink onClickLinuxSite

                  ; ISO Selection Starts
                  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
                  Pop $LabelISOSelection
                  ${NSD_CreateText} 0 120 78% 20 "$(BROW_AND_SELFORM)"
                  Pop $ISOFileTxt
                  ${NSD_CreateBrowseButton} 85% 120 60 20 "$(RL_BROWSE)"
                  Pop $ISOSelection
                  ${NSD_OnClick} $ISOSelection ISOBrowse

                  ; Casper-RW Selection Starts
                  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
                  Pop $CasperSelection

                  ; CasperSlider - TrackBar
                  !define TBM_SETPOS 0x0405
                  !define TBM_GETPOS 0x0400
                  !define TBM_SETRANGEMIN 0x0407
                  !define TBM_SETRANGEMAX 0x0408

                  ${NSD_CreateLabel} 52% 178 25% 25 ""
                  Pop $SlideSpot

                  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
                  Pop $CasperSlider

                  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
                  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
                  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider

                  ; Drive Pre-Selection
                  ${NSD_CreateLabel} 0 0 58% 15 ""
                  Pop $LabelDrivePage
                  ${NSD_SetText} $LabelDrivePage "$(RL1_STEP1)"
                  ; Droplist for Drive Selection
                  ${NSD_CreateDropList} 0 20 28% 15 "" ; was 0 20 15% 15
                  Pop $DestDriveTxt

                  ${If} $ShowAll == "YES"
                  ${GetDrives} "ALL" DrivesList ; All Drives Listed
                  ${ElseIf} $ShowAll == "NO"
                  ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
                  ${EndIf}

                  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
                  StrCpy $JustDrive $DestDrive 3
                  StrCpy $BootDir $DestDrive 2 ;was -1
                  StrCpy $DestDisk $DestDrive 2 ;was -1
                  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
                  StrCpy $Checker "Yes"
                  Call InstallorRemove
                  Call CheckSpace
                  Call FormatIt
                  Call EnableNext
                  ${NSD_OnChange} $DestDriveTxt OnSelectDrive

                  ; All Drives Option
                  ${NSD_CreateCheckBox} 30% 23 30% 15 "$(SHOW_ALL_DRIVES)" ; was 17% 23 41% 15
                  Pop $AllDriveOption
                  ${NSD_OnClick} $AllDriveOption ListAllDrives

                  ; Format Drive Option
                  ${NSD_CreateCheckBox} 60% 23 100% 15 "$(RL2_FORMAT2)"
                  Pop $Format
                  ${NSD_OnClick} $Format FormatIt

                  ; Add Help Link
                  ${NSD_CreateLink} 0 215 65% 15 "$(CLICK_TO_ONLINEHELP)"
                  Pop $Link
                  ${NSD_OnClick} $LINK onClickMyLink

                  ; Disable Next Button until a selection is made for all
                  GetDlgItem $6 $HWNDPARENT 1
                  EnableWindow $6 0
                  ; Remove Back Button
                  GetDlgItem $6 $HWNDPARENT 3
                  ShowWindow $6 0
                  ; Hide or disable steps until we state to display them
                  EnableWindow $LabelISOSelection 0
                  EnableWindow $ISOFileTxt 0
                  ShowWindow $ISOSelection 0
                  EnableWindow $DownloadISO 0
                  ShowWindow $DistroLink 0
                  StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
                  nsDialogs::Show

        ${Else}

                  ; To Install or Uninstall? That is the question!
                  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(VIEW_OR_REMOVEDISTROS)"
                  Pop $Uninstaller
                  ${NSD_OnClick} $Uninstaller Uninstall

                  ; Drive Selection Starts
                  ${NSD_CreateLabel} 0 0 58% 15 ""
                  Pop $LabelDrivePage
                  ${NSD_SetText} $LabelDrivePage "$(RL2_STEP1)"

                  ; Droplist for Drive Selection
                  ${NSD_CreateDropList} 0 20 28% 15 "" ; was 0 20 15% 15
                  Pop $DestDriveTxt
                  Call ListAllDrives
                  ${NSD_OnChange} $DestDriveTxt OnSelectDrive

                  ; All Drives Option
                  ${NSD_CreateCheckBox} 30% 23 30% 15 "$(SHOW_ALL_DRIVES2)" ; was 17% 23 41% 15
                  Pop $AllDriveOption
                  ${NSD_OnClick} $AllDriveOption ListAllDrives

                  ; Format Drive Option
                  ${NSD_CreateCheckBox} 60% 23 100% 15 "$(RL2_FORMAT)"
                  Pop $Format
                  ${NSD_OnClick} $Format FormatIt

                  ; Distro Selection Starts
                  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text)
                  Pop $LinuxDistroSelection

                  ${NSD_CreateDropList} 0 70 55% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
                  Pop $Distro
                  ${NSD_OnChange} $Distro OnSelectDistro
                  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox

                  ; Force Show All ISO Option
                  ${NSD_CreateCheckBox} 80% 100 20% 15 "$(SHOW_ALL_ISOS2)"
                  Pop $ForceShowAll
                  ${NSD_OnClick} $ForceShowAll ShowAllISOs

                  ; ISO Download Option
                  ${NSD_CreateCheckBox} 60% 60 40% 15 "$(DOWNLOAD_ISOOP2)"
                  Pop $DownloadISO
                  ${NSD_OnClick} $DownloadISO DownloadIt

                  ; Clickable Link to Distribution Homepage
                  ${NSD_CreateLink} 60% 80 40% 15 "$(RL_VISIST_OFHOME2)"
                  Pop $DistroLink
                  ${NSD_OnClick} $DistroLink onClickLinuxSite

                  ; ISO Selection Starts
                  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
                  Pop $LabelISOSelection
                  ${NSD_CreateText} 0 120 78% 20 "$(BROW_AND_SELFORM2)"
                  Pop $ISOFileTxt
                  ${NSD_CreateBrowseButton} 85% 120 60 20 "$(RL_BROWSE2)"
                  Pop $ISOSelection
                  ${NSD_OnClick} $ISOSelection ISOBrowse

                  ; Casper-RW Selection Starts
                  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
                  Pop $CasperSelection

                  ; CasperSlider - TrackBar
                  ; !define TBM_SETPOS 0x0405
                  ; !define TBM_GETPOS 0x0400
                  ; !define TBM_SETRANGEMIN 0x0407
                  ; !define TBM_SETRANGEMAX 0x0408

                  ${NSD_CreateLabel} 52% 178 25% 25 ""
                  Pop $SlideSpot

                  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
                  Pop $CasperSlider

                  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
                  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
                  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider

                  ; Add Help Link
                  ${NSD_CreateLink} 0 215 65% 15 "$(CLICK_TO_ONLINEHELP2)"
                  Pop $Link
                  ${NSD_OnClick} $LINK onClickMyLink

                  ;; Add a custom donate button
                  ;   ${NSD_CreateBitmap} 80% 125 20% 50 "PayPal Donation"
                  ;   Var /Global Donate
                  ;   Var /Global DonateHandle
                  ;   Pop $Donate
                  ;   ${NSD_SetImage} $Donate $PLUGINSDIR\paypal.bmp $DonateHandle
                  ;  GetFunctionAddress $DonateHandle OnClickDonate
                  ;  nsDialogs::OnClick $Donate $DonateHandle

                  ; Disable Next Button until a selection is made for all
                  GetDlgItem $6 $HWNDPARENT 1
                  EnableWindow $6 0
                  ; Remove Back Button
                  GetDlgItem $6 $HWNDPARENT 3
                  ShowWindow $6 0
                  ; Hide or disable steps until we state to display them
                  EnableWindow $LabelISOSelection 0
                  EnableWindow $ISOFileTxt 0
                  ShowWindow $ISOSelection 0
                  EnableWindow $LinuxDistroSelection 0
                  EnableWindow $Distro 0
                  EnableWindow $DownloadISO 0
                  ShowWindow $DistroLink 0
                  ShowWindow $CasperSelection 0
                  ShowWindow $CasperSlider 0
                  ShowWindow $SlideSpot 0
                  ShowWindow $Format 0
                  ShowWindow $ForceShowAll 0
                  ShowWindow $Uninstaller 0
                  nsDialogs::Show
                  ;  ${NSD_FreeImage} $DonateHandle
        ${EndIf}
        FunctionEnd