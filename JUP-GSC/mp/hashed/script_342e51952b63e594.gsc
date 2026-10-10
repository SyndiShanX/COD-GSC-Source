/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_342e51952b63e594.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using script_b7a9ce0a2282b79;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\locksandkeys;
#using scripts\mp\utility\player;
#namespace namespace_88c3382d02472ceb;

function init() {
  level endon("game_ended");
  level.var_c153eac6e7c0e1a2 = getdvarint(@ "hash_ae537ea74ad94bf6", 0);

  if(!level.var_c153eac6e7c0e1a2) {
    return;
  }

  level.var_78794c7cfbb450d5 = getDvar(@ "hash_d02bf26d7b888c7b", "barter_recipe_list_iw9");
  level.var_cfd448bdaf563afa = function_98723716dbe58366(getDvar(@ "hash_25dbdc95ff3e3da5", "barter_list_overrides_iw9"));
  scripts\mp\flags::gameflagwait("prematch_done");
  level.barterrecipes = function_eee09bd49d34d254(level.var_78794c7cfbb450d5);

  level thread function_f1c3dc8c80e536c4();
}

function function_b03a252f9ab9bcfd(player, index) {
  recipes = function_4ae28d68dfc25dad(player);
  return function_2f1ef432df69a29b(player, recipes[index]);
}

function function_2b4f0bea679346ef(player) {
  player notify("clear_barter");
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("clear_barter");
  waitframe();
  player setclientomnvar("ui_barter_success", 0);
}

function function_45eefc63956143ed(kiosk, var_78794c7cfbb450d5) {
  if(!isDefined(kiosk) || !isDefined(var_78794c7cfbb450d5) || !isDefined(level.var_cfd448bdaf563afa[var_78794c7cfbb450d5])) {
    return;
  }

  kiosk.var_9e3b77c6c3e95470 = level.var_cfd448bdaf563afa[var_78794c7cfbb450d5] + 1;
  kiosk.var_8165379c774fe8e3 = function_eee09bd49d34d254(var_78794c7cfbb450d5);
}

function function_fa0f2fcfc30f95a(players, kiosk, var_78794c7cfbb450d5) {
  foreach(player in players) {
    function_c661afd69dc6cb4d(player, kiosk, var_78794c7cfbb450d5);
  }
}

function function_c661afd69dc6cb4d(player, kiosk, var_78794c7cfbb450d5) {
  if(!isDefined(player) || !isDefined(kiosk) || !isDefined(var_78794c7cfbb450d5) || !isDefined(level.var_cfd448bdaf563afa[var_78794c7cfbb450d5])) {
    return;
  }

  if(!isDefined(kiosk.var_a713dcdd8d8d5d12)) {
    kiosk.var_a713dcdd8d8d5d12 = [];
  }

  kiosk.var_a713dcdd8d8d5d12[player.guid] = spawnStruct();
  kiosk.var_a713dcdd8d8d5d12[player.guid].var_9eb2829af566123b = level.var_cfd448bdaf563afa[var_78794c7cfbb450d5] + 1;
  kiosk.var_a713dcdd8d8d5d12[player.guid].barterrecipes = function_eee09bd49d34d254(var_78794c7cfbb450d5);
}

function function_cf93c66f1f68b32b(player, kiosk) {
  if(!istrue(level.var_c153eac6e7c0e1a2)) {
    return false;
  }

  if(!isDefined(player) || !isDefined(kiosk)) {
    return false;
  }

  return isDefined(kiosk.var_a713dcdd8d8d5d12) && isDefined(kiosk.var_a713dcdd8d8d5d12[player.guid]) || isDefined(kiosk.var_9e3b77c6c3e95470);
}

function function_6b9fb04b51e91720(player, kiosk) {
  if(!function_cf93c66f1f68b32b(player, kiosk)) {
    return 0;
  }

  if(isDefined(kiosk.var_a713dcdd8d8d5d12) && isDefined(kiosk.var_a713dcdd8d8d5d12[player.guid])) {
    return kiosk.var_a713dcdd8d8d5d12[player.guid].var_9eb2829af566123b;
  }

  return kiosk.var_9e3b77c6c3e95470;
}

function private function_eee09bd49d34d254(var_78794c7cfbb450d5) {
  var_2e6cde9123966491 = getscriptbundle(hashcat(%"hash_6c8907a65a40a6a9", var_78794c7cfbb450d5));
  barterrecipes = [];

  foreach(recipe in var_2e6cde9123966491.var_13736fc9faa3bcf3) {
    if(isDefined(recipe.recipe)) {
      barterrecipes[barterrecipes.size] = getscriptbundle("barterrecipes:" + recipe.recipe);
    }
  }

  return barterrecipes;
}

function private function_98723716dbe58366(listoverride) {
  bundleoverride = getscriptbundle(hashcat(%"hash_283f419bc25a568b", listoverride));
  outputoverrides = [];

  foreach(index, list in bundleoverride.listoverrides) {
    if(isDefined(list.list)) {
      outputoverrides[list.list] = index;
    }
  }

  return outputoverrides;
}

function private function_4ae28d68dfc25dad(player) {
  if(!isDefined(player) || !isDefined(player.br_kiosk)) {
    return level.barterrecipes;
  }

  if(isDefined(player.br_kiosk.var_a713dcdd8d8d5d12) && isDefined(player.br_kiosk.var_a713dcdd8d8d5d12[player.guid])) {
    return player.br_kiosk.var_a713dcdd8d8d5d12[player.guid].barterrecipes;
  }

  if(isDefined(player.br_kiosk.var_8165379c774fe8e3)) {
    return player.br_kiosk.var_8165379c774fe8e3;
  }

  return level.barterrecipes;
}

function private function_dde2ba6e3e9a30f8(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(player)) {
    return false;
  }

  return true;
}

function private function_90e06d23e15ccc43(player, matchlootid) {
  loadoutitems = player namespace_aead94004cf4c147::function_88a168912191ec3e(1, 1, 1);

  if(isDefined(loadoutitems)) {
    foreach(indextype, itemtype in loadoutitems) {
      if(!itemtype.size) {
        continue;
      }

      foreach(slotindex, slot in itemtype) {
        if(!isDefined(slot)) {
          continue;
        }

        lootid = slot[0];
        quantity = slot[1];

        if(!istrue(lootid) || !istrue(quantity)) {
          continue;
        }

        if(lootid != matchlootid) {
          continue;
        }

        if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(matchlootid) && quantity > 0) {
          quantity = 1;
        }

        return [quantity, indextype, slotindex];
      }
    }
  }

  return [0, 0, 0];
}

function private function_e59cc32a4f43c5d8(player, amount, itemtype, itemindex) {
  switch (itemtype) {
    case 0:
      plundercount = player.plundercount - amount;
      player scripts\mp\gametypes\br_plunder::playersetplundercount(plundercount);
      break;
    case 1:
      break;
    case 2:
      slot = scripts\mp\equipment::function_4967838290cb31b9(itemindex);
      player scripts\mp\equipment::decrementequipmentslotammo(slot, amount);
      break;
    case 3:
      player scripts\mp\killstreaks\killstreaks::removekillstreak(1);
      break;
    case 4:
      player scripts\mp\gametypes\br_pickups::resetsuper();
      player.equipment["super"] = undefined;
      break;
    case 6:
      player scripts\mp\gametypes\br_pickups::function_75520ea44545c906();
      namespace_a38a2e1fe7519183::function_55dc9108a9301e59(player);
      break;
    case 7:
      player scripts\mp\gametypes\br_pickups::removeselfrevivetoken();
      break;
    default:
      assertmsg("<dev string:x1c>" + itemtype);
      return;
  }
}

function private function_2f1ef432df69a29b(player, recipe) {
  if(!function_dde2ba6e3e9a30f8(player)) {
    return false;
  }

  var_2e72cf01652b5bd = [];

  if(isDefined(recipe.var_41f94bca374ed58a) && recipe.var_41f94bca374ed58a > 0) {
    if(!namespace_a38a2e1fe7519183::function_59352c09a417a5e2(player, recipe.var_41f94bca374ed58a)) {
      return false;
    }
  }

  foreach(item in recipe.materials) {
    scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);
    var_8f0a45a0f5b42b90 = item.lootid;

    if(scripts\mp\gametypes\br_pickups::iskey(scriptablename)) {
      rootkeyname = scripts\mp\locksandkeys::function_475482bfe3feb25(scriptablename);
      [scriptablename, keylevel] = scripts\mp\locksandkeys::function_7d321a63bc56c65c(rootkeyname, player, 1);
      var_8f0a45a0f5b42b90 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
    }

    var_99ca2650c284f5c3 = player function_93f02514431a1f5d(var_8f0a45a0f5b42b90);
    [var_b834cfed17d314a3, loadouttype, loadoutindex] = function_90e06d23e15ccc43(player, var_8f0a45a0f5b42b90);
    var_f53ae6184f353b7 = undefined;

    if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(player) && scripts\mp\gametypes\br_pickups::isdogtag(scriptablename)) {
      currentdogtag = scripts\mp\gametypes\dmz_dog_tag::function_59771b0cc100410a(player);

      if(currentdogtag == scriptablename) {
        var_b834cfed17d314a3++;
        var_f53ae6184f353b7 = 1;
      }
    }

    if(var_99ca2650c284f5c3 + var_b834cfed17d314a3 < item.quantity) {
      return false;
    }

    var_89955e781d50267a = player function_aeb6f176059d98f5(var_8f0a45a0f5b42b90);

    if(var_89955e781d50267a.size == 0 && var_b834cfed17d314a3 < item.quantity) {
      return false;
    }

    if(var_99ca2650c284f5c3 >= item.quantity) {
      var_b834cfed17d314a3 = undefined;
      loadoutindex = undefined;
      loadouttype = undefined;
      var_f53ae6184f353b7 = undefined;
    } else {
      var_b834cfed17d314a3 = item.quantity - var_99ca2650c284f5c3;
    }

    var_99ca2650c284f5c3 = int(min(var_99ca2650c284f5c3, item.quantity));

    if(isDefined(var_b834cfed17d314a3)) {
      var_b834cfed17d314a3 = int(min(var_b834cfed17d314a3, item.quantity));
    }

    var_2e72cf01652b5bd[var_2e72cf01652b5bd.size] = [var_99ca2650c284f5c3, var_89955e781d50267a, var_b834cfed17d314a3, loadoutindex, loadouttype, var_f53ae6184f353b7];
  }

  foreach(item in var_2e72cf01652b5bd) {
    var_a4f8448f29141288 = item[0];

    foreach(index in item[1]) {
      [lootid, quantity] = player function_6738846da50730f1(index);

      if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid)) {
        var_a4f8448f29141288 = quantity;
      }

      player function_db1dd76061352e5b(index, var_a4f8448f29141288);
      var_a4f8448f29141288 -= quantity;

      if(var_a4f8448f29141288 <= 0) {
        break;
      }
    }

    if(istrue(item[5])) {
      scripts\mp\gametypes\dmz_dog_tag::function_bc03aa369196f2bf(player, 0);
      continue;
    }

    if(!isDefined(item[2]) || !isDefined(item[3]) || !isDefined(item[4])) {
      continue;
    }

    function_e59cc32a4f43c5d8(player, item[2], item[4], item[3]);
  }

  scriptablename = recipe.weaponscriptable;

  if(!isDefined(scriptablename)) {
    scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(recipe.lootid);
  }

  result = undefined;

  if(!istrue(recipe.permanent)) {
    result = player scripts\mp\gametypes\br_pickups::lootitem(recipe.lootid, recipe.quantity, recipe.weaponscriptable);
  }

  if(!istrue(result) && !istrue(recipe.permanent)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(player.br_kiosk)) {
      slotindex = player.br_kiosk scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
      player.br_kiosk.dropstruct.dropidx = slotindex;
      dropstruct = player.br_kiosk.dropstruct;
    }

    baseorigin = player.origin;
    baseangles = player.angles;

    if(isDefined(player.br_kiosk)) {
      baseorigin = default_to(player.br_kiosk.centerbottom, player.br_kiosk.origin);
      baseangles = player.br_kiosk.angles;
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player);
    pickup = player scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, recipe.quantity, 1, undefined, 0);
  }

  player scripts\cp_mp\challenges::function_7ba17fb69c312e2c(undefined, scriptablename, recipe.lootid, recipe.quantity, 0);
  return true;
}

function private function_f1c3dc8c80e536c4() {
  level endon("<dev string:x42>");
  player = level.players[0];

  while(true) {
    var_a073d6e49197691f = getdvarint(@ "hash_d0372976df17d33a", 0);
    var_93a9a394196ad59a = getdvarint(@ "hash_df5d1d642bd121d0", 0);
    var_27de9f03f6194b9a = getdvarint(@ "hash_f77ca612090e125b", 0);
    var_d9acb3895ab8440b = getDvar(@ "hash_d61b2e700fcd4a9", "<dev string:x50>");

    if(var_a073d6e49197691f) {
      setDvar(@ "hash_ac9266111b154414", 0);

      if(!isDefined(level.barterrecipes[var_a073d6e49197691f - 1])) {
        waitframe();
        continue;
      }

      var_541d95a3bfa40a1f = level.barterrecipes[var_a073d6e49197691f - 1];
      function_2f1ef432df69a29b(player, var_541d95a3bfa40a1f);
    } else if(var_93a9a394196ad59a) {
      setDvar(@ "hash_df5d1d642bd121d0", 0);

      if(!function_dde2ba6e3e9a30f8(player)) {
        waitframe();
        continue;
      }

      var_541d95a3bfa40a1f = level.barterrecipes[var_93a9a394196ad59a - 1];

      foreach(item in var_541d95a3bfa40a1f.materials) {
        player scripts\mp\gametypes\br_pickups::lootitem(item.lootid, item.quantity, undefined, 1);
      }
    } else if(var_d9acb3895ab8440b != "<dev string:x50>") {
      setDvar(@ "hash_d61b2e700fcd4a9", "<dev string:x50>");

      if(!isDefined(level.br_armory_kiosk) || !isDefined(level.br_armory_kiosk.scriptables)) {
        waitframe();
        continue;
      }

      mindist = 999999999999;
      closestkiosk = undefined;

      foreach(kiosk in level.br_armory_kiosk.scriptables) {
        if(!isDefined(kiosk.origin)) {
          continue;
        }

        currentdist = distance(kiosk.origin, player.origin);

        if(currentdist < mindist) {
          mindist = currentdist;
          closestkiosk = kiosk;
        }
      }

      if(isDefined(closestkiosk)) {
        if(var_27de9f03f6194b9a) {
          function_c661afd69dc6cb4d(player, closestkiosk, var_d9acb3895ab8440b);
        } else {
          function_45eefc63956143ed(closestkiosk, var_d9acb3895ab8440b);
        }
      }
    }

    waitframe();
  }
}

# /