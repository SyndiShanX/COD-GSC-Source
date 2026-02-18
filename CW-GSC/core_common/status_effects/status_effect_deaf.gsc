/*************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_deaf.gsc
*************************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#namespace status_effect_deaf;

function private autoexec __init__system__() {
  system::register(#"status_effect_deaf", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  status_effect::register_status_effect_callback_apply(0, &deaf_apply);
  status_effect::function_5bae5120(0, &function_c5189bd);
  status_effect::function_6f4eaf88(getstatuseffect("deaf"));
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {}

function deaf_apply(var_756fda07, weapon, applicant) {}

function function_c5189bd() {}