/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\nuke_cp.gsc
***********************************************/

function init_script_triggers() {
  var0 = get_load_trigger_classes();
  var1 = get_load_trigger_funcs();

  foreach(var3 in var0) {
    var4 = getEntArray(var5, "classname");
    scripts\engine\utility::array_levelthread(var4, var3);
  }

  var6 = getEntArray("trigger_multiple", "classname");
  var7 = getEntArray("trigger_radius", "classname");
  var4 = scripts\cp\utility::array_merge(var6, var7);
  var8 = getEntArray("trigger_disk", "classname");
  var4 = scripts\cp\utility::array_merge(var4, var8);
  var9 = getEntArray("trigger_once", "classname");
  var4 = scripts\cp\utility::array_merge(var4, var9);

  foreach(var11 in var4) {
    if(var11.spawnflags & 32) {
      thread trigger_spawner(var4);
    }
  }

  var13 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage", "trigger_hurt"];

  foreach(var15 in var13) {
    var4 = getEntArray(var15, "code_classname");

    foreach(var11 in var4) {
      if(isDefined(var11.script_exploder)) {
        thread exploder_load(level);
      }

      if(isDefined(var11.targetname)) {
        var17 = var11.targetname;

        if(isDefined(var1[var17])) {
          level thread[[var1[var17]]](var11);
        }
      }
    }
  }
}

function get_load_trigger_classes() {
  var0 = [];
  GscBinSkip0(0x2e, "trigger_multiple_flag_set", &trigger_flag_set);
}

function get_load_trigger_funcs() {
  var0 = [];
  GscBinSkip0(0x2e, "trigger_spawner", &trigger_spawner);
}

function trigger_script_flag_false(var0) {
  var1 = scripts\engine\utility::create_flags_and_return_tokens(var0.script_flag_false);
  add_tokens_to_trigger_flags(var0, var1);
  var0 scripts\engine\utility::update_trigger_based_on_flags();
}

function trigger_script_flag_true(var0) {
  var1 = scripts\engine\utility::create_flags_and_return_tokens(var0.script_flag_true);
  add_tokens_to_trigger_flags(var0, var1);
  var0 scripts\engine\utility::update_trigger_based_on_flags();
}

function add_tokens_to_trigger_flags(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isDefined(level.trigger_flags[var2])) {
      level.trigger_flags[var2] = [];
    }

    level.trigger_flags[var2][level.trigger_flags[var2].size] = self;
  }
}

function exploder_load(var0) {
  level endon("killexplodertridgers" + var0.script_exploder);
  var0 waittill("trigger");

  if(isDefined(var0.script_chance) && randomfloat(1) > var0.script_chance) {
    if(isDefined(var0.script_delay)) {
      wait var0.script_delay;
    } else {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  scripts\engine\utility::exploder(var0.script_exploder);
  level notify("killexplodertridgers" + var0.script_exploder);
}

function get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

function trigger_flag_set(var0) {
  var1 = get_trigger_flag(var0);
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);

    if(getdropposition(var0)) {
      var0 scripts\engine\utility::script_delay();
      scripts\engine\utility::flag_set(var1, var2);

      if(!isDefined(var0)) {
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
    var0 = getaiarray("axis");

    foreach(var2 in var0) {
      if(var2 istouching(self)) {
        return true;
      }
    }
  }

  if(self.spawnflags & 4) {
    var4 = getaiarray("allies");

    foreach(var2 in var4) {
      if(var2 istouching(self)) {
        return true;
      }
    }
  }

  return false;
}

function trigger_flag_clear(var0) {
  var1 = get_trigger_flag(var0);

  if(!isDefined(level.flag[var1])) {
    scripts\engine\utility::flag_init(var1);
  }

  for(;;) {
    var0 waittill("trigger");
    var0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var1);
  }
}

function trigger_flag_set_touching(var0) {
  var1 = get_trigger_flag(var0);
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);
    var0 scripts\engine\utility::script_delay();

    if(isDefined(var0) && turret_has_target(var0)) {
      scripts\engine\utility::flag_set(var1);
    }

    while(isDefined(var0) && turret_has_target(var0)) {
      wait 0.25;
    }

    scripts\engine\utility::flag_clear(var1);

    if(!isDefined(var0)) {
      break;
    }
  }
}

function turret_has_target(var0) {
  foreach(var2 in level.players) {
    if(!isalive(var2)) {
      continue;
    }

    if(var2 istouching(var0)) {
      return true;
    }
  }

  return false;
}

function trigger_spawner(var0) {
  var0 waittill("trigger");
  var1 = var0.target;
  var0 scripts\engine\utility::script_delay();
  var2 = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(var1, "targetame"), getEntArray(var1));

  foreach(var4 in var2) {
    if(isstruct(var4)) {
      var4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      continue;
    }

    if(var4.code_classname == "script_vehicle") {
      if(isDefined(var4.script_moveoverride) && var4.script_moveoverride == 1 || !isDefined(var4.target)) {
        thread scripts\common\vehicle::vehicle_spawn(var4);
        continue;
      }

      var4 thread scripts\common\vehicle::spawn_vehicle_and_gopath();
    }
  }
}

function flood_trigger_think(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  scripts\engine\utility::array_thread(var1, &flood_spawner_init);
  var0 waittill("trigger");
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  scripts\engine\utility::array_thread(var1, &flood_spawner_think, var0);
}

function flood_spawner_init() {}

function flood_spawner_think(var0) {
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  scripts\engine\utility::script_delay();

  while(self.count > 0) {
    var1 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(!isDefined(var1)) {
      wait 2;
      continue;
    }

    var1 waittill("death", var2);

    if(!scripts\engine\utility::script_wait()) {
      wait randomfloatrange(2, 5);
    }
  }
}

function trigger_zone_spawn(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);
    var0 scripts\engine\utility::script_delay();
    var2 = scripts\engine\utility::getStructArray(var0.target);

    foreach(var4 in var2) {
      var4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    }

    while(turret_has_target(var0)) {
      wait 0.1;
    }
  }
}

function trigger_vehicle_spline_spawn(var0) {
  var0 waittill("trigger");
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    var3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

function ref_13da6(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isPlayer(var1) || isagent(var1)) {
      var1 kill();
    }
  }
}