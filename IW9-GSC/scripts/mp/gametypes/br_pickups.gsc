/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_pickups.gsc
***********************************************/

br_pickups_init() {
  _id_1CE31D513CB66606::_id_055292AFCF3C3024();
  level.br_pickups = spawnStruct();
  level.forcegivesuper = ::forcegivesuper;
  level.showuseresultsfeedback = ::showuseresultsfeedback;
  level.removeselfrevivetoken = ::removeselfrevivetoken;
  level._id_F26B4E7EB9AF8155 = ::_id_00CDF7F2F6BD3207;
  level._id_C57EE1E174E42601 = ::_id_8206BC54A1ED73CB;
  level._id_86B2CFC21B9ABCF8 = getdvarint("dvar_9AAD06FF702ECDB7", 1);
  level._id_509664F56A31278F = getdvarint("dvar_55DB2E273692B804", 1);
  initarrays();
  initscriptablemanagement();
  level._id_ABA762658155F642 = getdvarint("dvar_B455AB2EC51AA034", 0);
  level._id_0E5BB4D290468DD8 = getdvarint("dvar_5A47269347AE6EFD", 4);
  level._id_17D5CEA099C1EF53 = getdvarint("dvar_36A8422F72C9B425", 1);
  level._id_9FA4C8AFEFDC8734 = getdvarint("dvar_AAF53A2C0B576822", 0);
  level._id_7B6723A60D7478A0 = getdvarint("dvar_2F04A41993E8009A", 0);
  level._id_D3EF9649A38FFBE5 = getdvarint("dvar_3D4DC4C0031757DF", 0);
  level._id_6FB51FF010511210 = getdvarint("dvar_A4F090B2C5573E4A", 0);
  level._id_152735D16E609BEC = getdvarint("dvar_7CD2980EB93CD682", 0);
  level._id_F5A1DC77E6A05354 = getdvarint("dvar_BAD88DADEA6F5EAA", 0);
  level._id_A7C2A61A231CDA3E = getdvarint("dvar_6ED187BA3B2A67D4", 0);
  level._id_108EFBA0EE1450A8 = getdvarint("dvar_53147C89008F8596", 0);
  level notify("br_pickups_init");
  level._id_1515562147F27975 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_equip_gasmask");
  level._id_479D8EF7F76A4DF6 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_equip_gasmask_durable");
  level._id_CB1A359321609C75 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_equip_gasmask_scuba");
  level._id_534E97D34EF9FA29 = [level._id_1515562147F27975, level._id_479D8EF7F76A4DF6, level._id_CB1A359321609C75];
  level._id_152D5A9C5AC5CDAD = getdvarfloat("dvar_BA9E8FBF0254BE1E", 0.857);
  level._id_AA1AAED4A9B80D4B = getdvarint("dvar_3196E3743C6871B2", 3);
  level._id_7420DDC23AA7B431 = getdvarint("dvar_552A3359B82D470F", 1);
  level._id_A3443D8EBDAF7C00 = getdvarint("dvar_3481B39EB4C2F17A", 0);
  level._id_7582DC4260722BF1 = getdvarint("dvar_53D1E9738538BB23", 0);
  level._id_BC1086A365D70B30 = getdvarint("dvar_957BF05692B129CA", 0);
  level._id_E8FC7C00FD85A565 = getdvarint("dvar_DBB95D9FB9DB4E73", 0);
  level._id_9DD3CE936C1DEC1D = getdvarint("dvar_C108CC4C4E3A3653", 0);
  level._id_66A7A8B388D5DE9E = getdvarint("dvar_A55C2DF135B06DC0", 2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickups", "isDogTag", ::_id_9E3428357E5DF2E3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickups", "isGasMask", ::isgasmask);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickups", "registerScriptableInstance", ::registerscriptableinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickups", "tryDeregisterScriptableInstance", ::_id_007B67823458CD14);
  _id_498B5814B18986C9::init();
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(2, ::dangercircletick, ::_id_1A1709943670772A);
  level._id_5312BC14BD5DB377 = getdvarfloat("dvar_58805F0CB8978A2A", 0.65);
}

initarrays() {
  level.brloottablename = getDvar("loot_table_name", "mp/loot/br/default/loot_item_defs.csv");

  if(level.brloottablename == "")
    level.brloottablename = "mp/loot/br/default/loot_item_defs.csv";

  level._id_6178CE645AEEB787 = getDvar("loot_table_zone", "mp/loot/br/default/loot_table_zones.csv");

  if(level._id_6178CE645AEEB787 == "") {
    level._id_6178CE645AEEB787 = "mp/loot/br/default/loot_table_zones.csv";
    setDvar("loot_table_zones", level._id_6178CE645AEEB787);
  }

  if(!isDefined(level.br_pickups))
    level.br_pickups = spawnStruct();

  level.br_pickups.createcallbacks = [];
  level.br_pickups._id_7C25F4FB48DB3DD4 = [];
  level.br_pickups.droppedgasmasks = [];
  registerpickupcreatedcallback("brloot_equip_gasmask", ::gasmask_onpickupcreated);
  registerpickupcreatedcallback("brloot_equip_gasmask_durable", ::gasmask_onpickupcreated);
  registerpickupcreatedcallback("brloot_equip_gasmask_scuba", ::gasmask_onpickupcreated);
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
  level.br_pickups.br_killstreakreference = [];
  level.br_pickups.br_killstreaktoscriptable = [];
  level.br_pickups.br_superreference = [];
  level.br_pickups._id_14BD11727C4B6629 = [];
  level.br_pickups._id_838863C4848D4C26 = [];
  level.br_pickups.br_hasautopickup = [];
  level.br_pickups.uniquelootcallbacks = [];
  level.br_pickups._id_C4B4B56C76765330 = [];
  level.br_pickups._id_04138F9DDC1CD22D = [];
  level.br_pickups._id_52AAC7E6E7072413 = [];
  level.br_pickups._id_52C58DA4C35FDE00 = [];
  level.br_pickups._id_688C9B0A44E4A8CA = [];
  level.br_pickups._id_B8FAD1CFD41D21DA = [];
  level.br_pickups._id_0A5E4B146866D7FD = [];
  level.br_pickups._id_4183295EDCC21DB0 = [];
  level.br_pickups.br_allguns = [];
  level.br_pickups.br_lootguns = [];
  level.br_pickups._id_9E78B5EE377070A9 = [];
  level.br_pickups._id_692E058F97BCC055 = [];
  level.br_pickups.br_crateguns = [];
  level.br_pickups.br_crateitems = [];
  level.br_pickups.br_gulagpickups = [];
  level.br_pickups._id_1E6C5E03170CF425 = [];
  level.br_pickups._id_EB7725A8A6F2C64C = [];
  level.br_lootiteminfo = [];
  level.br_weaponsprimary = [];
  level.br_weaponssecondary = [];
  level.br_throwables = [];
  level.br_usables = [];
  level._id_D8DB1602C8BF473E = [];
  level._id_05635125E56693C8 = [];
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
      level.br_pickups.br_itemrow[_id_14004B68DDACB781] = int(_id_CB89110314447B2F);
      _id_A38E261031751C09 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 33);

      if(_id_A38E261031751C09 != "")
        level.br_pickups._id_B8FAD1CFD41D21DA[_id_14004B68DDACB781] = int(_id_A38E261031751C09);

      _id_52E1D38987AF61C3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 34);
      level.br_pickups._id_0A5E4B146866D7FD[_id_14004B68DDACB781] = isDefined(_id_52E1D38987AF61C3) && _id_52E1D38987AF61C3 != "";
      _id_5A56FE331235854A = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 32);
      level.br_pickups._id_4183295EDCC21DB0[_id_14004B68DDACB781] = isDefined(_id_5A56FE331235854A) && _id_5A56FE331235854A != &"";

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

      level.br_pickups._id_688C9B0A44E4A8CA[_id_14004B68DDACB781] = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 28) == "brightGold";

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
          fullweaponname = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 10);
          parts = strtok(fullweaponname, "+");

          foreach(part in parts) {
            if(getsubstr(part, 0, 4) == "camo")
              camo = strtok(part, "|")[1];
          }

          if(getdvarint("dvar_AD67CF67992FE5F2", 0))
            camo = "camo_11a";

          fullweaponobj = undefined;

          if(!isDefined(_id_91BBF8D2294A656E))
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_4BB9768282D4260D, camo, undefined, variantid);
          else
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon_attachmentidmap(_id_4BB9768282D4260D, _id_91BBF8D2294A656E, camo, undefined, variantid);

          fullweaponname = getcompleteweaponname(fullweaponobj);

          if(getDvar("dvar_9CC91F7C70752FA7", "1") != "1") {}
        } else {
          _id_92FCE7B1696254E3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 8);
          _id_FC5B5CABB888A488 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 9);
          _id_7CE98C8199BE3D76 = [];

          if(isDefined(_id_FC5B5CABB888A488) && _id_FC5B5CABB888A488.size)
            _id_7CE98C8199BE3D76 = strtok(_id_FC5B5CABB888A488, _id_55DFF3C24D1396C9);

          if(getdvarint("dvar_AD67CF67992FE5F2", 0))
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon(_id_92FCE7B1696254E3, _id_7CE98C8199BE3D76, "camo_11a", "none", -1);
          else
            fullweaponobj = _id_2669878CF5A1B6BC::buildweapon(_id_92FCE7B1696254E3, _id_7CE98C8199BE3D76, "none", "none", -1);

          fullweaponname = getcompleteweaponname(fullweaponobj);
          _id_D7305E20A538A9A1 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_92FCE7B1696254E3);

          if(isDefined(_id_D7305E20A538A9A1))
            _id_BB255CC38C4AA89D = "" + _id_D7305E20A538A9A1;
        }

        _id_0D0923526DE8A11F = int(_id_AE10C1B57593E13F);
        level.br_pickups.br_itemtype[_id_14004B68DDACB781] = itemtype;
        level.br_pickups.br_pickupsfx[_id_14004B68DDACB781] = _id_8D1FE71563B03100;
        level.br_pickups.br_itemrarity[_id_14004B68DDACB781] = _id_0D0923526DE8A11F;
        level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = _id_14004B68DDACB781;

        if(!isDefined(level.br_pickups._id_692E058F97BCC055[_id_0D0923526DE8A11F]))
          level.br_pickups._id_692E058F97BCC055[_id_0D0923526DE8A11F] = [];

        level.br_pickups._id_692E058F97BCC055[_id_0D0923526DE8A11F][level.br_pickups._id_692E058F97BCC055[_id_0D0923526DE8A11F].size] = _id_14004B68DDACB781;
        level.br_lootiteminfo[_id_14004B68DDACB781] = spawnStruct();
        level.br_lootiteminfo[_id_14004B68DDACB781].baseweapon = _id_92FCE7B1696254E3;
        level.br_lootiteminfo[_id_14004B68DDACB781].fullweaponname = fullweaponname;
        level.br_lootiteminfo[_id_14004B68DDACB781].fullweaponobj = fullweaponobj;

        if(_id_0D0923526DE8A11F != 10) {
          level.br_pickups.br_weapontoscriptable[fullweaponname] = _id_14004B68DDACB781;
          level.br_pickups._id_7B2BFF2D04EE1017[_id_14004B68DDACB781] = int(_id_BB255CC38C4AA89D);
          level.br_pickups._id_B13DC7E63676BBE7[int(_id_BB255CC38C4AA89D)] = _id_14004B68DDACB781;
        }

        if(_id_D9DA779938EBCD86(_id_CB89110314447B2F))
          level.br_pickups._id_9E78B5EE377070A9[fullweaponname] = _id_14004B68DDACB781;
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
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname]))
                level.equipment.table[equipname].defaultslot = "primary";

              level.br_throwables[level.br_throwables.size] = _id_14004B68DDACB781;
              break;
            case "2":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname]))
                level.equipment.table[equipname].defaultslot = "secondary";

              level.br_usables[level.br_usables.size] = _id_14004B68DDACB781;
              break;
            case "3":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname]))
                level.equipment.table[equipname].defaultslot = "health";

              break;
            case "4":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname]))
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

        if(itemtype == "killstreak" || itemtype == "killstreak_nodrop") {
          _id_44861522C9F83848 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 18);
          level.br_pickups.br_killstreakreference[_id_14004B68DDACB781] = _id_44861522C9F83848;
          level.br_pickups.br_killstreaktoscriptable[_id_44861522C9F83848] = _id_14004B68DDACB781;
        } else if(itemtype == "super" || itemtype == "super_nodrop") {
          _id_9766FDFDC41069A5 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 18);
          level.br_pickups.br_superreference[_id_14004B68DDACB781] = _id_9766FDFDC41069A5;
        } else if(itemtype == "lethal" || itemtype == "lethal_nodrop")
          level.br_pickups._id_1E6C5E03170CF425[level.br_pickups._id_1E6C5E03170CF425.size] = _id_14004B68DDACB781;
        else if(itemtype == "tactical" || itemtype == "tactical_nodrop")
          level.br_pickups._id_EB7725A8A6F2C64C[level.br_pickups._id_EB7725A8A6F2C64C.size] = _id_14004B68DDACB781;

        _id_51426AE160732E49 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 4));
        _id_10A92702735EFF08 = int(tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 27));

        if(itemtype == "ammo") {
          if(!isDefined(level.br_ammo_max))
            _id_724736FCF0FB6604::br_ammo_init();

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

      tags = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 6);
      tags = strtok(tags, "&");
      level.br_pickups._id_C4B4B56C76765330[_id_14004B68DDACB781] = scripts\engine\utility::array_contains(tags, "noSpawn");
    } else if(key == "crate") {
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
    } else if(key == "gulag") {
      _id_14004B68DDACB781 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 1);
      _id_7D9A5D01CE25E7A3 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2);

      if(!isDefined(level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3]))
        level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3] = [];

      count = level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3].size;
      level.br_pickups.br_gulagpickups[_id_7D9A5D01CE25E7A3][count] = _id_14004B68DDACB781;
    } else if(!isDefined(level.br_pickups._id_11FEB85E78E7CEE8) && (key == "depends" || key == "inheritDepends"))
      level.br_pickups._id_11FEB85E78E7CEE8 = _id_CB89110314447B2F;

    _id_75633A54AD10A451("brloot_equip_gasmask_durable", getdvarint("dvar_20633082981B3A9C", 216));
  }

  setdvarifuninitialized("dvar_61E10DE0F675E9AD", 0);
  level.br_pickups.br_pickupdenyammonoroom = "MP/BR_AMMO_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyequipnoroom = "MP/BR_EQUIP_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyalreadyhaveweapon = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyarmornotbetter = "MP/BR_ARMOR_DENY_NOT_BETTER";
  level.br_pickups.br_pickupdenyalreadyhaveks = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
  level.br_pickups._id_17109B21F99AD76D = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
  level.br_pickups._id_540408F173BA9A3F = "MP_BR_INGAME/ALREADY_HAVE_GULAG_TOKEN";
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
  level.br_pickups._id_06944F496399A2A4 = "MP_BR_INGAME/TOO_MANY_TEAMMATES";
  level.br_pickups.br_pickupdenyplunderpickup = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
  level.br_pickups._id_58D0559B458FD450 = "MP/CANNOT_EQUIP_NOW";
  level.br_pickups._id_355CDDB773CB000D = "MP/DENY_USE_CARRY";
  level.br_pickups._id_0859F4BD204F1259 = "MP/CANNOT_USE_GENERIC";
  level.br_pickups._id_61251EF22EFA8D15 = "MP_BR_INGAME/ALREADY_HAVE_SUPER";
  level.br_pickups._id_7C27D71DBF683991 = "MP/DENY_VEHICLE_DROP";
  level.br_pickups.br_pickupdenyweaponpickupap = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
  level.br_pickups._id_7141C6C2372C0A82 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups._id_8BFFCA3828FD297E = "MP/BR_EQUIP_DENY_PLATE_CARRIER_LESS";
  level.br_pickups._id_EC7422F11A61C100 = "MP/BR_EQUIP_DENY_BACKPACK_LESS";
  level.br_pickups._id_7BD397B2E9D8A434 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups.respawntokenenabled = getdvarint("dvar_C9D9BC1BAE348282", 1);
  level.br_pickups.respawntokenclosewithgulag = getdvarint("dvar_8603626DC2EC647D", 1);
  level.br_pickups._id_174664C71517F679 = getdvarint("dvar_410F6B398C585156", 1);
  level.br_pickups._id_5609DE5240E42E84 = getdvarint("dvar_2DF02EC7E7EFE5C9", 1);
  level.br_pickups._id_AD49A38DD7C4C10F = undefined;
  level.br_pickups._id_3B53BC0EEE6AE84E = undefined;

  if(getdvarint("dvar_249A73868C9CD7D8", 0)) {
    _id_F8B204E807CC62ED();
    _id_E6CABC9F20DCBC23();
  }

  if(getDvar("dvar_7FEB156CCFAF8DDF", "") != "")
    _id_32A0394CF13C8B29();

  if(_id_724736FCF0FB6604::_id_B1DD9DCAE2F63965())
    _id_724736FCF0FB6604::_id_B9DA718E50063452();

  scripts\engine\scriptable::scriptable_addusedcallback(::_id_E40EEC61EE9D0889);
  scripts\engine\scriptable::scriptable_addautousecallback(::_id_E40EEC61EE9D0889);
  level._id_B8E67F48A1D47883 = ::_id_23D6A60CCFA90B00;
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

_id_E6CABC9F20DCBC23() {
  if(isDefined(level.br_standard_loadout)) {
    level._id_EA84A0518343879C["primary"] = _id_78AD8EB4CC92F407(level.br_standard_loadout, "Primary");
    level._id_EA84A0518343879C["secondary"] = _id_78AD8EB4CC92F407(level.br_standard_loadout, "Secondary");
  }
}

_id_23A8498A6613DE14() {
  level._id_F67907AFE56C4F82 = [];

  if(istrue(level.usegulag)) {
    _id_F070698D508B0818 = [];
    _id_23182E0FD5672080 = getDvar("dvar_D07965DA1789DEA1", "mp/automatism/initial_slot_after_gulag_base_weapons_table.csv");

    if(tableexists(_id_23182E0FD5672080)) {
      _id_9C304086CA408D8B = tablelookupgetnumrows(_id_23182E0FD5672080);

      for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_9C304086CA408D8B; _id_CB89110314447B2F++) {
        _id_92FCE7B1696254E3 = tablelookupbyrow(_id_23182E0FD5672080, _id_CB89110314447B2F, 0);
        _id_F070698D508B0818[_id_CB89110314447B2F] = _id_92FCE7B1696254E3;
      }

      count = level.gulagloadouts.size;

      for(index = 0; index < count; index++) {
        _id_BC095883AECE1A82 = _id_78AD8EB4CC92F407(level.gulagloadouts[index], "Primary");
        _id_CC63CD9EC88314C2 = _id_78AD8EB4CC92F407(level.gulagloadouts[index], "Secondary");
        _id_5D9EF63DE8747C32(_id_BC095883AECE1A82, _id_F070698D508B0818);
        _id_5D9EF63DE8747C32(_id_CC63CD9EC88314C2, _id_F070698D508B0818);
      }
    }
  }
}

_id_D9DA779938EBCD86(_id_CB89110314447B2F) {
  _id_8677E2501BD28313 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 10);

  if(!isDefined(_id_8677E2501BD28313) || _id_8677E2501BD28313 == "")
    return 0;

  tags = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 6);
  tags = strtok(tags, "&");
  gametype = scripts\mp\utility\game::getsubgametype();
  return !scripts\engine\utility::array_contains(tags, "no" + gametype);
}

_id_32A0394CF13C8B29() {
  _id_BB4C023DC74082DF = "lootvalueoverride:" + getDvar("dvar_7FEB156CCFAF8DDF", "");
  _id_D442547D75DFFD09 = getscriptbundle(_func_40FD49171FAD19D3(_id_BB4C023DC74082DF));

  if(!isDefined(_id_D442547D75DFFD09)) {
    return;
  }
  foreach(_id_345386AA7C1AFE54 in _id_D442547D75DFFD09._id_2EAF4FEEEF5CEFC5) {
    ref = _id_345386AA7C1AFE54._id_CB325DDB4A764623;

    if(isDefined(level.br_pickups._id_D93566A78E29D583[ref]))
      level.br_pickups._id_D93566A78E29D583[ref] = int(_id_345386AA7C1AFE54._id_17B73AA1820974EE);
  }
}

_id_5D9EF63DE8747C32(weaponobj, _id_F070698D508B0818) {
  _id_92FCE7B1696254E3 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  count = _id_F070698D508B0818.size;

  for(index = 0; index < count; index++) {
    if(_id_F070698D508B0818[index] == _id_92FCE7B1696254E3 && !_id_2166628459C78E7A(weaponobj)) {
      level._id_F67907AFE56C4F82[level._id_F67907AFE56C4F82.size] = weaponobj;
      break;
    }
  }
}

_id_2166628459C78E7A(weaponobj) {
  hasweapon = 0;
  count = level._id_F67907AFE56C4F82.size;

  for(index = 0; !hasweapon && index < count; index++)
    hasweapon = issameweapon(level._id_F67907AFE56C4F82[index], weaponobj);

  return hasweapon;
}

_id_78AD8EB4CC92F407(loadout, _id_E38B4E99059A1F48) {
  _id_BA38574234720011 = 0;

  if(_id_E38B4E99059A1F48 == "Primary")
    _id_BA38574234720011 = 7;
  else if(_id_E38B4E99059A1F48 == "Secondary")
    _id_BA38574234720011 = 7;
  else {}

  _id_048743AAB19552FD = "loadout" + _id_E38B4E99059A1F48;
  weaponattachments = [];
  _id_E7CC1946FB89AFAA = [];
  _id_6C2BFD3D88F9E18C = _id_048743AAB19552FD + "Attachment";
  _id_6D728BAE3E54774A = "";

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < _id_BA38574234720011; _id_DF6D8E005B4B8020++) {
    if(_id_DF6D8E005B4B8020 != 0)
      _id_6D728BAE3E54774A = _id_6C2BFD3D88F9E18C + (_id_DF6D8E005B4B8020 + 1);
    else
      _id_6D728BAE3E54774A = _id_6C2BFD3D88F9E18C;

    if(isDefined(loadout[_id_6D728BAE3E54774A])) {
      weaponattachments[_id_DF6D8E005B4B8020] = loadout[_id_6D728BAE3E54774A];
      _id_E7CC1946FB89AFAA[_id_DF6D8E005B4B8020] = 0;
    }
  }

  return _id_2669878CF5A1B6BC::buildweapon(loadout[_id_048743AAB19552FD], weaponattachments, loadout[_id_048743AAB19552FD + "Camo"], loadout[_id_048743AAB19552FD + "Reticle"], loadout[_id_048743AAB19552FD + "VariantID"], _id_E7CC1946FB89AFAA);
}

_id_75633A54AD10A451(scriptablename, _id_9BE70D6D4FF253A1) {
  if(isDefined(level.br_pickups.counts[scriptablename]) && isDefined(_id_9BE70D6D4FF253A1))
    level.br_pickups.counts[scriptablename] = _id_9BE70D6D4FF253A1;
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

_id_4EE41241BBF56557(_id_ADF4A147715DABA0, baseorigin) {
  _id_FAFD64B272244139 = getlootscriptablearrayinradius(undefined, undefined, baseorigin, _id_ADF4A147715DABA0.dist + 10);

  if(isDefined(_id_FAFD64B272244139) && _id_FAFD64B272244139.size > 0) {
    foreach(scriptable in _id_FAFD64B272244139) {
      if(!isDefined(scriptable.origin)) {
        continue;
      }
      _id_CAC6B8B7EFDDB0E4 = scriptable.origin - baseorigin;
      _id_E6D3398E6E00BB9E = vectorNormalize(_id_CAC6B8B7EFDDB0E4);
      angle = vectordot(_id_ADF4A147715DABA0.dir, _id_E6D3398E6E00BB9E);

      if(angle > getdvarfloat("dvar_F877F79616E047C7", 0.85)) {
        _id_636C8575D7A7768B = distance2d(baseorigin, scriptable.origin) / 2;

        if(_id_636C8575D7A7768B < _id_ADF4A147715DABA0.dist)
          _id_ADF4A147715DABA0.dist = _id_636C8575D7A7768B;
      }
    }

    if(_id_ADF4A147715DABA0.dist < getdvarfloat("dvar_290C05A9320B623D", 50.0))
      _id_ADF4A147715DABA0.dist = 110.0 + randomfloatrange(-5.0, 5.0);
  }
}

_id_7BF5EA7DD272DB77(dropstruct, _id_ADF4A147715DABA0, baseorigin, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_551904951118B7B9) {
  tracestart = baseorigin + (0, 0, 21);
  _id_FFBB92BFD2DC8FE7 = _id_ADF4A147715DABA0.dir * 18.0;
  _id_8B39E5984DA1FFAF = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 + _id_FFBB92BFD2DC8FE7 + (0, 0, 21);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0)
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = traceresults["position"];
  else
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_8B39E5984DA1FFAF;

  _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 - _id_FFBB92BFD2DC8FE7;
  _id_69750FB1D5F5525F = getdvarint("dvar_3CA29B429F678228", 1);

  for(_id_DAC2FE2E7CCCDA53 = 0; _id_DAC2FE2E7CCCDA53 < _id_69750FB1D5F5525F; _id_DAC2FE2E7CCCDA53++) {
    tracestart = tracestart + (0, 0, 10.0 * _id_DAC2FE2E7CCCDA53);
    _id_435E68A101BE2358 = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8);

    if(_id_435E68A101BE2358["fraction"] < traceresults["fraction"])
      traceresults["fraction"] = -1;
  }

  return traceresults;
}

_id_3F0CE5CF3481F56C(dropstruct, _id_ADF4A147715DABA0, baseorigin, baseangles, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_F51E59095803AD71, _id_DAA047868CF7A01B, _id_551904951118B7B9) {
  _id_A9D5AD9414F5ECB7 = 11;
  _id_3385F93167B49AA1 = 360.0 / _id_A9D5AD9414F5ECB7;
  _id_69BA8B68BA5E82E1 = _id_ADF4A147715DABA0.ring;
  _id_52F7D953DEDDB1D3 = _id_ADF4A147715DABA0.slot;
  _id_D1F8E4E25A5B0AFA = _id_ADF4A147715DABA0.yaw;
  _id_B1645FB2E124B7BF = _id_ADF4A147715DABA0.dist;
  _id_00943CE3376B5DFE = _id_ADF4A147715DABA0.dir;
  _id_F4A31528787AE6BD = _id_ADF4A147715DABA0._id_37FBA60B9CB411EB;
  _id_9BD3420D924C5C43 = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915;
  _id_C4B448E975A0779B = 0;

  for(success = 0; _id_C4B448E975A0779B < _id_F51E59095803AD71 && !success; _id_C4B448E975A0779B++) {
    dropstruct._id_DFBA5A2C3C6F0A07++;
    _id_ADF4A147715DABA0.ring = int(dropstruct._id_DFBA5A2C3C6F0A07 / _id_A9D5AD9414F5ECB7);
    _id_ADF4A147715DABA0.slot = dropstruct._id_DFBA5A2C3C6F0A07 - _id_ADF4A147715DABA0.ring * _id_A9D5AD9414F5ECB7;
    _id_ADF4A147715DABA0.yaw = baseangles[1] + (_id_ADF4A147715DABA0.slot * _id_3385F93167B49AA1 + _id_ADF4A147715DABA0.ring * 10.0) + randomfloatrange(-5.0, 5.0);
    _id_ADF4A147715DABA0.dist = 75.0 + _id_ADF4A147715DABA0.ring * 35.0 + randomfloatrange(-5.0, 5.0);
    _id_ADF4A147715DABA0._id_37FBA60B9CB411EB = (0.0, _id_ADF4A147715DABA0.yaw, 0.0);
    _id_ADF4A147715DABA0.dir = anglesToForward(_id_ADF4A147715DABA0._id_37FBA60B9CB411EB);

    if(getdvarint("dvar_F621128B1EE62123", 1) && _id_ADF4A147715DABA0.ring < 1)
      _id_4EE41241BBF56557(_id_ADF4A147715DABA0, baseorigin);

    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = baseorigin + _id_ADF4A147715DABA0.dir * _id_ADF4A147715DABA0.dist;
    traceresults = _id_7BF5EA7DD272DB77(dropstruct, _id_ADF4A147715DABA0, baseorigin, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_551904951118B7B9);

    if(traceresults["fraction"] >= _id_DAA047868CF7A01B)
      return;
  }

  _id_ADF4A147715DABA0.ring = _id_69BA8B68BA5E82E1;
  _id_ADF4A147715DABA0.slot = _id_52F7D953DEDDB1D3;
  _id_ADF4A147715DABA0.yaw = _id_D1F8E4E25A5B0AFA;
  _id_ADF4A147715DABA0.dist = _id_B1645FB2E124B7BF;
  _id_ADF4A147715DABA0.dir = _id_00943CE3376B5DFE;
  _id_ADF4A147715DABA0._id_37FBA60B9CB411EB = _id_F4A31528787AE6BD;
  _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_9BD3420D924C5C43;
}

_id_28CD87CDBAE45940(dropstruct, _id_ADF4A147715DABA0, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_551904951118B7B9) {
  tracestart = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915;
  _id_8B39E5984DA1FFAF = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 + (0, 0, 60);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0)
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = traceresults["position"] + (0, 0, -6);
  else
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_8B39E5984DA1FFAF;

  return traceresults;
}

_id_BD56D40FA4E7A1E3(dropstruct, _id_ADF4A147715DABA0, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_C79BB482424EB3A0, _id_29A915F667B07B0F, _id_551904951118B7B9) {
  tracestart = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915;
  _id_914F83DDF24BED51 = scripts\engine\utility::_id_53C4C53197386572(_id_29A915F667B07B0F, getdvarfloat("dvar_0B91D6BC7E0694AC", 2000.0));
  _id_3A7F0173B03F5767 = -1 * _id_914F83DDF24BED51;
  _id_8B39E5984DA1FFAF = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 + (0.0, 0.0, _id_3A7F0173B03F5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0) {
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = traceresults["position"] + (0.0, 0.0, _id_C79BB482424EB3A0);
    _id_ADF4A147715DABA0.groundentity = traceresults["entity"];

    if(isDefined(_id_ADF4A147715DABA0.groundentity) && (istrue(_id_ADF4A147715DABA0.groundentity.isdestroyed) || istrue(_id_ADF4A147715DABA0.groundentity.burningdown) || _id_ADF4A147715DABA0.groundentity scripts\cp_mp\vehicles\vehicle::_id_794B5F886CCED2D0())) {
      ignorelist = [_id_ADF4A147715DABA0.groundentity];

      if(isDefined(_id_447F40C814B97CDC))
        ignorelist[ignorelist.size] = _id_447F40C814B97CDC;

      traceresults = scripts\engine\trace::ray_trace(_id_ADF4A147715DABA0._id_2BE6462FF6BE9915, _id_8B39E5984DA1FFAF, ignorelist, _id_FBCABD62B8F66EB8);

      if(traceresults["fraction"] < 1.0) {
        _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = traceresults["position"] + (0.0, 0.0, _id_C79BB482424EB3A0);
        _id_ADF4A147715DABA0.groundentity = traceresults["entity"];
      } else {
        _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = (0, 0, 0);
        _id_ADF4A147715DABA0._id_C551AB221BAC9779 = 1;
      }
    }
  } else {
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = (0, 0, 0);
    _id_ADF4A147715DABA0._id_C551AB221BAC9779 = 1;
  }

  return traceresults;
}

getitemdroporiginandangles(dropstruct, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44, _id_7591ED99E87A77D3, _id_29A915F667B07B0F, _id_688E4DA4CB16116D) {
  _id_A9D5AD9414F5ECB7 = 11;
  _id_3385F93167B49AA1 = 360.0 / _id_A9D5AD9414F5ECB7;
  _id_551904951118B7B9 = getdvarint("dvar_D7613094EA4BA91F", 0);
  _id_B57E08395CBE94D2 = 40.0;

  if(isDefined(_id_447F40C814B97CDC) && isent(_id_447F40C814B97CDC) && isPlayer(_id_447F40C814B97CDC) && scripts\mp\utility\player::isreallyalive(_id_447F40C814B97CDC)) {
    _id_0E85BB71774631A2 = _id_447F40C814B97CDC getstance();

    if(_id_0E85BB71774631A2 == "crouch")
      _id_B57E08395CBE94D2 = 20.0;
    else if(_id_0E85BB71774631A2 == "prone")
      _id_B57E08395CBE94D2 = 10.0;
  }

  _id_ADF4A147715DABA0 = spawnStruct();
  _id_ADF4A147715DABA0._id_C551AB221BAC9779 = 0;
  _id_ADF4A147715DABA0.payload = 0;
  _id_ADF4A147715DABA0.groundentity = undefined;

  if(!isDefined(baseangles))
    baseangles = (0, 0, 0);

  _id_C79BB482424EB3A0 = 0;

  if(isDefined(_id_6FE2FF802D5192D4))
    _id_C79BB482424EB3A0 = _id_6FE2FF802D5192D4;

  _id_ADF4A147715DABA0.ring = int(dropstruct._id_DFBA5A2C3C6F0A07 / _id_A9D5AD9414F5ECB7);
  _id_ADF4A147715DABA0.slot = dropstruct._id_DFBA5A2C3C6F0A07 - _id_ADF4A147715DABA0.ring * _id_A9D5AD9414F5ECB7;
  _id_ADF4A147715DABA0.yaw = baseangles[1] + (_id_ADF4A147715DABA0.slot * _id_3385F93167B49AA1 + _id_ADF4A147715DABA0.ring * 10.0) + randomfloatrange(-5.0, 5.0);
  _id_ADF4A147715DABA0.dist = 75.0 + _id_ADF4A147715DABA0.ring * 35.0 + randomfloatrange(-5.0, 5.0);

  if(isDefined(_id_8A600B6102DA9F9B))
    _id_ADF4A147715DABA0.yaw = baseangles[1] + _id_8A600B6102DA9F9B;

  if(isDefined(_id_F71D4F78D508DA69))
    _id_ADF4A147715DABA0.dist = _id_F71D4F78D508DA69;

  _id_ADF4A147715DABA0._id_37FBA60B9CB411EB = (0.0, _id_ADF4A147715DABA0.yaw, 0.0);
  _id_ADF4A147715DABA0.dir = anglesToForward(_id_ADF4A147715DABA0._id_37FBA60B9CB411EB);

  if(getdvarint("dvar_F621128B1EE62123", 1) && !isDefined(_id_F71D4F78D508DA69) && !isDefined(_id_7591ED99E87A77D3) && !istrue(_id_688E4DA4CB16116D) && _id_ADF4A147715DABA0.ring < 1)
    _id_4EE41241BBF56557(_id_ADF4A147715DABA0, baseorigin);

  _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = baseorigin + _id_ADF4A147715DABA0.dir * _id_ADF4A147715DABA0.dist;

  if(isDefined(_id_7591ED99E87A77D3))
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_7591ED99E87A77D3;

  if(1) {
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1);
    traceresults = _id_7BF5EA7DD272DB77(dropstruct, _id_ADF4A147715DABA0, baseorigin, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_551904951118B7B9);
    _id_045E7AD8E414C03F = getdvarint("dvar_1761D693D5C4DED5", 5);
    _id_DAA047868CF7A01B = getdvarfloat("dvar_E2CADD2E657C0C27", 0.5);

    if(isDefined(traceresults) && traceresults["fraction"] < _id_DAA047868CF7A01B && _id_045E7AD8E414C03F > 0 && !isDefined(_id_8A600B6102DA9F9B) && !isDefined(_id_F71D4F78D508DA69) && !isDefined(_id_7591ED99E87A77D3))
      _id_3F0CE5CF3481F56C(dropstruct, _id_ADF4A147715DABA0, baseorigin, baseangles, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_045E7AD8E414C03F, _id_DAA047868CF7A01B, _id_551904951118B7B9);

    _id_28CD87CDBAE45940(dropstruct, _id_ADF4A147715DABA0, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_551904951118B7B9);
    _id_BD56D40FA4E7A1E3(dropstruct, _id_ADF4A147715DABA0, _id_447F40C814B97CDC, _id_FBCABD62B8F66EB8, _id_C79BB482424EB3A0, _id_29A915F667B07B0F, _id_551904951118B7B9);
  } else
    _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 = _id_ADF4A147715DABA0._id_2BE6462FF6BE9915 + (0, 0, _id_C79BB482424EB3A0);

  if(1 && !_id_ADF4A147715DABA0._id_C551AB221BAC9779) {
    startorigin = baseorigin;

    if(!istrue(_id_3ACE5AC9C7D6FA44))
      startorigin = startorigin + (0, 0, _id_B57E08395CBE94D2);

    _id_ADF4A147715DABA0.payload = calcscriptablepayloadgravityarc(startorigin, _id_ADF4A147715DABA0._id_2BE6462FF6BE9915);
  }

  dropstruct.dropcount++;
  dropstruct._id_DFBA5A2C3C6F0A07++;
  return getitemdropinfo(_id_ADF4A147715DABA0._id_2BE6462FF6BE9915, _id_ADF4A147715DABA0._id_37FBA60B9CB411EB, _id_ADF4A147715DABA0.payload, _id_ADF4A147715DABA0.groundentity);
}

_id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C) {
  if(istrue(_id_7F437A5779C8787C)) {
    level.br_pickups._id_AD49A38DD7C4C10F = _id_4384ABBF498DF6A7::getkioskyawoffsetoverride();
    level.br_pickups._id_3B53BC0EEE6AE84E = _id_4384ABBF498DF6A7::_id_1A8066CCDB91C1D1();
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
  else if(pickupent _meth_73CC0F04C4C5001D()) {
    scriptablename = _id_155B1A2C8879BDA5(pickupent);
    return getfullweaponobjforscriptablepartname(scriptablename);
  } else if(isDefined(pickupent.type))
    return getfullweaponobjforscriptablepartname(pickupent.type);

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
  scriptablename = _id_155B1A2C8879BDA5(instance);

  if(!isDefined(scriptablename))
    return 0;

  if(scriptablename == "dmz_uav_tower")
    return 1;

  if(scriptablename == "brloot_scorpion_trophy" || scriptablename == "brloot_haunting_soul")
    return 1;

  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("lootUsedIgnore", instance)))
    return 1;

  return 0;
}

_id_155B1A2C8879BDA5(instance) {
  if(!isDefined(instance))
    return undefined;

  if(!instance _meth_73CC0F04C4C5001D())
    return instance.type;

  _id_A1093166DE09E6B8 = instance _meth_15C8C4841BFC1FD5();

  if(isDefined(_id_A1093166DE09E6B8))
    return _id_A1093166DE09E6B8;

  return instance.type;
}

_id_23D6A60CCFA90B00(instance, player) {
  if(!isDefined(instance))
    return 0;

  pickup = spawnStruct();
  pickup.scriptablename = _id_155B1A2C8879BDA5(instance);
  pickup.origin = instance.origin;
  pickup.count = loot_getitemcount(instance);
  pickup.countlefthand = loot_getitemcountlefthand(instance);
  pickup.instance = instance;
  pickup.customweaponname = instance.customweaponname;
  pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];

  if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename]))
    pickup.count = level.br_pickups.counts[pickup.scriptablename];

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = 1;

  if(!_id_BBC64F5BF69B1680(player, pickup, instance))
    return 0;

  _id_3FCF64BB4BAFC05B = 0;
  _id_12E7D95B6CC9CC78 = player cantakepickup(pickup);

  if(_id_12E7D95B6CC9CC78 == 1) {
    _id_3FCF64BB4BAFC05B = _id_3FCF64BB4BAFC05B | 1;

    if(isweaponpickup(pickup.scriptablename)) {
      _id_A700F4673C85C915 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];

      if(player _id_724736FCF0FB6604::_id_744E28EBE63C0358(_id_A700F4673C85C915))
        _id_3FCF64BB4BAFC05B = _id_3FCF64BB4BAFC05B | 2;
    }
  }

  return _id_3FCF64BB4BAFC05B;
}

_id_E40EEC61EE9D0889(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  result = lootused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, 1);

  if(getdvarint("dvar_EFE884B265FFB84F", 1) && isDefined(instance) && istrue(_id_A5B2C541413AA895))
    player _meth_95F0EDA7E462E30F(instance, result);
}

lootused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, _id_2861E2EEEB7AF5DA, _id_1A33360665B6BB36) {
  if(!isDefined(instance)) {
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

  if(!pickup.count && (!_id_5449DA9D3D0358A4(pickup.scriptablename) && !isgasmask(pickup.scriptablename)) && isDefined(level.br_pickups.counts[pickup.scriptablename]))
    pickup.count = level.br_pickups.counts[pickup.scriptablename];

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = _id_A5B2C541413AA895;
  pickup._id_E1147886CCF51970 = instance._id_E1147886CCF51970;
  pickup._id_4E479E14D0837E84 = instance._id_4E479E14D0837E84;
  return _id_B5F5576A0017C089(pickup, state, player, _id_A5B2C541413AA895, instance, _id_2861E2EEEB7AF5DA, _id_1A33360665B6BB36);
}

_id_60234AA487445085(pickup, player, _id_A5B2C541413AA895, instance) {
  _id_483AD0CAB6E25673 = isDefined(pickup.scriptablename) && _id_F262C137ED78E6EB(pickup.scriptablename);
  _id_BECFB5931B2C6BD7 = isDefined(pickup.scriptablename) && pickup _id_728FFCEE8CBF30EE::_id_5FACFBEE97E1A98E();
  _id_F0ABCE18FE9C334E = _id_483AD0CAB6E25673 || _id_BECFB5931B2C6BD7;
  _id_10BBEACB1429824E = player onusecompleted(pickup, _id_F0ABCE18FE9C334E, _id_A5B2C541413AA895, undefined, undefined, instance);

  if(isDefined(instance) && _id_10BBEACB1429824E)
    loot_setitemcount(instance, pickup.count, pickup.countlefthand, pickup._id_E97D731BEDD44C63);

  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    if(isDefined(player._id_D919D1C70719E664))
      player._id_D919D1C70719E664 = player._id_D919D1C70719E664 + 1;

    if(isDefined(pickup.scriptablename) && pickup.scriptablename == "loot_key_gulag") {
      player._id_936612C9EEEDD33B = 1;
      player._id_C51BE970BA557AF5 = 1;
    }

    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

    if(isDefined(pickup.scriptablename) && pickup.scriptablename != "loot_key_gulag") {
      if(isDefined(arena) && isDefined(arena._id_62D1855D36CFF5D2) && isDefined(instance))
        arena._id_62D1855D36CFF5D2[arena._id_62D1855D36CFF5D2.size] = instance;
    }
  }

  _id_ED6D9E78DE701FBA = getdvarint("dvar_920A281EF3740251", 1);

  if(!isDefined(instance) || _id_10BBEACB1429824E && !_id_ED6D9E78DE701FBA)
    return 1;

  if(!_id_483AD0CAB6E25673 && !_id_4EBFDBFA1B8E0339(pickup.scriptablename) && !_id_164622EB2B0F5390::_id_1DB5FF7063481DA7(pickup.scriptablename) && !istrue(instance._id_0C001CCFC802F487)) {
    if(_id_10BBEACB1429824E && _id_ED6D9E78DE701FBA) {
      dropstruct = _id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, undefined, pickup._id_96C7526F4AB04875, undefined, undefined, pickup.origin);
      spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, _id_10BBEACB1429824E, 1);
    }

    loothide(instance);
  }

  _id_56DD1FAA25A3414F(player, pickup, 1);
  player setclientomnvar("ui_notify_show_minimal_hud", gettime());
  return 1;
}

_id_DC5A935AB4958490(pickup) {
  if(isDefined(pickup.customweaponname))
    lootid = _id_2669878CF5A1B6BC::_id_B0D37B9BE0027733(pickup.customweaponname);
  else
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);

  return lootid;
}

_id_08F0BD51F5C6108B(pickup, player, _id_A5B2C541413AA895, instance) {
  lootid = _id_DC5A935AB4958490(pickup);
  player _id_A74604666BDE595B(pickup);
  player _id_EFDDDF60C5DB058C(pickup, _id_A5B2C541413AA895);
  _id_56DD1FAA25A3414F(player, pickup, 20);
  _id_10BBEACB1429824E = 0;

  if(isDefined(lootid)) {
    if(isweaponpickupitem(pickup))
      pickup.count = 1;

    if(_id_55E418C5CC946593::_id_43044DA0ED44D79F(pickup.scriptablename)) {
      if(_id_55E418C5CC946593::_id_BDD930EEE0042052()) {
        _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();
        _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(player, _id_65B695F0C0D909ED, lootid, 1);

        if(isDefined(pickup.instance.perks)) {
          _id_CCA9DDE643CB4A63 = [];

          foreach(perk in pickup.instance.perks)
          _id_CCA9DDE643CB4A63[_id_CCA9DDE643CB4A63.size] = perk;

          player _id_55E418C5CC946593::_id_222999AAD19F5B52(_id_65B695F0C0D909ED, _id_CCA9DDE643CB4A63);
        }
      }
    } else
      player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickup);

    if(isDefined(instance))
      loothide(instance);

    return 1;
  }
}

_id_56DD1FAA25A3414F(player, pickup, results) {
  _id_C17AC30865717C64 = results == 1 || results == 20 || results == 5 || results == 27;

  if(_id_C17AC30865717C64) {
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 0);
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 2);
    lootid = _id_DC5A935AB4958490(pickup);
    quantity = pickup.count;
    _id_2CF425F220B95FBB = scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, lootid, undefined, _id_3EAA9F644DBE7834, quantity);

    if(!istrue(_id_2CF425F220B95FBB))
      _id_2237800B816490B8(player, pickup);
  }
}

_id_2237800B816490B8(player, pickup) {
  if(!isDefined(player) || !isDefined(pickup) || !isDefined(pickup.scriptablename)) {
    return;
  }
  scriptablename = pickup.scriptablename;

  if(isplunder(scriptablename) || _id_7E2F2A69FC0C022B(scriptablename)) {
    _id_B87F7FAE01CE754F = 0;

    if(isDefined(player.plundercount))
      _id_B87F7FAE01CE754F = player.plundercount;

    _id_846972F0CB7C37FA = player _id_6FC415FF6A905DC1::_id_E2F4F470C55123B8(undefined, 1);

    if(isDefined(_id_846972F0CB7C37FA))
      _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + _id_846972F0CB7C37FA;

    if(_id_B87F7FAE01CE754F > 1000) {
      if(istrue(_id_0B7A9CE0A2282B79::_id_80478F2EF8C8882F(player)) && !_id_1F97A44D1761C919::_id_50EBF0029301BE3F(player, "dead_drop_nag"))
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dead_drop_nag", [player]);
    }
  }
}

_id_BBC64F5BF69B1680(player, pickup, instance) {
  if(istrue(level._id_ABA762658155F642))
    return 0;

  if(getdvarint("dvar_15055CB805B43A20", 1) && !player _id_E44C2D69DB881894(pickup.scriptablename))
    return 0;

  if(getdvarint("dvar_752EEED3DDCBD04B", 0) && !player _meth_7B738B973A0B7F94() && player _id_E44C2D69DB881894(pickup.scriptablename))
    return 0;

  if(_id_724736FCF0FB6604::_id_B1DD9DCAE2F63965() && player _id_724736FCF0FB6604::_id_AC3EC31BE7AAD7A7(instance))
    return 0;

  return 1;
}

_id_B5F5576A0017C089(pickup, state, player, _id_A5B2C541413AA895, instance, _id_2861E2EEEB7AF5DA, _id_1A33360665B6BB36) {
  if(!isDefined(pickup))
    return 0;

  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance, _id_A5B2C541413AA895)) || istrue(level.infilcinematicactive))
    return 0;

  if(istrue(_id_A5B2C541413AA895) && !_id_BBC64F5BF69B1680(player, pickup, instance))
    return 0;

  if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE() && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    if(isDefined(pickup.instance) && isDefined(pickup.instance.classname) && pickup.instance.classname == "scriptable_br_plunder_box") {
      if(!isDefined(player._id_44172449614F0738))
        player._id_44172449614F0738 = 0;

      player._id_44172449614F0738 = player._id_44172449614F0738 + 1;
    }
  }

  if(!isDefined(instance) || instance getscriptableisloot() && !_id_B6B71C738C7F7CA4(instance)) {
    results = undefined;

    if(istrue(_id_1A33360665B6BB36))
      results = 20;
    else
      results = player cantakepickup(pickup, getdvarint("dvar_8225B8D33C1565C6", 1) && !istrue(_id_A5B2C541413AA895));

    if((results == 1 || results == 20) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onPickupWeapon") && isweaponpickupitem(pickup)) {
      weapon = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, weapon, pickup._id_4E479E14D0837E84);
    }

    if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F()) {
      if(results == 1 || results == 20 || results == 5 || results == 27) {
        if(player scripts\mp\calloutmarkerping_mp::_id_C28D94289C4A6ECD(instance))
          player thread _id_396A814D39E7044F::_id_36EDF91561322753(3);
        else if(player scripts\mp\calloutmarkerping_mp::_id_4864C58AB9B1F07E(instance, 1))
          player thread _id_396A814D39E7044F::_id_36EDF91561322753(3);
      }
    }

    if(results == 1)
      return _id_60234AA487445085(pickup, player, _id_A5B2C541413AA895, instance);
    else if(results == 20)
      return _id_08F0BD51F5C6108B(pickup, player, _id_A5B2C541413AA895, instance);
    else if(results == 5 || results == 27) {
      _id_DD515FCF025B2E79 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
      _id_60227BFF1E9478CC.origin = pickup.origin;
      _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

      if(results == 5)
        _id_60234AA487445085(_id_60227BFF1E9478CC, player);
      else
        _id_08F0BD51F5C6108B(_id_60227BFF1E9478CC, player);

      if(isDefined(instance))
        loothide(instance);

      _id_56DD1FAA25A3414F(player, pickup, results);
    } else {
      if(getdvarint("dvar_C031BA1736951FAE", 1) && results != 28 && results != 2 && results != 10 && results != 9 && results != 13 && results != 33 && results != 35 && results != 11 && results != 16 && results != 8 && results != 36 && results != 7 && results != 37 && player _id_3583FF375AB3A91E::_id_C84E254980C7C8ED() && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && isDefined(instance) && !istrue(_id_A5B2C541413AA895)) {
        _id_491C9B4E02748831 = instance;
        _id_491C9B4E02748831.contents = [];
        _id_491C9B4E02748831._id_46A3A8565AC0C17C = 14;
        _id_491C9B4E02748831.contents[0] = [];
        _id_491C9B4E02748831.contents[0]["quantity"] = pickup.count;
        _id_491C9B4E02748831.contents[0]["lootID"] = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);

        if(_id_02D86BA79A58BB62(pickup.scriptablename)) {
          _id_491C9B4E02748831.contents[0]["extraInfoEnt"] = undefined;
          _id_491C9B4E02748831.contents[0]["extraInfoTeam"] = undefined;

          if(isDefined(pickup.instance._id_1FAF51A7DC279A8B))
            _id_491C9B4E02748831.contents[0]["extraInfoEnt"] = pickup.instance._id_1FAF51A7DC279A8B;

          if(isDefined(pickup.instance._id_B939ABDEDC45C697))
            _id_491C9B4E02748831.contents[0]["extraInfoTeam"] = pickup.instance._id_B939ABDEDC45C697;
        }

        scripts\mp\loot::_id_68CA06034B8AACCD(player, _id_491C9B4E02748831);
        return 0;
      }

      _id_8DDE4AC0085463FC = 1;
      _id_0BB9E46E1D8130F2 = level.br_pickups.br_hasautopickup[pickup.scriptablename];

      if(isDefined(_id_A5B2C541413AA895) && isDefined(_id_0BB9E46E1D8130F2)) {
        if(_id_A5B2C541413AA895 && istrue(_id_0BB9E46E1D8130F2) && state == "visible")
          _id_8DDE4AC0085463FC = 0;
      }

      if(results == 17)
        _id_8DDE4AC0085463FC = 0;

      if(_id_A45EE992E46A29F1(pickup.scriptablename))
        _id_8DDE4AC0085463FC = 0;

      if(_id_945D5BC4B5CB8C78(pickup.scriptablename))
        _id_8DDE4AC0085463FC = 0;

      if(results == 38) {
        thread _id_3FF2458477D23489::_id_5D0B1FA9645F3C89(pickup, player);
        _id_8DDE4AC0085463FC = 0;
      }

      if(_id_8DDE4AC0085463FC) {
        if(results == 3)
          player playlocalsound("weap_ammo_full", undefined, undefined, 1);
        else
          player playlocalsound("br_pickup_deny", undefined, undefined, 1);

        player showuseresultsfeedback(results);
      }
    }
  }

  return 0;
}

_id_2AE5E94BD6518AB5(loot, _id_ECCE4AADDE6676E5) {
  scriptablename = _id_155B1A2C8879BDA5(loot);

  if(!isDefined(scriptablename))
    return 1;

  if(_id_A45EE992E46A29F1(scriptablename))
    return _id_ECCE4AADDE6676E5;

  if(_id_32125EBA262380C7(scriptablename) || _id_F48BD2F51721F2FD(scriptablename) || _id_7A345D3F5A65278C(scriptablename) || _id_F262C137ED78E6EB(scriptablename))
    return 0;

  return 1;
}

loothide(instance, part) {
  scriptablename = _id_155B1A2C8879BDA5(instance);

  if(!isDefined(part))
    part = instance.type;

  if(isDefined(scriptablename) && isquesttablet(scriptablename)) {
    if(scripts\mp\flags::gameflag("prematch_done"))
      level notify("tablethide_kill_callout_" + instance.origin);

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::onquesttablethide(instance);
    else
      _id_64ACB6CE534155B7::_id_4D5DD20E109455F2(instance);
  }

  instance _meth_F35957C991FCFD3F();

  if(instance getscriptableisreserved() && !istrue(instance.keepinmap)) {
    deregisterscriptableinstance(instance);
    instance freescriptable();
  } else if(!istrue(instance._id_7B4388C3A450812A))
    instance setscriptablepartstate(part, "hidden");
}

br_forcegivecustompickupitem(player, scriptablename, _id_43FB3D97ABB79854, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585) {
  if(istrue(_id_1E736A37C3737585)) {
    player dropbrcustompickupitem(scriptablename, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585);
    return 1;
  }

  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = scriptablename;
  _id_60227BFF1E9478CC.origin = player.origin;
  _id_60227BFF1E9478CC.count = 0;
  _id_60227BFF1E9478CC.maxcount = level.br_pickups.maxcounts[_id_60227BFF1E9478CC.scriptablename];
  _id_60227BFF1E9478CC.stackable = level.br_pickups.stackable[_id_60227BFF1E9478CC.scriptablename];

  if(istrue(_id_7F437A5779C8787C) && isDefined(player.br_kiosk))
    _id_60227BFF1E9478CC._id_96C7526F4AB04875 = distance2d(player.origin, player.br_kiosk.origin) / 2;

  if(isDefined(_id_8E4538D786FB9418))
    _id_60227BFF1E9478CC.count = _id_8E4538D786FB9418;

  if(!_id_60227BFF1E9478CC.count && isDefined(level.br_pickups.counts[_id_60227BFF1E9478CC.scriptablename]))
    _id_60227BFF1E9478CC.count = level.br_pickups.counts[_id_60227BFF1E9478CC.scriptablename];

  results = player cantakepickup(_id_60227BFF1E9478CC, 1);

  if(results == 1) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);

    if(_id_2CEDCC356F1B9FC8::isarmorplate(_id_60227BFF1E9478CC.scriptablename) && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_60227BFF1E9478CC.scriptablename)) {
      equipname = level.br_pickups.br_equipname[_id_60227BFF1E9478CC.scriptablename];
      slot = level.equipment.table[equipname].defaultslot;
      _id_09FFB530E039A041 = player scripts\mp\equipment::getequipmentslotammo(slot);

      if(!isDefined(_id_09FFB530E039A041))
        _id_09FFB530E039A041 = 0;

      _id_7B207409AE007577 = spawnStruct();
      _id_7B207409AE007577.scriptablename = scriptablename;
      _id_7B207409AE007577.count = _id_60227BFF1E9478CC.count - (level.br_pickups._id_04138F9DDC1CD22D[scriptablename] - _id_09FFB530E039A041);

      if(_id_7B207409AE007577.count > 0) {
        player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_7B207409AE007577);
        _id_60227BFF1E9478CC.count = _id_60227BFF1E9478CC.count - _id_7B207409AE007577.count;
      }
    }

    player onusecompleted(_id_60227BFF1E9478CC, _id_43FB3D97ABB79854, undefined, _id_7F437A5779C8787C);
    return 1;
  } else if(results == 20) {
    lootid = undefined;

    if(_id_2CEDCC356F1B9FC8::isammo(_id_60227BFF1E9478CC.scriptablename))
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_60227BFF1E9478CC.scriptablename);
    else
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);

    if(isDefined(lootid)) {
      if(isweaponpickupitem(_id_60227BFF1E9478CC) || _id_4294E9B331377C31(_id_60227BFF1E9478CC.scriptablename))
        _id_60227BFF1E9478CC.count = 1;

      player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
      return 1;
    }
  }

  return 0;
}

resetplayerinventorywithdelay(_id_90D292BFA34CAC7D, _id_9E83064E74FA428C) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  wait(_id_90D292BFA34CAC7D);
  resetplayerinventory(_id_9E83064E74FA428C);
}

resetplayerinventory(_id_9E83064E74FA428C, _id_F7E8A863407717B3, _id_04C7CADAA72AF79D) {
  _id_07DE7C04BF49817C = scripts\mp\utility\game::getsubgametype() == "kingslayer";
  self.br_inventory_slots = [];

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("armor")) {
    if(!istrue(_id_F7E8A863407717B3))
      _id_07C40FA80892A721::breakarmor();

    if(istrue(self.insertingarmorplate))
      _id_07C40FA80892A721::_id_4504B6B6771998BB("reset_player_inventory");
  }

  if(!istrue(_id_9E83064E74FA428C)) {
    breakgasmaskbr();

    if(!level.allowsupers)
      resetsuper(_id_04C7CADAA72AF79D);

    if(isDefined(self.streakdata) && !_id_07DE7C04BF49817C)
      scripts\mp\killstreaks\killstreaks::removekillstreak(1);

    _id_724736FCF0FB6604::stripweaponsfromplayer();
    scripts\mp\equipment::takeequipment("primary");
    scripts\mp\equipment::takeequipment("secondary");
    scripts\mp\equipment::takeequipment("super");
    scripts\mp\weapons::setlastdroppableweaponobj(makeweapon("iw9_me_fists_mp"));

    if(_id_55E418C5CC946593::_id_C0D385A09D173A36())
      _id_55E418C5CC946593::_id_19868614946C4DF4();

    if(_id_2CEDCC356F1B9FC8::hasselfrevivetoken())
      removeselfrevivetoken();
  }
}

resetsuper(_id_04C7CADAA72AF79D) {
  scripts\mp\supers::clearsuper(undefined, undefined, _id_04C7CADAA72AF79D);
  scripts\mp\equipment::takeequipment("super");
  self setclientomnvar("ui_perk_package_state", 0);
  thread scripts\mp\supers::_id_93B5448EA8F6277B(0);
  _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, "super");
}

resetdefaultweaponammo(magcount) {
  _id_8CAC01EF5BCB1816 = self getweaponslistall();

  for(_id_FE8F7703F6313ED4 = 0; _id_FE8F7703F6313ED4 < _id_8CAC01EF5BCB1816.size; _id_FE8F7703F6313ED4++) {
    weapon = _id_8CAC01EF5BCB1816[_id_FE8F7703F6313ED4];
    stockammo = 0;

    if(weapon.inventorytype == "primary") {
      if(isDefined(magcount)) {
        _id_D63C71101D308076 = weapon.clipsize;
        stockammo = _id_D63C71101D308076 * (magcount - 1);
      } else if(level.magcount > 0) {
        _id_D63C71101D308076 = weapon.clipsize;
        stockammo = _id_D63C71101D308076 * (level.magcount - 1);
      } else
        _id_D63C71101D308076 = 0;

      self setweaponammoclip(weapon, _id_D63C71101D308076);
    }
  }
}

initplayer(_id_756150045B2B7AD8) {
  _id_724736FCF0FB6604::br_ammo_player_clear();
  resetplayerinventory(_id_756150045B2B7AD8);
  level thread _id_CF83A47B811BD132(self);
}

_id_CF83A47B811BD132(player) {
  if(!_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() || !getdvarint("dvar_48D4E35A894B5AFF", 1)) {
    return;
  }
  player notify("watch_backpack_size");
  level endon("game_ended");
  player endon("disconnect");
  player endon("watch_backpack_size");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    if(isDefined(player.attached_bag)) {
      _id_39D303A2954E0791 = _id_877FF2BC34ED0E27(player);

      if(!isDefined(player._id_9190265F4C5CA4C0) || player._id_9190265F4C5CA4C0 != _id_39D303A2954E0791)
        _id_8933B487E22EE213(player, _id_39D303A2954E0791);
    }

    wait 1.0;
  }
}

_id_877FF2BC34ED0E27(player) {
  _id_4755865F44ED3D7E = _id_2D9D24F7C63AC143::_id_6FE7E7891D125C48(player);
  _id_4AC0D9DE9D828350 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player);

  if(_id_4AC0D9DE9D828350 <= 0)
    return "";

  _id_6C8D21B2E54B2478 = _id_4755865F44ED3D7E / _id_4AC0D9DE9D828350;
  _id_43F0AD7C4532C785 = "";

  if(_id_6C8D21B2E54B2478 == 1)
    _id_43F0AD7C4532C785 = "bgfull";
  else if(_id_6C8D21B2E54B2478 >= 0.5)
    _id_43F0AD7C4532C785 = "bghalf";

  return _id_43F0AD7C4532C785;
}

_id_8933B487E22EE213(player, _id_43F0AD7C4532C785) {
  player _meth_1863F51C1339D80F(_id_43F0AD7C4532C785);
  player._id_9190265F4C5CA4C0 = _id_43F0AD7C4532C785;
}

spawndebugpickupfromdevgui(scriptablename, _id_93B8F6E8488B5E94, quantity) {
  foreach(player in level.players) {
    if(!isbot(player) && isalive(player)) {
      spawnpos = player.origin + anglesToForward(player.angles) * 100 + (0, 0, 12);
      _id_494DAFFF3D2C8E06 = 0;

      if(isDefined(level.br_pickups.counts[scriptablename]))
        _id_494DAFFF3D2C8E06 = level.br_pickups.counts[scriptablename];

      if(isDefined(quantity))
        _id_494DAFFF3D2C8E06 = int(quantity);

      _id_CB4FAD49263E20C4 = getitemdropinfo(spawnpos);
      item = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);

      if(istrue(_id_93B8F6E8488B5E94)) {
        item._id_BBC200BC77C5DB2B = 1;
        item._id_8C6CE30A6A5126B1 = 1;
      }

      if(_id_55F0DAEA8408E3A9(scriptablename))
        _id_3AACF02225CA0DA5::_id_3E7EE85CB0D3504C(item);

      if(isquesttablet(scriptablename))
        _id_64ACB6CE534155B7::_id_8A25384BACDD7B79(item, scriptablename);

      if(isDefined(item)) {
        contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
        ignorelist = [];
        caststart = item.origin + (0, 0, 50);
        castend = caststart + (0, 0, -200);
        _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

        if(isDefined(_id_1F0571D36D0DF95B["entity"]) && isDefined(_id_1F0571D36D0DF95B["entity"].targetname) && _id_1F0571D36D0DF95B["entity"].targetname == "train_wz") {
          trainent = _id_1F0571D36D0DF95B["entity"];
          _id_EA3B9640A6AD3C8E = rotatevectorinverted(item.origin - trainent.origin, trainent.angles);
          localangles = combineangles(invertangles(trainent.angles), item.angles);
          item scripts\common\utility::_id_6E506F39F121EA8A(trainent, _id_EA3B9640A6AD3C8E, localangles);
        }
      }
    }
  }
}

_id_C87696A022A2C6FC(_id_D9407D0D9C222CE7) {
  _id_A61C75B156FC1EE0 = level.br_pickups._id_D93566A78E29D583.size;
  _id_E2EBC5C5929B4B54 = sqrt(_id_A61C75B156FC1EE0);
  _id_0C3EAAB1A20FF3CC = level.players[0].origin;
  _id_9A6BA9F5A0E705C7 = 0;

  foreach(index, value in level.br_pickups._id_7B2BFF2D04EE1017) {
    if(istrue(_id_D9407D0D9C222CE7) && isweaponpickup(index)) {
      continue;
    }
    _id_9A6BA9F5A0E705C7 = _id_9A6BA9F5A0E705C7 + 1;
    _id_CB4FAD49263E20C4 = getitemdropinfo(_id_0C3EAAB1A20FF3CC + (20 * (_id_9A6BA9F5A0E705C7 % _id_E2EBC5C5929B4B54), 20 * int(_id_9A6BA9F5A0E705C7 / _id_E2EBC5C5929B4B54), 0));
    item = spawnpickup(index, _id_CB4FAD49263E20C4, 1);
  }
}

_id_510F82785BD2C148() {
  _id_937AF88187007C23 = [];

  foreach(scriptablename, type in level.br_pickups.br_itemtype) {
    if(type == "cache" && (scriptablename == "dmz_crate_wood" || issubstr(scriptablename, "br_loot")))
      _id_937AF88187007C23[_id_937AF88187007C23.size] = scriptablename;
  }

  _id_A61C75B156FC1EE0 = _id_937AF88187007C23.size;
  _id_E2EBC5C5929B4B54 = sqrt(_id_A61C75B156FC1EE0);
  _id_0C3EAAB1A20FF3CC = level.players[0].origin;
  _id_9A6BA9F5A0E705C7 = 0;

  foreach(scriptable in _id_937AF88187007C23) {
    _id_9A6BA9F5A0E705C7 = _id_9A6BA9F5A0E705C7 + 1;
    _id_CB4FAD49263E20C4 = getitemdropinfo(_id_0C3EAAB1A20FF3CC + (60 * (_id_9A6BA9F5A0E705C7 % _id_E2EBC5C5929B4B54), 60 * int(_id_9A6BA9F5A0E705C7 / _id_E2EBC5C5929B4B54), 0));
    item = spawnpickup(scriptable, _id_CB4FAD49263E20C4, 1);

    if(isDefined(item) && item getscriptablehaspart("body"))
      item setscriptablepartstate("body", "closed_usable");
  }
}

_id_B158D838449B637E(_id_4FD8EB3A32C6A55E) {
  _id_CB4FAD49263E20C4 = getitemdropinfo(level.players[0].origin);
  _id_B038ED928EC17A81 = spawnpickup("br_loot_cache", _id_CB4FAD49263E20C4, 1);

  if(!isDefined(_id_B038ED928EC17A81)) {
    return;
  }
  _id_B038ED928EC17A81.contents = [];
  _id_0B6DA601DCCC1197 = strtok(_id_4FD8EB3A32C6A55E, ",");

  foreach(id in _id_0B6DA601DCCC1197) {
    currentindex = _id_B038ED928EC17A81.contents.size;
    _id_B038ED928EC17A81.contents[currentindex] = [];
    _id_B038ED928EC17A81.contents[currentindex]["lootID"] = int(id);
    _id_B038ED928EC17A81.contents[currentindex]["quantity"] = 1;
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(int(id));

    if(isDefined(scriptablename) && isweaponpickup(scriptablename))
      _id_B038ED928EC17A81.contents[currentindex]["ref"] = scriptablename;
  }

  if(_id_B038ED928EC17A81 getscriptablehaspart("body"))
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
}

_id_E2D83DF8B282B199(_id_4FD8EB3A32C6A55E) {
  _id_CB4FAD49263E20C4 = getitemdropinfo(level.players[0].origin);
  _id_B038ED928EC17A81 = spawnpickup("br_loot_cache", _id_CB4FAD49263E20C4, 1);

  if(!isDefined(_id_B038ED928EC17A81)) {
    return;
  }
  items = [];
  _id_0B6DA601DCCC1197 = strtok(_id_4FD8EB3A32C6A55E, ",");
  index = items.size;
  items[index] = [];
  id = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_0B6DA601DCCC1197);
  items[index]["lootID"] = int(id);
  items[index]["quantity"] = 1;
  scripts\mp\loot::_id_40B46E7298657A93(_id_B038ED928EC17A81, level.players, items);

  if(_id_B038ED928EC17A81 getscriptablehaspart("body"))
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
}

isweaponpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "weapon";
}

isweaponpickupitem(item) {
  if(!isDefined(item))
    return 0;

  if(isDefined(item.scriptablename))
    return isweaponpickup(item.scriptablename);
  else if(isDefined(item.weapon))
    return 1;

  return 0;
}

takearmorpickup(pickupent) {
  _id_873C80E924A3F087 = level.br_pickups.br_equipname[pickupent.scriptablename];
  _id_0E233F90AEC7BF0A = _id_07C40FA80892A721::_id_CD4A78B4A236DDC8(_id_873C80E924A3F087);

  if(_id_0E233F90AEC7BF0A)
    tryequiparmor(pickupent);

  level notify("picked_up_item_" + pickupent.scriptablename + "_" + self.team, self);
}

_id_4E335A6589199847(pickupent, _id_A5B2C541413AA895, _id_DB943473454F6EA6, _id_44EE85DCF52B4001, _id_7F437A5779C8787C) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_43044DA0ED44D79F = _id_55E418C5CC946593::_id_43044DA0ED44D79F(pickupent.scriptablename);
  _id_10BBEACB1429824E = 0;
  _id_575AB8E8D68FBB42 = isDefined(self._id_028C944F222F4814._id_183EC729C8876D57);
  _id_0B46AB1E2531A4E2 = istrue(_id_A5B2C541413AA895) || istrue(_id_44EE85DCF52B4001) || !_id_575AB8E8D68FBB42 || !isDefined(_id_DB943473454F6EA6) && !isDefined(_id_44EE85DCF52B4001) || istrue(_id_7F437A5779C8787C);
  _id_A0FEF687A228BA07 = _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && _id_2D9D24F7C63AC143::_id_3D7E44B7E940DE24(lootid, pickupent.count);
  _id_A5BA66A3A80E70F7 = _id_A0FEF687A228BA07 && !_id_0B46AB1E2531A4E2 && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename);
  _id_40467635B1225B49 = istrue(_id_7F437A5779C8787C) && _id_A0FEF687A228BA07 && _id_575AB8E8D68FBB42;
  _id_ABEEB0D8E08896FD = _id_0B46AB1E2531A4E2 && _id_575AB8E8D68FBB42 && !istrue(_id_44EE85DCF52B4001) && !_id_40467635B1225B49;
  targetent = pickupent;

  if(istrue(_id_44EE85DCF52B4001) && !isDefined(_id_DB943473454F6EA6) && isDefined(self._id_02FA5B49969DEF47)) {
    scriptablename = _id_155B1A2C8879BDA5(self._id_02FA5B49969DEF47);

    if(_id_36DE08EA672B354C(scriptablename)) {
      targetent = _func_7E7B315FCB2B9159(pickupent);
      targetent.origin = self._id_02FA5B49969DEF47.origin;
      targetent.angles = self._id_02FA5B49969DEF47.angles;

      if(isDefined(self._id_02FA5B49969DEF47.perks))
        targetent.perks = self._id_02FA5B49969DEF47.perks;
    }
  }

  if(_id_0B46AB1E2531A4E2 || _id_A5BA66A3A80E70F7) {
    _id_EEEAE9DEFA0C1E95 = undefined;

    if(_id_575AB8E8D68FBB42)
      _id_EEEAE9DEFA0C1E95 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(self._id_028C944F222F4814._id_183EC729C8876D57);

    if(_id_40467635B1225B49) {
      index = _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

      if(isDefined(index)) {
        if(_id_55E418C5CC946593::_id_43044DA0ED44D79F(self._id_028C944F222F4814._id_183EC729C8876D57))
          _id_55E418C5CC946593::_id_222999AAD19F5B52(index, self._id_028C944F222F4814.perks);

        _id_2D9D24F7C63AC143::_id_A0CCC23064473A05(self, index, _id_EEEAE9DEFA0C1E95, 1);
        _id_55E418C5CC946593::_id_19868614946C4DF4();
        _id_575AB8E8D68FBB42 = 0;
        _id_EEEAE9DEFA0C1E95 = undefined;
      } else if(_id_575AB8E8D68FBB42)
        _id_ABEEB0D8E08896FD = 1;
    }

    _id_55E418C5CC946593::_id_C3023358DC648BF1(targetent, _id_ABEEB0D8E08896FD, _id_A5B2C541413AA895, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);

    if(isDefined(_id_EEEAE9DEFA0C1E95) && istrue(_id_44EE85DCF52B4001) && _id_575AB8E8D68FBB42)
      _id_2D9D24F7C63AC143::_id_3C3EE4C5700E0E32(self, _id_DB943473454F6EA6, _id_EEEAE9DEFA0C1E95, 1, 1, 6);
    else if(istrue(_id_44EE85DCF52B4001) && !_id_575AB8E8D68FBB42)
      _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_DB943473454F6EA6, 1);
  } else
    _id_10BBEACB1429824E = 1;

  return _id_10BBEACB1429824E;
}

_id_1DF16A3922616CD8(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_10BBEACB1429824E = 0;

  if(pickupissameasequipmentslot(equipname, slot)) {
    _id_5324597EDFAFF57C = scripts\mp\equipment::getequipmentslotammo(slot);

    if(_id_5324597EDFAFF57C == 0 && pickupent.count > 0) {
      _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
      _id_0EC0F9AD939B29E0::_id_30CD943D877DC29F(pickupent.count);
      scripts\mp\equipment::setequipmentammo(equipname, 1);
    }

    if(isDefined(_id_DB943473454F6EA6)) {
      _id_2D9D24F7C63AC143::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, pickupent.count * -1);
      _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, slot);
    }

    if(_id_5324597EDFAFF57C > 0) {
      if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
        _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickupent);
      } else {
        _id_3A4D41C141D89042 = pickupent.count;
        _id_57D1237E118F28D7 = _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();

        if(_id_3A4D41C141D89042 > _id_57D1237E118F28D7) {
          _id_10BBEACB1429824E = pickupent.count;
          _id_0EC0F9AD939B29E0::_id_30CD943D877DC29F(_id_3A4D41C141D89042);
        }
      }
    }
  } else if(!isDefined(self.equipment[slot]) || scripts\mp\equipment::getequipmentslotammo(slot) == 0) {
    scripts\mp\equipment::giveequipment(equipname, slot);
    _id_0EC0F9AD939B29E0::_id_30CD943D877DC29F(pickupent.count);
    scripts\mp\equipment::setequipmentammo(equipname, 1);

    if(isDefined(_id_DB943473454F6EA6)) {
      _id_9145F7D1B47A57D4 = _id_0B7A9CE0A2282B79::_id_F1C7356A808E9BD9(slot);
      _id_2D9D24F7C63AC143::_id_B4E3D555D6D737BB(self, _id_DB943473454F6EA6, _id_9145F7D1B47A57D4);
    } else
      _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  } else if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && !isDefined(_id_DB943473454F6EA6) && _id_82C2DC3D57D67F52()) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);

    if(_id_2D9D24F7C63AC143::_id_3D7E44B7E940DE24(lootid, pickupent.count)) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_FEB782334DD23A66;
      _id_60227BFF1E9478CC.count = pickupent.count;

      if(isDefined(pickupent._id_96C7526F4AB04875))
        _id_60227BFF1E9478CC._id_96C7526F4AB04875 = pickupent._id_96C7526F4AB04875;

      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
    } else {
      dropstruct = _id_7B9F3966A7A42003();
      dropequipmentinslot(dropstruct, slot, _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined, pickupent);
    }

    _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  } else {
    if(isDefined(_id_DB943473454F6EA6)) {
      _id_2D9D24F7C63AC143::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, pickupent.count * -1);
      _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, slot);
    }

    if(!istrue(level._id_AD82058550E7696B)) {
      dropstruct = _id_7B9F3966A7A42003();
      dropequipmentinslot(dropstruct, slot, _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined, pickupent);
    }

    scripts\mp\equipment::giveequipment(equipname, slot);
    scripts\mp\equipment::setequipmentammo(equipname, 1);
    _id_0EC0F9AD939B29E0::_id_30CD943D877DC29F(pickupent.count);
    _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  }

  return _id_10BBEACB1429824E;
}

takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_10BBEACB1429824E = 0;

  if(pickupissameasequipmentslot(equipname, slot)) {
    if(equipmentslothasroom(pickupent.scriptablename, slot)) {
      _id_5324597EDFAFF57C = scripts\mp\equipment::getequipmentslotammo(slot);
      _id_B5CDF4D935E6AC13 = scripts\mp\equipment::getequipmentmaxammo(equipname);

      if(_id_5324597EDFAFF57C == 0 && pickupent.count > 0)
        _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);

      if(_id_5324597EDFAFF57C + pickupent.count > _id_B5CDF4D935E6AC13) {
        _id_97C23A1323ACC7DF = _id_B5CDF4D935E6AC13 - _id_5324597EDFAFF57C;
        scripts\mp\equipment::setequipmentammo(equipname, _id_B5CDF4D935E6AC13);
        pickupent.count = pickupent.count - _id_97C23A1323ACC7DF;
        _id_10BBEACB1429824E = pickupent.count;
      } else
        scripts\mp\equipment::incrementequipmentslotammo(slot, pickupent.count);

      if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && equipname == "equip_throwing_knife" && !scripts\mp\utility\perk::_hasperk("specialty_equip_throwingKnife"))
        scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_ongive(equipname);

      if(isDefined(_id_DB943473454F6EA6)) {
        _id_2D9D24F7C63AC143::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, -1 * (_id_B5CDF4D935E6AC13 - _id_5324597EDFAFF57C));
        _id_10BBEACB1429824E = 0;
      }

      if(_id_10BBEACB1429824E && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && !isDefined(_id_DB943473454F6EA6) && _id_82C2DC3D57D67F52()) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
        _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickupent);
        _id_10BBEACB1429824E = 0;
      }
    } else if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && !istrue(_id_44EE85DCF52B4001) && _id_82C2DC3D57D67F52()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickupent);
      _id_10BBEACB1429824E = 0;
    }
  } else if(!isDefined(self.equipment[slot]) || scripts\mp\equipment::getequipmentslotammo(slot) == 0) {
    _id_B5CDF4D935E6AC13 = scripts\mp\equipment::getequipmentmaxammo(equipname);
    scripts\mp\equipment::giveequipment(equipname, slot);

    if(pickupent.count > _id_B5CDF4D935E6AC13) {
      _id_97C23A1323ACC7DF = _id_B5CDF4D935E6AC13;
      scripts\mp\equipment::setequipmentammo(equipname, _id_B5CDF4D935E6AC13);
      pickupent.count = pickupent.count - _id_97C23A1323ACC7DF;
      _id_10BBEACB1429824E = pickupent.count;
    } else
      scripts\mp\equipment::setequipmentammo(equipname, pickupent.count);

    if(_id_10BBEACB1429824E && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && _id_82C2DC3D57D67F52()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickupent);
      _id_10BBEACB1429824E = 0;
    }

    if(isDefined(_id_DB943473454F6EA6)) {
      _id_9145F7D1B47A57D4 = _id_0B7A9CE0A2282B79::_id_F1C7356A808E9BD9(slot);
      _id_2D9D24F7C63AC143::_id_B4E3D555D6D737BB(self, _id_DB943473454F6EA6, _id_9145F7D1B47A57D4);
    } else
      _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  } else if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename) && !isDefined(_id_DB943473454F6EA6) && _id_82C2DC3D57D67F52()) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);

    if(_id_2D9D24F7C63AC143::_id_3D7E44B7E940DE24(lootid, pickupent.count)) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      ammocount = scripts\mp\equipment::getequipmentslotammo(slot);
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_FEB782334DD23A66;
      _id_60227BFF1E9478CC.count = ammocount;

      if(isDefined(pickupent._id_96C7526F4AB04875))
        _id_60227BFF1E9478CC._id_96C7526F4AB04875 = pickupent._id_96C7526F4AB04875;

      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
      scripts\mp\equipment::giveequipment(equipname, slot);
      scripts\mp\equipment::setequipmentammo(equipname, pickupent.count);
      _id_10BBEACB1429824E = 0;
    } else {
      dropstruct = _id_7B9F3966A7A42003();
      dropequipmentinslot(dropstruct, slot, _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined, pickupent);
      scripts\mp\equipment::giveequipment(equipname, slot);
      scripts\mp\equipment::setequipmentammo(equipname, pickupent.count);
      _id_10BBEACB1429824E = 0;
    }

    _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  } else {
    if(isDefined(_id_DB943473454F6EA6)) {
      if(pickupent.maxcount == 0)
        pickupent.maxcount = level.br_pickups._id_04138F9DDC1CD22D[pickupent.scriptablename];

      _id_3FA041E4F059BC71 = min(pickupent.maxcount, pickupent.count);
      _id_2D9D24F7C63AC143::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, -1 * _id_3FA041E4F059BC71);
      _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, slot);
    }

    if(!istrue(level._id_AD82058550E7696B)) {
      dropstruct = _id_7B9F3966A7A42003();
      dropequipmentinslot(dropstruct, slot, _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined, pickupent);
    }

    scripts\mp\equipment::giveequipment(equipname, slot);
    scripts\mp\equipment::setequipmentammo(equipname, pickupent.count);
    _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, slot, lootid);
  }

  return _id_10BBEACB1429824E;
}

dropequipmentinslot(dropstruct, slot, _id_7F437A5779C8787C, _id_9BCB02C2619FE05A, _id_DB943473454F6EA6, _id_1AD2DB70C8D01F51, itemtype, _id_4C6EBA41707C461F, pickup) {
  ammocount = scripts\mp\equipment::getequipmentslotammo(slot);

  if(slot == "super") {
    if(scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE() && scripts\mp\supers::issuperready())
      ammocount = 1;
    else if(scripts\mp\supers::_id_52E340D32E36DF3E())
      ammocount = scripts\mp\supers::_id_3889D69492A93008();
  }

  if(isDefined(_id_9BCB02C2619FE05A))
    ammocount = _id_9BCB02C2619FE05A;

  if(!isDefined(_id_1AD2DB70C8D01F51))
    _id_1AD2DB70C8D01F51 = 1;

  _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);

  if(_id_2CEDCC356F1B9FC8::_id_12D9A293931F0455(_id_FEB782334DD23A66))
    ammocount = _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();

  if(_id_907944A173ED27E1(_id_FEB782334DD23A66)) {
    return;
  }
  if(ammocount <= 0) {
    return;
  }
  if(isDefined(_id_FEB782334DD23A66)) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);

    if(isDefined(_id_DB943473454F6EA6)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_2D9D24F7C63AC143::_id_91C1BE871300A518(lootid);
      _id_60227BFF1E9478CC.count = ammocount;
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC, undefined, undefined, _id_7F437A5779C8787C);
    } else {
      _id_285B7129B392CF3D = 0;
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      scriptablename = _id_2D9D24F7C63AC143::_id_91C1BE871300A518(lootid);

      if(isDefined(itemtype))
        _id_285B7129B392CF3D = quickdropaddtoexisting(itemtype, scriptablename, ammocount);

      if(_id_285B7129B392CF3D) {
        return;
      }
      _id_96C7526F4AB04875 = undefined;
      _id_7591ED99E87A77D3 = undefined;

      if(isDefined(pickup)) {
        if(isDefined(pickup._id_3B53BC0EEE6AE84E))
          _id_96C7526F4AB04875 = pickup._id_3B53BC0EEE6AE84E;

        if(isDefined(pickup.origin))
          _id_7591ED99E87A77D3 = pickup.origin;
      }

      baseorigin = self.origin;
      baseangles = self.angles;
      _id_AD49A38DD7C4C10F = level.br_pickups._id_AD49A38DD7C4C10F;

      if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk)) {
        baseorigin = scripts\engine\utility::_id_53C4C53197386572(self.br_kiosk._id_AFC028D00356E443, self.br_kiosk.origin);
        baseangles = self.br_kiosk.angles;
        _id_AD49A38DD7C4C10F = undefined;
      }

      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, _id_AD49A38DD7C4C10F, _id_96C7526F4AB04875, undefined, undefined, _id_7591ED99E87A77D3);

      if(issuperpickup(scriptablename))
        _id_1AD2DB70C8D01F51 = getdvarint("dvar_8C7FD24CB9DC68F0", 0) || _id_1AD2DB70C8D01F51 && isalive(self);

      item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
      quickdropaddtocache(scriptablename, slot, item, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
      _id_2F4E0022C686DBE6(item);

      if(istrue(_id_4C6EBA41707C461F))
        quickdropplaySound(itemtype, _id_CB4FAD49263E20C4.origin, scriptablename, item);

      _id_2D9D24F7C63AC143::_id_C6306EA9715DD8F1(self, slot);
    }
  }
}

pickupissameasequipmentslot(equipname, _id_CBB2B3D05E48BD27) {
  if(isDefined(self.equipment[_id_CBB2B3D05E48BD27]) && self.equipment[_id_CBB2B3D05E48BD27] == equipname)
    return 1;

  return 0;
}

equipmentslothasroom(scriptablename, _id_CBB2B3D05E48BD27) {
  _id_1C437E4320E43045 = level.br_pickups.br_equipname[scriptablename];

  if(isDefined(_id_1C437E4320E43045) && scripts\mp\equipment::getequipmentslotammo(_id_CBB2B3D05E48BD27) < scripts\mp\equipment::getequipmentmaxammo(_id_1C437E4320E43045))
    return 1;

  return 0;
}

_id_E52B0B5AB01DFA0C(_id_A1093166DE09E6B8, _id_257C3DB6F4BFDD81) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A1093166DE09E6B8);
  _id_AE026DF45F72858C = _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
  _id_5BC83C04FC824511 = 0;
  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount) || maxcount == 0)
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  if(maxcount > 0)
    _id_5BC83C04FC824511 = floor(_id_AE026DF45F72858C / maxcount);

  if(_id_5BC83C04FC824511 >= _id_257C3DB6F4BFDD81)
    return 0;

  return 1;
}

takerespawntokenpickup(pickupent) {
  if(!respawntokendisabled() && !_id_2CEDCC356F1B9FC8::hasrespawntoken()) {
    addrespawntoken();
    return 1;
  }

  return 0;
}

addrespawntoken(skipsplash) {
  player = self;
  player.hasrespawntoken = 1;
  player _id_2CEDCC356F1B9FC8::sethasrespawntokenextrainfo(1);

  if(!istrue(skipsplash))
    player thread scripts\mp\hud_message::showsplash("br_respawn_token_pickup");
}

removerespawntoken() {
  player = self;
  player.hasrespawntoken = 0;
  player _id_2CEDCC356F1B9FC8::sethasrespawntokenextrainfo(0);
}

_id_68C46FE15ED38D9B(pickupent) {
  if(!_id_2CEDCC356F1B9FC8::_id_8B2396647673BE50() && istrue(level.usegulag) && !_id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A()) {
    _id_127474F04C3A06B5();
    return 1;
  }

  return 0;
}

_id_127474F04C3A06B5(skipsplash) {
  player = self;
  player._id_15DA77DC195BD80A = 1;
  player _id_2CEDCC356F1B9FC8::_id_E58801ACF7ADCDC8(1);

  if(!istrue(skipsplash))
    player thread scripts\mp\hud_message::showsplash("br_gulag_token_pickup");
}

_id_17E127F2E3771058() {
  player = self;
  player._id_15DA77DC195BD80A = 0;
  player _id_2CEDCC356F1B9FC8::_id_E58801ACF7ADCDC8(0);
}

takerevivepickup(pickupent, itemslotindex, _id_44EE85DCF52B4001) {
  if(!_id_2CEDCC356F1B9FC8::hasselfrevivetoken() || _id_2CEDCC356F1B9FC8::hasselfrevivetoken() && !_id_2CEDCC356F1B9FC8::_id_723BD1AB3BB16B2B(self, pickupent.scriptablename)) {
    _id_E250AFAEAE6D7B0B = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(pickupent.scriptablename);
    addselfrevivetoken(undefined, _id_E250AFAEAE6D7B0B, itemslotindex, _id_44EE85DCF52B4001);
    return 1;
  }

  return 0;
}

_id_AAAA1B3DFE18885C(skipsplash, _id_E250AFAEAE6D7B0B, itemslotindex, _id_44EE85DCF52B4001) {
  player = self;
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_E250AFAEAE6D7B0B);

  if(player _id_2CEDCC356F1B9FC8::hasselfrevivetoken() && !_id_2CEDCC356F1B9FC8::_id_723BD1AB3BB16B2B(player, scriptablename)) {
    if(istrue(_id_44EE85DCF52B4001) && isDefined(itemslotindex)) {
      _id_BF28FCD9DFEAC57E = _id_2CEDCC356F1B9FC8::_id_791E72676CD7B544(player);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_BF28FCD9DFEAC57E);
      _id_2D9D24F7C63AC143::_id_3C3EE4C5700E0E32(player, itemslotindex, lootid, 1, 65535, 3);
      player removeselfrevivetoken();
    } else {
      dropstruct = _id_7B9F3966A7A42003();
      player dropbrselfrevivetoken(dropstruct);
    }
  } else if(istrue(_id_44EE85DCF52B4001) && isDefined(itemslotindex))
    player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(itemslotindex);

  player._id_6C05B62D5521A0B2 = spawnStruct();
  player._id_6C05B62D5521A0B2.name = scriptablename;
  player._id_6C05B62D5521A0B2.type = _id_2CEDCC356F1B9FC8::_id_56733D929B67A814(scriptablename);
  player._id_6C05B62D5521A0B2.perk = _id_2CEDCC356F1B9FC8::_id_8E65095B82C19D04(scriptablename);
  player setclientomnvar("ui_br_self_revive_type", player._id_6C05B62D5521A0B2.type);

  if(isDefined(player._id_6C05B62D5521A0B2.perk))
    player scripts\mp\utility\perk::giveperk(player._id_6C05B62D5521A0B2.perk);

  player _id_2CEDCC356F1B9FC8::sethasselfrevivetokenextrainfo(1);

  if(!istrue(skipsplash))
    player thread scripts\mp\hud_message::showsplash("br_self_revive_token_pickup");

  _id_04AD7C03EC4FA687 = level.maxteamsize == 1;

  if(_id_04AD7C03EC4FA687 && !player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
    player scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
}

addselfrevivetoken(skipsplash, _id_E250AFAEAE6D7B0B, itemslotindex, _id_44EE85DCF52B4001) {
  if(!isDefined(_id_E250AFAEAE6D7B0B))
    _id_E250AFAEAE6D7B0B = 8548;

  _id_AAAA1B3DFE18885C(skipsplash, _id_E250AFAEAE6D7B0B, itemslotindex, _id_44EE85DCF52B4001);
  _id_0B7A9CE0A2282B79::_id_C0AE57D4DC3A8EEF(self, _id_E250AFAEAE6D7B0B);
  level notify("picked_up_item_brloot_self_revive_" + self.team, self);
}

removeselfrevivetoken() {
  player = self;

  if(player _id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
    _id_F1CED1FC8297B8D2 = _id_2CEDCC356F1B9FC8::_id_7285C46EE8B26043(player);

    if(isDefined(_id_F1CED1FC8297B8D2) && player scripts\mp\utility\perk::_hasperk(_id_F1CED1FC8297B8D2))
      player scripts\mp\utility\perk::removeperk(_id_F1CED1FC8297B8D2);

    player _id_2CEDCC356F1B9FC8::sethasselfrevivetokenextrainfo(0);
    _id_04AD7C03EC4FA687 = level.maxteamsize == 1;

    if(_id_04AD7C03EC4FA687 && player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
      player scripts\mp\utility\perk::removeperk("specialty_pistoldeath");

    _id_0B7A9CE0A2282B79::_id_0A60428CDA4724A7(self);
    player._id_6C05B62D5521A0B2 = undefined;
  }
}

respawntokendisabled() {
  return getdvarint("dvar_4D250E4873E1753E", 0) || !istrue(level.br_pickups.respawntokenenabled) || istrue(level.br_pickups.respawntokenclosewithgulag) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

fillmaxarmorplate() {
  player = self;
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = "brloot_armor_plate";
  _id_60227BFF1E9478CC.equipname = level.br_pickups.br_equipname[_id_60227BFF1E9478CC.scriptablename];
  _id_60227BFF1E9478CC.origin = self.origin;
  _id_60227BFF1E9478CC.maxcount = scripts\mp\equipment::getequipmentmaxammo(_id_60227BFF1E9478CC.equipname);
  _id_60227BFF1E9478CC.count = _id_60227BFF1E9478CC.maxcount;
  _id_60227BFF1E9478CC.stackable = level.br_pickups.stackable[_id_60227BFF1E9478CC.scriptablename];
  player takeequipmentpickup(_id_60227BFF1E9478CC);
}

takeaccesscardpickup(pickupent) {
  if(_id_2CEDCC356F1B9FC8::hasaccesscard()) {
    dropstruct = _id_7B9F3966A7A42003();
    _id_AD49A38DD7C4C10F = undefined;
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, _id_AD49A38DD7C4C10F, pickupent._id_96C7526F4AB04875, undefined, undefined, pickupent.origin);
    spawnpickup(self.accesscard, _id_CB4FAD49263E20C4, 1, 1);
  }

  addaccesscard(pickupent.scriptablename);
}

addaccesscard(_id_A9F79680FF8B04AB) {
  player = self;
  player.accesscard = _id_A9F79680FF8B04AB;
  _id_4DC292C559481471 = int(tablelookup("mp/braccess_card.csv", 1, _id_A9F79680FF8B04AB, 0));
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("bunkerKeycardType", _id_4DC292C559481471);
}

removeaccesscard() {
  player = self;

  if(!getdvarint("dvar_8C6E1C43E3D41DD3", 0)) {}

  player.accesscard = undefined;
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("bunkerKeycardType", 0);
}

_id_7CB3C8630787467E(item) {
  player = self;

  if(!isDefined(player._id_1366E50D254F3F08))
    player._id_1366E50D254F3F08 = [];

  if(istrue(player._id_1366E50D254F3F08[item])) {
    scripts\mp\utility\script::demoforcesre("Trying to give persistent item player already has. Item: \"" + item + "\"");
    return;
  }

  player._id_1366E50D254F3F08[item] = 1;
  _id_5C9DDCF56D36F133 = player getclientomnvar("ui_persistent_item_status");
  _id_E0A2BFDA9DA11175 = player _id_6AFF3948CF4CCA03::_id_5EFEFF555D3C3AB4(item);
  _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + (1 << _id_E0A2BFDA9DA11175);
  player setclientomnvar("ui_persistent_item_status", _id_5C9DDCF56D36F133);
}

_id_B53322F9ACA1B83B(item) {
  player = self;

  if(!isDefined(player._id_1366E50D254F3F08) || !istrue(player._id_1366E50D254F3F08[item])) {
    scripts\mp\utility\script::demoforcesre("Trying to take persistent item player doesn't have. Item: \"" + item + "\"");
    return;
  }

  player._id_1366E50D254F3F08[item] = undefined;
  _id_5C9DDCF56D36F133 = player getclientomnvar("ui_persistent_item_status");
  _id_E0A2BFDA9DA11175 = player _id_6AFF3948CF4CCA03::_id_5EFEFF555D3C3AB4(item);
  _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 - (1 << _id_E0A2BFDA9DA11175);
  player setclientomnvar("ui_persistent_item_status", _id_5C9DDCF56D36F133);
}

_id_E351A4B1C26EC991(item) {
  player = self;

  if(!isDefined(player._id_1366E50D254F3F08))
    return 0;

  return istrue(player._id_1366E50D254F3F08[item]);
}

_id_B379C8B0A6564107(pickupent) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, pickupent);
}

_id_8A121226BD7BF630(pickupent) {}

_id_0AFCB53228E48F6A(pickupent) {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B67884DBD46199B8");
  thread scripts\mp\hud_message::showsplash("dmz_loot_xp");
  _id_5762AC2F22202BA2::hudicontype("xp_pickup");
  pickupent.instance disablescriptableplayeruse(self);
}

_id_ED254D7BE7FF977A(pickupent) {
  _id_A89E936650684174 = 0;

  if(pickupent _id_728FFCEE8CBF30EE::_id_5FACFBEE97E1A98E())
    _id_A89E936650684174 = pickupent _id_728FFCEE8CBF30EE::_id_699D3AFB882FD365();

  _id_A88E9F0ADD4FEEB3 = 0;

  if(pickupent _id_728FFCEE8CBF30EE::_id_668FA8D4516F7E15())
    _id_A88E9F0ADD4FEEB3 = pickupent _id_728FFCEE8CBF30EE::_id_BD7732605A7843B2(self);

  shouldpickup = _id_A89E936650684174 || _id_A88E9F0ADD4FEEB3;
  _id_8FB765E581AAF658 = pickupent _id_728FFCEE8CBF30EE::_id_10949665EFA60B20();

  if(isDefined(_id_8FB765E581AAF658) && istrue(shouldpickup)) {
    if(!pickupent _id_728FFCEE8CBF30EE::_id_D0DAEA8E27167BF7(self))
      return 33;

    pickupent.scriptablename = _id_8FB765E581AAF658;
  }

  if(istrue(shouldpickup))
    return _id_CBBF9BF3544DC456(pickupent);
  else {
    pickupent.instance.count = 1;
    return 1;
  }
}

addspecialistbonuspickup(skipsplash) {
  player = self;

  if(getdvarint("dvar_BE1B706F310C8E63", 0) == 0)
    self playsoundtoplayer("br_legendary_loot_pickup", self);

  player.hasbrspecialistbonus = 1;
  player scripts\mp\perks\perks::addspecialistbonus();

  if(!istrue(skipsplash))
    player thread scripts\mp\hud_message::showsplash("specialist_perk_bonus");
}

removespecialistbonuspickup() {
  player = self;
  player.hasbrspecialistbonus = 0;
  player scripts\mp\perks\perks::removespecialistbonus();
}

forcegivekillstreak(_id_A4E8372932B8612C, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6, _id_44EE85DCF52B4001, pickup) {
  self notify("cancel_all_killstreak_deployments");

  if(istrue(_id_1E736A37C3737585)) {
    dropstruct = _id_7B9F3966A7A42003();

    if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      _id_E1D097C517C3AF5B = self.br_kiosk _id_4F4D537C794B2BF5();
      self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = self.br_kiosk.dropstruct;
    }

    _id_AA702BCDEEB2B827(dropstruct, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_A4E8372932B8612C, pickup);
    return;
  }

  if(istrue(_id_44EE85DCF52B4001) && isDefined(_id_DB943473454F6EA6))
    _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_DB943473454F6EA6);

  if(istrue(_id_A5AB866673E5E99D)) {
    dropstruct = _id_7B9F3966A7A42003();

    if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      _id_E1D097C517C3AF5B = self.br_kiosk _id_4F4D537C794B2BF5();
      self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = self.br_kiosk.dropstruct;
    }

    dropbrkillstreak(dropstruct, _id_7F437A5779C8787C, _id_DB943473454F6EA6, undefined, pickup);

    if(isDefined(_id_DB943473454F6EA6))
      _id_0B7A9CE0A2282B79::_id_28550536EBAFE216(self);
  } else
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

  scripts\mp\killstreaks\killstreaks::awardkillstreak(_id_A4E8372932B8612C, "other", undefined, undefined, undefined, 1);
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(_id_A4E8372932B8612C));
  _id_0B7A9CE0A2282B79::_id_AA051314F7CDAB4E(self, lootid);
}

takekillstreakpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001) {
  _id_A4E8372932B8612C = level.br_pickups._id_14BD11727C4B6629[pickupent.scriptablename];

  if(_id_A7CC24F3A189746A(_id_A4E8372932B8612C))
    _id_381D14FB6E6ACA9A(_id_A4E8372932B8612C);
  else
    forcegivekillstreak(_id_A4E8372932B8612C, 1, _id_7F437A5779C8787C, 0, _id_DB943473454F6EA6, _id_44EE85DCF52B4001, pickupent);
}

hasanykillstreak() {
  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0)
    return isDefined(self.streakdata.streaks[1]);

  return 0;
}

haskillstreak(_id_A4E8372932B8612C) {
  return hasanykillstreak() && self.streakdata.streaks[1].streakname == _id_A4E8372932B8612C;
}

_id_81B00A2BA10C143A(_id_A4E8372932B8612C) {
  if(haskillstreak(_id_A4E8372932B8612C)) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[1];
    return _id_16EFCF27E6EFCBE8.available == 1;
  }

  return 0;
}

_id_A7CC24F3A189746A(_id_A4E8372932B8612C) {
  _id_13891006B82442F3 = 0;

  switch (_id_A4E8372932B8612C) {
    case "circle_peek":
      _id_13891006B82442F3 = 1;
      break;
  }

  return _id_13891006B82442F3;
}

_id_381D14FB6E6ACA9A(_id_A4E8372932B8612C) {
  _id_159EC9A052E1EFDA = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(_id_A4E8372932B8612C);

  if(isDefined(_id_159EC9A052E1EFDA) && isDefined(_id_159EC9A052E1EFDA._id_0B1469BCDAEC75A9))
    self[[_id_159EC9A052E1EFDA._id_0B1469BCDAEC75A9]]();
}

forceusekillstreak(_id_A4E8372932B8612C) {
  if(hasanykillstreak())
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

  scripts\mp\killstreaks\killstreaks::awardkillstreak(_id_A4E8372932B8612C, "other");
  _id_16EFCF27E6EFCBE8 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);
  _id_E4AECB271D56914B = scripts\mp\killstreaks\killstreaks::triggerkillstreak(_id_16EFCF27E6EFCBE8, 1);

  if(!_id_E4AECB271D56914B)
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

  return _id_E4AECB271D56914B;
}

_givebrsuper(equipname, _id_5237A188CCDA4D7B, _id_F29E7E3311257C37) {
  if(level.allowsupers || istrue(self._id_678855513F5076CA) && !scripts\mp\supers::_id_F95BCCA44E8CBA53(_id_5237A188CCDA4D7B)) {
    scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(_id_5237A188CCDA4D7B);
    scripts\mp\supers::_id_08C7B1312CF5986B(0);
    _id_F29E7E3311257C37 = scripts\mp\supers::getcurrentsuperpoints() >= scripts\mp\supers::getsuperpointsneeded();
  } else
    _id_9EC0D84BC12B8D15(_id_5237A188CCDA4D7B);

  if(isDefined(equipname)) {
    scripts\mp\equipment::giveequipment(equipname, "super");
    scripts\mp\equipment::setequipmentammo(equipname, _id_F29E7E3311257C37);
  }
}

_id_9EC0D84BC12B8D15(_id_5237A188CCDA4D7B) {
  scripts\mp\perks\perkpackage::perkpackage_giveimmediate(_id_5237A188CCDA4D7B);
  self._id_1066FBD86C88A6DF = 1;
  thread _id_390EAF44F2E0F0CC(_id_5237A188CCDA4D7B);

  if(isDefined(self.super.staticdata._id_70B09ED29C10732F))
    self thread[[self.super.staticdata._id_70B09ED29C10732F]]();
}

_id_390EAF44F2E0F0CC(_id_5237A188CCDA4D7B) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_perk_package_state", 3);
  self setclientomnvar("ui_perk_package_super1", scripts\mp\supers::getsuperid(_id_5237A188CCDA4D7B));
  thread scripts\mp\supers::_id_93B5448EA8F6277B(1);
  thread scripts\mp\supers::_id_BDCBE42D37001209(2);
}

_id_1615EAEC0C470F4F(equipname, _id_5237A188CCDA4D7B) {
  self._id_1066FBD86C88A6DF = 1;
  self setclientomnvar("ui_perk_package_state", 3);
  self setclientomnvar("ui_perk_package_super1", scripts\mp\supers::getsuperid(_id_5237A188CCDA4D7B));
  thread scripts\mp\supers::_id_93B5448EA8F6277B(1);
  thread scripts\mp\supers::_id_BDCBE42D37001209(2);

  if(isDefined(equipname))
    scripts\mp\equipment::setequipmentammo(equipname, 1);
}

_id_FCDE72DCBCEC206B() {
  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return undefined;

  if(isDefined(_id_19163E14365D9264.staticdata.useweapon))
    return scripts\mp\supers::_id_3889D69492A93008();
  else
    return scripts\mp\equipment::getequipmentslotammo("super");
}

_id_ADD28651639056B9() {
  _id_A1566100E7DF492E = scripts\mp\supers::_id_45C01CF6EBB2BA62();
  _id_EEC1B23802E9C80B = scripts\mp\supers::getsuperpointsneeded();
  _id_1E2EDCFD539B12CC = scripts\mp\supers::_id_395A9CB3EBE25D55(self.super) * _id_A1566100E7DF492E * _id_EEC1B23802E9C80B;
  scripts\mp\supers::setsuperbasepoints(_id_EEC1B23802E9C80B - _id_1E2EDCFD539B12CC, undefined, 1);
}

_id_23AC735F86C58BF4() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("super_started");
  self endon("remove_super");
  wait 0.05;
  self setclientomnvar("ui_super_can_use", 1);
}

takesuperpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  _id_5237A188CCDA4D7B = level.br_pickups._id_14BD11727C4B6629[pickupent.scriptablename];
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_D539AF51A08B192D = 0;

  if(isDefined(self.super) && scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
    _id_D539AF51A08B192D = scripts\mp\supers::getcurrentsuperpoints() >= scripts\mp\supers::getsuperpointsneeded();

  if(isDefined(_id_DB943473454F6EA6)) {
    _id_2D9D24F7C63AC143::_id_84772EBF836AF5DB(_id_DB943473454F6EA6, pickupent.count * -1);
    _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, "super");
  }

  if(_id_DF3F5431C93ED5A1(undefined, pickupent.scriptablename) && _id_799D521F485A1701::_id_59566A4CE3C2C3E2())
    _id_799D521F485A1701::_id_60D5992F51286201();

  if(isDefined(self.equipment["super"])) {
    if(scripts\mp\equipment::getequipmentslotammo("super") > 0 || _id_D539AF51A08B192D || scripts\mp\supers::_id_52E340D32E36DF3E()) {
      dropstruct = _id_7B9F3966A7A42003();
      dropequipmentinslot(dropstruct, "super", _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined, pickupent);
    }
  }

  _givebrsuper(equipname, _id_5237A188CCDA4D7B, 1);

  if(_id_1BE34022A4ACCE73(pickupent.scriptablename)) {
    scripts\mp\supers::_id_60E9AB8C0AD6A01C(pickupent.count, "all");
    _id_ADD28651639056B9();
  }

  _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(self, "super", lootid);

  if((level.allowsupers || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) && !(scripts\mp\equipment::getequipmentslotammo("super") > 0))
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
}

forcegivesuper(_id_9394537680F9C8A4, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  if(istrue(level._id_D040719163E20394) && _id_9394537680F9C8A4 == "none") {
    return;
  }
  if(_id_9394537680F9C8A4 == "none" && scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_9394537680F9C8A4, "forceGiveSuper"))
    _id_9394537680F9C8A4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_9394537680F9C8A4, "forceGiveSuper")]](_id_9394537680F9C8A4);

  _id_733D60A5F3A8C170 = undefined;

  foreach(scriptablename, _id_5237A188CCDA4D7B in level.br_pickups._id_14BD11727C4B6629) {
    if(_id_5237A188CCDA4D7B == _id_9394537680F9C8A4) {
      _id_733D60A5F3A8C170 = scriptablename;
      break;
    }
  }

  if(!isDefined(_id_733D60A5F3A8C170)) {}

  _id_878C13A767E1D193 = undefined;

  if(isDefined(_id_733D60A5F3A8C170) && !scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
    _id_878C13A767E1D193 = level.br_pickups.br_equipname[_id_733D60A5F3A8C170];

    if(istrue(_id_1E736A37C3737585)) {
      dropstruct = _id_7B9F3966A7A42003();

      if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
        _id_E1D097C517C3AF5B = self.br_kiosk _id_4F4D537C794B2BF5();
        self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
        dropstruct = self.br_kiosk.dropstruct;
      }

      dropbrequipment(dropstruct, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_878C13A767E1D193);
      return;
    }

    if(istrue(_id_A5AB866673E5E99D)) {
      if(isDefined(self.equipment["super"]) && scripts\mp\equipment::getequipmentslotammo("super") > 0) {
        dropstruct = _id_7B9F3966A7A42003();

        if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
          _id_E1D097C517C3AF5B = self.br_kiosk _id_4F4D537C794B2BF5();
          self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
          dropstruct = self.br_kiosk.dropstruct;
        }

        dropequipmentinslot(dropstruct, "super", _id_7F437A5779C8787C, undefined, _id_DB943473454F6EA6, undefined, undefined, undefined);
      }
    }
  }

  _givebrsuper(_id_878C13A767E1D193, _id_9394537680F9C8A4, 1);
}

takegasmask(pickupent, _id_7F437A5779C8787C, itemslotindex, _id_44EE85DCF52B4001) {
  if(istrue(_id_44EE85DCF52B4001) && isDefined(itemslotindex))
    _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(itemslotindex);

  if(!isDefined(pickupent.count) || pickupent.count <= 0) {
    return;
  }
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    _id_CAA51970540DF10D = !istrue(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickupent.scriptablename));

    if(!istrue(_id_CAA51970540DF10D)) {
      if(!istrue(_id_44EE85DCF52B4001)) {
        index = _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

        if(isDefined(index)) {
          _id_1515562147F27975 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(self.gasmasktype);
          _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(self, index, _id_1515562147F27975, int(self.gasmaskhealth));
        } else
          _id_CAA51970540DF10D = 1;
      } else {
        _id_1515562147F27975 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(self.gasmasktype);
        _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(self, itemslotindex, _id_1515562147F27975, int(self.gasmaskhealth));
      }
    }

    if(istrue(_id_CAA51970540DF10D)) {
      dropstruct = _id_7B9F3966A7A42003();
      _id_96C7526F4AB04875 = scripts\engine\utility::ter_op(isDefined(pickupent._id_96C7526F4AB04875), pickupent._id_96C7526F4AB04875, level.br_pickups._id_3B53BC0EEE6AE84E);
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, _id_96C7526F4AB04875, undefined, undefined, pickupent.origin);
      _id_E5D2B8FFAB2A2964 = spawnpickup(self.gasmasktype, _id_CB4FAD49263E20C4, int(self.gasmaskhealth), 1);

      if(_id_2CEDCC356F1B9FC8::isplayeringulag())
        _id_E5D2B8FFAB2A2964._id_1B46A808091EA19C = 1;
    }

    _id_0B7A9CE0A2282B79::_id_777C89585478357B(self);
  }

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
  _id_0B7A9CE0A2282B79::_id_826C883F14E827B3(self, lootid);
  scripts\cp_mp\gasmask::init(pickupent.count, pickupent.scriptablename);
  level notify("picked_up_item_" + pickupent.scriptablename + "_" + self.team, self);
}

_id_00CDF7F2F6BD3207(_id_3170CA906B2241A6) {
  if(!isDefined(self._id_FE63300B318B76B0))
    self._id_FE63300B318B76B0 = [];

  if(isDefined(self._id_FE63300B318B76B0[_id_3170CA906B2241A6])) {
    return;
  }
  self._id_FE63300B318B76B0[_id_3170CA906B2241A6] = 1;
  thread _id_2202E74632488BAC();
}

_id_8206BC54A1ED73CB(_id_3170CA906B2241A6) {
  if(!isDefined(self._id_FE63300B318B76B0))
    self._id_FE63300B318B76B0 = [];

  if(!isDefined(self._id_FE63300B318B76B0[_id_3170CA906B2241A6])) {
    return;
  }
  self._id_FE63300B318B76B0[_id_3170CA906B2241A6] = undefined;
  thread _id_2202E74632488BAC();
}

_id_2202E74632488BAC() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(istrue(self.gasmaskswapinprogress)) {
    scripts\engine\utility::waittill_notify_or_timeout("gas_mask_swap_complete", 2.0);
    waitframe();
  }

  self notify("gasMaskUpdateOnOff");
  self endon("gasMaskUpdateOnOff");
  waittillframeend;
  _id_F4361EA8CE0FBCA4();

  if(istrue(self.gasmaskequipped) && (!isDefined(self._id_FE63300B318B76B0) || !self._id_FE63300B318B76B0.size))
    thread removegasmaskbr();
  else if(!istrue(self.gasmaskequipped) && isDefined(self._id_FE63300B318B76B0) && self._id_FE63300B318B76B0.size)
    thread equipgasmaskbr();
}

_id_F213F06EBA604BBD(player) {
  _id_6B878DA7B46A930F = 0;
  _id_6B878DA7B46A930F = _id_6B878DA7B46A930F | player isreloading();
  _id_6B878DA7B46A930F = _id_6B878DA7B46A930F | player isthrowinggrenade();
  _id_6B878DA7B46A930F = _id_6B878DA7B46A930F | player _meth_E5BF22923D0004BC();
  _id_6B878DA7B46A930F = _id_6B878DA7B46A930F | player issprintsliding();
  _id_6B878DA7B46A930F = _id_6B878DA7B46A930F | player scripts\mp\utility\player::isplayerads();
  return _id_6B878DA7B46A930F;
}

canplaygasmaskgesturebr() {
  player = self;
  _id_C6C1E3E2091F7050 = 0;
  _id_C6C1E3E2091F7050 = _id_C6C1E3E2091F7050 | player isinfreefall();
  _id_C6C1E3E2091F7050 = _id_C6C1E3E2091F7050 | player isskydiving();
  _id_C6C1E3E2091F7050 = _id_C6C1E3E2091F7050 | player isparachuting();
  _id_C6C1E3E2091F7050 = _id_C6C1E3E2091F7050 | player isbasejumpavailable();
  _id_C6C1E3E2091F7050 = _id_C6C1E3E2091F7050 | player ismantling();
  return !_id_C6C1E3E2091F7050;
}

equipgasmaskbr() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskhealth) || self.gasmaskhealth == 0) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  self.gasmaskswapinprogress = 1;
  thread delayedattach(0.2);
  _id_9F955950F47F8532 = self getgestureanimlength("iw9_vm_ges_gasmask_on");

  if(canplaygasmaskgesturebr())
    thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_on", _id_9F955950F47F8532);

  self setclientomnvar("ui_gas_mask", 2);
  wait(_id_9F955950F47F8532);
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("gasmask_male");

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0)
    breakgasmaskbr();
}

removegasmaskbr() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_off_plr", self);
  _id_C8FE6E3CA9715960 = self getgestureanimlength("iw9_vm_ges_gasmask_off");
  thread delayeddetach(1.3);

  if(canplaygasmaskgesturebr())
    thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", _id_C8FE6E3CA9715960);

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 1);
  wait(_id_C8FE6E3CA9715960);
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("");

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0)
    _id_04D16B9C52EFA3B8();
}

breakgasmaskbr() {
  if(!isDefined(self.gasmaskhealth)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_break_plr", self);
  thread delayeddetachbreak(0.6);

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("");

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  _id_04D16B9C52EFA3B8();
  _id_C8FE6E3CA9715960 = self getgestureanimlength("iw9_vm_ges_gasmask_break");
  thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_break", _id_C8FE6E3CA9715960);
  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 3);
  wait(_id_C8FE6E3CA9715960);
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  _id_0B7A9CE0A2282B79::_id_777C89585478357B(self);
  _id_8E9B00A1D2B23D72();
}

delayedattach(_id_74B5B12BB6514385) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0.0)
    wait(_id_74B5B12BB6514385);

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
}

delayeddetach(_id_74B5B12BB6514385) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0.0)
    wait(_id_74B5B12BB6514385);

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

delayeddetachbreak(_id_74B5B12BB6514385) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0.1)
    wait(_id_74B5B12BB6514385 - 0.1);

  playFXOnTag(scripts\engine\utility::getfx("vfx_gas_mask_break"), self, "tag_weapon_left");
  wait 0.1;

  if(istrue(self.gasmaskequipped)) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

_id_A1D897962A19D27E() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    _id_353CC7FAC6358799 = scripts\engine\utility::waittill_any_timeout_1(level._id_5312BC14BD5DB377, "gasmask_buffer_reset");

    if(!isDefined(_id_353CC7FAC6358799) || _id_353CC7FAC6358799 == "timeout") {
      self._id_A18181D8BDAA0DAB = 0;
      return;
    }
  }
}

_id_8E9B00A1D2B23D72() {
  player = self;

  if(!player _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2()) {
    return;
  }
  _id_0D035435A9237F3D = _id_B76F69CE63757CEA("gas_mask_durable");

  if(!_id_0D035435A9237F3D)
    _id_B76F69CE63757CEA("gas_mask");
}

canholdammobox(scriptablename) {
  if(!isDefined(self.br_ammo[scriptablename]))
    return 1;

  return !_id_724736FCF0FB6604::br_ammo_type_player_full(self, scriptablename);
}

isvest(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "armor" && issubstr(scriptablename, "vest");
}

isgasmask(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gear" && issubstr(scriptablename, "gasmask");
}

_id_9A5D18FBDAD686C2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "key" && issubstr(scriptablename, "loot_key_gulag");
}

_id_4F94796425D65F79(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "note";
}

_id_6B5F3FB6550AE6D5(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gear" && issubstr(scriptablename, "iodine_pills");
}

isspecialistbonus(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "specialist" && issubstr(scriptablename, "specialist_bonus");
}

isplunder(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "plunder";
}

_id_34AF0F77C1668DBA(lootid) {
  return isDefined(lootid) && lootid == 8395;
}

isquesttablet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tablet";
}

_id_C7279E910CEFD2A4(scriptablename) {
  if(isquesttablet(scriptablename))
    return issubstr(scriptablename, "elite_arrow");

  return 0;
}

_id_9E3428357E5DF2E3(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "dogtag";
}

_id_A5202E2FC8ECB076(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "extractable" && issubstr(scriptablename, "durable_loot");
}

_id_55F0DAEA8408E3A9(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "weaponcase";
}

_id_F92615E29AFF3602(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "questitem_misc";
}

_id_E4B6260DBB04B43D(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "elite_arrow";
}

_id_9B77601837F66E32(lootid) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(isDefined(scriptablename))
    return _id_E4B6260DBB04B43D(scriptablename);

  return 0;
}

_id_B605A733974C2FF5(lootid) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(isDefined(scriptablename))
    return _id_43E6C697B2FDDE6E(scriptablename);

  return 0;
}

isperkpointpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "perkpoint";
}

istokenpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "token";
}

isrevivepickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "revive";
}

iskillstreak(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "killstreak";
}

_id_233D8364992B23B4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "attachment";
}

issuperpickup(scriptablename) {
  return !isnonequippable(scriptablename) && (isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "super");
}

_id_C7832DF426918C4E(scriptablename) {
  return scriptablename == "brloot_super_hauntedbox";
}

_id_1BE34022A4ACCE73(scriptablename) {
  switch (scriptablename) {
    case "brloot_super_stimpistol":
    case "brloot_super_oxygenmask":
      return 1;
    default:
      return 0;
  }
}

isplunderextract(scriptablename) {
  return scriptablename == "brloot_plunder_extract";
}

_id_4294E9B331377C31(scriptablename) {
  return scriptablename == "brloot_plate_carrier_high_capacity";
}

isaccesscard(scriptablename) {
  return issubstr(scriptablename, "access_card");
}

_id_E066D6B70DDA15F1(scriptablename) {
  return issubstr(scriptablename, "brloot_xp");
}

_id_F262C137ED78E6EB(scriptablename) {
  return issubstr(scriptablename, "activity_starter");
}

_id_82D45592D750D388(scriptablename) {
  return issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key");
}

_id_02D86BA79A58BB62(scriptablename) {
  return issubstr(scriptablename, "loot_multi_key");
}

isnonequippable(scriptablename) {
  return scriptablename == "br_loot_cache" || isquesttablet(scriptablename);
}

_id_7E2F2A69FC0C022B(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "valuable";
}

_id_EAC097CE4C683AB9(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "personal";
}

_id_F48BD2F51721F2FD(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tablet";
}

_id_32125EBA262380C7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "mission";
}

_id_A38E261031751C09(scriptablename) {
  return isDefined(level.br_pickups._id_B8FAD1CFD41D21DA[scriptablename]) && level.br_pickups._id_B8FAD1CFD41D21DA[scriptablename] == 1;
}

_id_A45EE992E46A29F1(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "cache";
}

_id_B989EDD9AF4F42C7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "lethal";
}

_id_D7C5786A0C42EF6C(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tactical";
}

_id_CB1E30930C35F2E2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "nvg";
}

_id_43E6C697B2FDDE6E(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "disguise";
}

_id_4C2B7C5A19471DEC(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "weaponpart";
}

_id_5449DA9D3D0358A4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gascan";
}

_id_F96674BA1A1EC2B3(lootid) {
  if(!isDefined(lootid))
    return 0;

  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptable))
    return 0;

  return _id_5449DA9D3D0358A4(scriptable);
}

_id_7A345D3F5A65278C(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "questsafe";
}

_id_3CAD96C265936DF7(scriptablename) {
  if(!isDefined(level.br_pickups.br_itemtype[scriptablename]))
    return 0;

  switch (scriptablename) {
    case "brloot_super_temp_v":
      return 1;
    default:
      return 0;
  }
}

_id_907944A173ED27E1(scriptablename) {
  if(!isDefined(level.br_pickups.br_itemtype[scriptablename]))
    return 0;

  switch (scriptablename) {
    case "brloot_super_high_jump":
    case "brloot_super_teleport":
    case "brloot_super_laser_charge":
    case "brloot_super_electric_discharge":
      return 1;
    default:
      return 0;
  }
}

_id_945D5BC4B5CB8C78(scriptablename) {
  return scriptablename == "brloot_rock";
}

_id_E68E1669597A3F4D(scriptablename) {
  return scriptablename == "brloot_payment_hacker_phone";
}

_id_B77386F2A0293169(scriptablename) {
  return _id_7E2F2A69FC0C022B(scriptablename) || _id_9E3428357E5DF2E3(scriptablename) || _id_EAC097CE4C683AB9(scriptablename) || _id_32125EBA262380C7(scriptablename);
}

_id_C51FEC498A6283B5(scriptablename) {
  return scriptablename == "brloot_shopkeeper_code";
}

_id_D0BACEE01BFF927C(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "objective";
}

_id_DF3F5431C93ED5A1(lootid, scriptablename) {
  if(!isDefined(scriptablename))
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename))
    return 0;

  return scriptablename == "brloot_offhand_advancedvehicledrop";
}

_id_D345EEC68E01361F(lootid, scriptablename) {
  if(!isDefined(lootid) && !isDefined(scriptablename))
    return 0;

  if(!isDefined(scriptablename))
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename))
    return 0;

  return _id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid) || isgasmask(scriptablename) || _id_5449DA9D3D0358A4(scriptablename) || _id_1BE34022A4ACCE73(scriptablename) || _id_2CEDCC356F1B9FC8::_id_12D9A293931F0455(scriptablename) || _id_C51FEC498A6283B5(scriptablename) || _id_43E6C697B2FDDE6E(scriptablename);
}

_id_4D256360C9588433(_id_1BBEB265EF74BC60, player) {
  _id_93CDBA842F067FEE = tolower(getDvar(_func_2EF675C13CA1C4AF("dvar_6C7B8805D40E0639", _id_1BBEB265EF74BC60)));

  if(!isDefined(_id_93CDBA842F067FEE) || _id_93CDBA842F067FEE == "")
    return 1;

  _id_FC081BBE060BD007 = strtok(_id_93CDBA842F067FEE, " ");
  _id_81A6DCF8641471F7 = tolower(player.name);

  if(scripts\engine\utility::array_contains(_id_FC081BBE060BD007, _id_81A6DCF8641471F7))
    return 1;

  return 0;
}

_id_54DAC56D15DD3D93(ref, lootid, quantity, _id_8598D3D3BC3D9CEB) {
  if(!isDefined(ref) || !isDefined(lootid) || !isDefined(quantity))
    return 0;

  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = ref;
  _id_60227BFF1E9478CC.count = quantity;
  result = _id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, canholdammobox(ref));

  if(result == 1) {
    _id_37BE6E543436F3B3(lootid, undefined, _id_8598D3D3BC3D9CEB, quantity);
    _id_724736FCF0FB6604::br_ammo_give_type(self, ref, quantity, 1);
    return 1;
  } else if(result == 20) {
    _id_37BE6E543436F3B3(lootid, undefined, _id_8598D3D3BC3D9CEB, quantity);
    _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
    return 1;
  } else {
    showuseresultsfeedback(result);
    return 0;
  }
}

_id_99AB09BA7022D107(pickup, isautouse) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
  result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result))
    return 1;
  else if(istrue(isautouse))
    return 12;
  else
    return 4;
}

_id_CBBF9BF3544DC456(pickup, isautouse) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
  result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result))
    return 20;
  else if(istrue(isautouse))
    return 12;
  else
    return 4;
}

_id_F8A3FF0A73FA0C1D(pickup, _id_FB40D5954B4F6792) {
  _id_4BD6D680451253CC = 0;

  if(pickup.count + self.br_ammo[pickup.scriptablename] <= level._id_E6EA72FC5E3FCD00[pickup.scriptablename])
    _id_4BD6D680451253CC = 1;

  _id_2CA75F603DE25B76 = _id_724736FCF0FB6604::_id_D885E66811EE3A4D(pickup.scriptablename);

  if(_id_FB40D5954B4F6792 && _id_2CA75F603DE25B76 && _id_4BD6D680451253CC)
    return 1;

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
  result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result) || _id_2CA75F603DE25B76 && self.br_ammo[pickup.scriptablename] < level._id_E6EA72FC5E3FCD00[pickup.scriptablename])
    return 20;

  return 4;
}

cantakepickup(pickup, _id_8E04B10487B421CE) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("canTakePickup")) {
    result = _id_362C58E8BB39BCDA::runbrgametypefunc("canTakePickup", pickup);

    if(isDefined(result) && result > 0)
      return result;
  }

  if(self isskydiving())
    return 9;

  if(_id_2CEDCC356F1B9FC8::isammo(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::jugg_canuseweaponpickups())
      return 16;

    if(level._id_7582DC4260722BF1 == 1) {
      if(self isreloading() && _id_724736FCF0FB6604::_id_D885E66811EE3A4D(pickup.scriptablename))
        return 2;
    }

    _id_FB40D5954B4F6792 = canholdammobox(pickup.scriptablename);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_F8A3FF0A73FA0C1D(pickup, _id_FB40D5954B4F6792);
    else if(_id_FB40D5954B4F6792)
      return 1;
    else
      return 4;
  }

  isautouse = istrue(pickup.isautouse);

  if(isweaponpickupitem(pickup)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::jugg_canuseweaponpickups())
      return 16;

    if(level._id_BC1086A365D70B30 == 1) {
      if(istrue(self.insertingarmorplate))
        return 13;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle())
      return 17;

    if(istrue(self._id_35DADE814E13D3CE))
      return 23;

    _id_DD515FCF025B2E79 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];

    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

        if(isDefined(_id_60227BFF1E9478CC.scriptablename)) {
          result = _id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, canholdammobox(pickup.scriptablename));

          if(result == 1)
            return 5;
          else if(result == 20)
            return 27;

          return 28;
        } else
          return 28;
      }
    }

    if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
      _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);

      if(issameweapon(_id_9AC5E72784815708, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

        if(isDefined(_id_60227BFF1E9478CC.scriptablename)) {
          result = _id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, canholdammobox(pickup.scriptablename));

          if(result == 1)
            return 5;
          else if(result == 20)
            return 27;

          return 28;
        } else
          return 28;
      }
    }

    if(!isDefined(pickup.lootid))
      pickup.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && _id_2D9D24F7C63AC143::_id_3AB0A87EEAA203BF()) {
      result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(pickup.lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    if(self _meth_B096B58FB3808D26()) {
      if(isautouse && !_id_C8A5593CBB13F17C(pickup, _id_DD515FCF025B2E79))
        return 12;
    }

    return 1;
  }

  if(_id_2CEDCC356F1B9FC8::isequipment(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    equipname = level.br_pickups.br_equipname[pickup.scriptablename];
    slot = level.equipment.table[equipname].defaultslot;
    _id_E52A49E4832AC060 = 1;

    if(isDefined(pickup.count))
      _id_E52A49E4832AC060 = pickup.count;

    if(isautouse && (slot == "primary" || slot == "secondary")) {
      if(isDefined(self.equipment[slot]) && pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(pickup.scriptablename, slot)) {
        if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
          _id_5324597EDFAFF57C = scripts\mp\equipment::getequipmentslotammo(slot);
          lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
          lootid = scripts\engine\utility::ter_op(isDefined(lootid), lootid, 0);
          _id_3793828403C6873E = _id_2D9D24F7C63AC143::_id_106B52ED8F680043(lootid);

          if(!isDefined(_id_3793828403C6873E) || isDefined(_id_5324597EDFAFF57C) && _id_5324597EDFAFF57C > 0)
            return 1;
        } else
          return 1;
      }

      if(!_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
        if(getdvarint("dvar_752EEED3DDCBD04B", 0) && (!isDefined(self.equipment[slot]) || scripts\mp\equipment::getequipmentslotammo(slot) == 0))
          return 1;

        return 12;
      }
    }

    if(!istrue(isautouse) && (!isDefined(self.equipment[slot]) || scripts\mp\equipment::getequipmentslotammo(slot) == 0))
      return 1;

    if(pickupissameasequipmentslot(equipname, slot)) {
      if(equipmentslothasroom(pickup.scriptablename, slot))
        return 1;
      else if(!istrue(isautouse)) {
        if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
          return _id_CBBF9BF3544DC456(pickup, isautouse);
        else
          return 4;
      }
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(!istrue(_id_8E04B10487B421CE))
        return _id_CBBF9BF3544DC456(pickup, isautouse);
      else
        return 1;
    } else
      return 1;
  }

  if(isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit)
      return 11;

    return 1;
  }

  if(isgasmask(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(getdvarint("dvar_752EEED3DDCBD04B", 0) && isautouse && scripts\cp_mp\gasmask::hasgasmask(self)) {
      if(getdvarint("dvar_E3BBC876E8C8249E", 0) && pickup.count > self.gasmaskhealth)
        return 1;

      return 12;
    }

    if(istrue(_id_8E04B10487B421CE))
      return 1;

    if(scripts\cp_mp\gasmask::hasgasmask(self) && pickup.count <= self.gasmaskhealth && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = pickup.scriptablename;
      _id_60227BFF1E9478CC.count = 1;
      return _id_CBBF9BF3544DC456(_id_60227BFF1E9478CC, isautouse);
    }

    return 1;
  }

  if(_id_6B5F3FB6550AE6D5(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_CBBF9BF3544DC456(pickup, isautouse);

    return 1;
  }

  if(isquesttablet(pickup.scriptablename)) {
    _id_8E862883A5F5E641 = getdvarint("dvar_82BDE055B11E6698", 0) != 0;

    if(!_id_8E862883A5F5E641) {}

    if(!_id_8E862883A5F5E641 && !_id_4D256360C9588433(pickup.instance._id_B8EBE3F71A08AB40.type.ref, self))
      return 33;

    if(_id_C7279E910CEFD2A4(pickup.scriptablename)) {
      _id_9C597E5015FF9E26 = getdvarint("dvar_441931632F11125E", 1);

      if(_id_9C597E5015FF9E26) {
        _id_195D33C54EC09E1D = getDvar("dvar_55D6AF015C42AB58", "11200+11201+1001");
        _id_AF989994E05FBDCB = [];

        if(isDefined(_id_195D33C54EC09E1D) && _id_195D33C54EC09E1D.size)
          _id_AF989994E05FBDCB = strtok(_id_195D33C54EC09E1D, "+");

        if(isDefined(_id_AF989994E05FBDCB)) {
          foreach(_id_083858784E9BAE7A in _id_AF989994E05FBDCB) {
            _id_4E1F73945DA1F162 = self _meth_0928FE2F2298BEAC(int(_id_083858784E9BAE7A));

            if(isDefined(_id_4E1F73945DA1F162) && _id_4E1F73945DA1F162)
              return 33;
          }
        }
      }

      result = pickup.instance._id_B8EBE3F71A08AB40 _id_728FFCEE8CBF30EE::_id_8F2A91A76E062B32(self);

      if(isstring(result)) {
        if(result == "too_many_teammates")
          return 35;
      }
    }

    if(pickup.scriptablename == "brloot_blueprintextract_tablet")
      return 1;
    else {
      _id_9CF0B8C1BE24C64D = undefined;

      if(getdvarint("dvar_82BDE055B11E6698", 0))
        _id_9CF0B8C1BE24C64D = scripts\engine\utility::array_contains(level.questinfo.teamsonquests, self.team);
      else
        _id_9CF0B8C1BE24C64D = _id_64ACB6CE534155B7::_id_7094C7010C5E3827(self.team);

      if(_id_9CF0B8C1BE24C64D) {
        if(istrue(self._id_45B8E84DE48BB89F))
          return 38;

        return 10;
      } else
        return 1;
    }
  }

  if(isperkpointpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    return 1;
  }

  if(istokenpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(pickup.scriptablename == "brloot_redeploy_token") {
      if(_id_2CEDCC356F1B9FC8::hasrespawntoken())
        return 8;
      else
        return 1;
    }

    if(pickup.scriptablename == "brloot_gulag_token") {
      if(isDefined(level.gulag) && (_id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A() || _id_67708F418B1FAC79::checkgulagusecount()))
        return 36;
      else
        return 1;
    }

    return 1;
  }

  if(isrevivepickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(pickup.scriptablename == "brloot_self_revive" || pickup.scriptablename == "brloot_battlerage_self_revive") {
      if(_id_2CEDCC356F1B9FC8::hasselfrevivetoken() && _id_2CEDCC356F1B9FC8::_id_723BD1AB3BB16B2B(self, pickup.scriptablename)) {
        if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
          return _id_CBBF9BF3544DC456(pickup, isautouse);
        else if(istrue(isautouse))
          return 12;
        else
          return 14;
      } else
        return 1;
    }

    return 1;
  }

  if(iskillstreak(pickup.scriptablename)) {
    _id_A4E8372932B8612C = level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename];

    if(istrue(self.isjuggernaut))
      return 16;

    if(_id_A7CC24F3A189746A(_id_A4E8372932B8612C)) {
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

    if(istrue(_id_8E04B10487B421CE) && !getdvarint("dvar_752EEED3DDCBD04B", 0)) {
      if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename])
        return _id_CBBF9BF3544DC456(pickup, isautouse);
      else
        return 1;
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && _id_2D9D24F7C63AC143::_id_D674D32C2D3BA5ED(self))
      return _id_CBBF9BF3544DC456(pickup, isautouse);

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename])
      return 7;
    else if(getdvarint("dvar_752EEED3DDCBD04B", 0) && isautouse && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size != 0)
      return 12;
    else
      return 1;
  }

  if(issuperpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;
    else if(_id_DF3F5431C93ED5A1(undefined, pickup.scriptablename) && !_id_799D521F485A1701::_id_81124B7B16101F8B())
      return 37;

    _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuperref();

    if(!scripts\mp\supers::issuperinuse() && !scripts\mp\supers::_id_565913010C84FFCA() && !self isthrowinggrenade()) {
      _id_0C89F07DA007FF0D = scripts\mp\equipment::getequipmentslotammo("super");

      if(getdvarint("dvar_752EEED3DDCBD04B", 0) && isautouse && isDefined(_id_0C89F07DA007FF0D) && _id_0C89F07DA007FF0D != 0)
        return 12;
      else if(!isDefined(_id_0C89F07DA007FF0D) || _id_0C89F07DA007FF0D == 0 || !_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
        if(getdvarint("dvar_FB6FDAA2E155EB88", 0) && isDefined(_id_D3C112E63BF53EE5) && isDefined(level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename]) && level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename] == _id_D3C112E63BF53EE5 && isDefined(_id_0C89F07DA007FF0D) && _id_0C89F07DA007FF0D > 0)
          return 37;
        else
          return 1;
      }
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(istrue(_id_8E04B10487B421CE)) {
        if(isDefined(_id_D3C112E63BF53EE5) && isDefined(level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename]) && level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename] == _id_D3C112E63BF53EE5) {
          result = _id_CBBF9BF3544DC456(pickup);

          if(result == 4 && !scripts\mp\supers::issuperinuse() && !scripts\mp\supers::_id_565913010C84FFCA())
            return 29;
          else
            return result;
        } else if(scripts\mp\supers::issuperinuse() || scripts\mp\supers::_id_565913010C84FFCA()) {
          result = _id_CBBF9BF3544DC456(pickup);

          if(result == 4 && !scripts\mp\supers::issuperinuse())
            return 29;
          else
            return result;
        } else if(self isthrowinggrenade()) {
          result = _id_CBBF9BF3544DC456(pickup);

          if(result != 20)
            result = 2;

          return result;
        } else
          return 1;
      } else if(_id_2D9D24F7C63AC143::_id_5E7049647595AB97() || scripts\mp\supers::issuperinuse() && !scripts\mp\supers::_id_565913010C84FFCA()) {
        result = _id_CBBF9BF3544DC456(pickup);

        if(result == 4 && !scripts\mp\supers::issuperinuse())
          return 29;
        else
          return result;
      }
    }

    return 4;
  }

  if(_id_2CEDCC356F1B9FC8::isarmor(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(_id_07C40FA80892A721::_id_CD4A78B4A236DDC8(level.br_pickups.br_equipname[pickup.scriptablename]))
      return 1;
    else
      return 6;
  }

  if(_id_4294E9B331377C31(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(scripts\mp\utility\perk::_hasperk("specialty_pc_high_capacity")) {
      if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
        return _id_CBBF9BF3544DC456(pickup);
      else
        return 15;
    }

    return 1;
  }

  if(_id_A5202E2FC8ECB076(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(!isDefined(pickup.count))
        pickup.count = 1;

      return _id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(isaccesscard(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_233D8364992B23B4(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_CBBF9BF3544DC456(pickup);
  }

  if(_id_E066D6B70DDA15F1(pickup.scriptablename))
    return 1;

  if(_id_F262C137ED78E6EB(pickup.scriptablename))
    return 1;

  if(_id_82D45592D750D388(pickup.scriptablename)) {
    if(_id_9A5D18FBDAD686C2(pickup.scriptablename)) {
      if(istrue(self._id_43B2A82936A5E974))
        return 23;
      else
        return 1;
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      index = _id_2D9D24F7C63AC143::_id_E05897F5D860188E(lootid, pickup.count, 0);

      if(isDefined(index)) {
        _id_E5FE6C50EC351711 = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(index);

        if(isDefined(_id_E5FE6C50EC351711) && isDefined(_id_E5FE6C50EC351711[1]) && _id_E5FE6C50EC351711[1] > 2)
          return 23;
      }

      return _id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(_id_F92615E29AFF3602(pickup.scriptablename)) {
    if(isDefined(pickup.instance.team) && self.team == pickup.instance.team)
      return 1;
    else
      return 4;
  }

  if(_id_E4B6260DBB04B43D(pickup.scriptablename)) {
    if(pickup _id_728FFCEE8CBF30EE::_id_BD7732605A7843B2(self))
      return _id_ED254D7BE7FF977A(pickup);
  }

  if(isspecialistbonus(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(_id_2CEDCC356F1B9FC8::hasspecialistbonus())
      return 18;

    return 1;
  }

  if(pickup.scriptablename == "brloot_ammo_grenade") {
    if(istrue(self.isjuggernaut))
      return 16;

    _id_F2B2C8DE93EBF806 = scripts\mp\equipment::getequipmentslotammo("primary");
    _id_E93897BC10C40746 = scripts\mp\equipment::getequipmentslotammo("secondary");

    if(isDefined(_id_F2B2C8DE93EBF806) && _id_F2B2C8DE93EBF806 < 2 || isDefined(_id_E93897BC10C40746) && _id_E93897BC10C40746 < 2)
      return 1;
    else
      return 3;
  }

  if(pickup.scriptablename == "Pillage_Cache")
    return 1;

  if(_id_7E2F2A69FC0C022B(pickup.scriptablename) || _id_EAC097CE4C683AB9(pickup.scriptablename) || _id_CB1E30930C35F2E2(pickup.scriptablename) || _id_5449DA9D3D0358A4(pickup.scriptablename) || _id_4F94796425D65F79(pickup.scriptablename) || _id_32125EBA262380C7(pickup.scriptablename) || _id_43E6C697B2FDDE6E(pickup.scriptablename) || _id_4C2B7C5A19471DEC(pickup.scriptablename)) {
    if(isDefined(level._id_D8DB1602C8BF473E[pickup.scriptablename])) {
      result = [[level._id_D8DB1602C8BF473E[pickup.scriptablename]]](pickup, self);

      if(isDefined(result))
        return result;
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_55F0DAEA8408E3A9(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_9E3428357E5DF2E3(pickup.scriptablename)) {
    _id_2391409EF7B431E1::_id_B5D4FCC3FAB92696(pickup);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(pickup.count);

      if(_id_2391409EF7B431E1::_id_D9F5C5090DE1241B(self, pickup.count)) {
        if(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player != self) {
          if(isDefined(level._id_547167A7517600FB)) {
            [[level._id_547167A7517600FB._id_770C1AF7032592A5]](self, level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player);
            return 1;
          }

          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [self], undefined);
        } else if(isDefined(level._id_547167A7517600FB)) {
          [[level._id_547167A7517600FB._id_5B72B9E0891944AE]](self);
          return 1;
        }

        if(isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player))
          _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player, pickup.count);

        return 1;
      } else if(isDefined(level._id_547167A7517600FB)) {
        [[level._id_547167A7517600FB._id_87206CFBD04971FA]](self, level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player);
        return 1;
      }

      return _id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(_id_4EBFDBFA1B8E0339(pickup.scriptablename) || _id_164622EB2B0F5390::_id_1DB5FF7063481DA7(pickup.scriptablename))
    return 1;

  if(_id_B1E944A2B3E15E9D(pickup.scriptablename)) {
    _id_F437251B800FEB88 = _id_2D9D24F7C63AC143::_id_102ABD6883C5F9BF(self) != _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);

    if(_id_F437251B800FEB88)
      return 1;

    return _id_CBBF9BF3544DC456(pickup);
  }

  if(_id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(pickup.scriptablename)) {
    _id_0E9CFD120B0B43EF = _id_2CEDCC356F1B9FC8::_id_692C3DF266580DF6(pickup.scriptablename);

    if(self._id_BED158A6DFAC230D < _id_0E9CFD120B0B43EF || isDefined(self._id_04045F099F3DA4BD) && pickup.scriptablename != self._id_04045F099F3DA4BD)
      return 1;

    return _id_CBBF9BF3544DC456(pickup);
  }

  if(_id_36DE08EA672B354C(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(istrue(_id_8E04B10487B421CE))
      return 1;

    result = _id_CBBF9BF3544DC456(pickup);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && result == 4)
      return 29;

    return result;
  }

  if(_id_D0BACEE01BFF927C(pickup.scriptablename) || _id_9E686AB118AC7725(pickup.scriptablename))
    return 1;

  if(_id_B676E90CFF5CB04D(pickup.scriptablename))
    return 1;

  return 2;
}

isdroppablepickup(_id_C0DD242FFCB18BD2) {
  if(scripts\mp\weapons::isfistweapon(_id_C0DD242FFCB18BD2) || scripts\mp\utility\weapon::isgunlessweapon(_id_C0DD242FFCB18BD2) || scripts\mp\utility\weapon::ismeleeoverrideweapon(_id_C0DD242FFCB18BD2))
    return 0;

  return 1;
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

  if(isDefined(weaponobj)) {
    _id_A48C0A5C6CBA3F2C = getcompleteweaponname(weaponobj);

    if(isDefined(level.br_pickups._id_9E78B5EE377070A9) && isDefined(level.br_pickups._id_9E78B5EE377070A9[_id_A48C0A5C6CBA3F2C]))
      _id_C9C301A888170672 = level.br_pickups._id_9E78B5EE377070A9[_id_A48C0A5C6CBA3F2C];
  }

  if(!isDefined(_id_C9C301A888170672)) {
    if(level._id_7420DDC23AA7B431 != 1) {
      if(isDefined(level.br_pickups.br_weapontoscriptable[_id_C0DD242FFCB18BD2]))
        _id_C9C301A888170672 = level.br_pickups.br_weapontoscriptable[_id_C0DD242FFCB18BD2];
      else if(scripts\engine\utility::array_contains(level.br_pickups.br_weapontoscriptable, _id_C0DD242FFCB18BD2))
        _id_C9C301A888170672 = _id_C0DD242FFCB18BD2;
    }

    if(!isDefined(_id_C9C301A888170672)) {
      if(_id_724736FCF0FB6604::isvalidcustomweapon(weaponobj)) {
        _id_CCE9361200C5117C = _id_2669878CF5A1B6BC::_id_0C9AF9FE37668DF2(weaponobj.basename);

        if(!isDefined(_id_CCE9361200C5117C)) {
          return;
        }
        if(_id_CCE9361200C5117C != "me" && _id_CCE9361200C5117C != "pi" && _id_CCE9361200C5117C != "sh" && _id_CCE9361200C5117C != "sm" && _id_CCE9361200C5117C != "ar" && _id_CCE9361200C5117C != "lm" && _id_CCE9361200C5117C != "dm" && _id_CCE9361200C5117C != "sn" && _id_CCE9361200C5117C != "la" && _id_CCE9361200C5117C != "br" && _id_CCE9361200C5117C != "kn") {
          return;
        }
        _id_EF809B0EE883BCC7 = 1;

        if(_id_CCE9361200C5117C == "br")
          _id_CCE9361200C5117C = "ar";

        _id_C9C301A888170672 = "brloot_weapon_generic_" + _id_CCE9361200C5117C;
      } else if(isdroppablepickup(_id_C0DD242FFCB18BD2))
        _id_C9C301A888170672 = _id_C0DD242FFCB18BD2;
    }
  }

  if(!isDefined(_id_C9C301A888170672)) {
    return;
  }
  _id_1DF19819FC6EF3F7 = "";

  if(issubstr(_id_C9C301A888170672, "me_riotshield") || _id_724736FCF0FB6604::isvalidcustomweapon(weaponobj) && scripts\cp_mp\utility\weapon_utility::isriotshield(weaponobj)) {
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] - 90, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2]);

    if(_id_C9C301A888170672 == "brloot_weapon_generic_me")
      _id_1DF19819FC6EF3F7 = "_riot_shield";
  }

  if(issubstr(_id_C9C301A888170672, "la_juliet")) {
    _id_CB4FAD49263E20C4.angles = (_id_CB4FAD49263E20C4.angles[0] - 4.2, _id_CB4FAD49263E20C4.angles[1], _id_CB4FAD49263E20C4.angles[2] - 90);
    _id_CB4FAD49263E20C4.origin = (_id_CB4FAD49263E20C4.origin[0], _id_CB4FAD49263E20C4.origin[1], _id_CB4FAD49263E20C4.origin[2] + 8.5);
  }

  _id_52AAC7E6E7072413 = level.br_pickups._id_52AAC7E6E7072413[_id_C9C301A888170672];
  _id_52C58DA4C35FDE00 = level.br_pickups._id_52C58DA4C35FDE00[_id_C9C301A888170672];

  if(isDefined(_id_52AAC7E6E7072413))
    _id_CB4FAD49263E20C4.origin = _func_4AD9053267734CF2(_id_52AAC7E6E7072413, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);

  if(isDefined(_id_52C58DA4C35FDE00))
    _id_CB4FAD49263E20C4.angles = _id_52C58DA4C35FDE00 + _id_CB4FAD49263E20C4.angles;

  clearspaceforscriptableinstance();
  item = undefined;

  if(_id_EF809B0EE883BCC7) {
    item = spawncustomweaponscriptable(_id_C9C301A888170672, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles, _id_CB4FAD49263E20C4.payload, weaponobj);

    if(isDefined(item))
      item.customweaponname = getcompleteweaponname(weaponobj);
  } else if(_id_55E418C5CC946593::_id_43044DA0ED44D79F(_id_C9C301A888170672))
    item = spawnscriptable(_id_C9C301A888170672, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles, _id_CB4FAD49263E20C4.payload, _id_CB4FAD49263E20C4._id_A0597A25C511B0AC);
  else if(_id_C9C301A888170672 != "none")
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
      if(_id_1AD2DB70C8D01F51)
        item setscriptablepartstate(_id_DA9F4CD603F44758, "dropped" + _id_1DF19819FC6EF3F7);
      else {
        state = "droppedNoAuto";

        if(!item getscriptableparthasstate(_id_DA9F4CD603F44758, state + _id_1DF19819FC6EF3F7) && getdvarint("dvar_8D10EDE0F25E6D2E", 0))
          state = "dropped";

        item setscriptablepartstate(_id_DA9F4CD603F44758, state + _id_1DF19819FC6EF3F7);
      }
    } else if(!_id_1AD2DB70C8D01F51) {
      state = "noAuto";

      if(!item getscriptableparthasstate(_id_DA9F4CD603F44758, state + _id_1DF19819FC6EF3F7) && getdvarint("dvar_8D10EDE0F25E6D2E", 0))
        state = "dropped";

      item setscriptablepartstate(_id_DA9F4CD603F44758, state + _id_1DF19819FC6EF3F7);
    }
  }

  if(isent(self) && isPlayer(self)) {
    item._id_1EEF5048F92C4951 = self;
    _id_BC7C01A944172176(item, _id_C9C301A888170672);
  }

  _id_AC9B1C5E2187AE62 = level.br_pickups.createcallbacks[_id_C9C301A888170672];

  if(isDefined(_id_AC9B1C5E2187AE62))
    item[[_id_AC9B1C5E2187AE62]]();

  return item;
}

_id_BC7C01A944172176(instance, scriptablename) {
  if(!isDefined(instance) || !isDefined(scriptablename) || !isDefined(self._id_F1CB96C63166B481) || self._id_F1CB96C63166B481.size <= 0) {
    return;
  }
  _id_21CF26F424B79878 = scripts\engine\utility::array_find(self._id_F1CB96C63166B481, scriptablename);

  if(!isDefined(_id_21CF26F424B79878)) {
    return;
  }
  self._id_F1CB96C63166B481[_id_21CF26F424B79878] = undefined;
  instance._id_BBC200BC77C5DB2B = 1;
  instance._id_8C6CE30A6A5126B1 = 1;
}

registerpickupcreatedcallback(_id_C9C301A888170672, callback) {
  level.br_pickups.createcallbacks[_id_C9C301A888170672] = callback;
}

_id_C3E1679F348A5E40(callback) {
  level.br_pickups._id_7C25F4FB48DB3DD4 = scripts\engine\utility::array_add(level.br_pickups._id_7C25F4FB48DB3DD4, callback);
}

showuseresultsfeedback(results) {
  switch (results) {
    case 28:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    case 3:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyammonoroom);
      return;
    case 4:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
      return;
    case 6:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmornotbetter);
      return;
    case 7:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveks);
      return;
    case 8:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_17109B21F99AD76D);
      return;
    case 36:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_540408F173BA9A3F);
      return;
    case 14:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaverevive);
      return;
    case 9:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyparachuting);
      return;
    case 10:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhavequest);
      return;
    case 13:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyweaponpickupap);
      return;
    case 15:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveplatepouch);
      return;
    case 16:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
      return;
    case 18:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupalreadyhavespecialistbonus);
      return;
    case 19:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_B4A939303C824805);
      return;
    case 23:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_5FDCD05C466E7520);
      return;
    case 2:
      break;
    case 25:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_7141C6C2372C0A82);
      break;
    case 26:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_8BFFCA3828FD297E);
      break;
    case 31:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_EC7422F11A61C100);
      break;
    case 32:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_7BD397B2E9D8A434);
      break;
    case 33:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_58FE23C2A80F28ED);
      break;
    case 34:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_D8A2816E3697C70C);
      break;
    case 35:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_06944F496399A2A4);
      break;
    case 11:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyplunderpickup);
      break;
    case 37:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_61251EF22EFA8D15);
      break;
  }
}

_removecashstateforplayer(player, waittime) {
  player notify("reset_cash_wait");
  player endon("reset_cash_wait");
  wait(waittime);
  player.br_cash_count = undefined;
  player.br_cash_time = undefined;
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

    player thread _removecashstateforplayer(player, _id_D8C56288C4B1C484);

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
      case "brloot_plunder_cash_epic_1":
      case "brloot_plunder_cash_rare_2":
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

onusecompleted(pickupent, _id_43FB3D97ABB79854, _id_A5B2C541413AA895, _id_7F437A5779C8787C, _id_DB943473454F6EA6, instance, _id_44EE85DCF52B4001, _id_830B2A6A83BA12EB, _id_5756AA71087F3439) {
  level endon("game_ended");
  self endon("disconnect");
  _id_10BBEACB1429824E = 0;

  if(!isDefined(pickupent.count))
    pickupent.count = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(pickupent.scriptablename, "onUseCompleted"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc(pickupent.scriptablename, "onUseCompleted")]](pickupent);

  level notify("pickedupweapon_kill_callout_" + pickupent.scriptablename + pickupent.origin);
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPickupItemUsed", pickupent);

  if(isplunder(pickupent.scriptablename))
    self notify("self_pickedupitem_plunder");
  else if(isweaponpickupitem(pickupent)) {
    if(self _meth_B096B58FB3808D26())
      self._id_E7F6950DDC75EF66 = gettime();

    self notify("self_pickedupitem_weapon", pickupent.scriptablename);
  } else
    self notify("self_pickedupitem_" + pickupent.scriptablename);

  self notify("br_pickup_scriptable");

  if(isweaponpickupitem(pickupent)) {
    _id_724736FCF0FB6604::takeweaponpickup(pickupent, _id_DB943473454F6EA6, _id_5756AA71087F3439, _id_44EE85DCF52B4001);
    scripts\cp_mp\challenges::onpickupitem("weapon");
    _id_87B8BA9A18C47387 = isDefined(pickupent.scriptablename) && pickupent.scriptablename == "brloot_weapon_lm_dblmg_lege";

    if(_id_87B8BA9A18C47387)
      manageminigunpickup();
  } else if(_id_2CEDCC356F1B9FC8::isammo(pickupent.scriptablename)) {
    _id_10BBEACB1429824E = _id_724736FCF0FB6604::takeammopickup(pickupent);
    _id_2D9D24F7C63AC143::_id_5BAAA0CE73D6FE84(self, pickupent.scriptablename);
  } else if(_id_2CEDCC356F1B9FC8::isarmorplate(pickupent.scriptablename)) {
    _id_10BBEACB1429824E = takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
    _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_armor");
    thread _id_07C40FA80892A721::_id_EF6D8B8C2ED89E8A(pickupent.count);
  } else if(_id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(pickupent.scriptablename)) {
    if(_id_990BE1AA4AD3C9D4()) {
      dropstruct = _id_7B9F3966A7A42003();
      _id_C15A28FC6247AD60(dropstruct, 1);
      _id_0B7A9CE0A2282B79::_id_EA96B27797C7E268(self);
    }

    _id_0E9CFD120B0B43EF = _id_E98A5A4E0E001AC3(self, pickupent.scriptablename);

    if(pickupent.scriptablename == "brloot_plate_carrier_high_capacity" && !istrue(self._id_E75B458675200E42)) {
      fillmaxarmorplate();
      self._id_E75B458675200E42 = 1;
    }

    if(istrue(_id_44EE85DCF52B4001) && isDefined(_id_DB943473454F6EA6))
      _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_DB943473454F6EA6);
  } else if(_id_2CEDCC356F1B9FC8::_id_12D9A293931F0455(pickupent.scriptablename)) {
    _id_1DF16A3922616CD8(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
    _id_10BBEACB1429824E = 0;
  } else if(_id_2CEDCC356F1B9FC8::isequipment(pickupent.scriptablename))
    _id_10BBEACB1429824E = takeequipmentpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
  else if(_id_2CEDCC356F1B9FC8::isarmor(pickupent.scriptablename))
    takearmorpickup(pickupent);
  else if(pickupent.scriptablename == "Pillage_Cache" && isDefined(level.givetagsfromcache))
    self[[level.givetagsfromcache]]();
  else if(isplunder(pickupent.scriptablename)) {
    _id_6AFF3948CF4CCA03::takeplunderpickup(pickupent);
    scripts\cp_mp\challenges::onpickupitem("plunder");
  } else if(istokenpickup(pickupent.scriptablename)) {
    if(issubstr(pickupent.scriptablename, "redeploy_token"))
      takerespawntokenpickup(pickupent);

    if(issubstr(pickupent.scriptablename, "gulag_token"))
      _id_68C46FE15ED38D9B(pickupent);
  } else if(isrevivepickup(pickupent.scriptablename))
    takerevivepickup(pickupent, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
  else if(iskillstreak(pickupent.scriptablename))
    takekillstreakpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
  else if(issuperpickup(pickupent.scriptablename))
    takesuperpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6);
  else if(isgasmask(pickupent.scriptablename))
    takegasmask(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_44EE85DCF52B4001);
  else if(isquesttablet(pickupent.scriptablename)) {
    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::takequesttablet(pickupent.instance);
    else
      _id_64ACB6CE534155B7::_id_BB413728BC5231D0(pickupent.instance);
  } else if(pickupent.scriptablename == "brloot_ammo_grenade")
    takegenericgrenadepickup(pickupent);
  else if(_id_A5202E2FC8ECB076(pickupent.scriptablename))
    _id_B379C8B0A6564107(pickupent);
  else if(isaccesscard(pickupent.scriptablename))
    takeaccesscardpickup(pickupent);
  else if(isDefined(pickupent.scriptablename) && pickupent.scriptablename == "loot_key_mrap") {
    if(isDefined(self.vehicle)) {
      ref = self.vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

      if(isDefined(ref) && ref == "veh9_mil_lnd_mrap" && scripts\engine\utility::is_equal(self.vehicle.owner, self)) {
        if(self.vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_72F871BF74995298()) {
          self.vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_474237292E64417E();
          _id_2D9D24F7C63AC143::_id_E900E7E66383AD97(self, _id_DB943473454F6EA6, 0);
        } else
          scripts\mp\hud_message::showerrormessage("MP/MRAP_ALREADY_UNLOCKED");

        _id_6A8EC730B2BFA844::_id_07FC83D63A85C14D(self);
      } else
        scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_MRAP_KEY");
    } else
      scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_MRAP_KEY");
  } else if(_id_82D45592D750D388(pickupent.scriptablename)) {
    if(_id_9A5D18FBDAD686C2(pickupent.scriptablename)) {
      if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagKeyAcquired"))
        _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagKeyAcquired");

      return 0;
    } else
      return 1;
  } else if(_id_F92615E29AFF3602(pickupent.scriptablename)) {} else if(_id_E4B6260DBB04B43D(pickupent.scriptablename))
    _id_ED254D7BE7FF977A(pickupent);
  else if(isspecialistbonus(pickupent.scriptablename))
    addspecialistbonuspickup();
  else if(_id_E066D6B70DDA15F1(pickupent.scriptablename)) {
    _id_0AFCB53228E48F6A(pickupent);
    return 1;
  } else if(_id_F262C137ED78E6EB(pickupent.scriptablename)) {
    if(istrue(self._id_45B8E84DE48BB89F))
      thread _id_01193C0B83FCE13B::_id_A232D3C610006843(pickupent, self);
    else
      thread _id_03314ADD7998AB13::_id_57AC6111C7DB410F(pickupent, self);
  } else if(_id_4EBFDBFA1B8E0339(pickupent.scriptablename))
    thread _id_2880C23DEADCDD8F::_id_4CC3562C55625E70(instance);
  else if(_id_164622EB2B0F5390::_id_1DB5FF7063481DA7(pickupent.scriptablename))
    thread _id_164622EB2B0F5390::_id_1C4B8BC4339E2C48(instance);
  else if(_id_6B5F3FB6550AE6D5(pickupent.scriptablename))
    thread _id_156835EF9924856A::_id_7430B01F931D7E4E(undefined, pickupent);
  else if(_id_5449DA9D3D0358A4(pickupent.scriptablename)) {
    _id_62CC4A0ECDE06ECF = pickupent.scriptablename == "brloot_gascan_palfa";
    error = scripts\cp_mp\vehicles\vehicle_interact::_id_557DA58E3AD8A579(pickupent, _id_62CC4A0ECDE06ECF);

    if(isDefined(error))
      scripts\mp\hud_message::showerrormessage(error);
    else {
      _id_2D9D24F7C63AC143::_id_E900E7E66383AD97(self, _id_DB943473454F6EA6, pickupent.count);

      if(istrue(_id_830B2A6A83BA12EB))
        _id_EFDDDF60C5DB058C(pickupent, _id_A5B2C541413AA895);

      playsoundatpos(self.origin + (0, 0, 30), "eqp_gas_can_use");

      if(_id_62CC4A0ECDE06ECF)
        _id_439D01E25D19543B::_id_354BD1BA3062243D();
    }
  } else if(_id_B1E944A2B3E15E9D(pickupent.scriptablename)) {
    _id_DB02EDBAC967FB02 = _id_2D9D24F7C63AC143::_id_3188D9C94B3D56C2(pickupent.scriptablename);
    _id_31DAFC6BA15DFBC9 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self);
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickupent.scriptablename);
    _id_F6AF44BB087C3DA5 = _id_2D9D24F7C63AC143::_id_102ABD6883C5F9BF(self);

    if(_id_F6AF44BB087C3DA5 != 0) {
      dropstruct = _id_7B9F3966A7A42003();
      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F6AF44BB087C3DA5);
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickupent._id_96C7526F4AB04875, undefined, undefined, pickupent.origin);
      item = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
    }

    _id_0B7A9CE0A2282B79::_id_5B7DC44BB66553A6(self);
    _id_0B7A9CE0A2282B79::_id_92D947129EA5BA6E(self, lootid);
    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(self, _id_DB02EDBAC967FB02, undefined, lootid);

    if(istrue(_id_44EE85DCF52B4001) && isDefined(_id_DB943473454F6EA6))
      _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_DB943473454F6EA6);

    _id_2D9D24F7C63AC143::_id_6491BD812BB47EFB(self, _id_DB02EDBAC967FB02, pickupent.scriptablename);
  } else if(_id_36DE08EA672B354C(pickupent.scriptablename))
    thread _id_4E335A6589199847(pickupent, _id_A5B2C541413AA895, _id_DB943473454F6EA6, _id_44EE85DCF52B4001, _id_7F437A5779C8787C);
  else if(_id_9E3428357E5DF2E3(pickupent.scriptablename) && (scripts\mp\utility\game::getsubgametype() != "dmz" && isDefined(level._id_547167A7517600FB))) {} else if(_id_B676E90CFF5CB04D(pickupent.scriptablename) && isDefined(level._id_D95D8CC7C34F298F))
    self[[level._id_D95D8CC7C34F298F]](pickupent);
  else if(_id_D0BACEE01BFF927C(pickupent.scriptablename) && isDefined(level._id_14CC24A75E8CD64D))
    self[[level._id_14CC24A75E8CD64D]](pickupent);
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

  _id_B96BD81B0107AD4C(pickupent);
  _id_715028F54BAD19A1::branalytics_lootpickup(self, pickupent.scriptablename, amount);
  _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_inventory");

  if(!istrue(_id_43FB3D97ABB79854) && !istrue(_id_830B2A6A83BA12EB)) {
    if(_id_10BBEACB1429824E)
      pickupent.count = pickupent.count - _id_10BBEACB1429824E;

    _id_EFDDDF60C5DB058C(pickupent, _id_A5B2C541413AA895);
  }

  return _id_10BBEACB1429824E;
}

_id_A74604666BDE595B(pickup) {
  if(_id_9E3428357E5DF2E3(pickup.scriptablename)) {
    _id_2391409EF7B431E1::_id_B5D4FCC3FAB92696(pickup);

    if(isDefined(level._id_9A3C2481A4CD4B46))
      [[level._id_9A3C2481A4CD4B46]](self, pickup.count);

    if(_id_2391409EF7B431E1::_id_1129BA5718D33025(self, pickup.count))
      thread _id_2391409EF7B431E1::_id_EA29BCCF97CB1B9A(self, pickup.count);

    _id_2391409EF7B431E1::_id_B5FBE3CB4ED955F4(self, pickup.count);
  }

  if(isDefined(level._id_05635125E56693C8) && isDefined(level._id_05635125E56693C8[pickup.scriptablename]))
    [[level._id_05635125E56693C8[pickup.scriptablename]]](pickup, self);

  if(_id_02D86BA79A58BB62(pickup.scriptablename)) {
    _id_1FAF51A7DC279A8B = undefined;
    _id_B939ABDEDC45C697 = undefined;

    if(isDefined(pickup.instance)) {
      _id_1FAF51A7DC279A8B = pickup.instance._id_1FAF51A7DC279A8B;
      _id_B939ABDEDC45C697 = pickup.instance._id_B939ABDEDC45C697;
    } else {
      _id_1FAF51A7DC279A8B = pickup._id_1FAF51A7DC279A8B;
      _id_B939ABDEDC45C697 = pickup._id_B939ABDEDC45C697;
    }

    if(isDefined(_id_1FAF51A7DC279A8B)) {
      self._id_1FAF51A7DC279A8B = _id_1FAF51A7DC279A8B;
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\player::getteamarray(self.team, 0);
      _id_744CAD313ED0A87E::_id_7BC622D2FE4B2017(_id_1FAF51A7DC279A8B, 0, _id_A6AB8D0FDA441DC2, _id_B939ABDEDC45C697, self.team);
    }
  }

  _id_B96BD81B0107AD4C(pickup);
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPickupTakenIntoBackpack", pickup);
}

_id_B96BD81B0107AD4C(pickup) {
  if(istrue(pickup._id_8C6CE30A6A5126B1) || isDefined(pickup.instance) && istrue(pickup.instance._id_8C6CE30A6A5126B1)) {
    if(!isDefined(self._id_F1CB96C63166B481))
      self._id_F1CB96C63166B481 = [];

    self._id_F1CB96C63166B481[self._id_F1CB96C63166B481.size] = pickup.scriptablename;
  }
}

_id_734B7A21BE53F605() {
  self setclientomnvar("ui_loot_splash_item_id", 0);
  self setclientomnvar("ui_loot_splash_item_quantity", 0);
}

_id_54CBF68F2E4A6D31(pickupent) {
  self notify("updateLootSplash");
  self endon("disconnect");
  lootid = 0;
  quantity = 0;
  scriptablename = pickupent.scriptablename;

  if(isweaponpickup(pickupent.scriptablename)) {
    if(isDefined(pickupent.customweaponname))
      lootid = _id_2669878CF5A1B6BC::_id_B0D37B9BE0027733(pickupent.customweaponname);
    else {
      weaponobj = getfullweaponobjforpickup(pickupent);
      lootid = _id_2669878CF5A1B6BC::_id_9C331F88BE5A1478(weaponobj);
    }
  } else {
    lootid = level.br_pickups._id_7B2BFF2D04EE1017[pickupent.scriptablename];

    if(!isDefined(lootid))
      lootid = 0;

    _id_C21291CD8D120C4A = isDefined(pickupent.stackable) && pickupent.stackable > 0 || isplunder(pickupent.scriptablename) || ispickupstackable(pickupent.scriptablename) || _id_E68E1669597A3F4D(pickupent.scriptablename);

    if(_id_C21291CD8D120C4A && isDefined(pickupent.count))
      quantity = pickupent.count;
  }

  waitframe();

  if(isDefined(lootid)) {
    self setclientomnvar("ui_loot_splash_item_id", lootid);
    self setclientomnvar("ui_loot_splash_item_quantity", quantity);
  } else
    logstring("ui_loot_splash_item_id LootID: undefinedpickupEnt: " + scriptablename);

  self endon("updateLootSplash");
  wait 0.05;
  _id_734B7A21BE53F605();
}

_id_37BE6E543436F3B3(lootid, origin, _id_8598D3D3BC3D9CEB, quantity) {
  pickup = spawnStruct();
  pickup.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  pickup.origin = origin;
  pickup.count = quantity;

  if(isDefined(_id_8598D3D3BC3D9CEB))
    pickup._id_8598D3D3BC3D9CEB = _id_8598D3D3BC3D9CEB;

  _id_EFDDDF60C5DB058C(pickup);
}

_id_EFDDDF60C5DB058C(pickupent, _id_A5B2C541413AA895) {
  _id_09D5BC8E32EE3635 = "br_pickup_generic";
  _id_A0BEA370D6A72CEB = undefined;
  _id_97FA758A2336C7C4 = undefined;

  if(isDefined(pickupent.scriptablename)) {
    if(isplunder(pickupent.scriptablename))
      _id_09D5BC8E32EE3635 = getcashsoundaliasforplayer(self, pickupent.scriptablename);
    else if(_id_E68E1669597A3F4D(pickupent.scriptablename))
      _id_09D5BC8E32EE3635 = _id_01193C0B83FCE13B::_id_5D4530EBFA3DA544(self);
    else if(isDefined(level.br_pickups.br_pickupsfx[pickupent.scriptablename]) && level.br_pickups.br_pickupsfx[pickupent.scriptablename].size > 0 && !(getdvarint("dvar_BE1B706F310C8E63", 0) != 0 && (level.br_pickups.br_pickupsfx[pickupent.scriptablename] == "br_legendary_loot_pickup" || issubstr(level.br_pickups.br_pickupsfx[pickupent.scriptablename], "dmz_specialty_loot_pickup_")))) {
      if(level.br_pickups.br_pickupsfx[pickupent.scriptablename] == "br_legendary_loot_pickup" || issubstr(level.br_pickups.br_pickupsfx[pickupent.scriptablename], "dmz_specialty_loot_pickup_")) {
        _id_A0BEA370D6A72CEB = level.br_pickups.br_pickupsfx[pickupent.scriptablename];

        if(isweaponpickupitem(pickupent))
          _id_09D5BC8E32EE3635 = "br_pickup_weap";
        else
          _id_09D5BC8E32EE3635 = "br_pickup_generic";
      } else if(level.br_pickups.br_pickupsfx[pickupent.scriptablename] == "uin_dmz_valuable_loot_pickup") {
        _id_97FA758A2336C7C4 = level.br_pickups.br_pickupsfx[pickupent.scriptablename];

        if(isweaponpickupitem(pickupent))
          _id_09D5BC8E32EE3635 = "br_pickup_weap";
        else
          _id_09D5BC8E32EE3635 = "br_pickup_generic";
      } else
        _id_09D5BC8E32EE3635 = level.br_pickups.br_pickupsfx[pickupent.scriptablename];
    } else if(isweaponpickupitem(pickupent))
      _id_09D5BC8E32EE3635 = "br_pickup_weap";
    else
      _id_09D5BC8E32EE3635 = "br_pickup_generic";

    if(isDefined(level.br_pickups.br_itemrow[pickupent.scriptablename]) && (istrue(level.br_pickups._id_0A5E4B146866D7FD[pickupent.scriptablename]) || isweaponpickup(pickupent.scriptablename) && getdvarint("dvar_68583A19A03DFDBC", 0))) {
      _id_277F6C5FC203760A = pickupent.customweaponname;
      _id_33F18065D4E06550 = undefined;
      index = undefined;

      if(isDefined(_id_277F6C5FC203760A)) {
        index = _id_2669878CF5A1B6BC::_id_B0D37B9BE0027733(_id_277F6C5FC203760A);
        _id_33F18065D4E06550 = 0;
      } else {
        index = level.br_pickups.br_itemrow[pickupent.scriptablename];
        _id_33F18065D4E06550 = 1;
      }

      self _meth_8AC1BECB4519E28C(index, pickupent.count, _id_33F18065D4E06550);
      self notify("loot_collected");
    }
  }

  _id_C872E61A2A2659B6 = self getvieworigin();
  _id_F6C83B7007D82D88 = undefined;

  if(isvector(pickupent.origin))
    _id_F6C83B7007D82D88 = pickupent.origin;
  else if(isstruct(pickupent)) {
    _id_69E96A4CAA72D794 = scripts\engine\utility::_id_53C4C53197386572(pickupent._id_69E96A4CAA72D794, self._id_02FA5B49969DEF47);

    if(isDefined(_id_69E96A4CAA72D794)) {
      _id_F6C83B7007D82D88 = _id_69E96A4CAA72D794.origin;
      _id_F6C83B7007D82D88 = (_id_F6C83B7007D82D88[0], _id_F6C83B7007D82D88[1], _id_C872E61A2A2659B6[2] - 20);
    }
  }

  if(!isvector(_id_F6C83B7007D82D88))
    _id_F6C83B7007D82D88 = _id_C872E61A2A2659B6 + anglesToForward(self getplayerangles()) * 36 + (0, 0, -20);

  origin_delta = _id_F6C83B7007D82D88 - _id_C872E61A2A2659B6;
  origin_offset = origin_delta * 0.666;
  _id_67B91D0A42B0578E = _id_C872E61A2A2659B6 + origin_offset;

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive() && !_func_6DC7C10050A0622B(self)) {
    if(isDefined(_id_A0BEA370D6A72CEB))
      self playlocalsound(_id_A0BEA370D6A72CEB);
    else if(isDefined(_id_97FA758A2336C7C4))
      self playlocalsound(_id_97FA758A2336C7C4);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self))
        self playsoundonmovingent(_id_09D5BC8E32EE3635);
    }
  }

  if(!istrue(pickupent._id_C03C4EF51659BA4C))
    thread _id_54CBF68F2E4A6D31(pickupent);

  if(!istrue(_id_A5B2C541413AA895) && !istrue(pickupent._id_8598D3D3BC3D9CEB))
    thread playerplaypickupanim(pickupent);
}

playerplaypickupanim(pickupent) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !_id_2CEDCC356F1B9FC8::playercanplaynotcriticalgesture()) {
    return;
  }
  _id_F4361EA8CE0FBCA4();
  _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
}

_id_F4361EA8CE0FBCA4() {
  _id_A7408DBFED49F3F9 = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(_id_A7408DBFED49F3F9)) {
    if(self isgestureplaying("iw8_ges_pickup_br"))
      self stopgestureviewmodel("iw8_ges_pickup_br", 0, 1);

    self takeweapon(_id_A7408DBFED49F3F9);
    waitframe();
  }
}

_id_7B9F3966A7A42003() {
  dropstruct = spawnStruct();
  dropstruct.dropcount = 0;
  dropstruct._id_DFBA5A2C3C6F0A07 = 0;
  return dropstruct;
}

droponplayerdeath(attacker, meansofdeath, objweapon) {
  victim = self;

  if(getdvarint("dvar_18C54F044520BA50", 0)) {
    if(isbot(victim))
      return;
  }

  if(getdvarint("dvar_307FC239DC43BE41", 0)) {
    return;
  }
  if(scripts\mp\utility\game::isteamreviveenabled())
    self._id_57C207FDE9B78089 = 1;

  if(istrue(level.usegulag) && (!_id_3583FF375AB3A91E::_id_1082D39CDBA869D9() && (_id_2CEDCC356F1B9FC8::isplayeringulag() || _id_2CEDCC356F1B9FC8::_id_F1918F2FCE663B2C()))) {
    return;
  }
  dropstruct = _id_7B9F3966A7A42003();

  if(isDefined(level.adddroponplayerdeath))
    self[[level.adddroponplayerdeath]](dropstruct, attacker, meansofdeath, objweapon);

  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("dropOnPlayerDeath"))) {
    return;
  }
  if(scripts\mp\utility\killstreak::isjuggernaut())
    _id_29C32B7117E01180::droponplayerdeath(dropstruct);

  if(isDefined(level._id_547167A7517600FB) && isDefined(level._id_547167A7517600FB._id_E393BF4026D0C393))
    [[level._id_547167A7517600FB._id_E393BF4026D0C393]](self, attacker);

  if(_id_D3204A974CEC837B()) {
    self._id_BA19D6A40E652DD6 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self);
    _id_F6AF44BB087C3DA5 = _id_2D9D24F7C63AC143::_id_102ABD6883C5F9BF(self);

    if(_id_F6AF44BB087C3DA5 != 0)
      self._id_0CD82E790E825DB2 = _id_F6AF44BB087C3DA5;

    if(istrue(level._id_813B4B2211FBAF1D)) {
      _id_2D9D24F7C63AC143::_id_C6B3799B231916BB(self, dropstruct);

      if(!istrue(level._id_D034183ABF2E274D)) {
        _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();
        _id_2D9D24F7C63AC143::_id_954372D604277278(self);
      }
    } else if(scripts\mp\loot::_id_8306D72EA2E8889C()) {
      if(!istrue(level._id_A1AAB37EC3423E39))
        _id_2D9D24F7C63AC143::_id_8121CBEE12383790(self, dropstruct);

      if(istrue(level._id_51225D738094457D))
        _id_2D9D24F7C63AC143::_id_AE287E5EB2024104(self, dropstruct);

      if(!istrue(level._id_D034183ABF2E274D)) {
        _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();
        _id_2D9D24F7C63AC143::_id_954372D604277278(self);
      }

      if(istrue(level._id_51225D738094457D)) {
        foreach(weapon in self.equippedweapons) {
          if(shoulddropbrprimary(weapon, self)) {
            _id_FACC6A1A18B419F0 = dropbrweapon(weapon, dropstruct);

            if(isDefined(_id_FACC6A1A18B419F0)) {
              self._id_3480393DC131952A = _id_FACC6A1A18B419F0;
              break;
            }
          }
        }
      }
    }

    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      if(getdvarint("dvar_F924E428AE42DC96"))
        dropbrammoboxes(dropstruct);
      else
        self._id_73BB45340691326C = self.br_ammo;
    } else
      dropbrammoboxes(dropstruct);

    if(!istrue(level._id_51225D738094457D)) {
      dropbrequipment(dropstruct);

      if(!istrue(level._id_4CA052423B9BB316))
        dropbrsuper(dropstruct);

      _id_6AFF3948CF4CCA03::playerdropplunderondeath(dropstruct, attacker);
      dropbrprimaryweapons(dropstruct, level._id_73DC8CB1481E4A36);
      dropbrhealthpack(dropstruct);
    }

    if(!istrue(level._id_813B4B2211FBAF1D) && !istrue(level._id_73DC8CB1481E4A36)) {
      dropbrgasmask(dropstruct);
      dropbrkillstreak(dropstruct);
      _id_A61F07010C727C0A(dropstruct);
      dropbrselfrevivetoken(dropstruct);
    } else if(scripts\cp_mp\gasmask::hasgasmask(self)) {
      _id_75520EA44545C906();
      _id_0B7A9CE0A2282B79::_id_777C89585478357B(self);
    }

    if(_id_990BE1AA4AD3C9D4())
      _id_C15A28FC6247AD60(dropstruct);

    dropspecialistbonus(dropstruct);
    dropbrmissiontablet(dropstruct);
    dropaccesscard(dropstruct);
    _id_B8FAA69B95FE55BE(dropstruct);

    if(_id_080DD3F82FFE825F()) {
      arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(self);

      if(isDefined(arena))
        thread _id_55463A3679678E2F(dropstruct, arena);
    }

    self notify("canSpawnAsSpectator");
    return;
  }

  if(_id_080DD3F82FFE825F()) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(self);

    if(isDefined(arena))
      thread _id_55463A3679678E2F(dropstruct, arena);
  }

  _id_2D9D24F7C63AC143::_id_2C226F050114F4B2(dropstruct, self);

  if(_id_990BE1AA4AD3C9D4())
    _id_C15A28FC6247AD60(dropstruct);

  if(!istrue(level._id_D034183ABF2E274D))
    _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();

  if(!istrue(level.skipweapondropondeath))
    dropbrprimaryweapons(dropstruct);

  dropbrgasmask(dropstruct);
  _id_A61F07010C727C0A(dropstruct);

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    if(getdvarint("dvar_F924E428AE42DC96"))
      dropbrammoboxes(dropstruct);
    else
      self._id_73BB45340691326C = self.br_ammo;
  } else
    dropbrammoboxes(dropstruct);

  dropbrhealthpack(dropstruct);
  dropspecialistbonus(dropstruct);

  if(!istrue(level.skipequipmentdropondeath))
    dropbrequipment(dropstruct);

  _id_6AFF3948CF4CCA03::playerdropplunderondeath(dropstruct, attacker);

  if(scripts\mp\utility\game::getsubgametype() != "kingslayer")
    dropbrkillstreak(dropstruct);

  dropbrsuper(dropstruct);
  dropbrmissiontablet(dropstruct);
  dropaccesscard(dropstruct);
  _id_B8FAA69B95FE55BE(dropstruct);
  self notify("canSpawnAsSpectator");
}

_id_D3204A974CEC837B() {
  player = self;

  if((istrue(player.jailed) || istrue(player.gulagarena)) && _id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    return 0;

  if(istrue(level._id_51225D738094457D) || istrue(level._id_AA5679EBF3504E13))
    return 1;

  return 0;
}

_id_C15A28FC6247AD60(dropstruct, _id_AB404EB77736D9A7) {
  if(!isDefined(self._id_BED158A6DFAC230D)) {
    return;
  }
  if(self._id_BED158A6DFAC230D <= 1) {
    return;
  }
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  item = undefined;

  if(isDefined(self._id_04045F099F3DA4BD))
    item = spawnpickup(self._id_04045F099F3DA4BD, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
  else
    item = spawnpickup("brloot_plate_carrier_" + self._id_BED158A6DFAC230D, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);

  if(istrue(_id_AB404EB77736D9A7)) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    self setplayerdata(level._id_5D69837CF4DB0407, "dmzPlateCarrierLevel", 1);

  if(isDefined(item)) {
    _id_2F4E0022C686DBE6(item);

    if(_id_4294E9B331377C31(item.type)) {
      scripts\mp\perks\perkfunctions::_id_6AF20073381A18D3();
      self._id_E75B458675200E42 = undefined;
    }
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    self._id_BED158A6DFAC230D = 1;
  else
    self._id_BED158A6DFAC230D = 2;

  self._id_8790C077C95DB752 = self._id_BED158A6DFAC230D * 50;
  _id_07C40FA80892A721::_id_AC7803D45979135C(0, 1);
}

dropbrammoboxes(dropstruct) {
  if(!isDefined(self.br_ammo)) {
    return;
  }
  foreach(ammotype in level.br_ammo_types) {
    if(self.br_ammo[ammotype] > 0 && isDefined(level.br_pickups.br_itemrow[ammotype])) {
      scriptablename = ammotype;
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_671A6A4AAED8033E", 1);
      spawnpickup(scriptablename, _id_CB4FAD49263E20C4, self.br_ammo[ammotype], 1, undefined, _id_1AD2DB70C8D01F51);
    }
  }
}

dropbrprimaryweapons(dropstruct, _id_73DC8CB1481E4A36) {
  foreach(weapon in self.equippedweapons) {
    if(istrue(_id_73DC8CB1481E4A36) && !issameweapon(weapon, self.lastweaponobj) && (weapon.basename == self.primaryweaponobj.basename || weapon.basename == self.secondaryweaponobj.basename)) {
      continue;
    }
    if(shoulddropbrprimary(weapon, self)) {
      _id_FACC6A1A18B419F0 = dropbrweapon(weapon, dropstruct);
      _id_2F4E0022C686DBE6(_id_FACC6A1A18B419F0);

      if(!isDefined(_id_FACC6A1A18B419F0))
        dropstruct._id_DFBA5A2C3C6F0A07--;
    }
  }

  if(istrue(level._id_0F478C1F94CAA7E9) && !istrue(level._id_A3499C286AC570E4)) {
    if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
      weapon = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
      _id_FACC6A1A18B419F0 = dropbrweapon(weapon, dropstruct);

      if(isDefined(_id_FACC6A1A18B419F0))
        _id_2F4E0022C686DBE6(_id_FACC6A1A18B419F0);

      _id_2D9D24F7C63AC143::_id_954372D604277278(self);
    }
  }
}

dropbrweapon(weapon, dropstruct, _id_7591ED99E87A77D3) {
  weaponobj = undefined;
  _id_00CA27530D7310F4 = 1;
  _id_6838DA24A7B27A10 = 0;
  _id_1CB8C0A6D750CF77 = 0;

  if(isDefined(weapon)) {
    if(isweapon(weapon)) {
      weaponobj = weapon;
      _id_00CA27530D7310F4 = self getweaponammoclip(weaponobj);
      _id_6838DA24A7B27A10 = self getweaponammoclip(weaponobj, "left");

      if(weaponobj.hasalternate) {
        _id_6890A4CE965BBA99 = weaponobj getaltweapon();

        if(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_6890A4CE965BBA99) != _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj))
          _id_1CB8C0A6D750CF77 = self getweaponammoclip(_id_6890A4CE965BBA99);
      }
    } else if(isstring(weapon)) {
      weaponobj = getfullweaponobjfromscriptablename(weapon);

      if(isDefined(weaponobj))
        _id_00CA27530D7310F4 = weaponobj.clipsize;
      else if(isDefined(level.br_ammo_clipsize[weapon]))
        _id_00CA27530D7310F4 = level.br_ammo_clipsize[weapon];
    }
  }

  if(!isDefined(weaponobj)) {
    return;
  }
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
  _id_E1147886CCF51970 = undefined;
  _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(self, weaponobj);

  if(isDefined(_id_FE4048AD22C35D73))
    _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(self, _id_FE4048AD22C35D73);

  _id_C9614496B843196E = _id_724736FCF0FB6604::weaponspawn(weaponobj, self, _id_CB4FAD49263E20C4, 0, 1);

  if(isDefined(_id_C9614496B843196E)) {
    _id_C9614496B843196E._id_E1147886CCF51970 = _id_E1147886CCF51970;
    ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);
    _id_C9614496B843196E.ammotype = ammotype;

    if(getdvarint("dvar_752EEED3DDCBD04B", 0) == 0 && _id_724736FCF0FB6604::_id_AD972C1D0F29841C(self, weaponobj) && self.br_ammo[ammotype] > 0) {
      _id_0660523CFF419F0B = getdvarint("dvar_3C4EDD0A748E4053", 1);
      dropstruct._id_DFBA5A2C3C6F0A07 = 1;
      _id_9EDC776840BAFF95 = undefined;

      if(isDefined(_id_7591ED99E87A77D3))
        _id_9EDC776840BAFF95 = self.origin + rotatevector(_id_7591ED99E87A77D3 - self.origin, (0, 36, 0));

      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_9EDC776840BAFF95);
      _id_C9614496B843196E._id_AC26EC91048AC2E3 = spawnpickup(ammotype, _id_CB4FAD49263E20C4, self.br_ammo[ammotype], 1, undefined, _id_0660523CFF419F0B);
      _id_724736FCF0FB6604::br_ammo_take_type(self, ammotype, self.br_ammo[ammotype]);
    }

    loot_setitemcount(_id_C9614496B843196E, _id_00CA27530D7310F4, _id_6838DA24A7B27A10, _id_1CB8C0A6D750CF77);
  }

  return _id_C9614496B843196E;
}

_id_080DD3F82FFE825F() {
  player = self;

  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagCanPlayerDropKey")) {
      if(player _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagCanPlayerDropKey"))
        return 1;
    }
  }

  return 0;
}

_id_55463A3679678E2F(dropstruct, arena) {
  player = self;
  scriptable = level.br_pickups._id_838863C4848D4C26["loot_key_gulag"];
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
  item = spawnpickup(scriptable, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);

  if(isPlayer(player))
    player _id_2F4E0022C686DBE6(item);

  arena._id_6D4E3B180776136F[arena._id_6D4E3B180776136F.size] = item;
  playsoundatpos(player.origin, "flag_spawned");

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers)
  _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_key_dropped");

  wait 0.5;

  if(!isDefined(item)) {
    return;
  }
  _id_3583FF375AB3A91E::_id_9F7B9A86A5328F0B(arena, item.origin);
  return;
}

_id_A10ADEC57AD9E3A4(dropstruct, arena, _id_6181DE250AFA5BB6) {
  agent = self;

  if(!isDefined(agent)) {
    return;
  }
  scriptable = level.br_pickups._id_838863C4848D4C26["loot_key_spectator_gulag"];
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent, undefined, 25);
  item = spawnpickup(scriptable, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
  item._id_BBC200BC77C5DB2B = 1;
  item._id_0C001CCFC802F487 = 1;
  arena._id_F1D536B9F8EFC97C = item;
  playsoundatpos(agent.origin, "flag_spawned");
  _id_8799B0DC8555323C = scripts\engine\utility::array_remove_array(arena.jailedplayers, arena.arenaplayers);

  foreach(player in _id_8799B0DC8555323C)
  player thread scripts\mp\hud_message::showsplash("gulagbreak_got_key");

  return;
}

getfullweaponobjfromscriptablename(_id_4B71202F07149879) {
  weaponname = undefined;

  if(!isDefined(level.br_lootiteminfo) && !isDefined(level.br_lootiteminfo[_id_4B71202F07149879])) {
    return;
  }
  return level.br_lootiteminfo[_id_4B71202F07149879].fullweaponobj;
}

shoulddropbrprimary(weapon, player) {
  basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

  if(basename == "iw9_me_fists" || basename == "iw9_knifestab" || basename == "iw8_gunless" || basename == "iw9_me_fists_mp" || basename == "iw9_me_diveknife" || basename == "iw9_swimfists_mp" || basename == "iw9_me_climbfists" || basename == "iw9_me_fists_mp_ls")
    return 0;

  if(basename == "ks_use_crate_mp")
    return 0;

  if(!isweapon(weapon))
    return 0;

  if(weapon.inventorytype != "primary")
    return 0;

  if(player _id_4ACBD920A4F5A24D::extract_ismissionweapon(weapon))
    return 0;

  return 1;
}

dropbrequipment(dropstruct, _id_7F437A5779C8787C, _id_1E736A37C3737585, equipmentref, _id_F24FBD36A9751174) {
  _id_11F2059012065537 = istrue(_id_1E736A37C3737585) && isDefined(equipmentref);

  if(_id_11F2059012065537) {
    _id_1A37FA6C580BB395 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, equipmentref);

    if(isDefined(_id_1A37FA6C580BB395)) {
      _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
      baseorigin = self.origin;
      baseangles = self.angles;
      _id_AD49A38DD7C4C10F = level.br_pickups._id_AD49A38DD7C4C10F;
      _id_3B53BC0EEE6AE84E = level.br_pickups._id_3B53BC0EEE6AE84E;

      if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk)) {
        baseorigin = self.br_kiosk.origin;
        baseangles = self.br_kiosk.angles;
        _id_3B53BC0EEE6AE84E = undefined;
        _id_AD49A38DD7C4C10F = undefined;
      }

      _id_2FB86E1C9B4C6464 = 1;

      if(isDefined(_id_F24FBD36A9751174))
        _id_2FB86E1C9B4C6464 = _id_F24FBD36A9751174;

      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, _id_AD49A38DD7C4C10F, _id_3B53BC0EEE6AE84E);
      item = spawnpickup(_id_1A37FA6C580BB395, _id_CB4FAD49263E20C4, _id_2FB86E1C9B4C6464, 1, undefined, isalive(self));
      _id_2F4E0022C686DBE6(item);
    }

    return;
  }

  _id_BB7A7034F796AF47 = self.equipment["primary"];

  if(isDefined(_id_BB7A7034F796AF47)) {
    if(_id_BB7A7034F796AF47 == "equip_hb_sensor")
      ammocount = _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();
    else
      ammocount = scripts\mp\equipment::getequipmentslotammo("primary");

    if(ammocount > 0) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["primary"]);

      if(isDefined(_id_FEB782334DD23A66)) {
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
        _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_091F6B5DD6FA6844", 0);
        item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
        _id_2F4E0022C686DBE6(item);
      }
    }
  }

  _id_79A42E6A2F51CF87 = self.equipment["secondary"];

  if(isDefined(_id_79A42E6A2F51CF87)) {
    if(_id_79A42E6A2F51CF87 == "equip_hb_sensor")
      ammocount = _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();
    else
      ammocount = scripts\mp\equipment::getequipmentslotammo("secondary");

    if(ammocount > 0) {
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["secondary"]);

      if(isDefined(_id_FEB782334DD23A66)) {
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
        _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_F74983A33E4CE283", 0);
        item = spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1, undefined, _id_1AD2DB70C8D01F51);
        _id_2F4E0022C686DBE6(item);
      }
    }
  }
}

dropbrsuper(dropstruct, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_EBEC497FF8B18A45) {
  _id_85EFDD4E2C86F214 = istrue(_id_1E736A37C3737585) && isDefined(_id_EBEC497FF8B18A45);

  if(_id_85EFDD4E2C86F214) {
    _id_1A37FA6C580BB395 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, _id_EBEC497FF8B18A45);

    if(isDefined(_id_1A37FA6C580BB395)) {
      _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
      [droporigin, dropangles, _id_A6717FAE5964E4C6] = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
      item = spawnpickup(_id_1A37FA6C580BB395, droporigin, dropangles, 1, 1, _id_A6717FAE5964E4C6);
      _id_2F4E0022C686DBE6(item);
    }

    return;
  }

  if(isDefined(self.equipment["super"])) {
    ammocount = _id_FCDE72DCBCEC206B();

    if(isDefined(ammocount) && ammocount > 0) {
      _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();

      if(isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "super_fulton") {
        if(!istrue(level.allowfultondropondeath))
          return;
      }

      dropequipmentinslot(dropstruct, "super", _id_7F437A5779C8787C, ammocount);
    }
  }
}

dropbrmissiontablet(dropstruct) {
  if(isDefined(self.extractquest_missionitem) && isDefined(self.extractquest_unlockablelootid)) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    pickup = spawnpickup(self.extractquest_missionitem, _id_CB4FAD49263E20C4, 1, 1, undefined, isalive(self));
    _id_2F4E0022C686DBE6(pickup);
    pickup _id_6A297C1028F46524::blueprintextract_setunlockablelootid(self.extractquest_unlockablelootid);
  }
}

dropbrhealthpack(dropstruct) {
  _id_9BE70D6D4FF253A1 = 0;
  itemname = undefined;

  if(!isDefined(level.br_pickups)) {
    return;
  }
  if(isDefined(self.equipment["health"])) {
    itemname = level.br_pickups.br_equipnametoscriptable[self.equipment["health"]];
    _id_9BE70D6D4FF253A1 = scripts\mp\equipment::getequipmentslotammo("health");
  } else if(istrue(level._id_36304CC9071BF738)) {
    itemname = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
    _id_9BE70D6D4FF253A1 = level._id_2B27FF18B10AD519;
  }

  if(istrue(level._id_2B27FF18B10AD519) && _id_9BE70D6D4FF253A1 < level._id_2B27FF18B10AD519) {
    _id_9BE70D6D4FF253A1 = level._id_2B27FF18B10AD519;

    if(!isDefined(itemname))
      itemname = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
  }

  if(_id_9BE70D6D4FF253A1 > 0 && isDefined(itemname)) {
    _id_1AD2DB70C8D01F51 = getdvarint("dvar_654510829E5B59D7", 1) || isalive(self);

    if(_id_9BE70D6D4FF253A1 > level.br_pickups.maxcounts[itemname]) {
      _id_9BE70D6D4FF253A1 = _id_9BE70D6D4FF253A1 - level.br_pickups.maxcounts[itemname];
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      item = spawnpickup(itemname, _id_CB4FAD49263E20C4, level.br_pickups.maxcounts[itemname], 1, undefined, _id_1AD2DB70C8D01F51);
    }

    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(itemname, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 1, undefined, _id_1AD2DB70C8D01F51);
    _id_2F4E0022C686DBE6(item);
  }
}

dropbrgasmask(dropstruct, _id_180513E5B195F19A) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_4508C701F27F5496", 0);
    gasmask = undefined;

    if(!istrue(_id_180513E5B195F19A) && self.gasmaskhealth > 0)
      gasmask = spawnpickup(self.gasmasktype, _id_CB4FAD49263E20C4, int(self.gasmaskhealth), 1, undefined, _id_1AD2DB70C8D01F51);

    if(isDefined(gasmask))
      gasmask.gasmaskmaxhealth = self.gasmaskmaxhealth;

    _id_75520EA44545C906();

    if(isDefined(gasmask))
      _id_2F4E0022C686DBE6(gasmask);

    _id_0B7A9CE0A2282B79::_id_777C89585478357B(self);

    if(!istrue(_id_180513E5B195F19A))
      _id_8E9B00A1D2B23D72();
  }
}

_id_AA702BCDEEB2B827(dropstruct, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_0FE0F715FC43F378, pickup) {
  _id_AA702BCDEEB2B827 = istrue(_id_1E736A37C3737585) && isDefined(_id_0FE0F715FC43F378);

  if(_id_AA702BCDEEB2B827) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    _id_3B53BC0EEE6AE84E = level.br_pickups._id_3B53BC0EEE6AE84E;
    _id_7591ED99E87A77D3 = undefined;

    if(isDefined(pickup)) {
      if(isDefined(pickup._id_96C7526F4AB04875))
        _id_3B53BC0EEE6AE84E = pickup._id_96C7526F4AB04875;

      if(isDefined(pickup.origin))
        _id_7591ED99E87A77D3 = pickup.origin;
    }

    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, _id_3B53BC0EEE6AE84E, undefined, undefined, _id_7591ED99E87A77D3);
    spawnpickup(level.br_pickups._id_838863C4848D4C26[_id_0FE0F715FC43F378], _id_CB4FAD49263E20C4);
    return;
  }

  dropbrkillstreak(dropstruct, _id_7F437A5779C8787C);
}

dropbrkillstreak(dropstruct, _id_7F437A5779C8787C, _id_DB943473454F6EA6, _id_4C6EBA41707C461F, pickup) {
  if(hasanykillstreak()) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    scriptable = level.br_pickups._id_838863C4848D4C26[self.streakdata.streaks[1].streakname];

    if(isDefined(_id_DB943473454F6EA6)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptable);
      _id_2D9D24F7C63AC143::_id_3C3EE4C5700E0E32(self, _id_DB943473454F6EA6, lootid, 1, 65535, 0);
      return;
    }

    _id_3B53BC0EEE6AE84E = level.br_pickups._id_3B53BC0EEE6AE84E;
    _id_7591ED99E87A77D3 = undefined;

    if(isDefined(pickup)) {
      if(isDefined(pickup._id_96C7526F4AB04875))
        _id_3B53BC0EEE6AE84E = pickup._id_96C7526F4AB04875;

      if(isDefined(pickup.origin))
        _id_7591ED99E87A77D3 = pickup.origin;
    }

    baseorigin = self.origin;
    baseangles = self.angles;
    _id_AD49A38DD7C4C10F = level.br_pickups._id_AD49A38DD7C4C10F;

    if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk)) {
      _id_3B53BC0EEE6AE84E = undefined;
      _id_7591ED99E87A77D3 = undefined;
      _id_AD49A38DD7C4C10F = undefined;
      baseorigin = self.br_kiosk.origin;
      baseangles = self.br_kiosk.angles;

      if(isDefined(self.br_kiosk._id_AFC028D00356E443))
        baseorigin = self.br_kiosk._id_AFC028D00356E443;
    }

    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, _id_AD49A38DD7C4C10F, _id_3B53BC0EEE6AE84E, undefined, undefined, _id_7591ED99E87A77D3);
    _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_75376790B7CF7E23", 0);
    item = spawnpickup(scriptable, _id_CB4FAD49263E20C4, 1, 1, undefined, _id_1AD2DB70C8D01F51);
    _id_2F4E0022C686DBE6(item);
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

    if(istrue(_id_4C6EBA41707C461F)) {
      quickdropplaySound(3, _id_CB4FAD49263E20C4.origin, scriptable, item);
      return;
    }

    return;
  } else if(isDefined(_id_DB943473454F6EA6))
    _id_2D9D24F7C63AC143::_id_AD05407157B7D86D(self, _id_DB943473454F6EA6);
}

dropaccesscard(dropstruct) {
  if(_id_2CEDCC356F1B9FC8::hasaccesscard()) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(self.accesscard, _id_CB4FAD49263E20C4, undefined, undefined, undefined, isalive(self));
    _id_2F4E0022C686DBE6(item);
    removeaccesscard();
  }
}

dropbrselfrevivetoken(dropstruct) {
  if(_id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(_id_2CEDCC356F1B9FC8::_id_791E72676CD7B544(self), _id_CB4FAD49263E20C4, 1, 1);
    _id_2F4E0022C686DBE6(item);
    removeselfrevivetoken();
  }
}

dropbrcustompickupitem(scriptablename, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585) {
  _id_7FEBA4EC6C35D82D = istrue(_id_1E736A37C3737585) && isDefined(scriptablename);

  if(_id_7FEBA4EC6C35D82D) {
    _id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    dropstruct = _id_7B9F3966A7A42003();

    if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      _id_E1D097C517C3AF5B = self.br_kiosk _id_4F4D537C794B2BF5();
      self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = self.br_kiosk.dropstruct;
      _id_8E4538D786FB9418 = scripts\engine\utility::_id_53C4C53197386572(_id_8E4538D786FB9418, 1);
      _id_285B7129B392CF3D = self.br_kiosk quickdropaddtoexisting(undefined, scriptablename, _id_8E4538D786FB9418);

      if(!_id_285B7129B392CF3D) {
        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, scripts\engine\utility::_id_53C4C53197386572(self.br_kiosk._id_AFC028D00356E443, self.br_kiosk.origin), self.br_kiosk.angles, self);
        item = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_8E4538D786FB9418, 1, undefined, 0);
        self.br_kiosk quickdropaddtocache(scriptablename, undefined, item, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
        return;
      }
    } else {
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      item = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_8E4538D786FB9418);
      _id_2F4E0022C686DBE6(item);
    }
  }
}

dropspecialistbonus(dropstruct) {
  if(_id_2CEDCC356F1B9FC8::hasspecialistbonus()) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, undefined, undefined, undefined, isalive(self));
    _id_2F4E0022C686DBE6(item);
    removespecialistbonuspickup();
  }
}

_id_B8FAA69B95FE55BE(dropstruct) {
  if(isDefined(self._id_028C944F222F4814) && isDefined(self._id_028C944F222F4814._id_183EC729C8876D57))
    item = _id_55E418C5CC946593::_id_3AF23B0BFAF91DBD(dropstruct);
}

_id_A61F07010C727C0A(dropstruct) {
  if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(self)) {
    quantity = _id_2391409EF7B431E1::_id_57711583C5D26490(self);

    if(isDefined(quantity)) {
      [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
      _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      _id_5983083928CE568C = _id_2391409EF7B431E1::_id_59771B0CC100410A(self);
      _id_3DD3ADFB27186CD7 = spawnpickup(_id_5983083928CE568C, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 0, undefined, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);

      if(isDefined(_id_3DD3ADFB27186CD7)) {
        _id_2391409EF7B431E1::_id_BC03AA369196F2BF(self, 0);
        self.dogtag = _id_3DD3ADFB27186CD7;
        _id_2F4E0022C686DBE6(_id_3DD3ADFB27186CD7);
      }

      if(isDefined(level._id_547167A7517600FB) && isDefined(level._id_547167A7517600FB._id_A5354AFEB0D5DFCC))
        [[level._id_547167A7517600FB._id_A5354AFEB0D5DFCC]](self);
    }
  }
}

_id_5EBF3E99B419D949(dropstruct) {
  if(getdvarint("dvar_74ABB928AB13113B", 0) == 0) {
    return;
  }
  [_id_3793828403C6873E, lootid] = _id_728FFCEE8CBF30EE::_id_C1A30DB229B1311D(self, 0);

  while(isDefined(_id_3793828403C6873E)) {
    _id_B41950C9B54B12E0(dropstruct, _id_3793828403C6873E, lootid);
    [_id_3793828403C6873E, lootid] = _id_728FFCEE8CBF30EE::_id_C1A30DB229B1311D(self, _id_3793828403C6873E + 1);
  }
}

_id_B41950C9B54B12E0(dropstruct, _id_3793828403C6873E, lootid) {
  _id_2713F4A3502D1624 = _id_2D9D24F7C63AC143::_id_91C1BE871300A518(lootid);

  if(isDefined(_id_728FFCEE8CBF30EE::_id_96A1620D901981D1(_id_2713F4A3502D1624, 0))) {
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    _id_728FFCEE8CBF30EE::_id_3A7809BE256ADADB(_id_CB4FAD49263E20C4, self);
    _id_18795864529A7FCF = spawnpickup(_id_2713F4A3502D1624, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
    _id_728FFCEE8CBF30EE::_id_A5130B39363778B7(self, _id_18795864529A7FCF, _id_3793828403C6873E);
  }
}

_id_2F4E0022C686DBE6(item) {
  if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(item))
    self._id_D2DBB2FA012E6D9C[self._id_D2DBB2FA012E6D9C.size] = item;
}

ispickupstackable(scriptablename) {
  return istrue(level.br_pickups.stackable[scriptablename]);
}

isitemslotopen() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.br_inventory_slots[_id_AC0E594AC96AA3A8]))
      return 1;
  }

  return 0;
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

canslotitem(scriptablename, _id_E52A49E4832AC060) {
  if(ispickupstackable(scriptablename)) {
    if(canstackpickup(scriptablename, _id_E52A49E4832AC060))
      return 1;
  }

  return isitemslotopen();
}

getfirstopenslot() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.br_inventory_slots[_id_AC0E594AC96AA3A8]))
      return _id_AC0E594AC96AA3A8;
  }

  return -1;
}

pickupitemintoinventory(pickup) {
  if(ispickupstackable(pickup.scriptablename)) {
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

dropitemfrominventory(slot) {
  if(isDefined(self.br_inventory_slots[slot])) {
    item = self.br_inventory_slots[slot];
    _id_CB4FAD49263E20C4 = getitemdropinfo(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
    pickupent = spawnpickup(item.scriptablename, _id_CB4FAD49263E20C4, item.count);
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item.scriptablename, "dropped", pickupent, self, _id_CB4FAD49263E20C4.origin);

    if(isDefined(item.armorhealth))
      pickupent.armorhealth = item.armorhealth;
    else if(isDefined(item.helmethealth))
      pickupent.helmethealth = item.helmethealth;
    else if(isDefined(item.gasmaskhealth))
      pickupent.gasmaskhealth = item.gasmaskhealth;

    _id_715028F54BAD19A1::branalytics_lootdrop(self, item.scriptablename);
    _id_2CEDCC356F1B9FC8::removeitemfrominventory(slot);
  }
}

takegenericgrenadepickup(pickupent) {
  ammocount = scripts\mp\equipment::getequipmentslotammo("primary");

  if(isDefined(ammocount) && ammocount < 2)
    scripts\mp\equipment::incrementequipmentslotammo("primary");

  ammocount = scripts\mp\equipment::getequipmentslotammo("secondary");

  if(isDefined(ammocount) && ammocount < 2)
    scripts\mp\equipment::incrementequipmentslotammo("secondary");
}

trypickupitemfroment(pickupent) {
  if(canslotitem(pickupent.scriptablename, pickupent.count))
    pickupitemintoinventory(pickupent);
  else {
    self iprintlnbold("No room in inventory");
    self playlocalsound("br_pickup_deny");
  }
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

droparmor(itemtype, _id_9300220825E28F00) {
  _id_CB4FAD49263E20C4 = getitemdropinfo(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
  pickupent = spawnpickup(itemtype, _id_CB4FAD49263E20C4);
  pickupent.count = 1;
  pickupent.helmethealth = 0;
  pickupent.armorhealth = 0;
  pickupent.gasmaskhealth = 0;

  if(issubstr(itemtype, "helmet")) {
    pickupent.helmethealth = _id_9300220825E28F00;

    if(itemtype == "brloot_armor_helmet_3")
      scripts\mp\utility\perk::removeperk("specialty_stun_resistance");
  }

  _id_715028F54BAD19A1::branalytics_lootdrop(self, itemtype);
}

trydroparmorfornewarmor(scriptablename) {
  if(_id_2CEDCC356F1B9FC8::ishelmet(scriptablename)) {
    if(isDefined(self.br_helmetlevel)) {
      itemtype = _id_07C40FA80892A721::helmetitemtypeforlevel(self.br_helmetlevel);

      if(isDefined(itemtype))
        droparmor(itemtype, self.br_helmethealth);
    }
  }
}

tryequiparmor(item, slot) {
  if(isDefined(slot))
    self.br_inventory_slots[slot] = undefined;

  trydroparmorfornewarmor(item.scriptablename);

  if(item.scriptablename == "brloot_armor_helmet_1")
    _id_07C40FA80892A721::takehelmet(item, 1);
  else if(item.scriptablename == "brloot_armor_helmet_2")
    _id_07C40FA80892A721::takehelmet(item, 2);
  else if(item.scriptablename == "brloot_armor_helmet_3")
    _id_07C40FA80892A721::takehelmet(item, 3);
}

initpickupusability() {
  scripts\common\interactive::interactive_addusedcallback(::brpickupsusecallback, "br_pickups");
}

brpickupsusecallback(entity, player) {
  results = player cantakepickup(entity);
  player showuseresultsfeedback(results);

  if(results != 1) {
    return;
  }
  player onusecompleted(entity);
  deregisterscriptableinstance(entity);

  if(entity isscriptable())
    entity freescriptable();
  else
    entity delete();
}

handleexplosivepickup(equipname, slot) {
  dropstruct = _id_7B9F3966A7A42003();

  if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(equipname))) {
    _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, equipname);
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
    result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, 1);

    if(istrue(result) && !pickupissameasequipmentslot(equipname, slot) && scripts\mp\equipment::getequipmentslotammo(slot) > 0) {
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_FEB782334DD23A66;
      _id_60227BFF1E9478CC.count = 1;
      _id_EFDDDF60C5DB058C(_id_60227BFF1E9478CC);
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
      return;
    }

    if(isDefined(self.equipment[slot]) && scripts\mp\equipment::getequipmentslotammo(slot) > 0)
      dropequipmentinslot(dropstruct, slot);

    scripts\mp\equipment::giveequipment(equipname, slot);
    scripts\mp\equipment::setequipmentammo(equipname, 1);
    return;
  } else {
    if(isDefined(self.equipment[slot]) && scripts\mp\equipment::getequipmentslotammo(slot) > 0)
      dropequipmentinslot(dropstruct, slot);

    scripts\mp\equipment::giveequipment(equipname, slot);
    scripts\mp\equipment::setequipmentammo(equipname, 1);
  }
}

superslotcleanup(owner) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !level.allowsupers && !scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
    owner scripts\mp\equipment::takeequipment("super");
}

_id_75520EA44545C906() {
  if(istrue(self.gasmaskequipped)) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }

  self.gasmaskswapinprogress = 0;
  _id_04D16B9C52EFA3B8();
}

_id_04D16B9C52EFA3B8() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self._id_FE63300B318B76B0 = undefined;
  _id_498B5814B18986C9::_id_F7171C4854FC6E65(self);
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("");
}

getquickdroparmorcount(_id_53AAAE2C915F815B) {
  _id_16D3878433169434 = "brloot_armor_plate";
  equipname = level.br_pickups.br_equipname[_id_16D3878433169434];
  _id_E97F18CF8C7E296B = level.equipment.table[equipname].defaultslot;

  if(isDefined(self.equipment[_id_E97F18CF8C7E296B])) {
    _id_B971E09CE070BD58 = scripts\mp\equipment::getequipmentslotammo(_id_E97F18CF8C7E296B);

    if(_id_B971E09CE070BD58 > 0) {
      if(istrue(_id_53AAAE2C915F815B))
        return _id_B971E09CE070BD58;
      else
        return 1;
    }
  }

  return 0;
}

getquickdropammocount(ammotype, _id_53AAAE2C915F815B) {
  _id_41FE346FD14B2567 = self.br_ammo[ammotype];
  clipsize = level.br_ammo_clipsize[ammotype];

  if(!isDefined(_id_41FE346FD14B2567) || !isDefined(clipsize))
    return 0;

  if(istrue(_id_53AAAE2C915F815B))
    return int(_id_41FE346FD14B2567);

  return int(min(clipsize, _id_41FE346FD14B2567));
}

getquickdropplundercount(_id_53AAAE2C915F815B) {
  _id_6233A26ECFB141A0 = getdvarint("dvar_A75FE77472FFFC90", 50);

  if(istrue(_id_53AAAE2C915F815B))
    return int(min(self.plundercount, 2047));

  return int(min(self.plundercount, _id_6233A26ECFB141A0));
}

getquickdropweapon(_id_3793828403C6873E) {
  _id_0CB8FEA2B4525691 = _id_13ECF3644442A3E7(self, _id_3793828403C6873E);
  weaponname = getcompleteweaponname(_id_0CB8FEA2B4525691);
  return weaponname;
}

_id_13ECF3644442A3E7(player, _id_3793828403C6873E) {
  if(_id_3793828403C6873E == 2)
    return _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

  weaponlist = player.equippedweapons;
  _id_BE28C7BBF8BD3F10 = _id_3793828403C6873E == 0;

  foreach(weapon in weaponlist) {
    if(scripts\mp\utility\weapon::_id_0D3C77884D93D850(weapon))
      continue;
    else if(scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(weapon))
      continue;
    else if(scripts\mp\utility\weapon::isgunlessweapon(weapon))
      continue;
    else if(weapon.inventorytype != "primary")
      continue;
    else if(scripts\mp\utility\weapon::ismeleeoverrideweapon(weapon))
      continue;
    else if(_id_BE28C7BBF8BD3F10)
      return weapon;
    else
      _id_BE28C7BBF8BD3F10 = 1;
  }
}

quickdropremovearmorfrominventory(itemslotindex, _id_9BE70D6D4FF253A1) {
  _id_16D3878433169434 = "brloot_armor_plate";
  equipname = level.br_pickups.br_equipname[_id_16D3878433169434];
  _id_E97F18CF8C7E296B = level.equipment.table[equipname].defaultslot;
  scripts\mp\equipment::decrementequipmentslotammo(_id_E97F18CF8C7E296B, _id_9BE70D6D4FF253A1);

  if(istrue(self.insertingarmorplate)) {
    ref = scripts\mp\equipment::getcurrentequipment(_id_E97F18CF8C7E296B);
    _id_3DBC3B058135CBFB = scripts\mp\equipment::getequipmentammo(ref);

    if(_id_3DBC3B058135CBFB < 1)
      self notify("try_armor_cancel", "all_armor_plates_dropped");
  }
}

_id_D655F2006CFE7789(_id_0EC22A950F210E39) {
  _id_3184653FDF31DB44 = makeweapon("iw9_me_fists_mp");
  _id_102D661B1CAA8BC1 = _id_3184653FDF31DB44;
  primaryweapons = self getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(weapon.inventorytype != "primary") {
      continue;
    }
    if(weapon != _id_3184653FDF31DB44 && weapon != _id_0EC22A950F210E39 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(weapon) && !scripts\mp\utility\weapon::_id_0D3C77884D93D850(weapon) && !scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(weapon)) {
      if(!self isalternatemode(weapon))
        _id_102D661B1CAA8BC1 = weapon;
      else {
        foreach(_id_BE014A8D5A4F68F4 in primaryweapons) {
          if(_id_BE014A8D5A4F68F4.basename == weapon.basename && _id_BE014A8D5A4F68F4.inventorytype == "altmode") {
            _id_102D661B1CAA8BC1 = _id_BE014A8D5A4F68F4;
            break;
          }
        }
      }

      break;
    }
  }

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(_id_0EC22A950F210E39)) {
    _id_D1AD88BF84DAA67F = self getweaponammostock(_id_0EC22A950F210E39);
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_0EC22A950F210E39);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      self.br_ammo[_id_811ABFDB6C33F17F] = min(_id_D1AD88BF84DAA67F, level._id_E6EA72FC5E3FCD00[_id_811ABFDB6C33F17F]);
      self.br_ammo[_id_811ABFDB6C33F17F] = _id_1E4A61DB11011446::get_int_or_0(self.br_ammo[_id_811ABFDB6C33F17F]);
    }
  }

  if(_id_2669878CF5A1B6BC::isminigunweapon(_id_0EC22A950F210E39))
    self notify("dropped_minigun");

  if(getdvarint("dvar_218B826F84233424", 0))
    _id_5EF33BFFAEDA4FA9(_id_0EC22A950F210E39, 0);

  _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(self, _id_0EC22A950F210E39);

  if(isDefined(_id_FE4048AD22C35D73))
    _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, _id_FE4048AD22C35D73, undefined);

  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0EC22A950F210E39);
  _id_2CEDCC356F1B9FC8::_id_64FA4C213439177F();

  if(!self hasweapon(_id_3184653FDF31DB44))
    self giveweapon(_id_3184653FDF31DB44);

  _id_724736FCF0FB6604::br_ammo_update_weapons(self);
  self switchtoweaponimmediate(_id_102D661B1CAA8BC1);
}

_id_62F068CEC343A111(player, itemtype, _id_3793828403C6873E, _id_9BE70D6D4FF253A1, _id_53AAAE2C915F815B, _id_180513E5B195F19A, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_E063B28D208E9A42) {
  _id_0EC22A950F210E39 = _id_13ECF3644442A3E7(player, _id_3793828403C6873E);

  if(!isDefined(_id_0EC22A950F210E39) || scripts\mp\utility\weapon::_id_0D3C77884D93D850(_id_0EC22A950F210E39) || scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(_id_0EC22A950F210E39) || scripts\mp\utility\weapon::_id_1E9278BA699927F7(_id_0EC22A950F210E39)) {
    return;
  }
  _id_9BE70D6D4FF253A1 = 0;
  _id_59BD51AFC73DF2CD = 0;
  _id_DAB81EAD77442A10 = 0;
  weaponobj = undefined;

  if(!isDefined(_id_0EC22A950F210E39) || isnullweapon(_id_0EC22A950F210E39) || _id_0EC22A950F210E39 == makeweapon("iw9_me_fists_mp") || _id_0EC22A950F210E39 == makeweapon("iw9_me_fists_mp_zmb") || self isskydiving())
    return 0;
  else {
    if(_id_3793828403C6873E == 2) {
      _id_9BE70D6D4FF253A1 = scripts\engine\utility::ter_op(isDefined(player._id_3EF503345DC57957), player._id_3EF503345DC57957, player getweaponammoclip(_id_0EC22A950F210E39));
      _id_59BD51AFC73DF2CD = scripts\engine\utility::ter_op(isDefined(player._id_00AD7897ECDBCB63), player._id_00AD7897ECDBCB63, player getweaponammoclip(_id_0EC22A950F210E39, "left"));

      if(_id_0EC22A950F210E39.hasalternate) {
        _id_6890A4CE965BBA99 = _id_0EC22A950F210E39 getaltweapon();

        if(isDefined(player._id_86B32AFF94B5714E))
          _id_DAB81EAD77442A10 = player._id_86B32AFF94B5714E;
        else if(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_6890A4CE965BBA99) != _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_0EC22A950F210E39))
          _id_DAB81EAD77442A10 = player getweaponammoclip(_id_6890A4CE965BBA99);
      }
    } else {
      _id_9BE70D6D4FF253A1 = player getweaponammoclip(_id_0EC22A950F210E39);
      _id_59BD51AFC73DF2CD = player getweaponammoclip(_id_0EC22A950F210E39, "left");

      if(_id_0EC22A950F210E39.hasalternate) {
        _id_6890A4CE965BBA99 = _id_0EC22A950F210E39 getaltweapon();

        if(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_6890A4CE965BBA99) != _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_0EC22A950F210E39))
          _id_DAB81EAD77442A10 = player getweaponammoclip(_id_6890A4CE965BBA99);
      }
    }

    weaponobj = _id_0EC22A950F210E39;
  }

  _id_96C4059AA2EABFB8 = undefined;

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    if(_id_3793828403C6873E == 2)
      _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(player, 2);
    else
      _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(player, _id_3793828403C6873E);
  }

  _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(player, weaponobj);
  _id_E1147886CCF51970 = undefined;

  if(isDefined(_id_FE4048AD22C35D73))
    _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(player, _id_FE4048AD22C35D73);

  _id_62F068CEC343A111 = getquickdropweapon(_id_3793828403C6873E);

  if(_id_3793828403C6873E == 2)
    _id_2D9D24F7C63AC143::_id_954372D604277278(player);
  else {
    _id_D655F2006CFE7789(_id_0EC22A950F210E39);
    _id_0B7A9CE0A2282B79::_id_BFEDEB20F8B77F3F(player, _id_3793828403C6873E, istrue(_id_E063B28D208E9A42));
  }

  if(istrue(_id_180513E5B195F19A))
    return 1;

  item = quickdropnewitem(itemtype, _id_62F068CEC343A111, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj, _id_96C4059AA2EABFB8, _id_96C7526F4AB04875, _id_7591ED99E87A77D3);

  if(isDefined(item)) {
    _id_6A8EC730B2BFA844::_id_D882E5D473C9B258(player, item, _id_0EC22A950F210E39);
    item._id_E1147886CCF51970 = _id_E1147886CCF51970;
  }

  if(isDefined(item)) {
    if(isDefined(player.tookweaponfrom[_id_62F068CEC343A111])) {
      item.owner = player.tookweaponfrom[_id_62F068CEC343A111];
      player.tookweaponfrom[_id_62F068CEC343A111] = undefined;
    } else
      item.owner = player;

    item.objweapon = weaponobj;
  }

  return 1;
}

_id_8AAB3CDA02F81C09(player, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A, _id_1AA3938720421958) {
  if(getdvarint("dvar_9E0E52E9B74F15EB", 0))
    return 0;

  _id_9BE70D6D4FF253A1 = getquickdropplundercount(_id_53AAAE2C915F815B);

  if(isDefined(_id_1AA3938720421958))
    _id_9BE70D6D4FF253A1 = _id_1AA3938720421958;

  if(_id_9BE70D6D4FF253A1 == 0)
    return 0;

  player _id_6AFF3948CF4CCA03::playerplunderdrop(_id_9BE70D6D4FF253A1);
  _id_8E5DD667F5BF1E1E = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_9BE70D6D4FF253A1);

  if(istrue(_id_180513E5B195F19A))
    return 1;

  quickdropnewitem(itemtype, _id_8E5DD667F5BF1E1E, _id_9BE70D6D4FF253A1);
  return 1;
}

_id_6F62CB4FC113349C(player, itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_3793828403C6873E);

  if(lootid == 0) {
    return;
  }
  _id_9BE70D6D4FF253A1 = undefined;
  _id_59BD51AFC73DF2CD = undefined;
  _id_DAB81EAD77442A10 = undefined;
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  _id_9E3428357E5DF2E3 = _id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid);

  if(_id_282D89F7705A2D63(ref))
    _id_BFC82C27ED3D9308(lootid, quantity, ref, _id_3793828403C6873E);

  if(_id_9E3428357E5DF2E3)
    [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
  else if(_id_53AAAE2C915F815B || _id_D345EEC68E01361F(lootid))
    _id_9BE70D6D4FF253A1 = quantity;
  else if(_id_2CEDCC356F1B9FC8::isammo(ref))
    _id_9BE70D6D4FF253A1 = int(min(quantity, level.br_pickups.counts[ref]));
  else
    _id_9BE70D6D4FF253A1 = 1;

  if(_id_55F0DAEA8408E3A9(ref))
    _id_3AACF02225CA0DA5::_id_04545674E87C5795(player, "stat_8970F52454669531");

  if(_id_55E418C5CC946593::_id_43044DA0ED44D79F(ref) && !istrue(_id_180513E5B195F19A)) {
    slot = _id_4F4D537C794B2BF5();
    thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    _id_55E418C5CC946593::_id_3AF23B0BFAF91DBD(dropstruct, undefined, undefined, _id_3793828403C6873E);
    _id_180513E5B195F19A = 1;
  } else if(_id_DF3F5431C93ED5A1(lootid))
    return 0;
  else if(_id_E4B6260DBB04B43D(ref)) {
    slot = _id_4F4D537C794B2BF5();
    thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    _id_27DE1507ED41F01E = _id_728FFCEE8CBF30EE::_id_96A1620D901981D1(lootid, 5);
    _id_7E4D1FADECFD0AE5 = _id_728FFCEE8CBF30EE::_id_6844602F3120E900(_id_27DE1507ED41F01E, 0);
    _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined);
    _id_728FFCEE8CBF30EE::_id_3A7809BE256ADADB(_id_CB4FAD49263E20C4, self);
    _id_F7806D4CF24AACD3 = spawnpickup(_id_7E4D1FADECFD0AE5, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 1, undefined, 0);
    _id_728FFCEE8CBF30EE::_id_A5130B39363778B7(self, _id_F7806D4CF24AACD3, _id_3793828403C6873E);
    _id_180513E5B195F19A = 1;
  } else if(_id_02D86BA79A58BB62(ref)) {
    slot = _id_4F4D537C794B2BF5();
    thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    player _id_744CAD313ED0A87E::_id_F9FF7C89B3792CCC(dropstruct, player._id_1FAF51A7DC279A8B);
    _id_180513E5B195F19A = 1;
  }

  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  scriptable = undefined;

  if(_id_2CEDCC356F1B9FC8::isammo(ref))
    scriptable = ref;
  else
    scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(istrue(_id_53AAAE2C915F815B) && isDefined(scriptable) && scriptable == "brloot_gascan") {
    [error, _id_CFCB8FC02F9DB4DC] = scripts\cp_mp\vehicles\vehicle_interact::_id_CF96FB01F9473D0D(_id_9BE70D6D4FF253A1);

    if(isDefined(error))
      scripts\mp\hud_message::showerrormessage(error);
    else {
      _id_2D9D24F7C63AC143::_id_E900E7E66383AD97(self, _id_3793828403C6873E, _id_CFCB8FC02F9DB4DC);
      playsoundatpos(self.origin + (0, 0, 30), "eqp_gas_can_siphon");
    }

    return;
  }

  player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_3793828403C6873E, scripts\engine\utility::ter_op(_id_9E3428357E5DF2E3, quantity, _id_9BE70D6D4FF253A1));
  player notify("dropped_backpack_item", ref);

  if(istrue(_id_180513E5B195F19A)) {
    return;
  }
  if(isDefined(scriptable))
    quickdropnewitem(itemtype, scriptable, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
}

_id_B130392812B25580(player, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_9BE70D6D4FF253A1 = player scripts\mp\equipment::getequipmentslotammo(scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E));

  if(!isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0)
    return 0;

  slot = scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E);
  ref = scripts\mp\equipment::getcurrentequipment(slot);

  if(ref == "equip_hb_sensor") {
    _id_9BE70D6D4FF253A1 = player _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();
    _id_53AAAE2C915F815B = 1;
  }

  if(!_id_53AAAE2C915F815B)
    _id_9BE70D6D4FF253A1 = 1;

  scripts\mp\equipment::decrementequipmentslotammo(slot, _id_9BE70D6D4FF253A1);

  if(!istrue(_id_180513E5B195F19A)) {
    _id_5F918FB78F83B464 = _id_4F4D537C794B2BF5();
    player thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = _id_5F918FB78F83B464;
    player dropequipmentinslot(dropstruct, slot, 0, _id_9BE70D6D4FF253A1, undefined, 0, itemtype, 1);
  }

  if(isDefined(ref) && ref == "equip_throwing_knife" && player scripts\mp\equipment::getequipmentslotammo(slot) == 0 && player scripts\mp\utility\perk::_hasperk("specialty_equip_throwingKnife"))
    player scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_ontake();

  return 1;
}

_id_1503D0B5B4C9D010(player, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_9BE70D6D4FF253A1 = 1;

  if(!player hasanykillstreak())
    return 0;

  if(!istrue(_id_180513E5B195F19A)) {
    slot = _id_4F4D537C794B2BF5();
    player thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    player dropbrkillstreak(dropstruct, 0, undefined, 1);
  }

  scripts\mp\killstreaks\killstreaks::removekillstreak(1);
  return 1;
}

_id_750E9A7F11BECD51(player, _id_180513E5B195F19A) {
  slot = _id_4F4D537C794B2BF5();
  player thread _id_1E450ADBA8DDC914();
  dropstruct = _id_7B9F3966A7A42003();
  dropstruct._id_DFBA5A2C3C6F0A07 = slot;
  player dropbrgasmask(dropstruct, _id_180513E5B195F19A);
  return 1;
}

_id_8F803EA058A13CBD(player, _id_180513E5B195F19A) {
  if(!istrue(_id_180513E5B195F19A)) {
    slot = _id_4F4D537C794B2BF5();
    player thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    player dropbrselfrevivetoken(dropstruct);
  } else
    player removeselfrevivetoken();

  return 1;
}

_id_B15E36B7BC247DDB(player, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_9BE70D6D4FF253A1 = player _id_FCDE72DCBCEC206B();
  _id_1189BD7FBE2861F8 = self.equipment["super"];

  if(isDefined(_id_1189BD7FBE2861F8) && player scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE() && scripts\mp\supers::issuperready())
    _id_9BE70D6D4FF253A1 = 1;

  if(isDefined(_id_1189BD7FBE2861F8) && _id_104E3370B024F998::_id_333146DD4B1C3317(_id_1189BD7FBE2861F8))
    return 0;

  if(!isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0)
    return 0;

  if(!_id_53AAAE2C915F815B)
    _id_9BE70D6D4FF253A1 = 1;

  if(!istrue(_id_180513E5B195F19A)) {
    if(isDefined(_id_1189BD7FBE2861F8) && _id_676F8221E501BED1::_id_852EA8E204596ED0(_id_1189BD7FBE2861F8))
      return 0;

    slot = _id_4F4D537C794B2BF5();
    player thread _id_1E450ADBA8DDC914();
    dropstruct = _id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = slot;
    player dropequipmentinslot(dropstruct, "super", 0, _id_9BE70D6D4FF253A1, undefined, 0, 4, 1);
  }

  if(scripts\mp\supers::issuperinuse())
    scripts\mp\supers::superusefinished();

  player resetsuper();
  self.equipment["super"] = undefined;
}

_id_52DF07E94B3CE0DF(player, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  if(player isreloading())
    return 0;

  ammotype = _id_724736FCF0FB6604::_id_5A80DBA504420037(_id_3793828403C6873E);
  ammocount = _id_724736FCF0FB6604::_id_1352197E2482F1CF(player, ammotype);

  if(!isDefined(ammocount) || ammocount == 0)
    return 0;

  if(!_id_53AAAE2C915F815B)
    ammocount = int(min(ammocount, _id_724736FCF0FB6604::_id_2BF8EAF550FBE399(ammotype)));

  _id_724736FCF0FB6604::br_ammo_take_type(player, ammotype, ammocount);

  if(!istrue(_id_180513E5B195F19A))
    quickdropnewitem(itemtype, ammotype, ammocount);

  return 1;
}

_id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  switch (itemtype) {
    case 0:
      _id_8AAB3CDA02F81C09(self, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 1:
      _id_62F068CEC343A111(self, itemtype, _id_3793828403C6873E, undefined, _id_53AAAE2C915F815B, _id_180513E5B195F19A, undefined, undefined, 1);
      break;
    case 10:
      _id_6F62CB4FC113349C(self, itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 2:
      _id_B130392812B25580(self, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 3:
      _id_1503D0B5B4C9D010(self, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 4:
      _id_B15E36B7BC247DDB(self, 1, _id_180513E5B195F19A);
      break;
    case 6:
      _id_750E9A7F11BECD51(self, _id_180513E5B195F19A);
      break;
    case 7:
      _id_8F803EA058A13CBD(self, _id_180513E5B195F19A);
      break;
    case 5:
      _id_52DF07E94B3CE0DF(self, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    default:
      return;
  }
}

quickdropcleanupcache() {
  _id_1CA69EE8605FC45D = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  self endon("death");
  level endon("game_ended");
  wait(_id_1CA69EE8605FC45D);
  self.quickdropcache = undefined;
}

quickdropaddtocache(scriptablename, slot, ent, droporigin, dropangles) {
  if(!isDefined(self.quickdropcache))
    self.quickdropcache = [];

  _id_01315B36154A5E3E = spawnStruct();
  _id_01315B36154A5E3E.scriptablename = scriptablename;
  _id_01315B36154A5E3E.slot = slot;
  _id_01315B36154A5E3E.ent = ent;
  _id_01315B36154A5E3E.droporigin = droporigin;
  _id_01315B36154A5E3E.dropangles = dropangles;
  _id_01315B36154A5E3E.playerorigin = self.origin;
  _id_01315B36154A5E3E.playeryaw = self.angles[1];

  if(isplunder(scriptablename))
    self.quickdropcache["cash"] = _id_01315B36154A5E3E;
  else
    self.quickdropcache[scriptablename] = _id_01315B36154A5E3E;

  thread quickdropcleanupcache();
}

quickdropcachematchesplayer(_id_9DC4EDEE6E76287A) {
  _id_5497DA879B5DC06E = 60.0;
  _id_9867768CEA965153 = squared(_id_5497DA879B5DC06E);
  _id_46E94FC9F78CEBFC = 45.0;
  _id_8336F113929858A6 = distancesquared(self.origin, _id_9DC4EDEE6E76287A.playerorigin);

  if(_id_8336F113929858A6 > _id_9867768CEA965153)
    return 0;

  _id_077B9E4B599269EB = abs(self.angles[1] - _id_9DC4EDEE6E76287A.playeryaw);

  if(_id_077B9E4B599269EB > _id_46E94FC9F78CEBFC)
    return 0;

  return 1;
}

quickdropfinditemincache(scriptablename) {
  if(!isDefined(scriptablename)) {
    return;
  }
  if(!isDefined(self.quickdropcache)) {
    return;
  }
  _id_4B1DC74724995FB7 = scriptablename;

  if(isplunder(scriptablename))
    _id_4B1DC74724995FB7 = "cash";

  if(!isDefined(self.quickdropcache[_id_4B1DC74724995FB7])) {
    return;
  }
  if(!isDefined(self.quickdropcache[_id_4B1DC74724995FB7].ent))
    self.quickdropcache[_id_4B1DC74724995FB7] = undefined;
  else if(distancesquared(self.quickdropcache[_id_4B1DC74724995FB7].droporigin, self.origin) > 20000)
    return;
}

quickdropcachefindslot() {
  if(!isDefined(self.quickdropcache))
    return 0;

  _id_1E299B4F7F8B3F95 = [];

  foreach(_id_9DC4EDEE6E76287A in self.quickdropcache) {
    if(isDefined(_id_9DC4EDEE6E76287A.ent)) {
      if(!quickdropcachematchesplayer(_id_9DC4EDEE6E76287A)) {
        continue;
      }
      _id_1E299B4F7F8B3F95[_id_9DC4EDEE6E76287A.slot] = 1;
    }
  }

  _id_E1D097C517C3AF5B = undefined;
  _id_DDE65F6AFBEC7591 = 0;
  _id_DBDAB5EE7FCAC18D = 0;
  _id_5B256C2C2DD532E3 = [0, 10, 1];

  for(;;) {
    _id_E1D097C517C3AF5B = _id_DBDAB5EE7FCAC18D * 11 + _id_5B256C2C2DD532E3[_id_DDE65F6AFBEC7591];

    if(!istrue(_id_1E299B4F7F8B3F95[_id_E1D097C517C3AF5B])) {
      break;
    }

    _id_DDE65F6AFBEC7591++;

    if(_id_DDE65F6AFBEC7591 >= _id_5B256C2C2DD532E3.size) {
      _id_DDE65F6AFBEC7591 = 0;
      _id_DBDAB5EE7FCAC18D++;
    }
  }

  return _id_E1D097C517C3AF5B;
}

_id_4F4D537C794B2BF5() {
  if(!isDefined(level._id_2DC1D82DA1DBFEAB))
    level._id_2DC1D82DA1DBFEAB = [0, 10, 1, 9, 2, 11, 21, 12, 20, 22, 32, 23, 31];

  if(!isDefined(self._id_1AC656BA9C98B8DB))
    self._id_1AC656BA9C98B8DB = 0;
  else
    self._id_1AC656BA9C98B8DB++;

  return level._id_2DC1D82DA1DBFEAB[self._id_1AC656BA9C98B8DB % level._id_2DC1D82DA1DBFEAB.size];
}

_id_1E450ADBA8DDC914() {
  self endon("disconnect");

  if(isDefined(self) && isDefined(self._id_1AC656BA9C98B8DB) && self._id_1AC656BA9C98B8DB == 0) {
    startorigin = self.origin;
    startangles = self.angles;

    while(isDefined(self) && distancesquared(startorigin, self.origin) < 100 && anglesdelta(startangles, self.angles) < 10)
      wait 1;

    if(isDefined(self)) {
      self._id_1AC656BA9C98B8DB = undefined;
      self notify("reset_slots");
    }
  }
}

_id_1CE1A3739DB60BFB(scriptablename) {
  if(isplunder(scriptablename))
    return "br_inventory_drop_plunder_med";
  else if(_id_2CEDCC356F1B9FC8::isammo(scriptablename))
    return "br_inventory_drop_ammo";
  else if(scriptablename == "brloot_offhand_throwingknife" || scriptablename == "brloot_offhand_shuriken")
    return "iw9_br_inventory_drop_knife";
  else if(scriptablename == "brloot_gascan")
    return "iw9_br_inventory_drop_gas_can";
  else if(_id_2CEDCC356F1B9FC8::isequipmentlethal(scriptablename))
    return "iw9_br_inventory_drop_lethal";
  else if(_id_2CEDCC356F1B9FC8::isequipmenttactical(scriptablename))
    return "iw9_br_inventory_drop_tactical";
  else if(_id_2CEDCC356F1B9FC8::isarmorplate(scriptablename))
    return "br_inventory_drop_armor";
  else if(isstartstr(scriptablename, "iw"))
    return "br_inventory_drop_weap";
  else if(isstartstr(scriptablename, "loot_key"))
    return "br_inventory_drop_key";

  return "br_inventory_drop_generic";
}

quickdropplaySound(itemtype, droporigin, scriptablename, _id_0E14905A4CDF3B12, weaponobj) {
  aliasname = undefined;

  switch (itemtype) {
    case 5:
      aliasname = "br_inventory_drop_ammo";
      break;
    case 0:
      if(scriptablename == "brloot_plunder_cash_uncommon_1")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_uncommon_2")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_uncommon_3")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_rare_1")
        aliasname = "br_inventory_drop_plunder_med";
      else if(scriptablename == "brloot_plunder_cash_rare_2")
        aliasname = "br_inventory_drop_plunder_med";
      else if(scriptablename == "brloot_plunder_cash_epic_1")
        aliasname = "br_inventory_drop_plunder_lrg";
      else if(scriptablename == "brloot_plunder_cash_epic_2")
        aliasname = "br_inventory_drop_plunder_lrg";
      else if(scriptablename == "brloot_plunder_cash_legendary_1")
        aliasname = "br_inventory_drop_plunder_extra_lrg";
      else
        aliasname = "br_inventory_drop_plunder_med";

      break;
    case 1:
      if(isDefined(weaponobj)) {
        thread _id_AED7983CF10CA9E2(_id_0E14905A4CDF3B12, weaponobj);
        return;
      } else
        aliasname = "br_inventory_drop_weap";

      break;
    case 10:
    case 7:
    case 6:
    case 4:
    case 3:
    case 2:
      aliasname = _id_1CE1A3739DB60BFB(scriptablename);
      break;
    default:
  }

  if(isDefined(aliasname)) {
    if(isDefined(_id_0E14905A4CDF3B12) && isvector(_id_0E14905A4CDF3B12.origin))
      playsoundatpos(_id_0E14905A4CDF3B12.origin, aliasname);
    else
      self playSound(aliasname);
  }
}

_id_AED7983CF10CA9E2(_id_0E14905A4CDF3B12, weaponobj) {
  origin = self.origin;
  basename = scripts\engine\utility::_id_53C4C53197386572(weaponobj.basename, "");
  material = scripts\engine\utility::_id_53C4C53197386572(weaponobj.material, "");

  if(isDefined(_id_0E14905A4CDF3B12) && isvector(_id_0E14905A4CDF3B12.origin))
    origin = _id_0E14905A4CDF3B12.origin;
  else {
    _id_FBB5190911C15C1B = self getvieworigin();
    origin = _id_FBB5190911C15C1B + anglesToForward(self getplayerangles()) * 100.0;
    origin = (origin[0], origin[1], _id_FBB5190911C15C1B[2]);
  }

  self playSound("br_inventory_drop_weap_toss_only");
  wait 0.5;
  _id_F39A1ABBE4EC2B6F = origin + (0, 0, -120);
  trace = scripts\engine\trace::ray_trace(origin, _id_F39A1ABBE4EC2B6F, self, undefined, 1);
  surfacetype = trace["surfacetype"];
  waittillframeend;
  scripts\mp\weapons::_id_E7DBBE9220D5E27B(surfacetype, basename, material);
}

quickdropaddtoexisting(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj) {
  _id_9DC4EDEE6E76287A = quickdropfinditemincache(scriptablename);

  if(isDefined(_id_9DC4EDEE6E76287A)) {
    _id_B3CE3FBCFC181AEF = _id_9DC4EDEE6E76287A.ent;
    _id_E5D77BF46A926594 = _id_9DC4EDEE6E76287A.droporigin;
    _id_C36E41058FF56216 = _id_9DC4EDEE6E76287A.dropangles;
    _id_E669DCD7466F65D9 = loot_getitemcount(_id_B3CE3FBCFC181AEF);
    _id_74B23B8EEA29A555 = loot_getitemcountlefthand(_id_B3CE3FBCFC181AEF);
    _id_4FF1E9F60BCF8FE8 = _id_3A5F7703319142DD(_id_B3CE3FBCFC181AEF);
    _id_623F993E8A5AC105 = _id_155B1A2C8879BDA5(_id_9DC4EDEE6E76287A.ent);

    if(!ispickupstackable(scriptablename) && !issubstr(_id_623F993E8A5AC105, "_cash"))
      return 0;

    _id_CFCB8FC02F9DB4DC = _id_E669DCD7466F65D9 + _id_9BE70D6D4FF253A1;

    if(_id_CFCB8FC02F9DB4DC >= 2048)
      return 0;

    if(!isDefined(_id_59BD51AFC73DF2CD))
      _id_59BD51AFC73DF2CD = 0;

    _id_9E57DC7AFE8604C8 = _id_74B23B8EEA29A555 + _id_59BD51AFC73DF2CD;

    if(!isDefined(_id_DAB81EAD77442A10))
      _id_DAB81EAD77442A10 = 0;

    _id_A69B5A02FFAE97FF = _id_4FF1E9F60BCF8FE8 + _id_DAB81EAD77442A10;
    _id_A6717FAE5964E4C6 = calcscriptablepayloadgravityarc(_id_E5D77BF46A926594 + (0, 0, 12), _id_E5D77BF46A926594);
    _id_CB4FAD49263E20C4 = getitemdropinfo(_id_E5D77BF46A926594, _id_C36E41058FF56216, _id_A6717FAE5964E4C6, _id_B3CE3FBCFC181AEF._id_BF8E5F003146AF44);
    _id_4B1DC74724995FB7 = scriptablename;

    if(isplunder(scriptablename)) {
      _id_4B1DC74724995FB7 = "cash";
      _id_3466C10973E9C476 = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_CFCB8FC02F9DB4DC);

      if(_id_3466C10973E9C476 != scriptablename)
        scriptablename = _id_3466C10973E9C476;
    }

    _id_0E14905A4CDF3B12 = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_CFCB8FC02F9DB4DC, 1, weaponobj, 0, _id_9E57DC7AFE8604C8, _id_A69B5A02FFAE97FF);

    if(isent(self) && isPlayer(self))
      _id_715028F54BAD19A1::branalytics_lootdrop(self, scriptablename, undefined, _id_9BE70D6D4FF253A1);

    if(isDefined(weaponobj))
      level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0E14905A4CDF3B12, self, weaponobj);

    _id_CB3339ECE72DBDEB = scriptablename;

    if(isplunder(scriptablename))
      _id_CB3339ECE72DBDEB = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_CFCB8FC02F9DB4DC);

    if(isDefined(itemtype))
      quickdropplaySound(itemtype, _id_E5D77BF46A926594, _id_CB3339ECE72DBDEB, _id_0E14905A4CDF3B12);

    self.quickdropcache[_id_4B1DC74724995FB7].ent = _id_0E14905A4CDF3B12;
    thread quickdropcleanupcache();
    deregisterscriptableinstance(_id_B3CE3FBCFC181AEF);

    if(isent(_id_B3CE3FBCFC181AEF))
      _id_B3CE3FBCFC181AEF delete();
    else
      _id_B3CE3FBCFC181AEF freescriptable();

    return 1;
  }

  return 0;
}

quickdropnewitem(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj, _id_96C4059AA2EABFB8, _id_96C7526F4AB04875, _id_7591ED99E87A77D3) {
  _id_285B7129B392CF3D = quickdropaddtoexisting(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj);

  if(_id_285B7129B392CF3D) {
    return;
  }
  slot = _id_4F4D537C794B2BF5();
  thread _id_1E450ADBA8DDC914();
  dropstruct = _id_7B9F3966A7A42003();
  dropstruct._id_DFBA5A2C3C6F0A07 = slot;
  _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, _id_96C7526F4AB04875, undefined, undefined, _id_7591ED99E87A77D3);
  _id_0E14905A4CDF3B12 = undefined;
  _id_EC7DED352736C3B1 = _id_4ACBD920A4F5A24D::extract_ismissionweapon(weaponobj);

  if(!_id_EC7DED352736C3B1) {
    _id_0E14905A4CDF3B12 = spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 1, weaponobj, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(scriptablename, "dropped", _id_0E14905A4CDF3B12, self, _id_CB4FAD49263E20C4.origin);
    _id_189B67B2735B981D::_id_ABA04688789CE643(_id_0E14905A4CDF3B12, weaponobj);
    quickdropaddtocache(scriptablename, slot, _id_0E14905A4CDF3B12, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
    _id_715028F54BAD19A1::branalytics_lootdrop(self, scriptablename, undefined, _id_9BE70D6D4FF253A1);

    if(isDefined(weaponobj)) {
      level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0E14905A4CDF3B12, self, weaponobj);

      if(_id_724736FCF0FB6604::_id_B1DD9DCAE2F63965())
        _id_724736FCF0FB6604::_id_8E7E1DA48D7746E5(self, _id_0E14905A4CDF3B12);

      if(getdvarint("dvar_752EEED3DDCBD04B", 0) == 0) {
        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

        if(isDefined(ammotype) && _id_724736FCF0FB6604::_id_AD972C1D0F29841C(self, weaponobj) && self.br_ammo[ammotype] > 0) {
          _id_0660523CFF419F0B = getdvarint("dvar_3C4EDD0A748E4053", 1);
          _id_4E06553818889332 = _id_CB4FAD49263E20C4.origin - self.origin;
          upvec = anglestoup(_id_CB4FAD49263E20C4.angles);
          _id_5A060C381DCE3622 = vectorcross(vectorNormalize(_id_4E06553818889332), upvec);
          _id_5A060C381DCE3622 = rotatepointaroundvector(upvec, _id_5A060C381DCE3622, getdvarint("dvar_51CB230BBD599B71", 20));
          _id_9EDC776840BAFF95 = _id_CB4FAD49263E20C4.origin + _id_5A060C381DCE3622 * getdvarint("dvar_16E74796DF75B8D0", 20);
          _id_1299B62E1FEDD7DF = _id_7B9F3966A7A42003();
          _id_CB4FAD49263E20C4 = getitemdroporiginandangles(_id_1299B62E1FEDD7DF, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_9EDC776840BAFF95);
          _id_F14355041A2A65AB = spawnpickup(ammotype, _id_CB4FAD49263E20C4, self.br_ammo[ammotype], 1, undefined, _id_0660523CFF419F0B);
          _id_724736FCF0FB6604::br_ammo_take_type(self, ammotype, self.br_ammo[ammotype]);
        }
      }
    }

    if(isDefined(_id_96C4059AA2EABFB8))
      _id_0E14905A4CDF3B12._id_4E479E14D0837E84 = _id_96C4059AA2EABFB8;
  }

  if(isplunder(scriptablename)) {
    _id_0E14905A4CDF3B12._id_6216E086379DEF7D = 1;
    scriptablename = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_9BE70D6D4FF253A1);
  }

  scripts\cp_mp\calloutmarkerping::_id_1062F2AF5C7D843E(scriptablename, weaponobj);
  quickdropplaySound(itemtype, _id_CB4FAD49263E20C4.origin, scriptablename, _id_0E14905A4CDF3B12, weaponobj);
  return _id_0E14905A4CDF3B12;
}

quickdropitem(itemtype, _id_3793828403C6873E, _id_180513E5B195F19A) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, 0, _id_180513E5B195F19A);
}

quickdropall(itemtype, _id_3793828403C6873E, _id_180513E5B195F19A) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, 1, _id_180513E5B195F19A);
}

_id_F7E756154EC35632(itemtype, _id_3793828403C6873E) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_BAA2DEF287F02CC9 = self._id_02FA5B49969DEF47.contents[0]["lootID"];
  _id_0EE01CB619969C19 = self._id_02FA5B49969DEF47.contents[0]["quantity"];
  _id_BBDE9E028D7E5CBA = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_BAA2DEF287F02CC9);
  _id_53AAAE2C915F815B = 0;
  _id_180513E5B195F19A = 0;

  if(isDefined(self._id_02FA5B49969DEF47.itemtype) && isDefined(self._id_02FA5B49969DEF47._id_3793828403C6873E) && self._id_02FA5B49969DEF47.itemtype == itemtype && self._id_02FA5B49969DEF47._id_3793828403C6873E == _id_3793828403C6873E) {
    return;
  }
  switch (itemtype) {
    case 10:
      _id_4C2DFFBF69902599 = isDefined(_id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9());

      if(istrue(_id_4C2DFFBF69902599)) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.scriptablename = _id_BBDE9E028D7E5CBA;
        _id_60227BFF1E9478CC.count = _id_0EE01CB619969C19;
        _id_60227BFF1E9478CC.origin = self._id_02FA5B49969DEF47.origin;

        if(_id_02D86BA79A58BB62(_id_BBDE9E028D7E5CBA)) {
          if(isDefined(self._id_02FA5B49969DEF47.contents[0]["extraInfoEnt"])) {
            _id_60227BFF1E9478CC._id_1FAF51A7DC279A8B = self._id_02FA5B49969DEF47.contents[0]["extraInfoEnt"];
            _id_A6AB8D0FDA441DC2 = scripts\mp\utility\player::getteamarray(self.team, 0);
            _id_B939ABDEDC45C697 = self.team;

            if(isDefined(self._id_02FA5B49969DEF47.contents[0]["extraInfoTeam"]))
              _id_B939ABDEDC45C697 = self._id_02FA5B49969DEF47.contents[0]["extraInfoTeam"];

            _id_744CAD313ED0A87E::_id_7BC622D2FE4B2017(_id_60227BFF1E9478CC._id_1FAF51A7DC279A8B, 0, _id_A6AB8D0FDA441DC2, _id_B939ABDEDC45C697, self.team);
          }
        } else if(_id_E4B6260DBB04B43D(_id_BBDE9E028D7E5CBA))
          _id_60227BFF1E9478CC._id_84B9876DBE3B246C = self._id_02FA5B49969DEF47._id_84B9876DBE3B246C;

        _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(_id_BAA2DEF287F02CC9, _id_60227BFF1E9478CC, undefined, 1);
        self._id_02FA5B49969DEF47.contents[0]["lootID"] = 0;
        self._id_02FA5B49969DEF47.contents[0]["quantity"] = 0;
        scripts\mp\loot::_id_446C7AD7BCC70992(self, self._id_02FA5B49969DEF47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self._id_02FA5B49969DEF47 notify("closed");
        loothide(self._id_02FA5B49969DEF47);
      }

      break;
    case 2:
      _id_9BE70D6D4FF253A1 = scripts\mp\equipment::getequipmentslotammo(scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E));
      _id_4C2DFFBF69902599 = !isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0;

      if(_id_4C2DFFBF69902599) {
        slot = scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E);
        _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_BAA2DEF287F02CC9);
        _id_402526809B38DA5F = scripts\mp\equipment::getequipmentmaxammo(_id_CB325DDB4A764623);
        _id_402526809B38DA5F = scripts\engine\utility::_id_53C4C53197386572(_id_402526809B38DA5F, 1);
        _id_75E244E5F45C894D = _id_0EE01CB619969C19;

        if(_id_402526809B38DA5F < _id_0EE01CB619969C19) {
          _id_75E244E5F45C894D = _id_402526809B38DA5F;
          dropstruct = _id_7B9F3966A7A42003();
          _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, self._id_02FA5B49969DEF47.origin);
          item = spawnpickup(_id_BBDE9E028D7E5CBA, _id_CB4FAD49263E20C4, _id_0EE01CB619969C19 - _id_402526809B38DA5F, 1, undefined, 0);
        }

        self._id_02FA5B49969DEF47.contents[0]["lootID"] = 0;
        self._id_02FA5B49969DEF47.contents[0]["quantity"] = 0;
        scripts\mp\loot::_id_446C7AD7BCC70992(self, self._id_02FA5B49969DEF47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self._id_02FA5B49969DEF47 notify("closed");
        loothide(self._id_02FA5B49969DEF47);
        scripts\mp\equipment::giveequipment(_id_CB325DDB4A764623, slot);
        scripts\mp\equipment::setequipmentammo(_id_CB325DDB4A764623, _id_75E244E5F45C894D);
      }

      break;
    case 4:
      _id_9BE70D6D4FF253A1 = scripts\mp\equipment::getequipmentslotammo("super");
      _id_4C2DFFBF69902599 = !isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0;

      if(_id_4C2DFFBF69902599) {
        equipname = level.br_pickups.br_equipname[_id_BBDE9E028D7E5CBA];
        _id_5237A188CCDA4D7B = level.br_pickups._id_14BD11727C4B6629[_id_BBDE9E028D7E5CBA];
        self._id_02FA5B49969DEF47.contents[0]["lootID"] = 0;
        self._id_02FA5B49969DEF47.contents[0]["quantity"] = 0;
        scripts\mp\loot::_id_446C7AD7BCC70992(self, self._id_02FA5B49969DEF47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self._id_02FA5B49969DEF47 notify("closed");
        loothide(self._id_02FA5B49969DEF47);
        _givebrsuper(equipname, _id_5237A188CCDA4D7B, _id_0EE01CB619969C19);
      }

      break;
    default:
      break;
  }
}

_id_CAB3366841D709AA(itemslotindex) {
  level endon("game_ended");
  [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(itemslotindex);
  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(_id_282D89F7705A2D63(_id_CB325DDB4A764623)) {
    _id_27443A5346BC8120(lootid, quantity, _id_CB325DDB4A764623, itemslotindex);
    return;
  }

  if(!isDefined(_id_CB325DDB4A764623) || isDefined(_id_CB325DDB4A764623) && !_id_2CEDCC356F1B9FC8::isammo(_id_CB325DDB4A764623)) {
    self._id_0E0C39101BFC15D2[itemslotindex] = 1;
    _id_FE539E37B6579930(lootid, quantity, itemslotindex, undefined, 1);
    self._id_0E0C39101BFC15D2[itemslotindex] = undefined;
  }
}

_id_27443A5346BC8120(lootid, quantity, _id_CB325DDB4A764623, itemslotindex) {
  if(_id_CB325DDB4A764623 == "brloot_nvg")
    _id_60EA3B868E7A009B();
  else if(_id_CB325DDB4A764623 == "brloot_disguise") {
    if(!_id_7C03AB87C5F9F420::_id_D3B190EE881C5CA7())
      _id_7C03AB87C5F9F420::_id_C2AFDDB38BD47F6F(itemslotindex, quantity);
    else
      _id_7C03AB87C5F9F420::_id_3EDE6B66136C0F93();
  }
}

_id_60EA3B868E7A009B() {
  _id_E036BEB70DA584EC = self isnightvisionon();

  if(_id_E036BEB70DA584EC)
    self nightvisionviewoff();
  else
    self nightvisionviewon();

  thread scripts\mp\equipment\nvg::nvg_monitor();
}

_id_BFC82C27ED3D9308(lootid, quantity, _id_CB325DDB4A764623, itemslotindex) {
  if(_id_CB325DDB4A764623 == "brloot_nvg") {
    _id_C0CDB299FADBABC3 = _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);

    if(_id_C0CDB299FADBABC3 <= 1) {
      if(self isnightvisionon())
        self nightvisionviewoff();
    }

    thread _id_5DDB83E059EE76C9(lootid);
  } else if(_id_CB325DDB4A764623 == "brloot_disguise") {
    if(_id_7C03AB87C5F9F420::_id_D3B190EE881C5CA7()) {
      if(_id_7C03AB87C5F9F420::_id_65A78266EAD29817())
        thread _id_2EA494708E46229B(lootid);
      else
        _id_7C03AB87C5F9F420::_id_3EDE6B66136C0F93();
    }
  }
}

_id_2EA494708E46229B(lootid) {
  self notify("watch_disguise_backpack");
  level endon("game_ended");
  self endon("watch_disguise_backpack");
  self endon("disconnect");

  while(_id_7C03AB87C5F9F420::_id_65A78266EAD29817())
    waitframe();

  _id_5773C32EC9B66A48 = _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

  if(_id_5773C32EC9B66A48) {
    return;
  }
  _id_7C03AB87C5F9F420::_id_3EDE6B66136C0F93();
}

_id_5DDB83E059EE76C9(lootid) {
  self notify("watch_nvg_backpack");
  level endon("game_ended");
  self endon("watch_nvg_backpack");
  self endon("disconnect");
  self endon("night_vision_off");
  wait 1.0;
  _id_11A1FA68AEB971C0 = _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

  if(_id_11A1FA68AEB971C0) {
    return;
  }
  self nightvisionviewoff();
}

_id_282D89F7705A2D63(_id_CB325DDB4A764623) {
  if(!isDefined(_id_CB325DDB4A764623))
    return 0;

  switch (_id_CB325DDB4A764623) {
    case "brloot_disguise":
    case "brloot_nvg":
      return 1;
    default:
      return 0;
  }
}

_id_F1A38D2BA0BBCB08(player, itemslotindex, _id_5C31C74D6D007E20) {
  if(isDefined(player.plundercount) && player.plundercount >= level.br_plunder.plunderlimit) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyplunderpickup);
    return;
  }

  [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(itemslotindex);
  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  _id_09FB3B576439EE3D = 1;

  if(istrue(_id_5C31C74D6D007E20) && !_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid))
    _id_09FB3B576439EE3D = quantity;

  if(isDefined(_id_CB325DDB4A764623) && (_id_7E2F2A69FC0C022B(_id_CB325DDB4A764623) || _id_9E3428357E5DF2E3(_id_CB325DDB4A764623) || _id_EAC097CE4C683AB9(_id_CB325DDB4A764623) || _id_32125EBA262380C7(_id_CB325DDB4A764623) && scripts\engine\utility::array_contains_key(level.br_pickups._id_D93566A78E29D583, _id_CB325DDB4A764623) && level.br_pickups._id_D93566A78E29D583[_id_CB325DDB4A764623] > 0)) {
    _id_B87F7FAE01CE754F = _id_09FB3B576439EE3D * level.br_pickups._id_D93566A78E29D583[_id_CB325DDB4A764623];

    if(isDefined(player.plundercount) && _id_B87F7FAE01CE754F + player.plundercount > level.br_plunder.plunderlimit) {
      _id_2C86AF91E7E20602 = _id_B87F7FAE01CE754F + player.plundercount - level.br_plunder.plunderlimit;
      _id_B87F7FAE01CE754F = level.br_plunder.plunderlimit - player.plundercount;

      if(_id_2C86AF91E7E20602 > 0) {
        _id_8E5DD667F5BF1E1E = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_2C86AF91E7E20602);
        dropstruct = _id_7B9F3966A7A42003();
        _id_96C7526F4AB04875 = undefined;

        if(isDefined(player.br_kiosk))
          _id_96C7526F4AB04875 = distance2d(player.origin, player.br_kiosk.origin) / 2;

        _id_CB4FAD49263E20C4 = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, undefined, _id_96C7526F4AB04875);
        spawnpickup(_id_8E5DD667F5BF1E1E, _id_CB4FAD49263E20C4, _id_2C86AF91E7E20602, 1);
      }
    }

    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_B87F7FAE01CE754F);
    player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(2, _id_B87F7FAE01CE754F);
    _id_74806F0C4CAA7E55 = _id_09FB3B576439EE3D;

    if(_id_9E3428357E5DF2E3(_id_CB325DDB4A764623))
      _id_74806F0C4CAA7E55 = quantity;

    if(_id_7E2F2A69FC0C022B(_id_CB325DDB4A764623))
      _id_6A8EC730B2BFA844::_id_2C407030F231CCC5(player, _id_CB325DDB4A764623);

    if(lootid == 35070)
      level._id_796BCFECDCC6BDF8._id_68623CDF221D38F5++;

    player notify("backpack_item_sold", lootid);
    player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(itemslotindex, _id_74806F0C4CAA7E55);
    player scripts\cp_mp\challenges::_id_EA50038423FC4CFC(type, _id_CB325DDB4A764623, lootid, _id_09FB3B576439EE3D, _id_B87F7FAE01CE754F);
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(lootid, "onItemSold", player, lootid, type, _id_09FB3B576439EE3D, _id_B87F7FAE01CE754F);
  }
}

_id_64F0398B29CF7C3E(player) {
  _id_1D4DB10D5290694A = player _id_2D9D24F7C63AC143::_id_254150D1E667DEE7();

  foreach(item in _id_1D4DB10D5290694A) {
    if(!isDefined(item.objweapon) && isDefined(item.index))
      _id_F1A38D2BA0BBCB08(player, item.index, 1);
  }
}

_id_E5845FF9B61AC5D7(weaponobj, quantity, itemslotindex, _id_E97D731BEDD44C63, _id_44EE85DCF52B4001, _id_5756AA71087F3439, _id_4E479E14D0837E84, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_E1147886CCF51970, _id_8BEAE58A219E6D44) {
  _id_BADA25504E8844D7 = spawnStruct();
  scriptablename = undefined;

  if(isDefined(weaponobj)) {
    _id_A48C0A5C6CBA3F2C = getcompleteweaponname(weaponobj);

    if(isDefined(level.br_pickups._id_9E78B5EE377070A9) && isDefined(level.br_pickups._id_9E78B5EE377070A9[_id_A48C0A5C6CBA3F2C]))
      scriptablename = level.br_pickups._id_9E78B5EE377070A9[_id_A48C0A5C6CBA3F2C];
  }

  _id_BADA25504E8844D7.scriptablename = scripts\engine\utility::_id_53C4C53197386572(scriptablename, "brloot_weapon_generic_pi");
  _id_BADA25504E8844D7.origin = scripts\engine\utility::ter_op(isDefined(_id_7591ED99E87A77D3), _id_7591ED99E87A77D3, self.origin);
  _id_BADA25504E8844D7.count = quantity;
  _id_BADA25504E8844D7.weapon = weaponobj;
  _id_BADA25504E8844D7.countlefthand = _id_8BEAE58A219E6D44;
  _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_E97D731BEDD44C63;
  _id_BADA25504E8844D7._id_4E479E14D0837E84 = _id_4E479E14D0837E84;
  _id_BADA25504E8844D7._id_96C7526F4AB04875 = _id_96C7526F4AB04875;
  _id_BADA25504E8844D7._id_E1147886CCF51970 = _id_E1147886CCF51970;
  _id_BADA25504E8844D7._id_C03C4EF51659BA4C = istrue(_id_44EE85DCF52B4001);
  onusecompleted(_id_BADA25504E8844D7, undefined, 1, 0, itemslotindex, undefined, _id_44EE85DCF52B4001, 0, _id_5756AA71087F3439);
  return 1;
}

_id_B76F69CE63757CEA(_id_A0CE8000D303764C) {
  player = self;

  if(!getdvarint("dvar_1F9797AA5675C82A", 0))
    return 0;

  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_A0CE8000D303764C);
  _id_08D4AD7AEA02F90E = player _id_2D9D24F7C63AC143::_id_5915BDBC5F6302B6([lootid]);

  if(isDefined(_id_08D4AD7AEA02F90E) && _id_08D4AD7AEA02F90E.size > 0) {
    player _id_CAB3366841D709AA(_id_08D4AD7AEA02F90E[0]);
    return 1;
  }

  return 0;
}

_id_FE539E37B6579930(lootid, quantity, itemslotindex, _id_E97D731BEDD44C63, _id_44EE85DCF52B4001, _id_5756AA71087F3439, _id_96C7526F4AB04875, _id_7591ED99E87A77D3) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename)) {
    return;
  }
  if(issuperpickup(scriptablename)) {
    if(scripts\mp\supers::issuperinuse() || scripts\mp\supers::_id_565913010C84FFCA()) {
      _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuper();
      _id_9CB951DE1A571D32 = isDefined(_id_D3C112E63BF53EE5) && isDefined(_id_D3C112E63BF53EE5.staticdata) && isDefined(_id_D3C112E63BF53EE5.staticdata.ref);
      ref = "";

      if(_id_9CB951DE1A571D32)
        ref = _id_D3C112E63BF53EE5.staticdata.ref;

      if(ref != "super_stimpistol" && ref != "super_oxygen_mask") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPERS_UNAVAILABLE_EQUIP");

        return;
      } else
        scripts\mp\supers::switchandtakesuperuseweapon();
    }

    if(isDefined(self.equipment["super"])) {
      _id_57B0241752598E4A = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);

      if(_id_57B0241752598E4A == scriptablename) {
        if(scripts\mp\equipment::getequipmentammo(self.equipment["super"]) != 0) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_A1A6A7680C4FF1EB);
          return undefined;
        }
      }
    }
  }

  _id_BADA25504E8844D7 = spawnStruct();
  _id_BADA25504E8844D7.scriptablename = scriptablename;
  _id_BADA25504E8844D7.origin = scripts\engine\utility::ter_op(isDefined(_id_7591ED99E87A77D3), _id_7591ED99E87A77D3, self.origin);
  _id_BADA25504E8844D7.count = quantity;
  _id_BADA25504E8844D7.maxcount = level.br_pickups.maxcounts[scriptablename];
  _id_BADA25504E8844D7.stackable = level.br_pickups.stackable[scriptablename];

  if(isDefined(_id_E97D731BEDD44C63))
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_E97D731BEDD44C63;

  _id_BADA25504E8844D7.countlefthand = 0;
  _id_BADA25504E8844D7._id_C03C4EF51659BA4C = istrue(_id_44EE85DCF52B4001);

  if(isDefined(_id_96C7526F4AB04875))
    _id_BADA25504E8844D7._id_96C7526F4AB04875 = _id_96C7526F4AB04875;

  if(iskillstreak(scriptablename) || issuperpickup(scriptablename) && !_id_1BE34022A4ACCE73(scriptablename))
    _id_BADA25504E8844D7.count = 1;

  _id_171E5792F47D0B3F = undefined;

  if(_id_5449DA9D3D0358A4(scriptablename))
    _id_171E5792F47D0B3F = 1;

  return onusecompleted(_id_BADA25504E8844D7, undefined, 1, 0, itemslotindex, undefined, _id_44EE85DCF52B4001, _id_171E5792F47D0B3F, _id_5756AA71087F3439);
}

_id_D8CD9C1941A88194(lootid, quantity, weaponref, _id_8598D3D3BC3D9CEB, _id_1A33360665B6BB36, _id_C03C4EF51659BA4C, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_307BCADB5A20BD5E, _id_4A08890FD43D6BC7) {
  scriptablename = weaponref;

  if(!isDefined(weaponref))
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  _id_BADA25504E8844D7 = spawnStruct();
  _id_BADA25504E8844D7.scriptablename = scriptablename;
  _id_BADA25504E8844D7.origin = scripts\engine\utility::ter_op(isDefined(_id_7591ED99E87A77D3), _id_7591ED99E87A77D3, self.origin);
  _id_BADA25504E8844D7.maxcount = level.br_pickups.maxcounts[scriptablename];
  _id_BADA25504E8844D7.stackable = level.br_pickups.stackable[scriptablename];

  if(isweaponpickupitem(_id_BADA25504E8844D7) && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(scriptablename)) {
    [ammo, _id_04F04B15053655BA, _id_35EAD47ED0D7507E] = _id_4480C6CE37B2BDF3::_id_5C9E1BD30347CB36(level.br_lootiteminfo[scriptablename].fullweaponobj, 1);
    _id_BADA25504E8844D7.count = ammo;
    _id_BADA25504E8844D7.countlefthand = _id_04F04B15053655BA;
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_35EAD47ED0D7507E;
    _id_BADA25504E8844D7._id_4A08890FD43D6BC7 = _id_4A08890FD43D6BC7;
  } else {
    _id_BADA25504E8844D7.count = quantity;
    _id_BADA25504E8844D7.countlefthand = 0;
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = 0;
  }

  if(isDefined(_id_8598D3D3BC3D9CEB))
    _id_BADA25504E8844D7._id_8598D3D3BC3D9CEB = _id_8598D3D3BC3D9CEB;

  if(isDefined(_id_C03C4EF51659BA4C))
    _id_BADA25504E8844D7._id_C03C4EF51659BA4C = _id_C03C4EF51659BA4C;

  if(isDefined(_id_96C7526F4AB04875))
    _id_BADA25504E8844D7._id_96C7526F4AB04875 = _id_96C7526F4AB04875;

  return _id_B5F5576A0017C089(_id_BADA25504E8844D7, "visible", self, _id_307BCADB5A20BD5E, undefined, undefined, _id_1A33360665B6BB36);
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("loot")) {
    return;
  }
  _id_54A45680DA242858 = _id_E86632D645C137D0 * _id_E86632D645C137D0;
  circleindex = level.br_circle.circleindex;

  if(circleindex > level.br_circle.damagetick.size - 1)
    circleindex = level.br_circle.damagetick.size - 1;

  damagetick = level.br_circle.damagetick[circleindex];

  if(isDefined(level.circledamagemultiplier))
    damagetick = damagetick * level.circledamagemultiplier;

  level.br_pickups.droppedgasmasks = scripts\engine\utility::array_removeundefined(level.br_pickups.droppedgasmasks);

  for(index = level.br_pickups.droppedgasmasks.size - 1; index >= 0; index--) {
    gasmask = level.br_pickups.droppedgasmasks[index];

    if(istrue(gasmask._id_1B46A808091EA19C)) {
      continue;
    }
    if(distance2dsquared(gasmask.origin, _id_819EDACDACB810E4) > _id_54A45680DA242858) {
      _id_9511FFFEC55BA283 = gasmask.count;

      if(level.br_circle.circleindex <= level._id_AA1AAED4A9B80D4B) {
        damagetick = damagetick * float(level._id_152D5A9C5AC5CDAD);
        _id_EDF34A99C4635317 = int(_id_9511FFFEC55BA283 - damagetick);
      } else
        _id_EDF34A99C4635317 = int(_id_9511FFFEC55BA283 - damagetick);

      if(_id_EDF34A99C4635317 <= 0) {
        gasmask setscriptablepartstate(gasmask.type, "death");
        gasmask deletescriptableinstanceaftertime(1.0);
        level thread deregistergasmaskscriptableatframeend(index);
      } else {
        if(gasmask scripts\cp_mp\gasmask::didgasmaskpipschange(_id_9511FFFEC55BA283, _id_EDF34A99C4635317))
          gasmask setscriptablepartstate(gasmask.type, "damage");

        loot_setitemcount(gasmask, _id_EDF34A99C4635317);
      }
    }
  }
}

_id_1A1709943670772A() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("loot")) {
    return;
  }
  circleindex = level.br_circle.circleindex;

  if(circleindex > level.br_circle.damagetick.size - 1)
    circleindex = level.br_circle.damagetick.size - 1;

  damagetick = level.br_circle.damagetick[circleindex];

  if(isDefined(level.circledamagemultiplier))
    damagetick = damagetick * level.circledamagemultiplier;

  level.br_pickups.droppedgasmasks = scripts\engine\utility::array_removeundefined(level.br_pickups.droppedgasmasks);

  for(index = level.br_pickups.droppedgasmasks.size - 1; index >= 0; index--) {
    gasmask = level.br_pickups.droppedgasmasks[index];

    if(istrue(gasmask._id_1B46A808091EA19C)) {
      continue;
    }
    if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(gasmask.origin)) {
      _id_9511FFFEC55BA283 = gasmask.count;

      if(level.br_circle.circleindex <= level._id_AA1AAED4A9B80D4B) {
        damagetick = damagetick * float(level._id_152D5A9C5AC5CDAD);
        _id_EDF34A99C4635317 = int(_id_9511FFFEC55BA283 - damagetick);
      } else
        _id_EDF34A99C4635317 = int(_id_9511FFFEC55BA283 - damagetick);

      if(_id_EDF34A99C4635317 <= 0) {
        gasmask setscriptablepartstate(gasmask.type, "death");
        gasmask deletescriptableinstanceaftertime(1.0);
        level thread deregistergasmaskscriptableatframeend(index);
      } else {
        if(gasmask scripts\cp_mp\gasmask::didgasmaskpipschange(_id_9511FFFEC55BA283, _id_EDF34A99C4635317))
          gasmask setscriptablepartstate(gasmask.type, "damage");

        loot_setitemcount(gasmask, _id_EDF34A99C4635317);
      }
    }
  }
}

gasmask_onpickupcreated() {
  level.br_pickups.droppedgasmasks[level.br_pickups.droppedgasmasks.size] = self;
}

deregistergasmaskscriptableatframeend(index) {
  waittillframeend;

  if(isDefined(level.br_pickups.droppedgasmasks))
    level.br_pickups.droppedgasmasks[index] = undefined;
}

initscriptablemanagement() {
  _id_962A30A9BB8C0F09 = level.br_pickups;
  _id_962A30A9BB8C0F09.scriptables = [];
  _id_962A30A9BB8C0F09.scriptablesstartid = 0;
  _id_962A30A9BB8C0F09.scriptablescurid = 0;
  _id_962A30A9BB8C0F09.scriptablesmax = getdvarint("dvar_3A100E962F0A003A", 750);
  _id_962A30A9BB8C0F09.scriptablescleanupbatchsize = getdvarint("dvar_1E71982A0A539739", 10);
  scripts\engine\utility::create_func_ref("deregisterScriptable", ::_id_007B67823458CD14);
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

_id_007B67823458CD14() {
  if(_id_0F483AACD19D70A1(self))
    deregisterscriptableinstance(self);
}

clearspaceforscriptableinstance() {
  _id_962A30A9BB8C0F09 = level.br_pickups;

  if(_id_962A30A9BB8C0F09.scriptables.size < _id_962A30A9BB8C0F09.scriptablesmax) {
    return;
  }
  _func_FF5569044925C628();
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
      foreach(_id_31AB61E6884F3BC2 in level.br_pickups._id_7C25F4FB48DB3DD4)
      instance[[_id_31AB61E6884F3BC2]]();

      _id_962A30A9BB8C0F09.scriptables[_id_AC0E594AC96AA3A8] = undefined;

      if(isDefined(instance._id_31AB61E6884F3BC2))
        instance[[instance._id_31AB61E6884F3BC2]]();
      else if(isent(instance))
        instance delete();
      else
        instance freescriptable();

      _id_406118F36AB85942++;
    } else
      _id_962A30A9BB8C0F09.scriptables[_id_AC0E594AC96AA3A8] = undefined;

    _id_962A30A9BB8C0F09.scriptablesstartid++;
  }
}

_id_0F483AACD19D70A1(instance) {
  return isDefined(instance) && isDefined(instance.brpickupscriptableid);
}

deletescriptableinstance(_id_1F99273BFEF8CF44) {
  if(istrue(self._id_BBC200BC77C5DB2B) && !istrue(_id_1F99273BFEF8CF44)) {
    return;
  }
  deregisterscriptableinstance(self);

  if(isent(self))
    self delete();
  else
    self freescriptable();
}

deletescriptableinstanceaftertime(_id_74B5B12BB6514385) {
  thread deletescriptableinstanceaftertime_proc(_id_74B5B12BB6514385);
}

deletescriptableinstanceaftertime_proc(_id_74B5B12BB6514385) {
  self endon("death");
  wait(_id_74B5B12BB6514385);

  if(isDefined(self))
    deletescriptableinstance();
}

registeruniquelootcallback(_id_7D740D4524CE32A9, callback) {
  while(!isDefined(level.br_pickups))
    waitframe();

  level.br_pickups.uniquelootcallbacks["uniqueLootItem_" + _id_7D740D4524CE32A9] = callback;
}

processuniquelootitem(uniquelootitemid, player) {
  if(isDefined([[level.br_pickups.uniquelootcallbacks[uniquelootitemid]]](player)))
    return;
  else {}
}

manageminigunpickup() {
  thread watchaddminigunrestrictions();
  thread watchremoveminigunrestrictions();
  thread watchminigunweapon();
}

applyminigunrestrictions() {
  self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
  scripts\mp\weapons::updatemovespeedscale();
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("fakeJugg", 0);

  if(!istrue(level.disablemount)) {
    _id_3B64EB40368C1450::set("fakeJugg", "mount_top", 0);
    _id_3B64EB40368C1450::set("fakeJugg", "mount_side", 0);
  }
}

removeminigunrestrictions() {
  self.playerstreakspeedscale = undefined;
  scripts\mp\weapons::updatemovespeedscale();
  _id_3B64EB40368C1450::_id_588F2307A3040610("fakeJugg");
}

watchaddminigunrestrictions() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");

  for(;;) {
    self waittill("switched_to_minigun");
    applyminigunrestrictions();
  }
}

watchremoveminigunrestrictions() {
  self endon("death_or_disconnect");
  self endon("juggernaut_start");
  level endon("game_ended");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_no_endon_death_2("switched_from_minigun", "dropped_minigun");

    if(isDefined(result)) {
      removeminigunrestrictions();

      if(result == "dropped_minigun") {
        break;
      }
    }
  }
}

watchminigunweapon() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");
  _id_811A4CB44C776B67 = 0;

  for(;;) {
    if(!_id_2669878CF5A1B6BC::isminigunweapon(self getcurrentweapon())) {
      if(istrue(_id_811A4CB44C776B67)) {
        _id_811A4CB44C776B67 = 0;
        self notify("switched_from_minigun");
      }
    } else if(!istrue(_id_811A4CB44C776B67)) {
      _id_811A4CB44C776B67 = 1;
      self notify("switched_to_minigun");
    }

    waitframe();
  }
}

doesstreakinfomatchequippedstreak(streakinfo) {
  if(!isDefined(streakinfo))
    return 0;

  if(!isDefined(self.streakdata))
    return 0;

  if(!isDefined(self.streakdata.streaks) || !isDefined(self.streakdata.streaks[1]))
    return 0;

  streakdata = self.streakdata.streaks[1];

  if(!isDefined(streakinfo.streakname) || !isDefined(streakdata.streakname) || streakinfo.streakname != streakdata.streakname)
    return 0;

  if(!isDefined(streakinfo.id) || !isDefined(streakdata.uniqueid) || streakinfo.id != streakdata.uniqueid)
    return 0;

  return 1;
}

_id_E44C2D69DB881894(_id_A1093166DE09E6B8) {
  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount) || maxcount == 0)
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount))
    scripts\mp\utility\script::demoforcesre("[IW9-672783]: maxCount undefined with lootName: " + _id_A1093166DE09E6B8);

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A1093166DE09E6B8);

  if(maxcount > 0 && isDefined(lootid)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
      _id_EEEAE9DEFA0C1E95 = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

      if(_id_EEEAE9DEFA0C1E95 == lootid) {
        _id_E30B916ADC1E2DC8 = _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

        if(_id_E30B916ADC1E2DC8 < maxcount)
          return 1;
      }
    }
  }

  if(_id_2CEDCC356F1B9FC8::isammo(_id_A1093166DE09E6B8)) {
    if(!getdvarint("dvar_752EEED3DDCBD04B", 0)) {
      _id_509D86412C9D7426 = self getweaponslistprimaries();

      foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
        _id_7CAC4FF8E11F1BCA = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

        if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_A1093166DE09E6B8 == _id_7CAC4FF8E11F1BCA) {
          if(getdvarint("dvar_B5DB5FF4B3F9E052", 0))
            return 1;

          _id_8EE7478BB4789B1A = self.br_ammo[_id_A1093166DE09E6B8] < level._id_E6EA72FC5E3FCD00[_id_A1093166DE09E6B8];

          if(getdvarint("dvar_D116B9023292A13E", 1))
            return !_id_2D9D24F7C63AC143::_id_49A39674C4A064E3(_id_A1093166DE09E6B8) || _id_8EE7478BB4789B1A;

          return _id_8EE7478BB4789B1A;
        }
      }

      if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
        _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_9AC5E72784815708);

        if(isDefined(ammotype) && ammotype == _id_A1093166DE09E6B8) {
          if(getdvarint("dvar_B5DB5FF4B3F9E052", 0))
            return 1;

          _id_8EE7478BB4789B1A = self.br_ammo[_id_A1093166DE09E6B8] < level._id_E6EA72FC5E3FCD00[_id_A1093166DE09E6B8];

          if(getdvarint("dvar_D116B9023292A13E", 1))
            return !_id_2D9D24F7C63AC143::_id_49A39674C4A064E3(_id_A1093166DE09E6B8) || _id_8EE7478BB4789B1A;

          return _id_8EE7478BB4789B1A;
        }
      }

      return 0;
    } else
      return 1;
  }

  if(isplunder(_id_A1093166DE09E6B8))
    return 1;

  if(isweaponpickup(_id_A1093166DE09E6B8) && self _meth_B096B58FB3808D26())
    return 1;

  if(_id_2CEDCC356F1B9FC8::isarmorplate(_id_A1093166DE09E6B8)) {
    equipname = level.br_pickups.br_equipname[_id_A1093166DE09E6B8];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(self.equipment[slot]))
      return 1;

    if(equipmentslothasroom(_id_A1093166DE09E6B8, slot))
      return 1;

    if(getdvarint("dvar_26FDFBD6BCBE5F42", 1) && _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2()) {
      if(level._id_66A7A8B388D5DE9E != -1) {
        if(_id_E52B0B5AB01DFA0C(_id_A1093166DE09E6B8, level._id_66A7A8B388D5DE9E))
          return 1;
      } else
        return 1;
    }

    return 0;
  }

  if((_id_D7C5786A0C42EF6C(_id_A1093166DE09E6B8) || _id_B989EDD9AF4F42C7(_id_A1093166DE09E6B8)) && !getdvarint("dvar_752EEED3DDCBD04B", 0)) {
    equipname = level.br_pickups.br_equipname[_id_A1093166DE09E6B8];

    if(!isDefined(equipname) || !isDefined(level.equipment.table[equipname]))
      return 0;

    slot = level.equipment.table[equipname].defaultslot;
    return pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(_id_A1093166DE09E6B8, slot);
  }

  if(_id_D0BACEE01BFF927C(_id_A1093166DE09E6B8))
    return 1;

  if(getdvarint("dvar_752EEED3DDCBD04B", 0)) {
    _id_0BB9E46E1D8130F2 = 0;

    if(_id_B989EDD9AF4F42C7(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_6B75060E643E52E9() == 1;
    else if(_id_D7C5786A0C42EF6C(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_C0A39ABE7EC43AD8() == 1;
    else if(iskillstreak(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_3AA858D217FB4A1A() == 1;
    else if(issuperpickup(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_FA1DA77265660058() == 1;
    else if(isrevivepickup(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_3FEB119F85F6CD82() == 1;
    else if(isgasmask(_id_A1093166DE09E6B8))
      _id_0BB9E46E1D8130F2 = self _meth_50B964D023C440E8() == 1;

    return _id_0BB9E46E1D8130F2;
  }

  return 0;
}

_id_4EBFDBFA1B8E0339(_id_A1093166DE09E6B8) {
  return _id_A1093166DE09E6B8 == "brloot_dead_agent_radio";
}

_id_B1E944A2B3E15E9D(_id_A1093166DE09E6B8) {
  return isDefined(_id_A1093166DE09E6B8) && !issubstr(_id_A1093166DE09E6B8, "brloot_backpack_player") && _id_A1093166DE09E6B8 != "brloot_backpack" && issubstr(_id_A1093166DE09E6B8, "brloot_backpack");
}

_id_36DE08EA672B354C(_id_A1093166DE09E6B8) {
  return issubstr(_id_A1093166DE09E6B8, "brloot_perkpack");
}

_id_9E686AB118AC7725(_id_A1093166DE09E6B8) {
  return issubstr(_id_A1093166DE09E6B8, "jup_exgm_force_recon_");
}

_id_B676E90CFF5CB04D(_id_A1093166DE09E6B8) {
  return issubstr(_id_A1093166DE09E6B8, "brloot_underground_keycard_");
}

_id_6FF4FEE4F07A3392() {
  self endon("disconnect");
  logstring("br_watch_mobile_cheat_pickups finished setup.");

  for(;;) {
    self waittill("luinotifyserver", message, _id_2150015540242E9E);

    if(message == "mobile_debug_give_killstreak") {
      _id_A4E8372932B8612C = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          _id_A4E8372932B8612C = "toma_strike";
          break;
        case 1:
          _id_A4E8372932B8612C = "precision_airstrike";
          break;
        case 2:
          _id_A4E8372932B8612C = "uav";
          break;
        case 3:
          _id_A4E8372932B8612C = "manual_turret";
          break;
        case 4:
          _id_A4E8372932B8612C = "scrambler_drone_guard";
          break;
        case 5:
          _id_A4E8372932B8612C = "directional_uav";
          break;
        case 6:
          _id_A4E8372932B8612C = "assault_drone";
          break;
        case 7:
          _id_A4E8372932B8612C = "airdrop";
          break;
        case 8:
          _id_A4E8372932B8612C = "fuel_airstrike";
          break;
        case 9:
          _id_A4E8372932B8612C = "hover_jet";
          break;
        case 10:
          _id_A4E8372932B8612C = "airdrop_escort";
          break;
        case 11:
          _id_A4E8372932B8612C = "auto_drone";
          break;
        case 12:
          _id_A4E8372932B8612C = "chopper_gunner";
          break;
        case 13:
          _id_A4E8372932B8612C = "airdrop_multiple";
          break;
        case 14:
          _id_A4E8372932B8612C = "gunship";
          break;
        case 15:
          _id_A4E8372932B8612C = "juggernaut";
          break;
        case 16:
          _id_A4E8372932B8612C = "cruise_predator";
          break;
        case 17:
          _id_A4E8372932B8612C = "sentry_gun";
          break;
        case 18:
          _id_A4E8372932B8612C = "pac_sentry";
          break;
        case 19:
          _id_A4E8372932B8612C = "counter_uav";
          break;
      }

      if(isDefined(_id_A4E8372932B8612C))
        forcegivekillstreak(_id_A4E8372932B8612C, 1, 0);

      continue;
    }

    if(message == "mobile_debug_give_fieldupgrade") {
      _id_D782E69CA6374BA6 = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          _id_D782E69CA6374BA6 = "super_tac_cover";
          break;
        case 1:
          _id_D782E69CA6374BA6 = "super_trophy";
          break;
        case 2:
          _id_D782E69CA6374BA6 = "super_deadsilence";
          break;
        case 3:
          _id_D782E69CA6374BA6 = "super_support_box";
          break;
        case 4:
          _id_D782E69CA6374BA6 = "super_ammo_drop";
          break;
        case 5:
          _id_D782E69CA6374BA6 = "super_armor_drop";
          break;
        case 6:
          _id_D782E69CA6374BA6 = "super_battlerage";
          break;
        case 7:
          _id_D782E69CA6374BA6 = "super_tac_camera";
          break;
        case 8:
          _id_D782E69CA6374BA6 = "super_deployed_decoy";
          break;
        case 9:
          _id_D782E69CA6374BA6 = "super_loadout_drop";
          break;
        case 10:
          _id_D782E69CA6374BA6 = "super_tac_insert";
          break;
        case 11:
          _id_D782E69CA6374BA6 = "super_sonar_pulse";
          break;
        case 12:
          _id_D782E69CA6374BA6 = "super_sound_veil";
          break;
        case 13:
          _id_D782E69CA6374BA6 = "super_recon_drone";
          break;
        case 14:
          _id_D782E69CA6374BA6 = "super_emp_pulse";
          break;
      }

      if(isDefined(_id_D782E69CA6374BA6))
        forcegivesuper(_id_D782E69CA6374BA6, 1, 0);

      continue;
    }

    if(message == "mobile_debug_give_equipment") {
      equipmentref = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          equipmentref = "brloot_offhand_frag";
          break;
        case 1:
          equipmentref = "brloot_offhand_atmine";
          break;
        case 2:
          equipmentref = "brloot_offhand_claymore";
          break;
        case 3:
          equipmentref = "brloot_offhand_molotov";
          break;
        case 4:
          equipmentref = "brloot_offhand_semtex";
          break;
        case 5:
          equipmentref = "brloot_offhand_thermite";
          break;
        case 6:
          equipmentref = "brloot_offhand_throwingknife";
          break;
        case 7:
          equipmentref = "brloot_offhand_throwingknife_fire";
          break;
        case 10:
          equipmentref = "brloot_health_adrenaline";
          break;
        case 11:
          equipmentref = "brloot_offhand_concussion";
          break;
        case 12:
          equipmentref = "brloot_offhand_decoy";
          break;
        case 13:
          equipmentref = "brloot_offhand_flash";
          break;
        case 14:
          equipmentref = "brloot_offhand_gas";
          break;
        case 15:
          equipmentref = "brloot_offhand_heartbeatsensor";
          break;
        case 16:
          equipmentref = "brloot_offhand_smoke";
          break;
        case 17:
          equipmentref = "brloot_offhand_snapshot";
          break;
        case 20:
          equipmentref = "brloot_armor_plate";
          break;
        case 21:
          equipmentref = "brloot_offhand_binoculars";
          break;
        case 22:
          equipmentref = "brloot_offhand_bunkerbuster";
          break;
        case 23:
          equipmentref = "brloot_offhand_shockstick";
          break;
        case 24:
          equipmentref = "brloot_offhand_c4";
          break;
      }

      if(isDefined(equipmentref))
        br_forcegivecustompickupitem(self, equipmentref, 1);

      continue;
    }

    if(message == "mobile_debug_give_br_items") {
      _id_CB325DDB4A764623 = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          _id_CB325DDB4A764623 = "brloot_equip_gasmask";
          break;
        case 1:
          _id_CB325DDB4A764623 = "brloot_equip_gasmask_durable";
          break;
        case 2:
          _id_CB325DDB4A764623 = "brloot_self_revive";
          break;
      }

      if(isDefined(_id_CB325DDB4A764623))
        br_forcegivecustompickupitem(self, _id_CB325DDB4A764623, 1);
    }
  }
}

_id_C8A5593CBB13F17C(pickup, weaponobj) {
  if(scripts\mp\utility\player::isplayerads() || getdvarint("dvar_9FC90311EF111AFD", 0) && scripts\mp\utility\player::isincombat())
    return 0;

  _id_FE4CD9DC9393409D = getdvarint("dvar_EF63562E5F3B14D0", 0);
  currenttime = gettime();
  _id_C8A5593CBB13F17C = !isDefined(self._id_E7F6950DDC75EF66) || currenttime - self._id_E7F6950DDC75EF66 > _id_FE4CD9DC9393409D;

  if(_id_C8A5593CBB13F17C && self _meth_113C9C35CAF6F029())
    _id_C8A5593CBB13F17C = _id_2B4B373533156A88(pickup, weaponobj);

  if(_id_C8A5593CBB13F17C && self _meth_2EBB84EC61FCFAAF())
    _id_C8A5593CBB13F17C = !_id_AAFFA8AFA2D9C195(weaponobj);

  if(_id_C8A5593CBB13F17C) {
    if(self _meth_C3A5505BC8F25A14()) {
      _id_F0E2A7D2C9E08D75 = self.primaryweapons.size;
      _id_D05470192F5F4895 = 2 > _id_F0E2A7D2C9E08D75;

      for(_id_AC0E594AC96AA3A8 = 0; !_id_D05470192F5F4895 && _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
        if(isnullweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]) || scripts\mp\weapons::isfistweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]) || !_id_AF4AEFC234671C2F(_id_AC0E594AC96AA3A8) && _id_AAFFA8AFA2D9C195(self.primaryweapons[_id_AC0E594AC96AA3A8])) {
          _id_F0E2A7D2C9E08D75--;
          _id_D05470192F5F4895 = 2 > _id_F0E2A7D2C9E08D75;
        }
      }

      _id_C8A5593CBB13F17C = _id_D05470192F5F4895;
    } else if(self _meth_362521BCB3A1BA25()) {
      if(!isDefined(level._id_81369E82645391F0))
        _id_F8B204E807CC62ED();

      _id_A6FB744F02D4FFB8 = level._id_81369E82645391F0[weaponclass(weaponobj.basename)];
      _id_439466F5277EF2D9 = self _meth_337E400EAD27B7BD(_id_A6FB744F02D4FFB8);
      _id_C8A5593CBB13F17C = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
        primaryweaponobj = self.primaryweapons[_id_AC0E594AC96AA3A8];

        if(!isnullweapon(primaryweaponobj)) {
          if(scripts\mp\weapons::isfistweapon(primaryweaponobj)) {
            _id_C8A5593CBB13F17C = 1;
            continue;
          }

          _id_83106F206AE5A450 = level._id_81369E82645391F0[weaponclass(primaryweaponobj.basename)];

          if(_id_A6FB744F02D4FFB8 == _id_83106F206AE5A450) {
            _id_C8A5593CBB13F17C = 0;
            break;
          }

          if(_id_AF4AEFC234671C2F(_id_AC0E594AC96AA3A8)) {
            continue;
          }
          _id_095F9039D76BF3AF = self _meth_337E400EAD27B7BD(_id_83106F206AE5A450);

          if(_id_095F9039D76BF3AF < _id_439466F5277EF2D9)
            _id_C8A5593CBB13F17C = 1;
        }
      }
    }
  }

  if(self _meth_5329138A845B7AA6()) {
    _id_92FCE7B1696254E3 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
    _id_862E2D88178BC2C8 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; !_id_862E2D88178BC2C8 && _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
      _id_E9094C47C8DBE268 = _id_2669878CF5A1B6BC::getweaponrootname(self.primaryweapons[_id_AC0E594AC96AA3A8]);

      if(_id_E9094C47C8DBE268 == _id_92FCE7B1696254E3) {
        _id_B68C8DFAC38718AB = _id_96B5A34CD1572D60(self.primaryweapons[_id_AC0E594AC96AA3A8]);
        _id_167E430A395B12BA = level.br_pickups.br_itemrarity[pickup.scriptablename];
        _id_862E2D88178BC2C8 = _id_B68C8DFAC38718AB < _id_167E430A395B12BA;
      }
    }

    _id_C8A5593CBB13F17C = _id_862E2D88178BC2C8;
  }

  return _id_C8A5593CBB13F17C;
}

_id_2B4B373533156A88(pickup, weapon) {
  ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon);

  if(isDefined(ammotype)) {
    _id_0F68FC94BC895254 = _id_724736FCF0FB6604::_id_088D62A65FF69EAC(self, ammotype);
    return _id_0F68FC94BC895254 > 0 || pickup.count > 0 || pickup.countlefthand > 0;
  }

  return 1;
}

_id_AAFFA8AFA2D9C195(weapon) {
  _id_AAFFA8AFA2D9C195 = 0;

  if(isDefined(level.br_standard_loadout)) {
    if(!isDefined(level._id_EA84A0518343879C))
      _id_E6CABC9F20DCBC23();

    foreach(_id_5C6FA156C22E63E3 in level._id_EA84A0518343879C) {
      _id_AAFFA8AFA2D9C195 = issameweapon(weapon, _id_5C6FA156C22E63E3);

      if(_id_AAFFA8AFA2D9C195) {
        break;
      }
    }
  }

  if(!_id_AAFFA8AFA2D9C195 && isDefined(self.gulag)) {
    if(!isDefined(level._id_F67907AFE56C4F82))
      _id_23A8498A6613DE14();

    _id_AAFFA8AFA2D9C195 = _id_2166628459C78E7A(weapon);
  }

  return _id_AAFFA8AFA2D9C195;
}

_id_96B5A34CD1572D60(weaponobj) {
  _id_1306AD638CEDC772 = 0;
  _id_878AB837C6FE40DF = getcompleteweaponname(weaponobj);

  if(isDefined(level.br_pickups.br_weapontoscriptable[_id_878AB837C6FE40DF])) {
    _id_C9C301A888170672 = level.br_pickups.br_weapontoscriptable[_id_878AB837C6FE40DF];
    _id_1306AD638CEDC772 = level.br_pickups.br_itemrarity[_id_C9C301A888170672];
  } else if(_id_724736FCF0FB6604::isvalidcustomweapon(weaponobj))
    _id_1306AD638CEDC772 = 10;

  return _id_1306AD638CEDC772;
}

_id_ABD2865600352FCD() {
  self._id_C365BEFD3D253AEF = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++)
    self._id_C365BEFD3D253AEF[_id_AC0E594AC96AA3A8] = 0;
}

_id_AF4AEFC234671C2F(_id_E1D097C517C3AF5B) {
  _id_B295A598178D62A3 = 0;

  if(getdvarint("dvar_218B826F84233424", 0)) {
    if(!isDefined(self._id_C365BEFD3D253AEF))
      _id_ABD2865600352FCD();

    _id_B295A598178D62A3 = _id_E1D097C517C3AF5B < 2 && self._id_C365BEFD3D253AEF[_id_E1D097C517C3AF5B];
  }

  return _id_B295A598178D62A3;
}

_id_5EF33BFFAEDA4FA9(weaponobj, blocked) {
  if(!isDefined(self._id_C365BEFD3D253AEF))
    _id_ABD2865600352FCD();

  _id_BFBB389447A5262C = min(2, self.primaryweapons.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BFBB389447A5262C; _id_AC0E594AC96AA3A8++) {
    if(issameweapon(self.primaryweapons[_id_AC0E594AC96AA3A8], weaponobj)) {
      self._id_C365BEFD3D253AEF[_id_AC0E594AC96AA3A8] = blocked;
      break;
    }
  }
}

_id_E98A5A4E0E001AC3(player, scriptablename, _id_F9BEEB3ED076A7A1) {
  _id_0E9CFD120B0B43EF = _id_2CEDCC356F1B9FC8::_id_692C3DF266580DF6(scriptablename);

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzPlateCarrierLevel", _id_0E9CFD120B0B43EF);

  if(istrue(level._id_7F3AAFCF56C9CE14)) {
    _id_6523C0535FDB1F1F(player, scriptablename);
    _id_F24FBD36A9751174 = player _id_F792EC0C5B3B6D45(scriptablename);

    if(isDefined(_id_F24FBD36A9751174) && _id_F24FBD36A9751174 > 0) {
      dropstruct = _id_7B9F3966A7A42003();
      player dropbrequipment(dropstruct, 0, 1, "equip_armorplate", _id_F24FBD36A9751174);
    }

    player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(0);
  }

  if(isDefined(scriptablename))
    _id_0B7A9CE0A2282B79::_id_0BD01C77AB46F790(player, _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename));

  player._id_04045F099F3DA4BD = scriptablename;

  if(!istrue(_id_F9BEEB3ED076A7A1)) {
    player._id_BED158A6DFAC230D = _id_0E9CFD120B0B43EF;
    player._id_8790C077C95DB752 = player._id_BED158A6DFAC230D * 50;
    player notify("try_armor_cancel", "plate_carrier");

    if(!getdvarint("dvar_43B4BF9A8BA6C500", 1))
      _id_07C40FA80892A721::_id_AC7803D45979135C(player._id_8790C077C95DB752);
    else {
      _id_07C40FA80892A721::_id_AC7803D45979135C(player.armorhealth);
      _id_364D691B501CD27F = player _id_07C40FA80892A721::_id_0600F6CF462E983F();

      if(getdvarint("dvar_E1EF460EF24E76E6", 0) && _id_364D691B501CD27F < player._id_BED158A6DFAC230D && !istrue(player._id_C7FD13C53DBDC4F6))
        player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(player._id_BED158A6DFAC230D - _id_364D691B501CD27F);
    }
  }

  return _id_0E9CFD120B0B43EF;
}

_id_6523C0535FDB1F1F(player, scriptablename) {
  _id_A60AD4EC2AE61226 = _id_77702C2321292AA3(scriptablename);
  _id_F94B4BEACF6B6B59 = _id_77702C2321292AA3(player._id_04045F099F3DA4BD);

  if(isDefined(_id_F94B4BEACF6B6B59) && scripts\mp\utility\perk::_hasperk(_id_F94B4BEACF6B6B59))
    player scripts\mp\utility\perk::removeperk(_id_F94B4BEACF6B6B59);

  if(isDefined(_id_A60AD4EC2AE61226))
    player scripts\mp\utility\perk::giveperk(_id_A60AD4EC2AE61226);
}

_id_77702C2321292AA3(scriptablename) {
  if(!isDefined(scriptablename))
    return undefined;

  perkname = undefined;

  if(issubstr(scriptablename, "comms"))
    perkname = "specialty_pc_comms";
  else if(issubstr(scriptablename, "medic"))
    perkname = "specialty_pc_medic";
  else if(issubstr(scriptablename, "stealth"))
    perkname = "specialty_pc_stealth";
  else if(issubstr(scriptablename, "tempered"))
    perkname = "specialty_pc_tempered";
  else if(issubstr(scriptablename, "high_capacity"))
    perkname = "specialty_pc_high_capacity";

  return perkname;
}

_id_A0877DFCB342653A(player) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzPlateCarrierLevel", 1);
}

_id_F792EC0C5B3B6D45(scriptablename) {
  _id_364D691B501CD27F = 0;

  foreach(weapon in self.equippedweapons) {
    basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

    if(basename == "armorplate")
      _id_364D691B501CD27F = self getweaponammoclip(weapon);
  }

  _id_A81ADEB0E1F89320 = 3;

  if(isDefined(scriptablename)) {
    if(scriptablename == "brloot_plate_carrier_high_capacity")
      _id_A81ADEB0E1F89320 = 8;
  }

  _id_F24FBD36A9751174 = undefined;

  if(_id_364D691B501CD27F > _id_A81ADEB0E1F89320)
    _id_F24FBD36A9751174 = _id_364D691B501CD27F - _id_A81ADEB0E1F89320;

  return _id_F24FBD36A9751174;
}

_id_F77406A45E988898(equipname) {
  if(!isDefined(equipname))
    return "br_ammo";

  switch (equipname) {
    case "equip_c4":
      return "c4";
    case "equip_claymore":
      return "claymore";
    case "equip_decoy":
      return "decoy";
    case "equip_flash":
      return "flash";
    case "equip_frag":
      return "frag";
    case "equip_geigercounter":
      return "geiger";
    case "equip_hb_sensor":
      return "hb_sensor";
    case "equip_iodine_pills":
      return "iodine_pills";
    case "equip_molotov":
      return "molotov";
    case "equip_shockstick":
      return "shockstick";
    case "equip_smoke":
      return "smoke";
    case "equip_adrenaline":
      return "stim";
    case "equip_concussion":
      return "stun";
    case "equip_thermite":
      return "thermite";
    case "equip_bunkerbuster":
      return "bunker_buster";
    case "equip_snapshot_grenade":
      return "snapshot";
    case "equip_at_mine":
      return "at_mine";
    case "equip_semtex":
      return "semtex";
    case "equip_binoculars":
      return "binoculars";
    default:
      return "br_ammo";
  }
}

_id_990BE1AA4AD3C9D4() {
  _id_4AE930E26ECEE422 = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
  _id_7FBB956846DF343E = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_7FBB956846DF343E && scripts\mp\utility\game::getsubgametype() == "dmz")
    return 1;

  if(_id_7FBB956846DF343E && !_id_4AE930E26ECEE422) {
    if(_id_9035374E6D5F69DB())
      return 0;

    return 1;
  }

  if(isDefined(self._id_BED158A6DFAC230D) && (getdvarint("dvar_62882304CC93BA77", 0) == 1 && self._id_BED158A6DFAC230D == 2) || self._id_BED158A6DFAC230D == 3 && getdvarint("dvar_86DC98A10DFE9205", 1) == 1 && !_id_4AE930E26ECEE422)
    return 1;

  return 0;
}

_id_9035374E6D5F69DB() {
  if(!isDefined(self._id_04045F099F3DA4BD))
    return 1;

  if(!isDefined(self._id_BED158A6DFAC230D) || self._id_BED158A6DFAC230D <= 1)
    return 1;

  return self._id_04045F099F3DA4BD == "brloot_plate_carrier_2" || self._id_04045F099F3DA4BD == "brloot_plate_carrier_3";
}

_id_82C2DC3D57D67F52() {
  return getdvarint("dvar_8D79947A6199A378", 0);
}