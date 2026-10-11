/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_55e418c5cc946593.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_util;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace namespace_126f4192a2d090c4;

function function_9fd92851e68a5662() {
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  function_b950d479e0b6a443();
  level.var_e6a9715874a7001b = getdvarint(@ "hash_d676c30878594b5b", 1);
  level.var_b6883bde144a226e = &function_b6883bde144a226e;
}

function function_ca7e33035f7f102f() {
  if(!function_56f3d322e17b9974()) {
    return;
  }

  level.var_767653d4d33e973 = [];

  for(i = 0; i <= 4; i++) {
    if(i >= 1) {
      level.var_767653d4d33e973[i] = getdvarint(hashcat(@ "hash_ab797bdab019e7f3", i, "_unlock_points"), i * 500);
      continue;
    }

    level.var_767653d4d33e973[i] = 0;
  }
}

function function_c0d385a09d173a36() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return (getdvarint(@ "br_perk_package_enabled", 1) > 0);
  }

  return 0;
}

function function_2980f22fb01f43e6() {
  return function_c0d385a09d173a36() && getdvarint(@ "br_perk_package_dropping_enabled", 1);
}

function function_53b52a367576cbe3() {
  function_19868614946c4df4();

  if(function_56f3d322e17b9974() && !isDefined(self.var_eaaa77e5f0f34045)) {
    self.var_eaaa77e5f0f34045 = [];

    for(i = 1; i <= 4; i++) {
      self.var_eaaa77e5f0f34045["slot" + i] = 0;
    }
  }
}

function function_b6883bde144a226e(var_b41cfb612983fe36) {
  if(!level.var_e6a9715874a7001b || !isDefined(level.perkbundles)) {
    return true;
  }

  if(!isDefined(level.perkbundles[var_b41cfb612983fe36])) {
    return false;
  }

  return !istrue(level.perkbundles[var_b41cfb612983fe36].brdisabled);
}

function private function_b950d479e0b6a443() {
  if(!isDefined(level.var_952400f520b7f68d)) {
    level.var_952400f520b7f68d = [];
  }

  bundlename = getDvar(@ "hash_23b1b8f92f4a2d96", "perkpackagelist_wz");
  scriptbundle = getscriptbundle(hashcat(%"perkpackagelist:", bundlename));

  if(isDefined(scriptbundle)) {
    foreach(packagestruct in scriptbundle.packages) {
      packageref = packagestruct.package;

      if(isDefined(packageref)) {
        packagebundle = getscriptbundle(hashcat(%"perkpackage:", packageref));

        if(isDefined(packagebundle)) {
          if(isvalidperk(packagebundle.perks.baseperk1)) {
            level.var_952400f520b7f68d[packageref]["perk" + 1] = packagebundle.perks.baseperk1;
          }

          if(isvalidperk(packagebundle.perks.baseperk2)) {
            level.var_952400f520b7f68d[packageref]["perk" + 2] = packagebundle.perks.baseperk2;
          }

          if(isvalidperk(packagebundle.perks.bonusperk)) {
            level.var_952400f520b7f68d[packageref]["perk" + 3] = packagebundle.perks.bonusperk;
          }

          if(isvalidperk(packagebundle.perks.ultimateperk)) {
            level.var_952400f520b7f68d[packageref]["perk" + 4] = packagebundle.perks.ultimateperk;
          }
        }
      }
    }
  }
}

function function_f9311648de44de28() {
  return function_7513b765bcfd9658(function_2f886a8000750771());
}

function function_7513b765bcfd9658(perks) {
  if(isDefined(perks) && perks.size > 0) {
    foreach(perk in perks) {
      if(isvalidperk(perk)) {
        return true;
      }
    }
  }

  return false;
}

function private function_2f886a8000750771() {
  if(isDefined(self.var_28c944f222f4814) && isDefined(self.var_28c944f222f4814.perks) && self.var_28c944f222f4814.perks.size > 0) {
    return self.var_28c944f222f4814.perks;
  }

  return getloadoutperks();
}

function private function_cdddff2c50ec5768(var_ed28bcc7797e2f2a) {
  if(isDefined(var_ed28bcc7797e2f2a)) {
    arr = [];

    foreach(item in var_ed28bcc7797e2f2a) {
      arr[arr.size] = item;
    }

    return arr;
  }
}

function getloadoutperks() {
  if(!isDefined(self.pers)) {
    return;
  }

  perks = [];

  if(isDefined(self.loadoutperks)) {
    foreach(perk in self.loadoutperks) {
      slot = scripts\mp\perks\perks::getperkslot(perk);

      if(isDefined(slot)) {
        perks[perks.size] = perk;
      }
    }
  }

  return perks;
}

function private function_3af287ce55291889(backpackindex) {
  lootname = undefined;
  [lootid, quantity] = namespace_aead94004cf4c147::function_6738846da50730f1(backpackindex);

  if(isDefined(lootid)) {
    lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

    if(!isDefined(lootname)) {
      lootname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    }

    if(function_43044da0ed44d79f(lootname)) {
      perkstruct = function_3634d41e203bc04e(backpackindex);

      if(isDefined(perkstruct) && isDefined(perkstruct.perks)) {
        return [lootname, perkstruct.perks];
      }
    } else {
      perks = function_bd6e1a518e1998db(lootname);

      if(isDefined(perks) && perks.size > 0) {
        return [lootname, perks];
      }
    }
  }

  return undefined;
}

function private function_b28e5ac58e164cac(scriptent) {
  entname = scriptent.scriptablename;
  perkarr = undefined;

  if(isDefined(scriptent.perks)) {
    perkarr = scriptent.perks;
  } else if(isDefined(scriptent.instance) && isDefined(scriptent.instance.perks)) {
    perkarr = scriptent.instance.perks;
  } else if(isDefined(entname)) {
    perks = function_bd6e1a518e1998db(entname);

    if(isDefined(perks) && perks.size > 0) {
      perkarr = perks;
    }
  }

  return [entname, perkarr];
}

function private function_c32b469bb2b68ece() {
  return [self.var_28c944f222f4814.var_183ec729c8876d57, self.var_28c944f222f4814.perks];
}

function private isvalidperk(perk) {
  return isDefined(perk) && perk != "" && perk != "none" && perk != "specialty_null";
}

function function_bd6e1a518e1998db(lootref) {
  if(isDefined(lootref) && isDefined(level.br_pickups) && isDefined(level.br_pickups.var_14bd11727c4b6629) && array_contains_key(level.br_pickups.var_14bd11727c4b6629, lootref)) {
    externalref = level.br_pickups.var_14bd11727c4b6629[lootref];

    if(isDefined(externalref) && isDefined(level.var_952400f520b7f68d) && array_contains_key(level.var_952400f520b7f68d, externalref) && isDefined(level.var_952400f520b7f68d[externalref])) {
      perks = [];

      for(i = 1; i <= 4; i++) {
        key = "perk" + i;

        if(array_contains_key(level.var_952400f520b7f68d[externalref], key)) {
          perks[key] = level.var_952400f520b7f68d[externalref][key];
        }
      }

      return perks;
    }
  }
}

function private giveperk(perk) {
  var_133b955e401a062f = isvalidperk(perk) && !scripts\mp\utility\perk::_hasperk(perk);

  if(var_133b955e401a062f && perkisrestricted(perk)) {
    return;
  }

  if(var_133b955e401a062f) {
    scripts\mp\class::loadout_giveperk(perk);
  }

  slot = scripts\mp\perks\perks::getperkslot(perk);

  if(isDefined(slot)) {
    if(isDefined(self.pers)) {
      if(!array_contains(self.pers["loadoutPerks"], perk)) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = perk;
      }

      if(!array_contains(self.pers["loadoutStandardPerks"], perk)) {
        self.pers["loadoutStandardPerks"][self.pers["loadoutStandardPerks"].size] = perk;
      }
    }
  }
}

function private removeperk(perk) {
  if(isvalidperk(perk) && scripts\mp\utility\perk::_hasperk(perk)) {
    if(isDefined(self.loadoutperks) && array_contains(self.loadoutperks, perk)) {
      scripts\mp\class::loadout_removeperk(perk);
    } else {
      scripts\mp\utility\perk::removeperk(perk);
    }

    if(!_hasperk(perk)) {
      if(isDefined(self.pers)) {
        foreach(perskey in ["loadoutPerks", "loadoutStandardPerks"]) {
          if(array_contains_key(self.pers, perskey) && array_contains(self.pers[perskey], perk)) {
            self.pers[perskey] = array_remove(self.pers[perskey], perk);
          }
        }
      }
    }
  }
}

function function_fb59c1d91c97a058(player) {
  return function_98f34de164fb4757(player function_2f886a8000750771());
}

function function_98f34de164fb4757(perks) {
  if(!function_7513b765bcfd9658(perks)) {
    return;
  }

  foreach(packref, perkpack in level.var_952400f520b7f68d) {
    matchingpack = 1;

    if(isDefined(perkpack) && perkpack.size > 0) {
      for(i = 0; i + 1 <= 4; i++) {
        packperk = "none";
        currentperk = "none";
        key = "perk" + i + 1;

        if(array_contains_key(perkpack, key) && isvalidperk(perkpack[key])) {
          packperk = perkpack[key];
        } else if(i < perkpack.size && isvalidperk(perkpack[i])) {
          packperk = perkpack[i];
        }

        if(array_contains_key(perks, key) && isvalidperk(perks[key])) {
          currentperk = perks[key];
        } else if(i < perks.size && isvalidperk(perks[i])) {
          currentperk = perks[i];
        }

        if(packperk != currentperk) {
          matchingpack = 0;
          break;
        }
      }
    } else {
      matchingpack = 0;
    }

    if(istrue(matchingpack)) {
      scriptable = function_cf81579b65f85dcf(packref);

      if(isDefined(scriptable)) {
        return scriptable;
      }
    }
  }

  return "brloot_perkpack_custom";
}

function function_40d138c40bd87f37(perks, isspecialistbonus) {
  if(!isDefined(self.var_28c944f222f4814)) {
    self.var_28c944f222f4814 = spawnStruct();
  }

  if(!isDefined(self.var_28c944f222f4814.perks)) {
    self.var_28c944f222f4814.perks = [];
  } else {
    function_f7d6c69e277fb3d4();
  }

  if(isDefined(perks) && perks.size > 0) {
    var_a746cf0b1aac05a1 = function_98f34de164fb4757(perks);
    self.var_28c944f222f4814.var_183ec729c8876d57 = var_a746cf0b1aac05a1;

    for(i = 0; i + 1 <= 4; i++) {
      key = "perk" + i + 1;

      if(array_contains_key(perks, key) && isvalidperk(perks[key])) {
        self.var_28c944f222f4814.perks[key] = perks[key];
        continue;
      }

      if(i < perks.size && isvalidperk(perks[i])) {
        self.var_28c944f222f4814.perks[key] = perks[i];
      }
    }

    function_bae19a088f61b99a(isspecialistbonus);
    function_1296419d9c62a9a8();

    function_e95ed23f86785c82();

    return;
  }

  function_19868614946c4df4();
}

function function_19868614946c4df4() {
  function_f7d6c69e277fb3d4();

  if(!isDefined(self.var_28c944f222f4814)) {
    self.var_28c944f222f4814 = spawnStruct();
  }

  if(!isDefined(self.var_28c944f222f4814.perks)) {
    self.var_28c944f222f4814.perks = [];
  }

  self.var_28c944f222f4814.var_183ec729c8876d57 = undefined;

  for(i = 1; i <= 4; i++) {
    self.var_28c944f222f4814.perks["perk" + i] = undefined;
  }

  function_1296419d9c62a9a8();

  function_e95ed23f86785c82();
}

function function_1296419d9c62a9a8() {
  perksarray = function_cdddff2c50ec5768(function_2f886a8000750771());
  scripts\mp\perks\perks::function_7c8cc44b58093ce4(perksarray);
  scripts\mp\perks\perks::setomnvarsforperklist("ui_spawn_perk_", perksarray, []);
}

function private function_bae19a088f61b99a(isspecialistbonus) {
  if(istrue(isspecialistbonus)) {
    scripts\mp\perks\perks::addspecialistbonus();
    return;
  }

  if(!isDefined(self.var_28c944f222f4814) || !isDefined(self.var_28c944f222f4814.perks)) {
    return;
  }

  for(i = 1; i <= 4; i++) {
    if(istrue(function_ee52068fbb9b0dec(i)) && array_contains_key(self.var_28c944f222f4814.perks, "perk" + i)) {
      perk = self.var_28c944f222f4814.perks["perk" + i];

      if(isvalidperk(perk) && !scripts\mp\utility\perk::_hasperk(perk)) {
        giveperk(perk);
      }
    }
  }
}

function private function_f7d6c69e277fb3d4() {
  if(scripts\mp\utility\perk::_hasperk("specialty_specialist_bonus")) {
    scripts\mp\perks\perks::removespecialistbonus();
  }

  if(!isDefined(self.var_28c944f222f4814) || !isDefined(self.var_28c944f222f4814.perks)) {
    return;
  }

  foreach(perk in self.var_28c944f222f4814.perks) {
    removeperk(perk);
  }

  self.var_28c944f222f4814.perks = [];
}

function function_cf81579b65f85dcf(ref) {
  if(isDefined(level.br_pickups.var_838863c4848d4c26) && array_contains_key(level.br_pickups.var_838863c4848d4c26, ref)) {
    return level.br_pickups.var_838863c4848d4c26[ref];
  }
}

function function_bdd930eee0042052() {
  return getdvarint(@ "br_perk_package_inventory_items_enabled", 1);
}

function function_c3023358dc648bf1(scriptent, var_a24f1824f93081a8, bautouse, backpackindex, backpackequip) {
  lootname = undefined;
  perks = undefined;

  if(isDefined(backpackindex)) {
    if(istrue(bautouse) && (!isDefined(backpackequip) || backpackequip == 0)) {
      [lootname, perks] = function_b28e5ac58e164cac(scriptent);
    } else {
      [lootname, perks] = function_3af287ce55291889(backpackindex);
    }
  } else if(isDefined(scriptent)) {
    [lootname, perks] = function_b28e5ac58e164cac(scriptent);
  }

  if(isDefined(scriptent)) {
    if(var_a24f1824f93081a8) {
      var_1b4771b4ba78454a = undefined;

      if(isDefined(scriptent.origin)) {
        var_1b4771b4ba78454a = scriptent.origin;
      } else if(isDefined(scriptent.instance) && isDefined(scriptent.instance.origin)) {
        var_1b4771b4ba78454a = scriptent.instance.origin;
      }

      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      function_3af23b0bfaf91dbd(dropstruct, undefined, undefined, undefined, var_1b4771b4ba78454a);
    } else if(isDefined(self.var_28c944f222f4814.var_183ec729c8876d57)) {
      if(function_43044da0ed44d79f(self.var_28c944f222f4814.var_183ec729c8876d57)) {
        function_222999aad19f5b52(backpackindex, function_2f886a8000750771());
      }
    }
  }

  isspecialistbonus = istrue(lootname == "brloot_perkpack_specialist_jup");
  function_40d138c40bd87f37(perks, isspecialistbonus);
  return true;
}

function function_3af23b0bfaf91dbd(dropstruct, origin, angles, backpackindex, var_1f6a2a2ac4c47af2) {
  assertex(isDefined(self), "<dev string:x1c>");
  scriptablename = undefined;
  item = undefined;

  if(function_2980f22fb01f43e6()) {
    if(!isDefined(backpackindex)) {
      scriptablename = function_fb59c1d91c97a058(self);
    } else {
      lootid = namespace_aead94004cf4c147::getlootidatbackpackindex(backpackindex);
      scriptablename = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    }

    if(isDefined(scriptablename)) {
      if(!isDefined(origin)) {
        origin = self.origin;
      }

      if(!isDefined(angles)) {
        angles = self.angles;
      }

      dropinfo = getitemdroporiginandangles(dropstruct, origin, angles, self, undefined, undefined, undefined, undefined, var_1f6a2a2ac4c47af2);
      perkset = undefined;

      if(function_43044da0ed44d79f(scriptablename)) {
        if(isDefined(backpackindex)) {
          perkdata = function_3634d41e203bc04e(backpackindex);

          if(isDefined(perkdata)) {
            perkset = perkdata.perks;
          }

          function_e8fd3389a3f6433a(backpackindex);
        } else if(isDefined(self.var_28c944f222f4814.perks) && self.var_28c944f222f4814.perks.size > 0) {
          perkset = self.var_28c944f222f4814.perks;
        } else {
          perkset = getloadoutperks();
        }

        dropinfo function_4f3873e207497c27(perkset);
      }

      item = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, 1, 1, undefined, 0);

      if(isDefined(item) && isDefined(perkset)) {
        item.perks = arraycopy(perkset);
      }
    }
  }

  if(!isDefined(backpackindex)) {
    function_19868614946c4df4();
  }

  return item;
}

function function_4f3873e207497c27(perkset) {
  self.customperkpayload = [#"customperkpackage"];

  if(isDefined(perkset)) {
    foreach(perk in perkset) {
      self.customperkpayload[self.customperkpayload.size] = scripts\cp_mp\utility\loot::getlootidfromref(perk);
    }
  }
}

function onplayerconnect() {
  function_53b52a367576cbe3();
  thread function_2fbbdfa540bdfb59();

  if(getdvarint(@ "hash_157ce918a8602734", 0) == 1) {
    thread function_d6a5c9019b66d5d3();
  }
}

function onplayerdisconnect(player) {
  if(!isbot(player)) {
    player function_6b534b98c34f9610();
  }
}

function onplayerkilled(attacker, victim) {
  if(isbot(victim)) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  victim function_19868614946c4df4();
}

function onplayerscore() {
  if(!function_56f3d322e17b9974()) {
    return;
  }

  function_f2dbab6f947771f2();

  function_e95ed23f86785c82();
}

function function_56f3d322e17b9974() {
  return getdvarint(@ "hash_b2a4fa1894b756bf", 0);
}

function function_ee52068fbb9b0dec(index) {
  if(!function_56f3d322e17b9974()) {
    return true;
  }

  if(!isDefined(self.pers["score"]) || index < 0 || index >= level.var_767653d4d33e973.size) {
    return false;
  }

  return self.pers["score"] >= level.var_767653d4d33e973[index];
}

function function_f2dbab6f947771f2() {
  if(!isPlayer(self)) {
    return;
  }

  if(!function_c0d385a09d173a36() || !function_56f3d322e17b9974()) {
    return;
  }

  if(!isDefined(self.pers["score"])) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  [lootref, perks] = function_c32b469bb2b68ece();

  for(i = 1; i <= 4; i++) {
    if(!self.var_eaaa77e5f0f34045["slot" + i] && function_ee52068fbb9b0dec(i)) {
      self.var_eaaa77e5f0f34045["slot" + i] = 1;

      if(isDefined(perks) && array_contains_key(perks, "perk" + i)) {
        perk = perks["perk" + i];

        if(isDefined(perk) && perk != "" && !scripts\mp\utility\perk::_hasperk(perk)) {
          giveperk(perk);

          function_e95ed23f86785c82();
        }
      }
    }
  }
}

function function_31ea444c3cecf0fb() {
  self.var_28c944f222f4814 = undefined;
}

function function_54410113b73d012() {
  self.var_eaaa77e5f0f34045 = undefined;
}

function function_be64b439107f4392() {
  if(!isDefined(self.var_a1adcd8ba70c9723)) {
    return;
  }

  if(self.var_a1adcd8ba70c9723.size > 0) {
    foreach(elem in self.var_a1adcd8ba70c9723) {
      if(isDefined(elem.parent)) {
        elem.parent removechild(elem);
      }
    }
  }

  self.var_a1adcd8ba70c9723 = undefined;
  self.var_9dc07720609cc75b = undefined;
}

function function_6b534b98c34f9610() {
  function_31ea444c3cecf0fb();
  function_54410113b73d012();
  function_4b84c1e093769ddf();
  function_be64b439107f4392();
}

function function_43044da0ed44d79f(ref) {
  if(!isDefined(ref)) {
    return false;
  }

  return ref == "brloot_perkpack_custom";
}

function function_8a2768bc7f7c63ec(lootid) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  return function_43044da0ed44d79f(scriptablename);
}

function function_36de08ea672b354c(lootref) {
  if(function_43044da0ed44d79f(lootref)) {
    return true;
  }

  if(isDefined(lootref) && isDefined(level.br_pickups) && isDefined(level.br_pickups.var_14bd11727c4b6629) && array_contains_key(level.br_pickups.var_14bd11727c4b6629, lootref)) {
    externalref = level.br_pickups.var_14bd11727c4b6629[lootref];
    return (isDefined(externalref) && isDefined(level.var_952400f520b7f68d) && array_contains_key(level.var_952400f520b7f68d, externalref) && isDefined(level.var_952400f520b7f68d[externalref]));
  }

  return false;
}

function function_f647113719f5139b(lootid) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  return function_36de08ea672b354c(scriptablename);
}

function function_2fbbdfa540bdfb59() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("giveLoadout");

    if(!istrue(level.br_prematchffa) || scripts\mp\flags::gameflagexists("prematch_done") && scripts\mp\flags::gameflag("prematch_done")) {
      if(!perks::_hasperk("specialty_specialist_bonus")) {
        if(scripts\mp\utility\player::isreallyalive(self) && function_f9311648de44de28()) {
          perks = getloadoutperks();
          function_40d138c40bd87f37(perks);
        } else {
          function_19868614946c4df4();
        }
      }

      thread function_e95ed23f86785c82();
    }

    waitframe();
  }
}

function function_bbb44bd3b8347efc(backpackindex, itement) {
  perkdata = function_3634d41e203bc04e(backpackindex);
  itement.perks = perkdata.perks;
  function_e8fd3389a3f6433a(backpackindex);
}

function function_1ca82d98d7519e1f(backpackindex, itement) {
  if(!isDefined(itement.perks)) {
    return;
  }

  function_222999aad19f5b52(backpackindex, itement.perks);
}

function function_446a16d58f290ca6(var_4598840b8e42c901, var_db86a856ddba5113) {
  if(!isDefined(var_4598840b8e42c901.scriptablename) || var_4598840b8e42c901.scriptablename != "brloot_perkpack_custom") {
    return;
  }

  if(!isDefined(var_db86a856ddba5113) || var_db86a856ddba5113.size <= 0) {
    [lootref, perks] = function_c32b469bb2b68ece();

    if(isDefined(perks) && perks.size > 0) {
      var_4598840b8e42c901.perks = perks;
    } else {
      var_4598840b8e42c901.perks = getloadoutperks();
    }

    return;
  }

  var_4598840b8e42c901.perks = var_db86a856ddba5113;
}

function function_3634d41e203bc04e(backpackindex) {
  if(!isDefined(self.var_b9d1aae41a5e8d70) || !isDefined(backpackindex)) {
    return undefined;
  }

  for(i = 0; i < self.var_b9d1aae41a5e8d70.size; i++) {
    if(self.var_b9d1aae41a5e8d70[i].index == backpackindex) {
      return self.var_b9d1aae41a5e8d70[i];
    }
  }

  return undefined;
}

function function_222999aad19f5b52(index, perks) {
  if(isDefined(function_3634d41e203bc04e(index))) {
    function_e8fd3389a3f6433a(index);
  }

  if(!isDefined(self.var_b9d1aae41a5e8d70)) {
    self.var_b9d1aae41a5e8d70 = [];
  }

  perklist = [];
  perkarr = perks;

  if((!isDefined(perkarr) || perkarr.size <= 0) && function_f9311648de44de28()) {
    perkarr = getloadoutperks();
  }

  if(isDefined(perkarr) && perkarr.size > 0) {
    for(i = 0; i + 1 <= 4; i++) {
      key = "perk" + i + 1;

      if(array_contains_key(perkarr, key)) {
        perklist[key] = perkarr[key];
        continue;
      }

      if(i < perkarr.size) {
        perklist[key] = perkarr[i];
      }
    }
  }

  if(perklist.size > 0) {
    arrindex = self.var_b9d1aae41a5e8d70.size;
    self.var_b9d1aae41a5e8d70[arrindex] = spawnStruct();
    self.var_b9d1aae41a5e8d70[arrindex].index = index;
    self.var_b9d1aae41a5e8d70[arrindex].perks = perklist;
  }
}

function function_e8fd3389a3f6433a(backpackindex) {
  if(!isDefined(self.var_b9d1aae41a5e8d70) || !isDefined(backpackindex)) {
    return;
  }

  removeitems = [];

  for(i = 0; i < self.var_b9d1aae41a5e8d70.size; i++) {
    if(self.var_b9d1aae41a5e8d70[i].index == backpackindex) {
      removeitems[removeitems.size] = self.var_b9d1aae41a5e8d70[i];
    }
  }

  if(removeitems.size > 0) {
    foreach(item in removeitems) {
      self.var_b9d1aae41a5e8d70 = array_remove(self.var_b9d1aae41a5e8d70, item);
    }
  }
}

function function_4b84c1e093769ddf() {
  if(!isDefined(self.var_b9d1aae41a5e8d70)) {
    return;
  }

  self.var_b9d1aae41a5e8d70 = undefined;
}

function function_d6a5c9019b66d5d3() {
  level endon("<dev string:x45>");
  self endon("<dev string:x53>");

  if(isbot(self) || getdvarint(@ "hash_157ce918a8602734", 0) != 1) {
    return;
  }

  xoffset = 5;
  yoffset = -80;
  yoffsetincrement = 10;
  var_75599bf3d6abf81f = createfontstring("<dev string:x61>", 1);
  var_75599bf3d6abf81f setpoint("<dev string:x6c>", "<dev string:x6c>", xoffset, yoffset);
  self.var_a1adcd8ba70c9723["<dev string:x74>"] = var_75599bf3d6abf81f;

  for(i = 1; i <= 4; i++) {
    var_d523d0a459b67453 = createfontstring("<dev string:x61>", 1);
    var_d523d0a459b67453 setpoint("<dev string:x6c>", "<dev string:x6c>", xoffset, yoffset + yoffsetincrement * (i - 1 + 1));
    self.var_a1adcd8ba70c9723["<dev string:x84>" + i] = var_d523d0a459b67453;
  }

  self.var_9dc07720609cc75b = 1;
  function_e95ed23f86785c82();
}

function function_e95ed23f86785c82() {
  if(!isPlayer(self) || isbot(self)) {
    return;
  }

  if(!function_c0d385a09d173a36() || getdvarint(@ "hash_157ce918a8602734", 0) != 1) {
    return;
  }

  if(!isDefined(self.pers["<dev string:x8c>"])) {
    return;
  }

  if(!scripts\mp\flags::gameflag("<dev string:x95>")) {
    return;
  }

  if(!istrue(self.var_9dc07720609cc75b)) {
    function_d6a5c9019b66d5d3();
  }

  [lootref, perks] = function_c32b469bb2b68ece();
  var_b904c15f8ea08a65 = 0;

  if(isDefined(lootref)) {
    self.var_a1adcd8ba70c9723["<dev string:x74>"] setdevtext("<dev string:xa6>" + lootref);
  } else {
    self.var_a1adcd8ba70c9723["<dev string:x74>"] setdevtext("<dev string:xb5>");
  }

  for(i = 1; i <= 4; i++) {
    perkname = "<dev string:xc5>";

    if(isDefined(perks) && array_contains_key(perks, "<dev string:x84>" + i)) {
      perkname = perks["<dev string:x84>" + i];
    }

    if(function_56f3d322e17b9974()) {
      scoreunlock = level.var_767653d4d33e973[i];
      statustext = "<dev string:xc9>";

      if(function_ee52068fbb9b0dec(i)) {
        statustext = "<dev string:xd3>";
      } else if(self.pers["<dev string:x8c>"] < scoreunlock && self.pers["<dev string:x8c>"] > var_b904c15f8ea08a65) {
        percentunlocked = round((self.pers["<dev string:x8c>"] - var_b904c15f8ea08a65) / (scoreunlock - var_b904c15f8ea08a65) * 100);
        statustext = percentunlocked + "<dev string:xdf>";
      } else if(self.pers["<dev string:x8c>"] >= scoreunlock) {
        statustext = "<dev string:xd3>";
      }

      self.var_a1adcd8ba70c9723["<dev string:x84>" + i] setdevtext("<dev string:xe4>" + i + "<dev string:xed>" + perkname + "<dev string:xf4>" + statustext);
      var_b904c15f8ea08a65 = scoreunlock;
      continue;
    }

    self.var_a1adcd8ba70c9723["<dev string:x84>" + i] setdevtext("<dev string:xe4>" + i + "<dev string:xfb>" + perkname);
  }
}

# /