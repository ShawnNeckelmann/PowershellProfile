Write-Host 'Loading files from $PSScriptRoot at' $PSScriptRoot -ForegroundColor Yellow -BackgroundColor Green
Write-Host 'Execute code $PROFILE -n to modify the startup profile' -ForegroundColor Yellow -BackgroundColor Red
Write-Host 'Execute Get-PSReadLineKeyHandler to see key bindings' -ForegroundColor Green -BackgroundColor Black
Write-Host 'cd ~\AppData\Local\nvim for nvim configuration' -ForegroundColor Green -BackgroundColor Black

Set-Alias g git
Set-Alias cg Get-Clipboard
Set-Alias k kubectl
Set-Alias ss Select-String
Set-Alias cls Clear-Host
Set-Alias dcu DockerComposeUpDetached
Set-Alias dcd DockerComposeDown
Set-Alias omp oh-my-posh
Set-Alias http curlie

Set-PSReadLineOption -PredictionViewStyle ListView -PromptText '> ', 'X '

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module posh-git
Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config $PSScriptRoot\MyModules\ohmyposh\neckelmann.omp.json | Invoke-Expression
$env:POSH_GIT_ENABLED = $true

Import-Module -Name $PSScriptRoot\MyModules\autocomplete\azcli-autocomplete.psm1
Import-Module -Name $PSScriptRoot\MyModules\autocomplete\ghcli-autocomplete.psm1
Import-Module -Name $PSScriptRoot\MyModules\autocomplete\kubectl-autocomplete.psm1
Import-Module -Name $PSScriptRoot\MyModules\autocomplete\helm-autocomplete.psm1
Import-Module -Name $PSScriptRoot\MyModules\autocomplete\winget-autocomplete.psm1
Import-Module -Name $PSScriptRoot\MyModules\autocomplete\dotnetcli-autocomplete.psm1


function rprof {
    clear
    & $profile
}

function gwip {
    g add .
    g c -m "Work i progress..."
    g push
}

function gsync {
    Get-ChildItem -Directory | ForEach-Object {
        Write-Host "`nGetting latest for $_..." -ForegroundColor Green
        git -C $_.FullName pull --all --verbose
        git -C $_.FullName fetch --all --verbose --prune
    }
}

function reset4stat {
    git rm --cached -r .
    git reset --hard
}