YUMI (Your Universal Multiboot Installer) ©2011-2016 Lance http://www.pendrivelinux.com (covered under GNU GPL License) - see YUMI-Copying

Background of YUMI (Your Universal Multiboot Installer):

YUMI is an easy to use installer script created using NSIS. YUMI's purpose is to help automate the creation of a bootable USB Flash Drive that can be used to boot multiple Linux based distributions (one at a time).
The end result should be a bootable USB Flash drive that will get you up and running with your chosen Live Distributions, all without having to do the research and perform the steps by hand. 
My work consists of creating/maintaining the YUMI scripts, initial creation/changes and continued maintenance of the menu entries, adding suggested entries, and testing to make sure the distributions boot.  

How YUMI Works:

YUMI utilizes a Syslinux MBR to make the chosen drive bootable. Distributions are extracted using 7zip to the multiboot folder on the USB device, and a custom syslinux.cfg file along with distro independant configuration files are used to boot each distribution. Grub4DOS grub.exe may also be used to boot ISO files directly. 

Credits, Resources, and Third Party Tools used:

* Remnants of Cedric Tissieres's Tazusb.exe for Slitaz (slitaz@objectif-securite.ch) may reside in the YUMI script, as it was derived from UUI, which was inspired by Tazusb.exe. 
* Created with NSIS Installer © Contributors http://nsis.sourceforge.net (needed to compile the YUMI.nsi script)  
* Syslinux © H. Peter Anvin http://syslinux.zytor.com (unmodified binary used)
* grub.exe Grub4DOS © the Gna! people + Chenall https://code.google.com/p/grub4dos-chenall/ (unmodified binary used) : Official Grub4DOS: http://gna.org/projects/grub4dos/
* 7-Zip is © Igor Pavlovis http://7-zip.org (unmodified binaries were used)
* Fat32format.exe © Tom Thornhill Ridgecorp Consultants http://www.ridgecrop.demon.co.uk (unmodified binary used)
* Firadisk.img © Panot Joonkhiaw Karyonix http://reboot.pro/8804/

Additional instructions for YUMI can be found HERE: http://www.pendrivelinux.com/yumi-multiboot-usb-creator/

Changelog:
06/01/16 Version 2.0.2.3: Fixed bug: calculating remaining space on USB drive. Switch back to using vesamenu for sub-menu config files. Remove unused Prompt 0 from config. Re-enable Ubuntu gfxoot.
04/14/16 Version 2.0.2.2: Update to support Linux Kid X, Linux Lite, Subgraph OS, and Calculate Linux Desktop. Re-enable entry for Offline NT Password and Registry Editor.
04/06/16 Version 2.0.2.1: Added support for WattOS, update SLAX option, update links, disable feature to close all open explorer windows when format option is selected. Update Fat32Format.
12/28/15 Version 2.0.2.0: Add GRUB (partition 4) option. Update to support Xioapan, Windows 10, Bitdefender Rescue CD options. Update DBan option.
10/28/15 Version 2.0.1.9: Remove distributions that are no longer being developed. Fix broken links.
06/17/15 Version 2.0.1.8: Update to support newer GRML 2014-11, CentOS 7, Clonezilla 2.4.2-10, and Ultimate Edition 4.
05/14/15 Version 2.0.1.7: Update links.
03/18/15 Version 2.0.1.6: Add support for Tahrpup 6.0, Debian Live 7.8.0, and OpenSuSe 3.2.
01/20/15 Version 2.0.1.5: Fix broken 64bit option for 2015_01_13 Parted Magic entry
01/15/15 Version 2.0.1.4: Update to support 2015_01_13 Parted Magic.
01/13/15 Version 2.0.1.3: Remove Acronis True Image entry (Use Try Unlisted ISO GRUB for Acronis). Updated links.
10/30/14 Version 2.0.1.2: Enable checkbox option to forcefully Show All ISO Files.
10/29/14 Version 2.0.1.1: Update to support Linpus Lite, mintyMac, and ESET SysRescue Live. Fix AntiX boot issue. 
09/19/14 Version 2.0.1.0: Switch to use Syslinux 6.0.3 to address ERR: Couldn't read the first sector issues.
09/11/14 Version 2.0.0.9: Add Dr.Web LiveDisk. Fix broken System Rescue CD, and HDT option. Update Ubuntu download options.
08/14/14 Version 2.0.0.8: Fix Windows Vista/7/8 and Hiren's options.
07/31/14 Version 2.0.0.7: Switch to use NEW Syslinux version 6.02.
07/29/14 Version 2.0.0.6: Update to support Peach OSI
05/29/14 Version 2.0.0.5: Update Ubuntu, CentOS, and Debian Download Links. Remove Backtrack - superseded by Kali.
04/29/14 Version 2.0.0.4: Update to support CAINE and Puppy Arcade.
04/17/14 Version 2.0.0.3: Update to support Tails 0.23 and Rescatux 0.30.2 (must manually extract and use Rescatux.iso from the ISO). Correct OpenSuse links.
03/18/14 Version 2.0.0.2: Update to support newer version of Offline Windows Password & Registry Editor, LuninuX OS, Pear Linux, and Konboot 2.3 Pro.
02/20/14 Version 2.0.0.1: Fixed Linux Mint 16 Live Installer Crash!
01/30/14 Version 2.0.0.0: Added support for JustBrowsing, Mythbuntu, Bugtraq II, and older pmagic_2013_05_01.iso.
01/10/14 Version 1.9.9.9B: Added support for Fedora 20, LXLE Desktop. Fixed source compilation bug.
12/11/13 Version 1.9.9.9: Re-enabled Dr.Web, Trinity, and RIP Linux. Support Elementary 32 bit.
12/09/13 Version 1.9.9.8B: Added Acronis True Image, Sparky Linux, and SolydX
12/06/13 Version 1.9.9.8: Add option for Paid version of Kon-Boot. Added Manjaro Linux.
12/04/13 Version 1.9.9.7B: Correct ISO Name for Desinfect. Correct OpenSUSE ISO copy failed when using Windows XP. Add support for Rescatux ISO (can't use sg2d version).
11/24/13 Version 1.9.9.7: Modify chain.c32 to address Insane Primary (MBR) partition error. Correct Kaspersky Rescue Disk (Antivirus Scanner) syslinux directory coping issue on Win XP
11/22/13 Version 1.9.9.6B: Added OpenSUSE. Corrected Desinfec't misspelling.
11/20/13 Version 1.9.9.6: Add Desinfec't 2013 (German Antivirus). Fix broken older Parted Magic menu entries.
11/13/13 Version 1.9.9.5B: Add WifiSlax. Thanks to Geminis Demon for helping finish the entry!
11/12/13 Version 1.9.9.5: Added provision to ensure menu.32 exists. Fixed Falcon4 and Hiren menu creation.
11/11/13 Version 1.9.9.4: Added Persistent Option for Ubuntu and some Derivatives. Fix Kon-Boot free entry. Switch to AutoDetect Size of ISO.
11/08/13 Version 1.9.9.3: Add Liberte Linux. Fixed a menu scrolling bug (vesamenu.c32 incompatible with boot.msg?) that occurred with distros like Puppy and KNOPPIX
11/07/13 Version 1.9.9.2: Add support for TAILS, and Ultimate Boot CD
11/05/13 Version 1.9.9.1: Quick fix to support older versions of Knoppix
11/04/13 Version 1.9.9.0: Beta release of YUMI version 2