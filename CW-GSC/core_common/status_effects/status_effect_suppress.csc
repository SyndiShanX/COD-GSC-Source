/*****************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_suppress.csc
*****************************************************************/

#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#namespace status_effect_suppress;

function private autoexec __init__system__() {
  system::register(#"status_effect_suppress", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  serverfield::register("status_effect_suppress_field", 1, 5, "int");
}