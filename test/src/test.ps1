<#
.SYNOPSIS
    江戸伝統色テーマ - PowerShell構文解析検証スクリプト
.DESCRIPTION
    コマンドレット（動詞-名詞）、パラメータ（-Parameter）、変数（$var）、型キャスト（[string]）、文字列補間、スクリプトブロック、例外処理の確認用
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ThemeName = "edo-nezu-theme",

    [Parameter(Mandatory = $false)]
    [ValidateSet("WhiteBase", "BlueNezu", "BrownTea")]
    [string]$Category = "BlueNezu",

    [switch]$IsProduction
)

# 変数・定数定義
$Script:Version = "1.0.0"
$Global:DebugPreference = "Continue"

# ハッシュテーブルと配列
$ColorMap = @{
    "White" = "#dcdddd" # 白鼠
    "Blue"  = "#567a98" # 舛花色
    "Brown" = "#cd8c5c" # 江戸茶
    "Green" = "#6a8372" # 老竹色
}

function Invoke-ColorValidation {
    [OutputType([PSCustomObject])]
    param (
        [string]$Name,
        [string]$Hex
    )

    try {
        # 文字列補間と条件演算
        Write-Verbose "Validating color: $Name ($Hex)..."

        if ($Hex -match '^#[0-9a-fA-F]{6}$') {
            return [PSCustomObject]@{
                Name      = $Name
                HexCode   = $Hex
                IsValid   = $true
                Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }
        } else {
            Write-Warning "無効なHEXコードです: $Hex"
            return $null
        }
    }
    catch [System.Exception] {
        Write-Error "エラーが発生しました: $_"
    }
    finally {
        # パイプライン処理テスト
        Get-Process -Name "Code" -ErrorAction SilentlyContinue |
            Select-Object -First 1 -Property ProcessName, Id
    }
}

# 実行ブロック
$results = foreach ($entry in $ColorMap.GetEnumerator()) {
    Invoke-ColorValidation -Name $entry.Key -Hex $entry.Value
}

Write-Output "処理完了件数: $($results.Count)"
