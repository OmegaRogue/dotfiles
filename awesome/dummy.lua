awesome = {}

---Register a new xproperty.
---@param name string THe name of the X11 property.
---@param type "string"|"number"|"boolean" One of "string, "number" or "boolean".
function awesome.register_xproperty (name, type)
	_ = name
	_ = type
end
---Quit awesome.
---@param code integer The exit code to use when exiting.
function awesome.quit (code)
end
---Execute another application, probably a window manager, to replace awesome. 	
function awesome.exec (cmd)
end
---Restart awesome. 	
function awesome.restart ()
end
---Send a signal to a process. 	
---@return boolean
function awesome.kill (pid, sig)
end
---Synchronize with the X11 server. 	
function awesome.sync ()
end
---Translate a GdkPixbuf to a cairo image surface.. 
---@return gears.surface
function awesome.pixbuf_to_surface (pixbuf, path)
end
---Load an image from a given path.
---@return (gears.surface, nil|string)
function awesome.load_image (name)
end
---Set the preferred size for client icons. 	
function awesome.set_preferred_icon_size (size)
end
---Add a global signal.
---@async
function awesome.connect_signal (name, func)
end
---Remove a global signal. 	
function awesome.disconnect_signal (name, func)
end
---Emit a global signal.
---@async
function awesome.emit_signal (name, ...)
end
---Spawn a program. 	
---@return (integer, string, integer, integer, integer)|string)
function awesome.spawn (cmd, use_sn, stdin, stdout, stderr, exit_callback, cmd)
end
---Switch keyboard layout. 	
function awesome.xkb_set_layout_group (num)
end
---Get current layout number. 	
---@return integer
function awesome.xkb_get_layout_group ()
end
---Get layout short names. 
---@return string
function awesome.xkb_get_group_names ()
end
