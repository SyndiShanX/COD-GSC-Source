/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_51e19a6cd0b4d30f.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_1e38a8f6;

function init() {
  registerclientfield("toplayer", "RGB_keyboard_manager", 1, 3, "int");
  callback::on_game_playing(&function_ca0a1ea4);
}

function function_ca0a1ea4() {
  level waittill(#"player_spawned");

  if(sessionmodeismultiplayergame()) {
    thread function_9e94a567();
  }
}

function function_9e94a567() {
  while(!is_true(level.gameended)) {
    wait 0.5;

    if(!isDefined(level.teams)) {
      continue;
    }

    if(level.teams.size > 2) {
      continue;
    }

    score = 0;
    winning_teams = [];

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

    if(!isint(event)) {
      continue;
    }

    foreach(player in level.players) {
      if(player function_8b1a219a()) {
        player clientfield::set_to_player("RGB_keyboard_manager", event);
      }
    }
  }
}