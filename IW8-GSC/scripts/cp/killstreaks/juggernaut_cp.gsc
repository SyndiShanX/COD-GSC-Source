/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\juggernaut_cp.gsc
****************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "initConfig", &jugg_initconfig);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "levelData", &jugg_leveldata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerActionSet", &jugg_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerOnPlayerSpawnCallback", &jugg_registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "dropCrateFromScriptedHeli", &jugg_dropcratefromscriptedheli);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "makeJuggernaut", &jugg_makejuggernautcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "watchPickup", &jugg_watchpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMoveSpeedScalar", &jugg_getmovespeedscalar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "updateMoveSpeedScale", &jugg_updatemovespeedscale);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "allowActionSet", &jugg_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", &jugg_cantriggerjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMinigunWeapon", &vehicle_damage_setweaponclassmoddamageforvehicle);
}

function vehicle_damage_setweaponclassmoddamageforvehicle() {
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

function jugg_registeronplayerspawncallback(var0) {}

function jugg_dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6);
}

function jugg_makejuggernautcallback(var0, var1) {
  return scripts\cp\cp_juggernaut::jugg_makejuggernaut(var0, var1);
}

function jugg_initconfig(var0) {
  return scripts\cp\cp_juggernaut::jugg_createconfig(var0);
}

function jugg_leveldata(var0) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(var0);
}

function jugg_watchpickup(var0) {
  thread scripts\cp\cp_weapon::watchweaponpickup(var0);
}

function jugg_registeractionset() {
  scripts\mp\playeractions::registeractionset("fakeJugg", ["slide", "prone", "reload"]);
}

function juggernautweaponpickedup(var0, var1) {
  if(istrue(self.isjuggernaut)) {
    return;
  }

  if(isDefined(var1) && isDefined(var1.basename) && var1.basename == "iw8_lm_dblmg_mp") {
    var2 = weaponclipsize(var1);
    self setweaponammoclip(var1, var2);
    return;
  }

  self.minigunprevweaponobject = var2;
  self.playerstreakspeedscale = scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
  scripts\cp\cp_loadout::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("fakeJugg", 0);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(0, "fakeJugg");
    scripts\common\utility::allow_mount_side(0, "fakeJugg");
  }

  self notifyonplayercommand("manual_switch_from_minigun", "+weapprev");
  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(var1, var2);
}

function jugg_getmovespeedscalar() {
  return scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
}

function jugg_updatemovespeedscale() {
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
}

function jugg_allowactionset(var0, var1) {
  scripts\mp\playeractions::allowactionset(var0, var1);
}

function jugg_decrementfauxvehiclecount() {}

function jugg_incrementfauxvehiclecount() {}

function jugg_cantriggerjuggernaut(var0) {
  return true;
}

function jugg_playoperatoruseline(var0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "use_killstreak_juggernaut_local");
}