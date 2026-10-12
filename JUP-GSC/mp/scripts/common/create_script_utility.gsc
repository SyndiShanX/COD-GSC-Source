/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\create_script_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace create_script_utility;

function initialize_create_script() {
  init_create_script_for_level();
}

function init_create_script_for_level(bshouldthread) {
  if(isDefined(level.scripted_spawner_func)) {
    return;
  }

  level.threadedscriptspawners = istrue(bshouldthread);
  level.create_script_file_ids = [];
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
  level.var_fd1365ce671037db = 0;
}

function initialize_registered_create_script_files() {
  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      for(i = 0; i < level.scripted_spawner_func.size; i++) {
        [[level.scripted_spawner_func[i]]](1, "cs" + i);
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
      level.create_script_file_ids[script] = "cs" + index;
    }
  }

  if(isDefined(map)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = map;
  }
}

function initialize_create_script_file(file_name) {
  if(flag_exist(file_name)) {
    flag_set(file_name);

    if(flag_exist(file_name + "_completed")) {
      level endon("game_ended");
      flag_wait(file_name + "_completed");
    }
  }
}

function register_valid_gametypes_for_create_script(allowed_gametype) {
  if(!isDefined(level.allowed_gametypes)) {
    level.allowed_gametypes = [];
  }

  level.allowed_gametypes = array_add(level.allowed_gametypes, allowed_gametype);
}

function register_valid_objectives_for_create_script(allowed_objective) {
  if(!isDefined(level.allowed_objectives)) {
    level.allowed_objectives = [];
  }

  level.allowed_objectives = array_add(level.allowed_objectives, allowed_objective);
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

  if(scripts\engine\utility::issharedfuncdefined("create_script", "cleanupFuncInit")) {
    funcname = scripts\engine\utility::getsharedfunc("create_script", "cleanupFuncInit");
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

  if(scripts\engine\utility::issharedfuncdefined("create_script", "cleanupFuncInit")) {
    funcname = scripts\engine\utility::getsharedfunc("create_script", "cleanupFuncInit");
    [[funcname]](cs_file, self);
  }
}

function strike_additem(struct, index, cs_file, origin, angles, targetname, target, script_noteworthy, script_linkto, script_linkname, var_a1306ee53c20150f, var_e3c2f7a7f3d4cce6, radius, speed, spawnflags, script_unload) {
  level endon("game_ended");

  if(!struct object_is_valid()) {
    return;
  }

  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0) {
      waitframe();
    }
  }

  var_ed4382cb70a213e2 = 0;

  if(isDefined(origin)) {
    struct.origin = origin;
  }

  if(isDefined(angles)) {
    struct.angles = angles;
  } else if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  if(isDefined(targetname)) {
    var_ed4382cb70a213e2 = 1;
    struct.targetname = targetname;
  }

  if(isDefined(target)) {
    var_ed4382cb70a213e2 = 1;
    struct.target = target;
  }

  if(isDefined(script_noteworthy)) {
    var_ed4382cb70a213e2 = 1;
    struct.script_noteworthy = script_noteworthy;
  }

  if(isDefined(script_linkto)) {
    struct.script_linkto = script_linkto;
  }

  if(isDefined(script_linkname)) {
    var_ed4382cb70a213e2 = 1;
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

  translate_position_with_offset_data(cs_file, struct, var_a1306ee53c20150f, var_e3c2f7a7f3d4cce6);

  if(!isDefined(index)) {
    index = "_";
  }

  strike_fixautokvps(struct, index);
  typecast_kvps(struct);

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = struct;
  }

  if(isDefined(struct.model)) {
    if(istrue(struct.is_cs_model)) {
      struct.is_cs_model = undefined;
    }

    strike_modelcreate(struct, index);
    return;
  }

  if(isDefined(struct.is_cs_script_origin)) {
    struct.is_cs_script_origin = ter_op(struct.is_cs_script_origin == "1", 1, 0);
  }

  if(istrue(struct.is_cs_trigger)) {
    struct.is_cs_trigger = undefined;
    strike_triggercreate(struct, index, 1, struct.var_857f45e57f5d5a7a);
    struct.var_857f45e57f5d5a7a = undefined;
    return;
  }

  if(istrue(struct.is_cs_model)) {
    strike_modelcreate(struct, index);
    struct.is_cs_model = undefined;
    return;
  }

  if(istrue(struct.is_cs_script_origin)) {
    struct.is_cs_script_origin = undefined;
    strike_scriptorigincreate(struct, index);
    return;
  }

  if(isDefined(struct.targetname)) {
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
        addstruct(struct);
        break;
    }

    return;
  }

  addstruct(struct);
}

function object_is_valid() {
  gametype_allowed = 0;
  objective_allowed = 0;

  if(isDefined(level.allowed_gametypes)) {
    if(isDefined(self.script_gameobjectname)) {
      for(i = 0; i < level.allowed_gametypes.size; i++) {
        if(getsubstr(level.allowed_gametypes[i], 0, 1) == "!") {
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
        if(getsubstr(level.allowed_objectives[i], 0, 1) == "!") {
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

function translate_position_with_offset_data(cs_file, struct, var_5f0a2cdf1e857bac, var_82b752b102f67a72) {
  translate_and_rotate_from_level_overrides(cs_file, struct);

  if(isDefined(var_5f0a2cdf1e857bac)) {
    if(!isDefined(var_82b752b102f67a72)) {
      var_82b752b102f67a72 = (0, 0, 0);
    }

    obj_angles = (0, 0, 0);

    if(isDefined(struct.angles)) {
      obj_angles = struct.angles;
    }

    obj_origin = struct.origin;
    struct.origin = var_5f0a2cdf1e857bac + rotatevector(obj_origin, var_82b752b102f67a72);

    if(isDefined(struct.script_origin_other)) {
      struct.script_origin_other = var_5f0a2cdf1e857bac + rotatevector(struct.script_origin_other, var_82b752b102f67a72);
    }

    var_d241032d837036a4 = combineangles(var_82b752b102f67a72, obj_angles);
    struct.angles = var_d241032d837036a4;
  }
}

function translate_and_rotate_from_level_overrides(cs_file, struct) {
  if(isDefined(cs_file) && isDefined(level.cs_origin_offset) && isDefined(level.cs_angle_offset[cs_file])) {
    var_82b752b102f67a72 = level.cs_angle_offset[cs_file];
    var_5f0a2cdf1e857bac = level.cs_origin_offset[cs_file];
    obj_angles = (0, 0, 0);

    if(isDefined(struct.angles)) {
      obj_angles = struct.angles;
    }

    obj_origin = struct.origin;
    struct.origin = var_5f0a2cdf1e857bac + rotatevector(obj_origin, var_82b752b102f67a72);

    if(isDefined(struct.script_origin_other)) {
      struct.script_origin_other = var_5f0a2cdf1e857bac + rotatevector(struct.script_origin_other, var_82b752b102f67a72);
    }

    var_d241032d837036a4 = combineangles(var_82b752b102f67a72, obj_angles);
    struct.angles = var_d241032d837036a4;
  }
}

function strike_add_to_cs_arrays(cs_type, struct, index) {
  if(!getdvarint(@ "hash_ad6e2fed4a549f49", 0)) {
    return;
  }

  if(cs_type == "struct") {
    level.scripted_spawners[index][level.scripted_spawners[index].size] = struct;
  } else if(cs_type == "trigger") {
    level.scripted_spawners_triggers[index][level.scripted_spawners_triggers[index].size] = struct;
  } else if(cs_type == "model") {
    level.scripted_spawners_models[index][level.scripted_spawners_models[index].size] = struct;
  }

  if(cs_type == "<dev string:x1c>") {
    level.cs_scripted_spawners[index][level.cs_scripted_spawners[index].size] = struct;
    return;
  }

  if(cs_type == "<dev string:x26>") {
    level.cs_scripted_spawners_triggers[index][level.cs_scripted_spawners_triggers[index].size] = struct;
    return;
  }

  if(cs_type == "<dev string:x31>") {
    level.cs_scripted_spawners_models[index][level.cs_scripted_spawners_models[index].size] = struct;
  }
}

function strike_interactioncreate(struct, index) {
  addstruct(struct);
}

function strike_scriptorigincreate(struct, index) {
  model = spawn("script_origin", struct.origin);

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
  strike_add_to_cs_arrays("model", struct, index);

  if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  model = spawn("script_model", struct.origin);
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

function strike_triggercreate(struct, index, var_edb06d254fff788c, noent_volume) {
  strike_add_to_cs_arrays("trigger", struct, index);

  if(isDefined(struct.spawnflags)) {
    spawnflags = struct.spawnflags;
  } else {
    spawnflags = 0;
  }

  if(isDefined(struct.var_74e936bbadd15418) && isDefined(struct.var_750c4cbbadf7cc32)) {
    if(istrue(noent_volume)) {
      trigger = spawn("noent_volume_trigger_box", struct.origin, spawnflags, struct.var_74e936bbadd15418, struct.var_750c4cbbadf7cc32);
    } else {
      trigger = spawn("trigger_box", struct.origin, spawnflags, struct.var_74e936bbadd15418, struct.var_750c4cbbadf7cc32);
    }
  } else if(istrue(noent_volume)) {
    trigger = spawn("noent_volume_trigger_rotatable_radius", struct.origin, spawnflags, int(struct.radius), int(struct.height));
  } else {
    trigger = spawn("trigger_rotatable_radius", struct.origin, spawnflags, int(struct.radius), int(struct.height));
  }

  if(isDefined(struct.angles) && struct.angles != (0, 0, 0)) {
    if(istrue(var_edb06d254fff788c)) {
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
  if(isDefined(struct.target) && issubstr(struct.target, "auto")) {
    struct.target = "CS|" + index + struct.target;
  }

  if(isDefined(struct.targetname) && issubstr(struct.targetname, "auto")) {
    struct.targetname = "CS|" + index + struct.targetname;
  }

  if(isDefined(struct.script_linkto)) {
    new_linkto = "";
    str_toks = strtok(struct.script_linkto, " ");

    foreach(new_index, tok in str_toks) {
      if(new_index != 0) {
        new_linkto = new_linkto + " " + "CS|" + index + tok;
        continue;
      }

      new_linkto = new_linkto + "CS|" + index + tok;
    }

    struct.script_linkto = new_linkto;
  }

  if(isDefined(struct.script_linkname)) {
    struct.script_linkname = "CS|" + index + struct.script_linkname;
  }
}

function typecast_kvps(struct) {
  if(scripts\engine\utility::issharedfuncdefined("createScript", "typeCast")) {
    if(istrue(struct scripts\engine\utility::callsharedfunc("createScript", "typeCast"))) {
      return;
    }
  }

  if(istrue(struct.ishelistruct)) {
    if(isDefined(struct.script_unload)) {
      struct.script_unload = int(struct.script_unload);
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

  if(isDefined(struct.var_9e5f6ca242b92628)) {
    struct.var_9e5f6ca242b92628 = int(struct.var_9e5f6ca242b92628);
  }

  if(isDefined(struct.lookahead)) {
    struct.lookahead = int(struct.lookahead);
  }

  if(isDefined(struct.speed)) {
    struct.speed = int(struct.speed);
  }

  if(isDefined(struct.var_3f0312e6382c878f)) {
    if(struct.var_3f0312e6382c878f == "true" || struct.var_3f0312e6382c878f == "1") {
      struct.var_3f0312e6382c878f = 1;
    } else {
      struct.var_3f0312e6382c878f = 0;
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

  if(isDefined(struct.var_3efdd073323b953c)) {
    if(struct.var_3efdd073323b953c == "true" || struct.var_3efdd073323b953c == "1") {
      struct.var_3efdd073323b953c = 1;
    } else {
      struct.var_3efdd073323b953c = undefined;
    }
  }

  if(isDefined(struct.script_goalyaw)) {
    if(struct.script_goalyaw == "true" || struct.script_goalyaw == "1") {
      struct.script_goalyaw = 1;
    } else {
      struct.script_goalyaw = undefined;
    }
  }

  if(isDefined(struct.script_anglevehicle)) {
    if(struct.script_anglevehicle == "true" || struct.script_anglevehicle == "1") {
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
    if(isstring(struct.script_faceangles) && (struct.script_faceangles == "true" || struct.script_faceangles == "1")) {
      struct.script_faceangles = 1;
    }

    if(int(struct.script_faceangles) != 0) {
      struct.script_faceangles = 1;
    } else {
      struct.script_faceangles = undefined;
    }
  }

  if(isDefined(struct.script_cleanexit)) {
    if(struct.script_cleanexit == "true" || struct.script_cleanexit == "1") {
      struct.script_cleanexit = 1;
      return;
    }

    struct.script_cleanexit = undefined;
  }
}

function cs_is_starttime() {
  if(utility::iscp()) {
    return (gettime() <= level.starttime + 250);
  }

  return gettime() <= level.starttimeutcseconds + 250;
}

function cs_init_flags(newitem) {
  if(!flag_exist("strike_init_done")) {
    flag_init("strike_init_done");
  }

  if(!flag_exist("create_script_initialized")) {
    flag_init("create_script_initialized");
  }

  newitem.objects = [];
  newitem ent_flag_init("cs_structs_complete");
  newitem ent_flag_init("cs_models_complete");
  newitem ent_flag_init("cs_triggers_complete");
}

function cs_flags_init(newitem) {
  if(!flag_exist("strike_init_done")) {
    flag_init("strike_init_done");
  }

  if(!flag_exist("create_script_initialized")) {
    flag_init("create_script_initialized");
  }

  newitem.objects = [];
  newitem ent_flag_init("cs_objects_created");
}

function wait_for_flags(newitem, complete_flag) {
  if(newitem ent_flag_exist("cs_structs_complete")) {
    newitem ent_flag_wait("cs_structs_complete");
  }

  if(newitem ent_flag_exist("cs_triggers_complete")) {
    newitem ent_flag_wait("cs_triggers_complete");
  }

  if(newitem ent_flag_exist("cs_objects_created")) {
    newitem ent_flag_wait("cs_objects_created");
  }

  flag_set(complete_flag + "_completed");

  if(cs_is_starttime()) {
    endcreatescript(newitem);
  }
}

function endcreatescript(newitem) {
  if(isDefined(level.createscriptfilesinitialized)) {
    level.createscriptfilesinitialized++;

    if(level.createscriptfilesinitialized >= level.scripted_spawner_func.size) {
      flag_set("strike_init_done");
      flag_set("create_script_initialized");
    }

    return;
  }

  flag_set("strike_init_done");
  flag_set("create_script_initialized");
}

function wait_for_cs_flag(waittill_flag) {
  level endon("game_ended");
  flag_init(waittill_flag + "_completed");

  if(!should_wait_for_cs_flag(waittill_flag)) {
    endcreatescript();
    flag_wait(waittill_flag);
  }
}

function should_wait_for_cs_flag(waittill_flag) {
  toks = strtok(getDvar(@ "hash_db88b998734440cc", ""), " ");
  toks = array_combine(toks, level.active_cs_files);

  if(toks.size < 1) {
    return true;
  }

  for(i = 0; i < toks.size; i++) {
    tok = toks[i];

    if(tok == "all") {
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
  flag_clear(cs_file + "_completed");
  flag_clear(cs_file);

  if(isDefined(level.cs_object_container[cs_file]) && isDefined(level.cs_object_container[cs_file].objects)) {
    temp_array = level.cs_object_container[cs_file].objects;

    for(i = 0; i < temp_array.size; i++) {
      object = temp_array[i];
      level.cs_object_container[cs_file].objects[i] = undefined;

      if(isstruct(object)) {
        deletestruct_ref(object);
      }

      if(isent(object)) {
        object delete();
      }
    }
  }
}

function private clean_cs_file_structs_array(type, cs_file) {
  if(!flag_exist("clean_cs_file_structs_array")) {
    level.var_f21943413f226f76 = 0;
    flag_init("clean_cs_file_structs_array");
  } else {
    while(level.var_f21943413f226f76) {
      flag_wait("clean_cs_file_structs_array");
    }

    flag_clear("clean_cs_file_structs_array");
  }

  level.var_f21943413f226f76 = 1;
  typekeys = getarraykeys(level.struct_class_names[type]);
  waitframe();
  var_de8e12bdbe3a8729 = 50;
  var_5f8f62a5487a6e5d = 0;

  for(targetnameindex = 0; targetnameindex < typekeys.size; targetnameindex++) {
    newarray = [];

    if(targetnameindex % var_de8e12bdbe3a8729 == 0) {
      waitframe();
    }

    typekey = typekeys[targetnameindex];
    typekeysize = level.struct_class_names[type][typekey].size;

    for(index = 0; index < typekeysize; index++) {
      struct = level.struct_class_names[type][typekey][index];

      if(isDefined(struct) && (!isDefined(struct.cs_flag) || struct.cs_flag != cs_file)) {
        newarray[newarray.size] = struct;
        continue;
      }

      var_5f8f62a5487a6e5d++;
    }

    level.struct_class_names[type][typekey] = newarray;
  }

  flag_set("clean_cs_file_structs_array");
  level.var_f21943413f226f76 = 0;
  return var_5f8f62a5487a6e5d;
}

function function_71a564b3bc009618(cs_file) {
  types = ["targetname", "target", "script_noteworthy", "script_linkname", "variantname"];
  var_5f8f62a5487a6e5d = 0;

  foreach(type in types) {
    var_5f8f62a5487a6e5d += clean_cs_file_structs_array(type, cs_file);
    waitframe();
  }

  return var_5f8f62a5487a6e5d;
}

function s() {
  return spawnStruct();
}

function spawn_cover_nodes(struct_targetname) {
  node_structs = getStructArray(struct_targetname, "targetname");

  foreach(struct in node_structs) {
    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    type = "Cover Stand";

    switch (struct.nodetype) {
      case #"hash_4ddb655e251e06c8":
        type = "Cover Left";
        break;
      case #"hash_175771022bc5e75d":
        type = "Cover Right";
        break;
      case #"hash_9d76c99eddd14433":
        type = "Cover Crouch";
        break;
      case #"hash_f1676baca0ae608b":
        type = "Cover Stand";
        break;
      case #"hash_8c335d77517de4f8":
        type = "Cover Crouch Window";
        break;
      case #"hash_42d1769dd06f8045":
        type = "Conceal Crouch";
        break;
      case #"hash_a315be2e1164ff6b":
        type = "Exposed";
      case #"hash_d4850e4dfbc48417":
        type = "Turret";
        break;
    }

    targetname = undefined;

    if(isDefined(struct.node_targetname)) {
      targetname = struct.node_targetname;
    }

    spawnflags = 0;

    if(isDefined(struct.nostand) && int(struct.nostand) != 0 && struct.nostand != "false") {
      spawnflags = 4;
    }

    if(isDefined(struct.nocrouch) && int(struct.nocrouch) != 0 && struct.nocrouch != "false") {
      spawnflags += 8;
    }

    if(isDefined(struct.noprone) && int(struct.noprone) != 0 && struct.noprone != "false") {
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
  node_structs = getStructArray(struct_targetname, "targetname");

  foreach(struct in node_structs) {
    if(isDefined(struct.covernode)) {
      despawncovernode(struct.covernode);
      struct.covernode = undefined;
    }
  }
}

function function_b055d49370405173() {
  return_value = level.var_fd1365ce671037db;
  level.var_fd1365ce671037db++;
  return "cs" + return_value;
}