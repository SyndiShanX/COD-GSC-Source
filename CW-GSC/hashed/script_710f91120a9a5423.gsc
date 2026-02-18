/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_710f91120a9a5423.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#namespace namespace_5e75c551;

function private autoexec __init__system__() {
  system::register(#"hash_7bd5e0fb2a57c52f", &preinit, undefined, undefined, #"killstreaks");
}

function preinit() {
  if(isDefined(level.killstreakrules[# "hero_weapons"])) {
    killstreakrules::addkillstreaktorule("napalm_strike_zm", "hero_weapons", 0, 0);
  }
}