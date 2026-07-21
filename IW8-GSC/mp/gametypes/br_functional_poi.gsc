/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_functional_poi.gsc
***********************************************/

init() {
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::init();
  _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::init();
  _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::init();
  _findgivearmoramountanddropleftovers::init();
  _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::init();
  scripts\mp\flags::gameflaginit("_encstr_8B250DD70DA97848DB333BEFB3422D", 0);
  level thread _spawnpois();
}

initplayer() {
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::initplayer();
}

onprematchdone() {
  scripts\mp\flags::gameflagwait("_encstr_8B250DD70DA97848DB333BEFB3422D");
  _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::onprematchdone();
  _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::onprematchdone();
  _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::onprematchdone();
}

getinteractiveoutlineasset() {
  return "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
}

_spawnpois() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0.05;
  var_1 = 5;
  var_2 = 5;
  var_3 = 7;
  var_4 = 7;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
    level.binoculars_checkexpirationtimer = getdvarint("_encstr_B1251F0EDB7356059D3A29F083B7258B6F449B8624AB584DC3F380981AC1D161FB", 35);
    level._id_12946 = getdvarint("_encstr_955A2403590E47A628970F3D8D40ED5320113A8B43E6579EB0D9210FA569B24FD5EE23130BB3", 1);
    level.fly_over_path = getdvarint("_encstr_AC0C243F1BCB17793B3FA1E9D833235DFE3BE4D7F0F96FD3CB29A5EBF2C0EB8478C09F22570D", 0);
    level thread _id_1325B();
  }

  level._id_11C41 = getdvarint("_encstr_AF2A1B7B357F689183A6C17385B8FB4766D103EA8D065312E9E047D8CB", var_4);
  level._id_11B6D = getdvarint("_encstr_AA251BE27B5F90AB22AF3064ABF8B5F322DF48B9D973EA9E9BDC923096", var_3);

  if(level._id_11C41 < level._id_11B6D)
    level._id_11B6D = randomintrange(level._id_11C41, level._id_11B6D + 1);

  var_5 = getdvarint("_encstr_88AF14F02BBF701B53197786ED5A45BAD7D720208753", 65);
  var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::registeraccesscardlocs();

  if(isDefined(var_6) && var_6.size > 0) {
    var_6 = play_lz_vo(var_6);
    var_6 = ai_semtex_swapp(var_6, var_5, level.fly_over_path);

    if(isDefined(var_6) && var_6.size > 0)
      _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_id_131C0(var_6);
  }

  var_7 = getdvarint("_encstr_884A15319CBEDA850F7D58E46BF6C9F27D3A2716C89593", 65);
  var_8 = _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::registeraccesscardlocs();

  if(isDefined(var_8) && var_8.size > 0) {
    var_8 = play_music_to_team(var_8);
    var_8 = ai_semtex_swapp(var_8, var_7, level.fly_over_path);

    if(isDefined(var_8) && var_8.size > 0)
      _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::_id_131C0(var_8);
  }

  var_9 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::register_vfx();

  if(isDefined(var_9) && var_9.size > 0) {
    var_9 = ai_semtex_swapp(var_9, level._id_11B6D, 1);

    if(isDefined(var_9) && var_9.size > 0)
      _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1314B(var_9);
  }

  var_10 = scripts\engine\utility::getStructArray("_encstr_9BE7137AC8E7CAC7237F214F18CED713C3507222B0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_11 = 0; var_11 < var_10.size; var_11++) {
    wait(var_0);
    _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::spawnambulance(var_10[var_11]);
  }

  scripts\mp\flags::gameflagset("_encstr_8B250DD70DA97848DB333BEFB3422D");
}

ai_semtex_swapp(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0)
    return undefined;

  if(var_1 > var_0.size)
    var_1 = var_0.size;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    return _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::ai_shooting_timer(var_0, var_1, var_2);
  else if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15")
    return _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::ai_shooting_timer(var_0, var_1, var_2);
  else if(!isDefined(level.br_circle) || !isDefined(level.br_level))
    return ai_shooting_watch(var_0, var_1);

  var_3 = level.br_level.default_class_chosen.size - 1;
  var_4 = int(max(1, var_3 * getdvarfloat("_encstr_ABA90DCE6EE75B0F4891CBC7C8E3FD", 1.0)));

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_7 = randomintrange(-1 * var_4, var_4 + 1);
    var_6.score = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_reset_deathshield_on_revived(var_6.origin) + var_7;
  }

  var_8 = scripts\engine\utility::array_sort_with_func(var_0, ::hidequestcircletoall);
  var_9 = [];

  for(var_5 = 0; var_5 < var_1; var_5++)
    var_9[var_5] = var_8[var_5];

  return scripts\engine\utility::array_slice(var_8, 0, var_1);
}

hidequestcircletoall(var_0, var_1) {
  return var_0.score > var_1.score;
}

ai_shooting_watch(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_2 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = int(min(var_1, var_0.size));

    for(var_4 = 0; var_4 < var_3; var_4++)
      var_2[var_2.size] = var_0[var_4];
  }

  return var_2;
}

showmiscmessagetoteam(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_4 = "_encstr_8FAA0DCD482F74D016A34A0A07B6DE";
    var_5 = 1;
    var_6 = 0;
    var_7 = -1;
    var_8 = tablelookuprownum(var_4, var_5, var_1);

    if(isDefined(var_8) && var_8 >= 0)
      var_7 = int(tablelookupbyrow(var_4, var_8, var_6));

    if(var_7 < 0) {
      return;
    }
    var_9 = undefined;

    if(isDefined(var_3))
      var_9 = gettime() + var_3;

    var_12 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

    foreach(var_14 in var_12)
    var_14 scripts\mp\utility\lower_message::setlowermessageomnvar(var_7, var_9, var_2);
  }
}

initstatemachineforpoitype(var_0) {
  if(!isDefined(level.poistates))
    level.poistates = [];

  level.poistates[var_0] = [];
}

registerstatecallbacksforpoitype(var_0, var_1, var_2, var_3, var_4) {
  level.poistates[var_0][var_1] = spawnStruct();
  level.poistates[var_0][var_1].onenter = var_2;
  level.poistates[var_0][var_1].onupdate = var_3;
  level.poistates[var_0][var_1].onexit = var_4;
}

gotopoistate(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.currentstate)) {
    var_3 = level.poistates[var_0][var_2.currentstate];

    if(isDefined(var_3) && isDefined(var_3.onexit))
      level[[var_3.onexit]](var_2);
  }

  var_2 notify("_encstr_BD78119790C337963B7E797129C84809756781");
  var_2.currentstate = var_1;
  var_3 = level.poistates[var_0][var_2.currentstate];

  if(isDefined(var_3)) {
    if(isDefined(var_3.onenter))
      level[[var_3.onenter]](var_2);

    if(isDefined(var_3.onupdate))
      var_2 thread _poistateupdate(var_3.onupdate);
  }
}

gotopoistateontimer(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_BD78119790C337963B7E797129C84809756781");
  wait(var_2);
  var_3 thread gotopoistate(var_0, var_1);
}

getcurrentpoistate() {
  var_0 = self;
  return var_0.currentstate;
}

_poistateupdate(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = var_1.currentstate;

  while(var_2 == var_1.currentstate) {
    level[[var_0]](var_1);
    waitframe();
  }
}

_id_1325B() {
  if(!isDefined(level.mapcorners))
    waitframe();

  var_0 = level.mapcorners[0].origin[0];
  var_1 = level.mapcorners[1].origin[0];
  var_2 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  var_3 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);

  if(var_1 < var_0) {
    var_2 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);
    var_3 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  }

  var_4 = level.mapcorners[0].origin[1];
  var_5 = level.mapcorners[1].origin[1];
  var_6 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  var_7 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);

  if(var_5 < var_4) {
    var_6 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);
    var_7 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  }

  var_8 = [];

  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    level.ignorevehicleexplosivedamage = abs(distance(var_7, var_2));
    var_9 = level.ignorevehicleexplosivedamage / 10;
    var_2 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
    var_3 = (var_3[0] - var_9, var_3[1] - var_9, var_3[2]);
    var_6 = (var_6[0] - var_9, var_6[1] + var_9, var_6[2]);
    var_7 = (var_7[0] + var_9, var_7[1] + var_9, var_7[2]);
    level.ignorevehicleexplosivedamage = abs(distance(var_7, var_2));

    for(var_10 = 1; var_10 < 4; var_10 = var_10 + 2) {
      var_11 = var_10 * level.ignorevehicleexplosivedamage / 2;

      for(var_12 = 1; var_12 < 4; var_12 = var_12 + 2) {
        var_13 = var_12 * level.ignorevehicleexplosivedamage / 2;
        var_14 = (var_7[0] + var_11 / 2, var_7[1] + var_13 / 2, 0);
        var_8[var_8.size] = var_14;
      }
    }
  }

  level._id_12950 = [];

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    level._id_12950[level._id_12950.size] = (3965, 4054, 0);
    level._id_12950[level._id_12950.size] = (4069, -4150, 0);
    level._id_12950[level._id_12950.size] = (-4035, -4074, 0);
    level._id_12950[level._id_12950.size] = (-4009, 4105, 0);
  } else if(level.mapname == "_encstr_BAC50C3DA2912902F125EDCA575E") {
    level._id_12950[level._id_12950.size] = (46569.5, -8170, 0);
    level._id_12950[level._id_12950.size] = (56849.5, -8170, 0);
    level._id_12950[level._id_12950.size] = (67081.5, -17919.5, 0);
    level._id_12950[level._id_12950.size] = (46593, -17919.5, 0);
  } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    level._id_12950[level._id_12950.size] = (-21299.2, 41779.2, 0);
    level._id_12950[level._id_12950.size] = (37683.2, 41779.2, 0);
    level._id_12950[level._id_12950.size] = (37683.2, -17203.2, 0);
    level._id_12950[level._id_12950.size] = (-21299.2, -17203.2, 0);
  } else {
    var_15 = 0.8;
    var_16 = 0.5;
    var_17 = var_15 * var_16;
    level._id_12950[level._id_12950.size] = (var_0 * var_17, var_5 * var_17, 0);
    level._id_12950[level._id_12950.size] = (var_1 * var_17, var_5 * var_17, 0);
    level._id_12950[level._id_12950.size] = (var_1 * var_17, var_4 * var_17, 0);
    level._id_12950[level._id_12950.size] = (var_0 * var_17, var_4 * var_17, 0);
  }

  level._id_12950 = scripts\engine\utility::array_randomize(level._id_12950);

  if(level.binoculars_checkexpirationtimer > 0 && scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var_18 = randomintrange(0, 5);
    var_9 = level.ignorevehicleexplosivedamage / 10;
    var_19 = level.ignorevehicleexplosivedamage / (100 / level.binoculars_checkexpirationtimer);

    switch (var_18) {
      case 0:
        var_20 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
        var_21 = (var_3[0] - var_19, var_3[1] - var_9, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_19, var_6[2]);
        var_23 = (var_7[0] + var_9, var_7[1] + var_19, var_7[2]);
        break;
      case 1:
        var_20 = (var_2[0] + var_19, var_2[1] - var_9, var_2[2]);
        var_21 = (var_3[0] - var_9, var_3[1] - var_9, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_9, var_6[2]);
        var_23 = (var_7[0] + var_19, var_7[1] + var_19, var_7[2]);
        break;
      case 2:
        var_20 = (var_2[0] + var_19, var_2[1] - var_19, var_2[2]);
        var_21 = (var_3[0] - var_9, var_3[1] - var_19, var_3[2]);
        var_22 = (var_6[0] - var_9, var_6[1] + var_9, var_6[2]);
        var_23 = (var_7[0] + var_19, var_7[1] + var_9, var_7[2]);
        break;
      case 3:
        var_20 = (var_2[0] + var_9, var_2[1] - var_19, var_2[2]);
        var_21 = (var_3[0] - var_19, var_3[1] - var_19, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_9, var_6[2]);
        var_23 = (var_7[0] + var_9, var_7[1] + var_9, var_7[2]);
        break;
      case 4:
        var_20 = (var_2[0] + var_19, var_2[1] - var_19, var_2[2]);
        var_21 = (var_3[0] - var_19, var_3[1] - var_19, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_19, var_6[2]);
        var_23 = (var_7[0] + var_19, var_7[1] + var_19, var_7[2]);
        break;
      default:
        var_20 = (var_2[0] + var_19, var_2[1] - var_19, var_2[2]);
        var_21 = (var_3[0] - var_19, var_3[1] - var_19, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_19, var_6[2]);
        var_23 = (var_7[0] + var_19, var_7[1] + var_19, var_7[2]);
        break;
    }

    var_24 = [];
    level._id_121BB = [];
    level._id_121BA = abs(distance(var_23, var_20));
    level._id_127DE = level._id_121BA / 2;

    for(var_10 = 1; var_10 < 4; var_10 = var_10 + 2) {
      var_11 = var_10 * level._id_121BA / 2;

      for(var_12 = 1; var_12 < 4; var_12 = var_12 + 2) {
        var_13 = var_12 * level._id_121BA / 2;
        var_14 = (var_23[0] + var_11 / 2, var_23[1] + var_13 / 2, 0);
        var_24[var_24.size] = var_14;
      }
    }

    if(level._id_12946 == 2)
      level._id_121BB = scripts\engine\utility::array_randomize(var_24);
    else {
      switch (var_18) {
        case 0:
          if(level._id_12946) {
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[0];
          } else {
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[0];
          }

          break;
        case 1:
          if(level._id_12946) {
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[1];
          } else {
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[1];
          }

          break;
        case 2:
          if(level._id_12946) {
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[3];
          } else {
            level._id_121BB[level._id_121BB.size] = var_24[2];
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[3];
          }

          break;
        case 3:
          if(level._id_12946) {
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[2];
          } else {
            level._id_121BB[level._id_121BB.size] = var_24[0];
            level._id_121BB[level._id_121BB.size] = var_24[1];
            level._id_121BB[level._id_121BB.size] = var_24[3];
            level._id_121BB[level._id_121BB.size] = var_24[2];
          }

          break;
        case 4:
          level._id_121BB = scripts\engine\utility::array_randomize(var_24);
          break;
        default:
          level._id_121BB = scripts\engine\utility::array_randomize(var_24);
          break;
      }
    }
  }
}

play_lz_vo(var_0) {
  if(getdvarint("_encstr_B69D1873C790D18336FEAAB2C08EEF9978BB0BFC7DE02607DD51", 1) == 0 || !scripts\cp_mp\utility\game_utility::unsetchainkillstreaks())
    return var_0;

  var_1 = getdvarfloat("_encstr_A51D206FF26E7F7ABAF70703A5D2F4FFC921C8BC9863E98BA4B84EAAA43566132F65", 1.0);
  var_2 = getdvarfloat("_encstr_9779217B2A2249BAB2575828D87B8F60337AE8DB33D8A5DB65913F259010A9CA73D78B", 7000);
  var_3 = var_2 * var_2;
  var_4 = [];
  var_5 = [];
  var_5[0] = battle_tracks_onexitvehicle((40925, -7519, 0), 49000000);
  var_5[1] = battle_tracks_onexitvehicle((-40840, -4814, 0), 36000000);
  var_5[2] = battle_tracks_onexitvehicle((42787, 8460, 0), 81000000);
  var_5[3] = battle_tracks_onexitvehicle((-7848, -42422, 0), 121000000);

  foreach(var_7 in var_0) {
    var_8 = 0;

    foreach(var_10 in level.calloutglobals.calloutzones) {
      if(ispointinvolume(var_7.origin, var_10)) {
        if(!isDefined(var_10.wait_for_computer_power))
          var_10.wait_for_computer_power = [];

        var_8 = 1;
        var_10.wait_for_computer_power[var_10.wait_for_computer_power.size] = var_7;
        break;
      }
    }

    if(!var_8) {
      foreach(var_10 in var_5) {
        var_13 = distance2dsquared(var_10.origin, var_7.origin);

        if(var_13 < var_10._id_129E5) {
          var_8 = 1;
          var_10.wait_for_computer_power[var_10.wait_for_computer_power.size] = var_7;
          break;
        }
      }
    }

    if(!var_8)
      var_4[var_4.size] = var_7;
  }

  var_16 = scripts\engine\utility::array_combine(level.calloutglobals.calloutzones, var_5);

  foreach(var_10 in var_16) {
    if(var_10.wait_for_computer_power.size == 0) {
      var_10.wait_for_computer_power = undefined;
      continue;
    }

    var_18 = scripts\engine\utility::array_randomize(var_10.wait_for_computer_power);
    var_4[var_4.size] = var_18[0];
    var_19 = [];
    var_19[0] = var_18[0];
    var_20 = int(ceil(var_18.size / var_1));
    var_21 = 1;

    for(var_22 = 1; var_22 < var_18.size && var_21 < var_20; var_22++) {
      var_23 = var_18[var_22];
      var_24 = 1;

      foreach(var_26 in var_19) {
        var_13 = distance2dsquared(var_23.origin, var_26.origin);

        if(var_13 < var_3) {
          var_24 = 0;
          break;
        }
      }

      if(var_24) {
        var_4[var_4.size] = var_23;
        var_19[var_19.size] = var_23;
        var_21++;
      }
    }

    var_10.wait_for_computer_power = undefined;
  }

  return var_4;
}

play_music_to_team(var_0) {
  if(getdvarint("_encstr_998019D32ED3E70E7571C35B78A1079BAE05416B3DBB475653A3DA", 1) == 0 || !scripts\cp_mp\utility\game_utility::turretdisabled())
    return var_0;

  var_1 = getdvarfloat("_encstr_8AFB214663CBEECD92E1B8B03A2F8B03270CC33EEC639015BBBB38D19204A57E73B5D6", 1.0);
  var_2 = getdvarfloat("_encstr_ACBE22F3CE3307EE9591237B588167FBCE25618BDD9B673673203AA150F39D97411BE304", 7000);
  var_3 = var_2 * var_2;
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = 0;

    foreach(var_9 in level.calloutglobals.calloutzones) {
      if(ispointinvolume(var_6.origin, var_9)) {
        if(!isDefined(var_9._id_13C6A))
          var_9._id_13C6A = [];

        var_7 = 1;
        var_9._id_13C6A[var_9._id_13C6A.size] = var_6;
        break;
      }
    }

    if(!var_7)
      var_4[var_4.size] = var_6;
  }

  foreach(var_9 in level.calloutglobals.calloutzones) {
    if(!isDefined(var_9._id_13C6A) || var_9._id_13C6A.size == 0) {
      var_9._id_13C6A = undefined;
      continue;
    }

    var_13 = scripts\engine\utility::array_randomize(var_9._id_13C6A);
    var_4[var_4.size] = var_13[0];
    var_14 = [];
    var_14[0] = var_13[0];
    var_15 = int(ceil(var_13.size / var_1));
    var_16 = 1;

    for(var_17 = 1; var_17 < var_13.size && var_16 < var_15; var_17++) {
      var_18 = var_13[var_17];
      var_19 = 1;

      foreach(var_21 in var_14) {
        var_22 = distance2dsquared(var_18.origin, var_21.origin);

        if(var_22 < var_3) {
          var_19 = 0;
          break;
        }
      }

      if(var_19) {
        var_4[var_4.size] = var_18;
        var_14[var_14.size] = var_18;
        var_16++;
      }
    }

    var_9._id_13C6A = undefined;
  }

  return var_4;
}

battle_tracks_onexitvehicle(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_129E5 = var_1;
  var_2.wait_for_computer_power = [];
  return var_2;
}

player_give_intel_1_ks(var_0) {
  var_1 = incrementpersistentstat(level.players, self.origin, var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }
    if(var_3 getstance() != "_encstr_922406F1A6FD5E05") {
      continue;
    }
    var_4 = var_3 getboundshalfsize();
    var_0 = var_4[0];
    var_5 = 2.0 * var_4[2];

    if(capsuletracepassed(var_3.origin, var_0, var_5, undefined, 0, 0)) {
      continue;
    }
    var_3 setstance("_encstr_B13D076BED70539F23", 1);
  }
}