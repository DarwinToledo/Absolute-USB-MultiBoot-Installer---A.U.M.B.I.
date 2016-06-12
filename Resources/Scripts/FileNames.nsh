!macro SetISOFileNames Distro2Check ISO2Check2 Download2Get Persistent Write2File Homepage OfficialName
 ${If} $Checker == "No" 
 ${AndIf} $DistroName == "${Distro2Check}" 
 StrCpy $ISOFileName "${ISO2Check2}"
 StrCpy $DownLink "${Download2Get}"   
 StrCpy $Persistence "${Persistent}"
 StrCpy $Config2Use "${Write2File}"
 StrCpy $Homepage "${Homepage}" ; Linux Distro Homepage
 StrCpy $OfficialName "${OfficialName}" ; Linux Distro Name for Home Page Anchor

 ${ElseIf} $Checker == "Yes"  
 ${AndIf} $Removal != "Yes" 
 ${AndIf} $FormatMe != "Yes"
 ;${AndIfNot} ${FileExists} $BootDir\${File2Check}  ; If Distro File exists, don't show Distro because it must already be installed.
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
  
 ${ElseIf} $Checker == "Yes"   
 ${AndIf} $Removal != "Yes"  
 ${AndIf} $FormatMe == "Yes" 
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
 ${EndIf}
!macroend