/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_weapon_kits_shared.gsc
*****************************************************************/

weaponkitsinitshared() {
  level._id_A9CB = [];
  var_0 = _tablegetrowcount("mp/zombieWeaponKitTable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = _tablelookupbyrow("mp/zombieWeaponKitTable.csv", var_1, 0);
    var_3 = _func_310(var_2);

    if(var_3 != 0) {
      level._id_A9CB[var_2] = 1;
      continue;
    }
  }
}

weaponkitsgetpaintjobfrombaseweaponrefmp(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "paintjob");
  return var_2;
}

getweaponkitmp(var_0, var_1) {
  var_2 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "weapon");
  var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "reticle");
  var_4 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "camo");
  var_5 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "charm");
  var_6 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "customization");
  var_7 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "paintjob");
  var_8 = [];

  for(var_9 = 0; var_9 < 4; var_9++) {
    var_10 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_1, "attachment", var_9);

    if(!var_10) {
      continue;
    }
    var_8 = common_scripts\utility::_id_0F6F(var_8, var_10);
  }

  var_11 = var_2;

  if(_func_315(var_11)) {
    var_11 = _func_312(var_2);
  }

  var_12 = level.weaponguidoverrides[var_11 + ""];

  if(isDefined(var_12) && !common_scripts\utility::_id_562E(level.promisenottogiveweapon)) {
    var_2 = var_12;
  }

  var_14 = spawnStruct();
  var_14._id_A9F8 = var_2;
  var_14._id_7E18 = var_3;
  var_14._id_1EC0 = var_4;
  var_14.charmguid = var_5;
  var_14._id_297C = var_6;
  var_14._id_114C = var_8;
  var_14.paintjobdwfileslot = var_7;
  return var_14;
}

_id_4736() {
  return getarraykeys(level._id_A9CB);
}

_id_5842(var_0) {
  return common_scripts\utility::_id_562E(level._id_A9CB[var_0]);
}

isvalidguid(var_0) {
  var_1 = !common_scripts\utility::_id_0F79([0, -1], var_0);
  return var_1;
}