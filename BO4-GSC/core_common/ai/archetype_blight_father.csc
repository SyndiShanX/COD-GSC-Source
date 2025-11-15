/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_blight_father.csc
******************************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\system_shared;

#namespace archetype_blight_father;

autoexec __init__system__() {
  system::register(#"blight_father", &__init__, undefined, undefined);
}

autoexec precache() {
  ai::add_archetype_spawn_function(#"blight_father", &function_859ccb1e);
}

__init__() {}

private function_859ccb1e(localclientnum) {
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}