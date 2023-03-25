$domain = "example.sharepoint.com" # replace with your target domain
$vulnUrls = @("/_vti_bin/owssvr.dll", "/_vti_bin/shtml.exe", "/_vti_bin/_vti_aut/author.dll","/_layouts/15/onedrive.aspx", "/personal") # list of vulnerable URLs to check
$results = @() # initialize an empty array to store the results

foreach ($url in $vulnUrls) {
    $fullUrl = "https://$domain$url"
    try {
        $response = Invoke-WebRequest $fullUrl -UseBasicParsing -ErrorAction Stop
        $status = $response.StatusCode
    } catch {
        $status = $_.Exception.Response.StatusCode.Value__
    }
    $result = [PSCustomObject]@{
        URL = $fullUrl
        Status = $status
    }
    $results += $result
}

$results | Format-Table -AutoSize
