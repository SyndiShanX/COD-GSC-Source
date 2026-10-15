/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_suppress.csc
*****************************************************************/

#include scripts\core_common\serverfield_shared;
#include scripts\core_common\system_shared;

#namespace status_effect_suppress;

autoexec __init__system__() {
  system::register(#"status_effect_suppress", &__init__, undefined, undefined);
}

__init__() {
  serverfield::register("status_effect_suppress_field", 1, 5, "int");
}