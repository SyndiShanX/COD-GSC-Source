/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_avogadro.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zm_ai_avogadro;

function private autoexec __init__system__() {
  system::register(#"zm_ai_avogadro", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  ai::add_archetype_spawn_function(#"avogadro", &function_1caf705e);
}

function private function_1caf705e(localclientnum) {}