/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\loot.gsc
******************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\weapon;
#using scripts\engine\utility;
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

  if(!level.gametypebundle.var_3a960ff885ea423) {
    function_ace7a24559a019fb();
  }

  function_36413802e4a9f188();
  utility::registersharedfunc(#"loot", #"hash_e8a1675206a03393", &function_d3e3bcaea591a6a2);
}

function function_36413802e4a9f188() {
  level.var_7dcfd72b3473e97d = [];
  level.var_77778f180e1e6ad3 = [];
  var_aa1e7736aee2628f = getDvar(@ "lui_banned_loot_items");

  if(isDefined(var_aa1e7736aee2628f)) {
    itemids = strtok(var_aa1e7736aee2628f, "|");

    foreach(itemid in itemids) {
      level.var_7dcfd72b3473e97d[level.var_7dcfd72b3473e97d.size] = int(itemid);
    }
  }

  var_aa1e7736aee2628f = getDvar(@ "hash_18d43c13f449a92b");

  if(isDefined(var_aa1e7736aee2628f)) {
    itemnames = strtok(var_aa1e7736aee2628f, "|");

    foreach(itemname in itemnames) {
      level.var_77778f180e1e6ad3[level.var_77778f180e1e6ad3.size] = itemname;
    }
  }
}

function function_ace7a24559a019fb() {
  if(isDefined(level.var_16e1c38355341288)) {
    return;
  }

  level.var_16e1c38355341288 = [];
  level.var_e43af16903bda945 = [];
  projectscriptbundle = level.projectbundle;
  var_5f783a376dc26921 = getscriptbundle(hashcat(%"hash_6da2812724ad07ed", projectscriptbundle.consumablelist));

  if(!isDefined(var_5f783a376dc26921)) {
    println("<dev string:x24>" + projectscriptbundle.consumablelist);
  }

  consumablelist = var_5f783a376dc26921.consumablelist;

  for(i = 0; i < consumablelist.size; i++) {
    if(!isDefined(consumablelist[i].bundle)) {
      continue;
    }

    consumablebundle = getscriptbundlefieldvalues(hashcat(%"hash_2d4d7620ade90519", consumablelist[i].bundle), [#"lootid"]);

    if(!isDefined(consumablebundle)) {
      println("<dev string:x54>" + projectscriptbundle.consumablelist + "<dev string:x8d>" + consumablelist[i].bundle);
      continue;
    }

    consumableref = consumablelist[i].bundle;
    level.var_16e1c38355341288[consumableref] = consumablebundle;
    level.var_e43af16903bda945[level.var_e43af16903bda945.size] = consumableref;
  }
}

function function_2fa0a9205d311c5d(consumableref) {
  function_ace7a24559a019fb();
  var_7237854e3be197ca = level.var_16e1c38355341288[consumableref];

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  println("<dev string:x93>" + consumableref);
  return undefined;
}

function function_5c29f3f1f5ff18bd(lootid) {
  function_ace7a24559a019fb();

  foreach(consumable in level.var_16e1c38355341288) {
    if(consumable.lootid == lootid) {
      return consumable;
    }
  }

  println("<dev string:xbe>" + lootid);
  return undefined;
}

function function_f9c3c4cb22370a36(typevalue) {
  foreach(data in level.lootmaster) {
    if(typevalue == data.typevalue) {
      return data.typename;
    }
  }

  return undefined;
}

function function_a7da1aae18be3d0c(typename) {
  foreach(data in level.lootmaster) {
    if(typename == data.typename) {
      return data.typevalue;
    }
  }

  return undefined;
}

function function_52cf8374c44a4ff5(lootid) {
  if(!isDefined(lootid)) {
    return undefined;
  }

  lootinfo = getlootiteminfofromid(lootid);

  if(!(isDefined(lootinfo) && isDefined(lootinfo.category))) {
    return undefined;
  }

  typename = lootinfo.category;

  if(typename == "") {
    return undefined;
  }

  return typename;
}

function function_5fea6a6dee392b8(lootid, weaponrootname) {
  uniqueref = function_f54ecb89dfab8e8c(lootid);
  bundledata = weapon::function_e0801e95ac4c4925(uniqueref, [#"baseref", #"category"]);
  conversionkitname = undefined;

  if(isDefined(bundledata) && isDefined(bundledata.category) && bundledata.category == "CONVERSIONKIT") {
    conversionkitname = uniqueref;
  }

  if(isDefined(bundledata) && isDefined(bundledata.baseref) && bundledata.baseref != "") {
    if(bundledata.baseref != uniqueref) {
      var_4ac39864cfcaa467 = weapon::function_e0801e95ac4c4925(bundledata.baseref, [#"lootid", #"category"]);
      assert(isDefined(var_4ac39864cfcaa467), "<dev string:xf6>" + bundledata.baseref);

      if(isDefined(var_4ac39864cfcaa467) && var_4ac39864cfcaa467.lootid != 0) {
        lootid = var_4ac39864cfcaa467.lootid;

        if(var_4ac39864cfcaa467.category == "CONVERSIONKIT") {
          conversionkitname = bundledata.baseref;
        } else {
          conversionkitname = undefined;
        }
      }
    }
  }

  foreach(slot in level.attachmentslotarray) {
    if(!isDefined(weaponrootname)) {
      break;
    }

    var_8672e9cd534b1c9f = function_2e5ecdd8ac47f308(weaponrootname, slot, 1);

    if(isDefined(var_8672e9cd534b1c9f)) {
      foreach(attachment in var_8672e9cd534b1c9f) {
        id = getscriptbundlefieldvalue(hashcat(%"hash_3c2c9813bb16552f", attachment), #"lootid");

        if(!isDefined(id)) {
          logprint("^3Failed to find attachment data with a valid id for [" + attachment + "] despite the weapon [" + weaponrootname + "] listing it as a possible attachment.");
          continue;
        }

        if(id != lootid) {
          continue;
        }

        if(isDefined(conversionkitname) && conversionkitname != attachment) {
          continue;
        }

        return attachment;
      }
    }
  }

  return uniqueref;
}

function function_f54ecb89dfab8e8c(lootid) {
  var_7237854e3be197ca = level.var_b2f40628ef3d5319[lootid];

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  if(!isDefined(lootid)) {
    return undefined;
  }

  if(!isDefined(level.var_b2f40628ef3d5319)) {
    level.var_b2f40628ef3d5319 = [];
  }

  lootinfo = getlootiteminfofromid(lootid);
  itemref = lootinfo.itemref;

  if(isDefined(itemref) && itemref != "") {
    level.var_b2f40628ef3d5319[lootid] = itemref;
  }

  return itemref;
}

function getlootidfromref(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(level.var_c2ec1ee1716fa425)) {
    level.var_c2ec1ee1716fa425 = [];
  }

  if(isDefined(level.var_c2ec1ee1716fa425[ref])) {
    return level.var_c2ec1ee1716fa425[ref];
  }

  lootinfo = getLootItemInfoFromRef(ref);

  if(!(isDefined(lootinfo) && isDefined(lootinfo.itemid))) {
    return 0;
  }

  lootid = lootinfo.itemid;
  level.var_c2ec1ee1716fa425[ref] = lootid;
  return lootid;
}

function function_25cbc3f93cc261bf(type) {
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

function function_3bbf7813accff0d9(ref) {
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

  if(isDefined(level.br_pickups.var_5515c706eaccd3[ref])) {
    return level.br_pickups.var_5515c706eaccd3[ref];
  }
}

function getScriptableFromLootID(lootid) {
  scriptable = namespace_9d8e359c3b1041e5::getscriptablefromlootidsharedfunc(lootid);

  if(isDefined(scriptable)) {
    return scriptable;
  }

  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.var_cf921d0c5390e142[lootid])) {
    return level.br_pickups.var_cf921d0c5390e142[lootid];
  }

  ref = function_f54ecb89dfab8e8c(lootid);
  return function_3bbf7813accff0d9(ref);
}

function function_d3e3bcaea591a6a2(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  if(utility::issharedfuncdefined(#"game", #"getlootidfromref")) {
    return level[[utility::getsharedfunc(#"game", #"getlootidfromref")]](ref);
  } else if(isDefined(level.br_pickups.var_2e379e316c36bf4a[ref])) {
    return level.br_pickups.var_2e379e316c36bf4a[ref];
  }

  if(isDefined(level.br_pickups.var_bc722094bd45cfd2[ref]) && isDefined(level.br_pickups.br_itemtype[ref])) {
    itemtype = level.br_pickups.br_itemtype[ref];

    if(itemtype == #"health") {
      itemtype = #"consumable";
    }

    return getlootidfromref(level.br_pickups.var_bc722094bd45cfd2[ref]);
  }

  if(isDefined(level.br_pickups.br_equipname[ref])) {
    return getlootidfromref(level.br_pickups.br_equipname[ref]);
  }
}

function function_19b5dfbb93a81e04(lootid) {
  cost = function_5c29f3f1f5ff18bd(lootid).cost;
  return cost;
}

function function_9aa227aad7652d16(scriptablename) {
  lootid = function_d3e3bcaea591a6a2(scriptablename);

  if(!isDefined(lootid)) {
    return 0;
  }

  return function_50aa4aee29aee621(lootid);
}

function function_50aa4aee29aee621(lootid) {
  unequippable = function_5c29f3f1f5ff18bd(lootid).unequippable;

  if(!isDefined(unequippable)) {
    return true;
  }

  if(unequippable == 1) {
    return false;
  }

  return true;
}

function function_c0c6b52344a55671(ref) {
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
    case #"hash_5bb446fe7b2c92da":
      return "super_haunted_drop";
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
    case #"hash_26da5d1481b16057":
      return "super_squadrage";
    case #"hash_4b4a6458f00d9319":
      return "super_hb_sensor";
    case #"hash_d3dba172bb61068c":
      return "super_redeploy_drone_beacon";
    case #"hash_b4bddb9307cef53c":
      return "super_contract_skipper";
    case #"hash_6fd1fe9f5304719a":
      return "super_mutation_ninja_vanish";
  }

  return undefined;
}

function function_f2c2d1fd3285a91d(lootid) {
  return function_e147eb0fef559d72(getScriptableFromLootID(lootid));
}

function function_e147eb0fef559d72(scriptablename) {
  if(!isDefined(scriptablename)) {
    return 0;
  }

  if(!(isDefined(level.br_pickups.counts) && isDefined(level.br_pickups.counts[scriptablename]))) {
    return 0;
  }

  return level.br_pickups.counts[scriptablename];
}

function function_7ece35b2b5205ad(lootid) {
  if(!isDefined(level.var_7dcfd72b3473e97d)) {
    function_36413802e4a9f188();
  }

  return arraycontains(level.var_7dcfd72b3473e97d, lootid);
}

function function_72263d7f509cd8cd(ref) {
  if(!isDefined(level.var_7dcfd72b3473e97d)) {
    function_36413802e4a9f188();
  }

  if(arraycontains(level.var_77778f180e1e6ad3, ref)) {
    return 1;
  }

  return arraycontains(level.var_7dcfd72b3473e97d, getlootidfromref(ref));
}