#===========================================================
#
#===========================================================

         Function License_PreFunction
             StrCpy $R8 1 ;This is the 1st page
         FunctionEnd
         Function License_ShowFunction
                  Call PageRefreshPre

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(LICENSE_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.LicensePage 0xFFFFFF transparent
                  SetCtlColors $mui.LicensePage.TopText 0x000000 transparent
                  SetCtlColors $mui.LicensePage.Text 0x000000 transparent


         FunctionEnd

         Function SelectionsPage_Color_Title

                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(SELECTION_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.LicensePage 0xFFFFFF transparent
                  SetCtlColors $mui.LicensePage.TopText 0x000000 transparent
                  SetCtlColors $mui.LicensePage.Text 0x000000 transparent
                  Call PageRefreshShow
         FunctionEnd

         Function PageRefreshPre
                    SetBrandingImage /IMGID=1046 "$PLUGINSDIR\modern-header.bmp"
         FunctionEnd
         
         Function PageRefreshShow
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_SHOW}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_SHOW}
         FunctionEnd

        Function InstFiles_PreFunction
                 StrCpy $R8 3
        FunctionEnd

         Function InstFiles_ShowFunction
                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(INSTALL_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.InstFilesPage      0xFFFFFF transparent
                  ;SetCtlColors $mui.InstFilesPage.Text 0x000000 transparent

                  Call PageRefreshShow
         FunctionEnd

         Var AUMBI_CST_Bitmap1
         Var AUMBI_CST_Bitmap1_hImage

         Function BKG_BITMAP

                  ${NSD_CreateBitmap} 0u 0u 297.52u 141.54u ""
                  Pop $AUMBI_CST_Bitmap1
                  File "/oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp" "Resources\Images\AUMBI_ND_BKG.bmp"
                  ${NSD_SetImage} $AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $AUMBI_CST_Bitmap1_hImage

         FunctionEnd


         Var AUMBI_FINISH
         Var AUMBI_FINISH_Link1
         Var AUMBI_FINISH_Label2

         Function InstFinish_ShowFunction

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(FINISH_AUMBI_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

         FunctionEnd


         Function fnc_AUMBI_FINISH_Create

                  nsDialogs::Create 1044
                  Pop $AUMBI_FINISH
                  ${If} $AUMBI_FINISH == error
                        Abort
                  ${EndIf}
                  SetCtlColors $AUMBI_FINISH 0x000000 transparent
                  
                  ${NSD_CreateLink} 17.11u 172.31u 200.1u 12.31u "$(Finish_Link)"
                  Pop $AUMBI_FINISH_Link1
                  SetCtlColors $AUMBI_FINISH_Link1 0x000000 transparent
                  ${NSD_OnClick} $AUMBI_FINISH_Link1 onClickMyLink

                  ${NSD_CreateLabel} 26.99u 54.77u 273.82u 47.38u "$(Finish_Text)"
                  Pop $AUMBI_FINISH_Label2
                  SetCtlColors $AUMBI_FINISH_Label2 0x000000 transparent

         FunctionEnd


         Function fnc_AUMBI_FINISH_Show
                  Call Finish_PreFunction
                  Call PageRefreshPre
                  Call fnc_AUMBI_FINISH_Create
                  Call InstFinish_ShowFunction
                  nsDialogs::Show
         FunctionEnd
         
         
         