# 獲取當前腳本的目錄路徑
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 組合路徑
$loaderPath = Join-Path $scriptDir "3DMigoto Loader.exe"

# 啟動 3DMigoto Loader.exe 並要求管理員權限
Start-Process -FilePath $loaderPath -Verb RunAs

# 等待 3 秒
Start-Sleep -Seconds 3

# 啟動 GenshinImpact.exe 並要求管理員權限
Start-Process -FilePath "C:\Program Files\Genshin Impact\Genshin Impact Game\GenshinImpact.exe" -Verb RunAs

# 持續監視 GenshinImpact.exe 是否已經啟動，並在啟動後自動切換視窗
$giWindow = $null
while ($giWindow -eq $null)
{
    Start-Sleep -Milliseconds 100
    $giWindow = Get-Process | Where-Object { $_.ProcessName -eq "GenshinImpact" } | Select-Object -First 1 | Select-Object -ExpandProperty MainWindowHandle
}
$null = (New-Object -ComObject Shell.Application).ToggleDesktop()  # 切換到桌面
$null = (New-Object -ComObject WScript.Shell).AppActivate($giWindow)  # 切換到 GenshinImpact.exe 視窗
