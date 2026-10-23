/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_killstreaks.gsc
********************************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["killstreaks"])) {
      var_0.pers["killstreaks"] = [];
    }

    if(!isDefined(var_0.pers["kID"])) {
      var_0.pers["kID"] = 10;
    }

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
    common_scripts\utility::waittill_any("spawned_player", "faux_spawn");
    thread killstreakusewaiter();
    thread streaknotifytracker();
    thread waitforchangeteam();
    thread streakselectuptracker();
    thread streakselectdowntracker();

    if(!level.console) {
      thread pc_watchstreakuse();
    }

    if(!isDefined(self.pers["killstreaks"][0])) {
      initplayerkillstreaks();
    }

    if(!isDefined(self.pers["killstreak_stowed_ammo"])) {
      self.pers["killstreak_stowed_ammo"] = [];
      thread _id_2385();
    }

    if(!isDefined(self.earnedstreaklevel)) {
      self.earnedstreaklevel = 0;
    }

    if(!isDefined(self._id_0A06) || self._id_0A06 == 0) {
      self._id_0A06 = self.pers["ks_totalPoints"];
      self._id_0A0D = self.pers["ks_totalPointsSupport"];
      updatestreakcount();

      for(var_0 = 0; var_0 < 5; var_0++) {
        if(!isDefined(self.pers["killstreaks"][var_0])) {
          continue;
        }
        var_1 = self.pers["killstreaks"][var_0].streakname;
        var_2 = self.pers["killstreaks"][var_0].available;

        if(isDefined(var_1)) {
          if(var_0 == 0 && (!isDefined(var_2) || !var_2)) {
            continue;
          }
          var_3 = maps\mp\_utility::getkillstreakindex(self.pers["killstreaks"][var_0].streakname);
          var_4 = "ks_icon" + common_scripts\utility::tostring(var_0);
          self setclientomnvar(var_4, var_3);
        }
      }

      updatestreakicons(0);
    }

    updatestreakslots();
    giveownedkillstreakitem();
    updatestreakcount();
  }
}

updatestreakicons(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    if(!var_0 && var_1 == 0) {
      continue;
    }
    var_2 = "ks_icon" + common_scripts\utility::tostring(var_1);
    self setclientomnvar(var_2, 0);
    var_3 = self getclientomnvar("ks_hasStreak");
    var_4 = var_3 &~(1 << var_1) &~(1 << var_1 + 5);
    self setclientomnvar("ks_hasStreak", var_4);
  }

  var_5 = 1;

  if(isDefined(self.killstreaks)) {
    foreach(var_7 in self.killstreaks) {
      var_8 = self.pers["killstreaks"][var_5];
      var_8.streakname = var_7;
      var_9 = var_8.streakname;
      var_2 = "ks_icon" + common_scripts\utility::tostring(var_5);
      self setclientomnvar(var_2, maps\mp\_utility::getkillstreakindex(var_9));
      var_3 = self getclientomnvar("ks_hasStreak");
      var_4 = var_3 &~(1 << var_5);

      if(issupportstreak(self, var_7)) {
        var_4 = var_4 | 1 << var_5 + 5;
      } else {
        var_4 = var_4 &~(1 << var_5 + 5);
      }

      self setclientomnvar("ks_hasStreak", var_4);
      var_5++;
    }
  }
}

initplayerkillstreaks() {
  var_0 = spawnStruct();
  var_0.available = 0;
  var_0.streakname = undefined;
  var_0.earned = 0;
  var_0.awardxp = undefined;
  var_0._id_0117 = undefined;
  var_0.kid = undefined;
  var_0._id_5CC6 = undefined;
  var_0._id_5703 = 1;
  var_0.nextslot = undefined;
  self.pers["killstreaks"][0] = var_0;

  for(var_1 = 1; var_1 < 5; var_1++) {
    var_2 = spawnStruct();
    var_2.available = 0;
    var_2.streakname = undefined;
    var_2.earned = 1;
    var_2.awardxp = 1;
    var_2._id_0117 = undefined;
    var_2.kid = undefined;
    var_2._id_5CC6 = -1;
    var_2._id_5703 = 0;
    self.pers["killstreaks"][var_1] = var_2;
  }

  updatestreakicons(1);
  self setclientomnvar("ks_selectedIndex", -1);
  var_3 = self getclientomnvar("ks_hasStreak");
  var_4 = var_3 &~32;
  self setclientomnvar("ks_hasStreak", var_4);
}

issupportstreak(var_0, var_1) {
  return var_0 maps\mp\_utility::_hasperk("specialty_supportstreaks");
}

updatestreakcount() {
  if(!isDefined(self.pers["killstreaks"])) {
    for(var_0 = 1; var_0 < 5; var_0++) {
      self setclientomnvar("ks_count" + common_scripts\utility::tostring(var_0), 0);
    }

    self setclientomnvar("ks_count_updated", 1);
    return;
  }

  for(var_0 = 1; var_0 < 5; var_0++) {
    if(!isDefined(self.pers["killstreaks"][var_0])) {
      continue;
    }
    var_1 = self.pers["killstreaks"][var_0].streakname;
    var_2 = "ks_count" + common_scripts\utility::tostring(var_0);
    var_3 = "ks_points" + common_scripts\utility::tostring(var_0);

    if(!isDefined(var_1)) {
      self setclientomnvar(var_2, 0);
      continue;
    }

    if(isDefined(self.pers["supportStreaksEarned"]) && isDefined(self.pers["supportStreaksEarned"][var_1]) && self.pers["supportStreaksEarned"][var_1]) {
      self setclientomnvar(var_3, 0);
      self setclientomnvar(var_2, -1);
      continue;
    }

    var_4 = getstreakcost(self.pers["killstreaks"][var_0].streakname);

    if(issupportstreak(self, var_1)) {
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
      if(var_4 == 0) {
        var_5 = self._id_0A06;
      } else {
        var_5 = self._id_0A06 / var_4;
      }

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

getmaxstreakcost(var_0) {
  if(!isDefined(self.killstreaks)) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in self.killstreaks) {
    var_4 = issupportstreak(self, var_3);

    if(var_0 && !var_4 || !var_0 && var_4) {
      continue;
    }
    var_5 = getstreakcost(var_3);

    if(var_5 > var_1) {
      var_1 = var_5;
    }
  }

  return var_1;
}

updatestreakslots() {
  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_0 = self.pers["killstreaks"];
  var_1 = 0;

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(isDefined(var_0[var_2]) && isDefined(var_0[var_2].streakname)) {
      var_3 = self getclientomnvar("ks_hasStreak");

      if(var_0[var_2].available == 1) {
        var_4 = var_3 | 1 << var_2;
      } else {
        var_4 = var_3 &~(1 << var_2);
      }

      self setclientomnvar("ks_hasStreak", var_4);

      if(var_0[var_2].available == 1) {
        var_1++;
      }

      continue;
    }

    var_3 = self getclientomnvar("ks_hasStreak");
    var_4 = var_3 &~(1 << var_2);
    self setclientomnvar("ks_hasStreak", var_4);
  }

  if(var_1 == 0) {
    self setclientomnvar("ks_hasStreak", 0);
  }

  if(isDefined(self.killstreakindexweapon)) {
    self setclientomnvar("ks_selectedIndex", self.killstreakindexweapon);
  } else {
    self setclientomnvar("ks_selectedIndex", -1);
  }
}

waitforchangeteam() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");

  for(;;) {
    self waittill("joined_team");
    clearkillstreaks(1);
  }
}

killstreakusepressed() {
  var_0 = self.pers["killstreaks"];
  var_1 = var_0[self.killstreakindexweapon].streakname;
  var_2 = var_0[self.killstreakindexweapon]._id_5CC6;
  var_3 = var_0[self.killstreakindexweapon].earned;
  var_4 = var_0[self.killstreakindexweapon].awardxp;
  var_5 = var_0[self.killstreakindexweapon].kid;
  var_6 = var_0[self.killstreakindexweapon]._id_5703;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = ["grenade_info_processing", "death", "disconnect", "carepackage_grenade_switch", "CarepackageKillstreakFuncComplete"];
  self.lastusedkillstreakslotindex = self.killstreakindexweapon;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  if(self.killstreakindexweapon == 0) {
    var_11 = var_0[0].nextslot;
  }

  if(!maps\mp\_utility::validateusestreak(var_1)) {
    if(maps\mp\_utility::_id_3153(var_1)) {
      self setclientomnvar("ui_map_location_selector", -1);
      self._id_8C04 = 1;
    }

    return 0;
  }

  var_13 = 0;

  if(maps\mp\_utility::_hasperk("specialty_explosivebullets") && !issubstr(var_1, "explosive_ammo")) {
    var_13 = 1;
  }

  if(level._id_53C7) {
    maps\mp\gametypes\scorestreak_training::_id_244D();
  }

  if(issubstr(var_1, "airdrop")) {
    if(!self[[level.killstreakfuncs[var_1]]](var_2, var_5)) {
      return 0;
    }
  } else if(!self[[level.killstreakfuncs[var_1]]](var_2))
    return 0;

  if(level._id_53C7) {
    self.pers["scorestreaksCalled"]++;
    maps\mp\_utility::setextrascore0(self.pers["scorestreaksCalled"]);
    self.pers["score"] = self.pers["score"] + 1;

    if(self.pers["score"] < 65535) {
      self.score = self.pers["score"];
    }
  }

  if(var_13) {
    maps\mp\_utility::_id_0735("specialty_explosivebullets");
  }

  if(isDefined(var_11) && var_1 != var_0[self.killstreakindexweapon].streakname) {
    var_12 = 1;
    var_10 = var_11;
  }

  var_14 = getstreakcost(var_1);

  if(var_1 == "airstrike" || var_1 == "firebomb" || var_1 == "plane_gunner" || var_1 == "paratroopers" || var_1 == "emergency_carepackage" || var_1 == "flak_gun" || var_1 == "attack_dogs" || var_1 == "advanced_uav" || var_1 == "v2_rocket") {
    var_15 = maps\mp\_utility::getkillstreakindex(var_1);

    if(var_15 != -1) {
      maps\mp\_utility::_id_863E(20, self.team, self getentitynumber(), var_15);
    }
  }

  self.lastusedkillstreakindexweapon = self.killstreakindexweapon;
  thread updatekillstreaks(var_12, var_10);
  _id_A206(var_1, var_4, self.lastusedkillstreakindexweapon);
  self.lastusedkillstreakindexweapon = undefined;
  return 1;
}

_id_A206(var_0, var_1, var_2) {
  if(_id_3150(var_0) && isDefined(self.pers["killstreak_stowed_ammo"])) {
    var_3 = maps\mp\_utility::getkillstreakweapon(var_0, self.team, maps\mp\_utility::_hasperk("specialty_improvedstreaks"));

    if(isDefined(var_3) && isDefined(var_2)) {
      if(isDefined(self.pers["killstreak_stowed_ammo"][var_3 + var_2])) {
        return;
      }
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

  if(var_0 == "carepackage" || var_0 == "emergency_carepackage") {
    _id_0468::_id_0A28("packageUsed");
  }

  if(var_1) {
    thread maps\mp\gametypes\_missions::usehardpoint(var_0);
  }

  var_4 = self.team;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1)) {
    var_4 = maps\mp\_utility::getotherteam(var_4);
  }

  var_5 = var_4 + "_friendly_" + var_0 + "_inbound";
  var_6 = var_4 + "_enemy_" + var_0 + "_inbound";

  if(var_0 != "basic_training_serum") {
    if(level.teambased) {
      if(var_0 == "flamethrower" || var_0 == "molotovs" || var_0 == "raid_ss_serum_a" || var_0 == "raid_ss_serum_b" || var_0 == "raid_ss_serum_c" || var_0 == "raid_superweapon" || var_0 == "raid_tesla_moon") {
        thread maps\mp\_utility::leaderdialogonplayer(var_5);
      } else {
        thread maps\mp\_utility::leaderdialog(var_5, var_4);
      }

      if(getkillstreakinformenemy(var_0)) {
        thread maps\mp\_utility::leaderdialog(var_6, level.otherteam[self.team]);
      }
    } else {
      thread maps\mp\_utility::leaderdialogonplayer(var_5);

      if(getkillstreakinformenemy(var_0)) {
        var_7[0] = self;
        thread maps\mp\_utility::leaderdialog(var_6, undefined, undefined, var_7);
      }
    }
  }

  var_8 = "used_" + var_0;

  if(getkillstreakinformenemy(var_0)) {
    thread maps\mp\_utility::teamplayercardsplash(var_8, self);
  } else if(level.teambased) {
    thread maps\mp\_utility::teamplayercardsplash(var_8, self, self.pers["team"]);
  }
}

updatekillstreaks(var_0, var_1) {
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(!isDefined(var_0)) {
    self.pers["killstreaks"][self.killstreakindexweapon].available = 0;

    if(self.killstreakindexweapon == 0) {
      _id_23DD();
    }
  }

  if(isDefined(var_1)) {
    self.pers["killstreaks"][var_1] = undefined;
  }

  var_4 = undefined;

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = self.pers["killstreaks"][var_5];

    if(isDefined(var_6) && isDefined(var_6.streakname) && var_6.available) {
      var_4 = var_5;
    }
  }

  if(isDefined(var_4)) {
    if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
      self.killstreakindexweapon = var_4;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_4].streakname;
      giveselectedkillstreakitem(var_4);
    } else {
      for(var_5 = 0; var_5 < 5; var_5++) {
        var_6 = self.pers["killstreaks"][var_5];

        if(isDefined(var_6) && isDefined(var_6.streakname) && var_6.available) {
          var_7 = maps\mp\_utility::getkillstreakweapon(var_6.streakname, var_2, var_3);
          var_8 = self getweaponslistitems();
          var_9 = 0;

          for(var_10 = 0; var_10 < var_8.size; var_10++) {
            if(var_7 == var_8[var_10]) {
              var_9 = 1;
              break;
            }
          }

          if(!var_9) {
            maps\mp\_utility::_giveweapon(var_7);
          } else if(issubstr(var_7, "airdrop_")) {
            self setweaponammoclip(var_7, 1);
          }

          if(!common_scripts\utility::_id_562E(self.pcwaitingforkillstreakweaponchange)) {
            maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_7);
          }
        }
      }

      self.killstreakindexweapon = undefined;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_4].streakname;
      updatestreakslots();
    }
  } else {
    self.killstreakindexweapon = undefined;
    self.pers["lastEarnedStreak"] = undefined;
    updatestreakslots();
  }

  if(isDefined(self)) {
    self setclientomnvar("ks_used", 1);
  }
}

_id_23DD() {
  self.pers["killstreaks"][self.pers["killstreaks"][0].nextslot] = undefined;
  var_0 = undefined;
  var_1 = self.pers["killstreaks"];

  for(var_2 = 5; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2]) || !isDefined(var_1[var_2].streakname)) {
      continue;
    }
    var_0 = var_1[var_2].streakname;
    var_1[0].nextslot = var_2;
  }

  if(isDefined(var_0)) {
    var_1[0].available = 1;
    var_1[0].streakname = var_0;
    var_3 = maps\mp\_utility::getkillstreakindex(var_0);
    var_4 = "ks_icon" + common_scripts\utility::tostring(0);
    self setclientomnvar(var_4, var_3);

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
      var_5 = maps\mp\_utility::getkillstreakweapon(var_0, self.team, maps\mp\_utility::_hasperk("specialty_improvedstreaks"));
      maps\mp\_utility::_setactionslot(4, "weapon", var_5);
      return;
    }
  } else {
    var_4 = "ks_icon" + common_scripts\utility::tostring(0);
    self setclientomnvar(var_4, 0);
  }
}

clearkillstreaks(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = self.pers["killstreaks"];

  if(!isDefined(var_1)) {
    return;
  }
  for(var_2 = var_1.size - 1; var_2 > -1; var_2--) {
    self.pers["killstreaks"][var_2] = undefined;
  }

  initplayerkillstreaks();
  resetadrenaline(var_0);
  self.killstreakindexweapon = undefined;
  updatestreakslots();
}

transferkillstreaks() {
  var_0 = self.pers["killstreaks"];

  if(!isDefined(var_0)) {
    return;
  }
  clearkillstreaks(0);

  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  for(var_1 = self.pers["killstreaks"].size - 1; var_1 > -1; var_1--) {
    if(!isDefined(self.pers["killstreaks"][var_1].streakname)) {
      continue;
    }
    for(var_2 = var_0.size - 1; var_2 > -1; var_2--) {
      if(!isDefined(var_0[var_2].streakname)) {
        continue;
      }
      if(var_0[var_2].streakname == self.pers["killstreaks"][var_1].streakname) {
        self.pers["killstreaks"][var_1].available = var_0[var_2].available;
      }
    }
  }
}

istryingtousekillstreakslot() {
  return isDefined(self._id_9E1C) && self._id_9E1C && isDefined(self.killstreakindexweapon);
}

waitforkillstreakweaponswitchstarted() {
  self endon("weapon_switch_invalid");
  self waittill("weapon_switch_started", var_0);
  self notify("killstreak_weapon_change", "switch_started", var_0);
}

waitforkillstreakweaponswitchinvalid() {
  self endon("weapon_switch_started");
  self waittill("weapon_switch_invalid", var_0);
  self notify("killstreak_weapon_change", "switch_invalid", var_0);
}

waitforkillstreakweaponchange() {
  childthread waitforkillstreakweaponswitchstarted();
  childthread waitforkillstreakweaponswitchinvalid();
  self waittill("killstreak_weapon_change", var_0, var_1);

  if(var_0 == "switch_started") {
    return var_1;
  }

  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_4 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, var_2, var_3);
  self switchtoweapon(var_4);
  self waittill("weapon_switch_started", var_5);

  if(var_5 != var_4) {
    return undefined;
  }

  return var_4;
}

_id_A0DC() {
  foreach(var_1 in level.players) {
    var_1 notify("updateKillStreakMarker");
  }
}

_id_0A2F() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("clearAerialKillstreakMarkers");
  var_0 = _id_04D1::getenemyteam(self.team);
  var_1 = 1;

  for(;;) {
    if(!var_1) {
      common_scripts\utility::waittill_any("updateKillStreakMarker");
    } else {
      var_1 = 0;
    }

    var_2 = [];
    var_2 = getaerialkillstreakarray(var_0);

    if(var_2.size == 0) {
      continue;
    }
    foreach(var_4 in var_2) {
      createthreaticon(var_4, self);
    }
  }
}

getaerialkillstreakarray(var_0) {
  var_1 = [];
  var_2 = [];

  if(maps\mp\_utility::invirtuallobby()) {
    return var_1;
  }

  if(level.teambased) {
    var_2 = level.uavmodels[var_0];
  } else {
    var_2 = level.uavmodels;
  }

  foreach(var_4 in var_2) {
    if(isDefined(var_4.isleaving) && var_4.isleaving) {
      continue;
    }
    if(isDefined(var_4.orbit) && var_4.orbit) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  foreach(var_7 in level._id_7043) {
    if(!level.teambased || var_7.team == var_0) {
      var_1[var_1.size] = var_7;
    }
  }

  if(isDefined(level.getaerialkillstreakarray)) {
    var_9 = [[level.getaerialkillstreakarray]](var_0);

    foreach(var_11 in var_9) {
      var_1[var_1.size] = var_11;
    }
  }

  return var_1;
}

createthreaticon(var_0, var_1) {
  if(!isDefined(var_0._id_A98D)) {
    var_0._id_A98D = [];
    var_0.waypoint = [];
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
  var_0._id_A98D[var_2] settargetEnt(var_0);
  var_0._id_A98D[var_2] setwaypointiconfadeatcenter(0);
  var_0._id_A98D[var_2]._id_0180 = 0;
  var_0._id_A98D[var_2].archived = 0;
  var_0.waypoint[var_2] = _newclienthudelem(self);
  var_0.waypoint[var_2] setshader("hud_exo_temp_warning", 1, 1);
  var_0.waypoint[var_2].alpha = 0.9;
  var_0.waypoint[var_2].color = (1, 1, 1);
  var_0.waypoint[var_2].x = var_0.origin[0];
  var_0.waypoint[var_2].y = var_0.origin[1];
  var_0.waypoint[var_2]._id_01D9 = var_0.origin[2];
  var_0.waypoint[var_2] setwaypoint(0, 1, 0);
  var_0.waypoint[var_2] settargetEnt(var_0);
  var_0.waypoint[var_2]._id_0180 = 0;
  var_0.waypoint[var_2].archived = 0;
  level thread removethreaticon(self, var_0, var_0._id_A98D[var_2], var_0.waypoint[var_2]);
}

removethreaticon(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 common_scripts\utility::waittill_any_ents(var_0, "death", var_1, "death", var_0, "clearAerialKillstreakMarkers", var_0, "disconnect", var_1, "leaving");
  var_2 destroy();
  var_3 destroy();
}

killstreakusewaiter() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("killstreakUseWaiter");
  self endon("killstreakUseWaiter");
  self.lastkillstreak = 0;

  if(!isDefined(self.pers["lastEarnedStreak"])) {
    self.pers["lastEarnedStreak"] = undefined;
  }

  thread finishdeathwaiter();

  for(;;) {
    if(!isDefined(self.justswitchedtokillstreakweapon)) {
      self waittill("weapon_change", var_0);
    } else {
      var_0 = self.justswitchedtokillstreakweapon;
      self.justswitchedtokillstreakweapon = undefined;
    }

    if(isDefined(self._id_8C04)) {
      self setclientomnvar("ui_map_location_selector", 0);
      self._id_8C04 = undefined;
    }

    if(!isalive(self)) {
      continue;
    }
    if(isDefined(self.ball_carried)) {
      continue;
    }
    if(!isDefined(self.killstreakindexweapon)) {
      if(!level.console) {
        if(isDefined(self.lastdroppableweapon) && var_0 == "killstreak_predator_missile_mp") {
          self switchtoweapon(self.lastdroppableweapon);
        }
      }

      continue;
    }

    if(isDefined(self.manuallyjoiningkillstreak) && self.manuallyjoiningkillstreak) {
      continue;
    }
    if(isDefined(self.iscarrying) && self.iscarrying) {
      continue;
    }
    if(!isDefined(self.pers["killstreaks"][self.killstreakindexweapon]) || !isDefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname)) {
      continue;
    }
    var_1 = self.team;
    var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
    var_3 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, var_1, var_2);

    if(var_0 != var_3) {
      if(issubstr(var_0, "turrethead")) {
        self switchtoweapon(self.lastdroppableweapon);
      }

      if(maps\mp\_utility::isstrstart(var_0, "airdrop_") || doeskillstreakweaponstowammo(var_0)) {
        self takeweapon(var_0);
        self switchtoweapon(self.lastdroppableweapon);
      }

      continue;
    }

    waittillframeend;
    var_4 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
    var_5 = self.pers["killstreaks"][self.killstreakindexweapon]._id_5703;
    var_6 = playergetkillstreaklastweapon();
    var_7 = self.killstreakindexweapon;

    if(shouldswitchweaponafterraiseanimation(var_3)) {
      childthread switchweaponafterraiseanimation(var_3, var_6);
    }

    var_8 = gettime();
    var_9 = killstreakusepressed();
    var_10 = gettime();
    var_11 = (var_10 - var_8) / 1000;

    if(var_9 && var_4 == "fritzx" && issubstr(var_6, "alt+")) {
      self notify("cancelSwitchWeaponAfterRaiseAnimation");
    }

    if(!var_9 && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon())) {
      var_6 = playergetkillstreaklastweapon(var_9);
      maps\mp\_utility::_giveweapon(var_6);
    }

    if(var_9) {
      thread waittakekillstreakweapon(var_3, var_6, var_4);
    }

    if(shouldswitchweaponpostkillstreak(var_9, var_3, var_4) && !isDefined(self.justswitchedtokillstreakweapon) && (!shouldswitchweaponafterraiseanimation(var_3) || var_9)) {
      switch (var_3) {
        case "killstreak_predator_missile_mp":
          if(!var_9 && 1.2 - var_11 > 0) {
            wait(1.2 - var_11);
          }

          break;
      }

      if(!isDefined(self.underwater)) {
        maps\mp\_utility::switch_to_last_weapon(var_6);
      } else {
        self.water_last_weapon = var_6;
      }
    }

    if(self getcurrentweapon() == "none") {
      while(self getcurrentweapon() == "none") {
        waitframe();
      }

      waittillframeend;
    }

    if(isDefined(level._id_2067) && var_9) {
      [[level._id_2067]](var_4, var_5, var_7);
    }

    if(_id_3150(var_4)) {
      _id_86B8(var_4, var_5, var_7);
      thread _id_63A4();

      if(maps\mp\_utility::_id_579B() && var_4 == "flamethrower") {
        thread _id_7B75(var_3, var_7);
        continue;
      }

      if(maps\mp\_utility::_id_579B() && (var_4 == "raid_superweapon" || var_4 == "raid_tesla_moon")) {
        thread reduceteslastowedammoondeath(var_3, var_7);
      }
    }
  }
}

switchweaponafterraiseanimation(var_0, var_1) {
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

  maps\mp\_utility::switch_to_last_weapon(var_1);
}

playergetkillstreaklastweapon(var_0) {
  if((!isDefined(var_0) || isDefined(var_0) && !var_0) && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon())) {
    return common_scripts\utility::getlastweapon();
  } else if(!self hasweapon(common_scripts\utility::getlastweapon())) {
    var_1 = maps\mp\_utility::_id_44DD();
    return var_1;
  } else
    return common_scripts\utility::getlastweapon();
}

waittakekillstreakweapon(var_0, var_1, var_2) {
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
    takekillstreakweaponifnodupe(var_0);

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
      if(isDefined(self.killstreakindexweapon) && self.pers["killstreaks"][self.killstreakindexweapon].streakname == var_2) {
        self.killstreakindexweapon = undefined;
      }
    }
  } else if(var_4 != var_0)
    thread waittakekillstreakweapon(var_0, var_1, var_2);
  else if(var_3 && self getcurrentweapon() == var_0) {
    thread waittakekillstreakweapon(var_0, var_1, var_2);
  }
}

takekillstreakweaponifnodupe(var_0) {
  var_1 = 0;
  var_2 = self.pers["killstreaks"];
  var_3 = self.team;
  var_4 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(isDefined(var_2[var_5]) && isDefined(var_2[var_5].streakname) && var_2[var_5].available) {
      if(var_0 == maps\mp\_utility::getkillstreakweapon(var_2[var_5].streakname, var_3, var_4)) {
        var_1 = 1;
        break;
      }
    }
  }

  if(var_1) {
    if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
      if(isDefined(self.killstreakindexweapon) && var_0 != maps\mp\_utility::getkillstreakweapon(var_2[self.killstreakindexweapon].streakname, var_3, var_4)) {
        self takeweapon(var_0);
      } else if(isDefined(self.killstreakindexweapon) && var_0 == maps\mp\_utility::getkillstreakweapon(var_2[self.killstreakindexweapon].streakname, var_3, var_4)) {
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

shouldswitchweaponpostkillstreak(var_0, var_1, var_2) {
  if(!var_0) {
    return 1;
  }

  switch (var_2) {
    case "fighter_strike":
      return 0;
  }

  if(shouldswitchweaponafterraiseanimation(var_1)) {
    return 0;
  }

  return 1;
}

shouldswitchweaponafterraiseanimation(var_0) {
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
      if(!getdvarint("4263", 0)) {
        return 1;
      }
    default:
      return 0;
  }
}

finishdeathwaiter() {
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

checkstreakreward() {
  var_0 = self._id_0A06;
  var_1 = self.previousadrenaline;
  var_2 = self._id_0A0D;
  var_3 = self._id_76DB;

  foreach(var_5 in self.killstreaks) {
    if(var_5 == "basic_training_serum") {
      continue;
    }
    var_6 = getstreakcost(var_5);
    var_7 = var_0;
    var_8 = var_1;

    if(issupportstreak(self, var_5)) {
      var_7 = var_2;
      var_8 = var_3;
    }

    if(var_6 > var_7 && var_7 > var_8) {
      continue;
    }
    if(var_8 < var_6 && (var_7 >= var_6 || var_7 <= var_8)) {
      _id_353C(var_5, var_6);
    }
  }
}

killstreakearned(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && var_0 != "none") {
    var_1 = maps\mp\_utility::_id_452A(var_0);
  }

  if(isDefined(self._id_231B)) {
    var_2 = self._id_231B;

    if(var_2 == -1) {
      var_3 = self.pers["copyCatLoadout"]["className"];
      var_2 = maps\mp\_utility::getclassindex(var_3);

      if(issubstr(var_3, "practice")) {
        var_2 = self.pers["copyCatLoadout"]["practiceClassNum"];
      }
    }

    if(issubstr(self.class, "custom")) {
      var_4 = common_scripts\utility::_id_46AF();

      if(!xmodelalias/alias_ger_heads_paris_grey_cap()) {
        var_4 = common_scripts\utility::_id_46AC();
      } else if(xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
        var_4 = common_scripts\utility::_id_ACEE();
      }

      if(self getplayerdata(var_4, "assaultStreaks", 0, "streak") == var_1) {
        self.firstkillstreakearned = gettime();
      } else if(self getplayerdata(var_4, "assaultStreaks", 2, "streak") == var_1 && isDefined(self.firstkillstreakearned)) {
        if(gettime() - self.firstkillstreakearned < 20000) {
          thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
        }
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
  self.earnedstreaklevel = var_1;
  var_4 = getnextkillstreakslotindex(var_0, 1);
  thread _id_047A::earnedkillstreakevent(var_0, var_1, var_4);
  thread killstreakearned(var_0);
  self.pers["lastEarnedStreak"] = var_0;

  if(_id_3150(var_0)) {
    if(isDefined(self.pers["killstreak_stowed_ammo"])) {
      var_5 = maps\mp\_utility::getkillstreakweapon(var_0, var_2, var_3);
      self.pers["killstreak_stowed_ammo"][var_5 + var_4] = undefined;
      var_6 = self.pers["killstreak_stowed_ammo"]["streakName"];
      var_7 = self.pers["killstreak_stowed_ammo"]["slotNumber"];

      if(isDefined(var_6) && isDefined(var_7) && var_6 == var_0 && var_7 == var_4) {
        self notify("cancel_stowed_ammo");
      }
    }
  }

  givekillstreak(var_0, 1, 1, self);

  if(maps\mp\_utility::_hasperk("specialty_class_ordnance")) {
    maps\mp\gametypes\_missions::processchallenge("ch_field_ordnance");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_blitzkrieg")) {
    maps\mp\gametypes\_missions::processchallenge("ch_dlc2_blitzkrieg");
  }
}

getnextkillstreakslotindex(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    if(!isDefined(var_2)) {
      var_3 = 0;
    } else {
      var_3 = var_2;
    }
  } else {
    for(var_4 = 1; var_4 < 5; var_4++) {
      var_5 = self.pers["killstreaks"][var_4];

      if(isDefined(var_5) && isDefined(var_5.streakname) && var_0 == var_5.streakname) {
        var_3 = var_4;
        break;
      }
    }
  }

  return var_3;
}

givekillstreak(var_0, var_1, var_2, var_3, var_4) {
  self endon("givingLoadout");

  if(!isDefined(level.killstreakfuncs[var_0]) || tablelookup("mp/killstreakTable.csv", 1, var_0, 0) == "") {
    return;
  }
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  self endon("disconnect");
  var_5 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    var_6 = self.pers["killstreaks"].size;

    if(isDefined(var_4)) {
      var_6 = var_4;
    }

    if(!isDefined(self.pers["killstreaks"][var_6])) {
      self.pers["killstreaks"][var_6] = spawnStruct();
    }

    var_7 = self.pers["killstreaks"][var_6];
    var_7.available = 0;
    var_7.streakname = var_0;
    var_7.earned = 0;
    var_7.awardxp = isDefined(var_2) && var_2;
    var_7._id_0117 = var_3;
    var_7.kid = self.pers["kID"];
    var_7._id_5CC6 = -1;
    var_7._id_5703 = 1;
    var_5 = getnextkillstreakslotindex(var_0, var_1, var_4);

    if(!isDefined(self.pers["killstreaks"][var_5])) {
      self.pers["killstreaks"][var_5] = spawnStruct();
    }

    self.pers["killstreaks"][var_5].nextslot = var_6;
    self.pers["killstreaks"][var_5].streakname = var_0;
    var_8 = maps\mp\_utility::getkillstreakindex(var_0);
    var_9 = "ks_icon" + common_scripts\utility::tostring(var_5);
    self setclientomnvar(var_9, var_8);
  } else {
    var_5 = getnextkillstreakslotindex(var_0, var_1, var_4);

    if(var_1 && maps\mp\_utility::_hasperk("specialty_supportstreaks")) {
      if(!isDefined(self.pers["supportStreaksEarned"])) {
        self.pers["supportStreaksEarned"] = [];
      }

      self.pers["supportStreaksEarned"][var_0] = 1;
    }

    if(!isDefined(var_5)) {
      return;
    }
  }

  var_14 = self.team;
  var_15 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_16 = self.pers["killstreaks"][var_5];
  var_16.available = 1;
  var_16.earned = isDefined(var_1) && var_1;
  var_16.awardxp = isDefined(var_2) && var_2;
  var_16._id_5703 = !isDefined(var_1) || var_1 == 0;
  var_16._id_0117 = var_3;
  var_16.kid = self.pers["kID"];
  self.pers["kID"]++;

  if(!var_16.earned) {
    var_16._id_5CC6 = -1;
  } else {
    var_16._id_5CC6 = self._id_5CC6;
  }

  if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
    var_17 = maps\mp\_utility::getkillstreakweapon(var_0, var_14, var_15);
    givekillstreakweapon(var_17, var_5);

    if(isDefined(self.killstreakindexweapon)) {
      var_0 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
      var_18 = maps\mp\_utility::getkillstreakweapon(var_0, var_14, var_15);
      var_19 = self getcurrentweapon();

      if(var_19 != var_18 && !issubstr(var_19, "turrethead")) {
        self.killstreakindexweapon = var_5;
      }
    } else
      self.killstreakindexweapon = var_5;
  } else {
    if(0 == var_5 && self.pers["killstreaks"][0].nextslot > 5) {
      var_20 = self.pers["killstreaks"][0].nextslot - 1;
      var_21 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_20].streakname, var_14, var_15);
      self takeweapon(var_21);
    }

    var_18 = maps\mp\_utility::getkillstreakweapon(var_0, var_14, var_15);
    maps\mp\_utility::_giveweapon(var_18);

    if(self._id_0887[var_5]) {
      maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_18);
    }

    var_0 = self.pers["killstreaks"][var_5].streakname;

    if(_id_3150(var_0)) {
      _id_A12A(var_0, var_18, var_5);
    }
  }

  updatestreakslots();

  if(isDefined(level.killstreaksetupfuncs[var_0])) {
    self[[level.killstreaksetupfuncs[var_0]]]();
  }

  self setclientomnvar("ks_acquired", 1);
}

_id_3150(var_0) {
  return var_0 == "flamethrower" || var_0 == "molotovs" || var_0 == "raid_superweapon" || var_0 == "raid_tesla_moon";
}

doeskillstreakweaponstowammo(var_0) {
  if(maps\mp\_utility::_id_579B() && issubstr(var_0, "tesla")) {
    return 1;
  }

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

        if(var_2._id_0DB3 > var_3) {
          var_2._id_0DB3 = int(max(var_3, var_2._id_0DB3 - var_3));
        }
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

        if(var_4 < 0) {
          var_4 = 0;
        }

        var_2._id_0DBB = int(var_4);
      }
    }
  }
}

_id_2385() {
  self endon("disconnect");
  var_0 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  common_scripts\utility::waittill_any_ents(level, "game_ended", self, "joined_team", self, "joined_spectators");

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(self.pers) && isDefined(self.pers["killstreaks"]) && isDefined(self.pers["killstreaks"][var_1]) && isDefined(self.pers["killstreaks"][var_1].streakname)) {
      var_2 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_1].streakname, self.team, var_0);

      if(isDefined(self.pers["killstreak_stowed_ammo"][var_2 + var_1])) {
        self.pers["killstreaks"][var_1].available = 0;

        if(var_1 == 0) {
          _id_23DD();
        }
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
  var_2 = common_scripts\utility::waittill_any_return_no_endon_death("weapon_change", "death", "cancel_stowed_ammo");

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
  var_5 = maps\mp\_utility::getkillstreakweapon(var_3, var_0, var_1);
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

  if(!isDefined(self.pers["killstreak_stowed_ammo"][var_5 + var_4])) {
    self.pers["killstreak_stowed_ammo"][var_5 + var_4] = spawnStruct();
  }

  var_8 = self.pers["killstreak_stowed_ammo"][var_5 + var_4];
  var_8._id_0DB3 = var_6;
  var_8._id_0DBB = var_7;
  var_9 = self.pers["killstreak_stowed_ammo"]["isGimme"];
  var_10 = var_4;

  if(var_9) {
    var_10 = undefined;
  }

  switch (var_2) {
    case "weapon_change":
      waittillframeend;
      givekillstreak(var_3, !var_9, 0, self, var_10);
      _id_A12A(var_3, var_5, var_4);
      return;
    case "death":
      self waittill("spawned_player");
      givekillstreak(var_3, !var_9, 0, self, var_10);
      return;
  }
}

givekillstreakweapon(var_0, var_1) {
  self endon("disconnect");
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
    return;
  }
  var_4 = self getcurrentweapon();

  while(maps\mp\_utility::ischangingweapon()) {
    if(doeskillstreakweaponstowammo(var_0) && (self isonladder() || isDefined(self.hasuseweapon) && self.hasuseweapon || isDefined(self.iscapturingcrate) && self.iscapturingcrate)) {
      break;
    }

    waitframe();
  }

  var_5 = self getweaponslistitems();

  foreach(var_7 in var_5) {
    if(!maps\mp\_utility::isstrstart(var_7, "killstreak_") && !maps\mp\_utility::isstrstart(var_7, "airdrop_") && !maps\mp\_utility::isstrstart(var_7, "deployable_")) {
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

  if(isDefined(self.killstreakindexweapon)) {
    var_9 = self.pers["killstreaks"][self.killstreakindexweapon];
    var_10 = var_9.streakname;
    var_11 = maps\mp\_utility::getkillstreakweapon(var_10, var_2, var_3);

    if(self getcurrentweapon() != var_11 || canshufflewithkillstreakweapon()) {
      if(self hasweapon(var_0) && self getcurrentweapon() != var_0) {
        self takeweapon(var_0);
      }

      if(_id_3150(var_10) && self getcurrentweapon() == var_11 && isDefined(self.lastusedkillstreakindexweapon) && var_1 != self.lastusedkillstreakindexweapon) {
        updatestreakslots();
        var_12 = common_scripts\utility::waittill_any_return("toggled_up", "toggled_down", "weapon_change");

        if(var_12 != "weapon_change" || self getclientomnvar("ks_selectedIndex") != var_1) {
          return;
        }
      }

      maps\mp\_utility::_giveweapon(var_0);
      maps\mp\_utility::_setactionslot(4, "weapon", var_0);

      if(_id_3150(var_10) && self getcurrentweapon() != var_11) {
        _id_A12A(var_10, var_11, var_1);
      }
    }
  } else {
    maps\mp\_utility::_giveweapon(var_0);
    maps\mp\_utility::_setactionslot(4, "weapon", var_0);
  }

  if(issubstr(var_0, "flamethrower") && self getcurrentweapon() == var_0) {
    self setweaponammostock(var_0, 0);
  }
}

getstreakcost(var_0) {
  if(getdvarint("isMLGMatch", 0) == 1 || xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
    var_1 = int(maps\mp\_utility::getkillstreakesportscost(var_0));
  } else if(maps\mp\_utility::_hasperk("specialty_killstreaks")) {
    var_1 = int(maps\mp\_utility::getkillstreakkills(var_0));

    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::_hasperk("specialty_hardline")) {
        var_1 = int(maps\mp\_utility::getkillstreakhardlinekills(var_0));
      }

      if(maps\mp\_utility::_hasperk("specialty_supportstreaks")) {
        var_1 = int(maps\mp\_utility::getkillstreaksupportkills(var_0));
      }
    }
  } else {
    var_1 = int(maps\mp\_utility::_id_4531(var_0));

    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::_hasperk("specialty_hardline")) {
        var_1 = int(maps\mp\_utility::_id_453C(var_0));
      }

      if(maps\mp\_utility::_hasperk("specialty_supportstreaks")) {
        var_1 = int(maps\mp\_utility::_id_4548(var_0));
      }
    }
  }

  return var_1;
}

_id_453D(var_0) {
  return _tablelookupistring("mp/killstreakTable.csv", 1, var_0, 10);
}

getkillstreakinformenemy(var_0) {
  return int(tablelookup("mp/killstreakTable.csv", 1, var_0, 15));
}

_id_4535(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 12);
}

getkillstreakcrateicon(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 19);
}

giveownedkillstreakitem(var_0) {
  var_1 = self.pers["killstreaks"];
  var_2 = self.team;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
    var_4 = -1;
    var_5 = -1;

    for(var_6 = 0; var_6 < 5; var_6++) {
      if(isDefined(var_1[var_6]) && isDefined(var_1[var_6].streakname) && var_1[var_6].available && getstreakcost(var_1[var_6].streakname) > var_5) {
        var_5 = 0;

        if(!var_1[var_6]._id_5703) {
          var_5 = getstreakcost(var_1[var_6].streakname);
        }

        var_4 = var_6;
      }
    }

    if(var_4 != -1) {
      self.killstreakindexweapon = var_4;
      var_7 = var_1[self.killstreakindexweapon].streakname;
      var_8 = maps\mp\_utility::getkillstreakweapon(var_7, var_2, var_3);
      givekillstreakweapon(var_8, self.killstreakindexweapon);
    } else
      self.killstreakindexweapon = undefined;
  } else {
    var_4 = -1;
    var_5 = -1;

    for(var_6 = 0; var_6 < 5; var_6++) {
      if(isDefined(var_1[var_6]) && isDefined(var_1[var_6].streakname) && var_1[var_6].available) {
        var_9 = maps\mp\_utility::getkillstreakweapon(var_1[var_6].streakname, var_2, var_3);
        var_10 = self getweaponslistitems();
        var_11 = 0;

        for(var_12 = 0; var_12 < var_10.size; var_12++) {
          if(var_9 == var_10[var_12]) {
            var_11 = 1;
            break;
          }
        }

        if(!var_11) {
          maps\mp\_utility::_giveweapon(var_9);
        } else if(issubstr(var_9, "airdrop_")) {
          self setweaponammoclip(var_9, 1);
        }

        maps\mp\_utility::_setactionslot(var_6 + 4, "weapon", var_9);
        var_7 = var_1[var_6].streakname;

        if(_id_3150(var_7) && self getcurrentweapon() != var_9) {
          _id_A12A(var_7, var_9, var_6);
        }

        if(getstreakcost(var_1[var_6].streakname) > var_5) {
          var_5 = 0;

          if(!var_1[var_6]._id_5703) {
            var_5 = getstreakcost(var_1[var_6].streakname);
          }

          var_4 = var_6;
        }
      }
    }

    if(var_4 != -1) {
      var_7 = var_1[var_4].streakname;
    }

    self.killstreakindexweapon = undefined;
  }

  updatestreakslots();
}

playerwaittillridekillstreakcomplete() {
  if(!isDefined(self.remoteridetransition)) {
    return;
  }
  self endon("rideKillstreakComplete");
  self waittill("rideKillstreakFailed");
}

playerwaittillridekillstreakblack() {
  if(!isDefined(self.remoteridetransition)) {
    return;
  }
  self endon("rideKillstreakBlack");
  self waittill("rideKillstreakFailed");
}

initridekillstreak(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(_id_5347(var_0)) {
    waittillframeend;
    self.remoteridetransition = undefined;
    maps\mp\_utility::playerremotekillstreakshowhud();
    self notify("rideKillstreakFailed");
    return "fail";
  }

  playerdestroyglassbelow();
  common_scripts\utility::_id_0601();
  maps\mp\_utility::freezecontrolswrapper(1);
  self.remoteridetransition = 1;
  var_4 = initridekillstreak_internal(var_0, var_1, var_2, var_3);

  if(isDefined(self)) {
    maps\mp\_utility::freezecontrolswrapper(0);
    common_scripts\utility::_id_0615();
    self.remoteridetransition = undefined;

    if(var_4 == "success") {
      self notify("rideKillstreakBlack");
    } else {
      maps\mp\_utility::playerremotekillstreakshowhud();
      self notify("rideKillstreakFailed");
    }
  }

  return var_4;
}

initridekillstreak_internal(var_0, var_1, var_2, var_3) {
  thread resetplayeronteamchange();
  var_4 = "none";
  var_5 = 0.75;

  if(isDefined(var_0) && var_0 == "plane_gunner") {
    var_5 = 0.05;
  }

  var_4 = common_scripts\utility::waittill_any_timeout(var_5, "disconnect", "death", "weapon_switch_started");
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_4 == "disconnect") {
    return "disconnect";
  }

  if(var_4 == "death") {
    return "fail";
  }

  if(var_4 == "weapon_switch_started") {
    return "fail";
  }

  if(_id_5347(var_0)) {
    return "fail";
  }

  maps\mp\_utility::playerremotekillstreakhidehud();
  playerdestroyglassbelow();

  if(var_1) {
    if(!isDefined(var_2)) {
      var_2 = 1.0;
    }
  } else {
    if(!isDefined(var_2)) {
      var_2 = 0.8;
    }

    self setclientomnvar("ui_killstreak_blackout", 1);
    self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(var_2 * 1000));
    thread clearrideintroonteamchange();
    thread clearrideintroonroundtransition();
  }

  var_4 = common_scripts\utility::waittill_any_timeout(var_2, "disconnect", "death");

  if(var_4 == "disconnect" || !isDefined(self)) {
    return "disconnect";
  }

  if(!isDefined(var_3)) {
    var_3 = 0.6;
  }

  if(var_1) {
    self notify("intro_cleared");
  } else {
    thread clearrideintro(var_3);
  }

  if(var_4 == "death") {
    return "fail";
  }

  if(_id_5347(var_0)) {
    return "fail";
  }

  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  return "success";
}

_id_5347(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return 1;
  }

  if(!self isonground() && !self islinked()) {
    self iprintlnbold(&"KILLSTREAKS_CANT_ACTIVATE_WHILE_FALLING");
    return 1;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return 1;
  }

  if(level.gameended) {
    return 1;
  }

  if(maps\mp\_utility::_id_56D7()) {
    return 1;
  }

  if(maps\mp\_utility::_id_5668(0)) {
    return 1;
  }

  return 0;
}

clearrideintro(var_0) {
  self endon("disconnect");
  self endon("joined_team");

  if(isDefined(var_0)) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }

  var_1 = 0.5;
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(var_1 * 1000));
  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify("rideKillstreakComplete");
}

resetplayeronteamchange() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  maps\mp\_utility::freezecontrolswrapper(0);
  self.remoteridetransition = undefined;

  if(self.disabledusability) {
    common_scripts\utility::_id_0615();
  }

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  }
}

clearrideintroonteamchange() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::playerremotekillstreakshowhud();
  self notify("rideKillstreakComplete");
}

clearrideintroonroundtransition() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  level waittill("game_ended");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::playerremotekillstreakshowhud();
  self notify("rideKillstreakComplete");
}

playerdestroyglassbelow() {
  if(self isonground()) {
    var_0 = bulletTrace(self.origin + (0, 0, 5), self.origin + (0, 0, -5), 0);

    if(isDefined(var_0["glass"])) {
      _destroyglass(var_0["glass"]);
    }
  }
}

giveselectedkillstreakitem(var_0) {
  var_1 = self.team;
  var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_3 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
  var_4 = maps\mp\_utility::getkillstreakweapon(var_3, var_1, var_2);
  givekillstreakweapon(var_4, self.killstreakindexweapon);

  if(isDefined(var_0)) {
    self.killstreakindexweapon = var_0;
  }

  updatestreakslots();
}

getkillstreakcount() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(self.pers["killstreaks"][var_1]) && isDefined(self.pers["killstreaks"][var_1].streakname) && self.pers["killstreaks"][var_1].available) {
      var_0++;
    }
  }

  return var_0;
}

shufflekillstreaksup() {
  if(getkillstreakcount() > 1) {
    for(;;) {
      self.killstreakindexweapon++;

      if(self.killstreakindexweapon >= 5) {
        self.killstreakindexweapon = 0;
      }

      if(self.pers["killstreaks"][self.killstreakindexweapon].available == 1) {
        break;
      }
    }

    giveselectedkillstreakitem();
  }
}

shufflekillstreaksdown() {
  if(getkillstreakcount() > 1) {
    for(;;) {
      self.killstreakindexweapon--;

      if(self.killstreakindexweapon < 0) {
        self.killstreakindexweapon = 4;
      }

      if(self.pers["killstreaks"][self.killstreakindexweapon].available == 1) {
        break;
      }
    }

    giveselectedkillstreakitem();
  }
}

streakselectuptracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_up");

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(canshufflekillstreaks()) {
      shufflekillstreaksup();
    }

    wait 0.12;
  }
}

streakselectdowntracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_down");

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(canshufflekillstreaks()) {
      shufflekillstreaksdown();
    }

    wait 0.12;
  }
}

canshufflekillstreaks() {
  return !self ismantling() && !self ismeleeing() && !isDefined(self.changingweapon) && canshufflewithkillstreakweapon() && (!isDefined(self.iscarrying) || isDefined(self.iscarrying) && self.iscarrying == 0);
}

canshufflewithkillstreakweapon() {
  var_0 = self getcurrentweapon();

  if(var_0 == "flamethrower_mp" || var_0 == "flamethrower_german_mp" || var_0 == "flamethrower_grenadier_mp" || var_0 == "flamethrower_german_grendier_mp" || var_0 == "killstreak_molotov_cocktail_mp" || var_0 == "killstreak_molotov_cocktail_grenadier_mp" || var_0 == "teslagun_war_moon_mp") {
    return 1;
  }

  return !maps\mp\_utility::iskillstreakweapon(var_0);
}

streaknotifytracker() {
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

  if(!level.console) {
    self notifyonplayercommand("streakUsed1", "+actionslot 4");
    self notifyonplayercommand("streakUsed2", "+actionslot 5");
    self notifyonplayercommand("streakUsed3", "+actionslot 6");
    self notifyonplayercommand("streakUsed4", "+actionslot 7");
    self notifyonplayercommand("streakUsed5", "+actionslot 8");
  }
}

giveadrenalinedirect(var_0) {
  if(!var_0) {
    return;
  }
  var_1 = self._id_0A06 + var_0;
  var_2 = getmaxstreakcost(0);

  if(var_1 >= var_2) {
    var_1 = var_1 - var_2;
  }

  playLoopSound(var_1);
  var_1 = self._id_0A0D + var_0;
  var_2 = getmaxstreakcost(1);

  if(var_1 >= var_2) {
    var_1 = var_1 - var_2;
  }

  setadrenalinesupport(var_1);
  updatestreakcount();
  checkstreakreward();
}

roundup(var_0) {
  if(int(var_0) != var_0) {
    return int(var_0 + 1);
  } else {
    return int(var_0);
  }
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

  if(isPlayer(self) && isDefined(self._id_4B5D) && self._id_4B5D) {
    var_1 = var_1 * level._id_252C;
  }

  if(maps\mp\_utility::_id_0F5C() && (maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::_hasperk("specialty_supportstreaks")) && var_0 != "raid_flak_kill" && var_0 != "raid_fighters_kill" && var_0 != "raid_flak_assist" && var_0 != "raid_fighters_assist") {
    if(maps\mp\_utility::_hasperk("specialty_killstreaks")) {
      if(iskillevent(var_0)) {
        giveadrenalinedirect(1);
      }
    } else
      giveadrenalinedirect(var_1);
  }

  if(maps\mp\_utility::_hasperk("specialty_improvedstreaks") && (var_0 == "airdrop_kill" || var_0 == "fritzx_kill" || var_0 == "mortar_strike_kill" || var_0 == "missile_strike_kill" || var_0 == "airstrike_kill" || var_0 == "firebomb_kill" || var_0 == "fighter_strike_kill" || var_0 == "plane_gunner_kill" || var_0 == "flamethrower_kill" || var_0 == "attack_dogs_kill" || var_0 == "paratroopers_kill" || var_0 == "molotovs_kill" || var_0 == "v2_rocket_kill")) {
    var_1 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
  }

  displaykillstreakpoints(var_0, var_1);
}

displaykillstreakpoints(var_0, var_1) {
  if(!level.hardcoremode) {
    thread maps\mp\gametypes\_rank::xppointspopup(var_0, var_1);
  }
}

resetadrenaline(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    self.earnedstreaklevel = 0;
    playLoopSound(0);

    if(var_0) {
      setadrenalinesupport(0);
      self.pers["ks_totalPointsSupport"] = 0;
    }

    updatestreakcount();
    self.pers["ks_totalPoints"] = 0;
    self.pers["lastEarnedStreak"] = undefined;
  }
}

playLoopSound(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    if(var_0 < 0) {
      var_0 = 0;
    }

    if(isDefined(self._id_0A06) && self._id_0A06 != 0) {
      self.previousadrenaline = self._id_0A06;
    } else {
      self.previousadrenaline = 0;
    }

    self._id_0A06 = var_0;
    self.pers["ks_totalPoints"] = self._id_0A06;
  }
}

setadrenalinesupport(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    if(var_0 < 0) {
      var_0 = 0;
    }

    if(isDefined(self._id_0A0D) && self._id_0A0D != 0) {
      self._id_76DB = self._id_0A0D;
    } else {
      self._id_76DB = 0;
    }

    self._id_0A0D = var_0;
    self.pers["ks_totalPointsSupport"] = self._id_0A0D;
  }
}

pc_watchcontrolschanged() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = common_scripts\utility::is_player_gamepad_enabled();

  for(;;) {
    if(maps\mp\_utility::isinremotetransition() || maps\mp\_utility::isusingremote() || maps\mp\_utility::ischangingweapon()) {
      while(maps\mp\_utility::isinremotetransition() || maps\mp\_utility::isusingremote() || maps\mp\_utility::ischangingweapon()) {
        waitframe();
      }

      waitframe();
    }

    if(var_0 != common_scripts\utility::is_player_gamepad_enabled()) {
      thread updatekillstreaks(1);
      var_0 = common_scripts\utility::is_player_gamepad_enabled();
    }

    waitframe();
  }
}

pc_watchstreakuse() {
  self._id_0887 = [];
  self._id_0887[0] = 1;
  self._id_0887[1] = 1;
  self._id_0887[2] = 1;
  self._id_0887[3] = 1;
  self._id_0887[4] = 1;
  self.pcwaitingforkillstreakweaponchange = 0;

  if(!isbot(self)) {
    thread pc_watchcontrolschanged();
  }

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

    if(common_scripts\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(isDefined(self.changingweapon) && self.changingweapon == "none") {
      continue;
    }
    if(self.pcwaitingforkillstreakweaponchange) {
      continue;
    }
    if(self.pers["killstreaks"][var_1].available && self._id_0887[var_1]) {
      self.killstreakindexweapon = var_1;
    }

    if(isDefined(self.killstreakindexweapon) && !self.pers["killstreaks"][self.killstreakindexweapon].available) {
      self.killstreakindexweapon = undefined;
    }

    if(isDefined(self.killstreakindexweapon)) {
      var_4 = 0;

      if(!isbot(self)) {
        disablekillstreakactionslots();
      }

      self.pcwaitingforkillstreakweaponchange = 1;

      for(;;) {
        if(maps\mp\_utility::isdogfightgametype()) {
          waitframe();
          break;
        }

        self waittill("weapon_change", var_5);

        if(isDefined(self.killstreakindexweapon)) {
          var_6 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, var_2, var_3);

          if(var_5 == var_6 && canshufflewithkillstreakweapon()) {
            var_4 = 1;
            break;
          }

          if(var_5 == "none" && self isusingturret()) {
            self switchtoweapon(self.lastdroppableweapon);
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

      if(!isbot(self)) {
        enablekillstreakactionslots();
      }

      if(!var_4) {
        self.killstreakindexweapon = undefined;
      }
    }
  }
}

disablekillstreakactionslots() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(!isDefined(self.killstreakindexweapon)) {
      break;
    }

    if(self.killstreakindexweapon == var_0) {
      continue;
    }
    maps\mp\_utility::_setactionslot(var_0 + 4, "");
    self._id_0887[var_0] = 0;
  }
}

enablekillstreakactionslots() {
  var_0 = self.team;
  var_1 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(!isDefined(self.pers["killstreaks"][var_2])) {
      continue;
    }
    if(self.pers["killstreaks"][var_2].available) {
      var_3 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_2].streakname, var_0, var_1);
      maps\mp\_utility::_setactionslot(var_2 + 4, "weapon", var_3);
    } else
      maps\mp\_utility::_setactionslot(var_2 + 4, "");

    self._id_0887[var_2] = 1;
  }
}

killstreakhit(var_0, var_1, var_2) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2._id_0117) && isDefined(var_2._id_0117.team)) {
    if((level.teambased && var_2._id_0117.team != var_0.team || !level.teambased) && var_0 != var_2._id_0117) {
      if(maps\mp\_utility::iskillstreakweapon(var_1)) {
        return;
      }
      if(!isDefined(var_0.lasthittime[var_1])) {
        var_0.lasthittime[var_1] = 0;
      }

      if(var_0.lasthittime[var_1] == gettime()) {
        return;
      }
      var_0.lasthittime[var_1] = gettime();
      var_0 thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname(var_1, 1, "hits");
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