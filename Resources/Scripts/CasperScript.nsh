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

; ------------ Casper Script --------------
Function CasperScript
${If} $Casper != "0"
 Call GetCaspTools
  ${If} $DistroName == "Debian Live"
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\multiboot\$JustISOName\live-rw bs=1M count=$Casper --progress'
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L live-rw $BootDir\multiboot\$JustISOName\live-rw'	; was using -b 1024
  ${Else}
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\multiboot\$JustISOName\casper-rw bs=1M count=$Casper --progress'
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L casper-rw $BootDir\multiboot\$JustISOName\casper-rw'	; was using -b 1024
  ${EndIf} 
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "dd.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "mke2fs.exe"
DetailPrint "Now Creating a Casper RW File" 
DetailPrint "Creating the Persistent File: The progress bar will not move until finished. Please be patient..." 
FunctionEnd