from pymol import cmd

def move_down():
    enabled_objs = cmd.get_names("objects",enabled_only=1)
    all_objs = cmd.get_names("objects",enabled_only=0)
    for obj in enabled_objs:
        if 'keep' not in obj:
            cmd.disable(obj)
            last_obj=obj
            for i in range(0,len(all_objs)):
                if all_objs[i] == obj:
                    if i+1 >= len(all_objs):
                        cmd.enable( all_objs[0] )
                    else:
                        cmd.enable( all_objs[i+1] )
    cmd.orient
def move_up():
    enabled_objs = cmd.get_names("objects",enabled_only=1)
    all_objs = cmd.get_names("objects",enabled_only=0)
    for obj in enabled_objs:
        if 'keep' not in obj:
            cmd.disable(obj)
            last_obj=obj
            for i in range(0,len(all_objs)):
                    if all_objs[i] == obj:
                            if i-1 < 0:
                                    cmd.enable( all_objs[-1] )

                            else:
                                    cmd.enable( all_objs[i-1] )



def align_structure():
    all_objs = cmd.get_names("objects",enabled_only=0)
    for i in cmd.get_object_list(): 
        cmd.align( i, all_objs[0] )
        cmd.center( i ,animate=-1)

def gv():
    all_objs = cmd.get_names("objects",enabled_only=0)
    for i in cmd.get_object_list(): 
        cmd.hide("everything", i)
        cmd.show("cartoon", i)
        cmd.set("cartoon_flat_sheets", 0)
        #cmd.show("surface", i)
        cmd.show("lines", i)
        if i != 'peptide_on_target-keep':
            cmd.show("stick", "resname CYS and not name c+n+o")   
        cmd.hide("everything", "symbol H")     
    #cmd.set("surface_cavity_mode", 1)
    #cmd.set("surface_type",2)

def hide_chain_b():
    cmd.hide("everything","chain b")
    cmd.hide("everything","resn hoh")

    
    cmd.orient
cmd.set_key('pgup', move_up)
cmd.set_key('pgdn', move_down)
#
# PG add
#cmd.set_key( 'F1' , make_it_blue, [ "object1" ] )
cmd.set_key('right',gv)#hide_chain_b)
cmd.set_key('left',align_structure)
#cmd.set_key('up', move_up)
#cmd.set_key('down', gv)
#cmd.set_key('left', move_up)
#cmd.set_key('right', move_down)
