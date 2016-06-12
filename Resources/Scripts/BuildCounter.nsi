#==========================================
#COMPRESSION SETTINGS
#==========================================

!define NAME "Build Counter v1.0"
  SetCompressor /SOLID lzma
  #   SetCompress off
  SetCompressorDictSize 32

  Name "${NAME}"

  OutFile "${NAME}.exe"

  RequestExecutionLevel user
  Showinstdetails show
  Page instfiles

Var Buildvar

Section ""
        ReadINIStr $Buildvar $EXEDIR\BuildCount.ini RUBIB Buildvar
        
        Detailprint "$Buildvar"
        IntOp $R0 $Buildvar + 1
        Detailprint "$R0"
        WriteINIStr $EXEDIR\BuildCount.ini RUBIB Buildvar $R0

        Delete "$EXEDIR\BuildCount.nsh"
        ClearErrors
        FileOpen $0 $EXEDIR\BuildCount.nsh w
        IfErrors done
        FileWrite $0 '!define       BUILD_NUMBER        "$Buildvar"$\n'
        FileClose $0
        done:
        
        quit
SectionEnd