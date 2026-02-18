/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\high_value_target.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace high_value_target;

function private autoexec __init__system__() {
  system::register(#"high_value_target", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "high_value_target", 1, 1, "int", undefined, 0, 0);
}