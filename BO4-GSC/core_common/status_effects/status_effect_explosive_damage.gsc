/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_explosive_damage.gsc
*************************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_explosive_damage;

autoexec __init__system__() {
  system::register(#"status_effect_explosive_damage", &__init__, undefined, undefined);
}

__init__() {
  status_effect::function_6f4eaf88(getstatuseffect("explosive_damage"));
}