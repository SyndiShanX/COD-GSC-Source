/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_6443733befc58658.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\mp_common\item_world_util;

#namespace namespace_3b8b8298;

autoexec __init__system__() {
  system::register(#"hash_4fb1e186fac435f4", &__init__, undefined, undefined);
}

__init__() {
  level.var_cee10b49 = [];
  callback::on_localclient_connect(&on_localclient_connect);
}

private on_localclient_connect(localclientnum) {
  if(isDefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising")) {
    level thread function_53d906fd(localclientnum);
  }
}

private function_53d906fd(localclientnum) {
  level endon(#"game_ended");

  while(true) {
    player = function_5c10bd79(localclientnum);
    show_fx = level clientfield::get("showSpectreSwordBeams");

    if(isDefined(level.var_5b2a8d88) && isDefined(player)) {
      foreach(i, playfx in level.var_5b2a8d88) {
        if(show_fx) {
          if(item_world_util::function_2c7fc531(i)) {
            point = function_b1702735(i);

            if(isDefined(point) && isDefined(point.itementry) && point.itementry.name === #"sig_blade_wz_item") {
              point function_6b5dfd6c(localclientnum, playfx, 0, i, player);
            } else {
              level function_6b5dfd6c(localclientnum, 0, 0, i, player);
            }
          } else if(item_world_util::function_da09de95(i)) {
            if(isDefined(level.item_spawn_drops[i]) && isDefined(level.item_spawn_drops[i].itementry) && level.item_spawn_drops[i].itementry.name === #"sig_blade_wz_item") {
              level.item_spawn_drops[i] function_6b5dfd6c(localclientnum, playfx, 1, i);
            } else {
              level function_6b5dfd6c(localclientnum, 0, 1, i, player);
            }
          }

          continue;
        }

        level function_6b5dfd6c(localclientnum, 0, 0, i, player);
      }
    }

    wait 0.2;
  }
}

function_6b5dfd6c(localclientnum, playfx, var_484cae2, id, player) {
  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(player.var_c1c8ef9c)) {
    player.var_c1c8ef9c = [];
  }

  if(playfx) {
    if(!isDefined(player.var_c1c8ef9c[id])) {
      player.var_c1c8ef9c[id] = {
        #var_9d888717: 0, 
        #fx_id: 0, 
        #fxent: undefined
      };

      if(var_484cae2) {
        player.var_c1c8ef9c[id].var_9d888717 = 1;
        player.var_c1c8ef9c[id].fxent = spawn(localclientnum, self.origin, "script_model");
        player.var_c1c8ef9c[id].fxent setModel("tag_origin");
        player.var_c1c8ef9c[id].fxent linkto(self);
        player.var_c1c8ef9c[id].fx_id = function_239993de(localclientnum, #"hash_3235e29f5bf57d5a", player.var_c1c8ef9c[id].fxent, "tag_origin");
      } else {
        player.var_c1c8ef9c[id].var_9d888717 = 1;
        player.var_c1c8ef9c[id].fx_id = playFX(localclientnum, #"hash_3235e29f5bf57d5a", self.origin);
      }
    } else if(!(isDefined(player.var_c1c8ef9c[id].var_9d888717) && player.var_c1c8ef9c[id].var_9d888717)) {
      if(var_484cae2) {
        player.var_c1c8ef9c[id].var_9d888717 = 1;
        player.var_c1c8ef9c[id].fxent = spawn(localclientnum, self.origin, "script_model");
        player.var_c1c8ef9c[id].fxent setModel("tag_origin");
        player.var_c1c8ef9c[id].fxent linkto(self);
        player.var_c1c8ef9c[id].fx_id = function_239993de(localclientnum, #"hash_3235e29f5bf57d5a", player.var_c1c8ef9c[id].fxent, "tag_origin");
      } else {
        player.var_c1c8ef9c[id].var_9d888717 = 1;
        player.var_c1c8ef9c[id].fx_id = playFX(localclientnum, #"hash_3235e29f5bf57d5a", self.origin);
      }
    }

    return;
  }

  if(isDefined(player.var_c1c8ef9c[id]) && isDefined(player.var_c1c8ef9c[id].fx_id)) {
    stopfx(localclientnum, player.var_c1c8ef9c[id].fx_id);

    if(isDefined(player.var_c1c8ef9c[id].fxent)) {
      player.var_c1c8ef9c[id].fxent delete();
    }

    player.var_c1c8ef9c[id] = undefined;
  }
}