
# Powershell System Specs

A simple powershell file that can be executed in a single line outputting PC system specs. 


## Execution
Open a powershell session with administration privileges, then copy the following script. It'll open the file from this repo and will output basic system informations as well as TPM, seucreboot and Windows Defender status.

Copy and paste the following script in a elevated powershell: 
```bash
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Dogino/Powershell-System-Specs/main/specs.ps1'))
```