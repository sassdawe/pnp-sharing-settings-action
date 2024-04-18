# PnP PowerShell Sharing Settings as Code

This action signs in into SharePoint Online using PnP PowerShell and sets the sharing capability for the specified site collections.

> ⚠️ **Important**: There are multiple versions of this action available. Please make sure you are using the correct version for your needs.

## Variants

### Version 1

Version 1 is limited to Windows based GitHub Actions runners and uses the `SharePointPnPPowerShellOnline` module to set the sharing capability for the specified site collections. It uses ACS App-Only authentication to connect to SharePoint Online. You can read more about the specifics in the [readme for version 1](https://github.com/sassdawe/pnp-sharing-settings-action/tree/version-one).

### Version 2

With Version 2 this action has switched to use the `PnP.PowerShell` module and supports all runner OS types: Windows, Linux and macOS as well. It is still using ACS App-Only authentication to connect to SharePoint Online. You can read more about the specifics in the [readme for version 2](https://github.com/sassdawe/pnp-sharing-settings-action/tree/version-two).

### Version 3 (in development)

Version 3 will switch to standard Entra ID app-only authentication to connect to SharePoint Online, and stop relying on ACS App-Only authentication. This will make the action more secure and reliable.

## Usage

The action takes 3 mandatory parameters for sign-in and 4 optional parameters to specify the sharing capability of the site collections. The sites can be specified using their full URLs or with the `ALLELSE` keyword. When `ALLELSE` is used for any of the settings (but only for **ONE** of them), it will apply that sharing capability to all the rest of the sites which were NOT specified in the other three settings. If `null` is used for any of the settings, it will skip that setting.

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

There is no output for this action. 🚩 But keep in mind that the generated logs will contain the specified URLs, and anyone with access the GitHub Actions logs will see which site has which sharing capability enforced. 🚩

## Example usage

```yaml
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
