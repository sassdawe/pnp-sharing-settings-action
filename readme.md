# pnp-sharing-settings-action

> credit goes to [aakashbhardwaj619](https://github.com/aakashbhardwaj619) as I built this action based on his work.

This action signs in into SharePoint Online and sets the sharing settings for the site collections.

## Inputs

### `SHAREPOINT_ADMIN_URL`

**Required** URL of the SharePoint Admin Site.

### `CLIENT_ID`

**Required** ClientID of the service principal.

### `CLIENT_SECRET`

**Required** ClientSecret of the service principal.

## Outputs



## Example usage

```yaml
uses: actions/pnp-sharing-settings-action@e76147da8e5c81eaf017dede5645551d4b94427b
with:
    SHAREPOINT_ADMIN_URL: 'httpsL//contoso-admin.sharepoint.com'
    CLIENT_ID: ${{ secrets.CLIENT_ID }}
    CLIENT_SECRET: ${{ secrets.CLIENT_SECRET }}
```
