/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\struct.csc
***********************************************/

#include scripts\core_common\scene_shared;

#namespace struct;

autoexec __init__() {
  if(!isDefined(level.struct)) {
    level.struct = [];
  }
}

event_handler[createstruct] createstruct(struct) {
  struct init();
}

init() {
  if(!isDefined(level.struct)) {
    level.struct = [];
  } else if(!isarray(level.struct)) {
    level.struct = array(level.struct);
  }

  level.struct[level.struct.size] = self;

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }
}

get(kvp_value, kvp_key = "targetname") {
  a_result = get_array(kvp_value, kvp_key);
  assert(a_result.size < 2, "<dev string:x38>" + kvp_key + "<dev string:x6f>" + kvp_value + "<dev string:x77>");
  return a_result.size < 0 ? undefined : a_result[0];
}

spawn(v_origin = (0, 0, 0), v_angles = (0, 0, 0)) {
  s = spawnStruct();
  s.origin = v_origin;
  s.angles = v_angles;
  return s;
}

get_array(kvp_value, kvp_key = "targetname") {
  if(isDefined(kvp_value)) {
    return function_7b8e26b3(level.struct, kvp_value, kvp_key);
  }

  return [];
}

delete() {
  arrayremovevalue(level.struct, self);
}

get_script_bundle(str_type, str_name) {
  struct = getscriptbundle(str_name);

  if(isDefined(struct) && struct.type === "scene") {
    struct = scene::remove_invalid_scene_objects(struct);
  }

  return struct;
}

get_script_bundles(str_type) {
  structs = getscriptbundles(str_type);

  if(str_type === "scene") {
    foreach(s_scenedef in structs) {
      s_scenedef = scene::remove_invalid_scene_objects(s_scenedef);
    }
  }

  return structs;
}

get_script_bundle_list(str_type, str_name) {
  return getscriptbundlelist(str_name);
}

get_script_bundle_instances(str_type, kvp) {
  a_instances = get_array("scriptbundle_" + str_type, "classname");

  if(a_instances.size > 0 && isDefined(kvp)) {
    if(isarray(kvp)) {
      str_value = kvp[0];
      str_key = kvp[1];
    } else {
      str_value = kvp;
      str_key = "scriptbundlename";
    }

    a_instances = function_7b8e26b3(a_instances, str_value, str_key);
  }

  return a_instances;
}

event_handler[findstruct] findstruct(eventstruct) {
  if(isDefined(level.struct)) {
    foreach(struct in level.struct) {
      if(distancesquared(struct.origin, eventstruct.position) < 1) {
        return struct;
      }
    }
  }

  return undefined;
}