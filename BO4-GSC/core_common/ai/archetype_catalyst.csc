/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_catalyst.csc
*************************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\system_shared;

#namespace archetype_catalyst;

autoexec __init__system__() {
  system::register(#"catalyst", &__init__, undefined, undefined);
}

autoexec

__init__() {
  ai::add_archetype_spawn_function(#"catalyst", &function_5608540a);
}

private function_5608540a(localclientnum) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}