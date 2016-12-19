# Get list of all music files sorted by file type and name.
# ? is the filter operator. It removes items in the list before | that do not satisfy the condition with {}.
# $_ is a variable that denotes the current item being processed by the ? operator.
# PSIsContainer is true for folders and false for files.
# Sort-Object sorts the list before | based on the given properties (Extension and Name in this case).
# Each item provided to Sort-Object is expected to have the given properties.

$files = (Get-ChildItem -Path "." -Recurse) | ?{-not $_.PSIsContainer} | Sort-Object Name, Extension

# Store the number of files
$numFiles = $files.Count

# Compare successive items in the sorted list by file name and size.
# Output item paths if they have duplicates.
for($i = 0; $i -lt $numFiles - 1; $i++) {
    $curr = $files[$i]
    $next = $files[$i + 1]
    if ($curr.Name -eq $next.Name -and $curr.length -eq $next.length) { # Name gives the name of the file
        Write-Host $curr.FullName # FullName gives the name of the file including the path
        Write-Host $next.FullName
        Write-Host "`r`n"
        
        # un-comment the following lines to delete the file at $curr
        # rm $curr.FullName
        
        # un-comment the following lines to delete the file at $next
        # rm $next.FullName
    }
}

Write-Host "All done!"