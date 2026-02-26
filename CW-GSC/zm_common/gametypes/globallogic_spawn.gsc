/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_spawn.gsc
*****************************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_defaults;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\gametypes\spawning;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#namespace globallogic_spawn;

function timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && !self.hasspawned) {
    return 0;
  }

  respawndelay = 0;

  if(is_true(self.hasspawned)) {
    result = self[[level.onrespawndelay]]();

    if(isDefined(result)) {
      respawndelay = result;
    } else {
      respawndelay = level.playerrespawndelay;
    }
  }

  wavebased = level.waverespawndelay > 0;

  if(wavebased) {
    return self timeuntilwavespawn(respawndelay);
  }

  return respawndelay;
}

function allteamshaveexisted() {
  foreach(team, _ in level.teams) {
    if(!level.everexisted[team]) {
      return false;
    }
  }

  return true;
}

function mayspawn() {
  if(isDefined(level.playermayspawn) && !self[[level.playermayspawn]]()) {
    return false;
  }

  if(level.inovertime) {
    return false;
  }

  if(level.playerqueuedrespawn && !isDefined(self.allowqueuespawn) && !level.ingraceperiod && !spawning::usestartspawns()) {
    return false;
  }

  if(level.numlives) {
    if(level.teambased) {
      gamehasstarted = allteamshaveexisted();
    } else {
      gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
    }

    if(!is_true(self.pers[#"lives"]) && gamehasstarted) {
      return false;
    } else if(gamehasstarted) {
      if(!level.ingraceperiod && !self.hasspawned && !isbot(self)) {
        return false;
      }
    }
  }

  return true;
}

function timeuntilwavespawn(minimumwait) {
  earliestspawntime = gettime() + int(minimumwait * 1000);
  lastwavetime = level.lastwave[self.pers[#"team"]];
  wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);

  if(wavedelay == 0) {
    return 0;
  }

  var_a0122c26 = 50;
  var_e0fb0ad5 = var_a0122c26 * (isDefined(self.wavespawnindex) ? self.wavespawnindex : 0);
  elapsed = max(0, earliestspawntime - lastwavetime - var_e0fb0ad5);
  numwavespassedearliestspawntime = elapsed / wavedelay;
  numwaves = ceil(numwavespassedearliestspawntime);
  timeofspawn = lastwavetime + numwaves * wavedelay;

  if(isDefined(self.wavespawnindex)) {
    timeofspawn += var_e0fb0ad5;
  }

  return float(timeofspawn - gettime()) / 1000;
}

function stoppoisoningandflareonspawn() {
  self endon(#"disconnect");
  self.inpoisonarea = 0;
  self.inburnarea = 0;
  self.inflarevisionarea = 0;
  self.ingroundnapalm = 0;
}

function spawnplayerprediction() {
  self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");

  while(true) {
    wait 0.5;

    if(isDefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0) {
      spawning::onspawnplayer_unified(1);
      continue;
    }

    self[[level.onspawnplayer]](1);
  }
}

function spawnplayer() {
  pixbeginevent(#"");
  self endon(#"disconnect", #"joined_spectators");
  hadspawned = self.hasspawned;
  self player::spawn_player();

  if(is_false(self.hasspawned)) {
    self.underscorechance = 70;
  }

  self.laststand = undefined;
  self.revivingteammate = 0;
  self.burning = undefined;
  self.nextkillstreakfree = undefined;
  self.activeuavs = 0;
  self.activecounteruavs = 0;
  self.activesatellites = 0;
  self.deathmachinekills = 0;
  self.diedonvehicle = undefined;

  if(is_false(self.wasaliveatmatchstart)) {
    if(level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
      self.wasaliveatmatchstart = 1;
    }
  }

  pixbeginevent(#"");

  if(isDefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0) {
    self[[level.onspawnplayerunified]]();
  } else {
    self[[level.onspawnplayer]](0);
  }

  if(isDefined(level.playerspawnedcb)) {
    self[[level.playerspawnedcb]]();
  }

  pixendevent();
  pixendevent();
  globallogic::updateteamstatus();
  pixbeginevent(#"");
  self thread stoppoisoningandflareonspawn();
  assert(globallogic_utils::isvalidclass(self.curclass));
  self zm_loadout::give_loadout();

  if(level.inprematchperiod) {
    self val::set(#"prematch_period", "freezecontrols");
    self val::set(#"prematch_period", "disablegadgets");
    self val::set(#"prematch_period", "disable_weapons");
  } else if(!hadspawned && game.state == "playing") {
    pixbeginevent(#"");
    team = self.team;

    if(isDefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
      self.pers[#"music"].spawn = 1;
    }

    if(level.splitscreen) {
      if(isDefined(level.playedstartingmusic)) {
        music = undefined;
      } else {
        level.playedstartingmusic = 1;
      }
    }

    pixendevent();
  }

  if(!level.splitscreen && getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "<dev string:x38>") {
    pixbeginevent(#"");

    if(level.perksenabled == 1) {
      self hud::showperks();
    }

    pixendevent();
  }

  if(isDefined(self.pers[#"momentum"])) {
    self.momentum = self.pers[#"momentum"];
  }

  pixendevent();
  self thread _spawnplayer();
}

function _spawnplayer() {
  self endon(#"disconnect", #"joined_spectators");
  waittillframeend();
  self notify(#"spawned_player");
  self callback::callback(#"on_player_spawned");

  print("<dev string:x58>" + self.origin[0] + "<dev string:x5e>" + self.origin[1] + "<dev string:x5e>" + self.origin[2] + "<dev string:x63>");

  setDvar(#"scr_selecting_location", "");
  self zm_utility::set_max_health();

  if(game.state == "postgame") {
    self globallogic_player::freezeplayerforroundend();
  }

  self util::set_lighting_state();
  self util::set_sun_shadow_split_distance();
}

function spawnspectator(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  in_spawnspectator(origin, angles);
}

function respawn_asspectator(origin, angles) {
  in_spawnspectator(origin, angles);
}

function in_spawnspectator(origin, angles) {
  pixmarker("BEGIN: in_spawnSpectator");
  self player::set_spawn_variables();
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  if(self.pers[#"team"] == "spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }

  spectating::setspectatepermissionsformachine();
  [[level.onspawnspectator]](origin, angles);

  if(level.teambased && !level.splitscreen) {
    self thread spectatorthirdpersonness();
  }

  pixmarker("END: in_spawnSpectator");
}

function spectatorthirdpersonness() {
  self notify(#"spectator_thirdperson_thread");
  self endon(#"disconnect", #"spawned", #"spectator_thirdperson_thread");
  self.spectatingthirdperson = 0;
}

function forcespawn(time) {
  self endon(#"death", #"spawned");

  if(!isDefined(time)) {
    time = 60;
  }

  wait time;

  if(is_true(self.hasspawned)) {
    return;
  }

  if(self.pers[#"team"] == "spectator") {
    return;
  }

  if(!globallogic_utils::isvalidclass(self.pers[#"class"])) {
    self.pers[#"class"] = "CLASS_CUSTOM1";
    self.curclass = self.pers[#"class"];
  }

  self thread[[level.spawnclient]]();
}

function kickifdontspawn() {
  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

  if(self ishost()) {
    return;
  }

  self kickifidontspawninternal();
}

function kickifidontspawninternal() {
  self endon(#"death", #"spawned");
  waittime = 90;

  if(getdvarstring(#"scr_kick_time") != "") {
    waittime = getdvarfloat(#"scr_kick_time", 0);
  }

  mintime = 45;

  if(getdvarstring(#"scr_kick_mintime") != "") {
    mintime = getdvarfloat(#"scr_kick_mintime", 0);
  }

  starttime = gettime();
  kickwait(waittime);
  timepassed = (gettime() - starttime) / 1000;

  if(timepassed < waittime - 0.1 && timepassed < mintime) {
    return;
  }

  if(is_true(self.hasspawned)) {
    return;
  }

  if(sessionmodeisprivate()) {
    return;
  }

  if(self.pers[#"team"] == "spectator") {
    return;
  }

  kick(self getentitynumber());
}

function kickwait(waittime) {
  level endon(#"game_ended");
  hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

function spawninterroundintermission() {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  self globallogic_defaults::default_onspawnintermission();
  self setorigin(self.origin);
  self setplayerangles(self.angles);
  self clientfield::set_to_player("player_dof_settings", 2);
}

function spawnintermission(usedefaultcallback) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();

  if(level.rankedmatch && util::waslastround()) {}

  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  if(isDefined(usedefaultcallback) && usedefaultcallback) {
    globallogic_defaults::default_onspawnintermission();
  } else {
    [[level.onspawnintermission]]();
  }

  if(game.state != "postgame") {
    self clientfield::set_to_player("player_dof_settings", 2);
  }
}

function spawnqueuedclientonteam(team) {
  player_to_spawn = undefined;

  for(i = 0; i < level.deadplayers[team].size; i++) {
    player = level.deadplayers[team][i];

    if(player.waitingtospawn) {
      continue;
    }

    player_to_spawn = player;
    break;
  }

  if(isDefined(player_to_spawn)) {
    player_to_spawn.allowqueuespawn = 1;
    player_to_spawn thread[[level.spawnclient]]();
  }
}

function spawnqueuedclient(dead_player_team, killer) {
  if(!level.playerqueuedrespawn) {
    return;
  }

  util::waittillslowprocessallowed();
  spawn_team = undefined;

  if(isDefined(killer) && isDefined(killer.team) && isDefined(level.teams[killer.team])) {
    spawn_team = killer.team;
  }

  if(isDefined(spawn_team)) {
    spawnqueuedclientonteam(spawn_team);
    return;
  }

  foreach(team, _ in level.teams) {
    if(team == dead_player_team) {
      continue;
    }

    spawnqueuedclientonteam(team);
  }
}

function allteamsnearscorelimit() {
  if(!level.teambased) {
    return false;
  }

  if(level.scorelimit <= 1) {
    return false;
  }

  foreach(team, _ in level.teams) {
    if(!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
      return false;
    }
  }

  return true;
}

function shouldshowrespawnmessage() {
  if(util::waslastround()) {
    return false;
  }

  if(util::isoneround()) {
    return false;
  }

  if(isDefined(level.livesdonotreset) && level.livesdonotreset) {
    return false;
  }

  if(allteamsnearscorelimit()) {
    return false;
  }

  return true;
}

function default_spawnmessage() {
  hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
}

function showspawnmessage() {
  if(shouldshowrespawnmessage()) {
    self thread[[level.spawnmessage]]();
  }
}

function spawnclient(timealreadypassed) {
  pixbeginevent(#"");
  assert(isDefined(self.team));
  assert(globallogic_utils::isvalidclass(self.curclass));

  if(!self mayspawn()) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self showspawnmessage();
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    pixendevent();
    return;
  }

  if(is_true(self.waitingtospawn)) {
    pixendevent();
    return;
  }

  self.waitingtospawn = 1;
  self.allowqueuespawn = undefined;
  pixendevent();
  self waitandspawnclient(timealreadypassed);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }
}

function waitandspawnclient(timealreadypassed) {
  self endon(#"disconnect", #"end_respawn");
  level endon(#"game_ended");

  if(!isDefined(timealreadypassed)) {
    timealreadypassed = 0;
  }

  spawnedasspectator = 0;

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  timeuntilspawn = timeuntilspawn(0);

  if(timeuntilspawn > timealreadypassed) {
    timeuntilspawn -= timealreadypassed;
    timealreadypassed = 0;
  } else {
    timealreadypassed -= timeuntilspawn;
    timeuntilspawn = 0;
  }

  if(timeuntilspawn > 0) {
    if(level.playerqueuedrespawn) {
      hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
    } else {
      hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
    }

    if(!spawnedasspectator) {
      spawnorigin = self.origin + (0, 0, 60);
      spawnangles = self.angles;

      if(isDefined(level.useintermissionpointsonwavespawn) && [[level.useintermissionpointsonwavespawn]]() == 1) {
        spawnpoint = spawnlogic::getrandomintermissionpoint();

        if(isDefined(spawnpoint)) {
          spawnorigin = spawnpoint.origin;
          spawnangles = spawnpoint.angles;
        }
      }

      self thread respawn_asspectator(spawnorigin, spawnangles);
    }

    spawnedasspectator = 1;
    self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");

    if(isDefined(level.var_16918506)) {
      self[[level.var_16918506]]();
    }

    self notify(#"stop_wait_safe_spawn_button");
  }

  wavebased = level.waverespawndelay > 0;

  if(!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn) {
    hud_message::setlowermessage(game.strings[#"press_to_spawn"]);

    if(!spawnedasspectator) {
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;
    self waitrespawnorsafespawnbutton();
  }

  self.waitingtospawn = 0;
  self.wavespawnindex = undefined;
  self.respawntimerstarttime = undefined;

  if(isDefined(level.var_4e1e5411)) {
    if(self[[level.var_4e1e5411]]()) {
      self thread[[level.spawnplayer]]();
    }
  } else {
    self thread[[level.spawnplayer]]();
  }

  self hud_message::clearlowermessage();
}

function waitrespawnorsafespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    if(self useButtonPressed()) {
      break;
    }

    waitframe(1);
  }
}

function waitinspawnqueue() {
  self endon(#"disconnect", #"end_respawn");

  if(!level.ingraceperiod && !spawning::usestartspawns()) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    self waittill(#"queue_respawn");
  }
}

function setthirdperson(value) {
  if(!level.console) {
    return;
  }

  if(!isDefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
    self.spectatingthirdperson = value;

    if(value) {
      self setclientthirdperson(1);
      self clientfield::set_to_player("player_dof_settings", 2);
    } else {
      self setclientthirdperson(0);
      self clientfield::set_to_player("player_dof_settings", 1);
    }

    self resetfov();
  }
}