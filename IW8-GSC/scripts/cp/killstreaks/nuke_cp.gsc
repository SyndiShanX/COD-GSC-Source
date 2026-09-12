/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\nuke_cp.gsc
***********************************************/

function init_script_triggers() {
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = scripts\cp\utility::array_merge(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = scripts\cp\utility::array_merge(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = scripts\cp\utility::array_merge(var_4, var_9);

  foreach(var_11 in var_4) {
    if(var_11.spawnflags & 32) {
      thread trigger_spawner(var_4);
    }
  }

  var_13 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage", "trigger_hurt"];

  foreach(var_15 in var_13) {
    var_4 = getEntArray(var_15, "code_classname");

    foreach(var_11 in var_4) {
      if(isDefined(var_11.script_exploder)) {
        thread exploder_load(level);
      }

      if(isDefined(var_11.targetname)) {
        var_17 = var_11.targetname;

        if(isDefined(var_1[var_17])) {
          level thread[[var_1[var_17]]](var_11);
        }
      }
    }
  }
}

function get_load_trigger_classes() {
  var_0 = [];
  GscBinSkip0(0x2e, "trigger_multiple_flag_set", &trigger_flag_set);
}

function get_load_trigger_funcs() {
  var_0 = [];
  GscBinSkip0(0x2e, "trigger_spawner", &trigger_spawner);
}

function trigger_script_flag_false(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  add_tokens_to_trigger_flags(var_0, var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

function trigger_script_flag_true(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  add_tokens_to_trigger_flags(var_0, var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

function add_tokens_to_trigger_flags(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

function exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay)) {
      wait var_0.script_delay;
    } else {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

function get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

function trigger_flag_set(var_0) {
  var_1 = get_trigger_flag(var_0);
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(getdropposition(var_0)) {
      var_0 scripts\engine\utility::script_delay();
      scripts\engine\utility::flag_set(var_1, var_2);

      if(!isDefined(var_0)) {
        break;
      }
    }
  }
}

function getdropposition() {
  if(turret_has_target(self)) {
    return true;
  }

  if(self.spawnflags & 2) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(var_2 istouching(self)) {
        return true;
      }
    }
  }

  if(self.spawnflags & 4) {
    var_4 = getaiarray("allies");

    foreach(var_2 in var_4) {
      if(var_2 istouching(self)) {
        return true;
      }
    }
  }

  return false;
}

function trigger_flag_clear(var_0) {
  var_1 = get_trigger_flag(var_0);

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

function trigger_flag_set_touching(var_0) {
  var_1 = get_trigger_flag(var_0);
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0) && turret_has_target(var_0)) {
      scripts\engine\utility::flag_set(var_1);
    }

    while(isDefined(var_0) && turret_has_target(var_0)) {
      wait 0.25;
    }

    scripts\engine\utility::flag_clear(var_1);

    if(!isDefined(var_0)) {
      break;
    }
  }
}

function turret_has_target(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }

    if(var_2 istouching(var_0)) {
      return true;
    }
  }

  return false;
}

function trigger_spawner(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0.target;
  var_0 scripts\engine\utility::script_delay();
  var_2 = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(var_1, "targetame"), getEntArray(var_1));

  foreach(var_4 in var_2) {
    if(isstruct(var_4)) {
      var_4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      continue;
    }

    if(var_4.code_classname == "script_vehicle") {
      if(isDefined(var_4.script_moveoverride) && var_4.script_moveoverride == 1 || !isDefined(var_4.target)) {
        thread scripts\common\vehicle::vehicle_spawn(var_4);
        continue;
      }

      var_4 thread scripts\common\vehicle::spawn_vehicle_and_gopath();
    }
  }
}

function flood_trigger_think(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  scripts\engine\utility::array_thread(var_1, &flood_spawner_init);
  var_0 waittill("trigger");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  scripts\engine\utility::array_thread(var_1, &flood_spawner_think, var_0);
}

function flood_spawner_init() {}

function flood_spawner_think(var_0) {
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  scripts\engine\utility::script_delay();

  while(self.count > 0) {
    var_1 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(!isDefined(var_1)) {
      wait 2;
      continue;
    }

    var_1 waittill("death", var_2);

    if(!scripts\engine\utility::script_wait()) {
      wait randomfloatrange(2, 5);
    }
  }
}

function trigger_zone_spawn(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_0 scripts\engine\utility::script_delay();
    var_2 = scripts\engine\utility::getStructArray(var_0.target);

    foreach(var_4 in var_2) {
      var_4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    }

    while(turret_has_target(var_0)) {
      wait 0.1;
    }
  }
}

function trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

function ref_13DA6(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1) || isagent(var_1)) {
      var_1 kill();
    }
  }
}