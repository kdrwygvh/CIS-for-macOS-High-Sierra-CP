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
# Writes to /Library/Application Support/SecurityScoring/org_security_score.plist by default.
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

# Configuration Profile - Custom payload > com.apple.SoftwareUpdate.plist > AutomaticCheckEnabled=true, AutomaticDownload=true

# Does not work as a Configuration Profile - Custom payload > com.apple.commerce


# Does not work as a Configuration Profile - Custom payload > com.apple.commerce

# 2.9 Pair the remote control infrared receiver if enabled
# Since 2013 only the Mac Mini has an infrared receiver

# Configuration Profile - Custom payload > com.apple.Terminal > SecureKeyboardEntry=true


## 2.12 Securely delete files as needed (Not Scored)
## With the wider use of FileVault and other encryption methods and the growing use of Solid State Drives
## the requirements have changed and the "Secure Empty Trash" capability has been removed from the GUI.


















# 5.3 Reduce the sudo timeout period



# 5.8 Ensure login keychain is locked when the computer sleeps

# 5.9 Enable OCSP and CRL certificate checking
# Does not work as a Configuration Profile - Custom payload > com.apple.security.revocation

# 5.11 Do not enable the "root" account

# Configuration Profile - LoginWindow payload > Options > Disable automatic login (checked)

# 5.13 Require a password to wake the computer from sleep or screen saver
# Configuration Profile - Security and Privacy payload > General > Require password * after sleep or screen saver begins (checked)


# 5.15 Require an administrator password to access system-wide preferences

# 5.16 Disable ability to login to another user's active and locked session

# 5.17 Create a custom message for the Login Screen
# Configuration Profile - LoginWindow payload > Window > Banner (message)

# 5.18 Create a Login window banner

## 5.19 Do not enter a password-related hint (Not Scored)

# 5.20 Disable Fast User Switching (Not Scored)
# Configuration Profile - LoginWindow payload > Options > Enable Fast User Switching (unchecked)

## 5.21 Secure individual keychains and items (Not Scored)

## 5.22 Create specialized keychains for different purposes (Not Scored)

# 5.23 System Integrity Protection status






# 6.2 Turn on filename extensions

# 6.3 Disable the automatic run of safe files in Safari
# Configuration Profile - Custom payload > com.apple.Safari > AutoOpenSafeDownloads=false

## 6.4 Safari disable Internet Plugins for global use (Not Scored)

## 6.5 Use parental controls for systems that are not centrally managed (Not Scored)
