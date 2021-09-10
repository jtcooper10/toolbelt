function Test-PythonHost
{
    $PREV_PREFERENCE = $ErrorActionPreference
    $ErrorActionPreference = "stop"

    # Ensure that Python is installed in the environment.
    try {
        if (Get-Command python) {}
    }
    Catch {
        Write-Error "Python 3 must be installed."
        return $false
    }
    Finally {
        $ErrorActionPreference = $PREV_PREFERENCE
    }

    # Ensure environment variable is actually set.
    if ( -Not (Test-Path env:PYTHON_CUSTOM_ENV_ROOT) )
    {
        Write-Error "Environment variable PYTHON_CUSTOM_ENV_ROOT must be set."
        return $false
    }

    return $true
}

function Test-PythonEnv
{
    param(
        [string] $Name
    )

    # Test if whole environment is setup
    if ( -Not (Test-Path $env:PYTHON_CUSTOM_ENV_ROOT))
    {
        Write-Error "No root folder exists at directory $env:PYTHON_CUSTOM_ENV_ROOT"
        return $false
    }

    if ($Name)
    {
        return (Test-Path "$env:PYTHON_CUSTOM_ENV_ROOT/$Name") -and (Test-PythonHost)
    }
    return (Test-PythonHost)
}

function New-PythonEnv
{
    param(
        [Parameter(Mandatory = $true)]
        [String] $Name
    )

    # Ensure environment is properly set up.
    if ( -Not (Test-PythonEnv) )
    {
        return
    }

    $NEW_ENV_PATH = "$env:PYTHON_CUSTOM_ENV_ROOT\$Name"
    # Only create a new environment if it doesn't exist already.
    if ( Test-PythonEnv -Name "$NEW_ENV_PATH" )
    {
        Write-Host "Virtual environment already exists at path: $NEW_ENV_PATH"
    }
    else
    {
        New-Item -Path $env:PYTHON_CUSTOM_ENV_ROOT -ItemType "Directory" -Name "$Name"
        python -m venv "$NEW_ENV_PATH"
        Write-Host "Virtual environment created at path: $NEW_ENV_PATH"
    }
}

function Use-PythonEnv
{
    param(
        [Parameter(Mandatory = $true)]
        [String] $Name
    )

    # Ensure environment is properly set up.
    if ( -Not (Test-PythonEnv) )
    {
        return
    }

    # If the desired environment doesn't exist, print error.
    if ( -Not (Test-PythonEnv -Name "$Name") )
    {
        Write-Error "No environment exists with name: $Name"
        return
    }

    $ENV_ACTIVATE_PATH = "$env:PYTHON_CUSTOM_ENV_ROOT\$Name\Scripts\Activate.ps1"
    & $ENV_ACTIVATE_PATH
    Write-Host "Environment activated at path $ENV_ACTIVATE_PATH"
}

function Remove-PythonEnv
{
    param(
        [Parameter(Mandatory = $true)]
        [string] $Name
    )

    # Ensure environment is properly set up.
    if ( -Not (Test-PythonEnv) )
    {
        return
    }

    # Test if directory exists. If so, remove it.
    $VENV_PATH = "$env:PYTHON_CUSTOM_ENV_ROOT\$Name"
    if ( Test-Path $VENV_PATH)
    {
        Write-Host "Removing environment: $VENV_PATH"
        Remove-Item -Recurse -Force "$VENV_PATH"
        Write-Host "Environment removed: $VENV_PATH"
    }
    else
    {
        Write-Host "Cannot remove environment ${VENV_PATH}: does not exist"
    }
}