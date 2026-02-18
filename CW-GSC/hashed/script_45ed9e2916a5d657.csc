/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_45ed9e2916a5d657.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_cd6bd9f;

function private autoexec __init__system__() {
  system::register(#"hash_54149d856843e31a", &preinit, undefined, undefined, undefined);
}

function preinit() {
  ai::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_7ec99c76);
}

function private function_7ec99c76(localclientnum) {
  playFX(localclientnum, "zombie/fx_portal_keeper_spawn_burst_zod_zmb", self.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
}