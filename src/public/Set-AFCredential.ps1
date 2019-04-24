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
        $Token
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
                $SecPassword = ConvertTo-SecureString $Password -AsPlainText -Force        
            }
            "AccessToken" { 
                $UserId = "AccessToken"
                $SecPassword = ConvertTo-SecureString $Token -AsPlainText -Force  
            }
        }
        
        $PSCred = New-Object System.Management.Automation.PsCredential($UserId,$SecPassword)
        

        
        $script:AFCredential = New-Object -TypeName PSObject -Property (@{ 
            
            Credential = $PSCred
            CredentialType = $PSCmdlet.ParameterSetName
        })
        
    }
    END {
        
    }
}
