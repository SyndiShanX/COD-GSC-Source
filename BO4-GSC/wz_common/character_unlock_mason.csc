/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_mason.csc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_mason;

autoexec __init__system__() {
  system::register(#"character_unlock_mason", &__init__, undefined, #"character_unlock_mason_fixup");
}

__init__() {
  clientfield::register("world", "array_broadcast", 1, 1, "int", undefined, 1, 0);
  clientfield::register("toplayer", "array_effects", 1, 1, "int", undefined, 0, 1);
  character_unlock_fixup::function_90ee7a97(#"mason_unlock", &function_2613aeec);
  callback::on_localclient_connect(&on_localclient_connect);
}

function_2613aeec(enabled) {
  if(enabled) {
    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"wz_escape_supply_stash_parent", #"supply_stash_cu19", 1);
      return;
    }

    item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_cu19", 6);
  }
}

on_localclient_connect(localclientnum) {
  var_2fcdec4f = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_20f3ff8fbb8d8295")) ? getgametypesetting(#"hash_20f3ff8fbb8d8295") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);

  if(var_2fcdec4f) {
    level thread function_6a0a79cf(localclientnum);
  }
}

private function_6a0a79cf(localclientnum) {
  var_d5823792 = 0;
  var_b9d612e8 = 0;
  var_a106daf5 = 0;

  while(true) {
    local_player = function_5c10bd79(localclientnum);

    if(isDefined(local_player)) {
      if(!local_player hasdobj(localclientnum)) {
        waitframe(1);
        continue;
      }
    }

    if(isDefined(local_player)) {
      array_effects = local_player clientfield::get_to_player("array_effects");

      if(array_effects === 1 && !var_d5823792) {
        var_d5823792 = 1;
        var_b9d612e8 = playfxoncamera(localclientnum, "wz/fx8_plyr_pstfx_numbers", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        var_a106daf5 = function_239993de(localclientnum, "wz/fx8_plyr_numbers", local_player, "tag_origin");
      } else if(array_effects === 0 && var_d5823792) {
        var_d5823792 = 0;
        stopfx(localclientnum, var_b9d612e8);
        stopfx(localclientnum, var_a106daf5);
      }
    } else {
      return;
    }

    waitframe(1);
  }
}