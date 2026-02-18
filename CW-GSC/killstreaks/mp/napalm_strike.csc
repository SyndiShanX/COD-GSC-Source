/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\napalm_strike.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\napalm_strike_shared;
#namespace napalm_strike;

function private autoexec __init__system__() {
  system::register(#"napalm_strike", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared("killstreak_napalm_strike");
}