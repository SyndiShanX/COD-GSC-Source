/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dm.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace dm;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  level.onstartgametype = &onstartgametype;
  player::function_cf3aa03d(&onplayerkilled);
  level.onspawnplayer = &onspawnplayer;
  level.onendgame = &onendgame;
  spawning::addsupportedspawnpointtype("ffa");
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
}

function setupteam(team) {}

function onstartgametype() {
  level.displayroundendtext = 0;
  level thread onscoreclosemusic();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }
}

function onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();

  if(isDefined(player)) {
    [[level._setplayerscore]](player, [[level._getplayerscore]](player) + 1);
  }

  match::set_winner(player);
}

function onscoreclosemusic() {
  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.9;

    for(i = 0; i < level.players.size; i++) {
      scorecheck = [[level._getplayerscore]](level.players[i]);

      if(scorecheck >= scorethreshold) {
        return;
      }
    }

    wait 0.5;
  }
}

function onspawnplayer(predictedspawn) {
  if(!level.inprematchperiod) {
    spawning::function_7a87efaa();
  }

  spawning::onspawnplayer(predictedspawn);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isPlayer(shitloc) || self == shitloc) {
    return;
  }

  if(!isDefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
    shitloc globallogic_score::givepointstowin(level.teamscoreperkill);
    self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);

    if(psoffsettime == "MOD_HEAD_SHOT") {
      shitloc globallogic_score::givepointstowin(level.teamscoreperheadshot);
    }
  }
}