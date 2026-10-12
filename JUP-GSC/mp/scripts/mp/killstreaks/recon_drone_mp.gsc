/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\recon_drone_mp.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#namespace recon_drone_mp;

function recondrone_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("radar_drone_recon", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  registersharedfunc("reconDrone", "onSuperStarted", &function_52d2de9ad62cae12);
}

function function_4beb6ea484d2db90() {
  if(!isDefined(level.superglobals.staticsuperdata["super_recon_drone"])) {
    return;
  }

  level.superglobals.staticsuperdata["super_recon_drone"].var_f6604eebabcac6c2 = &function_157c2bcd50ca6207;
}

function function_52d2de9ad62cae12() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread function_5a031333c402a6ce();
  }
}

function function_5a031333c402a6ce() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  objweapon = makeweapon("ks_remote_drone_mp");

  if(self hasweapon(objweapon)) {
    _takeweapon(objweapon);
  }
}