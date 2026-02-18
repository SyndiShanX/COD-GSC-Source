/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\planemortar_rules.gsc
************************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#namespace planemortar_rules;

function private autoexec __init__system__() {
  system::register(#"planemortar_rules", &preinit, undefined, undefined, #"killstreaks");
}

function preinit() {
  if(isDefined(level.killstreakrules[# "hero_weapons"])) {
    killstreakrules::addkillstreaktorule("planemortar", "hero_weapons", 0, 0);
  }
}