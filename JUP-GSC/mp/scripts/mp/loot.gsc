/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\loot.gsc
***********************************************/

#using script_2d9d24f7c63ac143;
#using script_4a6760982b403bad;
#using script_55e418c5cc946593;
#using script_728ffcee8cbf30ee;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace loot;

function init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  var_725f93c8f8f7cf9d = getdvarint(@ "hash_d8d8d08bfd9ec4df", 30);
  var_ef5b044960434f17 = getdvarint(@ "hash_17fe9acebdd2352", 5);
  level.var_de221bfb117f1fd1 = var_725f93c8f8f7cf9d * var_725f93c8f8f7cf9d;
  level.var_ef5b044960434f17 = var_ef5b044960434f17 * var_ef5b044960434f17;
}

function getpassivesforweapon(weaponbasename, variantid) {
  lootinfo = getlootinfoforweapon(weaponbasename, variantid);

  if(isDefined(lootinfo)) {
    return lootinfo.passives;
  }

  return undefined;
}

function getlootinfoforweapon(weaponbasename, variantid) {
  if(!isDefined(variantid)) {
    return undefined;
  }

  if(isDefined(level.lootweaponcache[weaponbasename]) && isDefined(level.lootweaponcache[weaponbasename][variantid])) {
    weaponinfo = level.lootweaponcache[weaponbasename][variantid];
    return weaponinfo;
  }

  weaponinfo = cachelootweaponweaponinfo(weaponbasename, variantid);

  if(isDefined(weaponinfo)) {
    return weaponinfo;
  }

  return undefined;
}

function getweaponassetfromrootweapon(rootweaponname, variantid) {
  varianttable = "mp/loot/weapon/" + rootweaponname + ".csv";
  weaponasset = tablelookup(varianttable, 0, variantid, 3);
  assertex(isDefined(weaponasset) && weaponasset != "<dev string:x1c>", "<dev string:x20>" + rootweaponname + "<dev string:x51>" + variantid);
  return weaponasset;
}

function lookupvariantref(rootweaponname, variantid) {
  varianttable = "mp/loot/weapon/" + rootweaponname + ".csv";
  variantref = tablelookup(varianttable, 0, variantid, 1);
  assertex(isDefined(variantref) && variantref != "<dev string:x1c>", "<dev string:x66>" + rootweaponname + "<dev string:x51>" + variantid);
  return variantref;
}

function isweaponitem(lootitemid) {
  itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootitemid);
  return isDefined(itemtype) && itemtype == "weapon";
}

function iskillstreakitem(lootitemid) {
  itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootitemid);
  return isDefined(itemtype) && itemtype == "weapon";
}

function cachelootweaponweaponinfo(weaponbasename, variantid) {
  if(!isDefined(weaponbasename)) {
    return undefined;
  }

  if(!isDefined(level.lootweaponcache[weaponbasename])) {
    level.lootweaponcache[weaponbasename] = [];
  }

  var_c6c779c138e8c65 = getweaponloottable(weaponbasename);
  weaponinfo = readweaponinfofromtable(var_c6c779c138e8c65, variantid, weaponbasename);
  level.lootweaponcache[weaponbasename][variantid] = weaponinfo;
  return weaponinfo;
}

function readweaponinfofromtable(tablepath, variantid, weaponbasename) {
  struct = spawnStruct();
  weaponroot = scripts\cp_mp\weapon::getweaponrootname(weaponbasename);
  ref = weaponroot + "|" + variantid;
  struct.ref = ref;
  struct.weaponasset = level.weaponlootmapdata[ref].assetname;
  struct.variantid = variantid;
  return struct;
}

function getweaponqualitybyid(weapon, variantid) {
  if(!isDefined(variantid) || variantid < 0) {
    return 0;
  }

  var_c6c779c138e8c65 = getweaponloottable(weapon);
  quality = int(tablelookup(var_c6c779c138e8c65, 0, variantid, 4));
  return quality;
}

function isvalidslot(opener, container, itemindex, overridecontents) {
  contents = ter_op(isDefined(overridecontents), overridecontents, container.contents);

  if(!isDefined(contents[itemindex])) {
    return false;
  }

  item = contents[itemindex];
  quantity = item["quantity"];
  lootid = item["lootID"];
  team = item["team"];
  visibilitycondition = item["visibilityCondition"];

  if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(visibilitycondition) || [[visibilitycondition]](opener, container))) {
    return true;
  }

  return false;
}

function isvalidloadoutslot(opener, container, itemindex) {
  if(!isDefined(container.loadoutcontents[itemindex])) {
    return false;
  }

  item = container.loadoutcontents[itemindex];
  quantity = item["quantity"];
  lootid = item["lootID"];
  team = item["team"];
  visibilitycondition = item["visibilityCondition"];

  if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(visibilitycondition) || [[visibilitycondition]](opener, container))) {
    return true;
  }

  return false;
}

function function_2581f2ab21309779(container) {
  if(!isDefined(container.containertype)) {
    return 1;
  }

  switch (container.containertype) {
    case 13:
    case 14:
    case 15:
      return 0;
    default:
      return 1;
  }
}

function function_61c51bd9656a843d(opener, container, var_fab72763a744c649) {
  loadoutcontents = container.loadoutcontents;

  if(!isDefined(var_fab72763a744c649)) {
    var_fab72763a744c649 = [];
  }

  if(!isDefined(container.var_3aadf7a3cc811358)) {
    container.var_3aadf7a3cc811358 = [];
  }

  if(isDefined(loadoutcontents)) {
    foreach(itemindex, item in loadoutcontents) {
      lootid = 0;
      quantity = 0;

      if(isDefined(item["lootID"])) {
        lootid = item["lootID"];
        quantity = item["quantity"];
      }

      if(lootid == 0 || quantity == 0) {
        continue;
      }

      newquantity = getautopickupquantity(opener, lootid, quantity);

      if(newquantity != quantity) {
        currentsize = var_fab72763a744c649.size;
        var_fab72763a744c649[currentsize] = spawnStruct();
        var_fab72763a744c649[currentsize].index = itemindex + 11;
        var_fab72763a744c649[currentsize].var_c79d6d2f755eb27e = quantity;
        var_fab72763a744c649[currentsize].lootid = lootid;
        container.var_3aadf7a3cc811358[currentsize] = itemindex;
      }
    }
  }

  return var_fab72763a744c649;
}

function getautopickupquantity(opener, lootid, quantity) {
  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(lootname)) {
    return quantity;
  }

  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount) || maxcount == 0) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getAutoPickupQuantity")) {
    result = scripts\mp\gametypes\br_gametypes::function_d72afaccedfc946e("getAutoPickupQuantity", lootid, lootname, quantity, maxcount);

    if(isDefined(result)) {
      return result;
    }
  }

  if(maxcount > 0 && isDefined(lootid)) {
    for(i = 0; i < namespace_aead94004cf4c147::getplayerbackpacksize(opener); i++) {
      currentlootid = opener namespace_aead94004cf4c147::getlootidatbackpackindex(i);

      if(currentlootid == lootid) {
        slotquantity = opener namespace_aead94004cf4c147::getquantityatbackpackindex(i);

        if(slotquantity < maxcount) {
          return int(max(0, slotquantity + quantity - maxcount));
        }
      }
    }
  }

  if(scripts\mp\gametypes\br_public::isammo(lootname)) {
    var_509d86412c9d7426 = opener getweaponslistprimaries();

    foreach(weap in var_509d86412c9d7426) {
      ammotypecomparison = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weap);

      if(isDefined(ammotypecomparison) && lootname == ammotypecomparison && opener.br_ammo[lootname] < level.var_e6ea72fc5e3fcd00[lootname]) {
        return int(max(0, opener.br_ammo[lootname] + quantity - level.var_e6ea72fc5e3fcd00[lootname]));
      }
    }
  }

  if(scripts\mp\gametypes\br_public::isarmorplate(lootname)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(opener.equipment[slot]) || opener scripts\mp\gametypes\br_pickups::equipmentslothasroom(lootname, slot)) {
      var_5324597edfaff57c = opener scripts\mp\equipment::getequipmentslotammo(slot);
      var_5324597edfaff57c = ter_op(isDefined(var_5324597edfaff57c), var_5324597edfaff57c, 0);
      var_b5cdf4d935e6ac13 = opener scripts\mp\equipment::getequipmentmaxammo(equipname);
      return int(max(0, var_5324597edfaff57c + quantity - var_b5cdf4d935e6ac13));
    }
  }

  if(scripts\mp\gametypes\br_pickups::function_b989edd9af4f42c7(lootname) || scripts\mp\gametypes\br_pickups::function_d7c5786a0c42ef6c(lootname)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;

    if(opener scripts\mp\gametypes\br_pickups::pickupissameasequipmentslot(equipname, slot) && opener scripts\mp\gametypes\br_pickups::equipmentslothasroom(lootname, slot)) {
      var_5324597edfaff57c = opener scripts\mp\equipment::getequipmentslotammo(slot);
      var_5324597edfaff57c = ter_op(isDefined(var_5324597edfaff57c), var_5324597edfaff57c, 0);
      var_b5cdf4d935e6ac13 = opener scripts\mp\equipment::getequipmentmaxammo(equipname);
      return int(max(0, var_5324597edfaff57c + quantity - var_b5cdf4d935e6ac13));
    }
  }

  if(scripts\mp\gametypes\br_pickups::isplunder(lootname)) {
    if(isDefined(opener.plundercount) && isDefined(level.br_plunder.plunderlimit) && opener.plundercount >= level.br_plunder.plunderlimit) {
      return quantity;
    }

    var_7eddf19f11da2f94 = default_to(opener.plundercount, 0);
    maxplunder = default_to(level.br_plunder.plunderlimit, var_7eddf19f11da2f94 + quantity);
    return int(max(0, var_7eddf19f11da2f94 + quantity - maxplunder));
  }

  return quantity;
}

function function_57c0f59f64f553fa(opener, container, items, parentcontainer) {
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  container endon("closed");
  level endon("game_ended");
  waittime = 0.55;
  var_e88566cf37c5687e = getdvarfloat(@ "hash_d9e519d9c89af2f3", 0);

  if(var_e88566cf37c5687e > 0) {
    waittime = var_e88566cf37c5687e + 0.2;
  }

  var_677b4d98122f0868 = getdvarfloat(@ "hash_12b0e0c79ccf572d", 0);

  if(var_677b4d98122f0868 > 0) {
    waittime = 0.35 + var_677b4d98122f0868;

    if(var_e88566cf37c5687e > 0) {
      waittime = var_e88566cf37c5687e + var_677b4d98122f0868;
    }
  }

  var_ed396a07b4c75932 = getdvarint(@ "hash_ab7929439577c576", 1);
  wait waittime;

  foreach(item in items) {
    if(!isreallyalive(opener) || !iscontaineropen(opener) || iscontainerempty(container, opener)) {
      if(isDefined(container.var_73fb94c9aedcc497)) {
        container.var_73fb94c9aedcc497 = [];
      }

      if(isDefined(container.var_3aadf7a3cc811358)) {
        container.var_3aadf7a3cc811358 = [];
      }

      return;
    }

    if(!isDefined(item) || !isDefined(item.lootid) || !isDefined(item.var_c79d6d2f755eb27e) || !isDefined(item.index)) {
      continue;
    }

    if(!function_7eda25c90cc3aaa1(item.index) && !isvalidslot(opener, container, item.index)) {
      continue;
    }

    if(function_7eda25c90cc3aaa1(item.index) && !isvalidloadoutslot(opener, container, item.index - 11)) {
      continue;
    }

    itemtaken = 0;

    if(isDefined(container.contents)) {
      foreach(content in container.contents) {
        if(function_7eda25c90cc3aaa1(item.index)) {
          break;
        }

        currentlootid = content["lootID"];

        if(isDefined(currentlootid) && currentlootid == item.lootid) {
          quantity = content["quantity"];
          newquantity = getautopickupquantity(opener, item.lootid, quantity);

          if(quantity != newquantity) {
            itemtaken = 1;
            function_9d924aea120c2693(opener, item.index, container);
            var_97c23a1323acc7df = quantity - newquantity;
            assertex(var_97c23a1323acc7df >= 0, "<dev string:x96>" + currentlootid);

            if(var_97c23a1323acc7df < 0) {
              continue;
            }

            function_2f00ca0526f3edc6(opener, item.index, var_97c23a1323acc7df, parentcontainer, 1);

            if(isDefined(container) && iscontainerempty(container, opener) && iscontaineropen(opener)) {
              closelootablecontainer(container, opener);
            }

            if(!var_ed396a07b4c75932) {
              wait getdvarfloat(@ "hash_f920b46a5250c2a9", 0.33);
            }
          }
        }
      }
    }

    if(function_7eda25c90cc3aaa1(item.index) && isDefined(container.loadoutcontents)) {
      for(i = 0; i < container.loadoutcontents.size; i++) {
        if(!isDefined(container.loadoutcontents[i])) {
          continue;
        }

        currentlootid = container.loadoutcontents[i]["lootID"];

        if(isDefined(currentlootid) && currentlootid == item.lootid) {
          quantity = container.loadoutcontents[i]["quantity"];
          newquantity = getautopickupquantity(opener, item.lootid, quantity);

          if(quantity != newquantity) {
            itemtaken = 1;
            function_9d924aea120c2693(opener, item.index, container);
            var_97c23a1323acc7df = quantity - newquantity;
            function_2f00ca0526f3edc6(opener, item.index, var_97c23a1323acc7df, parentcontainer, 1);

            if(isDefined(container) && iscontainerempty(container, opener) && iscontaineropen(opener)) {
              closelootablecontainer(container, opener);
            }

            if(!var_ed396a07b4c75932) {
              wait getdvarfloat(@ "hash_f920b46a5250c2a9", 0.33);
            }
          }
        }
      }
    }

    if(itemtaken && var_ed396a07b4c75932) {
      wait getdvarfloat(@ "hash_f920b46a5250c2a9", 0.33);
    }
  }

  if(isDefined(container.var_73fb94c9aedcc497)) {
    container.var_73fb94c9aedcc497 = [];
  }

  if(isDefined(container.var_3aadf7a3cc811358)) {
    container.var_3aadf7a3cc811358 = [];
  }
}

function getlootweaponref(lootitemid) {
  return level.lootweaponrefs[lootitemid];
}

function function_3a712642b82f6f2(scriptablename) {
  if(!isDefined(scriptablename)) {
    return 8;
  }

  if(scripts\mp\gametypes\br_pickups::isrevivepickup(scriptablename)) {
    return 0;
  }

  if(scripts\mp\gametypes\br_pickups::iskillstreak(scriptablename)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::isarmorplate(scriptablename)) {
    return 2;
  }

  if(scripts\mp\gametypes\br_public::function_4aa12e0ed3f6b745(scriptablename)) {
    return 3;
  }

  if(scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scriptablename)) {
    return 4;
  }

  if(scripts\mp\gametypes\br_pickups::issuperpickup(scriptablename)) {
    return 5;
  }

  if(scripts\mp\gametypes\br_public::isequipment(scriptablename)) {
    return 6;
  }

  if(scripts\mp\gametypes\br_public::isammo(scriptablename)) {
    return 7;
  }

  return 8;
}

function function_c01727794cd72a1c(itema, itemb) {
  if(!isDefined(itema) || !isDefined(itemb)) {
    return true;
  }

  if(!istrue(itema["lootID"]) || !istrue(itemb["lootID"]) || !istrue(itema["quantity"]) || !istrue(itemb["quantity"])) {
    return true;
  }

  prioritya = function_3a712642b82f6f2(scripts\cp_mp\utility\loot::getscriptablefromlootid(itema["lootID"]));
  priorityb = function_3a712642b82f6f2(scripts\cp_mp\utility\loot::getscriptablefromlootid(itemb["lootID"]));
  return prioritya < priorityb;
}

function openlootablecontainer(opener, container) {
  parentcontainer = container;

  if(function_e3081772bbf7a51c(opener, container)) {
    parentcontainer = container;
    container = function_3aae4431f00c347f(opener, container);
    container.origin = parentcontainer.origin;
    container.angles = parentcontainer.angles;
  }

  if(function_54066dbd8ef44fe1(container) && getdvarint(@ "hash_ab065f0da94d8ff", 1)) {
    [items, lastvalidindex] = function_438749eb7a7b738(container.contents, opener, container);
    container.contents = items;
    container.contents = array_sort_with_func(container.contents, &function_c01727794cd72a1c);
  }

  weaponcount = 0;

  for(itemindex = 0; itemindex < 11; itemindex++) {
    if(isvalidslot(opener, container, itemindex)) {
      if(isweaponitem(container.contents[itemindex]["lootID"])) {
        tmp = container.contents[weaponcount];
        container.contents[weaponcount] = container.contents[itemindex];
        container.contents[itemindex] = tmp;
        weaponcount++;
      }
    }
  }

  items = container.contents;
  opener.var_2fa5b49969def47 = parentcontainer;
  opener.var_f2aa9ae949179907 = opener.origin;
  parentcontainer.opener = opener;

  if(isPlayer(opener)) {
    opener function_41e759de50f883dc(items, parentcontainer.containertype);
  }

  if(isDefined(container.linkedparent)) {
    opener.var_f2aa9ae949179907 = rotatevectorinverted(opener.origin - parentcontainer.linkedparent.origin, parentcontainer.linkedparent.angles);
  }

  if(items.size > 11) {
    println("<dev string:xd7>" + items.size + "<dev string:x10e>" + 11 + "<dev string:x12a>");
  }

  var_fab72763a744c649 = [];
  var_4472b62c1fa150e5 = 0;
  container.var_73fb94c9aedcc497 = [];

  for(itemindex = 0; itemindex < 11; itemindex++) {
    if(isvalidslot(opener, container, itemindex)) {
      newquantity = items[itemindex]["quantity"];

      if(getdvarint(@ "hash_c272dfd858eba88f", 1) && function_2581f2ab21309779(parentcontainer)) {
        newquantity = getautopickupquantity(opener, items[itemindex]["lootID"], items[itemindex]["quantity"]);
      }

      function_446c7ad7bcc70992(opener, container, itemindex, items[itemindex]["lootID"], items[itemindex]["quantity"], items[itemindex]["ref"]);

      if(newquantity != items[itemindex]["quantity"]) {
        currentsize = var_fab72763a744c649.size;
        var_fab72763a744c649[currentsize] = spawnStruct();
        var_fab72763a744c649[currentsize].index = itemindex;
        var_fab72763a744c649[currentsize].var_c79d6d2f755eb27e = items[itemindex]["quantity"];
        var_fab72763a744c649[currentsize].lootid = items[itemindex]["lootID"];

        if(!opener function_b73431b8e7ae9204()) {
          container.var_73fb94c9aedcc497[currentsize] = itemindex;
        }
      }

      continue;
    }

    function_c7294f5b9b5006d5(opener, itemindex);
  }

  if(isDefined(container.weaponslotcontents)) {
    function_62ad0c002d54cbcc(opener, container, "loot_container_weapon", container.weaponslotcontents, container.weaponslotobj);
  } else {
    opener setclientomnvar("loot_container_weapon", 0);
  }

  if(!isDefined(parentcontainer.containertype)) {
    parentcontainer.containertype = 1;
  }

  containertype = parentcontainer.containertype;

  if(containertype == 6) {
    if(isDefined(parentcontainer.owner) && isDefined(parentcontainer.owner.team) && isDefined(opener.team) && parentcontainer.owner.team == opener.team && isDefined(parentcontainer.owner.sessionuimemberindex)) {
      containertype = 7 + parentcontainer.owner.sessionuimemberindex;
    }

    if(isDefined(parentcontainer.deadplayerindex)) {
      opener setclientomnvar("loot_container_dead_player_index", parentcontainer.deadplayerindex);
    }
  }

  if(function_54066dbd8ef44fe1(parentcontainer)) {
    owner = parentcontainer.owner;

    if(isDefined(parentcontainer.deadplayerindex)) {
      opener setclientomnvar("loot_container_dead_player_index", parentcontainer.deadplayerindex);
    }

    if(isDefined(parentcontainer.backpacksize)) {
      opener setclientomnvar("loot_container_dead_player_backpack_size", parentcontainer.backpacksize);
    }

    if(scripts\engine\utility::issharedfuncdefined("dmz_bosses", "onBackpackOpen")) {
      opener[[scripts\engine\utility::getsharedfunc("dmz_bosses", "onBackpackOpen")]](parentcontainer);
    }

    var_fab72763a744c649 = function_61c51bd9656a843d(opener, container, var_fab72763a744c649);
    function_46bf6f4d9dcc9b78(opener, container);
  }

  if(var_fab72763a744c649.size > 0 && !opener function_b73431b8e7ae9204()) {
    thread function_57c0f59f64f553fa(opener, container, var_fab72763a744c649, parentcontainer);
  }

  opener setclientomnvar("loot_container_open", containertype);

  if(istrue(level.var_a101059dea76957c) && !istrue(parentcontainer.previouslyopened) && parentcontainer.containertype != 13 && parentcontainer.containertype != 15 && parentcontainer.containertype != 17 && parentcontainer.containertype != 18 && parentcontainer.containertype != 19 && !function_54066dbd8ef44fe1(parentcontainer)) {
    parentcontainer.previouslyopened = 1;

    if(!isDefined(opener.containerslooted)) {
      opener.containerslooted = 0;
    }

    opener.containerslooted++;
    thread function_86d77b1dbd44b06e(opener, parentcontainer, var_4472b62c1fa150e5);
  }

  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  parentcontainer.dropstruct = dropstruct;
  function_e01065f2c8e19b09(container, opener);

  if(opener function_b73431b8e7ae9204()) {
    container thread function_576b46dbf8366fe3(container, opener, var_fab72763a744c649, parentcontainer);
  }

  parentcontainer thread function_71a59f067d5fe986(parentcontainer, opener);
  parentcontainer thread function_47b931d76ffd028f(parentcontainer, opener);

  if(function_e3081772bbf7a51c(opener, container)) {
    container.playercontents[opener.guid].contents = items;
  }

  opener scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_41e759de50f883dc(items, container_type) {
  if(!isDefined(items)) {
    return;
  }

  if(!isDefined(items.size) || items.size <= 0) {
    return;
  }

  current_team = "unset";

  if(isDefined(self.sessionteam)) {
    current_team = self.sessionteam;
  }

  if(isDefined(self.team)) {
    current_team = self.team;
  }

  lpconlevel = "0";

  if(isDefined(level.var_a7b62649c81b481a) && isDefined(level.var_a7b62649c81b481a.var_acc161de36707de2)) {
    lpconlevel = scripts\engine\utility::string(level.var_a7b62649c81b481a.var_acc161de36707de2);
  }

  itemids = [];
  itemcounts = [];

  foreach(item in items) {
    itemcounts[itemids.size] = scripts\engine\utility::string(item["quantity"]);
    itemids[itemids.size] = scripts\engine\utility::string(item["lootID"]);
  }

  data = spawnStruct();
  data.player = self;
  data.current_team = current_team;
  data.x = self.origin[0];
  data.y = self.origin[1];
  data.z = self.origin[2];
  data.xrot = self.angles[0];
  data.yrot = self.angles[1];
  data.zrot = self.angles[2];
  data.lpconlevel = lpconlevel;
  data.matchtimeelapsed = int(scripts\mp\utility\game::getsecondspassed());
  data.itemids = itemids;
  data.itemcounts = itemcounts;
  data.container_type = container_type;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_dmz_on_container", data);
}

function function_576b46dbf8366fe3(container, opener, var_fab72763a744c649, parentcontainer) {
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  container endon("closed");
  level endon("game_ended");
  startdelay = 0.5;
  pickupdelay = 0.2;
  currentindex = 0;
  wait startdelay;

  while(opener activatekeypressed() && iscontaineropen(opener) && currentindex < 11 && isreallyalive(opener) && !iscontainerempty(container, opener)) {
    if(isvalidslot(opener, container, currentindex)) {
      scriptablename = opener scripts\cp_mp\utility\loot::getscriptablefromlootid(container.contents[currentindex]["lootID"]);
      var_25978461c6e4f61b = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(container.contents[currentindex]["lootID"]);
      equipitem = 0;
      stowweapon = 0;
      var_5fa12dc278a8f1ba = 0;

      if(scripts\mp\gametypes\br_pickups::function_b989edd9af4f42c7(scriptablename) || scripts\mp\gametypes\br_pickups::function_d7c5786a0c42ef6c(scriptablename)) {
        equipname = level.br_pickups.br_equipname[scriptablename];
        slot = level.equipment.table[equipname].defaultslot;

        if(opener scripts\mp\gametypes\br_pickups::pickupissameasequipmentslot(equipname, slot)) {
          if(opener scripts\mp\gametypes\br_pickups::equipmentslothasroom(scriptablename, slot)) {
            equipitem = 1;
          }
        } else if(!isDefined(opener scripts\mp\equipment::getcurrentequipment(slot)) || opener scripts\mp\equipment::getequipmentslotammo(slot) == 0) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::isweaponpickup(scriptablename)) {
        var_5fa12dc278a8f1ba = 1;

        foreach(weaponobj in opener.primaryinventory) {
          if(weaponobj.basename == "iw9_me_fists_mp") {
            equipitem = 1;
            break;
          }
        }

        if(!equipitem && !namespace_aead94004cf4c147::function_efab78b72d131d76(opener) && namespace_aead94004cf4c147::getplayerbackpacksize(opener) >= 7) {
          stowweapon = 1;
        }
      } else if(scripts\mp\gametypes\br_public::function_4aa12e0ed3f6b745(scriptablename)) {
        carrierlevel = scripts\mp\gametypes\br_public::function_692c3df266580df6(scriptablename);

        if(carrierlevel > opener.platecarrierlevel) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_public::isarmorplate(scriptablename)) {
        equipitem = 1;
      } else if(scripts\mp\gametypes\br_pickups::iskillstreak(scriptablename)) {
        if(!opener scripts\mp\gametypes\br_pickups::hasanykillstreak()) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::isgasmask(scriptablename)) {
        if(!isDefined(opener.gasmaskhealth)) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scriptablename)) {
        playerbackpacksize = namespace_aead94004cf4c147::getplayerbackpacksize(opener);
        var_d5af812b9411dcc4 = namespace_aead94004cf4c147::function_3188d9c94b3d56c2(scriptablename);

        if(playerbackpacksize < var_d5af812b9411dcc4) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::isrevivepickup(scriptablename)) {
        if(!opener scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
          equipitem = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::issuperpickup(scriptablename)) {
        if(!opener namespace_aead94004cf4c147::function_5e7049647595ab97()) {
          equipitem = 1;
        }
      }

      if(var_25978461c6e4f61b == "cash") {
        function_9d924aea120c2693(opener, currentindex, container);
        function_2f00ca0526f3edc6(opener, currentindex, container.contents[currentindex]["quantity"], container, 1);
        wait pickupdelay;
      } else if(equipitem) {
        opener function_3ae3712fe76d0c6a(opener, currentindex, 0, container);
        wait pickupdelay;
      } else if(stowweapon) {
        opener function_f0617ad70b7e7792(0, 100, container);
        wait pickupdelay;
      } else if(!var_5fa12dc278a8f1ba && (scripts\mp\gametypes\br_public::isammo(scriptablename) || opener namespace_aead94004cf4c147::canitemfitinbackpack(container.contents[currentindex]["lootID"], container.contents[currentindex]["quantity"]))) {
        opener function_601d9afc257af3ff(opener, currentindex, container);
        wait pickupdelay;
      }
    }

    currentindex++;
  }

  if(var_fab72763a744c649.size > 0 && currentindex < 11 && iscontaineropen(opener)) {
    thread function_57c0f59f64f553fa(opener, container, var_fab72763a744c649, parentcontainer);
    return;
  }

  if(isDefined(container) && iscontainerempty(container, opener) && iscontaineropen(opener)) {
    closelootablecontainer(container, opener);
  }
}

function function_e01065f2c8e19b09(container, opener) {
  assert(isDefined(opener) && isDefined(container));

  if(isDefined(level.gamemodebundle)) {
    if(isDefined(level.gamemodebundle.var_d7b78a1323b4009f) && level.gamemodebundle.var_d7b78a1323b4009f != "") {
      playsoundatpos(opener.origin + (0, 0, 24), level.gamemodebundle.var_d7b78a1323b4009f);
    }
  }

  function_63981aa3be7d52ae(opener, container.origin);
}

function function_63981aa3be7d52ae(player, origin) {
  function_afe5cda1a4ed9d11("examine_loot", player, origin);
}

function function_438749eb7a7b738(items, opener, container) {
  assert(isDefined(items));
  validitems = [];
  firstindex = 0;
  lastindex = items.size - 1;

  foreach(item in items) {
    quantity = item["quantity"];
    lootid = item["lootID"];
    team = item["team"];
    visibilitycondition = item["visibilityCondition"];

    if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(visibilitycondition) || [[visibilitycondition]](opener, container))) {
      validitems[firstindex] = item;
      firstindex++;
      continue;
    }

    validitems[lastindex] = item;
    lastindex--;
  }

  return [validitems, lastindex];
}

function function_c7294f5b9b5006d5(player, index) {
  player setclientomnvar("loot_container_item_" + index, 0);
  player setclientomnvar("loot_container_quantity_" + index, 0);
  player setclientomnvar("loot_container_type_" + index, 0);
}

function function_47b931d76ffd028f(container, opener) {
  container endon("death");
  level endon("game_ended");
  container endon("closed");
  opener waittill_any_4("close_container", "flashbang", "concussed", "weapon_fired");
  closelootablecontainer(container, opener);
}

function function_825b88a376d4be6f(startingforward, opener) {
  if(!isDefined(opener) || !isDefined(opener getplayerangles())) {
    return true;
  }

  newforward = anglesToForward(opener getplayerangles());
  return math::anglebetweenvectors(startingforward, newforward) > 20;
}

function function_9fb5b05ed3f94474(container, opener, framesstill) {
  closedistance = level.var_de221bfb117f1fd1;

  if(framesstill > 2 && getdvarint(@ "hash_419fd2f09b23942a", 1)) {
    closedistance = level.var_ef5b044960434f17;
  }

  if(isDefined(container.linkedparent)) {
    newoffset = rotatevectorinverted(opener.origin - container.linkedparent.origin, container.linkedparent.angles);

    if(distancesquared(opener.var_f2aa9ae949179907, newoffset) > closedistance) {
      return false;
    }
  } else if(distancesquared(opener.var_f2aa9ae949179907, opener.origin) > closedistance) {
    return false;
  }

  return true;
}

function function_f5765dcf987b7720(container, opener, startingforward, framesstill) {
  if(istrue(opener.isdisconnecting)) {
    return false;
  }

  if(!isreallyalive(opener)) {
    return false;
  }

  if(function_f3557caf4562bff7(container) && istrue(container.loadoutcontainer)) {
    return true;
  }

  if(!isDefined(opener.origin)) {
    return false;
  }

  if(!function_9fb5b05ed3f94474(container, opener, framesstill)) {
    return false;
  }

  if(function_825b88a376d4be6f(startingforward, opener)) {
    return false;
  }

  if(opener playerads() > 0.5) {
    return false;
  }

  return true;
}

function function_71a59f067d5fe986(container, opener) {
  container endon("death");
  level endon("game_ended");
  container endon("closed");
  startingforward = anglesToForward(opener getplayerangles());
  framesstill = 0;

  while(function_f5765dcf987b7720(container, opener, startingforward, framesstill)) {
    if(getdvarint(@ "hash_419fd2f09b23942a", 1)) {
      if(lengthsquared(opener getvelocity()) == 0) {
        if(framesstill == 0) {
          if(isDefined(container.linkedparent)) {
            opener.var_f2aa9ae949179907 = rotatevectorinverted(opener.origin - container.linkedparent.origin, container.linkedparent.angles);
          } else {
            opener.var_f2aa9ae949179907 = opener.origin;
          }
        }

        framesstill++;
        framesstill = int(min(framesstill, getdvarint(@ "hash_aea0716d0a0f790a", 6)));
      } else {
        framesstill--;
        framesstill = int(max(framesstill, 0));
      }
    }

    waitframe();
  }

  closelootablecontainer(container, opener);
}

function closelootablecontainer(container, opener) {
  if(isDefined(opener)) {
    opener setclientomnvar("loot_container_open", 0);
  }

  if(!isDefined(container)) {
    return;
  }

  function_6cd112326d215e1f(opener, container);
  container.opener = undefined;
  partname = container function_ec5f4851431f3382();

  if(iscontainerempty(container, opener)) {
    if(scripts\mp\gametypes\br_lootcache::function_6759ff16e552aa94(container) || scripts\mp\gametypes\br_lootcache::isplayerbackpack(container) || scripts\mp\teamrevive::function_5b55070c02328ea7(container)) {
      container notify("death");
      container freescriptable();
    } else {
      function_932e5252b650e475(opener, container);
    }
  } else if(function_f3557caf4562bff7(container)) {
    if(isreallyalive(opener) && istrue(container.loadoutcontainer) && isDefined(container.contents) && container.contents.size > 0) {
      lootid = undefined;
      quantity = undefined;

      foreach(item in container.contents) {
        lootid = item["lootID"];
        quantity = item["quantity"];
        break;
      }

      if(!(container.itemtype == 6 && istrue(opener.var_ca27f3fd3dad0c1f))) {
        if(isDefined(lootid) && isDefined(quantity) && lootid != 0 && quantity > 0) {
          opener scripts\mp\gametypes\br_pickups::equipitem(lootid, quantity);
        }
      } else {
        scripts\mp\gametypes\br_headgear::resetgasmaskremovaldelay();
      }

      scripts\mp\gametypes\br_pickups::loothide(container);
      return;
    } else {
      foreach(player in level.players) {
        container enablescriptableplayeruse(player);
      }
    }
  } else if(!function_532eac3c428e5b9b(container)) {
    if(container getscriptableparthasstate(partname, "partially_open_usable")) {
      state = container getscriptablepartstate(partname);

      if(!isDefined(state)) {
        logstring("Log this in IW9-396144: state is undefined, container.type = " + ter_op(isDefined(container.type), container.type, "undefined") + ", partName = " + partname);
      }

      if(state == "partially_open_in_use_unusable" || state == "partially_reopen_in_use_unusable") {
        container setscriptablepartstate(partname, "partially_open_usable");
      } else if(state == "partially_opening_unusable") {
        container thread function_d3e618521013c7eb();
      } else if(!function_e3081772bbf7a51c(opener, container) && state != "partially_open_usable" && state != "closing") {
        assert("<dev string:x12f>");
      }
    }
  }

  if(isDefined(container.var_ceb543956c7203e7)) {
    [[container.var_ceb543956c7203e7]](container, opener);
  }

  if(getdvarint(@ "hash_c85a9bcc06a81a1f", 0) && isDefined(container.var_2568210352be1ecf) && container.var_2568210352be1ecf.size > 0) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(container.dropstruct)) {
      dropstruct = container.dropstruct;
    }

    foreach(index, item in container.var_2568210352be1ecf) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, opener.origin, opener.angles, opener, undefined);
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item["lootID"]);
      scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, item["quantity"], 1, undefined, 0);
      opener.var_2fa5b49969def47.contents[index]["lootID"] = 0;
      opener.var_2fa5b49969def47.contents[index]["quantity"] = 0;
    }

    container.var_2568210352be1ecf = undefined;
  }

  if(isDefined(container.dropstruct)) {
    container.dropstruct = undefined;
  }

  opener.var_2fa5b49969def47 = undefined;
  container notify("closed");
  opener scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_d3e618521013c7eb() {
  self endon("death");
  level endon("game_ended");
  partname = self function_ec5f4851431f3382();
  waitframe();

  while(self getscriptablepartstate(partname) == "partially_opening_unusable") {
    waitframe();
  }

  self setscriptablepartstate(partname, "partially_open_usable");
}

function iscontaineropen(player) {
  return player getclientomnvar("loot_container_open") > 0;
}

function function_73d8c72e055e8640(player) {
  if(!iscontaineropen(player)) {
    return false;
  }

  if(!isDefined(player.var_2fa5b49969def47)) {
    return false;
  }

  if(!isDefined(player.var_2fa5b49969def47.containertype)) {
    return false;
  }

  if(player.var_2fa5b49969def47.containertype != 14) {
    return false;
  }

  if(!isDefined(player.var_2fa5b49969def47.contents)) {
    return false;
  }

  foreach(item in player.var_2fa5b49969def47.contents) {
    if(isDefined(item["lootID"])) {
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item["lootID"]);

      if(isDefined(scriptablename) && scripts\mp\gametypes\br_pickups::function_e4b6260dbb04b43d(scriptablename)) {
        return true;
      }
    }
  }

  return false;
}

function function_6cd112326d215e1f(opener, container) {
  container = function_59b9c8081b873a10(opener, container);

  if(!isDefined(container.var_7f52190fa265244c)) {
    return;
  }

  foreach(var_8eb93a779d9df6f7 in container.var_7f52190fa265244c) {
    function_a1054a8c2bc6c36d(var_8eb93a779d9df6f7);
  }

  container.var_7f52190fa265244c = [];
}

function function_7ef8fa0b69da782a(var_8db5472153ea4811) {
  bitsused = 31;

  if(bitsused > 31) {
    assertmsg("<dev string:x1a8>");
    return undefined;
  }

  var_25cdf28fdb105d24 = spawnStruct();
  lootidmask = 1048576 - 1;
  var_25cdf28fdb105d24.lootid = lootidmask &var_8db5472153ea4811;
  var_8db5472153ea4811 >>= 20;
  var_b1a98c6b10f6e8c1 = 2048 - 1;
  var_25cdf28fdb105d24.extrapayload = var_b1a98c6b10f6e8c1 &var_8db5472153ea4811;
  var_8db5472153ea4811 >>= 11;
  assert(var_8db5472153ea4811 == 0);
  return var_25cdf28fdb105d24;
}

function function_c4858170624b6caf(lootid, extrapayload) {
  if(!isDefined(lootid)) {
    lootid = 0;
  }

  assert(lootid >= 0 && lootid < 1048576);

  if(!isDefined(extrapayload)) {
    extrapayload = 0;
  }

  assert(extrapayload >= 0 && extrapayload < 2048);
  var_8db5472153ea4811 = 0;
  bitsused = 31;

  if(bitsused > 31) {
    assertmsg("<dev string:x20a>");
    return var_8db5472153ea4811;
  }

  var_8db5472153ea4811 |= extrapayload;
  var_8db5472153ea4811 <<= 20;
  var_8db5472153ea4811 |= lootid;
  return var_8db5472153ea4811;
}

function function_d6a3266145bab76d(var_8c24a642e5abba4e) {
  player = self;
  assert(isPlayer(player));
  var_22937f7da36b4b8f = player getclientomnvar(var_8c24a642e5abba4e);

  if(!isDefined(var_22937f7da36b4b8f)) {
    return 0;
  }

  var_bd62f58e765fffd5 = function_7ef8fa0b69da782a(var_22937f7da36b4b8f);
  var_b7ef0bd383c9dbaf = var_bd62f58e765fffd5.lootid;
  return var_b7ef0bd383c9dbaf;
}

function function_62ad0c002d54cbcc(player, container, var_142ee196b1c70723, lootid, weapon) {
  var_8eb93a779d9df6f7 = undefined;

  if(isDefined(lootid) && lootid != 0) {
    if(!isDefined(weapon)) {
      scriptabledefname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
      assert(isDefined(scriptabledefname));
      var_8eb93a779d9df6f7 = function_51f396445baa7fa6(scriptabledefname);
    } else if(isweapon(weapon)) {
      weaponclasstoken = scripts\cp_mp\weapon::getweaponclasstoken(weapon.basename);
      scriptabledefname = "brloot_weapon_generic_" + weaponclasstoken;
      var_8eb93a779d9df6f7 = function_51f396445baa7fa6(scriptabledefname, weapon);
    } else {
      assert(isstring(weapon));
      scriptabledefname = weapon;
      var_8eb93a779d9df6f7 = function_51f396445baa7fa6(scriptabledefname);
    }
  }

  if(isDefined(var_8eb93a779d9df6f7) && var_8eb93a779d9df6f7 != 0) {
    assert(isDefined(container));

    if(!isDefined(container.var_7f52190fa265244c)) {
      container.var_7f52190fa265244c = [];
    }

    container.var_7f52190fa265244c[container.var_7f52190fa265244c.size] = var_8eb93a779d9df6f7;
  }

  var_453ae8156fbdc0de = function_c4858170624b6caf(lootid, var_8eb93a779d9df6f7);
  player setclientomnvar(var_142ee196b1c70723, var_453ae8156fbdc0de);
}

function function_446c7ad7bcc70992(player, container, index, lootid, quantity, scriptabledefname) {
  if(function_c26e54ffd0c8be94(container, index)) {
    function_b1423adeced14528(player, index - 11, lootid, quantity);
    return;
  }

  typename = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);
  typedata = undefined;

  if(isDefined(typename)) {
    typedata = level.lootmaster[typename];
  }

  if(lootid == 0) {
    function_c7294f5b9b5006d5(player, index);
    return;
  }

  if(isDefined(typedata)) {
    if(typedata.typename == "weapon") {
      function_62ad0c002d54cbcc(player, container, "loot_container_item_" + index, lootid, scriptabledefname);
    } else {
      player setclientomnvar("loot_container_item_" + index, lootid);
    }

    player setclientomnvar("loot_container_quantity_" + index, quantity);
    player setclientomnvar("loot_container_type_" + index, typedata.typevalue);

    if(quantity > 4095) {
      logstring("IW9-690092: Item quantity too large for loot ID: " + lootid);
    }

    return;
  }

  println("<dev string:x260>" + lootid + "<dev string:x12a>");
}

function function_7eda25c90cc3aaa1(index) {
  return index >= 11 && index <= 20;
}

function function_c26e54ffd0c8be94(container, index) {
  return function_7eda25c90cc3aaa1(index) && function_54066dbd8ef44fe1(container);
}

function getloadoutdoublebackpacklootid(container, index, var_cc768ff46f3f6339) {
  if(isDefined(container) && isDefined(container.var_3aadf7a3cc811358) && array_contains(container.var_3aadf7a3cc811358, index) && !istrue(var_cc768ff46f3f6339)) {
    return 0;
  }

  if(isDefined(container) && isDefined(container.loadoutcontents) && isDefined(container.loadoutcontents[index]) && isDefined(container.loadoutcontents[index]["lootID"])) {
    return container.loadoutcontents[index]["lootID"];
  }

  return 0;
}

function function_dc8d7c1709adcd67(container, index, var_cc768ff46f3f6339) {
  if(isDefined(container) && isDefined(container.var_3aadf7a3cc811358) && array_contains(container.var_3aadf7a3cc811358, index) && !istrue(var_cc768ff46f3f6339)) {
    return 0;
  }

  if(isDefined(container) && isDefined(container.loadoutcontents) && isDefined(container.loadoutcontents[index]) && isDefined(container.loadoutcontents[index]["quantity"])) {
    return container.loadoutcontents[index]["quantity"];
  }

  return 0;
}

function function_7f855164a30a5f5f(player) {
  player setclientomnvar("loot_container_loadout_weapon_id", 0);
  player setclientomnvar("loot_container_loadout_weapon_attachments", 0);
  player setclientomnvar("loot_container_loadout_weapon_ammo", 0);
}

function function_9b4ad636bec4278d(player, lootid, quantity) {
  gasmasktype = 0;
  gasmaskhealth = 0;

  if(!(lootid == 0 || quantity == 0)) {
    gasmaskhealth = quantity;
    scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

    if(scriptablename == "brloot_equip_gasmask_durable") {
      gasmasktype = 3;
    } else if(scriptablename == "brloot_equip_gasmask_scuba") {
      gasmasktype = 4;
    } else {
      gasmasktype = 2;
    }
  }

  player setclientomnvar("loot_container_loadout_gasmask_id", gasmasktype);
  player setclientomnvar("loot_container_loadout_gasmask_quantity", gasmaskhealth);
}

function function_b1423adeced14528(player, index, lootid, quantity) {
  if(lootid == 0 || quantity == 0) {
    lootid = 0;
    quantity = 0;
  }

  switch (index) {
    case 0:
      player setclientomnvar("loot_container_loadout_plunder_quantity", quantity);
      break;
    case 1:
      player setclientomnvar("loot_container_loadout_lethal_id", lootid);
      player setclientomnvar("loot_container_loadout_lethal_quantity", quantity);
      break;
    case 2:
      player setclientomnvar("loot_container_loadout_tactical_id", lootid);

      if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid)) {
        quantity = 1;
      }

      player setclientomnvar("loot_container_loadout_tactical_quantity", quantity);
      break;
    case 3:
      player setclientomnvar("loot_container_loadout_armor_quantity", quantity);
      break;
    case 6:
      function_9b4ad636bec4278d(player, lootid, quantity);
      break;
    case 7:
      player setclientomnvar("loot_container_loadout_revive", quantity);
      break;
    case 5:
      player setclientomnvar("loot_container_loadout_super_id", lootid);
      break;
    case 4:
      player setclientomnvar("loot_container_loadout_killstreak_id", lootid);
      break;
    case 8:
      if(lootid == 0 || quantity == 0) {
        player setclientomnvar("loot_container_loadout_dogtag_tier", 0);
        break;
      }

      if(lootid == 26140) {
        player setclientomnvar("loot_container_loadout_dogtag_tier", 5);
        player setclientomnvar("loot_container_loadout_dogtag_quantity", 1);
        break;
      }

      tier = scripts\mp\gametypes\dmz_dog_tag::function_2d2f7e8a6547ae42(lootid);
      player setclientomnvar("loot_container_loadout_dogtag_tier", tier + 1);
      player setclientomnvar("loot_container_loadout_dogtag_quantity", quantity);
      break;
    case 9:
      player setclientomnvar("loot_container_loadout_backpack", lootid);
    default:
      break;
  }
}

function function_46bf6f4d9dcc9b78(player, container) {
  loadoutcontents = container.loadoutcontents;

  if(isDefined(loadoutcontents)) {
    foreach(index, item in loadoutcontents) {
      lootid = 0;
      quantity = 0;

      if(isDefined(item["lootID"])) {
        lootid = item["lootID"];
        quantity = item["quantity"];
      }

      function_b1423adeced14528(player, index, lootid, quantity);
    }
  }

  if(isDefined(container.var_a06e7128c001851d) && isDefined(container.var_a0e9fef038504bd0)) {
    weaponslotid = container.var_a06e7128c001851d;
    weaponobj = container.var_a0e9fef038504bd0;
    attachments = getweaponattachments(weaponobj);
    attachmentcount = 0;

    foreach(attachment in attachments) {
      if(!scripts\mp\utility\weapon::attachmentisselectable(weaponobj, attachment)) {
        continue;
      }

      attachmentcount++;
    }

    function_62ad0c002d54cbcc(player, container, "loot_container_loadout_weapon_id", weaponslotid, weaponobj);
    player setclientomnvar("loot_container_loadout_weapon_attachments", attachmentcount);
    player setclientomnvar("loot_container_loadout_weapon_ammo", player getweaponammoclip(weaponobj));
  }
}

function getlootidatcontainerindex(player, index, container, var_cc768ff46f3f6339) {
  if(isDefined(container) && isDefined(container.var_73fb94c9aedcc497) && array_contains(container.var_73fb94c9aedcc497, index) && !istrue(var_cc768ff46f3f6339)) {
    return 0;
  }

  slotlootid = undefined;

  if(index == 100) {
    slotlootid = player function_d6a3266145bab76d("loot_container_weapon");
  } else {
    slotlootid = player function_d6a3266145bab76d("loot_container_item_" + index);
  }

  return slotlootid;
}

function function_8e5978971b5dcd16(player, index, container, var_cc768ff46f3f6339) {
  if(isDefined(container) && isDefined(container.var_73fb94c9aedcc497) && array_contains(container.var_73fb94c9aedcc497, index) && !istrue(var_cc768ff46f3f6339)) {
    return 0;
  }

  if(index == 100) {
    return 1;
  }

  return player getclientomnvar("loot_container_quantity_" + index);
}

function iscontainerempty(container, opener) {
  if(function_532eac3c428e5b9b(container)) {
    return false;
  }

  container = function_59b9c8081b873a10(opener, container);

  if(!isDefined(container.contents)) {
    return true;
  }

  contents = container.contents;

  foreach(content in contents) {
    if(!isDefined(content["lootID"]) || !isDefined(content["quantity"])) {
      continue;
    }

    if(content["lootID"] > 0 && content["quantity"] > 0) {
      return false;
    }
  }

  if(isDefined(container.customweaponname)) {
    return false;
  }

  if(istrue(container.weaponslotcontents)) {
    return false;
  }

  if(function_54066dbd8ef44fe1(container)) {
    if(isDefined(container.loadoutcontents)) {
      foreach(content in container.loadoutcontents) {
        if(!isDefined(content["lootID"]) || !isDefined(content["quantity"])) {
          continue;
        }

        if(content["lootID"] > 0 && content["quantity"] > 0) {
          return false;
        }
      }
    }

    if(isDefined(container.var_a0e9fef038504bd0)) {
      return false;
    }
  }

  return true;
}

function function_60d2295ccc45d8c0(player, lootid, quantity, container) {
  if(isDefined(quantity) && quantity < 0) {
    return;
  }

  method = scripts\cp_mp\challenges::function_6d40f12a09494350(0, function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"loot"));
  scriptablename = container.type;
  containertype = container.containertype;

  if(isDefined(containertype) && (containertype == 2 || containertype == 6 || containertype >= 7 && containertype <= 12)) {
    method = scripts\cp_mp\challenges::function_6d40f12a09494350(method, function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"backpack"));
  } else {
    method = scripts\cp_mp\challenges::function_6d40f12a09494350(method, function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"cache"));
  }

  lootsource = 0;
  issupplydrop = 0;

  if(isDefined(scriptablename)) {
    switch (scriptablename) {
      case #"hash_3b6111354af78459":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"hash_b7d4384f34a1807f"));
        break;
      case #"hash_469a90a45e97eda9":
      case #"hash_50e52e4dc37fb7a8":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"medicine_cabinet"));
        break;
      case #"hash_44904bb5898785d9":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"pc_cache"));
        break;
      case #"hash_61f36140da68c992":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"supply_drop"));
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"hash_8f2ebe6038c7957d"));
        issupplydrop = 1;
        break;
      case #"hash_993262832973e0d":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"supply_drop"));
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"hash_bc50426fe5f0eab1"));
        issupplydrop = 1;
        break;
      case #"hash_1a50c41f80fb532b":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"weapon_locker"));
        break;
      case #"hash_763609926e3b8ed":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"duffel_bag"));
        break;
      case #"hash_93553b29704c0d3":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"cash_register"));
        break;
      case #"hash_2808ce3c4558142d":
        lootsource = scripts\cp_mp\challenges::function_6d40f12a09494350(lootsource, function_e2ff8f4b4e94f723(#"loot_source", #"cash_register"));
        break;
      case #"hash_5fe210289499bd6e":
        issupplydrop = 1;
        break;
      default:
        break;
    }
  }

  if(issupplydrop) {
    function_ce5d71baed479274(player, container);
  }

  if(function_7ba31cb6b21c346f()) {
    if(player function_c28d94289c4a6ecd(container, lootid)) {
      player thread function_36edf91561322753(3);
    }
  }

  scripts\cp_mp\challenges::function_d24138b32084fc3e(player, lootid, undefined, method, quantity, lootsource);
  player notify("looted_item", lootid, quantity, 0);

  if(!game_utility::isbrstylegametype()) {
    scripts\mp\gametypes\br_pickups::function_acddab6fa6e914a(player, player.origin);
  }
}

function function_ce5d71baed479274(looter, container) {
  var_7ecbd4f07f6882d0 = getdvarint(@ "hash_a1e254e5a2b575d7", 1) == 1;
  var_ba03253452037335 = 0;
  players = scripts\mp\utility\teams::getteamdata(looter.team, "players");

  if(isDefined(container)) {
    if(isDefined(container.openedby)) {
      if(!var_7ecbd4f07f6882d0) {
        var_243d9ea347100ef1 = 0;

        foreach(player in players) {
          if(array_contains(container.openedby, player)) {
            var_243d9ea347100ef1 = 1;
            break;
          }
        }

        if(!var_243d9ea347100ef1) {
          container.openedby = array_combine_unique(container.openedby, players);
          var_ba03253452037335 = 1;
        }
      }
    } else {
      container.openedby = [];
      container.openedby = array_combine_unique(container.openedby, players);
      var_ba03253452037335 = 1;
    }
  }

  if(!var_ba03253452037335) {
    return;
  }

  foreach(player in players) {
    if(!isDefined(player.supplydropsopened)) {
      player.supplydropsopened = 0;
    }

    player.supplydropsopened++;
    player scripts\mp\utility\points::doscoreevent(#"hash_9a68d11b1688325a");
  }
}

function function_f3557caf4562bff7(container) {
  if(!isDefined(container) || !isDefined(container.containertype)) {
    return false;
  }

  return container.containertype == 14;
}

function function_532eac3c428e5b9b(container) {
  if(!isDefined(container.containertype)) {
    return false;
  }

  return container.containertype == 13 || container.containertype == 15 || container.containertype == 17 || container.containertype == 18 || container.containertype == 19;
}

function function_54066dbd8ef44fe1(container) {
  if(!isDefined(container.containertype)) {
    return false;
  }

  return container.containertype == 16 || container.containertype == 6 || container.containertype >= 7 && container.containertype <= 12;
}

function function_86d77b1dbd44b06e(opener, container, var_4472b62c1fa150e5) {
  level endon("game_ended");
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  container endon("death");
  waittime = 0.35;
  overridetime = getdvarfloat(@ "hash_d9e519d9c89af2f3", 0);

  if(overridetime > 0) {
    waittime = overridetime;
  }

  container waittill_any_timeout_1(waittime, "closed");

  if(!isreallyalive(opener)) {
    return;
  }

  if(var_4472b62c1fa150e5) {
    specialxpoverride = getdvarint(hashcat(@ "scr_", scripts\mp\utility\game::getsubgametype(), "_lootingSpecialXPOverride"), 0);

    if(specialxpoverride == 0) {
      specialxpoverride = undefined;
    }

    opener thread scripts\mp\utility\points::doscoreevent(#"hash_f396d39fee1a8054", undefined, undefined, specialxpoverride);
    opener playsoundtoplayer("uin_loot_container_open_epic", opener);
    return;
  }

  xpoverride = getdvarint(hashcat(@ "scr_", scripts\mp\utility\game::getsubgametype(), "_lootingXPOverride"), 0);

  if(xpoverride == 0) {
    xpoverride = undefined;
  }

  opener thread scripts\mp\utility\points::doscoreevent(#"br_cacheOpen", undefined, undefined, xpoverride);
  opener playsoundtoplayer("uin_loot_container_open_common", opener);
}

function function_1791c1e8974e9bd7(player, lootid, quantity, weaponref, var_cc768ff46f3f6339, overridedist, overrideorigin, var_4a08890fd43d6bc7) {
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  success = 0;

  if(ref == "cash") {
    var_3466c10973e9c476 = scripts\mp\gametypes\br_plunder::getplundernamebyamount(quantity);
    fakepickup = spawnStruct();
    fakepickup.scriptablename = var_3466c10973e9c476;
    fakepickup.var_8598d3d3bc3d9ceb = 1;
    fakepickup.count = quantity;
    player scripts\mp\gametypes\br_pickups::playpickupfeedback(fakepickup);
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(quantity, undefined, undefined, 1);
    player scripts\cp_mp\challenges::onpickupitem("plunder");
    success = 1;
  } else if(ref == "dmz_loot_quest_intel" || ref == "dmz_trap_quest_trigger") {
    player scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, undefined, 1);
    success = 1;
  } else if(scripts\mp\gametypes\br_public::isammo(ref)) {
    success = player scripts\mp\gametypes\br_pickups::function_54dac56d15dd3d93(ref, lootid, quantity, 1);
  } else if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid) && scripts\mp\gametypes\dmz_dog_tag::function_d9f5c5090de1241b(player, quantity)) {
    [victimindex, _] = scripts\mp\gametypes\dmz_dog_tag::getdogtagvictimandkiller(quantity);
    dogtagowner = level.dogtaginfo[victimindex].player;

    if(isDefined(dogtagowner)) {
      scripts\mp\gametypes\dmz_dog_tag::function_8e643d6706defeea(dogtagowner, quantity);
    }

    if(!isDefined(dogtagowner) || dogtagowner != player) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_recover_dog_tag", [player], undefined);
    }

    success = 1;
  } else if(istrue(isweaponitem(lootid))) {
    var_4a08890fd43d6bc7 = istrue(var_4a08890fd43d6bc7) && namespace_aead94004cf4c147::getplayerbackpacksize(player) >= 7 && !namespace_aead94004cf4c147::function_efab78b72d131d76(player);
    success = player scripts\mp\gametypes\br_pickups::lootitem(lootid, quantity, weaponref, 1, undefined, undefined, overridedist, overrideorigin, var_cc768ff46f3f6339, var_4a08890fd43d6bc7);
  } else {
    success = player scripts\mp\gametypes\br_pickups::lootitem(lootid, quantity, weaponref, 1, !istrue(var_cc768ff46f3f6339), undefined, overridedist, overrideorigin, var_cc768ff46f3f6339);
  }

  return success;
}

function function_a335aa664caa37c9(player, container) {
  if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    return;
  }

  lootid = namespace_aead94004cf4c147::function_d9b1550011525161(player);
  parentcontainer = container;
  container = function_59b9c8081b873a10(player, container);

  if(!isDefined(container.weaponslotobj)) {
    return;
  }

  var_c161ec212069668d = 1;

  foreach(weaponobj in player.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      var_c161ec212069668d = 0;
      break;
    }
  }

  if(var_c161ec212069668d && namespace_aead94004cf4c147::function_efab78b72d131d76(player)) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return;
  }

  function_60d2295ccc45d8c0(player, lootid, 1, parentcontainer);

  if(!var_c161ec212069668d) {
    scripts\mp\loot::function_a92926d5b02cf6ed(player, parentcontainer);
    return;
  }

  [_, weaponobj, pastteam, metadata, _, _, _] = function_775a7fc396485a9a(player, container);
  namespace_aead94004cf4c147::function_e35a7cb7e7c8c17e(player, weaponobj, undefined, metadata);
  scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(player, 2, pastteam);
  function_505e8eb7e77704c5(player, parentcontainer);
  player playsoundtoplayer("br_pickup_weap", player);
}

function function_2f00ca0526f3edc6(player, index, quantity, container, var_cc768ff46f3f6339) {
  lootid = 0;
  itemquantity = 0;
  [lootid, itemquantity] = function_edb397974ae6ee68(player, container, index, var_cc768ff46f3f6339);

  if(lootid == 0 || itemquantity == 0) {
    return;
  }

  weaponref = function_4b96aa12974840c0(player, container, index);
  sameweapon = undefined;
  var_4a08890fd43d6bc7 = undefined;

  if(isDefined(weaponref)) {
    if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
      return;
    }

    fakepickup = spawnStruct();
    fakepickup.scriptablename = weaponref;
    var_4a08890fd43d6bc7 = 1;
    newweapon = scripts\mp\gametypes\br_weapons::function_55c5d35c8c76a95b(fakepickup)[0];

    foreach(weap in self.primaryweapons) {
      if(issameweapon(weap, newweapon)) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(newweapon));
        itemquantity = weaponclipsize(newweapon);
        quantity = itemquantity;
        sameweapon = 1;
        break;
      }
    }
  }

  itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  if(isDefined(itemref) && itemref == "cash") {
    playerplunder = default_to(player.plundercount, 0);
    maxplunder = default_to(level.br_plunder.plunderlimit, playerplunder + itemquantity);

    if(playerplunder + itemquantity > level.br_plunder.plunderlimit) {
      quantity = level.br_plunder.plunderlimit - playerplunder;
    }
  }

  if(!isDefined(quantity)) {
    quantity = itemquantity;
  }

  assert(itemquantity >= quantity, "<dev string:x28d>");

  if(lootid == 0 || quantity == 0) {
    return 1;
  }

  overridedist = distance2d(container.origin, player.origin) / 2;
  overrideorigin = undefined;

  if(function_f3557caf4562bff7(container)) {
    overrideorigin = container.origin;
  }

  success = function_1791c1e8974e9bd7(player, lootid, quantity, weaponref, var_cc768ff46f3f6339, overridedist, overrideorigin, var_4a08890fd43d6bc7);

  if(success || istrue(sameweapon)) {
    newquantity = itemquantity - quantity;
    newlootid = lootid;
    function_60d2295ccc45d8c0(player, newlootid, quantity, container);

    if(scripts\engine\utility::issharedfuncdefined("pmc_missions", "onContainerLooted")) {
      [[scripts\engine\utility::getsharedfunc("pmc_missions", "onContainerLooted")]](player, newlootid, quantity, container);
    }

    function_153d3281e46e14da(player, container, index, newlootid, newquantity);
    function_f3c9e05d4767d037(lootid, player, container, index);
  }

  return success;
}

function function_a92926d5b02cf6ed(player, container, itemtype, overridedist) {
  if(!isDefined(container)) {
    return 1;
  }

  if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    return;
  }

  [_, weaponslotobj, pastteam, metadata, quantity, altquantity, lefthandquantity] = function_775a7fc396485a9a(player, container);

  if(!isDefined(weaponslotobj)) {
    return 1;
  }

  weapon = weaponslotobj;

  foreach(weap in self.primaryweapons) {
    if(issameweapon(weap, weapon)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  if(namespace_aead94004cf4c147::function_efab78b72d131d76(player)) {
    weaponslotweapon = namespace_aead94004cf4c147::function_2985254128b1c262(player);

    if(issameweapon(weaponslotweapon, weapon)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  quantity = default_to(quantity, weaponclipsize(weapon));
  overrideorigin = undefined;

  if(function_f3557caf4562bff7(container)) {
    overrideorigin = container.origin;
  }

  scripts\mp\gametypes\br_pickups::equipweapon(weapon, quantity, undefined, altquantity, undefined, undefined, metadata, overridedist, overrideorigin, undefined, lefthandquantity);
  weaponindex = scripts\mp\gametypes\br_weapons::function_2ab3bda08c595a32(player, weapon);

  if(isDefined(weaponindex)) {
    scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(player, weaponindex, pastteam);
  }

  scripts\engine\utility::callsharedfunc("pmc_missions", "onPickupWeapon", player, weaponslotobj, metadata);
  function_505e8eb7e77704c5(player, container);

  if(function_f3557caf4562bff7(container)) {
    player setclientomnvar("loot_container_open", 0);
    container notify("closed");
    scripts\mp\gametypes\br_pickups::loothide(container);
  }
}

function function_3ae3712fe76d0c6a(player, index, loadoutindex, container) {
  lootid = 0;
  quantity = 0;
  overridedist = distance2d(container.origin, self.origin) / 2;

  if(function_c3d68fb7b175edd(player, container) && loadoutindex != 0) {
    function_e183b2e94298bb75(loadoutindex, player, container, 0);
  } else {
    [lootid, quantity] = function_edb397974ae6ee68(player, container, index);
  }

  if(lootid == 0 || quantity == 0) {
    return;
  }

  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  if(function_430df78a3a4143c1(player, container, index)) {
    ref = container.contents[index]["ref"];
  }

  pickupremains = 0;

  if(scripts\mp\gametypes\br_public::isammo(ref)) {
    var_bada25504e8844d7 = spawnStruct();
    var_bada25504e8844d7.scriptablename = ref;
    var_bada25504e8844d7.count = quantity;

    if(function_f3557caf4562bff7(container)) {
      var_bada25504e8844d7.origin = container.origin;
    }

    player namespace_aead94004cf4c147::additemtobackpack(lootid, var_bada25504e8844d7);
  } else if(scripts\mp\gametypes\br_pickups::function_5449da9d3d0358a4(ref)) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.var_fde0e27b3a09bf3);
    return;
  } else if(function_430df78a3a4143c1(player, container, index)) {
    if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
      return;
    }

    overrideorigin = undefined;

    if(function_f3557caf4562bff7(container)) {
      overrideorigin = container.origin;
    }

    if(loadoutindex > 0) {
      scripts\mp\gametypes\br_pickups::quickdropweapon(player, 1, loadoutindex - 1, undefined, 0, 0, overridedist, overrideorigin);
    }

    weaponobj = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname(ref);
    quantity = weaponclipsize(weaponobj);
    success = scripts\mp\gametypes\br_pickups::equipweapon(weaponobj, quantity, undefined, undefined, undefined, undefined, undefined, overridedist, overrideorigin, undefined, quantity);

    if(scripts\engine\utility::issharedfuncdefined("pmc_missions", "onPickupWeapon")) {
      [[scripts\engine\utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, weaponobj);
    }

    if(!istrue(success)) {
      return;
    }
  } else {
    var_6a80b9f81cd7ad99 = undefined;

    if(getdvarint(@ "hash_1903ee79b0fffb17", 0)) {
      var_6a80b9f81cd7ad99 = namespace_aead94004cf4c147::getavailabledmzbackpackindex();
    }

    overrideorigin = undefined;

    if(function_f3557caf4562bff7(container)) {
      overrideorigin = container.origin;
    }

    pickupremains = scripts\mp\gametypes\br_pickups::equipitem(lootid, quantity, var_6a80b9f81cd7ad99, undefined, undefined, undefined, overridedist, overrideorigin);

    if(!isDefined(pickupremains)) {
      return;
    }
  }

  function_60d2295ccc45d8c0(player, lootid, quantity, container);

  if(function_f3557caf4562bff7(container)) {
    player setclientomnvar("loot_container_open", 0);
    container notify("closed");
    scripts\mp\gametypes\br_pickups::loothide(container);
    return;
  }

  originallootid = lootid;
  lootid = ter_op(pickupremains == 0, 0, lootid);
  function_153d3281e46e14da(player, container, index, lootid, quantity);
  function_f3c9e05d4767d037(originallootid, player, container, index);
}

function function_f0617ad70b7e7792(containerslot, backpackslot, container) {
  if(!isalive(self)) {
    return;
  }

  if(function_f3557caf4562bff7(container) && isDefined(self.var_e0c39101bfc15d2) && istrue(self.var_e0c39101bfc15d2[backpackslot])) {
    self setclientomnvar("loot_container_open", 0);
    container notify("closed");
    return;
  }

  if(backpackslot == 100) {
    if(istrue(self.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
      return;
    }

    if(scripts\engine\utility::issharedfuncdefined("pmc_missions", "onPickupWeapon")) {
      [[scripts\engine\utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](self);
    }

    if(namespace_aead94004cf4c147::function_efab78b72d131d76(self)) {
      var_fcbb55496a5ba4cb = namespace_aead94004cf4c147::function_2985254128b1c262(self);
      backpackweaponname = getcompleteweaponname(var_fcbb55496a5ba4cb);
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

      if(isDefined(container.dropstruct)) {
        dropstruct = container.dropstruct;
      }

      overrideorigin = undefined;

      if(function_f3557caf4562bff7(container)) {
        overrideorigin = container.origin;
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, overrideorigin);
      item = scripts\mp\gametypes\br_pickups::spawnpickup(backpackweaponname, dropinfo, 1, 1, var_fcbb55496a5ba4cb, 0);
      weaponmetadata = undefined;

      if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
        weaponmetadata = namespace_a38a2e1fe7519183::function_74031e3249a6f69e(self, 2);

        if(isDefined(weaponmetadata)) {
          item.metadata = weaponmetadata;
        }
      }

      item.pastteam = scripts\mp\gametypes\br_weapons::function_86a5c7670325346b(self, 2);
      namespace_aead94004cf4c147::function_954372d604277278(self);
    }

    [lootid, weaponobj, pastteam, metadata, quantity, _, lefthandquantity] = function_775a7fc396485a9a(self, container, containerslot);

    if(!isDefined(weaponobj)) {
      return;
    }

    quantity = default_to(quantity, weaponclipsize(weaponobj));
    self setweaponammoclip(weaponobj, quantity);

    if(scripts\mp\utility\weapon::isakimbo(weaponobj)) {
      lefthandquantity = default_to(lefthandquantity, weaponclipsize(weaponobj));
      self setweaponammoclip(weaponobj, lefthandquantity, "left");
    }

    namespace_aead94004cf4c147::function_e35a7cb7e7c8c17e(self, weaponobj, 1);
    scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(self, 2, pastteam);

    if(scripts\engine\utility::issharedfuncdefined("pmc_missions", "onPickupWeapon")) {
      [[scripts\engine\utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](self, weaponobj, metadata);
    }

    function_505e8eb7e77704c5(self, container, containerslot);
    return;
  }

  [containerlootid, containerquantity] = function_edb397974ae6ee68(self, container, containerslot);
  var_b358c0df5898a29b = scripts\cp_mp\utility\loot::getscriptablefromlootid(containerlootid);
  [backpacklootid, backpackquantity] = namespace_aead94004cf4c147::function_6738846da50730f1(backpackslot);
  var_2789584b4d4cb228 = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpacklootid);
  var_ab2190c9f802c652 = isDefined(var_b358c0df5898a29b) && namespace_708f627020de59d3::function_43044da0ed44d79f(var_b358c0df5898a29b);
  var_fa65d19c2d55b80d = isDefined(var_2789584b4d4cb228) && namespace_708f627020de59d3::function_43044da0ed44d79f(var_2789584b4d4cb228);
  var_3c295612e84d714 = isDefined(var_2789584b4d4cb228) && scripts\mp\gametypes\br_pickups::function_e4b6260dbb04b43d(var_2789584b4d4cb228);

  if(function_f3557caf4562bff7(container) && scripts\engine\utility::issharedfuncdefined(backpacklootid, "canQuickDrop")) {
    if(!scripts\engine\utility::callsharedfunc(backpacklootid, "canQuickDrop", self)) {
      self setclientomnvar("loot_container_open", 0);
      container notify("closed");
      scripts\mp\hud_message::showerrormessage(level.br_pickups.var_58d0559b458fd450);
      return;
    }
  }

  if(var_fa65d19c2d55b80d) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(container.dropstruct)) {
      dropstruct = container.dropstruct;
    }

    overrideorigin = undefined;

    if(function_f3557caf4562bff7(container)) {
      overrideorigin = container.origin;
    }

    namespace_708f627020de59d3::function_3af23b0bfaf91dbd(dropstruct, undefined, undefined, backpackslot, overrideorigin);
  } else if(var_3c295612e84d714) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(container.dropstruct)) {
      dropstruct = container.dropstruct;
    }

    overrideorigin = undefined;

    if(function_f3557caf4562bff7(container)) {
      overrideorigin = container.origin;
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, overrideorigin);
    namespace_6c622b52017c6808::function_3a7809be256adadb(dropinfo, self);
    element = scripts\mp\gametypes\br_pickups::spawnpickup(var_2789584b4d4cb228, dropinfo, backpackquantity, 1, undefined, 0);
    namespace_6c622b52017c6808::function_a5130b39363778b7(self, element, backpackslot);
  } else if(scripts\mp\gametypes\br_pickups::function_282d89f7705a2d63(var_2789584b4d4cb228)) {
    scripts\mp\gametypes\br_pickups::function_bfc82c27ed3d9308(backpacklootid, backpackquantity, var_2789584b4d4cb228, backpackslot);
  }

  namespace_aead94004cf4c147::function_db1dd76061352e5b(backpackslot, backpackquantity);
  fakepickup = spawnStruct();
  fakepickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(containerlootid);
  fakepickup.count = containerquantity;
  fakepickup.var_8598d3d3bc3d9ceb = 1;
  fakepickup.origin = container.origin;
  fakepickup.dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  fakepickup.instance = container;

  if(istrue(self.var_ca27f3fd3dad0c1f) && isDefined(container.itemtype) && container.itemtype == 6) {
    fakepickup.count = scripts\mp\gametypes\br_headgear::function_5109f3947b0c7dfb("gas_mask", self);
  }

  if(scripts\mp\gametypes\br_pickups::function_2d86ba79a58bb62(fakepickup.scriptablename)) {
    fakepickup.blacksite = container.blacksite;
    fakepickup.originalteam = container.originalteam;
  }

  if(var_ab2190c9f802c652) {
    namespace_708f627020de59d3::function_1ca82d98d7519e1f(backpackslot, container);
    quantity = 1;
    var_99d72c999b9a85fa = 0;

    if(isDefined(container.perks)) {
      [quantity, var_99d72c999b9a85fa] = scripts\mp\gametypes\br_pickups::function_b29b252cdfa9a7d6(container.perks);
    }

    namespace_aead94004cf4c147::function_11f48ae5b87b4525(self, backpackslot, containerlootid, quantity, var_99d72c999b9a85fa);
  } else if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(containerlootid) && scripts\mp\gametypes\dmz_dog_tag::function_d9f5c5090de1241b(self, containerquantity)) {
    [victimindex, _] = scripts\mp\gametypes\dmz_dog_tag::getdogtagvictimandkiller(containerquantity);
    dogtagowner = level.dogtaginfo[victimindex].player;

    if(isDefined(dogtagowner)) {
      scripts\mp\gametypes\dmz_dog_tag::function_8e643d6706defeea(dogtagowner, containerquantity);
    }

    if(!isDefined(dogtagowner) || dogtagowner != self) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_recover_dog_tag", [self], undefined);
    }
  } else {
    namespace_aead94004cf4c147::additemtobackpack(containerlootid, fakepickup);
    scripts\mp\gametypes\br_pickups::onpickuptakenintobackpack(fakepickup);
    scripts\mp\gametypes\br_pickups::playpickupfeedback(fakepickup);

    if(!function_f3557caf4562bff7(container)) {
      function_60d2295ccc45d8c0(self, containerlootid, containerquantity, container);
    } else {
      scripts\mp\gametypes\br_pickups::function_56dd1faa25a3414f(self, fakepickup, 0, 20);
    }
  }

  if(!getdvarint(@ "hash_8b40bee5a7e0fc04", 0) || function_f3557caf4562bff7(container) || function_54066dbd8ef44fe1(container)) {
    function_153d3281e46e14da(self, container, containerslot, 0, 0);
    maxcount = level.br_pickups.var_4138f9ddc1cd22d[fakepickup.scriptablename];

    if(!isDefined(maxcount) || maxcount == 0) {
      maxcount = level.br_pickups.maxcounts[fakepickup.scriptablename];
    }

    dropstruct = fakepickup.dropstruct;

    if(isDefined(container.dropstruct)) {
      dropstruct = container.dropstruct;
    }

    if(!var_fa65d19c2d55b80d && !var_3c295612e84d714) {
      overrideorigin = undefined;
      dropnewitem = 1;
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(backpacklootid);

      if(function_f3557caf4562bff7(container)) {
        if(getdvarint(@ "hash_8367f78074282ef0", 0) && istrue(container.loadoutcontainer)) {
          loadouttype = level.br_pickups.br_itemtype[fakepickup.scriptablename];
          backpacktype = level.br_pickups.br_itemtype[scriptablename];

          if(isDefined(loadouttype) && isDefined(backpacktype) && loadouttype == backpacktype) {
            scripts\mp\gametypes\br_pickups::equipitem(backpacklootid, backpackquantity);
            dropnewitem = 0;
          }
        }

        if(!istrue(container.loadoutcontainer) && dropstruct.dropcount < 1) {
          overrideorigin = container.origin;
        }
      }

      if(dropnewitem) {
        if(scripts\mp\gametypes\br_pickups::function_2d86ba79a58bb62(scriptablename)) {
          namespace_bd614c3c2275579a::function_f9ff7c89b3792ccc(dropstruct, self.blacksite);
        } else {
          dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, overrideorigin);
          newent = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, backpackquantity, 1, undefined, 0);

          if(isDefined(newent)) {
            scripts\engine\utility::callsharedfunc(scriptablename, "dropped", newent, self, dropinfo.origin);
          }
        }
      }
    }

    if(istrue(self.var_ca27f3fd3dad0c1f)) {
      scripts\mp\gametypes\br_headgear::resetgasmaskremovaldelay();
      scripts\mp\gametypes\br_pickups::function_3ff5a9fd0fa06974(self, 1);
    }
  } else {
    function_153d3281e46e14da(self, container, containerslot, backpacklootid, backpackquantity);

    if(getdvarint(@ "hash_c85a9bcc06a81a1f", 0)) {
      if(!isDefined(container.var_2568210352be1ecf)) {
        container.var_2568210352be1ecf = [];
      }

      container.var_2568210352be1ecf[containerslot] = [];
      container.var_2568210352be1ecf[containerslot]["lootID"] = backpacklootid;
      container.var_2568210352be1ecf[containerslot]["quantity"] = backpackquantity;
    }
  }

  if(function_f3557caf4562bff7(container)) {
    self setclientomnvar("loot_container_open", 0);
    container notify("closed");
    scripts\mp\gametypes\br_pickups::loothide(container);
  }

  function_f3c9e05d4767d037(containerlootid, self, container, containerslot);
}

function function_e183b2e94298bb75(loadoutindex, player, container, itemtype) {
  if(istrue(player.var_859654e0445a36d9) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    return;
  }

  [lootid, weaponslotobj, pastteam, metadata, quantity, _, _] = function_775a7fc396485a9a(player, container);

  if(!isDefined(weaponslotobj)) {
    return;
  }

  scripts\mp\gametypes\br_pickups::quickdropweapon(player, 1, loadoutindex - 1, undefined, 0, 0);
  backpackweaponname = getcompleteweaponname(weaponslotobj);
  var_d8aea6bbfacdff1 = undefined;

  if(isDefined(weaponslotobj.basename)) {
    var_d8aea6bbfacdff1 = weaponslotobj.basename;
  } else {
    var_d8aea6bbfacdff1 = getweaponbasename(weaponslotobj);
  }

  overrideorigin = undefined;

  if(function_f3557caf4562bff7(container)) {
    overrideorigin = container.origin;
  }

  success = scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(player, weaponslotobj, backpackweaponname, var_d8aea6bbfacdff1, undefined, undefined, overrideorigin, undefined, pastteam);

  if(success) {
    weaponslot = 0;
    currentprimary = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, 0);
    currentsecondary = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(player, 1);

    if(isDefined(currentprimary) && currentprimary == weaponslotobj) {
      weaponslot = 0;
    } else if(isDefined(currentsecondary) && currentsecondary == weaponslotobj) {
      weaponslot = 1;
    }

    scripts\engine\utility::callsharedfunc("pmc_missions", "onPickupWeapon", player, weaponslotobj, metadata);
    namespace_a38a2e1fe7519183::function_5d94b2dfabbc4cce(player, weaponslotobj, weaponslot, 1, metadata);
    function_505e8eb7e77704c5(player, container);

    if(function_f3557caf4562bff7(container)) {
      player setclientomnvar("loot_container_open", 0);
      container notify("closed");
      scripts\mp\gametypes\br_pickups::loothide(container);
    }
  }
}

function function_68ca06034b8aaccd(opener, container) {
  [items, lastvalidindex] = function_438749eb7a7b738(container.contents, opener, container);
  container.contents = items;
  opener.var_2fa5b49969def47 = container;
  opener.var_f2aa9ae949179907 = opener.origin;

  if(isDefined(container.linkedparent)) {
    opener.var_f2aa9ae949179907 = rotatevectorinverted(opener.origin - container.linkedparent.origin, container.linkedparent.angles);
  }

  if(items.size > 11) {
    println("<dev string:xd7>" + items.size + "<dev string:x10e>" + 11 + "<dev string:x12a>");
  }

  for(itemindex = 0; itemindex < 11; itemindex++) {
    if(itemindex <= lastvalidindex) {
      function_446c7ad7bcc70992(opener, container, itemindex, items[itemindex]["lootID"], items[itemindex]["quantity"], items[itemindex]["ref"]);
      continue;
    }

    function_c7294f5b9b5006d5(opener, itemindex);
  }

  opener setclientomnvar("loot_container_weapon", 0);

  if(!isDefined(container.containertype)) {
    container.containertype = 1;
  }

  containertype = container.containertype;

  foreach(player in level.players) {
    container disablescriptableplayeruse(player);
  }

  opener setclientomnvar("loot_container_open", containertype);
  container thread function_71a59f067d5fe986(container, opener);
  container thread function_47b931d76ffd028f(container, opener);
  opener scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_601d9afc257af3ff(player, slotindex, container, var_cc768ff46f3f6339, quantity) {
  if(isDefined(container) && function_f3557caf4562bff7(container)) {
    return;
  }

  if(slotindex == 100) {
    function_a335aa664caa37c9(player, container);
  } else {
    function_9d924aea120c2693(player, slotindex, container);
    function_2f00ca0526f3edc6(player, slotindex, quantity, container, var_cc768ff46f3f6339);
  }

  if(isDefined(container) && iscontainerempty(container, player) && iscontaineropen(player)) {
    closelootablecontainer(container, player);
  }
}

function function_e146f016a8a7244f(notification, slotindex) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }

  if(isDefined(notification)) {
    if(!isDefined(self.var_2fa5b49969def47)) {
      return;
    }

    container = self.var_2fa5b49969def47;

    switch (notification) {
      case #"hash_31a47c100531f34f":
        function_601d9afc257af3ff(self, slotindex, container, undefined, 1);
        break;
      case #"hash_b7e2e7e659da3043":
        function_601d9afc257af3ff(self, slotindex, container);
        break;
      case #"hash_453445f0e586a78e":
        loadoutindex = slotindex >> 8;
        itemtype = slotindex & 255;

        if((itemtype == 3 || itemtype == 150) && loadoutindex != 0) {
          function_e183b2e94298bb75(loadoutindex, self, container, itemtype);
        } else if(slotindex == 100 || itemtype == 150) {
          function_a92926d5b02cf6ed(self, container, itemtype);
        } else {
          function_9d924aea120c2693(self, itemtype, container);
          function_3ae3712fe76d0c6a(self, itemtype, loadoutindex, container);
        }

        if(isDefined(container) && iscontainerempty(container, self) && iscontaineropen(self)) {
          closelootablecontainer(container, self);
        }

        break;
      case #"hash_fb84b605789df05e":
        if(isDefined(container)) {
          closelootablecontainer(container, self);
        }

        break;
      case #"hash_10217053947e341b":
        containerslot = slotindex >> 8;
        backpackslot = slotindex & 255;

        if(iscontaineropen(self) && isDefined(container)) {
          function_f0617ad70b7e7792(containerslot, backpackslot, container);
        }

        if(isDefined(container) && iscontainerempty(container, self) && iscontaineropen(self)) {
          closelootablecontainer(container, self);
        }

        break;
      default:
        break;
    }
  }
}

function function_9d924aea120c2693(player, slotindex, container) {
  if(function_c26e54ffd0c8be94(container, slotindex)) {
    return;
  }

  lootid = getlootidatcontainerindex(player, slotindex, container);
  itemquantity = function_8e5978971b5dcd16(player, slotindex, container);

  if(lootid == 0 || itemquantity == 0) {
    return;
  }

  contentscontainer = function_59b9c8081b873a10(player, container);
  contents = contentscontainer.contents;

  if(isDefined(contents[slotindex]) && isDefined(contents[slotindex]["callback"])) {
    thread[[self.var_2fa5b49969def47.contents[slotindex]["callback"]]](self.var_2fa5b49969def47, player);
  }
}

function function_55b384ecb923003e() {
  return default_to(getmatchrulesdata("commonOption", "lootCacheInventoryStrip"), 1) == 1;
}

function function_c929a8ad95b46fda(container) {
  if(isDefined(container.type) && container.type == "br_loot_cache_april") {
    return 0;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && !getdvarint(@ "hash_597831555a246842", 0)) {
    return 1;
  }

  if(isDefined(container.type) && container.type != "br_loot_cache" && container.type != "br_reusable_loot_cache" && container.type != "br_loot_cache_yellow" && container.type != "br_loot_cache_yellow_quiet" && container.type != "br_loot_cache_lege" && container.type != "br_loot_cache_lege_novehiclecollision" && container.type != "br_loot_cache_gulag" && container.type != "br_loot_cache_personal_supply" && container.type != "br_loot_cache_stronghold" && container.type != "br_loot_cache_blacksite" && container.type != "br_loot_cache_bunker" && container.type != "cache_medicine_cabinet" && container.type != "cache_cash_register" && container.type != "cache_cash_register_clean" && container.type != "cache_medical_box_wall" && container.type != "dmz_hidden_container_common" && container.type != "cache_duffel_bag_01" && container.type != "cache_duffel_bag_02" && container.type != "cache_weapon_locker" && container.type != "br_loot_cache_holiday_common" && container.type != "br_loot_cache_holiday_lege" && container.type != "br_loot_cache_holiday_dth" && container.type != "ob_loot_cache_large" && container.type != "br_loot_cache_roguesignal" && container.type != "br_loot_cache_personal_legacy" && container.type != "br_loot_cache_personal_legacy_golden" && container.type != "br_loot_cache_underwater") {
    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("shouldGametypeContainerUseStrip")) {
      return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("shouldGametypeContainerUseStrip", container);
    }

    return 1;
  }

  if(!getdvarint(@ "hash_f6c12cf19ac66121", 1)) {
    return 1;
  }

  return 0;
}

function function_4749c1a092e650bd() {
  return default_to(getmatchrulesdata("commonOption", "aiBackpackDrop"), 0) == 1;
}

function function_8306d72ea2e8889c() {
  return default_to(getmatchrulesdata("commonOption", "playerBackpackDrop"), 1) == 1;
}

function function_310ab06891cb4517() {
  return function_4749c1a092e650bd() || function_8306d72ea2e8889c() || function_55b384ecb923003e();
}

function getindexforlootidincontainer(container, lootid, player) {
  if(!isDefined(container)) {
    return [undefined, undefined];
  }

  container = function_59b9c8081b873a10(player, container);

  if(!isDefined(container.contents) || !isDefined(lootid)) {
    return [undefined, undefined];
  }

  if(scripts\mp\loot::function_54066dbd8ef44fe1(container)) {
    foreach(index, item in container.contents) {
      if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
        continue;
      }

      if(item["lootID"] == lootid) {
        return [index, 0];
      }
    }

    if(isDefined(container.loadoutcontents)) {
      foreach(index, item in container.loadoutcontents) {
        if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
          continue;
        }

        if(item["lootID"] == lootid) {
          return [index, 1];
        }
      }
    }

    if(isDefined(container.var_a06e7128c001851d) && isDefined(container.var_a0e9fef038504bd0) && lootid == container.var_a06e7128c001851d) {
      return [100, 1];
    }
  }

  foreach(index, item in container.contents) {
    if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
      continue;
    }

    if(item["lootID"] == lootid) {
      return [index, 0];
    }
  }

  if(isDefined(container.weaponslotcontents) && lootid == container.weaponslotcontents) {
    return [100, 0];
  }

  return [undefined, undefined];
}

function function_59b9c8081b873a10(opener, container) {
  if(function_e3081772bbf7a51c(opener, container)) {
    return function_3aae4431f00c347f(opener, container);
  }

  return container;
}

function function_edb397974ae6ee68(opener, container, index, var_cc768ff46f3f6339) {
  var_42dcd1dafc60ca9 = function_c26e54ffd0c8be94(container, index);

  if(var_42dcd1dafc60ca9) {
    index -= 11;
    lootid = getloadoutdoublebackpacklootid(container, index, var_cc768ff46f3f6339);
    itemquantity = function_dc8d7c1709adcd67(container, index, var_cc768ff46f3f6339);
  } else {
    lootid = getlootidatcontainerindex(opener, index, container, var_cc768ff46f3f6339);
    itemquantity = function_8e5978971b5dcd16(opener, index, container, var_cc768ff46f3f6339);
  }

  return [lootid, itemquantity];
}

function function_3f23dfe9eb1bee5f(opener, container, index, quantity) {
  if(!isDefined(container)) {
    return;
  }

  if(function_c26e54ffd0c8be94(container, index)) {
    container.loadoutcontents[index - 11]["quantity"] = quantity;
    return;
  }

  if(function_e3081772bbf7a51c(opener, container)) {
    container.playercontents[opener.guid].contents[index]["quantity"] = quantity;
    return;
  }

  container.contents[index]["quantity"] = quantity;
}

function function_69532a81d0171769(opener, container, index, lootid) {
  if(!isDefined(container)) {
    return;
  }

  if(function_c26e54ffd0c8be94(container, index)) {
    container.loadoutcontents[index - 11]["lootID"] = lootid;
    return;
  }

  if(function_e3081772bbf7a51c(opener, container)) {
    container.playercontents[opener.guid].contents[index]["lootID"] = lootid;
    return;
  }

  container.contents[index]["lootID"] = lootid;
}

function function_153d3281e46e14da(opener, container, index, lootid, quantity) {
  if(!isDefined(container) || !isDefined(opener) || !isDefined(index) || !isDefined(lootid) || !isDefined(quantity)) {
    return;
  }

  lootid = ter_op(lootid > 0, lootid, 0);
  quantity = ter_op(quantity > 0, quantity, 0);

  if(lootid == 0 || quantity == 0) {
    lootid = 0;
    quantity = 0;
  }

  function_69532a81d0171769(opener, container, index, lootid);
  function_3f23dfe9eb1bee5f(opener, container, index, quantity);
  containercontents = function_59b9c8081b873a10(opener, container);
  function_446c7ad7bcc70992(opener, containercontents, index, lootid, quantity);
}

function function_c3d68fb7b175edd(opener, container) {
  if(!isDefined(container)) {
    return false;
  }

  if(isDefined(container.var_a06e7128c001851d) && isDefined(container.var_a0e9fef038504bd0)) {
    return true;
  }

  contentscontainer = function_59b9c8081b873a10(opener, container);
  return isDefined(contentscontainer.weaponslotcontents) && isDefined(contentscontainer.weaponslotobj);
}

function function_775a7fc396485a9a(opener, container, index) {
  weaponref = function_4b96aa12974840c0(opener, container, index);

  if(isDefined(weaponref)) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(weaponref);
    weaponobj = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname(weaponref);
    return [lootid, weaponobj, undefined, undefined, weaponclipsize(weaponobj)];
  }

  if(!function_c3d68fb7b175edd(opener, container)) {
    return [undefined, undefined, undefined, undefined, undefined];
  }

  lootid = undefined;
  weaponobj = undefined;
  pastteam = undefined;
  metadata = undefined;
  quantity = undefined;
  altquantity = undefined;
  lefthandquantity = undefined;

  if(isDefined(container.var_a06e7128c001851d) && isDefined(container.var_a0e9fef038504bd0)) {
    lootid = container.var_a06e7128c001851d;
    weaponobj = container.var_a0e9fef038504bd0;
    pastteam = container.var_c31356a794d8cb46;
    metadata = container.var_bb6791b7369ef71a;
    quantity = container.var_27990aa12decffdd;
    altquantity = container.var_49cd0247f1c08a6e;
    lefthandquantity = container.var_c693663e1bbdd8e9;
  } else {
    containercontents = function_59b9c8081b873a10(opener, container);
    lootid = containercontents.weaponslotcontents;
    weaponobj = containercontents.weaponslotobj;
    pastteam = containercontents.var_275f4441ab7920c8;
    metadata = containercontents.metadata;
    quantity = containercontents.weaponslotclip;
    altquantity = containercontents.var_86b32aff94b5714e;
    lefthandquantity = containercontents.var_ad7897ecdbcb63;
  }

  return [lootid, weaponobj, pastteam, metadata, quantity, altquantity, lefthandquantity];
}

function function_505e8eb7e77704c5(opener, container, index) {
  if(function_430df78a3a4143c1(opener, container, index)) {
    function_153d3281e46e14da(opener, container, index, 0, 0);
    return;
  }

  if(function_e3081772bbf7a51c(opener, container)) {
    container.playercontents[opener.guid].weaponslotobj = undefined;
    container.playercontents[opener.guid].weaponslotcontents = 0;
    container.playercontents[opener.guid].metadata = undefined;
    container.playercontents[opener.guid].var_275f4441ab7920c8 = undefined;
    container.playercontents[opener.guid].weaponslotclip = undefined;
    container.playercontents[opener.guid].var_ad7897ecdbcb63 = undefined;
    container.playercontents[opener.guid].var_86b32aff94b5714e = undefined;
  } else if(isDefined(container.var_a06e7128c001851d) && isDefined(container.var_a0e9fef038504bd0)) {
    container.var_a0e9fef038504bd0 = undefined;
    container.var_a06e7128c001851d = 0;
    container.var_bb6791b7369ef71a = undefined;
    container.var_c31356a794d8cb46 = undefined;
    container.var_27990aa12decffdd = undefined;
    container.var_49cd0247f1c08a6e = undefined;
    container.var_c693663e1bbdd8e9 = undefined;
    function_7f855164a30a5f5f(opener);
    return;
  } else {
    container.weaponslotobj = undefined;
    container.weaponslotcontents = 0;
    container.metadata = undefined;
    container.var_275f4441ab7920c8 = undefined;
    container.weaponslotclip = undefined;
    container.var_86b32aff94b5714e = undefined;
    container.var_ad7897ecdbcb63 = undefined;
  }

  opener setclientomnvar("loot_container_weapon", 0);
}

function function_67be8d119fa22135(container, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity) {
  container.weaponslotcontents = lootid;
  container.weaponslotobj = weaponobj;
  container.var_275f4441ab7920c8 = pastteam;
  container.var_5a90d1a92f9af4e3 = noextract;
  container.weaponslotclip = quantity;
  container.var_ad7897ecdbcb63 = lefthandquantity;
  container.var_86b32aff94b5714e = altclip;
  container.metadata = metadata;
}

function function_a0952bc59c9afa3f(player, specificcontainer, weaponobj, lootid, itemtype, itemindex, quantity, metadata, noextract, altclip, lefthandquantity) {
  pastteam = scripts\mp\gametypes\br_weapons::function_1a561e5ef2eca63a(player, weaponobj);

  if(isDefined(specificcontainer)) {
    function_67be8d119fa22135(specificcontainer, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity);
  } else {
    function_67be8d119fa22135(player.var_2fa5b49969def47, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity);
  }

  function_62ad0c002d54cbcc(player, specificcontainer, "loot_container_weapon", lootid, weaponobj);

  if(isDefined(itemtype) && isDefined(itemindex)) {
    player thread scripts\mp\gametypes\br_pickups::quickdropitem(itemtype, itemindex, 1);
  }
}

function function_430df78a3a4143c1(opener, container, index) {
  if(!isDefined(opener) || !isDefined(container) || !isDefined(index)) {
    return false;
  }

  contentscontainer = function_59b9c8081b873a10(opener, container);
  return isDefined(contentscontainer) && isDefined(contentscontainer.contents[index]) && isDefined(contentscontainer.contents[index]["ref"]);
}

function function_4b96aa12974840c0(opener, container, index) {
  if(!function_430df78a3a4143c1(opener, container, index)) {
    return undefined;
  }

  contentscontainer = function_59b9c8081b873a10(opener, container);
  return contentscontainer.contents[index]["ref"];
}

function function_932e5252b650e475(opener, container) {
  partname = container function_ec5f4851431f3382();

  if(function_e3081772bbf7a51c(opener, container)) {
    function_9ad640ba63792064(opener, container);
    return;
  }

  if(container getscriptableparthasstate(partname, "fully_opening_unusable")) {
    container setscriptablepartstate(partname, "fully_opening_unusable");
  }
}

function function_f3c9e05d4767d037(lootid, player, container, index) {
  if(!function_54066dbd8ef44fe1(container) || !scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid)) || !function_7eda25c90cc3aaa1(index)) {
    return;
  }

  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  baseorigin = container.origin;
  baseangles = container.angles;
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(baseorigin, baseangles);

  if(isDefined(container.linkedparent)) {
    dropinfo.groundentity = container.linkedparent;
  }

  basecount = scripts\mp\gametypes\br_pickups::loot_getitemcount(container);
  lefthand = scripts\mp\gametypes\br_pickups::loot_getitemcountlefthand(container);
  altcount = scripts\mp\gametypes\br_pickups::function_3a5f7703319142dd(container);
  spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_backpack_player_small", dropinfo, basecount, 0, undefined, undefined, lefthand, altcount);
  function_3883d0bb982156f3(container, spawnedbackpack);
  spawnedbackpack setscriptablepartstate("body", "partially_open_usable");

  if(isDefined(container.opener)) {
    scripts\mp\loot::openlootablecontainer(container.opener, spawnedbackpack);
  }

  scripts\mp\gametypes\br_pickups::loothide(container, "body");
}

function function_3883d0bb982156f3(container, backpack) {
  backpack.contents = container.contents;
  backpack.containertype = container.containertype;
  backpack.deadplayerindex = container.deadplayerindex;
  backpack.owner = container.owner;
  backpack.weaponslotcontents = container.weaponslotcontents;
  backpack.weaponslotobj = container.weaponslotobj;
  backpack.weaponslotclip = container.weaponslotclip;
  backpack.var_ad7897ecdbcb63 = container.var_ad7897ecdbcb63;
  backpack.var_275f4441ab7920c8 = container.var_275f4441ab7920c8;
  backpack.metadata = container.var_fd8a9b46f4a1e27c;
  backpack.var_86b32aff94b5714e = container.var_86b32aff94b5714e;
  backpack.backpacksize = container.backpacksize;
  backpack.loadoutcontents = container.loadoutcontents;
  backpack.var_a06e7128c001851d = container.var_a06e7128c001851d;
  backpack.var_a0e9fef038504bd0 = container.var_a0e9fef038504bd0;
  backpack.var_27990aa12decffdd = container.var_27990aa12decffdd;
  backpack.var_c693663e1bbdd8e9 = container.var_c693663e1bbdd8e9;
  backpack.var_49cd0247f1c08a6e = container.var_49cd0247f1c08a6e;
  backpack.var_bb6791b7369ef71a = container.var_bb6791b7369ef71a;
  backpack.var_c31356a794d8cb46 = container.var_c31356a794d8cb46;

  if(isDefined(container.owner) && isDefined(container.owner.var_6a4360dcf2a8f3d4)) {
    container.owner.var_6a4360dcf2a8f3d4 = backpack;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    backpack.criticalitem = 1;
  }

  foreach(item in backpack.contents) {
    scripts\engine\utility::callsharedfunc(item["lootID"], "addedToContainer", backpack);
  }
}

function function_bf4465d9535802ba(container, player, items) {
  function_cf0b3e7d1e5a3274(player, container, container.containertype);

  if(!isDefined(container.playersregistered)) {
    container.playersregistered = [];
  }

  container.playersregistered[player.guid] = items;
}

function function_40b46e7298657a93(container, players, items) {
  foreach(player in players) {
    function_bf4465d9535802ba(container, player, items);
  }
}

function function_cf0b3e7d1e5a3274(player, container, containertype, weaponslot) {
  if(!isDefined(container.playercontents)) {
    container.playercontents = [];
  }

  if(!isDefined(container.playercontents[player.guid])) {
    container.playercontents[player.guid] = spawnStruct();
    container.playercontents[player.guid].contents = [];
  }

  container.containertype = 1;
  container.playercontents[player.guid].containertype = 1;

  if(isDefined(containertype)) {
    container.containertype = containertype;
    container.playercontents[player.guid].containertype = containertype;
  }

  container.playercontents[player.guid].type = container.type;
  container.playercontents[player.guid].origin = container.origin;
  container.playercontents[player.guid].angles = container.angles;
}

function function_618f897065a12122(player, container, items) {
  if(!function_e3081772bbf7a51c(player, container)) {
    function_cf0b3e7d1e5a3274(player, container);
  }

  if(!isarray(items)) {
    items = [items];
  }

  foreach(item in items) {
    index = container.playercontents[player.guid].contents.size;
    container.playercontents[player.guid].contents[index] = [];
    container.playercontents[player.guid].contents[index]["lootID"] = item["lootID"];
    container.playercontents[player.guid].contents[index]["quantity"] = default_to(item["quantity"], 1);
  }
}

function function_3be0b970932fa47e(player, container, lootid, quantity, weaponobj, metadata, pastteam, altquantity, lefthandquantity) {
  if(!function_e3081772bbf7a51c(player, container)) {
    function_cf0b3e7d1e5a3274(player, container);
  }

  container.playercontents[player.guid].weaponslotcontents = lootid;
  container.playercontents[player.guid].weaponslotobj = weaponobj;
  container.playercontents[player.guid].metadata = metadata;
  container.playercontents[player.guid].var_275f4441ab7920c8 = pastteam;
  container.playercontents[player.guid].weaponslotclip = quantity;
  container.playercontents[player.guid].var_ad7897ecdbcb63 = lefthandquantity;
  container.playercontents[player.guid].var_86b32aff94b5714e = altquantity;
}

function function_e3081772bbf7a51c(opener, container) {
  return isDefined(container) && isDefined(opener) && isDefined(container.playercontents) && isDefined(container.playercontents[opener.guid]);
}

function function_3aae4431f00c347f(opener, container) {
  if(!isDefined(container.playercontents) || !isDefined(container.playercontents[opener.guid])) {
    return undefined;
  }

  return container.playercontents[opener.guid];
}

function function_3c85cbbfd2d2a3da(opener, container) {
  if(!isDefined(container.playercontents) || !isDefined(container.playercontents[opener.guid])) {
    return undefined;
  }

  return container.playercontents[opener.guid].contents;
}

function function_c24e299b175682e4(player, container) {
  container disablescriptableplayeruse(player);
}

function function_9ad640ba63792064(opener, container) {
  totalplayers = container.playercontents.size;
  totalcount = 0;

  foreach(guid, playercontents in container.playercontents) {
    player = getplayerforguid(guid);

    if(iscontainerempty(playercontents, player)) {
      totalcount++;
      function_c24e299b175682e4(player, container);
    }
  }

  partname = container function_ec5f4851431f3382();

  if(totalcount >= totalplayers && container getscriptableparthasstate(partname, "fully_opening_unusable")) {
    container setscriptablepartstate(partname, "fully_opening_unusable");
  }
}