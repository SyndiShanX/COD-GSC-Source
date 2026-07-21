/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_numbers_tower.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_B28D1DB91B4E7D8939BECDEAAD89B24E37F51D7BDDCA27FACAB9C231C6B28C", 0)) {
    return;
  }
  scripts\engine\scriptable::scriptable_addpostinitcallback(::scriptable_postinit);
  scripts\engine\scriptable::_id_12F5B("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1", ::_id_11F32);
  level._id_11F35 = spawnStruct();
  level._id_11F35.eliminate_drone = getdvarint("_encstr_B4DB1CD2BEF5E17A53D993E75009357B8FD89B4D1C73EBBFB9989F9778A0", 0);
  level._id_11F35.usable = 0;
  level._id_11F35.localangles = getdvarint("_encstr_B64129D6B64BD729122720E0F75A81C523D1CD500B925576ECD7C048A37C5967DB45D0E6670B1379DE0748", 0);
  level._id_11F35._id_1277B = getdvarint("_encstr_912A2B889F62E6CD2329C055BDFA1B8BCBD738F0A70D1BFF2B0D4F5B19D3479613D7A8A877AEF1B3A1F5306EEF", 0);

  if(!level._id_11F35.eliminate_drone)
    level._id_11F35.usable = getdvarint("_encstr_A90F1CE66C39AF9827AFB9ABB589CA27CDEBA3DEEEB239D757DC0B2663B2", 0);

  level._id_11F35._id_13C1A = [];
  level._id_11F35._id_13C19 = [];

  if(level._id_11F35.usable) {
    level._id_1442D = ::maxaccesscardspawns_red;
    level._effect["_encstr_B634159825BFCDFB1EE657684F2B752269551F1EF04080"] = loadfx("_encstr_8F6927D9CCF097A5DD1CD72693CBB30BD6958363582FBCB3CC877D73BAD631599CDCAFCDBD4E6B0B63");
    level._effect["_encstr_8EC1162B7B39AAED1013A17388E0356398FBA3DB33D0E3A5"] = loadfx("_encstr_B2D6283B9163DE3CD00127E26DEA472F0169D322D9BBA6B370A92FE64BD04E673643B9FA4095476D808B");
    switch_disabled();
  }

  level thread _id_11FF3();
  level thread delay_suspend_vehicle_convoy();
}

scriptable_postinit() {
  _id_135E7();
}

_id_11FF3() {
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(level._id_11F35.usable) {
    targetvehicle();
    level thread _id_14440();
    level thread _id_129F1();
  }
}

put_players_out_of_black_screen() {
  switch (level.mapname) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      return::_id_131FB;
    case "_encstr_A3F50BC8631F6D20CD64F7A155":
    case "_encstr_8CD508CA98A70FAFC01D":
      return::_id_131FC;
  }

  return undefined;
}

barrel_think(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4._id_1386F = var_3;
  var_5 = level._id_11F35._id_13C1A.size;
  var_4.id = level._id_11F35._id_13C1A.size;
  var_4.getaltbunkerkeypadindexforscriptable = var_2;
  level._id_11F35._id_13C1A[var_5] = var_4;
}

_id_131FB() {
  barrel_think((5518, 140, 0), (0, 130, 0), "_encstr_8CDC077B631EE3FF1A");
  barrel_think((6182, 296, 0), (0, 180, 0), "_encstr_A9DC071BB5EF4B4F33");
  barrel_think((5806, 830, 0), (0, 210, 0), undefined, 1);
}

_id_131FC() {
  barrel_think((11772, 28752, 1088), (0, 330, 0), undefined, 1);
  barrel_think((-9860, -36372, 244), (0, 0, 0), "_encstr_ACEF268323E07A20B951ED7588607EF14E235F07679061B5C2BEE3B8E6D8AEEAA8691FE3F3C91ACB");
  barrel_think((-15928, 32440, -236), (0, 350, 0), "_encstr_A559288EC9AF8D43BED8B7B5B5EDE6EB9BAC2CCDDBDCD79AA9AFBBF47DB23BB2738EF50BD2270EDB27E8");
  barrel_think((352, 53544, 984), (0, 195, 0), "_encstr_AAEE2EB88FC9E7285753808925EF90D7AAD29838425D674BD647947A3FEF5B7B55ABF140DA75433B5F729BE01A27A333");
  barrel_think((9212, 11036, -344), (0, 315, 0), "_encstr_8F6F2BE8E4BE1BD0EB8DBDB5B5DEDCAF6E5985B9F69BD7A6D47DEED3EB599D56DC1DAF8E9D7D9BA358A32DDB37");
  barrel_think((-22856, -408, -344), (0, 25, 0), "_encstr_A7DC3013B3108AD049C17DC538F0EE81DE93CFF7F720F1C5722E730896483E7A3819AF3B4F581A510893AF590B9060B28E6F");
  barrel_think((42708, 33764, -148), (0, 75, 0), "_encstr_B8792A71BF9FD65A792E67F5B8E08A7F9F7F3E3BED68F7258F4F5B82A6D28C8840A9C967D2057B9E9DD8287B");
  barrel_think((48704, -10908, 40), (0, 305, 0), "_encstr_95CC298E937DD80DD736B7D6B6DB37FA6EAC2C9BED73D7D453FAEE4FEBB2ECAC7347EB990B4EB58DB09B46");
  barrel_think((34752, -31764, -532), (0, 320, 0), "_encstr_99C625E89CEBB134EB6CF6B5B6DB737DDCCAC2DCDE37BE6AD4EBBBE9F52BECB2CDA3FA38BDE43A");
  barrel_think((-22416, -16012, -288), (0, 0, 0), "_encstr_99822ED40376178C2F9072AA18B7C52F2B85496BB0389F83D359FBD3A18BBB9F20F5EFE456618F9D5F20D37AE0CB357B");
}

_id_135E7() {
  var_0 = put_players_out_of_black_screen();

  if(isDefined(var_0))
    level thread[[var_0]]();

  foreach(var_2 in level._id_11F35._id_13C1A) {
    var_3 = var_2.origin;
    var_4 = var_2.angles;
    var_5 = _id_135E6(var_3, var_4);
    var_5.id = var_2.id;
    var_5.getaltbunkerkeypadindexforscriptable = var_2.getaltbunkerkeypadindexforscriptable;
    var_5._id_1386F = var_2._id_1386F;

    if(level._id_11F35.eliminate_drone)
      var_5 setscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1", "_encstr_A22A07C493EDB62BCD");
    else if(istrue(var_5._id_1386F))
      var_5 setscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1", "_encstr_8D2F0772683B3E416C");

    level._id_11F35._id_13C19[level._id_11F35._id_13C19.size] = var_5;
  }
}

_id_135E6(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_BE52216A4568B343EE08F67BD989322830D1FD60E8AEA06B51422A9AAA2D2BFFEB285F");
  return var_2 getlinkedscriptableinstance();
}

targetvehicle() {
  foreach(var_1 in level._id_11F35._id_13C19) {
    if(tu0bakechanges(var_1)) {
      _id_11A97(var_1);
      battle_station_combat_logic(var_1);
    }
  }
}

battle_station_combat_logic(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  var_2 = var_0.origin + rotatevector((-88, 60, 85), var_0.angles);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_2);
  getbnetigrbattlepassxpmultiplier(var_1, 4500, 5000);
  objective_setshowoncompass(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_icon(var_1, "_encstr_93DE29638BFF9238A640931F6B59F05A5390EB11E1238A75E8182FDFF8D1D1123BA0B6D2D853F2BBD1B89B");
  _func_421(var_1, 1);
}

_id_130F8(var_0) {
  if(!isDefined(var_0.objid)) {
    return;
  }
  objective_state(var_0.objid, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_0.objid, "_encstr_968E29D52D7D5BE0EB9839D7D616075BAC37EABEB1567659E632FA8939ED0B32C685378EEBDC5AD93785D8");
}

last_grenade_fire_time(var_0) {
  if(!isDefined(var_0.objid)) {
    return;
  }
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0.objid);
  var_0.objid = undefined;
}

_id_11A97(var_0) {
  var_0 setscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1", "_encstr_8E8607AB603B6E4341");
}

_id_11F32(var_0, var_1, var_2, var_3, var_4) {
  level thread _id_11FF7(var_0, var_3);
}

_id_11FF7(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = var_1.team;
  _id_12C3C(var_2, var_0, var_1);
  minigun_sweep_to_loc(var_0, var_1);
  _id_130F8(var_0);
  _id_129EF(var_0);
  level thread _id_12430(var_2, var_0);
}

minigun_sweep_to_loc(var_0, var_1) {
  var_2 = 50;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD") == "_encstr_A11804C81332")
    var_2 = getdvarint("_encstr_8F071C50FA526F991384D6DDA7D3E0F77F135858536C575327BAE64374BF", 25);

  var_1 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_2);
}

_id_129EF(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1", "_encstr_8A9C08535B23A3F9F869");

  while(var_0 getscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1") != "_encstr_8D2F0772683B3E416C")
    waitframe();
}

tu0bakechanges(var_0) {
  return var_0 getscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1") == "_encstr_921D09D9D9C0090D7275B4";
}

tugofwar_hvt_placed(var_0) {
  return var_0 getscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1") == "_encstr_8D2F0772683B3E416C";
}

tugofwar_hvt_taken_firsttime(var_0) {
  return var_0 getscriptablepartstate("_encstr_A97D14FD53CD400D8BABA19BD82773F369B0D0D48AA1") == "_encstr_8E8607AB603B6E4341";
}

dangercircletick(var_0, var_1) {
  if(!isDefined(level._id_11F35) || !istrue(level._id_11F35.usable)) {
    return;
  }
  var_2 = 25000000;

  foreach(var_4 in level._id_11F35._id_13C19) {
    if(!isDefined(var_4.objid)) {
      continue;
    }
    var_5 = 5000 + var_1;
    var_6 = distance2dsquared(var_4.origin, var_0);

    if(var_6 > var_5 * var_5)
      last_grenade_fire_time(var_4);
  }
}

_id_12430(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && !var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() && var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      level thread _id_1242F(var_4);
      waitframe();
    }
  }
}

_id_1242F(var_0) {
  playfxontagforclients(level._effect["_encstr_B634159825BFCDFB1EE657684F2B752269551F1EF04080"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
  level thread _id_12405(var_0);
}

_id_123CF(var_0) {
  playfxontagforclients(level._effect["_encstr_8EC1162B7B39AAED1013A17388E0356398FBA3DB33D0E3A5"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
  level thread _id_12405(var_0);
}

_id_123D1(var_0) {
  playfxontagforclients(level._effect["_encstr_8EC1162B7B39AAED1013A17388E0356398FBA3DB33D0E3A5"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
  _id_123D2(var_0);
}

_id_12405(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(_id_11F31(var_0)) {
    return;
  }
  level thread handlepersistentgungame(var_0);
  _id_137E1(var_0);
  _id_12406(var_0);
  _id_138BE(var_0);
  var_0 notify("_encstr_8E0C12107BF2E5B16ADFF1082F94C80739E798AD");
}

_id_137E1(var_0) {
  var_0._id_11F33 = 1;
  var_0 playLoopSound("_encstr_AD4612BAB0FE4DBDCFEAB36BFB08E37C0299C4F3");
  var_0 playlocalsound("_encstr_8FEE136A1087CB6855ED579ACA4F6BEBA04877AD72");
}

_id_138BE(var_0) {
  var_0 playlocalsound("_encstr_8FEE136A1087CB6855ED579ACA4F6BEBA04877AD72");
  wait 0.5;
  var_0 stoploopsound();
  var_0._id_11F33 = undefined;
}

_id_12406(var_0) {
  if(istrue(level._id_11F35.localangles)) {
    return;
  }
  if(istrue(level._id_11F35._id_1277B) && istrue(var_0._id_11F37)) {
    return;
  }
  var_0._id_11F37 = 1;
  wait 0.75;

  for(var_1 = 0; var_1 < level._id_11F35.checked_missiles.size; var_1++) {
    var_0 playlocalsound(level._id_11F35.checked_missiles[var_1]);
    wait 2.5;
  }
}

handlepersistentgungame(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8E0C12107BF2E5B16ADFF1082F94C80739E798AD");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 stoploopsound();
  var_0._id_11F33 = undefined;
}

_id_123D2(var_0) {
  if(_id_11F31(var_0)) {
    return;
  }
  var_1 = gettime();

  if(isDefined(var_0._id_11E7A) && var_0._id_11E7A > var_1) {
    return;
  }
  var_0 playlocalsound("_encstr_8FEE136A1087CB6855ED579ACA4F6BEBA04877AD72");
  var_0._id_11E7A = var_1 + 5000;
}

_id_11F31(var_0) {
  return istrue(var_0._id_11F33);
}

switch_disabled() {
  level._id_11F35.checked_missiles = [];
  bankplunderextractinstantly("_encstr_A12919D87B29C54BBF4FAE254B4FF0A30D425810A371DB0B9FC917");
  bankplunderextractinstantly("_encstr_AD4619BCE0FE553ECFD79F0BFA0840F5A070CDFB4F17E666D99BD2");
  bankplunderextractinstantly("_encstr_910D18F948F9381E97E97B833287D8488DAA734DEB51BAF08E37");
  bankplunderextractinstantly("_encstr_A5071832E1F5984ED6BE9B8E6CD7CDBA6B132B39DCEB07BE4C06");
  bankplunderextractinstantly("_encstr_883B19915AB969B343DF303CEFC918837862CD8BB72969BA3E1BE1");
  bankplunderextractinstantly("_encstr_A5401982CA684352B867939C37019DC7A9616A6B33C04A1A51A3E8");
  bankplunderextractinstantly("_encstr_8FEB186C4087FB5055970F9CCE4FBAFB8028F7BA32CF1267A212");
  bankplunderextractinstantly("_encstr_955E19723A98B3A228F7232CA791ED5739D1FA9BA3703608E15378");
  bankplunderextractinstantly("_encstr_955E19723A98B3A228F7232CA791ED5739D1FA9BA3703608E15378");
  bankplunderextractinstantly("_encstr_97FD18C83CEB26E4ADEBB9A36CF5375DAD895939DC7DE6BE9803");
  bankplunderextractinstantly("_encstr_8211195A6311150B4D0938CC19B950433D32129AA8F7AB11D8BF37");
  bankplunderextractinstantly("_encstr_883B19915AB969B343DF303CEFC918837862CD8BB72969BA3E1BE1");
  bankplunderextractinstantly("_encstr_8AD318A7A036FE407998EF40BE37B04B0A9AE54BF3163DE8CB3F");
  bankplunderextractinstantly("_encstr_BD0B1981309150068FC143AB2A6F3050B5821B25C349026E1F5F33");
  bankplunderextractinstantly("_encstr_93DD184687F53139DAEBDCD1C6BE37D5D64C2B93DCFA99EB26C0");
  bankplunderextractinstantly("_encstr_8EC518036120AAFAE896AA7309A13E1381ED8FC31F48D79F2293");
}

bankplunderextractinstantly(var_0) {
  level._id_11F35.checked_missiles[level._id_11F35.checked_missiles.size] = var_0;
}

_id_129F1() {
  for(;;) {
    foreach(var_1 in level._id_11F35._id_13C19) {
      if(istrue(var_1._id_1386F) || !tugofwar_hvt_placed(var_1)) {
        continue;
      }
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_1.origin, 5000);

      foreach(var_4 in var_2) {
        if(!isDefined(var_4) || var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || !var_4 scripts\cp_mp\utility\player_utility::_isalive() || _id_124F9(var_4, var_1)) {
          continue;
        }
        _id_12C3B(var_4, var_1);
        _id_123CF(var_4);
        _id_12AA0("_encstr_B652260F185582491D70A5F5FC10928A77B29D638612CB6F5EFBDFE7537AB916D52D4E7CC6515301", var_4, var_1);
        waitframe();
      }

      waitframe();
    }

    waitframe();
  }
}

_id_14440() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level._id_11F35._id_13C19) {
      if(tugofwar_hvt_placed(var_2))
        var_0++;
    }

    if(var_0 > 0 && var_0 >= level._id_11F35._id_13C19.size) {
      break;
    }

    waitframe();
  }

  _id_12A9E("_encstr_A306279B731854D12B3BAD606C992663F1AB87916A350BAAB61B30EFB90541888381F9A39191EBB799");
  level thread _id_123D0();
}

_id_123D0() {
  for(;;) {
    var_0 = gettime();

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2)) {
        continue;
      }
      if(isDefined(var_2._id_11E7B) && var_2._id_11E7B > var_0) {
        continue;
      }
      if(isDefined(var_2._id_125E4)) {
        if(!isDefined(var_2._id_11E7B)) {
          level thread _id_12405(var_2);
          _id_12A9F("_encstr_A92020A033EF91C722F3D5684BB9857B77A3A09063BD8B57699BD8EC6703B701B17F", var_2);
        }

        _id_123D1(var_2);
        var_2._id_11E7B = var_0 + 2500;
        waitframe();
      }
    }

    wait 0.1;
  }
}

delay_suspend_vehicle_convoy() {
  wait 5.0;
  scripts\mp\utility\sound::besttime("_encstr_819115F1229FE8FC9A6B315F53A349187DBA5BAE8A0EB8");
}

_id_12C3C(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\utility\teams::getfriendlyplayers(var_0)) {
    if(isDefined(var_2) && var_2 == var_4)
      _id_12AA0("_encstr_B686218CB17B9DEB95EC957347BE134EF573D5B53195E4E6F5E8BDDD599CEBAB6E5619", var_4, var_1);
    else
      _id_12AA0("_encstr_8D1626987A650F2E5FA665E89C8FB1EDC1C29828723F9DE3DFCC785C65D3DEB9379AC031BBD2FBD9", var_4, var_1);

    _id_12C3B(var_4, var_1);
  }
}

_id_12C3B(var_0, var_1) {
  if(_id_124F9(var_0, var_1)) {
    return;
  }
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_120A9(var_1.getaltbunkerkeypadindexforscriptable);
  var_0 _id_130AB(var_0, var_1);
}

_id_130AB(var_0, var_1) {
  if(!isDefined(var_1.id)) {
    return;
  }
  if(!isDefined(var_0._id_11F36))
    var_0._id_11F36 = [];

  var_0._id_11F36[var_1.id] = 1;
}

_id_124F9(var_0, var_1) {
  return isDefined(var_1.id) && isDefined(var_0._id_11F36) && istrue(var_0._id_11F36[var_1.id]);
}

maxaccesscardspawns_red() {
  var_0 = level.audio_start_obj_room_fires;

  for(var_1 = 3; var_0.size > 0 && var_1 > 0; var_0 = scripts\engine\utility::array_remove_index(var_0, var_2)) {
    var_1--;
    var_2 = randomint(var_0.size);
    var_0[var_2] _encstr_A26E269A30E680C83B2356CB50AFCA42EA030B6950FBBE18C1361F3F9358D371C1AD98734A627BD1::_id_13289();
  }
}

propheight() {
  var_0 = [];
  var_1 = level._id_11F35._id_13C19;

  foreach(var_3 in level._id_11F35._id_13C19) {
    if(tugofwar_hvt_taken_firsttime(var_3) && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_3.origin))
      var_0[var_0.size] = var_3;
  }

  if(var_0.size <= 0)
    return undefined;

  return var_0[randomint(var_0.size)];
}

_id_12A1B(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace_get_all_results(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4["_encstr_850E077B0BF30318B9"]))
      return var_4;
  }

  return var_2[var_2.size - 1];
}

_id_12A1A(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace_get_all_results(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_5) && isalive(var_5) && isDefined(var_5.vehiclename))
      return var_4;
  }

  return undefined;
}

_id_12AA0(var_0, var_1, var_2) {
  var_3 = juggernaut_getavoidanceposition();
  var_3 = autostartcircle(var_3, "_encstr_B10B088B2077CAD28888", var_2.id);
  var_3 = autostructnum(var_3, var_1.origin);
  var_1 dlog_recordplayerevent(var_0, var_3);
}

_id_12A9F(var_0, var_1) {
  var_2 = juggernaut_getavoidanceposition();
  var_2 = autostructnum(var_2, var_1.origin);
  var_1 dlog_recordplayerevent(var_0, var_2);
}

_id_12A9E(var_0) {
  var_1 = juggernaut_getavoidanceposition();
  getentitylessscriptablearray(var_0, var_1);
}

juggernaut_getavoidanceposition() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1";
  var_0[var_0.size] = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  return var_0;
}

autostartcircle(var_0, var_1, var_2) {
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = var_2;
  return var_0;
}

autostructnum(var_0, var_1) {
  var_0 = autostartcircle(var_0, "_encstr_A33506D8AA82DF6A", var_1[0]);
  var_0 = autostartcircle(var_0, "_encstr_9335067B90C6FFD8", var_1[1]);
  var_0 = autostartcircle(var_0, "_encstr_9135061CED9BAF9E", var_1[2]);
  return var_0;
}