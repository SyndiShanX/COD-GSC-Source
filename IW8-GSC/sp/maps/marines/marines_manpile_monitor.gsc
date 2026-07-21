/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_manpile_monitor.gsc
*******************************************************/

manpile_monitor() {
  manpile_monitor_initialize();

  for(;;) {
    manpile_monitor_core_loop();
    wait(level.manpile_monitor.wait_time);
  }
}

manpile_monitor_initialize() {
  level.manpile_monitor = spawnStruct();
  level.manpile_monitor.maximum = 20;
  level.manpile_monitor.maximum_in_fov = 12;
  level.manpile_monitor.ideal = 15;
  level.manpile_monitor.safe_delete_distance = 2000;
  level.manpile_monitor.fov = 60;
  level.manpile_monitor.working_fov = 60;
  level.manpile_monitor.wait_time = 0.5;
  level.manpile_monitor.verbose = 0;
  level.manpile_monitor.disabled = 0;
  level.manpile_monitor.maximum_weapons = 24;
}

manpile_monitor_core_loop() {
  if(level.manpile_monitor.disabled) {
    return;
  }
  var_0 = getcorpsearray();
  var_1 = getweaponarray();
  manpile_monitor_print("Corpses " + var_0.size + ",Weapons " + var_1.size);

  if(var_0.size < level.manpile_monitor.ideal && var_0.size < level.manpile_monitor.maximum_in_fov)
    manpile_monitor_reset_fov();
  else {
    if(getcorpsearray().size > level.manpile_monitor.maximum) {
      manpile_monitor_cull_urgent(getcorpsearray());

      if(var_0.size <= level.manpile_monitor.maximum) {
        return;
      }
      wait(level.manpile_monitor.wait_time / 2);
    }

    var_0 = getcorpsearray();

    if(var_0.size > level.manpile_monitor.ideal) {
      manpile_monitor_cull_ideal(var_0);

      if(var_0.size <= level.manpile_monitor.ideal) {
        return;
      }
      wait(level.manpile_monitor.wait_time / 2);
    }

    var_0 = getcorpsearray();

    if(var_1.size > level.manpile_monitor.maximum_weapons) {
      manpile_monitor_cull_weapons(var_1);

      if(var_1.size <= level.manpile_monitor.maximum_weapons) {
        return;
      }
      wait(level.manpile_monitor.wait_time / 2);
    }

    var_0 = getcorpsearray();

    if(var_0.size > level.manpile_monitor.maximum_in_fov) {
      manpile_monitor_cull_fov(var_0);
      wait(level.manpile_monitor.wait_time / 2);
    }

    var_0 = getcorpsearray();

    if(var_0.size > level.manpile_monitor.maximum) {
      manpile_monitor_print("FOV too high for culling - turning it down to " + level.manpile_monitor.working_fov * 0.9);
      level.manpile_monitor.working_fov = level.manpile_monitor.working_fov * 0.9;
      return;
    }

    manpile_monitor_reset_fov();
  }
}

manpile_monitor_cull_urgent(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_noteworthy) || var_3.script_noteworthy != "manpile_monitor_exempt") {
      if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3.origin, cos(level.manpile_monitor.working_fov)))
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  var_1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_1);

  while(getcorpsearray().size > level.manpile_monitor.maximum) {
    if(var_1.size > 0) {
      var_1[0] delete();
      var_1 = scripts\engine\utility::array_removeundefined(var_1);
      manpile_monitor_print("Bodies over maximum limit!Deleting one");
      continue;
    }

    break;
  }

  if(getcorpsearray().size > level.manpile_monitor.maximum)
    manpile_monitor_cull_fov(var_1);
}

manpile_monitor_cull_ideal(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_noteworthy) || var_3.script_noteworthy != "manpile_monitor_exempt") {
      if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3.origin, cos(level.manpile_monitor.working_fov)))
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  var_1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_1);

  foreach(var_3 in var_1) {
    if(getcorpsearray().size > level.manpile_monitor.ideal) {
      if(distancesquared(var_3.origin, level.player.origin) > level.manpile_monitor.safe_delete_distance * level.manpile_monitor.safe_delete_distance) {
        var_3 delete();
        manpile_monitor_print("Deleting a body to approach the ideal limit");
        continue;
      }

      break;
    }
  }
}

manpile_monitor_cull_fov(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3.origin, cos(level.manpile_monitor.fov))) {
      if(!isDefined(var_3.script_noteworthy) || var_3.script_noteworthy != "manpile_monitor_exempt")
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  var_5 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_1);

  if(var_5.size > level.manpile_monitor.maximum_in_fov) {
    foreach(var_3 in var_5) {
      if(!sighttracepassed(level.player getEye(), var_3.origin, 0, level.player)) {
        manpile_monitor_print("Too many corpses in FOV - Deleting one");
        var_3 delete();
        return;
      }
    }
  }
}

manpile_monitor_cull_weapons(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3.origin, cos(level.manpile_monitor.working_fov)))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  var_1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_1);

  while(getweaponarray().size > level.manpile_monitor.maximum_weapons) {
    if(var_1.size > 0) {
      var_1[0] delete();
      var_1 = scripts\engine\utility::array_removeundefined(var_1);
      manpile_monitor_print("Weapons over maximum limit!Deleting one");
      continue;
    }

    break;
  }
}

manpile_monitor_flush_all() {
  var_0 = getcorpsearray();

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = getweaponarray();

  foreach(var_6 in var_4)
  var_6 delete();
}

manpile_monitor_reset_fov() {
  level.manpile_monitor.working_fov = level.manpile_monitor.fov;
}

manpile_monitor_print(var_0) {
  if(level.manpile_monitor.verbose)
    iprintln(var_0);
}