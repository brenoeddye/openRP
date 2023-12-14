# How to Start

first of all create a .vscode folder on root with tasks.json

tasks.json:
```{
    "version": "2.0.0",
    "tasks":
    [
        {
        "label": "build",
        "type": "shell",
        "command": "${workspaceRoot}\\qawno\\pawncc.exe",
        "args": ["'${file}'", "'-D${fileDirname}'", "'-;+'", "'-(+'", "'-d3'"],

        "group":
        {
            "kind": "build",
            "isDefault": true
        },

        "isBackground": false,

        "presentation":
        {
            "reveal": "always",
            "panel": "dedicated"
        },

        "problemMatcher": "$pawncc"
        }
    ]
}```