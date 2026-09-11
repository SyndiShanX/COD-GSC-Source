/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_manpile_monitor.gsc
***************************************************************/

function manpile_monitor() {
  manpile_monitor_initialize();

  for(;;) {
    manpile_monitor_core_loop();
    wait level.manpile_monitor.wait_time;
  }
}

function manpile_monitor_initialize() {
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

function manpile_monitor_core_loop() {
  if(level.manpile_monitor.disabled) {
    return;
  }

  var0 = getcorpsearray();
  var1 = getweaponarray();
  manpile_monitor_print("Corpses " + var0.size + ",Weapons " + var1.size);

  if(var0.size < level.manpile_monitor.ideal && var0.size < level.manpile_monitor.maximum_in_fov) {
    manpile_monitor_reset_fov();
    return;
  }

  if(getcorpsearray().size > level.manpile_monitor.maximum) {
    manpile_monitor_cull_urgent(getcorpsearray());

    if(var0.size <= level.manpile_monitor.maximum) {
      return;
    }

    wait level.manpile_monitor.wait_time / 2;
  }

  var0 = getcorpsearray();

  if(var0.size > level.manpile_monitor.ideal) {
    manpile_monitor_cull_ideal(var0);

    if(var0.size <= level.manpile_monitor.ideal) {
      return;
    }

    wait level.manpile_monitor.wait_time / 2;
  }

  var0 = getcorpsearray();

  if(var1.size > level.manpile_monitor.maximum_weapons) {
    manpile_monitor_cull_weapons(var1);

    if(var1.size <= level.manpile_monitor.maximum_weapons) {
      return;
    }

    wait level.manpile_monitor.wait_time / 2;
  }

  var0 = getcorpsearray();

  if(var0.size > level.manpile_monitor.maximum_in_fov) {
    manpile_monitor_cull_fov(var0);
    wait level.manpile_monitor.wait_time / 2;
  }

  var0 = getcorpsearray();

  if(var0.size > level.manpile_monitor.maximum) {
    manpile_monitor_print("FOV too high for culling - turning it down to " + level.manpile_monitor.working_fov * 0.9);
    level.manpile_monitor.working_fov *= 0.9;
    return;
  }

  manpile_monitor_reset_fov();
}

function manpile_monitor_cull_urgent(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3.script_noteworthy) || var3.script_noteworthy != "manpile_monitor_exempt") {
      if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3.origin, cos(level.manpile_monitor.working_fov))) {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    }
  }

  var1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var1);

  while(getcorpsearray().size > level.manpile_monitor.maximum) {
    if(var1.size > 0) {
      var1[0] delete();
      var1 = scripts\engine\utility::array_removeundefined(var1);
      manpile_monitor_print("Bodies over maximum limit!Deleting one");
      continue;
    }

    break;
  }

  if(getcorpsearray().size > level.manpile_monitor.maximum) {
    manpile_monitor_cull_fov(var1);
    return;
  }
}

function manpile_monitor_cull_ideal(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3.script_noteworthy) || var3.script_noteworthy != "manpile_monitor_exempt") {
      if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3.origin, cos(level.manpile_monitor.working_fov))) {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    }
  }

  var1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var1);

  foreach(var3 in var1) {
    if(getcorpsearray().size > level.manpile_monitor.ideal) {
      if(distancesquared(var3.origin, level.player.origin) > level.manpile_monitor.safe_delete_distance * level.manpile_monitor.safe_delete_distance) {
        var3 delete();
        manpile_monitor_print("Deleting a body to approach the ideal limit");
        continue;
      }

      break;
    }
  }
}

function manpile_monitor_cull_fov(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3.origin, cos(level.manpile_monitor.fov))) {
      if(!isDefined(var3.script_noteworthy) || var3.script_noteworthy != "manpile_monitor_exempt") {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    }
  }

  var5 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var1);

  if(var5.size > level.manpile_monitor.maximum_in_fov) {
    foreach(var3 in var5) {
      if(!sighttracepassed(level.player getEye(), var3.origin, 0, level.player)) {
        manpile_monitor_print("Too many corpses in FOV - Deleting one");
        var3 delete();
        return;
      }
    }

    return;
  }
}

function manpile_monitor_cull_weapons(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      continue;
    }

    if(!level.player scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3.origin, cos(level.manpile_monitor.working_fov))) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  var1 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var1);

  while(getweaponarray().size > level.manpile_monitor.maximum_weapons) {
    if(var1.size > 0) {
      var1[0] delete();
      var1 = scripts\engine\utility::array_removeundefined(var1);
      manpile_monitor_print("Weapons over maximum limit!Deleting one");
      continue;
    }

    break;
  }
}

function manpile_monitor_flush_all() {
  var0 = getcorpsearray();

  foreach(var2 in var0) {
    var2 delete();
  }

  var4 = getweaponarray();

  foreach(var6 in var4) {
    var6 delete();
  }
}

function manpile_monitor_reset_fov() {
  level.manpile_monitor.working_fov = level.manpile_monitor.fov;
}

function manpile_monitor_print(var0) {
  if(level.manpile_monitor.verbose) {
    iprintln(var0);
    return;
  }
}