/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spectating.gsc
***********************************************/

init() {
  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spectateoverride[_id_F90358454413407F] = spawnStruct();

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::freecamcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);

  if(getdvarint("cg_mlg_static_cameras", 0) != 0)
    level thread getlevelmlgcams();
}

createmlgcamobject(icon, _id_014E3B97A4E7F7BA) {
  precacheshader(icon);
  camera = spawn("script_model", (0, 0, 0));
  camera setModel("tag_origin");
  camera.angles = (0, 0, 0);
  return camera;
}

setlevelmlgcam(index, _id_78F81D819C266965) {
  _id_01065D9A6B1649A1 = index;

  if(_id_01065D9A6B1649A1 >= 4)
    _id_01065D9A6B1649A1 = _id_01065D9A6B1649A1 - 4;

  mapname = tolower(getDvar("g_mapname"));
  _id_D9733D3B5B9C44CE = tablelookup(_id_78F81D819C266965, 0, mapname, _id_01065D9A6B1649A1 * 2 + 1);

  if(_id_D9733D3B5B9C44CE != "") {
    _id_DD0F1974B9C2C56A = index + 1;

    if(index >= 5)
      _id_DD0F1974B9C2C56A = _id_DD0F1974B9C2C56A - 4;

    level.cameramapobjs[index] = createmlgcamobject("compass_icon_codcaster_cam", 1);
    level.numbermapobjs[index] = createmlgcamobject("compass_icon_codcaster_num" + _id_DD0F1974B9C2C56A, 0);
    _id_FFB7BA3ABBF69F8C = tablelookup(_id_78F81D819C266965, 0, mapname, _id_01065D9A6B1649A1 * 2 + 2);
    level.camerapos[index] = getcameravecorang(_id_D9733D3B5B9C44CE);
    level.cameraang[index] = getcameravecorang(_id_FFB7BA3ABBF69F8C);
    level.camerahighestindex = index;
  }
}

getlevelmlgcams() {
  while(!isDefined(level.objectiveidpool))
    waitframe();

  _id_78F81D819C266965 = "mp/CameraPositions";
  _id_3B2139BFD025890B = _id_78F81D819C266965 + "_" + scripts\mp\utility\game::getgametype() + ".csv";
  _id_78F81D819C266965 = _id_78F81D819C266965 + ".csv";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(index = 0; index < 4; index++)
    setlevelmlgcam(index, _id_78F81D819C266965);

  for(index = 4; index < 8; index++)
    setlevelmlgcam(index, _id_3B2139BFD025890B);
}

getcameravecorang(_id_9C0FE13528240836) {
  _id_26FA16CED67D6AD0 = strtok(_id_9C0FE13528240836, " ");
  _id_D2F65E1ABE223EAD = (0, 0, 0);

  if(isDefined(_id_26FA16CED67D6AD0[0]) && isDefined(_id_26FA16CED67D6AD0[1]) && isDefined(_id_26FA16CED67D6AD0[2]))
    _id_D2F65E1ABE223EAD = (int(_id_26FA16CED67D6AD0[0]), int(_id_26FA16CED67D6AD0[1]), int(_id_26FA16CED67D6AD0[2]));

  return _id_D2F65E1ABE223EAD;
}

onjoinedteam(player) {
  player setspectatepermissions();
}

onjoinedspectators(player) {
  if(!isDefined(player)) {
    return;
  }
  player thread onspectatingclient();
  player thread onspectatingmlgcamera();
  player setspectatepermissions();
  player setclientomnvar("ui_callout_area_id", -1);

  if(player _meth_8420670EAFC8D391() || isDefined(player.pers["codcaster"]) && player.pers["codcaster"]) {
    player _meth_7398D812FCA0292F(1);
    player setmlgfollowdroneactive(0);
    player thread _id_DE89A33A1571DD0A();
    player thread autoattachtoplayer();
    player thread saveendgamelocals();
  }
}

onspectatingclient() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_cycle");
    player = self getspectatingplayer();

    if(isDefined(player)) {
      if(isDefined(player.calloutarea)) {
        _id_49996EBEBBBBF375 = level.calloutglobals.areaidmap[player.calloutarea];
        self setclientomnvar("ui_callout_area_id", _id_49996EBEBBBBF375);
      }
    }
  }
}

onspectatingmlgcamera() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_mlg_camera");
    _id_ECFCF631312F12AF = self getmlgselectedcamera();

    if(self _meth_8420670EAFC8D391() || isDefined(self.pers["codcaster"]) && self.pers["codcaster"]) {
      if(isDefined(_id_ECFCF631312F12AF)) {
        self setclientomnvar("ui_callout_area_id", -1);
        continue;
      }
    }
  }
}

freecamcallback(_id_7148C1A6F25491F8, _id_451EE4263845EBEC) {
  if(_id_7148C1A6F25491F8 == "mlg_view_change")
    scripts\mp\playerlogic::resetuidvarsonspectate();
}

updatespectatesettings() {
  level endon("game_ended");

  for(index = 0; index < level.players.size; index++)
    level.players[index] setspectatepermissions();
}

linkcameratoball(_id_FEAB200657F86FDB) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  for(;;) {
    if(!isDefined(self.codcasterballcamfollow)) {
      break;
    }

    if(self isspectatingplayer()) {
      waitframe();
      continue;
    }

    self cameralinkTo(self.codcasterballcamfollow, "tag_origin", 1);
    _id_5B248E30E84F1278 = level.codcasterball.origin;
    offset = (0, 0, 30);
    offset = offset + -80 * _id_FEAB200657F86FDB;
    _id_7858D5475D46051C = _id_5B248E30E84F1278 + offset;
    self.codcasterballcamfollow moveTo(_id_7858D5475D46051C, 10.5, 5.2, 5.2);
    self.codcasterballcamfollow.angles = vectortoangles(_id_FEAB200657F86FDB);
    break;
  }
}

autoattachtoplayer() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectating_mlg_camera");
  level scripts\engine\utility::waittill_any_4("prematch_started", "prematch_done", "start_mode_setup", "infil_started");
  level.lastspectatedplayer = game["lastSpectatedPlayer"];

  for(;;) {
    _id_D4E316F35A455ACD = undefined;

    if(!self _meth_8420670EAFC8D391() || self isspectatingplayer() || self ismlgfreecamenabled() || self ismlgaerialcamenabled()) {
      break;
    }

    if(level.players.size > 1) {
      if(level.currentround > 1 && isDefined(level.lastspectatedplayer))
        _id_D4E316F35A455ACD = level.lastspectatedplayer;
      else {
        foreach(_id_F90358454413407F in level.teamnamelist) {
          aliveplayers = scripts\mp\utility\teams::getfriendlyplayers(_id_F90358454413407F, 1);

          if(aliveplayers.size > 0)
            _id_D4E316F35A455ACD = scripts\mp\utility\player::getlowestclientnum(aliveplayers, 1);
        }
      }

      if(isDefined(_id_D4E316F35A455ACD)) {
        self spectateclientnum(_id_D4E316F35A455ACD);
        break;
      }
    }

    wait 1.0;
  }
}

_id_DE89A33A1571DD0A() {
  self endon("joined_team");
  self endon("disconnect");
  self.iswatchingcodcasterball = 0;
  self.codcasterballcamfollow = undefined;
  self.spectatingplayerbeforeballcam = undefined;

  for(;;) {
    if(self _meth_8420670EAFC8D391() && self isspectatingplayer()) {
      player = self getspectatingplayer();

      if(isDefined(player))
        level.lastspectatedplayer = player.clientid;

      player _id_548072087C9FD504::_id_20038A4ADA38BE4D(self);
    }

    _id_627E69AD7533B2BC = isDefined(level.codcasterball);

    if(!_id_627E69AD7533B2BC || !self ismlgfollowdroneactive()) {
      if(self.iswatchingcodcasterball) {
        self.iswatchingcodcasterball = 0;
        self.codcasterballcamfollow unlink();
        self.codcasterballcamfollow delete();
        self.codcasterballcamfollow = undefined;

        if(!self isspectatingplayer() && isDefined(self.spectatingplayerbeforeballcam))
          self spectateclientnum(self.spectatingplayerbeforeballcam getentitynumber());
        else
          self cameraunlink();

        self.spectatingplayerbeforeballcam = undefined;
      }
    } else if(!self.iswatchingcodcasterball) {
      if(self ismlgfollowdroneactive()) {
        player = self getspectatingplayer();

        if(isDefined(player) && isDefined(level.codcasterballowner) && player == level.codcasterballowner) {
          self.iswatchingcodcasterball = 1;
          self.spectatingplayerbeforeballcam = player;
          _id_FEAB200657F86FDB = vectorNormalize(level.codcasterballinitialforcevector);
          spawnpos = player getvieworigin();
          self.codcasterballcamfollow = spawn("script_model", spawnpos);
          self.codcasterballcamfollow.angles = vectortoangles(_id_FEAB200657F86FDB);
          self.codcasterballcamfollow setModel("tag_origin");
          stopspectateplayer(self getentitynumber());
          self cameraunlink();
          thread linkcameratoball(_id_FEAB200657F86FDB);
        }
      }
    } else if(isDefined(self.codcasterballcamfollow)) {
      _id_88DDDFF7DC28BB5F = level.codcasterball.origin;
      _id_0E04F6ADCAB85C41 = self.codcasterballcamfollow.origin;
      _id_AF272107A30A0964 = distance2d(_id_88DDDFF7DC28BB5F, _id_0E04F6ADCAB85C41);
      _id_D6AB325210DA0E83 = _id_88DDDFF7DC28BB5F - _id_0E04F6ADCAB85C41;
      _id_16A2CC6D8BD6F76F = (_id_D6AB325210DA0E83[0], _id_D6AB325210DA0E83[1], 0);
      _id_16A2CC6D8BD6F76F = vectorNormalize(_id_16A2CC6D8BD6F76F);
      _id_5B248E30E84F1278 = _id_88DDDFF7DC28BB5F;
      offset = (0, 0, 30);
      offset = offset + -80 * _id_16A2CC6D8BD6F76F;
      _id_7858D5475D46051C = _id_5B248E30E84F1278 + offset;

      if(_id_AF272107A30A0964 > 600)
        self.codcasterballcamfollow.origin = _id_7858D5475D46051C;
      else
        self.codcasterballcamfollow moveTo(_id_7858D5475D46051C, 0.5, 0, 0.2);

      self.codcasterballcamfollow rotateTo(vectortoangles(_id_D6AB325210DA0E83), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

saveendgamelocals() {
  level waittill("game_ended");
  game["lastSpectatedPlayer"] = level.lastspectatedplayer;
}

setspectatepermissions(gameended) {
  if(level.gameended && gettime() - level.gameendtime >= 2000 && !istrue(level.postgameexfil)) {
    if(level.teambased) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      self allowspectateteam(_id_F90358454413407F, 0);
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  _id_3AF8CCCC053F8276 = scripts\mp\tweakables::gettweakablevalue("game", "spectatetype");

  if(getdvarint("dvar_E32EBDBB97A1EC4E", 0) == 1)
    _id_3AF8CCCC053F8276 = 2;

  if(self _meth_8420670EAFC8D391())
    _id_3AF8CCCC053F8276 = 2;

  if(istrue(self.inspawncamera) || isDefined(self.setspawnpoint) && scripts\mp\playerlogic::mayspawn())
    _id_3AF8CCCC053F8276 = 0;

  if(istrue(gameended))
    _id_3AF8CCCC053F8276 = 2;

  if(istrue(level._id_A98A9986264D0EFC))
    _id_3AF8CCCC053F8276 = 0;

  team = self.sessionteam;

  switch (_id_3AF8CCCC053F8276) {
    case 0:
      setdisabled();
      break;
    case 1:
      self notify("waitForGameStartSpectate");

      if(team != "spectator" && team != "codcaster")
        setteamorplayeronly(team);
      else if(isDefined(self.pers["last_team"])) {
        team = self.pers["last_team"];
        setteamorplayeronly(team);
      } else if(scripts\mp\flags::gameflag("prematch_started")) {
        _id_F49EE9D2911C5AB5 = randomint(level.teamnamelist.size);
        setteamorplayeronly(level.teamnamelist[_id_F49EE9D2911C5AB5]);
      } else {
        setteamorplayeronly("allies");
        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      setfreelook(gameended);
      break;
    case 3:
      if(team == "spectator" || team == "codcaster")
        setfreelook();
      else
        setteamorplayeronly(team);

      break;
  }

  if(isDefined(team) && scripts\mp\utility\teams::isgameplayteam(team)) {
    if(istrue(level.spectateoverride[team].allowfreespectate))
      self allowspectateteam("freelook", 1);

    if(istrue(level.spectateoverride[team].allowenemyspectate)) {
      _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);

      foreach(_id_F90358454413407F in _id_B0C33D224B825287)
      self allowspectateteam(_id_F90358454413407F, 1);
    }
  }

  _id_929FD4BDFABD747B = scripts\mp\utility\game::privatematch() && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_929FD4BDFABD747B && (self.sessionteam == "spectator" || self.sessionteam == "codcaster")) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(!scripts\mp\utility\teams::isgameplayteam(_id_F90358454413407F)) {
        continue;
      }
      self allowspectateteam(_id_F90358454413407F, 1);
    }

    scripts\mp\utility\player::updatesessionstate("spectator");
  }
}

waitforgamestartspectate() {
  self endon("waitForGameStartSpectate");
  self endon("disconnect");
  level waittill("prematch_started");
  thread setspectatepermissions();
}

setdisabled() {
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  foreach(_id_F90358454413407F in level.teamnamelist)
  self allowspectateteam(_id_F90358454413407F, 0);
}

setteamorplayeronly(team) {
  self allowspectateteam("freelook", 0);

  if(level.teambased) {
    self allowspectateteam("none", 0);

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(team == _id_F90358454413407F) {
        self allowspectateteam(_id_F90358454413407F, 1);
        continue;
      }

      self allowspectateteam(_id_F90358454413407F, 0);
    }
  } else {
    self allowspectateteam("none", 1);

    foreach(_id_F90358454413407F in level.teamnamelist)
    self allowspectateteam(_id_F90358454413407F, 1);
  }
}

setfreelook(gameended) {
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    self allowspectateteam(_id_F90358454413407F, 1);

    if(istrue(gameended)) {
      thread scripts\mp\playerlogic::spawnspectator(undefined, undefined, 1);
      return;
    }
  } else if(self _meth_8420670EAFC8D391()) {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    thread waitforgamestartspectate();
  } else {
    team = self.sessionteam;

    if(self == level.players[0] || team == "spectator" || team == "codcaster") {
      self allowspectateteam("allies", 1);
      self allowspectateteam("axis", 0);
      thread waitforgamestartspectate();
    }
  }
}