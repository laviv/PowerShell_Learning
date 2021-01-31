# Check if the client is runninw with administrative privilages.
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”))
        {
            Write-Warning "You do not have Administrator rights to run this script! 'Opening PowerShell with administrator privilages.`nIt is safe to close this window."
           start-process powershell -Verb RunAs
break;
            }
Else 
	{
		Write-Warning "You are an Administrator"
	}

#To avoid disables service, we set Windows Erroe Reporting Service startup to Manual.
set-service wersvc -startuptype manual

#Var to save user's choice, preset to enable the following loop.
$UserChoice = 0

#Looped the Switch statment until the user wants to stop the script.
while ($UserChoice -ne 5) {	

#Menu that saves user's choice. Rolles to the Switch statment.
	$UserChoice = Read-Host ("To Start Windows Erroe Reporting Service, Press 1`nTo Stop Windows Erroe Reporting Service, Press 2`nTo Restart Windows Erroe Reporting Service, Press 3`nFor Service Status, Press 4`nTo Quit, Press 5")
	Switch ($UserChoice)
	{
		1 {if( (get-service wersvc).status -eq 'Running') {
			Write-Host ("Service is already Running. Cannot Start an Already Started Service!`nPlease Choose another Option."); break} 
		  else {'Start Service';start-service wersvc;(get-service wersvc).status; break}
		  }
		2 {if( (get-service wersvc).status -eq 'Stopped') {
			Write-Host ("Service is already Stopped. Cannot Stop an Already Stopped Service!`nPlease Choose another Option.");break}
		  else {'Stop Service';stop-service wersvc;(get-service wersvc).status; break}
		  }
		3 {if( (get-service wersvc).status -eq 'Running') {
			Write-Host ("Service is already Running. Cannot Restart an Already Started Service!`nPlease Choose another Option."); break} 
		  else {'Restart Service';start-service wersvc;(get-service wersvc).status; break}}
		4 {'Sercive Status';(get-service wersvc).status; break}
		5 {'Quit Script'; $UserChoice = 5}
		default {'Please choose from the following options'}
	}
}
Write-Host ("Goodby Grandpa :)")





