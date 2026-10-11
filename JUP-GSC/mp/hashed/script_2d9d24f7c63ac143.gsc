/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d9d24f7c63ac143.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using script_3583ff375ab3a91e;
#using script_3aacf02225ca0da5;
#using script_55e418c5cc946593;
#using script_728ffcee8cbf30ee;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\equipment\hb_sensor;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\equipment\disguise;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_e50e624d9af51c8c;

function function_e0948a1e98e82ae1() {
  if(istrue(level.var_d034183abf2e274d)) {
    level.backpackdata = "dmzBackpack";
    level.backpacksize = "dmzBackpackSize";
  } else {
    level.backpackdata = "brBackpack";
    level.backpacksize = "brBackpackSize";
  }

  level.var_1833d54921da2cc6 = scripts\mp\utility\game::privatematch();
  level.var_d57cae4a13c11233 = default_to(level.var_d57cae4a13c11233, []);
  level.var_d57cae4a13c11233[level.var_d57cae4a13c11233.size] = "equip_c4";
  level.var_d57cae4a13c11233[level.var_d57cae4a13c11233.size] = "equip_throwing_knife";
  level.var_d57cae4a13c11233[level.var_d57cae4a13c11233.size] = "equip_claymore";
  level.var_d57cae4a13c11233[level.var_d57cae4a13c11233.size] = "equip_at_mine";
  level.var_d57cae4a13c11233[level.var_d57cae4a13c11233.size] = "equip_throwing_knife_fire";
}

function function_5baaa0ce73d6fe84(player, ammotype) {
  if(function_efab78b72d131d76(player)) {
    var_9ac5e72784815708 = function_2985254128b1c262(player);
    weaponammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_9ac5e72784815708);

    if(isDefined(weaponammotype)) {
      if(isDefined(ammotype) && ammotype != weaponammotype) {
        return;
      }

      weaponstockammo = player.br_ammo[weaponammotype];
      maxstock = level.var_e6ea72fc5e3fcd00[weaponammotype];
      weaponstockammo = int(min(weaponstockammo, maxstock));

      if(weaponstockammo > 1023) {
        assertmsg("<dev string:x1c>" + weaponstockammo + "<dev string:x60>" + var_9ac5e72784815708.basename);
      }

      player setclientomnvar("ui_playerdata_weapon_ammo", weaponstockammo);
    }
  }
}

function function_e35a7cb7e7c8c17e(player, weapon, var_f51bbb191526dfa4, metadata, var_223785486725cd51) {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::function_9fee9bd8efd81655(player, weapon, var_f51bbb191526dfa4, metadata);
    return;
  }

  function_8107fe0feec27866(player, weapon, var_223785486725cd51);
}

function function_705889b7586cf34e(player, weapon, weaponslot) {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::function_1f83d85290c29bef(player, weaponslot);
  }

  function_8107fe0feec27866(player, weapon);
}

function function_ee4ccdff22e510fd(player, var_72e90f48e0fd0e1c, sticker) {
  if(sticker == "none") {
    player setplayerdata(level.progressiongroup, "dmzWeapon", "sticker", var_72e90f48e0fd0e1c, sticker);
    return;
  }

  player setplayerdata(level.progressiongroup, "dmzWeapon", "sticker", var_72e90f48e0fd0e1c, getsubstr(sticker, 2));
}

function function_8107fe0feec27866(player, weapon, var_223785486725cd51) {
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
  variantid = weapon.variantid;

  if(!isDefined(weapon.variantid)) {
    variantid = 0;
  }

  lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
  player setplayerdata(level.progressiongroup, "dmzWeapon", "weapon", rootname);
  player setplayerdata(level.progressiongroup, "dmzWeapon", "variantID", variantid);
  player setplayerdata(level.progressiongroup, "dmzWeapon", "lootItemID", lootid);

  if(!istrue(var_223785486725cd51)) {
    player.weaponslotclip = player getweaponammoclip(weapon);
    player.var_ad7897ecdbcb63 = player getweaponammoclip(weapon, "left");

    if(weapon.hasalternate) {
      weaponalt = weapon getaltweapon();
      player.var_86b32aff94b5714e = player getweaponammoclip(weaponalt);
    }
  }

  attachments = getweaponattachments(weapon);
  defaulttoidmap = scripts\cp_mp\weapon::getbaseweaponattachdefaulttoidmap(rootname);
  var_428a6c7cd65625c0 = 0;
  attachmenttoidmap = weapon.attachmentvarindices;

  for(attachmentindex = 0; attachmentindex < attachments.size && var_428a6c7cd65625c0 < 7; attachmentindex++) {
    if(scripts\mp\utility\weapon::attachmentisselectable(weapon, attachments[attachmentindex])) {
      player setplayerdata(level.progressiongroup, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "attachment", attachments[attachmentindex]);
      player setplayerdata(level.progressiongroup, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "variantID", attachmenttoidmap[attachments[attachmentindex]]);
      var_428a6c7cd65625c0++;
    }
  }

  for(attachmentindex = var_428a6c7cd65625c0; var_428a6c7cd65625c0 < 7; attachmentindex++) {
    player setplayerdata(level.progressiongroup, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "attachment", "none");
    player setplayerdata(level.progressiongroup, "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "variantID", 0);
    var_428a6c7cd65625c0++;
  }

  if(isDefined(weapon.camo)) {
    player setplayerdata(level.progressiongroup, "dmzWeapon", "camo", weapon.camo);
  }

  if(isDefined(weapon.reticle)) {
    player setplayerdata(level.progressiongroup, "dmzWeapon", "reticle", weapon.reticle);
  }

  if(isDefined(weapon.visual)) {
    player setplayerdata(level.progressiongroup, "dmzWeapon", "cosmeticAttachment", weapon.visual);
  }

  stickers = [];

  if(isDefined(weapon.stickerslot0)) {
    function_ee4ccdff22e510fd(player, 0, weapon.stickerslot0);
  }

  if(isDefined(weapon.stickerslot1)) {
    function_ee4ccdff22e510fd(player, 1, weapon.stickerslot1);
  }

  if(isDefined(weapon.stickerslot2)) {
    function_ee4ccdff22e510fd(player, 2, weapon.stickerslot2);
  }

  if(isDefined(weapon.stickerslot3)) {
    function_ee4ccdff22e510fd(player, 3, weapon.stickerslot3);
  }

  if(isDefined(weapon.var_b39ac546cc8621f8)) {
    function_ee4ccdff22e510fd(player, 4, weapon.var_b39ac546cc8621f8);
  }

  function_3e89085d4a19a802(player, weapon);
  function_5baaa0ce73d6fe84(player);
}

function function_3e89085d4a19a802(player, weapon) {
  if(!isDefined(weapon)) {
    weapon = function_f2849dae62f7444e(player);
  }

  player.var_9ac5e72784815708 = weapon;
}

function function_2985254128b1c262(player) {
  return player.var_9ac5e72784815708;
}

function function_f2849dae62f7444e(player, statsgroup, weaponkey) {
  if(!isDefined(weaponkey)) {
    weaponkey = "dmzWeapon";
  }

  if(!isDefined(statsgroup)) {
    statsgroup = level.progressiongroup;
  }

  weapon = player getplayerdata(statsgroup, weaponkey, "weapon");
  variantid = player getplayerdata(statsgroup, weaponkey, "variantID");
  attachments = [];
  attachmentids = [];
  var_eae5a591e200672 = [];

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachments[attachmentindex] = player getplayerdata(statsgroup, weaponkey, "attachmentSetup", attachmentindex, "attachment");
    attachmentids[attachmentindex] = player getplayerdata(statsgroup, weaponkey, "attachmentSetup", attachmentindex, "variantID");
    slider1 = player getplayerdata(statsgroup, weaponkey, "attachmentSetup", attachmentindex, "customTune", 0);
    slider2 = player getplayerdata(statsgroup, weaponkey, "attachmentSetup", attachmentindex, "customTune", 1);
    tuningvalues = scripts\mp\class::function_a5d1432d54033ea9(slider1, slider2, 0);

    if(isDefined(tuningvalues)) {
      var_eae5a591e200672[attachments[attachmentindex]] = tuningvalues;
    }
  }

  camo = player getplayerdata(statsgroup, weaponkey, "camo");
  reticle = player getplayerdata(statsgroup, weaponkey, "reticle");
  cosmeticattachment = player getplayerdata(statsgroup, weaponkey, "cosmeticAttachment");
  stickers = [];

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5; var_36d2abbdcbcb186c++) {
    stickers[var_36d2abbdcbcb186c] = player getplayerdata(statsgroup, weaponkey, "sticker", var_36d2abbdcbcb186c);
  }

  return scripts\cp_mp\weapon::buildweapon(weapon, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers);
}

function function_efab78b72d131d76(player) {
  ret = isDefined(player.var_9ac5e72784815708) && player.var_9ac5e72784815708.basename != "none";

  if(istrue(level.var_f478c1f94caa7e9)) {
    data = player getplayerdata(level.progressiongroup, "dmzWeapon", "weapon");
    assertex(data != "<dev string:x7a>" == ret, "<dev string:x82>" + data + "<dev string:xd0>" + ret);
  }

  return ret;
}

function function_d9b1550011525161(player) {
  return player getplayerdata(level.progressiongroup, "dmzWeapon", "lootItemID");
}

function function_f5a1a13f0181bb66(player, weaponstowed, backpackequip) {
  if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    return;
  }

  if(!namespace_aead94004cf4c147::function_efab78b72d131d76(player)) {
    return;
  }

  lootitemid = function_d9b1550011525161(player);
  switchweapon = function_2985254128b1c262(player);
  count = ter_op(isDefined(player.weaponslotclip), player.weaponslotclip, weaponclipsize(switchweapon));
  countalt = ter_op(switchweapon.hasalternate && isDefined(player.var_86b32aff94b5714e), player.var_86b32aff94b5714e, weaponclipsize(switchweapon getaltweapon()));
  countlefthand = undefined;

  if(scripts\mp\utility\weapon::isakimbo(switchweapon)) {
    countlefthand = ter_op(isDefined(player.var_ad7897ecdbcb63), player.var_ad7897ecdbcb63, weaponclipsize(switchweapon));
  }

  pastteam = function_86a5c7670325346b(player, 2);
  function_590202daf6a1d4d7(player);
  scripts\mp\gametypes\br_pickups::equipweapon(switchweapon, count, undefined, countalt, backpackequip, weaponstowed, undefined, undefined, undefined, pastteam, countlefthand);
}

function function_954372d604277278(player) {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::function_f910b139e75fd559(player);
  }

  function_590202daf6a1d4d7(player);
}

function function_6a77670d14b0d08c(player, statsgroup, weaponkey) {
  if(!isDefined(weaponkey)) {
    weaponkey = "dmzWeapon";
  }

  if(!isDefined(statsgroup)) {
    statsgroup = level.progressiongroup;
  }

  player setplayerdata(statsgroup, weaponkey, "weapon", "none");
  player setplayerdata(statsgroup, weaponkey, "lootItemID", 0);
  player setplayerdata(statsgroup, weaponkey, "camo", "none");
  player setplayerdata(statsgroup, weaponkey, "reticle", "none");
  player setplayerdata(statsgroup, weaponkey, "cosmeticAttachment", "none");
  player setplayerdata(statsgroup, weaponkey, "variantID", 0);
  player setplayerdata(statsgroup, weaponkey, "blueprintName", "");

  for(attachindex = 0; attachindex < 5; attachindex++) {
    player setplayerdata(statsgroup, weaponkey, "attachmentSetup", attachindex, "attachment", "none");
    player setplayerdata(statsgroup, weaponkey, "attachmentSetup", attachindex, "variantID", 0);
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
    player setplayerdata(statsgroup, weaponkey, "sticker", var_36d2abbdcbcb186c, "none");
  }
}

function function_51f991fdaf031388(player, statsgroup, weaponkey) {
  function_6a77670d14b0d08c(player, statsgroup, weaponkey);
  player.var_9ac5e72784815708 = undefined;
}

function function_590202daf6a1d4d7(player, weaponkey) {
  function_51f991fdaf031388(player, undefined, "dmzWeapon");
  player.weaponslotclip = undefined;
  player.var_86b32aff94b5714e = undefined;
  player.var_ad7897ecdbcb63 = undefined;
  function_ae30366a2d519a57(player, 2, undefined);
}

function function_106b52ed8f680043(lootid) {
  if(lootid == 0) {
    return undefined;
  }

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(lootid == currentlootid) {
      return i;
    }
  }

  return undefined;
}

function function_aeb6f176059d98f5(lootid) {
  if(lootid == 0) {
    return undefined;
  }

  indexes = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(lootid == currentlootid) {
      indexes[i] = getquantityatbackpackindex(i);
    }
  }

  indexes = tablesort(indexes, "up");
  return indexes;
}

function function_ed8f025d796c038(lootid, sorted) {
  if(lootid == 0) {
    return undefined;
  }

  indexes = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(lootid == currentlootid) {
      indexes[indexes.size] = i;
    }
  }

  return indexes;
}

function function_e37ca8120dc19c6a() {
  if(issubstr(level.mapname, "<dev string:xeb>") || level.mapname == "<dev string:xfb>") {
    return true;
  }

  var_78c5bd06aaaa2482 = scripts\mp\utility\game::privatematch() && !namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && getdvarint(@ "hash_6f45a6cbb79f0513", 0) == 0;
  return scripts\mp\utility\game::matchmakinggame() || var_78c5bd06aaaa2482 || getdvarint(@ "hash_9c2d59c1962cac50");
}

function getinventoryweapons(player) {
  weapons = [];
  primaries = player getweaponslistprimaries();

  foreach(weapon in primaries) {
    if(scripts\mp\utility\weapon::isunderwaterweapon(weapon) || scripts\mp\utility\weapon::isclimbweapon(weapon) || weaponinventorytype(weapon) == "altmode" || scripts\mp\utility\weapon::ismeleeoverrideweapon(weapon) || scripts\mp\utility\weapon::issuperweapon(weapon)) {
      continue;
    }

    weapons[weapons.size] = weapon;
  }

  return weapons;
}

function snapshotbackpack() {
  items = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    [lootid, quantity] = function_6738846da50730f1(i);

    if(lootid != 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = quantity;
      item.index = i;
      items[items.size] = item;
    }
  }

  if(function_efab78b72d131d76(self)) {
    item = spawnStruct();
    item.lootid = function_d9b1550011525161(self);
    item.quantity = 1;
    item.pastteam = scripts\mp\gametypes\br_weapons::function_86a5c7670325346b(self, 2);
    item.objweapon = function_2985254128b1c262(self);
    weaponmetadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);

    if(isDefined(weaponmetadata)) {
      item.metadata = weaponmetadata;
    }

    items[items.size] = item;
  }

  return items;
}

function function_6738846da50730f1(index) {
  lootid = getlootidatbackpackindex(index);
  quantity = getquantityatbackpackindex(index);
  lootedquantity = function_eee597a59b37c10e(index);
  return [lootid, quantity, lootedquantity];
}

function function_84772ebf836af5db(index, amount) {
  if(!function_e37ca8120dc19c6a()) {
    return;
  }

  var_e8db6afbf2180f7e = getquantityatbackpackindex(index);
  newamount = int(max(0, var_e8db6afbf2180f7e + amount));
  lootid = getlootidatbackpackindex(index);
  function_d87a9518235b9682(index, lootid, newamount);
}

function function_3b2bf3060f2efdf3(player, index, lootid, quantity, loadoutslot) {
  oldlootid = player getplayerdata(level.progressiongroup, level.backpackdata, index, "lootID");
  oldquantity = player getplayerdata(level.progressiongroup, level.backpackdata, index, "quantity");

  if(oldlootid != lootid && quantity > 0) {
    namespace_a38a2e1fe7519183::function_22c2d36f9a723c2f(player, index, loadoutslot);
  }

  player function_d87a9518235b9682(index, lootid, quantity);
}

function function_3c3ee4c5700e0e32(player, index, lootid, quantity, loadoutlocation, loadoutslot, lootedquantity) {
  lootedquantity = default_to(lootedquantity, 0);
  namespace_a38a2e1fe7519183::function_d368b112dc94baae(player, index, loadoutlocation, loadoutslot);
  player function_d87a9518235b9682(index, lootid, quantity, undefined, lootedquantity);
}

function function_11f48ae5b87b4525(player, index, lootid, quantity, lootedquantity, var_ca04d98d53412adf) {
  lootedquantity = default_to(lootedquantity, 0);
  oldlootid = player getplayerdata(level.progressiongroup, level.backpackdata, index, "lootID");
  oldquantity = player getplayerdata(level.progressiongroup, level.backpackdata, index, "quantity");

  if(oldlootid != lootid && (quantity > 0 || lootedquantity > 0)) {
    namespace_a38a2e1fe7519183::function_233512489717381(player, index, lootid);
  }

  player function_d87a9518235b9682(index, lootid, quantity, undefined, lootedquantity, var_ca04d98d53412adf);
}

function function_b4e3d555d6d737bb(player, index, loadoutslot) {
  namespace_a38a2e1fe7519183::function_e8a616866b41197(player, index, loadoutslot);
  player function_d87a9518235b9682(index, 0, 0);
}

function function_ad05407157b7d86d(player, index) {
  namespace_a38a2e1fe7519183::function_52384260fe709f19(player, index);
}

function function_c6306ea9715dd8f1(player, slot) {
  namespace_a38a2e1fe7519183::function_351fe4ac57ca37e5(player, slot);
}

function function_e900e7e66383ad97(player, index, quantity, var_f3990d8529de3a54) {
  oldlootid = player getlootidatbackpackindex(index);
  player function_d87a9518235b9682(index, oldlootid, quantity, var_f3990d8529de3a54);
}

function setbackpackitematindex(player, index, lootid, quantity, lootedquantity) {
  player function_d87a9518235b9682(index, lootid, quantity, 0, lootedquantity);
}

function private function_d87a9518235b9682(index, lootid, quantity, var_f3990d8529de3a54, lootedquantity, var_ca04d98d53412adf) {
  if(!function_e37ca8120dc19c6a()) {
    return;
  }

  lootedquantity = default_to(lootedquantity, 0);
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  println(self.name + "<dev string:x108>" + index + "<dev string:x130>" + lootid + "<dev string:x130>" + quantity + "<dev string:x136>");
  println("<dev string:x13c>" + index + "<dev string:x141>" + lootid + "<dev string:x14a>" + ref + "<dev string:x150>" + quantity);

  if(!isDefined(quantity) || quantity < 0) {
    quantity = 0;
  }

  if(!isDefined(lootid) || lootid != 0 && quantity == 0 && !istrue(var_ca04d98d53412adf)) {
    lootid = 0;
  }

  if(level.var_1833d54921da2cc6) {
    self setplayerdata(level.progressiongroup, level.backpackdata, index, "lootID", 1);
    self setplayerdata(level.progressiongroup, level.backpackdata, index, "quantity", 1);
  }

  self setplayerdata(level.progressiongroup, level.backpackdata, index, "lootID", lootid);
  self setplayerdata(level.progressiongroup, level.backpackdata, index, "quantity", quantity);
  self setplayerdata(level.progressiongroup, level.backpackdata, index, "lootedQuantity", lootedquantity);

  if(quantity == 0 && lootedquantity == 0 && !istrue(var_ca04d98d53412adf) || lootid == 0) {
    self setplayerdata(level.progressiongroup, level.backpackdata, index, "lootID", 0);
    self setplayerdata(level.progressiongroup, level.backpackdata, index, "quantity", 0);
    self setplayerdata(level.progressiongroup, level.backpackdata, index, "lootedQuantity", 0);

    if(!istrue(var_f3990d8529de3a54)) {
      function_ad05407157b7d86d(self, index);
    }

    return;
  }

  pickup = spawnStruct();
  pickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  scripts\mp\gametypes\br_analytics::branalytics_lootpickup(self, pickup.scriptablename, quantity);
}

function function_e7ec9888699dd8cf() {
  function_d28f52da6ede0191(self, 5, 1);
  namespace_a38a2e1fe7519183::function_5b7dc44bb66553a6(self);
  namespace_a38a2e1fe7519183::function_ea96b27797c7e268(self);

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    scripts\mp\gametypes\br_pickups::function_e98a5a4e0e001ac3(self);
    return;
  }

  var_2e1d1af8afe39ba8 = getdvarint(@ "scr_br_plate_carrier_start_level", 3);
  var_347aa4935f42810 = scripts\mp\gametypes\br_public::function_c2f2bb9e0ae9a454(var_2e1d1af8afe39ba8);
  scripts\mp\gametypes\br_pickups::function_e98a5a4e0e001ac3(self, var_347aa4935f42810);
}

function clearbackpack(var_f3990d8529de3a54) {
  for(packitemindex = 0; packitemindex < getplayerbackpacksize(self); packitemindex++) {
    function_db1dd76061352e5b(packitemindex, undefined, var_f3990d8529de3a54);
  }

  if(istrue(var_f3990d8529de3a54)) {
    self.var_4f7710ecff5b1619 = 1;
  }

  function_e7ec9888699dd8cf();
}

function function_bab1a10b3fdaae51() {
  for(packitemindex = 0; packitemindex < getplayerbackpacksize(self); packitemindex++) {
    if(level.var_1833d54921da2cc6) {
      self setplayerdata(level.progressiongroup, level.backpackdata, packitemindex, "lootID", 1);
      self setplayerdata(level.progressiongroup, level.backpackdata, packitemindex, "quantity", 1);
    }

    self setplayerdata(level.progressiongroup, level.backpackdata, packitemindex, "lootID", 0);
    self setplayerdata(level.progressiongroup, level.backpackdata, packitemindex, "quantity", 0);
  }
}

function canitemfitinbackpack(lootid, quantity) {
  initialquantity = quantity;
  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(lootname)) {
    lootname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount)) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("canItemFitInBackpack")) {
    result = scripts\mp\gametypes\br_gametypes::function_d72afaccedfc946e("canItemFitInBackpack", lootid, lootname, quantity, maxcount);

    if(isDefined(result)) {
      return result;
    }
  }

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(currentlootid == 0 && currentlootid != lootid) {
      return 1;
    }

    if(currentlootid == lootid) {
      currentquantity = getquantityatbackpackindex(i);

      if(currentquantity + quantity <= maxcount) {
        return 1;
      }

      quantity = currentquantity + quantity - maxcount;
    }
  }

  if(quantity == initialquantity) {
    return 0;
  }

  return 1;
}

function function_e05897f5d860188e(lootid, quantity, drop) {
  if(!isDefined(lootid)) {
    return undefined;
  }

  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(lootname)) {
    lootname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount)) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(currentlootid == lootid) {
      if(istrue(drop)) {
        return i;
      }

      currentquantity = getquantityatbackpackindex(i);

      if(currentquantity < maxcount) {
        return i;
      }
    }
  }

  return undefined;
}

function getlootidatbackpackindex(index) {
  return self getplayerdata(level.progressiongroup, level.backpackdata, index, "lootID");
}

function getquantityatbackpackindex(index) {
  return self getplayerdata(level.progressiongroup, level.backpackdata, index, "quantity");
}

function function_eee597a59b37c10e(index) {
  return self getplayerdata(level.progressiongroup, level.backpackdata, index, "lootedQuantity");
}

function getavailabledmzbackpackindex() {
  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(currentlootid == 0) {
      return i;
    }
  }

  return undefined;
}

function function_9e76c59021bbf021(ammotype) {
  lootid = loot::function_fae5e1d3de32d3f7(ammotype);

  if(!isDefined(lootid)) {
    return 0;
  }

  var_40f97ad475793851 = int(max(0, level.br_ammo_max[ammotype] - self.br_ammo[ammotype]));
  maxcount = level.br_pickups.var_4138f9ddc1cd22d[ammotype];

  if(!isDefined(maxcount)) {
    maxcount = level.br_pickups.maxcounts[ammotype];
  }

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(currentlootid == lootid) {
      currentquantity = getquantityatbackpackindex(i);
      var_a29ff2ee96b284c1 = int(max(0, maxcount - currentquantity));
      var_40f97ad475793851 += var_a29ff2ee96b284c1;
    }
  }

  return var_40f97ad475793851;
}

function function_f6f8c1fc9549eaf6(lootid) {
  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  return isDefined(scriptable) && isDefined(level.br_pickups.br_itemtype[scriptable]) && level.br_pickups.br_itemtype[scriptable] == #"weaponcase";
}

function function_8e61ef2a2f9137e7(lootid) {
  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  return isDefined(scriptable) && scriptable == "brloot_radioactive_charge";
}

function function_b4893066110f4d10(lootid) {
  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  return isDefined(scriptable) && scriptable == "brloot_volatile_decoy_grenade";
}

function function_2d86ba79a58bb62(lootid) {
  return isDefined(lootid) && lootid == 8525;
}

function function_8a160d9935d47f5e(ref, type, quantity) {
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
  return function_e01d9736b2d100ac(lootid, quantity);
}

function function_e01d9736b2d100ac(lootid, quantity) {
  assertex(isDefined(lootid) && isDefined(quantity), "<dev string:x157>");

  if(!isDefined(lootid) || !isDefined(quantity)) {
    return undefined;
  }

  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!function_7e103028c464ab9a(lootname)) {
    return 0;
  }

  if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid)) {
    return isDefined(getavailabledmzbackpackindex());
  }

  return canitemfitinbackpack(lootid, quantity);
}

function gettotalitemcountinbag(lootid) {
  total = 0;

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    slotlootid = getlootidatbackpackindex(i);

    if(slotlootid == lootid) {
      total += getquantityatbackpackindex(i);
    }
  }

  return total;
}

function function_6fe7e7891d125c48(player) {
  total = 0;

  for(i = 0; i < getplayerbackpacksize(player); i++) {
    slotlootid = player getlootidatbackpackindex(i);

    if(slotlootid) {
      total += 1;
    }
  }

  return total;
}

function function_474484ee8653086f(player) {
  for(i = 0; i < getplayerbackpacksize(player); i++) {
    slotlootid = player getlootidatbackpackindex(i);

    if(slotlootid) {
      return true;
    }
  }

  return false;
}

function function_5915bdbc5f6302b6(var_60452e1fc245c1) {
  matchingitems = [];

  if(isDefined(var_60452e1fc245c1)) {
    for(i = 0; i < getplayerbackpacksize(self); i++) {
      slotlootid = getlootidatbackpackindex(i);

      if(scripts\engine\utility::array_contains(var_60452e1fc245c1, slotlootid)) {
        matchingitems[matchingitems.size] = i;
      }
    }
  }

  return matchingitems;
}

function function_a1ef7227cd878384() {
  matchingitems = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    slotlootid = getlootidatbackpackindex(i);
    ref = function_793e8a72cedb8ef3(slotlootid);

    if(array_contains(level.br_pickups.br_killstreakreference, ref)) {
      matchingitems[matchingitems.size] = i;
    }
  }

  return matchingitems;
}

function function_69f1f154cb91d491() {
  matchingitems = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    slotlootid = getlootidatbackpackindex(i);
    ref = function_793e8a72cedb8ef3(slotlootid);

    if(isDefined(level.br_pickups.br_equipnametoscriptable[ref])) {
      scriptablename = scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(ref);

      if(isDefined(level.br_pickups.br_superreference[scriptablename])) {
        matchingitems[matchingitems.size] = i;
      }
    }
  }

  return matchingitems;
}

function function_91a0bab850d7db10(index, lootid, maxcount, pickupquantity, slotquantity) {
  leftover = slotquantity + pickupquantity - maxcount;
  thread function_e900e7e66383ad97(self, index, maxcount);
  return leftover;
}

function private setbackpackitem(lootid, pickup) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("setBackpackItem")) {
    result = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("setBackpackItem", lootid, pickup);

    if(result >= 0) {
      return result;
    }
  }

  quantity = pickup.count;
  maxcount = level.br_pickups.var_4138f9ddc1cd22d[pickup.scriptablename];

  if(!isDefined(maxcount) || maxcount == 0) {
    maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  }

  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  if(scripts\mp\gametypes\br_pickups::function_f5082b4fc43ef59b(ref)) {
    for(i = 0; i < getplayerbackpacksize(self); i++) {
      currentlootid = getlootidatbackpackindex(i);

      if(currentlootid == lootid) {
        slotquantity = getquantityatbackpackindex(i);

        if(slotquantity + quantity <= maxcount) {
          function_11f48ae5b87b4525(self, i, lootid, slotquantity + quantity);
          return 0;
        } else {
          quantity = function_91a0bab850d7db10(i, lootid, maxcount, quantity, slotquantity);
        }
      }

      if(quantity <= 0) {
        return 0;
      }
    }
  }

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    currentlootid = getlootidatbackpackindex(i);

    if(currentlootid == 0 && currentlootid != lootid) {
      if(quantity <= maxcount) {
        function_11f48ae5b87b4525(self, i, lootid, quantity);
        return 0;
      } else {
        function_11f48ae5b87b4525(self, i, lootid, maxcount);
        quantity -= maxcount;
      }
    }

    if(quantity <= 0) {
      return 0;
    }
  }

  return quantity;
}

function additemtobackpackbyref(ref, type, quantity) {
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
  fakepickup = spawnStruct();
  fakepickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  fakepickup.count = quantity;
  return additemtobackpack(lootid, fakepickup);
}

function additemtobackpack(lootid, pickup, dontdropleftover, var_c751296a033cdb3c, fromkiosk) {
  assertex(isDefined(lootid) || isDefined(pickup), "<dev string:x1ad>");

  if(!isDefined(lootid) || !isDefined(pickup)) {
    return;
  }

  if(scripts\engine\utility::issharedfuncdefined(lootid, "pickedUp")) {
    result = scripts\engine\utility::callsharedfunc(lootid, "pickedUp", pickup.instance, self);

    if(isDefined(result)) {
      return;
    }
  }

  if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid, pickup.scriptablename)) {
    index = getavailabledmzbackpackindex();

    if(!isDefined(index)) {
      return 0;
    }

    function_71e56bb092fd2574(lootid);
    thread function_11f48ae5b87b4525(self, index, lootid, pickup.count, undefined, 1);
    return 0;
  } else if(scripts\mp\gametypes\br_pickups::function_df3f5431c93ed5a1(undefined, pickup.scriptablename)) {
    index = getavailabledmzbackpackindex();

    if(!isDefined(index)) {
      return 0;
    }

    scripts\mp\gametypes\br_gametype_truckwar::function_60d5992f51286201();
  } else if(scripts\mp\gametypes\br_pickups::function_e4b6260dbb04b43d(pickup.scriptablename)) {
    index = getavailabledmzbackpackindex();

    if(!isDefined(index)) {
      return 0;
    }

    namespace_6c622b52017c6808::function_bc0879c9aa2863a3(self, pickup, index);
  }

  scripts\cp_mp\talking_gun::function_81f5578aed261da1(self);

  if(scripts\mp\gametypes\br_public::isammo(pickup.scriptablename)) {
    if(self.br_ammo[pickup.scriptablename] < level.var_e6ea72fc5e3fcd00[pickup.scriptablename] && scripts\mp\gametypes\br_weapons::function_d885e66811ee3a4d(pickup.scriptablename)) {
      ammomissing = level.var_e6ea72fc5e3fcd00[pickup.scriptablename] - self.br_ammo[pickup.scriptablename];
      var_c1192c297bbf292f = int(min(ammomissing, pickup.count));

      if(istrue(pickup.isautouse) && scripts\mp\gametypes\br_pickups::function_e44c2d69db881894(pickup.scriptablename)) {
        self.br_ammo[pickup.scriptablename] += var_c1192c297bbf292f;
        scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(pickup.scriptablename);
        scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
        quantity = pickup.count - var_c1192c297bbf292f;
        dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

        if(isDefined(var_c751296a033cdb3c)) {
          dropstruct.count = var_c751296a033cdb3c;
        }

        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickup.overridedist, undefined, undefined, pickup.origin);
        item = scripts\mp\gametypes\br_pickups::spawnpickup(pickup.scriptablename, dropinfo, quantity, 1, undefined, 0);
        return 0;
      } else {
        scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, pickup.scriptablename, var_c1192c297bbf292f);
        pickup.count -= var_c1192c297bbf292f;
      }
    } else if(istrue(pickup.isautouse) && scripts\mp\gametypes\br_pickups::function_e44c2d69db881894(pickup.scriptablename) && !getdvarint(@ "hash_b5db5ff4b3f9e052", 0) && getdvarint(@ "hash_d116b9023292a13e", 1)) {
      [index, quantity] = function_280230feed0c006(pickup.scriptablename);
      maxstack = function_e02526fc6db8443f(pickup.scriptablename);

      if(quantity >= 0 && isDefined(maxstack) && quantity + pickup.count > maxstack) {
        var_cf3b8ce798a5a08 = pickup.count;
        pickup.count = maxstack - quantity;
        var_cf3b8ce798a5a08 -= pickup.count;
        dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

        if(isDefined(var_c751296a033cdb3c)) {
          dropstruct.count = var_c751296a033cdb3c;
        }

        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickup.overridedist, undefined, undefined, pickup.origin);
        item = scripts\mp\gametypes\br_pickups::spawnpickup(pickup.scriptablename, dropinfo, var_cf3b8ce798a5a08, 1, undefined, 0);
      }
    }
  }

  quantity = setbackpackitem(lootid, pickup);

  if(lootid == armor::function_eeac688cedb92729()) {
    var_3312a64d533c3a0d = armor::function_6a84ae8b37bed447();
    var_dd80ae1abd4b9751 = armor::function_20b8437058079297();
    scripts\mp\gametypes\br_public::updatebrscoreboardstat("armorPlateCount", var_dd80ae1abd4b9751 + var_3312a64d533c3a0d);

    if(!getdvarint(@ "hash_97100b0ecc90d802", 0)) {
      self setclientomnvar("ui_equipment_id_health_numStowed", var_3312a64d533c3a0d);
    }
  }

  if(quantity > 0) {
    if(!istrue(dontdropleftover)) {
      baseorigin = self.origin;
      baseangles = self.angles;
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      overridedist = pickup.overridedist;
      overrideorigin = pickup.origin;

      if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
        slotindex = self.br_kiosk scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
        self.br_kiosk.dropstruct.dropidx = slotindex;
        dropstruct = self.br_kiosk.dropstruct;
        baseorigin = default_to(self.br_kiosk.centerbottom, self.br_kiosk.origin);
        baseangles = self.br_kiosk.angles;
        overrideorigin = undefined;
        overridedist = undefined;
      } else if(isDefined(pickup.dropstruct)) {
        dropstruct = pickup.dropstruct;
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, undefined, overridedist, undefined, undefined, overrideorigin);
      item = scripts\mp\gametypes\br_pickups::spawnpickup(pickup.scriptablename, dropinfo, quantity, 1, undefined, 0);

      if(isDefined(pickup.dropstruct)) {
        pickup.dropstruct = dropstruct;
      }

      return 0;
    } else {
      return quantity;
    }
  }

  return 0;
}

function function_db1dd76061352e5b(index, var_74806f0c4caa7e55, var_f3990d8529de3a54) {
  if(!function_e37ca8120dc19c6a()) {
    return 0;
  }

  [lootid, _, _] = function_6738846da50730f1(index);
  currentquantity = getquantityatbackpackindex(index);

  if(!isDefined(var_74806f0c4caa7e55)) {
    var_74806f0c4caa7e55 = currentquantity;
  }

  newquantity = int(max(0, currentquantity - var_74806f0c4caa7e55));
  thread function_e900e7e66383ad97(self, index, newquantity, var_f3990d8529de3a54);
  backpackname = function_91c1be871300a518(lootid);
  function_6355a9db4ea7ab55(lootid);

  if(lootid == armor::function_eeac688cedb92729()) {
    var_3312a64d533c3a0d = armor::function_6a84ae8b37bed447();
    var_dd80ae1abd4b9751 = armor::function_20b8437058079297();
    scripts\mp\gametypes\br_public::updatebrscoreboardstat("armorPlateCount", var_dd80ae1abd4b9751 + var_3312a64d533c3a0d);

    if(!getdvarint(@ "hash_97100b0ecc90d802", 0)) {
      self setclientomnvar("ui_equipment_id_health_numStowed", var_3312a64d533c3a0d);
    }
  }

  return lootid;
}

function function_d63a7299c6203bf9(lootid) {
  if(!function_e37ca8120dc19c6a()) {
    return false;
  }

  index = function_e05897f5d860188e(lootid, undefined, 1);
  return isDefined(index);
}

function function_6f39f9916649ac48(lootid, quantity) {
  if(!function_e37ca8120dc19c6a()) {
    return 0;
  }

  itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(itemtype == "weapon") {
    function_954372d604277278(self);
    return;
  }

  index = function_e05897f5d860188e(lootid, undefined, 1);

  if(!isDefined(index)) {
    return 0;
  }

  function_db1dd76061352e5b(index, quantity);
  return 1;
}

function function_43f9da47b5084ce0(scriptablename) {
  if(!function_e37ca8120dc19c6a()) {
    return 0;
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  removedcount = 0;

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    if(getlootidatbackpackindex(i) == lootid) {
      removedcount += getquantityatbackpackindex(i);
      function_db1dd76061352e5b(i);
    }
  }

  return removedcount;
}

function removesmallestitemstackbackpack(scriptablename, amountremoved) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  assertex(isDefined(lootid), "<dev string:x1fa>");

  if(!isDefined(lootid)) {
    return;
  }

  var_750fcc188317845a = [];

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    if(getlootidatbackpackindex(i) == lootid) {
      var_750fcc188317845a[i] = getquantityatbackpackindex(i);
    }
  }

  if(var_750fcc188317845a.size <= 0) {
    return amountremoved;
  }

  var_5581023a8fc8d56d = tablesort(var_750fcc188317845a, "up");

  foreach(index in var_5581023a8fc8d56d) {
    slotquantity = getquantityatbackpackindex(index);

    if(amountremoved <= slotquantity) {
      function_db1dd76061352e5b(index, amountremoved);
      return 0;
    }

    amountremoved -= slotquantity;
    function_db1dd76061352e5b(index, slotquantity);
  }

  return amountremoved;
}

function function_280230feed0c006(scriptablename) {
  if(!isDefined(scriptablename)) {
    return undefined;
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  backpacksize = getplayerbackpacksize(self);
  largeststack = -1;
  largestindex = undefined;

  for(i = 0; i < backpacksize; i++) {
    [tmplootid, quantity, _] = function_6738846da50730f1(i);

    if(lootid == tmplootid && quantity > largeststack) {
      largeststack = quantity;
      largestindex = i;
    }
  }

  return [largestindex, largeststack];
}

function function_49a39674c4a064e3(scriptablename) {
  if(!isDefined(scriptablename)) {
    return false;
  }

  maxcount = function_e02526fc6db8443f(scriptablename);
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  backpacksize = getplayerbackpacksize(self);

  for(i = 0; i < backpacksize; i++) {
    [tmplootid, quantity, _] = function_6738846da50730f1(i);

    if(lootid == tmplootid && quantity >= maxcount) {
      return true;
    }
  }

  return false;
}

function function_e02526fc6db8443f(scriptablename) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups.var_4138f9ddc1cd22d) || !isDefined(level.br_pickups.var_4138f9ddc1cd22d[scriptablename])) {
    return undefined;
  }

  return level.br_pickups.var_4138f9ddc1cd22d[scriptablename];
}

function function_c578cff4de96af82(scriptablename) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups.var_4183295edcc21db0) || !isDefined(level.br_pickups.var_4183295edcc21db0[scriptablename])) {
    return undefined;
  }

  return level.br_pickups.var_4183295edcc21db0[scriptablename];
}

function function_d9749a7ab0c838d3(scriptablename) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  assertex(isDefined(lootid), "<dev string:x233>");

  if(!isDefined(lootid)) {
    return;
  }

  var_50dcba8ba0e8511e = undefined;
  var_8fc76cf32bb0e10d = undefined;

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    if(getlootidatbackpackindex(i) == lootid) {
      quantity = getquantityatbackpackindex(i);
      assert(isDefined(quantity));

      if(!isDefined(var_50dcba8ba0e8511e) || var_50dcba8ba0e8511e > quantity) {
        var_50dcba8ba0e8511e = quantity;
        var_8fc76cf32bb0e10d = i;
      }
    }
  }

  return [var_8fc76cf32bb0e10d, var_50dcba8ba0e8511e];
}

function getbackpackitemcount(lootid) {
  currentquantity = 0;
  index = function_106b52ed8f680043(lootid);

  if(!isDefined(index)) {
    return currentquantity;
  }

  backpacksize = getplayerbackpacksize(self);

  for(i = index; i < backpacksize; i++) {
    [tmplootid, _, _] = function_6738846da50730f1(i);

    if(lootid == tmplootid) {
      if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid)) {
        currentquantity += 1;
        continue;
      }

      currentquantity = getquantityatbackpackindex(i) + currentquantity;
    }
  }

  return currentquantity;
}

function function_ef5c7ec55e0e20ee(lootid) {
  index = function_106b52ed8f680043(lootid);

  if(!isDefined(index)) {
    return 0;
  }

  if(!isDefined(self.team)) {
    return getbackpackitemcount(index);
  }

  teamplayers = scripts\mp\utility\teams::getteamdata(self.team, "players");
  teamquantity = 0;

  foreach(player in teamplayers) {
    playerquantity = player getbackpackitemcount(lootid);
    teamquantity += playerquantity;
  }

  return teamquantity;
}

function function_71e56bb092fd2574(lootid) {
  if(!isDefined(lootid)) {
    return;
  }

  type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  switch (type) {
    case #"hash_1cac65e1b8bf24a7":
    case #"hash_27124c6c97ccffa1":
    case #"hash_325cb2e66f67d5b9":
    case #"hash_339227cb650975db":
    case #"hash_511d3c24fcedcdb1":
    case #"hash_850999d7864fa3b4":
    case #"hash_93c71e7b6c0b81d7":
    case #"hash_ab671284a3fc4e3d":
    case #"hash_b60679835e82a584":
    case #"hash_e534fd8ec73eafb4":
      return;
    case #"hash_7d516d84d0a82f2":
      if(isDefined(level.var_b33c035c483c2893) && isDefined(level.var_b33c035c483c2893["onPickup"]) && isDefined(level.var_b33c035c483c2893["onPickup"][ref])) {
        [[level.var_b33c035c483c2893["onPickup"][ref]]](self);
      }

      return;
  }
}

function function_6355a9db4ea7ab55(lootid) {
  if(!isDefined(lootid)) {
    return;
  }

  type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(!isDefined(type)) {
    return;
  }

  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  switch (type) {
    case #"hash_ff2e175bfcc4f32":
    case #"hash_1cac65e1b8bf24a7":
    case #"hash_27124c6c97ccffa1":
    case #"hash_325cb2e66f67d5b9":
    case #"hash_339227cb650975db":
    case #"hash_511d3c24fcedcdb1":
    case #"hash_850999d7864fa3b4":
    case #"hash_93c71e7b6c0b81d7":
    case #"hash_ab671284a3fc4e3d":
    case #"hash_b60679835e82a584":
    case #"hash_e534fd8ec73eafb4":
      return;
    case #"hash_7d516d84d0a82f2":
      if(isDefined(level.var_b33c035c483c2893) && isDefined(level.var_b33c035c483c2893["onDrop"]) && isDefined(level.var_b33c035c483c2893["onDrop"][ref])) {
        [[level.var_b33c035c483c2893["onDrop"][ref]]](self);
      }

      return;
  }
}

function function_36b1968bfe78916b(lootid) {
  return isDefined(function_106b52ed8f680043(lootid));
}

function function_3ab0a87eeaa203bf() {
  if(!istrue(level.var_2c93542553c664f5)) {
    return false;
  }

  foreach(weaponobj in self.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      return false;
    }
  }

  return true;
}

function function_5e7049647595ab97() {
  if(!level.var_1d814f83596d0a02) {
    return false;
  }

  return isDefined(self.equipment["super"]) && scripts\mp\equipment::getequipmentslotammo("super") > 0;
}

function function_d674d32c2d3ba5ed(player) {
  if(!istrue(level.var_472d7a6d15e57940)) {
    return false;
  }

  return isDefined(player.streakdata) && isDefined(player.streakdata.streaks) && self.streakdata.streaks.size > 0;
}

function function_5bf048439a846222(oldequipment) {
  return arraycontains(level.var_d57cae4a13c11233, oldequipment);
}

function function_8237b4eeab275f08(player, slot, oldequipment) {
  if(!isDefined(player) || !isDefined(slot)) {
    return false;
  }

  if(function_5bf048439a846222(oldequipment)) {
    return false;
  }

  if(getdvarint(@ "hash_ced962345ff6ecd0", 0)) {
    return false;
  }

  var_32ad03c5b4a0887d = undefined;
  var_54697b28405e2f94 = "";
  var_3b04a55bcba2273a = 0;
  var_28d82fb085befa70 = 0;

  for(packitemindex = 0; packitemindex < getplayerbackpacksize(player); packitemindex++) {
    quantity = player getquantityatbackpackindex(packitemindex);
    lootid = player getlootidatbackpackindex(packitemindex);

    if(quantity > 0 && lootid > 0) {
      type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

      if(type == "equipment") {
        itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

        if(isDefined(oldequipment) && isDefined(itemref) && itemref == oldequipment) {
          var_32ad03c5b4a0887d = packitemindex;
          var_54697b28405e2f94 = itemref;
          var_3b04a55bcba2273a = quantity;
          var_28d82fb085befa70 = lootid;
          break;
        }

        if(!isDefined(var_32ad03c5b4a0887d)) {
          itemslot = scripts\mp\equipment::getdefaultslot(itemref);

          if(isDefined(itemslot) && itemslot == slot) {
            var_32ad03c5b4a0887d = packitemindex;
            var_54697b28405e2f94 = itemref;
            var_3b04a55bcba2273a = quantity;
            var_28d82fb085befa70 = lootid;
          }
        }
      }
    }
  }

  if(isDefined(var_32ad03c5b4a0887d)) {
    player scripts\mp\equipment::giveequipment(var_54697b28405e2f94, slot);
    player scripts\mp\equipment::setequipmentammo(var_54697b28405e2f94, var_3b04a55bcba2273a);

    if(var_54697b28405e2f94 == "equip_hb_sensor") {
      scripts\cp_mp\equipment\hb_sensor::function_30cd943d877dc29f(var_3b04a55bcba2273a);
      namespace_aead94004cf4c147::function_db1dd76061352e5b(var_32ad03c5b4a0887d);
    } else {
      equipmax = player scripts\mp\equipment::getequipmentmaxammo(var_54697b28405e2f94);
      newamount = min(equipmax, var_3b04a55bcba2273a);
      var_e8db6afbf2180f7e = getquantityatbackpackindex(var_32ad03c5b4a0887d);
      player function_84772ebf836af5db(var_32ad03c5b4a0887d, -1 * newamount);
      namespace_a38a2e1fe7519183::function_f5b2810055f85ead(player, slot, var_28d82fb085befa70);
    }

    player setclientomnvar("ui_notify_show_minimal_hud", gettime());
    return true;
  }

  return false;
}

function function_2c226f050114f4b2(dropstruct, victim) {
  for(packitemindex = 0; packitemindex < getplayerbackpacksize(victim); packitemindex++) {
    quantity = victim getquantityatbackpackindex(packitemindex);
    lootid = victim getlootidatbackpackindex(packitemindex);

    if(quantity > 0 && lootid > 0) {
      if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid)) {
        [itemcount, itemcountlefthand, var_dab81ead77442a10] = scripts\mp\gametypes\dmz_dog_tag::function_379463a84adb07b4(quantity);
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
        var_dd070161709fa76 = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
        dogtag = scripts\mp\gametypes\br_pickups::spawnpickup(var_dd070161709fa76, dropinfo, itemcount, 0, undefined, 0, itemcountlefthand, var_dab81ead77442a10);
        victim scripts\mp\gametypes\br_pickups::function_2f4e0022c686dbe6(dogtag);
        continue;
      }

      if(function_2d86ba79a58bb62(lootid)) {
        victim namespace_bd614c3c2275579a::function_f9ff7c89b3792ccc(dropstruct, victim.blacksite);
        continue;
      }

      if(isDefined(namespace_6c622b52017c6808::function_96a1620d901981d1(lootid, 5))) {
        victim scripts\mp\gametypes\br_pickups::function_b41950c9b54b12e0(dropstruct, packitemindex, lootid);
        continue;
      }

      if(namespace_708f627020de59d3::function_f647113719f5139b(lootid)) {
        victim namespace_708f627020de59d3::function_3af23b0bfaf91dbd(dropstruct, undefined, undefined, packitemindex);
        continue;
      }

      if(namespace_a8b2b88699fc40fb::isweaponcase(lootid)) {
        victim namespace_a8b2b88699fc40fb::dropweaponcase();
        continue;
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      var_dd070161709fa76 = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
      var_bb9e46e1d8130f2 = istrue(level.br_pickups.br_hasautopickup[var_dd070161709fa76]);
      item = scripts\mp\gametypes\br_pickups::spawnpickup(var_dd070161709fa76, dropinfo, quantity, 1, undefined, var_bb9e46e1d8130f2);
      victim scripts\mp\gametypes\br_pickups::function_2f4e0022c686dbe6(item);
      utility::callsharedfunc(lootid, "dropOnDeath", item, victim, dropinfo.origin);
    }
  }
}

function function_5814f4f8710e57f7(victim, dropstruct) {
  backpackcontents = [];
  var_badde91d16301be4 = 0;
  hasweaponcase = 0;

  for(packitemindex = 0; packitemindex < getplayerbackpacksize(victim); packitemindex++) {
    quantity = victim getquantityatbackpackindex(packitemindex);
    lootid = victim getlootidatbackpackindex(packitemindex);

    if(quantity > 0 && lootid > 0) {
      if(function_2d86ba79a58bb62(lootid)) {
        victim namespace_bd614c3c2275579a::function_f9ff7c89b3792ccc(dropstruct, victim.blacksite);
        continue;
      }

      if(isDefined(namespace_6c622b52017c6808::function_96a1620d901981d1(lootid, 5))) {
        victim scripts\mp\gametypes\br_pickups::function_b41950c9b54b12e0(dropstruct, packitemindex, lootid);
        continue;
      }

      if(function_f6f8c1fc9549eaf6(lootid)) {
        if(getdvarint(@ "hash_f5f97aec0784002a", 1)) {
          weaponcase = namespace_a8b2b88699fc40fb::spawnweaponcase(victim, dropstruct);
          victim scripts\mp\gametypes\br_pickups::function_2f4e0022c686dbe6(weaponcase);
          continue;
        } else {
          hasweaponcase = 1;
        }
      }

      backpackcontents[packitemindex] = [];
      backpackcontents[packitemindex]["lootID"] = lootid;
      backpackcontents[packitemindex]["quantity"] = quantity;
      var_badde91d16301be4++;
    }
  }

  if(istrue(level.var_f478c1f94caa7e9) && istrue(level.var_a3499c286ac570e4)) {
    if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
      var_badde91d16301be4++;
    }
  }

  dogtag = undefined;

  if(getdvarint(@ "hash_6d0beef651f58a69", 0)) {
    victim scripts\mp\gametypes\br_pickups::dropdogtag(dropstruct);
  } else if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(victim)) {
    dogtagcount = scripts\mp\gametypes\dmz_dog_tag::function_57711583c5d26490(victim);

    if(isDefined(dogtagcount)) {
      scripts\mp\gametypes\dmz_dog_tag::function_bc03aa369196f2bf(victim, 0);
      dogtag = [];
      dogtag["lootID"] = scripts\mp\gametypes\dmz_dog_tag::function_777013e79be19c16(victim);
      dogtag["quantity"] = dogtagcount;
    }
  }

  return [backpackcontents, hasweaponcase, dogtag];
}

function function_45013dfe9531841f(victim, dogtag) {
  loadoutitems = victim namespace_aead94004cf4c147::function_88a168912191ec3e(1, 1);
  loadoutcontents = [];
  index = 0;
  firstweapon = 1;
  weaponslotcontents = undefined;
  weaponslotobj = undefined;
  var_ec22a950f210e39 = undefined;
  weapondropindex = undefined;

  if(isDefined(loadoutitems)) {
    foreach(indextype, itemtype in loadoutitems) {
      if(!itemtype.size) {
        loadoutcontents[index] = [];
        loadoutcontents[index]["lootID"] = 0;
        loadoutcontents[index]["quantity"] = 0;
        index++;
        continue;
      }

      foreach(slotindex, slot in itemtype) {
        if(!isDefined(slot) && indextype != 1) {
          loadoutcontents[index] = [];
          loadoutcontents[index]["lootID"] = 0;
          loadoutcontents[index]["quantity"] = 0;
          index++;
          continue;
        }

        lootid = slot[0];
        quantity = slot[1];

        if(!isDefined(lootid) || !isDefined(quantity)) {
          continue;
        }

        if(indextype == 1) {
          if(itemtype.size > 1) {
            if(!firstweapon) {
              weaponslotcontents = lootid;
              weaponslotobj = slot[2];
            } else {
              var_ec22a950f210e39 = slot[2];
              weapondropindex = slotindex;
            }

            firstweapon = 0;
          }

          continue;
        }

        loadoutcontents[index] = [];
        loadoutcontents[index]["lootID"] = lootid;
        loadoutcontents[index]["quantity"] = quantity;
        index++;
      }
    }
  }

  if(isDefined(dogtag)) {
    loadoutcontents[8] = [];
    loadoutcontents[8]["lootID"] = dogtag["lootID"];
    loadoutcontents[8]["quantity"] = dogtag["quantity"];
    index++;
  }

  if(isDefined(victim.var_cd82e790e825db2)) {
    loadoutcontents[9] = [];
    loadoutcontents[9]["lootID"] = victim.backpackid;
    loadoutcontents[9]["quantity"] = 1;
    index++;
  }

  var_275f4441ab7920c8 = scripts\mp\gametypes\br_weapons::function_1a561e5ef2eca63a(victim, weaponslotobj);
  return [loadoutcontents, weaponslotobj, weaponslotcontents, var_275f4441ab7920c8, var_ec22a950f210e39, weapondropindex];
}

function function_c6b3799b231916bb(victim, dropstruct) {
  if(istrue(victim.extracted)) {
    return;
  }

  [backpackcontents, hasweaponcase, dogtag] = function_5814f4f8710e57f7(victim, dropstruct);
  [loadoutcontents, var_a0e9fef038504bd0, var_c299c08e4b8a8e56, var_c31356a794d8cb46, var_ec22a950f210e39, weapondropindex] = function_45013dfe9531841f(victim, dogtag);

  if(backpackcontents.size > 0 || loadoutcontents.size > 0) {
    if(istrue(level.uselootablecorpse) && scripts\mp\utility\game::isteamreviveenabled() && !getdvarint(@ "hash_4536e887a50f692e", 0)) {
      weaponslotcontents = undefined;
      weaponslotobj = undefined;
      weaponslotclip = undefined;
      var_86b32aff94b5714e = undefined;
      var_275f4441ab7920c8 = undefined;
      var_8348f10d08dad67a = undefined;
      var_b19049daab6b92cb = undefined;

      if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
        weaponslotcontents = function_d9b1550011525161(victim);
        weaponslotobj = function_2985254128b1c262(victim);
        weaponslotclip = ter_op(isDefined(victim.weaponslotclip), victim.weaponslotclip, weaponclipsize(weaponslotobj));

        if(scripts\mp\utility\weapon::isakimbo(weaponslotobj)) {
          var_b19049daab6b92cb = ter_op(isDefined(victim.var_ad7897ecdbcb63), victim.var_ad7897ecdbcb63, weaponclipsize(weaponslotobj));
        }

        var_275f4441ab7920c8 = function_86a5c7670325346b(victim, 2);

        if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
          var_8348f10d08dad67a = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);
        }

        if(weaponslotobj.hasalternate) {
          weaponalt = weaponslotobj getaltweapon();
          var_86b32aff94b5714e = ter_op(isDefined(victim.var_86b32aff94b5714e), victim.var_86b32aff94b5714e, weaponclipsize(weaponalt));
        }
      }

      var_9d09471027604346 = undefined;

      if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && isDefined(var_a0e9fef038504bd0) && isDefined(var_c299c08e4b8a8e56)) {
        var_9d09471027604346 = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 1);
      }

      scripts\mp\teamrevive::function_9341574d596e9d36(victim, backpackcontents, 6, scripts\mp\gametypes\dmz_dog_tag::function_fb2923d9d7eb7aac(victim), weaponslotcontents, weaponslotobj, weaponslotclip, var_86b32aff94b5714e, var_275f4441ab7920c8, hasweaponcase, loadoutcontents, var_c299c08e4b8a8e56, var_a0e9fef038504bd0, var_8348f10d08dad67a, var_9d09471027604346, var_c31356a794d8cb46, var_b19049daab6b92cb);
    } else {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      teamindex = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim.sessionuimemberindex;

      if(squadindex < 0 && isDefined(victim.var_71afb85ec1cc06f8)) {
        squadindex = victim.var_71afb85ec1cc06f8;
      }

      spawnedbackpack = victim scripts\mp\gametypes\br_pickups::spawnpickup(function_432475069c798ddc(self.attached_bag), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex);

      if(isDefined(spawnedbackpack)) {
        if(istrue(level.var_d034183abf2e274d)) {
          spawnedbackpack.criticalitem = 1;
        } else if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
          thread function_f4fc5c80c4d45c10(spawnedbackpack);
        } else {
          thread function_a87df010e38d988e(spawnedbackpack);
        }

        spawnedbackpack.contents = backpackcontents;
        spawnedbackpack.loadoutcontents = loadoutcontents;

        if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
          spawnedbackpack.weaponslotcontents = function_d9b1550011525161(victim);
          spawnedbackpack.weaponslotobj = function_2985254128b1c262(victim);
          spawnedbackpack.weaponslotclip = ter_op(isDefined(victim.weaponslotclip), victim.weaponslotclip, weaponclipsize(spawnedbackpack.weaponslotobj));
          spawnedbackpack.var_275f4441ab7920c8 = function_86a5c7670325346b(victim, 2);

          if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
            spawnedbackpack.metadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);
          }

          if(spawnedbackpack.weaponslotobj.hasalternate) {
            weaponalt = spawnedbackpack.weaponslotobj getaltweapon();
            spawnedbackpack.var_86b32aff94b5714e = ter_op(isDefined(victim.var_86b32aff94b5714e), victim.var_86b32aff94b5714e, weaponclipsize(weaponalt));
          }

          if(scripts\mp\utility\weapon::isakimbo(spawnedbackpack.weaponslotobj)) {
            spawnedbackpack.var_ad7897ecdbcb63 = ter_op(isDefined(victim.var_ad7897ecdbcb63), victim.var_ad7897ecdbcb63, weaponclipsize(spawnedbackpack.weaponslotobj));
          }
        }

        spawnedbackpack.containertype = 6;
        spawnedbackpack.owner = victim;
        spawnedbackpack.backpacksize = namespace_aead94004cf4c147::getplayerbackpacksize(victim);
        spawnedbackpack.deadplayerindex = scripts\mp\gametypes\dmz_dog_tag::function_fb2923d9d7eb7aac(victim);
        victim.var_6a4360dcf2a8f3d4 = spawnedbackpack;

        if(isDefined(var_a0e9fef038504bd0) && isDefined(var_c299c08e4b8a8e56)) {
          spawnedbackpack.var_a06e7128c001851d = var_c299c08e4b8a8e56;
          spawnedbackpack.var_a0e9fef038504bd0 = var_a0e9fef038504bd0;
          spawnedbackpack.var_c31356a794d8cb46 = var_c31356a794d8cb46;
          spawnedbackpack.var_27990aa12decffdd = victim getweaponammoclip(var_a0e9fef038504bd0);
          spawnedbackpack.var_c693663e1bbdd8e9 = victim getweaponammoclip(var_a0e9fef038504bd0, "left");

          if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
            spawnedbackpack.var_bb6791b7369ef71a = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 1);
          }
        }

        foreach(item in spawnedbackpack.contents) {
          scripts\engine\utility::callsharedfunc(item["lootID"], "addedToContainer", spawnedbackpack, victim);
        }
      }
    }
  }

  if(isDefined(victim.attached_bag) && !istrue(level.uselootablecorpse)) {
    victim scripts\mp\gametypes\br_gametype_dmz::detachbag();
  }

  if(isDefined(var_ec22a950f210e39) && scripts\mp\gametypes\br_pickups::shoulddropbrprimary(var_ec22a950f210e39, victim)) {
    newweapondrop = scripts\mp\gametypes\br_pickups::dropbrweapon(var_ec22a950f210e39, dropstruct);

    if(isDefined(newweapondrop)) {
      if(istrue(level.var_d034183abf2e274d)) {
        newweapondrop.criticalitem = 1;
      } else {
        thread function_a87df010e38d988e(newweapondrop);
      }

      if(isDefined(newweapondrop.var_ac26ec91048ac2e3)) {
        victim.var_620f2a17df977448 = newweapondrop.var_ac26ec91048ac2e3;
      }

      if(isDefined(weapondropindex) && namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
        newweapondrop.metadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, weapondropindex);
      }

      victim.var_3480393dc131952a = newweapondrop;
    }
  }

  if(function_c4f1bd7a01a307fa(victim)) {
    victim.var_457667014505e1f9 = backpackcontents;
  }

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::function_ef552df845e8b952(victim);
  }
}

function function_a87df010e38d988e(item) {
  item endon("death");
  level endon("game_ended");
  item.criticalitem = 1;
  wait getdvarint(@ "hash_2b4f8183903e67ef", 180);

  if(!isDefined(item)) {
    return;
  }

  item.criticalitem = undefined;
}

function function_8121cbee12383790(victim, dropstruct) {
  backpackcontents = [];
  var_badde91d16301be4 = 0;
  hasweaponcase = 0;

  for(packitemindex = 0; packitemindex < getplayerbackpacksize(victim); packitemindex++) {
    quantity = victim getquantityatbackpackindex(packitemindex);
    lootid = victim getlootidatbackpackindex(packitemindex);

    if(quantity > 0 && lootid > 0) {
      if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid)) {
        [itemcount, itemcountlefthand, var_dab81ead77442a10] = scripts\mp\gametypes\dmz_dog_tag::function_379463a84adb07b4(quantity);
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
        scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
        scripts\mp\gametypes\br_pickups::spawnpickup(scriptable, dropinfo, itemcount, 0, undefined, 0, itemcountlefthand, var_dab81ead77442a10);
        continue;
      }

      if(function_2d86ba79a58bb62(lootid)) {
        victim namespace_bd614c3c2275579a::function_f9ff7c89b3792ccc(dropstruct, victim.blacksite);
        continue;
      }

      if(isDefined(namespace_6c622b52017c6808::function_96a1620d901981d1(lootid, 5))) {
        victim scripts\mp\gametypes\br_pickups::function_b41950c9b54b12e0(dropstruct, packitemindex, lootid);
        continue;
      }

      backpackcontents[packitemindex] = [];
      backpackcontents[packitemindex]["lootID"] = lootid;
      backpackcontents[packitemindex]["quantity"] = quantity;

      if(function_f6f8c1fc9549eaf6(lootid)) {
        hasweaponcase = 1;
      }

      var_badde91d16301be4++;
    }
  }

  if(istrue(level.var_f478c1f94caa7e9) && istrue(level.var_a3499c286ac570e4)) {
    if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
      var_badde91d16301be4++;
    }
  }

  if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(victim)) {
    quantity = scripts\mp\gametypes\dmz_dog_tag::function_57711583c5d26490(victim);

    if(isDefined(quantity)) {
      [itemcount, itemcountlefthand, var_dab81ead77442a10] = scripts\mp\gametypes\dmz_dog_tag::function_379463a84adb07b4(quantity);
      var_5983083928ce568c = scripts\mp\gametypes\dmz_dog_tag::function_59771b0cc100410a(victim);
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      spawneddogtag = scripts\mp\gametypes\br_pickups::spawnpickup(var_5983083928ce568c, dropinfo, itemcount, 0, undefined, 0, itemcountlefthand, var_dab81ead77442a10);

      if(isDefined(spawneddogtag)) {
        scripts\mp\gametypes\dmz_dog_tag::function_bc03aa369196f2bf(victim, 0);
        victim.dogtag = spawneddogtag;

        if(isDefined(victim.var_d2dbb2fa012e6d9c)) {
          victim.var_d2dbb2fa012e6d9c[victim.var_d2dbb2fa012e6d9c.size] = spawneddogtag;
        }
      }

      if(isDefined(level.var_547167a7517600fb) && isDefined(level.var_547167a7517600fb.var_a5354afeb0d5dfcc)) {
        [[level.var_547167a7517600fb.var_a5354afeb0d5dfcc]](victim);
      }
    }
  }

  if(var_badde91d16301be4 > 0) {
    if(istrue(level.uselootablecorpse) && scripts\mp\utility\game::isteamreviveenabled()) {
      weaponslotcontents = undefined;
      weaponslotobj = undefined;
      weaponslotclip = undefined;
      var_86b32aff94b5714e = undefined;
      var_275f4441ab7920c8 = undefined;
      var_8348f10d08dad67a = undefined;
      var_ad7897ecdbcb63 = undefined;

      if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
        weaponslotcontents = function_d9b1550011525161(victim);
        weaponslotobj = function_2985254128b1c262(victim);
        weaponslotclip = ter_op(isDefined(victim.weaponslotclip), victim.weaponslotclip, weaponclipsize(weaponslotobj));
        var_275f4441ab7920c8 = function_86a5c7670325346b(victim, 2);

        if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
          var_8348f10d08dad67a = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);
        }

        if(weaponslotobj.hasalternate) {
          weaponalt = weaponslotobj getaltweapon();
          var_86b32aff94b5714e = ter_op(isDefined(victim.var_86b32aff94b5714e), victim.var_86b32aff94b5714e, weaponclipsize(weaponalt));
        }

        if(scripts\mp\utility\weapon::isakimbo(weaponslotobj)) {
          var_ad7897ecdbcb63 = ter_op(isDefined(victim.var_ad7897ecdbcb63), victim.var_ad7897ecdbcb63, weaponclipsize(weaponslotobj));
        }
      }

      scripts\mp\teamrevive::function_9341574d596e9d36(victim, backpackcontents, 6, scripts\mp\gametypes\dmz_dog_tag::function_fb2923d9d7eb7aac(victim), weaponslotcontents, weaponslotobj, weaponslotclip, var_86b32aff94b5714e, var_275f4441ab7920c8, hasweaponcase, undefined, undefined, undefined, var_8348f10d08dad67a, undefined, undefined, var_ad7897ecdbcb63);
    } else {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      teamindex = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim.sessionuimemberindex;
      spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup(function_432475069c798ddc(self.attached_bag), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex);

      if(isDefined(spawnedbackpack)) {
        spawnedbackpack.contents = backpackcontents;

        if(istrue(level.var_f478c1f94caa7e9) && istrue(level.var_a3499c286ac570e4)) {
          if(namespace_aead94004cf4c147::function_efab78b72d131d76(victim)) {
            spawnedbackpack.weaponslotcontents = function_d9b1550011525161(victim);
            spawnedbackpack.weaponslotobj = function_2985254128b1c262(victim);
            spawnedbackpack.weaponslotclip = ter_op(isDefined(victim.weaponslotclip), victim.weaponslotclip, weaponclipsize(spawnedbackpack.weaponslotobj));
            spawnedbackpack.var_275f4441ab7920c8 = function_86a5c7670325346b(victim, 2);

            if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
              spawnedbackpack.metadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);
            }

            if(spawnedbackpack.weaponslotobj.hasalternate) {
              weaponalt = spawnedbackpack.weaponslotobj getaltweapon();
              spawnedbackpack.var_86b32aff94b5714e = ter_op(isDefined(victim.var_86b32aff94b5714e), victim.var_86b32aff94b5714e, weaponclipsize(weaponalt));
            }

            if(scripts\mp\utility\weapon::isakimbo(spawnedbackpack.weaponslotobj)) {
              spawnedbackpack.var_ad7897ecdbcb63 = ter_op(isDefined(victim.var_ad7897ecdbcb63), victim.var_ad7897ecdbcb63, weaponclipsize(spawnedbackpack.weaponslotobj));
            }
          }
        }

        spawnedbackpack.containertype = 6;
        spawnedbackpack.owner = victim;
        spawnedbackpack.deadplayerindex = scripts\mp\gametypes\dmz_dog_tag::function_fb2923d9d7eb7aac(victim);
        victim.var_6a4360dcf2a8f3d4 = spawnedbackpack;

        foreach(item in spawnedbackpack.contents) {
          scripts\engine\utility::callsharedfunc(item["lootID"], "addedToContainer", spawnedbackpack, victim);
        }
      }
    }
  }

  if(isDefined(victim.attached_bag) && !istrue(level.uselootablecorpse)) {
    victim scripts\mp\gametypes\br_gametype_dmz::detachbag();
  }
}

function function_ae287e5eb2024104(victim, dropstruct) {
  victim.var_d2dbb2fa012e6d9c = victim namespace_aead94004cf4c147::function_88a168912191ec3e();

  if(istrue(level.var_51225d738094457d) && isDefined(victim.var_d2dbb2fa012e6d9c)) {
    bagmodel = victim.attached_bag;

    if(!isDefined(bagmodel)) {
      bagmodel = "brloot_backpack";
    }

    loadoutcontents = [];
    index = 0;
    firstweapon = 1;
    weaponslotcontents = undefined;
    weaponslotobj = undefined;

    foreach(indextype, itemtype in victim.var_d2dbb2fa012e6d9c) {
      if(!itemtype.size) {
        continue;
      }

      foreach(slot in itemtype) {
        if(!isDefined(slot)) {
          continue;
        }

        lootid = slot[0];
        quantity = slot[1];

        if(!istrue(lootid) || !istrue(quantity)) {
          continue;
        }

        if(indextype == 1) {
          if(itemtype.size > 1) {
            if(!firstweapon) {
              weaponslotcontents = lootid;
              weaponslotobj = slot[2];
            }

            firstweapon = 0;
          }

          continue;
        }

        loadoutcontents[index] = [];
        loadoutcontents[index]["lootID"] = lootid;
        loadoutcontents[index]["quantity"] = quantity;
        index++;
      }
    }

    if(isDefined(loadoutcontents) && loadoutcontents.size > 0) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      teamindex = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim.sessionuimemberindex;
      loadoutbackpack = scripts\mp\gametypes\br_pickups::spawnpickup(function_432475069c798ddc(bagmodel), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex);

      if(!isDefined(loadoutbackpack)) {
        return;
      }

      if(isDefined(weaponslotcontents) && isDefined(weaponslotobj)) {
        loadoutbackpack.weaponslotcontents = weaponslotcontents;
        loadoutbackpack.weaponslotobj = weaponslotobj;

        if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
          loadoutbackpack.metadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 1);
        }
      }

      loadoutbackpack.contents = loadoutcontents;
      loadoutbackpack.containertype = 6;
      loadoutbackpack.owner = victim;
      loadoutbackpack.deadplayerindex = scripts\mp\gametypes\dmz_dog_tag::function_fb2923d9d7eb7aac(victim);
      victim.var_77893f01ee39c62e = loadoutbackpack;
    }
  }
}

function function_1db038329eb56917(player, lootid, quantity, indexlength) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  teamindex = scripts\engine\utility::array_find(level.allteamnamelist, player.team);
  squadindex = player.sessionuimemberindex;
  spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup(function_432475069c798ddc(self.attached_bag), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex);

  if(isDefined(spawnedbackpack)) {
    backpackcontents = [];

    for(var_f45699551971765c = 0; var_f45699551971765c < indexlength; var_f45699551971765c++) {
      backpackcontents[var_f45699551971765c] = [];
      backpackcontents[var_f45699551971765c]["lootID"] = lootid;
      backpackcontents[var_f45699551971765c]["quantity"] = quantity;
    }

    spawnedbackpack.contents = backpackcontents;
    spawnedbackpack.containertype = 6;
    spawnedbackpack.owner = player;
    player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(19, spawnedbackpack.origin, spawnedbackpack.index);
  }
}

function function_432475069c798ddc(xmodelname) {
  if(isDefined(xmodelname)) {
    switch (xmodelname) {
      case #"hash_dca6f419e607e1f7":
        return "brloot_backpack_player_small";
      case #"hash_d9938108fa8eb85f":
        return "brloot_backpack_player_medium";
      case #"hash_e3731b91d944f82f":
        return "brloot_backpack_player_large";
      case #"hash_e6d61aa8716cb5e3":
        return "brloot_backpack_player_secure";
      case #"hash_1dc65c7b5858c244":
        return "brloot_backpack_player_scav";
    }
  }

  return "brloot_backpack";
}

function function_565cbea3437267d9(player) {
  var_f6af44bb087c3da5 = function_102abd6883c5f9bf(player);

  if(var_f6af44bb087c3da5 != 0) {
    backpacktype = function_2c4cee072c4426c4(var_f6af44bb087c3da5);

    switch (backpacktype) {
      case 1:
        return "parts_backpack_inventory_medium";
      case 2:
        return "parts_backpack_inventory_large";
      case 3:
        return "dmz_backpack_secured";
      case 4:
        return "dmz_backpack_scavenger";
      default:
        return "parts_backpack_inventory_small";
    }

    return "parts_backpack_inventory_small";
  }

  size = getplayerbackpacksize(player);

  switch (size) {
    case 5:
      return "parts_backpack_inventory_small";
    case 7:
      return "parts_backpack_inventory_medium";
    case 9:
      return "parts_backpack_inventory_large";
    case 11:
      return "dmz_backpack_scavenger";
    default:
      return "parts_backpack_inventory_small";
  }

  return "parts_backpack_inventory_small";
}

function function_3188d9c94b3d56c2(lootname) {
  if(!isDefined(lootname)) {
    return 5;
  }

  switch (lootname) {
    case #"hash_75ca97f27fab119c":
      return 7;
    case #"hash_5cdbaa0bf3e5ebfe":
      return 9;
    case #"hash_7e7616dbf5a436f2":
      return 5;
    case #"hash_c2b5d7ec929a9d4a":
      return 11;
    default:
      break;
  }

  return 5;
}

function function_cb9faea721c36499(size) {
  if(isDefined(size)) {
    switch (size) {
      case 5:
        return undefined;
      case 7:
        return scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_backpack_medium");
      case 9:
        return scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_backpack_large");
      default:
        break;
    }
  }

  return undefined;
}

function function_2c4cee072c4426c4(lootid) {
  if(!isDefined(lootid)) {
    return 0;
  }

  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptablename)) {
    return 0;
  }

  switch (scriptablename) {
    case #"hash_75ca97f27fab119c":
      return 1;
    case #"hash_5cdbaa0bf3e5ebfe":
      return 2;
    case #"hash_7e7616dbf5a436f2":
      return 3;
    case #"hash_c2b5d7ec929a9d4a":
      return 4;
    default:
      return 0;
  }

  return 0;
}

function function_41b6bff9497a60d9(lootid) {
  if(!isDefined(lootid)) {
    return false;
  }

  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptablename)) {
    return false;
  }

  switch (scriptablename) {
    case #"hash_5cdbaa0bf3e5ebfe":
    case #"hash_75ca97f27fab119c":
      return true;
    case #"hash_7e7616dbf5a436f2":
      return false;
    default:
      return false;
  }

  return false;
}

function function_c4f1bd7a01a307fa(player) {
  if(istrue(player.extracted)) {
    return function_f41d7258200e1d08(player);
  }

  return (function_f41d7258200e1d08(player) || istrue(player.var_4f7710ecff5b1619)) && getdvarint(@ "hash_ff574f42cbb4f9f7", 1);
}

function function_f41d7258200e1d08(player) {
  var_f6af44bb087c3da5 = function_102abd6883c5f9bf(player);

  if(var_f6af44bb087c3da5 == 0) {
    return false;
  }

  var_88b0df56aedaf993 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_backpack_secure");

  if(!isDefined(var_88b0df56aedaf993)) {
    return false;
  }

  return var_f6af44bb087c3da5 == var_88b0df56aedaf993;
}

function function_102abd6883c5f9bf(player) {
  if(!isDefined(player.backpackid)) {
    return 0;
  }

  return player.backpackid;
}

function function_91c1be871300a518(lootid) {
  backpackname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(backpackname)) {
    backpackname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  return backpackname;
}

function function_a40546ed395d06c8(ammoarray) {
  return array_sort_with_func(ammoarray, &function_6f3fb8a752376eb2);
}

function function_6f3fb8a752376eb2(a, b) {
  return a <= b;
}

function isbackpackinventoryenabled() {
  if(!isDefined(level.noinventory)) {
    return false;
  }

  if(!namespace_ad49798629176e96::function_c84e254980c7c8ed()) {
    return false;
  }

  if(!level.noinventory) {
    return true;
  }

  return false;
}

function function_7e103028c464ab9a(itemname) {
  var_2c155eac30eee07 = isbackpackinventoryenabled();

  if(var_2c155eac30eee07 && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("lootAllowedInBackpack")) {
    var_2c155eac30eee07 = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("lootAllowedInBackpack", itemname);
  }

  return var_2c155eac30eee07;
}

function function_9ac2038430604b09(player) {
  for(weaponindex = 0; weaponindex < 3; weaponindex++) {
    var_2b3e04e32a6a0c4c = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, weaponindex);

    if(isDefined(var_2b3e04e32a6a0c4c) && !scripts\mp\utility\weapon::isfistsonly(var_2b3e04e32a6a0c4c) && !scripts\mp\utility\weapon::isgunlessweapon(var_2b3e04e32a6a0c4c)) {
      rootname = scripts\cp_mp\weapon::getweaponrootname(var_2b3e04e32a6a0c4c);

      if(rootname != "none") {
        return true;
      }
    }
  }

  return false;
}

function function_cf1bef64e94f2d1a(itemtype, itemindex, var_a548a6c15ceb9e8c, var_616ab931ecba446b, getsingle) {
  var_a548a6c15ceb9e8c = istrue(var_a548a6c15ceb9e8c);

  switch (itemtype) {
    case 0:
      if(istrue(level.var_b75e093e97f9e931)) {
        plundercount = 0;

        if(isDefined(self.plundercount) && self.plundercount > 0) {
          plundercount = scripts\mp\gametypes\br_pickups::getquickdropplundercount(!istrue(getsingle));
        }

        if(plundercount <= 0) {
          if(var_a548a6c15ceb9e8c) {
            return [8395, 0];
          } else {
            return undefined;
          }
        }

        if(!istrue(var_616ab931ecba446b)) {
          scripts\mp\gametypes\br_plunder::playersetplundercount(0);
        }

        return [8395, plundercount];
      }

      dropinfo = scripts\mp\gametypes\br_plunder::function_79275e2fab13f54d();
      var_6aee9c9054f09ed5 = dropinfo.var_6aee9c9054f09ed5;
      var_b64f283113c99581 = dropinfo.var_b64f283113c99581;

      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("playerPlunderModifyInventoryDrop")) {
        [var_6aee9c9054f09ed5, var_b64f283113c99581] = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerPlunderModifyInventoryDrop", var_6aee9c9054f09ed5, var_b64f283113c99581);
      }

      self.plundercountondeath = var_6aee9c9054f09ed5;
      scripts\mp\gametypes\br_plunder::playersetplundercount(var_6aee9c9054f09ed5);

      if(var_b64f283113c99581 <= 0) {
        if(var_a548a6c15ceb9e8c) {
          return [8395, 0];
        } else {
          return undefined;
        }
      }

      return [8395, var_b64f283113c99581];
    case 1:
      if(itemindex == 2) {
        if(!namespace_aead94004cf4c147::function_efab78b72d131d76(self)) {
          return [0, 0, undefined];
        }

        lootid = self getplayerdata(level.progressiongroup, "dmzWeapon", "lootItemID");
        var_ec22a950f210e39 = namespace_aead94004cf4c147::function_2985254128b1c262(self);
        return [lootid, self getweaponammoclip(var_ec22a950f210e39), var_ec22a950f210e39];
      }

      var_ec22a950f210e39 = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(self, itemindex);

      if(!isDefined(var_ec22a950f210e39)) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0, undefined];
        } else {
          return undefined;
        }
      }

      rootname = scripts\cp_mp\weapon::getweaponrootname(var_ec22a950f210e39);
      variantid = var_ec22a950f210e39.variantid;

      if(!isDefined(var_ec22a950f210e39.variantid)) {
        variantid = 0;
      }

      lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
      return [lootid, self getweaponammoclip(var_ec22a950f210e39), var_ec22a950f210e39];
    case 10:
      return function_6738846da50730f1(itemindex);
    case 2:
      slot = scripts\mp\equipment::function_4967838290cb31b9(itemindex);

      if(!isDefined(self.equipment[slot])) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0];
        } else {
          return undefined;
        }
      }

      ref = self.equipment[slot];
      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      ammocount = 0;

      if(ref == "equip_hb_sensor") {
        ammocount = scripts\cp_mp\equipment\hb_sensor::function_db61876aca4e4cd3();
      } else if(istrue(getsingle)) {
        ammocount = 1;
      } else {
        ammocount = scripts\mp\equipment::getequipmentslotammo(slot);
      }

      return [lootid, ammocount];
    case 3:
      if(!isDefined(self.streakdata.streaks[1])) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0];
        } else {
          return undefined;
        }
      }

      scriptable = level.br_pickups.var_838863c4848d4c26[self.streakdata.streaks[1].streakname];
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptable);
      return [lootid, 1];
    case 4:
      if(!isDefined(self.equipment["super"])) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0];
        } else {
          return undefined;
        }
      }

      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment["super"]);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      ammocount = scripts\mp\gametypes\br_pickups::function_fcde72dcbcec206b();

      if(isDefined(ammocount) && ammocount == 0) {
        if(istrue(self.var_1066fbd86c88a6df) || scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() && scripts\mp\supers::issuperready()) {
          ammocount = 1;
        }
      }

      ammocount = default_to(ammocount, 0);
      return [lootid, ammocount];
    case 6:
      headgeartype = self.headgeartype;

      if(!scripts\mp\gametypes\br_headgear::hasheadgear(headgeartype, self) || istrue(self.var_46fa9025626f3183)) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0];
        } else {
          return undefined;
        }
      }

      var_fcb952f595aa03ed = scripts\mp\gametypes\br_headgear::function_5ecd6df2572a5899(headgeartype, self);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_fcb952f595aa03ed);
      quantity = scripts\mp\gametypes\br_headgear::function_5109f3947b0c7dfb(headgeartype, self);
      return [lootid, quantity];
    case 7:
      if(!scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
        if(var_a548a6c15ceb9e8c) {
          return [0, 0];
        } else {
          return undefined;
        }
      }

      if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
        if(level.br_circle.circleindex == 0) {
          if(!isDefined(self.var_ad98d6456993dafe)) {
            self.var_ad98d6456993dafe = 1;

            if(var_a548a6c15ceb9e8c) {
              return [0, 0];
            } else {
              return undefined;
            }
          }
        }
      }

      var_d11137e58d02736c = scripts\mp\gametypes\br_public::function_791e72676cd7b544(self);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_d11137e58d02736c);
      return [lootid, 1];
    case 13:
      if(var_a548a6c15ceb9e8c) {
        return [0, 0];
      } else {
        return undefined;
      }
    default:
      assertmsg("<dev string:x26e>" + itemtype);
      return;
  }
}

function getplayerbackpacksize(player) {
  backpacksize = function_684ef6e1c75b5518(player);

  if(isDefined(backpacksize)) {
    return backpacksize;
  }

  return 0;
}

function function_684ef6e1c75b5518(player) {
  if(istrue(level.var_a7f81dfdc88e53e6)) {
    return level.var_e247454ac2869696;
  }

  if(!isDefined(level.progressiongroup) || !isDefined(level.backpacksize)) {
    return undefined;
  }

  return player getplayerdata(level.progressiongroup, level.backpacksize);
}

function function_d28f52da6ede0191(player, size, var_cb6cd39e3733b463, backpackid) {
  player.backpackid = backpackid;

  if(!isDefined(backpackid)) {
    player.backpackid = function_cb9faea721c36499(size);
  }

  backpacktype = function_2c4cee072c4426c4(player.backpackid);
  player setclientomnvar("ui_loot_backpack_type", backpacktype);
  player setplayerdata(level.progressiongroup, level.backpacksize, size);
  player setplayerdata(level.progressiongroup, "backpackSize", size);

  if(istrue(var_cb6cd39e3733b463)) {
    return;
  }

  var_8f24a28261fb9da3 = namespace_aead94004cf4c147::function_565cbea3437267d9(player);
  player scripts\mp\gametypes\br_gametype_dmz::attachbag(var_8f24a28261fb9da3);
}

function function_6491bd812bb47efb(player, currentsize, backpackname) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  for(i = currentsize; i < 11; i++) {
    [lootid, quantity, _] = function_6738846da50730f1(i);

    if(!isDefined(lootid) || !isDefined(quantity)) {
      continue;
    }

    if(lootid == 0 || quantity == 0) {
      continue;
    }

    scripts\mp\gametypes\br_pickups::function_6f62cb4fc113349c(player, 10, i, 1);
  }

  if(!function_18e2d7a6912b1d07(backpackname) && function_efab78b72d131d76(player)) {
    scripts\mp\gametypes\br_pickups::quickdropweapon(player, 1, 2);
  }
}

function function_18e2d7a6912b1d07(backpackname) {
  if(!isDefined(backpackname)) {
    return false;
  }

  switch (backpackname) {
    case #"hash_5cdbaa0bf3e5ebfe":
    case #"hash_75ca97f27fab119c":
      return true;
    case #"hash_7e7616dbf5a436f2":
    case #"hash_c2b5d7ec929a9d4a":
      return false;
    default:
      return false;
  }

  return false;
}

function function_69a380e3f9c37cc7(player) {
  foreach(weaponobj in player.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      return false;
    }
  }

  if(!namespace_aead94004cf4c147::function_efab78b72d131d76(player)) {
    return false;
  }

  return true;
}

function function_631fd0855c653a68(player, onconnect) {
  level endon("game_ended");
  player endon("disconnect");

  while(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && !istrue(self function_f6c07d6ea7d83a5a())) {
    waitframe();
  }

  restored = namespace_a38a2e1fe7519183::function_c241fbc63120cfc4(player, onconnect);

  if(!istrue(level.var_a7f81dfdc88e53e6)) {
    backpacksize = namespace_aead94004cf4c147::getplayerbackpacksize(player);
    backpackid = ter_op(istrue(restored), player.backpackid, undefined);
    namespace_aead94004cf4c147::function_d28f52da6ede0191(player, backpacksize, 1, backpackid);
  }

  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  restored = namespace_a38a2e1fe7519183::function_fc56050bd3dcea6c(player);
}

function function_88a168912191ec3e(doublebackpack, var_a548a6c15ceb9e8c, var_616ab931ecba446b) {
  loadoutcontents = [];
  loadoutcontents[0] = [];
  loadoutcontents[0][0] = function_cf1bef64e94f2d1a(0, 0, var_a548a6c15ceb9e8c, var_616ab931ecba446b);
  loadoutcontents[1] = [];
  loadoutcontents[1][0] = function_cf1bef64e94f2d1a(1, 0, var_a548a6c15ceb9e8c);
  loadoutcontents[1][1] = function_cf1bef64e94f2d1a(1, 1, var_a548a6c15ceb9e8c);
  loadoutcontents[2] = [];
  loadoutcontents[2][0] = function_cf1bef64e94f2d1a(2, 0, var_a548a6c15ceb9e8c);
  loadoutcontents[2][1] = function_cf1bef64e94f2d1a(2, 1, var_a548a6c15ceb9e8c);
  loadoutcontents[2][2] = function_cf1bef64e94f2d1a(2, 2, var_a548a6c15ceb9e8c);
  loadoutcontents[3] = [];

  if(istrue(doublebackpack)) {
    loadoutcontents[3][0] = function_cf1bef64e94f2d1a(3, 0, var_a548a6c15ceb9e8c);
  }

  loadoutcontents[4] = [];
  loadoutcontents[4][0] = function_cf1bef64e94f2d1a(4, 0, var_a548a6c15ceb9e8c);

  if(istrue(doublebackpack)) {
    loadoutcontents[6] = [];
    loadoutcontents[6][0] = function_cf1bef64e94f2d1a(6, 0, var_a548a6c15ceb9e8c);
    loadoutcontents[7] = [];
    loadoutcontents[7][0] = function_cf1bef64e94f2d1a(7, 0, var_a548a6c15ceb9e8c);
  }

  return loadoutcontents;
}

function function_b4f4561fdb86fa25(player) {
  if(!istrue(level.var_d034183abf2e274d) || namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() || istrue(level.var_b4f4561fdb86fa25)) {
    player function_bab1a10b3fdaae51();
    function_590202daf6a1d4d7(player);
    function_d28f52da6ede0191(player, 5, 1);
    player setplayerdata(level.progressiongroup, "dmzPlateCarrierLevel", 1);
    function_590202daf6a1d4d7(player);
  }
}

function printinventory() {
  for(i = 0; i < 50; i++) {
    lootid = self getplayerdata(level.progressiongroup, "<dev string:x290>", i, "<dev string:x2a0>");
    quantity = self getplayerdata(level.progressiongroup, "<dev string:x290>", i, "<dev string:x2aa>");
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    println("<dev string:x13c>" + i + "<dev string:x141>" + lootid + "<dev string:x14a>" + ref + "<dev string:x150>" + quantity);
  }
}

function function_720d227d0e55a960() {
  if(!isDefined(level.var_7d17e26667be2792)) {
    level.var_7d17e26667be2792 = getdvarint(@ "hash_55d9444d8a3ce31a", 0);
  }

  return level.var_7d17e26667be2792;
}

function function_5323bef1ad6244b9(damagetick) {
  var_e32ed31bf12217d2 = [];
  var_e32ed31bf12217d2 = function_5915bdbc5f6302b6(level.var_534e97d34ef9fa29);

  foreach(var_a58c1fca5d8a5b2 in var_e32ed31bf12217d2) {
    function_e900e7e66383ad97(self, var_a58c1fca5d8a5b2, int(getquantityatbackpackindex(var_a58c1fca5d8a5b2) - damagetick));
  }
}

function function_e25e584cac984a5d(itemtype) {
  if(!isDefined(itemtype)) {
    return false;
  }

  itemtype = getxhash(itemtype);
  return itemtype == #"plunder" || itemtype == #"valuable" || itemtype == #"personal" || itemtype == #"dogtag";
}

function function_f4fc5c80c4d45c10(backpack) {
  if(isDefined(self.dropped_backpack)) {
    self.dropped_backpack.criticalitem = undefined;
    self.dropped_backpack notify("end_backpack_empty_watcher");
  }

  self.dropped_backpack = backpack;
  self.dropped_backpack.criticalitem = 1;
  self.dropped_backpack thread backpack_empty_watcher();
}

function backpack_empty_watcher() {
  level endon("game_ended");
  self endon("end_backpack_empty_watcher");

  while(isDefined(self) && !isDefined(self.loadoutcontents)) {
    wait 0.05;
  }

  while(isDefined(self) && isDefined(self.loadoutcontents)) {
    b_empty = 1;

    for(i = 0; i < self.loadoutcontents.size - 1; i++) {
      if(self.loadoutcontents[i]["quantity"]) {
        b_empty = 0;
      }
    }

    if(b_empty) {
      self.criticalitem = undefined;
      return;
    }

    wait 1;
  }
}

function function_68bca2c2e9f0a1d3(firstindex, secondindex) {
  backpacksize = getplayerbackpacksize(self);

  if(firstindex < 0 || firstindex >= backpacksize || secondindex < 0 || secondindex >= backpacksize) {
    return;
  }

  [var_26e51dc5f1cc490, var_c1500f171aeb561a, var_ed4dabc339a6141] = function_6738846da50730f1(firstindex);
  [var_41dcbc4d3302f6dc, var_4819afa0c5073b0e, var_6448cb914c5afd45] = function_6738846da50730f1(secondindex);

  if(isDefined(var_26e51dc5f1cc490) && isDefined(var_c1500f171aeb561a) && isDefined(var_41dcbc4d3302f6dc) && isDefined(var_4819afa0c5073b0e)) {
    setbackpackitematindex(self, secondindex, var_26e51dc5f1cc490, var_c1500f171aeb561a, var_ed4dabc339a6141);
    setbackpackitematindex(self, firstindex, var_41dcbc4d3302f6dc, var_4819afa0c5073b0e, var_6448cb914c5afd45);

    if(scripts\mp\gametypes\br_pickups::function_9b77601837f66e32(var_26e51dc5f1cc490) || scripts\mp\gametypes\br_pickups::function_9b77601837f66e32(var_41dcbc4d3302f6dc)) {
      namespace_6c622b52017c6808::function_6d070b6ad87fc4a2(self, var_26e51dc5f1cc490, var_41dcbc4d3302f6dc, firstindex, secondindex);
    }

    if(scripts\mp\gametypes\br_pickups::function_b605a733974c2ff5(var_26e51dc5f1cc490) && scripts\mp\equipment\disguise::function_8e1f9b3b6c83372d(firstindex)) {
      scripts\mp\equipment\disguise::function_9ee717001acd63a0(secondindex);
      return;
    }

    if(scripts\mp\gametypes\br_pickups::function_b605a733974c2ff5(var_41dcbc4d3302f6dc) && scripts\mp\equipment\disguise::function_8e1f9b3b6c83372d(secondindex)) {
      scripts\mp\equipment\disguise::function_9ee717001acd63a0(firstindex);
    }
  }
}

function function_ce92a41b8f3b666f(backpackindex, containerindex) {
  backpacksize = getplayerbackpacksize(self);
  container = self.var_2fa5b49969def47;

  if(backpackindex < 0 || backpackindex >= backpacksize) {
    return;
  }

  [backpacklootid, backpackquantity, _] = function_6738846da50730f1(backpackindex);
  [containerlootid, containerquantity] = scripts\mp\loot::function_edb397974ae6ee68(self, container, containerindex, 0);
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpacklootid);

  if(isDefined(backpacklootid) && isDefined(backpackquantity) && isDefined(containerlootid) && isDefined(containerquantity)) {
    var_da5c10799c16c24f = 8569;

    if(containerlootid == var_da5c10799c16c24f) {
      scripts\mp\loot::function_f0617ad70b7e7792(containerindex, backpackindex, container);
      return;
    } else {
      setbackpackitematindex(self, backpackindex, containerlootid, containerquantity);
    }

    if(backpacklootid == 0 || function_5b7e9a4c946f3a13(container.containertype, [13, 15])) {
      scripts\mp\loot::function_153d3281e46e14da(self, container, containerindex, backpacklootid, backpackquantity);
    } else {
      scripts\mp\loot::function_153d3281e46e14da(self, container, containerindex, 0, 0);
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      item = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, backpackquantity, 1);
      scripts\engine\utility::callsharedfunc(scriptablename, "dropped", item, self, dropinfo.origin);
    }

    var_2789584b4d4cb228 = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpacklootid);

    if(scripts\mp\gametypes\br_pickups::function_282d89f7705a2d63(var_2789584b4d4cb228)) {
      scripts\mp\gametypes\br_pickups::function_bfc82c27ed3d9308(backpacklootid, backpackquantity, var_2789584b4d4cb228, backpackindex);
    }
  }
}

function function_1d982e57487b7efe() {
  startweapon = self getcurrentweapon();
  primaryweapon = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(self, 0);
  secondaryweapon = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(self, 1);

  if(scripts\mp\utility\weapon::function_1e9278ba699927f7(primaryweapon) || scripts\mp\utility\weapon::function_1e9278ba699927f7(secondaryweapon)) {
    return;
  }

  var_f5e71c4df042fa27 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(primaryweapon);
  var_4cc9e4d0a2b19a67 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(secondaryweapon);
  var_1ab509d42abd4c39 = self getweaponammoclip(primaryweapon);
  var_f877d26184fc0d79 = self getweaponammoclip(secondaryweapon);
  var_dcf6299535b22f5e = 0;
  var_2e177550d1cc0f9e = 0;

  if(primaryweapon.basename != "iw9_me_fists_mp") {
    var_dcf6299535b22f5e = self.br_ammo[var_f5e71c4df042fa27];
  }

  if(secondaryweapon.basename != "iw9_me_fists_mp") {
    var_2e177550d1cc0f9e = self.br_ammo[var_4cc9e4d0a2b19a67];
  }

  self switchtoweaponimmediate(ter_op(issameweapon(startweapon, primaryweapon), secondaryweapon, primaryweapon));
  self takeweapon(primaryweapon);
  self takeweapon(secondaryweapon);
  self giveweapon(secondaryweapon);
  self giveweapon(primaryweapon);

  if(primaryweapon.basename != "iw9_me_fists_mp") {
    scripts\mp\gametypes\br_weapons::br_ammo_update_ammotype_weapons(self, var_f5e71c4df042fa27, var_dcf6299535b22f5e);
    self setweaponammoclip(primaryweapon, var_1ab509d42abd4c39);
  }

  if(secondaryweapon.basename != "iw9_me_fists_mp") {
    scripts\mp\gametypes\br_weapons::br_ammo_update_ammotype_weapons(self, var_4cc9e4d0a2b19a67, var_2e177550d1cc0f9e);
    self setweaponammoclip(secondaryweapon, var_f877d26184fc0d79);
  }
}

function function_51301c83420d42b4(inventoryindex, containerindex) {
  container = self.var_2fa5b49969def47;
  [_, weaponslotobj, pastteam, metadata, quantity, altquantity, lefthandquantity] = scripts\mp\loot::function_775a7fc396485a9a(self, container, containerindex);
  weapon = weaponslotobj;

  if(scripts\mp\utility\weapon::function_1e9278ba699927f7(weapon)) {
    return;
  }

  quantity = default_to(quantity, weaponclipsize(weapon));

  if(scripts\mp\utility\weapon::isakimbo(weapon)) {
    lefthandquantity = default_to(lefthandquantity, weaponclipsize(weapon));
  }

  backpackid = function_102abd6883c5f9bf(self);
  backpackname = function_91c1be871300a518(backpackid);
  backpackequip = function_18e2d7a6912b1d07(backpackname) && !function_efab78b72d131d76(self);
  self.lastdroppableweaponobj = self.primaryweapons[inventoryindex];
  success = scripts\mp\gametypes\br_pickups::equipweapon(weapon, quantity, undefined, altquantity, backpackequip, undefined, metadata, undefined, undefined, pastteam, lefthandquantity);

  if(success) {
    if(scripts\mp\loot::function_54066dbd8ef44fe1(container) || container.containertype == 15) {
      scripts\mp\loot::function_505e8eb7e77704c5(self, container);
      return;
    }

    scripts\mp\loot::function_153d3281e46e14da(self, container, containerindex, 0, 0);
  }
}

function function_9f1f9042105e4240(itemtype, itemindex, backpackindex) {
  if(!scripts\mp\gametypes\br::function_420ec7054801a5bd(itemtype, itemindex)) {
    return;
  }

  loadoutdata = function_cf1bef64e94f2d1a(itemtype, itemindex);

  if(!isDefined(loadoutdata)) {
    return;
  }

  loadoutlootid = loadoutdata[0];
  loadoutquantity = loadoutdata[1];
  [backpacklootid, backpackquantity, _] = function_6738846da50730f1(backpackindex);
  var_fe868233e98e9d8b = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpacklootid);
  var_ecbfb8d6f45ca36b = scripts\cp_mp\utility\loot::getscriptablefromlootid(loadoutlootid);
  loadoutitemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(loadoutlootid);
  var_b3fccfb5ca1d6ea8 = backpacklootid == 0;

  if(!var_b3fccfb5ca1d6ea8) {
    var_128a351cea87d140 = scripts\mp\gametypes\br_pickups::issuperpickup(var_fe868233e98e9d8b) && scripts\mp\gametypes\br_pickups::issuperpickup(var_ecbfb8d6f45ca36b);
    var_bb9a27098c4e4de9 = loadoutitemref != "super_stimpistol" || loadoutitemref != "super_oxygen_mask";

    if(var_128a351cea87d140 && var_bb9a27098c4e4de9) {
      thread scripts\mp\gametypes\br_pickups::equipbackpackitem(backpackindex);
      return;
    }
  }

  if(loadoutlootid == backpacklootid && namespace_aead94004cf4c147::function_e01d9736b2d100ac(loadoutlootid, loadoutquantity)) {
    scripts\mp\gametypes\br_pickups::lootitem(loadoutlootid, loadoutquantity, undefined, 1, 1, 1);
    thread scripts\mp\gametypes\br_pickups::quickdropall(itemtype, itemindex, 1);
    return;
  }

  setbackpackitematindex(self, backpackindex, loadoutlootid, loadoutquantity);
  thread scripts\mp\gametypes\br_pickups::quickdropall(itemtype, itemindex, 1);

  if(!var_b3fccfb5ca1d6ea8 && !scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, var_fe868233e98e9d8b, 1, backpackquantity)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = scripts\mp\gametypes\br_pickups::spawnpickup(var_fe868233e98e9d8b, dropinfo, backpackquantity, 1);
  }
}

function function_a763f6f503206771(player, scriptable, lootid) {
  if(!isDefined(scriptable) || !isDefined(player)) {
    return;
  }

  fakepickup = spawnStruct();
  fakepickup.scriptablename = scripts\mp\gametypes\br_pickups::lootgetscriptablename(scriptable);
  fakepickup.count = scriptable.count;
  var_a08d277f2971b749 = 0;

  if(scripts\mp\gametypes\br_pickups::isweaponpickup(fakepickup.scriptablename)) {
    if(namespace_aead94004cf4c147::getplayerbackpacksize(player) <= 5) {
      return;
    }

    if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
      return;
    }

    [newweapon] = scripts\mp\gametypes\br_weapons::function_55c5d35c8c76a95b(scriptable);
    var_a08d277f2971b749 = 0;

    foreach(weap in player.primaryweapons) {
      if(issameweapon(weap, newweapon)) {
        fakepickup.scriptablename = br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
        var_a08d277f2971b749 = 1;
      }
    }

    if(namespace_aead94004cf4c147::function_efab78b72d131d76(player) && !var_a08d277f2971b749) {
      var_9ac5e72784815708 = namespace_aead94004cf4c147::function_2985254128b1c262(player);

      if(issameweapon(var_9ac5e72784815708, newweapon)) {
        fakepickup.scriptablename = br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
        var_a08d277f2971b749 = 1;
      } else {
        dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
        newweapondrop = player scripts\mp\gametypes\br_pickups::dropbrweapon(var_9ac5e72784815708, dropstruct, scriptable.origin);
        itemcount = default_to(player.weaponslotclip, 0);
        itemcountlefthand = default_to(player.var_ad7897ecdbcb63, 0);
        scripts\mp\gametypes\br_pickups::loot_setitemcount(newweapondrop, itemcount, itemcountlefthand, player.var_86b32aff94b5714e);

        if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
          newweapondrop.metadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(player, 2);
        }

        namespace_aead94004cf4c147::function_954372d604277278(player);
      }
    }

    if(!var_a08d277f2971b749) {
      var_bada25504e8844d7 = spawnStruct();
      newcount = scripts\mp\gametypes\br_pickups::loot_getitemcount(scriptable);
      var_bada25504e8844d7.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
      var_bada25504e8844d7.origin = player.origin;
      var_bada25504e8844d7.count = newcount;
      var_bada25504e8844d7.weapon = newweapon;
      var_bada25504e8844d7.var_4a08890fd43d6bc7 = 1;
      var_bada25504e8844d7.countlefthand = 0;
      var_bada25504e8844d7.countalt = scriptable.countalt;
      var_bada25504e8844d7.metadata = scriptable.metadata;
      var_bada25504e8844d7.customweaponname = scriptable.customweaponname;
      var_bada25504e8844d7.pastteam = scriptable.pastteam;
      [[scripts\engine\utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, newweapon, var_bada25504e8844d7.metadata);
      scripts\mp\gametypes\br_pickups::function_60234aa487445085(var_bada25504e8844d7, player, 0, scriptable);
      return;
    }
  }

  results = scripts\mp\gametypes\br_pickups::cantakepickup(fakepickup);

  if(results == 1 && (namespace_aead94004cf4c147::function_e01d9736b2d100ac(lootid, fakepickup.count) || scripts\mp\gametypes\br_pickups::isplunder(fakepickup.scriptablename)) || results == 20) {
    var_5a88dbc7a4ed6e63 = 1 && !scripts\mp\gametypes\br_pickups::isplunder(fakepickup.scriptablename) && !scripts\mp\gametypes\br_public::isammo(fakepickup.scriptablename) && !scripts\mp\gametypes\br_public::istoken(fakepickup.scriptablename);
    scripts\mp\gametypes\br_pickups::lootused(scriptable, undefined, undefined, player, undefined, undefined, 1, var_5a88dbc7a4ed6e63);

    if(br_public::isarmorplate(fakepickup.scriptablename)) {
      player armor::function_50deea7508dbf174();
    }

    self.var_2e208b49f21aaed9 = gettime();
    return;
  }

  if(!player scripts\mp\gametypes\br::function_1c7f3f4e23f94f86(fakepickup.scriptablename)) {
    return;
  }

  if(scripts\mp\gametypes\br_pickups::isplunder(fakepickup.scriptablename)) {
    return;
  }

  if(var_a08d277f2971b749) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
    return;
  }

  if(scripts\mp\gametypes\br_pickups::function_df3f5431c93ed5a1(lootid)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_61251ef22efa8d15);
    return;
  }

  tmpcontainer = scriptable;
  tmpcontainer.contents = [];
  tmpcontainer.containertype = 14;
  tmpcontainer.contents[0] = [];
  tmpcontainer.contents[0]["quantity"] = scriptable.count;
  tmpcontainer.contents[0]["lootID"] = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
  scripts\mp\loot::function_68ca06034b8aaccd(player, tmpcontainer);
}

function function_c2f16e2bbb4e38c0(itemsonspawn, quantity) {
  if(!isDefined(quantity)) {
    quantity = 1;
  }

  items = strtok(itemsonspawn, ",");

  foreach(itemname in items) {
    backpackindex = namespace_aead94004cf4c147::getavailabledmzbackpackindex();

    if(!isDefined(backpackindex)) {
      break;
    }

    fakepickup = spawnStruct();
    fakepickup.scriptablename = itemname;
    fakepickup.count = quantity;
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
    namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup);
  }
}

function function_dee7316da051a630(lootname) {
  if(isDefined(lootname) && isDefined(level.br_pickups) && isDefined(level.br_pickups.var_4138f9ddc1cd22d)) {
    return level.br_pickups.var_4138f9ddc1cd22d[lootname];
  }

  return undefined;
}