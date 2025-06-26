
param(
    [string]$appName,
    [string]$resourceGroup,
    [string]$location,
    [string]$sourceFolder = "./site"
)

# Log in to Azure if not already logged in
az account show > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Logging in to Azure..."
    az login
}

# Create the resource group if it does not exist
Write-Host "Creating resource group..."
az group create `
    --name $resourceGroup `
    --location $location `
    --output json

# Create the static web app
Write-Host "Creating Azure Static Web App..."
az staticwebapp create `
    --name $appName `
    --resource-group $resourceGroup `
    --location $location `
    --source $sourceFolder `
    --app-location "/" `
    --output json `
    --sku Free `
    --no-use-github `
    --app-location "/"


Write-Host "Deployment initiated. Please check the Azure Portal for status."
