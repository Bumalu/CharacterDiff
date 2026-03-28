param(
    [Alias("fileA")]
    [Parameter(Mandatory=$true)]
    [string] $strFileA,

    [Alias("fileB")]
    [Parameter(Mandatory=$true)]
    [string] $strFileB,

    [Alias("mode")]
    [Parameter(Mandatory=$true)]
    [ValidateSet("line","lines","char")]
    [string] $strMode
)


function Get-CharDifference($strFileA, $strFileB) {

    [string] $textA = Get-Content $strFileA -Raw
    [string] $textB = Get-Content $strFileB -Raw

    $charsA = [System.Collections.Generic.HashSet[string]]::new()
    $charsB = [System.Collections.Generic.HashSet[string]]::new()

    foreach ($char in $textA.ToCharArray()) {
        [void] $charsA.Add([string] $char)
    }

    foreach ($char in $textB.ToCharArray()) {
        [void] $charsB.Add([string] $char)
    }

    $distinctChars = [System.Collections.Generic.HashSet[string]]::new($charsA)
    $distinctChars.SymmetricExceptWith($charsB)

    return $distinctChars.Count
}

function Get-LineDifference($strFileA, $strFileB) {

    [string[]] $linesA = Get-Content $strFileA
    [string[]] $linesB = Get-Content $strFileB

    $distinctLines = [System.Collections.Generic.HashSet[string]]::new($linesA)
    $distinctLines.SymmetricExceptWith($linesB)

    return $distinctLines.Count
}

if (! (Test-Path $strFileA)) {
    Write-Error "File not found: $strFileA"
    exit 1
}

if (! (Test-Path $strFileB)) {
    Write-Error "File not found: $strFileB"
    exit 1
}

switch ($strMode) {

    "line" {
        Get-LineDifference $strFileA $strFileB
    }

    "lines" {
        Get-LineDifference $strFileA $strFileB
    }

    "char" {
        Get-CharDifference $strFileA $strFileB
    }
}
