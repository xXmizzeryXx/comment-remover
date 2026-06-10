Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "CC Remover - By Mizzery"
$form.Size = New-Object System.Drawing.Size(750,550)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Select a folder containing source code:"
$label.Location = New-Object System.Drawing.Point(10,15)
$label.AutoSize = $true
$form.Controls.Add($label)

$txtPath = New-Object System.Windows.Forms.TextBox
$txtPath.Location = New-Object System.Drawing.Point(10,40)
$txtPath.Size = New-Object System.Drawing.Size(580,25)
$form.Controls.Add($txtPath)

$btnBrowse = New-Object System.Windows.Forms.Button
$btnBrowse.Text = "Browse"
$btnBrowse.Location = New-Object System.Drawing.Point(600,38)
$form.Controls.Add($btnBrowse)

$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "Remove Comments"
$btnRun.Location = New-Object System.Drawing.Point(10,75)
$form.Controls.Add($btnRun)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(150,78)
$progressBar.Size = New-Object System.Drawing.Size(530,20)
$form.Controls.Add($progressBar)

$output = New-Object System.Windows.Forms.RichTextBox
$output.Location = New-Object System.Drawing.Point(10,110)
$output.Size = New-Object System.Drawing.Size(710,390)
$output.ReadOnly = $true
$form.Controls.Add($output)

$folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog

$btnBrowse.Add_Click({
    if ($folderDialog.ShowDialog() -eq "OK") {
        $txtPath.Text = $folderDialog.SelectedPath
    }
})

function Remove-CodeComments {
    param(
        [string]$File,
        [string]$RootFolder
    )

    try {
        $content = Get-Content $File -Raw -Encoding UTF8

        # Create backup folder
        $backupRoot = Join-Path $RootFolder "Backups"

        if (-not (Test-Path $backupRoot)) {
            New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
        }

        # Preserve folder structure
        $relativePath = $File.Substring($RootFolder.Length).TrimStart('\')
        $backupFile = Join-Path $backupRoot ($relativePath + ".bak")

        $backupDir = Split-Path $backupFile -Parent

        if (-not (Test-Path $backupDir)) {
            New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        }

        Copy-Item $File $backupFile -Force

        # Remove multiline comments
        $content = [regex]::Replace(
            $content,
            '/\*[\s\S]*?\*/',
            '',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )

        # Remove single-line comments
        $content = [regex]::Replace(
            $content,
            '(?m)^\s*//.*?$',
            ''
        )

        # Remove HTML comments
        $content = [regex]::Replace(
            $content,
            '<!--[\s\S]*?-->',
            '',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )

        Set-Content -Path $File -Value $content -Encoding UTF8

        return $true
    }
    catch {
        return $false
    }
}

$btnRun.Add_Click({

    $output.Clear()

    if (-not (Test-Path $txtPath.Text)) {
        [System.Windows.Forms.MessageBox]::Show(
            "Please select a valid folder.",
            "CC Remover"
        )
        return
    }

    $extensions = @(
        "*.js","*.ts","*.jsx","*.tsx",
        "*.css","*.html","*.htm",
        "*.java",
        "*.c","*.cpp","*.h","*.hpp",
        "*.cs",
        "*.php"
    )

    $files = foreach ($ext in $extensions) {
        Get-ChildItem $txtPath.Text -Recurse -File -Filter $ext -ErrorAction SilentlyContinue
    }

    # Skip Backups folder if it already exists
    $files = $files | Where-Object {
        $_.FullName -notmatch '\\Backups\\'
    }

    $total = $files.Count
    $processed = 0
    $success = 0

    if ($total -eq 0) {
        [System.Windows.Forms.MessageBox]::Show(
            "No supported code files found.",
            "CC Remover"
        )
        return
    }

    $progressBar.Maximum = $total
    $progressBar.Value = 0

    foreach ($file in $files) {

        $processed++

        if (Remove-CodeComments $file.FullName $txtPath.Text) {
            $success++
            $output.AppendText("[OK] $($file.FullName)`r`n")
        }
        else {
            $output.AppendText("[FAILED] $($file.FullName)`r`n")
        }

        $progressBar.Value = $processed
        $form.Refresh()
    }

    $output.AppendText("`r`n=========================================`r`n")
    $output.AppendText("CC Remover Complete`r`n")
    $output.AppendText("Files Found: $total`r`n")
    $output.AppendText("Files Processed: $processed`r`n")
    $output.AppendText("Successful: $success`r`n")
    $output.AppendText("Backups Saved To: $($txtPath.Text)\Backups`r`n")

    [System.Windows.Forms.MessageBox]::Show(
        "Comment removal complete.`n`nProcessed $processed files.",
        "CC Remover - By Mizzery"
    )
})

[void]$form.ShowDialog()
