function Get-AFRepository {
    [CmdletBinding(DefaultParameterSetName='Plural')]
    param (
        # Parameter help description
        [Parameter(ParameterSetName='Single')]   
        [String]
        $Key,

        # Parameter help description
        [Parameter(ParameterSetName='Plural')]
        [ValidateSet("local","remote","virtual","distribution")]
        [String]
        $Type
    )
    
    begin {

    }
    
    process {
        
        $Path = "/repositories"

        if($Key){
            $Path += "/$Key"
        }
        if($Type){
            $Path += "?type=$Type"
        }
        (Invoke-AFApi -Path $Path) | % { 
            [PSCustomObject]@{Url = $PSItem.url; Name = $PSItem.key}
            # [Repository]::new($PSItem.key, $PSItem.url)
        }
    }
    
    end {
    }
}


<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet

function Verb-Noun {
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri = 'http://www.microsoft.com/',
                   ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
    Param (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false, 
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,5)]
        [ValidateSet("sun", "moon", "earth")]
        [Alias("p1")] 
        $Param1,
        
        # Param2 help description
        [Parameter(ParameterSetName='Parameter Set 1')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [ValidateScript({$true})]
        [ValidateRange(0,5)]
        [int]
        $Param2,
        
        # Param3 help description
        [Parameter(ParameterSetName='Another Parameter Set')]
        [ValidatePattern("[a-z]*")]
        [ValidateLength(0,15)]
        [String]
        $Param3
    )
    
    begin {
    }
    
    process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            
        }
    }
    
    end {
    }
}

#>