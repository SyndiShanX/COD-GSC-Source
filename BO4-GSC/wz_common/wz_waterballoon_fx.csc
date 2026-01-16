/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_waterballoon_fx.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace wz_waterballoon_fx;

autoexec __init__system__() {
  system::register(#"wz_waterballoon_fx", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "player_hit_water_balloon", 16000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "player_hit_water_balloon_direction", 16000, 4, "int", undefined, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

on_localclient_connect(localclientnum) {
  if((isDefined(getgametypesetting(#"wzwaterballoonsenabled")) ? getgametypesetting(#"wzwaterballoonsenabled") : 0) || (isDefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) ? getgametypesetting(#"hash_3e2d2cf6b1cc6c68") : 0)) {
    level thread function_4433b7ba(localclientnum);
  }
}

function_4433b7ba(localclientnum) {
  var_d5823792 = 0;

  while(true) {
    local_player = function_5c10bd79(localclientnum);

    if(isDefined(local_player)) {
      var_965f0bef = local_player clientfield::get_to_player("player_hit_water_balloon");

      if(var_965f0bef === 1 && !var_d5823792) {
        var_d5823792 = 1;
        function_a837926b(localclientnum, #"hash_7deaa6811d695aea");
        waitframe(1);

        if(!isDefined(local_player)) {
          return;
        }

        var_494e2f9b = local_player clientfield::get_to_player("player_hit_water_balloon_direction");

        switch (var_494e2f9b) {
          case 1:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 0);
            break;
          case 2:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 0);
            break;
          case 3:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 0);
            break;
          case 4:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", -1);
            break;
          case 5:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 1);
            break;
          case 6:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", -1);
            break;
          case 8:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", -1);
            break;
          case 9:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 1);
            break;
          case 10:
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"screen position y", 1);
            break;
        }
      } else if(var_965f0bef === 0 && var_d5823792) {
        var_d5823792 = 0;
        function_24cd4cfb(localclientnum, #"hash_7deaa6811d695aea");
      }
    } else {
      return;
    }

    waitframe(1);
  }
}