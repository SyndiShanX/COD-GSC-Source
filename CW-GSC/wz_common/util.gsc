/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\util.gsc
***********************************************/

#using scripts\core_common\death_circle;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_player;
#namespace util;

function function_8076d591(event, params) {
  if(isDefined(params)) {
    globallogic_audio::leader_dialog(event, params.team);
    return;
  }

  globallogic_audio::leader_dialog(event);
}

function function_de15dc32(killed_player, disconnected_player) {
  player_count = {
    #total: 0, #alive: 0
  };

  foreach(team in level.teams) {
    players = getplayers(team);

    if(players.size == 0) {
      continue;
    }

    var_40073db2 = 0;

    foreach(player in players) {
      if(disconnected_player === player) {
        continue;
      }

      player_count.total++;

      if(isalive(player)) {
        var_40073db2++;
      }
    }

    player_count.alive += var_40073db2;
  }

  return player_count;
}

function function_47851c07() {
  if(game.state != # "playing") {
    return false;
  }

  if(is_true(level.spawnsystem.deathcirclerespawn)) {
    var_3db6ed91 = level.deathcircles.size - 2;

    if(var_3db6ed91 < 0) {
      var_3db6ed91 = 0;
    }

    if((isDefined(level.var_78442886) ? level.var_78442886 : 0) >= var_3db6ed91) {
      return false;
    }

    if(isDefined(level.var_78442886) && isDefined(level.var_245d4af9) && level.var_78442886 >= level.var_245d4af9) {
      return false;
    }
  }

  if(is_true(level.wave_spawn) && (death_circle::function_9956f107() || isDefined(level.var_75db41a7) && gettime() > level.var_75db41a7)) {
    return false;
  }

  return true;
}