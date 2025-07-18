# Toolbox

## Quick Setups

<details>

<summary class="h2">Oh My Posh</summary>

<details>

<summary class="indented-1 h3">Linux</summary>

To install Oh My Posh on Linux, you can use the following command: [source](https://ohmyposh.dev/docs/installation/linux)
```shell
curl -s https://ohmyposh.dev/install.sh | bash -s
```

Appends default config to your shell profile.
```shell
# BASH
curl -s https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.bashrc >> ~/.bashrc
# ZSH
curl -s https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.zshrc >> ~/.zshrc
```
</details>

<details>

<summary class="indented-1 h3">Windows</summary>

<details>

<summary class="indented-2 h4">Install (Required for both)</summary>

Install Oh My Posh using one of the following Options:
#### Microsoft Store:
[![Download From Microsoft Store](https://ohmyposh.dev/img/msstore-light.svg)](https://apps.microsoft.com/detail/xp8k0hkjfrxgck?mode=mini)
<br>
#### Winget:
```powershell pwsh ps ps1 cmd
winget install JanDeDobbeleer.OhMyPosh --source winget --scope user --force
```
#### Manually (PowerShell):
```powershell pwsh ps ps1
Set-ExecutionPolicy Bypass -Scope Process -Force # Allow script execution for this session only
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```
</details>

<details>

<summary class="indented-2 h4">PowerShell</summary>

#### Allow executions if not already allowed
to allow all for the current process:
```powershell pwsh ps ps1
# Allow script execution for this session only
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
```
#### Ensure profile file exists
```powershell pwsh ps ps1
$PROFILE_DIR = Split-Path -Parent $PROFILE
if (-not (Test-Path $PROFILE_DIR)) { New-Item -ItemType Directory -Path $PROFILE_DIR -Force }
if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }
```
#### Add Default Config to PowerShell Profile

```powershell pwsh ps ps1 
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.profile.ps1' -UseBasicParsing |
    Select-Object -ExpandProperty Content |
    Add-Content -Path $PROFILE
```
</details>

<details>

<summary class="indented-2 h4">CMD</summary>

There's no out-of-the-box support for Windows CMD when it comes to custom prompts. There is however a way to do it using [Clink](https://chrisant996.github.io/clink/), which at the same time supercharges your cmd experience. Follow the installation instructions and make sure you select autostart.
#### Install Clink
Install from [Github Releases](https://github.com/chrisant996/clink/releases) (setup.exe) or using winget:
```cmd powershell pwsh ps ps1
winget install clink
```
#### Enable Autorun
Open new cmd window and run:
```cmd
clink autorun install
```

#### Use Oh My Posh with Clink
```cmd
clink config prompt use oh-my-posh
```

#### Set Oh My Posh Theme
```cmd
clink set ohmyposh.theme https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.omp.json
```
</details>

</details>

</details>



## [Oh My Posh](oh-my-posh/README.md)
To try my theme, run the following command in your shell:

```shell bash zsh
eval "$(oh-my-posh init $(ps -p $$ -o comm= 2>/dev/null || basename "$SHELL") --config 'https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.omp.json')"
```

Autoinstallation for linux and macOS: (untested, but should work)
```shell bash zsh
curl -s https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/auto-setup.sh | bash -s
```
