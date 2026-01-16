/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\warzone_fixup.csc
*************************************************/

#include scripts\mp_common\item_world_fixup;

#namespace warzone_fixup;

autoexec __init__() {
  waitframe(1);
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

  switch (maxteamplayers) {
    case 1:
      function_d0dc6619();
      break;
    case 2:
      function_f16631fc();
      break;
    case 4:
    default:
      function_91d1fd09();
      break;
  }

  function_4305a789();
  function_c94723bd();
}

private function_4305a789() {
  function_9b8d4d02(1);
}

private function_c94723bd() {
  var_d1d7eefb = isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0;

  if(!var_d1d7eefb) {
    function_9b8d4d02();
  }

  if(!(isDefined(getgametypesetting(#"hash_1d02e28ba907a343")) ? getgametypesetting(#"hash_1d02e28ba907a343") : 0)) {
    item_world_fixup::function_96ff7b88(#"perk_item_bloody_tracker");
    item_world_fixup::remove_item(#"perk_item_bloody_tracker");
  }
}

private function_9b8d4d02(prematch = 0) {
  var_3a1737b4 = getscriptbundles(#"itemspawnentry");

  foreach(var_1461de43, var_28f8f6a9 in var_3a1737b4) {
    if(var_28f8f6a9.itemtype == #"quest") {
      if(prematch) {
        item_world_fixup::function_96ff7b88(var_1461de43);
        continue;
      }

      item_world_fixup::remove_item(var_1461de43);
    }
  }
}

private function_d0dc6619() {
  item_world_fixup::function_96ff7b88(#"perk_item_squadlink");
  item_world_fixup::remove_item(#"perk_item_squadlink");
}

private function_f16631fc() {}

private function_91d1fd09() {}