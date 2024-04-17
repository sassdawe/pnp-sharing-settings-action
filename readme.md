# PnP PowerShell Sharing Settings as Code V2

This v2 version of the action signs in into SharePoint Online using ACS and sets the sharing settings for the site collections.

If `ALLELSE` is used for any of the settings (but only for **ONE** of them), it will apply that sharing capability to all the rest of the sites which were NOT specified in the other settings. If `null` is used for any of the settings, it will skip that setting.

> !Important: The v2 version is using composite model, and can run on Windows, Linux and MacOS runners. The v1 version is using JavaScript model and can run only on Windows runners.

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
name: PnP PowerShell Sharing Settings as Code
uses: sassdawe/pnp-sharing-settings-action@v2
with:
    SHAREPOINT_ADMIN_URL: 'https://contoso-admin.sharepoint.com'
    CLIENT_ID: ${{ secrets.CLIENT_ID }}
    CLIENT_SECRET: ${{ secrets.CLIENT_SECRET }}
    SHARINGCAPABILITY_DISABLED_SITES: 'ALLELSE'
    SHARINGCAPABILITY_EXTERNALUSERSHARINGONLY_SITES: 'https://contoso.sharepoint.com/, https://contoso.sharepoint.com/sites/Development'
    SHARINGCAPABILITY_EXTERNAUSERANDGUESTSHARING_SITES: 'https://contoso.sharepoint.com/sites/HR, https://contoso.sharepoint.com/sites/bteam, https://contoso.sharepoint.com/sites/ateam'
    SHARINGCAPABILITY_EXISTINGEXTERNALUSERSHARINGONLY_SITES: 'null'
```

## Information how to set up ACS for SharePoint Online

The steps are documented at [PnP PowerShell: Connect-PnPOnline using ClientID and ClientSecret](https://www.sharepointdiary.com/2019/03/connect-pnponline-with-appid-and-appsecret.html)

You can use an Entra ID App as well, but you need to grant it access to SharePoint Online using **step 2** from this ⬆️ blog.
