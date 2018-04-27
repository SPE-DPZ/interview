$service_list = @(
    "Dead Letter Handler"
    "Inbound Proxy"
    "Menu Bridge"
    "Outbound Proxy"
)
$service_list | ForEach-Object { Stop-Service -Name $_ -Force }
Start-Sleep -Seconds 5


$service_states = $service_list | ForEach-Object { (Get-Service -Name $_).Status }
if ( $service_states -contains 'Running' )
{
    $services_stopped = $False
}
else
{
    $services_stopped = $True
}


$process_list = @(
    'DeadLetterHandler',
    'InboundFederationProxy',
    'MenuBridge',
    'OutboundFederationProxy'
)
$process_list | ForEach-Object { Get-Process -Name $_ } | Stop-Process -Force
Start-Sleep -Seconds 5


$process_exists = $process_list | ForEach-Object { [bool](Get-Process -Name $_) }
if ( $process_exists -contains $true )
{
    $processes_stopped = $False
}
else
{
    $processes_stopped = $true
}
