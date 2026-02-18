/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\cp\abilities.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace abilities;

function private autoexec __init__system__() {
  system::register(#"cp_abilities", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("playerAbilities.inRange", #"player_abilities", #"inrange", 1, 1, "int", undefined, 0, 0);
}