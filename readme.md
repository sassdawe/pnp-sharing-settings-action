# PnP PowerShell Sharing Settings as Code

> credit goes to [aakashbhardwaj619](https://github.com/aakashbhardwaj619) as I built this action based on his work.

This action signs in into SharePoint Online using ACS and sets the sharing settings for the site collections.

If `ALLELSE` is used for any of the settings (but only for **ONE** of them), it will apply that sharing capability to all the rest of the sites which were NOT specified in the other settings. If `null` is used for any of the settings, it will skip that setting.

> !Important: The v1 version requires the use of **Windows** based runners to run this action currently.

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
uses: actions/pnp-sharing-settings-action@v1
with:
    SHAREPOINT_ADMIN_URL: 'https://contoso-admin.sharepoint.com'
    CLIENT_ID: ${{ secrets.CLIENT_ID }}
    CLIENT_SECRET: ${{ secrets.CLIENT_SECRET }}
    SHARINGCAPABILITY_DISABLED_SITES: 'ALLELSE'
    SHARINGCAPABILITY_EXTERNALUSERSHARINGONLY_SITES: 'https://contoso.sharepoint.com/, https://contoso.sharepoint.com/sites/Development'
    SHARINGCAPABILITY_EXTERNAUSERANDGUESTSHARING_SITES: 'https://contoso.sharepoint.com/sites/HR, https://contoso.sharepoint.com/sites/bteam, https://contoso.sharepoint.com/sites/ateam'
    SHARINGCAPABILITY_EXISTINGEXTERNALUSERSHARINGONLY_SITES: 'null'
```
