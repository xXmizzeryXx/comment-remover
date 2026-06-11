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
        Background="{StaticResource HeroGradient}"
        ResizeMode="CanResizeWithGrip"
        WindowStyle="SingleBorderWindow"
        FontFamily="Poppins, Segoe UI">

    <Window.Resources>

        <!-- ===== COLOR & FX RESOURCES ===== -->
        <SolidColorBrush x:Key="BgBase"       Color="#050510"/>
        <SolidColorBrush x:Key="BgSurface"    Color="#0C1428"/>
        <SolidColorBrush x:Key="BgCard"       Color="#111B33"/>
        <SolidColorBrush x:Key="BgCardHover"  Color="#182646"/>
        <SolidColorBrush x:Key="BgInput"      Color="#0E172E"/>
        <SolidColorBrush x:Key="Accent"       Color="#7F5BFF"/>
        <SolidColorBrush x:Key="AccentHover"  Color="#9B75FF"/>
        <SolidColorBrush x:Key="AccentPress"  Color="#5A3FE2"/>
        <SolidColorBrush x:Key="AccentGlow"   Color="#4030A8"/>
        <SolidColorBrush x:Key="Success"      Color="#34E0A1"/>
        <SolidColorBrush x:Key="Warning"      Color="#FFC85C"/>
        <SolidColorBrush x:Key="Danger"       Color="#FF6B6B"/>
        <SolidColorBrush x:Key="TextPrimary"  Color="#F6F8FF"/>
        <SolidColorBrush x:Key="TextSub"      Color="#ADB9D8"/>
        <SolidColorBrush x:Key="TextMuted"    Color="#5F6C8A"/>
        <SolidColorBrush x:Key="Border1"      Color="#162042"/>
        <SolidColorBrush x:Key="Border2"      Color="#1F2C54"/>
        <LinearGradientBrush x:Key="AccentGradient" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#7F5BFF" Offset="0"/>
            <GradientStop Color="#5BD8FF" Offset="1"/>
        </LinearGradientBrush>
        <LinearGradientBrush x:Key="HeroGradient" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#1E2854" Offset="0"/>
            <GradientStop Color="#131C38" Offset="0.45"/>
            <GradientStop Color="#0B1022" Offset="1"/>
        </LinearGradientBrush>
        <DropShadowEffect x:Key="CardGlow" BlurRadius="25" ShadowDepth="0" Color="#3C4A93" Opacity="0.6"/>
        <DropShadowEffect x:Key="SoftGlow" BlurRadius="40" ShadowDepth="0" Color="#7F5BFF" Opacity="0.35"/>

        <!-- ===== TYPOGRAPHY ===== -->
        <Style x:Key="DisplayTitle" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
            <Setter Property="FontSize" Value="34"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Margin" Value="0,0,0,8"/>
        </Style>

        <Style x:Key="DisplaySubtitle" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource TextSub}"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Margin" Value="0,0,0,24"/>
        </Style>

        <!-- ===== CARD STYLES ===== -->
        <Style x:Key="GlassCard" TargetType="Border">
            <Setter Property="Background" Value="#141F3900"/>
            <Setter Property="BorderBrush" Value="#5D78FF33"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="18"/>
            <Setter Property="Padding" Value="24"/>
        </Style>

        <Style x:Key="ElevatedCard" TargetType="Border" BasedOn="{StaticResource GlassCard}">
            <Setter Property="Background" Value="#162349BF"/>
            <Setter Property="Effect" Value="{StaticResource CardGlow}"/>
        </Style>

        <Style x:Key="MetricCard" TargetType="Border" BasedOn="{StaticResource GlassCard}">
            <Setter Property="Background" Value="#152240"/>
            <Setter Property="Padding" Value="18"/>
            <Setter Property="CornerRadius" Value="16"/>
        </Style>

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
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="FontSize" Value="14"/>
        </Style>

        <!-- ===== ACCENT BUTTON ===== -->
        <Style x:Key="AccentBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Padding" Value="18,12"/>
            <Setter Property="Background" Value="{StaticResource AccentGradient}"/>
            <Setter Property="Effect" Value="{StaticResource SoftGlow}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="14" Padding="{TemplateBinding Padding}">
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
                                <Setter TargetName="bd" Property="Opacity" Value="0.5"/>
                                <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== GHOST BUTTON ===== -->
        <Style x:Key="GhostBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Padding" Value="16,10"/>
            <Setter Property="Background" Value="#203153"/>
            <Setter Property="BorderBrush" Value="#2B3F6B"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="12"
                                BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#2A3E6A"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#1B294A"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== DANGER BUTTON ===== -->
        <Style x:Key="DangerBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Padding" Value="16,11"/>
            <Setter Property="Background" Value="#3B2030"/>
            <Setter Property="BorderBrush" Value="#BE4B6A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Foreground" Value="#FF9BB3"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="12"
                                BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#5A2742"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="#FF6B8A"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#2B1526"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== SIDEBAR NAV BUTTON ===== -->
        <Style x:Key="NavBtn" TargetType="Button" BasedOn="{StaticResource BtnBase}">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="HorizontalAlignment" Value="Stretch"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="18,14"/>
            <Setter Property="Margin" Value="4,4,4,0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="14"
                                Padding="{TemplateBinding Padding}">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="Auto"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>
                                <Border x:Name="indicator" Grid.Column="0" Width="6" CornerRadius="3"
                                        Background="Transparent" Margin="0,0,12,0"/>
                                <ContentPresenter Grid.Column="1" VerticalAlignment="Center"
                                                  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}"/>
                            </Grid>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#182646"/>
                                <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
                                <Setter TargetName="indicator" Property="Background" Value="#3F5BD9"/>
                            </Trigger>
                            <Trigger Property="Tag" Value="active">
                                <Setter TargetName="bd" Property="Background" Value="#212F56"/>
                                <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
                                <Setter TargetName="indicator" Property="Background" Value="{StaticResource AccentGradient}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ===== TEXTBOX ===== -->
        <Style TargetType="TextBox">
            <Setter Property="Background" Value="#162956"/>
            <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
            <Setter Property="BorderBrush" Value="#274173"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="14,0"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="CaretBrush" Value="{StaticResource AccentHover}"/>
            <Setter Property="SelectionBrush" Value="{StaticResource Accent}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border x:Name="bd" Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="12" Padding="{TemplateBinding Padding}">
                            <ScrollViewer x:Name="PART_ContentHost" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsFocused" Value="True">
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                                <Setter TargetName="bd" Property="Background" Value="#1B3263"/>
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
                            <Border x:Name="box" Width="20" Height="20" CornerRadius="6"
                                    BorderBrush="#2D4270" BorderThickness="1.4"
                                    Background="#162956" Margin="0,0,10,0">
                                <Path x:Name="chk" Data="M3 9 L7 13 L17 4" StrokeThickness="2.2" StrokeEndLineCap="Round" StrokeStartLineCap="Round" StrokeDashCap="Round"
                                      Stroke="#5BD8FF" Stretch="Fill" Visibility="Collapsed"/>
                            </Border>
                            <ContentPresenter VerticalAlignment="Center"/>
                        </StackPanel>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="box" Property="Background" Value="#1D2F5A"/>
                                <Setter TargetName="box" Property="BorderBrush" Value="#5BD8FF"/>
                                <Setter TargetName="chk" Property="Visibility" Value="Visible"/>
                                <Setter Property="Foreground" Value="{StaticResource TextPrimary}"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="box" Property="BorderBrush" Value="{StaticResource Accent}"/>
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
                                                <Border Height="5" Background="{StaticResource AccentGradient}" CornerRadius="3"/>
                                            </ControlTemplate>
                                        </RepeatButton.Template>
                                    </RepeatButton>
                                </Track.DecreaseRepeatButton>
                                <Track.IncreaseRepeatButton>
                                    <RepeatButton Command="Slider.IncreaseLarge">
                                        <RepeatButton.Template>
                                            <ControlTemplate TargetType="RepeatButton">
                                                <Border Height="5" Background="#1D2F57" CornerRadius="3"/>
                                            </ControlTemplate>
                                        </RepeatButton.Template>
                                    </RepeatButton>
                                </Track.IncreaseRepeatButton>
                                <Track.Thumb>
                                    <Thumb>
                                        <Thumb.Template>
                                            <ControlTemplate TargetType="Thumb">
                                                <Ellipse Width="18" Height="18" Fill="{StaticResource AccentHover}" Stroke="#2B3E6A" StrokeThickness="1"/>
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
            <Setter Property="Height" Value="8"/>
            <Setter Property="Background" Value="#152544"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ProgressBar">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4" Height="{TemplateBinding Height}">
                            <Border x:Name="PART_Indicator" HorizontalAlignment="Left" CornerRadius="4" Background="{StaticResource AccentGradient}"/>
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
            <Setter Property="ScrollViewer.VerticalScrollBarVisibility" Value="Auto"/>
            <Setter Property="ScrollViewer.CanContentScroll" Value="True"/>
        </Style>
        <Style TargetType="ListBoxItem">
            <Setter Property="Padding" Value="0"/>
            <Setter Property="Margin" Value="0,6"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ListBoxItem">
                        <Border x:Name="bd" Background="{TemplateBinding Background}"
                                CornerRadius="16" Padding="18,16"
                                BorderBrush="#203153" BorderThickness="1">
                            <ContentPresenter Margin="0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#1A2A51"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource Accent}"/>
                            </Trigger>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="bd" Property="Background" Value="#202F5D"/>
                                <Setter TargetName="bd" Property="BorderBrush" Value="{StaticResource AccentGradient}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

    </Window.Resources>

    <!-- ROOT GRID -->
    <Grid>
        <!-- Ambient backdrop -->
        <Grid Grid.ColumnSpan="2" IsHitTestVisible="False">
            <Ellipse Width="480" Height="480" Fill="#3F42FF26" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-160,-180,0,0" Effect="{StaticResource SoftGlow}"/>
            <Ellipse Width="380" Height="380" Fill="#2BC5FF1F" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-140,-120" Effect="{StaticResource SoftGlow}"/>
            <Rectangle Height="320" VerticalAlignment="Top" Margin="260,140,260,0" RadiusX="160" RadiusY="160">
                <Rectangle.Fill>
                    <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                        <GradientStop Color="#1E2D5F" Offset="0"/>
                        <GradientStop Color="#101730" Offset="1"/>
                    </LinearGradientBrush>
                </Rectangle.Fill>
            </Rectangle>
        </Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="280"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <!-- ====================================================
             SIDEBAR
             ==================================================== -->
        <Border Grid.Column="0" Style="{StaticResource ElevatedCard}" Margin="36" Padding="32,36">
            <DockPanel>

                <!-- Logo -->
                <StackPanel DockPanel.Dock="Top" Margin="8,0,8,32">
                    <Border Width="64" Height="64" CornerRadius="20" Background="{StaticResource AccentGradient}" Effect="{StaticResource SoftGlow}" HorizontalAlignment="Left">
                        <TextBlock Text="CC" FontSize="26" FontWeight="Bold" Foreground="White"
                                   HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                    <StackPanel Margin="0,20,0,0">
                        <TextBlock Text="Comment Cleaner" Foreground="{StaticResource TextPrimary}" FontSize="22" FontWeight="SemiBold"/>
                        <TextBlock Text="Reactbits-inspired PowerShell UI" Foreground="{StaticResource TextMuted}" FontSize="12" Margin="0,4,0,0"/>
                    </StackPanel>
                </StackPanel>

                <!-- Nav Label -->
                <StackPanel DockPanel.Dock="Top" Orientation="Horizontal" Margin="0,0,0,12">
                    <TextBlock Text="PAGES" Foreground="{StaticResource TextMuted}" FontSize="11" FontWeight="SemiBold" LetterSpacing="0.4"/>
                    <Rectangle Width="1" Height="12" Fill="#2A3F68" Margin="12,0,12,0"/>
                    <TextBlock Text="Explore &amp; manage" Foreground="{StaticResource TextSub}" FontSize="11"/>
                </StackPanel>

                <!-- Nav Buttons -->
                <StackPanel DockPanel.Dock="Top">
                    <Button x:Name="NavHome"     Style="{StaticResource NavBtn}" Content="  🏠  Home"     Tag="active"/>
                    <Button x:Name="NavScan"     Style="{StaticResource NavBtn}" Content="  🔍  Scan Files"/>
                    <Button x:Name="NavBackups"  Style="{StaticResource NavBtn}" Content="  📦  Backups"/>
                    <Button x:Name="NavSettings" Style="{StaticResource NavBtn}" Content="  ⚙️  Settings"/>
                    <Button x:Name="NavAbout"    Style="{StaticResource NavBtn}" Content="  ℹ️  About"/>
                </StackPanel>

                <!-- Bottom Stats Box -->
                <StackPanel DockPanel.Dock="Bottom" Margin="0,0,0,12">
                    <Border Style="{StaticResource GlassCard}">
                        <StackPanel>
                            <TextBlock Text="Today’s session" Foreground="{StaticResource TextSub}" FontSize="11" FontWeight="SemiBold" Margin="0,0,0,14"/>
                            <UniformGrid Columns="1" Rows="3" Margin="0">
                                <StackPanel Margin="0,4">
                                    <TextBlock Text="Files scanned" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                                    <TextBlock x:Name="SBFiles" Text="0" Foreground="{StaticResource TextPrimary}" FontSize="20" FontWeight="SemiBold"/>
                                </StackPanel>
                                <StackPanel Margin="0,10">
                                    <TextBlock Text="Comments removed" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                                    <TextBlock x:Name="SBComments" Text="0" Foreground="{StaticResource Success}" FontSize="20" FontWeight="SemiBold"/>
                                </StackPanel>
                                <StackPanel Margin="0,4">
                                    <TextBlock Text="Space saved" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                                    <TextBlock x:Name="SBSize" Text="0 KB" Foreground="{StaticResource TextPrimary}" FontSize="18" FontWeight="Medium"/>
                                </StackPanel>
                            </UniformGrid>
                        </StackPanel>
                    </Border>
                </StackPanel>

            </DockPanel>
        </Border>

        <!-- ====================================================
             MAIN CONTENT AREA
             ==================================================== -->
        <Grid Grid.Column="1" Margin="0,36,36,36">

            <!-- Toast Notification -->
            <Border x:Name="ToastPanel"
                    HorizontalAlignment="Right" VerticalAlignment="Top"
                    Margin="0,0,0,0" Padding="22,16" CornerRadius="14"
                    Background="#1E2E58F0" BorderBrush="#3F57FF66" BorderThickness="1"
                    Visibility="Collapsed" Panel.ZIndex="99" MaxWidth="420">
                <StackPanel Orientation="Horizontal">
                    <TextBlock x:Name="ToastIcon" FontSize="18" VerticalAlignment="Center"/>
                    <TextBlock x:Name="ToastText" Foreground="{StaticResource TextPrimary}" FontSize="14"
                               TextWrapping="Wrap" VerticalAlignment="Center" Margin="12,0,0,0"/>
                </StackPanel>
            </Border>

            <!-- ============ PAGE: HOME ============ -->
            <ScrollViewer x:Name="PageHome" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="12,0,12,36">

                    <!-- Hero Panel -->
                    <Border Style="{StaticResource ElevatedCard}" Padding="40" Background="#182B58E0" Margin="0,0,0,28">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="2*"/>
                                <ColumnDefinition Width="1.4*"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel>
                                <TextBlock Text="Welcome back" Foreground="{StaticResource TextSub}" FontSize="15"/>
                                <TextBlock Text="Your comment-free workflow" Style="{StaticResource DisplayTitle}" FontSize="40"/>
                                <TextBlock Text="Scan, preview, and restore your codebases with a single tap." Style="{StaticResource DisplaySubtitle}" Margin="0,6,0,30"/>

                                <StackPanel Orientation="Horizontal">
                                    <StackPanel.Resources>
                                        <Thickness x:Key="ActionSpacing">12,0,0,0</Thickness>
                                    </StackPanel.Resources>
                                    <Button x:Name="QAScanBtn" Content="🚀  Start new scan" Style="{StaticResource AccentBtn}" MinWidth="180"/>
                                    <Button x:Name="QABackupBtn" Content="📦  View backups" Style="{StaticResource GhostBtn}" MinWidth="150" Margin="{StaticResource ActionSpacing}"/>
                                    <Button x:Name="QASettingsBtn" Content="⚙️  Settings" Style="{StaticResource GhostBtn}" MinWidth="140" Margin="{StaticResource ActionSpacing}"/>
                                </StackPanel>
                            </StackPanel>

                            <StackPanel Grid.Column="1" Margin="32,0,0,0">
                                <TextBlock Text="Snapshot" Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,0,0,14"/>
                                <UniformGrid Columns="3" Rows="1">
                                    <Border Style="{StaticResource MetricCard}" Margin="0,0,14,0">
                                        <StackPanel>
                                            <TextBlock Text="Files processed" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                            <TextBlock x:Name="HomeFilesVal" Text="0" Foreground="{StaticResource TextPrimary}" FontSize="30" FontWeight="Bold" Margin="0,6,0,0"/>
                                        </StackPanel>
                                    </Border>
                                    <Border Style="{StaticResource MetricCard}" Margin="14,0,14,0">
                                        <StackPanel>
                                            <TextBlock Text="Comments removed" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                            <TextBlock x:Name="HomeCommentsVal" Text="0" Foreground="{StaticResource Success}" FontSize="30" FontWeight="Bold" Margin="0,6,0,0"/>
                                        </StackPanel>
                                    </Border>
                                    <Border Style="{StaticResource MetricCard}" Margin="14,0,0,0">
                                        <StackPanel>
                                            <TextBlock Text="Storage saved" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                            <TextBlock x:Name="HomeSizeVal" Text="0 KB" Foreground="{StaticResource TextPrimary}" FontSize="28" FontWeight="Bold" Margin="0,6,0,0"/>
                                        </StackPanel>
                                    </Border>
                                </UniformGrid>
                                <Border Background="#22376A" CornerRadius="12" Padding="18" Margin="0,26,0,0">
                                    <StackPanel>
                                        <TextBlock Text="Last scan" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                        <TextBlock x:Name="HomeLastFolder" Text="No folder scanned yet" Foreground="{StaticResource TextPrimary}" FontSize="14" Margin="0,6,0,0" TextWrapping="Wrap"/>
                                        <TextBlock x:Name="HomeLastTime" Text="" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                    </StackPanel>
                                </Border>
                            </StackPanel>
                        </Grid>
                    </Border>

                    <!-- Recent Activity + Insights -->
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="28"/>
                            <ColumnDefinition Width="320"/>
                        </Grid.ColumnDefinitions>

                        <!-- Recent Activity -->
                        <Border Grid.Column="0" Style="{StaticResource GlassCard}" Padding="26" Background="#122045DD">
                            <StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,18">
                                    <TextBlock Text="Activity timeline" Foreground="{StaticResource TextPrimary}" FontSize="18" FontWeight="SemiBold"/>
                                    <Rectangle Width="8" Height="8" Fill="{StaticResource AccentGradient}" RadiusX="4" RadiusY="4" VerticalAlignment="Center"/>
                                    <TextBlock Text="Latest 8 scans" Foreground="{StaticResource TextSub}" FontSize="12" VerticalAlignment="Center"/>
                                </StackPanel>
                                <ListBox x:Name="RecentList" Background="Transparent" BorderThickness="0"/>
                                <TextBlock x:Name="RecentEmpty" Text="No scans yet. Head to Scan Files to get started."
                                           Foreground="{StaticResource TextMuted}" FontSize="13"
                                           HorizontalAlignment="Center" Margin="0,24,0,0" TextWrapping="Wrap"/>
                            </StackPanel>
                        </Border>

                        <!-- Insights -->
                        <StackPanel Grid.Column="2">
                            <StackPanel.Resources>
                                <Thickness x:Key="InsightSpacing">0,20,0,0</Thickness>
                            </StackPanel.Resources>
                            <Border Style="{StaticResource GlassCard}" Padding="22" Background="#10203FDD">
                                <StackPanel>
                                    <TextBlock Text="Session health" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold" Margin="0,0,0,10"/>
                                    <StackPanel Orientation="Horizontal" Margin="0,6,0,0">
                                        <Border Background="#1E315F" CornerRadius="14" Padding="14" Width="120">
                                            <StackPanel>
                                                <TextBlock Text="Files" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                                                <TextBlock Text="↺ Live" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="SemiBold" Margin="0,6,0,0"/>
                                                <TextBlock Text="Auto-refresh" Foreground="{StaticResource TextSub}" FontSize="11"/>
                                            </StackPanel>
                                        </Border>
                                        <StackPanel Margin="16,0,0,0">
                                            <TextBlock Text="Tip" Foreground="{StaticResource TextSub}" FontSize="12"/>
                                            <TextBlock Text="Run a preview to inspect removals before committing changes."
                                                       Foreground="{StaticResource TextPrimary}" FontSize="13" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                        </StackPanel>
                                    </StackPanel>
                                </StackPanel>
                            </Border>

                            <Border Style="{StaticResource GlassCard}" Padding="22" Background="#10203FDD" Margin="{StaticResource InsightSpacing}">
                                <StackPanel>
                                    <TextBlock Text="Helpful shortcuts" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold" Margin="0,0,0,14"/>
                                    <StackPanel>
                                        <TextBlock Text="• Drag &amp; drop any folder to load it instantly." Foreground="{StaticResource TextSub}" FontSize="12"/>
                                        <TextBlock Text="• Toggle inline-only mode from Settings to preserve multi-line docs." Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,10,0,0"/>
                                        <TextBlock Text="• Backups are stored alongside your project inside CC_Backups_*." Foreground="{StaticResource TextSub}" FontSize="12" Margin="0,10,0,0"/>
                                    </StackPanel>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </Grid>
                </StackPanel>
            </ScrollViewer>

            <!-- ============ PAGE: SCAN ============ -->
            <ScrollViewer x:Name="PageScan" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="12,0,12,36">

                    <StackPanel>
                        <TextBlock Text="Scan &amp; remove" Style="{StaticResource DisplayTitle}" FontSize="38"/>
                        <TextBlock Text="Strip comments from your project with safety nets, analytics, and backups." Style="{StaticResource DisplaySubtitle}"/>
                    </StackPanel>

                    <Border Style="{StaticResource ElevatedCard}" Padding="32" Background="#13254BE6" Margin="0,28,0,28">
                        <StackPanel>

                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <TextBox x:Name="FolderBox" Height="48" FontSize="14" VerticalContentAlignment="Center"/>
                                <Button x:Name="BrowseBtn" Grid.Column="1" Content="Browse folder" Style="{StaticResource AccentBtn}" Height="48" Margin="16,0,0,0" MinWidth="160"/>
                            </Grid>

                            <StackPanel Margin="0,24,0,0">
                                <TextBlock Text="Filetypes in scope" Foreground="{StaticResource TextSub}" FontSize="13" Margin="0,0,0,12"/>
                                <WrapPanel ItemHeight="30" ItemWidth="110">
                                    <CheckBox x:Name="ChkJS"  Content="JS / TS" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkJSX" Content="JSX / TSX" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkCSS" Content="CSS / SCSS" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkHTML" Content="HTML / HTM" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkJava" Content="Java" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkCS" Content="C#" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkCpp" Content="C / C++" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkPHP" Content="PHP" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkPy" Content="Python" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkGo" Content="Go" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkRust" Content="Rust" IsChecked="True" Margin="0,0,18,8"/>
                                    <CheckBox x:Name="ChkSwift" Content="Swift" IsChecked="True" Margin="0,0,0,8"/>
                                </WrapPanel>
                            </StackPanel>

                            <StackPanel Orientation="Horizontal" Margin="0,24,0,0">
                                <Button x:Name="RunBtn" Content="🚀  Remove comments" Style="{StaticResource AccentBtn}" MinWidth="220" Height="50"/>
                                <Button x:Name="PreviewBtn" Content="👁  Preview changes" Style="{StaticResource GhostBtn}" MinWidth="200" Height="50" Margin="12,0,0,0"/>
                                <Button x:Name="ClearLogBtn" Content="Clear log" Style="{StaticResource GhostBtn}" Height="50" Margin="12,0,0,0"/>
                            </StackPanel>

                            <TextBlock Text="Tip: previews let you audit comment removals before committing." Foreground="{StaticResource TextMuted}" FontSize="12" Margin="0,18,0,0"/>
                        </StackPanel>
                    </Border>

                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="3*"/>
                            <ColumnDefinition Width="32"/>
                            <ColumnDefinition Width="2*"/>
                        </Grid.ColumnDefinitions>

                        <Border Grid.Column="0" Style="{StaticResource GlassCard}" Padding="26" Background="#101D3CDD" Margin="0,28,0,0">
                            <StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,14">
                                    <TextBlock Text="Operation log" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold"/>
                                    <Border x:Name="ScanningBadge" Background="#273A72" CornerRadius="8" Padding="10,4" Visibility="Collapsed" Margin="10,0,0,0">
                                        <TextBlock Text="● scanning" Foreground="{StaticResource Accent}" FontSize="12" FontWeight="SemiBold"/>
                                    </Border>
                                </StackPanel>
                                <ScrollViewer VerticalScrollBarVisibility="Auto">
                                    <RichTextBox x:Name="LogBox" Background="Transparent" BorderThickness="0" Padding="18,8,18,18" FontFamily="Cascadia Code, Consolas" FontSize="12" Foreground="#D0D7F2" IsReadOnly="True"/>
                                </ScrollViewer>
                            </StackPanel>
                        </Border>

                        <Border Grid.Column="2" Style="{StaticResource GlassCard}" Padding="26" Background="#10203FD9" Margin="0,28,0,0">
                            <StackPanel>
                                <TextBlock Text="Live progress" Foreground="{StaticResource TextPrimary}" FontSize="16" FontWeight="SemiBold"/>
                                <TextBlock x:Name="FilesFoundTxt" Text="Files found: 0" Foreground="{StaticResource TextSub}" FontSize="13" Margin="0,8,0,0"/>
                                <ProgressBar x:Name="ProgressBar" Margin="0,6,0,4"/>
                                <Grid Margin="0,0,0,12">
                                    <Grid.ColumnDefinitions>
                                        <ColumnDefinition Width="*"/>
                                        <ColumnDefinition Width="Auto"/>
                                    </Grid.ColumnDefinitions>
                                    <TextBlock x:Name="FilesProcessedTxt" Text="0 / 0 files" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                    <TextBlock x:Name="ProgressPctTxt" Grid.Column="1" Text="0%" Foreground="{StaticResource Accent}" FontSize="13" FontWeight="Bold"/>
                                </Grid>

                                <StackPanel Orientation="Horizontal">
                                    <Border Style="{StaticResource MetricCard}" Padding="20" Margin="0,0,6,0">
                                        <StackPanel>
                                            <TextBlock Text="Comments" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                            <TextBlock x:Name="CommentsRemovedTxt" Text="0" Foreground="{StaticResource Success}" FontSize="26" FontWeight="Bold" Margin="0,6,0,0"/>
                                        </StackPanel>
                                    </Border>
                                    <Border Style="{StaticResource MetricCard}" Padding="20" Margin="12,0,0,0">
                                        <StackPanel>
                                            <TextBlock Text="Space saved" Foreground="{StaticResource TextMuted}" FontSize="12"/>
                                            <TextBlock x:Name="SizeSavedTxt" Text="0 KB" Foreground="{StaticResource TextPrimary}" FontSize="24" FontWeight="Bold" Margin="0,6,0,0"/>
                                        </StackPanel>
                                    </Border>
                                </StackPanel>

                                <Border Background="#1A2F5D" CornerRadius="12" Padding="18" Margin="0,20,0,0">
                                    <StackPanel Orientation="Horizontal">
                                        <Border Width="32" Height="32" CornerRadius="10" Background="#273F7B">
                                            <TextBlock Text="⏱" FontSize="16" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                        </Border>
                                        <StackPanel Margin="12,0,0,0">
                                            <TextBlock Text="Elapsed" Foreground="{StaticResource TextMuted}" FontSize="11"/>
                                            <TextBlock x:Name="ElapsedTxt" Text="0s" Foreground="{StaticResource TextPrimary}" FontSize="22" FontWeight="Bold" Margin="0,2,0,0"/>
                                        </StackPanel>
                                    </StackPanel>
                                </Border>

                                <TextBlock Text="Drag a folder anywhere onto this window to auto-fill the path." Foreground="{StaticResource TextMuted}" FontSize="12" TextWrapping="Wrap" Margin="0,18,0,0"/>
                            </StackPanel>
                        </Border>
                    </Grid>

                    <TextBlock Text="Supported: JS  TS  JSX  TSX  CSS  HTML  Java  C#  C/C++  PHP  Python  Go  Rust  Swift" Foreground="{StaticResource TextMuted}" FontSize="11" HorizontalAlignment="Center" Margin="0,28,0,0"/>
                </StackPanel>
            </ScrollViewer>

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
                    <Border Grid.Column="0" Background="{StaticResource BgCard}" CornerRadius="18" Padding="24"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <DockPanel>
                            <StackPanel DockPanel.Dock="Top" Orientation="Horizontal" Margin="0,0,0,18">
                                <TextBlock Text="Backup snapshots" Foreground="{StaticResource TextPrimary}"
                                           FontSize="16" FontWeight="SemiBold" VerticalAlignment="Center"/>
                                <Button x:Name="RefreshBackupsBtn" Content="↻ Refresh" Style="{StaticResource GhostBtn}"
                                        Margin="16,0,0,0" Padding="14,6" FontSize="12"/>
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
                    <Border Grid.Column="2" Background="{StaticResource BgCard}" CornerRadius="18" Padding="24"
                            BorderBrush="{StaticResource Border1}" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="ACTIONS" Foreground="{StaticResource TextMuted}"
                                       FontSize="10" FontWeight="SemiBold" Margin="0,0,0,20"/>

                            <Button x:Name="RestoreProjectBtn" Content="🔄  Restore Entire Project"
                                    Style="{StaticResource AccentBtn}" HorizontalAlignment="Stretch"
                                    Height="46" Margin="0,0,0,12"/>
                            <Button x:Name="OpenBackupFolderBtn" Content="📂  Open in Explorer"
                                    Style="{StaticResource GhostBtn}" HorizontalAlignment="Stretch"
                                    Height="42" Margin="0,0,0,12"/>
                            <Button x:Name="DeleteBackupBtn" Content="🗑  Delete This Backup"
                                    Style="{StaticResource DangerBtn}" HorizontalAlignment="Stretch" Height="42"/>

                            <Separator Background="{StaticResource Border1}" Margin="0,26,0,22" Height="1"/>

                            <TextBlock Text="SELECTED BACKUP" Foreground="{StaticResource TextMuted}"
                                       FontSize="10" FontWeight="SemiBold" Margin="0,0,0,14"/>
                            <TextBlock x:Name="BackupDetailName" Text="—" Foreground="{StaticResource TextPrimary}"
                                       FontSize="14" FontWeight="Medium" TextWrapping="Wrap" Margin="0,0,0,6"/>
                            <TextBlock x:Name="BackupDetailDate" Text="" Foreground="{StaticResource TextSub}"
                                       FontSize="12"/>
                            <TextBlock x:Name="BackupDetailFiles" Text="" Foreground="{StaticResource TextSub}"
                                       FontSize="12" Margin="4,4,0,0"/>
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
    param($sender, $eventArgs)

    $ToastPanel.Visibility = "Collapsed"
    $sender.Stop()
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

function Get-LineCommentTokens {
    param([string]$Extension)

    $ext = if ([string]::IsNullOrEmpty($Extension)) { "" } else { $Extension.ToLowerInvariant() }
    $slashExts = @(".js", ".ts", ".jsx", ".tsx", ".java", ".cs", ".c", ".cpp", ".h", ".hpp", ".php", ".go", ".rs", ".swift", ".kt", ".scss", ".css", ".less")
    $hashExts  = @(".py", ".rb", ".pl", ".php", ".ps1", ".psm1", ".sh", ".bash", ".zsh", ".yaml", ".yml", ".ini", ".cfg", ".toml")
    $dashExts  = @(".sql", ".psql")

    $tokens = @()
    if ($slashExts -contains $ext) { $tokens += "//" }
    if ($hashExts -contains $ext)  { $tokens += "#" }
    if ($dashExts -contains $ext)  { $tokens += "--" }
    return $tokens
}

function Remove-LineCommentFromLine {
    param(
        [string]$Line,
        [string[]]$Tokens
    )

    if ([string]::IsNullOrEmpty($Line) -or $Tokens.Count -eq 0) { return $Line }

    $chars      = $Line.ToCharArray()
    $length     = $chars.Length
    $inSingle   = $false
    $inDouble   = $false
    $inBacktick = $false
    $inVerbatim = $false
    $escaped    = $false

    for ($i = 0; $i -lt $length; $i++) {
        $ch = $chars[$i]

        if ($escaped) { $escaped = $false; continue }

        if ($inVerbatim) {
            if ($ch -eq '"' -and $i + 1 -lt $length -and $chars[$i + 1] -eq '"') {
                $i++
                continue
            }
            if ($ch -eq '"') {
                $inVerbatim = $false
                $inDouble   = $false
            }
            continue
        }

        if ($ch -eq '\\') {
            if ($inSingle -or $inDouble -or $inBacktick) {
                $escaped = $true
            }
            continue
        }

        if ($ch -eq '"' -and -not $inSingle -and -not $inBacktick) {
            if ($i -gt 0 -and $chars[$i - 1] -eq '@' -and -not $inDouble) {
                $inVerbatim = $true
                $inDouble   = $true
            } else {
                $inDouble = -not $inDouble
            }
            continue
        }

        if ($ch -eq "'" -and -not $inDouble -and -not $inBacktick) {
            $inSingle = -not $inSingle
            continue
        }

        if ($ch -eq '`' -and -not $inSingle -and -not $inDouble) {
            $inBacktick = -not $inBacktick
            continue
        }

        if ($inSingle -or $inDouble -or $inBacktick) { continue }

        foreach ($token in $Tokens) {
            switch ($token) {
                '//' {
                    if ($ch -eq '/' -and $i + 1 -lt $length -and $chars[$i + 1] -eq '/') {
                        $prevIsColon = ($i -gt 0 -and $chars[$i - 1] -eq ':')
                        $prevIsEscape = ($i -gt 0 -and $chars[$i - 1] -eq '\\')
                        if (-not $prevIsColon -and -not $prevIsEscape) {
                            return $Line.Substring(0, $i).TrimEnd()
                        }
                    }
                }
                '#' {
                    if ($ch -eq '#') {
                        return $Line.Substring(0, $i).TrimEnd()
                    }
                }
                '--' {
                    if ($ch -eq '-' -and $i + 1 -lt $length -and $chars[$i + 1] -eq '-') {
                        return $Line.Substring(0, $i).TrimEnd()
                    }
                }
            }
        }
    }

    return $Line
}

function Remove-InlineCommentsFromContent {
    param(
        [string]$Content,
        [string]$Extension
    )

    $tokens = Get-LineCommentTokens $Extension
    if ($tokens.Count -eq 0) { return $Content }

    $delimiter = if ($Content -match "`r`n") { "`r`n" } else { "`n" }
    $lines     = [regex]::Split($Content, "\r?\n")
    for ($idx = 0; $idx -lt $lines.Length; $idx++) {
        $lines[$idx] = Remove-LineCommentFromLine -Line $lines[$idx] -Tokens $tokens
    }
    return [string]::Join($delimiter, $lines)
}

function Invoke-CommentRemoval {
    param(
        [string]$Content,
        [string]$Extension,
        [bool]$InlineOnly,
        [bool]$PreserveLines
    )

    $result = $Content

    if ($InlineOnly) {
        $result = Remove-InlineCommentsFromContent -Content $result -Extension $Extension
    } else {
        $result = [regex]::Replace($result, '/\*[\s\S]*?\*/', '')
        $result = [regex]::Replace($result, '<!--[\s\S]*?-->', '')
        $result = Remove-InlineCommentsFromContent -Content $result -Extension $Extension
    }

    if (-not $PreserveLines) {
        $result = [regex]::Replace($result, '(?m)^\s*$\r?\n', '')
    }

    return $result
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
    $skipDeps      = $SetSkipDeps.IsChecked
    $inlineOnly    = $SetInlineOnly.IsChecked
    $preserveLines = $SetPreserveLines.IsChecked

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
        $after = Invoke-CommentRemoval -Content $content -Extension $file.Extension -InlineOnly:$inlineOnly -PreserveLines:$preserveLines
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
    $preserveLines = $SetPreserveLines.IsChecked

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
        $content = Invoke-CommentRemoval -Content $content -Extension $file.Extension -InlineOnly:$inlineOnly -PreserveLines:$preserveLines

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
