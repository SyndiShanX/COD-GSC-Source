/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_player_stats.gsc
********************************/

init_stats() {
  self.stats["kills"] = 0;
  self.stats["kills_melee"] = 0;
  self.stats["kills_explosives"] = 0;
  self.stats["kills_grenades"] = 0;
  self.stats["kills_juggernaut"] = 0;
  self.stats["kills_vehicle"] = 0;
  self.stats["kills_sentry"] = 0;
  self.stats["headshots"] = 0;
  self.stats["shots_fired"] = 0;
  self.stats["shots_hit"] = 0;
  self.stats["weapon"] = [];
  self.stats["current_checkpoint"] = 0;
  self.stats["checkpoint_start"] = 0;
  self.stats["final_difficulty"] = "";
  self.stats["level_name"] = "";
  self.stats["start_difficulty"] = "";
  self.stats["career_kills_total"] = 0;
  self.stats["career_deaths_total"] = 0;
  self.stats["career_levels_completed"] = [];
  self.stats["career_level_completed_timestamps"] = [];
  self.stats["register_kills_for_vehicle_occupants"] = 1;
  thread shots_fired_recorder();
}

was_headshot() {
  if(isdefined(self.died_of_headshot) && self.died_of_headshot)
    return 1;

  if(!isdefined(self.damagelocation))
    return 0;

  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

register_difficulty(var_0, var_1) {
  var_2 = self;

  if(isdefined(self.owner))
    var_2 = self.owner;

  if(!isplayer(var_2)) {
    return;
  }
  if(var_1) {
    var_2.stats["start_difficulty"] = var_0;
    setspmatchdata("start_difficulty", var_0);
  } else {
    var_2.stats["final_difficulty"] = var_0;
    setspmatchdata("final_difficulty", var_0);
  }
}

register_level_name(var_0) {
  var_1 = self;

  if(isdefined(self.owner))
    var_1 = self.owner;

  if(!isplayer(var_1)) {
    return;
  }
  var_1.stats["level_name"] = var_0;
  setspmatchdata("level_name", var_0);
}

toggle_register_kills_for_vehicle_occupants(var_0) {
  var_1 = self;

  if(isdefined(self.owner))
    var_1 = self.owner;

  if(!isplayer(var_1)) {
    return;
  }
  if(!isdefined(var_0))
    var_0 = 1;

  var_1.stats["register_kills_for_vehicle_occupants"] = var_0;
}

should_register_kills_for_vehicle_occupants() {
  var_0 = self;

  if(isdefined(self.owner))
    var_0 = self.owner;

  if(!isplayer(var_0))
    return 1;

  if(isdefined(var_0.stats["register_kills_for_vehicle_occupants"]) && var_0.stats["register_kills_for_vehicle_occupants"])
    return 1;

  return 0;
}

register_kill(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = 0;

  if(isdefined(self.owner))
    var_4 = self.owner;

  if(!isplayer(var_4)) {
    if(isdefined(level.pmc_match) && level.pmc_match)
      var_4 = level.players[randomint(level.players.size)];
  }

  if(!isplayer(var_4)) {
    return;
  }
  if(isdefined(level.skip_pilot_kill_count) && isdefined(var_0.drivingvehicle) && var_0.drivingvehicle) {
    return;
  }
  var_4.stats["kills"]++;
  var_4 career_stat_increment("kills", 1);
  var_6 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "kills_total");

  if(isdefined(var_6))
    level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "kills_total", var_6 + 1);

  if(maps\_utility::is_specialop())
    level notify("specops_player_kill", var_4, var_0, var_2, var_3);

  if(isdefined(var_0)) {
    if(var_0 was_headshot() && var_1 != "MOD_MELEE" && var_1 != "MOD_MELEE_ALT") {
      var_4.stats["headshots"]++;
      var_4 career_stat_increment("headshots", 1);
      var_5 = 1;
    }

    if(isdefined(var_0.juggernaut)) {
      var_4.stats["kills_juggernaut"]++;
      var_4 career_stat_increment("kills_juggernaut", 1);
    }

    if(isdefined(var_0.issentrygun))
      var_4.stats["kills_sentry"]++;

    if(var_0.code_classname == "script_vehicle") {
      var_4.stats["kills_vehicle"]++;

      if(var_4 should_register_kills_for_vehicle_occupants()) {
        if(isdefined(var_0.riders)) {
          foreach(var_8 in var_0.riders) {
            if(isdefined(var_8))
              var_4 register_kill(var_8, var_1, var_2, var_3);
          }
        }
      }
    }
  }

  var_10 = 0;

  if(cause_is_explosive(var_1)) {
    var_4.stats["kills_explosives"]++;
    var_10 = 1;
  }

  if(cause_is_grenade(var_1, var_2) && (!isdefined(var_4.mechdata) || !isdefined(var_4.mechdata.active) || !var_4.mechdata.active)) {
    var_4.stats["kills_grenades"]++;
    var_4 stat_notify("kills_grenades", 1);
    var_10 = 1;
  }

  if(!isdefined(var_2))
    var_2 = var_4 getcurrentweapon();

  if(issubstr(tolower(var_1), "melee")) {
    var_4.stats["kills_melee"]++;

    if(weaponinventorytype(var_2) == "primary")
      return;
  }

  if(var_4 is_new_weapon(var_2))
    var_4 register_new_weapon(var_2);

  var_4.stats["weapon"][var_2].kills++;
  var_4.stats["career_kills_total"]++;

  if(!var_10)
    maps\_sp_matchdata::increment_kill(var_2, var_5);
}

stat_notify_register_func(var_0) {
  if(!isdefined(self.stat_notify_func))
    self.stat_notify_func = [];

  self.stat_notify_func[self.stat_notify_func.size] = var_0;
}

stat_notify(var_0, var_1) {
  if(isdefined(self.stat_notify_func)) {
    foreach(var_3 in self.stat_notify_func)
    self[[var_3]](var_0, var_1);
  }
}

career_stat_increment(var_0, var_1) {
  stat_notify(var_0, var_1);

  if(!maps\_utility::is_specialop())
    return;
}

register_shot_hit() {
  if(!isplayer(self)) {
    return;
  }
  if(isdefined(self.registeringshothit)) {
    return;
  }
  self.registeringshothit = 1;
  self.stats["shots_hit"]++;
  career_stat_increment("bullets_hit", 1);
  var_0 = self getcurrentweapon();

  if(is_new_weapon(var_0))
    register_new_weapon(var_0);

  self.stats["weapon"][var_0].shots_hit++;
  thread maps\_sp_matchdata::increment_hit(var_0);
  waittillframeend;
  self.registeringshothit = undefined;
}

shots_fired_recorder() {
  self endon("death");

  for (;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(!isdefined(var_0) || !maps\_utility::isprimaryweapon(var_0)) {
      continue;
    }
    self.stats["shots_fired"]++;
    career_stat_increment("bullets_fired", 1);

    if(is_new_weapon(var_0))
      register_new_weapon(var_0);

    self.stats["weapon"][var_0].shots_fired++;
    thread maps\_sp_matchdata::shots_fired(var_0);
  }
}

is_new_weapon(var_0) {
  if(isdefined(self.stats["weapon"][var_0]))
    return 0;

  return 1;
}

cause_is_explosive(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return 1;
    default:
      return 0;
  }

  return 0;
}

cause_is_grenade(var_0, var_1) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "emp_grenade":
      if(isdefined(var_1) && var_1 == "emp_grenade_var")
        return 1;

      break;
    case "mod_projectile_splash":
      if(isdefined(var_1) && var_1 == "iw5_microdronelauncher_sp")
        return 1;

      break;
    case "mod_grenade_splash":
    case "mod_grenade":
      return 1;
    default:
      return 0;
  }

  return 0;
}

register_new_weapon(var_0) {
  self.stats["weapon"][var_0] = spawnstruct();
  self.stats["weapon"][var_0].name = var_0;
  self.stats["weapon"][var_0].shots_fired = 0;
  self.stats["weapon"][var_0].shots_hit = 0;
  self.stats["weapon"][var_0].kills = 0;
  self.stats["weapon"][var_0].deaths = 0;
}

set_stat_dvars() {
  var_0 = 1;

  foreach(var_2 in level.players) {
    setdvar("stats_" + var_0 + "_kills_melee", var_2.stats["kills_melee"]);
    setdvar("stats_" + var_0 + "_kills_juggernaut", var_2.stats["kills_juggernaut"]);
    setdvar("stats_" + var_0 + "_kills_explosives", var_2.stats["kills_explosives"]);
    setdvar("stats_" + var_0 + "_kills_vehicle", var_2.stats["kills_vehicle"]);
    setdvar("stats_" + var_0 + "_kills_sentry", var_2.stats["kills_sentry"]);
    var_3 = var_2 get_best_weapons(5);

    foreach(var_5 in var_3) {
      var_5.accuracy = 0;

      if(var_5.shots_fired > 0)
        var_5.accuracy = int(var_5.shots_hit / var_5.shots_fired * 100);
    }

    for (var_7 = 1; var_7 < 6; var_7++) {
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_name", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_kills", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_shots", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_accuracy", " ");
    }

    for (var_7 = 0; var_7 < var_3.size; var_7++) {
      if(!isdefined(var_3[var_7])) {
        break;
      }

      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_name", var_3[var_7].name);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_kills", var_3[var_7].kills);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_shots", var_3[var_7].shots_fired);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_accuracy", var_3[var_7].accuracy + "%");
    }

    var_0++;
  }
}

get_best_weapons(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0; var_2++)
    var_1[var_2] = get_weapon_with_most_kills(var_1);

  return var_1;
}

get_weapon_with_most_kills(var_0) {
  if(!isdefined(var_0))
    var_0 = [];

  var_1 = undefined;

  foreach(var_3 in self.stats["weapon"]) {
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_3.name == var_6.name) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      continue;
    }
    if(!isdefined(var_1)) {
      var_1 = var_3;
      continue;
    }

    if(var_3.kills > var_1.kills)
      var_1 = var_3;
  }

  return var_1;
}

mark_stats_checkpoint() {}