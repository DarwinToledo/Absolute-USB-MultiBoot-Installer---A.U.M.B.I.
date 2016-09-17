#===========================================================
#SELECTIONS PAGE FUNCTIONS 1
#===========================================================

        Function Finish_PreFunction
                 StrCpy $R8 4
                 Call NoQuit
        FunctionEnd

        Function ListAllDrives ; Set to Display All Drives
                 SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0
                 ${NSD_GetState} $AllDriveOption $DisplayAll
                 ${If} $DisplayAll == ${BST_CHECKED}
                   ${NSD_Check} $AllDriveOption
                   ${NSD_SetText} $AllDriveOption "$(RL2_SHOWING)"
                     StrCpy $ShowAll "YES"
                     ${GetDrives} "ALL" DrivesList ; All Drives Listed
                 ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
                   ${NSD_Uncheck} $AllDriveOption
                   ${NSD_SetText} $AllDriveOption "$(RL2_SHOWALL)"
                    ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
	           StrCpy $ShowAll "NO"
                 ${EndIf}
         FunctionEnd

         Function onClickMyLink
                  Pop $Links ; pop something to prevent corruption
                  ExecShell "open" "${RUBIB_WEBSITE}"
         FunctionEnd

         Function onClickLinuxSite
                  Pop $OfficialSite
                  ExecShell "open" "$Homepage"
         FunctionEnd

         Function DownloadIt ; Set Download Option
                  ${NSD_GetState} $DownloadISO $DownloadMe
                  ${If} $DownloadMe == ${BST_CHECKED}
                     ${NSD_Check} $DownloadISO
                     ${NSD_SetText} $DownloadISO "$(RL_ODL)"
                     Call DownloadLinks
                  ${ElseIf} $DownloadMe == ${BST_UNCHECKED}
                     ${NSD_Uncheck} $DownloadISO
                     ${NSD_SetText} $DownloadISO "$(RL_DL1)"
                  ${EndIf}
         FunctionEnd

         Function EnableNext ; Enable Install Button
           ${If} $Blocksize >= 4
           ${AndIf} $Removal != "Yes"
           ShowWindow $Format 1
           ${Else}
           ShowWindow $Format 0
           ${EndIf}
           ${If} $Removal != "Yes"
            ${AndIf} $ISOFileName != ""
             ${AndIf} $ISOFile != ""
              ${AndIf} $DestDrive != ""
	           ${AndIf} $ISOTest != ""
           StrCpy $InUnStall "Install"
           GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
            SendMessage $6 ${WM_SETTEXT} 0 "STR:$(Create_Button)"
             EnableWindow $6 1 ; Enable "Install" control button

           ${ElseIf} $Removal == "Yes"
            ${AndIf} $ISOFileName != ""
              ${AndIf} $DestDrive != ""
	           ${AndIf} $ISOTest != ""
           StrCpy $InUnStall "UnInstall"
           GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
            SendMessage $6 ${WM_SETTEXT} 0 "STR:Remove"
             EnableWindow $6 1 ; Enable "Install" control button
           ${EndIf}

         ; Test if ISO has been Selected. If not, disable Install Button
           ${If} $ISOTest == ""
           GetDlgItem $6 $HWNDPARENT 1
           EnableWindow $6 0 ; Disable "Install" if ISO not set
           ${EndIf}

         ; Show Steps in progression
           ${If} $DestDrive != ""
           EnableWindow $LinuxDistroSelection 1
           EnableWindow $Distro 1
           ${EndIf}

           ${If} $ISOFileName != ""
           ${AndIf} $Removal != "Yes"
           EnableWindow $LabelISOSelection 1
           EnableWindow $ISOFileTxt 1
           ShowWindow $ISOSelection 1

           ${AndIf} $Removal == "Yes"
           EnableWindow $LabelISOSelection 0
           EnableWindow $ISOFileTxt 0
           ShowWindow $ISOSelection 0
           ${EndIf}

         ; Disable Window if ISO was downloaded
           ${If} $TheISO == "$EXEDIR\$ISOFileName"
           ${AndIf} $ISOTest != ""
           EnableWindow $ISOSelection 0
           SetCtlColors $ISOFileTxt 009900 FFFFFF
           ${EndIf}

         ; If using Casper Persistence...
           ${If} $Persistence == "casper" ; If can use Casper Persistence...
           ${AndIf} $TheISO != ""
           ${AndIf} $BootDir != ""
           ShowWindow $CasperSelection 1
           ShowWindow $CasperSlider 1
           ShowWindow $SlideSpot 1
           ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)"

         ; Else If not using Casper Persistence...
           ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
           ${OrIf} $Removal == "Yes"
           ShowWindow $CasperSelection 0
           ShowWindow $CasperSlider 0
           ShowWindow $SlideSpot 0
           ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)"
           ${EndIf}
         FunctionEnd

         Function DownloadLinks
                MessageBox MB_YESNO|MB_ICONQUESTION "$(MB_DL2)" IDYES DownloadIt IDNO Skip
                Skip: ; Reset Download Checkbox Options
                  ${NSD_Uncheck} $DownloadISO
                  ${NSD_SetText} $DownloadISO "$(RL_DL2)"
                  EnableWindow $DownloadISO 1
                  Goto end
                DownloadIt:
                  ${NSD_SetText} $LabelISOSelection "$(RL2_STEP3)"
                  EnableWindow $DownloadISO 0
                  ExecShell "open" "$DownLink"
                end:
        FunctionEnd

        Function LocalISODetected ; The script autodetected the ISO, so let's do the following
                 ${If} $DownloadMe != ${BST_CHECKED}
                 ${AndIf} $LocalSelection != "Yes"
                      StrCpy $ISOFile "$EXEDIR\$ISOFileName"
                 ${EndIf}
        FunctionEnd

        ; get only the filename
        Function GrabNameOnly
          Exch $4 ; count to get part
          Exch
          Exch $0 ; input string
          Push $1
          Push $2
          Push $3
          StrCpy $1 0
          StrCpy $3 1
          loop:
            IntOp $1 $1 - 1
            StrCpy $2 $0 1 $1
            StrCmp $2 "" exit2
            StrCmp $2 "\" next ; grab text to the right of "\"
            Goto loop
          next:
            StrCmp $3 $4 exit
            IntOp $3 $3 + 1
          Goto loop
          exit2:
            IntOp $1 $1 - 1
          exit:
            IntOp $1 $1 + 1
            StrCpy $0 $0 "" $1
            Pop $3
            Pop $2
            Pop $1
            Exch $0 ; output string
        FunctionEnd
