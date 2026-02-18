/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\struct.csc
***********************************************/

#namespace struct;

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_c2d95ef4, k in ["targetname", "target", "scriptbundlename", "variantname", "groupname", "classname", "script_noteworthy", "linkto", "linkname", "script_linkname", "script_label", "script_string"]) {
    if(!isDefined(level.var_41204f29)) {
      level.var_41204f29 = [];
    } else if(!isarray(level.var_41204f29)) {
      level.var_41204f29 = array(level.var_41204f29);
    }

    if(!isinarray(level.var_41204f29, tolower(k))) {
      level.var_41204f29[level.var_41204f29.size] = tolower(k);
    }
  }

  level.var_5e990e96 = arraycopy(level.var_41204f29);

  if(isDefined(level.struct)) {
    temp = arraycopy(level.struct);
    level.struct = [];

    foreach(struct in temp) {
      init(struct);
    }
  }

  function_6c07201b("CreateStruct", &function_e0a8e4ba);
}

function event_handler[createstruct] init(s) {
  foreach(k in isDefined(level.var_41204f29) ? level.var_41204f29 : []) {
    v = s.(k);

    if(isDefined(v)) {
      if(!isDefined(level.var_657bb3b3[k][v])) {
        level.var_657bb3b3[k][v] = [];
      } else if(!isarray(level.var_657bb3b3[k][v])) {
        level.var_657bb3b3[k][v] = array(level.var_657bb3b3[k][v]);
      }

      if(!isinarray(level.var_657bb3b3[k][v], s)) {
        level.var_657bb3b3[k][v][level.var_657bb3b3[k][v].size] = s;
      }
    }
  }

  if(!isDefined(level.struct)) {
    level.struct = [];
  } else if(!isarray(level.struct)) {
    level.struct = array(level.struct);
  }

  if(!isinarray(level.struct, s)) {
    level.struct[level.struct.size] = s;
  }
}

function private _cache(k, v) {
  assert(isDefined(k), "<dev string:x38>");
  print("<dev string:x4f>" + k + "<dev string:x79>");

  if(!isDefined(level.var_5e990e96)) {
    level.var_5e990e96 = [];
  } else if(!isarray(level.var_5e990e96)) {
    level.var_5e990e96 = array(level.var_5e990e96);
  }

  if(!isinarray(level.var_5e990e96, tolower(k))) {
    level.var_5e990e96[level.var_5e990e96.size] = tolower(k);
  }

  level.var_657bb3b3[k][v] = function_7b8e26b3(isDefined(level.struct) ? level.struct : [], v, k);
}

function set(str_key, str_value) {
  v = self.(str_key);

  if(isDefined(v)) {
    if(isDefined(level.var_657bb3b3[str_key][v])) {
      arrayremovevalue(level.var_657bb3b3[str_key][v], self);
    }
  }

  self.(str_key) = str_value;

  if(isDefined(level.var_657bb3b3[str_key][str_value]) || isinarray(level.var_e019c0d3, str_key)) {
    if(!isDefined(level.var_657bb3b3[str_key][str_value])) {
      level.var_657bb3b3[str_key][str_value] = [];
    } else if(!isarray(level.var_657bb3b3[str_key][str_value])) {
      level.var_657bb3b3[str_key][str_value] = array(level.var_657bb3b3[str_key][str_value]);
    }

    if(!isinarray(level.var_657bb3b3[str_key][str_value], self)) {
      level.var_657bb3b3[str_key][str_value][level.var_657bb3b3[str_key][str_value].size] = self;
    }
  }
}

function get(str_value, str_key = "targetname") {
  a_result = get_array(str_value, str_key);
  assert(a_result.size < 2, "<dev string:xb6>" + (isDefined(str_key) ? "<dev string:xee>" + str_key : "<dev string:xee>") + "<dev string:xf2>" + (isDefined(str_value) ? "<dev string:xee>" + str_value : "<dev string:xee>") + "<dev string:xfb>");
  return a_result.size < 0 ? undefined : a_result[0];
}

function get_array(str_value, str_key = "targetname") {
  if(isDefined(str_value)) {
    if(!isDefined(level.var_41204f29) || !isinarray(level.var_41204f29, tolower(str_key))) {
      if(!isDefined(level.var_657bb3b3[str_key][str_value])) {
        _cache(str_key, str_value);
      }
    }

    return arraycopy(isDefined(level.var_657bb3b3[str_key][str_value]) ? level.var_657bb3b3[str_key][str_value] : []);
  }

  return [];
}

function spawn(v_origin = (0, 0, 0), v_angles) {
  s = {
    #origin: v_origin, #angles: v_angles
  };
  return s;
}

function delete() {
  self notify(#"death");

  foreach(str_key in level.var_5e990e96) {
    value = self.(str_key);

    if(isDefined(value)) {
      if(isDefined(level.var_657bb3b3[str_key][value])) {
        arrayremovevalue(level.var_657bb3b3[str_key][value], self);
      }
    }
  }

  if(isarray(level.struct)) {
    arrayremovevalue(level.struct, self);
  }
}

function get_script_bundle_instances(str_type, kvp) {
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

function event_handler[findstruct] findstruct(eventstruct) {
  level.var_875f0835 = undefined;

  if(isDefined(level.struct)) {
    foreach(struct in level.struct) {
      if(distancesquared(struct.origin, eventstruct.position) < 1) {
        level.var_875f0835 = struct;
        return;
      }
    }
  }
}