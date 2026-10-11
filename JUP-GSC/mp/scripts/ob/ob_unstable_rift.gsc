/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\ob\ob_unstable_rift.gsc
***********************************************/

#using script_100adcc1cc11d2fa;
#using script_16ea1b94f0f381b3;
#using script_1feb0785278dafea;
#using script_2d400da2610fe542;
#using script_39d11000e476a42a;
#using script_3a13b8032b62a5e6;
#using script_443d99fe707f1d9f;
#using script_46c7c73b1a7e4773;
#using script_482376d10f69832c;
#using script_4e6e58ab5d96c2b0;
#using script_62a4f7a62643fe8;
#using script_638d701d263ee1ed;
#using script_686729055b66c6e4;
#using script_6f65366f542f6627;
#using script_7d3e27aa82b5d70b;
#using script_7f9409b703dad400;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#namespace ob_unstable_rift;

function autoexec auto() {
  if(getdvarint(@ "ob_unstable_rift", 0)) {
    utility::registersharedfunc("ob_unstable_rift", "init_mode", &init);
  }
}

function init() {
  ob_music::function_43983d74c830fa72("outbreak_riftrun");
  callback::add("player_connect", &function_252a3e0c6aa4be7b);
  callback::add("player_spawned", &_player_spawned);
  level.var_1bd22d3c8d75c6b2 = getdvarint(@ "hash_db836b47db5e3129", 1);
  level.var_e7e662c51dc0814a = "ob_jup_items_enemy_droplist_zombie_unstable_rift";
  thread infil_music();
  thread disable_powerups();
  thread init_lightning();
  thread init_locations();
  thread function_6482371d6e2a939e();

  thread init_debug();

  level function_24f7bf25b01b1d1f();
}

function private function_252a3e0c6aa4be7b(params) {
  utility::delaythread(0.5, &ob_music::function_1b4c60d1baa7885f, "outbreak_riftrun");

  if(level.var_1bd22d3c8d75c6b2) {
    self setclientomnvar("ui_bones_collected", 1);
    self setclientomnvar("ui_skulls_collected", 1);
  }

  thread function_4dc6d733de3023c2(self);
}

function private _player_spawned(params) {
  self setscriptablepartstate(#"jup_ob_fx", #"jup_ob_rift_run_fx");
  self.rift_run = 1;
  self dlog_recordplayerevent("dlog_event_ob_player_rift_run", ["started", 1, "difficulty", "unstable"]);
  thread function_e6d957d831735a78(self);
  thread function_d9fcb5cdd7d24bc4(self);
  thread function_dfd367bda1930fc(self);
  thread function_34270462e5904a4e(self);
}

function function_34270462e5904a4e(player) {
  level endon("prematch_done");
  timeout = gettime() + 1000 * getdvarint(@ "scr_game_matchstarttime", 15);

  while(gettime() < timeout) {
    self setstance("stand", 1, 1, 1);
    waitframe();
  }
}

function infil_music() {
  level utility::waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  setmusicstate(#"hash_88391f4cf248aa2c");

  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_prematch", 2);
  }
}

function disable_powerups() {
  utility::flag_wait("drop_powerups");
  utility::flag_clear("drop_powerups");
}

function function_6823175ab6619608(alias_to_play) {
  foreach(player in level.players) {
    player playlocalsound(alias_to_play);
  }
}

function function_e6d957d831735a78(player) {
  if(!getdvarint(@ "hash_9a9b2f52ec9b721c", 1)) {
    return;
  }

  player utility::ent_flag_wait("map_to_map_instances_restored");
  weapon_pap = getdvarint(@ "hash_e018e41448064bea", 3);

  if(weapon_pap > 0) {
    var_de6f1105d742abba = 0;
    current_weapon = player getcurrentweapon();
    index = 0;

    while(index < self.primaryweapons.size) {
      weapon = self.primaryweapons[index];

      if(issameweapon(current_weapon, weapon)) {
        var_de6f1105d742abba = index;
      }

      if(player pack_a_punch::can_pap(weapon)) {
        current_pap = player pack_a_punch::get_pap_level(weapon);

        if(current_pap < weapon_pap) {
          player pack_a_punch::pap_weapon(weapon, weapon_pap - 1);
          var_358b55482058f45b = weapon getnoaltweapon();

          if(weapon != var_358b55482058f45b) {
            player takeweapon(weapon);
            player giveweapon(var_358b55482058f45b);
            player switchtoweapon(var_358b55482058f45b);
            player givemaxammo(var_358b55482058f45b);
          }

          waitframe();
        }
      }

      index += 1;
    }

    player switchtoweapon(self.primaryweapons[var_de6f1105d742abba]);
  }

  weapon_rarity = getdvarint(@ "hash_c98d511d22d09cb6", 4);

  if(weapon_rarity > 0) {
    weapons = player getweaponslistall();

    foreach(weapon in weapons) {
      if(!weapon::iswonderweapon(weapon)) {
        current_rarity = player namespace_736197e4d378b91b::function_75e73212bbe447d9(weapon);

        if(current_rarity < weapon_rarity) {
          player namespace_736197e4d378b91b::function_3a0412b800f3331d(weapon, weapon_rarity);
          waitframe();
        }
      }
    }
  }

  if(getdvarint(@ "hash_f116cb4dd07fc940", 1)) {
    if(!istrue(player.hasgoldenammo)) {
      player utility::callsharedfunc("ob_golden_ammo", "set_goldenAmmo");
    }
  }

  if(getdvarint(@ "hash_3e375980aa802475", 1)) {
    if(!istrue(player.var_28c033c3c5b37f1f)) {
      player utility::callsharedfunc("ob_armor", "set_golden_armor");
    }
  }

  if(getdvarint(@ "hash_dfecfd3a6a3d8e1d", 1)) {
    perks = ["specialty_speedcola", "specialty_quickrevive", "specialty_juggernog", "specialty_phd_flopper", "specialty_deadshot", "specialty_staminup", "specialty_death_perception", "specialty_elemental_pop"];

    if(getdvarint(@ "hash_22da4068cf8b9b2f", 0)) {
      perks[perks.size] = "specialty_tombstone";
    }

    foreach(perk in perks) {
      if(!player zombie_perks::has_perk(perk)) {
        player zombie_perks::give_perk(perk, 0);
        waitframe();
      }
    }
  }
}

function init_lightning() {
  if(!getdvarint(@ "hash_5aae445a39111a65", 1)) {
    return;
  }

  utility::flag_wait("objidpoolmanager_initialized");
  level.var_de371020b7c43674 = getdvarint(@ "hash_be896089b3b04a75", 200);
  level.var_6aada0ffd2de106f = getdvarint(@ "hash_ee56b19ae40889ec", 200);
  level.var_3420a36c00dc27d1 = getdvarint(@ "hash_e2930c1667585f86", 50);
  level.var_b9a0e95957ebb0fa = getdvarint(@ "hash_d320074c5a54dd21", 1);
  level.var_6ab10c8bcb43f306 = getdvarint(@ "hash_4307b71f87da92eb", 30);
  level.var_dd85fd4726271a7b = getdvarint(@ "hash_76909227ecadab2a", 3);
  level.var_f3b6938b349a401 = getdvarfloat(@ "hash_aa41d81431d5040", 100);
  level.var_c338e159d5bb9a6e = getdvarint(@ "hash_5bffcc9f45ad612f", 400);
  level.var_e415cde5da5a3409 = getdvarint(@ "hash_310ec56351cc5002", 600);
  level.var_2b182934c713e39a = spawnscriptable(%"hash_67315e48e910687f", (0, 0, 0));
  scriptable::scriptable_addnotifycallback("aether_storm_lightning_strike_damage", &_lightning_strike_damage);
  scriptable::scriptable_addnotifycallback("aether_storm_lightning_strike_finished", &_lightning_strike_finished);
  level.var_a244b385cd427036 = objective_marker_bundle_helper::createobjectivemarkerfrombundlexhash(%"hash_528cbe8d883829a4");
  objidpoolmanager::function_f21e9b2e78de984b(level.var_a244b385cd427036, level.var_c338e159d5bb9a6e, level.var_e415cde5da5a3409);
  objective_disableping(level.var_a244b385cd427036, 1);
  objective_setpings(level.var_a244b385cd427036, 0);
  function_a16750cd44f57931(level.var_a244b385cd427036, 0);
  function_1a20f52de11ba2ef(level.var_a244b385cd427036, 1);
}

function function_d9fcb5cdd7d24bc4(player) {
  level endon("game_ended");
  player endon("disconnect");

  if(!getdvarint(@ "hash_5aae445a39111a65", 1)) {
    return;
  }

  last_origin = player.origin;
  lightning_delay = level.var_6ab10c8bcb43f306;
  player.var_3420a36c00dc27d1 = 0;
  iteration_duration = 0.5;
  var_8689ace32731da70 = 0;
  utility::flag_wait("ob_unstable_rift_phase_in_progress");

  while(true) {
    wait iteration_duration;

    if(utility::flag("ob_unstable_rift_phase_in_progress") && isalive(player) && player.sessionstate == "playing" && !istrue(player.inlaststand)) {
      if(distancesquared(last_origin, player.origin) < level.var_f3b6938b349a401) {
        var_8689ace32731da70 += iteration_duration;
      } else {
        var_8689ace32731da70 = 0;
        lightning_delay = level.var_6ab10c8bcb43f306;
        player.var_3420a36c00dc27d1 = 0;
      }

      if(var_8689ace32731da70 >= lightning_delay) {
        lightning_state = level.var_2b182934c713e39a getscriptablepartstate(#"strike", 1);

        if(isDefined(lightning_state) && getxhash(lightning_state) == #"on") {
          level.var_2b182934c713e39a waittill("aether_storm_lightning_strike_finished");
        }

        function_655a1532a10e2e3a(player.origin);
        lightning_delay = level.var_dd85fd4726271a7b;
        player.var_3420a36c00dc27d1 += level.var_3420a36c00dc27d1;
        var_8689ace32731da70 = 0;
      }
    } else {
      var_8689ace32731da70 = 0;
      lightning_delay = level.var_6ab10c8bcb43f306;
      player.var_3420a36c00dc27d1 = 0;
    }

    last_origin = player.origin;
  }
}

function function_655a1532a10e2e3a(strike_origin) {
  objidpoolmanager::update_objective_position(level.var_a244b385cd427036, strike_origin);
  objidpoolmanager::update_objective_state(level.var_a244b385cd427036, "current");
  objidpoolmanager::objective_playermask_showtoall(level.var_a244b385cd427036);
  level.var_2b182934c713e39a.origin = strike_origin;
  level.var_2b182934c713e39a setscriptablepartstate(#"strike", #"on");
  level.var_2b182934c713e39a waittill("aether_storm_lightning_strike_finished");
  objidpoolmanager::objective_playermask_hidefromall(level.var_a244b385cd427036);
  objidpoolmanager::update_objective_state(level.var_a244b385cd427036, "empty");
}

function private _lightning_strike_damage(instance, note, param, instigator) {
  profilebeginevent(#"hash_dba294ecb4b55928");
  radiusdamage(instance.origin, level.var_6aada0ffd2de106f, level.var_de371020b7c43674, level.var_de371020b7c43674, undefined, undefined, undefined, 1, 1);
  players = namespace_2b1145f62aa835b8::getplayersinradiussharedfunc(instance.origin, level.var_6aada0ffd2de106f);

  foreach(player in players) {
    thread aether_storm::function_1ccf067179383388(player, level.var_b9a0e95957ebb0fa, level.var_de371020b7c43674 + player.var_3420a36c00dc27d1);
  }

  zombies = getaiarrayinradius(instance.origin, level.var_6aada0ffd2de106f, "team_two_hundred");

  foreach(zombie in zombies) {
    thread aether_storm::function_1e93e4747cd83387(zombie, level.var_b9a0e95957ebb0fa, level.var_de371020b7c43674);
  }

  soldiers = getaiarrayinradius(instance.origin, level.var_6aada0ffd2de106f, "team_hundred_ninety");

  foreach(soldier in soldiers) {
    thread aether_storm::function_88888e5d4a0feebd(soldier, level.var_b9a0e95957ebb0fa, level.var_de371020b7c43674);
  }

  profileendevent();
}

function private _lightning_strike_finished(instance, note, param, instigator) {
  instance notify("aether_storm_lightning_strike_finished");
}

function init_locations() {
  locations_structs = utility::getStructArray("ob_unstable_rift_location", "script_noteworthy");

  if(!isDefined(locations_structs) || locations_structs.size == 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  location_index = getdvarint(@ "ob_unstable_rift_location", 0);
  location_struct = locations_structs[location_index];

  if(!(isDefined(location_struct) && isDefined(location_struct.targetname))) {
    assertmsg("<dev string:x63>" + location_index + "<dev string:xba>");
    return;
  }

  level.ob_unstable_rift_location = location_struct.targetname;
  thread function_d583b3fb3ef5c2af();
  thread init_spawnpoints();
  thread function_ea68c637f5f2ced4();
  thread init_blockers();
  thread init_teleporters();
  thread init_circle();
  thread function_86fca51eef9cd72a();
  thread function_365a84e613d680e1();
  thread function_7201098f8c39c87c();
  thread init_phases();
}

function function_d583b3fb3ef5c2af() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_14ee95ef4ca3a48b", 1)) {
    return;
  }

  location_volumes = getnoentvolumearray(level.ob_unstable_rift_location, "target");
  var_846432ad9b08b0b8 = getnoentvolumearray("ob_unstable_rift_aiallowedvolume", "script_noteworthy");
  level.var_c3d0776d96557e6b = [];

  foreach(location_volume in location_volumes) {
    foreach(var_2ff870ac3005041b in var_846432ad9b08b0b8) {
      if(location_volume == var_2ff870ac3005041b) {
        level.var_c3d0776d96557e6b[level.var_c3d0776d96557e6b.size] = var_2ff870ac3005041b;
      }
    }
  }

  level.var_442d9fc484b29f2a = getdvarint(@ "hash_74cc7e480e40c375", 0);
  level.var_31256873a5b8c323 = 1000 * getdvarint(@ "hash_11ae392c211797ab", 10);
  level.var_88efa857926fb89a = getdvarfloat(@ "hash_ada47bd2212a0879", 100);
  level.var_bc2bd152a41a0007 = throttle::throttle_initialize("ob_unstable_rift_ai_recycle", 1, level.framedurationseconds);
  utility::flag_set("ob_unstable_rift_ai_allowed_volumes_initialized");
}

function init_spawnpoints() {
  level endon("game_ended");
  utility::flag_wait("onStartGameTypeFinished");
  spawnpoint_structs = utility::getStructArray("ob_unstable_rift_spawnpoint", "script_noteworthy");

  if(!isDefined(spawnpoint_structs) || spawnpoint_structs.size == 0) {
    assertmsg("<dev string:xbf>");
    return;
  }

  spawnpoints = [];

  foreach(spawnpoint_struct in spawnpoint_structs) {
    if(isDefined(spawnpoint_struct.target) && spawnpoint_struct.target == level.ob_unstable_rift_location) {
      spawnpoint_struct.index = -1;
      spawnpoints[spawnpoints.size] = spawnpoint_struct;
    }
  }

  if(spawnpoints.size < getdvarint(@ "party_maxsquadsize", 1)) {
    assertmsg("<dev string:x108>" + getdvarint(@ "party_maxsquadsize", 1) + "<dev string:x165>" + level.ob_unstable_rift_location + "<dev string:xba>");
    return;
  }

  level.var_7a8e039103b51e0f = [spawnpoints];
}

function function_ea68c637f5f2ced4() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_63af639e39b05351", 1)) {
    return;
  }

  utility::flag_wait("scriptables_ready");
  var_667c061e2d30b35 = utility::getStructArray("ob_unstable_rift_ammorestock", "script_noteworthy");

  if(!isDefined(var_667c061e2d30b35)) {
    return;
  }

  foreach(var_aae1fe89f3376484 in var_667c061e2d30b35) {
    if(isDefined(var_aae1fe89f3376484.target) && var_aae1fe89f3376484.target == level.ob_unstable_rift_location) {
      spawnscriptable(%"military_ammo_restock_noent", var_aae1fe89f3376484.origin, var_aae1fe89f3376484.angles);
    }
  }
}

function init_blockers() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_976b609a5ca910a", 1)) {
    return;
  }

  utility::flag_wait("scriptables_ready");
  blocker_structs = utility::getStructArray("ob_unstable_rift_blocker", "script_noteworthy");

  if(!isDefined(blocker_structs)) {
    return;
  }

  foreach(blocker_struct in blocker_structs) {
    if(isDefined(blocker_struct.target) && isDefined(blocker_struct.script_parameters) && blocker_struct.target == level.ob_unstable_rift_location) {
      blocker = spawnscriptable(blocker_struct.script_parameters, blocker_struct.origin, blocker_struct.angles);
      blocker setscriptablepartstate(#"state", #"visible");
      waitframe();
    }
  }

  var_6e7df1777fb87d26 = utility::getStructArray("ob_unstable_rift_lockeddoor", "script_noteworthy");

  if(!isDefined(var_6e7df1777fb87d26)) {
    return;
  }

  foreach(var_6800f47d41b46431 in var_6e7df1777fb87d26) {
    if(isDefined(var_6800f47d41b46431.target) && var_6800f47d41b46431.target == level.ob_unstable_rift_location) {
      var_8c73c4add30bb4b2 = [];
      var_8c73c4add30bb4b2 = namespace_9e69d66f68c38a10::function_ad1b6accbaab404e(var_6800f47d41b46431, var_8c73c4add30bb4b2);

      foreach(door in var_8c73c4add30bb4b2) {
        door scriptabledoorfreeze(1);
      }
    }
  }
}

function init_teleporters() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_8f0e8bd70da52fd2", 1)) {
    return;
  }

  location_volumes = getnoentvolumearray(level.ob_unstable_rift_location, "target");
  teleport_volumes = getnoentvolumearray("ob_unstable_rift_teleportvolume", "script_noteworthy");
  level.var_52d7d5c63da761c5 = [];

  foreach(location_volume in location_volumes) {
    foreach(teleport_volume in teleport_volumes) {
      if(location_volume == teleport_volume) {
        level.var_52d7d5c63da761c5[level.var_52d7d5c63da761c5.size] = teleport_volume;
      }
    }
  }

  if(level.var_52d7d5c63da761c5.size == 0) {
    return;
  }

  teleport_destinations = utility::getStructArray("ob_unstable_rift_teleportdestination", "script_noteworthy");

  if(!isDefined(teleport_destinations) || teleport_destinations.size == 0) {
    assertmsg("<dev string:x177>");
    return;
  }

  teleport_destination = teleport_destinations[0];
  i = 1;

  while(i < teleport_destinations.size) {
    if(isDefined(teleport_destinations[i].target) && teleport_destinations[i].target == level.ob_unstable_rift_location) {
      teleport_destination = teleport_destinations[i];
      break;
    }

    i += 1;
  }

  if(!(isDefined(teleport_destination) && isDefined(teleport_destination.origin))) {
    assertmsg("<dev string:x1c9>" + level.ob_unstable_rift_location + "<dev string:xba>");
    return;
  }

  location_volumes = undefined;
  teleport_volumes = undefined;
  teleport_destinations = undefined;
  flags::function_1240434f4201ac9d("prematch_done");

  while(isDefined(level.players) && isDefined(level.players.size) && level.players.size > 0) {
    foreach(player in level.players) {
      wait 3;

      if(!isalive(player) || player.sessionstate != "playing") {
        continue;
      }

      foreach(volume in level.var_52d7d5c63da761c5) {
        if(ispointinvolume(player.origin, volume)) {
          player setOrigin(teleport_destination.origin);
          player setplayerangles(teleport_destination.angles);
        }

        break;
      }
    }
  }
}

function init_circle() {
  level endon("game_ended");
  utility::flag_wait("radiation_initialized");
  circle_structs = utility::getStructArray("ob_unstable_rift_circle", "script_noteworthy");

  if(!isDefined(circle_structs) || circle_structs.size == 0) {
    assertmsg("<dev string:x22a>");
    return;
  }

  circle_struct = circle_structs[0];
  i = 1;

  while(i < circle_structs.size) {
    if(isDefined(circle_structs[i].target) && circle_structs[i].target == level.ob_unstable_rift_location) {
      circle_struct = circle_structs[i];
      break;
    }

    i += 1;
  }

  if(!(isDefined(circle_struct.origin) && isDefined(circle_struct) && isDefined(circle_struct.radius))) {
    assertmsg("<dev string:x26f>" + level.ob_unstable_rift_location + "<dev string:xba>");
    return;
  }

  level.ob_unstable_rift_circle = circle_struct;
  level.var_692f2e697d0dce2d = radiation::create(circle_struct.origin, circle_struct.radius, 1, undefined, 1, 1);
  level.var_692f2e697d0dce2d radiation::set_damage(getdvarint(@ "hash_1b3e7d1776c644f1", 25));
  level.var_692f2e697d0dce2d callback::add("player_entered_radiation", &aether_storm::function_f4df458e2841cbf1);
  level.var_692f2e697d0dce2d callback::add("player_exited_radiation", &aether_storm::function_38b3b1600f7440b1);
  callback::add("player_death", &aether_storm::function_d0f8b9fdea272469);
  thread init_scrambler();
  thread function_12eef8228cdfcca();
}

function init_scrambler() {
  if(!getdvarint(@ "hash_424d0784d7cc6766", 1)) {
    return;
  }

  scrambler = spawn("script_model", level.ob_unstable_rift_circle.origin);

  while(true) {
    if(!isDefined(level.players) || level.players.size < 1) {
      waitframe();
      continue;
    }

    owner = level.players[0];
    scrambler.team = owner.team;
    scrambler makescrambler(owner, undefined, 100000, 1);
    owner waittill("disconnect");
    scrambler clearscrambler();
  }
}

function function_12eef8228cdfcca() {
  if(!getdvarint(@ "hash_d370dd5a570ca059", 1)) {
    return;
  }

  level.ontimelimit = &function_ae1ba841af6cdce;
  level endon("game_ended");
  flags::function_1240434f4201ac9d("prematch_done");
  setomnvar("ui_br_circle_state", 5);
}

function function_ae1ba841af6cdce() {
  if(istrue(level.var_997ed5aa1f9be84e)) {
    return;
  }

  level.var_29918f6b014e863a = getdvarint(@ "hash_edf2483ff5e69055", 900);
  setomnvar("ui_br_circle_state", 9);
  setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.var_29918f6b014e863a);
  level.var_692f2e697d0dce2d callback::add("radiation_transform_completed", &function_c1cb3c761c63d056);
  level.var_692f2e697d0dce2d radiation::transform(level.ob_unstable_rift_circle.origin, 0, level.var_29918f6b014e863a);
  level.var_997ed5aa1f9be84e = 1;
}

function private function_c1cb3c761c63d056(params) {
  wait 30;

  foreach(player in level.players) {
    if(isDefined(player)) {
      player thread ob::function_922c3629c545df86();

      if(isalive(player) && player.sessionstate == "playing") {
        player kill();
      }
    }
  }

  if(!istrue(level.gameended)) {
    wait getdvarint(@ "hash_b019df9b5745565b", 60);
    level thread gamelogic::endgame("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
  }
}

function function_86fca51eef9cd72a() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_677ef0af4dc0742f", 1)) {
    return;
  }

  utility::flag_wait("scriptables_ready");
  obelisk_structs = utility::getStructArray("ob_unstable_rift_obelisk", "script_noteworthy");

  if(!isDefined(obelisk_structs) || obelisk_structs.size == 0) {
    return;
  }

  level.var_3dffa560984ec742 = getdvarint(@ "hash_2c124bc3fbac8e93", 1);
  level.var_c802e79a1b639947 = getdvarint(@ "hash_89c0b21372f666e2", 24);
  level.var_6846603c748959ee = getdvarint(@ "hash_7520a3315d2e537b", 2);
  level.var_babdb329e82ada18 = getdvarint(@ "hash_b4d2aceffcbf7d23", 1);
  level.var_e9aa38ad22e6b2e5 = getdvarfloat(@ "hash_c2291c9b4a5b949a", 5);
  level.var_40b9af9adc0dadac = [];

  foreach(obelisk_struct in obelisk_structs) {
    if(isDefined(obelisk_struct.target) && obelisk_struct.target == level.ob_unstable_rift_location) {
      obelisk = spawnscriptable(%"jup_zm_rift_pedestal_base_scriptable", obelisk_struct.origin, obelisk_struct.angles);
      obelisk setscriptablepartstate(#"body", #"spawned_blank");
      obelisk setscriptablepartstate(#"interact", #"off");
      obelisk.top = spawnscriptable(%"jup_zm_rift_pedestal_top_scriptable", obelisk_struct.origin + (0, 0, 40), obelisk_struct.angles);
      obelisk.top setscriptablepartstate(#"fx", #"off");
      level.var_40b9af9adc0dadac[level.var_40b9af9adc0dadac.size] = obelisk;
    }
  }

  level.var_40b9af9adc0dadac = utility::array_randomize(level.var_40b9af9adc0dadac);
}

function function_1b4163237ac97fbd(phase) {
  if(!isDefined(level.var_40b9af9adc0dadac)) {
    return;
  }

  if(level.var_babdb329e82ada18) {
    utility::flag_wait("ob_unstable_rift_zombie_cleanup_completed");
  }

  obelisk = level.var_40b9af9adc0dadac[(phase - 1) % level.var_40b9af9adc0dadac.size];
  obelisk.top setscriptablepartstate(#"fx", #"blast");

  if(level.var_3dffa560984ec742) {
    if(isDefined(level.var_68d1155f7ce3315c)) {
      foreach(item in level.var_68d1155f7ce3315c) {
        common_item::function_c14962ea14e58968(item);
      }
    }

    level.var_68d1155f7ce3315c = [];
    item_names = function_6b35ded8b1d89ce8(%"hash_5127dbc8a423153f", level.var_c802e79a1b639947);
    var_ae216547caaaa3ce = item_names.size / level.var_6846603c748959ee;
    drop_options = common_item::function_59a2e61d79065dca(item_names.size, -1, 1, -1, 1, var_ae216547caaaa3ce, 60, 40);
    drop_options.var_7281c7ba7331bc41 = 360 / float(var_ae216547caaaa3ce) / 2;

    foreach(item_name in item_names) {
      item_bundle = getscriptbundle(hashcat(%"itemspawnentry:", item_name));
      item = common_item::function_c465d27f3f6066b4(item_bundle, obelisk.top.origin, undefined, 0, 1, undefined, drop_options);
      level.var_68d1155f7ce3315c[level.var_68d1155f7ce3315c.size] = item;
      waitframe();
    }

    return;
  }

  if(obelisk.top getscriptablepartstate(#"body") == "spawned") {
    obelisk.top setscriptablepartstate(#"body", #"destroyed");
  }

  if(level.var_e9aa38ad22e6b2e5 > 0) {
    wait level.var_e9aa38ad22e6b2e5;
  }

  reward_groups = [];

  foreach(player in level.players) {
    if(isPlayer(player)) {
      reward_groups[reward_groups.size] = [player];
    }
  }

  reward_placement = namespace_234722f5b7566015::function_3ae7f99339b96499(obelisk.top.origin);
  ob_objective_rewards::function_863be9e39e19fe2f(reward_groups, reward_placement, &function_ab644425428a09db);
}

function function_ab644425428a09db(var_f7f66a8bcca0ac73) {
  item_names = function_6b35ded8b1d89ce8(%"hash_5127dbc8a423153f", level.var_c802e79a1b639947);
  cache = spawnStruct();
  common_cache::function_fd95ef820bb2b980(item_names, cache);
  return cache.contents;
}

function function_365a84e613d680e1() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_96898ee0da00780e", 1)) {
    return;
  }

  portal_structs = utility::getStructArray("ob_unstable_rift_completionportal", "script_noteworthy");

  if(!isDefined(portal_structs) || portal_structs.size == 0) {
    assertmsg("<dev string:x2c3>");
    return;
  }

  var_5f770b539813a625 = [];

  foreach(portal_struct in portal_structs) {
    if(isDefined(portal_struct.target) && portal_struct.target == level.ob_unstable_rift_location) {
      var_5f770b539813a625[var_5f770b539813a625.size] = portal_struct;
    }
  }

  level.var_2e2204c429664d9b = 0;
  level.var_883c5bd44316cf99 = var_5f770b539813a625[randomint(var_5f770b539813a625.size)];
}

function function_5b531f4f333bd9b2() {
  level utility::flag_wait("scriptables_ready");

  if(getdvarint(@ "hash_6c90b3fbbd55a44a", 1)) {
    utility::flag_wait("ob_unstable_rift_zombie_cleanup_completed");
  }

  delay = getdvarfloat(@ "hash_94b57c4ac6024108", 5);

  if(delay > 0) {
    wait delay;
  }

  portal = spawnscriptable(%"hash_4b1a475882042d49", level.var_883c5bd44316cf99.origin, level.var_883c5bd44316cf99.angles);
  portal setscriptablepartstate(#"entrance_vfx", #"on");
  interaction::function_32645103f7520635(portal, &function_58d277c44be9198a);

  foreach(player in level.players) {
    player zombie_challenges::function_f10f600ac4ee4c09("s4_unstable_rift_complete", 3);
    player calloutmarkerping::calloutmarkerping_createcallout(18, portal.origin, portal.index);
  }
}

function private function_58d277c44be9198a(player) {
  if(!istrue(player.var_f52eb40ba99ffa4c)) {
    player.var_ad19e9b0668cd04d = 1;
    player.var_d0cbbb1229fbc61c = 1;
    thread namespace_cc781f142d33c074::function_b67447cfa15eb9e6(player);
  }
}

function function_7201098f8c39c87c() {
  level endon("game_ended");
  var_e2ac0976e9b8b1c5 = utility::getStructArray("ob_unstable_rift_tombstone", "script_noteworthy");
  level.var_99e2a67934970212 = [];
  level.var_5ee3bd4cf79f2988 = [];

  foreach(var_76cb032167a23454 in var_e2ac0976e9b8b1c5) {
    if(isDefined(var_76cb032167a23454.target) && var_76cb032167a23454.target == level.ob_unstable_rift_location) {
      level.var_5ee3bd4cf79f2988[level.var_5ee3bd4cf79f2988.size] = var_76cb032167a23454;
    }
  }

  level.var_5ee3bd4cf79f2988 = utility::array_randomize(level.var_5ee3bd4cf79f2988);
}

function function_4dc6d733de3023c2(player) {
  player utility::ent_flag_wait("map_to_map_instances_restored");
  player callback::add("zm_perk_obtained", &function_5708ac2d7dada287);
  waitframe();

  if(zombie_perks::has_perk("specialty_tombstone")) {
    thread function_2e2c433c560e6d5b(player);
  }
}

function private function_5708ac2d7dada287(params) {
  waitframe();

  if(params.specialtyperk == "specialty_tombstone") {
    thread function_2e2c433c560e6d5b(self);
  }
}

function function_2e2c433c560e6d5b(player) {
  if(getdvarint(@ "hash_93c23bac31ce4a07", 1)) {
    player notify("specialty_tombstone" + "_stop");
  }

  if(getdvarint(@ "hash_6439f260c9736d6c", 1)) {
    if(!(isDefined(level.var_5ee3bd4cf79f2988) && isDefined(level.var_5ee3bd4cf79f2988[player.sessionuimemberindex]))) {
      assertmsg("<dev string:x312>");
      return;
    }

    if(!isDefined(level.var_99e2a67934970212[player.sessionuimemberindex])) {
      var_76cb032167a23454 = level.var_5ee3bd4cf79f2988[player.sessionuimemberindex];
      tombstone = spawnscriptable(%"hash_56b821c70aef7c96", var_76cb032167a23454.origin, var_76cb032167a23454.angles, undefined, [#"teamselect", player getentitynumber()]);
      tombstone.var_55bb3585d29af1be = &function_90284af6102de992;
      level.var_99e2a67934970212[player.sessionuimemberindex] = tombstone;

      foreach(level_player in level.players) {
        if(level_player != player) {
          tombstone disablescriptableplayeruse(level_player);
        }
      }
    }
  }
}

function function_dfd367bda1930fc(player) {
  foreach(sessionindex, tombstone in level.var_99e2a67934970212) {
    if(player.sessionuimemberindex != sessionindex) {
      tombstone disablescriptableplayeruse(player);
    }
  }
}

function private function_90284af6102de992(scriptable, player) {
  scriptable setscriptablepartstate(#"hash_5562a9f3bc2269a9", #"shutdown");
  var_d01a68d4c8274caf = powerups::function_3f65dbe307c93086();

  if(isDefined(var_d01a68d4c8274caf)) {
    offset = (0, 0, isDefined(powerups::function_edeba0070ca0709e("drop_height_offset")) ? powerups::function_edeba0070ca0709e("drop_height_offset") : 0);
    level thread powerups::powerup_drop(var_d01a68d4c8274caf, scriptable.origin + offset, -1, 0);
  }

  wait 5;
  scriptable freescriptable();
}

function function_6482371d6e2a939e() {
  level.var_284af91c6f24b55d = [];
  level.var_284af91c6f24b55d["elite"] = getdvarint(@ "hash_82269fe03bcce69a", 999);
  level.var_3c3cafb0e6b2d8ad = [];
  level.var_3c3cafb0e6b2d8ad["zombie_disciple"] = "special";
  level.var_3c3cafb0e6b2d8ad["zombie_mangler"] = "special";
  level.var_3c3cafb0e6b2d8ad["zombie_mimic"] = "special";
  level.var_3c3cafb0e6b2d8ad["zombie_disciple_hvt"] = "elite";
  level.var_3c3cafb0e6b2d8ad["zombie_mangler_hvt"] = "elite";
  level.var_3c3cafb0e6b2d8ad["zombie_mimic_hvt"] = "elite";
  level.var_3c3cafb0e6b2d8ad["zombie_mimic_hvt_emp"] = "elite";
  level.var_14221129e7902e8 = [];
  level.var_14221129e7902e8["zombie_disciple"] = getdvarint(@ "hash_3241a434432f574d", 2);
  level.var_14221129e7902e8["zombie_mangler"] = getdvarint(@ "hash_d72430c68284205a", 4);
  level.var_14221129e7902e8["zombie_mimic"] = getdvarint(@ "hash_e6b77d14c76acde3", 2);
  level.var_5e094262cd9de258 = [];
  level.var_5e094262cd9de258["zombie_disciple"] = "zombie_disciple";
  level.var_5e094262cd9de258["zombie_disciple_hvt"] = "zombie_disciple";
  level.var_5e094262cd9de258["zombie_mangler"] = "zombie_mangler";
  level.var_5e094262cd9de258["zombie_mangler_hvt"] = "zombie_mangler";
  level.var_5e094262cd9de258["zombie_mimic"] = "zombie_mimic";
  level.var_5e094262cd9de258["zombie_mimic_hvt"] = "zombie_mimic";
  level.var_5e094262cd9de258["zombie_mimic_hvt_emp"] = "zombie_mimic";
  level.var_5e033493dbae5b3b = [];
  level.var_5e033493dbae5b3b["zombie_disciple"] = getdvarint(@ "hash_3fa79388c397814e", 2);
  level.var_5e033493dbae5b3b["zombie_disciple_hvt"] = getdvarint(@ "hash_3415fd39a43fe623", 1);
  level.var_5e033493dbae5b3b["zombie_mangler"] = getdvarint(@ "hash_6fcda416006922bf", 4);
  level.var_5e033493dbae5b3b["zombie_mangler_hvt"] = getdvarint(@ "hash_3f630e729c1d373a", 1);
  level.var_5e033493dbae5b3b["zombie_mimic"] = getdvarint(@ "hash_a12326250da8632a", 2);
  level.var_5e033493dbae5b3b["zombie_mimic_hvt"] = getdvarint(@ "hash_5726d8cd527b0c07", 1);
  level.var_5e033493dbae5b3b["zombie_mimic_hvt_emp"] = getdvarint(@ "hash_82404fcd71eb0dbb", 0);
  level.var_42da2a018b83a304 = [[[{
        #chance: 33, #tag: "zombie_base"}, {
        #chance: 67, #tag: "zombie_base_armored_light"}], [{
        #chance: 10, #tag: "zombie_hellhound"}, {
        #chance: 30, #tag: "zombie_base"}, {
        #chance: 60, #tag: "zombie_base_armored_light"}], [{
        #chance: 10, #tag: "zombie_hellhound"}, {
        #chance: 30, #tag: "zombie_base"}, {
        #chance: 60, #tag: "zombie_base_armored_light"}]], [[{
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_hellhound"}, {
        #chance: 30, #tag: "zombie_base"}, {
        #chance: 30, #tag: "zombie_base_armored_light"}, {
        #chance: 30, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_hellhound"}, {
        #chance: 5, #tag: "zombie_base_abom_crawler"}, {
        #chance: 28, #tag: "zombie_base"}, {
        #chance: 28, #tag: "zombie_base_armored_light"}, {
        #chance: 29, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_hellhound"}, {
        #chance: 5, #tag: "zombie_base_abom_crawler"}, {
        #chance: 28, #tag: "zombie_base"}, {
        #chance: 28, #tag: "zombie_base_armored_light"}, {
        #chance: 29, #tag: "zombie_base_armored_heavy"}]], [[{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 10, #tag: "zombie_base_abom_crawler"}, {
        #chance: 27, #tag: "zombie_base_armored_heavy"}, {
        #chance: 53, #tag: "zombie_base_armored_light"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 5, #tag: "zombie_hellhound"}, {
        #chance: 5, #tag: "zombie_base_abom_crawler"}, {
        #chance: 27, #tag: "zombie_base_armored_heavy"}, {
        #chance: 53, #tag: "zombie_base_armored_light"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 5, #tag: "zombie_hellhound"}, {
        #chance: 5, #tag: "zombie_base_abom_crawler"}, {
        #chance: 27, #tag: "zombie_base_armored_heavy"}, {
        #chance: 53, #tag: "zombie_base_armored_light"}]], [[{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 1, #tag: "zombie_mangler_hvt"}, {
        #chance: 4, #tag: "zombie_mangler"}, {
        #chance: 10, #tag: "zombie_base_abom_crawler"}, {
        #chance: 50, #tag: "zombie_base_armored_light"}, {
        #chance: 25, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 1, #tag: "zombie_mangler_hvt"}, {
        #chance: 4, #tag: "zombie_mangler"}, {
        #chance: 3, #tag: "zombie_hellhound"}, {
        #chance: 7, #tag: "zombie_base_abom_crawler"}, {
        #chance: 50, #tag: "zombie_base_armored_light"}, {
        #chance: 25, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt"}, {
        #chance: 4, #tag: "zombie_mimic"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 1, #tag: "zombie_mangler_hvt"}, {
        #chance: 4, #tag: "zombie_mangler"}, {
        #chance: 3, #tag: "zombie_hellhound"}, {
        #chance: 7, #tag: "zombie_base_abom_crawler"}, {
        #chance: 50, #tag: "zombie_base_armored_light"}, {
        #chance: 25, #tag: "zombie_base_armored_heavy"}]], [[{
        #chance: 3, #tag: "zombie_mimic_hvt"}, {
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 3, #tag: "zombie_disciple_hvt"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 4, #tag: "zombie_mangler_hvt"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 5, #tag: "zombie_base_abom_crawler"}, {
        #chance: 40, #tag: "zombie_base_armored_light"}, {
        #chance: 30, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt_emp"}, {
        #chance: 2, #tag: "zombie_mimic_hvt"}, {
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 3, #tag: "zombie_disciple_hvt"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 3, #tag: "zombie_mangler_hvt"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 3, #tag: "zombie_hellhound"}, {
        #chance: 3, #tag: "zombie_base_abom_crawler"}, {
        #chance: 40, #tag: "zombie_base_armored_light"}, {
        #chance: 30, #tag: "zombie_base_armored_heavy"}], [{
        #chance: 1, #tag: "zombie_mimic_hvt_emp"}, {
        #chance: 2, #tag: "zombie_mimic_hvt"}, {
        #chance: 5, #tag: "zombie_mimic"}, {
        #chance: 3, #tag: "zombie_disciple_hvt"}, {
        #chance: 5, #tag: "zombie_disciple"}, {
        #chance: 3, #tag: "zombie_mangler_hvt"}, {
        #chance: 5, #tag: "zombie_mangler"}, {
        #chance: 3, #tag: "zombie_hellhound"}, {
        #chance: 3, #tag: "zombie_base_abom_crawler"}, {
        #chance: 40, #tag: "zombie_base_armored_light"}, {
        #chance: 30, #tag: "zombie_base_armored_heavy"}]]];

  foreach(var_3b931715019009ce in level.var_42da2a018b83a304) {
    foreach(var_332af51fee9db3da in var_3b931715019009ce) {
      i = 1;

      while(i < var_332af51fee9db3da.size) {
        var_332af51fee9db3da[i].chance += var_332af51fee9db3da[i - 1].chance;
        i += 1;
      }
    }
  }

  level.var_9673c6e2468a0059 = [];
  level.var_245e7a85bf7c3a64 = [];
  level.var_620d3de3e96ca737 = [];
}

function init_phases() {
  level endon("game_ended");
  utility::flag_wait("ai_spawn_director_initialized");
  function_9b8829ab4092a7d7("ob_unstable_rift", 1);
  encounter_structs = utility::getStructArray("ob_unstable_rift_encounter", "script_noteworthy");

  if(!isDefined(encounter_structs) || encounter_structs.size == 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  encounter_struct = encounter_structs[0];
  i = 1;

  while(i < encounter_structs.size) {
    if(isDefined(encounter_structs[i].target) && encounter_structs[i].target == level.ob_unstable_rift_location) {
      encounter_struct = encounter_structs[i];
      break;
    }

    i += 1;
  }

  if(!(isDefined(encounter_struct.origin) && isDefined(encounter_struct) && isDefined(encounter_struct.radius))) {
    assertmsg("<dev string:x26f>" + level.ob_unstable_rift_location + "<dev string:xba>");
    return;
  }

  flags::function_1240434f4201ac9d("prematch_done");
  level.var_2ff7b3c5e5015098 = getdvarint(@ "hash_ce893a11e30c913f", 5);
  level.var_742fade356940bce = getdvarint(@ "hash_2eb10bce9cc1f08b", 3);
  level.var_46aa430cb8b7cb4f = getdvarint(@ "hash_50c7e8f57d331c64", 20);
  level.var_f5d5b9ef92679eb2 = getdvarint(@ "hash_793a9a89547ff9ff", 0);
  level.var_13b12aeb97840631 = getdvarint(@ "hash_823c58a31d140620", 10);
  level.var_c97170535c179e0 = getdvarint(@ "hash_44134d32ceb972cb", 3);
  level.var_a68f7ddeff300b0e = getdvarint(@ "hash_37e6f0f3e891f37d", 0);
  level.var_ba0849d2d702a9fa = getdvarint(@ "hash_ed6533497e44471", 120);
  level.var_18a90857ec380039 = getdvarint(@ "hash_e54ae1e22c7ea0d8", 1);
  level.var_5ab899501d7a8cc1 = getdvarint(@ "hash_30d547e8c702d690", 0);
  level.var_2d43671346b601f4 = getdvarint(@ "hash_b5c53367a9d4c65", 0);
  level.var_43eebc0b76a5046d = getdvarint(@ "hash_b0f8df164fa585ea", 0);
  level.var_df55b01624cc9bc2 = getdvarint(@ "hash_63a1deea883ae3b0", 45);
  level.var_d3fb98c219ff46d7 = getdvarint(@ "hash_87e349d7e26605c", 5);
  level.var_247a0d5e632874b1 = getdvarint(@ "hash_d9f787c92ab8f26f", 60);
  level.var_874f1d141bd8531a = getdvarint(@ "hash_e6240573fc06b361", 5);
  level.var_de00f175322567fb = getdvarint(@ "hash_e638566dc55e2c9b", 50);
  level.var_eea44450575931bc = getdvarint(@ "hash_2dc731de078895a5", 5);
  level.var_3c7d99e140c880d7 = getdvarint(@ "hash_df5670c5b94033ac", 1);
  level callback::remove("on_zombie_ai_spawned", &namespace_f721fc7d0d2d0f47::function_68a33f72cf283fdd, 1);
  level callback::add("on_zombie_ai_spawned", &function_a34cb18a0f721dfc);
  encounter_bundle = % "hash_31ee940d9ad45399";

  if(level.var_a68f7ddeff300b0e) {
    encounter_bundle = % "hash_4e22c4b8685d929c";
  }

  if(isDefined(encounter_struct.height)) {
    encounter_struct.origin += (0, 0, encounter_struct.height / 2);
  }

  level.ob_unstable_rift_encounter = ai_spawn_director::spawn_request(encounter_bundle, encounter_struct.origin, encounter_struct.radius, 0, 0, 0);
  function_adcc96a7d541aa36(level.ob_unstable_rift_encounter, 0);
  function_df930eed75d4f74f(level.ob_unstable_rift_encounter, encounter_struct.origin, encounter_struct.radius);
  ai_spawn_director::function_e4a67fe4ddca7ed5(level.ob_unstable_rift_encounter, &function_6e509d5aa1517140);
  ai_spawn_director::function_f81b7c3f18ef98be(level.ob_unstable_rift_encounter, &function_205f236b61b4df22);
  level.var_bc591e50323ade57 = ai_spawn_director::spawn_request(%"hash_232a9f95b1cbdfb4", encounter_struct.origin, encounter_struct.radius, 0, 0, 0);
  function_df930eed75d4f74f(level.var_bc591e50323ade57, encounter_struct.origin, encounter_struct.radius);
  ai_spawn_director::function_e4a67fe4ddca7ed5(level.var_bc591e50323ade57, &function_1f2fc07b5ccda54c);
  ai_spawn_director::function_bc5315dc37ae4cf(level.var_bc591e50323ade57, &function_645d046068cd16af);
  ai_spawn_director::function_73147cdf5c28d10c(level.var_bc591e50323ade57, &function_6ecd0a01e9730f0a);

  if(isDefined(encounter_struct.height)) {
    function_1b9b5d4a1c672ad1(level.ob_unstable_rift_encounter, encounter_struct.height / 2);
    function_1b9b5d4a1c672ad1(level.var_bc591e50323ade57, encounter_struct.height / 2);
  }

  var_fee3d0cd2d0e2e97 = getdvarfloat(@ "hash_580cc6f10c38ffa5", 15);

  if(var_fee3d0cd2d0e2e97 > 0) {
    wait var_fee3d0cd2d0e2e97;
  }

  thread do_phases();
}

function do_phases() {
  level endon("ob_unstable_rift_end_phases");
  level.var_63879ce0401fbcdd = isDefined(level.var_bbc1e3c5a5a3d286) ? level.var_bbc1e3c5a5a3d286 : 1;

  while(level.var_63879ce0401fbcdd <= level.var_2ff7b3c5e5015098) {
    level.var_c14a49c64f9f5d09 = "phase" + level.var_63879ce0401fbcdd;
    function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c14a49c64f9f5d09, 1);
    function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c14a49c64f9f5d09, 1);
    utility::flag_set("ob_unstable_rift_phase_in_progress");
    phase_started(level.var_63879ce0401fbcdd);
    level.var_aa7fa2b1f5d92ff = isDefined(level.var_a6a16c0a31a3d310) ? level.var_a6a16c0a31a3d310 : 1;

    while(level.var_aa7fa2b1f5d92ff <= level.var_742fade356940bce) {
      level.var_c967a3e3945fceef = "wave" + level.var_aa7fa2b1f5d92ff;
      function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c967a3e3945fceef, 1);
      function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c967a3e3945fceef, 1);
      utility::flag_set("ob_unstable_rift_wave_in_progress");
      wave_started(level.var_63879ce0401fbcdd, level.var_aa7fa2b1f5d92ff);
      function_fc38783a3da0bc71(level.ob_unstable_rift_encounter, 1);
      function_fc38783a3da0bc71(level.var_bc591e50323ade57, 1);
      function_a39e9894083f4513(level.ob_unstable_rift_encounter);
      function_a39e9894083f4513(level.var_bc591e50323ade57);

      if(level.var_a68f7ddeff300b0e && level.var_aa7fa2b1f5d92ff != level.var_742fade356940bce) {
        level utility::waittill_notify_or_timeout("ob_unstable_rift_timed_wave_completed", level.var_ba0849d2d702a9fa);
      } else {
        level waittill("ob_unstable_rift_boss_wave_completed");
      }

      function_22993fe73b6d16f4(level.ob_unstable_rift_encounter, 1);
      wave_completed(level.var_63879ce0401fbcdd, level.var_aa7fa2b1f5d92ff);
      utility::flag_clear("ob_unstable_rift_wave_in_progress");
      function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c967a3e3945fceef, 0);
      function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c967a3e3945fceef, 0);

      if(level.var_13b12aeb97840631 > 0 && level.var_aa7fa2b1f5d92ff != level.var_742fade356940bce) {
        wait level.var_13b12aeb97840631;
      }

      level.var_aa7fa2b1f5d92ff += 1;
    }

    phase_completed(level.var_63879ce0401fbcdd);
    utility::flag_clear("ob_unstable_rift_phase_in_progress");
    function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c14a49c64f9f5d09, 0);
    function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c14a49c64f9f5d09, 0);

    if(level.var_46aa430cb8b7cb4f > 0 && level.var_63879ce0401fbcdd != level.var_2ff7b3c5e5015098) {
      wait level.var_46aa430cb8b7cb4f;
    }

    level.var_63879ce0401fbcdd += 1;
  }
}

function phase_started(phase) {}

function phase_completed(phase) {
  level.var_df55b01624cc9bc2 += level.var_d3fb98c219ff46d7;
  level.var_247a0d5e632874b1 += level.var_874f1d141bd8531a;
  level.var_de00f175322567fb += level.var_eea44450575931bc;
  setDvar(@ "hash_80d8055d479ffc20", level.var_de00f175322567fb);
  thread function_e9d75f93c2bca97c();
  thread revive_players();

  if(phase != level.var_2ff7b3c5e5015098) {
    function_6823175ab6619608(#"hash_5c8e10452c6df94f");
    setmusicstate("");

    if(level.var_1bd22d3c8d75c6b2) {
      foreach(player in level.players) {
        player setclientomnvar("ui_bones_collected", phase + 1);
        player setclientomnvar("ui_skulls_collected", 1);
      }
    }

    foreach(player in level.players) {
      player thread hud_message::showsplash("jup_ob_unstable_rift_phase_completed", undefined, undefined, undefined, 1, "splash_list_jup_ob");
    }

    thread function_1b4163237ac97fbd(phase);
    thread do_countdown(level.var_46aa430cb8b7cb4f, level.var_f5d5b9ef92679eb2);
    return;
  }

  setmusicstate("mx_jup_ob_activity_win_high");

  foreach(player in level.players) {
    player thread hud_message::showsplash("jup_ob_unstable_rift_completed", undefined, undefined, undefined, 1, "splash_list_jup_ob");
  }

  if(isDefined(level.var_883c5bd44316cf99)) {
    thread function_5b531f4f333bd9b2();
    return;
  }

  thread function_f68d258d4ff8d087();
}

function wave_started(phase, wave) {
  if(wave <= 1) {
    function_6823175ab6619608(#"hash_3ba3856f6891c8da");
    musicstate = undefined;

    switch (phase) {
      case 1:
        musicstate = "mx_jup_ob_activity_action_loop1_high";
        break;
      case 2:
        musicstate = "mx_jup_ob_activity_action_loop2_high";
        break;
      case 3:
        musicstate = "mx_jup_ob_activity_action_loop5_high";
        break;
      case 4:
        musicstate = "mx_jup_ob_activity_action_loop4_high";
        break;
      case 5:
        musicstate = "mx_jup_ob_rr_objective_1";
        break;
      default:
        musicstate = "mx_jup_ob_rr_objective_2";
        break;
    }

    if(isDefined(musicstate)) {
      setmusicstate(musicstate);
    }
  } else {
    function_6823175ab6619608(#"hash_fbca777067ab1078");
  }

  level.var_a0c048a9988243fc = 0;
  level.var_cb99dae91a7d50eb = 0;
  level.var_f851fdc321a8c179 = 0;
  level.var_8c6af7d0ccfb0050 = 0;
  level.var_265bd17dd46954ca = 0;
  function_a24c9e89e3e9c356(level.var_bc591e50323ade57);
}

function wave_completed(phase, wave) {
  function_6823175ab6619608(#"hash_d245fdd48135eb49");

  if(!(phase == level.var_2ff7b3c5e5015098 && wave == level.var_742fade356940bce)) {
    if(level.var_1bd22d3c8d75c6b2 && wave < level.var_742fade356940bce) {
      foreach(player in level.players) {
        player setclientomnvar("ui_skulls_collected", wave + 1);
      }
    }

    thread do_countdown(level.var_13b12aeb97840631, level.var_c97170535c179e0);
  }
}

function function_e9d75f93c2bca97c() {
  utility::flag_set("ob_unstable_rift_zombie_cleanup_clear");
  zombies = getaispeciesarray("all", "zombie");

  if(level.var_43eebc0b76a5046d && level.var_63879ce0401fbcdd >= level.var_2ff7b3c5e5015098 && level.var_aa7fa2b1f5d92ff >= level.var_742fade356940bce) {
    foreach(zombie in zombies) {
      if(isalive(zombie)) {
        thread function_868256e45cf90700(zombie);
      }
    }
  } else {
    if(level.var_5ab899501d7a8cc1) {
      var_8efd528d6d6d916 = ["zombie_base", "zombie_base_armored_light", "zombie_base_armored_heavy", "zombie_hellhound", "zombie_base_abom_crawler", "zombie_base_abom_crawler_hvt"];

      foreach(zombie in zombies) {
        if(isalive(zombie) && arraycontains(var_8efd528d6d6d916, zombie.subclass)) {
          thread function_868256e45cf90700(zombie);
        }
      }
    }

    if(level.var_2d43671346b601f4) {
      var_c52f0480ae3cabdb = ["zombie_mimic", "zombie_mimic_hvt", "zombie_mimic_hvt_emp", "zombie_mangler", "zombie_mangler_hvt", "zombie_mangler_hvt_emp", "zombie_disciple", "zombie_disciple_hvt", "zombie_disciple_hvt_stormcaller"];

      foreach(zombie in zombies) {
        if(isalive(zombie) && !istrue(zombie.var_b8dfbbe1ede0d967) && arraycontains(var_c52f0480ae3cabdb, zombie.subclass)) {
          thread function_868256e45cf90700(zombie);
        }
      }
    }
  }

  utility::flag_set("ob_unstable_rift_zombie_cleanup_completed");
}

function function_868256e45cf90700(zombie) {
  playFXOnTag(getfx("rift_marked_zombie"), zombie, "j_spine4");
  zombie zombie_stun::stun_ai(1.5);
  zombie.full_gib = 1;
  zombie.var_745cd904c1ec804c = 1;
  wait randomfloatrange(0.5, 0.75);

  if(isalive(zombie)) {
    zombie zombie_stun::clear_stun();
    stopFXOnTag(getfx("rift_marked_zombie"), zombie, "j_spine4");
    zombie kill();
  }
}

function revive_players() {
  if(!getdvarint(@ "hash_ede1c15f7bae4871", 1)) {
    return;
  }

  foreach(player in level.players) {
    if(isalive(player) && istrue(player.inlaststand)) {
      player thread namespace_80be1a420d9464c2::heal_player(player);
    }
  }
}

function function_f68d258d4ff8d087() {
  wait 30;

  foreach(player in level.players) {
    player.var_f52eb40ba99ffa4c = 1;
    player.var_ad19e9b0668cd04d = 1;
    thread ob_exfil::function_a5426cbe311426c0(player, undefined, 1);
  }

  if(!istrue(level.gameended)) {
    wait getdvarint(@ "hash_b019df9b5745565b", 60);
    thread gamelogic::endgame("none", game["end_reason"]["objective_completed"], game["end_reason"]["objective_completed"]);
  }
}

function do_countdown(total_seconds, visible_seconds) {
  if(total_seconds <= 0 || visible_seconds <= 0) {
    return;
  }

  timer = namespace_51f0c667ac06536b::function_3eec8a169e8a0936(total_seconds);
  waitframe();

  while(!timer.progresscomplete) {
    time_remaining = int(timer.currentprogressvalue);

    if(time_remaining <= visible_seconds) {
      foreach(player in level.players) {
        player setclientomnvar("ui_is_exfil_countdown", 1);
        player setclientomnvar("ui_match_start_countdown", time_remaining);
      }
    }

    wait 0.5;
  }

  foreach(player in level.players) {
    player setclientomnvar("ui_is_exfil_countdown", 0);
    player setclientomnvar("ui_match_start_countdown", -1);
  }
}

function private function_a34cb18a0f721dfc(params) {
  self endon("death");
  self.difficulty = "difficulty_darkaether";
  self.difficulty_round = level.var_df55b01624cc9bc2;
  self._blackboard.difficultyround = level.var_df55b01624cc9bc2;

  if(isDefined(self.zombieaisettings.healthscriptbundle)) {
    ai::function_dd21d67ede8ba22(namespace_22b8ba12655bf3f2::get_starting_health(self.zombieaisettings.healthscriptbundle, level.var_df55b01624cc9bc2));
    self.health = self.maxhealth;
  }

  namespace_f721fc7d0d2d0f47::function_4fd50faaf7767e65(self, "difficulty_darkaether", level.var_df55b01624cc9bc2);
  utility::flag_wait("ob_unstable_rift_ai_allowed_volumes_initialized");
  var_2fe1324023d1406a = gettime();

  for(var_c74e2e565ee3fe18 = self.origin; true; var_c74e2e565ee3fe18 = self.origin) {
    throttle::function_f632348cbb773537(level.var_bc2bd152a41a0007, self);

    if(!isalive(self)) {
      return;
    }

    if(gettime() - var_2fe1324023d1406a < level.var_31256873a5b8c323) {
      continue;
    }

    if(level.var_442d9fc484b29f2a) {
      if(distancesquared(self.origin, var_c74e2e565ee3fe18) < level.var_88efa857926fb89a) {
        logprint("[UNSTABLE_RIFT] Killing an agent because it's not moved recently.");
        self kill();
        return;
      }
    }

    var_be33c4338e71ee2 = 0;

    foreach(volume in level.var_c3d0776d96557e6b) {
      if(ispointinvolume(self.origin, volume)) {
        var_be33c4338e71ee2 = 1;
        break;
      }
    }

    if(!var_be33c4338e71ee2) {
      logprint("[UNSTABLE_RIFT] Killing an agent because it's outside the allowed volumes.");
      self kill();
      return;
    }

    var_2fe1324023d1406a = gettime();
  }
}

function private function_6e509d5aa1517140(request_id, user_data, agent, data) {
  level.var_f851fdc321a8c179 += 1;
  agent callback::add("on_zombie_ai_killed", &function_5d1f79e049c44ed7);
  agent function_65cdab0fc78aba8f(level.ob_unstable_rift_circle.origin, level.ob_unstable_rift_circle.radius);
  agent.var_e23d72f180832aa = 1;
  agent.var_b8dfbbe1ede0d967 = 1;

  if(level.var_3c7d99e140c880d7) {
    agent.objective_marker = objective_marker_bundle_helper::createobjectivemarkerfrombundlexhash(%"hash_59192eabb1abc65e");
    objidpoolmanager::update_objective_onentity(agent.objective_marker, agent);

    switch (agent.subclass) {
      case #"hash_2f5c52f1e6ef9284":
      case #"hash_3374e2fd0840731d":
      case #"hash_60cbd0daf82a39c9":
      case #"hash_c530437c6cd11898":
      case #"hash_ef45af6960e1ed70":
        objidpoolmanager::update_objective_setzoffset(agent.objective_marker, 100);
        break;
      case #"hash_326c97f91326e4c5":
      case #"hash_59740dd906312a95":
      case #"hash_775290f0bffe6084":
      case #"hash_b1a17453629a8e00":
      case #"hash_c1fa8721b046b258":
      case #"hash_efe38896d0f4c135":
        objidpoolmanager::update_objective_setzoffset(agent.objective_marker, 90);
        break;
      case #"hash_c1b612499d7bd4a":
      case #"hash_3e4a9c816939eeef":
      case #"hash_9bc2060c1da7a187":
      case #"hash_c988cacd18bce2d2":
      case #"hash_cd50642e834acd67":
        objidpoolmanager::update_objective_setzoffset(agent.objective_marker, 90);
        break;
    }
  }
}

function private function_5d1f79e049c44ed7(params) {
  level.var_8c6af7d0ccfb0050 += 1;
  level notify("ob_unstable_rift_agent_killed");

  if(isDefined(self.objective_marker)) {
    objidpoolmanager::returnobjectiveid(self.objective_marker);
  }
}

function private function_205f236b61b4df22(request_id, user_data, var_db69bbaa77d175e2) {
  level.var_265bd17dd46954ca = 1;
  function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c967a3e3945fceef, 0);
  thread function_be3489833dc720bb();
}

function private function_be3489833dc720bb() {
  level endon("ob_unstable_rift_boss_wave_completed");

  while(true) {
    level waittill("ob_unstable_rift_agent_killed");
    waitframe();
    var_292a4944c4f89b2d = level.var_8c6af7d0ccfb0050;
    var_db69bbaa77d175e2 = level.var_f851fdc321a8c179;

    if(level.var_18a90857ec380039) {
      var_292a4944c4f89b2d += level.var_cb99dae91a7d50eb;
      var_db69bbaa77d175e2 += level.var_a0c048a9988243fc;
    }

    if(var_292a4944c4f89b2d >= var_db69bbaa77d175e2) {
      break;
    }
  }

  level notify("ob_unstable_rift_boss_wave_completed");
}

function private function_1f2fc07b5ccda54c(request_id, user_data, agent, data) {
  level.var_a0c048a9988243fc += 1;
  agent callback::add("on_zombie_ai_killed", &function_d9c42ce1b7235bfb);
  agent function_65cdab0fc78aba8f(level.ob_unstable_rift_circle.origin, level.ob_unstable_rift_circle.radius);
  category = level.var_3c3cafb0e6b2d8ad[agent.subclass];

  if(isDefined(category)) {
    if(!isDefined(level.var_9673c6e2468a0059[category])) {
      level.var_9673c6e2468a0059[category] = 0;
    }

    level.var_9673c6e2468a0059[category] += 1;
  }

  archetype = level.var_5e094262cd9de258[agent.subclass];

  if(isDefined(archetype)) {
    if(!isDefined(level.var_245e7a85bf7c3a64[archetype])) {
      level.var_245e7a85bf7c3a64[archetype] = 0;
    }

    level.var_245e7a85bf7c3a64[archetype] += 1;
  }

  if(!isDefined(level.var_620d3de3e96ca737[agent.subclass])) {
    level.var_620d3de3e96ca737[agent.subclass] = 0;
  }

  level.var_620d3de3e96ca737[agent.subclass] += 1;
}

function private function_d9c42ce1b7235bfb(params) {
  level.var_620d3de3e96ca737[self.subclass] -= 1;
  archetype = level.var_5e094262cd9de258[self.subclass];

  if(isDefined(archetype)) {
    level.var_245e7a85bf7c3a64[archetype] -= 1;
  }

  category = level.var_3c3cafb0e6b2d8ad[self.subclass];

  if(isDefined(category)) {
    level.var_9673c6e2468a0059[category] -= 1;
  }

  level.var_cb99dae91a7d50eb += 1;
  level notify("ob_unstable_rift_agent_killed");
}

function function_a24c9e89e3e9c356(request_id) {
  if(isDefined(level.var_6ceb8e49c8c8f9e8)) {
    function_d37068aac7785c04(request_id, level.var_6ceb8e49c8c8f9e8, 0);
    level.var_6ceb8e49c8c8f9e8 = undefined;
  }

  if(level.var_63879ce0401fbcdd > level.var_2ff7b3c5e5015098 || level.var_aa7fa2b1f5d92ff > level.var_742fade356940bce) {
    return;
  }

  var_6d8f5493b0ee2745 = level.var_42da2a018b83a304[level.var_63879ce0401fbcdd - 1][level.var_aa7fa2b1f5d92ff - 1];
  roll = randomfloat(var_6d8f5493b0ee2745[var_6d8f5493b0ee2745.size - 1].chance);
  i = 0;

  while(i < var_6d8f5493b0ee2745.size) {
    if(roll < var_6d8f5493b0ee2745[i].chance) {
      tag = var_6d8f5493b0ee2745[i].tag;
      category = level.var_3c3cafb0e6b2d8ad[tag];

      if(isDefined(category)) {
        category_limit = level.var_284af91c6f24b55d[category];
        category_alive = level.var_9673c6e2468a0059[category];
        jumpiffalse(isDefined(category_limit) && (category_limit == 0 || isDefined(category_alive) && category_alive >= category_limit)) LOC_00000180;
      } else {
        LOC_00000180: archetype = level.var_5e094262cd9de258[tag];

        if(isDefined(archetype)) {
          archetype_limit = level.var_14221129e7902e8[archetype];
          archetype_alive = level.var_245e7a85bf7c3a64[archetype];
          jumpiffalse(isDefined(archetype_limit) && (archetype_limit == 0 || isDefined(archetype_alive) && archetype_alive >= archetype_limit)) LOC_000001c9;
        } else {
          LOC_000001c9: var_3b8fd8e416f1396f = level.var_5e033493dbae5b3b[tag];
          var_a4bc8d4028b2251d = level.var_620d3de3e96ca737[tag];

          if(isDefined(var_3b8fd8e416f1396f) && (var_3b8fd8e416f1396f == 0 || isDefined(var_a4bc8d4028b2251d) && var_a4bc8d4028b2251d >= var_3b8fd8e416f1396f)) {} else {
            function_d37068aac7785c04(request_id, tag, 1);
            level.var_6ceb8e49c8c8f9e8 = tag;
            return;
          }
        }
      }
    }

    i += 1;
  }
}

function private function_645d046068cd16af(request_id, user_data) {
  if(level.var_18a90857ec380039 && level.var_265bd17dd46954ca && level.var_8c6af7d0ccfb0050 >= level.var_f851fdc321a8c179) {
    return false;
  }

  if(function_d45cf335caa19838(request_id) >= level.var_247a0d5e632874b1) {
    return false;
  }

  function_a24c9e89e3e9c356(request_id);
  return true;
}

function private function_6ecd0a01e9730f0a(request_id, user_data) {
  return false;
}

function init_debug() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_c0e60d48ef4352bd", 0)) {
      phase = getdvarint(@ "hash_c0e60d48ef4352bd", 0);
      setDvar(@ "hash_c0e60d48ef4352bd", 0);
      function_90c35e4500350f49(phase, level.var_aa7fa2b1f5d92ff);
    }

    if(getdvarint(@ "hash_6c407edbbc18855f", 0)) {
      wave = getdvarint(@ "hash_6c407edbbc18855f", 0);
      setDvar(@ "hash_6c407edbbc18855f", 0);
      function_90c35e4500350f49(level.var_63879ce0401fbcdd, wave);
    }

    if(getdvarint(@ "hash_48bbfc2e758b2ad8", 0)) {
      setDvar(@ "hash_48bbfc2e758b2ad8", 0);
      level.var_cb99dae91a7d50eb = 999999;
      level.var_8c6af7d0ccfb0050 = 999999;
      level notify("<dev string:x35d>");
      level notify("<dev string:x37e>");
      thread function_ec9945dc9d6f8f5();
    }

    if(getdvarint(@ "hash_7fd6417550fe2ec3", 0)) {
      setDvar(@ "hash_7fd6417550fe2ec3", 0);
      thread function_1b4163237ac97fbd(level.var_63879ce0401fbcdd);
    }

    if(getdvarint(@ "hash_82ac0dc563577ea9", 0)) {
      setDvar(@ "hash_82ac0dc563577ea9", 0);
      thread function_ae1ba841af6cdce();
    }
  }
}

function function_90c35e4500350f49(phase, wave) {
  level notify("<dev string:x3a7>");
  function_22993fe73b6d16f4(level.ob_unstable_rift_encounter, 1);
  function_22993fe73b6d16f4(level.var_bc591e50323ade57, 1);
  thread function_ec9945dc9d6f8f5();
  level.var_bbc1e3c5a5a3d286 = phase;
  level.var_a6a16c0a31a3d310 = wave;
  function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c14a49c64f9f5d09, 0);
  function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c14a49c64f9f5d09, 0);
  function_d37068aac7785c04(level.ob_unstable_rift_encounter, level.var_c967a3e3945fceef, 0);
  function_d37068aac7785c04(level.var_bc591e50323ade57, level.var_c967a3e3945fceef, 0);
  level.var_df55b01624cc9bc2 = (phase - 1) * level.var_d3fb98c219ff46d7 + getdvarint(@ "hash_63a1deea883ae3b0", 45);
  level.var_247a0d5e632874b1 = (phase - 1) * level.var_874f1d141bd8531a + getdvarint(@ "hash_63a1deea883ae3b0", 60);
  level.var_de00f175322567fb = (phase - 1) * level.var_eea44450575931bc + getdvarint(@ "hash_e638566dc55e2c9b", 50);
  setDvar(@ "hash_80d8055d479ffc20", level.var_de00f175322567fb);
  thread do_phases();
  level.var_bbc1e3c5a5a3d286 = undefined;
  level.var_a6a16c0a31a3d310 = undefined;

  if(level.var_1bd22d3c8d75c6b2) {
    foreach(player in level.players) {
      player setclientomnvar("<dev string:x3c6>", phase);
      player setclientomnvar("<dev string:x3dc>", wave);
    }
  }
}

function function_ec9945dc9d6f8f5() {
  zombies = getaispeciesarray("<dev string:x3f3>", "<dev string:x3fa>");

  foreach(zombie in zombies) {
    if(isalive(zombie)) {
      zombie kill();
    }
  }
}

# /