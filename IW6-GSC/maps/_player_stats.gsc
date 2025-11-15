/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_player_stats.gsc
*****************************************************/

init_stats() {
  self.stats["kills"] = 0;
  self.stats["kills_melee"] = 0;
  self.stats["kills_explosives"] = 0;
  self.stats["kills_juggernaut"] = 0;
  self.stats["kills_vehicle"] = 0;
  self.stats["kills_sentry"] = 0;
  self.stats["headshots"] = 0;
  self.stats["shots_fired"] = 0;
  self.stats["shots_hit"] = 0;
  self.stats["weapon"] = [];
  thread shots_fired_recorder();
}

was_headshot() {
  if(isDefined(self.died_of_headshot) && self.died_of_headshot)
    return 1;

  if(!isDefined(self.damagelocation))
    return 0;

  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

register_kill(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(self.owner))
    var_4 = self.owner;

  if(!isplayer(var_4)) {
    if(isDefined(level.pmc_match) && level.pmc_match)
      var_4 = level.players[randomint(level.players.size)];
  }

  if(!isplayer(var_4)) {
    return;
  }
  if(isDefined(level.skip_pilot_kill_count) && isDefined(var_0.drivingvehicle) && var_0.drivingvehicle) {
    return;
  }
  var_4.stats["kills"]++;
  var_4 career_stat_increment("kills", 1);

  if(maps\_utility::is_specialop())
    level notify("specops_player_kill", var_4, var_0, var_2, var_3);

  if(isDefined(var_0)) {
    if(var_0 was_headshot()) {
      var_4.stats["headshots"]++;
      var_4 career_stat_increment("headshots", 1);
    }

    if(isDefined(var_0.juggernaut)) {
      var_4.stats["kills_juggernaut"]++;
      var_4 career_stat_increment("kills_juggernaut", 1);
    }

    if(isDefined(var_0.issentrygun))
      var_4.stats["kills_sentry"]++;

    if(var_0.code_classname == "script_vehicle") {
      var_4.stats["kills_vehicle"]++;

      if(isDefined(var_0.riders)) {
        foreach(var_6 in var_0.riders) {
          if(isDefined(var_6))
            var_4 register_kill(var_6, var_1, var_2, var_3);
        }
      }
    }
  }

  if(cause_is_explosive(var_1))
    var_4.stats["kills_explosives"]++;

  if(!isDefined(var_2))
    var_2 = var_4 getcurrentweapon();

  if(issubstr(tolower(var_1), "melee")) {
    var_4.stats["kills_melee"]++;

    if(weaponinventorytype(var_2) == "primary")
      return;
  }

  if(var_4 is_new_weapon(var_2))
    var_4 register_new_weapon(var_2);

  var_4.stats["weapon"][var_2].kills++;
}

career_stat_increment(var_0, var_1) {
  if(!maps\_utility::is_specialop()) {
    return;
  }
  var_2 = int(self getplayerdata("career", var_0)) + var_1;
  self setplayerdata("career", var_0, var_2);
}

register_shot_hit() {
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(self.registeringshothit)) {
    return;
  }
  self.registeringshothit = 1;
  self.stats["shots_hit"]++;
  career_stat_increment("bullets_hit", 1);
  var_0 = self getcurrentweapon();

  if(is_new_weapon(var_0))
    register_new_weapon(var_0);

  self.stats["weapon"][var_0].shots_hit++;
  waittillframeend;
  self.registeringshothit = undefined;
}

shots_fired_recorder() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || !maps\_utility::isprimaryweapon(var_0)) {
      continue;
    }
    self.stats["shots_fired"]++;
    career_stat_increment("bullets_fired", 1);

    if(is_new_weapon(var_0))
      register_new_weapon(var_0);

    self.stats["weapon"][var_0].shots_fired++;
  }
}

is_new_weapon(var_0) {
  if(isDefined(self.stats["weapon"][var_0]))
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

register_new_weapon(var_0) {
  self.stats["weapon"][var_0] = spawnStruct();
  self.stats["weapon"][var_0].name = var_0;
  self.stats["weapon"][var_0].shots_fired = 0;
  self.stats["weapon"][var_0].shots_hit = 0;
  self.stats["weapon"][var_0].kills = 0;
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

    for(var_7 = 1; var_7 < 6; var_7++) {
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_name", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_kills", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_shots", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_accuracy", " ");
    }

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(!isDefined(var_3[var_7])) {
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

  for(var_2 = 0; var_2 < var_0; var_2++)
    var_1[var_2] = get_weapon_with_most_kills(var_1);

  return var_1;
}

get_weapon_with_most_kills(var_0) {
  if(!isDefined(var_0))
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
    if(!isDefined(var_1)) {
      var_1 = var_3;
      continue;
    }

    if(var_3.kills > var_1.kills)
      var_1 = var_3;
  }

  return var_1;
}