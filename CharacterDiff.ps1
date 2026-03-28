param(
    [Alias("fileA")]
    [Parameter(Mandatory=$true)]
    [string] $strFileA,

    [Alias("fileB")]
    [Parameter(Mandatory=$true)]
    [string] $strFileB,

    [Alias("mode")]
    [Parameter(Mandatory=$true)]
    [ValidateSet("line","char")]
    [string] $strMode
)


function Get-LevenshteinDistance($s, $t) {

    [int] $n = $s.Length
    [int] $m = $t.Length

    [int[,]] $d = New-Object 'int[,]' ($n + 1), ($m + 1)

    for ([int] $i = 0; $i -le $n; $i++) { $d[$i,0] = $i }
    for ([int] $j = 0; $j -le $m; $j++) { $d[0,$j] = $j }

    for ($i = 1; $i -le $n; $i++) {
        for ($j = 1; $j -le $m; $j++) {

            [int] $cost = if ($s[$i-1] -eq $t[$j-1]) { 0 } else { 1 }

            $d[$i,$j] = [Math]::Min(
                [Math]::Min(
                    $d[$i-1,$j] + 1,
                    $d[$i,$j-1] + 1
                ),
                $d[$i-1,$j-1] + $cost
            )
        }
    }

    return $d[$n,$m]
}

function Get-CharDifference($strFileA, $strFileB) {

    [string] $textA = Get-Content $strFileA -Raw
    [string] $textB = Get-Content $strFileB -Raw

    return Get-LevenshteinDistance $textA $textB
}

function Get-LineDifference($strFileA, $strFileB) {

    [string[]] $linesA = Get-Content $strFileA
    [string[]] $linesB = Get-Content $strFileB

    [int] $max = [Math]::Max($linesA.Count, $linesB.Count)
    [int] $intDiff = 0

    for ([int]$i = 0; $i -lt $max; $i++) {

        [string] $a = if ($i -lt $linesA.Count) { $linesA[$i] } else { "" }
        [string] $b = if ($i -lt $linesB.Count) { $linesB[$i] } else { "" }

        if ($a -ne $b) {
            $intDiff++
        }
    }

    return $intDiff
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

    "char" {
        Get-CharDifference $strFileA $strFileB
    }
}
