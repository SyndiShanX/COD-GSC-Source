/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\loadout_drop.gsc
***********************************************/

_id_68300CD2B488BA4D() {}

_id_40F1163063C26637() {
  thread _id_B1674D8C1E11617F();
  return 1;
}

_id_B1674D8C1E11617F() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("loadout_drop", self);
  streakinfo.deployweaponobj = makeweapon("deploy_loadout_drop_mp");

  if(isDefined(level._id_27F78817B59DFE32))
    streakinfo._id_FB58A31C756DB4CC = level._id_27F78817B59DFE32;

  _id_3B64EB40368C1450::set("giveDropWeapon", "killstreaks", 0);
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, streakinfo.deployweaponobj, "grenade_fire");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("giveDropWeapon");

  if(istrue(_id_9B1DEB5E9D32BBE3)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_1FD32A2F783FFFC4");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
      scripts\cp_mp\challenges::_id_D997435895422ECC("super_loadout_drop", 0);
    }
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage") && !scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
  }
}

_id_4CA6B5FEBA808692(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("loadout_drop", self);
  streakinfo.deployweaponobj = makeweapon("deploy_loadout_drop_mp");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    return 0;
  }

  thread scripts\cp_mp\killstreaks\airdrop::airdropmarkerfired(streakinfo, streakinfo.deployweaponobj, grenade);
  return 1;
}