/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_lootcache.gsc
****************************************************/

#using script_44b8991c2b01716a;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using scripts\common\callbacks;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\online_event;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_lootcache;

function brlootcache_init() {
  level.var_bd006676148e6c40 = [];
  level.var_a688dd9515c7def = [];
  level.var_344f2168e7b1bc8e = [];
  level.var_b00874d1374e4c38 = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", &lootcacheused);

  thread function_8ca2f83c962d40d9();
}

function canspawnitemname(itemname, iscustomweapon) {
  if(istrue(iscustomweapon)) {
    itemname = scripts\cp_mp\weapon::getweaponrootname(itemname);
  }

  if(!isDefined(itemname)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    if(isDefined(level.forbiddencachespawns) && isDefined(level.forbiddencachespawns[itemname])) {
      return false;
    }
  }

  if(scripts\cp_mp\utility\loot::isitemfiltered(itemname)) {
    return false;
  }

  if(itemname == "brloot_respawn_token" && scripts\mp\gametypes\br_pickups::respawntokendisabled()) {
    return false;
  }

  if(itemname == "brloot_gulag_token" && scripts\mp\gametypes\br_public::function_8b2396647673be50()) {
    return false;
  }

  if((itemname == "brloot_redeploy_token" || itemname == "brloot_gulag_token") && istrue(level.br_pickups.hidetokens)) {
    return false;
  }

  if(level.br_pickups.var_4757cffcfe60dc3a && itemname == "brloot_super_reinforcement_flare" && istrue(level.br_pickups.hidetokens)) {
    return false;
  }

  issolos = level.maxteamsize == 1 || istrue(level.brgametype.issolos);

  if(itemname == "brloot_super_reinforcement_flare" && issolos) {
    return false;
  }

  if(itemname == "loot_multi_key_fortress") {
    return false;
  }

  return true;
}

function lootspawnitem(itemname, dropstruct, origin, angles, var_4eddedc3311ede0d, islegendary, distoverride, yawoverride, yawhack) {
  if(istrue(var_4eddedc3311ede0d)) {
    if(dropstruct.dropcount % 2 > 0) {
      yaw = 75;
    } else {
      yaw = 115;
    }

    if(isDefined(yawhack)) {
      yaw = yawhack;

      if(dropstruct.dropcount % 2 > 0) {
        yaw -= 40;
      }
    }

    if(istrue(yawoverride)) {
      yaw += randomfloatrange(-1 * yawoverride, yawoverride);
    } else {
      yaw += randomfloatrange(-10, 10);
    }

    if(istrue(distoverride)) {
      dist = 35 + dropstruct.dropcount / 2 * 25 + randomfloatrange(-1 * distoverride, distoverride);
    } else {
      dist = 35 + dropstruct.dropcount / 2 * 25 + randomfloatrange(-5, 5);
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, origin, angles, undefined, yaw, dist);
  } else if(isDefined(self.var_d02a80abbdd18fe)) {
    dropinfo = [[self.var_d02a80abbdd18fe]](itemname, dropstruct, origin, angles, var_4eddedc3311ede0d, islegendary);
  } else {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, origin, angles);
  }

  dropcountlefthand = undefined;
  var_37dda6c5e1dabefa = undefined;

  if(scripts\mp\gametypes\br_weapons::isvalidcustomweapon(itemname)) {
    if(scripts\mp\gametypes\br_weapons::isexcludedweapon(itemname)) {
      if(isDefined(level.var_58ffe6a7ac9f8fd4[itemname.basename])) {
        dropcount = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(itemname);
        dropcountlefthand = level.var_58ffe6a7ac9f8fd4[itemname.basename];
      } else {
        dropcount = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(itemname);
      }
    } else {
      dropcount = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(itemname);

      if(isakimbo(itemname)) {
        dropcountlefthand = dropcount;
      }

      if(itemname.hasalternate) {
        altweapon = itemname getaltweapon();
        ammotype = br_ammo_type_for_weapon(itemname);
        var_8d876f015050ef61 = br_ammo_type_for_weapon(altweapon);
        assert(isDefined(ammotype), "<dev string:x1c>" + getcompleteweaponname(itemname));
        assert(isDefined(var_8d876f015050ef61), "<dev string:x42>" + getcompleteweaponname(itemname));

        if(ammotype != var_8d876f015050ef61) {
          var_37dda6c5e1dabefa = int(weaponclipsize(altweapon));
        } else {
          var_37dda6c5e1dabefa = int(min(weaponclipsize(altweapon), dropcount));
        }
      }
    }

    weaponname = getcompleteweaponname(itemname);
    pickupitem = scripts\mp\gametypes\br_pickups::spawnpickup(weaponname, dropinfo, dropcount, 1, itemname, undefined, dropcountlefthand, var_37dda6c5e1dabefa);
  } else {
    dropcount = level.br_pickups.counts[itemname];
    fullweaponobj = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname(itemname);

    if(isDefined(fullweaponobj)) {
      dropcount = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(fullweaponobj);

      if(isakimbo(fullweaponobj)) {
        dropcountlefthand = dropcount;
      }

      if(fullweaponobj.hasalternate) {
        altweapon = fullweaponobj getaltweapon();
        var_37dda6c5e1dabefa = int(min(weaponclipsize(altweapon), dropcount));
      }
    }

    pickupitem = scripts\mp\gametypes\br_pickups::spawnpickup(itemname, dropinfo, dropcount, 1, undefined, undefined, dropcountlefthand, var_37dda6c5e1dabefa);
    raritynum = level.br_pickups.br_itemrarity[itemname];
  }

  if(islegendary) {}

  return pickupitem;
}

function function_d683a60016231237(lootid, quantity, ref) {
  if(!isDefined(self.contents)) {
    self.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96(getscriptablelootcachecontents(self));
  }

  self.contents = array_randomize(scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f(self.contents, quantity, lootid, ref));
}

function function_848e20cf1d6cab8f(contents, quantity, lootid, ref, packitemindex) {
  if(!isDefined(packitemindex)) {
    packitemindex = contents.size;
  }

  contents[packitemindex] = [];
  contents[packitemindex]["quantity"] = int(quantity);
  contents[packitemindex]["lootID"] = lootid;

  if(isDefined(ref) && scripts\mp\gametypes\br_pickups::isweaponpickup(ref)) {
    contents[packitemindex]["ref"] = ref;
  }

  return contents;
}

function function_ec87b214cd429e96(items, existingcontents) {
  contents = [];

  if(isDefined(existingcontents)) {
    contents = existingcontents;
  }

  if(isDefined(items)) {
    startingsize = contents.size;

    for(index = 0; index < items.size - startingsize; index++) {
      item = items[index];
      lootid = function_fae5e1d3de32d3f7(item);
      quantity = 1;

      if(isDefined(level.br_pickups.counts[item])) {
        quantity = level.br_pickups.counts[item];
      }

      if(!isDefined(lootid)) {
        if(item == "brloot_armor_plate") {
          lootid = getlootidfromref("armor_plate");
        } else if(scripts\mp\gametypes\br_pickups::function_4294e9b331377c31(item)) {
          lootid = getlootidfromref("armor_satchel");
        } else if(scripts\mp\gametypes\br_pickups::isplunder(item)) {
          lootid = getlootidfromref("cash");
          quantity = level.br_pickups.counts[item];
        } else if(scripts\mp\gametypes\br_public::isammo(item) || item == "brloot_self_revive") {
          lootid = getlootidfromref(item);
          quantity = level.br_pickups.counts[item];
        }
      }

      contents = function_848e20cf1d6cab8f(contents, quantity, lootid, item);
      assertex(isDefined(lootid), "<dev string:x70>" + item);
    }

    contents = array_randomize(contents);
  }

  return contents;
}

function function_ec8712f07ed15e07(player, items, existingcontents, container) {
  contents = function_ec87b214cd429e96(items, existingcontents);

  if(isDefined(container.playersregistered)) {
    foreach(guid, itemset in container.playersregistered) {
      foreach(item in itemset) {
        contents = function_848e20cf1d6cab8f(contents, item["quantity"], item["lootID"], item["ref"]);
      }

      container.playercontents[guid].contents = contents;
      container.playersregistered[guid] = undefined;
    }
  }
}

function function_9065b3738ac07df0(items, cache, player, contents) {
  if(scripts\mp\loot::function_e3081772bbf7a51c(player, cache)) {
    function_ec8712f07ed15e07(player, items, contents, cache);
  } else {
    cache.contents = function_ec87b214cd429e96(items, contents);
  }

  contentscache = scripts\mp\loot::function_59b9c8081b873a10(player, cache);

  if(isDefined(contentscache.contents)) {
    cache.originalcontents = contentscache.contents;
  }

  scripts\mp\loot::openlootablecontainer(player, cache);
  return [];
}

function lootspawnitemlist(dropstruct, items, fromcache, player, distoverride, yawoverride, var_60ec3549226ce8d) {
  pickupents = [];
  legendary_dropped = 0;

  if(isDefined(items) && isDefined(items[0]) && isarray(items[0])) {
    newitems = [];

    foreach(item in items) {
      if(isDefined(item["lootID"])) {
        scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(item["lootID"]);
        newitems[newitems.size] = scriptable;
      }
    }

    items = newitems;
  }

  if(isDefined(self) && isDefined(self.type) && scripts\engine\utility::issharedfuncdefined(self.type, "spawnLoot")) {
    extraitems = scripts\engine\utility::callsharedfunc(self.type, "spawnLoot", player, dropstruct);

    if(isDefined(extraitems)) {
      foreach(extraitem in extraitems) {
        pickupents[pickupents.size] = extraitem;
      }
    }
  }

  var_4472b62c1fa150e5 = 0;
  var_7defd476665a5c0 = 0;
  var_1a51b8dd1e3a0296 = 0;
  var_7f6dc80424e55d7b = function_e1a934067bb5bc35(self);
  [hackyaw, hackorigin] = function_cb377a5e11eef62c(self);
  hackorigin = ter_op(isDefined(hackorigin), hackorigin, self.origin);
  var_e88269f1e541967 = ter_op(isDefined(var_60ec3549226ce8d), var_60ec3549226ce8d, self.angles);

  foreach(itemname in items) {
    iscustomweapon = scripts\mp\gametypes\br_weapons::isvalidcustomweapon(itemname);

    if(canspawnitemname(itemname, iscustomweapon)) {
      if(var_7f6dc80424e55d7b && scripts\mp\gametypes\br_pickups::isplunder(itemname)) {
        amount = level.br_pickups.counts[itemname];

        if(isDefined(amount)) {
          player scripts\mp\gametypes\br_plunder::playerplunderpickup(amount, undefined, undefined, 1);
          player scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(0, amount);
          var_1a51b8dd1e3a0296 += amount;
        }

        continue;
      }

      raritynum = undefined;

      if(!iscustomweapon) {
        raritynum = level.br_pickups.br_itemrarity[itemname];
      }

      if(isDefined(raritynum) && raritynum == 4 && legendary_dropped == 0) {
        if(isDefined(distoverride) || isDefined(yawoverride)) {
          if(!isDefined(distoverride)) {
            distoverride = 5;
          }

          if(!isDefined(yawoverride)) {
            yawoverride = 10;
          }

          pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, hackorigin, var_e88269f1e541967, fromcache, 1, distoverride, yawoverride, hackyaw);
          self.itemsdropped++;
          legendary_dropped = 1;
        } else {
          pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, hackorigin, var_e88269f1e541967, fromcache, 1, undefined, undefined, hackyaw);
          self.itemsdropped++;
          legendary_dropped = 1;
        }
      } else if(isDefined(distoverride) || isDefined(yawoverride)) {
        if(!isDefined(distoverride)) {
          distoverride = 5;
        }

        if(!isDefined(yawoverride)) {
          yawoverride = 10;
        }

        pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, hackorigin, var_e88269f1e541967, fromcache, 0, distoverride, yawoverride, hackyaw);
        self.itemsdropped++;
      } else {
        pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, hackorigin, var_e88269f1e541967, fromcache, 0, undefined, undefined, hackyaw);
        self.itemsdropped++;
      }

      if(iscustomweapon && !istrue(self.var_1e493f592119321e)) {
        weaponammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(itemname);

        if(isDefined(weaponammotype)) {
          pickupents[pickupents.size] = lootspawnitem(weaponammotype, dropstruct, hackorigin, var_e88269f1e541967, fromcache, 0, undefined, undefined, hackyaw);
          self.itemsdropped++;
        }

        var_7defd476665a5c0 = 1;
      }
    }
  }

  if(var_1a51b8dd1e3a0296 > 0 && istrue(level.var_9dd3ce936c1dec1d)) {
    plunder = spawnStruct();
    plunder.origin = player.origin;
    plunder.count = var_1a51b8dd1e3a0296;
    plunder.scriptablename = function_b88cfb4893ceedac("cash");

    if(isDefined(plunder.scriptablename)) {
      player scripts\mp\gametypes\br_pickups::playpickupfeedback(plunder, 0);
    }
  }

  if(scripts\mp\gametypes\br_lootcache::isplayerbackpack(self) && isDefined(self.owner)) {
    foreach(item in pickupents) {
      self.owner scripts\mp\gametypes\br_pickups::function_2f4e0022c686dbe6(item);
    }

    if(isDefined(self.weaponslotcontents) && isDefined(self.weaponslotobj)) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, var_e88269f1e541967);
      newweaponref = weaponspawn(self.weaponslotobj, self.owner, dropinfo, 0, 1);

      if(isDefined(newweaponref)) {
        ammotype = br_ammo_type_for_weapon(self.weaponslotobj);
        newweaponref.ammotype = ammotype;
        scripts\mp\gametypes\br_pickups::loot_setitemcount(newweaponref, self.weaponslotclip, self.var_ad7897ecdbcb63, self.var_86b32aff94b5714e);
      }

      self.owner scripts\mp\gametypes\br_pickups::function_2f4e0022c686dbe6(newweaponref);
      self.weaponslotcontents = undefined;
      self.weaponslotobj = undefined;
    }

    self.contents = [];
  }

  if(istrue(fromcache) && isDefined(player)) {
    if(var_4472b62c1fa150e5) {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_f396d39fee1a8054");
      player playsoundtoplayer("uin_loot_container_open_epic", player);
    } else if(var_7defd476665a5c0) {
      foreach(teammember in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
        if(isalive(teammember) && distance2d(teammember.origin, player.origin) <= 1000) {
          teammember thread scripts\mp\utility\points::doscoreevent(#"hash_c01d7d8b6119d321");
        }
      }

      player playsoundtoplayer("uin_loot_container_open_epic", player);
    } else {
      player thread scripts\mp\utility\points::doscoreevent(#"br_cacheOpen");
      player playsoundtoplayer("uin_loot_container_open_common", player);
    }
  }

  return pickupents;
}

function lootcachespawncontents(items, var_7a824904d97d59d7, player, contents) {
  if(var_7a824904d97d59d7) {
    return function_9065b3738ac07df0(items, self, player, contents);
  }

  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  return lootspawnitemlist(dropstruct, items, 1, player);
}

function function_c56e597e3aa81261(instance, player) {
  if(!isDefined(instance) || !isDefined(player) || !isalive(player)) {
    return;
  }

  if(!instance getscriptableparthasstate("body", "closed_usable")) {
    return;
  }

  instance setscriptablepartstate("body", "closed_usable");
  lootcacheused(instance, "body", "closed_usable", player, 0, undefined);
}

function lootcacheused(instance, part, state, player, bautouse, usestring, var_9f39a1d0187cefb8) {
  if(istrue(player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }

  var_64c59c08b4538d72 = scripts\mp\loot::function_55b384ecb923003e() && !function_e91a96d043315490(instance) && scripts\mp\loot::function_c929a8ad95b46fda(instance);

  if(istrue(player.isjuggernaut) && var_64c59c08b4538d72) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
    return;
  }

  if(!istrue(var_9f39a1d0187cefb8)) {
    assert(part == "<dev string:x8a>");
  }

  if((state == "closed_usable" || state == "closed_usable_no_collision") && !isDefined(instance.entity)) {
    if(scripts\mp\online_event::function_3392f98172a332d7() && !isbot(player)) {
      player thread scripts\mp\online_event::function_a23861c0f0635cf4(instance.type);
    }

    if(isDefined(instance.var_534e0cf170a981b7)) {
      result = [[instance.var_534e0cf170a981b7]](instance, player);

      if(isDefined(result) && result == 0) {
        return;
      }
    }

    if(!scripts\mp\loot::function_e3081772bbf7a51c(player, instance)) {
      if(var_64c59c08b4538d72 && instance getscriptableparthasstate(part, "partially_opening_unusable")) {
        instance setscriptablepartstate(part, "partially_opening_unusable");
      } else if(instance getscriptableparthasstate(part, "closed_to_fully_open_unusable")) {
        instance setscriptablepartstate(part, "closed_to_fully_open_unusable");
      } else if(instance getscriptableparthasstate(part, "fully_opening_unusable")) {
        instance setscriptablepartstate(part, "fully_opening_unusable");
      }
    }

    instance.itemsdropped = 0;
    pickupents = [];
    items = undefined;
    var_e451c519235e482 = isDefined(instance.type) && instance.type == "br_loot_cache_personal_supply";

    if(!istrue(var_e451c519235e482) && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("isCachePersonalSupply")) {
      var_e451c519235e482 = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("isCachePersonalSupply", instance);
    }

    if(istrue(var_e451c519235e482)) {
      loadoutnames = ["custom1", "custom2", "custom3", "custom4", "custom5", "custom6", "custom7", "custom8", "custom9", "custom10", "custom11", "custom12"];
      loadoutchoice = player getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");

      if(isDefined(loadoutchoice)) {
        loadoutchoice = loadoutnames[loadoutchoice];
        var_990bf19e67ec2d89 = player thread scripts\mp\gametypes\br::function_4043e420432f59f0(loadoutchoice);
        savedweapons = player function_75e83820a58a07c9(var_990bf19e67ec2d89);
        items = [];

        foreach(weapon in savedweapons) {
          items[items.size] = weapon;
        }
      }
    } else if(scripts\mp\loot::function_e3081772bbf7a51c(player, instance) && instance.playercontents[player.guid].contents.size > 0) {
      items = scripts\mp\loot::function_3c85cbbfd2d2a3da(player, instance);
    } else if(isDefined(instance.contents) && !function_ae639176fec476a6(instance)) {
      items = instance.contents;
    } else {
      items = getscriptablelootcachecontents(instance);

      if(!isDefined(items)) {
        assertmsg("<dev string:x92>");
        return;
      }

      if(isDefined(instance.var_2e1a29fb688816d4)) {
        items[items.size] = instance.var_2e1a29fb688816d4;
      }

      instance.var_2e1a29fb688816d4 = undefined;
      items = function_728bdc627d7df6c2(items, instance);

      if(isDefined(instance.type) && scripts\engine\utility::issharedfuncdefined(instance.type, "opened")) {
        items = instance scripts\engine\utility::callsharedfunc(instance.type, "opened", items, player);
      }

      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("lootCacheAdjustItems")) {
        items = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("lootCacheAdjustItems", items, instance);
      }

      if(isDefined(level.var_91104c01620d26b0)) {
        foreach(modifyfunc in level.var_91104c01620d26b0) {
          items = [[modifyfunc]](items, instance);
        }
      }

      items = function_6975415e57cd5a29(items, player);

      if(player scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
        items = lootcontentsadjustkillchain(items, player);
      }

      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if(getdvarint(@ "hash_f925d53a2a478522", 1) && (brgametype == "plunder" || brgametype == "risk")) {
        if(scripts\mp\flags::gameflag("placement_updates_allowed")) {
          placement = game["teamPlacements"][player.team];

          if(!isDefined(level.numteamswithplayers)) {
            scripts\mp\utility\teams::calculatenumteamswithplayers();
          }

          percentageplacement = 100 - 100 * placement / level.numteamswithplayers;

          if(isDefined(level.bottompercentagetoadjusteconomy) && percentageplacement < level.bottompercentagetoadjusteconomy) {
            items = lootcontentsadjusteconomy_bottomtier(instance, items);
          } else if(isDefined(level.toppercentagetoadjusteconomy) && percentageplacement > level.toppercentagetoadjusteconomy) {
            items = lootcontentsadjusteconomy_toptier(instance, items);
          }
        }
      }

      if(isDefined(level.maxaccesscardspawns_red)) {
        items = lootcontentsadjust_accesscardsred(items);
      }

      if(scripts\engine\utility::issharedfuncdefined("br_lootcache", "adjustContents")) {
        items = [[scripts\engine\utility::getsharedfunc("br_lootcache", "adjustContents")]](items, player, state);
      }
    }

    if(function_6759ff16e552aa94(instance) || isplayerbackpack(instance)) {
      player playsoundtoplayer("open_backpack", player);
    }

    if(!isDefined(instance.containertype)) {
      instance.containertype = 3;
    }

    activesupplysweeps = level.teamdata[player.team]["activeSupplySweeps"];

    if(isDefined(activesupplysweeps)) {
      foreach(streakinfo in activesupplysweeps) {
        if(isDefined(streakinfo) && streakinfo.owner != player) {
          streakinfo.owner thread scripts\mp\utility\points::giveunifiedpoints("br_supply_sweep_assist", undefined, undefined, undefined, undefined, undefined, streakinfo);
        }
      }
    }

    if(instance.type == "br_loot_cache_bunker" && isDefined(level.teamdata[player.team]["players"].size) && getdvarint(@ "hash_404657ad81e38a83", 0)) {
      lootitem = "brloot_equip_gasmask_durable";

      for(i = 0; i < level.teamdata[player.team]["players"].size - 1; i++) {
        items[items.size] = lootitem;
      }
    }

    existingcontents = instance.contents;

    if(scripts\mp\loot::function_e3081772bbf7a51c(player, instance)) {
      existingcontents = scripts\mp\loot::function_3c85cbbfd2d2a3da(player, instance);
    }

    pickupents = instance lootcachespawncontents(items, var_64c59c08b4538d72, player, existingcontents);
    instance.player = player;
    instance opencrate(items);
    cachetype = undefined;

    switch (instance.type) {
      case #"hash_417c605750c7baa5":
        cachetype = "cache";
        break;
      case #"hash_19ba8d41970911ad":
      case #"hash_1a4740585c33b169":
      case #"hash_ca40e4f432250696":
      case #"hash_d1616a5975b7a941":
        cachetype = "cache_legendary";
        break;
      case #"hash_8944097b14faec32":
        cachetype = "cache_scavenger";
        break;
      case #"hash_5bbda41f2e59fbef":
        cachetype = "cache_secretstash";
        break;
      case #"hash_4ca1dc2e1b0de0d3":
        cachetype = "reusable_cache";
        instance thread closeagain(part);
        instance.var_ab01afae3ce374e2 = player;
        break;
      case #"hash_bc13d03dc3f6d6e8":
        cachetype = "cache_personal_supply";
        break;
      case #"hash_359b8df8ec962fa4":
      case #"hash_4882ae4b6d3fae70":
        cachetype = "cache_personal_legacy";
        break;
      case #"hash_9c5f01407ae504fc":
        namespace_bd614c3c2275579a::function_ec5e700fa41093a4(instance.fortress, instance);
        break;
      case #"hash_4654cfd269b6fc02":
        namespace_bd614c3c2275579a::function_ec5e700fa41093a4(instance.fortress, instance);
        break;
      default:
        if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getGametypeCacheType")) {
          items = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getGametypeCacheType", instance, part);
        }

        break;
    }

    if(isDefined(cachetype)) {
      foreach(ent in pickupents) {
        ent.lootsource = cachetype;
      }

      scripts\mp\gametypes\br_plunder::modify_plunder_itemsinworld("br_loot_cache", -1);

      if(!isDefined(player.lootcachesopened)) {
        player.lootcachesopened = 1;
      } else {
        player.lootcachesopened++;
      }

      if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder") {
        player scripts\mp\gametypes\br_public::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);
      }

      level notify("lootcache_opened_kill_callout" + instance.origin);
      level notify("open_loot_box_" + player.team, player, 1, instance);
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(level.contractmanager)) {
      foreach(contract in level.contractmanager.contractdata) {
        if(isDefined(contract.funcs["onCacheLooted"])) {
          foreach(task in level.contractmanager.currenttasks) {
            if(contract.ref == task.type.ref) {
              task[[contract.funcs["onCacheLooted"]]](player, instance.containertype);
            }
          }
        }
      }
    }

    player scripts\cp_mp\challenges::function_da9003df08944b01(instance);
    scripts\mp\pmc_missions::function_68d841f5bc2dd2b6(player, instance);
  } else if(var_64c59c08b4538d72 && (isDefined(instance.contents) || scripts\mp\loot::function_e3081772bbf7a51c(player, instance)) && state == "partially_open_usable") {
    if(!scripts\mp\loot::function_e3081772bbf7a51c(player, instance)) {
      if(instance getscriptableparthasstate(part, "partially_reopen_in_use_unusable")) {
        instance setscriptablepartstate(part, "partially_reopen_in_use_unusable");
      } else if(instance getscriptableparthasstate(part, "partially_open_in_use_unusable")) {
        instance setscriptablepartstate(part, "partially_open_in_use_unusable");
      }
    }

    existingcontents = instance.contents;

    if(scripts\mp\loot::function_e3081772bbf7a51c(player, instance)) {
      existingcontents = scripts\mp\loot::function_3c85cbbfd2d2a3da(player, instance);
    }

    instance lootcachespawncontents(undefined, var_64c59c08b4538d72, player, existingcontents);
  }

  var_e384a29fa99c895c = spawnStruct();
  var_e384a29fa99c895c.player = player;
  var_e384a29fa99c895c.instance = instance;
  var_e384a29fa99c895c.pickupents = isDefined(pickupents) ? pickupents : undefined;
  var_3523cc58899fd9ba = istrue(level.var_2a5270e448379c6f) || getdvarint(@ "hash_a6ad2c23e3f14cf2", 0);

  if(var_3523cc58899fd9ba) {
    var_844928811ae86dbf = getdvarfloat(@ "hash_7ac9cbf284596e74", 0.1);

    if(randomfloat(1) < var_844928811ae86dbf) {
      var_9ba0d32850eee4c8 = namespace_2db04a57a1b9bf62::function_b67f0b02f25b1af(player, 1, 0);
    }
  }

  player thread utility::callsharedfunc("featurebans", "featurebans_jumpScare", instance);
  scripts\common\callbacks::callback("cache_opened", var_e384a29fa99c895c);
}

function function_ae639176fec476a6(instance) {
  return instance.type == "br_reusable_loot_cache" && istrue(instance.var_1208f086f2985c55);
}

function function_e1a934067bb5bc35(container) {
  if(!istrue(level.var_e8fc7c00fd85a565)) {
    return false;
  }

  if(isDefined(container) && isDefined(container.type)) {
    switch (container.type) {
      case #"hash_93553b29704c0d3":
      case #"hash_2808ce3c4558142d":
        return true;
    }
  }

  return false;
}

function closeagain(part) {
  level endon("game_ended");
  self endon("death");
  self endon("closed");
  var_eb937f6d33835604 = getdvarint(@ "hash_fd0c403fee9dc217", 90);
  fxincrement = var_eb937f6d33835604 / 3;
  self.var_1208f086f2985c55 = 1;
  wait fxincrement;

  if(!isDefined(self)) {
    return;
  }

  self setscriptablepartstate(part, "fully_open_unusable_fx2");
  wait fxincrement;

  if(!isDefined(self)) {
    return;
  }

  self setscriptablepartstate(part, "fully_open_unusable_fx3");
  wait fxincrement;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_ab01afae3ce374e2) && isDefined(self.var_ab01afae3ce374e2.var_2fa5b49969def47) && self.var_ab01afae3ce374e2.var_2fa5b49969def47 == self) {
    self.var_ab01afae3ce374e2 setclientomnvar("loot_container_open", 0);
  }

  function_27f0aed354031248();
  removecrate();
  self setscriptablepartstate(part, "closing");
  self notify("closed");
}

function function_e91a96d043315490(instance) {
  return scripts\mp\gametypes\br_lootcache::isplayerbackpack(instance) && istrue(level.explodingbackpack);
}

function function_6759ff16e552aa94(container) {
  return isDefined(container) && isDefined(container.type) && container.type == "brloot_backpack";
}

function isplayerbackpack(container) {
  return isDefined(container) && isDefined(container.type) && (container.type == "brloot_backpack_player_small" || container.type == "brloot_backpack_player_medium" || container.type == "brloot_backpack_player_large");
}

function function_163d360c111caa16(contents, var_8bd50c7e994c7434, var_42be80ba01341305) {
  totalcashvalue = 0;
  var_311064d4e2c10b88 = 0;

  foreach(item in contents) {
    if(scripts\mp\gametypes\br_pickups::function_34af0f77c1668dba(item["lootID"])) {
      totalcashvalue += item["quantity"];
      var_311064d4e2c10b88++;
    }
  }

  totalsurplus = 0;

  if(var_311064d4e2c10b88) {
    cashdifference = var_8bd50c7e994c7434 - totalcashvalue;
    var_c1d5034790909c2e = 5 * int(cashdifference / var_311064d4e2c10b88 / 5);

    foreach(i, item in contents) {
      if(scripts\mp\gametypes\br_pickups::function_34af0f77c1668dba(item["lootID"]) && item["quantity"] < var_42be80ba01341305) {
        surplus = max(item["quantity"] + var_c1d5034790909c2e - var_42be80ba01341305, 0);
        contents[i]["quantity"] = int(min(item["quantity"] + var_c1d5034790909c2e, var_42be80ba01341305));
        totalsurplus += surplus;
      }
    }
  } else {
    totalsurplus = var_8bd50c7e994c7434;
  }

  while(totalsurplus > 0) {
    value = min(totalsurplus, var_42be80ba01341305);
    contents = scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f(contents, value, 8395);
    totalsurplus -= value;
  }

  return array_randomize(contents);
}

function function_728bdc627d7df6c2(items, instance) {
  if(instance.type != "br_loot_cache_lege" && instance.type != "br_loot_cache_lege_novehiclecollision") {
    return items;
  }

  ammotype = "brloot_ammo_762";

  foreach(item in items) {
    if(isDefined(level.br_lootiteminfo[item]) && isDefined(level.br_lootiteminfo[item].fullweaponobj) && scripts\mp\gametypes\br_pickups::isweaponpickup(item)) {
      ammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(level.br_lootiteminfo[item].fullweaponobj);
      break;
    }
  }

  items[items.size] = ammotype;
  return array_randomize(items);
}

function lootcontentsadjusteconomy_bottomtier(instance, items) {
  adjusteditems = [];

  foreach(item in items) {
    if(issubstr(item, "brloot_plunder")) {
      if(instance.type == "br_loot_cache_lege") {
        if(item != "brloot_plunder_cash_legendary_1" && scripts\engine\utility::cointoss()) {
          item = "brloot_plunder_cash_legendary_1";
        }
      } else if(item != "brloot_plunder_cash_epic_2" && scripts\engine\utility::cointoss()) {
        item = "brloot_plunder_cash_epic_2";
      }
    }

    adjusteditems[adjusteditems.size] = item;
  }

  return adjusteditems;
}

function lootcontentsadjusteconomy_toptier(instance, items) {
  adjusteditems = [];

  foreach(item in items) {
    if(issubstr(item, "brloot_plunder")) {
      if(instance.type == "br_loot_cache_lege") {
        if((item == "brloot_plunder_cash_epic_2" || item == "brloot_plunder_cash_legendary_1") && scripts\engine\utility::cointoss()) {
          item = "brloot_plunder_cash_epic_1";
        }
      } else if((item == "brloot_plunder_cash_epic_2" || item == "brloot_plunder_cash_epic_1") && scripts\engine\utility::cointoss()) {
        item = "brloot_plunder_cash_rare_2";
      }
    }

    adjusteditems[adjusteditems.size] = item;
  }

  return adjusteditems;
}

function lootcontentsadjust_accesscardsred(items) {
  adjusteditems = [];

  foreach(item in items) {
    if(item != "brloot_access_card_red") {
      adjusteditems[adjusteditems.size] = item;
      continue;
    }

    if(level.maxaccesscardspawns_red > level.accesscardsspawned_red) {
      adjusteditems[adjusteditems.size] = item;
      level.accesscardsspawned_red++;
    }
  }

  return adjusteditems;
}

function chooseandspawnitems(dropstruct, minrarity, var_2860fa0f2247ccf0, itemtypeoverride, var_d6379f1654c3dca3, angleoffset, originoffset) {
  pickupents = [];
  legendary_dropped = 0;

  if(!isDefined(itemtypeoverride)) {
    itemtypeoverride = "";
  }

  if(!isDefined(minrarity)) {
    minrarity = 0;
  }

  lootlist = "mp/loot_set_cache_contents_base.csv";

  if(isDefined(var_d6379f1654c3dca3)) {
    lootlist = var_d6379f1654c3dca3;
  }

  for(currentitemindex = 0; currentitemindex < var_2860fa0f2247ccf0; currentitemindex++) {
    itemname = pickscriptablelootitem(itemtypeoverride, minrarity, 0, lootlist);

    if(canspawnitemname(itemname)) {
      angles = self.angles;

      if(isDefined(angleoffset)) {
        angles += angleoffset;
      }

      origin = self.origin;

      if(isDefined(originoffset)) {
        origin += originoffset;
      }

      raritynum = level.br_pickups.br_itemrarity[itemname];

      if(isDefined(raritynum) && raritynum == 4 && legendary_dropped == 0) {
        pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, origin, angles, undefined, 1);
        legendary_dropped = 1;
        continue;
      }

      pickupents[pickupents.size] = lootspawnitem(itemname, dropstruct, origin, angles, undefined, 0);
    }
  }

  return pickupents;
}

function lootcontentsadjustkillchain(items, player) {
  if(!isDefined(player.brkillchainchance)) {
    player.brkillchainchance = 10;
  }

  containskillstreak = 0;

  foreach(item in items) {
    if(issubstr(item, "killstreak")) {
      containskillstreak = 1;
      break;
    }
  }

  if(!containskillstreak) {
    killpercent = player.killcountthislife * 0;

    if(randomint(100) < player.brkillchainchance + killpercent) {
      var_d45c83148ef4cf67 = ["brloot_killstreak_clusterstrike", "brloot_killstreak_precision_airstrike", "brloot_killstreak_uav_bigmap", "brloot_killstreak_shieldturret"];
      items[items.size] = random(var_d45c83148ef4cf67);
      player.brkillchainchance = 10;
    } else {
      player.brkillchainchance += killpercent + 15;
    }
  }

  return items;
}

function function_75e83820a58a07c9(var_990bf19e67ec2d89) {
  level endon("game_ended");
  weapons = [];
  weapons[weapons.size] = var_990bf19e67ec2d89.loadoutprimaryobject;
  weapons[weapons.size] = var_990bf19e67ec2d89.loadoutsecondaryobject;
  return weapons;
}

function function_a76b46f057488cc0(instance, team, var_57838bb4fae836f8, var_583832b5ec35dfbc) {
  upgradecount = namespace_a38a2e1fe7519183::function_e860c1be7ff11f5b(team, var_57838bb4fae836f8);
  additionalitemcount = upgradecount * var_583832b5ec35dfbc;
  items = getscriptablelootcachecontents(instance);
  additionalitems = array_randomize(getscriptablelootcachecontents(instance));

  for(i = 0; i < additionalitemcount; i++) {
    items[items.size] = additionalitems[i];
  }

  return items;
}

function function_3acd6ff5bda75039(items) {
  foreach(item in items) {
    if(issubstr(item, "brloot_plunder")) {
      return true;
    }
  }

  return false;
}

function function_6975415e57cd5a29(items, player) {
  lootname = getDvar(@ "hash_4b9f1b5e62c2ac88", "<dev string:xd7>");
  lootprobability = getdvarfloat(@ "hash_19a50cd3f012388e", 0);

  if(lootprobability > randomfloat(1)) {
    items[items.size] = lootname;
  }

  return items;
}

function spawnlootcache(origin, angles, type) {
  switch (type) {
    case 2:
      scriptable = spawnscriptable("<dev string:xdb>", origin, angles);
      break;
    case 3:
      scriptable = spawnscriptable("<dev string:xf1>", origin, angles);
      break;
    case 4:
      scriptable = spawnscriptable("<dev string:x10b>", origin, angles);
      break;
    default:
      scriptable = spawnscriptable("<dev string:x12c>", origin, angles);
      break;
  }

  scriptable setscriptablepartstate("<dev string:x8a>", "<dev string:x13d>");
}

function function_8ca2f83c962d40d9() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_82b5f4eccb13d4d2", 0)) {
      caches = [];
      lootcount = getlootspawnpointcount();

      for(i = 0; i < lootcount; i++) {
        loot = getlootspawnpoint(i);

        if(loot.type == 1) {
          playerdist = distance2dsquared(level.players[0].origin, loot.origin);

          if(playerdist <= 1e+08) {
            caches[caches.size] = loot;
          }
        }
      }

      foreach(cache in caches) {
        sphere(cache.origin, 25, (1, 0, 0), 0, 1);
      }
    }
  }
}

function function_cb377a5e11eef62c(container) {
  if(!getdvarint(@ "hash_c38245858b3dcc0d", 1)) {
    return [undefined, undefined];
  }

  if(!isDefined(container.type)) {
    return [undefined, undefined];
  }

  forward = anglesToForward(container.angles);
  left = anglestoright(container.angles) * -1;
  up = anglestoup(container.angles);

  switch (container.type) {
    case #"hash_f5264031983561d3":
    case #"hash_f526413198356366":
      return [undefined, container.origin + left * getdvarfloat(@ "hash_90ce55a815605004", 16) + up * 30];
    case #"hash_1cb302e16a34b4dd":
      return [undefined, container.origin + forward * getdvarfloat(@ "hash_90ce55a815605004", 16)];
    case #"hash_6d3a7f28d4e30af0":
    case #"hash_15ffdff5c5e4cca2":
    case #"hash_8a31c0680349ff7b":
    case #"hash_bd0a50437d51e6e7":
    case #"hash_bd0a51437d51e87a":
    case #"hash_c82c626607f41c61":
    case #"hash_f086d807b107cbfd":
      return [0, container.origin + forward * getdvarfloat(@ "hash_90ce55a815605004", 16)];
    case #"hash_50e52e4dc37fb7a8":
      return [0, container.origin + forward * getdvarfloat(@ "hash_90ce55a815605004", 16) + up * -15];
    case #"hash_44904bb5898785d9":
      return [270, undefined];
    case #"hash_1a50c41f80fb532b":
    case #"hash_39e3bc45cc6f31c1":
      return [270, container.origin + up * 15];
    case #"hash_2cbf29aaf45c022d":
      return [undefined, container.origin + left * 10 + up * -30];
    case #"hash_4c9cda73b7cb8b41":
      return [0, container.origin + up * -15];
    case #"hash_93553b29704c0d3":
    case #"hash_2808ce3c4558142d":
    case #"hash_469a90a45e97eda9":
      return [0, container.origin + forward * 15 + up * -15];
    case #"hash_acc339f27e6535d8":
    case #"hash_acc33cf27e653a91":
      return [0, container.origin + forward * getdvarfloat(@ "hash_90ce55a815605004", 16) + up * 30];
    case #"hash_622289dd129d2c26":
      return [undefined, container.origin + left * 10 + up * 20];
    case #"hash_7125a4bce2d8c398":
    case #"hash_7adf06ad39cbadfa":
      return [0, container.origin + forward * 8 + up * -10];
    case #"hash_763609926e3b8ed":
    case #"hash_7635d9926e3b434":
      return [undefined, container.origin + forward * getdvarfloat(@ "hash_90ce55a815605004", 16) + left * 16 + up * -5];
    case #"hash_a6fd900b15b2be21":
      return [0, container.origin + forward * 25 + up * 20];
    case #"hash_a7972bf23ae4418b":
      return [undefined, container.origin + up * 20];
    case #"hash_f5c9223af83f2f31":
      return [30, container.origin + up * 10];
    case #"hash_86270620b8682388":
      return [30, container.origin + forward * 10 + up * -20];
    case #"hash_90051205d688bdf5":
      return [270, container.origin + forward * 10 + up * 5];
    case #"hash_359b8df8ec962fa4":
    case #"hash_4882ae4b6d3fae70":
      return [200, container.origin];
    default:
      return [undefined, undefined];
  }
}

function opencrate(items) {
  switch (self.type) {
    case #"hash_417c605750c7baa5":
      level.var_a688dd9515c7def = array_add(level.var_a688dd9515c7def, items);
      level.var_bd006676148e6c40 = array_add(level.var_bd006676148e6c40, self);
      break;
    case #"hash_19ba8d41970911ad":
    case #"hash_d1616a5975b7a941":
      level.var_344f2168e7b1bc8e = array_add(level.var_344f2168e7b1bc8e, items);
      level.var_bd006676148e6c40 = array_add(level.var_bd006676148e6c40, self);
      break;
    case #"hash_4ca1dc2e1b0de0d3":
      if(!getdvarint(@ "hash_e2833ccddfe41882", 1) || level.var_b00874d1374e4c38.size < 100 && !isDefined(self.contents)) {
        level.var_b00874d1374e4c38 = array_add(level.var_b00874d1374e4c38, items);
      }

      level.var_bd006676148e6c40 = array_add(level.var_bd006676148e6c40, self);
      break;
    case #"hash_359b8df8ec962fa4":
    case #"hash_4654cfd269b6fc02":
    case #"hash_4882ae4b6d3fae70":
    case #"hash_9c5f01407ae504fc":
    case #"hash_bc13d03dc3f6d6e8":
    case #"hash_d544c6a618d9d243":
      level.var_bd006676148e6c40 = array_add(level.var_bd006676148e6c40, self);
      break;
    case #"hash_5bbda41f2e59fbef":
    case #"hash_8944097b14faec32":
      break;
    default:
      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("openGametypeCrate")) {
        scripts\mp\gametypes\br_gametypes::runbrgametypefunc("openGametypeCrate", self, items);
      }

      break;
  }

  scripts\mp\gametypes\br_analytics::function_eb0f4a619dd99bba(self.type, self.origin, items, self.index);
}

function removecrate() {
  if(array_contains(level.var_bd006676148e6c40, self)) {
    level.var_bd006676148e6c40 = array_remove(level.var_bd006676148e6c40, self);
  }
}

function function_27f0aed354031248() {
  if(!isDefined(level.var_b00874d1374e4c38) || level.var_b00874d1374e4c38.size <= 0) {
    return;
  }

  self.var_1208f086f2985c55 = 0;

  if(getdvarint(@ "hash_e2833ccddfe41882", 1)) {
    self.contents = utility::array_random(level.var_b00874d1374e4c38);
    return;
  }

  randomindex = randomintrange(0, 99);
  newitems = getscriptcachecontents("sc_reusable_cache_restock", randomindex);
  self.contents = newitems;
}