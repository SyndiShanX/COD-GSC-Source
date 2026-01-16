/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\supplydrop.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\killstreaks\supplydrop_shared;

#namespace supplydrop;

autoexec __init__system__() {
  system::register(#"supplydrop", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
}