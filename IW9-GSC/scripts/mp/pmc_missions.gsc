/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\pmc_missions.gsc
***********************************************/

_id_5A9C4BF10785CE1E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onVehicleOutOfFuel", ::_id_0DA557960C6878E1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onUAVTowerUsed", ::_id_21EF4EB1AA52F430);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onVehicleEnter", ::_id_5354B59BEDC18F02);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onPingContractPhone", ::_id_5B7B312AF46D6E96);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onVehicleFullRefuelAndRepair", ::_id_D582DEA90C03CAC0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onGasGrenadeExplode", ::_id_90F5D19AB1C382D2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onEnterMediumBird", ::_id_4BA822FD37B63DCE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onAddItemToDeadDrop", ::_id_BB05028F0BA58E1A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onPlaceTacCamera", ::_id_53F53A9DD52A16FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onContainerLooted", ::_id_28DE1F2851B19254);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onPickupWeapon", ::_id_D9E4D7581BC90FE4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onRequestTeamAssimilate", ::_id_919D8870FF2B6812);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onOpenSupplyDrop", ::_id_04896A33419DA8A6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onPing", ::_id_84247818FC8A16F9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onGasCanRefuel", ::_id_903A764DA8E3DB20);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onUseUploadStation", ::_id_4D56964AE4EA5796);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onPopTire", ::_id_51B995F0FA4575C5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onShatterWindow", ::_id_454A887CA7C6A0A5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onSignalExfil", ::_id_A2974FE01BA0959C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onSpawnExfilHeli", ::_id_31EE7BE73C6305ED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onFlarePlaced", ::_id_5286EF6E8174C925);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onVehicleSiphoned", ::_id_36A84463A20F549C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onBombDefused", ::_id_31C6D5968282B472);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onReconDroneMarkEnt", ::_id_2910BC79A4D8427B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onVehicleDestroyed", ::_id_7854F54F01615A6E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pmc_missions", "onEnemyKilled", ::_id_398906218A0DD7DA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_explosive_charge", "delete", ::_id_FCCEB181033EE1EF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_explosive_charge", "dropped", ::_id_2BA521E376D3E4A5);
  scripts\cp_mp\utility\script_utility::registersharedfunc(19215, "pickedUp", ::_id_942941C058F16B20);
  scripts\cp_mp\utility\script_utility::registersharedfunc(19215, "addedToContainer", ::_id_E71CA8A81F647309);
  scripts\cp_mp\utility\script_utility::registersharedfunc(19215, "addedToDeadDrop", ::_id_FE936CA269BD714D);
  scripts\cp_mp\utility\script_utility::registersharedfunc(19215, "extracted", ::_id_D3AC71D99075CECD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_radioactive_charge", "delete", ::_id_8BD9CFD763BCD0E4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_radioactive_charge", "dropped", ::_id_65932D306CCE787E);
  scripts\cp_mp\utility\script_utility::registersharedfunc(21646, "pickedUp", ::_id_003E5CE38E7E8F69);
  scripts\cp_mp\utility\script_utility::registersharedfunc(21646, "addedToContainer", ::_id_23F069DC1BFF2EE0);
  scripts\cp_mp\utility\script_utility::registersharedfunc(21646, "addedToDeadDrop", ::_id_F8F2890A42F13746);
  scripts\cp_mp\utility\script_utility::registersharedfunc(21646, "extracted", ::_id_02FDFBB52976BA9E);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::_id_3340318A370A7CB2);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_disconnect", ::ondisconnect);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_laptop", ::_id_959DC4FE95B93CEA);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_intel", ::_id_7CFD9E977F412D78);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_disarm_security", ::_id_4CDD0981528FF098);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_hydro_bomb_site_use", ::_id_FFFD723FF4050D8E);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_hydro_tower_use", ::_id_A2B7F3DAFBFFA8DE);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_usb", ::_id_D7415966D73D5A1E);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_tracker", ::_id_9E928DE0556DD9A1);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_exfil_tracker", ::_id_8DB9F46C5668C0AF);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_caves_server_use", ::_id_822721B8759D5950);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("electrical_box", ::_id_71B0774FB2E6261F);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_place_harddrive", ::_id_23B4BC828CD125EA);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_call_in_plane", ::_id_0969B576411F99AD);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_place_item_use", ::_id_C335CF2377039BA5);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_use_radiation", ::_id_26C3B83E972A14FD);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_download_blackbox", ::_id_E5AA3C571F674BD3);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_transporter_plant", ::_id_80E7BBF0A2202B9B);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_flare_place", ::_id_48A98EBE20DD89F2);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_cut_the_head_mission_laptop", ::_id_C2D1503CC1629DD2);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_pmc_validate_gas", ::_id_E3B5DB8F3422827E);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("pmc_bunker_exit_button_use", ::_id_C55DAE311EA23861);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("pmc_signal_flare_use", ::_id_AC56C0EC10AC3E25);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("missile_silo_noent_use", ::_id_948991A18B048182);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_supply_site_use_pmc", ::_id_EC7E73044204B1CF);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::luinotifylistener);
  _id_2342B8AAD723994E::registeronplayerjoinsquadcallback(::_id_B944A4D927F9C28A);
  _id_2342B8AAD723994E::_id_A99987C7BF114DA4(::_id_B944A4D927F9C28A);
  _id_5A45EB93B9FC8909();
  level._id_87AF7F50C23346E8._id_DA66011459CB5E59 = [];
  _id_D57E0F306B88DD37();
  _id_2537E0B46AE9A7F1();
  _id_44D9A690ED5B6E76();
  _id_A269616A6F117980();
  _id_4E6833308F41021E();
  _id_5C7BC3641F80E9DC();
  _id_3008315FDF9460B8();
  _id_81365960BE26E970();
  _id_C603F3BE1379A541();
  _id_822D31A70ED0BC67();
  _id_825C9CA2BBC7169F();
  _id_3CB0E100C1DC6F26();
  _id_CAABC88D74AE0AE3();
  _id_944498DD24BC5348();
  _id_38DD5F365B6D2135();
  _id_2345DC4FA1F40628();
  _id_4DD8F8CBCBA13E0A();
  _id_871AB85492B81D67();
  _id_F91E78AAD103B663();
  _id_45DCF3DFCC5D1674();
  _id_41C54A1F9C108720();
  _id_265739B4859488D7();
  _id_BB6DE40DD726B4D9();
  _id_359F7F436DE6BA09();
  _id_3C989AD19E62DE6C();
  _id_51BDE44B90A1FC39();
  _id_554EC348CFC62F37();
  _id_8882CA663F07C0CF();
  _id_126C379552E5F3B7();
  _id_0071192F593DA6CF();
  _id_573C2D675DE0604C();
  _id_285B8DCD4EA4DA26();
  _id_B93CA7DB745586F6();
  _id_B4824DFA90CA1AB9();
  level thread _id_5175FA97870923AD();
  level thread _id_9414CE99A799A309();
  level thread _id_0492D7C202B56DC1();
  level thread _id_B46E6500BEF678BC();
  level thread _id_7868D975EF389ABA();
  level thread _id_B61326CF101FB540();
  level thread _id_31B8C224BA19C71D();
  level thread _id_C9FB574BC742A62E();
  level thread _id_B09C81EA055C4C31();
  level thread _id_FE20DC47D6A83B30();
  level thread _id_8305DF6D2C121ACB();
  level thread _id_BDFD9501E21E7259();
  level thread _id_47C562560E28EBC7();
  level thread _id_9C054602C73DF809();
  level thread _id_68307FC74660904C();
  level thread _id_DE99E97CBC765508();
  level thread _id_EC8A620F07DBCB21();
  level thread _id_A7FB9D5548D2455A();
  level thread _id_AB1164302301C233();
  level thread _id_5AD5CD868765ED83();
  level thread _id_3DE41A0F1613060F();
  level thread _id_70280EB87761BCD0();
  level thread _id_924E9E46E918D2EA();
  level thread _id_794D65C4D264DCC0();
  level thread _id_6CE896CA48E4C62A();
  level thread _id_54E624D4AC58B723();
  level thread _id_1665F2FE0AE0D024();
  level thread _id_A07E5E1F98C14D68();
  level thread _id_34969E35391841BA();
  level thread _id_7A1E65B949E0B879();
  level thread _id_48864D898E5100C0();
  level thread _id_C0849326027254F0();
  level thread _id_83BA07B9CB8B0809();
  level thread _id_562889DF3A616506();
  level thread _id_B74AD2C2C1691B18();
  level thread _id_280EDF3F47535AE9("pmc_port_cargo_ship_trigger", "script_noteworthy", "locate_lone_ship");
  level thread _id_FABD5665EEE8CC3A();
  level._id_97EA4DAF8989E0C6 = ::_id_5DDB9007EE69FE54;
}

cleanup() {
  _id_C649B702F1ECF51C("brloot_caves_intel");
  _id_C649B702F1ECF51C("brloot_unhacked_laptop");
  _id_C649B702F1ECF51C("brloot_crane_intel");
  _id_C649B702F1ECF51C("brloot_biolabs_intel_a");
  _id_C649B702F1ECF51C("brloot_biolabs_intel_b");
  _id_C649B702F1ECF51C("brloot_biolabs_intel_c");
  _id_C649B702F1ECF51C("brloot_black_mous_intel");
  _id_C649B702F1ECF51C("brloot_crown_intel");
  _id_C649B702F1ECF51C("brloot_fake_aq_intel");
  _id_C649B702F1ECF51C("brloot_konni_intel");
  _id_C649B702F1ECF51C("brloot_legion_deal_intel");
  _id_C649B702F1ECF51C("brloot_medical_intel");
  _id_C649B702F1ECF51C("brloot_research_intel");
  _id_C649B702F1ECF51C("brloot_saba_shipping_intel");
  _id_C649B702F1ECF51C("brloot_sealion_intel");
  _id_C649B702F1ECF51C("brloot_shadow_company_intel");
  _id_C649B702F1ECF51C("brloot_shadow_deal_intel");
  _id_C649B702F1ECF51C("brloot_system_architecture");
  _id_C649B702F1ECF51C("brloot_drivers_note");
  _id_C649B702F1ECF51C("brloot_konni_deal_note");
  _id_C649B702F1ECF51C("brloot_pmc_instructions");
  _id_C649B702F1ECF51C("brloot_politicians_letter");
  _id_C649B702F1ECF51C("brloot_shadow_letter");
  _id_C649B702F1ECF51C("brloot_rami_pictureofachild");
  _id_C649B702F1ECF51C("brloot_rami_heartlocket");
  _id_C649B702F1ECF51C("brloot_rami_watch");
  _id_C649B702F1ECF51C("brloot_valuable_drug_brick");
  _id_C649B702F1ECF51C("brloot_biolab_usb");
  _id_C649B702F1ECF51C("brloot_shadow_company_usb");
  _id_C649B702F1ECF51C("brloot_ceo_laptop");
  _id_C649B702F1ECF51C("brloot_konni_laptop");
  _id_C649B702F1ECF51C("brloot_black_mous_harddrive");
  _id_C649B702F1ECF51C("brloot_experiment_harddrive");
  _id_C649B702F1ECF51C("brloot_sealion_harddrive");
  _id_C649B702F1ECF51C("brloot_shadow_harddrive");
  _id_C649B702F1ECF51C("brloot_shipping_manifest");
}

_id_C649B702F1ECF51C(partname) {
  scriptables = getentitylessscriptablearray(undefined, undefined, undefined, undefined, partname);

  if(!isDefined(scriptables)) {
    return;
  }
  foreach(scriptable in scriptables)
  _id_7E52B56769FA7774::loothide(scriptable);
}

_id_5A45EB93B9FC8909() {
  level._id_87AF7F50C23346E8 = spawnStruct();
  level._id_87AF7F50C23346E8._id_16308019512AF385 = [];
  level._id_87AF7F50C23346E8._id_01B943B33F98BCE6 = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("pmc_mission_challenges.csv");

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    id = int(tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 0));
    ref = tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 1);
    amount = int(tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 4));
    xp = int(tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 6));
    lootid = int(tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 14));
    _id_F2E7EF56FB1A0B7C = int(tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 15));
    _id_1E6F49EEC1998002 = tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 16);
    _id_DA9FC800AF5A5CE0 = tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 18);
    _id_62CD3D7406BE8C32 = tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 17);
    _id_0B6DA601DCCC1197 = [];

    if(lootid)
      _id_0B6DA601DCCC1197[_id_0B6DA601DCCC1197.size] = lootid;

    if(_id_DA9FC800AF5A5CE0 == "iw9_loot_id" && _id_62CD3D7406BE8C32 != "") {
      _id_A36A3BA99F4FAC6B = strtok(_id_62CD3D7406BE8C32, "|");

      foreach(str in _id_A36A3BA99F4FAC6B) {
        _id_89E8814CE0183C08 = int(str);

        if(_id_89E8814CE0183C08)
          _id_0B6DA601DCCC1197[_id_0B6DA601DCCC1197.size] = _id_89E8814CE0183C08;
      }
    }

    _id_CFAE3AD1C98A75B1 = tablelookupbyrow("pmc_mission_challenges.csv", _id_CB89110314447B2F, 13);
    children = [];

    if(isDefined(_id_CFAE3AD1C98A75B1) && _id_CFAE3AD1C98A75B1 != "") {
      _id_CFAE3AD1C98A75B1 = strtok(_id_CFAE3AD1C98A75B1, "|");

      foreach(str in _id_CFAE3AD1C98A75B1)
      children[children.size] = int(str);
    }

    data = spawnStruct();
    data.ref = ref;
    data.amount = amount;
    data.xp = xp;
    data.children = children;
    data._id_0B6DA601DCCC1197 = _id_0B6DA601DCCC1197;
    data._id_1E6F49EEC1998002 = _id_1E6F49EEC1998002;
    data._id_F2E7EF56FB1A0B7C = _id_F2E7EF56FB1A0B7C;
    level._id_87AF7F50C23346E8._id_16308019512AF385[id] = data;
    level._id_87AF7F50C23346E8._id_01B943B33F98BCE6[ref] = id;
  }

  _id_977F24E61599CBBA = tablelookupgetnumrows("pmc_mission_tiers.csv");
  _id_66CF6C5E7983E0CF = [];
  _id_66CF6C5E7983E0CF["american"] = "a";
  _id_66CF6C5E7983E0CF["white_lotus"] = "b";
  _id_66CF6C5E7983E0CF["black_mous"] = "c";
  _id_66CF6C5E7983E0CF["crown"] = "d";
  _id_66CF6C5E7983E0CF["phalanx"] = "e";
  _id_66CF6C5E7983E0CF["shadow_company"] = "f";

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    tier = int(tablelookupbyrow("pmc_mission_tiers.csv", _id_CB89110314447B2F, 0));
    faction = _id_66CF6C5E7983E0CF[tablelookupbyrow("pmc_mission_tiers.csv", _id_CB89110314447B2F, 3)];
    _id_6AD59E2C98398E8B = int(tablelookupbyrow("pmc_mission_tiers.csv", _id_CB89110314447B2F, 2));
    _id_DF6EDF345D8E8653 = strtok(tablelookupbyrow("pmc_mission_tiers.csv", _id_CB89110314447B2F, 1), "|");

    foreach(str in _id_DF6EDF345D8E8653) {
      id = int(str);

      if(isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[id])) {
        level._id_87AF7F50C23346E8._id_16308019512AF385[id].faction = faction;
        level._id_87AF7F50C23346E8._id_16308019512AF385[id].tier = tier;
        continue;
      }
    }

    if(isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[_id_6AD59E2C98398E8B])) {
      level._id_87AF7F50C23346E8._id_16308019512AF385[_id_6AD59E2C98398E8B].faction = faction;
      level._id_87AF7F50C23346E8._id_16308019512AF385[_id_6AD59E2C98398E8B].tier = tier;
    }
  }

  foreach(id, _id_AA1ED8F12D71A7A5 in level._id_87AF7F50C23346E8._id_16308019512AF385) {
    if(_id_AA1ED8F12D71A7A5.children.size) {
      foreach(child in _id_AA1ED8F12D71A7A5.children) {
        if(isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[child])) {
          level._id_87AF7F50C23346E8._id_16308019512AF385[child].parent = id;
          level._id_87AF7F50C23346E8._id_16308019512AF385[child].faction = _id_AA1ED8F12D71A7A5.faction;
          level._id_87AF7F50C23346E8._id_16308019512AF385[child].tier = _id_AA1ED8F12D71A7A5.tier;
        }
      }
    }
  }
}

_id_16AE6D8B5F25F31B(_id_A5CB6F1F6ABE070B) {
  id = level._id_87AF7F50C23346E8._id_01B943B33F98BCE6["iw9_s4_ch_pmc_" + _id_A5CB6F1F6ABE070B];

  if(!isDefined(id))
    id = level._id_87AF7F50C23346E8._id_01B943B33F98BCE6["iw9_s5_ch_pmc_" + _id_A5CB6F1F6ABE070B];

  if(!isDefined(id)) {
    logprint("Error finding mission id for ref: " + _id_A5CB6F1F6ABE070B);
    id = -1;
  }

  return id;
}

_id_D57E0F306B88DD37() {
  _id_29D9D2428185616D = scripts\engine\utility::getStructArray("pmc_spawn_loot", "script_noteworthy");

  foreach(_id_543AA033CDA8A436 in _id_29D9D2428185616D) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_543AA033CDA8A436.origin, _id_543AA033CDA8A436.angles);
    item = _id_7E52B56769FA7774::spawnpickup(_id_543AA033CDA8A436.targetname, _id_CB4FAD49263E20C4, 1);

    if(isDefined(item)) {
      item._id_BBC200BC77C5DB2B = 1;
      continue;
    }
  }

  weapons = scripts\engine\utility::getStructArray("pmc_spawn_weapon", "script_noteworthy");

  foreach(_id_543AA033CDA8A436 in weapons) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_543AA033CDA8A436.origin, _id_543AA033CDA8A436.angles);
    item = _id_7E52B56769FA7774::spawnpickup(_id_543AA033CDA8A436.targetname, _id_CB4FAD49263E20C4);

    if(isDefined(item)) {
      item._id_BBC200BC77C5DB2B = 1;
      continue;
    }
  }
}

_id_46BFECE294C56645(_id_A5CB6F1F6ABE070B, itemlist, identifier) {
  id = _id_16AE6D8B5F25F31B(_id_A5CB6F1F6ABE070B);

  if(isDefined(itemlist)) {
    foreach(item in itemlist)
    level._id_57726C4D54785F95[item] = id;
  }

  if(isDefined(identifier))
    level._id_57726C4D54785F95[identifier] = id;
}

_id_D5394A20735BC2F1(struct, item, identifier, _id_1FA640F7C162F51E, _id_3474B4E818850C46) {
  origin = scripts\engine\utility::_id_53C4C53197386572(struct.origin, (0, 0, 0));
  angles = scripts\engine\utility::_id_53C4C53197386572(struct.angles, (0, 0, 0));
  placement = spawnscriptable("dmz_place_item", origin, angles);
  placement setscriptablepartstate("dmz_place_item_use", "usable_" + item);
  placement setscriptablepartstate("dmz_place_item_model", "hidden");
  placement.item = item;
  placement.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(placement.item);
  placement._id_D136B9F79E55C11B = item;

  if(isDefined(_id_3474B4E818850C46))
    placement._id_D136B9F79E55C11B = _id_3474B4E818850C46;

  placement.number = 1;
  placement.identifier = identifier;
  placement._id_1FA640F7C162F51E = _id_1FA640F7C162F51E;
  level._id_87AF7F50C23346E8._id_C3E10A42A81ADE25[level._id_87AF7F50C23346E8._id_C3E10A42A81ADE25.size] = placement;
  return placement;
}

_id_5C280A977F39790E(struct) {
  placement = _id_D5394A20735BC2F1(struct, struct.targetname, struct.target, struct.script_parameters, struct.script_label);

  if(isDefined(struct.target)) {
    id = _id_16AE6D8B5F25F31B(struct.target);
    level._id_57726C4D54785F95[struct.target] = id;
  }

  return placement;
}

_id_5FB061AD407E6E6C(script_noteworthy, item, identifier, _id_1FA640F7C162F51E, _id_3474B4E818850C46) {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(script_noteworthy, "script_noteworthy");

  if(isDefined(_id_9E4E1482CB40C9C5)) {
    foreach(struct in _id_9E4E1482CB40C9C5)
    placement = _id_D5394A20735BC2F1(struct, item, identifier, _id_1FA640F7C162F51E, _id_3474B4E818850C46);
  }
}

_id_2537E0B46AE9A7F1() {
  level._id_87AF7F50C23346E8._id_C3E10A42A81ADE25 = [];
  level._id_57726C4D54785F95 = [];
  _id_46BFECE294C56645("place_smuggling_tunnels", ["brloot_valuable_freshwater", "brloot_valuable_mre", "brloot_valuable_bandage"]);
  _id_46BFECE294C56645("plant_research_story", ["brloot_research_intel", "brloot_gascan"]);
  _id_46BFECE294C56645("mall_place", ["brloot_valuable_gunoil", "brloot_offhand_c4", "brloot_valuable_drill"]);
  _id_46BFECE294C56645("deliver_letter", ["brloot_drivers_note"]);
  _id_46BFECE294C56645("track_submarines", undefined, "track_submarine");
  _id_46BFECE294C56645("track_biolabs_cargo", undefined, "track_cargo_truck_biolabs");
  _id_46BFECE294C56645("plant_microphone", undefined, "pmc_discrete_radio");
  _id_46BFECE294C56645("plant_fake_docs", ["brloot_fake_aq_intel"]);
  _id_46BFECE294C56645("extract_plant_intel", ["brloot_biolab_usb"]);
  _id_46BFECE294C56645("redacted_3_excavation", undefined, "track_biobunker_entrance");
  _id_46BFECE294C56645("ir_beacon_story", ["brloot_ir_beacon"]);
  _id_29D9D2428185616D = scripts\engine\utility::getStructArray("pmc_place_loot", "script_noteworthy");

  foreach(spawn in _id_29D9D2428185616D) {
    placement = _id_5C280A977F39790E(spawn);

    if(placement.item == "brloot_tracking_device" && scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2())
      placement.identifier = "track_cargo_truck_biolabs";
  }

  _id_5FB061AD407E6E6C("pmc_submarine_tracker", "brloot_tracking_device", "track_submarine", "plant_submarine_tracker");
  _id_5FB061AD407E6E6C("pmc_discrete_radio", "brloot_discrete_radio", "pmc_discrete_radio");
  _id_5FB061AD407E6E6C("pmc_fake_aq_docs_place", "brloot_fake_aq_intel");
  _id_5FB061AD407E6E6C("pmc_intel_exchange_usb", "brloot_biolab_usb");
  _id_5FB061AD407E6E6C("track_biobunker_entrace", "brloot_tracking_device", "track_biobunker_entrance", "plant_biobunker_entrance", "parts_pouch_comms_cellular_jammer");
}

_id_C335CF2377039BA5(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  _id_587F61AD4C5334A0 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(instance.lootid, 1));

  if(!_id_587F61AD4C5334A0) {
    curr = player scripts\mp\equipment::getcurrentequipment("primary");
    _id_0C89F07DA007FF0D = player scripts\mp\equipment::getequipmentslotammo("primary");

    if(isDefined(curr) && curr != "" && isDefined(_id_0C89F07DA007FF0D) && _id_0C89F07DA007FF0D) {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(curr);

      if(lootid == instance.lootid) {
        player scripts\mp\equipment::takeequipment("primary");
        _id_587F61AD4C5334A0 = 1;
      }
    }
  }

  if(_id_587F61AD4C5334A0) {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
    instance disablescriptableplayeruse(_id_F0EA4030349A33D5);

    state = instance getscriptablepartstate("dmz_place_item_model");

    if(state == "hidden")
      instance setscriptablepartstate("dmz_place_item_model", instance._id_D136B9F79E55C11B);

    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 10);
    scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, instance.lootid, undefined, _id_3EAA9F644DBE7834, 1);
    _id_4E55FC12323FF73E = _id_16AE6D8B5F25F31B("microphone_story");

    if(_id_C5E0BAC8F123CC88(player.team, _id_4E55FC12323FF73E)) {
      if(isDefined(instance.identifier) && instance.identifier == "microphone_story")
        scripts\mp\utility\teams::setteamdata(player.team, "placed_microphone", 1);
    }

    if(isDefined(instance._id_1FA640F7C162F51E)) {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, instance._id_1FA640F7C162F51E, 1);
      return;
    }
  } else
    player scripts\mp\hud_message::showerrormessage("PMC_S2/PLACE_ERR_MSG");
}

_id_FABD5665EEE8CC3A() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  _id_529ED52251CA4317 = [];

  foreach(player in level.players) {
    foreach(placement in level._id_87AF7F50C23346E8._id_C3E10A42A81ADE25)
    placement disablescriptableplayeruse(player);

    if(isDefined(player.team) && scripts\mp\utility\teams::getteamdata(player.team, "players").size == 1) {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "solo_infil_exfil", 1);
      weapons = _id_2D9D24F7C63AC143::_id_57931A717F140EBE(player);

      if(isDefined(weapons)) {
        hasweapon = 0;

        foreach(weapon in weapons) {
          if(!scripts\mp\utility\weapon::isfistsonly(weapon) && !scripts\mp\utility\weapon::isgunlessweapon(weapon)) {
            hasweapon = 1;
            break;
          }
        }

        if(!istrue(hasweapon))
          scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "infil_solo_no_weapons", 1);
      }
    }

    if(_id_0B7A9CE0A2282B79::_id_4B57E9867785E738(player))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "infil_with_custom_weapon", 1);

    if(isDefined(player.team)) {
      foreach(str, id in level._id_57726C4D54785F95) {
        if(isDefined(_id_529ED52251CA4317[player.team]) && istrue(_id_529ED52251CA4317[player.team][id]) || _id_C5E0BAC8F123CC88(player.team, id)) {
          if(!isDefined(_id_529ED52251CA4317[player.team]))
            _id_529ED52251CA4317[player.team] = [];

          if(!isDefined(_id_529ED52251CA4317[player.team][id]))
            _id_529ED52251CA4317[player.team][id] = 1;

          foreach(placement in level._id_87AF7F50C23346E8._id_C3E10A42A81ADE25) {
            if(isDefined(placement.item) && placement.item == str || isDefined(placement.identifier) && placement.identifier == str)
              placement enablescriptableplayeruse(player);
          }
        }
      }
    }

    _id_E634010F11D249EB(player);
  }
}

_id_E634010F11D249EB(player) {
  for(_id_373249E63DD9730B = 0; _id_373249E63DD9730B < 3; _id_373249E63DD9730B++) {
    id = _id_47F721114FED37E7(player, _id_373249E63DD9730B);

    if(id > 0 && isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[id])) {
      ref = level._id_87AF7F50C23346E8._id_16308019512AF385[id].ref;
      vo = undefined;

      switch (ref) {
        case "iw9_s4_ch_pmc_smugglers_run":
          vo = "faction_e_smugglers_run_on_start";
          break;
        case "iw9_s4_ch_pmc_tracking_activity":
          vo = "faction_e_tracking_activity_on_start";
          break;
        case "iw9_s4_ch_pmc_go_for_a_drive":
          vo = "faction_e_go_for_a_drive_on_start";
          break;
        case "iw9_s4_ch_pmc_fearless":
          vo = "faction_e_fearless_on_start";
          break;
        case "iw9_s4_ch_pmc_cut_the_head":
          vo = "faction_e_cut_the_head_on_start";
          break;
        default:
          continue;
      }

      if(isDefined(vo))
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5(vo, [player]);
    }
  }
}

_id_B0CA76F04AD0E0C3(player) {
  if(_id_0B7A9CE0A2282B79::_id_4B57E9867785E738(player))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "exfil_with_custom_weapon", 1);
}

_id_44D9A690ED5B6E76() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["poisVisited"] = [];
    level.teamdata[team]["vehiclesEntered"] = [];
    level.teamdata[team]["gpsPoisVisited"] = [];
    level.teamdata[team]["poisVisitedACV"] = [];
    level.teamdata[team]["placed_microphone"] = 0;
    level.teamdata[team]["uniqueWeaponKill"] = [];
  }
}

_id_CFF2F4F168B29B81() {
  if(!isDefined(level._id_B2729F28A675BE79))
    level._id_B2729F28A675BE79 = getdvarint("pmc_mission_enabled", 0);

  return level._id_B2729F28A675BE79;
}

_id_47F721114FED37E7(player, _id_373249E63DD9730B) {
  return player getplayerdata(level.loadoutsgroup, "squadMembers", "activePMCMissionsS4", _id_373249E63DD9730B, "challengeID");
}

_id_7159CEB842152778(player, _id_373249E63DD9730B, _id_CAE85767829655F7) {
  return player getplayerdata(level.loadoutsgroup, "squadMembers", "activePMCMissionsS4", _id_373249E63DD9730B, "challengeProgress", _id_CAE85767829655F7);
}

_id_31B54D12C6B13A7C(player) {
  _id_9D027939A218EB23 = [];

  for(_id_373249E63DD9730B = 0; _id_373249E63DD9730B < 3; _id_373249E63DD9730B++)
    _id_9D027939A218EB23[_id_9D027939A218EB23.size] = _id_47F721114FED37E7(player, _id_373249E63DD9730B);

  return _id_9D027939A218EB23;
}

_id_C7D3C1CB4A3958CF(player, _id_6540FCBF7CAF4EAF) {
  for(_id_373249E63DD9730B = 0; _id_373249E63DD9730B < 3; _id_373249E63DD9730B++) {
    _id_93058306EC47E322 = _id_47F721114FED37E7(player, _id_373249E63DD9730B);

    if(_id_93058306EC47E322 > 0 && _id_93058306EC47E322 == _id_6540FCBF7CAF4EAF)
      return 1;
  }

  return 0;
}

_id_C5E0BAC8F123CC88(team, _id_6540FCBF7CAF4EAF) {
  if(getdvarint("dvar_AE46D31A716A05E8", 0))
    return 1;

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(_id_C7D3C1CB4A3958CF(player, _id_6540FCBF7CAF4EAF))
      return 1;
  }

  return 0;
}

_id_4E577D33450CAEE4(_id_6540FCBF7CAF4EAF) {
  if(getdvarint("dvar_AE46D31A716A05E8", 0))
    return level.players;

  _id_0694CF27A7080216 = [];

  foreach(player in level.players) {
    if(isDefined(player) && _id_C7D3C1CB4A3958CF(player, _id_6540FCBF7CAF4EAF))
      _id_0694CF27A7080216 = scripts\engine\utility::array_add(_id_0694CF27A7080216, player);
  }

  return _id_0694CF27A7080216;
}

_id_AB5C0B42F31A0D20(missionid) {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_F2092A53E01523F4 = [];

  foreach(player in level.players) {
    if(!isDefined(_id_F2092A53E01523F4[player.team]))
      _id_F2092A53E01523F4[player.team] = _id_C5E0BAC8F123CC88(player.team, missionid);

    if(!_id_F2092A53E01523F4[player.team])
      self disablescriptableplayeruse(player);
  }
}

_id_EF63CDEBAAFF3440() {
  foreach(player in level.players) {
    if(isDefined(player))
      self disablescriptableplayeruse(player);
  }
}

_id_D3428EBFDA80EDEB(icon, offset, team) {
  offset = scripts\engine\utility::_id_53C4C53197386572(offset, (0, 0, 0));
  self.curorigin = self.origin;
  self.offset3d = offset;
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  objidnum = self.objidnum;

  if(isDefined(icon))
    objective_icon(objidnum, icon);

  objective_position(objidnum, self.origin + offset);

  if(isDefined(team))
    scripts\mp\objidpoolmanager::objective_teammask_single(objidnum, team);
  else {
    objective_addalltomask(objidnum);
    objective_hidefromplayersinmask(objidnum);
  }

  _func_9427CB5974C925D9(objidnum, 1);
  scripts\mp\objidpoolmanager::objective_pin_global(objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objidnum, 4);
  _func_A13E72E0427ECAD2(objidnum, _func_58FB674A1DD27075());
  return objidnum;
}

_id_280EDF3F47535AE9(name, key, type, _id_1FBC3549649926B6) {
  trigger = _func_F159C10D5CF8F0B4(name, key);

  if(!isDefined(trigger) || trigger.size == 0) {
    return;
  }
  trigger = trigger[0];
  thread _id_B58F7554FAA406E7(trigger, type, _id_1FBC3549649926B6);
}

_id_89A7111BD154E223(name, key, _id_BB7537F2CCD47382, _id_1FBC3549649926B6) {
  struct = scripts\engine\utility::getStruct(name, key);

  if(!isDefined(struct)) {
    return;
  }
  trigger = spawn("noent_volume_trigger_radius", struct.origin, 0, struct.radius, int(struct.target));
  thread _id_B58F7554FAA406E7(trigger, _id_BB7537F2CCD47382, _id_1FBC3549649926B6);
}

_id_B58F7554FAA406E7(trigger, type, _id_1FBC3549649926B6) {
  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent) || !isDefined(ent.team)) {
      continue;
    }
    if(isDefined(trigger.used) && isDefined(trigger.used[ent.team])) {
      continue;
    }
    if(!isDefined(trigger.used))
      trigger.used = [];

    trigger.used[ent.team] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(ent, type, 1);

    if(isDefined(_id_1FBC3549649926B6))
      [[_id_1FBC3549649926B6]](ent);
  }
}

_id_A0AF645242DC7260(player, lootid, _id_5577636292591C8B) {
  _id_937EF066F0F41BA2 = _id_31B54D12C6B13A7C(player);

  foreach(_id_AA1ED8F12D71A7A5 in _id_937EF066F0F41BA2) {
    if(_id_AA1ED8F12D71A7A5 <= 0 || !isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5])) {
      continue;
    }
    _id_F2E7EF56FB1A0B7C = level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5]._id_F2E7EF56FB1A0B7C;

    if(_id_F2E7EF56FB1A0B7C && isDefined(_id_5577636292591C8B) && _id_F2E7EF56FB1A0B7C == _id_5577636292591C8B)
      return _id_AA1ED8F12D71A7A5;

    foreach(id in level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5]._id_0B6DA601DCCC1197) {
      if(isDefined(id) && id != 0) {
        if(id == lootid)
          return _id_AA1ED8F12D71A7A5;
      }
    }

    foreach(child in level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5].children) {
      _id_F2E7EF56FB1A0B7C = level._id_87AF7F50C23346E8._id_16308019512AF385[child]._id_F2E7EF56FB1A0B7C;

      if(_id_F2E7EF56FB1A0B7C && isDefined(_id_5577636292591C8B) && _id_F2E7EF56FB1A0B7C == _id_5577636292591C8B)
        return child;

      foreach(id in level._id_87AF7F50C23346E8._id_16308019512AF385[child]._id_0B6DA601DCCC1197) {
        if(isDefined(id) && id != 0) {
          if(id == lootid)
            return child;
        }
      }
    }
  }

  return 0;
}

_id_6C11B28B956BF6AD(_id_E249F003655293F8) {
  if(!isDefined(_id_E249F003655293F8))
    _id_E249F003655293F8 = 1;

  if(_id_E249F003655293F8 & 1)
    return scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702();
  else if(_id_E249F003655293F8 & 2)
    return scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414();
  else if(_id_E249F003655293F8 & 4)
    return scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2();
  else if(_id_E249F003655293F8 & 8)
    return scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1();

  return 1;
}

_id_315E9C3A5FB405E5(missionid, _id_F05299E50A2F2CC7, lootid, quantity, _id_E249F003655293F8) {
  if(!_id_6C11B28B956BF6AD(_id_E249F003655293F8)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  scripts\engine\utility::flag_wait("dead_drops_init");

  if(!isDefined(level._id_CED78996BBF1B2D3)) {
    return;
  }
  _id_0694CF27A7080216 = [];
  _id_F2092A53E01523F4 = [];

  foreach(player in level.players) {
    if(!isDefined(_id_F2092A53E01523F4[player.team]))
      _id_F2092A53E01523F4[player.team] = _id_C5E0BAC8F123CC88(player.team, missionid);

    if(_id_F2092A53E01523F4[player.team])
      _id_0694CF27A7080216[_id_0694CF27A7080216.size] = player;
  }

  _id_69E96A4CAA72D794 = sortbydistance(level._id_CED78996BBF1B2D3, _id_F05299E50A2F2CC7)[0];
  _id_048614492EF09B23::_id_6207D6F728CEE51D(_id_0694CF27A7080216, _id_69E96A4CAA72D794, lootid, quantity, undefined, 1);
  level thread _id_955E6C9750EE6B5E(_id_0694CF27A7080216, _id_69E96A4CAA72D794);
}

_id_3079D4D1C0EE380E(missionid, _id_F05299E50A2F2CC7, weaponobj, _id_E249F003655293F8) {
  if(!_id_6C11B28B956BF6AD(_id_E249F003655293F8)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  scripts\engine\utility::flag_wait("dead_drops_init");

  if(!isDefined(level._id_CED78996BBF1B2D3)) {
    return;
  }
  _id_0694CF27A7080216 = [];
  _id_F2092A53E01523F4 = [];

  foreach(player in level.players) {
    if(!isDefined(_id_F2092A53E01523F4[player.team]))
      _id_F2092A53E01523F4[player.team] = _id_C5E0BAC8F123CC88(player.team, missionid);

    if(_id_F2092A53E01523F4[player.team])
      _id_0694CF27A7080216[_id_0694CF27A7080216.size] = player;
  }

  _id_69E96A4CAA72D794 = sortbydistance(level._id_CED78996BBF1B2D3, _id_F05299E50A2F2CC7)[0];
  lootid = _id_2669878CF5A1B6BC::_id_9C331F88BE5A1478(weaponobj);
  ammo = weaponclipsize(weaponobj);
  _id_048614492EF09B23::_id_6207D6F728CEE51D(_id_0694CF27A7080216, _id_69E96A4CAA72D794, lootid, ammo, weaponobj, 1);
  level thread _id_955E6C9750EE6B5E(_id_0694CF27A7080216, _id_69E96A4CAA72D794);
}

_id_955E6C9750EE6B5E(_id_0694CF27A7080216, _id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(_id_0694CF27A7080216)) {
    return;
  }
  _id_69E96A4CAA72D794 notify("dead_drop_nag");
  _id_69E96A4CAA72D794 endon("dead_drop_nag");
  _id_69E96A4CAA72D794 endon("death");
  level endon("game_ended");

  for(;;) {
    _id_EE49733D297CD9F1 = [];

    foreach(player in _id_0694CF27A7080216) {
      if(isDefined(player) && !isbot(player) && scripts\mp\utility\player::isreallyalive(player) && isDefined(player.team) && !scripts\engine\utility::array_contains(_id_EE49733D297CD9F1, player.team) && distance2d(player.origin, _id_69E96A4CAA72D794.origin) < 2000) {
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("player_item_dead_drop_retrieve", player.team);
        _id_EE49733D297CD9F1[_id_EE49733D297CD9F1.size] = player.team;
      }
    }

    wait 5.0;
  }
}

_id_B944A4D927F9C28A(player) {
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_14CEE82314AC28CD = [];
  _id_A0F0FC2F7FF8F287 = [];
  _id_F5382FE07E7DD793 = [];

  foreach(_id_736D8D9188CCBD45 in players) {
    for(_id_373249E63DD9730B = 0; _id_373249E63DD9730B < 3; _id_373249E63DD9730B++) {
      _id_804E08EA07743095 = _id_736D8D9188CCBD45._id_3F78C6A0862F9E25;

      if(!isDefined(_id_14CEE82314AC28CD[_id_804E08EA07743095])) {
        _id_14CEE82314AC28CD[_id_804E08EA07743095] = [];
        _id_A0F0FC2F7FF8F287[_id_804E08EA07743095] = [];
      }

      _id_F5382FE07E7DD793[_id_804E08EA07743095] = _id_736D8D9188CCBD45 getentitynumber();
      _id_A61C75B156FC1EE0 = _id_14CEE82314AC28CD[_id_804E08EA07743095].size;
      id = _id_47F721114FED37E7(_id_736D8D9188CCBD45, _id_373249E63DD9730B);
      _id_14CEE82314AC28CD[_id_804E08EA07743095][_id_A61C75B156FC1EE0] = id;
      _id_A0F0FC2F7FF8F287[_id_804E08EA07743095][_id_A61C75B156FC1EE0] = [];

      for(_id_CAE85767829655F7 = 0; _id_CAE85767829655F7 < 3; _id_CAE85767829655F7++)
        _id_A0F0FC2F7FF8F287[_id_804E08EA07743095][_id_A61C75B156FC1EE0][_id_CAE85767829655F7] = _id_7159CEB842152778(_id_736D8D9188CCBD45, _id_373249E63DD9730B, _id_CAE85767829655F7);

      if(id > 0) {
        if(isDefined(level._id_87AF7F50C23346E8._id_16308019512AF385[id])) {
          if(level._id_87AF7F50C23346E8._id_16308019512AF385[id].children.size > 0) {
            _id_55194940629E0C11 = 1;

            for(child = 0; child < 3; child++) {
              _id_F75E644ECAA00094 = level._id_87AF7F50C23346E8._id_16308019512AF385[id].children[child];

              if(isDefined(_id_F75E644ECAA00094) && _id_F75E644ECAA00094 > 0) {
                progress = _id_A0F0FC2F7FF8F287[_id_804E08EA07743095][_id_A61C75B156FC1EE0][child];
                amount = level._id_87AF7F50C23346E8._id_16308019512AF385[_id_F75E644ECAA00094].amount;
                _id_46612E4815489BA6 = level._id_87AF7F50C23346E8._id_16308019512AF385[_id_F75E644ECAA00094].ref;

                if(progress != amount)
                  _id_55194940629E0C11 = 0;
                else if(!isarray(_id_736D8D9188CCBD45._id_D0FFE5AA652992E9) || !istrue(_id_736D8D9188CCBD45._id_D0FFE5AA652992E9[_id_46612E4815489BA6]))
                  _id_1A3BD4602E62E661(_id_736D8D9188CCBD45, players, _id_46612E4815489BA6);
              }
            }

            if(istrue(_id_55194940629E0C11))
              _id_B2D5FE14937FA854(_id_736D8D9188CCBD45, id);

            continue;
          }

          progress = _id_A0F0FC2F7FF8F287[_id_804E08EA07743095][_id_A61C75B156FC1EE0][0];
          amount = level._id_87AF7F50C23346E8._id_16308019512AF385[id].amount;

          if(progress == amount)
            _id_B2D5FE14937FA854(_id_736D8D9188CCBD45, id);
        }
      }
    }
  }

  foreach(_id_736D8D9188CCBD45 in players) {
    for(_id_804E08EA07743095 = 0; _id_804E08EA07743095 < 6; _id_804E08EA07743095++) {
      _id_37CE0ED43BBBDA16 = 0;

      if(isDefined(_id_F5382FE07E7DD793[_id_804E08EA07743095]))
        _id_736D8D9188CCBD45 setplayerdata(level._id_5D69837CF4DB0407, "squadPMCMissionGroups", _id_804E08EA07743095, "clientNum", _id_F5382FE07E7DD793[_id_804E08EA07743095]);

      if(isDefined(_id_14CEE82314AC28CD[_id_804E08EA07743095]) && isDefined(_id_A0F0FC2F7FF8F287[_id_804E08EA07743095])) {
        for(_id_37CE0ED43BBBDA16 = 0; _id_37CE0ED43BBBDA16 < min(_id_14CEE82314AC28CD[_id_804E08EA07743095].size, 3); _id_37CE0ED43BBBDA16++) {
          _id_736D8D9188CCBD45 setplayerdata(level._id_5D69837CF4DB0407, "squadPMCMissionGroups", _id_804E08EA07743095, "missions", _id_37CE0ED43BBBDA16, "challengeID", _id_14CEE82314AC28CD[_id_804E08EA07743095][_id_37CE0ED43BBBDA16]);

          for(_id_CAE85767829655F7 = 0; _id_CAE85767829655F7 < 3; _id_CAE85767829655F7++)
            _id_736D8D9188CCBD45 setplayerdata(level._id_5D69837CF4DB0407, "squadPMCMissionGroups", _id_804E08EA07743095, "missions", _id_37CE0ED43BBBDA16, "challengeProgress", _id_CAE85767829655F7, _id_A0F0FC2F7FF8F287[_id_804E08EA07743095][_id_37CE0ED43BBBDA16][_id_CAE85767829655F7]);
        }
      }

      while(_id_37CE0ED43BBBDA16 < 3) {
        _id_736D8D9188CCBD45 setplayerdata(level._id_5D69837CF4DB0407, "squadPMCMissionGroups", _id_804E08EA07743095, "missions", _id_37CE0ED43BBBDA16, "challengeID", 0);

        for(_id_CAE85767829655F7 = 0; _id_CAE85767829655F7 < 3; _id_CAE85767829655F7++)
          _id_736D8D9188CCBD45 setplayerdata(level._id_5D69837CF4DB0407, "squadPMCMissionGroups", _id_804E08EA07743095, "missions", _id_37CE0ED43BBBDA16, "challengeProgress", _id_CAE85767829655F7, 0);

        _id_37CE0ED43BBBDA16++;
      }
    }
  }
}

_id_B2D5FE14937FA854(player, id) {
  if(isDefined(player.guid) && isDefined(level._id_87AF7F50C23346E8._id_DA66011459CB5E59)) {
    if(!isDefined(level._id_87AF7F50C23346E8._id_DA66011459CB5E59[player.guid]))
      level._id_87AF7F50C23346E8._id_DA66011459CB5E59[player.guid] = [];

    if(!isDefined(level._id_87AF7F50C23346E8._id_DA66011459CB5E59[player.guid][id])) {
      level._id_87AF7F50C23346E8._id_DA66011459CB5E59[player.guid][id] = 1;
      _id_DAB637C713E2986F(player, id);
    }
  }
}

luinotifylistener(_id_EA3E3B2121E6713A, value) {
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "update_pmc_mission_data":
        _id_B944A4D927F9C28A(self);
        break;
    }
  }
}

_id_6F6CC16C0528DE5B(player) {
  return player scripts\cp_mp\challenges::challengesenabledforplayer() && _id_CFF2F4F168B29B81();
}

_id_1120295A2CD880F4(player, _id_54658E63E8FB96B5) {
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_736D8D9188CCBD45 in players) {
    if(_id_736D8D9188CCBD45 != player)
      _id_736D8D9188CCBD45 scripts\mp\utility\points::_id_0366980B6A8796AE("stat_05A2C275279403F5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    else {
      if(!isDefined(_id_736D8D9188CCBD45.pers["missionXP"]))
        _id_736D8D9188CCBD45.pers["missionXP"] = 0;

      _id_736D8D9188CCBD45.pers["missionXP"] = _id_736D8D9188CCBD45.pers["missionXP"] + _id_54658E63E8FB96B5;
    }

    if(!isDefined(_id_736D8D9188CCBD45._id_56A4E98C643A1E2D))
      _id_736D8D9188CCBD45._id_56A4E98C643A1E2D = 0;

    _id_736D8D9188CCBD45._id_56A4E98C643A1E2D++;
  }
}

_id_1A3BD4602E62E661(player, players, ref) {
  foreach(_id_736D8D9188CCBD45 in players) {
    if(!isarray(_id_736D8D9188CCBD45._id_D0FFE5AA652992E9))
      _id_736D8D9188CCBD45._id_D0FFE5AA652992E9 = [];

    _id_736D8D9188CCBD45._id_D0FFE5AA652992E9[ref] = 1;
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || !isDefined(player.team)) {
    return;
  }
  switch (ref) {
    case "iw9_s4_ch_pmc_smugglers_run_extract":
      if(!istrue(player._id_D0FFE5AA652992E9["iw9_s4_ch_pmc_smugglers_run_drop"]))
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_smugglers_run_on_kills_done", player.team);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_smugglers_run_extract_ready", player.team);

      break;
    case "iw9_s4_ch_pmc_smugglers_run_drop":
      if(!istrue(player._id_D0FFE5AA652992E9["iw9_s4_ch_pmc_smugglers_run_extract"]))
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_smugglers_run_weapons_deaddropped", player.team);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_smugglers_run_extract_ready", player.team);

      break;
    case "iw9_s4_ch_pmc_tracking_activity_loot":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_tracking_activity_on_tracker_pickup", player.team);
      break;
    case "iw9_s4_ch_pmc_tracking_activity_use":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_tracking_activity_on_uavs_activated", player.team);
      break;
    case "iw9_s4_ch_pmc_go_for_a_drive_aquire_item":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_go_for_a_drive_on_drive_pickup", player.team);
      break;
    case "iw9_s4_ch_pmc_go_for_a_drive_drive":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_go_for_a_drive_transfer_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_fearless_on_weaponcase_pickup":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_on_weaponcase_pickup", player.team);
      break;
    case "iw9_s4_ch_pmc_fearless_clear":
      if(!istrue(player._id_D0FFE5AA652992E9["iw9_s4_ch_pmc_fearless_activate"]))
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_on_firestation_cleared", player.team);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_completed", player.team);

      break;
    case "iw9_s4_ch_pmc_fearless_activate":
      if(!istrue(player._id_D0FFE5AA652992E9["iw9_s4_ch_pmc_fearless_clear"]))
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_on_uav_activated", player.team);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_completed", player.team);

      break;
    case "iw9_s4_ch_pmc_cut_the_head_search":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_cut_the_head_on_key_pickup", player.team);
      break;
    case "iw9_s4_ch_pmc_cut_the_head_activate":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_cut_the_head_on_data_ready_for_extract", player.team);
      break;
    default:
      break;
  }
}

_id_DAB637C713E2986F(player, id) {
  ref = level._id_87AF7F50C23346E8._id_16308019512AF385[id].ref;
  xp = level._id_87AF7F50C23346E8._id_16308019512AF385[id].xp;

  if(!scripts\mp\flags::gameflag("prematch_done") || !isDefined(player.team)) {
    return;
  }
  _id_1120295A2CD880F4(player, xp);

  if(isDefined(player.team)) {
    _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    if(isDefined(_id_607DA387F3617ED1)) {
      foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1) {
        if(_id_8F7040E569EC9E98 != player)
          scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_8F7040E569EC9E98, "squadmate_mission_complete", 1);
      }
    }
  }

  switch (ref) {
    case "iw9_s4_ch_pmc_tracking_activity":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_tracking_activity_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_go_for_a_drive":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_go_for_a_drive_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_cut_the_head":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_cut_the_head_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_ir_beacon_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_beacon_castle_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_microphone_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_microphone_plant_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_delta_drive_poi":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_assign_travel", player.team);
      break;
    case "iw9_s4_ch_pmc_interrogate_chemist_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_shadow_alliance_2_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_gas_sample_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_gas_investigation_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_letter_upload_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_letter_instructions_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_deliver_letter_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_letter_delivery_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_deliver_russian_docs_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_bio_bunker_intel_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_phalanx_harddrive_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_building_21_owner_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_biobunker_safe_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_drill_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_dead_drop_weapons_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_letter_instructions_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_biobunker_keycode_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_find_map_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_stronghold_clears":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_three_strongholds_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_scan_biobunker_exits_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_exits_located_completed", player.team);
      break;
    case "iw9_s4_ch_pmc_secure_biobunker_exits_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_mission_exit_secured_completed", player.team);
      break;
    case "iw9_s5_ch_pmc_investigate_shipping_container_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_f_mission1_completed", player.team);
      break;
    case "iw9_s5_ch_pmc_false_reinforcement_signal_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_f_mission2_completed", player.team);
      break;
    case "iw9_s5_ch_pmc_flush_out_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_f_mission3_completed", player.team);
      break;
    case "iw9_s5_ch_pmc_cartel_locate_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_f_mission4_completed", player.team);
      break;
    case "iw9_s5_ch_pmc_destroy_cartel_story":
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_f_mission5_completed", player.team);
      break;
    default:
      break;
  }
}

_id_5DDB9007EE69FE54(player, lootid, _id_5577636292591C8B) {
  if(!isDefined(lootid))
    return 0;

  _id_AA1ED8F12D71A7A5 = _id_A0AF645242DC7260(player, lootid, _id_5577636292591C8B);
  _id_D720B003C55C1F6C = 0;

  if(_id_AA1ED8F12D71A7A5) {
    faction = level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5].faction;
    _id_3EAA9F644DBE7834 = level._id_87AF7F50C23346E8._id_16308019512AF385[_id_AA1ED8F12D71A7A5]._id_1E6F49EEC1998002;

    if(isDefined(faction)) {
      switch (_id_3EAA9F644DBE7834) {
        case "EXFIL":
        case "EXTRACT":
          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("faction_" + faction + "_item_exfil_nag", [player]);
          _id_D720B003C55C1F6C = 1;
          break;
        case "DEAD_DROP":
          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("faction_" + faction + "_item_dead_drop_nag", [player]);
          _id_D720B003C55C1F6C = 1;
          break;
        default:
          break;
      }
    }
  }

  if(lootid == 11197) {
    if(isDefined(level._id_FE06B29988DC7C85) && level._id_FE06B29988DC7C85 getscriptablepartstate("dmz_pmc_place_intel") == "invisible_unusable") {
      level._id_FE06B29988DC7C85 setscriptablepartstate("dmz_pmc_place_intel", "invisible_usable");
      level._id_FE06B29988DC7C85 _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("water_caves_story"));
    }

    _id_D720B003C55C1F6C = 1;
  }

  thread _id_7BB64B8F4EEA0443(player, lootid);
  return _id_D720B003C55C1F6C;
}

_id_7BB64B8F4EEA0443(player, lootid) {
  _id_5D10FD4182B17097 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_valuable_drill");
  _id_C6D0DF64279E57B9 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_gascan");
  _id_D3A1B1290EE315AB = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_valuable_gold_skull");

  if(lootid == _id_5D10FD4182B17097 || lootid == _id_C6D0DF64279E57B9 || lootid == _id_D3A1B1290EE315AB) {
    waitframe();

    if(isDefined(player)) {
      _id_0977A87CBF1BC6D6 = player _id_2D9D24F7C63AC143::_id_93F02514431A1F5D(_id_5D10FD4182B17097);
      _id_42E59AD4D758C878 = player _id_2D9D24F7C63AC143::_id_93F02514431A1F5D(_id_C6D0DF64279E57B9);
      _id_5A0F6A793669372A = player _id_2D9D24F7C63AC143::_id_93F02514431A1F5D(_id_D3A1B1290EE315AB);

      if(_id_0977A87CBF1BC6D6 && _id_42E59AD4D758C878 && _id_5A0F6A793669372A)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "get_backpack_trade_items", 1);
    }
  }
}

_id_D9E4D7581BC90FE4(player, weapon, _id_4E479E14D0837E84) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(!isDefined(player) || !isDefined(player.guid)) {
    return;
  }
  if(!isDefined(level._id_36635E1FD288EA27))
    level._id_36635E1FD288EA27 = [];

  level._id_36635E1FD288EA27[player.guid] = 1;

  if(isDefined(weapon)) {
    if(issameweapon(weapon, level._id_C891A425BF8CBC28))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "loot_chemist_dead_drop_weapon", 1);

    if(issameweapon(weapon, level._id_0632F6A89B947FD5))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "loot_phalanx_dead_drop_weapon", 1);

    if(isDefined(level._id_C932DCF448D425F1) && issameweapon(weapon, level._id_C932DCF448D425F1))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "loot_trapper_crossbow", 1);

    if(isDefined(_id_4E479E14D0837E84))
      _id_CC6A02D4564D9F07(player, _id_4E479E14D0837E84);
  }
}

_id_C2BC51039A2DF634(player) {
  _id_91CB23E7AB33F8EF = _id_0B7A9CE0A2282B79::_id_DDD16C8B86863B56(player);

  if(isDefined(_id_91CB23E7AB33F8EF) && _id_91CB23E7AB33F8EF <= 2)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "operator_slot_full_" + _id_91CB23E7AB33F8EF, 1);
}

_id_3172B1344F4E08A0(player, _id_414B281CD48C16D3, _id_EBD34E72023FC5A9, clipammo, _id_52C67624A2BB680E, _id_3064FA24DBBD5BBF) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2()) {
    _id_04249EC519AA97CD(player, _id_414B281CD48C16D3, _id_EBD34E72023FC5A9, clipammo, _id_52C67624A2BB680E, _id_3064FA24DBBD5BBF);

    if(istrue(player._id_859654E0445A36D9))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "pmc_biolabs_hostage_exfil", 1);
  }

  _id_3C0F3A5D88F0584A = 0;

  foreach(item in _id_EBD34E72023FC5A9) {
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item.lootid, "extracted", player, item);

    if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(item.lootid))
      _id_3C0F3A5D88F0584A++;
  }

  _id_342175A1B9F9067E = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player);

  if(_id_3C0F3A5D88F0584A >= _id_342175A1B9F9067E)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "full_backpack_dogtag_extract", 1);

  _id_3EAA9F644DBE7834 = 0;
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 5);

  if(istrue(_id_3064FA24DBBD5BBF._id_27144879B0C7BEED)) {
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 8);
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extracted_final", 1);
  }

  if(_id_3064FA24DBBD5BBF.players.size >= 2) {
    if(istrue(_id_3064FA24DBBD5BBF._id_5FDA164731E59C13))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "personal_exfil_with_other_player", 1);

    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "exfil_with_other_players", _id_3064FA24DBBD5BBF.players.size);
  }

  if(istrue(_id_3064FA24DBBD5BBF._id_21584999AB948530))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "drivable_exfil", 1);

  items = scripts\engine\utility::array_combine(_id_414B281CD48C16D3, _id_EBD34E72023FC5A9, clipammo);
  _id_BAECEEC743D9A737(player, items, _id_52C67624A2BB680E, _id_3EAA9F644DBE7834, 1);

  if(isDefined(level._id_E250C5815C2E42F3) && scripts\engine\utility::array_contains(level._id_E250C5815C2E42F3, player.team))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "plane_black_box_extract", 1);

  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extracted", 1);

  if(isDefined(player.guid) && (!isDefined(level._id_36635E1FD288EA27) || !isDefined(level._id_36635E1FD288EA27[player.guid])))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "exfil_no_weapons", 1);

  _id_4C4CA0F1F252F57B = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player);
  _id_B3723CF04DCD3FB8 = _id_2D9D24F7C63AC143::_id_102ABD6883C5F9BF(player);
  _id_7704A6A835AD2E44 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_backpack_scav");

  if(_id_4C4CA0F1F252F57B > 5 && _id_B3723CF04DCD3FB8 != _id_7704A6A835AD2E44)
    _id_4C4CA0F1F252F57B++;

  if(_id_EBD34E72023FC5A9.size == _id_4C4CA0F1F252F57B)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "full_backpack_extract", 1);

  if(istrue(_id_3064FA24DBBD5BBF._id_6086028A8DFDE29E))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "hostage_heli_exfil", 1);

  if(istrue(player._id_D139CA6041259B28))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extract_heli_blackbox", 1);

  _id_B5468C34E36D3940 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player) >= 9 && scripts\engine\utility::is_equal(player._id_BED158A6DFAC230D, 3) && scripts\engine\utility::is_equal(player.gasmasktype, "brloot_equip_gasmask_durable") && player _id_2CEDCC356F1B9FC8::hasselfrevivetoken() && isDefined(scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1));

  if(_id_B5468C34E36D3940 && _id_EBD34E72023FC5A9.size >= 10 && _id_2D9D24F7C63AC143::_id_57931A717F140EBE(player).size >= 2 && isDefined(player.equipment) && player.equipment.size >= 4)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "full_backpack_loadout_extract", 1);

  if(_id_B5468C34E36D3940)
    _id_C2BC51039A2DF634(player);
}

_id_04249EC519AA97CD(player, _id_414B281CD48C16D3, _id_EBD34E72023FC5A9, clipammo, _id_52C67624A2BB680E, _id_3064FA24DBBD5BBF) {
  if(isDefined(level._id_A7B62649C81B481A) && isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2)) {
    _id_9C02E895E4DBDC3B = level._id_A7B62649C81B481A._id_ACC161DE36707DE2;

    if(_id_9C02E895E4DBDC3B == 5)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "lpcon_echo_extract", 1);
  }
}

_id_B0537EE3A491B4DD(player, contents, _id_52C67624A2BB680E) {
  _id_3EAA9F644DBE7834 = 0;
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 6);
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 1);
  _id_FEC4228317AFE4FF = _id_BAECEEC743D9A737(player, contents, _id_52C67624A2BB680E, _id_3EAA9F644DBE7834, 0);

  if(!isDefined(player._id_E7FAF08F327B0FB5))
    player._id_E7FAF08F327B0FB5 = 0;

  player._id_E7FAF08F327B0FB5 = player._id_E7FAF08F327B0FB5 + _id_2CC6455920627806::_id_0160A29300CE1E14(_id_FEC4228317AFE4FF, player);
}

_id_BAECEEC743D9A737(player, items, _id_52C67624A2BB680E, _id_3EAA9F644DBE7834, _id_4FC750F6108A10AB) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  _id_A95035097821E2D1 = [];
  _id_2A1283E22F4E4AA8 = 0;
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 1);

  foreach(item in items) {
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);
    _id_25978461C6E4F61B = level.br_pickups._id_838863C4848D4C26[ref];
    itemtype = undefined;

    if(isDefined(_id_25978461C6E4F61B))
      itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

    quantity = item.quantity;

    if(!isDefined(item.quantity))
      quantity = 1;

    source = 0;

    if(isDefined(item._id_E1147886CCF51970) && isDefined(player.team) && item._id_E1147886CCF51970 != player.team)
      source = scripts\cp_mp\challenges::_id_6D40F12A09494350(source, 0);

    lootid = item.lootid;

    if(isDefined(item.objweapon)) {
      _id_49D6C5A42EBCF947 = scripts\mp\weapons::_id_7A91162092CC11EC(lootid);

      if(isDefined(_id_49D6C5A42EBCF947))
        lootid = _id_49D6C5A42EBCF947;
    }

    scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, lootid, undefined, _id_3EAA9F644DBE7834, quantity, source);

    if(isDefined(itemtype) && (itemtype == "lethal" || itemtype == "tactical")) {
      if(!isDefined(_id_A95035097821E2D1[ref])) {
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unique_grenade_extract", quantity);
        _id_A95035097821E2D1[ref] = 1;
      }
    }

    if(isDefined(item.objweapon) && isDefined(item._id_4E479E14D0837E84)) {
      _id_3F6103D9666B07CC = _id_0B7A9CE0A2282B79::_id_36275388F9093535(item._id_4E479E14D0837E84);

      if(isDefined(_id_3F6103D9666B07CC) && _id_3F6103D9666B07CC.team != player.team)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_3F6103D9666B07CC, "player_extracted_your_insured_weapon", 1);
    }

    _id_927CF275793E815B = scripts\cp_mp\challenges::_id_CE112254F7CBA89E(item.objweapon);

    if(isDefined(_id_927CF275793E815B) && _id_927CF275793E815B != 0) {
      attachments = getweaponattachments(item.objweapon);
      _id_51DBE1A1C3D8BF04 = _func_6527364C1ECCA6C6(item.objweapon);
      _id_2CB723804483D204 = scripts\engine\utility::array_remove_array(attachments, _id_51DBE1A1C3D8BF04);

      if(_id_2CB723804483D204.size >= 3)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extract_3_attachment_weapon", 1);
    }

    if(isDefined(item.objweapon) && item.objweapon issilenced())
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extract_with_silenced_weapons", 1);

    if(isDefined(item.objweapon) && isDefined(item.objweapon.basename) && isDefined(item.objweapon.camo) && item.objweapon.basename == "iw9_pi_decho_mp" && item.objweapon.camo == "camo_comp_01")
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "extracted_gold_decho", 1);
  }

  scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, 8395, undefined, _id_3EAA9F644DBE7834, _id_52C67624A2BB680E);
  _id_FEC4228317AFE4FF = player.plundercount;

  if(!_id_2D9D24F7C63AC143::_id_C4F1BD7A01A307FA(player))
    _id_FEC4228317AFE4FF = player.plundercount + player _id_6FC415FF6A905DC1::_id_E2F4F470C55123B8(items);
  else
    _id_FEC4228317AFE4FF = _id_FEC4228317AFE4FF + _id_3AACF02225CA0DA5::_id_BAF5E17D7033A223(player);

  if(istrue(_id_4FC750F6108A10AB))
    player._id_FEC4228317AFE4FF = _id_FEC4228317AFE4FF;

  player dlog_recordplayerevent("dlog_event_dmz_exfil_cash", ["cash_amount", _id_FEC4228317AFE4FF]);

  if(_id_FEC4228317AFE4FF >= 20000)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "big_cash_extract", 1);

  return _id_FEC4228317AFE4FF;
}

_id_68D841F5BC2DD2B6(player, _id_B038ED928EC17A81) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "loot_cache", 1);
}

_id_04896A33419DA8A6(player, _id_B038ED928EC17A81, items) {
  if(!_id_6F6CC16C0528DE5B(player))
    return items;

  if(!isDefined(player) || !isDefined(_id_B038ED928EC17A81) || !isDefined(player.team))
    return items;

  if(isDefined(_id_B038ED928EC17A81.type) && _id_B038ED928EC17A81.type == "dmz_supply_drop_samsite" && _id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("samsite_supply_box")))
    items[items.size] = "interactable_note_anti_air";

  if(isDefined(_id_B038ED928EC17A81.used) && isDefined(_id_B038ED928EC17A81.used[player.team]))
    return items;

  if(!isDefined(_id_B038ED928EC17A81.used))
    _id_B038ED928EC17A81.used = [];

  _id_B038ED928EC17A81.used[player.team] = 1;
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "loot_supply_drop", 1);
  return items;
}

_id_01D1DF26DF05A6C8(door, player) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(!isDefined(player) || !isDefined(player.team) || !isDefined(door)) {
    return;
  }
  if(!isDefined(door._id_8F7EDDC9C0864A1B) || istrue(door._id_FC580ACBD61DA738)) {
    return;
  }
  if(door._id_8F7EDDC9C0864A1B == "fortress") {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlock_stronghold", 1);
    scripts\cp_mp\challenges::_id_070ABD486AE26235(player, "unlock_stronghold", 1);
    _id_F7D8054AE05DE10F(door, player);
    return;
  }

  if(!isDefined(level._id_B99BDEAD5A1BF81B))
    level._id_B99BDEAD5A1BF81B = [];

  if(isDefined(level._id_B99BDEAD5A1BF81B[door._id_8F7EDDC9C0864A1B])) {
    return;
  }
  level._id_B99BDEAD5A1BF81B[door._id_8F7EDDC9C0864A1B] = 1;

  switch (door._id_8F7EDDC9C0864A1B) {
    case "hotel_room1":
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlock_room_2", 1);
      break;
    case "crane_building":
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlock_crane_building_base", 1);
      break;
    case "skeleton_key":
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlock_skeleton_key", 1);
      break;
    default:
      break;
  }

  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlocked_door", 1);
}

_id_F00AA0C3B58C13F2(_id_B038ED928EC17A81, player) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(!isDefined(player) || !isDefined(player.team) || !isDefined(_id_B038ED928EC17A81)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unlocked_door", 1);
}

_id_D10645AFED0F00FE(player, _id_B205D90302DA2F07) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  _id_B23DDA83A49CD36E = scripts\mp\utility\teams::getteamdata(player.team, "poisVisited");

  if(!isDefined(_id_B23DDA83A49CD36E[_id_B205D90302DA2F07])) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "poi_travel", 1);
    _id_B23DDA83A49CD36E[_id_B205D90302DA2F07] = 1;
    scripts\mp\utility\teams::setteamdata(player.team, "poisVisited", _id_B23DDA83A49CD36E);
    players = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(ent in players)
    ent scripts\mp\utility\points::_id_0366980B6A8796AE("stat_3B0B5B72C38E1A56");
  }

  if(player _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(11200) > 0)
    _id_187F4232DCD3B0E9(player, _id_B205D90302DA2F07);

  if(isDefined(player.vehicle) && player.vehicle.vehiclename == "veh9_acv_6x6")
    _id_88D8597BEAFDD628(player, _id_B205D90302DA2F07);
}

_id_5354B59BEDC18F02(player, vehicle) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  vehiclename = vehicle.vehiclename;
  _id_1423302F659C7767 = scripts\mp\utility\teams::getteamdata(player.team, "vehiclesEntered");

  if(!isDefined(_id_1423302F659C7767[vehiclename])) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unique_vehicle_pilot", 1);
    _id_1423302F659C7767[vehiclename] = 1;
    scripts\mp\utility\teams::setteamdata(player.team, "vehiclesEntered", _id_1423302F659C7767);
  }

  if(vehiclename == "veh9_civ_lnd_dirt_bike")
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "enter_dirt_bike", 1);

  if(vehiclename == "veh9_mil_lnd_mrap" && !vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_72F871BF74995298())
    _id_07FC83D63A85C14D(player);

  thread _id_B55402E6D4FAE450(vehicle);
  thread _id_494CF678A5B30F9E(player, vehiclename);
}

_id_0DA557960C6878E1(player) {
  if(!isDefined(player) || !_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "gas_drain", 1);
}

_id_D582DEA90C03CAC0(vehicle, _id_C75620CA74D2E522) {
  owner = vehicle.owner;

  if(!isDefined(owner) || !isDefined(owner.guid) || !isDefined(owner.team) || !_id_6F6CC16C0528DE5B(owner)) {
    return;
  }
  if(!isDefined(level._id_E4F4C5FE8BC2228F))
    level._id_E4F4C5FE8BC2228F = [];

  if(!isDefined(level._id_E4F4C5FE8BC2228F[owner.team]))
    level._id_E4F4C5FE8BC2228F[owner.team] = [];

  if(!isDefined(level._id_0F1CB112868CFFC8))
    level._id_0F1CB112868CFFC8 = [];

  if(!isDefined(level._id_0F1CB112868CFFC8[owner.team]))
    level._id_0F1CB112868CFFC8[owner.team] = [];

  if(!scripts\engine\utility::array_contains(level._id_E4F4C5FE8BC2228F[owner.team], _id_C75620CA74D2E522)) {
    level._id_E4F4C5FE8BC2228F[owner.team][level._id_E4F4C5FE8BC2228F[owner.team].size] = _id_C75620CA74D2E522;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "unique_full_gas_and_repair", 1);
  }

  if(!scripts\engine\utility::array_contains(level._id_0F1CB112868CFFC8[owner.team], vehicle)) {
    level._id_0F1CB112868CFFC8[owner.team][level._id_0F1CB112868CFFC8[owner.team].size] = vehicle;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "unique_vehicle_refuel_repair", 1);

    if(isDefined(vehicle.vehiclename)) {
      if(vehicle.vehiclename == "veh9_jltv_mg" || vehicle.vehiclename == "veh9_patrol_boat")
        scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "full_gas_and_repair_cargo_vehicle", 1);

      if(vehicle.vehiclename == "veh9_mil_cargo_truck")
        scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "cargo_truck_refuel_repair", 1);
    }

    if(vehicle scripts\cp_mp\vehicles\vehicle::_id_7C62CA52F72901A1())
      scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "boat_refuel_repair", 1);
  }
}

_id_719E931249C15652(vehicle) {
  owner = vehicle._id_628A2EBA2E3D4AF4;

  if(!isDefined(owner) || !_id_6F6CC16C0528DE5B(owner) || istrue(vehicle._id_2E64C6E32CBA0A75)) {
    return;
  }
  vehicle._id_2E64C6E32CBA0A75 = 1;

  if(!vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "kill_vehicle_with_train", 1);
}

ongrenadeused(grenade, player, _id_49E6EF3EDADD524E) {
  if(!_id_6F6CC16C0528DE5B(player) || !isDefined(player)) {
    return;
  }
  switch (_id_49E6EF3EDADD524E) {
    case "decoy_grenade":
    case "frag_grenade":
    case "concussion_grenade":
    case "gas":
    case "thermite":
    case "at_mine":
    case "semtex":
    case "bunkerbuster":
    case "c4":
      thread _id_F37F5D719BC2F2F0(grenade, player);
      break;
    default:
      break;
  }
}

_id_5D2504919B717097(owner, victim) {
  if(!_id_6F6CC16C0528DE5B(owner) || !isDefined(victim) || !isDefined(victim.origin)) {
    return;
  }
  if(isagent(victim)) {
    _id_831B0DF5DBB687CF = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(victim.origin);

    if(isDefined(_id_831B0DF5DBB687CF) && _id_4948CDF739393D2D::_id_771F278C8C749A28(_id_831B0DF5DBB687CF))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "snapshot_in_locked_stronghold", 1);
  }
}

_id_815A3DCB943176B3(owner, victim) {
  if(!isDefined(owner) || !_id_6F6CC16C0528DE5B(owner) || !isDefined(victim)) {
    return;
  }
  if(isDefined(victim.agent_type)) {
    _id_1C9CB43BCF3EB16D = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("ai_mp_controller", "agentPers_getAgentPersData", victim, "subcategory");

    if(scripts\cp_mp\challenges::_id_C7496288999AC847(victim.agent_type, _id_1C9CB43BCF3EB16D))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "photograph_cartel", 1);
  }
}

_id_2910BC79A4D8427B(owner, victim) {
  if(!isDefined(owner) || !_id_6F6CC16C0528DE5B(owner) || !isDefined(victim)) {
    return;
  }
  if(isagent(victim)) {
    if(_id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(victim.origin))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "tag_enemy_in_radiation", 1);
  }
}

_id_C0A3853F9497FAD3(_id_1A38F515390A5144) {
  if(isDefined(_id_1A38F515390A5144.reviver) && isDefined(_id_1A38F515390A5144.reviver)) {
    if(isDefined(_id_1A38F515390A5144.reviver.team) && isDefined(_id_1A38F515390A5144._id_22F7E3F7E360775B.team) && _id_1A38F515390A5144.reviver.team != _id_1A38F515390A5144._id_22F7E3F7E360775B.team)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_1A38F515390A5144.reviver, "stim_enemy_player", 1);
  }
}

_id_B71395F12AF20A42(instance) {
  _id_A9F8FA06A358585B(instance._id_3A94ED22775A3C94, "samsite", 1, instance._id_B205D90302DA2F07, 1);
  _id_A497D0881EBBDF71 = 0;

  foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
    if(isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && _id_C327ADFAD89EFC23._id_3A94ED22775A3C94 == instance._id_3A94ED22775A3C94)
      _id_A497D0881EBBDF71++;
  }

  if(_id_A497D0881EBBDF71 >= 3)
    _id_8A7A2427622E7572(instance._id_3A94ED22775A3C94, "sync_samsite_control", 1);
}

_id_19D6E799236E4435(instance) {
  _id_8A7A2427622E7572(instance._id_3A94ED22775A3C94, "plane_shot_down", 1);
}

_id_DA13A73169D19313(ref) {
  switch (ref) {
    case "dom":
      return 1;
    case "geiger":
      return 2;
    case "elim":
      return 0;
    case "trap":
      return 3;
    case "hostage":
      return 4;
    case "vehicledrive":
      return 5;
    case "hunt":
      return 6;
    case "boatdrive":
      return 7;
    case "demo":
      return 8;
    case "samsite":
      return 10;
    case "safe":
      return 9;
    case "bomb":
      return 11;
    case "poi":
      return 12;
    case "hacker_phone":
      return 13;
    case "supply":
      return 14;
    case "scav":
      return 15;
    case "convoy_attack":
      return 16;
    case "convoy_defend":
      return 17;
    case "train_safe":
      return 18;
    default:
      return undefined;
  }
}

_id_A9F8FA06A358585B(_id_2E0BDB36F81A37E4, _id_FA7850D42F71A2AD, _id_2C900DDF3B37AA0B, _id_B205D90302DA2F07, _id_A7828126A34279E8) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_2E0BDB36F81A37E4, "players");

  if(_id_E2B2BBD9E6539F11.size == 0) {
    return;
  }
  _id_03F96767F60A1D2C = _id_DA13A73169D19313(_id_FA7850D42F71A2AD);

  if(!isDefined(_id_03F96767F60A1D2C)) {
    return;
  }
  _id_AF0662D6485D5D58 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, _id_03F96767F60A1D2C);

  if(istrue(_id_2C900DDF3B37AA0B)) {
    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!_id_6F6CC16C0528DE5B(player)) {
        continue;
      }
      scripts\cp_mp\challenges::_id_2635CDB5E985EAAB(player, _id_AF0662D6485D5D58, _id_B205D90302DA2F07);
    }

    if(istrue(_id_A7828126A34279E8)) {
      return;
    }
    if(!isDefined(level._id_48CD656AF1746262))
      level._id_48CD656AF1746262 = [];

    if(!isDefined(level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4]))
      level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4] = [];

    if(isDefined(_id_B205D90302DA2F07)) {
      if(!isDefined(level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4][_id_B205D90302DA2F07])) {
        level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4][_id_B205D90302DA2F07] = 1;
        _id_8A7A2427622E7572(_id_2E0BDB36F81A37E4, "contract_complete_unique_poi", 1);
      }
    }

    if(!isDefined(level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4][_id_FA7850D42F71A2AD])) {
      level._id_48CD656AF1746262[_id_2E0BDB36F81A37E4][_id_FA7850D42F71A2AD] = 1;
      _id_8A7A2427622E7572(_id_2E0BDB36F81A37E4, "contract_complete_unique_contract", 1);
      return;
    }
  } else {
    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!_id_6F6CC16C0528DE5B(player)) {
        continue;
      }
      scripts\cp_mp\challenges::_id_AFFB3AF6AF110594(player, _id_AF0662D6485D5D58, _id_B205D90302DA2F07);
    }
  }
}

_id_63FEDB7F004DA23B(attackers) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  _id_42F8055B028EA2E0 = [];

  foreach(attacker in attackers) {
    if(!isDefined(_id_42F8055B028EA2E0[attacker.team])) {
      _id_42F8055B028EA2E0[attacker.team] = 1;
      scripts\cp_mp\challenges::_id_8359CADD253F9604(attacker, "squad_wipe", 1);
    }
  }
}

_id_5E98EB5DE21B3A8C(player) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "hacked_wheelson", 1);
}

_id_919D8870FF2B6812(player, validplayers) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  if(!isDefined(level._id_8B67A807D9DD822C))
    level._id_8B67A807D9DD822C = [];

  if(!isDefined(level._id_8B67A807D9DD822C[player.guid]))
    level._id_8B67A807D9DD822C[player.guid] = [];

  foreach(_id_3C142A00B5CB6976 in validplayers) {
    if(!isDefined(_id_3C142A00B5CB6976.guid) || isDefined(level._id_8B67A807D9DD822C[player.guid][_id_3C142A00B5CB6976.guid])) {
      continue;
    }
    level._id_8B67A807D9DD822C[player.guid][_id_3C142A00B5CB6976.guid] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "request_assimilation", 1);
  }
}

_id_5B7B312AF46D6E96(player) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "ping_contract_phone", 1);
}

_id_58D9B223AAF4966C(_id_276AC5E84835EA87) {
  name = _id_276AC5E84835EA87.name;

  if(isDefined(name))
    return "cleared_" + name;

  return "";
}

_id_59FE5E0D7D5E7947(player, _id_276AC5E84835EA87) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(_id_4948CDF739393D2D::_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87)) {
    if(!isDefined(_id_276AC5E84835EA87.name)) {
      return;
    }
    ref = _id_58D9B223AAF4966C(_id_276AC5E84835EA87);
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, ref, 1);

    if(_id_276AC5E84835EA87.name == "delta_firestation" && isDefined(player.team)) {
      players = scripts\mp\utility\teams::getteamdata(player.team, "players");

      foreach(_id_F0EA4030349A33D5 in players) {
        if(_id_F0EA4030349A33D5 _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(29299)) {
          scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "cleared_fire_station_with_weapon_case", 1);
          break;
        }
      }

      return;
    }
  } else
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "clear_stronghold", 1);
}

_id_21EF4EB1AA52F430(player, index) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(!isDefined(player._id_9CD3A5A67FCD8A9A))
    player._id_9CD3A5A67FCD8A9A = [];

  if(!istrue(player._id_9CD3A5A67FCD8A9A[index])) {
    _id_D6FAB9BC69A92A51(player);
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "uav_tower", 1);
    player._id_9CD3A5A67FCD8A9A[index] = 1;
  }

  team = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_F0EA4030349A33D5 in team) {
    if(_id_F0EA4030349A33D5 _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(29299)) {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "uav_tower_use_with_weapon_case", 1);
      break;
    }
  }

  if(isDefined(level._id_116A5F32AEB86391) && isDefined(player.team)) {
    _id_0F7DF47F85B931DA = 0;

    foreach(_id_C6CD9D2C6AD18DD6 in level._id_116A5F32AEB86391) {
      if(isDefined(_id_C6CD9D2C6AD18DD6._id_DCC5F31EC71D6D8A) && _id_C6CD9D2C6AD18DD6._id_DCC5F31EC71D6D8A == player.team)
        _id_0F7DF47F85B931DA++;
    }

    if(_id_0F7DF47F85B931DA >= 5)
      _id_8A7A2427622E7572(player.team, "sync_uav_tower_control", 1);

    if(_id_0F7DF47F85B931DA >= 2)
      _id_8A7A2427622E7572(player.team, "two_uav_tower_active_at_once", 1);
  }
}

_id_3D12FCE128D424B1(player, instance) {
  if(!_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "agent_radio_used", 1);
}

_id_AFF49E563A741F1E(victim, player, objweapon) {
  if(!isDefined(player) || !_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(isDefined(objweapon)) {
    weaponclass = weaponclass(objweapon);

    if(weaponclass == "spread" && isDefined(player._id_DA28916E7827AF7C) && player._id_DA28916E7827AF7C == "saba_hydro")
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "hydro_shotgun_ai", 1);
    else if(weaponclass == "rifle" && isDefined(player._id_DA28916E7827AF7C) && player._id_DA28916E7827AF7C == "saba_oilfield")
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "oilfield_sniper_ai", 1);
  }

  if(isDefined(level._id_A68DCD3B5A82712D)) {
    foreach(struct in level._id_A68DCD3B5A82712D) {
      dist = distance2d(struct.origin, victim.origin);

      if(dist <= struct.radius)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "killed_under_agent_radio", 1);
    }
  }

  if(isDefined(level._id_116A5F32AEB86391) && isDefined(player.team)) {
    foreach(instance in level._id_116A5F32AEB86391) {
      if(isDefined(instance._id_DCC5F31EC71D6D8A) && instance._id_DCC5F31EC71D6D8A == player.team) {
        dist = distance2d(instance.origin, victim.origin);

        if(dist <= level._id_6ACF91BBF5273E8F)
          scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "kill_under_uav_tower", 1);
      }
    }
  }

  if(isDefined(player) && isDefined(player.team)) {
    if(isDefined(victim._id_A5DAF6A4BAF26AAF) && isDefined(victim._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87)) {
      if(!isDefined(level._id_6BA2DB37DF87088E))
        level._id_6BA2DB37DF87088E = [];

      _id_0DD070161709FA76 = "brloot_legion_deal_intel";

      if(scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E())
        _id_0DD070161709FA76 = "brloot_aq_bunker_note";

      if(!isDefined(level._id_6BA2DB37DF87088E[player.team])) {
        level._id_6BA2DB37DF87088E[player.team] = 1;
        _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76);
      } else
        _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76, undefined, 0.25);

      if(scripts\mp\agents\agent_utility::_id_17B2ECDAE3A795F6(victim)) {
        if(!isDefined(level._id_686C3D79C097CB9E))
          level._id_686C3D79C097CB9E = [];

        _id_0DD070161709FA76 = "brloot_valuable_konni_ledger";

        if(!isDefined(level._id_686C3D79C097CB9E[player.team])) {
          level._id_686C3D79C097CB9E[player.team] = 1;
          _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76);
        } else
          _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76, undefined, 0.25);
      }
    } else if(scripts\mp\agents\agent_utility::_id_17B2ECDAE3A795F6(victim)) {
      if(scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2()) {
        _id_0DD070161709FA76 = "brloot_note_extraction_protocol";
        _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76, undefined, 0.1);
      } else if(scripts\mp\agents\agent_utility::_id_35CC816ACEEEB402(victim)) {
        if(!isDefined(level._id_97F6DFD8F1A1CDE8))
          level._id_97F6DFD8F1A1CDE8 = [];

        _id_0DD070161709FA76 = "brloot_valuable_battle_notes";

        if(!isDefined(level._id_97F6DFD8F1A1CDE8[player.team])) {
          level._id_97F6DFD8F1A1CDE8[player.team] = 1;
          _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76);
        } else
          _id_48814951E916AF89::_id_63A043D47490F90D(victim, _id_0DD070161709FA76, undefined, 0.1);
      }
    }
  }

  if(isDefined(objweapon)) {
    player._id_5394C1BB15BEE8F8 = scripts\engine\utility::_id_53C4C53197386572(player._id_5394C1BB15BEE8F8, []);
    _id_50AA84B69780E0F7 = 0;

    foreach(_id_F0FFAFCA5D927A12 in player._id_5394C1BB15BEE8F8) {
      if(issameweapon(objweapon, _id_F0FFAFCA5D927A12)) {
        _id_50AA84B69780E0F7 = 1;
        break;
      }
    }

    if(!_id_50AA84B69780E0F7) {
      player._id_5394C1BB15BEE8F8 = scripts\engine\utility::array_add(player._id_5394C1BB15BEE8F8, objweapon);
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "kill_AI_unique_weapon", 1);
    }
  }

  _id_634368E310EDF6F9(player, objweapon);
}

_id_398906218A0DD7DA(player, victim, objweapon, modifiers) {
  if(!isDefined(player) || !_id_6F6CC16C0528DE5B(player)) {
    return;
  }
  if(isDefined(objweapon)) {
    _id_927CF275793E815B = scripts\cp_mp\challenges::_id_CE112254F7CBA89E(objweapon);

    if(isDefined(_id_927CF275793E815B) && _id_927CF275793E815B != 0)
      _id_0E06A127B0DD6AF8(player, _id_927CF275793E815B);
  }

  _id_8221E91D323E06D1 = scripts\cp_mp\challenges::_id_3005EF56488DF9BE(modifiers);

  if(isDefined(_id_8221E91D323E06D1) && isDefined(_id_8221E91D323E06D1[56])) {
    _id_D4E556C137E61B46 = player;

    for(;;) {
      if((isPlayer(_id_D4E556C137E61B46) || _func_5FAAB6FEF1BAF5AE(_id_D4E556C137E61B46)) && !_id_D4E556C137E61B46 islinked())
        _id_ACF3EB2AF5579D05 = _id_D4E556C137E61B46 getmovingplatformparent(1);
      else
        _id_ACF3EB2AF5579D05 = _id_D4E556C137E61B46 getlinkedparent();

      if(!isDefined(_id_ACF3EB2AF5579D05)) {
        break;
      }

      _id_D4E556C137E61B46 = _id_ACF3EB2AF5579D05;
    }

    if(isDefined(_id_D4E556C137E61B46) && _id_D4E556C137E61B46 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(_id_D4E556C137E61B46);

      if(isDefined(driver) && isDefined(driver.team) && isPlayer(driver)) {
        if(driver.team != player.team && (!isPlayer(victim) || driver.team != victim.team))
          scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "enemy_operator_killed_enemies_from_your_vehicle", 1);
      }
    }
  }

  if(isDefined(player._id_ABD157413AC4E022)) {
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(player._id_ABD157413AC4E022);

    if(isDefined(driver) && isDefined(driver.team) && isPlayer(driver)) {
      if(driver.team != player.team && (!isPlayer(victim) || driver.team != victim.team))
        scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "enemy_operator_killed_enemies_from_your_vehicle", 1);
    }
  }
}

_id_0E06A127B0DD6AF8(player, _id_927CF275793E815B) {
  if(!isDefined(player._id_3B6F247FF290F31A))
    player._id_3B6F247FF290F31A = [];

  if(!isDefined(player._id_3B6F247FF290F31A[_id_927CF275793E815B])) {
    player._id_3B6F247FF290F31A[_id_927CF275793E815B] = 1;
    players = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_736D8D9188CCBD45 in players) {
      if(isDefined(_id_736D8D9188CCBD45) && _id_736D8D9188CCBD45 != player) {
        if(!isDefined(_id_736D8D9188CCBD45._id_3B6F247FF290F31A))
          _id_736D8D9188CCBD45._id_3B6F247FF290F31A = [];

        _id_736D8D9188CCBD45._id_3B6F247FF290F31A[_id_927CF275793E815B] = 1;
      }
    }

    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "kill_unique_weapon_class", 1);
  }
}

_id_22024087C0855CDE() {
  if(!isDefined(level._id_A7B62649C81B481A) || !isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2)) {
    return;
  }
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  _id_B3A1D6972F2A160C = level._id_A7B62649C81B481A._id_ACC161DE36707DE2;
  _id_444A5451F436094A = "";

  if(_id_B3A1D6972F2A160C == 2)
    _id_444A5451F436094A = "lpcon_bravo";
  else if(_id_B3A1D6972F2A160C == 3)
    _id_444A5451F436094A = "lpcon_charlie";
  else if(_id_B3A1D6972F2A160C == 4)
    _id_444A5451F436094A = "lpcon_delta";
  else if(_id_B3A1D6972F2A160C == 5)
    _id_444A5451F436094A = "lpcon_echo";

  if(_id_444A5451F436094A != "") {
    foreach(player in level.players)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, _id_444A5451F436094A, 1);
  }
}

_id_7184ABFE5941A710(player, _id_1CB2654B9D2B112A) {
  if(!isDefined(player) || !isDefined(player.br_kiosk)) {
    return;
  }
  _id_15B89FF206500554 = player.br_kiosk;

  if(!isDefined(level._id_0B434BB6B1C80514))
    level._id_0B434BB6B1C80514 = [];

  if(!isDefined(level._id_0B434BB6B1C80514[player.team]))
    level._id_0B434BB6B1C80514[player.team] = [];

  if(!isDefined(level._id_0B434BB6B1C80514[player.team][_id_15B89FF206500554.index])) {
    _id_836ACB10D08E768B = spawnStruct();
    _id_836ACB10D08E768B._id_1CB2654B9D2B112A = 0;
    _id_836ACB10D08E768B._id_E993C350422F112F = 0;
    level._id_0B434BB6B1C80514[player.team][_id_15B89FF206500554.index] = _id_836ACB10D08E768B;
  }

  _id_836ACB10D08E768B = level._id_0B434BB6B1C80514[player.team][_id_15B89FF206500554.index];
  _id_836ACB10D08E768B._id_1CB2654B9D2B112A = _id_836ACB10D08E768B._id_1CB2654B9D2B112A + _id_1CB2654B9D2B112A;

  if(_id_836ACB10D08E768B._id_1CB2654B9D2B112A >= 600 && !_id_836ACB10D08E768B._id_E993C350422F112F) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "spend_cash_unique_buy_station", 1);
    _id_836ACB10D08E768B._id_E993C350422F112F = 1;
  }
}

_id_2C407030F231CCC5(player, _id_06E36889D56716C4) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(level._id_47CAFADB8DA5A0B2))
    level._id_47CAFADB8DA5A0B2 = [];

  if(!isDefined(level._id_47CAFADB8DA5A0B2[player.team]))
    level._id_47CAFADB8DA5A0B2[player.team] = [];

  if(!isDefined(level._id_47CAFADB8DA5A0B2[player.team][_id_06E36889D56716C4])) {
    level._id_47CAFADB8DA5A0B2[player.team][_id_06E36889D56716C4] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "sell_unique_valuable", 1);
  }
}

_id_8A7A2427622E7572(team, type, quantity) {
  if(isDefined(team)) {
    foreach(_id_736D8D9188CCBD45 in scripts\mp\utility\teams::getteamdata(team, "players"))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_736D8D9188CCBD45, type, quantity, 0);
  }
}

_id_A269616A6F117980() {
  level._id_B4973B15EAD7E660 = _func_F159C10D5CF8F0B4("trigger_hydro_waterwell", "script_noteworthy");
}

_id_90F5D19AB1C382D2(position, owner, team) {
  if(!isDefined(level._id_B4973B15EAD7E660) || level._id_B4973B15EAD7E660.size == 0) {
    return;
  }
  position = position - (0, 0, 100);

  foreach(_id_DE9ED71411646755 in level._id_B4973B15EAD7E660) {
    if(!ispointinvolume(position, _id_DE9ED71411646755)) {
      continue;
    }
    if(isDefined(_id_DE9ED71411646755.used) && isDefined(_id_DE9ED71411646755.used[team])) {
      continue;
    }
    if(!isDefined(_id_DE9ED71411646755.used))
      _id_DE9ED71411646755.used = [];

    _id_DE9ED71411646755.used[team] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(owner, "gas_grenade_in_hydro_well", 1);
    break;
  }
}

_id_4BA822FD37B63DCE(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "enter_medium_bird", 1);
}

_id_B46E6500BEF678BC() {
  _id_4D9FC05439D5C39F = _func_F159C10D5CF8F0B4("trigger_lone_helipad", "script_noteworthy");

  if(!isDefined(_id_4D9FC05439D5C39F) || _id_4D9FC05439D5C39F.size == 0) {
    return;
  }
  helipad = _id_4D9FC05439D5C39F[0];

  for(;;) {
    helipad waittill("trigger", ent);

    if(!ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      continue;
    }
    if(ent scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() != "little_bird") {
      continue;
    }
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(ent);

    if(!isDefined(driver) || !isDefined(driver.team) || !isPlayer(driver)) {
      continue;
    }
    if(isDefined(helipad.used) && isDefined(helipad.used[driver.team])) {
      continue;
    }
    if(!_id_C5E0BAC8F123CC88(driver.team, _id_16AE6D8B5F25F31B("medium_bird_story"))) {
      continue;
    }
    if(!isDefined(helipad.used))
      helipad.used = [];

    helipad.used[driver.team] = 1;
    helipad _id_1D1A225AB9F876FD(ent, driver);
  }
}

_id_1D1A225AB9F876FD(vehicle, driver) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "land_at_lone_helipad", 1);
  _id_FDC858798721A112 = spawn("script_origin", vehicle.origin);
  _id_FDC858798721A112 linkTo(vehicle);
  _id_FDC858798721A112 makeusable();
  _id_FDC858798721A112 setuserange(250);
  _id_FDC858798721A112 setusefov(180);
  _id_FDC858798721A112 setHintString(&"PMC/DOWNLOAD_FLIGHT_PATH_DATA");
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(driver.team, "players");

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(_id_6D5ED003AF1F9612, player)) {
      _id_FDC858798721A112 enableplayeruse(player);
      continue;
    }

    _id_FDC858798721A112 disableplayeruse(player);
  }

  foreach(player in _id_6D5ED003AF1F9612)
  player scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(vehicle, 0);

  _id_FDC858798721A112 waittill("trigger");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "use_heli_blackbox", 1);
  driver._id_D139CA6041259B28 = 1;
  _id_FDC858798721A112 delete();

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player))
      player scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(vehicle, 1);
  }
}

_id_C603F3BE1379A541() {
  level._id_A524A11DADC4D9FB = [];
  _id_4C570D8C8152FAF1 = _func_F159C10D5CF8F0B4("trigger_sira_mall", "script_noteworthy");
  _id_09A4152961152A1A = _func_F159C10D5CF8F0B4("pmc_oasis_trigger", "script_noteworthy");
  _id_5F3FCC88F85016C2 = _func_F159C10D5CF8F0B4("pmc_sandstorm", "script_noteworthy");

  if(isDefined(_id_4C570D8C8152FAF1) && _id_4C570D8C8152FAF1.size > 0)
    level._id_A524A11DADC4D9FB["sira_mall"] = _id_4C570D8C8152FAF1[0];

  if(isDefined(_id_09A4152961152A1A) && _id_09A4152961152A1A.size > 0)
    level._id_A524A11DADC4D9FB["saba_oasis"] = _id_09A4152961152A1A[0];

  if(isDefined(_id_5F3FCC88F85016C2) && _id_5F3FCC88F85016C2.size > 0)
    level._id_A524A11DADC4D9FB["saba_sandstorm"] = _id_5F3FCC88F85016C2[0];
}

_id_4E6833308F41021E() {
  _id_641D70DCBCAF1346 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_unhacked_laptop");

  if(!isDefined(_id_641D70DCBCAF1346) || _id_641D70DCBCAF1346.size == 0) {
    return;
  }
  level._id_1FED93654FA204F8 = _id_641D70DCBCAF1346[0];
}

_id_44CB8B0C33CEF670(player, _id_5793A0CF9D352C92, weapon) {
  if(isDefined(weapon)) {
    attachments = getweaponattachments(weapon);
    _id_51DBE1A1C3D8BF04 = _func_6527364C1ECCA6C6(weapon);
    _id_2CB723804483D204 = scripts\engine\utility::array_remove_array(attachments, _id_51DBE1A1C3D8BF04);

    if(_id_2CB723804483D204.size >= 5)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "dead_drop_gun_with_five_attachments", 1);

    if(isDefined(_id_5793A0CF9D352C92._id_B205D90302DA2F07) && _id_5793A0CF9D352C92._id_B205D90302DA2F07 == "saba_caves" && issameweapon(weapon, level._id_C891A425BF8CBC28))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "dead_drop_chemist_gun", 1);

    if(isDefined(level._id_C932DCF448D425F1) && issameweapon(weapon, level._id_C932DCF448D425F1))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "dead_drop_trapper_crossbow", 1);
  }
}

_id_BB05028F0BA58E1A(_id_69E96A4CAA72D794, lootid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(lootid, "addedToDeadDrop"))
    return scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(lootid, "addedToDeadDrop", _id_69E96A4CAA72D794, lootid);

  if(!isDefined(self) || !isDefined(self._id_02FA5B49969DEF47))
    return [lootid, undefined];

  _id_338E098F5CBFDA5B = undefined;

  if(lootid == 11247)
    [lootid, _id_338E098F5CBFDA5B] = _id_D2ABBCB10A39FF56(lootid);

  if(isDefined(self.team) && _id_C5E0BAC8F123CC88(self.team, _id_16AE6D8B5F25F31B("radiation_bomb_story")) && (lootid == 8408 || lootid == 9104 || lootid == 8569))
    [lootid, _id_338E098F5CBFDA5B] = _id_0F8D258990C78569(lootid);

  if(isDefined(self.team) && _id_C5E0BAC8F123CC88(self.team, _id_16AE6D8B5F25F31B("bomb_delivery")) && (lootid == 19214 || lootid == 8408 || lootid == 13372))
    [lootid, _id_338E098F5CBFDA5B] = _id_4AD47F789DFAD847(_id_69E96A4CAA72D794, lootid);

  if(isDefined(self.team) && _id_C5E0BAC8F123CC88(self.team, _id_16AE6D8B5F25F31B("speed_deaddrop_chain")))
    [lootid, _id_338E098F5CBFDA5B] = _id_DBC1B65952F8ED88(self, _id_69E96A4CAA72D794, lootid);

  return [lootid, _id_338E098F5CBFDA5B];
}

_id_D2ABBCB10A39FF56(lootid) {
  if(!isDefined(self) || !isDefined(self._id_02FA5B49969DEF47) || !isDefined(self._id_02FA5B49969DEF47.origin))
    return [lootid, undefined];

  if(!isDefined(self._id_02FA5B49969DEF47._id_B205D90302DA2F07))
    self._id_02FA5B49969DEF47._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self._id_02FA5B49969DEF47.origin);

  if(!isDefined(self._id_02FA5B49969DEF47._id_B205D90302DA2F07) || self._id_02FA5B49969DEF47._id_B205D90302DA2F07 != "saba_caves")
    return [lootid, undefined];

  _id_0E53E7E4801C9866();
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "hacked_laptop", 1);
  return [8644, 1];
}

_id_0E53E7E4801C9866() {
  if(!isDefined(level._id_1FED93654FA204F8) || !isDefined(level._id_1FED93654FA204F8.origin) || !isDefined(level._id_1FED93654FA204F8.angles)) {
    return;
  }
  _id_6D6612CAAC7C7233 = spawnscriptable("dmz_pmc_place_laptop", level._id_1FED93654FA204F8.origin, level._id_1FED93654FA204F8.angles);
  _id_6D6612CAAC7C7233 _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("espionage_story"));
}

_id_959DC4FE95B93CEA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state != "invisible_usable") {
    return;
  }
  _id_D1768FD36A39517B = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(8644, 1));

  if(!_id_D1768FD36A39517B) {
    player scripts\mp\hud_message::showerrormessage("PMC/DONT_HAVE_HACKED_LAPTOP");
    return;
  }

  instance setscriptablepartstate("dmz_pmc_place_laptop", "visible_unusable");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "planted_hacked_laptop", 1);
}

_id_0492D7C202B56DC1() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_0B6DA601DCCC1197 = [11209, 11208, 11201];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 3; _id_AC0E594AC96AA3A8++) {
    _id_3531236D1A437A5C = scripts\engine\utility::getStruct("puzzle_buried_cache_" + _id_AC0E594AC96AA3A8, "script_noteworthy");
    _id_FA4FFF8AD27727E2 = _id_0B6DA601DCCC1197[_id_AC0E594AC96AA3A8 - 1];

    if(!isDefined(_id_3531236D1A437A5C)) {
      continue;
    }
    _id_B038ED928EC17A81 = spawnscriptable("dmz_geiger_puzzle_container", _id_3531236D1A437A5C.origin, scripts\engine\utility::_id_53C4C53197386572(_id_3531236D1A437A5C.angles, (0, 0, 0)));
    contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(getscriptablelootcachecontents(_id_B038ED928EC17A81));
    _id_521D43CCA02DB88B = [];

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < contents.size; _id_AC0E5C4AC96AAA41++) {
      lootid = contents[_id_AC0E5C4AC96AAA41]["lootID"];

      if(scripts\engine\utility::array_contains(_id_0B6DA601DCCC1197, lootid)) {
        if(lootid == _id_FA4FFF8AD27727E2) {
          contents[_id_AC0E5C4AC96AAA41]["callback"] = ::_id_ECDD376B2A318C49;
          _id_521D43CCA02DB88B[_id_521D43CCA02DB88B.size] = contents[_id_AC0E5C4AC96AAA41];
        }

        continue;
      }

      _id_521D43CCA02DB88B[_id_521D43CCA02DB88B.size] = contents[_id_AC0E5C4AC96AAA41];
    }

    _id_B038ED928EC17A81.contents = scripts\engine\utility::array_randomize(_id_521D43CCA02DB88B);
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
    _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_B038ED928EC17A81);
  }
}

_id_ECDD376B2A318C49(_id_B038ED928EC17A81, player) {
  _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(_id_B038ED928EC17A81);
}

_id_5C7BC3641F80E9DC() {
  level._id_39F292381A9D3BB8 = scripts\engine\utility::getStruct("oilfield_stronghold_entrance", "script_noteworthy");

  if(isDefined(level._id_39F292381A9D3BB8) && !isDefined(level._id_39F292381A9D3BB8.origin))
    level._id_39F292381A9D3BB8 = undefined;
}

_id_53F53A9DD52A16FA(camera) {
  if(!isDefined(camera) || !isDefined(camera.origin)) {
    return;
  }
  if(isDefined(level._id_39F292381A9D3BB8))
    _id_0635937C689EC374(camera);

  if(isDefined(level._id_CCAA9CFD2B7B3856))
    _id_E6FC5A0CC74883EF(camera);

  if(isDefined(level._id_A05F3BD63F29EFF9) && isDefined(level._id_A05F3BD63F29EFF9._id_CC41B5D31D55087B))
    _id_1236E9842DF9AA2F(camera);
}

_id_0635937C689EC374(camera) {
  if(distancesquared(camera.origin, level._id_39F292381A9D3BB8.origin) > 2250000) {
    return;
  }
  _id_02F75059127901DC = scripts\engine\trace::ray_trace(camera.origin, level._id_39F292381A9D3BB8.origin, camera);

  if(_id_02F75059127901DC["fraction"] < 0.99) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "tac_cam_pointing_at_oilfield", 1);
}

_id_5175FA97870923AD() {
  items = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_caves_intel");

  if(!isDefined(items) || items.size == 0) {
    return;
  }
  level._id_446D110C8D4DDFD2 = items[0];
  level._id_FE06B29988DC7C85 = spawnscriptable("dmz_pmc_place_intel", level._id_446D110C8D4DDFD2.origin, level._id_446D110C8D4DDFD2.angles);
  level._id_FE06B29988DC7C85 setscriptablepartstate("dmz_pmc_place_intel", "invisible_unusable");
}

_id_7CFD9E977F412D78(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state != "invisible_usable") {
    return;
  }
  _id_002166BD993A82E3 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(8618, 1));

  if(!_id_002166BD993A82E3) {
    player scripts\mp\hud_message::showerrormessage("PMC/NO_DOCUMENTS_ERR_MSG");
    return;
  }

  instance setscriptablepartstate("dmz_pmc_place_intel", "visible");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "swapped_caves_intel", 1);
}

_id_7868D975EF389ABA() {
  _id_17AD7DD267294331 = _func_F159C10D5CF8F0B4("trigger_water_cave_docks", "script_noteworthy");

  if(!isDefined(_id_17AD7DD267294331) || _id_17AD7DD267294331.size == 0) {
    return;
  }
  _id_E4C7659A84F52978 = _id_17AD7DD267294331[0];

  for(;;) {
    _id_E4C7659A84F52978 waittill("trigger", ent);

    if(!ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      continue;
    }
    if(!ent scripts\cp_mp\vehicles\vehicle::_id_7C62CA52F72901A1()) {
      continue;
    }
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(ent);

    if(!isDefined(driver) || !isDefined(driver.team) || !isPlayer(driver)) {
      continue;
    }
    if(isDefined(_id_E4C7659A84F52978.used) && isDefined(_id_E4C7659A84F52978.used[driver.team])) {
      continue;
    }
    if(!isDefined(_id_E4C7659A84F52978.used))
      _id_E4C7659A84F52978.used = [];

    _id_E4C7659A84F52978.used[driver.team] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "trigger_water_cave_docks", 1);
  }
}

_id_3008315FDF9460B8() {
  _id_3531236D1A437A5C = scripts\engine\utility::getStruct("fortress_sewer_underwater_cache", "script_noteworthy");
  _id_AECE5BD343E9D2DC = scripts\engine\utility::getStructArray("fortress_breaker_interact", "script_noteworthy");

  if(!isDefined(_id_3531236D1A437A5C) || !isDefined(_id_3531236D1A437A5C.origin)) {
    return;
  }
  if(!isDefined(_id_AECE5BD343E9D2DC) || _id_AECE5BD343E9D2DC.size == 0) {
    return;
  }
  level._id_F0223212ED81B749 = [];
  _id_8AF01E9D902B5797 = [(18096, -55514, 731), (16657, -53540, 837), (18114, -54311, 730)];

  foreach(struct in _id_AECE5BD343E9D2DC) {
    _id_05956C54E54EBF3D = 1;

    foreach(origin in _id_8AF01E9D902B5797) {
      if(distance(struct.origin, origin) < 20)
        _id_05956C54E54EBF3D = 0;
    }

    if(_id_05956C54E54EBF3D)
      level._id_F0223212ED81B749[level._id_F0223212ED81B749.size] = struct;
  }

  level._id_D4A11CB7A6A4BC0C = 0;
  level._id_518FAFBD705972FB = spawnscriptable("br_loot_cache_lege", _id_3531236D1A437A5C.origin, scripts\engine\utility::_id_53C4C53197386572(_id_3531236D1A437A5C.angles, (0, 0, 0)));
  level._id_518FAFBD705972FB _id_552B8E4EA5FF7DF1::_id_D683A60016231237(11263, 1);
  level._id_518FAFBD705972FB._id_C93EA8F612F4AABA = 1;
  level._id_DD5EABA9F20B9619 = level._id_518FAFBD705972FB _id_57D3850A12CF1D8F::_id_C4D29F8F054E326B(level._id_518FAFBD705972FB.origin + (0, 0, 20), "generic_no_key");
  level thread _id_280EDF3F47535AE9("trigger_fortress_sewers", "script_noteworthy", "trigger_fortress_sewers", ::_id_FF25C1631A28D8FE);
}

_id_FF25C1631A28D8FE(player) {
  if(istrue(level._id_1171DE670AFDDBEE)) {
    return;
  }
  level._id_1171DE670AFDDBEE = 1;
  level._id_3EDCA7326772514B = [];

  foreach(_id_F1EB9D38C7909EC6 in level._id_F0223212ED81B749)
  level._id_3EDCA7326772514B[level._id_3EDCA7326772514B.size] = spawnscriptable("dmz_pmc_disarm_security", _id_F1EB9D38C7909EC6.origin);

  level._id_66B139A489AF4AAC = player.team;
  level._id_F0223212ED81B749 = undefined;
  playsoundatpos(scripts\engine\utility::random(level._id_3EDCA7326772514B).origin, "mp_dmz_alrm_trap");
  level endon("sewer_event_disabled");
  wait 240;

  if(isDefined(level._id_3EDCA7326772514B)) {
    _id_EA893B6B39485E16 = scripts\engine\utility::random(level._id_3EDCA7326772514B);
    playsoundatpos(_id_EA893B6B39485E16.origin, "mp_dmz_alrm_trap");
    _id_5C7BC997159207B3();
    _id_8AD0DC3070480B2B(_id_EA893B6B39485E16.origin, 6, "saba_fort");
  }
}

_id_8AD0DC3070480B2B(location, num, _id_B205D90302DA2F07) {
  agents = [];
  _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(6, level.spawnset["guard"], 3);
  _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";

  while(!isDefined(agents) || agents.size == 0) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(6, location, "high", "mission", "sewerEvent", undefined, undefined, 1, _id_B205D90302DA2F07, undefined, undefined, undefined, _id_CF2FF249C028B242);

    if(isDefined(agents) && agents.size != 0) {
      break;
    }

    wait 1;
  }
}

_id_4CDD0981528FF098(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance setscriptablepartstate(part, "invisible_unusable");
  player thread _id_7E52B56769FA7774::playerplaypickupanim();
  level._id_3EDCA7326772514B = scripts\engine\utility::array_remove(level._id_3EDCA7326772514B, instance);
  level._id_D4A11CB7A6A4BC0C++;

  if(level._id_D4A11CB7A6A4BC0C == 7)
    _id_66D667A607A545C4();

  _id_8A7A2427622E7572(level._id_66B139A489AF4AAC, "fortress_sewer_breaker_reroute", 1);
}

_id_66D667A607A545C4() {
  level notify("sewer_event_disabled");
  level._id_DD5EABA9F20B9619 _id_57D3850A12CF1D8F::_id_F3B1F1D41C65B340();
  _id_27E49251BB3376EA = undefined;

  foreach(player in scripts\mp\utility\teams::getteamdata(level._id_66B139A489AF4AAC, "players")) {
    if(!isDefined(player) || !isalive(player)) {
      return;
    }
    _id_27E49251BB3376EA = player;
    break;
  }

  if(isDefined(_id_27E49251BB3376EA))
    _id_27E49251BB3376EA calloutmarkerping_create(18, (0, 0, 100), level._id_518FAFBD705972FB.index);

  _id_5C7BC997159207B3();
}

_id_5C7BC997159207B3() {
  if(!isDefined(level._id_3EDCA7326772514B)) {
    return;
  }
  foreach(scriptable in level._id_3EDCA7326772514B)
  scriptable setscriptablepartstate("dmz_pmc_disarm_security", "invisible_unusable");

  level._id_3EDCA7326772514B = undefined;
}

_id_9414CE99A799A309() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  triggers = _func_F159C10D5CF8F0B4("trigger_hydro_gas_station", "script_noteworthy");
  _id_C6CD9D2C6AD18DD6 = _func_F159C10D5CF8F0B4("trigger_radio_tower_hydro", "script_noteworthy");

  if(!isDefined(triggers) || triggers.size == 0 || !isDefined(_id_C6CD9D2C6AD18DD6) || _id_C6CD9D2C6AD18DD6.size == 0) {
    return;
  }
  level._id_FC7BBB62DAF23E2D = [];
  missionid = _id_16AE6D8B5F25F31B("car_bomb_story");

  foreach(trigger in triggers) {
    _id_C1A3F9C508FA9B56 = spawnscriptable("dmz_pmc_hydro_bomb_site_use", trigger.origin);
    _id_C1A3F9C508FA9B56 setscriptablepartstate("dmz_pmc_hydro_bomb_site_use", "usable");
    _id_C1A3F9C508FA9B56 _id_AB5C0B42F31A0D20(missionid);
    level._id_FC7BBB62DAF23E2D[level._id_FC7BBB62DAF23E2D.size] = _id_C1A3F9C508FA9B56;
  }

  _id_C6CD9D2C6AD18DD6 = _id_C6CD9D2C6AD18DD6[0];
  _id_81739BC035AB88E1 = spawnscriptable("dmz_pmc_hydro_tower_use", _id_C6CD9D2C6AD18DD6.origin);
  _id_81739BC035AB88E1 _id_AB5C0B42F31A0D20(missionid);
  level thread _id_98F9CF6481D5A722(triggers);
}

_id_98F9CF6481D5A722(triggers) {
  level._id_E5953799FC4ECE76 = triggers;

  foreach(trigger in level._id_E5953799FC4ECE76)
  trigger thread _id_88E153E1B6916E25();

  for(;;) {
    if(_id_4518B3F7C0343AE4()) {
      foreach(player in level.players)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "parked_vehicles_hydro_gas_station", 1, 0);

      return;
    }

    wait 1;
  }
}

_id_88E153E1B6916E25() {
  self._id_7A27771914A473EB = [];

  for(;;) {
    self waittill("trigger", ent);

    if(!ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      continue;
    }
    if(isDefined(self._id_7A27771914A473EB[ent getentitynumber()])) {
      continue;
    }
    thread _id_CDE3404945DF007C(ent);
  }
}

_id_CDE3404945DF007C(vehicle) {
  entnum = vehicle getentitynumber();
  self._id_7A27771914A473EB[entnum] = vehicle;

  while(isDefined(vehicle) && isDefined(vehicle.origin) && distancesquared(vehicle.origin, self.origin) < 490000)
    wait 1;

  self._id_7A27771914A473EB[entnum] = undefined;
}

_id_4518B3F7C0343AE4() {
  foreach(trigger in level._id_E5953799FC4ECE76) {
    if(trigger._id_7A27771914A473EB.size == 0)
      return 0;
  }

  return 1;
}

_id_69A1E33DFBEE41D2(team) {
  foreach(_id_461EDD0EF0140E86 in level._id_FC7BBB62DAF23E2D) {
    if(!scripts\engine\utility::is_equal(_id_461EDD0EF0140E86.team, team))
      return 0;
  }

  return 1;
}

_id_FFFD723FF4050D8E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "usable") {
    instance setscriptablepartstate(part, "unusable");

    if(istrue(instance._id_8E977040CC228632)) {
      return;
    }
    instance._id_8E977040CC228632 = 1;
    bomb = _id_C795784DBF5F49C5(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(instance, instance, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.planttime) {
      if(instance._id_A4CF15C49F3E9EEF || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
        instance._id_8E977040CC228632 = 0;
        _id_BC3D8A9D8B004ECD(player, bomb);
        instance setscriptablepartstate(part, "usable");
        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    origin = scripts\engine\utility::drop_to_ground(player.origin, 100, undefined, undefined, scripts\engine\trace::create_world_contents()) + (0, 0, 1);
    team = player.team;
    _id_BC3D8A9D8B004ECD(player, bomb);
    instance.plantedbomb = spawnscriptable("dmz_pmc_hydro_bomb", origin);
    instance.team = team;
    instance.used = [];
    instance.used[team] = 1;
    instance _id_9C8EE1FAE2F25458();
    _id_8A7A2427622E7572(team, "planted_bombs_hydro_gas_station", 1);
  } else if(state == "defusable") {
    instance setscriptablepartstate(part, "unusable");

    if(istrue(instance._id_482C2428A4E2FDDC)) {
      return;
    }
    instance._id_482C2428A4E2FDDC = 1;
    instance.plantedbomb setscriptablepartstate("dmz_pmc_hydro_bomb", "invisible");
    bomb = _id_C795784DBF5F49C5(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(instance, instance, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.defusetime) {
      if(instance._id_A4CF15C49F3E9EEF || !isalive(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
        instance._id_482C2428A4E2FDDC = 0;
        _id_BC3D8A9D8B004ECD(player, bomb);
        instance.plantedbomb setscriptablepartstate("dmz_pmc_hydro_bomb", "visible");
        instance _id_9C8EE1FAE2F25458();
        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    instance.team = player.team;
    instance.plantedbomb.origin = scripts\engine\utility::drop_to_ground(player.origin, 100, undefined, undefined, scripts\engine\trace::create_world_contents()) + (0, 0, 1);
    _id_BC3D8A9D8B004ECD(player, bomb);

    if(!isDefined(instance.used[instance.team])) {
      instance.used[instance.team] = 1;
      _id_8A7A2427622E7572(instance.team, "planted_bombs_hydro_gas_station", 1);
    }

    instance.plantedbomb setscriptablepartstate("dmz_pmc_hydro_bomb", "visible");
    instance _id_9C8EE1FAE2F25458();
  }
}

_id_9C8EE1FAE2F25458() {
  self setscriptablepartstate("dmz_pmc_hydro_bomb_site_use", "defusable", 0);

  foreach(player in level.players)
  self enablescriptableplayeruse(player);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  self disablescriptableplayeruse(player);
}

_id_C795784DBF5F49C5(player) {
  player _id_18445FC8F6589865(0);
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1, 1);
  return bomb;
}

_id_BC3D8A9D8B004ECD(player, bomb) {
  lastweaponobj = player scripts\mp\utility\inventory::getlastweapon();

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
  else if(!player hasweapon(lastweaponobj))
    lastweaponobj = player scripts\mp\utility\inventory::getfirstprimaryweapon();

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
  player takeweapon(bomb);
  player _id_18445FC8F6589865(1);
}

_id_18445FC8F6589865(_id_BD138DE99B3B3507) {
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_movement", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "sprint", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "fire", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "reload", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_pickup", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_switch", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "gesture", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "supers", _id_BD138DE99B3B3507);
  self _meth_35501B42058D4DE9();

  if(_id_BD138DE99B3B3507)
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");

  _id_3B64EB40368C1450::set("sam_holding_bomb", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "mantle", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "offhand_weapons", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sam_holding_bomb");
    self _meth_BB04491D50D9E43E();
  }
}

_id_A2B7F3DAFBFFA8DE(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!_id_4518B3F7C0343AE4()) {
    player scripts\mp\hud_message::showerrormessage("PMC/NOT_ALL_GAS_STATIONS_ARE_OCCUPIED");
    return;
  }

  if(!_id_69A1E33DFBEE41D2(player.team)) {
    player scripts\mp\hud_message::showerrormessage("PMC/NOT_ALL_BOMBS_ARE_PLANTED");
    return;
  }

  instance freescriptable();
  player thread scripts\mp\equipment\c4::c4_animdetonate();
  wait 1;

  foreach(bomb in level._id_FC7BBB62DAF23E2D) {
    _id_81C6D95294B1ECE3(bomb.origin, player);
    bomb.plantedbomb freescriptable();
    bomb freescriptable();
  }

  foreach(trigger in level._id_E5953799FC4ECE76) {
    foreach(vehicle in trigger._id_7A27771914A473EB) {
      if(isDefined(vehicle) && !istrue(vehicle.isdestroyed)) {
        data = scripts\cp_mp\utility\damage_utility::packdamagedata(player, vehicle, vehicle.maxhealth, makeweapon("bomb_site_mp"), "MOD_EXPLOSIVE", vehicle, vehicle.origin);
        vehicle scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9(data);
      }
    }
  }

  level._id_FC7BBB62DAF23E2D = undefined;
  level._id_E5953799FC4ECE76 = undefined;
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "detonated_hydro_bombs", 1);
}

_id_81C6D95294B1ECE3(origin, damageent, _id_39A2C4C5962FC158) {
  _id_408F3E834E201526 = origin + (0, 0, 20);
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["samsite_bomb_explosion"], _id_408F3E834E201526);
  _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
  triggerfx(_id_EFDFC6EBE7A152C5);
  physicsexplosionsphere(_id_408F3E834E201526, 200, 100, 3);
  playrumbleonposition("grenade_rumble", origin);
  earthquake(0.25, 0.5, origin, 500);
  playsoundatpos(_id_408F3E834E201526, scripts\engine\utility::_id_53C4C53197386572(_id_39A2C4C5962FC158, "exp_bombsite_lr"));
  radiusdamage(_id_408F3E834E201526, 200, 500, 10, damageent, "MOD_EXPLOSIVE", "bomb_site_mp");
}

_id_B61326CF101FB540() {
  _id_32E92DE34D022079 = scripts\engine\utility::getStructArray("computer_usb_port", "script_noteworthy");

  if(!isDefined(_id_32E92DE34D022079) || _id_32E92DE34D022079.size == 0) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  missionid = _id_16AE6D8B5F25F31B("plant_usb_story");

  foreach(_id_54A79406C5065ED0 in _id_32E92DE34D022079) {
    usb = spawnscriptable("dmz_pmc_place_usb", _id_54A79406C5065ED0.origin, _id_54A79406C5065ED0.angles);
    usb _id_AB5C0B42F31A0D20(missionid);
  }

  level thread _id_315E9C3A5FB405E5(missionid, (22656, -55352, 696), 11262, 3);
}

_id_D7415966D73D5A1E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state != "invisible_usable") {
    return;
  }
  _id_95D1A0691036B3E7 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(11262, 1));

  if(!_id_95D1A0691036B3E7) {
    player scripts\mp\hud_message::showerrormessage("PMC/HACKED_THUMB_DRIVE_REQUIRED");
    return;
  }

  instance setscriptablepartstate(part, "visible_unusable");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "hacked_usb_planted", 1);
}

_id_31B8C224BA19C71D() {
  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    level thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("gps_travel_story"), (4297, -11455, 4590), 11200, 1);
}

_id_28DE1F2851B19254(player, lootid, quantity, _id_69E96A4CAA72D794) {
  if(lootid != 11200) {
    return;
  }
  _id_187F4232DCD3B0E9(player, player._id_DA28916E7827AF7C);
}

_id_187F4232DCD3B0E9(player, _id_B205D90302DA2F07) {
  if(isDefined(player) && isDefined(_id_B205D90302DA2F07)) {
    _id_B23DDA83A49CD36E = scripts\mp\utility\teams::getteamdata(player.team, "gpsPoisVisited");

    if(!isDefined(_id_B23DDA83A49CD36E[_id_B205D90302DA2F07])) {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "gps_poi_travel", 1);
      _id_B23DDA83A49CD36E[_id_B205D90302DA2F07] = 1;
      scripts\mp\utility\teams::setteamdata(player.team, "gpsPoisVisited", _id_B23DDA83A49CD36E);
    }
  }
}

_id_438DAE3E86A38ABA(team) {
  _id_B23DDA83A49CD36E = scripts\mp\utility\teams::getteamdata(team, "gpsPoisVisited");
  return _id_B23DDA83A49CD36E.size == 17;
}

_id_C9FB574BC742A62E() {
  _id_400C962E88747E94 = scripts\engine\utility::getStructArray("caves_tracking_device", "script_noteworthy");
  _id_C2B66B0092CF95C6 = [];

  foreach(struct in _id_400C962E88747E94) {
    if(distance(struct.origin, (-31098, -499.5, 2113)) > 10.0)
      _id_C2B66B0092CF95C6[_id_C2B66B0092CF95C6.size] = struct;
  }

  _id_84A1C60E63EB7AD5 = scripts\engine\utility::getStruct("caves_bunker_server", "script_noteworthy");

  if(!isDefined(_id_C2B66B0092CF95C6) || _id_C2B66B0092CF95C6.size == 0 || !isDefined(_id_84A1C60E63EB7AD5)) {
    return;
  }
  missionid = _id_16AE6D8B5F25F31B("caves_tracking");

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    _id_315E9C3A5FB405E5(missionid, (21286, -16750, 3685), 11206, _id_C2B66B0092CF95C6.size);
  else if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  foreach(_id_3029E9D959D68951 in _id_C2B66B0092CF95C6) {
    _id_5BE082C81F66920A = spawnscriptable("dmz_pmc_place_tracker", _id_3029E9D959D68951.origin, scripts\engine\utility::_id_53C4C53197386572(_id_3029E9D959D68951.angles, (0, 0, 0)));
    _id_5BE082C81F66920A _id_AB5C0B42F31A0D20(missionid);
  }

  _id_56593EBA3D9C2965 = spawnscriptable("dmz_pmc_caves_server_use", _id_84A1C60E63EB7AD5.origin);
  _id_56593EBA3D9C2965 _id_AB5C0B42F31A0D20(missionid);
}

_id_9E928DE0556DD9A1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_761F8B171E80E381 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(11206, 1));

  if(!_id_761F8B171E80E381) {
    player scripts\mp\hud_message::showerrormessage("PMC/NO_TRACKING_DEVICES_IN_BACKPACK");
    return;
  }

  instance setscriptablepartstate(part, "visible_unusable");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "plant_tracker_on_truck", 1);
}

_id_822721B8759D5950(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team) || !isDefined(instance)) {
    return;
  }
  if(isDefined(instance.used) && isDefined(instance.used[player.team])) {
    instance disablescriptableplayeruse(player);
    return;
  }

  if(!isDefined(instance.used))
    instance.used = [];

  instance.used[player.team] = 1;
  instance thread _id_B4B7D5EFF7C75C3C(instance, player);
}

_id_B4B7D5EFF7C75C3C(_id_850AB69BFC46BCF6, player) {
  _id_850AB69BFC46BCF6.curorigin = _id_850AB69BFC46BCF6.origin;
  _id_850AB69BFC46BCF6.offset3d = (0, 0, 15);
  _id_850AB69BFC46BCF6 scripts\mp\gameobjects::requestid(1, 1, undefined, 1, 1);
  objid = _id_850AB69BFC46BCF6.objidnum;
  _id_850AB69BFC46BCF6.curorigin = undefined;
  _id_850AB69BFC46BCF6.offset3d = undefined;

  if(objid == -1) {
    return;
  }
  objective_icon(objid, "ui_map_icon_obj_recon");
  objective_setbackground(objid, 1);
  objective_setzoffset(objid, 15);
  objective_position(objid, _id_850AB69BFC46BCF6.origin + (0, 0, 15));
  objective_setpinned(objid, 1);
  objective_setplayintro(objid, 1);
  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, player.team);
  objective_showtoplayersinmask(objid);
  playerteam = player.team;
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_B2810E8D06E0A042 in players) {
    _id_850AB69BFC46BCF6 disablescriptableplayeruse(_id_B2810E8D06E0A042);
    scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objid, _id_B2810E8D06E0A042, 1, 2, &"PMC/DOWNLOADING_SERVER_DATA");
  }

  wait 3;
  progress = 0;

  while(progress < 1) {
    progress = min(1, progress + level.framedurationseconds / 8);
    objective_setprogress(objid, progress);
    waitframe();
  }

  wait 0.2;

  foreach(_id_B2810E8D06E0A042 in players) {
    if(!isDefined(_id_B2810E8D06E0A042)) {
      continue;
    }
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objid, _id_B2810E8D06E0A042);
  }

  _id_8A7A2427622E7572(playerteam, "caves_server_download", 1);
  _id_850AB69BFC46BCF6 scripts\mp\gameobjects::releaseid();
}

_id_822D31A70ED0BC67() {
  _id_5CD858914520A8A5 = getentitylessscriptablearray("pmc_beach_observatory_toolbox", "script_noteworthy");

  if(!isDefined(_id_5CD858914520A8A5) || _id_5CD858914520A8A5.size != 1) {
    return;
  }
  _id_5CD858914520A8A5 = _id_5CD858914520A8A5[0];
  _id_5CD858914520A8A5 setscriptablepartstate("body", "closed_usable");
  _id_5CD858914520A8A5._id_3E5D613E6F4D92E3 = 1;
  _id_5CD858914520A8A5 _id_552B8E4EA5FF7DF1::_id_D683A60016231237(19247, 1);
}

_id_84247818FC8A16F9(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D) {
  if(_id_A1823E6B1CB4B46D == 6) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_vehicle", 1);
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent)) {
      if(isDefined(ent._id_47BDE44B1ACEC603)) {
        scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_boss", 1);
        return;
      }

      return;
    }
  } else if(_id_A1823E6B1CB4B46D == 4) {
    index = self calloutmarkerping_getgscobjectiveindex(_id_394466C2DDB208CB);

    if(isDefined(index)) {
      found = 0;

      foreach(_id_D233486A875A4BA8 in level._id_A1141D47AB94D2A1) {
        if(isDefined(_id_D233486A875A4BA8) && isDefined(_id_D233486A875A4BA8._id_107D6E8FC82A82A8) && isDefined(_id_D233486A875A4BA8._id_107D6E8FC82A82A8.objidnum) && index == _id_D233486A875A4BA8._id_107D6E8FC82A82A8.objidnum) {
          scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_uav_tower", 1);
          found = 1;
          break;
        }
      }

      if(!found) {
        foreach(_id_9329E0D3CE1D5CA8 in level._id_6A4C9FBD7AA58544) {
          foreach(_id_0566868292EE2A1B in _id_9329E0D3CE1D5CA8.instances) {
            if(isDefined(_id_0566868292EE2A1B.objidnum) && _id_0566868292EE2A1B.objidnum == index) {
              scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_boss", 1);
              found = 1;
              break;
            }
          }

          if(found) {
            break;
          }
        }

        return;
      }

      return;
    }
  } else if(_id_A1823E6B1CB4B46D == 22) {
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent) && isDefined(ent.type) && ent.type == "dmz_uav_tower")
      scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_uav_tower", 1);

    if(isDefined(ent) && isDefined(ent.type) && ent.type == "pmc_cartel_cargo") {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "pmc_pinged_cartel_cargo", 1);
      return;
    }
  } else if(_id_A1823E6B1CB4B46D == 9) {
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isagent(ent) || isPlayer(ent)) {
      if(isDefined(ent.agent_type)) {
        _id_1C9CB43BCF3EB16D = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("ai_mp_controller", "agentPers_getAgentPersData", ent, "subcategory");

        if(scripts\cp_mp\challenges::_id_C7496288999AC847(ent.agent_type, _id_1C9CB43BCF3EB16D))
          scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_cartel_member", 1);
      }

      scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_enemy", 1);

      if(isDefined(ent._id_47BDE44B1ACEC603))
        scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "ping_boss", 1);
    }
  }
}

_id_903A764DA8E3DB20(vehicle, _id_5E91B6FE3674E856) {
  if(!_id_6F6CC16C0528DE5B(self)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "gas_can_refuel", 1);

  if(istrue(_id_5E91B6FE3674E856))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "refuel_palfa", 1);
}

_id_36A84463A20F549C(vehicle, _id_5E91B6FE3674E856) {
  if(!_id_6F6CC16C0528DE5B(self) || !isDefined(vehicle) || istrue(_id_5E91B6FE3674E856)) {
    return;
  }
  if(!isDefined(vehicle._id_46708A9A93D3DD28))
    vehicle._id_46708A9A93D3DD28 = [];

  id = scripts\mp\utility\player::getuniqueid();

  if(istrue(vehicle._id_46708A9A93D3DD28[id])) {
    return;
  }
  vehicle._id_46708A9A93D3DD28[id] = 1;
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "siphon_gas", 1);
}

_id_1236E9842DF9AA2F(camera) {
  foreach(locname, struct in level._id_A05F3BD63F29EFF9._id_CC41B5D31D55087B) {
    _id_82FFC17C45523D42 = struct.useprompt.trigger;

    if(ispointinvolume(camera.origin, _id_82FFC17C45523D42))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "plant_camera_" + locname, 1);
  }
}

_id_B09C81EA055C4C31() {
  _id_CCAA9CFD2B7B3856 = scripts\engine\utility::getStructArray("pmc_smuggling_tunnel_entrance", "script_noteworthy");

  if(!isDefined(_id_CCAA9CFD2B7B3856) || _id_CCAA9CFD2B7B3856.size == 0) {
    return;
  }
  level._id_CCAA9CFD2B7B3856 = _id_CCAA9CFD2B7B3856;
  level thread _id_280EDF3F47535AE9("pmc_smuggling_tunnels_trigger", "script_noteworthy", "locate_smuggling_tunnels");
}

_id_E6FC5A0CC74883EF(camera) {
  _id_4F99FC3CCB1614DE = sortbydistance(level._id_CCAA9CFD2B7B3856, camera.origin)[0];

  if(!isDefined(camera.ownerteam)) {
    return;
  }
  if(!isDefined(_id_4F99FC3CCB1614DE.used))
    _id_4F99FC3CCB1614DE.used = [];

  if(isDefined(_id_4F99FC3CCB1614DE.used[camera.ownerteam])) {
    return;
  }
  if(distancesquared(camera.origin, _id_4F99FC3CCB1614DE.origin) > 360000) {
    return;
  }
  _id_4F99FC3CCB1614DE.used[camera.ownerteam] = 1;
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "plant_tac_cam_smuggling_tunnels", 1);
}

_id_4D56964AE4EA5796(player) {
  if(!isDefined(player.team))
    return 0;

  if(!isDefined(self._id_68FA0B06CBF0A443))
    self._id_68FA0B06CBF0A443 = [];

  if(scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    if(istrue(level._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid])) {
      level thread _id_1115D65BD80653E6(self, player, 10000, "upload_reset_lasers", ::_id_3CE8C941726C2400);
      return 1;
    }
  }

  _id_4E55FC12323FF73E = _id_16AE6D8B5F25F31B("microphone_story");

  if(_id_C5E0BAC8F123CC88(player.team, _id_4E55FC12323FF73E)) {
    if(istrue(scripts\mp\utility\teams::getteamdata(player.team, "placed_microphone"))) {
      duration = 10000;
      _id_9D0C2841C15D2FCC = "upload_eavesdropped_audio";
      level thread _id_1115D65BD80653E6(self, player, duration, _id_9D0C2841C15D2FCC);
      return 1;
    }
  }

  if(isDefined(self._id_B205D90302DA2F07)) {
    if(_id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("radio_uploads_story"))) {
      if((self._id_B205D90302DA2F07 == "sealion_coastalruins" || self._id_B205D90302DA2F07 == "sealion_residential" || self._id_B205D90302DA2F07 == "saba_observatory") && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(19224)) {
        switch (self._id_B205D90302DA2F07) {
          case "sealion_coastalruins":
            duration = 45000;
            _id_9D0C2841C15D2FCC = "upload_legion_intel_2";
            break;
          case "sealion_residential":
            duration = 60000;
            _id_9D0C2841C15D2FCC = "upload_legion_intel_3";
            break;
          default:
            duration = 30000;
            _id_9D0C2841C15D2FCC = "upload_legion_intel_1";
            break;
        }

        level thread _id_1115D65BD80653E6(self, player, duration, _id_9D0C2841C15D2FCC);
        return 1;
      }
    }

    _id_4E21105A6086A3A7 = _id_16AE6D8B5F25F31B("letter_upload_story");

    if(_id_C5E0BAC8F123CC88(player.team, _id_4E21105A6086A3A7)) {
      level thread _id_1115D65BD80653E6(self, player, 30000, "upload_mysterious_letter");
      return 1;
    }

    if(_id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("phalanx_harddrive_story"))) {
      if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(32166) && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(32132)) {
        level thread _id_1115D65BD80653E6(self, player, 30000, "upload_title_deed_drives_success");
        return 1;
      }
    }

    if(_id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("upload_konni_harddrive"))) {
      if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(32131) && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(32168)) {
        level thread _id_1115D65BD80653E6(self, player, 30000, "upload_russian_hard_drive_to_shadow_company");
        return 1;
      }
    }

    if(_id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("hdd_upload_story"))) {
      if(self._id_B205D90302DA2F07 == "saba_observatory" && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(21648)) {
        level thread _id_1115D65BD80653E6(self, player, 60000, "upload_eavesdropped_audio");
        return 1;
      }
    }
  }

  return 0;
}

_id_1115D65BD80653E6(instance, player, duration, _id_9D0C2841C15D2FCC, _id_35203142D72CDC41) {
  _id_0C00335A7AEB2728::_id_94F937F05D8740C8(instance, player);

  if(!istrue(instance._id_B14A331BA425C286)) {
    return;
  }
  instance._id_68FA0B06CBF0A443[player.guid] = 1;
  _id_45ACCC7124BE3725 = spawnStruct();
  _id_45ACCC7124BE3725._id_BF7F7683EA10DA26 = ::_id_6012AFFE882A1565;
  _id_45ACCC7124BE3725._id_35203142D72CDC41 = _id_35203142D72CDC41;
  _id_45ACCC7124BE3725.instance = instance;
  _id_45ACCC7124BE3725._id_9D0C2841C15D2FCC = _id_9D0C2841C15D2FCC;
  _id_45ACCC7124BE3725.origin = instance.origin;
  _id_45ACCC7124BE3725 _id_D3428EBFDA80EDEB("ui_map_icon_obj_intel", (0, 0, 50));
  _id_45ACCC7124BE3725 thread _id_0C00335A7AEB2728::_id_66998E5E0034B2BB(player.team, instance, _id_45ACCC7124BE3725.objidnum, duration);
}

_id_6012AFFE882A1565(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);

  scripts\mp\gameobjects::releaseid();
  _id_8A7A2427622E7572(team, self._id_9D0C2841C15D2FCC, 1);

  if(isDefined(self._id_35203142D72CDC41))
    [[self._id_35203142D72CDC41]](self._id_21280A92D9373B6F);

  self notify("task_ended");
}

_id_A3E1795E126D3738(player) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "plant_tac_cam_core_room", 1);
}

_id_800F75FE5E5C7462(player, _id_B35522AE1F278555) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  if(isDefined(_id_B35522AE1F278555._id_B205D90302DA2F07)) {
    if(_id_B35522AE1F278555._id_B205D90302DA2F07 == "sealion_castle")
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "trigger_trapper_trap", 1);
  }
}

_id_EC8A620F07DBCB21() {
  level endon("game_ended");

  if(!scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2()) {
    return;
  }
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  _id_AAF949C4C3315031 = [];
  _id_39DE31482AB57867 = getEnt("lv1_generator_room", "script_noteworthy");

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.guid) && isalive(player) && !isDefined(_id_AAF949C4C3315031[player.guid]) && player istouching(_id_39DE31482AB57867)) {
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "locate_generator_room", 1);
        _id_AAF949C4C3315031[player.guid] = 1;
      }
    }

    wait 1.0;
  }
}

_id_51B995F0FA4575C5(player, isenemy) {
  if(!isenemy) {
    return;
  }
  minspeed = getdvarfloat("dvar_0E85D50EF5E31422", 10);

  if(self vehicle_getspeed() < minspeed) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "pop_enemy_player_vehicle_tire", 1);
}

_id_454A887CA7C6A0A5(damagedata) {
  if(!isDefined(damagedata) || !isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }
  if(!scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, damagedata.attacker)) {
    return;
  }
  minspeed = getdvarfloat("dvar_0E85D50EF5E31422", 10);

  if(self vehicle_getspeed() < minspeed) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(damagedata.attacker, "shatter_enemy_vehicle_window", 1);
}

_id_A2974FE01BA0959C(player, exfilstruct) {
  if(!isDefined(self._id_63E7335083210B7A))
    self._id_63E7335083210B7A = [];

  if(isDefined(self._id_63E7335083210B7A[player.team])) {
    return;
  }
  self._id_63E7335083210B7A[player.team] = 1;
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "signal_any_exfil", 1);

  if(istrue(exfilstruct._id_5FDA164731E59C13)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "signal_unique_exfil", 1);
}

_id_825C9CA2BBC7169F() {
  level thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("exfil_tracking_story"), (-8980, 4681, 405), 11206, 4);
}

_id_31EE7BE73C6305ED(_id_7E6513B2AE0D5C1D) {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    return;
  }
  _id_6CFD049D9A6F1D75 = spawnscriptable("dmz_pmc_place_exfil_tracker", self.origin);
  _id_6CFD049D9A6F1D75._id_7E6513B2AE0D5C1D = _id_7E6513B2AE0D5C1D;
  _id_6CFD049D9A6F1D75 scripts\common\utility::_id_6E506F39F121EA8A(self, (-150, 105, -211.5), (180, 270, 20));
  _id_6CFD049D9A6F1D75 _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("exfil_tracking_story"));

  if(isDefined(self._id_1E897AE1C018B2C2)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self._id_1E897AE1C018B2C2, "players"))
    _id_6CFD049D9A6F1D75 disablescriptableplayeruse(player);
  }
}

_id_8DB9F46C5668C0AF(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_761F8B171E80E381 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(11206, 1));

  if(!_id_761F8B171E80E381) {
    player scripts\mp\hud_message::showerrormessage("PMC/NO_TRACKING_DEVICES_IN_BACKPACK");
    return;
  }

  instance setscriptablepartstate(part, "visible_unusable");
  event = scripts\engine\utility::ter_op(istrue(instance._id_7E6513B2AE0D5C1D), "final_exfil_heli_plant", "exfil_heli_plant");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, event, 1);
}

_id_81365960BE26E970() {
  _id_3531236D1A437A5C = scripts\engine\utility::getStruct("pmc_boating_and_entering_cache", "script_noteworthy");

  if(!isDefined(_id_3531236D1A437A5C) || !isDefined(_id_3531236D1A437A5C.origin)) {
    return;
  }
  level._id_9E5144FE5A8D9020 = 0;
  level._id_F9DC2C104AD6D123 = spawnscriptable("br_loot_cache_lege", _id_3531236D1A437A5C.origin, scripts\engine\utility::_id_53C4C53197386572(_id_3531236D1A437A5C.angles, (0, 0, 0)));
  level._id_F9DC2C104AD6D123 _id_552B8E4EA5FF7DF1::_id_D683A60016231237(19241, 1);
  level._id_F9DC2C104AD6D123._id_C93EA8F612F4AABA = 1;
  level._id_E64E215320EA7CA1 = level._id_F9DC2C104AD6D123 _id_57D3850A12CF1D8F::_id_C4D29F8F054E326B(level._id_F9DC2C104AD6D123.origin + (0, 0, 20), "generic_no_key");
}

_id_C10AF6C88EE96F56(player) {
  if(istrue(level._id_02C791A3626339E6)) {
    return;
  }
  level._id_02C791A3626339E6 = 1;
  level endon("caves_event_disabled");
  level._id_2D313239A1FEDC04 = player.team;
  playerorigin = player.origin;
  wait 2;
  playsoundatpos(sortbydistance(level._id_12177FADDACF1082, playerorigin)[0].origin, "mp_dmz_alrm_trap");
  wait 180;
  _id_E469BCF32854CC04();
  _id_BF12FBEEC276ACBE = sortbydistance(level._id_12177FADDACF1082, (-3642.89, -94.2525, 433.417))[0];
  playsoundatpos(_id_BF12FBEEC276ACBE.origin, "mp_dmz_alrm_trap");
  _id_8AD0DC3070480B2B(_id_BF12FBEEC276ACBE.origin, 6, "sealion_beachclub");
}

_id_71B0774FB2E6261F(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(level._id_12177FADDACF1082)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level._id_12177FADDACF1082, instance)) {
    return;
  }
  if(!isDefined(level._id_F9DC2C104AD6D123)) {
    return;
  }
  if(istrue(instance.used)) {
    return;
  }
  instance.used = 1;
  player thread _id_7E52B56769FA7774::playerplaypickupanim();
  level thread _id_C10AF6C88EE96F56(player);
  level._id_9E5144FE5A8D9020++;

  if(level._id_9E5144FE5A8D9020 >= 9)
    level thread _id_3A8DEBA1C5443F74();

  _id_8A7A2427622E7572(level._id_2D313239A1FEDC04, "sealion_electric_breaker", 1);
}

_id_E469BCF32854CC04() {
  foreach(scriptable in level._id_12177FADDACF1082) {
    state = scriptable getscriptablepartstate("electrical_box");

    if(state == "on") {
      scriptable setscriptablepartstate("electrical_box", "unusable_on");
      continue;
    }

    if(state == "off")
      scriptable setscriptablepartstate("electrical_box", "unusable_off");
  }
}

_id_3A8DEBA1C5443F74() {
  level notify("caves_event_disabled");
  level._id_E64E215320EA7CA1 _id_57D3850A12CF1D8F::_id_F3B1F1D41C65B340();
  _id_27E49251BB3376EA = undefined;

  foreach(player in scripts\mp\utility\teams::getteamdata(level._id_2D313239A1FEDC04, "players")) {
    if(!isDefined(player) || !isalive(player)) {
      return;
    }
    _id_27E49251BB3376EA = player;
    break;
  }

  if(isDefined(_id_27E49251BB3376EA))
    _id_27E49251BB3376EA calloutmarkerping_create(18, (0, 0, 100), level._id_F9DC2C104AD6D123.index);

  waittillframeend;
  _id_E469BCF32854CC04();
}

_id_FE20DC47D6A83B30() {
  level thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("biolabs_harddrive_story"), (-8980, 4681, 405), 19240, 1);
}

_id_8305DF6D2C121ACB() {
  _id_651C7AB3F07B0718 = scripts\engine\utility::getStruct("pmc_server_room_computer", "script_noteworthy");

  if(!isDefined(_id_651C7AB3F07B0718)) {
    return;
  }
  level._id_0ADC92E54D3179AF = spawnscriptable("dmz_pmc_place_harddrive", _id_651C7AB3F07B0718.origin, _id_651C7AB3F07B0718.angles);
  level._id_0ADC92E54D3179AF _id_D3428EBFDA80EDEB("ui_map_icon_obj_intel", (0, 0, 5));
  level._id_0ADC92E54D3179AF thread _id_C1C1F536AB7B9C6B();
}

_id_23B4BC828CD125EA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _id_08DF84BA9405587B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_08DF84BA9405587B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  _id_0870B7252D19B6B4 = 0;
  _id_CF727733E585E945 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(19240, 1));

  if(!_id_CF727733E585E945) {
    _id_0870B7252D19B6B4 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(19241, 1));

    if(!_id_0870B7252D19B6B4) {
      player scripts\mp\hud_message::showerrormessage("PMC_S2/CANT_USE_THIS");
      return;
    }
  }

  player thread _id_7E52B56769FA7774::playerplaypickupanim();
  instance setscriptablepartstate(part, "visible_unusable");
  objidnum = level._id_0ADC92E54D3179AF.objidnum;
  level._id_9629782FE725D345 = player.team;
  scripts\mp\objidpoolmanager::objective_teammask_single(objidnum, player.team);
  instance notify("download_started");
  instance thread _id_2AE7954A827CF6A1();
  progress = 0;
  _id_F26D6E29F4EFC048 = 0;

  while(progress < 150) {
    if(level._id_CAE5A4EFC6320920.size > 0)
      progress = progress + level.framedurationseconds;

    if(_id_F26D6E29F4EFC048 < 1 && progress > 4) {
      _id_022FA1E423C72C2A(1250);
      _id_F26D6E29F4EFC048 = 1;
    } else if(_id_F26D6E29F4EFC048 < 2 && progress > 50) {
      _id_022FA1E423C72C2A(2500);
      _id_F26D6E29F4EFC048 = 2;
    } else if(_id_F26D6E29F4EFC048 < 3 && progress > 100) {
      _id_022FA1E423C72C2A(4000);
      _id_F26D6E29F4EFC048 = 3;
    }

    objective_setprogress(objidnum, clamp(progress / 150, 0, 1));
    waitframe();
  }

  foreach(_id_6B8130899CD021F4 in level._id_CAE5A4EFC6320920)
  scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, _id_6B8130899CD021F4);

  instance notify("download_ended");
  instance setscriptablepartstate(part, "invisible_unusable");
  _id_A620CB0E6444887F = scripts\engine\utility::ter_op(_id_CF727733E585E945, "brloot_black_mous_harddrive_downloaded", "brloot_experiment_harddrive_decrypted");
  _id_776F4D5DCB35850F = spawnscriptable(_id_A620CB0E6444887F, instance.origin, instance.angles);
  _id_7E52B56769FA7774::registerscriptableinstance(_id_776F4D5DCB35850F);
  _id_776F4D5DCB35850F._id_BBC200BC77C5DB2B = 1;

  while(isDefined(_id_776F4D5DCB35850F))
    waitframe();

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objidnum);
  wait 2;
  instance thread _id_C1C1F536AB7B9C6B();
  instance setscriptablepartstate(part, "invisible_usable");
}

_id_022FA1E423C72C2A(radius) {
  playsoundatpos(level._id_0ADC92E54D3179AF.origin, "mp_dmz_alrm_trap");
  _id_48814951E916AF89::_id_353FECD1549F5F42(level._id_0ADC92E54D3179AF.origin, radius, level._id_4B195D3DD0024B9C, 4);
}

_id_2AE7954A827CF6A1() {
  self endon("download_ended");
  origin = level._id_0ADC92E54D3179AF.origin;
  objidnum = level._id_0ADC92E54D3179AF.objidnum;
  level._id_CAE5A4EFC6320920 = [];

  for(;;) {
    _id_C8DADD43AEFDC396 = [];

    foreach(player in level.players) {
      if(isDefined(player.origin) && scripts\engine\utility::is_equal(player.team, level._id_9629782FE725D345) && distancesquared(origin, player.origin) < 122500)
        _id_C8DADD43AEFDC396[_id_C8DADD43AEFDC396.size] = player;
    }

    _id_0E34E332590AC462 = scripts\engine\utility::array_difference(_id_C8DADD43AEFDC396, level._id_CAE5A4EFC6320920);
    _id_EA6B4EEEAEA5CDC3 = scripts\engine\utility::array_difference(level._id_CAE5A4EFC6320920, _id_C8DADD43AEFDC396);

    foreach(player in _id_0E34E332590AC462)
    scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objidnum, player, 2, 2, &"DMZ/UPLOAD_STATION_PROGRESS");

    foreach(player in _id_EA6B4EEEAEA5CDC3)
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, player);

    level._id_CAE5A4EFC6320920 = _id_C8DADD43AEFDC396;
    wait 1;
  }
}

_id_C1C1F536AB7B9C6B() {
  self endon("download_started");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players)
  self disablescriptableplayeruse(player);

  origin = level._id_0ADC92E54D3179AF.origin;
  objidnum = level._id_0ADC92E54D3179AF.objidnum;
  _id_436336AFA9E7C28A = [];

  for(;;) {
    _id_B39A5638271F4B06 = [];

    foreach(player in level.players) {
      if(isDefined(player.origin) && distancesquared(origin, player.origin) < 122500 && (player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(19240) || player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(19241)))
        _id_B39A5638271F4B06[_id_B39A5638271F4B06.size] = player;
    }

    _id_0196224C27CA169C = scripts\engine\utility::array_difference(_id_B39A5638271F4B06, _id_436336AFA9E7C28A);
    _id_E46940998B5C5ECA = scripts\engine\utility::array_difference(_id_436336AFA9E7C28A, _id_B39A5638271F4B06);

    foreach(player in _id_0196224C27CA169C)
    self enablescriptableplayeruse(player);

    foreach(player in _id_E46940998B5C5ECA)
    self disablescriptableplayeruse(player);

    _id_436336AFA9E7C28A = _id_B39A5638271F4B06;
    wait 1;
  }
}

_id_BDFD9501E21E7259() {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    return;
  }
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::_id_2F274301F86D64E0);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_train_tracking_placement", ::_id_10545602CD6CF0A9);
  missionid = _id_16AE6D8B5F25F31B("track_train_story");
  level thread _id_315E9C3A5FB405E5(missionid, (22656, -55352, 696), 11206, 9);

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  scripts\engine\utility::flag_wait("wztrain_scriptables_spawned");

  foreach(scriptable in getentitylessscriptablearray(undefined, undefined, undefined, undefined, "dmz_train_tracking_placement")) {
    scriptable setscriptablepartstate("dmz_train_tracking_placement", "invisible_usable");
    scriptable _id_AB5C0B42F31A0D20(missionid);
  }
}

_id_10545602CD6CF0A9(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(11206, 1))) {
    player scripts\mp\hud_message::showerrormessage("PMC/NO_TRACKING_DEVICES_IN_BACKPACK");
    return;
  }

  instance setscriptablepartstate(part, "visible_unusable");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "plant_tracker_cargo_train", 1);
}

_id_2F274301F86D64E0(params) {
  self endon("disconnect");

  if(!isDefined(self.team) || !_id_C5E0BAC8F123CC88(self.team, _id_16AE6D8B5F25F31B("track_train_story"))) {
    return;
  }
  scripts\engine\utility::flag_wait("wztrain_array_set");
  _id_6B111DC033D6F700 = undefined;

  for(;;) {
    _id_357562058EA1C391 = scripts\cp_mp\utility\train_utility::_id_31156831AFC882AD();

    if(isDefined(_id_357562058EA1C391) && !scripts\engine\utility::is_equal(_id_357562058EA1C391, _id_6B111DC033D6F700) && _id_357562058EA1C391 == "cargo_train") {
      scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "get_on_cargo_train", 1);
      return;
    }

    _id_6B111DC033D6F700 = _id_357562058EA1C391;
    wait 1;
  }
}

_id_3CB0E100C1DC6F26() {
  level thread _id_280EDF3F47535AE9("pmc_sealion_castle_trigger", "script_noteworthy", "locate_sealion_castle");
}

_id_CAABC88D74AE0AE3() {
  level thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("instructions_story"), (22656, -55352, 696), 19233, 1);
}

_id_47C562560E28EBC7() {
  _id_10EA8A6407D668DA = scripts\engine\utility::getStruct("pmc_atc_console", "script_noteworthy");

  if(!isDefined(_id_10EA8A6407D668DA)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  prompt = spawnscriptable("dmz_pmc_call_in_plane", _id_10EA8A6407D668DA.origin);
  prompt _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("destroy_plane_story"));
}

_id_0969B576411F99AD(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team) || !_id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("destroy_plane_story"))) {
    player scripts\mp\hud_message::showerrormessage("PMC_S2/CANT_USE_THIS");
    instance disablescriptableplayeruse(player);
    return;
  }

  instance setscriptablepartstate(part, "invisible_unusable");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "destroy_plane_call_in", 1);
  level thread _id_0700E4F86FF237DB();
}

_id_0700E4F86FF237DB() {
  plane = _id_79D4B1C751A51F03::_id_9C57F5D58C4333CE();
  plane setscriptablepartstate("objective", "active_red");
  plane endon("deleted");
  plane waittill("plane_hit", team);
  _id_8A7A2427622E7572(team, "destroy_plane_destroy", 1);
}

_id_DE99E97CBC765508() {
  bomb = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_explosive_charge");
  destination = scripts\engine\utility::getStruct("pmc_transporter_bombsite", "script_noteworthy");

  if(!isDefined(bomb) || bomb.size == 0 || !isDefined(destination)) {
    return;
  }
  level._id_58EA889CD5F8AE84 = bomb[0];
  destination.site = spawnscriptable("dmz_supply_site", destination.origin, destination.angles);
  level._id_04B66829E86ADA86 = destination;
  destination.prompt = spawnscriptable("dmz_pmc_transporter_plant", destination.origin);
  level._id_A3F54943D4B96DA2 = spawn("script_origin", level._id_58EA889CD5F8AE84.origin);
  level._id_A3F54943D4B96DA2 thread _id_63603418E8AA6CFA();

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  destination.prompt _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("transport_bomb_story"));
}

_id_63603418E8AA6CFA() {
  self endon("delete");
  destination = level._id_04B66829E86ADA86;

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  endtime = gettime() + 300000;
  _id_95390AEFE43F2FC7 = [];
  _id_95390AEFE43F2FC7[10000] = ["dmz_bombsite_warning_beep_05", 0.5];
  _id_95390AEFE43F2FC7[30000] = ["dmz_bombsite_warning_beep_04", 1.5];
  _id_95390AEFE43F2FC7[60000] = ["dmz_bombsite_warning_beep_03", 3];
  _id_95390AEFE43F2FC7[150000] = ["dmz_bombsite_warning_beep_02", 5];
  _id_95390AEFE43F2FC7[300000] = ["dmz_bombsite_warning_beep_01", 7];
  _id_1D24D18E8F904D2D = [];

  while(gettime() < endtime) {
    _id_8DD9F2EB8215A139 = endtime - gettime();
    sound = undefined;
    waittime = undefined;

    foreach(time, _id_D41B4DEF32764658 in _id_95390AEFE43F2FC7) {
      if(_id_8DD9F2EB8215A139 <= time) {
        sound = _id_D41B4DEF32764658[0];
        waittime = _id_D41B4DEF32764658[1];
        break;
      }
    }

    if(soundexists(sound))
      self playSound(sound);

    wait(waittime);

    if(isDefined(level._id_75434AA809A31EB6) && isDefined(level._id_75434AA809A31EB6.team) && !istrue(_id_1D24D18E8F904D2D[level._id_75434AA809A31EB6.team]) && distance(self.origin, destination.origin) < 200) {
      _id_1D24D18E8F904D2D[level._id_75434AA809A31EB6.team] = 1;
      scripts\cp_mp\challenges::_id_8359CADD253F9604(level._id_75434AA809A31EB6, "transport_bomb_plant", 1);
    }
  }

  _id_81C6D95294B1ECE3(self.origin, self);
  destination.prompt setscriptablepartstate("dmz_pmc_transporter_plant", "invisible_unusable");

  if(distance(self.origin, destination.origin) < 200) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(level._id_75434AA809A31EB6, "transport_bomb_explode", 1);
    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["bombsite_explosion"], destination.origin);
    _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
    triggerfx(_id_EFDFC6EBE7A152C5);
    physicsexplosionsphere(destination.origin, 200, 100, 3);
    playrumbleonposition("grenade_rumble", self.origin);
    earthquake(0.75, 2.0, self.origin, 2000);
    destination.site setscriptablepartstate("dmz_supply_site", "destroyed");
  }

  self delete();

  if(!isDefined(level._id_58EA889CD5F8AE84)) {
    return;
  }
  if(isent(level._id_58EA889CD5F8AE84) && isPlayer(level._id_58EA889CD5F8AE84))
    level._id_58EA889CD5F8AE84 _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(19215, 1);
  else if(isDefined(level._id_58EA889CD5F8AE84._id_556DB0B72A96514E)) {
    if(!isDefined(level._id_75434AA809A31EB6) || !isDefined(level._id_75434AA809A31EB6.guid)) {
      return;
    }
    guid = level._id_75434AA809A31EB6.guid;

    if(!isDefined(level._id_58EA889CD5F8AE84._id_556DB0B72A96514E[guid]) || !isDefined(level._id_58EA889CD5F8AE84._id_556DB0B72A96514E[guid].contents)) {
      return;
    }
    foreach(index, item in level._id_58EA889CD5F8AE84._id_556DB0B72A96514E[guid].contents) {
      if(item["lootID"] == 19215) {
        level._id_58EA889CD5F8AE84._id_556DB0B72A96514E[guid].contents[index]["lootID"] = 0;
        level._id_58EA889CD5F8AE84._id_556DB0B72A96514E[guid].contents[index]["quantity"] = 0;
      }
    }
  } else if(isDefined(level._id_58EA889CD5F8AE84.contents)) {
    foreach(index, item in level._id_58EA889CD5F8AE84.contents) {
      if(item["lootID"] == 19215) {
        level._id_58EA889CD5F8AE84.contents[index]["lootID"] = 0;
        level._id_58EA889CD5F8AE84.contents[index]["quantity"] = 0;
      }
    }
  } else if(level._id_58EA889CD5F8AE84 _meth_73CC0F04C4C5001D()) {
    _id_7E52B56769FA7774::deregisterscriptableinstance(level._id_58EA889CD5F8AE84);
    level._id_58EA889CD5F8AE84 freescriptable();
  }
}

_id_80E7BBF0A2202B9B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_E2695A141B4F2BC3 = player _id_2D9D24F7C63AC143::_id_E05897F5D860188E(19215, undefined, 1);

  if(!isDefined(_id_E2695A141B4F2BC3)) {
    player scripts\mp\hud_message::showerrormessage("PMC_S2/PLACE_ERR_MSG");
    return;
  }

  player thread _id_7E52B56769FA7774::quickdropitem(10, _id_E2695A141B4F2BC3);
}

_id_3340318A370A7CB2(params) {
  if(scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2())
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "infil_biolabs", 1);

  if(scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E())
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "infil_biobunker", 1);
}

ondisconnect(params) {
  if(getdvarint("dvar_8F63416F53600636", 1)) {
    return;
  }
  if(_id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(21646))
    _id_56F9B7D959B1704B();

  if(_id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(19215))
    _id_239568CA276A3AE6();
}

_id_239568CA276A3AE6() {
  if(!isDefined(self) || !isDefined(self.origin)) {
    _id_FCCEB181033EE1EF();
    return;
  }

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(self.origin, self.angles);
  bomb = _id_7E52B56769FA7774::spawnpickup("brloot_explosive_charge", _id_CB4FAD49263E20C4, 1);
  _id_2BA521E376D3E4A5(bomb, self, _id_CB4FAD49263E20C4.origin);
}

_id_FCCEB181033EE1EF() {
  level._id_A3F54943D4B96DA2 notify("delete");
  return 0;
}

_id_D3AC71D99075CECD(player, item) {
  level._id_A3F54943D4B96DA2 notify("delete");
}

_id_2BA521E376D3E4A5(scriptable, owner, _id_D7A9FDC121364C8D) {
  level._id_A3F54943D4B96DA2 unlink();

  if(isDefined(_id_D7A9FDC121364C8D))
    level._id_A3F54943D4B96DA2.origin = _id_D7A9FDC121364C8D;

  if(isDefined(scriptable) && isDefined(scriptable._id_BF8E5F003146AF44))
    level._id_A3F54943D4B96DA2 linkTo(scriptable._id_BF8E5F003146AF44);

  level._id_58EA889CD5F8AE84 = scriptable;

  if(distance(scriptable.origin, level._id_04B66829E86ADA86.origin) < 200)
    playsoundatpos(scriptable.origin, "dmz_mission_bomb_arm");
}

_id_E71CA8A81F647309(_id_69E96A4CAA72D794, owner) {
  level._id_A3F54943D4B96DA2 unlink();

  if(isDefined(_id_69E96A4CAA72D794)) {
    if(isDefined(_id_69E96A4CAA72D794.origin))
      level._id_A3F54943D4B96DA2.origin = _id_69E96A4CAA72D794.origin;

    if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
      level._id_A3F54943D4B96DA2 linkTo(_id_69E96A4CAA72D794._id_BF8E5F003146AF44);
  }

  level._id_58EA889CD5F8AE84 = _id_69E96A4CAA72D794;
}

_id_FE936CA269BD714D(_id_5793A0CF9D352C92, lootid) {
  if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47.origin) && isDefined(self.team)) {
    _id_FCCEB181033EE1EF();
    return _id_A28E5FE14B06DE35(self._id_02FA5B49969DEF47, 19215);
  }

  level._id_A3F54943D4B96DA2 unlink();

  if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47.origin))
    level._id_A3F54943D4B96DA2.origin = self._id_02FA5B49969DEF47.origin;

  level._id_58EA889CD5F8AE84 = self._id_02FA5B49969DEF47;
  return [19215, 1];
}

_id_942941C058F16B20(scriptable, player) {
  level._id_A3F54943D4B96DA2 unlink();

  if(isDefined(player)) {
    level._id_75434AA809A31EB6 = player;

    if(isDefined(player.origin))
      level._id_A3F54943D4B96DA2.origin = player.origin;

    level._id_A3F54943D4B96DA2 linkTo(player);
  }

  level._id_58EA889CD5F8AE84 = player;
}

_id_0F8D258990C78569(lootid) {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() && !scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    return [lootid, undefined];

  if(!isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E) || !isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid]))
    return [lootid, undefined];

  _id_6152AB3D3D329811 = [8408, 9104, 8569];
  _id_71F687D0CC8CE37D = [];

  foreach(item in _id_6152AB3D3D329811) {
    if(item == lootid) {
      continue;
    }
    [_id_3793828403C6873E, _] = scripts\mp\loot::_id_EA8078BE364FF10F(self._id_02FA5B49969DEF47, item, self);

    if(!isDefined(_id_3793828403C6873E))
      return [lootid, 1];

    _id_71F687D0CC8CE37D[_id_71F687D0CC8CE37D.size] = _id_3793828403C6873E;
  }

  if(istrue(level._id_16677A8421E20C23)) {
    self._id_02FA5B49969DEF47 thread _id_5A9DC1917ED8BCDF(self);
    return [lootid, undefined];
  }

  foreach(_id_3793828403C6873E in _id_71F687D0CC8CE37D) {
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] = self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] - 1;
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["noExtract"] = undefined;
  }

  _id_048614492EF09B23::_id_CE9B69FC041571D2(self, self._id_02FA5B49969DEF47);
  _id_F40C67796C17FBCB();
  return [21646, 1];
}

_id_5A9DC1917ED8BCDF(player) {
  self waittill("closed");
  player scripts\mp\hud_message::showerrormessage("PMC_S2/SOMEONE_ALREADY_MADE_RADIOACTIVE_CHARGE");
}

_id_F40C67796C17FBCB() {
  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087()) {
    return;
  }
  level._id_16677A8421E20C23 = 1;
  level._id_9C0E86C22ACF2968 = 1;
  scriptable = spawnscriptable("dmz_pmc_use_radiation", _id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5());
  _id_45253047E760F6A6 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702(), "usable_saba", "usable_sealion");
  scriptable setscriptablepartstate("dmz_pmc_use_radiation", _id_45253047E760F6A6);
  scriptable _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("radiation_bomb_story"));
  _id_F8F2890A42F13746();
  level thread _id_F65B07EF19699719();
}

_id_F65B07EF19699719() {
  level._id_6CEEAAA97AA7C2E9 = 0;
  _id_8078D5974E1B58F0 = [];

  while(istrue(level._id_9C0E86C22ACF2968)) {
    level._id_6CEEAAA97AA7C2E9 = 0;
    _id_E01568FE8F58645B = [];

    if(isDefined(level._id_8654B69976FBAEE8) && isDefined(level._id_8654B69976FBAEE8.origin)) {
      foreach(player in scripts\common\utility::playersinsphere(level._id_8654B69976FBAEE8.origin, 500)) {
        _id_1174ABEDBEFE9ADA::_id_C4A3072CE7B3F1FD(player, 1, 1);

        if(scripts\engine\utility::is_equal(level._id_E301C40B562DBD9D, player.team)) {
          level._id_6CEEAAA97AA7C2E9 = 1;
          _id_E01568FE8F58645B[_id_E01568FE8F58645B.size] = player;
        }
      }
    }

    if(isDefined(level._id_E301C40B562DBD9D) && isDefined(level._id_D21F44D30E9FBCAE)) {
      _id_5B27284C6A5E1168 = scripts\engine\utility::array_difference(_id_E01568FE8F58645B, _id_8078D5974E1B58F0);
      _id_5008853324A21A45 = scripts\engine\utility::array_difference(_id_8078D5974E1B58F0, _id_E01568FE8F58645B);

      foreach(player in _id_5B27284C6A5E1168)
      scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(level._id_D21F44D30E9FBCAE, player, 2, 2, &"PMC_S2/ARMING_BOMB");

      foreach(player in _id_5008853324A21A45)
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(level._id_D21F44D30E9FBCAE, player);

      _id_8078D5974E1B58F0 = _id_E01568FE8F58645B;
    }

    wait 1;
  }

  if(isDefined(level._id_D21F44D30E9FBCAE)) {
    foreach(player in _id_8078D5974E1B58F0)
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(level._id_D21F44D30E9FBCAE, player);

    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_D21F44D30E9FBCAE);
  }
}

_id_26C3B83E972A14FD(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(21646, 1))) {
    player scripts\mp\hud_message::showerrormessage("PMC_S2/NO_RADIOACTIVE_CHARGE");
    return;
  }

  instance freescriptable();
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "plant_radioactive_charge", 1);
  level thread _id_BC2E5C079BF6B8F2(player);
}

_id_BC2E5C079BF6B8F2(player) {
  bomb = spawnscriptable("brloot_radioactive_charge", scripts\engine\utility::drop_to_ground(player.origin, 50));
  bomb setscriptablepartstate("brloot_radioactive_charge", "unusable");
  _id_65932D306CCE787E(bomb);
  level._id_E301C40B562DBD9D = player.team;
  objidnum = bomb _id_D3428EBFDA80EDEB("ui_map_icon_obj_bomb_collect", (0, 0, 15), level._id_E301C40B562DBD9D);
  level._id_D21F44D30E9FBCAE = objidnum;
  progress = 0;

  while(progress < 60) {
    if(istrue(level._id_6CEEAAA97AA7C2E9)) {
      progress = progress + level.framedurationseconds;
      objective_setprogress(objidnum, clamp(progress / 60, 0, 1));
    }

    waitframe();
  }

  level._id_E301C40B562DBD9D = undefined;
  level._id_9C0E86C22ACF2968 = undefined;
  _id_81C6D95294B1ECE3(bomb.origin, scripts\engine\utility::_id_53C4C53197386572(player, bomb), "exp_radiation_boom_c");
  bomb freescriptable();
  _id_1174ABEDBEFE9ADA::_id_9BC063861B9330F1(10);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_radiation_damage_increase", level.players);
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "explode_radioactive_charge", 1);
}

_id_56F9B7D959B1704B(params) {
  if(!isDefined(self) || !isDefined(self.origin)) {
    _id_FCCEB181033EE1EF();
    return;
  }

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(self.origin, self.angles);
  bomb = _id_7E52B56769FA7774::spawnpickup("brloot_radioactive_charge", _id_CB4FAD49263E20C4, 1);
  _id_2BA521E376D3E4A5(bomb, self, _id_CB4FAD49263E20C4.origin);
}

_id_8BD9CFD763BCD0E4() {
  level._id_9C0E86C22ACF2968 = undefined;
  return 0;
}

_id_02FDFBB52976BA9E(player, item) {
  level._id_9C0E86C22ACF2968 = undefined;
}

_id_65932D306CCE787E(scriptable, owner, _id_D7A9FDC121364C8D) {
  level._id_8654B69976FBAEE8 = scriptable;
}

_id_23F069DC1BFF2EE0(_id_69E96A4CAA72D794, owner) {
  level._id_8654B69976FBAEE8 = _id_69E96A4CAA72D794;
}

_id_F8F2890A42F13746(_id_5793A0CF9D352C92, lootid) {
  level._id_8654B69976FBAEE8 = self._id_02FA5B49969DEF47;
  return [21646, 1];
}

_id_003E5CE38E7E8F69(scriptable, player) {
  level._id_8654B69976FBAEE8 = player;
}

_id_944498DD24BC5348() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("track_submarines"), (21286, -16750, 3685), 11206, 1, 1);
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("track_submarines"), (-72.488, 1721.72, 434.75), 11206, 1, 2);
}

_id_38DD5F365B6D2135() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("track_biolabs_cargo"), (0, 0, 0), 11206, 7, 4);
}

_id_2345DC4FA1F40628() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("plant_microphone"), (-7562, 2060, 512), 19217, 1, 2);
}

_id_126C379552E5F3B7() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("microphone_story"), (-72.488, 1721.72, 434.75), 19217, 1, 2);
}

_id_0071192F593DA6CF() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("deliver_letter_story"), (-9152.06, -11234.5, 48), 32022, 1, 8);
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("deliver_letter_story"), (-9152.06, -11234.5, 48), 11206, 1, 8);
}

_id_573C2D675DE0604C() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("phalanx_harddrive_story"), (4467, 8721, 124), 32166, 1, 8);
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("phalanx_harddrive_story"), (4297, -11455, 4590), 32132, 1, 1);
}

_id_285B8DCD4EA4DA26() {
  level._id_0632F6A89B947FD5 = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_akilo", ["rec_akilo", "bar_lm_light_p04_akilo", "stock_ar_p04_akilo", "mag_ar_large_p04_akilo", "holotherm01", "ub_gl_drill_akilo", "ammo_762s", "pgrip_p04", "silencer05_br"]);
  thread _id_3079D4D1C0EE380E(_id_16AE6D8B5F25F31B("kill_biobunker_bosses_weapon"), (4467, 8721, 124), level._id_0632F6A89B947FD5, 8);
}

_id_8882CA663F07C0CF() {
  _id_ABA9018B1743D830 = scripts\engine\utility::getStruct("pmc_spawnrhib", "script_noteworthy");

  if(isDefined(_id_ABA9018B1743D830))
    scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", _id_ABA9018B1743D830);
}

_id_3DE41A0F1613060F() {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_47D43CEA8A553AF1 = scripts\engine\utility::getStruct("pmc_spawn_jltv_radar", "script_noteworthy");

  if(isDefined(_id_47D43CEA8A553AF1)) {
    missionid = _id_16AE6D8B5F25F31B("delta_drive_poi");
    _id_03EF9B41093F5752 = spawnscriptable("pmc_airdrop_jltv_radar", _id_47D43CEA8A553AF1.origin);
    _id_03EF9B41093F5752 _id_AB5C0B42F31A0D20(missionid);
    _id_03EF9B41093F5752 setscriptablepartstate("pmc_airdrop_site", "ready");
    _id_03EF9B41093F5752.origin = scripts\engine\utility::drop_to_ground(_id_47D43CEA8A553AF1.origin);
    _id_A06F4D6A943FFF5B = scripts\engine\scriptable::scriptable_addusedcallbackbypart("pmc_airdrop_site", ::_id_9D1F0973F606C702);
  }
}

_id_4DD8F8CBCBA13E0A() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("plant_fake_docs"), (4297, -11455, 4590), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_fake_aq_intel"), 1, 1);
}

_id_871AB85492B81D67() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("extract_plant_intel"), (-3419.62, -5825.94, 332), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_biolab_usb"), 1, 2);
}

_id_B4824DFA90CA1AB9() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("plant_ir_beacon_towers"), (21286, -16750, 3685), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_ir_beacon"), 2, 1);
}

_id_B93CA7DB745586F6() {
  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_4168098F4AD31178);
}

_id_4168098F4AD31178(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(_id_EB06B338608EF354)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "complete_assimilation", 1);
}

_id_924E9E46E918D2EA() {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  if(!scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    return;
  }
  _id_C229D93C0BB4F8E8 = scripts\engine\utility::getStruct("brloot_valuable_vondelgas", "script_noteworthy");
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_C229D93C0BB4F8E8.origin, _id_C229D93C0BB4F8E8.angles);
  _id_7E52B56769FA7774::spawnpickup("brloot_valuable_vondelgas", _id_CB4FAD49263E20C4, 1, 0);
}

_id_70280EB87761BCD0() {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  if(!scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    return;
  }
  id = _id_16AE6D8B5F25F31B("gas_sample_story");
  players = _id_4E577D33450CAEE4(id);

  if(!isDefined(players) || players.size <= 0) {
    return;
  }
  _id_C229D93C0BB4F8E8 = scripts\engine\utility::getStruct("dmz_pmc_validate_gas", "script_noteworthy");
  useprompt = spawnscriptable("dmz_pmc_validate_gas", _id_C229D93C0BB4F8E8.origin, _id_C229D93C0BB4F8E8.angles);
  useprompt _id_AB5C0B42F31A0D20(id);
}

_id_E3B5DB8F3422827E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_6760390F08FAD126 = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(32110);
  _id_8EDD6A16616BBA27 = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(32111);

  if(!isDefined(_id_6760390F08FAD126) || !isDefined(_id_8EDD6A16616BBA27)) {
    return;
  }
  player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_6760390F08FAD126);
  player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_8EDD6A16616BBA27);
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_80EF668C09FFB70F in _id_6D5ED003AF1F9612)
  instance disablescriptableplayeruse(player);

  instance setscriptablepartstate("dmz_pmc_validate_gas_audio", "on");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "validate_gas_samples", 1);
}

_id_9C054602C73DF809() {
  _id_6DE76E4A214EEDB9 = scripts\engine\utility::getStruct("pmc_black_box", "script_noteworthy");

  if(!isDefined(_id_6DE76E4A214EEDB9)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  scriptable = spawnscriptable("dmz_pmc_download_blackbox", _id_6DE76E4A214EEDB9.origin);
  scriptable _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("plane_encounter"));
}

_id_E5AA3C571F674BD3(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance thread _id_7993F38E8643F95D(player);
}

_id_7993F38E8643F95D(player) {
  if(istrue(self._id_C281C3795B398443)) {
    return;
  }
  self._id_C281C3795B398443 = 1;
  team = player.team;
  objidnum = _id_D3428EBFDA80EDEB("ui_map_icon_obj_scavenger", (0, 0, 20), player.team);
  _id_90FB369A18926018 = [];

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    self disablescriptableplayeruse(player);

    if(distancesquared(player.origin, self.origin) < 160000) {
      _id_90FB369A18926018[_id_90FB369A18926018.size] = player;
      scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objidnum, player, 1, 2, &"PMC_S2/DOWNLOADING_BLACKBOX");
    }
  }

  _id_48814951E916AF89::_id_353FECD1549F5F42(self.origin, 1200, level._id_4B195D3DD0024B9C, 4);
  progress = 0;

  while(progress < 10) {
    progress = progress + level.framedurationseconds;
    objective_setprogress(objidnum, clamp(progress / 10, 0, 1));
    waitframe();
  }

  foreach(player in _id_90FB369A18926018)
  scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, player);

  scripts\mp\gameobjects::releaseid();

  if(!isDefined(level._id_E250C5815C2E42F3))
    level._id_E250C5815C2E42F3 = [];

  level._id_E250C5815C2E42F3[level._id_E250C5815C2E42F3.size] = team;
  _id_8A7A2427622E7572(team, "plane_black_box_download", 1);
  self._id_C281C3795B398443 = 0;
}

_id_F91E78AAD103B663() {
  level._id_C891A425BF8CBC28 = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_xmike2010", ["ammo_300wm", "bar_sn_light_p20_xmike2010", "bolt_p20", "laserbox_ads01", "mag_sn_p20_xmike2010", "pgrip_p20_xmike2010", "rec_xmike2010", "silencer01_dm", "snscope_therm01", "stock_sn_p20"]);
  thread _id_3079D4D1C0EE380E(_id_16AE6D8B5F25F31B("chemist_kill_story"), (-26681, 2194, 1915), level._id_C891A425BF8CBC28, 1);
}

_id_41C54A1F9C108720() {
  triggers = scripts\engine\utility::getStructArray("pmc_getawayvehicle_triggers", "script_noteworthy");

  if(!isDefined(triggers) || triggers.size == 0) {
    return;
  }
  foreach(struct in triggers)
  thread _id_4132600C37883F0B(struct);
}

_id_4132600C37883F0B(struct) {
  trigger = spawn("noent_volume_trigger_radius", struct.origin, 0, struct.radius, 100);

  for(;;) {
    trigger waittill("trigger", ent);

    if(!ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      continue;
    }
    if(ent scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() != "veh9_rhib") {
      continue;
    }
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(ent);

    if(!isDefined(driver) || !isDefined(driver.team) || !isPlayer(driver)) {
      continue;
    }
    if(isDefined(trigger.used) && isDefined(trigger.used[driver.team])) {
      continue;
    }
    if(!isDefined(trigger.used))
      trigger.used = [];

    trigger.used[driver.team] = 1;
    scripts\cp_mp\challenges::_id_8359CADD253F9604(driver, "park_rhib_sira", 1);
  }
}

_id_4AD47F789DFAD847(_id_69E96A4CAA72D794, lootid) {
  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || _id_2CC6455920627806::_id_30B30561882A2477(_id_69E96A4CAA72D794) != "sealion_waterways")
    return [lootid, undefined];

  if(!isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E) || !isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid]))
    return [lootid, undefined];

  _id_6152AB3D3D329811 = [19214, 8408, 13372];
  _id_71F687D0CC8CE37D = [];

  foreach(item in _id_6152AB3D3D329811) {
    if(item == lootid) {
      continue;
    }
    [_id_3793828403C6873E, _] = scripts\mp\loot::_id_EA8078BE364FF10F(self._id_02FA5B49969DEF47, item, self);

    if(!isDefined(_id_3793828403C6873E))
      return [lootid, 1];

    _id_71F687D0CC8CE37D[_id_71F687D0CC8CE37D.size] = _id_3793828403C6873E;
  }

  foreach(_id_3793828403C6873E in _id_71F687D0CC8CE37D) {
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] = self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] - 1;
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["noExtract"] = undefined;
  }

  _id_048614492EF09B23::_id_CE9B69FC041571D2(self, self._id_02FA5B49969DEF47);
  return [19216, 1];
}

_id_A28E5FE14B06DE35(_id_69E96A4CAA72D794, lootid) {
  if(!isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E) || !isDefined(self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid]))
    return [lootid, undefined];

  _id_6152AB3D3D329811 = [19215];
  _id_71F687D0CC8CE37D = [];

  foreach(item in _id_6152AB3D3D329811) {
    if(item == lootid) {
      continue;
    }
    [_id_3793828403C6873E, _] = scripts\mp\loot::_id_EA8078BE364FF10F(self._id_02FA5B49969DEF47, item, self);

    if(!isDefined(_id_3793828403C6873E))
      return [lootid, 1];

    _id_71F687D0CC8CE37D[_id_71F687D0CC8CE37D.size] = _id_3793828403C6873E;
  }

  foreach(_id_3793828403C6873E in _id_71F687D0CC8CE37D) {
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] = self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["quantity"] - 1;
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_3793828403C6873E]["noExtract"] = undefined;
  }

  _id_048614492EF09B23::_id_CE9B69FC041571D2(self, self._id_02FA5B49969DEF47);
  return [32107, 1];
}

_id_45DCF3DFCC5D1674() {
  _id_E2A9ADC592527CF3 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_valuable_fuelrods");

  foreach(_id_CB89020314445A32 in _id_E2A9ADC592527CF3)
  _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_CB89020314445A32);
}

_id_265739B4859488D7() {
  _id_89A7111BD154E223("pmc_observatory_car_crash_trigger", "script_noteworthy", "locate_car_crash");
}

_id_BB6DE40DD726B4D9() {
  _id_280EDF3F47535AE9("pmc_plane_crash_trigger", "script_noteworthy", "locate_plane_crash_site");
}

_id_359F7F436DE6BA09() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("redacted_1_zero_tolerance"), (-26681, 2194, 1915), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_cartel_intel"), 1, 1);
}

_id_3C989AD19E62DE6C() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("redacted_3_excavation"), (22656, -55352, 696), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_tracking_device"), 3, 1);
}

_id_88D8597BEAFDD628(player, _id_B205D90302DA2F07) {
  _id_969D82A329CBCC64 = scripts\mp\utility\teams::getteamdata(player.team, "poisVisitedACV");

  if(!isDefined(_id_969D82A329CBCC64[_id_B205D90302DA2F07])) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "poi_travel_acv", 1);
    _id_969D82A329CBCC64[_id_B205D90302DA2F07] = 1;
    scripts\mp\utility\teams::setteamdata(player.team, "poisVisitedACV", _id_969D82A329CBCC64);
  }
}

_id_8706A89FAE666D51(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "contract_hacker_use", 1);
}

_id_51BDE44B90A1FC39() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("tracking_activity"), (-9152.06, -11234.5, 48), 30414, 1, 8);
}

_id_16597CC75DE769A6() {
  _id_41B55EBF5A84F41D = istrue(_id_2D9D24F7C63AC143::_id_6F39F9916649AC48(30414, 1));
  _id_2D9D24F7C63AC143::_id_9D094FAC5AE6454E("brloot_gps_loaded_triangulator", "valuable", 1);
}

_id_D6FAB9BC69A92A51(player) {
  if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(30414)) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "uav_tower_use_with_tracker", 1);
    _id_3995EC6A46BD14DF = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_3995EC6A46BD14DF) {
      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      if(!isDefined(_id_F0EA4030349A33D5._id_24ACAC5A29F2B972))
        _id_F0EA4030349A33D5._id_24ACAC5A29F2B972 = 0;

      _id_F0EA4030349A33D5._id_24ACAC5A29F2B972++;

      if(_id_F0EA4030349A33D5._id_24ACAC5A29F2B972 >= 3 && _id_F0EA4030349A33D5 _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(30414) && scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
        _id_F0EA4030349A33D5 _id_16597CC75DE769A6();
    }
  }
}

_id_2B7CC5D62043202E(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "read_stationary_note", 1);
}

_id_93AB9968BF96E2B0(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "shopkeeper_trade_success", 1);
}

_id_0C2B3319EB135740(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "reward_station_buy_item", 1);
}

_id_38D565BD866CED0E(player, _id_5793A0CF9D352C92) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  baseorigin = scripts\engine\utility::_id_53C4C53197386572(_id_5793A0CF9D352C92._id_AFC028D00356E443, _id_5793A0CF9D352C92.origin);
  baseangles = _id_5793A0CF9D352C92.angles;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
  _id_7E52B56769FA7774::spawnpickup("brloot_shop_intel", _id_CB4FAD49263E20C4, 1, 1);
}

_id_C543832FAB9303CB(player, _id_5793A0CF9D352C92) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  baseorigin = scripts\engine\utility::_id_53C4C53197386572(_id_5793A0CF9D352C92._id_AFC028D00356E443, _id_5793A0CF9D352C92.origin);
  baseangles = _id_5793A0CF9D352C92.angles;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
  quantity = int(level._id_DAB6C0F07F8DF447);
  _id_7E52B56769FA7774::spawnpickup("brloot_shopkeeper_code", _id_CB4FAD49263E20C4, quantity, 1);
}

_id_F3F7CF5AA591A391(player, _id_5793A0CF9D352C92) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  baseorigin = scripts\engine\utility::_id_53C4C53197386572(_id_5793A0CF9D352C92._id_AFC028D00356E443, _id_5793A0CF9D352C92.origin);
  baseangles = _id_5793A0CF9D352C92.angles;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
  _id_7E52B56769FA7774::spawnpickup("brloot_valuable_shopkeeper_konni_intel", _id_CB4FAD49263E20C4, 1, 1);
}

_id_554EC348CFC62F37() {}

_id_B49C89AD7EDCF17B(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "discover_oasis_bunker_entrance", 1);
}

_id_A7FB9D5548D2455A() {
  if(!scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    return;
  }
  _id_1E8573A54A7096F3 = spawnStruct();
  level._id_1E8573A54A7096F3 = _id_1E8573A54A7096F3;
  _id_1E8573A54A7096F3._id_7A7997EBB531CB5B = [];
  _id_CF59B8FF27DCE1A4 = scripts\engine\utility::getStruct("pmc_bunker_upload_station", "script_noteworthy");
  _id_0C00335A7AEB2728::_id_2EDDEFE4D621123B();
  _id_C25ECF9ED9150764 = _id_0C00335A7AEB2728::_id_443A192943945265(_id_CF59B8FF27DCE1A4, 5);
  _id_2076A994E0E7C929 = scripts\engine\utility::getStruct("pmc_laser_trap_cache", "script_noteworthy");
  _id_B038ED928EC17A81 = getentitylessscriptablearray(undefined, undefined, _id_2076A994E0E7C929.origin, 50, "body")[0];

  if(!isDefined(_id_B038ED928EC17A81)) {
    return;
  }
  _id_B038ED928EC17A81._id_3E5D613E6F4D92E3 = 1;
  _id_B038ED928EC17A81 _id_552B8E4EA5FF7DF1::_id_D683A60016231237(_id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_biolabs_evidence"), 1);
  _id_B038ED928EC17A81._id_1E8573A54A7096F3 = _id_1E8573A54A7096F3;
  _id_B038ED928EC17A81._id_534E0CF170A981B7 = ::_id_901BC7E60BA89F7F;
  _id_1E8573A54A7096F3._id_B038ED928EC17A81 = _id_B038ED928EC17A81;
  level thread _id_4BADDF78C907E8F9();
  _id_60CEB54CF9534519 = scripts\engine\utility::getStructArray("pmc_laser_trap", "script_noteworthy");
  config = spawnStruct();
  config.maxhealth = 350;
  config.maxrange = 4000000;
  config._id_947AF351CE904AA5 = 7562500;

  foreach(struct in _id_60CEB54CF9534519) {
    turret = _id_0518AE857A3D351C::_id_D1ACADC2A0B9E115(config, struct, "team_hundred_ninety_five", "electronics_ir_laser_device_assembly_nogeo", "laser_trap_nvg");
    turret setmode("manual");
    turret laseron();
    turret._id_1E8573A54A7096F3 = _id_1E8573A54A7096F3;
    tag = "tag_laser";

    if(!scripts\engine\utility::hastag(turret.model, tag))
      tag = "tag_turret";

    _id_878BAE61ACA86FC5 = anglesToForward(struct.angles);
    _id_1E536FC02CE7881D = turret gettagorigin(tag);
    _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_878BAE61ACA86FC5 * 2000;
    trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, turret);
    end = trace["position"];
    turret._id_C507394A92387E01 = end;
    turret _meth_83EA6F9EBC30C9A4(turret._id_C507394A92387E01 - _id_1E536FC02CE7881D);
    _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
    turret thread _id_0518AE857A3D351C::_id_0A890D51E917AD74(0, _id_98C102BF3750C771);
    turret thread _id_A7614CE40D9DBE48();
  }
}

_id_A7614CE40D9DBE48() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_idle_movement");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_turret";

  self._id_C507394A92387E01 = self gettagorigin(tag) + anglesToForward(self gettagangles(tag)) * 3000;
  self._id_7A7997EBB531CB5B = [];
  wait 2;
  _id_4A5D9D7667048BF3 = scripts\engine\trace::create_character_contents();

  for(;;) {
    start = self gettagorigin("tag_laser");
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    trace = scripts\engine\trace::ray_trace(start, self._id_C507394A92387E01);
    end = trace["position"];
    _id_DB9C2822E3D940DC = lengthsquared(start - end);
    trace = scripts\engine\trace::ray_trace(start, end, [], _id_4A5D9D7667048BF3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      if(isPlayer(trace["entity"]) && isDefined(trace["entity"].guid)) {
        player = trace["entity"];

        if(isDefined(player) && isPlayer(player)) {
          player._id_230A3287F9AD2965 = 1;
          player.shouldskipdeathsshield = 1;
        }

        currenttime = gettime();

        if(!isDefined(self._id_7A7997EBB531CB5B[player.guid]) || currenttime - self._id_7A7997EBB531CB5B[player.guid] > 10000) {
          playsoundatpos(self.origin, "cp_laser_trigger");
          self._id_7A7997EBB531CB5B[player.guid] = currenttime;
        }

        if(!istrue(self._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid])) {
          self._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid] = 1;
          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_laser_tripped", [player]);

          if(!isDefined(self._id_1E8573A54A7096F3._id_8D4BDF4AFC9C5846) || currenttime - self._id_1E8573A54A7096F3._id_8D4BDF4AFC9C5846 > lookupsoundlength("mp_dmz_alrm_trap")) {
            playsoundatpos(self._id_1E8573A54A7096F3._id_B038ED928EC17A81.origin, "mp_dmz_alrm_trap");
            self._id_1E8573A54A7096F3._id_8D4BDF4AFC9C5846 = currenttime;
            _id_48814951E916AF89::_id_353FECD1549F5F42(level._id_1E8573A54A7096F3._id_B038ED928EC17A81.origin, 1500, level._id_4B195D3DD0024B9C, 6);
          }
        }
      }
    }

    waitframe();
  }
}

_id_901BC7E60BA89F7F(instance, player) {
  currenttime = gettime();

  if(isDefined(player.guid) && istrue(instance._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid])) {
    player scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR");
    return 0;
  }

  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "open_laser_cache", 1);
}

_id_4BADDF78C907E8F9() {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.guid))
      level._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid] = 1;
  }
}

_id_3CE8C941726C2400(player) {
  if(isDefined(player) && isDefined(player.guid)) {
    level._id_1E8573A54A7096F3._id_7A7997EBB531CB5B[player.guid] = 0;
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_laser_reset", [player]);
  }
}

_id_AB1164302301C233() {
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_flare_stick");
  missionid = _id_16AE6D8B5F25F31B("place_biobunker_tac_inserts");
  thread _id_315E9C3A5FB405E5(missionid, (-72.488, 1721.72, 434.75), lootid, 4, 2);

  if(!scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    return;
  }
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("pmc_plant_flare", "script_noteworthy");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    _id_E6D7DE89AE05A160 = spawnscriptable("dmz_flare_place", struct.origin, struct.angles);
    _id_E6D7DE89AE05A160 _id_AB5C0B42F31A0D20(missionid);
  }
}

_id_48A98EBE20DD89F2(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(player)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_flare_stick");
    _id_587F61AD4C5334A0 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1));

    if(!_id_587F61AD4C5334A0) {
      player scripts\mp\hud_message::showerrormessage("PMC_S2/PLACE_ERR_MSG");
      return;
    }

    weapon = makeweapon("flare_dmz_pmc");
    success = player scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(weapon);

    if(istrue(success)) {
      instance disablescriptableplayeruse(player);
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "place_flare_stick", 1);
    }
  }
}

_id_5286EF6E8174C925(grenade) {
  if(isDefined(grenade) && isDefined(self)) {
    level._id_E1FBD405916EAB45 = scripts\engine\utility::_id_53C4C53197386572(level._id_E1FBD405916EAB45, 0);
    level._id_E1FBD405916EAB45++;
    grenade setscriptablepartstate("smoke", "active");

    if(level._id_E1FBD405916EAB45 > getdvarint("dvar_27C2A8E9EE2E06D4", 20))
      grenade delete();
  }
}

_id_7757687DF059EB94(_id_FABF84450735DD93) {
  aliveplayers = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers");
  _id_3BB38B68CD07463E = 0;

  foreach(player in aliveplayers) {
    if(isDefined(player) && !istrue(player.extracted) && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(29514)) {
      _id_3BB38B68CD07463E = 1;
      break;
    }
  }

  return _id_3BB38B68CD07463E;
}

_id_5FF4AF6E7A002C62(_id_FABF84450735DD93, _id_11807F242097F672) {
  _id_EE3D1775B76DC3E9 = 0;

  if(isDefined(_id_11807F242097F672._id_B934B77F24F0966E) && isDefined(_id_11807F242097F672._id_B934B77F24F0966E[_id_FABF84450735DD93]))
    _id_EE3D1775B76DC3E9 = 1;

  return _id_EE3D1775B76DC3E9;
}

_id_6ADB8D95823366CB(_id_FABF84450735DD93) {
  level._id_F734766FB8C924E2 = scripts\engine\utility::array_removeundefined(level._id_F734766FB8C924E2);
  _id_7D0763BC73F02938 = undefined;
  _id_DE6953DDE7EFBC9C = undefined;

  foreach(_id_11807F242097F672 in level._id_F734766FB8C924E2) {
    _id_676D7C49AB177224 = isDefined(_id_11807F242097F672._id_B934B77F24F0966E) && isDefined(_id_11807F242097F672._id_B934B77F24F0966E[_id_FABF84450735DD93]);

    if(!_id_676D7C49AB177224) {
      continue;
    }
    _id_42C0D692E6B1366E = _id_11807F242097F672._id_B934B77F24F0966E[_id_FABF84450735DD93];

    if(!isDefined(_id_DE6953DDE7EFBC9C) || _id_42C0D692E6B1366E < _id_DE6953DDE7EFBC9C) {
      _id_DE6953DDE7EFBC9C = _id_42C0D692E6B1366E;
      _id_7D0763BC73F02938 = _id_11807F242097F672;
    }
  }

  return _id_7D0763BC73F02938;
}

_id_4CBA31E79D4E5166(_id_FABF84450735DD93) {
  _id_7D0763BC73F02938 = _id_6ADB8D95823366CB(_id_FABF84450735DD93);

  if(!isDefined(_id_7D0763BC73F02938))
    return 0;

  _id_42C0D692E6B1366E = _id_7D0763BC73F02938._id_B934B77F24F0966E[_id_FABF84450735DD93];
  _id_025A8868785389F9 = gettime() - _id_42C0D692E6B1366E < 120000;
  return !_id_025A8868785389F9;
}

_id_538AB9A6A1F38F55(_id_FABF84450735DD93, _id_11807F242097F672) {
  _id_DE05D1D03582C1F8 = 1;

  if(scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "aliveCount") == 0)
    _id_DE05D1D03582C1F8 = 0;
  else if(!_id_C5E0BAC8F123CC88(_id_FABF84450735DD93, 13926))
    _id_DE05D1D03582C1F8 = 0;
  else if(!_id_7757687DF059EB94(_id_FABF84450735DD93))
    _id_DE05D1D03582C1F8 = 0;
  else if(_id_5FF4AF6E7A002C62(_id_FABF84450735DD93, _id_11807F242097F672))
    _id_DE05D1D03582C1F8 = 0;
  else if(_id_4CBA31E79D4E5166(_id_FABF84450735DD93))
    _id_DE05D1D03582C1F8 = 0;

  return _id_DE05D1D03582C1F8;
}

_id_6245FC3E65911655(_id_11807F242097F672, _id_0694CF27A7080216) {
  level endon("game_ended");
  _id_11807F242097F672 endon("death");

  for(;;) {
    _id_FA33C4C6886D1DA2 = [];

    foreach(player in _id_0694CF27A7080216) {
      if(isDefined(player) && !scripts\engine\utility::array_contains(_id_FA33C4C6886D1DA2, player.team))
        _id_FA33C4C6886D1DA2 = scripts\engine\utility::array_add(_id_FA33C4C6886D1DA2, player.team);
    }

    if(_id_FA33C4C6886D1DA2.size == 0) {
      return;
    }
    foreach(_id_FABF84450735DD93 in _id_FA33C4C6886D1DA2) {
      _id_8D978122BC1C23AF = _id_538AB9A6A1F38F55(_id_FABF84450735DD93, _id_11807F242097F672);
      aliveplayers = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers");
      aliveplayers = scripts\engine\utility::array_removeundefined(aliveplayers);

      foreach(player in aliveplayers) {
        if(istrue(player.extracted)) {
          continue;
        }
        if(_id_8D978122BC1C23AF) {
          _id_11807F242097F672 enablescriptableplayeruse(player);
          continue;
        }

        _id_11807F242097F672 disablescriptableplayeruse(player);
      }
    }

    _id_11807F242097F672 scripts\engine\utility::waittill_any_timeout_1(5.0, "cutTheHead_laptop_activated");
  }
}

_id_37E963E85F8863AA() {
  _id_158D9D73AE320433 = [];
  _id_16881D0315399BB8 = scripts\engine\utility::getStructArray("pmc_mission_cut_the_head", "script_noteworthy");

  foreach(spawner in _id_16881D0315399BB8) {
    _id_11807F242097F672 = spawnscriptable("dmz_pmc_cut_the_head_mission_laptop", spawner.origin, spawner.angles);
    _id_11807F242097F672 _id_EF63CDEBAAFF3440();
    _id_158D9D73AE320433 = scripts\engine\utility::array_add(_id_158D9D73AE320433, _id_11807F242097F672);
  }

  return _id_158D9D73AE320433;
}

_id_68307FC74660904C() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  level._id_F734766FB8C924E2 = _id_37E963E85F8863AA();
  _id_0694CF27A7080216 = _id_4E577D33450CAEE4(13926);

  foreach(_id_11807F242097F672 in level._id_F734766FB8C924E2)
  thread _id_6245FC3E65911655(_id_11807F242097F672, _id_0694CF27A7080216);
}

_id_C2D1503CC1629DD2(_id_11807F242097F672, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(_id_11807F242097F672) || !isDefined(player)) {
    return;
  }
  if(_id_538AB9A6A1F38F55(player.team, _id_11807F242097F672)) {
    _id_11807F242097F672._id_B934B77F24F0966E = scripts\engine\utility::_id_53C4C53197386572(_id_11807F242097F672._id_B934B77F24F0966E, []);
    _id_11807F242097F672._id_B934B77F24F0966E[player.team] = gettime();
    _id_11807F242097F672 setscriptablepartstate("dmz_pmc_cut_the_head_mission_laptop", "laptop_on");
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "activate_laptop_within_time_limit", 1);

    if(!istrue(player._id_0CFD4A4C78ABADC9)) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_cut_the_head_on_1st_laptop_use", player.team);
      players = scripts\mp\utility\teams::getteamdata(player.team, "players");

      foreach(_id_E62DA3572742C173 in players)
      _id_E62DA3572742C173._id_0CFD4A4C78ABADC9 = 1;
    }

    _id_11807F242097F672 notify("cutTheHead_laptop_activated");
  }
}

_id_664FD771B95A53B6(objweapon) {
  player = self;

  if(!isDefined(player._id_9AB1766F74A7F17D) || !isDefined(objweapon)) {
    return;
  }
  foreach(killsperweapon in player._id_9AB1766F74A7F17D) {
    if(issameweapon(killsperweapon.objweapon, objweapon)) {
      player._id_9AB1766F74A7F17D = scripts\engine\utility::array_remove(player._id_9AB1766F74A7F17D, killsperweapon);
      break;
    }
  }
}

_id_414CF87BC60BB468() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("weapon_taken", _id_EBEF17F6067E94C0);
    player _id_664FD771B95A53B6(_id_EBEF17F6067E94C0);
  }
}

_id_27667A7E09799204() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("reload");
    objweapon = player getcurrentweapon();
    player _id_664FD771B95A53B6(objweapon);
  }
}

_id_3A9BA2472C7413C6(player, objweapon) {
  _id_0EDE51FF75BC58C6 = scripts\mp\utility\teams::getteamdata(player.team, "uniqueWeaponKill");

  if(!scripts\engine\utility::array_contains(_id_0EDE51FF75BC58C6, objweapon)) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "kill_AI_unique_weapon_squad", 1);
    _id_0EDE51FF75BC58C6 = scripts\engine\utility::array_add(_id_0EDE51FF75BC58C6, objweapon);
    scripts\mp\utility\teams::setteamdata(player.team, "uniqueWeaponKill", _id_0EDE51FF75BC58C6);
  }
}

_id_634368E310EDF6F9(player, objweapon) {
  if(!isDefined(player) || !isDefined(objweapon)) {
    return;
  }
  _id_3A9BA2472C7413C6(player, objweapon);

  if(!scripts\mp\weapons::isdroppableweapon(objweapon)) {
    return;
  }
  player._id_9AB1766F74A7F17D = scripts\engine\utility::_id_53C4C53197386572(player._id_9AB1766F74A7F17D, []);
  killsperweapon = undefined;

  foreach(_id_81729CC26E850EAE in player._id_9AB1766F74A7F17D) {
    if(issameweapon(_id_81729CC26E850EAE.objweapon, objweapon)) {
      killsperweapon = _id_81729CC26E850EAE;
      break;
    }
  }

  if(!isDefined(killsperweapon)) {
    killsperweapon = spawnStruct();
    killsperweapon.objweapon = objweapon;
    killsperweapon._id_1338796A0CAAD277 = 0;
    player._id_9AB1766F74A7F17D = scripts\engine\utility::array_add(player._id_9AB1766F74A7F17D, killsperweapon);
  }

  killsperweapon._id_1338796A0CAAD277++;

  if(killsperweapon._id_1338796A0CAAD277 >= 10) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "AI_kills_with_unique_ammo_clip", 1);
    player _id_664FD771B95A53B6(objweapon);
  }
}

_id_5AD5CD868765ED83() {
  level scripts\mp\flags::gameflagwait("prematch_done");
  _id_0694CF27A7080216 = _id_4E577D33450CAEE4(15132);

  foreach(player in _id_0694CF27A7080216) {
    player thread _id_414CF87BC60BB468();
    player thread _id_27667A7E09799204();
  }
}

_id_C17F9E8E49A412BF(player) {
  _id_41B55EBF5A84F41D = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(8567, 1));
  _id_2D9D24F7C63AC143::_id_9D094FAC5AE6454E("brloot_loaded_harddrive", "valuable", 1);
}

_id_AFD9995BF86B7912(objidnum) {
  player = self;
  player endon("vehicle_change_seat");
  _id_6A9734D81CBB50E7 = 100;
  _id_C351A54729796AE1 = 120 / _id_6A9734D81CBB50E7;
  scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objidnum, player, 2, 2, &"PMC_S4/GO_FOR_A_DRIVE_TIMER");

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_6A9734D81CBB50E7; _id_AC0E594AC96AA3A8++) {
    objective_setprogress(objidnum, _id_AC0E594AC96AA3A8 / _id_6A9734D81CBB50E7);
    wait(_id_C351A54729796AE1);
  }

  return 1;
}

_id_C900D8CC1FE76EF0(objidnum) {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");

  for(;;) {
    _id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player);

    if(_id_17915DB3DE174953) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_go_for_a_drive_transfer_started", player.team);
      _id_0B6AF944A5CF839E = player _id_AFD9995BF86B7912(objidnum);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, player);

      if(istrue(_id_0B6AF944A5CF839E)) {
        if(!player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(8567)) {
          break;
        }

        _id_C17F9E8E49A412BF(player);
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "drive_overland_while_carrying_hard_drive", 1);
        break;
      }
    } else
      player waittill("vehicle_change_seat");
  }
}

_id_5071E81A54B409CF(player) {
  _id_45ACCC7124BE3725 = spawnStruct();
  _id_45ACCC7124BE3725.curorigin = player.origin;
  _id_45ACCC7124BE3725.offset3d = (0, 0, 0);
  _id_45ACCC7124BE3725 scripts\mp\gameobjects::requestid(0, 1, undefined, 0);
  objidnum = _id_45ACCC7124BE3725.objidnum;
  objective_icon(objidnum, "ui_map_icon_obj_intel");
  scripts\mp\objidpoolmanager::objective_pin_global(objidnum, 1);
  objective_onentity(objidnum, player);
  scripts\mp\objidpoolmanager::objective_playermask_single(objidnum, player);
  return objidnum;
}

_id_494CF678A5B30F9E(player, vehiclename) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1() && vehiclename == "veh9_overland_2016" && player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(8567) && _id_C5E0BAC8F123CC88(player.team, 14773)) {
    objidnum = _id_5071E81A54B409CF(player);
    player _id_C900D8CC1FE76EF0(objidnum);
    scripts\mp\objidpoolmanager::returnobjectiveid(objidnum);
  }
}

_id_DBC1B65952F8ED88(player, _id_69E96A4CAA72D794, lootid) {
  _id_DC336372F57219A4 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_slipstream_laptop");

  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() || lootid != _id_DC336372F57219A4 || !isDefined(player.guid))
    return [lootid, undefined];

  _id_9CA59006FCFEECE6 = _id_2CC6455920627806::_id_30B30561882A2477(_id_69E96A4CAA72D794);

  if(_id_9CA59006FCFEECE6 != "saba_observatory" && _id_9CA59006FCFEECE6 != "saba_mtntwn" && _id_9CA59006FCFEECE6 != "saba_oldtwn")
    return [lootid, undefined];

  if(!isDefined(level._id_4C039B809146FC9D))
    level._id_4C039B809146FC9D = [];

  if(!isDefined(level._id_4C039B809146FC9D[player.guid])) {
    struct = spawnStruct();
    struct._id_B23DDA83A49CD36E = [];
    struct.starttime = gettime();
    level._id_4C039B809146FC9D[player.guid] = struct;
    scripts\cp_mp\challenges::_id_070ABD486AE26235(player, "first_slipstream_dead_drop", 1);
  }

  struct = level._id_4C039B809146FC9D[player.guid];
  currenttime = gettime();
  timeelapsed = currenttime - struct.starttime;

  if(timeelapsed > 180000) {
    struct.starttime = currenttime;
    struct._id_B23DDA83A49CD36E = [];
    scripts\cp_mp\challenges::_id_070ABD486AE26235(player, "first_slipstream_dead_drop", 1);
  }

  struct._id_B23DDA83A49CD36E[_id_9CA59006FCFEECE6] = 1;

  if(struct._id_B23DDA83A49CD36E.size == 3)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "dead_drop_dirt_bike", 1);

  return [lootid, 1];
}

_id_892733A0F84DEDCF(lootid) {
  if(!isDefined(lootid))
    return 0;

  return lootid == 11247 || lootid == 8644 || lootid == 32131 || lootid == 13356 || lootid == 19244 || lootid == 19245 || lootid == 26336 || lootid == 32131;
}

_id_BEBCEFBD95A287EC(player) {
  return _id_C5E0BAC8F123CC88(player.team, 13915);
}

_id_FEA699CF9870F641(radar, vehicle) {
  level endon("game_ended");
  vehicle endon("death");

  while(isDefined(vehicle)) {
    radius = getdvarint("dvar_EF46FBF92436A6E7", 1200);
    _id_5888FE9DAC2D7D8E = getdvarint("dvar_6B9856393459E1E8", 2);
    _id_F7949D3327A3E569 = getdvarint("dvar_97CEFEA3D38C1B44", 10);

    if(isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
      triggerportableradarpingteam(radar.origin, vehicle.owner.team, radius, _id_5888FE9DAC2D7D8E * 1000);
      radar playsoundonmovingent("iw9_code_scan_succes");
      currentpoi = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(radar.origin, 0, 0, 0);

      if(currentpoi == "delta_fleamarket")
        _id_8A7A2427622E7572(vehicle.owner.team, "quidproquo_visited_poi_one", 1);
      else if(currentpoi == "delta_firestation")
        _id_8A7A2427622E7572(vehicle.owner.team, "quidproquo_visited_poi_two", 1);
    }

    wait(_id_F7949D3327A3E569);
  }
}

_id_06300F1D8A3C7644(vehicle) {
  level endon("game_ended");
  vehicle endon("death");

  while(isDefined(vehicle)) {
    if(isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
      currentpoi = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(vehicle.origin, 0, 0, 0);

      if(currentpoi == "delta_fleamarket")
        _id_8A7A2427622E7572(vehicle.owner.team, "quidproquo_visited_poi_one", 1);
      else if(currentpoi == "delta_firestation")
        _id_8A7A2427622E7572(vehicle.owner.team, "quidproquo_visited_poi_two", 1);
    }

    wait 1;
  }
}

_id_6234D21AECEF0158(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level endon("game_ended");
  _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1)
  instance disablescriptableplayeruse(_id_8F7040E569EC9E98);

  _id_E99460BC50772002 = spawnStruct();
  _id_E99460BC50772002.origin = instance.origin;
  _id_E99460BC50772002.angles = instance.angles;
  _id_17160569DAB45FD6 = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_jltv_mg", _id_E99460BC50772002);
  _id_17160569DAB45FD6 waittill("landed");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "quidproquo_airdrop_call_success", 1);
  offset = (-80, 0, 37);
  _id_3D3F3EC461DFB6F1 = _id_17160569DAB45FD6.origin + offset;
  radar = spawn("script_model", _id_3D3F3EC461DFB6F1, 0, 0);
  radar setModel("offhand_2h_wm_sonar_pulse_v0");
  radar show();
  radar linkTo(_id_17160569DAB45FD6);
  level thread _id_FEA699CF9870F641(radar, _id_17160569DAB45FD6);
  level thread _id_06300F1D8A3C7644(_id_17160569DAB45FD6);
}

_id_9D1F0973F606C702(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_6234D21AECEF0158(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_7616962F7C523A5D(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "enter_keycode_success", 1);
}

_id_D8BAE32458CE35B7(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "drill_bunker_safe", 1);
}

_id_8B3BE362BFF6847F(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "enter_traded_keycode_success", 1);
}

_id_31C6D5968282B472(_id_34E4B26FEE2CFD2B) {
  if(!_id_6F6CC16C0528DE5B(_id_34E4B26FEE2CFD2B)) {
    return;
  }
  scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_34E4B26FEE2CFD2B, "defuse_enemy_charge", 1);
}

_id_D882E5D473C9B258(player, item, _id_0EC22A950F210E39) {
  if(_id_0B7A9CE0A2282B79::_id_D3E4D206D9B842A0(item) && _id_C5E0BAC8F123CC88(player.team, _id_16AE6D8B5F25F31B("infil_give_scav_weapon"))) {
    _id_FAFD64B272244139 = getlootscriptablearrayinradius(undefined, undefined, player.origin, 500);

    if(isDefined(_id_FAFD64B272244139) && _id_FAFD64B272244139.size > 0) {
      foreach(scriptable in _id_FAFD64B272244139) {
        if(isDefined(scriptable._id_BF23A60678978C19)) {
          scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "give_weapon_to_scavenger", 1);
          break;
        }
      }
    }
  }
}

_id_794D65C4D264DCC0() {
  _id_6A49A6F54A44C91A = scripts\engine\utility::getStructArray("pmc_bunker_exit_radiation", "script_noteworthy");

  foreach(struct in _id_6A49A6F54A44C91A) {
    _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(struct);
    struct._id_9D4873A013FB19AB = "scanned_bunker_exit";
    struct._id_44C91F16317BB5C2 = 1.32;
    struct._id_F967E4DE0363EA83 = [];
    struct.trigger = spawn("noent_volume_trigger_radius", struct.origin, 0, 600, 400);
    thread _id_B58F7554FAA406E7(struct.trigger, "entered_bunker_exit_trigger");
  }

  _id_91554E96494CE0A9 = scripts\engine\utility::getStructArray("pmc_bunker_exit_button", "script_noteworthy");
  level._id_C67075AA240462A9 = [];

  foreach(struct in _id_91554E96494CE0A9) {
    button = spawnscriptable("pmc_bunker_exit_button", struct.origin, struct.angles);
    button setscriptablepartstate("pmc_bunker_exit_button_use", "usable");
    button _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("secure_biobunker_exits_story"));
    button _id_D3428EBFDA80EDEB("ui_map_icon_obj_searchseizure", (0, 0, 5));
    button._id_11FB82FF93300BB7 = [];
    level._id_C67075AA240462A9[level._id_C67075AA240462A9.size] = button;
  }
}

_id_C55DAE311EA23861(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_DACDD049029751A8(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_DACDD049029751A8(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  _id_CF66D8322862D043 = 0;

  foreach(button in level._id_C67075AA240462A9) {
    if(istrue(button._id_9828F1535ACBC937))
      _id_CF66D8322862D043 = 1;
  }

  if(istrue(_id_CF66D8322862D043)) {
    player scripts\mp\hud_message::showerrormessage("PMC_S4/BUNKER_EXIT_BUTTON_ERR_MSG");
    return;
  }

  foreach(team in instance._id_11FB82FF93300BB7) {
    if(scripts\engine\utility::is_equal(team, player.team)) {
      player scripts\mp\hud_message::showerrormessage("PMC_S4/BUNKER_EXIT_BUTTON_ALREADY_SECURED_ERR_MSG");
      return;
    }
  }

  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
  instance disablescriptableplayeruse(_id_F0EA4030349A33D5);

  objidnum = instance.objidnum;
  _id_2E0BDB36F81A37E4 = player.team;
  instance._id_EF269077A28646EB = [];
  scripts\mp\objidpoolmanager::objective_teammask_single(objidnum, player.team);
  instance._id_9828F1535ACBC937 = 1;
  instance notify("download_started");
  instance thread _id_1DB8528D0D503797();
  progress = 0;
  _id_F26D6E29F4EFC048 = 0;
  time = getdvarint("dvar_F542E5B088626170", 80);

  while(progress < time) {
    if(instance._id_EF269077A28646EB.size > 0)
      progress = progress + level.framedurationseconds;

    if(_id_F26D6E29F4EFC048 < 1 && progress > 0) {
      _id_0B9FCE22C56FDAE8(instance.origin, 1250);
      _id_F26D6E29F4EFC048 = 1;
    } else if(_id_F26D6E29F4EFC048 < 2 && progress > 30) {
      _id_0B9FCE22C56FDAE8(instance.origin, 2500);
      _id_F26D6E29F4EFC048 = 2;
    } else if(_id_F26D6E29F4EFC048 < 3 && progress > 60) {
      _id_0B9FCE22C56FDAE8(instance.origin, 4000);
      _id_F26D6E29F4EFC048 = 3;
    }

    objective_setprogress(objidnum, clamp(progress / time, 0, 1));
    waitframe();
  }

  foreach(_id_6B8130899CD021F4 in instance._id_EF269077A28646EB)
  scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, _id_6B8130899CD021F4);

  instance notify("download_ended");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_bunker_exit_secured", instance._id_EF269077A28646EB);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objidnum);
  _id_A93508890D2545D1 = [];

  foreach(_id_8BA69F32363F01DD in instance._id_EF269077A28646EB) {
    if(!scripts\engine\utility::array_contains(_id_A93508890D2545D1, _id_8BA69F32363F01DD.team))
      _id_A93508890D2545D1[_id_A93508890D2545D1.size] = _id_8BA69F32363F01DD.team;
  }

  foreach(team in _id_A93508890D2545D1) {
    _id_8A7A2427622E7572(team, "secured_bunker_exit", 1);
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
    instance disablescriptableplayeruse(_id_F0EA4030349A33D5);
  }

  instance._id_9828F1535ACBC937 = 0;
}

_id_0B9FCE22C56FDAE8(origin, radius) {
  playsoundatpos(origin, "mp_dmz_alrm_trap");
  _id_48814951E916AF89::_id_77ACC10C4823DD8A(4, origin, "high", "mission", "pmc_bunkerExit", "no_group", level._id_4B195D3DD0024B9C);
  _id_48814951E916AF89::_id_353FECD1549F5F42(origin, radius, level._id_4B195D3DD0024B9C, 6);
}

_id_1DB8528D0D503797() {
  self endon("download_ended");
  origin = self.origin;
  objidnum = self.objidnum;

  for(;;) {
    _id_C8DADD43AEFDC396 = [];

    foreach(player in level.players) {
      if(isDefined(player.origin) && distancesquared(origin, player.origin) < 160000)
        _id_C8DADD43AEFDC396[_id_C8DADD43AEFDC396.size] = player;
    }

    _id_0E34E332590AC462 = scripts\engine\utility::array_difference(_id_C8DADD43AEFDC396, self._id_EF269077A28646EB);
    _id_EA6B4EEEAEA5CDC3 = scripts\engine\utility::array_difference(self._id_EF269077A28646EB, _id_C8DADD43AEFDC396);

    foreach(player in _id_0E34E332590AC462)
    scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objidnum, player, 2, 2, &"PMC_S4/BUNKER_EXIT_SECURING_PROGRESS_TITLE");

    foreach(player in _id_EA6B4EEEAEA5CDC3)
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objidnum, player);

    self._id_EF269077A28646EB = _id_C8DADD43AEFDC396;
    wait 1;
  }
}

_id_4F0E53309E4DBD74(_id_C45248FDF60A7B9A) {
  _id_9EFE117534A94AF7 = _func_4AD9053267734CF2((0, -176, 8), _id_C45248FDF60A7B9A.origin, _id_C45248FDF60A7B9A.angles);
  _id_5CCD62BA7DFE0E79 = combineangles((0, 270, 0), _id_C45248FDF60A7B9A.angles);
  usable = spawnscriptable("missile_silo_usable", _id_9EFE117534A94AF7, _id_5CCD62BA7DFE0E79);
  _id_611B35D0279EB120::_id_364384B9D084F84E(usable, 0);
  usable._id_C45248FDF60A7B9A = _id_C45248FDF60A7B9A;
  _id_C45248FDF60A7B9A.usable = usable;
  return usable;
}

_id_D7FD9F403937E688(origin, angles) {
  _id_A6487FB1572C9B44 = spawnscriptable("missile_silo_noent", origin, angles);
  _id_A6487FB1572C9B44 setscriptablepartstate("missile_silo_noent", "closed_idle");
  _id_FE5C4A69C056946B = _func_4AD9053267734CF2((0, 0, 105), _id_A6487FB1572C9B44.origin, _id_A6487FB1572C9B44.angles);
  _id_D9BF814FE5FAB0C7 = combineangles(_id_A6487FB1572C9B44.angles, (0, 0, 180));
  _id_A6487FB1572C9B44._id_E0393EE951DB4B0F = spawnscriptable("missile_silo_hidden_collision", _id_FE5C4A69C056946B, _id_D9BF814FE5FAB0C7);
  return _id_A6487FB1572C9B44;
}

_id_6CE896CA48E4C62A() {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    return;
  }
  nodes = scripts\engine\utility::getStructArray("dmz_missle_silo", "script_noteworthy");

  foreach(node in nodes)
  _id_A6487FB1572C9B44 = _id_D7FD9F403937E688(node.origin, node.angles);

  _id_6328AEB6488169E5 = scripts\engine\utility::getStruct("dmz_missile_silo_open", "script_noteworthy");
  _id_6E62624128D2EFA0 = spawnscriptable("missile_silo_noent", _id_6328AEB6488169E5.origin, _id_6328AEB6488169E5.angles);
  _id_6E62624128D2EFA0 setscriptablepartstate("missile_silo_noent_collision", "open");
  _id_6E62624128D2EFA0._id_445F2D1BE8A9DD9E = ::_id_EA506E1F9C05EFC8;
  usable = _id_4F0E53309E4DBD74(_id_6E62624128D2EFA0);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("missile_silo_usable", _id_611B35D0279EB120::_id_EB1DFD659C785A01);
  _id_611B35D0279EB120::_id_AA0FB4301A2106D9();
  level._id_A2B890D129C64761 = spawnStruct();
  level._id_A2B890D129C64761.usetime = 3;
  level._id_A2B890D129C64761.capturetype = 2;
  _id_5085F0539505E5F5 = _func_F159C10D5CF8F0B4("subarea_airport_konniship", "script_noteworthy")[0];
  group = spawnStruct();
  group.contributingplayers = [];
  group.used = [];
  group._id_22E2935C86B3B88E = "pmc_konni_ship";
  group.volume = _id_5085F0539505E5F5;
  _func_572838690D80D959(group._id_22E2935C86B3B88E);
  level scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_611B35D0279EB120::_id_364384B9D084F84E(usable, 1);
  missionid = _id_16AE6D8B5F25F31B("investigate_shipping_container_story");
  usable _id_AB5C0B42F31A0D20(missionid);
  _id_811318CF900D3874 = scripts\engine\utility::getStructArray("pmc_boat_agent_spawn", "script_noteworthy");

  foreach(node in _id_811318CF900D3874) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(node);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, "high", "mission", "pmc_mission", undefined, undefined, undefined, "saba_airport", 0, undefined, 0);
    _id_A5DAF6A4BAF26AAF = spawnStruct();
    _id_A5DAF6A4BAF26AAF.group = group;
    _id_A5DAF6A4BAF26AAF._id_90CCD093DE8C8C55 = ::_id_8EF059CEB8BB6F26;
    _id_A5DAF6A4BAF26AAF.ondeath = ::_id_5629FA2CAE5846F2;
    _id_A5DAF6A4BAF26AAF._id_9E729433FD479F19 = ::_id_507B92D2539B9074;

    if(isint(agent))
      _id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B = agent;

    _id_371B4C2AB5861E62::_id_3EA1225BF6192343(agent, _id_A5DAF6A4BAF26AAF);
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "pmc_agentPostDormancy", ::_id_EAD7C3630E018044);
    _func_E812B7065161DA79(agent, group._id_22E2935C86B3B88E);
    _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, node.origin, 256);
  }

  thread _id_5678739494BF8DE1(group);
}

_id_8EF059CEB8BB6F26(agent, _id_451A9D27D63C746B) {
  agent._id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B = _id_451A9D27D63C746B;
  _func_C36F897D56E28169(agent, agent._id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);
  _func_E812B7065161DA79(_id_451A9D27D63C746B, agent._id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);
}

_id_EAD7C3630E018044(agent) {
  _func_C36F897D56E28169(agent._id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B, agent._id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);
  _func_E812B7065161DA79(agent, agent._id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);
}

_id_507B92D2539B9074(struct, id) {
  _func_C36F897D56E28169(id, struct.group._id_22E2935C86B3B88E);
}

_id_5629FA2CAE5846F2(agent, _id_6181DE250AFA5BB6) {
  if(isagent(agent)) {
    _id_A5DAF6A4BAF26AAF = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "agentStruct");

    if(isDefined(_id_A5DAF6A4BAF26AAF)) {
      if(isDefined(_id_A5DAF6A4BAF26AAF._id_9768B22610B34D9D))
        agent _id_48814951E916AF89::_id_8C8C6DBF143AB5B2(agent, _id_A5DAF6A4BAF26AAF._id_9768B22610B34D9D);

      _func_C36F897D56E28169(agent, _id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);

      if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6) && isDefined(_id_A5DAF6A4BAF26AAF.group.contributingplayers) && !scripts\engine\utility::array_contains(_id_A5DAF6A4BAF26AAF.group.contributingplayers, _id_6181DE250AFA5BB6))
        _id_A5DAF6A4BAF26AAF.group.contributingplayers[_id_A5DAF6A4BAF26AAF.group.contributingplayers.size] = _id_6181DE250AFA5BB6;
    }
  } else if(isint(agent)) {
    info = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

    if(isDefined(info) && isDefined(info._id_A5DAF6A4BAF26AAF) && isDefined(info._id_A5DAF6A4BAF26AAF.group))
      _func_C36F897D56E28169(agent, info._id_A5DAF6A4BAF26AAF.group._id_22E2935C86B3B88E);
  }

  _id_371B4C2AB5861E62::_id_3EA1225BF6192343(agent, undefined);
  _id_371B4C2AB5861E62::_id_97FBD14BBCF19D9C(agent, "pmc_agentPostDormancy", ::_id_EAD7C3630E018044);
}

_id_5678739494BF8DE1(group) {
  level endon("game_ended");

  for(;;) {
    agents = _func_B4B9401715CF98EA(group._id_22E2935C86B3B88E);
    numagents = agents.size;
    _id_28615E1635F3C2EB = 0;
    group._id_28615E1635F3C2EB = 0;

    foreach(agent in agents) {
      origin = undefined;

      if(isagent(agent))
        origin = agent.origin;
      else if(isint(agent)) {
        info = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

        if(isDefined(info))
          origin = info.origin;
      }

      _id_FBF09640272961B4 = isDefined(origin) && ispointinvolume(origin, group.volume);
      _id_4076D436F9878FDF = isDefined(origin) && distance2d(origin, group.volume.origin) < 1000;

      if(_id_FBF09640272961B4 || _id_4076D436F9878FDF) {
        _id_28615E1635F3C2EB++;
        continue;
      }

      _id_5629FA2CAE5846F2(agent);
    }

    group._id_28615E1635F3C2EB = _id_28615E1635F3C2EB;

    if(_id_28615E1635F3C2EB == 0) {
      _id_095CFA82FFCDA809 = [];
      _id_7DA5B2082E28AB9D = [];

      foreach(player in group.contributingplayers) {
        if(isDefined(player.team) && !scripts\engine\utility::array_contains(_id_095CFA82FFCDA809, player.team)) {
          _id_095CFA82FFCDA809[_id_095CFA82FFCDA809.size] = player.team;
          _id_7DA5B2082E28AB9D[_id_7DA5B2082E28AB9D.size] = player;
        }
      }

      foreach(player in _id_7DA5B2082E28AB9D) {
        group.used[player.team] = 1;
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "cleared_konni_ship");
      }

      group._id_2FB79D99876506A7 = 1;
      return;
    }

    wait 1.0;
  }
}

_id_EA506E1F9C05EFC8(_id_C45248FDF60A7B9A, player) {
  if(_id_C45248FDF60A7B9A getscriptablepartstate("missile_silo_noent") != "capturing_0_percent") {
    playsoundatpos(_id_C45248FDF60A7B9A.origin, "iw9_jup_reveal_missile_silo_start_dmz");
    _id_C45248FDF60A7B9A setscriptablepartstate("missile_silo_noent", "capturing_0_percent");
  }

  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "open_missile_silo", 1);
}

_id_2D3C14FAA38E2146(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "equipped_disguise", 1);
}

_id_4F23417A848E2F5F(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "buy_scavenger_buy_station", 1);
}

_id_54E624D4AC58B723() {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    return;
  }
  node = scripts\engine\utility::getStruct("pmc_tunnel_entrance", "script_noteworthy");
  _id_DC9F380321BCBE98 = spawnscriptable("pmc_signal_flare_use", node.origin, node.angles);
  _id_DC9F380321BCBE98 setscriptablepartstate("pmc_signal_flare_use", "usable");
  _id_DC9F380321BCBE98._id_A8E2D773F5B6D88E = [];
  level scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_DC9F380321BCBE98 _id_AB5C0B42F31A0D20(_id_16AE6D8B5F25F31B("false_reinforcement_signal_story"));
}

_id_AC56C0EC10AC3E25(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_6871A50434E7CC31(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_6871A50434E7CC31(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_64ACB6CE534155B7::utilflare_shootflare(instance.origin, "dom");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "false_signal_sent", 1);
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
  instance disablescriptableplayeruse(_id_F0EA4030349A33D5);

  _id_782866E364DCD2EF = _id_48814951E916AF89::_id_AB14D6652E44FDA0(8, level.spawnset["guard"], 3, undefined, "Helicopter");
  agents = undefined;

  while(!isDefined(agents)) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(undefined, instance.origin, "absolute", "mission", "false_signal", undefined, undefined, 1, undefined, undefined, undefined, undefined, _id_782866E364DCD2EF, "ru");
    wait 1.0;
  }

  _id_FC1C9CEBE104F3FE = 0;

  foreach(agent in agents) {
    agent._id_B582B10663B5B2A9 = 0;
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_konni_combat_intel", undefined, scripts\engine\utility::ter_op(_id_FC1C9CEBE104F3FE, 0.5, 1), 1);

    if(!_id_FC1C9CEBE104F3FE)
      _id_FC1C9CEBE104F3FE = 1;

    _id_120270BD0A747A35::_id_0BD9ACC7C99AD884(agent, instance.origin);
  }
}

_id_1665F2FE0AE0D024() {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    return;
  }
  missionid = _id_16AE6D8B5F25F31B("locate_missile_containers");
  thread _id_315E9C3A5FB405E5(missionid, (4297, -11455, 4590), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_ir_beacon"), 2, 1);
  _id_F98C415FEA7D1738 = undefined;
  nodes = scripts\engine\utility::getStructArray("missile_silo", "targetname");

  foreach(node in nodes) {
    _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1, 1);

    if(_id_B205D90302DA2F07 == "saba_cemetery") {
      _id_F98C415FEA7D1738 = _id_E13625D770059EF9(node, missionid);
      _id_F98C415FEA7D1738._id_1FA640F7C162F51E = "silo_plant_first_ir_beacon";
      nodes = scripts\engine\utility::array_remove(nodes, node);
      break;
    }
  }

  nodes = scripts\engine\utility::array_randomize(nodes);
  _id_A6487FB1572C9B44 = _id_E13625D770059EF9(nodes[0], missionid);
  _id_A6487FB1572C9B44._id_1FA640F7C162F51E = "silo_plant_second_ir_beacon";
  _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(nodes[0].origin, 1, 1);
  _id_4298E4CA487BD69D = _func_4AD9053267734CF2((51, 0, 65), _id_F98C415FEA7D1738.origin, _id_F98C415FEA7D1738.angles);
  _id_4A122E836C546C35 = combineangles(_id_F98C415FEA7D1738.angles, (90, 0, 0));
  _id_A234A65C378F3289 = spawnscriptable("stationary_note_paper", _id_4298E4CA487BD69D, _id_4A122E836C546C35);
  _id_5FC921CA5DF09E7E = "pmc_missile_silo_hint_" + getsubstr(_id_B205D90302DA2F07, 5);
  _id_A234A65C378F3289._id_70B5FD7365F6B50C = _id_304F476283F6D36E::_id_793A7B85FFB737D1(_id_5FC921CA5DF09E7E);
}

_id_E13625D770059EF9(node, missionid) {
  _id_A6487FB1572C9B44 = _id_D7FD9F403937E688(node.origin, node.angles);
  _id_A6487FB1572C9B44 setscriptablepartstate("missile_silo_noent_use", "usable");
  _id_A6487FB1572C9B44 thread _id_AB5C0B42F31A0D20(missionid);
  trigger = spawn("noent_volume_trigger_radius", _id_A6487FB1572C9B44.origin, 0, 700, 700);
  thread _id_B58F7554FAA406E7(trigger, "locate_missile_silo");
  _id_A6487FB1572C9B44 thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_A6487FB1572C9B44.origin, 50, 10000000, (1, 0, 0));
  thread _id_AFE925F2DEE5F03E(_id_A6487FB1572C9B44);
  return _id_A6487FB1572C9B44;
}

_id_AFE925F2DEE5F03E(_id_A6487FB1572C9B44) {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  numagents = 4;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    _id_DE2D3E1486E4E9D3 = randomfloatrange(200, 400);
    forward = anglesToForward(_id_A6487FB1572C9B44.angles) * _id_DE2D3E1486E4E9D3;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / numagents * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = _id_A6487FB1572C9B44.origin + offset;
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar", 2);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_CB88E484EB1A3A92, "medium", "mission", "pmc_mission");
    _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, _id_A6487FB1572C9B44.origin, 512);
  }
}

_id_948991A18B048182(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player isonground() || !isDefined(player.team)) {
    return;
  }
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_ir_beacon");
  _id_587F61AD4C5334A0 = istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1));

  if(_id_587F61AD4C5334A0) {
    groundpos = scripts\engine\utility::drop_to_ground(player.origin);
    placement = spawnscriptable("dmz_place_item", groundpos, player.angles);
    placement setscriptablepartstate("dmz_place_item_use", "unusable");
    placement setscriptablepartstate("dmz_place_item_model", "brloot_ir_beacon");
    player thread _id_7E52B56769FA7774::playerplaypickupanim();
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, instance._id_1FA640F7C162F51E);
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
    instance disablescriptableplayeruse(_id_F0EA4030349A33D5);
  } else
    player scripts\mp\hud_message::showerrormessage("PMC_S2/PLACE_ERR_MSG");
}

_id_07FC83D63A85C14D(player) {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "turn_on_mrap", 1);
}

_id_496B109DC14FA57D(_id_B8EBE3F71A08AB40) {
  if(isDefined(_id_B8EBE3F71A08AB40._id_540E563BD70483A2) && istrue(_id_B8EBE3F71A08AB40._id_540E563BD70483A2._id_27144879B0C7BEED) && isDefined(_id_B8EBE3F71A08AB40.teams[0]))
    _id_8A7A2427622E7572(_id_B8EBE3F71A08AB40.teams[0], "hostage_final_exfil", 1);
}

_id_A07E5E1F98C14D68() {
  thread _id_315E9C3A5FB405E5(_id_16AE6D8B5F25F31B("speed_deaddrop_chain"), (-8980, 4681, 405), _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_slipstream_laptop"), 1, 1);
}

_id_CC6A02D4564D9F07(player, _id_4E479E14D0837E84) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  _id_3F6103D9666B07CC = _id_0B7A9CE0A2282B79::_id_36275388F9093535(_id_4E479E14D0837E84);

  if(isDefined(_id_3F6103D9666B07CC) && _id_3F6103D9666B07CC.team != player.team)
    scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_3F6103D9666B07CC, "share_insured_weapon", 1);
}

_id_5A3FD0BABC886413(_id_CFDFB123EB5C2482, _id_7731ADEF63E19B0C) {
  _id_E6AB91AF04FB3479 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(_id_7731ADEF63E19B0C);

  foreach(_id_9940E1F565DCFAD0 in _id_E6AB91AF04FB3479) {
    if(!isDefined(_id_9940E1F565DCFAD0._id_628A2EBA2E3D4AF4) && _id_9940E1F565DCFAD0 != _id_CFDFB123EB5C2482)
      return 0;
  }

  return 1;
}

_id_B55402E6D4FAE450(vehicle) {
  if(!scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    return;
  }
  if(vehicle.vehiclename == "veh9_pwc" || vehicle.vehiclename == "veh9_rhib" || vehicle.vehiclename == "veh9_patrol_boat") {
    _id_D9A354906C598604 = _id_5A3FD0BABC886413(vehicle, "veh9_pwc");

    if(_id_D9A354906C598604) {
      _id_D9A354906C598604 = _id_D9A354906C598604 && _id_5A3FD0BABC886413(vehicle, "veh9_rhib");

      if(_id_D9A354906C598604) {
        _id_D9A354906C598604 = _id_D9A354906C598604 && _id_5A3FD0BABC886413(vehicle, "veh9_patrol_boat");

        if(_id_D9A354906C598604) {
          foreach(player in level.players)
          scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "destroy_all_unoccupied_aquatic_vehicles", 1, 0);
        }
      }
    }
  }
}

_id_7854F54F01615A6E(vehicle) {
  if(!_id_CFF2F4F168B29B81()) {
    return;
  }
  _id_B55402E6D4FAE450(vehicle);
}

_id_34969E35391841BA() {
  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  scripts\mp\flags::_id_1240434F4201AC9D("fortress_system_init");
  _id_590672F7B5711C59 = (-578, 7297, 434);
  _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_590672F7B5711C59);

  if(!isDefined(_id_276AC5E84835EA87)) {
    return;
  }
  _id_4948CDF739393D2D::_id_D1EC6D522C8102D9(_id_276AC5E84835EA87);
  _id_4948CDF739393D2D::_id_68A6379D51E7DBC2(_id_276AC5E84835EA87, "completely_locked");
  triggers = _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46;
  group = spawnStruct();
  level._id_79C824DDFE860A6F = group;
  group.contributingplayers = [];
  group.used = [];
  group._id_22E2935C86B3B88E = "pmc_konni_safehouse";
  group.volume = triggers[0];
  group._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  _func_572838690D80D959(group._id_22E2935C86B3B88E);
  group._id_45895CED8788D5DE = scripts\engine\utility::getStructArray("pmc_konni_safehouse_exit", "script_noteworthy");
  _id_9D3AB0BFFF930906 = scripts\engine\utility::getStructArray("pmc_konni_safehouse_agent", "script_noteworthy");
  _id_63366D9D88CE51F8 = 1;

  foreach(spawn in _id_9D3AB0BFFF930906) {
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
    agent = undefined;

    while(!isDefined(agent)) {
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawn.origin, spawn.angles, "high", "mission", "pmc_mission", undefined, undefined, undefined, undefined, 0, undefined, 0);

      if(!isDefined(agent))
        waitframe();
    }

    _id_A5DAF6A4BAF26AAF = spawnStruct();
    _id_A5DAF6A4BAF26AAF.group = group;
    _id_A5DAF6A4BAF26AAF._id_90CCD093DE8C8C55 = ::_id_8EF059CEB8BB6F26;
    _id_A5DAF6A4BAF26AAF.ondeath = ::_id_5629FA2CAE5846F2;
    _id_A5DAF6A4BAF26AAF._id_9E729433FD479F19 = ::_id_507B92D2539B9074;
    _id_A5DAF6A4BAF26AAF._id_9768B22610B34D9D = _id_48814951E916AF89::_id_EDABF4238E9D70B5("brloot_cartel_transportation_plans", undefined, undefined, scripts\engine\utility::ter_op(_id_63366D9D88CE51F8, 1.0, 0.25), 1);

    if(isint(agent))
      _id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B = agent;

    _id_371B4C2AB5861E62::_id_3EA1225BF6192343(agent, _id_A5DAF6A4BAF26AAF);
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "pmc_agentPostDormancy", ::_id_EAD7C3630E018044);
    _func_E812B7065161DA79(agent, group._id_22E2935C86B3B88E);
    _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, spawn.origin, 256);
    _id_63366D9D88CE51F8 = 0;
  }
}

_id_F37F5D719BC2F2F0(grenade, player) {
  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  player endon("death_or_disconnect");
  origin = _id_4404ED46F49E5BA1(grenade);
  origin = scripts\engine\utility::_id_53C4C53197386572(origin, grenade.origin);

  if(!isDefined(origin)) {
    return;
  }
  if(isDefined(level._id_79C824DDFE860A6F)) {
    if(_id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(origin, level._id_79C824DDFE860A6F._id_276AC5E84835EA87)) {
      if(isDefined(player))
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "grenade_in_konni_safehouse", 1);

      _id_4948CDF739393D2D::_id_A113CF2BE454F78D(level._id_79C824DDFE860A6F._id_276AC5E84835EA87);
      wait 1.0;
      agents = _func_B4B9401715CF98EA(level._id_79C824DDFE860A6F._id_22E2935C86B3B88E);

      foreach(agent in agents) {
        if(isagent(agent)) {
          _id_0F66F4B446207B0C = agent.origin;

          if(!isDefined(_id_0F66F4B446207B0C)) {
            continue;
          }
          _id_C79DCA57049C64D4 = _id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(_id_0F66F4B446207B0C, level._id_79C824DDFE860A6F._id_276AC5E84835EA87);

          if(_id_C79DCA57049C64D4) {
            _id_E8697EE52F033360 = scripts\engine\utility::getclosest(_id_0F66F4B446207B0C, level._id_79C824DDFE860A6F._id_45895CED8788D5DE);

            if(isDefined(_id_E8697EE52F033360))
              _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_E8697EE52F033360.origin, 0);
          }
        }
      }
    }
  }
}

_id_4404ED46F49E5BA1(grenade) {
  grenade endon("decoy_sequence_started");
  grenade waittill("explode", origin);
  return origin;
}

_id_7A1E65B949E0B879() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("create_script_initialized");
  scripts\engine\utility::flag_wait("scriptables_ready");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_pmc_unobserved_radio", ::_id_CD8C827E2B6115EA);
  _id_340FEFBB7410B03E = scripts\engine\utility::getStructArray("pmc_unobserved_laptop", "script_noteworthy");

  foreach(node in _id_340FEFBB7410B03E) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, node.origin, node.angles);
    item = _id_7E52B56769FA7774::spawnpickup("brloot_valuable_konni_laptop", _id_CB4FAD49263E20C4, 1);
    item._id_BBC200BC77C5DB2B = 1;
    item._id_8C6CE30A6A5126B1 = 1;
  }
}

_id_F7D8054AE05DE10F(door, player) {
  if(!scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() || !getdvarint("dvar_67839DC5E648F761", 1)) {
    return;
  }
  _id_A44BBCE89FC81DF8 = getlootscriptablearrayinradius(undefined, undefined, door._id_276AC5E84835EA87.origin, 1500);
  maxdist = -1;
  _id_C0B5AEFDDE135C6D = undefined;

  foreach(loot in _id_A44BBCE89FC81DF8) {
    if(!loot getscriptableisloot() || loot scriptableislootcache() || !_id_7E52B56769FA7774::_id_2AE5E94BD6518AB5(loot, 0) || !_id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(loot.origin, door._id_276AC5E84835EA87)) {
      continue;
    }
    _id_556B31282ABCB132 = distancesquared(player.origin, loot.origin);

    if(_id_556B31282ABCB132 > maxdist) {
      maxdist = _id_556B31282ABCB132;
      _id_C0B5AEFDDE135C6D = loot;
    }
  }

  if(isDefined(_id_C0B5AEFDDE135C6D)) {
    spawnorigin = _id_C0B5AEFDDE135C6D.origin;
    _id_7E52B56769FA7774::loothide(_id_C0B5AEFDDE135C6D);
    radio = spawnscriptable("brloot_pmc_unobserved_radio", spawnorigin);
    radio._id_276AC5E84835EA87 = door._id_276AC5E84835EA87;
  }
}

_id_CD8C827E2B6115EA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(player _id_7C03AB87C5F9F420::_id_D3B190EE881C5CA7()) {
    instance setscriptablepartstate("brloot_pmc_unobserved_radio", "visible_unusable");
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "unobserved_activated_radio", 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_CC75A90D4B9108B1.size; _id_AC0E594AC96AA3A8++) {
      _id_AB70AE90BE101A99 = _id_7BBDBBC6CB745DC6(int(level._id_CC75A90D4B9108B1[_id_AC0E594AC96AA3A8]));
      playsoundatpos(instance.origin, _id_AB70AE90BE101A99);
      wait(getdvarfloat("dvar_291C19B0A2EB5CE4", 1.0));
    }

    instance setscriptablepartstate("brloot_pmc_unobserved_radio", "visible");
  } else
    player scripts\mp\hud_message::showerrormessage("MP/ACTIVATE_DISGUISE_ERROR");
}

_id_7BBDBBC6CB745DC6(_id_506303DCA407BFE6) {
  _id_7C06C0A232E7E6EA = "";

  switch (_id_506303DCA407BFE6) {
    case 0:
      _id_7C06C0A232E7E6EA = "zero";
      break;
    case 1:
      _id_7C06C0A232E7E6EA = "one";
      break;
    case 2:
      _id_7C06C0A232E7E6EA = "two";
      break;
    case 3:
      _id_7C06C0A232E7E6EA = "three";
      break;
    case 4:
      _id_7C06C0A232E7E6EA = "four";
      break;
    case 5:
      _id_7C06C0A232E7E6EA = "five";
      break;
    case 6:
      _id_7C06C0A232E7E6EA = "six";
      break;
    case 7:
      _id_7C06C0A232E7E6EA = "seven";
      break;
    case 8:
      _id_7C06C0A232E7E6EA = "eight";
      break;
    case 9:
      _id_7C06C0A232E7E6EA = "nine";
      break;
    default:
      _id_7C06C0A232E7E6EA = "zero";
      break;
  }

  return "dx_br_bds5_fcms_cmpv_" + _id_7C06C0A232E7E6EA;
}

_id_562889DF3A616506() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2()) {
    _id_2B63ED707BD0B362 = getentitylessscriptablearray("scriptable_un_office_computer_monitor_01_169", "classname", (-919, 828, 451), 20);

    if(isDefined(_id_2B63ED707BD0B362) && _id_2B63ED707BD0B362.size > 0) {
      _id_2B63ED707BD0B362[0] setscriptablepartstate("screen", "bink2");

      if(isDefined(level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8))
        level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8[14] = "pmc_cartel_computer";
    }
  }

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    _id_740D31FEB555E99E = scripts\engine\utility::getStruct("pmc_cartel_boat", "targetname");

    if(isDefined(_id_740D31FEB555E99E)) {
      _id_E2E4A2412ACAFDA7 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", _id_740D31FEB555E99E);
      _id_536A5C2E42582B98 = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(_id_E2E4A2412ACAFDA7, "iw9_mg_patrol_boat_back_mp");
      _id_536A5C2E42582B98._id_A682A8256C580B8C = _id_536A5C2E42582B98._id_9F925F5509626DF1;
      _id_536A5C2E42582B98._id_9F925F5509626DF1 = (-100, 45, -7);
      _id_107050C9B895DD07 = spawn("script_model", _id_E2E4A2412ACAFDA7.origin + (0, 0, 5) + anglesToForward(_id_E2E4A2412ACAFDA7.angles) * -90);
      _id_107050C9B895DD07.angles = _id_E2E4A2412ACAFDA7.angles;
      _id_107050C9B895DD07 setModel("pmc_cartel_cargo");
      _id_107050C9B895DD07 linkTo(_id_E2E4A2412ACAFDA7);
      _id_E2E4A2412ACAFDA7.payload = _id_107050C9B895DD07;

      if(isDefined(_id_107050C9B895DD07.objidnum))
        level._id_F49DEAF34CD1A04A = _id_107050C9B895DD07.objidnum;

      thread _id_0A62705CB078EC0A::_id_CF8F787850F621F9(_id_E2E4A2412ACAFDA7);
    }
  }
}

_id_48864D898E5100C0() {
  if(!scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    return;
  }
  level._id_C162C5E269F54CBF = spawnStruct();
  level._id_C162C5E269F54CBF.nodes = [];
  _id_D7DCF29BC306D383 = scripts\engine\utility::getStructArray("pmc_terminal_bombsite", "script_noteworthy");

  foreach(node in _id_D7DCF29BC306D383) {
    site = spawnscriptable("dmz_supply_site", node.origin, node.angles);
    site._id_DC9F380321BCBE98 = spawnscriptable("dmz_supply_site_use_pmc", site.origin);
    site.node = node;
    node.site = site;
    node._id_DC9F380321BCBE98 = site._id_DC9F380321BCBE98;
    node._id_DC9F380321BCBE98.node = node;
    node._id_B8EBE3F71A08AB40 = spawnStruct();
    node._id_C01591CD513B7E46 = 1;
    node._id_3DBA99677FD840CD = ::_id_7EF66059655C6E3E;
    node.curorigin = site.origin;
    node.offset3d = (0, 0, 15);
    node scripts\mp\gameobjects::requestid(0, 0, undefined, 1);
    objid = node.objidnum;
    scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_obj_bomb_collect");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
    scripts\mp\objidpoolmanager::update_objective_position(objid, node.origin + (0, 0, 15));
    scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
    scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
    scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
    site._id_DC9F380321BCBE98 setscriptablepartstate("dmz_supply_site_use_pmc", "usable");
    node.trigger = spawn("trigger_radius", node.origin, 0, int(128), int(512));
    node.trigger scripts\engine\utility::trigger_off();
    node thread _id_1E1FB042A28726E6(node.trigger, 512);
    level._id_C162C5E269F54CBF.nodes[level._id_C162C5E269F54CBF.nodes.size] = node;
    thread _id_B7FA1E109D78DFE5(node);
  }

  _id_7944BBB983082099 = scripts\engine\utility::getStructArray("pmc_terminal_safe", "script_noteworthy");

  foreach(node in _id_7944BBB983082099) {
    _id_32605DB102447D94 = spawnscriptable("dmz_safe_pmc_terminal", node.origin, node.angles);
    _id_32605DB102447D94.curorigin = _id_32605DB102447D94.origin;
    _id_32605DB102447D94.offset3d = (0, 0, 15);
    _id_32605DB102447D94 scripts\mp\gameobjects::requestid(0, 0, undefined, 1);
    objid = _id_32605DB102447D94.objidnum;
    scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_safe");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
    scripts\mp\objidpoolmanager::update_objective_position(objid, _id_32605DB102447D94.origin + (0, 0, 15));
    scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
    scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);

    if(level._id_AC29BBE3A85FC5FA._id_F73C5AA20A9C44D5)
      scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
    else
      scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);

    scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
    _id_32605DB102447D94.node = node;
    node._id_32605DB102447D94 = _id_32605DB102447D94;
    level._id_C162C5E269F54CBF.nodes[level._id_C162C5E269F54CBF.nodes.size] = node;
    _id_32605DB102447D94 setscriptablepartstate("safe", "usable_not_open");
    _id_32605DB102447D94.trigger = spawn("trigger_radius", _id_32605DB102447D94.node.origin, 0, int(128), int(512));
    _id_32605DB102447D94.trigger scripts\engine\utility::trigger_off();
    _id_32605DB102447D94.capturetime = getdvarint("dvar_AAF56E4808EAD990", 480);
    _id_32605DB102447D94._id_4E29111F80D17365 = [];
    _id_32605DB102447D94 thread _id_662CBAC61C1AE7E2::_id_474E2E9B4A997564(_id_32605DB102447D94.trigger, 512);
    _id_32605DB102447D94._id_CEB543956C7203E7 = _id_662CBAC61C1AE7E2::_id_9618CC73546D253D;
    _id_32605DB102447D94._id_AB0E150EDA2B5E13 = ::_id_2D2046E72A3653FB;
    node._id_3DBA99677FD840CD = ::_id_1C9E346732C1DCC5;
  }

  thread _id_139ABFF6182EEBCB();

  if(getdvarint("dvar_DD42F7C88CF36A4B", 1)) {
    foreach(node in level._id_C162C5E269F54CBF.nodes)
    thread _id_2039E3A5F09B1A11(node);
  }

  scripts\mp\flags::_id_1240434F4201AC9D("fortress_system_init");
  level._id_C162C5E269F54CBF._id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_888D8429A71C944C("delta_terminal");
  level._id_C162C5E269F54CBF._id_276AC5E84835EA87._id_A42C3E0E1B2DC645 = "cartel";
}

_id_139ABFF6182EEBCB() {
  level endon("game_ended");
  _id_2C728360E4C9326A = [getdvarint("dvar_AFBCA5BB4491C0A5", 45), getdvarint("dvar_4D898EBBB795902F", 30), getdvarint("dvar_2436B93C12EB7965", 20), getdvarint("dvar_366C7231D6D96A73", 15), getdvarint("dvar_1D332131C5BF6C97", 10)];
  _id_6068CCE0AEC83591 = 0;

  for(;;) {
    foreach(node in level._id_C162C5E269F54CBF.nodes) {
      if(istrue(node._id_ED9A173473282EAB)) {
        if(!istrue(_id_6068CCE0AEC83591)) {
          _id_4948CDF739393D2D::_id_A113CF2BE454F78D(level._id_C162C5E269F54CBF._id_276AC5E84835EA87);
          _id_6068CCE0AEC83591 = 1;
        }

        _id_34E72E17A2410A72 = 0;

        foreach(_id_715887858D481E40 in level._id_C162C5E269F54CBF.nodes)
        _id_34E72E17A2410A72 = _id_34E72E17A2410A72 + istrue(_id_715887858D481E40._id_ED9A173473282EAB);

        _id_A30AD7C4A9B45232(node.origin, _id_34E72E17A2410A72);
        waittime = _id_2C728360E4C9326A[_id_34E72E17A2410A72 - 1];

        if(isDefined(waittime))
          wait(waittime);
      }
    }

    wait 1;
  }
}

_id_A30AD7C4A9B45232(origin, count) {
  agents = undefined;

  while(!isDefined(agents)) {
    numagents = getdvarint("dvar_53BFA830ADD0AB24", 4);

    if(count >= 4)
      numagents = numagents + 2;

    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(numagents, origin, "high", "mission", "demoReinforcements", undefined, undefined, undefined, undefined, "Helicopter");

    if(!isDefined(agents))
      wait 1.0;
  }
}

_id_2039E3A5F09B1A11(node) {
  level endon("game_ended");

  for(;;) {
    if(istrue(node._id_ED9A173473282EAB)) {
      agents = scripts\common\utility::agentsnear(node.origin, 500);

      foreach(agent in agents)
      thread _id_8CA392C7633466C3(node, agent);
    }

    wait 1;
  }
}

_id_8CA392C7633466C3(node, agent) {
  level endon("game_ended");

  if(istrue(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "pmc_terminalWatchAgentDisarmTimer"))) {
    return;
  }
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "pmc_terminalWatchAgentDisarmTimer", 1);
  _id_4FE918623E730B5A = getdvarint("dvar_4989DD8F2D0EB10F", 6);
  timeremaining = _id_4FE918623E730B5A;

  for(;;) {
    if(!isDefined(agent) || !isalive(agent)) {
      return;
    }
    distance = distance(agent.origin, node.origin);

    if(!istrue(node._id_ED9A173473282EAB) || istrue(node.paused) || distance > 500) {
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "pmc_terminalWatchAgentDisarmTimer", 0);
      return;
    }

    if(distance <= 200) {
      contents = scripts\engine\trace::create_contents(0, 1, 1, 0);
      ignore = [];

      if(isDefined(node._id_32605DB102447D94))
        ignore[ignore.size] = node._id_32605DB102447D94;

      info = physics_raycast(node.origin + (0, 0, 65), agent.origin + (0, 0, 50), contents, undefined, 0, "physicsquery_closest", 1, 0);

      if(!info.size || !isDefined(info[0]["hittype"])) {
        timeremaining = timeremaining - level.framedurationseconds;

        if(timeremaining <= 0) {
          players = scripts\common\utility::_id_0A92D0739B2373DF(node.origin, 500, 1);

          if(!players.size)
            node[[node._id_3DBA99677FD840CD]](agent);

          _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "pmc_terminalWatchAgentDisarmTimer", 0);
          return;
        }
      } else {}
    } else if(distance <= 500) {
      _id_120270BD0A747A35::_id_A5117518725DA028(agent, node.origin, 0, 0, 0);
      timeremaining = _id_4FE918623E730B5A;
    }

    waitframe();
  }
}

_id_B7FA1E109D78DFE5(node) {
  for(;;) {
    node waittill("bomb_planted");
    node._id_78122E18403A8DC4 = [];
    scripts\mp\objidpoolmanager::update_objective_state(node.objidnum, "current");
    scripts\mp\objidpoolmanager::objective_show_progress(node.objidnum, 1);
    node.trigger scripts\engine\utility::trigger_on();
    node._id_DC9F380321BCBE98.origin = node.plantedbomb.origin;
    node._id_DC9F380321BCBE98 setscriptablepartstate("dmz_supply_site_use_pmc", "defusable");

    foreach(player in level.players)
    node._id_DC9F380321BCBE98 enablescriptableplayeruse(player);

    node._id_7B45AAAC74192C14 = _id_48814951E916AF89::_id_353FECD1549F5F42(node.plantedbomb.origin, 2048, undefined, 10);
    node.isactive = 1;
    node._id_ED9A173473282EAB = 1;
    node thread _id_DD80845D6200B0DC(getdvarint("dvar_CADC39F51D382105", 360));
    node _id_2E94D8DA4A6ED951();
  }
}

_id_DD80845D6200B0DC(time) {
  level endon("game_ended");
  self endon("bomb_defused");
  _id_849B91807BEE7E34(time);
  _id_58FE895FD0FBE620::_id_ACCEAD05B2C47CB7();
  self._id_ED9A173473282EAB = 0;

  if(isDefined(self._id_06036CD81FE22627))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self._id_06036CD81FE22627, "destroy_terminal_supplies", 1);

  wait 0.1;
  self._id_DC9F380321BCBE98 freescriptable();
}

_id_849B91807BEE7E34(time) {
  _id_90FB369A18926018 = [];
  thread _id_9DFA2432E378262A(time);
  starttime = gettime();
  offset = 5;
  totaltime = time + offset;
  self.plantedbomb thread _id_58FE895FD0FBE620::playtickingsound(time, offset);
  self.timeremaining = totaltime;

  for(;;) {
    currenttime = gettime();
    duration = (currenttime - starttime) / 1000;
    _id_0DE2C2A1FD468B5F = 1 - duration / time;
    progress = clamp(_id_0DE2C2A1FD468B5F, 0, 1);
    self.timeremaining = totaltime - duration;
    _id_90FB369A18926018 = _id_5DF48BE36D20A070(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress, &"MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_PROGRESS_TEXT");
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

    if(self.timeremaining <= 0) {
      self notify("bomb_exploded");
      break;
    }

    waitframe();
  }
}

_id_5DF48BE36D20A070(_id_78122E18403A8DC4, _id_90FB369A18926018, progress, text) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.team) && !scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_show_player_progress(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(text, player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(2, player);
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_hide_player_progress(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_9DFA2432E378262A(timer) {
  level endon("game_ended");
  self endon("bomb_defused");
  wait(timer);
  self._id_DC9F380321BCBE98 setscriptablepartstate("dmz_supply_site_use_pmc", "unusable", 0);
}

_id_2E94D8DA4A6ED951() {
  level endon("game_ended");
  self endon("bomb_exploded");
  self waittill("bomb_defused");
  self._id_DC9F380321BCBE98 setscriptablepartstate("dmz_supply_site_use_pmc", "usable", 0);

  foreach(player in self._id_78122E18403A8DC4)
  scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);

  self._id_78122E18403A8DC4 = [];
  _id_379D6BAD84E53438 = self._id_BD6089532051AA97;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_demo_defused_lose", scripts\mp\utility\teams::getteamdata(_id_379D6BAD84E53438, "players"));

  if(isDefined(self._id_285292A6695A1FCA))
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onBombDefused", self._id_285292A6695A1FCA);

  self._id_ED9A173473282EAB = 0;
  self._id_DC9F380321BCBE98.origin = self.origin;
  self.plantedbomb delete();
}

_id_7EF66059655C6E3E(agent) {
  self notify("bomb_defused");
}

_id_1E1FB042A28726E6(trigger, radius) {
  level endon("game_ended");
  self endon("bomb_exploded");
  self._id_78122E18403A8DC4 = [];
  self.teams = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, player);
    thread _id_34A83EF704F155D7(trigger, player, radius);
  }
}

_id_34A83EF704F155D7(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2)
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}

_id_EC7E73044204B1CF(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part != "dmz_supply_site_use_pmc") {
    return;
  }
  if(state == "usable") {
    instance setscriptablepartstate("dmz_supply_site_use_pmc", "unusable");
    node = instance.node;

    if(isDefined(node._id_8E977040CC228632) && istrue(node._id_8E977040CC228632)) {
      return;
    }
    node._id_8E977040CC228632 = 1;
    bomb = _id_58FE895FD0FBE620::_id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < 5) {
      if(node._id_A4CF15C49F3E9EEF || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
        node._id_8E977040CC228632 = 0;
        _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
        instance setscriptablepartstate("dmz_supply_site_use_pmc", "usable", 0);
        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    origin = player.origin;
    _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
    _id_EEB138FAE3842A92 = spawn("script_model", origin);
    _id_EEB138FAE3842A92 setModel("offhand_2h_wm_briefcase_bomb_v0");
    _id_EEB138FAE3842A92.visuals = [];
    _id_EEB138FAE3842A92.visuals[0] = spawn("script_model", origin);
    _id_EEB138FAE3842A92.visuals[0] setModel("tag_origin");
    _id_EEB138FAE3842A92.curorigin = origin;
    _id_EEB138FAE3842A92.offset3d = (0, 0, 15);
    _id_EEB138FAE3842A92.safeorigin = origin;
    _id_EEB138FAE3842A92.trigger = spawnStruct();
    _id_EEB138FAE3842A92.icon = -1;
    _id_EEB138FAE3842A92.owner = player;
    _id_EEB138FAE3842A92 scripts\mp\gameobjects::setdropped(undefined, undefined, 1);
    node.plantedbomb = _id_EEB138FAE3842A92;
    node.plantedbomb.node = node;
    node.bombplanted = 1;
    node._id_06036CD81FE22627 = player;
    node._id_BD6089532051AA97 = player.team;
    node._id_8E977040CC228632 = 0;
    node notify("bomb_planted");
  } else if(state == "defusable") {
    instance setscriptablepartstate("dmz_supply_site_use_pmc", "unusable");
    node = instance.node;

    if(isDefined(node._id_482C2428A4E2FDDC) && istrue(node._id_482C2428A4E2FDDC)) {
      return;
    }
    node._id_482C2428A4E2FDDC = 1;
    node.plantedbomb hide();
    bomb = _id_58FE895FD0FBE620::_id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < 5) {
      if(node._id_A4CF15C49F3E9EEF || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
        node._id_482C2428A4E2FDDC = 0;
        _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
        node.plantedbomb show();
        instance setscriptablepartstate("dmz_supply_site_use_pmc", "defusable");

        foreach(player in level.players)
        instance enablescriptableplayeruse(player);

        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    node._id_285292A6695A1FCA = player;
    node._id_482C2428A4E2FDDC = 0;
    node notify("bomb_defused");
    _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);

    if(isDefined(node.plantedbomb))
      node.plantedbomb show();
  }
}

_id_2D2046E72A3653FB(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team)) {
    return;
  }
  if(!_id_662CBAC61C1AE7E2::_id_9AB4D7EA05385788(player))
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
  else if(state == "usable_not_open") {
    instance setscriptablepartstate(part, "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance thread _id_662CBAC61C1AE7E2::_id_24765A7AABF0093E(player);
    instance _id_662CBAC61C1AE7E2::_id_7F10E8E120314F4B(player, part);

    if(istrue(instance._id_B14A331BA425C286)) {
      instance.teams = [player.team];
      instance.trigger scripts\engine\utility::trigger_on();
      _id_5307834CD39B435C::_id_1C2BD1696D29935B(player.team, "dmz_mission_safe_opening");
      scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "current");
      scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
      instance thread _id_C606A52499149C25();
      wait 1.0;
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_safe_defend_started", scripts\mp\utility\teams::getteamdata(player.team, "players"), instance.node._id_B205D90302DA2F07);
    } else
      instance setscriptablepartstate(part, "usable_not_open");
  } else {
    if(state == "usable_drilling") {
      instance.node.paused = 0;
      instance._id_78122E18403A8DC4 = [];
      instance setscriptablepartstate("safe", "unusable_drilling");
      return;
    }

    if(state == "open_usable") {
      if(instance getscriptableparthasstate("safe", "unusable"))
        instance setscriptablepartstate("safe", "unusable");

      if(!isDefined(instance.contents)) {
        _id_9256A8C4667BAA69 = getdvarint("dvar_4C9B0494A5FFAC13", 2);
        items = _id_552B8E4EA5FF7DF1::_id_A76B46F057488CC0(instance, player.team, 23, _id_9256A8C4667BAA69);
        instance._id_46A3A8565AC0C17C = 4;
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
        instance _id_662CBAC61C1AE7E2::_id_20D58C7FB1074FC6(player.team);
      } else
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
    }
  }
}

_id_C606A52499149C25() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.progress = 0;
  _id_90FB369A18926018 = [];
  self.node.isactive = 1;
  self.node._id_ED9A173473282EAB = 1;

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!istrue(self.node.paused)) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      }

      progress = self.progress / self.capturetime;
      text = scripts\engine\utility::ter_op(istrue(self.node.paused), &"MP_DMZ_MISSIONS/SAFE_PAUSED", &"MP_DMZ_MISSIONS/OPENING_SAFE");
      _id_90FB369A18926018 = _id_5DF48BE36D20A070(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress, text);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        _id_662CBAC61C1AE7E2::_id_67ABFC6A70AF2CCC();
        self.node._id_ED9A173473282EAB = 0;

        foreach(team in self.teams)
        _id_8A7A2427622E7572(team, "terminal_safe_open", 1);
      }
    }

    waitframe();
  }
}

_id_1C9E346732C1DCC5(agent) {
  self.paused = 1;
  self._id_32605DB102447D94 setscriptablepartstate("safe", "usable_drilling");
  self._id_32605DB102447D94._id_78122E18403A8DC4 = [];

  foreach(team in self._id_32605DB102447D94.teams) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_train_safe_paused", players);
  }
}

_id_C0849326027254F0() {
  scriptable = "brloot_volatile_decoy_grenade";
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptable);
  scripts\cp_mp\utility\script_utility::registersharedfunc(scriptable, "delete", ::_id_29DDD40932B14EDB);
  scripts\cp_mp\utility\script_utility::registersharedfunc(scriptable, "dropped", ::_id_B46D7D7D4ECCDA8C);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "addedToContainer", ::_id_5DF8CF35B1DE080C);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "pickedUp", ::_id_32CB9876A487C40F);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "addedToDeadDrop", ::_id_BE5AF8DC2F94E2EE);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "extracted", ::_id_792282E9CEDE4876);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "onItemSold", ::_id_54E94E9563ADFF5E);
  level._id_877F557047D60FB5 = spawnscriptable("pmc_volatile_decoy_grenade", (0, 0, 0), (0, 0, 0));
  thread _id_C7CFD1AD1977F03E();
  thread _id_39564755F8F1046B();
}

_id_39564755F8F1046B() {
  level endon("game_ended");
  level._id_877F557047D60FB5 endon("death");

  for(;;) {
    if(isDefined(level._id_877F557047D60FB5.targetent))
      level._id_877F557047D60FB5.origin = level._id_877F557047D60FB5.targetent.origin + (0, 0, 50);

    waitframe();
  }
}

_id_C7CFD1AD1977F03E() {
  level endon("game_ended");
  level._id_877F557047D60FB5 endon("death");
  firetypes = ["ar", "smg", "sniper"];
  _id_D95C5AD4A266E91F = ["footFallSoundsA", "footFallSoundsB"];
  _id_9A9572BA98E9E9EC = ["footFallsSprint", "footFallsWalk"];

  for(;;) {
    if(istrue(level._id_877F557047D60FB5._id_7309E8A5EF4BC197)) {
      _id_A6F6BC31EB056D92 = randomfloat(1.0) > 0.65;

      if(_id_A6F6BC31EB056D92) {
        _id_E14619CB2CF279CA = randomintrange(6, 12);
        _id_FD5D79D7E8A4C916 = scripts\engine\utility::random(_id_D95C5AD4A266E91F);
        _id_9C7E57C8DB70BA17 = scripts\engine\utility::random(_id_9A9572BA98E9E9EC);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E14619CB2CF279CA; _id_AC0E594AC96AA3A8++) {
          if(istrue(level._id_877F557047D60FB5._id_7309E8A5EF4BC197)) {
            level._id_877F557047D60FB5 setscriptablepartstate(_id_FD5D79D7E8A4C916, _id_9C7E57C8DB70BA17);

            if(_id_FD5D79D7E8A4C916 == "footFallSoundsA")
              _id_FD5D79D7E8A4C916 = "footFallSoundsB";
            else
              _id_FD5D79D7E8A4C916 = "footFallSoundsA";
          }

          wait 0.15;
        }
      } else {
        firetype = scripts\engine\utility::random(firetypes);
        _id_A2A92143787D00A4 = 1 + randomint(level.decoygrenadedata.firemaxcounts[firetype]);
        level._id_877F557047D60FB5 setscriptablepartstate("weaponSounds", firetype + "Fire", 0);
        _id_5C362DCAAA44CDF0 = scripts\common\utility::_id_98A826B6B6D0D118(level._id_877F557047D60FB5.origin, 2000, undefined, 1000, 0);

        foreach(agent in _id_5C362DCAAA44CDF0)
        agent aieventlistenerevent("gunshot", level._id_877F557047D60FB5.targetent, level._id_877F557047D60FB5.origin);

        wait(level.decoygrenadedata.firetimes[firetype]);
      }
    }

    _id_3E3E41683DC1BCDD = randomfloatrange(1.0, 5.0);
    wait(_id_3E3E41683DC1BCDD);
  }
}

_id_32CB9876A487C40F(scriptable, player) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 1;
  level._id_877F557047D60FB5.origin = player.origin;
  level._id_877F557047D60FB5.targetent = player;
}

_id_5DF8CF35B1DE080C(_id_69E96A4CAA72D794, player) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 1;
  level._id_877F557047D60FB5.targetent = undefined;
  level._id_877F557047D60FB5.origin = _id_69E96A4CAA72D794.origin;
}

_id_B46D7D7D4ECCDA8C(pickup, player, origin) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 1;
  level._id_877F557047D60FB5.targetent = undefined;
  level._id_877F557047D60FB5.origin = origin;
}

_id_BE5AF8DC2F94E2EE(_id_5793A0CF9D352C92, lootid) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 1;
  level._id_877F557047D60FB5.targetent = undefined;
  level._id_877F557047D60FB5.origin = _id_5793A0CF9D352C92.origin;
  return [lootid, 0];
}

_id_29DDD40932B14EDB() {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 0;
  level._id_877F557047D60FB5.targetent = undefined;
}

_id_792282E9CEDE4876(player, item) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 0;
  level._id_877F557047D60FB5.targetent = undefined;
}

_id_54E94E9563ADFF5E(player, lootid, type, _id_09FB3B576439EE3D, _id_B87F7FAE01CE754F) {
  level._id_877F557047D60FB5._id_7309E8A5EF4BC197 = 0;
  level._id_877F557047D60FB5.targetent = undefined;
}

_id_83BA07B9CB8B0809() {
  spawn = scripts\engine\utility::getStruct("pmc_biolabs_hostage", "script_noteworthy");

  if(isDefined(spawn)) {
    scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
    _id_325F3808645AD9E2 = spawnStruct();
    _id_325F3808645AD9E2.teams = [];
    _id_325F3808645AD9E2.node = spawnStruct();
    _id_325F3808645AD9E2.node.target = "fake_debug_hostage";
    _id_325F3808645AD9E2._id_2F893D4A9CBF8A5C = 1;
    _id_679AFEF82BB8E515 = spawnStruct();
    spawn.targetname = "fake_debug_hostage";
    spawn.script_noteworthy = "hostage";
    scripts\engine\utility::_id_1F6C1A9B7564DC61(spawn);
    _id_325F3808645AD9E2 _id_241FF3C86D02A28D::_id_B6B601986DCAD85A();
    _id_325F3808645AD9E2.instance setscriptablepartstate("dmz_hostage", "remaining");

    foreach(player in level.players)
    _id_325F3808645AD9E2.instance enablescriptableplayeruse(player);
  }
}

_id_FF7F720788558A70(agent, players) {
  _id_1B8524F934EDD790 = [];

  foreach(player in players) {
    if(isDefined(player.team) && !scripts\engine\utility::array_contains(_id_1B8524F934EDD790, player.team))
      _id_1B8524F934EDD790 = scripts\engine\utility::array_add(_id_1B8524F934EDD790, player.team);
  }

  foreach(team in _id_1B8524F934EDD790)
  _id_8A7A2427622E7572(team, "pmc_biolabs_hostage_exfil", 1);
}

_id_B74AD2C2C1691B18() {
  if(!scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    return;
  }
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("pmc_radiation_safe", "script_noteworthy");
  scripts\mp\flags::_id_1240434F4201AC9D("radiation_initialized");

  foreach(node in _id_9E4E1482CB40C9C5) {
    if(_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(node.origin)) {
      _id_32605DB102447D94 = spawnscriptable("dmz_safe_pmc_terminal", node.origin, node.angles);
      _id_32605DB102447D94.curorigin = _id_32605DB102447D94.origin;
      _id_32605DB102447D94.offset3d = (0, 0, 15);
      _id_32605DB102447D94 scripts\mp\gameobjects::requestid(0, 0, undefined, 1);
      objid = _id_32605DB102447D94.objidnum;
      scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_safe");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
      scripts\mp\objidpoolmanager::update_objective_position(objid, _id_32605DB102447D94.origin + (0, 0, 15));
      scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
      scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);

      if(level._id_AC29BBE3A85FC5FA._id_F73C5AA20A9C44D5)
        scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
      else
        scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);

      scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
      _id_32605DB102447D94.node = node;
      node._id_32605DB102447D94 = _id_32605DB102447D94;
      _id_32605DB102447D94 setscriptablepartstate("safe", "usable_not_open");
      _id_32605DB102447D94.trigger = spawn("trigger_radius", _id_32605DB102447D94.node.origin, 0, int(128), int(512));
      _id_32605DB102447D94.trigger scripts\engine\utility::trigger_off();
      _id_32605DB102447D94.capturetime = getdvarint("dvar_6045836C04E4D385", 300);
      _id_32605DB102447D94._id_4E29111F80D17365 = [];
      _id_32605DB102447D94 thread _id_662CBAC61C1AE7E2::_id_474E2E9B4A997564(_id_32605DB102447D94.trigger, 512);
      _id_32605DB102447D94._id_CEB543956C7203E7 = _id_662CBAC61C1AE7E2::_id_9618CC73546D253D;
      _id_32605DB102447D94._id_AB0E150EDA2B5E13 = ::_id_C9EC79155B2119BA;
      break;
    }
  }
}

_id_C9EC79155B2119BA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team)) {
    return;
  }
  if(!_id_662CBAC61C1AE7E2::_id_9AB4D7EA05385788(player))
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
  else {
    if(state == "usable_not_open") {
      instance setscriptablepartstate(part, "unusable");
      instance._id_B14A331BA425C286 = 0;
      instance thread _id_662CBAC61C1AE7E2::_id_24765A7AABF0093E(player);
      instance _id_662CBAC61C1AE7E2::_id_7F10E8E120314F4B(player, part);

      if(istrue(instance._id_B14A331BA425C286)) {
        instance.teams = [player.team];
        instance.trigger scripts\engine\utility::trigger_on();
        _id_5307834CD39B435C::_id_1C2BD1696D29935B(player.team, "dmz_mission_safe_opening");
        scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "current");
        scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
        instance thread _id_065CCF76EA342606();
        wait 1.0;
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_safe_defend_started", scripts\mp\utility\teams::getteamdata(player.team, "players"), instance.node._id_B205D90302DA2F07);
        return;
      }

      instance setscriptablepartstate(part, "usable_not_open");
      return;
      return;
    }

    if(state == "open_usable") {
      if(instance getscriptableparthasstate("safe", "unusable"))
        instance setscriptablepartstate("safe", "unusable");

      if(!isDefined(instance.contents)) {
        lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_irradiated_gas_canister");
        instance _id_552B8E4EA5FF7DF1::_id_D683A60016231237(lootid, 1);
        instance._id_46A3A8565AC0C17C = 4;
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
        instance _id_662CBAC61C1AE7E2::_id_20D58C7FB1074FC6(player.team);
      } else
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
    }
  }
}

_id_065CCF76EA342606() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.progress = 0;
  _id_A81135442EE1A731 = 0;
  _id_90FB369A18926018 = [];
  _id_C07A32453726222F = 0;

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      currenttime = gettime();

      if(self._id_78122E18403A8DC4.size > 0) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
      }

      progress = self.progress / self.capturetime;
      _id_90FB369A18926018 = _id_662CBAC61C1AE7E2::_id_075A1596E8181156(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        foreach(team in self.teams)
        _id_8A7A2427622E7572(team, "pmc_radiation_safe_open", 1);

        _id_662CBAC61C1AE7E2::_id_67ABFC6A70AF2CCC();
      } else if(self._id_78122E18403A8DC4.size > 0 && _id_C07A32453726222F + 45000 < currenttime) {
        _id_C07A32453726222F = currenttime;
        _id_F7D8DF490BD332C3 = 2816;
        agents = _id_48814951E916AF89::_id_353FECD1549F5F42(self.origin, _id_F7D8DF490BD332C3, undefined, 3, undefined, 64, 128);

        if(isDefined(agents)) {
          self.agents = scripts\engine\utility::array_combine(self.agents, agents);
          _id_A81135442EE1A731 = _id_A81135442EE1A731 + agents.size;
        }

        _id_DA117CA38EFAC51B = _id_48814951E916AF89::_id_77ACC10C4823DD8A(6, self.origin, "high", "mission", "safeReinforcements", undefined, undefined, undefined, undefined, "Helicopter", 32, 64);

        if(isDefined(_id_DA117CA38EFAC51B) && _id_DA117CA38EFAC51B.size > 0) {
          _id_7CC37D084D5E863C = 1;
          self.agents = scripts\engine\utility::array_combine(self.agents, _id_DA117CA38EFAC51B);
        }
      }
    }

    waitframe();
  }
}