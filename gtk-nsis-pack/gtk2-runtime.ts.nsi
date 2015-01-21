
; NSIS2 Script for GTK2-Runtime
; by Alexander Shaduri <ashaduri 'at' gmail.com>.
; modified by Tom Schoonjans <Tom.Schoonjans 'at' gmail.com>
; Compatible with NSIS Unicode 2.45.
; Public Domain

; The naming convention is:
; Product: GTK2-Runtime;
; Directory and package names: gtk2-runtime.
; The reason for this is that when gtk3 comes out, it
; should be installable side by side with this package.


!define GTK_VERSION "2.24.25"
!define GTK_BIN_VERSION "2.10.0"
!define PRODUCT_VERSION "${GTK_VERSION}-2015-01-21-ts-win64"
!define PRODUCT_NAME "GTK2-Runtime Win64"
!define PRODUCT_PUBLISHER "Tom Schoonjans"
!define PRODUCT_WEB_SITE "https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer"
!define INSTALLER_OUTPUT_FILE "gtk2-runtime-${PRODUCT_VERSION}.exe"

;!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"

!define REGISTRY_APP_PATHS "Software\Microsoft\Windows\CurrentVersion\App Paths"


; AddToPath and friends should work with all users
!define ALL_USERS

!include nsi_env_var_update.nsh  ; EnvVar* functions
!include "FileFunc.nsh"  ; GetOptions
!include "x64.nsh"
!include "LogicLib.nsh"


; --------------- General Settings


; this is needed for proper start menu item manipulation (for all users) in vista
RequestExecutionLevel admin

; This compressor gives us the best results
SetCompressor /SOLID lzma

; Do a CRC check before installing
CRCCheck On

; This is used in titles
Name "${PRODUCT_NAME}"  ;  ${PRODUCT_VERSION}

; Output File Name
OutFile "${INSTALLER_OUTPUT_FILE}"


; The Default Installation Directory
InstallDir "$PROGRAMFILES64\${PRODUCT_NAME}"
;InstallDir "$WINDIR"
; Detect the old installation
InstallDirRegKey HKLM "SOFTWARE\${PRODUCT_NAME}" ""
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

ShowInstDetails show
ShowUnInstDetails show





; --------------------- MUI INTERFACE

; MUI 2.0 compatible install
!include "MUI2.nsh"
!include "InstallOptions.nsh"

; Icon "gtk.ico"
; UninstallIcon "gtk.ico"

; MUI Settings
!define MUI_ABORTWARNING
;!define MUI_ICON "nsi_install.ico"
!define MUI_ICON "gtk.ico"
;!define MUI_UNICON "nsi_uninstall.ico"
!define MUI_UNICON "gtk.ico"


; Things that need to be extracted on first (keep these lines before any File command!)
; Only useful for BZIP2 compression
ReserveFile "nsi_pathpage.ini"
ReserveFile "nsi_configpage.ini"
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"


; Pages to show during installation
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_COMPONENTS
Page custom PathPage PathPageExit ; Custom page
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE DirectoryPageExit
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

;!define MUI_FINISHPAGE_RUN "$INSTDIR\gtk2-runtime\gtk2_prefs.exe"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Example.file"
;!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_NOAUTOCLOSE
;!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!insertmacro MUI_PAGE_FINISH



; Uninstaller page
!insertmacro MUI_UNPAGE_CONFIRM
UninstPage custom un.DeleteConfig  ;Custom page
!insertmacro MUI_UNPAGE_INSTFILES




Function PathPage
	!insertmacro MUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
	!insertmacro INSTALLOPTIONS_DISPLAY "nsi_pathpage.ini"
FunctionEnd


; Note: These options are unsupported unless the installer is launched in silent mode (/S).
; e.g. /setpath=no /dllpath=root /sideeffects=no
var install_option_setpath  ; set PATH: yes (default), no
var install_option_dllpath  ; bin (default), lib, root
var install_option_sideeffects  ; yes (default), no. no = don't write to registry, PATH or start menu.
var install_option_translations  ; install translations: yes, no (default)
var install_option_removeold  ; uninstall the old version first (if present): yes (default), no.

var LIB_INSTDIR
var DLL_DIR_NAME
var DLL_TMP


; Executed when leaving PathPage page.
; Sets DLL_DIR_NAME to dll directory name.
Function PathPageExit
	
	IfSilent dllpath_silent
		; if not silent, show a page with radiobuttons
		!insertmacro INSTALLOPTIONS_READ $DLL_TMP "nsi_pathpage.ini" "Field 3" "State"
		StrCmp $DLL_TMP "1" goto_dll_bin
		!insertmacro INSTALLOPTIONS_READ $DLL_TMP "nsi_pathpage.ini" "Field 4" "State"
		StrCmp $DLL_TMP "1" goto_dll_lib
		!insertmacro INSTALLOPTIONS_READ $DLL_TMP "nsi_pathpage.ini" "Field 5" "State"
		StrCmp $DLL_TMP "1" goto_dll_none
		goto dllpath_exit
	dllpath_silent:
		; if silent, use the /dllpath= option
		StrCmp $install_option_dllpath "bin" goto_dll_bin
		StrCmp $install_option_dllpath "lib" goto_dll_lib
		StrCmp $install_option_dllpath "root" goto_dll_none goto_dll_bin  ; default to bin if not matched
	dllpath_exit:

	goto_dll_none:
		StrCpy $DLL_DIR_NAME ""
		goto goto_dll_exit
	goto_dll_lib:
		StrCpy $DLL_DIR_NAME "lib"
		goto goto_dll_exit
	goto_dll_bin:
		StrCpy $DLL_DIR_NAME "bin"
		goto goto_dll_exit
	goto_dll_exit:

FunctionEnd


; Set $LIB_INSTDIR to <instpath>\bin, <instpath>\lib or <instpath>\ .
; Must be after the directory selection page.
Function DirectoryPageExit
	StrCpy $LIB_INSTDIR "$INSTDIR"
	StrCmp $DLL_DIR_NAME "" no_dll_append
		StrCpy $LIB_INSTDIR "$INSTDIR\$DLL_DIR_NAME"
	no_dll_append:
FunctionEnd



Function un.DeleteConfig
	; !insertmacro MUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
	!insertmacro INSTALLOPTIONS_DISPLAY "nsi_configpage.ini"
FunctionEnd



; Language files
!insertmacro MUI_LANGUAGE "English"


; --------------- END MUI



;Description
LangString DESC_SecCopyUI ${LANG_ENGLISH} "GTK2 Runtime"
LangString TEXT_IO_TITLE ${LANG_ENGLISH} "GTK2 Runtime"
LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "Additional options"


;License page Introduction
;LicenseText "You must agree to this license before installing."
;License text
;LicenseData /LANG=${LANG_ENGLISH} "license.txt"





; ----------------- INSTALLATION TYPES

InstType "Recommended"  ; 1
InstType "Full"  ; 2


var SEC_TRANSLATIONS_INSTALLED


Section "GTK+ libraries (required)" SecGTK
SectionIn 1 2 RO
	SetShellVarContext all  ; use all user variables as opposed to current user
	SetOverwrite On

	SetOutPath "$LIB_INSTDIR"

	; NOTE: If you add or remove any of these,
	; be sure to do the same in the uninstall section.

	File bin\libatk-1.0-0.dll  ; atk
	File bin\libatkmm-1.6-1.dll  ; atk
	File bin\libcairo-2.dll  ; cairo, needed by gtk
	File bin\libcairo-gobject-2.dll  ; cairo. Doesn't seem to be required, but since we're distributing cairo...
	File bin\libcairo-script-interpreter-2.dll  ; cairo. Doesn't seem to be required, but since we're distributing cairo...
	File bin\libcairomm-1.0-1.dll
	File bin\libffi-6.dll  ; libffi is required by glib 
	File bin\libfontconfig-1.dll  ; fontconfig is needed for ft2 pango backend
	File bin\libfreetype-6.dll  ; freetype is needed for ft2 pango backend
	File bin\libgailutil-18.dll  ; from gtk
	File bin\libgdk_pixbuf-2.0-0.dll  ; from gtk
	File bin\libgdk-win32-2.0-0.dll  ; from gtk
	File bin\libgdkmm-2.4-1.dll
	File bin\libgio-2.0-0.dll  ; from glib
	File bin\libglib-2.0-0.dll  ; glib
	File bin\libglibmm-2.4-1.dll  ; glib
	File bin\libgiomm-2.4-1.dll  ; glib
	File bin\libsigc-2.0-0.dll
	File bin\libglibmm_generate_extra_defs-2.4-1.dll  ; glib
	File bin\libgmodule-2.0-0.dll  ; from glib
	File bin\libgobject-2.0-0.dll  ; from glib
	File bin\libgthread-2.0-0.dll  ; from glib
	File bin\libgtk-win32-2.0-0.dll  ; gtk
	File bin\libgtkmm-2.4-1.dll
	File bin\libharfbuzz-0.dll
	File bin\libintl-8.dll  ; gettext, needed by all i18n libs
	File bin\libpango-1.0-0.dll  ; pango, needed by gtk
	File bin\libpangocairo-1.0-0.dll  ; pango, needed by gtk
	File bin\libpangowin32-1.0-0.dll  ; pango, needed by gtk
	File bin\libpangoft2-1.0-0.dll  ; pango, needed by gtk
	File bin\libpangomm-1.4-1.dll
	File bin\libpixman-1-0.dll  ; libpixman, needed by cairo
	File bin\libpng16-16.dll  ; for gdk_pixbuf loader.
	File bin\libxml2-2.dll  ; fontconfig needs this
	File bin\zlib1.dll  ; png and many others need this
	File bin\libstdc++_64-6.dll
	File bin\libgcc_s_seh_64-1.dll

	; We install this into the same place as the DLLs to avoid any PATH manipulation.
	SetOutPath "$LIB_INSTDIR"
	File bin\fc-cache.exe
	File bin\fc-cat.exe
	File bin\fc-list.exe
	File bin\fc-match.exe
	File bin\fc-pattern.exe
	File bin\fc-query.exe
	File bin\fc-scan.exe
	File bin\fc-validate.exe
	File bin\gdk-pixbuf-query-loaders.exe  ; from gdk_pixbuf
	File bin\gspawn-win64-helper.exe
	File bin\gspawn-win64-helper-console.exe
	File bin\gtk-query-immodules-2.0.exe
	File bin\gtk-update-icon-cache.exe
	File bin\pango-querymodules.exe
	
	
	SetOutPath "$INSTDIR"
	SetOverwrite off
	File /r etc  ; don't overwrite config files
	SetOverwrite On


	SetOutPath "$INSTDIR\lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}"
	File lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}\loaders.cache

	; SetOutPath "$INSTDIR\lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}\loaders"
	; File /r lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}\loaders

	SetOutPath "$INSTDIR\lib\gtk-2.0\modules"
	File /r lib\gtk-2.0\modules

	SetOutPath "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}"
	; no longer in gtk as of 2.14.5.
	; File /r lib\gtk-2.0\${GTK_BIN_VERSION}\immodules
	; gone as of gtk 2.16.6-2.
	; File /r lib\gtk-2.0\${GTK_BIN_VERSION}\loaders

	; wimp
	SetOutPath "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines"
	File lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libwimp*.dll
	; We install this, but other installers may not have it.
	File lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libpixmap*.dll

	SetOutPath "$INSTDIR\share\locale"
	File share\locale\locale.alias  ; from gettext

	SetOutPath "$INSTDIR\share\themes\Emacs"
	File /r share\themes\Emacs\gtk-2.0-key
	SetOutPath "$INSTDIR\share\themes"
	File /r share\themes\MS-Windows
	File /r share\themes\Raleigh


	SetOutPath "$INSTDIR\gtk2-runtime"
	; File gtk-postinstall.bat ; this file is generated now
	File license.txt
	File license_gpl.txt
	File license_lgpl.txt
	File license_png.txt
	File license_zlib.txt
	File gtk.ico  ; needed for "add/remove programs"


	; this script updates some config files, but it's unsafe
	; (gtk or pango may not work afterwards), so don't call it.
	Push $INSTDIR\gtk2-runtime\gtk-postinstall.bat
	Call WritePostInstall
	; update pango.modules, not working for now
	; Exec '$INSTDIR\gtk2-runtime\gtk-postinstall.bat'

SectionEnd ; end of gtk section





Section "Translations" SecTranslations
SectionIn 2
	SetShellVarContext all  ; use all user variables as opposed to current user
	StrCpy $SEC_TRANSLATIONS_INSTALLED "1"
	SetOutPath "$INSTDIR"
	SetOverwrite On

	; SetOutPath "$INSTDIR\lib"
	; File /r lib\locale

	; gtk (beginning with 2.12.3) uses share\locale
	SetOutPath "$INSTDIR\share"
	File /r share\locale

SectionEnd



; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SecGTK} "GTK+ 64-bit Runtime Libraries"
	!insertmacro MUI_DESCRIPTION_TEXT ${SecTranslations} "Additional translations (some are incomplete)"
!insertmacro MUI_FUNCTION_DESCRIPTION_END




; Executed on installer run
Function .onInit
	SetShellVarContext all  ; use all user variables as opposed to current user
	${IfNot} ${RunningX64} 
		MessageBox MB_OK|MB_ICONEXCLAMATION "This installation requires a 64-bit Windows system" /SD IDOK
		Abort
	${EndIf}

	SetRegView 64
		
	

	!insertmacro INSTALLOPTIONS_EXTRACT "nsi_pathpage.ini"

	StrCpy $SEC_TRANSLATIONS_INSTALLED "0"  ; set to 1 in appropriate section

	${GetOptions} "$CMDLINE" "/setpath=" $install_option_setpath
	${GetOptions} "$CMDLINE" "/dllpath=" $install_option_dllpath
	${GetOptions} "$CMDLINE" "/sideeffects=" $install_option_sideeffects
	${GetOptions} "$CMDLINE" "/translations=" $install_option_translations
	${GetOptions} "$CMDLINE" "/removeold=" $install_option_removeold

	; Debug stuff
	; MessageBox MB_ICONINFORMATION|MB_OK "/setpath=$install_option_setpath \
	;	/dllpath=$install_option_dllpath /sideeffects=$install_option_sideeffects \
	;	INSTDIR: $INSTDIR" /SD IDOK

	; if we're using /sideeffects=no, set /setpath=no, because we can't
	; revert it during uninstall (there's no dllpath in registry).
	StrCmp $install_option_sideeffects "no" "" init_sideeffects
		StrCpy $install_option_setpath "no"  ; set /setpath=no
		goto init_sideeffects_exit
	init_sideeffects:
		Call PreventMultipleInstances  ; in no-sideeffects mode this has no purpose
		Call DetectPrevInstallation  ; we don't want local installations to interfere with global ones.
	init_sideeffects_exit:


	; enable translations if requested through command line
	StrCmp $install_option_translations "yes" "" no_translations
		push $R0
		SectionGetFlags ${SecTranslations} $R0
		IntOp $R0 $R0 | ${SF_SELECTED}
		SectionSetFlags ${SecTranslations} $R0
		pop $R0
	no_translations:

	; Page callbacks are not called if in silent mode, so call these manually
	IfSilent "" +3
		Call PathPageExit
		Call DirectoryPageExit

FunctionEnd



; ------------------ POST INSTALL


var ADD_TO_PATH


Section -post
	SetShellVarContext all  ; use all user variables as opposed to current user

	IfSilent PATH_silent
		; Read a value from an InstallOptions INI File
		!insertmacro INSTALLOPTIONS_READ $ADD_TO_PATH "nsi_pathpage.ini" "Field 1" "State"
		StrCmp $ADD_TO_PATH "1" goto_set_path_yes goto_set_path_no
		goto PATH_exit
	PATH_silent:
		; if silent, use the /setpath= option
		StrCmp $install_option_setpath "no" goto_set_path_no goto_set_path_yes
	PATH_exit:


	goto_set_path_yes:
		; The user requested to add the libdir to $PATH.
		StrCpy $ADD_TO_PATH "1"
		; Push $LIB_INSTDIR
		; Call AddToPath  ; add $LIB_INSTDIR to system $PATH
		Push $0  ; result PATH
		${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$LIB_INSTDIR" ; Append
		Pop $0
		; MessageBox MB_ICONINFORMATION|MB_OK "$LIB_INSTDIR added to path"
		goto goto_set_path_exit
	goto_set_path_no:
		StrCpy $ADD_TO_PATH "0"
		goto goto_set_path_exit
	goto_set_path_exit:


	; write out uninstaller
	WriteUninstaller "$INSTDIR\gtk2_runtime_uninst.exe"

	StrCmp $install_option_sideeffects "no" no_sideeffects
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "InstallationDirectory" "$INSTDIR"
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "DllPath" "$LIB_INSTDIR"
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "Vendor" "${PRODUCT_PUBLISHER}"
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "PackageVersion" "${PRODUCT_VERSION}"
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "Version" "${GTK_VERSION}"
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "BinVersion" "${GTK_BIN_VERSION}"

		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "DllDirName" "$DLL_DIR_NAME"  ; lib, bin, or ""
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "UsingSystemPath" $ADD_TO_PATH
		WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "TranslationsInstalled" $SEC_TRANSLATIONS_INSTALLED

		; compat with installer from http://gimp-win.sourceforge.net/
		WriteRegStr HKLM "SOFTWARE\GTK\2.0" "Path" "$INSTDIR"
		WriteRegStr HKLM "SOFTWARE\GTK\2.0" "Version" "${GTK_VERSION}"
		; compat with Dropline's GTK
		WriteRegStr HKLM "SOFTWARE\GTK\2.0" "DllPath" "$LIB_INSTDIR"

		; Information for the uninstall component in "add/remove programs"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\gtk2_runtime_uninst.exe"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "InstallLocation" "$INSTDIR"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\gtk2-runtime\gtk.ico"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
		WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
		WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoModify" 1
		WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoRepair" 1

		; uninstall shortcut
		CreateDirectory "$SMPROGRAMS\GTK2 Runtime"
		CreateShortCut "$SMPROGRAMS\GTK2 Runtime\Uninstall GTK2 Runtime.lnk" "$INSTDIR\gtk2_runtime_uninst.exe" "" ""
		WriteIniStr "$SMPROGRAMS\GTK2 Runtime\Go to the website.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"


		; Write $INSTDIR\gtk2-runtime\gtk2r-env.bat
		; This script sets the GTK environment variables
		DetailPrint "Generating $INSTDIR\gtk2-runtime\gtk2r-env.bat"
		Push $INSTDIR\gtk2-runtime\gtk2r-env.bat
		Call WriteEnvBat
		DetailPrint "Done"

	no_sideeffects:

SectionEnd ; post





; ---------------- UNINSTALL


; Note: These options are unsupported unless the uninstaller is launched in silent mode (/S).
var uninstall_option_remove_config  ; yes, no (default).
var uninstall_option_sideeffects  ; yes (default), no. Use if it was installed with this option.
; These are used only if /sideffects=no :
var uninstall_option_dllpath  ; uninstall dlls from: bin (default), lib, root.
var uninstall_option_translations  ; uninstall translations: yes, no (default)


Function un.onInit
	${GetOptions} "$CMDLINE" "/remove_config=" $uninstall_option_remove_config
	${GetOptions} "$CMDLINE" "/sideeffects=" $uninstall_option_sideeffects
	${GetOptions} "$CMDLINE" "/dllpath=" $uninstall_option_dllpath
	${GetOptions} "$CMDLINE" "/translations=" $uninstall_option_translations
FunctionEnd



Function un.onUninstSuccess
	HideWindow
	MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer." /SD IDOK
FunctionEnd




var leave_config  ; don't remove global gtk config (uninstall page option)
;var INST_DIR_REG  ; installation dir from registry (uninstall stage)


; This is a separate function to allow multiple calls to it
Function un.DeleteDlls
	SetShellVarContext all  ; use all user variables as opposed to current user

	StrCpy $LIB_INSTDIR "$INSTDIR"
	StrCmp $DLL_DIR_NAME "" un_no_dll_append
		StrCpy $LIB_INSTDIR "$INSTDIR\$DLL_DIR_NAME"
	un_no_dll_append:

	; bin stuff (they are in the same directory)
	Delete $LIB_INSTDIR\fc-cache.exe
	Delete $LIB_INSTDIR\fc-cat.exe
	Delete $LIB_INSTDIR\fc-list.exe
	Delete $LIB_INSTDIR\fc-match.exe
	Delete $LIB_INSTDIR\fc-pattern.exe
	Delete $LIB_INSTDIR\fc-query.exe
	Delete $LIB_INSTDIR\fc-scan.exe
	Delete $LIB_INSTDIR\fc-validate.exe
	Delete $LIB_INSTDIR\gdk-pixbuf-query-loaders.exe
	Delete $LIB_INSTDIR\gspawn-win64-helper.exe
	Delete $LIB_INSTDIR\gspawn-win64-helper-console.exe
	Delete $LIB_INSTDIR\gtk-query-immodules-2.0.exe
	Delete $LIB_INSTDIR\gtk-update-icon-cache.exe
	Delete $LIB_INSTDIR\pango-querymodules.exe

	; dlls
	Delete $LIB_INSTDIR\libatk-1.0-0.dll  ; atk
	Delete $LIB_INSTDIR\libatkmm-1.6-1.dll  ; atk
	Delete $LIB_INSTDIR\libcairo-2.dll  ; cairo, needed by gtk
	Delete $LIB_INSTDIR\libcairo-gobject-2.dll  ; cairo. Doesn't seem to be required, but since we're distributing cairo...
	Delete $LIB_INSTDIR\libcairo-script-interpreter-2.dll  ; cairo. Doesn't seem to be required, but since we're distributing cairo...
	Delete $LIB_INSTDIR\libcairomm-1.0-1.dll
	Delete $LIB_INSTDIR\libffi-6.dll  ; libffi is required by glib 
	Delete $LIB_INSTDIR\libfontconfig-1.dll  ; fontconfig is needed for ft2 pango backend
	Delete $LIB_INSTDIR\libfreetype-6.dll  ; freetype is needed for ft2 pango backend
	Delete $LIB_INSTDIR\libgailutil-18.dll  ; from gtk
	Delete $LIB_INSTDIR\libgdk_pixbuf-2.0-0.dll  ; from gtk
	Delete $LIB_INSTDIR\libgdk-win32-2.0-0.dll  ; from gtk
	Delete $LIB_INSTDIR\libgdkmm-2.4-1.dll
	Delete $LIB_INSTDIR\libgio-2.0-0.dll  ; from glib
	Delete $LIB_INSTDIR\libglib-2.0-0.dll  ; glib
	Delete $LIB_INSTDIR\libglibmm-2.4-1.dll  ; glib
	Delete $LIB_INSTDIR\libgiomm-2.4-1.dll  ; glib
	Delete $LIB_INSTDIR\libsigc-2.0-0.dll  ; glib
	Delete $LIB_INSTDIR\libglibmm_generate_extra_defs-2.4-1.dll  ; glib
	Delete $LIB_INSTDIR\libgmodule-2.0-0.dll  ; from glib
	Delete $LIB_INSTDIR\libgobject-2.0-0.dll  ; from glib
	Delete $LIB_INSTDIR\libgthread-2.0-0.dll  ; from glib
	Delete $LIB_INSTDIR\libgtk-win32-2.0-0.dll  ; gtk
	Delete $LIB_INSTDIR\libgtkmm-2.4-1.dll
	Delete $LIB_INSTDIR\libharfbuzz-0.dll
	Delete $LIB_INSTDIR\libintl-8.dll  ; gettext, needed by all i18n libs
	Delete $LIB_INSTDIR\libpango-1.0-0.dll  ; pango, needed by gtk
	Delete $LIB_INSTDIR\libpangocairo-1.0-0.dll  ; pango, needed by gtk
	Delete $LIB_INSTDIR\libpangowin32-1.0-0.dll  ; pango, needed by gtk
	Delete $LIB_INSTDIR\libpangoft2-1.0-0.dll  ; pango, needed by gtk
	Delete $LIB_INSTDIR\libpangomm-1.4-1.dll
	Delete $LIB_INSTDIR\libpixman-1-0.dll  ; libpixman, needed by cairo
	Delete $LIB_INSTDIR\libpng16-16.dll  ; for gdk_pixbuf loader.
	Delete $LIB_INSTDIR\libxml2-2.dll  ; fontconfig needs this
	Delete $LIB_INSTDIR\zlib1.dll  ; png and many others need this
	Delete $LIB_INSTDIR\libstdc++_64-6.dll
	Delete $LIB_INSTDIR\libgcc_s_seh_64-1.dll


FunctionEnd



var found_dir
var find_handle_lang_dir


Section Uninstall
	SetShellVarContext all  ; use all user variables as opposed to current user
	SetAutoClose false

	; Note: Checking if there is a registry key present, and using it to determine
	; if this is a private installation will not work, as it will break if a parallel
	; shared installation is present.

	; ReadRegStr $INST_DIR_REG HKLM "SOFTWARE\${PRODUCT_NAME}" "InstallationDirectory"
	; StrCmp $INST_DIR_REG "" uninst_no_sideeffects
	StrCmp $uninstall_option_sideeffects "no" uninst_no_sideeffects
		; For PATH removal
		ReadRegStr $LIB_INSTDIR HKLM "SOFTWARE\${PRODUCT_NAME}" "DllPath"
		ReadRegStr $DLL_DIR_NAME HKLM "SOFTWARE\${PRODUCT_NAME}" "DllDirName"
		ReadRegStr $ADD_TO_PATH HKLM "SOFTWARE\${PRODUCT_NAME}" "UsingSystemPath"
		ReadRegStr $SEC_TRANSLATIONS_INSTALLED HKLM "SOFTWARE\${PRODUCT_NAME}" "TranslationsInstalled"

		DeleteRegKey HKLM "SOFTWARE\GTK\2.0"  ; dropline, etc...
		DeleteRegKey /ifempty HKLM "SOFTWARE\GTK"  ; don't damage other installations

		DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"
		DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"

		; FIXME: Do we have this registry key?
		; DeleteRegKey HKCU "Software\${PRODUCT_NAME}"

		Delete "$SMPROGRAMS\GTK2 Runtime\Uninstall GTK2 Runtime.lnk"
		Delete "$SMPROGRAMS\GTK2 Runtime\Go to the website.url"
		RMDir "$SMPROGRAMS\GTK2 Runtime"  ; only if empty, theme selector may still be there

		; Remove GTK from $PATH
		StrCmp $ADD_TO_PATH "0" un_nopath  ; Setting $PATH was not requested during installation
		; Push $LIB_INSTDIR
		; Call un.RemoveFromPath
		Push $0  ; result PATH
		${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$LIB_INSTDIR" ; remove
		Pop $0
		; MessageBox MB_OK "$LIB_INSTDIR removed from PATH" /SD IDOK
		un_nopath:

		; $DLL_DIR_NAME is from the registry here
		Call un.DeleteDlls

		goto delete_dlls_exit


	uninst_no_sideeffects:


		Strcpy $SEC_TRANSLATIONS_INSTALLED "0"
		StrCmp $uninstall_option_translations "yes" "" nodelete_translations
			Strcpy $SEC_TRANSLATIONS_INSTALLED "1"
		nodelete_translations:


		; All dll files. We delete them before /bin and /lib, so that
		; the directories are empty afterwards.

		; Since we have no registry, we have to remove dlls from all possible locations
		; StrCpy $DLL_DIR_NAME ""
		; Call un.DeleteDlls
		; StrCpy $DLL_DIR_NAME "bin"
		; Call un.DeleteDlls
		; StrCpy $DLL_DIR_NAME "lib"
		; Call un.DeleteDlls
		
		; Force users to use the command-line argument instead:
		; if silent, use the /dllpath= option
		StrCmp $uninstall_option_dllpath "bin" goto_undll_bin
		StrCmp $uninstall_option_dllpath "lib" goto_undll_lib
		StrCmp $uninstall_option_dllpath "root" goto_undll_none goto_undll_bin  ; default to bin if not matched

		goto_undll_none:
			StrCpy $DLL_DIR_NAME ""
			goto goto_undll_exit
		goto_undll_lib:
			StrCpy $DLL_DIR_NAME "lib"
			goto goto_undll_exit
		goto_undll_bin:
			StrCpy $DLL_DIR_NAME "bin"
			goto goto_undll_exit

		goto_undll_exit:
		    Call un.DeleteDlls

	delete_dlls_exit:


	; Delete config file?
	IfSilent "" read_config_page
		StrCmp $uninstall_option_remove_config "yes" delete_config skip_config

	read_config_page:
		!insertmacro INSTALLOPTIONS_READ $leave_config "nsi_configpage.ini" "Field 1" "State"
		StrCmp $leave_config "1" skip_config

	delete_config:
		Delete "$INSTDIR\etc\gtk-2.0\gtkrc"
	skip_config:


	Delete "$INSTDIR\etc\fonts\fonts.conf"
	RMDir "$INSTDIR\etc\fonts"  ; only if empty
	Delete "$INSTDIR\etc\pango\pango.modules"
	RMDir "$INSTDIR\etc\pango"  ; only if empty
	; Delete "$INSTDIR\etc\gtk-2.0\gdk-pixbuf.loaders"
	Delete "$INSTDIR\etc\gtk-2.0\gtk.immodules"
	Delete "$INSTDIR\etc\gtk-2.0\gtkrc.default"
	Delete "$INSTDIR\etc\gtk-2.0\im-multipress.conf"
	RMDir "$INSTDIR\etc\gtk-2.0" ; only if empty
	RMDir "$INSTDIR\etc" ; only if empty

	; some helper files here
	RMDir /r "$INSTDIR\gtk2-runtime"

	RMDir "$INSTDIR\bin"  ; only if empty

	; RMDir /r "$INSTDIR\lib"
	; pango modules are gone as of gtk 2.10
	;  RMDir /r "$INSTDIR\lib\pango"
	
	Delete "$INSTDIR\lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}\loaders.cache"
	; RMDir "$INSTDIR\lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}\loaders"  ; not forced
	RMDir "$INSTDIR\lib\gdk-pixbuf-2.0\${GTK_BIN_VERSION}"  ; not forced
	RMDir "$INSTDIR\lib\gdk-pixbuf-2.0"  ; not forced


	RMDir /r "$INSTDIR\lib\gtk-2.0\modules"

	; no longer in gtk as of 2.14.5
	; RMDir /r "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\immodules"
	; gone as of gtk 2.16.6-2
	;RMDir /r "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\loaders"

	Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libwimp*.dll"
	; there should be no problem deleting this
	Delete "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines\libpixmap*.dll"

	RMDir "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}\engines"  ; not forced
	RMDir "$INSTDIR\lib\gtk-2.0\${GTK_BIN_VERSION}"  ; not forced
	RMDir "$INSTDIR\lib\gtk-2.0"  ; not forced

	RMDir "$INSTDIR\lib"  ; not forced

	Delete "$INSTDIR\share\locale\locale.alias"  ; gettext

	; Remove our translations only
	StrCmp $SEC_TRANSLATIONS_INSTALLED "1" "" un_notranslations
		FindFirst $find_handle_lang_dir $found_dir "$INSTDIR\share\locale\*"
		find_lang_dir_next:
		; DetailPrint "LOC: $found_dir"
		StrCmp $found_dir "" find_lang_dir_done
		; check if it's a directory
		IfFileExists "$INSTDIR\share\locale\$found_dir\*.*" "" find_lang_dir_continue
		IfFileExists "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\*.*" "" find_lang_dir_continue

		Delete "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\atk10.mo"
		Delete "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\gdk-pixbuf.mo"
		Delete "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\glib20.mo"
		Delete "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\gtk20.mo"
		Delete "$INSTDIR\share\locale\$found_dir\LC_MESSAGES\gtk20-properties.mo"

		RmDir "$INSTDIR\share\locale\$found_dir\LC_MESSAGES"  ; only if empty
		RmDir "$INSTDIR\share\locale\$found_dir"

		find_lang_dir_continue:
		FindNext $find_handle_lang_dir $found_dir
		goto find_lang_dir_next
		find_lang_dir_done:
		FindClose $find_handle_lang_dir

		RMDir "$INSTDIR\share\locale"  ; only if empty, not to remove the other programs' translations
	un_notranslations:


	RMDir /r "$INSTDIR\share\themes\Raleigh"
	RMDir /r "$INSTDIR\share\themes\MS-Windows"
	RMDir /r "$INSTDIR\share\themes\Emacs"

	RMDir "$INSTDIR\share\themes"  ; not forced
	RMDir "$INSTDIR\share"  ; not forced

	Delete "$INSTDIR\gtk2_runtime_uninst.exe"

	RMDir "$INSTDIR"  ; delete only if empty

SectionEnd ; end of uninstall section






; --------------- Helpers


; WriteEnvBat
Function WriteEnvBat
	Pop $R0 ; Output file
	Push $R9
		FileOpen $R9 $R0 w
		FileWrite $R9 "@set GTK2R_PREFIX=$LIB_INSTDIR$\r$\n"
		FileWrite $R9 "$\r$\n"
		FileWrite $R9 "@echo Setting environment variables for GTK2-Runtime.$\r$\n"
		FileWrite $R9 "@echo.$\r$\n"
		FileWrite $R9 "$\r$\n"
		FileWrite $R9 "@echo set PATH=%GTK2R_PREFIX%;%%PATH%%$\r$\n"
		FileWrite $R9 "@set PATH=%GTK2R_PREFIX%;%PATH%$\r$\n"
		FileWrite $R9 "$\r$\n"
		FileWrite $R9 "@echo.$\r$\n"
		FileClose $R9
	Pop $R9
FunctionEnd



; WritePostInstall
Function WritePostInstall
	SetShellVarContext all  ; use all user variables as opposed to current user
	Pop $R0 ; Output file
	Push $R9
		FileOpen $R9 $R0 w
		FileWrite $R9 "@echo off$\r$\n"
		FileWrite $R9 "$\"$INSTDIR\bin\pango-querymodules.exe$\" > $\"$INSTDIR\etc\pango\pango.modules$\"$\r$\n"
		FileWrite $R9 "rem $\"$INSTDIR\bin\gdk-pixbuf-query-loaders.exe$\" > $\"$INSTDIR\etc\gtk-2.0\gdk-pixbuf.loaders$\"$\r$\n"
		FileWrite $R9 "$\"$INSTDIR\bin\gtk-query-immodules-2.0.exe$\" > $\"$INSTDIR\etc\gtk-2.0\gtk.immodules$\"$\r$\n"
		FileWrite $R9 "rem $\"$INSTDIR\bin\gtk-update-icon-cache.exe$\"$\r$\n"
		FileClose $R9
	Pop $R9
FunctionEnd




; Detect previous installation
Function DetectPrevInstallation
	; if /removeold=no option is given, don't check anything.
	StrCmp $install_option_removeold "no" old_detect_done

	SetShellVarContext all  ; use all user variables as opposed to current user
	push $R0

	; detect previous installation
	ReadRegStr $R0 HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
	StrCmp $R0 "" old_detect_done

	MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
		"${PRODUCT_NAME} is already installed. $\n$\nClick `OK` to remove the \
		previous version or `Cancel` to continue anyway." \
		/SD IDOK IDOK old_uninst
		; Abort
		goto old_detect_done

	; Run the old uninstaller
	old_uninst:
		ClearErrors
		IfSilent old_silent_uninst old_nosilent_uninst

		old_nosilent_uninst:
			ExecWait '$R0'
			goto old_uninst_continue

		old_silent_uninst:
			; We assume it's an NSIS-generated uninstaller.
			ExecWait '$R0 /S _?=$INSTDIR'

		old_uninst_continue:

		IfErrors old_no_remove_uninstaller

		; You can either use Delete /REBOOTOK in the uninstaller or add some code
		; here to remove to remove the uninstaller. Use a registry key to check
		; whether the user has chosen to uninstall. If you are using an uninstaller
		; components page, make sure all sections are uninstalled.
		old_no_remove_uninstaller:

	old_detect_done: ; old installation not found, all ok

	pop $R0
FunctionEnd



; Prevent running multiple instances of the installer
Function PreventMultipleInstances
	Push $R0
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t ${PRODUCT_NAME}) ?e'
	Pop $R0
	StrCmp $R0 0 +3
		MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running." /SD IDOK
		Abort
	Pop $R0
FunctionEnd




; eof
