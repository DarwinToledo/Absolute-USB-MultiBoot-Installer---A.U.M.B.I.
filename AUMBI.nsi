#===========================================================
# AUMBI (Absolute USB MultiBoot Installer)
# Developed by Darwin Toledo http://www.usbwithlinux.com/
# Based on YUMI
#===========================================================
; AUMBI Copyleft ©2016 Darwin Toledo http://www.darwintoledo.com (See YUMI-Copying.txt and AUMBI-Readme.txt for more information, Credits, and Licensing)
; YUMI (Your Universal Multiboot Installer) Copyright ©2011-2016 Lance http://www.pendrivelinux.com 
; 7-Zip Copyright © Igor Pavlovis http://7-zip.org (unmodified binaries were used)
; Syslinux © H. Peter Anvin http://syslinux.zytor.com (unmodified binary used)
; Firadisk.img © Panot Joonkhiaw Karyonix http://reboot.pro/8804/ (unmodified binary used)
; grub.exe Grub4DOS © the Gna! people + Chenall https://code.google.com/p/grub4dos-chenall/ (unmodified binary used) : Official Grub4DOS: http://gna.org/projects/grub4dos/
; Fat32format.exe © Tom Thornhill Ridgecorp Consultants http://www.ridgecrop.demon.co.uk (unmodified binary used)
; NSIS Installer © Contributors http://nsis.sourceforge.net - Install NSIS to compile this script. http://nsis.sourceforge.net/Download
; YUMI may contain remnants of Cedric Tissieres's Tazusb.exe for Slitaz (slitaz@objectif-securite.ch), as his work was used as a base for singular distro installers that preceded YUMI.

#===========================================================
# INCLUDES
#===========================================================

         !execute "Resources\Scripts\Build Counter v1.0.exe"

         !addincludedir "Resources\Scripts"
         !AddPluginDir  "plugins"

         RequestExecutionLevel admin ;highest
         SetCompressor /SOLID /FINAL LZMA
         CRCCheck On
         XPStyle on
         
         !include       WordFunc.nsh
         !include       nsDialogs.nsh
         !include       MUI2.nsh
         !include       FileFunc.nsh
         !include       LogicLib.nsh
         !include       "Macros.nsh"
         ;!include      TextFunc.nsh
         !addplugindir  "Resources\Plugins"

         !include       "Resources\Scripts\Defines.nsh"
         !include       "Variables.nsh"

         !include DiskVoodoo.nsh ; DiskVoodoo Script created by Lance http://www.pendrivelinux.com
         !include StrContains.nsh ; Let's check if a * wildcard exists

#===========================================================
# MoreInfo Plugin - Adds Version Tab fields to Properties. Plugin created by onad http://nsis.sourceforge.net/MoreInfo_plug-in
#===========================================================

         VIProductVersion "${VERSION}"
         VIAddVersionKey CompanyName "${RUBIB_WEBSITE}"
         VIAddVersionKey LegalCopyright "Copyleft ©2016 Darwin Toledo www.usbwithlinux.com"
         VIAddVersionKey FileVersion "${VERSION}"
         VIAddVersionKey FileDescription "Absolute USB MultiBoot Installer (UFD Creation Tool)"
         VIAddVersionKey License "GPL Version 2"

#===========================================================
# Installer Atrrib
#===========================================================
         Name "${NAME} ${VERSION}"

         !ifdef BUILD_STABLE
         Caption "${NAME} ${VERSION} - ${RUBIB_WEBSITE}"
         OutFile "C:\Users\${DESKTOP_USER}\Desktop\${FILENAME}-${VERSION}.exe"
         BrandingText "${NAME} - ${RUBIB_WEBSITE}"
         !else
         Caption "${NAME} ${VERSION} Beta - ${RUBIB_WEBSITE}"
         OutFile "C:\Users\${DESKTOP_USER}\Desktop\${FILENAME}-Beta.exe"
         BrandingText "${NAME} Beta - ${RUBIB_WEBSITE}"
         !endif


         ShowInstDetails show
         CompletedText "$(COMPLETED_TEXT)"
         InstallButtonText "$(Create_Button)"

#===========================================================
# INTERFACE SETTINGS
#===========================================================
         ; Interface settings
         !define MUI_CUSTOMFUNCTION_GUIINIT AUMBIInit
         !define MUI_FINISHPAGE_NOAUTOCLOSE
         !define MUI_HEADERIMAGE
         !define MUI_HEADERIMAGE_BITMAP "Resources\Images\AUMBI_BKG.bmp"
         !define MUI_UI_HEADERIMAGE "Resources\UI\AUMBI_UI.exe"
         ;!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
         ;!define MUI_HEADERIMAGE_RIGHT


         ; License Agreement Page
         !define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
         !define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
         !define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
         !define MUI_PAGE_CUSTOMFUNCTION_PRE License_PreFunction
         !define MUI_PAGE_CUSTOMFUNCTION_SHOW License_ShowFunction
         !insertmacro MUI_PAGE_LICENSE "AUMBI.rtf"

         ; Distro Selection Page
         Page custom SelectionsPage_Show

         ; Install Files Page
         ;!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
         !define MUI_INSTFILESPAGE_FINISHHEADER_TEXT $(Finish_Install)
         !define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
         !define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
         !define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
         !define MUI_PAGE_CUSTOMFUNCTION_PRE InstFiles_PreFunction
         !define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFiles_ShowFunction
         !insertmacro MUI_PAGE_INSTFILES

         ; Finish page
         !define MUI_FINISHPAGE_TITLE $(Finish_Title)
         !define MUI_FINISHPAGE_TEXT $(Finish_Text)
         !define MUI_FINISHPAGE_LINK $(Finish_Link)
         !define MUI_FINISHPAGE_LINK_LOCATION "${RUBIB_LINK2}"
         !define MUI_WELCOMEFINISHPAGE_BITMAP "Resources\Images\finish.bmp"
         !define MUI_PAGE_CUSTOMFUNCTION_PRE Finish_PreFunction
         !insertmacro MUI_PAGE_FINISH

         ; English Language files
         !insertmacro MUI_LANGUAGE "English" ; first language is the default language
         !include     "Language_English.nsh"
         !insertmacro MUI_LANGUAGE "SpanishInternational" ; first language is the default language
         !include     "Language_SpanishInternational.nsh"

         !include FileManipulation.nsh ; Text File Manipulation
         !include FileNames.nsh ; Macro for FileNames
         !include DistroList.nsh ; List of Distributions
         !include "CasperScript.nsh" ; For creation of Persistent Casper-rw files


         
#===========================================================
#INCLUDES PAGE
#===========================================================

         !include "Resources\Scripts\PageFunctions1.nsh"
         !include "Resources\Scripts\PageFunctions2.nsh"

         #SELECTIONS PAGE FUNCTIONS HEADER 1
         !include "Resources\Scripts\PageFunctions3.nsh"
         !include "Resources\Scripts\PageFunctions4.nsh"
