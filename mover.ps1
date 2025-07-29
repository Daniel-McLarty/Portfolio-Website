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

# Create prod folder if it doesn't exist
$dest = ".\prod"
if (-Not (Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest | Out-Null
}

# Define the files to move (source -> destination)
$files = @{
    ".\src\index.min.html"  = ".\prod\index.html"
    ".\src\styles.min.css"  = ".\prod\styles.css"
    ".\src\script.min.js"   = ".\prod\script.js"
}

foreach ($src in $files.Keys) {
    $destFile = $files[$src]
    if (Test-Path $src) {
        Move-Item -Path $src -Destination $destFile -Force
        Write-Host "Moved $src -> $destFile"
    } else {
        Write-Warning "File not found: $src"
    }
}