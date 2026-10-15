/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_deaf.gsc
*************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_deaf;

autoexec __init__system__() {
  system::register(#"status_effect_deaf", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(0, &deaf_apply);
  status_effect::function_5bae5120(0, &function_c5189bd);
  status_effect::function_6f4eaf88(getstatuseffect("deaf"));
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {}

deaf_apply(var_756fda07, weapon, applicant) {}

function_c5189bd() {}