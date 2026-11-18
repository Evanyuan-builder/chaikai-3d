# blender -b -P preview_bl.py -- in.glb out.png
import bpy, sys, mathutils, math
a = sys.argv[sys.argv.index("--")+1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=a[0])
objs=[o for o in bpy.context.scene.objects if o.type=='MESH']
mn=mathutils.Vector((1e9,)*3); mx=-mn
for o in objs:
    for c in o.bound_box:
        w=o.matrix_world@mathutils.Vector(c); mn=mathutils.Vector(map(min,mn,w)); mx=mathutils.Vector(map(max,mx,w))
ctr=(mn+mx)/2; size=(mx-mn).length
cam=bpy.data.objects.new("cam",bpy.data.cameras.new("cam")); bpy.context.scene.collection.objects.link(cam)
d=size*1.3; cam.location=ctr+mathutils.Vector((d*0.7,-d*0.7,d*0.5))
cam.rotation_euler=(ctr-cam.location).to_track_quat('-Z','Y').to_euler()
bpy.context.scene.camera=cam
for loc,e in [((3,-3,5),3),((-4,2,3),1.5)]:
    l=bpy.data.objects.new("l",bpy.data.lights.new("l",'SUN')); l.data.energy=e; l.rotation_euler=(mathutils.Vector(loc)).to_track_quat('Z','Y').to_euler(); bpy.context.scene.collection.objects.link(l)
w=bpy.data.worlds.new("w"); w.use_nodes=True; w.node_tree.nodes["Background"].inputs[0].default_value=(0.95,0.95,0.96,1); w.node_tree.nodes["Background"].inputs[1].default_value=0.8
bpy.context.scene.world=w
s=bpy.context.scene; s.render.engine='BLENDER_EEVEE_NEXT' if 'BLENDER_EEVEE_NEXT' in [e.identifier for e in bpy.types.RenderSettings.bl_rna.properties['engine'].enum_items] else 'BLENDER_EEVEE'
s.render.resolution_x=s.render.resolution_y=512; s.render.filepath=a[1]
bpy.ops.render.render(write_still=True)
print("DIMS", tuple(round(x,3) for x in (mx-mn)))
