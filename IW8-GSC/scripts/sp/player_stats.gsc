/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player_stats.gsc
***********************************************/

function init_stats() {
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

function was_headshot() {
  if(isDefined(self.died_of_headshot) && self.died_of_headshot) {
    return true;
  }

  if(!isDefined(self.damagelocation)) {
    return false;
  }

  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

function register_kill(var0, var1, var2, var3) {
  var4 = self;

  if(isDefined(self.owner)) {
    var4 = self.owner;
  }

  if(!isPlayer(var4)) {
    if(isDefined(level.pmc_match) && level.pmc_match) {
      var4 = level.players[randomint(level.players.size)];
    }
  }

  if(!isPlayer(var4)) {
    return;
  }

  if(isDefined(level.skip_pilot_kill_count) && isDefined(var0.drivingvehicle) && var0.drivingvehicle) {
    return;
  }

  var4.stats["kills"]++;

  if(isDefined(var0)) {
    if(was_headshot(var0)) {
      var4.stats["headshots"]++;
    }

    if(isDefined(var0.juggernaut)) {
      var4.stats["kills_juggernaut"]++;
    }

    if(isDefined(var0.issentrygun)) {
      var4.stats["kills_sentry"]++;
    }

    if(var0.code_classname == "script_vehicle") {
      var4.stats["kills_vehicle"]++;

      if(isDefined(var0.riders)) {
        foreach(var6 in var0.riders) {
          if(isDefined(var6)) {
            register_kill(var4, var6, var1, var2, var3);
          }
        }
      }
    }
  }

  if(cause_is_explosive(var1)) {
    var4.stats["kills_explosives"]++;
  }

  if(isDefined(var2)) {
    var8 = asmdevgetallstates(var2);
  } else {
    var8 = var8 getcurrentweapon();
  }

  if(issubstr(tolower(var2), "melee")) {
    var8.stats["kills_melee"]++;

    if(weaponinventorytype(var8) == "primary") {
      return;
    }
  }

  if(is_new_weapon(var8, var8)) {
    register_new_weapon(var8, var8);
  }

  var8.stats["weapon"][createheadicon(var8)].kills++;
}

function register_shot_hit() {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.registeringshothit)) {
    return;
  }

  self.registeringshothit = 1;
  self.stats["shots_hit"]++;
  var0 = self getcurrentweapon();

  if(is_new_weapon(var0)) {
    register_new_weapon(var0);
  }

  self.stats["weapon"][createheadicon(var0)].shots_hit++;
  waittillframeend();
  self.registeringshothit = undefined;
}

function shots_fired_recorder() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var0 = self getcurrentweapon();

    if(!isDefined(var0) || !scripts\sp\utility::isprimaryweapon(var0)) {
      continue;
    }

    self.stats["shots_fired"]++;

    if(is_new_weapon(var0)) {
      register_new_weapon(var0);
    }

    self.stats["weapon"][createheadicon(var0)].shots_fired++;
  }
}

function is_new_weapon(var0) {
  if(isDefined(self.stats["weapon"][createheadicon(var0)])) {
    return false;
  }

  return true;
}

function cause_is_explosive(var0) {
  var0 = tolower(var0);

  switch (var0) {
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return true;
    default:
      return false;
  }

  return false;
}

function register_new_weapon(var0) {
  var1 = createheadicon(var0);
  self.stats["weapon"][var1] = spawnStruct();
  self.stats["weapon"][var1].name = var1;
  self.stats["weapon"][var1].shots_fired = 0;
  self.stats["weapon"][var1].shots_hit = 0;
  self.stats["weapon"][var1].kills = 0;
}

function set_stat_dvars() {
  var0 = 1;

  foreach(var2 in level.players) {
    setDvar("stats_" + var0 + "_kills_melee", var2.stats["kills_melee"]);
    setDvar("stats_" + var0 + "_kills_juggernaut", var2.stats["kills_juggernaut"]);
    setDvar("stats_" + var0 + "_kills_explosives", var2.stats["kills_explosives"]);
    setDvar("stats_" + var0 + "_kills_vehicle", var2.stats["kills_vehicle"]);
    setDvar("stats_" + var0 + "_kills_sentry", var2.stats["kills_sentry"]);
    var3 = get_best_weapons(var2, 5);

    foreach(var5 in var3) {
      var5.accuracy = 0;

      if(var5.shots_fired > 0) {
        var5.accuracy = int(var5.shots_hit / var5.shots_fired * 100);
      }
    }

    for(var7 = 1; var7 < 6; var7++) {
      setDvar("stats_" + var0 + "_weapon" + var7 + "_name", " ");
      setDvar("stats_" + var0 + "_weapon" + var7 + "_kills", " ");
      setDvar("stats_" + var0 + "_weapon" + var7 + "_shots", " ");
      setDvar("stats_" + var0 + "_weapon" + var7 + "_accuracy", " ");
    }

    for(var7 = 0; var7 < var3.size; var7++) {
      if(!isDefined(var3[var7])) {
        break;
      }

      setDvar("stats_" + var0 + "_weapon" + var7 + 1 + "_name", var3[var7].name);
      setDvar("stats_" + var0 + "_weapon" + var7 + 1 + "_kills", var3[var7].kills);
      setDvar("stats_" + var0 + "_weapon" + var7 + 1 + "_shots", var3[var7].shots_fired);
      setDvar("stats_" + var0 + "_weapon" + var7 + 1 + "_accuracy", var3[var7].accuracy + "%");
    }

    var0++;
  }
}

function get_best_weapons(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0; var2++) {
    var1 = get_weapon_with_most_kills(var1);
  }

  return var1;
}

function get_weapon_with_most_kills(var0) {
  if(!isDefined(var0)) {
    var0 = [];
  }

  var1 = undefined;

  foreach(var3 in self.stats["weapon"]) {
    var4 = 0;

    foreach(var6 in var0) {
      if(var3.name == var6.name) {
        var4 = 1;
        break;
      }
    }

    if(var4) {
      continue;
    }

    if(!isDefined(var1)) {
      var1 = var3;
      continue;
    }

    if(var3.kills > var1.kills) {
      var1 = var3;
    }
  }

  return var1;
}