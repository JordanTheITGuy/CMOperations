<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.144
	 Created on:   	2/23/2018 11:13 AM
	 Created by:   	Jordan Benzing
	 Organization: 	
	 Filename:     	CMOperations.psm1
	-------------------------------------------------------------------------
	 Module Name: CMOperations
	===========================================================================
#>



function Start-SoftwareUpdateScan
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$ComputerName,
		[Parameter(Mandatory = $False)]
		[switch]$ConnectionTest
	)
	if ($ConnectionTest -eq $true)
	{
		if (Test-Connectivity -ComputerName $ComputerName)
		{
			try
			{
				Write-Verbose -message "Attempting to start a Software Update Scan Cycle"
				Invoke-WmiMethod -ComputerName $ComputerName -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000113}" | Out-Null
				Write-Verbose -Message "The computer has started a software update scan cycle."
			}
			Catch
			{
				throw "$ComputerName failed to start software update Scan"
			}
		}
	}
	else
	{
		try
		{
			Write-Verbose -message "Attempting to start a Software Update Scan Cycle"
			Invoke-WmiMethod -ComputerName $ComputerName -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000113}" | Out-Null
			Write-Verbose -Message "The computer has started a software update scan cycle."
		}
		Catch
		{
			throw "$ComputerName failed to start software update Scan"
		}
	}
}

function Start-HardwareInventoryScan
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$ComputerName,
		[Parameter(Mandatory = $False)]
		[switch]$ConnectionTest
	)
	if ($ConnectionTest -eq $true)
	{
		if (Test-Connectivity -ComputerName $ComputerName)
		{
			try
			{
				Write-Verbose -Message "Attempting to invoke a hardware inventory cycle"
				Invoke-WMIMethod -ComputerName $Server -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}" | Out-Null
				Write-Verbose -Message "The computer has started a hardware inventory cycle."
			}
			Catch
			{
				throw "$ComputerName failed to start hardware inventory cycle"
			}
		}
	}
	else
	{
		try
		{
			Write-Verbose -Message "Attempting to invoke a hardware inventory cycle."
			Invoke-WMIMethod -ComputerName $Server -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}" | Out-Null
			Write-Verbose -Message "The computer has started a hardware inventory cycle."
		}
		Catch
		{
			throw "$ComputerName failed to start a hardware inventory cycle"
		}
	}
}

function Get-LastHardwareScan
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$ComputerName,
		[Parameter(Mandatory = $False)]
		[switch]$ConnectionTest
	)
	if ($ConnectionTest -eq $true)
	{
		if (Test-Connectivity -ComputerName $ComputerName)
		{
			try
			{
				Write-Verbose -Message "Attempting to connect and retrieve the instance for Hardware Inventory Information"
				$obj = Get-WmiObject -Namespace "root\ccm\invagt" -Class InventoryActionStatus -ErrorAction Stop | Where-Object { $_.InventoryActionID -eq "{00000000-0000-0000-0000-000000000001}" } | select PsComputerName, LastCycleStartedDate, LastReportDate
				Write-Verbose -Message "Retrieved WMI Instance for Hardware Scan Information"
				$LastHWRun = $ComputerName + " last attempted Hardware inventory on " + [Management.ManagementDateTimeConverter]::ToDateTime($obj.LastCycleStartedDate)
				Write-Host $LastHWRun
			}
			Catch
			{
				throw "Unable to get last hardware scan run time"	
			}
		}
		else
		{
			throw "Failed collection test to remote machine"
		}
	}
	else
	{
		try
		{
			Write-Verbose -Message "Attempting to connect and retrieve the instance for Hardware Inventory Information"
			$obj = Get-WmiObject -Namespace "root\ccm\invagt" -Class InventoryActionStatus -ErrorAction Stop | Where-Object { $_.InventoryActionID -eq "{00000000-0000-0000-0000-000000000001}" } | select PsComputerName, LastCycleStartedDate, LastReportDate
			Write-Verbose -Message "Retrieved WMI Instance for Hardware Scan Information"
			$LastHWRun = $ComputerName + " last attempted Hardware inventory on " + [Management.ManagementDateTimeConverter]::ToDateTime($obj.LastCycleStartedDate)
			Write-Host $LastHWRun
		}
		Catch
		{
			throw "Unable to get last hardware scan run time"
		}
	}
}
############################################
function Test-Connectivity
#Test Connection function. All network tests should be added to this for a full connection test. Returns true or false.
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[string]$ComputerName
	)
	Try
	{
		Test-Ping -ComputerName $ComputerName -ErrorAction Stop
		Test-AdminShare -ComputerName $ComputerName -ErrorAction Stop
		Test-WinRM -ComputerName $ComputerName -ErrorAction Stop
		return $true
	}
	CATCH
	{
		$ConnectionStatus = $false
		Write-Verbose "$ComputerName failed a connection test."
		return $false
	}
}

function Test-Ping
#Test ping for computer.
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[string]$ComputerName
	)
	$PingTest = Test-Connection -ComputerName $ComputerName -BufferSize 8 -Count 1 -Quiet
	If ($PingTest)
	{
		Write-Verbose "The Ping test for $ComputerName has PASSED"
	}
	Else
	{
		Write-Verbose "$ComputerName failed ping test"
		throw [System.Net.NetworkInformation.PingException] "$ComputerName failed ping test."
	}
}

function Test-AdminShare
#Test Conection to admin C$ share.
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[string]$ComputerName
	)
	$AdminShare = "\\" + $ComputerName + "\C$"
	$AdminAccess = Test-Path -Path $AdminShare -ErrorAction Stop
	if ($AdminAccess)
	{
		Write-Verbose "The admin share connection test $ComputerName has PASSED"
		$ConnectionStatus = $true
	}
	Else
	{
		Write-Verbose "$ComputerName admin share not found"
		throw [System.IO.FileNotFoundException] "$ComputerName admin share not found"
		
	}
}

function Test-WinRM
#Test WinRM.
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[string]$ComputerName
	)
	Try
	{
		Test-WSMan -computername $ComputerName -ErrorAction Stop
		Write-Verbose "The WINRM check for $ComputerName has PASSED"
	}
	Catch
	{
		throw [System.IO.DriveNotFoundException] "$ComputerName cannot be connected to via WINRM"
	}
}
##############################################


