# Load the required assemblies
Add-Type -AssemblyName System.IO
Add-Type -AssemblyName Microsoft.Office.Interop.Excel

# Create a new instance of Excel.Application
$excel = New-Object -ComObject Excel.Application

# Open the Requirements.xlsx file
$workbook = $excel.Workbooks.Open("C:\Users\10705954\OneDrive - LTIMindtree\Lab Sessions\Terraform\CMA-CGM-Modules\Requirements.xlsx")

# Select the first worksheet
$worksheet = $workbook.Worksheets.Item(1)

# Initialize an empty string to store the terraform.tfvars content
$tfvars_content = "ec2_app = {`r`n"

# Loop through each row in the worksheet
for ($row = 2; $row -le $worksheet.UsedRange.Rows.Count; $row++) {
    # Get the instance name, ami_id, and instance_choice from columns A, B, and C
    $instance_name = $worksheet.Cells.Item($row, 1).Text
    $ami_id = $worksheet.Cells.Item($row, 2).Text
    $instance_choice = $worksheet.Cells.Item($row, 3).Text

    # Add the instance to the terraform.tfvars content
    $tfvars_content += "  `"$instance_name`" = {`r`n"
    $tfvars_content += "    ami_id          = `"$ami_id`"`r`n"
    $tfvars_content += "    instance_choice = `"$instance_choice`"`r`n"
    $tfvars_content += "  }`r`n"
}

# Close the terraform.tfvars content
$tfvars_content += "}`r`n"

# Close the Excel application
$excel.Quit()

# Write the terraform.tfvars content to a file
$tfvars_file = "terraform.tfvars"
$tfvars_content | Out-File -FilePath $tfvars_file -Encoding UTF8

# Output a message to indicate success
Write-Output "Terraform variables file created: $tfvars_file"