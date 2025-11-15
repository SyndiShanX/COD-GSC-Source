/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\struct.gsc
***********************************************/

#namespace struct;

autoexec __init__() {
  if(!isDefined(level.struct)) {
    level.struct = [];
  }

  if(!isDefined(level.struct_class_names)) {
    level.struct_class_names = [];
    level.struct_class_names[level.struct_class_names.size] = "target";
    level.struct_class_names[level.struct_class_names.size] = "targetname";
    level.struct_class_names[level.struct_class_names.size] = "script_noteworthy";
    level.struct_class_names[level.struct_class_names.size] = "classname";
    level.struct_class_names[level.struct_class_names.size] = "variantname";
    level.struct_class_names[level.struct_class_names.size] = "script_unitrigger_type";
    level.struct_class_names[level.struct_class_names.size] = "scriptbundlename";
    level.struct_class_names[level.struct_class_names.size] = "prefabname";
    level.struct_class_names[level.struct_class_names.size] = "script_igc_teleport_location";

    foreach(str_key in level.struct_class_names) {
      level.var_77fe0a41[str_key] = [];
    }
  }

  level.struct_class_names = undefined;
  level.var_77fe0a41 = undefined;
}

event_handler[createstruct] createstruct(struct) {
  __init__();
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

  if(isDefined(level.struct_class_names)) {
    foreach(str_key in level.struct_class_names) {
      if(isDefined(self.(str_key))) {
        if(!isDefined(level.var_77fe0a41[str_key][self.(str_key)])) {
          level.var_77fe0a41[str_key][self.(str_key)] = [];
        } else if(!isarray(level.var_77fe0a41[str_key][self.(str_key)])) {
          level.var_77fe0a41[str_key][self.(str_key)] = array(level.var_77fe0a41[str_key][self.(str_key)]);
        }

        level.var_77fe0a41[str_key][self.(str_key)][level.var_77fe0a41[str_key][self.(str_key)].size] = self;
      }
    }
  }
}

get(kvp_value, kvp_key = "targetname") {
  a_result = get_array(kvp_value, kvp_key);
  assert(a_result.size < 2, "<dev string:x38>" + (isDefined(kvp_key) ? "<dev string:x6f>" + kvp_key : "<dev string:x6f>") + "<dev string:x72>" + (isDefined(kvp_value) ? "<dev string:x6f>" + kvp_value : "<dev string:x6f>") + "<dev string:x7a>");
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
    if(isDefined(level.var_77fe0a41) && isDefined(level.var_77fe0a41[kvp_key])) {
      if(isDefined(level.var_77fe0a41[kvp_key][kvp_value])) {
        return arraycopy(level.var_77fe0a41[kvp_key][kvp_value]);
      }
    } else {
      return function_7b8e26b3(level.struct, kvp_value, kvp_key);
    }
  }

  return [];
}

delete() {
  if(isDefined(level.struct_class_names)) {
    foreach(str_key in level.struct_class_names) {
      if(isDefined(self.(str_key))) {
        arrayremovevalue(level.var_77fe0a41[str_key][self.(str_key)], self);
      }
    }
  }

  arrayremovevalue(level.struct, self);
}

get_script_bundle(str_type, str_name) {
  struct = getscriptbundle(str_name);
  return struct;
}

get_script_bundles(str_type) {
  structs = getscriptbundles(str_type);
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

event_handler[findstruct] findstruct(param1, name, index) {
  if(isvec(param1)) {
    position = param1;

    foreach(key in level.struct_class_names) {
      foreach(s_array in level.var_77fe0a41[key]) {
        foreach(struct in s_array) {
          if(distancesquared(struct.origin, position) < 1) {
            return struct;
          }
        }
      }
    }

    if(isDefined(level.struct)) {
      foreach(struct in level.struct) {
        if(distancesquared(struct.origin, position) < 1) {
          return struct;
        }
      }
    }
  } else {
    s = get(param1);

    if(isDefined(s)) {
      return s;
    }

    s = get_script_bundle(param1, name);

    if(isDefined(s)) {
      if(index < 0) {
        return s;
      } else if(isDefined(s.objects)) {
        return s.objects[index];
      }
    }
  }

  return undefined;
}