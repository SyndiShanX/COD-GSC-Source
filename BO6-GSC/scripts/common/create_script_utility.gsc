/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\create_script_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace create_script_utility;

function autoexec initialize_create_script() {
  init_create_script_for_level();
}

function init_create_script_for_level(bshouldthread) {
  if(isDefined(level.scripted_spawner_func)) {
    return;
  }

  if(!function_6cf19cb9988ce1b1()) {
    return;
  }

  utility::flag_set("\xac\x98\xfb\xf5x\\\xc5\xd7\xfd\xae\xc5\xe9\x9f");
  level.create_script = 1;
  level.threadedscriptspawners = istrue(bshouldthread);
  level.create_script_file_ids = [];
  level.cs_scripts = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  level.var_c8c131d2a5403872 = 0;
}

function initialize_registered_create_script_files() {
  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      for(i = 0; i < level.scripted_spawner_func.size; i++) {
        [[level.scripted_spawner_func[i]]](1, "\x11\xa7" + i);
      }

      return;
    }

    if(istrue(level.threadedscriptspawners)) {
      [[level.scripted_spawner_func]](1);
      return;
    }

    [[level.scripted_spawner_func]]();
  }
}

function register_create_script_arrays(script, map, index, func) {
  if(isDefined(func)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = func;
  }

  if(isDefined(script)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = script;

    if(isDefined(index)) {
      level.create_script_file_ids[script] = "\x11\xa7" + index;
    }
  }

  if(isDefined(map)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = map;
  }
}

function initialize_create_script_file(file_name) {
  if(utility::flag_exist(file_name)) {
    utility::flag_set(file_name);

    if(utility::flag_exist(file_name + "\b6\x13X\x1e[\xcf\x05\xc0K")) {
      level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
      utility::flag_wait(file_name + "\b6\x13X\x1e[\xcf\x05\xc0K");
    }
  }
}

function register_valid_gametypes_for_create_script(allowed_gametype) {
  if(!isDefined(level.allowed_gametypes)) {
    level.allowed_gametypes = [];
  }

  level.allowed_gametypes[level.allowed_gametypes.size] = allowed_gametype;
}

function register_valid_objectives_for_create_script(allowed_objective) {
  if(!isDefined(level.allowed_objectives)) {
    level.allowed_objectives = [];
  }

  level.allowed_objectives[level.allowed_objectives.size] = allowed_objective;
}

function strike_setup_arrays(index, cs_file) {
  if(!isDefined(level.scripted_spawners)) {
    level.scripted_spawners = [];
  }

  if(!isDefined(level.scripted_spawners_triggers)) {
    level.scripted_spawners_triggers = [];
  }

  if(!isDefined(level.scripted_spawners_models)) {
    level.scripted_spawners_models = [];
  }

  if(!isDefined(level.cs_origin_offset)) {
    level.cs_origin_offset = [];
  }

  if(!isDefined(level.cs_angle_offset)) {
    level.cs_angle_offset = [];
  }

  if(!isDefined(level.cs_scripted_spawners)) {
    level.cs_scripted_spawners = [];
  }

  if(!isDefined(level.cs_scripted_spawners_triggers)) {
    level.cs_scripted_spawners_triggers = [];
  }

  if(!isDefined(level.cs_scripted_spawners_models)) {
    level.cs_scripted_spawners_models = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners[index])) {
    level.scripted_spawners[index] = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners_triggers[index])) {
    level.scripted_spawners_triggers[index] = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners_models[index])) {
    level.scripted_spawners_models[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners[index])) {
    level.cs_scripted_spawners[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_triggers[index])) {
    level.cs_scripted_spawners_triggers[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_models[index])) {
    level.cs_scripted_spawners_models[index] = [];
  }

  if(utility::issharedfuncdefined(#"create_script", #"cleanupfuncinit")) {
    funcname = utility::getsharedfunc(#"create_script", #"cleanupfuncinit");
    [[funcname]](cs_file, self);
  }
}

function cs_setup_arrays(index, cs_file) {
  if(!isDefined(level.scripted_spawners)) {
    level.scripted_spawners = [];
  }

  if(!isDefined(level.scripted_spawners_triggers)) {
    level.scripted_spawners_triggers = [];
  }

  if(!isDefined(level.scripted_spawners_models)) {
    level.scripted_spawners_models = [];
  }

  if(!isDefined(level.cs_origin_offset)) {
    level.cs_origin_offset = [];
  }

  if(!isDefined(level.cs_angle_offset)) {
    level.cs_angle_offset = [];
  }

  if(!isDefined(level.cs_scripted_spawners)) {
    level.cs_scripted_spawners = [];
  }

  if(!isDefined(level.cs_scripted_spawners_triggers)) {
    level.cs_scripted_spawners_triggers = [];
  }

  if(!isDefined(level.cs_scripted_spawners_models)) {
    level.cs_scripted_spawners_models = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners[index])) {
    level.scripted_spawners[index] = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners_triggers[index])) {
    level.scripted_spawners_triggers[index] = [];
  }

  if(isDefined(index) && !isDefined(level.scripted_spawners_models[index])) {
    level.scripted_spawners_models[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners[index])) {
    level.cs_scripted_spawners[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_triggers[index])) {
    level.cs_scripted_spawners_triggers[index] = [];
  }

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_models[index])) {
    level.cs_scripted_spawners_models[index] = [];
  }

  if(utility::issharedfuncdefined(#"create_script", #"cleanupfuncinit")) {
    funcname = utility::getsharedfunc(#"create_script", #"cleanupfuncinit");
    [[funcname]](cs_file, self);
  }
}

function strike_additem(struct, index, cs_file, origin, angles, targetname, target, script_noteworthy, script_linkto, script_linkname, var_3e9c0e7d04e7639e, var_a9e41d296e7927ff, radius, speed, spawnflags, script_unload) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(!struct object_is_valid()) {
    return;
  }

  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0) {
      waitframe();
    }
  }

  var_834fd65131f8a9db = 0;

  if(isDefined(origin)) {
    struct.origin = origin;
  }

  if(isDefined(angles)) {
    struct.angles = angles;
  } else if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  if(isDefined(targetname)) {
    var_834fd65131f8a9db = 1;
    struct.targetname = targetname;
  }

  if(isDefined(target)) {
    var_834fd65131f8a9db = 1;
    struct.target = target;
  }

  if(isDefined(script_noteworthy)) {
    var_834fd65131f8a9db = 1;
    struct.script_noteworthy = script_noteworthy;
  }

  if(isDefined(script_linkto)) {
    struct.script_linkto = script_linkto;
  }

  if(isDefined(script_linkname)) {
    var_834fd65131f8a9db = 1;
    struct.script_linkname = script_linkname;
  }

  if(isDefined(speed)) {
    struct.speed = speed;
  }

  if(isDefined(radius)) {
    struct.radius = radius;
  }

  if(isDefined(spawnflags)) {
    struct.spawnflags = int(spawnflags);
  }

  if(isDefined(script_unload)) {
    struct.script_unload = script_unload;
  }

  translate_position_with_offset_data(cs_file, struct, var_3e9c0e7d04e7639e, var_a9e41d296e7927ff);

  if(!isDefined(index)) {
    index = "w";
  }

  strike_fixautokvps(struct, index);
  typecast_kvps(struct);
  correct_kvps(struct);

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = struct;
  }

  if(isDefined(struct.model)) {
    if(istrue(struct.is_cs_model)) {
      struct.is_cs_model = undefined;
    }

    strike_modelcreate(struct, index);
    utility::callsharedfunc(#"create_script", #"ai_interactions", struct);
    utility::callsharedfunc(#"create_script", #"delete_bsp_dupes", struct);
    return;
  }

  if(isDefined(struct.is_cs_script_origin)) {
    struct.is_cs_script_origin = struct.is_cs_script_origin == "\x87" ? 1 : 0;
  }

  if(istrue(struct.is_cs_trigger)) {
    struct.is_cs_trigger = undefined;
    strike_triggercreate(struct, index, 1, struct.var_fbe2fe793b4e0d9f);
    struct.var_fbe2fe793b4e0d9f = undefined;
  } else if(istrue(struct.is_cs_model)) {
    strike_modelcreate(struct, index);
    struct.is_cs_model = undefined;
  } else if(istrue(struct.is_cs_script_origin)) {
    struct.is_cs_script_origin = undefined;
    strike_scriptorigincreate(struct, index);
  } else if(isDefined(struct.targetname)) {
    switch (struct.targetname) {
      case #"hash_c54a2fb47decfc4b":
        strike_triggercreate(struct, index);
        break;
      case #"hash_39242cd548aa8ad2":
        strike_triggercreate(struct, index);
        break;
      case #"hash_9c00e8ccfe6f652f":
        strike_triggercreate(struct, index, 1);
        break;
      case #"hash_e0468027719a9048":
        strike_triggercreate(struct, index, 1);
        break;
      case #"hash_d9876aa54e2a4d2b":
        strike_interactioncreate(struct, index);
        break;
      case #"hash_1ca1f994ed1249f5":
        strike_triggercreate(struct, index, 1);
        break;
      default:
        utility::addstruct(struct);
        break;
    }
  } else {
    utility::addstruct(struct);
  }

  utility::callsharedfunc(#"create_script", #"ai_interactions", struct);
  utility::callsharedfunc(#"create_script", #"delete_bsp_dupes", struct);
}

function object_is_valid() {
  gametype_allowed = 0;
  objective_allowed = 0;

  if(isDefined(level.allowed_gametypes)) {
    if(isDefined(self.script_gameobjectname)) {
      for(i = 0; i < level.allowed_gametypes.size; i++) {
        if(getsubstr(level.allowed_gametypes[i], 0, 1) == "p") {
          invertlogic = 1;
        } else {
          invertlogic = 0;
        }

        if(is_object_allowed_in_gametype(self.script_gameobjectname, level.allowed_gametypes[i]) != invertlogic) {
          gametype_allowed = 1;
          break;
        }
      }
    } else {
      gametype_allowed = 1;
    }
  } else {
    gametype_allowed = 1;
  }

  if(isDefined(level.allowed_objectives)) {
    if(isDefined(self.script_gameobjectname)) {
      for(i = 0; i < level.allowed_objectives.size; i++) {
        if(getsubstr(level.allowed_objectives[i], 0, 1) == "p") {
          invertlogic = 1;
        } else {
          invertlogic = 0;
        }

        if(is_object_allowed_in_gametype(self.script_gameobjectname, level.allowed_objectives[i]) != invertlogic) {
          objective_allowed = 1;
          break;
        }
      }
    } else {
      objective_allowed = 1;
    }
  } else {
    objective_allowed = 1;
  }

  return istrue(gametype_allowed && objective_allowed);
}

function is_object_allowed_in_gametype(stringlist, gametype) {
  if(!isDefined(stringlist) || stringlist == "" || !isDefined(gametype) || gametype == "") {
    return 0;
  }

  return issubstr(stringlist, gametype);
}

function translate_position_with_offset_data(cs_file, struct, var_c8f168efed6eb125, var_bed918c700ddbd8b) {
  translate_and_rotate_from_level_overrides(cs_file, struct);

  if(isDefined(var_c8f168efed6eb125)) {
    if(!isDefined(var_bed918c700ddbd8b)) {
      var_bed918c700ddbd8b = (0, 0, 0);
    }

    obj_angles = (0, 0, 0);

    if(isDefined(struct.angles)) {
      obj_angles = struct.angles;
    }

    obj_origin = struct.origin;
    struct.origin = var_c8f168efed6eb125 + rotatevector(obj_origin, var_bed918c700ddbd8b);

    if(isDefined(struct.script_origin_other)) {
      struct.script_origin_other = var_c8f168efed6eb125 + rotatevector(struct.script_origin_other, var_bed918c700ddbd8b);
    }

    var_8cd4b4a256f6059 = combineangles(var_bed918c700ddbd8b, obj_angles);
    struct.angles = var_8cd4b4a256f6059;
  }
}

function translate_and_rotate_from_level_overrides(cs_file, struct) {
  if(isDefined(level.cs_origin_offset) && isDefined(cs_file) && isDefined(level.cs_angle_offset[cs_file])) {
    var_bed918c700ddbd8b = level.cs_angle_offset[cs_file];
    var_c8f168efed6eb125 = level.cs_origin_offset[cs_file];
    obj_angles = (0, 0, 0);

    if(isDefined(struct.angles)) {
      obj_angles = struct.angles;
    }

    obj_origin = struct.origin;
    struct.origin = var_c8f168efed6eb125 + rotatevector(obj_origin, var_bed918c700ddbd8b);

    if(isDefined(struct.script_origin_other)) {
      struct.script_origin_other = var_c8f168efed6eb125 + rotatevector(struct.script_origin_other, var_bed918c700ddbd8b);
    }

    var_8cd4b4a256f6059 = combineangles(var_bed918c700ddbd8b, obj_angles);
    struct.angles = var_8cd4b4a256f6059;
  }
}

function strike_add_to_cs_arrays(cs_type, struct, index) {
  if(!getdvarint(@ "hash_ad6e2fed4a549f49", 0)) {
    return;
  }

  if(cs_type == "\xf7\x9dP\x19 \x9a") {
    level.scripted_spawners[index][level.scripted_spawners[index].size] = struct;
  } else if(cs_type == "\x91`\xb1\xe7T\x97>") {
    level.scripted_spawners_triggers[index][level.scripted_spawners_triggers[index].size] = struct;
  } else if(cs_type == "\xff\xb2\x0e\xc5\xc8") {
    level.scripted_spawners_models[index][level.scripted_spawners_models[index].size] = struct;
  }

  if(cs_type == "<dev string:x24>") {
    level.cs_scripted_spawners[index][level.cs_scripted_spawners[index].size] = struct;
    return;
  }

  if(cs_type == "<dev string:x2e>") {
    level.cs_scripted_spawners_triggers[index][level.cs_scripted_spawners_triggers[index].size] = struct;
    return;
  }

  if(cs_type == "<dev string:x39>") {
    level.cs_scripted_spawners_models[index][level.cs_scripted_spawners_models[index].size] = struct;
  }
}

function strike_interactioncreate(struct, index) {
  utility::addstruct(struct);
}

function strike_scriptorigincreate(struct, index) {
  model = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", struct.origin);
  model.targetname = "\xcd\xd1\x9cK\xda\xb2\xf57\xd8\x9cZp\xa3\xa7\x9c\xa5vK\xb9\rr+,\xa3V";

  if(!isDefined(struct.angles)) {
    model.angles = (0, 0, 0);
  } else {
    model.angles = struct.angles;
  }

  if(isDefined(struct.model)) {
    model setModel(struct.model);
  }

  if(isDefined(struct.targetname)) {
    model.targetname = struct.targetname;
  }

  if(isDefined(struct.script_noteworthy)) {
    model.script_noteworthy = struct.script_noteworthy;
  }

  if(isDefined(struct.script_linkto)) {
    model.script_linkto = struct.script_linkto;
  }

  if(isDefined(struct.script_linkname)) {
    model.script_linkname = struct.script_linkname;
  }

  if(isDefined(struct.target)) {
    model.target = struct.target;
  }

  model.struct = struct;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = model;
  }
}

function strike_modelcreate(struct, index) {
  strike_add_to_cs_arrays("\xff\xb2\x0e\xc5\xc8", struct, index);

  if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", struct.origin);
  model.angles = struct.angles;
  model setModel(struct.model);

  if(isDefined(struct.targetname)) {
    model.targetname = struct.targetname;
  }

  if(isDefined(struct.script_noteworthy)) {
    model.script_noteworthy = struct.script_noteworthy;
  }

  if(isDefined(struct.script_linkto)) {
    model.script_linkto = struct.script_linkto;
  }

  if(isDefined(struct.script_linkname)) {
    model.script_linkname = struct.script_linkname;
  }

  if(isDefined(struct.target)) {
    model.target = struct.target;
  }

  if(isDefined(struct.name)) {
    model.name = struct.name;
  }

  model.struct = struct;
  struct.is_cs_model = undefined;
  struct.is_cs_scriptable = undefined;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = model;
  }
}

function strike_triggercreate(struct, index, var_d2f8442a91f400ad, noent_volume) {
  strike_add_to_cs_arrays("\x91`\xb1\xe7T\x97>", struct, index);

  if(isDefined(struct.spawnflags)) {
    spawnflags = struct.spawnflags;
  } else {
    spawnflags = 0;
  }

  if(isDefined(struct.var_43a808bc2f21d6f5) && isDefined(struct.var_4304bcca5f89ca7f)) {
    if(istrue(noent_volume)) {
      trigger = spawn("e\x8b\xed\xbc\xd8\xdb$\x97\x83\x90\x8e\x9a5\x06\x9c\xcdzP\xcd\xf5\xdfn\x83\x0f", struct.origin, spawnflags, struct.var_43a808bc2f21d6f5, struct.var_4304bcca5f89ca7f);
    } else {
      trigger = spawn("\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xb1\x0f\x8c", struct.origin, spawnflags, struct.var_43a808bc2f21d6f5, struct.var_4304bcca5f89ca7f);
    }
  } else if(istrue(noent_volume)) {
    trigger = spawn("\xc6\x0f{e\"\"\xb6\f\x96%Ae\x05\x9bXT\xfc\xa93\xf3\x18W\x88\xae0\xbb\xd8\x05\xe0\x06\x13m\xa7\xb2}\xb3z", struct.origin, spawnflags, int(struct.radius), int(struct.height));
  } else {
    trigger = spawn("\vD\x8a\xdd\x95W6\xca\x01\xbc\xe7\xa2\xccr\xce\x17\v>\xcc\xe1X\xb1\x17\xc0", struct.origin, spawnflags, int(struct.radius), int(struct.height));
  }

  if(isDefined(struct.angles) && struct.angles != (0, 0, 0)) {
    if(istrue(var_d2f8442a91f400ad)) {
      trigger.angles = struct.angles;
    } else {
      trigger.angles = (-90, 0, 0) + struct.angles;
    }
  }

  trigger.struct = struct;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = trigger;
  }

  trigger strike_triggerassignvalues(struct);
}

function strike_triggerassignvalues(struct) {
  if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  if(isDefined(struct.script_label)) {
    self.script_label = struct.script_label;
  }

  if(isDefined(struct.script_function)) {
    self.script_function = struct.script_function;
  }

  if(isDefined(struct.script_noteworthy)) {
    self.script_noteworthy = struct.script_noteworthy;
  }

  if(isDefined(struct.script_gesture)) {
    self.script_gesture = struct.script_gesture;
  }

  if(isDefined(struct.target)) {
    self.target = struct.target;
  }

  if(isDefined(struct.script_wtf)) {
    self.script_wtf = struct.script_wtf;
  }

  if(isDefined(struct.script_flag)) {
    self.script_flag = struct.script_flag;
  }

  if(isDefined(struct.script_linkto)) {
    self.script_linkto = struct.script_linkto;
  }

  if(isDefined(struct.script_linkname)) {
    self.script_linkname = struct.script_linkname;
  }

  if(isDefined(struct.groupname)) {
    self.groupname = struct.groupname;
  }

  if(isDefined(struct.script_count)) {
    self.script_count = struct.script_count;
  }

  if(isDefined(struct.script_count_min)) {
    self.script_count_min = struct.script_count_min;
  }

  if(isDefined(struct.script_count_max)) {
    self.script_count_max = struct.script_count_max;
  }

  if(isDefined(struct.script_maxdist)) {
    self.script_maxdist = struct.script_maxdist;
  }

  if(isDefined(struct.script_parameters)) {
    self.script_parameters = struct.script_parameters;
  }

  self.targetname = struct.targetname;
}

function strike_fixautokvps(struct, index) {
  if(isDefined(struct.target) && issubstr(struct.target, "/i\x84'")) {
    struct.target = "\x10\xe7\xc5" + index + struct.target;
  }

  if(isDefined(struct.targetname) && issubstr(struct.targetname, "/i\x84'")) {
    struct.targetname = "\x10\xe7\xc5" + index + struct.targetname;
  }

  if(isDefined(struct.script_linkto)) {
    new_linkto = "";
    str_toks = strtok(struct.script_linkto, "\xda");

    foreach(tok in str_toks) {
      if(new_index != 0) {
        new_linkto = new_linkto + "\xda" + "\x10\xe7\xc5" + index + tok;
        continue;
      }

      new_linkto = new_linkto + "\x10\xe7\xc5" + index + tok;
    }

    struct.script_linkto = new_linkto;
  }

  if(isDefined(struct.script_linkname)) {
    struct.script_linkname = "\x10\xe7\xc5" + index + struct.script_linkname;
  }

  if(isDefined(struct.var_54bd06598344315f) && issubstr(struct.var_54bd06598344315f, "/i\x84'")) {
    struct.var_54bd06598344315f = "\x10\xe7\xc5" + index + struct.var_54bd06598344315f;
  }
}

function private correct_kvps(struct) {
  struct.script_agent_noteworthy = isDefined(struct.script_agent_noteworthy) ? struct.script_agent_noteworthy : struct.agent_noteworthy;
  struct.script_aitype1 = isDefined(struct.script_aitype1) ? struct.script_aitype1 : struct.aitype1;
  struct.var_172bf3b2c696c068 = isDefined(struct.var_172bf3b2c696c068) ? struct.var_172bf3b2c696c068 : struct.aitype1_tier;
  struct.script_aitype2 = isDefined(struct.script_aitype2) ? struct.script_aitype2 : struct.aitype2;
  struct.var_6421fc34626e65a7 = isDefined(struct.var_6421fc34626e65a7) ? struct.var_6421fc34626e65a7 : struct.aitype2_tier;
  struct.script_aitype3 = isDefined(struct.script_aitype3) ? struct.script_aitype3 : struct.aitype3;
  struct.var_9e04ce0937d292da = isDefined(struct.var_9e04ce0937d292da) ? struct.var_9e04ce0937d292da : struct.aitype3_tier;
  struct.script_aitype4 = isDefined(struct.script_aitype4) ? struct.script_aitype4 : struct.aitype4;
  struct.var_d9a4fbc4b673e0e1 = isDefined(struct.var_d9a4fbc4b673e0e1) ? struct.var_d9a4fbc4b673e0e1 : struct.aitype4_tier;
  struct.script_aitype5 = isDefined(struct.script_aitype5) ? struct.script_aitype5 : struct.aitype5;
  struct.var_f5574fbfab37f89c = isDefined(struct.var_f5574fbfab37f89c) ? struct.var_f5574fbfab37f89c : struct.aitype5_tier;
  struct.script_codelength = isDefined(struct.script_codelength) ? struct.script_codelength : struct.codelength;
  struct.var_f799de6b82e6bbe5 = isDefined(struct.var_f799de6b82e6bbe5) ? struct.var_f799de6b82e6bbe5 : struct.var_34d9d6e9600db7ef;
  struct.var_d6697dd1b282bf56 = isDefined(struct.var_d6697dd1b282bf56) ? struct.var_d6697dd1b282bf56 : struct.var_ffdb978f204116ac;
  struct.var_29de1c8340f75a85 = isDefined(struct.var_29de1c8340f75a85) ? struct.var_29de1c8340f75a85 : struct.cs_flag;
  struct.script_formation_type = isDefined(struct.script_formation_type) ? struct.script_formation_type : struct.formation_type;
  struct.var_73362579dcc1123a = isDefined(struct.var_73362579dcc1123a) ? struct.var_73362579dcc1123a : struct.var_5ab9737504a3fa8c;
  struct.script_maxagents = isDefined(struct.script_maxagents) ? struct.script_maxagents : struct.maxagents;
  struct.var_d713367048738a3a = isDefined(struct.var_d713367048738a3a) ? struct.var_d713367048738a3a : struct.minagents;
  struct.script_nationality_override = isDefined(struct.script_nationality_override) ? struct.script_nationality_override : struct.nationality_override;
  struct.var_62dff80601d6d3ca = isDefined(struct.var_62dff80601d6d3ca) ? struct.var_62dff80601d6d3ca : struct.path_behavior;
  struct.script_patrolspawnset = isDefined(struct.script_patrolspawnset) ? struct.script_patrolspawnset : struct.patrolspawnset;
  struct.script_poi = isDefined(struct.script_poi) ? struct.script_poi : struct.poi;
  struct.script_required = isDefined(struct.script_required) ? struct.script_required : struct.required;
  struct.var_290e0648a8b06611 = isDefined(struct.var_290e0648a8b06611) ? struct.var_290e0648a8b06611 : struct.respawn_behavior;
  struct.script_spawnset = isDefined(struct.script_spawnset) ? struct.script_spawnset : struct.spawnset;
  struct.script_tier = isDefined(struct.script_tier) ? struct.script_tier : struct.tier;
  struct.script_waittime = isDefined(struct.script_waittime) ? struct.script_waittime : struct.waittime;
  struct.script_wander_range = isDefined(struct.script_wander_range) ? struct.script_wander_range : struct.wander_range;
  struct.script_keynameoverride = isDefined(struct.script_keynameoverride) ? struct.script_keynameoverride : struct.keynameoverride;
  struct.agent_noteworthy = undefined;
  struct.aitype1 = undefined;
  struct.aitype1_tier = undefined;
  struct.aitype2 = undefined;
  struct.aitype2_tier = undefined;
  struct.aitype3 = undefined;
  struct.aitype3_tier = undefined;
  struct.aitype4 = undefined;
  struct.aitype4_tier = undefined;
  struct.aitype5 = undefined;
  struct.aitype5_tier = undefined;
  struct.codelength = undefined;
  struct.var_34d9d6e9600db7ef = undefined;
  struct.var_ffdb978f204116ac = undefined;
  struct.cs_flag = undefined;
  struct.formation_type = undefined;
  struct.maxagents = undefined;
  struct.minagents = undefined;
  struct.nationality_override = undefined;
  struct.path_behavior = undefined;
  struct.patrolspawnset = undefined;
  struct.poi = undefined;
  struct.required = undefined;
  struct.respawn_behavior = undefined;
  struct.spawnset = undefined;
  struct.tier = undefined;
  struct.waittime = undefined;
  struct.wander_range = undefined;
  struct.keynameoverride = undefined;
}

function function_6cf19cb9988ce1b1() {
  return getdvarint(@ "hash_ad6e2fed4a549f49", 1);
}

function private function_c41d28626e8eb389(value, key) {
  if(isDefined(value)) {
    print(key + "<dev string:x42>" + self.origin + "<dev string:x6c>" + key + "<dev string:x9d>");
  }

  return value;
}

function typecast_kvps(struct) {
  if(utility::issharedfuncdefined(#"createscript", #"typecast")) {
    if(istrue(struct utility::callsharedfunc(#"createscript", #"typecast"))) {
      return;
    }
  }

  if(isDefined(struct.script_wait_min)) {
    struct.script_wait_min = float(struct.script_wait_min);
  }

  if(isDefined(struct.script_wait_max)) {
    struct.script_wait_max = float(struct.script_wait_max);
  }

  if(isDefined(struct.script_wait_add)) {
    struct.script_wait_add = float(struct.script_wait_add);
  }

  if(isDefined(struct.script_brake)) {
    struct.script_brake = float(struct.script_brake);
  }

  if(isDefined(struct.var_7390e299f9acebc9)) {
    struct.var_7390e299f9acebc9 = int(struct.var_7390e299f9acebc9);
  }

  if(isDefined(struct.lookahead)) {
    struct.lookahead = int(struct.lookahead);
  }

  if(isDefined(struct.speed)) {
    struct.speed = int(struct.speed);
  }

  if(isDefined(struct.var_f14c5f628a07448e)) {
    if(struct.var_f14c5f628a07448e == "at\xea\xb9" || struct.var_f14c5f628a07448e == "\x87") {
      struct.var_f14c5f628a07448e = 1;
    } else {
      struct.var_f14c5f628a07448e = 0;
    }
  }

  if(isDefined(struct.dont_enter_combat)) {
    struct.dont_enter_combat = int(struct.dont_enter_combat);
  }

  if(isDefined(struct.script_goalradius)) {
    struct.script_goalradius = int(struct.script_goalradius);
  }

  if(isDefined(struct.script_accel)) {
    struct.script_accel = int(struct.script_accel);
  }

  if(isDefined(struct.script_decel)) {
    struct.script_decel = int(struct.script_decel);
  }

  if(isDefined(struct.script_speed)) {
    struct.script_speed = int(struct.script_speed);
  }

  if(isDefined(struct.repeat_interaction)) {
    struct.repeat_interaction = int(struct.repeat_interaction);
  }

  if(isDefined(struct.script_goal_threshold)) {
    struct.script_goal_threshold = float(struct.script_goal_threshold);
  }

  if(isDefined(struct.var_91240f0e2fb1b535)) {
    if(struct.var_91240f0e2fb1b535 == "at\xea\xb9" || struct.var_91240f0e2fb1b535 == "\x87") {
      struct.var_91240f0e2fb1b535 = 1;
    } else {
      struct.var_91240f0e2fb1b535 = undefined;
    }
  }

  if(isDefined(struct.script_goalyaw)) {
    if(struct.script_goalyaw == "at\xea\xb9" || struct.script_goalyaw == "\x87") {
      struct.script_goalyaw = 1;
    } else {
      struct.script_goalyaw = undefined;
    }
  }

  if(isDefined(struct.script_anglevehicle)) {
    if(struct.script_anglevehicle == "at\xea\xb9" || struct.script_anglevehicle == "\x87") {
      struct.script_goalyaw = 1;
    } else {
      struct.script_goalyaw = undefined;
    }
  }

  if(isDefined(struct.script_delay)) {
    struct.script_delay = float(struct.script_delay);
  }

  if(isDefined(struct.script_onlyidle)) {
    struct.script_onlyidle = int(struct.script_onlyidle);
  }

  if(isDefined(struct.script_ignoreme)) {
    struct.script_ignoreme = int(struct.script_ignoreme);
  }

  if(isDefined(struct.script_ignoreall)) {
    struct.script_ignoreall = int(struct.script_ignoreall);
  }

  if(isDefined(struct.script_death)) {
    struct.script_death = int(struct.script_death);
  }

  if(isDefined(struct.script_wait)) {
    struct.script_wait = float(struct.script_wait);
  }

  if(isDefined(struct.script_forcespawn)) {
    struct.script_forcespawn = int(struct.script_forcespawn);
  }

  if(isDefined(struct.script_timer)) {
    struct.script_timer = int(struct.script_timer);
  }

  if(isDefined(struct.script_dist_only)) {
    struct.script_dist_only = int(struct.script_dist_only) * int(struct.script_dist_only);
  }

  if(isDefined(struct.script_speed)) {
    struct.script_speed = int(struct.script_speed);
  }

  if(isDefined(struct.script_count)) {
    struct.script_count = int(struct.script_count);
  }

  if(isDefined(struct.script_radius)) {
    struct.script_radius = int(struct.script_radius);
  }

  if(isDefined(struct.script_delay_min)) {
    struct.script_delay_min = float(struct.script_delay_min);
  }

  if(isDefined(struct.script_delay_max)) {
    struct.script_delay_max = float(struct.script_delay_max);
  }

  if(isDefined(struct.script_escalation_level)) {
    struct.script_escalation_level = int(struct.script_escalation_level);
  }

  if(isDefined(struct.script_goalheight)) {
    struct.script_goalheight = int(struct.script_goalheight);
  }

  if(isDefined(struct.script_timeout)) {
    struct.script_timeout = float(struct.script_timeout);
  }

  if(isDefined(struct.script_pacifist)) {
    struct.script_pacifist = int(struct.script_pacifist);
  }

  if(isDefined(struct.script_forcespawn)) {
    struct.script_forcespawn = int(struct.script_forcespawn);
  }

  if(isDefined(struct.dontkilloff)) {
    struct.dontkilloff = int(struct.dontkilloff);
  }

  if(isDefined(struct.script_origin_other)) {
    struct.script_origin_other = struct.script_origin_other;
  }

  if(isDefined(struct.script_dot)) {
    struct.script_dot = int(struct.script_dot);
  }

  if(isDefined(struct.script_stopnode)) {
    struct.script_stopnode = int(struct.script_stopnode);
  }

  if(isDefined(struct.script_maxdist)) {
    struct.script_maxdist = int(struct.script_maxdist);
  }

  if(isDefined(struct.script_accuracy)) {
    struct.script_accuracy = float(struct.script_accuracy);
  }

  if(isDefined(struct.script_bcdialog)) {
    struct.script_bcdialog = int(struct.script_bcdialog);
  }

  if(isDefined(struct.script_fixednode)) {
    struct.script_fixednode = int(struct.script_fixednode);
  }

  if(isDefined(struct.script_pacifist)) {
    struct.script_pacifist = int(struct.script_pacifist);
  }

  if(isDefined(struct.script_moveoverride)) {
    struct.script_moveoverride = int(struct.script_moveoverride);
  }

  if(isDefined(struct.script_longdeath)) {
    struct.script_longdeath = int(struct.script_longdeath);
  }

  if(isDefined(struct.script_goalyaw)) {
    struct.script_goalyaw = int(struct.script_goalyaw);
  }

  if(isDefined(struct.script_forcegoal)) {
    struct.script_forcegoal = int(struct.script_forcegoal);
  }

  if(isDefined(struct.script_forcespawn)) {
    struct.script_forcespawn = int(struct.script_forcespawn);
  }

  if(isDefined(struct.script_useangles)) {
    struct.script_useangles = int(struct.script_useangles);
  }

  if(isDefined(struct.script_suspend)) {
    struct.script_suspend = int(struct.script_suspend);
  }

  if(isDefined(struct.count)) {
    struct.count = int(struct.count);
  }

  if(isDefined(struct.script_index)) {
    struct.script_index = int(struct.script_index);
  }

  if(isDefined(struct.script_faceangles)) {
    if(isstring(struct.script_faceangles) && (struct.script_faceangles == "at\xea\xb9" || struct.script_faceangles == "\x87")) {
      struct.script_faceangles = 1;
    }

    if(int(struct.script_faceangles) != 0) {
      struct.script_faceangles = 1;
    } else {
      struct.script_faceangles = undefined;
    }
  }

  if(isDefined(struct.script_cleanexit)) {
    if(struct.script_cleanexit == "at\xea\xb9" || struct.script_cleanexit == "\x87") {
      struct.script_cleanexit = 1;
      return;
    }

    struct.script_cleanexit = undefined;
  }
}

function cs_is_starttime() {
  if(utility::issp()) {
    if(!isDefined(level.starttime)) {
      level.starttime = gettime();
    }

    return (gettime() <= level.starttime + 250);
  }

  if(!isDefined(level.starttimeutcseconds)) {
    return 1;
  }

  return gettime() <= level.starttimeutcseconds + 250;
}

function cs_init_flags(newitem) {
  if(!utility::flag_exist("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca")) {
    utility::flag_init("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca");
  }

  if(!utility::flag_exist("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s")) {
    utility::flag_init("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s");
  }

  newitem.objects = [];
  newitem utility::ent_flag_init("\xad`\xbc\x13\xb2(\xf7\x0e\x7f\xdf_\xa5\a1h]\xcdp1");
  newitem utility::ent_flag_init("\xc7;>\x1b\x989Z\xf0\x90\\\x99\x96\xfa\xd4\xd8\x17%\xc1");
  newitem utility::ent_flag_init("9\x1d\x9dQ\x83V>[\xef*\r\xa6\"t\x19m\x91}\xaf\xf1");
}

function cs_flags_init(newitem) {
  if(!utility::flag_exist("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca")) {
    utility::flag_init("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca");
  }

  if(!utility::flag_exist("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s")) {
    utility::flag_init("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s");
  }

  newitem.objects = [];
  newitem utility::ent_flag_init("q\b\x9c2\x0e\xef\x0er\xbb\x81 Nv\x02m\xf43l");
}

function wait_for_flags(newitem, complete_flag) {
  if(newitem utility::ent_flag_exist("\xad`\xbc\x13\xb2(\xf7\x0e\x7f\xdf_\xa5\a1h]\xcdp1")) {
    newitem utility::ent_flag_wait("\xad`\xbc\x13\xb2(\xf7\x0e\x7f\xdf_\xa5\a1h]\xcdp1");
  }

  if(newitem utility::ent_flag_exist("9\x1d\x9dQ\x83V>[\xef*\r\xa6\"t\x19m\x91}\xaf\xf1")) {
    newitem utility::ent_flag_wait("9\x1d\x9dQ\x83V>[\xef*\r\xa6\"t\x19m\x91}\xaf\xf1");
  }

  if(newitem utility::ent_flag_exist("q\b\x9c2\x0e\xef\x0er\xbb\x81 Nv\x02m\xf43l")) {
    newitem utility::ent_flag_wait("q\b\x9c2\x0e\xef\x0er\xbb\x81 Nv\x02m\xf43l");
  }

  utility::flag_set(complete_flag + "\b6\x13X\x1e[\xcf\x05\xc0K");

  if(cs_is_starttime()) {
    endcreatescript(newitem);
  }
}

function endcreatescript(newitem) {
  if(isDefined(level.createscriptfilesinitialized) && (!isDefined(level.cs_scripts) || level.cs_scripts.size == 0)) {
    level.createscriptfilesinitialized++;

    if(level.createscriptfilesinitialized >= level.scripted_spawner_func.size) {
      utility::flag_set("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca");
      utility::flag_set("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s");
    }

    return;
  }

  if(!isDefined(level.cs_scripts) || level.cs_scripts.size == 0) {
    utility::flag_set("'\x03\xb6\xfe\x9c\xece\xc3\xdc\x1e\xbb\xc7H\xf8G\xca");
    utility::flag_set("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s");
  }
}

function wait_for_cs_flag(waittill_flag) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  utility::flag_init(waittill_flag + "\b6\x13X\x1e[\xcf\x05\xc0K");

  if(!should_wait_for_cs_flag(waittill_flag)) {
    endcreatescript();
    utility::flag_wait(waittill_flag);
  }
}

function should_wait_for_cs_flag(waittill_flag) {
  toks = strtok(getDvar(@ "hash_db88b998734440cc", ""), "\xda");
  toks = utility::array_combine(toks, level.active_cs_files);

  if(toks.size < 1) {
    return true;
  }

  for(i = 0; i < toks.size; i++) {
    tok = toks[i];

    if(tok == "\xc0\xc6J") {
      return true;
    }

    if(waittill_flag == tok) {
      return true;
    }
  }

  return false;
}

function register_cs_offsets(cs_file, origin_offset, angle_offset) {
  if(isDefined(origin_offset)) {
    level.cs_origin_offset[cs_file] = origin_offset;
  }

  if(isDefined(angle_offset)) {
    level.cs_angle_offset[cs_file] = angle_offset;
  }
}

function set_cs_file_dvar(file_name) {
  level.active_cs_files[level.active_cs_files.size] = file_name;
}

function cleanup_cs_file_objects(cs_file) {
  utility::flag_clear(cs_file + "\b6\x13X\x1e[\xcf\x05\xc0K");
  utility::flag_clear(cs_file);

  if(isDefined(level.cs_object_container[cs_file]) && isDefined(level.cs_object_container[cs_file].objects)) {
    temp_array = level.cs_object_container[cs_file].objects;

    for(i = 0; i < temp_array.size; i++) {
      object = temp_array[i];
      level.cs_object_container[cs_file].objects[i] = undefined;

      if(isstruct(object)) {
        utility::deletestruct_ref(object);
      }

      if(isent(object)) {
        object delete();
      }
    }
  }
}

function private clean_cs_file_structs_array(type, cs_file) {
  if(!utility::flag_exist("\xe2Z\xdd\xba)\xa3\xaf\xaf\xc91\xe7rf\x19\xdb\x05\xfcrLcQ\xf8\xd6\t]\x8a\x11")) {
    level.var_7a0b58c476a2cef3 = 0;
    utility::flag_init("\xe2Z\xdd\xba)\xa3\xaf\xaf\xc91\xe7rf\x19\xdb\x05\xfcrLcQ\xf8\xd6\t]\x8a\x11");
  } else {
    while(level.var_7a0b58c476a2cef3) {
      utility::flag_wait("\xe2Z\xdd\xba)\xa3\xaf\xaf\xc91\xe7rf\x19\xdb\x05\xfcrLcQ\xf8\xd6\t]\x8a\x11");
    }

    utility::flag_clear("\xe2Z\xdd\xba)\xa3\xaf\xaf\xc91\xe7rf\x19\xdb\x05\xfcrLcQ\xf8\xd6\t]\x8a\x11");
  }

  level.var_7a0b58c476a2cef3 = 1;
  typekeys = getarraykeys(level.struct_class_names[type]);
  waitframe();
  var_4fd7a6b0c7945568 = 50;
  var_a0870bbe9a0908a0 = 0;

  for(targetnameindex = 0; targetnameindex < typekeys.size; targetnameindex++) {
    newarray = [];

    if(targetnameindex % var_4fd7a6b0c7945568 == 0) {
      waitframe();
    }

    typekey = typekeys[targetnameindex];
    typekeysize = level.struct_class_names[type][typekey].size;

    for(index = 0; index < typekeysize; index++) {
      struct = level.struct_class_names[type][typekey][index];

      if(isDefined(struct) && (!isDefined(struct.var_29de1c8340f75a85) || struct.var_29de1c8340f75a85 != cs_file)) {
        newarray[newarray.size] = struct;
        continue;
      }

      var_a0870bbe9a0908a0++;
    }

    level.struct_class_names[type][typekey] = newarray;
  }

  utility::flag_set("\xe2Z\xdd\xba)\xa3\xaf\xaf\xc91\xe7rf\x19\xdb\x05\xfcrLcQ\xf8\xd6\t]\x8a\x11");
  level.var_7a0b58c476a2cef3 = 0;
  return var_a0870bbe9a0908a0;
}

function function_3c750111c1d423b1(cs_file) {
  types = ["\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc", "\x7fw*%A\xff", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*", "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13", "!DOn\xba'\xed\x8e&!\\", "s\xd8\x93-8t\xf5\xb0v+\x9b\x1d_\x9boGVw\xb79:C^"];
  var_a0870bbe9a0908a0 = 0;

  foreach(type in types) {
    var_a0870bbe9a0908a0 += clean_cs_file_structs_array(type, cs_file);
    waitframe();
  }

  return var_a0870bbe9a0908a0;
}

function s() {
  return spawnStruct();
}

function spawn_cover_nodes(struct_targetname) {
  node_structs = utility::getStructArray(struct_targetname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(struct in node_structs) {
    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    type = "\xcalv\xe9\xf1\xb1\x89\x96\x9d^#";

    switch (struct.nodetype) {
      case #"hash_4ddb655e251e06c8":
        type = "g\x1fWv\xec\xec@P(o";
        break;
      case #"hash_175771022bc5e75d":
        type = "c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2";
        break;
      case #"hash_9d76c99eddd14433":
        type = "\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce";
        break;
      case #"hash_f1676baca0ae608b":
        type = "\xcalv\xe9\xf1\xb1\x89\x96\x9d^#";
        break;
      case #"hash_8c335d77517de4f8":
        type = "C\xed;\xcar\b\xa1r\xdb\xael\x1a\x04Wi\xcd2\xedw";
        break;
      case #"hash_42d1769dd06f8045":
        type = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
        break;
      case #"hash_a315be2e1164ff6b":
        type = "\xf7\xd5d'hTb";
      case #"hash_d4850e4dfbc48417":
        type = "v0\x8c@\x88d";
        break;
    }

    targetname = undefined;

    if(isDefined(struct.node_targetname)) {
      targetname = struct.node_targetname;
    }

    spawnflags = 0;

    if(isDefined(struct.nostand) && int(struct.nostand) != 0 && struct.nostand != "\x99\xb0\xc67\x95") {
      spawnflags = 4;
    }

    if(isDefined(struct.nocrouch) && int(struct.nocrouch) != 0 && struct.nocrouch != "\x99\xb0\xc67\x95") {
      spawnflags += 8;
    }

    if(isDefined(struct.noprone) && int(struct.noprone) != 0 && struct.noprone != "\x99\xb0\xc67\x95") {
      spawnflags += 16;
    }

    struct.covernode = spawncovernode(struct.origin, struct.angles, type, spawnflags, targetname);

    if(isDefined(struct.radius)) {
      struct.covernode.radius = struct.radius;
    }
  }

  return node_structs;
}

function delete_covernodes(struct_targetname) {
  node_structs = utility::getStructArray(struct_targetname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(struct in node_structs) {
    if(isDefined(struct.covernode)) {
      despawncovernode(struct.covernode);
      struct.covernode = undefined;
    }
  }
}

function function_bbf9e0033f4ddb96() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  utility::flag_wait("\xac\x98\xfb\xf5x\\\xc5\xd7\xfd\xae\xc5\xe9\x9f");
  return_value = level.var_c8c131d2a5403872;
  level.var_c8c131d2a5403872++;
  return "\x11\xa7" + return_value;
}

function function_76e40d930c589ff1(create_script_file) {
  level.cs_scripts[level.cs_scripts.size] = create_script_file;
  level.scripted_spawner_func[level.scripted_spawner_func.size] = create_script_file;
}

function function_39e2894965579bf7() {
  foreach(var_d14fff107e5b9458 in level.cs_scripts) {
    profilestart();
    [[var_d14fff107e5b9458]]();
    profilestop();
  }

  utility::flag_set("n\x8es\xaa\xb4i1\x1fWp\xc0\x88C\xaf\xab\xb5du\xb3b\xe4\xb0`_s");
}