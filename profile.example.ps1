Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd) -nonewline

    Write-VcsStatus

    if ($GitPromptSettings.EnableWindowTitleOverride) {
        try {
            if ($GitStatus) {
                $Host.UI.RawUI.WindowTitle = [string]::Format($GitPromptSettings.WindowTitleOverrideFormat, $pwd, " [$($GitStatus.Branch)]")
            } else {
                $Host.UI.RawUI.WindowTitle = [string]::Format($GitPromptSettings.WindowTitleOverrideFormat, $pwd, "")
            }
        }
        catch [System.Exception] {
            $GitPromptSettings.EnableWindowTitleOverride = $false
        }
    }
    
    $LASTEXITCODE = $realLASTEXITCODE
    if ($GitPromptSettings.PromptOnNewLine) {
        return "`r`n> "
    }
    else {
        return "> "
    }
}

Enable-GitColors

Pop-Location

Start-SshAgent -Quiet
