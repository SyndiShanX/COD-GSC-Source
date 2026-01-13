/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2800.gsc
**************************************/

init() {
  level.spectateoverride["allies"] = spawnStruct();
  level.spectateoverride["axis"] = spawnStruct();
  level thread onplayerconnect();

  if(getdvarint("cg_mlg_static_cameras", 0) != 0) {
    level thread func_7F6C();
  }
}

createmlgcamobject(var_0, var_1) {
  precacheshader(var_0);
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.angles = (0, 0, 0);
  return var_2;
}

setlevelmlgcam(var_0, var_1) {
  var_2 = var_0;

  if(var_2 >= 4) {
    var_2 = var_2 - 4;
  }

  var_3 = tolower(getdvar("mapname"));
  var_4 = tablelookup(var_1, 0, var_3, var_2 * 2 + 1);

  if(var_4 != "") {
    var_5 = var_0 + 1;

    if(var_0 >= 5) {
      var_5 = var_5 - 4;
    }

    level.cameramapobjs[var_0] = createmlgcamobject("compass_icon_codcaster_cam", 1);
    level.numbermapobjs[var_0] = createmlgcamobject("compass_icon_codcaster_num" + var_5, 0);
    var_6 = tablelookup(var_1, 0, var_3, var_2 * 2 + 2);
    level.camerapos[var_0] = getcameravecorang(var_4);
    level.cameraang[var_0] = getcameravecorang(var_6);
    level.camerahighestindex = var_0;
  }
}

func_7F6C() {
  while(!isDefined(level.objidpool)) {
    wait 0.05;
  }

  var_0 = "mp\CameraPositions";
  var_1 = var_0 + "_" + level.gametype + ".csv";
  var_0 = var_0 + ".csv";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    setlevelmlgcam(var_2, var_0);
  }

  for(var_2 = 4; var_2 < 8; var_2++) {
    setlevelmlgcam(var_2, var_1);
  }
}

getcameravecorang(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = (0, 0, 0);

  if(isDefined(var_1[0]) && isDefined(var_1[1]) && isDefined(var_1[2])) {
    var_2 = (int(var_1[0]), int(var_1[1]), int(var_1[2]));
  }

  return var_2;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread func_C541();
    var_0 thread func_C540();
    var_0 thread func_C5A1();
    var_0 thread func_C531();
    var_0 thread func_C5A2();
  }
}

func_C541() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    setspectatepermissions();
  }
}

func_C540() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    setspectatepermissions();
    self setclientomnvar("ui_callout_area_id", -1);

    if(self ismlgspectator() || isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"]) {
      self setmlgspectator(1);
      self setclientomnvar("ui_use_mlg_hud", 1);
      self _meth_85B1(0);
      thread updatemlgspectator();
      thread autoattachtoplayer();
    }
  }
}

func_C5A1() {
  self endon("disconnect");

  for(;;) {
    self waittill("spectating_cycle");
    var_0 = self getspectatingplayer();

    if(self ismlgspectator() || isDefined(var_0)) {
      var_1 = level.calloutglobals.areaidmap[var_0.calloutarea];
      self setclientomnvar("ui_callout_area_id", var_1);

      if(level.gametype == "ball") {
        scripts\mp\gametypes\ball::ball_goal_fx_for_player(self);
      }
    }
  }
}

func_C5A2() {
  self endon("disconnect");

  for(;;) {
    self waittill("spectating_mlg_camera");
    var_0 = self _meth_858E();

    if(self ismlgspectator() || isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"]) {
      if(isDefined(var_0)) {
        self setclientomnvar("ui_callout_area_id", -1);
        continue;
      }
    }
  }
}

func_C531() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "mlg_view_change") {
      scripts\mp\playerlogic::resetuidvarsonconnect();
    }
  }
}

updatespectatesettings() {
  level endon("game_ended");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] setspectatepermissions();
  }
}

linkcameratoball(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  for(;;) {
    if(!isDefined(self.codcasterballcamfollow)) {
      break;
    }
    if(self isspectatingplayer()) {
      wait 0.05;
      continue;
    }

    self cameralinkto(self.codcasterballcamfollow, "tag_origin", 1);
    var_1 = level.codcasterball.origin;
    var_2 = (0, 0, 30);
    var_2 = var_2 + -80 * var_0;
    var_3 = var_1 + var_2;
    self.codcasterballcamfollow moveto(var_3, 10.5, 5.2, 5.2);
    self.codcasterballcamfollow.angles = vectortoangles(var_0);
    break;
  }
}

autoattachtoplayer() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("joined_team");
  self endon("joined_spectator");
  self endon("spectating_mlg_camera");

  for(;;) {
    wait 1.0;
    var_0 = undefined;

    if(!self ismlgspectator() || self isspectatingplayer()) {
      break;
    }
    if(level.players.size > 1) {
      var_1 = scripts\mp\utility\game::getteamarray("allies", 0);

      if(var_1.size > 0) {
        var_0 = scripts\mp\utility\game::getlowestclientnum(var_1, 1);
      }

      if(!isDefined(var_0)) {
        var_1 = scripts\mp\utility\game::getteamarray("axis", 0);

        if(var_1.size > 0) {
          var_0 = scripts\mp\utility\game::getlowestclientnum(var_1, 1);
        }
      }

      if(isDefined(var_0)) {
        self spectateclientnum(var_0);
        break;
      }
    }
  }
}

updatemlgspectator() {
  self endon("joined_team");
  self endon("disconnect");
  self.iswatchingcodcasterball = 0;
  self.codcasterballcamfollow = undefined;
  self.spectatingplayerbeforeballcam = undefined;

  for(;;) {
    var_0 = isDefined(level.codcasterball);

    if(!var_0 || !self ismlgfollowdroneactive()) {
      if(self.iswatchingcodcasterball) {
        self.iswatchingcodcasterball = 0;
        self.codcasterballcamfollow unlink();
        self.codcasterballcamfollow delete();
        self.codcasterballcamfollow = undefined;

        if(!self isspectatingplayer() && isDefined(self.spectatingplayerbeforeballcam)) {
          self spectateclientnum(self.spectatingplayerbeforeballcam getentitynumber());
        } else {
          self cameraunlink();
        }

        self.spectatingplayerbeforeballcam = undefined;
      }
    } else if(!self.iswatchingcodcasterball) {
      if(self ismlgfollowdroneactive()) {
        var_1 = self getspectatingplayer();

        if(isDefined(var_1) && isDefined(level.codcasterballowner) && var_1 == level.codcasterballowner) {
          self.iswatchingcodcasterball = 1;
          self.spectatingplayerbeforeballcam = var_1;
          var_2 = vectornormalize(level.codcasterballinitialforcevector);
          var_3 = var_1 getvieworigin();
          self.codcasterballcamfollow = spawn("script_model", var_3);
          self.codcasterballcamfollow.angles = vectortoangles(var_2);
          self.codcasterballcamfollow setModel("tag_origin");
          stopspectateplayer(self getentitynumber());
          self cameraunlink();
          thread linkcameratoball(var_2);
        }
      }
    } else if(isDefined(self.codcasterballcamfollow)) {
      var_4 = level.codcasterball.origin;
      var_5 = self.codcasterballcamfollow.origin;
      var_6 = distance2d(var_4, var_5);
      var_7 = var_4 - var_5;
      var_8 = (var_7[0], var_7[1], 0);
      var_8 = vectornormalize(var_8);
      var_9 = var_4;
      var_10 = (0, 0, 30);
      var_10 = var_10 + -80 * var_8;
      var_11 = var_9 + var_10;

      if(var_6 > 600) {
        self.codcasterballcamfollow.origin = var_11;
      } else {
        self.codcasterballcamfollow moveto(var_11, 0.5, 0, 0.2);
      }

      self.codcasterballcamfollow rotateto(vectortoangles(var_7), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

setspectatepermissions() {
  if(level.gameended && gettime() - level.gameendtime >= 2000) {
    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        self allowspectateteam(level.teamnamelist[var_0], 0);
      }
    } else {
      self allowspectateteam("allies", 0);
      self allowspectateteam("axis", 0);
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var_1 = scripts\mp\tweakables::gettweakablevalue("game", "spectatetype");

  if(self ismlgspectator()) {
    var_1 = 2;
  }

  if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
    var_1 = 1;
  }

  var_2 = self.sessionteam;

  switch (var_1) {
    case 0:
      func_F6C5();
      break;
    case 1:
      self notify("waitForGameStartSpectate");

      if(var_2 != "spectator") {
        func_F87A(var_2);
      } else if(isDefined(self.pers["last_team"])) {
        var_2 = self.pers["last_team"];
        func_F87A(var_2);
      } else if(scripts\mp\utility\game::gameflag("prematch_done")) {
        if(randomint(2)) {
          var_2 = "allies";
        } else {
          var_2 = "axis";
        }

        func_F87A(var_2);
      } else {
        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      func_F71A();
      break;
    case 3:
      if(var_2 == "spectator") {
        func_F71A();
      } else {
        func_F87A(var_2);
      }

      break;
  }

  if(isDefined(var_2) && (var_2 == "axis" || var_2 == "allies")) {
    if(isDefined(level.spectateoverride[var_2].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(isDefined(level.spectateoverride[var_2].allowenemyspectate)) {
      self allowspectateteam(scripts\mp\utility\game::getotherteam(var_2), 1);
    }
  }
}

waitforgamestartspectate() {
  self endon("waitForGameStartSpectate");
  level waittill("prematch_over");
  thread setspectatepermissions();
}

func_F6C5() {
  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      self allowspectateteam(level.teamnamelist[var_0], 0);
    }
  } else {
    self allowspectateteam("allies", 0);
    self allowspectateteam("axis", 0);
  }

  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
}

func_F87A(var_0) {
  if(!level.teambased) {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    self allowspectateteam("none", 1);
    self allowspectateteam("freelook", 0);
  } else if(isDefined(var_0) && (var_0 == "allies" || var_0 == "axis") && !level.multiteambased) {
    self allowspectateteam(var_0, 1);
    self allowspectateteam(scripts\mp\utility\game::getotherteam(var_0), 0);
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
}

func_F71A() {
  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      self allowspectateteam(level.teamnamelist[var_0], 1);
    }
  } else {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
  }

  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
}