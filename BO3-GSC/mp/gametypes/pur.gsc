/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\pur.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_defaults;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace pur;

function main() {
  globallogic::init();
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 10);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.cumulativeroundscores = getgametypesetting("cumulativeRoundScores");
  level.teambased = 1;
  level.onstartgametype = & onstartgametype;
  level.onspawnplayer = & onspawnplayer;
  level.onroundendgame = & onroundendgame;
  level.onroundswitch = & onroundswitch;
  level.ondeadevent = & ondeadevent;
  level.onlastteamaliveevent = & onlastteamaliveevent;
  level.onalivecountchange = & onalivecountchange;
  level.spawnmessage = & pur_spawnmessage;
  level.onspawnspectator = & onspawnspectator;
  level.onrespawndelay = & getrespawndelay;
  gameobjects::register_allowed_gameobject("tdm");
  game["dialog"]["gametype"] = "tdm_start";
  game["dialog"]["gametype_hardcore"] = "hctdm_start";
  game["dialog"]["offense_obj"] = "generic_boost";
  game["dialog"]["defense_obj"] = "generic_boost";
  game["dialog"]["sudden_death"] = "generic_boost";
  globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "kdratio", "assists");
}

function onstartgametype() {
  setclientnamemode("auto_change");
  if(!isdefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    util::setobjectivetext(team, & "OBJECTIVES_TDM");
    util::setobjectivehinttext(team, & "OBJECTIVES_TDM_HINT");
    if(level.splitscreen) {
      util::setobjectivescoretext(team, & "OBJECTIVES_TDM");
    } else {
      util::setobjectivescoretext(team, & "OBJECTIVES_TDM_SCORE");
    }
    spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
    spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
  }
  spawning::updateallspawnpoints();
  level.spawn_start = [];
  foreach(team in level.teams) {
    level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
  }
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.displayroundendtext = 0;
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }
}

function waitthenspawn() {
  while (self.sessionstate == "dead") {
    wait(0.05);
  }
}

function onspawnplayer(predictedspawn) {
  self endon("disconnect");
  level endon("end_game");
  self.usingobj = undefined;
  self initplayerhud();
  self waitthenspawn();
  self util::clearlowermessage();
  spawning::onspawnplayer(predictedspawn);
}

function pur_endgamewithkillcam(winningteam, endreasontext) {
  thread globallogic::endgame(winningteam, endreasontext);
}

function onalivecountchange(team) {
  level thread updatequeuemessage(team);
}

function onlastteamaliveevent(team) {
  if(level.multiteam) {
    pur_endgamewithkillcam(team, & "MP_ALL_TEAMS_ELIMINATED");
  } else {
    if(team == game["attackers"]) {
      pur_endgamewithkillcam(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
    } else if(team == game["defenders"]) {
      pur_endgamewithkillcam(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
    }
  }
}

function ondeadevent(team) {
  if(team == "all") {
    pur_endgamewithkillcam("tie", game["strings"]["round_draw"]);
  }
}

function onendgame(winningteam) {
  if(isdefined(winningteam) && isdefined(level.teams[winningteam])) {
    globallogic_score::giveteamscoreforobjective(winningteam, 1);
  }
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
  if(level.scoreroundwinbased) {
    foreach(team in level.teams) {
      [
        [level._setteamscore]
      ](team, game["roundswon"][team]);
    }
  }
}

function onroundendgame(roundwinner) {
  if(level.scoreroundwinbased) {
    foreach(team in level.teams) {
      [
        [level._setteamscore]
      ](team, game["roundswon"][team]);
    }
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
  } else {
    winner = globallogic::determineteamwinnerbyteamscore();
  }
  return winner;
}

function onscoreclosemusic() {
  teamscores = [];
  while (!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    topscore = 0;
    runnerupscore = 0;
    foreach(team in level.teams) {
      score = [
        [level._getteamscore]
      ](team);
      if(score > topscore) {
        runnerupscore = topscore;
        topscore = score;
        continue;
      }
      if(score > runnerupscore) {
        runnerupscore = score;
      }
    }
    scoredif = topscore - runnerupscore;
    if(scoredif <= scorethreshold && scorethresholdstart <= topscore) {
      thread globallogic_audio::set_music_on_team("timeOut");
      return;
    }
    wait(1);
  }
}

function initpurgatoryenemycountelem(team, y_pos) {
  self.purpurgatorycountelem[team] = newclienthudelem(self);
  self.purpurgatorycountelem[team].fontscale = 1.25;
  self.purpurgatorycountelem[team].x = 110;
  self.purpurgatorycountelem[team].y = y_pos;
  self.purpurgatorycountelem[team].alignx = "right";
  self.purpurgatorycountelem[team].aligny = "top";
  self.purpurgatorycountelem[team].horzalign = "left";
  self.purpurgatorycountelem[team].vertalign = "top";
  self.purpurgatorycountelem[team].foreground = 1;
  self.purpurgatorycountelem[team].hidewhendead = 0;
  self.purpurgatorycountelem[team].hidewheninmenu = 1;
  self.purpurgatorycountelem[team].archived = 0;
  self.purpurgatorycountelem[team].alpha = 1;
  self.purpurgatorycountelem[team].label = & "MP_PURGATORY_ENEMY_COUNT";
}

function initplayerhud() {
  if(isdefined(self.purpurgatorycountelem)) {
    if(self.pers["team"] == self.purhudteam) {
      return;
    }
    foreach(elem in self.purpurgatorycountelem) {
      elem destroy();
    }
  }
  self.purpurgatorycountelem = [];
  y_pos = 115;
  y_inc = 15;
  team = self.pers["team"];
  self.purhudteam = team;
  self.purpurgatorycountelem[team] = newclienthudelem(self);
  self.purpurgatorycountelem[team].fontscale = 1.25;
  self.purpurgatorycountelem[team].x = 110;
  self.purpurgatorycountelem[team].y = y_pos;
  self.purpurgatorycountelem[team].alignx = "right";
  self.purpurgatorycountelem[team].aligny = "top";
  self.purpurgatorycountelem[team].horzalign = "left";
  self.purpurgatorycountelem[team].vertalign = "top";
  self.purpurgatorycountelem[team].foreground = 1;
  self.purpurgatorycountelem[team].hidewhendead = 0;
  self.purpurgatorycountelem[team].hidewheninmenu = 1;
  self.purpurgatorycountelem[team].archived = 0;
  self.purpurgatorycountelem[team].alpha = 1;
  self.purpurgatorycountelem[team].label = & "MP_PURGATORY_TEAMMATE_COUNT";
  foreach(team in level.teams) {
    if(team == self.team) {
      continue;
    }
    y_pos = y_pos + y_inc;
    initpurgatoryenemycountelem(team, y_pos);
  }
  self thread hideplayerhudongameend();
  self thread updateplayerhud();
}

function updateplayerhud() {
  self endon("disconnect");
  level endon("end_game");
  while (true) {
    if(self.team != "spectator") {
      self.purpurgatorycountelem[self.team] setvalue(level.deadplayers[self.team].size);
      foreach(team in level.teams) {
        if(self.team == team) {
          continue;
        }
        self.purpurgatorycountelem[team] setvalue(level.alivecount[team]);
      }
    }
    wait(0.25);
  }
}

function hideplayerhudongameend() {
  level waittill("game_ended");
  foreach(elem in self.purpurgatorycountelem) {
    elem.alpha = 0;
  }
}

function displayspawnmessage() {
  if(self.waitingtospawn) {
    return;
  }
  if(self.name == "TolucaLake") {
    shit = 0;
  }
  if(self.spawnqueueindex != 0) {
    self util::setlowermessagevalue(&"MP_PURGATORY_QUEUE_POSITION", self.spawnqueueindex + 1, 1);
  } else {
    self util::setlowermessagevalue(&"MP_PURGATORY_NEXT_SPAWN", undefined, 0);
  }
}

function pur_spawnmessage() {
  util::waittillslowprocessallowed();
}

function onspawnspectator(origin, angles) {
  self displayspawnmessage();
  globallogic_defaults::default_onspawnspectator(origin, angles);
}

function updatequeuemessage(team) {
  self notify("updatequeuemessage");
  self endon("updatequeuemessage");
  util::waittillslowprocessallowed();
  players = level.deadplayers[team];
  for (i = 0; i < players.size; i++) {
    player = players[i];
    if(!player.waitingtospawn && player.sessionstate != "dead" && !isdefined(player.killcam)) {
      player displayspawnmessage();
    }
  }
}

function getrespawndelay() {
  self.lowermessageoverride = undefined;
  return level.playerrespawndelay;
}