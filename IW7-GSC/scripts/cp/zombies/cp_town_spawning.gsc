/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_town_spawning.gsc
***************************************************/

cp_town_spawning_init() {
  if(!isDefined(level.zombie_spawn_override_func)) {
    level.zombie_spawn_override_func = [];
  }

  level.zombie_spawn_override_func["crab_brute"] = ::spawn_brute_wave_enemy;
  level thread listen_for_tent_door_open();
  level.crab_mini_debug_spawn_func = ::dbg_spawn_goons;
}

listen_for_tent_door_open() {
  level endon("game_ended");
  level.tent_door_opened = 0;
  for(;;) {
    level waittill("volume_activated", var_00);
    if(var_00 == "drive_in_theater" || var_00 == "drive_in_elvira") {
      break;
    }
  }

  level.tent_door_opened = 1;
}

update_crog_spawners() {
  while(!scripts\engine\utility::flag_exist("init_adjacent_volumes_done")) {
    wait(0.1);
  }

  scripts\engine\utility::flag_wait("init_adjacent_volumes_done");
  var_00 = scripts\engine\utility::getstructarray("dog_spawner", "targetname");
  var_01 = ["morgue", "supermarket"];
  foreach(var_03 in level.goon_spawners) {
    if(!isDefined(var_03.volume)) {
      continue;
    }

    if(!isDefined(var_03.volume.basename)) {
      continue;
    }

    foreach(var_05 in var_01) {
      if(var_03.volume.basename == var_05) {
        level.goon_spawners = scripts\engine\utility::array_remove(level.goon_spawners, var_03);
        var_03.volume.goon_spawners = scripts\engine\utility::array_remove(var_03.volume.goon_spawners, var_03);
      }
    }

    wait(0.1);
  }
}

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
  var_02 = 1;
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

brute_goon_summon() {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  var_00 = get_num_guys_to_brute_spawn();
  var_00 = min(self.spawnpoints.size, var_00);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_00);
  wait(1);
  brute_goon_spawn_loop(var_00);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_00);
}

get_num_guys_to_brute_spawn() {
  var_00 = num_goons_to_spawn();
  var_01 = getdvar("crab_brute_action", "none");
  if(var_01 == "summon") {
    var_00 = 2;
  }

  var_00 = min(var_00, level.players.size + 1);
  if(var_00 <= 0) {
    var_02 = 0;
    foreach(var_04 in level.spawned_enemies) {
      if(isDefined(var_04.agent_type) && var_04.agent_type == "generic_zombie") {
        var_02++;
      }
    }

    if(var_02 < 2) {
      var_02 = 0;
    }

    var_00 = min(2, var_02);
  }

  return var_00;
}

brute_goon_spawn_loop(param_00) {
  for(var_01 = 0; var_01 < param_00; var_01++) {
    var_02 = get_spawner_and_spawn_goons(1);
    wait(0.1);
  }
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
  return ["crab_mini"];
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

get_spawner_and_spawn_goons(param_00) {
  var_01 = 0;
  if(param_00 <= 0) {
    if(param_00 < 0) {
      scripts\cp\zombies\zombies_spawning::func_A5FA(abs(param_00));
    }

    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "crab_mini") {
      param_00 = 1;
    }
  }

  var_02 = min(param_00, 1);
  spawn_goons_from_eggs(var_02);
  return var_02;
}

spawn_goons_from_eggs(param_00) {
  var_01 = 0.3;
  var_02 = 0.7;
  if(param_00 > 0) {
    scripts\cp\zombies\zombies_spawning::func_93E6(param_00);
    var_03 = [];
    var_04 = 0;
    while(var_04 < param_00) {
      var_05 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
      var_05.in_use = 1;
      var_05.lastspawntime = gettime();
      var_06 = func_10719(var_05);
      if(isDefined(var_06)) {
        var_04++;
        wait(randomfloatrange(var_01, var_02));
      }

      var_05.in_use = 0;
    }
  }
}

dbg_spawn_goons(param_00, param_01) {
  var_02 = 0.3;
  var_03 = 0.7;
  var_04 = 1;
  if(var_04 > 0) {
    scripts\cp\zombies\zombies_spawning::func_93E6(var_04);
    var_05 = [];
    var_06 = 0;
    while(var_06 < var_04) {
      var_07 = undefined;
      var_08 = level.goon_spawners;
      var_07 = scripts\cp\zombies\zombies_spawning::_meth_8456(var_08);
      var_08 = sortbydistance(var_08, param_00);
      var_09 = 0;
      var_0A = cos(70);
      var_0B = 500;
      var_0C = var_0B * var_0B;
      while(var_09 < var_08.size) {
        if(distancesquared(param_00, var_08[var_09].origin) > var_0C) {
          break;
        }

        if(!scripts\engine\utility::within_fov(param_00, param_01, var_08[var_09].origin, var_0A)) {
          var_09++;
          continue;
        }

        var_07 = var_08[var_09];
        break;
        wait(0.1);
      }

      if(!isDefined(var_07)) {
        return;
      }

      var_07.volume scripts\cp\zombies\zombies_spawning::make_volume_active();
      level thread scripts\cp\utility::drawsphere(var_07.origin, 20, 3, (0, 1, 0));
      var_07.in_use = 1;
      var_07.lastspawntime = gettime();
      var_0D = func_10719(var_07);
      if(isDefined(var_0D)) {
        var_06++;
        wait(randomfloatrange(var_02, var_03));
      }

      var_07.in_use = 0;
    }
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
  var_01 = param_00.origin;
  var_02 = param_00.angles;
  var_03 = get_fake_crab_boss_spawner();
  if(isDefined(level.crab_boss)) {
    var_04 = level.agenttunedata["crab_boss"].egg_sack_launching_tags;
    var_05 = scripts\engine\utility::array_randomize(var_04);
    var_06 = randomint(var_05.size);
    var_07 = level.crab_boss;
    var_03 = var_07 gettagorigin(var_05[var_06]);
  }

  var_08 = launch_egg_sac(var_03, var_01, 7, 1, var_02);
  var_09 = "crab_mini";
  if(isDefined(var_08)) {
    update_respawn_data(var_09);
    param_00.lastspawntime = gettime();
  }

  return var_08;
}

get_fake_crab_boss_spawner() {
  var_00 = [(4492, 6602, -257), (3362, 6854, -257), (4292, 6602, -257), (3362, 6654, -257)];
  var_01 = scripts\engine\utility::random(var_00);
  return var_01;
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

launch_egg_sac(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "cp_town_temp_egg_sac_green";
  param_01 = getclosestpointonnavmesh(param_01);
  var_06 = spawn("script_model", param_00);
  var_06 setModel(var_05);
  var_06 playSound("boss_crog_fire_egg_launch");
  var_06 thread scripts\cp\maps\cp_town\cp_town_crab_boss_escort::egg_sac_or_bomb_incoming_delayed(param_02);
  var_06 thread egg_sac_damage_monitor(var_06, param_03);
  var_06 thread egg_sac_fly(var_06, param_00, param_01, param_02, param_03, param_04);
  return var_06;
}

egg_sac_damage_monitor(param_00, param_01) {
  param_00 endon("death");
  param_00.health = 999999;
  param_00.fake_health = 100;
  param_00 setCanDamage(1);
  for(;;) {
    param_00 waittill("damage", var_02, var_03);
    param_00.health = 999999;
    param_00.fake_health = param_00.fake_health - var_02;
    if(isplayer(var_03)) {
      scripts\cp\maps\cp_town\cp_town_crab_boss_escort::show_hit_marker(param_00, var_03);
    }

    if(param_00.fake_health < 0) {
      break;
    }
  }

  if(isDefined(var_03) && isplayer(var_03)) {
    var_03 scripts\cp\cp_merits::processmerit("mt_dlc3_eggs_killed");
    level.current_enemy_deaths = level.current_enemy_deaths + 1;
  }

  scripts\cp\zombies\zombies_spawning::func_4FB6(1);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_damage_explosion_fx(param_00, param_01);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::delete_egg_sac(param_00);
}

egg_sac_fly(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  var_06 = 386.09;
  scripts\engine\utility::waitframe();
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::show_flying_trail(param_00, param_04);
  var_07 = var_06 * (0, 0, -1);
  var_08 = trajectorycalculateinitialvelocity(param_01, param_02, var_07, param_03);
  var_09 = param_03 * 20;
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_launch_muzzle_flash(param_01, var_08, param_04);
  for(var_0A = 1; var_0A <= var_09; var_0A++) {
    var_0B = var_0A / 20;
    var_0C = 0.5 * var_07 * var_0B * var_0B + var_08 * var_0B + param_01;
    param_00.origin = var_0C;
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  var_0D = egg_sac_landing_sequence(param_00, param_02, param_04, param_05);
  return var_0D;
}

egg_sac_landing_sequence(param_00, param_01, param_02, param_03) {
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::do_earthquake(param_01);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::do_radius_damage(param_00, param_01);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_landing_explosion(param_01, param_02);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::hide_flying_trail(param_00);
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::hide_landing_marker(param_00);
  var_04 = param_00 egg_sac_spawn(param_00, param_01, param_03);
  return var_04;
}

egg_sac_spawn(param_00, param_01, param_02) {
  param_00 endon("death");
  playFX(level._effect["egg_sac_hatching"], param_00.origin);
  var_03 = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::make_egg_sac_spawner(param_01, param_02);
  var_04 = var_03 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("crab_mini", 1, var_03);
  if(isDefined(var_04)) {
    adjust_crab_mini_health(var_04);
    var_04 thread crab_mini_audio_monitor();
  }

  scripts\cp\zombies\zombies_spawning::func_4FB6(1);
  thread scripts\cp\maps\cp_town\cp_town_crab_boss_escort::delete_egg_sac(param_00);
  return var_04;
}

adjust_crab_mini_health(param_00) {
  param_00.health = scripts\mp\agents\crab_mini\crab_mini_agent::calculatecrabminihealth();
}

crab_mini_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  self.voprefix = "minion_crog_";
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix, undefined, 1);
  self.playing_stumble = 0;
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "attack_miss", "attack_charge");
    switch (var_00) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "alert", 0);
        break;

      case "attack_miss":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "alert", 0);
        break;

      case "attack_charge":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "alert", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "idle", 0);
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

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "crab_mini") {
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

  if(isDefined(param_00.scripted_mode)) {
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

  if(param_00 >= 10 && param_00 <= 16) {
    if(randomint(100) > 60) {
      var_01 = scripts\engine\utility::random(level.players);
      if(isDefined(var_01.vo_prefix)) {
        switch (var_01.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["sally_end_round_10_16_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("sally_end_round_10_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["sally_end_round_10_16_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["aj_end_round_10_16_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("aj_end_round_10_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["aj_end_round_10_16_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["andre_end_round_10_16_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("andre_end_round_10_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["andre_end_round_10_16_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["pdex_end_round_10_16_1"])) {
              var_01 thread scripts\cp\cp_vo::try_to_play_vo("pdex_end_round_10_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["pdex_end_round_10_16_1"] = 1;
            }
            break;

          default:
            break;
        }

        return;
      }
    }
  }
}

boss_spawn_vo() {
  if(scripts\engine\utility::flag("elvira_summoned") || isDefined(level.elvira_ai)) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_crog_spawn_elvira", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  }

  var_00 = scripts\cp\cp_vo::get_sound_length("ww_crog_spawn_elvira3");
  var_01 = scripts\engine\utility::random(level.players);
  if(isDefined(var_01.vo_prefix)) {
    switch (var_01.vo_prefix) {
      case "p1_":
        level thread scripts\cp\cp_vo::try_to_play_vo("sally_boss_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p2_":
        level thread scripts\cp\cp_vo::try_to_play_vo("pdex_boss_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p3_":
        level thread scripts\cp\cp_vo::try_to_play_vo("andre_boss_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p4_":
        level thread scripts\cp\cp_vo::try_to_play_vo("aj_boss_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      default:
        break;
    }
  }
}

cp_town_boss_spawn() {
  level thread boss_spawn_vo();
  var_00 = undefined;
  var_01 = get_scored_goon_spawn_location();
  if(isDefined(var_01)) {
    var_02 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
    var_00 = var_02 spawn_brute_wave_enemy("crab_brute");
    if(!isDefined(var_00)) {
      return 0;
    }

    var_01.in_use = 1;
    level.var_A88E = level.wave_num;
    func_3115(var_01);
    var_00 move_to_spot(var_01);
    var_01.in_use = 0;
  } else {
    return 0;
  }

  level notify("boss_spawned", var_00);
  if(scripts\engine\utility::flag("force_spawn_boss")) {
    var_00.var_72AC = 1;
  }

  var_00 thread scripts\cp\zombies\zombies_spawning::killplayersifonhead(var_00);
  return 1;
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
  var_07 thread func_310F();
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
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

func_310F() {
  level endon("game_ended");
  self endon("death");
  self.voprefix = "brute_crog_";
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

func_3115(param_00) {
  var_01 = level._effect["brute_spawn_bolt"];
  thread scripts\cp\utility::playsoundinspace("brute_spawn_lightning", param_00.origin);
  playFX(var_01, param_00.origin);
  playFX(level._effect["drone_ground_spawn"], param_00.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", param_00.origin);
  earthquake(0.3, 0.2, param_00.origin, 500);
}