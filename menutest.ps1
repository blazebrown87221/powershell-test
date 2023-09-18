# Load the Windows Forms assembly
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# Create a new form
$form = New-Object Windows.Forms.Form
$form.Text = "PowerShell-like Menu"
$form.Size = New-Object Drawing.Size(400, 300)
$form.BackColor = [System.Drawing.Color]::FromArgb(25, 61, 131)  # Use the RGB color 25, 61, 131

# Load an icon from a URL (replace 'ICON_URL_HERE' with the actual icon URL)
$iconUrl = 'https://raw.githubusercontent.com/blazebrown87221/powershell-test/main/file_type_powershell_icon_130243.ico'
$iconStream = (New-Object System.Net.WebClient).DownloadData($iconUrl)
$iconConverter = New-Object System.Drawing.IconConverter
$icon = $iconConverter.ConvertFrom($iconStream)

# Set the icon for the form
$form.Icon = [System.Drawing.Icon]::FromHandle($icon.ToBitmap().GetHicon())

# Create a label for the menu
$label = New-Object Windows.Forms.Label
$label.Text = "=== Menu ==="
$label.AutoSize = $true
$label.ForeColor = [System.Drawing.Color]::White
$label.Font = New-Object Drawing.Font("Consolas", 16, [System.Drawing.FontStyle]::Bold)
$label.Location = [System.Drawing.Point]::new(10, 10)
$form.Controls.Add($label)

# Create menu items
$menuItems = @("Option 1", "Option 2", "Option 3", "Exit")
$menuItemLabels = @()

for ($i = 0; $i -lt $menuItems.Count; $i++) {
    $menuItem = $menuItems[$i]
    $menuItemLabel = New-Object Windows.Forms.Label
    $menuItemLabel.Text = "$($i + 1). $menuItem"
    $menuItemLabel.AutoSize = $true
    $menuItemLabel.ForeColor = [System.Drawing.Color]::White
    $menuItemLabel.Font = New-Object Drawing.Font("Consolas", 14)
    
    # Set the position of the label
    $menuItemLabel.Location = [System.Drawing.Point]::new(20, 60 + ($i * 40))
    
    # Add click event handler to each menu item
    $menuItemLabel.Add_Click({
        $selectedMenuItem = $menuItemLabel.Text -replace '^\d+\.\s', ''
        if ($selectedMenuItem -eq "Exit") {
            $form.Close()
        }
        else {
            [System.Windows.Forms.MessageBox]::Show("You selected $selectedMenuItem", "Menu Item Clicked")
        }
    })

    $menuItemLabel.Cursor = [System.Windows.Forms.Cursors]::Hand
    $menuItemLabels += $menuItemLabel
    $form.Controls.Add($menuItemLabel)
}

# Show the form
$form.ShowDialog()
