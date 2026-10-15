/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\tacticalinsertion.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\hacker_tool;
#include scripts\weapons\tacticalinsertion;

#namespace tacticalinsertion;

autoexec __init__system__() {
  system::register(#"tacticalinsertion", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  level.var_96ee56b5 = &function_e34f7002;
}

function_e34f7002() {
  self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
}