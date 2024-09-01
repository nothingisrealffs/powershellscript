# Define the new values for the EXIF tags
$newTags = "New Tags"
$newSubject = "New Subject"
$newDate = "2024:09:01 12:00:00"
$newNotes = "These are new notes."

# Loop through all the images in the current directory
Get-ChildItem -Path . -Filter *.jpg | ForEach-Object {
    $image = $_.FullName
    # Update the EXIF tags
    & exiftool -Keywords="$newTags" -Subject="$newSubject" -DateTimeOriginal="$newDate" -UserComment="$newNotes" "$image"
}
