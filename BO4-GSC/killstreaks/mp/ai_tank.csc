/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ai_tank.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\killstreaks\ai_tank_shared;

#namespace ai_tank;

autoexec __init__system__() {
  system::register(#"ai_tank", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
}