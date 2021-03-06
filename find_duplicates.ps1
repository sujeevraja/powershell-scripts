# Get list of all music files sorted by file type and name.
# ? is the filter operator. It removes items in the list before | that do not satisfy the condition with {}.
# $_ is a variable that denotes the current item being processed by the ? operator.
# PSIsContainer is true for folders and false for files.
# Sort-Object sorts the list before | based on the given properties (Extension and Name in this case).
# Each item provided to Sort-Object is expected to have the given properties.

$files = (Get-ChildItem -Path "." -Recurse) | ?{-not $_.PSIsContainer} | Sort-Object Name, Extension
if($files -eq $null) {
    Write-Host "no files found."
    Exit
}

$numFiles = $files.Count
$numDuplicates = 0
$uniqueFiles = @() # create empty array
$uniqueFiles += $files[0] # += appends element to array

for($i = 1; $i -lt $numFiles - 1; $i++) {
    $curr = $uniqueFiles[-1];
    $next = $files[$i];
    if ($curr.Name -eq $next.Name -and $curr.length -eq $next.length) { # Name gives the name of the file, length gives file size.
        Write-Host $curr.FullName # FullName gives the name of the file including the path
        Write-Host $next.FullName
        $numDuplicates++;
        
        Write-Host "removing " + $next.FullName
        rm $next.FullName
        Write-Host "`r`n"
    } else {
        $uniqueFiles += $next
    }
}

Write-Host "Num duplicates:"
Write-Host $numDuplicates
Write-Host "All done!"