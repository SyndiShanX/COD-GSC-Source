/***********************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_movement_speed.gsc
***********************************************************************/

#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#namespace status_effect_movement_speed;

function private autoexec __init__system__() {
  system::register(#"status_effect_movement_speed", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  status_effect::function_6f4eaf88(getstatuseffect("movement"));
  status_effect::function_5bae5120(8, &function_f7e9c0bb);
}

function function_f7e9c0bb() {}