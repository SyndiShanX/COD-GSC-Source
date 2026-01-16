/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_snowball_fx.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace wz_snowball_fx;

autoexec __init__system__() {
  system::register(#"wz_snowball_fx", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "player_hit_freezing_snowball", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "player_hit_snowball_direction", 9000, 4, "int", undefined, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

on_localclient_connect(localclientnum) {
  if(isDefined(getgametypesetting(#"wzsnowballsenabled")) ? getgametypesetting(#"wzsnowballsenabled") : 0) {
    level thread function_b6992be(localclientnum);
  }
}

function_b6992be(localclientnum) {
  var_d5823792 = 0;

  while(true) {
    local_player = function_5c10bd79(localclientnum);

    if(isDefined(local_player)) {
      var_965f0bef = local_player clientfield::get_to_player("player_hit_freezing_snowball");

      if(var_965f0bef === 1 && !var_d5823792) {
        var_d5823792 = 1;
        function_a837926b(localclientnum, #"pstfx_wz_snowball_hit");
        waitframe(1);

        if(!isDefined(local_player)) {
          return;
        }

        var_494e2f9b = local_player clientfield::get_to_player("player_hit_snowball_direction");

        switch (var_494e2f9b) {
          case 1:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 0);
            break;
          case 2:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 0);
            break;
          case 3:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 0);
            break;
          case 4:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", -1);
            break;
          case 5:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 0);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 1);
            break;
          case 6:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", -1);
            break;
          case 8:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", -1);
            break;
          case 9:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", -1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 1);
            break;
          case 10:
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position x", 1);
            local_player postfx::function_c8b5f318(#"pstfx_wz_snowball_hit", #"screen position y", 1);
            break;
        }
      } else if(var_965f0bef === 0 && var_d5823792) {
        var_d5823792 = 0;
        function_24cd4cfb(localclientnum, #"pstfx_wz_snowball_hit");
      }
    } else {
      return;
    }

    waitframe(1);
  }
}