/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\wz_progression.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\item_world_util;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\wz_common\util;
#namespace wz_progression;

function private autoexec __init__system__() {
  system::register(#"wz_progression", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  callback::on_revived(&function_3de8b6e0);
  callback::on_player_damage(&function_36e144fa);
  callback::on_vehicle_killed(&function_8920ad6e);
  callback::on_item_pickup(&function_106be0dc);
  callback::on_item_pickup(&on_item_pickup);
  callback::on_item_use(&function_393ec79e);
  callback::on_stash_open(&function_6c478b00);
  callback::add_callback(#"freefall", &function_c9a18304);
  callback::on_challenge_complete(&on_challenge_complete);
  callback::on_character_unlock(&on_character_unlock);
  callback::on_game_playing(&on_game_playing);
  callback::on_downed(&function_a117c988);
  callback::on_player_killed(&on_player_killed);
  callback::on_game_shutdown(&on_game_shutdown);
  callback::add_callback("on_driving_wz_vehicle", &on_driving_wz_vehicle);
  callback::add_callback("on_exit_locked_on_vehicle", &on_exit_locked_on_vehicle);
  callback::add_callback(#"hash_677c43609aa6ce47", &function_5648f82);
  callback::add_callback(#"hash_1019ab4b81d07b35", &team_eliminated);
  level.var_c8453874 = &function_35ac33e1;
}

function private postinit() {}

function function_cfc02934() {
  var_88846d2d = getDvar(#"hash_4a5fd7d94cfc9dfd", 0) != 0 || getdvarint(#"hash_4a5fd7d94cfc9dfd", 0) != 0;

  if(isPlayer(self) && !isbot(self) && var_88846d2d) {
    player = self;
    player giveachievement(#"wz_specialist_super_fan");
  }
}

function function_ec3a8858() {
  player = self;

  if(!isPlayer(player)) {
    return false;
  }

  if(isDefined(player.inventory) && isDefined(player.inventory.consumed)) {
    if((isDefined(player.inventory.consumed.size) ? player.inventory.consumed.size : 0) > 0) {
      return true;
    }
  }

  return false;
}

function private function_f874ca5e(placement_player) {
  player = self;
  assert(isPlayer(player));

  if(!isPlayer(player)) {
    return;
  }

  player.pers[# "placement_player"] = placement_player;
  player match_record::set_player_stat(#"player_placement", placement_player);
  player stats::function_7a850245(#"placement_player", placement_player);
}

function player_connected() {
  assert(isPlayer(self));
  player = self;
  player.pers[# "jointime"] = gettime();
  player.pers[# "deathtime"] = 0;
  player.pers[# "teameliminatedtime"] = 0;
  player.pers[# "hash_77f848fcd417ea53"] = 0;
  player.pers[# "placement_player"] = 0;
  player.pers[# "placement_team"] = 0;
}

function function_2c8aac6() {
  assert(isPlayer(self));
  player = self;

  if(!player stats::function_f94325d3() || isbot(player) || !isDefined(player.pers)) {
    return;
  }

  if(is_true(player.pers[# "hash_77f848fcd417ea53"])) {
    println("<dev string:x38>" + (isDefined(player.name) ? player.name : "<dev string:x43>") + "<dev string:x55>");
    return;
  }

  if(!isDefined(self.pers[# "teameliminatedtime"])) {
    self.pers[# "teameliminatedtime"] = gettime();
  }

  if(player.pers[# "teameliminatedtime"]) {
    var_c06441ec = max(gettime() - self.pers[# "teameliminatedtime"], 0);
  } else {
    var_c06441ec = 0;
  }

  var_3e32dc53 = 0;

  if(isDefined(self.pers[# "hash_150795bee4d46ce4"])) {
    var_3e32dc53 = max(gettime() - self.pers[# "hash_150795bee4d46ce4"] - var_c06441ec, 0);
  }

  player contracts::function_78083139();
  player challenges::function_659f7dc(var_3e32dc53, undefined);

  if(game.state == # "playing" && isDefined(level.var_13de4626)) {
    player[[level.var_13de4626]]();
  }

  player function_4835d26a();
  println("<dev string:x78>" + (isDefined(player.name) ? player.name : "<dev string:x43>") + "<dev string:x9f>" + (isDefined(player.pers[# "placement_player"]) ? player.pers[# "placement_player"] : "<dev string:xb7>") + "<dev string:xc2>" + "<dev string:xc7>" + (isDefined(player.pers[# "placement_team"]) ? player.pers[# "placement_team"] : "<dev string:xb7>") + "<dev string:xc2>" + "<dev string:xdd>" + (isDefined(player.pers[# "kills"]) ? player.pers[# "kills"] : "<dev string:xb7>") + "<dev string:xc2>");
  player.pers[# "hash_77f848fcd417ea53"] = 1;
}

function player_disconnected() {
  self stats::function_b7f80d87(#"died", 1);
  self function_2c8aac6();
}

function private function_fb20ad56() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_6d5e162204f447f4", 1);
}

function private function_d61fdbef() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_25f4611fc9d40aa8", 1);
}

function private function_67949803() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_63307a0460c698ac", 1);
}

function private function_a0fea1a9() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_6429d1fccdef2c9", 1);
}

function private function_3217b0d2() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_7b8d2c77874a1c24", 1);

  if(player function_ec3a8858()) {
    player stats::function_d40764f3(#"hash_337e05385393e3a6", 1);
  }

  if(!is_true(player.var_e4bec3d4)) {
    player stats::function_d40764f3(#"hash_702849e1bf1e3915", 1);
  }
}

function private function_6a7970fe() {
  player = self;
  assert(isPlayer(player));
  player stats::function_d40764f3(#"hash_5e9a745460a10f80", 1);

  if(is_true(player.avenger)) {
    player stats::function_d40764f3(#"hash_5387d5e6f15c6b55", 1);
  }

  if(isDefined(player.items_picked_up) && player.items_picked_up.size <= 1) {
    player stats::function_d40764f3(#"hash_7158067d85c1402a", 1);
  }
}

function team_eliminated(params) {
  team = params.team;
  team_placement = params.var_293493b;

  if(!isDefined(team)) {
    println("<dev string:xea>");
    return;
  }

  a_players = getplayers(team);

  if(isDefined(level.var_29ab88df)) {
    level[[level.var_29ab88df]](a_players, team_placement);
  }

  println("<dev string:x123>" + (isDefined(team) ? team : "<dev string:x146>") + "<dev string:x156>" + team_placement + "<dev string:x16b>");

  foreach(player in a_players) {
    if(!isDefined(player.pers) || is_true(player.pers[# "hash_2283e9384383a6e9"])) {
      continue;
    }

    player.pers[# "hash_2283e9384383a6e9"] = 1;
    player.pers[# "teameliminatedtime"] = gettime();
    player.pers[# "placement_team"] = team_placement;
    player match_record::set_player_stat(#"team_placement", team_placement);
    player stats::function_7a850245(#"placement_team", team_placement);

    if(team_placement <= 15) {
      player function_a0fea1a9();
    }

    if(team_placement <= 10) {
      player function_3217b0d2();
    }

    if(team_placement <= 5) {
      player function_6a7970fe();
    }
  }
}

function function_5648f82(team) {
  println("<dev string:x170>" + (isDefined(team) ? team : "<dev string:x146>"));

  if(isDefined(team)) {
    foreach(player in getplayers(team)) {
      if(!player stats::function_f94325d3()) {
        continue;
      }

      if(!isDefined(player.pers) || is_true(player.pers[# "hash_2283e9384383a6e9"])) {
        continue;
      }

      player.pers[# "hash_2283e9384383a6e9"] = 1;
      player.pers[# "placement_team"] = 1;
      player.pers[# "placement_player"] = 1;
      player function_a0fea1a9();
      player function_3217b0d2();
      player function_6a7970fe();
      player function_fb20ad56();
      player function_d61fdbef();
      player function_67949803();
      player stats::function_dad108fa(#"wins_first", 1);
      player giveachievement(#"wz_first_win");
      var_4cf27874 = player stats::get_stat_global(#"wins");

      if(var_4cf27874 >= 9) {
        player giveachievement(#"wz_not_a_fluke");
      }

      if(!isDefined(player.laststandcount) || player.laststandcount <= 0) {
        player stats::function_d40764f3(#"wins_without_down", 1);
      }

      if(isDefined(player.pers[# "kills"]) && player.pers[# "kills"] == 0) {
        player stats::function_d40764f3(#"wins_without_kills", 1);
      }

      player_counts = util::function_de15dc32();

      if(isalive(player) && player_counts.alive == 1 && (isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1) > 1) {
        player stats::function_d40764f3(#"wins_last_alive", 1);
      }

      player function_f874ca5e(1);
      player match_record::set_player_stat(#"team_placement", 1);
      player stats::function_7a850245(#"placement_team", 1);
      player stats::function_b7f80d87(#"died", 1);
    }
  }
}

function on_driving_wz_vehicle(params) {
  if(level.inprematchperiod) {
    return;
  }

  vehicle = params.vehicle;
  player = params.player;
  seatindex = params.seatindex;

  if(seatindex === 0) {
    vehicle thread function_f8072c71(player);

    if(!isDefined(player.var_e081a4e5)) {
      player.var_e081a4e5 = [];
    }

    var_b01d9212 = isairborne(vehicle);
    var_7c6311c4 = vehicle.vehicleclass === "boat";
    var_f03db647 = !var_b01d9212 && !var_7c6311c4;

    if(var_b01d9212 && !isDefined(player.var_e081a4e5[# "air"])) {
      player.var_e081a4e5[# "air"] = 1;
    } else if(var_7c6311c4 && !isDefined(player.var_e081a4e5[# "sea"])) {
      player.var_e081a4e5[# "sea"] = 1;
    } else if(var_f03db647 && !isDefined(player.var_e081a4e5[# "land"])) {
      player.var_e081a4e5[# "land"] = 1;
    }

    if(player.var_e081a4e5.size == 3) {
      if(!is_true(player.var_e081a4e5[# "all_used"])) {
        player.var_e081a4e5[# "all_used"] = 1;
        player stats::function_d40764f3(#"vehicle_used_all", 1);
      }
    }

    if(isDefined(player.lastdamagetime)) {
      time = gettime();

      if(time - player.lastdamagetime <= 3000) {
        player thread function_d0c523bf();
      }
    }
  }
}

function function_d0c523bf() {
  self endon(#"death", #"exit_vehicle", #"disconnect");
  wait 5;

  if(self isinvehicle()) {
    self stats::function_d40764f3(#"vehicle_escapes", 1);
  }
}

function function_f8072c71(player) {
  if(!isPlayer(player) || !isDefined(self)) {
    return;
  }

  self endon(#"death");
  player endon(#"death", #"change_seat", #"exit_vehicle", #"disconnect");
  prevposition = self.origin;
  distancetraveled = 0;
  var_b01d9212 = isairborne(self);
  var_7c6311c4 = self.vehicleclass === "boat";
  var_f03db647 = !var_b01d9212 && !var_7c6311c4;

  while(isDefined(self) && isDefined(player)) {
    wait 1;

    if(isDefined(self) && isDefined(player)) {
      distancetraveled = int(distancetraveled + distance2d(self.origin, prevposition));
      prevposition = self.origin;

      if(distancetraveled > 1000) {
        if(var_f03db647) {
          player stats::function_dad108fa(#"distance_traveled_vehicle_land", distancetraveled);
          var_ae40ba19 = player stats::get_stat_global(#"distance_traveled_vehicle_land");
          var_7f444a72 = int(var_ae40ba19 / 63360);
          var_a7f485eb = player stats::get_stat_global(#"distance_traveled_vehicle_land_miles");

          if(var_7f444a72 > var_a7f485eb) {
            diff = var_7f444a72 - var_a7f485eb;
            player stats::function_dad108fa(#"distance_traveled_vehicle_land_miles", diff);
          }
        }

        if(var_b01d9212) {
          player stats::function_dad108fa(#"distance_traveled_vehicle_air", distancetraveled);
          var_ae40ba19 = player stats::get_stat_global(#"distance_traveled_vehicle_air");
          var_7f444a72 = int(var_ae40ba19 / 63360);
          var_a7f485eb = player stats::get_stat_global(#"distance_traveled_vehicle_air_miles");

          if(var_7f444a72 > var_a7f485eb) {
            diff = var_7f444a72 - var_a7f485eb;
            player stats::function_dad108fa(#"distance_traveled_vehicle_air_miles", diff);
          }
        }

        if(var_7c6311c4) {
          player stats::function_dad108fa(#"distance_traveled_vehicle_water", distancetraveled);
          var_ae40ba19 = player stats::get_stat_global(#"distance_traveled_vehicle_water");
          var_7f444a72 = int(var_ae40ba19 / 63360);
          var_a7f485eb = player stats::get_stat_global(#"distance_traveled_vehicle_water_miles");

          if(var_7f444a72 > var_a7f485eb) {
            diff = var_7f444a72 - var_a7f485eb;
            player stats::function_dad108fa(#"distance_traveled_vehicle_water_miles", diff);
          }
        }

        distancetraveled = 0;
      }
    }
  }
}

function on_exit_locked_on_vehicle(params) {
  player = params.player;

  if(isPlayer(player)) {
    player stats::function_d40764f3(#"vehicle_lock_exits", 1);
  }
}

function function_c9a18304(eventstruct) {
  if(eventstruct.freefall) {
    if(isPlayer(self)) {}

    return;
  }

  self notify(#"hash_74973f333d2fabfa");
}

function function_da21a17c() {
  self endon(#"hash_74973f333d2fabfa", #"death", #"disconnect");
  prevposition = self.origin;
  distancetraveled = 0;

  while(isDefined(self)) {
    wait 1;

    if(isDefined(self)) {
      distancetraveled = int(distancetraveled + distance2d(self.origin, prevposition));
      prevposition = self.origin;

      if(distancetraveled > 1000) {
        self stats::function_dad108fa(#"distance_traveled_wingsuit", distancetraveled);
        distancetraveled = 0;
        var_ae40ba19 = self stats::get_stat_global(#"distance_traveled_wingsuit");
        var_7f444a72 = int(var_ae40ba19 / 63360);
        var_a7f485eb = self stats::get_stat_global(#"distance_traveled_wingsuit_miles");

        if(var_7f444a72 > var_a7f485eb) {
          diff = var_7f444a72 - var_a7f485eb;
          self stats::function_dad108fa(#"distance_traveled_wingsuit_miles", diff);
        }
      }
    }
  }
}

function function_3de8b6e0(params) {
  if(!gamestate::is_state(#"playing") || !isDefined(params.reviver)) {
    return;
  }
}

function function_36e144fa(params) {
  if(!is_true(self.var_e4bec3d4)) {
    if(params.smeansofdeath == "MOD_DEATH_CIRCLE") {
      self.var_e4bec3d4 = 1;
    }
  }

  if(!isDefined(self.var_9854aa3a)) {
    self.var_9854aa3a = [];
  }

  attacker = params.eattacker;

  if(isPlayer(attacker) && !isinarray(self.var_9854aa3a, attacker)) {
    if(!isDefined(self.var_9854aa3a)) {
      self.var_9854aa3a = [];
    } else if(!isarray(self.var_9854aa3a)) {
      self.var_9854aa3a = array(self.var_9854aa3a);
    }

    if(!isinarray(self.var_9854aa3a, attacker)) {
      self.var_9854aa3a[self.var_9854aa3a.size] = attacker;
    }
  }

  bare_hands = getweapon(#"bare_hands");
  var_c1f166f3 = self hasweapon(bare_hands);

  if(var_c1f166f3) {
    if(!isDefined(self.var_91ddc6c5)) {
      self.var_91ddc6c5 = [];
    }

    if(isPlayer(attacker) && !isinarray(self.var_91ddc6c5, attacker)) {
      if(!isDefined(self.var_91ddc6c5)) {
        self.var_91ddc6c5 = [];
      } else if(!isarray(self.var_91ddc6c5)) {
        self.var_91ddc6c5 = array(self.var_91ddc6c5);
      }

      if(!isinarray(self.var_91ddc6c5, attacker)) {
        self.var_91ddc6c5[self.var_91ddc6c5.size] = attacker;
      }
    }
  }
}

function private function_a117c988() {
  if(isDefined(self.laststandparams)) {
    attacker = self.laststandparams.attacker;

    if(isDefined(attacker) && isDefined(attacker.var_121392a1) && isarray(attacker.var_121392a1)) {
      if(isDefined(attacker.var_121392a1[# "blind_base"]) || isDefined(attacker.var_121392a1[# "swat_grenade"]) || isDefined(attacker.var_121392a1[# "hash_1527a22d8a6fdc21"])) {
        self.laststandparams.var_6314a3a3 = 1;
      }
    }
  }
}

function private on_player_killed(params) {
  victim = self;
  assert(isPlayer(victim));

  if(isDefined(victim)) {
    victim.pers[# "deathtime"] = gettime();
    player_counts = util::function_de15dc32(victim);
    placement_player = player_counts.alive + 1;

    if(placement_player <= 25) {
      victim function_fb20ad56();
    }

    if(placement_player <= 10) {
      victim function_d61fdbef();
    }

    if(placement_player <= 5) {
      victim function_67949803();
    }

    victim stats::function_b7f80d87(#"died", 1);
    victim function_f874ca5e(placement_player);
  }
}

function function_35ac33e1(attacker, victim, var_c5948a69 = {}) {
  if(isDefined(attacker)) {
    attacker stats::function_b7f80d87(#"kills", 1);

    if(isDefined(attacker.pers[# "timesrevived"]) && attacker.pers[# "timesrevived"] > 0) {
      attacker stats::function_d40764f3(#"kills_after_revive", 1);
    }

    var_2fba6abe = attacker.var_37ef8626;
    currenttime = gettime();

    if(isDefined(var_2fba6abe) && currenttime - var_2fba6abe <= 60000) {
      attacker stats::function_d40764f3(#"kills_early", 1);
      attacker callback::callback(#"hash_22c795c5dddbfc97");
    }

    if(var_c5948a69.weapon === getweapon(#"bare_hands")) {
      attacker stats::function_d40764f3(#"kills_unarmed", 1);
    }

    if(is_true(var_c5948a69.var_6314a3a3)) {
      attacker stats::function_d40764f3(#"kills_while_stunned", 1);
    }

    if(attacker isplayerunderwater()) {
      attacker stats::function_d40764f3(#"kills_underwater", 1);
    }

    if(isDefined(victim)) {
      if(isDefined(victim.playerskilled)) {
        if(isDefined(victim.playerskilled[attacker.team]) && victim.playerskilled[attacker.team].size > 0) {
          attacker.avenger = 1;
        }
      }

      if(isDefined(victim.team)) {
        maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

        if(!isDefined(attacker.playerskilled)) {
          attacker.playerskilled = [];
        }

        if(!isDefined(attacker.playerskilled[victim.team])) {
          attacker.playerskilled[victim.team] = [];
        } else if(!isarray(attacker.playerskilled[victim.team])) {
          attacker.playerskilled[victim.team] = array(attacker.playerskilled[victim.team]);
        }

        if(!isinarray(attacker.playerskilled[victim.team], victim)) {
          attacker.playerskilled[victim.team][attacker.playerskilled[victim.team].size] = victim;
        }

        if(isDefined(attacker.playerskilled[victim.team])) {
          switch (attacker.playerskilled[victim.team].size) {
            case 2:
              attacker stats::function_d40764f3(#"hash_46971a941d93cbb4", 1);

              if(maxteamplayers == 2) {
                scoreevents::processscoreevent(#"hash_36b13ed6e99e6f06", attacker, undefined, var_c5948a69.weapon);
              }

              break;
            case 3:
              attacker stats::function_d40764f3(#"hash_1b3182f99881069d", 1);
              break;
            case 4:
              attacker stats::function_d40764f3(#"hash_736fa2bcc0b0bf62", 1);
              attacker stats::function_d40764f3(#"squads_eliminated_unassisted", 1);
              attacker stats::function_dad108fa(#"hash_6f41f79a13199c79", 1);
              break;
            default:
              break;
          }
        }
      }

      if(isDefined(attacker.var_22002c3b)) {
        if(isinarray(attacker.var_22002c3b, victim)) {
          attacker stats::function_d40764f3(#"kills_revenge", 1);
        }
      }

      if(victim isplayerunderwater()) {
        attacker stats::function_d40764f3(#"kills_underwater_enemy", 1);
      }

      if(isDefined(attacker.var_9854aa3a) && isinarray(attacker.var_9854aa3a, victim)) {
        attacker stats::function_d40764f3(#"kills_after_damage", 1);
      } else {
        attacker stats::function_d40764f3(#"kills_without_damage", 1);
      }

      if(isDefined(attacker.var_91ddc6c5)) {
        if(isinarray(attacker.var_91ddc6c5, victim)) {
          attacker stats::function_d40764f3(#"kills_after_damage_unarmed", 1);
        }
      }

      vehicle = victim.var_156bf46e;

      if(isDefined(vehicle) && isvehicle(vehicle)) {
        var_b01d9212 = isairborne(vehicle);
        var_7c6311c4 = vehicle.vehicleclass === "boat";
        var_f03db647 = !var_b01d9212 && !var_7c6311c4;

        if(var_f03db647) {
          attacker stats::function_d40764f3(#"kills_enemy_in_vehicle_land", 1);
        }

        if(var_b01d9212) {
          attacker stats::function_d40764f3(#"kills_enemy_in_vehicle_air", 1);
        }

        if(var_7c6311c4) {
          attacker stats::function_d40764f3(#"kills_enemy_in_vehicle_water", 1);
        }
      }
    }

    weapon = var_c5948a69.weapon;

    if(isDefined(weapon) && weapon != level.weaponnone && isDefined(var_c5948a69.attackerorigin) && isDefined(var_c5948a69.victimorigin) && is_true(weapon.isbulletweapon)) {
      weaponclass = util::getweaponclass(weapon);
      dist_to_target = distance(var_c5948a69.attackerorigin, var_c5948a69.victimorigin);

      if(dist_to_target >= 13779 && weaponclass == # "weapon_sniper") {
        attacker stats::function_d40764f3(#"kills_longshot_sniper", 1);
      }

      var_5afc3871 = attacker function_65776b07();

      if(isDefined(var_5afc3871) && isDefined(var_5afc3871[# "talent_deadsilence"]) && weaponhasattachment(weapon, "suppressed")) {
        attacker stats::function_dad108fa(#"hash_41f134c3e727d877", 1);
        attacker callback::callback(#"hash_453c77a41df1963c");
      }

      height = var_c5948a69.attackerorigin[2] - var_c5948a69.victimorigin[2];

      if(height >= 240) {
        attacker stats::function_dad108fa(#"hash_35020c395a89befb", 1);
        attacker callback::callback(#"hash_7a9bdd3ee0ae95af");
      }

      if(!isDefined(attacker.pers[# "longestdistancekill"]) || dist_to_target > attacker.pers[# "longestdistancekill"]) {
        attacker.pers[# "longestdistancekill"] = dist_to_target;
        longestkill = dist_to_target * 0.0254;
        attacker.longestkill = int(floor(longestkill + 0.5));
        attacker stats::function_62b271d8(#"longest_distance_kill", int(dist_to_target));
        attacker stats::function_7a850245(#"longestdistancekill", int(attacker.pers[# "longestdistancekill"]));
      }

      var_c2d07ee0 = attacker stats::function_ed81f25e(#"longest_distance_kill");

      if(isDefined(var_c2d07ee0)) {
        if(dist_to_target > var_c2d07ee0) {
          attacker stats::function_baa25a23(#"longest_distance_kill", int(dist_to_target));
        }
      }
    }
  }
}

function function_c7aa9338(array) {
  foreach(ent in array) {
    if(util::function_fbce7263(ent.team, self.team)) {
      return true;
    }
  }

  return false;
}

function function_8920ad6e(params) {
  if(!gamestate::is_state(#"playing")) {
    return;
  }

  if(isPlayer(params.eattacker)) {
    params.eattacker stats::function_d40764f3(#"vehicles_destroyed", 1);
  }

  if(isDefined(params.occupants)) {
    if(params.occupants.size > 0 && self function_c7aa9338(params.occupants)) {
      if(isPlayer(params.eattacker)) {
        vehicle = params.eattacker getvehicleoccupied();

        if(isDefined(vehicle) && isvehicle(vehicle)) {
          seat = vehicle getoccupantseat(params.eattacker);

          if(isDefined(seat)) {
            if(seat === 0) {
              params.eattacker stats::function_d40764f3(#"vehicles_destroyed_occupied_using_vehicle", 1);
            }
          }
        }

        params.eattacker stats::function_d40764f3(#"vehicles_destroyed_occupied", 1);
      }
    }
  }
}

function function_106be0dc(params) {
  if(!gamestate::is_state(#"playing") || !isDefined(params.item)) {
    return;
  }

  item = params.item;

  if(isPlayer(self)) {
    self.pers[# "participation"]++;

    if(!isDefined(self.items_picked_up)) {
      self.items_picked_up = [];
    }

    if(!isDefined(self.items_picked_up[item.id])) {
      self.items_picked_up[item.id] = 1;
      self stats::function_d40764f3(#"items_picked_up", 1);

      if(isDefined(item.itementry) && item.itementry.itemtype === # "armor") {
        self stats::function_d40764f3(#"items_armor_used", 1);
      }

      if(isDefined(item.itementry) && item.itementry.itemtype === # "backpack") {
        self stats::function_d40764f3(#"items_backpacks_used", 1);
      }
    }
  }
}

function function_393ec79e(params) {
  if(!gamestate::is_state(#"playing") || !isDefined(params.item)) {
    return;
  }

  item = params.item;

  if(isDefined(item.itementry) && item.itementry.itemtype === # "health") {
    self stats::function_d40764f3(#"items_health_used", 1);

    if(is_true(self.outsidedeathcircle)) {
      self stats::function_d40764f3(#"hash_154d42f200303577", 1);
      self match_record::function_34800eec(#"hash_154d42f200303577", 1);
    }
  }
}

function function_6c478b00(params) {
  if(!gamestate::is_state(#"playing") || !isDefined(params.activator)) {
    return;
  }

  activator = params.activator;

  if(isPlayer(activator)) {
    if(self === getdynent(#"dock_yard_stash_2")) {
      activator stats::function_d40764f3(#"cargo_supply_opened", 1);
    }
  }
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(level.inprematchperiod) {
    return;
  }

  if(sessionmodeiswarzonegame() && isPlayer(self) && isalive(self) && isDefined(eventstruct) && isDefined(eventstruct.weapon)) {
    if(eventstruct.weapon.name === # "basketball") {
      if(isDefined(eventstruct.projectile)) {
        ball = eventstruct.projectile;
        ball thread function_16de96c7(self);
      }
    }
  }
}

function function_16de96c7(player) {
  if(!isDefined(player) || !isDefined(self)) {
    return;
  }

  level endon(#"game_ended");
  self endon(#"stationary", #"death");
  player endon(#"disconnect", #"death");
  var_299b8419 = getEntArray("basketball_hoop", "targetname");

  if(!isDefined(var_299b8419)) {
    return;
  }

  var_69a93dcf = 0;
  ball_velocity = self getvelocity();

  if(!isDefined(ball_velocity)) {
    return;
  }

  var_ace707d = 0;

  while(!var_69a93dcf && !var_ace707d) {
    ball_velocity = self getvelocity();

    if(ball_velocity[2] < 0) {
      var_b4331e2d = 0;

      foreach(basket in var_299b8419) {
        if(self.origin[2] < basket.origin[2]) {
          var_b4331e2d++;
        }

        if(self istouching(basket)) {
          var_69a93dcf = 1;
          break;
        }
      }

      if(var_b4331e2d === var_299b8419.size) {
        var_ace707d = 1;
        break;
      }

      if(var_69a93dcf) {
        break;
      }
    }

    waitframe(1);
  }

  if(var_69a93dcf) {
    if(isPlayer(player)) {
      player stats::function_d40764f3(#"baskets_made", 1);
    }
  }
}

function on_game_playing(params) {
  level.prematchduration = gettime();

  foreach(team, _ in level.teams) {
    players = getplayers(team);

    foreach(player in players) {
      if(isbot(player)) {
        continue;
      }

      player function_cfc02934();
      player stats::set_stat(#"afteractionreportstats", #"teammatecount", players.size);

      for(i = 0; i < players.size; i++) {
        teammate = players[i];
        player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"name", teammate.name);
        player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"xuid", teammate getxuid(1));

        if(isDefined(teammate.pers) && isDefined(teammate.pers[# "rank"])) {
          player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"rank", teammate.pers[# "rank"]);
          player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"plevel", teammate.pers[# "plevel"]);
        }
      }
    }
  }
}

function on_game_shutdown() {
  players = getplayers();

  foreach(player in players) {
    player function_2c8aac6();
  }
}

function on_challenge_complete(params) {
  player = self;
  assert(isPlayer(player));

  if(!isPlayer(player) || !isDefined(player.pers)) {
    return;
  }

  if(!isDefined(player.pers[# "participation"])) {
    player.pers[# "participation"] = 0;
  }

  player.pers[# "participation"]++;
}

function on_character_unlock(params) {
  if(isPlayer(self)) {
    waitframe(1);
    player = self;
  }
}

function on_item_pickup(params) {
  if(!gamestate::is_state(#"playing") || !isDefined(params.item)) {
    return;
  }

  item = params.item;
  count = params.count;

  if(isPlayer(self)) {
    if(isDefined(item.itementry) && item.itementry.itemtype === # "resource" && item_world_util::function_41f06d9d(item.itementry) && count > 0) {
      self stats::function_dad108fa(#"items_paint_cans_collected", count);
      self stats::function_b7f80d87("paint_cans_collected", count);
    }
  }
}

function private event_handler[event_cf200f34] function_209450ae(eventstruct) {
  if(level.inprematchperiod) {
    return;
  }

  dynent = eventstruct.ent;

  if(dynent.targetname !== # "firing_range_target_challenge") {
    return;
  }

  attacker = eventstruct.attacker;
  weapon = eventstruct.weapon;
  position = eventstruct.position;
  direction = eventstruct.dir;

  if(!isPlayer(attacker) || !isDefined(weapon) || !isDefined(position) || !isDefined(direction)) {
    return;
  }

  dist = distance(attacker.origin, dynent.origin);

  if(dist < 3550) {
    return;
  }

  targetangles = dynent.angles + (0, 90, 0);
  var_2bbc9717 = anglesToForward(targetangles);

  if(vectordot(var_2bbc9717, direction) >= 0) {
    return;
  }

  var_f748425e = dynent.origin + (0, 0, 45);

  if(distance2dsquared(var_f748425e, position) > sqr(5)) {
    return;
  }

  attacker stats::function_d40764f3(#"longest_firing_range_bullseye", 1);
}

function function_f6dc1aa9() {
  while(true) {
    var_f748425e = self.origin + (0, 0, 45);
    sphere(var_f748425e, 5, (1, 1, 0));
    waitframe(1);
  }
}