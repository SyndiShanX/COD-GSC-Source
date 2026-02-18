/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\spawning.gsc
***********************************************/

#using scripts\core_common\util_shared;
#using scripts\mp_common\util;
#namespace spawning;

function getteamstartspawnname(team, spawnpointnamebase) {
  spawn_point_team_name = team;
  spawn_point_team_name = util::function_6f4ff113(team);

  if(level.multiteam) {
    if(team == # "axis") {
      spawn_point_team_name = "team1";
    } else if(team == # "allies") {
      spawn_point_team_name = "team2";
    }

    if(!util::isoneround()) {
      number = int(getsubstr(spawn_point_team_name, 4, 5)) - 1;
      number = (number + game.roundsplayed) % level.teams.size + 1;
      spawn_point_team_name = "team" + number;
    }
  }

  return spawnpointnamebase + "_" + spawn_point_team_name + "_start";
}

function gettdmstartspawnname(team) {
  return getteamstartspawnname(team, "mp_tdm_spawn");
}