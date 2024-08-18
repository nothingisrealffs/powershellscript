Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$basePath = "OU=Workstations,OU=XX,OU=XX,OU=XX,OU=XX,OU=XX,DC=XX,DC=XX,DC=XX"
$categories = @("XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","XX","Storage","Checkout","Other")
$frontPath = XX
# Function to simulate the operation
function PerformOperation($data) {
    # Simulate some operation
    Start-Sleep -Seconds 1
    Write-Host "Operation performed with data: $($data | ConvertTo-Json)"
    return $true
}

function firstForm($data) {
    $ID = $frontPath+"-"+$data
    #[System.Windows.Forms.MessageBox]::Show($ID)
    try {
        $adComputer = Get-ADComputer -Filter {Name -eq $ID} -SearchBase $basePath
        if ($adComputer) {
            return $adComputer
    }} catch {
        Write-Host "Error: $_"
        exit 1
    }
}

function runCommand($pcName,$descData) {
    Write-Host $pcName.Name
    Write-Host $descData
    Set-ADComputer -Identity $pcName.Name -Replace @{description=$descData}
}

$form1 = New-Object System.Windows.Forms.Form
$form1.Text = 'Enter Text'
$form1.Size = New-Object System.Drawing.Size(300,150)
$form1.StartPosition = 'CenterScreen'

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,20)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form1.Controls.Add($textBox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,70)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form1.AcceptButton = $okButton
$form1.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,70)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form1.CancelButton = $cancelButton
$form1.Controls.Add($cancelButton)

$result = $form1.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $newText = $textBox.Text
    $operationSuccess = firstForm($newText)
    
    if ($operationSuccess)
    {
        $form2 = New-Object System.Windows.Forms.Form
        $form2.Text = 'Select Options'
        $form2.Size = New-Object System.Drawing.Size(300,450)
        $form2.StartPosition = 'CenterScreen'

        $dropdown = New-Object System.Windows.Forms.ComboBox
        $dropdown.Location = New-Object System.Drawing.Point(10,20)
        $dropdown.Size = New-Object System.Drawing.Size(260,20)
        $dropdown.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
        $categories | ForEach-Object { $dropdown.Items.Add($_) }
        $form2.Controls.Add($dropdown)

        $checkbox = New-Object System.Windows.Forms.CheckBox
        $checkbox.Location = New-Object System.Drawing.Point(10,50)
        $checkbox.Size = New-Object System.Drawing.Size(260,20)
        $checkbox.Text = "Skip Name Fields"
        $checkbox.Visible = $false
        $form2.Controls.Add($checkbox)

        $label1 = New-Object System.Windows.Forms.Label
        $label1.Location = New-Object System.Drawing.Point(10,80)
        $label1.Size = New-Object System.Drawing.Size(260,20)
        $label1.Text = "First Name"
        $label1.Visible = $false
        $form2.Controls.Add($label1)

        $textBox1 = New-Object System.Windows.Forms.TextBox
        $textBox1.Location = New-Object System.Drawing.Point(10,100)
        $textBox1.Size = New-Object System.Drawing.Size(260,20)
        $textBox1.Visible = $false
        $form2.Controls.Add($textBox1)

        $label2 = New-Object System.Windows.Forms.Label
        $label2.Location = New-Object System.Drawing.Point(10,130)
        $label2.Size = New-Object System.Drawing.Size(260,20)
        $label2.Text = "Last Name"
        $label2.Visible = $false
        $form2.Controls.Add($label2)

        $textBox2 = New-Object System.Windows.Forms.TextBox
        $textBox2.Location = New-Object System.Drawing.Point(10,150)
        $textBox2.Size = New-Object System.Drawing.Size(260,20)
        $textBox2.Visible = $false
        $form2.Controls.Add($textBox2)

        $label3 = New-Object System.Windows.Forms.Label
        $label3.Location = New-Object System.Drawing.Point(10,180)
        $label3.Size = New-Object System.Drawing.Size(260,20)
        $label3.Text = "Model Number"
        $label3.Visible = $false
        $form2.Controls.Add($label3)

        $textBox3 = New-Object System.Windows.Forms.TextBox
        $textBox3.Location = New-Object System.Drawing.Point(10,200)
        $textBox3.Size = New-Object System.Drawing.Size(260,20)
        $textBox3.Visible = $false
        $form2.Controls.Add($textBox3)

        $label4 = New-Object System.Windows.Forms.Label
        $label4.Location = New-Object System.Drawing.Point(10,230)
        $label4.Size = New-Object System.Drawing.Size(260,20)
        $label4.Text = "Room Number"
        $label4.Visible = $false
        $form2.Controls.Add($label4)

        $textBox4 = New-Object System.Windows.Forms.TextBox
        $textBox4.Location = New-Object System.Drawing.Point(10,250)
        $textBox4.Size = New-Object System.Drawing.Size(260,20)
        $textBox4.Visible = $false
        $form2.Controls.Add($textBox4)

        $label5 = New-Object System.Windows.Forms.Label
        $label5.Location = New-Object System.Drawing.Point(10,280)
        $label5.Size = New-Object System.Drawing.Size(260,20)
        $label5.Text = "Department"
        $label5.Visible = $false
        $form2.Controls.Add($label5)

        $textBox5 = New-Object System.Windows.Forms.TextBox
        $textBox5.Location = New-Object System.Drawing.Point(10,300)
        $textBox5.Size = New-Object System.Drawing.Size(260,20)
        $textBox5.Visible = $false
        $form2.Controls.Add($textBox5)

        $okButton2 = New-Object System.Windows.Forms.Button
        $okButton2.Location = New-Object System.Drawing.Point(75,350)
        $okButton2.Size = New-Object System.Drawing.Size(75,23)
        $okButton2.Text = 'OK'
        $okButton2.Enabled = $false
        $form2.Controls.Add($okButton2)

        $cancelButton2 = New-Object System.Windows.Forms.Button
        $cancelButton2.Location = New-Object System.Drawing.Point(150,350)
        $cancelButton2.Size = New-Object System.Drawing.Size(75,23)
        $cancelButton2.Text = 'Cancel'
        $cancelButton2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form2.CancelButton = $cancelButton2
        $form2.Controls.Add($cancelButton2)

        function UpdateFormLayout {
            $selectedValue = [string]$dropdown.SelectedItem
            if ($selectedValue -in "Storage","Checkout") {
                $checkbox.Visible = $true
                if ($checkbox.Checked) {
                    $label1.Visible = $false
                    $textBox1.Visible = $false
                    $label2.Visible = $false
                    $textBox2.Visible = $false
                    $label3.Visible = $true
                    $textBox3.Visible = $true
                    $label4.Visible = $true
                    $textBox4.Visible = $true
                    $label5.Visible = $false
                    $textBox5.Visible = $false
                    $label3.Text = "Model Number"
                    $label4.Text = "Room Number"
                } else {
                    $label1.Visible = $true
                    $textBox1.Visible = $true
                    $label2.Visible = $true
                    $textBox2.Visible = $true
                    $label3.Visible = $true
                    $textBox3.Visible = $true
                    $label4.Visible = $true
                    $textBox4.Visible = $true
                    $label5.Visible = $false
                    $textBox5.Visible = $false
                    $label1.Text = "First Name"
                    $label2.Text = "Last Name"
                    $label3.Text = "Model Number"
                    $label4.Text = "Room Number"
                }
            }elseif ($selectedValue -eq "Other") {
                $checkbox.Visible = $true
                if ($checkbox.Checked) {
                    $label1.Visible = $false
                    $textBox1.Visible = $false
                    $label2.Visible = $false
                    $textBox2.Visible = $false
                    $label3.Visible = $true
                    $textBox3.Visible = $true
                    $label4.Visible = $true
                    $textBox4.Visible = $true
                    $label5.Visible = $true
                    $textBox5.Visible = $true
                    $label3.Text = "Model Number"
                    $label4.Text = "Room Number"
                    $label5.Text = "Department"
                } else {
                    $label1.Visible = $true
                    $textBox1.Visible = $true
                    $label2.Visible = $true
                    $textBox2.Visible = $true
                    $label3.Visible = $true
                    $textBox3.Visible = $true
                    $label4.Visible = $true
                    $textBox4.Visible = $true
                    $label5.Visible = $true
                    $textBox5.Visible = $true
                    $label1.Text = "First Name"
                    $label2.Text = "Last Name"
                    $label3.Text = "Model Number"
                    $label4.Text = "Room Number"
                    $label5.Text = "Department"
                }
            }elseif ($selectedValue -ne "Storage","Checkout","Other") {
                $checkbox.Visible = $false
                $label1.Visible = $true
                $textBox1.Visible = $true
                $label2.Visible = $true
                $textBox2.Visible = $true
                $label3.Visible = $true
                $textBox3.Visible = $true
                $label4.Visible = $true
                $textBox4.Visible = $true
                $label5.Visible = $false
                $textBox5.Visible = $false
                $label1.Text = "First Name"
                $label2.Text = "Last Name"
                $label3.Text = "Model Number"
                $label4.Text = "Room Number"
            }
            CheckTextBoxes
        }

        $dropdown.Add_SelectedIndexChanged({ UpdateFormLayout })
        $checkbox.Add_CheckedChanged({ UpdateFormLayout })

        $textBox1.Add_TextChanged({ CheckTextBoxes })
        $textBox2.Add_TextChanged({ CheckTextBoxes })
        $textBox3.Add_TextChanged({ CheckTextBoxes })
        $textBox4.Add_TextChanged({ CheckTextBoxes })
        $textBox5.Add_TextChanged({ CheckTextBoxes })

        function CheckTextBoxes {
            $selectedValue = $dropdown.SelectedItem
            if ($selectedValue -in "Storage","Checkout") {
                if ($checkbox.Checked) {
                    $okButton2.Enabled = $textBox3.Text -ne "" -and $textBox4.Text -ne ""
                } else {
                    $okButton2.Enabled = $textBox1.Text -ne "" -and $textBox2.Text -ne "" -and $textBox3.Text -ne "" -and $textBox4.Text -ne ""
                }
            } elseif ($selectedValue -eq "Other") {
                if ($checkbox.Checked) {
                    $okButton2.Enabled = $textBox3.Text -ne "" -and $textBox4.Text -ne "" -and $textBox5.Text -ne ""
                } else {
                    $okButton2.Enabled = $textBox1.Text -ne "" -and $textBox2.Text -ne "" -and $textBox3.Text -ne "" -and $textBox4.Text -ne "" -and $textBox5.Text -ne ""
                }
            } elseif ($selectedValue -ne "Storage","Checkout","Other") {
                $okButton2.Enabled = $textBox1.Text -ne "" -and $textBox2.Text -ne "" -and $textBox3.Text -ne "" -and $textBox4.Text -ne ""
            } else {
                $okButton2.Enabled = $false
            }
        }

        $okButton2.Add_Click({
            $selectedValue =$dropdown.SelectedItem
            $data = @{
                "SelectedValue" = $selectedValue
                "SkipNameFields" = if ($selectedValue -in "Storage","Checkout","Other") { $checkbox.Checked } else { $false }
                "fname" = $textBox1.Text
                "lname" = $textBox2.Text
                "model" = $textBox3.Text
                "room" = $textBox4.Text
                "dept" = $textBox5.Text
                "comp" = $operationSuccess
            }
            if ($data.SkipNameFields -eq $true){
                $data.fname = "Open"
            	if ($data.SelectedValue -eq "Other"){
                	$cmd = "{0}: {1}: {2}: {3}" -f $data.dept, $data.fname, $data.model, $data.room
                } elseif($data.SelectedValue -in "Storage","Checkout") {
                    $cmd = "{0}: {1}: {2}: {3}" -f $data.SelectedValue, $data.fname, $data.model, $data.room
            }
            }else{
                $newName = "{0}, {1}" -f $data.lname, $data.fname
                $cmd = "{0}: {1}: {2}: {3}"-f $data.SelectedValue,$newName,$data.model,$data.room
            }
            $operationResult = runCommand($operationSuccess,$data)
            #$operationResult = PerformOperation($data)
            if ($operationResult) {
                [System.Windows.Forms.MessageBox]::Show("Operation completed successfully!", "Success")
                $form2.Close()
            } else {
                [System.Windows.Forms.MessageBox]::Show("Operation failed.", "Error")
            }
        })

        $form2.ShowDialog()
    }
}
