/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58260.gsc
***********************************************/

init() {
  level.setplayervargulagjail = [];
  level.setplunderifunchanged = [];
  level.setplayervargulagjail[0] = 20;
  level.setplunderifunchanged[0] = 30;
  level.setplayervargulagjail[1] = 50;
  level.setplayervargulagjail[2] = 80;
  level.setplayervargulagjail[3] = 120;
  level.setplayervargulagjail[4] = 160;
  level.setplunderifunchanged[1] = 180;
  level.setplayervargulagjail[5] = 220;
  level.setplayervargulagjail[6] = 280;
  level.setplayervargulagjail[7] = 340;
  level.setplunderifunchanged[2] = 370;
  level.setplayervargulagjail[8] = 400;
  level.setplunderifunchanged[3] = 450;
  level.setplayervargulagjail[9] = 460;
  level.setplunderifunchanged[4] = 510;
  level.setplunderifunchanged[5] = 520;
  level.setplayervargulagjail[10] = 530;
  level.setplunderifunchanged[6] = 590;
  level.setplayervargulagjail[11] = 650;
  level.setplayervargulagjail[12] = 710;
  level.setplunderifunchanged[7] = 750;
  level.setplayervargulagjail[13] = 780;
  level.setplunderifunchanged[8] = 830;
  level.setplunderifunchanged[9] = 840;
  level.setplayervargulagjail[14] = 850;
  level._effect["_encstr_8F6C0BC685DC23F26AB585B1B1"] = loadfx("_encstr_A61F315BB08AA71A7F8B493E96E7B2B170C03BBB10026FD287CDCF35500D9A60DE30CF2F103E9B0A9D55D06166D3F24E43880B");
  level._effect["_encstr_852209F2C81DA75FFD1BCF"] = loadfx("_encstr_8420313B330FCBD2DD83D7264ECBD90BD65607B116F2971A77562BCDE59D99C3F536DEDED1D7C685B9915EF51B93B371CECCF0");
  level._effect["_encstr_8D201573D92B670558F744678740CDF3D3968BBB808247"] = loadfx("_encstr_B18C33DC8E0B08232B7FF91833D5E719F7356759E177406913B2D060DEDBAD72E7D460406C4731433D8A38E143F24B8A670E744CC8");
}

_id_12120(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = getdvarint("_encstr_868D1AB8AF52F6C9021531482BBA2B189737A0E81B018EBD2A3DB545", 10);
  var_5 = getdvarint("_encstr_929023AB09261FF3984C8D37A82529488847B6FAC9502746F0B34D6FFF56294BDAFE58AAF9", 0);
  var_6 = var_0 == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D";

  if(var_6)
    var_4 = var_4 * 2;

  if(var_5 > 0)
    var_4 = var_4 + randomintrange(var_5 * -1, var_5);

  if(getdvarint("_encstr_8AD31E626693B1907F019398B443357D29DB64EBDF51B5F5A39B01CF8086E38F", 0) == 1) {
    if(var_6)
      level thread _id_12458(var_1, 1);
    else
      level thread _id_12458(var_1, 0);
  }

  if(_calloutmarkerping_handleluinotify_enemyrepinged::_id_124F5()) {
    var_7 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16);

    if(!var_7) {
      level thread _id_12776(var_1);
      var_8 = forceexplosivedeath();
      self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_B65B1343C23636B7EECA59CDD71D4E2BC2D1EB8953");
      self dlog_recordplayerevent("_encstr_9B891B8C1BDBCEF5599DAC73D1F5862C8D1BB7BB2BAC37BE8EC9592CA3", ["_encstr_A7270A27CAEEB04E46EB96C8", 15]);
      self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16, 1);
      _id_13E12();
    }

    return;
  }

  var_9 = -1;

  if(isDefined(var_3))
    var_9 = var_3;
  else if(isDefined(var_2)) {
    switch (var_2) {
      case "_encstr_B4840D0763993ADCA8D3C816A9E015":
      case "_encstr_967B0985969CCC2D561B19":
        var_9 = 0;
        break;
      case "_encstr_9B8A0AA48A02FDA1718768D0":
      case "_encstr_8B410851CDC7EDE732ED":
      case "_encstr_A7FA0953BADCAD2F2C4E19":
      case "_encstr_A12309057F2275CBB14A51":
        var_9 = 1;
        break;
      case "_encstr_971804ED3712":
        var_9 = 2;
        break;
      case "_encstr_883009BD28232B4B688B98":
        var_9 = 3;
        break;
      case "_encstr_85540C476130A3E140D973BDB320":
        var_9 = 4;
        break;
      case "_encstr_883E0978CAE2A1689B3161":
        var_9 = 5;
        break;
      case "_encstr_9BD70814BBB0A55B35C3":
        var_9 = 6;
        break;
      case "_encstr_B49507136BBF0EA070":
        var_9 = 7;
        break;
      case "_encstr_810D059BE07D8B":
        var_9 = 8;
        break;
      case "_encstr_A77808BB284B9F27D3C1":
        var_9 = 9;
        break;
      case "_encstr_9B220634456A5747":
        var_9 = 10;
        break;
      case "_encstr_837905862370BD":
      case "_encstr_8E4107C6EA5B135939":
      case "_encstr_BAC106FFE6F8C842":
        var_9 = 11;
        break;
      case "_encstr_834E0AFD036B7C39A427F282":
        var_9 = 12;
        break;
      case "_encstr_BEB406F03B72BB3B":
        var_9 = 13;
        break;
      case "_encstr_950214E6D0F6E0832D73B37D23D2B9E8E42D6CA3D7AC":
      case "_encstr_99021473044FA01FBA8BF7FFDBC2E6C80ADCF92B61BF":
      case "_encstr_AAAB06A89862980B":
        var_9 = 14;
        break;
      default:
        break;
    }
  }

  if(var_9 == -1) {
    return;
  }
  var_10 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_9);

  if(var_10) {
    _id_13E19();

    if(!istrue(self.setplayersquadindex)) {
      self.setplayersquadindex = 1;
      _id_13E12();
    }

    return;
  }

  var_11 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_BDAE1B86C2C6637BDD59AC73A84E2D36D6F4935127CA2CE8D0589B9197");
  var_8 = forceexplosivedeath();
  var_12 = regulateturretrateoffire(var_8, var_11, var_4);
  _id_128B2(var_9, var_12, var_1, var_6);
}

_id_13E19() {
  var_0 = randomfloat(1.0);

  if(var_0 < getdvarfloat("_encstr_8DC62467E3E28143F7AAE8B023DF8D40F17EDB25810A801D0B71E31BAAAFB21116D853AD3377", 0)) {
    var_1 = randomint(11);
    self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", var_1);
    return 1;
  }

  return 0;
}

_id_128B2(var_0, var_1, var_2, var_3) {
  if(var_1 == 0)
    level thread _id_12458(var_2, var_3);

  if(var_1 < 0) {
    if(getdvarint("_encstr_A6D61F9BB19C7D0D0BB18D7BDD5956E6EBD1394B6CD6F5DA5AD86337EE5AD1D8A1", 0) == 0)
      _id_12D34(var_1);
  } else if(var_1 > 0) {
    self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", 99);
    level thread _id_12776(var_2);
    thread _id_12D33(var_1, var_0);
  }
}

isskydivestatedisabled() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1);
    var_0 = var_1;

    if(!var_2) {
      break;
    }
  }

  var_3 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_BDAE1B86C2C6637BDD59AC73A84E2D36D6F4935127CA2CE8D0589B9197");
  var_4 = getdvarint("_encstr_868D1AB8AF52F6C9021531482BBA2B189737A0E81B018EBD2A3DB545", 10);
  var_5 = forceexplosivedeath();
  var_6 = regulateturretrateoffire(var_5, var_3, var_4);
  _id_128B2(var_0, var_6);
}

isstandardsandbox(var_0) {
  issmallsplashdamage();

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = 0;

    for(var_1 = 0; var_1 < 15; var_1++) {
      var_3 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1);
      var_2 = var_1;

      if(!var_3) {
        break;
      }
    }

    _id_12120("_encstr_B40101", undefined, "_encstr_B40101", var_2);
  }
}

issmallsplashdamage() {
  var_0 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16);

  if(!var_0) {
    self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_B65B1343C23636B7EECA59CDD71D4E2BC2D1EB8953");
    self dlog_recordplayerevent("_encstr_9B891B8C1BDBCEF5599DAC73D1F5862C8D1BB7BB2BAC37BE8EC9592CA3", ["_encstr_A7270A27CAEEB04E46EB96C8", 15]);
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16, 1);
  }
}

isthrowingknifeequipment() {
  for(var_0 = 0; var_0 <= 14; var_0++) {
    var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_0);

    if(!var_1) {
      var_2 = "_encstr_B40101";

      switch (var_0) {
        case 0:
          var_2 = "_encstr_967E09A40CC5515D1FDB52";
          break;
        case 1:
          var_2 = "_encstr_A12309457F2275CBB14A51";
          break;
        case 2:
          var_2 = "_encstr_971804FD3712";
          break;
        case 3:
          var_2 = "_encstr_883009AD28232B4B688B98";
          break;
        case 4:
          var_2 = "_encstr_8B210D8763427379803911D972E08D";
          break;
        case 5:
          var_2 = "_encstr_883E0979CAE2A1689B3161";
          break;
        case 6:
          var_2 = "_encstr_9BD70834BBB0A55B35C3";
          break;
        case 7:
          var_2 = "_encstr_B49507176BBF0EA070";
          break;
        case 8:
          var_2 = "_encstr_810D0599E07D8B";
          break;
        case 9:
          var_2 = "_encstr_A77808B9284B9F27D3C1";
          break;
        case 10:
          var_2 = "_encstr_9B220624456A5747";
          break;
        case 11:
          var_2 = "_encstr_8E4107C4EA5B135939";
          break;
        case 12:
          var_2 = "_encstr_AFAF0B45B2046AE8C2E84BB773";
          break;
        case 13:
          var_2 = "_encstr_BEB406F13B72BB3B";
          break;
        case 14:
          var_2 = "_encstr_AAAB06A99862980B";
          break;
        default:
          var_2 = "_encstr_8FBB0859C0BAAFCB689F" + var_0;
          break;
      }

      self iprintln("_encstr_BDDD0C890DA52A43E128F05A6FA6" + var_2);
    }
  }

  var_3 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16);

  if(!var_3)
    self iprintln("_encstr_8267115590CEE8B69022B097DB52C3A2E1B9A2");
}

issmokinggun() {
  var_0 = forceexplosivedeath();

  for(var_1 = 0; var_1 < var_0 + 1; var_1++) {
    var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1);

    if(!var_2)
      isstunnedby(var_1);
  }
}

isstunnedby(var_0) {
  self iprintln("_encstr_B6961419D2E6963743D2377601B1BD36C24796BDDC80" + var_0);
  self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", 99);
  thread _id_12D33(10, var_0);

  if(var_0 == 14) {
    self iprintln("_encstr_99A61219B4DCB0D80213B7ED3A0185DDB0C99142");
    wait 3;
    cheesewedge();
  }
}

regulateturretrateoffire(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_BDAE1B86C2C6637BDD59AC73A84E2D36D6F4935127CA2CE8D0589B9197", var_3);
  var_4 = level.setplayervargulagjail[var_0];
  var_5 = -1;

  if(var_3 >= var_4) {
    var_5 = var_0;
    return var_5 + 1;
  } else {
    var_6 = -1;

    for(var_7 = 0; var_7 < level.setplunderifunchanged.size; var_7++) {
      var_8 = level.setplunderifunchanged[var_7];

      if(var_3 >= var_8 && var_1 < var_8)
        var_6 = var_7;
    }

    return (var_6 + 1) * -1;
  }
}

_id_12D33(var_0, var_1) {
  self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", 99);
  var_2 = 0;
  var_3 = "_encstr_B40101";

  switch (var_1) {
    case 0:
      var_3 = "_encstr_95FA12A12C3663DB77592B37EB3A9C562CD1AF03";
      break;
    case 1:
      var_3 = "_encstr_B4FA12C89EA4A878A34F2B358FBB3E384133D66B";
      break;
    case 2:
      var_3 = "_encstr_B6FA1222A87985277B3DEDEED8E3AB0F8B98D93F";
      break;
    case 3:
      var_3 = "_encstr_A6FA1222E9395267DB3FF1103ED34E22B7A89806";
      break;
    case 4:
      var_3 = "_encstr_B2FA12D473527A2723EBFD8AFEB963BD47FC97AA";
      break;
    case 5:
      var_3 = "_encstr_84FA12B0779C6037938765F811FB5509F95B81C2";
      break;
    case 6:
      var_3 = "_encstr_8AFA12CB61B388D7D3423050D92BA5E1DF1CD89C";
      break;
    case 7:
      var_3 = "_encstr_85FA12591682EDD7EF89A8882919EB2D8954E78A";
      break;
    case 8:
      var_3 = "_encstr_ADFA12F45F29329713289FABE1AB426A8B6DB178";
      break;
    case 9:
      var_3 = "_encstr_97FA12A1B08D637BEE2BCA737D3A9C56581DF59C";
      break;
    case 10:
      var_3 = "_encstr_A25B1370222DE1D09F2DFD603FBB3B4BD6DB5132CF";
      break;
    case 11:
      var_3 = "_encstr_B15B13C863C0BD171419EA2226ED2BB7F0E147195B";
      break;
    case 12:
      var_3 = "_encstr_BA5B1386C263D8BDBB2B9573D73AC9592C47AF4C91";
      break;
    case 13:
      var_3 = "_encstr_A95B131AB08D8DDE772B599BF5D1E4AC16D1FA8999";
      break;
    case 14:
      var_3 = "_encstr_A65B13FA70A16DCF83D50536E0CBF377E3B0F1E742";
      break;
  }

  if(var_3 != "_encstr_B40101") {
    self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", var_3);
    self dlog_recordplayerevent("_encstr_9B891B8C1BDBCEF5599DAC73D1F5862C8D1BB7BB2BAC37BE8EC9592CA3", ["_encstr_A7270A27CAEEB04E46EB96C8", var_0]);
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1, 1);
    _id_13E12();
  }
}

_id_13E12() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1);
    var_0 = var_0 + var_2;
    var_3 = var_1;
  }

  var_4 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", 16);
  var_0 = var_0 + var_4;

  if(var_0 == 16) {
    wait 3;
    cheesewedge();
  }
}

_id_12D34(var_0) {
  self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", var_0 * -1);
}

_id_12458(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = "_encstr_8F6C0BC685DC23F26AB585B1B1";

  if(var_1)
    var_2 = "_encstr_852209F2C81DA75FFD1BCF";

  var_3 = spawnfx(level._effect[var_2], var_0.origin + (0, 0, 10));
  var_3.angles = var_0.angles;
  wait 0.1;
  triggerfx(var_3);
}

_id_12776(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawnfx(level._effect["_encstr_8D201573D92B670558F744678740CDF3D3968BBB808247"], var_0.origin + (0, 0, 10));
  var_1.angles = var_0.angles;
  wait 0.1;
  triggerfx(var_1);
}

forceexplosivedeath() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 14; var_1++) {
    var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A2211F8A57B03AF0EFCBE0FD098B2B4E4F653AC45BEF19830CD0C7331B5338CA4F", var_1);

    if(var_2)
      var_0++;
  }

  return var_0;
}

isusingtacmap(var_0) {
  if(!isbot(self)) {
    self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", 99);
    self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_ABEA11C248992587DB9D4D4EB883CBAF2B7839" + var_0);
    self dlog_recordplayerevent("_encstr_9B891B8C1BDBCEF5599DAC73D1F5862C8D1BB7BB2BAC37BE8EC9592CA3", ["_encstr_A7270A27CAEEB04E46EB96C8", int(var_0)]);
  }
}

isvalidanimsuiteentity(var_0) {
  if(int(var_0) < 0)
    _id_13E19();
  else if(!isbot(self))
    self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", int(var_0));
}

cheesewedge() {
  self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_B45B1308A3637DD7D4D92A6266AD6BF7B02187D995");
  self dlog_recordplayerevent("_encstr_9B891B8C1BDBCEF5599DAC73D1F5862C8D1BB7BB2BAC37BE8EC9592CA3", ["_encstr_A7270A27CAEEB04E46EB96C8", 16]);
}