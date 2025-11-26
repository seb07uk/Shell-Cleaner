# Requires: Windows PowerShell 5+ or PowerShell 7+, Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Config ---
$Title          = "Shell Cleaner v1.0"
$BatchDirectory = Split-Path -Parent $PSCommandPath
$Columns        = 4
$ButtonWidth    = 105
$ButtonHeight   = 42
$Padding        = 25
$Font           = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)


# --- Define individual buttons: Label + Batch file ---
$ButtonMap = @(
    @{Text="Chrome";          File="Chrome.bat"}
    @{Text="Edge";            File="Edge.bat"}
    @{Text="FireFox";         File="firefox.bat"}
    @{Text="All Cookies";     File="AllCookies.bat"}
    @{Text="Crash Dumps";     File="Minidump.bat"}
    @{Text="Log Files";       File="LogFiles.bat"}
    @{Text="Temp Files";      File="TempFiles.bat"}
    @{Text="Prefetch";        File="Prefetch.bat"}
    @{Text="Update Cache";    File="WinUpdCa.bat"}
    @{Text="Disk Cleanup";    File="AutoClean.bat"}
    @{Text="Clean Windows Update"; File="winupd.bat"}
    @{Text="Recycle Bin";     File="RecycleBin.bat"}
)

# --- Extra bottom row buttons ---
$ExtraButtons = @(
    @{Text="Clean System";            File="ClnSys.bat"}
    @{Text="Premium System Cleanup";  File="ClnSysPre.bat"}
	@{Text="Storage Setting";  File="storage.vbs"}
)

$TotalButtons = $ButtonMap.Count
$TotalExtra   = $ExtraButtons.Count

# --- Form setup ---
$form                 = New-Object System.Windows.Forms.Form
$form.Text            = $Title
$form.StartPosition   = "CenterScreen"
$form.AutoScaleMode   = "None"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox     = $false

# Ikona aplikacji
$icoPath = Join-Path $BatchDirectory "icon.ico"
if (Test-Path $icoPath) {
    $form.Icon = New-Object System.Drawing.Icon($icoPath)
}

# Background image
$bgPath = Join-Path $BatchDirectory "bg.png"
if (Test-Path $bgPath) {
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($bgPath)
    $form.BackgroundImageLayout = "Stretch"
} else {
    $form.BackColor = [System.Drawing.Color]::FromArgb(245,245,245)
}

# Calculate form size
$rows = [math]::Ceiling($TotalButtons / $Columns)
$width = ($Columns * $ButtonWidth) + (($Columns + 1) * $Padding)
$height = ($rows * $ButtonHeight) + (($rows + 1) * $Padding) + 60 + ($ButtonHeight + $Padding)
$form.ClientSize = New-Object System.Drawing.Size($width, $height)

# --- MenuStrip ---
$menuStrip = New-Object System.Windows.Forms.MenuStrip

# File menu
$fileMenu  = New-Object System.Windows.Forms.ToolStripMenuItem("File")
$fileExit  = New-Object System.Windows.Forms.ToolStripMenuItem("Exit")
$fileExit.Add_Click({ $form.Close() })
$fileMenu.DropDownItems.Add($fileExit) | Out-Null

# Online menu
$onlineMenu   = New-Object System.Windows.Forms.ToolStripMenuItem("Online")

$onlineGitHub = New-Object System.Windows.Forms.ToolStripMenuItem("GitHub")
$onlineGitHub.Add_Click({ Start-Process "https://github.com/seb07uk" })

$onlineChomik = New-Object System.Windows.Forms.ToolStripMenuItem("Chomik")
$onlineChomik.Add_Click({ Start-Process "https://chomikuj.pl/polsoft-its/seb07uk" })

$onlineEmail  = New-Object System.Windows.Forms.ToolStripMenuItem("Email")
$onlineEmail.Add_Click({ Start-Process "mailto:polsoft.its@fastservice.com" })

$onlineMenu.DropDownItems.Add($onlineGitHub) | Out-Null
$onlineMenu.DropDownItems.Add($onlineChomik) | Out-Null
$onlineMenu.DropDownItems.Add($onlineEmail)  | Out-Null

# Help menu
$helpMenu  = New-Object System.Windows.Forms.ToolStripMenuItem("Help")
$helpAbout = New-Object System.Windows.Forms.ToolStripMenuItem("About")
$helpAbout.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "polsoft.ITS London`n`nShell Cleaner v1.0`n`n2025(c) Sebastian Januchowski",
        "About",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    ) | Out-Null
})
# Nowa pozycja License
$helpLicense = New-Object System.Windows.Forms.ToolStripMenuItem("License")
$helpLicense.Add_Click({
    try {
        Start-Process "mit.exe"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            "Nie udało się uruchomić pliku mit.exe",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    }
})

# Nowa pozycja Funktion FaQ
$helpFunktion = New-Object System.Windows.Forms.ToolStripMenuItem("Funktion FaQ")
$helpFunktion.Add_Click({
    try {
        Start-Process "button.exe"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            "Nie udało się uruchomić pliku button.exe",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    }
})

$helpReadME = New-Object System.Windows.Forms.ToolStripMenuItem("ReadMe")
$helpReadME.Add_Click({
    try {
        Start-Process "readme.html"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            "Nie udało się uruchomić pliku readme.html",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    }
})
$helpMenu.DropDownItems.Add($helpFunktion) | Out-Null
$helpMenu.DropDownItems.Add($helpReadME) | Out-Null
$helpMenu.DropDownItems.Add($helpLicense) | Out-Null
$helpMenu.DropDownItems.Add($helpAbout) | Out-Null

# Add menus to strip
$menuStrip.Items.Add($fileMenu)   | Out-Null
$menuStrip.Items.Add($onlineMenu) | Out-Null
$menuStrip.Items.Add($helpMenu)   | Out-Null
$form.MainMenuStrip = $menuStrip
$form.Controls.Add($menuStrip)

# --- Status strip ---
$statusStrip = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready"
$statusStrip.Items.Add($statusLabel) | Out-Null
$form.Controls.Add($statusStrip)

# --- Helper: launch batch with feedback ---
function Invoke-Option {
    param([string]$BatchFile)
    $batchPath = Join-Path $BatchDirectory $BatchFile
    if (-not (Test-Path -LiteralPath $batchPath)) {
        [System.Windows.Forms.MessageBox]::Show("File not found: $BatchFile`nCheck path: $batchPath","Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
        $statusLabel.Text = "Missing: $BatchFile"
        return
    }
    try {
        $statusLabel.Text = "Launching: $BatchFile"
        Start-Process -FilePath $batchPath -WorkingDirectory $BatchDirectory -Verb RunAs
        $statusLabel.Text = "Launched: $BatchFile"
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to launch $BatchFile`n$_","Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
        $statusLabel.Text = "Error: $BatchFile"
    }
}

# --- Create main buttons ---
for ($i = 0; $i -lt $TotalButtons; $i++) {
    $button = New-Object System.Windows.Forms.Button
    $button.Font = $Font
    $button.Text = $ButtonMap[$i].Text
    $button.Tag  = $ButtonMap[$i].File
    $button.Width  = $ButtonWidth
    $button.Height = $ButtonHeight
    $button.BackColor = [System.Drawing.Color]::White

    $row = [math]::Floor($i / $Columns)
    $col = $i % $Columns
    $x = $Padding + ($col * ($ButtonWidth + $Padding))
    $y = $Padding + ($row * ($ButtonHeight + $Padding)) + $menuStrip.Height
    $button.Location = New-Object System.Drawing.Point($x, $y)

    $button.Add_Click({ Invoke-Option -BatchFile $this.Tag })
    $form.Controls.Add($button)
}

# --- Create extra bottom row buttons ---
for ($j = 0; $j -lt $TotalExtra; $j++) {
    $button = New-Object System.Windows.Forms.Button
    $button.Font = $Font
    $button.Text = $ExtraButtons[$j].Text
    $button.Tag  = $ExtraButtons[$j].File
    $button.Width  = $ButtonWidth
    $button.Height = $ButtonHeight
    $button.BackColor = [System.Drawing.Color]::White

    $x = $Padding + ($j * ($ButtonWidth + $Padding))
    $y = $Padding + ($rows * ($ButtonHeight + $Padding)) + $menuStrip.Height
    $button.Location = New-Object System.Drawing.Point($x, $y)

    $button.Add_Click({ Invoke-Option -BatchFile $this.Tag })
    $form.Controls.Add($button)
}

# --- Show form ---
[void]$form.ShowDialog()