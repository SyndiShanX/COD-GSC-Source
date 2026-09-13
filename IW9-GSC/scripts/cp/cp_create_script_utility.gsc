/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_create_script_utility.gsc
***************************************************/

initialize_create_script() {
  init_create_script_for_level();
}

init_create_script_for_level(_id_D118031DB9B990AA) {
  if(isDefined(level.scripted_spawner_func)) {
    return;
  }
  level.threadedscriptspawners = istrue(_id_D118031DB9B990AA);
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
}

initialize_registered_create_script_files() {
  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.scripted_spawner_func.size; _id_AC0E594AC96AA3A8++)
        [[level.scripted_spawner_func[_id_AC0E594AC96AA3A8]]](1, "cs" + _id_AC0E594AC96AA3A8);
    } else if(istrue(level.threadedscriptspawners))
      [[level.scripted_spawner_func]](1);
    else
      [[level.scripted_spawner_func]]();
  }
}

register_create_script_arrays(script, _id_365929041E4386ED, index, func) {
  if(isDefined(func))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = func;

  if(isDefined(script))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = script;

  if(isDefined(_id_365929041E4386ED))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = _id_365929041E4386ED;

  if(isDefined(index))
    level.create_script_file_ids[script] = "cs" + index;
}

initialize_create_script_file(_id_B3D026D11EC695FB) {
  if(scripts\engine\utility::flag_exist(_id_B3D026D11EC695FB)) {
    scripts\engine\utility::flag_set(_id_B3D026D11EC695FB);

    if(scripts\engine\utility::flag_exist(_id_B3D026D11EC695FB + "_completed")) {
      level endon("game_ended");
      scripts\engine\utility::flag_wait(_id_B3D026D11EC695FB + "_completed");
    }
  }
}

register_valid_gametypes_for_create_script(_id_61FB539E50D5658A) {
  if(!isDefined(level.allowed_gametypes))
    level.allowed_gametypes = [];

  level.allowed_gametypes = scripts\engine\utility::array_add(level.allowed_gametypes, _id_61FB539E50D5658A);
}

register_valid_objectives_for_create_script(_id_9AF68064717C528B) {
  if(!isDefined(level.allowed_objectives))
    level.allowed_objectives = [];

  level.allowed_objectives = scripts\engine\utility::array_add(level.allowed_objectives, _id_9AF68064717C528B);
}

strike_setup_arrays(index, _id_9F279646ED66AB76) {
  if(!isDefined(level.scripted_spawners))
    level.scripted_spawners = [];

  if(!isDefined(level.scripted_spawners_triggers))
    level.scripted_spawners_triggers = [];

  if(!isDefined(level.scripted_spawners_models))
    level.scripted_spawners_models = [];

  if(!isDefined(level.cs_origin_offset))
    level.cs_origin_offset = [];

  if(!isDefined(level.cs_angle_offset))
    level.cs_angle_offset = [];

  if(!isDefined(level.cs_scripted_spawners))
    level.cs_scripted_spawners = [];

  if(!isDefined(level.cs_scripted_spawners_triggers))
    level.cs_scripted_spawners_triggers = [];

  if(!isDefined(level.cs_scripted_spawners_models))
    level.cs_scripted_spawners_models = [];

  if(isDefined(index) && !isDefined(level.scripted_spawners[index]))
    level.scripted_spawners[index] = [];

  if(isDefined(index) && !isDefined(level.scripted_spawners_triggers[index]))
    level.scripted_spawners_triggers[index] = [];

  if(isDefined(index) && !isDefined(level.scripted_spawners_models[index]))
    level.scripted_spawners_models[index] = [];

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners[index]))
    level.cs_scripted_spawners[index] = [];

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_triggers[index]))
    level.cs_scripted_spawners_triggers[index] = [];

  if(isDefined(index) && !isDefined(level.cs_scripted_spawners_models[index]))
    level.cs_scripted_spawners_models[index] = [];

  if(!isDefined(level.cs_object_container))
    level.cs_object_container = [];

  if(isDefined(_id_9F279646ED66AB76) && !isDefined(level.cs_object_container[_id_9F279646ED66AB76]))
    level.cs_object_container[_id_9F279646ED66AB76] = self;
}

strike_additem(struct, index, _id_9F279646ED66AB76, origin, angles, targetname, target, script_noteworthy, script_linkto, script_linkname, _id_A1306EE53C20150F, _id_E3C2F7A7F3D4CCE6, radius, speed, spawnflags, script_unload) {
  level endon("game_ended");

  if(!struct object_is_valid()) {
    return;
  }
  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0)
      waitframe();
  }

  if(isDefined(origin))
    struct.origin = origin;

  if(isDefined(angles))
    struct.angles = angles;
  else if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  if(isDefined(targetname))
    struct.targetname = targetname;

  if(isDefined(target))
    struct.target = target;

  if(isDefined(script_noteworthy))
    struct.script_noteworthy = script_noteworthy;

  if(isDefined(script_linkto))
    struct.script_linkto = script_linkto;

  if(isDefined(script_linkname))
    struct.script_linkname = script_linkname;

  if(isDefined(speed))
    struct.speed = speed;

  if(isDefined(radius))
    struct.radius = radius;

  if(isDefined(spawnflags))
    struct.spawnflags = int(spawnflags);

  if(isDefined(script_unload))
    struct.script_unload = script_unload;

  translate_position_with_offset_data(_id_9F279646ED66AB76, struct, _id_A1306EE53C20150F, _id_E3C2F7A7F3D4CCE6);

  if(!isDefined(index))
    index = "_";

  strike_fixautokvps(struct, index);
  typecast_kvps(struct);

  if(isDefined(self.objects))
    self.objects[self.objects.size] = struct;

  if(isDefined(struct.model)) {
    if(istrue(struct.is_cs_model))
      struct.is_cs_model = undefined;

    strike_modelcreate(struct, index);
  } else {
    if(isDefined(struct.targetname)) {
      if(istrue(struct.is_cs_trigger)) {
        struct.is_cs_trigger = undefined;
        strike_triggercreate(struct, index, 1);
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

      switch (struct.targetname) {
        case "trigger_spawn":
          strike_triggercreate(struct, index);
          break;
        case "trigger_fallback":
          strike_triggercreate(struct, index);
          break;
        case "module_update":
          strike_triggercreate(struct, index, 1);
          break;
        case "cs_trigger":
          strike_triggercreate(struct, index, 1);
          break;
        case "interaction":
          strike_interactioncreate(struct, index);
          break;
        case "trigger_kill_floodspawner":
          strike_triggercreate(struct, index, 1);
          break;
        default:
          scripts\engine\utility::_id_1F6C1A9B7564DC61(struct);
          break;
      }

      return;
      return;
      return;
      return;
    }

    scripts\engine\utility::_id_1F6C1A9B7564DC61(struct);
  }
}

object_is_valid() {
  _id_EE2438927A30059C = 0;
  _id_0E83560F72B6E4E7 = 0;

  if(isDefined(level.allowed_gametypes)) {
    if(isDefined(self.script_gameobjectname)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.allowed_gametypes.size; _id_AC0E594AC96AA3A8++) {
        if(getsubstr(level.allowed_gametypes[_id_AC0E594AC96AA3A8], 0, 1) == "!")
          _id_E88E346FEAB6A5E9 = 1;
        else
          _id_E88E346FEAB6A5E9 = 0;

        if(is_object_allowed_in_gametype(self.script_gameobjectname, level.allowed_gametypes[_id_AC0E594AC96AA3A8]) != _id_E88E346FEAB6A5E9) {
          _id_EE2438927A30059C = 1;
          break;
        }
      }
    } else
      _id_EE2438927A30059C = 1;
  } else
    _id_EE2438927A30059C = 1;

  if(isDefined(level.allowed_objectives)) {
    if(isDefined(self.script_gameobjectname)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.allowed_objectives.size; _id_AC0E594AC96AA3A8++) {
        if(getsubstr(level.allowed_objectives[_id_AC0E594AC96AA3A8], 0, 1) == "!")
          _id_E88E346FEAB6A5E9 = 1;
        else
          _id_E88E346FEAB6A5E9 = 0;

        if(is_object_allowed_in_gametype(self.script_gameobjectname, level.allowed_objectives[_id_AC0E594AC96AA3A8]) != _id_E88E346FEAB6A5E9) {
          _id_0E83560F72B6E4E7 = 1;
          break;
        }
      }
    } else
      _id_0E83560F72B6E4E7 = 1;
  } else
    _id_0E83560F72B6E4E7 = 1;

  return istrue(_id_EE2438927A30059C && _id_0E83560F72B6E4E7);
}

is_object_allowed_in_gametype(_id_5598168FD5B0E734, gametype) {
  if(!isDefined(_id_5598168FD5B0E734) || _id_5598168FD5B0E734 == "" || !isDefined(gametype) || gametype == "")
    return 0;

  return issubstr(_id_5598168FD5B0E734, gametype);
}

translate_position_with_offset_data(_id_9F279646ED66AB76, struct, _id_5F0A2CDF1E857BAC, _id_82B752B102F67A72) {
  translate_and_rotate_from_level_overrides(_id_9F279646ED66AB76, struct);

  if(isDefined(_id_5F0A2CDF1E857BAC)) {
    if(!isDefined(_id_82B752B102F67A72))
      _id_82B752B102F67A72 = (0, 0, 0);

    _id_8DD49492E28FCABB = (0, 0, 0);

    if(isDefined(struct.angles))
      _id_8DD49492E28FCABB = struct.angles;

    _id_B0FDD17853C7B165 = struct.origin;
    struct.origin = _id_5F0A2CDF1E857BAC + rotatevector(_id_B0FDD17853C7B165, _id_82B752B102F67A72);

    if(isDefined(struct.script_origin_other))
      struct.script_origin_other = _id_5F0A2CDF1E857BAC + rotatevector(struct.script_origin_other, _id_82B752B102F67A72);

    _id_D241032D837036A4 = combineangles(_id_82B752B102F67A72, _id_8DD49492E28FCABB);
    struct.angles = _id_D241032D837036A4;
  }
}

translate_and_rotate_from_level_overrides(_id_9F279646ED66AB76, struct) {
  if(isDefined(_id_9F279646ED66AB76) && isDefined(level.cs_origin_offset) && isDefined(level.cs_angle_offset[_id_9F279646ED66AB76])) {
    _id_82B752B102F67A72 = level.cs_angle_offset[_id_9F279646ED66AB76];
    _id_5F0A2CDF1E857BAC = level.cs_origin_offset[_id_9F279646ED66AB76];
    _id_8DD49492E28FCABB = (0, 0, 0);

    if(isDefined(struct.angles))
      _id_8DD49492E28FCABB = struct.angles;

    _id_B0FDD17853C7B165 = struct.origin;
    struct.origin = _id_5F0A2CDF1E857BAC + rotatevector(_id_B0FDD17853C7B165, _id_82B752B102F67A72);

    if(isDefined(struct.script_origin_other))
      struct.script_origin_other = _id_5F0A2CDF1E857BAC + rotatevector(struct.script_origin_other, _id_82B752B102F67A72);

    _id_D241032D837036A4 = combineangles(_id_82B752B102F67A72, _id_8DD49492E28FCABB);
    struct.angles = _id_D241032D837036A4;
  }
}

strike_add_to_cs_arrays(_id_3215B787C2BE06C8, struct, index) {
  if(!getdvarint("dvar_AD6E2FED4A549F49", 0)) {
    return;
  }
  if(_id_3215B787C2BE06C8 == "struct")
    level.scripted_spawners[index][level.scripted_spawners[index].size] = struct;
  else if(_id_3215B787C2BE06C8 == "trigger")
    level.scripted_spawners_triggers[index][level.scripted_spawners_triggers[index].size] = struct;
  else if(_id_3215B787C2BE06C8 == "model")
    level.scripted_spawners_models[index][level.scripted_spawners_models[index].size] = struct;
}

strike_interactioncreate(struct, index) {
  scripts\engine\utility::_id_1F6C1A9B7564DC61(struct);
}

strike_scriptorigincreate(struct, index) {
  model = spawn("script_origin", struct.origin);

  if(!isDefined(struct.angles))
    model.angles = (0, 0, 0);
  else
    model.angles = struct.angles;

  if(isDefined(struct.model))
    model setModel(struct.model);

  if(isDefined(struct.targetname))
    model.targetname = struct.targetname;

  if(isDefined(struct.script_noteworthy))
    model.script_noteworthy = struct.script_noteworthy;

  if(isDefined(struct.script_linkto))
    model.script_linkto = struct.script_linkto;

  if(isDefined(struct.script_linkname))
    model.script_linkname = struct.script_linkname;

  if(isDefined(struct.target))
    model.target = struct.target;

  model.struct = struct;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = model;
}

strike_modelcreate(struct, index) {
  strike_add_to_cs_arrays("model", struct, index);
  model = spawn("script_model", struct.origin);

  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  model.angles = struct.angles;
  model setModel(struct.model);

  if(isDefined(struct.targetname))
    model.targetname = struct.targetname;

  if(isDefined(struct.script_noteworthy))
    model.script_noteworthy = struct.script_noteworthy;

  if(isDefined(struct.script_linkto))
    model.script_linkto = struct.script_linkto;

  if(isDefined(struct.script_linkname))
    model.script_linkname = struct.script_linkname;

  if(isDefined(struct.target))
    model.target = struct.target;

  if(isDefined(struct.name))
    model.name = struct.name;

  model.struct = struct;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = model;
}

strike_triggercreate(struct, index, _id_EDB06D254FFF788C) {
  strike_add_to_cs_arrays("trigger", struct, index);
  trigger = spawn("trigger_rotatable_radius", struct.origin, 0, int(struct.radius), int(struct.height));

  if(isDefined(struct.angles) && struct.angles != (0, 0, 0)) {
    if(istrue(_id_EDB06D254FFF788C))
      trigger.angles = struct.angles;
    else
      trigger.angles = (-90, 0, 0) + struct.angles;
  }

  trigger.struct = struct;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = trigger;

  trigger strike_triggerassignvalues(struct);
}

strike_triggerassignvalues(struct) {
  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  if(isDefined(struct.script_label))
    self.script_label = struct.script_label;

  if(isDefined(struct.script_function))
    self.script_function = struct.script_function;

  if(isDefined(struct.script_noteworthy))
    self.script_noteworthy = struct.script_noteworthy;

  if(isDefined(struct.script_gesture))
    self.script_gesture = struct.script_gesture;

  if(isDefined(struct.target))
    self.target = struct.target;

  if(isDefined(struct.script_wtf))
    self.script_wtf = struct.script_wtf;

  if(isDefined(struct.script_flag))
    self.script_flag = struct.script_flag;

  if(isDefined(struct.script_linkto))
    self.script_linkto = struct.script_linkto;

  if(isDefined(struct.script_linkname))
    self.script_linkname = struct.script_linkname;

  if(isDefined(struct.groupname))
    self.groupname = struct.groupname;

  if(isDefined(struct.script_count))
    self.script_count = struct.script_count;

  if(isDefined(struct.script_count_min))
    self.script_count_min = struct.script_count_min;

  if(isDefined(struct.script_count_max))
    self.script_count_max = struct.script_count_max;

  if(isDefined(struct.script_maxdist))
    self.script_maxdist = struct.script_maxdist;

  self.targetname = struct.targetname;
}

strike_fixautokvps(struct, index) {
  if(isDefined(struct.target) && issubstr(struct.target, "auto"))
    struct.target = "CS|" + index + struct.target;

  if(isDefined(struct.targetname) && issubstr(struct.targetname, "auto"))
    struct.targetname = "CS|" + index + struct.targetname;

  if(isDefined(struct.script_linkto)) {
    _id_10744F696C62CE23 = "";
    _id_58C555D673EEB36E = strtok(struct.script_linkto, " ");

    foreach(_id_12EBA3D580C9458A, _id_E97377032A878881 in _id_58C555D673EEB36E) {
      if(_id_12EBA3D580C9458A != 0) {
        if(int(struct.script_linkto) == 0)
          _id_10744F696C62CE23 = _id_10744F696C62CE23 + " " + _id_E97377032A878881;
        else
          _id_10744F696C62CE23 = _id_10744F696C62CE23 + " " + "CS|" + index + _id_E97377032A878881;

        continue;
      }

      if(int(struct.script_linkto) == 0) {
        _id_10744F696C62CE23 = _id_10744F696C62CE23 + _id_E97377032A878881;
        continue;
      }

      _id_10744F696C62CE23 = _id_10744F696C62CE23 + "CS|" + index + _id_E97377032A878881;
    }

    struct.script_linkto = _id_10744F696C62CE23;
  }

  if(isDefined(struct.script_linkname)) {
    if(int(struct.script_linkname) != 0)
      struct.script_linkname = "CS|" + index + struct.script_linkname;
  }
}

typecast_kvps(struct) {
  if(istrue(struct.ishelistruct)) {
    if(isDefined(struct.script_unload))
      struct.script_unload = int(struct.script_unload);
  }

  if(isDefined(struct.script_wait_min))
    struct.script_wait_min = float(struct.script_wait_min);

  if(isDefined(struct.script_wait_max))
    struct.script_wait_max = float(struct.script_wait_max);

  if(isDefined(struct.script_wait_add))
    struct.script_wait_add = float(struct.script_wait_add);

  if(isDefined(struct.script_brake))
    struct.script_brake = float(struct.script_brake);

  if(isDefined(struct.lookahead))
    struct.lookahead = int(struct.lookahead);

  if(isDefined(struct.speed))
    struct.speed = int(struct.speed);

  if(isDefined(struct.script_accel))
    struct.script_accel = int(struct.script_accel);

  if(isDefined(struct.script_decel))
    struct.script_decel = int(struct.script_decel);

  if(isDefined(struct.script_speed))
    struct.script_speed = int(struct.script_speed);

  if(isDefined(struct.script_goalyaw)) {
    if(struct.script_goalyaw == "true" || struct.script_goalyaw == "1")
      struct.script_goalyaw = 1;
    else
      struct.script_goalyaw = undefined;
  }

  if(isDefined(struct.script_anglevehicle)) {
    if(struct.script_anglevehicle == "true" || struct.script_anglevehicle == "1")
      struct.script_goalyaw = 1;
    else
      struct.script_goalyaw = undefined;
  }

  if(isDefined(struct.script_delay))
    struct.script_delay = float(struct.script_delay);

  if(isDefined(struct.script_ignoreme))
    struct.script_ignoreme = int(struct.script_ignoreme);

  if(isDefined(struct.script_ignoreall))
    struct.script_ignoreall = int(struct.script_ignoreall);

  if(isDefined(struct.script_death))
    struct.script_death = int(struct.script_death);

  if(isDefined(struct.script_wait))
    struct.script_wait = float(struct.script_wait);

  if(isDefined(struct.script_forcespawn))
    struct.script_forcespawn = int(struct.script_forcespawn);

  if(isDefined(struct.script_timer))
    struct.script_timer = int(struct.script_timer);

  if(isDefined(struct.script_dist_only))
    struct.script_dist_only = int(struct.script_dist_only) * int(struct.script_dist_only);

  if(isDefined(struct.script_speed))
    struct.script_speed = int(struct.script_speed);

  if(isDefined(struct.script_count))
    struct.script_count = int(struct.script_count);

  if(isDefined(struct.script_radius))
    struct.script_radius = int(struct.script_radius);

  if(isDefined(struct.script_delay_min))
    struct.script_delay_min = float(struct.script_delay_min);

  if(isDefined(struct.script_delay_max))
    struct.script_delay_max = float(struct.script_delay_max);

  if(isDefined(struct.script_escalation_level))
    struct.script_escalation_level = int(struct.script_escalation_level);

  if(isDefined(struct.script_goalheight))
    struct.script_goalheight = int(struct.script_goalheight);

  if(isDefined(struct.script_timeout))
    struct.script_timeout = float(struct.script_timeout);

  if(isDefined(struct.script_pacifist))
    struct.script_pacifist = int(struct.script_pacifist);

  if(isDefined(struct.script_forcespawn))
    struct.script_forcespawn = int(struct.script_forcespawn);

  if(isDefined(struct.dontkilloff))
    struct.dontkilloff = int(struct.dontkilloff);

  if(isDefined(struct.script_origin_other))
    struct.script_origin_other = struct.script_origin_other;

  if(isDefined(struct.script_dot))
    struct.script_dot = int(struct.script_dot);

  if(isDefined(struct.script_ignoreall))
    struct.script_ignoreall = int(struct.script_ignoreall);

  if(isDefined(struct.script_stopnode))
    struct.script_stopnode = int(struct.script_stopnode);
}

cs_is_starttime() {
  if(scripts\common\utility::iscp())
    return gettime() <= level.starttime + 250;
  else
    return gettime() <= level.starttimeutcseconds + 250;
}

cs_init_flags(_id_01315B36154A5E3E) {
  if(!scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_init("strike_init_done");

  if(!scripts\engine\utility::flag_exist("create_script_initialized"))
    scripts\engine\utility::flag_init("create_script_initialized");

  _id_01315B36154A5E3E.objects = [];
  _id_01315B36154A5E3E scripts\engine\utility::ent_flag_init("cs_structs_complete");
  _id_01315B36154A5E3E scripts\engine\utility::ent_flag_init("cs_models_complete");
  _id_01315B36154A5E3E scripts\engine\utility::ent_flag_init("cs_triggers_complete");
}

cs_flags_init(_id_01315B36154A5E3E) {
  if(!scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_init("strike_init_done");

  if(!scripts\engine\utility::flag_exist("create_script_initialized"))
    scripts\engine\utility::flag_init("create_script_initialized");

  _id_01315B36154A5E3E.objects = [];
  _id_01315B36154A5E3E scripts\engine\utility::ent_flag_init("cs_structs_complete");
}

wait_for_flags(_id_01315B36154A5E3E, _id_039DC2B41CCB722D) {
  if(_id_01315B36154A5E3E scripts\engine\utility::ent_flag_exist("cs_structs_complete"))
    _id_01315B36154A5E3E scripts\engine\utility::ent_flag_wait("cs_structs_complete");

  if(_id_01315B36154A5E3E scripts\engine\utility::ent_flag_exist("cs_models_complete"))
    _id_01315B36154A5E3E scripts\engine\utility::ent_flag_wait("cs_models_complete");

  if(_id_01315B36154A5E3E scripts\engine\utility::ent_flag_exist("cs_triggers_complete"))
    _id_01315B36154A5E3E scripts\engine\utility::ent_flag_wait("cs_triggers_complete");

  scripts\engine\utility::flag_set(_id_039DC2B41CCB722D + "_completed");

  if(cs_is_starttime())
    endcreatescript(_id_01315B36154A5E3E);
}

endcreatescript(_id_01315B36154A5E3E) {
  if(isDefined(level.createscriptfilesinitialized)) {
    level.createscriptfilesinitialized++;

    if(level.createscriptfilesinitialized >= level.scripted_spawner_func.size) {
      scripts\engine\utility::flag_set("strike_init_done");
      scripts\engine\utility::flag_set("create_script_initialized");
    }
  } else {
    scripts\engine\utility::flag_set("strike_init_done");
    scripts\engine\utility::flag_set("create_script_initialized");
  }
}

wait_for_cs_flag(_id_82097CDAC1C61CCE) {
  level endon("game_ended");
  scripts\engine\utility::flag_init(_id_82097CDAC1C61CCE + "_completed");

  if(!should_wait_for_cs_flag(_id_82097CDAC1C61CCE)) {
    endcreatescript();
    scripts\engine\utility::flag_wait(_id_82097CDAC1C61CCE);
  }
}

should_wait_for_cs_flag(_id_82097CDAC1C61CCE) {
  _id_F077ADF688122C36 = strtok(getDvar("dvar_DB88B998734440CC", ""), " ");
  _id_F077ADF688122C36 = scripts\engine\utility::array_combine(_id_F077ADF688122C36, level.active_cs_files);

  if(_id_F077ADF688122C36.size < 1)
    return 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F077ADF688122C36.size; _id_AC0E594AC96AA3A8++) {
    _id_E97377032A878881 = _id_F077ADF688122C36[_id_AC0E594AC96AA3A8];

    if(_id_E97377032A878881 == "all")
      return 1;

    if(_id_82097CDAC1C61CCE == _id_E97377032A878881)
      return 1;
  }

  return 0;
}

register_cs_offsets(_id_9F279646ED66AB76, origin_offset, angle_offset) {
  if(isDefined(origin_offset))
    level.cs_origin_offset[_id_9F279646ED66AB76] = origin_offset;

  if(isDefined(angle_offset))
    level.cs_angle_offset[_id_9F279646ED66AB76] = angle_offset;
}

set_cs_file_dvar(_id_B3D026D11EC695FB) {
  level.active_cs_files[level.active_cs_files.size] = _id_B3D026D11EC695FB;
}

cleanup_cs_file_objects(_id_9F279646ED66AB76) {
  scripts\engine\utility::flag_clear(_id_9F279646ED66AB76 + "_completed");
  scripts\engine\utility::flag_clear(_id_9F279646ED66AB76);

  if(isDefined(level.cs_object_container[_id_9F279646ED66AB76]) && isDefined(level.cs_object_container[_id_9F279646ED66AB76].objects)) {
    _id_6D906809844C7CB1 = level.cs_object_container[_id_9F279646ED66AB76].objects;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D906809844C7CB1.size; _id_AC0E594AC96AA3A8++) {
      object = _id_6D906809844C7CB1[_id_AC0E594AC96AA3A8];
      level.cs_object_container[_id_9F279646ED66AB76].objects[_id_AC0E594AC96AA3A8] = undefined;

      if(isstruct(object))
        scripts\engine\utility::deletestruct_ref(object);

      if(isent(object))
        object delete();
    }
  }
}

s() {
  return spawnStruct();
}

spawn_cover_nodes(_id_2D486638FB4FCC1F) {
  _id_25189A7111F6896C = scripts\engine\utility::getStructArray(_id_2D486638FB4FCC1F, "targetname");

  foreach(struct in _id_25189A7111F6896C) {
    if(!isDefined(struct.angles))
      struct.angles = (0, 0, 0);

    type = "Cover Stand";

    switch (struct.nodetype) {
      case "cover_left":
        type = "Cover Left";
        break;
      case "cover_right":
        type = "Cover Right";
        break;
      case "cover_crouch":
        type = "Cover Crouch";
        break;
      case "cover_stand":
        type = "Cover Stand";
        break;
      case "cover_crouch_window":
        type = "Cover Crouch Window";
        break;
      case "conceal_crouch":
        type = "Conceal Crouch";
        break;
      case "cover_exposed":
        type = "Exposed";
      case "turret":
        type = "Turret";
        break;
    }

    targetname = undefined;

    if(isDefined(struct.node_targetname))
      targetname = struct.node_targetname;

    spawnflags = 0;

    if(isDefined(struct.nostand) && int(struct.nostand) != 0 && struct.nostand != "false")
      spawnflags = 4;

    if(isDefined(struct.nocrouch) && int(struct.nocrouch) != 0 && struct.nocrouch != "false")
      spawnflags = spawnflags + 8;

    if(isDefined(struct.noprone) && int(struct.noprone) != 0 && struct.noprone != "false")
      spawnflags = spawnflags + 16;

    struct.covernode = spawncovernode(struct.origin, struct.angles, type, spawnflags, targetname);

    if(isDefined(struct.radius))
      struct.covernode.radius = struct.radius;
  }

  return _id_25189A7111F6896C;
}

delete_covernodes(_id_2D486638FB4FCC1F) {
  _id_25189A7111F6896C = scripts\engine\utility::getStructArray(_id_2D486638FB4FCC1F, "targetname");

  foreach(struct in _id_25189A7111F6896C) {
    if(isDefined(struct.covernode)) {
      despawncovernode(struct.covernode);
      struct.covernode = undefined;
    }
  }
}