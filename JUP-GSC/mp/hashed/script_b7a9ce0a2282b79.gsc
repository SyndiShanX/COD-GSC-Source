/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_b7a9ce0a2282b79.gsc
************************************************/

#using script_2d9d24f7c63ac143;
#using script_6fc415ff6a905dc1;
#using script_b7a9ce0a2282b79;
#using scripts\common\ae_utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace namespace_b16531563568eaba;

function init() {
  scripts\engine\utility::registersharedfunc("instanceInventory", "getUpgradeCount", &getupgradecount);
  scripts\engine\utility::registersharedfunc("instanceInventory", "restorePlateCarrier", &function_743a2b4d08f023d2);
  scripts\engine\utility::registersharedfunc("instanceInventory", "getNumStartUpgradePlates", &getnumstartupgradeplates);
  scripts\engine\utility::registersharedfunc("instanceInventory", "isEnabled", &function_e0fc1230452cf4e7);
  scripts\engine\utility::registersharedfunc("instanceInventory", "inventoryIsValid", &inventoryisvalid);
  scripts\engine\utility::registersharedfunc("instanceInventory", "updateDefaultClassStruct", &function_f02d8dd1e58f235c);
  scripts\engine\utility::registersharedfunc("instanceInventory", "updateCustomClassStruct", &function_8b8cedb1c653204e);
  scripts\engine\utility::registersharedfunc("instanceInventory", "updateInstanceInventoryFromDefault", &updateinstanceinventoryfromdefault);
}

function initteamdatafields() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["extractedStashItems"] = [];
  }
}

function function_ddbc94f52a1947b5(player, lootid) {
  extractedstashitems = scripts\mp\utility\teams::getteamdata(player.team, "extractedStashItems");
  extractedstashitems[lootid] = 1;
  scripts\mp\utility\teams::setteamdata(player.team, "extractedStashItems", extractedstashitems);
}

function function_e0fc1230452cf4e7() {
  if(!isDefined(level.var_8f125ba0dc7c4b33)) {
    level.var_8f125ba0dc7c4b33 = getdvarint(@ "hash_a31e837c3d3a9c9", 0);
  }

  return level.var_8f125ba0dc7c4b33;
}

function function_758b22811e547efe() {
  if(!isDefined(level.var_77441e4682269fc5)) {
    level.var_77441e4682269fc5 = getdvarint(@ "hash_3a0b46b826670c2b", 0);
  }

  return level.var_77441e4682269fc5;
}

function function_dedf2039edee97d0() {
  if(!isDefined(level.var_8fa33b5efba196a8)) {
    level.var_8fa33b5efba196a8 = getdvarint(@ "hash_effdf75f46ecb806", 1);
  }

  return level.var_8fa33b5efba196a8;
}

function inventoryisValid(player) {
  return player function_f6c07d6ea7d83a5a();
}

function function_8b8cedb1c653204e(player, struct, class) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  classindex = scripts\mp\class::getclassindex(class);
  self.class_num = classindex;
  struct.loadoutarchetype = scripts\mp\class::cac_getcharacterarchetype();
  primaryweaponstruct = namespace_a38a2e1fe7519183::getloadoutweaponstruct(self, 0);
  struct.loadoutprimary = primaryweaponstruct.weaponref;

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutprimaryattachments[attachmentindex] = primaryweaponstruct.attachmentrefs[attachmentindex];
    struct.loadoutprimaryattachmentids[attachmentindex] = primaryweaponstruct.attachmentids[attachmentindex];
    tuningvalues = primaryweaponstruct.var_eae5a591e200672[attachmentindex];

    if(isDefined(tuningvalues)) {
      struct.var_193bf3cfb8aeaf0f[struct.loadoutprimaryattachments[attachmentindex]] = tuningvalues;
    }
  }

  struct.loadoutprimarycamo = primaryweaponstruct.weaponcamo;
  struct.loadoutprimaryreticle = primaryweaponstruct.weaponreticle;
  struct.loadoutprimarylootitemid = primaryweaponstruct.lootitemid;
  struct.loadoutprimaryvariantid = primaryweaponstruct.weaponvariant;
  struct.loadoutprimarycosmeticattachment = primaryweaponstruct.var_67dfd35699ba2d3e;

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutprimarystickers[var_36d2abbdcbcb186c] = primaryweaponstruct.weaponstickers[var_36d2abbdcbcb186c];
  }

  if(isDefined(primaryweaponstruct.blueprinttuning)) {
    struct.var_c4c1f56f0ddbeeff = primaryweaponstruct.blueprinttuning;
  }

  secondaryweaponstruct = namespace_a38a2e1fe7519183::getloadoutweaponstruct(self, 1);
  struct.loadoutsecondary = secondaryweaponstruct.weaponref;

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    struct.loadoutsecondaryattachments[attachmentindex] = secondaryweaponstruct.attachmentrefs[attachmentindex];
    struct.loadoutsecondaryattachmentids[attachmentindex] = secondaryweaponstruct.attachmentids[attachmentindex];
    tuningvalues = undefined;

    if(isDefined(tuningvalues)) {
      struct.var_ead3720e647f74a3[struct.loadoutsecondaryattachments[attachmentindex]] = tuningvalues;
    }
  }

  struct.loadoutsecondarycamo = secondaryweaponstruct.weaponcamo;
  struct.loadoutsecondaryreticle = secondaryweaponstruct.weaponreticle;
  struct.loadoutsecondarylootitemid = secondaryweaponstruct.lootitemid;
  struct.loadoutsecondaryvariantid = secondaryweaponstruct.weaponvariant;
  struct.loadoutsecondarycosmeticattachment = secondaryweaponstruct.var_67dfd35699ba2d3e;

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    struct.loadoutsecondarystickers[var_36d2abbdcbcb186c] = secondaryweaponstruct.weaponstickers[var_36d2abbdcbcb186c];
  }

  if(isDefined(secondaryweaponstruct.blueprinttuning)) {
    struct.var_f440bb0f08482d83 = secondaryweaponstruct.blueprinttuning;
  }

  namespace_a38a2e1fe7519183::function_f02d8dd1e58f235c(self, struct);
}

function function_f02d8dd1e58f235c(player, struct) {
  if(!function_e0fc1230452cf4e7() || !istrue(inventoryisValid(player))) {
    return;
  }

  lootid = player function_644ed519cac9722b(1, 2).lootid;
  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(isDefined(loottype) && loottype == "weapon") {
    loottype = "equipment";
  }

  if(isDefined(loottype) && loottype == "equipment") {
    struct.loadoutequipmentprimary = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    struct.var_b68e3a0a9c628d23 = function_64ccc54bdbae5cf6(lootid);

    if(isDefined(struct.var_b68e3a0a9c628d23) && struct.var_b68e3a0a9c628d23 > 0) {
      struct.loadoutequipmentprimary = scripts\cp_mp\equipment::function_f4f687e4e1edb923(struct.loadoutequipmentprimary);
    }
  }

  lootid = player function_644ed519cac9722b(1, 3).lootid;
  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(isDefined(loottype) && loottype == "weapon") {
    loottype = "equipment";
  }

  if(isDefined(loottype) && loottype == "equipment") {
    struct.loadoutequipmentsecondary = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    struct.var_a1dfc5ce15795a3 = function_64ccc54bdbae5cf6(lootid);

    if(isDefined(struct.var_a1dfc5ce15795a3) && struct.var_a1dfc5ce15795a3 > 0) {
      struct.loadoutequipmentsecondary = scripts\cp_mp\equipment::function_f4f687e4e1edb923(struct.loadoutequipmentsecondary);
    }
  }

  lootid = player function_644ed519cac9722b(1, 4).lootid;
  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(isDefined(loottype) && loottype == "super") {
    struct.loadoutfieldupgrade1 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  operatorskin = function_ef8648922f0937b9(player);
  struct.loadoutstreaksfilled = 1;
  lootid = player function_644ed519cac9722b(65535, 0).lootid;
  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(isDefined(loottype) && loottype == "killstreak") {
    struct.loadoutkillstreak1 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    return;
  }

  if(isDefined(operatorskin)) {
    defaultkillstreak = scripts\cp_mp\operator::function_e0b3eff8c73f5475(operatorskin);

    if(isDefined(defaultkillstreak)) {
      assert(scripts\cp_mp\utility\loot::function_282cf83c9eeda744(defaultkillstreak) == "<dev string:x1c>");
      struct.loadoutkillstreak1 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(defaultkillstreak);
      function_aa051314f7cdab4e(player, defaultkillstreak);
    }
  }
}

function updateinstanceinventoryfromdefault(player) {
  if(!function_e0fc1230452cf4e7() || !istrue(scripts\mp\class::function_de324c78ecdc7acd(player))) {
    return;
  }

  function_787f50a063a49187(player, 11, 1, 0, player.primaryweaponobj);
  function_787f50a063a49187(player, 11, 1, 1, player.secondaryweaponobj);
  function_f5b2810055f85ead(player, "primary", scripts\cp_mp\utility\loot::getlootidfromref(player.loadoutequipmentprimary));
  function_f5b2810055f85ead(player, "secondary", scripts\cp_mp\utility\loot::getlootidfromref(player.loadoutequipmentsecondary));
  scripts\mp\class::function_cfa0343e808b7421(player, 0);
}

function function_ea56934c1996d527(player, location, sublocation) {
  struct = spawnStruct();
  instance = player function_644ed519cac9722b(location, sublocation);

  if(istrue(level.var_ff7483c62c2bcb88) && (!isDefined(instance) || instance.lootid == 0)) {
    struct.lootitemid = 0;
    struct.weaponref = "iw9_me_fists_mp";
    struct.weaponvariant = 0;
  } else {
    loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(instance.lootid);

    if(isDefined(loottype) && loottype == "weapon") {
      struct.lootitemid = instance.lootid;
    } else {
      struct.lootitemid = 0;
    }

    struct.weaponref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(struct.lootitemid);
    struct.weaponvariant = function_64ccc54bdbae5cf6(struct.lootitemid);
  }

  struct.attachmentrefs = [];
  struct.attachmentids = [];
  struct.var_eae5a591e200672 = [];
  struct.var_4d3cc0262cea20f0 = [];
  struct.weaponcamo = "none";
  struct.weaponreticle = "none";
  struct.var_67dfd35699ba2d3e = "none";
  struct.weaponstickers = [];

  if(struct.lootitemid == 0) {
    return struct;
  }

  rootname = scripts\cp_mp\weapon::getweaponrootname(struct.weaponref);
  weaponassetname = scripts\cp_mp\weapon::weaponassetnamemap(rootname, struct.weaponvariant);
  childids = instance.var_6cb812578f7d9ae7;

  for(attachmentoffset = 0; attachmentoffset <= 4; attachmentoffset++) {
    attachref = "none";
    attachlootid = 0;
    attachmentindex = 0 + attachmentoffset;
    struct.attachmentids[attachmentoffset] = 0;

    if(isDefined(childids) && isDefined(childids[attachmentindex])) {
      attachlootid = childids[attachmentindex];
      loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(attachlootid);

      if(isDefined(attachlootid) && attachlootid != 0 && isDefined(loottype) && loottype == "attachment") {
        attachref = scripts\cp_mp\utility\loot::function_2f80e9272a2074d(attachlootid, weaponassetname);
        struct.attachmentids[attachmentoffset] = scripts\mp\weapons::function_15abe90be101ffc8(weaponassetname, attachref, childids[attachmentindex]);
      }
    }

    struct.attachmentrefs[attachmentoffset] = attachref;
  }

  if(isDefined(instance.var_d3c548c09bb62da2)) {
    for(i = 2; i <= 6; i++) {
      value = function_423648b9c03fdaa1(i, instance, 1);

      if(isDefined(value) && int(value) != 0) {
        value = int(value);
        valuex = value & 255;
        valuey = value >> 8;
        struct.var_eae5a591e200672[i - 2] = [function_f76ff66a6601d9c9(valuex), function_f76ff66a6601d9c9(valuey)];
      }
    }

    for(i = 8; i <= 12; i++) {
      value = function_423648b9c03fdaa1(i, instance, 1);

      if(isDefined(value) && int(value) != 0) {
        struct.var_4d3cc0262cea20f0[i - 8] = int(value);
      }
    }

    value = function_423648b9c03fdaa1(7, instance, 1);

    if(isDefined(value) && int(value) != 0) {
      struct.blueprinttuning = int(value);
    }
  }

  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(childids[5]);

  if(isDefined(childids) && isDefined(childids[5]) && isDefined(loottype) && loottype == "camo") {
    weaponcamo = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(childids[5]);
    bundledata = function_50f8a8f765bad85e(hashcat(%"hash_1345cc24140e89b8", weaponcamo), [#"ref"]);
    struct.weaponcamo = bundledata.ref;
  }

  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(childids[6]);

  if(isDefined(childids) && isDefined(childids[6] && isDefined(loottype) && loottype == "reticle")) {
    struct.weaponreticle = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(childids[6]);
  }

  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(childids[7]);

  if(isDefined(childids) && isDefined(childids[7]) && isDefined(loottype) && (loottype == "gun_screen" || loottype == "weapon_charm")) {
    struct.var_67dfd35699ba2d3e = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(childids[7]);
  }

  for(var_171380a28f103a53 = 0; var_171380a28f103a53 <= 4; var_171380a28f103a53++) {
    var_3372b69cf77360ed = "none";
    var_36d2abbdcbcb186c = var_171380a28f103a53 + 8;
    loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(childids[var_36d2abbdcbcb186c]);

    if(isDefined(childids) && isDefined(childids[var_36d2abbdcbcb186c]) && isDefined(loottype) && loottype == "sticker") {
      lootid = childids[var_36d2abbdcbcb186c];

      if(isDefined(lootid) && lootid != 0) {
        var_3372b69cf77360ed = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
      }
    }

    struct.weaponstickers[var_171380a28f103a53] = var_3372b69cf77360ed;
  }

  return struct;
}

function getloadoutweaponstruct(player, weaponslot) {
  sublocation = function_4ad0394e9ad7176d(weaponslot);
  return function_ea56934c1996d527(player, 1, sublocation);
}

function private function_dc67872cc4cfae72(player, location, sublocation) {
  instance = player function_644ed519cac9722b(location, sublocation);

  if(instance.instanceid != "0") {
    player function_dd5661ebe3c9a5a2(instance.instanceid);
  }
}

function function_4ad0394e9ad7176d(weaponslot) {
  return ter_op(weaponslot == 0, 0, 1);
}

function function_540c2b6342f4e28c(player, slot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(slot == 2) {
    return player function_644ed519cac9722b(2, 0);
  }

  instanceslot = function_4ad0394e9ad7176d(slot);
  return player function_644ed519cac9722b(1, instanceslot);
}

function function_1f83d85290c29bef(player, weaponslot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  sublocation = function_4ad0394e9ad7176d(weaponslot);
  var_6e079390df583eb4 = player function_644ed519cac9722b(1, sublocation);
  player function_da187bcae911d661(var_6e079390df583eb4.instanceid, 2, 0);
}

function function_9fee9bd8efd81655(player, weaponobj, var_f51bbb191526dfa4, metadata) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(istrue(var_f51bbb191526dfa4)) {
    function_dc67872cc4cfae72(player, 2, 0);
  }

  function_787f50a063a49187(player, 11, 2, 0, weaponobj);
  function_a839b9ad5740477d(player, 2, 0);

  if(isDefined(metadata)) {
    instance = player function_644ed519cac9722b(2, 0);
    var_11cc6f33cb91b3f1 = function_fe92418620d93763(metadata[0]);
    var_d3c548c09bb62da2 = function_fe92418620d93763(metadata[1]);
    function_cd81c0e152649846(player, instance, var_11cc6f33cb91b3f1, var_d3c548c09bb62da2);

    function_72fe945f29c8bce6(player function_644ed519cac9722b(2, 0));
  }
}

function function_fe92418620d93763(metadata) {
  var_60d63c99a7a31e59 = [];

  if(isDefined(metadata)) {
    foreach(data in metadata) {
      currentsize = var_60d63c99a7a31e59.size;
      var_60d63c99a7a31e59[currentsize] = [];
      var_60d63c99a7a31e59[currentsize][0] = data.key;
      var_60d63c99a7a31e59[currentsize][1] = int(data.value);
    }
  }

  return var_60d63c99a7a31e59;
}

function function_bf2fa755e8269ca8(keys, values, instance, var_d3c548c09bb62da2) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(!isDefined(keys) || !isDefined(values) || !isDefined(instance)) {
    return undefined;
  }

  if(!isarray(keys)) {
    keys = [keys];
  }

  if(!isarray(values)) {
    values = [values];
  }

  if(keys.size != values.size) {
    assertmsg("<dev string:x2a>");
  }

  var_c630485049dea721 = [];
  var_a7efdaacbd89567 = instance.metadata;

  if(istrue(var_d3c548c09bb62da2)) {
    var_a7efdaacbd89567 = instance.var_d3c548c09bb62da2;
  }

  var_11e7b05668d732b9 = 0;

  if(istrue(var_d3c548c09bb62da2)) {
    var_11e7b05668d732b9 = 0;
  }

  foreach(index, key in keys) {
    unusedslot = undefined;

    foreach(dataindex, data in var_a7efdaacbd89567) {
      if(data.key == key) {
        currentsize = var_c630485049dea721.size;
        var_c630485049dea721[currentsize] = [];
        var_c630485049dea721[currentsize][0] = key;
        var_c630485049dea721[currentsize][1] = values[index];
        unusedslot = undefined;
        break;
      }

      if(data.key == var_11e7b05668d732b9) {
        unusedslot = dataindex;
      }
    }

    if(isDefined(unusedslot)) {
      var_a7efdaacbd89567[unusedslot].key = key;
      var_a7efdaacbd89567[unusedslot].value = values[index];
      currentsize = var_c630485049dea721.size;
      var_c630485049dea721[currentsize] = [];
      var_c630485049dea721[currentsize][0] = key;
      var_c630485049dea721[currentsize][1] = values[index];
    }
  }

  return var_c630485049dea721;
}

function function_a839b9ad5740477d(player, location, sublocation, var_223785486725cd51) {
  weaponstruct = function_ea56934c1996d527(player, location, sublocation);
  rootname = scripts\cp_mp\weapon::getweaponrootname(weaponstruct.weaponref);
  player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "weapon", rootname);
  player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "variantID", weaponstruct.weaponvariant);
  player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "lootItemID", weaponstruct.lootitemid);
  var_428a6c7cd65625c0 = 0;

  if(isDefined(weaponstruct.attachmentrefs)) {
    for(attachmentindex = 0; attachmentindex < weaponstruct.attachmentrefs.size; attachmentindex++) {
      player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "attachment", weaponstruct.attachmentrefs[attachmentindex]);
      player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "variantID", weaponstruct.attachmentids[attachmentindex]);

      if(isDefined(weaponstruct.var_eae5a591e200672) && isDefined(weaponstruct.var_eae5a591e200672[attachmentindex])) {
        player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "customTune", 0, function_f3c863dd3265167(weaponstruct.var_eae5a591e200672[attachmentindex][0]));
        player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "customTune", 1, function_f3c863dd3265167(weaponstruct.var_eae5a591e200672[attachmentindex][1]));
      }

      var_428a6c7cd65625c0++;
    }
  }

  if(isDefined(weaponstruct.weaponcamo)) {
    player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "camo", weaponstruct.weaponcamo);
  }

  if(isDefined(weaponstruct.weaponreticle)) {
    player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "reticle", weaponstruct.weaponreticle);
  }

  if(isDefined(weaponstruct.var_67dfd35699ba2d3e)) {
    player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "cosmeticAttachment", weaponstruct.var_67dfd35699ba2d3e);
  }

  if(isDefined(weaponstruct.weaponstickers)) {
    for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < weaponstruct.weaponstickers.size; var_36d2abbdcbcb186c++) {
      if(isDefined(weaponstruct.weaponstickers[var_36d2abbdcbcb186c])) {
        player setplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "sticker", var_36d2abbdcbcb186c, weaponstruct.weaponstickers[var_36d2abbdcbcb186c]);
      }
    }
  }

  namespace_aead94004cf4c147::function_3e89085d4a19a802(player);

  if(!istrue(var_223785486725cd51)) {
    function_5baaa0ce73d6fe84(player);
  }
}

function function_f910b139e75fd559(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
  player function_dd5661ebe3c9a5a2(var_6267a5ad12c5e4d4.instanceid);
}

function function_5d94b2dfabbc4cce(player, weaponobj, weaponslot, var_f51bbb191526dfa4, metadata) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  sublocation = function_4ad0394e9ad7176d(weaponslot);

  if(istrue(var_f51bbb191526dfa4)) {
    function_dc67872cc4cfae72(player, 1, sublocation);
  }

  function_787f50a063a49187(player, 11, 1, sublocation, weaponobj);

  if(isDefined(metadata)) {
    instance = player function_644ed519cac9722b(1, sublocation);
    var_11cc6f33cb91b3f1 = function_fe92418620d93763(metadata[0]);
    var_d3c548c09bb62da2 = function_fe92418620d93763(metadata[1]);
    function_cd81c0e152649846(player, instance, var_11cc6f33cb91b3f1, var_d3c548c09bb62da2);

    function_72fe945f29c8bce6(player function_644ed519cac9722b(1, sublocation));
  }
}

function function_787f50a063a49187(player, kind, location, sublocation, weaponobj) {
  variantid = weaponobj.variantid;

  if(!isDefined(weaponobj.variantid)) {
    variantid = 0;
  }

  rootname = scripts\cp_mp\weapon::getweaponrootname(weaponobj);
  lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
  attachmentindex = 0;
  subcomponents = [];

  for(var_e26e310b5f042288 = 0; var_e26e310b5f042288 <= 12; var_e26e310b5f042288++) {
    subcomponents[var_e26e310b5f042288] = 0;
  }

  if(isDefined(weaponobj.attachments)) {
    foreach(attachment in weaponobj.attachments) {
      if(scripts\cp_mp\weapon::attachmentiscosmetic(attachment)) {
        subcomponents[7] = scripts\cp_mp\utility\loot::getlootidfromref(attachment);
        continue;
      }

      if(scripts\engine\utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
        if([[scripts\engine\utility::getsharedfunc("weapons", "attachmentIsSelectable")]](weaponobj, attachment)) {
          attachmentref = attachment;

          if(isDefined(weaponobj.attachmentvarindices) && isDefined(weaponobj.attachmentvarindices[attachment])) {
            attachmentlootid = scripts\mp\weapons::function_1c6803f36c2ea0a6(weaponobj.basename, attachment, weaponobj.attachmentvarindices[attachment]);

            if(!isDefined(attachmentlootid)) {
              attachmentlootid = scripts\cp_mp\weapon::function_693e108cb61ceeb5(rootname, attachment);
            }

            subcomponents[attachmentindex] = attachmentlootid;
          } else {
            subcomponents[attachmentindex] = scripts\cp_mp\weapon::function_693e108cb61ceeb5(rootname, attachment);
          }

          attachmentindex += 1;
        }
      }
    }
  }

  if(isDefined(weaponobj.camo)) {
    subcomponents[5] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.camo);
  }

  if(isDefined(weaponobj.reticle)) {
    subcomponents[6] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.radical);
  }

  if(isDefined(weaponobj.stickerslot0) && weaponobj.stickerslot0 != "none") {
    subcomponents[8] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.stickerslot0);
  }

  if(isDefined(weaponobj.stickerslot1) && weaponobj.stickerslot1 != "none") {
    subcomponents[9] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.stickerslot1);
  }

  if(isDefined(weaponobj.stickerslot2) && weaponobj.stickerslot2 != "none") {
    subcomponents[10] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.stickerslot2);
  }

  if(isDefined(weaponobj.stickerslot3) && weaponobj.stickerslot3 != "none") {
    subcomponents[11] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.stickerslot3);
  }

  if(isDefined(weaponobj.var_b39ac546cc8621f8) && weaponobj.var_b39ac546cc8621f8 != "none") {
    subcomponents[12] = scripts\cp_mp\utility\loot::getlootidfromref(weaponobj.var_b39ac546cc8621f8);
  }

  player function_4f1027e74d5073c4(lootid, kind, location, sublocation, subcomponents);
}

function equipweapon(player, weaponobj, var_ec22a950f210e39, var_bac000abfe10d487, var_9539ccecbbdebc31, metadata) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  weaponslot = undefined;
  primaryweapon = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, 0);
  secondaryweapon = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, 1);

  if(isDefined(primaryweapon) && primaryweapon == weaponobj) {
    weaponslot = 0;
  } else if(isDefined(secondaryweapon) && secondaryweapon == weaponobj) {
    weaponslot = 1;
  } else {
    assert(0, "<dev string:x73>" + weaponobj.basename + "<dev string:xac>" + player.name + "<dev string:xbc>");
    weaponslot = 0;
  }

  if(isDefined(var_ec22a950f210e39)) {
    var_6e079390df583eb4 = player function_644ed519cac9722b(1, weaponslot);

    if(istrue(var_bac000abfe10d487) && istrue(var_9539ccecbbdebc31)) {
      var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
      swapinstances(player, var_6e079390df583eb4, var_6267a5ad12c5e4d4, 1, 2, weaponslot, 0);
      return;
    } else if(istrue(var_bac000abfe10d487)) {
      player function_da187bcae911d661(var_6e079390df583eb4.instanceid, 2, 0);
    } else {
      player function_dd5661ebe3c9a5a2(var_6e079390df583eb4.instanceid);
    }
  }

  if(istrue(var_9539ccecbbdebc31)) {
    var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
    player function_da187bcae911d661(var_6267a5ad12c5e4d4.instanceid, 1, weaponslot);
    return;
  }

  function_787f50a063a49187(player, 11, 1, weaponslot, weaponobj);

  if(isDefined(metadata)) {
    instance = player function_644ed519cac9722b(1, weaponslot);
    var_11cc6f33cb91b3f1 = function_fe92418620d93763(metadata[0]);
    var_d3c548c09bb62da2 = function_fe92418620d93763(metadata[1]);
    function_cd81c0e152649846(player, instance, var_11cc6f33cb91b3f1, var_d3c548c09bb62da2);

    function_72fe945f29c8bce6(player function_644ed519cac9722b(1, weaponslot));
  }
}

function function_22c2d36f9a723c2f(player, index, loadoutslot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  backpackindex = 1 + index;
  assert(backpackindex < 12, "<dev string:xea>" + index);
  loadoutinstance = player function_644ed519cac9722b(1, loadoutslot);
  player function_da187bcae911d661(loadoutinstance.instanceid, 2, backpackindex);
}

function function_d368b112dc94baae(player, index, loadoutlocation, loadoutslot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  backpackindex = 1 + index;
  assert(backpackindex < 12, "<dev string:xea>" + index);
  backpackinstance = player function_644ed519cac9722b(2, backpackindex);
  loadoutinstance = player function_644ed519cac9722b(loadoutlocation, loadoutslot);
  swapinstances(player, backpackinstance, loadoutinstance, 2, loadoutlocation, backpackindex, loadoutslot);
}

function function_e8a616866b41197(player, index, loadoutslot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  backpackindex = 1 + index;
  assert(backpackindex <= 12, "<dev string:xea>" + index);
  backpackinstance = player function_644ed519cac9722b(2, backpackindex);
  player function_da187bcae911d661(backpackinstance.instanceid, 1, loadoutslot);
}

function function_233512489717381(player, index, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  backpackindex = 1 + index;
  assert(backpackindex < 12, "<dev string:xea>" + index);
  kind = 13;
  lootscriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(scripts\mp\gametypes\br_pickups::iskey(lootscriptable) || scripts\mp\gametypes\br_pickups::function_a38e261031751c09(lootscriptable)) {
    kind = 15;
  }

  player function_4f1027e74d5073c4(lootid, kind, 2, backpackindex, []);
}

function function_f5b2810055f85ead(player, slot, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  instanceslot = function_f1c7356a808e9bd9(slot);

  if(!isDefined(instanceslot)) {
    return;
  }

  if(lootid == 0) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, instanceslot, []);
}

function function_aa051314f7cdab4e(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 65535, 0, []);
}

function function_92d947129ea5ba6e(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 65535, 1, []);
}

function function_c0ae57d4dc3a8eef(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 65535, 3, []);
}

function function_2dd07f0034a0fed1(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 65535, 4, []);
}

function function_bd01c77ab46f790(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 65535, 2, []);
}

function function_ef8648922f0937b9(player) {
  if(!function_e0fc1230452cf4e7()) {
    return undefined;
  }

  operatorinstance = player function_644ed519cac9722b(65535, 6);

  if(isDefined(operatorinstance) && operatorinstance.instanceid != "0") {
    if(isDefined(operatorinstance.var_6cb812578f7d9ae7) && isDefined(operatorinstance.var_6cb812578f7d9ae7[0])) {
      skinref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(operatorinstance.var_6cb812578f7d9ae7[0]);

      if(isDefined(skinref)) {
        return scripts\cp_mp\operator::function_29b2af59258d6501(skinref);
      }
    }
  }
}

function function_28f402fa85068f06(player) {
  if(!function_e0fc1230452cf4e7()) {
    return undefined;
  }

  operatorinstance = player function_644ed519cac9722b(65535, 6);

  if(isDefined(operatorinstance) && operatorinstance.instanceid != "0") {
    if(isDefined(operatorinstance.var_6cb812578f7d9ae7) && isDefined(operatorinstance.var_6cb812578f7d9ae7[1])) {
      executionref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(operatorinstance.var_6cb812578f7d9ae7[1]);

      if(isDefined(executionref)) {
        return scripts\cp_mp\operator::function_3daf6bb451cf826e(executionref);
      }
    }
  }
}

function function_80a3ed28ed1b33a1(player, streak, perklootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  streakinstance = player function_644ed519cac9722b(65535, 5);
  subcomponents = [];
  numperks = 0;

  if(isDefined(streakinstance) && streakinstance.instanceid != "0") {
    if(isDefined(streakinstance.var_6cb812578f7d9ae7)) {
      subcomponents = streakinstance.var_6cb812578f7d9ae7;

      for(perkindex = 0; perkindex <= 9; perkindex++) {
        if(subcomponents[perkindex] != 0) {
          numperks++;
        }
      }
    }
  }

  if(isDefined(perklootid)) {
    assert(numperks <= 9);
    newperkindex = int(min(numperks, 9));
    subcomponents[newperkindex] = perklootid;
  }

  function_7bc70fc1dd299f89(player);
  player function_4f1027e74d5073c4(scripts\cp_mp\utility\loot::getlootidfromref("dmz_exfil_streak"), 15, 65535, 5, subcomponents);
  streakinstance = player function_644ed519cac9722b(65535, 5);
  var_5170a7c15b09f348 = function_bf2fa755e8269ca8([2], [streak], streakinstance);
  function_cd81c0e152649846(player, streakinstance, var_5170a7c15b09f348);
}

function function_a0b4e4dcd4b46cf8(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, 12, []);
}

function function_1444118309b4345a(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, 13, []);
}

function function_1488c5e2dec8cf1b(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, 14, []);
}

function function_72918635f959a76f(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, 15, []);
}

function function_21ca7273e5592920(player, lootid) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_4f1027e74d5073c4(lootid, 13, 1, 16, []);
}

function function_b9da145c1f56fb90(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 12);
}

function function_a29cfeeaaf0eff2(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 13);
}

function function_2906a7bfaa0ad0a3(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 14);
}

function function_1e27d6436d2ef237(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 15);
}

function function_62eb6ab1b2878a58(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 16);
}

function function_80ff109723716c07(player) {
  function_b9da145c1f56fb90(player);
  function_a29cfeeaaf0eff2(player);
  function_2906a7bfaa0ad0a3(player);
  function_1e27d6436d2ef237(player);
  function_62eb6ab1b2878a58(player);
}

function function_7bc70fc1dd299f89(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 5);
}

function function_1558f8fb859c492a(player) {
  if(!function_e0fc1230452cf4e7()) {
    return [0, []];
  }

  streakinstance = player function_644ed519cac9722b(65535, 5);

  if(isDefined(streakinstance) && streakinstance.instanceid != "0") {
    if(isDefined(streakinstance.var_6cb812578f7d9ae7) && isDefined(streakinstance.metadata)) {
      streak = function_423648b9c03fdaa1(2, streakinstance);

      if(!isDefined(streak)) {
        streak = 0;
      }

      return [int(streak), streakinstance.var_6cb812578f7d9ae7];
    }
  }

  return [0, []];
}

function function_52384260fe709f19(player, index) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  index += 1;
  assert(index >= 1 && index <= 12, "<dev string:x121>" + index);
  function_dc67872cc4cfae72(player, 2, index);
}

function function_bfedeb20f8b77f3f(player, slot, var_4850537bc9bf2170) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(istrue(var_4850537bc9bf2170) && !function_6484ce4430c9439b(player, slot)) {
    return;
  }

  if(slot == 2) {
    function_dc67872cc4cfae72(player, 2, 0);
    return;
  }

  instanceslot = function_4ad0394e9ad7176d(slot);
  function_dc67872cc4cfae72(player, 1, instanceslot);
}

function function_351fe4ac57ca37e5(player, slot) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  instanceslot = function_f1c7356a808e9bd9(slot);

  if(!isDefined(instanceslot)) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, instanceslot);
}

function function_28550536ebafe216(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 0);
}

function function_55dc9108a9301e59(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 4);
}

function function_a60428cda4724a7(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 3);
}

function function_5b7dc44bb66553a6(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 1);
}

function function_ea96b27797c7e268(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 65535, 2);
}

function private swapinstances(player, instance1, instance2, location1, location2, var_4a10e88291db3581, var_4a10e58291db2ee8) {
  player function_da187bcae911d661(instance1.instanceid, 2, 13);
  player function_da187bcae911d661(instance2.instanceid, location1, var_4a10e88291db3581);
  player function_da187bcae911d661(instance1.instanceid, location2, var_4a10e58291db2ee8);
}

function function_ab1505092d4e2a8c(player, var_87f0698dc7ac0a09, location, sublocation, var_760480dc8b6f2623) {
  weaponinstance = player function_644ed519cac9722b(location, sublocation);

  if(weaponinstance.instanceid != "0" && weaponinstance.lootid != 0 && weaponinstance.kind != 11) {
    var_85166da84e55de25 = function_423648b9c03fdaa1(15, weaponinstance, 1);

    if(function_3a8d97d9e7d9e535(player, weaponinstance) > getsystemtime()) {
      player function_dd5661ebe3c9a5a2(weaponinstance.instanceid);
    } else if(istrue(var_760480dc8b6f2623[var_85166da84e55de25])) {
      player function_dd5661ebe3c9a5a2(weaponinstance.instanceid);
    } else {
      var_760480dc8b6f2623[var_85166da84e55de25] = 1;
      var_5170a7c15b09f348 = function_bf2fa755e8269ca8([1], [var_87f0698dc7ac0a09], weaponinstance);

      if(isDefined(var_5170a7c15b09f348)) {
        function_cd81c0e152649846(player, weaponinstance, var_5170a7c15b09f348);
      }

      weaponinstance = player function_644ed519cac9722b(location, sublocation);

      function_72fe945f29c8bce6(weaponinstance);

      player.var_b1bf418aa7242c1d[player.var_b1bf418aa7242c1d.size] = weaponinstance;
      return var_760480dc8b6f2623;
    }
  }

  return var_760480dc8b6f2623;
}

function function_8d65122ea2e88ecd(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(isDefined(player.var_b1bf418aa7242c1d)) {
    return;
  }

  player.var_b1bf418aa7242c1d = [];
  var_87f0698dc7ac0a09 = function_a3d464413e73f057(player);
  var_760480dc8b6f2623 = [];
  var_760480dc8b6f2623 = function_ab1505092d4e2a8c(player, var_87f0698dc7ac0a09, 2, 0, var_760480dc8b6f2623);
  var_760480dc8b6f2623 = function_ab1505092d4e2a8c(player, var_87f0698dc7ac0a09, 1, 0, var_760480dc8b6f2623);
  var_760480dc8b6f2623 = function_ab1505092d4e2a8c(player, var_87f0698dc7ac0a09, 1, 1, var_760480dc8b6f2623);
}

function function_db31af9bfc65ea51(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player.initialequipment = [];
  lethalinstance = player function_644ed519cac9722b(1, 2);

  if(lethalinstance.instanceid != "0" && lethalinstance.lootid != 0) {
    player.initialequipment[2] = lethalinstance.lootid;
  }

  tacticalinstance = player function_644ed519cac9722b(1, 3);

  if(tacticalinstance.instanceid != "0" && tacticalinstance.lootid != 0) {
    player.initialequipment[3] = tacticalinstance.lootid;
  }

  var_bed94c5e8ba6c57e = player function_644ed519cac9722b(1, 4);

  if(var_bed94c5e8ba6c57e.instanceid != "0" && var_bed94c5e8ba6c57e.lootid != 0) {
    player.initialequipment[4] = var_bed94c5e8ba6c57e.lootid;
  }
}

function function_33366ade5697aa38(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  println(player.name + "<dev string:x15b>");
  function_a839b9ad5740477d(player, 2, 0);

  for(backpackindex = 0; backpackindex < 11; backpackindex++) {
    lootinstance = player function_644ed519cac9722b(2, 1 + backpackindex);
    lootid = lootinstance.lootid;
    quantity = function_423648b9c03fdaa1(3, lootinstance, 0);
    quantity = int(default_to(quantity, 1));
    player setplayerdata(level.var_5d69837cf4db0407, "dmzBackpack", backpackindex, "lootID", lootid);
    player setplayerdata(level.var_5d69837cf4db0407, "dmzBackpack", backpackindex, "quantity", quantity);
    player namespace_512200f0f9e6ebc9::function_bac731e0fdaa0ccb(lootid);
  }

  println(player.name + "<dev string:x18a>");

  for(backpackindex = 0; backpackindex < 11; backpackindex++) {
    lootid = player getlootidatbackpackindex(backpackindex);
    quantity = player function_897b29adb37f06a7(backpackindex);
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    println("<dev string:x19c>" + backpackindex + "<dev string:x1a1>" + lootid + "<dev string:x1ab>" + ref + "<dev string:x1b1>" + lootid);
    println("<dev string:x19c>" + backpackindex + "<dev string:x1b8>" + lootid + "<dev string:x1ab>" + ref + "<dev string:x1b1>" + quantity);
  }
}

function function_f1c7356a808e9bd9(equipmentslot) {
  switch (equipmentslot) {
    case #"hash_325cb2e66f67d5b9":
      return 2;
    case #"hash_511d3c24fcedcdb1":
      return 3;
    case #"hash_e534fd8ec73eafb4":
      return 4;
    case #"hash_723175e1d432ccef":
    default:
      return undefined;
  }
}

function function_56ec0560843aa9a4(player) {
  var_a0e4abf938dbe26b = player function_644ed519cac9722b(1, 5);

  if(istrue(function_59352c09a417a5e2(player, 28)) && isDefined(var_a0e4abf938dbe26b) && var_a0e4abf938dbe26b.instanceid != "0") {
    return var_a0e4abf938dbe26b.quantity;
  }

  return function_1d6d967dbf6dfa05(player);
}

function function_416ab73109b71d69(player) {
  var_a0e4abf938dbe26b = player function_644ed519cac9722b(1, 5);

  if(istrue(function_59352c09a417a5e2(player, 28)) && isDefined(var_a0e4abf938dbe26b) && var_a0e4abf938dbe26b.instanceid != "0") {
    return var_a0e4abf938dbe26b.quantity;
  }

  return 0;
}

function function_b9e5b13d100aa0f5(player, quantity) {
  var_a0e4abf938dbe26b = player function_644ed519cac9722b(1, 5);

  if(istrue(function_59352c09a417a5e2(player, 28)) && isDefined(var_a0e4abf938dbe26b) && var_a0e4abf938dbe26b.instanceid != "0") {
    player function_77eff0a02c92c9b7(var_a0e4abf938dbe26b.instanceid, quantity);
  }
}

function function_695fdeab4db350b4(player) {
  var_8a9d33941712cf66 = 0;

  if(istrue(function_59352c09a417a5e2(player, 28))) {
    var_8a9d33941712cf66 = 10000;
    var_4deb41b14261b5 = int(min(getupgradecount(player, 15), 18));

    if(isDefined(var_4deb41b14261b5)) {
      var_8a9d33941712cf66 += var_4deb41b14261b5 * 5000;
    }
  }

  return var_8a9d33941712cf66;
}

function bankcash(player) {
  if(!istrue(function_59352c09a417a5e2(player, 28))) {
    return;
  }

  plundercount = 0;

  if(isDefined(player.plundercount) && player.plundercount > 0) {
    plundercount = player.plundercount;
  }

  var_8a9d33941712cf66 = function_695fdeab4db350b4(player);
  cashbalance = player function_7aee6670da372309();
  balancespace = var_8a9d33941712cf66 - cashbalance;

  if(balancespace > 0) {
    intobalance = 0;

    if(balancespace >= plundercount) {
      intobalance = plundercount;
    } else {
      intobalance = balancespace;
    }

    player function_a653645c73c1f9f8(intobalance);
    plundercount -= intobalance;
  }

  function_b9e5b13d100aa0f5(player, plundercount);
}

function function_7d760edc2a7e9b8f(player) {
  var_8a9d33941712cf66 = function_695fdeab4db350b4(player);
  cashbalance = player function_7aee6670da372309();

  if(cashbalance > var_8a9d33941712cf66) {
    player function_2fb23b36f31441c5(var_8a9d33941712cf66);
  }

  var_80d194bff78511db = function_416ab73109b71d69(player);

  if(var_80d194bff78511db > 25000) {
    function_b9e5b13d100aa0f5(player, 25000);
  }
}

function savecash(player) {
  plundercount = 0;

  if(isDefined(player.plundercount) && player.plundercount > 0) {
    plundercount = player.plundercount;
  }

  if(istrue(function_59352c09a417a5e2(player, 28))) {
    function_b9e5b13d100aa0f5(player, plundercount);
    return;
  }

  player setplayerdata(level.var_5d69837cf4db0407, "dmzPocketCash", plundercount);
}

function function_cd234cdd6b1b3699(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_1341f0ae49d492cd(player, 1);
  function_1d553b4e5df1cb3e(player);
}

function function_ea65e35c77f7679b(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  ownedstashitems = [];
  player.pers["telemetry"].var_7e78e00462492360 = [];
  var_f41d7258200e1d08 = namespace_aead94004cf4c147::function_c4f1bd7a01a307fa(player);
  extractedstashitems = scripts\mp\utility\teams::getteamdata(player.team, "extractedStashItems");

  for(backpackindex = 0; backpackindex < 11; backpackindex++) {
    lootinstance = player function_644ed519cac9722b(2, 1 + backpackindex);

    if(lootinstance.instanceid != "0") {
      var_25978461c6e4f61b = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootinstance.lootid);

      if(isDefined(var_25978461c6e4f61b)) {
        var_a38e261031751c09 = scripts\mp\gametypes\br_pickups::function_a38e261031751c09(var_25978461c6e4f61b);
        player.pers["telemetry"].var_7e78e00462492360[backpackindex] = 0;

        if(!scripts\mp\gametypes\br_pickups::iskey(var_25978461c6e4f61b) && !var_a38e261031751c09 && !var_f41d7258200e1d08) {
          player namespace_aead94004cf4c147::function_db1dd76061352e5b(backpackindex);
          player.pers["telemetry"].var_7e78e00462492360[backpackindex] = 1;
          continue;
        }

        if(var_a38e261031751c09) {
          ownedstashitems[lootinstance.lootid] = 1;
          currentquantity = player namespace_aead94004cf4c147::function_897b29adb37f06a7(backpackindex);
          function_f605baf61d74d8df(player, lootinstance, currentquantity);
        }
      }
    }
  }

  if(var_f41d7258200e1d08) {
    function_1341f0ae49d492cd(player);
  }

  foreach(stashitemid, _ in extractedstashitems) {
    if(!istrue(ownedstashitems[stashitemid])) {
      backpackindex = player namespace_aead94004cf4c147::getavailabledmzbackpackindex();

      if(isDefined(backpackindex)) {
        namespace_aead94004cf4c147::function_11f48ae5b87b4525(player, backpackindex, stashitemid, 1);
      }
    }
  }

  function_1d553b4e5df1cb3e(player);
  function_6b94748791fa241c(player);
  bankcash(player);
}

function function_f605baf61d74d8df(player, lootinstance, quantity) {
  var_5170a7c15b09f348 = function_bf2fa755e8269ca8([3], [quantity], lootinstance);

  if(isDefined(var_5170a7c15b09f348)) {
    function_cd81c0e152649846(player, lootinstance, var_5170a7c15b09f348);
  }
}

function function_1341f0ae49d492cd(player, var_fd5de2fbc2159648, infil) {
  for(backpackindex = 0; backpackindex < 11; backpackindex++) {
    lootinstance = player function_644ed519cac9722b(2, 1 + backpackindex);

    if(lootinstance.instanceid != "0") {
      if(function_957f1b4b0dc253d9(lootinstance.lootid, var_fd5de2fbc2159648, infil)) {
        function_52384260fe709f19(player, backpackindex);

        if(istrue(var_fd5de2fbc2159648)) {
          method = scripts\cp_mp\challenges::function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"extract"));
          scripts\cp_mp\challenges::function_d24138b32084fc3e(player, lootinstance.lootid, undefined, method, 1, 0);
        }

        continue;
      }

      if(!istrue(infil)) {
        currentquantity = player namespace_aead94004cf4c147::function_897b29adb37f06a7(backpackindex);

        if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootinstance.lootid)) {
          currentquantity = scripts\mp\gametypes\dmz_dog_tag::function_20d00accaa12c27f();
        } else if(!istrue(player.extracted) && isDefined(player.var_457667014505e1f9) && isDefined(player.var_457667014505e1f9[backpackindex]) && player.var_457667014505e1f9[backpackindex]["lootID"] == lootinstance.lootid) {
          currentquantity = player.var_457667014505e1f9[backpackindex]["quantity"];

          if(!isDefined(currentquantity)) {
            currentquantity = 1;
          }
        }

        function_f605baf61d74d8df(player, lootinstance, currentquantity);
      }
    }
  }
}

function function_957f1b4b0dc253d9(lootid, var_fd5de2fbc2159648, infil) {
  return !istrue(var_fd5de2fbc2159648) && !(istrue(infil) && istrue(level.var_a25720e982f459fb)) && function_f6f8c1fc9549eaf6(lootid) || function_8e61ef2a2f9137e7(lootid) || function_b4893066110f4d10(lootid);
}

function function_a3bbd9874f6a5599(lootid, var_fd5de2fbc2159648, infil) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  var_907944a173ed27e1 = isDefined(scriptablename) && scripts\mp\supers::function_907944a173ed27e1(scriptablename);
  var_d8d84c04a1b3965 = isDefined(scriptablename) && (var_907944a173ed27e1 || scripts\mp\gametypes\br_pickups::function_3cad96c265936df7(scriptablename));
  return !istrue(var_fd5de2fbc2159648) && !(istrue(infil) && istrue(level.var_a25720e982f459fb)) && function_f6f8c1fc9549eaf6(lootid) || var_d8d84c04a1b3965 && !istrue(var_fd5de2fbc2159648) && !istrue(infil) || var_907944a173ed27e1 && istrue(var_fd5de2fbc2159648);
}

function private function_6b94748791fa241c(player) {
  if(!istrue(level.var_e442ba065dd78f24)) {
    return;
  }

  if(!isDefined(player.var_54d33ff1df87c60f)) {
    return;
  }

  function_bfedeb20f8b77f3f(player, player.var_54d33ff1df87c60f);
}

function function_ed325a060adcbe65(player) {
  if(!istrue(level.var_e442ba065dd78f24)) {
    return;
  }

  foreach(weaponslot in [0, 1]) {
    weapon = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, weaponslot);

    if(isDefined(weapon) && weaponclass(weapon) == "sniper" && weapon hasattachment("unique_sn_alpha50_stpats")) {
      player.var_54d33ff1df87c60f = weaponslot;
      return;
    }
  }

  if(!isDefined(player.var_54d33ff1df87c60f)) {
    weapon = namespace_aead94004cf4c147::function_2985254128b1c262(player);

    if(isDefined(weapon) && weaponclass(weapon) == "sniper" && weapon hasattachment("unique_sn_alpha50_stpats")) {
      player.var_54d33ff1df87c60f = 2;
    }
  }
}

function private function_181f84b6e516d4e6(weaponinstance, prefix) {
  itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(weaponinstance.lootid);
  prefix = prefix + " ID: " + weaponinstance.lootid + " " + itemref + " ";

  if(isDefined(weaponinstance.var_6cb812578f7d9ae7)) {
    foreach(childindex, childlootid in weaponinstance.var_6cb812578f7d9ae7) {
      if(isDefined(childlootid) && childlootid != 0) {
        prefix = prefix + " Child " + childindex + ": " + childlootid + " ";
      }
    }
  }

  return prefix;
}

function private function_e29c498dd636939a(instance, prefix) {
  itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(instance.lootid);
  return prefix + instance.lootid + " " + itemref;
}

function function_ddd16c8b86863b56(player) {
  operatorindex = player getplayerdata(level.var_5d69837cf4db0407, "dmzActiveOperatorSlot");
  return operatorindex - 100;
}

function function_1d6d967dbf6dfa05(player) {
  cash = player getplayerdata(level.var_5d69837cf4db0407, "dmzPocketCash");
  player setplayerdata(level.var_5d69837cf4db0407, "dmzPocketCash", 0);
  return cash;
}

function function_c241fbc63120cfc4(player, onconnect) {
  if(!function_e0fc1230452cf4e7()) {
    return false;
  }

  operatorskin = function_ef8648922f0937b9(player);
  backpackinstance = player function_644ed519cac9722b(65535, 1);
  defaultbackpack = scripts\cp_mp\operator::function_a317055d4d0a4605(operatorskin);
  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpackinstance.lootid);

  if(backpackinstance.instanceid != "0" && isDefined(scriptable) && scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scriptable)) {
    backpacksize = namespace_aead94004cf4c147::function_3188d9c94b3d56c2(scripts\cp_mp\utility\loot::getscriptablefromlootid(backpackinstance.lootid));
    namespace_aead94004cf4c147::function_d28f52da6ede0191(player, backpacksize, undefined, backpackinstance.lootid);
  } else if(isDefined(operatorskin) && isDefined(defaultbackpack)) {
    scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(defaultbackpack);
    assert(scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scriptable));
    function_92d947129ea5ba6e(player, defaultbackpack);
    backpacksize = namespace_aead94004cf4c147::function_3188d9c94b3d56c2(scriptable);
    namespace_aead94004cf4c147::function_d28f52da6ede0191(player, backpacksize, undefined, defaultbackpack);
  } else {
    namespace_aead94004cf4c147::function_d28f52da6ede0191(player, 5);
  }

  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
  loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(var_6267a5ad12c5e4d4.lootid);

  if(var_6267a5ad12c5e4d4.instanceid != "0" && var_6267a5ad12c5e4d4.lootid > 0) {
    currentbackpack = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(namespace_aead94004cf4c147::function_102abd6883c5f9bf(player));
    var_6d77d0560b815b93 = namespace_aead94004cf4c147::function_18e2d7a6912b1d07(currentbackpack);

    if(isDefined(loottype) && loottype == "weapon" && var_6d77d0560b815b93) {
      function_a839b9ad5740477d(player, 2, 0, onconnect);
    } else {
      function_f910b139e75fd559(player);
    }
  }

  var_dc62a204e1921a99 = player function_644ed519cac9722b(65535, 4);

  if(var_dc62a204e1921a99.instanceid != "0") {
    scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(var_dc62a204e1921a99.lootid);

    if(isDefined(scriptable) && scripts\mp\gametypes\br_pickups::isgasmask(scriptable)) {
      player scripts\cp_mp\gasmask::init(undefined, scriptable);
    } else {
      function_55dc9108a9301e59(player);
    }
  } else if(isDefined(operatorskin)) {
    var_7c64a9a794249d9f = scripts\cp_mp\operator::function_8d92d3fb88a9d34(operatorskin);

    if(isDefined(var_7c64a9a794249d9f)) {
      scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(var_7c64a9a794249d9f);
      assert(scripts\mp\gametypes\br_pickups::isgasmask(scriptable));
      function_2dd07f0034a0fed1(player, var_7c64a9a794249d9f);
      player scripts\cp_mp\gasmask::init(undefined, scriptable);
    }
  }

  var_ea074533d9558d3d = player function_644ed519cac9722b(65535, 3);
  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(var_ea074533d9558d3d.lootid);
  var_a96a2ab9bf3042d5 = undefined;

  if(isDefined(operatorskin)) {
    var_a96a2ab9bf3042d5 = scripts\cp_mp\operator::function_a3195a1d60bb2d90(operatorskin);
  }

  if(var_ea074533d9558d3d.instanceid != "0" && isDefined(scriptable) && scripts\mp\gametypes\br_pickups::isrevivepickup(scriptable)) {
    player scripts\mp\gametypes\br_pickups::function_aaaa1b3dfe18885c(1, var_ea074533d9558d3d.lootid);
  } else if(isDefined(var_a96a2ab9bf3042d5)) {
    assert(scripts\mp\gametypes\br_pickups::isrevivepickup(scripts\cp_mp\utility\loot::getscriptablefromlootid(var_a96a2ab9bf3042d5)));
    function_c0ae57d4dc3a8eef(player, var_a96a2ab9bf3042d5);
    player scripts\mp\gametypes\br_pickups::function_aaaa1b3dfe18885c(1, var_a96a2ab9bf3042d5);
  }

  var_928d2239ab126d72 = player function_644ed519cac9722b(65535, 5);
  featureref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(var_928d2239ab126d72.lootid);

  if(var_928d2239ab126d72.instanceid != "0" && isDefined(featureref) && featureref == "dmz_exfil_streak") {
    scripts\mp\gametypes\br_gametype_dmz::function_470b4aaafd986a0d(player);
  } else {
    player scripts\mp\gametypes\br_gametype_dmz::function_1a425272955d5f75();
  }

  namespace_a38a2e1fe7519183::function_1341f0ae49d492cd(player, 0, 1);
  function_8d65122ea2e88ecd(player);
  function_db31af9bfc65ea51(player);
  return true;
}

function function_fc56050bd3dcea6c(player) {
  if(!function_e0fc1230452cf4e7()) {
    return 0;
  }

  var_ea074533d9558d3d = player function_644ed519cac9722b(65535, 3);
  var_a96a2ab9bf3042d5 = undefined;
  operatorskin = function_ef8648922f0937b9(player);

  if(isDefined(operatorskin)) {
    var_a96a2ab9bf3042d5 = scripts\cp_mp\operator::function_a3195a1d60bb2d90(operatorskin);
  }

  if(var_ea074533d9558d3d.instanceid == "0" && !isDefined(var_a96a2ab9bf3042d5) && isDefined(player.team)) {
    if(function_59352c09a417a5e2(player, 30)) {
      teamplayers = scripts\mp\utility\teams::getteamdata(player.team, "players");

      if(isDefined(teamplayers) && teamplayers.size == 1) {
        function_c0ae57d4dc3a8eef(player, scripts\cp_mp\utility\loot::getlootidfromref("brloot_self_revive"));
        player scripts\mp\gametypes\br_pickups::function_aaaa1b3dfe18885c(1);
      }
    }
  }
}

function function_a9857977596563cd(player, reductiontime) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_53d2be04710104ca(player, function_b41e38c8836a823e(player, 0), reductiontime);
  function_53d2be04710104ca(player, function_b41e38c8836a823e(player, 1), reductiontime);
  function_53d2be04710104ca(player, function_b41e38c8836a823e(player, 2), reductiontime);
}

function function_53d2be04710104ca(player, instance, reductiontime) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  currentcooldown = int(default_to(instance.var_b34159f22f6379c9, 0));

  if(currentcooldown <= getsystemtime()) {
    return;
  }

  newcooldown = int(max(currentcooldown - reductiontime, 0));
  player function_4e8d00b0ee5d3bbb(instance.instanceid, newcooldown);
}

function private function_b45a3c813eaaa08d(player, instance) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  currentcooldown = function_3a8d97d9e7d9e535(player, instance);

  if(currentcooldown > getsystemtime()) {
    return;
  }

  newcooldown = function_319dc9ed3b41647();

  if(getdvarint(@ "hash_6dc2f0452c76707d", 1) || getdvarint(@ "hash_257cb72a99900ef2", 1)) {
    newcooldown = function_809d965739629dbf(player, instance);
  }

  newcooldown = getsystemtime() + newcooldown;
  var_b0bee880705ae6be = function_869526aec2165ec3(player, instance);
  player function_4e8d00b0ee5d3bbb(var_b0bee880705ae6be.instanceid, int(newcooldown));
}

function function_b41e38c8836a823e(player, index) {
  return player function_644ed519cac9722b(5, index);
}

function function_869526aec2165ec3(player, instance) {
  if(!isDefined(instance) || !isDefined(player) || !isDefined(instance.var_d3c548c09bb62da2)) {
    return 0;
  }

  foreach(data in instance.var_d3c548c09bb62da2) {
    if(data.key == 15) {
      return player function_644ed519cac9722b(5, int(data.value) - 1);
    }
  }
}

function function_3a8d97d9e7d9e535(player, instance) {
  var_b0bee880705ae6be = function_869526aec2165ec3(player, instance);
  return default_to(var_b0bee880705ae6be.var_b34159f22f6379c9, 0);
}

function function_809d965739629dbf(player, instance) {
  if(!isDefined(instance) || !isDefined(player) || !isDefined(instance.var_d3c548c09bb62da2)) {
    return 0;
  }

  var_85166da84e55de25 = function_423648b9c03fdaa1(15, instance, 1);

  if(!isDefined(var_85166da84e55de25)) {
    return function_319dc9ed3b41647();
  }

  potentialcooldown = function_f1aa77738031b49c(instance);

  if(potentialcooldown > 0) {
    return potentialcooldown;
  }

  if(!getdvarint(@ "hash_6dc2f0452c76707d", 1)) {
    return function_319dc9ed3b41647();
  }

  basecooldown = undefined;

  switch (var_85166da84e55de25) {
    case #"hash_31100fbc01bd387c":
      basecooldown = getdvarint(@ "hash_618c3ca8c4897d2c", 7200);
      break;
    case #"hash_311012bc01bd3d35":
      basecooldown = getdvarint(@ "hash_618c3fa8c48983c5", 14400);
      break;
    case #"hash_311011bc01bd3ba2":
      basecooldown = getdvarint(@ "hash_618c3ea8c4898192", 21600);
      break;
    default:
      basecooldown = function_319dc9ed3b41647();
      break;
  }

  var_45b8f5c6792a74f2 = function_1ee6a57e88b1a120(player, var_85166da84e55de25);
  return max(0, basecooldown - basecooldown * var_45b8f5c6792a74f2);
}

function function_f1aa77738031b49c(instance) {
  if(!isDefined(instance.lootid) || instance.lootid == 0) {
    return 0;
  }

  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(instance.lootid);

  if(!isDefined(ref)) {
    return 0;
  }

  rootname = scripts\cp_mp\weapon::getweaponrootname(ref);
  variantid = function_64ccc54bdbae5cf6(instance.lootid);
  cooldown = scripts\cp_mp\weapon::function_115404a4dbd59830(rootname, variantid);
  return cooldown;
}

function function_80478f2ef8c8882f(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  for(i = 0; i < 3; i++) {
    instance = function_b41e38c8836a823e(player, i);

    if(!isDefined(instance)) {
      continue;
    }

    currentcooldown = int(default_to(instance.var_b34159f22f6379c9, 0));

    if(currentcooldown > getsystemtime()) {
      return 1;
    }
  }
}

function function_498ba9b391e5d087(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(!istrue(function_80478f2ef8c8882f(player))) {
    return;
  }

  mincooldown = undefined;

  for(i = 0; i < 3; i++) {
    instance = function_b41e38c8836a823e(player, i);

    if(!isDefined(instance)) {
      continue;
    }

    currentcooldown = int(default_to(instance.var_b34159f22f6379c9, 0));

    if(currentcooldown > getsystemtime()) {
      if(!isDefined(mincooldown)) {
        mincooldown = currentcooldown;
        continue;
      }

      mincooldown = int(min(mincooldown, currentcooldown));
    }
  }

  return mincooldown;
}

function function_319dc9ed3b41647() {
  return getdvarint(@ "hash_40eb514e313dd3ef", 14400);
}

function function_4e92b2a9e565aee() {
  return getdvarint(@ "hash_c5ac098e3a15af33", 3000);
}

function getcurrentweaponinstances(player) {
  currentweaponinstances = [];
  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);

  if(var_6267a5ad12c5e4d4.instanceid != "0" && var_6267a5ad12c5e4d4.lootid != 0) {
    currentweaponinstances[currentweaponinstances.size] = var_6267a5ad12c5e4d4;
  }

  primaryweaponinstance = player function_644ed519cac9722b(1, 0);

  if(primaryweaponinstance.instanceid != "0" && primaryweaponinstance.lootid != 0) {
    currentweaponinstances[currentweaponinstances.size] = primaryweaponinstance;
  }

  secondaryweaponinstance = player function_644ed519cac9722b(1, 1);

  if(secondaryweaponinstance.instanceid != "0" && secondaryweaponinstance.lootid != 0) {
    currentweaponinstances[currentweaponinstances.size] = secondaryweaponinstance;
  }

  return currentweaponinstances;
}

function function_5148f855de907e6f(player, weaponslot) {
  if(!function_e0fc1230452cf4e7()) {
    return undefined;
  }

  weaponinstance = function_540c2b6342f4e28c(player, weaponslot);

  foreach(instance in player.var_b1bf418aa7242c1d) {
    sameweapon = undefined;

    if(function_e7fcc338bf1ccf24(instance, weaponinstance)) {
      return function_423648b9c03fdaa1(15, weaponinstance, 1);
    }
  }

  return undefined;
}

function function_1d553b4e5df1cb3e(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(!isDefined(player.var_b1bf418aa7242c1d)) {
    return;
  }

  currentweaponinstances = getcurrentweaponinstances(player);

  foreach(instance in player.var_b1bf418aa7242c1d) {
    sameweapon = undefined;

    foreach(currentinstance in currentweaponinstances) {
      if(function_e7fcc338bf1ccf24(instance, currentinstance)) {
        sameweapon = currentinstance;
        break;
      }
    }

    if(!isDefined(sameweapon)) {
      function_b45a3c813eaaa08d(player, instance);
      continue;
    }

    if(sameweapon.kind != 14) {
      function_814f4e5c852d9604(player, sameweapon);
    }
  }
}

function function_814f4e5c852d9604(player, instance) {
  player function_dd5661ebe3c9a5a2(instance.instanceid);
  player function_4f1027e74d5073c4(instance.lootid, 14, instance.location, instance.sublocation, instance.var_6cb812578f7d9ae7);
  custominstance = player function_644ed519cac9722b(instance.location, instance.sublocation);

  if(isDefined(instance.metadata)) {
    var_5170a7c15b09f348 = function_fe92418620d93763(instance.metadata);
    player function_e70c1fc3c2e5e05f(custominstance.instanceid, 0, var_5170a7c15b09f348);
  }

  if(isDefined(instance.var_d3c548c09bb62da2)) {
    var_5170a7c15b09f348 = function_fe92418620d93763(instance.var_d3c548c09bb62da2);
    player function_e70c1fc3c2e5e05f(custominstance.instanceid, 1, var_5170a7c15b09f348);
  }
}

function function_2286bf57aede9518(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(!isDefined(player.var_b1bf418aa7242c1d)) {
    return;
  }

  foreach(instance in player.var_b1bf418aa7242c1d) {
    function_b45a3c813eaaa08d(player, instance);
  }
}

function function_cd81c0e152649846(player, instance, metadata, var_d3c548c09bb62da2) {
  player function_e70c1fc3c2e5e05f(instance.instanceid, 0, metadata);

  if(isDefined(var_d3c548c09bb62da2)) {
    player function_e70c1fc3c2e5e05f(instance.instanceid, 1, var_d3c548c09bb62da2);
  }
}

function function_4a84e57f6373e69(key, metadata, var_7f24f2a49f4715f7) {
  if(isDefined(metadata)) {
    foreach(data in metadata) {
      if(key == data.key) {
        if(istrue(var_7f24f2a49f4715f7)) {
          return [data.value, data.valuelow, data.valuehigh];
        }

        return data.value;
      }
    }
  }

  return undefined;
}

function function_423648b9c03fdaa1(key, instance, var_d3c548c09bb62da2, var_7f24f2a49f4715f7) {
  if(!isDefined(key) || !isDefined(instance)) {
    return undefined;
  }

  metadata = instance.metadata;

  if(istrue(var_d3c548c09bb62da2)) {
    metadata = instance.var_d3c548c09bb62da2;
  }

  return function_4a84e57f6373e69(key, metadata, var_7f24f2a49f4715f7);
}

function function_92f14840aa31925d(key, value, metadata) {
  foreach(data in metadata) {
    if(key == data.key) {
      data.value = value;
    }
  }

  return metadata;
}

function private function_e7fcc338bf1ccf24(originalinstance, currentinstance) {
  var_cf86f085f815a526 = function_423648b9c03fdaa1(1, originalinstance);
  var_e51271b38c67dfc6 = function_423648b9c03fdaa1(1, currentinstance);

  if(!isDefined(var_cf86f085f815a526) || !isDefined(var_e51271b38c67dfc6)) {
    return false;
  }

  if(var_cf86f085f815a526 == var_e51271b38c67dfc6) {
    var_f4d447ffd61bcf2 = function_423648b9c03fdaa1(15, originalinstance, 1);
    var_b8250a3b219f951a = function_423648b9c03fdaa1(15, currentinstance, 1);
    return (isDefined(var_f4d447ffd61bcf2) && isDefined(var_b8250a3b219f951a) && var_f4d447ffd61bcf2 == var_b8250a3b219f951a);
  }

  return false;
}

function private function_c60ad978e8ec0345(player, location, sublocation) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  instance = player function_644ed519cac9722b(location, sublocation);
  return [instance.metadata, instance.var_d3c548c09bb62da2];
}

function private function_cd4840758c0f2125(instance) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  return [instance.metadata, instance.var_d3c548c09bb62da2];
}

function function_74031e3249a6f69e(player, slot) {
  if(!function_e0fc1230452cf4e7()) {
    return undefined;
  }

  location = 1;
  sublocation = slot;

  if(slot == 2) {
    location = 2;
    sublocation = 0;
  }

  return function_c60ad978e8ec0345(player, location, sublocation);
}

function function_743a2b4d08f023d2(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  var_2ac478345313402 = player function_644ed519cac9722b(65535, 2);
  operatorskin = function_ef8648922f0937b9(player);
  var_3fc34ca532242bea = scripts\cp_mp\operator::function_81360519d4836bf7(operatorskin);
  var_347aa4935f42810 = scripts\cp_mp\utility\loot::getscriptablefromlootid(var_2ac478345313402.lootid);

  if(var_2ac478345313402.instanceid != "0" && scripts\mp\gametypes\br_public::function_4aa12e0ed3f6b745(var_347aa4935f42810)) {
    platelevel = scripts\mp\gametypes\br_pickups::function_e98a5a4e0e001ac3(player, var_347aa4935f42810, 1);
    return;
  }

  if(isDefined(operatorskin) && isDefined(var_3fc34ca532242bea)) {
    scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(var_2ac478345313402.lootid);
    assert(scripts\mp\gametypes\br_public::function_4aa12e0ed3f6b745(scriptable));
    function_bd01c77ab46f790(player, var_3fc34ca532242bea);
    platelevel = scripts\mp\gametypes\br_pickups::function_e98a5a4e0e001ac3(player, scripts\cp_mp\utility\loot::getscriptablefromlootid(var_3fc34ca532242bea), 1);
    return;
  }

  scripts\mp\gametypes\br_pickups::function_a0877dfcb342653a(player);
}

function function_c0cc833a07b24cd8(player, instance, paramoffset, unlockeventparams, var_11b87ef3f5ccbc5e) {
  lootid = scripts\mp\weapons::function_7a91162092cc11ec(instance.lootid);

  if(!isDefined(lootid) || lootid == 0) {
    return [unlockeventparams, paramoffset];
  }

  if(!isDefined(var_11b87ef3f5ccbc5e[lootid])) {
    unlockeventparams[unlockeventparams.size] = paramoffset;
    unlockeventparams[unlockeventparams.size] = lootid;
    var_11b87ef3f5ccbc5e[lootid] = 1;
    paramoffset += 1;
  }

  variantref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  rootname = scripts\cp_mp\weapon::getweaponrootname(variantref);
  assetname = scripts\cp_mp\weapon::getweaponassetname(rootname);
  attachments = function_6527364c1ecca6c6(assetname);

  foreach(attachment in attachments) {
    attachmentscriptbundle = getscriptbundle(hashcat(%"hash_3c2c9813bb16552f", attachment));

    if(isDefined(attachmentscriptbundle)) {
      attachmentlootid = attachmentscriptbundle.lootid;
    }

    if(!isDefined(attachmentlootid)) {
      continue;
    }

    if(!isDefined(var_11b87ef3f5ccbc5e[attachmentlootid])) {
      unlockeventparams[unlockeventparams.size] = paramoffset;
      unlockeventparams[unlockeventparams.size] = attachmentlootid;
      var_11b87ef3f5ccbc5e[attachmentlootid] = 1;
      paramoffset += 1;
    }
  }

  return [unlockeventparams, paramoffset, var_11b87ef3f5ccbc5e];
}

function unlockitems(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  aeeventname = #"hash_b103a36a0ed8b293";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  unlockeventparams = [];
  var_11b87ef3f5ccbc5e = [];
  unlockeventparams[unlockeventparams.size] = function_d6f771aedba70ce7(aeeventname, #"version");
  unlockeventparams[unlockeventparams.size] = 1;
  var_6be6ee2c96b9685d = function_d6f771aedba70ce7(aeeventname, #"loot_id");
  var_21341c7142d7e704 = var_6be6ee2c96b9685d;
  primaryinstance = player function_644ed519cac9722b(1, 0);
  [unlockeventparams, var_21341c7142d7e704, var_11b87ef3f5ccbc5e] = function_c0cc833a07b24cd8(player, primaryinstance, var_21341c7142d7e704, unlockeventparams, var_11b87ef3f5ccbc5e);
  secondaryinstance = player function_644ed519cac9722b(1, 1);
  [unlockeventparams, var_21341c7142d7e704, var_11b87ef3f5ccbc5e] = function_c0cc833a07b24cd8(player, secondaryinstance, var_21341c7142d7e704, unlockeventparams, var_11b87ef3f5ccbc5e);
  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
  [unlockeventparams, var_21341c7142d7e704, var_11b87ef3f5ccbc5e] = function_c0cc833a07b24cd8(player, var_6267a5ad12c5e4d4, var_21341c7142d7e704, unlockeventparams, var_11b87ef3f5ccbc5e);
  lethalinstance = player function_644ed519cac9722b(1, 2);
  unlockeventparams[unlockeventparams.size] = var_21341c7142d7e704;
  unlockeventparams[unlockeventparams.size] = lethalinstance.lootid;
  var_11b87ef3f5ccbc5e[lethalinstance.lootid] = 1;
  var_21341c7142d7e704++;
  tacticalinstance = player function_644ed519cac9722b(1, 3);
  unlockeventparams[unlockeventparams.size] = var_21341c7142d7e704;
  unlockeventparams[unlockeventparams.size] = tacticalinstance.lootid;
  var_11b87ef3f5ccbc5e[tacticalinstance.lootid] = 1;
  var_21341c7142d7e704++;
  var_bed94c5e8ba6c57e = player function_644ed519cac9722b(1, 4);
  unlockeventparams[unlockeventparams.size] = var_21341c7142d7e704;
  unlockeventparams[unlockeventparams.size] = var_bed94c5e8ba6c57e.lootid;
  var_11b87ef3f5ccbc5e[var_bed94c5e8ba6c57e.lootid] = 1;
  var_21341c7142d7e704++;
  killstreakinstance = player function_644ed519cac9722b(65535, 0);
  unlockeventparams[unlockeventparams.size] = var_21341c7142d7e704;
  unlockeventparams[unlockeventparams.size] = killstreakinstance.lootid;
  var_11b87ef3f5ccbc5e[killstreakinstance.lootid] = 1;
  var_21341c7142d7e704++;

  for(backpackindex = 1; backpackindex <= 12; backpackindex++) {
    backpackinstance = player function_644ed519cac9722b(2, backpackindex);

    if(!isDefined(var_11b87ef3f5ccbc5e[backpackinstance.lootid])) {
      unlockeventparams[unlockeventparams.size] = var_21341c7142d7e704;
      unlockeventparams[unlockeventparams.size] = backpackinstance.lootid;
      var_11b87ef3f5ccbc5e[backpackinstance.lootid] = 1;
      var_21341c7142d7e704++;
    }
  }

  var_23d99faf8c73c = var_21341c7142d7e704 - function_d6f771aedba70ce7(aeeventname, #"loot_id");
  assertmsg(var_23d99faf8c73c <= 49, "<dev string:x1c8>" + var_23d99faf8c73c + "<dev string:x1ee>" + 49 + "<dev string:x218>");

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    player function_f3bb4f4911a1beb2("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, unlockeventparams);
  }
}

function function_ef552df845e8b952(player) {
  if(function_6484ce4430c9439b(player, 0)) {
    function_dc67872cc4cfae72(player, 1, 0);
  }

  if(function_6484ce4430c9439b(player, 1)) {
    function_dc67872cc4cfae72(player, 1, 1);
  }

  function_f910b139e75fd559(player);
  function_351fe4ac57ca37e5(player, "primary");
  function_351fe4ac57ca37e5(player, "secondary");
  function_351fe4ac57ca37e5(player, "super");
  function_28550536ebafe216(player);
  function_55dc9108a9301e59(player);
  function_a60428cda4724a7(player);
  function_5b7dc44bb66553a6(player);
  function_ea96b27797c7e268(player);

  if(!namespace_aead94004cf4c147::function_c4f1bd7a01a307fa(player)) {
    function_f30f21d87c483297(player);
  }
}

function function_e8b12ce137e718cd(player) {
  if(!isDefined(player.initialequipment)) {
    return;
  }

  if(isDefined(player.initialequipment[2])) {
    equipref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(player.initialequipment[2]);
    isselectable = scripts\mp\equipment::isequipmentselectable(equipref);

    if(istrue(isselectable)) {
      player function_4f1027e74d5073c4(player.initialequipment[2], 13, 1, 2, []);
    }
  }

  if(isDefined(player.initialequipment[3])) {
    equipref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(player.initialequipment[3]);
    isselectable = scripts\mp\equipment::isequipmentselectable(equipref);

    if(istrue(isselectable)) {
      player function_4f1027e74d5073c4(player.initialequipment[3], 13, 1, 3, []);
    }
  }

  if(isDefined(player.initialequipment[4])) {
    superref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(player.initialequipment[4]);
    var_94deac09d462d41e = scripts\mp\supers::function_5cc7d8c432d5d6c1(superref);
    var_41f94bca374ed58a = scripts\mp\supers::function_c519ae03535afe0f(superref);

    if(!istrue(var_94deac09d462d41e) || isDefined(var_41f94bca374ed58a) && function_59352c09a417a5e2(player, var_41f94bca374ed58a)) {
      player function_4f1027e74d5073c4(player.initialequipment[4], 13, 1, 4, []);
    }
  }
}

function function_868b6d4fbec3938c(player) {
  function_c1bb256c7473f345(player);
  function_b9e5b13d100aa0f5(player, 0);
  function_e8b12ce137e718cd(player);
}

function function_c1bb256c7473f345(player) {
  function_2286bf57aede9518(player);
  function_dc67872cc4cfae72(player, 1, 0);
  function_dc67872cc4cfae72(player, 1, 1);
  function_f910b139e75fd559(player);
  function_351fe4ac57ca37e5(player, "primary");
  function_351fe4ac57ca37e5(player, "secondary");
  function_351fe4ac57ca37e5(player, "super");
  function_28550536ebafe216(player);
  function_55dc9108a9301e59(player);
  function_a60428cda4724a7(player);
  function_5b7dc44bb66553a6(player);
  function_ea96b27797c7e268(player);
  function_7bc70fc1dd299f89(player);
  function_80ff109723716c07(player);

  if(!namespace_aead94004cf4c147::function_c4f1bd7a01a307fa(player)) {
    function_f30f21d87c483297(player);
    return;
  }

  function_1341f0ae49d492cd(player);
}

function function_f30f21d87c483297(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  for(backpackindex = 0; backpackindex < 11; backpackindex++) {
    function_52384260fe709f19(player, backpackindex);
  }
}

function applyupdates(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  player function_78ec884c707a6adc();
}

function function_4b57e9867785e738(player) {
  if(!function_e0fc1230452cf4e7() || !istrue(inventoryisValid(player))) {
    return false;
  }

  for(var_a7c9e7c67496899e = 0; var_a7c9e7c67496899e <= 1; var_a7c9e7c67496899e++) {
    weaponinstance = player function_644ed519cac9722b(1, var_a7c9e7c67496899e);

    if(isDefined(weaponinstance.kind) && weaponinstance.kind == 14) {
      return true;
    }
  }

  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);

  if(isDefined(var_6267a5ad12c5e4d4.kind) && var_6267a5ad12c5e4d4.kind == 14) {
    return true;
  }

  return false;
}

function function_4d95079ff587fdb9(player) {
  if(!function_e0fc1230452cf4e7()) {
    return false;
  }

  for(var_a7c9e7c67496899e = 0; var_a7c9e7c67496899e <= 1; var_a7c9e7c67496899e++) {
    weaponinstance = player function_644ed519cac9722b(1, var_a7c9e7c67496899e);

    if(isDefined(weaponinstance.kind) && weaponinstance.kind == 11) {
      return true;
    }
  }

  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);

  if(isDefined(var_6267a5ad12c5e4d4.kind) && var_6267a5ad12c5e4d4.kind == 11) {
    return true;
  }

  return false;
}

function function_7bc089fe8fde43c7(player, weaponslot) {
  weaponinstance = function_540c2b6342f4e28c(player, weaponslot);

  if(isDefined(weaponinstance)) {
    if(isDefined(weaponinstance.kind) && weaponinstance.kind == 11) {
      return true;
    }
  }

  return false;
}

function function_e64d9a42c66018c9(player) {
  if(!istrue(inventoryisValid(player))) {
    return;
  }

  primaryinstance = player function_644ed519cac9722b(1, 0);
  weaponstring = "<dev string:x27e>";
  println(function_181f84b6e516d4e6(primaryinstance, weaponstring));
  secondaryinstance = player function_644ed519cac9722b(1, 1);
  weaponstring = "<dev string:x293>";
  println(function_181f84b6e516d4e6(secondaryinstance, weaponstring));
  var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);
  weaponstring = "<dev string:x2a8>";
  println(function_181f84b6e516d4e6(var_6267a5ad12c5e4d4, weaponstring));
  lethalinstance = player function_644ed519cac9722b(1, 2);
  println("<dev string:x2bc>" + lethalinstance.lootid);
  tacticalinstance = player function_644ed519cac9722b(1, 3);
  println("<dev string:x2dd>" + tacticalinstance.lootid);
  var_bed94c5e8ba6c57e = player function_644ed519cac9722b(1, 4);
  println("<dev string:x300>" + var_bed94c5e8ba6c57e.lootid);
  killstreakinstance = player function_644ed519cac9722b(65535, 0);
  println("<dev string:x31e>" + killstreakinstance.lootid);
  var_dc62a204e1921a99 = player function_644ed519cac9722b(65535, 4);
  println("<dev string:x339>" + var_dc62a204e1921a99.lootid);
  backpackinstance = player function_644ed519cac9722b(65535, 1);
  println("<dev string:x352>" + backpackinstance.lootid);
  var_ea074533d9558d3d = player function_644ed519cac9722b(65535, 3);
  println("<dev string:x36b>" + var_ea074533d9558d3d.lootid);
  var_50b1b73063d6e846 = player function_644ed519cac9722b(1, 12);
  println("<dev string:x387>" + var_50b1b73063d6e846.lootid);
  var_c8bbed73f0438ec8 = player function_644ed519cac9722b(1, 13);
  println("<dev string:x3a7>" + var_c8bbed73f0438ec8.lootid);
  var_9cdf915529700821 = player function_644ed519cac9722b(1, 14);
  println("<dev string:x3c6>" + var_9cdf915529700821.lootid);
  var_a4462a64012f11a5 = player function_644ed519cac9722b(1, 15);
  println("<dev string:x3e4>" + var_a4462a64012f11a5.lootid);
  var_78ae3551b1d877da = player function_644ed519cac9722b(1, 16);
  println("<dev string:x404>" + var_78ae3551b1d877da.lootid);

  for(backpackindex = 1; backpackindex <= 12; backpackindex++) {
    backpackinstance = player function_644ed519cac9722b(2, backpackindex);
    println("<dev string:x423>" + backpackindex + "<dev string:x435>" + backpackinstance.lootid);
  }
}

function function_540204218b5dd9da(player) {
  var_1580961b4a92675c = 7;
  player.var_6f7281f031b30320 = [];

  for(i = 0; i <= var_1580961b4a92675c; i++) {
    player.var_6f7281f031b30320[i] = createfontstring("default", 0.8);
  }
}

function function_c563bbc48f1dd3d2(player) {
  if(!istrue(inventoryisValid(player))) {
    return;
  }

  while(true) {
    if(!isDefined(player.var_6f7281f031b30320)) {
      function_540204218b5dd9da(player);
    }

    primaryinstance = player function_644ed519cac9722b(1, 0);

    player.var_6f7281f031b30320[0] setdevtext(function_181f84b6e516d4e6(primaryinstance, "<dev string:x27e>"));

    player.var_6f7281f031b30320[0] setpoint("TOPLEFT", "TOPLEFT", 250, 30);
    player.var_6f7281f031b30320[0] clearalltextafterhudelem();
    secondaryinstance = player function_644ed519cac9722b(1, 1);

    player.var_6f7281f031b30320[1] setdevtext(function_181f84b6e516d4e6(secondaryinstance, "<dev string:x293>"));

    player.var_6f7281f031b30320[1] setpoint("TOPLEFT", "TOPLEFT", 250, 40);
    player.var_6f7281f031b30320[1] clearalltextafterhudelem();
    var_6267a5ad12c5e4d4 = player function_644ed519cac9722b(2, 0);

    player.var_6f7281f031b30320[2] setdevtext(function_181f84b6e516d4e6(var_6267a5ad12c5e4d4, "<dev string:x2a8>"));

    player.var_6f7281f031b30320[2] setpoint("TOPLEFT", "TOPLEFT", 250, 50);
    player.var_6f7281f031b30320[2] clearalltextafterhudelem();
    lethalinstance = player function_644ed519cac9722b(1, 2);
    tacticalinstance = player function_644ed519cac9722b(1, 3);

    player.var_6f7281f031b30320[3] setdevtext(function_e29c498dd636939a(lethalinstance, "<dev string:x2bc>") + "<dev string:x43e>" + function_e29c498dd636939a(tacticalinstance, "<dev string:x443>"));

    player.var_6f7281f031b30320[3] setpoint("TOPLEFT", "TOPLEFT", 250, 60);
    player.var_6f7281f031b30320[3] clearalltextafterhudelem();
    player.var_6f7281f031b30320[3].archived = 0;
    var_bed94c5e8ba6c57e = player function_644ed519cac9722b(1, 4);
    killstreakinstance = player function_644ed519cac9722b(65535, 0);

    player.var_6f7281f031b30320[4] setdevtext(function_e29c498dd636939a(var_bed94c5e8ba6c57e, "<dev string:x467>") + "<dev string:x43e>" + function_e29c498dd636939a(killstreakinstance, "<dev string:x48f>"));

    player.var_6f7281f031b30320[4] setpoint("TOPLEFT", "TOPLEFT", 250, 80);
    player.var_6f7281f031b30320[4] clearalltextafterhudelem();
    player.var_6f7281f031b30320[4].archived = 0;
    var_dc62a204e1921a99 = player function_644ed519cac9722b(65535, 4);
    backpackinstance = player function_644ed519cac9722b(65535, 1);
    var_2ac478345313402 = player function_644ed519cac9722b(65535, 2);
    var_ea074533d9558d3d = player function_644ed519cac9722b(65535, 3);

    player.var_6f7281f031b30320[5] setdevtext(function_e29c498dd636939a(var_dc62a204e1921a99, "<dev string:x339>") + "<dev string:x43e>" + function_e29c498dd636939a(backpackinstance, "<dev string:x4ac>") + "<dev string:x43e>" + function_e29c498dd636939a(var_ea074533d9558d3d, "<dev string:x4c6>") + "<dev string:x43e>" + function_e29c498dd636939a(var_2ac478345313402, "<dev string:x4e3>"));

    player.var_6f7281f031b30320[5] setpoint("TOPLEFT", "TOPLEFT", 250, 100);
    player.var_6f7281f031b30320[5] clearalltextafterhudelem();
    player.var_6f7281f031b30320[5].archived = 0;
    var_50b1b73063d6e846 = player function_644ed519cac9722b(1, 12);
    var_c8bbed73f0438ec8 = player function_644ed519cac9722b(1, 13);
    var_9cdf915529700821 = player function_644ed519cac9722b(1, 14);
    var_a4462a64012f11a5 = player function_644ed519cac9722b(1, 15);
    var_78ae3551b1d877da = player function_644ed519cac9722b(1, 16);

    player.var_6f7281f031b30320[6] setdevtext(function_e29c498dd636939a(var_50b1b73063d6e846, "<dev string:x502>") + "<dev string:x43e>" + function_e29c498dd636939a(var_c8bbed73f0438ec8, "<dev string:x51c>") + "<dev string:x43e>" + function_e29c498dd636939a(var_9cdf915529700821, "<dev string:x536>") + "<dev string:x43e>" + function_e29c498dd636939a(var_a4462a64012f11a5, "<dev string:x54f>") + "<dev string:x43e>" + function_e29c498dd636939a(var_78ae3551b1d877da, "<dev string:x56a>"));

    player.var_6f7281f031b30320[6] setpoint("TOPLEFT", "TOPLEFT", 250, 140);
    player.var_6f7281f031b30320[6] clearalltextafterhudelem();
    player.var_6f7281f031b30320[6].archived = 0;
    backpackstring = "Backpack Items: ";

    for(backpackindex = 1; backpackindex <= 12; backpackindex++) {
      backpackinstance = player function_644ed519cac9722b(2, backpackindex);
      backpackstring = backpackstring + function_e29c498dd636939a(backpackinstance, "") + ", ";
    }

    player.var_6f7281f031b30320[7] setdevtext(backpackstring);

    player.var_6f7281f031b30320[7] setpoint("TOPLEFT", "TOPLEFT", 250, 190);
    player.var_6f7281f031b30320[7] clearalltextafterhudelem();
    player.var_6f7281f031b30320[7].archived = 0;
    wait 3;
  }
}

function function_a3d464413e73f057(player) {
  if(!isDefined(level.var_19cc064ef4f4f035)) {
    level.var_19cc064ef4f4f035 = 0;
  }

  if(!isDefined(player.var_87f0698dc7ac0a09)) {
    player.var_87f0698dc7ac0a09 = level.var_19cc064ef4f4f035;
    level.var_19cc064ef4f4f035++;
  }

  return player.var_87f0698dc7ac0a09;
}

function function_359ea1fa75ce58d8() {
  if(!isDefined(level.var_a2c878a15054b7d2)) {
    level.var_a2c878a15054b7d2 = getdvarint(@ "hash_b39534cbfce013c4", 0);
  }

  return level.var_a2c878a15054b7d2;
}

function function_6e0f57c0fdd64f13(player) {
  if(istrue(player.var_7093a8118013837f)) {
    return true;
  }

  ticketid = scripts\cp_mp\utility\loot::getlootidfromref("loot_key_gold_door");

  if(!isDefined(ticketid)) {
    return false;
  }

  for(backpackindex = 14; backpackindex >= 1; backpackindex--) {
    backpackinstance = player function_644ed519cac9722b(2, backpackindex);

    if(backpackinstance.instanceid != "0" && backpackinstance.lootid == ticketid) {
      player.var_7093a8118013837f = 1;

      if(backpackindex <= 12) {
        var_239511438b021cbe = backpackindex - 1;
        player setplayerdata(level.var_5d69837cf4db0407, "dmzBackpack", var_239511438b021cbe, "lootID", 0);
        player setplayerdata(level.var_5d69837cf4db0407, "dmzBackpack", var_239511438b021cbe, "quantity", 0);
      }

      function_dc67872cc4cfae72(player, 2, backpackindex);
      return true;
    }
  }

  return false;
}

function function_3b6ac6fde1b3e84a(player) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  if(!player isfireteamleader()) {
    return;
  }

  if(!function_6e0f57c0fdd64f13(player) && function_359ea1fa75ce58d8()) {
    fireteammembers = player getfireteammembers();
    kick(player getentitynumber(), "EXE/PLAYERKICKED_NO_BIO_LAB_TICKET");

    foreach(fireteammember in fireteammembers) {
      kick(fireteammember getentitynumber(), "EXE/PLAYERKICKED_NO_BIO_LAB_TICKET");
    }
  }
}

function function_6484ce4430c9439b(player, slot) {
  if(!isDefined(player) || !isDefined(player.var_6317f2446d7f722)) {
    return true;
  }

  return !istrue(player.var_6317f2446d7f722[slot]);
}

function function_d3e4d206d9b842a0(scriptable) {
  if(!isDefined(scriptable.metadata) || !isDefined(scriptable.metadata[1])) {
    return false;
  }

  foreach(data in scriptable.metadata[1]) {
    if(data.key == 15 && int(data.value) > 0) {
      return true;
    }
  }

  return false;
}

function function_c2b37caeb3e8dfa0(player, weaponindex, oldinstance, newinstance) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  var_5170a7c15b09f348 = function_cd4840758c0f2125(newinstance);

  if(istrue(function_423648b9c03fdaa1(7, newinstance, 1))) {
    var_5170a7c15b09f348[1] = function_92f14840aa31925d(7, 0, var_5170a7c15b09f348[1]);
  }

  var_de3154264e07d28 = [];
  var_76a621441904ebab = [];

  for(attachmentoffset = 0; attachmentoffset <= 4; attachmentoffset++) {
    attachmentindex = 0 + attachmentoffset;

    if(isDefined(function_423648b9c03fdaa1(8 + attachmentoffset, oldinstance, 1)) && oldinstance.var_6cb812578f7d9ae7[attachmentindex] != 0) {
      var_de3154264e07d28[oldinstance.var_6cb812578f7d9ae7[attachmentindex]] = 1;
    }

    oldtuning = function_423648b9c03fdaa1(2 + attachmentoffset, oldinstance, 1);

    if(isDefined(oldtuning) && oldinstance.var_6cb812578f7d9ae7[attachmentindex] != 0) {
      var_76a621441904ebab[oldinstance.var_6cb812578f7d9ae7[attachmentindex]] = oldtuning;
    }
  }

  for(attachmentoffset = 0; attachmentoffset <= 4; attachmentoffset++) {
    attachmentindex = 0 + attachmentoffset;
    istuned = 0;
    oldtuning = 0;

    if(isDefined(var_de3154264e07d28[newinstance.var_6cb812578f7d9ae7[attachmentindex]])) {
      istuned = 1;
    }

    if(isDefined(var_76a621441904ebab[newinstance.var_6cb812578f7d9ae7[attachmentindex]])) {
      oldtuning = var_76a621441904ebab[newinstance.var_6cb812578f7d9ae7[attachmentindex]];
    }

    var_5170a7c15b09f348[1] = function_92f14840aa31925d(8 + attachmentoffset, istuned, var_5170a7c15b09f348[1]);
    var_5170a7c15b09f348[1] = function_92f14840aa31925d(2 + attachmentoffset, oldtuning, var_5170a7c15b09f348[1]);
  }

  var_11cc6f33cb91b3f1 = function_fe92418620d93763(var_5170a7c15b09f348[0]);
  var_d3c548c09bb62da2 = function_fe92418620d93763(var_5170a7c15b09f348[1]);
  function_cd81c0e152649846(player, newinstance, var_11cc6f33cb91b3f1, var_d3c548c09bb62da2);
}

function function_36275388f9093535(metadata) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  var_87f0698dc7ac0a09 = function_4a84e57f6373e69(1, metadata[0]);

  foreach(player in level.players) {
    if(isDefined(player.var_87f0698dc7ac0a09) && isDefined(var_87f0698dc7ac0a09) && player.var_87f0698dc7ac0a09 == int(var_87f0698dc7ac0a09)) {
      return player;
    }
  }
}

function private function_251fb8fbf0d6addc() {
  if(!isDefined(level.var_1200c749a3268f9f)) {
    level.var_1200c749a3268f9f = getdvarfloat(@ "hash_4d31327236448d75", 0.05);
  }

  return level.var_1200c749a3268f9f;
}

function function_ba249ac98edc6279(player) {
  if(!function_e0fc1230452cf4e7()) {
    return 0;
  }

  upgradecount = getupgradecount(player, 14);
  return upgradecount * function_251fb8fbf0d6addc();
}

function private function_5c55ff785294ad1d() {
  if(!isDefined(level.var_70d06cc3a8218177)) {
    level.var_70d06cc3a8218177 = getdvarfloat(@ "hash_aad2dc8050226460", 0.04);
  }

  return level.var_70d06cc3a8218177;
}

function private function_66f4c5ec2e0beee6() {
  if(!isDefined(level.var_18c292b7709dafcc)) {
    level.var_18c292b7709dafcc = getdvarfloat(@ "hash_1c2dc077c5758375", 0.05);
  }

  return level.var_18c292b7709dafcc;
}

function private function_956e931113e352a6() {
  if(!isDefined(level.var_3aa04e5b96bb1307)) {
    level.var_3aa04e5b96bb1307 = getdvarfloat(@ "hash_c9a496baf46a5a42", 0.05);
  }

  return level.var_3aa04e5b96bb1307;
}

function private function_c826ee21a52e408b() {
  if(!isDefined(level.var_96ab8672d820807)) {
    level.var_96ab8672d820807 = getdvarfloat(@ "hash_ae4f2b9bfc7f50a8", 0.05);
  }

  return level.var_96ab8672d820807;
}

function function_39f56604458d5a9b(player, itemdata) {
  if(!function_e0fc1230452cf4e7()) {
    return 0;
  }

  if(itemdata.ref == "armor") {
    upgradecount = getupgradecount(player, 13);
    return (function_5c55ff785294ad1d() * upgradecount);
  }

  if(itemdata.ref == "dmz_exfil_personal") {
    upgradecount = getupgradecount(player, 11);
    return (function_66f4c5ec2e0beee6() * upgradecount);
  }

  if(itemdata.type == "killstreak") {
    upgradecount = getupgradecount(player, 12);
    return (function_956e931113e352a6() * upgradecount);
  }
}

function function_1ee6a57e88b1a120(player, var_85166da84e55de25) {
  var_57838bb4fae836f8 = undefined;

  switch (var_85166da84e55de25) {
    case #"hash_31100fbc01bd387c":
      var_57838bb4fae836f8 = 16;
      break;
    case #"hash_311012bc01bd3d35":
      var_57838bb4fae836f8 = 17;
      break;
    case #"hash_311011bc01bd3ba2":
      var_57838bb4fae836f8 = 18;
      break;
  }

  if(isDefined(var_57838bb4fae836f8)) {
    upgradecount = getupgradecount(player, var_57838bb4fae836f8);
    return (upgradecount * function_c826ee21a52e408b());
  }

  return 0;
}

function private function_93f21618e59f6402(player) {
  var_6f908d78e5ac8e01 = level.spawnarmorplates;

  if(!function_e0fc1230452cf4e7()) {
    return var_6f908d78e5ac8e01;
  }

  return var_6f908d78e5ac8e01 + getupgradecount(player, 29);
}

function getnumstartupgradeplates(player) {
  var_51539d5a1aa9b3f9 = scripts\cp_mp\armor::function_47320a25b8ee003();
  upgradecount = function_93f21618e59f6402(player);
  return min(upgradecount, var_51539d5a1aa9b3f9);
}

function function_aad5c8b478df88c4(player) {
  if(!function_e0fc1230452cf4e7()) {
    return 0;
  }

  upgradeplates = function_93f21618e59f6402(player);
  var_51539d5a1aa9b3f9 = scripts\cp_mp\armor::function_47320a25b8ee003();
  return max(0, upgradeplates - var_51539d5a1aa9b3f9);
}

function function_59352c09a417a5e2(player, sublocation) {
  if(!function_e0fc1230452cf4e7()) {
    return true;
  }

  return getupgradecount(player, sublocation) > 0;
}

function getupgradecount(player, sublocation) {
  if(istrue(function_758b22811e547efe())) {
    return 1;
  }

  return default_to(player function_10abd3fe15ba02dd(sublocation), 0);
}

function function_e860c1be7ff11f5b(team, sublocation) {
  var_d3d220ae17c9a0be = 0;
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    upgradecount = getupgradecount(player, sublocation);
    var_d3d220ae17c9a0be = max(upgradecount, var_d3d220ae17c9a0be);
  }

  return int(var_d3d220ae17c9a0be);
}

function function_72fe945f29c8bce6(instance) {
  println("<dev string:x584>" + instance.instanceid);

  if(isDefined(instance.metadata)) {
    println("<dev string:x5a7>");

    foreach(data in instance.metadata) {
      println("<dev string:x5bb>" + data.key + "<dev string:x5c4>" + data.value);
    }
  }

  if(isDefined(instance.var_d3c548c09bb62da2)) {
    println("<dev string:x5d1>");

    foreach(data in instance.var_d3c548c09bb62da2) {
      println("<dev string:x5bb>" + data.key + "<dev string:x5c4>" + data.value);
    }
  }

  println("<dev string:x5e7>");
}

# /