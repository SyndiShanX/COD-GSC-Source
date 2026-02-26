/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\flamethrower_rules.gsc
*************************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#namespace flamethrower_rules;

function private autoexec __init__system__() {
  system::register(#"flamethrower_rules", &preinit, undefined, undefined, #"killstreaks");
}

function preinit() {
  if(isDefined(level.killstreakrules[#"hero_weapons"])) {
    killstreakrules::addkillstreaktorule("hero_flamethrower", "hero_weapons", 0, 0);
  }
}