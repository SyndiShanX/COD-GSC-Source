/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teamset.csc
***********************************************/

#include scripts\core_common\system_shared;

#namespace teamset;

autoexec __init__system__() {
  system::register(#"teamset_seals", &__init__, undefined, undefined);
}

__init__() {
  level.allies_team = #"allies";
  level.axis_team = #"axis";
}