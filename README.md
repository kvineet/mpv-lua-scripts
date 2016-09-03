#mpv-lua-scritps

Set of Lua scripts I use with MPV.

##autoload.lua
Is taken from [original mpv repository](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua). 

>This script automatically loads playlist entries before and after the the currently played file. It does so by scanning the directory a file is located in when starting playback. It sorts the directory entries alphabetically, and adds entries before and after the current file to the internal playlist.

Sorting method is modified to handle natural sort (e.g. file2.mkv added before file11.mkv etc.)

##addToRecent.lua
Since autoload.lua loads files in playlist and plays them, the files do not appear in recent Documents folder or in jump lists. This script adds .desktop files to ~/.local/share/RecentDocuments to fix this problem. now any file played with mpv will create entry in RecentDocuments.
