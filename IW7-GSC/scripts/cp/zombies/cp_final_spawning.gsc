/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_final_spawning.gsc
****************************************************/

cp_final_spawning_init() {
  level.zombie_karatemaster_vo_prefix = "zmb_vo_karate_male_";
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["karatemaster"] = ::calculatekaratemasterhealth;
  level._effect["final_goon_spawn_bolt"] = loadfx("vfx\iw7\levels\cp_final\alien\vfx_alien_spawn_sm.vfx");
  level._effect["final_phantom_spawn_bolt"] = loadfx("vfx\iw7\levels\cp_final\alien\vfx_alien_spawn_lrg.vfx");
  level thread delayed_zmb_adjust();
  level thread no_shamblers();
  level thread turn_on_flood_room_trigger();
}

no_shamblers() {
  level endon("game_ended");
  for(;;) {
    level waittill("agent_spawned", var_0);
    if(var_0.agent_type == "generic_zombie") {
      var_0 thread delayed_set_move_mode();
    }
  }
}

turn_on_flood_room_trigger() {
  var_0 = getent("flood_room_tunnel_trigger", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isPlayer(var_1)) {
      break;
    }
  }

  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("flood_room");
}

delayed_set_move_mode() {
  self endon("death");
  wait(1);
  if(self.synctransients == "slow_walk") {
    self.synctransients = "walk";
  }
}

delayed_zmb_adjust() {
  wait(10);
  level.wait_for_music_clown_wave = 1;
}

km_spawn_event_func() {
  if(level.wave_num > 0 && !scripts\engine\utility::flag("power_on")) {
    update_special_round_counter();
  }

  level.zombie_killed_loot_func = ::func_5CF7;
  level.static_enemy_types = func_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = func_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  if(isDefined(level.specialwavescompleted)) {
    level.specialwavescompleted++;
  }

  var_0 = "karatemaster";
  func_1071B(var_0);
}

start_goon_spawn_event_func() {
  if(level.wave_num > 0 && !scripts\engine\utility::flag("power_on")) {
    update_special_round_counter();
  }

  level.zombie_killed_loot_func = ::func_5CF7;
  level.static_enemy_types = func_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = func_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  if(level.wave_num >= 8) {
    var_0 = "alien_phantom";
    var_1 = scripts\engine\utility::random(level.players);
    var_2 = getrandomnavpoint(var_1.origin, 256);
    var_3 = spawnStruct();
    if(isDefined(var_2)) {
      var_3.origin = var_2;
    } else {
      var_3.origin = getclosestpointonnavmesh(var_1.origin);
    }

    var_3.angles = anglesToForward(var_1.origin - var_3.origin);
    var_4 = var_3 spawn_brute_wave_enemy(var_0);
  }

  var_0 = "alien_goon";
  func_1071B(var_0);
}

goon_spawn_event_func() {
  if(level.wave_num > 0 && !scripts\engine\utility::flag("power_on")) {
    update_special_round_counter();
  }

  level.zombie_killed_loot_func = ::func_5CF7;
  level.static_enemy_types = func_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = func_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  var_0 = "alien_goon";
  func_1071B(var_0);
}

func_8455() {
  var_0 = level.players.size;
  var_1 = var_0 * 3;
  var_2 = 1;
  if(!scripts\engine\utility::flag("power_on")) {
    return starting_goon_spawn_total_spawns();
  }

  switch (level.specialroundcounter) {
    case 0:
      var_1 = var_0 * 6;
      break;

    case 1:
      var_1 = var_0 * 9;
      break;

    case 2:
      var_1 = var_0 * 12;
      break;

    case 3:
      var_1 = var_0 * 16;
      break;

    default:
      var_1 = var_0 * 16;
      break;
  }

  var_1 = var_1 * var_2;
  return var_1;
}

starting_goon_spawn_total_spawns() {
  var_0 = level.players.size;
  var_1 = var_0 * 3;
  var_2 = 1;
  switch (level.wave_num) {
    case 0:
      var_1 = var_0 * 6;
      break;

    case 1:
      var_1 = var_0 * 9;
      break;

    case 2:
      var_1 = var_0 * 12;
      break;

    case 3:
      var_1 = var_0 * 16;
      break;

    default:
      var_1 = int(max(1, level.specialroundcounter) * var_0 * 16);
      break;
  }

  var_1 = var_1 * var_2;
  return var_1;
}

func_1071B(var_0) {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  level.respawning_enemies = 0;
  level.num_goons_spawned = 0;
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  var_1 = 0;
  if(level.wave_num == 1) {
    wait(10);
  }

  if(soundexists("mus_zombies_newwave") && level.wave_num > 0) {
    level thread scripts\cp\zombies\zombies_spawning::func_BDD4();
  }

  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    while(scripts\engine\utility::istrue(level.zombies_paused) || scripts\engine\utility::istrue(level.nuke_zombies_paused)) {
      scripts\engine\utility::waitframe();
    }

    var_2 = num_goons_to_spawn();
    var_3 = get_spawner_and_spawn_goons(var_2, var_0);
    var_1 = var_1 + var_3;
    if(var_3 > 0) {
      wait(func_8454(var_1, level.desired_enemy_deaths_this_wave));
      continue;
    }

    wait(0.1);
  }

  if(soundexists("mus_zombies_endwave") && level.wave_num > 0) {
    level thread scripts\cp\zombies\zombies_spawning::func_BDD1();
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

func_5CF7(var_0, var_1, var_2) {
  if(isDefined(level.force_drop_loot_item)) {
    if(level scripts\cp\loot::drop_loot(var_1, var_2, level.force_drop_loot_item, undefined, undefined, 1)) {
      level.force_drop_loot_item = undefined;
      return 1;
    }
  }

  if(level.wave_num > 0 && !scripts\engine\utility::flag("power_on")) {
    return 0;
  }

  if(level.spawn_event_running == 1) {
    if(level.desired_enemy_deaths_this_wave == level.current_enemy_deaths && level.wave_num > 1) {
      level thread scripts\cp\loot::drop_loot(var_1, var_2, "ammo_max", undefined, undefined, 1);
      return 1;
    }

    return 0;
  }

  return 0;
}

func_79EB() {
  return ["alien_goon"];
}

func_8454(var_0, var_1) {
  var_2 = 1.5;
  var_3 = level.players.size;
  if(var_3 == 1) {
    if(scripts\engine\utility::flag_exist("power_on") && !scripts\engine\utility::flag("power_on")) {
      switch (level.specialroundcounter) {
        case 0:
          var_2 = 4;
          break;

        case 1:
          var_2 = 3;
          break;

        case 2:
          var_2 = 2.5;
          break;

        case 3:
          var_2 = 2;
          break;

        default:
          var_2 = 2;
          break;
      }
    } else {
      switch (level.specialroundcounter) {
        case 0:
          var_2 = 4;
          break;

        case 1:
          var_2 = 3;
          break;

        case 2:
          var_2 = 2.5;
          break;

        case 3:
          var_2 = 2;
          break;

        default:
          var_2 = 2;
          break;
      }
    }
  } else if(scripts\engine\utility::flag_exist("power_on") && !scripts\engine\utility::flag("power_on")) {
    switch (level.specialroundcounter) {
      case 0:
        var_2 = 2;
        break;

      case 1:
        var_2 = 1.5;
        break;

      case 2:
        var_2 = 1.25;
        break;

      case 3:
        var_2 = 1;
        break;

      default:
        var_2 = 0.5;
        break;
    }
  } else {
    switch (level.specialroundcounter) {
      case 0:
        var_2 = 3;
        break;

      case 1:
        var_2 = 2;
        break;

      case 2:
        var_2 = 1.5;
        break;

      case 3:
        var_2 = 1;
        break;

      default:
        var_2 = 1;
        break;
    }
  }

  var_2 = var_2 - var_0 / var_1;
  var_2 = max(var_2, 0.05);
  return var_2;
}

choose_agent_type_and_spawn(var_0, var_1) {
  var_2 = "alien_goon";
  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(isDefined(level.respawn_data)) {
    var_2 = level.respawn_data.type;
  }

  if(scripts\engine\utility::flag("power_on")) {
    if(!scripts\engine\utility::istrue(level.used_portal)) {
      var_2 = "alien_goon";
    } else {
      var_2 = scripts\engine\utility::random(["alien_goon", "zombie_clown", "karatemaster"]);
    }
  }

  if(isDefined(level.event_wave_override)) {
    var_2 = level.event_wave_override;
  }

  var_3 = get_spawner_and_spawn_goons(var_0, var_2);
  return var_3;
}

get_spawner_and_spawn_goons(var_0, var_1, var_2) {
  var_3 = 0;
  if(var_0 <= 0) {
    if(var_0 < 0) {
      scripts\cp\zombies\zombies_spawning::func_A5FA(abs(var_0));
    }

    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == var_1) {
      var_0 = 1;
    }
  }

  if(isDefined(var_2)) {
    var_4 = min(var_0, var_2);
  } else {
    var_4 = min(var_1, 1);
  }

  var_4 = spawn_goons_from_eggs(var_4, var_1);
  return var_4;
}

spawn_goons_from_eggs(var_0, var_1) {
  var_2 = 0.3;
  var_3 = 0.7;
  var_4 = 0;
  if(var_0 > 0) {
    var_5 = [];
    var_4 = 0;
    while(var_4 < var_0) {
      var_6 = get_scored_goon_spawn_location();
      var_6.in_use = 1;
      var_6.lastspawntime = gettime();
      var_7 = func_10719(var_6, var_1);
      if(isDefined(var_7)) {
        var_4++;
        wait(randomfloatrange(var_2, var_3));
        continue;
      }

      scripts\engine\utility::waitframe();
      var_6.in_use = 0;
    }
  }

  return var_4;
}

func_1B99(var_0) {
  var_1 = level._effect["final_goon_spawn_bolt"];
  playFX(var_1, var_0.origin);
  playFX(level._effect["drone_ground_spawn"], var_0.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", var_0.origin);
  earthquake(0.3, 0.2, var_0.origin, 500);
}

move_to_spot(var_0) {
  var_1 = getclosestpointonnavmesh(var_0.origin);
  self dontinterpolate();
  self setorigin(var_0.origin, 1);
  self ghostskulls_complete_status(var_0.origin);
  self.precacheleaderboards = 0;
}

func_10719(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = var_1;
  func_1B99(var_0);
  var_5 = goon_spawn_func(var_4, var_2, var_3, "axis");
  if(isDefined(var_5)) {
    var_5 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_4);
    update_respawn_data(var_4);
    var_0.lastspawntime = gettime();
  }

  return var_5;
}

goon_spawn_func(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\mp_agent::spawnnewagent(var_0, var_3, var_1, var_2, undefined, var_4);
  if(!isDefined(var_5)) {
    return undefined;
  }

  if(isDefined(var_5.spawner)) {
    var_5.entered_playspace = 1;
  }

  var_5 ghostskulls_total_waves(var_5.defaultgoalradius);
  var_5.maxhealth = func_3712(var_0);
  var_5.health = var_5.maxhealth;
  if(var_5.agent_type != "alien_goon" && var_5.agent_type != "alien_phantom") {
    if(var_0 == "karatemaster" && isDefined(level.zombie_karatemaster_vo_prefix)) {
      var_5.voprefix = level.zombie_karatemaster_vo_prefix;
      var_5 thread scripts\cp\zombies\zombies_vo::func_13F10();
    } else if(var_0 == "zombie_clown") {
      var_5.voprefix = level.var_13F18;
      var_5 thread scripts\cp\zombies\zombies_vo::func_13F10();
    }
  }

  if(var_0 == "alien_goon" || var_0 == "alien_phantom") {
    var_5 thread scripts\cp\zombies\zombies_spawning::setemissive();
  }

  return var_5;
}

update_respawn_data(var_0) {
  if(isDefined(level.respawn_data)) {
    var_1 = -1;
    for(var_2 = 0; var_2 < level.respawn_enemy_list.size; var_2++) {
      if(level.respawn_enemy_list[var_2].id == level.respawn_data.id && level.respawn_data.type == var_0) {
        var_1 = var_2;
        break;
      }
    }

    if(var_1 > -1) {
      if(isDefined(level.respawn_data.health)) {
        self.health = level.respawn_data.health;
      }

      level.respawn_enemy_list = scripts\cp\utility::array_remove_index(level.respawn_enemy_list, var_1);
    }

    level.respawn_data = undefined;
  }
}

num_goons_to_spawn() {
  var_0 = scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn();
  return var_0;
}

get_scored_goon_spawn_location() {
  var_0 = undefined;
  var_0 = func_79EC();
  return var_0;
}

func_79EC() {
  var_0 = [];
  foreach(var_2 in level.var_162C) {
    if(scripts\engine\utility::istrue(var_2.var_19) && !scripts\engine\utility::istrue(var_2.in_use)) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size > 0) {
    var_2 = func_8456(var_0);
    if(isDefined(var_2)) {
      return var_2;
    }
  }

  return scripts\engine\utility::random(var_0);
}

func_8456(var_0) {
  var_1 = [];
  var_2 = 1;
  var_3 = 1;
  var_4 = 10000;
  foreach(var_6 in var_0) {
    if(scripts\cp\zombies\func_0D60::allowedstances(var_6.volume)) {
      var_1[var_1.size] = var_6;
      var_6.modifiedspawnpoints = var_2;
      continue;
    }

    if(isDefined(var_6.volume.var_186E)) {
      foreach(var_8 in var_6.volume.var_186E) {
        if(scripts\cp\zombies\func_0D60::allowedstances(var_8)) {
          var_1[var_1.size] = var_6;
          var_6.modifiedspawnpoints = var_3;
          break;
        }
      }
    }
  }

  var_11 = 302500;
  var_12 = 2250000;
  var_13 = 6250000;
  var_14 = 122500;
  var_15 = -25536;
  var_10 = -99999999;
  var_11 = undefined;
  var_12 = 15000;
  var_13 = -25536;
  var_14 = " ";
  var_15 = undefined;
  var_16 = gettime();
  var_17 = getvalidplayersinarray();
  var_18 = [];
  if(!isDefined(var_17)) {
    return undefined;
  }

  foreach(var_6 in var_1) {
    var_15 = "";
    var_1A = 0;
    var_1B = var_6.modifiedspawnpoints * randomintrange(var_12, var_13);
    var_1C = randomint(100);
    if(isDefined(var_6.var_BF6C) && var_6.var_BF6C >= var_16) {
      var_1A = var_1A - 20000;
      var_15 = var_15 + " Short Cooldown";
    }

    var_1D = distancesquared(var_17.origin, var_6.origin);
    if(var_1D < var_14) {
      var_1A = var_1A - -15536;
      var_15 = var_15 + " Too Close";
    } else if(var_1D > var_13) {
      var_1A = var_1A - -15536;
      var_15 = var_15 + " Too Far";
    } else if(var_1D < var_11) {
      if(var_1C < max(int(level.specialroundcounter + 1) * 10, 20)) {
        var_1A = var_1A + var_1B;
        var_15 = var_15 + " Chance Close";
      } else {
        var_1A = var_1A - var_1B;
        var_15 = var_15 + " Close";
      }
    } else if(var_1D > var_12) {
      var_1A = var_1A - var_1B;
      var_15 = var_15 + " Far";
    } else {
      var_1A = var_1A + var_1B;
      var_15 = var_15 + " Good Spawn";
    }

    if(var_1A > var_10) {
      var_10 = var_1A;
      var_11 = var_6;
      var_14 = var_15;
      var_18[var_18.size] = var_6;
    }
  }

  if(!isDefined(var_11)) {
    return undefined;
  }

  for(var_1F = var_18.size - 1; var_1F >= 0; var_1F--) {
    var_20 = 1;
    foreach(var_17 in level.players) {
      if(distancesquared(var_17.origin, var_18[var_1F].origin) < var_15) {
        var_20 = 0;
        break;
      }
    }

    if(var_20) {
      var_11 = var_18[var_1F];
      break;
    }
  }

  var_11.var_BF6C = var_16 + var_4;
  return var_11;
}

getvalidplayersinarray() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.linked_to_coaster)) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  return scripts\engine\utility::random(var_0);
}

move_goon_spawner(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_1, var_0, 500);
  var_3.origin = var_2;
}

func_3712(var_0) {
  if(isDefined(level.var_8CBD) && isDefined(level.var_8CBD[var_0])) {
    var_1 = [[level.var_8CBD[var_0]]]();
    return var_1;
  }

  var_1 = 400;
  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_1 = 400;
      break;

    case 2:
      var_1 = 900;
      break;

    case 3:
      var_1 = 1300;
      break;

    default:
      var_1 = 1600;
      break;
  }

  return var_1;
}

calculatestartinggoonhealth() {
  var_0 = 400;
  if(level.wave_num > 19) {
    var_0 = 2000;
  } else if(level.wave_num > 14) {
    var_0 = 1600;
  } else if(level.wave_num > 9) {
    var_0 = 1300;
  } else if(level.wave_num > 4) {
    var_0 = 900;
  }

  return var_0;
}

update_special_round_counter() {
  if(level.wave_num > 19) {
    level.specialroundcounter = 4;
  } else if(level.wave_num > 14) {
    level.specialroundcounter = 3;
  } else if(level.wave_num > 9) {
    level.specialroundcounter = 2;
  } else if(level.wave_num > 4) {
    level.specialroundcounter = 1;
  } else {
    level.specialroundcounter = 0;
  }

  if(isDefined(level.specialwavescompleted)) {
    level.specialwavescompleted = level.specialroundcounter;
  }
}

update_origin(var_0, var_1) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getStructArray("static", "script_noteworthy");
  }

  foreach(var_3 in level.spawn_struct_list) {
    if(var_3.origin == var_0) {
      var_3.origin = var_1;
      break;
    }
  }
}

remove_origin(var_0) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getStructArray("static", "script_noteworthy");
  }

  foreach(var_2 in level.spawn_struct_list) {
    if(var_2.origin == var_0) {
      var_2.remove_me = 1;
      break;
    }
  }
}

update_kvp(var_0, var_1, var_2) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getStructArray("static", "script_noteworthy");
  }

  foreach(var_4 in level.spawn_struct_list) {
    if(var_4.origin == var_0) {
      var_4 = [[level.kvp_update_funcs[var_1]]](var_4, var_2);
      break;
    }
  }
}

kvp_update_init() {
  level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

update_kvp_script_fxid(var_0, var_1) {
  var_0.script_fxid = var_1;
  return var_0;
}

func_FF96() {
  if(isDefined(level.no_clown_spawn)) {
    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "alien_goon") {
      return 1;
    }

    return 0;
  }

  var_0 = randomint(100);
  if(var_0 < min(level.wave_num - 19, 10) && level.wave_num > 20) {
    if(gettime() - level.last_clown_spawn_time > 15000) {
      level.last_clown_spawn_time = gettime();
      return 1;
    }
  } else {
    return 0;
  }

  return 0;
}

calculatezombiehealth(var_0) {
  var_1 = 0;
  var_2 = level.wave_num;
  if(isDefined(level.var_8CBD) && isDefined(level.var_8CBD[var_0])) {
    var_1 = [[level.var_8CBD[var_0]]]();
  } else {
    if(isDefined(level.wave_num_override)) {
      var_2 = level.wave_num_override;
    }

    if(scripts\engine\utility::istrue(self.is_cop)) {
      var_2 = var_2 + 3;
    }

    if(scripts\engine\utility::istrue(self.is_skeleton)) {
      var_2 = var_2 + 10;
    }

    if(scripts\engine\utility::istrue(self.aj_goon)) {
      if(var_2 < 10) {
        var_2 = var_2 + 20;
      } else {
        var_2 = var_2 + 10;
      }
    }

    var_3 = 150;
    if(var_2 == 1) {
      var_1 = var_3;
    } else if(var_2 <= 9) {
      var_1 = var_3 + var_2 - 1 * 100;
    } else {
      var_4 = 950;
      var_5 = var_2 - 9;
      var_1 = var_4 * pow(1.1, var_5);
    }
  }

  if(isDefined(level.var_8CB3[var_0])) {
    var_1 = int(var_1 * level.var_8CB3[var_0]);
  }

  if(var_1 > 6100000) {
    var_1 = 6100000;
  }

  return int(var_1);
}

func_F604(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!scripts\engine\utility::istrue(var_3.wearing_dischord_glasses)) {
      var_3 visionsetnakedforplayer(var_0, var_1);
    }
  }
}

func_7848(var_0) {
  if(isDefined(level.available_event_func)) {
    return [[level.available_event_func]](var_0);
  }

  return "";
}

func_7B1C() {
  return level.wave_num + 1;
}

get_max_static_enemies(var_0) {
  return 24;
}

get_total_spawned_enemies(var_0) {
  var_1 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
  var_2 = 1;
  var_3 = 1;
  if(var_0 < 6) {
    var_2 = var_1[var_0];
  } else if(var_0 < 10) {
    var_3 = var_0 / 5;
  } else {
    var_3 = squared(var_0) * 0.03;
  }

  var_4 = level.players.size - 1;
  if(var_4 < 1) {
    var_4 = 0.5;
  }

  var_5 = 24 + var_4 * 6 * var_3 * var_2;
  return int(var_5);
}

func_7CFF(var_0) {
  return 1;
}

func_13691() {
  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    wait(1);
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

is_in_array(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_0.size == 0) {
    return 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}

cp_final_cleanup_main() {
  var_0 = 0;
  level.var_BE23 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_1 = gettime();
    if(var_1 < var_0) {
      continue;
    }

    if(isDefined(level.var_BE22)) {
      var_2 = gettime() / 1000;
      var_3 = var_2 - level.var_BE22;
      if(var_3 < 0) {
        continue;
      }

      level.var_BE22 = undefined;
    }

    var_4 = var_1 - level.var_13BDA / 1000;
    if(level.wave_num <= 5 && var_4 < 30) {
      continue;
    } else if(level.wave_num > 5 && var_4 < 20) {
      continue;
    }

    var_5 = undefined;
    if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 3) {
      var_5 = 1000000;
    }

    var_0 = var_0 + 3000;
    var_6 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_8 in var_6) {
      if(level.var_BE23 >= 1) {
        level.var_BE23 = 0;
        scripts\engine\utility::waitframe();
      }

      if(func_380D(var_8)) {
        var_8 func_5773(var_5);
      }
    }
  }
}

func_380D(var_0) {
  if(isDefined(level.zbg_active)) {
    return 0;
  }

  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_ghost") {
    return 0;
  }

  if(isDefined(var_0.var_2BF9)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.is_turned)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.dont_cleanup)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.sent_to_portal)) {
    return 0;
  }

  if(isDefined(var_0.delay_cleanup_until) && gettime() < var_0.delay_cleanup_until) {
    return 0;
  }

  return 1;
}

func_5773(var_0) {
  if(!isalive(self)) {
    return;
  }

  if(!func_FF1A(self)) {
    return;
  }

  var_1 = gettime() - self.spawn_time;
  if(var_1 < 5000) {
    return;
  }

  if(self.agent_type == "generic_zombie" || self.agent_type == "lumberjack") {
    if(var_1 < -20536 && !self.entered_playspace) {
      return;
    }
  }

  var_2 = 1;
  var_3 = 0;
  var_4 = 1;
  if(scripts\engine\utility::istrue(self.dismember_crawl) && level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 2) {
    var_3 = 1;
    var_0 = 250000;
    var_2 = 0;
  } else if(level.var_B789.size == 0) {
    if(isDefined(level.use_adjacent_volumes)) {
      var_2 = scripts\cp\zombies\zombies_spawning::animmode(1, 0);
    } else {
      var_2 = scripts\cp\zombies\zombies_spawning::animmode(0, 0);
    }
  } else {
    var_2 = scripts\cp\zombies\zombies_spawning::animmode(1, 0);
    if(var_2) {
      var_4 = scripts\cp\zombies\zombies_spawning::animmode(0, 1);
    }
  }

  level.var_BE23++;
  if(!var_2 || !var_4) {
    var_5 = 10000000;
    var_6 = level.players[0];
    foreach(var_8 in level.players) {
      var_9 = distancesquared(self.origin, var_8.origin);
      if(var_9 < var_5) {
        var_5 = var_9;
        var_6 = var_8;
      }
    }

    if(isDefined(var_0)) {
      var_11 = var_0;
    } else if(isDefined(var_7) && scripts\cp\zombies\zombies_spawning::func_CF4C(var_7)) {
      var_11 = 189225;
    } else {
      var_11 = 250000;
    }

    if(var_5 >= var_11) {
      if(!var_4) {
        if(level.last_mini_zone_fail + 1000 > gettime()) {
          return;
        } else {
          level.last_mini_zone_fail = gettime();
        }
      }

      thread func_51A5(var_5, var_3);
    }
  }
}

func_FF1A(var_0) {
  if(!isDefined(var_0.agent_type)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.scripted_mode)) {
    return 0;
  }

  switch (var_0.agent_type) {
    case "alien_phantom":
    case "slasher":
      return 0;

    default:
      return 1;
  }
}

func_51A5(var_0, var_1) {
  if(scripts\engine\utility::istrue(self.var_93A7)) {
    return;
  }

  if(var_1) {
    if(scripts\engine\utility::istrue(self.isactive)) {
      func_EDF6();
    }

    return;
  }

  foreach(var_3 in level.players) {
    if(scripts\engine\utility::istrue(var_3.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.in_afterlife_arcade)) {
      continue;
    }

    if(scripts\cp\zombies\zombies_spawning::func_CFB2(var_3)) {
      if(var_0 < 4000000) {
        return;
      }
    }
  }

  self.died_poorly = 1;
  if(scripts\engine\utility::istrue(self.marked_for_challenge) && isDefined(level.num_zombies_marked)) {
    level.num_zombies_marked--;
  }

  if(scripts\engine\utility::istrue(self.isactive)) {
    self.nocorpse = 1;
    func_EDF6();
  }
}

func_EDF6() {
  self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
}

adjustmovespeed(var_0, var_1, var_2) {
  var_0 endon("death");
  if(isDefined(var_0.agent_type) && var_0.agent_type == "crab_brute") {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1)) {
    wait(0.5);
  }

  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_2);
}

disablespawnvolumes(var_0, var_1) {
  level.copy_active_spawn_volumes = level.active_spawn_volumes;
  var_2 = undefined;
  var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_5 in level.copy_active_spawn_volumes) {
    if(ispointinvolume(var_0, var_5)) {
      var_2 = var_5;
      foreach(var_7 in var_3) {
        var_7 thread sendzombietopos(var_7, var_0);
      }

      break;
    }
  }

  foreach(var_11 in level.copy_active_spawn_volumes) {
    if(!scripts\engine\utility::istrue(var_1)) {
      if(isDefined(var_2) && var_11 == var_2) {
        continue;
      }
    }

    var_11 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
  }
}

restorespawnvolumes() {
  level notify("spawn_volumes_restored");
  foreach(var_1 in level.copy_active_spawn_volumes) {
    var_1 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }

  level.copy_active_spawn_volumes = undefined;
}

sendzombietopos(var_0, var_1) {
  level endon("spawn_volumes_restored");
  var_0 endon("death");
  var_2 = 250000;
  var_0.scripted_mode = 1;
  var_0.precacheleaderboards = 1;
  var_0 give_mp_super_weapon(var_1);
  for(;;) {
    if(distance(var_0.origin, var_1) < var_2) {
      break;
    }

    wait(0.5);
  }

  var_0.scripted_mode = 0;
  var_0.precacheleaderboards = 0;
}

special_vo_during_wave(var_0) {
  level endon("game_ended");
  if(!isDefined(level.played_cryptidvo)) {
    level.played_cryptidvo = 0;
  }

  if(!isDefined(level.played_powervo)) {
    level.played_powervo = 0;
  }

  if(!isDefined(level.completed_dialogues)) {
    level.completed_dialogues = [];
  }

  wait(10);
  if(scripts\engine\utility::flag_exist("neil_head_placed") && !scripts\engine\utility::flag("neil_head_placed")) {
    if(randomint(100) > 30) {
      if(scripts\engine\utility::istrue(level.played_cryptidvo)) {
        return;
      }

      level.played_cryptidvo = 1;
      var_1 = scripts\engine\utility::random(level.players);
      if(isDefined(var_1.vo_prefix)) {
        switch (var_1.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["conv_crypitd_sally_1_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_crypitd_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_crypitd_sally_1_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["conv_crypitd_pdex_1_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_crypitd_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_crypitd_pdex_1_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["conv_crypitd_andre_1_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_crypitd_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_crypitd_andre_1_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["conv_crypitd_aj_1_2"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_crypitd_aj_1_2", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_crypitd_aj_1_2"] = 1;
            }
            break;
        }

        return;
      }

      return;
    }

    var_2 = scripts\engine\utility::random(level.players);
    if(isDefined(var_2.vo_prefix)) {
      if(scripts\engine\utility::istrue(level.played_powervo)) {
        return;
      }

      level.played_powervo = 1;
      switch (var_2.vo_prefix) {
        case "p1_":
          if(!isDefined(level.completed_dialogues["conv_power_sally_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_power_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_power_sally_1_1"] = 1;
          }
          break;

        case "p2_":
          if(!isDefined(level.completed_dialogues["conv_power_pdex_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_power_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_power_pdex_1_1"] = 1;
          }
          break;

        case "p3_":
          if(!isDefined(level.completed_dialogues["conv_power_andre_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_power_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_power_andre_1_1"] = 1;
          }
          break;

        case "p4_":
          if(!isDefined(level.completed_dialogues["conv_power_aj_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_power_aj_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_power_aj_1_1"] = 1;
          }
          break;
      }

      return;
    }
  }
}

wave_complete_vo(var_0) {
  if(!isDefined(level.completed_dialogues)) {
    level.completed_dialogues = [];
  }

  if(level.players.size < 2) {
    if(level.players[0].vo_prefix == "p5_") {
      if(randomint(100) > 90) {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_p5_taunt", "rave_ww_vo");
      }
    }
  }

  if(var_0 >= 8 && var_0 <= 12) {
    if(randomint(100) > 60) {
      var_1 = scripts\engine\utility::random(level.players);
      if(isDefined(var_1.vo_prefix)) {
        switch (var_1.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["conv_round_8_12_1_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_8_12_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_8_12_1_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["conv_round_8_12_3_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_8_12_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_8_12_3_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["conv_round_8_12_2_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_8_12_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_8_12_2_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["conv_round_8_12_4_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_8_12_4_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_8_12_4_1"] = 1;
            }
            break;

          default:
            break;
        }

        return;
      }

      return;
    }

    return;
  }

  if(var_1 >= 10 && var_1 <= 16) {
    if(randomint(100) > 60) {
      var_2 = scripts\engine\utility::random(level.players);
      if(isDefined(var_2.vo_prefix)) {
        switch (var_2.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["conv_round_16_20_1_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_16_20_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_16_20_1_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["conv_round_16_20_2_1"])) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_round_16_20_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_round_16_20_2_1"] = 1;
            }
            break;

          default:
            break;
        }

        return;
      }

      return;
    }
  }
}

cp_final_boss_spawn() {
  var_0 = undefined;
  var_1 = get_scored_goon_spawn_location();
  if(isDefined(var_1)) {
    var_2 = get_boss_to_spawn();
    var_0 = boss_spawn_in_box(var_1, var_2);
    if(!isDefined(var_0)) {
      return 0;
    }

    move_boss_to_world(var_0, var_1);
  } else {
    return 0;
  }

  level notify("boss_spawned", var_0);
  if(scripts\engine\utility::flag("force_spawn_boss")) {
    var_0.var_72AC = 1;
  }

  return 1;
}

get_boss_to_spawn() {
  if(isDefined(level.boss_override)) {
    return level.boss_override;
  }

  if(!scripts\engine\utility::istrue(level.used_portal)) {
    return "alien_phantom";
  } else if(level.wave_num < 20) {
    return "alien_phantom";
  } else {
    return scripts\engine\utility::random(["alien_phantom", "slasher"]);
  }

  return "alien_phantom";
}

boss_spawn_in_box(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
  var_3 = var_2 spawn_brute_wave_enemy(var_1);
  return var_3;
}

move_boss_to_world(var_0, var_1) {
  var_1.in_use = 1;
  level.var_A88E = level.wave_num;
  func_3115(var_1);
  var_0 move_to_spot(var_1);
  var_1.in_use = 0;
}

spawn_brute_wave_enemy(var_0, var_1, var_2, var_3) {
  var_4 = self.origin;
  var_5 = self.angles;
  var_6 = "axis";
  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  if(!isDefined(self.script_animation)) {
    var_4 = getclosestpointonnavmesh(var_4);
    var_4 = var_4 + (0, 0, 5);
  }

  var_7 = scripts\cp\zombies\zombies_spawning::func_13F53(var_0, var_4, var_5, var_6, self);
  if(!isDefined(var_7)) {
    return undefined;
  }

  if(isDefined(self.volume)) {
    var_7.volume = self.volume;
  }

  var_7.dont_cleanup = undefined;
  var_7 thread func_3114();
  if(var_0 == "slasher") {
    var_7 thread slasher_audio_monitor();
  }

  level notify("agent_spawned", var_7);
  return var_7;
}

func_3114() {
  level endon("game_ended");
  if(!isDefined(level.var_3120)) {
    level.var_3120 = [];
  }

  level.var_3120 = scripts\engine\utility::add_to_array(level.var_3120, self);
  self.allowpain = 0;
  self.is_reserved = 1;
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  level.spawned_enemies[level.spawned_enemies.size] = self;
  thread scripts\cp\zombies\zombies_spawning::func_135A3();
  self waittill("death");
  level.var_3120 = scripts\engine\utility::array_remove(level.var_3120, self);
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

func_310F() {
  level endon("game_ended");
  self endon("death");
  self.voprefix = "alien_phantom_";
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix);
  self.playing_stumble = 0;
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(6, "attack_hit", "attack_miss");
    switch (var_0) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_pounding", 0);
        break;

      case "attack_miss":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_pounding", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "idle", 0);
        break;
    }
  }
}

slasher_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  self notify("stop_audio_monitors");
  if(!isDefined(level.zombie_slasher_vo_prefix)) {
    level.zombie_slasher_vo_prefix = "zmb_vo_slasher_";
  }

  self.voprefix = level.zombie_slasher_vo_prefix;
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix, undefined, 1);
  self.playing_stumble = 0;
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(6, "attack_hit", "taunt", "attack_charge", "attack_shoot");
    switch (var_0) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_melee", 0);
        break;

      case "attack_shoot":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_saw_blade_shoot", 0);
        break;

      case "taunt":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "taunt", 0);
        break;

      case "attack_charge":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "charge_grunt", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "walk_idle_grunt", 0);
        break;
    }
  }
}

func_3115(var_0) {
  var_1 = level._effect["final_phantom_spawn_bolt"];
  thread scripts\cp\utility::playsoundinspace("brute_spawn_lightning", var_0.origin);
  playFX(var_1, var_0.origin);
  playFX(level._effect["drone_ground_spawn"], var_0.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", var_0.origin);
  earthquake(0.3, 0.2, var_0.origin, 500);
}

calculatekaratemasterhealth() {
  var_0 = 900;
  if(isDefined(level.spawn_event_running) && level.spawn_event_running == 1) {
    var_1 = 400;
    switch (level.specialroundcounter) {
      case 0:
        var_1 = 400;
        break;

      case 1:
        var_1 = 900;
        break;

      case 2:
        var_1 = 1600;
        break;

      case 3:
        var_1 = 1900;
        break;

      default:
        var_1 = 2500;
        break;
    }

    var_0 = var_1;
  } else if(isDefined(level.zombie_health_func)) {
    var_2 = [[level.zombie_health_func]]("generic_zombie");
    var_0 = var_2 * 3;
  }

  return var_0;
}