if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Devi eseguire lo script (e la powershell) come amministratore. Cerca powershell, fai tasto destro, apri come amministratore, premi si e re-incolla il testo."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host "Informazioni di sistema riassuntive`nRevisione Script: 1.4`nOrigine: https://dogetech.it`n------"
Write-Host "Fornisci uno screenshot di tutte le seguenti informazioni. I seguenti dati non sono sensibili e serviranno a diagnosticare eventuali problemi."

Write-Host "`n ----- CPU -----"
$cpu = Get-WmiObject win32_processor
$cpuName = $cpu.Name
$cpuCores = $cpu.NumberOfCores
$cpuThreads = $cpu.NumberOfLogicalProcessors
$cpuSpeed = $cpu.MaxClockSpeed
$cpuMaxClockSpeed = $cpu.MaxClockSpeed
Write-Host "CPU: $cpuName`n$cpuCores Cores $cpuThreads Threads`n$cpuSpeed MHz su $cpuMaxClockSpeed MHz max"

Write-Host "`n ----- RAM -----"
$ram = Get-WmiObject win32_physicalmemory
$ramQuantity = $ram.count
$ramPartName = $ram.partnumber
$ramCapacity = $ram.capacity
$ramSpeed = $ram.speed
$ramConfiguredClockSpeed = $ram.configuredclockspeed
$ramDeviceLocator = $ram.devicelocator
$ramBankLabel = $ram.banklabel
$ConfiguredVoltage = $ram.ConfiguredVoltage
Write-Host "RAM fisiche installate: $ramQuantity`n$ramPartName, capacità in byte: $ramCapacity`n$ramSpeed MHz su $ramConfiguredClockSpeed MHz max`n$ConfiguredVoltage Volts`n$ramDeviceLocator ($ramBankLabel)"

Write-Host "`n ----- MOBO -----"
$mobo = Get-WmiObject win32_baseboard
$moboManufacturer = $mobo.manufacturer
$moboProduct = $mobo.product
$moboVersion = $mobo.version
$bios = Get-WmiObject win32_bios
$biosVersion = $bios.smbiosbiosversion
Write-Host "Scheda Madre: $moboManufacturer`n$moboProduct v$moboVersion, BIOS: $biosVersion"

Write-Host "`n ----- GPU -----"
$gpu = Get-WmiObject win32_VideoController
$gpuName = $gpu.name
$gpuDriverVersion = $gpu.driverversion
$gpuDriverDate = $gpu.driverdate
Write-Host "Scheda Video: $gpuName`nDriver: $gpuDriverVersion, Data Driver: $gpuDriverDate"

Write-Host "`n ----- OS -----"
$os = Get-WmiObject win32_operatingsystem
$osName = $os.caption
$osVersion = $os.version
$osBuild = $os.buildnumber
$osArch = $os.osarchitecture
Write-Host "Sistema Operativo: $osName`nVersione $osVersion, Build $osBuild a $osArch"

Write-Host "`n ----- MONITORS -----"
$monitor = Get-WmiObject win32_VideoController
$CurrentHorizontalResolution = $monitor.CurrentHorizontalResolution
$CurrentVerticalResolution = $monitor.CurrentVerticalResolution
$CurrentRefreshRate = $monitor.CurrentRefreshRate
Write-Host "Monitor(s): H $CurrentHorizontalResolution x V $CurrentVerticalResolution a $CurrentRefreshRate hz"

Write-Host "`n ----- HDD/SSD -----"
$disk = Get-WmiObject win32_logicaldisk
$diskName = $disk.name
$diskSize = $disk.size
$diskFreeSpace = $disk.freespace
$diskModel = Get-WmiObject win32_diskdrive
$diskModelName = $diskModel.model
$diskModelInterfaceType = $diskModel.interfacetype
Write-Host "Modelli dischi: $diskModelName`nUnità dischi: $diskName`nInterfacce: $diskModelInterfaceType`nSpazio totale in bytes: $diskSize`nSpazio libero in bytes: $diskFreeSpace"

Write-Host "`n ----- MISC -----"
$tpm = Get-CimInstance -Namespace "root/cimv2/Security/MicrosoftTPM" -ClassName "Win32_TPM"
$tpmActivated = $tpm.IsActivated_InitialValue
$tpmEnabled = $tpm.IsEnabled_InitialValue
$tpmOwned = $tpm.IsOwned_InitialValue
$tpmSpecVersion = $tpm.SpecVersion
Write-Host "TPM Abilitato? $tpmActivated`nTPM Attivo? $tpmEnabled`nTPM Posseduto? $tpmOwned`nVersione TPM: $tpmSpecVersion"
$secureBoot = Confirm-SecureBootUEFI
Write-Host "Il secure boot è attivo?: $secureBoot"
$defender = Get-MpComputerStatus
$defenderAntispywareSignatureLastUpdated = $defender.AntispywareSignatureLastUpdated
$defenderAntivirusSignatureLastUpdated = $defender.AntivirusSignatureLastUpdated
$defenderEnabled = $defender.AntivirusEnabled
$defenderLatestScan = $defender.QuickScanEndTime
Write-Host "Windows Defender è attivo? $defenderEnabled, ultimo aggiornamento database virus: $defenderAntivirusSignatureLastUpdated e spyware: $defenderAntispywareSignatureLastUpdated, ultima scansione rapida: $defenderLatestScan"

Write-Host "`nModelli di alimentatori, ventole, dissipatori e dispositivi come tastiere e mouse non sono reperibili dai driver di sistema. Elencali manualmente."
Write-Host "--- FINITO ---"