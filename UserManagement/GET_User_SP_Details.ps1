<#
.SYNOPSIS
    Finds all SharePoint Online sites where a specific user exists and exports details to CSV.

.DESCRIPTION
    Connects to the SharePoint Admin Center, enumerates all site collections, and checks each site for the specified user.
    Outputs site URL, user name, email, job title, and department to a CSV file.

.PARAMETER targetUser
    The email address of the user to search for.

.EXAMPLE
    .\Get-UserSharePointSites.ps1 -targetUser "user@domain.com"

.NOTES
    Requires PnP.PowerShell module and SharePoint admin permissions.
#>

param(
    [Parameter(Mandatory)]
    [string]$targetUser
)

# Connect to SharePoint Admin Center
Connect-PnPOnline -Url "https://company-admin.sharepoint.com/" -Interactive

# Get all site collections
$sites = Get-PnPTenantSite

# Prepare output array
$results = @()

foreach ($site in $sites) {
    Connect-PnPOnline -Url $site.Url -Interactive
    $users = Get-PnPUser

    # Filter for the target user
    foreach ($user in $users) {
        if ($user.Email -eq $targetUser) {
            $results += [PSCustomObject]@{
                SiteUrl     = $site.Url
                UserName    = $user.Title
                Email       = $user.Email
                JobTitle    = $user.JobTitle
                Department  = $user.Department
            }
        }
    }
}

# Export to CSV
$results | Export-Csv -Path "UserSiteJobDept.csv" -NoTypeInformation
