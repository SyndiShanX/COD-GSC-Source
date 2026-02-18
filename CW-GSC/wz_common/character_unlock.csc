/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world_fixup;
#using scripts\core_common\system_shared;
#namespace character_unlock;

function private autoexec __init__system__() {
  system::register(#"character_unlock", &preinit, undefined, undefined, #"character_unlock_fixup");
}

function private preinit() {}

function function_d2294476(var_2ab9d3bd, replacementcount, var_3afaa57b) {}