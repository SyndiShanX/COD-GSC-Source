/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gametype.gsc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\userspawnselection;
#include scripts\mp_common\util;

#namespace gametype;

init() {
  bundle = function_302bd0b9();
  level.var_d1455682 = bundle;
  level.var_812be535 = 0;

  if(!isDefined(bundle)) {
    return;
  }

  level.teambased = isgametypeteambased();
  setvisiblescoreboardcolumns(bundle.scoreboard_1, bundle.scoreboard_2, bundle.scoreboard_3, bundle.scoreboard_4, bundle.scoreboard_5, bundle.var_d4259e74, bundle.var_54dd9ff6, bundle.var_5ee7b40a, bundle.var_6d3350a1, bundle.var_26d52900);
  globallogic_audio::set_leader_gametype_dialog(bundle.var_ef0e6936, bundle.var_92ea240c, bundle.var_39d466bc, bundle.var_fd58840f, "", "");

  if(!isDefined(game.switchedsides)) {
    game.switchedsides = 0;
  }

  level.onroundswitch = &on_round_switch;
}

on_start_game_type() {
  bundle = level.var_d1455682;

  if(!isDefined(bundle)) {
    return;
  }

  function_f2f4dfa7();
  util::function_9540d9b6();

  if(!util::isoneround() && level.scoreroundwinbased) {
    globallogic_score::resetteamscores();
  }
}

on_round_switch() {
  bundle = level.var_d1455682;

  if(!isDefined(bundle)) {
    return;
  }

  if(isDefined(level.var_d1455682.switchsides) && level.var_d1455682.switchsides) {
    game.switchedsides = !game.switchedsides;
    userspawnselection::onroundchange();
  }
}

private function_788fb510(value) {
  if(!isDefined(value)) {
    return "";
  }

  return value;
}

setvisiblescoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10) {
  col1 = function_788fb510(col1);
  col2 = function_788fb510(col2);
  col3 = function_788fb510(col3);
  col4 = function_788fb510(col4);
  col5 = function_788fb510(col5);
  col6 = function_788fb510(col6);
  col7 = function_788fb510(col7);
  col8 = function_788fb510(col8);
  col9 = function_788fb510(col9);
  col10 = function_788fb510(col10);

  if(!level.rankedmatch) {
    setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, "sbtimeplayed", "shotshit", "shotsmissed", "victory");
    return;
  }

  setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);
}

function_f2f4dfa7() {
  if(isDefined(level.var_d1455682.switchsides) && level.var_d1455682.switchsides && game.switchedsides) {
    util::set_team_mapping(game.defenders, game.attackers);
    return;
  }

  util::set_team_mapping(game.attackers, game.defenders);
}