/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_spectating.gsc
*****************************************************/

init() {
  level.spectateoverride["allies"] = spawnStruct();
  level.spectateoverride["axis"] = spawnStruct();
  level.spectateoverride["none"] = spawnStruct();
  level thread _id_04C3::init();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onjoinedteam();
    var_0 thread onjoinedspectators();
    var_0 thread onspectatingclient();
  }
}

onjoinedteam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    setspectatepermissions();
  }
}

onjoinedspectators() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    setspectatepermissions();

    if(!maps\mp\_utility::invirtuallobby() && !_func_367() && (self ismlgspectator() || isDefined(self.pers["broadcaster"]) && self.pers["broadcaster"])) {
      _id_04C3::_id_1C8B();
      self setmlgspectator(1);
    }
  }
}

_id_A0E7() {
  self endon("disconnect");

  if(self ismlgspectator()) {
    for(;;) {
      level waittill("player_spawned", var_0);
      var_1 = var_0.spectatorviewloadout;

      if(isDefined(var_1)) {
        if(isDefined(var_1._id_7709)) {
          self precachekillcamiconforweapon(maps\mp\_utility::_id_4737(var_1._id_7709));
        }

        if(isDefined(var_1.botgetscriptgoalradius)) {
          self precachekillcamiconforweapon(maps\mp\_utility::_id_4737(var_1.botgetscriptgoalradius));
        }
      }
    }
  }
}

onspectatingclient() {
  self endon("disconnect");
  thread _id_A0E7();
  var_0 = self getspectatingplayer();
  self._id_90E1 = var_0;

  for(;;) {
    self waittill("spectating_cycle");

    if(isPlayer(self) && isDefined(var_0)) {
      if(var_0 maps\mp\_utility::_hasperk("specialty_perception") || var_0 maps\mp\_utility::_hasperk("specialty_class_perception")) {
        thread _id_04E6::_id_238F(var_0);
      }

      if(isDefined(var_0._id_0079)) {
        thread _id_04E6::_id_237D(var_0);
      }
    }

    var_0 = self getspectatingplayer();
    self._id_90E1 = var_0;

    if(isDefined(var_0)) {
      self setcarddisplayslot(var_0, 6);

      if(self ismlgspectator()) {
        updatespectatedloadout(var_0);
      }
    }
  }
}

updatespectatesettings() {
  level endon("game_ended");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] setspectatepermissions();
  }
}

setspectatepermissions() {
  var_0 = self._id_0179;

  if(level.gameended && gettime() - level.gameendtime >= 2000) {
    if(level.multiteambased) {
      for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
        self allowspectateteam(level.teamnamelist[var_1], 0);
      }
    } else {
      self allowspectateteam("allies", 0);
      self allowspectateteam("axis", 0);
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var_2 = _id_0511::gettweakablevalue("game", "spectatetype");
  var_3 = _id_0511::gettweakablevalue("game", "lockspectatepov");

  if(common_scripts\utility::_id_562E(level.disableprespawnspectator) && !common_scripts\utility::_id_562E(self.hasspawned) && isDefined(self.team) && self.team != "spectator") {
    var_2 = 0;
  }

  if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby()) {
    var_2 = 1;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    var_2 = 1;
  }

  if(getdvarint("4605") && self ishost()) {
    var_2 = 2;
  }

  switch (var_2) {
    case 0:
      if(level.multiteambased) {
        for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
          self allowspectateteam(level.teamnamelist[var_1], 0);
        }
      } else {
        self allowspectateteam("allies", 0);
        self allowspectateteam("axis", 0);
      }

      self allowspectateteam("freelook", 0);
      self allowspectateteam("none", 0);
      break;
    case 1:
      if(!level.teambased) {
        self allowspectateteam("allies", 1);
        self allowspectateteam("axis", 1);
        self allowspectateteam("none", 1);
        self allowspectateteam("freelook", 0);
      } else if(isDefined(var_0) && (var_0 == "allies" || var_0 == "axis") && !level.multiteambased) {
        self allowspectateteam(var_0, 1);
        self allowspectateteam(maps\mp\_utility::getotherteam(var_0), 0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else if(isDefined(var_0) && issubstr(var_0, "team_") && level.multiteambased) {
        for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
          if(var_0 == level.teamnamelist[var_1]) {
            self allowspectateteam(level.teamnamelist[var_1], 1);
            continue;
          }

          self allowspectateteam(level.teamnamelist[var_1], 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else {
        if(level.multiteambased) {
          for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
            self allowspectateteam(level.teamnamelist[var_1], 0);
          }
        } else {
          self allowspectateteam("allies", 0);
          self allowspectateteam("axis", 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      }

      break;
    case 2:
      if(level.multiteambased) {
        for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
          self allowspectateteam(level.teamnamelist[var_1], 1);
        }
      } else {
        self allowspectateteam("allies", 1);
        self allowspectateteam("axis", 1);
      }

      self allowspectateteam("freelook", 1);
      self allowspectateteam("none", 1);
      break;
  }

  var_4 = self getxuid();

  switch (var_3) {
    case 0:
      self forcespectatepov(var_4, "freelook");
      break;
    case 1:
      if(level.teambased) {
        self allowspectateteam("none", 0);
      }

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_4, "first_person");
      break;
    case 2:
      if(level.teambased) {
        self allowspectateteam("none", 0);
      }

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_4, "third_person");
      break;
  }

  if(isDefined(var_0) && (var_0 == "axis" || var_0 == "allies" || var_0 == "none")) {
    if(isDefined(level.spectateoverride[var_0]._id_0C24)) {
      self allowspectateteam("freelook", 1);
    }

    if(isDefined(level.spectateoverride[var_0]._id_0C22)) {
      self allowspectateteam(maps\mp\_utility::getotherteam(var_0), 1);
    }

    if(isDefined(level.spectateoverride[var_0].allownonespectate)) {
      self allowspectateteam("none", 1);
    }
  }
}

updatespectatedloadoutweapon(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && var_1 != 0) {
    var_3 = _tablelookuprownum("mp/statstable.csv", 18, var_1);
  }

  self setclientomnvar(var_0 + "weapon", var_3);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = undefined;

    if(isDefined(var_2[var_4]) && var_2[var_4] != 0) {
      var_5 = maps\mp\_utility::_id_452B(var_2[var_4]);
    }

    if(!isDefined(var_5)) {
      var_5 = 0;
    }

    self setclientomnvar(var_0 + "attachment_" + var_4, var_5);
  }
}

updatespectatedloadout(var_0) {
  var_1 = var_0.spectatorviewloadout;
  var_2 = maps\mp\_utility::_id_4604();
  var_3 = 3;
  updatespectatedloadoutweapon("ui_broadcaster_loadout_primary_", var_1._id_7709.guid, [var_1._id_76F3[0], var_1._id_76F3[1], var_1._id_76F3[2]]);
  updatespectatedloadoutweapon("ui_broadcaster_loadout_secondary_", var_1.botgetscriptgoalradius.guid, [var_1.botsetflag[0], var_1.botsetflag[1]]);
  var_4 = 0;

  if(isDefined(var_1._id_69AD)) {
    var_5 = maps\mp\_utility::_id_44CD(var_1._id_69AD);
    var_4 = _tablelookuprownum(var_2, 1, var_5);
  }

  self setclientomnvar("ui_broadcaster_loadout_equipment_0", var_4);
  var_6 = 0;

  if(isDefined(var_1._id_37FE)) {
    var_7 = maps\mp\_utility::_id_44CD(var_1._id_37FE);
    var_6 = _tablelookuprownum(var_2, 1, var_7);
  }

  self setclientomnvar("ui_broadcaster_loadout_equipment_1", var_6);

  if(isDefined(var_1._id_37FA) && var_1._id_37FA) {
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", var_6);
  } else {
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", -1);
  }

  var_8 = [var_1._id_5A62, var_1._id_5A63, var_1._id_5A64, var_1._id_5A65];

  for(var_9 = 0; var_9 < 4; var_9++) {
    var_10 = var_8[var_9];
    var_11 = undefined;

    if(isDefined(var_10) && var_10 != 0) {
      var_12 = maps\mp\_utility::_id_452B(var_10);
      var_11 = _tablelookuprownum("mp/killstreakTable.csv", 1, var_12);
    }

    if(!isDefined(var_11)) {
      var_11 = 0;
    }

    self setclientomnvar("ui_broadcaster_loadout_streak_" + var_9, var_11);
  }

  var_13 = var_1._id_6F69[var_3];
  var_14 = undefined;

  if(isDefined(var_13) && var_13 != 0) {
    var_15 = maps\mp\_utility::_id_452B(var_13);
    var_14 = _tablelookuprownum(var_2, 1, var_15);
  } else
    var_14 = 0;

  self setclientomnvar("ui_broadcaster_loadout_training", var_14);
}