/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_rave_spawning.gsc
***************************************************/

goon_spawn_event_func() {
  if(!isDefined(level.zombie_sasquatch_vo_prefix)) {
    level.zombie_sasquatch_vo_prefix = "zmb_vo_sasquatch_";
  }

  level.static_enemy_types = _id_79EB();
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = _id_8455();
  level.current_enemy_deaths = 0;
  _id_1071B();
}

_id_8455() {
  var_0 = level.players.size;
  var_1 = var_0 * 3;
  var_2 = 1;

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
  }

  var_1 = var_1 * var_2;
  return var_1;
}

_id_1071B() {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  level.respawning_enemies = 0;
  level.num_goons_spawned = 0;
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  var_0 = 0;

  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    while(scripts\engine\utility::is_true(level.zombies_paused) || scripts\engine\utility::is_true(level.nuke_zombies_paused)) {
      scripts\engine\utility::waitframe();
    }

    var_1 = num_goons_to_spawn();
    var_2 = get_spawner_and_spawn_goons(var_1);
    var_0 = var_0 + var_2;

    if(var_2 > 0) {
      wait(_id_8454(var_0, level.desired_enemy_deaths_this_wave));
      continue;
    }

    wait 0.1;
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

_id_B26D() {
  if(!is_in_array(level._id_162C, self)) {
    level._id_162C[level._id_162C.size] = self;
  }

  self.active = 1;
  self.in_use = 0;
}

_id_B26E() {
  self.active = 0;
}

_id_5CF7(var_0, var_1, var_2) {
  if(isDefined(level.force_drop_loot_item)) {
    level thread scripts\cp\loot::drop_loot(var_1, var_2, level.force_drop_loot_item);
    level.force_drop_loot_item = undefined;
    return 1;
  }

  if(level.spawn_event_running == 1) {
    if(level.desired_enemy_deaths_this_wave == level.current_enemy_deaths) {
      level thread scripts\cp\loot::drop_loot(var_1, var_2, "ammo_max");
      return 1;
    } else
      return 0;
  } else
    return 0;
}

_id_79EB() {
  return ["sasquatch"];
}

_id_8454(var_0, var_1) {
  var_2 = 1.5;

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
  }

  var_2 = var_2 - var_0 / var_1;
  var_2 = max(var_2, 0.05);
  return var_2;
}

_id_826F() {
  var_0 = 0.5;
  return var_0;
}

_id_8270() {
  var_0 = level.players.size;
  return 8 + 4 * var_0;
}

get_spawner_and_spawn_goons(var_0) {
  var_1 = 0;

  if(var_0 <= 0) {
    if(var_0 < 0) {
      scripts\cp\zombies\zombies_spawning::_id_A5FA(abs(var_0));
    }

    return 0;
  }

  var_2 = min(var_0, 1);
  _id_1071C(var_2);
  return var_2;
}

_id_1071C(var_0) {
  var_1 = 0.3;
  var_2 = 0.7;

  if(var_0 > 0) {
    scripts\cp\zombies\zombies_spawning::_id_93E6(var_0);
    var_3 = [];
    var_4 = scripts\engine\utility::getStruct("brute_hide_org", "targetname");
    var_5 = 0;

    while(var_5 < var_0) {
      var_6 = _id_10719(var_4);

      if(isDefined(var_6)) {
        var_5++;
        var_6 setgoalpos(var_6.origin);
        var_6 scripts\anim\notetracks_mp::setstatelocked(1, "spawn_in_box");
        var_6.ignoreall = 1;
        var_6.ignoreme = 1;
        var_6.scripted_mode = 1;
        var_3[var_3.size] = var_6;
      }

      wait 0.1;
    }

    var_7 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
    var_7.in_use = 1;
    var_7.lastspawntime = gettime();
    thread scripts\cp\utility::playsoundinspace("zombie_spawn_lightning", var_7.origin);

    for(var_8 = 0; var_8 < var_3.size; var_8++) {
      var_6 = var_3[var_8];
      var_9 = scripts\cp\zombies\zombies_spawning::_id_772C(var_7.origin, var_7.angles);
      var_6.spawner = var_9;
      _id_1B99(var_6.spawner);
      var_6 scripts\cp\zombies\zombies_spawning::move_to_spot(var_6.spawner);
      var_6.ignoreme = 0;
      var_6.scripted_mode = 0;
      var_6 scripts\anim\notetracks_mp::setstatelocked(0, "spawn_in_box");
      var_9 = undefined;
      scripts\cp\zombies\zombies_spawning::_id_4FB6(1);
      var_6 thread scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent::setup_eye_glow();
      wait(randomfloatrange(var_1, var_2));
    }

    var_7.in_use = 0;
  }
}

_id_1B99(var_0) {
  var_1 = level._effect["goon_spawn_bolt"];
  playFX(var_1, var_0.origin);
  playFX(level._effect["drone_ground_spawn"], var_0.origin, (0, 0, 1));
  playrumbleonposition("grenade_rumble", var_0.origin);
  earthquake(0.3, 0.2, var_0.origin, 500);
}

move_to_spot(var_0) {
  var_1 = getclosestpointonnavmesh(var_0.origin);
  self dontinterpolate();
  self setOrigin(var_0.origin, 1);
  self scragentsetgoalpos(var_0.origin);
  self.ignoreall = 0;
}

_id_772C(var_0, var_1) {
  var_2 = 50;
  var_3 = 50;
  var_4 = spawnStruct();
  var_4.angles = var_1;
  var_5 = var_4.origin;
  var_6 = 0;

  while(!var_6) {
    var_7 = randomintrange(var_2 * -1, var_2);
    var_8 = randomintrange(var_3 * -1, var_3);
    var_5 = getclosestpointonnavmesh((var_0[0] + var_7, var_0[1] + var_8, var_0[2]));
    var_6 = 1;

    foreach(var_10 in level.players) {
      if(positionwouldtelefrag(var_5)) {
        var_6 = 0;
      }
    }

    if(!var_6) {
      wait 0.1;
    }
  }

  var_4.origin = var_5 + (0, 0, 5);
  return var_4;
}

_id_10719(var_0) {
  var_1 = "zombie_sasquatch";
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = "axis";
  var_5 = scripts\mp\mp_agent::spawnnewagent(var_1, var_4, var_2, var_3);

  if(isDefined(var_5)) {
    var_5.voprefix = level.zombie_sasquatch_vo_prefix;
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_5, "spawn", 1);
    var_5 setavoidanceradius(4);
    var_0.lastspawntime = gettime();
    var_5 thread sasquatch_audio_monitor();
    var_5 thread scripts\cp\zombies\zombies_spawning::_id_64E7(var_1);
    level notify("agent_spawned", var_5);
  }

  return var_5;
}

sasquatch_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix, undefined, 1);
  self.playing_stumble = 0;

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(6, "attack_hit", "attack_miss", "attack_charge");

    switch (var_0) {
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
  var_0 = scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn();
  return var_0;
}

get_scored_goon_spawn_location() {
  var_0 = undefined;
  var_0 = _id_79EC();
  return var_0;
}

_id_79EC() {
  var_0 = [];

  foreach(var_2 in level._id_162C) {
    if(scripts\engine\utility::is_true(var_2.active) && !scripts\engine\utility::is_true(var_2.in_use)) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size > 0) {
    var_2 = _id_8456(var_0);

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  return scripts\engine\utility::random(var_0);
}

_id_8456(var_0) {
  var_1 = [];
  var_2 = 2;
  var_3 = 1;
  var_4 = 5000;

  foreach(var_6 in var_0) {
    if(scripts\cp\zombies\_id_0D60::_id_800B(var_6.volume)) {
      var_1[var_1.size] = var_6;
      var_6.modifiedspawnpoints = var_2;
      continue;
    }

    if(isDefined(var_6.volume._id_186E)) {
      foreach(var_8 in var_6.volume._id_186E) {
        if(scripts\cp\zombies\_id_0D60::_id_800B(var_8)) {
          var_1[var_1.size] = var_6;
          var_6.modifiedspawnpoints = var_3;
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

  if(!isDefined(var_23)) {
    return undefined;
  }

  foreach(var_6 in var_1) {
    var_21 = "";
    var_26 = 0;
    var_27 = var_6.modifiedspawnpoints * randomintrange(var_18, var_19);
    var_28 = randomint(100);

    if(isDefined(var_6._id_BF6C) && var_6._id_BF6C >= var_22) {
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
      var_17 = var_6;
      var_20 = var_21;
      var_24[var_24.size] = var_6;
    }
  }

  if(!isDefined(var_17)) {
    return undefined;
  }

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

  var_17._id_BF6C = var_22 + var_4;
  return var_17;
}

getvalidplayersinarray() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_2.linked_to_coaster)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return scripts\engine\utility::random(var_0);
}

_id_9608() {
  level.goon_spawners = [];
  var_0 = scripts\engine\utility::getStructArray("dog_spawner", "targetname");

  if(isDefined(level.goon_spawner_patch_func)) {
    [[level.goon_spawner_patch_func]](var_0);
  }

  foreach(var_2 in var_0) {
    var_3 = 0;

    foreach(var_5 in level.invalid_spawn_volume_array) {
      if(ispointinvolume(var_2.origin, var_5)) {
        var_3 = 1;
      }
    }

    if(!var_3) {
      foreach(var_5 in level.spawn_volume_array) {
        if(ispointinvolume(var_2.origin, var_5)) {
          if(!isDefined(var_2.angles)) {
            var_2.angles = (0, 0, 0);
          }

          level.goon_spawners[level.goon_spawners.size] = var_2;
          var_2.volume = var_5;

          if(!isDefined(var_5.goon_spawners)) {
            var_5.goon_spawners = [];
          }

          var_5.goon_spawners[var_5.goon_spawners.size] = var_2;
          break;
        }
      }
    }
  }
}

move_goon_spawner(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_1, var_0, 500);
  var_3.origin = var_2;
}

_id_3712() {
  var_0 = 400;

  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_0 = 400;
      break;
    case 2:
      var_0 = 900;
      break;
    case 3:
      var_0 = 1300;
      break;
    default:
      var_0 = 1600;
  }

  return var_0;
}

_id_7CE3() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var_0 = getEntArray(self.target, "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  }

  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.remove_me)) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size > 0) {
    var_0 = scripts\engine\utility::array_remove_array(var_0, var_1);
  }

  return var_0;
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

_id_77D3() {
  if(isDefined(level._id_186E[self.basename])) {
    var_0 = [];

    foreach(var_2 in level._id_186E[self.basename]) {
      var_0[var_0.size] = level._id_10817[var_2];
    }

    return var_0;
  }

  return [];
}

_id_7999() {
  var_0 = getEntArray(self.script_linkname, "script_noteworthy");

  if(isDefined(var_0) && var_0.size != 0) {
    self._id_665B = var_0;
  }
}

_id_4F1E() {
  level endon("game_ended");
  var_0 = getdvarint("scr_spawn_start_delay");

  if(var_0 > 0) {
    wait(var_0);
  }
}

_id_1294D() {
  foreach(var_1 in level.active_spawners) {
    var_1.active = 0;
    var_1 notify("dont_restart_spawner");
  }

  level.active_spawners = [];
}

should_spawn_clown() {
  if(isDefined(level.no_clown_spawn)) {
    return 0;
  }

  if(isDefined(level.respawn_data)) {
    if(level.respawn_data.type == "zombie_sasquatch") {
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
  }

  return 0;
}

_id_AD62() {
  level endon("game_ended");

  for(;;) {
    if(getdvarint("scr_reserve_spawning") > 0) {
      level._id_E1CC = getdvarint("scr_reserve_spawning");
    }

    wait 1.0;
  }
}

_id_726E() {
  level notify("force_spawn_wave_done");
  wait 0.1;
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

_id_5173(var_0) {
  scripts\engine\utility::waittill_any("death", "emerge_done");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

calculatezombiehealth(var_0) {
  var_1 = 0;
  var_2 = level.wave_num;

  if(isDefined(level._id_8CBD) && isDefined(level._id_8CBD[var_0])) {
    var_1 = [[level._id_8CBD[var_0]]]();
  } else {
    if(isDefined(level.wave_num_override)) {
      var_2 = level.wave_num_override;
    }

    if(scripts\engine\utility::is_true(self.is_cop)) {
      var_2 = var_2 + 3;
    }

    if(scripts\engine\utility::is_true(self.is_skeleton)) {
      var_2 = var_2 + 10;
    }

    var_3 = 150;

    if(var_2 == 1) {
      var_1 = var_3;
    } else if(var_2 <= 9) {
      var_1 = var_3 + (var_2 - 1) * 100;
    } else {
      var_4 = 950;
      var_5 = var_2 - 9;
      var_1 = var_4 * pow(1.1, var_5);
    }
  }

  if(isDefined(level._id_8CB3[var_0])) {
    var_1 = int(var_1 * level._id_8CB3[var_0]);
  }

  if(var_1 > 6100000) {
    var_1 = 6100000;
  }

  return int(var_1);
}

_id_F604(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!scripts\engine\utility::is_true(var_3.wearing_dischord_glasses)) {
      var_3 visionsetnakedforplayer(var_0, var_1);
    }
  }
}

_id_7848(var_0) {
  if(isDefined(level.available_event_func)) {
    return [[level.available_event_func]](var_0);
  }

  return "goon";
}

_id_7B1C() {
  return level.wave_num + 1;
}

_id_7D00(var_0, var_1) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 1;
  }

  return 10;
}

_id_7CA9(var_0) {
  var_1 = ["generic_zombie"];
  return var_1;
}

get_max_static_enemies(var_0) {
  if(scripts\cp\utility::is_escape_gametype() && var_0 < 5) {
    var_1 = level.players.size * 6;
    var_2 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
    var_3 = 1;
    var_4 = 1;
    var_3 = var_2[var_0];
    var_5 = level.players.size - 1;

    if(var_5 < 1) {
      var_5 = 0.5;
    }

    var_6 = (24 + var_5 * 6 * var_4) * var_3;
    return int(min(var_1, var_6));
  }

  return 24;
}

get_total_spawned_enemies(var_0) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 9000;
  }

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

  var_5 = (24 + var_4 * 6 * var_3) * var_2;
  return int(var_5);
}

_id_7CFF(var_0) {
  return 1;
}

_id_13691() {
  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    wait 1.0;
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

_id_13FA2() {
  foreach(var_1 in level.spawn_volume_array) {
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

cp_rave_cleanup_main() {
  var_0 = 0;
  level._id_BE23 = 0;

  for(;;) {
    scripts\engine\utility::waitframe();
    var_1 = gettime();

    if(var_1 < var_0) {
      continue;
    }
    if(isDefined(level._id_BE22)) {
      var_2 = gettime() / 1000;
      var_3 = var_2 - level._id_BE22;

      if(var_3 < 0) {
        continue;
      }
      level._id_BE22 = undefined;
    }

    var_4 = (var_1 - level._id_13BDA) / 1000;

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
      if(level._id_BE23 >= 1) {
        level._id_BE23 = 0;
        scripts\engine\utility::waitframe();
      }

      if(_id_380D(var_8)) {
        var_8 _id_5773(var_5);
      }
    }
  }
}

_id_380D(var_0) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_ghost") {
    return 0;
  }

  if(isDefined(var_0._id_2BF9)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.is_turned)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.dont_cleanup)) {
    return 0;
  }

  if(isDefined(var_0.delay_cleanup_until) && gettime() < var_0.delay_cleanup_until) {
    return 0;
  }

  return 1;
}

_id_5773(var_0) {
  if(!isalive(self)) {
    return;
  }
  if(!_id_FF1A(self)) {
    return;
  }
  var_1 = gettime() - self.spawn_time;

  if(var_1 < 5000) {
    return;
  }
  if(self.agent_type == "generic_zombie" || self.agent_type == "lumberjack") {
    if(var_1 < 45000 && !self.entered_playspace) {
      return;
    }
  }

  var_2 = 1;
  var_3 = 0;
  var_4 = 1;

  if(scripts\engine\utility::is_true(self.dismember_crawl) && level.desired_enemy_deaths_this_wave - level.current_enemy_deaths < 2) {
    var_3 = 1;
    var_0 = 250000;
    var_2 = 0;
  } else {
    if(level._id_B789.size == 0) {
      if(isDefined(level.use_adjacent_volumes)) {
        var_2 = scripts\cp\zombies\zombies_spawning::_id_8016(1, 0);
      } else {
        var_2 = scripts\cp\zombies\zombies_spawning::_id_8016(0, 0);
      }
    } else {
      var_2 = scripts\cp\zombies\zombies_spawning::_id_8016(1, 0);

      if(var_2) {
        var_4 = scripts\cp\zombies\zombies_spawning::_id_8016(0, 1);
      }
    }

    if(var_2) {
      var_5 = undefined;

      foreach(var_7 in level.active_spawn_volumes) {
        if(self istouching(var_7)) {
          var_5 = var_7;
          break;
        }
      }

      if(isDefined(var_5) && var_5.basename == "island") {
        var_9 = scripts\cp\zombies\_id_0D60::_id_800B(var_5);

        if(var_9 == 0) {
          var_2 = 0;
        }
      }
    }
  }

  level._id_BE23++;

  if(!var_2 || !var_4) {
    var_10 = 10000000;
    var_11 = level.players[0];

    foreach(var_13 in level.players) {
      var_14 = distancesquared(self.origin, var_13.origin);

      if(var_14 < var_10) {
        var_10 = var_14;
        var_11 = var_13;
      }
    }

    if(isDefined(var_0)) {
      var_16 = var_0;
    } else if(isDefined(var_11) && scripts\cp\zombies\zombies_spawning::_id_CF4C(var_11)) {
      var_16 = 189225;
    } else {
      var_16 = 250000;
    }

    if(var_10 >= var_16) {
      if(!var_4) {
        if(level.last_mini_zone_fail + 1000 > gettime()) {
          return;
        } else {
          level.last_mini_zone_fail = gettime();
        }
      }

      thread _id_51A5(var_10, var_3);
    }
  }
}

_id_FF1A(var_0) {
  if(!isDefined(var_0.agent_type)) {
    return 0;
  }

  switch (var_0.agent_type) {
    case "superslasher":
    case "slasher":
      return 0;
    default:
      return 1;
  }
}

_id_51A5(var_0, var_1) {
  if(scripts\engine\utility::is_true(self._id_93A7)) {
    return;
  }
  if(var_1) {
    if(scripts\engine\utility::is_true(self.isactive)) {
      _id_EDF6();
    } else {}
  } else {
    foreach(var_3 in level.players) {
      if(scripts\engine\utility::is_true(var_3.spectating)) {
        continue;
      }
      if(scripts\engine\utility::is_true(var_3.is_fast_traveling)) {
        continue;
      }
      if(scripts\engine\utility::is_true(var_3.in_afterlife_arcade)) {
        continue;
      }
      if(scripts\cp\zombies\zombies_spawning::_id_CFB2(var_3)) {
        if(var_0 < 4000000) {
          return;
        }
      }
    }

    self.died_poorly = 1;

    if(scripts\engine\utility::is_true(self.marked_for_challenge) && isDefined(level.num_zombies_marked)) {
      level.num_zombies_marked--;
    }

    if(scripts\engine\utility::is_true(self.isactive)) {
      self.nocorpse = 1;
      _id_EDF6();
    }
  }
}

_id_EDF6() {
  self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
}