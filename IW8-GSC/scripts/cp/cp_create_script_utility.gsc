/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_create_script_utility.gsc
***************************************************/

function thermitestucktoshield() {
  struct_set_fields();
}

function struct_set_fields(var0) {
  if(isDefined(level.scripted_spawner_func)) {
    return;
  }

  level.threadedscriptspawners = istrue(var0);
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
      for(var0 = 0; var0 < level.scripted_spawner_func.size; var0++) {
        [[level.scripted_spawner_func[var0]]](1, "cs" + var0);
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

function register_create_script_arrays(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var3;
  }

  if(isDefined(var0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var0;
  }

  if(isDefined(var1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var1;
  }

  if(isDefined(var2)) {
    level.create_script_file_ids[var0] = "cs" + var2;
    return;
  }
}

function thermometerwatch(var0) {
  if(scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_set(var0);

    if(scripts\engine\utility::flag_exist(var0 + "_completed")) {
      level endon("game_ended");
      scripts\engine\utility::flag_wait(var0 + "_completed");
      return;
    }

    return;
  }
}

function ref_12b00(var0) {
  if(!isDefined(level.brjuggernautcrateactivatecallback)) {
    level.brjuggernautcrateactivatecallback = [];
  }

  level.brjuggernautcrateactivatecallback = scripts\engine\utility::array_add(level.brjuggernautcrateactivatecallback, var0);
}

function ref_12b01(var0) {
  if(!isDefined(level.brjuggernautcratecapturecallback)) {
    level.brjuggernautcratecapturecallback = [];
  }

  level.brjuggernautcratecapturecallback = scripts\engine\utility::array_add(level.brjuggernautcratecapturecallback, var0);
}

function strike_setup_arrays(var0, var1) {
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

  if(isDefined(var0) && !isDefined(level.scripted_spawners[var0])) {
    level.scripted_spawners[var0] = [];
  }

  if(isDefined(var0) && !isDefined(level.scripted_spawners_triggers[var0])) {
    level.scripted_spawners_triggers[var0] = [];
  }

  if(isDefined(var0) && !isDefined(level.scripted_spawners_models[var0])) {
    level.scripted_spawners_models[var0] = [];
  }

  if(isDefined(var0) && !isDefined(level.cs_scripted_spawners[var0])) {
    level.cs_scripted_spawners[var0] = [];
  }

  if(isDefined(var0) && !isDefined(level.cs_scripted_spawners_triggers[var0])) {
    level.cs_scripted_spawners_triggers[var0] = [];
  }

  if(isDefined(var0) && !isDefined(level.cs_scripted_spawners_models[var0])) {
    level.cs_scripted_spawners_models[var0] = [];
  }

  if(!isDefined(level.cs_object_container)) {
    level.cs_object_container = [];
  }

  if(isDefined(var1) && !isDefined(level.cs_object_container[var1])) {
    level.cs_object_container[var1] = self;
    return;
  }
}

function strike_additem(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15) {
  level endon("game_ended");

  if(!ref_11f7c(var0)) {
    return;
  }

  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0) {
      waitframe();
    }
  }

  if(isDefined(var3)) {
    var0.origin = var3;
  }

  if(isDefined(var4)) {
    var0.angles = var4;
  } else if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(isDefined(var5)) {
    var0.targetname = var5;
  }

  if(isDefined(var6)) {
    var0.target = var6;
  }

  if(isDefined(var7)) {
    var0.script_noteworthy = var7;
  }

  if(isDefined(var8)) {
    var0.script_linkto = var8;
  }

  if(isDefined(var9)) {
    var0.script_linkname = var9;
  }

  if(isDefined(var13)) {
    var0.speed = var13;
  }

  if(isDefined(var12)) {
    var0.radius = var12;
  }

  if(isDefined(var14)) {
    var0.spawnflags = int(var14);
  }

  if(isDefined(var15)) {
    var0.script_unload = var15;
  }

  translate_position_with_offset_data(var2, var0, var10, var11);

  if(!isDefined(var1)) {
    var1 = "_";
  }

  strike_fixautokvps(var0, var1);
  typecast_kvps(var0);

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var0;
  }

  if(isDefined(var0.model)) {
    if(istrue(var0.is_cs_model)) {
      var0.is_cs_model = undefined;
    }

    strike_modelcreate(var0, var1);
    return;
  }

  if(isDefined(var0.targetname)) {
    if(istrue(var0.is_cs_trigger)) {
      var0.is_cs_trigger = undefined;
      strike_triggercreate(var0, var1, 1);
      return;
    }

    if(istrue(var0.is_cs_model)) {
      strike_modelcreate(var0, var1);
      var0.is_cs_model = undefined;
      return;
    }

    if(istrue(var0.trigger_aggro_damage_amount)) {
      var0.trigger_aggro_damage_amount = undefined;
      ref_13921(var0, var1);
      return;
    }

    switch (var0.targetname) {
      case "trigger_spawn":
        strike_triggercreate(var0, var1);
        break;
      case "trigger_fallback":
        strike_triggercreate(var0, var1);
        break;
      case "module_update":
        strike_triggercreate(var0, var1, 1);
        break;
      case "cs_trigger":
        strike_triggercreate(var0, var1, 1);
        break;
      case "interaction":
        strike_interactioncreate(var0, var1);
        break;
      case "trigger_kill_floodspawner":
        strike_triggercreate(var0, var1, 1);
        break;
      default:
        strike_addstructtolevel(var0, 0, var1);
        break;
    }

    return;
  }

  strike_addstructtolevel(var0, 0, var1);
}

function ref_11f7c() {
  var0 = 0;
  var1 = 0;

  if(isDefined(level.brjuggernautcrateactivatecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var2 = 0; var2 < level.brjuggernautcrateactivatecallback.size; var2++) {
        if(getsubstr(level.brjuggernautcrateactivatecallback[var2], 0, 1) == "!") {
          var3 = 1;
        } else {
          var3 = 0;
        }

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcrateactivatecallback[var2]) != var3) {
          var0 = 1;
          break;
        }
      }
    } else {
      var0 = 1;
    }
  } else {
    var0 = 1;
  }

  if(isDefined(level.brjuggernautcratecapturecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var2 = 0; var2 < level.brjuggernautcratecapturecallback.size; var2++) {
        if(getsubstr(level.brjuggernautcratecapturecallback[var2], 0, 1) == "!") {
          var3 = 1;
        } else {
          var3 = 0;
        }

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcratecapturecallback[var2]) != var3) {
          var1 = 1;
          break;
        }
      }
    } else {
      var1 = 1;
    }
  } else {
    var1 = 1;
  }

  return istrue(var0 && var1);
}

function trophy_watchtimeoutorgameendedinternal(var0, var1) {
  if(!isDefined(var0) || var0 == "" || !isDefined(var1) || var1 == "") {
    return 0;
  }

  return issubstr(var0, var1);
}

function translate_position_with_offset_data(var0, var1, var2, var3) {
  ref_13cf2(var0, var1);

  if(isDefined(var2)) {
    if(!isDefined(var3)) {
      var3 = (0, 0, 0);
    }

    var4 = (0, 0, 0);

    if(isDefined(var1.angles)) {
      var4 = var1.angles;
    }

    var5 = var1.origin;
    var1.origin = var2 + rotatevector(var5, var3);

    if(isDefined(var1.script_origin_other)) {
      var1.script_origin_other = var2 + rotatevector(var1.script_origin_other, var3);
    }

    var6 = combineangles(var3, var4);
    var1.angles = var6;
    return;
  }
}

function ref_13cf2(var0, var1) {
  if(isDefined(var0) && isDefined(level.cs_origin_offset) && isDefined(level.cs_angle_offset[var0])) {
    var2 = level.cs_angle_offset[var0];
    var3 = level.cs_origin_offset[var0];
    var4 = (0, 0, 0);

    if(isDefined(var1.angles)) {
      var4 = var1.angles;
    }

    var5 = var1.origin;
    var1.origin = var3 + rotatevector(var5, var2);

    if(isDefined(var1.script_origin_other)) {
      var1.script_origin_other = var3 + rotatevector(var1.script_origin_other, var2);
    }

    var6 = combineangles(var2, var4);
    var1.angles = var6;
    return;
  }
}

function strike_add_to_cs_arrays(var0, var1, var2) {
  if(!getdvarint("scr_enable_create_script", 0)) {
    return;
  }

  if(var0 == "struct") {
    level.scripted_spawners[var2][level.scripted_spawners[var2].size] = var1;
    return;
  }

  if(var0 == "trigger") {
    level.scripted_spawners_triggers[var2][level.scripted_spawners_triggers[var2].size] = var1;
    return;
  }

  if(var0 == "model") {
    level.scripted_spawners_models[var2][level.scripted_spawners_models[var2].size] = var1;
    return;
  }
}

function strike_interactioncreate(var0, var1) {
  strike_addstructtolevel(var0, 1, var1);
}

function ref_13921(var0, var1) {
  var2 = spawn("script_origin", var0.origin);

  if(!isDefined(var0.angles)) {
    var2.angles = (0, 0, 0);
  } else {
    var2.angles = var0.angles;
  }

  if(isDefined(var0.model)) {
    var2 setModel(var0.model);
  }

  if(isDefined(var0.targetname)) {
    var2.targetname = var0.targetname;
  }

  if(isDefined(var0.script_noteworthy)) {
    var2.script_noteworthy = var0.script_noteworthy;
  }

  if(isDefined(var0.script_linkto)) {
    var2.script_linkto = var0.script_linkto;
  }

  if(isDefined(var0.script_linkname)) {
    var2.script_linkname = var0.script_linkname;
  }

  if(isDefined(var0.target)) {
    var2.target = var0.target;
  }

  var2.struct = var0;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var2;
    return;
  }
}

function strike_modelcreate(var0, var1) {
  strike_add_to_cs_arrays("model", var0, var1);
  var2 = spawn("script_model", var0.origin);

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2.angles = var0.angles;
  var2 setModel(var0.model);

  if(isDefined(var0.targetname)) {
    var2.targetname = var0.targetname;
  }

  if(isDefined(var0.script_noteworthy)) {
    var2.script_noteworthy = var0.script_noteworthy;
  }

  if(isDefined(var0.script_linkto)) {
    var2.script_linkto = var0.script_linkto;
  }

  if(isDefined(var0.script_linkname)) {
    var2.script_linkname = var0.script_linkname;
  }

  if(isDefined(var0.target)) {
    var2.target = var0.target;
  }

  if(isDefined(var0.name)) {
    var2.name = var0.name;
  }

  var2.struct = var0;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var2;
    return;
  }
}

function strike_triggercreate(var0, var1, var2) {
  strike_add_to_cs_arrays("trigger", var0, var1);
  var3 = spawn("trigger_rotatable_radius", var0.origin, 0, int(var0.radius), int(var0.height));

  if(isDefined(var0.angles) && var0.angles != (0, 0, 0)) {
    if(istrue(var2)) {
      var3.angles = var0.angles;
    } else {
      var3.angles = (-90, 0, 0) + var0.angles;
    }
  }

  var3.struct = var0;

  if(isDefined(self.objects)) {
    self.objects[self.objects.size] = var3;
  }

  strike_triggerassignvalues(var3, var0);
}

function strike_triggerassignvalues(var0) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(isDefined(var0.script_label)) {
    self.script_label = var0.script_label;
  }

  if(isDefined(var0.script_function)) {
    self.script_function = var0.script_function;
  }

  if(isDefined(var0.script_noteworthy)) {
    self.script_noteworthy = var0.script_noteworthy;
  }

  if(isDefined(var0.script_gesture)) {
    self.script_gesture = var0.script_gesture;
  }

  if(isDefined(var0.target)) {
    self.target = var0.target;
  }

  if(isDefined(var0.script_wtf)) {
    self.script_wtf = var0.script_wtf;
  }

  if(isDefined(var0.script_flag)) {
    self.script_flag = var0.script_flag;
  }

  if(isDefined(var0.script_linkto)) {
    self.script_linkto = var0.script_linkto;
  }

  if(isDefined(var0.script_linkname)) {
    self.script_linkname = var0.script_linkname;
  }

  if(isDefined(var0.groupname)) {
    self.groupname = var0.groupname;
  }

  if(isDefined(var0.script_count)) {
    self.script_count = var0.script_count;
  }

  if(isDefined(var0.script_count_min)) {
    self.script_count_min = var0.script_count_min;
  }

  if(isDefined(var0.script_count_max)) {
    self.script_count_max = var0.script_count_max;
  }

  if(isDefined(var0.script_maxdist)) {
    self.script_maxdist = var0.script_maxdist;
  }

  self.targetname = var0.targetname;
}

function strike_addstructtolevel(var0, var1, var2) {
  if(isDefined(var0.target)) {
    initbunkeranims("target", var0.target, var0);
  }

  if(isDefined(var0.script_linkname)) {
    initbunkeranims("script_linkname", var0.script_linkname, var0);
  }

  if(isDefined(var0.targetname)) {
    initbunkeranims("targetname", var0.targetname, var0);
  }

  if(isDefined(var0.script_noteworthy)) {
    initbunkeranims("script_noteworthy", var0.script_noteworthy, var0);
    return;
  }
}

function initbunkeranims(var0, var1, var2) {
  if(!isDefined(level.struct_class_names[var0][var1])) {
    level.struct_class_names[var0][var1] = [];
  }

  level.struct_class_names[var0][var1][level.struct_class_names[var0][var1].size] = var2;
}

function strike_fixautokvps(var0, var1) {
  if(isDefined(var0.target) && issubstr(var0.target, "auto")) {
    var0.target = "CS|" + var1 + var0.target;
  }

  if(isDefined(var0.targetname) && issubstr(var0.targetname, "auto")) {
    var0.targetname = "CS|" + var1 + var0.targetname;
  }

  if(isDefined(var0.script_linkto)) {
    var2 = "";
    var3 = strtok(var0.script_linkto, " ");

    foreach(var5 in var3) {
      if(var6 != 0) {
        if(int(var0.script_linkto) == 0) {
          var2 = var2 + " " + var5;
        } else {
          var2 = var2 + " " + "CS|" + var1 + var5;
        }

        continue;
      }

      if(int(var0.script_linkto) == 0) {
        var2 += var5;
        continue;
      }

      var2 = var2 + "CS|" + var1 + var5;
    }

    var0.script_linkto = var2;
  }

  if(isDefined(var0.script_linkname)) {
    if(int(var0.script_linkname) != 0) {
      var0.script_linkname = "CS|" + var1 + var0.script_linkname;
      return;
    }

    return;
  }
}

function typecast_kvps(var0) {
  if(istrue(var0.ishelistruct)) {
    if(isDefined(var0.script_unload)) {
      var0.script_unload = int(var0.script_unload);
    }
  }

  if(isDefined(var0.script_wait_min)) {
    var0.script_wait_min = float(var0.script_wait_min);
  }

  if(isDefined(var0.script_wait_max)) {
    var0.script_wait_max = float(var0.script_wait_max);
  }

  if(isDefined(var0.script_wait_add)) {
    var0.script_wait_add = float(var0.script_wait_add);
  }

  if(isDefined(var0.script_brake)) {
    var0.script_brake = float(var0.script_brake);
  }

  if(isDefined(var0.lookahead)) {
    var0.lookahead = int(var0.lookahead);
  }

  if(isDefined(var0.speed)) {
    var0.speed = int(var0.speed);
  }

  if(isDefined(var0.script_accel)) {
    var0.script_accel = int(var0.script_accel);
  }

  if(isDefined(var0.script_decel)) {
    var0.script_decel = int(var0.script_decel);
  }

  if(isDefined(var0.script_speed)) {
    var0.script_speed = int(var0.script_speed);
  }

  if(isDefined(var0.script_goalyaw)) {
    if(var0.script_goalyaw == "true" || var0.script_goalyaw == "1") {
      var0.script_goalyaw = 1;
    } else {
      var0.script_goalyaw = undefined;
    }
  }

  if(isDefined(var0.script_anglevehicle)) {
    if(var0.script_anglevehicle == "true" || var0.script_anglevehicle == "1") {
      var0.script_goalyaw = 1;
    } else {
      var0.script_goalyaw = undefined;
    }
  }

  if(isDefined(var0.script_delay)) {
    var0.script_delay = float(var0.script_delay);
  }

  if(isDefined(var0.script_ignoreme)) {
    var0.script_ignoreme = int(var0.script_ignoreme);
  }

  if(isDefined(var0.script_ignoreall)) {
    var0.script_ignoreall = int(var0.script_ignoreall);
  }

  if(isDefined(var0.script_death)) {
    var0.script_death = int(var0.script_death);
  }

  if(isDefined(var0.script_wait)) {
    var0.script_wait = float(var0.script_wait);
  }

  if(isDefined(var0.script_forcespawn)) {
    var0.script_forcespawn = int(var0.script_forcespawn);
  }

  if(isDefined(var0.script_timer)) {
    var0.script_timer = int(var0.script_timer);
  }

  if(isDefined(var0.script_dist_only)) {
    var0.script_dist_only = int(var0.script_dist_only) * int(var0.script_dist_only);
  }

  if(isDefined(var0.script_speed)) {
    var0.script_speed = int(var0.script_speed);
  }

  if(isDefined(var0.script_count)) {
    var0.script_count = int(var0.script_count);
  }

  if(isDefined(var0.script_radius)) {
    var0.script_radius = int(var0.script_radius);
  }

  if(isDefined(var0.script_delay_min)) {
    var0.script_delay_min = float(var0.script_delay_min);
  }

  if(isDefined(var0.script_delay_max)) {
    var0.script_delay_max = float(var0.script_delay_max);
  }

  if(isDefined(var0.script_escalation_level)) {
    var0.script_escalation_level = int(var0.script_escalation_level);
  }

  if(isDefined(var0.script_goalheight)) {
    var0.script_goalheight = int(var0.script_goalheight);
  }

  if(isDefined(var0.script_timeout)) {
    var0.script_timeout = float(var0.script_timeout);
  }

  if(isDefined(var0.script_pacifist)) {
    var0.script_pacifist = int(var0.script_pacifist);
  }

  if(isDefined(var0.script_forcespawn)) {
    var0.script_forcespawn = int(var0.script_forcespawn);
  }

  if(isDefined(var0.dontkilloff)) {
    var0.dontkilloff = int(var0.dontkilloff);
  }

  if(isDefined(var0.script_origin_other)) {
    var0.script_origin_other = var0.script_origin_other;
  }

  if(isDefined(var0.script_dot)) {
    var0.script_dot = int(var0.script_dot);
  }

  if(isDefined(var0.script_ignoreall)) {
    var0.script_ignoreall = int(var0.script_ignoreall);
    return;
  }
}

function cs_is_starttime() {
  if(scripts\common\utility::iscp()) {
    return (gettime() <= level.starttime + 250);
  }

  return gettime() <= level.starttimeutcseconds + 250;
}

function cs_init_flags(var0) {
  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_init("create_script_initialized");
  }

  var0.objects = [];
  var0 scripts\engine\utility::ent_flag_init("cs_structs_complete");
  var0 scripts\engine\utility::ent_flag_init("cs_models_complete");
  var0 scripts\engine\utility::ent_flag_init("cs_triggers_complete");
}

function initbunkerbackwallkeypads(var0) {
  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_init("create_script_initialized");
  }

  var0.objects = [];
  var0 scripts\engine\utility::ent_flag_init("cs_structs_complete");
}

function wait_for_flags(var0, var1) {
  if(var0 scripts\engine\utility::ent_flag_exist("cs_structs_complete")) {
    var0 scripts\engine\utility::ent_flag_wait("cs_structs_complete");
  }

  if(var0 scripts\engine\utility::ent_flag_exist("cs_models_complete")) {
    var0 scripts\engine\utility::ent_flag_wait("cs_models_complete");
  }

  if(var0 scripts\engine\utility::ent_flag_exist("cs_triggers_complete")) {
    var0 scripts\engine\utility::ent_flag_wait("cs_triggers_complete");
  }

  scripts\engine\utility::flag_set(var1 + "_completed");

  if(cs_is_starttime()) {
    endcreatescript(var0);
    return;
  }
}

function endcreatescript(var0) {
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

function wait_for_cs_flag(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_init(var0 + "_completed");

  if(!should_wait_for_cs_flag(var0)) {
    endcreatescript();
    scripts\engine\utility::flag_wait(var0);
    return;
  }
}

function should_wait_for_cs_flag(var0) {
  var1 = strtok(getDvar("scr_init_cs_files", ""), " ");
  var1 = scripts\engine\utility::array_combine(var1, level.aud_interior_plane_audio_zones);

  if(var1.size < 1) {
    return true;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(var3 == "all") {
      return true;
    }

    if(var0 == var3) {
      return true;
    }
  }

  return false;
}

function register_cs_offsets(var0, var1, var2) {
  if(isDefined(var1)) {
    level.cs_origin_offset[var0] = var1;
  }

  if(isDefined(var2)) {
    level.cs_angle_offset[var0] = var2;
    return;
  }
}

function set_cs_file_dvar(var0) {
  level.aud_interior_plane_audio_zones[level.aud_interior_plane_audio_zones.size] = var0;
}

function cleanup_cs_file_objects(var0) {
  scripts\engine\utility::flag_clear(var0 + "_completed");
  scripts\engine\utility::flag_clear(var0);

  if(isDefined(level.cs_object_container[var0]) && isDefined(level.cs_object_container[var0].objects)) {
    var1 = level.cs_object_container[var0].objects;

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = var1[var2];
      level.cs_object_container[var0].objects[var2] = undefined;

      if(isstruct(var3)) {
        scripts\engine\utility::deletestruct_ref(var3);
      }

      if(isent(var3)) {
        var3 delete();
      }
    }

    return;
  }
}

function s() {
  return spawnStruct();
}

function ref_13529(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    if(!isDefined(var3.angles)) {
      var3.angles = (0, 0, 0);
    }

    var4 = "Cover Stand";

    switch (var3.ref_11eaa) {
      case "cover_left":
        var4 = "Cover Left";
        break;
      case "cover_right":
        var4 = "Cover Right";
        break;
      case "cover_crouch":
        var4 = "Cover Crouch";
        break;
      case "cover_stand":
        var4 = "Cover Stand";
        break;
      case "cover_crouch_window":
        var4 = "Cover Crouch Window";
        break;
      case "conceal_crouch":
        var4 = "Conceal Crouch";
        break;
      case "cover_exposed":
        var4 = "Exposed";
      case "turret":
        var4 = "Turret";
        break;
    }

    var5 = undefined;

    if(isDefined(var3.ref_11ea3)) {
      var5 = var3.ref_11ea3;
    }

    var6 = 0;

    if(isDefined(var3.ref_11ebf) && int(var3.ref_11ebf) != 0 && var3.ref_11ebf != "false") {
      var6 = 4;
    }

    if(isDefined(var3.ref_11e99) && int(var3.ref_11e99) != 0 && var3.ref_11e99 != "false") {
      var6 += 8;
    }

    if(isDefined(var3.ref_11eb6) && int(var3.ref_11eb6) != 0 && var3.ref_11eb6 != "false") {
      var6 += 16;
    }

    var3.covernode = spawncovernode(var3.origin, var3.angles, var4, var6, var5);

    if(isDefined(var3.radius)) {
      var3.covernode.radius = var3.radius;
    }
  }

  return var1;
}

function land_usability_disabled(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.covernode)) {
      despawncovernode(var3.covernode);
      var3.covernode = undefined;
    }
  }
}