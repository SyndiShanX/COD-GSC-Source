/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_ffotd.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\zm_utility;

#namespace zm_ffotd;

main_start() {}

function

optimize_for_splitscreen() {
  if(!isDefined(level.var_58def399)) {
    level.var_58def399 = 3;
  }

  if(level.var_58def399) {
    if(getdvarint(#"splitscreen_playercount", 0) >= level.var_58def399) {
      return true;
    }
  }

  return false;
}