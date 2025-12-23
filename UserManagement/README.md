# User Management Scripts

This folder contains PowerShell scripts for managing and reporting on user accounts in SharePoint Online and related systems.

## Scripts

- **GET_User_SP_Details.ps1**  
  Finds all SharePoint Online sites where a specific user exists and exports details to CSV.

## Usage

Each script includes usage instructions in its header.  
To run a script, use:
```powershell
.\GET_User_SP_Details.ps1 -targetUser "user@domain.com"
