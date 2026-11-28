class_name OpenOverlayCommand extends Command



@export var overlay_script: Script




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("overlay_script"):
		
		overlay_script = data.overlay_script

	var overlay = UI.get_overlay(overlay_script)

	if overlay:

		UI.add_overlay(overlay)

	result = Result.SUCCESS

	return result