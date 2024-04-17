
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $adminUrl,
    [Parameter(Mandatory = $true)]
    [string] $clientID,
    [Parameter(Mandatory = $true)]
    [string] $clientSecret,
    [Parameter(Mandatory = $false)]
    [string] $sharingCapabilityDisabled,
    [Parameter(Mandatory = $false)]
    [string] $sharingCapabilityExternalUserSharingOnly,
    [Parameter(Mandatory = $false)]
    [string] $sharingCapabilityExternalUserAndGuestSharing,
    [Parameter(Mandatory = $false)]
    [string] $sharingCapabilityExistingExternalUserSharingOnly
)

$ErrorActionPreference = "Stop";
$WarningPreference = "SilentlyContinue";

# ${{ inputs.Icons }}

$sharingCapabilityDisabledSites = if ( 'null' -ne $sharingCapabilityDisabled ) { $sharingCapabilityDisabled.Split(",").Trim().TrimEnd('/').ToLower() } else { @() };
"To Disable site count: $($sharingCapabilityDisabledSites.count)" | Write-Output;

$sharingCapabilityExternalUserSharingOnlySites = if ( 'null' -ne $sharingCapabilityExternalUserSharingOnly ) { $sharingCapabilityExternalUserSharingOnly.Split(",").Trim().TrimEnd('/').ToLower() } else { @() };
"To ExternalUserSharingOnly site count: $($sharingCapabilityExternalUserSharingOnlySites.count)" | Write-Output;

$sharingCapabilityExternalUserAndGuestSharingSites = if ( 'null' -ne $sharingCapabilityExternalUserAndGuestSharing ) { $sharingCapabilityExternalUserAndGuestSharing.Split(",").Trim().TrimEnd('/').ToLower() } else { @() };
"To ExternalAndGuestSharing site count: $($sharingCapabilityExternalUserAndGuestSharingSites.count)" | Write-Output;

$sharingCapabilityExistingExternalUserSharingOnlySites = if ( 'null' -ne $sharingCapabilityExistingExternalUserSharingOnly ) { $sharingCapabilityExistingExternalUserSharingOnly.Split(",").Trim().TrimEnd('/').ToLower() } else { @() };
"To ExistingExternalUserSharingOnly site count: $($sharingCapabilityExistingExternalUserSharingOnlySites.count)" | Write-Output;

$sharingOrderOfPrecedence = New-Object 'System.Collections.Specialized.OrderedDictionary';
$sharingOrderOfPrecedence.Add('ExternalUserAndGuestSharing', $sharingCapabilityExternalUserAndGuestSharingSites);
$sharingOrderOfPrecedence.Add('ExternalUserSharingOnly', $sharingCapabilityExternalUserSharingOnlySites);
$sharingOrderOfPrecedence.Add('ExistingExternalUserSharingOnly', $sharingCapabilityExistingExternalUserSharingOnlySites);
$sharingOrderOfPrecedence.Add('Disabled', $sharingCapabilityDisabledSites);

foreach ($sites in ($sharingOrderOfPrecedence.Values.GetEnumerator())) {
    $sites.count | Write-Output;
}

# Now lets check that only one parameter contains 'ALLELSE', and make sure that one will get executed last.
$allCount = 0;

if ($sharingCapabilityDisabledSites -icontains 'ALLELSE') {
    $allCount++; $allElse = 'Disabled';
    $sharingOrderOfPrecedence.Remove('Disabled')
}
if ($sharingCapabilityExternalUserSharingOnlySites -icontains 'ALLELSE') {
    $allCount++; $allElse = 'ExternalUserSharingOnly';
    $sharingOrderOfPrecedence.Remove('ExternalUserSharingOnly')
}
if ($sharingCapabilityExternalUserAndGuestSharingSites -icontains 'ALLELSE') {
    $allCount++; $allElse = 'ExternalUserAndGuestSharing';
    $sharingOrderOfPrecedence.Remove('ExternalUserAndGuestSharing')
}
if ($sharingCapabilityExistingExternalUserSharingOnlySites -icontains 'ALLELSE') {
    $allCount++; $allElse = 'ExistingExternalUserSharingOnly';
    $sharingOrderOfPrecedence.Remove('ExistingExternalUserSharingOnly')
}

if ($allCount -le 1) {
    Write-Output "✅ Only one parameter contains 'ALLELSE'";
    Write-Output "🚩 All else: $allElse";
}
else {
    Throw "More than one parameter contains 'ALLELSE' this is not allowed, make sure that maximum only one parameter contains 'ALLELSE'"
}

Import-Module ".\Modules\PnP.PowerShell\2.4.0\PnP.PowerShell.psd1" -Force;
Connect-PnPOnline -Url ${adminUrl} -ClientId ${clientID} -ClientSecret ${clientSecret};
Get-PnPTenantSite | Format-Table Url, Template, LocaleId, SharingCapability | Write-Output;

$sitesAsSet = New-Object System.Collections.Generic.HashSet[string]
Get-PnPTenantSite | ForEach-Object { $null = $sitesAsSet.add( $_.url.ToLower().TrimEnd('/') ) }
Write-Output "All sites count: $($sitesAsSet.count)";

Write-Output "🚀 Start to update the sharing capability for the sites";

foreach ($sharingCapability in $sharingOrderOfPrecedence.GetEnumerator()) {
    $sharingCapabilityName = $sharingCapability.Key;
    $sites = $sharingCapability.Value;
    if ($null -ne $sites -and $sites.Count -gt 0) {
        Write-Output "🚀 Start to update the sharing capability for the sites with sharing capability: $sharingCapabilityName";
        foreach ($site in $sites) {
            Write-Output "🚀🚀 Start to update the sharing capability for the site: $site";
            Set-PnPTenantSite -Url $site -SharingCapability $sharingCapabilityName -ErrorAction Continue;
            $null = $sitesAsSet.Remove($site);
            Write-Output "✅ Sharing capability updated for the site: $site";
        }
    }
}

if ($allCount -eq 1) {
    # Get All sites, and filter out the sites that are already updated.
    Write-Output "Remaining sites to update: $($sitesAsSet.count)";
    foreach ($site in $sitesAsSet) {
        Write-Output "🚀🚀 Start to update the sharing capability for the site: $site";
        Set-PnPTenantSite -Url $site -SharingCapability $allElse -ErrorAction Continue;
        Write-Output "✅ Sharing capability updated for the site: $site";
    }
}

Write-Output "✅ All sites are updated successfully";
Get-PnPTenantSite | Format-Table Url, Template, LocaleId, SharingCapability | Write-Output;
