/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\chopper_gunner.csc
***********************************************/

#using script_4eecbd20dc9a462c;
#using scripts\core_common\system_shared;
#namespace chopper_gunner;

function private autoexec __init__system__() {
  system::register(#"chopper_gunner", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  namespace_e8c18978::preinit();
}