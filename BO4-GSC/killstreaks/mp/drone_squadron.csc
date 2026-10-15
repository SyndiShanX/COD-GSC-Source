/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\drone_squadron.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace drone_squadron;

autoexec __init__system__() {
  system::register(#"drone_squadron", &__init__, undefined, #"killstreaks");
}

__init__() {}