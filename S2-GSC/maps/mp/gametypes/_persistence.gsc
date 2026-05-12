/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
**********************************************/

func_00D5() {
  level.var_6F79 = [];
  maps\mp\gametypes\_class::func_00D5();
  maps\mp\gametypes\_missions::func_00D5();
  maps\mp\gametypes\_playercards::func_00D5();
  maps\mp\gametypes\_rank::func_00D5();
  if(getdvarint("4017", 0) > 0 || function_0367()) {
    return;
  }

  level thread func_A0ED();
  level thread func_A1C2();
}

func_529D() {
  self.var_1CEF = [];
  if(isbot(self)) {
    self resetplayerdata(common_scripts\utility::func_46AE());
    self resetplayerdata(common_scripts\utility::func_46A7());
    self resetplayerdata(common_scripts\utility::func_46A8());
    self resetplayerdata(common_scripts\utility::func_46AF());
    self resetplayerdata(common_scripts\utility::func_46AC());
  }

  if(maps\mp\_utility::func_7A69()) {
    self.var_1CEF["totalShots"] = spawnStruct();
    self.var_1CEF["totalShots"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "totalShots");
    self.var_1CEF["totalShots"].var_2F14 = 0;
    self.var_1CEF["accuracy"] = spawnStruct();
    self.var_1CEF["accuracy"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "accuracy");
    self.var_1CEF["accuracy"].var_2F14 = 0;
    self.var_1CEF["misses"] = spawnStruct();
    self.var_1CEF["misses"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "misses");
    self.var_1CEF["misses"].var_2F14 = 0;
    self.var_1CEF["hits"] = spawnStruct();
    self.var_1CEF["hits"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "hits");
    self.var_1CEF["hits"].var_2F14 = 0;
    self.var_1CEF["timePlayedAllies"] = spawnStruct();
    self.var_1CEF["timePlayedAllies"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedAllies");
    self.var_1CEF["timePlayedAllies"].var_2F14 = 0;
    self.var_1CEF["timePlayedOpfor"] = spawnStruct();
    self.var_1CEF["timePlayedOpfor"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedOpfor");
    self.var_1CEF["timePlayedOpfor"].var_2F14 = 0;
    self.var_1CEF["timePlayedOther"] = spawnStruct();
    self.var_1CEF["timePlayedOther"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedOther");
    self.var_1CEF["timePlayedOther"].var_2F14 = 0;
    self.var_1CEF["timePlayedTotal"] = spawnStruct();
    self.var_1CEF["timePlayedTotal"].var_A281 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedTotal");
    self.var_1CEF["timePlayedTotal"].var_2F14 = 0;
  }

  self.var_1CEE = [];
  self.var_1CEE["round"] = [];
  self.var_1CEE["round"]["timePlayed"] = self getrankedplayerdata(common_scripts\utility::func_46A7(), "round", "timePlayed");
}

func_932F(param_00) {
  if(maps\mp\_utility::func_585F()) {
    if(param_00 == "experience") {
      param_00 = "totalXP";
    }

    if(param_00 == "prestige") {
      param_00 = "prestigeLevel";
    }
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00);
}

func_9338(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return;
  }

  if(param_00 != "experience" && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
}

func_9314(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(isDefined(param_02)) {
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_02);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_02, param_01 + var_03);
    return;
  }

  var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01 + var_03);
}

func_9331(param_00, param_01) {
  if(param_00 == "round") {
    return self getrankedplayerdata(common_scripts\utility::func_46A7(), param_00, param_01);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
}

func_933A(param_00, param_01, param_02) {
  if(function_01EF(self)) {
    return;
  }

  if(maps\mp\_utility::func_551F()) {
    return;
  }

  if(function_0367()) {
    return;
  }

  if(param_00 == "round") {
    self setrankedplayerdata(common_scripts\utility::func_46A7(), param_00, param_01, param_02);
    return;
  }

  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01, param_02);
}

func_9317(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_761E()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01, var_03 + param_02);
}

func_9332(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69()) {
    return 0;
  }

  return self.var_1CEE[param_00][param_01];
}

func_933B(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  self.var_1CEE[param_00][param_01] = param_02;
}

func_9318(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  var_03 = func_9332(param_00, param_01);
  func_933B(param_00, param_01, var_03 + param_02);
}

func_9316(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  var_03 = func_9330(param_00) + param_01;
  if(var_03 > param_02) {
    var_03 = param_02;
  }

  if(var_03 < func_9330(param_00)) {
    var_03 = param_02;
  }

  func_9339(param_00, var_03);
}

func_9319(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  var_04 = func_9332(param_00, param_01) + param_02;
  if(var_04 > param_03) {
    var_04 = param_03;
  }

  if(var_04 < func_9332(param_00, param_01)) {
    var_04 = param_03;
  }

  func_933B(param_00, param_01, var_04);
}

func_9330(param_00) {
  if(!maps\mp\_utility::func_7A69()) {
    return 0;
  }

  return self.var_1CEF[param_00].var_A281;
}

func_9339(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  if(self.var_1CEF[param_00].var_A281 != param_01) {
    self.var_1CEF[param_00].var_A281 = param_01;
    self.var_1CEF[param_00].var_2F14 = 1;
  }
}

func_9315(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69()) {
    return;
  }

  var_02 = func_9330(param_00);
  func_9339(param_00, var_02 + param_01);
}

func_A0ED() {
  wait(0.15);
  var_00 = 0;
  while(!level.var_3F9D) {
    maps\mp\gametypes\_hostmigration::func_A782();
    var_00++;
    if(var_00 >= level.var_744A.size) {
      var_00 = 0;
    }

    if(isDefined(level.var_744A[var_00])) {
      level.var_744A[var_00] func_AAB9();
      level.var_744A[var_00] func_A195();
    }

    wait(2);
  }

  foreach(var_02 in level.var_744A) {
    var_02 func_AAB9();
    var_02 func_A195();
  }
}

func_AAB9() {
  var_00 = maps\mp\_utility::func_7A69() && !maps\mp\_utility::func_761E() && !isDefined(level.disableallplayerstats) && level.disableallplayerstats;
  if(var_00) {
    foreach(var_03, var_02 in self.var_1CEF) {
      if(var_02.var_2F14 == 1) {
        self setrankedplayerdata(common_scripts\utility::func_46AE(), var_03, var_02.var_A281);
        var_02.var_2F14 = 0;
      }
    }
  }

  foreach(var_03, var_02 in self.var_1CEE) {
    foreach(var_07, var_06 in var_02) {
      if(var_03 == "round") {
        self setrankedplayerdata(common_scripts\utility::func_46A7(), var_03, var_07, var_06);
        continue;
      }

      if(var_00) {
        self setrankedplayerdata(common_scripts\utility::func_46AE(), var_03, var_07, var_06);
      }
    }
  }
}

func_50FF(param_00, param_01, param_02) {
  if(maps\mp\_utility::func_5740(param_00)) {
    return;
  }

  if((isDefined(level.var_2FAB) && level.var_2FAB) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(isDefined(level.var_2FAA) && level.var_2FAA) {
    return;
  }

  if(function_03AF()) {
    return;
  }

  var_03 = maps\mp\_utility::func_45B5(param_00);
  if(maps\mp\_utility::func_7A69() && !maps\mp\_utility::func_761E()) {
    var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_03, param_01);
    var_05 = var_04 + param_02;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_03, param_01, var_05);
    if(param_01 == "kills") {
      if(maps\mp\_utility::func_5699(var_03)) {
        var_06 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestPrimaryID"));
        if(var_06 != var_03) {
          var_07 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_06, "kills");
          if(var_05 > var_07) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestPrimaryID", maps\mp\_utility::func_452A(var_03));
            return;
          }

          return;
        }

        return;
      }

      if(maps\mp\_utility::func_569A(var_03)) {
        var_08 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestSecondaryID"));
        if(var_08 != var_03) {
          var_09 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_08, "kills");
          if(var_05 > var_09) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestSecondaryID", maps\mp\_utility::func_452A(var_03));
            return;
          }

          return;
        }

        return;
      }

      if(maps\mp\gametypes\_weapons::func_5747(var_03)) {
        var_0A = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestLethalID"));
        if(var_0A != var_03) {
          var_0B = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_0A, "kills");
          if(var_05 > var_0B) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestLethalID", maps\mp\_utility::func_452A(var_03));
            return;
          }

          return;
        }

        return;
      }

      return;
    }

    if(param_01 == "assists") {
      if(maps\mp\gametypes\_weapons::func_57F6(var_03)) {
        var_0C = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestTacticalID"));
        if(var_0C != var_03) {
          var_0D = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_0C, "assists");
          if(var_05 > var_0D) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestTacticalID", maps\mp\_utility::func_452A(var_03));
            return;
          }

          return;
        }

        return;
      }

      return;
    }
  }
}

func_50F9(param_00, param_01, param_02) {
  if((isDefined(level.var_2FAB) && level.var_2FAB) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(getdvarint("spv_enableAttachmentStats", 0) == 0) {
    return;
  }

  if(function_03AF()) {
    return;
  }

  if(maps\mp\_utility::func_7A69() && !maps\mp\_utility::func_761E()) {
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "attachmentsStats", param_00, param_01);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "attachmentsStats", param_00, param_01, var_03 + param_02);
  }
}

incrementscorestreakstat(param_00, param_01, param_02) {
  if(function_03AF()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(param_00 == "tripwire" || param_00 == "raid_flak" || param_00 == "raid_fighters" || param_00 == "dogfight_flak" || param_00 == "raid_tesla_moon" || param_00 == "basic_training_serum") {
    return;
  }

  if(maps\mp\_utility::func_7A69() && !maps\mp\_utility::func_761E()) {
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", param_00, param_01);
    var_04 = var_03 + param_02;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", param_00, param_01, var_04);
    if(param_01 == "killsOrAssists") {
      var_05 = ["uav", "counter_uav", "flak_gun"];
      var_06 = ["carepackage", "flamethrower", "fritzx", "mortar_strike", "missile_strike", "airstrike", "firebomb", "emergency_carepackage", "fighter_strike", "plane_gunner", "paratroopers", "molotovs"];
      if(common_scripts\utility::func_0F79(var_05, param_00)) {
        var_07 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakSupportID"));
        if(var_07 != param_00) {
          var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", var_07, "killsOrAssists");
          if(var_04 > var_08) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakSupportID", maps\mp\_utility::func_452A(param_00));
            return;
          }

          return;
        }

        return;
      }

      if(common_scripts\utility::func_0F79(var_06, param_00)) {
        var_09 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakAttackID"));
        if(var_09 != param_00) {
          var_0A = self getrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", var_09, "killsOrAssists");
          if(var_04 > var_0A) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakAttackID", maps\mp\_utility::func_452A(param_00));
            return;
          }

          return;
        }

        return;
      }

      return;
    }
  }
}

func_A195() {
  if(!isDefined(self.var_9BBB)) {
    return;
  }

  if(self.var_9BBB == "" || self.var_9BBB == "none") {
    return;
  }

  var_00 = self.var_9BBB;
  if(maps\mp\_utility::func_5740(var_00) || maps\mp\_utility::func_56DF(var_00)) {
    return;
  }

  var_01 = maps\mp\_utility::func_4738(var_00);
  var_02 = var_01[0];
  if(var_01[0] == "alt") {
    var_02 = var_01[1];
    foreach(var_04 in var_01) {
      if(var_04 == "gl") {
        var_02 = "gl";
        break;
      }
    }
  }

  if(var_02 == "gl") {
    if(self.var_9BBC > 0) {
      func_50F9(var_02, "shots", self.var_9BBC);
    }

    if(self.var_9BBA > 0) {
      func_50F9(var_02, "kills", self.var_9BBA);
    }

    if(self.var_9BB9 > 0) {
      func_50F9(var_02, "hits", self.var_9BB9);
    }

    if(self.var_9BB7 > 0) {
      func_50F9(var_02, "headShots", self.var_9BB7);
    }

    if(self.var_9BB6 > 0) {
      func_50F9(var_02, "deaths", self.var_9BB6);
    }

    if(self.var_9BB8 > 0) {
      func_50F9(var_02, "hipfirekills", self.var_9BB8);
    }

    if(self.var_9BBD > 0) {
      func_50F9(var_02, "timeInUse", self.var_9BBD);
    }

    if(self.trackingweaponassists > 0) {
      func_50F9(var_02, "assists", self.trackingweaponassists);
    }

    if(self.trackingweaponmultikills > 0) {
      func_50F9(var_02, "multikills", self.trackingweaponmultikills);
    }

    self.var_9BBB = "none";
    self.var_9BBC = 0;
    self.var_9BBA = 0;
    self.var_9BB9 = 0;
    self.var_9BB7 = 0;
    self.var_9BB6 = 0;
    self.var_9BB8 = 0;
    self.trackingweaponassists = 0;
    self.trackingweaponmultikills = 0;
    self.var_9BBD = 0;
    return;
  }

  var_02 = function_02FF(var_02, "_sp");
  if(!maps\mp\_utility::func_5699(var_02) && !maps\mp\_utility::func_569A(var_02) && !maps\mp\gametypes\_weapons::func_5747(var_02) && !maps\mp\gametypes\_weapons::func_57F6(var_02)) {
    return;
  }

  if(self.var_9BBC > 0) {
    func_50FF(var_02, "shots", self.var_9BBC);
    maps\mp\_matchdata::func_5EAF(var_02, "shots", self.var_9BBC, var_00);
  }

  if(self.var_9BBA > 0) {
    func_50FF(var_02, "kills", self.var_9BBA);
    maps\mp\_matchdata::func_5EAF(var_02, "kills", self.var_9BBA, var_00);
  }

  if(self.var_9BB9 > 0) {
    func_50FF(var_02, "hits", self.var_9BB9);
    maps\mp\_matchdata::func_5EAF(var_02, "hits", self.var_9BB9, var_00);
  }

  if(self.var_9BB7 > 0) {
    func_50FF(var_02, "headShots", self.var_9BB7);
    maps\mp\_matchdata::func_5EAF(var_02, "headShots", self.var_9BB7, var_00);
  }

  if(self.var_9BB6 > 0) {
    func_50FF(var_02, "deaths", self.var_9BB6);
    maps\mp\_matchdata::func_5EAF(var_02, "deaths", self.var_9BB6, var_00);
  }

  if(self.var_9BB8 > 0) {
    func_50FF(var_02, "hipfirekills", self.var_9BB8);
    maps\mp\_matchdata::func_5EAF(var_02, "hipfirekills", self.var_9BB8, var_00);
  }

  if(self.var_9BBD > 0) {
    func_50FF(var_02, "timeInUse", self.var_9BBD);
    maps\mp\_matchdata::func_5EAF(var_02, "timeInUse", self.var_9BBD, var_00);
  }

  if(self.trackingweaponassists > 0) {
    func_50FF(var_02, "assists", self.trackingweaponassists);
    maps\mp\_matchdata::func_5EAF(var_02, "assists", self.trackingweaponassists, var_00);
  }

  if(self.trackingweaponmultikills > 0) {
    func_50FF(var_02, "multikills", self.trackingweaponmultikills);
    maps\mp\_matchdata::func_5EAF(var_02, "multikills", self.trackingweaponmultikills, var_00);
  }

  var_06 = function_0061(var_00);
  foreach(var_08 in var_06) {
    var_09 = maps\mp\_utility::func_1150(var_08);
    if(var_09 == "gl") {
      continue;
    }

    if(self.var_9BBC > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "shots", self.var_9BBC);
      }
    }

    if(self.var_9BBA > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "kills", self.var_9BBA);
      }
    }

    if(self.var_9BB9 > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "hits", self.var_9BB9);
      }
    }

    if(self.var_9BB7 > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "headShots", self.var_9BB7);
      }
    }

    if(self.var_9BB8 > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "hipfirekills", self.var_9BB8);
      }
    }

    if(self.var_9BBD > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "timeInUse", self.var_9BBD);
      }
    }

    if(self.var_9BB6 > 0) {
      func_50F9(var_09, "deaths", self.var_9BB6);
    }

    if(self.trackingweaponassists > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "assists", self.trackingweaponassists);
      }
    }

    if(self.trackingweaponmultikills > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "multikills", self.trackingweaponmultikills);
      }
    }
  }

  self.var_9BBB = "none";
  self.var_9BBC = 0;
  self.var_9BBA = 0;
  self.var_9BB9 = 0;
  self.var_9BB7 = 0;
  self.var_9BB6 = 0;
  self.var_9BB8 = 0;
  self.trackingweaponassists = 0;
  self.trackingweaponmultikills = 0;
  self.var_9BBD = 0;
}

func_A1C2() {
  level waittill("game_ended");
  if(!maps\mp\_utility::func_602B()) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  foreach(var_07 in level.var_744A) {
    var_05 = var_05 + var_07.var_9A06["total"];
  }

  incrementcounter("global_minutes", int(var_05 / 60));
  if(!maps\mp\_utility::func_A872()) {
    return;
  }

  wait 0.05;
  foreach(var_07 in level.var_744A) {
    var_00 = var_00 + var_07.var_00E3;
    var_01 = var_01 + var_07.var_0070;
    var_02 = var_02 + var_07.var_0021;
    var_03 = var_03 + var_07.var_4BF9;
    var_04 = var_04 + var_07.var_94DD;
  }

  incrementcounter("global_kills", var_00);
  incrementcounter("global_deaths", var_01);
  incrementcounter("global_assists", var_02);
  incrementcounter("global_headshots", var_03);
  incrementcounter("global_suicides", var_04);
  incrementcounter("global_games", 1);
}