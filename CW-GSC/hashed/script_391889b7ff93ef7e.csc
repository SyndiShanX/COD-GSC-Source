/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_391889b7ff93ef7e.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_9f3d3e9;

function private autoexec __init__system__() {
  system::register(#"wz_ai_avogadro", &preinit, undefined, undefined, undefined);
}

function preinit() {
  ai::add_archetype_spawn_function(#"avogadro", &function_1caf705e);
}

function private function_1caf705e(localclientnum) {}