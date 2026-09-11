/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\so_trigger.gsc
***********************************************/

function thermitestucktoshield() {
  struct_set_fields();
}

function struct_set_fields(var_0) {
  if(isDefined(level.scripted_spawner_func)) {
    return;
  }

  level.threadedscriptspawners = istrue(var_0);
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

function thirtypercent_music() {
  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      for(var_0 = 0; var_0 < level.scripted_spawner_func.size; var_0++) {
        [[level.scripted_spawner_func[var_0]]](1, "cs" + var_0);
      }

      return;
    }

    if(istrue(level.threadedscriptspawners)) {
      [[level.scripted_spawner_func]](1);
      return;
    }

    [[level.scripted_spawner_func]]();
    return;
  }
}

function register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
  }

  if(isDefined(var_0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;
  }

  if(isDefined(var_1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;
  }

  if(isDefined(var_2)) {
    level.create_script_file_ids[var_0] = "cs" + var_2;
    return;
  }
}

function thermometerwatch(var_0) {
  if(scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_set(var_0);

    if(scripts\engine\utility::flag_exist(var_0 + "_completed")) {
      level endon("game_ended");
      scripts\engine\utility::flag_wait(var_0 + "_completed");
      return;
    }

    return;
  }
}

function ref_12b00(var_0) {
  if(!isDefined(level.brjuggernautcrateactivatecallback)) {
    level.brjuggernautcrateactivatecallback = [];
  }

  level.brjuggernautcrateactivatecallback = scripts\engine\utility::array_add(level.brjuggernautcrateactivatecallback, var_0);
}

function ref_12b01(var_0) {
  if(!isDefined(level.brjuggernautcratecapturecallback)) {
    level.brjuggernautcratecapturecallback = [];
  }

  level.brjuggernautcratecapturecallback = scripts\engine\utility::array_add(level.brjuggernautcratecapturecallback, var_0);
}

function strike_setup_arrays(var_0, var_1) {
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

  if(isDefined(var_0) && !isDefined(level.scripted_spawners[var_0])) {
    level.scripted_spawners[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_triggers[var_0])) {
    level.scripted_spawners_triggers[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_models[var_0])) {
    level.scripted_spawners_models[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners[var_0])) {
    level.cs_scripted_spawners[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_triggers[var_0])) {
    level.cs_scripted_spawners_triggers[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_models[var_0])) {
    level.cs_scripted_spawners_models[var_0] = [];
  }

  if(!isDefined(level.cs_object_container)) {
    level.cs_object_container = [];
  }

  if(isDefined(var_1) && !isDefined(level.cs_object_container[var_1])) {
    level.cs_object_container[var_1] = self;
    return;
  }
}

function initbunkerdoor(var_0, var_1) {
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

  if(isDefined(var_0) && !isDefined(level.scripted_spawners[var_0])) {
    level.scripted_spawners[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_triggers[var_0])) {
    level.scripted_spawners_triggers[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_models[var_0])) {
    level.scripted_spawners_models[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners[var_0])) {
    level.cs_scripted_spawners[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_triggers[var_0])) {
    level.cs_scripted_spawners_triggers[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_models[var_0])) {
    level.cs_scripted_spawners_models[var_0] = [];
  }

  if(!isDefined(level.cs_object_container)) {
    level.cs_object_container = [];
  }

  if(isDefined(var_1) && !isDefined(level.cs_object_container[var_1])) {
    level.cs_object_container[var_1] = self;
    return;
  }
}

function strike_additem(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  level endon("game_ended");

  if(!ref_11f7c(var_0)) {
    return;
  }

  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0) {
      waitframe();
    }
  }

  if(isDefined(var_3)) {
    var_0.origin = var_3;
  }

  if(isDefined(var_4)) {
    var_0.angles = var_4;
  } else if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(isDefined(var_5)) {
    var_0.targetname = var_5;
  }

  if(isDefined(var_6)) {
    var_0.target = var_6;
  }

  if(isDefined(var_7)) {
    var_0.script_noteworthy = var_7;
  }

  if(isDefined(var_8)) {
    var_0.script_linkto = var_8;
  }

  if(isDefined(var_9)) {
    var_0.script_linkname = var_9;
  }

  if(isDefined(var_13)) {
    var_0.speed = var_13;
  }

  if(isDefined(var_12)) {
    var_0.radius = var_12;
  }

  if(isDefined(var_14)) {
    var_0.spawnflags = int(var_14);
  }

  if(isDefined(var_15)) {
    var_0.script_unload = var_15;
  }

  translate_position_with_offset_data(var_2, var_0, var_10, var_11);

  if(!isDefined(var_1)) {
    var_1 = "_";
  }

  strike_fixautokvps(var_0, var_1);
  typecast_kvps(var_0);

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var_0;
  }

  if(isDefined(var_0.model)) {
    if(istrue(var_0.is_cs_model)) {
      var_0.is_cs_model = undefined;
    }

    strike_modelcreate(var_0, var_1);
    return;
  }

  if(isDefined(var_0.targetname)) {
    if(istrue(var_0.is_cs_trigger)) {
      var_0.is_cs_trigger = undefined;
      strike_triggercreate(var_0, var_1, 1);
      return;
    }

    if(istrue(var_0.is_cs_model)) {
      strike_modelcreate(var_0, var_1);
      var_0.is_cs_model = undefined;
      return;
    }

    if(istrue(var_0.trigger_aggro_damage_amount)) {
      var_0.trigger_aggro_damage_amount = undefined;
      ref_13921(var_0, var_1);
      return;
    }

    switch (var_0.targetname) {
      case "trigger_spawn":
        strike_triggercreate(var_0, var_1);
        break;
      case "trigger_fallback":
        strike_triggercreate(var_0, var_1);
        break;
      case "module_update":
        strike_triggercreate(var_0, var_1, 1);
        break;
      case "cs_trigger":
        strike_triggercreate(var_0, var_1, 1);
        break;
      case "interaction":
        strike_interactioncreate(var_0, var_1);
        break;
      case "trigger_kill_floodspawner":
        strike_triggercreate(var_0, var_1, 1);
        break;
      default:
        strike_addstructtolevel(var_0, 0, var_1);
        break;
    }

    return;
  }

  strike_addstructtolevel(var_0, 0, var_1);
}

function ref_11f7c() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(level.brjuggernautcrateactivatecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var_2 = 0; var_2 < level.brjuggernautcrateactivatecallback.size; var_2++) {
        if(getsubstr(level.brjuggernautcrateactivatecallback[var_2], 0, 1) == "!") {
          var_3 = 1;
        } else {
          var_3 = 0;
        }

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcrateactivatecallback[var_2]) != var_3) {
          var_0 = 1;
          break;
        }
      }
    } else {
      var_0 = 1;
    }
  } else {
    var_0 = 1;
  }

  if(isDefined(level.brjuggernautcratecapturecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var_2 = 0; var_2 < level.brjuggernautcratecapturecallback.size; var_2++) {
        if(getsubstr(level.brjuggernautcratecapturecallback[var_2], 0, 1) == "!") {
          var_3 = 1;
        } else {
          var_3 = 0;
        }

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcratecapturecallback[var_2]) != var_3) {
          var_1 = 1;
          break;
        }
      }
    } else {
      var_1 = 1;
    }
  } else {
    var_1 = 1;
  }

  return istrue(var_0 && var_1);
}

function trophy_watchtimeoutorgameendedinternal(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || var_1 == "") {
    return 0;
  }

  return issubstr(var_0, var_1);
}

function translate_position_with_offset_data(var_0, var_1, var_2, var_3) {
  ref_13cf2(var_0, var_1);

  if(isDefined(var_2)) {
    if(!isDefined(var_3)) {
      var_3 = (0, 0, 0);
    }

    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_4 = var_1.angles;
    }

    var_5 = var_1.origin;
    var_1.origin = var_2 + rotatevector(var_5, var_3);

    if(isDefined(var_1.script_origin_other)) {
      var_1.script_origin_other = var_2 + rotatevector(var_1.script_origin_other, var_3);
    }

    var_6 = combineangles(var_3, var_4);
    var_1.angles = var_6;
    return;
  }
}

function ref_13cf2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level.cs_origin_offset) && isDefined(level.cs_angle_offset[var_0])) {
    var_2 = level.cs_angle_offset[var_0];
    var_3 = level.cs_origin_offset[var_0];
    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_4 = var_1.angles;
    }

    var_5 = var_1.origin;
    var_1.origin = var_3 + rotatevector(var_5, var_2);

    if(isDefined(var_1.script_origin_other)) {
      var_1.script_origin_other = var_3 + rotatevector(var_1.script_origin_other, var_2);
    }

    var_6 = combineangles(var_2, var_4);
    var_1.angles = var_6;
    return;
  }
}

function strike_add_to_cs_arrays(var_0, var_1, var_2) {
  if(!getdvarint("scr_enable_create_script", 0)) {
    return;
  }

  if(var_0 == "struct") {
    level.scripted_spawners[var_2][level.scripted_spawners[var_2].size] = var_1;
    return;
  }

  if(var_0 == "trigger") {
    level.scripted_spawners_triggers[var_2][level.scripted_spawners_triggers[var_2].size] = var_1;
    return;
  }

  if(var_0 == "model") {
    level.scripted_spawners_models[var_2][level.scripted_spawners_models[var_2].size] = var_1;
    return;
  }
}

function strike_interactioncreate(var_0, var_1) {
  strike_addstructtolevel(var_0, 1, var_1);
}

function ref_13921(var_0, var_1) {
  var_2 = spawn("script_origin", var_0.origin);

  if(!isDefined(var_0.angles)) {
    var_2.angles = (0, 0, 0);
  } else {
    var_2.angles = var_0.angles;
  }

  if(isDefined(var_0.model)) {
    var_2 setModel(var_0.model);
  }

  if(isDefined(var_0.targetname)) {
    var_2.targetname = var_0.targetname;
  }

  if(isDefined(var_0.script_noteworthy)) {
    var_2.script_noteworthy = var_0.script_noteworthy;
  }

  if(isDefined(var_0.script_linkto)) {
    var_2.script_linkto = var_0.script_linkto;
  }

  if(isDefined(var_0.script_linkname)) {
    var_2.script_linkname = var_0.script_linkname;
  }

  if(isDefined(var_0.target)) {
    var_2.target = var_0.target;
  }

  var_2.struct = var_0;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var_2;
    return;
  }
}

function strike_modelcreate(var_0, var_1) {
  strike_add_to_cs_arrays("model", var_0, var_1);

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0.model);
  var_2.angles = var_0.angles;

  if(isDefined(var_0.targetname)) {
    var_2.targetname = var_0.targetname;
  }

  if(isDefined(var_0.script_noteworthy)) {
    var_2.script_noteworthy = var_0.script_noteworthy;
  }

  if(isDefined(var_0.script_linkto)) {
    var_2.script_linkto = var_0.script_linkto;
  }

  if(isDefined(var_0.script_linkname)) {
    var_2.script_linkname = var_0.script_linkname;
  }

  if(isDefined(var_0.target)) {
    var_2.target = var_0.target;
  }

  if(isDefined(var_0.name)) {
    var_2.name = var_0.name;
  }

  var_2.struct = var_0;
  var_0.is_cs_model = undefined;
  var_0.trigger_elevator_spawners = undefined;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var_2;
    return;
  }
}

function strike_triggercreate(var_0, var_1, var_2) {
  strike_add_to_cs_arrays("trigger", var_0, var_1);
  var_3 = spawn("trigger_rotatable_radius", var_0.origin, 0, int(var_0.radius), int(var_0.height));

  if(isDefined(var_0.angles) && var_0.angles != (0, 0, 0)) {
    if(istrue(var_2)) {
      var_3.angles = var_0.angles;
    } else {
      var_3.angles = (-90, 0, 0) + var_0.angles;
    }
  }

  var_3.struct = var_0;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var_3;
  }

  strike_triggerassignvalues(var_3, var_0);
}

function strike_triggerassignvalues(var_0) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(isDefined(var_0.script_label)) {
    self.script_label = var_0.script_label;
  }

  if(isDefined(var_0.script_function)) {
    self.script_function = var_0.script_function;
  }

  if(isDefined(var_0.script_noteworthy)) {
    self.script_noteworthy = var_0.script_noteworthy;
  }

  if(isDefined(var_0.script_gesture)) {
    self.script_gesture = var_0.script_gesture;
  }

  if(isDefined(var_0.target)) {
    self.target = var_0.target;
  }

  if(isDefined(var_0.script_wtf)) {
    self.script_wtf = var_0.script_wtf;
  }

  if(isDefined(var_0.script_flag)) {
    self.script_flag = var_0.script_flag;
  }

  if(isDefined(var_0.script_linkto)) {
    self.script_linkto = var_0.script_linkto;
  }

  if(isDefined(var_0.script_linkname)) {
    self.script_linkname = var_0.script_linkname;
  }

  if(isDefined(var_0.groupname)) {
    self.groupname = var_0.groupname;
  }

  if(isDefined(var_0.script_count)) {
    self.script_count = var_0.script_count;
  }

  if(isDefined(var_0.script_count_min)) {
    self.script_count_min = var_0.script_count_min;
  }

  if(isDefined(var_0.script_count_max)) {
    self.script_count_max = var_0.script_count_max;
  }

  if(isDefined(var_0.script_maxdist)) {
    self.script_maxdist = var_0.script_maxdist;
  }

  self.targetname = var_0.targetname;
}

function strike_addstructtolevel(var_0, var_1, var_2) {
  if(isDefined(var_0.target)) {
    initbunkeranims("target", var_0.target, var_0);
  }

  if(isDefined(var_0.script_linkname)) {
    initbunkeranims("script_linkname", var_0.script_linkname, var_0);
  }

  if(isDefined(var_0.targetname)) {
    initbunkeranims("targetname", var_0.targetname, var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    initbunkeranims("script_noteworthy", var_0.script_noteworthy, var_0);
    return;
  }
}

function initbunkeranims(var_0, var_1, var_2) {
  if(!isDefined(level.struct_class_names[var_0][var_1])) {
    level.struct_class_names[var_0][var_1] = [];
  }

  level.struct_class_names[var_0][var_1][level.struct_class_names[var_0][var_1].size] = var_2;
}

function strike_fixautokvps(var_0, var_1) {
  if(isDefined(var_0.target) && issubstr(var_0.target, "auto")) {
    var_0.target = "CS|" + var_1 + var_0.target;
  }

  if(isDefined(var_0.targetname) && issubstr(var_0.targetname, "auto")) {
    var_0.targetname = "CS|" + var_1 + var_0.targetname;
  }

  if(isDefined(var_0.script_linkto)) {
    var_2 = "";
    var_3 = strtok(var_0.script_linkto, " ");

    foreach(var_5 in var_3) {
      if(var_6 != 0) {
        if(int(var_0.script_linkto) == 0) {
          var_2 = var_2 + " " + var_5;
        } else {
          var_2 = var_2 + " " + "CS|" + var_1 + var_5;
        }

        continue;
      }

      if(int(var_0.script_linkto) == 0) {
        var_2 += var_5;
        continue;
      }

      var_2 = var_2 + "CS|" + var_1 + var_5;
    }

    var_0.script_linkto = var_2;
  }

  if(isDefined(var_0.script_linkname)) {
    if(int(var_0.script_linkname) != 0) {
      var_0.script_linkname = "CS|" + var_1 + var_0.script_linkname;
      return;
    }

    return;
  }
}

function typecast_kvps(var_0) {
  if(istrue(var_0.ishelistruct)) {
    if(isDefined(var_0.script_unload)) {
      var_0.script_unload = int(var_0.script_unload);
    }
  }

  if(isDefined(var_0.script_wait_min)) {
    var_0.script_wait_min = float(var_0.script_wait_min);
  }

  if(isDefined(var_0.script_wait_max)) {
    var_0.script_wait_max = float(var_0.script_wait_max);
  }

  if(isDefined(var_0.script_wait_add)) {
    var_0.script_wait_add = float(var_0.script_wait_add);
  }

  if(isDefined(var_0.script_brake)) {
    var_0.script_brake = float(var_0.script_brake);
  }

  if(isDefined(var_0.lookahead)) {
    var_0.lookahead = int(var_0.lookahead);
  }

  if(isDefined(var_0.speed)) {
    var_0.speed = int(var_0.speed);
  }

  if(isDefined(var_0.script_accel)) {
    var_0.script_accel = int(var_0.script_accel);
  }

  if(isDefined(var_0.script_decel)) {
    var_0.script_decel = int(var_0.script_decel);
  }

  if(isDefined(var_0.script_speed)) {
    var_0.script_speed = int(var_0.script_speed);
  }

  if(isDefined(var_0.script_goalyaw)) {
    if(var_0.script_goalyaw == "true" || var_0.script_goalyaw == "1") {
      var_0.script_goalyaw = 1;
    } else {
      var_0.script_goalyaw = undefined;
    }
  }

  if(isDefined(var_0.script_anglevehicle)) {
    if(var_0.script_anglevehicle == "true" || var_0.script_anglevehicle == "1") {
      var_0.script_goalyaw = 1;
    } else {
      var_0.script_goalyaw = undefined;
    }
  }

  if(isDefined(var_0.script_delay)) {
    var_0.script_delay = float(var_0.script_delay);
  }

  if(isDefined(var_0.script_ignoreme)) {
    var_0.script_ignoreme = int(var_0.script_ignoreme);
  }

  if(isDefined(var_0.script_ignoreall)) {
    var_0.script_ignoreall = int(var_0.script_ignoreall);
  }

  if(isDefined(var_0.script_death)) {
    var_0.script_death = int(var_0.script_death);
  }

  if(isDefined(var_0.script_wait)) {
    var_0.script_wait = float(var_0.script_wait);
  }

  if(isDefined(var_0.script_forcespawn)) {
    var_0.script_forcespawn = int(var_0.script_forcespawn);
  }

  if(isDefined(var_0.script_timer)) {
    var_0.script_timer = int(var_0.script_timer);
  }

  if(isDefined(var_0.script_dist_only)) {
    var_0.script_dist_only = int(var_0.script_dist_only) * int(var_0.script_dist_only);
  }

  if(isDefined(var_0.script_speed)) {
    var_0.script_speed = int(var_0.script_speed);
  }

  if(isDefined(var_0.script_count)) {
    var_0.script_count = int(var_0.script_count);
  }

  if(isDefined(var_0.script_radius)) {
    var_0.script_radius = int(var_0.script_radius);
  }

  if(isDefined(var_0.script_delay_min)) {
    var_0.script_delay_min = float(var_0.script_delay_min);
  }

  if(isDefined(var_0.script_delay_max)) {
    var_0.script_delay_max = float(var_0.script_delay_max);
  }

  if(isDefined(var_0.script_escalation_level)) {
    var_0.script_escalation_level = int(var_0.script_escalation_level);
  }

  if(isDefined(var_0.script_goalheight)) {
    var_0.script_goalheight = int(var_0.script_goalheight);
  }

  if(isDefined(var_0.script_timeout)) {
    var_0.script_timeout = float(var_0.script_timeout);
  }

  if(isDefined(var_0.script_pacifist)) {
    var_0.script_pacifist = int(var_0.script_pacifist);
  }

  if(isDefined(var_0.script_forcespawn)) {
    var_0.script_forcespawn = int(var_0.script_forcespawn);
  }

  if(isDefined(var_0.dontkilloff)) {
    var_0.dontkilloff = int(var_0.dontkilloff);
  }

  if(isDefined(var_0.script_origin_other)) {
    var_0.script_origin_other = var_0.script_origin_other;
  }

  if(isDefined(var_0.script_dot)) {
    var_0.script_dot = int(var_0.script_dot);
  }

  if(isDefined(var_0.script_ignoreall)) {
    var_0.script_ignoreall = int(var_0.script_ignoreall);
    return;
  }
}

function cs_is_starttime() {
  if(scripts\common\utility::iscp()) {
    return (gettime() <= level.starttime + 250);
  }

  return gettime() <= level.starttimeutcseconds + 250;
}

function cs_init_flags(var_0) {
  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_init("create_script_initialized");
  }

  var_0.objects = [];
  var_0 scripts\engine\utility::ent_flag_init("cs_structs_complete");
  var_0 scripts\engine\utility::ent_flag_init("cs_models_complete");
  var_0 scripts\engine\utility::ent_flag_init("cs_triggers_complete");
}

function initbunkerbackwallkeypads(var_0) {
  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_init("create_script_initialized");
  }

  var_0.objects = [];
  var_0 scripts\engine\utility::ent_flag_init("cs_objects_created");
}

function wait_for_flags(var_0, var_1) {
  if(var_0 scripts\engine\utility::ent_flag_exist("cs_structs_complete")) {
    var_0 scripts\engine\utility::ent_flag_wait("cs_structs_complete");
  }

  if(var_0 scripts\engine\utility::ent_flag_exist("cs_triggers_complete")) {
    var_0 scripts\engine\utility::ent_flag_wait("cs_triggers_complete");
  }

  if(var_0 scripts\engine\utility::ent_flag_exist("cs_objects_created")) {
    var_0 scripts\engine\utility::ent_flag_wait("cs_objects_created");
  }

  scripts\engine\utility::flag_set(var_1 + "_completed");

  if(cs_is_starttime()) {
    endcreatescript(var_0);
    return;
  }
}

function endcreatescript(var_0) {
  if(isDefined(level.createscriptfilesinitialized)) {
    level.createscriptfilesinitialized++;

    if(level.createscriptfilesinitialized >= level.scripted_spawner_func.size) {
      scripts\engine\utility::flag_set("strike_init_done");
      scripts\engine\utility::flag_set("create_script_initialized");
      return;
    }

    return;
  }

  scripts\engine\utility::flag_set("strike_init_done");
  scripts\engine\utility::flag_set("create_script_initialized");
}

function wait_for_cs_flag(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_init(var_0 + "_completed");

  if(!should_wait_for_cs_flag(var_0)) {
    endcreatescript();
    scripts\engine\utility::flag_wait(var_0);
    return;
  }
}

function should_wait_for_cs_flag(var_0) {
  var_1 = strtok(getDvar("scr_init_cs_files", ""), " ");
  var_1 = scripts\engine\utility::array_combine(var_1, level.aud_interior_plane_audio_zones);

  if(var_1.size < 1) {
    return true;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "all") {
      return true;
    }

    if(var_0 == var_3) {
      return true;
    }
  }

  return false;
}

function register_cs_offsets(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level.cs_origin_offset[var_0] = var_1;
  }

  if(isDefined(var_2)) {
    level.cs_angle_offset[var_0] = var_2;
    return;
  }
}

function set_cs_file_dvar(var_0) {
  level.aud_interior_plane_audio_zones[level.aud_interior_plane_audio_zones.size] = var_0;
}

function cleanup_cs_file_objects(var_0) {
  scripts\engine\utility::flag_clear(var_0 + "_completed");
  scripts\engine\utility::flag_clear(var_0);

  if(isDefined(level.cs_object_container[var_0]) && isDefined(level.cs_object_container[var_0].objects)) {
    var_1 = level.cs_object_container[var_0].objects;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];
      level.cs_object_container[var_0].objects[var_2] = undefined;

      if(isstruct(var_3)) {
        scripts\engine\utility::deletestruct_ref(var_3);
      }

      if(isent(var_3)) {
        var_3 delete();
      }
    }

    return;
  }
}

function s() {
  return spawnStruct();
}

function ref_13529(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = "Cover Stand";

    switch (var_3.ref_11eaa) {
      case "cover_left":
        var_4 = "Cover Left";
        break;
      case "cover_right":
        var_4 = "Cover Right";
        break;
      case "cover_crouch":
        var_4 = "Cover Crouch";
        break;
      case "cover_stand":
        var_4 = "Cover Stand";
        break;
      case "cover_crouch_window":
        var_4 = "Cover Crouch Window";
        break;
      case "conceal_crouch":
        var_4 = "Conceal Crouch";
        break;
      case "cover_exposed":
        var_4 = "Exposed";
      case "turret":
        var_4 = "Turret";
        break;
    }

    var_5 = undefined;

    if(isDefined(var_3.ref_11ea3)) {
      var_5 = var_3.ref_11ea3;
    }

    var_6 = 0;

    if(isDefined(var_3.ref_11ebf) && int(var_3.ref_11ebf) != 0 && var_3.ref_11ebf != "false") {
      var_6 = 4;
    }

    if(isDefined(var_3.ref_11e99) && int(var_3.ref_11e99) != 0 && var_3.ref_11e99 != "false") {
      var_6 += 8;
    }

    if(isDefined(var_3.ref_11eb6) && int(var_3.ref_11eb6) != 0 && var_3.ref_11eb6 != "false") {
      var_6 += 16;
    }

    var_3.covernode = spawncovernode(var_3.origin, var_3.angles, var_4, var_6, var_5);

    if(isDefined(var_3.radius)) {
      var_3.covernode.radius = var_3.radius;
    }
  }

  return var_1;
}

function land_usability_disabled(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.covernode)) {
      despawncovernode(var_3.covernode);
      var_3.covernode = undefined;
    }
  }
}