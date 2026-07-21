/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_civs.gsc
**************************************************/

civ_init() {
  setdvarifuninitialized("scr_picc_civ_debug", 0);
  level thread civ_struct_spawner_init();
  level.civspawners = getspawnerarray("civilians");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("close_runner", ::close_runner_logic);
}

close_runner_logic() {
  self endon("death");
  self.team = "allies";
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  thread ignoreme_til_player_sees();
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
  wait 7;

  while(distance2dsquared(self.origin, level.player.origin) < squared(500))
    wait 1;

  while(scripts\anim\utility_common.gsc::player_can_see_ai(level.player, self))
    wait 1;

  self delete();
}

trgger_kill_civ_structs() {
  self waittill("trigger");

  foreach(var_1 in level.piccadilly.civ_struct_spawners[self.script_namenumber]) {
    var_1 notify("stop_spawning");
    level.piccadilly.civ_struct_spawners[self.script_namenumber] = scripts\engine\utility::array_remove(level.piccadilly.civ_struct_spawners[self.script_namenumber], var_1);
  }

  level.piccadilly.civ_struct_spawners = scripts\engine\utility::array_remove_key(level.piccadilly.civ_struct_spawners, self.script_namenumber);
}

civ_struct_spawner_init() {
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civ_struct_spawners))
    level.piccadilly.civ_struct_spawners = [];

  var_0 = scripts\engine\utility::getStructArray("civ_struct_spawner", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_namenumber)) {
      if(!isDefined(level.piccadilly.civ_struct_spawners[var_2.script_namenumber]))
        level.piccadilly.civ_struct_spawners[var_2.script_namenumber][0] = var_2;
      else
        level.piccadilly.civ_struct_spawners[var_2.script_namenumber][level.piccadilly.civ_struct_spawners[var_2.script_namenumber].size] = var_2;

      continue;
    }

    level.piccadilly.civ_struct_spawners[level.piccadilly.civ_struct_spawners.size] = var_2;
  }

  var_4 = getEntArray("kill_civ_struct_spawner", "script_noteworthy");
  scripts\engine\utility::array_thread(var_4, ::trgger_kill_civ_structs);
}

start_civ_struct_spawner(var_0, var_1) {
  if(!isDefined(level.piccadilly.civ_struct_spawners[var_0])) {
    return;
  }
  var_2 = level.piccadilly.civ_struct_spawners[var_0];

  if(var_2.size > 1)
    var_3 = scripts\engine\sp\utility::get_average_origin(var_2);
  else
    var_3 = var_2[0].origin;

  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_3);

  if(!isDefined(var_1))
    var_1 = 1;

  foreach(var_5 in var_2)
  var_5 thread civ_struct_spawner_internal(var_1, var_5.target);
}

civ_struct_spawner_internal(var_0, var_1) {
  self endon("stop_spawning");
  scripts\engine\utility::script_delay();

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(level.player scripts\engine\trace::can_see_origin(self.origin, 0)) {
      return;
    }
    var_3 = spawn_civ("random", undefined, 1);

    if(!isDefined(var_3)) {
      scripts\sp\maps\piccadilly\piccadilly_util.gsc::debug_print("STRUCT SPANWER: civ undefined, maybe ai count too high, " + getaicount());
      continue;
    }

    if(isDefined(self.targetname))
      var_3.targetname = self.targetname;

    var_4 = var_3.goalradius;
    var_3.goalradius = 32;

    if(isDefined(self.script_team))
      var_3.team = self.script_team;

    if(isDefined(self.script_threatbiasgroup))
      var_3 setthreatbiasgroup(self.script_threatbiasgroup);

    if(isDefined(self.script_attackeraccuracy))
      var_3.attackeraccuracy = self.script_attackeraccuracy;

    if(istrue(self.script_ignoreme))
      var_3.ignoreme = 1;

    var_3 scripts\asm\asm_bb::bb_setcivilianstate("panic");
    var_3 scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
    var_3 thread civ_struct_ai_go(var_1);

    if(istrue(self.script_wait)) {
      scripts\engine\utility::script_wait();
      continue;
    }

    wait(2 + randomfloat(2));
  }
}

civ_struct_ai_go(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    self.target = var_0;
    scripts\sp\spawner::go_to_node();
    level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 350);
  } else
    thread civ_think_run();
}

ignoreme_til_player_sees() {
  self endon("death");
  var_0 = cos(60);
  self.ignoreme = 1;
  var_1 = gettime() + 5000;

  while(gettime() < var_1) {
    if(distancesquared(self.origin, level.player.origin) <= 640000 && scripts\anim\utility_common.gsc::player_can_see_ai(level.player, self)) {
      break;
    }

    waitframe();
  }

  self.ignoreme = 0;
}

civ_think_run(var_0) {
  self endon("death");
  self.goalradius = 32;
  var_1 = undefined;

  for(;;) {
    if(isDefined(var_0))
      var_1 = getnode(var_0, "targetname");
    else {
      var_1 = get_best_civ_node();

      if(!isDefined(var_1)) {
        wait 0.05;
        continue;
      }
    }

    var_1.in_use = 1;

    if(isai(self)) {
      scripts\asm\asm_bb::bb_setcivilianstate("panic");
      scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
    }

    thread scripts\sp\spawner::go_to_node(var_1);
    wait 7;
    var_2 = 0;
    var_3 = 40;

    for(;;) {
      if(!scripts\anim\utility_common.gsc::player_can_see_ai(level.player, self))
        var_2++;
      else
        var_2 = 0;

      if(var_2 >= var_3) {
        var_1.in_use = 0;
        self delete();
        return;
      }

      waitframe();
    }
  }
}

release_node(var_0) {
  var_0.in_use = 0;
}

get_best_civ_node() {
  self endon("death");
  var_0 = getnodearray("civ_node", "script_noteworthy");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0 = scripts\engine\utility::array_reverse(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.in_use) && var_2.in_use)
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!level.player scripts\engine\trace::can_see_origin(var_2.origin + (0, 0, 50), 0))
        return var_2;
    }
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::debug_print("Using backup node, create more civ nodes!");
  return var_0[0];
}

spawn_civ(var_0, var_1, var_2) {
  if(!istrue(var_2)) {
    if(scripts\engine\utility::flag("stop_civ_spawns"))
      return;
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civilians))
    level.piccadilly.civilians = [];

  if(istrue(var_1)) {
    var_3 = get_picc_civ_spawner(var_0);
    var_3.scs_last_spawn_time = gettime();
    var_4 = var_3 spawndrone();
    var_4.spawner = var_3;
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_4 scripts\sp\utility::enable_procedural_bones();
  } else {
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::make_room_for_ai();

    switch (var_0) {
      case "female":
        var_5 = "actor_civilian_uk_cold_female";
        break;
      case "male":
        var_5 = "actor_civilian_uk_cold_male";
        break;
      default:
        var_5 = "actor_civilian_uk_cold";
        break;
    }

    var_4 = havemapentseffects(var_5, self.origin, self.angles, 1);

    if(!isDefined(var_4)) {
      scripts\sp\maps\piccadilly\piccadilly_util.gsc::debug_print("SPAWN CIV: civ undefined, maybe ai count too high, " + getaicount());
      return;
    }

    var_4 scripts\asm\asm_bb::bb_setcivilianstate("panic");
    level.piccadilly.civilians = scripts\engine\utility::array_add(level.piccadilly.civilians, var_4);
    var_4.script_friendname = "";
    var_4.name = var_4.script_friendname;
  }

  var_4 thread scripts\sp\maps\piccadilly\piccadilly.gsc::global_civ_spawn_func();
  var_4.animname = self.animname;
  return var_4;
}

get_picc_civ_spawner(var_0) {
  var_1 = get_safe_spawners("civilian");

  if(!isDefined(var_1))
    return undefined;

  var_2 = undefined;

  if(!isDefined(var_0))
    var_0 = "random";

  if(var_0 == "random")
    var_2 = var_1[randomint(var_1.size)];
  else {
    foreach(var_4 in var_1) {
      if(var_4.script_namenumber == var_0) {
        var_2 = var_4;
        break;
      }
    }
  }

  return var_2;
}

spawner_makerealai(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;

  if(isDefined(var_1))
    var_0.spawner.target = var_1;

  var_0.spawner.count = var_0.spawner.count + 1;
  var_5 = undefined;

  while(!isDefined(var_5)) {
    var_5 = var_0.spawner stalingradspawn();
    waitframe();
  }

  var_6 = scripts\common\ai::spawn_failed(var_5);

  if(var_6) {}

  var_5.vehicle_idling = var_0.vehicle_idling;
  var_5.vehicle_position = var_0.vehicle_position;
  var_5.standing = var_0.standing;
  var_5.forcecolor = var_0.forcecolor;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();

  if(var_5.asmname == "civilian")
    var_5.deathfunction = ::civ_deathfunction;

  return var_5;
}

civ_deathfunction() {
  thread scripts\engine\utility::play_sound_in_space("shield_death_enemy_" + randomintrange(1, 7), self.origin);
  refresh_piccadilly_civs_array();
  return 0;
}

refresh_piccadilly_civs_array() {
  var_0 = [];

  foreach(var_2 in level.piccadilly.civilians) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  level.piccadilly.civilians = var_0;
}

get_safe_spawners(var_0) {
  for(;;) {
    var_1 = level.civspawners;

    foreach(var_3 in var_1) {
      if(isDefined(var_3.scs_last_spawn_time) && var_3.scs_last_spawn_time == gettime())
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }

    if(var_1.size > 0)
      return var_1;
    else
      waitframe();
  }
}

civ_debug() {
  if(getdvarint("scr_picc_civ_debug") != 1) {
    return;
  }
  var_0 = newhudelem();
  var_0.x = 320;
  var_0.y = 50;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.sort = 1;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;
  var_0.alpha = 1;
  var_0.fontscale = 1;
  var_0.font = "objective";
  var_1 = newhudelem();
  var_1.x = 324;
  var_1.y = 40;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.sort = 1;
  var_1.foreground = 1;
  var_1.hidewheninmenu = 1;
  var_1.alpha = 1;
  var_1.fontscale = 1;
  var_1.font = "objective";
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_spawnStruct();

  if(!isDefined(level.piccadilly.civilians))
    level.piccadilly.civilians = [];

  for(;;) {
    var_1 settext("Axis: " + getaicount("axis"));
    var_0 settext("Civilians: " + level.piccadilly.civilians.size);
    waitframe();
  }
}