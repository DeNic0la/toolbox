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




<style>

:root:not(var(--darkmode)) {
  --indent-unit: 1.5em;
  /* Light mode variables */
  --details-bg: #f9f9f9;
  --details-bg-open: #f0f0f0;
  --details-border: #ccc;
  --details-color: #1F2328;

  --details-nested-bg: #fdfdfd;
}

:root:where(var(--darkmode)),
@media (prefers-color-scheme: dark) :root {
    --details-bg: #1e1e1e;
    --details-bg-open: #2a2a2a;
    --details-border: #444;
    --details-color: #ddd;

    --details-nested-bg: #252525;

}

.h1 {
  margin: .67em 0;
  font-weight: 600;
  padding-bottom: .3em;
  font-size: 2em;
  #border-bottom: 1px solid #3d444db3;
}
.h2 {
  font-weight: 600;
  padding-bottom: .3em;
  font-size: 1.5em;
  /*border-bottom: 1px solid #3d444db3;*/
}
.h3 {
  font-weight: 600;
  font-size: 1.25em;
}
.h4 {
  font-weight: 600;
  font-size: 1em;
}
.indented-1 { margin-left: calc(1 * var(--indent-unit)); }
.indented-2 { margin-left: calc(2 * var(--indent-unit)); }
.indented-3 { margin-left: calc(3 * var(--indent-unit)); }
.indented-4 { margin-left: calc(4 * var(--indent-unit)); }
.indented-5 { margin-left: calc(5 * var(--indent-unit)); }
.indented-6 { margin-left: calc(6 * var(--indent-unit)); }
.indented-7 { margin-left: calc(7 * var(--indent-unit)); }
.indented-8 { margin-left: calc(8 * var(--indent-unit)); }
.indented-9 { margin-left: calc(9 * var(--indent-unit)); }
.indented-10 { margin-left: calc(10 * var(--indent-unit)); }


details {
  border: 1px solid var(--details-border);
  border-radius: 0.5em;
  padding: 0.75em 1em;
  margin: 1em 0;
  background: var(--details-bg);
  color: var(--details-color);
  transition: background 0.3s ease;
}

details[open] {
  background: var(--details-bg-open);
}

summary {
  cursor: pointer;
  position: relative;
}

summary::marker,
summary::-webkit-details-marker {
  transition: transform 0.2s ease;
}
details[open] > summary {
    color: #9198be;
}
/*
details > *:not(summary) {
  margin-left: 1.5em;
}*/


details details {
  margin-top: 0.75em;
  border-color: var(--details-border);
  background: var(--details-nested-bg);
}
</style>
