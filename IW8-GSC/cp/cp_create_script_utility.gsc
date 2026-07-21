/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_create_script_utility.gsc
***********************************************/

thermitestucktoshield() {
  struct_set_fields();
}

struct_set_fields(var_0) {
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

thirtypercent_music() {
  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      for(var_0 = 0; var_0 < level.scripted_spawner_func.size; var_0++)
        [[level.scripted_spawner_func[var_0]]](1, "_encstr_8A0703D983" + var_0);
    } else if(istrue(level.threadedscriptspawners))
      [[level.scripted_spawner_func]](1);
    else
      [[level.scripted_spawner_func]]();
  }
}

register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;

  if(isDefined(var_0))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;

  if(isDefined(var_1))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;

  if(isDefined(var_2))
    level.create_script_file_ids[var_0] = "_encstr_8A0703D983" + var_2;
}

thermometerwatch(var_0) {
  if(scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_set(var_0);

    if(scripts\engine\utility::flag_exist(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8")) {
      level endon("_encstr_9B1D0BC7932875276230426AA1");
      scripts\engine\utility::flag_wait(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
    }
  }
}

_id_12B00(var_0) {
  if(!isDefined(level.brjuggernautcrateactivatecallback))
    level.brjuggernautcrateactivatecallback = [];

  level.brjuggernautcrateactivatecallback = scripts\engine\utility::array_add(level.brjuggernautcrateactivatecallback, var_0);
}

_id_12B01(var_0) {
  if(!isDefined(level.brjuggernautcratecapturecallback))
    level.brjuggernautcratecapturecallback = [];

  level.brjuggernautcratecapturecallback = scripts\engine\utility::array_add(level.brjuggernautcratecapturecallback, var_0);
}

strike_setup_arrays(var_0, var_1) {
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

  if(isDefined(var_0) && !isDefined(level.scripted_spawners[var_0]))
    level.scripted_spawners[var_0] = [];

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_triggers[var_0]))
    level.scripted_spawners_triggers[var_0] = [];

  if(isDefined(var_0) && !isDefined(level.scripted_spawners_models[var_0]))
    level.scripted_spawners_models[var_0] = [];

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners[var_0]))
    level.cs_scripted_spawners[var_0] = [];

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_triggers[var_0]))
    level.cs_scripted_spawners_triggers[var_0] = [];

  if(isDefined(var_0) && !isDefined(level.cs_scripted_spawners_models[var_0]))
    level.cs_scripted_spawners_models[var_0] = [];

  if(!isDefined(level.cs_object_container))
    level.cs_object_container = [];

  if(isDefined(var_1) && !isDefined(level.cs_object_container[var_1]))
    level.cs_object_container[var_1] = self;
}

strike_additem(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!var_0 _id_11F7C()) {
    return;
  }
  if(isDefined(level.cs_creation_counter) && !cs_is_starttime()) {
    level.cs_creation_counter++;

    if(level.cs_creation_counter % 25 == 0)
      waitframe();
  }

  if(isDefined(var_3))
    var_0.origin = var_3;

  if(isDefined(var_4))
    var_0.angles = var_4;
  else if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(isDefined(var_5))
    var_0.targetname = var_5;

  if(isDefined(var_6))
    var_0.target = var_6;

  if(isDefined(var_7))
    var_0.script_noteworthy = var_7;

  if(isDefined(var_8))
    var_0.script_linkto = var_8;

  if(isDefined(var_9))
    var_0.script_linkname = var_9;

  if(isDefined(var_13))
    var_0.speed = var_13;

  if(isDefined(var_12))
    var_0.radius = var_12;

  if(isDefined(var_14))
    var_0.spawnflags = int(var_14);

  if(isDefined(var_15))
    var_0.script_unload = var_15;

  translate_position_with_offset_data(var_2, var_0, var_10, var_11);

  if(!isDefined(var_1))
    var_1 = "_encstr_BA4C02DF";

  strike_fixautokvps(var_0, var_1);
  typecast_kvps(var_0);

  if(isDefined(self.objects))
    self.objects[self.objects.size] = var_0;

  if(isDefined(var_0.model)) {
    if(istrue(var_0.is_cs_model))
      var_0.is_cs_model = undefined;

    strike_modelcreate(var_0, var_1);
  } else {
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
        _id_13921(var_0, var_1);
        return;
      }

      switch (var_0.targetname) {
        case "_encstr_84640E5C1E08BFC7D380F93378333B63":
          strike_triggercreate(var_0, var_1);
          break;
        case "_encstr_A79611E5424A1739B503398837C4105592AED2":
          strike_triggercreate(var_0, var_1);
          break;
        case "_encstr_99CA0EDAB78CBA36ACEB57C13258A395":
          strike_triggercreate(var_0, var_1, 1);
          break;
        case "_encstr_9A350B80AB4949EB0FD7040DBA":
          strike_triggercreate(var_0, var_1, 1);
          break;
        case "_encstr_81010C2D9BE8B29C0B8D1D2DED37":
          strike_interactioncreate(var_0, var_1);
          break;
        case "_encstr_8F7E1AAD2B5A01B7557B691AE0716360C824679271A718116368F5F3":
          strike_triggercreate(var_0, var_1, 1);
          break;
        default:
          strike_addstructtolevel(var_0, 0, var_1);
          break;
      }

      return;
      return;
      return;
      return;
    }

    strike_addstructtolevel(var_0, 0, var_1);
  }
}

_id_11F7C() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(level.brjuggernautcrateactivatecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var_2 = 0; var_2 < level.brjuggernautcrateactivatecallback.size; var_2++) {
        if(getsubstr(level.brjuggernautcrateactivatecallback[var_2], 0, 1) == "_encstr_AD4C0212")
          var_3 = 1;
        else
          var_3 = 0;

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcrateactivatecallback[var_2]) != var_3) {
          var_0 = 1;
          break;
        }
      }
    } else
      var_0 = 1;
  } else
    var_0 = 1;

  if(isDefined(level.brjuggernautcratecapturecallback)) {
    if(isDefined(self.script_gameobjectname)) {
      for(var_2 = 0; var_2 < level.brjuggernautcratecapturecallback.size; var_2++) {
        if(getsubstr(level.brjuggernautcratecapturecallback[var_2], 0, 1) == "_encstr_AD4C0212")
          var_3 = 1;
        else
          var_3 = 0;

        if(trophy_watchtimeoutorgameendedinternal(self.script_gameobjectname, level.brjuggernautcratecapturecallback[var_2]) != var_3) {
          var_1 = 1;
          break;
        }
      }
    } else
      var_1 = 1;
  } else
    var_1 = 1;

  return istrue(var_0 && var_1);
}

trophy_watchtimeoutorgameendedinternal(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "_encstr_B40101" || !isDefined(var_1) || var_1 == "_encstr_B40101")
    return 0;

  return issubstr(var_0, var_1);
}

translate_position_with_offset_data(var_0, var_1, var_2, var_3) {
  _id_13CF2(var_0, var_1);

  if(isDefined(var_2)) {
    if(!isDefined(var_3))
      var_3 = (0, 0, 0);

    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles))
      var_4 = var_1.angles;

    var_5 = var_1.origin;
    var_1.origin = var_2 + rotatevector(var_5, var_3);

    if(isDefined(var_1.script_origin_other))
      var_1.script_origin_other = var_2 + rotatevector(var_1.script_origin_other, var_3);

    var_6 = combineangles(var_3, var_4);
    var_1.angles = var_6;
  }
}

_id_13CF2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level.cs_origin_offset) && isDefined(level.cs_angle_offset[var_0])) {
    var_2 = level.cs_angle_offset[var_0];
    var_3 = level.cs_origin_offset[var_0];
    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles))
      var_4 = var_1.angles;

    var_5 = var_1.origin;
    var_1.origin = var_3 + rotatevector(var_5, var_2);

    if(isDefined(var_1.script_origin_other))
      var_1.script_origin_other = var_3 + rotatevector(var_1.script_origin_other, var_2);

    var_6 = combineangles(var_2, var_4);
    var_1.angles = var_6;
  }
}

strike_add_to_cs_arrays(var_0, var_1, var_2) {
  if(!getdvarint("_encstr_AF76191BB6BB57FA9B4A3BE94D7199FA8DC6FC05C0C2177B3AF821", 0)) {
    return;
  }
  if(var_0 == "_encstr_91D8076ED193D5B11D")
    level.scripted_spawners[var_2][level.scripted_spawners[var_2].size] = var_1;
  else if(var_0 == "_encstr_8F5C086405E70FBA4B4A")
    level.scripted_spawners_triggers[var_2][level.scripted_spawners_triggers[var_2].size] = var_1;
  else if(var_0 == "_encstr_A59306224004FA23")
    level.scripted_spawners_models[var_2][level.scripted_spawners_models[var_2].size] = var_1;
}

strike_interactioncreate(var_0, var_1) {
  strike_addstructtolevel(var_0, 1, var_1);
}

_id_13921(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);

  if(!isDefined(var_0.angles))
    var_2.angles = (0, 0, 0);
  else
    var_2.angles = var_0.angles;

  if(isDefined(var_0.model))
    var_2 setModel(var_0.model);

  if(isDefined(var_0.targetname))
    var_2.targetname = var_0.targetname;

  if(isDefined(var_0.script_noteworthy))
    var_2.script_noteworthy = var_0.script_noteworthy;

  if(isDefined(var_0.script_linkto))
    var_2.script_linkto = var_0.script_linkto;

  if(isDefined(var_0.script_linkname))
    var_2.script_linkname = var_0.script_linkname;

  if(isDefined(var_0.target))
    var_2.target = var_0.target;

  var_2.struct = var_0;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = var_2;
}

strike_modelcreate(var_0, var_1) {
  strike_add_to_cs_arrays("_encstr_A59306224004FA23", var_0, var_1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2.angles = var_0.angles;
  var_2 setModel(var_0.model);

  if(isDefined(var_0.targetname))
    var_2.targetname = var_0.targetname;

  if(isDefined(var_0.script_noteworthy))
    var_2.script_noteworthy = var_0.script_noteworthy;

  if(isDefined(var_0.script_linkto))
    var_2.script_linkto = var_0.script_linkto;

  if(isDefined(var_0.script_linkname))
    var_2.script_linkname = var_0.script_linkname;

  if(isDefined(var_0.target))
    var_2.target = var_0.target;

  if(isDefined(var_0.name))
    var_2.name = var_0.name;

  var_2.struct = var_0;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = var_2;
}

strike_triggercreate(var_0, var_1, var_2) {
  strike_add_to_cs_arrays("_encstr_8F5C086405E70FBA4B4A", var_0, var_1);
  var_3 = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_0.origin, 0, int(var_0.radius), int(var_0.height));

  if(isDefined(var_0.angles) && var_0.angles != (0, 0, 0)) {
    if(istrue(var_2))
      var_3.angles = var_0.angles;
    else
      var_3.angles = (-90, 0, 0) + var_0.angles;
  }

  var_3.struct = var_0;

  if(isDefined(self.objects))
    self.objects[self.objects.size] = var_3;

  var_3 strike_triggerassignvalues(var_0);
}

strike_triggerassignvalues(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(isDefined(var_0.script_label))
    self.script_label = var_0.script_label;

  if(isDefined(var_0.script_function))
    self.script_function = var_0.script_function;

  if(isDefined(var_0.script_noteworthy))
    self.script_noteworthy = var_0.script_noteworthy;

  if(isDefined(var_0.script_gesture))
    self.script_gesture = var_0.script_gesture;

  if(isDefined(var_0.target))
    self.target = var_0.target;

  if(isDefined(var_0.script_wtf))
    self.script_wtf = var_0.script_wtf;

  if(isDefined(var_0.script_flag))
    self.script_flag = var_0.script_flag;

  if(isDefined(var_0.script_linkto))
    self.script_linkto = var_0.script_linkto;

  if(isDefined(var_0.script_linkname))
    self.script_linkname = var_0.script_linkname;

  if(isDefined(var_0.groupname))
    self.groupname = var_0.groupname;

  if(isDefined(var_0.script_count))
    self.script_count = var_0.script_count;

  if(isDefined(var_0.script_count_min))
    self.script_count_min = var_0.script_count_min;

  if(isDefined(var_0.script_count_max))
    self.script_count_max = var_0.script_count_max;

  if(isDefined(var_0.script_maxdist))
    self.script_maxdist = var_0.script_maxdist;

  self.targetname = var_0.targetname;
}

strike_addstructtolevel(var_0, var_1, var_2) {
  if(isDefined(var_0.target))
    initbunkeranims("_encstr_A16007A921A23B85E3", var_0.target, var_0);

  if(isDefined(var_0.script_linkname))
    initbunkeranims("_encstr_A29D10371B275A1C47F536969BDAB90BB5B2", var_0.script_linkname, var_0);

  if(isDefined(var_0.targetname))
    initbunkeranims("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_0.targetname, var_0);

  if(isDefined(var_0.script_noteworthy))
    initbunkeranims("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_0.script_noteworthy, var_0);
}

initbunkeranims(var_0, var_1, var_2) {
  if(!isDefined(level.struct_class_names[var_0][var_1]))
    level.struct_class_names[var_0][var_1] = [];

  level.struct_class_names[var_0][var_1][level.struct_class_names[var_0][var_1].size] = var_2;
}

strike_fixautokvps(var_0, var_1) {
  if(isDefined(var_0.target) && issubstr(var_0.target, "_encstr_AD84055EA3D5D0"))
    var_0.target = "_encstr_831904BF777B" + var_1 + var_0.target;

  if(isDefined(var_0.targetname) && issubstr(var_0.targetname, "_encstr_AD84055EA3D5D0"))
    var_0.targetname = "_encstr_831904BF777B" + var_1 + var_0.targetname;

  if(isDefined(var_0.script_linkto)) {
    var_2 = "_encstr_B40101";
    var_3 = strtok(var_0.script_linkto, "_encstr_974C0246");

    foreach(var_6, var_5 in var_3) {
      if(var_6 != 0) {
        if(int(var_0.script_linkto) == 0)
          var_2 = var_2 + "_encstr_974C0246" + var_5;
        else
          var_2 = var_2 + "_encstr_974C0246" + "_encstr_831904BF777B" + var_1 + var_5;

        continue;
      }

      if(int(var_0.script_linkto) == 0) {
        var_2 = var_2 + var_5;
        continue;
      }

      var_2 = var_2 + "_encstr_831904BF777B" + var_1 + var_5;
    }

    var_0.script_linkto = var_2;
  }

  if(isDefined(var_0.script_linkname)) {
    if(int(var_0.script_linkname) != 0)
      var_0.script_linkname = "_encstr_831904BF777B" + var_1 + var_0.script_linkname;
  }
}

typecast_kvps(var_0) {
  if(istrue(var_0.ishelistruct)) {
    if(isDefined(var_0.script_unload))
      var_0.script_unload = int(var_0.script_unload);
  }

  if(isDefined(var_0.script_wait_min))
    var_0.script_wait_min = float(var_0.script_wait_min);

  if(isDefined(var_0.script_wait_max))
    var_0.script_wait_max = float(var_0.script_wait_max);

  if(isDefined(var_0.script_wait_add))
    var_0.script_wait_add = float(var_0.script_wait_add);

  if(isDefined(var_0.script_brake))
    var_0.script_brake = float(var_0.script_brake);

  if(isDefined(var_0.lookahead))
    var_0.lookahead = int(var_0.lookahead);

  if(isDefined(var_0.speed))
    var_0.speed = int(var_0.speed);

  if(isDefined(var_0.script_accel))
    var_0.script_accel = int(var_0.script_accel);

  if(isDefined(var_0.script_decel))
    var_0.script_decel = int(var_0.script_decel);

  if(isDefined(var_0.script_speed))
    var_0.script_speed = int(var_0.script_speed);

  if(isDefined(var_0.script_goalyaw)) {
    if(var_0.script_goalyaw == "_encstr_AAEF05B83B43EB" || var_0.script_goalyaw == "_encstr_A34C02BB")
      var_0.script_goalyaw = 1;
    else
      var_0.script_goalyaw = undefined;
  }

  if(isDefined(var_0.script_anglevehicle)) {
    if(var_0.script_anglevehicle == "_encstr_AAEF05B83B43EB" || var_0.script_anglevehicle == "_encstr_A34C02BB")
      var_0.script_goalyaw = 1;
    else
      var_0.script_goalyaw = undefined;
  }

  if(isDefined(var_0.script_delay))
    var_0.script_delay = float(var_0.script_delay);

  if(isDefined(var_0.script_ignoreme))
    var_0.script_ignoreme = int(var_0.script_ignoreme);

  if(isDefined(var_0.script_ignoreall))
    var_0.script_ignoreall = int(var_0.script_ignoreall);

  if(isDefined(var_0.script_death))
    var_0.script_death = int(var_0.script_death);

  if(isDefined(var_0.script_wait))
    var_0.script_wait = float(var_0.script_wait);

  if(isDefined(var_0.script_forcespawn))
    var_0.script_forcespawn = int(var_0.script_forcespawn);

  if(isDefined(var_0.script_timer))
    var_0.script_timer = int(var_0.script_timer);

  if(isDefined(var_0.script_dist_only))
    var_0.script_dist_only = int(var_0.script_dist_only) * int(var_0.script_dist_only);

  if(isDefined(var_0.script_speed))
    var_0.script_speed = int(var_0.script_speed);

  if(isDefined(var_0.script_count))
    var_0.script_count = int(var_0.script_count);

  if(isDefined(var_0.script_radius))
    var_0.script_radius = int(var_0.script_radius);

  if(isDefined(var_0.script_delay_min))
    var_0.script_delay_min = float(var_0.script_delay_min);

  if(isDefined(var_0.script_delay_max))
    var_0.script_delay_max = float(var_0.script_delay_max);

  if(isDefined(var_0.script_escalation_level))
    var_0.script_escalation_level = int(var_0.script_escalation_level);

  if(isDefined(var_0.script_goalheight))
    var_0.script_goalheight = int(var_0.script_goalheight);

  if(isDefined(var_0.script_timeout))
    var_0.script_timeout = float(var_0.script_timeout);

  if(isDefined(var_0.script_pacifist))
    var_0.script_pacifist = int(var_0.script_pacifist);

  if(isDefined(var_0.script_forcespawn))
    var_0.script_forcespawn = int(var_0.script_forcespawn);

  if(isDefined(var_0.dontkilloff))
    var_0.dontkilloff = int(var_0.dontkilloff);

  if(isDefined(var_0.script_origin_other))
    var_0.script_origin_other = var_0.script_origin_other;

  if(isDefined(var_0.script_dot))
    var_0.script_dot = int(var_0.script_dot);

  if(isDefined(var_0.script_ignoreall))
    var_0.script_ignoreall = int(var_0.script_ignoreall);
}

cs_is_starttime() {
  if(scripts\common\utility::iscp())
    return gettime() <= level.starttime + 250;
  else
    return gettime() <= level.starttimeutcseconds + 250;
}

cs_init_flags(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_init("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  var_0.objects = [];
  var_0 scripts\engine\utility::ent_flag_init("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
  var_0 scripts\engine\utility::ent_flag_init("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
  var_0 scripts\engine\utility::ent_flag_init("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

initbunkerbackwallkeypads(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_init("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  var_0.objects = [];
  var_0 scripts\engine\utility::ent_flag_init("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

wait_for_flags(var_0, var_1) {
  if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9"))
    var_0 scripts\engine\utility::ent_flag_wait("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");

  if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7"))
    var_0 scripts\engine\utility::ent_flag_wait("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");

  if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5"))
    var_0 scripts\engine\utility::ent_flag_wait("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");

  scripts\engine\utility::flag_set(var_1 + "_encstr_93D80BF536F6B638D8AC1D95C8");

  if(cs_is_starttime())
    endcreatescript(var_0);
}

endcreatescript(var_0) {
  if(isDefined(level.createscriptfilesinitialized)) {
    level.createscriptfilesinitialized++;

    if(level.createscriptfilesinitialized >= level.scripted_spawner_func.size) {
      scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
      scripts\engine\utility::flag_set("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
    }
  } else {
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    scripts\engine\utility::flag_set("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
  }
}

wait_for_cs_flag(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");

  if(!should_wait_for_cs_flag(var_0)) {
    endcreatescript();
    scripts\engine\utility::flag_wait(var_0);
  }
}

should_wait_for_cs_flag(var_0) {
  var_1 = strtok(getDvar("_encstr_87D9124B6393AECFD89C54373A5380FD074A1062", "_encstr_B40101"), "_encstr_974C0246");
  var_1 = scripts\engine\utility::array_combine(var_1, level.aud_interior_plane_audio_zones);

  if(var_1.size < 1)
    return 1;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "_encstr_AF1904A7F929")
      return 1;

    if(var_0 == var_3)
      return 1;
  }

  return 0;
}

register_cs_offsets(var_0, var_1, var_2) {
  if(isDefined(var_1))
    level.cs_origin_offset[var_0] = var_1;

  if(isDefined(var_2))
    level.cs_angle_offset[var_0] = var_2;
}

set_cs_file_dvar(var_0) {
  level.aud_interior_plane_audio_zones[level.aud_interior_plane_audio_zones.size] = var_0;
}

cleanup_cs_file_objects(var_0) {
  scripts\engine\utility::flag_clear(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  scripts\engine\utility::flag_clear(var_0);

  if(isDefined(level.cs_object_container[var_0]) && isDefined(level.cs_object_container[var_0].objects)) {
    var_1 = level.cs_object_container[var_0].objects;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];
      level.cs_object_container[var_0].objects[var_2] = undefined;

      if(isstruct(var_3))
        scripts\engine\utility::deletestruct_ref(var_3);

      if(isent(var_3))
        var_3 delete();
    }
  }
}

s() {
  return spawnStruct();
}

_id_13529(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.angles))
      var_3.angles = (0, 0, 0);

    var_4 = "_encstr_AFFF0C6E8FE899DDE6174B068510";

    switch (var_3._id_11EAA) {
      case "_encstr_87970BBFC71BCD10D7953951BB":
        var_4 = "_encstr_A7760B6710A315533959DF17AD";
        break;
      case "_encstr_91280CE8026B33B37F7ABBA448FB":
        var_4 = "_encstr_86A30C90489C3F32B21DA9AF0178";
        break;
      case "_encstr_8DE30D6CF69D2B937DB1277BAE8DD0":
        var_4 = "_encstr_87AB0D4BD7B857DB077503DA9B8EEB";
        break;
      case "_encstr_96BC0CA9321B0D2861C34163F697":
        var_4 = "_encstr_AFFF0C6E8FE899DDE6174B068510";
        break;
      case "_encstr_8B011499C0E5A0CDBE8AAA18B830FAA7D4288B49276B":
        var_4 = "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0";
        break;
      case "_encstr_B2970F58FF2E51F3223588AE8AFAEB9980":
        var_4 = "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C";
        break;
      case "_encstr_82780EB1ED67CA27BE56E138DBCD5691":
        var_4 = "_encstr_8E2508511EE07BE6B246";
      case "_encstr_A7AF07D1EF1B06683C":
        var_4 = "_encstr_A7AF0791EF1B06683C";
        break;
    }

    var_5 = undefined;

    if(isDefined(var_3._id_11EA3))
      var_5 = var_3._id_11EA3;

    var_6 = 0;

    if(isDefined(var_3._id_11EBF) && int(var_3._id_11EBF) != 0 && var_3._id_11EBF != "_encstr_B6C106D7FF89633D")
      var_6 = 4;

    if(isDefined(var_3._id_11E99) && int(var_3._id_11E99) != 0 && var_3._id_11E99 != "_encstr_B6C106D7FF89633D")
      var_6 = var_6 + 8;

    if(isDefined(var_3._id_11EB6) && int(var_3._id_11EB6) != 0 && var_3._id_11EB6 != "_encstr_B6C106D7FF89633D")
      var_6 = var_6 + 16;

    var_3.covernode = spawncovernode(var_3.origin, var_3.angles, var_4, var_6, var_5);

    if(isDefined(var_3.radius))
      var_3.covernode.radius = var_3.radius;
  }

  return var_1;
}

land_usability_disabled(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.covernode)) {
      despawncovernode(var_3.covernode);
      var_3.covernode = undefined;
    }
  }
}