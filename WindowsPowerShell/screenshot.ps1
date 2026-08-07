Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)
$graphics.Dispose()
$timestamp = Get-Date -Format "yyyy-MM-dd (HHmmss)"
$filePath = "$env:USERPROFILE\Pictures\Screenshots\Screenshot-$timestamp.png"
$bitmap.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
$bitmap.Dispose()
Write-Output "Saved to $filePath"

# Create the notification object
$Notification = New-Object System.Windows.Forms.NotifyIcon
$Notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process -Id $PID).Path)
$Notification.BalloonTipIcon  = "None"
$Notification.BalloonTipTitle = "Screenshotted!"
$Notification.BalloonTipText  = "Your Screenshot saved to $filePath"

# Display the notification (Visible for 10,000 milliseconds)
$Notification.Visible = $true
$Notification.ShowBalloonTip(50)

$Notification.Dispose()

