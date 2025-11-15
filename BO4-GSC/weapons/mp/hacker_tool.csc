/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\hacker_tool.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\hacker_tool;

#namespace hacker_tool;

autoexec __init__system__() {
  system::register(#"hacker_tool", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}