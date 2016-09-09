#===========================================================
# AUMBI (Absolute USB Multiboot Installer)
# http://www.usbwithlinux.com
# Macros by Darwin Toledo
#===========================================================


       !macro FILEONAME0 FILE
              File /oname=$PLUGINSDIR\${FILE} "menufiles\${FILE}"
       !macroend
       !define FILEONAME0 "!insertmacro FILEONAME0 "

       !macro FILEONAME FILE
              File /oname=$PLUGINSDIR\${FILE} "${FILE}"
       !macroend
       !define FILEONAME "!insertmacro FILEONAME "

       !macro FILEONAME2 FILE
              File /oname=$PLUGINSDIR\${FILE} "menu\${FILE}"
       !macroend
       !define FILEONAME2 "!insertmacro FILEONAME2 "

       !macro FILEONAMELANG FILE
 	${If} $LANGUAGE == ${LANG_ENGLISH}
		StrCpy $DefaultLNG "EnglishFiles"
              File /oname=$PLUGINSDIR\${FILE} "menufiles\English_${FILE}"
        ${ElseIf} $LANGUAGE == ${LANG_SPANISHINTERNATIONAL}
		StrCpy $DefaultLNG "SpanishInternationalFiles"
              File /oname=$PLUGINSDIR\${FILE} "menufiles\SpanishInternational_${FILE}"
        ${Endif}

       !macroend
       !define FILEONAMELANG "!insertmacro FILEONAMELANG "

       !macro FILEONAMELANG2 FILE
 	${If} $LANGUAGE == ${LANG_ENGLISH}
		StrCpy $DefaultLNG "EnglishFiles"
              File /oname=$PLUGINSDIR\${FILE} "menu\English_${FILE}"
        ${ElseIf} $LANGUAGE == ${LANG_SPANISHINTERNATIONAL}
		StrCpy $DefaultLNG "SpanishInternationalFiles"
              File /oname=$PLUGINSDIR\${FILE} "menu\SpanishInternational_${FILE}"
        ${Endif}

       !macroend
       !define FILEONAMELANG2 "!insertmacro FILEONAMELANG2 "
