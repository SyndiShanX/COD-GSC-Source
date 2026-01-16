/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\tdm.gsc
***********************************************/

#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreaks;
#include scripts\mp_common\bb;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\dogtags;
#include scripts\mp_common\gametypes\gametype;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\spawning;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;

#namespace tdm;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundscorelimit(0, 10000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
  level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
  level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
  level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
  level.overrideteamscore = 1;
  level.takelivesondeath = 1;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onroundswitch = &onroundswitch;
  level.onendround = &onendround;
  level.var_cdb8ae2c = &function_a8da260c;
  player::function_cf3aa03d(&onplayerkilled);
  globallogic_audio::set_leader_gametype_dialog("startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost", "bbStartTeamDeathmatch", "hcbbStartTeamDeathmatch");
  globallogic_spawn::addsupportedspawnpointtype("tdm");

  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }

  if(getdvarint(#"hash_5795d85dc4b1b0d9", 0)) {
    level.var_49a15413 = getdvarint(#"hash_5795d85dc4b1b0d9", 0);
    level.scoremodifiercallback = &function_f9df98d3;
  }
}

function_a8da260c() {
  foreach(team, _ in level.teams) {
    spawning::add_spawn_points(team, "mp_tdm_spawn");
    spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
  }

  spawning::updateallspawnpoints();
}

onstartgametype() {
  level.displayroundendtext = 0;
  level thread onscoreclosemusic();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;

    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }

  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    level.numlives = 1;
  }

  if(util::function_8570168d()) {
    level.playgadgetready = undefined;
  }
}

onspawnplayer(predictedspawn) {
  self.usingobj = undefined;

  if(level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
    level.usestartspawns = 0;
  }

  spawning::onspawnplayer(predictedspawn);
}

onroundswitch() {
  gametype::on_round_switch();
  globallogic_score::updateteamscorebyroundswon();
}

onendround(var_c1e98979) {
  function_e596b745(var_c1e98979);
}

onscoreclosemusic() {
  teamscores = [];

  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    topscore = 0;
    runnerupscore = 0;

    foreach(team, _ in level.teams) {
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

    if(topscore >= scorelimit * 0.5) {
      level notify(#"sndmusichalfway");
      return;
    }

    wait 1;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(smeansofdeath == "MOD_META") {
    return;
  }

  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    thread dogtags::checkallowspectating();
    should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();

    if(should_spawn_tags) {
      level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
    }
  }

  if(isplayer(attacker) == 0 || attacker.team == self.team) {
    return;
  }

  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
    }
  }
}

function_e596b745(var_c1e98979) {
  gamemodedata = spawnStruct();
  gamemodedata.remainingtime = max(0, globallogic_utils::gettimeremaining());

  switch (var_c1e98979) {
    case 2:
      gamemodedata.wintype = "time_limit_reached";
      break;
    case 3:
      gamemodedata.wintype = "score_limit_reached";
      break;
    case 9:
    case 10:
    default:
      gamemodedata.wintype = "NA";
      break;
  }

  bb::function_bf5cad4e(gamemodedata);
}

function_f9df98d3(type, value) {
  if(type === #"ekia") {
    return (value + level.var_49a15413);
  }

  return value;
}