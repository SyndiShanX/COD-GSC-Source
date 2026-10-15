/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\remotemissile.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

autoexec __init__system__() {
  system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
}