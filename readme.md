# PnP PowerShell Sharing Settings as Code

> credit goes to [aakashbhardwaj619](https://github.com/aakashbhardwaj619) as I built this action based on his work.

This action signs in into SharePoint Online using ACS and sets the sharing settings for the site collections.

## Inputs

### `SHAREPOINT_ADMIN_URL`

**Required** URL of the SharePoint Admin Site.

### `CLIENT_ID`

**Required** ClientID of the service principal.

### `CLIENT_SECRET`

**Required** ClientSecret of the service principal.

### `SHARINGCAPABILITY_DISABLED_SITES`

Comma separated list of URLS where to disable sharing capability, could also be "null" to skip this setting, or "ALLELSE" to disable sharing capability on all sites not specified in the other settings.

### `SHARINGCAPABILITY_EXTERNALUSERSHARINGONLY_SITES`

Comma separated list of URLS where to enable sharing capability for external users only, could also be "null" to skip this setting, or "ALLELSE" to enable sharing capability for external users only on all sites not specified in the other settings.

### `SHARINGCAPABILITY_EXTERNAUSERANDGUESTSHARING_SITES`

Comma separated list of URLS where to enable sharing capability for external and guest users, could also be "null" to skip this setting, or "ALLELSE" to enable sharing capability for external and guest users on all sites not specified in the other settings.

### `SHARINGCAPABILITY_EXISTINGEXTERNALUSERSHARINGONLY_SITES`

Comma separated list of URLS where to enable sharing capability for existing external users only, could also be "null" to skip this setting, or "ALLELSE" to enable sharing capability for existing external users only on all sites not specified in the other settings.

## Outputs

There is no output for this action.

## Example usage

```yaml
uses: actions/pnp-sharing-settings-action@e76147da8e5c81eaf017dede5645551d4b94427b
with:
    SHAREPOINT_ADMIN_URL: 'https://contoso-admin.sharepoint.com'
    CLIENT_ID: ${{ secrets.CLIENT_ID }}
    CLIENT_SECRET: ${{ secrets.CLIENT_SECRET }}
    SHARINGCAPABILITY_DISABLED_SITES: 'ALLELSE'
    SHARINGCAPABILITY_EXTERNALUSERSHARINGONLY_SITES: 'https://contoso.sharepoint.com/, https://contoso.sharepoint.com/sites/Development'
    SHARINGCAPABILITY_EXTERNAUSERANDGUESTSHARING_SITES: 'https://contoso.sharepoint.com/sites/HR, https://contoso.sharepoint.com/sites/bteam, https://contoso.sharepoint.com/sites/ateam'
    SHARINGCAPABILITY_EXISTINGEXTERNALUSERSHARINGONLY_SITES: 'null'
```
