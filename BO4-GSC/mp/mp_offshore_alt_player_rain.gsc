/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_offshore_alt_player_rain.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_offshore_alt_player_rain;

autoexec __init__system__() {
  system::register(#"mp_offshore_alt_player_rain", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("toplayer", "toggle_player_rain", 1, 1, "counter");
  callback::on_game_playing(&on_game_playing);
}

__main__() {
  function_182d285c();
}

on_game_playing() {
  level thread function_5d400be9();
}

function_182d285c() {
  level.var_bd14ecc1 = getEntArray("outdoor_rain_trig", "targetname");
}

function_5d400be9() {
  while(true) {
    waitframe(1);

    foreach(player in getplayers()) {
      if(isalive(player) && function_325b468a(player)) {
        if(!(isDefined(player.var_325b468a) && player.var_325b468a)) {
          player.var_325b468a = 1;
          player clientfield::increment_to_player("toggle_player_rain");
        }

        continue;
      }

      if(isDefined(player.var_325b468a) && player.var_325b468a) {
        player.var_325b468a = 0;
        player clientfield::increment_to_player("toggle_player_rain");
      }
    }
  }
}

function_4235c686(player) {
  height = getwaterheight(player.origin);
  player_z = player.origin[2];
  depth = height - player_z;
  var_101b13f6 = depth > 50;
  return var_101b13f6;
}

function_325b468a(player) {
  if(!isalive(player) || function_4235c686(player)) {
    return false;
  } else if(level.var_bd14ecc1.size == 0) {
    return true;
  }

  foreach(var_c54eaae9 in level.var_bd14ecc1) {
    if(isalive(player) && isDefined(var_c54eaae9) && player istouching(var_c54eaae9)) {
      return false;
    }
  }

  return true;
}