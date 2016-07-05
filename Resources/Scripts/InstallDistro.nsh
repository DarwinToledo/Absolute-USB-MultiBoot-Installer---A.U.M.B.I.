/*
 * This file is part of YUMI
 *
 * YUMI is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * any later version.
 *
 * YUMI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with YUMI.  If not, see <http://www.gnu.org/licenses/>.
 */

; ------------ Install Distros Macro -------------- 

!include ReplaceInFile.nsh
Function FindConfig ; Set config path and file
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg" ; Liberte
  StrCpy $ConfigPath "liberte/boot/syslinux"
  StrCpy $CopyPath "liberte\boot\syslinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg" ; OpenSuse based 32bit
  StrCpy $ConfigPath "boot/i386/loader"
  StrCpy $CopyPath "boot\i386\loader"
  StrCpy $ConfigFile "isolinux.cfg" 
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\x86_64\loader\isolinux.cfg" ; OpenSuse based 32bit
  StrCpy $ConfigPath "boot/x86_64/loader"
  StrCpy $CopyPath "boot\x86_64\loader"
  StrCpy $ConfigFile "isolinux.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"    
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "syslinux.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "isolinux.cfg" 
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\syslinux.cfg"  ; AVG
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "syslinux.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  ; Probably Ubuntu based
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "txt.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"   ; Probably Ubuntu based
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "text.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"   
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "txt.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"   
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "text.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\system\isolinux\isolinux.cfg"  ; AOSS
  StrCpy $ConfigPath "system/isolinux"
  StrCpy $CopyPath "system\isolinux"
  StrCpy $ConfigFile "isolinux.cfg"    
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg"  ; Probably Puppy based 
  StrCpy $ConfigPath ""
  StrCpy $CopyPath ""
  StrCpy $ConfigFile "isolinux.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux.cfg" 
  StrCpy $ConfigPath ""
  StrCpy $CopyPath ""
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  ; Slax based 
  StrCpy $ConfigPath "slax/boot"
  StrCpy $CopyPath "slax\boot"
  StrCpy $ConfigFile "syslinux.cfg"    

  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"     
  StrCpy $ConfigPath "boot/syslinux"
  StrCpy $CopyPath "boot\syslinux"
  StrCpy $ConfigFile "syslinux.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
  StrCpy $ConfigPath "boot/isolinux"
  StrCpy $CopyPath "boot\isolinux"
  StrCpy $ConfigFile "isolinux.cfg" 
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\syslinux.cfg"     
  StrCpy $ConfigPath "boot/isolinux"
  StrCpy $CopyPath "boot\isolinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${Else} 
   StrCpy $ConfigFile "NULL"
  ${EndIf}   
  ;MessageBox MB_OK "$ConfigPath/$ConfigFile"   
FunctionEnd

Function OldSysFix ; fix to force use of new syslinux... 
 DetailPrint "Checking if we need to replace vesamenu.c32, menu.c32, and chain.c32, libutil.c32, libcom32.c32, memdisk"   
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName chain.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName vesamenu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName menu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName libutil.c32 CBFUNC  
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName libcom32.c32 CBFUNC  
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName memdisk CBFUNC 
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName ifcpu64.c32 CBFUNC 
  !insertmacro CallFindFiles $BootDir\boot\isolinux menu.c32 CBFUNC  ; fix for distros like Dr.Web
FunctionEnd

Function SysFixHirens ; fix to force use of new syslinux... 
 DetailPrint "Checking if we need to replace vesamenu.c32, menu.c32, and chain.c32, libutil.c32, libcom32.c32, memdisk" 
; Replace for Hirens
  !insertmacro CallFindFiles $BootDir\HBCD\Boot chain.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\HBCD\Boot vesamenu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\HBCD\Boot memdisk CBFUNC
FunctionEnd
  
Function WriteStuff
 ; Now done before this function is called (see line 122) CreateDirectory "$BootDir\multiboot\$JustISOName\YUMI\" ; Create the YUMI Directory.. so we can copy the following config file to it.
 CopyFiles "$PLUGINSDIR\$Config2Use" "$BootDir\multiboot\$JustISOName\YUMI\$Config2Use" ; Copy the $Config2Use file to $JustISOName\YUMI folder for the distro (so we know where to remove entry) 
 DetailPrint "$DistroName ($JustISOName) and its menu entry were added!"
 
; Failure to find ConfigFile and was not added as a GRUB Boot ISO, so Remove and Delete   
  ${If} $ConfigFile == "NULL" ; Isolinux/Syslinux config file doesn't exist!
  ${AndIf} $Config2Use != "menu.lst" ; menu.lst = GRUB, so we shouldn't expect to find a syslinux config file!
    MessageBox MB_OK "YUMI couldn't find a configuration file.$\r$\n'$JustISO' not supported, please report the exact steps taken to arrive at this message!$\r$\nYUMI will now remove this entry."   
    ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#start $JustISOName" "#end $JustISOName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
    StrCpy $DistroName "$JustISOName" ; So we can remove the following Installed.txt entry
    ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed.txt entry
    ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines from Installed.txt
    RMDir /R "$BootDir\multiboot\$JustISOName"  
    DetailPrint "$JustISOName and its menu entry were Removed!"  	
  ${EndIf}	
FunctionEnd

!macro Install_Distros 

; Initiate Plugins Directory for potential use
  SetShellVarContext all
  InitPluginsDir

; If distro is already installed, delete the entry, so we don't make a mess.
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
 ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#start $DistroName" "#end $DistroName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
 ${EndIf}
 
; Write $JustISOName to Installed.txt 
 ${InstalledList} "$JustISOName" $R0 ; Write the ISO name to the Installed List "Installed.txt" file (so we can keep track of installs for removal)
 ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
 
; Create the Directory for this ISOs files
 CreateDirectory "$BootDir\multiboot\$JustISOName\YUMI\" ; Create the YUMI Directory.. so we can eventually copy the config file (see line 90) to it.

; Kaspersky Rescue Disk
 ${If} $DistroName == "Kaspersky Rescue Disk (Antivirus Scanner)" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 File /oname=$PLUGINSDIR\kav.cfg "menu\kav.cfg"   
 CreateDirectory "$BootDir\multiboot\$JustISOName\syslinux" 
 CopyFiles "$PLUGINSDIR\kav.cfg" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" 
 CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BootDir\multiboot\$JustISOName\syslinux\vesamenu.c32"  
 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" 
 Call FindConfig
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nCONFIG /multiboot/$JustISOName/$ConfigPath/$ConfigFile$\r$\nAPPEND /multiboot/$JustISOName/$ConfigPath$\r$\n#end $JustISOName" $R0 

; Acronis True Image 
 ${ElseIf} $DistroName == "Acronis True Image"
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 File /oname=$PLUGINSDIR\acronisti.cfg "menu\acronisti.cfg"   
 CopyFiles "$PLUGINSDIR\acronisti.cfg" "$BootDir\multiboot\$JustISOName\acronisti.cfg"  
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nCONFIG /multiboot/$JustISOName/acronisti.cfg$\r$\nAPPEND /multiboot/$JustISOName$\r$\n#end $JustISOName" $R0 

 ; Calculate Linux Desktop
 ${ElseIf} $DistroName == "Calculate Linux Desktop"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y' 
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/vmlinuz$\r$\nINITRD /multiboot/$JustISOName/initrd$\r$\nAPPEND root=live:LABEL=CLD-20151230 vga=current init=/linuxrc rd.live.squashimg=livecd.squashfs nodevfs noresume splash=silent,theme:calculate console=tty1 iso-scan/filename=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0 
 
 ; Linux Kid X
 ${ElseIf} $DistroName == "Linux Kid X" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/boot/vmlinuz$\r$\nINITRD /multiboot/$JustISOName/boot/initrd.gz$\r$\nAPPEND from=/multiboot/$JustISOName vga=788 nocd max_loop=255 ramdisk_size=6666 root=/dev/ram0 rw $\r$\n#end $JustISOName" $R0      
 
; Bitdefender
; ${ElseIf} $DistroName == "Bitdefender Rescue CD"
; ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
; ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/boot/kernel.i386-pc$\r$\nAPPEND initrd=/multiboot/$JustISOName/boot/initfs.i386-pc root=/dev/ram0 real_root=/dev/loop0 loop=/multiboot/$JustISOName/rescue/livecd.squashfs cdroot_marker=/multiboot/$JustISOName/rescue/livecd.squashfs initrd udev cdroot scandelay=10 quiet splash$\r$\n#end $JustISOName" $R0 
 
 ${ElseIf} $DistroName == "Bitdefender Rescue CD"
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO" 
 ${WriteToFile} "#start $JustISOName$\r$\nlabel Bitdefender ($JustISOName)$\r$\nmenu label title Bitdefender ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/bitdefender.lst$\r$\n#end $JustISOName" $R0   
 File /oname=$PLUGINSDIR\bitdefender.lst "Menu\bitdefender.lst"  
 CopyFiles "$PLUGINSDIR\bitdefender.lst" "$BootDir\multiboot\menu\bitdefender.lst" 
 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\bitdefender.lst" 
 
 
; Dr.Web Live CD
 ;${ElseIf} $DistroName == "Dr.Web LiveDisk"
 ;ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y'
 ;Call OldSysFix  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
 ;${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nCONFIG /boot/isolinux/isolinux.cfg$\r$\nAPPEND /boot/isolinux$\r$\n#end $JustISOName" $R0
 
; Linux Mint (New Method) 
 ${ElseIf} $DistroName == "Linux Mint"
  ${OrIf} $DistroName == "AVIRA AntiVir Rescue CD (Virus Scanner)"
  ${OrIf} $DistroName == "Cub Linux"
 ${AndIfNot} $JustISO == "linuxmint-201403-cinnamon-dvd-32bit.iso"
 ${AndIfNot} $JustISO == "linuxmint-201403-mate-dvd-32bit.iso" 
 ${AndIfNot} $JustISO == "linuxmint-201403-cinnamon-dvd-64bit.iso"
 ${AndIfNot} $JustISO == "linuxmint-201403-mate-dvd-64bit.iso"  
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd.* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 Rename "$BootDir\multiboot\$JustISOName\initrd.gz" "$BootDir\multiboot\$JustISOName\initrd.lz" 
 Rename "$BootDir\multiboot\$JustISOName\vmlinuz.efi" "$BootDir\multiboot\$JustISOName\vmlinuz" 
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/vmlinuz$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd.lz cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt splash boot=casper iso-scan/filename=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0
 
; OpenSUSE 32bit 
 ${ElseIf} $DistroName == "OpenSUSE 32bit"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0
 
; OpenSUSE 64bit 
 ${ElseIf} $DistroName == "OpenSUSE 64bit"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$EXEDIR\TEMPYUMI" -y' 
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$EXEDIR\TEMPYUMI\*.img" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y' 
 RMDir /R "$EXEDIR\TEMPYUMI" 
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0 

; OpenMediaVault - NOT WORKING YET
 ; ${ElseIf} $DistroName == "OpenMediaVault"
 ; CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
 ; ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y'  
 ; ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0 
 
 ; FreeDOS (Balder img) 
 ${ElseIf} $DistroName == "FreeDOS (Balder img)"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL FreeDOS ($JustISOName)$\r$\nMENU LABEL FreeDOS ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/memdisk$\r$\nAPPEND initrd=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0
 
; Memtest86+ (Memory Testing Tool)
 ${ElseIf} $DistroName == "Memtest86+ (Memory Testing Tool)"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/$JustISOName.bin$\r$\n#end $JustISOName" $R0

; Kon-Boot  
 ${ElseIf} $DistroName == "Kon-Boot FREE"
 CreateDirectory "$EXEDIR\TEMPYUMI" ; Create the TEMPYUMI directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -pkon-boot -o"$EXEDIR\TEMPYUMI" -y' 
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$EXEDIR\TEMPYUMI\FD0-konboot*.zip" -pkon-boot -o"$EXEDIR\TEMPYUMI" -y' 
 CopyFiles $EXEDIR\TEMPYUMI\FD0-konboot-v1.1-2in1.img "$BootDir\multiboot\$JustISOName\konboot.img" 
 RMDir /R "$EXEDIR\TEMPYUMI"
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Kon-Boot ($JustISOName)$\r$\nMENU LABEL Kon-Boot ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/konboot.cfg$\r$\nAPPEND /multiboot/menu$\r$\n#end $JustISOName" $R0 
 File /oname=$PLUGINSDIR\konboot.cfg "Menu\konboot.cfg"  
 CopyFiles "$PLUGINSDIR\konboot.cfg" "$BootDir\multiboot\menu\konboot.cfg"
 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\menu\konboot.cfg" 
 
 ${ElseIf} $DistroName == "Kon-Boot Purchased"
 CreateDirectory "$EXEDIR\TEMPYUMI" ; Create the TEMPYUMI directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$EXEDIR\TEMPYUMI" -y' 
 CopyFiles $EXEDIR\TEMPYUMI\grldr "$BootDir\multiboot\$JustISOName\grldr"  
 CopyFiles $EXEDIR\TEMPYUMI\konboot.img "$BootDir\multiboot\$JustISOName\konboot.img"  
 CopyFiles $EXEDIR\TEMPYUMI\konbootOLD.img "$BootDir\multiboot\$JustISOName\konbootOLD.img" 
 RMDir /R "$EXEDIR\TEMPYUMI"
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Kon-Boot ($JustISOName)$\r$\nMENU LABEL Kon-Boot ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/konboot.lst" $R0 
 File /oname=$PLUGINSDIR\konboot.lst "Menu\konboot.lst"  
 CopyFiles "$PLUGINSDIR\konboot.lst" "$BootDir\multiboot\$JustISOName\konboot.lst"
 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\konboot.lst" 
 
; Falcon 4 Boot CD
 ${ElseIf} $DistroName == "Falcon 4 Boot CD"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y' 
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Falcon 4 Boot CD ($JustISOName)$\r$\nMENU LABEL Falcon 4 Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCOM32 /multiboot/chain.c32 ntldr=/grldr$\r$\n#end $JustISOName" $R0
 
; Hiren's Boot CD 
 ${ElseIf} $DistroName == "Hiren's Boot CD" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -ir!HBCD -o"$BootDir\" -y' 
   Call SysFixHirens  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Hiren's Boot CD ($JustISOName)$\r$\nMENU LABEL Hiren's Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCOM32 /HBCD/Boot/chain.c32 ntldr=/HBCD/grldr$\r$\n#end $JustISOName" $R0  

; Windows Defender Offline
 ${ElseIf} $DistroName == "Windows Defender Offline"
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO" 
; ${WriteToFile} "#start $JustISOName$\r$\nLABEL Windows Defender Offline ($JustISOName)$\r$\nMENU LABEL Windows Defender Offline ($JustISOName)$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/grub.exe$\r$\nAPPEND --config-file=$\"ls /multiboot/ISOS/$JustISO || find --set-root /multiboot/ISOS/$JustISO;map --heads=0 --sectors-per-track=0 /multiboot/ISOS/$JustISO (0xff) || map --heads=0 --sectors-per-track=0 --mem /multiboot/ISOS/$JustISO (0xff);map --hook;chainloader (0xff)$\"$\r$\n#end $JustISOName" $R0
 ${WriteToFile} "#start $JustISOName$\r$\nlabel Windows Defender Offline ($JustISOName)$\r$\nmenu label title Windows Defender Offline ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/WDO.lst$\r$\n#end $JustISOName" $R0   
 File /oname=$PLUGINSDIR\WDO.lst "Menu\WDO.lst"  
 CopyFiles "$PLUGINSDIR\WDO.lst" "$BootDir\multiboot\menu\WDO.lst" 
 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\WDO.lst"  
 
; Windows 10
 ${ElseIf} $DistroName == "Windows 10 Installer"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\" -y -x![BOOT]*' 
 ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName$\r$\nchainloader /bootmgr$\r$\n#end $JustISOName" $R0  
 
; Windows Vista/7/8
 ${ElseIf} $DistroName == "Windows Vista/7/8 Installer"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\" -y -x![BOOT]*' 
; For Syslinux ---- ${WriteToFile} "#start $JustISOName$\r$\nLABEL Windows Vista/7/8 Installer$\r$\nMENU LABEL Windows Vista/7/8/10 Installer$\r$\nMENU INDENT 1$\r$\nCOM32 /multiboot/chain.c32 fs ntldr=/bootmgr$\r$\n#end $JustISOName" $R0  
; CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName$\r$\nchainloader /bootmgr$\r$\n#end $JustISOName" $R0  
; File /oname=$PLUGINSDIR\firadisk.img "firadisk.img"  
; CopyFiles "$PLUGINSDIR\firadisk.img" "$BootDir\multiboot\ISOS\firadisk.img"   

; Windows XP
 ${ElseIf} $DistroName == "Windows XP Installer" 
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\ntitle Begin Install of Windows XP from $JustISO (Stage 1)$\r$\nfind --set-root /multiboot/ISOS/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/ISOS/firadisk.img (fd0)$\r$\nmap --mem /multiboot/ISOS/firadisk.img (fd1)$\r$\nmap --mem /multiboot/ISOS/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (0xff)/I386/SETUPLDR.BIN$\r$\n$\r$\ntitle Continue Windows XP Install from $JustISO (Stage 2)$\r$\nfind --set-root /multiboot/ISOS/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/ISOS/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (hd0)+1$\r$\n$\r$\ntitle Boot Windows XP - If fails, reboot with USB removed (Stage 3)$\r$\nmap (hd1) (hd0)$\r$\nmap (hd0) (hd1)$\r$\nroot (hd1,0)$\r$\nfind --set-root /ntldr$\r$\nchainloader /ntldr$\r$\n#end $JustISOName" $R0  
 File /oname=$PLUGINSDIR\firadisk.img "firadisk.img"  
 CopyFiles "$PLUGINSDIR\firadisk.img" "$BootDir\multiboot\ISOS\firadisk.img"   
 
; Unlisted ISOs

# The following Grub at Partition 4 entry adds a 4th partition table to the USB device and uses this as a placeholder for the ISO. 
# Entry derived from Information obtained from Steve of rmprepusb.com. Steve said the following were his original sources: http://reboot.pro/topic/9916-grub4dos-isohybrided/page-2#entry88531 and http://reboot.pro/topic/9916-grub4dos-isohybrided/page-2#entry164127
 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB Partition 4)" 
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4%$\r$\nif %check%==0x00 partnew (hd0,3) 0 0 0$\r$\nif not %check%==0x00 echo WARNING: Fourth partion is not empty, please delete it if you wish to use this boot method! && pause --wait=5 && configfile /multiboot/menu/menu.lst$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISOName$\r$\nset ISO=/multiboot/ISOS/$JustISO$\r$\nfind --set-root %ISO%$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4% $\r$\nif %check%==0x00 partnew (hd0,3) 0x00 %ISO%$\r$\nif NOT %check%==0x00 echo ERROR: Fourth partion is not empty, please delete it if you wish to use this method! && pause --wait=5 && configfile /multiboot/menu/menu.lst$\r$\nmap  %ISO% (0xff)$\r$\nmap --hook$\r$\nroot (0xff)$\r$\nchainloader (0xff)$\r$\n#end $JustISOName" $R0

 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB)" 
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISO$\r$\nfind --set-root --ignore-floppies --ignore-cd /multiboot/ISOS/$JustISO$\r$\nmap --heads=0 --sectors-per-track=0 /multiboot/ISOS/$JustISO (hd32)$\r$\nmap --hook$\r$\nchainloader (hd32)$\r$\n#end $JustISOName" $R0 
 
 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB from RAM)" 
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following memory based entry if it does not boot$\r$\ntitle Boot $JustISO from Memory$\r$\nfind --set-root --ignore-floppies --ignore-cd /multiboot/ISOS/$JustISO$\r$\nmap --heads=0 --sectors-per-track=0 --mem /multiboot/ISOS/$JustISO (hd32)$\r$\nmap --hook$\r$\nroot (hd32)$\r$\nchainloader (hd32)$\r$\n#end $JustISOName" $R0
 
; Ultimate Boot CD (Diagnostics Tools)
 ${ElseIf} $DistroName == "Ultimate Boot CD (Diagnostics Tools)"  
 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
 ${WriteToFile} "#start $JustISOName$\r$\nlabel Ultimate Boot CD ($JustISOName)$\r$\nmenu label Ultimate Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/ubcd.lst$\r$\n#end $JustISOName" $R0   
 File /oname=$PLUGINSDIR\ubcd.lst "Menu\ubcd.lst"  
 CopyFiles "$PLUGINSDIR\ubcd.lst" "$BootDir\multiboot\menu\ubcd.lst" 
 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\ubcd.lst"  
 
 ${ElseIf} $DistroName == "Puppy Arcade"  
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nmenu label $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/arcade.lst$\r$\n#end $JustISOName" $R0   
 File /oname=$PLUGINSDIR\arcade.lst "Menu\arcade.lst"  
 CopyFiles "$PLUGINSDIR\arcade.lst" "$BootDir\multiboot\$JustISOName\arcade.lst" 
 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\arcade.lst"  
 
; Vba32 Rescue - NOT READY YET
; ${ElseIf} $DistroName == "Vba32 Rescue"
; ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y' 
; ${WriteToFile} "#start $JustISOName$\r$\nLABEL Vba32 Rescue ($JustISOName)$\r$\nMENU LABEL Vba32 Rescue ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/vba/kernel$\r$\nAPPEND initrd=/multiboot/$JustISOName/vba/initrd$\r$\n#end $JustISOName" $R0
 
 ${Else}
; Start Catch All Install Methods 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 Call FindConfig
 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/$JustISOName/$ConfigPath/$ConfigFile$\r$\nAPPEND /multiboot/$JustISOName/$ConfigPath$\r$\n#end $JustISOName" $R0 

; For Ubuntu Desktop and derivatives
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
  ${EndIf}
  
; Alt For derivatives like Dr.Web Livedisk
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg" ; Rename the following for syslinux txt.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\text.cfg" ; Rename the following for syslinux text.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" ; Rename the following for syslinux.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
  ${EndIf}

; Disable Ubuntu modified gfxboot as older Ubuntu bootlogo archives might not contain all necessary files for newer syslinux 6+.
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg 
   	 ${StrContains} $0 "buntu-17" "$JustISO"   
	 ${StrContains} $1 "buntu-16" "$JustISO"
     ${StrContains} $2 "buntu-15" "$JustISO" 
     ${If} $0 != "buntu-17" 
     ${AndIf} $1 != "buntu-16"  
	 ${AndIf} $2 != "buntu-15"  
     !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
     ${EndIf}
   ${EndIf}  
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"
   	 ${StrContains} $0 "buntu-17" "$JustISO"   
	 ${StrContains} $1 "buntu-16" "$JustISO"
     ${StrContains} $2 "buntu-15" "$JustISO" 
     ${If} $0 != "buntu-17" 
     ${AndIf} $1 != "buntu-16"  
	 ${AndIf} $2 != "buntu-15"  
     !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"      
     ${EndIf}
   ${EndIf}
; Various Antivius (New Method) 
  ${If} $DistroName == "ESET SysRescue Live"
  ${OrIf} $DistroName == "Dr.Web LiveDisk" 
; Disable Ubuntu modified gfxboot as the Ubuntu bootlogo archive does not currently contain all necessary files for newer syslinux 6+.
    ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg  
    !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
    ${EndIf} 
    ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"
    !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"      
    ${EndIf}
  ${EndIf}
  
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
  !insertmacro ReplaceInFile "/casper/vmlinuz" "/multiboot/$JustISOName/casper/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
  !insertmacro ReplaceInFile "/casper/initrd" "/multiboot/$JustISOName/casper/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" 
  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
  ${EndIf}
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" ; Rename the following for grub.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "/casper/vmlinuz" "/multiboot/$JustISOName/casper/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "/casper/initrd" "/multiboot/$JustISOName/casper/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"   
  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  ${EndIf}  

; For Ubuntu Server  
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"    
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"     
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"   
   ; Ubuntu Server amd64
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"    
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*"     
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"    
  ${EndIf}  
  
; OpenMediaVault - NOT WORKING YET
  ; ${IfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"  
   ; ${AndIfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*" 
    ; ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
   ; !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"   
   ; !insertmacro ReplaceInFile "initrd=/install/initrd.gz" "initrd=/multiboot/$JustISOName/install/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"   
   ; ${EndIf} 
  
; For Debian Based and derivatives
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" ; Rename the following for isolinux live.cfg
  !insertmacro ReplaceInFile "linux /live/" "linux /multiboot/$JustISOName/live/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"  
  !insertmacro ReplaceInFile "initrd /live/" "initrd /multiboot/$JustISOName/live/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
  !insertmacro ReplaceInFile "append boot=live" "append live-media-path=/multiboot/$JustISOName/live cdrom-detect/try-usb=true noprompt boot=live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\install.cfg" ; Rename the following for isolinux install.cfg  
  !insertmacro ReplaceInFile "linux /install/" "linux /multiboot/$JustISOName/install/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg"  
  !insertmacro ReplaceInFile "initrd /install/" "initrd /multiboot/$JustISOName/install/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg" 
  !insertmacro ReplaceInFile "-- quiet" "cdrom-detect/try-usb=true quiet" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg"
  ${EndIf}  
  
; SolydX
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\solydxk\filesystem.squashfs" 
  !insertmacro ReplaceInFile "kernel /solydxk" "kernel /multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  !insertmacro ReplaceInFile "initrd=/solydxk" "initrd=/multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "live-media-path=/solydxk" "live-media-path=/multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  ${EndIf} 
	
; For Desinfect Distro 
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\os.cfg" ; Rename the following for isolinux os.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
  !insertmacro ReplaceInFile "BOOT_IMAGE=/casper/" "BOOT_IMAGE=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
  ${EndIf} 
   
; For Fedora Based and derivatives
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\livecd-iso-to-disk"  ; Probably Fedora based
   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=MULTIBOOT live_dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
   ${EndIf} 

; For Puppy Based and derivatives
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help2.msg"  ; Probably Puppy based  
   !insertmacro ReplaceInFile "pmedia=cd" "psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"    
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help\help.msg"  ; Probably Puppy based 
   !insertmacro ReplaceInFile "append search" "append search psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
  ${EndIf} 
  
; For Clonezilla, and DRBL
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" ; Rename the following for syslinux syslinux.cfg
  !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
  !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live/ initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux isolinux.cfg
  !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
  !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live/ initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
 ; Linux Mint 2014
  !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
  ${EndIf}
  
; Xpud
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vesamenu.c32"
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\opt\media"  
  !insertmacro ReplaceInFile "KERNEL /boot/" "KERNEL /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "/opt/media,/opt/scim" "/multiboot/$JustISOName/opt/media,/multiboot/$JustISOName/opt/scim" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "DEFAULT /boot/" "DEFAULT /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/" "MENU BACKGROUND /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  !insertmacro ReplaceInFile "APPEND initrd=/opt/media" "APPEND initrd=/multiboot/$JustISOName/opt/media" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  ${EndIf}
  
; AntivirusLiveCD, Comodo
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"  
  !insertmacro ReplaceInFile "kernel /boot/bzImage" "kernel /multiboot/$JustISOName/boot/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd*" 
  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs*"   
  !insertmacro ReplaceInFile "append initrd=/boot" "append initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  ${EndIf} 
  
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.jpg" ; Fix background Image Paths
  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.png"   
  !insertmacro ReplaceInFile "MENU BACKGROUND /boot" "MENU BACKGROUND /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  ${EndIf} 
  
; AOSS
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\system\stage1"  
   !insertmacro ReplaceInFile "KERNEL /system" "KERNEL /multiboot/$JustISOName/system" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "initrd=/system" "initrd=/multiboot/$JustISOName/system" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   !insertmacro ReplaceInFile "boot=cdrom" "boot=usb" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   ${EndIf} 
   
; TinyCore, + REVISIT WifiWay, + REVISIT Dr.Web
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vmlinuz"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd" 
   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.gz"  
   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.lz"     
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   ${EndIf}
   
; WifiSlax ; Entry initially populated by Lance, completed and submitted by Geminis Demon - continued fixes and updates by Lance 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg"  
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"     
   
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
   
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg"  

   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax-english.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax-english.cfg"   
   
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
   !insertmacro ReplaceInFile "/vmlinuz" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
   
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
   !insertmacro ReplaceInFile "/vmlinuz" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg" 
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg" 
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"

   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"

   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"   
   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
   
   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg" 
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"

   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"   
   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"   
   ${EndIf}
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\core.gz" ; TinyCore specific
   !insertmacro ReplaceInFile "initrd=/boot/core.gz" "initrd=/multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "INITRD /boot/core.gz" "INITRD /multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
   ${EndIf}
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\tinycore.gz" ; Partition Wizard, TinyCore specific
   !insertmacro ReplaceInFile "initrd=/boot/tinycore.gz" "initrd=/multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "INITRD /boot/tinycore.gz" "INITRD /multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
   ${EndIf}   
   
; F-Secure Rescue CD
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\fsecure\linux"  
   !insertmacro ReplaceInFile "kernel fsecure" "kernel /multiboot/$JustISOName/boot/isolinux/fsecure" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "initrd=fsecure" "initrd=/multiboot/$JustISOName/boot/isolinux/fsecure" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "fsecure/boot." "/multiboot/$JustISOName/boot/isolinux/fsecureNULL/boot." "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "fsecureNULL/boot." "fsecure/boot." "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   !insertmacro ReplaceInFile "APPEND ramdisk_size" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX ramdisk_size" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   ${EndIf}   

; GData
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\linux6"  
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "INITRD /boot" "INITRD /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "APPEND boot=live" "APPEND live-media-path=/multiboot/$JustISOName/live boot=live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   ${EndIf} 

; Liberte
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg"  
   !insertmacro ReplaceInFile "/liberte/boot/syslinux/" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "/liberte/boot/" "/multiboot/$JustISOName/liberte/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "cdroot_hash=" "initrd=/multiboot/$JustISOName/liberte/boot/initrd-x86.xz loop=/multiboot/$JustISOName/liberte/boot/root-x86.sfs NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
   ${EndIf}    

; Panda Safe CD, Tails
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"  
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg" 
   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg" 
   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"    
   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"
   ${EndIf}   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"  ; Tails Specific 486
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"  
   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg" 
   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"   
   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"
   ${EndIf}   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"  ; Tails Specific
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"  
   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg" 
   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"    
   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"    
   ${EndIf}   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"  
   !insertmacro ReplaceInFile "default /isolinux/vesamenu.c32" "default /multiboot/$JustISOName/isolinux/vesamenu.c32" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   ${EndIf}   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\splash.png"   
   !insertmacro ReplaceInFile "menu background /isolinux" "menu background /multiboot/$JustISOName/isolinux" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg"   
   ${EndIf} 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"  ; Tails Specific
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"  
   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg" 
   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"    
   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"    
   ${EndIf} 
   
; Webconverger
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\live.cfg"  
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\boot\live.cfg"  
   !insertmacro ReplaceInFile "initrd=/live" "noprompt live-media-path=/multiboot/$JustISOName/live initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\boot\live.cfg" 
   ${EndIf} 

; AntiX
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\antiX\vmlinuz"  
   !insertmacro ReplaceInFile "/antiX/vmlinuz" "/multiboot/$JustISOName/antiX/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "INITRD /antiX" "INITRD /multiboot/$JustISOName/antiX" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "APPEND quiet" "APPEND image_dir=/multiboot/$JustISOName/antiX" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "UI gfxboot" "default vesamenu.c32 $\r$\nprompt 0 #" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   ${EndIf}   
   
; Archlinux
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso.cfg"    
   !insertmacro ReplaceInFile "CONFIG /arch" "CONFIG /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "APPEND /arch" "APPEND /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
      
   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"     
   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"     
   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"     
   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"  

   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"     
   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"     
   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"     
   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"     
   ${EndIf}  

; Manjaro
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\.miso"  
   !insertmacro ReplaceInFile "kernel /manjaro" "kernel /multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   !insertmacro ReplaceInFile "append initrd=/manjaro" "append initrd=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "misobasedir=manjaro" "misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   !insertmacro ReplaceInFile "misolabel=MJRO" "misolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   CopyFiles "$BootDir\multiboot\$JustISOName\.miso" "$BootDir"
   ${EndIf}     

; Slax
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  
   !insertmacro ReplaceInFile "/slax/boot/" "/multiboot/$JustISOName/slax/bootNULL" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  
   !insertmacro ReplaceInFile "NULL" "/" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"   
   !insertmacro ReplaceInFile "APPEND vga=" "APPEND from=/multiboot/$JustISOName/slax changes=/multiboot/$JustISOName/slax vga=" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"
   ${EndIf}   
   
; Not Linux Kid X but maybe Slax Based   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\syslinux.cfg"  
   ${AndIf} $DistroName != "Linux Kid X" 
   !insertmacro ReplaceInFile "DEFAULT /boot/vesamenu.c32" "DEFAULT /multiboot/$JustISOName/boot/vesamenu.c32" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "APPEND vga=" "APPEND from=/multiboot/$JustISOName changes=/multiboot/$JustISOName vga=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   ${EndIf}     
   
; Porteus
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"  
   !insertmacro ReplaceInFile "APPEND initrd=" "APPEND from=/multiboot/$JustISOName initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg" 
   !insertmacro ReplaceInFile "changes=/porteus" "" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg" ;eventually use changes=/multiboot/$JustISOName/changes.dat
   ${EndIf} 

; Knoppix - tested on v6 and 7
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\KNOPPIX\KNOPPIX"    
   !insertmacro ReplaceInFile "APPEND lang=" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX lang=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "APPEND ramdisk_size" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX ramdisk_size" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
   ${EndIf}  
   
; Mandriva
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\*.*"   
   !insertmacro ReplaceInFile "append initrd=" "append live_dir=/multiboot/$JustISOName/LiveOS initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
   ${EndIf}  

; !REVISIT BROKEN Mageia
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\loopbacks\distrib-lzma.sqfs"   
   !insertmacro ReplaceInFile "root=mgalive:LABEL=Mageia" "root=mgalive:LABEL=MULTIBOOT NULL=Mageia" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
   !insertmacro ReplaceInFile "ui gfxboot.c32" "#ui NULL gfxboot.c32" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile "display /boot" "display /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   !insertmacro ReplaceInFile "append initrd=/boot" "append initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
   ${EndIf}     

; PCLinuxOS
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\livecd.sqfs"    
   !insertmacro ReplaceInFile "append livecd=livecd" "append fromusb livecd=/multiboot/$JustISOName/livecd" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile "prompt" "#prompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
   !insertmacro ReplaceInFile "ui gfxboot.com" "#ui gfxboot.com" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
   !insertmacro ReplaceInFile "timeout" "#timeout" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
   ${EndIf}     
   
; SlitaZ
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*slitaz"   
   !insertmacro ReplaceInFile "kernel /boot/isolinux" "kernel /multiboot/$JustISOName/boot/isolinux" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile ",/boot" ",/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
   !insertmacro ReplaceInFile "append /md5sum" "append /multiboot/$JustISOName/md5sum" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
   !insertmacro ReplaceInFile "KERNEL /boot/gpxe" "KERNEL /multiboot/$JustISOName/boot/gpxe" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
   !insertmacro ReplaceInFile "LABEL slitaz" "# LABEL slitaz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
   ${EndIf}     

; Easus Disk Copy, Panda Safe CD
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg" 
   !insertmacro ReplaceInFile "default /$CopyPath/" "default " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
   !insertmacro ReplaceInFile "menu background /$CopyPath/" "menu background " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg"  
   ${EndIf} 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
    ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"    
    !insertmacro ReplaceInFile "kernel /bzImage" "kernel /multiboot/$JustISOName/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"
    !insertmacro ReplaceInFile "initrd=/initrd" "initrd=/multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"   
   ${EndIf} 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
    ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"    
    !insertmacro ReplaceInFile "kernel /bzImage" "kernel /multiboot/$JustISOName/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"
    !insertmacro ReplaceInFile "initrd=/initrd" "initrd=/multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"   
   ${EndIf} 
 
; ESET SysRescue Live
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\eset-favicon.ico" 
   !insertmacro ReplaceInFile "live-media=/dev/disk/by-label/eSysRescueLiveCD" " " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\txt.cfg"    
   ${EndIf} 
   
; GRML (system rescue)
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\addon_10_grub2.cfg" 
   !insertmacro ReplaceInFile "kernel /boot/addons/mboot.c32 /boot/grub/grub.img" "kernel /multiboot/$JustISOName/boot/addons/mboot.c32 /multiboot/$JustISOName/boot/grub/grub.img" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_10_grub2.cfg" 
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_20_allinone.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_20_allinone.cfg"
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_25_gxpe.cfg"     
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_30_dos.cfg"     
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_30_dos.cfg" 
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_35_bsd.cfg"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_40_memtest.cfg"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_45_hdt.cfg"  
   !insertmacro ReplaceInFile "pciids=/boot" "pciids=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_45_hdt.cfg"    
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"       
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"     
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml32_full_grml.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml32_full_grml.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg" 
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"
   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"   
    ${EndIf}  

; Ophcrack
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"     
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\be.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\be.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\br.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\br.cfg"
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg"  
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de.cfg"
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de_CH.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de_CH.cfg"    
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\en.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\en.cfg"       
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\es.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\es.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fi.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fi.cfg"  
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr_CH.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr_CH.cfg"   
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hu.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hu.cfg"    
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\it.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\it.cfg" 
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\jp.cfg" 
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\jp.cfg"    
   ${EndIf}  

; RIP Linux
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\BOOT\DOC\RIPLINUX.TXT" 
   !insertmacro ReplaceInFile "F1 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "F2 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "F3 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
   ${EndIf}  
   
; Trinity Rescue Kit
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\trk3\trkramfs" 
   CopyFiles "$BootDir\multiboot\$JustISOName\trk3\*.*" "$BootDir\trk3\" 
   RMDir /R "$BootDir\multiboot\$JustISOName\trk3" 
   !insertmacro ReplaceInFile "initrd=initrd.trk r" "initrd=initrd.trk vollabel=MULTIBOOT r" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
   ${EndIf}  
  
  Call OldSysFix  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
 ${EndIf} 
; End Catch All Install Methods
  
; Start Distro Specific 
 ${If} $JustISO == "ubuntu-13.10-server-i386.iso"
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 i386
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
  
 ${ElseIf} $JustISO == "ubuntu-13.10-server-amd64.iso"
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 amd64
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     

 ${ElseIf} $JustISO == "ubuntu-13.04-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-13.04.2-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-13.04.3-server-i386.iso" 
 ${OrIf} $JustISO == "ubuntu-13.04.4-server-i386.iso" 
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 i386
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
  
 ${ElseIf} $JustISO == "ubuntu-13.04-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-13.04.2-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-13.04.3-server-i386.iso" 
 ${OrIf} $JustISO == "ubuntu-13.04.4-server-i386.iso" 
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 amd64
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     

 ${ElseIf} $JustISO == "ubuntu-12.10-server-i386.iso"
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 i386
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
  
 ${ElseIf} $JustISO == "ubuntu-12.10-server-amd64.iso"
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 amd64
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files      
  
 ${ElseIf} $JustISO == "ubuntu-12.04-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-12.04.2-server-i386.iso"
 ${OrIf} $JustISO == "ubuntu-12.04.3-server-i386.iso" 
 ${OrIf} $JustISO == "ubuntu-12.04.4-server-i386.iso" 
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 i386
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
  
 ${ElseIf} $JustISO == "ubuntu-12.04-server-amd64.iso"
 ${OrIf} $JustISO == "ubuntu-12.04.2-server-amd64.iso"
 ${OrIf} $JustISO == "ubuntu-12.04.3-server-amd64.iso" 
 ${OrIf} $JustISO == "ubuntu-12.04.4-server-amd64.iso"
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 amd64
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files       
   
; Parted Magic
 ${ElseIf} $DistroName == "Parted Magic (Partition Tools)" 
  !insertmacro ReplaceInFile "/boot/syslinux" "/multiboot/$JustISOName/boot/syslinux" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
  !insertmacro ReplaceInFile "/pmagic/initrd64.img" "/multiboot/$JustISOName/pmagic/initrd64.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
; added next 10 changes for pmagic_2015_01_13.iso
  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
  !insertmacro ReplaceInFile "/EFI/boot/grub.cfg" "/multiboot/$JustISOName/EFI/boot/grub.cfg" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"   
  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"    
  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/EFI/boot/" "/multiboot/$JustISOName/EFI/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"
   
  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "APPEND edd=" "APPEND directory=/multiboot/$JustISOName/ edd=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "APPEND iso" "APPEND directory=/multiboot/$JustISOName/ iso" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "/boot/syslinux/reboot.c32" "/multiboot/$JustISOName/boot/syslinux/reboot.c32" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "/boot/ipxe/ipxe.krn" "/multiboot/$JustISOName/boot/ipxe/ipxe.krn" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "/boot/plpbt/plpbt.bin" "/multiboot/$JustISOName/boot/plpbt/plpbt.bin" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "INITRD /boot/" "INITRD /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "LINUX /boot/" "LINUX /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
  !insertmacro ReplaceInFile "COM32 /boot/" "COM32 /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
  ; For older pmagic
 ${AndIf} $JustISO == "pmagic_2013_06_15.iso"   
 ${OrIf} $JustISO == "pmagic_2013_05_01.iso"  
  !insertmacro ReplaceInFile "edd=off load" "edd=off directory=/multiboot/$JustISOName/ load" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 

; System Rescue CD
 ${ElseIf} $DistroName == "System Rescue CD" 
  !insertmacro ReplaceInFile "INITRD initram.igz" "INITRD NULL initram.igz$\r$\nAPPEND subdir=multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
  !insertmacro ReplaceInFile "INITRD NULL initram.igz" "INITRD initram.igz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  !insertmacro ReplaceInFile "APPEND docache" "APPEND subdir=multiboot/$JustISOName docache" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  !insertmacro ReplaceInFile "APPEND nomodeset" "APPEND subdir=multiboot/$JustISOName nomodeset" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  !insertmacro ReplaceInFile "APPEND video=800x600" "APPEND subdir=multiboot/$JustISOName video=800x600" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "APPEND video=800x600" "APPEND subdir=multiboot/$JustISOName video=800x600" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "APPEND root=auto" "APPEND subdir=multiboot/$JustISOName root=auto" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "APPEND dostartx" "APPEND subdir=multiboot/$JustISOName dostartx" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "kernel /bootdisk" "kernel /multiboot/$JustISOName/bootdisk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  !insertmacro ReplaceInFile "kernel /ntpasswd" "kernel /multiboot/$JustISOName/ntpasswd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  !insertmacro ReplaceInFile "/ntpasswd/initrd.cgz,/ntpasswd/scsi.cgz" "/multiboot/$JustISOName/ntpasswd/initrd.cgz,/multiboot/$JustISOName/ntpasswd/scsi.cgz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  !insertmacro ReplaceInFile "initrd=/bootdisk" "initrd=/multiboot/$JustISOName/bootdisk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
 
; JustBrowsing 
 ${ElseIf} $DistroName == "JustBrowsing"  
;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso.cfg"
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_browser.cfg"
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg" 
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"  
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"    
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"    
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"  
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg" 
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"    
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"  
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"    
;  !insertmacro ReplaceInFile "COM32 boot" "COM32 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_hdt.cfg"  
  !insertmacro ReplaceInFile "modules_alias=boot" "modules_alias=/multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_hdt.cfg"    
;  !insertmacro ReplaceInFile "F1 boot" "F1 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_head.cfg"  
;  !insertmacro ReplaceInFile "F2 boot" "F2 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_head.cfg"  
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_http.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_http.cfg"   
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_keymaps.cfg"  
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg" 
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"    
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg"
  !insertmacro ReplaceInFile "archisolabel=%ARCHISO_LABEL%" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg" 
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg" 
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nfs.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nfs.cfg"
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe.cfg"
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe_both_inc.cfg"  
;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe_choose.cfg" 
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_32_inc.cfg"
;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_both_inc.cfg" 
;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_choose.cfg"  
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"   
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"  
;  !insertmacro ReplaceInFile "COM32 boot" "COM32 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_tail.cfg"  
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg" 
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg" 
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"  
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg" 
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"    
;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"  
;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"
  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"
  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"    
 
; Xiaopan 
  ${ElseIf} $DistroName == "Xiaopan (Penetration Testing)"   
  CopyFiles "$BootDir\multiboot\$JustISOName\cde\*.*" "$BootDir\cde\" ;(quick hack until a cde bootcode/cheatcode is made upstream from tinyCore)
  CopyFiles "$BootDir\multiboot\$JustISOName\mydata.tgz" "$BootDir\mydata.tgz"
  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/isolinux/splash.jpg" "MENU BACKGROUND /multiboot/$JustISOName/boot/isolinux/splash.jpg" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/isolinux/splash.jpg" "MENU BACKGROUND /multiboot/$JustISOName/boot/isolinux/splash.jpg" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
  
; Ophcrack
 ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg"  
  CopyFiles "$BootDir\multiboot\$JustISOName\tables\*.*" "$BootDir\tables\"
  RMDir /R "$BootDir\multiboot\$JustISOName\tables"  
 ${EndIf} 
 
; OpenSuse/BlehOS  
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg"       
   !insertmacro ReplaceInFile "ui gfxboot" "#ui NULL gfxboot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg"     
  ${EndIf}   
  
; For OpenSuSe like compilations!
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\mbrid" 
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL  
  StrCpy $SUSEDIR "$JustISOName" 
  Call MBRID  
 ${EndIf}   

; Enable Casper  
  ${If} $Persistence == "casper" ; Casper
  ${AndIf} $Casper != "0" ; Casper Slider (Size) was not Null
  ; Add Boot Code Persistent
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
  !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
  !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
  !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
  ${EndIf}
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
  !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
  ${EndIf} 
; Create Casper-rw file
  Call CasperScript  
 ${EndIf}
 
Call WriteStuff

!macroend