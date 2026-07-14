/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\code\struct.csc
**************************************/

#namespace struct;

function private event_handler[bootstrap] bootstrap() {
  level.struct_class_names = ["script_agent_noteworthy": [], "variantname": [], "script_vehicleref": [], "script_linkname": [], "script_noteworthy": [], "targetname": [], "target": []];
}

function private event_handler[spawnstruct] spawn_struct(struct) {
  if(struct.var_cadb121fd1be05b0 || struct.targetname == "delete_on_load") {
    return;
  }

  if(level.create_script && struct.var_a55b0b7889573538) {
    return;
  }

  if(level.struct_filter_override && ![[level.struct_filter_override]](struct)) {
    return;
  }

  if(level.struct_filter && ![[level.struct_filter]](struct)) {
    return;
  }
}