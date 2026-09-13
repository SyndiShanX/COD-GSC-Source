/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\juggernaut_cp.gsc
****************************************************/

init() {
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
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", ::jugg_cantriggerjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", ::jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMinigunWeapon", ::jugg_getminigunweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "juggernautWeaponPickedUp", ::juggernautweaponpickedup);
}

jugg_getminigunweapon() {
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

_id_A869748B27159997() {
  _id_791C14FBD0F3282D = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(self.juggcontext.juggconfig.classstruct.loadoutprimary);
  return _id_791C14FBD0F3282D;
}

jugg_registeronplayerspawncallback(function) {}

jugg_dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data);
}

jugg_makejuggernautcallback(config, streakinfo) {
  return scripts\cp\cp_juggernaut::jugg_makejuggernaut(config, streakinfo);
}

jugg_initconfig(config) {
  return scripts\cp\cp_juggernaut::jugg_createconfig(config);
}

jugg_leveldata(ref) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(ref);
}

jugg_watchpickup(_id_2CA201D5906CDBA5) {
  thread _id_74502A9E0EF1F19C::watchweaponpickup(_id_2CA201D5906CDBA5);
}

jugg_registeractionset() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("fakeJugg", ["slide", "prone", "reload"]);
}

juggernautweaponpickedup(_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417) {
  if(istrue(self.isjuggernaut)) {
    return;
  }
  if(isDefined(_id_6E8ABB5CB9BFD417) && isDefined(_id_6E8ABB5CB9BFD417.basename) && _id_6E8ABB5CB9BFD417.basename == "iw9_lm_dblmg2_cp" && !isDefined(level._id_7E81A64330ECE925)) {
    _id_A7BE10E54A3A4B99 = weaponclipsize(_id_6E8ABB5CB9BFD417);
    self setweaponammoclip(_id_6E8ABB5CB9BFD417, _id_A7BE10E54A3A4B99);
    return;
  }

  if(isDefined(level._id_7E81A64330ECE925))
    self[[level._id_7E81A64330ECE925]](_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417);

  self.minigunprevweaponobject = _id_6E8ABB5CB9BFD417;
  self.playerstreakspeedscale = scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
  scripts\cp\cp_loadout::updatemovespeedscale();
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("fakeJugg", 0);

  if(!istrue(level.disablemount)) {
    _id_3B64EB40368C1450::set("fakeJugg", "mount_top", 0);
    _id_3B64EB40368C1450::set("fakeJugg", "mount_side", 0);
  }

  self notifyonplayercommand("manual_switch_from_minigun", "+weapprev");
  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417);
}

jugg_getmovespeedscalar() {
  return scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
}

jugg_updatemovespeedscale() {
  _id_12E2FB553EC1605E::updatemovespeedscale();
}

jugg_allowactionset(name, _id_CD187E38E3DF8F36) {
  _id_3B64EB40368C1450::_id_3633B947164BE4F3(name, _id_CD187E38E3DF8F36);
}

jugg_decrementfauxvehiclecount() {}

jugg_incrementfauxvehiclecount() {}

jugg_cantriggerjuggernaut(streakinfo) {
  if(isDefined(self._id_AC19F9B9C6C841B9) && self._id_AC19F9B9C6C841B9 == "chopper")
    return 0;

  return 1;
}

jugg_playoperatoruseline(player) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_2492241D17CECD6D");
}