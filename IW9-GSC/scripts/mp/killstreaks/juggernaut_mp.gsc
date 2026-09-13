/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\juggernaut_mp.gsc
****************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("juggernaut", scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "initConfig", ::jugg_initconfig);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "levelData", ::jugg_leveldata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerActionSet", ::jugg_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerOnPlayerSpawnCallback", ::jugg_registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "dropCrateFromScriptedHeli", ::jugg_dropcratefromscriptedheli);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "makeJuggernaut", ::jugg_makejuggernautcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "watchPickup", ::jugg_watchpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMoveSpeedScalar", ::jugg_getmovespeedscalar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "updateMoveSpeedScale", ::jugg_updatemovespeedscale);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "allowActionSet", ::jugg_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "decrementFauxVehicleCount", ::jugg_decrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "incrementFauxVehicleCount", ::jugg_incrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", ::jugg_cantriggerjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", ::jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", ::jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "juggernautWeaponPickedUp", ::juggernautweaponpickedup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canReload", scripts\mp\juggernaut::jugg_canreload);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canUseWeaponPickups", scripts\mp\juggernaut::jugg_canuseweaponpickups);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMinigunWeapon", scripts\mp\juggernaut::jugg_getminigunweapon);
}

jugg_registeractionset() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("fakeJugg", ["slide", "prone"]);
}

jugg_registeronplayerspawncallback(function) {}

jugg_dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo);
}

jugg_makejuggernautcallback(config, streakinfo) {
  return scripts\mp\juggernaut::jugg_makejuggernaut(config, streakinfo);
}

jugg_initconfig(config) {
  return scripts\mp\juggernaut::jugg_createconfig(config);
}

jugg_leveldata(ref) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(ref);
}

jugg_watchpickup(_id_2CA201D5906CDBA5) {
  thread scripts\mp\weapons::watchpickup(_id_2CA201D5906CDBA5);
}

jugg_getmovespeedscalar() {
  return scripts\mp\juggernaut::jugg_getmovespeedscalar();
}

jugg_updatemovespeedscale() {
  scripts\mp\weapons::updatemovespeedscale();
}

jugg_allowactionset(name, _id_CD187E38E3DF8F36) {
  _id_3B64EB40368C1450::_id_3633B947164BE4F3(name, _id_CD187E38E3DF8F36);
}

jugg_decrementfauxvehiclecount() {
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
}

jugg_incrementfauxvehiclecount() {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
}

jugg_cantriggerjuggernaut(streakinfo) {
  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");

    return 0;
  }

  return 1;
}

juggernautweaponpickedup(_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417) {
  if(istrue(self.isjuggernaut)) {
    return;
  }
  if(isDefined(_id_6E8ABB5CB9BFD417) && isDefined(_id_6E8ABB5CB9BFD417.basename) && _id_6E8ABB5CB9BFD417.basename == "iw8_lm_dblmg_mp") {
    _id_A7BE10E54A3A4B99 = weaponclipsize(_id_6E8ABB5CB9BFD417);
    self setweaponammoclip(_id_6E8ABB5CB9BFD417, _id_A7BE10E54A3A4B99);
    return;
  }

  self.pickedupcoreminigun = 1;
  self.minigunprevweaponobject = _id_6E8ABB5CB9BFD417;
  self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
  scripts\mp\weapons::updatemovespeedscale();
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("fakeJugg", 0);

  if(!istrue(level.disablemount)) {
    _id_3B64EB40368C1450::set("fakeJugg", "mount_top", 0);
    _id_3B64EB40368C1450::set("fakeJugg", "mount_side", 0);
  }

  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417);
}

jugg_playoperatoruseline(player) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(player, "stat_2492241D17CECD6D");
}