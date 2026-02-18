/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_soa.csc
***********************************************/

#using script_182ec5b35e8dcb93;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_ai_soa;

function private autoexec __init__system__() {
  system::register(#"zm_ai_soa", &preinit, undefined, undefined, undefined);
}

function private preinit() {}