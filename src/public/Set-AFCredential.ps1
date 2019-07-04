function Set-AFCredential {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [Parameter(
            ParameterSetName='Basic'
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $UserId,

        [Parameter(
            ParameterSetName='Basic'
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $Password,

        [Parameter(
            ParameterSetName='AccessToken'
        )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Token,

        [Parameter(
            ParameterSetName='ImportFromDisk'
        )]
        [Switch]
        $ImportFromDisk
    )

    BEGIN {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    PROCESS {
        
        
        switch($PSCmdlet.ParameterSetName){
            "Basic" {
                # $SecPassword = ConvertTo-SecureString $Password -AsPlainText -Force        
                $SecPassword = $Password
            }
            "AccessToken" { 
                $UserId = "AccessToken"
                # $SecPassword = ConvertTo-SecureString $Token -AsPlainText -Force  
                $SecPassword = $Token
            }
        }
        
        # $PSCred = New-Object System.Management.Automation.PsCredential($UserId,$SecPassword)
        $PSCred = @{
            Username = $UserId
            Password = $SecPassword
        }

        
        New-Object -TypeName PSObject -Property (@{ 
            Credential = $PSCred
            CredentialType = $PSCmdlet.ParameterSetName
        }) | ConvertTo-Json | Out-File -FilePath (Get-AFCredentialPath)
    }
    END {
        
    }
}
