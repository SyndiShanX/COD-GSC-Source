/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_catalyst.csc
*************************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;
#namespace archetype_catalyst;

function private autoexec __init__system__() {
  system::register(#"catalyst", &preinit, undefined, undefined, undefined);
}

function autoexec precache() {}

function private preinit() {
  ai::add_archetype_spawn_function(#"catalyst", &function_5608540a);
}

function private function_5608540a(localclientnum) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}