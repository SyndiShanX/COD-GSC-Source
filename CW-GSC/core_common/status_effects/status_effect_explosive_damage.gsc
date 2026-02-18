/*************************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_explosive_damage.gsc
*************************************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#namespace status_effect_explosive_damage;

function private autoexec __init__system__() {
  system::register(#"status_effect_explosive_damage", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  status_effect::function_6f4eaf88(getstatuseffect("explosive_damage"));
}