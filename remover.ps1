
# CC Remover - By Mizzery
# Eclipse + Windows 11 Style (Single File WPF)

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="CC Remover - By Mizzery"
        Height="760" Width="1200"
        WindowStartupLocation="CenterScreen"
        Background="#111111"
        ResizeMode="CanResize">

<Grid Margin="15">
<Grid.ColumnDefinitions>
    <ColumnDefinition Width="220"/>
    <ColumnDefinition Width="*"/>
</Grid.ColumnDefinitions>

<Border Grid.Column="0" Background="#181818" CornerRadius="16" Padding="15">
    <StackPanel>
        <TextBlock Text="CC REMOVER" Foreground="White" FontSize="24" FontWeight="Bold"/>
        <TextBlock Text="By Mizzery" Foreground="#AAAAAA" Margin="0,0,0,20"/>

        <Button Name="HomeBtn" Content="Home" Height="40" Margin="0,5"/>
        <Button Name="ScanBtn" Content="Scan" Height="40" Margin="0,5"/>
        <Button Name="BackupBtn" Content="Backups" Height="40" Margin="0,5"/>
        <Button Name="AboutBtn" Content="About" Height="40" Margin="0,5"/>
    </StackPanel>
</Border>

<Grid Grid.Column="1" Margin="15,0,0,0">
<Grid.RowDefinitions>
<RowDefinition Height="Auto"/>
<RowDefinition Height="Auto"/>
<RowDefinition Height="*"/>
<RowDefinition Height="Auto"/>
</Grid.RowDefinitions>

<TextBlock Text="Modern Comment Removal Utility"
           Foreground="White"
           FontSize="28"
           FontWeight="SemiBold"/>

<StackPanel Grid.Row="1" Margin="0,15,0,10">
    <TextBox Name="FolderBox" Height="34"/>
    <WrapPanel Margin="0,10,0,0">
        <Button Name="BrowseBtn" Content="Browse Folder" Width="140" Height="35"/>
        <Button Name="RunBtn" Content="Remove Comments" Width="160" Height="35" Margin="10,0,0,0"/>
        <Button Name="RestoreBtn" Content="Restore Backups" Width="160" Height="35" Margin="10,0,0,0"/>
    </WrapPanel>
</StackPanel>

<Grid Grid.Row="2">
<Grid.ColumnDefinitions>
<ColumnDefinition Width="3*"/>
<ColumnDefinition Width="1*"/>
</Grid.ColumnDefinitions>

<RichTextBox Name="LogBox" Margin="0,0,10,0"/>

<Border Grid.Column="1" Background="#181818" CornerRadius="12" Padding="12">
<StackPanel>
<TextBlock Name="FilesFound" Foreground="White" Text="Files Found: 0"/>
<TextBlock Name="FilesProcessed" Foreground="White" Text="Processed: 0" Margin="0,10,0,0"/>
<TextBlock Name="CommentsRemoved" Foreground="White" Text="Comments Removed: 0" Margin="0,10,0,0"/>
<TextBlock Name="Elapsed" Foreground="White" Text="Elapsed: 0s" Margin="0,10,0,0"/>
<TextBlock Foreground="#AAAAAA" Margin="0,20,0,0"
Text="Drag a folder onto the window to select it." TextWrapping="Wrap"/>
</StackPanel>
</Border>
</Grid>

<ProgressBar Name="ProgressBar" Grid.Row="3" Height="24"/>
</Grid>
</Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$Window = [Windows.Markup.XamlReader]::Load($reader)

$FolderBox = $Window.FindName("FolderBox")
$BrowseBtn = $Window.FindName("BrowseBtn")
$RunBtn = $Window.FindName("RunBtn")
$RestoreBtn = $Window.FindName("RestoreBtn")
$LogBox = $Window.FindName("LogBox")
$ProgressBar = $Window.FindName("ProgressBar")
$FilesFound = $Window.FindName("FilesFound")
$FilesProcessed = $Window.FindName("FilesProcessed")
$CommentsRemoved = $Window.FindName("CommentsRemoved")
$Elapsed = $Window.FindName("Elapsed")

$Window.AllowDrop = $true

$Window.Add_DragOver({
    $_.Effects = [Windows.DragDropEffects]::Copy
    $_.Handled = $true
})

$Window.Add_Drop({
    $items = $_.Data.GetData([Windows.DataFormats]::FileDrop)
    if($items){
        $first = $items[0]
        if(Test-Path $first -PathType Container){
            $FolderBox.Text = $first
        } else {
            $FolderBox.Text = Split-Path $first -Parent
        }
    }
})

$BrowseBtn.Add_Click({
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.BrowseForFolder(0,"Select Project Folder",0,0)
    if($folder){ $FolderBox.Text = $folder.Self.Path }
})

$RestoreBtn.Add_Click({
    [System.Windows.MessageBox]::Show("Restore Backups feature coming soon.","CC Remover")
})

$RunBtn.Add_Click({

    $root = $FolderBox.Text

    if(!(Test-Path $root)){
        [System.Windows.MessageBox]::Show("Please select a valid folder.")
        return
    }

    $result = [System.Windows.MessageBox]::Show(
        "A backup will be created before modifying files.`nContinue?",
        "CC Remover",
        "YesNo"
    )

    if($result -ne "Yes"){ return }

    $start = Get-Date
    $backupRoot = Join-Path $root "Backups"

    New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

    $files = Get-ChildItem $root -Recurse -File |
        Where-Object {
            $_.FullName -notmatch '\\Backups\\' -and
            $_.Extension -match '\.(js|ts|jsx|tsx|css|html|htm|java|cs|c|cpp|h|hpp|php)$'
        }

    $FilesFound.Text = "Files Found: $($files.Count)"
    $ProgressBar.Maximum = [Math]::Max($files.Count,1)

    $processed = 0
    $removed = 0

    foreach($file in $files){

        $processed++

        $relative = $file.FullName.Substring($root.Length).TrimStart('\')
        $backupFile = Join-Path $backupRoot ($relative + ".bak")

        New-Item -ItemType Directory -Force -Path (Split-Path $backupFile -Parent) | Out-Null
        Copy-Item $file.FullName $backupFile -Force

        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if($null -eq $content){ continue }

        $before = $content.Length

        $content = [regex]::Replace($content,'/\*[\s\S]*?\*/','')
        $content = [regex]::Replace($content,'(?m)^\s*//.*?$','')
        $content = [regex]::Replace($content,'<!--[\s\S]*?-->','')

        $removed += ($before - $content.Length)

        Set-Content $file.FullName $content

        $LogBox.AppendText("✓ $($file.FullName)`r`n")

        $FilesProcessed.Text = "Processed: $processed"
        $CommentsRemoved.Text = "Comments Removed: $removed"
        $Elapsed.Text = "Elapsed: $([int]((Get-Date)-$start).TotalSeconds)s"
        $ProgressBar.Value = $processed
    }

    [System.Windows.MessageBox]::Show(
        "Completed.`nProcessed $processed files.",
        "CC Remover - By Mizzery"
    )
})

$Window.ShowDialog() | Out-Null
