/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_brutus.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace archetype_brutus;

function private autoexec __init__system__() {
  system::register(#"brutus", &preinit, undefined, undefined, undefined);
}

function autoexec precache() {}

function private preinit() {}

function function_6e2a738c(localclientnum, pos, surface, notetrack, bone) {}