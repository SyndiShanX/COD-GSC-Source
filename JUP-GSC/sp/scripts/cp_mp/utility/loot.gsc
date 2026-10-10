/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\utility\loot.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\cp_mp\weapon;
#namespace loot;

function init() {
  level.lootmaster = [];

  for(row = 0; true; row++) {
    typename = tablelookupbyrow("loot/loot_types.csv", row, 0);

    if(!isDefined(typename) || typename == "") {
      break;
    }

    typevalue = int(tablelookupbyrow("loot/loot_types.csv", row, 1));
    data = spawnStruct();
    data.typename = typename;
    data.typevalue = typevalue;
    level.lootmaster[typename] = data;
  }
}

function function_6fb104d58e745d61(typevalue) {
  foreach(data in level.lootmaster) {
    if(typevalue == data.typevalue) {
      return data.typename;
    }
  }

  return undefined;
}

function function_8662a0aef570ff4b(typename) {
  foreach(data in level.lootmaster) {
    if(typename == data.typename) {
      return data.typevalue;
    }
  }

  return undefined;
}

function function_282cf83c9eeda744(lootid) {
  if(!isDefined(lootid)) {
    return undefined;
  }

  lootinfo = function_3475769c002400f7(lootid);

  if(!isDefined(lootinfo) || !isDefined(lootinfo.category)) {
    return undefined;
  }

  typename = lootinfo.category;

  if(typename == "") {
    return undefined;
  }

  return typename;
}

function function_2f80e9272a2074d(lootid, weaponrootname) {
  uniqueref = function_793e8a72cedb8ef3(lootid);
  bundledata = scripts\cp_mp\weapon::function_a622d54bb517923a(uniqueref, [#"baseref"]);

  if(isDefined(bundledata) && isDefined(bundledata.baseref) && bundledata.baseref != "") {
    if(bundledata.baseref != uniqueref) {
      var_39dd70c4a332b134 = scripts\cp_mp\weapon::function_a622d54bb517923a(bundledata.baseref, [#"lootid"]);
      assertex(isDefined(var_39dd70c4a332b134), "Unable to retrieve base bundle data for: " + bundledata.baseref);

      if(var_39dd70c4a332b134.lootid != 0) {
        lootid = var_39dd70c4a332b134.lootid;
      }
    }
  }

  assert(isarray(level.var_c7008cff883cd615));

  foreach(slot in level.var_c7008cff883cd615) {
    var_e1ffc4455c6c4f8a = function_75b035199842693d(weaponrootname, slot);

    if(isDefined(var_e1ffc4455c6c4f8a)) {
      foreach(attachment in var_e1ffc4455c6c4f8a) {
        id = getscriptbundlefieldvalue(hashcat(%"hash_3c2c9813bb16552f", attachment), #"lootid");

        if(!isDefined(id)) {
          logprint("^3Failed to find attachment data with a valid id for [", attachment, "] despite the weapon [", weaponrootname, "] listing it as a possible attachment.");
          continue;
        }

        if(id == lootid) {
          return attachment;
        }
      }
    }
  }

  return uniqueref;
}

function function_793e8a72cedb8ef3(lootid) {
  if(!isDefined(lootid)) {
    return;
  }

  if(!isDefined(level.var_f41abe634712663c)) {
    level.var_f41abe634712663c = [];
  }

  if(isDefined(level.var_f41abe634712663c[lootid])) {
    return level.var_f41abe634712663c[lootid];
  }

  itemref = undefined;
  lootinfo = function_3475769c002400f7(lootid);

  if(isDefined(lootinfo) && isDefined(lootinfo.itemref)) {
    itemref = lootinfo.itemref;
  }

  if(!isDefined(itemref)) {
    if(getdvarint(@ "hash_6d4a21dadd19744d", 0) == 1 && getDvar(@ "loot_table_name", "mp/loot/br/default/loot_item_defs.csv") == "mp/loot/br/default/loot_item_defs.csv") {
      itemref = "";

      if(isDefined(level.br_pickups.var_b13dc7e63676bbe7[lootid])) {
        itemref = level.br_pickups.var_b13dc7e63676bbe7[lootid];
      }
    } else {
      itemref = tablelookup(level.brloottablename, 5, lootid, 1);
    }
  }

  if(isDefined(itemref) && itemref != "") {
    level.var_f41abe634712663c[lootid] = itemref;
  }

  return itemref;
}

function getlootidfromref(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(level.var_782b4804d4e2d690)) {
    level.var_782b4804d4e2d690 = [];
  }

  if(isDefined(level.var_782b4804d4e2d690[ref])) {
    return level.var_782b4804d4e2d690[ref];
  }

  lootinfo = function_e4f08713dc9c53b3(ref);

  if(!isDefined(lootinfo) || !isDefined(lootinfo.itemid)) {
    return 0;
  }

  lootid = lootinfo.itemid;
  level.var_782b4804d4e2d690[ref] = lootid;
  return lootid;
}

function function_c2c9fb447c203cb2(type) {
  if(!isDefined(type)) {
    return undefined;
  }

  switch (type) {
    case #"hash_27124c6c97ccffa1":
    case #"hash_325cb2e66f67d5b9":
    case #"hash_511d3c24fcedcdb1":
      return "weapon";
    case #"hash_933827ed049cbeb9":
      return "special_weapon";
    case #"hash_339227cb650975db":
    case #"hash_850999d7864fa3b4":
    case #"hash_93c71e7b6c0b81d7":
      return "equipment";
    case #"hash_9b65aa0f76e2e865":
    case #"hash_b60679835e82a584":
    case #"hash_e534fd8ec73eafb4":
      return "super";
    case #"hash_1cac65e1b8bf24a7":
      return "killstreak";
    case #"hash_ab671284a3fc4e3d":
      return "perk";
    case #"hash_4a01666eb6c388c8":
      return "attachment";
    case #"hash_59b8e9d05b31ff9":
    case #"hash_7d516d84d0a82f2":
    case #"hash_d42d44f53610ee5":
    case #"hash_13d1f84d0ae96a5f":
    case #"hash_55425b6c36803a4c":
    case #"hash_5e0a8ff36bce5106":
    case #"hash_6287e3a709aed1ed":
    case #"hash_68f4eeaa46e980a8":
    case #"hash_69146251ab5ca13a":
    case #"hash_7142f43f1e6394cf":
    case #"hash_7b7fff9980d178cf":
    case #"hash_8499464a48c4e157":
    case #"hash_bf5597954aaed3d7":
      return "consumable";
  }

  return undefined;
}

function function_b88cfb4893ceedac(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(level.br_pickups)) {
    return;
  }

  if(!isDefined(level.br_pickups)) {
    return undefined;
  }

  if(isDefined(level.br_pickups.br_weapontoscriptable[ref])) {
    return level.br_pickups.br_weapontoscriptable[ref];
  }

  if(isDefined(level.br_pickups.br_equipnametoscriptable[ref])) {
    return level.br_pickups.br_equipnametoscriptable[ref];
  }

  if(isDefined(level.br_pickups.var_838863c4848d4c26[ref])) {
    return level.br_pickups.var_838863c4848d4c26[ref];
  }
}

function getscriptablefromlootid(lootid) {
  scriptable = function_e0a57e47b2947bc(lootid);

  if(isDefined(scriptable)) {
    return scriptable;
  }

  if(isDefined(level.br_pickups.var_b13dc7e63676bbe7[lootid])) {
    return level.br_pickups.var_b13dc7e63676bbe7[lootid];
  }

  ref = function_793e8a72cedb8ef3(lootid);
  return function_b88cfb4893ceedac(ref);
}

function function_fae5e1d3de32d3f7(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  if(isDefined(level.br_pickups.var_7b2bff2d04ee1017[ref])) {
    return level.br_pickups.var_7b2bff2d04ee1017[ref];
  }

  if(isDefined(level.br_pickups.var_14bd11727c4b6629[ref]) && isDefined(level.br_pickups.br_itemtype[ref])) {
    itemtype = level.br_pickups.br_itemtype[ref];

    if(itemtype == #"health") {
      itemtype = #"consumable";
    }

    return getlootidfromref(level.br_pickups.var_14bd11727c4b6629[ref]);
  }

  if(isDefined(level.br_pickups.br_equipname[ref])) {
    return getlootidfromref(level.br_pickups.br_equipname[ref]);
  }
}

function function_afa71c22d9dcfdc5(lootid) {
  cost = tablelookup("loot/consumable_ids.csv", 0, lootid, 3);
  return cost;
}

function function_4068c937ebaa0ebd(scriptablename) {
  lootid = function_fae5e1d3de32d3f7(scriptablename);

  if(!isDefined(lootid)) {
    return 0;
  }

  return function_c02e0fb782d242f2(lootid);
}

function function_c02e0fb782d242f2(lootid) {
  var_4b67a123f86227ce = tablelookup("loot/consumable_ids.csv", 0, lootid, 12);

  if(!isDefined(var_4b67a123f86227ce)) {
    return true;
  }

  if(var_4b67a123f86227ce == 1) {
    return false;
  }

  return true;
}

function isitemfiltered(var_25978461c6e4f61b) {
  if(!isDefined(var_25978461c6e4f61b)) {
    return false;
  }

  return issubstr(getDvar(@ "loot_table_filter", ""), var_25978461c6e4f61b) || issubstr(getDvar(@ "hash_ac347c5a6346b8ac", ""), var_25978461c6e4f61b);
}

function function_5d47301f7bb7a6ba(lootid) {
  if(!isDefined(lootid)) {
    return false;
  }

  var_25978461c6e4f61b = getscriptablefromlootid(lootid);
  return isitemfiltered(var_25978461c6e4f61b);
}

function function_54b046aa3ba2678a(var_9023cea8f03e72d2) {
  var_3d329ebb0d03d6db = tablelookup("mp/buyStation/buyStationDefs.csv", 1, var_9023cea8f03e72d2, 0);

  if(var_3d329ebb0d03d6db != "") {
    return int(var_3d329ebb0d03d6db);
  }

  return undefined;
}

function function_151b82e1257f4cde(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  switch (ref) {
    case #"hash_aa60ec2aec479ec8":
      return "super_tac_cover";
    case #"hash_c848458cca24d656":
      return "super_trophy";
    case #"hash_de0fbd002a2503b7":
      return "super_recon_drone";
    case #"hash_8bb4a7de3879026d":
      return "super_deadsilence";
    case #"hash_b593201e2eae5dcd":
      return "super_support_box";
    case #"hash_ecd28780631ff043":
      return "super_ammo_drop";
    case #"hash_91076f076ee682f4":
      return "super_armor_drop";
    case #"hash_b3d0752364b0193d":
      return "super_utility_drop";
    case #"hash_4d6bb233bacb2d87":
      return "super_battlerage";
    case #"hash_2ee3956fc66771d2":
      return "super_stimpistol";
    case #"hash_8e058a166a2a6049":
      return "super_deployed_decoy";
    case #"hash_1eeb976ed8edf3e2":
      return "super_tac_camera";
    case #"hash_ac9ba190f352c1f":
      return "super_emp_pulse";
    case #"hash_4cbb2e16d7934fbc":
      return "super_supply_drop";
    case #"hash_9abd51e099d625":
      return "super_fulton";
    case #"hash_59c61d6301a0c38f":
      return "super_vehicle_drop";
    case #"hash_f4e4d96da65cbe0c":
      return "super_sound_veil";
    case #"hash_7c09786dbc292c05":
      return "super_sonar_pulse";
    case #"hash_221cbd05ce8eda95":
      return "super_suppression_rounds";
    case #"hash_1a66514788f13506":
      return "super_reinforcement_flare";
    case #"hash_d83c44d7d3de6d4a":
      return "super_personal_redeploy_drone";
    case #"hash_d7c0526ce6fa6664":
      return "super_oxygen_mask";
  }

  return undefined;
}

function function_2ce015d8f99a66e0(lootid) {
  return function_e025bb823276187(getscriptablefromlootid(lootid));
}

function function_e025bb823276187(scriptablename) {
  if(!isDefined(scriptablename)) {
    return 0;
  }

  if(!isDefined(level.br_pickups.counts) || !isDefined(level.br_pickups.counts[scriptablename])) {
    return 0;
  }

  return level.br_pickups.counts[scriptablename];
}