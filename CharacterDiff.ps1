param(
    [Alias("fileA")]
    [Parameter(Mandatory=$true)]
    [string] $strFileA,

    [Alias("fileB")]
    [Parameter(Mandatory=$true)]
    [string] $strFileB,

    [Alias("mode")]
    [Parameter(Mandatory=$true)]
    [ValidateSet("line","lines","char","pos")]
    [string] $strMode
)


function Get-CharDifference($strFileA, $strFileB) {

    [string] $strTextA = Get-Content $strFileA -Raw
    [string] $strTextB = Get-Content $strFileB -Raw

    $hashSetCharsA = [System.Collections.Generic.HashSet[string]]::new()
    $hashSetCharsB = [System.Collections.Generic.HashSet[string]]::new()

    foreach ($strChar in $strTextA.ToCharArray()) {
        [void] $hashSetCharsA.Add([string] $strChar)
    }

    foreach ($strChar in $strTextB.ToCharArray()) {
        [void] $hashSetCharsB.Add([string] $strChar)
    }

    $hashSetDistinctChars = [System.Collections.Generic.HashSet[string]]::new($hashSetCharsA)
    $hashSetDistinctChars.SymmetricExceptWith($hashSetCharsB)

    return $hashSetDistinctChars.Count
}

function Get-PositionDifference($strFileA, $strFileB) {

    [string] $strTextA = Get-Content $strFileA -Raw
    [string] $strTextB = Get-Content $strFileB -Raw

    [int] $intMax = [Math]::Max($strTextA.Length, $strTextB.Length)
    [int] $intDiff = 0

    for ([int] $intIndex = 0; $intIndex -lt $intMax; $intIndex++) {

        [string] $strCharA = if ($intIndex -lt $strTextA.Length) { [string] $strTextA[$intIndex] } else { "" }
        [string] $strCharB = if ($intIndex -lt $strTextB.Length) { [string] $strTextB[$intIndex] } else { "" }

        if ($strCharA -ne $strCharB) {
            $intDiff++
        }
    }

    return $intDiff
}

function Get-LineDifference($strFileA, $strFileB) {

    [string[]] $arrStrLinesA = Get-Content $strFileA
    [string[]] $arrStrLinesB = Get-Content $strFileB

    $hashSetDistinctLines = [System.Collections.Generic.HashSet[string]]::new($arrStrLinesA)
    $hashSetDistinctLines.SymmetricExceptWith($arrStrLinesB)

    return $hashSetDistinctLines.Count
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

    "pos" {
        Get-PositionDifference $strFileA $strFileB
    }
}
