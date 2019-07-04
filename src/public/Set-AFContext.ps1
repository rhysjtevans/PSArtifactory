function Set-AFContext {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Repository,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $APIUri,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $BaseUri
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
        $Prop = @{ 
            APIUri = $APIUri
            Repository = $Repository
            BaseUri = $BaseUri
        }
        
        $Prop | ConvertTo-Json | Out-File -FilePath (Get-AFContextPath)
    }
    END {

    }
}
