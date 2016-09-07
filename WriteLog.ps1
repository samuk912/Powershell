<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.127
	 Created on:   	06/09/2016 15:36
	 Created by:   	 Sam Wrighton
	 Organization: 	
	 Filename: WriteLog.ps1    	
	===========================================================================
	.SYNOPSIS
		Writes to a log file

	.DESCRIPTION
		This Writes data to a txt file in the location where the script is ran from

	.PARAMETER MessageBody
		Message content you want in the log needs to be a string

	.PARAMETER MessageType
		This is the type of Message you want logging "Status" , "Warnining" , "Error" or "Debug"

	.EXAMPLE
		Write-log -MessageBody "$ExecutionMessage" -MessageType "ERROR"

#>
param
(
	[Parameter(Mandatory = $True,
			   ValueFromPipelineByPropertyName = $True)]
	[string]$MessageBody,
	[Parameter(Mandatory = $true,
			   ValueFromPipelineByPropertyName = $true)]
	[string]$MessageType
)

function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($hostinvocation -ne $null)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

[string]$ScriptDirectory = Get-ScriptDirectory
[string]$RunID = [guid]::NewGuid()
[string]$Date = Get-Date -f dd-MM-yyyy
[string]$DateID = $RunID + " " + $Date
[string]$LogPath = "$ScriptDirectory\$DateID Log.txt"
$DateTime = Get-Date

"$DateTime $MessageType" + ":" + " $MessageBody" | Out-File $LogPath -Append;
	