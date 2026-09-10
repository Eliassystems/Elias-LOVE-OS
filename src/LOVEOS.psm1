function Invoke-LOVEOS {
    param(
        [Parameter(Mandatory=$true)]
        [pscustomobject]$State
    )

    $reasons = @()
    $standing = 'ADMISSIBLE'

    if ($State.intention_defined -ne $true) {
        $standing = 'WITHHELD'
        $reasons += 'INTENTION_NOT_DEFINED'
    }

    if ($State.human_benefit_preserved -ne $true) {
        $standing = 'WITHHELD'
        $reasons += 'HUMAN_BENEFIT_NOT_PRESERVED'
    }

    if ($State.harm_boundary_respected -ne $true) {
        $standing = 'WITHHELD'
        $reasons += 'HARM_BOUNDARY_VIOLATED'
    }

    if ($State.human_authority_preserved -ne $true) {
        $standing = 'WITHHELD'
        $reasons += 'HUMAN_AUTHORITY_NOT_PRESERVED'
    }

    if ($State.immutable_core_preserved -ne $true) {
        $standing = 'WITHHELD'
        $reasons += 'IMMUTABLE_ETHICAL_CORE_VIOLATED'
    }

    [pscustomobject]@{
        system                 = 'LOVE-OS'
        version                = '1.0'
        immutable_core        = '97%'
        governed_extension    = '3%'
        standing              = $standing
        execution_admissible  = ($standing -eq 'ADMISSIBLE')
        reasons               = $reasons
    }
}

Export-ModuleMember -Function Invoke-LOVEOS
