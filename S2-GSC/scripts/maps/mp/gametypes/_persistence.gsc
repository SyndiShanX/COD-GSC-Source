/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_persistence.gsc
******************************************************/

init() {
  level.persistentdatainfo = [];
  maps\mp\gametypes\_class::init();
  maps\mp\gametypes\_missions::init();
  maps\mp\gametypes\_playercards::init();
  maps\mp\gametypes\_rank::init();

  if(getdvarint("4017", 0) > 0 || _func_367()) {
    return;
  }
  level thread updatebufferedstats();
  level thread _id_A1C2();
}

_id_529D() {
  self.bufferedstats = [];

  if(isbot(self)) {
    self _meth_821E(common_scripts\utility::_id_46AE());
    self _meth_821E(common_scripts\utility::_id_46A7());
    self _meth_821E(common_scripts\utility::_id_46A8());
    self _meth_821E(common_scripts\utility::_id_46AF());
    self _meth_821E(common_scripts\utility::_id_46AC());
  }

  if(maps\mp\_utility::rankingenabled()) {
    self.bufferedstats["totalShots"] = spawnStruct();
    self.bufferedstats["totalShots"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "totalShots");
    self.bufferedstats["totalShots"]._id_2F14 = 0;
    self.bufferedstats["accuracy"] = spawnStruct();
    self.bufferedstats["accuracy"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "accuracy");
    self.bufferedstats["accuracy"]._id_2F14 = 0;
    self.bufferedstats["misses"] = spawnStruct();
    self.bufferedstats["misses"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "misses");
    self.bufferedstats["misses"]._id_2F14 = 0;
    self.bufferedstats["hits"] = spawnStruct();
    self.bufferedstats["hits"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "hits");
    self.bufferedstats["hits"]._id_2F14 = 0;
    self.bufferedstats["timePlayedAllies"] = spawnStruct();
    self.bufferedstats["timePlayedAllies"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedAllies");
    self.bufferedstats["timePlayedAllies"]._id_2F14 = 0;
    self.bufferedstats["timePlayedOpfor"] = spawnStruct();
    self.bufferedstats["timePlayedOpfor"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedOpfor");
    self.bufferedstats["timePlayedOpfor"]._id_2F14 = 0;
    self.bufferedstats["timePlayedOther"] = spawnStruct();
    self.bufferedstats["timePlayedOther"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedOther");
    self.bufferedstats["timePlayedOther"]._id_2F14 = 0;
    self.bufferedstats["timePlayedTotal"] = spawnStruct();
    self.bufferedstats["timePlayedTotal"].value = self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedTotal");
    self.bufferedstats["timePlayedTotal"]._id_2F14 = 0;
  }

  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata(common_scripts\utility::_id_46A7(), "round", "timePlayed");
}

statget(var_0) {
  if(maps\mp\_utility::_id_585F()) {
    if(var_0 == "experience")
      var_0 = "totalXP";

    if(var_0 == "prestige")
      var_0 = "prestigeLevel";
  }

  return self getplayerdata(common_scripts\utility::_id_46AE(), var_0);
}

statset(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E()) {
    return;
  }
  if(var_0 != "experience" && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1);
}

statadd(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E()) {
    return;
  }
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(isDefined(var_2)) {
    var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), var_0, var_2);
    self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_2, var_1 + var_3);
  } else {
    var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), var_0);
    self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1 + var_3);
  }
}

statgetchild(var_0, var_1) {
  if(var_0 == "round")
    return self getplayerdata(common_scripts\utility::_id_46A7(), var_0, var_1);
  else
    return self getplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1);
}

statsetchild(var_0, var_1, var_2) {
  if(_func_1EF(self)) {
    return;
  }
  if(maps\mp\_utility::_id_551F()) {
    return;
  }
  if(_func_367()) {
    return;
  }
  if(var_0 == "round")
    self setplayerdata(common_scripts\utility::_id_46A7(), var_0, var_1, var_2);
  else {
    if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E()) {
      return;
    }
    if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
      return;
    }
    self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1, var_2);
  }
}

stataddchild(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_761E()) {
    return;
  }
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1);
  self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_1, var_3 + var_2);
}

statgetchildbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return self.bufferedchildstats[var_0][var_1];
}

statsetchildbuffered(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  self.bufferedchildstats[var_0][var_1] = var_2;
}

stataddchildbuffered(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_3 = statgetchildbuffered(var_0, var_1);
  statsetchildbuffered(var_0, var_1, var_3 + var_2);
}

_id_9316(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_3 = statgetbuffered(var_0) + var_1;

  if(var_3 > var_2)
    var_3 = var_2;

  if(var_3 < statgetbuffered(var_0))
    var_3 = var_2;

  statsetbuffered(var_0, var_3);
}

_id_9319(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_4 = statgetchildbuffered(var_0, var_1) + var_2;

  if(var_4 > var_3)
    var_4 = var_3;

  if(var_4 < statgetchildbuffered(var_0, var_1))
    var_4 = var_3;

  statsetchildbuffered(var_0, var_1, var_4);
}

statgetbuffered(var_0) {
  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return self.bufferedstats[var_0].value;
}

statsetbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(self.bufferedstats[var_0].value != var_1) {
    self.bufferedstats[var_0].value = var_1;
    self.bufferedstats[var_0]._id_2F14 = 1;
  }
}

stataddbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_2 = statgetbuffered(var_0);
  statsetbuffered(var_0, var_2 + var_1);
}

updatebufferedstats() {
  wait 0.15;
  var_0 = 0;

  while(!level.gameended) {
    maps\mp\gametypes\_hostmigration::_id_A782();
    var_0++;

    if(var_0 >= level.players.size)
      var_0 = 0;

    if(isDefined(level.players[var_0])) {
      level.players[var_0] writebufferedstats();
      level.players[var_0] _id_A195();
    }

    wait 2.0;
  }

  foreach(var_2 in level.players) {
    var_2 writebufferedstats();
    var_2 _id_A195();
  }
}

writebufferedstats() {
  var_0 = maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E() && !(isDefined(level.disableallplayerstats) && level.disableallplayerstats);

  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats) {
      if(var_2._id_2F14 == 1) {
        self setplayerdata(common_scripts\utility::_id_46AE(), var_3, var_2.value);
        var_2._id_2F14 = 0;
      }
    }
  }

  foreach(var_3, var_2 in self.bufferedchildstats) {
    foreach(var_7, var_6 in var_2) {
      if(var_3 == "round") {
        self setplayerdata(common_scripts\utility::_id_46A7(), var_3, var_7, var_6);
        continue;
      }

      if(var_0)
        self setplayerdata(common_scripts\utility::_id_46AE(), var_3, var_7, var_6);
    }
  }
}

_id_50FF(var_0, var_1, var_2) {
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return;
  }
  if(isDefined(level._id_2FAB) && level._id_2FAB || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(isDefined(level._id_2FAA) && level._id_2FAA) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  var_3 = maps\mp\_utility::_id_45B5(var_0);

  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E()) {
    var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_3, var_1);
    var_5 = var_4 + var_2;
    self setplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_3, var_1, var_5);

    if(var_1 == "kills") {
      if(maps\mp\_utility::iscacprimaryweapon(var_3)) {
        var_6 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestPrimaryID"));

        if(var_6 != var_3) {
          var_7 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_6, "kills");

          if(var_5 > var_7) {
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestPrimaryID", maps\mp\_utility::_id_452A(var_3));
            return;
          }

          return;
        }
      } else if(maps\mp\_utility::iscacsecondaryweapon(var_3)) {
        var_8 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestSecondaryID"));

        if(var_8 != var_3) {
          var_9 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_8, "kills");

          if(var_5 > var_9) {
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestSecondaryID", maps\mp\_utility::_id_452A(var_3));
            return;
          }

          return;
        }
      } else if(_id_0513::_id_5747(var_3)) {
        var_10 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestLethalID"));

        if(var_10 != var_3) {
          var_11 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_10, "kills");

          if(var_5 > var_11)
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestLethalID", maps\mp\_utility::_id_452A(var_3));
        }
      }
    } else if(var_1 == "assists") {
      if(_id_0513::_id_57F6(var_3)) {
        var_12 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestTacticalID"));

        if(var_12 != var_3) {
          var_13 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_12, "assists");

          if(var_5 > var_13)
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestTacticalID", maps\mp\_utility::_id_452A(var_3));
        }
      }
    }
  }
}

_id_50F9(var_0, var_1, var_2) {
  if(isDefined(level._id_2FAB) && level._id_2FAB || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(getdvarint("spv_enableAttachmentStats", 0) == 0) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E()) {
    var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "attachmentsStats", var_0, var_1);
    self setplayerdata(common_scripts\utility::_id_46AE(), "attachmentsStats", var_0, var_1, var_3 + var_2);
  }
}

incrementscorestreakstat(var_0, var_1, var_2) {
  if(_func_3AF()) {
    return;
  }
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(var_0 == "tripwire" || var_0 == "raid_flak" || var_0 == "raid_fighters" || var_0 == "dogfight_flak" || var_0 == "raid_tesla_moon" || var_0 == "basic_training_serum") {
    return;
  }
  if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E()) {
    var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "scorestreakStats", var_0, var_1);
    var_4 = var_3 + var_2;
    self setplayerdata(common_scripts\utility::_id_46AE(), "scorestreakStats", var_0, var_1, var_4);

    if(var_1 == "killsOrAssists") {
      var_5 = ["uav", "counter_uav", "flak_gun"];
      var_6 = ["carepackage", "flamethrower", "fritzx", "mortar_strike", "missile_strike", "airstrike", "firebomb", "emergency_carepackage", "fighter_strike", "plane_gunner", "paratroopers", "molotovs"];

      if(common_scripts\utility::_id_0F79(var_5, var_0)) {
        var_7 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestScorestreakSupportID"));

        if(var_7 != var_0) {
          var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "scorestreakStats", var_7, "killsOrAssists");

          if(var_4 > var_8) {
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestScorestreakSupportID", maps\mp\_utility::_id_452A(var_0));
            return;
          }

          return;
        }
      } else if(common_scripts\utility::_id_0F79(var_6, var_0)) {
        var_9 = maps\mp\_utility::_id_452B(self getplayerdata(common_scripts\utility::_id_46AE(), "bestScorestreakAttackID"));

        if(var_9 != var_0) {
          var_10 = self getplayerdata(common_scripts\utility::_id_46AE(), "scorestreakStats", var_9, "killsOrAssists");

          if(var_4 > var_10)
            self setplayerdata(common_scripts\utility::_id_46AE(), "bestScorestreakAttackID", maps\mp\_utility::_id_452A(var_0));
        }
      }
    }
  }
}

_id_A195() {
  if(!isDefined(self._id_9BBB)) {
    return;
  }
  if(self._id_9BBB == "" || self._id_9BBB == "none") {
    return;
  }
  var_0 = self._id_9BBB;

  if(maps\mp\_utility::iskillstreakweapon(var_0) || maps\mp\_utility::_id_56DF(var_0)) {
    return;
  }
  var_1 = maps\mp\_utility::_id_4738(var_0);
  var_2 = var_1[0];

  if(var_1[0] == "alt") {
    var_2 = var_1[1];

    foreach(var_4 in var_1) {
      if(var_4 == "gl") {
        var_2 = "gl";
        break;
      }
    }
  }

  if(var_2 == "gl") {
    if(self._id_9BBC > 0)
      _id_50F9(var_2, "shots", self._id_9BBC);

    if(self._id_9BBA > 0)
      _id_50F9(var_2, "kills", self._id_9BBA);

    if(self._id_9BB9 > 0)
      _id_50F9(var_2, "hits", self._id_9BB9);

    if(self._id_9BB7 > 0)
      _id_50F9(var_2, "headShots", self._id_9BB7);

    if(self._id_9BB6 > 0)
      _id_50F9(var_2, "deaths", self._id_9BB6);

    if(self._id_9BB8 > 0)
      _id_50F9(var_2, "hipfirekills", self._id_9BB8);

    if(self._id_9BBD > 0)
      _id_50F9(var_2, "timeInUse", self._id_9BBD);

    if(self.trackingweaponassists > 0)
      _id_50F9(var_2, "assists", self.trackingweaponassists);

    if(self.trackingweaponmultikills > 0)
      _id_50F9(var_2, "multikills", self.trackingweaponmultikills);

    self._id_9BBB = "none";
    self._id_9BBC = 0;
    self._id_9BBA = 0;
    self._id_9BB9 = 0;
    self._id_9BB7 = 0;
    self._id_9BB6 = 0;
    self._id_9BB8 = 0;
    self.trackingweaponassists = 0;
    self.trackingweaponmultikills = 0;
    self._id_9BBD = 0;
    return;
  }

  var_2 = _func_2FF(var_2, "_sp");

  if(!maps\mp\_utility::iscacprimaryweapon(var_2) && !maps\mp\_utility::iscacsecondaryweapon(var_2) && !_id_0513::_id_5747(var_2) && !_id_0513::_id_57F6(var_2)) {
    return;
  }
  if(self._id_9BBC > 0) {
    _id_50FF(var_2, "shots", self._id_9BBC);
    _id_0485::_id_5EAF(var_2, "shots", self._id_9BBC, var_0);
  }

  if(self._id_9BBA > 0) {
    _id_50FF(var_2, "kills", self._id_9BBA);
    _id_0485::_id_5EAF(var_2, "kills", self._id_9BBA, var_0);
  }

  if(self._id_9BB9 > 0) {
    _id_50FF(var_2, "hits", self._id_9BB9);
    _id_0485::_id_5EAF(var_2, "hits", self._id_9BB9, var_0);
  }

  if(self._id_9BB7 > 0) {
    _id_50FF(var_2, "headShots", self._id_9BB7);
    _id_0485::_id_5EAF(var_2, "headShots", self._id_9BB7, var_0);
  }

  if(self._id_9BB6 > 0) {
    _id_50FF(var_2, "deaths", self._id_9BB6);
    _id_0485::_id_5EAF(var_2, "deaths", self._id_9BB6, var_0);
  }

  if(self._id_9BB8 > 0) {
    _id_50FF(var_2, "hipfirekills", self._id_9BB8);
    _id_0485::_id_5EAF(var_2, "hipfirekills", self._id_9BB8, var_0);
  }

  if(self._id_9BBD > 0) {
    _id_50FF(var_2, "timeInUse", self._id_9BBD);
    _id_0485::_id_5EAF(var_2, "timeInUse", self._id_9BBD, var_0);
  }

  if(self.trackingweaponassists > 0) {
    _id_50FF(var_2, "assists", self.trackingweaponassists);
    _id_0485::_id_5EAF(var_2, "assists", self.trackingweaponassists, var_0);
  }

  if(self.trackingweaponmultikills > 0) {
    _id_50FF(var_2, "multikills", self.trackingweaponmultikills);
    _id_0485::_id_5EAF(var_2, "multikills", self.trackingweaponmultikills, var_0);
  }

  var_6 = _func_061(var_0);

  foreach(var_8 in var_6) {
    var_9 = maps\mp\_utility::_id_1150(var_8);

    if(var_9 == "gl") {
      continue;
    }
    if(self._id_9BBC > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "shots", self._id_9BBC);
    }

    if(self._id_9BBA > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "kills", self._id_9BBA);
    }

    if(self._id_9BB9 > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "hits", self._id_9BB9);
    }

    if(self._id_9BB7 > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "headShots", self._id_9BB7);
    }

    if(self._id_9BB8 > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "hipfirekills", self._id_9BB8);
    }

    if(self._id_9BBD > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "timeInUse", self._id_9BBD);
    }

    if(self._id_9BB6 > 0)
      _id_50F9(var_9, "deaths", self._id_9BB6);

    if(self.trackingweaponassists > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "assists", self.trackingweaponassists);
    }

    if(self.trackingweaponmultikills > 0) {
      if(var_9 != "tactical")
        _id_50F9(var_9, "multikills", self.trackingweaponmultikills);
    }
  }

  self._id_9BBB = "none";
  self._id_9BBC = 0;
  self._id_9BBA = 0;
  self._id_9BB9 = 0;
  self._id_9BB7 = 0;
  self._id_9BB6 = 0;
  self._id_9BB8 = 0;
  self.trackingweaponassists = 0;
  self.trackingweaponmultikills = 0;
  self._id_9BBD = 0;
}

_id_A1C2() {
  level waittill("game_ended");

  if(!maps\mp\_utility::matchmakinggame()) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in level.players)
  var_5 = var_5 + var_7._id_9A06["total"];

  _func_0F0("global_minutes", int(var_5 / 60));

  if(!maps\mp\_utility::waslastround()) {
    return;
  }
  waitframe();

  foreach(var_7 in level.players) {
    var_0 = var_0 + var_7._id_00E3;
    var_1 = var_1 + var_7.deaths;
    var_2 = var_2 + var_7._id_0021;
    var_3 = var_3 + var_7._id_4BF9;
    var_4 = var_4 + var_7._id_94DD;
  }

  _func_0F0("global_kills", var_0);
  _func_0F0("global_deaths", var_1);
  _func_0F0("global_assists", var_2);
  _func_0F0("global_headshots", var_3);
  _func_0F0("global_suicides", var_4);
  _func_0F0("global_games", 1);
}