<#
MIT License

Copyright (c) 2025 Daniel McLarty

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

#Set the prod directory and prod/assets directory
$prodDir = ".\prod"
$prodAssetsDir = Join-Path $prodDir "assets"

# Remove prod directory if it exists to start clean
if (Test-Path $prodDir) {
    Remove-Item -Path $prodDir -Recurse -Force
    Write-Host "Deleted existing $prodDir folder to start fresh."
}

# Recreate prod and prod\assets folders
New-Item -ItemType Directory -Path $prodDir | Out-Null
New-Item -ItemType Directory -Path $prodAssetsDir | Out-Null

# Copy all .min.* files from src to prod, renaming to strip ".min"
Get-ChildItem -Path .\src\ -Filter "*.min.*" | ForEach-Object {
    $srcPath = $_.FullName
    $filename = $_.Name -replace '\.min(?=\.)', ''  # Remove .min before extension
    $destPath = Join-Path $prodDir $filename

    Copy-Item -Path $srcPath -Destination $destPath -Force
    Write-Host "Copied $srcPath -> $destPath"
}

# Copy all assets from src\assets to prod\assets
$srcAssets = ".\src\assets"
if (Test-Path $srcAssets) {
    Copy-Item -Path "$srcAssets\*" -Destination $prodAssetsDir -Recurse -Force
    Write-Host "Copied assets -> $prodAssetsDir"
} else {
    Write-Warning "Assets folder not found: $srcAssets"
}

# Copy robots.txt and sitemap.xml from src to prod (if they exist)
$filesToMove = @("robots.txt", "sitemap.xml")
foreach ($file in $filesToMove) {
    $srcFile = Join-Path ".\src" $file
    $destFile = Join-Path $prodDir $file
    if (Test-Path $srcFile) {
        Copy-Item -Path $srcFile -Destination $destFile -Force
        Write-Host "Copied $srcFile -> $destFile"
    } else {
        Write-Warning "$file not found in src directory."
    }
}
