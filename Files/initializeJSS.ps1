[PSCustomObject]$variables = [PSCustomObject](Get-Content .\variables.json | ConvertFrom-Json)


Write-Host "Physical Path: " $variables.PhysicalPath
Write-Host "HostName " $variables.HostName
Write-Host "Import URL: "$variables.HostName"/sitecore/api/jss/import"
Write-Host "API KEY: " $variables.APIKeyID

#install the sitecore jss CLI

if($variables.isLocal){
    npm install @sitecore-jss/sitecore-jss
}else{
    npm install -g @sitecore-jss/sitecore-jss
}

#install the required variable
if($variables.ClientFramework -eq "nextjs"){
    npm install @sitecore-jss/sitecore-jss-nextjs
}elseif($variables.ClientFramework -eq "react"){
    npm install @sitecore-jss/sitecore-jss-react
}


# #create the app

npx create-sitecore-jss --templates $variables.ClientFramework  --appName $variables.AppName --fetchWith REST --force --yes
cd $variables.AppName
# npm run jss start
npm run jss setup

npm run jss deploy config

npm run jss deploy app

npm run jss start:connected