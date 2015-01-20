
; NSIS2 Script for GTK2-Themes
; by Alexander Shaduri
; Compatible with NSIS 2.40


!define PRODUCT_VERSION "2009-09-07-ash"
!define GTK_BIN_VERSION "2.10.0"
!define PRODUCT_NAME "GTK2-Themes"
!define PRODUCT_PUBLISHER "Alexander Shaduri"
!define PRODUCT_WEB_SITE "http://gtk-win.sourceforge.net"

;!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define REGISTRY_APP_PATHS "Software\Microsoft\Windows\CurrentVersion\App Paths"




; --------------- General Settings


; This compressor gives us the best results
SetCompressor /SOLID lzma

; Do a CRC check before installing
CRCCheck On

; This is used in titles
Name "${PRODUCT_NAME}"  ;  ${PRODUCT_VERSION}

; Output File Name
OutFile "gtk2-themes-${PRODUCT_VERSION}.exe"



;The Default Installation Directory
; try to install to the same directory as runtime.
; InstallDir "$PROGRAMFILES\GTK2-Runtime\"
InstallDir "$COMMONFILES\GTK\2.0\"  ; gimp-installer gtk runtime compat.
; If our installer is present, install there
InstallDirRegKey HKLM "Software\GTK2-Runtime" "InstallationDirectory"


ShowInstDetails show
ShowUnInstDetails show





; --------------------- MUI INTERFACE

; MUI 2.0 compatible install
!include "MUI2.nsh"

;Backgound Colors. uncomment to enable fullscreen.
; BGGradient 0000FF 000000 FFFFFF

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "nsi_install.ico"
!define MUI_UNICON "nsi_uninstall.ico"


;Things that need to be extracted on first (keep these lines before any File command!)
;Only useful for BZIP2 compression
!insertmacro MUI_RESERVEFILE_LANGDLL
; !insertmacro MUI_RESERVEFILE_INSTALLOPTIONS


; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"


; Pages to show during installation
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license_themes.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

;!define MUI_FINISHPAGE_RUN "$INSTDIR\gtk2-runtime\gtk2_prefs.exe"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Example.file"
;!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!insertmacro MUI_PAGE_FINISH



; Uninstaller page
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES



; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Russian"


; --------------- END MUI


;Description
LangString DESC_SecCopyUI ${LANG_ENGLISH} "GTK2 Themes"
LangString DESC_SecCopyUI ${LANG_RUSSIAN} "GTK2 Themes"

LangString TEXT_IO_TITLE ${LANG_ENGLISH} "GTK2 Themes"
LangString TEXT_IO_TITLE ${LANG_RUSSIAN} "GTK2 Themes"

LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "Additional options"
LangString TEXT_IO_SUBTITLE ${LANG_RUSSIAN} "Additional options"








; --------------- START INSTALLATION


Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

  Call PreventMultipleInstances

  Push 2 ;F ;22 = number of languages, F = change font

  ;Language selection
  LangDLL::LangDialog "Installer Language" "Please select a language."

  Pop $LANGUAGE
  StrCmp $LANGUAGE "cancel" 0 +2
  Abort


	; detect previous installation
	ReadRegStr $R0 HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
	StrCmp $R0 "" done

	MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
		"${PRODUCT_NAME} is already installed. $\n$\nClick `OK` to remove the \
		previous version or `Cancel` to continue anyway." \
		/SD IDOK IDOK uninst
		; Abort
	goto done

  ;Run the uninstaller
  uninst:
  ClearErrors
  ExecWait '$R0 _?=$INSTDIR'  ;Do not copy the uninstaller to a temp file

  IfErrors no_remove_uninstaller

  ;You can either use Delete /REBOOTOK in the uninstaller or add some code
  ;here to remove to remove the uninstaller. Use a registry key to check
  ;whether the user has chosen to uninstall. If you are using an uninstaller
  ;components page, make sure all sections are uninstalled.
  no_remove_uninstaller:

  done:
  ; old installation not found


FunctionEnd




; ----------------- INSTALLATINO TYPES

; InstType "Recommended"
InstType "Full"
;InstType "Minimal"






Section "Themes" SecThemes
SectionIn 1
  SetOutPath "$INSTDIR"
  SetOverwrite On

  SetOutPath "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines"
;  File /r lib\gtk-2.0\${GTK_BIN_VERSION}\engines
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libanachron.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libaurora.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libbluecurve.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libblueprint.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcandido.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcleanice.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libclearlooks.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcrux-engine.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libdyndyn.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libexcelsior.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libgflat.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libglide.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libhcengine.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libindustrial.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\liblighthouseblue.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmetal.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmgicchikn.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmist.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmurrine.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libnimbus.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libnodoka.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libredmond95.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\librezlooks.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libsmooth.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libthinice.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libubuntulooks.dll"
  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libxfce.dll"


  ; this file is optional. it may be installed by gtk runtime, or may be not.
  SetOverwrite Off
  ; gtk 2.14-bundled:
  File "gtk-engine\libpixmap.dll"
  ; gtk-bundled:
;  File "lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libpixmap.dll"
  SetOverwrite On


  SetOutPath "$INSTDIR\share\themes"
;  File /r share\themes

File /r "share\themes\Amaranth"
File /r "share\themes\AnachronAna"
File /r "share\themes\Aurora"
File /r "share\themes\Bluecurve"
File /r "share\themes\Bluecurve-BerriesAndCream"
File /r "share\themes\Bluecurve-Gnome"
File /r "share\themes\Bluecurve-Grape"
File /r "share\themes\Bluecurve-Lime"
File /r "share\themes\Bluecurve-Slate"
File /r "share\themes\Bluecurve-Strawberry"
File /r "share\themes\Bluecurve-Tangerine"
File /r "share\themes\Blueprint"
File /r "share\themes\Blueprint-Green"
File /r "share\themes\Blueprint-Ice"
File /r "share\themes\Blueprint-Sand"
File /r "share\themes\Blueprint-no-color"
File /r "share\themes\Candido-Calm"
File /r "share\themes\Candido-Candy"
File /r "share\themes\Candido-DarkOrange"
File /r "share\themes\Candido-Hybrid"
File /r "share\themes\Candido-NeoGraphite"
File /r "share\themes\CleanIce"
File /r "share\themes\CleanIce-Dark"
File /r "share\themes\CleanIce-Debian"
File /r "share\themes\Clearlooks"
File /r "share\themes\ClearlooksClassic"
File /r "share\themes\ClearlooksTest"
File /r "share\themes\Crux"
File /r "share\themes\Darklooks"
File /r "share\themes\Delightfully-Smooth"
File /r "share\themes\DyndynBlueGray"
File /r "share\themes\DyndynPinkGray"
File /r "share\themes\G26"
File /r "share\themes\Glider"
File /r "share\themes\Glossy"
File /r "share\themes\Gorilla"
File /r "share\themes\HighContrast"
File /r "share\themes\HighContrastInverse"
File /r "share\themes\HighContrastLargePrint"
File /r "share\themes\HighContrastLargePrintInverse"
File /r "share\themes\Human"
File /r "share\themes\Industrial"
File /r "share\themes\Inverted"
File /r "share\themes\LargePrint"
File /r "share\themes\LighthouseBlue"
File /r "share\themes\LowContrast"
File /r "share\themes\LowContrastLargePrint"
File /r "share\themes\Lush"
File /r "share\themes\Metal"
File /r "share\themes\Mist"
File /r "share\themes\MurrinaAquaIsh"
File /r "share\themes\MurrinaAzul"
File /r "share\themes\MurrinaBleu"
File /r "share\themes\MurrinaBlue"
File /r "share\themes\MurrinaCandido"
File /r "share\themes\MurrinaCandy"
File /r "share\themes\MurrinaCappuccino"
File /r "share\themes\MurrinaChrome"
File /r "share\themes\MurrinaCream"
File /r "share\themes\MurrinaEalm"
File /r "share\themes\MurrinaFancyCandy"
File /r "share\themes\MurrinaGilouche"
File /r "share\themes\MurrinaLoveGray"
File /r "share\themes\MurrinaNeoGraphite"
File /r "share\themes\MurrinaVerdeOlivo"
File /r "share\themes\Nimbus"
File /r "share\themes\Nimbus-Dark"
File /r "share\themes\Nimbus-Light"
File /r "share\themes\Nodoka"
File /r "share\themes\Nodoka-Aqua"
File /r "share\themes\Nodoka-Gilouche"
File /r "share\themes\Nodoka-Looks"
File /r "share\themes\Nodoka-Midnight"
File /r "share\themes\Nodoka-Rounded"
File /r "share\themes\Nodoka-Silver"
File /r "share\themes\Nodoka-Squared"
File /r "share\themes\Nuvola"
File /r "share\themes\Redmond"
File /r "share\themes\Rezlooks-Gilouche"
File /r "share\themes\Rezlooks-Snow"
File /r "share\themes\Rezlooks-candy"
File /r "share\themes\Rezlooks-dark"
File /r "share\themes\Rezlooks-graphite"
File /r "share\themes\Simple"
File /r "share\themes\Smooth-Funky-Monkey"
File /r "share\themes\Smooth-Line"
File /r "share\themes\Smooth-Okayish"
File /r "share\themes\Smooth-Sea-Ice"
File /r "share\themes\Smooth-Tangerine-Dream"
File /r "share\themes\Smooth-Winter"
File /r "share\themes\ThinIce"
File /r "share\themes\Unity"
File /r "share\themes\Wasp"
File /r "share\themes\Xcl-aqua"
File /r "share\themes\Xcl-aqua-dark"
File /r "share\themes\Xcl-bubblegum"
File /r "share\themes\Xcl-bubblegum-dark"
File /r "share\themes\Xcl-clarius"
File /r "share\themes\Xcl-clarius-dark"
File /r "share\themes\Xcl-flat"
File /r "share\themes\Xcl-flat-dark"
File /r "share\themes\Xcl-inverted"
File /r "share\themes\Xcl-inverted-dark"
File /r "share\themes\Xfce"
File /r "share\themes\Xfce-4.0"
File /r "share\themes\Xfce-4.2"
File /r "share\themes\Xfce-4.4"

SectionEnd




Section "GTK2 Preference Utility" SecGtkPrefs
SectionIn 1

  SetOverwrite On
  SetOutPath "$INSTDIR"

  File gtk2_prefs.exe
  File gtk.ico


  ; set a special path for this exe, as GTK may not be in a global path.
  ReadRegStr $R3 HKLM "SOFTWARE\GTK\2.0" "DllPath"
  WriteRegStr HKLM "${REGISTRY_APP_PATHS}\gtk2_prefs.exe" "Path" "$R3"


  CreateDirectory "$SMPROGRAMS\GTK2 Runtime"
  CreateShortCut "$SMPROGRAMS\GTK2 Runtime\Change GTK2 Appearance.lnk" "$INSTDIR\gtk2_prefs.exe" "" "$INSTDIR\gtk.ico" ""

SectionEnd




!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecThemes} "GTK2 theme engines and themes to improve its look"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGtkPrefs} "GTK2 Preference Utility to change the theme and font of GTK2 applications"
!insertmacro MUI_FUNCTION_DESCRIPTION_END





; ------------------ POST INSTALL


!define TEMP $R0

Section -post

  WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "InstallationDirectory" "$INSTDIR"
  WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "Vendor" "Alex Shaduri"

  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\gtk2_themes_uninst.exe"

  ; We don't need this, MUI takes care for us
  WriteRegStr HKCU "Software\${PRODUCT_NAME}" "Installer Language" $LANGUAGE

  ; uninstall shortcut
  CreateDirectory "$SMPROGRAMS\GTK2 Runtime"
  CreateShortCut "$SMPROGRAMS\GTK2 Runtime\Uninstall GTK2 Themes.lnk" "$INSTDIR\gtk2_themes_uninst.exe" "" ""


  ; write out uninstaller
  WriteUninstaller "$INSTDIR\gtk2_themes_uninst.exe"

SectionEnd ; post





; ---------------- UNINSTALL



Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer." /SD IDOK
FunctionEnd




Section Uninstall

  SetAutoClose false

  ; add delete commands to delete whatever files/registry keys/etc you installed here.
  Delete "$INSTDIR\gtk2_themes_uninst.exe"

  DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"
  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"

  ; FIXME: Do we have this registry key?
  DeleteRegKey HKCU "Software\${PRODUCT_NAME}"

  DeleteRegKey HKLM "${REGISTRY_APP_PATHS}\gtk2_prefs.exe"

  Delete "$INSTDIR\gtk2_prefs.exe"
  Delete "$INSTDIR\gtk.ico"

  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libanachron.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libaurora.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libbluecurve.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libblueprint.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcandido.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcleanice.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libclearlooks.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libcrux-engine.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libdyndyn.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libexcelsior.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libgflat.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libglide.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libhcengine.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libindustrial.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\liblighthouseblue.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmetal.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmgicchikn.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmist.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libmurrine.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libnimbus.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libnodoka.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libredmond95.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\librezlooks.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libsmooth.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libthinice.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libubuntulooks.dll"
  Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libxfce.dll"


  ; FIXME: STALE FILE!
  ; we should not delete this, it may be owned by gtk-runtime.
  ; Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libpixmap.dll"

  RMDir "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines"
  RMDir "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}"  ; not forced
  RMDir "$INSTDIR\lib\gtk-2.0"  ; not forced
  RMDir "$INSTDIR\lib"

;  RMDir /r  "$INSTDIR\share"

RMDir /r "$INSTDIR\share\themes\Amaranth"
RMDir /r "$INSTDIR\share\themes\AnachronAna"
RMDir /r "$INSTDIR\share\themes\Aurora"
RMDir /r "$INSTDIR\share\themes\Bluecurve"
RMDir /r "$INSTDIR\share\themes\Bluecurve-BerriesAndCream"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Gnome"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Grape"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Lime"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Slate"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Strawberry"
RMDir /r "$INSTDIR\share\themes\Bluecurve-Tangerine"
RMDir /r "$INSTDIR\share\themes\Blueprint"
RMDir /r "$INSTDIR\share\themes\Blueprint-Green"
RMDir /r "$INSTDIR\share\themes\Blueprint-Ice"
RMDir /r "$INSTDIR\share\themes\Blueprint-Sand"
RMDir /r "$INSTDIR\share\themes\Blueprint-no-color"
RMDir /r "$INSTDIR\share\themes\Candido-Calm"
RMDir /r "$INSTDIR\share\themes\Candido-Candy"
RMDir /r "$INSTDIR\share\themes\Candido-DarkOrange"
RMDir /r "$INSTDIR\share\themes\Candido-Hybrid"
RMDir /r "$INSTDIR\share\themes\Candido-NeoGraphite"
RMDir /r "$INSTDIR\share\themes\CleanIce"
RMDir /r "$INSTDIR\share\themes\CleanIce-Dark"
RMDir /r "$INSTDIR\share\themes\CleanIce-Debian"
RMDir /r "$INSTDIR\share\themes\Clearlooks"
RMDir /r "$INSTDIR\share\themes\ClearlooksClassic"
RMDir /r "$INSTDIR\share\themes\ClearlooksTest"
RMDir /r "$INSTDIR\share\themes\Crux"
RMDir /r "$INSTDIR\share\themes\Darklooks"
RMDir /r "$INSTDIR\share\themes\Delightfully-Smooth"
RMDir /r "$INSTDIR\share\themes\DyndynBlueGray"
RMDir /r "$INSTDIR\share\themes\DyndynPinkGray"
RMDir /r "$INSTDIR\share\themes\G26"
RMDir /r "$INSTDIR\share\themes\Glider"
RMDir /r "$INSTDIR\share\themes\Glossy"
RMDir /r "$INSTDIR\share\themes\Gorilla"
RMDir /r "$INSTDIR\share\themes\HighContrast"
RMDir /r "$INSTDIR\share\themes\HighContrastInverse"
RMDir /r "$INSTDIR\share\themes\HighContrastLargePrint"
RMDir /r "$INSTDIR\share\themes\HighContrastLargePrintInverse"
RMDir /r "$INSTDIR\share\themes\Human"
RMDir /r "$INSTDIR\share\themes\Industrial"
RMDir /r "$INSTDIR\share\themes\Inverted"
RMDir /r "$INSTDIR\share\themes\LargePrint"
RMDir /r "$INSTDIR\share\themes\LighthouseBlue"
RMDir /r "$INSTDIR\share\themes\LowContrast"
RMDir /r "$INSTDIR\share\themes\LowContrastLargePrint"
RMDir /r "$INSTDIR\share\themes\Lush"
RMDir /r "$INSTDIR\share\themes\Metal"
RMDir /r "$INSTDIR\share\themes\Mist"
RMDir /r "$INSTDIR\share\themes\MurrinaAquaIsh"
RMDir /r "$INSTDIR\share\themes\MurrinaAzul"
RMDir /r "$INSTDIR\share\themes\MurrinaBleu"
RMDir /r "$INSTDIR\share\themes\MurrinaBlue"
RMDir /r "$INSTDIR\share\themes\MurrinaCandido"
RMDir /r "$INSTDIR\share\themes\MurrinaCandy"
RMDir /r "$INSTDIR\share\themes\MurrinaCappuccino"
RMDir /r "$INSTDIR\share\themes\MurrinaChrome"
RMDir /r "$INSTDIR\share\themes\MurrinaCream"
RMDir /r "$INSTDIR\share\themes\MurrinaEalm"
RMDir /r "$INSTDIR\share\themes\MurrinaFancyCandy"
RMDir /r "$INSTDIR\share\themes\MurrinaGilouche"
RMDir /r "$INSTDIR\share\themes\MurrinaLoveGray"
RMDir /r "$INSTDIR\share\themes\MurrinaNeoGraphite"
RMDir /r "$INSTDIR\share\themes\MurrinaVerdeOlivo"
RMDir /r "$INSTDIR\share\themes\Nimbus"
RMDir /r "$INSTDIR\share\themes\Nimbus-Dark"
RMDir /r "$INSTDIR\share\themes\Nimbus-Light"
RMDir /r "$INSTDIR\share\themes\Nodoka"
RMDir /r "$INSTDIR\share\themes\Nodoka-Aqua"
RMDir /r "$INSTDIR\share\themes\Nodoka-Gilouche"
RMDir /r "$INSTDIR\share\themes\Nodoka-Looks"
RMDir /r "$INSTDIR\share\themes\Nodoka-Midnight"
RMDir /r "$INSTDIR\share\themes\Nodoka-Rounded"
RMDir /r "$INSTDIR\share\themes\Nodoka-Silver"
RMDir /r "$INSTDIR\share\themes\Nodoka-Squared"
RMDir /r "$INSTDIR\share\themes\Nuvola"
RMDir /r "$INSTDIR\share\themes\Redmond"
RMDir /r "$INSTDIR\share\themes\Rezlooks-Gilouche"
RMDir /r "$INSTDIR\share\themes\Rezlooks-Snow"
RMDir /r "$INSTDIR\share\themes\Rezlooks-candy"
RMDir /r "$INSTDIR\share\themes\Rezlooks-dark"
RMDir /r "$INSTDIR\share\themes\Rezlooks-graphite"
RMDir /r "$INSTDIR\share\themes\Simple"
RMDir /r "$INSTDIR\share\themes\Smooth-Funky-Monkey"
RMDir /r "$INSTDIR\share\themes\Smooth-Line"
RMDir /r "$INSTDIR\share\themes\Smooth-Okayish"
RMDir /r "$INSTDIR\share\themes\Smooth-Sea-Ice"
RMDir /r "$INSTDIR\share\themes\Smooth-Tangerine-Dream"
RMDir /r "$INSTDIR\share\themes\Smooth-Winter"
RMDir /r "$INSTDIR\share\themes\ThinIce"
RMDir /r "$INSTDIR\share\themes\Unity"
RMDir /r "$INSTDIR\share\themes\Wasp"
RMDir /r "$INSTDIR\share\themes\Xcl-aqua"
RMDir /r "$INSTDIR\share\themes\Xcl-aqua-dark"
RMDir /r "$INSTDIR\share\themes\Xcl-bubblegum"
RMDir /r "$INSTDIR\share\themes\Xcl-bubblegum-dark"
RMDir /r "$INSTDIR\share\themes\Xcl-clarius"
RMDir /r "$INSTDIR\share\themes\Xcl-clarius-dark"
RMDir /r "$INSTDIR\share\themes\Xcl-flat"
RMDir /r "$INSTDIR\share\themes\Xcl-flat-dark"
RMDir /r "$INSTDIR\share\themes\Xcl-inverted"
RMDir /r "$INSTDIR\share\themes\Xcl-inverted-dark"
RMDir /r "$INSTDIR\share\themes\Xfce"
RMDir /r "$INSTDIR\share\themes\Xfce-4.0"
RMDir /r "$INSTDIR\share\themes\Xfce-4.2"
RMDir /r "$INSTDIR\share\themes\Xfce-4.4"

  RMDir "$INSTDIR\share\themes"  ; not forced
  RMDir "$INSTDIR\share"  ; not forced

  ; only delete if empty
  RMDir "$INSTDIR"

  ; FIXME: do we need this after deletion of instdir?
;  RMDir /r "$SMPROGRAMS\GTK2 Runtime"
  Delete "$SMPROGRAMS\GTK2 Runtime\Change GTK2 Appearance.lnk"
  Delete "$SMPROGRAMS\GTK2 Runtime\Uninstall GTK2 Themes.lnk"

  RMDir "$SMPROGRAMS\GTK2 Runtime"  ; gtk-runtime may still be there


SectionEnd ; end of uninstall section



; Prevent running multiple instances of the installer
Function PreventMultipleInstances
  Push $R0
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${PRODUCT_NAME}") ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running." /SD IDOK
    Abort
  Pop $R0
FunctionEnd



; eof