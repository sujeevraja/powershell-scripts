$gPaths = (Get-ChildItem -Path ".\Golden\TamilAudioSongs" -Recurse)

$hdPaths = (Get-ChildItem -Path ".\Tamil" -Recurse)

function removeIfDupl($fileObj) {
	foreach ($item in $gPaths) {
		If((($item -is [System.IO.FileInfo]) -and ($fileObj -is [System.IO.FileInfo])) -and
				(($item.Name -match $fileObj.BaseName) -or ($fileObj.BaseName -match $item.Name)) -and
				($item.Extension -eq $fileObj.Extension)) {
			Write-Host "`r`n"
			Write-Host ("phone drive name: " + $fileObj.FullName + " " + ($fileObj.length -as [string]))
			Write-Host ("golden drive name: " + $item.FullName + " " + ($item.length -as [string]))
			Write-Host "`r`n"
			$canDelete = Read-Host "Press n to skip, any other key to delete`r`n"
			If ($canDelete -ne "n") {
				If($item.length -ge $fileObj.length) {
					Write-Host "deleting " + $fileObj.FullName
					rm $fileObj.FullName
					Write-Host "deleted"
				}
				Else {
					Write-Host "deleting " + $item.FullName
					$dstPath = (Split-Path $item.FullName)
					rm $item.FullName
					Write-Host "moving " + $fileObj.FullName + " to " + $dstPath
					mv $fileObj.FullName $dstPath
				}
			}
			break
		}
	}
	#return $FALSE
}

foreach ($obj in $hdPaths) {
	(removeIfDupl -fileObj $obj)
}

