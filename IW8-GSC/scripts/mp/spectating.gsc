/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spectating.gsc
***********************************************/

function init() {
  foreach(var_1 in level.teamnamelist) {
    level.spectateoverride[var_1] = spawnStruct();
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&freecamcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);

  if(getdvarint("cg_mlg_static_cameras", 0) != 0) {
    thread getlevelmlgcams();
    return;
  }
}

function createmlgcamobject(var_0, var_1) {
  precacheshader(var_0);
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.angles = (0, 0, 0);
  return var_2;
}

function setlevelmlgcam(var_0, var_1) {
  var_2 = var_0;

  if(var_2 >= 4) {
    var_2 -= 4;
  }

  var_3 = tolower(getDvar("mapname"));
  var_4 = tablelookup(var_1, 0, var_3, var_2 * 2 + 1);

  if(var_4 != "") {
    var_5 = var_0 + 1;

    if(var_0 >= 5) {
      var_5 -= 4;
    }

    level.cameramapobjs[var_0] = createmlgcamobject("compass_icon_codcaster_cam", 1);
    level.numbermapobjs[var_0] = createmlgcamobject("compass_icon_codcaster_num" + var_5, 0);
    var_6 = tablelookup(var_1, 0, var_3, var_2 * 2 + 2);
    level.camerapos[var_0] = getcameravecorang(var_4);
    level.cameraang[var_0] = getcameravecorang(var_6);
    level.camerahighestindex = var_0;
    return;
  }
}

function getlevelmlgcams() {
  while(!isDefined(level.objectiveidpool)) {
    waitframe();
  }

  var_0 = "mp/CameraPositions";
  var_1 = var_0 + "_" + scripts\mp\utility\game::getgametype() + ".csv";
  var_0 += ".csv";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    setlevelmlgcam(var_2, var_0);
  }

  for(var_2 = 4; var_2 < 8; var_2++) {
    setlevelmlgcam(var_2, var_1);
  }
}

function getcameravecorang(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = (0, 0, 0);

  if(isDefined(var_1[0]) && isDefined(var_1[1]) && isDefined(var_1[2])) {
    var_2 = (int(var_1[0]), int(var_1[1]), int(var_1[2]));
  }

  return var_2;
}

function onjoinedteam(var_0) {
  setspectatepermissions(var_0);
}

function onjoinedspectators(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  thread onspectatingclient();
  thread onspectatingmlgcamera();
  setspectatepermissions(var_0);
  var_0 setclientomnvar("ui_callout_area_id", -1);

  if(var_0 ismlgspectator() || isDefined(var_0.pers["mlgSpectator"]) && var_0.pers["mlgSpectator"]) {
    var_0 setmlgspectator(1);
    var_0 setmlgfollowdroneactive(0);
    thread updatemlgspectator();
    thread autoattachtoplayer();
    thread ref_12eb1();
    return;
  }
}

function onspectatingclient() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_cycle");
    var_0 = self getspectatingplayer();

    if(isDefined(var_0)) {
      if(isDefined(var_0.calloutarea)) {
        var_1 = level.calloutglobals.areaidmap[var_0.calloutarea];
        self setclientomnvar("ui_callout_area_id", var_1);
      }
    }
  }
}

function onspectatingmlgcamera() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_mlg_camera");
    var_0 = self getmlgselectedcamera();

    if(self ismlgspectator() || isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"]) {
      if(isDefined(var_0)) {
        self setclientomnvar("ui_callout_area_id", -1);
      }
    }
  }
}

function freecamcallback(var_0, var_1) {
  if(var_0 == "mlg_view_change") {
    scripts\mp\playerlogic::resetuidvarsonspectate();
    return;
  }
}

function updatespectatesettings() {
  level endon("game_ended");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    setspectatepermissions(level.players[var_0]);
  }
}

function linkcameratoball(var_0) {
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
    var_1 = level.codcasterball.origin;
    var_2 = (0, 0, 30);
    var_2 += -80 * var_0;
    var_3 = var_1 + var_2;
    self.codcasterballcamfollow moveTo(var_3, 10.5, 5.2, 5.2);
    self.codcasterballcamfollow.angles = vectortoangles(var_0);
    break;
  }
}

function autoattachtoplayer() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectating_mlg_camera");
  level scripts\engine\utility::ref_143a6("prematch_done", "start_mode_setup", "infil_started");
  level.wasflagspawned = game["lastSpectatedPlayer"];

  for(;;) {
    var_0 = undefined;

    if(!self ismlgspectator() || self isspectatingplayer() || self enablereloading() || self useinvisibleplayerduringspawnselection()) {
      break;
    }

    if(level.players.size > 1) {
      if(level.currentround > 1 && isDefined(level.wasflagspawned) && self.team != "follower") {
        var_0 = level.wasflagspawned;
      } else if(self.team == "follower") {
        var_1 = self updatecurrentweapon();
        var_2 = 0;

        foreach(var_4 in level.players) {
          if(var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
            if(var_4 getentitynumber() == var_1) {
              if(var_4.team == "spectator" || var_4.team == "follower") {
                var_2 = 1;
              } else {
                var_0 = var_1;
              }

              break;
            }
          }
        }

        if(var_2) {
          break;
        }
      } else {
        foreach(var_7 in level.teamnamelist) {
          var_8 = scripts\mp\utility\teams::getfriendlyplayers(var_7, 1);

          if(var_8.size > 0) {
            <
            error > = scripts\mp\utility\player::getlowestclientnum(var_8, 1);
          }
        }
      }

      if(isDefined( < error > )) {
        self spectateclientnum( < error > );
        break;
      }
    }

    wait 1;
  }
}

function updatemlgspectator() {
  self endon("joined_team");
  self endon("disconnect");
  self.iswatchingcodcasterball = 0;
  self.codcasterballcamfollow = undefined;
  self.spectatingplayerbeforeballcam = undefined;

  for(;;) {
    if(self ismlgspectator() && self isspectatingplayer()) {
      var_0 = self getspectatingplayer();

      if(isDefined(var_0)) {
        level.wasflagspawned = var_0.clientid;
      }
    }

    var_1 = isDefined(level.codcasterball);

    if(!var_1 || !self ismlgfollowdroneactive()) {
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
        var_0 = self getspectatingplayer();

        if(isDefined(var_0) && isDefined(level.codcasterballowner) && var_0 == level.codcasterballowner) {
          self.iswatchingcodcasterball = 1;
          self.spectatingplayerbeforeballcam = var_0;
          var_2 = vectorNormalize(level.codcasterballinitialforcevector);
          var_3 = var_0 getvieworigin();
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
      var_8 = vectorNormalize(var_8);
      var_9 = var_4;
      var_10 = (0, 0, 30);
      var_10 += -80 * var_8;
      var_11 = var_9 + var_10;

      if(var_6 > 600) {
        self.codcasterballcamfollow.origin = var_11;
      } else {
        self.codcasterballcamfollow moveTo(var_11, 0.5, 0, 0.2);
      }

      self.codcasterballcamfollow rotateTo(vectortoangles(var_7), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

function ref_12eb1() {
  level waittill("game_ended");
  game["lastSpectatedPlayer"] = level.wasflagspawned;
}

function setspectatepermissions(var_0) {
  if(level.gameended && gettime() - level.gameendtime >= 2000 && !istrue(level.postgameexfil)) {
    if(level.teambased) {
      foreach(var_2 in level.teamnamelist) {
        self allowspectateteam(var_2, 0);
      }
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var_4 = scripts\mp\tweakables::gettweakablevalue("game", "spectatetype");

  if(getdvarint("debug_GLSpectate", 0) == 1) {
    var_4 = 2;
  }

  if(self ismlgspectator()) {
    var_4 = 2;
  }

  if(istrue(self.inspawncamera)) {
    var_4 = 0;
  }

  if(istrue(var_0)) {
    var_4 = 2;
  }

  var_5 = self.sessionteam;

  switch (var_4) {
    case 0:
      setdisabled();
      break;
    case 1:
      self notify("waitForGameStartSpectate");

      if(var_5 != "spectator" && var_5 != "follower") {
        setteamorplayeronly(var_5);
      } else if(isDefined(self.pers["last_team"])) {
        var_5 = self.pers["last_team"];
        setteamorplayeronly(var_5);
      } else if(scripts\mp\flags::gameflag("prematch_done")) {
        var_6 = randomint(level.teamnamelist.size);
        setteamorplayeronly(level.teamnamelist[var_6]);
      } else {
        setteamorplayeronly("allies");
        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      setfreelook(var_0);
      break;
    case 3:
      if(var_5 == "spectator" || var_5 == "follower") {
        setfreelook();
      } else {
        setteamorplayeronly(var_5);
      }

      break;
  }

  if(isDefined(var_5) && scripts\mp\utility\teams::isgameplayteam(var_5)) {
    if(istrue(level.spectateoverride[var_5].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(istrue(level.spectateoverride[var_5].allowenemyspectate)) {
      var_7 = scripts\mp\utility\teams::getenemyteams(var_5);

      foreach(var_2 in var_7) {
        self allowspectateteam(var_2, 1);
      }

      return;
    }

    return;
  }
}

function waitforgamestartspectate() {
  self endon("waitForGameStartSpectate");
  self endon("disconnect");
  level waittill("prematch_over");
  thread setspectatepermissions();
}

function setdisabled() {
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  foreach(var_1 in level.teamnamelist) {
    self allowspectateteam(var_1, 0);
  }
}

function setteamorplayeronly(var_0) {
  self allowspectateteam("freelook", 0);

  if(level.teambased) {
    self allowspectateteam("none", 0);

    foreach(var_2 in level.teamnamelist) {
      if(var_0 == var_2) {
        self allowspectateteam(var_2, 1);
        continue;
      }

      self allowspectateteam(var_2, 0);
    }

    return;
  }

  self allowspectateteam("none", 1);

  foreach(var_2 in level.teamnamelist) {
    self allowspectateteam(var_2, 1);
  }
}

function setfreelook(var_0) {
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(var_2 in level.teamnamelist) {
      self allowspectateteam(var_2, 1);
    }

    if(istrue(var_0)) {
      thread scripts\mp\playerlogic::spawnspectator(undefined, undefined, 1);
      return;
    }

    return;
  }

  if(self ismlgspectator()) {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    thread waitforgamestartspectate();
    return;
  }

  var_4 = self.sessionteam;

  if(self == level.players[0] || var_4 == "spectator" || var_4 == "follower") {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 0);
    thread waitforgamestartspectate();
    return;
  }
}