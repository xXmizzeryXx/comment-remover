# CC Remover v2.0 - By Mizzery
# Fluent Design, Purple Accent, Multi-Page Navigation
# Single-File WPF PowerShell

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="CC Remover v2.0"
        Height="860" Width="1320"
        MinHeight="720" MinWidth="1100"
        WindowStartupLocation="CenterScreen"
        Background="#0A0A0F"
        ResizeMode="CanResizeWithGrip"
        WindowStyle="SingleBorderWindow"
        FontFamily="Segoe UI">

    <Window.Resources>

        <!-- ===== COLOR RESOURCES ===== -->
        <SolidColorBrush x:Key="BgBase"       Color="#0A0A0F"/>
        <SolidColorBrush x:Key="BgSurface"    Color="#12121A"/>
        <SolidColorBrush x:Key="BgCard"       Color="#1A1A26"/>
        <SolidColorBrush x:Key="BgCardHover"  Color="#1F1F2E"/>
        <SolidColorBrush x:Key="BgInput"      Color="#0F0F18"/>
        <SolidColorBrush x:Key="Accent"       Color="#8B5CF6"/>
        <SolidColorBrush x:Key="AccentHover"  Color="#A78BFA"/>
        <SolidColorBrush x:Key="AccentPress"  Color="#7C3AED"/>
        <SolidColorBrush x:Key="AccentGlow"   Color="#6D28D9"/>
        <SolidColorBrush x:Key="Success"      Color="#10B981"/>
        <SolidColorBrush x:Key="Warning"      Color="#F59E0B"/>
        <SolidColorBrush x:Key="Danger"       Color="#EF4444"/>
        <SolidColorBrush x:Key="TextPrimary"  Color="#F1F0FF"/>
        <SolidColorBrush x:Key="TextSub"      Color="#9CA3AF"/>
        <SolidColorBrush x:Key="TextMuted"    Color="#4B5563"/>
        <SolidColorBrush x:Key="Border1"      Color="#1E1E2E"/>
        <SolidColorBrush x:Key="Border2"      Color="#2D2D42"/>

        <!-- ===== SCROLLBAR STYLE ===== -->
        <Style TargetType="ScrollBar">
            <Setter Property="Width" Value="6"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ScrollBar">
                        <Grid>
                            <Track x:Name="PART_Track" IsDirectionReversed="True">
                                <Track.Thumb>
                                    <Thumb>
                                        <Thumb.Template>
                                            <ControlTemplate TargetType="Thumb">
                                                <Border Background="#3D3D5C" CornerRadius="3" Margin="1,0"/>
                                            </ControlTemplate>
                                        </Thumb.Template>
                                    </Thumb>
                                </Track.Thumb>
                            </Track>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== SCROLLVIEWER STYLE ===== -->
        <Style TargetType="ScrollViewer">
            <Setter Property="VerticalScrollBarVisibility" Value="Auto"/>
            <Setter Property="HorizontalScrollBarVisibility" Value="Disabled"/>
        </Style>

        <!-- ===== BUTTON BASE ===== -->
        <Style x:Key="BtnBase" TargetType="Button">
            <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
        </Style>

        <!-- ===== ACCENT BUTTON ===== -->
        <Style x:Key="AccentBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Background" Value="{StaticResource Accent}"/>
            <Setter Property="Padding" Value="20,10"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="10" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="{StaticResource AccentHover}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="{StaticResource AccentPress}"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="bd" Property="Background" Value="#2D2D42"/>
                                <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== GHOST BUTTON ===== -->
        <Style x:Key="GhostBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Padding" Value="16,9"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="8"
                                BorderBrush="{StaticResource Border2}" BorderThickness="1" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="{StaticResource BgCard}"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="{StaticResource BgCardHover}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== DANGER BUTTON ===== -->
        <Style x:Key="DangerBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Background" Value="#3B1E1E"/>
            <Setter Property="Foreground" Value="#FCA5A5"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="8"
                                BorderBrush="#5C2626" BorderThickness="1" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#EF4444"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== SIDEBAR NAV BUTTON ===== -->
        <Style x:Key="NavBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextSub}"/>
            <Setter Property="HorizontalAlignment" Value="Stretch"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="16,12"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Margin" Value="8,2"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="10"
                                Padding="{TemplateBinding Padding}">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="Auto"/>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <Border x:Name="indicator" Grid.Column="0" Width="3" Height="20" CornerRadius="2"
                                        Background="Transparent" Margin="0,0,10,0"/>
                                <ContentPresenter Grid.Column="1" VerticalAlignment="Center"
                                                  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}"/>
                            </Grid>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#1A1A26"/>
                                <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
                            </Trigger>
                            <Trigger Property="Tag" Value="active">
                                <Setter TargetName="bd" Property="Background" Value="#1E1433"/>
                                <Setter Property="Foreground" Value="{StaticResource AccentHover}"/>
                                <Setter TargetName="indicator" Property="Background" Value="{StaticResource Accent}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== TEXTBOX ===== -->
        <Style TargetType="TextBox">
            <Setter Property="Background" Value="{StaticResource BgInput}"/>
            <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
            <Setter Property="BorderBrush" Value="{StaticResource Border2}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="12,0"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="CaretBrush" Value="{StaticResource AccentHover}"/>
            <Setter Property="SelectionBrush" Value="{StaticResource Accent}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border x:Name="bd" Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="8" Padding="{TemplateBinding Padding}">
                            <ScrollViewer x:Name="PART_ContentHost" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsFocused" Value="True">
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== CHECKBOX ===== -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="{StaticResource TextSub}"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,4"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="CheckBox">
                        <StackPanel Orientation="Horizontal">
                            <Border x:Name="box" Width="18" Height="18" CornerRadius="5"
                                    BorderBrush="{StaticResource Border2}" BorderThickness="1.5"
                                    Background="{StaticResource BgInput}" Margin="0,0,10,0">
                                <TextBlock x:Name="chk" Text="✓" FontSize="11" FontWeight="Bold"
                                           Foreground="{StaticResource Accent}"
                                           HorizontalAlignment="Center" VerticalAlignment="Center"
                                           Visibility="Collapsed"/>
                            </Border>
                            <ContentPresenter VerticalAlignment="Center"/>
                        </StackPanel>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="box" Property="Background" Value="#1E1433"/>
                                <Setter TargetName="box" Property="BorderBrush" Value="{StaticResource Accent}"/>
                                <Setter TargetName="chk" Property="Visibility" Value="Visible"/>
                                <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="box" Property="BorderBrush" Value="{StaticResource AccentHover}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== SLIDER ===== -->
        <Style TargetType="Slider">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Slider">
                        <Grid>
                            <Track x:Name="PART_Track">
                                <Track.DecreaseRepeatButton>
                                    <RepeatButton Command="Slider.DecreaseLarge">
                                        <RepeatButton.Template>
                                            <ControlTemplate TargetType="RepeatButton">
                                                <Border Height="4" Background="{StaticResource Accent}" CornerRadius="2"/>
                                            </ControlTemplate>
                                        </RepeatButton.Template>
                                    </RepeatButton>
                                </Track.DecreaseRepeatButton>
                                <Track.IncreaseRepeatButton>
                                    <RepeatButton Command="Slider.IncreaseLarge">
                                        <RepeatButton.Template>
                                            <ControlTemplate TargetType="RepeatButton">
                                                <Border Height="4" Background="{StaticResource Border2}" CornerRadius="2"/>
                                            </ControlTemplate>
                                        </RepeatButton.Template>
                                    </RepeatButton>
                                </Track.IncreaseRepeatButton>
                                <Track.Thumb>
                                    <Thumb>
                                        <Thumb.Template>
                                            <ControlTemplate TargetType="Thumb">
                                                <Ellipse Width="16" Height="16" Fill="{StaticResource AccentHover}"/>
                                            </ControlTemplate>
                                        </Thumb.Template>
                                    </Thumb>
                                </Track.Thumb>
                            </Track>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== PROGRESS BAR ===== -->
        <Style TargetType="ProgressBar">
            <Setter Property="Height" Value="6"/>
            <Setter Property="Background" Value="{StaticResource Border1}"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ProgressBar">
                        <Border Background="{TemplateBinding Background}" CornerRadius="3" Height="{TemplateBinding Height}">
                            <Border x:Name="PART_Indicator" HorizontalAlignment="Left" CornerRadius="3">
                                <Border.Background>
                                    <LinearGradientBrush StartPoint="0,0" EndPoint="1,0">
                                        <GradientStop Color="#7C3AED" Offset="0"/>
                                        <GradientStop Color="#A78BFA" Offset="1"/>
                                    </LinearGradientBrush>
                                </Border.Background>
                            </Border>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== LIST BOX ===== -->
        <Style TargetType="ListBox">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="0"/>
        </Style>
        <Style TargetType="ListBoxItem">
            <Setter Property="Padding" Value="0"/>
            <Setter Property="Margin" Value="0,3"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ListBoxItem">
                        <Border x:Name="bd" Background="{TemplateBinding Background}"
                                CornerRadius="10" Padding="14,12"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <ContentPresenter/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="{StaticResource BgCardHover}"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Border2}"/>
                            </Trigger>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#1E1433"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

    </Window.Resources>

    <!-- ROOT GRID -->
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="240"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <!-- ====================================================
             SIDEBAR
             ==================================================== -->
        <Border Grid.Column="0" Background="{StaticResource BgSurface}"
                BorderBrush="{StaticResource Border1}" BorderThickness="0,0,1,0">
            <DockPanel>

                <!-- Logo -->
                <StackPanel DockPanel.Dock="Top" Orientation="Horizontal" Margin="20,24,20,28">
                    <Border Width="44" Height="44" CornerRadius="12">
                        <Border.Background>
                            <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                <GradientStop Color="#7C3AED" Offset="0"/>
                                <GradientStop Color="#A78BFA" Offset="1"/>
                            </LinearGradientBrush>
                        </Border.Background>
                        <TextBlock Text="CC" FontSize="18" FontWeight="Bold" Foreground="White"
                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                    <StackPanel Margin="14,0,0,0" VerticalAlignment="Center">
                        <TextBlock Text="CC Remover" Foreground="{StaticResource TextPrimary}"
                                   FontSize="16" FontWeight="SemiBold"/>
                        <TextBlock Text="v2.0 by Mizzery" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                    </StackPanel>
                </StackPanel>

                <!-- Nav Label -->
                <TextBlock DockPanel.Dock="Top" Text="NAVIGATION"
                           Foreground="{StaticResource TextMuted}" FontSize="10" FontWeight="SemiBold"
                           Margin="26,0,0,8"/>

                <!-- Nav Buttons -->
                <StackPanel DockPanel.Dock="Top">
                    <Button x:Name="NavHome"     Style="{StaticResource NavBtn}" Content="  🏠  Home"     Tag="active"/>
                    <Button x:Name="NavScan"     Style="{StaticResource NavBtn}" Content="  🔍  Scan Files"/>
                    <Button x:Name="NavBackups"  Style="{StaticResource NavBtn}" Content="  📦  Backups"/>
                    <Button x:Name="NavSettings" Style="{StaticResource NavBtn}" Content="  ⚙️  Settings"/>
                    <Button x:Name="NavAbout"    Style="{StaticResource NavBtn}" Content="  ℹ️  About"/>
                </StackPanel>

                <!-- Bottom Stats Box -->
                <StackPanel DockPanel.Dock="Bottom" Margin="14,0,14,20">
                    <Border Background="{StaticResource BgCard}" CornerRadius="12" Padding="14,14">
                        <StackPanel>
                            <TextBlock Text="SESSION STATS" Foreground="{StaticResource TextMuted}"
                                       FontSize="10" FontWeight="SemiBold" Margin="0,0,0,10"/>
                            <Grid Margin="0,0,0,6">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <TextBlock Text="Files scanned" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                <TextBlock x:Name="SBFiles" Grid.Column="1" Text="0" Foreground="{StaticResource AccentHover}" FontSize="12" FontWeight="SemiBold"/>
                            </Grid>
                            <Grid Margin="0,0,0,6">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <TextBlock Text="Comments out" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                <TextBlock x:Name="SBComments" Grid.Column="1" Text="0" Foreground="{StaticResource Success}" FontSize="12" FontWeight="SemiBold"/>
                            </Grid>
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <TextBlock Text="Size saved" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                <TextBlock x:Name="SBSize" Grid.Column="1" Text="0 KB" Foreground="{StaticResource TextSub}" FontSize="12"/>
                            </Grid>
                        </StackPanel>
                    </Border>
                </StackPanel>

            </DockPanel>
        </Border>

        <!-- ====================================================
             MAIN CONTENT AREA
             ==================================================== -->
        <Grid Grid.Column="1" Background="{StaticResource BgBase}">

            <!-- Toast Notification -->
            <Border x:Name="ToastPanel"
                    HorizontalAlignment="Right" VerticalAlignment="Top"
                    Margin="0,20,24,0" Padding="18,12" CornerRadius="10"
                    Background="#1E1433" BorderBrush="{StaticResource Accent}" BorderThickness="1"
                    Visibility="Collapsed" Panel.ZIndex="99" MaxWidth="380"
                <StackPanel Orientation="Horizontal">
                    <TextBlock x:Name="ToastIcon" FontSize="16" VerticalAlignment="Center" Margin="0,0,10,0"/>
                    <TextBlock x:Name="ToastText" Foreground="{StaticResource TextPrimary}" FontSize="13"
                               TextWrapping="Wrap" VerticalAlignment="Center"/>
                </StackPanel>
            </Border>

            <!-- ============ PAGE: HOME ============ -->
            <ScrollViewer x:Name="PageHome" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="36,32,36,36">

                    <TextBlock Text="Welcome back" Foreground="{StaticResource TextSub}" FontSize="14"/>
                    <TextBlock Text="Dashboard" Foreground="{StaticResource TextPrimary}" FontSize="32" FontWeight="Bold" Margin="0,2,0,28"/>

                    <!-- Stat Cards Row -->
                    <Grid Margin="0,0,0,28">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="16"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="16"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <!-- Card 1 -->
                        <Border Grid.Column="0" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,20"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <StackPanel>
                                <Border Width="38" Height="38" CornerRadius="10" HorizontalAlignment="Left" Margin="0,0,0,14">
                                    <Border.Background><LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                        <GradientStop Color="#7C3AED" Offset="0"/>
                                        <GradientStop Color="#A78BFA" Offset="1"/>
                                    </LinearGradientBrush></Border.Background>
                                    <TextBlock Text="📁" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                                <TextBlock x:Name="HomeFilesVal" Text="0" Foreground="{StaticResource TextPrimary}" FontSize="30" FontWeight="Bold"/>
                                <TextBlock Text="Files Processed" Foreground="{StaticResource TextSub}" FontSize="13" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Card 2 -->
                        <Border Grid.Column="2" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,20"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <StackPanel>
                                <Border Width="38" Height="38" CornerRadius="10" HorizontalAlignment="Left" Margin="0,0,0,14">
                                    <Border.Background><LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                        <GradientStop Color="#059669" Offset="0"/>
                                        <GradientStop Color="#34D399" Offset="1"/>
                                    </LinearGradientBrush></Border.Background>
                                    <TextBlock Text="✂️" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                                <TextBlock x:Name="HomeCommentsVal" Text="0" Foreground="{StaticResource TextPrimary}" FontSize="30" FontWeight="Bold"/>
                                <TextBlock Text="Comments Removed" Foreground="{StaticResource TextSub}" FontSize="13" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Card 3 -->
                        <Border Grid.Column="4" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,20"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <StackPanel>
                                <Border Width="38" Height="38" CornerRadius="10" HorizontalAlignment="Left" Margin="0,0,0,14">
                                    <Border.Background><LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                        <GradientStop Color="#D97706" Offset="0"/>
                                        <GradientStop Color="#FCD34D" Offset="1"/>
                                    </LinearGradientBrush></Border.Background>
                                    <TextBlock Text="💾" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                                <TextBlock x:Name="HomeSizeVal" Text="0 KB" Foreground="{StaticResource TextPrimary}" FontSize="30" FontWeight="Bold"/>
                                <TextBlock Text="Storage Saved" Foreground="{StaticResource TextSub}" FontSize="13" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>
                    </Grid>

                    <!-- Recent Activity + Quick Actions -->
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="20"/>
                            <ColumnDefinition Width="300"/>
                        </Grid.ColumnDefinitions>

                        <!-- Recent Activity -->
                        <Border Grid.Column="0" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,20"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,16">
                                    <TextBlock Text="Recent Activity" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold"/>
                                </StackPanel>
                                <ListBox x:Name="RecentList" Background="Transparent" BorderThickness="0"/>
                                <TextBlock x:Name="RecentEmpty" Text="No scans yet. Head to Scan Files to get started."
                                           Foreground="{StaticResource TextMuted}" FontSize="13"
                                           HorizontalAlignment="Center" Margin="0,20,0,0" TextWrapping="Wrap"/>
                            </StackPanel>
                        </Border>

                        <!-- Quick Actions -->
                        <Border Grid.Column="2" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,20"
                                BorderBrush="{StaticResource Border1}" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="Quick Actions" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold" Margin="0,0,0,16"/>

                                <Button x:Name="QAScanBtn" Content="🚀  Start New Scan" Style="{StaticResource AccentBtn}"
                                        HorizontalAlignment="Stretch" Height="46" FontSize="14" Margin="0,0,0,10"/>
                                <Button x:Name="QABackupBtn" Content="📦  View Backups" Style="{StaticResource GhostBtn}"
                                        HorizontalAlignment="Stretch" Height="42" Margin="0,0,0,8"/>
                                <Button x:Name="QASettingsBtn" Content="⚙️  Settings" Style="{StaticResource GhostBtn}"
                                        HorizontalAlignment="Stretch" Height="42"/>

                                <Separator Background="{StaticResource Border1}" Margin="0,20,0,16" Height="1"/>

                                <TextBlock Text="Last Scan" Foreground="{StaticResource TextMuted}" FontSize="11" FontWeight="SemiBold" Margin="0,0,0,8"/>
                                <TextBlock x:Name="HomeLastFolder" Text="No folder scanned yet" Foreground="{StaticResource TextSub}" FontSize="12" TextWrapping="Wrap"/>
                                <TextBlock x:Name="HomeLastTime" Text="" Foreground="{StaticResource TextMuted}" FontSize="11" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>
                    </Grid>
                </StackPanel>
            </ScrollViewer>

            <!-- ============ PAGE: SCAN ============ -->
            <Grid x:Name="PageScan" Visibility="Collapsed" Margin="36,32,36,0">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <!-- Page Header -->
                <StackPanel Grid.Row="0" Margin="0,0,0,24">
                    <TextBlock Text="Scan &amp; Remove" Foreground="{StaticResource TextPrimary}" FontSize="32" FontWeight="Bold"/>
                    <TextBlock Text="Strip comments from source files safely • Automatic backups included"
                               Foreground="{StaticResource TextSub}" FontSize="14"/>
                </StackPanel>

                <!-- Folder + Options Row -->
                <Border Grid.Row="1" Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,20"
                        BorderBrush="{StaticResource Border1}" BorderThickness="1" Margin="0,0,0,20">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>

                        <!-- Folder Row -->
                        <Grid Grid.Row="0" Margin="0,0,0,18">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <TextBox x:Name="FolderBox" Height="44" FontSize="13" VerticalContentAlignment="Center"
                                     Background="{StaticResource BgInput}"/>
                            <Button x:Name="BrowseBtn" Grid.Column="1" Content="Browse Folder"
                                    Style="{StaticResource AccentBtn}" Height="44" Margin="12,0,0,0" Padding="18,0"/>
                        </Grid>

                        <!-- File Type Checkboxes -->
                        <StackPanel Grid.Row="1" Margin="0,0,0,16">
                            <TextBlock Text="FILE TYPES" Foreground="{StaticResource TextMuted}" FontSize="10" FontWeight="SemiBold"
                                       Margin="0,0,0,10"/>
                            <WrapPanel>
                                <CheckBox x:Name="ChkJS"  Content="JS / TS" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkJSX" Content="JSX / TSX" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkCSS" Content="CSS / SCSS" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkHTML" Content="HTML / HTM" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkJava" Content="Java" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkCS" Content="C#" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkCpp" Content="C / C++" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkPHP" Content="PHP" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkPy" Content="Python" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkGo" Content="Go" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkRust" Content="Rust" IsChecked="True" Margin="0,0,20,6"/>
                                <CheckBox x:Name="ChkSwift" Content="Swift" IsChecked="True" Margin="0,0,0,6"/>
                            </WrapPanel>
                        </StackPanel>

                        <!-- Action Buttons -->
                        <WrapPanel Grid.Row="2">
                            <Button x:Name="RunBtn" Content="🚀  Remove Comments" Style="{StaticResource AccentBtn}"
                                    Height="48" Width="220" FontSize="15" FontWeight="SemiBold"/>
                            <Button x:Name="PreviewBtn" Content="👁  Preview Changes" Style="{StaticResource GhostBtn}"
                                    Height="48" Width="180" Margin="12,0,0,0"/>
                            <Button x:Name="ClearLogBtn" Content="Clear Log" Style="{StaticResource GhostBtn}"
                                    Height="48" Margin="12,0,0,0"/>
                        </WrapPanel>
                    </Grid>
                </Border>

                <!-- Log + Progress Panel -->
                <Grid Grid.Row="2">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="3*"/>
                        <ColumnDefinition Width="18"/>
                        <ColumnDefinition Width="2*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Log -->
                    <Border Grid.Column="0" Background="{StaticResource BgSurface}" CornerRadius="16"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <DockPanel Margin="6">
                            <StackPanel DockPanel.Dock="Top" Orientation="Horizontal" Margin="16,12,16,8">
                                <TextBlock Text="Operation Log" Foreground="{StaticResource TextPrimary}"
                                           FontSize="14" FontWeight="SemiBold"/>
                                <Border x:Name="ScanningBadge" Background="#1E1433" CornerRadius="6" Padding="8,3"
                                        Margin="12,0,0,0" Visibility="Collapsed">
                                    <TextBlock Text="● SCANNING" Foreground="{StaticResource Accent}"
                                               FontSize="11" FontWeight="SemiBold"/>
                                </Border>
                            </StackPanel>
                            <ScrollViewer VerticalScrollBarVisibility="Auto">
                                <RichTextBox x:Name="LogBox" Background="Transparent" BorderThickness="0"
                                             Padding="16,6,16,16" FontFamily="Cascadia Code, Consolas"
                                             FontSize="12" Foreground="#C4C0E0" IsReadOnly="True"/>
                            </ScrollViewer>
                        </DockPanel>
                    </Border>

                    <!-- Stats Panel -->
                    <Border Grid.Column="2" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,22"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="LIVE PROGRESS" Foreground="{StaticResource Accent}"
                                       FontSize="11" FontWeight="SemiBold" Margin="0,0,0,20"/>

                            <TextBlock x:Name="FilesFoundTxt" Text="Files found: 0"
                                       Foreground="{StaticResource TextPrimary}" FontSize="15" FontWeight="Medium"/>

                            <ProgressBar x:Name="ProgressBar" Margin="0,12,0,4"/>

                            <Grid Margin="0,0,0,24">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <TextBlock x:Name="FilesProcessedTxt" Text="0 / 0 files"
                                           Foreground="{StaticResource TextSub}" FontSize="12"/>
                                <TextBlock x:Name="ProgressPctTxt" Grid.Column="1"
                                           Text="0%" Foreground="{StaticResource Accent}" FontSize="12" FontWeight="Bold"/>
                            </Grid>

                            <!-- Metric Cards -->
                            <Border Background="{StaticResource BgSurface}" CornerRadius="12" Padding="16" Margin="0,0,0,10">
                                <StackPanel>
                                    <TextBlock Text="Comments removed" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                    <TextBlock x:Name="CommentsRemovedTxt" Text="0"
                                               Foreground="{StaticResource Success}" FontSize="26" FontWeight="Bold" Margin="0,4,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Background="{StaticResource BgSurface}" CornerRadius="12" Padding="16" Margin="0,0,0,10">
                                <StackPanel>
                                    <TextBlock Text="Space freed" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                    <TextBlock x:Name="SizeSavedTxt" Text="0 KB"
                                               Foreground="{StaticResource TextPrimary}" FontSize="22" FontWeight="Bold" Margin="0,4,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Background="{StaticResource BgSurface}" CornerRadius="12" Padding="16">
                                <StackPanel>
                                    <TextBlock Text="Elapsed time" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                    <TextBlock x:Name="ElapsedTxt" Text="0s"
                                               Foreground="{StaticResource TextPrimary}" FontSize="22" FontWeight="Bold" Margin="0,4,0,0"/>
                                </StackPanel>
                            </Border>

                            <TextBlock Text="💡 Drag &amp; drop a folder to begin"
                                       Foreground="{StaticResource TextMuted}" FontSize="12"
                                       HorizontalAlignment="Center" Margin="0,24,0,0" TextWrapping="Wrap"/>
                        </StackPanel>
                    </Border>
                </Grid>

                <!-- Supported types footer -->
                <TextBlock Grid.Row="3"
                           Text="Supported: JS  TS  JSX  TSX  CSS  HTML  Java  C#  C/C++  PHP  Python  Go  Rust  Swift"
                           Foreground="{StaticResource TextMuted}" FontSize="11"
                           HorizontalAlignment="Center" Margin="0,14,0,18"/>
            </Grid>

            <!-- ============ PAGE: BACKUPS ============ -->
            <Grid x:Name="PageBackups" Visibility="Collapsed" Margin="36,32,36,0">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <StackPanel Grid.Row="0" Margin="0,0,0,24">
                    <TextBlock Text="Backups" Foreground="{StaticResource TextPrimary}" FontSize="32" FontWeight="Bold"/>
                    <TextBlock Text="Browse, restore, or delete backup snapshots"
                               Foreground="{StaticResource TextSub}" FontSize="14"/>
                </StackPanel>

                <Grid Grid.Row="1">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="18"/>
                        <ColumnDefinition Width="320"/>
                    </Grid.ColumnDefinitions>

                    <!-- Backup List -->
                    <Border Grid.Column="0" Background="{StaticResource BgCard}" CornerRadius="16" Padding="20"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <DockPanel>
                            <StackPanel DockPanel.Dock="Top" Orientation="Horizontal" Margin="0,0,0,16">
                                <TextBlock Text="Backup Snapshots" Foreground="{StaticResource TextPrimary}"
                                           FontSize="15" FontWeight="SemiBold" VerticalAlignment="Center"/>
                                <Button x:Name="RefreshBackupsBtn" Content="↻ Refresh" Style="{StaticResource GhostBtn}"
                                        Margin="16,0,0,0" Padding="12,6" FontSize="12"/>
                            </StackPanel>
                            <ScrollViewer DockPanel.Dock="Top" VerticalScrollBarVisibility="Auto">
                                <ListBox x:Name="BackupList"/>
                            </ScrollViewer>
                            <TextBlock x:Name="BackupEmpty" DockPanel.Dock="Top"
                                       Text="No backups found. Run a scan to create backup snapshots automatically."
                                       Foreground="{StaticResource TextMuted}" FontSize="13"
                                       HorizontalAlignment="Center" Margin="0,30,0,0" TextWrapping="Wrap"/>
                        </DockPanel>
                    </Border>

                    <!-- Backup Actions -->
                    <Border Grid.Column="2" Background="{StaticResource BgCard}" CornerRadius="16" Padding="22,22"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="ACTIONS" Foreground="{StaticResource TextMuted}"
                                       FontSize="10" FontWeight="SemiBold" Margin="0,0,0,16"/>

                            <Button x:Name="RestoreProjectBtn" Content="🔄  Restore Entire Project"
                                    Style="{StaticResource AccentBtn}" HorizontalAlignment="Stretch"
                                    Height="44" Margin="0,0,0,10"/>
                            <Button x:Name="OpenBackupFolderBtn" Content="📂  Open in Explorer"
                                    Style="{StaticResource GhostBtn}" HorizontalAlignment="Stretch"
                                    Height="40" Margin="0,0,0,10"/>
                            <Button x:Name="DeleteBackupBtn" Content="🗑  Delete This Backup"
                                    Style="{StaticResource DangerBtn}" HorizontalAlignment="Stretch" Height="40"/>

                            <Separator Background="{StaticResource Border1}" Margin="0,24,0,20" Height="1"/>

                            <TextBlock Text="SELECTED BACKUP" Foreground="{StaticResource TextMuted}"
                                       FontSize="10" FontWeight="SemiBold" Margin="0,0,0,12"/>
                            <TextBlock x:Name="BackupDetailName" Text="—" Foreground="{StaticResource TextPrimary}"
                                       FontSize="14" FontWeight="Medium" TextWrapping="Wrap"/>
                            <TextBlock x:Name="BackupDetailDate" Text="" Foreground="{StaticResource TextSub}"
                                       FontSize="12" Margin="0,6,0,0"/>
                            <TextBlock x:Name="BackupDetailFiles" Text="" Foreground="{StaticResource TextSub}"
                                       FontSize="12" Margin="0,4,0,0"/>
                        </StackPanel>
                    </Border>
                </Grid>
            </Grid>

            <!-- ============ PAGE: SETTINGS ============ -->
            <ScrollViewer x:Name="PageSettings" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="36,32,36,36">
                    <TextBlock Text="Settings" Foreground="{StaticResource TextPrimary}" FontSize="32" FontWeight="Bold"/>
                    <TextBlock Text="Customize how CC Remover behaves"
                               Foreground="{StaticResource TextSub}" FontSize="14" Margin="0,0,0,32"/>

                    <!-- Backup Settings -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,22" Margin="0,0,0,16"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="BACKUP" Foreground="{StaticResource TextMuted}" FontSize="10"
                                       FontWeight="SemiBold" Margin="0,0,0,16"/>
                            <Grid Margin="0,0,0,16">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Auto-backup before removal" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Always create a backup before modifying files" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <CheckBox x:Name="SetAutoBackup" Grid.Column="1" IsChecked="True" VerticalAlignment="Center"/>
                            </Grid>
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Backup retention (days)" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Backups older than this will be listed for cleanup" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
                                    <TextBlock x:Name="RetentionVal" Text="30" Foreground="{StaticResource AccentHover}"
                                               FontSize="16" FontWeight="Bold" VerticalAlignment="Center" Margin="0,0,12,0"/>
                                    <Slider x:Name="RetentionSlider" Width="140" Minimum="1" Maximum="90" Value="30"
                                            VerticalAlignment="Center"/>
                                </StackPanel>
                            </Grid>
                        </StackPanel>
                    </Border>

                    <!-- Removal Settings -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,22" Margin="0,0,0,16"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="REMOVAL BEHAVIOR" Foreground="{StaticResource TextMuted}" FontSize="10"
                                       FontWeight="SemiBold" Margin="0,0,0,16"/>
                            <Grid Margin="0,0,0,16">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Remove inline comments only" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Only strip // and # style comments, preserve block comments" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <CheckBox x:Name="SetInlineOnly" Grid.Column="1" IsChecked="False" VerticalAlignment="Center"/>
                            </Grid>
                            <Grid Margin="0,0,0,16">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Preserve empty lines" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Keep blank lines where comments were removed" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <CheckBox x:Name="SetPreserveLines" Grid.Column="1" IsChecked="True" VerticalAlignment="Center"/>
                            </Grid>
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Skip node_modules and .git folders" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Recommended: always skip dependency directories" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <CheckBox x:Name="SetSkipDeps" Grid.Column="1" IsChecked="True" VerticalAlignment="Center"/>
                            </Grid>
                        </StackPanel>
                    </Border>

                    <!-- UI Settings -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,22"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="INTERFACE" Foreground="{StaticResource TextMuted}" FontSize="10"
                                       FontWeight="SemiBold" Margin="0,0,0,16"/>
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock Text="Confirm before removing" Foreground="{StaticResource TextPrimary}" FontSize="14"/>
                                    <TextBlock Text="Show a confirmation dialog before making changes" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,2,0,0"/>
                                </StackPanel>
                                <CheckBox x:Name="SetConfirm" Grid.Column="1" IsChecked="True" VerticalAlignment="Center"/>
                            </Grid>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </ScrollViewer>

            <!-- ============ PAGE: ABOUT ============ -->
            <ScrollViewer x:Name="PageAbout" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="36,32,200,36">
                    <TextBlock Text="About" Foreground="{StaticResource TextPrimary}" FontSize="32" FontWeight="Bold"/>
                    <TextBlock Text="CC Remover v2.0" Foreground="{StaticResource TextSub}" FontSize="14" Margin="0,0,0,32"/>

                    <!-- App Info Card -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="28,26" Margin="0,0,0,16"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <StackPanel Orientation="Horizontal" Margin="0,0,0,24">
                                <Border Width="56" Height="56" CornerRadius="14">
                                    <Border.Background>
                                        <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                            <GradientStop Color="#7C3AED" Offset="0"/>
                                            <GradientStop Color="#A78BFA" Offset="1"/>
                                        </LinearGradientBrush>
                                    </Border.Background>
                                    <TextBlock Text="CC" FontSize="24" FontWeight="Bold" Foreground="White"
                                               HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                                <StackPanel Margin="18,0,0,0" VerticalAlignment="Center">
                                    <TextBlock Text="CC Remover" Foreground="{StaticResource TextPrimary}" FontSize="22" FontWeight="Bold"/>
                                    <TextBlock Text="Version 2.0  •  By Mizzery" Foreground="{StaticResource TextSub}" FontSize="13"/>
                                </StackPanel>
                            </StackPanel>
                            <TextBlock Text="CC Remover is a developer utility that strips comments from source code files in bulk. It supports 15+ languages, creates automatic backups before every operation, and provides a clean Fluent-design interface." Foreground="{StaticResource TextSub}" FontSize="14" TextWrapping="Wrap" LineHeight="22"/>
                        </StackPanel>
                    </Border>

                    <!-- Features Card -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,22" Margin="0,0,0,16"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="WHAT'S NEW IN V2.0" Foreground="{StaticResource TextMuted}" FontSize="10"
                                       FontWeight="SemiBold" Margin="0,0,0,16"/>
                            <StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Multi-page navigation with Home, Scan, Backups, Settings, About"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Backup manager with browse, restore, and delete capabilities"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Fluent design with purple accent, 16-20px card radius, session stats"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Per-language file type checkboxes on scan page"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Toast notification system for all major events"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                                <StackPanel Orientation="Horizontal">
                                    <Border Background="#1E1433" Width="24" Height="24" CornerRadius="6" Margin="0,0,12,0">
                                        <TextBlock Text="✓" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"
                                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <TextBlock Text="Settings page: backup toggle, retention days, behavior options"
                                               Foreground="{StaticResource TextSub}" FontSize="13" VerticalAlignment="Center"/>
                                </StackPanel>
                            </StackPanel>
                        </StackPanel>
                    </Border>

                    <!-- Supported Languages -->
                    <Border Background="{StaticResource BgCard}" CornerRadius="16" Padding="24,22"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="SUPPORTED LANGUAGES" Foreground="{StaticResource TextMuted}" FontSize="10"
                                       FontWeight="SemiBold" Margin="0,0,0,14"/>
                            <WrapPanel>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="JavaScript" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="TypeScript" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="JSX / TSX" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="CSS / SCSS" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="HTML" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="Java" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="C#" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="C / C++" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="PHP" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="Python" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="Go" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="Rust" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                                <Border Background="#1A1A26" CornerRadius="6" Padding="10,5" Margin="0,0,8,8">
                                    <TextBlock Text="Swift" Foreground="{StaticResource AccentHover}" FontSize="12"/>
                                </Border>
                            </WrapPanel>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </ScrollViewer>

        </Grid>
    </Grid>
</Window>
"@

# ======================================================================
# LOAD WINDOW
# ======================================================================
$reader = New-Object System.Xml.XmlNodeReader $xaml
$Window = [Windows.Markup.XamlReader]::Load($reader)

# ---- Find all controls ----
$NavHome         = $Window.FindName("NavHome")
$NavScan         = $Window.FindName("NavScan")
$NavBackups      = $Window.FindName("NavBackups")
$NavSettings     = $Window.FindName("NavSettings")
$NavAbout        = $Window.FindName("NavAbout")

$PageHome        = $Window.FindName("PageHome")
$PageScan        = $Window.FindName("PageScan")
$PageBackups     = $Window.FindName("PageBackups")
$PageSettings    = $Window.FindName("PageSettings")
$PageAbout       = $Window.FindName("PageAbout")

$FolderBox       = $Window.FindName("FolderBox")
$BrowseBtn       = $Window.FindName("BrowseBtn")
$RunBtn          = $Window.FindName("RunBtn")
$PreviewBtn      = $Window.FindName("PreviewBtn")
$ClearLogBtn     = $Window.FindName("ClearLogBtn")
$LogBox          = $Window.FindName("LogBox")
$ProgressBar     = $Window.FindName("ProgressBar")
$FilesFoundTxt   = $Window.FindName("FilesFoundTxt")
$FilesProcessedTxt = $Window.FindName("FilesProcessedTxt")
$ProgressPctTxt  = $Window.FindName("ProgressPctTxt")
$CommentsRemovedTxt = $Window.FindName("CommentsRemovedTxt")
$SizeSavedTxt    = $Window.FindName("SizeSavedTxt")
$ElapsedTxt      = $Window.FindName("ElapsedTxt")
$ScanningBadge   = $Window.FindName("ScanningBadge")

$SBFiles         = $Window.FindName("SBFiles")
$SBComments      = $Window.FindName("SBComments")
$SBSize          = $Window.FindName("SBSize")

$HomeFilesVal    = $Window.FindName("HomeFilesVal")
$HomeCommentsVal = $Window.FindName("HomeCommentsVal")
$HomeSizeVal     = $Window.FindName("HomeSizeVal")
$HomeLastFolder  = $Window.FindName("HomeLastFolder")
$HomeLastTime    = $Window.FindName("HomeLastTime")
$RecentList      = $Window.FindName("RecentList")
$RecentEmpty     = $Window.FindName("RecentEmpty")

$BackupList      = $Window.FindName("BackupList")
$BackupEmpty     = $Window.FindName("BackupEmpty")
$BackupDetailName = $Window.FindName("BackupDetailName")
$BackupDetailDate = $Window.FindName("BackupDetailDate")
$BackupDetailFiles = $Window.FindName("BackupDetailFiles")
$RefreshBackupsBtn = $Window.FindName("RefreshBackupsBtn")
$RestoreProjectBtn = $Window.FindName("RestoreProjectBtn")
$OpenBackupFolderBtn = $Window.FindName("OpenBackupFolderBtn")
$DeleteBackupBtn = $Window.FindName("DeleteBackupBtn")

$QAScanBtn       = $Window.FindName("QAScanBtn")
$QABackupBtn     = $Window.FindName("QABackupBtn")
$QASettingsBtn   = $Window.FindName("QASettingsBtn")

$RetentionSlider = $Window.FindName("RetentionSlider")
$RetentionVal    = $Window.FindName("RetentionVal")
$SetAutoBackup   = $Window.FindName("SetAutoBackup")
$SetInlineOnly   = $Window.FindName("SetInlineOnly")
$SetPreserveLines = $Window.FindName("SetPreserveLines")
$SetSkipDeps     = $Window.FindName("SetSkipDeps")
$SetConfirm      = $Window.FindName("SetConfirm")

$ToastPanel      = $Window.FindName("ToastPanel")
$ToastIcon       = $Window.FindName("ToastIcon")
$ToastText       = $Window.FindName("ToastText")

# ---- Checkboxes for file types ----
$ChkJS    = $Window.FindName("ChkJS")
$ChkJSX   = $Window.FindName("ChkJSX")
$ChkCSS   = $Window.FindName("ChkCSS")
$ChkHTML  = $Window.FindName("ChkHTML")
$ChkJava  = $Window.FindName("ChkJava")
$ChkCS    = $Window.FindName("ChkCS")
$ChkCpp   = $Window.FindName("ChkCpp")
$ChkPHP   = $Window.FindName("ChkPHP")
$ChkPy    = $Window.FindName("ChkPy")
$ChkGo    = $Window.FindName("ChkGo")
$ChkRust  = $Window.FindName("ChkRust")
$ChkSwift = $Window.FindName("ChkSwift")

# ======================================================================
# SESSION STATE
# ======================================================================
$script:TotalFiles    = 0
$script:TotalComments = 0
$script:TotalSize     = 0
$script:RecentScans   = [System.Collections.Generic.List[hashtable]]::new()
$script:LastFolder    = ""

# ======================================================================
# HELPERS
# ======================================================================
function Show-Toast {
    param([string]$Message, [string]$Icon = "✅", [int]$DurationMs = 3500)
    $ToastIcon.Text = $Icon
    $ToastText.Text = $Message
    $ToastPanel.Visibility = "Visible"
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMilliseconds($DurationMs)
    $timer.Add_Tick({
        $ToastPanel.Visibility = "Collapsed"
        $timer.Stop()
    })
    $timer.Start()
}

function Switch-Page {
    param([string]$Page)
    $PageHome.Visibility     = "Collapsed"
    $PageScan.Visibility     = "Collapsed"
    $PageBackups.Visibility  = "Collapsed"
    $PageSettings.Visibility = "Collapsed"
    $PageAbout.Visibility    = "Collapsed"

    $NavHome.Tag     = $null
    $NavScan.Tag     = $null
    $NavBackups.Tag  = $null
    $NavSettings.Tag = $null
    $NavAbout.Tag    = $null

    switch ($Page) {
        "Home"     { $PageHome.Visibility     = "Visible"; $NavHome.Tag     = "active" }
        "Scan"     { $PageScan.Visibility     = "Visible"; $NavScan.Tag     = "active" }
        "Backups"  { $PageBackups.Visibility  = "Visible"; $NavBackups.Tag  = "active"; Refresh-Backups }
        "Settings" { $PageSettings.Visibility = "Visible"; $NavSettings.Tag = "active" }
        "About"    { $PageAbout.Visibility    = "Visible"; $NavAbout.Tag    = "active" }
    }
}

function Update-HomeStats {
    $HomeFilesVal.Text    = "$($script:TotalFiles)"
    $HomeCommentsVal.Text = "$($script:TotalComments)"
    $HomeSizeVal.Text     = "$([Math]::Round($script:TotalSize/1024, 1)) KB"
    $SBFiles.Text         = "$($script:TotalFiles)"
    $SBComments.Text      = "$($script:TotalComments)"
    $SBSize.Text          = "$([Math]::Round($script:TotalSize/1024, 1)) KB"
}

function Refresh-RecentList {
    $RecentList.Items.Clear()
    if ($script:RecentScans.Count -eq 0) {
        $RecentEmpty.Visibility = "Visible"
    } else {
        $RecentEmpty.Visibility = "Collapsed"
        foreach ($scan in ($script:RecentScans | Select-Object -Last 8)) {
            $item = New-Object Windows.Controls.Grid
            $col1 = New-Object Windows.Controls.ColumnDefinition; $col1.Width = [Windows.GridLength]::Star
            $col2 = New-Object Windows.Controls.ColumnDefinition; $col2.Width = [Windows.GridLength]::Auto
            $item.ColumnDefinitions.Add($col1)
            $item.ColumnDefinitions.Add($col2)

            $sp = New-Object Windows.Controls.StackPanel
            $t1 = New-Object Windows.Controls.TextBlock
            $t1.Text = [System.IO.Path]::GetFileName($scan.Folder)
            $t1.Foreground = [Windows.Media.Brushes]::WhiteSmoke
            $t1.FontSize = 13
            $t2 = New-Object Windows.Controls.TextBlock
            $t2.Text = $scan.Folder
            $t2.Foreground = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x9C, 0xA3, 0xAF))
            $t2.FontSize = 11
            $t2.TextTrimming = "CharacterEllipsis"
            $sp.Children.Add($t1)
            $sp.Children.Add($t2)
            [Windows.Controls.Grid]::SetColumn($sp, 0)
            $item.Children.Add($sp)

            $badge = New-Object Windows.Controls.Border
            $badge.CornerRadius = New-Object Windows.CornerRadius(6)
            $badge.Padding = New-Object Windows.Thickness(8,3,8,3)
            $badge.Background = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x1E, 0x14, 0x33))
            $tb = New-Object Windows.Controls.TextBlock
            $tb.Text = "-$($scan.Comments)"
            $tb.Foreground = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x10, 0xB9, 0x81))
            $tb.FontSize = 12
            $tb.FontWeight = [Windows.FontWeights]::SemiBold
            $badge.Child = $tb
            [Windows.Controls.Grid]::SetColumn($badge, 1)
            $item.Children.Add($badge)

            $li = New-Object Windows.Controls.ListBoxItem
            $li.Content = $item
            $RecentList.Items.Add($li)
        }
    }
}

function Refresh-Backups {
    $BackupList.Items.Clear()
    $BackupDetailName.Text = "—"
    $BackupDetailDate.Text = ""
    $BackupDetailFiles.Text = ""

    # Search recently used folders and common backup roots
    $searchRoots = @()
    if (![string]::IsNullOrEmpty($FolderBox.Text) -and (Test-Path $FolderBox.Text)) {
        $searchRoots += $FolderBox.Text
    }
    if (![string]::IsNullOrEmpty($script:LastFolder) -and (Test-Path $script:LastFolder)) {
        $searchRoots += $script:LastFolder
    }

    $backups = @()
    foreach ($root in ($searchRoots | Select-Object -Unique)) {
        $found = Get-ChildItem $root -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -like "CC_Backups_*" }
        foreach ($b in $found) {
            $backups += $b
        }
    }

    if ($backups.Count -eq 0) {
        $BackupEmpty.Visibility = "Visible"
    } else {
        $BackupEmpty.Visibility = "Collapsed"
        foreach ($b in ($backups | Sort-Object LastWriteTime -Descending)) {
            $fileCount = (Get-ChildItem $b.FullName -Recurse -File -ErrorAction SilentlyContinue).Count
            $grid = New-Object Windows.Controls.Grid
            $c1 = New-Object Windows.Controls.ColumnDefinition; $c1.Width = [Windows.GridLength]::Star
            $c2 = New-Object Windows.Controls.ColumnDefinition; $c2.Width = [Windows.GridLength]::Auto
            $grid.ColumnDefinitions.Add($c1)
            $grid.ColumnDefinitions.Add($c2)

            $sp = New-Object Windows.Controls.StackPanel
            $t1 = New-Object Windows.Controls.TextBlock
            $t1.Text = $b.Name
            $t1.Foreground = [Windows.Media.Brushes]::WhiteSmoke
            $t1.FontSize = 13
            $t2 = New-Object Windows.Controls.TextBlock
            $t2.Text = $b.LastWriteTime.ToString("MMM dd, yyyy  HH:mm")
            $t2.Foreground = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x9C, 0xA3, 0xAF))
            $t2.FontSize = 11
            $sp.Children.Add($t1)
            $sp.Children.Add($t2)
            [Windows.Controls.Grid]::SetColumn($sp, 0)
            $grid.Children.Add($sp)

            $badge = New-Object Windows.Controls.Border
            $badge.CornerRadius = New-Object Windows.CornerRadius(6)
            $badge.Padding = New-Object Windows.Thickness(8,3,8,3)
            $badge.Background = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x1A, 0x1A, 0x26))
            $tb = New-Object Windows.Controls.TextBlock
            $tb.Text = "$fileCount files"
            $tb.Foreground = [Windows.Media.SolidColorBrush]([Windows.Media.Color]::FromRgb(0x9C, 0xA3, 0xAF))
            $tb.FontSize = 11
            $badge.Child = $tb
            [Windows.Controls.Grid]::SetColumn($badge, 1)
            $grid.Children.Add($badge)

            $li = New-Object Windows.Controls.ListBoxItem
            $li.Content = $grid
            $li.Tag = $b.FullName
            $BackupList.Items.Add($li)
        }
    }
}

function Get-SelectedBackupPath {
    if ($BackupList.SelectedItem) {
        return $BackupList.SelectedItem.Tag
    }
    return $null
}

function Build-ExtensionPattern {
    $parts = @()
    if ($ChkJS.IsChecked)    { $parts += 'js'; $parts += 'ts' }
    if ($ChkJSX.IsChecked)   { $parts += 'jsx'; $parts += 'tsx' }
    if ($ChkCSS.IsChecked)   { $parts += 'css'; $parts += 'scss' }
    if ($ChkHTML.IsChecked)  { $parts += 'html'; $parts += 'htm' }
    if ($ChkJava.IsChecked)  { $parts += 'java' }
    if ($ChkCS.IsChecked)    { $parts += 'cs' }
    if ($ChkCpp.IsChecked)   { $parts += 'c'; $parts += 'cpp'; $parts += 'h'; $parts += 'hpp' }
    if ($ChkPHP.IsChecked)   { $parts += 'php' }
    if ($ChkPy.IsChecked)    { $parts += 'py' }
    if ($ChkGo.IsChecked)    { $parts += 'go' }
    if ($ChkRust.IsChecked)  { $parts += 'rs' }
    if ($ChkSwift.IsChecked) { $parts += 'swift' }
    if ($parts.Count -eq 0) { return $null }
    return '\\.(' + ($parts -join '|') + ')$'
}

function Append-Log {
    param([string]$Text, [string]$Color = "#C4C0E0")
    $para = New-Object Windows.Documents.Paragraph
    $run  = New-Object Windows.Documents.Run
    $run.Text = $Text
    $run.Foreground = [Windows.Media.SolidColorBrush]([Windows.Media.ColorConverter]::ConvertFromString($Color))
    $para.Inlines.Add($run)
    $para.Margin = New-Object Windows.Thickness(0,1,0,1)
    $LogBox.Document.Blocks.Add($para)
    $LogBox.ScrollToEnd()
}

# ======================================================================
# NAVIGATION
# ======================================================================
$NavHome.Add_Click(     { Switch-Page "Home" })
$NavScan.Add_Click(     { Switch-Page "Scan" })
$NavBackups.Add_Click(  { Switch-Page "Backups" })
$NavSettings.Add_Click( { Switch-Page "Settings" })
$NavAbout.Add_Click(    { Switch-Page "About" })

$QAScanBtn.Add_Click(     { Switch-Page "Scan" })
$QABackupBtn.Add_Click(   { Switch-Page "Backups" })
$QASettingsBtn.Add_Click( { Switch-Page "Settings" })

# ======================================================================
# DRAG & DROP
# ======================================================================
$Window.AllowDrop = $true
$Window.Add_DragOver({ $_.Effects = [Windows.DragDropEffects]::Copy; $_.Handled = $true })
$Window.Add_Drop({
    $items = $_.Data.GetData([Windows.DataFormats]::FileDrop)
    if ($items) {
        $first = $items[0]
        $path = if (Test-Path $first -PathType Container) { $first } else { Split-Path $first -Parent }
        $FolderBox.Text = $path
        Switch-Page "Scan"
        Show-Toast "Folder loaded via drag & drop" "📁"
    }
})

# ======================================================================
# BROWSE
# ======================================================================
$BrowseBtn.Add_Click({
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.BrowseForFolder(0, "Select Project Folder", 0, 0)
    if ($folder) {
        $FolderBox.Text = $folder.Self.Path
        Show-Toast "Folder selected: $([System.IO.Path]::GetFileName($folder.Self.Path))" "📁"
    }
})

# ======================================================================
# CLEAR LOG
# ======================================================================
$ClearLogBtn.Add_Click({
    $LogBox.Document.Blocks.Clear()
    Show-Toast "Log cleared" "🧹"
})

# ======================================================================
# SETTINGS: Retention Slider
# ======================================================================
$RetentionSlider.Add_ValueChanged({
    $RetentionVal.Text = [int]$RetentionSlider.Value
})

# ======================================================================
# BACKUP LIST SELECTION
# ======================================================================
$BackupList.Add_SelectionChanged({
    $path = Get-SelectedBackupPath
    if ($path -and (Test-Path $path)) {
        $info = Get-Item $path
        $fileCount = (Get-ChildItem $path -Recurse -File -ErrorAction SilentlyContinue).Count
        $BackupDetailName.Text  = $info.Name
        $BackupDetailDate.Text  = "Created: " + $info.LastWriteTime.ToString("MMMM dd, yyyy  HH:mm:ss")
        $BackupDetailFiles.Text = "$fileCount backed-up files"
    }
})

$RefreshBackupsBtn.Add_Click({ Refresh-Backups; Show-Toast "Backup list refreshed" "↻" })

# ======================================================================
# OPEN BACKUP FOLDER
# ======================================================================
$OpenBackupFolderBtn.Add_Click({
    $path = Get-SelectedBackupPath
    if ($path -and (Test-Path $path)) {
        Start-Process explorer.exe $path
    } else {
        Show-Toast "Select a backup to open" "⚠️"
    }
})

# ======================================================================
# DELETE BACKUP
# ======================================================================
$DeleteBackupBtn.Add_Click({
    $path = Get-SelectedBackupPath
    if ([string]::IsNullOrEmpty($path)) {
        Show-Toast "Select a backup to delete" "⚠️"
        return
    }
    $name = [System.IO.Path]::GetFileName($path)
    $confirm = [System.Windows.MessageBox]::Show(
        "Permanently delete backup:`n`n$name`n`nThis cannot be undone.",
        "Delete Backup",
        "YesNo",
        "Warning"
    )
    if ($confirm -eq "Yes") {
        Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
        Refresh-Backups
        Show-Toast "Backup deleted" "🗑️"
    }
})

# ======================================================================
# RESTORE PROJECT
# ======================================================================
$RestoreProjectBtn.Add_Click({
    $path = Get-SelectedBackupPath
    if ([string]::IsNullOrEmpty($path) -or !(Test-Path $path)) {
        Show-Toast "Select a backup to restore" "⚠️"
        return
    }
    $parent = Split-Path $path -Parent
    $confirm = [System.Windows.MessageBox]::Show(
        "Restore all files from:`n`n$(Split-Path $path -Leaf)`n`nFiles will be overwritten in:`n$parent`n`nContinue?",
        "Restore Backup",
        "YesNo",
        "Question"
    )
    if ($confirm -ne "Yes") { return }
    try {
        $files = Get-ChildItem $path -Recurse -File -ErrorAction Stop
        $restored = 0
        foreach ($f in $files) {
            $rel = $f.FullName.Substring($path.Length).TrimStart('\')
            $dest = Join-Path $parent $rel
            $destDir = Split-Path $dest -Parent
            New-Item -ItemType Directory -Force -Path $destDir | Out-Null
            Copy-Item $f.FullName $dest -Force
            $restored++
        }
        Show-Toast "Restored $restored files successfully" "✅"
        [System.Windows.MessageBox]::Show("Restored $restored files from backup.", "Restore Complete", "OK", "Information")
    } catch {
        Show-Toast "Restore failed: $_" "❌"
    }
})

# ======================================================================
# PREVIEW BUTTON
# ======================================================================
$PreviewBtn.Add_Click({
    $root = $FolderBox.Text.Trim()
    if ([string]::IsNullOrEmpty($root) -or !(Test-Path $root)) {
        Show-Toast "Please select a valid folder first" "⚠️"
        return
    }
    $pattern = Build-ExtensionPattern
    if ($null -eq $pattern) {
        Show-Toast "Select at least one file type" "⚠️"
        return
    }
    $skipDeps = $SetSkipDeps.IsChecked

    $files = Get-ChildItem $root -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object {
            $_.FullName -notmatch '\\CC_Backups_' -and
            $_.Extension -match $pattern -and
            (!$skipDeps -or ($_.FullName -notmatch '\\(node_modules|\.git)\\'))
        }

    $totalEstimate = 0
    $previewLines  = 0
    $LogBox.Document.Blocks.Clear()
    Append-Log "=== PREVIEW MODE — No files will be modified ===" "#A78BFA"
    Append-Log ""

    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($null -eq $content) { continue }
        $after = $content
        $after = [regex]::Replace($after, '/\*[\s\S]*?\*/', '')
        $after = [regex]::Replace($after, '(?m)^\s*//.*?$', '')
        $after = [regex]::Replace($after, '<!--[\s\S]*?-->', '')
        $after = [regex]::Replace($after, '(?m)^\s*#.*?$', '')
        $removed = $content.Length - $after.Length
        if ($removed -gt 0) {
            $totalEstimate += $removed
            $previewLines++
            Append-Log "  $($file.Name)  →  -$removed chars" "#9CA3AF"
        }
    }

    Append-Log ""
    Append-Log "  $previewLines files with comments  •  ~$([Math]::Round($totalEstimate/1024,2)) KB to free" "#10B981"
    Append-Log "=== End of preview ===" "#A78BFA"
    Switch-Page "Scan"
    Show-Toast "Preview complete: $previewLines files found" "👁️"
})

# ======================================================================
# MAIN RUN
# ======================================================================
$RunBtn.Add_Click({
    $root = $FolderBox.Text.Trim()
    if ([string]::IsNullOrEmpty($root) -or !(Test-Path $root)) {
        Show-Toast "Please select a valid folder" "⚠️"
        return
    }

    $pattern = Build-ExtensionPattern
    if ($null -eq $pattern) {
        Show-Toast "Select at least one file type" "⚠️"
        return
    }

    if ($SetConfirm.IsChecked) {
        $confirm = [System.Windows.MessageBox]::Show(
            "This will remove comments from all matching source files in:`n`n$root`n`nAutomatic backups will be created first.`n`nContinue?",
            "Confirm Removal",
            "YesNo",
            "Question"
        )
        if ($confirm -ne "Yes") { return }
    }

    $startTime  = Get-Date
    $skipDeps   = $SetSkipDeps.IsChecked
    $inlineOnly = $SetInlineOnly.IsChecked
    $doBackup   = $SetAutoBackup.IsChecked

    $backupRoot = $null
    if ($doBackup) {
        $backupRoot = Join-Path $root "CC_Backups_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
    }

    $files = Get-ChildItem $root -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object {
            $_.FullName -notmatch '\\CC_Backups_' -and
            $_.Extension -match $pattern -and
            (!$skipDeps -or ($_.FullName -notmatch '\\(node_modules|\.git)\\'))
        }

    $FilesFoundTxt.Text = "Files found: $($files.Count)"
    $ProgressBar.Maximum = [Math]::Max($files.Count, 1)
    $ProgressBar.Value = 0
    $ScanningBadge.Visibility = "Visible"
    $LogBox.Document.Blocks.Clear()
    Append-Log "Starting... $($files.Count) files to process" "#A78BFA"
    Append-Log ""

    $processed = 0
    $removedTotal = 0
    $sizeSaved = 0

    foreach ($file in $files) {
        $processed++
        $relative = $file.FullName.Substring($root.Length).TrimStart('\')

        if ($doBackup -and $backupRoot) {
            $backupFile = Join-Path $backupRoot $relative
            $backupDir  = Split-Path $backupFile -Parent
            New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
            Copy-Item $file.FullName $backupFile -Force
        }

        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($null -eq $content) { continue }

        $before = $content.Length

        if ($inlineOnly) {
            $content = [regex]::Replace($content, '(?m)^\s*//.*?$', '')
            $content = [regex]::Replace($content, '(?m)^\s*#.*?$', '')
        } else {
            $content = [regex]::Replace($content, '/\*[\s\S]*?\*/', '')
            $content = [regex]::Replace($content, '(?m)^\s*//.*?$', '')
            $content = [regex]::Replace($content, '<!--[\s\S]*?-->', '')
            $content = [regex]::Replace($content, '(?m)^\s*#.*?$', '')
        }

        if (!$SetPreserveLines.IsChecked) {
            $content = [regex]::Replace($content, '(?m)^\s*$\n', '')
        }

        $after   = $content.Length
        $removed = $before - $after
        $removedTotal += $removed
        if ($removed -gt 0) { $sizeSaved += $removed }

        Set-Content $file.FullName $content -Encoding UTF8 -NoNewline

        $color = if ($removed -gt 0) { "#10B981" } else { "#4B5563" }
        Append-Log "  $($file.Name)  -$removed chars" $color

        $pct = [int](($processed / $files.Count) * 100)
        $FilesProcessedTxt.Text  = "$processed / $($files.Count) files"
        $ProgressPctTxt.Text     = "$pct%"
        $CommentsRemovedTxt.Text = "$removedTotal"
        $SizeSavedTxt.Text       = "$([Math]::Round($sizeSaved/1024,2)) KB"
        $ElapsedTxt.Text         = "$([int]((Get-Date) - $startTime).TotalSeconds)s"
        $ProgressBar.Value       = $processed

        $Window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Background)
    }

    $ScanningBadge.Visibility = "Collapsed"

    # Update totals
    $script:TotalFiles    += $processed
    $script:TotalComments += $removedTotal
    $script:TotalSize     += $sizeSaved
    $script:LastFolder     = $root

    $script:RecentScans.Add(@{
        Folder   = $root
        Files    = $processed
        Comments = $removedTotal
        Time     = (Get-Date).ToString("HH:mm")
    })

    $HomeLastFolder.Text = $root
    $HomeLastTime.Text   = "Last scan: $((Get-Date).ToString('MMM dd, HH:mm'))"
    Update-HomeStats
    Refresh-RecentList

    $duration = [int]((Get-Date) - $startTime).TotalSeconds
    Append-Log ""
    Append-Log "Done!  $processed files  •  $removedTotal comments removed  •  ${duration}s" "#A78BFA"

    Show-Toast "Done! $processed files processed in ${duration}s" "✅"
})

# ======================================================================
# INIT
# ======================================================================
$RecentEmpty.Visibility = "Visible"
$BackupEmpty.Visibility = "Visible"
Update-HomeStats

$Window.ShowDialog() | Out-Null
