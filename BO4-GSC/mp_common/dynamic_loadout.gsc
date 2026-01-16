/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\dynamic_loadout.gsc
***********************************************/

#include script_702b73ee97d18efe;
#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\loadout_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\armor;
#include scripts\mp_common\gametypes\menus;
#include scripts\mp_common\perks;
#include scripts\mp_common\pickup_health;
#include scripts\mp_common\player\player_loadout;

#namespace dynamic_loadout;

autoexec __init__system__() {
  system::register(#"dynamic_loadout", &__init__, undefined, #"weapons");
}

private __init__() {
  callback::on_connect(&onconnect);
  level.givecustomloadout = &function_738575c4;
  level.var_67f4fd41 = &function_485e3421;
  level.bountypackagelist = getscriptbundlelist("bounty_hunter_package_list");
  registerclientfields();
  level.var_968635ea = bountyhunterbuy::register("BountyHunterLoadout");

  for(i = 1; i < 38; i++) {
    if(i == 23) {
      continue;
    }

    ability_player::register_gadget_activation_callbacks(i, undefined, &function_597cbfb8);
  }

  callback::on_player_killed_with_params(&onplayerkilled);
}

private function_597cbfb8(slot, weapon, force = 0) {
  if(!force) {
    if(!isalive(self) || game.state != "playing") {
      return;
    }

    wait 1;

    if(self gadgetisready(slot)) {
      return;
    }
  }

  equipdata = self.pers[#"dynamic_loadout"].weapons[2];
  take = 1;

  if(isDefined(equipdata)) {
    if(equipdata.ammo > 1) {
      equipdata.ammo--;
      take = 0;
    }
  }

  if(take) {
    self.pers[#"dynamic_loadout"].weapons[2] = undefined;
    function_ff8ef46b(2, "luielement.BountyHunterLoadout.equipment", 0);
    self function_9ede386f(slot);
  }
}

private onplayerkilled(params) {
  function_cea5cbc5();

  if(!isDefined(params.eattacker) || params.eattacker != self) {
    return;
  }

  if(params.weapon.name == #"frag_grenade") {
    function_597cbfb8(self gadgetgetslot(params.weapon), params.weapon, 1);
  }
}

private function_9ede386f(slot) {
  wait 0.1;
  self gadgetpowerset(slot, 0);
  self function_19ed70ca(slot, 1);
}

private registerclientfields() {
  if(isDefined(level.bountypackagelist)) {
    var_2b5b08bd = int(ceil(log2(level.bountypackagelist.size + 1)));
    var_ff35ecd8 = getgametypesetting(#"bountybagomoneymoney");
    var_19302641 = getgametypesetting(#"hash_63f8d60d122e755b");

    if(var_19302641 > 0) {
      var_bfbe32b4 = int(ceil(log2(var_ff35ecd8 / var_19302641)));
      clientfield::register("toplayer", "bountyBagMoney", 1, var_bfbe32b4, "int");
    } else {
      clientfield::register("toplayer", "bountyBagMoney", 1, 1, "int");
    }

    clientfield::register("toplayer", "bountyMoney", 1, 14, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primary", 1, var_2b5b08bd, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondary", 1, var_2b5b08bd, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.armor", 1, var_2b5b08bd, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.reconTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.assaultTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.supportTrack.tierPurchased", 1, 2, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.scorestreak", 1, var_2b5b08bd, "int");
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.equipment", 1, var_2b5b08bd, "int");
    clientfield::register("worlduimodel", "BountyHunterLoadout.timeRemaining", 1, 5, "int");
    clientfield::register("clientuimodel", "hudItems.BountyCarryingBag", 1, 1, "int");
  }
}

private onconnect() {
  if(!isDefined(self.pers[#"dynamic_loadout"])) {
    self.pers[#"dynamic_loadout"] = spawnStruct();
    self.pers[#"dynamic_loadout"].weapons = [];
    self.pers[#"dynamic_loadout"].talents = [];
    self.pers[#"dynamic_loadout"].armor = undefined;
    self.pers[#"dynamic_loadout"].scorestreak = undefined;
    self.pers[#"dynamic_loadout"].clientfields = [];
  }

  self function_c6de6bdd();

  foreach(var_387a4eaf in self.pers[#"dynamic_loadout"].clientfields) {
    self clientfield::set_player_uimodel(var_387a4eaf.clientfield, var_387a4eaf.val);
  }
}

private function_485e3421() {
  if(isDefined(self.pers[#"dynamic_loadout"].armor)) {
    self function_51a2c3b3(self.pers[#"dynamic_loadout"].armor);
    self function_2b71fd3(self.pers[#"dynamic_loadout"].armor);
  }

  self removearmor();
}

removearmor() {
  self.pers[#"dynamic_loadout"].armor = undefined;
  self function_ff8ef46b(5, "luielement.BountyHunterLoadout.armor", 0);
}

private function_c6de6bdd() {
  self menus::register_menu_response_callback("BountyHunterBuy", &function_40eb02fc);
  self menus::register_menu_response_callback("BountyHunterPackageSelect", &function_40eb02fc);
}

private function_40eb02fc(response, intpayload) {
  if(!isDefined(intpayload)) {
    return;
  }

  clientfield = undefined;
  slot = undefined;
  isammo = 0;
  var_e120a933 = undefined;
  isscorestreak = 0;

  if(response == "undo_last_purchase") {
    return;
  }

  package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[intpayload - 1]);

  switch (response) {
    case #"hash_28554ae159269915":
      clientfield = "luielement.BountyHunterLoadout.primary";
      slot = 0;
      break;
    case #"hash_c785a629253dcd5":
      clientfield = "luielement.BountyHunterLoadout.secondary";
      slot = 1;
      break;
    case #"hash_390a1acd2edcd5b7":
      var_e120a933 = 1;
      clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
      slot = 11;
      break;
    case #"hash_390a1bcd2edcd76a":
      var_e120a933 = 2;
      clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
      slot = 11;
      break;
    case #"hash_390a1ccd2edcd91d":
      var_e120a933 = 3;
      clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
      slot = 11;
      break;
    case #"hash_2acbda1102e614f7":
      var_e120a933 = 1;
      clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
      slot = 12;
      break;
    case #"hash_2acbdb1102e616aa":
      var_e120a933 = 2;
      clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
      slot = 12;
      break;
    case #"hash_2acbdc1102e6185d":
      var_e120a933 = 3;
      clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
      slot = 12;
      break;
    case #"hash_7760a837c6f81098":
      clientfield = "luielement.BountyHunterLoadout.armor";
      slot = 5;
      break;
    case #"hash_46637ad5c1dd8390":
      clientfield = "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased";
      slot = 6;
      break;
    case #"hash_603babb2a7c35420":
      clientfield = "luielement.BountyHunterLoadout.reconTrack.tierPurchased";
      slot = 7;
      break;
    case #"hash_5792934483949728":
      clientfield = "luielement.BountyHunterLoadout.assaultTrack.tierPurchased";
      slot = 8;
      break;
    case #"hash_265c0500ba88a4a4":
      clientfield = "luielement.BountyHunterLoadout.supportTrack.tierPurchased";
      slot = 9;
      break;
    case #"hash_7b3685fb5a146b83":
      isammo = 1;

      if(function_2b402d5d(package)) {
        slot = 100;
      } else {
        slot = 101;
      }

      break;
    case #"hash_6e8d37dc2b55eb07":
      isscorestreak = 1;
      clientfield = "luielement.BountyHunterLoadout.scorestreak";
      slot = 10;
      break;
    case #"hash_45dc798feb538f7b":
      clientfield = "luielement.BountyHunterLoadout.equipment";
      slot = 2;
      break;
  }

  if(!self function_5b8256ca(package, isammo, var_e120a933, isscorestreak)) {
    return;
  }

  if(slot < 4) {
    self function_a3d739c6(slot, package);
  } else if(slot == 5) {
    self function_e6fa90be(package);
  } else if(slot <= 9) {
    self function_14e4d700(slot, package);
    intpayload = package.tracktier;
  } else if(slot == 10) {
    self function_1875e2a9(package);
  } else if(slot <= 12) {
    self function_7a836986(slot - 11, package, var_e120a933);
    intpayload = var_e120a933;
  } else if(slot <= 101) {
    self addammo(slot - 100, package);
  }

  if(isDefined(clientfield)) {
    self function_ff8ef46b(slot, clientfield, intpayload);

    if(clientfield == "luielement.BountyHunterLoadout.primary") {
      self function_ff8ef46b(11, "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 0);
    } else if(clientfield == "luielement.BountyHunterLoadout.secondary") {
      self function_ff8ef46b(12, "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 0);
    }
  }

  self function_738575c4(1, 0);
}

private function_5b8256ca(package, isammo = 0, var_e120a933 = undefined, isscorestreak = 0) {
  money = self.pers[#"money"];
  registerend_prestige_imp = isDefined(getgametypesetting(#"hash_1b34b26470f4368")) ? getgametypesetting(#"hash_1b34b26470f4368") : isscorestreak ? 1 : 1;
  cost = package.purchasecost * registerend_prestige_imp;

  if(isDefined(isammo) && isammo) {
    cost = package.refillcost * (isDefined(getgametypesetting(#"hash_71b2b43696e16252")) ? getgametypesetting(#"hash_71b2b43696e16252") : 1);
  } else if(isDefined(var_e120a933)) {
    cost = package.attachmentupgrades[var_e120a933 - 1].purchasecost * registerend_prestige_imp;
  }

  cost = int(cost);

  if(!isDefined(cost)) {
    return false;
  }

  if(money < cost) {
    return false;
  }

  money -= cost;
  self clientfield::set_to_player("bountyMoney", money);
  self.pers[#"money"] = money;
  return true;
}

private function_a3d739c6(slot, package) {
  self.pers[#"dynamic_loadout"].weapons[slot] = spawnStruct();
  self.pers[#"dynamic_loadout"].weapons[slot].name = package.packageitems[0].item;
  self.pers[#"dynamic_loadout"].weapons[slot].attachments = [];
  self.pers[#"dynamic_loadout"].weapons[slot].ammo = -1;
  self.pers[#"dynamic_loadout"].weapons[slot].startammo = package.startammo;
}

private function_e6fa90be(package) {
  self.pers[#"dynamic_loadout"].armor = {};
  self.pers[#"dynamic_loadout"].armor.name = package.packageitems[0].item;
  self.pers[#"dynamic_loadout"].armor.armor = package.armor;
  self.pers[#"dynamic_loadout"].armor.var_782dbf79 = isDefined(package.var_782dbf79) ? package.var_782dbf79 : 0;
  self.pers[#"dynamic_loadout"].armor.var_767b7337 = isDefined(package.var_767b7337) ? package.var_767b7337 : 0;
  self.pers[#"dynamic_loadout"].armor.var_741010b5 = isDefined(package.var_741010b5) ? package.var_741010b5 : 0;
  self.pers[#"dynamic_loadout"].armor.var_673a16ad = isDefined(package.var_673a16ad) ? package.var_673a16ad : 0;
}

private function_14e4d700(slot, package) {
  foreach(talent in package.packageitems) {
    if(!isDefined(self.pers[#"dynamic_loadout"].talents)) {
      self.pers[#"dynamic_loadout"].talents = [];
    } else if(!isarray(self.pers[#"dynamic_loadout"].talents)) {
      self.pers[#"dynamic_loadout"].talents = array(self.pers[#"dynamic_loadout"].talents);
    }

    self.pers[#"dynamic_loadout"].talents[self.pers[#"dynamic_loadout"].talents.size] = talent.item;
  }
}

function_ff8ef46b(slot, clientfield, newval) {
  self clientfield::set_player_uimodel(clientfield, newval);

  if(!isDefined(self.pers[#"dynamic_loadout"].clientfields[slot])) {
    self.pers[#"dynamic_loadout"].clientfields[slot] = spawnStruct();
    self.pers[#"dynamic_loadout"].clientfields[slot].clientfield = clientfield;
  }

  self.pers[#"dynamic_loadout"].clientfields[slot].val = newval;
}

private function_2b402d5d(package) {
  primary = self.pers[#"dynamic_loadout"].weapons[0];

  if(!isDefined(primary)) {
    return false;
  }

  if(!isDefined(primary.name)) {
    return false;
  }

  if(primary.name == package.packageitems[0].item) {
    return true;
  }

  return false;
}

private addammo(slot, package) {
  if(isDefined(package.refillammo) && package.refillammo > 0) {
    self.pers[#"dynamic_loadout"].weapons[slot].ammo = package.refillammo;
    return;
  }

  weapdata = self.pers[#"dynamic_loadout"].weapons[slot];
  weapon = getweapon(weapdata.name, weapdata.attachments);

  if(!isDefined(weapon.clipsize) || weapon.clipsize <= 0) {
    weapdata.ammo = 1;
    return;
  }

  weapdata.ammo = weapon.maxammo / weapon.clipsize + 1;
}

private function_1875e2a9(package) {
  self.pers[#"dynamic_loadout"].scorestreak = package.packageitems[0].item;
}

private function_7a836986(slot, package, var_e120a933) {
  var_51cc2fc9 = package.attachmentupgrades[var_e120a933 - 1].attachmentlist;
  attacharray = strtok(var_51cc2fc9, "+");

  foreach(attach in attacharray) {
    if(!isDefined(self.pers[#"dynamic_loadout"].weapons[slot].attachments)) {
      self.pers[#"dynamic_loadout"].weapons[slot].attachments = [];
    } else if(!isarray(self.pers[#"dynamic_loadout"].weapons[slot].attachments)) {
      self.pers[#"dynamic_loadout"].weapons[slot].attachments = array(self.pers[#"dynamic_loadout"].weapons[slot].attachments);
    }

    if(!isinarray(self.pers[#"dynamic_loadout"].weapons[slot].attachments, attach)) {
      self.pers[#"dynamic_loadout"].weapons[slot].attachments[self.pers[#"dynamic_loadout"].weapons[slot].attachments.size] = attach;
    }
  }
}

private function_738575c4(takeoldweapon, givestreak = 1) {
  self loadout::init_player(1);
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    self takeweapon(weapon);
  }

  killstreaks::function_2ea0382e();
  self function_f14e5ee3();
  self function_422164cd();
  self function_6a829089();

  if(givestreak) {
    self function_8d5ede64();
  }

  self function_d2f0197a();
  current_weapon = self getcurrentweapon();
  self thread loadout::initweaponattachments(current_weapon);
  self thread pickup_health::function_3fbb0e22();
  self setactionslot(3, "flourish_callouts");
}

private function_d2f0197a() {
  if(isDefined(self.pers[#"dynamic_loadout"].armor)) {
    self addtalent(#"hash_6be738527a4213aa");
    armor = self.pers[#"dynamic_loadout"].armor;
    self function_52630bb(armor);
    self armor::set_armor(armor.armor, armor.armor, 0, armor.var_767b7337, armor.var_782dbf79, armor.var_673a16ad, armor.var_741010b5, 1, 1, 1);
  }
}

private function_659633d8(var_31e314e8) {
  switch (var_31e314e8.name) {
    case #"hash_16cfc7f70dbd8712":
      return #"specialty_armor_tier_two";
    case #"hash_39045b0020cc3e00":
      return #"specialty_armor_tier_three";
    default:
      return #"specialty_armor";
  }
}

private function_51a2c3b3(var_31e314e8) {
  if(!isDefined(var_31e314e8)) {
    return;
  }

  switch (var_31e314e8.name) {
    case #"hash_16cfc7f70dbd8712":
      playFXOnTag(#"hash_56c8182de62c1c6", self, "j_spineupper");
    case #"hash_39045b0020cc3e00":
      playFXOnTag(#"hash_3c6a01bd4394d4f3", self, "j_spineupper");
    default:
      playFXOnTag(#"hash_4a955131370a3720", self, "j_spineupper");
      break;
  }
}

private function_52630bb(var_31e314e8) {
  armor_perk = function_659633d8(var_31e314e8);
  self setperk(armor_perk);
}

private function_2b71fd3(var_31e314e8) {
  armor_perk = function_659633d8(var_31e314e8);
  self unsetperk(armor_perk);
}

private function_f14e5ee3() {
  var_7d27f2d6 = self.pers[#"dynamic_loadout"].weapons[0];

  if(isDefined(var_7d27f2d6)) {
    primary = getweapon(var_7d27f2d6.name, var_7d27f2d6.attachments);
    self giveweapon(primary);
    self function_c1932ad3(primary, var_7d27f2d6);
    self switchtoweapon(primary, 1);
    self loadout::function_442539("primary", primary);
    self setspawnweapon(primary);
  } else {
    nullprimary = function_898839b4();
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self loadout::function_442539("primary", nullprimary);
  }

  var_23218f5e = self.pers[#"dynamic_loadout"].weapons[1];

  if(isDefined(var_23218f5e)) {
    secondary = getweapon(var_23218f5e.name, var_23218f5e.attachments);
    self giveweapon(secondary);
    self function_c1932ad3(secondary, var_23218f5e);
    self loadout::function_442539("secondary", secondary);

    if(!isDefined(var_7d27f2d6)) {
      self switchtoweapon(secondary, 1);
      self setspawnweapon(secondary);
    }
  } else {
    nullsecondary = getweapon(#"none");
    self giveweapon(nullsecondary);
    self setweaponammoclip(nullsecondary, 0);
    self loadout::function_442539("secondary", nullsecondary);
  }

  equipmentdata = self.pers[#"dynamic_loadout"].weapons[2];

  if(isDefined(equipmentdata)) {
    equipment = getweapon(equipmentdata.name);
    self giveweapon(equipment);
    self setweaponammoclip(equipment, equipmentdata.ammo);
    slot = self gadgetgetslot(equipment);
    self gadgetpowerset(slot, equipment.gadget_powermax);
  } else {
    var_30b5b5af = getweapon(#"null_offhand_primary");
    self giveweapon(var_30b5b5af);
    self loadout::function_442539("primarygrenade", var_30b5b5af);
  }

  self seteverhadweaponall(1);
}

private function_898839b4() {
  var_81b9af1a = self.pers[#"dynamic_loadout"].talents;

  foreach(item in var_81b9af1a) {
    if(item == #"hash_7932008294f0d876") {
      return getweapon(#"hash_7932008294f0d876");
    }
  }

  return getweapon(#"hash_1773b576c62a506");
}

private function_c1932ad3(weap, data) {
  if(data.ammo > 0) {
    self setweaponammostock(weap, int(data.ammo * weap.clipsize) - weap.clipsize);
  } else {
    self setweaponammostock(weap, int(data.startammo * weap.clipsize) - weap.clipsize);
  }

  if(self getweaponammoclip(weap) <= 0) {
    self setweaponammostock(weap, weap.clipsize);
  }
}

private function_6a829089() {
  healthgadget = getweapon(#"pickup_health_regen");

  if(isDefined(self.var_c7e6d7c7) && self.var_c7e6d7c7) {
    healthgadget = getweapon(#"gadget_medicalinjectiongun");
  }

  self giveweapon(healthgadget);
  self loadout::function_442539("specialgrenade", healthgadget);
}

private function_422164cd() {
  self cleartalents();
  self clearperks();

  foreach(talent in self.pers[#"dynamic_loadout"].talents) {
    if(talent == #"hash_7932008294f0d876") {
      continue;
    }

    self addtalent(talent + level.game_mode_suffix);

    if(talent == #"gear_medicalinjectiongun") {
      self.var_c7e6d7c7 = 1;
    }
  }

  perks = self getloadoutperks(0);

  foreach(perk in perks) {
    self setperk(perk);
  }

  self thread perks::monitorgpsjammer();
}

private function_8d5ede64() {
  if(isDefined(self.pers[#"dynamic_loadout"].scorestreak)) {
    self killstreaks::give(self.pers[#"dynamic_loadout"].scorestreak);
  }
}

function_cea5cbc5() {
  scorestreak = self.pers[#"dynamic_loadout"].scorestreak;

  if(isDefined(scorestreak) && (!self killstreaks::has_killstreak(scorestreak) || isDefined(self.var_a8c5fe4e) && self.var_a8c5fe4e)) {
    self.pers[#"dynamic_loadout"].scorestreak = undefined;
    self function_ff8ef46b(10, "luielement.BountyHunterLoadout.scorestreak", 0);
  }
}