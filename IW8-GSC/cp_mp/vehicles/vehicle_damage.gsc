/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_damage.gsc
***********************************************/

vehicle_damage_setCanDamage(var_0) {
  var_1 = self getlinkedchildren(1);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.code_classname) && var_3.code_classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E") {
        if(var_0) {
          var_3 thread vehicle_damage_keepturretalive(self);
          continue;
        }

        var_3 vehicle_damage_keepturretaliveend();
      }
    }
  }

  self setCanDamage(var_0);
  vehicle_damage_cleareventlog(self);
}

vehicle_damage_getleveldataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldata();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.isattachmentvariantlocked = [];
      var_4.class = "_encstr_8BBA05185F8B99";
      var_4.showtacmaphint = undefined;
      var_4._id_12899 = undefined;
      var_4.siege_bot_team_triple_cap_check = undefined;
      var_4.flare_setup = undefined;
      var_4.visualpercents = [];
      var_4.visualcallbacks = [];
      var_4.visualclearcallbacks = [];
      var_4.visualhighesttolowest = undefined;
    } else if(!istrue(var_2)) {}
  }

  return var_4;
}

_id_1414C(var_0, var_1, var_2) {
  var_3 = var_0.damagedata;

  if(!isDefined(var_3)) {
    if(istrue(var_1)) {
      var_3 = spawnStruct();
      var_0.damagedata = var_3;
      var_3.lb_mg_impulse_dmg_threshold_low = undefined;
      var_3.lb_mg_impulse_dmg_threshold_mid = undefined;
      var_3.lb_mg_dmg_factor_landing_gear = undefined;
      var_3.lb_mg_dmg_factor_main_rotor = undefined;
      var_3.sidekillcount = undefined;
      var_3.siege_bot_team_had_advantage = undefined;
      var_3.shuttingdown = undefined;
      var_3.sidehouse_intel_sequence = undefined;
      var_3._id_11BAE = undefined;
      var_3._id_11BAF = undefined;
      var_3._id_11BAC = undefined;
      var_3._id_11BAD = undefined;
      var_3.wind_trigger_toggle = undefined;
      var_3.wind_triggers = undefined;
      var_3.winbycaptures = undefined;
      var_3.wind_trigger_loop = undefined;
    } else if(!istrue(var_2)) {}
  }

  return var_3;
}

_id_1416E(var_0) {
  return _id_1414C(var_0, 1);
}

_id_14141(var_0) {
  var_0.damagedata = undefined;
}

_id_1414D(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_damage_getleveldataforvehicle(var_0, var_2, var_3);
  var_5 = var_4.isattachmentvariantlocked[var_1];

  if(!isDefined(var_5)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4.isattachmentvariantlocked[var_1] = var_5;
      var_5.maxhealth = undefined;
      var_5._id_12024 = undefined;
      var_5._id_1202D = undefined;
    } else if(!istrue(var_3)) {}
  }

  return var_5;
}

_id_1416F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_5.visualpercents[var_4] = var_1;
  var_5.visualcallbacks[var_4] = var_2;
  var_5.visualclearcallbacks[var_4] = var_3;
}

_id_14142(var_0, var_1) {
  var_2 = vehicle_damage_getleveldataforvehicle(var_0, 0);

  if(isDefined(var_2)) {
    var_2.visualpercents[var_1] = undefined;
    var_2.visualcallbacks[var_1] = undefined;
    var_2.visualclearcallbacks[var_1] = undefined;
  }
}

_id_1416D(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_1.visualhighesttolowest = 1;
  _id_1416F(var_0, 0.85, ::_id_1415C, ::vehicle_damage_lightvisualclearcallback, "_encstr_8FA906CC80677438");
  _id_1416F(var_0, 0.5, ::_id_1415F, ::vehicle_damage_mediumvisualclearcallback, "_encstr_AB5E07609A5B7368E5");
  _id_1416F(var_0, 0.15, ::_id_14157, ::vehicle_damage_heavyvisualclearcallback, "_encstr_B846067B175AA56A");

  if(level.gametype != "_encstr_B607038AAB")
    _id_1416F(var_0, 0.15, ::_id_14145, ::_id_14146, "_encstr_817F076A48F76C8B81");
}

_id_14140(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_1.visualhighesttolowest = undefined;
  _id_14142(var_0, "_encstr_8FA906CC80677438");
  _id_14142(var_0, "_encstr_AB5E07609A5B7368E5");
  _id_14142(var_0, "_encstr_B846067B175AA56A");
  _id_14142(var_0, "_encstr_817F076A48F76C8B81");
}

vehicle_damage_clearvisuals(var_0, var_1, var_2) {
  if(isDefined(self.vehiclename)) {
    var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, 0, 1);

    if(isDefined(var_3)) {
      foreach(var_5 in var_3.visualclearcallbacks)
      self thread[[var_5]](var_0, var_1, var_2);
    }
  }
}

_id_14170() {
  _id_1413C(self.maxhealth);
}

_id_1413C(var_0) {
  self.health = int(min(self.health + var_0, self.maxhealth));
  var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(level.gametype == "_encstr_B607038AAB")
    _id_14181();
  else
    _id_14182(undefined, 0, 1);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
}

_id_14160(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_0, var_1);
  var_4 = vehicle_damage_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_3)) {
    if(isDefined(var_4._id_11FA5) && isDefined(var_4._id_11FA5[var_3]))
      var_2 = var_2 * var_4._id_11FA5[var_3];

    if(isDefined(var_4._id_11FA4) && isDefined(var_4._id_11FA4[var_3]))
      var_2 = clamp(var_2, 0, var_4._id_11FA4[var_3]);
  }

  return var_2;
}

vehicle_damage_init() {
  var_0 = spawnStruct();
  level.vehicle.damage = var_0;
  var_0.vehicledata = [];
  var_0._id_12899 = getdvarint("_encstr_B471284349BECF6B479AD9F963DA09A9A73A3F313ABB461B8D692ABB77DC59CDE573A7517C83B3CDE1A1", 125);
  var_0.siege_bot_team_triple_cap_check = getdvarint("_encstr_82B825C862CAE793F768DBC6EC1F1D63F5AAF0F0D9E3D3ABAF18D5CFEE57C4235EE2E02090BF01", 350);
  var_0._id_11BB0 = getdvarfloat("_encstr_818628F74B22B97BFFE2CBB7ADA8BB316007775DA151666B63B9C977C875137C07D10A8BDC2B3745B32F", 0.5);
  var_0.flare_setup = getdvarfloat("_encstr_85431ED3673071731DB82AF24065F3B690CB7F4DBDE0C2CBA570C32A6F4BAF6F", 8);
  _id_1415D();
  vehicle_damage_initdebug();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C5055208731B")]]();

  if(level.gametype == "_encstr_B607038AAB")
    _id_14159();
  else
    _id_14158();

  level.brking_managecircles = getdvarint("_encstr_9A8A28CD8DE4F59DB20DA51B36CAAF5863D8F6EEEB4658AD5876ACBE2C5D235ADBF5CCAC594698B0B1D6", 1);
  _id_1415A();
}

_id_1415D() {
  var_0 = vehicle_damage_getleveldata();
  var_1 = spawnStruct();
  var_0.table = var_1;
  var_1._id_11CA5 = [];
  var_1._id_11CA6 = [];
  var_1.spawn_lmg_soldiers_01 = [];
  var_1.spawn_lmg_soldiers_02 = [];
  var_1._id_133C2 = [];
  var_1._id_133C3 = [];
  var_2 = [];
  var_2["_encstr_959506B911C79707"] = [];
  var_2["_encstr_9A50080BA7292FFA0DA2"] = [];
  var_3 = [];
  var_3["_encstr_AFDE0AEE2B0B0EDEDC53DE23"] = [];
  var_3["_encstr_97DE0AEE2B58E07B9B09A014"] = [];
  var_3["_encstr_825413DD2B85C17B9B4D5BB48348579373227B7737"] = [];

  if(getDvar("_encstr_85F5192646BB275BF52BC860C30DB699526D97A45F0109E1DA13A0", "_encstr_B40101") != "_encstr_B40101")
    var_1 = getDvar("_encstr_85F5192646BB275BF52BC860C30DB699526D97A45F0109E1DA13A0", "_encstr_B40101");
  else if(level.gametype == "_encstr_B607038AAB")
    var_1 = "_encstr_8197207D37E6871A5F48A26AA81FD5573D17F5E9C4C90366ED70AA11D8551DF73304";
  else
    var_1 = "_encstr_AB411DED61795E4B185BCA2280067397F92B9569D72B2BD756F0C24EA96623";

  var_4 = undefined;
  var_5 = tablelookupgetnumcols(var_1);

  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow(var_1, 0, var_6);

    if(isDefined(var_7) && var_7 != "_encstr_B40101") {
      if(getsubstr(var_7, 0, 1) == "_encstr_8E4C028A") {
        var_4 = getsubstr(var_7, 1, var_7.size);
        continue;
      }

      if(isDefined(var_2[var_4]))
        var_2[var_4][var_7] = var_6;
    }
  }

  var_8 = undefined;
  var_9 = 0;
  var_10 = tablelookupgetnumrows(var_1);

  for(var_9 = 0; var_9 < var_10; var_9++) {
    var_11 = tablelookupbyrow(var_1, var_9, 1);

    if(isDefined(var_11) && var_11 != "_encstr_B40101") {
      if(getsubstr(var_11, 0, 1) == "_encstr_8E4C028A") {
        var_8 = getsubstr(var_11, 1, var_11.size);
        continue;
      }

      if(isDefined(var_3[var_8]))
        var_3[var_8][var_11] = var_9;
    }
  }

  foreach(var_8, var_13 in var_3) {
    foreach(var_11, var_15 in var_13) {
      foreach(var_4, var_17 in var_2) {
        foreach(var_7, var_19 in var_17) {
          var_20 = tablelookup(var_1, 0, var_15, var_19);

          if(isDefined(var_20) && var_20 != "_encstr_B40101")
            _id_1415E(var_20, var_11, var_8, var_7, var_4);
        }
      }
    }
  }
}

_id_1415E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_damage_getleveldata();
  var_6 = var_5.table;

  if(var_2 == "_encstr_AFDE0AEE2B0B0EDEDC53DE23") {
    var_7 = float(var_0);

    if(var_4 == "_encstr_959506B911C79707") {
      if(!isDefined(var_6._id_11CA5[var_3]))
        var_6._id_11CA5[var_3] = [];

      var_6._id_11CA5[var_3][var_1] = var_7;
    } else if(var_4 == "_encstr_9A50080BA7292FFA0DA2") {
      if(!isDefined(var_6._id_11CA6[var_3]))
        var_6._id_11CA6[var_3] = [];

      var_6._id_11CA6[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "_encstr_97DE0AEE2B58E07B9B09A014") {
    var_7 = int(var_0);

    if(var_4 == "_encstr_959506B911C79707") {
      if(!isDefined(var_6.spawn_lmg_soldiers_01[var_3]))
        var_6.spawn_lmg_soldiers_01[var_3] = [];

      var_6.spawn_lmg_soldiers_01[var_3][var_1] = var_7;
    } else if(var_4 == "_encstr_9A50080BA7292FFA0DA2") {
      if(!isDefined(var_6.spawn_lmg_soldiers_02[var_3]))
        var_6.spawn_lmg_soldiers_02[var_3] = [];

      var_6.spawn_lmg_soldiers_02[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "_encstr_825413DD2B85C17B9B4D5BB48348579373227B7737") {
    var_7 = int(var_0) != 0;

    if(var_4 == "_encstr_959506B911C79707") {
      if(!isDefined(var_6._id_133C2[var_3]))
        var_6._id_133C2[var_3] = [];

      var_6._id_133C2[var_3][var_1] = var_7;
    } else if(var_4 == "_encstr_9A50080BA7292FFA0DA2") {
      if(!isDefined(var_6._id_133C3[var_3]))
        var_6._id_133C3[var_3] = [];

      var_6._id_133C3[var_3][var_1] = var_7;
    }
  }
}

_id_1413D(var_0, var_1) {
  var_2 = vehicle_damage_getleveldata();
  var_3 = var_2.table;
  var_4 = vehicle_damage_getleveldataforvehicle(var_0, undefined, var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_4.class;

  if(isDefined(var_3._id_11CA5[var_5])) {
    foreach(var_8, var_7 in var_3._id_11CA5[var_5])
    _id_1417A(var_8, var_7, 0, var_0);
  }

  if(isDefined(var_3._id_11CA6[var_0])) {
    foreach(var_8, var_7 in var_3._id_11CA6[var_0])
    _id_1417A(var_8, var_7, 0, var_0);
  }

  if(isDefined(var_3.spawn_lmg_soldiers_01[var_5])) {
    foreach(var_12, var_11 in var_3.spawn_lmg_soldiers_01[var_5]) {
      _id_1417C(var_12, var_11, var_0);
      _id_14179(var_0, 100, var_12);
    }
  }

  if(isDefined(var_3.spawn_lmg_soldiers_02[var_0])) {
    foreach(var_12, var_11 in var_3.spawn_lmg_soldiers_02[var_0]) {
      _id_1417C(var_12, var_11, var_0);
      _id_14179(var_0, 100, var_12);
    }
  }
}

_id_14158() {
  _id_1417B("_encstr_9B69114A571F8EBD17484FBA87220987C71A97", 5);
  _id_1417B("_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA", 5);
  _id_1417B("_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59", 5);
  _id_1417B("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", 5);
  _id_1417B("_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0", 5);
  _id_1417B("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", 6);
  _id_1417B("_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B", 4);
  _id_1417B("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", 3);
  _id_1417B("_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB", 3);
  _id_1417B("_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", 3);
  _id_1417B("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", 3);
  _id_1417B("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 3);
  _id_1417B("_encstr_92A70ABB8267F5E0D89F6351", 3);
  _id_1417B("_encstr_9AAE0876FCB7603101DB", 3);
  _id_1417B("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", 3);
  _id_1417B("_encstr_81430B218B3F7018458997D78A", 3);
  _id_1417B("_encstr_ACC40CC1F8A321601715CFBFE0EA", 3);
  _id_1417B("_encstr_BA730BF8AFF178988293F158B9", 2);
  _id_1417B("_encstr_99410C4B48C39AB7D0CD95B769DB", 2);
  _id_1417B("_encstr_B29B0FE0E32573E3A23395B04E6BBF5898", 1);
  _id_1417B("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1);
  _id_1417B("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 4);
  _id_1417B("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 0.5);
  _id_1417B("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 2);
  _id_1417B("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1);
  _id_1417B("_encstr_AC740FAA3BF169D025C6A373200C27E06B", 3);
  _id_1417B("_encstr_95E70D8EDBDA85F5839CED35F5B683", 3);
  _id_1417B("_encstr_8DCB0F47F22330CEE7996B13A2E390583A", 15);
  _id_1417B("_encstr_A2950D16C9E8D2361B59932FF55BC1", 3);
  _id_1417B("_encstr_A29408E6D5D6CAAF5B1C", 15);
  _id_1417B("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", 15);
  _id_1417B("_encstr_88710EC26CC49918FA1A815BB5AFADC1", 5);
  _id_1417B("_encstr_88F90EF65F8E7A1AEED5251AE97F9788", 1);
  _id_1417B("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07", 3);
  _id_1417B("_encstr_A73C111777369AFDE0F3A1772B203E1298F3DB", 5);
  _id_1417B("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB", 3);
  _id_1417B("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E", 5);
}

_id_14159() {
  _id_1417B("_encstr_9B69114A571F8EBD17484FBA87220987C71A97", 10);
  _id_1417B("_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA", 10);
  _id_1417B("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", 10);
  _id_1417B("_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0", 10);
  _id_1417B("_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59", 10);
  _id_1417B("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", 20);
  _id_1417B("_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B", 10);
  _id_1417B("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", 6);
  _id_1417B("_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB", 6);
  _id_1417B("_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", 6);
  _id_1417B("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", 6);
  _id_1417B("_encstr_9AAE0876FCB7603101DB", 13);
  _id_1417B("_encstr_92A70ABB8267F5E0D89F6351", 4);
  _id_1417B("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 4);
  _id_1417B("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0", 4);
  _id_1417B("_encstr_BA730BF8AFF178988293F158B9", 1);
  _id_1417B("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", 5);
  _id_1417B("_encstr_81430B218B3F7018458997D78A", 13);
  _id_1417B("_encstr_99410C4B48C39AB7D0CD95B769DB", 1);
  _id_1417B("_encstr_B29B0FE0E32573E3A23395B04E6BBF5898", 1);
  _id_1417B("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", 4);
  _id_1417B("_encstr_ACC40CC1F8A321601715CFBFE0EA", 13);
  _id_1417B("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1);
  _id_1417B("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 4);
  _id_1417B("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 0.5);
  _id_1417B("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 2);
  _id_1417B("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1);
  _id_1417B("_encstr_AC740FAA3BF169D025C6A373200C27E06B", 3);
  _id_1417B("_encstr_95E70D8EDBDA85F5839CED35F5B683", 12);
  _id_1417B("_encstr_8DCB0F47F22330CEE7996B13A2E390583A", 15);
  _id_1417B("_encstr_A2950D16C9E8D2361B59932FF55BC1", 10);
  _id_1417B("_encstr_A29408E6D5D6CAAF5B1C", 20);
  _id_1417B("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", 15);
  _id_1417B("_encstr_88710EC26CC49918FA1A815BB5AFADC1", 6);
  _id_1417B("_encstr_88F90EF65F8E7A1AEED5251AE97F9788", 1);
  _id_1417B("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07", 3);
  _id_1417B("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07", 3);
  _id_1417B("_encstr_A73C111777369AFDE0F3A1772B203E1298F3DB", 10);
  _id_1417B("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB", 3);
  _id_1417B("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E", 5);
  _id_1417B("_encstr_8C2F1137A27861F12E284A3D76576398DF8B6B", 10);
  _id_1417B("_encstr_9331124BFBD033DE7171F9CC49F0E61ACE0E2203", 10);
  _id_1417B("_encstr_B6D110371AEBC60B7DDADAD236DBC4F5B683", 10);
  _id_1417B("_encstr_8A6E10B968F5D885BE0E0B63831A58BEAD0E", 10);
  _id_1417B("_encstr_B1E0119B86AFD816FABB85D838D0B023D7DA07", 10);
}

_id_1415A() {
  _id_14174("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F", 0.5, 0);
}

vehicle_damage_getleveldata() {
  return level.vehicle.damage;
}

vehicle_damage_isselfdamage(var_0, var_1) {
  if(isDefined(var_1.inflictor)) {
    if(var_1.inflictor == var_0)
      return 1;

    var_2 = scripts\cp_mp\vehicles\vehicle::_id_14193(var_0);

    foreach(var_4 in var_2) {
      if(var_1.inflictor == var_4)
        return 1;
    }

    if(var_1.inflictor.classname == "_encstr_8D8A07F05F6987BF4B" && isDefined(var_1.inflictor.vehicle) && var_1.inflictor.vehicle == var_0)
      return 1;
  }

  return 0;
}

vehicle_damage_enableownerdamage(var_0) {
  var_0.ownerdamageenabled = 1;
}

vehicle_damage_isownerdamageenabled(var_0) {
  return istrue(var_0.ownerdamageenabled);
}

vehicle_damage_logevent(var_0, var_1) {
  if(!isDefined(var_0.damageevents))
    var_0.damageevents = [];

  var_0.damageevents[var_0.damageevents.size] = var_1;
  thread vehicle_damage_cleareventlogatframeend(var_0);
}

vehicle_damage_cleareventlog(var_0) {
  var_0 notify("_encstr_B8911DD9AC1AD2D8C6CAF53216D6C276CAEBC61B2B58C9A2D9CADC47317BD9");
  var_0.damageevents = undefined;
}

vehicle_damage_cleareventlogatframeend(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B8911DD9AC1AD2D8C6CAF53216D6C276CAEBC61B2B58C9A2D9CADC47317BD9");
  var_0 notify("_encstr_AAE82710F2BC7BC103DD10F5B16FC93FA7F91B486A1685DD53C580F5A4BFF1BB4B1093B802AF93F0F3");
  var_0 endon("_encstr_AAE82710F2BC7BC103DD10F5B16FC93FA7F91B486A1685DD53C580F5A4BFF1BB4B1093B802AF93F0F3");
  waittillframeend;
  thread vehicle_damage_cleareventlog(var_0);
}

vehicle_damage_referevent(var_0, var_1, var_2) {
  if(!isDefined(var_2.meansofdeath))
    return 0;

  if(!isexplosivedamagemod(var_2.meansofdeath))
    return 0;

  if(!isDefined(var_2.eventid))
    return 0;

  if(isDefined(var_0.damageevents)) {
    foreach(var_4 in var_0.damageevents) {
      if(var_4.eventid == var_2.eventid)
        return 0;
    }
  }

  if(!isDefined(var_2.inflictor))
    var_2.inflictor = undefined;

  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B8911DD9AC1AD2D8C6CAF53216D6C276CAEBC61B2B58C9A2D9CADC47317BD9");
  var_0 dodamage(var_2.damage, var_2.point, var_2.attacker, var_2.inflictor, var_2.meansofdeath, var_2.objweapon, var_2.hitlocation);
  vehicle_damage_logevent(var_0, var_2);
}

vehicle_damage_keepturretalive(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8279223BAC86D236D8567D3258B5169D567DB52BCA1C455739E4CA3A821B5A9D95A2B932");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, self, var_1, var_10, var_5, var_14, var_4, var_3, var_6, var_8, var_7, var_9, var_15);
  vehicle_damage_referevent(var_0, self, var_16);
  self.health = 2147483647;
}

vehicle_damage_keepturretaliveend(var_0) {
  self notify("_encstr_8279223BAC86D236D8567D3258B5169D567DB52BCA1C455739E4CA3A821B5A9D95A2B932");
  self setCanDamage(0);
}

vehicle_damage_dovisuals(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename);

  if(isDefined(var_1)) {
    var_2 = self.health / self.maxhealth;
    var_3 = self.health;
    var_4 = 0;

    if(isDefined(var_0) && isDefined(var_0.damage))
      var_3 = int(max(0, self.health - var_0.damage));

    var_5 = var_3 / self.maxhealth;
    var_6 = getarraykeys(var_1.visualpercents);

    if(istrue(var_1.visualhighesttolowest)) {
      if(var_1.visualpercents.size > 1) {
        var_6 = getarraykeys(var_1.visualpercents);

        for(var_7 = 0; var_7 < var_6.size; var_7++) {
          for(var_8 = var_7 + 1; var_8 < var_6.size; var_8++) {
            var_9 = var_1.visualpercents[var_6[var_7]];
            var_10 = var_1.visualpercents[var_6[var_8]];

            if(var_9 < var_10) {
              var_11 = var_6[var_7];
              var_6[var_7] = var_6[var_8];
              var_6[var_8] = var_11;
            }
          }
        }
      }
    }

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      var_12 = var_6[var_7];
      var_13 = var_1.visualpercents[var_12];

      if(var_5 > var_13) {
        if(isDefined(var_1.visualclearcallbacks[var_12])) {
          var_14 = var_2 <= var_13;
          self thread[[var_1.visualclearcallbacks[var_12]]](var_0, var_14);
        }

        continue;
      }

      if(isDefined(var_1.visualcallbacks[var_12])) {
        var_14 = var_2 > var_13;
        self thread[[var_1.visualcallbacks[var_12]]](var_0, var_14);
      }
    }
  }
}

_id_14184(var_0, var_1) {
  self notify("_encstr_8EFF2D76CB405C8739B9E9620181C79770D70EE17FABE6634E73E22BAFEFAB4EF0039E7797D02F0F8D8D8A22903427");
  self endon("_encstr_8EFF2D76CB405C8739B9E9620181C79770D70EE17FABE6634E73E22BAFEFAB4EF0039E7797D02F0F8D8D8A22903427");
  var_2 = undefined;

  while(isDefined(self)) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
      var_3 = undefined;
      var_4 = int(self vehicle_getspeed());
      var_5 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

      if(var_5 && self vehicle_isonground())
        var_3 = 0;
      else if(!var_5 && var_4 <= 3)
        var_3 = 0;
      else if(var_4 <= 25)
        var_3 = 1;
      else
        var_3 = 2;

      if(isDefined(var_2) && var_3 != var_2) {
        var_6 = _id_1414D(self.vehiclename, var_0);
        self thread[[var_6._id_12024]](var_0, var_1);
        return;
      }

      var_2 = var_3;
    }

    wait 0.1;
  }
}

vehicle_damage_visualstopwatchingspeedchange() {
  self notify("_encstr_8EFF2D76CB405C8739B9E9620181C79770D70EE17FABE6634E73E22BAFEFAB4EF0039E7797D02F0F8D8D8A22903427");
}

_id_1415C(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle())
    self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_8F79084EEB0211E38D73", 1);
  else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground())
      self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_8F79084EEB0211E38D73", 1);
    else if(!var_3 && var_2 <= 3)
      self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_8F79084EEB0211E38D73", 1);
    else if(var_2 <= 25)
      self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_81EE09B1F6DD9AC1595991", 1);
    else
      self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_92B80AD0A53BD0A60EAC598C", 1);
  }

  thread _id_14184("_encstr_8FA906CC80677438", var_0);
}

vehicle_damage_lightvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("_encstr_814F0C745BBF7FC77D53486FF35B", "_encstr_BA19049F4B2D", 1);
}

_id_1415F(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle())
    self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_8F79084EEB0211E38D73", 1);
  else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground())
      self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_8F79084EEB0211E38D73", 1);
    else if(!var_3 && var_2 <= 3)
      self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_8F79084EEB0211E38D73", 1);
    else if(var_2 <= 25)
      self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_81EE09B1F6DD9AC1595991", 1);
    else
      self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_92B80AD0A53BD0A60EAC598C", 1);
  }

  thread _id_14184("_encstr_AB5E07609A5B7368E5", var_0);
}

vehicle_damage_mediumvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("_encstr_86E80D33A808C9DA7B11E7DF7B3332", "_encstr_BA19049F4B2D", 1);
}

_id_14157(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle())
    self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_8F79084EEB0211E38D73", 1);
  else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground())
      self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_8F79084EEB0211E38D73", 1);
    else if(!var_3 && var_2 <= 3)
      self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_8F79084EEB0211E38D73", 1);
    else if(var_2 <= 25)
      self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_81EE09B1F6DD9AC1595991", 1);
    else
      self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_92B80AD0A53BD0A60EAC598C", 1);
  }

  thread _id_14184("_encstr_B846067B175AA56A", var_0);
}

vehicle_damage_heavyvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("_encstr_96700C2BB010A1B203EB8F86DC03", "_encstr_BA19049F4B2D", 1);
}

_id_14145(var_0, var_1) {
  self setscriptablepartstate("_encstr_AD700D3258D60B76CA8AB9B34BDC59", "_encstr_860808CB78E2984063BA", 1);
}

_id_14146(var_0, var_1, var_2) {
  self setscriptablepartstate("_encstr_AD700D3258D60B76CA8AB9B34BDC59", "_encstr_BA19049F4B2D", 1);
}

_id_14152() {
  if(!isDefined(self.isautouse))
    return "_encstr_B4100940FB3BABDBE4BABA";

  return self.isautouse;
}

_id_14177(var_0, var_1, var_2) {
  self notify("_encstr_AB891419C2AD2C76ACF5CD3A581D95BEC6430BB976B2");

  if(var_1 != "_encstr_B4100940FB3BABDBE4BABA") {
    var_3 = _id_1414D(self.vehiclename, var_1);

    if(isDefined(var_3._id_1202D))
      self thread[[var_3._id_1202D]](var_0, var_2);
  }

  if(var_0 != "_encstr_B4100940FB3BABDBE4BABA") {
    var_3 = _id_1414D(self.vehiclename, var_0);

    if(isDefined(var_3._id_12024))
      self thread[[var_3._id_12024]](var_1, var_2);
  }

  self.isautouse = var_0;
}

_id_1417F(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  self.lasttimedamaged = gettime();
  _id_14182(var_0, var_1, var_2);
}

_id_14182(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_2);
  var_4 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage))
    var_4 = var_4 - int(var_0.damage);

  var_5 = "_encstr_B4100940FB3BABDBE4BABA";
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_10, var_9 in var_3.isattachmentvariantlocked) {
    if(!isDefined(var_7) || var_9.maxhealth < var_7) {
      if(var_4 <= var_9.maxhealth) {
        var_5 = var_10;
        var_6 = var_9;
        var_7 = var_9.maxhealth;
      }
    }
  }

  var_11 = _id_14152();

  if(var_5 != var_11) {
    if(!istrue(var_1)) {
      if(var_5 == "_encstr_B846067B175AA56A" && (!isDefined(var_11) || var_11 != "_encstr_B846067B175AA56A")) {
        if(!istrue(self.load_sequence_4_vfx)) {
          var_12 = _id_1414B(undefined, self.vehiclename);

          if(isDefined(var_12)) {
            if(isDefined(var_0) && isDefined(var_0.damage) && var_0.damage != 0)
              self.health = self.health + (var_12 - var_4);
          }
        }
      }
    }

    _id_14177(var_5, var_11, var_0);
  }
}

_id_14180(var_0, var_1) {
  var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  self.lasttimedamaged = gettime();
  _id_14181(var_0);
}

_id_14181(var_0) {
  var_1 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage))
    var_1 = var_1 - int(var_0.damage);

  var_2 = var_1 / self.maxhealth;

  if(var_2 <= 0.1)
    var_3 = "_encstr_B846067B175AA56A";
  else if(var_2 <= 0.5)
    var_3 = "_encstr_AB5E07609A5B7368E5";
  else if(var_2 <= 0.85)
    var_3 = "_encstr_8FA906CC80677438";
  else
    var_3 = "_encstr_B4100940FB3BABDBE4BABA";

  var_4 = _id_14152();

  if(var_3 != var_4)
    _id_14177(var_3, var_4, var_0);
}

_id_14143(var_0) {
  if(var_0)
    self.load_sequence_4_vfx = 1;
  else
    self.load_sequence_4_vfx = undefined;
}

_id_14165(var_0, var_1) {
  _id_1415C(var_1, 1);

  if(!isDefined(var_0) || var_0 == "_encstr_B4100940FB3BABDBE4BABA")
    _id_14166(var_0, var_1);
}

_id_1416A(var_0, var_1) {
  vehicle_damage_lightvisualclearcallback(var_1, 1);
}

_id_14167(var_0, var_1) {
  _id_1415F(var_1, 1);

  if(!isDefined(var_0) || var_0 == "_encstr_8FA906CC80677438" || var_0 == "_encstr_B4100940FB3BABDBE4BABA")
    _id_14168(var_0, var_1);
}

_id_1416B(var_0, var_1) {
  vehicle_damage_mediumvisualclearcallback(var_1, 1);
}

_id_14163(var_0, var_1) {
  _id_14157(var_1, 1);

  if(level.gametype != "_encstr_B607038AAB")
    _id_14145(var_1, 1);

  if(!isDefined(var_0) || var_0 != "_encstr_B846067B175AA56A") {
    if(!istrue(self.move_to_car_stop))
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);

    _id_14164(var_0, var_1);
    thread _id_1413E(var_1);
  }
}

_id_14169(var_0, var_1) {
  vehicle_damage_heavyvisualclearcallback(var_1, 1);
  _id_14146(var_1, 1);

  if(!isDefined(var_0) || var_0 != "_encstr_B846067B175AA56A") {
    if(!istrue(self.move_to_car_stop))
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);

    _id_14144();
  }
}

_id_1416C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_6.health = var_1;
  var_6._id_12899 = var_2;
  var_6.siege_bot_team_triple_cap_check = var_3;
  var_6._id_11BB0 = var_4;
  var_6.flare_setup = var_5;
  var_7 = _id_1414D(var_0, "_encstr_8FA906CC80677438", 1);
  var_7._id_12024 = ::_id_14165;
  var_7._id_1202D = ::_id_1416A;
  var_7 = _id_1414D(var_0, "_encstr_AB5E07609A5B7368E5", 1);
  var_7._id_12024 = ::_id_14167;
  var_7._id_1202D = ::_id_1416B;
  var_7 = _id_1414D(var_0, "_encstr_B846067B175AA56A", 1);
  var_7._id_12024 = ::_id_14163;
  var_7._id_1202D = ::_id_14169;
  _id_14183(var_0);
}

_id_1414E(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.vehiclename;

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1, 1);

  if(!isDefined(var_3)) {
    if(isDefined(var_0))
      return var_0.maxhealth;

    return undefined;
  }

  if(!isDefined(var_3.health)) {
    if(isDefined(var_0))
      return var_0.maxhealth;

    return undefined;
  }

  var_4 = var_3.health;
  var_5 = _id_14150(var_1);

  if(isDefined(var_5))
    var_4 = var_4 + var_5;

  var_6 = _id_1414A(var_1);

  if(isDefined(var_6))
    var_4 = var_4 + var_6;

  return int(var_4);
}

_id_14151(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.vehiclename;

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1, 1);

  if(!isDefined(var_3))
    return undefined;

  if(!isDefined(var_3.health))
    return undefined;

  var_4 = var_3.health;
  var_5 = _id_1414A(var_1);

  if(isDefined(var_5))
    var_4 = var_4 + var_5;

  if(!isDefined(var_4) || var_4 <= 0)
    return undefined;

  return int(var_4);
}

_id_1414B(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.vehiclename;

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1);

  if(!isDefined(var_3))
    return undefined;

  if(!isDefined(var_3.health))
    return undefined;

  var_4 = _id_1414A(var_1);

  if(!isDefined(var_4) || var_4 <= 0)
    return undefined;

  return int(var_4);
}

_id_14183(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_6, var_5 in var_1.isattachmentvariantlocked) {
    if(var_6 == "_encstr_8FA906CC80677438") {
      var_5.maxhealth = _id_14151(undefined, var_0);
      var_3 = var_5.maxhealth;
      continue;
    }

    if(var_6 == "_encstr_B846067B175AA56A") {
      var_5.maxhealth = _id_1414B(undefined, var_0);
      var_2 = var_5.maxhealth;
    }
  }

  var_5 = var_1.isattachmentvariantlocked["_encstr_AB5E07609A5B7368E5"];

  if(isDefined(var_5)) {
    if(isDefined(var_2) && isDefined(var_3)) {
      var_7 = _id_1414F(var_0);

      if(isDefined(var_7))
        var_5.maxhealth = int(scripts\engine\math::lerp(var_2, var_3, var_7));
    }
  }
}

_id_14150(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2._id_12899;

  if(!isDefined(var_3))
    var_3 = var_1._id_12899;

  if(!isDefined(var_3) || var_3 <= 0)
    return undefined;

  return int(var_3);
}

_id_1414A(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.siege_bot_team_triple_cap_check;

  if(!isDefined(var_3))
    var_3 = var_1.siege_bot_team_triple_cap_check;

  if(!isDefined(var_3) || var_3 <= 0)
    return undefined;

  return int(var_3);
}

_id_1414F(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2._id_11BB0;

  if(!isDefined(var_3))
    var_3 = var_1._id_11BB0;

  if(!isDefined(var_3) || var_3 <= 0 || var_3 > 1)
    return undefined;

  return var_3;
}

_id_1413E(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A7FF0E151DB5F16ACB98C6A6CC47BC30");

  if(!istrue(self.flarecooldown)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(self.vehiclename);
    var_2 = var_1.destroycallback;
    var_3 = _id_14149(self.vehiclename);
    var_4 = istrue(self.little_bird_mg_onexitheavydamagestate);

    if(!var_4 && isDefined(var_3) && isDefined(var_2)) {
      self.flarecooldown = 1;
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

      if(isDefined(var_5))
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_5, self.vehiclename);

      wait(var_3);
      self.flarecooldown = undefined;
      scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();
      self.flare_activated = 1;
      self thread[[var_2]](var_0, 0);
      return;
    }
  }
}

_id_14144(var_0) {
  if(!istrue(self.flarecooldown)) {
    return;
  }
  self notify("_encstr_A7FF0E151DB5F16ACB98C6A6CC47BC30");
  scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();

  if(!istrue(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

    if(isDefined(var_1))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_1, self.vehiclename);
  }

  self.flarecooldown = undefined;
}

_id_1415B() {
  return istrue(self.flarecooldown);
}

_id_14149(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.flare_setup;

  if(!isDefined(var_3))
    var_3 = var_1.flare_setup;

  if(!isDefined(var_3) || var_3 <= 0)
    return undefined;

  return var_3;
}

_id_1417D(var_0) {
  if(isDefined(var_0.meansofdeath)) {
    if(var_0.meansofdeath == "_encstr_8D4E0A501FCB898912CB3FA3")
      return 1;

    if(!isexplosivedamagemod(var_0.meansofdeath) && var_0.meansofdeath != "_encstr_9B0D099AD3887D91252954")
      return 0;
  }

  if(isDefined(var_0.objweapon) && !nullweapon(var_0.objweapon) && isDefined(self.vehiclename)) {
    var_1 = undefined;
    var_2 = self.vehiclename;
    var_3 = var_0.objweapon.basename;
    var_4 = vehicle_damage_getleveldata();
    var_5 = var_4.table;

    if(isDefined(var_4.table._id_133C3[var_2]))
      var_1 = var_4.table._id_133C3[var_2][var_3];

    if(isDefined(var_1))
      return var_1;

    var_6 = vehicle_damage_getleveldataforvehicle(var_2, undefined, 1);

    if(isDefined(var_6)) {
      var_7 = var_6.class;

      if(!isDefined(var_7) || var_7 == "_encstr_8BBA05185F8B99")
        return 1;

      if(isDefined(var_4.table._id_133C2[var_7]))
        var_1 = var_4.table._id_133C2[var_7][var_3];

      if(isDefined(var_1))
        return var_1;
    } else
      return 1;
  } else
    return 1;

  return 0;
}

_id_14147(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "_encstr_8BBA05185F8B99")
    var_1 = undefined;

  if(isDefined(var_3) && var_3 == "_encstr_8BBA05185F8B99")
    var_3 = undefined;

  if(!istrue(var_0.scurrentobjective) && isPlayer(var_0.attacker))
    var_0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::_id_141B7(self, var_0.attacker);

  if(isDefined(var_0.objweapon) && weaponclass(var_0.objweapon.basename) != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0") {
    if(istrue(var_2))
      var_0._id_12F0D = 1;

    if(istrue(var_4))
      var_0.chestorigin = 1;
  }

  var_0.attacker thread _id_14156(var_1, var_3, var_0, self);
}

_id_14166(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = _id_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3.wind_trigger_toggle;
        var_5 = var_3.wind_triggers;
        var_6 = var_3.winbycaptures;
        var_7 = var_3.wind_trigger_loop;
      }

      _id_14147(var_1, var_4, var_5, var_6, var_7);
    }
  }
}

_id_14168(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = _id_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3._id_11BAE;
        var_5 = var_3._id_11BAF;
        var_6 = var_3._id_11BAC;
        var_7 = var_3._id_11BAD;
      }

      _id_14147(var_1, var_4, var_5, var_6, var_7);
    }
  }
}

_id_14164(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = _id_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3.sidekillcount;
        var_5 = var_3.siege_bot_team_had_advantage;
        var_6 = var_3.shuttingdown;
        var_7 = var_3.sidehouse_intel_sequence;
      }

      if(isDefined(var_2.class)) {
        if(!isDefined(var_4)) {
          switch (var_2.class) {
            case "_encstr_8FA906CC80677438":
            case "_encstr_818F0CB9D50E9527EB1B963B3447":
              var_4 = "_encstr_BEF61769079317B8DCEF312E53BDA05BCABBD3978BDAEC30FC";
              break;
            case "_encstr_B6F60D728869C44F3820E0E5C7A387":
            case "_encstr_A37E0DDAAC8C4B5D5BAF1B2DD91AA3":
            case "_encstr_AB5E07609A5B7368E5":
              var_4 = "_encstr_8A12180CD30BE7C681780AB188FB3CBF61C995BF79113BCC6B6B";
              break;
            case "_encstr_B846067B175AA56A":
            case "_encstr_81AC0C7BBD0B976247B0BAF26823":
              var_4 = "_encstr_851317D2136309B95D79F16F73E3C864FE699A07F417D2D0CF";
              break;
          }
        }

        if(!isDefined(var_6)) {}
      }

      _id_14147(var_1, var_4, var_5, var_6, var_7);
    }
  }
}

_id_14162(var_0) {
  if(isDefined(var_0) && isDefined(var_0.attacker)) {
    var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_1)) {
      var_2 = _id_1414C(self, undefined, 1);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_2)) {
        var_3 = var_2.lb_mg_impulse_dmg_threshold_low;
        var_4 = var_2.lb_mg_impulse_dmg_threshold_mid;
        var_5 = var_2.lb_mg_dmg_factor_landing_gear;
        var_6 = var_2.lb_mg_dmg_factor_main_rotor;
      }

      if(isDefined(var_1.class)) {
        if(!isDefined(var_3)) {
          switch (var_1.class) {
            case "_encstr_8FA906CC80677438":
            case "_encstr_818F0CB9D50E9527EB1B963B3447":
              var_3 = "_encstr_93681832B29B3A39DB5E958CAFEC95A19636362BFAD896760DE8";
              break;
            case "_encstr_B6F60D728869C44F3820E0E5C7A387":
            case "_encstr_A37E0DDAAC8C4B5D5BAF1B2DD91AA3":
            case "_encstr_AB5E07609A5B7368E5":
              var_3 = "_encstr_B8F21970028AB113DF11DD45DF533971F48AA8F019A5DBA99F25D1";
              break;
            case "_encstr_B846067B175AA56A":
            case "_encstr_81AC0C7BBD0B976247B0BAF26823":
              var_3 = "_encstr_BA80189051CFC3BD88B0F105CFA8A8B1AFD3C4570FB31F3FBBCB";
              break;
            default:
              var_3 = "_encstr_8BBA05185F8B99";
              break;
          }
        }

        if(!isDefined(var_5)) {}
      }

      if(isDefined(var_3) && var_3 == "_encstr_8BBA05185F8B99")
        var_3 = undefined;

      if(isDefined(var_5) && var_5 == "_encstr_8BBA05185F8B99")
        var_5 = undefined;

      if(isPlayer(var_0.attacker)) {
        if(!isDefined(var_0.scurrentobjective))
          var_0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::_id_141B7(self, var_0.attacker);
        else if(var_0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::_id_141B9(self, var_0.attacker))
          var_0.scurrentobjective = 0;
        else if(!var_0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::_id_141B7(self, var_0.attacker))
          var_0.scurrentobjective = 1;
      } else
        var_0.scurrentobjective = 0;

      if(isDefined(var_0.objweapon) && weaponclass(var_0.objweapon.basename) != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0") {
        if(istrue(var_4))
          var_0._id_12F0D = 1;

        if(istrue(var_6))
          var_0.chestorigin = 1;
      }

      if(var_0.scurrentobjective && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_BA871030B65C6DB33AB26DCBEC4A2CB162C4"))
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_BA871030B65C6DB33AB26DCBEC4A2CB162C4")]](self, var_0.inflictor, var_0.attacker, var_0.damage, var_0.objweapon);

      var_0.attacker _id_14155(var_3, var_5, var_0, self getentitynumber());
    }
  }
}

_id_14156(var_0, var_1, var_2, var_3) {
  var_4 = var_3 getentitynumber();
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AAA61E53A080F9A2412D71B7071BDABF49099FB790991B6AAFBEC7E6F8218170" + var_4);
  waittillframeend;
  thread _id_14155(var_0, var_1, var_3, var_4);
}

_id_14155(var_0, var_1, var_2, var_3) {
  self notify("_encstr_AAA61E53A080F9A2412D71B7071BDABF49099FB790991B6AAFBEC7E6F8218170" + var_3);

  if(isDefined(var_0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_A6250AB3B4ECCA9A8DED39AC")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2._id_12F0D), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_A6250AB3B4ECCA9A8DED39AC")]](var_0, var_4, !istrue(var_2.scurrentobjective));
  }

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_82D40AB35A679550EEB09346")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2.chestorigin), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_82D40AB35A679550EEB09346")]](var_1, var_4, !istrue(var_2.scurrentobjective));
  }
}

br_iseliminated(var_0) {
  var_1 = self;

  if(!var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.classname) && var_0.inflictor.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0") {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

  if(var_2.size <= 0) {
    return;
  }
  var_3 = 0;

  if(!isDefined(var_1.waitthensetgendersoundcontext))
    var_1.waitthensetgendersoundcontext = ["_encstr_9B1804C793EB", 0, "_encstr_81B20629C5B7B6B2", 0, "_encstr_8F4811F85FAD18390A9F060E79E373C3F2E7C0", 0, "_encstr_82680E6210C589BD482933D7831B8FA4", 0, "_encstr_B466095A7116816BDB36BF", 0, "_encstr_97840E40EB0B153049EE5B59E9AE08ED", 0, "_encstr_87680AB085AF1DBA93C92B1D", 0, "_encstr_8A9E0E2347AE42F1E86E672EC0683F1A", 0, "_encstr_920D11620D19A29761B07F57A038614BCB90AD", 0, "_encstr_85FE0DD5727A27098513298817CA23", 0, "_encstr_A1470989E6EB65D9D83F30", 0, "_encstr_8261067B1D34AC27", 0];

  var_4 = br_isininfil(var_0);
  var_5 = -1;

  for(var_6 = 0; var_6 < var_1.waitthensetgendersoundcontext.size; var_6 = var_6 + 2) {
    if(var_1.waitthensetgendersoundcontext[var_6] == var_4)
      var_5 = var_6;
  }

  if(var_5 == -1)
    var_5 = 22;

  var_5 = var_5 + 1;
  var_1.waitthensetgendersoundcontext[var_5] = var_1.waitthensetgendersoundcontext[var_5] + var_0.damage;
}

br_isininfil(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.meansofdeath;
  var_3 = "_encstr_B40101";

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633")
    var_3 = "_encstr_9B1804C793EB";
  else if(!isent(var_0.attacker))
    var_3 = "_encstr_8261067B1D34AC27";
  else if(var_0.attacker == var_0.victim)
    var_3 = "_encstr_920D11620D19A29761B07F57A038614BCB90AD";
  else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && (var_0.objweapon.basename == "_encstr_97781E650A25C38AAC57A0C87B5BB7F5DF8A108FA21EBB8BF030E72F98F028EA" || var_0.objweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83" || var_0.objweapon.basename == "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A")) {
    if(!isDefined(var_0.attacker.vehicle))
      var_3 = "_encstr_87680AB085AF1DBA93C92B1D";
    else
      var_3 = "_encstr_B466095A7116816BDB36BF";
  } else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
    var_3 = "_encstr_82680E6210C589BD482933D7831B8FA4";
  else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1")
    var_3 = "_encstr_81B20629C5B7B6B2";
  else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
    var_3 = "_encstr_8F4811F85FAD18390A9F060E79E373C3F2E7C0";
  else if(isDefined(var_0.attacker.vehicle))
    var_3 = "_encstr_97840E40EB0B153049EE5B59E9AE08ED";
  else if(var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0.meansofdeath == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
    var_3 = "_encstr_A1470989E6EB65D9D83F30";
  else if(isPlayer(var_0.attacker))
    var_3 = "_encstr_8A9E0E2347AE42F1E86E672EC0683F1A";

  return var_3;
}

_id_1417E(var_0) {
  var_1 = self;

  if(!istrue(level.brking_managecircles)) {
    return;
  }
  if(issubstr(var_0.meansofdeath, "_encstr_A6260721AA98982A51") || var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") {
    if(isPlayer(var_0.attacker))
      var_0.attacker setscriptablepartstate("_encstr_97E41613E0C0B9E2016DF4B4CDDB1A6A48188B1F18DBE6DA", "_encstr_97E41613E0C0B9E2016DF4B4CDDB1A6A48188B1F18DBE6DA", 0);

    if(var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

      if(isDefined(var_2)) {
        foreach(var_4 in var_2)
        var_4 setscriptablepartstate("_encstr_A6ED11C14C4668A537DA0BD1C23B76A89BD661", "_encstr_A6ED11C14C4668A537DA0BD1C23B76A89BD661", 0);
      }
    }
  }
}

_id_1417A(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_9AE622B0BF5CCFEB0A0AB8302E322BB3A3F7C88083E1C09B327734487AA97B9811D75830"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_9AE622B0BF5CCFEB0A0AB8302E322BB3A3F7C88083E1C09B327734487AA97B9811D75830")]](var_0, var_1, var_2, var_3);
}

_id_14174(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C011F369FD8B97400FAD8739D95EA7AFC16A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C011F369FD8B97400FAD8739D95EA7AFC16A")]](var_0, var_1, var_2);
}

_id_1417B(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8D88174B550B3FA8299F3810E04B7BED7177B999A725328330"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8D88174B550B3FA8299F3810E04B7BED7177B999A725328330")]](var_0, var_1);
}

_id_14178(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8251188E33131BB80BEF5BC1B0596BFB6D411D5F3FD5CCFFB457"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8251188E33131BB80BEF5BC1B0596BFB6D411D5F3FD5CCFFB457")]](var_0, var_1);
}

_id_14179(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]](var_0, var_1, var_2);
}

_id_1417C(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]](var_0, var_1, var_2);
}

_id_14176(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_85A918C0514B5B122A2F5759E0BFD3EB674A07DF932355C16F8A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_85A918C0514B5B122A2F5759E0BFD3EB674A07DF932355C16F8A")]](var_0, var_1);
}

_id_14175(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_AF2619A06A23E1A88724F1E80C635153CED298D9C2FD2141A75BFA"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_AF2619A06A23E1A88724F1E80C635153CED298D9C2FD2141A75BFA")]](var_0, var_1);
}

_id_14171(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_99EA1113870319E55145A9343029C8C021AF4F"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_99EA1113870319E55145A9343029C8C021AF4F")]](var_0, var_1);
}

_id_14173(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(var_0, 1);

  if(!isDefined(var_3._id_11FA5))
    var_3._id_11FA5 = [];

  var_3._id_11FA5[var_1] = var_2;
}

_id_14172(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(var_0, 1);

  if(!isDefined(var_3._id_11FA4))
    var_3._id_11FA4 = [];

  var_3._id_11FA4[var_1] = var_2;
}

vehicle_damage_initdebug() {
  setdvarifuninitialized("_encstr_82FF0F23792E678308F9595B996087DF5D", 0);
  setdvarifuninitialized("_encstr_BE351A90877AEEE76AAD55D186930377D503D898C305C5FBF256446D", 0);
}