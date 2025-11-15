/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
    level waittill("agent_spawned", var_00);
    if(var_00.agent_type == "generic_zombie") {
      var_00 thread delayed_set_move_mode();
    }
  }
}

turn_on_flood_room_trigger() {
  var_00 = getent("flood_room_tunnel_trigger", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isplayer(var_01)) {
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
  level.desired_enemy_deaths_this_wave = _meth_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  if(isDefined(level.specialwavescompleted)) {
    level.specialwavescompleted++;
  }

  var_00 = "karatemaster";
  func_1071B(var_00);
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
  level.desired_enemy_deaths_this_wave = _meth_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  if(level.wave_num >= 8) {
    var_00 = "alien_phantom";
    var_01 = scripts\engine\utility::random(level.players);
    var_02 = getrandomnavpoint(var_01.origin, 256);
    var_03 = spawnStruct();
    if(isDefined(var_02)) {
      var_03.origin = var_02;
    } else {
      var_03.origin = getclosestpointonnavmesh(var_01.origin);
    }

    var_03.angles = anglesToForward(var_01.origin - var_03.origin);
    var_04 = var_03 spawn_brute_wave_enemy(var_00);
  }

  var_00 = "alien_goon";
  func_1071B(var_00);
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
  level.desired_enemy_deaths_this_wave = _meth_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  var_00 = "alien_goon";
  func_1071B(var_00);
}

_meth_8455() {
  var_00 = level.players.size;
  var_01 = var_00 * 3;
  var_02 = 1;
  if(!scripts\engine\utility::flag("power_on")) {
    return starting_goon_spawn_total_spawns();
  }

  switch (level.specialroundcounter) {
    case 0:
      var_01 = var_00 * 6;
      break;

    case 1:
      var_01 = var_00 * 9;
      break;

    case 2:
      var_01 = var_00 * 12;
      break;

    case 3:
      var_01 = var_00 * 16;
      break;

    default:
      var_01 = var_00 * 16;
      break;
  }

  var_01 = var_01 * var_02;
  return var_01;
}

starting_goon_spawn_total_spawns() {
  var_00 = level.players.size;
  var_01 = var_00 * 3;
  var_02 = 1;
  switch (level.wave_num) {
    case 0:
      var_01 = var_00 * 6;
      break;

    case 1:
      var_01 = var_00 * 9;
      break;

    case 2:
      var_01 = var_00 * 12;
      break;

    case 3:
      var_01 = var_00 * 16;
      break;

    default:
      var_01 = int(max(1, level.specialroundcounter) * var_00 * 16);
      break;
  }

  var_01 = var_01 * var_02;
  return var_01;
}

func_1071B(param_00) {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  level.respawning_enemies = 0;
  level.num_goons_spawned = 0;
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  var_01 = 0;
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

    var_02 = num_goons_to_spawn();
    var_03 = get_spawner_and_spawn_goons(var_02, param_00);
    var_01 = var_01 + var_03;
    if(var_03 > 0) {
      wait(_meth_8454(var_01, level.desired_enemy_deaths_this_wave));
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

func_5CF7(param_00, param_01, param_02) {
  if(isDefined(level.force_drop_loot_item)) {
    if(level scripts\cp\loot::drop_loot(param_01, param_02, level.force_drop_loot_item, undefined, undefined, 1)) {
      level.force_drop_loot_item = undefined;
      return 1;
    }
  }

  if(level.wave_num > 0 && !scripts\engine\utility::flag("power_on")) {
    return 0;
  }

  if(level.spawn_event_running == 1) {
    if(level.desired_enemy_deaths_this_wave == level.current_enemy_deaths && level.wave_num > 1) {
      level thread scripts\cp\loot::drop_loot(param_01, param_02, "ammo_max", undefined, undefined, 1);
      return 1;
    }

    return 0;
  }

  return 0;
}

func_79EB() {
  return ["alien_goon"];
}

_meth_8454(param_00, param_01) {
  var_02 = 1.5;
  var_03 = level.players.size;
  if(var_03 == 1) {
    if(scripts\engine\utility::flag_exist("power_on") && !scripts\engine\utility::flag("power_on")) {
      switch (level.specialroundcounter) {
        case 0:
          var_02 = 4;
          break;

        case 1:
          var_02 = 3;
          break;

        case 2:
          var_02 = 2.5;
          break;

        case 3:
          var_02 = 2;
          break;

        default:
          var_02 = 2;
          break;
      }
    } else {
      switch (level.specialroundcounter) {
        case 0:
          var_02 = 4;
          break;

        case 1:
          var_02 = 3;
          break;

        case 2:
          var_02 = 2.5;
          break;

        case 3:
          var_02 = 2;
          break;

        default:
          var_02 = 2;
          break;
      }
    }
  } else if(scripts\engine\utility::flag_exist("power_on") && !scripts\engine\utility::flag("power_on")) {
    switch (level.specialroundcounter) {
      case 0:
        var_02 = 2;
        break;

      case 1:
        var_02 = 1.5;
        break;

      case 2:
        var_02 = 1.25;
        break;

      case 3:
        var_02 = 1;
        break;

      default:
        var_02 = 0.5;
        break;
    }
  } else {
    switch (level.specialroundcounter) {
      case 0:
        var_02 = 3;
        break;

      case 1:
        var_02 = 2;
        break;

      case 2:
        var_02 = 1.5;
        break;

      case 3:
        var_02 = 1;
        break;

      default:
        var_02 = 1;
        break;
    }
  }

  var_02 = var_02 - param_00 / param_01;
  var_02 = max(var_02, 0.05);
  return var_02;
}

choose_agent_type_and_spawn(param_00, param_01) {
  var_02 = "alien_goon";
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  if(isDefined(level.respawn_data)) {
    var_02 = level.respawn_data.type;
  }

  if(scripts\engine\utility::flag("power_on")) {
    if(!scripts\engine\utility::istrue(level.used_portal)) {
      var_02 = "alien_goon";
    } else {
      var_02 = scripts\engine\utility::random(["alien_goon", "zombie_clown", "karatemaster"]);
    }
  }

  if(isDefined(level.event_wave_override)) {
    var_02 = level.event_wave_override;
  }

  var_03 = get_spawner_and_spawn_goons(param_00, var_02);
  return var_03;
}

get_spawner_and_spawn_goons(param_00, param_01, param_02) {
  var_03 = 0;
  if(param_00 <= 0) {
    if(param_00 < 0) {
      scripts\cp\zombies\zombies_spawning::func_A5FA(abs(param_00));
    }

    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == param_01) {
      param_00 = 1;
    }
  }

  if(isDefined(param_02)) {
    var_04 = min(param_00, param_02);
  } else {
    var_04 = min(param_01, 1);
  }

  var_04 = spawn_goons_from_eggs(var_04, param_01);
  return var_04;
}

spawn_goons_from_eggs(param_00, param_01) {
  var_02 = 0.3;
  var_03 = 0.7;
  var_04 = 0;
  if(param_00 > 0) {
    var_05 = [];
    var_04 = 0;
    while(var_04 < param_00) {
      var_06 = get_scored_goon_spawn_location();
      var_06.in_use = 1;
      var_06.lastspawntime = gettime();
      var_07 = func_10719(var_06, param_01);
      if(isDefined(var_07)) {
        var_04++;
        wait(randomfloatrange(var_02, var_03));
        continue;
      }

      scripts\engine\utility::waitframe();
      var_06.in_use = 0;
    }
  }

  return var_04;
}

func_1B99(param_00) {
  var_01 = level._effect["final_goon_spawn_bolt"];
  playFX(var_01, param_00.origin);
  playFX(level._effect["drone_ground_spawn"], param_00.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", param_00.origin);
  earthquake(0.3, 0.2, param_00.origin, 500);
}

move_to_spot(param_00) {
  var_01 = getclosestpointonnavmesh(param_00.origin);
  self dontinterpolate();
  self setorigin(param_00.origin, 1);
  self ghostskulls_complete_status(param_00.origin);
  self.precacheleaderboards = 0;
}

func_10719(param_00, param_01) {
  var_02 = param_00.origin;
  var_03 = param_00.angles;
  var_04 = param_01;
  func_1B99(param_00);
  var_05 = goon_spawn_func(var_04, var_02, var_03, "axis");
  if(isDefined(var_05)) {
    var_05 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_04);
    update_respawn_data(var_04);
    param_00.lastspawntime = gettime();
  }

  return var_05;
}

goon_spawn_func(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\mp\mp_agent::spawnnewagent(param_00, param_03, param_01, param_02, undefined, param_04);
  if(!isDefined(var_05)) {
    return undefined;
  }

  if(isDefined(var_05.spawner)) {
    var_05.entered_playspace = 1;
  }

  var_05 ghostskulls_total_waves(var_05.defaultgoalradius);
  var_05.maxhealth = func_3712(param_00);
  var_05.health = var_05.maxhealth;
  if(var_05.agent_type != "alien_goon" && var_05.agent_type != "alien_phantom") {
    if(param_00 == "karatemaster" && isDefined(level.zombie_karatemaster_vo_prefix)) {
      var_05.voprefix = level.zombie_karatemaster_vo_prefix;
      var_05 thread scripts\cp\zombies\zombies_vo::func_13F10();
    } else if(param_00 == "zombie_clown") {
      var_05.voprefix = level.var_13F18;
      var_05 thread scripts\cp\zombies\zombies_vo::func_13F10();
    }
  }

  if(param_00 == "alien_goon" || param_00 == "alien_phantom") {
    var_05 thread scripts\cp\zombies\zombies_spawning::setemissive();
  }

  return var_05;
}

update_respawn_data(param_00) {
  if(isDefined(level.respawn_data)) {
    var_01 = -1;
    for(var_02 = 0; var_02 < level.respawn_enemy_list.size; var_02++) {
      if(level.respawn_enemy_list[var_02].id == level.respawn_data.id && level.respawn_data.type == param_00) {
        var_01 = var_02;
        break;
      }
    }

    if(var_01 > -1) {
      if(isDefined(level.respawn_data.health)) {
        self.health = level.respawn_data.health;
      }

      level.respawn_enemy_list = scripts\cp\utility::array_remove_index(level.respawn_enemy_list, var_01);
    }

    level.respawn_data = undefined;
  }
}

num_goons_to_spawn() {
  var_00 = scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn();
  return var_00;
}

get_scored_goon_spawn_location() {
  var_00 = undefined;
  var_00 = func_79EC();
  return var_00;
}

func_79EC() {
  var_00 = [];
  foreach(var_02 in level.var_162C) {
    if(scripts\engine\utility::istrue(var_02.var_19) && !scripts\engine\utility::istrue(var_02.in_use)) {
      var_00[var_00.size] = var_02;
    }
  }

  if(var_00.size > 0) {
    var_02 = _meth_8456(var_00);
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  return scripts\engine\utility::random(var_00);
}

_meth_8456(param_00) {
  var_01 = [];
  var_02 = 1;
  var_03 = 1;
  var_04 = 10000;
  foreach(var_06 in param_00) {
    if(scripts\cp\zombies\func_0D60::allowedstances(var_06.volume)) {
      var_01[var_01.size] = var_06;
      var_06.modifiedspawnpoints = var_02;
      continue;
    }

    if(isDefined(var_06.volume.var_186E)) {
      foreach(var_08 in var_06.volume.var_186E) {
        if(scripts\cp\zombies\func_0D60::allowedstances(var_08)) {
          var_01[var_01.size] = var_06;
          var_06.modifiedspawnpoints = var_03;
          break;
        }
      }
    }
  }

  var_0B = 302500;
  var_0C = 2250000;
  var_0D = 6250000;
  var_0E = 122500;
  var_0F = -25536;
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

  foreach(var_06 in var_01) {
    var_15 = "";
    var_1A = 0;
    var_1B = var_06.modifiedspawnpoints * randomintrange(var_12, var_13);
    var_1C = randomint(100);
    if(isDefined(var_06.var_BF6C) && var_06.var_BF6C >= var_16) {
      var_1A = var_1A - 20000;
      var_15 = var_15 + " Short Cooldown";
    }

    var_1D = distancesquared(var_17.origin, var_06.origin);
    if(var_1D < var_0E) {
      var_1A = var_1A - -15536;
      var_15 = var_15 + " Too Close";
    } else if(var_1D > var_0D) {
      var_1A = var_1A - -15536;
      var_15 = var_15 + " Too Far";
    } else if(var_1D < var_0B) {
      if(var_1C < max(int(level.specialroundcounter + 1) * 10, 20)) {
        var_1A = var_1A + var_1B;
        var_15 = var_15 + " Chance Close";
      } else {
        var_1A = var_1A - var_1B;
        var_15 = var_15 + " Close";
      }
    } else if(var_1D > var_0C) {
      var_1A = var_1A - var_1B;
      var_15 = var_15 + " Far";
    } else {
      var_1A = var_1A + var_1B;
      var_15 = var_15 + " Good Spawn";
    }

    if(var_1A > var_10) {
      var_10 = var_1A;
      var_11 = var_06;
      var_14 = var_15;
      var_18[var_18.size] = var_06;
    }
  }

  if(!isDefined(var_11)) {
    return undefined;
  }

  for(var_1F = var_18.size - 1; var_1F >= 0; var_1F--) {
    var_20 = 1;
    foreach(var_17 in level.players) {
      if(distancesquared(var_17.origin, var_18[var_1F].origin) < var_0F) {
        var_20 = 0;
        break;
      }
    }

    if(var_20) {
      var_11 = var_18[var_1F];
      break;
    }
  }

  var_11.var_BF6C = var_16 + var_04;
  return var_11;
}

getvalidplayersinarray() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(!isalive(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.linked_to_coaster)) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return scripts\engine\utility::random(var_00);
}

move_goon_spawner(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getclosest(param_01, param_00, 500);
  var_03.origin = param_02;
}

func_3712(param_00) {
  if(isDefined(level.var_8CBD) && isDefined(level.var_8CBD[param_00])) {
    var_01 = [[level.var_8CBD[param_00]]]();
    return var_01;
  }

  var_01 = 400;
  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_01 = 400;
      break;

    case 2:
      var_01 = 900;
      break;

    case 3:
      var_01 = 1300;
      break;

    default:
      var_01 = 1600;
      break;
  }

  return var_01;
}

calculatestartinggoonhealth() {
  var_00 = 400;
  if(level.wave_num > 19) {
    var_00 = 2000;
  } else if(level.wave_num > 14) {
    var_00 = 1600;
  } else if(level.wave_num > 9) {
    var_00 = 1300;
  } else if(level.wave_num > 4) {
    var_00 = 900;
  }

  return var_00;
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

update_origin(param_00, param_01) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");
  }

  foreach(var_03 in level.spawn_struct_list) {
    if(var_03.origin == param_00) {
      var_03.origin = param_01;
      break;
    }
  }
}

remove_origin(param_00) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");
  }

  foreach(var_02 in level.spawn_struct_list) {
    if(var_02.origin == param_00) {
      var_02.remove_me = 1;
      break;
    }
  }
}

update_kvp(param_00, param_01, param_02) {
  if(!isDefined(level.spawn_struct_list)) {
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");
  }

  foreach(var_04 in level.spawn_struct_list) {
    if(var_04.origin == param_00) {
      var_04 = [
        [level.kvp_update_funcs[param_01]]
      ](var_04, param_02);
      break;
    }
  }
}

kvp_update_init() {
  level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

update_kvp_script_fxid(param_00, param_01) {
  param_00.script_fxid = param_01;
  return param_00;
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

  var_00 = randomint(100);
  if(var_00 < min(level.wave_num - 19, 10) && level.wave_num > 20) {
    if(gettime() - level.last_clown_spawn_time > 15000) {
      level.last_clown_spawn_time = gettime();
      return 1;
    }
  } else {
    return 0;
  }

  return 0;
}

calculatezombiehealth(param_00) {
  var_01 = 0;
  var_02 = level.wave_num;
  if(isDefined(level.var_8CBD) && isDefined(level.var_8CBD[param_00])) {
    var_01 = [[level.var_8CBD[param_00]]]();
  } else {
    if(isDefined(level.wave_num_override)) {
      var_02 = level.wave_num_override;
    }

    if(scripts\engine\utility::istrue(self.is_cop)) {
      var_02 = var_02 + 3;
    }

    if(scripts\engine\utility::istrue(self.is_skeleton)) {
      var_02 = var_02 + 10;
    }

    if(scripts\engine\utility::istrue(self.aj_goon)) {
      if(var_02 < 10) {
        var_02 = var_02 + 20;
      } else {
        var_02 = var_02 + 10;
      }
    }

    var_03 = 150;
    if(var_02 == 1) {
      var_01 = var_03;
    } else if(var_02 <= 9) {
      var_01 = var_03 + var_02 - 1 * 100;
    } else {
      var_04 = 950;
      var_05 = var_02 - 9;
      var_01 = var_04 * pow(1.1, var_05);
    }
  }

  if(isDefined(level.var_8CB3[param_00])) {
    var_01 = int(var_01 * level.var_8CB3[param_00]);
  }

  if(var_01 > 6100000) {
    var_01 = 6100000;
  }

  return int(var_01);
}

func_F604(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!scripts\engine\utility::istrue(var_03.wearing_dischord_glasses)) {
      var_03 visionsetnakedforplayer(param_00, param_01);
    }
  }
}

func_7848(param_00) {
  if(isDefined(level.available_event_func)) {
    return [[level.available_event_func]](param_00);
  }

  return "";
}

func_7B1C() {
  return level.wave_num + 1;
}

get_max_static_enemies(param_00) {
  return 24;
}

get_total_spawned_enemies(param_00) {
  var_01 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
  var_02 = 1;
  var_03 = 1;
  if(param_00 < 6) {
    var_02 = var_01[param_00];
  } else if(param_00 < 10) {
    var_03 = param_00 / 5;
  } else {
    var_03 = squared(param_00) * 0.03;
  }

  var_04 = level.players.size - 1;
  if(var_04 < 1) {
    var_04 = 0.5;
  }

  var_05 = 24 + var_04 * 6 * var_03 * var_02;
  return int(var_05);
}

func_7CFF(param_00) {
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

is_in_array(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01) || param_00.size == 0) {
    return 0;
  }

  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] == param_01) {
      return 1;
    }
  }

  return 0;
}

cp_final_cleanup_main() {
  var_00 = 0;
  level.var_BE23 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_01 = gettime();
    if(var_01 < var_00) {
      continue;
    }

    if(isDefined(level.var_BE22)) {
      var_02 = gettime() / 1000;
      var_03 = var_02 - level.var_BE22;
      if(var_03 < 0) {
        continue;
      }

      level.var_BE22 = undefined;
    }

    var_04 = var_01 - level.var_13BDA / 1000;
    if(level.wave_num <= 5 && var_04 < 30) {
      continue;
    } else if(level.wave_num > 5 && var_04 < 20) {
      continue;
    }

    var_05 = undefined;
    if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 3) {
      var_05 = 1000000;
    }

    var_00 = var_00 + 3000;
    var_06 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_08 in var_06) {
      if(level.var_BE23 >= 1) {
        level.var_BE23 = 0;
        scripts\engine\utility::waitframe();
      }

      if(func_380D(var_08)) {
        var_08 func_5773(var_05);
      }
    }
  }
}

func_380D(param_00) {
  if(isDefined(level.zbg_active)) {
    return 0;
  }

  if(isDefined(param_00.agent_type) && param_00.agent_type == "zombie_ghost") {
    return 0;
  }

  if(isDefined(param_00.var_2BF9)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.is_turned)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.dont_cleanup)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.sent_to_portal)) {
    return 0;
  }

  if(isDefined(param_00.delay_cleanup_until) && gettime() < param_00.delay_cleanup_until) {
    return 0;
  }

  return 1;
}

func_5773(param_00) {
  if(!isalive(self)) {
    return;
  }

  if(!func_FF1A(self)) {
    return;
  }

  var_01 = gettime() - self.spawn_time;
  if(var_01 < 5000) {
    return;
  }

  if(self.agent_type == "generic_zombie" || self.agent_type == "lumberjack") {
    if(var_01 < -20536 && !self.entered_playspace) {
      return;
    }
  }

  var_02 = 1;
  var_03 = 0;
  var_04 = 1;
  if(scripts\engine\utility::istrue(self.dismember_crawl) && level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 2) {
    var_03 = 1;
    param_00 = 250000;
    var_02 = 0;
  } else if(level.var_B789.size == 0) {
    if(isDefined(level.use_adjacent_volumes)) {
      var_02 = scripts\cp\zombies\zombies_spawning::animmode(1, 0);
    } else {
      var_02 = scripts\cp\zombies\zombies_spawning::animmode(0, 0);
    }
  } else {
    var_02 = scripts\cp\zombies\zombies_spawning::animmode(1, 0);
    if(var_02) {
      var_04 = scripts\cp\zombies\zombies_spawning::animmode(0, 1);
    }
  }

  level.var_BE23++;
  if(!var_02 || !var_04) {
    var_05 = 10000000;
    var_06 = level.players[0];
    foreach(var_08 in level.players) {
      var_09 = distancesquared(self.origin, var_08.origin);
      if(var_09 < var_05) {
        var_05 = var_09;
        var_06 = var_08;
      }
    }

    if(isDefined(param_00)) {
      var_0B = param_00;
    } else if(isDefined(var_07) && scripts\cp\zombies\zombies_spawning::func_CF4C(var_07)) {
      var_0B = 189225;
    } else {
      var_0B = 250000;
    }

    if(var_05 >= var_0B) {
      if(!var_04) {
        if(level.last_mini_zone_fail + 1000 > gettime()) {
          return;
        } else {
          level.last_mini_zone_fail = gettime();
        }
      }

      thread func_51A5(var_05, var_03);
    }
  }
}

func_FF1A(param_00) {
  if(!isDefined(param_00.agent_type)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.scripted_mode)) {
    return 0;
  }

  switch (param_00.agent_type) {
    case "alien_phantom":
    case "slasher":
      return 0;

    default:
      return 1;
  }
}

func_51A5(param_00, param_01) {
  if(scripts\engine\utility::istrue(self.var_93A7)) {
    return;
  }

  if(param_01) {
    if(scripts\engine\utility::istrue(self.isactive)) {
      func_EDF6();
    } else {}

    return;
  }

  foreach(var_03 in level.players) {
    if(scripts\engine\utility::istrue(var_03.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.in_afterlife_arcade)) {
      continue;
    }

    if(scripts\cp\zombies\zombies_spawning::func_CFB2(var_03)) {
      if(param_00 < 4000000) {
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

adjustmovespeed(param_00, param_01, param_02) {
  param_00 endon("death");
  if(isDefined(param_00.agent_type) && param_00.agent_type == "crab_brute") {
    return;
  }

  if(scripts\engine\utility::istrue(param_00.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01)) {
    wait(0.5);
  }

  param_00 scripts\asm\asm_bb::bb_requestmovetype(param_02);
}

disablespawnvolumes(param_00, param_01) {
  level.copy_active_spawn_volumes = level.active_spawn_volumes;
  var_02 = undefined;
  var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_05 in level.copy_active_spawn_volumes) {
    if(ispointinvolume(param_00, var_05)) {
      var_02 = var_05;
      foreach(var_07 in var_03) {
        var_07 thread sendzombietopos(var_07, param_00);
      }

      break;
    }
  }

  foreach(var_0B in level.copy_active_spawn_volumes) {
    if(!scripts\engine\utility::istrue(param_01)) {
      if(isDefined(var_02) && var_0B == var_02) {
        continue;
      }
    }

    var_0B scripts\cp\zombies\zombies_spawning::make_volume_inactive();
  }
}

restorespawnvolumes() {
  level notify("spawn_volumes_restored");
  foreach(var_01 in level.copy_active_spawn_volumes) {
    var_01 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }

  level.copy_active_spawn_volumes = undefined;
}

sendzombietopos(param_00, param_01) {
  level endon("spawn_volumes_restored");
  param_00 endon("death");
  var_02 = 250000;
  param_00.scripted_mode = 1;
  param_00.precacheleaderboards = 1;
  param_00 give_mp_super_weapon(param_01);
  for(;;) {
    if(distance(param_00.origin, param_01) < var_02) {
      break;
    }

    wait(0.5);
  }

  param_00.scripted_mode = 0;
  param_00.precacheleaderboards = 0;
}

special_vo_during_wave(param_00) {
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
      var_01 = scripts\engine\utility::random(level.players);
      if(isDefined(var_01.vo_prefix)) {
        switch (var_01.vo_prefix) {
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

    var_02 = scripts\engine\utility::random(level.players);
    if(isDefined(var_02.vo_prefix)) {
      if(scripts\engine\utility::istrue(level.played_powervo)) {
        return;
      }

      level.played_powervo = 1;
      switch (var_02.vo_prefix) {
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

wave_complete_vo(param_00) {
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

  if(param_00 >= 8 && param_00 <= 12) {
    if(randomint(100) > 60) {
      var_01 = scripts\engine\utility::random(level.players);
      if(isDefined(var_01.vo_prefix)) {
        switch (var_01.vo_prefix) {
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

  if(var_01 >= 10 && var_01 <= 16) {
    if(randomint(100) > 60) {
      var_02 = scripts\engine\utility::random(level.players);
      if(isDefined(var_02.vo_prefix)) {
        switch (var_02.vo_prefix) {
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
  var_00 = undefined;
  var_01 = get_scored_goon_spawn_location();
  if(isDefined(var_01)) {
    var_02 = get_boss_to_spawn();
    var_00 = boss_spawn_in_box(var_01, var_02);
    if(!isDefined(var_00)) {
      return 0;
    }

    move_boss_to_world(var_00, var_01);
  } else {
    return 0;
  }

  level notify("boss_spawned", var_00);
  if(scripts\engine\utility::flag("force_spawn_boss")) {
    var_00.var_72AC = 1;
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

boss_spawn_in_box(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
  var_03 = var_02 spawn_brute_wave_enemy(param_01);
  return var_03;
}

move_boss_to_world(param_00, param_01) {
  param_01.in_use = 1;
  level.var_A88E = level.wave_num;
  func_3115(param_01);
  param_00 move_to_spot(param_01);
  param_01.in_use = 0;
}

spawn_brute_wave_enemy(param_00, param_01, param_02, param_03) {
  var_04 = self.origin;
  var_05 = self.angles;
  var_06 = "axis";
  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  if(isDefined(param_02)) {
    var_05 = param_02;
  }

  if(isDefined(param_03)) {
    var_06 = param_03;
  }

  if(!isDefined(self.script_animation)) {
    var_04 = getclosestpointonnavmesh(var_04);
    var_04 = var_04 + (0, 0, 5);
  }

  var_07 = scripts\cp\zombies\zombies_spawning::func_13F53(param_00, var_04, var_05, var_06, self);
  if(!isDefined(var_07)) {
    return undefined;
  }

  if(isDefined(self.volume)) {
    var_07.volume = self.volume;
  }

  var_07.dont_cleanup = undefined;
  var_07 thread func_3114();
  if(param_00 == "slasher") {
    var_07 thread slasher_audio_monitor();
  }

  level notify("agent_spawned", var_07);
  return var_07;
}

func_3114() {
  level endon("game_ended");
  if(!isDefined(level.var_3120)) {
    level.var_3120 = [];
  }

  level.var_3120 = scripts\engine\utility::array_add_safe(level.var_3120, self);
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
    var_00 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "attack_miss");
    switch (var_00) {
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
    var_00 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "taunt", "attack_charge", "attack_shoot");
    switch (var_00) {
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

func_3115(param_00) {
  var_01 = level._effect["final_phantom_spawn_bolt"];
  thread scripts\cp\utility::playsoundinspace("brute_spawn_lightning", param_00.origin);
  playFX(var_01, param_00.origin);
  playFX(level._effect["drone_ground_spawn"], param_00.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", param_00.origin);
  earthquake(0.3, 0.2, param_00.origin, 500);
}

calculatekaratemasterhealth() {
  var_00 = 900;
  if(isDefined(level.spawn_event_running) && level.spawn_event_running == 1) {
    var_01 = 400;
    switch (level.specialroundcounter) {
      case 0:
        var_01 = 400;
        break;

      case 1:
        var_01 = 900;
        break;

      case 2:
        var_01 = 1600;
        break;

      case 3:
        var_01 = 1900;
        break;

      default:
        var_01 = 2500;
        break;
    }

    var_00 = var_01;
  } else if(isDefined(level.zombie_health_func)) {
    var_02 = [[level.zombie_health_func]]("generic_zombie");
    var_00 = var_02 * 3;
  }

  return var_00;
}