/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42947.gsc
**************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["killstreaks"])) {
      var_0.pers["killstreaks"] = [];
    }

    if(!isDefined(var_0.pers["kID"])) {
      var_0.pers["kID"] = 10;
    }

    var_0.lifeid = 0;
    var_0.curdefvalue = 0;

    if(isDefined(var_0.pers["deaths"])) {
      var_0.lifeid = var_0.pers["deaths"];
    }

    var_0.spupdatetotal = 0;

    if(getdvarint("virtualLobbyActive", 0)) {
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

    if(!isDefined(self.earnedstreaklevel)) {
      self.earnedstreaklevel = 0;
    }

    if(!isDefined(self.adrenaline) || self.adrenaline == 0) {
      self.adrenaline = self.pers["ks_totalPoints"];
      self.adrenalinesupport = self.pers["ks_totalPointsSupport"];
      updatestreakcount();

      for(var_0 = 0; var_0 < level.killstreak_stacking_start_slot; var_0++) {
        var_1 = self.pers["killstreaks"][var_0].streakname;
        var_2 = self.pers["killstreaks"][var_0].available;

        if(isDefined(var_1)) {
          if(var_0 == level.killstreak_gimme_slot && (!isDefined(var_2) || !var_2)) {
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
  for(var_1 = 0; var_1 < level.killstreak_stacking_start_slot; var_1++) {
    if(!var_0 && var_1 == level.killstreak_gimme_slot) {
      continue;
    }
    var_2 = "ks_icon" + common_scripts\utility::tostring(var_1);
    self setclientomnvar(var_2, 0);
    var_3 = self getclientomnvar("ks_hasStreak");
    var_4 = var_3 &~(1 << var_1) &~(1 << var_1 + level.killstreak_stacking_start_slot);
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
        var_4 = var_4 | 1 << var_5 + level.killstreak_stacking_start_slot;
      } else {
        var_4 = var_4 &~(1 << var_5 + level.killstreak_stacking_start_slot);
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
  var_0.owner = undefined;
  var_0.kid = undefined;
  var_0.lifeid = undefined;
  var_0.isgimme = 1;
  var_0.nextslot = undefined;
  self.pers["killstreaks"][level.killstreak_gimme_slot] = var_0;

  for(var_1 = level.killstreak_slot_1; var_1 < level.killstreak_stacking_start_slot; var_1++) {
    var_2 = spawnStruct();
    var_2.available = 0;
    var_2.streakname = undefined;
    var_2.earned = 1;
    var_2.awardxp = 1;
    var_2.owner = undefined;
    var_2.kid = undefined;
    var_2.lifeid = -1;
    var_2.isgimme = 0;
    self.pers["killstreaks"][var_1] = var_2;
  }

  updatestreakicons(1);
  self setclientomnvar("ks_selectedIndex", -1);
  var_3 = self getclientomnvar("ks_hasStreak");
  var_4 = var_3 &~(1 << level.killstreak_stacking_start_slot);
  self setclientomnvar("ks_hasStreak", var_4);
}

issupportstreak(var_0, var_1) {
  var_2 = getarraykeys(self.killstreakmodules);

  foreach(var_4 in var_2) {
    var_5 = getstreakmodulebasekillstreak(var_4);

    if(var_5 == var_1) {
      var_6 = tablelookup(level.ks_modules_table, level.ks_module_ref_column, var_4, level.ks_module_support_column);

      if(isDefined(var_6) && var_6 != "" && var_6 != "0") {
        return 1;
      }
    }
  }

  return 0;
}

updatestreakcount() {
  if(!isDefined(self.pers["killstreaks"])) {
    for(var_0 = level.killstreak_slot_1; var_0 < level.killstreak_stacking_start_slot; var_0++) {
      self setclientomnvar("ks_count" + common_scripts\utility::tostring(var_0), 0);
    }

    self setclientomnvar("ks_count_updated", 1);
    return;
  }

  for(var_0 = level.killstreak_slot_1; var_0 < level.killstreak_stacking_start_slot; var_0++) {
    var_1 = self.pers["killstreaks"][var_0].streakname;
    var_2 = "ks_count" + common_scripts\utility::tostring(var_0);
    var_3 = "ks_points" + common_scripts\utility::tostring(var_0);

    if(!isDefined(var_1)) {
      self setclientomnvar(var_2, 0);
      continue;
    }

    var_4 = getstreakcost(self.pers["killstreaks"][var_0].streakname);

    if(issupportstreak(self, var_1)) {
      var_5 = self.adrenalinesupport / var_4;
      var_6 = var_4 - self.adrenalinesupport;
    } else {
      var_5 = self.adrenaline / var_4;
      var_6 = var_4 - self.adrenaline;
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

  for(var_2 = 0; var_2 < level.killstreak_stacking_start_slot; var_2++) {
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
    }
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
  var_2 = var_0[self.killstreakindexweapon].lifeid;
  var_3 = var_0[self.killstreakindexweapon].earned;
  var_4 = var_0[self.killstreakindexweapon].awardxp;
  var_5 = var_0[self.killstreakindexweapon].kid;
  var_6 = var_0[self.killstreakindexweapon].isgimme;
  var_7 = var_0[self.killstreakindexweapon].modules;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(self.killstreakindexweapon == level.killstreak_gimme_slot) {
    var_9 = var_0[level.killstreak_gimme_slot].nextslot;
  }

  if(!maps\mp\_utility::validateusestreak(var_1)) {
    return 0;
  }

  var_11 = 0;

  if(maps\mp\_utility::_hasperk("specialty_explosivebullets") && !issubstr(var_1, "explosive_ammo")) {
    var_11 = 1;
  }

  if(issubstr(var_1, "airdrop")) {
    if(!self[[level.killstreakfuncs[var_1]]](var_2, var_5, var_7)) {
      return 0;
    }
  } else if(!self[[level.killstreakfuncs[var_1]]](var_2, var_7)) {
    return 0;
  }

  if(var_11) {
    maps\mp\_utility::_unsetperk("specialty_explosivebullets");
  }

  if(isDefined(var_9) && var_1 != var_0[self.killstreakindexweapon].streakname) {
    var_10 = 1;
    var_8 = var_9;
  }

  thread updatekillstreaks(var_10, var_8);
  usedkillstreak(var_1, var_7, var_4);
  return 1;
}

usedkillstreak(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("killStreaksUsed", 1);

  if(var_2) {
    thread maps\mp\gametypes\_missions::usehardpoint(var_0);
  }

  var_3 = self.team;
  var_4 = var_3 + "_friendly_" + var_0 + "_inbound";
  var_5 = var_3 + "_enemy_" + var_0 + "_inbound";

  if(var_0 == "emp") {
    var_6 = maps\mp\killstreaks\_emp::getmodulelineemp(var_1);
    var_4 = var_4 + var_6;
    var_5 = var_5 + var_6;
  }

  if(level.teambased) {
    thread maps\mp\_utility::leaderdialog(var_4, var_3);

    if(getkillstreakinformenemy(var_0)) {
      thread maps\mp\_utility::leaderdialog(var_5, level.otherteam[var_3]);
    }
  } else {
    thread maps\mp\_utility::leaderdialogonplayer(var_4);

    if(getkillstreakinformenemy(var_0)) {
      var_7[0] = self;
      thread maps\mp\_utility::leaderdialog(var_5, undefined, undefined, var_7);
    }
  }

  if(isDefined(level.mapkillstreak)) {
    if(var_0 == level.mapkillstreak) {
      var_8 = getmatchdata("players", self.clientid, "numberOfMapstreaksUsed");
      var_8++;
      setmatchdata("players", self.clientid, "numberOfMapstreaksUsed", maps\mp\_utility::clamptobyte(var_8));
    }
  }
}

updatekillstreaks(var_0, var_1) {
  if(!isDefined(var_0)) {
    self.pers["killstreaks"][self.killstreakindexweapon].available = 0;

    if(self.killstreakindexweapon == level.killstreak_gimme_slot) {
      self.pers["killstreaks"][self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot] = undefined;
      var_2 = undefined;
      var_3 = undefined;
      var_4 = self.pers["killstreaks"];

      for(var_5 = level.killstreak_stacking_start_slot; var_5 < var_4.size; var_5++) {
        if(!isDefined(var_4[var_5]) || !isDefined(var_4[var_5].streakname)) {
          continue;
        }
        var_2 = var_4[var_5].streakname;

        if(isDefined(var_4[var_5].modules)) {
          var_3 = var_4[var_5].modules;
        }

        var_4[level.killstreak_gimme_slot].nextslot = var_5;
      }

      if(isDefined(var_2)) {
        var_4[level.killstreak_gimme_slot].available = 1;
        var_4[level.killstreak_gimme_slot].streakname = var_2;

        if(isDefined(var_3)) {
          var_4[level.killstreak_gimme_slot].modules = var_3;
        }

        var_6 = maps\mp\_utility::getkillstreakindex(var_2);
        var_7 = "ks_icon" + common_scripts\utility::tostring(level.killstreak_gimme_slot);
        self setclientomnvar(var_7, var_6);

        if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
          var_8 = maps\mp\_utility::getkillstreakweapon(var_2, var_3);
          maps\mp\_utility::_setactionslot(4, "weapon", var_8);
        }
      } else {
        var_7 = "ks_icon" + common_scripts\utility::tostring(level.killstreak_gimme_slot);
        self setclientomnvar(var_7, 0);
      }
    }
  }

  if(isDefined(var_1)) {
    self.pers["killstreaks"][var_1] = undefined;
  }

  var_9 = undefined;

  for(var_5 = 0; var_5 < level.killstreak_stacking_start_slot; var_5++) {
    var_10 = self.pers["killstreaks"][var_5];

    if(isDefined(var_10) && isDefined(var_10.streakname) && var_10.available) {
      var_9 = var_5;
    }
  }

  if(isDefined(var_9)) {
    if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
      self.killstreakindexweapon = var_9;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_9].streakname;
      giveselectedkillstreakitem();
    } else {
      for(var_5 = 0; var_5 < level.killstreak_stacking_start_slot; var_5++) {
        var_10 = self.pers["killstreaks"][var_5];

        if(isDefined(var_10) && isDefined(var_10.streakname) && var_10.available) {
          var_8 = maps\mp\_utility::getkillstreakweapon(var_10.streakname, var_10.modules);
          var_11 = self getweaponslistitems();
          var_12 = 0;

          for(var_13 = 0; var_13 < var_11.size; var_13++) {
            if(var_8 == var_11[var_13]) {
              var_12 = 1;
              break;
            }
          }

          if(!var_12) {
            maps\mp\_utility::_giveweapon(var_8);
          } else if(issubstr(var_8, "airdrop_")) {
            self setweaponammoclip(var_8, 1);
          }

          maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_8);
        }
      }

      self.killstreakindexweapon = undefined;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_9].streakname;
      updatestreakslots();
    }
  } else {
    self.killstreakindexweapon = undefined;
    self.pers["lastEarnedStreak"] = undefined;
    updatestreakslots();
  }

  self setclientomnvar("ks_used", 1);
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

getfirstprimaryweapon() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

istryingtousekillstreakslot() {
  return isDefined(self.tryingtouseks) && self.tryingtouseks && isDefined(self.killstreakindexweapon);
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

  var_2 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, self.pers["killstreaks"][self.killstreakindexweapon].modules);
  self switchtoweapon(var_2);
  self waittill("weapon_switch_started", var_3);

  if(var_3 != var_2) {
    return undefined;
  }

  return var_2;
}

updateaerialkillstreakmarker() {
  foreach(var_1 in level.players) {
    var_1 notify("updateKillStreakMarker");
  }
}

aerialkillstreakmarker() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");
  var_0 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);

  for(;;) {
    common_scripts\utility::waittill_any("weapon_change", "updateKillStreakMarker");
    var_1 = self getcurrentweapon();
    var_2 = weaponclass(var_1);

    if(var_2 != "rocketlauncher") {
      continue;
    }
    var_3 = [];
    var_3 = getaerialkillstreakarray(var_0);

    if(var_3.size == 0) {
      continue;
    }
    foreach(var_5 in var_3) {
      createthreaticon(var_5, self);
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

  foreach(var_7 in level.planes) {
    if(!level.teambased || var_7.team == var_0) {
      var_1[var_1.size] = var_7;
    }
  }

  if(level.orbitalsupportinuse && isDefined(level.orbitalsupport_planemodel) && isDefined(level.orbitalsupport_planemodel.owner) && isDefined(level.orbitalsupport_planemodel.showthreatmarker) && level.orbitalsupport_planemodel.showthreatmarker) {
    if(level.teambased && level.orbitalsupport_planemodel.owner.team == var_0) {
      var_1[var_1.size] = level.orbitalsupport_planemodel;
    }

    if(!level.teambased) {
      var_1[var_1.size] = level.orbitalsupport_planemodel;
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
  if(!isDefined(var_0.waypoint)) {
    var_0.waypoint = [];
  }

  var_2 = var_1.guid;

  if(isDefined(var_0.waypoint[var_2])) {
    return;
  }
  var_0.waypoint[var_2] = newhudelem();
  var_0.waypoint[var_2] setshader("waypoint_threat_hostile", 1, 1);
  var_0.waypoint[var_2].alpha = 0.75;
  var_0.waypoint[var_2].color = (1, 1, 1);
  var_0.waypoint[var_2].x = var_0.origin[0];
  var_0.waypoint[var_2].y = var_0.origin[1];
  var_0.waypoint[var_2].z = var_0.origin[2];
  var_0.waypoint[var_2] setwaypoint(1, 1, 1);
  var_0.waypoint[var_2] settargetent(var_0);
  var_0.waypoint[var_2].showinkillcam = 0;
  var_0.waypoint[var_2].archived = 0;
  level thread removethreaticon(self, var_0, var_0.waypoint[var_2]);
}

removethreaticon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 common_scripts\utility::waittill_any_ents(var_0, "death", var_1, "death", var_0, "weapon_change", var_0, "disconnect", var_1, "leaving");
  var_2 destroy();
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

    var_1 = maps\mp\_utility::iskillstreakweapon(var_0);

    if(!isalive(self)) {
      continue;
    }
    if(var_1) {}

    if(isDefined(self.ball_carried)) {
      continue;
    }
    if(var_1) {}

    if(!isDefined(self.killstreakindexweapon)) {
      if(!level.console) {
        if(isDefined(self.lastdroppableweapon) && var_0 == "killstreak_predator_missile_mp") {
          self switchtoweapon(self.lastdroppableweapon);
        }
      }

      continue;
    }

    if(var_1) {}

    if(isDefined(self.manuallyjoiningkillstreak) && self.manuallyjoiningkillstreak) {
      continue;
    }
    if(var_1) {}

    if(isDefined(self.iscarrying) && self.iscarrying) {
      continue;
    }
    if(var_1) {}

    if(!isDefined(self.pers["killstreaks"][self.killstreakindexweapon]) || !isDefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname)) {
      continue;
    }
    if(var_1) {}

    var_2 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, self.pers["killstreaks"][self.killstreakindexweapon].modules);

    if(var_0 != var_2) {
      if(issubstr(var_0, "turrethead")) {
        self switchtoweapon(self.lastdroppableweapon);
      }

      if(maps\mp\_utility::isstrstart(var_0, "airdrop_")) {
        self takeweapon(var_0);
        self switchtoweapon(self.lastdroppableweapon);
      }

      continue;
    }

    if(var_1) {}

    waittillframeend;
    var_3 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
    var_4 = self.pers["killstreaks"][self.killstreakindexweapon].isgimme;
    var_5 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
    var_6 = playergetkillstreaklastweapon();
    var_7 = self.killstreakindexweapon;

    if(shouldswitchweaponafterraiseanimation(var_2)) {
      childthread switchweaponafterraiseanimation(var_2, var_6);
    }

    var_8 = gettime();
    var_9 = killstreakusepressed();
    var_10 = gettime();
    var_11 = (var_10 - var_8) / 1000;

    if(!var_9 && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon())) {
      var_6 = playergetkillstreaklastweapon(var_9);
      maps\mp\_utility::_giveweapon(var_6);
    }

    if(var_9) {
      thread waittakekillstreakweapon(var_2);
    }

    if(shouldswitchweaponpostkillstreak(var_9, var_2, var_3, var_5) && !isDefined(self.justswitchedtokillstreakweapon)) {
      switch (var_2) {
        case "killstreak_predator_missile_mp":
          if(!var_9 && 1.2 - var_11 > 0) {
            wait(1.2 - var_11);
          }

          break;
      }

      if(!isDefined(self.underwater)) {
        if(!isDefined(level.ishorde) || isDefined(level.ishorde) && level.ishorde && !(level.hordeweaponsjammed && issubstr(var_2, "turrethead"))) {
          maps\mp\_utility::switch_to_last_weapon(var_6);
        }
      } else {
        self.water_last_weapon = var_6;
      }
    }

    if(self getcurrentweapon() == "none") {
      while(self getcurrentweapon() == "none") {
        wait 0.05;
      }

      waittillframeend;
    }

    if(isDefined(level.cb_usedkillstreak) && var_9) {
      [[level.cb_usedkillstreak]](var_3, var_4, var_7);
    }
  }
}

switchweaponafterraiseanimation(var_0, var_1) {
  switch (var_0) {
    case "killstreak_uav_mp":
      wait 0.75;
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
    return getfirstprimaryweapon();
  } else {
    return common_scripts\utility::getlastweapon();
  }
}

waittakekillstreakweapon(var_0) {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  level endon("game_ended");
  self endon("faux_spawn");
  self notify("waitTakeKillstreakWeapon");
  self endon("waitTakeKillstreakWeapon");
  var_1 = self getcurrentweapon() == "none";
  self waittill("weapon_change", var_2);
  var_3 = self getweaponslistprimaries();

  if(common_scripts\utility::array_contains(var_3, var_2)) {
    takekillstreakweaponifnodupe(var_0);

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
      self.killstreakindexweapon = undefined;
    }
  } else if(var_2 != var_0) {
    thread waittakekillstreakweapon(var_0);
  } else if(var_1 && self getcurrentweapon() == var_0) {
    thread waittakekillstreakweapon(var_0);
  }
}

takekillstreakweaponifnodupe(var_0) {
  var_1 = 0;
  var_2 = self.pers["killstreaks"];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]) && isDefined(var_2[var_3].streakname) && var_2[var_3].available) {
      if(var_0 == maps\mp\_utility::getkillstreakweapon(var_2[var_3].streakname, var_2[var_3].modules)) {
        var_1 = 1;
        break;
      }
    }
  }

  if(var_1) {
    if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
      if(isDefined(self.killstreakindexweapon) && var_0 != maps\mp\_utility::getkillstreakweapon(var_2[self.killstreakindexweapon].streakname, var_2[self.killstreakindexweapon].modules)) {
        self takeweapon(var_0);
      } else if(isDefined(self.killstreakindexweapon) && var_0 == maps\mp\_utility::getkillstreakweapon(var_2[self.killstreakindexweapon].streakname, var_2[self.killstreakindexweapon].modules)) {
        self takeweapon(var_0);
        maps\mp\_utility::_giveweapon(var_0, 0);
        maps\mp\_utility::_setactionslot(4, "weapon", var_0);
      }
    } else {
      self takeweapon(var_0);
      maps\mp\_utility::_giveweapon(var_0, 0);
    }
  } else {
    self takeweapon(var_0);
  }
}

shouldswitchweaponpostkillstreak(var_0, var_1, var_2, var_3) {
  if(shouldswitchweaponafterraiseanimation(var_1)) {
    return 0;
  }

  if(!var_0) {
    return 1;
  }

  switch (var_2) {
    case "warbird":
      return common_scripts\utility::array_contains(var_3, "warbird_ai_attack") || common_scripts\utility::array_contains(var_3, "warbird_ai_follow");
    case "zm_ugv":
    case "assault_ugv":
      return common_scripts\utility::array_contains(var_3, "assault_ugv_ai");
  }

  if(maps\mp\_utility::isridekillstreak(var_2)) {
    return 0;
  }

  return 1;
}

shouldswitchweaponafterraiseanimation(var_0) {
  switch (var_0) {
    case "killstreak_uav_mp":
      return 1;
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
  wait 0.05;
  self notify("finish_death");
  self.pers["lastEarnedStreak"] = undefined;
}

checkstreakreward() {
  foreach(var_1 in self.killstreaks) {
    var_2 = getstreakcost(var_1);
    var_3 = self.adrenaline;
    var_4 = self.previousadrenaline;

    if(issupportstreak(self, var_1)) {
      var_3 = self.adrenalinesupport;
      var_4 = self.previousadrenalinesupport;
    }

    if(var_2 > var_3 && var_3 > var_4) {
      continue;
    }
    if(var_4 < var_2 && (var_3 >= var_2 || var_3 <= var_4)) {
      earnkillstreak(var_1, var_2);
    }
  }
}

killstreakearned(var_0) {
  if(isDefined(self.class_num)) {
    var_1 = self.class_num;

    if(var_1 == -1) {
      var_2 = self.pers["copyCatLoadout"]["className"];
      var_1 = maps\mp\_utility::getclassindex(var_2);

      if(issubstr(var_2, "practice")) {
        var_1 = self.pers["copyCatLoadout"]["practiceClassNum"];
      }
    }

    if(issubstr(self.class, "custom")) {
      if(self getcacplayerdata(var_1, "assaultStreaks", 0, "streak") == var_0) {
        self.firstkillstreakearned = gettime();
      } else if(self getcacplayerdata(var_1, "assaultStreaks", 2, "streak") == var_0 && isDefined(self.firstkillstreakearned)) {
        if(gettime() - self.firstkillstreakearned < 20000) {
          thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
        }
      }
    }
  }
}

earnkillstreak(var_0, var_1) {
  self.earnedstreaklevel = var_1;
  var_2 = getkillstreakmodules(self, var_0);
  var_3 = getnextkillstreakslotindex(var_0, 1);
  thread maps\mp\_events::earnedkillstreakevent(var_0, var_1, var_2, var_3);
  thread killstreakearned(var_0);
  self.pers["lastEarnedStreak"] = var_0;
  givekillstreak(var_0, 1, 1, self, var_2);

  if(maps\mp\_utility::_hasperk("specialty_class_hardline")) {
    maps\mp\gametypes\_missions::processchallenge("ch_perk_hardline");
  }
}

getkillstreakmodules(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(self.killstreakmodules);

  foreach(var_5 in var_3) {
    var_6 = getstreakmodulebasekillstreak(var_5);

    if(var_6 == var_1) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

getnexthordekillstreakslotindex(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.killstreak_gimme_slot;
  }

  return var_0;
}

givehordekillstreak(var_0, var_1, var_2, var_3, var_4) {
  self endon("givingLoadout");

  if(!isDefined(level.killstreakfuncs[var_0]) || tablelookup(level.killstreak_string_table, 1, var_0, 0) == "") {
    return;
  }
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  self endon("disconnect");
  var_5 = undefined;
  var_6 = self.pers["killstreaks"].size;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  if(!isDefined(self.pers["killstreaks"][var_6])) {
    self.pers["killstreaks"][var_6] = spawnStruct();
  }

  var_7 = self.pers["killstreaks"][var_6];
  var_7.available = 0;
  var_7.streakname = var_0;
  var_7.earned = 0;
  var_7.awardxp = 0;
  var_7.owner = var_1;
  var_7.kid = self.pers["kID"];
  var_7.lifeid = -1;
  var_7.isgimme = 1;
  var_5 = getnexthordekillstreakslotindex(var_3);

  if(!isDefined(var_2) || !isarray(var_2)) {
    var_2 = getkillstreakmodules(self, var_0);
  }

  var_7.modules = var_2;
  self.pers["killstreaks"][var_5].nextslot = var_6;
  self.pers["killstreaks"][var_5].streakname = var_0;
  var_8 = maps\mp\_utility::getkillstreakindex(var_0);
  var_9 = "ks_icon" + common_scripts\utility::tostring(var_5);
  self setclientomnvar(var_9, var_8);

  if(!var_4) {
    updatestreakslots();

    if(isDefined(level.killstreaksetupfuncs[var_0])) {
      self[[level.killstreaksetupfuncs[var_0]]]();
    }

    self setclientomnvar("ks_acquired", 1);
    return;
  }

  var_10 = self.pers["killstreaks"][var_5];
  var_10.available = 1;
  var_10.earned = 0;
  var_10.awardxp = 0;
  var_10.owner = var_1;
  var_10.kid = self.pers["kID"];

  if(isDefined(var_2) && isarray(var_2)) {
    var_10.modules = var_2;
  } else {
    var_10.modules = getkillstreakmodules(self, var_0);
  }

  self.pers["kID"]++;
  var_10.lifeid = -1;

  if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
    var_11 = maps\mp\_utility::getkillstreakweapon(var_0, var_2);
    givekillstreakweapon(var_11);

    if(isDefined(self.killstreakindexweapon)) {
      var_0 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
      var_12 = maps\mp\_utility::getkillstreakweapon(var_0, var_2);
      var_13 = self getcurrentweapon();

      if(var_13 != var_12 && !issubstr(var_13, "turrethead")) {
        self.killstreakindexweapon = var_5;
      }
    } else {
      self.killstreakindexweapon = var_5;
    }
  } else {
    if(level.killstreak_gimme_slot == var_5 && self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot > level.killstreak_stacking_start_slot) {
      var_14 = self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot - 1;
      var_15 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_14].streakname, self.pers["killstreaks"][var_14].modules);
      self takeweapon(var_15);
    }

    var_12 = maps\mp\_utility::getkillstreakweapon(var_0, var_2);
    maps\mp\_utility::_giveweapon(var_12, 0);
    maps\mp\_utility::_setactionslot(var_5 + 4, "weapon", var_12);
  }

  updatestreakslots();

  if(isDefined(level.killstreaksetupfuncs[var_0])) {
    self[[level.killstreaksetupfuncs[var_0]]]();
  }

  self setclientomnvar("ks_acquired", 1);
}

getnextkillstreakslotindex(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    if(!isDefined(var_2)) {
      var_3 = level.killstreak_gimme_slot;
    } else {
      var_3 = var_2;
    }
  } else {
    for(var_4 = level.killstreak_slot_1; var_4 < level.killstreak_stacking_start_slot; var_4++) {
      var_5 = self.pers["killstreaks"][var_4];

      if(isDefined(var_5) && isDefined(var_5.streakname) && var_0 == var_5.streakname) {
        var_3 = var_4;
        break;
      }
    }
  }

  return var_3;
}

givekillstreak(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("givingLoadout");

  if(!isDefined(level.killstreakfuncs[var_0]) || tablelookup(level.killstreak_string_table, 1, var_0, 0) == "") {
    return;
  }
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  self endon("disconnect");
  var_6 = undefined;

  if(!isDefined(var_1) || var_1 == 0) {
    var_7 = self.pers["killstreaks"].size;

    if(isDefined(var_5)) {
      var_7 = var_5;
    }

    if(!isDefined(self.pers["killstreaks"][var_7])) {
      self.pers["killstreaks"][var_7] = spawnStruct();
    }

    var_8 = self.pers["killstreaks"][var_7];
    var_8.available = 0;
    var_8.streakname = var_0;
    var_8.earned = 0;
    var_8.awardxp = isDefined(var_2) && var_2;
    var_8.owner = var_3;
    var_8.kid = self.pers["kID"];
    var_8.lifeid = -1;
    var_8.isgimme = 1;
    var_6 = getnextkillstreakslotindex(var_0, var_1, var_5);

    if(!isDefined(var_4) || !isarray(var_4)) {
      var_4 = getkillstreakmodules(self, var_0);
    }

    var_8.modules = var_4;
    self.pers["killstreaks"][var_6].nextslot = var_7;
    self.pers["killstreaks"][var_6].streakname = var_0;
    var_9 = maps\mp\_utility::getkillstreakindex(var_0);
    var_10 = "ks_icon" + common_scripts\utility::tostring(var_6);
    self setclientomnvar(var_10, var_9);
  } else {
    var_6 = getnextkillstreakslotindex(var_0, var_1, var_5);

    if(!isDefined(var_6)) {
      return;
    }
  }

  var_14 = self.pers["killstreaks"][var_6];
  var_14.available = 1;
  var_14.earned = isDefined(var_1) && var_1;
  var_14.awardxp = isDefined(var_2) && var_2;
  var_14.owner = var_3;
  var_14.kid = self.pers["kID"];

  if(isDefined(var_4) && isarray(var_4)) {
    var_14.modules = var_4;
  } else {
    var_14.modules = getkillstreakmodules(self, var_0);
  }

  self.pers["kID"]++;

  if(!var_14.earned) {
    var_14.lifeid = -1;
  } else {
    var_14.lifeid = self.pers["deaths"];
  }

  if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
    var_15 = maps\mp\_utility::getkillstreakweapon(var_0, var_4);
    givekillstreakweapon(var_15);

    if(isDefined(self.killstreakindexweapon)) {
      var_0 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
      var_16 = maps\mp\_utility::getkillstreakweapon(var_0, var_4);
      var_17 = self getcurrentweapon();

      if(var_17 != var_16 && !issubstr(var_17, "turrethead")) {
        self.killstreakindexweapon = var_6;
      }
    } else {
      self.killstreakindexweapon = var_6;
    }
  } else {
    if(level.killstreak_gimme_slot == var_6 && self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot > level.killstreak_stacking_start_slot) {
      var_18 = self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot - 1;
      var_19 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_18].streakname, self.pers["killstreaks"][var_18].modules);
      self takeweapon(var_19);
    }

    var_16 = maps\mp\_utility::getkillstreakweapon(var_0, var_4);
    maps\mp\_utility::_giveweapon(var_16, 0);
    maps\mp\_utility::_setactionslot(var_6 + 4, "weapon", var_16);
  }

  updatestreakslots();

  if(isDefined(level.killstreaksetupfuncs[var_0])) {
    self[[level.killstreaksetupfuncs[var_0]]]();
  }

  if(isDefined(var_1) && var_1 && isDefined(var_2) && var_2) {
    self notify("received_earned_killstreak");
  }

  self setclientomnvar("ks_acquired", 1);
}

givekillstreakweapon(var_0) {
  self endon("disconnect");

  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
    return;
  }
  var_1 = self getweaponslistitems();

  foreach(var_3 in var_1) {
    if(!maps\mp\_utility::isstrstart(var_3, "killstreak_") && !maps\mp\_utility::isstrstart(var_3, "airdrop_") && !maps\mp\_utility::isstrstart(var_3, "deployable_")) {
      continue;
    }
    if(self getcurrentweapon() == var_3) {
      continue;
    }
    while(maps\mp\_utility::ischangingweapon()) {
      wait 0.05;
    }

    self takeweapon(var_3);
  }

  if(isDefined(self.killstreakindexweapon)) {
    var_5 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
    var_6 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
    var_7 = maps\mp\_utility::getkillstreakweapon(var_5, var_6);

    if(self getcurrentweapon() != var_7) {
      maps\mp\_utility::_giveweapon(var_0, 0);
      maps\mp\_utility::_setactionslot(4, "weapon", var_0);
      return;
    }
  } else {
    maps\mp\_utility::_giveweapon(var_0, 0);
    maps\mp\_utility::_setactionslot(4, "weapon", var_0);
  }
}

getstreakmodulecost(var_0) {
  return int(tablelookup(level.ks_modules_table, level.ks_module_ref_column, var_0, level.ks_module_added_points_column));
}

getstreakmodulebasekillstreak(var_0) {
  return tablelookup(level.ks_modules_table, level.ks_module_ref_column, var_0, level.ks_module_killstreak_ref_column);
}

getallstreakmodulescost(var_0) {
  var_1 = 0;
  var_2 = getarraykeys(self.killstreakmodules);

  foreach(var_4 in var_2) {
    var_5 = getstreakmodulebasekillstreak(var_4);

    if(var_5 == var_0) {
      var_1 = var_1 + self.killstreakmodules[var_4];
    }
  }

  return var_1;
}

getstreakcost(var_0) {
  var_1 = int(maps\mp\_utility::getkillstreakkills(var_0));

  if(isplayer(self)) {
    var_1 = var_1 + getallstreakmodulescost(var_0);
  }

  if(isDefined(self) && isplayer(self)) {
    if(var_1 > 100 && maps\mp\_utility::_hasperk("specialty_hardline")) {
      var_1 = var_1 - 100;
    }
  }

  return var_1;
}

getkillstreakhint(var_0) {
  return tablelookupistring(level.killstreak_string_table, 1, var_0, 5);
}

getkillstreakinformenemy(var_0) {
  return int(tablelookup(level.killstreak_string_table, 1, var_0, 10));
}

getkillstreakdialog(var_0) {
  return tablelookup(level.killstreak_string_table, 1, var_0, 7);
}

getkillstreakcrateicon(var_0, var_1) {
  var_2 = 14;

  if(isDefined(var_1) && var_1.size > 0) {
    switch (var_1.size) {
      case 1:
        var_2 = 15;
        break;
      case 2:
        var_2 = 16;
        break;
      case 3:
        var_2 = 17;
        break;
      default:
        break;
    }
  }

  return tablelookup(level.killstreak_string_table, 1, var_0, var_2);
}

giveownedkillstreakitem(var_0) {
  var_1 = self.pers["killstreaks"];

  if(level.console || common_scripts\utility::is_player_gamepad_enabled()) {
    var_2 = -1;
    var_3 = -1;

    for(var_4 = 0; var_4 < level.killstreak_stacking_start_slot; var_4++) {
      if(isDefined(var_1[var_4]) && isDefined(var_1[var_4].streakname) && var_1[var_4].available && getstreakcost(var_1[var_4].streakname) > var_3) {
        var_3 = 0;

        if(!var_1[var_4].isgimme) {
          var_3 = getstreakcost(var_1[var_4].streakname);
        }

        var_2 = var_4;
      }
    }

    if(var_2 != -1) {
      self.killstreakindexweapon = var_2;
      var_5 = var_1[self.killstreakindexweapon].streakname;
      var_6 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
      var_7 = maps\mp\_utility::getkillstreakweapon(var_5, var_6);
      givekillstreakweapon(var_7);
    } else {
      self.killstreakindexweapon = undefined;
    }
  } else {
    var_2 = -1;
    var_3 = -1;

    for(var_4 = 0; var_4 < level.killstreak_stacking_start_slot; var_4++) {
      if(isDefined(var_1[var_4]) && isDefined(var_1[var_4].streakname) && var_1[var_4].available) {
        var_8 = maps\mp\_utility::getkillstreakweapon(var_1[var_4].streakname, var_1[var_4].modules);
        var_9 = self getweaponslistitems();
        var_10 = 0;

        for(var_11 = 0; var_11 < var_9.size; var_11++) {
          if(var_8 == var_9[var_11]) {
            var_10 = 1;
            break;
          }
        }

        if(!var_10) {
          maps\mp\_utility::_giveweapon(var_8);
        } else if(issubstr(var_8, "airdrop_")) {
          self setweaponammoclip(var_8, 1);
        }

        maps\mp\_utility::_setactionslot(var_4 + 4, "weapon", var_8);

        if(getstreakcost(var_1[var_4].streakname) > var_3) {
          var_3 = 0;

          if(!var_1[var_4].isgimme) {
            var_3 = getstreakcost(var_1[var_4].streakname);
          }

          var_2 = var_4;
        }
      }
    }

    if(var_2 != -1) {
      var_5 = var_1[var_2].streakname;
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

  playerdestroyglassbelow();
  common_scripts\utility::_disableusability();
  maps\mp\_utility::freezecontrolswrapper(1);
  self.remoteridetransition = 1;
  var_4 = initridekillstreak_internal(var_0, var_1, var_2, var_3);

  if(isDefined(self)) {
    maps\mp\_utility::freezecontrolswrapper(0);
    common_scripts\utility::_enableusability();
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

  if(isDefined(var_0) && var_0 == "coop") {
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

  if(!isDefined(self) || !isalive(self)) {
    return "fail";
  }

  if(!self isonground() && !self islinked()) {
    return "fail";
  }

  if(isDefined(self.underwater) && self.underwater) {
    return "fail";
  }

  if(level.gameended) {
    return "fail";
  }

  if(maps\mp\_utility::isemped() || maps\mp\_utility::isairdenied()) {
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

  if(!isDefined(self) || !isalive(self)) {
    return "fail";
  }

  if(!self isonground() && !self islinked()) {
    return "fail";
  }

  if(isDefined(self.underwater) && self.underwater) {
    return "fail";
  }

  if(level.gameended) {
    return "fail";
  }

  if(maps\mp\_utility::isemped() || maps\mp\_utility::isairdenied()) {
    return "fail";
  }

  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  return "success";
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
    common_scripts\utility::_enableusability();
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
      destroyglass(var_0["glass"]);
    }
  }
}

giveselectedkillstreakitem() {
  var_0 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
  var_1 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
  var_2 = maps\mp\_utility::getkillstreakweapon(var_0, var_1);
  givekillstreakweapon(var_2);
  updatestreakslots();
}

getkillstreakcount() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.killstreak_stacking_start_slot; var_1++) {
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

      if(self.killstreakindexweapon >= level.killstreak_stacking_start_slot) {
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
        self.killstreakindexweapon = level.killstreak_stacking_start_slot - 1;
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

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("horde_end_spectate");
  }

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

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("horde_end_spectate");
  }

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
  return !self ismantling() && (!isDefined(self.changingweapon) || isDefined(self.changingweapon) && self.changingweapon == "none") && canshufflewithkillstreakweapon() && (!isDefined(self.iscarrying) || isDefined(self.iscarrying) && self.iscarrying == 0);
}

canshufflewithkillstreakweapon() {
  var_0 = self getcurrentweapon();
  return !maps\mp\_utility::iskillstreakweapon(var_0) || maps\mp\_utility::iskillstreakweapon(var_0) && maps\mp\_utility::isjuggernaut();
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
  var_1 = self.adrenaline + var_0;
  var_2 = getmaxstreakcost(0);

  if(var_1 >= var_2) {
    var_1 = var_1 - var_2;
  }

  setadrenaline(var_1);
  var_1 = self.adrenalinesupport + var_0;
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

giveadrenaline(var_0) {
  var_1 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);

  if(maps\mp\_utility::isreallyalive(self)) {
    giveadrenalinedirect(var_1);
  }

  displaykillstreakpoints(var_0, var_1);
}

displaykillstreakpoints(var_0, var_1) {
  if(!level.hardcoremode) {
    thread maps\mp\gametypes\_rank::xppointspopup(var_0, var_1);
  }
}

resetadrenaline(var_0) {
  self.earnedstreaklevel = 0;
  setadrenaline(0);

  if(var_0) {
    setadrenalinesupport(0);
    self.pers["ks_totalPointsSupport"] = 0;
  }

  updatestreakcount();
  self.pers["ks_totalPoints"] = 0;
  self.pers["lastEarnedStreak"] = undefined;
}

setadrenaline(var_0) {
  if(var_0 < 0) {
    var_0 = 0;
  }

  if(isDefined(self.adrenaline) && self.adrenaline != 0) {
    self.previousadrenaline = self.adrenaline;
  } else {
    self.previousadrenaline = 0;
  }

  self.adrenaline = var_0;
  self.pers["ks_totalPoints"] = self.adrenaline;
}

setadrenalinesupport(var_0) {
  if(var_0 < 0) {
    var_0 = 0;
  }

  if(isDefined(self.adrenalinesupport) && self.adrenalinesupport != 0) {
    self.previousadrenalinesupport = self.adrenalinesupport;
  } else {
    self.previousadrenalinesupport = 0;
  }

  self.adrenalinesupport = var_0;
  self.pers["ks_totalPointsSupport"] = self.adrenalinesupport;
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
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  self.actionslotenabled = [];
  self.actionslotenabled[level.killstreak_gimme_slot] = 1;
  self.actionslotenabled[level.killstreak_slot_1] = 1;
  self.actionslotenabled[level.killstreak_slot_2] = 1;
  self.actionslotenabled[level.killstreak_slot_3] = 1;
  self.actionslotenabled[level.killstreak_slot_4] = 1;

  if(!isbot(self)) {
    thread pc_watchcontrolschanged();
  }

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4", "streakUsed5");

    if(common_scripts\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(!isDefined(var_0)) {
      continue;
    }
    if(isDefined(self.changingweapon) && self.changingweapon == "none") {
      continue;
    }
    switch (var_0) {
      case "streakUsed1":
        if(self.pers["killstreaks"][level.killstreak_gimme_slot].available && self.actionslotenabled[level.killstreak_gimme_slot]) {
          self.killstreakindexweapon = level.killstreak_gimme_slot;
        }

        break;
      case "streakUsed2":
        if(self.pers["killstreaks"][level.killstreak_slot_1].available && self.actionslotenabled[level.killstreak_slot_1]) {
          self.killstreakindexweapon = level.killstreak_slot_1;
        }

        break;
      case "streakUsed3":
        if(self.pers["killstreaks"][level.killstreak_slot_2].available && self.actionslotenabled[level.killstreak_slot_2]) {
          self.killstreakindexweapon = level.killstreak_slot_2;
        }

        break;
      case "streakUsed4":
        if(self.pers["killstreaks"][level.killstreak_slot_3].available && self.actionslotenabled[level.killstreak_slot_3]) {
          self.killstreakindexweapon = level.killstreak_slot_3;
        }

        break;
      case "streakUsed5":
        if(self.pers["killstreaks"][level.killstreak_slot_4].available && self.actionslotenabled[level.killstreak_slot_4]) {
          self.killstreakindexweapon = level.killstreak_slot_4;
        }

        break;
    }

    if(isDefined(self.killstreakindexweapon) && !self.pers["killstreaks"][self.killstreakindexweapon].available) {
      self.killstreakindexweapon = undefined;
    }

    if(isDefined(self.killstreakindexweapon)) {
      if(!isbot(self)) {
        disablekillstreakactionslots();
      }

      for(;;) {
        self waittill("weapon_change", var_1);

        if(isDefined(self.killstreakindexweapon)) {
          var_2 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname, self.pers["killstreaks"][self.killstreakindexweapon].modules);

          if(var_1 == var_2 || var_1 == "none" || var_2 == "killstreak_uav_mp" && var_1 == "uav_remote_mp" || var_2 == "killstreak_recreation_mp" && var_1 == "uav_remote_mp") {
            continue;
          }
          break;
        }

        break;
      }

      if(!isbot(self)) {
        enablekillstreakactionslots();
      }

      self.killstreakindexweapon = undefined;
    }
  }
}

disablekillstreakactionslots() {
  for(var_0 = 0; var_0 < level.killstreak_stacking_start_slot; var_0++) {
    if(!isDefined(self.killstreakindexweapon)) {
      break;
    }

    if(self.killstreakindexweapon == var_0) {
      continue;
    }
    maps\mp\_utility::_setactionslot(var_0 + 4, "");
    self.actionslotenabled[var_0] = 0;
  }
}

enablekillstreakactionslots() {
  for(var_0 = 0; var_0 < level.killstreak_stacking_start_slot; var_0++) {
    if(self.pers["killstreaks"][var_0].available) {
      var_1 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_0].streakname, self.pers["killstreaks"][var_0].modules);
      maps\mp\_utility::_setactionslot(var_0 + 4, "weapon", var_1);
    } else {
      maps\mp\_utility::_setactionslot(var_0 + 4, "");
    }

    self.actionslotenabled[var_0] = 1;
  }
}

killstreakhit(var_0, var_1, var_2) {
  if(isDefined(var_1) && isplayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if((level.teambased && var_2.owner.team != var_0.team || !level.teambased) && var_0 != var_2.owner) {
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
        var_5 = clamp(float(var_4) / float(var_3), 0.0, 1.0) * 10000.0;
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_5));
      }
    }
  }
}