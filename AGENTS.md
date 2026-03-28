# CharacterDiff Agent Instructions

These instructions apply to all files in this directory and its subdirectories.

## PowerShell Naming Rules

- Include the variable type in the variable name whenever the type is explicitly known.
- Use `str` for strings, for example `strFileA` or `strTextA`.
- Use `int` for integers, for example `intDiff` or `intIndex`.
- Use `arrStr` for string arrays, for example `arrStrLinesA`.
- Use descriptive collection prefixes for other typed collections, for example `hashSetDistinctChars`.

## Implementation Expectations

- Follow this naming convention for all new PowerShell variables.
- When editing existing code, align touched variable names with this convention when it is safe to do so.
- Keep names descriptive and consistent with the existing script style.
