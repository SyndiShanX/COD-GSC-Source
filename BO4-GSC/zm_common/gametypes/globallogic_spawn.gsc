/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_spawn.gsc
*****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\gametypes\globallogic;
#include scripts\zm_common\gametypes\globallogic_audio;
#include scripts\zm_common\gametypes\globallogic_defaults;
#include scripts\zm_common\gametypes\globallogic_player;
#include scripts\zm_common\gametypes\globallogic_score;
#include scripts\zm_common\gametypes\globallogic_ui;
#include scripts\zm_common\gametypes\globallogic_utils;
#include scripts\zm_common\gametypes\hostmigration;
#include scripts\zm_common\gametypes\spawning;
#include scripts\zm_common\gametypes\spawnlogic;
#include scripts\zm_common\gametypes\spectating;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_utility;

#namespace globallogic_spawn;

autoexec init() {
  if(!isDefined(level.givestartloadout)) {
    level.givestartloadout = &givestartloadout;
  }
}

timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && !self.hasspawned) {
    return 0;
  }

  respawndelay = 0;

  if(isDefined(self.hasspawned) && self.hasspawned) {
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

allteamshaveexisted() {
  foreach(team, _ in level.teams) {
    if(!level.everexisted[team]) {
      return false;
    }
  }

  return true;
}

mayspawn() {
  if(isDefined(level.playermayspawn) && !self[[level.playermayspawn]]()) {
    return false;
  }

  if(level.inovertime) {
    return false;
  }

  if(level.playerqueuedrespawn && !isDefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
    return false;
  }

  if(level.numlives) {
    if(level.teambased) {
      gamehasstarted = allteamshaveexisted();
    } else {
      gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
    }

    if(!self.pers[#"lives"] && gamehasstarted) {
      return false;
    } else if(gamehasstarted) {
      if(!level.ingraceperiod && !self.hasspawned && !isbot(self)) {
        return false;
      }
    }
  }

  return true;
}

timeuntilwavespawn(minimumwait) {
  earliestspawntime = gettime() + minimumwait * 1000;
  lastwavetime = level.lastwave[self.pers[#"team"]];
  wavedelay = level.wavedelay[self.pers[#"team"]] * 1000;

  if(wavedelay == 0) {
    return 0;
  }

  numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
  numwaves = ceil(numwavespassedearliestspawntime);
  timeofspawn = lastwavetime + numwaves * wavedelay;

  if(isDefined(self.wavespawnindex)) {
    timeofspawn += 50 * self.wavespawnindex;
  }

  return (timeofspawn - gettime()) / 1000;
}

stoppoisoningandflareonspawn() {
  self endon(#"disconnect");
  self.inpoisonarea = 0;
  self.inburnarea = 0;
  self.inflarevisionarea = 0;
  self.ingroundnapalm = 0;
}

spawnplayerprediction() {
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

giveloadoutlevelspecific(team, _class) {
  pixbeginevent(#"giveloadoutlevelspecific");

  if(isDefined(level.givestartloadout)) {
    self[[level.givestartloadout]]();
  }

  self flagsys::set(#"loadout_given");
  callback::callback(#"on_loadout");
  pixendevent();
}

givestartloadout() {
  if(isDefined(level.givecustomloadout)) {
    self[[level.givecustomloadout]]();
  }
}

spawnplayer() {
  pixbeginevent(#"spawnplayer_preuts");
  self endon(#"disconnect", #"joined_spectators");
  hadspawned = self.hasspawned;
  self player::spawn_player();

  if(isDefined(self.hasspawned) && !self.hasspawned) {
    self.underscorechance = 70;
  }

  self.laststand = undefined;
  self.revivingteammate = 0;
  self.burning = undefined;
  self.nextkillstreakfree = undefined;
  self.activeuavs = 0;
  self.activecounteruavs = 0;
  self.activesatellites = 0;
  self.maxarmor = 100;
  self.deathmachinekills = 0;
  self.diedonvehicle = undefined;

  if(isDefined(self.wasaliveatmatchstart) && !self.wasaliveatmatchstart) {
    if(level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
      self.wasaliveatmatchstart = 1;
    }
  }

  pixbeginevent(#"onspawnplayer");

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
  pixbeginevent(#"spawnplayer_postuts");
  self thread stoppoisoningandflareonspawn();
  assert(globallogic_utils::isvalidclass(self.curclass));
  self giveloadoutlevelspecific(self.team, self.curclass);

  if(level.inprematchperiod) {
    self val::set(#"prematch_period", "freezecontrols");
    self val::set(#"prematch_period", "disablegadgets");
    self val::set(#"prematch_period", "disable_weapons");
  } else if(!hadspawned && game.state == "playing") {
    pixbeginevent(#"sound");
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
    pixbeginevent(#"showperksonspawn");

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

_spawnplayer() {
  self endon(#"disconnect", #"joined_spectators");
  waittillframeend();
  self notify(#"spawned_player");
  self callback::callback(#"on_player_spawned");

  print("<dev string:x43>" + self.origin[0] + "<dev string:x48>" + self.origin[1] + "<dev string:x48>" + self.origin[2] + "<dev string:x4c>");

    setdvar(#"scr_selecting_location", "");
  self zm_utility::set_max_health();

  if(game.state == "postgame") {
    assert(!level.intermission);
    self globallogic_player::freezeplayerforroundend();
  }

  self util::set_lighting_state();
  self util::set_sun_shadow_split_distance();
}

spawnspectator(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  in_spawnspectator(origin, angles);
}

respawn_asspectator(origin, angles) {
  in_spawnspectator(origin, angles);
}

in_spawnspectator(origin, angles) {
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

spectatorthirdpersonness() {
  self notify(#"spectator_thirdperson_thread");
  self endon(#"disconnect", #"spawned", #"spectator_thirdperson_thread");
  self.spectatingthirdperson = 0;
}

forcespawn(time) {
  self endon(#"death", #"spawned");

  if(!isDefined(time)) {
    time = 60;
  }

  wait time;

  if(isDefined(self.hasspawned) && self.hasspawned) {
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

kickifdontspawn() {

  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

    if(self ishost()) {
      return;
    }

  self kickifidontspawninternal();
}

kickifidontspawninternal() {
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

  if(isDefined(self.hasspawned) && self.hasspawned) {
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

kickwait(waittime) {
  level endon(#"game_ended");
  hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

spawninterroundintermission() {
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

spawnintermission(usedefaultcallback) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();

  if(level.rankedmatch && util::waslastround()) {
    if(self.postgamemilestones || self.postgamecontracts || self.postgamepromotion) {
      if(self.postgamepromotion) {
        self playlocalsound(#"mus_level_up");
      } else if(self.postgamecontracts) {
        self playlocalsound(#"mus_challenge_complete");
      } else if(self.postgamemilestones) {
        self playlocalsound(#"mus_contract_complete");
      }

      self closeingamemenu();
      waittime = 4;

      while(waittime) {
        wait 0.25;
        waittime -= 0.25;
      }
    }
  }

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

spawnqueuedclientonteam(team) {
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

spawnqueuedclient(dead_player_team, killer) {
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

allteamsnearscorelimit() {
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

shouldshowrespawnmessage() {
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

default_spawnmessage() {
  hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
}

showspawnmessage() {
  if(shouldshowrespawnmessage()) {
    self thread[[level.spawnmessage]]();
  }
}

spawnclient(timealreadypassed) {
  pixbeginevent(#"spawnclient");
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

  if(isDefined(self.waitingtospawn) && self.waitingtospawn) {
    pixendevent();
    return;
  }

  self.waitingtospawn = 1;
  self.allowqueuespawn = undefined;
  self waitandspawnclient(timealreadypassed);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }

  pixendevent();
}

waitandspawnclient(timealreadypassed) {
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

      if(isDefined(level.useintermissionpointsonwavespawn) && [
          [level.useintermissionpointsonwavespawn]
        ]() == 1) {
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
  self thread[[level.spawnplayer]]();
  self hud_message::clearlowermessage();
}

waitrespawnorsafespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    if(self usebuttonpressed()) {
      break;
    }

    waitframe(1);
  }
}

waitinspawnqueue() {
  self endon(#"disconnect", #"end_respawn");

  if(!level.ingraceperiod && !level.usestartspawns) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    self waittill(#"queue_respawn");
  }
}

setthirdperson(value) {
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