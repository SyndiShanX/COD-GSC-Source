/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\pickups.gsc
***********************************************/

#using script_3a8f9ace195c9da9;
#using script_56bbc6b044d9068e;
#using script_5e254f0491793e03;
#using script_7e7eaa110dbb1c83;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\agent_drops;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_relics;
#using scripts\cp\cp_weapon;
#using scripts\cp\gameobjects;
#using scripts\cp\globallogic;
#using scripts\cp\kits;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\perks;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\stimpistol;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\oxygenmask;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace pickups;

function init() {
  setDvar(@ "scr_game_cash", 1);
  setDvar(@ "hash_19fae1aad58e8c50", 1);
  level.var_e247454ac2869696 = getdvarint(@ "hash_5fcbce13ef8d5f", 9);
  level.noinventory = getdvarint(@ "hash_19fae1aad58e8c50", 0);
  level.br_plunder_enabled = getdvarint(@ "scr_game_cash", 0);
  level.var_1d814f83596d0a02 = getdvarint(@ "hash_7a1da73fa673ed8", 1);
  level.var_a7f81dfdc88e53e6 = 1;
  level.backpackdata = "dmzBackpack";
  level.var_9fb437a5f1d70130 = ["radar_drone_recon"];
  val::group_register("useSuper", ["base_jumping", "vehicle_use", "cp_munitions", "cp_supers_pickup", "swimming_underwater", "usability"]);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_195f5055031ad0cb);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_52db16c0f1b89f36);
  br_pickups_init();

  if(getdvarint(@ "hash_a21301e95040b2ab", 1)) {
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock", &ammorestock_used);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock_train", &ammorestock_used);
  }
}

function br_pickups_init() {
  level.br_pickups = spawnStruct();
  initarrays();
  initscriptablemanagement();
  function_24ea0b21194d20ce();
}

function function_df050f6185b6c43d(scriptablename) {
  if(isDefined(level.br_pickups.var_a5e4b146866d7fd[scriptablename])) {
    icon = tablelookupbyrow(level.brloottablename, level.br_pickups.br_itemrow[scriptablename], 34);
    return icon;
  }

  return undefined;
}

function function_f28d303ba069eb4b(scriptablename) {
  row = level.br_pickups.br_itemrow[scriptablename];

  if(isDefined(row)) {
    icon = tablelookupbyrow(level.brloottablename, row, 13);

    if(isDefined(icon)) {
      return icon;
    }
  }

  return undefined;
}

function initarrays() {
  if(function_240f7f4e57340e8f()) {
    level.brloottablename = getDvar(@ "loot_table_name", "cp/loot/dungeons/loot_item_defs.csv");

    if(level.brloottablename == "") {
      level.brloottablename = "cp/loot/dungeons/loot_item_defs.csv";
    }

    level.var_6178ce645aeeb787 = getDvar(@ "loot_table_zone", "cp/loot/dungeons/loot_table_zones.csv");

    if(level.var_6178ce645aeeb787 == "") {
      level.var_6178ce645aeeb787 = "cp/loot/dungeons/loot_table_zones.csv";
      setDvar(@ "loot_table_zones", level.var_6178ce645aeeb787);
    }
  } else {
    level.brloottablename = getDvar(@ "loot_table_name", "cp/loot/default/loot_item_defs.csv");

    if(level.brloottablename == "") {
      level.brloottablename = "cp/loot/default/loot_item_defs.csv";
    }

    level.var_6178ce645aeeb787 = getDvar(@ "loot_table_zone", "cp/loot/default/loot_table_zones.csv");

    if(level.var_6178ce645aeeb787 == "") {
      level.var_6178ce645aeeb787 = "cp/loot/default/loot_table_zones.csv";
      setDvar(@ "loot_table_zones", level.var_6178ce645aeeb787);
    }
  }

  if(!isDefined(level.br_pickups)) {
    level.br_pickups = spawnStruct();
  }

  level.br_pickups.createcallbacks = [];
  level.br_pickups.droppedgasmasks = [];
  level.br_pickups.br_equipname = [];
  level.br_pickups.stackable = [];
  level.br_pickups.maxcounts = [];
  level.br_pickups.counts = [];
  level.br_pickups.br_itemtype = [];
  level.br_pickups.br_itemrow = [];
  level.br_pickups.br_itemrarity = [];
  level.br_pickups.br_value = [];
  level.br_pickups.br_equipnametoscriptable = [];
  level.br_pickups.br_weapontoscriptable = [];
  level.br_pickups.var_7b2bff2d04ee1017 = [];
  level.br_pickups.var_b13dc7e63676bbe7 = [];
  level.br_pickups.br_pickupsfx = [];
  level.br_pickups.var_14bd11727c4b6629 = [];
  level.br_pickups.var_838863c4848d4c26 = [];
  level.br_pickups.br_hasautopickup = [];
  level.br_pickups.uniquelootcallbacks = [];
  level.br_pickups.var_4138f9ddc1cd22d = [];
  level.br_pickups.var_a5e4b146866d7fd = [];
  level.br_pickups.br_allguns = [];
  level.br_pickups.br_lootguns = [];
  level.br_pickups.br_crateguns = [];
  level.br_pickups.br_crateitems = [];
  level.br_pickups.br_gulagpickups = [];
  level.br_lootiteminfo = [];
  level.br_weaponsprimary = [];
  level.br_weaponssecondary = [];
  level.br_throwables = [];
  level.br_usables = [];
  var_6a537ee3949585f4 = [];
  var_5c845b7a0ef0780f = 0;
  var_55dff3c24d1396c9 = "+";
  lastrow = tablelookupgetnumrows(level.brloottablename);

  for(row = 0; row < lastrow; row++) {
    key = tablelookupbyrow(level.brloottablename, row, 0);

    if(!isDefined(key)) {
      continue;
    }

    if(key == "item") {
      itemtype = tablelookupbyrow(level.brloottablename, row, 2);

      if(!isDefined(itemtype)) {
        continue;
      }

      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      itemvalue = tablelookupbyrow(level.brloottablename, row, 7);
      level.br_pickups.br_value[var_14004b68ddacb781] = int(itemvalue);
      lootidname = tablelookupbyrow(level.brloottablename, row, 5);
      var_2ad07b9c3adc39e3 = int(tablelookupbyrow(level.brloottablename, row, 17));
      level.br_pickups.maxcounts[var_14004b68ddacb781] = var_2ad07b9c3adc39e3;
      level.br_pickups.br_hasautopickup[var_14004b68ddacb781] = int(tablelookupbyrow(level.brloottablename, row, 20));
      var_52e1d38987af61c3 = tablelookupbyrow(level.brloottablename, row, 34);
      level.br_pickups.var_a5e4b146866d7fd[var_14004b68ddacb781] = isDefined(var_52e1d38987af61c3) && var_52e1d38987af61c3 != "";
      level.br_pickups.br_itemrow[var_14004b68ddacb781] = int(row);
      function_ec51234e00e53e8a(itemtype, var_14004b68ddacb781);

      if(itemtype == "weapon") {
        raritystring = tablelookupbyrow(level.brloottablename, row, 3);
        pickupsound = tablelookupbyrow(level.brloottablename, row, 14);
        lootreference = tablelookupbyrow(level.brloottablename, row, 18);

        if(isDefined(lootreference) && lootreference != "") {
          level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
          level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
        }

        if(isDefined(lootidname) && lootidname.size > 0) {
          lootid = int(lootidname);
          weaponroot = function_1cc3fd00b6ccc3ba(lootid);
          var_25152a36c536d7f = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
          var_655be453564ea032 = getweaponvarianttablename(weaponroot);

          if(getDvar(@ "hash_9cc91f7c70752fa7", "1") == "1") {
            weaponroot = tablelookupbyrow(level.brloottablename, row, 8);
            variantid = 0;
          } else {
            variantid = int(tablelookup(var_655be453564ea032, 1, var_25152a36c536d7f, 0));
          }

          attachmentsstring = tablelookupbyrow(level.brloottablename, row, 9);
          attachmentsarray = [];
          attachmenttoidmap = [];

          if(isDefined(attachmentsstring) && attachmentsstring.size) {
            attachmentsarray = strtok(attachmentsstring, var_55dff3c24d1396c9);
          }

          if(isDefined(attachmentsarray)) {
            foreach(attach in attachmentsarray) {
              array = strtok(attach, "|");

              if(array.size > 1) {
                attachmenttoidmap[array[0]] = int(array[1]);
                continue;
              }

              attachmenttoidmap[array[0]] = 0;
            }
          }

          baseweaponname = weaponroot;
          camo = undefined;

          if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
            camo = "camo_11a";
          }

          fullweaponobj = undefined;

          if(!isDefined(attachmenttoidmap)) {
            fullweaponobj = scripts\cp_mp\weapon::buildweapon_blueprint(weaponroot, camo, undefined, variantid);
          } else {
            fullweaponobj = scripts\cp_mp\weapon::buildweapon_attachmentidmap(weaponroot, attachmenttoidmap, camo, undefined, variantid, undefined, undefined, 1);
          }

          fullweaponname = getcompleteweaponname(fullweaponobj);

          if(getdvarint(@ "hash_9cc91f7c70752fa7", 1)) {
            weaponrarity = "<dev string:x1c>";
            titlestring = tablelookupbyrow(level.brloottablename, row, 11);
            icon = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d(weaponroot, #"image", "<dev string:x1e>");
            attachmentsall = scripts\cp_mp\weapon::weaponattachcustomtoidmap(weaponroot, variantid);
            attachmentsdefault = scripts\cp_mp\weapon::weaponattachdefaulttoidmap(weaponroot, variantid);
            attachmentsstring = "<dev string:x1e>";

            if(isDefined(attachmentsall)) {
              foreach(key, aid in attachmentsall) {
                if(isDefined(attachmentsdefault) && isDefined(attachmentsdefault[key])) {
                  continue;
                }

                if(attachmentsstring != "<dev string:x1e>") {
                  attachmentsstring += var_55dff3c24d1396c9;
                }

                attachmentsstring += key;
              }
            }

            var_287363cd98ae15a8 = tablelookupbyrow(level.brloottablename, row, 8);
            var_361a437d788f1ff4 = tablelookupbyrow(level.brloottablename, row, 10);
            var_2278b4e29d8c7ddd = tablelookupbyrow(level.brloottablename, row, 13);

            if(var_287363cd98ae15a8 != baseweaponname) {
              println("<dev string:x1f>" + var_14004b68ddacb781 + "<dev string:x4b>" + var_287363cd98ae15a8 + "<dev string:x4f>" + baseweaponname + "<dev string:x56>");
              var_5c845b7a0ef0780f = 1;
            }

            if(var_361a437d788f1ff4 != fullweaponname) {
              println("<dev string:x58>" + var_14004b68ddacb781 + "<dev string:x4b>" + var_361a437d788f1ff4 + "<dev string:x4f>" + fullweaponname + "<dev string:x56>");
              var_5c845b7a0ef0780f = 1;
            }

            if(var_2278b4e29d8c7ddd != icon) {
              println("<dev string:x84>" + var_14004b68ddacb781 + "<dev string:x4b>" + var_2278b4e29d8c7ddd + "<dev string:x4f>" + icon + "<dev string:x56>");
              var_5c845b7a0ef0780f = 1;
            }
          }
        } else {
          baseweaponname = tablelookupbyrow(level.brloottablename, row, 8);

          if(scripts\cp\cp_weapon::function_2b7981cbc7ca24b4(baseweaponname)) {
            continue;
          }

          attachmentsstring = tablelookupbyrow(level.brloottablename, row, 9);
          attachmentsarray = [];

          if(isDefined(attachmentsstring) && attachmentsstring.size) {
            attachmentsarray = strtok(attachmentsstring, var_55dff3c24d1396c9);
          }

          if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
            fullweaponobj = scripts\cp_mp\weapon::buildweapon(baseweaponname, attachmentsarray, "camo_11a", "none", -1);
          } else {
            fullweaponobj = scripts\cp_mp\weapon::buildweapon(baseweaponname, attachmentsarray, "none", "none", -1);
          }

          fullweaponname = getcompleteweaponname(fullweaponobj);
          variantlootid = scripts\cp_mp\utility\loot::getlootidfromref(baseweaponname);

          if(isDefined(variantlootid)) {
            lootidname = "" + variantlootid;
          }

          if(int(raritystring) != 10) {
            titlestring = tablelookupbyrow(level.brloottablename, row, 11);
            icon = tablelookupbyrow(level.brloottablename, row, 13);
            var_361a437d788f1ff4 = tablelookupbyrow(level.brloottablename, row, 10);

            if(var_361a437d788f1ff4 != fullweaponname) {
              println("<dev string:x58>" + var_14004b68ddacb781 + "<dev string:x4b>" + var_361a437d788f1ff4 + "<dev string:x4f>" + fullweaponname + "<dev string:x56>");
            }
          }

        }

        level.br_pickups.br_itemtype[var_14004b68ddacb781] = getxhash(itemtype);
        level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = getxhash(pickupsound);
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = int(raritystring);
        level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = var_14004b68ddacb781;
        level.br_lootiteminfo[var_14004b68ddacb781] = spawnStruct();
        level.br_lootiteminfo[var_14004b68ddacb781].baseweapon = baseweaponname;
        level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname = fullweaponname;
        level.br_lootiteminfo[var_14004b68ddacb781].fullweaponobj = fullweaponobj;

        if(int(raritystring) != 10) {
          level.br_pickups.br_weapontoscriptable[fullweaponname] = var_14004b68ddacb781;
          level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = int(lootidname);
          level.br_pickups.var_b13dc7e63676bbe7[int(lootidname)] = var_14004b68ddacb781;
        }
      } else {
        equipname = tablelookupbyrow(level.brloottablename, row, 8);

        if(isDefined(equipname) && equipname.size > 0) {
          equipname = tolower(equipname);
          level.br_pickups.br_equipname[var_14004b68ddacb781] = equipname;
          level.br_pickups.br_equipnametoscriptable[equipname] = var_14004b68ddacb781;
        }

        var_54e2cc4157b862bd = tablelookupbyrow(level.brloottablename, row, 15);

        if(var_54e2cc4157b862bd != "") {
          switch (var_54e2cc4157b862bd) {
            case #"hash_31100fbc01bd387c":
              if(isDefined(equipname) && equipname.size > 0) {
                level.equipment.table[equipname].defaultslot = "primary";
              }

              level.br_throwables[level.br_throwables.size] = var_14004b68ddacb781;
              break;
            case #"hash_311012bc01bd3d35":
              if(isDefined(equipname) && equipname.size > 0) {
                level.equipment.table[equipname].defaultslot = "secondary";
              }

              level.br_usables[level.br_usables.size] = var_14004b68ddacb781;
              break;
            case #"hash_311011bc01bd3ba2":
              if(isDefined(equipname) && equipname.size > 0) {
                level.equipment.table[equipname].defaultslot = "health";
              }

              break;
            case #"hash_31100cbc01bd33c3":
              if(isDefined(equipname) && equipname.size > 0) {
                level.equipment.table[equipname].defaultslot = "super";
              }

              break;
            default:
              assertmsg("Unhandled brSlotOverride type in loot table for " + var_14004b68ddacb781 + "\n");
              break;
          }
        }

        lootreference = tablelookupbyrow(level.brloottablename, row, 18);

        if(isDefined(lootreference) && lootreference != "") {
          level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
          level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
        }

        var_51426ae160732e49 = int(tablelookupbyrow(level.brloottablename, row, 4));
        var_10a92702735eff08 = int(tablelookupbyrow(level.brloottablename, row, 27));

        if(itemtype == "ammo") {
          if(!isDefined(level.br_ammo_max)) {
            br_ammo_init();
          }

          level.br_ammo_max[var_14004b68ddacb781] = var_2ad07b9c3adc39e3;
        }

        level.br_pickups.stackable[var_14004b68ddacb781] = var_2ad07b9c3adc39e3 > 1;
        level.br_pickups.counts[var_14004b68ddacb781] = var_51426ae160732e49;
        level.br_pickups.var_4138f9ddc1cd22d[var_14004b68ddacb781] = var_10a92702735eff08;
        itemtype = tolower(itemtype);
        level.br_pickups.br_itemtype[var_14004b68ddacb781] = getxhash(itemtype);
        level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = getxhash(tablelookupbyrow(level.brloottablename, row, 14));
        raritynum = tablelookupbyrow(level.brloottablename, row, 3);
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = int(raritynum);

        if(isDefined(lootidname) && lootidname != "") {
          level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = int(lootidname);
          level.br_pickups.var_b13dc7e63676bbe7[int(lootidname)] = var_14004b68ddacb781;
        }
      }

      continue;
    }

    if(key == "crate") {
      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      cratechance = int(tablelookupbyrow(level.brloottablename, row, 2));

      if(cratechance > 0) {
        if(isDefined(level.br_lootiteminfo[var_14004b68ddacb781]) && isDefined(level.br_lootiteminfo[var_14004b68ddacb781].baseweapon)) {
          for(i = 0; i < cratechance; i++) {
            level.br_pickups.br_crateguns[level.br_pickups.br_crateguns.size] = var_14004b68ddacb781;
            level.br_pickups.br_allguns[level.br_pickups.br_allguns.size] = var_14004b68ddacb781;
          }
        } else {
          for(i = 0; i < cratechance; i++) {
            level.br_pickups.br_crateitems[level.br_pickups.br_crateitems.size] = var_14004b68ddacb781;
          }
        }
      }

      continue;
    }

    if(key == "gulag") {
      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      pickupclass = tablelookupbyrow(level.brloottablename, row, 2);

      if(!isDefined(level.br_pickups.br_gulagpickups[pickupclass])) {
        level.br_pickups.br_gulagpickups[pickupclass] = [];
      }

      count = level.br_pickups.br_gulagpickups[pickupclass].size;
      level.br_pickups.br_gulagpickups[pickupclass][count] = var_14004b68ddacb781;
      continue;
    }

    if(key == "depends" && !isDefined(level.br_pickups.var_11feb85e78e7cee8)) {
      level.br_pickups.var_11feb85e78e7cee8 = row;
    }
  }

  setdvarifuninitialized(@ "hash_61e10de0f675e9ad", 0);
  level.br_pickups.br_pickupdenyammonoroom = "MP/BR_AMMO_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyequipnoroom = "MP/BR_EQUIP_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyalreadyhaveweapon = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyarmornotbetter = "MP/BR_ARMOR_DENY_NOT_BETTER";
  level.br_pickups.br_pickupdenyalreadyhaveks = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyalreadyhavetoken = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
  level.br_pickups.br_pickupdenyalreadyhaverevive = "MP_BR_INGAME/ALREADY_HAVE_SELF_REVIVE_ITEM";
  level.br_pickups.br_pickupdenyarmorfull = "MP/BR_ARMOR_DENY_ARMOR_FULL";
  level.br_pickups.br_pickupdenyalreadyhaveplatepouch = "MP_BR_INGAME/ALREADY_HAVE_PLATE_POUCH_ITEM";
  level.br_pickups.br_pickupdenyparachuting = "MP/BR_PICKUP_DENY_PARACHUTING";
  level.br_pickups.br_pickupdenyalreadyhavequest = "MP_BR_INGAME/TABLET_PICKUP_FAILURE";
  level.br_pickups.br_pickupdenyplunderpickup = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
  level.br_pickups.br_pickupdenyjuggernaut = "KILLSTREAKS/JUGG_CANNOT_BE_USED";
  level.br_pickups.br_pickupalreadyhavespecialistbonus = "MP_BR_INGAME/ALREADY_HAVE_SPECIALIST_BONUS_ITEM";
  level.br_pickups.var_b4a939303c824805 = "MP_BR_INGAME/CIRCLE_PEEK_LIMIT";
  level.br_pickups.var_5fdcd05c466e7520 = "MP/BR_PICKUP_ITEM_MAX_LIMIT";
  level.br_pickups.var_a1a6a7680c4ff1eb = "MP/BR_ALREADY_EQUIPPED_ITEM";
  level.br_pickups.var_fde0e27b3a09bf3 = "MP/CANNOT_EQUIP_NOW";
  level.br_pickups.var_58fe23c2a80f28ed = "MP_BR_INGAME/MISSION_WHITELISTED";
  level.br_pickups.var_d8a2816e3697c70c = "MP_DMZ_MISSIONS/GEIGER_SEARCH_CONTRACT_CANCELLED_ERR";
  level.br_pickups.br_pickupdenyweaponpickupap = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
  level.br_pickups.var_7141c6c2372c0a82 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.var_8bffca3828fd297e = "MP/BR_EQUIP_DENY_PLATE_CARRIER_LESS";
  level.br_pickups.var_ec7422f11a61c100 = "MP/BR_EQUIP_DENY_BACKPACK_LESS";
  level.br_pickups.var_7bd397b2e9d8a434 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups.respawntokenenabled = getdvarint(@ "hash_c9d9bc1bae348282", 1);
  level.br_pickups.respawntokenclosewithgulag = getdvarint(@ "hash_8603626dc2ec647d", 0);
  level.br_pickups.yawoffsetoverride = undefined;
  level.br_pickups.distanceoverride = undefined;

  if(getdvarint(@ "hash_249a73868c9cd7d8", 0)) {
    function_f8b204e807cc62ed();
  }

  if(function_b1dd9dcae2f63965()) {
    function_b9da718e50063452();
  }

  scripts\engine\scriptable::scriptable_addusedcallback(&function_5caa62275ce1a582);
  scripts\engine\scriptable::scriptable_addautousecallback(&lootused);
}

function function_ec51234e00e53e8a(item_type, drop_name) {
  drop_var = "agentdrops_+" + drop_name;
  drop_path = item_type + "/" + drop_name;
  cmd = "devgui_cmd \"CP Debug:2 / Loot Drops / " + drop_path + "\" \"set scr_start_debug " + drop_var + "\" \n";
  addentrytodevgui(cmd);
}

function function_f8b204e807cc62ed() {
  level.var_81369e82645391f0 = [];
  var_3c7f6558e5171cfc = getDvar(@ "hash_dd0e2df8833b28d8", "mp/automatism/weapon_class_groups_for_auto_grab.csv");
  var_3cfaae92e4bb0d04 = tablelookupgetnumrows(var_3c7f6558e5171cfc);

  for(row = 0; row < var_3cfaae92e4bb0d04; row++) {
    weaponclass = tablelookupbyrow(var_3c7f6558e5171cfc, row, 0);
    groupindex = int(tablelookupbyrow(var_3c7f6558e5171cfc, row, 1));
    level.var_81369e82645391f0[weaponclass] = groupindex;
  }
}

function function_d2d7b153b9d3889e(index, name, start, end, traceresults) {
  var_a16891a5162df351 = 2000;

  if(traceresults["<dev string:xa6>"] < 1) {
    line(start, traceresults["<dev string:xaf>"], (1, 0, 0), 1, 0, var_a16891a5162df351);

    if(isDefined(traceresults["<dev string:xb8>"])) {
      selectedentity = traceresults["<dev string:xb8>"];
      println("<dev string:xbf>" + index + "<dev string:xce>" + name + "<dev string:xd1>" + traceresults["<dev string:xa6>"] + "<dev string:xd7>" + traceresults["<dev string:xaf>"] + "<dev string:xdc>" + selectedentity.name);
    } else {
      println("<dev string:xbf>" + index + "<dev string:xce>" + name + "<dev string:xd1>" + traceresults["<dev string:xa6>"] + "<dev string:xd7>" + traceresults["<dev string:xaf>"]);
    }

    return;
  }

  println("<dev string:xbf>" + index + "<dev string:xce>" + name + "<dev string:xe2>");
  line(start, end, (1, 1, 1), 1, 0, var_a16891a5162df351);
}

function getitemdropinfo(origin, angles, payload, groundentity, var_97331585b4002aa7) {
  assert(isDefined(origin));
  dropinfo = spawnStruct();
  dropinfo.origin = origin;

  if(isDefined(angles)) {
    dropinfo.angles = angles;
  } else {
    dropinfo.angles = (0, 0, 0);
  }

  if(isDefined(payload)) {
    dropinfo.payload = payload;
  } else {
    dropinfo.payload = 0;
  }

  dropinfo.var_97331585b4002aa7 = var_97331585b4002aa7;
  dropinfo.groundentity = groundentity;
  return dropinfo;
}

function takeweaponsdefaultfunc() {
  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  gunless = makeweapon("iw9_me_fists_mp");
  weapnone = makeweapon("none");
  self.weaponlist = self.primaryweapons;

  for(i = 0; i < self.weaponlist.size; i++) {
    weapon = self.weaponlist[i];

    if(isDefined(weapon) && !issameweapon(gunless, weapon) && !issameweapon(weapnone, weapon)) {
      self takeweapon(weapon);
    }
  }

  self clearaccessory();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  self.gunnlessweapon = gunless;
  waitframe();
}

function getitemdroporiginandangles(index, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44, pickupent) {
  assert(!isDefined(ignoreent) || isent(ignoreent));
  var_c5eed6e92f7c606d = 1;
  trace_active = 1;
  var_551904951118b7b9 = getdvarint(@ "hash_d7613094ea4ba91f", 0);
  var_a9d5ad9414f5ecb7 = 14;
  var_57716496f9f490f = 100;
  var_e0cc897878c28778 = 40;
  var_b0bb91ad89d1aaed = -5;
  var_b0987bad89ab32d3 = 5;
  ring_yaw = 10;
  slot_yaw = 360 / var_a9d5ad9414f5ecb7;
  var_ab9f50e5b2c2e07e = -5;
  var_ab7c62e5b29cc05c = 5;
  var_bf66b5fb30acfdc9 = 40;
  var_aea7c2414b868248 = 20;
  var_ca4135583a9a540d = 60;
  var_d6a5232d04d3a753 = -6;
  var_240f67006fe07965 = 0;
  var_cd6d42939f0321e6 = -18;
  var_d83d7a2c3425b761 = getdvarint(@ "hash_e25578bd8bbf75ea", 0);
  noground = 0;
  payload = 0;
  groundentity = undefined;
  groundfloat = var_240f67006fe07965;

  if(isDefined(var_6fe2ff802d5192d4)) {
    groundfloat = var_6fe2ff802d5192d4;
  }

  ring = int(index / var_a9d5ad9414f5ecb7);
  slot = index - ring * var_a9d5ad9414f5ecb7;
  yaw = baseangles[1] + slot * slot_yaw + ring * ring_yaw + randomfloatrange(var_ab9f50e5b2c2e07e, var_ab7c62e5b29cc05c);
  dist = var_57716496f9f490f + ring * var_e0cc897878c28778 + randomfloatrange(var_b0bb91ad89d1aaed, var_b0987bad89ab32d3);

  if(isDefined(var_8a600b6102da9f9b)) {
    yaw = baseangles[1] + var_8a600b6102da9f9b;
  }

  if(isDefined(optionaloverridedist)) {
    dist = optionaloverridedist;
  }

  angles = (0, yaw, 0);
  dir = anglesToForward(angles);
  origin = baseorigin + dir * dist;

  if(trace_active) {
    ignoreents = vehicle_getarrayinradius(origin, 500, 500);

    if(isDefined(ignoreent)) {
      ignoreents[ignoreents.size] = ignoreent;
    }

    if(var_551904951118b7b9) {
      println("<dev string:xbf>" + index + "<dev string:xeb>" + baseorigin + "<dev string:xf3>" + origin + "<dev string:xf8>" + dist);
    }

    tracestart = baseorigin + (0, 0, var_aea7c2414b868248);
    traceend = origin + (0, 0, var_aea7c2414b868248);
    tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1);

    if(var_d83d7a2c3425b761 && utility::function_ccf98e6391dd38b9()) {
      var_3e665d870a5068fb = scripts\engine\trace::function_b88b8bd51ea7fe24();
      tracecontents -= var_3e665d870a5068fb;
    }

    traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

    if(var_551904951118b7b9) {
      function_d2d7b153b9d3889e(index, "<dev string:x102>", tracestart, traceend, traceresults);
    }

    if(traceresults["fraction"] < 1) {
      origin = traceresults["position"];
      origin += dir * var_cd6d42939f0321e6;
    } else {
      origin = traceend;
    }

    tracestart = origin;
    traceend = origin + (0, 0, var_ca4135583a9a540d);
    traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

    if(var_551904951118b7b9) {
      function_d2d7b153b9d3889e(index, "<dev string:x105>", tracestart + (0, 1, 0), traceend + (0, 1, 0), traceresults);
    }

    if(traceresults["fraction"] < 1) {
      origin = traceresults["position"] + (0, 0, var_d6a5232d04d3a753);
    } else {
      origin = traceend;
    }

    tracestart = origin;
    var_3a7f0173b03f5767 = -1 * getdvarfloat(@ "hash_b91d6bc7e0694ac", 2000);
    traceend = origin + (0, 0, var_3a7f0173b03f5767);
    traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

    if(var_551904951118b7b9) {
      function_d2d7b153b9d3889e(index, "<dev string:x108>", tracestart, traceend, traceresults);
    }

    if(traceresults["fraction"] < 1) {
      origin = traceresults["position"] + (0, 0, groundfloat);
      groundentity = traceresults["entity"];

      if(isDefined(groundentity) && groundentity.code_classname == "script_model" && groundentity.spawnflags & 4) {
        groundentity = undefined;
      } else if(isDefined(groundentity) && groundentity.code_classname == "script_brushmodel" && groundentity.spawnflags & 8) {
        groundentity = undefined;
      }
    } else {
      if(var_551904951118b7b9) {
        println("<dev string:xbf>" + index + "<dev string:x10b>");
      }

      origin = (0, 0, 0);
      noground = 1;
    }
  } else {
    origin += (0, 0, groundfloat);
  }

  if(isDefined(pickupent) && !istrue(pickupent.isstuck)) {
    if(isDefined(pickupent.instance) && (isDefined(pickupent.instance.itembox) || istrue(pickupent.instance.var_b5c99a0d29afb1ac))) {
      origin = baseorigin;
      var_c5eed6e92f7c606d = 0;
    } else {
      origin = pickupent.origin;
    }
  }

  if(var_c5eed6e92f7c606d && !noground) {
    startorigin = baseorigin;

    if(!istrue(var_3ace5ac9c7d6fa44)) {
      startorigin += (0, 0, var_bf66b5fb30acfdc9);
    }

    payload = calcscriptablepayloadgravityarc(startorigin, origin);
  }

  if(var_551904951118b7b9) {
    println("<dev string:xbf>" + index + "<dev string:x117>" + origin + "<dev string:x127>" + angles);
  }

  return getitemdropinfo(origin, angles, payload, groundentity);
}

function function_73ffc9bcd6d1e62d(fromkiosk) {
  if(istrue(fromkiosk)) {
    level.br_pickups.yawoffsetoverride = getkioskyawoffsetoverride();
    level.br_pickups.distanceoverride = function_1a8066ccdb91c1d1();
    return;
  }

  level.br_pickups.yawoffsetoverride = undefined;
  level.br_pickups.distanceoverride = undefined;
}

function getfullweaponobjforscriptablepartname(scriptablename) {
  if(isDefined(scriptablename) && isDefined(level.br_lootiteminfo[scriptablename]) && isDefined(level.br_lootiteminfo[scriptablename].fullweaponobj)) {
    return level.br_lootiteminfo[scriptablename].fullweaponobj;
  }

  return undefined;
}

function getfullweaponobjforpickup(pickupent) {
  if(isDefined(pickupent) && isDefined(pickupent.scriptablename)) {
    return getfullweaponobjforscriptablepartname(pickupent.scriptablename);
  }

  return undefined;
}

function getgulagpickupsforclass(pickupclass) {
  var_14004b68ddacb781 = ["none"];

  if(isDefined(pickupclass) && isDefined(level.br_pickups.br_gulagpickups[pickupclass])) {
    var_14004b68ddacb781 = level.br_pickups.br_gulagpickups[pickupclass];
  }

  return var_14004b68ddacb781;
}

function lootusedignore(instance) {
  if(instance.type == "br_plunder_box" || instance.type == "dmz_uav_tower") {
    return true;
  }

  return false;
}

function lootused(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(instance) || function_362d5a8d49b93721(instance.type)) {
    return;
  }

  pickup = function_2e99748b7a8e1fe4(instance, bautouse);
  return function_b5f5576a0017c089(pickup, state, player, bautouse, instance);
}

function function_5caa62275ce1a582(instance, part, state, player, bautouse, usestring) {
  startlocation = instance.origin;
  result = lootused(instance, part, state, player, bautouse, usestring);

  if(istrue(result) && function_240f7f4e57340e8f() && !bautouse && !issubstr(part, "weapon") && !function_af07aad35b55fd73(part)) {
    thread function_8a1c7c62c1a6f261(startlocation, part, state, player);
  }

  return result;
}

function function_2e99748b7a8e1fe4(instance, bautouse) {
  pickup = spawnStruct();
  pickup.scriptablename = instance.type;
  pickup.origin = instance.origin;
  pickup.count = loot_getitemcount(instance);
  pickup.countlefthand = loot_getitemcountlefthand(instance);
  pickup.countalt = function_3a5f7703319142dd(instance);
  pickup.instance = instance;
  pickup.customweaponname = instance.customweaponname;
  pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];
  assert(isDefined(pickup.count));

  if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename])) {
    pickup.count = level.br_pickups.counts[pickup.scriptablename];
  }

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = bautouse;

  if(isDefined(instance.var_5c3c19452417fd1c)) {
    pickup.var_5c3c19452417fd1c = instance.var_5c3c19452417fd1c;
  }

  return pickup;
}

function function_8a1c7c62c1a6f261(locationstart, part, state, player) {
  starttime = gettime();

  while(!player function_66bdd7e1d2e05f14() && gettime() - starttime < 500) {
    waitframe();
  }

  nearby_instances = getentitylessscriptablearray(undefined, undefined, locationstart, 30);
  nearby_instances = sortbydistance(nearby_instances, locationstart);

  foreach(instance in nearby_instances) {
    if(instance.type == part) {
      pickup = function_2e99748b7a8e1fe4(instance, 0);

      if(player function_ea3cee541617e9ce(pickup)) {
        pickup.skipsound = 1;
        result = function_b5f5576a0017c089(pickup, state, player, 0, instance);

        if(!result) {
          return;
        }
      }
    }
  }
}

function function_ea3cee541617e9ce(pickup) {
  results = cantakepickup(pickup);

  if(results == 1) {
    return true;
  }

  if(results == 20) {
    return true;
  }

  if(results == 5 || results == 27) {
    return true;
  }

  if(results == 22) {
    return true;
  }

  return false;
}

function function_b5f5576a0017c089(pickup, state, player, bautouse, instance) {
  if(!isDefined(pickup)) {
    return 0;
  }

  if(istrue(level.infilcinematicactive)) {
    return 0;
  }

  if(istrue(level.disableautolootpickup) && istrue(bautouse)) {
    return 0;
  }

  if(getdvarint(@ "hash_15055cb805b43a20", 1) && istrue(bautouse) && !player function_e44c2d69db881894(pickup.scriptablename)) {
    return 0;
  }

  if(player usingtouch() && !player function_7b738b973a0b7f94() && istrue(bautouse) && player function_e44c2d69db881894(pickup.scriptablename)) {
    return 0;
  }

  if(function_b1dd9dcae2f63965() && istrue(bautouse) && player function_ac3ec31be7aad7a7(instance)) {
    return 0;
  }

  if(player isreloading()) {
    return 0;
  }

  if(!isDefined(instance) || instance getscriptableisloot() && !lootusedignore(instance)) {
    if(isDefined(instance) && istrue(instance.var_4c89ae940ca43b23)) {
      return 0;
    }

    results = player cantakepickup(pickup);

    if(results == 1) {
      if(isDefined(instance)) {
        instance.var_4c89ae940ca43b23 = 1;
      }

      return function_60234aa487445085(pickup, player, bautouse, instance);
    } else if(results == 20) {
      return function_8f0bd51f5c6108b(pickup, player, bautouse, instance);
    } else if(results == 5 || results == 27) {
      if(istrue(instance.var_ff45e00f9ed1e5c9)) {
        player scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
        player playlocalsound("br_pickup_deny");
        return 1;
      }

      newweapon = function_55c5d35c8c76a95b(pickup)[0];
      fakepickup = spawnStruct();
      fakepickup.scriptablename = br_ammo_type_for_weapon(newweapon);
      fakepickup.origin = pickup.origin;
      fakepickup.count = weaponclipsize(newweapon);

      if(results == 5) {
        function_60234aa487445085(fakepickup, player);
      } else {
        function_8f0bd51f5c6108b(fakepickup, player);
      }

      if(isDefined(instance)) {
        loothide(instance);
      }
    } else if(isDefined(instance) && results == 22) {
      player function_1a13107253c400d(player, instance);
      return 1;
    } else {
      var_8dde4ac0085463fc = 1;
      var_bb9e46e1d8130f2 = level.br_pickups.br_hasautopickup[pickup.scriptablename];

      if(isDefined(bautouse) && isDefined(var_bb9e46e1d8130f2)) {
        if(bautouse && istrue(var_bb9e46e1d8130f2) && state == "visible") {
          var_8dde4ac0085463fc = 0;
        }
      }

      if(results == 38) {
        var_8dde4ac0085463fc = 0;
      }

      if(results == 17) {
        var_8dde4ac0085463fc = 0;
      }

      if(iscache(pickup.scriptablename)) {
        var_8dde4ac0085463fc = 0;
      }

      if(results == 9) {
        var_8dde4ac0085463fc = 0;
      }

      if(var_8dde4ac0085463fc) {
        if(results == 3) {
          player playlocalsound("weap_ammo_full");
        } else {
          player playlocalsound("br_pickup_deny");
        }

        player showuseresultsfeedback(results);
      }
    }
  }

  return 0;
}

function function_86321fc8f45c2a9b(bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  self.var_ff45e00f9ed1e5c9 = bool;
}

function function_b10ee40ed82d45c9(bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  self.isweaponfromcrate = bool;
}

function function_2a6a614936c17ac0(value) {
  if(isDefined(value)) {
    self.stock_override = int(value);
  }
}

function function_d3507041e41e9dd0(value) {
  if(isDefined(value)) {
    self.clip_override = int(value);
  }
}

function function_e44c2d69db881894(lootname) {
  if(isammo(lootname)) {
    if(!self usingtouch()) {
      var_509d86412c9d7426 = self getweaponslistprimaries();

      foreach(weap in var_509d86412c9d7426) {
        ammotypecomparison = br_ammo_type_for_weapon(weap);

        if(isDefined(ammotypecomparison) && lootname == ammotypecomparison && self.br_ammo[lootname] < level.var_e6ea72fc5e3fcd00[lootname]) {
          return 1;
        }
      }

      return 0;
    } else {
      return 1;
    }
  }

  if(isplunder(lootname)) {
    return 1;
  }

  if(isarmorplate(lootname)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(self.equipment[slot])) {
      return 1;
    }

    if(equipmentslothasroom(lootname, slot)) {
      return 1;
    }

    return 0;
  }

  if(isweaponpickup(lootname)) {
    if(self function_b096b58fb3808d26()) {
      return 1;
    } else if(getdvarint(@ "hash_4fe68158dff053c", 0)) {
      return 1;
    }
  }

  if(self usingtouch()) {
    var_bb9e46e1d8130f2 = 0;

    if(function_b989edd9af4f42c7(lootname)) {
      var_bb9e46e1d8130f2 = self function_6b75060e643e52e9() == 1;
    } else if(function_d7c5786a0c42ef6c(lootname)) {
      var_bb9e46e1d8130f2 = self function_c0a39abe7ec43ad8() == 1;
    } else if(iskillstreak(lootname)) {
      var_bb9e46e1d8130f2 = self function_3aa858d217fb4a1a() == 1;
    } else if(issuperpickup(lootname)) {
      var_bb9e46e1d8130f2 = self function_fa1da77265660058() == 1;
    } else if(isrevivepickup(lootname)) {
      var_bb9e46e1d8130f2 = self function_3feb119f85f6cd82() == 1;
    } else if(isgasmask(lootname)) {
      var_bb9e46e1d8130f2 = self function_50b964d023c440e8() == 1;
    } else if(function_4294e9b331377c31(lootname)) {
      var_bb9e46e1d8130f2 = self function_853086956ee45c36() == 1;
    }

    return var_bb9e46e1d8130f2;
  }

  return 0;
}

function showuseresultsfeedback(results) {
  switch (results) {
    case 30:
      scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANT_PICK_UP_WEAPON_WHILE_SWIMMING");
      return;
    case 28:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    case 3:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyammonoroom);
      return;
    case 4:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
      return;
    case 6:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmornotbetter);
      return;
    case 7:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveks);
      return;
    case 8:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.var_fa26185493a84cc6);
      return;
    case 14:
      thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SURIVAL/ALREADY_HAS_REVIVE", 2);
      return;
    case 9:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyparachuting);
      return;
    case 10:
      thread scripts\cp\cp_hud_message::tutorialprint(&"CP_INCURSION/ALREADY_HAVE_QUEST", 2);
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhavequest);
      return;
    case 21:
      thread scripts\cp\cp_hud_message::tutorialprint(&"CP_INCURSION/NEED_ASCENDER", 2);
      return;
    case 11:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyplunderpickup);
      return;
    case 13:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyweaponpickupap);
      return;
    case 15:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveplatepouch);
      return;
    case 16:
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
      return;
    case 40:
      scripts\cp\cp_hud_message::showerrormessage("EQUIPMENT/MUNITION_CANNOT_BE_PICKED_UP");
      return;
    case 2:
      break;
  }
}

function loothide(instance, part) {
  if(!isDefined(part)) {
    part = instance.type;
  }

  if(isquesttablet(instance.type)) {
    if(scripts\cp\utility::gameflag("prematch_done")) {
      level notify("tablethide_kill_callout_" + instance.origin);
    }

    if(getdvarint(@ "hash_82bde055b11e6698", 0)) {}
  }

  instance scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();

  if(isDefined(instance.itembox)) {
    instance.itembox notify("self_hidden");
  }

  instance notify("self_hidden");
  level notify("pickup_hidden", part);

  if(instance getscriptableisreserved() && isDefined(instance.brpickupscriptableid) && !istrue(instance.keepinmap)) {
    deregisterscriptableinstance(instance);
    instance freescriptable();
    return;
  }

  instance setscriptablepartstate(part, "hidden");
}

function clearspaceforscriptableinstance() {
  leveldata = level.br_pickups;
  assertex(isDefined(leveldata), "clearSpaceForScriptableInstance called before initArrays or br_pickups_init.");
  assertex(isDefined(leveldata.scriptables), "clearSpaceForScriptableInstance called before initScriptableManagement.");
  assertex(leveldata.scriptables.size <= leveldata.scriptablesmax, "number of scriptables exceeds the maximum");

  if(leveldata.scriptables.size < leveldata.scriptablesmax) {
    return;
  }

  var_406118f36ab85942 = 0;

  for(i = leveldata.scriptablesstartid; i < leveldata.scriptablescurid; i++) {
    if(var_406118f36ab85942 == leveldata.scriptablescleanupbatchsize) {
      break;
    }

    instance = leveldata.scriptables[i];

    if(isDefined(instance)) {
      leveldata.scriptables[i] = undefined;

      if(isent(instance)) {
        instance delete();
      } else {
        instance freescriptable();
      }

      var_406118f36ab85942++;
    } else {
      leveldata.scriptables[i] = undefined;
    }

    leveldata.scriptablesstartid++;
  }
}

function registerscriptableinstance(instance) {
  assertex(isDefined(level.br_pickups), "registerScriptableInstance called before initArrays or br_pickups_init.");
  assertex(isDefined(level.br_pickups.scriptables), "registerScriptableInstance called before initScriptableManagement.");
  assertex(!isDefined(instance.brpickupscriptableid), "registerScriptableInstance was called twice on the same instances.");
  id = level.br_pickups.scriptablescurid;
  instance.brpickupscriptableid = id;
  level.br_pickups.scriptables[id] = instance;
  level.br_pickups.scriptablescurid++;
}

function deregisterscriptableinstance(instance) {
  assertex(isDefined(level.br_pickups), "deregisterScriptableInstance called before initArrays or br_pickups_init.");
  assertex(isDefined(level.br_pickups.scriptables), "deregisterScriptableInstance called before initScriptableManagement.");
  assertex(isDefined(instance.brpickupscriptableid), "deregisterScriptableInstance called on an unregistered instance.");
  level.br_pickups.scriptables[instance.brpickupscriptableid] = undefined;
  instance.brpickupscriptableid = undefined;
}

function onusecompleted(pickupent, var_43fb3d97abb79854, bautouse, fromkiosk, var_db943473454f6ea6, instance, backpackequip) {
  level endon("game_ended");
  self endon("disconnect");
  pickupremains = 0;

  if(!isDefined(pickupent.count)) {
    pickupent.count = 0;
  }

  if(!istrue(var_43fb3d97abb79854)) {
    playpickupfeedback(pickupent, bautouse);
  }

  if(isDefined(pickupent.origin)) {
    level notify("pickedupweapon_kill_callout_" + pickupent.scriptablename + pickupent.origin);
  }

  level notify("pickedupweapon_all", pickupent);

  if(isplunder(pickupent.scriptablename)) {
    self notify("self_pickedupitem_" + "plunder");
  } else if(isweaponpickupitem(pickupent)) {
    var_8dd05205656e1dd4 = bautouse && getdvarint(@ "hash_4fe68158dff053c", 0);

    if(!var_8dd05205656e1dd4) {
      self notify("self_pickedupitem_" + "weapon", pickupent.scriptablename);
    }
  } else {
    self notify("self_pickedupitem_" + pickupent.scriptablename);
  }

  if(isweaponpickupitem(pickupent)) {
    if(bautouse && getdvarint(@ "hash_4fe68158dff053c", 0)) {
      weaponbasename = pickupent.customweaponname;
      weaponrootname = getweaponrootname(weaponbasename);
      clipsize = weaponclipsize(weaponbasename);
      var_7e7ac47753d9e2e3 = br_ammo_type_for_weapon(weaponrootname);
      var_c240d5bbb6b43a32 = br_ammo_give_type(self, var_7e7ac47753d9e2e3, pickupent.count - clipsize, 1, 1);
      pickupent.count = var_c240d5bbb6b43a32 + clipsize;
      instance.var_4c89ae940ca43b23 = 0;
      function_5baaa0ce73d6fe84(self);
      return 1;
    }

    if(istrue(instance.var_ff45e00f9ed1e5c9)) {
      pickupremains = 1;
    }

    takeweaponpickup(pickupent, var_db943473454f6ea6);
    scripts\cp_mp\challenges::onpickupitem("weapon");
  } else if(isammo(pickupent.scriptablename)) {
    pickupremains = takeammopickup(pickupent);
    function_5baaa0ce73d6fe84(self);
  } else if(isarmorplate(pickupent.scriptablename)) {
    pickupremains = takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
    thread scripts\cp_mp\armor::function_ef6d8b8c2ed89e8a(pickupent.count);
  } else if(function_4aa12e0ed3f6b745(pickupent.scriptablename)) {
    platelevel = function_692c3df266580df6(pickupent.scriptablename);
    self.platecarrierlevel = platelevel;
    self.maxarmorhealth = self.platecarrierlevel * 50;
    scripts\cp_mp\armor::setarmorhealth(self.maxarmorhealth);
  } else if(isequipment(pickupent.scriptablename) || function_15ecbc9a1a51007f(pickupent.scriptablename)) {
    pickupremains = takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(isarmor(pickupent.scriptablename)) {
    takearmorpickup(pickupent);
  } else if(pickupent.scriptablename == "Pillage_Cache" && isDefined(level.givetagsfromcache)) {
    self[[level.givetagsfromcache]]();
  } else if(isplunder(pickupent.scriptablename)) {
    takeplunderpickup(pickupent);
    scripts\cp_mp\challenges::onpickupitem("plunder");
  } else if(istokenpickup(pickupent.scriptablename)) {
    takerespawntokenpickup(pickupent);
  } else if(isrevivepickup(pickupent.scriptablename)) {
    takerevivepickup(pickupent);
  } else if(iskillstreak(pickupent.scriptablename)) {
    killstreakref = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];
    thread scripts\cp\kits::kit_givekillstreak(killstreakref, 1, 0, 0, 1, backpackequip, pickupent);
  } else if(function_240f7f4e57340e8f() && function_8ef153aa42520ac4(pickupent.scriptablename)) {
    var_630da9780891fbe9 = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];
    thread scripts\cp\kits::kit_givekillstreak(var_630da9780891fbe9, 1, 0, 0, 1, backpackequip, pickupent);
  } else if(issuperpickup(pickupent.scriptablename)) {
    takesuperpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(function_9e686ab118ac7725(pickupent.scriptablename)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "lootIntelFoundCallback")) {
      self[[scripts\engine\utility::getsharedfunc("game", "lootIntelFoundCallback")]](pickupent);
    }
  } else if(function_4294e9b331377c31(pickupent.scriptablename)) {
    if(!hasplatepouch()) {
      addplatepouch();

      if(!isDefined(pickupent.instance) || !istrue(pickupent.instance.var_d71f714a6b742e2)) {
        fillmaxarmorplate();
      }
    }
  } else if(pickupent.scriptablename == "brloot_ammo_grenade") {
    takegenericgrenadepickup(pickupent);
  } else {
    amount = 1;

    if(isDefined(pickupent.count)) {
      amount = pickupent.count;
    }

    trypickupitem(pickupent.scriptablename, amount);
  }

  amount = 1;

  if(isDefined(pickupent.count)) {
    amount = pickupent.count;
  }

  if(isDefined(pickupent.instance) && isDefined(pickupent.instance.uniquelootitemid)) {
    processuniquelootitem(pickupent.instance.uniquelootitemid, self);
  }

  return pickupremains;
}

function function_9e686ab118ac7725(lootname) {
  return issubstr(lootname, "jup_exgm_force_recon_");
}

function takesuperpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  supername = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];

  if(isDefined(backpackequip) && backpackequip) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(supername);
    scripts\cp_mp\pickups::function_6f39f9916649ac48(lootid, 1);
  }

  if(isDefined(self.superweapon)) {
    if(level.noinventory) {
      function_21779eb63ee9edb0(scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(self.supername), undefined, undefined, 1, undefined, undefined, 4, undefined, pickupent);
    } else {
      additemtobackpackbyref(self.supername, "super", 1);
    }
  }

  _givebrsuper(equipname, supername, pickupent.count);
  function_769d5ba5e4540f87(supername);

  if(istrue(level.allowsupers)) {}
}

function forcegivesuper(targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6) {
  if(istrue(level.var_d040719163e20394) && targetsupername == "none") {
    return;
  }

  var_733d60a5f3a8c170 = undefined;

  foreach(supername in level.br_pickups.var_14bd11727c4b6629) {
    if(supername == targetsupername) {
      var_733d60a5f3a8c170 = scriptablename;
      break;
    }
  }

  var_878c13a767e1d193 = undefined;

  if(!scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    assert(isDefined(var_733d60a5f3a8c170));
    var_878c13a767e1d193 = level.br_pickups.br_equipname[var_733d60a5f3a8c170];
    assert(isDefined(var_878c13a767e1d193));
  }

  if(istrue(droppurchased)) {
    dropbrequipment(fromkiosk, droppurchased, var_878c13a767e1d193);
    return;
  }

  if(istrue(dropcurrent)) {
    if(isDefined(self.equipment["super"]) && scripts\cp_mp\equipment::getequipmentslotammo("super") > 0) {
      dropequipmentinslot("super", fromkiosk, undefined, undefined, var_db943473454f6ea6);
    }
  }

  _givebrsuper(var_878c13a767e1d193, targetsupername, 1);
}

function function_35a73d6384babb13(lookupstring) {
  if(string_starts_with(lookupstring, "br_")) {
    return getsubstr(lookupstring, 3, lookupstring.size);
  }

  return lookupstring;
}

function takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  pickupremains = 0;

  if(pickupissameasequipmentslot(equipname, slot)) {
    if(equipmentslothasroom(pickupent.scriptablename, slot)) {
      if(slot != "health" && !self usingtouch()) {
        icontype = function_f77406a45e988898(equipname);
        scripts\cp_mp\damagefeedback::hudicontype(icontype);
      }

      var_5324597edfaff57c = scripts\cp_mp\equipment::getequipmentslotammo(slot);
      var_b5cdf4d935e6ac13 = scripts\cp_mp\equipment::getequipmentmaxammo(equipname);

      if(var_5324597edfaff57c + pickupent.count > var_b5cdf4d935e6ac13) {
        var_97c23a1323acc7df = var_b5cdf4d935e6ac13 - var_5324597edfaff57c;
        scripts\cp_mp\equipment::setequipmentammo(equipname, var_b5cdf4d935e6ac13);
        pickupent.count -= var_97c23a1323acc7df;
        pickupremains = 1;
      } else {
        scripts\cp_mp\equipment::incrementequipmentslotammo(slot, pickupent.count);
      }

      if(isDefined(var_db943473454f6ea6)) {
        function_84772ebf836af5db(var_db943473454f6ea6, -1 * (var_b5cdf4d935e6ac13 - var_5324597edfaff57c));
        pickupremains = 0;
      }

      if(pickupremains && isbackpackinventoryenabled() && !isDefined(var_db943473454f6ea6)) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
        additemtobackpack(lootid, pickupent);
        pickupremains = 0;
      }
    } else if(isbackpackinventoryenabled() && !istrue(backpackequip)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      additemtobackpack(lootid, pickupent);
      pickupremains = 0;
    }
  } else if(!isDefined(self.equipment[slot]) || scripts\cp_mp\equipment::getequipmentslotammo(slot) == 0) {
    var_b5cdf4d935e6ac13 = scripts\cp_mp\equipment::getequipmentmaxammo(equipname);
    scripts\cp_mp\equipment::giveequipment(equipname, slot);

    if(pickupent.count > var_b5cdf4d935e6ac13) {
      var_97c23a1323acc7df = var_b5cdf4d935e6ac13;
      scripts\cp_mp\equipment::setequipmentammo(equipname, var_b5cdf4d935e6ac13);
      pickupent.count -= var_97c23a1323acc7df;
      pickupremains = 1;
    } else {
      scripts\cp_mp\equipment::setequipmentammo(equipname, pickupent.count);
    }

    function_c33f5b700efef63b(slot, equipname);

    if(pickupremains && isbackpackinventoryenabled()) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      additemtobackpack(lootid, pickupent);
      pickupremains = 0;
    }

    if(isDefined(var_db943473454f6ea6)) {
      setbackpackitematindex(var_db943473454f6ea6, 0, 0);
    }
  } else if(isbackpackinventoryenabled() && !isDefined(var_db943473454f6ea6)) {
    count = 1;

    if(isDefined(pickupent.count)) {
      count = pickupent.count;
    }

    if(istrue(pickupent.var_54ac5c5126489388)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      additemtobackpack(lootid, pickupent);
    } else {
      trypickupitem(pickupent.scriptablename, count);
    }
  } else {
    if(isDefined(var_db943473454f6ea6)) {
      if(pickupent.maxcount == 0) {
        pickupent.maxcount = level.br_pickups.var_4138f9ddc1cd22d[pickupent.scriptablename];
      }

      newamount = min(pickupent.maxcount, pickupent.count);
      function_84772ebf836af5db(var_db943473454f6ea6, -1 * newamount);
    }

    if(!istrue(level.var_ad82058550e7696b)) {
      dropequipmentinslot(slot, fromkiosk, undefined, undefined, var_db943473454f6ea6);
    }

    scripts\cp_mp\equipment::giveequipment(equipname, slot);
    scripts\cp_mp\equipment::setequipmentammo(equipname, pickupent.count);
    function_c33f5b700efef63b(slot, equipname);
  }

  return pickupremains;
}

function function_276e0e89c09af369(slot, lootid, ammocount, pickupent) {
  fakepickup = spawnStruct();
  fakepickup.scriptablename = function_91c1be871300a518(lootid);
  fakepickup.count = ammocount;

  if(level.noinventory) {
    dropequipmentinslot(slot, undefined, undefined, undefined, undefined, undefined, undefined, undefined, pickupent);
  } else {
    quantity = setbackpackitem(lootid, fakepickup);

    if(quantity > 0) {
      dropequipmentinslot(slot, undefined, undefined, quantity);
    }
  }

  takeequipment(slot);
}

function function_21779eb63ee9edb0(equipindex, fromkiosk, var_273a070109cfc7e0, ammocount, var_db943473454f6ea6, allowautopickup, itemtype, dropfeedback, pickupent) {
  function_73ffc9bcd6d1e62d(fromkiosk);
  placementindex = 0;

  if(isDefined(var_273a070109cfc7e0)) {
    placementindex = var_273a070109cfc7e0;
  }

  if(isDefined(var_db943473454f6ea6)) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(equipindex);
    fakepickup = spawnStruct();
    fakepickup.scriptablename = function_91c1be871300a518(lootid);
    fakepickup.count = ammocount;
    quantity = setbackpackitem(lootid, fakepickup);

    if(quantity > 0) {
      var_285b7129b392cf3d = 0;

      if(isDefined(itemtype)) {
        var_285b7129b392cf3d = quickdropaddtoexisting(itemtype, fakepickup.scriptablename, quantity);
      }

      if(var_285b7129b392cf3d) {
        return;
      }

      dropinfo = getitemdroporiginandangles(placementindex, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride, undefined, undefined, pickupent);
      item = spawnpickup(equipindex, dropinfo, quantity, 1, undefined, isalive(self));
      quickdropaddtocache(fakepickup.scriptablename, placementindex, item, dropinfo.origin, dropinfo.angles);
      function_2f4e0022c686dbe6(item);

      if(istrue(dropfeedback)) {
        quickdropplaySound(itemtype, dropinfo.origin, fakepickup.scriptablename, item);
      }
    }

    return;
  }

  var_285b7129b392cf3d = 0;
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(equipindex);
  scriptablename = function_91c1be871300a518(lootid);

  if(isDefined(itemtype)) {
    var_285b7129b392cf3d = quickdropaddtoexisting(itemtype, scriptablename, ammocount);
  }

  if(var_285b7129b392cf3d) {
    return;
  }

  dropinfo = getitemdroporiginandangles(placementindex, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, undefined, undefined, undefined, pickupent);

  if(issuperpickup(scriptablename)) {
    allowautopickup = getdvarint(@ "hash_8c7fd24cb9dc68f0", 0) || isDefined(allowautopickup) && allowautopickup && isalive(self);
  }

  item = spawnpickup(equipindex, dropinfo, ammocount, 1, undefined, allowautopickup);
  quickdropaddtocache(scriptablename, placementindex, item, dropinfo.origin, dropinfo.angles);
  function_2f4e0022c686dbe6(item);

  if(istrue(dropfeedback)) {
    quickdropplaySound(itemtype, dropinfo.origin, scriptablename, item);
  }
}

function dropequipmentinslot(slot, fromkiosk, var_273a070109cfc7e0, ammocountoverride, var_db943473454f6ea6, allowautopickup, itemtype, dropfeedback, pickupent) {
  ammocount = scripts\cp_mp\equipment::getequipmentslotammo(slot);

  if(isDefined(ammocountoverride)) {
    ammocount = ammocountoverride;
  }

  if(!isDefined(allowautopickup)) {
    allowautopickup = 1;
  }

  if(!isDefined(self.equipment[slot])) {
    return;
  }

  var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment[slot]);

  if(isDefined(var_feb782334dd23a66)) {
    function_21779eb63ee9edb0(var_feb782334dd23a66, fromkiosk, var_273a070109cfc7e0, ammocount, var_db943473454f6ea6, allowautopickup, itemtype, dropfeedback, pickupent);
  }
}

function giveequipment(ref, slot) {
  scripts\cp_mp\equipment::giveequipment(ref, slot);
}

function is_equipment_slot_allowed(slot) {
  switch (slot) {
    case #"hash_325cb2e66f67d5b9":
      return val::get("equipment_primary");
    case #"hash_511d3c24fcedcdb1":
      return val::get("equipment_secondary");
    default:
      return 1;
  }
}

function takeequipment(slot) {
  assert(isDefined(slot));
  ref = scripts\cp_mp\equipment::getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }

  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    ref = function_f16f02e6c6ff945a(ref);
    tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);
  }

  if(isDefined(tableinfo) && isDefined(tableinfo.objweapon)) {
    if(self hasweapon(tableinfo.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(tableinfo.objweapon);

      if(slot == "primary") {
        self clearoffhandprimary();
      } else if(slot == "secondary") {
        self clearoffhandsecondary();
      }
    }
  }

  self.equipment[slot] = undefined;
  self notify("equipment_taken_" + ref);
}

function getkioskyawoffsetoverride() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    finaloffset = level.var_e9f7702d839b262c;

    if(level.randomanglemax > 0) {
      finaloffset += randomfloatrange(level.randomanglemax * -1, level.randomanglemax);
    }

    return finaloffset;
  }

  return 180 + randomfloatrange(-10, 10);
}

function function_66361755731d772a(pickupent, scriptablename) {
  if(isplunder(scriptablename)) {
    return getcashsoundaliasforplayer(self, scriptablename);
  }

  if(isDefined(level.br_pickups.br_pickupsfx[scriptablename]) && level.br_pickups.br_pickupsfx[scriptablename].size > 0) {
    return level.br_pickups.br_pickupsfx[scriptablename];
  }

  if(isweaponpickupitem(pickupent)) {
    return "pickup_weap";
  }

  return "pickup_ammo";
}

function function_e53db8cc244f396b(pickupent, scriptablename) {
  if(isplunder(pickupent.scriptablename)) {
    return "br_plunder";
  }

  if(isammo(pickupent.scriptablename)) {
    return "br_ammo";
  }

  if(isarmorplate(pickupent.scriptablename)) {
    return "br_armor";
  }
}

function player_play_pickup_anim(pickupent) {
  self notify("player_play_pickup_anim");
  self endon("player_play_pickup_anim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !playercanplaynotcriticalgesture()) {
    return;
  }

  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(weapobj)) {
    if(self isgestureplaying("iw9_ges_pickup")) {
      self stopgestureviewmodel("iw9_ges_pickup", 0, 1);
    }

    self takeweapon(weapobj);
    waitframe();
  }

  playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
}

function playerplaygestureweaponanim(weaponref, animtime) {
  self endon("death_or_disconnect");
  weapobj = makeweapon(weaponref);
  self giveandfireoffhand(weapobj);
  wait animtime;

  if(self hasweapon(weapobj)) {
    self takeweapon(weapobj);
  }
}

function takeplunderpickup(pickupent) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  amount = 1;

  if(isDefined(pickupent.count)) {
    amount = pickupent.count;
  }

  if(array_contains(level.br_plunder.names, pickupent.scriptablename)) {
    playerplunderpickup(amount);
    level.br_plunder.plunder_items_picked_up += 1;
    level.br_plunder.plunder_value_picked_up += amount;
    modify_plunder_itemsinworld(pickupent.scriptablename, -1);
    type = "loot";

    if(isDefined(pickupent.instance.lootsource)) {
      type = pickupent.instance.lootsource;
    }

    return;
  }

  trypickupitem(pickupent.scriptablename, amount);
}

function playerplunderpickupcallback(amount, entity, data) {
  if(!isDefined(data)) {
    data = createplayerplundereventdata(self);
  }

  if(istrue(level.var_be46ed9fde731e08)) {
    data.playplundersound = 0;
  }

  return data;
}

function playerplunderlosecallback(amount, entity, data) {
  if(!isDefined(data)) {
    data = createplayerplundereventdata(self);
  }

  return data;
}

function createplayerplundereventdata(player, team) {
  data = spawnStruct();
  data.player = undefined;

  if(isDefined(player)) {
    data.player = player;
  }

  data.playersplash = undefined;
  data.playerscoreeventref = undefined;
  data.playerscoreeventvalue = undefined;
  data.setplunderifunchanged = undefined;
  data.playplundersound = 1;
  data.plundersoundamount = undefined;
  data.playanimation = undefined;
  return data;
}

function playerplunderpickup(amount, data, wasscoreevent) {
  return playerplunderevent(amount, 1, undefined, data, wasscoreevent);
}

function playerplunderevent(amount, type, entity, data, wasscoreevent) {
  if(!istrue(level.br_plunder_enabled) || !isDefined(self.plundercount)) {
    return;
  }

  if(istrue(wasscoreevent) && amount <= 0) {
    return;
  }

  if(level.gameended && amount == 0) {
    return;
  }

  assertex(isDefined(level.playerplundereventomnvars), "playerPlunderEvent() was called before initPlayerPlunderEvents().");
  assertex(amount > 0, "playerPlunderEvent amount must be a positive value.Example: player playerPlunderEvent( 500, PLUNDER_EVENT_TYPE_LOSE ).");

  if(type == 2 || type == 3 || type == 4) {
    amount = int(min(self.plundercount, amount));
  }

  if(!isDefined(self.plundereventtime)) {
    self.plundereventtime = [];
  }

  if(!isDefined(self.plundereventtotal)) {
    self.plundereventtotal = [];
  }

  if(!isDefined(self.lastplundereventtype)) {
    self.lastplundereventtype = 0;
  }

  omnvartype = ter_op(type == 5, 3, type);
  omnvar = level.playerplundereventomnvars[omnvartype];
  plundereventtotal = self.plundereventtotal[type];
  plundereventtime = self.plundereventtime[type];

  if(!isDefined(plundereventtime) || gettime() - plundereventtime > 2000) {
    plundereventtotal = 0;
  }

  plundereventtotal += amount;

  if(isPlayer(self) && isDefined(omnvar)) {
    omnvarvalue = int(min(plundereventtotal, self.plundercount + amount));
    self setclientomnvar(omnvar, omnvarvalue);
  }

  self.lastplundereventtype = type;
  self.plundereventtime[type] = gettime();
  self.plundereventtotal[type] = plundereventtotal;
  plundereventcallback = level.playerplundereventcallbacks[type];

  if(isDefined(plundereventcallback)) {
    data = self[[plundereventcallback]](amount, entity, data);
  }

  if(isDefined(data)) {
    if(isDefined(data.player)) {
      if(isDefined(data.playersplash) && data.playersplash != "none") {
        if(data.playersplash != "br_plunder_first_pickup" || !istrue(data.player.haspickedupplunderyet)) {
          data.player thread scripts\cp\cp_hud_message::showsplash(data.playersplash);

          if(data.playersplash == "br_plunder_first_pickup") {
            data.player.haspickedupplunderyet = 1;
          }
        }
      }

      if(isDefined(data.playerscoreeventref) && (!isDefined(data.playerscoreeventvalue) || data.playerscoreeventvalue > 0)) {
        data.player thread scripts\cp\points::doscoreevent(data.playerscoreeventref, undefined, data.playerscoreeventvalue);
      }
    }

    if(isDefined(data.amount)) {
      amount = data.amount;
    }

    if(istrue(data.playplundersound)) {
      soundamount = ter_op(isDefined(data.plundersoundamount), data.plundersoundamount, amount);
      playplundersoundbyamount(self, soundamount);
    }
  }

  switch (type) {
    case 2:
    case 3:
    case 4:
      amount *= -1;
      break;
    case 5:
    case 6:
      amount = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(amount)) {
    data.plunderdelta = amount;
    thread playersetplundercount(self.plundercount + amount, data);
  }

  return data;
}

function playplundersoundbyamount(player, amount) {
  if(amount == 0) {
    return;
  }

  var_3466c10973e9c476 = getplundernamebyamount(amount);
  soundalias = getcashsoundaliasforplayer(player, var_3466c10973e9c476);
  player playsoundtoplayer(soundalias, self);
}

function getplundernamebyamount(amount) {
  assertex(isDefined(level.br_plunder) && isDefined(level.br_plunder.quantity) && isDefined(level.br_plunder.names), "getPlunderNameByAmount called before setupQuantities.");
  var_3466c10973e9c476 = level.br_plunder.names[0];

  for(i = level.br_plunder.quantity.size - 1; i > 0; i--) {
    if(amount >= level.br_plunder.quantity[i]) {
      var_3466c10973e9c476 = level.br_plunder.names[i];
      break;
    }
  }

  return var_3466c10973e9c476;
}

function getcashsoundaliasforplayer(player, var_3466c10973e9c476) {
  pickup_sfx = "br_pickup_cash";
  var_41426f97882c68fb = 5000;
  var_d8c56288c4b1c484 = var_41426f97882c68fb / 1000;
  now = gettime();

  if(isPlayer(player)) {
    if(!isDefined(player.br_cash_count)) {
      player.br_cash_count = 0;
    }

    if(!isDefined(player.br_cash_time)) {
      player.br_cash_time = now;
    }

    cashdelta = now - player.br_cash_time;
    player.br_cash_time = now;

    if(cashdelta < var_41426f97882c68fb) {
      player.br_cash_count += 1;
    }

    assert(isDefined(player.br_cash_count));

    switch (var_3466c10973e9c476) {
      case #"hash_192a14ffd18243fb":
      case #"hash_192a15ffd182458e":
      case #"hash_b64903f6ab579d1c":
      default:
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_cash_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_cash_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_cash_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_cash_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_cash_05";
            break;
        }

        break;
      case #"hash_192a16ffd1824721":
      case #"hash_8f5e151d9e4dfc51":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_cash_med_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_cash_med_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_cash_med_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_cash_med_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_cash_med_05";
            break;
        }

        break;
      case #"hash_364c01bf1db279e8":
      case #"hash_364c04bf1db27ea1":
      case #"hash_8f5e121d9e4df798":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_cash_lrg_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_cash_lrg_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_cash_lrg_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_cash_lrg_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_cash_lrg_05";
            break;
        }

        break;
      case #"hash_266af6147dbd8916":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_cash_vlrg_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_cash_vlrg_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_cash_vlrg_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_cash_vlrg_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_cash_vlrg_05";
            break;
        }

        break;
    }
  }

  return pickup_sfx;
}

function processuniquelootitem(uniquelootitemid, player) {
  if(isDefined([[level.br_pickups.uniquelootcallbacks[uniquelootitemid]]](player))) {
    return;
  }

  assertmsg("There is no callback for the unique loot ID specified.");
}

function trypickupitem(scriptablename, count) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups.maxcounts[scriptablename]) || !isDefined(level.br_pickups.stackable[scriptablename])) {
    return;
  }

  pickup = spawnStruct();
  pickup.scriptablename = scriptablename;
  pickup.count = count;
  pickup.maxcount = level.br_pickups.maxcounts[scriptablename];
  pickup.stackable = level.br_pickups.stackable[scriptablename];
  pickup.itemtype = level.br_pickups.br_itemtype[scriptablename];

  if(canslotitem(pickup.scriptablename, pickup.count)) {
    pickupitemintoinventory(pickup);
    return;
  }

  self iprintlnbold("No room in inventory");
  self playlocalsound("br_pickup_deny");
}

function pickupitemintoinventory(pickup) {
  if(ispickupstackable(pickup.scriptablename)) {
    if(canstackpickup(pickup.scriptablename, pickup.count)) {
      foreach(item in self.br_inventory_slots) {
        if(isDefined(item.scriptablename) && item.scriptablename == pickup.scriptablename) {
          if(!isitemfull(item, pickup.count)) {
            item.count += pickup.count;
            item.count = int(min(item.count, pickup.maxcount));
            return;
          }
        }
      }
    }
  }

  firstopenslot = getfirstopenslot();

  if(firstopenslot == -1) {
    return;
  }

  self.br_inventory_slots[firstopenslot] = pickup;
}

function isitemfull(item, pickupcount) {
  return pickupcount + item.count > item.maxcount;
}

function canstackpickup(scriptablename, pickupcount) {
  foreach(item in self.br_inventory_slots) {
    if(isDefined(item.scriptablename) && item.scriptablename == scriptablename) {
      if(!isitemfull(item, pickupcount)) {
        return true;
      }
    }
  }

  return false;
}

function getfirstopenslot() {
  for(i = 0; i < 8; i++) {
    if(!isDefined(self.br_inventory_slots[i])) {
      return i;
    }
  }

  return -1;
}

function canslotitem(scriptablename, pickupcount) {
  if(ispickupstackable(scriptablename)) {
    if(canstackpickup(scriptablename, pickupcount)) {
      return 1;
    }
  }

  return isitemslotopen();
}

function isitemslotopen() {
  for(i = 0; i < 8; i++) {
    if(!isDefined(self.br_inventory_slots[i])) {
      return true;
    }
  }

  return false;
}

function takeammopickup(pickupent) {
  var_c240d5bbb6b43a32 = 0;

  if(pickupent.scriptablename == "Ammo_Crate") {
    weaponobj = self getcurrentweapon();
    weaponbasename = weaponobj.basename;
    weaponrootname = getweaponrootname(weaponbasename);
    clipsize = weaponclipsize(weaponbasename);
    ammotype = br_ammo_type_for_weapon(weaponobj);

    if(isDefined(ammotype)) {
      var_c240d5bbb6b43a32 = br_ammo_give_type(self, ammotype, clipsize);
    }
  } else {
    var_c240d5bbb6b43a32 = br_ammo_give_type(self, pickupent.scriptablename, pickupent.count, 1);
  }

  if(var_c240d5bbb6b43a32) {
    pickupent.count = var_c240d5bbb6b43a32;
    pickupremains = 1;
  } else {
    pickupremains = 0;
  }

  return pickupremains;
}

function function_99e27ed6b392b6a9(pickupent) {
  pickupremains = 0;

  if(isDefined(pickupent.count)) {
    var_6018edf2459ae384 = ter_op(pickupent.count > level.var_c4e3d516b4ea7be7, level.var_c4e3d516b4ea7be7, pickupent.count);
    pickupent.count = scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(var_6018edf2459ae384);

    if(isDefined(pickupent.count) && pickupent.count > 0) {
      pickupremains = 1;
    }
  }

  return pickupremains;
}

function function_31374ab57f6a7926(pickupent) {
  pickupremains = 1;
  return pickupremains;
}

function function_355165dac88b5d17(pickupent) {
  pickupremains = 1;
  scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(2);
  return pickupremains;
}

function function_e1809c1ea94194d8(pickupent) {
  var_c240d5bbb6b43a32 = 0;
  weaponbasename = self getcurrentprimaryweapon();
  ammotype = br_ammo_type_for_weapon(weaponbasename);

  if(isDefined(ammotype)) {
    var_dc6cffbd65a99ae8 = level.var_e6ea72fc5e3fcd00[ammotype];
    var_c240d5bbb6b43a32 = br_ammo_give_type(self, ammotype, var_dc6cffbd65a99ae8);
  }

  if(var_c240d5bbb6b43a32) {
    pickupremains = 1;
  } else {
    pickupremains = 0;
  }

  return pickupremains;
}

function br_ammo_give_type(player, ammotype, amount, dropleftovers, var_dff84541dcb30d24) {
  if(!isDefined(dropleftovers)) {
    dropleftovers = 0;
  }

  if(br_ammo_type_player_full(player, ammotype, var_dff84541dcb30d24)) {
    br_ammo_update_weapons(player);

    if(dropleftovers) {
      return amount;
    } else {
      return 0;
    }
  }

  var_2c86af91e7e20602 = 0;
  player.br_ammo[ammotype] += amount;

  if(player.br_ammo[ammotype] > level.br_ammo_max[ammotype]) {
    var_2c86af91e7e20602 = player.br_ammo[ammotype] - level.br_ammo_max[ammotype];

    if(isbackpackinventoryenabled() && !istrue(var_dff84541dcb30d24)) {
      var_bada25504e8844d7 = spawnStruct();
      var_bada25504e8844d7.scriptablename = ammotype;
      var_bada25504e8844d7.count = var_2c86af91e7e20602;
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
      player additemtobackpack(lootid, var_bada25504e8844d7, !dropleftovers);
      var_2c86af91e7e20602 = 0;
    } else if(dropleftovers && var_2c86af91e7e20602 < level.br_ammo_clipsize[ammotype]) {
      var_2c86af91e7e20602 = 0;
    }

    player.br_ammo[ammotype] = level.var_e6ea72fc5e3fcd00[ammotype];
  }

  player br_ammo_player_hud_update_ammotype(ammotype);
  br_ammo_update_weapons(player);

  if(dropleftovers) {
    return var_2c86af91e7e20602;
  }

  return 1;
}

function br_ammo_type_player_full(player, ammotype, var_dff84541dcb30d24) {
  if(!isDefined(ammotype)) {
    return true;
  }

  if(!isDefined(player.br_ammo) || !isDefined(player.br_ammo[ammotype])) {
    return false;
  }

  if(!isDefined(level.var_e6ea72fc5e3fcd00[ammotype])) {
    assert("Ammo type '" + ammotype + "' does not have a max ammo count assigned! Please set this in the loot table.");
    return false;
  }

  if(isbackpackinventoryenabled() && !istrue(var_dff84541dcb30d24)) {
    return false;
  }

  return get_int_or_0(player.br_ammo[ammotype]) >= level.var_e6ea72fc5e3fcd00[ammotype];
}

function takearmorpickup(pickupent) {
  armorperkname = level.br_pickups.br_equipname[pickupent.scriptablename];
  armorbetter = isarmorbetterthanequipped(armorperkname);

  if(armorbetter) {
    tryequiparmor(pickupent);
  }
}

function isarmorbetterthanequipped(armorname) {
  helmetlevel = 0;

  if(armorname == "equip_helmet_1") {
    helmetlevel = 1;
  } else if(armorname == "equip_helmet_2") {
    helmetlevel = 2;
  } else if(armorname == "equip_helmet_3") {
    helmetlevel = 3;
  }

  if(helmetlevel > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < helmetlevel) {
      return true;
    }
  }

  return false;
}

function tryequiparmor(item, slot) {
  if(isDefined(slot)) {
    self.br_inventory_slots[slot] = undefined;
  }
}

function takerevivepickup(pickupent) {
  pickupremains = 0;

  if(getdvarint(@ "hash_bd54dd62349d46c8", 0) == 1 && isDefined(self.hasselfrevivetoken) && self.hasselfrevivetoken == 1) {
    removeselfrevivetoken();
  }

  if(!has_auto_revive() && !function_3ea84ab28dea3f8()) {
    addselfrevivetoken();
    pickupremains = 0;
    self.pers["dropped_initial_revive_token"] = undefined;
  } else {
    scripts\cp\cp_hud_message::tutorialprint(&"CP_SURIVAL/ALREADY_HAS_REVIVE", 2);
    pickupremains = 1;
  }

  if(getdvarint(@ "hash_41ab31c3b86aa5b1", 0) == 1) {
    delete_revives();
  }

  return pickupremains;
}

function sethasselfrevivetokenextrainfo(value) {
  if(istrue(value)) {
    self.game_extrainfo |= 65536;
    return;
  }

  self.game_extrainfo &= ~65536;
}

function addselfrevivetoken(skipsplash, var_7405289ebaf266bd) {
  if(istrue(self.hasselfrevivetoken)) {
    if(!istrue(var_7405289ebaf266bd)) {
      scripts\cp\cp_hud_message::tutorialprint(&"CP_SURIVAL/ALREADY_HAS_REVIVE", 2);
    }

    return;
  }

  scripts\cp\laststand::enable_self_revive();
  self.pers["has_revive_token"] = 1;
  sethasselfrevivetokenextrainfo(1);
  self.hasselfrevivetoken = 1;

  if(!isDefined(self.var_9f4e140e6dcbc55d)) {
    self.var_9f4e140e6dcbc55d = [];
  }

  self.var_9f4e140e6dcbc55d[self.var_9f4e140e6dcbc55d.size] = set_carry_item(self, "self_revive");

  if(!istrue(skipsplash)) {
    thread scripts\cp\cp_hud_message::showsplash("br_self_revive_token_pickup");
  }

  if(!_hasperk("specialty_pistoldeath")) {
    giveperk("specialty_pistoldeath");
  }
}

function removeselfrevivetoken() {
  player = self;
  player.hasselfrevivetoken = 0;
  player sethasselfrevivetokenextrainfo(0);
  player function_98f7ca3781dac77c(player, "self_revive");
  issolos = level.maxteamsize == 1;

  if(issolos && player _hasperk("specialty_pistoldeath")) {
    player scripts\cp\perks::removeperk("specialty_pistoldeath");
  }

  if(function_240f7f4e57340e8f()) {
    namespace_9766820f5baa93fb::function_316420283a77f32b("selfrevive", 0);
  }
}

function takeweaponpickup(pickupent, var_db943473454f6ea6) {
  var_af6bdfd2f2ee7bad = getdvarint(@ "hash_fbf5d62954cafb35", 0);
  var_29893f13d84d295f = isDefined(pickupent) && isDefined(pickupent.instance);

  if(var_29893f13d84d295f) {
    var_c9e3aab3cb667506 = istrue(pickupent.instance.var_b5c99a0d29afb1ac) || isDefined(pickupent.instance.itembox) || istrue(pickupent.instance.isweaponfromcrate);
  } else {
    var_c9e3aab3cb667506 = 0;
  }

  if(var_af6bdfd2f2ee7bad || isDefined(pickupent.instance.var_b5c99a0d29afb1ac) && pickupent.instance.var_b5c99a0d29afb1ac == 1) {
    var_fc705b68988ae946 = self.origin;
  } else {
    var_fc705b68988ae946 = pickupent.origin;
  }

  println("<dev string:x129>" + var_fc705b68988ae946);
  println("<dev string:x13e>" + self.origin);

  if(function_240f7f4e57340e8f()) {
    if(isDefined(pickupent.instance.var_5c3c19452417fd1c) && pickupent.instance.var_5c3c19452417fd1c == 1) {
      var_9b7df99df9e2fe65 = pickupent.instance.var_9b7df99df9e2fe65;
      var_7bf99486a11d01e4 = pickupent.instance.lootid;
      self setclientomnvar("ui_new_item_discovered", var_7bf99486a11d01e4);
      function_10e81f91fc857e5e(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), var_9b7df99df9e2fe65, 1);
      function_a0d4a0a7264d1772(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), var_9b7df99df9e2fe65, 1);
      self setprogressiondata("spProgData", level.var_82191bfa9f751f4c + "_should_show_loadout", 1);
    }
  }

  var_7b9de6db6a90dbe7 = 0;
  numprimaries = self.primaryweapons.size;
  newweaponinfo = function_55c5d35c8c76a95b(pickupent);
  newweapon = newweaponinfo[0];
  newweaponbasename = newweaponinfo[1];
  weaponname = newweaponinfo[2];
  assert(isDefined(newweapon));
  assert(isDefined(newweaponbasename));
  assert(isDefined(weaponname));
  var_7dc30386b50647a1 = 0;
  var_ec22a950f210e39 = undefined;

  foreach(weap in self.primaryweapons) {
    if(isnullweapon(weap)) {
      numprimaries--;
      continue;
    }

    if(issameweapon(weap, newweapon)) {
      var_7dc30386b50647a1 = 1;
      var_ec22a950f210e39 = weap;
    }
  }

  if(numprimaries > 1 && !var_7dc30386b50647a1) {
    if(!self hasweapon("iw9_me_fists_mp")) {
      var_7dc30386b50647a1 = 1;
    } else {
      self takeweapon("iw9_me_fists_mp");
    }
  }

  if(var_7dc30386b50647a1) {
    if(istrue(pickupent.isautouse) && getdvarint(@ "hash_f84e49a704687827", 0)) {
      var_ec22a950f210e39 = function_823964aa15b30575();
      var_7b9de6db6a90dbe7 = isDefined(var_ec22a950f210e39) && !issameweapon(var_ec22a950f210e39, self getcurrentweapon());
    }

    if(!isDefined(var_ec22a950f210e39)) {
      var_ec22a950f210e39 = self.lastdroppableweaponobj;
    }

    assert(var_ec22a950f210e39.basename != "none");

    if(var_ec22a950f210e39.basename != "none") {
      var_28aebe3dd6733ed3 = undefined;
      var_1af8fe94ee02a80f = undefined;
      var_961012dd15fa29ee = undefined;
      dirtoitem = pickupent.origin - self.origin;
      yaw = vectortoyaw(dirtoitem);
      var_c02997b2deff6e69 = 1;

      if(istrue(pickupent.instance.var_ff45e00f9ed1e5c9)) {
        var_fc705b68988ae946 = self.origin;
        pickupent.instance disablescriptableplayeruse(self);
      }

      if(istrue(level.var_f478c1f94caa7e9) && !function_efab78b72d131d76(self)) {
        function_8107fe0feec27866(self, var_ec22a950f210e39);
        var_c02997b2deff6e69 = 0;
      } else if(isDefined(var_db943473454f6ea6) && function_3ab0a87eeaa203bf()) {
        function_64f6ebff728689ab(self, var_ec22a950f210e39);
        rootname = scripts\cp_mp\weapon::getweaponrootname(var_ec22a950f210e39);
        variantid = var_ec22a950f210e39.variantid;

        if(!isDefined(var_ec22a950f210e39.variantid)) {
          variantid = 0;
        }

        lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
        setbackpackitematindex(var_db943473454f6ea6, lootid, 1);
        var_c02997b2deff6e69 = 0;
      } else {
        var_28aebe3dd6733ed3 = self getweaponammoclip(var_ec22a950f210e39);
        var_1af8fe94ee02a80f = self getweaponammoclip(var_ec22a950f210e39, "left");
        var_961012dd15fa29ee = 0;

        if(var_ec22a950f210e39.hasalternate) {
          var_5d9b5b689a1846c8 = var_ec22a950f210e39 getaltweapon();
          var_961012dd15fa29ee = self getweaponammoclip(var_5d9b5b689a1846c8);
        }

        if(!isriotshield(var_ec22a950f210e39)) {
          ammostock = self getweaponammostock(var_ec22a950f210e39);
          weaponammotype = br_ammo_type_for_weapon(var_ec22a950f210e39);

          if(isDefined(weaponammotype)) {
            self.br_ammo[weaponammotype] = ammostock;
          }
        }

        if(var_c02997b2deff6e69) {
          if(istrue(pickupent.instance.var_97331585b4002aa7) && !var_c9e3aab3cb667506) {
            dropinfo = getitemdropinfo(pickupent.instance.origin, pickupent.instance.angles, 0, undefined, 1);
          } else {
            dropinfo = getitemdroporiginandangles(0, var_fc705b68988ae946, (0, yaw, 0), self, 0, 0, undefined, undefined);
          }

          dropinfo.var_54ed99022c529d4a = 1;
          item = weaponspawn(var_ec22a950f210e39, self, dropinfo, 0, undefined, undefined, pickupent);

          if(isDefined(item)) {
            assert(isDefined(var_28aebe3dd6733ed3));
            assert(isDefined(var_1af8fe94ee02a80f));
            assert(isDefined(var_961012dd15fa29ee));
            loot_setitemcount(item, var_28aebe3dd6733ed3, var_1af8fe94ee02a80f, var_961012dd15fa29ee);

            if(function_b1dd9dcae2f63965()) {
              function_8e7e1da48d7746e5(self, item);
            }

            for(i = 0; i < self.primaryweapons.size; i++) {
              if(issameweapon(self.primaryweapons[i], var_ec22a950f210e39)) {
                weaponref = int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, self.var_ff741d59e10631a[i]));
                weapon_camo = function_c7771194200d360e(weaponref);
                var_79ff1ab6ab43cb7d = function_1cc3fd00b6ccc3ba(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, self.var_ff741d59e10631a[i])));
                var_79ff1ab6ab43cb7d = function_c4080e8a53a0fed4(var_79ff1ab6ab43cb7d);
                weaponvariantid = function_64ccc54bdbae5cf6(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, self.var_ff741d59e10631a[i])));
                weapontocheck = scripts\cp_mp\weapon::buildweapon_blueprint(var_79ff1ab6ab43cb7d, weapon_camo, undefined, weaponvariantid);

                if(issameweapon(var_ec22a950f210e39, weapontocheck)) {
                  item.var_9b7df99df9e2fe65 = self.var_ff741d59e10631a[i];
                  continue;
                }

                item.var_9b7df99df9e2fe65 = -1;
              }
            }

            level notify("droppedweapon", item);
            var_e637ee4faed5d14d = 1;
            self notify("dropped_weapon_scriptable", item, undefined, dropinfo.origin);
          }
        }
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_ec22a950f210e39);
    }
  } else if(isDefined(var_db943473454f6ea6)) {
    [lootid, quantity] = function_6738846da50730f1(var_db943473454f6ea6);
    function_6f39f9916649ac48(lootid, 1);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponname);
  self notify("pickedupweapon", weaponname);
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint) {
    thread scripts\cp\loadout::function_7da7bd24b280d295();
  }

  if(istrue(newweapon.isweaponfromcrate) || istrue(pickupent.isweaponfromcrate)) {
    ammotype = br_ammo_type_for_weapon(newweapon);

    if(isDefined(ammotype)) {
      clipsize = weaponclipsize(newweapon);
      maxstock = scripts\cp\pickups::function_ecdfc73e68dcc209(ammotype);
      br_ammo_give_type(self, ammotype, maxstock);
    }
  } else {
    var_c1192c297bbf292f = pickupent.count;
    var_7b7b94efe2e96d4b = pickupent.countlefthand;
    clipsize = weaponclipsize(newweapon);
    var_31b36738ff4eacd = 0;

    if(var_c1192c297bbf292f > clipsize) {
      var_31b36738ff4eacd += var_c1192c297bbf292f - clipsize;
      var_c1192c297bbf292f = clipsize;
    }

    if(var_7b7b94efe2e96d4b > clipsize) {
      var_31b36738ff4eacd += var_7b7b94efe2e96d4b - clipsize;
      var_7b7b94efe2e96d4b = clipsize;
    }

    self setweaponammoclip(weaponname, var_c1192c297bbf292f);
    self setweaponammoclip(weaponname, var_7b7b94efe2e96d4b, "left");

    if(var_31b36738ff4eacd > 0) {
      ammotype = br_ammo_type_for_weapon(newweapon);

      if(isDefined(ammotype)) {
        br_ammo_give_type(self, ammotype, var_31b36738ff4eacd);
      }
    }

    if(newweapon.hasalternate) {
      var_c883522792ef6bba = pickupent.countalt;
      var_84c947974132a108 = newweapon getaltweapon();
      var_26f2db792005350e = br_ammo_type_for_weapon(var_84c947974132a108);

      if(var_26f2db792005350e != br_ammo_type_for_weapon(newweapon)) {
        altclipsize = weaponclipsize(var_84c947974132a108);

        if(!isDefined(var_c883522792ef6bba)) {
          var_c883522792ef6bba = altclipsize;
        }

        if(var_c883522792ef6bba > altclipsize) {
          var_c883522792ef6bba -= altclipsize;
        }

        br_ammo_give_type(self, var_26f2db792005350e, var_c883522792ef6bba);
        self setweaponammoclip(var_84c947974132a108, altclipsize);
      }
    }
  }

  ammotype = undefined;

  if(isDefined(newweapon)) {
    ammotype = br_ammo_type_for_weapon(newweapon);
  }

  if(isDefined(ammotype)) {
    br_ammo_update_ammotype_weapons(self, ammotype, self.br_ammo[ammotype]);
  }

  if(!istrue(var_7b9de6db6a90dbe7)) {
    self assignweaponprimaryslot(weaponname);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponname);
    scripts\cp_mp\weapon::fixupplayerweapons(self, weaponname);
    scripts\cp\weapon::updatelastweaponobj(newweapon);
  }

  if(isDefined(pickupent.weapon) && isent(pickupent.weapon)) {
    pickupent.weapon delete();
  }

  newweaponobj = undefined;

  foreach(weapon in self.equippedweapons) {
    if(isweapon(weapon) && weapon.inventorytype == "primary") {
      completeweaponname = getcompleteweaponname(weapon);

      if(completeweaponname == weaponname) {
        newweaponobj = weapon;
        break;
      }
    }
  }

  if(isDefined(pickupent.instance)) {
    level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_trigger(pickupent.instance, self, newweapon);
  }

  if(istrue(pickupent.instance.var_da00cb32efd73efc)) {
    thread function_f58ee288a541af2e(newweapon);
  }

  var_9b7df99df9e2fe65 = pickupent.instance.var_9b7df99df9e2fe65;

  for(i = 0; i < self.primaryweapons.size; i++) {
    if(issameweapon(self.primaryweapons[i], newweapon)) {
      if(i == 0) {
        if(isDefined(var_9b7df99df9e2fe65) && var_9b7df99df9e2fe65 != -1) {
          function_b28ea2077fe04c46(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "primaryWeapon", var_9b7df99df9e2fe65);
          self.var_ff741d59e10631a[0] = var_9b7df99df9e2fe65;

          if(self.var_ff741d59e10631a[1] == self.var_ff741d59e10631a[0]) {
            self.var_ff741d59e10631a[1] = item.var_9b7df99df9e2fe65;
            function_b28ea2077fe04c46(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "secondaryWeapon", item.var_9b7df99df9e2fe65);
          }
        }

        continue;
      }

      if(i == 1) {
        if(isDefined(var_9b7df99df9e2fe65) && var_9b7df99df9e2fe65 != -1) {
          function_b28ea2077fe04c46(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "secondaryWeapon", var_9b7df99df9e2fe65);
          self.var_ff741d59e10631a[1] = var_9b7df99df9e2fe65;

          if(self.var_ff741d59e10631a[1] == self.var_ff741d59e10631a[0]) {
            self.var_ff741d59e10631a[0] = item.var_9b7df99df9e2fe65;
            function_b28ea2077fe04c46(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "primaryWeapon", item.var_9b7df99df9e2fe65);
          }
        }
      }
    }
  }
}

function function_f58ee288a541af2e(newweapon) {
  if(function_1bb1470f934a81eb()) {
    return;
  }

  waitframe();

  while(self isswitchingweapon() || self israisingweapon()) {
    waitframe();
  }

  ads_amount = self playerads();

  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || ads_amount > 0 || istrue(self.insertingarmorplate)) {
    return;
  }

  self function_7781b1e34507328();
}

function private function_64f6ebff728689ab(player, weapon) {
  if(isriotshield(weapon)) {
    return;
  }

  clipammo = player getweaponammoclip(weapon);
  weaponammotype = br_ammo_type_for_weapon(weapon);

  if(isDefined(weaponammotype)) {
    self.br_ammo[weaponammotype] += clipammo;
  }
}

function br_ammo_update_weapons(player) {
  if(!isDefined(player)) {
    return;
  }

  var_509d86412c9d7426 = player getweaponslistprimaries();

  foreach(weap in var_509d86412c9d7426) {
    wammotype = br_ammo_type_for_weapon(weap);

    if(isDefined(wammotype)) {
      newstockammo = get_int_or_0(player.br_ammo[wammotype]);
      player function_4906c10c3ffdd4ca(weap, newstockammo);
    }
  }

  player notify("ammo_update");
}

function function_bc12e1ef44f08efa() {
  if(!isDefined(self)) {
    return;
  }

  var_509d86412c9d7426 = self getweaponslistprimaries();

  foreach(weap in var_509d86412c9d7426) {
    wammotype = br_ammo_type_for_weapon(weap);

    if(isDefined(wammotype)) {
      currentstock = self getweaponammostock(weap);
      newstockammo = get_int_or_0(self.br_ammo[wammotype]);
      br_ammo_max = level.var_e6ea72fc5e3fcd00[wammotype];
      var_190b69d94afe0a15 = currentstock + newstockammo;

      if(var_190b69d94afe0a15 >= br_ammo_max) {
        var_190b69d94afe0a15 = br_ammo_max;
      }

      self.br_ammo[wammotype] = var_190b69d94afe0a15;
    }
  }

  self notify("ammo_update");
}

function function_1d23b39eb17b338() {
  if(!isDefined(self)) {
    return;
  }

  var_509d86412c9d7426 = self getweaponslistprimaries();

  foreach(weap in var_509d86412c9d7426) {
    wammotype = br_ammo_type_for_weapon(weap);

    if(isDefined(wammotype)) {
      newstockammo = self getweaponammostock(weap);
      newstockammo = get_int_or_0(newstockammo);
      weaponammotype = br_ammo_type_for_weapon(weap);
      br_ammo_give_type(self, weaponammotype, newstockammo, 0);
    }
  }
}

function spawnpickup(pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt) {
  if(!isDefined(dropinfo)) {
    println("<dev string:x14f>");
    return;
  }

  if(dropinfo.origin == (0, 0, 0)) {
    println("<dev string:x14f>");
    return;
  }

  assert(isDefined(dropinfo.origin));
  assert(isDefined(dropinfo.angles));
  assert(isDefined(dropinfo.payload));
  var_ef809b0ee883bcc7 = 0;
  is_weapon = isDefined(weaponobj);
  assert(isDefined(pickupname));
  scriptabledefname = undefined;

  if(isDefined(level.br_pickups.br_weapontoscriptable[pickupname])) {
    scriptabledefname = level.br_pickups.br_weapontoscriptable[pickupname];
  } else if(isvalidcustomweapon(weaponobj)) {
    weaponclasstoken = scripts\cp_mp\weapon::getweaponclasstoken(weaponobj.basename);

    if(weaponclasstoken != "me" && weaponclasstoken != "pi" && weaponclasstoken != "sh" && weaponclasstoken != "sm" && weaponclasstoken != "ar" && weaponclasstoken != "lm" && !scripts\cp_mp\weapon::isminigunweapon(weaponobj) && weaponclasstoken != "dm" && weaponclasstoken != "sn" && weaponclasstoken != "la" && weaponclasstoken != "kn") {
      println("<dev string:x19b>" + weaponobj.basename);
      return;
    }

    var_ef809b0ee883bcc7 = 1;
    scriptabledefname = "brloot_weapon_generic_" + weaponclasstoken;
  } else if(isdroppablepickup(pickupname)) {
    scriptabledefname = pickupname;
  }

  if(!isDefined(scriptabledefname)) {
    assertex(!isdroppablepickup(pickupname), "No scriptable found for item " + pickupname);
    return;
  }

  if(!istrue(dropinfo.var_97331585b4002aa7)) {
    dropinfo.angles = (0, dropinfo.angles[1], 0);

    if(scriptabledefname == "brloot_weapon_me_riotshield_epic" || isvalidcustomweapon(weaponobj) && isriotshield(weaponobj)) {
      dropinfo.angles = (dropinfo.angles[0] - 90, dropinfo.angles[1], dropinfo.angles[2]);
      dropinfo.origin = (dropinfo.origin[0], dropinfo.origin[1], dropinfo.origin[2] + 2);
    }

    if(issubstr(scriptabledefname, "la_juliet")) {
      dropinfo.angles = (dropinfo.angles[0] - 4.2, dropinfo.angles[1], dropinfo.angles[2] - 90);
      dropinfo.origin = (dropinfo.origin[0], dropinfo.origin[1], dropinfo.origin[2] + 8.5);
    }

    if(scriptabledefname == "brloot_offhand_gas") {
      dropinfo.angles = (dropinfo.angles[0], dropinfo.angles[1] - 90, dropinfo.angles[2]);
    }

    if(scriptabledefname == "brloot_offhand_shockstick") {
      dropinfo.angles = (dropinfo.angles[0], dropinfo.angles[1] - 180, dropinfo.angles[2]);
    }

    if(issubstr(pickupname, "iw9_dm_crossbow_mp")) {
      dropinfo.angles = (dropinfo.angles[0], dropinfo.angles[1], dropinfo.angles[2] + 90);
      dropinfo.origin = (dropinfo.origin[0], dropinfo.origin[1], dropinfo.origin[2] + 7);
    }
  }

  clearspaceforscriptableinstance();

  if(var_ef809b0ee883bcc7) {
    item = spawncustomweaponscriptable(scriptabledefname, dropinfo.origin, dropinfo.angles, dropinfo.payload, weaponobj);

    if(isDefined(item)) {
      item.customweaponname = getcompleteweaponname(weaponobj);
    }
  } else {
    item = spawnscriptable(scriptabledefname, dropinfo.origin, dropinfo.angles, dropinfo.payload);
  }

  if(!isDefined(item)) {
    return;
  }

  if(isDefined(dropinfo.groundentity)) {
    localorigin = rotatevectorinverted(dropinfo.origin - dropinfo.groundentity.origin, dropinfo.groundentity.angles);
    localangles = combineangles(invertangles(dropinfo.groundentity.angles), dropinfo.angles);
    item utility::scriptable_setparententity(dropinfo.groundentity, localorigin, localangles);
  }

  registerscriptableinstance(item);

  if(isDefined(count)) {
    loot_setitemcount(item, count, countlefthand, countalt);
  } else {
    loot_setitemcount(item, 0);
  }

  if(!isDefined(allowautopickup)) {
    allowautopickup = 1;
  }

  if(!istrue(level.br_pickups.br_hasautopickup[scriptabledefname])) {
    allowautopickup = 1;
  }

  item function_828247536ca07ac1(scriptabledefname, dropinfo, is_weapon, allowautopickup, showtrail);
  createcallback = level.br_pickups.createcallbacks[scriptabledefname];

  if(isDefined(createcallback)) {
    item[[createcallback]]();
  }

  return item;
}

function function_828247536ca07ac1(scriptabledefname, dropinfo, is_weapon, allowautopickup, showtrail) {
  state = function_3646de62d5cf4d0d(scriptabledefname, dropinfo, is_weapon, allowautopickup, showtrail);

  if(!isDefined(state)) {
    return;
  }

  if(self getscriptableparthasstate(scriptabledefname, state)) {
    self setscriptablepartstate(scriptabledefname, state);
  }
}

function function_3646de62d5cf4d0d(scriptabledefname, dropinfo, is_weapon, allowautopickup, showtrail) {
  state = undefined;

  if(istrue(dropinfo.var_97331585b4002aa7)) {
    if(istrue(dropinfo.var_54ed99022c529d4a)) {
      state = "visible_original_position_no_outline";
    } else {
      state = "visible_original_position_subtle_outline";
    }

    self.var_97331585b4002aa7 = 1;
    return state;
  }

  if(!getdvarint(@ "hash_61e10de0f675e9ad")) {
    var_d9a07b7746ada099 = getdvarint(@ "hash_8d10ede0f25e6d2e");

    if(istrue(showtrail)) {
      if(allowautopickup) {
        state = "dropped";
      } else {
        assert(istrue(level.br_pickups.br_hasautopickup[scriptabledefname]));
        state = "droppedNoAuto";

        if(var_d9a07b7746ada099 || !self getscriptableparthasstate(scriptabledefname, state)) {
          state = "dropped";
        }
      }
    } else if(!allowautopickup) {
      assert(istrue(level.br_pickups.br_hasautopickup[scriptabledefname]));
      state = "noAuto";

      if(var_d9a07b7746ada099 || !self getscriptableparthasstate(scriptabledefname, state)) {
        state = "dropped";
      }
    }
  }

  if(function_240f7f4e57340e8f()) {
    state = function_4160979a238b2cd5(scriptabledefname, dropinfo, is_weapon, state, allowautopickup);
  }

  return state;
}

function function_4160979a238b2cd5(scriptabledefname, dropinfo, is_weapon, state, allowautopickup) {
  if(istrue(dropinfo.var_54ed99022c529d4a)) {
    return "visible_no_outline";
  }

  if(!isDefined(state)) {
    return function_82d002965498f57d(dropinfo, is_weapon, allowautopickup);
  }

  if(state == "droppedNoAuto") {
    state = "dropped_no_outline_noauto";
  } else if(state == "noAuto") {
    if(istrue(dropinfo.var_a61783b788746c54)) {
      state = "noAuto_no_outline";
    } else {
      state = "noAuto_subtle_outline";
    }
  } else {
    return function_82d002965498f57d(dropinfo, is_weapon, allowautopickup);
  }

  return state;
}

function function_82d002965498f57d(dropinfo, is_weapon, allowautopickup) {
  state = undefined;

  if(istrue(dropinfo.var_a61783b788746c54)) {
    state = "dropped_no_outline";
  } else if(istrue(dropinfo.var_b5c99a0d29afb1ac)) {
    state = "visible_sublte_outline";
  } else if(istrue(allowautopickup)) {
    state = "dropped_subtle_outline";
  } else if(dropinfo.payload == 0) {
    state = "visible_sublte_outline";
  }

  return state;
}

function isvalidcustomweapon(weaponobj) {
  if(!isDefined(weaponobj)) {
    return false;
  }

  if(!isweapon(weaponobj)) {
    return false;
  }

  if(isnullweapon(weaponobj)) {
    return false;
  }

  if(scripts\cp\weapon::isfistweapon(weaponobj) || scripts\cp\weapon::isgunlessweapon(weaponobj) || scripts\cp\weapon::ismeleeoverrideweapon(weaponobj)) {
    return false;
  }

  return true;
}

function isdroppablepickup(pickupname) {
  return true;
}

function weaponspawn(weaponobj, droppingplayer, dropinfo, firstspawn, showtrail, count, pickupent) {
  if(!isDefined(count)) {
    count = weaponclipsize(weaponobj) * 3;
  }

  if(isDefined(pickupent) && isDefined(pickupent.instance)) {
    altammo = function_3a5f7703319142dd(pickupent.instance);
  }

  completeweaponname = getcompleteweaponname(weaponobj);
  weaponpickup = spawnpickup(completeweaponname, dropinfo, count, showtrail, weaponobj, undefined, undefined, altammo);
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(weaponpickup, droppingplayer, weaponobj);
  return weaponpickup;
}

function function_b3b99f9f9371c997(weapon) {
  switch (weapon.inventorytype) {
    case #"hash_325cb2e66f67d5b9":
      break;
    default:
      return false;
  }

  rootname = getweaponrootname(weapon);

  switch (rootname) {
    case #"hash_b742b20d3ace6197":
    case #"hash_db653a4972b3c13b":
    case #"hash_f80d7ed55e765a1f":
      return false;
  }

  return true;
}

function makeweaponfromcrate(dropnum) {
  var_5fba91f7c0fc9c89 = random(level.br_pickups.br_crateguns);
  fullweaponobj = getfullweaponobjforscriptablepartname(var_5fba91f7c0fc9c89);

  if(!isDefined(fullweaponobj)) {
    return;
  }

  groundpos = drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[dropnum], 50, -200, (0, 0, 1)) + (0, 0, 24);
  weapon = createspawnweaponatpos(groundpos, (0, 0, 90), fullweaponobj);

  if(isDefined(weapon)) {
    weapon.isweaponfromcrate = 1;
  }

  return weapon;
}

function createspawnweaponatpos(pos, angles, fullweaponobj, var_ec821bafdc44f38c, count) {
  if(!isDefined(count)) {
    count = weaponclipsize(fullweaponobj) * 3;
  }

  if(isstring(fullweaponobj)) {
    fullweaponobj = makeweaponfromstring(fullweaponobj);
  }

  if(!istrue(var_ec821bafdc44f38c)) {
    trace = scripts\engine\trace::ray_trace(pos, (pos[0], pos[1], pos[2] - 60));

    if(trace["fraction"] < 1) {
      pos = trace["position"] + (0, 0, 2);
    }
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 90);
  }

  dropinfo = getitemdropinfo(pos, angles);
  return weaponspawn(fullweaponobj, undefined, dropinfo, 1, 1, count);
}

function function_8a9c22c541e0dd5b(fullweaponobj, var_3ace5ac9c7d6fa44) {
  dropinfo = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self, undefined, undefined, undefined, var_3ace5ac9c7d6fa44, undefined);
  dropinfo.var_a61783b788746c54 = 1;
  return weaponspawn(fullweaponobj, undefined, dropinfo, 1);
}

function br_ammo_type_for_weapon(weapon) {
  weapclass = undefined;
  weapclass = getweapongroup(weapon);

  if(!isstring(weapon) && isDefined(weapon.underbarrel)) {
    var_d0a536d5580f1bde = issubstr(weapon.underbarrel, "selectsemi") || issubstr(weapon.underbarrel, "selectauto") || issubstr(weapon.underbarrel, "selectburst");

    if(istrue(weapon.isalternate) && !var_d0a536d5580f1bde) {
      if(scripts\cp_mp\weapon::function_de04e13ab01e1a10(weapon.underbarrel)) {
        weapclass = "weapon_shotgun";
      } else {
        weapclass = "weapon_projectile";
      }
    } else {
      weapclass = getweapongroup(weapon);
    }
  }

  return function_a2fa56c4e1c77ba9(weapclass);
}

function function_a2fa56c4e1c77ba9(weapclass) {
  switch (weapclass) {
    case #"hash_6f796b5c69cec63":
    case #"hash_34340d457a63e7f1":
    case #"hash_ab10f9c080fe4faf":
      return "brloot_ammo_919";
    case #"hash_16cf6289ab06bd30":
      return "brloot_ammo_12g";
    case #"hash_bef5ec0b3e197ae":
    case #"hash_8af0086b038622b5":
    case #"hash_dd616da0b395a0b0":
      return "brloot_ammo_762";
    case #"hash_47368bc0d2ef1565":
    case #"hash_c095d67337b1f5a1":
      return "brloot_ammo_50cal";
    case #"hash_9d18adab1b65a661":
      return "brloot_ammo_rocket";
  }

  return undefined;
}

function getweapongroup(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return "other";
  }

  if(isstring(weapon) && (weapon == "none" || weapon == "alt_none")) {
    return "other";
  }

  if(isstring(weapon)) {
    rootname = weapon;
  } else {
    rootname = getweaponrootname(weapon);
  }

  group = weapongroupmap(rootname);

  if(!isDefined(group)) {
    if(issuperweapon(weapon)) {
      group = "super";
    } else if(iskillstreakweapon(weapon)) {
      group = "killstreak";
    } else {
      group = "other";
    }
  }

  return group;
}

function cantakepickup(pickup) {
  if(!function_240f7f4e57340e8f() && !isDefined(scripts\cp\loot_system::get_empty_munition_slot(self)) && scripts\cp\munitions::function_af07aad35b55fd73(pickup.scriptablename)) {
    hint_prompt("munition_slots_full", 1, 2);
    self playlocalsound("br_pickup_deny");
    return 0;
  }

  if(self isskydiving() || self isparachuting()) {
    return 9;
  }

  if(function_240f7f4e57340e8f() && scripts\cp\munitions::function_af07aad35b55fd73(pickup.scriptablename)) {
    if(!val::get("cp_munitions_pickup")) {
      return 40;
    }

    return 1;
  }

  if(isammo(pickup.scriptablename)) {
    var_fb40d5954b4f6792 = canholdammobox(pickup.scriptablename);

    if(isbackpackinventoryenabled()) {
      return function_f8a3ff0a73fa0c1d(pickup, var_fb40d5954b4f6792);
    } else if(var_fb40d5954b4f6792) {
      return 1;
    } else {
      return 4;
    }
  }

  isautouse = istrue(pickup.isautouse);

  if(isweaponpickupitem(pickup)) {
    if(isautouse && getdvarint(@ "hash_4fe68158dff053c", 0)) {
      weaponbasename = pickup.customweaponname;
      weaponrootname = getweaponrootname(weaponbasename);
      clipsize = weaponclipsize(weaponbasename);

      if(pickup.count - clipsize <= 0) {
        return 38;
      }

      var_7e7ac47753d9e2e3 = br_ammo_type_for_weapon(weaponrootname);

      if(br_ammo_type_player_full(self, var_7e7ac47753d9e2e3, 1)) {
        return 38;
      } else {
        return 1;
      }
    }

    if(scripts\cp_mp\oxygenmask::function_23a6763562820c70()) {
      return 30;
    }

    current_weapon = self getcurrentprimaryweapon();

    if(scripts\cp_mp\equipment\stimpistol::function_76ca0b3d8b2555ca(current_weapon)) {
      return 30;
    }

    if(!val::get("weapon_pickup") || function_8c58cd733dfc8cce(pickup.customweaponname)) {
      if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_pickupdenyequipnoroom)) {
        full_message = level.br_pickups.br_pickupdenyequipnoroom;

        if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]](full_message);
        }

        return 0;
      }
    }

    if(istrue(self.insertingarmorplate)) {
      return 13;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return 17;
    }

    newweapon = function_55c5d35c8c76a95b(pickup)[0];

    foreach(weap in self.primaryweapons) {
      if(issameweapon(weap, newweapon)) {
        fakepickup = spawnStruct();
        fakepickup.scriptablename = br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);

        if(isminigunweapon(newweapon)) {
          currammo = self getweaponammoclip(weap);

          if(currammo == weaponclipsize(weap)) {
            return 3;
          }

          var_97c3703f332729d6 = min(currammo + 100, fakepickup.count);
          self setweaponammoclip(weap, int(var_97c3703f332729d6));
          return 5;
        }

        result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(pickup.scriptablename, weap));

        if(result == 1) {
          result = 5;
        } else if(result == 20) {
          result = 27;
        }

        return result;
      }
    }

    if(isbackpackinventoryenabled() && function_3ab0a87eeaa203bf()) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    if(self function_b096b58fb3808d26()) {
      if(isautouse && !function_c8a5593cbb13f17c(pickup, newweapon)) {
        return 12;
      }

      self.var_e7f6950ddc75ef66 = gettime();
    }

    return 1;
  }

  if(isequipment(pickup.scriptablename) || function_15ecbc9a1a51007f(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    equipname = level.br_pickups.br_equipname[pickup.scriptablename];
    slot = level.equipment.table[equipname].defaultslot;
    pickupcount = 1;

    if(isDefined(pickup.count)) {
      pickupcount = pickup.count;
    }

    if(isautouse && (slot == "primary" || slot == "secondary")) {
      if(isDefined(self.equipment[slot]) && pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(pickup.scriptablename, slot)) {
        return 1;
      }

      if(!isbackpackinventoryenabled()) {
        if(self usingtouch() && (!isDefined(self.equipment[slot]) || scripts\cp_mp\equipment::getequipmentslotammo(slot) == 0)) {
          return 1;
        }

        return 12;
      }
    }

    if(!isDefined(self.equipment[slot]) || scripts\cp_mp\equipment::getequipmentslotammo(slot) == 0) {
      return 1;
    }

    if(pickupissameasequipmentslot(equipname, slot)) {
      if(equipmentslothasroom(pickup.scriptablename, slot)) {
        return 1;
      } else if(isbackpackinventoryenabled() && equipname != "equip_armorplate") {
        return function_cbbf9bf3544dc456(pickup, isautouse);
      } else {
        return 4;
      }
    } else if(getdvarint(@ "hash_3d3e000ab3fdf69e", 0) == 1) {
      if(isDefined(self.equipment[slot])) {
        lootid = scripts\cp_mp\utility\loot::getlootidfromref(self.equipment[slot]);
        function_276e0e89c09af369(slot, lootid, getequipmentammo(self.equipment[slot]), pickup);
      }

      return 1;
    }

    if(isbackpackinventoryenabled()) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }

    if(!isbackpackinventoryenabled()) {
      return 1;
    }

    if(!canslotitem(pickup.scriptablename, pickupcount)) {
      return 4;
    } else {
      return 1;
    }
  }

  if(isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit) {
      return 11;
    }

    return 1;
  }

  if(isgasmask(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    if(self usingtouch() && isautouse && scripts\cp_mp\gasmask::hasgasmask(self)) {
      return 12;
    }

    return 1;
  }

  if(function_6b5f3fb6550ae6d5(pickup.scriptablename)) {
    if(isbackpackinventoryenabled()) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    return 1;
  }

  if(isquesttablet(pickup.scriptablename)) {
    if(pickup.scriptablename == "brloot_blueprintextract_tablet") {
      return 1;
    } else {
      alreadyhavequest = undefined;

      if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
        alreadyhavequest = array_contains(level.questinfo.teamsonquests, self.team);
      } else {
        alreadyhavequest = function_7094c7010c5e3827(self.team);
      }

      if(alreadyhavequest) {
        return 10;
      } else {
        return 1;
      }
    }
  }

  if(isperkpointpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self.var_ca56839b2e00edce)) {
      return 16;
    }

    return 1;
  }

  if(function_362d5a8d49b93721(pickup.scriptablename)) {
    if(isDefined(level.var_6a2eac0ef4a956cb)) {
      return [[level.var_6a2eac0ef4a956cb]](self, pickup);
    }

    return 20;
  }

  if(istokenpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self.var_ca56839b2e00edce)) {
      return 16;
    }

    if(pickup.scriptablename == "brloot_respawn_token") {
      if(hasrespawntoken()) {
        return 8;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(function_9e686ab118ac7725(pickup.scriptablename)) {
    return 1;
  }

  if(isrevivepickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self.var_ca56839b2e00edce)) {
      return 16;
    }

    if(pickup.scriptablename == "brloot_self_revive") {
      if(scripts\cp\laststand::hasselfrevivetoken() && getdvarint(@ "hash_bd54dd62349d46c8", 0) == 0) {
        return 14;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(iskillstreak(pickup.scriptablename)) {
    killstreakref = level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename];

    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    if(istrue(function_a7cc24f3a189746a(killstreakref))) {
      if(killstreakref == "circle_peek") {
        if(!isDefined(level.teamswithcirclepeek[self.team])) {
          level.teamswithcirclepeek[self.team] = 0;
        }

        var_2c18d9be706d7ad7 = level.teamswithcirclepeek[self.team] + level.br_circle.circleindex + 1;

        if(var_2c18d9be706d7ad7 >= level.circlepeeks.size) {
          return 19;
        }
      }

      return 1;
    }

    if(iskillstreakweapon(self getcurrentweapon())) {
      return 7;
    }

    if(isbackpackinventoryenabled() && function_d674d32c2d3ba5ed(self)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename]) {
      return 7;
    } else if(self usingtouch() && isautouse && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size != 0) {
      return 12;
    } else {
      return 1;
    }
  }

  if(issuperpickup(pickup.scriptablename)) {
    if(!val::get("cp_supers_pickup")) {
      return 37;
    }

    if(istrue(self.isjuggernaut) && !istrue(self.var_ca56839b2e00edce)) {
      return 16;
    }

    if(!scripts\cp\super::issuperinuse()) {
      equipammo = scripts\cp_mp\equipment::getequipmentslotammo("super");

      if(self usingtouch() && isautouse && isDefined(equipammo) && equipammo != 0) {
        return 12;
      } else if(getsubgametype() != "dmz" && getsubgametype() != "exgm" || !isDefined(equipammo) || equipammo == 0) {
        return 1;
      }
    }

    if(isbackpackinventoryenabled()) {
      if(function_5e7049647595ab97() || scripts\cp\super::issuperinuse()) {
        result = function_cbbf9bf3544dc456(pickup);

        if(result == 4 && !scripts\cp\super::issuperinuse()) {
          return 1;
        } else {
          return result;
        }
      }
    }

    return 4;
  }

  if(isarmor(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    if(scripts\cp_mp\armor::function_cd4a78b4a236ddc8(level.br_pickups.br_equipname[pickup.scriptablename])) {
      return 1;
    } else {
      return 6;
    }
  }

  if(function_4294e9b331377c31(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    if(isbackpackinventoryenabled()) {
      pickup.scriptablename = "brloot_armor_plate";
      pickup.count = scripts\cp_mp\armor::function_47320a25b8ee003();
      pickup.count -= scripts\cp_mp\armor::function_600f6cf462e983f();
      return function_99ab09ba7022d107(pickup);
    }

    if(hasplatepouch() && !function_240f7f4e57340e8f()) {
      return 15;
    }

    return 1;
  }

  if(function_51adf909541800d7(pickup.scriptablename)) {
    namespace_ee632c9a776f5f85::function_b4492a14e5453ff9();
    namespace_ee632c9a776f5f85::function_a0ea72ada55fbd51(pickup.instance);

    if(self.platecarrierlevel >= namespace_ee632c9a776f5f85::function_6f16016c53d6cf63()) {
      thread namespace_ee632c9a776f5f85::function_5bb1ea396e15a905();
    }

    return 1;
  }

  if(isaccesscard(pickup.scriptablename)) {
    if(isbackpackinventoryenabled()) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isattachment(pickup.scriptablename)) {
    if(isbackpackinventoryenabled()) {
      return function_cbbf9bf3544dc456(pickup);
    }
  }

  if(isxp(pickup.scriptablename)) {
    return 1;
  }

  if(function_f262c137ed78e6eb(pickup.scriptablename)) {
    return 1;
  }

  if(iskey(pickup.scriptablename)) {
    if(isbackpackinventoryenabled()) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      index = function_e05897f5d860188e(lootid, pickup.count, 0);

      if(isDefined(index)) {
        keystruct = function_6738846da50730f1(index);

        if(isDefined(keystruct) && isDefined(keystruct[1]) && keystruct[1] > 2) {
          return 23;
        }
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(function_f92615e29aff3602(pickup.scriptablename)) {
    if(isDefined(pickup.instance.team) && self.team == pickup.instance.team) {
      return 1;
    } else {
      return 4;
    }
  }

  if(function_32125eba262380c7(pickup.scriptablename)) {
    if(isDefined(level.var_d8db1602c8bf473e) && isDefined(level.var_d8db1602c8bf473e[pickup.scriptablename])) {
      result = [[level.var_d8db1602c8bf473e[pickup.scriptablename]]](pickup, self);

      if(isDefined(result)) {
        return result;
      }
    }

    return 1;
  }

  if(pickup.scriptablename == "brloot_ammo_grenade") {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0) {
      return 16;
    }

    var_f2b2c8de93ebf806 = scripts\cp_mp\equipment::getequipmentslotammo("primary");
    var_e93897bc10c40746 = scripts\cp_mp\equipment::getequipmentslotammo("secondary");

    if(isDefined(var_f2b2c8de93ebf806) && var_f2b2c8de93ebf806 < 2 || isDefined(var_e93897bc10c40746) && var_e93897bc10c40746 < 2) {
      return 1;
    } else {
      return 3;
    }
  }

  if(pickup.scriptablename == "Pillage_Cache") {
    return 1;
  }

  if(function_609bb538ed61b8d7(pickup.scriptablename)) {
    return 22;
  }

  if(function_cb1e30930c35f2e2(pickup.scriptablename) && level.gametype == "dungeons") {
    return 1;
  }

  if(isvaluable(pickup.scriptablename) || ispersonal(pickup.scriptablename) || function_cb1e30930c35f2e2(pickup.scriptablename) || function_5449da9d3d0358a4(pickup.scriptablename)) {
    if(isbackpackinventoryenabled()) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(function_4aa12e0ed3f6b745(pickup.scriptablename)) {
    platelevel = function_692c3df266580df6(pickup.scriptablename);

    if(self.platecarrierlevel < platelevel) {
      return 1;
    } else if(self.platecarrierlevel == platelevel) {
      return 25;
    } else {
      return 26;
    }
  }

  return 2;
}

function function_8c58cd733dfc8cce(weaponname) {
  if(!isDefined(weaponname)) {
    return 0;
  }

  switch (weaponname) {
    case #"hash_b742b20d3ace6197":
      return 1;
    default:
      return 0;
  }
}

function function_d381554fdc8cdfa3() {
  current_weapon = self getcurrentweapon();
  root_weapon = getweaponrootname(current_weapon);

  switch (root_weapon) {
    case #"hash_10101350333ad041":
    case #"hash_75742af6018d77f5":
      return 0;
    default:
      return 1;
  }
}

function function_d3e48c0b2febbeca() {
  weapon = self getcurrentweapon();
  weaponammotype = br_ammo_type_for_weapon(weapon);
  result = br_ammo_type_player_full(self, weaponammotype);
  return result;
}

function getequipmentslotammo(slot) {
  ref = scripts\cp_mp\equipment::getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  return getequipmentammo(ref);
}

function getcurrentequipment(slot) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[slot];
}

function getequipmentammo(ref) {
  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    ref = function_f16f02e6c6ff945a(ref);
    tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);
  }

  if(!isDefined(tableinfo)) {
    ref = function_f16f02e6c6ff945a(ref);
    tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);
  }

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  return self getammocount(tableinfo.objweapon);
}

function function_f16f02e6c6ff945a(equipment_name) {
  switch (equipment_name) {
    case #"hash_8db6bf9ca54eb15b":
      return "equip_semtex";
    case #"hash_497754f33560ac77":
      return "equip_frag";
    case #"hash_bf0fd8e6fe2267bb":
      return "equip_molotov";
    case #"hash_79b8269b3b1d0fd3":
      return "equip_claymore";
    case #"hash_e380bc2838d9b190":
      return "equip_throwing_knife";
    case #"hash_d4a6437262e222e1":
      return "equip_throwing_knife_fire";
    case #"hash_6644827d8700e5b4":
      return "equip_c4";
    case #"hash_a4bbe9e5a19b54c9":
      return "equip_thermite";
    case #"hash_ae10efa2fe15642a":
      return "equip_smoke";
    case #"hash_b3b871a191462c63":
      return "equip_flash";
    case #"hash_b2e49572d35e0e77":
      return "equip_concussion";
    case #"hash_80b21713df2fc1fb":
      return "equip_snapshot_grenade";
    default:
      return equipment_name;
  }
}

function function_63699875d9aca328(power_name) {
  switch (power_name) {
    case #"hash_8db6bf9ca54eb15b":
      return "brloot_offhand_semtex";
    case #"hash_497754f33560ac77":
      return "brloot_offhand_frag";
    case #"hash_bf0fd8e6fe2267bb":
      return "brloot_offhand_molotov";
    case #"hash_79b8269b3b1d0fd3":
      return "brloot_offhand_claymore";
    case #"hash_e380bc2838d9b190":
      return "brloot_offhand_throwingknife";
    case #"hash_d4a6437262e222e1":
      return "brloot_offhand_throwingknife_fire";
    case #"hash_6644827d8700e5b4":
      return "brloot_offhand_c4";
    case #"hash_ae10efa2fe15642a":
      return "brloot_offhand_smoke";
    case #"hash_b3b871a191462c63":
      return "brloot_offhand_flash";
    case #"hash_b2e49572d35e0e77":
      return "brloot_offhand_concussion";
    case #"hash_a4bbe9e5a19b54c9":
      return "brloot_offhand_thermite";
    default:
      return undefined;
  }
}

function function_a8e35c2fa66dafd4(equipment_name) {
  switch (equipment_name) {
    case #"hash_f0907f858c134cb4":
      return "power_semtex";
    case #"hash_8c7819f0a3fbd1e0":
      return "power_frag";
    case #"hash_142a787e36d7d7ce":
      return "power_molotov";
    case #"hash_2354208d9af64220":
      return "power_claymore";
    case #"hash_9ba0a6ff6081954e":
      return "power_throwingKnife";
    case #"hash_acc752b9cde2ff4f":
      return "power_throwingKnife_fire";
    case #"hash_4320d77f90725183":
      return "power_c4";
    case #"hash_de4641ddbc44a7ba":
      return "power_thermite";
    case #"hash_4f62b5fa00ecd075":
      return "power_snapshotGrenade";
    case #"hash_fb6b649176cec75d":
      return "power_smokeGrenade";
    default:
      return equipment_name;
  }
}

function function_e1c4715fb39996e7(equipment_name) {
  switch (equipment_name) {
    case #"hash_8db6bf9ca54eb15b":
    case #"hash_f0907f858c134cb4":
      return "semtex_mp";
    case #"hash_497754f33560ac77":
    case #"hash_8c7819f0a3fbd1e0":
      return "frag_grenade_mp";
    case #"hash_142a787e36d7d7ce":
    case #"hash_bf0fd8e6fe2267bb":
      return "molotov_mp";
    case #"hash_2354208d9af64220":
    case #"hash_79b8269b3b1d0fd3":
      return "claymore_mp";
    case #"hash_9ba0a6ff6081954e":
    case #"hash_e380bc2838d9b190":
      return "throwingknife_mp";
    case #"hash_acc752b9cde2ff4f":
    case #"hash_d4a6437262e222e1":
      return "throwingknife_fire_mp";
    case #"hash_4320d77f90725183":
    case #"hash_6644827d8700e5b4":
      return "c4_mp";
    case #"hash_a4bbe9e5a19b54c9":
    case #"hash_de4641ddbc44a7ba":
      return "thermite_mp";
    default:
      return equipment_name;
  }
}

function getequipmenttableinfo(ref) {
  return level.equipment.table[ref];
}

function incrementequipmentslotammo(slot, var_930290d7f474a0ae) {
  ref = scripts\cp_mp\equipment::getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  currammo = scripts\cp_mp\equipment::getequipmentammo(ref);
  newammo = int(min(currammo + var_930290d7f474a0ae, scripts\cp_mp\equipment::getequipmentmaxammo(ref)));
  scripts\cp_mp\equipment::setequipmentammo(ref, newammo);
}

function getequipmentmaxammo(ref) {
  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    maxammo = scripts\cp\utility::function_ed18a118c6fa5c4f(tableinfo.objweapon);

    switch (ref) {
      case #"hash_6d194c409057b2":
      case #"hash_4b4a6458f00d9319":
      case #"hash_aa60ec2aec479ec8":
        break;
      default:
        maxammo--;
        break;
    }

    slot = findequipmentslot(ref);
  } else {
    equipmentname = level.br_pickups.br_equipnametoscriptable[tableinfo.ref];
    assertex(isDefined(level.br_pickups.maxcounts[equipmentname]), "Equipment " + equipmentname + " not found in level.br_pickups.maxCounts. Please add a stack size in the appropriate loot_item_defs table.");
    maxammo = level.br_pickups.maxcounts[equipmentname];

    if(!isDefined(maxammo)) {
      maxammo = 0;
    }

    if(ref == "equip_armorplate") {
      if(hasplatepouch()) {
        maxammo += getdvarint(@ "hash_a5ab8ed6cc1b486a", 3);
      }
    }
  }

  return maxammo;
}

function findequipmentslot(ref) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  foreach(equippedref in self.equipment) {
    if(equippedref == ref) {
      return slot;
    }
  }
}

function canholdammobox(scriptablename, weapon) {
  if(isDefined(weapon)) {
    if(weapon.basename == "iw9_me_knife_mp") {
      return false;
    }
  }

  if(!isDefined(self.br_ammo[scriptablename])) {
    return true;
  }

  return !br_ammo_type_player_full(self, scriptablename);
}

function registerpickupcreatedcallback(scriptabledefname, callback) {
  level.br_pickups.createcallbacks[scriptabledefname] = callback;
}

function isweaponpickupitem(item) {
  if(!isDefined(item)) {
    return false;
  }

  if(isDefined(item.weapon)) {
    return istrue(item.weapon.iscustomweapon);
  } else if(isDefined(item.scriptablename)) {
    return isweaponpickup(item.scriptablename);
  }

  return false;
}

function initscriptablemanagement() {
  leveldata = level.br_pickups;
  assertex(isDefined(leveldata), "initScriptableManagement called before initArrays or br_pickups_init.");
  assertex(!isDefined(leveldata.scriptables), "initScriptableManagement called more than once.");
  leveldata.scriptables = [];
  leveldata.scriptablesstartid = 0;
  leveldata.scriptablescurid = 0;
  leveldata.scriptablesmax = getdvarint(@ "scr_br_pickupscriptablesmax", 750);
  leveldata.scriptablescleanupbatchsize = getdvarint(@ "hash_1e71982a0a539739", 10);
  assertex(leveldata.scriptablescleanupbatchsize < leveldata.scriptablesmax, "cleanupBatchSize should never be greater than or equal to maxSize.");

  setdevdvarifuninitialized(@ "scr_br_pickupscriptablesmax", leveldata.scriptablesmax);
  setdevdvarifuninitialized(@ "hash_1e71982a0a539739", leveldata.scriptablescleanupbatchsize);
}

function function_9bddcf74474466b1() {
  wait 10;
  dropinfo = getitemdropinfo(level.players[0].origin, level.players[0].angles);
  item = spawnpickup("brloot_self_revive", dropinfo);
}

function br_ammo_init() {
  if(istrue(level.var_fcd1ae93f5209b41)) {
    return;
  }

  level.br_ammo_types = [];
  level.br_ammo_types[0] = "brloot_ammo_919";
  level.br_ammo_types[1] = "brloot_ammo_12g";
  level.br_ammo_types[2] = "brloot_ammo_762";
  level.br_ammo_types[3] = "brloot_ammo_50cal";
  level.br_ammo_types[4] = "brloot_ammo_rocket";
  level.br_ammo_clipsize["brloot_ammo_919"] = 30;
  level.br_ammo_clipsize["brloot_ammo_12g"] = 8;
  level.br_ammo_clipsize["brloot_ammo_762"] = 30;
  level.br_ammo_clipsize["brloot_ammo_50cal"] = 8;
  level.br_ammo_clipsize["brloot_ammo_rocket"] = 1;
  level.br_ammo_max = [];
  level.br_ammo_omnvars = [];
  level.br_ammo_omnvars["brloot_ammo_919"] = "ui_br_smallarms_ammo";
  level.br_ammo_omnvars["brloot_ammo_12g"] = "ui_br_shotgun_ammo";
  level.br_ammo_omnvars["brloot_ammo_762"] = "ui_br_assault_ammo";
  level.br_ammo_omnvars["brloot_ammo_50cal"] = "ui_br_sniper_ammo";
  level.br_ammo_omnvars["brloot_ammo_rocket"] = "ui_br_rocket_ammo";
  level.var_e6ea72fc5e3fcd00 = [];
  level.var_e6ea72fc5e3fcd00["brloot_ammo_919"] = 150;
  level.var_e6ea72fc5e3fcd00["brloot_ammo_12g"] = 40;
  level.var_e6ea72fc5e3fcd00["brloot_ammo_762"] = 210;
  level.var_e6ea72fc5e3fcd00["brloot_ammo_50cal"] = 40;
  level.var_e6ea72fc5e3fcd00["brloot_ammo_rocket"] = function_240f7f4e57340e8f() ? 12 : 6;
  level.var_fcd1ae93f5209b41 = 1;
}

function function_195f5055031ad0cb() {
  if(!isDefined(self.plundercount)) {
    self.plundercount = 0;
  }

  if(!isDefined(self.plunderbanked)) {
    self.plunderbanked = 0;
  }

  if(!isDefined(self.haspickedupplunderyet)) {
    self.haspickedupplunderyet = 0;
  }

  if(self.plundercount == 0) {
    thread scripts\cp_mp\pickups::playersetplundercount(0);
  }
}

function function_24ea0b21194d20ce() {
  level.br_plunder = spawnStruct();
  level.br_plunder.plunderlimit = 65536 - 1;
  level.br_plunder.plunder_items_picked_up = 0;
  level.br_plunder.plunder_value_picked_up = 0;
  level.br_plunder.plunder_items_dropped = 0;
  level.br_plunder.plunder_value_dropped = 0;
  level.br_plunder.kiosk_spent_total = 0;
  level.br_plunder.kiosk_num_purchases = 0;
  level.br_plunder.extraction_balloon_total_plunder = 0;
  level.br_plunder.extraction_balloon_num_completed = 0;
  level.br_plunder.extraction_helicoptor_total_plunder = 0;
  level.br_plunder.extraction_helicoptor_num_completed = 0;
  level.br_plunder.plunder_awarded_by_missions_total = 0;
  level.br_plunder.itemsinworld = [];
  level.br_plunder.itemsinworld["brloot_plunder_cash_common_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_common_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_3"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_3");
  level.br_plunder.itemsinworld["brloot_plunder_cash_rare_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_rare_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_rare_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_rare_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_epic_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_epic_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_epic_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_epic_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_legendary_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_legendary_1");
  level.br_plunder.itemsinworld["br_loot_cache"] = getscriptablelootspawnedcountbyname("br_loot_cache");
  level.br_plunder.itemsinworld["brloot_mission_tablet"] = getscriptablelootspawnedcountbyname("brloot_mission_tablet");
  setupquantities();
  level.br_depots = [];
  initplayerplunderevents();
  initteamdatafields();
}

function initteamdatafields() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["plunderTeamTotal"] = 0;
    level.teamdata[team]["plunderInDeposit"] = 0;
    level.teamdata[team]["plunderBanked"] = 0;
  }

  if(getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk") {
    foreach(team in level.teamnamelist) {
      level.teamdata[team]["tokensTeamTotal"] = 0;
      level.teamdata[team]["tokensInDeposit"] = 0;
      level.teamdata[team]["tokensBanked"] = 0;
    }
  }
}

function setupquantities() {
  level.br_plunder.quantity = [];
  level.br_plunder.names = [];
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_3";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_rare_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_rare_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_epic_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_epic_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_legendary_1";

  for(i = 0; i < level.br_plunder.names.size; i++) {
    level.br_plunder.quantity[i] = level.br_pickups.counts[level.br_plunder.names[i]];

    if(isDefined(level.br_plunder.quantity[i - 1])) {
      assert(level.br_plunder.quantity[i - 1] < level.br_plunder.quantity[i]);
    }
  }
}

function initplayerplunderevents() {
  omnvars = [];
  omnvars[1] = "ui_cash_pickedup";
  omnvars[2] = "ui_cash_pickedup";
  level.playerplundereventomnvars = omnvars;
  callbacks = [];
  callbacks[1] = &playerplunderpickupcallback;
  callbacks[4] = &playerplunderlosecallback;
  level.playerplundereventcallbacks = callbacks;
}

function function_52db16c0f1b89f36() {
  initplayer();
  thread function_461334c52833c744();
  thread br_ammo_player_hud_monitor();

  if(!scripts\cp\utility::gameflag("prematch_done")) {
    var_509d86412c9d7426 = self getweaponslistprimaries();

    foreach(weap in var_509d86412c9d7426) {
      ammoclipsize = weaponclipsize(weap);

      if(isDefined(ammoclipsize)) {
        self setweaponammoclip(weap, ammoclipsize);
      }
    }
  }

  foreach(ammotype in level.br_ammo_types) {
    self.br_ammo[ammotype] = 0;
  }

  br_ammo_update_weapons();
  br_ammo_player_hud_update_ammotype("brloot_ammo_919");
  br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
  br_ammo_player_hud_update_ammotype("brloot_ammo_762");
  br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
  br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
}

function initplayer(useloadout) {
  br_ammo_player_clear();
  resetplayerinventory(useloadout);
}

function br_ammo_player_clear() {
  foreach(ammotype in level.br_ammo_types) {
    self.br_ammo[ammotype] = 0;
  }

  self notify("ammo_update");
}

function resetplayerinventory(keeploadout) {
  self.br_inventory_slots = [];

  if(istrue(keeploadout)) {}

  if(has_auto_revive()) {
    removeselfrevivetoken();
  }
}

function br_ammo_player_hud_update_ammotype(ammotype, bpulse) {
  extraammo = 0;

  if(isbackpackinventoryenabled()) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
    function_5baaa0ce73d6fe84(self);
  }

  if(isDefined(level.br_ammo_omnvars[ammotype])) {
    self setclientomnvar(level.br_ammo_omnvars[ammotype], self.br_ammo[ammotype] + extraammo);
  }
}

function function_461334c52833c744() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("reload_start");

    if(!isDefined(self)) {
      return;
    }

    objweapon = self getcurrentweapon();
    old_clip = self getweaponammoclip(objweapon);
    weaponammotype = br_ammo_type_for_weapon(objweapon);

    if(!isDefined(weaponammotype)) {
      continue;
    }

    br_wait_for_complete_reload();

    if(!isDefined(self)) {
      return;
    }

    var_7ff630bfbca7b961 = self.br_ammo[weaponammotype];

    if(!getdvarint(@ "hash_59a26f9bd4367b8d", istrue(level.prematchinfinitammo)) || scripts\mp\flags::gameflag("prematch_done")) {
      var_7ff630bfbca7b961 = self getweaponammostock(objweapon);
    }

    br_ammo_update_ammotype_weapons(self, weaponammotype, var_7ff630bfbca7b961);

    if(getdvarint(@ "hash_11a55f76d25d5bd5", 0) && isDefined(self.br_ammo[weaponammotype]) && self.br_ammo[weaponammotype] <= 0) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(weaponammotype);

      if(isDefined(lootid)) {
        scripts\cp_mp\calloutmarkerping::function_1ced737a22161a49(22, lootid);
      }
    }
  }
}

function br_wait_for_complete_reload(objweapon) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self isreloading()) {
    waitframe();
  }
}

function br_ammo_update_ammotype_weapons(player, ammotype, newweaponstock) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }

  var_509d86412c9d7426 = self getweaponslistprimaries();
  var_a9bc5314d494806d = 0;

  foreach(weap in var_509d86412c9d7426) {
    ammotypecomparison = br_ammo_type_for_weapon(weap);

    if(isDefined(ammotypecomparison) && ammotype == ammotypecomparison) {
      if(function_6b531c76815d77f3(ammotype) && !var_a9bc5314d494806d) {
        var_efb882bf4f27ee85 = level.var_e6ea72fc5e3fcd00[ammotype] - newweaponstock;
        lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
        var_750fcc188317845a = [];

        for(i = 0; i < getplayerbackpacksize(player); i++) {
          if(player getlootidatbackpackindex(i) == lootid) {
            var_750fcc188317845a[i] = player getquantityatbackpackindex(i);
          }
        }

        var_2c20ea06f37f490a = tablesort(var_750fcc188317845a, "up");

        foreach(index in var_2c20ea06f37f490a) {
          slotquantity = player getquantityatbackpackindex(index);

          if(var_efb882bf4f27ee85 <= slotquantity) {
            function_db1dd76061352e5b(index, var_efb882bf4f27ee85);
            var_efb882bf4f27ee85 = 0;
            break;
          }

          var_efb882bf4f27ee85 -= slotquantity;
          function_db1dd76061352e5b(index, slotquantity);
        }

        newweaponstock += level.var_e6ea72fc5e3fcd00[ammotype] - newweaponstock - var_efb882bf4f27ee85;
      }

      newweaponstock = get_int_or_0(newweaponstock);
      player function_4906c10c3ffdd4ca(weap, newweaponstock);
      self.br_ammo[ammotype] = min(newweaponstock, level.var_e6ea72fc5e3fcd00[ammotype]);
      self.br_ammo[ammotype] = get_int_or_0(self.br_ammo[ammotype]);
      var_a9bc5314d494806d = 1;
    }
  }

  player notify("ammo_update");
}

function function_4906c10c3ffdd4ca(weapon, stock_ammo, var_2b2365bad962f899) {
  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    self setweaponammostock(weapon, 0);
    return;
  }

  if(istrue(var_2b2365bad962f899)) {
    ammotype = br_ammo_type_for_weapon(weapon);

    if(isDefined(ammotype) && isDefined(self.br_ammo[ammotype])) {
      stock_ammo = int(clamp(stock_ammo, 0, level.var_e6ea72fc5e3fcd00[ammotype]));
      self.br_ammo[ammotype] = stock_ammo;
    }

    self setweaponammostock(weapon, stock_ammo);
    return;
  }

  ammotype = br_ammo_type_for_weapon(weapon);
  array_stock = get_int_or_0(self.br_ammo[ammotype]);

  if(istrue(weapon.isalternate) && !isDefined(weapon.underbarrel)) {
    return;
  }

  self setweaponammostock(weapon, array_stock);
}

function br_ammo_player_hud_monitor() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    result = waittill_any_return_5("ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");
    next_weapon = self function_b2ed366433a3d074();

    if(isDefined(next_weapon)) {
      ammotype = br_ammo_type_for_weapon(next_weapon);

      if(isDefined(ammotype)) {
        newstockammo = get_int_or_0(self.br_ammo[ammotype]);
        function_4906c10c3ffdd4ca(next_weapon, newstockammo);
      }
    } else {
      weapon = self getcurrentweapon();

      if(isDefined(weapon) && !isnullweapon(weapon)) {
        ammotype = br_ammo_type_for_weapon(weapon);

        if(isDefined(ammotype)) {
          newstockammo = get_int_or_0(self.br_ammo[ammotype]);
          function_4906c10c3ffdd4ca(weapon, newstockammo);
        }
      }
    }

    br_ammo_player_hud_update_ammotype("brloot_ammo_919");
    br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
    br_ammo_player_hud_update_ammotype("brloot_ammo_762");
    br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
    br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
  }
}

function function_45b39e34d0beb8cb(result) {
  var_509d86412c9d7426 = self.primaryweapons;
  current_weapon = self.currentprimaryweapon;

  foreach(weap in var_509d86412c9d7426) {
    ammotype = br_ammo_type_for_weapon(weap);

    if(isDefined(ammotype)) {
      newstockammo = get_int_or_0(self.br_ammo[ammotype]);

      if(br_ammo_type_player_full(self, ammotype)) {
        br_ammo_give_type(self, ammotype, newstockammo, 0);
        function_c5c058c71cfc237a(self, ammotype, newstockammo);
      }
    }
  }

  ammotype = br_ammo_type_for_weapon(current_weapon);

  if(isDefined(ammotype)) {
    newstockammo = get_int_or_0(self.br_ammo[ammotype]);
    function_4906c10c3ffdd4ca(current_weapon, newstockammo);
  }
}

function function_c5c058c71cfc237a(player, ammotype, amount) {
  player.br_ammo[ammotype] += amount;

  if(player.br_ammo[ammotype] > level.var_e6ea72fc5e3fcd00[ammotype]) {
    player.br_ammo[ammotype] = level.var_e6ea72fc5e3fcd00[ammotype];
  }
}

function function_7a302a314424968f(bool) {
  level.clearstockondrop = bool;
}

function function_44055a11ffdcc17e() {
  self.br_ammo["brloot_ammo_919"] = 0;
  self.br_ammo["brloot_ammo_12g"] = 0;
  self.br_ammo["brloot_ammo_762"] = 0;
  self.br_ammo["brloot_ammo_50cal"] = 0;
  self.br_ammo["brloot_ammo_rocket"] = 0;
  self.br_ammo["brloot_ammo_mike32"] = 0;
}

function drop_cash(amount, dropinfoindex) {
  if(amount >= 5000) {
    drop_type = "brloot_plunder_cash_rare_1";
  } else if(amount >= 2000) {
    drop_type = "brloot_plunder_cash_uncommon_2";
  } else if(amount >= 1000) {
    drop_type = "brloot_plunder_cash_uncommon_1";
  } else {
    drop_type = "brloot_plunder_cash_common_1";
  }

  if(!isDefined(dropinfoindex)) {
    dropinfoindex = 0;
  }

  dropinfo = getitemdroporiginandangles(dropinfoindex, self.origin, self.angles, self);
  item = spawnpickup(drop_type, dropinfo, int(amount), 1, undefined, 1);
}

function function_5cff081d620d2ef3() {
  dropinfo = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self);
  drops = ["brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_50cal", "brloot_ammo_12g", "brloot_ammo_rocket"];

  for(i = 0; i < drops.size; i++) {
    if(scripts\cp\globallogic::function_c5251179824f0deb(drops[i])) {
      count = scripts\cp\globallogic::function_f9c71b46b5e50150(drops[i], scripts\cp\globallogic::function_93f256198133479f(drops[i]));
      item = spawnpickup(drops[i], dropinfo, count, 1, undefined, 1);
      dropinfo = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self);
    }
  }
}

function function_c78e977650c14d64() {
  drop_info = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);

  if(isDefined(self.copy_fullweaponlist)) {
    for(i = 0; i < self.copy_fullweaponlist.size; i++) {
      if(function_b3b99f9f9371c997(self.copy_fullweaponlist[i])) {
        weaponspawn(self.copy_fullweaponlist[i], self, drop_info, 0, 1);
        drop_info = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);
      }
    }

    return;
  }

  if(isDefined(self.primaryweapons)) {
    for(i = 0; i < self.primaryweapons.size; i++) {
      if(function_b3b99f9f9371c997(self.primaryweapons[i])) {
        weaponspawn(self.primaryweapons[i], self, drop_info, 0, 1);
        drop_info = getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);
        scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapons[i]);
      }
    }
  }
}

function function_4172a10ae7cbdb41(weaponobj) {
  ammotype = br_ammo_type_for_weapon(weaponobj);
  amount = function_a5408e1d8e88137c(weaponobj);
  br_ammo_give_type(self, ammotype, amount, 0);
}

function function_a5408e1d8e88137c(weaponobj) {
  ammotype = br_ammo_type_for_weapon(weaponobj);

  if(isDefined(ammotype)) {
    var_d8f2cb467e2af5cd = function_ecdfc73e68dcc209(ammotype);

    if(isDefined(var_d8f2cb467e2af5cd)) {
      return var_d8f2cb467e2af5cd;
    } else {
      return weaponmaxammo(weaponobj);
    }

    return;
  }

  return weaponmaxammo(weaponobj);
}

function function_ecdfc73e68dcc209(ammotype) {
  if(isDefined(level.var_e6ea72fc5e3fcd00[ammotype])) {
    return level.var_e6ea72fc5e3fcd00[ammotype];
  }

  return undefined;
}

function inventory_close() {
  self setclientomnvar("ui_force_close_inventory", 1);
  self setclientomnvar("open_inventory", 0);
  self.inventory_visible = 0;
}

function inventory_open() {
  self setclientomnvar("ui_force_close_inventory", 0);
  self setclientomnvar("open_inventory", 1);
  self.inventory_visible = 1;
}

function dropbrequipment(fromkiosk, droppurchased, equipmentref) {
  var_65cad465fd8e737c = 7;
  var_11f2059012065537 = istrue(droppurchased) && isDefined(equipmentref);

  if(var_11f2059012065537) {
    var_1a37fa6c580bb395 = array_find(level.br_pickups.br_equipname, equipmentref);

    if(isDefined(var_1a37fa6c580bb395)) {
      function_73ffc9bcd6d1e62d(fromkiosk);
      dropinfo = getitemdroporiginandangles(var_65cad465fd8e737c, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
      item = spawnpickup(var_1a37fa6c580bb395, dropinfo, 1, 1, undefined, isalive(self));
      function_2f4e0022c686dbe6(item);
    }

    return;
  }

  if(isDefined(self.equipment["primary"])) {
    ammocount = scripts\cp_mp\equipment::getequipmentslotammo("primary");

    if(ammocount > 0) {
      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment["primary"]);

      if(isDefined(var_feb782334dd23a66)) {
        dropinfo = getitemdroporiginandangles(var_65cad465fd8e737c, self.origin, self.angles, self);
        allowautopickup = isalive(self) || getdvarint(@ "scr_br_allow_auto_pickup_dropped_lethal_gadgets", 0);
        item = spawnpickup(var_feb782334dd23a66, dropinfo, ammocount, 1, undefined, allowautopickup);
        function_2f4e0022c686dbe6(item);
      }

      var_65cad465fd8e737c++;
    }
  }

  if(isDefined(self.equipment["secondary"])) {
    ammocount = scripts\cp_mp\equipment::getequipmentslotammo("secondary");

    if(ammocount > 0) {
      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment["secondary"]);

      if(isDefined(var_feb782334dd23a66)) {
        dropinfo = getitemdroporiginandangles(var_65cad465fd8e737c, self.origin, self.angles, self);
        allowautopickup = isalive(self) || getdvarint(@ "scr_br_allow_auto_pickup_dropped_tactical_gadgets", 0);
        item = spawnpickup(var_feb782334dd23a66, dropinfo, ammocount, 1, undefined, allowautopickup);
        function_2f4e0022c686dbe6(item);
      }

      var_65cad465fd8e737c++;
    }
  }
}

function function_1a8066ccdb91c1d1() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    return level.var_fb60f0244999d528;
  }

  return 0;
}

function function_2f4e0022c686dbe6(item) {
  if(!scripts\cp_mp\utility\player_utility::isreallyalive(self) && isDefined(item)) {
    self.var_d2dbb2fa012e6d9c[item.type] = item;
  }
}

function private _givebrsuper(equipname, supername, supercount, suppress_splash) {
  if(isDefined(level.allowsupers) && level.allowsupers) {
    supercount = scripts\cp\super::getcurrentsuperpoints() >= scripts\cp\super::getsuperpointsneeded();
  } else {
    self setclientomnvar("ui_perk_package_state", 3);
    self setclientomnvar("ui_perk_package_super1", scripts\cp_mp\supers\supers::getsuperid(supername));
    self setclientomnvar("ui_super_progress", 1);

    if(!isDefined(suppress_splash) || !suppress_splash) {
      thread function_39a9c1f90dd0465();
    }
  }

  if(isDefined(supername)) {
    tableinfo = spawnStruct();
    tableinfo.objweapon = level.superglobals.staticsuperdata[supername].weapon;
    tableinfo.ispassive = 0;
    tableinfo.id = level.superglobals.staticsuperdata[supername].id;

    if(!isDefined(tableinfo)) {
      return;
    }

    if(isDefined(self.superweapon)) {
      self takeweapon(self.superweapon);
      self clearoffhandspecial();
      self notify("special_switch");
    }

    self.superweapon = tableinfo.objweapon;
    self.supername = supername;
    self giveweapon(self.superweapon);
    self assignweaponoffhandspecial(self.superweapon);
    sethudslot("super", tableinfo.id);
    var_645972186625daee = getcallback(supername, "onGive");

    if(isDefined(var_645972186625daee)) {
      self thread[[var_645972186625daee]](supername, "super");
    }
  } else if(isDefined(equipname)) {
    scripts\cp_mp\equipment::giveequipment(equipname, "super");
    scripts\cp_mp\equipment::setequipmentammo(equipname, supercount);
  }

  if(isDefined(self.superweapon) && isDefined(supercount)) {
    self setweaponammoclip(self.superweapon, supercount);
  }

  thread function_946f4162d6eddcb8(equipname);
}

function function_39a9c1f90dd0465() {
  self endon("disconnect");
  self endon("death");

  if(flag_exist("dungeon_intro_complete")) {
    flag_wait("dungeon_intro_complete");
  }

  wait 1;

  if(!istrue(self.superreminderset)) {
    self notify("showSuperReminderSplash");
    self endon("showSuperReminderSplash");
    self.superreminderset = 1;
    self setclientomnvar("ui_super_reminder", 1);
    wait 0.5;
    thread function_b137afbca79ba3ff();
    return;
  }

  thread function_b137afbca79ba3ff();
  self endon("showSuperReminderSplash");
  waitframe();
  thread function_39a9c1f90dd0465();
  return;
}

function function_b137afbca79ba3ff() {
  self notify("showSuperReminderSplash");
  self.superreminderset = undefined;
  self setclientomnvar("ui_super_reminder", 0);
}

function function_946f4162d6eddcb8(equipname) {
  self endon("death");
  self endon("disconnect");
  self endon("special_switch");
  self waittill("special_weapon_fired");

  if(scripts\cp\laststand::isinlaststand(self)) {
    success = 0;
  } else {
    val::group_set("useSuper", 0);
    success = function_84521a355496476f(equipname);
    val::group_reset("useSuper");
  }

  if(!success) {
    _givebrsuper(equipname, undefined, 1, 1);

    if(equipname == "equip_recondrone") {
      self notify("killstreak_use_finished", "radar_drone_recon");
    }

    return;
  }

  if(!(isDefined(equipname) && (equipname == "equip_hb_sensor" || equipname == "equip_nvg"))) {
    self setclientomnvar("ui_field_upgrade_icon", 0);
    self setclientomnvar("ui_super_progress", 0);
    self takeweapon(self.superweapon);
    self clearoffhandspecial();
    self.superweapon = undefined;
    self.supername = undefined;
  }
}

function function_84521a355496476f(equipname) {
  if(isDefined(equipname)) {
    if(equipname == "equip_recondrone") {
      thread function_6dba5503031bcc38("radar_drone_recon");
      streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("radar_drone_recon", self);
      streakinfo.issuper = 1;
      return scripts\cp_mp\killstreaks\recon_drone::function_ab931b44a2efddf7(streakinfo);
    } else if(equipname == "equip_suppression_rounds") {
      if(issharedfuncdefined("super_suppression_rounds", "suppressionRounds_beginUse")) {
        return self[[getsharedfunc("super_suppression_rounds", "suppressionRounds_beginUse")]]();
      }
    } else if(equipname == "equip_nvg") {
      if(self isnightvisionon()) {
        self nightvisionviewoff(1);
      } else {
        self nightvisionviewon(1);
      }

      self setweaponammoclip(self.superweapon, 1);
      function_946f4162d6eddcb8(equipname);
    }
  }

  return 1;
}

function function_b1dd9dcae2f63965() {
  return getdvarint(@ "hash_1445bea2674012b9", 0);
}

function function_b9da718e50063452() {
  if(isDefined(level.br_pickups.var_c9015f26f73062a0)) {
    return;
  }

  level.br_pickups.var_c9015f26f73062a0 = [];
  thread function_a856fc2139eef0c(15);
}

function function_ac3ec31be7aad7a7(weaponinstance) {
  function_b9da718e50063452();
  weaponshandler = level.br_pickups.var_c9015f26f73062a0[self.guid];

  if(isDefined(weaponshandler)) {
    foreach(weapidx in weaponshandler.array) {
      if(weapidx == weaponinstance.index) {
        weaponshandler.var_52fcfe909c72db5b = gettime();
        return true;
      }
    }
  }

  return false;
}

function function_a856fc2139eef0c(tickinterval) {
  level endon("game_ended");

  while(true) {
    curtime = gettime();
    maxtimekeeping = getdvarint(@ "hash_5eff4677b208a6b8", 45000);

    foreach(weaponshandler in level.br_pickups.var_c9015f26f73062a0) {
      if(curtime - weaponshandler.var_52fcfe909c72db5b >= maxtimekeeping) {
        level.br_pickups.var_c9015f26f73062a0[key] = undefined;
      }
    }

    if(getdvarint(@ "hash_9723d1b7ab64df07", 0)) {
      function_c50d56273471bf54();
    }

    wait tickinterval;
  }
}

function function_c50d56273471bf54() {
  var_c215e2a76b873506 = 0;
  structscount = 0;

  foreach(weaponhandler in level.br_pickups.var_c9015f26f73062a0) {
    if(isDefined(weaponhandler)) {
      structscount++;
      var_c215e2a76b873506 += weaponhandler.array.size;
    }
  }

  println("<dev string:x1be>");
  println("<dev string:x22f>");
  println("<dev string:x263>" + structscount);
  println("<dev string:x291>" + var_c215e2a76b873506);
  println("<dev string:x22f>");
}

function additemtobackpack(lootid, pickup, dontdropleftover, var_75f83bdffeda824b) {
  assertex(isDefined(lootid) || isDefined(pickup), "lootID or pickup not defined in addItemToBackpack in br_dmz_inventory.gsc");

  if(!isDefined(lootid) || !isDefined(pickup)) {
    return;
  }

  if(!istrue(var_75f83bdffeda824b) && issubstr(pickup.scriptablename, "brloot_ammo")) {
    return;
  }

  if(function_3c17a26ce6a4668(lootid)) {
    index = getavailabledmzbackpackindex();

    if(!isDefined(index)) {
      return 0;
    }

    function_71e56bb092fd2574(lootid);
    thread setbackpackitematindex(index, lootid, pickup.count);
    return 0;
  } else if(function_f6f8c1fc9549eaf6(lootid)) {}

  if(isammo(pickup.scriptablename)) {
    if(self.br_ammo[pickup.scriptablename] < level.var_e6ea72fc5e3fcd00[pickup.scriptablename]) {
      var_3107c519d169a89 = level.var_e6ea72fc5e3fcd00[pickup.scriptablename] - self.br_ammo[pickup.scriptablename];

      if(istrue(pickup.isautouse) && function_e44c2d69db881894(pickup.scriptablename)) {
        self.br_ammo[pickup.scriptablename] = level.var_e6ea72fc5e3fcd00[pickup.scriptablename];
        br_ammo_player_hud_update_ammotype(pickup.scriptablename);
        br_ammo_update_weapons(self);
        quantity = pickup.count - var_3107c519d169a89;
        dropinfo = getitemdroporiginandangles(0, self.origin, self.angles, self, undefined);
        item = spawnpickup(pickup.scriptablename, dropinfo, quantity, 1, undefined, 0);
        return 0;
      } else {
        br_ammo_give_type(self, pickup.scriptablename, var_3107c519d169a89);
        pickup.count -= var_3107c519d169a89;
      }
    }
  }

  quantity = setbackpackitem(lootid, pickup);

  if(quantity > 0) {
    if(!istrue(dontdropleftover)) {
      dropinfo = getitemdroporiginandangles(0, self.origin, self.angles, self, undefined);
      item = spawnpickup(pickup.scriptablename, dropinfo, quantity, 1, undefined, 0);
      return 0;
    } else {
      return quantity;
    }
  }

  return 0;
}

function function_3c17a26ce6a4668(lootid) {
  return isDefined(lootid) && lootid == 8516;
}

function getavailabledmzbackpackindex() {
  for(i = 0; i < level.var_e247454ac2869696; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(currentlootid == 0) {
      return i;
    }
  }

  return undefined;
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

function function_9f3a7767f1c1bd9e(lootid, index, quantity) {
  total = quantity;
  total += self getplayerdata("cp", "dmzBackpack", index, "quantity");
  thread setbackpackitematindex(index, lootid, total);
}

function function_91a0bab850d7db10(index, lootid, maxcount, pickupquantity, slotquantity) {
  leftover = slotquantity + pickupquantity - maxcount;
  thread setbackpackitematindex(index, lootid, maxcount);
  return leftover;
}

function setbackpackitematindex(index, lootid, quantity) {
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  println(self.name + "<dev string:x2b2>" + index + "<dev string:x2cd>" + lootid + "<dev string:x2cd>" + quantity + "<dev string:x2d0>");
  println("<dev string:x2d3>" + index + "<dev string:x2d5>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + quantity);

  if(!isDefined(quantity)) {
    quantity = 0;
  }

  if(!isDefined(lootid) || lootid != 0 && quantity == 0) {
    lootid = 0;
  }

  self setplayerdata("cp", level.backpackdata, index, "lootID", lootid);
  self setplayerdata("cp", level.backpackdata, index, "quantity", quantity);

  if(quantity < 0) {
    self setplayerdata("cp", level.backpackdata, index, "lootID", 0);
    self setplayerdata("cp", level.backpackdata, index, "quantity", 0);
  }
}

function function_f6f8c1fc9549eaf6(lootid) {
  return isDefined(lootid) && lootid == 8358;
}

function function_e37ca8120dc19c6a() {
  return matchmakinggame() || getdvarint(@ "hash_9c2d59c1962cac50");
}

function function_c01eb7d2911f26e1(player, instance_reference) {
  if(!isDefined(instance_reference)) {
    return;
  }

  quantity = 0;
  backpacksize = scripts\cp_mp\pickups::getplayerbackpacksize(player);

  if(!isDefined(backpacksize) || backpacksize <= 0) {
    return;
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(instance_reference);

  for(i = 0; i < backpacksize; i++) {
    curid = player scripts\cp_mp\pickups::getlootidatbackpackindex(i);

    if(curid == lootid) {
      quantity++;
    }
  }

  return quantity;
}

function function_f8d85c542911e3a9(player, instance_reference) {
  if(!isDefined(instance_reference)) {
    return;
  }

  backpacksize = scripts\cp_mp\pickups::getplayerbackpacksize(player);
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(instance_reference);

  if(!isDefined(backpacksize) || backpacksize <= 0) {
    return;
  }

  for(i = 0; i < backpacksize; i++) {
    curid = player scripts\cp_mp\pickups::getlootidatbackpackindex(i);

    if(curid == lootid) {
      return i;
    }
  }

  return undefined;
}

function function_1a13107253c400d(looter, backpack) {
  assert(isDefined(backpack.contents));

  if(!isDefined(backpack.containertype)) {
    backpack.containertype = 2;
  }

  looter playsoundtoplayer("cp_open_backpack", looter);
  scripts\cp\loot_system::openlootablecontainer(looter, backpack);
}

function function_37be6e543436f3b3(lootid, origin) {
  pickup = spawnStruct();
  pickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  pickup.origin = origin;
  playpickupfeedback(pickup);
}

function playpickupfeedback(pickupent, bautouse) {
  pickup_sfx = "br_pickup_generic";
  icontype = undefined;

  if(isDefined(pickupent.scriptablename)) {
    if(isplunder(pickupent.scriptablename)) {
      pickup_sfx = getcashsoundaliasforplayer(self, pickupent.scriptablename);
    } else if(isDefined(level.br_pickups.br_pickupsfx[pickupent.scriptablename]) && level.br_pickups.br_pickupsfx[pickupent.scriptablename] != #"" && !(getdvarint(@ "scr_br_skiplegendarypickupsound", 0) != 0 && level.br_pickups.br_pickupsfx[pickupent.scriptablename] == getxhash("br_legendary_loot_pickup"))) {
      pickup_sfx = level.br_pickups.br_pickupsfx[pickupent.scriptablename];
    } else if(isweaponpickupitem(pickupent)) {
      pickup_sfx = "br_pickup_weap";
    } else {
      pickup_sfx = "br_pickup_generic";
    }

    if(isDefined(level.br_pickups.br_itemrow[pickupent.scriptablename]) && (istrue(level.br_pickups.var_a5e4b146866d7fd[pickupent.scriptablename]) || isweaponpickup(pickupent.scriptablename) && getdvarint(@ "hash_68583a19a03dfdbc", 0))) {
      self setclientomnvar("ui_br_loot_index_picked_up", level.br_pickups.br_itemrow[pickupent.scriptablename]);
    } else if(isplunder(pickupent.scriptablename)) {
      icontype = "br_plunder";
    } else if(isammo(pickupent.scriptablename)) {
      switch (pickupent.scriptablename) {
        case #"hash_57e5eda4a702c559":
          icontype = "br_ammo_12g";
          break;
        case #"hash_f1734c15f85881ca":
          icontype = "br_ammo_50cal";
          break;
        case #"hash_672892a4af1e94cc":
          icontype = "br_ammo_762";
          break;
        case #"hash_1cd9ffa488237604":
          icontype = "br_ammo_919";
          break;
        case #"hash_755a9bafcd63b343":
          icontype = "br_ammo_rocket";
          break;
        default:
          icontype = "br_ammo";
          break;
      }
    } else if(isarmorplate(pickupent.scriptablename)) {
      icontype = "br_armor";
    } else if(isequipment(pickupent.scriptablename)) {
      equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
      slot = level.equipment.table[equipname].defaultslot;

      if(slot != "health") {
        icontype = "br_ammo";
      }
    }
  }

  origin = pickupent.origin;

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  if(isDefined(origin)) {
    playsoundatpos(origin, pickup_sfx);
  }

  if(isDefined(icontype)) {
    scripts\cp_mp\damagefeedback::hudicontype(icontype);
  }

  if(!istrue(bautouse)) {
    thread function_630bb1e4fdf27c6c(pickupent);
  }
}

function function_630bb1e4fdf27c6c(pickupent) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !playercanplaynotcriticalgesture()) {
    return;
  }

  if(function_240f7f4e57340e8f()) {
    if(!function_66bdd7e1d2e05f14()) {
      playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
    }

    return;
  }

  function_f4361ea8ce0fbca4();
  playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
}

function lootitem(lootid, quantity) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = self.origin;
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];

  if(isweaponpickupitem(var_bada25504e8844d7) && isbackpackinventoryenabled()) {
    [ammo, ammoleft, var_35ead47ed0d7507e] = getdefaultweaponammo(level.br_lootiteminfo[scriptablename].fullweaponobj, 1);
    var_bada25504e8844d7.count = ammo;
    var_bada25504e8844d7.countlefthand = ammoleft;
    var_bada25504e8844d7.countalt = var_35ead47ed0d7507e;
  } else {
    var_bada25504e8844d7.count = quantity;
    var_bada25504e8844d7.countlefthand = 0;
    var_bada25504e8844d7.countalt = 0;
  }

  return function_b5f5576a0017c089(var_bada25504e8844d7, "visible", self);
}

function getdefaultweaponammo(weapon, maxammo) {
  ammotype = br_ammo_type_for_weapon(weapon);
  maxdropcount = 100;

  if(isDefined(ammotype) && isDefined(level.br_pickups.counts[ammotype])) {
    maxdropcount = level.br_pickups.counts[ammotype];
  }

  var_28aebe3dd6733ed3 = ter_op(weaponclipsize(weapon) < maxdropcount || istrue(maxammo), weaponclipsize(weapon), maxdropcount);
  var_961012dd15fa29ee = 0;

  if(weapon.hasalternate) {
    var_5d9b5b689a1846c8 = weapon getaltweapon();
    var_961012dd15fa29ee = ter_op(weaponclipsize(var_5d9b5b689a1846c8) < maxdropcount || istrue(maxammo), weaponclipsize(var_5d9b5b689a1846c8), maxdropcount);
  }

  return [var_28aebe3dd6733ed3, var_28aebe3dd6733ed3, var_961012dd15fa29ee];
}

function function_54dac56d15dd3d93(ref, lootid, quantity) {
  if(!isDefined(ref) || !isDefined(lootid) || !isDefined(quantity)) {
    return 0;
  }

  fakepickup = spawnStruct();
  fakepickup.scriptablename = ref;
  fakepickup.count = quantity;
  result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(ref));

  if(result == 1) {
    function_37be6e543436f3b3(lootid);
    br_ammo_give_type(self, ref, quantity, 1);
    return 1;
  }

  if(result == 20) {
    function_37be6e543436f3b3(lootid);
    additemtobackpack(lootid, fakepickup);
    return 1;
  }

  showuseresultsfeedback(result);
  return 0;
}

function function_f8a3ff0a73fa0c1d(pickup, var_fb40d5954b4f6792) {
  if(!isDefined(pickup.scriptablename)) {
    return 28;
  }

  var_4bd6d680451253cc = 0;

  if(pickup.count + self.br_ammo[pickup.scriptablename] <= level.var_e6ea72fc5e3fcd00[pickup.scriptablename]) {
    var_4bd6d680451253cc = 1;
  }

  var_2ca75f603de25b76 = function_d885e66811ee3a4d(pickup.scriptablename);

  if(var_fb40d5954b4f6792 && var_2ca75f603de25b76 && var_4bd6d680451253cc) {
    return 1;
  }

  lootid = scripts\cp_mp\utility\loot::getlootidfromref(pickup.scriptablename);
  result = function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result) || var_fb40d5954b4f6792 && self.br_ammo[pickup.scriptablename] < level.var_e6ea72fc5e3fcd00[pickup.scriptablename]) {
    return 20;
  }

  return 4;
}

function function_d885e66811ee3a4d(var_4ce224053f650637) {
  var_509d86412c9d7426 = self getweaponslistprimaries();
  var_2ca75f603de25b76 = 0;

  foreach(weap in var_509d86412c9d7426) {
    ammotypecomparison = br_ammo_type_for_weapon(weap);

    if(isDefined(ammotypecomparison) && var_4ce224053f650637 == ammotypecomparison) {
      return true;
    }
  }

  return false;
}

function function_e01d9736b2d100ac(lootid, quantity) {
  assertex(isDefined(lootid) && isDefined(quantity), "LootID or quantity not defined in canAddItemToBackpack in br_dmz_inventory.gsc");

  if(!isDefined(lootid) || !isDefined(quantity)) {
    return undefined;
  }

  result = undefined;

  if(!function_3c17a26ce6a4668(lootid)) {
    result = canitemfitinbackpack(lootid, quantity);
  } else {
    result = isDefined(getavailabledmzbackpackindex());
  }

  return result;
}

function function_8a160d9935d47f5e(ref, type, quantity) {
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
  return function_e01d9736b2d100ac(lootid, quantity);
}

function additemtobackpackbyref(ref, type, quantity, dontdropleftover) {
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
  fakepickup = spawnStruct();
  fakepickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  fakepickup.count = quantity;
  return additemtobackpack(lootid, fakepickup, dontdropleftover);
}

function canitemfitinbackpack(lootid, quantity) {
  initialquantity = quantity;
  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(lootname)) {
    lootname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  if(lootname == "brloot_offhand_geigercounter") {
    if(isDefined(level.var_193eacbf6d2d8179)) {
      if(![[level.var_193eacbf6d2d8179]](self)) {
        return false;
      }
    }
  }

  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount)) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  for(i = 0; i < level.var_e247454ac2869696; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(currentlootid == 0 && currentlootid != lootid) {
      return true;
    }

    if(currentlootid == lootid) {
      currentquantity = self getplayerdata("cp", "dmzBackpack", i, "quantity");

      if(currentquantity + quantity <= maxcount) {
        return true;
      }

      quantity = currentquantity + quantity - maxcount;
    }
  }

  if(quantity == initialquantity) {
    return false;
  }

  return true;
}

function function_d9b1550011525161(player) {
  return player getplayerdata("cp", "dmzWeapon", "lootItemID");
}

function function_efab78b72d131d76(player) {
  return istrue(level.var_f478c1f94caa7e9) && player getplayerdata("cp", "dmzWeapon", "weapon") != "none";
}

function function_8107fe0feec27866(player, weapon) {
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
  variantid = weapon.variantid;

  if(!isDefined(weapon.variantid)) {
    variantid = 0;
  }

  lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
  player setplayerdata("cp", "dmzWeapon", "weapon", rootname);
  player setplayerdata("cp", "dmzWeapon", "variantID", variantid);
  player setplayerdata("cp", "dmzWeapon", "lootItemID", lootid);
  player.weaponslotclip = player getweaponammoclip(weapon);

  if(weapon.hasalternate) {
    weaponalt = weapon getaltweapon();
    player.var_86b32aff94b5714e = player getweaponammoclip(weaponalt);
  }

  attachments = getweaponattachments(weapon);
  defaulttoidmap = scripts\cp_mp\weapon::getbaseweaponattachdefaulttoidmap(rootname);
  var_428a6c7cd65625c0 = 0;

  for(attachmentindex = 0; attachmentindex < attachments.size && var_428a6c7cd65625c0 < 7; attachmentindex++) {
    if(!isDefined(defaulttoidmap[attachments[attachmentindex]])) {
      player setplayerdata("cp", "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "attachment", attachments[attachmentindex]);
      player setplayerdata("cp", "dmzWeapon", "attachmentSetup", var_428a6c7cd65625c0, "variantID", 0);
      var_428a6c7cd65625c0++;
    }
  }

  function_5baaa0ce73d6fe84(player);
}

function function_5baaa0ce73d6fe84(player) {
  if(function_efab78b72d131d76(player)) {
    var_9ac5e72784815708 = function_2985254128b1c262(player);
    weaponammotype = br_ammo_type_for_weapon(var_9ac5e72784815708);

    if(isDefined(weaponammotype)) {
      var_3ca81573d978175b = 0;

      if(isDefined(player.weaponslotclip)) {
        var_3ca81573d978175b = player.weaponslotclip;
      }

      weaponstockammo = player.br_ammo[weaponammotype];
      maxstock = level.var_e6ea72fc5e3fcd00[weaponammotype];
      weaponstockammo = int(min(weaponstockammo, maxstock));
      player setclientomnvar("ui_playerdata_weapon_ammo", weaponstockammo + var_3ca81573d978175b);
    }
  }
}

function function_2985254128b1c262(player) {
  weapon = player getplayerdata("cp", "dmzWeapon", "weapon");
  variantid = player getplayerdata("cp", "dmzWeapon", "variantID");
  attachments = [];
  attachmentids = [];

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachments[attachmentindex] = player getplayerdata("cp", "dmzWeapon", "attachmentSetup", attachmentindex, "attachment");
    attachmentids[attachmentindex] = player getplayerdata("cp", "dmzWeapon", "attachmentSetup", attachmentindex, "variantID");
  }

  return scripts\cp_mp\weapon::buildweapon(weapon, attachments, undefined, undefined, variantid, attachmentids);
}

function br_getweaponstartingclipammo(weaponobj) {
  clipsize = weaponclipsize(weaponobj);
  return int(clipsize);
}

function br_forcegivecustomweapon(player, weaponobj, weaponfullname, weaponbasename, var_bde57922cf2180d3, var_eaac92793f70b7df) {
  if(player hasweapon(weaponobj)) {
    player scripts\cp\cp_hud_message::showerrormessage("MP/BR_ALREADY_HOLDING_WEAPON");
    return false;
  }

  hasmaxammo = weaponobj hasattachment("maxammo");
  fakepickup = spawnStruct();
  fakepickup.weapon = weaponobj;
  fakepickup.loadoutprimaryfullname = weaponfullname;
  fakepickup.scriptablename = weaponbasename;
  fakepickup.origin = player.origin + (0, 0, 24);
  fakepickup.count = br_getweaponstartingclipammo(weaponobj);
  fakepickup.countlefthand = 0;
  fakepickup.countalt = 0;

  if(hasmaxammo) {
    fakepickup.count = 999;
  }

  if(isDefined(var_bde57922cf2180d3) && isDefined(var_eaac92793f70b7df)) {
    ammoclip = weaponclipsize(weaponobj);
    var_4429cfcff681b936 = int(ceil(ammoclip * var_bde57922cf2180d3));
    fakepickup.count = int(min(var_4429cfcff681b936, var_eaac92793f70b7df));
  }

  if(scripts\cp\weapon::isakimbo(weaponobj)) {
    fakepickup.countlefthand = fakepickup.count;
  }

  if(weaponobj.hasalternate) {
    altweaponobj = weaponobj getaltweapon();
    var_6664d64b7cb8a858 = weaponclipsize(altweaponobj);
    fakepickup.countalt = var_6664d64b7cb8a858;

    if(hasmaxammo) {
      fakepickup.countalt = 999;
    }
  }

  if(getdvarint(@ "hash_c8896a161aebda74", 0) > 0) {
    player loadweaponsforplayer([fakepickup.loadoutprimaryfullname]);
  }

  player takeweaponpickup(fakepickup);

  if(weaponobj.hasalternate) {
    altweapon = weaponobj getaltweapon();

    if(altweapon.isalternate && scripts\cp_mp\weapon::function_de04e13ab01e1a10(altweapon.underbarrel)) {
      clipammo = weaponclipsize(altweapon);
      newammo = int(clipammo);
      player setweaponammoclip(altweapon, newammo);
    }
  }

  return true;
}

function isbackpackinventoryenabled() {
  if(!isDefined(level.noinventory)) {
    return false;
  }

  if(!level.noinventory) {
    return true;
  }

  return false;
}

function removesmallestitemstackbackpack(scriptablename, amountremoved) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  assertex(isDefined(lootid), "lootID not defined in removeSmallestItemStackBackpack");

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

function function_8863381bf5a8c162(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance.invalid_players) && istrue(instance.invalid_players[player.name])) {
    player thread scripts\cp\utility::hint_prompt("cant_use_yet", 1, 3);
    return;
  }

  used = 0;

  foreach(weapon in player.primaryweapons) {
    weaponammotype = player br_ammo_type_for_weapon(weapon);
    result = player br_ammo_type_player_full(player, weaponammotype);

    if(!result) {
      player scripts\cp\pickups::function_4172a10ae7cbdb41(weapon);
      used = 1;
    }
  }

  primary = player scripts\cp_mp\equipment::getcurrentequipment("primary");

  if(isDefined(primary)) {
    changed = player scripts\cp_mp\equipment::incrementequipmentammo(primary, 10);

    if(changed) {
      used = 1;
    }
  }

  secondary = player scripts\cp_mp\equipment::getcurrentequipment("secondary");

  if(isDefined(secondary)) {
    changed = player scripts\cp_mp\equipment::incrementequipmentammo(secondary, 10);

    if(changed) {
      used = 1;
    }
  }

  if(!istrue(level.var_cee48b761f8ca747)) {
    if(used) {
      instance thread function_df1c9968b5cbf288(player);
    } else {
      player thread scripts\cp\utility::hint_prompt("full_inventory", 1, 3);
    }

    return used;
  }

  var_1cd29382d1867470 = player scripts\cp_mp\armor::function_600f6cf462e983f();
  maxplates = player scripts\cp_mp\armor::function_47320a25b8ee003();

  if(var_1cd29382d1867470 < maxplates) {
    player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(maxplates - var_1cd29382d1867470);
    used = 1;
  }

  if(used) {
    instance thread function_df1c9968b5cbf288(player);
  } else {
    player thread scripts\cp\utility::hint_prompt("full_inventory", 1, 3);
  }

  return used;
}

function ammorestock_used(instance, part, state, player, bautouse, usestring) {
  assert(part == "military_ammo_restock" || part == "military_ammo_restock_train");

  if(br_ammorestock_playeruse(player)) {
    if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
      thread ammorestock_disableusefortime(instance, player, 90);
    } else {
      thread ammorestock_disableusefortime(instance, player, 0.1);
    }

    return;
  }

  thread ammorestock_disableusefortime(instance, player, 0.1);
}

function ammorestock_disableusefortime(scriptable, player, time) {
  level endon("game_ended");
  player endon("disconnect");
  scriptable disablescriptableplayeruse(player);
  wait time;
  scriptable enablescriptableplayeruse(player);
}

function br_ammorestock_playeruse(player) {
  var_bf64f721310414a0 = 0;
  var_a82c04c3789c6905 = 0;

  if(istrue(level.var_3480abea6656fce6)) {
    var_bf64f721310414a0 = player scripts\cp_mp\equipment::function_1ab06e1478168800();
    var_a82c04c3789c6905 = player scripts\cp_mp\equipment::function_f1c136649b4207d6();
  }

  var_535a3f9c599a0c5f = 0;

  if(istrue(level.var_cee48b761f8ca747)) {
    var_1cd29382d1867470 = player scripts\cp_mp\armor::function_600f6cf462e983f();
    maxplates = player scripts\cp_mp\armor::function_47320a25b8ee003();

    if(var_1cd29382d1867470 < maxplates) {
      slot = "health";

      if(!isDefined(player.equipment[slot]) || player scripts\cp_mp\equipment::getequipmentslotammo(slot) == 0) {
        player scripts\cp_mp\equipment::giveequipment("equip_armorplate", slot);
      }

      player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(maxplates - var_1cd29382d1867470);
      var_535a3f9c599a0c5f = 1;
    }
  }

  [gaveammo, var_d6a57b95fc473441] = giveammo(player);
  var_6e10774fa3fb048e = function_a95732425992ae46(player);

  if(!gaveammo && !var_535a3f9c599a0c5f && !var_bf64f721310414a0 && !var_a82c04c3789c6905 && !var_6e10774fa3fb048e) {
    if(istrue(var_d6a57b95fc473441)) {
      if(player isjuggernaut()) {
        if(player getclientomnvar("ui_assault_suit_on") == 1) {
          player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/CANNOT_REFILL_MINIGUN");
          return false;
        }
      } else {
        player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/CANNOT_REFILL_MINIGUN");
        return false;
      }
    }

    player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  player scripts\cp_mp\damagefeedback::hudicontype("br_ammo");
  player playlocalsound("iw9_support_box_use");
  return true;
}

function giveammo(player) {
  player = default_to(player, self);
  assertex(isDefined(player) && isPlayer(player), "You must pass in a player to give ammo to.");
  gaveammo = 0;
  var_417c6efd125fb6b8 = [];
  var_509d86412c9d7426 = player getweaponslistprimaries();

  if(player isjuggernaut()) {
    if(!isDefined(var_509d86412c9d7426) || var_509d86412c9d7426.size == 0) {
      minigun = player getcurrentweapon();
      var_d0bae9fa43b9e424 = player getcurrentweaponclipammo();
      var_e21a1fe75ea20307 = weaponclipsize(minigun);

      if(var_d0bae9fa43b9e424 < var_e21a1fe75ea20307) {
        player setweaponammoclip(minigun, var_e21a1fe75ea20307);
        player scripts\cp_mp\damagefeedback::hudicontype("br_ammo");
        player playlocalsound("iw9_support_box_use");
        br_ammo_update_weapons(player);
        self notify("ammo_update");
        return [1, 1];
      }
    }
  }

  var_d6a57b95fc473441 = 0;

  foreach(weap in var_509d86412c9d7426) {
    currenttype = br_ammo_type_for_weapon(weap);

    if(scripts\cp_mp\weapon::isminigunweapon(weap)) {
      var_d6a57b95fc473441 = 1;
      var_d591b3fb254c89d2 = weaponclipsize(weap);
      player setweaponammoclip(weap, var_d591b3fb254c89d2);
    }

    if(!function_2145743924c7fc7b(weap, player)) {
      continue;
    }

    if(!isDefined(currenttype)) {
      continue;
    } else if(br_ammo_give_type(player, currenttype, level.br_ammo_max[currenttype], 0, 1) <= 0) {
      continue;
    }

    giveammo = 1;

    if(var_417c6efd125fb6b8.size >= 1) {
      foreach(ammo in var_417c6efd125fb6b8) {
        if(currenttype == ammo) {
          giveammo = 0;
        }
      }
    }

    if(giveammo) {
      var_417c6efd125fb6b8[var_417c6efd125fb6b8.size] = currenttype;
      gaveammo = 1;
    }
  }

  self notify("ammo_update");
  br_ammo_update_weapons(player);
  return [gaveammo, var_d6a57b95fc473441];
}

function function_a95732425992ae46(player) {
  var_6e10774fa3fb048e = 0;
  var_509d86412c9d7426 = player getweaponslistprimaries();
  current_weapon = player getcurrentprimaryweapon();

  if(scripts\cp_mp\equipment\stimpistol::function_76ca0b3d8b2555ca(current_weapon)) {
    foreach(weap in var_509d86412c9d7426) {
      if(scripts\cp_mp\equipment\stimpistol::function_76ca0b3d8b2555ca(weap)) {
        continue;
      }

      current_weapon = weap;
      break;
    }
  }

  var_6e10774fa3fb048e = 0;

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    foreach(weap in var_509d86412c9d7426) {
      var_d0bae9fa43b9e424 = player getweaponammoclip(weap);
      var_e21a1fe75ea20307 = weaponclipsize(weap);

      if(var_d0bae9fa43b9e424 < var_e21a1fe75ea20307) {
        player setweaponammoclip(weap, var_d0bae9fa43b9e424 + 1);
      }
    }

    var_6e10774fa3fb048e = 1;
  }

  if(getdvarint(@ "hash_b404e78398423f9", 0)) {
    ammoclipsize = weaponclipsize(current_weapon);

    if(isDefined(ammoclipsize)) {
      clip = player getweaponammoclip(current_weapon);

      if(clip < ammoclipsize) {
        player setweaponammoclip(current_weapon, ammoclipsize);
        var_6e10774fa3fb048e = 1;
      }
    }
  }

  return var_6e10774fa3fb048e;
}

function function_2145743924c7fc7b(weapon, player) {
  if(scripts\cp_mp\equipment\stimpistol::function_76ca0b3d8b2555ca(weapon)) {
    return false;
  }

  return true;
}

function ammorestock_playeruse(player, loc) {
  player endon("death_or_disconnect");

  if(istrue(level.var_cee48b761f8ca747)) {
    var_1cd29382d1867470 = player scripts\cp_mp\armor::function_600f6cf462e983f();
    maxplates = player scripts\cp_mp\armor::function_47320a25b8ee003();

    if(var_1cd29382d1867470 < maxplates) {
      player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(maxplates - var_1cd29382d1867470);
    }
  }

  if(istrue(level.var_3480abea6656fce6)) {
    player scripts\cp_mp\equipment::function_1ab06e1478168800();
  }

  used = 0;
  var_12a372e8caa042bb = player.primaryweapons;
  temparray = [];

  foreach(item in var_12a372e8caa042bb) {
    if(!scripts\cp\weapon::ismeleeonly(item) && !scripts\cp\utility::issuperweapon(item) && !scripts\cp_mp\weapon::iskillstreakweapon(item)) {
      temparray[temparray.size] = item;
    }
  }

  var_12a372e8caa042bb = temparray;
  var_df04395b59031a4d = 0;

  foreach(weaponobj in var_12a372e8caa042bb) {
    wammotype = br_ammo_type_for_weapon(weaponobj);

    if(br_ammo_type_player_full(player, wammotype, 1)) {
      var_df04395b59031a4d++;
    }
  }

  if(var_df04395b59031a4d == var_12a372e8caa042bb.size) {
    player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  var_417c6efd125fb6b8 = [];

  foreach(index, item in var_12a372e8caa042bb) {
    var_417c6efd125fb6b8[index] = player getammotype(item);
  }

  var_824c3a21454e998d = 0;

  foreach(index, type in var_417c6efd125fb6b8) {
    if(isDefined(var_417c6efd125fb6b8[index + 1])) {
      if(var_417c6efd125fb6b8[index] == var_417c6efd125fb6b8[index + 1]) {
        var_824c3a21454e998d = 1;
        continue;
      }

      var_824c3a21454e998d = 0;
    }
  }

  var_126a4003fa316d0c = 0;

  if(var_824c3a21454e998d) {
    foreach(item in var_12a372e8caa042bb) {
      var_126a4003fa316d0c += weaponmaxammo(item);
    }
  }

  foreach(weaponobj in var_12a372e8caa042bb) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      player br_give_weapon_clip(weaponobj, 2);
      continue;
    }

    isakimbo = 0;

    if(weaponobj.isdualwield) {
      isakimbo = 1;
    }

    singleclipammo = scripts\cp\weapon::getammooverride(weaponobj);

    if(isakimbo) {
      stockammo = player getweaponammostock(weaponobj);
      newammo = int(min(weaponmaxammo(weaponobj), stockammo + singleclipammo * 2));
      player function_4906c10c3ffdd4ca(weaponobj, newammo);

      if(weaponclipsize(weaponobj) != player getweaponammoclip(weaponobj)) {
        player setweaponammoclip(weaponobj, 0, "left");
        player setweaponammoclip(weaponobj, 0, "right");
      }

      continue;
    }

    clipammo = player getweaponammoclip(weaponobj);
    stockammo = player getweaponammostock(weaponobj);

    if(var_824c3a21454e998d) {
      newammo = int(min(var_126a4003fa316d0c, stockammo + singleclipammo * 2));
    } else {
      newammo = int(min(weaponmaxammo(weaponobj), stockammo + singleclipammo * 2));
    }

    if(weaponobj.basename == "iw9_lm_dblmg2_cp") {
      player setweaponammoclip(weaponobj, clipammo + singleclipammo);
      continue;
    }

    player function_4906c10c3ffdd4ca(weaponobj, newammo);
  }

  player notify("ammo_update");
  player scripts\cp_mp\damagefeedback::hudicontype("br_ammo");
  player playlocalsound("iw9_support_box_use");
  return true;
}

function private function_df1c9968b5cbf288(player) {
  level endon("game_ended");

  if(!isDefined(self.invalid_players)) {
    self.invalid_players = [];
  }

  player_name = player.name;
  self.invalid_players[player_name] = 1;
  wait_time = 0;
  override_time = getdvarint(@ "hash_a97dd1a639fa9ee5", 0);

  if(override_time > 0) {
    wait_time = override_time;
  }

  wait wait_time;
  self.invalid_players[player_name] = undefined;
}

function function_f09e47b124561928() {
  if(isai(self)) {
    return;
  }

  function_7f04a682872040db(self);
  println(self.name + "<dev string:x2e2>");

  printinventory();

  inventory = snapshotinventory();
  var_113572a27a3ac22 = function_774fef5f034555ba();

  foreach(item in inventory) {
    index = undefined;

    if(var_113572a27a3ac22) {
      index = function_752a16f10a698186(item.lootid, &function_25be694d7a22db61);
    } else {
      index = function_752a16f10a698186(item.lootid);
    }

    if(isDefined(index)) {
      currentquantity = self getplayerdata("cp", "dmzInventory", index, "quantity");
      ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(item.lootid);

      println("<dev string:x2fe>");
      println("<dev string:x2d3>" + index + "<dev string:x2d5>" + item.lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + currentquantity);

      if(currentquantity == 1) {
        if(var_113572a27a3ac22) {
          itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(item.lootid);

          if(itemtype == "weapon") {
            function_e249cffd8b8f7a9(index, item.lootid, currentquantity, getweaponcooldown());
            continue;
          }
        }

        function_e249cffd8b8f7a9(index, 0, 0);
        continue;
      }

      function_e249cffd8b8f7a9(index, item.lootid, currentquantity - 1);
    }
  }

  var_341de26bf458efaa = self getplayerdata("cp", "dmzPocketCash");
  data = createplayerplundereventdata();
  function_46ee9182cf6872d5(var_341de26bf458efaa);
  self setplayerdata("cp", "dmzPocketCash", 0);
  println(self.name + "<dev string:x31b>");
  printinventory();

  if(!function_b0d22762c7ee8fe4()) {
    clearloadout();
  }

  function_5baaa0ce73d6fe84(self);
}

function function_46ee9182cf6872d5(value) {
  multiplier = function_6c95beb0447ff560();
  scripts\cp_mp\cash::playersetplunderomnvar(int(value / multiplier));
}

function function_6c95beb0447ff560() {
  return getdvarint(@ "hash_7360a50e3ff1a193", 10);
}

function clearloadout() {
  function_e2b623e5ad975ee(0, 0);
  function_e2b623e5ad975ee(0, 1);
  function_7734d7b754df1192(0, 0, "none");
  function_7734d7b754df1192(0, 1, "none");
}

function function_5f0596c296180f6c(index, ref) {}

function function_7734d7b754df1192(classindex, equipindex, ref) {}

function function_e2b623e5ad975ee(classindex, weaponindex) {
  function_8c5b523b8e941dc2(classindex, weaponindex, "iw9_me_fists");
  function_e5a485a5370debc1(classindex, weaponindex, 0);

  for(attachindex = 0; attachindex < 5; attachindex++) {}

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {}
}

function function_8c5b523b8e941dc2(classindex, weaponindex, ref) {}

function function_e5a485a5370debc1(classindex, weaponindex, lootid) {}

function function_b0d22762c7ee8fe4() {
  if(!isDefined(level.var_a488de48eee3f95e)) {
    level.var_a488de48eee3f95e = getdvarint(@ "hash_b3d354dab8da45d4", 0);
  }

  return level.var_a488de48eee3f95e;
}

function function_2d55e66e05614871() {
  println(self.name + "<dev string:x33f>");

  for(i = 0; i < 10; i++) {
    lootid = self getplayerdata("cp", "dmzBackpackFE", i, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpackFE", i, "quantity");
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    println("<dev string:x2d3>" + i + "<dev string:x362>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + lootid);
    println("<dev string:x2d3>" + i + "<dev string:x369>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + quantity);

    self setplayerdata("cp", "dmzBackpack", i, "lootID", lootid);
    self setplayerdata("cp", "dmzBackpack", i, "quantity", quantity);
    function_bac731e0fdaa0ccb(lootid);
    self setplayerdata("cp", "dmzBackpackFE", i, "lootID", 0);
    self setplayerdata("cp", "dmzBackpackFE", i, "quantity", 0);
  }

  println(self.name + "<dev string:x376>");

  for(i = 0; i < 10; i++) {
    lootid = self getplayerdata("cp", "dmzBackpackFE", i, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpackFE", i, "quantity");
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    println("<dev string:x2d3>" + i + "<dev string:x362>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + lootid);
    println("<dev string:x2d3>" + i + "<dev string:x369>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + quantity);
  }

  println(self.name + "<dev string:x387>");

  for(i = 0; i < 10; i++) {
    lootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpack", i, "quantity");
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    println("<dev string:x2d3>" + i + "<dev string:x362>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + lootid);
    println("<dev string:x2d3>" + i + "<dev string:x369>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + quantity);
  }
}

function function_bac731e0fdaa0ccb(lootid) {
  println(self.name + "<dev string:x396>" + "<dev string:x3b4>" + lootid);

  if(!isDefined(lootid) || lootid == 0) {
    return;
  }

  type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  if(!isDefined(type)) {
    return;
  }

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
      if(isDefined(level.var_b33c035c483c2893) && isDefined(level.var_b33c035c483c2893["onMatchStart"]) && isDefined(level.var_b33c035c483c2893["onMatchStart"][ref])) {
        [[level.var_b33c035c483c2893["onMatchStart"][ref]]](self);
      }

      return;
  }
}

function function_e249cffd8b8f7a9(index, lootid, quantity, cooldown) {
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  println(self.name + "<dev string:x3b7>" + index + "<dev string:x2cd>" + lootid + "<dev string:x2cd>" + quantity + "<dev string:x2d0>");
  println("<dev string:x2d3>" + index + "<dev string:x2d5>" + lootid + "<dev string:x2db>" + ref + "<dev string:x2de>" + quantity);

  if(lootid == 0 || quantity <= 0) {
    lootid = 0;
    quantity = 0;
  }

  if(!isDefined(cooldown)) {
    cooldown = 0;
  }

  self setplayerdata("cp", "dmzInventory", index, "lootID", lootid);
  self setplayerdata("cp", "dmzInventory", index, "quantity", quantity);
  self setplayerdata("cp", "dmzInventory", index, "cooldownEndTime", cooldown);
}

function getweaponcooldown() {
  if(!isDefined(level.var_c04142d70a12ce89)) {
    level.var_c04142d70a12ce89 = getdvarint(@ "hash_40eb514e313dd3ef", 43200);
  }

  return getsystemtime() + level.var_c04142d70a12ce89;
}

function function_752a16f10a698186(lootid, testvalid) {
  if(lootid == 0) {
    return undefined;
  }

  for(i = 0; i < 50; i++) {
    currentlootid = self getplayerdata("cp", "dmzInventory", i, "lootID");

    if(lootid == currentlootid) {
      if(!isDefined(testvalid) || self[[testvalid]](i)) {
        return i;
      }
    }
  }

  return undefined;
}

function function_25be694d7a22db61(itemindex) {
  if(self getplayerdata("cp", "dmzInventory", itemindex, "cooldownEndTime") > gettime()) {
    return false;
  }

  return true;
}

function function_774fef5f034555ba() {
  if(!isDefined(level.var_113572a27a3ac22)) {
    level.var_113572a27a3ac22 = getdvarint(@ "hash_e28234d5ed130fb4", 1);
  }

  return level.var_113572a27a3ac22;
}

function function_52f61c6576e6a9f5() {
  level.var_effb351e78e1ed6c = [];
}

function delete_revives() {
  foreach(ss in level.var_effb351e78e1ed6c) {
    if(isDefined(ss)) {
      scripts\cp\pickups::loothide(ss);
    }
  }

  flag_set("deleted_revives");
}

function spawn_pickups() {
  level endon("game_ended");
  function_244e6c9f27c6d81();
  flag_wait("level_ready_for_script");
  flag_wait("loot_hack_complete");

  if(getdvarint(@ "hash_41ab31c3b86aa5b1", 0) == 1) {
    function_52f61c6576e6a9f5();
  }

  thread function_6fe97cf815da0051();
  thread function_8847aa701752972b();
  thread function_fb4fb47ca3cada2c();
  thread function_edc3bc07b0a2a146();
  thread function_2798b0cf132300ca();
}

function function_6fe97cf815da0051() {
  if(flag("cp_equipment_pickups_spawned")) {
    return;
  }

  level endon("game_ended");
  var_3f0c694d3bf37be1 = 0;

  foreach(loot_name, pickup_str in level.registered_pickups) {
    var_c2c7f18e2611a8b5 = getStructArray(pickup_str.tname, "targetname");
    var_fa378e0dc2bb99f6 = 10;

    foreach(loc in var_c2c7f18e2611a8b5) {
      loc.angles = default_to(loc.angles, (0, 0, 0));
      var_97331585b4002aa7 = loc function_e128592dbb634077();

      if(loot_name == "brloot_offhand_molotov") {
        x = 0;
      }

      if(!var_97331585b4002aa7) {
        if(istrue(var_3f0c694d3bf37be1)) {
          loc.angles += pickup_str.angles_offset;
        } else if(istrue(pickup_str.var_85bca64deb9b3318)) {
          loc.angles += pickup_str.forced_angles;
        } else {
          loc.angles = pickup_str.forced_angles;
        }

        loc.origin += pickup_str.origin_offset;
      }

      drop_info = scripts\cp\pickups::getitemdropinfo(loc.origin, loc.angles, undefined, undefined, var_97331585b4002aa7);
      item = scripts\cp\pickups::spawnpickup(loot_name, drop_info, pickup_str.default_count, undefined, undefined, 1);

      if(isDefined(loc.script_objective)) {
        item.count = int(loc.script_objective);
      }

      if(getdvarint(@ "hash_41ab31c3b86aa5b1", 0) == 1 && isrevivepickup(loot_name)) {
        level.var_effb351e78e1ed6c[level.var_effb351e78e1ed6c.size] = item;
      }

      var_fa378e0dc2bb99f6--;

      if(var_fa378e0dc2bb99f6 == 0) {
        var_fa378e0dc2bb99f6 = 10;
        waitframe();
      }
    }
  }

  flag_set("cp_equipment_pickups_spawned");
}

function function_244e6c9f27c6d81() {
  register_pickup("snapshot_pickup", "brloot_offhand_snapshot", 1, (0, 0, 0), 1);
  register_pickup("molotov_pickup", "brloot_offhand_molotov", 1, (0, 0, -90));
  register_pickup("semtex_pickup", "brloot_offhand_semtex", 1, (0, 0, 0));
  register_pickup("c4_pickup", "brloot_offhand_c4", 1, (0, 0, -90), 1);
  register_pickup("frag_grenade_pickup", "brloot_offhand_frag", 1, (0, 0, 0), 1);
  register_pickup("claymore_pickup", "brloot_offhand_claymore", 1, (0, 0, 0), 1);
  register_pickup("thermite_pickup", "brloot_offhand_thermite", 1, (0, 0, 0), 1);
  register_pickup("throwing_knife_pickup", "brloot_offhand_throwingknife", 1, (0, 0, 0), 1);
  register_pickup("fire_throwing_knife_pickup", "brloot_offhand_throwingknife_fire", 1, (0, 0, 0), 1);
  register_pickup("at_mine_pickup", "brloot_offhand_atmine", 1, (0, 0, 0), 1);
  register_pickup("shock_pickup", "brloot_offhand_shockstick", 1, (0, 0, 0), 1);
  register_pickup("self_revive_pickup", "brloot_self_revive", undefined, (0, 0, 0), 1);
  register_pickup("armor_pickup_vest", "brloot_plate_pouch", undefined, (0, 0, 0), 1);
  register_pickup("armor_pickup_plate", "brloot_armor_plate", undefined, (0, 0, 0), 1);
  register_pickup("armor_platecarrier_upgrade", "jup_armor_platecarrier_upgrade", undefined, (0, 0, 0), 1);
  register_pickup("adrenaline_pickup", "brloot_health_adrenaline", 1, (0, 0, 0), 1);
  register_pickup("bottle_pickup", "brloot_offhand_jup_bottle", 1, (0, 0, 0));
  register_pickup("flash_pickup", "brloot_offhand_flash", 1, (0, 0, 0));
  register_pickup("gas_pickup", "brloot_offhand_gas", 1, (0, 0, 0), 1);
  register_pickup("hbsensor_pickup", "brloot_offhand_heartbeatsensor", 1, (0, 0, 0), 1);
  register_pickup("gasmask_pickup", "brloot_equip_gasmask", 1, (0, 0, 0), 1);
  register_pickup("nvg_pickup", "brloot_nvg", 1, (0, 0, 0), 1);
}

function function_fb4fb47ca3cada2c() {
  if(flag("cp_custom_pickups_spawned")) {
    return;
  }

  level endon("game_ended");
  equipment_spawns = getStructArray("custom_pickup", "targetname");
  var_8231196c5573b55d = getStructArray("custom_pickup_cur", "targetname");
  equipment_spawns = array_combine(equipment_spawns, var_8231196c5573b55d);
  var_d33c196bd4e3883e = getStructArray("starting_equipment", "targetname");
  var_b581b204746ade37 = getStructArray("starting_equipment_cur", "targetname");
  var_d33c196bd4e3883e = array_combine(var_d33c196bd4e3883e, var_b581b204746ade37);
  equipment_spawns = array_combine(equipment_spawns, var_d33c196bd4e3883e);

  for(i = 0; i < equipment_spawns.size; i++) {
    if(!isDefined(equipment_spawns[i].script_noteworthy)) {
      continue;
    }

    var_97331585b4002aa7 = equipment_spawns[i] function_e128592dbb634077();
    dropinfo = scripts\cp\pickups::getitemdropinfo(equipment_spawns[i].origin, equipment_spawns[i].angles, undefined, undefined, var_97331585b4002aa7);
    item_name = equipment_spawns[i].script_noteworthy;
    item = scripts\cp\pickups::spawnpickup(item_name, dropinfo);

    if(!isDefined(item)) {
      continue;
    }

    item.var_ff45e00f9ed1e5c9 = 1;
    item.isweaponfromcrate = 1;

    if(isDefined(equipment_spawns[i].script_objective)) {
      item.count = int(equipment_spawns[i].script_objective);
    }

    waitframe();
  }

  flag_set("cp_custom_pickups_spawned");
}

function function_edc3bc07b0a2a146() {
  if(flag("cp_munition_pickups_spawned")) {
    return;
  }

  structs = getStructArray("munition_pickup", "targetname");

  foreach(struct in structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }

    var_97331585b4002aa7 = struct function_e128592dbb634077();
    dropinfo = scripts\cp\pickups::getitemdropinfo(struct.origin, struct.angles, undefined, undefined, var_97331585b4002aa7);
    item_name = struct.script_noteworthy;
    item = scripts\cp\pickups::spawnpickup(item_name, dropinfo);
    item.var_ff45e00f9ed1e5c9 = 1;
    item.isweaponfromcrate = 1;

    if(isDefined(struct.script_objective)) {
      item.count = int(struct.script_objective);
    }

    waitframe();
  }

  flag_set("cp_munition_pickups_spawned");
  flag_set("cp_custom_pickups_spawned");
}

function function_8847aa701752972b() {
  if(flag("cp_weapon_pickups_spawned")) {
    return;
  }

  level endon("game_ended");
  flag_wait("level_ready_for_script");
  flag_wait("loot_hack_complete");
  weapons = getStructArray("weapon_pickup", "targetname");

  if(isDefined(level.struct_class_names) && isDefined(level.struct_class_names["targetname"])) {
    foreach(struct_array in level.struct_class_names["targetname"]) {
      if(targetname == "weapon_pickup") {
        continue;
      }

      foreach(struct in struct_array) {
        if(isDefined(struct.bulletweapon)) {
          weapons[weapons.size] = struct;
        }
      }
    }
  }

  [origin_offset, angles_offset] = function_1c134e183bc46cd7("brloot_weapon");

  foreach(weap in weapons) {
    origin = weap.origin;
    angles = weap.angles;

    if(isDefined(weap.script_parameters) && weap.script_parameters != "") {
      spawned_weapon = function_8119f212171548bf(weap.script_parameters, origin, angles);
      continue;
    }

    if(isDefined(weap.bulletweapon) && weap.bulletweapon != "") {
      var_97331585b4002aa7 = weap function_e128592dbb634077();
      spawned_weapon = function_8119f212171548bf(weap.bulletweapon, origin, angles, undefined, undefined, var_97331585b4002aa7);
    }
  }

  flag_set("cp_weapon_pickups_spawned");
}

function function_e128592dbb634077() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    return true;
  }

  if(istrue(self.script_suspend)) {
    return true;
  }

  return false;
}

function function_2798b0cf132300ca() {
  structs = getStructArray("dungeon_weapon_crate", "targetname");
  flag_init("item_caches_populated");
  flag_wait("loot_hack_complete");

  foreach(struct in structs) {
    if(!isDefined(struct.script_noteworthy)) {
      msg = "<dev string:x3d2>" + struct.origin + "<dev string:x3f2>";
      assertmsg(msg);
      continue;
    }

    crateinfo = namespace_cfe848c6b27fe834::function_231f43f1d8cf0ef1(struct.script_noteworthy);
    var_da63677a16704210 = crateinfo.var_20c06686589dcd6d;

    if(getdvarint(@ "hash_9c7b7540824ac88e", 0) == 1) {
      var_d9da0ac7ab54f1be = crateinfo.var_3124d97e64e2ed57;

      if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_pistol") {
        type_override = "cp_blueprint_crate_dungeons_pistol";
        var_da63677a16704210 = "jup_military_munition_case_01_pistol_rig_ent";
      } else if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_large") {
        type_override = "cp_blueprint_crate_dungeons_large";
        var_da63677a16704210 = "xcomp_jup_military_loot_crate_01_sp_ent_l";

        if(is_equal(var_d9da0ac7ab54f1be, "depth01")) {
          var_da63677a16704210 += "_depth01";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
          var_da63677a16704210 += "_depth03";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth06")) {
          var_da63677a16704210 += "_depth06";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth10")) {
          var_da63677a16704210 += "_depth10";
        }
      } else if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_xlarge") {
        type_override = "cp_blueprint_crate_dungeons_xlarge";

        if(is_equal(var_d9da0ac7ab54f1be, "depth30")) {
          var_da63677a16704210 = "orange::jup_military_loot_crate_01_sp_ent_xl";
        } else {
          var_da63677a16704210 = "xcomp_jup_military_loot_crate_01_sp_ent_xl";

          if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
            var_da63677a16704210 += "_depth03";
          } else if(is_equal(var_d9da0ac7ab54f1be, "depth07")) {
            var_da63677a16704210 += "_depth07";
          } else if(is_equal(var_d9da0ac7ab54f1be, "depth15")) {
            var_da63677a16704210 += "_depth15";
          }
        }
      } else {
        type_override = "cp_blueprint_crate_dungeons";
        var_da63677a16704210 = "xcomp_jup_military_loot_crate_01_sp_ent_r";

        if(is_equal(var_d9da0ac7ab54f1be, "depth01")) {
          var_da63677a16704210 += "_depth01";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
          var_da63677a16704210 += "_depth03";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth06")) {
          var_da63677a16704210 += "_depth06";
        }
      }

      crate = spawn("script_model", struct.origin);
      crate.angles = struct.angles;
      crate setModel(var_da63677a16704210);
      crate.type = type_override;

      if(!isDefined(level.var_2bf46003ba58c954)) {
        level.var_2bf46003ba58c954 = [];
      }

      level.var_2bf46003ba58c954 = array_add(level.var_2bf46003ba58c954, crate);
    } else {
      var_d9da0ac7ab54f1be = crateinfo.var_3124d97e64e2ed57;

      if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_pistol") {
        var_da63677a16704210 = "cp_blueprint_crate_dungeons_pistol";
        type_override = "cp_blueprint_crate_dungeons_pistol";
      } else if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_large") {
        if(is_equal(var_d9da0ac7ab54f1be, "depth01")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_large_depth01";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_large_depth03";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth06")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_large_depth06";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth10")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_large_depth10";
        } else {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_large";
        }

        type_override = "cp_blueprint_crate_dungeons_large";
      } else if(var_da63677a16704210 == "cp_blueprint_crate_dungeons_xlarge") {
        if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_xlarge_depth03";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth07")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_xlarge_depth07";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth15")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_xlarge_depth15";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth30")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_xlarge_depth30";
        } else {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_xlarge";
        }

        type_override = "cp_blueprint_crate_dungeons_xlarge";
      } else {
        if(is_equal(var_d9da0ac7ab54f1be, "depth01")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_depth01";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth03")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_depth03";
        } else if(is_equal(var_d9da0ac7ab54f1be, "depth06")) {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons_depth06";
        } else {
          var_da63677a16704210 = "cp_blueprint_crate_dungeons";
        }

        type_override = "cp_blueprint_crate_dungeons";
      }

      crate = spawnscriptable(var_da63677a16704210, struct.origin, struct.angles);
    }

    if(!isDefined(level.var_92bc844b6f90242a)) {
      level.var_92bc844b6f90242a = [];
    }

    level.var_92bc844b6f90242a[level.var_92bc844b6f90242a.size] = crate;

    if(isDefined(struct.script_count)) {
      crate.script_count = struct.script_count;
    }

    crate.itemname = struct.script_noteworthy;

    if(isDefined(struct.script_label)) {
      crate.missionname = struct.script_label;
    }

    waitframe();
  }

  flag_set("item_caches_populated");
}

function function_8119f212171548bf(weapon_name, spawn_origin, spawn_angles, weapon_modifier, count, var_97331585b4002aa7) {
  weapon_obj = undefined;

  if(isDefined(level.var_bcd25cd23011249)) {
    if(array_contains_key(level.var_bcd25cd23011249, weapon_name)) {
      weapon_obj = level.var_bcd25cd23011249[weapon_name];
    } else {
      toks = strtok(weapon_name, "+");

      if(isDefined(toks) && toks.size > 0) {
        base_name = toks[0];

        if(!array_contains_key(level.var_bcd25cd23011249, base_name)) {
          assertmsg("Base weapon '" + base_name + "' not found in the weapon list scriptbundle for this project.Please ensure weapon is included.");
          return;
        }

        attachments = array_remove_index(toks, 0, 0);
        weapon_obj = makeweapon(base_name, attachments);
      }
    }
  }

  if(!isDefined(weapon_obj)) {
    return;
  }

  completeweaponname = getcompleteweaponname(weapon_obj);

  if(completeweaponname == "none") {
    return;
  }

  if(!isDefined(count)) {
    count = weaponclipsize(weapon_obj) * 3;
  }

  countalt = undefined;

  if(weapon_obj.hasalternate) {
    var_414f6f05dd56d073 = weapon_obj getaltweapon();

    if(br_ammo_type_for_weapon(var_414f6f05dd56d073) != br_ammo_type_for_weapon(weapon_obj)) {
      countalt = weaponclipsize(var_414f6f05dd56d073) * 3;
    }
  }

  drop_info = scripts\cp\pickups::getitemdropinfo(spawn_origin, spawn_angles, undefined, undefined, var_97331585b4002aa7);
  var_d9755f3d1d426a77 = scripts\cp\pickups::spawnpickup(completeweaponname, drop_info, count, 1, weapon_obj, undefined, undefined, countalt);
  return var_d9755f3d1d426a77;
}

function function_1c134e183bc46cd7(str_type) {
  origin_offset = (0, 0, 0);
  angles_offset = (0, 0, 0);

  switch (str_type) {
    case #"hash_8f8a3429bcffcbfc":
      origin_offset = (0, 0, 2);
      angles_offset = (0, 90, -90);
      break;
    case #"hash_36b47d09e6eca09d":
      origin_offset = (0, 0, 3);
      break;
    case #"hash_e8e7b62030261269":
      origin_offset = (0, 0, -1.8);
      angles_offset = (0, 0, -90);
      break;
    case #"hash_c740a7ba6ff37781":
      origin_offset = (0, 0, -1.5);
      break;
    case #"hash_d4b690624f898e02":
      origin_offset = (0, 0, -0.5);
      angles_offset = (0, 0, -90);
      break;
    case #"hash_a500f53d3e52d6e":
      angles_offset = (0, -180, 0);
      break;
    case #"hash_b9494439da2d7ca5":
      origin_offset = (0, 0, -1.5);
      break;
    case #"hash_9ad472e96ffa7649":
      origin_offset = (0, 0, -3.5);
      break;
    case #"hash_736e4b57f09fd01f":
      origin_offset = (0, 0, -1.4);
      angles_offset = (0, 0, -84);
      break;
    case #"hash_64cb76a790aa0ddf":
    case #"hash_e6613df7bf5f6ebe":
      origin_offset = (0, 0, -0.5);
      angles_offset = (0, 0, -90);
      break;
    case #"hash_2838637cb090a498":
      origin_offset = (0, 0, -1);
      angles_offset = (-90, 0, 0);
      break;
    case #"hash_e702c0e73839c7a3":
      angles_offset = (90, 0, 0);
      break;
    case #"hash_4326cb8d4b104ef9":
      origin_offset = (0, 0, -1.3);
      angles_offset = (-90, 0, 0);
      break;
    case #"hash_46fa1fc325bffb72":
      origin_offset = (0, 0, -1.3);
      angles_offset = (0, 0, -90);
      break;
    case #"hash_12214dbd291d3d03":
    case #"hash_9a59926a43d025a9":
    default:
      break;
  }

  return [origin_offset, angles_offset];
}

function register_pickup(tname, loot_name, default_count, forced_angles, var_85bca64deb9b3318) {
  if(!isDefined(level.registered_pickups)) {
    level.registered_pickups = [];
  }

  level.registered_pickups[loot_name] = spawnStruct();
  level.registered_pickups[loot_name].tname = tname;
  level.registered_pickups[loot_name].default_count = default_count;
  level.registered_pickups[loot_name].forced_angles = forced_angles;
  level.registered_pickups[loot_name].var_85bca64deb9b3318 = var_85bca64deb9b3318;
  [origin_offset, angles_offset] = function_1c134e183bc46cd7(loot_name);
  level.registered_pickups[loot_name].origin_offset = origin_offset;
  level.registered_pickups[loot_name].angles_offset = angles_offset;
}

function spawnhealthpickup() {
  droplocation = self.origin;
  startpos = droplocation + (0, 0, 14);
  stance = self getstance();
  zoffset = 35;

  if(stance == "prone") {
    zoffset = 14;
  }

  if(stance == "crouch") {
    zoffset = 25;
  }

  movetostartpos = droplocation + (0, 0, zoffset);
  randomangle = (0, randomfloat(360), 0);
  randomdir = anglesToForward(randomangle);
  randomdst = randomfloatrange(30, 150);
  testpos = startpos + randomdst * randomdir;
  movetoendpos = playerphysicstrace(startpos, testpos);

  if(!isDefined(self.healthpickup)) {
    visuals = [];
    visuals[0] = spawn("script_model", movetostartpos);
    visuals[0] setModel("equipment_scavenger_bag");
    trigger = spawn("trigger_radius", movetostartpos, 0, 32, 32);
    pickup = scripts\cp\gameobjects::createuseobject("neutral", trigger, visuals, undefined, undefined, 1);
    pickup.onuse = &function_75c517d33cd52b54;
    pickup.usetime = 0;
    pickup scripts\cp\gameobjects::function_58281ac4da450ded("any");
    pickup.owner = self;
    self.healthpickup = pickup;
    self.healthpickup thread function_c0a12a6b52fed534();
  } else {
    self.healthpickup.curorigin = movetostartpos;
    self.healthpickup.visuals[0].origin = movetostartpos;
    self.healthpickup.trigger.origin = movetostartpos;
  }

  self.healthpickup thread function_a7d682792f532578(movetostartpos, movetoendpos);

  if(level.var_accb27010daa82d > 0) {
    self.healthpickup thread function_2af863f00a8c4505();
  }
}

function function_a7d682792f532578(startpos, endpos) {
  self endon("death");
  initialforce = (endpos - startpos) * 25;
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, initialforce);
  wait 1;

  if(isDefined(self.trigger) && isDefined(self.visuals[0])) {
    self.trigger.origin = self.visuals[0].origin;
    self.curorigin = self.visuals[0].origin;
    self.visuals[0] physicsstopserver();
  }
}

function function_75c517d33cd52b54(player, team) {
  if(player.health == player.maxhealth) {
    return;
  }

  player playsoundtoplayer("br_pickup_generic", player);
  player thread function_83843e755681a78c();

  if(level.var_ee05489a095df4d1) {
    if(level.var_11d8636343eae20c == 0) {
      player.health = player.maxhealth;
    } else {
      player.health = min(player.health + level.var_11d8636343eae20c, player.maxhealth);
    }
  } else {
    player notify("force_regeneration");
  }

  function_884dc0265a0070ac();
}

function function_83843e755681a78c() {
  self endon("death_or_disconnect");
  self lerpfovbypreset("zombiedefault");
  wait 0.5;
  self lerpfovbypreset("default_2seconds");
}

function function_c0a12a6b52fed534() {
  self waittill("disconnect");
  function_884dc0265a0070ac();
}

function function_2af863f00a8c4505() {
  self endon("death");
  self notify("monitorTimeOut");
  self endon("monitorTimeOut");
  wait level.var_accb27010daa82d;
  function_884dc0265a0070ac();
}

function function_884dc0265a0070ac() {
  if(isDefined(self.owner)) {
    self.owner.healthpickup = undefined;
  }

  self.visuals[0] delete();
  scripts\cp\gameobjects::deleteuseobject();
}