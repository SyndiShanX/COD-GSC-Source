/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_disco_spawning.gsc
****************************************************/

goon_spawn_event_func() {
  level.static_enemy_types = func_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = _meth_8455();
  level.current_enemy_deaths = 0;
  level.last_clown_spawn_time = gettime();
  func_1071B();
}

_meth_8455() {
  var_00 = level.players.size;
  var_01 = var_00 * 3;
  var_02 = 2;
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
      var_02 = 3;
      break;

    default:
      var_01 = var_00 * 16;
      var_02 = 3;
      break;
  }

  var_01 = var_01 * var_02;
  return var_01;
}

func_1071B() {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  level.respawning_enemies = 0;
  level.num_goons_spawned = 0;
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  var_00 = 0;
  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    while(scripts\engine\utility::istrue(level.zombies_paused) || scripts\engine\utility::istrue(level.nuke_zombies_paused)) {
      scripts\engine\utility::waitframe();
    }

    var_01 = num_goons_to_spawn();
    var_02 = get_spawner_and_spawn_goons(var_01);
    var_00 = var_00 + var_02;
    if(var_02 > 0) {
      wait(_meth_8454(var_00, level.desired_enemy_deaths_this_wave));
      continue;
    }

    wait(0.1);
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

func_B26D() {
  if(!is_in_array(level.var_162C, self)) {
    level.var_162C[level.var_162C.size] = self;
  }

  self.var_19 = 1;
  self.in_use = 0;
}

func_B26E() {
  self.var_19 = 0;
}

func_5CF7(param_00, param_01, param_02) {
  if(isDefined(level.force_drop_loot_item)) {
    level thread scripts\cp\loot::drop_loot(param_01, param_02, level.force_drop_loot_item);
    level.force_drop_loot_item = undefined;
    return 1;
  }

  if(level.spawn_event_running == 1) {
    if(level.desired_enemy_deaths_this_wave == level.current_enemy_deaths) {
      level thread scripts\cp\loot::drop_loot(param_01, param_02, "ammo_max");
      return 1;
    }

    return 0;
  }

  return 0;
}

func_79EB() {
  return ["skater"];
}

_meth_8454(param_00, param_01) {
  var_02 = 1.5;
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

  var_02 = var_02 - param_00 / param_01;
  var_02 = max(var_02, 0.05);
  return var_02;
}

_meth_826F() {
  var_00 = 0.5;
  return var_00;
}

rotatevelocity() {
  var_00 = level.players.size;
  return 8 + 4 * var_00;
}

get_spawner_and_spawn_goons(param_00) {
  var_01 = 0;
  if(param_00 <= 0) {
    if(param_00 < 0) {
      scripts\cp\zombies\zombies_spawning::func_A5FA(abs(param_00));
    }

    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "skater") {
      param_00 = 1;
    }
  }

  var_02 = min(param_00, 2);
  func_1071C(var_02);
  return var_02;
}

func_1071C(param_00) {
  var_01 = 0.3;
  var_02 = 0.7;
  if(param_00 > 0) {
    scripts\cp\zombies\zombies_spawning::func_93E6(param_00);
    var_03 = [];
    var_04 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
    var_05 = 0;
    while(var_05 < param_00) {
      var_06 = func_10719(var_04);
      if(isDefined(var_06)) {
        var_05++;
        var_06 give_mp_super_weapon(var_06.origin);
        var_06 scripts\mp\agents\_scriptedagents::setstatelocked(1, "spawn_in_box");
        var_06.precacheleaderboards = 1;
        var_06.ignoreme = 1;
        var_06.scripted_mode = 1;
        var_03[var_03.size] = var_06;
      }

      wait(0.1);
    }

    var_07 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
    var_07.in_use = 1;
    var_07.lastspawntime = gettime();
    thread scripts\cp\utility::playsoundinspace("zombie_spawn_lightning", var_07.origin);
    for(var_08 = 0; var_08 < var_03.size; var_08++) {
      var_06 = var_03[var_08];
      var_09 = scripts\cp\zombies\zombies_spawning::func_772C(var_07.origin, var_07.angles);
      var_06.spawner = var_09;
      func_1B99(var_06.spawner);
      var_06 scripts\cp\zombies\zombies_spawning::move_to_spot(var_06.spawner);
      var_06.ignoreme = 0;
      var_06.scripted_mode = 0;
      var_06 scripts\mp\agents\_scriptedagents::setstatelocked(0, "spawn_in_box");
      var_09 = undefined;
      scripts\cp\zombies\zombies_spawning::func_4FB6(1);
      wait(randomfloatrange(var_01, var_02));
    }

    var_07.in_use = 0;
  }
}

func_1B99(param_00) {
  var_01 = level._effect["goon_spawn_bolt"];
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

func_772C(param_00, param_01) {
  var_02 = 50;
  var_03 = 50;
  var_04 = spawnStruct();
  var_04.angles = param_01;
  var_05 = var_04.origin;
  var_06 = 0;
  while(!var_06) {
    var_07 = randomintrange(var_02 * -1, var_02);
    var_08 = randomintrange(var_03 * -1, var_03);
    var_05 = getclosestpointonnavmesh((param_00[0] + var_07, param_00[1] + var_08, param_00[2]));
    var_06 = 1;
    foreach(var_0A in level.players) {
      if(positionwouldtelefrag(var_05)) {
        var_06 = 0;
      }
    }

    if(!var_06) {
      wait(0.1);
    }
  }

  var_04.origin = var_05 + (0, 0, 5);
  return var_04;
}

func_10719(param_00) {
  var_01 = "skater";
  var_02 = param_00.origin;
  var_03 = param_00.angles;
  var_04 = "axis";
  var_05 = scripts\mp\mp_agent::spawnnewagent(var_01, var_04, var_02, var_03);
  if(isDefined(var_05)) {
    update_respawn_data(var_01);
    var_05 setavoidanceradius(4);
    param_00.lastspawntime = gettime();
    var_05 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_01);
    level notify("agent_spawned", var_05);
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

sasquatch_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix, undefined, 1);
  self.playing_stumble = 0;
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "attack_miss", "attack_charge");
    switch (var_00) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack", 0);
        break;

      case "attack_miss":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack", 0);
        break;

      case "attack_charge":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "charge_grunt", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "idle_grunt", 0);
        break;
    }
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
  var_02 = 2;
  var_03 = 1;
  var_04 = 5000;
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

  var_0B = 562500;
  var_0C = 4000000;
  var_0D = 9000000;
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

func_9608() {
  level.goon_spawners = [];
  var_00 = scripts\engine\utility::getstructarray("dog_spawner", "targetname");
  if(isDefined(level.goon_spawner_patch_func)) {
    [[level.goon_spawner_patch_func]](var_00);
  }

  foreach(var_02 in var_00) {
    var_03 = 0;
    foreach(var_05 in level.invalid_spawn_volume_array) {
      if(ispointinvolume(var_02.origin, var_05)) {
        var_03 = 1;
      }
    }

    if(!var_03) {
      foreach(var_05 in level.spawn_volume_array) {
        if(ispointinvolume(var_02.origin, var_05)) {
          if(!isDefined(var_02.angles)) {
            var_02.angles = (0, 0, 0);
          }

          level.goon_spawners[level.goon_spawners.size] = var_02;
          var_02.volume = var_05;
          if(!isDefined(var_05.goon_spawners)) {
            var_05.goon_spawners = [];
          }

          var_05.goon_spawners[var_05.goon_spawners.size] = var_02;
          break;
        }
      }
    }
  }
}

move_goon_spawner(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getclosest(param_01, param_00, 500);
  var_03.origin = param_02;
}

func_3712() {
  var_00 = 400;
  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_00 = 400;
      break;

    case 2:
      var_00 = 900;
      break;

    case 3:
      var_00 = 1300;
      break;

    default:
      var_00 = 1600;
      break;
  }

  return var_00;
}

func_7CE3() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var_00 = getEntArray(self.target, "targetname");
  if(!isDefined(var_00) || var_00.size == 0) {
    var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  }

  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.remove_me)) {
      var_01[var_01.size] = var_03;
    }
  }

  if(var_01.size > 0) {
    var_00 = scripts\engine\utility::array_remove_array(var_00, var_01);
  }

  return var_00;
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

func_77D3() {
  if(isDefined(level.var_186E[self.basename])) {
    var_00 = [];
    foreach(var_02 in level.var_186E[self.basename]) {
      var_00[var_00.size] = level.var_10817[var_02];
    }

    return var_00;
  }

  return [];
}

func_7999() {
  var_00 = getEntArray(self.destroynavobstacle, "script_noteworthy");
  if(isDefined(var_00) && var_00.size != 0) {
    self.var_665B = var_00;
  }
}

func_4F1E() {
  level endon("game_ended");
  var_00 = getdvarint("scr_spawn_start_delay");
  if(var_00 > 0) {
    wait(var_00);
  }
}

func_1294D() {
  foreach(var_01 in level.active_spawners) {
    var_01.var_19 = 0;
    var_01 notify("dont_restart_spawner");
  }

  level.active_spawners = [];
}

func_AD62() {
  level endon("game_ended");
  for(;;) {
    if(getdvarint("scr_reserve_spawning") > 0) {
      level.var_E1CC = getdvarint("scr_reserve_spawning");
    }

    wait(1);
  }
}

should_spawn_skater() {
  if(isDefined(level.no_clown_spawn)) {
    return 0;
  }

  if(scripts\engine\utility::flag("rk_fight_started")) {
    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "skater") {
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

func_726E() {
  level notify("force_spawn_wave_done");
  wait(0.1);
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

func_5173(param_00) {
  scripts\engine\utility::waittill_any_3("death", "emerge_done");
  if(isDefined(param_00)) {
    param_00 delete();
  }
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

    if(scripts\engine\utility::istrue(self.aj_karatemaster)) {
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

func_FF9D(param_00) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 0;
  }

  if(getdvar("ui_mapname") == "cp_disco") {
    return 0;
  }

  if(param_00 < 5) {
    return 0;
  } else if(scripts\engine\utility::flag_exist("defense_sequence_active") && scripts\engine\utility::flag("defense_sequence_active")) {
    return 0;
  } else if(scripts\engine\utility::flag_exist("all_center_positions_used") && scripts\engine\utility::flag("all_center_positions_used")) {
    return 0;
  } else if(isDefined(level.should_run_event_func)) {
    return [[level.should_run_event_func]](param_00);
  } else {
    var_01 = param_00 - level.last_event_wave;
    if(var_01 < 5) {
      return 0;
    } else {
      var_01 = var_01 - 4;
      var_02 = var_01 / 3 * 100;
      if(randomint(100) < var_02) {
        return 1;
      }
    }
  }

  return 0;
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

  return "goon";
}

func_7B1C() {
  return level.wave_num + 1;
}

func_7D00(param_00, param_01) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 1;
  }

  return 10;
}

func_7CA9(param_00) {
  var_01 = ["generic_zombie"];
  return var_01;
}

get_max_static_enemies(param_00) {
  if(scripts\cp\utility::is_escape_gametype() && param_00 < 5) {
    var_01 = level.players.size * 6;
    var_02 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
    var_03 = 1;
    var_04 = 1;
    var_03 = var_02[param_00];
    var_05 = level.players.size - 1;
    if(var_05 < 1) {
      var_05 = 0.5;
    }

    var_06 = 24 + var_05 * 6 * var_04 * var_03;
    return int(min(var_01, var_06));
  }

  return 24;
}

get_total_spawned_enemies(param_00) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 9000;
  }

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

func_13FA2() {
  foreach(var_01 in level.spawn_volume_array) {
    if(self istouching(var_01)) {
      return 1;
    }
  }

  return 0;
}

cp_disco_cleanup_main() {
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
    case "superslasher":
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

pausenormalwavespawning(param_00) {
  scripts\engine\utility::flag_set("pause_wave_progression");
  if(scripts\engine\utility::istrue(param_00)) {
    level.zombies_paused = 1;
    return;
  }

  level.zombies_paused = 0;
}

setmaxstaticspawns(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 16;
  }

  if(!isDefined(param_01)) {
    param_01 = 24;
  }

  if(!isDefined(param_02)) {
    param_02 = 24;
  }

  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.max_static_spawned_enemies = param_00;
  } else {
    level.max_static_spawned_enemies = param_01;
  }

  level.desired_enemy_deaths_this_wave = 24;
}

unpausenormalwavespawning() {
  scripts\engine\utility::flag_clear("pause_wave_progression");
  level.zombies_paused = 0;
}

storewavespawningcounters() {
  var_00 = spawnStruct();
  var_00.cop_spawn_percent = level.cop_spawn_percent;
  var_00.current_enemy_deaths = level.current_enemy_deaths;
  var_00.max_static_spawned_enemies = level.max_static_spawned_enemies;
  var_00.desired_enemy_deaths_this_wave = level.desired_enemy_deaths_this_wave;
  var_00.wave_num = level.wave_num;
  level.storedspawncounters = var_00;
}

restorewavespawningcounters() {
  var_00 = level.storedspawncounters;
  if(level.wave_num == var_00.wave_num) {
    level.current_enemy_deaths = var_00.current_enemy_deaths;
    level.max_static_spawned_enemies = var_00.max_static_spawned_enemies;
    level.desired_enemy_deaths_this_wave = var_00.desired_enemy_deaths_this_wave;
  } else {
    level.current_enemy_deaths = 0;
    level.max_static_spawned_enemies = get_max_static_enemies(level.wave_num);
    level.desired_enemy_deaths_this_wave = get_total_spawned_enemies(level.wave_num);
  }

  level.storedspawncounters = undefined;
}

waitforvalidwavepause() {
  while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
    wait(0.05);
  }
}

unsetzombiemovespeed() {
  level notify("unsetZombieMoveSpeed");
}

setzombiemovespeed(param_00) {
  level endon("game_ended");
  level notify("unsetZombieMoveSpeed");
  level endon("unsetZombieMoveSpeed");
  foreach(var_02 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isDefined(var_02.agent_type) && var_02.agent_type != "ratking") {
      var_03 = scripts\engine\utility::random(param_00);
      var_02 thread adjustmovespeed(var_02, 0, var_03);
    }
  }

  for(;;) {
    level waittill("agent_spawned", var_05);
    var_03 = scripts\engine\utility::random(param_00);
    var_05 thread adjustmovespeed(var_05, 1, var_03);
  }
}

adjustmovespeed(param_00, param_01, param_02) {
  param_00 endon("death");
  if(isDefined(param_00.agent_type) && param_00.agent_type == "ratking") {
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

setspecialevent() {
  level.special_event = 1;
}

unsetspecialevent() {
  level.special_event = undefined;
}

setspawndelayoverride(param_00) {
  level.spawndelayoverride = param_00;
}

unsetspawndelayoverride(param_00) {
  level.spawndelayoverride = undefined;
}

setwavenumoverride(param_00) {
  level.wave_num_override = param_00;
}

unsetwavenumoverride(param_00) {
  level.wave_num_override = undefined;
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
            if(!isDefined(level.completed_dialogues["sally_end_round_8-12_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("sally_end_round_8-12_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["sally_end_round_8-12_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["aj_end_round_8-12_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("aj_end_round_8-12_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["aj_end_round_8-12_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["andre_end_round_8-12_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("andre_end_round_8-12_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["andre_end_round_8-12_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["pdex_end_round_8-12_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("pdex_end_round_8-12_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["pdex_end_round_8-12_1"] = 1;
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

  if(var_01 >= 16 && var_01 <= 20) {
    if(randomint(100) > 60) {
      var_01 = scripts\engine\utility::random(level.players);
      if(isDefined(var_01.vo_prefix)) {
        switch (var_01.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["sally_end_round_16-20_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("sally_end_round_16-20_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["sally_end_round_16-20_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["aj_end_round_16-20_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("aj_end_round_16-20_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["aj_end_round_16-20_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["andre_end_round_16-20_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("andre_end_round_16-20_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["andre_end_round_16-20_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["pdex_end_round_16-20_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("pdex_end_round_16-20_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["pdex_end_round_16-20_1"] = 1;
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

  if(randomint(100) > 60) {
    if(isDefined(level.spoke_to_pam_first)) {
      var_02 = level.spoke_to_pam_first;
      switch (var_02.vo_prefix) {
        case "p1_":
          if(!isDefined(level.completed_dialogues["sally_will_pam_fight_1"])) {
            var_02 thread scripts\cp\cp_vo::try_to_play_vo("sally_will_pam_fight_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["sally_will_pam_fight_1"] = 1;
          }
          break;

        case "p4_":
          if(!isDefined(level.completed_dialogues["aj_will_pam_fight_1"])) {
            var_02 thread scripts\cp\cp_vo::try_to_play_vo("aj_will_pam_fight_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["aj_will_pam_fight_1"] = 1;
          }
          break;

        case "p3_":
          if(!isDefined(level.completed_dialogues["andre_will_pam_fight_1"])) {
            var_02 thread scripts\cp\cp_vo::try_to_play_vo("andre_will_pam_fight_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["andre_will_pam_fight_1"] = 1;
          }
          break;

        case "p2_":
          if(!isDefined(level.completed_dialogues["pdex_will_pam_fight_1"])) {
            var_02 thread scripts\cp\cp_vo::try_to_play_vo("pdex_will_pam_fight_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["pdex_will_pam_fight_1"] = 1;
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