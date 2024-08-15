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
$tfvars_content = ""

# Loop through each row in the worksheet
for ($row = 2; $row -le $worksheet.UsedRange.Rows.Count; $row++) {
    # Get the variable name and value from columns A and B
    $variable_name = $worksheet.Cells.Item($row, 1).Text
    $variable_value = $worksheet.Cells.Item($row, 2).Text

    # Add the variable to the terraform.tfvars content
    $tfvars_content += "$variable_name = `"$variable_value`"`r`n"
}

# Close the Excel application
$excel.Quit()

# Write the terraform.tfvars content to a file
$tfvars_file = "terraform.tfvars"
$tfvars_content | Out-File -FilePath $tfvars_file -Encoding UTF8

# Output a message to indicate success
Write-Output "Terraform variables file created: $tfvars_file"