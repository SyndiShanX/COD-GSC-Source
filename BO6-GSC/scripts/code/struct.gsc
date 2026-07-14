/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
**************************************/

#using scripts\engine\utility;
#namespace struct;

function private event_handler[bootstrap] bootstrap() {
  level.struct_class_names = ["script_agent_noteworthy": [], "variantname": [], "script_vehicleref": [], "script_linkname": [], "script_noteworthy": [], "targetname": [], "target": []];
  init_global_scriptbundles();
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
  } else if(level.struct_filter && ![[level.struct_filter]](struct)) {
    return;
  }

  if(struct.script_noteworthy == "vfx_ambientwar_node") {
    utility::function_d25424f1ac9f1290(struct);
    return;
  }

  utility::addstruct(struct);
}

function private init_global_scriptbundles() {
  level.projectbundle = getprojectscriptbundle();
  level.gamemodebundle = getgamemodescriptbundle();
  level.gametypebundle = getgametypescriptbundle();
  level.mapbundle = getmapscriptbundle();

  if(isDefined(level.gametypebundle.additionalscriptbundles)) {
    level.gametypebundle.var_ae100eea97c7fcc7 = [];

    foreach(bundle in level.gametypebundle.additionalscriptbundles) {
      level.gametypebundle.var_ae100eea97c7fcc7[bundle.var_48cc9bf9fa3db0a] = getscriptbundle(bundle.var_33ebe182767e4f6e);
    }
  }

  utility::flag_set("init_global_scriptbundles");

  if(!isinfrontend()) {
    assert(isDefined(level.projectbundle));
    assert(isDefined(level.gamemodebundle));
  }
}

function dummy() {}