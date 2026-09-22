/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1388.gsc
**************************************/

_id_A9CE() {
  level._id_A9CC = ::_id_4735;
}

getattachmentforzombieweapon(var_0, var_1) {
  if(!isDefined(var_1) || !_isstring(var_1) || var_1 == "") {
    return undefined;
  }

  var_2 = _getweaponattachmentsbasenames(var_0);

  foreach(var_4 in var_2) {
    if(issubstr(var_4, var_1)) {
      return var_4;
    }
  }

  return undefined;
}

_id_4735(var_0, var_1) {
  if(var_1 == "none") {
    return;
  }
  if(!issubstr(var_1, "_zm")) {
    return;
  }
  var_2 = _id_0547::_id_AAF9(var_1);
  var_3 = _id_0547::_id_9475(var_2) + "_mp";

  if(!maps\mp\zombies\zombie_weapon_kits_shared::_id_5842(var_3)) {
    return;
  }
  var_4 = maps\mp\zombies\zombie_weapon_kits_shared::getweaponkitmp(var_0, var_3);
  var_5 = [];

  foreach(var_7 in var_4._id_114C) {
    var_8 = getzombieattachmentoverrideguid(var_7, var_1);

    if(isDefined(var_8)) {
      var_5[var_5.size] = var_8;
    }
  }

  var_4._id_114C = var_5;
  return var_4;
}

getzombieattachmentoverrideguid(var_0, var_1) {
  var_2 = maps\mp\_utility::_id_452B(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = getattachmentforzombieweapon(var_1, var_2);

  if(!isDefined(var_3)) {
    return undefined;
  }

  return maps\mp\_utility::_id_452A(var_3);
}

weaponkitsgetvalidbaseweaponrefmp(var_0) {
  if(var_0 == "none") {
    return;
  }
  if(!issubstr(var_0, "_zm")) {
    return;
  }
  var_1 = _id_0547::_id_AAF9(var_0);
  var_2 = _id_0547::_id_9475(var_1) + "_mp";

  if(!maps\mp\zombies\zombie_weapon_kits_shared::_id_5842(var_2)) {
    return;
  }
  return var_2;
}

getzombiepaintjob(var_0, var_1) {
  var_2 = _id_0547::_id_AAF9(var_1, 0, 0);

  if(var_2 == "none") {
    return 0;
  }

  var_3 = _func_2FF(var_2, "_zm") + "_mp";

  if(!maps\mp\zombies\zombie_weapon_kits_shared::_id_5842(var_3)) {
    return 0;
  }

  var_4 = _id_0547::_id_AAF9(var_1, 0, 1);
  var_5 = _func_2FF(var_4, "_zm") + "_mp";
  var_6 = _func_310(var_5);
  var_7 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_3, "weapon");

  if(var_7 == 0) {
    var_7 = var_6;
  }

  var_8 = _func_311(var_7);

  if(var_5 != var_8) {
    return 0;
  }

  var_10 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_3, "paintjob");
  return var_10;
}