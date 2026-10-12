/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\juggernaut_cp.gsc
****************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\loadout;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace juggernaut_cp;

function init() {
  scripts\engine\utility::registersharedfunc("juggernaut", "initConfig", &jugg_initconfig);
  scripts\engine\utility::registersharedfunc("juggernaut", "levelData", &jugg_leveldata);
  scripts\engine\utility::registersharedfunc("juggernaut", "registerActionSet", &jugg_registeractionset);
  scripts\engine\utility::registersharedfunc("juggernaut", "registerOnPlayerSpawnCallback", &jugg_registeronplayerspawncallback);
  scripts\engine\utility::registersharedfunc("juggernaut", "dropCrateFromScriptedHeli", &jugg_dropcratefromscriptedheli);
  scripts\engine\utility::registersharedfunc("juggernaut", "makeJuggernaut", &jugg_makejuggernautcallback);
  scripts\engine\utility::registersharedfunc("juggernaut", "watchPickup", &jugg_watchpickup);
  scripts\engine\utility::registersharedfunc("juggernaut", "getMoveSpeedScalar", &jugg_getmovespeedscalar);
  scripts\engine\utility::registersharedfunc("juggernaut", "updateMoveSpeedScale", &jugg_updatemovespeedscale);
  scripts\engine\utility::registersharedfunc("juggernaut", "allowActionSet", &jugg_allowactionset);
  scripts\engine\utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", &jugg_cantriggerjuggernaut);
  scripts\engine\utility::registersharedfunc("juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline);
  scripts\engine\utility::registersharedfunc("juggernaut", "getMinigunWeapon", &jugg_getminigunweapon);
  scripts\engine\utility::registersharedfunc("juggernaut", "juggernautWeaponPickedUp", &juggernautweaponpickedup);
}

function jugg_getminigunweapon() {
  assertex(scripts\cp\utility::isjuggernaut(), "jugg_getMiniGunWeapon: Trying to get the player's ( jugg ) minigun weapon when not a jugg");
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

function function_a869748b27159997() {
  assertex(scripts\cp\utility::isjuggernaut(), "jugg_getMiniGunWeaponUpdated: Trying to get the player's ( jugg ) minigun weapon when not a jugg");
  minigunweaponobj = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(self.juggcontext.juggconfig.classstruct.loadoutprimary);
  return minigunweaponobj;
}

function jugg_registeronplayerspawncallback(function) {}

function jugg_dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data);
}

function jugg_makejuggernautcallback(config, streakinfo) {
  return scripts\cp\cp_juggernaut::jugg_makejuggernaut(config, streakinfo);
}

function jugg_initconfig(config) {
  return scripts\cp\cp_juggernaut::jugg_createconfig(config);
}

function jugg_leveldata(ref) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(ref);
}

function jugg_watchpickup(droppingplayer) {
  thread scripts\cp\weapon::watchweaponpickup(droppingplayer);
}

function jugg_registeractionset() {
  val::group_register("fakeJugg", ["slide", "prone", "reload"]);
}

function juggernautweaponpickedup(juggernautweaponobject, prevweaponobject) {
  if(istrue(self.isjuggernaut)) {
    return;
  }

  if(isDefined(prevweaponobject) && isDefined(prevweaponobject.basename) && prevweaponobject.basename == "iw9_lm_dblmg2_cp" && !isDefined(level.var_7e81a64330ece925)) {
    maxclipammo = weaponclipsize(prevweaponobject);
    self setweaponammoclip(prevweaponobject, maxclipammo);
    return;
  }

  if(isDefined(level.var_7e81a64330ece925)) {
    self[[level.var_7e81a64330ece925]](juggernautweaponobject, prevweaponobject);
  }

  self.minigunprevweaponobject = prevweaponobject;
  self.playerstreakspeedscale = scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
  scripts\cp\cp_loadout::updatemovespeedscale();
  val::group_set("fakeJugg", 0);

  if(!istrue(level.disablemount)) {
    val::set("fakeJugg", "mount_top", 0);
    val::set("fakeJugg", "mount_side", 0);
  }

  self notifyonplayercommand("manual_switch_from_minigun", "+weapprev");
  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(juggernautweaponobject, prevweaponobject);
}

function jugg_getmovespeedscalar() {
  return scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
}

function jugg_updatemovespeedscale() {
  scripts\cp\loadout::updatemovespeedscale();
}

function jugg_allowactionset(name, allow) {
  val::group_set(name, allow);
}

function jugg_decrementfauxvehiclecount() {}

function jugg_incrementfauxvehiclecount() {}

function jugg_cantriggerjuggernaut(streakinfo) {
  return true;
}

function jugg_playoperatoruseline(player) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, #"bc_killstreak_action_juggernaut");
}