/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\lmg_rules.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#namespace lmg_rules;

function private autoexec __init__system__() {
  system::register(#"lmg_rules", &preinit, undefined, undefined, #"killstreaks");
}

function preinit() {
  if(isDefined(level.killstreakrules[#"hero_weapons"])) {
    killstreakrules::addkillstreaktorule("sig_lmg", "hero_weapons", 0, 0);
  }
}