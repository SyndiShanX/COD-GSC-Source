/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: codescripts\struct.csc
*************************************************/

#using scripts\shared\scene_shared;
#namespace struct;

function autoexec __init__() {
  if(!isDefined(level.struct)) {
    init_structs();
  }
}

function init_structs() {
  level.struct = [];
  level.scriptbundles = [];
  level.scriptbundlelists = [];
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];
  level.struct_class_names["script_label"] = [];
  level.struct_class_names["classname"] = [];
  level.struct_class_names["script_unitrigger_type"] = [];
  level.struct_class_names["scriptbundlename"] = [];
}

function remove_unneeded_kvps(struct) {
  struct.igdtseqnum = undefined;
  struct.configstringfiletype = undefined;
  devstate = struct.devstate;
  struct.devstate = undefined;
  struct.devstate = devstate;
}

function createstruct(struct, type, name) {
  if(!isDefined(level.struct)) {
    init_structs();
  }
  if(isDefined(type)) {
    isfrontend = getdvarstring("mapname") == "core_frontend";
    if(!isDefined(level.scriptbundles[type])) {
      level.scriptbundles[type] = [];
    }
    if(isDefined(level.scriptbundles[type][name])) {
      return level.scriptbundles[type][name];
    }
    if(type == "scene") {
      level.scriptbundles[type][name] = scene::remove_invalid_scene_objects(struct);
    } else {
      if(!(sessionmodeismultiplayergame() || isfrontend) && type == "mpdialog_player") {} else {
        if(!(sessionmodeismultiplayergame() || isfrontend) && type == "gibcharacterdef" && issubstr(name, "c_t7_mp_")) {} else {
          if(!(sessionmodeiscampaigngame() || isfrontend) && type == "collectibles") {} else {
            level.scriptbundles[type][name] = struct;
          }
        }
      }
    }
    remove_unneeded_kvps(struct);
  } else {
    struct init();
  }
}

function createscriptbundlelist(items, type, name) {
  if(!isDefined(level.struct)) {
    init_structs();
  }
  level.scriptbundlelists[type][name] = items;
}

function init() {
  if(!isDefined(level.struct)) {
    level.struct = [];
  } else if(!isarray(level.struct)) {
    level.struct = array(level.struct);
  }
  level.struct[level.struct.size] = self;
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }
  if(isDefined(self.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][self.targetname])) {
      level.struct_class_names["targetname"][self.targetname] = [];
    } else if(!isarray(level.struct_class_names["targetname"][self.targetname])) {
      level.struct_class_names["targetname"][self.targetname] = array(level.struct_class_names["targetname"][self.targetname]);
    }
    level.struct_class_names["targetname"][self.targetname][level.struct_class_names["targetname"][self.targetname].size] = self;
  }
  if(isDefined(self.target)) {
    if(!isDefined(level.struct_class_names["target"][self.target])) {
      level.struct_class_names["target"][self.target] = [];
    } else if(!isarray(level.struct_class_names["target"][self.target])) {
      level.struct_class_names["target"][self.target] = array(level.struct_class_names["target"][self.target]);
    }
    level.struct_class_names["target"][self.target][level.struct_class_names["target"][self.target].size] = self;
  }
  if(isDefined(self.script_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_noteworthy"][self.script_noteworthy])) {
      level.struct_class_names["script_noteworthy"][self.script_noteworthy] = [];
    } else if(!isarray(level.struct_class_names["script_noteworthy"][self.script_noteworthy])) {
      level.struct_class_names["script_noteworthy"][self.script_noteworthy] = array(level.struct_class_names["script_noteworthy"][self.script_noteworthy]);
    }
    level.struct_class_names["script_noteworthy"][self.script_noteworthy][level.struct_class_names["script_noteworthy"][self.script_noteworthy].size] = self;
  }
  if(isDefined(self.script_linkname)) {
    assert(!isDefined(level.struct_class_names[""][self.script_linkname]), "");
    level.struct_class_names["script_linkname"][self.script_linkname][0] = self;
  }
  if(isDefined(self.script_label)) {
    if(!isDefined(level.struct_class_names["script_label"][self.script_label])) {
      level.struct_class_names["script_label"][self.script_label] = [];
    } else if(!isarray(level.struct_class_names["script_label"][self.script_label])) {
      level.struct_class_names["script_label"][self.script_label] = array(level.struct_class_names["script_label"][self.script_label]);
    }
    level.struct_class_names["script_label"][self.script_label][level.struct_class_names["script_label"][self.script_label].size] = self;
  }
  if(isDefined(self.classname)) {
    if(!isDefined(level.struct_class_names["classname"][self.classname])) {
      level.struct_class_names["classname"][self.classname] = [];
    } else if(!isarray(level.struct_class_names["classname"][self.classname])) {
      level.struct_class_names["classname"][self.classname] = array(level.struct_class_names["classname"][self.classname]);
    }
    level.struct_class_names["classname"][self.classname][level.struct_class_names["classname"][self.classname].size] = self;
  }
  if(isDefined(self.script_unitrigger_type)) {
    if(!isDefined(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type])) {
      level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type] = [];
    } else if(!isarray(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type])) {
      level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type] = array(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type]);
    }
    level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type][level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type].size] = self;
  }
  if(isDefined(self.scriptbundlename)) {
    if(!isDefined(level.struct_class_names["scriptbundlename"][self.scriptbundlename])) {
      level.struct_class_names["scriptbundlename"][self.scriptbundlename] = [];
    } else if(!isarray(level.struct_class_names["scriptbundlename"][self.scriptbundlename])) {
      level.struct_class_names["scriptbundlename"][self.scriptbundlename] = array(level.struct_class_names["scriptbundlename"][self.scriptbundlename]);
    }
    level.struct_class_names["scriptbundlename"][self.scriptbundlename][level.struct_class_names["scriptbundlename"][self.scriptbundlename].size] = self;
  }
}

function get(kvp_value, kvp_key = "targetname") {
  if(!isDefined(kvp_value)) {
    return undefined;
  }
  if(isDefined(level.struct_class_names[kvp_key][kvp_value])) {
    if(level.struct_class_names[kvp_key][kvp_value].size > 1) {
      assertmsg(((("" + kvp_key) + "") + kvp_value) + "");
      return undefined;
    }
    return level.struct_class_names[kvp_key][kvp_value][0];
  }
}

function spawn(v_origin = (0, 0, 0), v_angles = (0, 0, 0)) {
  s = spawnStruct();
  s.origin = v_origin;
  s.angles = v_angles;
  return s;
}

function get_array(kvp_value, kvp_key = "targetname") {
  if(isDefined(level.struct_class_names[kvp_key][kvp_value])) {
    return arraycopy(level.struct_class_names[kvp_key][kvp_value]);
  }
  return [];
}

function delete() {
  if(isDefined(self.target)) {
    arrayremovevalue(level.struct_class_names["target"][self.target], self);
  }
  if(isDefined(self.targetname)) {
    arrayremovevalue(level.struct_class_names["targetname"][self.targetname], self);
  }
  if(isDefined(self.script_noteworthy)) {
    arrayremovevalue(level.struct_class_names["script_noteworthy"][self.script_noteworthy], self);
  }
  if(isDefined(self.script_linkname)) {
    arrayremovevalue(level.struct_class_names["script_linkname"][self.script_linkname], self);
  }
  if(isDefined(self.script_label)) {
    arrayremovevalue(level.struct_class_names["script_label"][self.script_label], self);
  }
  if(isDefined(self.classname)) {
    arrayremovevalue(level.struct_class_names["classname"][self.classname], self);
  }
  if(isDefined(self.script_unitrigger_type)) {
    arrayremovevalue(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type], self);
  }
  if(isDefined(self.scriptbundlename)) {
    arrayremovevalue(level.struct_class_names["scriptbundlename"][self.scriptbundlename], self);
  }
}

function get_script_bundle(str_type, str_name) {
  if(isDefined(level.scriptbundles[str_type]) && isDefined(level.scriptbundles[str_type][str_name])) {
    return level.scriptbundles[str_type][str_name];
  }
}

function delete_script_bundle(str_type, str_name) {
  if(isDefined(level.scriptbundles[str_type]) && isDefined(level.scriptbundles[str_type][str_name])) {
    level.scriptbundles[str_type][str_name] = undefined;
  }
}

function get_script_bundles_of_type(str_type) {
  if(isDefined(level.scriptbundles[str_type])) {
    return arraycopy(level.scriptbundles[str_type]);
  }
}

function get_script_bundles(str_type) {
  if(isDefined(level.scriptbundles) && isDefined(level.scriptbundles[str_type])) {
    return level.scriptbundles[str_type];
  }
  return [];
}

function get_script_bundle_list(str_type, str_name) {
  if(isDefined(level.scriptbundlelists[str_type]) && isDefined(level.scriptbundlelists[str_type][str_name])) {
    return level.scriptbundlelists[str_type][str_name];
  }
}

function get_script_bundle_instances(str_type, str_name = "") {
  a_instances = get_array("scriptbundle_" + str_type, "classname");
  if(str_name != "") {
    foreach(i, s_instance in a_instances) {
      if(s_instance.name != str_name) {
        arrayremoveindex(a_instances, i, 1);
      }
    }
  }
  return a_instances;
}

function findstruct(position) {
  foreach(key, _ in level.struct_class_names) {
    foreach(s_array in level.struct_class_names[key]) {
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
  return undefined;
}