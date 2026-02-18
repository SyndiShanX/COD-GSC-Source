/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_ffotd.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;
#namespace zm_ffotd;

function main_start() {}

function main_end() {}

function optimize_for_splitscreen() {
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