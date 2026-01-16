/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_avogadro.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_ai_avogadro;

autoexec __init__system__() {
  system::register(#"zm_ai_avogadro", &__init__, undefined, undefined);
}

__init__() {
  ai::add_archetype_spawn_function(#"avogadro", &function_1caf705e);
}

private function_1caf705e(localclientnum) {}