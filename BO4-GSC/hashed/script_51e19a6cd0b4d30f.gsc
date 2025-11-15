/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_51e19a6cd0b4d30f.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace namespace_1e38a8f6;

init() {
  registerclientfield("toplayer", "RGB_keyboard_manager", 1, 3, "int");

  if(function_8b1a219a() && getdvarint(#"hash_cca6902a7ce5273", 0) == 1) {
    callback::on_game_playing(&function_ca0a1ea4);
  }

  if(function_8b1a219a() && sessionmodeiszombiesgame() && util::get_game_type() == "ztutorial") {
    thread function_8431fef6();
  }
}

function_ca0a1ea4() {
  if(level.console) {
    return;
  }

  level waittill(#"player_spawned");

  if(sessionmodeismultiplayergame()) {
    thread function_9e94a567();
  }
}

function_9e94a567() {
  while(!(isDefined(level.gameended) && level.gameended)) {
    wait 0.5;
    score = 0;
    winning_teams = [];

    if(!isDefined(level.teams)) {
      continue;
    }

    foreach(team, _ in level.teams) {
      team_score = game.stat[#"teamscores"][team];

      if(team_score > score) {
        score = team_score;
        winning_teams = [];
      }

      if(team_score == score) {
        winning_teams[winning_teams.size] = team;
      }
    }

    if(winning_teams.size != 1) {
      event = 1;
    } else if(winning_teams[0] == "allies") {
      event = 2;
    } else if(winning_teams[0] == "axis") {
      event = 3;
    }

    foreach(player in level.players) {
      player clientfield::set_to_player("RGB_keyboard_manager", event);
    }
  }
}

function_8431fef6() {
  level endon(#"game_ended");
  level waittill(#"hash_7d7ad8f95ddcdcbd");
  player = getplayers()[0];
  player clientfield::set_to_player("RGB_keyboard_manager", 4);
}