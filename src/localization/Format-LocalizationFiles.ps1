Set-StrictMode -Latest

$fileList = Get-Content $Env:XLocFileList

$fileList | % {
    $fileName = $_
    $fileContents = Get-Content -Raw $fileName
    $fileContents = $fileContents -replace "`r`n","`n" # use LF, not CRLF
    if (-not $fileContents.EndsWith("`n"))
    {
        $fileContents += "`n" # add a trailing newline
    }
    # this (convert to UTF-8 followed by WriteAllBytes) avoids adding a BOM in Windows PowerShell
    $fileContents = [System.Text.Encoding]::UTF8.GetBytes($fileContents)
    [io.file]::WriteAllBytes($fileName, $fileContents)
}
