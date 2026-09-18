/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
**********************************************/

init() {
  level.persistentdatainfo = [];
  maps\mp\gametypes\_class::init();
  maps\mp\gametypes\_missions::init();
  maps\mp\gametypes\_playercards::init();
  maps\mp\gametypes\_rank::init();
  if(getdvarint("4017", 0) > 0 || function_0367()) {
    return;
  }

  level thread updatebufferedstats();
  level thread func_A1C2();
}

func_529D() {
  self.bufferedstats = [];
  if(isbot(self)) {
    self resetplayerdata(common_scripts\utility::func_46AE());
    self resetplayerdata(common_scripts\utility::getstatgamemode());
    self resetplayerdata(common_scripts\utility::func_46A8());
    self resetplayerdata(common_scripts\utility::func_46AF());
    self resetplayerdata(common_scripts\utility::func_46AC());
  }

  if(maps\mp\_utility::rankingenabled()) {
    self.bufferedstats["totalShots"] = spawnStruct();
    self.bufferedstats["totalShots"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "totalShots");
    self.bufferedstats["totalShots"].var_2F14 = 0;
    self.bufferedstats["accuracy"] = spawnStruct();
    self.bufferedstats["accuracy"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "accuracy");
    self.bufferedstats["accuracy"].var_2F14 = 0;
    self.bufferedstats["misses"] = spawnStruct();
    self.bufferedstats["misses"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "misses");
    self.bufferedstats["misses"].var_2F14 = 0;
    self.bufferedstats["hits"] = spawnStruct();
    self.bufferedstats["hits"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "hits");
    self.bufferedstats["hits"].var_2F14 = 0;
    self.bufferedstats["timePlayedAllies"] = spawnStruct();
    self.bufferedstats["timePlayedAllies"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedAllies");
    self.bufferedstats["timePlayedAllies"].var_2F14 = 0;
    self.bufferedstats["timePlayedOpfor"] = spawnStruct();
    self.bufferedstats["timePlayedOpfor"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedOpfor");
    self.bufferedstats["timePlayedOpfor"].var_2F14 = 0;
    self.bufferedstats["timePlayedOther"] = spawnStruct();
    self.bufferedstats["timePlayedOther"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedOther");
    self.bufferedstats["timePlayedOther"].var_2F14 = 0;
    self.bufferedstats["timePlayedTotal"] = spawnStruct();
    self.bufferedstats["timePlayedTotal"].value = self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedTotal");
    self.bufferedstats["timePlayedTotal"].var_2F14 = 0;
  }

  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "timePlayed");
}

statget(param_00) {
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

statset(param_00, param_01) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(param_00 != "experience" && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
}

statadd(param_00, param_01, param_02) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame()) {
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

  var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01 + var_03);
}

statgetchild(param_00, param_01) {
  if(param_00 == "round") {
    return self getrankedplayerdata(common_scripts\utility::getstatgamemode(), param_00, param_01);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
}

statsetchild(param_00, param_01, param_02) {
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
    self setrankedplayerdata(common_scripts\utility::getstatgamemode(), param_00, param_01, param_02);
    return;
  }

  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01, param_02);
}

stataddchild(param_00, param_01, param_02) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, param_01, var_03 + param_02);
}

statgetchildbuffered(param_00, param_01) {
  if(!maps\mp\_utility::rankingenabled()) {
    return 0;
  }

  return self.bufferedchildstats[param_00][param_01];
}

statsetchildbuffered(param_00, param_01, param_02) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  self.bufferedchildstats[param_00][param_01] = param_02;
}

stataddchildbuffered(param_00, param_01, param_02) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_03 = statgetchildbuffered(param_00, param_01);
  statsetchildbuffered(param_00, param_01, var_03 + param_02);
}

func_9316(param_00, param_01, param_02) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_03 = statgetbuffered(param_00) + param_01;
  if(var_03 > param_02) {
    var_03 = param_02;
  }

  if(var_03 < statgetbuffered(param_00)) {
    var_03 = param_02;
  }

  statsetbuffered(param_00, var_03);
}

func_9319(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_04 = statgetchildbuffered(param_00, param_01) + param_02;
  if(var_04 > param_03) {
    var_04 = param_03;
  }

  if(var_04 < statgetchildbuffered(param_00, param_01)) {
    var_04 = param_03;
  }

  statsetchildbuffered(param_00, param_01, var_04);
}

statgetbuffered(param_00) {
  if(!maps\mp\_utility::rankingenabled()) {
    return 0;
  }

  return self.bufferedstats[param_00].value;
}

statsetbuffered(param_00, param_01) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  if(self.bufferedstats[param_00].value != param_01) {
    self.bufferedstats[param_00].value = param_01;
    self.bufferedstats[param_00].var_2F14 = 1;
  }
}

stataddbuffered(param_00, param_01) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_02 = statgetbuffered(param_00);
  statsetbuffered(param_00, var_02 + param_01);
}

updatebufferedstats() {
  wait(0.15);
  var_00 = 0;
  while(!level.gameended) {
    maps\mp\gametypes\_hostmigration::func_A782();
    var_00++;
    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    if(isDefined(level.players[var_00])) {
      level.players[var_00] writebufferedstats();
      level.players[var_00] func_A195();
    }

    wait(2);
  }

  foreach(var_02 in level.players) {
    var_02 writebufferedstats();
    var_02 func_A195();
  }
}

writebufferedstats() {
  var_00 = maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame() && !isDefined(level.disableallplayerstats) && level.disableallplayerstats;
  if(var_00) {
    foreach(var_03, var_02 in self.bufferedstats) {
      if(var_02.var_2F14 == 1) {
        self setrankedplayerdata(common_scripts\utility::func_46AE(), var_03, var_02.value);
        var_02.var_2F14 = 0;
      }
    }
  }

  foreach(var_03, var_02 in self.bufferedchildstats) {
    foreach(var_07, var_06 in var_02) {
      if(var_03 == "round") {
        self setrankedplayerdata(common_scripts\utility::getstatgamemode(), var_03, var_07, var_06);
        continue;
      }

      if(var_00) {
        self setrankedplayerdata(common_scripts\utility::func_46AE(), var_03, var_07, var_06);
      }
    }
  }
}

func_50FF(param_00, param_01, param_02) {
  if(maps\mp\_utility::iskillstreakweapon(param_00)) {
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
  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame()) {
    var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_03, param_01);
    var_05 = var_04 + param_02;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_03, param_01, var_05);
    if(param_01 == "kills") {
      if(maps\mp\_utility::iscacprimaryweapon(var_03)) {
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

      if(maps\mp\_utility::iscacsecondaryweapon(var_04)) {
        var_08 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestSecondaryID"));
        if(var_08 != var_04) {
          var_09 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_08, "kills");
          if(var_06 > var_09) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestSecondaryID", maps\mp\_utility::func_452A(var_04));
            return;
          }

          return;
        }

        return;
      }

      if(maps\mp\gametypes\_weapons::func_5747(var_05)) {
        var_0A = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestLethalID"));
        if(var_0A != var_05) {
          var_0B = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_0A, "kills");
          if(var_08 > var_0B) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestLethalID", maps\mp\_utility::func_452A(var_05));
            return;
          }

          return;
        }

        return;
      }

      return;
    }

    if(var_05 == "assists") {
      if(maps\mp\gametypes\_weapons::func_57F6(var_08)) {
        var_0C = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestTacticalID"));
        if(var_0C != var_08) {
          var_0D = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_0C, "assists");
          if(var_0B > var_0D) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestTacticalID", maps\mp\_utility::func_452A(var_08));
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

  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame()) {
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

  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame()) {
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", param_00, param_01);
    var_04 = var_03 + param_02;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", param_00, param_01, var_04);
    if(param_01 == "killsOrAssists") {
      var_05 = ["uav", "counter_uav", "flak_gun"];
      var_06 = ["carepackage", "flamethrower", "fritzx", "mortar_strike", "missile_strike", "airstrike", "firebomb", "emergency_carepackage", "fighter_strike", "plane_gunner", "paratroopers", "molotovs"];
      if(common_scripts\utility::func_F79(var_05, param_00)) {
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

      if(common_scripts\utility::func_F79(var_07, param_01)) {
        var_09 = maps\mp\_utility::func_452B(self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakAttackID"));
        if(var_09 != param_01) {
          var_0A = self getrankedplayerdata(common_scripts\utility::func_46AE(), "scorestreakStats", var_09, "killsOrAssists");
          if(var_05 > var_0A) {
            self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestScorestreakAttackID", maps\mp\_utility::func_452A(param_01));
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
  if(maps\mp\_utility::iskillstreakweapon(var_00) || maps\mp\_utility::isenvironmentweapon(var_00)) {
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

    if(self.trackingweaponkills > 0) {
      func_50F9(var_02, "kills", self.trackingweaponkills);
    }

    if(self.var_9BB9 > 0) {
      func_50F9(var_02, "hits", self.var_9BB9);
    }

    if(self.trackingweaponheadshots > 0) {
      func_50F9(var_02, "headShots", self.trackingweaponheadshots);
    }

    if(self.var_9BB6 > 0) {
      func_50F9(var_02, "deaths", self.var_9BB6);
    }

    if(self.trackingweaponhipfirekills > 0) {
      func_50F9(var_02, "hipfirekills", self.trackingweaponhipfirekills);
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
    self.trackingweaponkills = 0;
    self.var_9BB9 = 0;
    self.trackingweaponheadshots = 0;
    self.var_9BB6 = 0;
    self.trackingweaponhipfirekills = 0;
    self.trackingweaponassists = 0;
    self.trackingweaponmultikills = 0;
    self.var_9BBD = 0;
    return;
  }

  var_02 = function_02FF(var_02, "_sp");
  if(!maps\mp\_utility::iscacprimaryweapon(var_02) && !maps\mp\_utility::iscacsecondaryweapon(var_02) && !maps\mp\gametypes\_weapons::func_5747(var_02) && !maps\mp\gametypes\_weapons::func_57F6(var_02)) {
    return;
  }

  if(self.var_9BBC > 0) {
    func_50FF(var_02, "shots", self.var_9BBC);
    maps\mp\_matchdata::func_5EAF(var_02, "shots", self.var_9BBC, var_00);
  }

  if(self.trackingweaponkills > 0) {
    func_50FF(var_02, "kills", self.trackingweaponkills);
    maps\mp\_matchdata::func_5EAF(var_02, "kills", self.trackingweaponkills, var_00);
  }

  if(self.var_9BB9 > 0) {
    func_50FF(var_02, "hits", self.var_9BB9);
    maps\mp\_matchdata::func_5EAF(var_02, "hits", self.var_9BB9, var_00);
  }

  if(self.trackingweaponheadshots > 0) {
    func_50FF(var_02, "headShots", self.trackingweaponheadshots);
    maps\mp\_matchdata::func_5EAF(var_02, "headShots", self.trackingweaponheadshots, var_00);
  }

  if(self.var_9BB6 > 0) {
    func_50FF(var_02, "deaths", self.var_9BB6);
    maps\mp\_matchdata::func_5EAF(var_02, "deaths", self.var_9BB6, var_00);
  }

  if(self.trackingweaponhipfirekills > 0) {
    func_50FF(var_02, "hipfirekills", self.trackingweaponhipfirekills);
    maps\mp\_matchdata::func_5EAF(var_02, "hipfirekills", self.trackingweaponhipfirekills, var_00);
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

    if(self.trackingweaponkills > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "kills", self.trackingweaponkills);
      }
    }

    if(self.var_9BB9 > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "hits", self.var_9BB9);
      }
    }

    if(self.trackingweaponheadshots > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "headShots", self.trackingweaponheadshots);
      }
    }

    if(self.trackingweaponhipfirekills > 0) {
      if(var_09 != "tactical") {
        func_50F9(var_09, "hipfirekills", self.trackingweaponhipfirekills);
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
  self.trackingweaponkills = 0;
  self.var_9BB9 = 0;
  self.trackingweaponheadshots = 0;
  self.var_9BB6 = 0;
  self.trackingweaponhipfirekills = 0;
  self.trackingweaponassists = 0;
  self.trackingweaponmultikills = 0;
  self.var_9BBD = 0;
}

func_A1C2() {
  level waittill("game_ended");
  if(!maps\mp\_utility::matchmakinggame()) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  foreach(var_07 in level.players) {
    var_05 = var_05 + var_07.timeplayed["total"];
  }

  incrementcounter("global_minutes", int(var_05 / 60));
  if(!maps\mp\_utility::waslastround()) {
    return;
  }

  wait 0.05;
  foreach(var_07 in level.players) {
    var_00 = var_00 + var_07.kills;
    var_01 = var_01 + var_07.deaths;
    var_02 = var_02 + var_07.assists;
    var_03 = var_03 + var_07.var_4BF9;
    var_04 = var_04 + var_07.suicides;
  }

  incrementcounter("global_kills", var_00);
  incrementcounter("global_deaths", var_01);
  incrementcounter("global_assists", var_02);
  incrementcounter("global_headshots", var_03);
  incrementcounter("global_suicides", var_04);
  incrementcounter("global_games", 1);
}