/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2915.gsc
***************************************/

func_9768() {
  self.func_10E53["kills"] = 0;
  self.func_10E53["kills_melee"] = 0;
  self.func_10E53["kills_explosives"] = 0;
  self.func_10E53["kills_juggernaut"] = 0;
  self.func_10E53["kills_vehicle"] = 0;
  self.func_10E53["kills_sentry"] = 0;
  self.func_10E53["headshots"] = 0;
  self.func_10E53["shots_fired"] = 0;
  self.func_10E53["shots_hit"] = 0;
  self.func_10E53["weapon"] = [];
  thread func_FF05();
}

func_13901() {
  if(isDefined(self.func_54CA) && self.func_54CA) {
    return 1;
  }

  if(!isDefined(self.damagelocation)) {
    return 0;
  }

  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

func_DEBD(var_00, var_01, var_02, var_03) {
  var_04 = self;

  if(isDefined(self.owner)) {
    var_04 = self.owner;
  }

  if(!isplayer(var_04)) {
    if(isDefined(level.func_D5ED) && level.func_D5ED) {
      var_04 = level.players[randomint(level.players.size)];
    }
  }

  if(!isplayer(var_04)) {
    return;
  }
  if(isDefined(level.func_10259) && isDefined(var_0.func_5BD6) && var_0.func_5BD6) {
    return;
  }
  var_4.func_10E53["kills"]++;

  if(isDefined(var_00)) {
    if(var_00 func_13901()) {
      var_4.func_10E53["headshots"]++;
    }

    if(isDefined(var_0.func_A4A3)) {
      var_4.func_10E53["kills_juggernaut"]++;
    }

    if(isDefined(var_0.func_9F45)) {
      var_4.func_10E53["kills_sentry"]++;
    }

    if(var_0.code_classname == "script_vehicle") {
      var_4.func_10E53["kills_vehicle"]++;

      if(isDefined(var_0.func_E4FB)) {
        foreach(var_06 in var_0.func_E4FB) {
          if(isDefined(var_06)) {
            var_04 func_DEBD(var_06, var_01, var_02, var_03);
          }
        }
      }
    }
  }

  if(func_3B9F(var_01)) {
    var_4.func_10E53["kills_explosives"]++;
  }

  if(!isDefined(var_02)) {
    var_02 = var_04 getcurrentweapon();
  }

  if(issubstr(tolower(var_01), "melee")) {
    var_4.func_10E53["kills_melee"]++;

    if(weaponinventorytype(var_02) == "primary") {
      return;
    }
  }

  if(var_04 func_9C49(var_02)) {
    var_04 func_DEC5(var_02);
  }

  var_4.func_10E53["weapon"][var_02].kills++;
}

func_DED8() {
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(self.func_DEF6)) {
    return;
  }
  self.func_DEF6 = 1;
  self.func_10E53["shots_hit"]++;
  var_00 = self getcurrentweapon();

  if(func_9C49(var_00)) {
    func_DEC5(var_00);
  }

  self.func_10E53["weapon"][var_00].func_FF06++;
  waittillframeend;
  self.func_DEF6 = undefined;
}

func_FF05() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_00 = self getcurrentweapon();

    if(!isDefined(var_00) || !scripts\sp\utility::isprimaryweapon(var_00)) {
      continue;
    }
    self.func_10E53["shots_fired"]++;

    if(func_9C49(var_00)) {
      func_DEC5(var_00);
    }

    self.func_10E53["weapon"][var_00].func_FF04++;
  }
}

func_9C49(var_00) {
  if(isDefined(self.func_10E53["weapon"][var_00])) {
    return 0;
  }

  return 1;
}

func_3B9F(var_00) {
  var_00 = tolower(var_00);

  switch (var_00) {
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

func_DEC5(var_00) {
  self.func_10E53["weapon"][var_00] = spawnStruct();
  self.func_10E53["weapon"][var_00].name = var_00;
  self.func_10E53["weapon"][var_00].func_FF04 = 0;
  self.func_10E53["weapon"][var_00].func_FF06 = 0;
  self.func_10E53["weapon"][var_00].kills = 0;
}

func_F5B2() {
  var_00 = 1;

  foreach(var_02 in level.players) {
    setdvar("stats_" + var_00 + "_kills_melee", var_2.func_10E53["kills_melee"]);
    setdvar("stats_" + var_00 + "_kills_juggernaut", var_2.func_10E53["kills_juggernaut"]);
    setdvar("stats_" + var_00 + "_kills_explosives", var_2.func_10E53["kills_explosives"]);
    setdvar("stats_" + var_00 + "_kills_vehicle", var_2.func_10E53["kills_vehicle"]);
    setdvar("stats_" + var_00 + "_kills_sentry", var_2.func_10E53["kills_sentry"]);
    var_03 = var_02 func_7867(5);

    foreach(var_05 in var_03) {
      var_5.accuracy = 0;

      if(var_5.func_FF04 > 0) {
        var_5.accuracy = int(var_5.func_FF06 / var_5.func_FF04 * 100);
      }
    }

    for(var_07 = 1; var_07 < 6; var_7++) {
      setdvar("stats_" + var_00 + "_weapon" + var_07 + "_name", " ");
      setdvar("stats_" + var_00 + "_weapon" + var_07 + "_kills", " ");
      setdvar("stats_" + var_00 + "_weapon" + var_07 + "_shots", " ");
      setdvar("stats_" + var_00 + "_weapon" + var_07 + "_accuracy", " ");
    }

    for(var_07 = 0; var_07 < var_3.size; var_7++) {
      if(!isDefined(var_3[var_07])) {
        break;
      }
      setdvar("stats_" + var_00 + "_weapon" + (var_07 + 1) + "_name", var_3[var_07].name);
      setdvar("stats_" + var_00 + "_weapon" + (var_07 + 1) + "_kills", var_3[var_07].kills);
      setdvar("stats_" + var_00 + "_weapon" + (var_07 + 1) + "_shots", var_3[var_07].func_FF04);
      setdvar("stats_" + var_00 + "_weapon" + (var_07 + 1) + "_accuracy", var_3[var_07].accuracy + "%");
    }

    var_0++;
  }
}

func_7867(var_00) {
  var_01 = [];

  for(var_02 = 0; var_02 < var_00; var_2++) {
    var_1[var_02] = func_7D73(var_01);
  }

  return var_01;
}

func_7D73(var_00) {
  if(!isDefined(var_00)) {
    var_00 = [];
  }

  var_01 = undefined;

  foreach(var_03 in self.func_10E53["weapon"]) {
    var_04 = 0;

    foreach(var_06 in var_00) {
      if(var_3.name == var_6.name) {
        var_04 = 1;
        break;
      }
    }

    if(var_04) {
      continue;
    }
    if(!isDefined(var_01)) {
      var_01 = var_03;
      continue;
    }

    if(var_3.kills > var_1.kills) {
      var_01 = var_03;
    }
  }

  return var_01;
}