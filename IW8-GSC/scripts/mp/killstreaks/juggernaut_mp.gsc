/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\juggernaut_mp.gsc
****************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("juggernaut", &scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct);
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
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "decrementFauxVehicleCount", &jugg_decrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "incrementFauxVehicleCount", &jugg_incrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", &jugg_cantriggerjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canReload", &scripts\mp\juggernaut::vehicle_damage_registervisualpercentcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canUseWeaponPickups", &scripts\mp\juggernaut::vehicle_damage_setdeathcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMinigunWeapon", &scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle);
}

function jugg_registeractionset() {
  scripts\mp\playeractions::registeractionset("fakeJugg", ["slide", "prone"]);
}

function jugg_registeronplayerspawncallback(var0) {}

function jugg_dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6);
}

function jugg_makejuggernautcallback(var0, var1) {
  return scripts\mp\juggernaut::jugg_makejuggernaut(var0, var1);
}

function jugg_initconfig(var0) {
  return scripts\mp\juggernaut::jugg_createconfig(var0);
}

function jugg_leveldata(var0) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(var0);
}

function jugg_watchpickup(var0) {
  thread scripts\mp\weapons::watchpickup(var0);
}

function jugg_getmovespeedscalar() {
  return scripts\mp\juggernaut::jugg_getmovespeedscalar();
}

function jugg_updatemovespeedscale() {
  scripts\mp\weapons::updatemovespeedscale();
}

function jugg_allowactionset(var0, var1) {
  scripts\mp\playeractions::allowactionset(var0, var1);
}

function jugg_decrementfauxvehiclecount() {
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
}

function jugg_incrementfauxvehiclecount() {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
}

function jugg_cantriggerjuggernaut(var0) {
  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
    }

    return false;
  }

  if(scripts\mp\juggernaut::changecirclestateatlowtime()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_TEAM_MAX_REACHED");
    }

    return false;
  }

  return true;
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

  self.ref_12346 = 1;
  self.minigunprevweaponobject = var2;
  self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("fakeJugg", 0);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(0, "fakeJugg");
    scripts\common\utility::allow_mount_side(0, "fakeJugg");
  }

  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(var1, var2);
}

function jugg_playoperatoruseline(var0) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, "use_killstreak_juggernaut_local");
}