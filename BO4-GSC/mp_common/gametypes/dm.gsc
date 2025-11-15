/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dm.gsc
***********************************************/

#include scripts\core_common\spawning_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;

#namespace dm;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
  level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
  level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
  level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
  level.onstartgametype = &onstartgametype;
  player::function_cf3aa03d(&onplayerkilled);
  level.onspawnplayer = &onspawnplayer;
  level.onendgame = &onendgame;
  level.var_cdb8ae2c = &function_a8da260c;
  globallogic_spawn::addsupportedspawnpointtype("ffa");
  globallogic_audio::set_leader_gametype_dialog("startFreeForAll", "hcStartFreeForAll", "gameBoost", "gameBoost", "bbStartFreeForAll", "hcbbStartFreeForAll");

  if(util::function_8570168d()) {
    level.is_dm = 1;
    ct_tutorial_skirmish::init();
  }
}

function_a8da260c() {
  foreach(team, _ in level.teams) {
    spawning::add_spawn_points(team, "mp_dm_spawn");
  }

  spawning::place_spawn_points("mp_dm_spawn_start");
  spawning::updateallspawnpoints();
}

setupteam(team) {}

onstartgametype() {
  level.displayroundendtext = 0;
  level thread onscoreclosemusic();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }

  globallogic_spawn::addspawns();
}

onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();

  if(isDefined(player)) {
    [[level._setplayerscore]](player, [[level._getplayerscore]](player) + 1);
  }

  match::set_winner(player);
}

onscoreclosemusic() {
  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.9;

    for(i = 0; i < level.players.size; i++) {
      scorecheck = [
        [level._getplayerscore]
      ](level.players[i]);

      if(scorecheck >= scorethreshold) {
        return;
      }
    }

    wait 0.5;
  }
}

onspawnplayer(predictedspawn) {
  if(!level.inprematchperiod) {
    level.usestartspawns = 0;
  }

  spawning::onspawnplayer(predictedspawn);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isplayer(attacker) || self == attacker) {
    return;
  }

  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
    attacker globallogic_score::givepointstowin(level.teamscoreperkill);
    self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker globallogic_score::givepointstowin(level.teamscoreperheadshot);
    }
  }
}