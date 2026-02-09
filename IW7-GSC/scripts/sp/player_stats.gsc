/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\player_stats.gsc
*********************************************/

func_9768() {
  self.var_10E53["kills"] = 0;
  self.var_10E53["kills_melee"] = 0;
  self.var_10E53["kills_explosives"] = 0;
  self.var_10E53["kills_juggernaut"] = 0;
  self.var_10E53["kills_vehicle"] = 0;
  self.var_10E53["kills_sentry"] = 0;
  self.var_10E53["headshots"] = 0;
  self.var_10E53["shots_fired"] = 0;
  self.var_10E53["shots_hit"] = 0;
  self.var_10E53["weapon"] = [];
  thread func_FF05();
}

func_13901() {
  if(isDefined(self.var_54CA) && self.var_54CA) {
    return 1;
  }

  if(!isDefined(self.var_DD)) {
    return 0;
  }

  return self.var_DD == "helmet" || self.var_DD == "head" || self.var_DD == "neck";
}

func_DEBD(var_0, var_1, var_2, var_3) {
  var_4 = self;
  if(isDefined(self.owner)) {
    var_4 = self.owner;
  }

  if(!isPlayer(var_4)) {
    if(isDefined(level.var_D5ED) && level.var_D5ED) {
      var_4 = level.players[randomint(level.players.size)];
    }
  }

  if(!isPlayer(var_4)) {
    return;
  }

  if(isDefined(level.var_10259) && isDefined(var_0.var_5BD6) && var_0.var_5BD6) {
    return;
  }

  var_4.var_10E53["kills"]++;
  if(isDefined(var_0)) {
    if(var_0 func_13901()) {
      var_4.var_10E53["headshots"]++;
    }

    if(isDefined(var_0.var_A4A3)) {
      var_4.var_10E53["kills_juggernaut"]++;
    }

    if(isDefined(var_0.var_9F45)) {
      var_4.var_10E53["kills_sentry"]++;
    }

    if(var_0.var_9F == "script_vehicle") {
      var_4.var_10E53["kills_vehicle"]++;
      if(isDefined(var_0.var_E4FB)) {
        foreach(var_6 in var_0.var_E4FB) {
          if(isDefined(var_6)) {
            var_4 func_DEBD(var_6, var_1, var_2, var_3);
          }
        }
      }
    }
  }

  if(func_3B9F(var_1)) {
    var_4.var_10E53["kills_explosives"]++;
  }

  if(!isDefined(var_2)) {
    var_2 = var_4 getcurrentweapon();
  }

  if(issubstr(tolower(var_1), "melee")) {
    var_4.var_10E53["kills_melee"]++;
    if(weaponinventorytype(var_2) == "primary") {
      return;
    }
  }

  if(var_4 func_9C49(var_2)) {
    var_4 func_DEC5(var_2);
  }

  var_4.var_10E53["weapon"][var_2].setculldist++;
}

func_DED8() {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.var_DEF6)) {
    return;
  }

  self.var_DEF6 = 1;
  self.var_10E53["shots_hit"]++;
  var_0 = self getcurrentweapon();
  if(func_9C49(var_0)) {
    func_DEC5(var_0);
  }

  self.var_10E53["weapon"][var_0].var_FF06++;
  waittillframeend;
  self.var_DEF6 = undefined;
}

func_FF05() {
  self endon("death");
  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();
    if(!isDefined(var_0) || !scripts\sp\utility::isprimaryweapon(var_0)) {
      continue;
    }

    self.var_10E53["shots_fired"]++;
    if(func_9C49(var_0)) {
      func_DEC5(var_0);
    }

    self.var_10E53["weapon"][var_0].var_FF04++;
  }
}

func_9C49(var_0) {
  if(isDefined(self.var_10E53["weapon"][var_0])) {
    return 0;
  }

  return 1;
}

func_3B9F(var_0) {
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

func_DEC5(var_0) {
  self.var_10E53["weapon"][var_0] = spawnStruct();
  self.var_10E53["weapon"][var_0].name = var_0;
  self.var_10E53["weapon"][var_0].var_FF04 = 0;
  self.var_10E53["weapon"][var_0].var_FF06 = 0;
  self.var_10E53["weapon"][var_0].setculldist = 0;
}

func_F5B2() {
  var_0 = 1;
  foreach(var_2 in level.players) {
    setDvar("stats_" + var_0 + "_kills_melee", var_2.var_10E53["kills_melee"]);
    setDvar("stats_" + var_0 + "_kills_juggernaut", var_2.var_10E53["kills_juggernaut"]);
    setDvar("stats_" + var_0 + "_kills_explosives", var_2.var_10E53["kills_explosives"]);
    setDvar("stats_" + var_0 + "_kills_vehicle", var_2.var_10E53["kills_vehicle"]);
    setDvar("stats_" + var_0 + "_kills_sentry", var_2.var_10E53["kills_sentry"]);
    var_3 = var_2 func_7867(5);
    foreach(var_5 in var_3) {
      var_5.accuracy = 0;
      if(var_5.var_FF04 > 0) {
        var_5.accuracy = int(var_5.var_FF06 / var_5.var_FF04 * 100);
      }
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

      setDvar("stats_" + var_0 + "_weapon" + var_7 + 1 + "_name", var_3[var_7].name);
      setDvar("stats_" + var_0 + "_weapon" + var_7 + 1 + "_kills", var_3[var_7].setculldist);
      setDvar("stats_" + var_0 + "_weapon" + var_7 + 1 + "_shots", var_3[var_7].var_FF04);
      setDvar("stats_" + var_0 + "_weapon" + var_7 + 1 + "_accuracy", var_3[var_7].accuracy + "%");
    }

    var_0++;
  }
}

func_7867(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1[var_2] = func_7D73(var_1);
  }

  return var_1;
}

func_7D73(var_0) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  var_1 = undefined;
  foreach(var_3 in self.var_10E53["weapon"]) {
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

    if(var_3.setculldist > var_1.setculldist) {
      var_1 = var_3;
    }
  }

  return var_1;
}