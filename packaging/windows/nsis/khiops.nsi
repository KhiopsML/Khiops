# Khiops installer builder NSIS script
# You may use "!define DEBUG" to have informational boxes in the installer

# Set Unicode to avoid warning 7998: "ANSI targets are deprecated"
Unicode True

# Set compresion to LZMA (faster)
SetCompressor /SOLID lzma

# Include NSIS librairies

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "x64.nsh"
!include "winmessages.nsh"

# Include Custom libraries
!include "KhiopsGlobals.nsh"
!include "GetCoresCount.nsh"
!include "CreateKhiopsEnvCmdFileFunc.nsh"
!include "CreateKhiopsCmdFileFunc.nsh"
!include "KhiopsPrerequisiteFunc.nsh"

# Definitions for registry change notification
!define SHCNE_ASSOCCHANGED 0x8000000
!define SHCNF_IDLIST 0

# Macro to check input parameter definitions
!macro CheckInputParameter ParameterName
  !ifndef ${ParameterName}
    !error "${ParameterName} is not defined. Use makesis flag '-D${ParameterName}=...' to define it."
  !endif
!macroend

# Check the mandatory input definitions
!insertmacro CheckInputParameter KHIOPS_VERSION
!insertmacro CheckInputParameter KHIOPS_WINDOWS_BUILD_DIR
!insertmacro CheckInputParameter KHIOPS_VISUALIZATION_INSTALLER_PATH
!insertmacro CheckInputParameter KHIOPS_COVISUALIZATION_INSTALLER_PATH
!insertmacro CheckInputParameter JRE_INSTALLER_PATH
!insertmacro CheckInputParameter MSMPI_INSTALLER_PATH

# Application name and installer file name
Name "Khiops ${KHIOPS_VERSION}"
OutFile "khiops-${KHIOPS_VERSION}-setup.exe"

# Get installation folder from registry if available
InstallDirRegKey HKLM Software\khiops ""

# Request admin privileges
RequestExecutionLevel admin


########################
# Variable definitions #
########################

# MPI installation flag
Var /GLOBAL IsMPIRequired

# Flag d'installation des prerequis logiciels
Var /GLOBAL MPIInstallationNeeded
Var /GLOBAL JavaInstallationNeeded

# Messages d'installation des prerequis
Var /GLOBAL MPIInstallationMessage
Var /GLOBAL JavaInstallationMessage

# Number of physical cores
Var /GLOBAL PhysicalCoresNumber

# Number of processes to use
Var /GLOBAL ProcessNumber

# Root key for the uninstaller in the windows registry
!define UninstallerKey "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

###########################
# Interface Configuration #
###########################

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\common\images\installer_khiopsleft.bmp" ; optional
!define MUI_HEADERIMAGE_LEFT
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\common\images\installer_khiopswelcome.bmp"
!define MUI_ABORTWARNING
!define MUI_ICON "..\common\images\installer_khiops.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
BrandingText "Orange Labs"

###################
# Installer Pages #
###################

# Welcome page
!define MUI_WELCOMEPAGE_TITLE "Welcome to the Khiops ${KHIOPS_VERSION} Setup Wizard"
!define MUI_WELCOMEPAGE_TEXT \
    "Khiops is a data mining tool includes data preparation and scoring, visualization, coclustering and covisualization.$\r$\n$\r$\n$\r$\n$\r$\n$(MUI_${MUI_PAGE_UNINSTALLER_PREFIX}TEXT_WELCOME_INFO_TEXT)"
!insertmacro MUI_PAGE_WELCOME

# Licence page
!insertmacro MUI_PAGE_LICENSE "..\..\LICENCE"

# Custom page for requirements software
Page custom RequirementsPageShow RequirementsPageLeave

# Install directory choice page
!insertmacro MUI_PAGE_DIRECTORY

# Install files choice page
!insertmacro MUI_PAGE_INSTFILES

# Final page
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Create desktop shortcut"
!define MUI_FINISHPAGE_RUN_FUNCTION "CreateDesktopShortcuts"
!define MUI_FINISHPAGE_TEXT "$\r$\n$\r$\nThank you for installing Khiops."
!define MUI_FINISHPAGE_LINK "www.khiops.com"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.khiops.com"
!insertmacro MUI_PAGE_FINISH

Function "CreateDesktopShortcuts"
  DetailPrint "Installing Desktop Shortcut..."
  SetOutPath "$INSTDIR"
  CreateShortCut "$DESKTOP\Khiops.lnk" "$INSTDIR\bin\khiops.cmd" "" "$INSTDIR\bin\icons\khiops.ico" 0 SW_SHOWMINIMIZED
  CreateShortCut "$DESKTOP\Khiops Coclustering.lnk" "$INSTDIR\bin\khiops_coclustering.cmd" "" "$INSTDIR\bin\icons\khiops_coclustering.ico" 0 SW_SHOWMINIMIZED
FunctionEnd

# Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Language (must be defined after uninstaller)
!insertmacro MUI_LANGUAGE "English"

#######################
# Version Information #
#######################

VIProductVersion "${KHIOPS_VERSION}.0.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Khiops"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Orange"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Copyright (c) 2023 Orange"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Khiops Installer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${KHIOPS_VERSION}"

######################
# Installer Sections #
######################

Section "Install" SecInstall

  # Sets whether install logging to $INSTDIR\install.log will happen (require NSIS_CONFIG_LOG)
  #LogSet on

  # In order to have shortcuts and documents for all users
  SetShellVarContext all

  # Detect Java
  #LogText "=== Auto-detection of Java ==="
  Call RequirementsDetection

  ;
  ${If} $JavaInstallationNeeded == "1"
      # LogText "=== Java installation ==="
      Call InstallJava
  ${EndIf}

  ; MPI installation is always required, because Khiops is linked with MPI DLL
  ${If} $MPIInstallationNeeded == "1"
      # LogText "=== Microsoft MPI installation ==="
      Call InstallMPI
  ${EndIf}

  # Install files
  # LogText "=== Install Khiops files ==="

  # Activate file overwrite
  SetOverwrite on

  # Files to install in the root directory
  SetOutPath "$INSTDIR"
  File "..\..\LICENCE"

  # Install executables and java libraries
  SetOutPath "$INSTDIR\bin"
  File "${KHIOPS_WINDOWS_BUILD_DIR}\bin\MODL.exe"
  File "${KHIOPS_WINDOWS_BUILD_DIR}\bin\MODL_Coclustering.exe"
  File "${KHIOPS_WINDOWS_BUILD_DIR}\jars\norm.jar"
  File "${KHIOPS_WINDOWS_BUILD_DIR}\jars\khiops.jar"

  # Install icons
  SetOutPath "$INSTDIR\bin\icons"
  File "..\common\images\installer_khiops.ico"
  File "..\common\images\khiops.ico"
  File "..\common\images\khiops_coclustering.ico"

  # Install Khiops Visualization App
  # LogText "=== Install Khiops visualization tools ==="

  # Add the installer file
  SetOutPath $TEMP
  File ${KHIOPS_VISUALIZATION_INSTALLER_PATH}

  # Execute Khiops visualization installer:
  # - It is not executed with silent mode so the user can customize the install
  # - It is executed with "cmd /C" so it opens the installer options window
  # LogText "=== Khiops Visualization installation ==="
  Var /Global KHIOPS_VISUALIZATION_INSTALLER_FILENAME
  ${GetFileName} ${KHIOPS_VISUALIZATION_INSTALLER_PATH} $KHIOPS_VISUALIZATION_INSTALLER_FILENAME
  #nsexec::Exec 'cmd /C "$KHIOPS_VISUALIZATION_INSTALLER_FILENAME"'
  #Pop $0
  #DetailPrint "Installation of Khiops visualization: $0"

  # Delete installer
  Delete "$TEMP\KHIOPS_VISUALIZATION_INSTALLER_FILENAME"


  # Execute Khiops covisualization installer:
  # Same rules as above with the visualization

  # LogText "=== Install Khiops covisualization tools ==="
  # Files to install in installer directory
  File ${KHIOPS_COVISUALIZATION_INSTALLER_PATH}

  # LogText "=== Khiops Covisualization installation ==="
  Var /Global KHIOPS_COVISUALIZATION_INSTALLER_FILENAME
  ${GetFileName} ${KHIOPS_COVISUALIZATION_INSTALLER_PATH} $KHIOPS_COVISUALIZATION_INSTALLER_FILENAME
  #nsexec::Exec 'cmd /C "$TEMP\$KHIOPS_COVISUALIZATION_INSTALLER_FILENAME"'
  #Pop $0
  #DetailPrint "Installation of Khiops covisualization: $0"

  ; Delete installer
  Delete "$TEMP\$KHIOPS_COVISUALIZATION_INSTALLER_FILENAME"


  ;------------------------------------------------------------------
  ; Finalize the installation

  # LogText "=== Install shell files ==="

  ; Creation of Khiops cmd files for Khiops et Khiops Coclustering
  StrCpy $ProcessNumber $PhysicalCoresNumber
  ${If} $PhysicalCoresNumber >= 2
      IntOp $ProcessNumber $PhysicalCoresNumber + 1
  ${EndIf}
  ${CreateKhiopsEnvCmdFile} "$INSTDIR\bin\khiops_env.cmd" "$INSTDIR" $ProcessNumber
  ${CreateKhiopsCmdFile} "$INSTDIR\bin\khiops.cmd" "MODL" "" "$INSTDIR" "scenario._kh" "log.txt" $IsMPIRequired
  ${CreateKhiopsCmdFile} "$INSTDIR\bin\khiops_coclustering.cmd" "MODL_Coclustering" "" "$INSTDIR" "scenario._khc" "logc.txt" "0"

  # Create the Khiops shell
  FileOpen $0 "$INSTDIR\bin\shell_khiops.cmd" w
  FileWrite $0 '@echo off$\r$\n'
  FileWrite $0 'REM Open a shell session with access to Khiops$\r$\n'
  FileWrite $0 `if "%KHIOPS_HOME%".=="". set KHIOPS_HOME=$INSTDIR$\r$\n`
  FileWrite $0 'set path=%KHIOPS_HOME%\bin;%path%$\r$\n'
  FileWrite $0 'title Shell Khiops$\r$\n'
  FileWrite $0 '%comspec% /K "echo Welcome to Khiops scripting mode & echo Type khiops -h or khiops_coclustering -h to get help'
  FileClose $0

  # LogText "=== Create uninstaller ==="

  ; Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall-khiops.exe"



  #####################################
  # Windows environment customization #
  # ###################################

  # LogText "=== Windows environment customization ==="

  # Write registry keys to add Khiops in the Add/Remove Programs pane
  WriteRegStr HKLM "Software\Khiops" "" $INSTDIR
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "UninstallString" '"$INSTDIR\uninstall-khiops.exe"'
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "DisplayName" "Khiops"
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "Publisher" "Orange Labs"
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "DisplayIcon" "$INSTDIR\bin\icons\installer_khiops.ico"
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "DisplayVersion" "${KHIOPS_VERSION}"
  WriteRegStr HKLM "${UninstallerKey}\Khiops" "URLInfoAbout" "http://www.khiops.com"
  WriteRegDWORD HKLM "${UninstallerKey}\Khiops" "NoModify" "1"
  WriteRegDWORD HKLM "${UninstallerKey}\Khiops" "NoRepair" "1"

  # Create application shortcuts in the installation directory
  DetailPrint "Installing Start menu Shortcut..."
  SetOutPath "$INSTDIR"  ; for the start directory
  CreateShortCut "$INSTDIR\Khiops.lnk" "$INSTDIR\bin\khiops.cmd" "" "$INSTDIR\bin\icons\khiops.ico" 0 SW_SHOWMINIMIZED
  CreateShortCut "$INSTDIR\Khiops Coclustering.lnk" "$INSTDIR\bin\khiops_coclustering.cmd" "" "$INSTDIR\bin\icons\khiops_coclustering.ico" 0 SW_SHOWMINIMIZED
  ExpandEnvStrings $R0 "%COMSPEC%"
  CreateShortCut "$INSTDIR\Shell Khiops.lnk" "$INSTDIR\bin\shell_khiops.cmd" "" "$R0"

  ; Create start menu shortcuts for exe
  DetailPrint "Installing Start menu Shortcut..."
  SetOutPath "$INSTDIR"  ; for the start directory
  CreateDirectory "$SMPROGRAMS\Khiops"
  CreateShortCut "$SMPROGRAMS\Khiops\Khiops.lnk" "$INSTDIR\bin\khiops.cmd" "" "$INSTDIR\bin\icons\khiops.ico" 0 SW_SHOWMINIMIZED
  CreateShortCut "$SMPROGRAMS\Khiops\Khiops Coclustering.lnk" "$INSTDIR\bin\khiops_coclustering.cmd" "" "$INSTDIR\bin\icons\khiops_coclustering.ico" 0 SW_SHOWMINIMIZED
  ExpandEnvStrings $R0 "%COMSPEC%"
  CreateShortCut "$SMPROGRAMS\Khiops\Shell Khiops.lnk" "$INSTDIR\bin\shell_khiops.cmd" "" "$R0"
  CreateShortCut "$SMPROGRAMS\Khiops\Uninstall.lnk" "$INSTDIR\uninstall-khiops.exe"

  ; Create start menu shortcuts for doc
  SetOutPath "$INSTDIR"
  CreateDirectory "$SMPROGRAMS\Khiops\doc"
  CreateShortCut "$SMPROGRAMS\Khiops\doc\Tutorial.lnk" "$INSTDIR\doc\KhiopsTutorial.pdf"
  CreateShortCut "$SMPROGRAMS\Khiops\doc\Khiops.lnk" "$INSTDIR\doc\KhiopsGuide.pdf"
  CreateShortCut "$SMPROGRAMS\Khiops\doc\Khiops Coclustering.lnk" "$INSTDIR\doc\KhiopsCoclusteringGuide.pdf"
  CreateShortCut "$SMPROGRAMS\Khiops\doc\Khiops Visualization.lnk" "$INSTDIR\doc\KhiopsVisualizationGuide.pdf"
  CreateShortCut "$SMPROGRAMS\Khiops\doc\Khiops Covisualization.lnk" "$INSTDIR\doc\KhiopsCovisualizationGuide.pdf"


   ##############################################
   # Register environement variable KHIOPS_HOME #
   ##############################################

   # include for some of the windows messages defines
   # HKLM (all users) vs HKCU (current user) defines
   !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
   !define env_hkcu 'HKCU "Environment"'
   # set variable for local machine
   WriteRegExpandStr ${env_hklm} "KHIOPS_HOME" "$INSTDIR"
   # and current user
   WriteRegExpandStr ${env_hkcu} "KHIOPS_HOME" "$INSTDIR"
   # deprecated
   WriteRegExpandStr ${env_hklm} "KhiopsHome" "$INSTDIR"
   WriteRegExpandStr ${env_hkcu} "KhiopsHome" "$INSTDIR"
   # make sure windows knows about the change
   SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ;------------------------------------------------------------------
  ; Register file association for Khiops visualisation tools
  ; Inspired from examples\makensis.nsi

  ; Khiops dictionary file
  ReadRegStr $R0 HKCR ".kdic" ""
  ${if} $R0 == "Khiops.Dictionary.File"
    DeleteRegKey HKCR "Khiops.Dictionary.File"
  ${EndIf}
  WriteRegStr HKCR ".kdic" "" "Khiops.Dictionary.File"
  WriteRegStr HKCR "Khiops.Dictionary.File" "" "Khiops Dictionary File"
  ReadRegStr $R0 HKCR "Khiops.Dictionary.File\shell\open\command" ""
  ${If} $R0 == ""
    WriteRegStr HKCR "Khiops.Dictionary.File\shell" "" "open"
    WriteRegStr HKCR "Khiops.Dictionary.File\shell\open\command" "" 'notepad.exe "%1"'
  ${EndIf}

  ; Khiops file
  ReadRegStr $R0 HKCR "._kh" ""
  ${if} $R0 == "Khiops.File"
    DeleteRegKey HKCR "Khiops.File"
  ${EndIf}
  WriteRegStr HKCR "._kh" "" "Khiops.File"
  WriteRegStr HKCR "Khiops.File" "" "Khiops File"
  WriteRegStr HKCR "Khiops.File\DefaultIcon" "" "$INSTDIR\bin\icons\khiops.ico"
  ReadRegStr $R0 HKCR "Khiops.File\shell\open\command" ""
  ${If} $R0 == ""
    WriteRegStr HKCR "Khiops.File\shell" "" "open"
    WriteRegStr HKCR "Khiops.File\shell\open\command" "" 'notepad.exe "%1"'
  ${EndIf}
  WriteRegStr HKCR "Khiops.File\shell\compile" "" "Execute Khiops Script"
  WriteRegStr HKCR "Khiops.File\shell\compile\command" "" '"$INSTDIR\bin\khiops.cmd" -i "%1"'

  ; Khiops coclustering file
  ReadRegStr $R0 HKCR "._khc" ""
  ${if} $R0 == "Khiops.Coclustering.File"
    DeleteRegKey HKCR "Khiops.Coclustering.File"
  ${EndIf}
  WriteRegStr HKCR "._khc" "" "Khiops.Coclustering.File"
  WriteRegStr HKCR "Khiops.Coclustering.File" "" "Khiops Coclustering File"
  WriteRegStr HKCR "Khiops.Coclustering.File\DefaultIcon" "" "$INSTDIR\bin\icons\khiops_coclustering.ico"
  ReadRegStr $R0 HKCR "Khiops.Coclustering.File\shell\open\command" ""
  ${If} $R0 == ""
    WriteRegStr HKCR "Khiops.Coclustering.File\shell" "" "open"
    WriteRegStr HKCR "Khiops.Coclustering.File\shell\open\command" "" 'notepad.exe "%1"'
  ${EndIf}
  WriteRegStr HKCR "Khiops.Coclustering.File\shell\compile" "" "Execute Khiops Coclustering Script"
  WriteRegStr HKCR "Khiops.Coclustering.File\shell\compile\command" "" '"$INSTDIR\bin\khiops_coclustering.cmd" -i "%1"'

  ; Notify file extension changes
  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, i 0, i 0)'

  # LogText "=== End of installation ==="

SectionEnd





;============================================================================================
;Uninstaller Section

Section "Uninstall"

  # LogText "=== Uninstallation of previous version ==="

  ; In order to have shortcuts and documents for all users
  SetShellVarContext all

  # Unregister file associations
  DetailPrint "Uninstalling Khiops Shell Extensions..."

  # Unregister Khiops dictionary file extension
  ${If} $R0 == "Khiops.Dictionary.File"
    DeleteRegKey HKCR ".kdic"
  ${EndIf}
  DeleteRegKey HKCR "Khiops.Dictionary.File"

  # Unregister Khiops file extension
  ${If} $R0 == "Khiops.File"
    DeleteRegKey HKCR "._kh"
  ${EndIf}
  DeleteRegKey HKCR "Khiops.File"

  # Unregister Khiops coclustering file extension
  ${If} $R0 == "Khiops.Coclustering.File"
    DeleteRegKey HKCR "._khc"
  ${EndIf}
  DeleteRegKey HKCR "Khiops.Coclustering.File"

  # Notify file extension changes
  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, i 0, i 0)'

  # Delete installation folder key
  DeleteRegKey HKLM "${UninstallerKey}\Khiops"
  DeleteRegKey HKLM "Software\Khiops"

  # Delete environement variable KHIOPS_HOME
  DeleteRegValue ${env_hklm} "KHIOPS_HOME"
  DeleteRegValue ${env_hkcu} "KHIOPS_HOME"

  # Delete deprecated environment variable KhiopsHome
  DeleteRegValue ${env_hklm} "KhiopsHome"
  DeleteRegValue ${env_hkcu} "KhiopsHome"

  # Make sure windows knows about the changes in the environment
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ################
  # Delete files #
  ################

  DetailPrint "Deleting Files ..."

  # Files to delete in root directory
  Delete "$INSTDIR\LICENCE"

  # Files to delete in bin directory
  Delete "$INSTDIR\bin\khiops_env.cmd"
  Delete "$INSTDIR\bin\khiops.cmd"
  Delete "$INSTDIR\bin\khiops_coclustering.cmd"
  Delete "$INSTDIR\bin\MODL.exe"
  Delete "$INSTDIR\bin\MODL_Coclustering.exe"
  Delete "$INSTDIR\bin\norm.jar"
  Delete "$INSTDIR\bin\khiops.jar"
  Delete "$INSTDIR\bin\shell_khiops.cmd"

  # Files to delete in bin\icons directory
  Delete "$INSTDIR\bin\icons\installer_khiops.ico"
  Delete "$INSTDIR\bin\icons\khiops.ico"
  Delete "$INSTDIR\bin\icons\khiops_coclustering.ico"

  # Delete short cuts from install dir
  Delete "$INSTDIR\Khiops.lnk"
  Delete "$INSTDIR\Khiops Coclustering.lnk"
  Delete "$INSTDIR\Shell Khiops.lnk"

  # Delete the installer
  Delete "$INSTDIR\uninstall-khiops.exe"

  # Delete the installation directory tree
  # Note: Directories are removed only if they are completely empty
  RMDir "$INSTDIR\bin\icons"
  RMDir "$INSTDIR\bin"
  RMDir "$INSTDIR\key"
  RMDir "$INSTDIR\doc"
  RMDir "$INSTDIR"

  # Delete shortcuts
  Delete "$DESKTOP\Khiops.lnk"
  Delete "$DESKTOP\Khiops Coclustering.lnk"
  Delete "$DESKTOP\Shell Khiops.lnk"
  RMDir /r "$SMPROGRAMS\Khiops"

  # LogText "=== End of uninstallation ==="

SectionEnd


#######################
# Installer Functions #
#######################


# Predefined initialisation install function
Function .onInit
  # Define variables
  Var /GLOBAL PreviousUninstaller
  Var /GLOBAL PreviousVersion

  # Read location of the uninstaller
  ReadRegStr $PreviousUninstaller HKLM "${UninstallerKey}\Khiops" "UninstallString"
  ReadRegStr $PreviousVersion HKLM "${UninstallerKey}\Khiops" "DisplayVersion"

  # Ask the user to proceed if there was already a previous Khiops version installed
  # In silent mode: remove previous version
  ${If} $PreviousUninstaller != ""
    MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
       "Khiops $PreviousVersion is already installed. $\n$\nClick OK to remove the \
       previous version $\n$\nor Cancel to cancel this upgrade." \
       /SD IDOK IDOK uninst
    Abort

    # Run the uninstaller
    uninst:
    ClearErrors
    ExecWait '$PreviousUninstaller /S _?=$INSTDIR'

    # Run again the uninstaller to delete the uninstaller itself and the root dir (without waiting)
    # Must not be used in silent mode (may delete files from silent following installation)
    ${IfNot} ${Silent}
       ExecWait '$PreviousUninstaller /S'
    ${EndIf}
  ${EndIf}

  # Choice of default installation directory, for windows 32 or 64
  ${If} $INSTDIR == ""
    ${If} ${RunningX64}
      StrCpy $INSTDIR "$PROGRAMFILES64\khiops"
      # No 32-bit install
    ${EndIf}
  ${EndIf}
FunctionEnd


# Function to show the page for requirements
Function RequirementsPageShow
  # Detect requirements
  Call RequirementsDetection

  # Creation of page, with title and subtitle
  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "Check requirement softwares" "Check Microsoft MPI and Java Runtime Environment"

  # Message to show for the Microsoft MPI installation
  ${NSD_CreateLabel} 0 20u 100% 10u $MPIInstallationMessage

  # Message to show for the JRE installation
  ${NSD_CreateLabel} 0 50u 100% 10u $JavaInstallationMessage

  # Show page
  nsDialogs::Show
FunctionEnd


# Requirements detection
# - Detects if the system architecture is 64-bit
# - Detects whether Java JRE and MPI are installed and their versions
Function RequirementsDetection
  # Abort installation if the machine does not have 64-bit architecture
  ${IfNot} ${RunningX64}
    Messagebox MB_OK "Khiops works only on Windows 64 bits: installation will be terminated." /SD IDOK
    Quit
  ${EndIf}

  # Decide if MPI is required by detecting the number of cores
  StrCpy $PhysicalCoresNumber "0"
  Call GetProcessorPhysCoreCount
  Pop $0
  StrCpy $PhysicalCoresNumber $0
  ${If} $PhysicalCoresNumber > 1
      StrCpy $IsMPIRequired "1"
  ${Else}
      StrCpy $IsMPIRequired "0"
  ${EndIf}
  ${If} $IsMPIRequired == "1"
      Call DetectAndLoadMPIEnvironment
  ${EndIf}

  # Try to install MPI if it is required
  StrCpy $MPIInstallationNeeded "0"
  StrCpy $MPIInstallationMessage ""
  ${If} $IsMPIRequired == "1"
    # If it is not installed install it
    ${If} $MPIInstalledVersion == "0"
      StrCpy $MPIInstallationMessage "Microsoft MPI (version ${MPIRequiredVersion}) will be installed"
      StrCpy $MPIInstallationNeeded "1"
    # Otherwise install only if the required version is newer than the installed one
    ${Else}
      ${VersionCompare} "${MPIRequiredVersion}" "$MPIInstalledVersion" $0
      ${If} $0 == 1
        StrCpy $MPIInstallationMessage "New Microsoft MPI (version ${MPIRequiredVersion}) will be installed"
        StrCpy $MPIInstallationNeeded "1"
      ${Else}
        StrCpy $MPIInstallationMessage "Microsoft MPI already installed"
          ${EndIf}
      ${EndIf}
  # Otherwise just inform that MPI is not required
  ${Else}
    StrCpy $MPIInstallationMessage "Microsoft MPI installation not required"
  ${EndIf}

  # Show debug information
  !ifdef DEBUG
    Messagebox MB_OK "MS-MPI: needed=$MPIInstallationNeeded required=${MPIRequiredVersion} installed=$MPIInstalledVersion"
  !endif

  # Detect and load Java Environment
  Call DetectAndLoadJavaEnvironment

  # Message to install Java
  StrCpy $JavaInstallationNeeded "0"
  StrCpy $JavaInstallationMessage ""
  ${If} $JavaInstallationPath == ""
    StrCpy $JavaInstallationMessage "Java runtime (version ${JavaRequiredVersion}, update ${JavaInstallerVersionUpdate}) will be installed"
    StrCpy $JavaInstallationNeeded "1"
  # If Java allready installed
  ${Else}
    # Suite a ce qui semble etre bug de l'installeur Java, on se base desormais sur JavaRequiredVersion, et non sur JavaRequiredFullVersion
    ${VersionCompare} "${JavaRequiredVersion}" "$JavaInstalledVersion" $0
    # Required version is newer than installed version
    ${If} $0 == 1
         StrCpy $JavaInstallationMessage "New Java runtime (version ${JavaRequiredVersion}, update ${JavaInstallerVersionUpdate}) will be installed"
         StrCpy $JavaInstallationNeeded "1"
    # Require version is equal or older than installed version
    ${Else}
         StrCpy $JavaInstallationMessage "Java runtime already installed"
    ${EndIf}
  ${EndIf}

  # Debug message
  !ifdef DEBUG
    Messagebox MB_OK "Java runtime: $JavaInstallationNeeded required ${JavaRequiredVersion}, installed $JavaInstalledVersion"
  !endif
FunctionEnd

# No leave page for required softwares
Function RequirementsPageLeave
FunctionEnd
