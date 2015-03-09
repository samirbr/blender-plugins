# usage:
# 1) drop the file in SketchUp plugin folder
# 2) open SketchUp
# 3) in "Plugins" menu click in "Export Groups"
# 4) type path and format

tool_menu = UI.menu "Tools"
tool_menu.add_item("Export Groups") {

	model = Sketchup.active_model

	# get path to save files
	input = UI.inputbox ["Set path to export file:", "Set file format:"], ["", "3ds"], "Path to Export"

	if input.length > 0 then
		index = 1
		(model.entities).each do |entity| 
			# select all
			selection = model.selection
			
			(model.entities).each do |group| 
				if group != entity then
					selection.add group
				end
			end
			# delete selected
			model.entities.erase_entities selection
			# export
			model.export "#{ input[0] }\\#{ index }.#{ input[1] }"
			# undo delete
			Sketchup.undo
			# clear selection
			selection.clear
			
			index = index + 1
		end			
		#UI.messagebox("Done!")
	end	
}
