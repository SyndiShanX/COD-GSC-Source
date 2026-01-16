/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\infection.csc
***********************************************/

#include scripts\core_common\system_shared;

#namespace infection;

autoexec __init__system__() {
  system::register(#"infection", &__init__, undefined, undefined);
}

__init__() {}

function_74650d7() {
  if(isDefined(getgametypesetting("infectionMode")) && getgametypesetting("infectionMode")) {
    return true;
  }

  return false;
}