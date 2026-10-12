/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spectating.gsc
***********************************************/

#using script_548072087c9fd504;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\playerlogic;
#using scripts\mp\tweakables;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace spectating;

function init() {
  foreach(entry in level.teamnamelist) {
    level.spectateoverride[entry] = spawnStruct();
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&freecamcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);

  if(getdvarint(@ "hash_242c4deac00b8e5b", 0) != 0) {
    level thread getlevelmlgcams();
  }
}

function createmlgcamobject(icon, followrotation) {
  precacheshader(icon);
  camera = spawn("script_model", (0, 0, 0));
  camera setModel("tag_origin");
  camera.angles = (0, 0, 0);
  return camera;
}

function setlevelmlgcam(index, csvfile) {
  tableindex = index;

  if(tableindex >= 4) {
    tableindex -= 4;
  }

  mapname = tolower(getDvar(@ "g_mapname"));
  var_d9733d3b5b9c44ce = tablelookup(csvfile, 0, mapname, tableindex * 2 + 1);

  if(var_d9733d3b5b9c44ce != "") {
    var_dd0f1974b9c2c56a = index + 1;

    if(index >= 5) {
      var_dd0f1974b9c2c56a -= 4;
    }

    level.cameramapobjs[index] = createmlgcamobject("compass_icon_codcaster_cam", 1);
    level.numbermapobjs[index] = createmlgcamobject("compass_icon_codcaster_num" + var_dd0f1974b9c2c56a, 0);
    var_ffb7ba3abbf69f8c = tablelookup(csvfile, 0, mapname, tableindex * 2 + 2);
    level.camerapos[index] = getcameravecorang(var_d9733d3b5b9c44ce);
    level.cameraang[index] = getcameravecorang(var_ffb7ba3abbf69f8c);
    level.camerahighestindex = index;
  }
}

function getlevelmlgcams() {
  while(!isDefined(level.objectiveidpool)) {
    waitframe();
  }

  csvfile = "mp/CameraPositions";
  var_3b2139bfd025890b = csvfile + "_" + getgametype() + ".csv";
  csvfile += ".csv";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(index = 0; index < 4; index++) {
    setlevelmlgcam(index, csvfile);
  }

  for(index = 4; index < 8; index++) {
    setlevelmlgcam(index, var_3b2139bfd025890b);
  }
}

function getcameravecorang(elementstring) {
  var_26fa16ced67d6ad0 = strtok(elementstring, " ");
  var_d2f65e1abe223ead = (0, 0, 0);

  if(isDefined(var_26fa16ced67d6ad0[0]) && isDefined(var_26fa16ced67d6ad0[1]) && isDefined(var_26fa16ced67d6ad0[2])) {
    var_d2f65e1abe223ead = (int(var_26fa16ced67d6ad0[0]), int(var_26fa16ced67d6ad0[1]), int(var_26fa16ced67d6ad0[2]));
  }

  return var_d2f65e1abe223ead;
}

function onjoinedteam(player) {
  player setspectatepermissions();
}

function onjoinedspectators(player) {
  if(!isDefined(player)) {
    return;
  }

  player thread onspectatingclient();
  player thread onspectatingmlgcamera();
  player setspectatepermissions();
  player setclientomnvar("ui_callout_area_id", -1);

  if(player iscodcaster() || isDefined(player.pers["codcaster"]) && player.pers["codcaster"]) {
    player function_7398d812fca0292f(1);
    player thread function_de89a33a1571dd0a();
    player thread autoattachtoplayer();
    player thread saveendgamelocals();
  }
}

function onspectatingclient() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_cycle");
    player = self getspectatingplayer();

    if(isDefined(player)) {
      if(isDefined(player.calloutarea)) {
        areaid = level.calloutglobals.areaidmap[player.calloutarea];
        self setclientomnvar("ui_callout_area_id", areaid);
      }

      if(game["state"] == "playing" && level.teamdata[player.team]["alivePlayers"].size > 0 && !isinkillcam()) {
        gametype = getbasegametype();
        var_b19d8f6eee9278c4 = getdvarint(@ "hash_2167cbfc86b6839", 0) == 1;

        if(gametype == "sd" || gametype == "arena" && var_b19d8f6eee9278c4 || gametype == "warrior") {
          if(player.team == "allies") {
            self setclientomnvar("ui_team_before_spectating", 1);
            continue;
          }

          if(player.team == "axis") {
            self setclientomnvar("ui_team_before_spectating", 2);
            continue;
          }

          if(player.team == "team_three") {
            self setclientomnvar("ui_team_before_spectating", 3);
          }
        }
      }
    }
  }
}

function onspectatingmlgcamera() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_mlg_camera");
    selectedcamera = self getmlgselectedcamera();

    if(self iscodcaster() || isDefined(self.pers["codcaster"]) && self.pers["codcaster"]) {
      if(isDefined(selectedcamera)) {
        self setclientomnvar("ui_callout_area_id", -1);
      }
    }
  }
}

function freecamcallback(channel, view) {
  if(channel == "mlg_view_change") {
    scripts\mp\playerlogic::resetuidvarsonspectate();
  }
}

function updatespectatesettings() {
  level endon("game_ended");

  for(index = 0; index < level.players.size; index++) {
    level.players[index] setspectatepermissions();
  }
}

function autoattachtoplayer() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectating_mlg_camera");
  level waittill_any_4("prematch_started", "prematch_done", "start_mode_setup", "infil_started");
  level.lastspectatedplayer = game["lastSpectatedPlayer"];

  for(;;) {
    selectedclientnum = undefined;

    if(!self iscodcaster() || self isspectatingplayer() || self ismlgfreecamenabled() || self ismlgaerialcamenabled()) {
      break;
    }

    if(level.players.size > 1) {
      if(level.currentround > 1 && isDefined(level.lastspectatedplayer)) {
        selectedclientnum = level.lastspectatedplayer;
      } else {
        foreach(entry in level.teamnamelist) {
          aliveplayers = getfriendlyplayers(entry, 1);

          if(aliveplayers.size > 0) {
            selectedclientnum = getlowestclientnum(aliveplayers, 1);
          }
        }
      }

      if(isDefined(selectedclientnum)) {
        self spectateclientnum(selectedclientnum);
        break;
      }
    }

    wait 1;
  }
}

function function_de89a33a1571dd0a() {
  self endon("joined_team");
  self endon("disconnect");
  self.iswatchingcodcasterball = 0;
  self.codcasterballcamfollow = undefined;
  self.spectatingplayerbeforeballcam = undefined;

  for(;;) {
    if(self iscodcaster() && self isspectatingplayer()) {
      player = self getspectatingplayer();

      if(isDefined(player)) {
        level.lastspectatedplayer = player.clientid;
      }

      player namespace_f5675568ccc8acc6::function_20038a4ada38be4d(self);
    }

    wait 0.05;
  }
}

function saveendgamelocals() {
  level waittill("game_ended");
  game["lastSpectatedPlayer"] = level.lastspectatedplayer;
}

function setspectatepermissions(gameended) {
  if(level.gameended && gettime() - level.gameendtime >= 2000 && !istrue(level.postgameexfil)) {
    if(level.teambased) {
      foreach(entry in level.teamnamelist) {
        self allowspectateteam(entry, 0);
      }
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  spectatetype = scripts\mp\tweakables::gettweakablevalue("game", "spectatetype");

  if(getdvarint(@ "hash_e32ebdbb97a1ec4e", 0) == 1) {
    spectatetype = 2;
  }

  if(self iscodcaster()) {
    spectatetype = 2;
  }

  if(istrue(self.inspawncamera) || isDefined(self.setspawnpoint) && scripts\mp\playerlogic::mayspawn()) {
    spectatetype = 0;
  }

  if(istrue(gameended)) {
    spectatetype = 2;
  }

  if(istrue(level.disablespectate)) {
    spectatetype = 0;
  }

  team = self.sessionteam;

  switch (spectatetype) {
    case 0:
      setdisabled();
      break;
    case 1:
      self notify("waitForGameStartSpectate");

      if(team != "spectator" && team != "codcaster") {
        if(level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior") {
          if(team == "allies") {
            self setclientomnvar("ui_team_before_spectating", 1);
          } else if(team == "axis") {
            self setclientomnvar("ui_team_before_spectating", 2);
          } else if(team == "team_three") {
            self setclientomnvar("ui_team_before_spectating", 3);
          }
        }

        setteamorplayeronly(team);
      } else if(isDefined(self.pers["last_team"])) {
        if(level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior") {
          if(self.pers["last_team"] == "allies") {
            self setclientomnvar("ui_team_before_spectating", 1);
          } else if(self.pers["last_team"] == "axis") {
            self setclientomnvar("ui_team_before_spectating", 2);
          } else if(self.pers["last_team"] == "team_three") {
            self setclientomnvar("ui_team_before_spectating", 3);
          }
        }

        team = self.pers["last_team"];
        setteamorplayeronly(team);
      } else if(istrue(level.prematchstarted)) {
        randidx = randomint(level.teamnamelist.size);
        setteamorplayeronly(level.teamnamelist[randidx]);

        if(level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior") {
          self setclientomnvar("ui_team_before_spectating", randidx);
        }
      } else {
        setteamorplayeronly("allies");

        if(level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior") {
          self setclientomnvar("ui_team_before_spectating", 1);
        }

        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      setfreelook(gameended);
      break;
    case 3:
      if(team == "spectator" || team == "codcaster") {
        setfreelook();
      } else {
        setteamorplayeronly(team);
      }

      break;
  }

  if(isDefined(team) && isgameplayteam(team)) {
    if(istrue(level.spectateoverride[team].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(istrue(level.spectateoverride[team].allowenemyspectate)) {
      enemyteams = getenemyteams(team);

      foreach(entry in enemyteams) {
        self allowspectateteam(entry, 1);
      }
    }
  }

  var_929fd4bdfabd747b = privatematch() && scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(getdvarint(@ "hash_f7fccc8ff6925d24", 0) != 0) {
    var_929fd4bdfabd747b = 1;
  }

  if(var_929fd4bdfabd747b && (self.sessionteam == "spectator" || self.sessionteam == "codcaster")) {
    foreach(entry in level.teamnamelist) {
      if(!isgameplayteam(entry)) {
        continue;
      }

      self allowspectateteam(entry, 1);
    }

    updatesessionstate("spectator");
  }
}

function waitforgamestartspectate() {
  self endon("waitForGameStartSpectate");
  self endon("disconnect");
  level waittill("prematch_started");
  thread setspectatepermissions();
}

function setdisabled() {
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  foreach(entry in level.teamnamelist) {
    self allowspectateteam(entry, 0);
  }
}

function setteamorplayeronly(team) {
  self allowspectateteam("freelook", 0);

  if(level.teambased) {
    self allowspectateteam("none", 0);

    foreach(entry in level.teamnamelist) {
      if(team == entry) {
        self allowspectateteam(entry, 1);
        continue;
      }

      self allowspectateteam(entry, 0);
    }

    return;
  }

  self allowspectateteam("none", 1);

  foreach(entry in level.teamnamelist) {
    self allowspectateteam(entry, 1);
  }
}

function setfreelook(gameended) {
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(entry in level.teamnamelist) {
      self allowspectateteam(entry, 1);
    }

    if(istrue(gameended)) {
      thread scripts\mp\playerlogic::spawnspectator(undefined, undefined, 1);
    }

    return;
  }

  if(self iscodcaster()) {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    thread waitforgamestartspectate();
    return;
  }

  team = self.sessionteam;

  if(self == level.players[0] || team == "spectator" || team == "codcaster") {
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 0);
    thread waitforgamestartspectate();
  }
}