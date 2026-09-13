/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\locksandkeys.gsc
***********************************************/

init() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  precachestring(&"MP_DMZ_LOCKS/LOCKED_FORTRESS");
  precachestring(&"MP_DMZ_LOCKS/STUCK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_TESTUNIQUEDOOR");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_QUARRY_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_QUARRY_CONTROL");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_QUARRY_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_HYDRO_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_HYDRO_APT");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_HYDRO_WEAPONDROP");
  precachestring(&"MP_DMZ_LOCKS/LOCKED");
  precachestring(&"MP_BIO_LAB/CACHE_LOCKED_RED_DOOR");
  precachestring(&"MP_BIO_LAB/CACHE_LOCKED_BLUE_DOOR");
  precachestring(&"MP_BIO_LAB/CACHE_LOCKED_GREEN_DOOR");
  precachestring(&"MP_BIO_LAB/CACHE_LOCKED_BLACK_DOOR");
  precachestring(&"MP_BIO_LAB/CACHE_LOCKED_GOLD_DOOR");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_TRAPPER_DOOR");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_RESORT_ENTRANCE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_FIREFIGHTTEST01");
  precachestring(&"MP_DMZ_LOCKS/LOCKED");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CONFERENCE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_AIRPORT_MAINTENANCE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_UNDERGROUND_SHACK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CLIFF_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_GRAVEYARD_HOUSE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POPPY_HOME");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_WESTERN_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_MOBILE_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CRANE_BUILDING");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POLICE_LOCKERROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SMUGGLERS_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POWER_SUBSTATION");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CELL_PHONE_SHOP");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_BARRACKS");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_LOCKERROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POST_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_TV_STATION");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_NORTH_GUARD_SHACK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SOUTH_GUARD_SHACK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_FORT_BARRACK1");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_ANTIQUITIES_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_MUNITIONS_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS1");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS2");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_QUIET_BEDROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_AUTO_SHOP_SUNKEN");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SERVER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SUNKEN_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SUNKEN_SECOND_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM1");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM2");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_DRESSING_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SEC_CAMERA_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_GAMING_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_FISH_SHACK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_MOUNTAIN_TOP_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SPOTTERS_VIEW");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_GROCERY_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_NEIGH_STORAGE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_APARTMENT_SNIPERNEST");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_DESTROYED_TELESCOPE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_GROUNDSKEEPERS");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_LIGHTHOUSE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SAFE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SCIENTIST_APARTMENT");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SECRET_COMMS");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SIRA_APARTMENT");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SMALL_CONFER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SUPPLY_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_TV_COMPUTER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_YUM_BURGER");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_INTERROGATION_ROOM");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CONTROL_TOWER");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_EXHUME_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_FORT");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SIRA_MALL");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CIVIC_CENTER");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_EMBASSY");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_POST_OFFICE_STRONGHOLD");
  precachestring(&"MP_BIOBUNKER/BOSS_KEY_A_NAME");
  precachestring(&"MP_BIOBUNKER/BOSS_KEY_B_NAME");
  precachestring(&"MP_BIOBUNKER/HUB_KEY_A_NAME");
  precachestring(&"MP_BIOBUNKER/HUB_KEY_B_NAME");
  precachestring(&"MP_BIOBUNKER/WATER_KEY_A_NAME");
  precachestring(&"MP_BIOBUNKER/WATER_KEY_B_NAME");
  precachestring(&"MP_BIOBUNKER/RAD_KEY_A_NAME");
  precachestring(&"MP_BIOBUNKER/RAD_KEY_B_NAME");
  precachestring(&"MP_BIOBUNKER/WORKSHOP_KEY_NEED");
  precachestring(&"MP_BIOBUNKER/STAIRWELL_KEY_NEED");
  precachestring(&"MP_BIOBUNKER/STAIRWELL_KEY_UNLOCK");
  precachestring(&"MP_BIOBUNKER/WORKSHOP_KEY_UNLOCK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_CARTEL_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_SKELETON_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FORTRESS");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_TESTUNIQUEDOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_QUARRY_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_QUARRY_CONTROL");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_QUARRY_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_HYDRO_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_HYDRO_APT");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_HYDRO_WEAPONDROP");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_TRAPPER_DOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_RESORT_ENTRANCE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FIREFIGHTTEST01");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DEADBOLT");
  precachestring(&"MP_DMZ_MISSIONS/TRAP_DOOR_UNLOCK");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CONFERENCE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_AIRPORT_MAINTENANCE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_UNDERGROUND_SHACK");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CLIFF_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_GRAVEYARD_HOUSE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POPPY_HOME");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_WESTERN_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_MOBILE_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CRANE_BUILDING");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POLICE_LOCKERROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SMUGGLERS_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POWER_SUBSTATION");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CELL_PHONE_SHOP");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_BARRACKS");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_LOCKERROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_TV_STATION");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CONTROL_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_NORTH_GUARD_SHACK");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SOUTH_GUARD_SHACK1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FORT_BARRACK1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_ANTIQUITIES_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_MUNITIONS_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS2");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_QUIET_BEDROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_AUTO_SHOP_SUNKEN");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SERVER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SUNKEN_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SUNKEN_SECOND_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM2");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DRESSING_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SEC_CAMERA_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_GAMING_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FISH_SHACK");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_MOUNTAIN_TOP_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SPOTTERS_VIEW");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_GROCERY_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_NEIGH_STORAGE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_APARTMENT_SNIPERNEST");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DESTROYED_TELESCOPE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_GROUNDSKEEPERS");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_LIGHTHOUSE_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SAFE_HOUSE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SCIENTIST_APARTMENT");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SECRET_COMMS");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SIRA_APARTMENT");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SMALL_CONFER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SUPPLY_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_TV_COMPUTER_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_YUM_BURGER");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_INTERROGATION_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CONTROL_TOWER");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_EXHUME_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FORT");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SIRA_MALL");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CIVIC_CENTER");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_EMBASSY");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE_STRONGHOLD");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_CARTEL_WAREHOUSE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_SKELETON_ROOM");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_STRONGOLD_WITH_SKELETON");

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_AQUARIUM");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_AQUARIUM");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_CITYHALL");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_CITYHALL");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_FIRESTATION");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_FIRESTATION");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_OLDMUSEUM");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_OLDMUSEUM");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_STADIUM");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_STADIUM");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_TERMINAL");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_TERMINAL");
    precachestring(&"MP_DMZ_LOCKS/LOCKED_DELTA_TRAINSTATION");
    precachestring(&"MP_DMZ_LOCKS/UNLOCK_DELTA_TRAINSTATION");
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_lock", ::_id_2166C547B0D38235);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_lock_interior", ::_id_EE4E77BC15DA5EAE);
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_6416FB9A24D278B4);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_504F19B32802CB8D);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);
  _id_20466DFC92ECF1A9();
  _id_FAD5181703A528EE();
  _id_B35796A7C0A71079();
  _id_E726302A1F8D9A1A();

  if(getdvarint("scr_disable_unique_doors", 0) != 1)
    _id_3E0F1CEEB525C408();

  _id_E6DF49DDA3F9A00E();
  _id_AF0108718CDDFF00();
  level._id_AB18903AA481FFF2 = _func_F159C10D5CF8F0B4("locked_space_volume", "script_noteworthy");
}

_id_FAD5181703A528EE() {
  level._id_B33C035C483C2893 = [];
  level._id_B33C035C483C2893["onPickup"] = [];
  level._id_B33C035C483C2893["onDrop"] = [];
  level._id_B33C035C483C2893["onMatchStart"] = [];
  level._id_B33C035C483C2893["onExtract"] = [];
}

_id_1420863A23DEAB24(scriptable, player) {
  _id_2BEF23D3DB267F0D = isDefined(player._id_65513AD5397A67EF) && scriptable._id_65513AD5397A67EF == player._id_65513AD5397A67EF;
  _id_4D1155F8BB48272E = isDefined(player._id_B2FB23E638ADC7D2) && scriptable._id_65513AD5397A67EF == player._id_B2FB23E638ADC7D2;
  _id_2DC12170AEAB79FC = isDefined(scriptable._id_B8EBE3F71A08AB40) && istrue(scriptable._id_B8EBE3F71A08AB40._id_0AF8D4CC519C65DE) && isDefined(scriptable._id_B8EBE3F71A08AB40.teams) && isDefined(player.team) && scripts\engine\utility::array_contains(scriptable._id_B8EBE3F71A08AB40.teams, player.team);
  return _id_2BEF23D3DB267F0D || _id_4D1155F8BB48272E || _id_2DC12170AEAB79FC;
}

_id_6416FB9A24D278B4(scriptable, player) {
  if(distance2dsquared(scriptable._id_9BCDD0A1013CC2CB, player.origin) < distance2dsquared(scriptable.node.origin, player.origin)) {
    if(isDefined(scriptable._id_8F7EDDC9C0864A1B) && isstring(scriptable._id_8F7EDDC9C0864A1B) && scriptable._id_8F7EDDC9C0864A1B == "blacksite") {
      _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_" + scriptable._id_8F7EDDC9C0864A1B);

      if(isDefined(_id_ECE2647396F544DF) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_ECE2647396F544DF))
        return _id_54F0BA9AC5666ABA(scriptable._id_8F7EDDC9C0864A1B);
      else
        return _id_94F5E3929619C3D1(scriptable._id_8F7EDDC9C0864A1B);
    }

    return &"MP_DMZ_LOCKS/UNLOCK_DEADBOLT";
  }

  if(isDefined(scriptable._id_8F7EDDC9C0864A1B) && isstring(scriptable._id_8F7EDDC9C0864A1B)) {
    _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_" + scriptable._id_8F7EDDC9C0864A1B);

    if(isDefined(scriptable._id_65513AD5397A67EF)) {
      if(_id_1420863A23DEAB24(scriptable, player)) {
        if(isDefined(scriptable._id_AF0662D6485D5D58))
          return _id_54F0BA9AC5666ABA(scriptable._id_AF0662D6485D5D58);
        else
          return _id_54F0BA9AC5666ABA(scriptable._id_8F7EDDC9C0864A1B);
      } else if(istrue(scriptable._id_8E6BA9B12787EB1D))
        return _id_94F5E3929619C3D1(scriptable._id_8F7EDDC9C0864A1B);
    }

    if(isDefined(_id_ECE2647396F544DF)) {
      if(player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_ECE2647396F544DF))
        return _id_54F0BA9AC5666ABA(scriptable._id_8F7EDDC9C0864A1B);
      else if(_id_92063F2C6A1CA2BF(player) && scriptable._id_8F7EDDC9C0864A1B != "stuck" && !istrue(scriptable._id_8CC59FC7249E7F0F)) {
        if(scriptable._id_8F7EDDC9C0864A1B == "fortress" && (!isDefined(scriptable._id_65513AD5397A67EF) || !_id_1420863A23DEAB24(scriptable, player)))
          return _id_54F0BA9AC5666ABA("stronghold_with_skeleton");
        else if(istrue(scriptable._id_534FFC051D7244A7))
          return _id_94F5E3929619C3D1(scriptable._id_8F7EDDC9C0864A1B);
        else
          return _id_54F0BA9AC5666ABA(scriptable._id_8F7EDDC9C0864A1B);
      } else
        return _id_94F5E3929619C3D1(scriptable._id_8F7EDDC9C0864A1B);
    }
  }

  return &"MP_DMZ_LOCKS/LOCKED";
}

_id_E0E50EF00477DEEB(scriptablename, player, scriptable) {
  if(scriptablename == "loot_key_stuck")
    return 0;

  _id_530052914D6C4A41 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename);

  if(isDefined(_id_530052914D6C4A41) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_530052914D6C4A41))
    return 1;

  _id_AD765BD3479A01A3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename + "_used");

  if(isDefined(_id_AD765BD3479A01A3) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_AD765BD3479A01A3))
    return 1;

  _id_50D0DB530B4B97D8 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename + "_worn");

  if(isDefined(_id_50D0DB530B4B97D8) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_50D0DB530B4B97D8))
    return 1;

  if(isDefined(scriptable) && istrue(scriptable._id_534FFC051D7244A7) || !isDefined(level._id_FC7C751394AB36BA))
    return 0;
  else {
    foreach(index, key in level._id_FC7C751394AB36BA) {
      _id_35FA1149AE3912E5 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(key);

      if(isDefined(_id_35FA1149AE3912E5) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_35FA1149AE3912E5))
        return 1;
    }
  }

  return 0;
}

_id_92063F2C6A1CA2BF(player) {
  _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_skeleton");

  if(player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_ECE2647396F544DF))
    return 1;

  _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_skeleton_used");

  if(player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_ECE2647396F544DF))
    return 1;

  _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_skeleton_worn");

  if(player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_ECE2647396F544DF))
    return 1;

  return 0;
}

_id_B88D3FE223408F2B(scriptable, player, _id_85E3240D30E184E7) {
  success = 0;
  _id_13E8F34633572B1C = 0;
  _id_E25B47370653DED5 = isDefined(scriptable) && isDefined(scriptable.node);

  if(!istrue(_id_E25B47370653DED5))
    return 0;

  if(distance2dsquared(scriptable._id_9BCDD0A1013CC2CB, player.origin) < distance2dsquared(scriptable.node.origin, player.origin)) {
    if(!_id_85E3240D30E184E7) {
      success = 1;
      _id_13E8F34633572B1C = 1;
    } else {
      _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
      traceresults = scripts\engine\trace::ray_trace(player.origin + (0, 0, 16), scriptable._id_9BCDD0A1013CC2CB, player, _id_FBCABD62B8F66EB8);

      if(traceresults["hittype"] == "hittype_none") {
        success = 1;
        _id_13E8F34633572B1C = 1;
      }
    }
  }

  if(isDefined(scriptable._id_65513AD5397A67EF)) {
    if(_id_1420863A23DEAB24(scriptable, player))
      success = 1;
    else if(istrue(scriptable._id_8E6BA9B12787EB1D))
      success = 0;
  }

  if(isDefined(scriptable._id_8F7EDDC9C0864A1B) && isstring(scriptable._id_8F7EDDC9C0864A1B)) {
    if(scriptable._id_8F7EDDC9C0864A1B == "TESTUNIQUEDOOR")
      success = 1;

    if(scriptable._id_8F7EDDC9C0864A1B == "completely_locked")
      return [0, 0];

    _id_8F7EDDC9C0864A1B = scriptable._id_8F7EDDC9C0864A1B;
    _id_6F3309B71AE22D94 = isDefined(scriptable.node.script_noteworthy) && (scriptable.node.script_noteworthy == "lockMe_interior" || scriptable.node.script_noteworthy == "lockme_interior");

    if(istrue(_id_6F3309B71AE22D94))
      _id_8F7EDDC9C0864A1B = scriptable._id_8F7EDDC9C0864A1B + "_interior";

    if(isDefined(scriptable._id_276AC5E84835EA87) && scriptable._id_8F7EDDC9C0864A1B == "fortress" && _id_03314ADD7998AB13::_id_A2DCDCD112310E33(player.team, scriptable._id_276AC5E84835EA87))
      success = 1;

    if(!istrue(scriptable._id_8CC59FC7249E7F0F) && _id_E0E50EF00477DEEB("loot_key_" + _id_8F7EDDC9C0864A1B, player, scriptable) && !istrue(scriptable._id_8E6BA9B12787EB1D))
      success = 1;

    if(_id_8F7EDDC9C0864A1B == "office_quarters1") {
      if(_id_E0E50EF00477DEEB("loot_key_office_quarters2", player, scriptable) && !istrue(scriptable._id_8E6BA9B12787EB1D)) {
        _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters2");
        _id_CF5BC3D609317CC3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters1");
        _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(_id_ECE2647396F544DF);

        if(!isDefined(_id_65B695F0C0D909ED)) {
          _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters2_used");
          _id_CF5BC3D609317CC3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters1_used");
          _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(_id_ECE2647396F544DF);
        }

        if(!isDefined(_id_65B695F0C0D909ED)) {
          _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters2_worn");
          _id_CF5BC3D609317CC3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_office_quarters1_worn");
          _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(_id_ECE2647396F544DF);
        }

        player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_65B695F0C0D909ED);
        _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(player, _id_65B695F0C0D909ED, _id_CF5BC3D609317CC3, 1);
        success = 1;
      }
    }

    _id_06DD4FA9F46B16CE = isDefined(scriptable._id_276AC5E84835EA87) && isDefined(scriptable._id_276AC5E84835EA87.name) && istrue(level._id_BE265257B0C58303);

    if(!istrue(_id_13E8F34633572B1C) && !istrue(_id_6F3309B71AE22D94) && _id_06DD4FA9F46B16CE) {
      tier = scriptable._id_276AC5E84835EA87 _id_744CAD313ED0A87E::_id_B7A9796C95AA8E8D();

      if(isDefined(tier) && tier == "black")
        success = _id_ED2CF116DDA82611(player, scriptable._id_276AC5E84835EA87._id_63A517E15C8177BD, "loot_multi_key_fortress", level._id_CCBB1EB445B88CC0);
    }
  }

  return [success, _id_13E8F34633572B1C];
}

_id_504F19B32802CB8D(scriptable, player, _id_85E3240D30E184E7) {
  success = 0;
  _id_13E8F34633572B1C = 0;
  [success, _id_13E8F34633572B1C] = _id_B88D3FE223408F2B(scriptable, player, _id_85E3240D30E184E7);

  if(istrue(_id_85E3240D30E184E7)) {
    if(!success)
      playsoundatpos(scriptable.node.origin, "mp_door_locked");
    else {
      scriptable._id_FC580ACBD61DA738 = _id_13E8F34633572B1C;

      if(istrue(_id_13E8F34633572B1C))
        playsoundatpos(scriptable.node.origin, "mp_door_unlock_deadbolt");
      else
        playsoundatpos(scriptable.node.origin, "mp_door_unlock_key");
    }
  }

  return success;
}

_id_87997FCEE4A6E14C(scriptable, _id_7BE8AA86A10B27EA) {
  if(isDefined(scriptable) && isDefined(scriptable.type) && scriptable.type == "locked_cache_prompt") {
    return;
  }
  _id_7ECBD4F07F6882D0 = getdvarint("dvar_291AD74097993A0A", 1) == 1;
  _id_BA03253452037335 = 0;
  _id_124C1597FA6FF697 = 0;
  _id_F2075BD612AE5AB7 = 0;
  players = scripts\mp\utility\teams::getteamdata(_id_7BE8AA86A10B27EA.team, "players");

  if(isDefined(scriptable)) {
    _id_8F7EDDC9C0864A1B = scriptable._id_8F7EDDC9C0864A1B;
    _id_A60E40071D04DB92(_id_7BE8AA86A10B27EA, _id_8F7EDDC9C0864A1B);
  }

  if(isDefined(scriptable._id_276AC5E84835EA87)) {
    _id_124C1597FA6FF697 = !istrue(scriptable._id_276AC5E84835EA87._id_732DF8DB084AB0C5);
    _id_F2075BD612AE5AB7 = istrue(scriptable._id_276AC5E84835EA87._id_732DF8DB084AB0C5);

    if(isDefined(scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165)) {
      if(!_id_7ECBD4F07F6882D0) {
        _id_243D9EA347100EF1 = 0;

        foreach(player in players) {
          if(scripts\engine\utility::array_contains(scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165, player)) {
            _id_243D9EA347100EF1 = 1;
            break;
          }
        }

        if(!_id_243D9EA347100EF1) {
          scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165 = scripts\engine\utility::array_combine_unique(scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165, players);
          _id_BA03253452037335 = 1;
        }
      }
    } else {
      scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165 = [];
      scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165 = scripts\engine\utility::array_combine_unique(scriptable._id_276AC5E84835EA87._id_A1F47D5C26653165, players);
      _id_BA03253452037335 = 1;
    }
  } else
    _id_BA03253452037335 = 1;

  if(!_id_BA03253452037335) {
    return;
  }
  foreach(player in players) {
    if(!isDefined(player._id_BD3FCBFDEDA97E97))
      player._id_BD3FCBFDEDA97E97 = 0;

    player._id_BD3FCBFDEDA97E97++;

    if(_id_F2075BD612AE5AB7) {
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F3613BEAE4483DB1");
      continue;
    }

    if(_id_124C1597FA6FF697) {
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_584786512B068A29");
      continue;
    }

    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6C63C18261A7AF97");
  }
}

_id_7D321A63BC56C65C(_id_B835958CE1825933, player, _id_F66668BAB8035A05) {
  _id_50D0DB530B4B97D8 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_B835958CE1825933 + "_worn");

  if(isDefined(_id_50D0DB530B4B97D8) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_50D0DB530B4B97D8))
    return [_id_B835958CE1825933 + "_worn", 2];

  _id_AD765BD3479A01A3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_B835958CE1825933 + "_used");

  if(isDefined(_id_AD765BD3479A01A3) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_AD765BD3479A01A3))
    return [_id_B835958CE1825933 + "_used", 1];

  _id_530052914D6C4A41 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_B835958CE1825933);

  if(isDefined(_id_530052914D6C4A41) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_530052914D6C4A41))
    return [_id_B835958CE1825933, 0];

  if(!istrue(_id_F66668BAB8035A05)) {
    foreach(index, key in level._id_FC7C751394AB36BA) {
      _id_35FA1149AE3912E5 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(key);

      if(isDefined(_id_35FA1149AE3912E5) && player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_35FA1149AE3912E5))
        return [key, index];
    }
  }

  return [undefined, undefined];
}

_id_0475482BFE3FEB25(_id_FD28C1FC64C971B4) {
  _id_FD28C1FC64C971B4 = scripts\mp\utility\script::strip_suffix(_id_FD28C1FC64C971B4, "_worn");
  _id_FD28C1FC64C971B4 = scripts\mp\utility\script::strip_suffix(_id_FD28C1FC64C971B4, "_used");
  return _id_FD28C1FC64C971B4;
}

_id_20381C7B081C3F54(scriptable, player) {
  if(isDefined(scriptable._id_5C493302B016B154))
    scriptable._id_5C493302B016B154 scriptabledoorfreeze(0);

  if(isDefined(scriptable._id_DEF557E8FD5C6763))
    scriptable thread[[scriptable._id_DEF557E8FD5C6763]](scriptable, player);

  player thread _id_83F5CDC3D883507E(scriptable, player);
}

_id_83F5CDC3D883507E(scriptable, player) {
  player endon("death_or_disconnect");
  _id_2AE805B43221A762 = scriptable.origin;

  if(isDefined(scriptable._id_8F7EDDC9C0864A1B) && isstring(scriptable._id_8F7EDDC9C0864A1B)) {
    _id_8F7EDDC9C0864A1B = scriptable._id_8F7EDDC9C0864A1B;
    [scriptablename, _id_2053E168B46CAA6E] = _id_7D321A63BC56C65C("loot_key_" + _id_8F7EDDC9C0864A1B, player);

    if(_id_8F7EDDC9C0864A1B == "fortress" && isDefined(scriptablename) && !scripts\engine\utility::array_contains(level._id_FC7C751394AB36BA, scriptablename)) {
      _id_87997FCEE4A6E14C(scriptable, player);
      return;
    }

    if(isDefined(scriptable._id_65513AD5397A67EF) && _id_1420863A23DEAB24(scriptable, player)) {
      return;
    }
    if(isDefined(scriptablename) && isDefined(_id_2053E168B46CAA6E)) {
      _id_87997FCEE4A6E14C(scriptable, player);

      if(!istrue(scriptable._id_FC580ACBD61DA738)) {
        _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename);
        _id_CF5BC3D609317CC3 = _id_ED1AEA6648BCDC28("loot_key_" + _id_8F7EDDC9C0864A1B, _id_2053E168B46CAA6E);

        if(isDefined(level._id_FC7C751394AB36BA) && scripts\engine\utility::array_contains(level._id_FC7C751394AB36BA, scriptablename))
          _id_CF5BC3D609317CC3 = _id_ED1AEA6648BCDC28("loot_key_skeleton", _id_2053E168B46CAA6E);

        if(!isDefined(_id_CF5BC3D609317CC3)) {
          player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(_id_ECE2647396F544DF, 1);
          wait 1.0;
          playsoundatpos(_id_2AE805B43221A762, "mp_door_key_break");
        } else {
          _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_106B52ED8F680043(_id_ECE2647396F544DF);
          player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_65B695F0C0D909ED);
          _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(player, _id_65B695F0C0D909ED, _id_CF5BC3D609317CC3, 1);
        }
      }
    }
  }
}

_id_ED2CF116DDA82611(player, _id_4E5A0B81AEFB772F, _id_8F7EDDC9C0864A1B, _id_7502F9FEF0559294) {
  _id_ECE2647396F544DF = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_8F7EDDC9C0864A1B);
  _id_DFC9610051655857 = 0;

  if(!isDefined(_id_4E5A0B81AEFB772F))
    return 0;

  if(istrue(_id_7502F9FEF0559294))
    _id_DFC9610051655857 = player _id_2D9D24F7C63AC143::_id_EF5C7EC55E0E20EE(_id_ECE2647396F544DF);
  else
    _id_DFC9610051655857 = player _id_2D9D24F7C63AC143::_id_93F02514431A1F5D(_id_ECE2647396F544DF);

  if(!isDefined(_id_DFC9610051655857))
    return 0;

  if(_id_DFC9610051655857 >= _id_4E5A0B81AEFB772F)
    return 1;

  return 0;
}

_id_830809E6920E8BED(category, _id_8F7EDDC9C0864A1B, callback) {
  level._id_B33C035C483C2893[category][_id_8F7EDDC9C0864A1B] = callback;
}

_id_1A037D5CD64DC892() {
  if(isDefined(level._id_F64C6EF6F688A407)) {
    return;
  }
  level._id_F64C6EF6F688A407 = [];
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(tolower(key), "uniquedoor")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key])
      level._id_F64C6EF6F688A407 = _id_AD1B6ACCBAAB404E(node, level._id_F64C6EF6F688A407, getsubstr(key, 11), 1);
    }
  }
}

_id_3E0F1CEEB525C408() {
  _id_1A037D5CD64DC892();

  foreach(door in level._id_F64C6EF6F688A407) {
    if(istrue(door._id_3D9512B73BDC1514)) {
      door scriptabledoorfreeze(1);
      continue;
    }

    _id_FBBFE6F05EDA5EB1(door);
  }
}

_id_FBBFE6F05EDA5EB1(door) {
  door _meth_9AF4C9B2CC1BF989(1);
}

_id_B092780F9EC4496E(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();
}

_id_4327A2C68EEF5DB9(struct) {
  if(isDefined(struct.target)) {
    doors = getentitylessscriptablearray(struct.target, "targetname");
    return doors;
  }
}

_id_2166C547B0D38235(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _id_A95D35E420C6A968(instance, part, state, player, _id_A5B2C541413AA895);
}

_id_A95D35E420C6A968(instance, part, state, player, _id_A5B2C541413AA895) {
  instance setscriptablepartstate("maphint_lock", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");

  if(getdvarint("dvar_5556498DFFA596FB", 0) == 1 || player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(instance._id_ECE2647396F544DF)) {
    playsoundatpos(instance.origin, "br_keypad_confirm");
    _id_B092780F9EC4496E(instance.door);
    instance._id_624D966650B9EBCC setscriptablepartstate("maphint_lock_interior", "off");

    if(isDefined(instance.door._id_DEF557E8FD5C6763))
      [[instance.door._id_DEF557E8FD5C6763]](instance.door, player);
  } else {
    wait 1;
    instance setscriptablepartstate("maphint_lock", instance._id_8F7EDDC9C0864A1B);
  }
}

_id_EE4E77BC15DA5EAE(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _id_44017CC8B84B87AD(instance, part, state, player, _id_A5B2C541413AA895);
}

_id_44017CC8B84B87AD(instance, part, state, player, _id_A5B2C541413AA895) {
  instance setscriptablepartstate("maphint_lock_interior", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");
  wait 1;
  playsoundatpos(instance.origin, "br_keypad_confirm");
  _id_B092780F9EC4496E(instance.door);
  instance._id_D144AB8AC8538C8E setscriptablepartstate("maphint_lock", "off");

  if(isDefined(instance.door._id_DEF557E8FD5C6763))
    [[instance.door._id_DEF557E8FD5C6763]](instance.door, player);
}

_id_AD1B6ACCBAAB404E(node, _id_FA9E859CA98DCDBF, _id_8F7EDDC9C0864A1B, _id_AE2C4ED794036495) {
  index = _id_FA9E859CA98DCDBF.size;
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(node.origin, 75, 75);
  _id_D319F528390FD526 = 0;

  foreach(door in doors) {
    if(isDefined(door.type) && issubstr(door.type, "invisible")) {
      _id_D319F528390FD526 = 1;
      break;
    }
  }

  if(_id_D319F528390FD526) {
    _id_BE7B958FDBF091C0 = [];

    foreach(door in doors) {
      if(isDefined(door.type) && issubstr(door.type, "invisible")) {
        door setscriptablepartstate("door", "closed");
        _id_BE7B958FDBF091C0[_id_BE7B958FDBF091C0.size] = door;
        continue;
      }

      door setscriptablepartstate("door", "invisible");
    }

    doors = _id_BE7B958FDBF091C0;
  }

  if(doors.size == 2) {
    doors[0]._id_5C493302B016B154 = doors[1];
    doors[1]._id_5C493302B016B154 = doors[0];

    if(0)
      thread scripts\mp\utility\debug::drawsphere(node.origin, 75, 900, (0, 1, 0));
  }

  if(isDefined(doors)) {
    foreach(door in doors) {
      if(isDefined(door)) {
        if(istrue(door._id_67535222A761BDC5) && !istrue(_id_AE2C4ED794036495)) {
          continue;
        }
        _id_FA9E859CA98DCDBF[index] = door;
        _id_FA9E859CA98DCDBF[index]._id_8F7EDDC9C0864A1B = _id_8F7EDDC9C0864A1B;
        _id_FA9E859CA98DCDBF[index]._id_9CCEA499F9E1B693 = node.origin;
        _id_FA9E859CA98DCDBF[index].node = node;

        if(istrue(_id_AE2C4ED794036495))
          _id_FA9E859CA98DCDBF[index]._id_67535222A761BDC5 = 1;

        forward = anglesToForward(node.angles);
        _id_FA9E859CA98DCDBF[index]._id_9BCDD0A1013CC2CB = door._id_9CCEA499F9E1B693 - forward * 25;
        _id_FA9E859CA98DCDBF[index]._id_F87CE576CBF4518A = door._id_9CCEA499F9E1B693 + forward * 60;

        if(0)
          thread scripts\mp\utility\debug::drawline(node.origin, _id_FA9E859CA98DCDBF[index]._id_9BCDD0A1013CC2CB, 300, (1, 0, 0));
      }

      index++;
    }
  }

  return _id_FA9E859CA98DCDBF;
}

_id_E6DF49DDA3F9A00E() {
  level._id_7517E35A3DA8AA2D = [];
  keys = getarraykeys(level.struct_class_names["targetname"]);

  foreach(key in keys) {
    if(issubstr(key, "uniqueBlocker")) {
      foreach(node in level.struct_class_names["targetname"][key]) {
        if(isDefined(node.script_noteworthy))
          level._id_7517E35A3DA8AA2D[level._id_7517E35A3DA8AA2D.size] = node;
      }
    }
  }
}

_id_AF0108718CDDFF00() {
  foreach(node in level._id_7517E35A3DA8AA2D) {
    scriptable = spawnscriptable("fortress_scriptable_props", node.origin, node.angles);
    scriptable setscriptablepartstate("scriptable_prop", node.script_noteworthy);
  }
}

_id_20466DFC92ECF1A9() {
  level._id_24CE016BDB558839 = [];
  level._id_24CE016BDB558839["locked_no_key"] = [];
  level._id_24CE016BDB558839["locked_has_key"] = [];
  level._id_24CE016BDB558839["open"] = [];
  level._id_24CE016BDB558839["locked_no_key"]["fortress"] = &"MP_DMZ_LOCKS/LOCKED_FORTRESS";
  level._id_24CE016BDB558839["locked_no_key"]["stuck"] = &"MP_DMZ_LOCKS/STUCK";
  level._id_24CE016BDB558839["locked_no_key"]["testuniquedoor"] = &"MP_DMZ_LOCKS/LOCKED_TESTUNIQUEDOOR";
  level._id_24CE016BDB558839["locked_no_key"]["quarry_storage"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_STORAGE";
  level._id_24CE016BDB558839["locked_no_key"]["quarry_control"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_CONTROL";
  level._id_24CE016BDB558839["locked_no_key"]["quarry_office"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["hydro_storage"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_STORAGE";
  level._id_24CE016BDB558839["locked_no_key"]["hydro_apt"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_APT";
  level._id_24CE016BDB558839["locked_no_key"]["hydro_weapondrop"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_WEAPONDROP";
  level._id_24CE016BDB558839["locked_no_key"]["hostage_door"] = &"MP_DMZ_MISSIONS/LOCKED_HOSTAGE_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["trap"] = &"MP_DMZ_LOCKS/LOCKED_FORTRESS";
  level._id_24CE016BDB558839["locked_no_key"]["trapper_door"] = &"MP_DMZ_LOCKS/LOCKED_TRAPPER_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["resort_entrance"] = &"MP_DMZ_LOCKS/LOCKED_RESORT_ENTRANCE";
  level._id_24CE016BDB558839["locked_no_key"]["firefighttest01"] = &"MP_DMZ_LOCKS/LOCKED_FIREFIGHTTEST01";
  level._id_24CE016BDB558839["locked_no_key"]["biolab_door"] = &"MP_DMZ_LOCKS/LOCKED";
  level._id_24CE016BDB558839["locked_no_key"]["high_security"] = &"MP_BIO_LAB/CACHE_LOCKED_SECURITY_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["third_floor"] = &"MP_BIO_LAB/CACHE_LOCKED_SECURITY_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["red_door"] = &"MP_BIO_LAB/CACHE_LOCKED_RED_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["blue_door"] = &"MP_BIO_LAB/CACHE_LOCKED_BLUE_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["green_door"] = &"MP_BIO_LAB/CACHE_LOCKED_GREEN_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["black_door"] = &"MP_BIO_LAB/CACHE_LOCKED_BLACK_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["gold_door"] = &"MP_BIO_LAB/CACHE_LOCKED_GOLD_DOOR";
  level._id_24CE016BDB558839["locked_no_key"]["armory_room"] = &"MP_BIO_LAB/CACHE_LOCKED_ARMORY_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["conference_room"] = &"MP_DMZ_LOCKS/LOCKED_CONFERENCE_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["maintenance"] = &"MP_DMZ_LOCKS/LOCKED_AIRPORT_MAINTENANCE";
  level._id_24CE016BDB558839["locked_no_key"]["undershack"] = &"MP_DMZ_LOCKS/LOCKED_UNDERGROUND_SHACK";
  level._id_24CE016BDB558839["locked_no_key"]["cliffroom"] = &"MP_DMZ_LOCKS/LOCKED_CLIFF_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["gravehouse"] = &"MP_DMZ_LOCKS/LOCKED_GRAVEYARD_HOUSE";
  level._id_24CE016BDB558839["locked_no_key"]["poppyhome"] = &"MP_DMZ_LOCKS/LOCKED_POPPY_HOME";
  level._id_24CE016BDB558839["locked_no_key"]["western_storage"] = &"MP_DMZ_LOCKS/LOCKED_WESTERN_STORAGE";
  level._id_24CE016BDB558839["locked_no_key"]["mobile_office"] = &"MP_DMZ_LOCKS/LOCKED_MOBILE_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["crane_building"] = &"MP_DMZ_LOCKS/LOCKED_CRANE_BUILDING";
  level._id_24CE016BDB558839["locked_no_key"]["policestation"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_LOCKERROOM";
  level._id_24CE016BDB558839["locked_no_key"]["smugglers_warehouse"] = &"MP_DMZ_LOCKS/LOCKED_SMUGGLERS_WAREHOUSE";
  level._id_24CE016BDB558839["locked_no_key"]["power_substation"] = &"MP_DMZ_LOCKS/LOCKED_POWER_SUBSTATION";
  level._id_24CE016BDB558839["locked_no_key"]["cell_phone_shop"] = &"MP_DMZ_LOCKS/LOCKED_CELL_PHONE_SHOP";
  level._id_24CE016BDB558839["locked_no_key"]["police_academy_barracks"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_BARRACKS";
  level._id_24CE016BDB558839["locked_no_key"]["police_lockerroom"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_LOCKERROOM";
  level._id_24CE016BDB558839["locked_no_key"]["post_office"] = &"MP_DMZ_LOCKS/LOCKED_POST_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["tv_station"] = &"MP_DMZ_LOCKS/LOCKED_TV_STATION";
  level._id_24CE016BDB558839["locked_no_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH";
  level._id_24CE016BDB558839["locked_no_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET";
  level._id_24CE016BDB558839["locked_no_key"]["north_guard_shack"] = &"MP_DMZ_LOCKS/LOCKED_NORTH_GUARD_SHACK";
  level._id_24CE016BDB558839["locked_no_key"]["south_guard_shack"] = &"MP_DMZ_LOCKS/LOCKED_SOUTH_GUARD_SHACK";
  level._id_24CE016BDB558839["locked_no_key"]["fortbarrack1"] = &"MP_DMZ_LOCKS/LOCKED_FORT_BARRACK1";
  level._id_24CE016BDB558839["locked_no_key"]["antiquities_office"] = &"MP_DMZ_LOCKS/LOCKED_ANTIQUITIES_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["munitions_storage"] = &"MP_DMZ_LOCKS/LOCKED_MUNITIONS_STORAGE";
  level._id_24CE016BDB558839["locked_no_key"]["office_quarters1"] = &"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS1";
  level._id_24CE016BDB558839["locked_no_key"]["office_quarters2"] = &"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS2";
  level._id_24CE016BDB558839["locked_no_key"]["quiet_bedroom"] = &"MP_DMZ_LOCKS/LOCKED_QUIET_BEDROOM";
  level._id_24CE016BDB558839["locked_no_key"]["car_shop"] = &"MP_DMZ_LOCKS/LOCKED_AUTO_SHOP_SUNKEN";
  level._id_24CE016BDB558839["locked_no_key"]["server_room"] = &"MP_DMZ_LOCKS/LOCKED_SERVER_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["sunken_top_office"] = &"MP_DMZ_LOCKS/LOCKED_SUNKEN_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["sunken_2nd_office"] = &"MP_DMZ_LOCKS/LOCKED_SUNKEN_SECOND_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["hotel_room1"] = &"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM1";
  level._id_24CE016BDB558839["locked_no_key"]["hotel_room2"] = &"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM2";
  level._id_24CE016BDB558839["locked_no_key"]["dressing_room"] = &"MP_DMZ_LOCKS/LOCKED_DRESSING_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["sec_camera_room"] = &"MP_DMZ_LOCKS/LOCKED_SEC_CAMERA_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["gaming_room"] = &"MP_DMZ_LOCKS/LOCKED_GAMING_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["fishing_shack"] = &"MP_DMZ_LOCKS/LOCKED_FISH_SHACK";
  level._id_24CE016BDB558839["locked_no_key"]["mountain_top"] = &"MP_DMZ_LOCKS/LOCKED_MOUNTAIN_TOP_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["spotters_view"] = &"MP_DMZ_LOCKS/LOCKED_SPOTTERS_VIEW";
  level._id_24CE016BDB558839["locked_no_key"]["grocery_office"] = &"MP_DMZ_LOCKS/LOCKED_GROCERY_OFFICE";
  level._id_24CE016BDB558839["locked_no_key"]["neigh_storage_room"] = &"MP_DMZ_LOCKS/LOCKED_NEIGH_STORAGE_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET";
  level._id_24CE016BDB558839["locked_no_key"]["apartment_snipernest"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_SNIPERNEST";
  level._id_24CE016BDB558839["locked_no_key"]["destroyed_telescope"] = &"MP_DMZ_LOCKS/LOCKED_DESTROYED_TELESCOPE";
  level._id_24CE016BDB558839["locked_no_key"]["groundskeepers"] = &"MP_DMZ_LOCKS/LOCKED_GROUNDSKEEPERS";
  level._id_24CE016BDB558839["locked_no_key"]["lighthouse_room"] = &"MP_DMZ_LOCKS/LOCKED_LIGHTHOUSE_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["safe_house"] = &"MP_DMZ_LOCKS/LOCKED_SAFE_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["scientist_apartment"] = &"MP_DMZ_LOCKS/LOCKED_SCIENTIST_APARTMENT";
  level._id_24CE016BDB558839["locked_no_key"]["secret_comms"] = &"MP_DMZ_LOCKS/LOCKED_SECRET_COMMS";
  level._id_24CE016BDB558839["locked_no_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH";
  level._id_24CE016BDB558839["locked_no_key"]["sira_apartment"] = &"MP_DMZ_LOCKS/LOCKED_SIRA_APARTMENT";
  level._id_24CE016BDB558839["locked_no_key"]["small_confer_room"] = &"MP_DMZ_LOCKS/LOCKED_SMALL_CONFER_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["supply_rooms"] = &"MP_DMZ_LOCKS/LOCKED_SUPPLY_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["tv_computer_room"] = &"MP_DMZ_LOCKS/LOCKED_TV_COMPUTER_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["yumyum_burger"] = &"MP_DMZ_LOCKS/LOCKED_YUM_BURGER";
  level._id_24CE016BDB558839["locked_no_key"]["interrogation_room"] = &"MP_DMZ_LOCKS/LOCKED_INTERROGATION_ROOM";
  level._id_24CE016BDB558839["locked_no_key"]["control_tower"] = &"MP_DMZ_LOCKS/LOCKED_CONTROL_TOWER";
  level._id_24CE016BDB558839["locked_no_key"]["civic_center"] = &"MP_DMZ_LOCKS/LOCKED_CIVIC_CENTER";
  level._id_24CE016BDB558839["locked_no_key"]["sira_mall"] = &"MP_DMZ_LOCKS/LOCKED_SIRA_MALL";
  level._id_24CE016BDB558839["locked_no_key"]["fort"] = &"MP_DMZ_LOCKS/LOCKED_FORT";
  level._id_24CE016BDB558839["locked_no_key"]["exhume_warehouse"] = &"MP_DMZ_LOCKS/LOCKED_EXHUME_WAREHOUSE";
  level._id_24CE016BDB558839["locked_no_key"]["post_office_stronghold"] = &"MP_DMZ_LOCKS/LOCKED_POST_OFFICE_STRONGHOLD";
  level._id_24CE016BDB558839["locked_no_key"]["police_academy"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY";
  level._id_24CE016BDB558839["locked_no_key"]["embassy"] = &"MP_DMZ_LOCKS/LOCKED_EMBASSY";
  level._id_24CE016BDB558839["locked_no_key"]["blacksite"] = &"MP_DMZ_LOCKS/LOCKED_BLACKSITE";
  level._id_24CE016BDB558839["locked_no_key"]["br_fortress"] = &"MP_DMZ_LOCKS/LOCKED_BR_FORTRESS";
  level._id_24CE016BDB558839["locked_no_key"]["cartel_warehouse"] = &"MP_DMZ_LOCKS/LOCKED_CARTEL_WAREHOUSE";
  level._id_24CE016BDB558839["locked_no_key"]["skeleton_key"] = &"MP_DMZ_LOCKS/LOCKED_SKELETON_ROOM";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    level._id_24CE016BDB558839["locked_no_key"]["sealion_beach_club_bathroom"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_BEACHCLUB_BATHROOM";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_ferry_tourist_information_booth"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_FERRY_BOOTH";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_hotel_room_403"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_HOTEL_ROOM_403";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_lab_office"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_LAB_OFFICE";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_port_harbor_control"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_PORT_HARBOR_CONTROL";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_port_managers_office"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_PORT_MANAGER_OFFICE";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_water_treatment_control_center"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_WATERTREATMENT_CC";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_castle"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_CASTLE";
    level._id_24CE016BDB558839["locked_no_key"]["sealion_cityhall"] = &"MP_DMZ_LOCKS/LOCKED_SEALION_CITYHALL";
  }

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    level._id_24CE016BDB558839["locked_no_key"]["delta_aquarium"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_AQUARIUM";
    level._id_24CE016BDB558839["locked_no_key"]["delta_cityhall"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_CITYHALL";
    level._id_24CE016BDB558839["locked_no_key"]["delta_firestation"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_FIRESTATION";
    level._id_24CE016BDB558839["locked_no_key"]["delta_oldmuseum"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_OLDMUSEUM";
    level._id_24CE016BDB558839["locked_no_key"]["delta_stadium"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_STADIUM";
    level._id_24CE016BDB558839["locked_no_key"]["delta_terminal"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_TERMINAL";
    level._id_24CE016BDB558839["locked_no_key"]["delta_trainstation"] = &"MP_DMZ_LOCKS/LOCKED_DELTA_TRAINSTATION";
    level._id_24CE016BDB558839["locked_no_key"]["de_animal_care"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_ANIMALCARE";
    level._id_24CE016BDB558839["locked_no_key"]["de_shops_02"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_APARTMENT";
    level._id_24CE016BDB558839["locked_no_key"]["de_bike_parking_02"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_BIKEPARKING";
    level._id_24CE016BDB558839["locked_no_key"]["de_firestation_01"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_FIRESTATION";
    level._id_24CE016BDB558839["locked_no_key"]["de_waterhome_04"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_FLOATINGHOUSE";
    level._id_24CE016BDB558839["locked_no_key"]["de_homeboat_08"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_HOMEBOAT";
    level._id_24CE016BDB558839["locked_no_key"]["de_stadium"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_STADIUM";
    level._id_24CE016BDB558839["locked_no_key"]["de_cruise_terminal"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_CRUISETERMINAL";
    level._id_24CE016BDB558839["locked_no_key"]["de_block_01"] = &"MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_TOWNHOUSE";
  }

  if(scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    level._id_24CE016BDB558839["locked_no_key"]["biobunker_fortress"] = &"MP_DMZ_LOCKS/LOCKED_BIOBUNKER_FORTRESS";
    level._id_24CE016BDB558839["locked_no_key"]["datacenter_saferoom"] = &"MP_BIOBUNKER/DATA_CENTER_SAFE_DOOR_LOCKED";
    level._id_24CE016BDB558839["locked_no_key"]["code_on_wall_saferoom"] = &"MP_BIOBUNKER/CODE_ON_WALL_SAFE_DOOR_LOCKED";
    level._id_24CE016BDB558839["locked_no_key"]["biobunker_stairwell_worn"] = &"MP_BIOBUNKER/STAIRWELL_KEY_NEED";
    level._id_24CE016BDB558839["locked_no_key"]["biobunker_workshop_worn"] = &"MP_BIOBUNKER/WORKSHOP_KEY_NEED";
  }

  level._id_24CE016BDB558839["locked_has_key"]["fortress"] = &"MP_DMZ_LOCKS/UNLOCK_FORTRESS";
  level._id_24CE016BDB558839["locked_has_key"]["stuck"] = &"MP_DMZ_LOCKS/STUCK";
  level._id_24CE016BDB558839["locked_has_key"]["testuniquedoor"] = &"MP_DMZ_LOCKS/UNLOCK_TESTUNIQUEDOOR";
  level._id_24CE016BDB558839["locked_has_key"]["quarry_storage"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_STORAGE";
  level._id_24CE016BDB558839["locked_has_key"]["quarry_control"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_CONTROL";
  level._id_24CE016BDB558839["locked_has_key"]["quarry_office"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["hydro_storage"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_STORAGE";
  level._id_24CE016BDB558839["locked_has_key"]["hydro_apt"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_APT";
  level._id_24CE016BDB558839["locked_has_key"]["hydro_weapondrop"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_WEAPONDROP";
  level._id_24CE016BDB558839["locked_has_key"]["hostage_door"] = &"MP_DMZ_MISSIONS/UNLOCK_HOSTAGE_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["trap"] = &"MP_DMZ_MISSIONS/TRAP_DOOR_UNLOCK";
  level._id_24CE016BDB558839["locked_has_key"]["trapper_door"] = &"MP_DMZ_LOCKS/UNLOCK_TRAPPER_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["resort_entrance"] = &"MP_DMZ_LOCKS/UNLOCK_RESORT_ENTRANCE";
  level._id_24CE016BDB558839["locked_has_key"]["firefighttest01"] = &"MP_DMZ_LOCKS/UNLOCK_FIREFIGHTTEST01";
  level._id_24CE016BDB558839["locked_has_key"]["biolab_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["red_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["blue_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["green_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["black_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["gold_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["armory_room"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["third_floor"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["high_security"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level._id_24CE016BDB558839["locked_has_key"]["conference_room"] = &"MP_DMZ_LOCKS/UNLOCK_CONFERENCE_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["maintenance"] = &"MP_DMZ_LOCKS/UNLOCK_AIRPORT_MAINTENANCE";
  level._id_24CE016BDB558839["locked_has_key"]["undershack"] = &"MP_DMZ_LOCKS/UNLOCK_UNDERGROUND_SHACK";
  level._id_24CE016BDB558839["locked_has_key"]["cliffroom"] = &"MP_DMZ_LOCKS/UNLOCK_CLIFF_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["gravehouse"] = &"MP_DMZ_LOCKS/UNLOCK_GRAVEYARD_HOUSE";
  level._id_24CE016BDB558839["locked_has_key"]["poppyhome"] = &"MP_DMZ_LOCKS/UNLOCK_POPPY_HOME";
  level._id_24CE016BDB558839["locked_has_key"]["western_storage"] = &"MP_DMZ_LOCKS/UNLOCK_WESTERN_STORAGE";
  level._id_24CE016BDB558839["locked_has_key"]["mobile_office"] = &"MP_DMZ_LOCKS/UNLOCK_MOBILE_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["crane_building"] = &"MP_DMZ_LOCKS/UNLOCK_CRANE_BUILDING";
  level._id_24CE016BDB558839["locked_has_key"]["policestation"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_LOCKERROOM";
  level._id_24CE016BDB558839["locked_has_key"]["smugglers_warehouse"] = &"MP_DMZ_LOCKS/UNLOCK_SMUGGLERS_WAREHOUSE";
  level._id_24CE016BDB558839["locked_has_key"]["power_substation"] = &"MP_DMZ_LOCKS/UNLOCK_POWER_SUBSTATION";
  level._id_24CE016BDB558839["locked_has_key"]["cell_phone_shop"] = &"MP_DMZ_LOCKS/UNLOCK_CELL_PHONE_SHOP";
  level._id_24CE016BDB558839["locked_has_key"]["police_academy_barracks"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_BARRACKS";
  level._id_24CE016BDB558839["locked_has_key"]["police_lockerroom"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_LOCKERROOM";
  level._id_24CE016BDB558839["locked_has_key"]["post_office"] = &"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["tv_station"] = &"MP_DMZ_LOCKS/UNLOCK_TV_STATION";
  level._id_24CE016BDB558839["locked_has_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH";
  level._id_24CE016BDB558839["locked_has_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET";
  level._id_24CE016BDB558839["locked_has_key"]["control_room"] = &"MP_DMZ_LOCKS/UNLOCK_CONTROL_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["north_guard_shack"] = &"MP_DMZ_LOCKS/UNLOCK_NORTH_GUARD_SHACK";
  level._id_24CE016BDB558839["locked_has_key"]["south_guard_shack"] = &"MP_DMZ_LOCKS/UNLOCK_SOUTH_GUARD_SHACK1";
  level._id_24CE016BDB558839["locked_has_key"]["fortbarrack1"] = &"MP_DMZ_LOCKS/UNLOCK_FORT_BARRACK1";
  level._id_24CE016BDB558839["locked_has_key"]["antiquities_office"] = &"MP_DMZ_LOCKS/UNLOCK_ANTIQUITIES_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["munitions_storage"] = &"MP_DMZ_LOCKS/UNLOCK_MUNITIONS_STORAGE";
  level._id_24CE016BDB558839["locked_has_key"]["office_quarters1"] = &"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS1";
  level._id_24CE016BDB558839["locked_has_key"]["office_quarters2"] = &"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS2";
  level._id_24CE016BDB558839["locked_has_key"]["quiet_bedroom"] = &"MP_DMZ_LOCKS/UNLOCK_QUIET_BEDROOM";
  level._id_24CE016BDB558839["locked_has_key"]["car_shop"] = &"MP_DMZ_LOCKS/UNLOCK_AUTO_SHOP_SUNKEN";
  level._id_24CE016BDB558839["locked_has_key"]["server_room"] = &"MP_DMZ_LOCKS/UNLOCK_SERVER_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["sunken_top_office"] = &"MP_DMZ_LOCKS/UNLOCK_SUNKEN_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["sunken_2nd_office"] = &"MP_DMZ_LOCKS/UNLOCK_SUNKEN_SECOND_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["hotel_room1"] = &"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM1";
  level._id_24CE016BDB558839["locked_has_key"]["hotel_room2"] = &"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM2";
  level._id_24CE016BDB558839["locked_has_key"]["dressing_room"] = &"MP_DMZ_LOCKS/UNLOCK_DRESSING_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["sec_camera_room"] = &"MP_DMZ_LOCKS/UNLOCK_SEC_CAMERA_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["gaming_room"] = &"MP_DMZ_LOCKS/UNLOCK_GAMING_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["fishing_shack"] = &"MP_DMZ_LOCKS/UNLOCK_FISH_SHACK";
  level._id_24CE016BDB558839["locked_has_key"]["mountain_top"] = &"MP_DMZ_LOCKS/UNLOCK_MOUNTAIN_TOP_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["spotters_view"] = &"MP_DMZ_LOCKS/UNLOCK_SPOTTERS_VIEW";
  level._id_24CE016BDB558839["locked_has_key"]["grocery_office"] = &"MP_DMZ_LOCKS/UNLOCK_GROCERY_OFFICE";
  level._id_24CE016BDB558839["locked_has_key"]["neigh_storage_room"] = &"MP_DMZ_LOCKS/UNLOCK_NEIGH_STORAGE_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET";
  level._id_24CE016BDB558839["locked_has_key"]["apartment_snipernest"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_SNIPERNEST";
  level._id_24CE016BDB558839["locked_has_key"]["destroyed_telescope"] = &"MP_DMZ_LOCKS/UNLOCK_DESTROYED_TELESCOPE";
  level._id_24CE016BDB558839["locked_has_key"]["groundskeepers"] = &"MP_DMZ_LOCKS/UNLOCK_GROUNDSKEEPERS";
  level._id_24CE016BDB558839["locked_has_key"]["lighthouse_room"] = &"MP_DMZ_LOCKS/UNLOCK_LIGHTHOUSE_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["safe_house"] = &"MP_DMZ_LOCKS/UNLOCK_SAFE_HOUSE";
  level._id_24CE016BDB558839["locked_has_key"]["scientist_apartment"] = &"MP_DMZ_LOCKS/UNLOCK_SCIENTIST_APARTMENT";
  level._id_24CE016BDB558839["locked_has_key"]["secret_comms"] = &"MP_DMZ_LOCKS/UNLOCK_SECRET_COMMS";
  level._id_24CE016BDB558839["locked_has_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH";
  level._id_24CE016BDB558839["locked_has_key"]["sira_apartment"] = &"MP_DMZ_LOCKS/UNLOCK_SIRA_APARTMENT";
  level._id_24CE016BDB558839["locked_has_key"]["small_confer_room"] = &"MP_DMZ_LOCKS/UNLOCK_SMALL_CONFER_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["supply_rooms"] = &"MP_DMZ_LOCKS/UNLOCK_SUPPLY_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["tv_computer_room"] = &"MP_DMZ_LOCKS/UNLOCK_TV_COMPUTER_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["yumyum_burger"] = &"MP_DMZ_LOCKS/UNLOCK_YUM_BURGER";
  level._id_24CE016BDB558839["locked_has_key"]["interrogation_room"] = &"MP_DMZ_LOCKS/UNLOCK_INTERROGATION_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["control_tower"] = &"MP_DMZ_LOCKS/UNLOCK_CONTROL_TOWER";
  level._id_24CE016BDB558839["locked_has_key"]["civic_center"] = &"MP_DMZ_LOCKS/UNLOCK_CIVIC_CENTER";
  level._id_24CE016BDB558839["locked_has_key"]["sira_mall"] = &"MP_DMZ_LOCKS/UNLOCK_SIRA_MALL";
  level._id_24CE016BDB558839["locked_has_key"]["fort"] = &"MP_DMZ_LOCKS/UNLOCK_FORT";
  level._id_24CE016BDB558839["locked_has_key"]["exhume_warehouse"] = &"MP_DMZ_LOCKS/UNLOCK_EXHUME_WAREHOUSE";
  level._id_24CE016BDB558839["locked_has_key"]["post_office_stronghold"] = &"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE_STRONGHOLD";
  level._id_24CE016BDB558839["locked_has_key"]["police_academy"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY";
  level._id_24CE016BDB558839["locked_has_key"]["embassy"] = &"MP_DMZ_LOCKS/UNLOCK_EMBASSY";
  level._id_24CE016BDB558839["locked_has_key"]["blacksite"] = &"MP_DMZ_LOCKS/UNLOCK_BLACKSITE";
  level._id_24CE016BDB558839["locked_has_key"]["cartel_warehouse"] = &"MP_DMZ_LOCKS/UNLOCK_CARTEL_WAREHOUSE";
  level._id_24CE016BDB558839["locked_has_key"]["skeleton_key"] = &"MP_DMZ_LOCKS/UNLOCK_SKELETON_ROOM";
  level._id_24CE016BDB558839["locked_has_key"]["stronghold_with_skeleton"] = &"MP_DMZ_LOCKS/UNLOCK_STRONGOLD_WITH_SKELETON";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    level._id_24CE016BDB558839["locked_has_key"]["sealion_beach_club_bathroom"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_BEACHCLUB_BATHROOM";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_ferry_tourist_information_booth"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_FERRY_BOOTH";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_hotel_room_403"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_HOTEL_ROOM_403";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_lab_office"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_LAB_OFFICE";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_port_harbor_control"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_PORT_HARBOR_CONTROL";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_port_managers_office"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_PORT_MANAGER_OFFICE";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_water_treatment_control_center"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_WATERTREATMENT_CC";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_castle"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_CASTLE";
    level._id_24CE016BDB558839["locked_has_key"]["sealion_cityhall"] = &"MP_DMZ_LOCKS/UNLOCK_SEALION_CITYHALL";
  }

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    level._id_24CE016BDB558839["locked_has_key"]["delta_aquarium"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_AQUARIUM";
    level._id_24CE016BDB558839["locked_has_key"]["delta_cityhall"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_CITYHALL";
    level._id_24CE016BDB558839["locked_has_key"]["delta_firestation"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_FIRESTATION";
    level._id_24CE016BDB558839["locked_has_key"]["delta_oldmuseum"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_OLDMUSEUM";
    level._id_24CE016BDB558839["locked_has_key"]["delta_stadium"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_STADIUM";
    level._id_24CE016BDB558839["locked_has_key"]["delta_terminal"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_TERMINAL";
    level._id_24CE016BDB558839["locked_has_key"]["delta_trainstation"] = &"MP_DMZ_LOCKS/UNLOCK_DELTA_TRAINSTATION";
    level._id_24CE016BDB558839["locked_has_key"]["de_animal_care"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_ANIMALCARE";
    level._id_24CE016BDB558839["locked_has_key"]["de_shops_02"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_APARTMENT";
    level._id_24CE016BDB558839["locked_has_key"]["de_bike_parking_02"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_BIKEPARKING";
    level._id_24CE016BDB558839["locked_has_key"]["de_firestation_01"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_FIRESTATION";
    level._id_24CE016BDB558839["locked_has_key"]["de_waterhome_04"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_FLOATINGHOUSE";
    level._id_24CE016BDB558839["locked_has_key"]["de_homeboat_08"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_HOMEBOAT";
    level._id_24CE016BDB558839["locked_has_key"]["de_stadium"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_STADIUM";
    level._id_24CE016BDB558839["locked_has_key"]["de_cruise_terminal"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_CRUISETERMINAL";
    level._id_24CE016BDB558839["locked_has_key"]["de_block_01"] = &"MP_DMZ_LOCKS/CACHE_UNLOCK_DELTA_TOWNHOUSE";
  }

  if(scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E()) {
    level._id_24CE016BDB558839["locked_has_key"]["biobunker_fortress"] = &"MP_DMZ_LOCKS/UNLOCK_BIOBUNKER_FORTRESS";
    level._id_24CE016BDB558839["locked_has_key"]["datacenter_saferoom"] = &"MP_BIOBUNKER/DATA_CENTER_SAFE_DOOR_UNLOCK";
    level._id_24CE016BDB558839["locked_has_key"]["code_on_wall_saferoom"] = &"MP_BIOBUNKER/DATA_CENTER_SAFE_DOOR_UNLOCK";
    level._id_24CE016BDB558839["locked_has_key"]["biobunker_workshop_worn"] = &"MP_BIOBUNKER/WORKSHOP_KEY_UNLOCK";
    level._id_24CE016BDB558839["locked_has_key"]["biobunker_stairwell_worn"] = &"MP_BIOBUNKER/STAIRWELL_KEY_UNLOCK";
  }
}

_id_94F5E3929619C3D1(_id_6EC5749C5CE7657E) {
  string = level._id_24CE016BDB558839["locked_no_key"][tolower(_id_6EC5749C5CE7657E)];

  if(!isDefined(string))
    string = level._id_24CE016BDB558839["locked_no_key"]["stuck"];

  return string;
}

_id_54F0BA9AC5666ABA(_id_6EC5749C5CE7657E) {
  string = level._id_24CE016BDB558839["locked_has_key"][tolower(_id_6EC5749C5CE7657E)];

  if(!isDefined(string))
    string = level._id_24CE016BDB558839["locked_has_key"]["stuck"];

  return string;
}

_id_2A56C656879DBF63() {
  _id_8E1CBE18678D7FFF();
  _id_29E046251BDC472C();
}

_id_29E046251BDC472C() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  level._id_7ED6190E252D4EC8 = [];
  _id_4C7BFE49F37E4FAF = level.struct_class_names["script_noteworthy"]["lockedSpace"];

  if(!isDefined(_id_4C7BFE49F37E4FAF)) {
    return;
  }
  foreach(_id_11F568BBCEDEBCF0 in _id_4C7BFE49F37E4FAF) {
    _id_2039418022567D47(_id_11F568BBCEDEBCF0);
    _id_DCEC5158A800E39D(_id_11F568BBCEDEBCF0);
    level._id_7ED6190E252D4EC8[level._id_7ED6190E252D4EC8.size] = _id_11F568BBCEDEBCF0;
  }
}

_id_2039418022567D47(_id_809FDFF7726141BB) {
  nodes = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(_id_809FDFF7726141BB.target, "targetname"), getEntArray(_id_809FDFF7726141BB.target, "targetname"));
  _id_809FDFF7726141BB._id_E2CD8AA8B46D18AC = [];
  _id_809FDFF7726141BB._id_84B0EF6BDDD2907A = [];
  _id_809FDFF7726141BB._id_3DA7559F232A2CA9 = [];
  _id_809FDFF7726141BB._id_104F87CC51A1138D = [];

  foreach(node in nodes) {
    if(!isDefined(node.angles))
      node.angles = (0, 0, 0);

    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    switch (tolower(node.script_noteworthy)) {
      case "lockme":
        _id_809FDFF7726141BB._id_E2CD8AA8B46D18AC = _id_AD1B6ACCBAAB404E(node, _id_809FDFF7726141BB._id_E2CD8AA8B46D18AC, tolower(_id_809FDFF7726141BB.targetname), 0);
        break;
      case "lockme_nounlock":
        _id_809FDFF7726141BB._id_84B0EF6BDDD2907A = _id_AD1B6ACCBAAB404E(node, _id_809FDFF7726141BB._id_84B0EF6BDDD2907A, "stuck", 0);
        break;
      case "notebook":
        node._id_86740FA764EE2FDC = 1;
        _id_809FDFF7726141BB._id_3DA7559F232A2CA9[_id_809FDFF7726141BB._id_3DA7559F232A2CA9.size] = node;
        break;
      case "note":
        node._id_4F94796425D65F79 = 1;
        _id_809FDFF7726141BB._id_3DA7559F232A2CA9[_id_809FDFF7726141BB._id_3DA7559F232A2CA9.size] = node;
        break;
      case "key":
        node._id_82D45592D750D388 = 1;
        _id_809FDFF7726141BB._id_3DA7559F232A2CA9[_id_809FDFF7726141BB._id_3DA7559F232A2CA9.size] = node;
        break;
      default:
        _id_809FDFF7726141BB._id_104F87CC51A1138D[_id_809FDFF7726141BB._id_104F87CC51A1138D.size] = node;
    }
  }
}

_id_DCEC5158A800E39D(_id_7BE3A4CA79D6D8E6, _id_14DCEA3D745E5B2B) {
  foreach(door in _id_7BE3A4CA79D6D8E6._id_E2CD8AA8B46D18AC) {
    _id_FBBFE6F05EDA5EB1(door);
    door._id_3325CFE18A840BEB = 1;

    if(isDefined(_id_14DCEA3D745E5B2B)) {
      door._id_DEF557E8FD5C6763 = _id_14DCEA3D745E5B2B;
      continue;
    }

    door._id_DEF557E8FD5C6763 = ::_id_BF5AD2061B782C3C;
  }

  foreach(door in _id_7BE3A4CA79D6D8E6._id_84B0EF6BDDD2907A)
  _id_FBBFE6F05EDA5EB1(door);

  _id_4948CDF739393D2D::_id_401B0949743B45A9(_id_7BE3A4CA79D6D8E6);

  foreach(node in _id_7BE3A4CA79D6D8E6._id_3DA7559F232A2CA9)
  _id_4C877FC54E2E6854(node, _id_7BE3A4CA79D6D8E6.targetname);
}

_id_64332F29E2409E55(origin) {
  foreach(volume in level._id_AB18903AA481FFF2) {
    if(ispointinvolume(origin, volume))
      return 1;
  }

  return 0;
}

_id_BF5AD2061B782C3C(scriptable, player) {
  _id_6A8EC730B2BFA844::_id_01D1DF26DF05A6C8(scriptable, player);
}

_id_ED1AEA6648BCDC28(scriptablename, _id_2053E168B46CAA6E) {
  if(!isDefined(scriptablename) || !isDefined(_id_2053E168B46CAA6E))
    return undefined;

  switch (_id_2053E168B46CAA6E) {
    case 0:
      _id_F48A1FA8EDDF2B4A = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename + "_used");

      if(!isDefined(_id_F48A1FA8EDDF2B4A))
        return undefined;

      return _id_F48A1FA8EDDF2B4A;
    case 1:
      _id_F48A1FA8EDDF2B4A = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename + "_worn");

      if(!isDefined(_id_F48A1FA8EDDF2B4A))
        return undefined;

      return _id_F48A1FA8EDDF2B4A;
    case 2:
      return undefined;
    default:
      return undefined;
  }
}

_id_8E1CBE18678D7FFF() {
  _id_5374A9DF4582DF00 = getDvar("dvar_64DDCF029687CA8B", "mp/loot/br/dmz/lootset_custom_nodes.csv");
  level._id_3DA7559F232A2CA9 = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows(_id_5374A9DF4582DF00);

  for(_id_AC0E594AC96AA3A8 = 0; istrue(_id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA); _id_AC0E594AC96AA3A8++) {
    _id_49710DF804BEA4D0 = tablelookupbyrow(_id_5374A9DF4582DF00, _id_AC0E594AC96AA3A8, 0);

    if(!isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]))
      level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0] = [];

    _id_F2E7EF56FB1A0B7C = tablelookupbyrow(_id_5374A9DF4582DF00, _id_AC0E594AC96AA3A8, 1);
    _id_B5858D9A2232E324 = int(tablelookupbyrow(_id_5374A9DF4582DF00, _id_AC0E594AC96AA3A8, 2));
    _id_DCB6E2B7467A12FC = tablelookupbyrow(_id_5374A9DF4582DF00, _id_AC0E594AC96AA3A8, 3);
    _id_B99B2114134FE248 = tablelookupbyrow(_id_5374A9DF4582DF00, _id_AC0E594AC96AA3A8, 4);
    level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][_id_F2E7EF56FB1A0B7C] = spawnStruct();
    level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][_id_F2E7EF56FB1A0B7C]._id_B5858D9A2232E324 = _id_B5858D9A2232E324;
    level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][_id_F2E7EF56FB1A0B7C]._id_DCB6E2B7467A12FC = _id_DCB6E2B7467A12FC;
    level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][_id_F2E7EF56FB1A0B7C]._id_B99B2114134FE248 = _id_B99B2114134FE248;
  }
}

_id_799A9EE634DA2160(node) {
  if(!isDefined(node.classname) || !isent(node))
    return 0;

  _id_9F1CAE7F3799988A = node isscriptable();
  _id_4F94796425D65F79 = issubstr(node.classname, "note");

  if(istrue(_id_4F94796425D65F79))
    node._id_4F94796425D65F79 = _id_4F94796425D65F79;

  _id_82D45592D750D388 = issubstr(node.classname, "key");

  if(istrue(_id_82D45592D750D388))
    node._id_82D45592D750D388 = _id_4F94796425D65F79;

  return _id_9F1CAE7F3799988A && (_id_4F94796425D65F79 || _id_82D45592D750D388);
}

_id_4C877FC54E2E6854(node, _id_49710DF804BEA4D0) {
  _id_49710DF804BEA4D0 = tolower(_id_49710DF804BEA4D0);

  if(!isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0])) {
    return;
  }
  if(istrue(node._id_82D45592D750D388)) {
    if(!_id_E05F1F84BB69A4D2(_id_49710DF804BEA4D0, "key"))
      _id_7FA45E159979FE3C = 0;
    else
      _id_7FA45E159979FE3C = level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["key"]._id_B5858D9A2232E324;

    if(_id_7FA45E159979FE3C == 0) {
      return;
    }
    roll = randomint(100);

    if(roll < _id_7FA45E159979FE3C) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(node.origin, node.angles);
      _id_58564A86A29587A4 = 0;
      _id_8F7EDDC9C0864A1B = "loot_key_fortress";
      _id_DCB6E2B7467A12FC = level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["key"]._id_DCB6E2B7467A12FC;

      if(isDefined(_id_DCB6E2B7467A12FC) && _id_DCB6E2B7467A12FC != "") {
        _id_8F7EDDC9C0864A1B = _id_DCB6E2B7467A12FC;

        if(issubstr(_id_8F7EDDC9C0864A1B, "loot_key"))
          _id_58564A86A29587A4 = 1;
      }

      _id_67F14F8315CB0F2F = strtok(_id_8F7EDDC9C0864A1B, "_");

      if(_id_67F14F8315CB0F2F[0] == "tier1Key")
        _id_8F7EDDC9C0864A1B = _id_23326C8AC97C60C7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
      else if(_id_67F14F8315CB0F2F[0] == "tier2Key")
        _id_8F7EDDC9C0864A1B = _id_23326C8AC97C60C7(0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
      else if(_id_67F14F8315CB0F2F[0] == "tier3Key")
        _id_8F7EDDC9C0864A1B = _id_23326C8AC97C60C7(0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
      else if(_id_67F14F8315CB0F2F[0] == "heroKey")
        _id_8F7EDDC9C0864A1B = _id_23326C8AC97C60C7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, _id_67F14F8315CB0F2F[1]);

      scriptable = _id_7E52B56769FA7774::spawnpickup(_id_8F7EDDC9C0864A1B, _id_CB4FAD49263E20C4, 1, 0);

      if(istrue(_id_58564A86A29587A4)) {
        scriptable._id_BBC200BC77C5DB2B = 1;
        return;
      }

      return;
    }
  } else if(istrue(node._id_4F94796425D65F79) || istrue(node._id_86740FA764EE2FDC)) {
    if(isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["noteAlreadyPlaced"]))
      return;
    else
      level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["noteAlreadyPlaced"] = 1;

    if(!_id_E05F1F84BB69A4D2(_id_49710DF804BEA4D0, "note"))
      _id_7FA45E159979FE3C = 0;
    else
      _id_7FA45E159979FE3C = level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["note"]._id_B5858D9A2232E324;

    if(_id_7FA45E159979FE3C == 0) {
      return;
    }
    roll = randomint(100);

    if(roll < _id_7FA45E159979FE3C) {
      _id_6EF4FD3894A9F0A2 = level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]["note"]._id_DCB6E2B7467A12FC;

      if(!isDefined(_id_6EF4FD3894A9F0A2) || _id_6EF4FD3894A9F0A2 == "") {
        return;
      }
      offset = (0, 0, 0);

      if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
        if(istrue(node._id_86740FA764EE2FDC)) {
          if(issubstr(_id_6EF4FD3894A9F0A2, "_note_"))
            offset = (0, 0, 0);
          else
            offset = (0, 0, 0);
        } else if(istrue(node._id_4F94796425D65F79)) {
          if(issubstr(_id_6EF4FD3894A9F0A2, "_notebook_"))
            offset = (90, 0, 0);
          else
            offset = (90, 0, 0);
        }
      } else if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
        if(_id_6EF4FD3894A9F0A2 == "interactable_notebook_sealion_scared01")
          node.angles = (0, 0, 0);
        else if(istrue(node._id_4F94796425D65F79))
          offset = (90, 0, 0);
      }

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(node.origin, node.angles + offset);
      scriptable = _id_7E52B56769FA7774::spawnpickup(_id_6EF4FD3894A9F0A2, _id_CB4FAD49263E20C4, 1, 0);
      scriptable._id_BBC200BC77C5DB2B = 1;
    }
  }
}

_id_E05F1F84BB69A4D2(_id_49710DF804BEA4D0, itemtype) {
  if(!isDefined(_id_49710DF804BEA4D0) || !isDefined(itemtype))
    return 0;

  if(!isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]))
    return 0;

  if(!isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][itemtype]))
    return 0;

  if(!isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][itemtype]._id_B5858D9A2232E324))
    return 0;

  if(!isint(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0][itemtype]._id_B5858D9A2232E324))
    return 0;

  return 1;
}

_id_A894D6041798CC06() {
  level thread _id_A9D72A6EE70123E5();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("locked_cache_prompt", ::_id_38904BC3A49AF40C);

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    return;
  }
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_4CC04C6A9DBFD0EE = scripts\engine\utility::getStructArray("lockedCache", "targetname");

  foreach(_id_2076A994E0E7C929 in _id_4CC04C6A9DBFD0EE) {
    _id_C54E8A88506815AA = getentitylessscriptablearray(undefined, undefined, _id_2076A994E0E7C929.origin, 64, "body");

    if(!isDefined(_id_C54E8A88506815AA)) {
      continue;
    }
    _id_B038ED928EC17A81 = _id_C54E8A88506815AA[0];

    if(!isDefined(_id_B038ED928EC17A81)) {
      continue;
    }
    _id_B038ED928EC17A81 _id_C4D29F8F054E326B(_id_2076A994E0E7C929.origin, scripts\engine\utility::_id_53C4C53197386572(_id_2076A994E0E7C929.script_noteworthy, "generic"), "closed_locked");
  }
}

_id_C4D29F8F054E326B(origin, _id_8F7EDDC9C0864A1B, _id_0CFA05EF5CFBE083, _id_F1435A21FF6AD202) {
  if(isDefined(_id_0CFA05EF5CFBE083))
    self setscriptablepartstate("body", _id_0CFA05EF5CFBE083);

  self._id_F1435A21FF6AD202 = _id_F1435A21FF6AD202;
  scriptable = spawnscriptable("locked_cache_prompt", origin);
  scriptable setscriptablepartstate("locked_cache_prompt", scripts\engine\utility::ter_op(_id_8F7EDDC9C0864A1B == "generic_no_key", "on_no_key", "on"));
  scriptable._id_8F7EDDC9C0864A1B = _id_8F7EDDC9C0864A1B;
  scriptable._id_B038ED928EC17A81 = self;
  scriptable._id_4187E96FE413300E = 1;
  self._id_3E5D613E6F4D92E3 = 1;
  return scriptable;
}

_id_F3B1F1D41C65B340() {
  self._id_B038ED928EC17A81 setscriptablepartstate("body", scripts\engine\utility::_id_53C4C53197386572(self._id_B038ED928EC17A81._id_F1435A21FF6AD202, "closed_usable"));
  self freescriptable();
}

_id_38904BC3A49AF40C(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_44082B06F156465D = instance._id_8F7EDDC9C0864A1B;

  if(instance._id_8F7EDDC9C0864A1B == "firefightTestContainer")
    _id_44082B06F156465D = "fortress";

  if(!_id_E0E50EF00477DEEB("loot_key_" + _id_44082B06F156465D, player)) {
    player scripts\mp\hud_message::showerrormessage(_id_BD958525BE466CD7(_id_44082B06F156465D));

    if(istrue(instance._id_4187E96FE413300E)) {
      instance._id_4187E96FE413300E = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](player))
          player playsoundonmovingent("mp_door_locked");
      }

      return 0;
    }

    wait 1.0;
    instance._id_4187E96FE413300E = 1;
    return 0;
  }

  _id_B038ED928EC17A81 = instance._id_B038ED928EC17A81;
  player thread _id_83F5CDC3D883507E(instance, player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self))
      player playsoundonmovingent("mp_door_unlock_key");
  }

  _id_A82E2128E25504DC = instance._id_8F7EDDC9C0864A1B;

  if(instance._id_8F7EDDC9C0864A1B == "crash_lrg_2") {
    _id_F3E5EC9ECAAF8E1B = instance._id_B038ED928EC17A81.origin + (0, 0, 42);
    grenade = magicgrenademanual("gas_grenade_mp", _id_F3E5EC9ECAAF8E1B, (0, 0, 1), 0.1);
    grenade.owner = player;
    player thread scripts\mp\equipment\gas_grenade::gas_used(grenade);
  }

  instance freescriptable();
  wait 1;
  _id_B038ED928EC17A81 setscriptablepartstate("body", scripts\engine\utility::_id_53C4C53197386572(_id_B038ED928EC17A81._id_F1435A21FF6AD202, "closed_usable"));
  items = getscriptablelootcachecontents(_id_B038ED928EC17A81);
  _id_B038ED928EC17A81._id_46A3A8565AC0C17C = 3;
  _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
  _id_6A8EC730B2BFA844::_id_F00AA0C3B58C13F2(_id_B038ED928EC17A81, player);
  _id_94D44A28DFEFB26B = _id_B98C91E5697EDB49(_id_A82E2128E25504DC);

  foreach(index, item in _id_94D44A28DFEFB26B) {
    _id_CE27CBABE010181E = item._id_B99B2114134FE248;

    if(!isDefined(_id_CE27CBABE010181E)) {
      continue;
    }
    ref = undefined;

    if(scripts\engine\utility::array_contains(level.br_plunder.names, item._id_DCB6E2B7467A12FC)) {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("cash");
      _id_07BAF6F0EAFE87A8 = 0;

      foreach(_id_F90D0E006A1F717B, _id_3466C10973E9C476 in level.br_plunder.names) {
        if(_id_3466C10973E9C476 == item._id_DCB6E2B7467A12FC) {
          _id_07BAF6F0EAFE87A8 = _id_F90D0E006A1F717B;
          break;
        }
      }

      count = level.br_plunder.quantity[_id_07BAF6F0EAFE87A8];
    } else if(issubstr(item._id_DCB6E2B7467A12FC, "brloot_weapon")) {
      lootid = level.br_pickups._id_7B2BFF2D04EE1017[item._id_DCB6E2B7467A12FC];
      count = 1;
      ref = item._id_DCB6E2B7467A12FC;
    } else {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(item._id_DCB6E2B7467A12FC);
      count = tablelookup(level.brloottablename, 1, item._id_DCB6E2B7467A12FC, 4);

      if(count == "")
        count = tablelookup(level.brloottablename, 5, lootid, 4);
    }

    _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F(_id_B038ED928EC17A81.contents, count, lootid, ref, index);
  }
}

_id_A9D72A6EE70123E5() {
  level._id_409396D5620DEAE8 = [];
  level._id_409396D5620DEAE8["fortress"] = "MP_DMZ_LOCKS/CACHE_LOCKED_FORTRESS";
  level._id_409396D5620DEAE8["generic_no_key"] = "MP_DMZ_LOCKS/CACHE_LOCKED_GENERIC_NO_KEY";
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    level._id_409396D5620DEAE8["airport_lounge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_AIRPORT_LOUNGE";
    level._id_409396D5620DEAE8["baggage_handling"] = "MP_DMZ_LOCKS/CACHE_LOCKED_BAGGAGE_HANDLING";
    level._id_409396D5620DEAE8["end_runway"] = "MP_DMZ_LOCKS/CACHE_LOCKED_END_RUNWAY";
    level._id_409396D5620DEAE8["caves_bench_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CAVES_BENCH_CONTAINER";
    level._id_409396D5620DEAE8["powerstation_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_POWERSUBSTATION_CONTAINER";
    level._id_409396D5620DEAE8["gravesite_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_GRAVESITE_CONTAINER";
    level._id_409396D5620DEAE8["waterpit_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_WATERPIT_CONTAINER";
    level._id_409396D5620DEAE8["underwater_ship"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERWATER_SHIP";
    level._id_409396D5620DEAE8["clocktower_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CLOCKTOWER_CONTAINER";
    level._id_409396D5620DEAE8["hydro_island_room"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HYDRO_ISLAND_ROOM";
    level._id_409396D5620DEAE8["ship_bridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_BRIDGE";
    level._id_409396D5620DEAE8["ship_center"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_CENTER";
    level._id_409396D5620DEAE8["fishing_box_dock"] = "MP_DMZ_LOCKS/CACHE_LOCKED_FISHING_BOX_DOCK";
    level._id_409396D5620DEAE8["underthebridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERBRIDGE";
    level._id_409396D5620DEAE8["tower_hill"] = "MP_DMZ_LOCKS/CACHE_LOCKED_TOWER_HILL";
    level._id_409396D5620DEAE8["canal_uw_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CANAL_UW_CONTAINER";
    level._id_409396D5620DEAE8["hallway_locker"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HALLWAY_LOCKER";
    level._id_409396D5620DEAE8["control_room"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CONTROL_ROOM";
    level._id_409396D5620DEAE8["ship_above_water"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_ABOVE_WATER";
    level._id_409396D5620DEAE8["sunken_ship"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SUNKEN_SHIP";
    level._id_409396D5620DEAE8["underground_passage"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERGROUND_PASSAGE";
    level._id_409396D5620DEAE8["police_locker"] = "MP_DMZ_LOCKS/CACHE_LOCKED_POLICE_LOCKER";
    level._id_409396D5620DEAE8["end_pyro_tunnel"] = "MP_DMZ_LOCKS/CACHE_LOCKED_END_PYRO_TUNNEL";
    level._id_409396D5620DEAE8["crash_wp_case"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_WP_CASE";
    level._id_409396D5620DEAE8["crash_lrg_1"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_LRG_1";
    level._id_409396D5620DEAE8["crash_lrg_2"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_LRG_2";
    level._id_409396D5620DEAE8["crash_sm_1"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_SM_1";
    level._id_409396D5620DEAE8["crash_sm_2"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_SM_2";
    level._id_409396D5620DEAE8["crash_sm_3"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_SM_3";
    level._id_409396D5620DEAE8["crash_briefcase_1"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CRASH_BRIEFCASE_1";
    level._id_409396D5620DEAE8["dc_toolbox_1"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DC_TOOLBOX_1";
    level._id_409396D5620DEAE8["dc_briefcase_1"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DC_BRIEFCASE_1";
    level._id_409396D5620DEAE8["hell_train"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HELL_TRAIN";
  } else if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    level._id_409396D5620DEAE8["sealion_castle_armory"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_CASTLE_ARMORY";
    level._id_409396D5620DEAE8["sealion_couple_fight_bag"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_COUPLE_BAG";
    level._id_409396D5620DEAE8["sealion_farmers_toolbox"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_FARMERS_TOOLBOX";
    level._id_409396D5620DEAE8["sealion_hotel_workers_office_fridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_OFFICE_FRIDGE";
    level._id_409396D5620DEAE8["sealion_knocked_over_workers_toolbox"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_WORKER_TOOLBOX";
    level._id_409396D5620DEAE8["sealion_lost_travelers_bag"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_TRAVELERS_BAG";
    level._id_409396D5620DEAE8["sealion_misplaced_crate"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_MISPLACED_CRATE";
    level._id_409396D5620DEAE8["sealion_observatory_thrown_fridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_OBSERVATORY_FRIDGE";
    level._id_409396D5620DEAE8["sealion_shadow_company_toolbox"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_SHADOW_TOOLBOX";
    level._id_409396D5620DEAE8["sealion_shipwreck_cargo_crate"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_SHIPWRECK_CRATE";
    level._id_409396D5620DEAE8["sealion_town_canal_crate"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SEALION_CANAL_CRATE";
  } else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    level._id_409396D5620DEAE8["de_city_hall"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_CITYHALL";
    level._id_409396D5620DEAE8["de_museum_02"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_NEWMUSEUM";
    level._id_409396D5620DEAE8["de_museum_01"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_OLDMUSEUM";
    level._id_409396D5620DEAE8["de_tunnel_01"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_SEWERS";
    level._id_409396D5620DEAE8["de_shopping_mall"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_SHOPPINGMALL";
    level._id_409396D5620DEAE8["de_hangar_01"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_STABLES";
    level._id_409396D5620DEAE8["de_homeboat_01"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_SUNKENHOUSE";
    level._id_409396D5620DEAE8["de_under_bridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_UNDERBRIDGE";
    level._id_409396D5620DEAE8["de_stage_01"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_UNIVERSITY";
    level._id_409396D5620DEAE8["de_windmill"] = "MP_DMZ_LOCKS/CACHE_LOCKED_DELTA_WINDMILL";
  } else if(level.mapname == "mp_br_mechanics")
    level._id_409396D5620DEAE8["hell_train"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HELL_TRAIN";
}

_id_BD958525BE466CD7(_id_8F7EDDC9C0864A1B) {
  _id_B00CC25137FA2908 = level._id_409396D5620DEAE8[_id_8F7EDDC9C0864A1B];

  if(!isDefined(_id_B00CC25137FA2908))
    _id_B00CC25137FA2908 = level._id_409396D5620DEAE8["fortress"];

  return _id_B00CC25137FA2908;
}

_id_B98C91E5697EDB49(_id_49710DF804BEA4D0) {
  _id_94D44A28DFEFB26B = [];

  if(isDefined(level._id_3DA7559F232A2CA9) && isDefined(level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0])) {
    foreach(_id_811F40234CD18F32 in level._id_3DA7559F232A2CA9[_id_49710DF804BEA4D0]) {
      _id_67F14F8315CB0F2F = strtok(_id_811F40234CD18F32._id_DCB6E2B7467A12FC, "_");

      if(_id_67F14F8315CB0F2F[0] == "tier1Key") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_23326C8AC97C60C7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "tier2Key") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_23326C8AC97C60C7(0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "tier3Key") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_23326C8AC97C60C7(0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "heroKey") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_23326C8AC97C60C7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, _id_67F14F8315CB0F2F[1]);
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "weaponPistol") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_3C30CD923087306B("pistol");
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "weaponRare") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_3C30CD923087306B("rare");
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      if(_id_67F14F8315CB0F2F[0] == "weaponEpic") {
        _id_811F40234CD18F32._id_DCB6E2B7467A12FC = _id_3C30CD923087306B("epic");
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
        continue;
      }

      roll = randomint(100);

      if(roll < _id_811F40234CD18F32._id_B5858D9A2232E324)
        _id_94D44A28DFEFB26B[_id_94D44A28DFEFB26B.size] = _id_811F40234CD18F32;
    }
  }

  return _id_94D44A28DFEFB26B;
}

_id_B35796A7C0A71079() {
  level._id_EABF33BC40A9A363 = [];
  level._id_FC7C751394AB36BA = ["loot_key_skeleton", "loot_key_skeleton_used", "loot_key_skeleton_worn"];
  level._id_F2E2B5ED406A7D94 = [];
  level._id_F2E2B5ED406A7D94[1] = [];
  level._id_F2E2B5ED406A7D94[2] = [];
  level._id_F2E2B5ED406A7D94[3] = [];
  level._id_F2E2B5ED406A7D94[4] = [];
  level._id_F2E2B5ED406A7D94["1_sabacrash"] = [];
  level._id_F2E2B5ED406A7D94["2_sabacrash"] = [];
  level._id_F2E2B5ED406A7D94["3_sabacrash"] = [];
  level._id_F2E2B5ED406A7D94["4_sabacrash"] = [];
  level._id_F2E2B5ED406A7D94["1_b21"] = [];
  level._id_F2E2B5ED406A7D94["1_sealion"] = [];
  level._id_F2E2B5ED406A7D94["2_sealion"] = [];
  level._id_F2E2B5ED406A7D94["3_sealion"] = [];
  level._id_F2E2B5ED406A7D94["4_sealion"] = [];
  level._id_F2E2B5ED406A7D94["1_delta"] = [];
  level._id_F2E2B5ED406A7D94["2_delta"] = [];
  level._id_F2E2B5ED406A7D94["3_delta"] = [];
  level._id_F2E2B5ED406A7D94["4_delta"] = [];
  _id_B96CA3C98CA2FB0A(1, "hydro_storage", 1);
  _id_B96CA3C98CA2FB0A(1, "airport_lounge", 1);
  _id_B96CA3C98CA2FB0A(1, "baggage_handling", 1);
  _id_B96CA3C98CA2FB0A(1, "caves_bench_container", 1);
  _id_B96CA3C98CA2FB0A(1, "undershack", 1);
  _id_B96CA3C98CA2FB0A(1, "gravehouse", 1);
  _id_B96CA3C98CA2FB0A(1, "powerstation_container", 1);
  _id_B96CA3C98CA2FB0A(1, "gravesite_container", 1);
  _id_B96CA3C98CA2FB0A(1, "mobile_office", 1);
  _id_B96CA3C98CA2FB0A(1, "groundskeepers", 1);
  _id_B96CA3C98CA2FB0A(1, "clocktower_container", 1);
  _id_B96CA3C98CA2FB0A(1, "hydro_island_room", 1);
  _id_B96CA3C98CA2FB0A(1, "fishing_box_dock", 1);
  _id_B96CA3C98CA2FB0A(1, "supply_rooms", 1);
  _id_B96CA3C98CA2FB0A(1, "power_substation", 1);
  _id_B96CA3C98CA2FB0A(1, "cell_phone_shop", 1);
  _id_B96CA3C98CA2FB0A(1, "underthebridge", 1);
  _id_B96CA3C98CA2FB0A(1, "police_academy_barracks", 1);
  _id_B96CA3C98CA2FB0A(1, "tv_station", 1);
  _id_B96CA3C98CA2FB0A(1, "shopping_booth", 1);
  _id_B96CA3C98CA2FB0A(1, "yumyum_burger", 1);
  _id_B96CA3C98CA2FB0A(1, "tower_hill", 1);
  _id_B96CA3C98CA2FB0A(1, "canal_uw_container", 1);
  _id_B96CA3C98CA2FB0A(1, "small_confer_room", 1);
  _id_B96CA3C98CA2FB0A(1, "hallway_locker", 1);
  _id_B96CA3C98CA2FB0A(1, "north_guard_shack", 1);
  _id_B96CA3C98CA2FB0A(1, "south_guard_shack", 1);
  _id_B96CA3C98CA2FB0A(1, "fortbarrack1", 1);
  _id_B96CA3C98CA2FB0A(1, "office_quarters1", 1);
  _id_B96CA3C98CA2FB0A(1, "sunken_2nd_office", 1);
  _id_B96CA3C98CA2FB0A(1, "sira_apartment", 1);
  _id_B96CA3C98CA2FB0A(1, "gaming_room", 1);
  _id_B96CA3C98CA2FB0A(1, "fishing_shack", 1);
  _id_B96CA3C98CA2FB0A(1, "spotters_view", 1);
  _id_B96CA3C98CA2FB0A(1, "grocery_office", 1);
  _id_B96CA3C98CA2FB0A(1, "neigh_storage_room", 1);
  _id_B96CA3C98CA2FB0A(1, "crane_building", 1);
  _id_B96CA3C98CA2FB0A(1, "underwater_ship", 1);
  _id_B96CA3C98CA2FB0A(2, "hydro_apt");
  _id_B96CA3C98CA2FB0A(2, "conference_room");
  _id_B96CA3C98CA2FB0A(2, "end_runway", 1);
  _id_B96CA3C98CA2FB0A(2, "cliffroom");
  _id_B96CA3C98CA2FB0A(2, "poppyhome");
  _id_B96CA3C98CA2FB0A(2, "waterpit_container", 1);
  _id_B96CA3C98CA2FB0A(2, "lighthouse_room");
  _id_B96CA3C98CA2FB0A(2, "ship_bridge", 1);
  _id_B96CA3C98CA2FB0A(2, "ship_center", 1);
  _id_B96CA3C98CA2FB0A(2, "policestation", 1);
  _id_B96CA3C98CA2FB0A(2, "smugglers_warehouse");
  _id_B96CA3C98CA2FB0A(2, "interrogation_room");
  _id_B96CA3C98CA2FB0A(2, "police_lockerroom");
  _id_B96CA3C98CA2FB0A(2, "apartment_closet");
  _id_B96CA3C98CA2FB0A(2, "tv_computer_room");
  _id_B96CA3C98CA2FB0A(2, "destroyed_telescope");
  _id_B96CA3C98CA2FB0A(2, "scientist_apartment");
  _id_B96CA3C98CA2FB0A(2, "control_room");
  _id_B96CA3C98CA2FB0A(2, "end_pyro_tunnel");
  _id_B96CA3C98CA2FB0A(2, "munitions_storage", 1);
  _id_B96CA3C98CA2FB0A(2, "car_shop");
  _id_B96CA3C98CA2FB0A(2, "sunken_top_office");
  _id_B96CA3C98CA2FB0A(2, "hotel_room1");
  _id_B96CA3C98CA2FB0A(2, "ship_above_water");
  _id_B96CA3C98CA2FB0A(2, "dressing_room");
  _id_B96CA3C98CA2FB0A(2, "apartment_snipernest");
  _id_B96CA3C98CA2FB0A(2, "underground_passage");
  _id_B96CA3C98CA2FB0A(3, "maintenance");
  _id_B96CA3C98CA2FB0A(3, "safe_house");
  _id_B96CA3C98CA2FB0A(3, "western_storage");
  _id_B96CA3C98CA2FB0A(3, "secret_comms", 1);
  _id_B96CA3C98CA2FB0A(3, "post_office");
  _id_B96CA3C98CA2FB0A(3, "antiquities_office", 1);
  _id_B96CA3C98CA2FB0A(3, "quiet_bedroom");
  _id_B96CA3C98CA2FB0A(3, "server_room");
  _id_B96CA3C98CA2FB0A(3, "hotel_room2", 1);
  _id_B96CA3C98CA2FB0A(3, "sunken_ship");
  _id_B96CA3C98CA2FB0A(3, "sec_camera_room");
  _id_B96CA3C98CA2FB0A(3, "mountain_top");
  _id_B96CA3C98CA2FB0A(4, "civic_center", 1);
  _id_B96CA3C98CA2FB0A(4, "embassy", 1);
  _id_B96CA3C98CA2FB0A(4, "fort", 1);
  _id_B96CA3C98CA2FB0A(4, "sira_mall", 1);
  _id_B96CA3C98CA2FB0A(4, "resort_entrance", 1);
  _id_B96CA3C98CA2FB0A(4, "police_academy", 1);
  _id_B96CA3C98CA2FB0A(4, "post_office_stronghold", 1);
  _id_B96CA3C98CA2FB0A(4, "control_tower", 1);
  _id_B96CA3C98CA2FB0A(4, "exhume_warehouse", 1);
  _id_B96CA3C98CA2FB0A("1_sabacrash", "crash_sm_1");
  _id_B96CA3C98CA2FB0A("1_sabacrash", "crash_wp_case");
  _id_B96CA3C98CA2FB0A("1_sabacrash", "sealion_port_managers_office");
  _id_B96CA3C98CA2FB0A("1_sabacrash", "sealion_castle_armory");
  _id_B96CA3C98CA2FB0A("2_sabacrash", "crash_sm_2");
  _id_B96CA3C98CA2FB0A("2_sabacrash", "crash_wp_case");
  _id_B96CA3C98CA2FB0A("2_sabacrash", "sealion_ferry_tourist_information_booth");
  _id_B96CA3C98CA2FB0A("2_sabacrash", "sealion_misplaced_crate");
  _id_B96CA3C98CA2FB0A("3_sabacrash", "crash_sm_3");
  _id_B96CA3C98CA2FB0A("3_sabacrash", "crash_wp_case");
  _id_B96CA3C98CA2FB0A("3_sabacrash", "sealion_water_treatment_control_center");
  _id_B96CA3C98CA2FB0A("3_sabacrash", "sealion_port_harbor_control");
  _id_B96CA3C98CA2FB0A("4_sabacrash", "crash_lrg_1");
  _id_B96CA3C98CA2FB0A("4_sabacrash", "crash_lrg_2");
  _id_B96CA3C98CA2FB0A("4_sabacrash", "crash_briefcase_1");
  _id_B96CA3C98CA2FB0A("1_b21", "red_door", 1);
  _id_B96CA3C98CA2FB0A("1_b21", "blue_door", 1);
  _id_B96CA3C98CA2FB0A("1_b21", "green_door", 1);
  _id_B96CA3C98CA2FB0A("1_b21", "black_door", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_shadow_company_toolbox", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_castle_armory", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_beach_club_bathroom", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_hotel_room_403", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_hotel_workers_office_fridge", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_port_managers_office", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_shipwreck_cargo_crate", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_farmers_toolbox", 1);
  _id_B96CA3C98CA2FB0A("1_sealion", "sealion_couple_fight_bag", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_misplaced_crate", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_knocked_over_workers_toolbox", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_observatory_thrown_fridge");
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_lab_office", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_town_canal_crate", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_ferry_tourist_information_booth", 1);
  _id_B96CA3C98CA2FB0A("2_sealion", "sealion_lost_travelers_bag");
  _id_B96CA3C98CA2FB0A("3_sealion", "sealion_water_treatment_control_center", 1);
  _id_B96CA3C98CA2FB0A("3_sealion", "sealion_port_harbor_control");
  _id_B96CA3C98CA2FB0A("3_sealion", "sealion_castle", 1);
  _id_B96CA3C98CA2FB0A("3_sealion", "sealion_cityhall", 1);
  _id_B96CA3C98CA2FB0A("4_sealion", "sealion_castle", 1);
  _id_B96CA3C98CA2FB0A("4_sealion", "sealion_cityhall", 1);
  _id_B96CA3C98CA2FB0A("1_delta", "de_city_hall", 1);
  _id_B96CA3C98CA2FB0A("1_delta", "de_museum_02", 1);
  _id_B96CA3C98CA2FB0A("1_delta", "de_museum_01", 1);
  _id_B96CA3C98CA2FB0A("1_delta", "de_tunnel_01");
  _id_B96CA3C98CA2FB0A("1_delta", "de_shopping_mall");
  _id_B96CA3C98CA2FB0A("1_delta", "de_hangar_01");
  _id_B96CA3C98CA2FB0A("1_delta", "de_homeboat_01");
  _id_B96CA3C98CA2FB0A("1_delta", "de_under_bridge");
  _id_B96CA3C98CA2FB0A("1_delta", "de_stage_01", 1);
  _id_B96CA3C98CA2FB0A("1_delta", "de_windmill", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_animal_care", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_shops_02", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_bike_parking_02", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_firestation_01", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_waterhome_04");
  _id_B96CA3C98CA2FB0A("2_delta", "de_homeboat_08");
  _id_B96CA3C98CA2FB0A("2_delta", "de_stadium", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_cruise_terminal", 1);
  _id_B96CA3C98CA2FB0A("2_delta", "de_block_01");
  _id_B96CA3C98CA2FB0A("3_delta", "delta_oldmuseum", 1);
  _id_B96CA3C98CA2FB0A("3_delta", "delta_stadium", 1);
  _id_B96CA3C98CA2FB0A("3_delta", "delta_trainstation", 1);
  _id_B96CA3C98CA2FB0A("4_delta", "delta_aquarium", 1);
  _id_B96CA3C98CA2FB0A("4_delta", "delta_cityhall", 1);
  _id_B96CA3C98CA2FB0A("4_delta", "delta_firestation", 1);
  _id_B96CA3C98CA2FB0A("4_delta", "delta_terminal", 1);
}

_id_B96CA3C98CA2FB0A(category, _id_8F7EDDC9C0864A1B, _id_4BAAD979FEF17BC0) {
  level._id_F2E2B5ED406A7D94[category][level._id_F2E2B5ED406A7D94[category].size] = _id_8F7EDDC9C0864A1B;

  if(istrue(_id_4BAAD979FEF17BC0)) {
    if(!isDefined(level._id_EABF33BC40A9A363[category]))
      level._id_EABF33BC40A9A363[category] = [];

    level._id_EABF33BC40A9A363[category][level._id_EABF33BC40A9A363[category].size] = _id_8F7EDDC9C0864A1B;
  }
}

_id_F4C3A9C8DA53FBC9(categories, _id_0A8A80ADF71C7716, _id_D521671A5DC52DB9, _id_28140FFED2089170, _id_26EDAE68004E6C83) {
  _id_9B43447DBBDF246B = scripts\engine\utility::_id_6E4039E57D0A3E7E(categories, _id_0A8A80ADF71C7716);

  if(!isDefined(_id_9B43447DBBDF246B) || !isDefined(level._id_EABF33BC40A9A363[_id_9B43447DBBDF246B]) || level._id_EABF33BC40A9A363[_id_9B43447DBBDF246B].size == 0)
    return undefined;

  key = scripts\engine\utility::random(level._id_EABF33BC40A9A363[_id_9B43447DBBDF246B]);
  _id_9B2459DEE80D0FE7 = scripts\engine\utility::_id_6E4039E57D0A3E7E(["", "_used", "_worn"], [_id_D521671A5DC52DB9, _id_28140FFED2089170, _id_26EDAE68004E6C83]);

  if(!isDefined(_id_9B2459DEE80D0FE7))
    return undefined;

  return "loot_key_" + key + _id_9B2459DEE80D0FE7;
}

_id_23326C8AC97C60C7(_id_D259D727BBA44656, _id_FD055A27DA9B626F, _id_EC6A1127CDA9E8C4, _id_B12C0079F47946DF, _id_086A95353C7E4EE8, _id_7AC6D26C235B0601, _id_B8DA46C98DAD35FA, _id_FC3E95C7096A9A71, _id_D521671A5DC52DB9, _id_28140FFED2089170, _id_26EDAE68004E6C83, _id_E6AC6A73F0B31C4E) {
  _id_333B22FC26CBC11F = [];
  _id_EB6F2E9E793E992E = 0;

  if(istrue(_id_D259D727BBA44656)) {
    if(isDefined(_id_086A95353C7E4EE8)) {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_086A95353C7E4EE8;
      _id_333B22FC26CBC11F[1] = _id_086A95353C7E4EE8;
    } else {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + 1;
      _id_333B22FC26CBC11F[1] = 1;
    }
  }

  if(istrue(_id_FD055A27DA9B626F)) {
    if(isDefined(_id_7AC6D26C235B0601)) {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_7AC6D26C235B0601;
      _id_333B22FC26CBC11F[2] = _id_7AC6D26C235B0601;
    } else {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + 1;
      _id_333B22FC26CBC11F[2] = 1;
    }
  }

  if(istrue(_id_EC6A1127CDA9E8C4)) {
    if(isDefined(_id_7AC6D26C235B0601)) {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_B8DA46C98DAD35FA;
      _id_333B22FC26CBC11F[3] = _id_B8DA46C98DAD35FA;
    } else {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + 1;
      _id_333B22FC26CBC11F[3] = 1;
    }
  }

  if(istrue(_id_B12C0079F47946DF)) {
    if(isDefined(_id_FC3E95C7096A9A71)) {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_FC3E95C7096A9A71;
      _id_333B22FC26CBC11F[4] = _id_FC3E95C7096A9A71;
    } else {
      _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + 1;
      _id_333B22FC26CBC11F[4] = 1;
    }
  }

  roll = randomint(_id_EB6F2E9E793E992E);
  _id_0DB4D4D3DCAE5375 = 0;
  _id_390AE2320A151006 = undefined;

  foreach(tier, _id_DBBEC3CD4A60CA51 in _id_333B22FC26CBC11F) {
    _id_0DB4D4D3DCAE5375 = _id_0DB4D4D3DCAE5375 + _id_DBBEC3CD4A60CA51;

    if(roll < _id_0DB4D4D3DCAE5375) {
      _id_390AE2320A151006 = tier;
      break;
    }
  }

  _id_BF3D63E39C071FAB = [];
  _id_D73CB1F45B5418A1 = 0;

  if(isDefined(_id_D521671A5DC52DB9)) {
    _id_D73CB1F45B5418A1 = _id_D73CB1F45B5418A1 + _id_D521671A5DC52DB9;
    _id_BF3D63E39C071FAB[""] = _id_D521671A5DC52DB9;
  }

  if(isDefined(_id_28140FFED2089170)) {
    _id_D73CB1F45B5418A1 = _id_D73CB1F45B5418A1 + _id_28140FFED2089170;
    _id_BF3D63E39C071FAB["_used"] = _id_28140FFED2089170;
  }

  if(isDefined(_id_26EDAE68004E6C83)) {
    _id_D73CB1F45B5418A1 = _id_D73CB1F45B5418A1 + _id_26EDAE68004E6C83;
    _id_BF3D63E39C071FAB["_worn"] = _id_26EDAE68004E6C83;
  }

  if(_id_BF3D63E39C071FAB.size == 0)
    _id_F97B516EEAB99CBB = scripts\engine\utility::random(["", "_worn", "_used"]);
  else {
    roll = randomint(_id_D73CB1F45B5418A1);
    _id_0DB4D4D3DCAE5375 = 0;
    _id_F97B516EEAB99CBB = undefined;

    foreach(quality, _id_D4846EC86821410A in _id_BF3D63E39C071FAB) {
      _id_0DB4D4D3DCAE5375 = _id_0DB4D4D3DCAE5375 + _id_D4846EC86821410A;

      if(roll < _id_0DB4D4D3DCAE5375) {
        _id_F97B516EEAB99CBB = quality;
        break;
      }
    }
  }

  if(isDefined(_id_E6AC6A73F0B31C4E))
    _id_390AE2320A151006 = _id_390AE2320A151006 + "_" + _id_E6AC6A73F0B31C4E;

  _id_8F7EDDC9C0864A1B = scripts\engine\utility::random(level._id_F2E2B5ED406A7D94[_id_390AE2320A151006]);
  _id_FA6333B1A0588411 = "loot_key_" + _id_8F7EDDC9C0864A1B + _id_F97B516EEAB99CBB;
  return _id_FA6333B1A0588411;
}

_id_E726302A1F8D9A1A() {
  level._id_A7AF1E28DC5852F3 = spawnStruct();
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400 = [];
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"] = [];
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"] = [];
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"] = [];
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_br_msecho_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_la_rpapa7_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_dm_pgolf1_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_dm_la700_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_br_soscar14_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sh_charlie725_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sh_mviktor_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_lm_ahotel_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_lm_kilo21_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_ar_mike4_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_ar_kilo53_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sm_papa90_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sm_alpha57_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_golf3_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_br_msecho_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_mike14_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_sa700_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_scromeo_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_sh_mbravo_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_lm_foxtrot_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_lm_rkilo_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_kilo53_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_augolf_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_akilo_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_sm_victor_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_br_soscar14_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_sm_alpha57_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_la_juliet_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"].size] = "brloot_weapon_pi_decho_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"].size] = "brloot_weapon_pi_golf17_epic";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"].size] = "brloot_weapon_pi_golf18_lege";
  level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"][level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400["pistol"].size] = "brloot_weapon_pi_swhiskey_lege";
}

_id_3C30CD923087306B(category) {
  if(!isDefined(level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400[category])) {
    return;
  }
  return scripts\engine\utility::random(level._id_A7AF1E28DC5852F3._id_E0FFFA1AF7503400[category]);
}

_id_A60E40071D04DB92(player, _id_606F47FE5A7A935D) {
  if(!isDefined(_id_606F47FE5A7A935D))
    logprint("'keyUsed' is undefined. Parameter [1], 'keyUsed'");

  if(!isDefined(player)) {
    logprint("'player' is undefined. Parameter [0], 'player'");
    return;
  }

  if(!isPlayer(player)) {
    logprint("'player' object passed in is not a Player . Parameter [0], 'player'");
    return;
  }

  _id_727C48E0D16106B0 = scripts\engine\utility::_id_53C4C53197386572(_id_606F47FE5A7A935D, "stat_22A0E850ADD468A3");

  if(isDefined(player) && isPlayer(player)) {
    _id_6F8E00E25EB68CA5 = player.origin[0];
    _id_6F8DFFE25EB68A72 = player.origin[1];
    _id_6F8DFEE25EB6883F = player.origin[2];
    _id_A9A662E0842A9EA8 = player.angles[0];
    _id_9AB5E9B12A34C66D = player.angles[1];
    _id_2C03C414C57B6915 = player.angles[2];
    _id_FF9358B3AC96C7AB = scripts\engine\utility::_id_53C4C53197386572(_id_4A6760982B403BAD::_id_1B15450E092933CF(gettime()), 0.0);
    _id_9C02E895E4DBDC3B = _id_2892A7E13357D95B::_id_C43F9411E4146FBD();
    _id_0672820B647EC78D = scripts\engine\utility::_id_53C4C53197386572(_id_45F403E1732217D3::_id_260DF5DDBFEBAC5F(player), "stat_22A0E850ADD468A3");
    player dlog_recordplayerevent("dlog_event_dmz_keycard_used", ["key_type", _func_1823FF50BB28148D(_id_727C48E0D16106B0), "player_position_x", _id_6F8E00E25EB68CA5, "player_position_y", _id_6F8DFFE25EB68A72, "player_position_z", _id_6F8DFEE25EB6883F, "player_rotation_pitch", _id_A9A662E0842A9EA8, "player_rotation_yaw", _id_9AB5E9B12A34C66D, "player_rotation_roll", _id_2C03C414C57B6915, "lpcon_level", _func_1823FF50BB28148D(_id_9C02E895E4DBDC3B), "team_id", _func_1823FF50BB28148D(_id_0672820B647EC78D), "match_time_elapsed", _id_FF9358B3AC96C7AB]);
  }
}