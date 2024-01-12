<#
.SYNOPSIS
   Creation of a local administrator in Intune
 
.DESCRIPTION
   This script creates a local LAPS Administrator.
   The script is intended for distribution via Intune, so that a
   local administrator for the configuration of Windows LAPS is located.
   The initial password is randomly generated when the script is executed.

.NOTES
  Version:        1.0
  Author:         Andreas Breitenlohner
  Creation Date:  2024-01-12
  Purpose/Change: initial creation of a LAPS LocalAdmin Account in Intune
#>

#Name of the account
$LocalAdminUsername = "LocalAdmin"

#Generate random password
$Password = ConvertTo-SecureString -String (-join ((33..126) | Get-Random -Count 32 | % {[char]$_})) -AsPlainText -Force

#Create user
New-LocalUser -Name $LocalAdminUsername -Password $Password -Description "Intune Windows LAPS Admin Account"

# Add users to local admins
Add-LocalGroupMember -SID S-1-5-32-544 -Member $LocalAdminUsername
