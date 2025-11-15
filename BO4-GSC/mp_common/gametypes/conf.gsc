/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\conf.gsc
***********************************************/

#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\dogtags;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\spawning;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;

#namespace conf;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundswitch(0, 9);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  player::function_cf3aa03d(&onplayerkilled);
  level.overrideteamscore = 1;
  level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
  level.teamscoreperkillconfirmed = getgametypesetting(#"teamscoreperkillconfirmed");
  level.teamscoreperkilldenied = getgametypesetting(#"teamscoreperkilldenied");
  level.var_cdb8ae2c = &function_a8da260c;
  globallogic_audio::set_leader_gametype_dialog("startKillConfirmed", "hcStartKillConfirmed", "gameBoost", "gameBoost", "bbStartKillConfirmed", "hcbbStartKillConfirmed");

  if(util::function_8570168d()) {
    level.var_c7494a5d = 1;
    ct_tutorial_skirmish::init();
  }
}

function_a8da260c() {
  foreach(team, _ in level.teams) {
    spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    spawning::add_spawn_points(team, "mp_tdm_spawn");
    spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
  }

  spawning::updateallspawnpoints();
}

onstartgametype() {
  dogtags::init();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isplayer(attacker) || attacker.team == self.team) {
    return;
  }

  level thread dogtags::spawn_dog_tag(self, attacker, &onuse, 1);

  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
  }
}

onuse(player) {
  tacinsertboost = 0;
  player.pers[#"objectives"]++;
  player.objectives = player.pers[#"objectives"];

  if(player.team != self.attackerteam) {
    tacinsertboost = self.tacinsert;

    if(isDefined(self.attacker) && self.attacker.team == self.attackerteam) {
      self.attacker luinotifyevent(#"player_callout", 2, #"mp/kill_denied", player.entnum);
    }

    if(!tacinsertboost) {
      player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
    }

    return;
  }

  assert(isDefined(player.lastkillconfirmedtime));
  assert(isDefined(player.lastkillconfirmedcount));

    player.pers[#"killsconfirmed"]++;
  player.killsconfirmed = player.pers[#"killsconfirmed"];
  player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);

  if(!tacinsertboost) {
    currenttime = gettime();

    if(player.lastkillconfirmedtime + 4000 > currenttime) {
      player.lastkillconfirmedcount++;

      if(player.lastkillconfirmedcount >= 3) {
        scoreevents::processscoreevent(#"kill_confirmed_multi", player, undefined, undefined);
        player.lastkillconfirmedcount = 0;
      }
    } else {
      player.lastkillconfirmedcount = 1;
    }

    player.lastkillconfirmedtime = currenttime;
  }
}

onspawnplayer(predictedspawn) {
  self.usingobj = undefined;

  if(level.usestartspawns && !level.ingraceperiod) {
    level.usestartspawns = 0;
  }

  self.lastkillconfirmedtime = 0;
  self.lastkillconfirmedcount = 0;
  spawning::onspawnplayer(predictedspawn);
  dogtags::on_spawn_player();
}