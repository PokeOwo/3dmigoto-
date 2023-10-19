# 獲取當前腳本的目錄路徑
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 組合路徑
$loaderPath = Join-Path $scriptDir "3DMigoto Loader.exe"

# 啟動 3DMigoto Loader.exe 並要求管理員權限
Start-Process -FilePath $loaderPath -Verb RunAs

# 等待 3DMigoto Loader.exe 輸出指定的文字
$foundText = $false
while (-not $foundText)
{
    $loaderOutput = Get-Content $loaderPath
    if ($loaderOutput -match "3DMigoto ready - Now run the game.")
    {
        $foundText = $true
    }
    Start-Sleep -Milliseconds 100
}

# 啟動 GenshinImpact.exe 並要求管理員權限
Start-Process -FilePath "C:\Program Files\Genshin Impact\Genshin Impact Game\GenshinImpact.exe" -Verb RunAs

# 等待 3DMigoto Loader.exe 輸出指定的文字，以確保 GenshinImpact.exe 已經啟動
$foundText = $false
while (-not $foundText)
{
    $loaderOutput = Get-Content $loaderPath
    if ($loaderOutput -match "GenshinImpact.exe")
    {
        $foundText = $true
    }
    Start-Sleep -Milliseconds 100
}

# 切換到 GenshinImpact.exe 視窗
$giWindow = Get-Process | Where-Object { $_.ProcessName -eq "GenshinImpact" } | Select-Object -First 1 | Select-Object -ExpandProperty MainWindowHandle
$null = (New-Object -ComObject WScript.Shell).AppActivate($giWindow)
