<#	
.SYNOPSIS
	Configuration Manager Module file for basic configuration manager operations and commands. This includes commands that interact both with the SCCM client
	and commands that interact directly with the SMS Provider on the configuration Manager server.

.DESCRIPTION
	This module has been written over a year and a half and will continue to grow and expand as new pieces are added to it. 


.EXAMPLE
	import-module CMOperations

.NOTES
    FileName:    CMOperations.psd1
    Author:      Jordan Benzing
    Contact:     @JordanTheItGuy
    Created:     2/23/2018
    Updated:     8/22/2018

    Version history:
    1.0.0.6 - Updated to use new coding standard for myself

#>

@{
	
	# Script module or binary module file associated with this manifest
	ModuleToProcess = 'CMOperations.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.0.0.4'
	
	# ID used to uniquely identify this module
	GUID = '8911e550-c0cb-4542-a5c9-07915bdfa47a'
	
	# Author of this module
	Author = 'Jordan Benzing'
	
	# Copyright statement for this module
	Copyright = '(c) 2018. All rights reserved.'
	
	# Description of the functionality provided by this module
	Description = 'Powershell Module for Configuration Manager Operations tasks.'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '4.0'
	
	# Name of the Windows PowerShell host required by this module
	PowerShellHostName = ''
	
	# Minimum version of the Windows PowerShell host required by this module
	PowerShellHostVersion = ''
	
	# Minimum version of the .NET Framework required by this module
	DotNetFrameworkVersion = '2.0'
	
	# Minimum version of the common language runtime (CLR) required by this module
	CLRVersion = '2.0.50727'
	
	# Processor architecture (None, X86, Amd64, IA64) required by this module
	ProcessorArchitecture = 'None'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @()
	
	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies = @()
	
	# Script files (.ps1) that are run in the caller's environment prior to
	# importing this module
	ScriptsToProcess = @()
	
	# Type files (.ps1xml) to be loaded when importing this module
	TypesToProcess = @()
	
	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess = @()
	
	# Modules to import as nested modules of the module specified in
	# ModuleToProcess
	NestedModules = @()
	
	# Functions to export from this module
	FunctionsToExport = "Start-SoftwareUpdateScan","Start-HardwareInventoryScan","Get-LastHardwareScan","Get-UpdatesInSoftwareCenter","Install-UpdatesInSoftwareCenter","Get-NextAvailableMW","Get-LastSoftwareUpdateScan" #For performanace, list functions explicity
	
	# Cmdlets to export from this module
	CmdletsToExport = ''
	
	# Variables to export from this module
	VariablesToExport = '*'
	
	# Aliases to export from this module
	AliasesToExport = '*' #For performanace, list alias explicity
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			# Tags = @()
			
			# A URL to the license for this module.
			# LicenseUri = ''
			
			# A URL to the main website for this project.
			# ProjectUri = ''
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}







