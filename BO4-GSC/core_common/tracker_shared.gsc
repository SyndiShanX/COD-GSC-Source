/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\tracker_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\globallogic\globallogic_player;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace tracker;

init_shared() {
  register_clientfields();
  level.trackerperk = spawnStruct();
  level.var_c8241070 = &function_c8241070;
  thread function_a7e7bda0();
  level.trackerperk.var_75492b09 = [];
  callback::on_spawned(&onplayerspawned);
}

register_clientfields() {
  clientfield::register("clientuimodel", "huditems.isExposedOnMinimap", 1, 1, "int");
}

onplayerspawned() {
  self clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
}

function_c8241070(player, weapon) {
  if(!isDefined(level.trackerperk.var_75492b09[player.clientid])) {
    level.trackerperk.var_75492b09[player.clientid] = spawnStruct();
  }

  level.trackerperk.var_75492b09[player.clientid].lastfired = gettime();
  level.trackerperk.var_75492b09[player.clientid].var_2e0b3c25 = player.origin;
  level.trackerperk.var_75492b09[player.clientid].var_2672a259 = weapon;
  level.trackerperk.var_75492b09[player.clientid].var_851de005 = player;
  level.trackerperk.var_75492b09[player.clientid].expiretime = gettime() + float(getdvarint(#"hash_6f3f10e68d2fedba", 0)) / 1000;
}

function_43084f6c(player) {
  if(level.teambased) {
    otherteam = util::getotherteam(player.team);

    foreach(var_f53fe24c in getplayers(otherteam)) {
      if(var_f53fe24c function_d210981e(player.origin)) {
        return true;
      }
    }
  } else {
    enemies = getplayers();

    foreach(enemy in enemies) {
      if(enemy == player) {
        continue;
      }

      if(enemy function_d210981e(player.origin)) {
        return true;
      }
    }
  }

  return false;
}

function_2c77961d(player) {
  if(!isDefined(level.trackerperk.var_75492b09[player.clientid])) {
    return false;
  }

  if(gettime() > level.trackerperk.var_75492b09[player.clientid].expiretime) {
    return false;
  }

  return true;
}

function_796e0334(player) {
  if(1 && globallogic_player::function_eddea888(player)) {
    return true;
  }

  if(1 && globallogic_player::function_43084f6c(player)) {
    return true;
  }

  if(1 && function_2c77961d(player)) {
    return true;
  }

  if(1 && globallogic_player::function_ce33e204(player)) {
    return true;
  }

  return false;
}

function_a7e7bda0() {
  if(getgametypesetting(#"hardcoremode")) {
    return;
  }

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!player hasperk(#"specialty_detectedicon")) {
        continue;
      }

      if(function_796e0334(player)) {
        if(!isDefined(player.var_7241f6e3)) {
          player.var_7241f6e3 = gettime() + 100;
        }

        if(player.var_7241f6e3 <= gettime()) {
          player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 1);
          player.var_99811216 = gettime() + 100;
        }

        continue;
      }

      if(isDefined(player.var_99811216) && gettime() > player.var_99811216 && player clientfield::get_player_uimodel("huditems.isExposedOnMinimap")) {
        player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
        player.var_7241f6e3 = undefined;
      }
    }

    wait 0.1;
  }
}