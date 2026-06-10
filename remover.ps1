# CC Remover - By Mizzery
# Enhanced Modern UI - Eclipse + Windows 11 Inspired (Single File WPF)
Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="CC Remover - By Mizzery"
        Height="820" Width="1280"
        WindowStartupLocation="CenterScreen"
        Background="#0F0F0F"
        ResizeMode="CanResizeWithGrip"
        AllowsTransparency="False"
        WindowStyle="SingleBorderWindow">
    
    <Window.Resources>
        <!-- Modern Button Style -->
        <Style TargetType="Button" x:Key="ModernButton">
            <Setter Property="Background" Value="#1E1E1E"/>
            <Setter Property="Foreground" Value="#E0E0E0"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="16,8"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Medium"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}" CornerRadius="8" BorderBrush="#333333" BorderThickness="1">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#2D2D2D"/>
                                <Setter TargetName="border" Property="BorderBrush" Value="#00DDFF"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#00AAFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Accent Button -->
        <Style TargetType="Button" x:Key="AccentButton" BasedOn="{StaticResource ModernButton}">
            <Setter Property="Background" Value="#007ACC"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}" CornerRadius="8">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#1088E0"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#0066AA"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Sidebar Button -->
        <Style TargetType="Button" x:Key="SidebarButton" BasedOn="{StaticResource ModernButton}">
            <Setter Property="HorizontalAlignment" Value="Stretch"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="20,12"/>
            <Setter Property="Margin" Value="0,4,0,4"/>
        </Style>
    </Window.Resources>

    <Grid Margin="12">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="260"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <!-- Sidebar -->
        <Border Grid.Column="0" Background="#1A1A1A" CornerRadius="16" Padding="8" BorderBrush="#222222" BorderThickness="1">
            <StackPanel>
                <!-- Logo/Header -->
                <StackPanel Orientation="Horizontal" Margin="12,20,12,30">
                    <Border Width="48" Height="48" Background="#007ACC" CornerRadius="12">
                        <TextBlock Text="CC" FontSize="22" FontWeight="Bold" Foreground="White" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                    <StackPanel Margin="16,0,0,0" VerticalAlignment="Center">
                        <TextBlock Text="CC REMOVER" Foreground="#FFFFFF" FontSize="22" FontWeight="SemiBold"/>
                        <TextBlock Text="By Mizzery" Foreground="#888888" FontSize="13"/>
                    </StackPanel>
                </StackPanel>

                <!-- Navigation -->
                <Button Name="HomeBtn" Style="{StaticResource SidebarButton}" Content="🏠 Home"/>
                <Button Name="ScanBtn" Style="{StaticResource SidebarButton}" Content="🔍 Scan Files"/>
                <Button Name="BackupBtn" Style="{StaticResource SidebarButton}" Content="📦 Backups"/>
                <Button Name="SettingsBtn" Style="{StaticResource SidebarButton}" Content="⚙️ Settings"/>
                <Button Name="AboutBtn" Style="{StaticResource SidebarButton}" Content="ℹ️ About"/>

                <Separator Background="#333333" Margin="16,30,16,20" Height="1"/>

                <!-- Quick Stats -->
                <TextBlock Text="QUICK STATS" Foreground="#666666" FontSize="11" Margin="20,0,0,8" FontWeight="Medium"/>
                <Border Background="#222222" CornerRadius="10" Padding="16" Margin="12,0">
                    <StackPanel>
                        <TextBlock Name="QuickFiles" Text="Files Scanned: 0" Foreground="#AAAAAA" Margin="0,4"/>
                        <TextBlock Name="QuickRemoved" Text="Comments Removed: 0" Foreground="#AAAAAA" Margin="0,4"/>
                    </StackPanel>
                </Border>
            </StackPanel>
        </Border>

        <!-- Main Content -->
        <Grid Grid.Column="1" Margin="20,0,0,0">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <!-- Header -->
            <StackPanel Grid.Row="0" Margin="0,0,0,20">
                <TextBlock Text="Modern Comment Remover" 
                           Foreground="#FFFFFF" 
                           FontSize="32" 
                           FontWeight="SemiBold"/>
                <TextBlock Text="Safely strip comments from source files • Supports 15+ languages" 
                           Foreground="#888888" 
                           FontSize="15"/>
            </StackPanel>

            <!-- Controls -->
            <Border Grid.Row="1" Background="#1A1A1A" CornerRadius="12" Padding="20">
                <StackPanel>
                    <TextBlock Text="Target Folder" Foreground="#CCCCCC" FontSize="14" Margin="0,0,0,8"/>
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <TextBox Name="FolderBox" Height="46" Padding="16,0" FontSize="14" Background="#252525" Foreground="#E0E0E0" BorderThickness="1" BorderBrush="#333333" VerticalContentAlignment="Center"/>
                        <Button Name="BrowseBtn" Grid.Column="1" Content="Browse" Width="120" Height="46" Margin="12,0,0,0" Style="{StaticResource AccentButton}"/>
                    </Grid>

                    <WrapPanel Margin="0,18,0,0">
                        <Button Name="RunBtn" Content="🚀 Remove Comments" Width="220" Height="52" Style="{StaticResource AccentButton}" FontSize="16" FontWeight="SemiBold"/>
                        <Button Name="RestoreBtn" Content="Restore Backups" Width="180" Height="52" Margin="12,0,0,0" Style="{StaticResource ModernButton}"/>
                        <Button Name="ClearLogBtn" Content="Clear Log" Width="140" Height="52" Margin="12,0,0,0" Style="{StaticResource ModernButton}"/>
                    </WrapPanel>
                </StackPanel>
            </Border>

            <!-- Log + Stats -->
            <Grid Grid.Row="2" Margin="0,20,0,0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="3*"/>
                    <ColumnDefinition Width="2*"/>
                </Grid.ColumnDefinitions>

                <!-- Log Area -->
                <Border Background="#111111" CornerRadius="12" BorderBrush="#222222" BorderThickness="1">
                    <DockPanel>
                        <TextBlock DockPanel.Dock="Top" Text="Operation Log" Foreground="#AAAAAA" FontSize="14" FontWeight="Medium" Margin="16,12,16,8"/>
                        <RichTextBox Name="LogBox" Background="Transparent" BorderThickness="0" Padding="16" FontFamily="Consolas" FontSize="13" Foreground="#D0D0D0" IsReadOnly="True"/>
                    </DockPanel>
                </Border>

                <!-- Live Stats -->
                <Border Grid.Column="1" Margin="16,0,0,0" Background="#1A1A1A" CornerRadius="12" Padding="20">
                    <StackPanel>
                        <TextBlock Text="LIVE PROGRESS" Foreground="#00DDFF" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,20"/>
                        
                        <StackPanel Margin="0,0,0,24">
                            <TextBlock Name="FilesFound" Text="Files Found: 0" Foreground="#E0E0E0" FontSize="15"/>
                            <ProgressBar Name="ProgressBar" Height="8" Margin="0,10,0,6" Background="#222222" BorderThickness="0"/>
                            <TextBlock Name="FilesProcessed" Text="Processed: 0 / 0" Foreground="#AAAAAA" FontSize="13"/>
                        </StackPanel>

                        <Border Background="#222222" CornerRadius="10" Padding="16">
                            <StackPanel>
                                <TextBlock Name="CommentsRemoved" Text="Comments Removed: 0" Foreground="#00FFAA" FontSize="15" FontWeight="Medium"/>
                                <TextBlock Name="Elapsed" Text="Elapsed: 0s" Foreground="#AAAAAA" Margin="0,12,0,0" FontSize="14"/>
                                <TextBlock Name="SizeSaved" Text="Est. size saved: 0 KB" Foreground="#AAAAAA" Margin="0,6,0,0" FontSize="14"/>
                            </StackPanel>
                        </Border>

                        <TextBlock Text="💡 Drag &amp; drop a folder onto this window" 
                                   Foreground="#555555" 
                                   TextWrapping="Wrap" 
                                   Margin="0,32,0,0" 
                                   FontSize="13"
                                   HorizontalAlignment="Center"/>
                    </StackPanel>
                </Border>
            </Grid>

            <!-- Footer -->
            <TextBlock Grid.Row="3" Text="Supported: JS • TS • JSX • TSX • CSS • HTML • Java • C# • C/C++ • PHP • Python • Go • Rust • and more" 
                       Foreground="#555555" 
                       FontSize="12" 
                       HorizontalAlignment="Center" 
                       Margin="0,16,0,0"/>
        </Grid>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Find controls
$FolderBox = $Window.FindName("FolderBox")
$BrowseBtn = $Window.FindName("BrowseBtn")
$RunBtn = $Window.FindName("RunBtn")
$RestoreBtn = $Window.FindName("RestoreBtn")
$ClearLogBtn = $Window.FindName("ClearLogBtn")
$LogBox = $Window.FindName("LogBox")
$ProgressBar = $Window.FindName("ProgressBar")
$FilesFound = $Window.FindName("FilesFound")
$FilesProcessed = $Window.FindName("FilesProcessed")
$CommentsRemoved = $Window.FindName("CommentsRemoved")
$Elapsed = $Window.FindName("Elapsed")
$SizeSaved = $Window.FindName("SizeSaved")
$QuickFiles = $Window.FindName("QuickFiles")
$QuickRemoved = $Window.FindName("QuickRemoved")

$Window.AllowDrop = $true

# Drag & Drop
$Window.Add_DragOver({
    $_.Effects = [Windows.DragDropEffects]::Copy
    $_.Handled = $true
})

$Window.Add_Drop({
    $items = $_.Data.GetData([Windows.DataFormats]::FileDrop)
    if ($items) {
        $first = $items[0]
        if (Test-Path $first -PathType Container) {
            $FolderBox.Text = $first
        } else {
            $FolderBox.Text = Split-Path $first -Parent
        }
        $LogBox.AppendText("📁 Folder selected via drag & drop`r`n")
    }
})

# Browse
$BrowseBtn.Add_Click({
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.BrowseForFolder(0, "Select Project Folder", 0, 0)
    if ($folder) { 
        $FolderBox.Text = $folder.Self.Path 
        $LogBox.AppendText("📁 Folder selected: $($folder.Self.Path)`r`n")
    }
})

# Clear Log
$ClearLogBtn.Add_Click({
    $LogBox.Document.Blocks.Clear()
    $LogBox.AppendText("🧹 Log cleared`r`n")
})

# Restore (placeholder)
$RestoreBtn.Add_Click({
    [System.Windows.MessageBox]::Show("Full backup restore with preview coming in next version.", "CC Remover", "OK", "Information")
})

# Main Run Button
$RunBtn.Add_Click({
    $root = $FolderBox.Text.Trim()
    if ([string]::IsNullOrEmpty($root) -or !(Test-Path $root)) {
        [System.Windows.MessageBox]::Show("Please select a valid folder.", "CC Remover", "OK", "Warning")
        return
    }

    $confirm = [System.Windows.MessageBox]::Show(
        "This will create backups before removing comments.`n`nContinue?",
        "Confirm Operation",
        "YesNo",
        "Question"
    )
    if ($confirm -ne "Yes") { return }

    $startTime = Get-Date
    $backupRoot = Join-Path $root "CC_Backups_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

    $extensions = '\.(js|ts|jsx|tsx|css|html|htm|java|c|cpp|h|hpp|cs|php|py|go|rs|swift)$'
    
    $files = Get-ChildItem $root -Recurse -File | 
        Where-Object { 
            $_.FullName -notmatch '\\CC_Backups_' -and 
            $_.Extension -match $extensions 
        }

    $FilesFound.Text = "Files Found: $($files.Count)"
    $ProgressBar.Maximum = [Math]::Max($files.Count, 1)
    $ProgressBar.Value = 0

    $processed = 0
    $removedTotal = 0
    $sizeSaved = 0

    foreach ($file in $files) {
        $processed++
        $relative = $file.FullName.Substring($root.Length).TrimStart('\')
        $backupFile = Join-Path $backupRoot $relative
        $backupDir = Split-Path $backupFile -Parent
        New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
        Copy-Item $file.FullName $backupFile -Force

        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($null -eq $content) { continue }

        $before = $content.Length
        $originalContent = $content

        # Multi-line comments
        $content = [regex]::Replace($content, '/\*[\s\S]*?\*/', '')
        # Single-line comments
        $content = [regex]::Replace($content, '(?m)^\s*//.*?$', '')
        # HTML comments
        $content = [regex]::Replace($content, '<!--[\s\S]*?-->', '')
        # Python/Rust/Go style comments (#)
        $content = [regex]::Replace($content, '(?m)^\s*#.*?$', '')

        $after = $content.Length
        $removed = $before - $after
        $removedTotal += $removed
        if ($removed -gt 0) { $sizeSaved += $removed }

        Set-Content $file.FullName $content -Encoding UTF8

        # Log
        $LogBox.AppendText("✓ $($file.Name)  (-$removed chars)`r`n")
        $LogBox.ScrollToEnd()

        # Update UI
        $FilesProcessed.Text = "Processed: $processed / $($files.Count)"
        $CommentsRemoved.Text = "Comments Removed: $removedTotal"
        $Elapsed.Text = "Elapsed: $([int]((Get-Date) - $startTime).TotalSeconds)s"
        $SizeSaved.Text = "Est. size saved: $([Math]::Round($sizeSaved/1024, 2)) KB"
        $ProgressBar.Value = $processed

        $QuickFiles.Text = "Files Scanned: $processed"
        $QuickRemoved.Text = "Comments Removed: $removedTotal"
    }

    $duration = [int]((Get-Date) - $startTime).TotalSeconds
    [System.Windows.MessageBox]::Show(
        "Operation completed successfully!`n`nProcessed: $processed files`nComments removed: $removedTotal`nTime: ${duration}s", 
        "CC Remover - Success",
        "OK",
        "Information"
    )
})

# Show window
$Window.ShowDialog() | Out-Null
