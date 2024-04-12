import * as core from '@actions/core';
import { existsSync } from 'fs';
import PowerShellToolRunner from './PowerShellToolRunner';

async function main() {
    try {
        const adminUrl: string = core.getInput("SHAREPOINT_ADMIN_URL", { required: true });
        const clientID: string = core.getInput("CLIENT_ID", { required: true });
        const clientSecret: string = core.getInput("CLIENT_SECRET", { required: true });
//        const appFilePath: string = core.getInput("APP_FILE_PATH", { required: true });
//        const overwrite: string = core.getInput("OVERWRITE", { required: false }) == "true" ? "-Overwrite" : "";
//        const scope: string = core.getInput("SCOPE", { required: false }).toLowerCase() == "site" ? "Site" : "Tenant";
//        const skipFeatureDeployment: string = core.getInput("SKIP_FEATURE_DEPLOYMENT", { required: false }) == "true" ? "-SkipFeatureDeployment" : "";

        //if (!existsSync(appFilePath)) {
        //    throw new Error("Please check if the app file path - APP_FILE_PATH - is correct.");
        //}

        core.info("ℹ️ Starting something...");

        await PowerShellToolRunner.init();

        const script = `$ErrorActionPreference = "Stop";
            $WarningPreference = "SilentlyContinue";
            Install-Module -Name PnP.PowerShell -Force -Verbose -Scope CurrentUser;
            Connect-PnPOnline -Url ${adminUrl} -ClientId ${clientID} -ClientSecret ${clientSecret};
            (Get-PnPConnection).Url | Write-Output;`;

        await PowerShellToolRunner.executePowerShellScriptBlock(script);

        core.info("✅ Something is successful.");
    } catch (err) {
        core.error("🚨 Some error occurred");
        core.setFailed(err);
    }
}

main();