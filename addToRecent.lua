-- This script creates entries for files loaded by mpv in 
-- ~/.local/share/RecentDocuments folders.
-- The script spawns subprocess to get Absolute Path and 
-- mime type of file. Since Lua does not provide any support
-- by default

mputils = require 'mp.utils'

function getAbsPath(path)
	local ret = mputils.subprocess({args = {"readlink","-mn",path}})
	for k,v in pairs(ret) do
		print(k,v)
	end
	if ret.status >= 0 and not ret.error then
		return ret.stdout
	else
		return nil
	end
end

function getMime(path)
	local ret = mputils.subprocess({args = {"file","-b","--mime-type",path}})
	if ret.status >= 0 and not ret.error then
		return string.gsub(ret.stdout,"/","-")
	else
		return ""
	end
end
	
function register_fileLoad(event)
	local path = mp.get_property("path", "")
	local absPath = getAbsPath(path)
	if not absPath then
		print("unable to resolve path.")
		return
	end

	local filePath, fileName = mputils.split_path(absPath)
	local mime=getMime(absPath)
	local desktopfile = getAbsPath(".local/share/RecentDocuments/" .. fileName .. ".desktop")
	local desktop = [[
		[Desktop Entry]
		Icon=_mime
		Name=_fileName
		Type=Link
		URL[$e]=_filePath
		X-KDE-LastOpenedWith=mpv
		]]
	desktop = string.gsub(desktop,"_mime",mime)
	desktop = string.gsub(desktop,"_fileName", fileName)
	desktop = string.gsub(desktop,"_filePath", "file://" .. absPath)
	local file = io.open(desktopfile, "w+")
	print(type(file))
	file:write(desktop)
	file:close()
end

mp.register_event("file-loaded", register_fileLoad)
