/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\conf.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_dogtags;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#namespace conf;

function main() {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundswitch(0, 9);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = 1;
  level.teambased = 1;
  level.onprecachegametype = & onprecachegametype;
  level.onstartgametype = & onstartgametype;
  level.onspawnplayer = & onspawnplayer;
  level.onroundendgame = & onroundendgame;
  level.onplayerkilled = & onplayerkilled;
  level.onroundswitch = & onroundswitch;
  level.determinewinner = & determinewinner;
  level.overrideteamscore = 1;
  level.teamscoreperkill = getgametypesetting("teamScorePerKill");
  level.teamscoreperkillconfirmed = getgametypesetting("teamScorePerKillConfirmed");
  level.teamscoreperkilldenied = getgametypesetting("teamScorePerKillDenied");
  gameobjects::register_allowed_gameobject(level.gametype);
  globallogic_audio::set_leader_gametype_dialog("startKillConfirmed", "hcCtartKillConfirmed", "gameBoost", "gameBoost");
  if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "killsconfirmed", "killsdenied", "deaths");
  } else {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "killsconfirmed", "killsdenied");
  }
}

function onprecachegametype() {}

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
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    util::setobjectivetext(team, & "OBJECTIVES_CONF");
    util::setobjectivehinttext(team, & "OBJECTIVES_CONF_HINT");
    if(level.splitscreen) {
      util::setobjectivescoretext(team, & "OBJECTIVES_CONF");
    } else {
      util::setobjectivescoretext(team, & "OBJECTIVES_CONF_SCORE");
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
  dogtags::init();
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isplayer(attacker) || attacker.team == self.team) {
    return;
  }
  level thread dogtags::spawn_dog_tag(self, attacker, & onuse, 1);
  if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
  }
}

function onuse(player) {
  tacinsertboost = 0;
  if(player.team != self.attackerteam) {
    tacinsertboost = self.tacinsert;
    if(isdefined(self.attacker) && self.attacker.team == self.attackerteam) {
      self.attacker luinotifyevent(&"player_callout", 2, & "MP_KILL_DENIED", player.entnum);
    }
    if(!tacinsertboost) {
      player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
    }
  } else {
    assert(isdefined(player.lastkillconfirmedtime));
    assert(isdefined(player.lastkillconfirmedcount));
    /#
    player.pers["killsconfirmed"]++;
    player.killsconfirmed = player.pers["killsconfirmed"];
    player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);
  }
  if(!tacinsertboost) {
    currenttime = gettime();
    if((player.lastkillconfirmedtime + 1000) > currenttime) {
      player.lastkillconfirmedcount++;
      if(player.lastkillconfirmedcount >= 3) {
        scoreevents::processscoreevent("kill_confirmed_multi", player);
        player.lastkillconfirmedcount = 0;
      }
    } else {
      player.lastkillconfirmedcount = 1;
    }
    player.lastkillconfirmedtime = currenttime;
  }
}

function onspawnplayer(predictedspawn) {
  self.usingobj = undefined;
  if(level.usestartspawns && !level.ingraceperiod) {
    level.usestartspawns = 0;
  }
  self.lastkillconfirmedtime = 0;
  self.lastkillconfirmedcount = 0;
  spawning::onspawnplayer(predictedspawn);
  dogtags::on_spawn_player();
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
}

function determinewinner() {
  return globallogic::determineteamwinnerbygamestat("roundswon");
}

function onroundendgame(roundwinner) {
  return globallogic::determineteamwinnerbygamestat("roundswon");
}