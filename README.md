# SharePoint Enumeration
A tool for assessing unattended URL's of SharePoint which could lead toward potential compromise of SharePoint Account and also may impact data leakage.


# The Code

$domain = "example.com" # replace with your target domain<br>
$vulnUrls = @("/_vti_bin/owssvr.dll", "/_vti_bin/shtml.exe", "/_vti_bin/_vti_aut/author.dll") # list of vulnerable URLs to check <br>
$results = @() # initialize an empty array to store the results <br>

foreach ($url in $vulnUrls) { <br>
    $fullUrl = "https://$domain$url" <br>
    try { <br>
        $response = Invoke-WebRequest $fullUrl -UseBasicParsing -ErrorAction Stop <br>
        $status = $response.StatusCode <br>
    } catch { <br>
        $status = $_.Exception.Response.StatusCode.Value__ <br>
    } <br>
    $result = [PSCustomObject]@{ <br>
        URL = $fullUrl <br>
        Status = $status <br>
    } <br>
    $results += $result <br>
} <br>

$results | Format-Table -AutoSize

# How to Use the Script?
To use this script, open PowerShell ISE or another PowerShell console and paste the code into the console. Replace "example.com" with your target domain and run the script. The script will check each vulnerable URL in the $vulnUrls array for the target domain and report the HTTP status code for each URL.

Please note that this script is for informational purposes only and should not be used to perform any unauthorized actions on a SharePoint site. It is important to obtain proper authorization and follow proper ethical guidelines before testing for vulnerabilities on any system.
