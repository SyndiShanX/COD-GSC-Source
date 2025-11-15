/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_rv_vfx.gsc
*****************************************************/

init() {
  level thread init_fx_triggers();
  level thread global_breakables_think();
  level thread func_glass_handler();
  level thread impact_override();
}

set_fungglass_life(var_0, var_1) {
  setsaveddvar("glass_damageToWeaken", var_0);
  setsaveddvar("glass_damageToDestroy", var_1);
}

global_breakables_think() {
  var_0 = getEntArray("vfx_breakable", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters)) {
      if(issubstr(var_3.script_parameters, ".efx") || issubstr(var_3.script_parameters, ".EFX") || issubstr(var_3.script_parameters, "fx/"))
        var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in var_1) {
    if(isDefined(var_6.groupname) && isDefined(var_6.script_spawn_pool)) {
      var_7 = strtok(var_6.groupname, "|");

      foreach(var_9 in var_7) {
        if(var_9 != "NO_MODEL" && var_9 != "no_model")
          precachemodel(var_9);
      }

      var_11 = strtok(var_6.script_parameters, "|");
      var_12 = [];
      var_13 = strtok(var_6.script_spawn_pool, "|");

      foreach(var_15 in var_11) {
        var_16 = strtok(var_15, ".")[0];
        level._effect[var_16] = loadfx(var_16);
        var_12[var_12.size] = var_16;
      }

      var_6 thread global_breakable_wait(var_7, var_12, var_13, int(var_13[0]));
    }
  }
}

global_breakable_target_damage_wait() {
  var_0 = self.origin;
  self endon("delete");

  while(isDefined(self)) {
    var_1 = self.target;
    self waittill("damage", var_2);
    var_3 = getEntArray(var_1, "targetname");

    foreach(var_5 in var_3) {
      if(isDefined(var_5))
        var_5 dodamage(var_2, var_0);
    }
  }
}

global_breakable_wait(var_0, var_1, var_2, var_3) {
  var_4 = self.origin;

  if(isDefined(self.target))
    thread global_breakable_target_damage_wait();

  self.health = var_3;
  self setCanDamage(1);
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  var_5 = 0;
  var_6 = var_3;
  var_7 = 0;

  foreach(var_9 in var_2) {
    var_10 = int(var_9);
    var_7 = var_7 + var_10;
  }

  var_12 = self.health * -1 + var_3;
  var_13 = "";
  var_14 = undefined;

  if(isDefined(self.targetname) && self.targetname != "")
    var_13 = self.targetname;

  if(isDefined(self.target))
    var_14 = self.target;

  var_5 = -1;

  if(self.health != 0) {
    foreach(var_9 in var_2) {
      var_10 = int(var_9);

      if(var_12 > var_10) {
        var_12 = var_12 - var_10;
        var_5++;
        continue;
      }

      var_6 = var_10 - var_12;
      break;
    }
  }

  if(var_5 < 0)
    var_5 = 0;

  if(var_5 > var_0.size - 1)
    var_5 = var_0.size - 1;

  var_17 = (0, 0, 0);

  if(isDefined(self.origin))
    var_17 = self.origin;

  var_18 = (0, 0, 0);

  if(isDefined(self.angles))
    var_18 = self.angles;

  var_19 = undefined;

  if(isDefined(self.script_group) && self.script_group != 0)
    var_19 = self.script_group;

  playFX(level._effect[var_1[var_5]], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  self delete();

  if(var_0[var_5] != "NO_MODEL" && var_0[var_5] != "no_model") {
    var_20 = spawn("script_model", (0, 0, 0));
    var_20.origin = var_17;
    var_20.angles = var_18;
    var_20.targetname = var_13;
    var_20.target = var_14;
    var_20.script_group = var_19;
    var_20 setModel(var_0[var_5]);

    if(var_0.size > var_5 + 1) {
      for(var_21 = 0; var_21 < var_5 + 1; var_21++) {
        var_0 = maps\_utility::array_remove_index(var_0, 0);
        var_1 = maps\_utility::array_remove_index(var_1, 0);
        var_2 = maps\_utility::array_remove_index(var_2, 0);
      }

      var_22 = var_6;

      if(var_22 <= 0)
        var_22 = 1;

      var_20.health = var_22;
      var_20 thread global_breakable_wait(var_0, var_1, var_2, var_20.health);
      return;
    }

    if(isDefined(var_19)) {
      radiusdamage(var_20.origin, var_19, int(var_2[0]) * 2, int(var_2[0]) / 2);
      return;
    }

    return;
  } else {}
}

global_fx_array_to_string(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];

    if(var_2 != var_0.size - 1)
      var_1 = var_1 + "|";
  }

  return var_1;
}

init_fx_triggers() {
  var_0 = getEntArray("fx_trigger", "targetname");
  common_scripts\utility::array_thread(var_0, ::handle_exploder_trigger);
}

handle_exploder_trigger() {
  if(!common_scripts\utility::flag_exist(self.script_flag))
    common_scripts\utility::flag_init(self.script_flag);

  var_0 = strtok(self.script_flag, "_");
  var_1 = var_0[1];

  if(var_0.size == 2) {
    for(;;) {
      common_scripts\utility::flag_wait(self.script_flag);
      common_scripts\_exploder::activate_exploder(var_1);
      common_scripts\utility::flag_waitopen(self.script_flag);
      maps\_utility::stop_exploder(var_1);
    }
  }
}

func_glass_handler() {
  var_0 = [];
  var_1 = [];
  var_2 = getEntArray("vfx_custom_glass", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = getglass(var_4.script_noteworthy);

      if(isDefined(var_5)) {
        var_1[var_5] = var_4;
        var_0[var_0.size] = var_5;
      }
    }
  }

  var_7 = var_0.size;
  var_8 = var_0.size;
  var_9 = 5;
  var_10 = 0;

  while(var_7 != 0) {
    var_11 = var_10 + var_9 - 1;

    if(var_11 > var_8)
      var_11 = var_8;

    if(var_10 == var_8)
      var_10 = 0;

    while(var_10 < var_11) {
      var_12 = var_0[var_10];
      var_4 = var_1[var_12];

      if(isDefined(var_4)) {
        if(isglassdestroyed(var_12)) {
          var_4 delete();
          var_7--;
          var_1[var_12] = undefined;
        }
      }

      var_10++;
    }

    wait 0.05;
  }
}

impact_override() {
  var_0 = getEntArray("vfx_impact_override", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters)) {
      if(issubstr(var_3.script_parameters, ".efx") || issubstr(var_3.script_parameters, ".EFX") || issubstr(var_3.script_parameters, "fx/")) {
        var_4 = strtok(var_3.script_parameters, ".")[0];
        level._effect[var_4] = loadfx(var_4);
        var_3.script_parameters = var_4;
        var_3 thread impact_override_object_damage_check();
      }
    }
  }
}

impact_override_object_damage_check() {
  self setCanDamage(1);
  self.health = 1000;
  self endon("delete");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = undefined; isDefined(self); self.health = 1000) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "bullet":
      case "mod_projectile":
        var_5 = self.script_parameters;
        playFX(level._effect[var_5], var_3, anglesToForward(vectortoangles(var_2)), anglestoup(vectortoangles(var_2)));
    }
  }
}