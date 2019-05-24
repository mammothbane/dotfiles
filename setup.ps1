echo "this script *must* be run as administrator or with developer mode"

$files = "vimrc", "gitconfig", "gitignore_global"

foreach ($file in $files) {
    $src = Join-Path -Path $PSScriptRoot -ChildPath $file
    $dest = Join-Path -Path $env:USERPROFILE -ChildPath ".$file"

    New-Item -Path $dest -ItemType SymbolicLink -Value $src
}