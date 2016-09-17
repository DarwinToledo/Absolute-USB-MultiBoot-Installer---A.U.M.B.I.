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

Var hCtl_AUMBI_CST_Bitmap1
Var hCtl_AUMBI_CST_Bitmap1_hImage

Function BKG_BITMAP
  ; === Bitmap1 (type: Bitmap) ===
  ${NSD_CreateBitmap} 0u 0u 297.52u 141.54u ""
  Pop $hCtl_AUMBI_CST_Bitmap1
  File "/oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp" "C:\Users\Rodrigo\Documents\GitHub\Absolute-USB-MultiBoot-Installer---A.U.M.B.I\Resources\Images\AUMBI_ND_BKG.bmp"
  ${NSD_SetImage} $hCtl_AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $hCtl_AUMBI_CST_Bitmap1_hImage

FunctionEnd         
         
         
         