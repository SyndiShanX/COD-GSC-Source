/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\pickups.gsc
***********************************************/

init() {
  setDvar("scr_game_cash", 1);
  level._id_E247454AC2869696 = getdvarint("dvar_005FCBCE13EF8D5F", 9);
  level._id_C59C301EAABC2E32 = getdvarint("dvar_19FAE1AAD58E8C50", 0);
  level.br_plunder_enabled = getdvarint("scr_game_cash", 0);
  level._id_1D814F83596D0A02 = getdvarint("dvar_07A1DA73FA673ED8", 1);
  level._id_A7F81DFDC88E53E6 = 1;
  level._id_201C841C4668A94F = "dmzBackpack";
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_195F5055031AD0CB);
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_52DB16C0F1B89F36);
  br_pickups_init();

  if(getdvarint("dvar_A21301E95040B2AB", 1)) {
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock", ::ammorestock_used);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock_train", ::ammorestock_used);
  }
}

br_pickups_init() {
  level.br_pickups = spawnStruct();
  initarrays();
  initscriptablemanagement();
  _id_24EA0B21194D20CE();
}

initarrays() {
  level.brloottablename = getDvar("loot_table_name", "cp/loot/default/loot_item_defs.csv");

  if(level.brloottablename == "")
    level.brloottablename = "cp/loot/default/loot_item_defs.csv";

  level._id_6178CE645AEEB787 = getDvar("loot_table_zone", "cp/loot/default/loot_table_zones.csv");

  if(level._id_6178CE645AEEB787 == "") {
    level._id_6178CE645AEEB787 = "cp/loot/default/loot_table_zones.csv";
    setDvar("loot_table_zones", level._id_6178CE645AEEB787);
  }

  if(!isDefined(level.br_pickups))
    level.br_pickups = spawnStruct();

  level.br_pickups.createcallbacks = [];
  level.br_pickups.droppedgasmasks = [];
  level.br_pickups.br_equipname = [];
  level.br_pickups.stackable = [];
  level.br_pickups.maxcounts = [];
  level.br_pickups.counts = [];
  level.br_pickups.br_itemtype = [];
  level.br_pickups.br_itemrow = [];
  level.br_pickups.br_itemrarity = [];
  level.br_pickups._id_D93566A78E29D583 = [];
  level.br_pickups.br_equipnametoscriptable = [];
  level.br_pickups.br_weapontoscriptable = [];
  level.br_pickups._id_7B2BFF2D04EE1017 = [];
  level.br_pickups._id_B13DC7E63676BBE7 = [];
  level.br_pickups.br_pickupsfx = [];
  level.br_pickups._id_14BD11727C4B6629 = [];
  level.br_pickups._id_838863C4848D4C26 = [];
  level.br_pickups.br_hasautopickup = [];
  level.br_pickups.uniquelootcallbacks = [];
  level.br_pickups._id_04138F9DDC1CD22D = [];
  level.br_pickups._id_52AAC7E6E7072413 = [];
  level.br_pickups._id_52C58DA4C35FDE00 = [];
  level.br_pickups._id_0A5E4B146866D7FD = [];
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
  _id_6A537EE3949585F4 = [];
  _id_5C845B7A0EF0780F = 0;
  _id_55DFF3C24D1396C9 = "+";
  _id_4236BEE99BA1D49B = tablelookupgetnumrows(level.brloottablename);

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_4236BEE99BA1D49B; _id_CB89110314447B2F++) {
    key = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 0);

    if(!isDefined(key)) {
      continue;
    }
    if(key == "item") {
      itemtype = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2);

      if(!isDefined(itemtype)) {
        continue;
      }
      _id_14004B68DDACB781 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 1);
      _id_42B066F111A584F3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 7);
      level.br_pickups._id_D93566A78E29D583[_id_14004B68DDACB781] = int(_id_42B066F111A584F3);
      _id_BB255CC38C4AA89D = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 5);
      _id_2AD07B9C3ADC39E3 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 17));
      level.br_pickups.maxcounts[_id_14004B68DDACB781] = _id_2AD07B9C3ADC39E3;
      level.br_pickups.br_hasautopickup[_id_14004B68DDACB781] = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 20));
      _id_52E1D38987AF61C3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 34);
      level.br_pickups._id_0A5E4B146866D7FD[_id_14004B68DDACB781] = isDefined(_id_52E1D38987AF61C3) && _id_52E1D38987AF61C3 != "";
      level.br_pickups.br_itemrow[_id_14004B68DDACB781] = int(_id_CB89110314447B2F);

      if(itemtype != "tablet") {
        _id_D530BDB3D172E1CB = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 21));
        _id_D530BCB3D172DF98 = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 22));
        _id_D530BFB3D172E631 = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 23));
        _id_54EEAA80BA02A904 = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 24));
        _id_54EEAB80BA02AB37 = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 25));
        _id_54EEAC80BA02AD6A = float(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 26));
        level.br_pickups._id_52AAC7E6E7072413[_id_14004B68DDACB781] = (_id_D530BDB3D172E1CB, _id_D530BCB3D172DF98, _id_D530BFB3D172E631);
        level.br_pickups._id_52C58DA4C35FDE00[_id_14004B68DDACB781] = (_id_54EEAA80BA02A904, _id_54EEAB80BA02AB37, _id_54EEAC80BA02AD6A);
      }

      _id_EC51234E00E53E8A(itemtype, _id_14004B68DDACB781);

      if(itemtype == "weapon") {
        _id_AE10C1B57593E13F = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 3);
        _id_8D1FE71563B03100 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 14);
        _id_2B69EA4799C0A698 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 18);

        if(isDefined(_id_2B69EA4799C0A698) && _id_2B69EA4799C0A698 != "") {
          level.br_pickups._id_14BD11727C4B6629[_id_14004B68DDACB781] = _id_2B69EA4799C0A698;
          level.br_pickups._id_838863C4848D4C26[_id_2B69EA4799C0A698] = _id_14004B68DDACB781;
        }

        if(isDefined(_id_BB255CC38C4AA89D) && _id_BB255CC38C4AA89D.size > 0) {
          lootid = int(_id_BB255CC38C4AA89D);
          _id_4BB9768282D4260D = _func_1CC3FD00B6CCC3BA(lootid);
          _id_025152A36C536D7F = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
          _id_655BE453564EA032 = _id_2669878CF5A1B6BC::getweaponvarianttablename(_id_4BB9768282D4260D);

          if(getDvar("dvar_9CC91F7C70752FA7", "1") == "1") {
            _id_4BB9768282D4260D = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 8);
            variantid = 0;
          } else
            variantid = int(tablelookup(_id_655BE453564EA032, 1, _id_025152A36C536D7F, 0));

          _id_FC5B5CABB888A488 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 9);
          _id_7CE98C8199BE3D76 = [];
          _id_91BBF8D2294A656E = [];

          if(isDefined(_id_FC5B5CABB888A488) && _id_FC5B5CABB888A488.size)
            _id_7CE98C8199BE3D76 = strtok(_id_FC5B5CABB888A488, _id_55DFF3C24D1396C9);

          if(isDefined(_id_7CE98C8199BE3D76)) {
            foreach(attach in _id_7CE98C8199BE3D76) {
              array = strtok(attach, "|");

              if(array.size > 1) {
                _id_91BBF8D2294A656E[array[0]] = int(array[1]);
                continue;
              }

              _id_91BBF8D2294A656E[array[0]] = 0;
            }
          }

          _id_92FCE7B1696254E3 = _id_4BB9768282D4260D;
          camo = undefined;

          if(getdvarint("scr_br_alt_mode_gg", 0))
            camo = "camo_11a";

          fullweaponobj = undefined;

          if(!isDefined(_id_91BBF8D2294A656E))
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_4BB9768282D4260D, camo, undefined, variantid);
          else
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon_attachmentidmap(_id_4BB9768282D4260D, _id_91BBF8D2294A656E, camo, undefined, variantid);

          fullweaponname = getcompleteweaponname(fullweaponobj);

          if(getdvarint("dvar_9CC91F7C70752FA7", 1)) {}
        } else {
          _id_92FCE7B1696254E3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 8);

          if(scripts\cp\cp_weapon::_id_2B7981CBC7CA24B4(_id_92FCE7B1696254E3)) {
            continue;
          }
          _id_FC5B5CABB888A488 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 9);
          _id_7CE98C8199BE3D76 = [];

          if(isDefined(_id_FC5B5CABB888A488) && _id_FC5B5CABB888A488.size)
            _id_7CE98C8199BE3D76 = strtok(_id_FC5B5CABB888A488, _id_55DFF3C24D1396C9);

          if(getdvarint("scr_br_alt_mode_gg", 0))
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon(_id_92FCE7B1696254E3, _id_7CE98C8199BE3D76, "camo_11a", "none", -1);
          else
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon(_id_92FCE7B1696254E3, _id_7CE98C8199BE3D76, "none", "none", -1);

          fullweaponname = getcompleteweaponname(fullweaponobj);
          _id_D7305E20A538A9A1 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_92FCE7B1696254E3);

          if(isDefined(_id_D7305E20A538A9A1))
            _id_BB255CC38C4AA89D = "" + _id_D7305E20A538A9A1;
        }

        level.br_pickups.br_itemtype[_id_14004B68DDACB781] = itemtype;
        level.br_pickups.br_pickupsfx[_id_14004B68DDACB781] = _id_8D1FE71563B03100;
        level.br_pickups.br_itemrarity[_id_14004B68DDACB781] = int(_id_AE10C1B57593E13F);
        level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = _id_14004B68DDACB781;
        level.br_lootiteminfo[_id_14004B68DDACB781] = spawnStruct();
        level.br_lootiteminfo[_id_14004B68DDACB781].baseweapon = _id_92FCE7B1696254E3;
        level.br_lootiteminfo[_id_14004B68DDACB781].fullweaponname = fullweaponname;
        level.br_lootiteminfo[_id_14004B68DDACB781].fullweaponobj = fullweaponobj;

        if(int(_id_AE10C1B57593E13F) != 10) {
          level.br_pickups.br_weapontoscriptable[fullweaponname] = _id_14004B68DDACB781;
          level.br_pickups._id_7B2BFF2D04EE1017[_id_14004B68DDACB781] = int(_id_BB255CC38C4AA89D);
          level.br_pickups._id_B13DC7E63676BBE7[int(_id_BB255CC38C4AA89D)] = _id_14004B68DDACB781;
        }
      } else {
        equipname = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 8);

        if(isDefined(equipname) && equipname.size > 0) {
          equipname = tolower(equipname);
          level.br_pickups.br_equipname[_id_14004B68DDACB781] = equipname;
          level.br_pickups.br_equipnametoscriptable[equipname] = _id_14004B68DDACB781;
        }

        _id_54E2CC4157B862BD = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 15);

        if(_id_54E2CC4157B862BD != "") {
          switch (_id_54E2CC4157B862BD) {
            case "1":
              if(isDefined(equipname) && equipname.size > 0)
                level.equipment.table[equipname].defaultslot = "primary";

              level.br_throwables[level.br_throwables.size] = _id_14004B68DDACB781;
              break;
            case "2":
              if(isDefined(equipname) && equipname.size > 0)
                level.equipment.table[equipname].defaultslot = "secondary";

              level.br_usables[level.br_usables.size] = _id_14004B68DDACB781;
              break;
            case "3":
              if(isDefined(equipname) && equipname.size > 0)
                level.equipment.table[equipname].defaultslot = "health";

              break;
            case "4":
              if(isDefined(equipname) && equipname.size > 0)
                level.equipment.table[equipname].defaultslot = "super";

              break;
            default:
              break;
          }
        }

        _id_2B69EA4799C0A698 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 18);

        if(isDefined(_id_2B69EA4799C0A698) && _id_2B69EA4799C0A698 != "") {
          level.br_pickups._id_14BD11727C4B6629[_id_14004B68DDACB781] = _id_2B69EA4799C0A698;
          level.br_pickups._id_838863C4848D4C26[_id_2B69EA4799C0A698] = _id_14004B68DDACB781;
        }

        _id_51426AE160732E49 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 4));
        _id_10A92702735EFF08 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 27));

        if(itemtype == "ammo") {
          if(!isDefined(level.br_ammo_max))
            br_ammo_init();

          level.br_ammo_max[_id_14004B68DDACB781] = _id_2AD07B9C3ADC39E3;
        }

        level.br_pickups.stackable[_id_14004B68DDACB781] = _id_2AD07B9C3ADC39E3 > 1;
        level.br_pickups.counts[_id_14004B68DDACB781] = _id_51426AE160732E49;
        level.br_pickups._id_04138F9DDC1CD22D[_id_14004B68DDACB781] = _id_10A92702735EFF08;
        itemtype = tolower(itemtype);
        level.br_pickups.br_itemtype[_id_14004B68DDACB781] = itemtype;
        level.br_pickups.br_pickupsfx[_id_14004B68DDACB781] = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 14);
        _id_A69FFF5222862F26 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 3);
        level.br_pickups.br_itemrarity[_id_14004B68DDACB781] = int(_id_A69FFF5222862F26);

        if(isDefined(_id_BB255CC38C4AA89D) && _id_BB255CC38C4AA89D != "") {
          level.br_pickups._id_7B2BFF2D04EE1017[_id_14004B68DDACB781] = int(_id_BB255CC38C4AA89D);
          level.br_pickups._id_B13DC7E63676BBE7[int(_id_BB255CC38C4AA89D)] = _id_14004B68DDACB781;
        }
      }

      continue;
    }

    if(key == "crate") {
      _id_14004B68DDACB781 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 1);
      _id_6D4E1B034A6B8370 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2));

      if(_id_6D4E1B034A6B8370 > 0) {
        if(isDefined(level.br_lootiteminfo[_id_14004B68DDACB781]) && isDefined(level.br_lootiteminfo[_id_14004B68DDACB781].baseweapon)) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D4E1B034A6B8370; _id_AC0E594AC96AA3A8++) {
            level.br_pickups.br_crateguns[level.br_pickups.br_crateguns.size] = _id_14004B68DDACB781;
            level.br_pickups.br_allguns[level.br_pickups.br_allguns.size] = _id_14004B68DDACB781;
          }
        } else {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D4E1B034A6B8370; _id_AC0E594AC96AA3A8++)
            level.br_pickups.br_crateitems[level.br_pickups.br_crateitems.size] = _id_14004B68DDACB781;
        }
      }

      continue;
    }

    if(key == "gulag") {
      _id_14004B68DDACB781 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 1);
      _id_7D9A5D01CE25E7A3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2);

      if(!isDefined(level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3]))
        level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3] = [];

      count = level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3].size;
      level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3][count] = _id_14004B68DDACB781;
      continue;
    }

    if(key == "depends" && !isDefined(level.br_pickups._id_11FEB85E78E7CEE8))
      level.br_pickups._id_11FEB85E78E7CEE8 = _id_CB89110314447B2F;
  }

  setdvarifuninitialized("dvar_61E10DE0F675E9AD", 0);
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
  level.br_pickups._id_B4A939303C824805 = "MP_BR_INGAME/CIRCLE_PEEK_LIMIT";
  level.br_pickups._id_5FDCD05C466E7520 = "MP/BR_PICKUP_ITEM_MAX_LIMIT";
  level.br_pickups._id_A1A6A7680C4FF1EB = "MP/BR_ALREADY_EQUIPPED_ITEM";
  level.br_pickups._id_0FDE0E27B3A09BF3 = "MP/CANNOT_EQUIP_NOW";
  level.br_pickups._id_58FE23C2A80F28ED = "MP_BR_INGAME/MISSION_WHITELISTED";
  level.br_pickups._id_D8A2816E3697C70C = "MP_DMZ_MISSIONS/GEIGER_SEARCH_CONTRACT_CANCELLED_ERR";
  level.br_pickups.br_pickupdenyweaponpickupap = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
  level.br_pickups._id_7141C6C2372C0A82 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups._id_8BFFCA3828FD297E = "MP/BR_EQUIP_DENY_PLATE_CARRIER_LESS";
  level.br_pickups._id_EC7422F11A61C100 = "MP/BR_EQUIP_DENY_BACKPACK_LESS";
  level.br_pickups._id_7BD397B2E9D8A434 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups.respawntokenenabled = getdvarint("scr_br_respawn_token", 1);
  level.br_pickups.respawntokenclosewithgulag = getdvarint("scr_br_respawn_token_gulag", 0);
  level.br_pickups._id_AD49A38DD7C4C10F = undefined;
  level.br_pickups._id_3B53BC0EEE6AE84E = undefined;

  if(getdvarint("bg_weaponautograboptionsenabled", 0))
    _id_F8B204E807CC62ED();

  if(_id_B1DD9DCAE2F63965())
    _id_B9DA718E50063452();

  scripts\engine\scriptable::scriptable_addusedcallback(::lootused);
  scripts\engine\scriptable::scriptable_addautousecallback(::lootused);
}

_id_EC51234E00E53E8A(item_type, _id_D49285246B443066) {
  _id_ABA40A4E9A19401E = "agentdrops_+" + _id_D49285246B443066;
  _id_4AFF050E56974DD6 = item_type + "/" + _id_D49285246B443066;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Loot Drops / " + _id_4AFF050E56974DD6 + "\" \"set scr_start_debug " + _id_ABA40A4E9A19401E + "\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_F8B204E807CC62ED() {
  level._id_81369E82645391F0 = [];
  _id_3C7F6558E5171CFC = getDvar("dvar_DD0E2DF8833B28D8", "mp/automatism/weapon_class_groups_for_auto_grab.csv");
  _id_3CFAAE92E4BB0D04 = tablelookupgetnumrows(_id_3C7F6558E5171CFC);

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_3CFAAE92E4BB0D04; _id_CB89110314447B2F++) {
    weaponclass = tablelookupbyrow(_id_3C7F6558E5171CFC, _id_CB89110314447B2F, 0);
    groupindex = int(tablelookupbyrow(_id_3C7F6558E5171CFC, _id_CB89110314447B2F, 1));
    level._id_81369E82645391F0[weaponclass] = groupindex;
  }
}

getitemdropinfo(origin, angles, payload, groundentity) {
  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4.origin = origin;

  if(isDefined(angles))
    _id_CB4FAD49263E20C4.angles = angles;
  else
    _id_CB4FAD49263E20C4.angles = (0, 0, 0);

  if(isDefined(payload))
    _id_CB4FAD49263E20C4.payload = payload;
  else
    _id_CB4FAD49263E20C4.payload = 0;

  _id_CB4FAD49263E20C4.groundentity = groundentity;
  return _id_CB4FAD49263E20C4;
}

takeweaponsdefaultfunc(_id_E30FEDE51649CE21) {
  if(!isDefined(_id_E30FEDE51649CE21))
    _id_E30FEDE51649CE21 = "iw9_me_fists_mp";

  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  gunless = makeweapon(_id_E30FEDE51649CE21);
  _id_F9F3100428A6E476 = makeweapon("none");
  self.weaponlist = self.primaryweapons;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.weaponlist.size; _id_AC0E594AC96AA3A8++) {
    weapon = self.weaponlist[_id_AC0E594AC96AA3A8];

    if(isDefined(weapon) && !issameweapon(gunless, weapon) && !issameweapon(_id_F9F3100428A6E476, weapon))
      self takeweapon(weapon);
  }

  self clearaccessory();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  self.gunnlessweapon = gunless;
  waitframe();
}

getitemdroporiginandangles(index, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44) {
  _id_C5EED6E92F7C606D = 1;
  _id_2F0B0FA0C619FE99 = 1;
  _id_551904951118B7B9 = getdvarint("dvar_D7613094EA4BA91F", 0);
  _id_A9D5AD9414F5ECB7 = 14;
  _id_057716496F9F490F = 100.0;
  _id_E0CC897878C28778 = 40.0;
  _id_B0BB91AD89D1AAED = -5.0;
  _id_B0987BAD89AB32D3 = 5.0;
  _id_AC72A33C0ED48603 = 10.0;
  _id_3385F93167B49AA1 = 360.0 / _id_A9D5AD9414F5ECB7;
  _id_AB9F50E5B2C2E07E = -5.0;
  _id_AB7C62E5B29CC05C = 5.0;
  _id_BF66B5FB30ACFDC9 = 40.0;
  _id_AEA7C2414B868248 = 20.0;
  _id_CA4135583A9A540D = 60.0;
  _id_D6A5232D04D3A753 = -6.0;
  _id_240F67006FE07965 = 0;
  _id_CD6D42939F0321E6 = -18.0;
  _id_C551AB221BAC9779 = 0;
  payload = 0;
  groundentity = undefined;
  _id_C79BB482424EB3A0 = _id_240F67006FE07965;

  if(isDefined(_id_6FE2FF802D5192D4))
    _id_C79BB482424EB3A0 = _id_6FE2FF802D5192D4;

  ring = int(index / _id_A9D5AD9414F5ECB7);
  slot = index - ring * _id_A9D5AD9414F5ECB7;
  yaw = baseangles[1] + (slot * _id_3385F93167B49AA1 + ring * _id_AC72A33C0ED48603) + randomfloatrange(_id_AB9F50E5B2C2E07E, _id_AB7C62E5B29CC05C);
  dist = _id_057716496F9F490F + ring * _id_E0CC897878C28778 + randomfloatrange(_id_B0BB91AD89D1AAED, _id_B0987BAD89AB32D3);

  if(isDefined(_id_8A600B6102DA9F9B))
    yaw = baseangles[1] + _id_8A600B6102DA9F9B;

  if(isDefined(_id_F71D4F78D508DA69))
    dist = _id_F71D4F78D508DA69;

  angles = (0.0, yaw, 0.0);
  dir = anglesToForward(angles);
  origin = baseorigin + dir * dist;

  if(_id_2F0B0FA0C619FE99) {
    ignoreents = vehicle_getarrayinradius(origin, 500, 500);

    if(isDefined(_id_447F40C814B97CDC))
      ignoreents[ignoreents.size] = _id_447F40C814B97CDC;

    tracestart = baseorigin + (0.0, 0.0, _id_AEA7C2414B868248);
    _id_8B39E5984DA1FFAF = origin + (0.0, 0.0, _id_AEA7C2414B868248);
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1);
    traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);

    if(traceresults["fraction"] < 1.0) {
      origin = traceresults["position"];
      origin = origin + dir * _id_CD6D42939F0321E6;
    } else
      origin = _id_8B39E5984DA1FFAF;

    tracestart = origin;
    _id_8B39E5984DA1FFAF = origin + (0.0, 0.0, _id_CA4135583A9A540D);
    traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);

    if(traceresults["fraction"] < 1.0)
      origin = traceresults["position"] + (0.0, 0.0, _id_D6A5232D04D3A753);
    else
      origin = _id_8B39E5984DA1FFAF;

    tracestart = origin;
    _id_3A7F0173B03F5767 = -1 * getdvarfloat("dvar_0B91D6BC7E0694AC", 2000.0);
    _id_8B39E5984DA1FFAF = origin + (0.0, 0.0, _id_3A7F0173B03F5767);
    traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);

    if(traceresults["fraction"] < 1.0) {
      origin = traceresults["position"] + (0.0, 0.0, _id_C79BB482424EB3A0);
      groundentity = traceresults["entity"];
    } else {
      origin = (0, 0, 0);
      _id_C551AB221BAC9779 = 1;
    }
  } else
    origin = origin + (0, 0, _id_C79BB482424EB3A0);

  if(_id_C5EED6E92F7C606D && !_id_C551AB221BAC9779) {
    startorigin = baseorigin;

    if(!istrue(_id_3ACE5AC9C7D6FA44))
      startorigin = startorigin + (0, 0, _id_BF66B5FB30ACFDC9);

    payload = calcscriptablepayloadgravityarc(startorigin, origin);
  }

  return getitemdropinfo(origin, angles, payload, groundentity);
}

_id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C) {
  if(istrue(_id_7F437A5779C8787C)) {
    level.br_pickups._id_AD49A38DD7C4C10F = getkioskyawoffsetoverride();
    level.br_pickups._id_3B53BC0EEE6AE84E = _id_1A8066CCDB91C1D1();
  } else {
    level.br_pickups._id_AD49A38DD7C4C10F = undefined;
    level.br_pickups._id_3B53BC0EEE6AE84E = undefined;
  }
}

getfullweaponobjforscriptablepartname(scriptablename) {
  if(isDefined(scriptablename) && isDefined(level.br_lootiteminfo[scriptablename]) && isDefined(level.br_lootiteminfo[scriptablename].fullweaponobj))
    return level.br_lootiteminfo[scriptablename].fullweaponobj;

  return undefined;
}

getfullweaponobjforpickup(pickupent) {
  if(isDefined(pickupent) && isDefined(pickupent.scriptablename))
    return getfullweaponobjforscriptablepartname(pickupent.scriptablename);

  return undefined;
}

getgulagpickupsforclass(_id_7D9A5D01CE25E7A3) {
  _id_14004B68DDACB781 = ["none"];

  if(isDefined(_id_7D9A5D01CE25E7A3) && isDefined(level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3]))
    _id_14004B68DDACB781 = level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3];

  return _id_14004B68DDACB781;
}

loot_getitemcount(instance) {
  return instance.count >> 0 & 2047;
}

loot_getitemcountlefthand(instance) {
  return instance.count >> 11 & 2047;
}

_id_3A5F7703319142DD(instance) {
  return instance.count >> 22 & 255;
}

loot_setitemcount(instance, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10) {
  count = 0;
  count = count + ((_id_9BE70D6D4FF253A1 & 2047) << 0);

  if(isDefined(_id_59BD51AFC73DF2CD))
    count = count + ((_id_59BD51AFC73DF2CD & 2047) << 11);

  if(isDefined(_id_DAB81EAD77442A10))
    count = count + ((_id_DAB81EAD77442A10 & 255) << 22);

  instance.count = count;
}

_id_B6B71C738C7F7CA4(instance) {
  if(instance.type == "br_plunder_box" || instance.type == "dmz_uav_tower")
    return 1;

  return 0;
}

_id_155B1A2C8879BDA5(instance) {
  _id_A1093166DE09E6B8 = instance _meth_15C8C4841BFC1FD5();

  if(isDefined(_id_A1093166DE09E6B8))
    return _id_A1093166DE09E6B8;

  return instance.type;
}

lootused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || _id_531CB1BE084314F7::_id_362D5A8D49B93721(instance.type)) {
    return;
  }
  pickup = spawnStruct();
  pickup.scriptablename = _id_155B1A2C8879BDA5(instance);
  pickup.origin = instance.origin;
  pickup.count = loot_getitemcount(instance);
  pickup.countlefthand = loot_getitemcountlefthand(instance);
  pickup._id_E97D731BEDD44C63 = _id_3A5F7703319142DD(instance);
  pickup.instance = instance;
  pickup.customweaponname = instance.customweaponname;
  pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];

  if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename]))
    pickup.count = level.br_pickups.counts[pickup.scriptablename];

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = _id_A5B2C541413AA895;
  return _id_B5F5576A0017C089(pickup, state, player, _id_A5B2C541413AA895, instance);
}

_id_B5F5576A0017C089(pickup, state, player, _id_A5B2C541413AA895, instance) {
  if(!isDefined(pickup))
    return 0;

  if(istrue(level.infilcinematicactive))
    return 0;

  if(istrue(level._id_ABA762658155F642) && istrue(_id_A5B2C541413AA895))
    return 0;

  if(getdvarint("dvar_15055CB805B43A20", 1) && istrue(_id_A5B2C541413AA895) && !player _id_E44C2D69DB881894(pickup.scriptablename))
    return 0;

  if(player _meth_C6CB3E654225077A() && !player _meth_7B738B973A0B7F94() && istrue(_id_A5B2C541413AA895) && player _id_E44C2D69DB881894(pickup.scriptablename))
    return 0;

  if(_id_B1DD9DCAE2F63965() && istrue(_id_A5B2C541413AA895) && player _id_AC3EC31BE7AAD7A7(instance))
    return 0;

  if(player isreloading())
    return 0;

  if(!isDefined(instance) || instance getscriptableisloot() && !_id_B6B71C738C7F7CA4(instance)) {
    if(isDefined(instance) && istrue(instance._id_4C89AE940CA43B23))
      return 0;

    results = player cantakepickup(pickup);

    if(results == 1) {
      if(isDefined(instance))
        instance._id_4C89AE940CA43B23 = 1;

      return _id_531CB1BE084314F7::_id_60234AA487445085(pickup, player, _id_A5B2C541413AA895, instance);
    } else if(results == 20)
      return _id_531CB1BE084314F7::_id_08F0BD51F5C6108B(pickup, player, _id_A5B2C541413AA895, instance);
    else if(results == 5 || results == 27) {
      _id_DD515FCF025B2E79 = _id_531CB1BE084314F7::_id_55C5D35C8C76A95B(pickup)[0];
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
      _id_60227BFF1E9478CC.origin = pickup.origin;
      _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

      if(results == 5)
        _id_531CB1BE084314F7::_id_60234AA487445085(_id_60227BFF1E9478CC, player);
      else
        _id_531CB1BE084314F7::_id_08F0BD51F5C6108B(_id_60227BFF1E9478CC, player);

      if(isDefined(instance))
        loothide(instance);
    } else {
      _id_8DDE4AC0085463FC = 1;
      _id_0BB9E46E1D8130F2 = level.br_pickups.br_hasautopickup[pickup.scriptablename];

      if(isDefined(_id_A5B2C541413AA895) && isDefined(_id_0BB9E46E1D8130F2)) {
        if(_id_A5B2C541413AA895 && istrue(_id_0BB9E46E1D8130F2) && state == "visible")
          _id_8DDE4AC0085463FC = 0;
      }

      if(results == 17)
        _id_8DDE4AC0085463FC = 0;

      if(_id_531CB1BE084314F7::_id_A45EE992E46A29F1(pickup.scriptablename))
        _id_8DDE4AC0085463FC = 0;

      if(_id_8DDE4AC0085463FC) {
        if(results == 3)
          player playlocalsound("weap_ammo_full");
        else
          player playlocalsound("br_pickup_deny");

        player showuseresultsfeedback(results);
      }
    }
  }

  return 0;
}

_id_86321FC8F45C2A9B(_id_E3108E412AFB3811) {
  if(!isDefined(_id_E3108E412AFB3811))
    _id_E3108E412AFB3811 = 1;

  self._id_FF45E00F9ED1E5C9 = _id_E3108E412AFB3811;
}

_id_B10EE40ED82D45C9(_id_E3108E412AFB3811) {
  if(!isDefined(_id_E3108E412AFB3811))
    _id_E3108E412AFB3811 = 1;

  self.isweaponfromcrate = _id_E3108E412AFB3811;
}

_id_2A6A614936C17AC0(value) {
  if(isDefined(value))
    self._id_0FFB4606CE142F6A = int(value);
}

_id_D3507041E41E9DD0(value) {
  if(isDefined(value))
    self._id_F5E8DC8531286C60 = int(value);
}

_id_E44C2D69DB881894(_id_A1093166DE09E6B8) {
  if(_id_531CB1BE084314F7::isammo(_id_A1093166DE09E6B8)) {
    if(!self _meth_C6CB3E654225077A()) {
      _id_509D86412C9D7426 = self getweaponslistprimaries();

      foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
        _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

        if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_A1093166DE09E6B8 == _id_7CAC4FF8E11F1BCA && self.br_ammo[_id_A1093166DE09E6B8] < level._id_E6EA72FC5E3FCD00[_id_A1093166DE09E6B8])
          return 1;
      }

      return 0;
    } else
      return 1;
  }

  if(_id_531CB1BE084314F7::isplunder(_id_A1093166DE09E6B8))
    return 1;

  if(_id_531CB1BE084314F7::isarmorplate(_id_A1093166DE09E6B8)) {
    equipname = level.br_pickups.br_equipname[_id_A1093166DE09E6B8];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(self.equipment[slot]))
      return 1;

    if(_id_531CB1BE084314F7::equipmentslothasroom(_id_A1093166DE09E6B8, slot))
      return 1;

    return 0;
  }

  if(_id_531CB1BE084314F7::isweaponpickup(_id_A1093166DE09E6B8) && self _meth_B096B58FB3808D26())
    return 1;

  if(self _meth_C6CB3E654225077A()) {
    _id_0BB9E46E1D8130F2 = 0;

    if(_id_531CB1BE084314F7::_id_B989EDD9AF4F42C7(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_6B75060E643E52E9() == 1;
    else if(_id_531CB1BE084314F7::_id_D7C5786A0C42EF6C(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_C0A39ABE7EC43AD8() == 1;
    else if(_id_531CB1BE084314F7::iskillstreak(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_3AA858D217FB4A1A() == 1;
    else if(_id_531CB1BE084314F7::issuperpickup(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_FA1DA77265660058() == 1;
    else if(_id_531CB1BE084314F7::isrevivepickup(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_3FEB119F85F6CD82() == 1;
    else if(_id_531CB1BE084314F7::isgasmask(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_50B964D023C440E8() == 1;
    else if(_id_531CB1BE084314F7::_id_4294E9B331377C31(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_853086956EE45C36() == 1;

    return _id_0BB9E46E1D8130F2;
  }

  return 0;
}

showuseresultsfeedback(results) {
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
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups._id_FA26185493A84CC6);
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
    case 2:
      break;
  }
}

loothide(instance, part) {
  if(!isDefined(part))
    part = instance.type;

  if(_id_531CB1BE084314F7::isquesttablet(instance.type)) {
    if(scripts\cp\utility::gameflag("prematch_done"))
      level notify("tablethide_kill_callout_" + instance.origin);

    if(getdvarint("dvar_82BDE055B11E6698", 0)) {} else {}
  }

  instance _meth_F35957C991FCFD3F();

  if(instance getscriptableisreserved() && !istrue(instance.keepinmap)) {
    deregisterscriptableinstance(instance);
    instance freescriptable();
  } else
    instance setscriptablepartstate(part, "hidden");
}

clearspaceforscriptableinstance() {
  _id_962A30A9BB8C0F09 = level.br_pickups;

  if(_id_962A30A9BB8C0F09.scriptables.size < _id_962A30A9BB8C0F09.scriptablesmax) {
    return;
  }
  _id_406118F36AB85942 = 0;

  for(_id_AC0E594AC96AA3A8 = _id_962A30A9BB8C0F09.scriptablesstartid; _id_AC0E594AC96AA3A8 < _id_962A30A9BB8C0F09.scriptablescurid; _id_AC0E594AC96AA3A8++) {
    if(_id_406118F36AB85942 == _id_962A30A9BB8C0F09.scriptablescleanupbatchsize) {
      break;
    }

    instance = _id_962A30A9BB8C0F09.scriptables[_id_AC0E594AC96AA3A8];

    if(isDefined(instance)) {
      if(istrue(instance._id_BBC200BC77C5DB2B)) {
        continue;
      }
      _id_962A30A9BB8C0F09.scriptables[_id_AC0E594AC96AA3A8] = undefined;

      if(isent(instance))
        instance delete();
      else
        instance freescriptable();

      _id_406118F36AB85942++;
    } else
      _id_962A30A9BB8C0F09.scriptables[_id_AC0E594AC96AA3A8] = undefined;

    _id_962A30A9BB8C0F09.scriptablesstartid++;
  }
}

registerscriptableinstance(instance) {
  id = level.br_pickups.scriptablescurid;
  instance.brpickupscriptableid = id;
  level.br_pickups.scriptables[id] = instance;
  level.br_pickups.scriptablescurid++;
}

deregisterscriptableinstance(instance) {
  level.br_pickups.scriptables[instance.brpickupscriptableid] = undefined;
  instance.brpickupscriptableid = undefined;
}

onusecompleted(pickupent, _id_43FB3D97ABB79854, _id_A5B2C541413AA895, _id_7F437A5779C8787C, _id_DB943473454F6EA6, instance, _id_44EE85DCF52B4001) {
  level endon("game_ended");
  self endon("disconnect");
  _id_10BBEACB1429824E = 0;

  if(!isDefined(pickupent.count))
    pickupent.count = 0;

  if(!istrue(_id_43FB3D97ABB79854))
    _id_EFDDDF60C5DB058C(pickupent, _id_A5B2C541413AA895);

  level notify("pickedupweapon_kill_callout_" + pickupent.scriptablename + pickupent.origin);

  if(_id_531CB1BE084314F7::isplunder(pickupent.scriptablename))
    self notify("self_pickedupitem_plunder");
  else if(isweaponpickupitem(pickupent))
    self notify("self_pickedupitem_weapon", pickupent.scriptablename);
  else
    self notify("self_pickedupitem_" + pickupent.scriptablename);

  if(isweaponpickupitem(pickupent)) {
    if(istrue(instance._id_FF45E00F9ED1E5C9))
      _id_10BBEACB1429824E = 1;

    takeweaponpickup(pickupent, _id_DB943473454F6EA6);
    scripts\cp_mp\challenges::onpickupitem("weapon");
  } else if(_id_531CB1BE084314F7::isammo(pickupent.scriptablename)) {
    _id_10BBEACB1429824E = takeammopickup(pickupent);
    _id_5BAAA0CE73D6FE84(self);
  } else if(_id_531CB1BE084314F7::isarmorplate(pickupent.scriptablename)) {
    _id_10BBEACB1429824E = takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
    _id_A81ADEB0E1F89320 = _id_07C40FA80892A721::_id_047320A25B8EE003();
    _id_364D691B501CD27F = _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_2F7B6D2030D5B87A = int(min(pickupent.count, _id_A81ADEB0E1F89320));

    if(_id_364D691B501CD27F < _id_A81ADEB0E1F89320)
      _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_2F7B6D2030D5B87A);
  } else if(_id_531CB1BE084314F7::_id_4AA12E0ED3F6B745(pickupent.scriptablename)) {
    _id_0E9CFD120B0B43EF = _id_531CB1BE084314F7::_id_692C3DF266580DF6(pickupent.scriptablename);
    self._id_BED158A6DFAC230D = _id_0E9CFD120B0B43EF;
    self._id_8790C077C95DB752 = self._id_BED158A6DFAC230D * 50;
    _id_07C40FA80892A721::_id_AC7803D45979135C(self._id_8790C077C95DB752);
  } else if(_id_531CB1BE084314F7::isequipment(pickupent.scriptablename))
    _id_10BBEACB1429824E = takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
  else if(_id_531CB1BE084314F7::isarmor(pickupent.scriptablename))
    takearmorpickup(pickupent);
  else if(pickupent.scriptablename == "Pillage_Cache" && isDefined(level.givetagsfromcache))
    self[[level.givetagsfromcache]]();
  else if(_id_531CB1BE084314F7::isplunder(pickupent.scriptablename)) {
    takeplunderpickup(pickupent);
    scripts\cp_mp\challenges::onpickupitem("plunder");
  } else if(_id_531CB1BE084314F7::istokenpickup(pickupent.scriptablename))
    _id_531CB1BE084314F7::takerespawntokenpickup(pickupent);
  else if(_id_531CB1BE084314F7::isrevivepickup(pickupent.scriptablename))
    takerevivepickup(pickupent);
  else if(_id_531CB1BE084314F7::iskillstreak(pickupent.scriptablename)) {
    _id_A4E8372932B8612C = level.br_pickups._id_14BD11727C4B6629[pickupent.scriptablename];
    thread _id_5E5507D57BBBB709::_id_4A1FD54AFFDAA367(_id_A4E8372932B8612C, 1, 0, 0, 1);
  } else if(_id_531CB1BE084314F7::issuperpickup(pickupent.scriptablename))
    takesuperpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6);
  else if(_id_531CB1BE084314F7::_id_4294E9B331377C31(pickupent.scriptablename)) {
    if(!_id_531CB1BE084314F7::hasplatepouch()) {
      _id_531CB1BE084314F7::addplatepouch();

      if(!isDefined(pickupent.instance) || !istrue(pickupent.instance._id_0D71F714A6B742E2))
        _id_531CB1BE084314F7::fillmaxarmorplate();
    }
  } else if(pickupent.scriptablename == "brloot_ammo_grenade")
    _id_531CB1BE084314F7::takegenericgrenadepickup(pickupent);
  else {
    amount = 1;

    if(isDefined(pickupent.count))
      amount = pickupent.count;

    trypickupitem(pickupent.scriptablename, amount);
  }

  amount = 1;

  if(isDefined(pickupent.count))
    amount = pickupent.count;

  if(isDefined(pickupent.instance) && isDefined(pickupent.instance.uniquelootitemid))
    processuniquelootitem(pickupent.instance.uniquelootitemid, self);

  if(isDefined(pickupent.instance) && isDefined(pickupent.instance.type) && pickupent.instance.type == "brloot_weapon_me_buzzsaw")
    pickupent.instance notify("trigger", self);

  return _id_10BBEACB1429824E;
}

takesuperpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  _id_5237A188CCDA4D7B = level.br_pickups._id_14BD11727C4B6629[pickupent.scriptablename];

  if(isDefined(self.equipment["super"]) && _id_7EF95BBA57DC4B82::getequipmentslotammo("super") > 0)
    dropequipmentinslot("super", _id_7F437A5779C8787C);

  if(istrue(level.allowsupers))
    return;
}

forcegivesuper(_id_9394537680F9C8A4, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  if(istrue(level._id_D040719163E20394) && _id_9394537680F9C8A4 == "none") {
    return;
  }
  _id_733D60A5F3A8C170 = undefined;

  foreach(scriptablename, _id_5237A188CCDA4D7B in level.br_pickups._id_14BD11727C4B6629) {
    if(_id_5237A188CCDA4D7B == _id_9394537680F9C8A4) {
      _id_733D60A5F3A8C170 = scriptablename;
      break;
    }
  }

  _id_878C13A767E1D193 = undefined;

  if(!scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    _id_878C13A767E1D193 = level.br_pickups.br_equipname[_id_733D60A5F3A8C170];

  if(istrue(_id_1E736A37C3737585)) {
    dropbrequipment(_id_7F437A5779C8787C, _id_1E736A37C3737585, _id_878C13A767E1D193);
    return;
  }

  if(istrue(_id_A5AB866673E5E99D)) {
    if(isDefined(self.equipment["super"]) && _id_7EF95BBA57DC4B82::getequipmentslotammo("super") > 0)
      dropequipmentinslot("super", _id_7F437A5779C8787C, undefined, undefined, _id_DB943473454F6EA6);
  }
}

_id_35A73D6384BABB13(_id_A3C267C12168AE42) {
  if(scripts\engine\utility::string_starts_with(_id_A3C267C12168AE42, "br_"))
    return getsubstr(_id_A3C267C12168AE42, 3, _id_A3C267C12168AE42.size);

  return _id_A3C267C12168AE42;
}

takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  _id_10BBEACB1429824E = 0;

  if(_id_531CB1BE084314F7::pickupissameasequipmentslot(equipname, slot)) {
    if(_id_531CB1BE084314F7::equipmentslothasroom(pickupent.scriptablename, slot)) {
      if(slot != "health" && !self _meth_C6CB3E654225077A()) {
        _id_DC382B1157307F94 = _id_531CB1BE084314F7::_id_F77406A45E988898(equipname);
        _id_5762AC2F22202BA2::hudicontype(_id_DC382B1157307F94);
      }

      _id_5324597EDFAFF57C = _id_7EF95BBA57DC4B82::getequipmentslotammo(slot);
      _id_B5CDF4D935E6AC13 = _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipname);

      if(_id_5324597EDFAFF57C + pickupent.count > _id_B5CDF4D935E6AC13) {
        _id_97C23A1323ACC7DF = _id_B5CDF4D935E6AC13 - _id_5324597EDFAFF57C;
        _id_7EF95BBA57DC4B82::setequipmentammo(equipname, _id_B5CDF4D935E6AC13);
        pickupent.count = pickupent.count - _id_97C23A1323ACC7DF;
        _id_10BBEACB1429824E = 1;
      } else
        _id_7EF95BBA57DC4B82::incrementequipmentslotammo(slot, pickupent.count);

      if(isDefined(_id_DB943473454F6EA6)) {
        _id_531CB1BE084314F7::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, -1 * (_id_B5CDF4D935E6AC13 - _id_5324597EDFAFF57C));
        _id_10BBEACB1429824E = 0;
      }

      if(_id_10BBEACB1429824E && _id_8B121DD10A442DD2() && !isDefined(_id_DB943473454F6EA6)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
        _id_10F6E537F1B5763C(lootid, pickupent);
        _id_10BBEACB1429824E = 0;
      }
    } else if(_id_8B121DD10A442DD2() && !istrue(_id_44EE85DCF52B4001)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
      _id_10F6E537F1B5763C(lootid, pickupent);
      _id_10BBEACB1429824E = 0;
    }
  } else if(!isDefined(self.equipment[slot]) || _id_7EF95BBA57DC4B82::getequipmentslotammo(slot) == 0) {
    _id_B5CDF4D935E6AC13 = _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipname);
    _id_7EF95BBA57DC4B82::giveequipment(equipname, slot);

    if(pickupent.count > _id_B5CDF4D935E6AC13) {
      _id_97C23A1323ACC7DF = _id_B5CDF4D935E6AC13;
      _id_7EF95BBA57DC4B82::setequipmentammo(equipname, _id_B5CDF4D935E6AC13);
      pickupent.count = pickupent.count - _id_97C23A1323ACC7DF;
      _id_10BBEACB1429824E = 1;
    } else
      _id_7EF95BBA57DC4B82::setequipmentammo(equipname, pickupent.count);

    if(_id_10BBEACB1429824E && _id_8B121DD10A442DD2()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
      _id_10F6E537F1B5763C(lootid, pickupent);
      _id_10BBEACB1429824E = 0;
    }

    if(isDefined(_id_DB943473454F6EA6))
      _id_A0CCC23064473A05(_id_DB943473454F6EA6, 0, 0);
  } else if(_id_8B121DD10A442DD2() && !isDefined(_id_DB943473454F6EA6)) {
    count = 1;

    if(isDefined(pickupent.count))
      count = pickupent.count;

    trypickupitem(pickupent.scriptablename, count);
  } else {
    if(isDefined(_id_DB943473454F6EA6)) {
      if(pickupent.maxcount == 0)
        pickupent.maxcount = level.br_pickups._id_04138F9DDC1CD22D[pickupent.scriptablename];

      _id_3FA041E4F059BC71 = min(pickupent.maxcount, pickupent.count);
      _id_531CB1BE084314F7::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, -1 * _id_3FA041E4F059BC71);
    }

    if(!istrue(level._id_AD82058550E7696B))
      dropequipmentinslot(slot, _id_7F437A5779C8787C, undefined, undefined, _id_DB943473454F6EA6);

    _id_7EF95BBA57DC4B82::giveequipment(equipname, slot);
    _id_7EF95BBA57DC4B82::setequipmentammo(equipname, pickupent.count);
  }

  return _id_10BBEACB1429824E;
}

dropequipmentinslot(slot, _id_7F437A5779C8787C, _id_273A070109CFC7E0, _id_9BCB02C2619FE05A, _id_DB943473454F6EA6, _id_1AD2DB70C8D01F51, itemtype, _id_4C6EBA41707C461F) {
  ammocount = _id_7EF95BBA57DC4B82::getequipmentslotammo(slot);

  if(isDefined(_id_9BCB02C2619FE05A))
    ammocount = _id_9BCB02C2619FE05A;

  if(!isDefined(_id_1AD2DB70C8D01F51))
    _id_1AD2DB70C8D01F51 = 1;

  _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);

  if(isDefined(_id_FEB782334DD23A66)) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    _id_0AFFC0355B490190 = 0;

    if(isDefined(_id_273A070109CFC7E0))
      _id_0AFFC0355B490190 = _id_273A070109CFC7E0;

    if(isDefined(_id_DB943473454F6EA6)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_531CB1BE084314F7::_id_91C1BE871300A518(lootid);
      _id_60227BFF1E9478CC.count = ammocount;
      quantity = _id_531CB1BE084314F7::_id_15308562FDA076AA(lootid, _id_60227BFF1E9478CC);

      if(quantity > 0) {
        _id_285B7129B392CF3D = 0;

        if(isDefined(itemtype))
          _id_285B7129B392CF3D = _id_531CB1BE084314F7::quickdropaddtoexisting(itemtype, _id_60227BFF1E9478CC.scriptablename, quantity);

        if(_id_285B7129B392CF3D) {
          return;
        }
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_0AFFC0355B490190, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
        item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, quantity, 1, undefined, isalive(self));
        _id_531CB1BE084314F7::quickdropaddtocache(_id_60227BFF1E9478CC.scriptablename, _id_0AFFC0355B490190, item, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
        _id_2F4E0022C686DBE6(item);

        if(istrue(_id_4C6EBA41707C461F)) {
          _id_531CB1BE084314F7::quickdropplaySound(itemtype, _id_CB4FAD49263E20C4.origin, _id_60227BFF1E9478CC.scriptablename, item);
          return;
        }

        return;
      }
    } else {
      _id_285B7129B392CF3D = 0;
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      scriptablename = _id_531CB1BE084314F7::_id_91C1BE871300A518(lootid);

      if(isDefined(itemtype))
        _id_285B7129B392CF3D = _id_531CB1BE084314F7::quickdropaddtoexisting(itemtype, scriptablename, ammocount);

      if(_id_285B7129B392CF3D) {
        return;
      }
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_0AFFC0355B490190, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F);

      if(_id_531CB1BE084314F7::issuperpickup(scriptablename))
        _id_1AD2DB70C8D01F51 = getdvarint("dvar_8C7FD24CB9DC68F0", 0) || _id_1AD2DB70C8D01F51 && isalive(self);

      item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
      _id_531CB1BE084314F7::quickdropaddtocache(scriptablename, _id_0AFFC0355B490190, item, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
      _id_2F4E0022C686DBE6(item);

      if(istrue(_id_4C6EBA41707C461F))
        _id_531CB1BE084314F7::quickdropplaySound(itemtype, _id_CB4FAD49263E20C4.origin, scriptablename, item);
    }
  }
}

giveequipment(ref, slot) {
  if(!isDefined(self.equipment))
    self.equipment = [];

  if(ref == "none") {
    return;
  }
  _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  takeequipment(slot);

  if(isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_8BF83D28BE4C2D4F.objweapon);

    if(is_equipment_slot_allowed(slot) && !_id_8BF83D28BE4C2D4F.ispassive) {
      if(slot == "primary")
        self assignweaponoffhandprimary(_id_8BF83D28BE4C2D4F.objweapon);
      else if(slot == "secondary")
        self assignweaponoffhandsecondary(_id_8BF83D28BE4C2D4F.objweapon);
      else if(slot == "super")
        self assignweaponoffhandspecial(_id_8BF83D28BE4C2D4F.objweapon);
    }
  }

  self.equipment[slot] = ref;
  _id_4E8271CF261E45DD = ref == "equip_throwing_knife" || ref == "equip_throwing_knife_fire";

  if(scripts\cp\utility::getgametype() == "arena" && _id_4E8271CF261E45DD) {
    return;
  }
  return;
}

is_equipment_slot_allowed(slot) {
  switch (slot) {
    case "primary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_primary");
    case "secondary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_secondary");
    default:
      return 1;
  }
}

takeequipment(slot) {
  ref = _id_7EF95BBA57DC4B82::getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }
  _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F)) {
    ref = _id_F16F02E6C6FF945A(ref);
    _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  }

  if(isDefined(_id_8BF83D28BE4C2D4F) && isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    if(self hasweapon(_id_8BF83D28BE4C2D4F.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_8BF83D28BE4C2D4F.objweapon);

      if(slot == "primary")
        self clearoffhandprimary();
      else if(slot == "secondary")
        self clearoffhandsecondary();
    }
  }

  self.equipment[slot] = undefined;
  self notify("equipment_taken_" + ref);
}

getkioskyawoffsetoverride() {
  if(isDefined(level._id_D03E6BA38B56B4AB) && istrue(level._id_D03E6BA38B56B4AB)) {
    _id_924453750F53A090 = level._id_E9F7702D839B262C;

    if(level._id_F454C63919420AA9 > 0)
      _id_924453750F53A090 = _id_924453750F53A090 + randomfloatrange(level._id_F454C63919420AA9 * -1, level._id_F454C63919420AA9);

    return _id_924453750F53A090;
  }

  return 180.0 + randomfloatrange(-10.0, 10.0);
}

_id_66361755731D772A(pickupent, scriptablename) {
  if(_id_531CB1BE084314F7::isplunder(scriptablename))
    return getcashsoundaliasforplayer(self, scriptablename);
  else if(isDefined(level.br_pickups.br_pickupsfx[scriptablename]) && level.br_pickups.br_pickupsfx[scriptablename].size > 0)
    return level.br_pickups.br_pickupsfx[scriptablename];
  else if(isweaponpickupitem(pickupent))
    return "pickup_weap";
  else
    return "pickup_ammo";
}

_id_E53DB8CC244F396B(pickupent, scriptablename) {
  if(_id_531CB1BE084314F7::isplunder(pickupent.scriptablename))
    return "br_plunder";
  else if(_id_531CB1BE084314F7::isammo(pickupent.scriptablename))
    return "br_ammo";
  else if(_id_531CB1BE084314F7::isarmorplate(pickupent.scriptablename))
    return "br_armor";
}

_id_EE5540242EF172D4(pickupent) {
  self notify("player_play_pickup_anim");
  self endon("player_play_pickup_anim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !_id_531CB1BE084314F7::playercanplaynotcriticalgesture()) {
    return;
  }
  _id_A7408DBFED49F3F9 = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(_id_A7408DBFED49F3F9)) {
    if(self isgestureplaying("iw9_ges_pickup"))
      self stopgestureviewmodel("iw9_ges_pickup", 0, 1);

    self takeweapon(_id_A7408DBFED49F3F9);
    waitframe();
  }

  playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
}

playerplaygestureweaponanim(weaponref, _id_EB5B1F36E255152D) {
  self endon("death_or_disconnect");
  _id_A7408DBFED49F3F9 = makeweapon(weaponref);
  self giveandfireoffhand(_id_A7408DBFED49F3F9);
  wait(_id_EB5B1F36E255152D);

  if(self hasweapon(_id_A7408DBFED49F3F9))
    self takeweapon(_id_A7408DBFED49F3F9);
}

takeplunderpickup(pickupent) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  amount = 1;

  if(isDefined(pickupent.count))
    amount = pickupent.count;

  if(scripts\engine\utility::array_contains(level.br_plunder.names, pickupent.scriptablename)) {
    playerplunderpickup(amount);
    level.br_plunder.plunder_items_picked_up = level.br_plunder.plunder_items_picked_up + 1;
    level.br_plunder.plunder_value_picked_up = level.br_plunder.plunder_value_picked_up + amount;
    _id_531CB1BE084314F7::modify_plunder_itemsinworld(pickupent.scriptablename, -1);
    type = "loot";

    if(isDefined(pickupent.instance.lootsource)) {
      type = pickupent.instance.lootsource;
      return;
    }
  } else
    trypickupitem(pickupent.scriptablename, amount);
}

playerplunderpickupcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  if(istrue(level._id_BE46ED9FDE731E08))
    data.playplundersound = 0;

  return data;
}

playerplunderlosecallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  return data;
}

createplayerplundereventdata(player, team) {
  data = spawnStruct();
  data.player = undefined;

  if(isDefined(player))
    data.player = player;

  data.playersplash = undefined;
  data.playerscoreeventref = undefined;
  data.playerscoreeventvalue = undefined;
  data.setplunderifunchanged = undefined;
  data.playplundersound = 1;
  data.plundersoundamount = undefined;
  data.playanimation = undefined;
  return data;
}

playerplunderpickup(amount, data, _id_3108C5D4E33B7014) {
  return playerplunderevent(amount, 1, undefined, data, _id_3108C5D4E33B7014);
}

playerplunderevent(amount, type, entity, data, _id_3108C5D4E33B7014) {
  if(!istrue(level.br_plunder_enabled) || !isDefined(self.plundercount)) {
    return;
  }
  if(istrue(_id_3108C5D4E33B7014) && amount <= 0) {
    return;
  }
  if(type == 2 || type == 3 || type == 4)
    amount = int(min(self.plundercount, amount));

  if(!isDefined(self.plundereventtime))
    self.plundereventtime = [];

  if(!isDefined(self.plundereventtotal))
    self.plundereventtotal = [];

  if(!isDefined(self.lastplundereventtype))
    self.lastplundereventtype = 0;

  _id_26641D000F48954A = scripts\engine\utility::ter_op(type == 5, 3, type);
  omnvar = level.playerplundereventomnvars[_id_26641D000F48954A];
  plundereventtotal = self.plundereventtotal[type];
  plundereventtime = self.plundereventtime[type];

  if(!isDefined(plundereventtime) || gettime() - plundereventtime > 2000)
    plundereventtotal = 0;

  plundereventtotal = plundereventtotal + amount;

  if(isPlayer(self) && isDefined(omnvar)) {
    _id_5C9DDCF56D36F133 = int(min(plundereventtotal, self.plundercount + amount));
    self setclientomnvar(omnvar, _id_5C9DDCF56D36F133);
  }

  self.lastplundereventtype = type;
  self.plundereventtime[type] = gettime();
  self.plundereventtotal[type] = plundereventtotal;
  _id_8CD4523B06660D98 = level.playerplundereventcallbacks[type];

  if(isDefined(_id_8CD4523B06660D98))
    data = self[[_id_8CD4523B06660D98]](amount, entity, data);

  if(isDefined(data)) {
    if(isDefined(data.player)) {
      if(isDefined(data.playersplash) && data.playersplash != "none") {
        if(data.playersplash != "br_plunder_first_pickup" || !istrue(data.player.haspickedupplunderyet)) {
          data.player thread scripts\cp\cp_hud_message::showsplash(data.playersplash);

          if(data.playersplash == "br_plunder_first_pickup")
            data.player.haspickedupplunderyet = 1;
        }
      }

      if(isDefined(data.playerscoreeventref) && (!isDefined(data.playerscoreeventvalue) || data.playerscoreeventvalue > 0))
        data.player thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE(data.playerscoreeventref, undefined, data.playerscoreeventvalue);
    }

    if(isDefined(data.amount))
      amount = data.amount;

    if(istrue(data.playplundersound)) {
      _id_644A1BA14DC91834 = scripts\engine\utility::ter_op(isDefined(data.plundersoundamount), data.plundersoundamount, amount);
      playplundersoundbyamount(self, _id_644A1BA14DC91834);
    }
  }

  switch (type) {
    case 4:
    case 3:
    case 2:
      amount = amount * -1;
      break;
    case 6:
    case 5:
      amount = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(amount)) {
    data.plunderdelta = amount;
    thread _id_531CB1BE084314F7::playersetplundercount(self.plundercount + amount, data);
  }

  return data;
}

playplundersoundbyamount(player, amount) {
  if(amount == 0) {
    return;
  }
  _id_3466C10973E9C476 = getplundernamebyamount(amount);
  soundalias = getcashsoundaliasforplayer(player, _id_3466C10973E9C476);
  player playsoundtoplayer(soundalias, self);
}

getplundernamebyamount(amount) {
  _id_3466C10973E9C476 = level.br_plunder.names[0];

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    if(amount >= level.br_plunder.quantity[_id_AC0E594AC96AA3A8]) {
      _id_3466C10973E9C476 = level.br_plunder.names[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return _id_3466C10973E9C476;
}

getcashsoundaliasforplayer(player, _id_3466C10973E9C476) {
  _id_09D5BC8E32EE3635 = "br_pickup_cash";
  _id_41426F97882C68FB = 5000.0;
  _id_D8C56288C4B1C484 = _id_41426F97882C68FB / 1000.0;
  _id_64F88D0441939203 = gettime();

  if(isPlayer(player)) {
    if(!isDefined(player.br_cash_count))
      player.br_cash_count = 0;

    if(!isDefined(player.br_cash_time))
      player.br_cash_time = _id_64F88D0441939203;

    _id_DF1D3AA74EC5C028 = _id_64F88D0441939203 - player.br_cash_time;
    player.br_cash_time = _id_64F88D0441939203;

    if(_id_DF1D3AA74EC5C028 < _id_41426F97882C68FB)
      player.br_cash_count = player.br_cash_count + 1;

    switch (_id_3466C10973E9C476) {
      case "brloot_plunder_cash_common_1":
      case "brloot_plunder_cash_uncommon_2":
      case "brloot_plunder_cash_uncommon_1":
      default:
        switch (player.br_cash_count) {
          case 1:
          case 0:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_01";
            break;
          case 2:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_02";
            break;
          case 3:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_03";
            break;
          case 4:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_04";
            break;
          case 5:
          default:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_05";
            break;
        }

        break;
      case "brloot_plunder_cash_rare_1":
      case "brloot_plunder_cash_uncommon_3":
        switch (player.br_cash_count) {
          case 1:
          case 0:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_med_01";
            break;
          case 2:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_med_02";
            break;
          case 3:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_med_03";
            break;
          case 4:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_med_04";
            break;
          case 5:
          default:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_med_05";
            break;
        }

        break;
      case "brloot_plunder_cash_epic_2":
      case "brloot_plunder_cash_rare_2":
      case "brloot_plunder_cash_epic_1":
        switch (player.br_cash_count) {
          case 1:
          case 0:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_lrg_01";
            break;
          case 2:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_lrg_02";
            break;
          case 3:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_lrg_03";
            break;
          case 4:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_lrg_04";
            break;
          case 5:
          default:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_lrg_05";
            break;
        }

        break;
      case "brloot_plunder_cash_legendary_1":
        switch (player.br_cash_count) {
          case 1:
          case 0:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_vlrg_01";
            break;
          case 2:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_vlrg_02";
            break;
          case 3:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_vlrg_03";
            break;
          case 4:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_vlrg_04";
            break;
          case 5:
          default:
            _id_09D5BC8E32EE3635 = "br_pickup_cash_vlrg_05";
            break;
        }

        break;
    }
  }

  return _id_09D5BC8E32EE3635;
}

processuniquelootitem(uniquelootitemid, player) {
  if(isDefined([[level.br_pickups.uniquelootcallbacks[uniquelootitemid]]](player)))
    return;
  else {}
}

trypickupitem(scriptablename, count) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups.maxcounts[scriptablename]) || !isDefined(level.br_pickups.stackable[scriptablename])) {
    return;
  }
  pickup = spawnStruct();
  pickup.scriptablename = scriptablename;
  pickup.count = count;
  pickup.maxcount = level.br_pickups.maxcounts[scriptablename];
  pickup.stackable = level.br_pickups.stackable[scriptablename];
  pickup.itemtype = level.br_pickups.br_itemtype[scriptablename];

  if(canslotitem(pickup.scriptablename, pickup.count))
    pickupitemintoinventory(pickup);
  else {
    self iprintlnbold("No room in inventory");
    self playlocalsound("br_pickup_deny");
  }
}

pickupitemintoinventory(pickup) {
  if(_id_531CB1BE084314F7::ispickupstackable(pickup.scriptablename)) {
    if(canstackpickup(pickup.scriptablename, pickup.count)) {
      foreach(index, item in self.br_inventory_slots) {
        if(isDefined(item.scriptablename) && item.scriptablename == pickup.scriptablename) {
          if(!isitemfull(item, pickup.count)) {
            item.count = item.count + pickup.count;
            item.count = int(min(item.count, pickup.maxcount));
            return;
          }
        }
      }
    }
  }

  _id_001475CE431472AD = getfirstopenslot();

  if(_id_001475CE431472AD == -1) {
    return;
  }
  self.br_inventory_slots[_id_001475CE431472AD] = pickup;
}

isitemfull(item, _id_E52A49E4832AC060) {
  return _id_E52A49E4832AC060 + item.count > item.maxcount;
}

canstackpickup(scriptablename, _id_E52A49E4832AC060) {
  foreach(item in self.br_inventory_slots) {
    if(isDefined(item.scriptablename) && item.scriptablename == scriptablename) {
      if(!isitemfull(item, _id_E52A49E4832AC060))
        return 1;
    }
  }

  return 0;
}

getfirstopenslot() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.br_inventory_slots[_id_AC0E594AC96AA3A8]))
      return _id_AC0E594AC96AA3A8;
  }

  return -1;
}

canslotitem(scriptablename, _id_E52A49E4832AC060) {
  if(_id_531CB1BE084314F7::ispickupstackable(scriptablename)) {
    if(canstackpickup(scriptablename, _id_E52A49E4832AC060))
      return 1;
  }

  return isitemslotopen();
}

isitemslotopen() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.br_inventory_slots[_id_AC0E594AC96AA3A8]))
      return 1;
  }

  return 0;
}

takeammopickup(pickupent) {
  _id_C240D5BBB6B43A32 = 0;

  if(pickupent.scriptablename == "Ammo_Crate") {
    weaponobj = self getcurrentweapon();
    _id_5C3F9357F11D2223 = weaponobj.basename;
    _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(_id_5C3F9357F11D2223);
    clipsize = weaponclipsize(_id_5C3F9357F11D2223);
    ammotype = br_ammo_type_for_weapon(weaponobj);

    if(isDefined(ammotype))
      _id_C240D5BBB6B43A32 = br_ammo_give_type(self, ammotype, clipsize);
  } else
    _id_C240D5BBB6B43A32 = br_ammo_give_type(self, pickupent.scriptablename, pickupent.count, 1);

  if(_id_C240D5BBB6B43A32) {
    pickupent.count = _id_C240D5BBB6B43A32;
    _id_10BBEACB1429824E = 1;
  } else
    _id_10BBEACB1429824E = 0;

  return _id_10BBEACB1429824E;
}

_id_99E27ED6B392B6A9(pickupent) {
  _id_10BBEACB1429824E = 0;

  if(isDefined(pickupent.count)) {
    _id_6018EDF2459AE384 = scripts\engine\utility::ter_op(pickupent.count > level._id_C4E3D516B4EA7BE7, level._id_C4E3D516B4EA7BE7, pickupent.count);
    pickupent.count = _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_6018EDF2459AE384);

    if(isDefined(pickupent.count) && pickupent.count > 0)
      _id_10BBEACB1429824E = 1;
  }

  return _id_10BBEACB1429824E;
}

_id_31374AB57F6A7926(pickupent) {
  _id_10BBEACB1429824E = 1;
  return _id_10BBEACB1429824E;
}

_id_355165DAC88B5D17(pickupent) {
  _id_10BBEACB1429824E = 1;
  _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(2);
  return _id_10BBEACB1429824E;
}

_id_E1809C1EA94194D8(pickupent) {
  _id_C240D5BBB6B43A32 = 0;
  _id_5C3F9357F11D2223 = self getcurrentprimaryweapon();
  ammotype = br_ammo_type_for_weapon(_id_5C3F9357F11D2223);

  if(isDefined(ammotype)) {
    _id_DC6CFFBD65A99AE8 = level._id_E6EA72FC5E3FCD00[ammotype];
    _id_C240D5BBB6B43A32 = br_ammo_give_type(self, ammotype, _id_DC6CFFBD65A99AE8);
  }

  if(_id_C240D5BBB6B43A32)
    _id_10BBEACB1429824E = 1;
  else
    _id_10BBEACB1429824E = 0;

  return _id_10BBEACB1429824E;
}

br_ammo_give_type(player, ammotype, amount, _id_8BB770D6EEDA5198, _id_DFF84541DCB30D24) {
  if(!isDefined(_id_8BB770D6EEDA5198))
    _id_8BB770D6EEDA5198 = 0;

  if(br_ammo_type_player_full(player, ammotype, _id_DFF84541DCB30D24)) {
    if(_id_8BB770D6EEDA5198)
      return amount;
    else
      return 0;
  }

  _id_2C86AF91E7E20602 = 0;
  player.br_ammo[ammotype] = player.br_ammo[ammotype] + amount;

  if(player.br_ammo[ammotype] > level.br_ammo_max[ammotype]) {
    _id_2C86AF91E7E20602 = player.br_ammo[ammotype] - level.br_ammo_max[ammotype];

    if(_id_8B121DD10A442DD2() && !istrue(_id_DFF84541DCB30D24)) {
      _id_BADA25504E8844D7 = spawnStruct();
      _id_BADA25504E8844D7.scriptablename = ammotype;
      _id_BADA25504E8844D7.count = _id_2C86AF91E7E20602;
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
      player _id_10F6E537F1B5763C(lootid, _id_BADA25504E8844D7, !_id_8BB770D6EEDA5198);
      _id_2C86AF91E7E20602 = 0;
    } else if(_id_8BB770D6EEDA5198 && _id_2C86AF91E7E20602 < level.br_ammo_clipsize[ammotype])
      _id_2C86AF91E7E20602 = 0;

    player.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];
  }

  player br_ammo_player_hud_update_ammotype(ammotype);
  br_ammo_update_weapons(player);

  if(_id_8BB770D6EEDA5198)
    return _id_2C86AF91E7E20602;
  else
    return 1;
}

br_ammo_type_player_full(player, ammotype, _id_DFF84541DCB30D24) {
  if(!isDefined(ammotype))
    return 1;

  if(!isDefined(player.br_ammo) || !isDefined(player.br_ammo[ammotype]))
    return 0;

  if(!isDefined(level._id_E6EA72FC5E3FCD00[ammotype]))
    return 0;

  if(_id_8B121DD10A442DD2() && !istrue(_id_DFF84541DCB30D24))
    return 0;

  return get_int_or_0(player.br_ammo[ammotype]) >= level._id_E6EA72FC5E3FCD00[ammotype];
}

takearmorpickup(pickupent) {
  _id_873C80E924A3F087 = level.br_pickups.br_equipname[pickupent.scriptablename];
  _id_0E233F90AEC7BF0A = isarmorbetterthanequipped(_id_873C80E924A3F087);

  if(_id_0E233F90AEC7BF0A)
    tryequiparmor(pickupent);
}

isarmorbetterthanequipped(_id_DBD090CC010CD89B) {
  _id_9FB8A8EE3A677CEA = 0;

  if(_id_DBD090CC010CD89B == "equip_helmet_1")
    _id_9FB8A8EE3A677CEA = 1;
  else if(_id_DBD090CC010CD89B == "equip_helmet_2")
    _id_9FB8A8EE3A677CEA = 2;
  else if(_id_DBD090CC010CD89B == "equip_helmet_3")
    _id_9FB8A8EE3A677CEA = 3;

  if(_id_9FB8A8EE3A677CEA > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < _id_9FB8A8EE3A677CEA)
      return 1;
  }

  return 0;
}

tryequiparmor(item, slot) {
  if(isDefined(slot))
    self.br_inventory_slots[slot] = undefined;
}

takerevivepickup(pickupent) {
  _id_10BBEACB1429824E = 0;

  if(!scripts\cp\utility::has_auto_revive() && !scripts\cp\utility::_id_03EA84AB28DEA3F8()) {
    addselfrevivetoken();
    _id_10BBEACB1429824E = 0;
    self.pers["dropped_initial_revive_token"] = undefined;
  } else {
    scripts\cp\cp_hud_message::tutorialprint(&"CP_SURIVAL/ALREADY_HAS_REVIVE", 2);
    _id_10BBEACB1429824E = 1;
  }

  return _id_10BBEACB1429824E;
}

sethasselfrevivetokenextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 65536;
  else
    self.game_extrainfo = self.game_extrainfo &~65536;
}

addselfrevivetoken(skipsplash) {
  if(istrue(self.hasselfrevivetoken)) {
    scripts\cp\cp_hud_message::tutorialprint(&"CP_SURIVAL/ALREADY_HAS_REVIVE", 2);
    return;
  }

  _id_0AFB7E332AEE4BF2::enable_self_revive(self);
  sethasselfrevivetokenextrainfo(1);
  self.hasselfrevivetoken = 1;

  if(!isDefined(self._id_9F4E140E6DCBC55D))
    self._id_9F4E140E6DCBC55D = [];

  self._id_9F4E140E6DCBC55D[self._id_9F4E140E6DCBC55D.size] = scripts\cp\utility::set_carry_item(self, "self_revive");

  if(!istrue(skipsplash))
    thread scripts\cp\cp_hud_message::showsplash("br_self_revive_token_pickup");

  if(!scripts\cp\utility::_hasperk("specialty_pistoldeath"))
    scripts\cp\utility::giveperk("specialty_pistoldeath");
}

removeselfrevivetoken() {
  player = self;
  player.hasselfrevivetoken = 0;
  player sethasselfrevivetokenextrainfo(0);
  player scripts\cp\utility::_id_98F7CA3781DAC77C(player, "self_revive");
  _id_04AD7C03EC4FA687 = level.maxteamsize == 1;

  if(_id_04AD7C03EC4FA687 && player scripts\cp\utility::_hasperk("specialty_pistoldeath"))
    player _id_6E09A830FAB9468F::removeperk("specialty_pistoldeath");
}

takeweaponpickup(pickupent, _id_DB943473454F6EA6) {
  _id_FC705B68988AE946 = pickupent.origin;
  _id_7B9DE6DB6A90DBE7 = 0;
  _id_060012A0838191D7 = self.primaryweapons.size;
  _id_7F6369ECA6D7C141 = _id_531CB1BE084314F7::_id_55C5D35C8C76A95B(pickupent);
  _id_DD515FCF025B2E79 = _id_7F6369ECA6D7C141[0];
  _id_1C454AEE1C2A55DF = _id_7F6369ECA6D7C141[1];
  weaponname = _id_7F6369ECA6D7C141[2];
  _id_7DC30386B50647A1 = 0;
  _id_0EC22A950F210E39 = undefined;

  foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
    if(isnullweapon(_id_DE88CD14114C1E24)) {
      _id_060012A0838191D7--;
      continue;
    }

    if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
      _id_7DC30386B50647A1 = 1;
      _id_0EC22A950F210E39 = _id_DE88CD14114C1E24;
    }
  }

  if(_id_060012A0838191D7 > 1 && !_id_7DC30386B50647A1) {
    if(!self hasweapon("iw9_me_fists_mp"))
      _id_7DC30386B50647A1 = 1;
    else
      self takeweapon("iw9_me_fists_mp");
  }

  if(_id_7DC30386B50647A1) {
    if(istrue(pickupent.isautouse) && getdvarint("bg_weapondiscardoptionsenabled", 0)) {
      _id_0EC22A950F210E39 = _id_531CB1BE084314F7::_id_823964AA15B30575();
      _id_7B9DE6DB6A90DBE7 = isDefined(_id_0EC22A950F210E39) && !issameweapon(_id_0EC22A950F210E39, self getcurrentweapon());
    }

    if(!isDefined(_id_0EC22A950F210E39))
      _id_0EC22A950F210E39 = self.lastdroppableweaponobj;

    if(_id_0EC22A950F210E39.basename != "none") {
      _id_28AEBE3DD6733ED3 = undefined;
      _id_1AF8FE94EE02A80F = undefined;
      _id_961012DD15FA29EE = undefined;
      _id_1EE5FB8247544C62 = pickupent.origin - self.origin;
      yaw = vectortoyaw(_id_1EE5FB8247544C62);
      _id_C02997B2DEFF6E69 = 1;

      if(istrue(pickupent.instance._id_FF45E00F9ED1E5C9)) {
        _id_FC705B68988AE946 = self.origin;
        pickupent.instance disablescriptableplayeruse(self);
      }

      if(istrue(level._id_0F478C1F94CAA7E9) && !_id_EFAB78B72D131D76(self)) {
        _id_8107FE0FEEC27866(self, _id_0EC22A950F210E39);
        _id_C02997B2DEFF6E69 = 0;
      } else if(isDefined(_id_DB943473454F6EA6) && _id_531CB1BE084314F7::_id_3AB0A87EEAA203BF()) {
        _id_64F6EBFF728689AB(self, _id_0EC22A950F210E39);
        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_0EC22A950F210E39);
        variantid = _id_0EC22A950F210E39.variantid;

        if(!isDefined(_id_0EC22A950F210E39.variantid))
          variantid = 0;

        lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
        _id_A0CCC23064473A05(_id_DB943473454F6EA6, lootid, 1);
        _id_C02997B2DEFF6E69 = 0;
      } else {
        _id_28AEBE3DD6733ED3 = self getweaponammoclip(_id_0EC22A950F210E39);
        _id_1AF8FE94EE02A80F = self getweaponammoclip(_id_0EC22A950F210E39, "left");
        _id_961012DD15FA29EE = 0;

        if(_id_0EC22A950F210E39.hasalternate) {
          _id_5D9B5B689A1846C8 = _id_0EC22A950F210E39 getaltweapon();
          _id_961012DD15FA29EE = self getweaponammoclip(_id_5D9B5B689A1846C8);
        }

        if(!scripts\cp_mp\utility\weapon_utility::isriotshield(_id_0EC22A950F210E39)) {
          _id_D1AD88BF84DAA67F = self getweaponammostock(_id_0EC22A950F210E39);
          _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(_id_0EC22A950F210E39);

          if(isDefined(_id_811ABFDB6C33F17F))
            self.br_ammo[_id_811ABFDB6C33F17F] = _id_D1AD88BF84DAA67F;
        }

        if(_id_C02997B2DEFF6E69) {
          _id_CB4FAD49263E20C4 = getitemdroporiginandangles(0, _id_FC705B68988AE946, (0, yaw, 0), self, 0, 0);
          item = weaponspawn(_id_0EC22A950F210E39, self, _id_CB4FAD49263E20C4, 0);

          if(isDefined(item)) {
            loot_setitemcount(item, _id_28AEBE3DD6733ED3, _id_1AF8FE94EE02A80F, _id_961012DD15FA29EE);

            if(_id_B1DD9DCAE2F63965())
              _id_531CB1BE084314F7::_id_8E7E1DA48D7746E5(self, item);

            _id_E637EE4FAED5D14D = 1;
            self notify("dropped_weapon_scriptable", item, undefined, _id_CB4FAD49263E20C4.origin);
          }
        }
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0EC22A950F210E39);
    }
  } else if(isDefined(_id_DB943473454F6EA6)) {
    [lootid, quantity] = _id_531CB1BE084314F7::_id_6738846DA50730F1(_id_DB943473454F6EA6);
    _id_531CB1BE084314F7::_id_6F39F9916649AC48(lootid, 1);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponname);
  self notify("pickedupweapon", weaponname);
  _id_DD2BB4748E278051 = istrue(level._id_EEDBACC5FD767772);
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(_id_DD2BB4748E278051 || isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint)
    thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();

  if(istrue(_id_DD515FCF025B2E79.isweaponfromcrate) || istrue(pickupent.isweaponfromcrate)) {
    ammotype = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

    if(isDefined(ammotype)) {
      clipsize = weaponclipsize(_id_DD515FCF025B2E79);
      _id_AB0EE360900BCB85 = _id_ECDFC73E68DCC209(ammotype);
      br_ammo_give_type(self, ammotype, _id_AB0EE360900BCB85);
    }
  } else {
    _id_C1192C297BBF292F = pickupent.count;
    _id_7B7B94EFE2E96D4B = pickupent.countlefthand;
    clipsize = weaponclipsize(_id_DD515FCF025B2E79);
    _id_031B36738FF4EACD = 0;

    if(_id_C1192C297BBF292F > clipsize) {
      _id_031B36738FF4EACD = _id_031B36738FF4EACD + (_id_C1192C297BBF292F - clipsize);
      _id_C1192C297BBF292F = clipsize;
    }

    if(_id_7B7B94EFE2E96D4B > clipsize) {
      _id_031B36738FF4EACD = _id_031B36738FF4EACD + (_id_7B7B94EFE2E96D4B - clipsize);
      _id_7B7B94EFE2E96D4B = clipsize;
    }

    self setweaponammoclip(weaponname, _id_C1192C297BBF292F);
    self setweaponammoclip(weaponname, _id_7B7B94EFE2E96D4B, "left");

    if(_id_031B36738FF4EACD > 0) {
      ammotype = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

      if(isDefined(ammotype))
        br_ammo_give_type(self, ammotype, _id_031B36738FF4EACD);
    }

    if(_id_DD515FCF025B2E79.hasalternate) {
      _id_DFD1FD5D26DD4E12 = pickupent._id_E97D731BEDD44C63;
      _id_84C947974132A108 = _id_DD515FCF025B2E79 getaltweapon();
      _id_13E1D3280DF9E6E7 = weaponclipsize(_id_84C947974132A108);

      if(!isDefined(_id_DFD1FD5D26DD4E12) || _id_DFD1FD5D26DD4E12 > _id_13E1D3280DF9E6E7)
        _id_DFD1FD5D26DD4E12 = _id_13E1D3280DF9E6E7;

      self setweaponammoclip(_id_84C947974132A108, _id_DFD1FD5D26DD4E12);
    }
  }

  ammotype = undefined;

  if(isDefined(_id_DD515FCF025B2E79))
    ammotype = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

  if(isDefined(ammotype))
    br_ammo_update_ammotype_weapons(self, ammotype, self.br_ammo[ammotype]);

  if(!istrue(_id_7B9DE6DB6A90DBE7)) {
    self assignweaponprimaryslot(weaponname);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponname);
    _id_74502A9E0EF1F19C::fixupplayerweapons(self, weaponname);
    _id_74502A9E0EF1F19C::updatelastweaponobj(_id_DD515FCF025B2E79);
  }

  if(isDefined(pickupent.weapon) && isent(pickupent.weapon))
    pickupent.weapon delete();

  _id_66B3DB972AC1531E = undefined;

  foreach(weapon in self.equippedweapons) {
    if(isweapon(weapon) && weapon.inventorytype == "primary") {
      _id_A0CB84D50AFAAB7D = getcompleteweaponname(weapon);

      if(_id_A0CB84D50AFAAB7D == weaponname) {
        _id_66B3DB972AC1531E = weapon;
        break;
      }
    }
  }

  if(isDefined(pickupent.instance))
    level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_trigger(pickupent.instance, self, _id_DD515FCF025B2E79);
}

_id_64F6EBFF728689AB(player, weapon) {
  if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
    return;
  }
  clipammo = player getweaponammoclip(weapon);
  _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(weapon);

  if(isDefined(_id_811ABFDB6C33F17F))
    self.br_ammo[_id_811ABFDB6C33F17F] = self.br_ammo[_id_811ABFDB6C33F17F] + clipammo;
}

fixupplayerweapons(player, weapon) {
  _id_E3B59C80BF16DE8C = player getweaponslistprimaries();
  _id_45005959354D69FF = 1;
  _id_39E00B498B7A3C1B = 1;
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = getcompleteweaponname(weapon);
  else
    weaponname = weapon;

  foreach(currentweapon in _id_E3B59C80BF16DE8C) {
    if(isDefined(player.primaryweaponobj) && player.primaryweaponobj == currentweapon) {
      _id_45005959354D69FF = 0;
      continue;
    }

    if(isDefined(player.secondaryweaponobj) && player.secondaryweaponobj == currentweapon)
      _id_39E00B498B7A3C1B = 0;
  }

  if(_id_45005959354D69FF) {
    player.primaryweapon = weaponname;
    player.primaryweaponobj = makeweaponfromstring(weaponname);
  } else if(_id_39E00B498B7A3C1B) {
    player.secondaryweapon = weaponname;
    player.secondaryweaponobj = makeweaponfromstring(weaponname);
  }

  return _id_45005959354D69FF || _id_39E00B498B7A3C1B;
}

br_ammo_update_weapons(player) {
  if(!isDefined(player)) {
    return;
  }
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_1C0BAEEC9828351C = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_1C0BAEEC9828351C)) {
      _id_5B3F7D686C59AB97 = get_int_or_0(player.br_ammo[_id_1C0BAEEC9828351C]);
      player _id_4906C10C3FFDD4CA(_id_DE88CD14114C1E24, _id_5B3F7D686C59AB97);
    }
  }

  player notify("ammo_update");
}

_id_BC12E1EF44F08EFA() {
  if(!isDefined(self)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_1C0BAEEC9828351C = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_1C0BAEEC9828351C)) {
      _id_DD2DECF8DB7E69B8 = self getweaponammostock(_id_DE88CD14114C1E24);
      _id_5B3F7D686C59AB97 = get_int_or_0(self.br_ammo[_id_1C0BAEEC9828351C]);
      br_ammo_max = level._id_E6EA72FC5E3FCD00[_id_1C0BAEEC9828351C];
      _id_190B69D94AFE0A15 = _id_DD2DECF8DB7E69B8 + _id_5B3F7D686C59AB97;

      if(_id_190B69D94AFE0A15 >= br_ammo_max)
        _id_190B69D94AFE0A15 = br_ammo_max;

      self.br_ammo[_id_1C0BAEEC9828351C] = _id_190B69D94AFE0A15;
    }
  }

  self notify("ammo_update");
}

_id_01D23B39EB17B338() {
  if(!isDefined(self)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_1C0BAEEC9828351C = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_1C0BAEEC9828351C)) {
      _id_5B3F7D686C59AB97 = self getweaponammostock(_id_DE88CD14114C1E24);
      _id_5B3F7D686C59AB97 = get_int_or_0(_id_5B3F7D686C59AB97);
      _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);
      br_ammo_give_type(self, _id_811ABFDB6C33F17F, _id_5B3F7D686C59AB97, 0);
    }
  }
}

get_int_or_0(value) {
  if(!isDefined(value))
    return 0;

  return int(value);
}

spawnpickup(_id_C0DD242FFCB18BD2, _id_CB4FAD49263E20C4, count, _id_8D9AE21C4B7DA354, weaponobj, _id_1AD2DB70C8D01F51, countlefthand, _id_E97D731BEDD44C63) {
  if(!isDefined(_id_CB4FAD49263E20C4)) {
    return;
  }
  if(_id_CB4FAD49263E20C4.origin == (0, 0, 0)) {
    return;
  }
  _id_EF809B0EE883BCC7 = 0;
  _id_C9C301A888170672 = undefined;

  if(isDefined(level.br_pickups.br_weapontoscriptable[_id_C0DD242FFCB18BD2]))
    _id_C9C301A888170672 = level.br_pickups.br_weapontoscriptable[_id_C0DD242FFCB18BD2];
  else if(isvalidcustomweapon(weaponobj)) {
    _id_CCE9361200C5117C = _id_2669878CF5A1B6BC::_id_0C9AF9FE37668DF2(weaponobj.basename);

    if(_id_CCE9361200C5117C != "me" && _id_CCE9361200C5117C != "pi" && _id_CCE9361200C5117C != "sh" && _id_CCE9361200C5117C != "sm" && _id_CCE9361200C5117C != "ar" && (_id_CCE9361200C5117C != "lm" && !_id_2669878CF5A1B6BC::isminigunweapon(weaponobj)) && _id_CCE9361200C5117C != "dm" && _id_CCE9361200C5117C != "sn" && _id_CCE9361200C5117C != "la" && _id_CCE9361200C5117C != "kn") {
      return;
    }
    _id_EF809B0EE883BCC7 = 1;
    _id_C9C301A888170672 = "brloot_weapon_generic_" + _id_CCE9361200C5117C;
  } else if(isdroppablepickup(_id_C0DD242FFCB18BD2))
    _id_C9C301A888170672 = _id_C0DD242FFCB18BD2;

  if(!isDefined(_id_C9C301A888170672)) {
    return;
  }
  if(_id_C9C301A888170672 == "brloot_weapon_me_riotshield_epic" || isvalidcustomweapon(weaponobj) && scripts\cp_mp\utility\weapon_utility::isriotshield(weaponobj)) {
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] - 90, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2]);
    _id_CB4FAD49263E20C4.origin = (_id_CB4FAD49263E20C4.origin[0], _id_CB4FAD49263E20C4.origin[1], _id_CB4FAD49263E20C4.origin[2] + 2);
  }

  if(issubstr(_id_C9C301A888170672, "la_juliet")) {
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] - 4.2, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2] - 90);
    _id_CB4FAD49263E20C4.origin = (_id_CB4FAD49263E20C4.origin[0], _id_CB4FAD49263E20C4.origin[1], _id_CB4FAD49263E20C4.origin[2] + 8.5);
  }

  if(_id_C9C301A888170672 == "brloot_offhand_gas")
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0], _id_CB4FAD49263E20C4.angles[1] - 90, _id_CB4FAD49263E20C4.angles[2]);

  if(_id_C9C301A888170672 == "brloot_offhand_shockstick")
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0], _id_CB4FAD49263E20C4.angles[1] - 180, _id_CB4FAD49263E20C4.angles[2]);

  if(_id_C9C301A888170672 == "brloot_offhand_molotov")
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0], _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2] - 90);

  if(issubstr(_id_C9C301A888170672, "interactable_note_raid"))
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] + 90, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2]);

  if(_id_C9C301A888170672 == "interactable_note_ee_usb")
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] + 90, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2]);

  if(_id_C9C301A888170672 == "interactable_note_keycard_a" || _id_C9C301A888170672 == "interactable_note_keycard_b" || _id_C9C301A888170672 == "interactable_note_keycard_c" || _id_C9C301A888170672 == "interactable_note_keycard_raid4_maze" || _id_C9C301A888170672 == "interactable_note_keycard_raid4_maze_2") {
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] + 90, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2]);
    _id_CB4FAD49263E20C4.origin = (_id_CB4FAD49263E20C4.origin[0], _id_CB4FAD49263E20C4.origin[1], _id_CB4FAD49263E20C4.origin[2] + 4);
  }

  _id_52AAC7E6E7072413 = level.br_pickups._id_52AAC7E6E7072413[_id_C9C301A888170672];
  _id_52C58DA4C35FDE00 = level.br_pickups._id_52C58DA4C35FDE00[_id_C9C301A888170672];

  if(isDefined(_id_52AAC7E6E7072413))
    _id_CB4FAD49263E20C4.origin = _func_4AD9053267734CF2(_id_52AAC7E6E7072413, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);

  if(isDefined(_id_52C58DA4C35FDE00))
    _id_CB4FAD49263E20C4.angles = _id_52C58DA4C35FDE00 + _id_CB4FAD49263E20C4.angles;

  clearspaceforscriptableinstance();

  if(_id_EF809B0EE883BCC7) {
    item = spawncustomweaponscriptable(_id_C9C301A888170672, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles, _id_CB4FAD49263E20C4.payload, weaponobj);

    if(isDefined(item))
      item.customweaponname = getcompleteweaponname(weaponobj);
  } else
    item = spawnscriptable(_id_C9C301A888170672, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles, _id_CB4FAD49263E20C4.payload);

  if(!isDefined(item)) {
    return;
  }
  if(isDefined(_id_CB4FAD49263E20C4.groundentity)) {
    _id_EA3B9640A6AD3C8E = rotatevectorinverted(_id_CB4FAD49263E20C4.origin - _id_CB4FAD49263E20C4.groundentity.origin, _id_CB4FAD49263E20C4.groundentity.angles);
    localangles = combineangles(invertangles(_id_CB4FAD49263E20C4.groundentity.angles), _id_CB4FAD49263E20C4.angles);
    item scripts\common\utility::_id_6E506F39F121EA8A(_id_CB4FAD49263E20C4.groundentity, _id_EA3B9640A6AD3C8E, localangles);
  }

  registerscriptableinstance(item);

  if(isDefined(count))
    loot_setitemcount(item, count, countlefthand, _id_E97D731BEDD44C63);
  else
    loot_setitemcount(item, 0);

  if(!isDefined(_id_1AD2DB70C8D01F51))
    _id_1AD2DB70C8D01F51 = 1;

  if(!istrue(level.br_pickups.br_hasautopickup[_id_C9C301A888170672]))
    _id_1AD2DB70C8D01F51 = 1;

  if(!getdvarint("dvar_61E10DE0F675E9AD")) {
    _id_DA9F4CD603F44758 = item.type;

    if(istrue(_id_8D9AE21C4B7DA354)) {
      if(_id_1AD2DB70C8D01F51) {
        if(getdvarint("dvar_965329FDEB4BE51F", 0) && item getscriptableparthasstate(_id_C9C301A888170672, "dropped_no_outline"))
          item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped_no_outline");
        else
          item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped");
      } else {
        state = "droppedNoAuto";

        if(!item getscriptableparthasstate(_id_DA9F4CD603F44758, state) && getdvarint("dvar_8D10EDE0F25E6D2E", 0)) {
          if(getdvarint("dvar_965329FDEB4BE51F", 0) && item getscriptableparthasstate(_id_C9C301A888170672, "dropped_no_outline"))
            item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped_no_outline");
          else
            item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped");
        }

        item setscriptablepartstate(_id_DA9F4CD603F44758, state);
      }
    } else if(!_id_1AD2DB70C8D01F51) {
      state = "noAuto";

      if(!item getscriptableparthasstate(_id_DA9F4CD603F44758, state) && getdvarint("dvar_8D10EDE0F25E6D2E", 0)) {
        if(getdvarint("dvar_965329FDEB4BE51F", 0))
          state = "dropped_no_outline";
        else
          state = "dropped";
      }

      item setscriptablepartstate(_id_DA9F4CD603F44758, state);
    } else if(getdvarint("dvar_965329FDEB4BE51F", 0) && item getscriptableparthasstate(_id_C9C301A888170672, "dropped_no_outline"))
      item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped_no_outline");
    else
      item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped");
  }

  _id_AC9B1C5E2187AE62 = level.br_pickups.createcallbacks[_id_C9C301A888170672];

  if(isDefined(_id_AC9B1C5E2187AE62))
    item[[_id_AC9B1C5E2187AE62]]();

  return item;
}

isvalidcustomweapon(weaponobj) {
  if(!isDefined(weaponobj))
    return 0;

  if(!isweapon(weaponobj))
    return 0;

  if(isnullweapon(weaponobj))
    return 0;

  if(_id_74502A9E0EF1F19C::isfistweapon(weaponobj) || _id_74502A9E0EF1F19C::isgunlessweapon(weaponobj) || _id_74502A9E0EF1F19C::ismeleeoverrideweapon(weaponobj))
    return 0;

  return 1;
}

isdroppablepickup(_id_C0DD242FFCB18BD2) {
  return 1;
}

weaponspawn(weaponobj, _id_2CA201D5906CDBA5, _id_CB4FAD49263E20C4, _id_63366D9D88CE51F8, _id_8D9AE21C4B7DA354) {
  _id_A0CB84D50AFAAB7D = getcompleteweaponname(weaponobj);
  _id_0CC708B3BF7C11ED = spawnpickup(_id_A0CB84D50AFAAB7D, _id_CB4FAD49263E20C4, 0, _id_8D9AE21C4B7DA354, weaponobj);
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0CC708B3BF7C11ED, _id_2CA201D5906CDBA5, weaponobj);
  return _id_0CC708B3BF7C11ED;
}

_id_B3B99F9F9371C997(weapon) {
  switch (weapon.inventorytype) {
    case "primary":
      break;
    default:
      return 0;
  }

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

  switch (_id_AB501F397D3CD312) {
    case "iw9_me_fists":
    case "iw9_pi_stimpistol_mp":
    case "none":
      return 0;
  }

  return 1;
}

makeweaponfromcrate(_id_2891322C71EF74A8) {
  _id_5FBA91F7C0FC9C89 = scripts\engine\utility::random(level.br_pickups.br_crateguns);
  fullweaponobj = getfullweaponobjforscriptablepartname(_id_5FBA91F7C0FC9C89);

  if(!isDefined(fullweaponobj)) {
    return;
  }
  groundpos = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[_id_2891322C71EF74A8], 50, -200, (0, 0, 1)) + (0, 0, 24);
  weapon = createspawnweaponatpos(groundpos, (0, 0, 90), fullweaponobj);

  if(isDefined(weapon))
    weapon.isweaponfromcrate = 1;

  return weapon;
}

createspawnweaponatpos(pos, angles, fullweaponobj, _id_EC821BAFDC44F38C) {
  if(isstring(fullweaponobj))
    fullweaponobj = makeweaponfromstring(fullweaponobj);

  if(!istrue(_id_EC821BAFDC44F38C)) {
    trace = scripts\engine\trace::ray_trace(pos, (pos[0], pos[1], pos[2] - 60));

    if(trace["fraction"] < 1.0)
      pos = trace["position"] + (0, 0, 2);
  }

  if(!isDefined(angles))
    angles = (0, 0, 90);

  _id_CB4FAD49263E20C4 = getitemdropinfo(pos, angles);
  return weaponspawn(fullweaponobj, undefined, _id_CB4FAD49263E20C4, 1);
}

br_ammo_type_for_weapon(weapon) {
  _id_0DD6BF5F9DBA888C = undefined;
  _id_0DD6BF5F9DBA888C = getweapongroup(weapon);

  if(isDefined(weapon.underbarrel)) {
    _id_D0A536D5580F1BDE = issubstr(weapon.underbarrel, "selectsemi") || issubstr(weapon.underbarrel, "selectauto") || issubstr(weapon.underbarrel, "selectburst");

    if(istrue(weapon.isalternate) && !_id_D0A536D5580F1BDE) {
      if(issubstr(weapon.underbarrel, "ubshtgn"))
        return undefined;
      else
        _id_0DD6BF5F9DBA888C = "weapon_projectile";
    } else
      _id_0DD6BF5F9DBA888C = getweapongroup(weapon);
  }

  return _id_A2FA56C4E1C77BA9(_id_0DD6BF5F9DBA888C);
}

_id_A2FA56C4E1C77BA9(_id_0DD6BF5F9DBA888C) {
  switch (_id_0DD6BF5F9DBA888C) {
    case "weapon_machine_pistol":
    case "weapon_smg":
    case "weapon_pistol":
      return "brloot_ammo_919";
    case "weapon_shotgun":
      return "brloot_ammo_12g";
    case "weapon_battle":
    case "weapon_assault":
    case "weapon_lmg":
      return "brloot_ammo_762";
    case "weapon_sniper":
    case "weapon_dmr":
      return "brloot_ammo_50cal";
    case "weapon_projectile":
      return "brloot_ammo_rocket";
  }

  return undefined;
}

getweapongroup(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return "other";

  if(isstring(weapon) && (weapon == "none" || weapon == "alt_none"))
    return "other";

  if(isstring(weapon))
    _id_AB501F397D3CD312 = weapon;
  else
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

  group = _id_2669878CF5A1B6BC::weapongroupmap(_id_AB501F397D3CD312);

  if(!isDefined(group)) {
    if(scripts\cp\utility::issuperweapon(weapon))
      group = "super";
    else if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
      group = "killstreak";
    else
      group = "other";
  }

  return group;
}

cantakepickup(pickup) {
  if(!isDefined(scripts\cp\loot_system::get_empty_munition_slot(self)) && _id_644C18834356D9DC::_id_AF07AAD35B55FD73(pickup.scriptablename)) {
    scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    self playlocalsound("br_pickup_deny");
    return 0;
  }

  if(self isskydiving())
    return 9;

  if(_id_531CB1BE084314F7::isammo(pickup.scriptablename)) {
    _id_FB40D5954B4F6792 = canholdammobox(pickup.scriptablename);

    if(_id_8B121DD10A442DD2())
      return _id_F8A3FF0A73FA0C1D(pickup, _id_FB40D5954B4F6792);
    else if(_id_FB40D5954B4F6792)
      return 1;
    else
      return 4;
  }

  isautouse = istrue(pickup.isautouse);

  if(isweaponpickupitem(pickup)) {
    if(_id_1B4114093CD44368::_id_23A6763562820C70())
      return 30;

    _id_89162A7340BA32F3 = self getcurrentprimaryweapon();

    if(_id_0DCC09902E277B83::_id_76CA0B3D8B2555CA(_id_89162A7340BA32F3))
      return 30;

    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_pickup") || _id_8C58CD733DFC8CCE(pickup.customweaponname)) {
      if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_pickupdenyequipnoroom)) {
        if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_pickup"))
          _id_68D1EE3A807FD204 = level.br_pickups._id_0FDE0E27B3A09BF3;
        else
          _id_68D1EE3A807FD204 = level.br_pickups.br_pickupdenyequipnoroom;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_68D1EE3A807FD204);

        return 0;
      }
    }

    if(istrue(self.insertingarmorplate))
      return 13;

    if(scripts\cp_mp\utility\player_utility::isinvehicle())
      return 17;

    _id_DD515FCF025B2E79 = _id_531CB1BE084314F7::_id_55C5D35C8C76A95B(pickup)[0];

    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.scriptablename = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

        if(_id_2669878CF5A1B6BC::isminigunweapon(_id_DD515FCF025B2E79)) {
          _id_3DBC3B058135CBFB = self getweaponammoclip(_id_DE88CD14114C1E24);

          if(_id_3DBC3B058135CBFB == weaponclipsize(_id_DE88CD14114C1E24))
            return 3;

          _id_97C3703F332729D6 = min(_id_3DBC3B058135CBFB + 175, _id_60227BFF1E9478CC.count);
          self setweaponammoclip(_id_DE88CD14114C1E24, int(_id_97C3703F332729D6));
          return 5;
        }

        result = _id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, canholdammobox(pickup.scriptablename, _id_DE88CD14114C1E24));

        if(result == 1)
          result = 5;
        else if(result == 20)
          result = 27;

        return result;
      }
    }

    if(_id_8B121DD10A442DD2() && _id_531CB1BE084314F7::_id_3AB0A87EEAA203BF()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      result = _id_E01D9736B2D100AC(lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    if(self _meth_B096B58FB3808D26()) {
      if(isautouse && !_id_531CB1BE084314F7::_id_C8A5593CBB13F17C(pickup, _id_DD515FCF025B2E79))
        return 12;

      self._id_E7F6950DDC75EF66 = gettime();
    }

    return 1;
  }

  if(_id_531CB1BE084314F7::isequipment(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    equipname = level.br_pickups.br_equipname[pickup.scriptablename];
    slot = level.equipment.table[equipname].defaultslot;
    _id_E52A49E4832AC060 = 1;

    if(isDefined(pickup.count))
      _id_E52A49E4832AC060 = pickup.count;

    if(isautouse && (slot == "primary" || slot == "secondary")) {
      if(isDefined(self.equipment[slot]) && _id_531CB1BE084314F7::pickupissameasequipmentslot(equipname, slot) && _id_531CB1BE084314F7::equipmentslothasroom(pickup.scriptablename, slot))
        return 1;

      if(!_id_8B121DD10A442DD2()) {
        if(self _meth_C6CB3E654225077A() && (!isDefined(self.equipment[slot]) || _id_7EF95BBA57DC4B82::getequipmentslotammo(slot) == 0))
          return 1;

        return 12;
      }
    }

    if(!isDefined(self.equipment[slot]) || _id_7EF95BBA57DC4B82::getequipmentslotammo(slot) == 0)
      return 1;

    if(_id_531CB1BE084314F7::pickupissameasequipmentslot(equipname, slot)) {
      if(_id_531CB1BE084314F7::equipmentslothasroom(pickup.scriptablename, slot))
        return 1;
      else if(_id_8B121DD10A442DD2())
        return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup, isautouse);
      else
        return 4;
    }

    if(_id_8B121DD10A442DD2())
      return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup, isautouse);

    if(!_id_8B121DD10A442DD2())
      return 1;

    if(!canslotitem(pickup.scriptablename, _id_E52A49E4832AC060))
      return 4;
    else
      return 1;
  }

  if(_id_531CB1BE084314F7::isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit)
      return 11;

    return 1;
  }

  if(_id_531CB1BE084314F7::isgasmask(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    if(self _meth_C6CB3E654225077A() && isautouse && scripts\cp_mp\gasmask::hasgasmask(self))
      return 12;

    return 1;
  }

  if(_id_531CB1BE084314F7::_id_6B5F3FB6550AE6D5(pickup.scriptablename)) {
    if(_id_8B121DD10A442DD2()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      result = _id_E01D9736B2D100AC(lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    return 1;
  }

  if(_id_531CB1BE084314F7::isquesttablet(pickup.scriptablename)) {
    if(pickup.scriptablename == "brloot_blueprintextract_tablet")
      return 1;
    else {
      _id_9CF0B8C1BE24C64D = undefined;

      if(getdvarint("dvar_82BDE055B11E6698", 0))
        _id_9CF0B8C1BE24C64D = scripts\engine\utility::array_contains(level.questinfo.teamsonquests, self.team);
      else
        _id_9CF0B8C1BE24C64D = _id_531CB1BE084314F7::_id_7094C7010C5E3827(self.team);

      if(_id_9CF0B8C1BE24C64D)
        return 10;
      else
        return 1;
    }
  }

  if(_id_531CB1BE084314F7::isperkpointpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self._id_CA56839B2E00EDCE))
      return 16;

    return 1;
  }

  if(_id_531CB1BE084314F7::_id_362D5A8D49B93721(pickup.scriptablename)) {
    if(isDefined(level._id_6A2EAC0EF4A956CB))
      return [[level._id_6A2EAC0EF4A956CB]](self, pickup);

    return 20;
  }

  if(_id_531CB1BE084314F7::istokenpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self._id_CA56839B2E00EDCE))
      return 16;

    if(pickup.scriptablename == "brloot_respawn_token") {
      if(_id_531CB1BE084314F7::hasrespawntoken())
        return 8;
      else
        return 1;
    }

    return 1;
  }

  if(_id_531CB1BE084314F7::isrevivepickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self._id_CA56839B2E00EDCE))
      return 16;

    if(pickup.scriptablename == "brloot_self_revive") {
      if(_id_0AFB7E332AEE4BF2::hasselfrevivetoken())
        return 14;
      else
        return 1;
    }

    return 1;
  }

  if(_id_531CB1BE084314F7::iskillstreak(pickup.scriptablename)) {
    _id_A4E8372932B8612C = level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename];

    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    if(istrue(_id_531CB1BE084314F7::_id_A7CC24F3A189746A(_id_A4E8372932B8612C))) {
      if(_id_A4E8372932B8612C == "circle_peek") {
        if(!isDefined(level.teamswithcirclepeek[self.team]))
          level.teamswithcirclepeek[self.team] = 0;

        _id_2C18D9BE706D7AD7 = level.teamswithcirclepeek[self.team] + level.br_circle.circleindex + 1;

        if(_id_2C18D9BE706D7AD7 >= level.circlepeeks.size)
          return 19;
      }

      return 1;
    }

    if(_id_2669878CF5A1B6BC::iskillstreakweapon(self getcurrentweapon()))
      return 7;

    if(_id_8B121DD10A442DD2() && _id_531CB1BE084314F7::_id_D674D32C2D3BA5ED(self)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      result = _id_E01D9736B2D100AC(lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename])
      return 7;
    else if(self _meth_C6CB3E654225077A() && isautouse && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size != 0)
      return 12;
    else
      return 1;
  }

  if(_id_531CB1BE084314F7::issuperpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !istrue(self._id_CA56839B2E00EDCE))
      return 16;

    if(!_id_56EF8D52FE1B48A1::issuperinuse()) {
      _id_0C89F07DA007FF0D = _id_7EF95BBA57DC4B82::getequipmentslotammo("super");

      if(self _meth_C6CB3E654225077A() && isautouse && isDefined(_id_0C89F07DA007FF0D) && _id_0C89F07DA007FF0D != 0)
        return 12;
      else if(scripts\cp\utility::getsubgametype() != "dmz" && scripts\cp\utility::getsubgametype() != "exgm" || (!isDefined(_id_0C89F07DA007FF0D) || _id_0C89F07DA007FF0D == 0))
        return 1;
    }

    if(_id_8B121DD10A442DD2()) {
      if(_id_531CB1BE084314F7::_id_5E7049647595AB97() || _id_56EF8D52FE1B48A1::issuperinuse()) {
        result = _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup);

        if(result == 4 && !_id_56EF8D52FE1B48A1::issuperinuse())
          return 1;
        else
          return result;
      }
    }

    return 4;
  }

  if(_id_531CB1BE084314F7::isarmor(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    if(_id_07C40FA80892A721::_id_CD4A78B4A236DDC8(level.br_pickups.br_equipname[pickup.scriptablename]))
      return 1;
    else
      return 6;
  }

  if(_id_531CB1BE084314F7::_id_4294E9B331377C31(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    if(_id_8B121DD10A442DD2()) {
      pickup.scriptablename = "brloot_armor_plate";
      pickup.count = 8;
      return _id_531CB1BE084314F7::_id_99AB09BA7022D107(pickup);
    }

    if(_id_531CB1BE084314F7::hasplatepouch())
      return 15;

    return 1;
  }

  if(_id_531CB1BE084314F7::isaccesscard(pickup.scriptablename)) {
    if(_id_8B121DD10A442DD2())
      return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_531CB1BE084314F7::_id_233D8364992B23B4(pickup.scriptablename)) {
    if(_id_8B121DD10A442DD2())
      return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup);
  }

  if(_id_531CB1BE084314F7::_id_E066D6B70DDA15F1(pickup.scriptablename))
    return 1;

  if(_id_531CB1BE084314F7::_id_F262C137ED78E6EB(pickup.scriptablename))
    return 1;

  if(_id_531CB1BE084314F7::_id_82D45592D750D388(pickup.scriptablename)) {
    if(_id_8B121DD10A442DD2()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      index = _id_531CB1BE084314F7::_id_E05897F5D860188E(lootid, pickup.count, 0);

      if(isDefined(index)) {
        _id_E5FE6C50EC351711 = _id_531CB1BE084314F7::_id_6738846DA50730F1(index);

        if(isDefined(_id_E5FE6C50EC351711) && isDefined(_id_E5FE6C50EC351711[1]) && _id_E5FE6C50EC351711[1] > 2)
          return 23;
      }

      return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(_id_531CB1BE084314F7::_id_F92615E29AFF3602(pickup.scriptablename)) {
    if(isDefined(pickup.instance.team) && self.team == pickup.instance.team)
      return 1;
    else
      return 4;
  }

  if(_id_531CB1BE084314F7::_id_32125EBA262380C7(pickup.scriptablename)) {
    if(isDefined(level._id_D8DB1602C8BF473E) && isDefined(level._id_D8DB1602C8BF473E[pickup.scriptablename])) {
      result = [[level._id_D8DB1602C8BF473E[pickup.scriptablename]]](pickup, self);

      if(isDefined(result))
        return result;
    }

    return 1;
  }

  if(pickup.scriptablename == "brloot_ammo_grenade") {
    if(istrue(self.isjuggernaut) && self getclientomnvar("ui_assault_suit_on") == 0)
      return 16;

    _id_F2B2C8DE93EBF806 = _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");
    _id_E93897BC10C40746 = _id_7EF95BBA57DC4B82::getequipmentslotammo("secondary");

    if(isDefined(_id_F2B2C8DE93EBF806) && _id_F2B2C8DE93EBF806 < 2 || isDefined(_id_E93897BC10C40746) && _id_E93897BC10C40746 < 2)
      return 1;
    else
      return 3;
  }

  if(pickup.scriptablename == "Pillage_Cache")
    return 1;

  if(_id_531CB1BE084314F7::_id_609BB538ED61B8D7(pickup.scriptablename))
    return 22;

  if(_id_531CB1BE084314F7::_id_7E2F2A69FC0C022B(pickup.scriptablename) || _id_531CB1BE084314F7::_id_EAC097CE4C683AB9(pickup.scriptablename) || _id_531CB1BE084314F7::_id_CB1E30930C35F2E2(pickup.scriptablename) || _id_531CB1BE084314F7::_id_5449DA9D3D0358A4(pickup.scriptablename)) {
    if(_id_8B121DD10A442DD2())
      return _id_531CB1BE084314F7::_id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_531CB1BE084314F7::_id_4AA12E0ED3F6B745(pickup.scriptablename)) {
    _id_0E9CFD120B0B43EF = _id_531CB1BE084314F7::_id_692C3DF266580DF6(pickup.scriptablename);

    if(self._id_BED158A6DFAC230D < _id_0E9CFD120B0B43EF)
      return 1;
    else if(self._id_BED158A6DFAC230D == _id_0E9CFD120B0B43EF)
      return 25;
    else
      return 26;
  }

  return 2;
}

_id_8C58CD733DFC8CCE(weaponname) {
  if(!isDefined(weaponname))
    return 0;

  switch (weaponname) {
    case "iw9_pi_stimpistol_mp":
      return 1;
    default:
      return 0;
  }
}

_id_D381554FDC8CDFA3() {
  _id_89162A7340BA32F3 = self getcurrentweapon();
  _id_A4EFD2B2FB2298D2 = _id_2669878CF5A1B6BC::getweaponrootname(_id_89162A7340BA32F3);

  switch (_id_A4EFD2B2FB2298D2) {
    case "iw8_me_akimboblunt":
    case "iw8_me_akimboblades":
      return 0;
    default:
      return 1;
  }
}

_id_D3E48C0B2FEBBECA() {
  weapon = self getcurrentweapon();
  _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(weapon);
  result = br_ammo_type_player_full(self, _id_811ABFDB6C33F17F);
  return result;
}

getequipmentslotammo(slot) {
  ref = _id_7EF95BBA57DC4B82::getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  return getequipmentammo(ref);
}

getcurrentequipment(slot) {
  if(!isDefined(self.equipment))
    return undefined;

  return self.equipment[slot];
}

getequipmentammo(ref) {
  _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F)) {
    ref = _id_F16F02E6C6FF945A(ref);
    _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  }

  if(!isDefined(_id_8BF83D28BE4C2D4F)) {
    ref = _id_F16F02E6C6FF945A(ref);
    _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  }

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  return self getammocount(_id_8BF83D28BE4C2D4F.objweapon);
}

_id_F16F02E6C6FF945A(_id_019CD48B2DAF2547) {
  switch (_id_019CD48B2DAF2547) {
    case "power_semtex":
      return "equip_semtex";
    case "power_frag":
      return "equip_frag";
    case "power_molotov":
      return "equip_molotov";
    case "power_claymore":
      return "equip_claymore";
    case "power_throwingKnife":
      return "equip_throwing_knife";
    case "power_throwingKnife_fire":
      return "equip_throwing_knife_fire";
    case "power_c4":
      return "equip_c4";
    case "power_thermite":
      return "equip_thermite";
    case "power_smokeGrenade":
      return "equip_smoke";
    case "power_flash":
      return "equip_flash";
    case "power_stun":
      return "equip_concussion";
    case "power_snapshotGrenade":
      return "equip_snapshot_grenade";
    default:
      return _id_019CD48B2DAF2547;
  }
}

_id_63699875D9ACA328(power_name) {
  switch (power_name) {
    case "power_semtex":
      return "brloot_offhand_semtex";
    case "power_frag":
      return "brloot_offhand_frag";
    case "power_molotov":
      return "brloot_offhand_molotov";
    case "power_claymore":
      return "brloot_offhand_claymore";
    case "power_throwingKnife":
      return "brloot_offhand_throwingknife";
    case "power_throwingKnife_fire":
      return "brloot_offhand_throwingknife_fire";
    case "power_c4":
      return "brloot_offhand_c4";
    case "power_smokeGrenade":
      return "brloot_offhand_smoke";
    case "power_flash":
      return "brloot_offhand_flash";
    case "power_stun":
      return "brloot_offhand_concussion";
    case "power_thermite":
      return "brloot_offhand_thermite";
    default:
      return undefined;
  }
}

_id_A8E35C2FA66DAFD4(_id_019CD48B2DAF2547) {
  switch (_id_019CD48B2DAF2547) {
    case "equip_semtex":
      return "power_semtex";
    case "equip_frag":
      return "power_frag";
    case "equip_molotov":
      return "power_molotov";
    case "equip_claymore":
      return "power_claymore";
    case "equip_throwing_knife":
      return "power_throwingKnife";
    case "equip_throwing_knife_fire":
      return "power_throwingKnife_fire";
    case "equip_c4":
      return "power_c4";
    case "equip_thermite":
      return "power_thermite";
    case "equip_snapshot_grenade":
      return "power_snapshotGrenade";
    case "equip_smoke":
      return "power_smokeGrenade";
    default:
      return _id_019CD48B2DAF2547;
  }
}

_id_E1C4715FB39996E7(_id_019CD48B2DAF2547) {
  switch (_id_019CD48B2DAF2547) {
    case "power_semtex":
    case "equip_semtex":
      return "semtex_mp";
    case "power_frag":
    case "equip_frag":
      return "frag_grenade_mp";
    case "equip_molotov":
    case "power_molotov":
      return "molotov_mp";
    case "power_claymore":
    case "equip_claymore":
      return "claymore_mp";
    case "power_throwingKnife":
    case "equip_throwing_knife":
      return "throwingknife_mp";
    case "power_throwingKnife_fire":
    case "equip_throwing_knife_fire":
      return "throwingknife_fire_mp";
    case "equip_c4":
    case "power_c4":
      return "c4_mp";
    case "power_thermite":
    case "equip_thermite":
      return "thermite_mp";
    default:
      return _id_019CD48B2DAF2547;
  }
}

getequipmenttableinfo(ref) {
  return level.equipment.table[ref];
}

incrementequipmentslotammo(slot, _id_930290D7F474A0AE) {
  ref = _id_7EF95BBA57DC4B82::getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_3DBC3B058135CBFB = _id_7EF95BBA57DC4B82::getequipmentammo(ref);
  _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB + _id_930290D7F474A0AE, _id_7EF95BBA57DC4B82::getequipmentmaxammo(ref)));
  _id_7EF95BBA57DC4B82::setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
}

getequipmentmaxammo(ref) {
  _id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    maxammo = scripts\cp\utility::_id_ED18A118C6FA5C4F(_id_8BF83D28BE4C2D4F.objweapon);

    switch (ref) {
      case "equip_binoculars":
      case "equip_hb_sensor":
      case "equip_tac_cover":
        break;
      default:
        maxammo--;
        break;
    }

    slot = findequipmentslot(ref);
  } else {
    _id_F4692D0892428480 = level.br_pickups.br_equipnametoscriptable[_id_8BF83D28BE4C2D4F.ref];
    maxammo = level.br_pickups.maxcounts[_id_F4692D0892428480];

    if(!isDefined(maxammo))
      maxammo = 0;

    if(ref == "equip_armorplate") {
      if(_id_531CB1BE084314F7::hasplatepouch())
        maxammo = maxammo + getdvarint("dvar_A5AB8ED6CC1B486A", 3);
    }
  }

  return maxammo;
}

findequipmentslot(ref) {
  if(!isDefined(self.equipment))
    return undefined;

  foreach(slot, _id_F03830BD1CD0CF91 in self.equipment) {
    if(_id_F03830BD1CD0CF91 == ref)
      return slot;
  }
}

canholdammobox(scriptablename, weapon) {
  if(isDefined(weapon)) {
    if(weapon.basename == "iw9_me_knife_mp")
      return 0;
  }

  if(!isDefined(self.br_ammo[scriptablename]))
    return 1;

  return !br_ammo_type_player_full(self, scriptablename);
}

registerpickupcreatedcallback(_id_C9C301A888170672, callback) {
  level.br_pickups.createcallbacks[_id_C9C301A888170672] = callback;
}

isweaponpickupitem(item) {
  if(!isDefined(item))
    return 0;

  if(isDefined(item.weapon))
    return istrue(item.weapon.iscustomweapon);
  else if(isDefined(item.scriptablename))
    return _id_531CB1BE084314F7::isweaponpickup(item.scriptablename);

  return 0;
}

initscriptablemanagement() {
  _id_962A30A9BB8C0F09 = level.br_pickups;
  _id_962A30A9BB8C0F09.scriptables = [];
  _id_962A30A9BB8C0F09.scriptablesstartid = 0;
  _id_962A30A9BB8C0F09.scriptablescurid = 0;
  _id_962A30A9BB8C0F09.scriptablesmax = getdvarint("scr_br_pickupscriptablesmax", 750);
  _id_962A30A9BB8C0F09.scriptablescleanupbatchsize = getdvarint("dvar_1E71982A0A539739", 10);
}

_id_9BDDCF74474466B1() {
  wait 10;
  _id_CB4FAD49263E20C4 = getitemdropinfo(level.players[0].origin, level.players[0].angles);
  item = spawnpickup("brloot_self_revive", _id_CB4FAD49263E20C4);
}

br_ammo_init() {
  if(istrue(level._id_FCD1AE93F5209B41)) {
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
  level._id_E6EA72FC5E3FCD00 = [];
  level._id_E6EA72FC5E3FCD00["brloot_ammo_919"] = 150;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_12g"] = 40;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_762"] = 180;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_50cal"] = 40;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_rocket"] = 6;
  level._id_FCD1AE93F5209B41 = 1;
}

_id_195F5055031AD0CB() {
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  if(!isDefined(self.plunderbanked))
    self.plunderbanked = 0;

  if(!isDefined(self.haspickedupplunderyet))
    self.haspickedupplunderyet = 0;

  if(self.plundercount == 0)
    thread _id_531CB1BE084314F7::playersetplundercount(0);
}

_id_24EA0B21194D20CE() {
  level.br_plunder = spawnStruct();
  level.br_plunder.plunderlimit = 65535;
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

initteamdatafields() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["plunderTeamTotal"] = 0;
    level.teamdata[team]["plunderInDeposit"] = 0;
    level.teamdata[team]["plunderBanked"] = 0;
  }

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
    foreach(team in level.teamnamelist) {
      level.teamdata[team]["tokensTeamTotal"] = 0;
      level.teamdata[team]["tokensInDeposit"] = 0;
      level.teamdata[team]["tokensBanked"] = 0;
    }
  }
}

setupquantities() {
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

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder.names.size; _id_AC0E594AC96AA3A8++) {
    level.br_plunder.quantity[_id_AC0E594AC96AA3A8] = level.br_pickups.counts[level.br_plunder.names[_id_AC0E594AC96AA3A8]];

    if(isDefined(level.br_plunder.quantity[_id_AC0E594AC96AA3A8 - 1])) {}
  }
}

initplayerplunderevents() {
  omnvars = [];
  omnvars[1] = "ui_cash_pickedup";
  omnvars[2] = "ui_cash_pickedup";
  level.playerplundereventomnvars = omnvars;
  callbacks = [];
  callbacks[1] = ::playerplunderpickupcallback;
  callbacks[4] = ::playerplunderlosecallback;
  level.playerplundereventcallbacks = callbacks;
}

_id_52DB16C0F1B89F36() {
  initplayer();
  thread _id_461334C52833C744();
  thread br_ammo_player_hud_monitor();

  if(!scripts\cp\utility::gameflag("prematch_done")) {
    _id_509D86412C9D7426 = self getweaponslistprimaries();

    foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
      _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);

      if(isDefined(_id_44C97DCE6932DE3C))
        self setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C);
    }
  }

  foreach(ammotype in level.br_ammo_types)
  self.br_ammo[ammotype] = 0;

  br_ammo_update_weapons();
  br_ammo_player_hud_update_ammotype("brloot_ammo_919");
  br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
  br_ammo_player_hud_update_ammotype("brloot_ammo_762");
  br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
  br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
}

initplayer(_id_756150045B2B7AD8) {
  br_ammo_player_clear();
  resetplayerinventory(_id_756150045B2B7AD8);
}

br_ammo_player_clear() {
  foreach(ammotype in level.br_ammo_types)
  self.br_ammo[ammotype] = 0;

  self notify("ammo_update");
}

resetplayerinventory(_id_9E83064E74FA428C) {
  self.br_inventory_slots = [];

  if(!istrue(_id_9E83064E74FA428C)) {}

  if(scripts\cp\utility::has_auto_revive())
    removeselfrevivetoken();
}

br_ammo_player_hud_update_ammotype(ammotype, _id_D2B0C34470701882) {
  _id_047905BF82C80D97 = 0;

  if(_id_8B121DD10A442DD2()) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
    _id_5BAAA0CE73D6FE84(self);
  }

  if(isDefined(level.br_ammo_omnvars[ammotype]))
    self setclientomnvar(level.br_ammo_omnvars[ammotype], self.br_ammo[ammotype] + _id_047905BF82C80D97);
}

_id_461334C52833C744() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");

    if(!isDefined(self)) {
      return;
    }
    objweapon = self getcurrentweapon();
    _id_8BB6EB01FCDE5851 = self getweaponammoclip(objweapon);
    _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(objweapon);

    if(!isDefined(_id_811ABFDB6C33F17F)) {
      continue;
    }
    br_wait_for_complete_reload();

    if(!isDefined(self)) {
      return;
    }
    if(objweapon != self getcurrentweapon()) {
      continue;
    }
    _id_7FF630BFBCA7B961 = self.br_ammo[_id_811ABFDB6C33F17F];

    if(!getdvarint("dvar_59A26F9BD4367B8D", istrue(level.prematchinfinitammo)) || scripts\mp\flags::gameflag("prematch_done"))
      _id_7FF630BFBCA7B961 = self getweaponammostock(objweapon);

    br_ammo_update_ammotype_weapons(self, _id_811ABFDB6C33F17F, _id_7FF630BFBCA7B961);

    if(getdvarint("dvar_11A55F76D25D5BD5", 0) && isDefined(self.br_ammo[_id_811ABFDB6C33F17F]) && self.br_ammo[_id_811ABFDB6C33F17F] <= 0) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_811ABFDB6C33F17F);

      if(isDefined(lootid))
        scripts\cp_mp\calloutmarkerping::_id_1CED737A22161A49(22, lootid);
    }
  }
}

br_wait_for_complete_reload(objweapon) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self isreloading())
    waitframe();
}

br_ammo_update_ammotype_weapons(player, ammotype, _id_23C054F415636C51) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();
  _id_A9BC5314D494806D = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && ammotype == _id_7CAC4FF8E11F1BCA) {
      if(_id_531CB1BE084314F7::_id_6B531C76815D77F3(ammotype) && !_id_A9BC5314D494806D) {
        _id_EFB882BF4F27EE85 = level._id_E6EA72FC5E3FCD00[ammotype] - _id_23C054F415636C51;
        lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
        _id_750FCC188317845A = [];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_531CB1BE084314F7::_id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
          if(player _id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8) == lootid)
            _id_750FCC188317845A[_id_AC0E594AC96AA3A8] = player _id_531CB1BE084314F7::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
        }

        _id_2C20EA06F37F490A = tablesort(_id_750FCC188317845A, "up");

        foreach(index in _id_2C20EA06F37F490A) {
          _id_E30B916ADC1E2DC8 = player _id_531CB1BE084314F7::_id_897B29ADB37F06A7(index);

          if(_id_EFB882BF4F27EE85 <= _id_E30B916ADC1E2DC8) {
            _id_531CB1BE084314F7::_id_DB1DD76061352E5B(index, _id_EFB882BF4F27EE85);
            _id_EFB882BF4F27EE85 = 0;
            break;
          }

          _id_EFB882BF4F27EE85 = _id_EFB882BF4F27EE85 - _id_E30B916ADC1E2DC8;
          _id_531CB1BE084314F7::_id_DB1DD76061352E5B(index, _id_E30B916ADC1E2DC8);
        }

        _id_23C054F415636C51 = _id_23C054F415636C51 + (level._id_E6EA72FC5E3FCD00[ammotype] - _id_23C054F415636C51 - _id_EFB882BF4F27EE85);
      }

      _id_23C054F415636C51 = get_int_or_0(_id_23C054F415636C51);
      player _id_4906C10C3FFDD4CA(_id_DE88CD14114C1E24, _id_23C054F415636C51);
      self.br_ammo[ammotype] = min(_id_23C054F415636C51, level._id_E6EA72FC5E3FCD00[ammotype]);
      self.br_ammo[ammotype] = get_int_or_0(self.br_ammo[ammotype]);
      _id_A9BC5314D494806D = 1;
    }
  }

  player notify("ammo_update");
}

_id_4906C10C3FFDD4CA(weapon, stock_ammo, _id_2B2365BAD962F899) {
  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber"))
    self setweaponammostock(weapon, 0);
  else if(scripts\cp\cp_relics::is_relic_active("relic_rocket_kill_ammo"))
    return;
  else if(istrue(_id_2B2365BAD962F899))
    self setweaponammostock(weapon, stock_ammo);
  else {
    ammotype = br_ammo_type_for_weapon(weapon);
    _id_89F473B8328B7973 = get_int_or_0(self.br_ammo[ammotype]);

    if(istrue(weapon.isalternate) && !isDefined(weapon.underbarrel)) {
      return;
    }
    self setweaponammostock(weapon, _id_89F473B8328B7973);
  }
}

br_ammo_player_hud_monitor() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_5("ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");
    _id_4A1B6EE7B6A82FB5 = self _meth_B2ED366433A3D074();

    if(isDefined(_id_4A1B6EE7B6A82FB5)) {
      ammotype = br_ammo_type_for_weapon(_id_4A1B6EE7B6A82FB5);

      if(isDefined(ammotype)) {
        _id_5B3F7D686C59AB97 = get_int_or_0(self.br_ammo[ammotype]);
        _id_4906C10C3FFDD4CA(_id_4A1B6EE7B6A82FB5, _id_5B3F7D686C59AB97);
      }
    } else {
      weapon = self getcurrentweapon();

      if(isDefined(weapon) && !isnullweapon(weapon)) {
        ammotype = br_ammo_type_for_weapon(weapon);

        if(isDefined(ammotype)) {
          _id_5B3F7D686C59AB97 = get_int_or_0(self.br_ammo[ammotype]);
          _id_4906C10C3FFDD4CA(weapon, _id_5B3F7D686C59AB97);
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

_id_45B39E34D0BEB8CB(result) {
  _id_509D86412C9D7426 = self.primaryweapons;
  _id_89162A7340BA32F3 = self.currentprimaryweapon;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(ammotype)) {
      _id_5B3F7D686C59AB97 = get_int_or_0(self.br_ammo[ammotype]);

      if(br_ammo_type_player_full(self, ammotype)) {
        br_ammo_give_type(self, ammotype, _id_5B3F7D686C59AB97, 0);
        _id_C5C058C71CFC237A(self, ammotype, _id_5B3F7D686C59AB97);
      }
    }
  }

  ammotype = br_ammo_type_for_weapon(_id_89162A7340BA32F3);

  if(isDefined(ammotype)) {
    _id_5B3F7D686C59AB97 = get_int_or_0(self.br_ammo[ammotype]);
    _id_4906C10C3FFDD4CA(_id_89162A7340BA32F3, _id_5B3F7D686C59AB97);
  }
}

_id_C5C058C71CFC237A(player, ammotype, amount) {
  player.br_ammo[ammotype] = player.br_ammo[ammotype] + amount;

  if(player.br_ammo[ammotype] > level._id_E6EA72FC5E3FCD00[ammotype])
    player.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];
}

_id_7A302A314424968F(_id_E3108E412AFB3811) {
  level.clearstockondrop = _id_E3108E412AFB3811;
}

_id_44055A11FFDCC17E() {
  self.br_ammo["brloot_ammo_919"] = 0;
  self.br_ammo["brloot_ammo_12g"] = 0;
  self.br_ammo["brloot_ammo_762"] = 0;
  self.br_ammo["brloot_ammo_50cal"] = 0;
  self.br_ammo["brloot_ammo_rocket"] = 0;
  self.br_ammo["brloot_ammo_mike32"] = 0;
}

_id_34DC33AF893513B2(amount, _id_56218893A21367E0) {
  if(amount >= 5000)
    drop_type = "brloot_plunder_cash_rare_1";
  else if(amount >= 2000)
    drop_type = "brloot_plunder_cash_uncommon_2";
  else if(amount >= 1000)
    drop_type = "brloot_plunder_cash_uncommon_1";
  else
    drop_type = "brloot_plunder_cash_common_1";

  if(!isDefined(_id_56218893A21367E0))
    _id_56218893A21367E0 = 0;

  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_56218893A21367E0, self.origin, self.angles, self);
  item = spawnpickup(drop_type, _id_CB4FAD49263E20C4, int(amount), 1, undefined, 1);
}

_id_5CFF081D620D2EF3() {
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles, self);
  _id_7643BB9BACEC0071 = ["brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_50cal", "brloot_ammo_12g", "brloot_ammo_rocket"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7643BB9BACEC0071.size; _id_AC0E594AC96AA3A8++) {
    if(_id_116171939929AF39::_id_C5251179824F0DEB(_id_7643BB9BACEC0071[_id_AC0E594AC96AA3A8])) {
      count = _id_116171939929AF39::_id_F9C71B46B5E50150(_id_7643BB9BACEC0071[_id_AC0E594AC96AA3A8], _id_116171939929AF39::_id_93F256198133479F(_id_7643BB9BACEC0071[_id_AC0E594AC96AA3A8]));
      item = spawnpickup(_id_7643BB9BACEC0071[_id_AC0E594AC96AA3A8], _id_CB4FAD49263E20C4, count, 1, undefined, 1);
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles, self);
    }
  }
}

_id_C78E977650C14D64() {
  _id_06FE80416B4BE165 = getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);

  if(isDefined(self.copy_fullweaponlist)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.copy_fullweaponlist.size; _id_AC0E594AC96AA3A8++) {
      if(_id_B3B99F9F9371C997(self.copy_fullweaponlist[_id_AC0E594AC96AA3A8])) {
        weaponspawn(self.copy_fullweaponlist[_id_AC0E594AC96AA3A8], self, _id_06FE80416B4BE165, 0, 1);
        _id_06FE80416B4BE165 = getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);
      }
    }
  } else if(isDefined(self.primaryweapons)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
      if(_id_B3B99F9F9371C997(self.primaryweapons[_id_AC0E594AC96AA3A8])) {
        weaponspawn(self.primaryweapons[_id_AC0E594AC96AA3A8], self, _id_06FE80416B4BE165, 0, 1);
        _id_06FE80416B4BE165 = getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);
        scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]);
      }
    }
  }
}

_id_4172A10AE7CBDB41(weaponobj) {
  ammotype = br_ammo_type_for_weapon(weaponobj);
  amount = _id_A5408E1D8E88137C(weaponobj);
  br_ammo_give_type(self, ammotype, amount, 0);
}

_id_A5408E1D8E88137C(weaponobj) {
  ammotype = br_ammo_type_for_weapon(weaponobj);

  if(isDefined(ammotype)) {
    _id_D8F2CB467E2AF5CD = _id_ECDFC73E68DCC209(ammotype);

    if(isDefined(_id_D8F2CB467E2AF5CD)) {
      return _id_D8F2CB467E2AF5CD;
      return;
    }

    return weaponmaxammo(weaponobj);
    return;
  } else
    return weaponmaxammo(weaponobj);
}

_id_ECDFC73E68DCC209(ammotype) {
  if(isDefined(level._id_E6EA72FC5E3FCD00[ammotype]))
    return level._id_E6EA72FC5E3FCD00[ammotype];
  else
    return undefined;
}

_id_F0A8D592BDDE9818() {
  self setclientomnvar("ui_force_close_inventory", 1);
  self setclientomnvar("open_inventory", 0);
  self._id_BD00788011A0F6C6 = 0;
}

_id_410042DC2CC03264() {
  self setclientomnvar("ui_force_close_inventory", 0);
  self setclientomnvar("open_inventory", 1);
  self._id_BD00788011A0F6C6 = 1;
}

dropbrequipment(_id_7F437A5779C8787C, _id_1E736A37C3737585, equipmentref) {
  _id_65CAD465FD8E737C = 7;
  _id_11F2059012065537 = istrue(_id_1E736A37C3737585) && isDefined(equipmentref);

  if(_id_11F2059012065537) {
    _id_1A37FA6C580BB395 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, equipmentref);

    if(isDefined(_id_1A37FA6C580BB395)) {
      _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_65CAD465FD8E737C, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
      item = spawnpickup(_id_1A37FA6C580BB395, _id_CB4FAD49263E20C4, 1, 1, undefined, isalive(self));
      _id_2F4E0022C686DBE6(item);
    }

    return;
  }

  if(isDefined(self.equipment["primary"])) {
    ammocount = _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");

    if(ammocount > 0) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["primary"]);

      if(isDefined(_id_FEB782334DD23A66)) {
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_65CAD465FD8E737C, self.origin, self.angles, self);
        _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_091F6B5DD6FA6844", 0);
        item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
        _id_2F4E0022C686DBE6(item);
      }

      _id_65CAD465FD8E737C++;
    }
  }

  if(isDefined(self.equipment["secondary"])) {
    ammocount = _id_7EF95BBA57DC4B82::getequipmentslotammo("secondary");

    if(ammocount > 0) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["secondary"]);

      if(isDefined(_id_FEB782334DD23A66)) {
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_65CAD465FD8E737C, self.origin, self.angles, self);
        _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("scr_br_allow_auto_pickup_dropped_tactical_gadgets", 0);
        item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
        _id_2F4E0022C686DBE6(item);
      }

      _id_65CAD465FD8E737C++;
    }
  }
}

_id_1A8066CCDB91C1D1() {
  if(isDefined(level._id_D03E6BA38B56B4AB) && istrue(level._id_D03E6BA38B56B4AB))
    return level._id_FB60F0244999D528;

  return 0;
}

_id_2F4E0022C686DBE6(item) {
  if(!scripts\cp_mp\utility\player_utility::isreallyalive(self) && isDefined(item))
    self._id_D2DBB2FA012E6D9C[item.type] = item;
}

_id_B1DD9DCAE2F63965() {
  return getdvarint("dvar_1445BEA2674012B9", 0);
}

_id_B9DA718E50063452() {
  if(isDefined(level.br_pickups._id_C9015F26F73062A0)) {
    return;
  }
  level.br_pickups._id_C9015F26F73062A0 = [];
  thread _id_0A856FC2139EEF0C(15);
}

_id_AC3EC31BE7AAD7A7(_id_08488A6AF29DE20A) {
  _id_B9DA718E50063452();
  _id_712A14F78C75A0C2 = level.br_pickups._id_C9015F26F73062A0[self.guid];

  if(isDefined(_id_712A14F78C75A0C2)) {
    foreach(_id_C544EDC003A91D23 in _id_712A14F78C75A0C2.array) {
      if(_id_C544EDC003A91D23 == _id_08488A6AF29DE20A.index) {
        _id_712A14F78C75A0C2._id_52FCFE909C72DB5B = gettime();
        return 1;
      }
    }
  }

  return 0;
}

_id_0A856FC2139EEF0C(_id_FE0750B31604C691) {
  level endon("game_ended");

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_342CB0D14D88D2AB = getdvarint("dvar_5EFF4677B208A6B8", 45000);

    foreach(key, _id_712A14F78C75A0C2 in level.br_pickups._id_C9015F26F73062A0) {
      if(_id_6B7BEE46F2C6DA28 - _id_712A14F78C75A0C2._id_52FCFE909C72DB5B >= _id_342CB0D14D88D2AB)
        level.br_pickups._id_C9015F26F73062A0[key] = undefined;
    }

    if(getdvarint("dvar_9723D1B7AB64DF07", 0))
      _id_C50D56273471BF54();

    wait(_id_FE0750B31604C691);
  }
}

_id_C50D56273471BF54() {
  _id_C215E2A76B873506 = 0;
  _id_96F1817624122314 = 0;

  foreach(_id_F4AE06A55C9C79DB in level.br_pickups._id_C9015F26F73062A0) {
    if(isDefined(_id_F4AE06A55C9C79DB)) {
      _id_96F1817624122314++;
      _id_C215E2A76B873506 = _id_C215E2A76B873506 + _id_F4AE06A55C9C79DB.array.size;
    }
  }
}

_id_10F6E537F1B5763C(lootid, pickup, _id_70E660487C2924EC, _id_75F83BDFFEDA824B) {
  if(!isDefined(lootid) || !isDefined(pickup)) {
    return;
  }
  if(!istrue(_id_75F83BDFFEDA824B) && issubstr(pickup.scriptablename, "brloot_ammo")) {
    return;
  }
  if(_id_03C17A26CE6A4668(lootid)) {
    index = _id_AE22C70A9C2474D9();

    if(!isDefined(index))
      return 0;

    _id_71E56BB092FD2574(lootid);
    thread _id_A0CCC23064473A05(index, lootid, pickup.count);
    return 0;
  } else if(_id_F6F8C1FC9549EAF6(lootid)) {}

  if(_id_531CB1BE084314F7::isammo(pickup.scriptablename)) {
    if(self.br_ammo[pickup.scriptablename] < level._id_E6EA72FC5E3FCD00[pickup.scriptablename]) {
      _id_03107C519D169A89 = level._id_E6EA72FC5E3FCD00[pickup.scriptablename] - self.br_ammo[pickup.scriptablename];

      if(istrue(pickup.isautouse) && _id_E44C2D69DB881894(pickup.scriptablename)) {
        self.br_ammo[pickup.scriptablename] = level._id_E6EA72FC5E3FCD00[pickup.scriptablename];
        br_ammo_player_hud_update_ammotype(pickup.scriptablename);
        br_ammo_update_weapons(self);
        quantity = pickup.count - _id_03107C519D169A89;
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(0, self.origin, self.angles, self, undefined);
        item = spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, quantity, 1, undefined, 0);
        return 0;
      } else {
        br_ammo_give_type(self, pickup.scriptablename, _id_03107C519D169A89);
        pickup.count = pickup.count - _id_03107C519D169A89;
      }
    }
  }

  quantity = _id_531CB1BE084314F7::_id_15308562FDA076AA(lootid, pickup);

  if(quantity > 0) {
    if(!istrue(_id_70E660487C2924EC)) {
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(0, self.origin, self.angles, self, undefined);
      item = spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, quantity, 1, undefined, 0);
      return 0;
    } else
      return quantity;
  }

  return 0;
}

_id_03C17A26CE6A4668(lootid) {
  return isDefined(lootid) && lootid == 8516;
}

_id_AE22C70A9C2474D9() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_E247454AC2869696; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == 0)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_71E56BB092FD2574(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  switch (type) {
    case "perk":
    case "field_upgrade":
    case "equipment":
    case "secondary":
    case "weapon":
    case "primary":
    case "super":
    case "killstreak":
    case "tactical":
    case "lethal":
      return;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onPickup"]) && isDefined(level._id_B33C035C483C2893["onPickup"][ref]))
        [[level._id_B33C035C483C2893["onPickup"][ref]]](self);

      return;
  }

  return;
}

_id_9F3A7767F1C1BD9E(lootid, index, quantity) {
  total = quantity;
  total = total + self getplayerdata("cp", "dmzBackpack", index, "quantity");
  thread _id_A0CCC23064473A05(index, lootid, total);
}

_id_91A0BAB850D7DB10(index, lootid, maxcount, _id_9610A859DB3F00CC, _id_E30B916ADC1E2DC8) {
  _id_F94E260AC3C6121E = _id_E30B916ADC1E2DC8 + _id_9610A859DB3F00CC - maxcount;
  thread _id_A0CCC23064473A05(index, lootid, maxcount);
  return _id_F94E260AC3C6121E;
}

_id_A0CCC23064473A05(index, lootid, quantity) {
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(!isDefined(quantity))
    quantity = 0;

  if(!isDefined(lootid) || lootid != 0 && quantity == 0)
    lootid = 0;

  self setplayerdata("cp", level._id_201C841C4668A94F, index, "lootID", lootid);
  self setplayerdata("cp", level._id_201C841C4668A94F, index, "quantity", quantity);

  if(quantity < 0) {
    self setplayerdata("cp", level._id_201C841C4668A94F, index, "lootID", 0);
    self setplayerdata("cp", level._id_201C841C4668A94F, index, "quantity", 0);
  }
}

_id_F6F8C1FC9549EAF6(lootid) {
  return isDefined(lootid) && lootid == 8358;
}

_id_E37CA8120DC19C6A() {
  return scripts\cp\utility::matchmakinggame() || getdvarint("force_ranking");
}

_id_C01EB7D2911F26E1(player, _id_0F53482EF48BDBA8) {
  if(!isDefined(_id_0F53482EF48BDBA8)) {
    return;
  }
  quantity = 0;
  _id_342175A1B9F9067E = _id_531CB1BE084314F7::_id_B13E35608B336D65(player);

  if(!isDefined(_id_342175A1B9F9067E) || _id_342175A1B9F9067E <= 0) {
    return;
  }
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_0F53482EF48BDBA8);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_E58EA7BE13F8D8A4 = player _id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_E58EA7BE13F8D8A4 == lootid)
      quantity++;
  }

  return quantity;
}

_id_F8D85C542911E3A9(player, _id_0F53482EF48BDBA8) {
  if(!isDefined(_id_0F53482EF48BDBA8)) {
    return;
  }
  _id_342175A1B9F9067E = _id_531CB1BE084314F7::_id_B13E35608B336D65(player);
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_0F53482EF48BDBA8);

  if(!isDefined(_id_342175A1B9F9067E) || _id_342175A1B9F9067E <= 0) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_E58EA7BE13F8D8A4 = player _id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_E58EA7BE13F8D8A4 == lootid)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_01A13107253C400D(_id_F2983979DD4F1FF0, _id_51BE4043D33594E7) {
  if(!isDefined(_id_51BE4043D33594E7._id_46A3A8565AC0C17C))
    _id_51BE4043D33594E7._id_46A3A8565AC0C17C = 2;

  _id_F2983979DD4F1FF0 playsoundtoplayer("cp_open_backpack", _id_F2983979DD4F1FF0);
  scripts\cp\loot_system::_id_30F5EA60517F9E06(_id_F2983979DD4F1FF0, _id_51BE4043D33594E7);
}

_id_37BE6E543436F3B3(lootid, origin) {
  pickup = spawnStruct();
  pickup.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  pickup.origin = origin;
  _id_EFDDDF60C5DB058C(pickup);
}

_id_EFDDDF60C5DB058C(pickupent, _id_A5B2C541413AA895) {
  _id_09D5BC8E32EE3635 = "br_pickup_generic";
  _id_DC382B1157307F94 = undefined;

  if(isDefined(pickupent.scriptablename)) {
    if(_id_531CB1BE084314F7::isplunder(pickupent.scriptablename))
      _id_09D5BC8E32EE3635 = getcashsoundaliasforplayer(self, pickupent.scriptablename);
    else if(isDefined(level.br_pickups.br_pickupsfx[pickupent.scriptablename]) && level.br_pickups.br_pickupsfx[pickupent.scriptablename].size > 0 && !(getdvarint("scr_br_skiplegendarypickupsound", 0) != 0 && level.br_pickups.br_pickupsfx[pickupent.scriptablename] == "br_legendary_loot_pickup"))
      _id_09D5BC8E32EE3635 = level.br_pickups.br_pickupsfx[pickupent.scriptablename];
    else if(isweaponpickupitem(pickupent))
      _id_09D5BC8E32EE3635 = "br_pickup_weap";
    else
      _id_09D5BC8E32EE3635 = "br_pickup_generic";

    if(isDefined(level.br_pickups.br_itemrow[pickupent.scriptablename]) && (istrue(level.br_pickups._id_0A5E4B146866D7FD[pickupent.scriptablename]) || _id_531CB1BE084314F7::isweaponpickup(pickupent.scriptablename) && getdvarint("dvar_68583A19A03DFDBC", 0))) {
      self _meth_8AC1BECB4519E28C(level.br_pickups.br_itemrow[pickupent.scriptablename], pickupent.count, 0);
      self notify("loot_collected");
    } else if(_id_531CB1BE084314F7::isplunder(pickupent.scriptablename))
      _id_DC382B1157307F94 = "br_plunder";
    else if(_id_531CB1BE084314F7::isammo(pickupent.scriptablename)) {
      switch (pickupent.scriptablename) {
        case "brloot_ammo_12g":
          _id_DC382B1157307F94 = "br_ammo_12g";
          break;
        case "brloot_ammo_50cal":
          _id_DC382B1157307F94 = "br_ammo_50cal";
          break;
        case "brloot_ammo_762":
          _id_DC382B1157307F94 = "br_ammo_762";
          break;
        case "brloot_ammo_919":
          _id_DC382B1157307F94 = "br_ammo_919";
          break;
        case "brloot_ammo_rocket":
          _id_DC382B1157307F94 = "br_ammo_rocket";
          break;
        default:
          _id_DC382B1157307F94 = "br_ammo";
          break;
      }
    } else if(_id_531CB1BE084314F7::isarmorplate(pickupent.scriptablename))
      _id_DC382B1157307F94 = "br_armor";
    else if(_id_531CB1BE084314F7::isequipment(pickupent.scriptablename)) {
      equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
      slot = level.equipment.table[equipname].defaultslot;

      if(slot != "health")
        _id_DC382B1157307F94 = "br_ammo";
    }
  }

  origin = pickupent.origin;

  if(!isDefined(origin))
    origin = self.origin;

  if(isDefined(origin))
    playsoundatpos(origin, _id_09D5BC8E32EE3635);

  if(isDefined(_id_DC382B1157307F94))
    _id_5762AC2F22202BA2::hudicontype(_id_DC382B1157307F94);

  if(!istrue(_id_A5B2C541413AA895))
    thread _id_630BB1E4FDF27C6C(pickupent);
}

_id_630BB1E4FDF27C6C(pickupent) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !_id_531CB1BE084314F7::playercanplaynotcriticalgesture()) {
    return;
  }
  _id_531CB1BE084314F7::_id_F4361EA8CE0FBCA4();
  playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
}

_id_D8CD9C1941A88194(lootid, quantity) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  _id_BADA25504E8844D7 = spawnStruct();
  _id_BADA25504E8844D7.scriptablename = scriptablename;
  _id_BADA25504E8844D7.origin = self.origin;
  _id_BADA25504E8844D7.maxcount = level.br_pickups.maxcounts[scriptablename];
  _id_BADA25504E8844D7.stackable = level.br_pickups.stackable[scriptablename];

  if(isweaponpickupitem(_id_BADA25504E8844D7) && _id_8B121DD10A442DD2()) {
    [ammo, _id_04F04B15053655BA, _id_35EAD47ED0D7507E] = _id_5C9E1BD30347CB36(level.br_lootiteminfo[scriptablename].fullweaponobj, 1);
    _id_BADA25504E8844D7.count = ammo;
    _id_BADA25504E8844D7.countlefthand = _id_04F04B15053655BA;
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_35EAD47ED0D7507E;
  } else {
    _id_BADA25504E8844D7.count = quantity;
    _id_BADA25504E8844D7.countlefthand = 0;
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = 0;
  }

  return _id_B5F5576A0017C089(_id_BADA25504E8844D7, "visible", self);
}

_id_5C9E1BD30347CB36(weapon, maxammo) {
  ammotype = br_ammo_type_for_weapon(weapon);
  _id_B7E1758E56028B63 = 100;

  if(isDefined(ammotype) && isDefined(level.br_pickups.counts[ammotype]))
    _id_B7E1758E56028B63 = level.br_pickups.counts[ammotype];

  _id_28AEBE3DD6733ED3 = scripts\engine\utility::ter_op(weaponclipsize(weapon) < _id_B7E1758E56028B63 || istrue(maxammo), weaponclipsize(weapon), _id_B7E1758E56028B63);
  _id_961012DD15FA29EE = 0;

  if(weapon.hasalternate) {
    _id_5D9B5B689A1846C8 = weapon getaltweapon();
    _id_961012DD15FA29EE = scripts\engine\utility::ter_op(weaponclipsize(_id_5D9B5B689A1846C8) < _id_B7E1758E56028B63 || istrue(maxammo), weaponclipsize(_id_5D9B5B689A1846C8), _id_B7E1758E56028B63);
  }

  return [_id_28AEBE3DD6733ED3, _id_28AEBE3DD6733ED3, _id_961012DD15FA29EE];
}

_id_54DAC56D15DD3D93(ref, lootid, quantity) {
  if(!isDefined(ref) || !isDefined(lootid) || !isDefined(quantity))
    return 0;

  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = ref;
  _id_60227BFF1E9478CC.count = quantity;
  result = _id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, canholdammobox(ref));

  if(result == 1) {
    _id_37BE6E543436F3B3(lootid);
    br_ammo_give_type(self, ref, quantity, 1);
    return 1;
  } else if(result == 20) {
    _id_37BE6E543436F3B3(lootid);
    _id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
    return 1;
  } else {
    showuseresultsfeedback(result);
    return 0;
  }
}

_id_F8A3FF0A73FA0C1D(pickup, _id_FB40D5954B4F6792) {
  if(!isDefined(pickup.scriptablename))
    return 28;

  _id_4BD6D680451253CC = 0;

  if(pickup.count + self.br_ammo[pickup.scriptablename] <= level._id_E6EA72FC5E3FCD00[pickup.scriptablename])
    _id_4BD6D680451253CC = 1;

  _id_2CA75F603DE25B76 = _id_D885E66811EE3A4D(pickup.scriptablename);

  if(_id_FB40D5954B4F6792 && _id_2CA75F603DE25B76 && _id_4BD6D680451253CC)
    return 1;

  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(pickup.scriptablename);
  result = _id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result) || _id_FB40D5954B4F6792 && self.br_ammo[pickup.scriptablename] < level._id_E6EA72FC5E3FCD00[pickup.scriptablename])
    return 20;

  return 4;
}

_id_D885E66811EE3A4D(_id_4CE224053F650637) {
  _id_509D86412C9D7426 = self getweaponslistprimaries();
  _id_2CA75F603DE25B76 = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_4CE224053F650637 == _id_7CAC4FF8E11F1BCA)
      return 1;
  }

  return 0;
}

_id_E01D9736B2D100AC(lootid, quantity) {
  if(!isDefined(lootid) || !isDefined(quantity))
    return undefined;

  result = undefined;

  if(!_id_03C17A26CE6A4668(lootid))
    result = _id_3D7E44B7E940DE24(lootid, quantity);
  else
    result = isDefined(_id_AE22C70A9C2474D9());

  return result;
}

_id_8A160D9935D47F5E(ref, type, quantity) {
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  return _id_E01D9736B2D100AC(lootid, quantity);
}

_id_9D094FAC5AE6454E(ref, type, quantity) {
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  _id_60227BFF1E9478CC.count = quantity;
  return _id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
}

_id_3D7E44B7E940DE24(lootid, quantity) {
  _id_A1D8C3682333615E = quantity;
  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_A1093166DE09E6B8))
    _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(_id_A1093166DE09E6B8 == "brloot_offhand_geigercounter") {
    if(isDefined(level._id_193EACBF6D2D8179)) {
      if(![[level._id_193EACBF6D2D8179]](self))
        return 0;
    }
  }

  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount))
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_E247454AC2869696; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == 0 && _id_EEEAE9DEFA0C1E95 != lootid)
      return 1;

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      _id_FF239359935AA777 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "quantity");

      if(_id_FF239359935AA777 + quantity <= maxcount)
        return 1;
      else
        quantity = _id_FF239359935AA777 + quantity - maxcount;
    }
  }

  if(quantity == _id_A1D8C3682333615E)
    return 0;

  return 1;
}

_id_D9B1550011525161(player) {
  return player getplayerdata("cp", "dmzWeapon", "lootItemID");
}

_id_EFAB78B72D131D76(player) {
  return istrue(level._id_0F478C1F94CAA7E9) && player getplayerdata("cp", "dmzWeapon", "weapon") != "none";
}

_id_8107FE0FEEC27866(player, weapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  variantid = weapon.variantid;

  if(!isDefined(weapon.variantid))
    variantid = 0;

  lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
  player setplayerdata("cp", "dmzWeapon", "weapon", _id_AB501F397D3CD312);
  player setplayerdata("cp", "dmzWeapon", "variantID", variantid);
  player setplayerdata("cp", "dmzWeapon", "lootItemID", lootid);
  player._id_3EF503345DC57957 = player getweaponammoclip(weapon);

  if(weapon.hasalternate) {
    _id_B6FF735C3690CC44 = weapon getaltweapon();
    player._id_86B32AFF94B5714E = player getweaponammoclip(_id_B6FF735C3690CC44);
  }

  attachments = getweaponattachments(weapon);
  _id_F957368A964A7504 = _id_2669878CF5A1B6BC::_id_792BACB194F6F862(_id_AB501F397D3CD312);
  _id_428A6C7CD65625C0 = 0;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size && _id_428A6C7CD65625C0 < 7; _id_DF6D8E005B4B8020++) {
    if(!isDefined(_id_F957368A964A7504[attachments[_id_DF6D8E005B4B8020]])) {
      player setplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "attachment", attachments[_id_DF6D8E005B4B8020]);
      player setplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "variantID", 0);
      _id_428A6C7CD65625C0++;
    }
  }

  _id_5BAAA0CE73D6FE84(player);
}

_id_5BAAA0CE73D6FE84(player) {
  if(_id_EFAB78B72D131D76(player)) {
    _id_9AC5E72784815708 = _id_2985254128B1C262(player);
    _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(_id_9AC5E72784815708);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      _id_3CA81573D978175B = 0;

      if(isDefined(player._id_3EF503345DC57957))
        _id_3CA81573D978175B = player._id_3EF503345DC57957;

      _id_5A57E79AE8D5AE67 = player.br_ammo[_id_811ABFDB6C33F17F];
      _id_AB0EE360900BCB85 = level._id_E6EA72FC5E3FCD00[_id_811ABFDB6C33F17F];
      _id_5A57E79AE8D5AE67 = int(min(_id_5A57E79AE8D5AE67, _id_AB0EE360900BCB85));
      player setclientomnvar("ui_playerdata_weapon_ammo", _id_5A57E79AE8D5AE67 + _id_3CA81573D978175B);
    }
  }
}

_id_2985254128B1C262(player) {
  weapon = player getplayerdata("cp", "dmzWeapon", "weapon");
  variantid = player getplayerdata("cp", "dmzWeapon", "variantID");
  attachments = [];
  _id_F3464D71F01F614E = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    attachments[_id_DF6D8E005B4B8020] = player getplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
    _id_F3464D71F01F614E[_id_DF6D8E005B4B8020] = player getplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
  }

  return _id_2669878CF5A1B6BC::buildweapon(weapon, attachments, undefined, undefined, variantid, _id_F3464D71F01F614E);
}

br_getweaponstartingclipammo(weaponobj) {
  clipsize = weaponclipsize(weaponobj);
  return int(clipsize);
}

br_forcegivecustomweapon(player, weaponobj, _id_878AB837C6FE40DF, _id_5C3F9357F11D2223, _id_BDE57922CF2180D3, _id_EAAC92793F70B7DF) {
  if(player hasweapon(weaponobj)) {
    player scripts\cp\cp_hud_message::showerrormessage("MP/BR_ALREADY_HOLDING_WEAPON");
    return 0;
  }

  hasmaxammo = weaponobj hasattachment("maxammo");
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.weapon = weaponobj;
  _id_60227BFF1E9478CC.loadoutprimaryfullname = _id_878AB837C6FE40DF;
  _id_60227BFF1E9478CC.scriptablename = _id_5C3F9357F11D2223;
  _id_60227BFF1E9478CC.origin = player.origin + (0, 0, 24);
  _id_60227BFF1E9478CC.count = br_getweaponstartingclipammo(weaponobj);
  _id_60227BFF1E9478CC.countlefthand = 0;
  _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = 0;

  if(hasmaxammo)
    _id_60227BFF1E9478CC.count = 999;

  if(isDefined(_id_BDE57922CF2180D3) && isDefined(_id_EAAC92793F70B7DF)) {
    _id_AC9CAEBED426E625 = weaponclipsize(weaponobj);
    _id_4429CFCFF681B936 = int(ceil(_id_AC9CAEBED426E625 * _id_BDE57922CF2180D3));
    _id_60227BFF1E9478CC.count = int(min(_id_4429CFCFF681B936, _id_EAAC92793F70B7DF));
  }

  if(_id_74502A9E0EF1F19C::isakimbo(weaponobj))
    _id_60227BFF1E9478CC.countlefthand = _id_60227BFF1E9478CC.count;

  if(weaponobj.hasalternate) {
    _id_A0F049FA949F48E9 = weaponobj getaltweapon();
    _id_6664D64B7CB8A858 = weaponclipsize(_id_A0F049FA949F48E9);
    _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = _id_6664D64B7CB8A858;

    if(hasmaxammo)
      _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = 999;
  }

  if(getdvarint("dvar_C8896A161AEBDA74", 0) > 0)
    player loadweaponsforplayer([_id_60227BFF1E9478CC.loadoutprimaryfullname]);

  player takeweaponpickup(_id_60227BFF1E9478CC);

  if(weaponobj.hasalternate) {
    _id_BE014A8D5A4F68F4 = weaponobj getaltweapon();

    if(_id_BE014A8D5A4F68F4.isalternate && _id_2669878CF5A1B6BC::_id_DE04E13AB01E1A10(_id_BE014A8D5A4F68F4.underbarrel)) {
      clipammo = weaponclipsize(_id_BE014A8D5A4F68F4);
      _id_2AA9CAEF99C9AF77 = int(clipammo);
      player setweaponammoclip(_id_BE014A8D5A4F68F4, _id_2AA9CAEF99C9AF77);
    }
  }

  return 1;
}

_id_8B121DD10A442DD2() {
  if(!isDefined(level._id_C59C301EAABC2E32))
    return 0;

  if(!level._id_C59C301EAABC2E32)
    return 1;

  return 0;
}

_id_6FE7E7891D125C48(player) {
  total = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_531CB1BE084314F7::_id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = player _id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_F1CBC68C79EBF1EA)
      total = total + 1;
  }

  return total;
}

_id_51F5AAFA38A37F0F(scriptablename, _id_940774B1F9D551A3) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

  if(!isDefined(lootid)) {
    return;
  }
  _id_750FCC188317845A = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_531CB1BE084314F7::_id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    if(_id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8) == lootid)
      _id_750FCC188317845A[_id_AC0E594AC96AA3A8] = _id_531CB1BE084314F7::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
  }

  if(_id_750FCC188317845A.size <= 0)
    return _id_940774B1F9D551A3;

  _id_5581023A8FC8D56D = tablesort(_id_750FCC188317845A, "up");

  foreach(index in _id_5581023A8FC8D56D) {
    _id_E30B916ADC1E2DC8 = _id_531CB1BE084314F7::_id_897B29ADB37F06A7(index);

    if(_id_940774B1F9D551A3 <= _id_E30B916ADC1E2DC8) {
      _id_531CB1BE084314F7::_id_DB1DD76061352E5B(index, _id_940774B1F9D551A3);
      return 0;
    }

    _id_940774B1F9D551A3 = _id_940774B1F9D551A3 - _id_E30B916ADC1E2DC8;
    _id_531CB1BE084314F7::_id_DB1DD76061352E5B(index, _id_E30B916ADC1E2DC8);
  }

  return _id_940774B1F9D551A3;
}

_id_8863381BF5A8C162(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance._id_2385D6A02352C53D) && istrue(instance._id_2385D6A02352C53D[player.name]))
    player thread scripts\cp\utility::hint_prompt("cant_use_yet", 1, 3);
  else {
    used = 0;

    foreach(weapon in player.primaryweapons) {
      _id_811ABFDB6C33F17F = player br_ammo_type_for_weapon(weapon);
      result = player br_ammo_type_player_full(player, _id_811ABFDB6C33F17F);

      if(!result) {
        player _id_4172A10AE7CBDB41(weapon);
        used = 1;
      }
    }

    primary = player _id_7EF95BBA57DC4B82::getcurrentequipment("primary");

    if(isDefined(primary)) {
      _id_D7D8FAA73DE16FAF = player _id_7EF95BBA57DC4B82::incrementequipmentammo(primary, 10);

      if(_id_D7D8FAA73DE16FAF)
        used = 1;
    }

    _id_D7B9856A19F9B6B5 = player _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");

    if(isDefined(_id_D7B9856A19F9B6B5)) {
      _id_D7D8FAA73DE16FAF = player _id_7EF95BBA57DC4B82::incrementequipmentammo(_id_D7B9856A19F9B6B5, 10);

      if(_id_D7D8FAA73DE16FAF)
        used = 1;
    }

    if(!istrue(level._id_CEE48B761F8CA747)) {
      if(used)
        instance thread _id_DF1C9968B5CBF288(player);
      else
        player thread scripts\cp\utility::hint_prompt("full_inventory", 1, 3);

      return used;
    }

    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

    if(_id_1CD29382D1867470 < _id_A81ADEB0E1F89320) {
      player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_A81ADEB0E1F89320 - _id_1CD29382D1867470);
      used = 1;
    }

    if(used)
      instance thread _id_DF1C9968B5CBF288(player);
    else
      player thread scripts\cp\utility::hint_prompt("full_inventory", 1, 3);
  }
}

ammorestock_used(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(br_ammorestock_playeruse(player)) {
    if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber"))
      thread ammorestock_disableusefortime(instance, player, 90);
    else {
      cooldown = 0.1;

      if(isDefined(level._id_09CBA44F21E7EFD6))
        cooldown = level._id_09CBA44F21E7EFD6;

      thread ammorestock_disableusefortime(instance, player, cooldown);
    }
  } else
    thread ammorestock_disableusefortime(instance, player, 0.1);
}

ammorestock_disableusefortime(scriptable, player, time) {
  level endon("game_ended");
  level endon("end_ammo_restock_threads");
  player endon("disconnect");
  scriptable disablescriptableplayeruse(player);
  wait(time);

  if(time >= 1)
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_COMPLEX_JUGG_MAZE/AMMO_CACHE_AVAILABLE", 2);

  scriptable enablescriptableplayeruse(player);
}

br_ammorestock_playeruse(player) {
  _id_BF64F721310414A0 = 0;

  if(istrue(level._id_3480ABEA6656FCE6))
    _id_BF64F721310414A0 = player _id_7EF95BBA57DC4B82::_id_1AB06E1478168800();

  _id_535A3F9C599A0C5F = 0;

  if(istrue(level._id_CEE48B761F8CA747)) {
    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

    if(_id_1CD29382D1867470 < _id_A81ADEB0E1F89320) {
      slot = "health";

      if(!isDefined(player.equipment[slot]) || player _id_7EF95BBA57DC4B82::getequipmentslotammo(slot) == 0)
        player _id_7EF95BBA57DC4B82::giveequipment("equip_armorplate", slot);

      player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_A81ADEB0E1F89320 - _id_1CD29382D1867470);
      _id_535A3F9C599A0C5F = 1;
    }
  }

  _id_BF00BD1D7DA56C26 = 0;
  _id_417C6EFD125FB6B8 = [];
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  if(player scripts\cp\utility::isjuggernaut()) {
    if(!isDefined(_id_509D86412C9D7426) || _id_509D86412C9D7426.size == 0) {
      minigun = player getcurrentweapon();
      _id_D0BAE9FA43B9E424 = player getcurrentweaponclipammo();
      _id_E21A1FE75EA20307 = weaponclipsize(minigun);

      if(_id_D0BAE9FA43B9E424 < _id_E21A1FE75EA20307) {
        player setweaponammoclip(minigun, _id_E21A1FE75EA20307);
        player _id_5762AC2F22202BA2::hudicontype("br_ammo");
        player playlocalsound("iw9_support_box_use");
        return 1;
      }
    }
  }

  _id_D6A57B95FC473441 = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_B928C399C807AC2E = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(_id_2669878CF5A1B6BC::isminigunweapon(_id_DE88CD14114C1E24)) {
      _id_D6A57B95FC473441 = 1;
      continue;
    }

    if(!_id_2145743924C7FC7B(_id_DE88CD14114C1E24, player)) {
      continue;
    }
    if(!isDefined(_id_B928C399C807AC2E))
      continue;
    else if(br_ammo_give_type(player, _id_B928C399C807AC2E, level.br_ammo_max[_id_B928C399C807AC2E], 0, 1) <= 0) {
      continue;
    }
    giveammo = 1;

    if(_id_417C6EFD125FB6B8.size >= 1) {
      foreach(ammo in _id_417C6EFD125FB6B8) {
        if(_id_B928C399C807AC2E == ammo)
          giveammo = 0;
      }
    }

    if(giveammo) {
      _id_417C6EFD125FB6B8[_id_417C6EFD125FB6B8.size] = _id_B928C399C807AC2E;
      _id_BF00BD1D7DA56C26 = 1;
    }
  }

  _id_89162A7340BA32F3 = player getcurrentprimaryweapon();

  if(_id_0DCC09902E277B83::_id_76CA0B3D8B2555CA(_id_89162A7340BA32F3)) {
    foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
      if(_id_0DCC09902E277B83::_id_76CA0B3D8B2555CA(_id_DE88CD14114C1E24)) {
        continue;
      }
      _id_89162A7340BA32F3 = _id_DE88CD14114C1E24;
      break;
    }
  }

  _id_6E10774FA3FB048E = 0;

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
      _id_D0BAE9FA43B9E424 = player getweaponammoclip(_id_DE88CD14114C1E24);
      _id_E21A1FE75EA20307 = weaponclipsize(_id_DE88CD14114C1E24);

      if(_id_D0BAE9FA43B9E424 < _id_E21A1FE75EA20307)
        player setweaponammoclip(_id_DE88CD14114C1E24, _id_D0BAE9FA43B9E424 + 1);
    }

    _id_6E10774FA3FB048E = 1;
  }

  if(getdvarint("dvar_0B404E78398423F9", 0)) {
    _id_44C97DCE6932DE3C = weaponclipsize(_id_89162A7340BA32F3);

    if(isDefined(_id_44C97DCE6932DE3C)) {
      clip = player getweaponammoclip(_id_89162A7340BA32F3);

      if(clip < _id_44C97DCE6932DE3C) {
        player setweaponammoclip(_id_89162A7340BA32F3, _id_44C97DCE6932DE3C);
        _id_6E10774FA3FB048E = 1;
      }
    }
  }

  if(!_id_BF00BD1D7DA56C26 && !_id_535A3F9C599A0C5F && !_id_BF64F721310414A0 && !_id_6E10774FA3FB048E) {
    if(istrue(_id_D6A57B95FC473441)) {
      if(player scripts\cp\utility::isjuggernaut()) {
        if(player getclientomnvar("ui_assault_suit_on") == 1) {
          player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/CANNOT_REFILL_MINIGUN");
          return 0;
        }
      } else {
        player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/CANNOT_REFILL_MINIGUN");
        return 0;
      }
    }

    player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return 0;
  }

  player _id_5762AC2F22202BA2::hudicontype("br_ammo");
  player playlocalsound("iw9_support_box_use");
  return 1;
}

_id_2145743924C7FC7B(weapon, player) {
  if(weapon.isalternate && _id_2669878CF5A1B6BC::_id_DE04E13AB01E1A10(weapon.underbarrel)) {
    clipammo = weaponclipsize(weapon);
    _id_2AA9CAEF99C9AF77 = int(clipammo);
    player setweaponammoclip(weapon, _id_2AA9CAEF99C9AF77);
    return 0;
  }

  if(_id_0DCC09902E277B83::_id_76CA0B3D8B2555CA(weapon))
    return 0;

  return 1;
}

ammorestock_playeruse(player, loc) {
  player endon("death_or_disconnect");

  if(istrue(level._id_CEE48B761F8CA747)) {
    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

    if(_id_1CD29382D1867470 < _id_A81ADEB0E1F89320)
      player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_A81ADEB0E1F89320 - _id_1CD29382D1867470);
  }

  if(istrue(level._id_3480ABEA6656FCE6))
    player _id_7EF95BBA57DC4B82::_id_1AB06E1478168800();

  used = 0;
  _id_12A372E8CAA042BB = player.primaryweapons;
  _id_50F783A5617F8940 = [];

  foreach(item in _id_12A372E8CAA042BB) {
    if(!_id_74502A9E0EF1F19C::ismeleeonly(item) && !scripts\cp\utility::issuperweapon(item) && !_id_2669878CF5A1B6BC::iskillstreakweapon(item))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = item;
  }

  _id_12A372E8CAA042BB = _id_50F783A5617F8940;
  _id_DF04395B59031A4D = 0;

  foreach(weaponobj in _id_12A372E8CAA042BB) {
    _id_1C0BAEEC9828351C = br_ammo_type_for_weapon(weaponobj);

    if(br_ammo_type_player_full(player, _id_1C0BAEEC9828351C, 1))
      _id_DF04395B59031A4D++;
  }

  if(_id_DF04395B59031A4D == _id_12A372E8CAA042BB.size) {
    player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return 0;
  }

  _id_417C6EFD125FB6B8 = [];

  foreach(index, item in _id_12A372E8CAA042BB)
  _id_417C6EFD125FB6B8[index] = player getammotype(item);

  _id_824C3A21454E998D = 0;

  foreach(index, type in _id_417C6EFD125FB6B8) {
    if(isDefined(_id_417C6EFD125FB6B8[index + 1])) {
      if(_id_417C6EFD125FB6B8[index] == _id_417C6EFD125FB6B8[index + 1]) {
        _id_824C3A21454E998D = 1;
        continue;
      }

      _id_824C3A21454E998D = 0;
    }
  }

  _id_126A4003FA316D0C = 0;

  if(_id_824C3A21454E998D) {
    foreach(item in _id_12A372E8CAA042BB)
    _id_126A4003FA316D0C = _id_126A4003FA316D0C + weaponmaxammo(item);
  }

  foreach(weaponobj in _id_12A372E8CAA042BB) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      player _id_531CB1BE084314F7::br_give_weapon_clip(weaponobj, 2);
      continue;
    }

    isakimbo = 0;

    if(weaponobj._id_318338AA880DFAC6)
      isakimbo = 1;

    _id_F05AA030D9FAF1B9 = _id_74502A9E0EF1F19C::getammooverride(weaponobj);

    if(isakimbo) {
      stockammo = player getweaponammostock(weaponobj);
      _id_2AA9CAEF99C9AF77 = int(min(weaponmaxammo(weaponobj), stockammo + _id_F05AA030D9FAF1B9 * 2));
      player _id_4906C10C3FFDD4CA(weaponobj, _id_2AA9CAEF99C9AF77);

      if(weaponclipsize(weaponobj) != player getweaponammoclip(weaponobj)) {
        player setweaponammoclip(weaponobj, 0, "left");
        player setweaponammoclip(weaponobj, 0, "right");
      }

      continue;
    }

    clipammo = player getweaponammoclip(weaponobj);
    stockammo = player getweaponammostock(weaponobj);

    if(_id_824C3A21454E998D)
      _id_2AA9CAEF99C9AF77 = int(min(_id_126A4003FA316D0C, stockammo + _id_F05AA030D9FAF1B9 * 2));
    else
      _id_2AA9CAEF99C9AF77 = int(min(weaponmaxammo(weaponobj), stockammo + _id_F05AA030D9FAF1B9 * 2));

    if(weaponobj.basename == "iw9_lm_dblmg2_cp")
      player setweaponammoclip(weaponobj, clipammo + _id_F05AA030D9FAF1B9);
    else
      player _id_4906C10C3FFDD4CA(weaponobj, _id_2AA9CAEF99C9AF77);
  }

  player _id_5762AC2F22202BA2::hudicontype("br_ammo");
  player playlocalsound("iw9_support_box_use");
  return 1;
}

_id_DF1C9968B5CBF288(player) {
  level endon("game_ended");

  if(!isDefined(self._id_2385D6A02352C53D))
    self._id_2385D6A02352C53D = [];

  _id_55BED569A266A992 = player.name;
  self._id_2385D6A02352C53D[_id_55BED569A266A992] = 1;
  wait_time = 0;
  _id_03DC0F83D387B17B = getdvarint("dvar_A97DD1A639FA9EE5", 0);

  if(_id_03DC0F83D387B17B > 0)
    wait_time = _id_03DC0F83D387B17B;

  wait(wait_time);
  self._id_2385D6A02352C53D[_id_55BED569A266A992] = undefined;
}

_id_F09E47B124561928() {
  if(isai(self)) {
    return;
  }
  _id_531CB1BE084314F7::_id_7F04A682872040DB(self);
  _id_414B281CD48C16D3 = _id_531CB1BE084314F7::_id_9CD290910C24D4D3();
  _id_0113572A27A3AC22 = _id_774FEF5F034555BA();

  foreach(item in _id_414B281CD48C16D3) {
    index = undefined;

    if(_id_0113572A27A3AC22)
      index = _id_752A16F10A698186(item.lootid, ::_id_25BE694D7A22DB61);
    else
      index = _id_752A16F10A698186(item.lootid);

    if(isDefined(index)) {
      _id_FF239359935AA777 = self getplayerdata("cp", "dmzInventory", index, "quantity");
      ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);

      if(_id_FF239359935AA777 == 1) {
        if(_id_0113572A27A3AC22) {
          itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(item.lootid);

          if(itemtype == "weapon") {
            _id_0E249CFFD8B8F7A9(index, item.lootid, _id_FF239359935AA777, _id_D347B1E01AE5D066());
            continue;
          }
        }

        _id_0E249CFFD8B8F7A9(index, 0, 0);
        continue;
      }

      _id_0E249CFFD8B8F7A9(index, item.lootid, _id_FF239359935AA777 - 1);
    }
  }

  _id_341DE26BF458EFAA = self getplayerdata("cp", "dmzPocketCash");
  data = createplayerplundereventdata();
  _id_46EE9182CF6872D5(_id_341DE26BF458EFAA);
  self setplayerdata("cp", "dmzPocketCash", 0);
  _id_531CB1BE084314F7::_id_F1F10297297D06C8();

  if(!_id_B0D22762C7EE8FE4())
    _id_568D5B6B51690C6A();

  _id_5BAAA0CE73D6FE84(self);
}

_id_46EE9182CF6872D5(value) {
  _id_98EA5AFB293A76A2 = _id_6C95BEB0447FF560();
  _id_03F1B6713CA4C9C7::playersetplunderomnvar(int(value / _id_98EA5AFB293A76A2));
}

_id_6C95BEB0447FF560() {
  return getdvarint("dvar_7360A50E3FF1A193", 10);
}

_id_568D5B6B51690C6A() {
  _id_0E2B623E5AD975EE(0, 0);
  _id_0E2B623E5AD975EE(0, 1);
  _id_7734D7B754DF1192(0, 0, "none");
  _id_7734D7B754DF1192(0, 1, "none");
}

_id_5F0596C296180F6C(index, ref) {}

_id_7734D7B754DF1192(_id_089688461C79EF11, _id_50B79E19F823671D, ref) {}

_id_0E2B623E5AD975EE(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  _id_8C5B523B8E941DC2(_id_089688461C79EF11, _id_FE4048AD22C35D73, "iw9_me_fists");
  _id_E5A485A5370DEBC1(_id_089688461C79EF11, _id_FE4048AD22C35D73, 0);

  for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < 5; _id_40E4B9C48B36C9EC++) {}

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++) {}
}

_id_8C5B523B8E941DC2(_id_089688461C79EF11, _id_FE4048AD22C35D73, ref) {}

_id_E5A485A5370DEBC1(_id_089688461C79EF11, _id_FE4048AD22C35D73, lootid) {}

_id_B0D22762C7EE8FE4() {
  if(!isDefined(level._id_A488DE48EEE3F95E))
    level._id_A488DE48EEE3F95E = getdvarint("dvar_B3D354DAB8DA45D4", 0);

  return level._id_A488DE48EEE3F95E;
}

_id_2D55E66E05614871() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    self setplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID", lootid);
    self setplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "quantity", quantity);
    _id_BAC731E0FDAA0CCB(lootid);
    self setplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID", 0);
    self setplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity", 0);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }
}

_id_BAC731E0FDAA0CCB(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(!isDefined(type)) {
    return;
  }
  switch (type) {
    case "perk":
    case "field_upgrade":
    case "equipment":
    case "secondary":
    case "weapon":
    case "primary":
    case "super":
    case "killstreak":
    case "tactical":
    case "lethal":
      return;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onMatchStart"]) && isDefined(level._id_B33C035C483C2893["onMatchStart"][ref]))
        [[level._id_B33C035C483C2893["onMatchStart"][ref]]](self);

      return;
  }

  return;
}

_id_0E249CFFD8B8F7A9(index, lootid, quantity, cooldown) {
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(lootid == 0 || quantity <= 0) {
    lootid = 0;
    quantity = 0;
  }

  if(!isDefined(cooldown))
    cooldown = 0;

  self setplayerdata("cp", "dmzInventory", index, "lootID", lootid);
  self setplayerdata("cp", "dmzInventory", index, "quantity", quantity);
  self setplayerdata("cp", "dmzInventory", index, "cooldownEndTime", cooldown);
}

_id_D347B1E01AE5D066() {
  if(!isDefined(level._id_C04142D70A12CE89))
    level._id_C04142D70A12CE89 = getdvarint("dvar_40EB514E313DD3EF", 43200);

  return getsystemtime() + level._id_C04142D70A12CE89;
}

_id_752A16F10A698186(lootid, _id_7191CAA0AEAD68A5) {
  if(lootid == 0)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzInventory", _id_AC0E594AC96AA3A8, "lootID");

    if(lootid == _id_EEEAE9DEFA0C1E95) {
      if(!isDefined(_id_7191CAA0AEAD68A5) || self[[_id_7191CAA0AEAD68A5]](_id_AC0E594AC96AA3A8))
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_25BE694D7A22DB61(_id_3793828403C6873E) {
  if(self getplayerdata("cp", "dmzInventory", _id_3793828403C6873E, "cooldownEndTime") > gettime())
    return 0;

  return 1;
}

_id_774FEF5F034555BA() {
  if(!isDefined(level._id_0113572A27A3AC22))
    level._id_0113572A27A3AC22 = getdvarint("dvar_E28234D5ED130FB4", 1);

  return level._id_0113572A27A3AC22;
}