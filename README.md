# CharacterDiff

The script compares two text files and returns a numeric difference value.

## Usage

```powershell
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode <mode> -strCompare <compare>
```

## Mode Options

- `line`: Compares the files line by line.
- `char`: Compares the files character by character.

## Compare Options

- `set`: Returns the number of distinct lines or distinct characters between both files. This is the default value.
- `pos`: Returns the number of differing positions between both files, either by line position or by character position.

## Examples

```powershell
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode line -strCompare set
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode line -strCompare pos
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode char -strCompare set
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode char -strCompare pos
```
