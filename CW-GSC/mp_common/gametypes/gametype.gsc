/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gametype.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#namespace gametype;

function init_mp() {
  if(!isDefined(level.var_d1455682)) {
    level.var_d1455682 = function_302bd0b9();
  }

  if(!isDefined(level.var_d1455682)) {
    return;
  }

  level.teambased = isgametypeteambased();
  globallogic_audio::set_leader_gametype_dialog(level.var_d1455682.var_ef0e6936, level.var_d1455682.var_92ea240c, level.var_d1455682.var_39d466bc, level.var_d1455682.var_fd58840f, level.var_d1455682.var_39f24ab5, level.var_d1455682.var_a254e69e);

  if(!isDefined(game.switchedsides)) {
    game.switchedsides = 0;
  }

  level.onroundswitch = &on_round_switch;
}

function on_start_game_type() {
  bundle = level.var_d1455682;

  if(!isDefined(bundle)) {
    return;
  }

  function_f2f4dfa7();

  if(level.teambased) {
    spawning::function_b4f071cd();
  }

  util::function_9540d9b6();

  if(!util::isoneround() && level.scoreroundwinbased) {
    globallogic_score::resetteamscores();
  }
}

function on_round_switch() {
  bundle = level.var_d1455682;

  if(!isDefined(bundle)) {
    return;
  }

  if(is_true(level.var_d1455682.switchsides)) {
    game.switchedsides = !game.switchedsides;
    userspawnselection::onroundchange();
  }
}

function function_f2f4dfa7() {
  if(is_true(level.var_d1455682.switchsides) && game.switchedsides) {
    util::set_team_mapping(game.defenders, game.attackers);
  } else {
    util::set_team_mapping(game.attackers, game.defenders);
  }

  level flag::set(#"hash_22ca95de91eb92b");
}