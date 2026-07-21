/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player_stats.gsc
***********************************************/

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

  if(!isPlayer(var_4)) {
    if(isDefined(level.pmc_match) && level.pmc_match)
      var_4 = level.players[randomint(level.players.size)];
  }

  if(!isPlayer(var_4)) {
    return;
  }
  if(isDefined(level.skip_pilot_kill_count) && isDefined(var_0.drivingvehicle) && var_0.drivingvehicle) {
    return;
  }
  var_4.stats["kills"]++;

  if(isDefined(var_0)) {
    if(var_0 was_headshot())
      var_4.stats["headshots"]++;

    if(isDefined(var_0.juggernaut))
      var_4.stats["kills_juggernaut"]++;

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

  if(isDefined(var_2))
    var_8 = asmdevgetallstates(var_2);
  else
    var_8 = var_4 getcurrentweapon();

  if(issubstr(tolower(var_1), "melee")) {
    var_4.stats["kills_melee"]++;

    if(weaponinventorytype(var_8) == "primary")
      return;
  }

  if(var_4 is_new_weapon(var_8))
    var_4 register_new_weapon(var_8);

  var_4.stats["weapon"][createheadicon(var_8)].kills++;
}

register_shot_hit() {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.registeringshothit)) {
    return;
  }
  self.registeringshothit = 1;
  self.stats["shots_hit"]++;
  var_0 = self getcurrentweapon();

  if(is_new_weapon(var_0))
    register_new_weapon(var_0);

  self.stats["weapon"][createheadicon(var_0)].shots_hit++;
  waittillframeend;
  self.registeringshothit = undefined;
}

shots_fired_recorder() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || !scripts\sp\utility::isprimaryweapon(var_0)) {
      continue;
    }
    self.stats["shots_fired"]++;

    if(is_new_weapon(var_0))
      register_new_weapon(var_0);

    self.stats["weapon"][createheadicon(var_0)].shots_fired++;
  }
}

is_new_weapon(var_0) {
  if(isDefined(self.stats["weapon"][createheadicon(var_0)]))
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
  var_1 = createheadicon(var_0);
  self.stats["weapon"][var_1] = spawnStruct();
  self.stats["weapon"][var_1].name = var_1;
  self.stats["weapon"][var_1].shots_fired = 0;
  self.stats["weapon"][var_1].shots_hit = 0;
  self.stats["weapon"][var_1].kills = 0;
}

set_stat_dvars() {
  var_0 = 1;

  foreach(var_2 in level.players) {
    setDvar("stats_" + var_0 + "_kills_melee", var_2.stats["kills_melee"]);
    setDvar("stats_" + var_0 + "_kills_juggernaut", var_2.stats["kills_juggernaut"]);
    setDvar("stats_" + var_0 + "_kills_explosives", var_2.stats["kills_explosives"]);
    setDvar("stats_" + var_0 + "_kills_vehicle", var_2.stats["kills_vehicle"]);
    setDvar("stats_" + var_0 + "_kills_sentry", var_2.stats["kills_sentry"]);
    var_3 = var_2 get_best_weapons(5);

    foreach(var_5 in var_3) {
      var_5.accuracy = 0;

      if(var_5.shots_fired > 0)
        var_5.accuracy = int(var_5.shots_hit / var_5.shots_fired * 100);
    }

    for(var_7 = 1; var_7 < 6; var_7++) {
      setDvar("stats_" + var_0 + "_weapon" + var_7 + "_name", " ");
      setDvar("stats_" + var_0 + "_weapon" + var_7 + "_kills", " ");
      setDvar("stats_" + var_0 + "_weapon" + var_7 + "_shots", " ");
      setDvar("stats_" + var_0 + "_weapon" + var_7 + "_accuracy", " ");
    }

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(!isDefined(var_3[var_7])) {
        break;
      }

      setDvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_name", var_3[var_7].name);
      setDvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_kills", var_3[var_7].kills);
      setDvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_shots", var_3[var_7].shots_fired);
      setDvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_accuracy", var_3[var_7].accuracy + "%");
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