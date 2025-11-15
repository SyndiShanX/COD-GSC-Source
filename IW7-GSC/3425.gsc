/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3425.gsc
***************************************/

enemy_spawner_init() {
  func_97B9();
  func_97AE();
  func_97B8();
  level.func_5F90 = [];
  level.func_10E44 = [];
  level.current_num_spawned_enemies = 0;
  level.func_4B6B = 0;
  level.func_E1CC = 0;
  level.func_50F8 = 0;
  level.respawning_enemies = 0;
  level.desired_enemy_deaths_this_wave = 0;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.dynamic_enemy_types = ["generic_zombie"];
  level.func_BFB7 = 200;
  level.func_1BF5 = scripts\engine\utility::getstructarray("spawner_location", "targetname");
  level.func_1002D = ::func_FF55;
  level.stop_spawning = 1;
  level.func_B433 = 20;
  level.spawned_enemies = [];
  level.func_8CB3 = [];
  level.respawn_enemy_list = [];
  kvp_update_init();

  if(isDefined(level.patch_update_spawners))
    [[level.patch_update_spawners]]();

  func_975C();
  func_9757();
  level thread func_F8A7();
  level thread func_F5EC();
  level thread func_7D87();
  level.func_17C4 = [];
  level.func_17C4[1] = 0;
  level.func_17C4[2] = 0;
  level.func_17C4[3] = 0;
  level.func_17C4[4] = 0;
  level.func_CA07 = 0;
  level.func_CA06 = 0;
  level.func_CA05 = 0;
  level.func_4CC7 = 0;

  if(!isDefined(level.func_106DB))
    level.func_106DB = [];

  level.active_spawn_volumes = [];
  level.active_spawners = [];
  level.func_162C = [];
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  level.spawnloopupdatefunc = ::func_12E29;
  level.func_13F39 = "zmb_vo_base_male_";
  level.func_13F3A = "zmb_vo_base_male2_";
  level.func_13F24 = "zmb_vo_base_female_";
  level.func_13F14 = "zmb_vo_brute_";
  level.func_13F1A = "zmb_vo_cop_";
  level.func_13F18 = "zmb_vo_clown_";
  level.last_clown_spawn_time = gettime();
  level.wait_for_music_clown_wave = 0;
  level.last_mini_zone_fail = 0;
}

func_97B9() {
  scripts\engine\utility::flag_init("init_spawn_volumes_done");
  scripts\engine\utility::flag_init("init_adjacent_volumes_done");
  scripts\engine\utility::flag_init("force_spawn_boss");
  scripts\engine\utility::flag_init("pause_wave_progression");
}

func_97B8() {
  level._effect["drone_ground_spawn"] = loadfx("vfx\old\_requests\cp_titan\vfx_alien_drone_ground_spawn_titan.vfx");
}

func_97AE() {
  scripts\cp\zombies\zombie_armor::func_97AF();
}

func_975C() {
  level.spawn_volume_array = getEntArray("spawn_volume", "targetname");
  level.invalid_spawn_volume_array = getEntArray("invalid_playspace", "targetname");
  level.active_player_respawn_locs = [];
  var_00 = [];

  foreach(var_02 in level.spawn_volume_array) {
    var_2.basename = func_7859(var_02);
    level.func_10817[var_2.basename] = var_02;

    if(!scripts\cp\utility::is_escape_gametype()) {
      var_02 func_7C8E();
      var_02 func_7999();
    }

    var_2.active = 0;
    var_0[var_2.basename] = var_02;
    wait 0.1;
  }

  level.spawn_volume_array = var_00;
  scripts\engine\utility::flag_set("init_spawn_volumes_done");
}

func_F8A7() {
  func_94D5();
}

func_975D() {
  if(!scripts\engine\utility::flag("init_spawn_volumes_done"))
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");

  level.func_10818 = getEntArray("spawn_volume_trigger", "targetname");

  if(!isDefined(level.func_10818)) {
    return;
  }
  foreach(var_01 in level.func_10818) {
    var_01 thread func_15FD();
    wait 0.1;
  }
}

func_15FD() {
  level endon("game_ended");
  self.volume = self.script_area;

  for(;;) {
    self waittill("trigger", var_00);

    if(!isplayer(var_00)) {
      continue;
    }
    break;
  }

  activate_volume_by_name(self.volume);
}

func_A5BC() {
  foreach(var_01 in level.spawned_enemies)
  var_01 getrandomarmkillstreak(var_1.health + 990, var_1.origin, var_01, var_01, "MOD_SUICIDE");
}

func_7859(var_00) {
  var_01 = strtok(var_0.script_linkname, "_");

  if(var_1.size < 2)
    var_02 = var_1[0];
  else if(scripts\engine\utility::string_starts_with(var_1[0], "pf")) {
    var_02 = var_1[1];

    for(var_03 = 2; var_03 < var_1.size; var_3++)
      var_02 = var_02 + "_" + var_1[var_03];
  } else
    var_02 = var_0.script_linkname;

  return var_02;
}

func_9757() {
  level.spawn_event_running = 0;
  level.last_event_wave = 0;
  level.specialroundcounter = 0;
  level.zombie_killed_loot_func = ::func_5CF7;
  init_event_waves();
  func_9605();
}

init_event_waves() {
  level.event_funcs = [];

  if(isDefined(level.event_funcs_init))
    [[level.event_funcs_init]]();
  else {
    level.event_funcs["goon"] = ::goon_spawn_event_func;
    func_9608();
  }
}

func_B26D() {
  if(!is_in_array(level.func_162C, self))
    level.func_162C[level.func_162C.size] = self;

  self.active = 1;
  self.in_use = 0;
}

func_B26E() {
  self.active = 0;
}

goon_spawn_event_func() {
  level.static_enemy_types = func_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = _meth_8455();
  level.current_enemy_deaths = 0;

  while(level.wait_for_music_clown_wave == 0)
    wait 0.1;

  func_1071B();
}

func_5CF7(var_00, var_01, var_02) {
  if(isDefined(level.force_drop_loot_item)) {
    level thread scripts\cp\loot::drop_loot(var_01, var_02, level.force_drop_loot_item);
    level.force_drop_loot_item = undefined;
    return 1;
  }

  if(level.spawn_event_running == 1) {
    if(level.desired_enemy_deaths_this_wave == level.current_enemy_deaths) {
      level thread scripts\cp\loot::drop_loot(var_01, var_02, "ammo_max");
      return 1;
    } else
      return 0;
  } else
    return 0;
}

func_79EB() {
  return ["generic_zombie"];
}

func_79E9() {
  return ["zombie_ghost"];
}

_meth_8454(var_00, var_01) {
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
  }

  var_02 = var_02 - var_00 / var_01;
  var_02 = max(var_02, 0.05);
  return var_02;
}

_meth_826F() {
  var_00 = 0.5;
  return var_00;
}

_meth_8455() {
  var_00 = level.players.size;
  var_01 = var_00 * 6;
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
      var_01 = var_00 * 12;
      var_02 = 3;
      break;
    default:
      var_01 = var_00 * 15;
      var_02 = 3;
  }

  var_01 = var_01 * var_02;
  return var_01;
}

rotatevelocity() {
  var_00 = level.players.size;
  return 8 + 4 * var_00;
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
    while(scripts\engine\utility::is_true(level.zombies_paused) || scripts\engine\utility::is_true(level.nuke_zombies_paused))
      scripts\engine\utility::waitframe();

    var_01 = num_goons_to_spawn();
    var_02 = get_spawner_and_spawn_goons(var_01);
    var_00 = var_00 + var_02;

    if(var_02 > 0) {
      wait(_meth_8454(var_00, level.desired_enemy_deaths_this_wave));
      continue;
    }

    wait 0.1;
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

get_spawner_and_spawn_goons(var_00) {
  if(isDefined(level.special_zombie_spawn_func)) {
    var_01 = [[level.special_zombie_spawn_func]](var_00);
    return var_01;
  }

  var_02 = 0;

  if(var_00 <= 0) {
    if(var_00 < 0)
      func_A5FA(abs(var_00));

    return 0;
  }

  var_01 = min(var_00, 2);
  func_1071C(var_01);
  return var_01;
}

spawn_ghosts() {
  level endon("game_ended");
  level endon("stop_ghost_spawn");
  var_00 = 24;
  var_01 = _meth_826F();

  for(;;) {
    var_02 = func_7C2D();

    if(isDefined(var_02)) {
      var_2.in_use = 1;
      var_2.lastspawntime = gettime();
      var_03 = var_00 - level.zombie_ghosts.size;
      level thread func_10718(var_02, var_03);
    }

    wait(var_01);
  }
}

func_1071C(var_00) {
  var_01 = 0.3;
  var_02 = 0.7;

  if(var_00 > 0) {
    func_93E6(var_00);
    var_03 = [];
    var_04 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
    var_05 = 0;

    while(var_05 < var_00) {
      var_06 = func_10719(var_04);

      if(isDefined(var_06)) {
        var_5++;
        var_06 give_mp_super_weapon(var_6.origin);
        var_06 scripts\anim\notetracks_mp::setstatelocked(1, "spawn_in_box");
        var_6.ignoreall = 1;
        var_6.ignoreme = 1;
        var_6.scripted_mode = 1;
        var_3[var_3.size] = var_06;
      }

      wait 0.1;
    }

    var_07 = get_scored_goon_spawn_location();
    var_7.in_use = 1;
    var_7.lastspawntime = gettime();
    thread scripts\cp\utility::playsoundinspace("zombie_spawn_lightning", var_7.origin);

    for(var_08 = 0; var_08 < var_3.size; var_8++) {
      var_06 = var_3[var_08];
      var_09 = func_772C(var_7.origin, var_7.angles);
      var_6.spawner = var_09;
      func_1B99(var_6.spawner);
      var_06 move_to_spot(var_6.spawner);
      var_6.ignoreme = 0;
      var_6.scripted_mode = 0;
      var_06 scripts\anim\notetracks_mp::setstatelocked(0, "spawn_in_box");
      var_09 = undefined;
      func_4FB6(1);
      wait(randomfloatrange(var_01, var_02));
    }

    var_7.in_use = 0;
  }
}

move_to_spot(var_00) {
  var_01 = getclosestpointonnavmesh(var_0.origin);
  self dontinterpolate();
  self setorigin(var_0.origin, 1);
  self ghostskulls_complete_status(var_0.origin);
  self.ignoreall = 0;
}

func_10718(var_00, var_01) {
  level endon("game_ended");
  level endon("stop_ghost_spawn");
  var_02 = 1;
  var_03 = 1;
  var_04 = 0.3;
  var_05 = 0.7;
  var_06 = var_0.origin;
  var_07 = var_0.angles;
  var_08 = min(var_01, randomintrange(var_02, var_03 + 1));

  for(var_09 = 0; var_09 < var_08; var_9++) {
    func_10713(var_00);
    wait(randomfloatrange(var_04, var_05));
    var_00 = func_772C(var_06, var_07);
  }
}

func_772C(var_00, var_01) {
  var_02 = 50;
  var_03 = 50;
  var_04 = spawnStruct();
  var_4.angles = var_01;
  var_05 = var_4.origin;
  var_06 = 0;

  while(!var_06) {
    var_07 = randomintrange(var_02 * -1, var_02);
    var_08 = randomintrange(var_03 * -1, var_03);
    var_05 = getclosestpointonnavmesh((var_0[0] + var_07, var_0[1] + var_08, var_0[2]));
    var_06 = 1;

    foreach(var_10 in level.players) {
      if(positionwouldtelefrag(var_05))
        var_06 = 0;
    }

    if(!var_06)
      wait 0.1;
  }

  var_4.origin = var_05 + (0, 0, 5);
  return var_04;
}

func_10719(var_00) {
  var_01 = "zombie_clown";
  var_02 = var_00 func_1068A();

  if(isDefined(var_02)) {
    var_2.voprefix = level.func_13F18;
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_02, "spawn", 1);
    var_02 setavoidanceradius(4);
    var_0.lastspawntime = gettime();
  }

  return var_02;
}

func_10713(var_00) {
  if(isDefined(level.zombie_ghost_color_manager))
    [[level.zombie_ghost_color_manager]]();

  var_01 = func_13F2A("zombie_ghost", "axis", var_0.origin, var_0.angles);

  if(isDefined(var_01)) {
    level.zombie_ghosts[level.zombie_ghosts.size] = var_01;
    var_0.lastspawntime = gettime();
  }
}

func_E82B() {
  self endon("death");

  for(;;) {
    var_00 = length(self.velocity);

    if(var_00 > 350)
      iprintln("speed = " + var_00);

    wait 0.25;
  }
}

func_1B99(var_00) {
  if(ispointinvolume(var_0.origin, level.func_10817["underground_route"]))
    var_01 = level._effect["goon_spawn_bolt_underground"];
  else
    var_01 = level._effect["goon_spawn_bolt"];

  playFX(var_01, var_0.origin);
  playFX(level._effect["drone_ground_spawn"], var_0.origin, (0, 0, 1));
  playrumbleonentity("grenade_rumble", var_0.origin);
  earthquake(0.3, 0.2, var_0.origin, 500);
}

func_3115(var_00) {
  if(ispointinvolume(var_0.origin, level.func_10817["underground_route"]))
    var_01 = level._effect["brute_spawn_bolt_indoor"];
  else
    var_01 = level._effect["brute_spawn_bolt"];

  thread scripts\cp\utility::playsoundinspace("brute_spawn_lightning", var_0.origin);
  playFX(var_01, var_0.origin);
  playFX(level._effect["drone_ground_spawn"], var_0.origin, (0, 0, 1));
  playrumbleonentity("grenade_rumble", var_0.origin);
  earthquake(0.3, 0.2, var_0.origin, 500);
}

num_goons_to_spawn() {
  var_00 = num_zombies_available_to_spawn();
  return var_00;
}

func_FF95() {
  var_00 = num_zombies_available_to_spawn();

  if(var_00 > 0)
    return !(level.func_C1E7 + level.current_enemy_deaths + level.current_num_spawned_enemies >= level.desired_enemy_deaths_this_wave);

  return 0;
}

get_scored_goon_spawn_location() {
  var_00 = undefined;
  var_00 = func_79EC();
  return var_00;
}

func_79EC() {
  var_00 = [];

  foreach(var_02 in level.func_162C) {
    if(scripts\engine\utility::is_true(var_2.active) && !scripts\engine\utility::is_true(var_2.in_use))
      var_0[var_0.size] = var_02;
  }

  if(var_0.size > 0) {
    var_02 = _meth_8456(var_00);

    if(isDefined(var_02))
      return var_02;
  }

  return scripts\engine\utility::random(var_00);
}

_meth_8456(var_00) {
  var_01 = [];
  var_02 = 2;
  var_03 = 1;
  var_04 = 5000;

  foreach(var_06 in var_00) {
    if(scripts\cp\zombies\func_0D60::allowedstances(var_6.volume)) {
      var_1[var_1.size] = var_06;
      var_6.modifiedspawnpoints = var_02;
      continue;
    }

    if(isDefined(var_6.volume.func_186E)) {
      foreach(var_08 in var_6.volume.func_186E) {
        if(scripts\cp\zombies\func_0D60::allowedstances(var_08)) {
          var_1[var_1.size] = var_06;
          var_6.modifiedspawnpoints = var_03;
          break;
        }
      }
    }
  }

  var_11 = 562500;
  var_12 = 4000000;
  var_13 = 9000000;
  var_14 = 122500;
  var_15 = 40000;
  var_16 = -99999999;
  var_17 = undefined;
  var_18 = 15000;
  var_19 = 40000;
  var_20 = " ";
  var_21 = undefined;
  var_22 = gettime();
  var_23 = getvalidplayersinarray();
  var_24 = [];

  if(!isDefined(var_23))
    return undefined;

  foreach(var_06 in var_01) {
    var_21 = "";
    var_26 = 0;
    var_27 = var_6.modifiedspawnpoints * randomintrange(var_18, var_19);
    var_28 = randomint(100);

    if(isDefined(var_6.func_BF6C) && var_6.func_BF6C >= var_22) {
      var_26 = var_26 - 20000;
      var_21 = var_21 + " Short Cooldown";
    }

    var_29 = distancesquared(var_23.origin, var_6.origin);

    if(var_29 < var_14) {
      var_26 = var_26 - 50000;
      var_21 = var_21 + " Too Close";
    } else if(var_29 > var_13) {
      var_26 = var_26 - 50000;
      var_21 = var_21 + " Too Far";
    } else if(var_29 < var_11) {
      if(var_28 < max(int(level.specialroundcounter + 1) * 10, 20)) {
        var_26 = var_26 + var_27;
        var_21 = var_21 + " Chance Close";
      } else {
        var_26 = var_26 - var_27;
        var_21 = var_21 + " Close";
      }
    } else if(var_29 > var_12) {
      var_26 = var_26 - var_27;
      var_21 = var_21 + " Far";
    } else {
      var_26 = var_26 + var_27;
      var_21 = var_21 + " Good Spawn";
    }

    if(var_26 > var_16) {
      var_16 = var_26;
      var_17 = var_06;
      var_20 = var_21;
      var_24[var_24.size] = var_06;
    }
  }

  if(!isDefined(var_17))
    return undefined;

  for(var_31 = var_24.size - 1; var_31 >= 0; var_31--) {
    var_32 = 1;

    foreach(var_23 in level.players) {
      if(distancesquared(var_23.origin, var_24[var_31].origin) < var_15) {
        var_32 = 0;
        break;
      }
    }

    if(var_32) {
      var_17 = var_24[var_31];
      break;
    }
  }

  var_17.func_BF6C = var_22 + var_04;
  return var_17;
}

getvalidplayersinarray() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(!isalive(var_02)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_2.linked_to_coaster)) {
      continue;
    }
    var_0[var_0.size] = var_02;
  }

  return scripts\engine\utility::random(var_00);
}

func_7C2D() {
  var_00 = undefined;
  var_00 = func_79EA();
  return var_00;
}

func_79EA() {
  var_00 = [];

  foreach(var_02 in level.rotateyaw) {
    if(scripts\engine\utility::is_true(var_2.active))
      var_0[var_0.size] = var_02;
  }

  if(isDefined(level.zombies_spawn_score_func) && var_0.size > 0)
    return [[level.zombies_spawn_score_func]](var_00);

  return var_00;
}

func_9608() {
  level.goon_spawners = [];
  var_00 = scripts\engine\utility::getstructarray("dog_spawner", "targetname");

  if(isDefined(level.goon_spawner_patch_func))
    [[level.goon_spawner_patch_func]](var_00);

  foreach(var_02 in var_00) {
    var_03 = 0;

    foreach(var_05 in level.invalid_spawn_volume_array) {
      if(ispointinvolume(var_2.origin, var_05))
        var_03 = 1;
    }

    if(!var_03) {
      foreach(var_05 in level.spawn_volume_array) {
        if(ispointinvolume(var_2.origin, var_05)) {
          if(!isDefined(var_2.angles))
            var_2.angles = (0, 0, 0);

          level.goon_spawners[level.goon_spawners.size] = var_02;
          var_2.volume = var_05;

          if(!isDefined(var_5.goon_spawners))
            var_5.goon_spawners = [];

          var_5.goon_spawners[var_5.goon_spawners.size] = var_02;
          break;
        }
      }
    }
  }
}

move_goon_spawner(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::getclosest(var_01, var_00, 500);
  var_3.origin = var_02;
}

func_9605() {
  level.rotateyaw = [];
  var_00 = scripts\engine\utility::getstructarray("ghost_spawn", "targetname");

  foreach(var_02 in var_00) {
    var_2.active = 1;

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    level.rotateyaw[level.rotateyaw.size] = var_02;
  }
}

func_1B98(var_00, var_01, var_02, var_03) {
  var_04 = scripts\cp\cp_agent_utils::func_179E("axis", var_01, var_02, "wave " + var_00);

  if(!isDefined(var_04))
    return undefined;

  if(scripts\engine\utility::is_true(level.func_68AA)) {
    var_4.maxhealth = func_3712();
    var_4.health = var_4.maxhealth;
    var_4.voprefix = level.func_13F18;
  }

  if(var_4.agent_type == "elite") {
    var_4.maxhealth = 15000 * level.player.size;
    var_4.health = var_4.maxhealth;
    earthquake(0.3, 5, var_4.origin, 3000);
  }

  if(isDefined(var_03))
    var_4.spawner = var_03;

  return var_04;
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
  }

  return var_00;
}

func_7CE3() {
  if(!isDefined(self.target))
    return undefined;

  var_00 = getEntArray(self.target, "targetname");

  if(!isDefined(var_00) || var_0.size == 0)
    var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");

  var_01 = [];

  foreach(var_03 in var_00) {
    if(isDefined(var_3.remove_me))
      var_1[var_1.size] = var_03;
  }

  if(var_1.size > 0)
    var_00 = scripts\engine\utility::array_remove_array(var_00, var_01);

  return var_00;
}

update_origin(var_00, var_01, var_02) {
  if(!isDefined(level.spawn_struct_list))
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");

  foreach(var_04 in level.spawn_struct_list) {
    if(var_4.origin == var_00) {
      var_4.origin = var_01;

      if(isDefined(var_02))
        var_4.angles = var_02;

      break;
    }
  }
}

remove_origin(var_00) {
  if(!isDefined(level.spawn_struct_list))
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");

  foreach(var_02 in level.spawn_struct_list) {
    if(var_2.origin == var_00) {
      var_2.remove_me = 1;
      break;
    }
  }
}

update_kvp(var_00, var_01, var_02) {
  if(!isDefined(level.spawn_struct_list))
    level.spawn_struct_list = scripts\engine\utility::getstructarray("static", "script_noteworthy");

  foreach(var_04 in level.spawn_struct_list) {
    if(var_4.origin == var_00) {
      var_04 = [
        [level.kvp_update_funcs[var_01]]
      ](var_04, var_02);
      break;
    }
  }
}

kvp_update_init() {
  level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

update_kvp_script_fxid(var_00, var_01) {
  var_0.script_fxid = var_01;
  return var_00;
}

func_77D3() {
  if(isDefined(level.func_186E[self.basename])) {
    var_00 = [];

    foreach(var_02 in level.func_186E[self.basename])
    var_0[var_0.size] = level.func_10817[var_02];

    return var_00;
  }

  return [];
}

func_7C8E() {
  var_00 = func_7CE3();

  if(isDefined(var_00) && var_0.size > 0) {
    self.spawners = var_00;

    foreach(var_02 in self.spawners)
    var_02 func_10865(self);
  }

  func_F546(self);
}

func_7999() {
  var_00 = getEntArray(self.script_linkname, "script_noteworthy");

  if(isDefined(var_00) && var_0.size != 0)
    self.func_665B = var_00;
}

enemy_spawning_run() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag("init_spawn_volumes_done"))
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");

  while(!scripts\engine\utility::is_true(level.introscreen_done))
    wait 1;

  if(!scripts\cp\utility::is_escape_gametype())
    wait 15;
  else
    wait 1;

  if(!scripts\cp\utility::is_escape_gametype())
    func_15BA();

  level thread func_10D2E();
}

func_4F1E() {
  level endon("game_ended");
  var_00 = getdvarint("scr_spawn_start_delay");

  if(var_00 > 0)
    wait(var_00);
}

func_15BA() {
  if(isDefined(level.initial_active_volumes)) {
    foreach(var_01 in level.initial_active_volumes) {
      if(isDefined(level.spawn_volume_array[var_01]))
        level.spawn_volume_array[var_01] make_volume_active();
    }
  }
}

func_10865(var_00) {
  self.active = 0;
  self.volume = var_00;
  level.func_1BF5[level.func_1BF5.size] = self;

  if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "static")
    level.func_5F90[level.func_5F90.size] = self;
  else {
    self.func_10E45 = 1;
    level.func_10E44[level.func_10E44.size] = self;
  }

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(ispointinvolume(self.origin, var_00))
    self.func_93A1 = 1;
  else
    self.func_93A1 = 0;

  if(isDefined(self.script_animation)) {
    switch (self.script_animation) {
      case "spawn_ground":
        thread func_5D13();
        break;
      case "spawn_ceiling":
        thread func_B0D1();
        break;
      case "spawn_wall_low":
        self.func_1CAE = 1;
    }
  }
}

func_5D13() {
  var_00 = scripts\engine\utility::drop_to_ground(self.origin, 10);
  self.origin = var_00 + (0, 0, 1);
}

func_B0D1() {
  self.func_ABA7 = self.origin;
  var_00 = scripts\engine\utility::drop_to_ground(self.origin, 0);
  self.func_ABA6 = var_00;
}

escape_room_init() {
  if(!scripts\engine\utility::flag_exist("init_spawn_volumes_done"))
    scripts\engine\utility::flag_init("init_spawn_volumes_done");

  if(!scripts\engine\utility::flag("init_spawn_volumes_done"))
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");

  level.func_1BF5 = [];
  level.func_671F = [];
  level.active_spawners = [];
  level.func_6727 = "escape_path_0_start";
  level.func_4B3F = level.func_6727;
  scripts\engine\utility::flag_init("escape_room_triggers_spawned");
  level thread func_106D8();
  level thread func_66DA();
}

func_106D8() {
  var_00 = scripts\engine\utility::getstructarray("escape_spawn_trigger", "targetname");

  foreach(var_02 in var_00) {
    var_03 = spawn("trigger_radius", var_2.origin, 0, var_2.radius, 96);
    var_3.targetname = var_2.targetname;
    var_3.script_area = var_2.script_area;
    var_3.target = var_2.target;
    wait 0.05;
  }

  var_05 = getEntArray("escape_spawn_trigger", "targetname");

  foreach(var_03 in var_05)
  var_03 thread func_6730();
}

func_6730() {
  self.func_E6DB = self.script_area;
  level.func_4BD4 = 0;

  if(self.func_E6DB == level.func_6727)
    thread func_6731();

  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");

  foreach(var_02 in var_00)
  var_02 thread func_6722(self.func_E6DB);
}

func_6731(var_00) {
  level endon(self.func_E6DB + "_done");
  level endon("game_ended");

  if(getdvarint("esc_zombies_triggertrig") == 0) {
    var_01 = 0;
    var_02 = 70;

    for(;;) {
      self waittill("trigger", var_03);

      if(!isplayer(var_03)) {
        wait 0.1;
        var_01 = var_01 + 0.1;

        if(var_01 >= var_02) {
          break;
        }
      } else
        break;
    }
  } else {
    for(;;) {
      self waittill("trigger", var_03);

      if(!isplayer(var_03))
        continue;
      else
        break;
    }
  }

  if(isDefined(var_00) && !level.func_4BD4) {
    foreach(var_05 in var_00) {
      var_5.died_poorly = 1;
      var_05 suicide();
    }

    level.func_4BD4 = 1;
    level.func_C20B = 0;
    level notify("update_escape_timer");
    var_07 = strtok(tablelookup(level.escape_table, 0, level.current_room_index, 3), " ");
    level.escape_time = int(var_7[level.players.size - 1]);
    level thread[[level.escape_timer_func]]();
    level.current_room_index++;
  }

  func_12DBF();
}

func_12DBF() {
  func_1294D();
  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");

  foreach(var_02 in var_00) {
    var_2.active = 1;
    level.active_spawners[level.active_spawners.size] = var_02;
  }
}

func_1294D() {
  foreach(var_01 in level.active_spawners) {
    var_1.active = 0;
    var_01 notify("dont_restart_spawner");
  }

  level.active_spawners = [];
}

func_6722(var_00) {
  self.active = 0;
  self.func_1353B = var_00;
  level.func_1BF5[level.func_1BF5.size] = self;
  level.func_671F[level.func_671F.size] = self;

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);
}

func_66DA() {
  for(;;) {
    level waittill("next_area_opened", var_00);
    level notify(level.func_4B3F + "_done");
    level.wave_num++;
    level.func_4B3F = var_00;
    func_1294D();
    var_01 = getEntArray("escape_spawn_trigger", "targetname");
    var_02 = level.spawned_enemies;
    level.func_4BD4 = 0;

    foreach(var_04 in var_01) {
      if(var_4.script_area == var_00)
        var_04 thread func_6731(var_02);
    }
  }
}

func_66D6() {
  self endon("death");
  var_00 = 2560000;

  for(;;) {
    wait 0.1;
    var_01 = 1;

    foreach(var_03 in level.players) {
      if(scripts\engine\utility::is_true(var_3.spectating)) {
        continue;
      }
      if(distancesquared(var_3.origin, self.origin) < var_00)
        var_01 = 0;
    }

    if(var_01) {
      break;
    }
  }

  wait 0.5;
  self.died_poorly = 1;

  if(scripts\engine\utility::is_true(self.isactive))
    self getrandomarmkillstreak(self.health + 1000, self.origin);
  else {}
}

func_10D2E() {
  level thread func_E81B();
}

func_10927() {
  level endon("force_spawn_wave_done");
  level endon("spawn_wave_done");
  level endon("game_ended");
  var_00 = level.desired_enemy_deaths_this_wave;
  var_01 = func_7C79();
  level.respawning_enemies = 0;

  if(!isDefined(level.func_2CDB))
    level.func_2CDB = 50;

  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
  var_02 = func_C212();
  var_03 = int(var_00 / 4);
  var_04 = int(var_00 / 2);
  var_05 = 0;

  if(var_03 != var_04)
    var_05 = randomintrange(var_03, var_04);
  else
    var_05 = var_03;

  var_06 = 1;
  var_07 = int(var_00 / 8);
  var_08 = int(var_00 / 4);

  if(var_07 != var_08)
    var_06 = randomintrange(var_07, var_08);
  else
    var_06 = var_07;

  var_06 = var_05 - var_06;

  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    while(scripts\engine\utility::is_true(level.zombies_paused) || scripts\engine\utility::is_true(level.nuke_zombies_paused))
      scripts\engine\utility::waitframe();

    var_09 = num_zombies_available_to_spawn();

    if(var_09 <= 0) {
      if(var_09 < 0)
        func_A5FA(abs(var_09));

      wait 0.1;
      continue;
    }

    var_10 = undefined;

    if(!isDefined(level.respawn_data) && level.respawn_enemy_list.size > 0)
      level.respawn_data = level.respawn_enemy_list[0];

    if(var_02 && var_05 < 1 || scripts\engine\utility::flag("force_spawn_boss")) {
      var_10 = func_2CFC();

      if(isDefined(var_10)) {
        if(scripts\engine\utility::flag("force_spawn_boss"))
          scripts\engine\utility::flag_clear("force_spawn_boss");

        if(var_02 >= 1)
          var_2--;
      }
    } else if(should_spawn_clown() && var_05 < var_06)
      var_10 = get_spawner_and_spawn_goons(var_09);
    else {
      if(var_05)
        var_5--;

      var_10 = spawn_zombie();
    }

    if(isDefined(var_10)) {
      if(level.respawning_enemies > 0) {
        level.respawning_enemies = int(level.respawning_enemies - var_10);
        wait 0.1;
        continue;
      }
    }

    var_01 = func_7C79();
    wait(var_01);
  }

  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
}

spawn_zombie() {
  var_00 = func_7C2F();

  if(isDefined(var_00)) {
    if(!scripts\engine\utility::is_true(var_0.active))
      return 0;

    var_0.in_use = 1;
    var_01 = func_FF98(var_00);

    if(isDefined(var_01))
      var_02 = var_01;
    else if(!isDefined(level.static_enemy_types))
      var_02 = "generic_zombie";
    else
      var_02 = scripts\engine\utility::random(level.static_enemy_types);

    if(isDefined(level.respawn_data))
      var_02 = level.respawn_data.type;

    var_03 = var_00 spawn_wave_enemy(var_02, 1);

    if(isDefined(var_03)) {
      var_03 scripts\cp\zombies\zombie_armor::func_668D(var_03);
      var_03 scripts\cp\zombies\zombies_pillage::func_6690(var_03);
      var_0.lastspawntime = gettime();
      var_00 thread func_1296E(0.25);
    } else
      return 0;
  } else
    return 0;

  return 1;
}

func_2CFC() {
  if(isDefined(level.boss_spawn_func))
    return [[level.boss_spawn_func]]();

  var_00 = undefined;
  var_01 = get_scored_goon_spawn_location();

  if(isDefined(var_01)) {
    var_02 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
    var_00 = var_02 spawn_wave_enemy("zombie_brute", 1);

    if(!isDefined(var_00))
      return 0;

    var_1.in_use = 1;
    level.func_A88E = level.wave_num;
    func_3115(var_01);
    var_00 move_to_spot(var_01);
    var_1.in_use = 0;
  } else
    return 0;

  level notify("boss_spawned", var_00);
  level thread func_CCBB();

  if(scripts\engine\utility::flag("force_spawn_boss"))
    var_0.func_72AC = 1;

  var_00 thread killplayersifonhead(var_00);
  return 1;
}

killplayersifonhead(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_01 = scripts\engine\trace::create_character_contents();

  for(;;) {
    foreach(var_03 in level.players) {
      if(distance2dsquared(var_3.origin, var_0.origin) <= 1024) {
        if(!var_03 isonground() && var_3.origin[2] > var_0.origin[2]) {
          var_04 = scripts\engine\trace::capsule_trace(var_00 gettagorigin("tag_eye"), var_00 gettagorigin("tag_eye") + (0, 0, 56), 32, 64, undefined, var_00);

          if(isDefined(var_4["entity"]) && isplayer(var_4["entity"]) && !var_4["entity"] isonground())
            var_4["entity"] getrandomarmkillstreak(10000, var_0.origin, var_4["entity"], var_4["entity"], "MOD_UNKNOWN", "frag_grenade_zm");
        }
      }
    }

    wait 0.2;
  }
}

func_CCBB() {
  if(level.func_311A == 1) {
    foreach(var_01 in level.players)
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("brute_generic", "zmb_comment_vo", "highest", 20, 0, 0, 1);

    wait 6;
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_brute_spawn", "zmb_ww_vo", "highest", 20, 0, 0, 1);
  } else {
    level.func_311A = 1;

    foreach(var_01 in level.players)
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("brute_first", "zmb_comment_vo", "highest", 20, 0, 0, 1);

    wait 6;
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_brute_firstspawn", "zmb_ww_vo", "highest", 20, 0, 0, 1);
  }
}

func_C212() {
  if(getdvar("ui_mapname") == "cp_rave" || getdvar("ui_mapname") == "cp_disco")
    return 0;

  var_00 = 10;
  var_01 = 19;

  if(!isDefined(level.func_A88E))
    level.func_A88E = 0;

  if(!isDefined(level.func_3120))
    level.func_3120 = [];

  var_02 = 0;
  var_03 = getdvarint("scr_force_boss_spawn", 0);

  if(var_03 != 0) {
    if(level.wave_num > var_01)
      var_02 = 2;
    else
      var_02 = 1;

    if(level.func_3120.size < var_02)
      return var_02 - level.func_3120.size;
  }

  if(level.wave_num < var_00)
    return 0;

  if(scripts\engine\utility::flag("pause_wave_progression"))
    return 0;

  if(level.func_A88E + 3 < level.wave_num) {
    if(randomint(100) < level.func_2CDB) {
      level.func_2CDB = 50;

      if(level.wave_num > var_01)
        var_02 = 2;
      else
        var_02 = 1;

      if(level.func_3120.size < var_02)
        return var_02 - level.func_3120.size;
    } else {
      level.func_2CDB = level.func_2CDB + 50;
      return 0;
    }
  }

  return 0;
}

should_spawn_clown() {
  if(isDefined(level.should_spawn_special_zombie_func)) {
    var_00 = [[level.should_spawn_special_zombie_func]]();
    return scripts\engine\utility::is_true(var_00);
  }

  if(isDefined(level.no_clown_spawn))
    return 0;

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "zombie_clown")
      return 1;

    return 0;
  }

  var_01 = randomint(100);

  if(var_01 < min(level.wave_num - 19, 10) && level.wave_num > 20) {
    if(gettime() - level.last_clown_spawn_time > 15000) {
      level.last_clown_spawn_time = gettime();
      return 1;
    }
  }

  return 0;
}

func_AD62() {
  level endon("game_ended");

  for(;;) {
    if(getdvarint("scr_reserve_spawning") > 0)
      level.func_E1CC = getdvarint("scr_reserve_spawning");

    wait 1.0;
  }
}

func_A5FA(var_00, var_01) {
  var_02 = cos(70);
  var_03 = 0;

  foreach(var_05 in level.spawned_enemies) {
    if(isDefined(var_5.dont_scriptkill)) {
      continue;
    }
    var_06 = 0;

    foreach(var_08 in level.players) {
      var_06 = scripts\engine\utility::within_fov(var_8.origin, var_8.angles, var_5.origin, var_02);

      if(var_06) {
        break;
      }
    }

    if(!var_06) {
      var_5.died_poorly = 1;
      var_05 getrandomarmkillstreak(var_5.health + 980, var_5.origin, var_05, var_05, "MOD_SUICIDE");
      var_3++;

      if(var_00 <= var_03)
        return;
    }

    wait 0.1;
  }

  if(var_00 > var_03) {
    var_11 = scripts\engine\utility::array_randomize(level.spawned_enemies);

    foreach(var_05 in var_11) {
      var_5.died_poorly = 1;
      var_05 getrandomarmkillstreak(var_5.health + 970, var_5.origin, var_05, var_05, "MOD_SUICIDE");
      var_3++;

      if(var_00 <= var_03)
        return;
    }
  }
}

func_726E() {
  level notify("force_spawn_wave_done");
  wait 0.1;
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

func_172A(var_00) {
  var_01 = (0, 0, 0);
  var_02 = (0, 0, 0);
  var_03 = var_00 gettagorigin("j_spine4");
  var_04 = spawn("script_model", var_03);
  var_04 setModel("zombies_backpack");
  var_4.angles = var_0.angles;
  var_04 linkto(var_00, var_03, var_01, var_02);
  var_0.func_8B9B = 1;
}

num_zombies_available_to_spawn() {
  var_00 = 100;
  var_01 = level.max_static_spawned_enemies - level.current_num_spawned_enemies - level.func_E1CC - level.func_50F8;

  if(var_01 < var_00)
    var_00 = var_01;

  if(scripts\cp\utility::is_escape_gametype())
    return var_00;

  var_01 = level.desired_enemy_deaths_this_wave - level.current_num_spawned_enemies - level.current_enemy_deaths - level.func_50F8;

  if(var_01 < var_00)
    var_00 = var_01;

  return var_00;
}

func_1296E(var_00) {
  self endon("dont_restart_spawner");
  self.active = 0;
  wait(var_00);
  self.active = 1;
}

func_7C79() {
  if(scripts\cp\utility::is_escape_gametype()) {
    var_00 = level.players.size;
    return 1 / var_00;
  }

  var_01 = 2;

  if(level.wave_num == 1)
    return var_01;

  var_02 = var_01 * _pow(0.95, level.wave_num - 1);

  if(isDefined(level.spawndelayoverride))
    var_02 = level.spawndelayoverride;

  if(var_02 < 0.08)
    var_02 = 0.08;

  return var_02;
}

func_1068A(var_00, var_01) {
  var_02 = "zombie_clown";
  var_03 = self.origin;
  var_04 = self.angles;

  if(isDefined(var_00)) {
    var_03 = var_0.origin;
    var_04 = var_0.angles;
  } else if(isDefined(var_01))
    var_03 = var_01;

  var_05 = func_13F53(var_02, var_03, var_04, "axis", self);

  if(!isDefined(var_05))
    return undefined;

  if(isDefined(self.volume))
    var_5.volume = self.volume;

  if(scripts\engine\utility::is_true(self.is_coaster_spawner))
    var_05 thread func_42EC(var_02);
  else
    var_05 thread func_64E7(var_02);

  level notify("agent_spawned", var_05);
  return var_05;
}

spawn_wave_enemy(var_00, var_01, var_02, var_03) {
  var_04 = self.origin;
  var_05 = self.angles;

  if(isDefined(var_02)) {
    var_04 = var_2.origin;
    var_05 = var_2.angles;
  } else if(isDefined(var_03))
    var_04 = var_03;

  if(!isDefined(self.script_animation)) {
    var_04 = getclosestpointonnavmesh(var_04);
    var_04 = var_04 + (0, 0, 5);
  }

  if(level.agent_definition[var_00]["species"] == "alien") {
    var_06 = func_1B98(var_00, var_04, var_05, self);
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_06, "spawn", 1);
  } else if(level.agent_definition[var_00]["species"] == "c6")
    var_06 = func_33B1(var_00, var_04, var_05, "axis", self);
  else if(var_00 == "zombie_brute") {
    var_06 = func_13F13("zombie_brute", "axis", var_04, var_05);

    if(isDefined(var_06))
      level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_06, "spawn", 1);
  } else
    var_06 = func_13F53(var_00, var_04, var_05, "axis", self);

  if(!isDefined(var_06))
    return undefined;

  if(isDefined(self.volume))
    var_6.volume = self.volume;

  if(scripts\engine\utility::is_true(var_01))
    var_6.func_9CD9 = 1;

  var_6.dont_cleanup = undefined;

  if(func_9BF8())
    var_06 thread func_8637();

  if(isDefined(self.target) && !scripts\engine\utility::is_true(self.func_1024B)) {
    var_07 = scripts\engine\utility::getstructarray(self.target, "targetname");
    var_08 = scripts\engine\utility::random(var_07);
    var_04 = var_8.origin;
  }

  var_6.closest_entrance = scripts\cp\utility::get_closest_entrance(var_04);

  if(scripts\engine\utility::is_true(self.is_coaster_spawner))
    var_06 thread func_42EC(var_00);
  else if(var_00 == "zombie_brute")
    var_06 thread func_3114();
  else
    var_06 thread func_64E7(var_00);

  level notify("agent_spawned", var_06);
  return var_06;
}

func_13F53(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\mp_agent::spawnnewagent(var_00, var_03, var_01, var_02, undefined, var_04);

  if(!isDefined(var_05))
    return undefined;

  if(isDefined(var_5.spawner)) {
    if(var_04 func_0C2B::func_10863())
      var_5.entered_playspace = 1;
  }

  var_05 ghostskulls_total_waves(var_5.defaultgoalradius);
  var_5.maxhealth = var_05 calculatezombiehealth(var_00);
  var_5.health = var_5.maxhealth;

  if(isDefined(level.respawn_data)) {
    var_06 = -1;

    for(var_07 = 0; var_07 < level.respawn_enemy_list.size; var_7++) {
      if(level.respawn_enemy_list[var_07].id == level.respawn_data.id && level.respawn_data.type == var_00) {
        var_06 = var_07;
        break;
      }
    }

    if(var_06 > -1) {
      if(isDefined(level.respawn_data.health))
        var_5.health = level.respawn_data.health;

      level.respawn_enemy_list = scripts\cp\utility::array_remove_index(level.respawn_enemy_list, var_06);
    }

    level.respawn_data = undefined;
  }

  if(var_00 == "karatemaster" && isDefined(level.zombie_karatemaster_vo_prefix))
    var_5.voprefix = level.zombie_karatemaster_vo_prefix;
  else if(var_00 == "zombie_brute")
    var_5.voprefix = level.func_13F14;
  else if(var_00 == "zombie_cop")
    var_5.voprefix = level.func_13F1A;
  else if(var_00 == "zombie_clown")
    var_5.voprefix = level.func_13F18;
  else if(issubstr(var_5.model, "female"))
    var_5.voprefix = level.func_13F24;
  else if(randomint(100) > 50)
    var_5.voprefix = level.func_13F39;
  else
    var_5.voprefix = level.func_13F3A;

  var_05 thread scripts\cp\zombies\zombies_vo::func_13F10();
  return var_05;
}

func_FF98(var_00) {
  if(isDefined(var_0.script_animation) && (var_0.script_animation == "spawn_ceiling" || var_0.script_animation == "spawn_wall_low"))
    return undefined;

  if(isDefined(level.func_1094E)) {
    var_01 = undefined;
    var_02 = scripts\engine\utility::array_randomize_objects(level.func_1094E);

    foreach(var_06, var_04 in var_02) {
      var_05 = [
        [var_2[var_06]]
      ]();

      if(isDefined(var_05))
        return var_05;
    }
  }

  return undefined;
}

func_DB23() {
  self endon("death");
  wait 2;
  self setscriptablepartstate("glasses", "show");
}

func_13F13(var_00, var_01, var_02, var_03) {
  var_04 = 2000;
  var_05 = 2;

  switch (level.players.size) {
    case 1:
    case 0:
      var_05 = var_05 * 1;
      break;
    case 2:
      var_05 = var_05 * 1.5;
      break;
    case 3:
      var_05 = var_05 * 2;
      break;
    case 4:
      var_05 = var_05 * 2.5;
      break;
  }

  var_06 = scripts\mp\mp_agent::spawnnewagent(var_00, var_01, var_02, var_03, "iw7_zombie_laser_mp");

  if(!isDefined(var_06))
    return undefined;

  var_07 = calculatezombiehealth("generic_zombie");
  var_08 = int(var_07 * var_05);
  var_6.maxhealth = int(min(var_04 + var_08, 5000));
  var_6.health = var_6.maxhealth;
  var_6.func_8DF0 = min(var_6.maxhealth * 0.5, 5000);
  var_6.voprefix = level.func_13F14;
  var_06 thread func_310F();
  var_06 thread func_53A9();
  return var_06;
}

func_53A9() {
  level endon("game_ended");
  self endon("death");
  var_00 = 0;
  var_01 = 2304;

  for(;;) {
    var_02 = self.origin;
    wait 1;

    if(!scripts\engine\utility::is_true(self.blaserattack)) {
      if(distancesquared(self.origin, var_02) < var_01)
        var_0++;
      else
        var_00 = 0;
    } else
      var_00 = 0;

    if(var_00 > 3) {
      self setorigin(self.origin + (0, 0, 5), 1);
      var_00 = 0;
    }
  }
}

func_13F2A(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\mp_agent::spawnnewagent(var_00, var_01, var_02, var_03);

  if(!isDefined(var_04))
    return undefined;

  var_4.maxhealth = 99999999;
  var_4.health = var_4.maxhealth;
  return var_04;
}

func_9BF8() {
  if(isDefined(self.script_parameters) && (self.script_parameters == "ground_spawn" || self.script_parameters == "ground_spawn_no_boards"))
    return 1;

  return 0;
}

func_8637() {
  self endon("death");

  if(isDefined(self.spawner.script_animation)) {
    return;
  }
  self.scripted_mode = 1;
  self.ignoreall = 1;
  var_00 = 100;

  if(!isDefined(self.spawner.angles))
    self.spawner.angles = (0, 0, 0);

  var_01 = anglestoup(self.spawner.angles);
  var_01 = vectornormalize(var_01);
  var_02 = -1 * var_01;
  var_02 = var_02 * var_00;
  var_03 = 0;

  if(abs(self.spawner.angles[2]) > 45)
    var_03 = 1;

  if(var_03)
    var_04 = scripts\engine\trace::ray_trace(self.spawner.origin - (0, 0, 100), self.spawner.origin + (0, 0, 50), self);
  else
    var_04 = scripts\engine\trace::ray_trace(self.spawner.origin + (0, 0, 50), self.spawner.origin - (0, 0, 100), self);

  var_05 = var_4["position"] + var_02;
  var_06 = var_4["position"];
  func_13F1D(var_05, var_06, var_03);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

func_13F1D(var_00, var_01, var_02) {
  self endon("death");
  var_03 = spawn("script_origin", var_00);
  var_3.angles = self.spawner.angles;
  self setorigin(var_00, 0);
  self setplayerangles(self.spawner.angles);
  self linkto(var_03);
  self.func_AD1D = var_03;
  thread func_5173(var_03);
  var_04 = 2;

  if(!var_02) {
    var_03 moveto(var_01, var_04, 0.1, 0.1);
    playFX(level._effect["drone_ground_spawn"], var_01, (0, 0, 1));
    wait(var_04);
  } else {
    var_03 moveto(var_01, var_04, 0.1, 0.1);
    playFX(level._effect["drone_ground_spawn"], var_01, (0, 0, -1));
    wait(var_04);
    var_05 = scripts\engine\trace::ray_trace(var_01 - (0, 0, 10), var_01 - (0, 0, 1000), self);
    var_03 moveto(var_5["position"] + (0, 0, 10), 0.25, 0.1, 0.1);
    var_06 = (var_3.angles[0], var_3.angles[1], 0);
    var_03 rotateto(var_06, 0.25, 0.1, 0.1);
    wait 0.25;
  }

  if(self.spawner.script_parameters == "ground_spawn_no_boards")
    self.entered_playspace = 1;

  self unlink();
  self notify("emerge_done");
}

func_5173(var_00) {
  scripts\engine\utility::waittill_any("death", "emerge_done");

  if(isDefined(var_00))
    var_00 delete();
}

func_33B1(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_05))
    var_05 = "iw7_erad_zm";

  var_06 = scripts\mp\mp_agent::spawnnewagent(var_00, var_03, var_01, var_02, var_05);

  if(!isDefined(var_06))
    return undefined;

  if(isDefined(var_04))
    var_6.spawner = var_04;

  var_6.is_reserved = 1;
  return var_06;
}

calculatezombiehealth(var_00) {
  var_01 = 0;
  var_02 = level.wave_num;

  if(isDefined(level.func_8CBD) && isDefined(level.func_8CBD[var_00]))
    var_01 = [[level.func_8CBD[var_00]]]();
  else {
    if(isDefined(level.wave_num_override))
      var_02 = level.wave_num_override;

    if(scripts\engine\utility::is_true(self.is_cop))
      var_02 = var_02 + 3;
    else if(scripts\engine\utility::is_true(self.is_skeleton))
      var_02 = var_02 + 10;

    var_03 = 150;

    if(var_02 == 1)
      var_01 = var_03;
    else if(var_02 <= 9)
      var_01 = var_03 + (var_02 - 1) * 100;
    else {
      var_04 = 950;
      var_05 = var_02 - 9;
      var_01 = var_04 * _pow(1.1, var_05);
    }
  }

  if(isDefined(level.func_8CB3[var_00]))
    var_01 = int(var_01 * level.func_8CB3[var_00]);

  if(var_01 > 6100000)
    var_01 = 6100000;

  return int(var_01);
}

get_spawn_volumes_players_are_in(var_00, var_01) {
  if(isDefined(level.func_7C80))
    return [[level.func_7C80]]();

  var_02 = [];
  var_03 = level.spawn_volume_array;

  foreach(var_05 in var_03) {
    if(!var_5.active) {
      continue;
    }
    var_06 = 0;

    foreach(var_08 in level.players) {
      if(isDefined(var_01) && !var_08 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(var_08 istouching(var_05)) {
        var_06 = 1;
        continue;
      }

      if(scripts\engine\utility::is_true(var_00) && var_08 func_9C0F(var_05))
        var_06 = 1;
    }

    if(var_06)
      var_2[var_2.size] = var_05;
  }

  return var_02;
}

get_spawn_volumes_player_is_in(var_00, var_01, var_02) {
  if(isDefined(level.func_7C80))
    return [[level.func_7C80]]();

  var_03 = [];
  var_04 = level.spawn_volume_array;

  foreach(var_06 in var_04) {
    if(!var_6.active) {
      continue;
    }
    var_07 = 0;

    if(isDefined(var_01) && !var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(var_02 istouching(var_06))
      var_07 = 1;
    else if(scripts\engine\utility::is_true(var_00) && var_02 func_9C0F(var_06))
      var_07 = 1;

    if(var_07)
      var_3[var_3.size] = var_06;
  }

  return var_03;
}

func_9C0F(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(!isDefined(var_0.func_186E))
    return 0;

  foreach(var_02 in var_0.func_186E) {
    if(!var_2.active) {
      continue;
    }
    if(self istouching(var_02))
      return 1;
  }

  return 0;
}

func_94D5() {
  while(!isDefined(level.all_interaction_structs))
    wait 0.1;

  level.func_186E = [];
  level.func_186E["hidden_room"] = [];
  level.func_C50A["mars_3"]["swamp_stage"] = 1;
  var_00 = [];

  foreach(var_02 in level.all_interaction_structs) {
    if(isDefined(var_2.script_area) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != "fast_travel")
      var_0[var_0.size] = var_02;
  }

  level.func_59F4 = var_00;
  scripts\engine\utility::flag_set("init_adjacent_volumes_done");
}

set_adjacent_volume_from_door_struct(var_00) {
  var_01 = var_0.target;
  var_02 = undefined;
  var_03 = var_0.script_area;
  var_04 = undefined;

  foreach(var_06 in level.func_59F4) {
    if(var_00 == var_06) {
      continue;
    }
    if(var_6.script_area == var_03) {
      continue;
    }
    if(var_6.target == var_01) {
      var_04 = var_6.script_area;
      var_02 = var_06;
      break;
    }
  }

  if(isDefined(var_02)) {
    if(!func_9C59(var_04, var_03))
      func_1751(var_02, var_00);
  }
}

func_1751(var_00, var_01) {
  if(var_0.script_area == var_1.script_area) {
    return;
  }
  if(!isDefined(level.func_186E[var_0.script_area]))
    level.func_186E[var_0.script_area] = [];

  if(scripts\engine\utility::array_contains(level.func_186E[var_0.script_area], var_1.script_area)) {
    return;
  }
  level.func_186E[var_0.script_area][level.func_186E[var_0.script_area].size] = var_1.script_area;
  func_12E46(var_0.script_area, var_1.script_area);
}

func_9C59(var_00, var_01) {
  if(!isDefined(level.func_C50A))
    return 0;

  if(!isDefined(level.func_C50A[var_00]))
    return 0;

  if(!isDefined(level.func_C50A[var_00][var_01]))
    return 0;

  return 1;
}

func_12E46(var_00, var_01) {
  if(!isDefined(var_01)) {
    return;
  }
  if(!isDefined(level.spawn_volume_array[var_01])) {
    return;
  }
  if(!isDefined(level.spawn_volume_array[var_01].func_186E))
    level.spawn_volume_array[var_01].func_186E = [];

  level.spawn_volume_array[var_01].func_186E[level.spawn_volume_array[var_01].func_186E.size] = level.spawn_volume_array[var_00];
}

func_7C8C() {
  if(isDefined(level.zombies_spawn_score_func))
    return [[level.zombies_spawn_score_func]]();

  return scripts\engine\utility::random(level.active_spawners);
}

activate_volume_by_name(var_00) {
  if(isDefined(level.spawn_volume_array[var_00]))
    level.spawn_volume_array[var_00] make_volume_active();
}

make_volume_active() {
  var_00 = 1;

  if(scripts\cp\utility::is_escape_gametype()) {
    if(!scripts\engine\utility::is_true(self.active))
      level.active_spawners = [];
    else
      var_00 = 0;
  }

  self.active = 1;

  if(!is_in_array(level.active_spawn_volumes, self)) {
    level.active_spawn_volumes[level.active_spawn_volumes.size] = self;

    if(isDefined(self.spawners) && var_00) {
      foreach(var_02 in self.spawners)
      var_02 make_spawner_active();
    }

    if(isDefined(self.goon_spawners)) {
      foreach(var_02 in self.goon_spawners)
      var_02 func_B26D();
    }

    if(isDefined(self.rotateyaw)) {
      foreach(var_02 in self.rotateyaw)
      var_02 func_B26D();
    }
  }

  var_08 = scripts\engine\utility::getstructarray("secure_window", "script_noteworthy");

  foreach(var_10 in var_08) {
    if(ispointinvolume(var_10.origin, self)) {
      var_11 = scripts\engine\utility::getclosest(var_10.origin, level.window_entrances);
      var_11.enabled = 1;
    }
  }

  level.active_player_respawn_locs = scripts\engine\utility::array_combine(level.active_player_respawn_locs, self.func_D25E);
  level notify("volume_activated", self.basename);
}

make_volume_inactive() {
  self.active = 0;

  if(is_in_array(level.active_spawn_volumes, self)) {
    level.active_spawn_volumes = scripts\engine\utility::array_remove(level.active_spawn_volumes, self);

    if(isDefined(self.spawners)) {
      foreach(var_01 in self.spawners)
      var_01 make_spawner_inactive();
    }

    if(isDefined(self.goon_spawners)) {
      foreach(var_01 in self.goon_spawners)
      var_01 func_B26E();
    }

    if(isDefined(self.func_D25E)) {
      foreach(var_01 in self.func_D25E)
      level.active_player_respawn_locs = scripts\engine\utility::array_remove(level.active_player_respawn_locs, var_01);
    }
  }
}

make_spawner_active() {
  if(!is_in_array(level.active_spawners, self))
    level.active_spawners[level.active_spawners.size] = self;

  self.active = 1;
  self.in_use = 0;
}

make_spawner_inactive() {
  if(is_in_array(level.active_spawners, self))
    level.active_spawners = scripts\engine\utility::array_remove(level.active_spawners, self);

  self.active = 0;
}

func_D1F7() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_00 = 35;
  var_01 = var_00 * var_00;
  var_02 = 1000;

  while(!isDefined(level.spawned_enemies))
    wait 0.1;

  for(;;) {
    if(scripts\cp\utility::isignoremeenabled()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(level.spawned_enemies.size > 0) {
      var_03 = sortbydistance(level.spawned_enemies, self.origin);

      for(var_04 = 0; var_04 < var_3.size; var_4++) {
        var_05 = var_3[var_04];

        if(!agent_type_does_auto_melee(var_05)) {
          continue;
        }
        if(!var_05 func_3828()) {
          continue;
        }
        if(isDefined(var_5.attackent)) {
          continue;
        }
        if(!isDefined(var_5.last_attack_time))
          var_5.last_attack_time = gettime();

        if(distance2dsquared(var_5.origin, self.origin) < var_01) {
          var_06 = gettime();

          if(var_5.last_attack_time + 1000 < var_06) {
            if(isDefined(var_5.func_A9B8)) {
              if(var_5.func_A9B8 + 1000 < var_06) {
                if(!func_CFB2(var_05)) {
                  continue;
                }
                func_576B(var_05);
                break;
              }
            } else if(!isDefined(var_5.hasplayedvignetteanim) || var_5.hasplayedvignetteanim) {
              if(!scripts\engine\utility::is_true(var_5.bneedtoenterplayspace)) {
                if(!func_CFB2(var_05)) {
                  continue;
                }
                func_576B(var_05);
              }

              break;
            }
          }
        } else
          break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

agent_type_does_auto_melee(var_00) {
  if(isDefined(level.auto_melee_agent_type_check))
    return [[level.auto_melee_agent_type_check]](var_00);

  if(!isDefined(var_0.agent_type))
    return 0;

  if(var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_clown")
    return 0;

  return 1;
}

func_576B(var_00) {
  var_00 scripts\asm\asm_bb::bb_requestmelee(self);
  var_0.last_attack_time = gettime();
  self getrandomarmkillstreak(45, var_0.origin, var_00, var_00, "MOD_IMPACT", "none");
}

func_3828() {
  if(scripts\engine\utility::is_true(self.isfrozen))
    return 0;

  if(scripts\mp\agents\zombie\zombie_agent::dying_zapper_death())
    return 0;

  if(scripts\engine\utility::is_true(self.is_traversing))
    return 0;

  if(scripts\engine\utility::is_true(self.is_turned))
    return 0;

  if(scripts\engine\utility::is_true(self.stunned))
    return 0;

  if(scripts\engine\utility::is_true(self.is_dancing))
    return 0;

  if(scripts\engine\utility::is_true(self.marked_for_death))
    return 0;

  if(scripts\engine\utility::is_true(self.is_electrified))
    return 0;

  if(isDefined(self.killing_time))
    return 0;

  return 1;
}

func_64E7(var_00) {
  level endon("game_ended");
  func_12E2A();

  if(var_00 != "zombie_brute" && !scripts\cp\utility::is_escape_gametype())
    thread func_A5B4();

  thread func_135A3();
}

func_42EC(var_00) {
  level endon("game_ended");
  level.spawned_enemies[level.spawned_enemies.size] = self;
  self.died_poorly = 1;
  self.allowpain = 0;
}

func_3114() {
  level endon("game_ended");

  if(!isDefined(level.func_3120))
    level.func_3120 = [];

  level.func_3120 = scripts\engine\utility::add_to_array(level.func_3120, self);
  self.allowpain = 0;
  self.is_reserved = 1;
  increase_reserved_spawn_slots(1);
  level.spawned_enemies[level.spawned_enemies.size] = self;
  thread func_135A3();
  self waittill("death");
  level.func_3120 = scripts\engine\utility::array_remove(level.func_3120, self);
  decrease_reserved_spawn_slots(1);
}

func_12E2A() {
  var_00 = 1;
  level.spawned_enemies[level.spawned_enemies.size] = self;
  level.current_num_spawned_enemies = level.current_num_spawned_enemies + var_00;
}

func_12E29(var_00, var_01) {
  var_02 = 1;

  if(isDefined(self.attack_spot)) {
    var_03 = self.attack_spot;
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
    self.attack_spot = undefined;
  }

  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);

  if(scripts\engine\utility::is_true(self.is_reserved)) {
    return;
  }
  level.current_num_spawned_enemies = level.current_num_spawned_enemies - var_02;

  if(scripts\engine\utility::flag("pause_wave_progression"))
    return;
  else if(!self.died_poorly)
    level.current_enemy_deaths = level.current_enemy_deaths + var_02;
  else {
    add_to_respawn_list();
    level.respawning_enemies++;
  }
}

add_to_respawn_list() {
  var_00 = spawnStruct();
  var_0.health = self.died_poorly_health;
  var_0.type = self.agent_type;
  var_0.id = gettime();
  level.respawn_enemy_list[level.respawn_enemy_list.size] = var_00;
  self.died_poorly_health = undefined;
}

func_A5B4() {
  self endon("death");

  if(isDefined(self.dont_scriptkill)) {
    return;
  }
  var_00 = 625;
  var_01 = 100;
  var_02 = 0;
  var_03 = self.origin;
  var_04 = self.angles;
  self.traversal_start_time = undefined;
  wait 1;

  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    while(!scripts\engine\utility::is_true(self.hasplayedvignetteanim))
      wait 0.1;
  }

  while(!isDefined(self.asm.cur_move_mode))
    wait 0.1;

  for(;;) {
    if(isDefined(self.is_traversing)) {
      var_05 = gettime();

      if(!isDefined(self.traversal_start_time)) {
        self.traversal_start_time = var_05;
        wait 1;
        continue;
      } else if(var_05 - self.traversal_start_time < 10000) {
        wait 1;
        continue;
      } else
        var_02 = 6;
    } else
      self.traversal_start_time = undefined;

    if(isDefined(self.func_9393)) {
      wait 1;
      continue;
    }

    if(self.is_dancing || self.about_to_dance || scripts\engine\utility::is_true(self.stunned) || scripts\engine\utility::is_true(self.func_4F42)) {
      wait 1;
      continue;
    }

    var_06 = var_00;

    if(self.asm.cur_move_mode == "slow_walk")
      var_06 = var_01;

    if(distancesquared(self.origin, var_03) < var_06) {
      if(isDefined(self.is_suicide_bomber))
        var_2++;
      else if(isDefined(self.curmeleetarget)) {
        var_07 = anglesdelta(var_04, self.angles);
        var_08 = distancesquared(self.origin, self.curmeleetarget.origin);

        if(var_08 > 10000 && var_07 < 45)
          var_2++;
        else
          var_02 = 0;
      } else if(isDefined(self.func_6658)) {
        if(!scripts\cp\zombies\zombie_entrances::entrance_has_barriers(self.func_6658))
          var_2++;
        else
          var_02 = 0;
      } else
        var_02 = 0;

      if(var_02 == 4)
        self setorigin(self.origin + (0, 0, 10), 0);

      if(var_02 > 5) {
        break;
      }
    }

    var_04 = self.angles;
    var_03 = self.origin;
    wait 1;
  }

  self.died_poorly = 1;

  if(scripts\engine\utility::is_true(self.marked_for_challenge) && isDefined(level.num_zombies_marked))
    level.num_zombies_marked--;

  self getrandomarmkillstreak(self.health + 960, self.origin, self, self, "MOD_SUICIDE");
}

func_7C2F() {
  var_00 = undefined;
  var_00 = func_7C8C();
  return var_00;
}

is_in_any_room_volume() {
  if(isDefined(level.invalid_spawn_volume_array)) {
    foreach(var_01 in level.invalid_spawn_volume_array) {
      if(ispointinvolume(self.origin, var_01))
        return 0;
    }
  }

  if(isDefined(level.spawn_volume_array)) {
    foreach(var_01 in level.spawn_volume_array) {
      if(ispointinvolume(self.origin, var_01))
        return 1;
    }
  }

  return 0;
}

func_E81B() {
  level endon("game_ended");
  var_00 = 5;
  level.func_6870 = 0;
  var_01 = 21;
  level thread func_4094();
  var_02 = 1;

  for(;;) {
    func_13BCB();
    scripts\cp\cp_persistence::update_lb_aliensession_wave(level.wave_num);

    if(level.wave_num > 0) {
      if(level.wave_num / 10 == var_02) {
        level notify("prize_restock");

        if(scripts\cp\utility::map_check(0))
          level thread scripts\cp\cp_vo::try_to_play_vo("dj_nag_ticket_restock", "zmb_dj_vo", "highest", 20, 0, 0, 1, 100);

        var_2++;
      }

      if(getdvar("ui_gametype") == "zombie" && (scripts\cp\utility::isplayingsolo() || level.only_one_player)) {
        if(isDefined(level.players[0])) {
          if(level.wave_num == 2)
            level.players[0] thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("zombiehealth", 7);
          else if(level.wave_num == 3)
            level.players[0] thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("scenes", 7);
          else if(level.wave_num == 4 && !level.players[0] scripts\cp\cp_hud_message::get_has_seen_tutorial("magic_wheel")) {
            level.players[0] thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("magic_wheel", 7);
            level.players[0] notify("saw_wheel_tutorial");
          } else if(level.wave_num == 9 && !level.players[0] scripts\cp\cp_hud_message::get_has_seen_tutorial("pap"))
            level.players[0] thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("pap", 7);
        }
      }

      if(getdvar("ui_gametype") == "zombie") {
        foreach(var_04 in level.players) {
          var_04 setclientomnvar("zombie_wave_number", level.wave_num);
          var_04 scripts\cp\cp_merits::processmerit("mt_highest_round");
        }
      }
    }

    if(func_FF9D(level.wave_num)) {
      level notify("event_wave_starting");
      func_E7F0(level.wave_num);
    } else {
      level notify("regular_wave_starting");

      if(level.power_on == 1 && level.wave_num > 5)
        level thread scripts\cp\cp_vo::try_to_play_vo("dj_interup_wave_start", "zmb_dj_vo", "high", 4, 0, 0, 1, 40);

      if(soundexists("mus_zombies_newwave") && level.wave_num > 0)
        level thread func_BDD4();

      func_1081A(level.wave_num);

      if(soundexists("mus_zombies_endwave") && level.wave_num > 0)
        level thread func_BDD1();
    }

    if(level.wave_num > 0)
      level notify("spawn_wave_done");

    var_06 = int(1000);

    if(level.wave_num < 21)
      var_06 = int(level.wave_num * 50);

    foreach(var_04 in level.players) {
      var_04 scripts\cp\cp_persistence::give_player_xp(var_06, 1);
      var_04 scripts\cp\cp_merits::processmerit("mt_total_rounds");

      if(level.wave_num > 0)
        var_04 notify("next_wave_notify");

      var_4.coaster_ridden_this_round = undefined;
      var_4.func_2113 = 0;
    }

    if(level.power_on == 1 && level.wave_num > 5)
      level thread scripts\cp\cp_vo::try_to_play_vo("dj_interup_wave_end", "zmb_dj_vo", "high", 4, 0, 0, 1, 40);

    wait(var_00);
    level thread scripts\cp\gametypes\zombie::replace_grenades_between_waves();

    if(isDefined(level.wave_complete_dialogues_func))
      [[level.wave_complete_dialogues_func]](level.wave_num);

    var_09 = (gettime() - level.func_13BDA) / 1000;
    scripts\cp\zombies\zombie_analytics::func_AF90(level.wave_num, var_09, level.laststandnumber, level.timesinafterlife);

    if(level.wave_num > 1)
      func_13BDB();

    level.wave_num = func_7B1C();
    scripts\cp\cp_persistence::update_players_career_highest_wave(level.wave_num, level.script);
    var_00 = func_7D00(var_00, level.wave_num);
  }
}

clown_wave_music() {
  wait 0.5;
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_clownwave_wavestart", "zmb_announcer_vo", "highest", 70, 0, 0, 1);
  wait 3;

  if(soundexists("mus_zombies_eventwave_start"))
    level thread func_BDD3();

  level.wait_for_music_clown_wave = 1;
}

wave_complete_dialogues(var_00) {
  if(!isDefined(level.completed_dialogues))
    level.completed_dialogues = [];

  if(var_00 >= 17 && !isDefined(level.completed_dialogues["flavour_1"])) {
    if(randomint(100) > 60)
      level thread scripts\cp\cp_vo::try_to_play_vo("flavour_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  }

  if(var_00 >= 3 && var_00 <= 5 && !isDefined(level.completed_dialogues["round_end_3thru5_1"])) {
    if(randomint(100) > 50) {
      level thread scripts\cp\cp_vo::try_to_play_vo("round_end_3thru5_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["round_end_3thru5_1"] = 1;
    }
  } else if(var_00 >= 6 && var_00 <= 8 && !isDefined(level.completed_dialogues["round_end_6thru8_1"])) {
    if(randomint(100) > 50) {
      level thread scripts\cp\cp_vo::try_to_play_vo("round_end_6thru8_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["round_end_6thru8_1"] = 1;
    }
  } else if(var_00 >= 9 && var_00 <= 12 && !isDefined(level.completed_dialogues["round_end_9thru12_1"])) {
    if(randomint(100) > 50) {
      level thread scripts\cp\cp_vo::try_to_play_vo("round_end_9thru12_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["round_end_9thru12_1"] = 1;
    }
  } else if(var_00 >= 13 && var_00 <= 16 && !isDefined(level.completed_dialogues["round_end_13thru16_1"])) {
    if(randomint(100) > 50) {
      level thread scripts\cp\cp_vo::try_to_play_vo("round_end_13thru16_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["round_end_13thru16_1"] = 1;
    }
  }
}

func_13BDB() {
  foreach(var_01 in level.players) {
    if(!isDefined(var_1.pers["timesPerWave"].func_11930[level.wave_num + 1])) {
      if(scripts\engine\utility::is_true(var_1.in_afterlife_arcade)) {
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["coaster"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["game_race"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery"] = 0;
        var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
      }

      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["coaster"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["game_race"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery"] = 0;
      var_1.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
    }

    var_02 = var_01 getcurrentweapon();
    var_03 = getweaponbasename(var_02);

    if(var_1.exitingafterlifearcade == 1 || !isDefined(var_1.wavesheldwithweapon[var_03])) {
      continue;
    }
    var_1.wavesheldwithweapon[var_03]++;
  }
}

func_13BCB() {
  level notify("wave_starting");

  if(scripts\engine\utility::flag_exist("dj_interup_wave_start_init"))
    scripts\engine\utility::flag_set("dj_interup_wave_start_init");

  foreach(var_01 in level.players)
  var_1.fortune_visit_this_round = 0;

  func_E21C();
  level.func_13BDA = gettime();
}

func_E21C() {
  var_00 = 50;
  level.func_B41F = var_00 * level.wave_num;

  if(level.func_B41F > 500)
    level.func_B41F = 500;

  foreach(var_02 in level.players)
  var_2.reboarding_points = 0;
}

func_1081A(var_00) {
  level.static_enemy_types = func_7CA9(var_00);
  level.max_static_spawned_enemies = get_max_static_enemies(var_00);
  level.desired_enemy_deaths_this_wave = get_total_spawned_enemies(var_00);
  level.current_enemy_deaths = 0;
  level.stop_spawning = 0;
  func_10927();
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

func_4F0E() {
  iprintln("starting wave " + level.wave_num);
  iprintln("total spawns: " + level.desired_enemy_deaths_this_wave);
}

func_FF9D(var_00) {
  if(isDefined(level.should_run_event_func))
    return [[level.should_run_event_func]](var_00);

  if(scripts\cp\utility::is_escape_gametype())
    return 0;

  if(getdvar("ui_mapname") == "cp_disco")
    return 0;

  if(var_00 < 5)
    return 0;
  else if(scripts\engine\utility::flag_exist("defense_sequence_active") && scripts\engine\utility::flag("defense_sequence_active"))
    return 0;
  else if(scripts\engine\utility::flag_exist("all_center_positions_used") && scripts\engine\utility::flag("all_center_positions_used"))
    return 0;
  else {
    var_01 = var_00 - level.last_event_wave;

    if(var_01 < 5)
      return 0;
    else {
      var_01 = var_01 - 4;
      var_02 = var_01 / 3 * 100;

      if(randomint(100) < var_02)
        return 1;
    }
  }

  return 0;
}

func_E7F0(var_00) {
  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
  var_01 = func_7848(var_00);

  if(isDefined(level.event_funcs_start))
    [[level.event_funcs_start]](var_01);
  else {
    level thread clown_wave_music();
    func_F604("cp_zmb_alien", 1.0);
    level.vision_set_override = "cp_zmb_alien";
  }

  level.spawn_event_running = 1;
  var_02 = 0;

  if(isDefined(var_01)) {
    if(isDefined(level.event_funcs[var_01]))
      [[level.event_funcs[var_01]]]();
    else
      var_02 = 1;
  } else
    var_02 = 1;

  if(var_02) {
    return;
  }
  level.spawn_event_running = 0;
  level.specialroundcounter++;
  level.last_event_wave = var_00;

  if(isDefined(level.event_funcs_end))
    [[level.event_funcs_end]](var_01);
  else {
    level.vision_set_override = undefined;
    func_F604("", 0);

    if(soundexists("mus_zombies_eventwave_end"))
      level thread func_BDD2();

    level.wait_for_music_clown_wave = 0;
  }

  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
}

func_F604(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(!scripts\engine\utility::is_true(var_3.wearing_dischord_glasses))
      var_03 visionsetnakedforplayer(var_00, var_01);
  }
}

func_7848(var_00) {
  if(isDefined(level.available_event_func))
    return [[level.available_event_func]](var_00);

  return "goon";
}

func_7B1C() {
  return level.wave_num + 1;
}

func_7D00(var_00, var_01) {
  if(scripts\cp\utility::is_escape_gametype())
    return 1;

  return 10;
}

func_7CA9(var_00) {
  var_01 = ["generic_zombie"];
  return var_01;
}

get_max_static_enemies(var_00) {
  if(scripts\cp\utility::is_escape_gametype() && var_00 < 5) {
    var_01 = level.players.size * 6;
    var_02 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
    var_03 = 1;
    var_04 = 1;
    var_03 = var_2[var_00];
    var_05 = level.players.size - 1;

    if(var_05 < 1)
      var_05 = 0.5;

    var_06 = (24 + var_05 * 6 * var_04) * var_03;
    return int(min(var_01, var_06));
  }

  return 24;
}

get_total_spawned_enemies(var_00) {
  if(scripts\cp\utility::is_escape_gametype())
    return 9000;

  var_01 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
  var_02 = 1;
  var_03 = 1;

  if(var_00 < 6)
    var_02 = var_1[var_00];
  else if(var_00 < 10)
    var_03 = var_00 / 5;
  else
    var_03 = squared(var_00) * 0.03;

  var_04 = level.players.size - 1;

  if(var_04 < 1)
    var_04 = 0.5;

  var_05 = (24 + var_04 * 6 * var_03) * var_02;
  return int(var_05);
}

func_7CFF(var_00) {
  return 1;
}

func_79B4(var_00) {
  return 0;
}

func_7A3D(var_00, var_01) {
  if(isDefined(level.func_10698)) {
    var_00 = var_00 + 0;
    var_02 = tablelookupbyrow(level.func_10698, var_00, var_01);
    var_03 = strtok(var_02, " ");

    if(var_3.size > 0)
      return var_03;
  }

  return undefined;
}

func_13691() {
  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave)
    wait 1.0;

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

is_in_array(var_00, var_01) {
  if(!isDefined(var_00) || !isDefined(var_01) || var_0.size == 0)
    return 0;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(var_0[var_02] == var_01)
      return 1;
  }

  return 0;
}

func_13FA2() {
  foreach(var_01 in level.spawn_volume_array) {
    if(self istouching(var_01))
      return 1;
  }

  return 0;
}

func_310F() {
  level endon("game_ended");
  self endon("death");
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix);
  self.playing_stumble = 0;

  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_timeout(6, "attack_hit", "attack_miss");

    switch (var_00) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_swipe", 0);
        break;
      case "attack_miss":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_swipe", 0);
        break;
      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "run_grunt", 0);
        break;
    }
  }
}

func_135A3() {
  self endon("death");

  for(;;) {
    if([
        [level.active_volume_check]
      ](self.origin)) {
      self.entered_playspace = 1;

      if(isDefined(self.attack_spot)) {
        if(isDefined(self.attack_spot.func_C2D0) && self.attack_spot.func_C2D0 == self)
          scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
      }

      return;
    }

    wait 0.35;
  }
}

func_4094() {
  if(isDefined(level.ai_cleanup_func)) {
    level thread[[level.ai_cleanup_func]]();
    return;
  }

  var_00 = 0;
  level.func_BE23 = 0;

  for(;;) {
    scripts\engine\utility::waitframe();
    var_01 = gettime();

    if(var_01 < var_00) {
      continue;
    }
    if(isDefined(level.func_BE22)) {
      var_02 = gettime() / 1000;
      var_03 = var_02 - level.func_BE22;

      if(var_03 < 0) {
        continue;
      }
      level.func_BE22 = undefined;
    }

    var_04 = (var_01 - level.func_13BDA) / 1000;

    if(level.wave_num <= 5 && var_04 < 30)
      continue;
    else if(level.wave_num > 5 && var_04 < 20) {
      continue;
    }
    var_05 = undefined;

    if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 3)
      var_05 = 2250000;

    var_00 = var_00 + 3000;
    var_06 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(var_08 in var_06) {
      if(level.func_BE23 >= 1) {
        level.func_BE23 = 0;
        scripts\engine\utility::waitframe();
      }

      if(func_380D(var_08))
        var_08 func_5773(var_05);
    }
  }
}

func_380D(var_00) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_ghost")
    return 0;

  if(isDefined(var_0.func_2BF9))
    return 0;

  if(scripts\engine\utility::is_true(var_0.is_turned))
    return 0;

  if(scripts\engine\utility::is_true(var_0.dont_cleanup))
    return 0;

  if(isDefined(var_0.delay_cleanup_until) && gettime() < var_0.delay_cleanup_until)
    return 0;

  if(scripts\engine\utility::is_true(level.zbg_active))
    return 0;

  return 1;
}

func_5773(var_00) {
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
  if(self.agent_type == "generic_zombie" || self.agent_type == "zombie_cop" || self.agent_type == "lumberjack") {
    if(var_01 < 45000 && !self.entered_playspace)
      return;
  }

  var_02 = 1;
  var_03 = 0;
  var_04 = 1;

  if(scripts\engine\utility::is_true(self.dismember_crawl) && level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 2) {
    var_03 = 1;
    var_00 = 1000000;
    var_02 = 0;
  } else if(level.func_B789.size == 0) {
    if(isDefined(level.use_adjacent_volumes))
      var_02 = animmode(1, 0);
    else
      var_02 = animmode(0, 0);
  } else {
    var_02 = animmode(1, 0);

    if(var_02)
      var_04 = animmode(0, 1);
  }

  level.func_BE23++;

  if(!var_02 || !var_04) {
    var_05 = 10000000;
    var_06 = level.players[0];

    foreach(var_08 in level.players) {
      var_09 = distancesquared(self.origin, var_8.origin);

      if(var_09 < var_05) {
        var_05 = var_09;
        var_06 = var_08;
      }
    }

    if(isDefined(var_00))
      var_11 = var_00;
    else if(isDefined(var_06) && func_CF4C(var_06))
      var_11 = 189225;
    else
      var_11 = 1000000;

    if(var_05 >= var_11) {
      if(!var_04) {
        if(level.last_mini_zone_fail + 1000 > gettime())
          return;
        else
          level.last_mini_zone_fail = gettime();
      }

      thread func_51A5(var_05, var_03);
    }
  }
}

func_FF1A(var_00) {
  if(!isDefined(var_0.agent_type))
    return 0;

  switch (var_0.agent_type) {
    case "zombie_grey":
    case "zombie_brute":
      return 0;
    default:
      return 1;
  }
}

func_51A5(var_00, var_01) {
  if(scripts\engine\utility::is_true(self.func_93A7)) {
    return;
  }
  if(var_01) {
    if(scripts\engine\utility::is_true(self.isactive))
      func_EDF6();
    else {}
  } else {
    foreach(var_03 in level.players) {
      if(scripts\engine\utility::is_true(var_3.spectating)) {
        continue;
      }
      if(scripts\engine\utility::is_true(var_3.is_fast_traveling)) {
        continue;
      }
      if(scripts\engine\utility::is_true(var_3.in_afterlife_arcade)) {
        continue;
      }
      if(func_CFB2(var_03)) {
        if(var_00 < 4000000)
          return;
      }
    }

    self.died_poorly = 1;

    if(scripts\engine\utility::is_true(self.marked_for_challenge) && isDefined(level.num_zombies_marked))
      level.num_zombies_marked--;

    if(scripts\engine\utility::is_true(self.isactive)) {
      self.nocorpse = 1;
      func_EDF6();
    }
  }
}

func_EDF6() {
  self getrandomarmkillstreak(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
}

func_CFB2(var_00) {
  var_01 = var_00 getplayerangles();
  var_02 = anglesToForward(var_01);
  var_03 = self.origin - var_00 getorigin();
  var_03 = vectornormalize(var_03);
  var_04 = vectordot(var_02, var_03);

  if(var_04 < 0.766)
    return 0;

  return 1;
}

func_CF4C(var_00) {
  var_01 = var_00 getplayerangles();
  var_02 = anglesToForward(var_01);
  var_03 = var_00 getorigin() - self.origin;
  var_04 = vectordot(var_02, var_03);

  if(var_04 < 0)
    return 0;

  return 1;
}

animmode(var_00, var_01) {
  var_02 = undefined;

  foreach(var_04 in level.active_spawn_volumes) {
    if(self istouching(var_04)) {
      var_02 = var_04;
      break;
    }
  }

  if(!isDefined(var_02))
    return 0;

  var_06 = 0;

  if(scripts\engine\utility::is_true(var_01))
    var_06 = var_06 + func_C1EB(var_02, 1);
  else
    var_06 = scripts\cp\zombies\func_0D60::allowedstances(var_02);

  if(scripts\engine\utility::is_true(var_00) && var_06 == 0 && isDefined(var_2.func_186E)) {
    foreach(var_04 in var_2.func_186E)
    var_06 = var_06 + scripts\cp\zombies\func_0D60::allowedstances(var_04);
  }

  return var_06;
}

func_F5EC() {
  scripts\engine\utility::flag_wait("init_adjacent_volumes_done");
  level.func_B789 = [];
  var_00 = getEntArray("mini_zone", "script_noteworthy");

  foreach(var_02 in var_00)
  level.func_B789[var_2.targetname] = var_02;

  if(level.func_B789.size == 0) {
    return;
  }
  var_04 = 1;

  foreach(var_06 in level.spawn_volume_array) {
    var_04 = 1;
    var_07 = var_6.basename + "_" + var_04 + "_despawn_volume";

    if(var_07 == "mars3_1_despawn_volume")
      var_04 = 1;

    while(isDefined(level.func_B789[var_07])) {
      var_08 = var_6.basename + "_" + (var_04 - 1) + "_despawn_volume";
      var_09 = var_6.basename + "_" + (var_04 + 1) + "_despawn_volume";

      if(isDefined(level.func_B789[var_08]))
        level.func_B789[var_07].func_186E[var_08] = level.func_B789[var_08];

      if(isDefined(level.func_B789[var_09]))
        level.func_B789[var_07].func_186E[var_09] = level.func_B789[var_09];

      if(isDefined(level.func_B789[var_07].target)) {
        var_10 = level.func_B789[var_07].target;
        level.func_B789[var_07].func_186E[var_10] = level.func_B789[var_10];
        level.func_B789[var_10].func_186E[var_07] = level.func_B789[var_07];
      }

      var_4++;
      var_07 = var_6.basename + "_" + var_04 + "_despawn_volume";
    }
  }
}

func_C1EB(var_00, var_01) {
  var_02 = 1;
  var_03 = undefined;
  var_04 = 1;
  var_05 = 0;

  while(var_02) {
    var_06 = getEntArray(var_0.basename + "_" + var_04 + "_despawn_volume", "targetname");

    if(isDefined(var_6[0])) {
      if(self istouching(var_6[0])) {
        var_03 = var_6[0];
        break;
      }

      var_4++;
      continue;
    }

    var_02 = 0;
  }

  if(isDefined(var_03)) {
    var_05 = scripts\cp\zombies\func_0D60::allowedstances(var_03);

    if(scripts\engine\utility::is_true(var_01) && var_05 == 0 && isDefined(var_3.func_186E)) {
      foreach(var_08 in var_3.func_186E)
      var_05 = var_05 + scripts\cp\zombies\func_0D60::allowedstances(var_08);
    }
  }

  return var_05;
}

create_spawner(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = level.spawn_volume_array[var_00];
  var_07 = spawnStruct();
  var_7.origin = var_01;

  if(isDefined(var_02))
    var_7.angles = var_02;
  else
    var_7.angles = (0, 0, 0);

  if(isDefined(var_05))
    var_7.script_fxid = var_05;

  var_7.script_noteworthy = "static";

  if(isDefined(var_04))
    var_7.script_animation = var_04;

  if(isDefined(var_03))
    var_7.script_parameters = var_03;

  var_7.targetname = var_6.target;
  var_07 func_10865(var_06);
  var_6.spawners = scripts\engine\utility::array_add(var_6.spawners, var_07);
  return var_07;
}

func_7D87() {
  level.func_13F33 = scripts\engine\utility::getstructarray("zombie_idle_spot", "targetname");
  level thread func_962E();
}

func_FF55(var_00) {
  if(getdvarint("scr_active_volume_check") == 1) {
    if(isplayer(var_00) && !scripts\cp\loot::is_in_active_volume(var_0.origin))
      return 1;
  }

  if(isDefined(var_0.linked_to_coaster))
    return 1;

  if(isDefined(var_0.is_off_grid))
    return 1;

  var_01 = isDefined(self.enemy) && isDefined(self.enemy.is_fast_traveling);

  if(!var_01 && distancesquared(var_0.origin, getclosestpointonnavmesh(var_0.origin)) > 10000)
    return 1;

  if(self.agent_type == "zombie_brute" && isDefined(var_0.special_case_ignore))
    return 1;

  return 0;
}

func_962E() {
  if(!isDefined(level.func_13F33) || level.func_13F33.size == 0) {
    return;
  }
  level.func_71A7 = ::func_7A2C;

  if(isDefined(level.idle_spot_patch_func))
    [[level.idle_spot_patch_func]]();

  var_00 = [];

  foreach(var_02 in level.func_13F33) {
    var_03 = var_02 func_962D();

    if(isDefined(var_03))
      var_0[var_0.size] = var_03;
  }

  level.func_13F33 = scripts\engine\utility::array_remove_array(level.func_13F33, var_00);
}

func_962D() {
  foreach(var_01 in level.spawn_volume_array) {
    if(ispointinvolume(self.origin, var_01)) {
      self.volume = var_01;
      return;
    }
  }

  return self;
}

debug_idle_spots(var_00, var_01) {
  wait 15;

  foreach(var_03 in var_00)
  thread scripts\cp\utility::drawsphere(var_3.origin, 5, 1800, var_01);
}

add_idle_spot(var_00) {
  var_01 = spawnStruct();
  var_1.origin = var_00;
  var_1.targetname = "zombie_idle_spot";
  level.func_13F33 = scripts\engine\utility::add_to_array(level.func_13F33, var_01);
}

move_idle_spot(var_00, var_01) {
  var_02 = scripts\engine\utility::getclosest(var_00, level.func_13F33, 500);
  var_2.origin = var_01;
}

func_4957() {
  var_00 = 80;
  var_01 = [];
  var_1[0] = getclosestpointonnavmesh(self.origin + (var_00, 0, 0));
  var_1[1] = getclosestpointonnavmesh(self.origin + (var_00, var_00, 0));
  var_1[2] = getclosestpointonnavmesh(self.origin + (0, var_00, 0));
  var_1[3] = getclosestpointonnavmesh(self.origin + (-1 * var_00, var_00, 0));
  var_1[4] = getclosestpointonnavmesh(self.origin + (-1 * var_00, 0, 0));
  var_1[5] = getclosestpointonnavmesh(self.origin + (-1 * var_00, -1 * var_00, 0));
  var_1[6] = getclosestpointonnavmesh(self.origin + (0, -1 * var_00, 0));
  var_1[7] = getclosestpointonnavmesh(self.origin + (var_00, -1 * var_00, 0));
  var_02 = [];

  for(var_03 = 0; var_03 < var_1.size; var_3++)
    var_2[var_03] = 0;

  var_04 = spawnStruct();
  var_4.func_C6FB = var_01;
  var_4.func_1621 = var_02;
  self.func_E540 = var_04;
}

func_7C19(var_00) {
  foreach(var_03, var_02 in var_0.func_E540.func_C6FB) {
    if(var_0.func_E540.func_1621[var_03]) {
      continue;
    }
    var_0.func_E540.func_1621[var_03] = 1;
    thread func_DF41();
    return var_03;
  }

  return undefined;
}

func_7A2C() {
  if(!isDefined(level.func_13F33))
    return undefined;

  return func_7C18(level.func_13F33);
}

func_7C18(var_00) {
  var_00 = scripts\engine\utility::array_randomize(var_00);

  if(var_0.size == 1) {
    var_01 = var_0[0];
    self.func_92E8 = var_01;
    return var_1.origin;
  }

  foreach(var_01 in var_00) {
    if(ispointinvolume(self.origin, var_1.volume)) {
      if(isDefined(self.func_92E8) && var_01 == self.func_92E8) {
        continue;
      }
      self.func_92E8 = var_01;
      return var_1.origin;
    }
  }

  if(!isDefined(self.spawner))
    return undefined;

  foreach(var_01 in var_00) {
    if(isDefined(self.spawner.volume) && self.spawner.volume == var_1.volume) {
      if(isDefined(self.func_92E8) && var_01 == self.func_92E8) {
        continue;
      }
      self.func_92E8 = var_01;
      return var_1.origin;
    }
  }

  return undefined;
}

func_DDC7(var_00, var_01) {
  self endon("reset_recently_used");
  wait(var_00);
  self.recently_used = 1;
  wait(var_01);
  self.recently_used = undefined;
  self notify("reset_recently_used");
}

func_DF41() {
  scripts\engine\utility::waittill_any("StopFindTargetNoGoal", "death");
  self.func_92E8.func_E540.func_1621[self.func_92E9] = 0;
  self.func_92E8 = undefined;
  self.func_92E9 = undefined;
  self notify("StopFindTargetNoGoal");
}

func_F546(var_00) {
  var_01 = scripts\engine\utility::getstructarray("player_respawn_loc", "targetname");
  var_02 = [];

  foreach(var_04 in var_01) {
    if(ispointinvolume(var_4.origin, var_00)) {
      var_4.func_212E = var_00;
      var_2[var_2.size] = var_04;
    }
  }

  var_0.func_D25E = var_02;
}

func_BDD4() {
  scripts\cp\utility::playsoundinspace("mus_zombies_newwave", (0, 0, 0), 1);
  level notify("wave_start_sound_done");
}

func_BDD1() {
  wait 0.3;
  scripts\cp\utility::playsoundinspace("mus_zombies_endwave", (0, 0, 0));
}

func_BDD3() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_start", (0, 0, 0));
  level notify("wave_start_sound_done");
}

func_BDD2() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_end", (0, 0, 0));
}

func_BDD0() {
  scripts\cp\utility::playsoundinspace("mus_zombies_boss_start", (0, 0, 0));
}

func_BDCF() {
  scripts\cp\utility::playsoundinspace("mus_zombies_boss_end", (0, 0, 0));
}

increase_reserved_spawn_slots(var_00) {
  level.func_E1CC = level.func_E1CC + var_00;
}

decrease_reserved_spawn_slots(var_00) {
  level.func_E1CC = max(0, level.func_E1CC - var_00);
}

func_93E6(var_00) {
  level.func_50F8 = level.func_50F8 + var_00;
}

func_4FB6(var_00) {
  level.func_50F8 = level.func_50F8 - var_00;
}