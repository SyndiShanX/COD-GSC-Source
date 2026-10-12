/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\juggernaut_recon_mp.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\weapons;
#namespace juggernaut_recon_mp;

function autoexec main() {
  registersharedfunc("juggernaut_recon", "init", &init);
}

function init() {
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "initConfig", &function_6cbad31a27208d32);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "levelData", &function_9701a01eee186094);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "registerActionSet", &function_998577120b21a50b);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "dropCrateFromScriptedHeli", &function_23b84686f47e78f4);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "makeJuggernaut", &function_a9e9a04447be5abb);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "watchPickup", &function_c7dc75a1f2dc340d);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "getMoveSpeedScalar", &function_beb2f24f2f22abe2);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "updateMoveSpeedScale", &function_eee408b4aae805c5);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "allowActionSet", &function_e8acfbf95ff60c47);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "decrementFauxVehicleCount", &function_46cfff4421ac1b50);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "incrementFauxVehicleCount", &function_ce88bec69240f560);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "canTriggerJuggernaut", &function_22256c01d8eb752c);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "playOperatorUseLine", &function_44d1e060ec177f59);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "canReload", &scripts\mp\juggernaut::jugg_canreload);
  scripts\engine\utility::registersharedfunc("juggernaut_recon", "canUseWeaponPickups", &scripts\mp\juggernaut::jugg_canuseweaponpickups);
}

function function_998577120b21a50b() {
  val::group_register("fakeJugg", ["slide", "prone"]);
}

function function_23b84686f47e78f4(owner, team, cratetype, position, angles, destination, data, streakinfo) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo);
}

function function_a9e9a04447be5abb(config, streakinfo) {
  bundle = level.streakglobals.streakbundles["juggernaut_recon"];
  return scripts\mp\juggernaut::jugg_makejuggernaut(config, streakinfo, bundle);
}

function function_6cbad31a27208d32(config) {
  return scripts\mp\juggernaut::jugg_createconfig(config);
}

function function_9701a01eee186094(ref) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(ref);
}

function function_c7dc75a1f2dc340d(droppingplayer) {
  thread scripts\mp\weapons::watchpickup(droppingplayer);
}

function function_beb2f24f2f22abe2() {
  bundle = level.streakglobals.streakbundles["juggernaut_recon"];
  return bundle.var_2c9122780ca2e437;
}

function function_eee408b4aae805c5() {
  scripts\mp\weapons::updatemovespeedscale();
}

function function_e8acfbf95ff60c47(name, allow) {
  val::group_set(name, allow);
}

function function_46cfff4421ac1b50() {
  decrementfauxvehiclecount();
}

function function_ce88bec69240f560() {
  incrementfauxvehiclecount();
}

function function_22256c01d8eb752c(streakinfo) {
  if(getdvarint(@ "hash_e33f3513a88f530c", 0)) {
    return true;
  }

  if(currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maxvehiclesallowed()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
    }

    return false;
  }

  return true;
}

function function_44d1e060ec177f59(player) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(player, #"bc_killstreak_action_juggernaut");
}