/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_spectating.gsc
*****************************************************/

init() {
  level._id_90E2["allies"] = spawnStruct();
  level._id_90E2["axis"] = spawnStruct();
  level._id_90E2["none"] = spawnStruct();
  level thread _id_04C3::init();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_6B49();
    var_0 thread _id_6B48();
    var_0 thread _id_6BAC();
  }
}

_id_6B49() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    _id_872F();
  }
}

_id_6B48() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    _id_872F();

    if(!maps\mp\_utility::_id_551F() && !_func_367() && (self ismlgspectator() || isDefined(self.pers["broadcaster"]) && self.pers["broadcaster"])) {
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
      var_1 = var_0._id_90E4;

      if(isDefined(var_1)) {
        if(isDefined(var_1._id_7709))
          self precachekillcamiconforweapon(maps\mp\_utility::_id_4737(var_1._id_7709));

        if(isDefined(var_1.botgetscriptgoalradius))
          self precachekillcamiconforweapon(maps\mp\_utility::_id_4737(var_1.botgetscriptgoalradius));
      }
    }
  }
}

_id_6BAC() {
  self endon("disconnect");
  thread _id_A0E7();
  var_0 = self getspectatingplayer();
  self._id_90E1 = var_0;

  for(;;) {
    self waittill("spectating_cycle");

    if(isPlayer(self) && isDefined(var_0)) {
      if(var_0 maps\mp\_utility::_hasperk("specialty_perception") || var_0 maps\mp\_utility::_hasperk("specialty_class_perception"))
        thread _id_04E6::_id_238F(var_0);

      if(isDefined(var_0._id_0079))
        thread _id_04E6::_id_237D(var_0);
    }

    var_0 = self getspectatingplayer();
    self._id_90E1 = var_0;

    if(isDefined(var_0)) {
      self setcarddisplayslot(var_0, 6);

      if(self ismlgspectator())
        _id_A168(var_0);
    }
  }
}

_id_A16A() {
  level endon("game_ended");

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] _id_872F();
}

_id_872F() {
  var_0 = self._id_0179;

  if(level.gameended && gettime() - level._id_3F9F >= 2000) {
    if(level._id_6520) {
      for(var_1 = 0; var_1 < level._id_985B.size; var_1++)
        self allowspectateteam(level._id_985B[var_1], 0);
    } else {
      self allowspectateteam("allies", 0);
      self allowspectateteam("axis", 0);
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var_2 = _id_0511::_id_46F7("game", "spectatetype");
  var_3 = _id_0511::_id_46F7("game", "lockspectatepov");

  if(common_scripts\utility::_id_562E(level.disableprespawnspectator) && !common_scripts\utility::_id_562E(self.hasspawned) && isDefined(self.team) && self.team != "spectator")
    var_2 = 0;

  if(self ismlgspectator() && !maps\mp\_utility::_id_551F())
    var_2 = 1;

  if(isDefined(level._id_585D) && level._id_585D)
    var_2 = 1;

  if(getdvarint("4605") && self ishost())
    var_2 = 2;

  switch (var_2) {
    case 0:
      if(level._id_6520) {
        for(var_1 = 0; var_1 < level._id_985B.size; var_1++)
          self allowspectateteam(level._id_985B[var_1], 0);
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
      } else if(isDefined(var_0) && (var_0 == "allies" || var_0 == "axis") && !level._id_6520) {
        self allowspectateteam(var_0, 1);
        self allowspectateteam(maps\mp\_utility::getotherteam(var_0), 0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else if(isDefined(var_0) && issubstr(var_0, "team_") && level._id_6520) {
        for(var_1 = 0; var_1 < level._id_985B.size; var_1++) {
          if(var_0 == level._id_985B[var_1]) {
            self allowspectateteam(level._id_985B[var_1], 1);
            continue;
          }

          self allowspectateteam(level._id_985B[var_1], 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else {
        if(level._id_6520) {
          for(var_1 = 0; var_1 < level._id_985B.size; var_1++)
            self allowspectateteam(level._id_985B[var_1], 0);
        } else {
          self allowspectateteam("allies", 0);
          self allowspectateteam("axis", 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      }

      break;
    case 2:
      if(level._id_6520) {
        for(var_1 = 0; var_1 < level._id_985B.size; var_1++)
          self allowspectateteam(level._id_985B[var_1], 1);
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
      if(level.teambased)
        self allowspectateteam("none", 0);

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_4, "first_person");
      break;
    case 2:
      if(level.teambased)
        self allowspectateteam("none", 0);

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_4, "third_person");
      break;
  }

  if(isDefined(var_0) && (var_0 == "axis" || var_0 == "allies" || var_0 == "none")) {
    if(isDefined(level._id_90E2[var_0]._id_0C24))
      self allowspectateteam("freelook", 1);

    if(isDefined(level._id_90E2[var_0]._id_0C22))
      self allowspectateteam(maps\mp\_utility::getotherteam(var_0), 1);

    if(isDefined(level._id_90E2[var_0].allownonespectate))
      self allowspectateteam("none", 1);
  }
}

_id_A169(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && var_1 != 0)
    var_3 = _tablelookuprownum("mp/statstable.csv", 18, var_1);

  self setclientomnvar(var_0 + "weapon", var_3);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = undefined;

    if(isDefined(var_2[var_4]) && var_2[var_4] != 0)
      var_5 = maps\mp\_utility::_id_452B(var_2[var_4]);

    if(!isDefined(var_5))
      var_5 = 0;

    self setclientomnvar(var_0 + "attachment_" + var_4, var_5);
  }
}

_id_A168(var_0) {
  var_1 = var_0._id_90E4;
  var_2 = maps\mp\_utility::_id_4604();
  var_3 = 3;
  _id_A169("ui_broadcaster_loadout_primary_", var_1._id_7709.guid, [var_1._id_76F3[0], var_1._id_76F3[1], var_1._id_76F3[2]]);
  _id_A169("ui_broadcaster_loadout_secondary_", var_1.botgetscriptgoalradius.guid, [var_1.botsetflag[0], var_1.botsetflag[1]]);
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

  if(isDefined(var_1._id_37FA) && var_1._id_37FA)
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", var_6);
  else
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", -1);

  var_8 = [var_1._id_5A62, var_1._id_5A63, var_1._id_5A64, var_1._id_5A65];

  for(var_9 = 0; var_9 < 4; var_9++) {
    var_10 = var_8[var_9];
    var_11 = undefined;

    if(isDefined(var_10) && var_10 != 0) {
      var_12 = maps\mp\_utility::_id_452B(var_10);
      var_11 = _tablelookuprownum("mp/killstreakTable.csv", 1, var_12);
    }

    if(!isDefined(var_11))
      var_11 = 0;

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