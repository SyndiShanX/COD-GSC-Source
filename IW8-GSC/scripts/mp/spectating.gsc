/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spectating.gsc
***********************************************/

function init() {
  foreach(var1 in level.teamnamelist) {
    level.spectateoverride[var1] = spawnStruct();
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&freecamcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);

  if(getdvarint("OLNMMRPTTS", 0) != 0) {
    thread getlevelmlgcams();
    return;
  }
}

function createmlgcamobject(var0, var1) {
  precacheshader(var0);
  var2 = spawn("script_model", (0, 0, 0));
  var2 setModel("tag_origin");
  var2.angles = (0, 0, 0);
  return var2;
}

function setlevelmlgcam(var0, var1) {
  var2 = var0;

  if(var2 >= 4) {
    var2 -= 4;
  }

  var3 = tolower(getDvar("mapname"));
  var4 = tablelookup(var1, 0, var3, var2 * 2 + 1);

  if(var4 != "") {
    var5 = var0 + 1;

    if(var0 >= 5) {
      var5 -= 4;
    }

    level.cameramapobjs[var0] = createmlgcamobject("compass_icon_codcaster_cam", 1);
    level.numbermapobjs[var0] = createmlgcamobject("compass_icon_codcaster_num" + var5, 0);
    var6 = tablelookup(var1, 0, var3, var2 * 2 + 2);
    level.camerapos[var0] = getcameravecorang(var4);
    level.cameraang[var0] = getcameravecorang(var6);
    level.camerahighestindex = var0;
    return;
  }
}

function getlevelmlgcams() {
  while(!isDefined(level.objectiveidpool)) {
    waitframe();
  }

  var0 = "mp/CameraPositions";
  var1 = var0 + "_" + scripts\mp\utility\game::getgametype() + ".csv";
  var0 += ".csv";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(var2 = 0; var2 < 4; var2++) {
    setlevelmlgcam(var2, var0);
  }

  for(var2 = 4; var2 < 8; var2++) {
    setlevelmlgcam(var2, var1);
  }
}

function getcameravecorang(var0) {
  var1 = strtok(var0, " ");
  var2 = (0, 0, 0);

  if(isDefined(var1[0]) && isDefined(var1[1]) && isDefined(var1[2])) {
    var2 = (int(var1[0]), int(var1[1]), int(var1[2]));
  }

  return var2;
}

function onjoinedteam(var0) {
  setspectatepermissions(var0);
}

function onjoinedspectators(var0) {
  if(!isDefined(var0)) {
    return;
  }

  thread onspectatingclient();
  thread onspectatingmlgcamera();
  setspectatepermissions(var0);
  var0 setclientomnvar("ui_callout_area_id", -1);

  if(var0 ismlgspectator() || isDefined(var0.pers["mlgSpectator"]) && var0.pers["mlgSpectator"]) {
    var0 setmlgspectator(1);
    var0 setmlgfollowdroneactive(0);
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
    var0 = self getspectatingplayer();

    if(isDefined(var0)) {
      if(isDefined(var0.calloutarea)) {
        var1 = level.calloutglobals.areaidmap[var0.calloutarea];
        self setclientomnvar("ui_callout_area_id", var1);
      }
    }
  }
}

function onspectatingmlgcamera() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_mlg_camera");
    var0 = self getmlgselectedcamera();

    if(self ismlgspectator() || isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"]) {
      if(isDefined(var0)) {
        self setclientomnvar("ui_callout_area_id", -1);
      }
    }
  }
}

function freecamcallback(var0, var1) {
  if(var0 == "mlg_view_change") {
    scripts\mp\playerlogic::resetuidvarsonspectate();
    return;
  }
}

function updatespectatesettings() {
  level endon("game_ended");

  for(var0 = 0; var0 < level.players.size; var0++) {
    setspectatepermissions(level.players[var0]);
  }
}

function linkcameratoball(var0) {
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
    var1 = level.codcasterball.origin;
    var2 = (0, 0, 30);
    var2 += -80 * var0;
    var3 = var1 + var2;
    self.codcasterballcamfollow moveTo(var3, 10.5, 5.2, 5.2);
    self.codcasterballcamfollow.angles = vectortoangles(var0);
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
    var0 = undefined;

    if(!self ismlgspectator() || self isspectatingplayer() || self enablereloading() || self useinvisibleplayerduringspawnselection()) {
      break;
    }

    if(level.players.size > 1) {
      if(level.currentround > 1 && isDefined(level.wasflagspawned) && self.team != "follower") {
        var0 = level.wasflagspawned;
      } else if(self.team == "follower") {
        var1 = self updatecurrentweapon();
        var2 = 0;

        foreach(var4 in level.players) {
          if(var4 scripts\cp_mp\utility\player_utility::_isalive()) {
            if(var4 getentitynumber() == var1) {
              if(var4.team == "spectator" || var4.team == "follower") {
                var2 = 1;
              } else {
                var0 = var1;
              }

              break;
            }
          }
        }

        if(var2) {
          break;
        }
      } else {
        foreach(var7 in level.teamnamelist) {
          var8 = scripts\mp\utility\teams::getfriendlyplayers(var7, 1);

          if(var8.size > 0) {
            <
            error > = scripts\mp\utility\player::getlowestclientnum(var8, 1);
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
      var0 = self getspectatingplayer();

      if(isDefined(var0)) {
        level.wasflagspawned = var0.clientid;
      }
    }

    var1 = isDefined(level.codcasterball);

    if(!var1 || !self ismlgfollowdroneactive()) {
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
        var0 = self getspectatingplayer();

        if(isDefined(var0) && isDefined(level.codcasterballowner) && var0 == level.codcasterballowner) {
          self.iswatchingcodcasterball = 1;
          self.spectatingplayerbeforeballcam = var0;
          var2 = vectorNormalize(level.codcasterballinitialforcevector);
          var3 = var0 getvieworigin();
          self.codcasterballcamfollow = spawn("script_model", var3);
          self.codcasterballcamfollow.angles = vectortoangles(var2);
          self.codcasterballcamfollow setModel("tag_origin");
          stopspectateplayer(self getentitynumber());
          self cameraunlink();
          thread linkcameratoball(var2);
        }
      }
    } else if(isDefined(self.codcasterballcamfollow)) {
      var4 = level.codcasterball.origin;
      var5 = self.codcasterballcamfollow.origin;
      var6 = distance2d(var4, var5);
      var7 = var4 - var5;
      var8 = (var7[0], var7[1], 0);
      var8 = vectorNormalize(var8);
      var9 = var4;
      var10 = (0, 0, 30);
      var10 += -80 * var8;
      var11 = var9 + var10;

      if(var6 > 600) {
        self.codcasterballcamfollow.origin = var11;
      } else {
        self.codcasterballcamfollow moveTo(var11, 0.5, 0, 0.2);
      }

      self.codcasterballcamfollow rotateTo(vectortoangles(var7), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

function ref_12eb1() {
  level waittill("game_ended");
  game["lastSpectatedPlayer"] = level.wasflagspawned;
}

function setspectatepermissions(var0) {
  if(level.gameended && gettime() - level.gameendtime >= 2000 && !istrue(level.postgameexfil)) {
    if(level.teambased) {
      foreach(var2 in level.teamnamelist) {
        self allowspectateteam(var2, 0);
      }
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var4 = scripts\mp\tweakables::gettweakablevalue("game", "spectatetype");

  if(getdvarint("debug_GLSpectate", 0) == 1) {
    var4 = 2;
  }

  if(self ismlgspectator()) {
    var4 = 2;
  }

  if(istrue(self.inspawncamera)) {
    var4 = 0;
  }

  if(istrue(var0)) {
    var4 = 2;
  }

  var5 = self.sessionteam;

  switch (var4) {
    case 0:
      setdisabled();
      break;
    case 1:
      self notify("waitForGameStartSpectate");

      if(var5 != "spectator" && var5 != "follower") {
        setteamorplayeronly(var5);
      } else if(isDefined(self.pers["last_team"])) {
        var5 = self.pers["last_team"];
        setteamorplayeronly(var5);
      } else if(scripts\mp\flags::gameflag("prematch_done")) {
        var6 = randomint(level.teamnamelist.size);
        setteamorplayeronly(level.teamnamelist[var6]);
      } else {
        setteamorplayeronly("allies");
        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      setfreelook(var0);
      break;
    case 3:
      if(var5 == "spectator" || var5 == "follower") {
        setfreelook();
      } else {
        setteamorplayeronly(var5);
      }

      break;
  }

  if(isDefined(var5) && scripts\mp\utility\teams::isgameplayteam(var5)) {
    if(istrue(level.spectateoverride[var5].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(istrue(level.spectateoverride[var5].allowenemyspectate)) {
      var7 = scripts\mp\utility\teams::getenemyteams(var5);

      foreach(var2 in var7) {
        self allowspectateteam(var2, 1);
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

  foreach(var1 in level.teamnamelist) {
    self allowspectateteam(var1, 0);
  }
}

function setteamorplayeronly(var0) {
  self allowspectateteam("freelook", 0);

  if(level.teambased) {
    self allowspectateteam("none", 0);

    foreach(var2 in level.teamnamelist) {
      if(var0 == var2) {
        self allowspectateteam(var2, 1);
        continue;
      }

      self allowspectateteam(var2, 0);
    }

    return;
  }

  self allowspectateteam("none", 1);

  foreach(var2 in level.teamnamelist) {
    self allowspectateteam(var2, 1);
  }
}

function setfreelook(var0) {
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(var2 in level.teamnamelist) {
      self allowspectateteam(var2, 1);
    }

    if(istrue(var0)) {
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

  var4 = self.sessionteam;

  if(self == level.players[0] || var4 == "spectator" || var4 == "follower") {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 0);
    thread waitforgamestartspectate();
    return;
  }
}