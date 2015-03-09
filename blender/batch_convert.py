# usage:
# 1) drop the plugin in Blender scripts/addons folder
# 2) open Blender
# 3) python console and type
#
# import batch_convert
# batch_convert.convert( "D:\\pathto3dsfilesfolder" )

import bpy, sys, os, glob
import io_scene_3ds.import_3ds
import io_mesh_threejs.export_threejs

def convert( path ) :

	for file in glob.glob( os.path.join( path, "*.3ds" ) ) :
		
		# delete any from stage
		scn = bpy.context.scene
		for ob in scn.objects : 
			scn.objects.unlink( ob )
		
		io_scene_3ds.import_3ds.load_3ds( file, bpy.context )
		
		# break file into pieces
		basename = os.path.basename( file )
		filename, extension = os.path.splitext( basename )
		
		# io_mesh_threejs.		
		io_mesh_threejs.export_threejs.save( scn.objects, bpy.context, os.path.join( path, filename + ".js" ) )
		
	return
