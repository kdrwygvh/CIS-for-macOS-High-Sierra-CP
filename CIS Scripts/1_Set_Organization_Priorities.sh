#!/usr/bin/env bash

####################################################################################################
#
# Copyright (c) 2017, Jamf, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################

# written by Katie English, Jamf October 2016
# updated for 10.12 CIS benchmarks by Katie English, Jamf May 2017
# updated to use configuration profiles by Apple Professional Services, January 2018
# github.com/jamfprofessionalservices
# Updated for 10.13 CIS benchmarks by Erin McDonald, Jamf Jan 2019

# USAGE
# Admins set organizational compliance for each listed item, which gets written to plist.
# Values default to "true," and must be commented to "false" to disregard as an organizational priority.
# Writes to /Library/Preferences/com.organization.cisPriorities.plist where com.organization is defined
# below or as Jamf parameter 4 to match the organization's preference domain

organizationDomain=$4

if [[ "$4" = "" ]] && [[ "$organizationDomain" = "" ]]; then
    echo "Must set organization domain before running, bailing"
    exit 1
fi
##################################################################
############### ADMINS DESIGNATE ORG VALUES BELOW ################
##################################################################

# 1.1 Verify all Apple provided software is current
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score1.1 -bool false

# 1.2 Enable Auto Update
# Configuration Profile - Custom payload > com.apple.SoftwareUpdate.plist > AutomaticCheckEnabled=true, AutomaticDownload=true
# or setting via defaults
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score1.2 -bool false

# 1.3 Enable app update installs
# Does not work as a Configuration Profile - Custom payload > com.apple.commerce
# or setting via defaults
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score1.3 -bool false

# 1.4 Enable system data files and security update installs
# Configuration Profile - Custom payload com.apple.SoftwareUpdate.plist > ConfigDataInstall=true, CriticalUpdateInstall=true
# or setting via defaults
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score1.4 -bool false

# 1.5 Enable macOS update installs
# Does not work as a Configuration Profile - Custom payload > com.apple.commerce
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score1.5 -bool false

# 2.1 Bluetooth

    # 2.1.1 Turn off Bluetooth, if no paired devices exist
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.1.1 -bool false

    ## 2.1.2 Turn off Bluetooth "Discoverable" mode when not pairing devices - not applicable to 10.9 and higher.
    ## Starting with OS X (10.9) Bluetooth is only set to Discoverable when the Bluetooth System Preference is selected.
    ## To ensure that the computer is not Discoverable do not leave that preference open.

    # 2.1.3 Show Bluetooth status in menu bar
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.1.3 -bool true

# 2.2 Date & TIme

    # 2.2.1 Enable "Set time and date automatically" (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.2.1 -bool false

    # 2.2.2 Ensure time set is within appropriate limits
    # Not audited - only enforced if identified as priority
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.2.2 -bool false

    # 2.2.3 Restrict NTP server to loopback interface
    # OrgScore2_2_3="true"
    # OrgScore2_2_3="false"

# 2.3 Desktop & Screen Saver

    # 2.3.1 Set an inactivity interval of 20 minutes or less for the screen saver
    # Configuration Profile - LoginWindow payload > Options > Start screen saver after: 20 Minutes of Inactivity
    # or done via defaults. Using defaults would allow the user to make in session changes
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.3.1 -bool false

    # 2.3.2 Secure screen saver corners
    # Configuration Profile - Custom payload > com.apple.dock > wvous-tl-corner=0, wvous-br-corner=5, wvous-bl-corner=0, wvous-tr-corner=0
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.3.2 -bool false

    ## 2.3.3 Verify Display Sleep is set to a value larger than the Screen Saver (Not Scored)
    ## The rationale in the CIS Benchmark for this is incorrect. The computer will lock if the
    ## display sleeps before the Screen Saver activates

    # 2.3.4 Set a screen corner to Start Screen Saver
    # Configuration Profile - Custom payload > com.apple.dock > wvous-tl-corner=0, wvous-br-corner=5, wvous-bl-corner=0, wvous-tr-corner=0
    # OrgScore2_3_4="true"
    # OrgScore2_3_4="false"

# 2.4 Sharing

    # 2.4.1 Disable Remote Apple Events
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.1 -bool false

    # 2.4.2 Disable Internet Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.2 -bool false

    # 2.4.3 Disable Screen Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.3 -bool false

    # 2.4.4 Disable Printer Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.4 -bool false

    # 2.4.5 Disable Remote Login
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.5 -bool false

    # 2.4.6 Disable DVD or CD Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.6 -bool false

    # 2.4.7 Disable Bluetooth Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.7 -bool false

    # 2.4.8 Disable File Sharing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.8 -bool false

    # 2.4.9 Disable Remote Management
    # Screen Sharing and Apple Remote Desktop
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.4.9 -bool false

# 2.5 Energy Saver

    # 2.5.1 Disable "Wake for network access"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.5.1 -bool false

    # 2.5.2 Disable sleeping the computer when connected to power
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.5.2 -bool false

# 2.6 Security & Privacy

    # 2.6.1 Encryption

        # 2.6.1.1 Enable FileVault
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.1.1 -bool false

        # 2.6.1.2 Ensure all user storage APFS volumes are encrypted (Not Scored)
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.1.2 -bool false

         # 2.6.1.3 Ensure all user storage APFS volumes are encrypted (Not Scored)
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.1.3 -bool false

    # 2.6.2 Enable Gatekeeper
    # Configuration Profile - Security and Privacy payload > General > Gatekeeper > Mac App Store and identified developers (selected)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.2 -bool false

    # 2.6.3 Enable Firewall
    # Configuration Profile - Security and Privacy payload > Firewall > Enable Firewall (checked)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.3 -bool false

    # 2.6.4 Enable Firewall Stealth Mode
    # Configuration Profile - Security and Privacy payload > Firewall > Enable stealth mode (checked)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.4 -bool false

    # 2.6.5 Review Application Firewall Rules
    # Configuration Profile - Security and Privacy payload > Firewall > Control incoming connections for specific apps (selected)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.5 -bool false

    # 2.6.6 Enable Location Services (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.6 -bool false

    # 2.6.7 Monitor Location Services Access (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.7 -bool false

    # 2.6.8 Disable sending diagnostic and usage data to Apple (Scored)
    # Configuration Profile - Security and Privacy payload > Privacy (selected)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.6.8 -bool false

# 2.7 iCloud

    # 2.7.1 iCloud configuration (Check for iCloud accounts) (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1 -bool false

    # 2.7.1.01 Disable Apple ID setup during login (Not Scored)
    # Configuration Profile - LoginWindow payload > Options >  Disable Apple ID setup during login (checked)
    # OrgScore2_7_1_01="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.01 -bool false

    # 2.7.1.02 Disable the iCloud system preference pane (Not Scored)
    # Configuration Profile - Restrictions payload > Preferences > disable selected items > iCloud
    # OrgScore2_7_1_02="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.02 -bool false

    # 2.7.1.03 Disable the use of iCloud password for local accounts (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow use of iCloud password for local accounts (unchecked)
    # OrgScore2_7_1_03="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.03 -bool false

    # 2.7.1.04 Disable iCloud Back to My Mac (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Back to My Mac (unchecked)
    # OrgScore2_7_1_04="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.04 -bool false

    # 2.7.1.05 Disable iCloud Find My Mac (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Find My Mac (unchecked)
    # OrgScore2_7_1_05="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.05 -bool false

    # 2.7.1.06 Disable iCloud Bookmarks (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Bookmarks (unchecked)
    # OrgScore2_7_1_06="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.06 -bool false

    # 2.7.1.07 Disable iCloud Mail (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Mail (unchecked)
    # OrgScore2_7_1_07="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.07 -bool false

    # 2.7.1.08 Disable iCloud Calendar (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Calendar (unchecked)
    # OrgScore2_7_1_08="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.08 -bool false

    # 2.7.1.09 Disable iCloud Reminders (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Reminders (unchecked)
    # OrgScore2_7_1_09="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.09 -bool false

    # 2.7.1.10 Disable iCloud Contacts (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Contacts (unchecked)
    # OrgScore2_7_1_10="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.10 -bool false

    # 2.7.1.11 Disable iCloud Notes (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Notes (unchecked)
    # OrgScore2_7_1_11="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.11 -bool false

    # 2.7.1.12 Disable Content Caching (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow Content Caching (unchecked)
    # OrgScore2_7_1_12="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.1.12 -bool false

    # 2.7.2 iCloud keychain (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Keychain (unchecked)
    # OrgScore2_7_2="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.2 -bool false

    # 2.7.3 iCloud Drive (Not Scored)
    # Configuration Profile - Restrictions payload > Functionality > Allow iCloud Drive (unchecked)
    # OrgScore2_7_3="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.3 -bool false

    # 2.7.4 iCloud Drive Document sync
    # Configuration Profile - Restrictions payload - > Functionality > Allow iCloud Desktop & Documents (unchecked)
    # OrgScore2_7_4="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.4 -bool false

    # 2.7.5 iCloud Drive Desktop sync
    # Configuration Profile - Restrictions payload - > Functionality > Allow iCloud Desktop & Documents (unchecked)
    #OrgScore2_7_5="true"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.7.5 -bool false

# 2.8 Time Machine

    # 2.8.1 Time Machine Auto-Backup
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.8.1 -bool false

    # 2.8.2 Time Machine Volumes Are Encrypted (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.8.2 -bool false


# 2.9 Pair the remote control infrared receiver if enabled
# Since 2013 only the Mac Mini has an infrared receiver
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.9 -bool false

# 2.10 Enable Secure Keyboard Entry in terminal.app
# Configuration Profile - Custom payload > com.apple.Terminal > SecureKeyboardEntry=true
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.10 -bool false

# 2.11 Java 6 is not the default Java runtime
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.11 -bool false

## 2.12 Securely delete files as needed (Not Scored)
## With the wider use of FileVault and other encryption methods and the growing use of Solid State Drives
## the requirements have changed and the "Secure Empty Trash" capability has been removed from the GUI.

# 2.13 Ensure EFI version is valid and being regularly checked (Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score2.13 -bool false

# 3 Logging & Auditing

    # 3.1 Enable security auditing
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.1 -bool false

    # 3.2 Configure Security Auditing Flags (Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.2 -bool false

    # 3.3 Ensure security auditing retention (Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.3 -bool false

    # 3.4 Control access to audit records (Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.4 -bool false

    # 3.5 Retain install.log for 365 or more days (Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.5 -bool false

    # 3.6 Ensure Firewall is configured to log (Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score3.6 -bool false

# Network Configurations

    # 4.1 Disable Bonjour advertising service
    # Configuration Profile - Custom payload > com.apple.mDNSResponder > NoMulticastAdvertisements=true
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score4.1 -bool false

    # 4.2 Enable "Show Wi-Fi status in menu bar"
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score4.2 -bool false

    ## 4.3 Create network specific locations (Not Scored)
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score4.3 -bool false

    # 4.4 Ensure http server is not running
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score4.4 -bool false

    # 4.5 Ensure nfs server is not running
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score4.6 -bool false

# 5 System Access, Authentication and Authorization
    # 5.1 File System Permissions and Access Controls
        # 5.1.1 Secure Home Folders
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.1.1 -bool false

        # 5.1.2 Check System Wide Applications for appropriate permissions
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.1.2 -bool false

        # 5.1.3 Check System folder for world writable files
        # Not needed for any macOS which contains System Integrity Protection
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.1.3 -bool false

        # 5.1.4 Check Library folder for world writable files
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.1.4 -bool false

# 5.2 Password Management
    # 5.2.1 Configure account lockout threshold
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.1 -bool false

    # 5.2.2 Set a minimum password length
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.2 -bool false

    # 5.2.3 Complex passwords must contain an Alphabetic Character
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.3 -bool false

    # 5.2.4 Complex passwords must contain a Numeric Character
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.4 -bool false

    # 5.2.5 Complex passwords must contain a Special Character
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.5 -bool false

    # 5.2.6 Complex passwords must uppercase and lowercase letters
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.6 -bool false

    # 5.2.7 Password Age
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.7 -bool false

    # 5.2.8 Password History
    defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.2.8 -bool false

# 5.3 Reduce the sudo timeout period
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.3 -bool false

# 5.4 Use a separate timestamp for each user/tty combo (Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.4 -bool false

# 5.7 Automatically lock the login keychain for inactivity (Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.7 -bool false

# 5.8 Ensure login keychain is locked when the computer sleeps
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.8 -bool false

# 5.9 Enable OCSP and CRL certificate checking
# Does not work as a Configuration Profile - Custom payload > com.apple.security.revocation
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.9 -bool false

# 5.11 Do not enable the "root" account
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.11 -bool false

# 5.12 Disable automatic login
# Configuration Profile - LoginWindow payload > Options > Disable automatic login (checked)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.12 -bool false

# 5.13 Require a password to wake the computer from sleep or screen saver
# Configuration Profile - Security and Privacy payload > General > Require password * after sleep or screen saver begins (checked)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.13 -bool false

# 5.14 Ensure system is set to hibernate (Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.14 -bool false

# 5.15 Require an administrator password to access system-wide preferences
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.15 -bool false

# 5.16 Disable ability to login to another user's active and locked session
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.16 -bool false

# 5.17 Create a custom message for the Login Screen
# Configuration Profile - LoginWindow payload > Window > Banner (message)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.17 -bool false

# 5.18 Create a Login window banner
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.18 -bool false

## 5.19 Do not enter a password-related hint (Not Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.19 -bool false

# 5.20 Disable Fast User Switching (Not Scored)
# Configuration Profile - LoginWindow payload > Options > Enable Fast User Switching (unchecked)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.20 -bool false

## 5.21 Secure individual keychains and items (Not Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.21 -bool false

## 5.22 Create specialized keychains for different purposes (Not Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.22 -bool false

# 5.23 System Integrity Protection status
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score5.23 -bool false

# 6 User Accounts and Environment
    # 6.1 Accounts Preferences Action Items
        # 6.1.1 Display login window as name and password
        # Configuration Profile - LoginWindow payload > Window > LOGIN PROMPT > Name and password text fields (selected)
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.1.1 -bool false

        # 6.1.2 Disable "Show password hints"
        # Configuration Profile - LoginWindow payload > Options > Show password hint when needed and available (unchecked - Yes this is backwards)
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.1.2 -bool false

        # 6.1.3 Disable guest account
        # Configuration Profile - LoginWindow payload > Options > Allow Guest User (unchecked)
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.1.3 -bool false

        # 6.1.4 Disable "Allow guests to connect to shared folders"
        # Configuration Profile - 6.1.4 Disable Allow guests to connect to shared folders - Custom payload > com.apple.AppleFileServer guestAccess=false, com.apple.smb.server AllowGuestAccess=false
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.1.4 -bool false

        # 6.1.5 Remove Guest home folder
        defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.1.5 -bool false

# 6.2 Turn on filename extensions
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.2 -bool false

# 6.3 Disable the automatic run of safe files in Safari
# Configuration Profile - Custom payload > com.apple.Safari > AutoOpenSafeDownloads=false
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.3 -bool false

## 6.4 Safari disable Internet Plugins for global use (Not Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.4 -bool false

## 6.5 Use parental controls for systems that are not centrally managed (Not Scored)
defaults write /Library/Preferences/"$organizationDomain".cisPriorities.plist Score6.5 -bool false
