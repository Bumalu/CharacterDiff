# CharacterDiff

The script compares two text files and returns a numeric difference value.

## Usage

```powershell
.\CharacterDiff.ps1 -strFileA .\testA.txt -strFileB .\testB.txt -strMode <mode>
```

## Options

- `line` or `lines`: Returns the number of distinct lines between both files.
- `char`: Returns the number of distinct characters between both files, based on the set of characters used in each file.
- `pos`: Returns the number of character positions that differ between both files.
