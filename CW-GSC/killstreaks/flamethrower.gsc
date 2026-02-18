/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\flamethrower.gsc
***********************************************/

#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace flamethrower;

function private autoexec __init__system__() {
  system::register(#"flamethrower", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  if(!sessionmodeiscampaigngame()) {
    killstreaks::register_killstreak("killstreak_flamethrower", &killstreaks::function_fc82c544);
  }

  status_effect::function_30e7d622(getweapon("hero_flamethrower"), "flakjacket");
  status_effect::function_30e7d622(getweapon("inventory_hero_flamethrower"), "flakjacket");
}