
# CC Remover - By Mizzery
# Single-file WPF version

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="CC Remover - By Mizzery"
        Height="700" Width="1000"
        WindowStartupLocation="CenterScreen"
        Background="#1E1E1E">
    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <TextBlock Text="CC Remover - By Mizzery"
                   FontSize="28"
                   Foreground="White"
                   Margin="0,0,0,10"/>

        <StackPanel Grid.Row="1" Orientation="Horizontal">
            <TextBox Name="FolderBox" Width="750" Height="30"/>
            <Button Name="BrowseBtn" Content="Browse" Width="100" Margin="10,0,0,0"/>
        </StackPanel>

        <WrapPanel Grid.Row="2" Margin="0,10">
            <CheckBox Name="JSBox" Content="JS/TS" IsChecked="True" Foreground="White" Margin="10"/>
            <CheckBox Name="HTMLBox" Content="HTML/CSS" IsChecked="True" Foreground="White" Margin="10"/>
            <CheckBox Name="CSBox" Content="C#" IsChecked="True" Foreground="White" Margin="10"/>
            <CheckBox Name="CPPBox" Content="C/C++" IsChecked="True" Foreground="White" Margin="10"/>
            <CheckBox Name="JavaBox" Content="Java" IsChecked="True" Foreground="White" Margin="10"/>
            <CheckBox Name="PHPBox" Content="PHP" IsChecked="True" Foreground="White" Margin="10"/>
        </WrapPanel>

        <Grid Grid.Row="3">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="3*"/>
                <ColumnDefinition Width="1*"/>
            </Grid.ColumnDefinitions>

            <RichTextBox Name="LogBox" Margin="0,0,10,0"/>

            <StackPanel Grid.Column="1">
                <TextBlock Name="FilesFound" Foreground="White" Margin="0,5" Text="Files Found: 0"/>
                <TextBlock Name="FilesProcessed" Foreground="White" Margin="0,5" Text="Processed: 0"/>
                <TextBlock Name="CommentsRemoved" Foreground="White" Margin="0,5" Text="Comments Removed: 0"/>
                <TextBlock Name="Elapsed" Foreground="White" Margin="0,5" Text="Elapsed: 0s"/>
            </StackPanel>
        </Grid>

        <StackPanel Grid.Row="4">
            <ProgressBar Name="ProgressBar" Height="25"/>
            <WrapPanel Margin="0,10">
                <Button Name="RunBtn" Content="Remove Comments" Width="150"/>
                <Button Name="RestoreBtn" Content="Restore Backups" Width="150" Margin="10,0,0,0"/>
            </WrapPanel>
        </StackPanel>
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

$BrowseBtn.Add_Click({
    Add-Type -AssemblyName System.Windows.Forms
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    if($dlg.ShowDialog() -eq "OK"){
        $FolderBox.Text = $dlg.SelectedPath
    }
})

$RestoreBtn.Add_Click({
    [System.Windows.MessageBox]::Show("Restore Backups feature placeholder.")
})

$RunBtn.Add_Click({
    $root = $FolderBox.Text
    if(!(Test-Path $root)){
        [System.Windows.MessageBox]::Show("Select a valid folder.")
        return
    }

    $start = Get-Date
    $backupRoot = Join-Path $root "Backups"
    New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

    $files = Get-ChildItem $root -Recurse -File |
        Where-Object {
            $_.FullName -notmatch '\\Backups\\' -and
            $_.Extension -match '\.(js|ts|jsx|tsx|css|html|htm|cs|c|cpp|h|hpp|java|php)$'
        }

    $FilesFound.Text = "Files Found: $($files.Count)"
    $ProgressBar.Maximum = [Math]::Max($files.Count,1)

    $processed = 0
    $removed = 0

    foreach($file in $files){
        $processed++

        $relative = $file.FullName.Substring($root.Length).TrimStart('\')
        $backup = Join-Path $backupRoot ($relative + ".bak")

        New-Item -ItemType Directory -Force -Path (Split-Path $backup) | Out-Null
        Copy-Item $file.FullName $backup -Force

        $content = Get-Content $file.FullName -Raw
        $before = $content.Length

        $content = [regex]::Replace($content,'/\*[\s\S]*?\*/','')
        $content = [regex]::Replace($content,'(?m)^\s*//.*?$','')
        $content = [regex]::Replace($content,'<!--[\s\S]*?-->','')

        $removed += ($before - $content.Length)

        Set-Content $file.FullName $content

        $LogBox.AppendText("OK: $($file.FullName)`r`n")
        $FilesProcessed.Text = "Processed: $processed"
        $CommentsRemoved.Text = "Comments Removed: $removed"
        $Elapsed.Text = "Elapsed: $([int]((Get-Date)-$start).TotalSeconds)s"
        $ProgressBar.Value = $processed
    }

    [System.Windows.MessageBox]::Show("Completed!")
})

$Window.ShowDialog() | Out-Null
