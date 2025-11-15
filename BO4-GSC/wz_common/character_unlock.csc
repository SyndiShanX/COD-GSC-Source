/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_world_fixup;

#namespace character_unlock;

autoexec __init__system__() {
  system::register(#"character_unlock", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {}

function_d2294476(var_2ab9d3bd, replacementcount, var_3afaa57b) {}