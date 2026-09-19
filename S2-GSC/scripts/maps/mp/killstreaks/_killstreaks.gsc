/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_killstreaks.gsc
********************************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["killstreaks"]))
      var_0.pers["killstreaks"] = [];

    if(!isDefined(var_0.pers["kID"]))
      var_0.pers["kID"] = 10;

    var_0._id_28D1 = 0;
    var_0._id_9133 = 0;

    if(getdvarint("4017", 0)) {
      return;
    }
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("spawned_player", "faux_spawn");
    thread _id_5A7B();
    thread _id_944D();
    thread _id_A698();
    thread _id_9450();
    thread _id_944F();

    if(!level._id_258F)
      thread _id_6F34();

    if(!isDefined(self.pers["killstreaks"][0]))
      _id_5333();

    if(!isDefined(self.pers["killstreak_stowed_ammo"])) {
      self.pers["killstreak_stowed_ammo"] = [];
      thread _id_2385();
    }

    if(!isDefined(self._id_353B))
      self._id_353B = 0;

    if(!isDefined(self._id_0A06) || self._id_0A06 == 0) {
      self._id_0A06 = self.pers["ks_totalPoints"];
      self._id_0A0D = self.pers["ks_totalPointsSupport"];
      _id_A16E();

      for(var_0 = 0; var_0 < 5; var_0++) {
        if(!isDefined(self.pers["killstreaks"][var_0])) {
          continue;
        }
        var_1 = self.pers["killstreaks"][var_0]._id_944C;
        var_2 = self.pers["killstreaks"][var_0]._id_13AF;

        if(isDefined(var_1)) {
          if(var_0 == 0 && (!isDefined(var_2) || !var_2)) {
            continue;
          }
          var_3 = maps\mp\_utility::_id_453F(self.pers["killstreaks"][var_0]._id_944C);
          var_4 = "ks_icon" + common_scripts\utility::_id_9AAD(var_0);
          self setclientomnvar(var_4, var_3);
        }
      }

      _id_A16F(0);
    }

    _id_A170();
    _id_47A1();
    _id_A16E();
  }
}

_id_A16F(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    if(!var_0 && var_1 == 0) {
      continue;
    }
    var_2 = "ks_icon" + common_scripts\utility::_id_9AAD(var_1);
    self setclientomnvar(var_2, 0);
    var_3 = self getclientomnvar("ks_hasStreak");
    var_4 = var_3 &~(1 << var_1) &~(1 << var_1 + 5);
    self setclientomnvar("ks_hasStreak", var_4);
  }

  var_5 = 1;

  if(isDefined(self.killstreaks)) {
    foreach(var_7 in self.killstreaks) {
      var_8 = self.pers["killstreaks"][var_5];
      var_8._id_944C = var_7;
      var_9 = var_8._id_944C;
      var_2 = "ks_icon" + common_scripts\utility::_id_9AAD(var_5);
      self setclientomnvar(var_2, maps\mp\_utility::_id_453F(var_9));
      var_3 = self getclientomnvar("ks_hasStreak");
      var_4 = var_3 &~(1 << var_5);

      if(_id_57F0(self, var_7))
        var_4 = var_4 | 1 << var_5 + 5;
      else
        var_4 = var_4 &~(1 << var_5 + 5);

      self setclientomnvar("ks_hasStreak", var_4);
      var_5++;
    }
  }
}

_id_5333() {
  var_0 = spawnStruct();
  var_0._id_13AF = 0;
  var_0._id_944C = undefined;
  var_0._id_3539 = 0;
  var_0._id_145C = undefined;
  var_0._id_0117 = undefined;
  var_0._id_59F1 = undefined;
  var_0._id_5CC6 = undefined;
  var_0._id_5703 = 1;
  var_0._id_66CC = undefined;
  self.pers["killstreaks"][0] = var_0;

  for(var_1 = 1; var_1 < 5; var_1++) {
    var_2 = spawnStruct();
    var_2._id_13AF = 0;
    var_2._id_944C = undefined;
    var_2._id_3539 = 1;
    var_2._id_145C = 1;
    var_2._id_0117 = undefined;
    var_2._id_59F1 = undefined;
    var_2._id_5CC6 = -1;
    var_2._id_5703 = 0;
    self.pers["killstreaks"][var_1] = var_2;
  }

  _id_A16F(1);
  self setclientomnvar("ks_selectedIndex", -1);
  var_3 = self getclientomnvar("ks_hasStreak");
  var_4 = var_3 &~32;
  self setclientomnvar("ks_hasStreak", var_4);
}

_id_57F0(var_0, var_1) {
  return var_0 maps\mp\_utility::_hasperk("specialty_supportstreaks");
}

_id_A16E() {
  if(!isDefined(self.pers["killstreaks"])) {
    for(var_0 = 1; var_0 < 5; var_0++)
      self setclientomnvar("ks_count" + common_scripts\utility::_id_9AAD(var_0), 0);

    self setclientomnvar("ks_count_updated", 1);
    return;
  }

  for(var_0 = 1; var_0 < 5; var_0++) {
    if(!isDefined(self.pers["killstreaks"][var_0])) {
      continue;
    }
    var_1 = self.pers["killstreaks"][var_0]._id_944C;
    var_2 = "ks_count" + common_scripts\utility::_id_9AAD(var_0);
    var_3 = "ks_points" + common_scripts\utility::_id_9AAD(var_0);

    if(!isDefined(var_1)) {
      self setclientomnvar(var_2, 0);
      continue;
    }

    if(isDefined(self.pers["supportStreaksEarned"]) && isDefined(self.pers["supportStreaksEarned"][var_1]) && self.pers["supportStreaksEarned"][var_1]) {
      self setclientomnvar(var_3, 0);
      self setclientomnvar(var_2, -1);
      continue;
    }

    var_4 = _id_46B4(self.pers["killstreaks"][var_0]._id_944C);

    if(_id_57F0(self, var_1)) {
      var_5 = self._id_0A0D / var_4;
      var_6 = var_4 - self._id_0A0D;
    } else if(var_1 == "basic_training_serum") {
      if(isDefined(self.pers["basicTrainingSerumEarnProgress"])) {
        var_5 = self.pers["basicTrainingSerumEarnProgress"];
        var_6 = int(100 * (1 - self.pers["basicTrainingSerumEarnProgress"]));
      } else {
        var_5 = 0;
        var_6 = 100;
      }
    } else {
      if(var_4 == 0)
        var_5 = self._id_0A06;
      else
        var_5 = self._id_0A06 / var_4;

      var_6 = var_4 - self._id_0A06;
    }

    if(var_5 >= 1) {
      var_5 = 0;
      var_6 = var_4;
    }

    self setclientomnvar(var_3, var_6);
    self setclientomnvar(var_2, var_5);
  }

  self setclientomnvar("ks_count_updated", 1);
}

_id_457A(var_0) {
  if(!isDefined(self.killstreaks))
    return 0;

  var_1 = 0;

  foreach(var_3 in self.killstreaks) {
    var_4 = _id_57F0(self, var_3);

    if(var_0 && !var_4 || !var_0 && var_4) {
      continue;
    }
    var_5 = _id_46B4(var_3);

    if(var_5 > var_1)
      var_1 = var_5;
  }

  return var_1;
}

_id_A170() {
  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_0 = self.pers["killstreaks"];
  var_1 = 0;

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(isDefined(var_0[var_2]) && isDefined(var_0[var_2]._id_944C)) {
      var_3 = self getclientomnvar("ks_hasStreak");

      if(var_0[var_2]._id_13AF == 1)
        var_4 = var_3 | 1 << var_2;
      else
        var_4 = var_3 &~(1 << var_2);

      self setclientomnvar("ks_hasStreak", var_4);

      if(var_0[var_2]._id_13AF == 1)
        var_1++;

      continue;
    }

    var_3 = self getclientomnvar("ks_hasStreak");
    var_4 = var_3 &~(1 << var_2);
    self setclientomnvar("ks_hasStreak", var_4);
  }

  if(var_1 == 0)
    self setclientomnvar("ks_hasStreak", 0);

  if(isDefined(self._id_5A69))
    self setclientomnvar("ks_selectedIndex", self._id_5A69);
  else
    self setclientomnvar("ks_selectedIndex", -1);
}

_id_A698() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");

  for(;;) {
    self waittill("joined_team");
    _id_2400(1);
  }
}

_id_5A7A() {
  var_0 = self.pers["killstreaks"];
  var_1 = var_0[self._id_5A69]._id_944C;
  var_2 = var_0[self._id_5A69]._id_5CC6;
  var_3 = var_0[self._id_5A69]._id_3539;
  var_4 = var_0[self._id_5A69]._id_145C;
  var_5 = var_0[self._id_5A69]._id_59F1;
  var_6 = var_0[self._id_5A69]._id_5703;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = ["grenade_info_processing", "death", "disconnect", "carepackage_grenade_switch", "CarepackageKillstreakFuncComplete"];
  self.lastusedkillstreakslotindex = self._id_5A69;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  if(self._id_5A69 == 0)
    var_11 = var_0[0]._id_66CC;

  if(!maps\mp\_utility::_id_A27A(var_1)) {
    if(maps\mp\_utility::_id_3153(var_1)) {
      self setclientomnvar("ui_map_location_selector", -1);
      self._id_8C04 = 1;
    }

    return 0;
  }

  var_13 = 0;

  if(maps\mp\_utility::_hasperk("specialty_explosivebullets") && !issubstr(var_1, "explosive_ammo"))
    var_13 = 1;

  if(level._id_53C7)
    maps\mp\gametypes\scorestreak_training::_id_244D();

  if(issubstr(var_1, "airdrop")) {
    if(!self[[level._id_5A61[var_1]]](var_2, var_5))
      return 0;
  } else if(!self[[level._id_5A61[var_1]]](var_2))
    return 0;

  if(level._id_53C7) {
    self.pers["scorestreaksCalled"]++;
    maps\mp\_utility::_id_867B(self.pers["scorestreaksCalled"]);
    self.pers["score"] = self.pers["score"] + 1;

    if(self.pers["score"] < 65535)
      self.score = self.pers["score"];
  }

  if(var_13)
    maps\mp\_utility::_id_0735("specialty_explosivebullets");

  if(isDefined(var_11) && var_1 != var_0[self._id_5A69]._id_944C) {
    var_12 = 1;
    var_10 = var_11;
  }

  var_14 = _id_46B4(var_1);

  if(var_1 == "airstrike" || var_1 == "firebomb" || var_1 == "plane_gunner" || var_1 == "paratroopers" || var_1 == "emergency_carepackage" || var_1 == "flak_gun" || var_1 == "attack_dogs" || var_1 == "advanced_uav" || var_1 == "v2_rocket") {
    var_15 = maps\mp\_utility::_id_453F(var_1);

    if(var_15 != -1)
      maps\mp\_utility::_id_863E(20, self.team, self getentitynumber(), var_15);
  }

  self.lastusedkillstreakindexweapon = self._id_5A69;
  thread _id_A129(var_12, var_10);
  _id_A206(var_1, var_4, self.lastusedkillstreakindexweapon);
  self.lastusedkillstreakindexweapon = undefined;
  return 1;
}

_id_A206(var_0, var_1, var_2) {
  if(_id_3150(var_0) && isDefined(self.pers["killstreak_stowed_ammo"])) {
    var_3 = maps\mp\_utility::_id_454A(var_0, self.team, maps\mp\_utility::_hasperk("specialty_improvedstreaks"));

    if(isDefined(var_3) && isDefined(var_2)) {
      if(isDefined(self.pers["killstreak_stowed_ammo"][var_3 + var_2]))
        return;
    }
  }

  if(var_0 == "basic_training_serum") {
    return;
  }
  maps\mp\_utility::incplayerstat("killStreaksUsed", 1);

  if(!maps\mp\_utility::_id_579B() || var_2 != 0) {
    maps\mp\gametypes\_missions::processchallenge("ch_career_streaksinbound");
    _id_0468::_id_0A28("scorestreakUsed");
  }

  if(var_0 == "carepackage" || var_0 == "emergency_carepackage")
    _id_0468::_id_0A28("packageUsed");

  if(var_1)
    thread maps\mp\gametypes\_missions::_id_A20F(var_0);

  var_4 = self.team;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1))
    var_4 = maps\mp\_utility::getotherteam(var_4);

  var_5 = var_4 + "_friendly_" + var_0 + "_inbound";
  var_6 = var_4 + "_enemy_" + var_0 + "_inbound";

  if(var_0 != "basic_training_serum") {
    if(level.teambased) {
      if(var_0 == "flamethrower" || var_0 == "molotovs" || var_0 == "raid_ss_serum_a" || var_0 == "raid_ss_serum_b" || var_0 == "raid_ss_serum_c" || var_0 == "raid_superweapon" || var_0 == "raid_tesla_moon")
        thread maps\mp\_utility::leaderdialogonplayer(var_5);
      else
        thread maps\mp\_utility::leaderdialog(var_5, var_4);

      if(_id_4540(var_0))
        thread maps\mp\_utility::leaderdialog(var_6, level._id_6C63[self.team]);
    } else {
      thread maps\mp\_utility::leaderdialogonplayer(var_5);

      if(_id_4540(var_0)) {
        var_7[0] = self;
        thread maps\mp\_utility::leaderdialog(var_6, undefined, undefined, var_7);
      }
    }
  }

  var_8 = "used_" + var_0;

  if(_id_4540(var_0))
    thread maps\mp\_utility::teamplayercardsplash(var_8, self);
  else if(level.teambased)
    thread maps\mp\_utility::teamplayercardsplash(var_8, self, self.pers["team"]);
}

_id_A129(var_0, var_1) {
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(!isDefined(var_0)) {
    self.pers["killstreaks"][self._id_5A69]._id_13AF = 0;

    if(self._id_5A69 == 0)
      _id_23DD();
  }

  if(isDefined(var_1))
    self.pers["killstreaks"][var_1] = undefined;

  var_4 = undefined;

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = self.pers["killstreaks"][var_5];

    if(isDefined(var_6) && isDefined(var_6._id_944C) && var_6._id_13AF)
      var_4 = var_5;
  }

  if(isDefined(var_4)) {
    if(level._id_258F || common_scripts\utility::_id_55E0()) {
      self._id_5A69 = var_4;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_4]._id_944C;
      _id_47BA(var_4);
    } else {
      for(var_5 = 0; var_5 < 5; var_5++) {
        var_6 = self.pers["killstreaks"][var_5];

        if(isDefined(var_6) && isDefined(var_6._id_944C) && var_6._id_13AF) {
          var_7 = maps\mp\_utility::_id_454A(var_6._id_944C, var_2, var_3);
          var_8 = self getweaponslistitems();
          var_9 = 0;

          for(var_10 = 0; var_10 < var_8.size; var_10++) {
            if(var_7 == var_8[var_10]) {
              var_9 = 1;
              break;
            }
          }

          if(!var_9)
            maps\mp\_utility::_giveweapon(var_7);
          else if(issubstr(var_7, "airdrop_"))
            self setweaponammoclip(var_7, 1);

          if(!common_scripts\utility::_id_562E(self.pcwaitingforkillstreakweaponchange))
            maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_7);
        }
      }

      self._id_5A69 = undefined;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_4]._id_944C;
      _id_A170();
    }
  } else {
    self._id_5A69 = undefined;
    self.pers["lastEarnedStreak"] = undefined;
    _id_A170();
  }

  if(isDefined(self))
    self setclientomnvar("ks_used", 1);
}

_id_23DD() {
  self.pers["killstreaks"][self.pers["killstreaks"][0]._id_66CC] = undefined;
  var_0 = undefined;
  var_1 = self.pers["killstreaks"];

  for(var_2 = 5; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2]) || !isDefined(var_1[var_2]._id_944C)) {
      continue;
    }
    var_0 = var_1[var_2]._id_944C;
    var_1[0]._id_66CC = var_2;
  }

  if(isDefined(var_0)) {
    var_1[0]._id_13AF = 1;
    var_1[0]._id_944C = var_0;
    var_3 = maps\mp\_utility::_id_453F(var_0);
    var_4 = "ks_icon" + common_scripts\utility::_id_9AAD(0);
    self setclientomnvar(var_4, var_3);

    if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
      var_5 = maps\mp\_utility::_id_454A(var_0, self.team, maps\mp\_utility::_hasperk("specialty_improvedstreaks"));
      maps\mp\_utility::_setactionslot(4, "weapon", var_5);
      return;
    }
  } else {
    var_4 = "ks_icon" + common_scripts\utility::_id_9AAD(0);
    self setclientomnvar(var_4, 0);
  }
}

_id_2400(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = self.pers["killstreaks"];

  if(!isDefined(var_1)) {
    return;
  }
  for(var_2 = var_1.size - 1; var_2 > -1; var_2--)
    self.pers["killstreaks"][var_2] = undefined;

  _id_5333();
  _id_7D50(var_0);
  self._id_5A69 = undefined;
  _id_A170();
}

transferkillstreaks() {
  var_0 = self.pers["killstreaks"];

  if(!isDefined(var_0)) {
    return;
  }
  _id_2400(0);

  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  for(var_1 = self.pers["killstreaks"].size - 1; var_1 > -1; var_1--) {
    if(!isDefined(self.pers["killstreaks"][var_1]._id_944C)) {
      continue;
    }
    for(var_2 = var_0.size - 1; var_2 > -1; var_2--) {
      if(!isDefined(var_0[var_2]._id_944C)) {
        continue;
      }
      if(var_0[var_2]._id_944C == self.pers["killstreaks"][var_1]._id_944C)
        self.pers["killstreaks"][var_1]._id_13AF = var_0[var_2]._id_13AF;
    }
  }
}

_id_580E() {
  return isDefined(self._id_9E1C) && self._id_9E1C && isDefined(self._id_5A69);
}

_id_A6A8() {
  self endon("weapon_switch_invalid");
  self waittill("weapon_switch_started", var_0);
  self notify("killstreak_weapon_change", "switch_started", var_0);
}

_id_A6A7() {
  self endon("weapon_switch_started");
  self waittill("weapon_switch_invalid", var_0);
  self notify("killstreak_weapon_change", "switch_invalid", var_0);
}

_id_A6A6() {
  childthread _id_A6A8();
  childthread _id_A6A7();
  self waittill("killstreak_weapon_change", var_0, var_1);

  if(var_0 == "switch_started")
    return var_1;

  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_4 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][self._id_5A69]._id_944C, var_2, var_3);
  self switchtoweapon(var_4);
  self waittill("weapon_switch_started", var_5);

  if(var_5 != var_4)
    return undefined;

  return var_4;
}

_id_A0DC() {
  foreach(var_1 in level.players)
  var_1 notify("updateKillStreakMarker");
}

_id_0A2F() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("clearAerialKillstreakMarkers");
  var_0 = _id_04D1::_id_44B9(self.team);
  var_1 = 1;

  for(;;) {
    if(!var_1)
      common_scripts\utility::_id_A70A("updateKillStreakMarker");
    else
      var_1 = 0;

    var_2 = [];
    var_2 = _id_4405(var_0);

    if(var_2.size == 0) {
      continue;
    }
    foreach(var_4 in var_2)
    _id_2832(var_4, self);
  }
}

_id_4405(var_0) {
  var_1 = [];
  var_2 = [];

  if(maps\mp\_utility::_id_551F())
    return var_1;

  if(level.teambased)
    var_2 = level._id_9FDA[var_0];
  else
    var_2 = level._id_9FDA;

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_5745) && var_4._id_5745) {
      continue;
    }
    if(isDefined(var_4._id_6C1F) && var_4._id_6C1F) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  foreach(var_7 in level._id_7043) {
    if(!level.teambased || var_7.team == var_0)
      var_1[var_1.size] = var_7;
  }

  if(isDefined(level._id_4405)) {
    var_9 = [[level._id_4405]](var_0);

    foreach(var_11 in var_9)
    var_1[var_1.size] = var_11;
  }

  return var_1;
}

_id_2832(var_0, var_1) {
  if(!isDefined(var_0._id_A98D)) {
    var_0._id_A98D = [];
    var_0._id_A991 = [];
  }

  var_2 = var_1.guid;

  if(isDefined(var_0._id_A98D[var_2])) {
    return;
  }
  var_0._id_A98D[var_2] = _newclienthudelem(self);
  var_0._id_A98D[var_2] setshader("scorestreak_hud_target_hostile", 1, 1, 5);
  var_0._id_A98D[var_2].alpha = 0.9;
  var_0._id_A98D[var_2].x = var_0.origin[0];
  var_0._id_A98D[var_2].y = var_0.origin[1];
  var_0._id_A98D[var_2]._id_01D9 = var_0.origin[2] - 400;
  var_0._id_A98D[var_2] setwaypoint(1, 1, 1);
  var_0._id_A98D[var_2] settargetent(var_0);
  var_0._id_A98D[var_2] setwaypointiconfadeatcenter(0);
  var_0._id_A98D[var_2]._id_0180 = 0;
  var_0._id_A98D[var_2].archived = 0;
  var_0._id_A991[var_2] = _newclienthudelem(self);
  var_0._id_A991[var_2] setshader("hud_exo_temp_warning", 1, 1);
  var_0._id_A991[var_2].alpha = 0.9;
  var_0._id_A991[var_2].color = (1, 1, 1);
  var_0._id_A991[var_2].x = var_0.origin[0];
  var_0._id_A991[var_2].y = var_0.origin[1];
  var_0._id_A991[var_2]._id_01D9 = var_0.origin[2];
  var_0._id_A991[var_2] setwaypoint(0, 1, 0);
  var_0._id_A991[var_2] settargetent(var_0);
  var_0._id_A991[var_2]._id_0180 = 0;
  var_0._id_A991[var_2].archived = 0;
  level thread _id_7CFF(self, var_0, var_0._id_A98D[var_2], var_0._id_A991[var_2]);
}

_id_7CFF(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 common_scripts\utility::_id_A70C(var_0, "death", var_1, "death", var_0, "clearAerialKillstreakMarkers", var_0, "disconnect", var_1, "leaving");
  var_2 destroy();
  var_3 destroy();
}

_id_5A7B() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("killstreakUseWaiter");
  self endon("killstreakUseWaiter");
  self._id_5BB3 = 0;

  if(!isDefined(self.pers["lastEarnedStreak"]))
    self.pers["lastEarnedStreak"] = undefined;

  thread _id_3BA6();

  for(;;) {
    if(!isDefined(self._id_5992))
      self waittill("weapon_change", var_0);
    else {
      var_0 = self._id_5992;
      self._id_5992 = undefined;
    }

    if(isDefined(self._id_8C04)) {
      self setclientomnvar("ui_map_location_selector", 0);
      self._id_8C04 = undefined;
    }

    if(!isalive(self)) {
      continue;
    }
    if(isDefined(self._id_1510)) {
      continue;
    }
    if(!isDefined(self._id_5A69)) {
      if(!level._id_258F) {
        if(isDefined(self._id_5B94) && var_0 == "killstreak_predator_missile_mp")
          self switchtoweapon(self._id_5B94);
      }

      continue;
    }

    if(isDefined(self._id_5FDD) && self._id_5FDD) {
      continue;
    }
    if(isDefined(self._id_56A3) && self._id_56A3) {
      continue;
    }
    if(!isDefined(self.pers["killstreaks"][self._id_5A69]) || !isDefined(self.pers["killstreaks"][self._id_5A69]._id_944C)) {
      continue;
    }
    var_1 = self.team;
    var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
    var_3 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][self._id_5A69]._id_944C, var_1, var_2);

    if(var_0 != var_3) {
      if(issubstr(var_0, "turrethead"))
        self switchtoweapon(self._id_5B94);

      if(maps\mp\_utility::_id_57E5(var_0, "airdrop_") || doeskillstreakweaponstowammo(var_0)) {
        self takeweapon(var_0);
        self switchtoweapon(self._id_5B94);
      }

      continue;
    }

    waittillframeend;
    var_4 = self.pers["killstreaks"][self._id_5A69]._id_944C;
    var_5 = self.pers["killstreaks"][self._id_5A69]._id_5703;
    var_6 = _id_73EB();
    var_7 = self._id_5A69;

    if(_id_8BAC(var_3))
      childthread _id_956E(var_3, var_6);

    var_8 = gettime();
    var_9 = _id_5A7A();
    var_10 = gettime();
    var_11 = (var_10 - var_8) / 1000;

    if(var_9 && var_4 == "fritzx" && issubstr(var_6, "alt+"))
      self notify("cancelSwitchWeaponAfterRaiseAnimation");

    if(!var_9 && !isalive(self) && !self hasweapon(common_scripts\utility::_id_4550())) {
      var_6 = _id_73EB(var_9);
      maps\mp\_utility::_giveweapon(var_6);
    }

    if(var_9)
      thread _id_A701(var_3, var_6, var_4);

    if(_id_8BAD(var_9, var_3, var_4) && !isDefined(self._id_5992) && (!_id_8BAC(var_3) || var_9)) {
      switch (var_3) {
        case "killstreak_predator_missile_mp":
          if(!var_9 && 1.2 - var_11 > 0)
            wait(1.2 - var_11);

          break;
      }

      if(!isDefined(self._id_A019))
        maps\mp\_utility::_id_955C(var_6);
      else
        self._id_A95F = var_6;
    }

    if(self getcurrentweapon() == "none") {
      while(self getcurrentweapon() == "none")
        waitframe();

      waittillframeend;
    }

    if(isDefined(level._id_2067) && var_9)
      [[level._id_2067]](var_4, var_5, var_7);

    if(_id_3150(var_4)) {
      _id_86B8(var_4, var_5, var_7);
      thread _id_63A4();

      if(maps\mp\_utility::_id_579B() && var_4 == "flamethrower") {
        thread _id_7B75(var_3, var_7);
        continue;
      }

      if(maps\mp\_utility::_id_579B() && (var_4 == "raid_superweapon" || var_4 == "raid_tesla_moon"))
        thread reduceteslastowedammoondeath(var_3, var_7);
    }
  }
}

_id_956E(var_0, var_1) {
  self endon("cancelSwitchWeaponAfterRaiseAnimation");

  switch (var_0) {
    case "killstreak_uav_axis_mp":
    case "killstreak_uav_mp":
      if(!getdvarint("4263", 0)) {
        wait 0.833;
        break;
      }
    case "war_super_soldier_syrum_orange_mp":
    case "war_super_soldier_syrum_mp":
    case "war_super_soldier_syrum_green_mp":
    case "war_super_soldier_syrum_purple_mp":
      wait 0.833;
      break;
    default:
      return;
  }

  maps\mp\_utility::_id_955C(var_1);
}

_id_73EB(var_0) {
  if((!isDefined(var_0) || isDefined(var_0) && !var_0) && !isalive(self) && !self hasweapon(common_scripts\utility::_id_4550()))
    return common_scripts\utility::_id_4550();
  else if(!self hasweapon(common_scripts\utility::_id_4550())) {
    var_1 = maps\mp\_utility::_id_44DD();
    return var_1;
  } else
    return common_scripts\utility::_id_4550();
}

_id_A701(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  level endon("game_ended");
  self endon("faux_spawn");
  self notify("waitTakeKillstreakWeapon");
  self endon("waitTakeKillstreakWeapon");
  var_3 = self getcurrentweapon() == "none";
  self waittill("weapon_change", var_4);

  if(var_4 == var_1 || _id_3150(var_2)) {
    _id_95D6(var_0);

    if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
      if(isDefined(self._id_5A69) && self.pers["killstreaks"][self._id_5A69]._id_944C == var_2)
        self._id_5A69 = undefined;
    }
  } else if(var_4 != var_0)
    thread _id_A701(var_0, var_1, var_2);
  else if(var_3 && self getcurrentweapon() == var_0)
    thread _id_A701(var_0, var_1, var_2);
}

_id_95D6(var_0) {
  var_1 = 0;
  var_2 = self.pers["killstreaks"];
  var_3 = self.team;
  var_4 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(isDefined(var_2[var_5]) && isDefined(var_2[var_5]._id_944C) && var_2[var_5]._id_13AF) {
      if(var_0 == maps\mp\_utility::_id_454A(var_2[var_5]._id_944C, var_3, var_4)) {
        var_1 = 1;
        break;
      }
    }
  }

  if(var_1) {
    if(level._id_258F || common_scripts\utility::_id_55E0()) {
      if(isDefined(self._id_5A69) && var_0 != maps\mp\_utility::_id_454A(var_2[self._id_5A69]._id_944C, var_3, var_4))
        self takeweapon(var_0);
      else if(isDefined(self._id_5A69) && var_0 == maps\mp\_utility::_id_454A(var_2[self._id_5A69]._id_944C, var_3, var_4)) {
        self takeweapon(var_0);
        maps\mp\_utility::_giveweapon(var_0);
        maps\mp\_utility::_setactionslot(4, "weapon", var_0);
      }
    } else {
      self takeweapon(var_0);
      maps\mp\_utility::_giveweapon(var_0);
    }
  } else
    self takeweapon(var_0);
}

_id_8BAD(var_0, var_1, var_2) {
  if(!var_0)
    return 1;

  switch (var_2) {
    case "fighter_strike":
      return 0;
  }

  if(_id_8BAC(var_1))
    return 0;

  return 1;
}

_id_8BAC(var_0) {
  switch (var_0) {
    case "m712carry_mp":
    case "killstreak_mortar_mp":
    case "m1917_carry_turret_mp":
    case "teslagun_war_regular_mp":
    case "teslagunmtx_mp":
    case "sword_mp":
    case "killstreak_molotov_cocktail_grenadier_mp":
    case "killstreak_molotov_cocktail_mp":
    case "flamethrower_german_grenadier_mp":
    case "flamethrower_grenadier_mp":
    case "flamethrower_german_mp":
    case "flamethrower_mp":
    case "war_sword_mp":
    case "war_super_soldier_syrum_orange_mp":
    case "war_super_soldier_syrum_mp":
    case "war_super_soldier_syrum_green_mp":
    case "war_super_soldier_syrum_purple_mp":
    case "teslagun_war_moon_mp":
      return 1;
    case "killstreak_uav_axis_mp":
    case "killstreak_uav_mp":
      if(!getdvarint("4263", 0))
        return 1;
    default:
      return 0;
  }
}

_id_3BA6() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  self notify("finishDeathWaiter");
  self endon("finishDeathWaiter");
  self waittill("death");
  waitframe();
  self notify("finish_death");
  self.pers["lastEarnedStreak"] = undefined;
}

_id_21E7() {
  var_0 = self._id_0A06;
  var_1 = self._id_76DA;
  var_2 = self._id_0A0D;
  var_3 = self._id_76DB;

  foreach(var_5 in self.killstreaks) {
    if(var_5 == "basic_training_serum") {
      continue;
    }
    var_6 = _id_46B4(var_5);
    var_7 = var_0;
    var_8 = var_1;

    if(_id_57F0(self, var_5)) {
      var_7 = var_2;
      var_8 = var_3;
    }

    if(var_6 > var_7 && var_7 > var_8) {
      continue;
    }
    if(var_8 < var_6 && (var_7 >= var_6 || var_7 <= var_8))
      _id_353C(var_5, var_6);
  }
}

_id_5A60(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && var_0 != "none")
    var_1 = maps\mp\_utility::_id_452A(var_0);

  if(isDefined(self._id_231B)) {
    var_2 = self._id_231B;

    if(var_2 == -1) {
      var_3 = self.pers["copyCatLoadout"]["className"];
      var_2 = maps\mp\_utility::getclassindex(var_3);

      if(issubstr(var_3, "practice"))
        var_2 = self.pers["copyCatLoadout"]["practiceClassNum"];
    }

    if(issubstr(self.class, "custom")) {
      var_4 = common_scripts\utility::_id_46AF();

      if(!_func_3AC())
        var_4 = common_scripts\utility::_id_46AC();
      else if(_func_3AF())
        var_4 = common_scripts\utility::_id_ACEE();

      if(self getplayerdata(var_4, "assaultStreaks", 0, "streak") == var_1)
        self._id_3C6B = gettime();
      else if(self getplayerdata(var_4, "assaultStreaks", 2, "streak") == var_1 && isDefined(self._id_3C6B)) {
        if(gettime() - self._id_3C6B < 20000)
          thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
      }
    }
  }
}

_id_353C(var_0, var_1) {
  if(isDefined(self.pers["supportStreaksEarned"]) && isDefined(self.pers["supportStreaksEarned"][var_0]) && self.pers["supportStreaksEarned"][var_0]) {
    return;
  }
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  self._id_353B = var_1;
  var_4 = _id_45A5(var_0, 1);
  thread _id_047A::_id_353A(var_0, var_1, var_4);
  thread _id_5A60(var_0);
  self.pers["lastEarnedStreak"] = var_0;

  if(_id_3150(var_0)) {
    if(isDefined(self.pers["killstreak_stowed_ammo"])) {
      var_5 = maps\mp\_utility::_id_454A(var_0, var_2, var_3);
      self.pers["killstreak_stowed_ammo"][var_5 + var_4] = undefined;
      var_6 = self.pers["killstreak_stowed_ammo"]["streakName"];
      var_7 = self.pers["killstreak_stowed_ammo"]["slotNumber"];

      if(isDefined(var_6) && isDefined(var_7) && var_6 == var_0 && var_7 == var_4)
        self notify("cancel_stowed_ammo");
    }
  }

  _id_478D(var_0, 1, 1, self);

  if(maps\mp\_utility::_hasperk("specialty_class_ordnance"))
    maps\mp\gametypes\_missions::processchallenge("ch_field_ordnance");

  if(maps\mp\_utility::_hasperk("specialty_class_blitzkrieg"))
    maps\mp\gametypes\_missions::processchallenge("ch_dlc2_blitzkrieg");
}

_id_45A5(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    if(!isDefined(var_2))
      var_3 = 0;
    else
      var_3 = var_2;
  } else {
    for(var_4 = 1; var_4 < 5; var_4++) {
      var_5 = self.pers["killstreaks"][var_4];

      if(isDefined(var_5) && isDefined(var_5._id_944C) && var_0 == var_5._id_944C) {
        var_3 = var_4;
        break;
      }
    }
  }

  return var_3;
}

_id_478D(var_0, var_1, var_2, var_3, var_4) {
  self endon("givingLoadout");

  if(!isDefined(level._id_5A61[var_0]) || tablelookup("mp/killstreakTable.csv", 1, var_0, 0) == "") {
    return;
  }
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  self endon("disconnect");
  var_5 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    var_6 = self.pers["killstreaks"].size;

    if(isDefined(var_4))
      var_6 = var_4;

    if(!isDefined(self.pers["killstreaks"][var_6]))
      self.pers["killstreaks"][var_6] = spawnStruct();

    var_7 = self.pers["killstreaks"][var_6];
    var_7._id_13AF = 0;
    var_7._id_944C = var_0;
    var_7._id_3539 = 0;
    var_7._id_145C = isDefined(var_2) && var_2;
    var_7._id_0117 = var_3;
    var_7._id_59F1 = self.pers["kID"];
    var_7._id_5CC6 = -1;
    var_7._id_5703 = 1;
    var_5 = _id_45A5(var_0, var_1, var_4);

    if(!isDefined(self.pers["killstreaks"][var_5]))
      self.pers["killstreaks"][var_5] = spawnStruct();

    self.pers["killstreaks"][var_5]._id_66CC = var_6;
    self.pers["killstreaks"][var_5]._id_944C = var_0;
    var_8 = maps\mp\_utility::_id_453F(var_0);
    var_9 = "ks_icon" + common_scripts\utility::_id_9AAD(var_5);
    self setclientomnvar(var_9, var_8);
  } else {
    var_5 = _id_45A5(var_0, var_1, var_4);

    if(var_1 && maps\mp\_utility::_hasperk("specialty_supportstreaks")) {
      if(!isDefined(self.pers["supportStreaksEarned"]))
        self.pers["supportStreaksEarned"] = [];

      self.pers["supportStreaksEarned"][var_0] = 1;
    }

    if(!isDefined(var_5))
      return;
  }

  var_14 = self.team;
  var_15 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_16 = self.pers["killstreaks"][var_5];
  var_16._id_13AF = 1;
  var_16._id_3539 = isDefined(var_1) && var_1;
  var_16._id_145C = isDefined(var_2) && var_2;
  var_16._id_5703 = !isDefined(var_1) || var_1 == 0;
  var_16._id_0117 = var_3;
  var_16._id_59F1 = self.pers["kID"];
  self.pers["kID"]++;

  if(!var_16._id_3539)
    var_16._id_5CC6 = -1;
  else
    var_16._id_5CC6 = self._id_5CC6;

  if(level._id_258F || common_scripts\utility::_id_55E0()) {
    var_17 = maps\mp\_utility::_id_454A(var_0, var_14, var_15);
    _id_478E(var_17, var_5);

    if(isDefined(self._id_5A69)) {
      var_0 = self.pers["killstreaks"][self._id_5A69]._id_944C;
      var_18 = maps\mp\_utility::_id_454A(var_0, var_14, var_15);
      var_19 = self getcurrentweapon();

      if(var_19 != var_18 && !issubstr(var_19, "turrethead"))
        self._id_5A69 = var_5;
    } else
      self._id_5A69 = var_5;
  } else {
    if(0 == var_5 && self.pers["killstreaks"][0]._id_66CC > 5) {
      var_20 = self.pers["killstreaks"][0]._id_66CC - 1;
      var_21 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][var_20]._id_944C, var_14, var_15);
      self takeweapon(var_21);
    }

    var_18 = maps\mp\_utility::_id_454A(var_0, var_14, var_15);
    maps\mp\_utility::_giveweapon(var_18);

    if(self._id_0887[var_5])
      maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_18);

    var_0 = self.pers["killstreaks"][var_5]._id_944C;

    if(_id_3150(var_0))
      _id_A12A(var_0, var_18, var_5);
  }

  _id_A170();

  if(isDefined(level._id_5A75[var_0]))
    self[[level._id_5A75[var_0]]]();

  self setclientomnvar("ks_acquired", 1);
}

_id_3150(var_0) {
  return var_0 == "flamethrower" || var_0 == "molotovs" || var_0 == "raid_superweapon" || var_0 == "raid_tesla_moon";
}

doeskillstreakweaponstowammo(var_0) {
  if(maps\mp\_utility::_id_579B() && issubstr(var_0, "tesla"))
    return 1;

  return var_0 == "flamethrower_mp" || var_0 == "flamethrower_german_mp" || var_0 == "flamethrower_grenadier_mp" || var_0 == "flamethrower_german_grenadier_mp" || var_0 == "killstreak_molotov_cocktail_mp" || var_0 == "killstreak_molotov_cocktail_grenadier_mp";
}

_id_86B8(var_0, var_1, var_2) {
  if(_id_3150(var_0)) {
    self.pers["killstreak_stowed_ammo"]["streakName"] = var_0;
    self.pers["killstreak_stowed_ammo"]["slotNumber"] = var_2;
    self.pers["killstreak_stowed_ammo"]["isGimme"] = var_1;
  }
}

_id_A12A(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(_id_3150(var_0)) {
      if(isDefined(self.pers["killstreak_stowed_ammo"])) {
        var_3 = self.pers["killstreak_stowed_ammo"][var_1 + var_2];

        if(isDefined(var_3)) {
          self setweaponammoclip(var_1, var_3._id_0DB3);
          self setweaponammostock(var_1, var_3._id_0DBB);
        }
      }
    }
  } else {}
}

_id_7B75(var_0, var_1) {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  self endon("cancel_stowed_ammo");
  self notify("reduceFlamethrowerStowedAmmoOnDeath");
  self endon("reduceFlamethrowerStowedAmmoOnDeath");

  for(;;) {
    self waittill("death");
    waittillframeend;

    if(isDefined(self.pers["killstreak_stowed_ammo"])) {
      var_2 = self.pers["killstreak_stowed_ammo"][var_0 + var_1];

      if(isDefined(var_2)) {
        var_3 = int(0.2 * _weaponclipsize(var_0));

        if(var_2._id_0DB3 > var_3)
          var_2._id_0DB3 = int(max(var_3, var_2._id_0DB3 - var_3));
      }
    }
  }
}

reduceteslastowedammoondeath(var_0, var_1) {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  self endon("cancel_stowed_ammo");
  self notify("reduceTeslaStowedAmmoOnDeath");
  self endon("reduceTeslaStowedAmmoOnDeath");

  for(;;) {
    self waittill("death");
    waittillframeend;

    if(isDefined(self.pers["killstreak_stowed_ammo"])) {
      var_2 = self.pers["killstreak_stowed_ammo"][var_0 + var_1];

      if(isDefined(var_2)) {
        var_3 = _weaponclipsize(var_0);
        var_4 = var_2._id_0DBB - var_3;

        if(var_4 < 0)
          var_4 = 0;

        var_2._id_0DBB = int(var_4);
      }
    }
  }
}

_id_2385() {
  self endon("disconnect");
  var_0 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  common_scripts\utility::_id_A70C(level, "game_ended", self, "joined_team", self, "joined_spectators");

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(self.pers) && isDefined(self.pers["killstreaks"]) && isDefined(self.pers["killstreaks"][var_1]) && isDefined(self.pers["killstreaks"][var_1]._id_944C)) {
      var_2 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][var_1]._id_944C, self.team, var_0);

      if(isDefined(self.pers["killstreak_stowed_ammo"][var_2 + var_1])) {
        self.pers["killstreaks"][var_1]._id_13AF = 0;

        if(var_1 == 0)
          _id_23DD();
      }
    }
  }

  self.pers["killstreak_stowed_ammo"] = undefined;
}

_id_63A4() {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  level endon("runBomberObjective");
  var_0 = self.team;
  var_1 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_2 = common_scripts\utility::_id_A716("weapon_change", "death", "cancel_stowed_ammo");

  if(!isDefined(self.pers["killstreak_stowed_ammo"])) {
    return;
  }
  var_3 = self.pers["killstreak_stowed_ammo"]["streakName"];
  var_4 = self.pers["killstreak_stowed_ammo"]["slotNumber"];

  if(var_2 == "cancel_stowed_ammo") {
    self.pers["killstreak_stowed_ammo"]["streakName"] = undefined;
    self.pers["killstreak_stowed_ammo"]["slotNumber"] = undefined;
    self.pers["killstreak_stowed_ammo"]["isGimme"] = undefined;
    return;
  }

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  var_5 = maps\mp\_utility::_id_454A(var_3, var_0, var_1);
  var_6 = self getweaponammoclip(var_5);
  var_7 = self getweaponammostock(var_5);

  if(var_6 + var_7 <= 0) {
    self.pers["killstreak_stowed_ammo"][var_5 + var_4] = undefined;
    self.pers["killstreak_stowed_ammo"]["streakName"] = undefined;
    self.pers["killstreak_stowed_ammo"]["slotNumber"] = undefined;
    self notify("reduceFlamethrowerStowedAmmoOnDeath");
    self notify("reduceTeslaStowedAmmoOnDeath");
    return;
  }

  if(!isDefined(self.pers["killstreak_stowed_ammo"][var_5 + var_4]))
    self.pers["killstreak_stowed_ammo"][var_5 + var_4] = spawnStruct();

  var_8 = self.pers["killstreak_stowed_ammo"][var_5 + var_4];
  var_8._id_0DB3 = var_6;
  var_8._id_0DBB = var_7;
  var_9 = self.pers["killstreak_stowed_ammo"]["isGimme"];
  var_10 = var_4;

  if(var_9)
    var_10 = undefined;

  switch (var_2) {
    case "weapon_change":
      waittillframeend;
      _id_478D(var_3, !var_9, 0, self, var_10);
      _id_A12A(var_3, var_5, var_4);
      return;
    case "death":
      self waittill("spawned_player");
      _id_478D(var_3, !var_9, 0, self, var_10);
      return;
  }
}

_id_478E(var_0, var_1) {
  self endon("disconnect");
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
    return;
  }
  var_4 = self getcurrentweapon();

  while(maps\mp\_utility::_id_56A8()) {
    if(doeskillstreakweaponstowammo(var_0) && (self isonladder() || isDefined(self.hasuseweapon) && self.hasuseweapon || isDefined(self._id_56A1) && self._id_56A1)) {
      break;
    }

    waitframe();
  }

  var_5 = self getweaponslistitems();

  foreach(var_7 in var_5) {
    if(!maps\mp\_utility::_id_57E5(var_7, "killstreak_") && !maps\mp\_utility::_id_57E5(var_7, "airdrop_") && !maps\mp\_utility::_id_57E5(var_7, "deployable_")) {
      continue;
    }
    if(var_7 == "killstreak_molotov_cocktail_mp" || var_7 == "killstreak_molotov_cocktail_grenadier_mp") {
      continue;
    }
    if(self getcurrentweapon() == var_7) {
      continue;
    }
    self takeweapon(var_7);
  }

  if(isDefined(self._id_5A69)) {
    var_9 = self.pers["killstreaks"][self._id_5A69];
    var_10 = var_9._id_944C;
    var_11 = maps\mp\_utility::_id_454A(var_10, var_2, var_3);

    if(self getcurrentweapon() != var_11 || _id_1F6E()) {
      if(self hasweapon(var_0) && self getcurrentweapon() != var_0)
        self takeweapon(var_0);

      if(_id_3150(var_10) && self getcurrentweapon() == var_11 && isDefined(self.lastusedkillstreakindexweapon) && var_1 != self.lastusedkillstreakindexweapon) {
        _id_A170();
        var_12 = common_scripts\utility::waittill_any_return("toggled_up", "toggled_down", "weapon_change");

        if(var_12 != "weapon_change" || self getclientomnvar("ks_selectedIndex") != var_1)
          return;
      }

      maps\mp\_utility::_giveweapon(var_0);
      maps\mp\_utility::_setactionslot(4, "weapon", var_0);

      if(_id_3150(var_10) && self getcurrentweapon() != var_11)
        _id_A12A(var_10, var_11, var_1);
    }
  } else {
    maps\mp\_utility::_giveweapon(var_0);
    maps\mp\_utility::_setactionslot(4, "weapon", var_0);
  }

  if(issubstr(var_0, "flamethrower") && self getcurrentweapon() == var_0)
    self setweaponammostock(var_0, 0);
}

_id_46B4(var_0) {
  if(getdvarint("isMLGMatch", 0) == 1 || _func_3AF())
    var_1 = int(maps\mp\_utility::getkillstreakesportscost(var_0));
  else if(maps\mp\_utility::_hasperk("specialty_killstreaks")) {
    var_1 = int(maps\mp\_utility::getkillstreakkills(var_0));

    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::_hasperk("specialty_hardline"))
        var_1 = int(maps\mp\_utility::getkillstreakhardlinekills(var_0));

      if(maps\mp\_utility::_hasperk("specialty_supportstreaks"))
        var_1 = int(maps\mp\_utility::getkillstreaksupportkills(var_0));
    }
  } else {
    var_1 = int(maps\mp\_utility::_id_4531(var_0));

    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::_hasperk("specialty_hardline"))
        var_1 = int(maps\mp\_utility::_id_453C(var_0));

      if(maps\mp\_utility::_hasperk("specialty_supportstreaks"))
        var_1 = int(maps\mp\_utility::_id_4548(var_0));
    }
  }

  return var_1;
}

_id_453D(var_0) {
  return _tablelookupistring("mp/killstreakTable.csv", 1, var_0, 10);
}

_id_4540(var_0) {
  return int(tablelookup("mp/killstreakTable.csv", 1, var_0, 15));
}

_id_4535(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 12);
}

_id_4533(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 19);
}

_id_47A1(var_0) {
  var_1 = self.pers["killstreaks"];
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(level._id_258F || common_scripts\utility::_id_55E0()) {
    var_4 = -1;
    var_5 = -1;

    for(var_6 = 0; var_6 < 5; var_6++) {
      if(isDefined(var_1[var_6]) && isDefined(var_1[var_6]._id_944C) && var_1[var_6]._id_13AF && _id_46B4(var_1[var_6]._id_944C) > var_5) {
        var_5 = 0;

        if(!var_1[var_6]._id_5703)
          var_5 = _id_46B4(var_1[var_6]._id_944C);

        var_4 = var_6;
      }
    }

    if(var_4 != -1) {
      self._id_5A69 = var_4;
      var_7 = var_1[self._id_5A69]._id_944C;
      var_8 = maps\mp\_utility::_id_454A(var_7, var_2, var_3);
      _id_478E(var_8, self._id_5A69);
    } else
      self._id_5A69 = undefined;
  } else {
    var_4 = -1;
    var_5 = -1;

    for(var_6 = 0; var_6 < 5; var_6++) {
      if(isDefined(var_1[var_6]) && isDefined(var_1[var_6]._id_944C) && var_1[var_6]._id_13AF) {
        var_9 = maps\mp\_utility::_id_454A(var_1[var_6]._id_944C, var_2, var_3);
        var_10 = self getweaponslistitems();
        var_11 = 0;

        for(var_12 = 0; var_12 < var_10.size; var_12++) {
          if(var_9 == var_10[var_12]) {
            var_11 = 1;
            break;
          }
        }

        if(!var_11)
          maps\mp\_utility::_giveweapon(var_9);
        else if(issubstr(var_9, "airdrop_"))
          self setweaponammoclip(var_9, 1);

        maps\mp\_utility::_setactionslot(var_6 + 4, "weapon", var_9);
        var_7 = var_1[var_6]._id_944C;

        if(_id_3150(var_7) && self getcurrentweapon() != var_9)
          _id_A12A(var_7, var_9, var_6);

        if(_id_46B4(var_1[var_6]._id_944C) > var_5) {
          var_5 = 0;

          if(!var_1[var_6]._id_5703)
            var_5 = _id_46B4(var_1[var_6]._id_944C);

          var_4 = var_6;
        }
      }
    }

    if(var_4 != -1)
      var_7 = var_1[var_4]._id_944C;

    self._id_5A69 = undefined;
  }

  _id_A170();
}

_id_748B() {
  if(!isDefined(self._id_7C67)) {
    return;
  }
  self endon("rideKillstreakComplete");
  self waittill("rideKillstreakFailed");
}

_id_748A() {
  if(!isDefined(self._id_7C67)) {
    return;
  }
  self endon("rideKillstreakBlack");
  self waittill("rideKillstreakFailed");
}

_id_5345(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(_id_5347(var_0)) {
    waittillframeend;
    self._id_7C67 = undefined;
    maps\mp\_utility::_id_7441();
    self notify("rideKillstreakFailed");
    return "fail";
  }

  _id_73D0();
  common_scripts\utility::_id_0601();
  maps\mp\_utility::freezecontrolswrapper(1);
  self._id_7C67 = 1;
  var_4 = _id_5346(var_0, var_1, var_2, var_3);

  if(isDefined(self)) {
    maps\mp\_utility::freezecontrolswrapper(0);
    common_scripts\utility::_id_0615();
    self._id_7C67 = undefined;

    if(var_4 == "success")
      self notify("rideKillstreakBlack");
    else {
      maps\mp\_utility::_id_7441();
      self notify("rideKillstreakFailed");
    }
  }

  return var_4;
}

_id_5346(var_0, var_1, var_2, var_3) {
  thread _id_7D69();
  var_4 = "none";
  var_5 = 0.75;

  if(isDefined(var_0) && var_0 == "plane_gunner")
    var_5 = 0.05;

  var_4 = common_scripts\utility::_id_A71A(var_5, "disconnect", "death", "weapon_switch_started");
  maps\mp\gametypes\_hostmigration::_id_A782();

  if(var_4 == "disconnect")
    return "disconnect";

  if(var_4 == "death")
    return "fail";

  if(var_4 == "weapon_switch_started")
    return "fail";

  if(_id_5347(var_0))
    return "fail";

  maps\mp\_utility::_id_7440();
  _id_73D0();

  if(var_1) {
    if(!isDefined(var_2))
      var_2 = 1.0;
  } else {
    if(!isDefined(var_2))
      var_2 = 0.8;

    self setclientomnvar("ui_killstreak_blackout", 1);
    self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(var_2 * 1000));
    thread _id_240D();
    thread _id_240C();
  }

  var_4 = common_scripts\utility::_id_A71A(var_2, "disconnect", "death");

  if(var_4 == "disconnect" || !isDefined(self))
    return "disconnect";

  if(!isDefined(var_3))
    var_3 = 0.6;

  if(var_1)
    self notify("intro_cleared");
  else
    thread _id_240B(var_3);

  if(var_4 == "death")
    return "fail";

  if(_id_5347(var_0))
    return "fail";

  maps\mp\gametypes\_hostmigration::_id_A782();
  return "success";
}

_id_5347(var_0) {
  if(!isDefined(self) || !isalive(self))
    return 1;

  if(!self isonground() && !self islinked()) {
    self iprintlnbold(&"KILLSTREAKS_CANT_ACTIVATE_WHILE_FALLING");
    return 1;
  }

  if(isDefined(self._id_A019) && self._id_A019)
    return 1;

  if(level.gameended)
    return 1;

  if(maps\mp\_utility::_id_56D7())
    return 1;

  if(maps\mp\_utility::_id_5668(0))
    return 1;

  return 0;
}

_id_240B(var_0) {
  self endon("disconnect");
  self endon("joined_team");

  if(isDefined(var_0))
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  var_1 = 0.5;
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(var_1 * 1000));
  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify("rideKillstreakComplete");
}

_id_7D69() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  maps\mp\_utility::freezecontrolswrapper(0);
  self._id_7C67 = undefined;

  if(self._id_2F80)
    common_scripts\utility::_id_0615();

  if(maps\mp\_utility::isusingremote())
    maps\mp\_utility::clearusingremote();
}

_id_240D() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::_id_7441();
  self notify("rideKillstreakComplete");
}

_id_240C() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  level waittill("game_ended");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::_id_7441();
  self notify("rideKillstreakComplete");
}

_id_73D0() {
  if(self isonground()) {
    var_0 = bulletTrace(self.origin + (0, 0, 5), self.origin + (0, 0, -5), 0);

    if(isDefined(var_0["glass"]))
      _destroyglass(var_0["glass"]);
  }
}

_id_47BA(var_0) {
  var_1 = self.team;
  var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_3 = self.pers["killstreaks"][self._id_5A69]._id_944C;
  var_4 = maps\mp\_utility::_id_454A(var_3, var_1, var_2);
  _id_478E(var_4, self._id_5A69);

  if(isDefined(var_0))
    self._id_5A69 = var_0;

  _id_A170();
}

_id_4532() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(self.pers["killstreaks"][var_1]) && isDefined(self.pers["killstreaks"][var_1]._id_944C) && self.pers["killstreaks"][var_1]._id_13AF)
      var_0++;
  }

  return var_0;
}

_id_8C30() {
  if(_id_4532() > 1) {
    for(;;) {
      self._id_5A69++;

      if(self._id_5A69 >= 5)
        self._id_5A69 = 0;

      if(self.pers["killstreaks"][self._id_5A69]._id_13AF == 1) {
        break;
      }
    }

    _id_47BA();
  }
}

_id_8C2F() {
  if(_id_4532() > 1) {
    for(;;) {
      self._id_5A69--;

      if(self._id_5A69 < 0)
        self._id_5A69 = 4;

      if(self.pers["killstreaks"][self._id_5A69]._id_13AF == 1) {
        break;
      }
    }

    _id_47BA();
  }
}

_id_9450() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_up");

    if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
      continue;
    }
    if(_id_1F6D())
      _id_8C30();

    wait 0.12;
  }
}

_id_944F() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_down");

    if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
      continue;
    }
    if(_id_1F6D())
      _id_8C2F();

    wait 0.12;
  }
}

_id_1F6D() {
  return !self ismantling() && !self ismeleeing() && !isDefined(self._id_20CC) && _id_1F6E() && (!isDefined(self._id_56A3) || isDefined(self._id_56A3) && self._id_56A3 == 0);
}

_id_1F6E() {
  var_0 = self getcurrentweapon();

  if(var_0 == "flamethrower_mp" || var_0 == "flamethrower_german_mp" || var_0 == "flamethrower_grenadier_mp" || var_0 == "flamethrower_german_grendier_mp" || var_0 == "killstreak_molotov_cocktail_mp" || var_0 == "killstreak_molotov_cocktail_grenadier_mp" || var_0 == "teslagun_war_moon_mp")
    return 1;

  return !maps\mp\_utility::iskillstreakweapon(var_0);
}

_id_944D() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");

  if(isbot(self)) {
    return;
  }
  maps\mp\_utility::gameflagwait("prematch_done");
  self notifyonplayercommand("toggled_up", "+actionslot 1");
  self notifyonplayercommand("toggled_down", "+actionslot 2");

  if(!level._id_258F) {
    self notifyonplayercommand("streakUsed1", "+actionslot 4");
    self notifyonplayercommand("streakUsed2", "+actionslot 5");
    self notifyonplayercommand("streakUsed3", "+actionslot 6");
    self notifyonplayercommand("streakUsed4", "+actionslot 7");
    self notifyonplayercommand("streakUsed5", "+actionslot 8");
  }
}

_id_4771(var_0) {
  if(!var_0) {
    return;
  }
  var_1 = self._id_0A06 + var_0;
  var_2 = _id_457A(0);

  if(var_1 >= var_2)
    var_1 = var_1 - var_2;

  playloopsound(var_1);
  var_1 = self._id_0A0D + var_0;
  var_2 = _id_457A(1);

  if(var_1 >= var_2)
    var_1 = var_1 - var_2;

  _id_861E(var_1);
  _id_A16E();
  _id_21E7();
}

_id_7F2C(var_0) {
  if(int(var_0) != var_0)
    return int(var_0 + 1);
  else
    return int(var_0);
}

iskillevent(var_0) {
  switch (var_0) {
    case "division_commando_kill":
    case "division_grenadier_kill":
    case "crossfire_cavalry":
    case "assist_cavalry":
    case "kill":
    case "mg_nest_kill":
    case "tac_insert_kill":
    case "division_artillery_kill":
    case "division_scout_kill":
    case "division_resistance_kill":
    case "divisions_cavalry_kill":
    case "divisions_mountain_kill":
    case "divisions_armored_kill":
    case "divisions_airborne_kill":
    case "divisions_infantry_kill":
      return 1;
    case "attack_dogs_kill":
    case "v2_rocket_kill":
    case "airdrop_kill":
    case "paratroopers_kill":
    case "missile_strike_kill":
    case "mortar_strike_kill":
    case "flamethrower_kill":
    case "molotovs_kill":
    case "plane_gunner_kill":
    case "airstrike_kill":
    case "firebomb_kill":
    case "fritzx_kill":
    case "fighter_strike_kill":
      return maps\mp\_utility::areexperimentalbasictrainingsenabled();
  }

  return 0;
}

_id_4770(var_0) {
  var_1 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
  thread _id_0533::_id_6BCF(var_1);

  if(isPlayer(self) && isDefined(self._id_4B5D) && self._id_4B5D)
    var_1 = var_1 * level._id_252C;

  if(maps\mp\_utility::_id_0F5C() && (maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::_hasperk("specialty_supportstreaks")) && var_0 != "raid_flak_kill" && var_0 != "raid_fighters_kill" && var_0 != "raid_flak_assist" && var_0 != "raid_fighters_assist") {
    if(maps\mp\_utility::_hasperk("specialty_killstreaks")) {
      if(iskillevent(var_0))
        _id_4771(1);
    } else
      _id_4771(var_1);
  }

  if(maps\mp\_utility::_hasperk("specialty_improvedstreaks") && (var_0 == "airdrop_kill" || var_0 == "fritzx_kill" || var_0 == "mortar_strike_kill" || var_0 == "missile_strike_kill" || var_0 == "airstrike_kill" || var_0 == "firebomb_kill" || var_0 == "fighter_strike_kill" || var_0 == "plane_gunner_kill" || var_0 == "flamethrower_kill" || var_0 == "attack_dogs_kill" || var_0 == "paratroopers_kill" || var_0 == "molotovs_kill" || var_0 == "v2_rocket_kill"))
    var_1 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");

  _id_300F(var_0, var_1);
}

_id_300F(var_0, var_1) {
  if(!level.hardcoremode)
    thread maps\mp\gametypes\_rank::_id_AAD2(var_0, var_1);
}

_id_7D50(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    self._id_353B = 0;
    playloopsound(0);

    if(var_0) {
      _id_861E(0);
      self.pers["ks_totalPointsSupport"] = 0;
    }

    _id_A16E();
    self.pers["ks_totalPoints"] = 0;
    self.pers["lastEarnedStreak"] = undefined;
  }
}

playloopsound(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    if(var_0 < 0)
      var_0 = 0;

    if(isDefined(self._id_0A06) && self._id_0A06 != 0)
      self._id_76DA = self._id_0A06;
    else
      self._id_76DA = 0;

    self._id_0A06 = var_0;
    self.pers["ks_totalPoints"] = self._id_0A06;
  }
}

_id_861E(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    if(var_0 < 0)
      var_0 = 0;

    if(isDefined(self._id_0A0D) && self._id_0A0D != 0)
      self._id_76DB = self._id_0A0D;
    else
      self._id_76DB = 0;

    self._id_0A0D = var_0;
    self.pers["ks_totalPointsSupport"] = self._id_0A0D;
  }
}

_id_6F33() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = common_scripts\utility::_id_55E0();

  for(;;) {
    if(maps\mp\_utility::_id_572D() || maps\mp\_utility::isusingremote() || maps\mp\_utility::_id_56A8()) {
      while(maps\mp\_utility::_id_572D() || maps\mp\_utility::isusingremote() || maps\mp\_utility::_id_56A8())
        waitframe();

      waitframe();
    }

    if(var_0 != common_scripts\utility::_id_55E0()) {
      thread _id_A129(1);
      var_0 = common_scripts\utility::_id_55E0();
    }

    waitframe();
  }
}

_id_6F34() {
  self._id_0887 = [];
  self._id_0887[0] = 1;
  self._id_0887[1] = 1;
  self._id_0887[2] = 1;
  self._id_0887[3] = 1;
  self._id_0887[4] = 1;
  self.pcwaitingforkillstreakweaponchange = 0;

  if(!isbot(self))
    thread _id_6F33();

  thread pc_watchstreakuseslot("streakUsed1", 0);
  thread pc_watchstreakuseslot("streakUsed2", 1);
  thread pc_watchstreakuseslot("streakUsed3", 2);
  thread pc_watchstreakuseslot("streakUsed4", 3);
  thread pc_watchstreakuseslot("streakUsed5", 4);
}

pc_watchstreakuseslot(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  for(;;) {
    self waittill(var_0);

    if(common_scripts\utility::_id_55E0()) {
      continue;
    }
    if(isDefined(self._id_20CC) && self._id_20CC == "none") {
      continue;
    }
    if(self.pcwaitingforkillstreakweaponchange) {
      continue;
    }
    if(self.pers["killstreaks"][var_1]._id_13AF && self._id_0887[var_1])
      self._id_5A69 = var_1;

    if(isDefined(self._id_5A69) && !self.pers["killstreaks"][self._id_5A69]._id_13AF)
      self._id_5A69 = undefined;

    if(isDefined(self._id_5A69)) {
      var_4 = 0;

      if(!isbot(self))
        _id_2F8C();

      self.pcwaitingforkillstreakweaponchange = 1;

      for(;;) {
        if(maps\mp\_utility::isdogfightgametype()) {
          waitframe();
          break;
        }

        self waittill("weapon_change", var_5);

        if(isDefined(self._id_5A69)) {
          var_6 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][self._id_5A69]._id_944C, var_2, var_3);

          if(var_5 == var_6 && _id_1F6E()) {
            var_4 = 1;
            break;
          }

          if(var_5 == "none" && self isusingturret()) {
            self switchtoweapon(self._id_5B94);
            break;
          }

          if(var_5 == var_6 || var_5 == "none" || (var_6 == "killstreak_uav_axis_mp" || var_6 == "killstreak_uav_mp") && var_5 == "uav_remote_mp" || var_6 == "killstreak_recreation_mp" && var_5 == "uav_remote_mp") {
            continue;
          }
          break;
        }

        break;
      }

      self.pcwaitingforkillstreakweaponchange = 0;

      if(!isbot(self))
        _id_365A();

      if(!var_4)
        self._id_5A69 = undefined;
    }
  }
}

_id_2F8C() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(!isDefined(self._id_5A69)) {
      break;
    }

    if(self._id_5A69 == var_0) {
      continue;
    }
    maps\mp\_utility::_setactionslot(var_0 + 4, "");
    self._id_0887[var_0] = 0;
  }
}

_id_365A() {
  var_0 = self.team;
  var_1 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(!isDefined(self.pers["killstreaks"][var_2])) {
      continue;
    }
    if(self.pers["killstreaks"][var_2]._id_13AF) {
      var_3 = maps\mp\_utility::_id_454A(self.pers["killstreaks"][var_2]._id_944C, var_0, var_1);
      maps\mp\_utility::_setactionslot(var_2 + 4, "weapon", var_3);
    } else
      maps\mp\_utility::_setactionslot(var_2 + 4, "");

    self._id_0887[var_2] = 1;
  }
}

_id_5A67(var_0, var_1, var_2) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2._id_0117) && isDefined(var_2._id_0117.team)) {
    if((level.teambased && var_2._id_0117.team != var_0.team || !level.teambased) && var_0 != var_2._id_0117) {
      if(maps\mp\_utility::iskillstreakweapon(var_1)) {
        return;
      }
      if(!isDefined(var_0._id_5BA9[var_1]))
        var_0._id_5BA9[var_1] = 0;

      if(var_0._id_5BA9[var_1] == gettime()) {
        return;
      }
      var_0._id_5BA9[var_1] = gettime();
      var_0 thread maps\mp\gametypes\_gamelogic::_id_996D(var_1, 1, "hits");
      var_3 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
      var_4 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

      if(var_4 <= var_3) {
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("hits", var_4);
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_3 - var_4));
        var_5 = clamp(_float(var_4) / _float(var_3), 0.0, 1.0) * 10000.0;
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_5));
      }
    }
  }
}