/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_civs.gsc
**********************************************************/

function civ_init() {
  setdvarifuninitialized("scr_picc_civ_debug", 0);
  thread civ_struct_spawner_init();
  level.civspawners = getspawnerarray("civilians");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("close_runner", &close_runner_logic);
}

function close_runner_logic() {
  self endon("death");
  self.team = "allies";
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  thread ignoreme_til_player_sees();
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
  wait 7;

  while(distance2dsquared(self.origin, level.player.origin) < squared(500)) {
    wait 1;
  }

  while(scripts\anim\utility_common::player_can_see_ai(level.player, self)) {
    wait 1;
  }

  self delete();
}

function trgger_kill_civ_structs() {
  self waittill("trigger");

  foreach(var1 in level.piccadilly.civ_struct_spawners[self.script_namenumber]) {
    var1 notify("stop_spawning");
    level.piccadilly.civ_struct_spawners[self.script_namenumber] = scripts\engine\utility::array_remove(level.piccadilly.civ_struct_spawners[self.script_namenumber], var1);
  }

  level.piccadilly.civ_struct_spawners = scripts\engine\utility::array_remove_key(level.piccadilly.civ_struct_spawners, self.script_namenumber);
}

function civ_struct_spawner_init() {
  scripts\sp\maps\piccadilly\piccadilly_util::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civ_struct_spawners)) {
    level.piccadilly.civ_struct_spawners = [];
  }

  var0 = scripts\engine\utility::getStructArray("civ_struct_spawner", "script_noteworthy");

  foreach(var2 in var0) {
    if(isDefined(var2.script_namenumber)) {
      if(!isDefined(level.piccadilly.civ_struct_spawners[var2.script_namenumber])) {
        level.piccadilly.civ_struct_spawners[var2.script_namenumber][0] = var2;
      } else {
        level.piccadilly.civ_struct_spawners[var2.script_namenumber][level.piccadilly.civ_struct_spawners[var2.script_namenumber].size] = var2;
      }

      continue;
    }

    level.piccadilly.civ_struct_spawners[level.piccadilly.civ_struct_spawners.size] = var2;
  }

  var4 = getEntArray("kill_civ_struct_spawner", "script_noteworthy");
  scripts\engine\utility::array_thread(var4, &trgger_kill_civ_structs);
}

function start_civ_struct_spawner(var0, var1) {
  if(!isDefined(level.piccadilly.civ_struct_spawners[var0])) {
    return;
  }

  var2 = level.piccadilly.civ_struct_spawners[var0];

  if(var2.size > 1) {
    var3 = scripts\engine\sp\utility::get_average_origin(var2);
  } else {
    var3 = var3[0].origin;
  }

  thread scripts\sp\maps\piccadilly\piccadilly_util::crowd_screams(var3);

  if(!isDefined(var2)) {
    var2 = 1;
  }

  foreach(var5 in var3) {
    thread civ_struct_spawner_internal(var5, var2);
  }
}

function civ_struct_spawner_internal(var0, var1) {
  self endon("stop_spawning");
  scripts\engine\utility::script_delay();

  for(var2 = 0; var2 < var0; var2++) {
    if(level.player scripts\engine\trace::can_see_origin(self.origin, 0)) {
      return;
    }

    var3 = spawn_civ("random", undefined, 1);

    if(!isDefined(var3)) {
      scripts\sp\maps\piccadilly\piccadilly_util::debug_print("STRUCT SPANWER: civ undefined, maybe ai count too high, " + getaicount());
      continue;
    }

    if(isDefined(self.targetname)) {
      var3.targetname = self.targetname;
    }

    var4 = var3.goalradius;
    var3.goalradius = 32;

    if(isDefined(self.script_team)) {
      var3.team = self.script_team;
    }

    if(isDefined(self.script_threatbiasgroup)) {
      var3 setthreatbiasgroup(self.script_threatbiasgroup);
    }

    if(isDefined(self.script_attackeraccuracy)) {
      var3.attackeraccuracy = self.script_attackeraccuracy;
    }

    if(istrue(self.script_ignoreme)) {
      var3.ignoreme = 1;
    }

    var3 scripts\asm\asm_bb::bb_setcivilianstate("panic");
    var3 scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
    thread civ_struct_ai_go(var3);

    if(istrue(self.script_wait)) {
      scripts\engine\utility::script_wait();
      continue;
    }

    wait 2 + randomfloat(2);
  }
}

function civ_struct_ai_go(var0) {
  self endon("death");

  if(isDefined(var0)) {
    self.target = var0;
    scripts\sp\spawner::go_to_node();
    level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 350);
    return;
  }

  thread civ_think_run();
}

function ignoreme_til_player_sees() {
  self endon("death");
  var0 = cos(60);
  self.ignoreme = 1;
  var1 = gettime() + 5000;

  while(gettime() < var1) {
    if(distancesquared(self.origin, level.player.origin) <= 640000 && scripts\anim\utility_common::player_can_see_ai(level.player, self)) {
      break;
    }

    waitframe();
  }

  self.ignoreme = 0;
}

function civ_think_run(var0) {
  self endon("death");
  self.goalradius = 32;
  var1 = undefined;

  for(;;) {
    if(isDefined(var0)) {
      var1 = getnode(var0, "targetname");
    } else {
      var1 = get_best_civ_node();

      if(!isDefined(var1)) {
        wait 0.05;
        continue;
      }
    }

    var1.in_use = 1;

    if(isai(self)) {
      scripts\asm\asm_bb::bb_setcivilianstate("panic");
      scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
    }

    thread scripts\sp\spawner::go_to_node(var1);
    wait 7;
    var2 = 0;
    var3 = 40;

    for(;;) {
      if(!scripts\anim\utility_common::player_can_see_ai(level.player, self)) {
        var2++;
      } else {
        var2 = 0;
      }

      if(var2 >= var3) {
        var1.in_use = 0;
        self delete();
        return;
      }

      waitframe();
    }
  }
}

function release_node(var0) {
  var0.in_use = 0;
}

function get_best_civ_node() {
  self endon("death");
  var0 = getnodearray("civ_node", "script_noteworthy");
  var0 = sortbydistance(var0, level.player.origin);
  var0 = scripts\engine\utility::array_reverse(var0);

  foreach(var2 in var0) {
    if(isDefined(var2.in_use) && var2.in_use) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  if(var0.size > 0) {
    foreach(var2 in var0) {
      if(!level.player scripts\engine\trace::can_see_origin(var2.origin + (0, 0, 50), 0)) {
        return var2;
      }
    }
  }

  scripts\sp\maps\piccadilly\piccadilly_util::debug_print("Using backup node, create more civ nodes!");
  return var0[0];
}

function spawn_civ(var0, var1, var2) {
  if(!istrue(var2)) {
    if(scripts\engine\utility::flag("stop_civ_spawns")) {
      return;
    }
  }

  scripts\sp\maps\piccadilly\piccadilly_util::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civilians)) {
    level.piccadilly.civilians = [];
  }

  if(istrue(var1)) {
    var3 = get_picc_civ_spawner(var0);
    var3.scs_last_spawn_time = gettime();
    var4 = var3 spawndrone();
    var4.spawner = var3;
    var4.origin = self.origin;
    var4.angles = self.angles;
    var4 scripts\sp\utility::enable_procedural_bones();
  } else {
    scripts\sp\maps\piccadilly\piccadilly_util::make_room_for_ai();

    switch (var1) {
      case "female":
        var5 = "actor_civilian_uk_cold_female";
        break;
      case "male":
        var5 = "actor_civilian_uk_cold_male";
        break;
      default:
        var5 = "actor_civilian_uk_cold";
        break;
    }

    var4 = havemapentseffects(var5, self.origin, self.angles, 1);

    if(!isDefined(var4)) {
      scripts\sp\maps\piccadilly\piccadilly_util::debug_print("SPAWN CIV: civ undefined, maybe ai count too high, " + getaicount());
      return;
    }

    var4 scripts\asm\asm_bb::bb_setcivilianstate("panic");
    level.piccadilly.civilians = scripts\engine\utility::array_add(level.piccadilly.civilians, var4);
    var4.script_friendname = "";
    var4.name = var4.script_friendname;
  }

  var4 thread scripts\sp\maps\piccadilly\piccadilly::global_civ_spawn_func();
  var4.animname = self.animname;
  return var4;
}

function get_picc_civ_spawner(var0) {
  var1 = get_safe_spawners("civilian");

  if(!isDefined(var1)) {
    return undefined;
  }

  var2 = undefined;

  if(!isDefined(var0)) {
    var0 = "random";
  }

  if(var0 == "random") {
    var2 = var1[randomint(var1.size)];
  } else {
    foreach(var4 in var1) {
      if(var4.script_namenumber == var0) {
        var2 = var4;
        break;
      }
    }
  }

  return var2;
}

function spawner_makerealai(var0, var1) {
  var0 endon("death");

  if(isDefined(var0.spawner)) {}

  var2 = var0.spawner.origin;
  var3 = var0.spawner.angles;
  var4 = var0.spawner.target;
  var0.spawner.origin = var0.origin;
  var0.spawner.angles = var0.angles;

  if(isDefined(var1)) {
    var0.spawner.target = var1;
  }

  var0.spawner.count += 1;
  var5 = undefined;

  while(!isDefined(var5)) {
    var5 = var0.spawner stalingradspawn();
    waitframe();
  }

  var6 = scripts\common\ai::spawn_failed(var5);

  if(var6) {}

  var5.vehicle_idling = var0.vehicle_idling;
  var5.vehicle_position = var0.vehicle_position;
  var5.standing = var0.standing;
  var5.forcecolor = var0.forcecolor;
  var0.spawner.origin = var2;
  var0.spawner.angles = var3;
  var0.spawner.target = var4;
  var0 delete();

  if(var5.asmname == "civilian") {
    var5.deathfunction = &civ_deathfunction;
  }

  return var5;
}

function civ_deathfunction() {
  thread scripts\engine\utility::play_sound_in_space("shield_death_enemy_" + randomintrange(1, 7), self.origin);
  refresh_piccadilly_civs_array();
  return false;
}

function refresh_piccadilly_civs_array() {
  var0 = [];

  foreach(var2 in level.piccadilly.civilians) {
    if(!isDefined(var2)) {
      continue;
    }

    if(!isalive(var2)) {
      continue;
    }

    var0 = var2;
  }

  level.piccadilly.civilians = var0;
}

function get_safe_spawners(var0) {
  for(;;) {
    var1 = level.civspawners;

    foreach(var3 in var1) {
      if(isDefined(var3.scs_last_spawn_time) && var3.scs_last_spawn_time == gettime()) {
        var1 = scripts\engine\utility::array_remove(var1, var3);
      }
    }

    if(var1.size > 0) {
      return var1;
    }

    waitframe();
  }
}

function civ_debug() {
  if(getdvarint("scr_picc_civ_debug") != 1) {
    return;
  }

  var0 = newhudelem();
  var0.x = 320;
  var0.y = 50;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.sort = 1;
  var0.foreground = 1;
  var0.hidewheninmenu = 1;
  var0.alpha = 1;
  var0.fontscale = 1;
  var0.font = "objective";
  var1 = newhudelem();
  var1.x = 324;
  var1.y = 40;
  var1.alignx = "center";
  var1.aligny = "middle";
  var1.sort = 1;
  var1.foreground = 1;
  var1.hidewheninmenu = 1;
  var1.alpha = 1;
  var1.fontscale = 1;
  var1.font = "objective";
  scripts\sp\maps\piccadilly\piccadilly_util::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civilians)) {
    level.piccadilly.civilians = [];
  }

  for(;;) {
    var1 settext("Axis: " + getaicount("axis"));
    var0 settext("Civilians: " + level.piccadilly.civilians.size);
    waitframe();
  }
}