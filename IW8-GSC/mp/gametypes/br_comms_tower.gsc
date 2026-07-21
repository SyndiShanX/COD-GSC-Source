/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_comms_tower.gsc
***********************************************/

init() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._effect["_encstr_BD7616BE050819476EB1A7197B48D74FB08F222589D05D23"] = loadfx("_encstr_9A8930CB10E02A81288A113AF3BDD918264F0F76B7B3599726CBB0DB2752B3DF4CA7DB886FC27BE9A60D8BD430D0A6801250");
  level._effect["_encstr_91011F4BA3BB4F957A483CFFFB50672FCA2F703B71CF78630B4D3F60A454C2AB63"] = loadfx("_encstr_993F376B38F9CDA713EBAF8AE6307FA20F88A3B2788117EAC0349E9868015FAE31C18A1AE86B8D0F21906EAC1FA8E377E52993A2184D43337A");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_816D1C1E9F51639064379368A2A73B0A6561DBAE2D05D7F1F8829005C263"] = "_encstr_8CC820B8AD2D7A045E317DB6DA75701BFFBE8887AF96B35037993BD8455BF1CF7213";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4231A17E030CD5141186BE7FE6FCA8B7B48CBA790E93C996925F69D"] = "_encstr_84961F177506C22126C1A230E58AF0A7C98657A0F1B1D8520F17FB314A7F2769CB";
  waitframe();
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level thread _encstr_AB5B10E02A6FFDD865D56B4FD44D30CDBB53();
}

_encstr_AB5B10E02A6FFDD865D56B4FD44D30CDBB53() {
  if(getdvarint("_encstr_8B501B37C627F5C439F536DEB6AD6ED7E8EDBBB2C9D7599B2C131B9523", 1) == 0) {
    return;
  }
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_encstr_A3931CF387678A230BBBCA8377B370C34C88DD29E5403FD2B5AABEAB2EEC(::_encstr_A1D511E8DEEECA4E38B76E47C1C65DCD462B27);
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D = spawnStruct();
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E = [];
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._id_13671 = _encstr_B41517A8C28B71707FCD960EB30BF90F753A701B3A238388C3();
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7 = getdvarint("_encstr_ACE5191AE2B329808EC1509805EF13B7D4DFD71F453138635A812F", 1500);
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D.usecooldown = getdvarint("_encstr_851F16F3D8256933FBAFCBCF21204FA181203B6AB8A7DE63", 45);
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_86320B0328F3B5E3092D7165BE = getdvarint("_encstr_8B811ACD3639FA989CFA8DEDB6D66ED7D1DBBB594EAF272C912DAB6E", 2500);
  level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_A5E00E9EFE32FD736F8720802B994813 = getdvarint("_encstr_87831D2E4EB32FC1FAFF6008DF0D3BF77BF5A4BD62193F2BD50F83C8F755B1", 3000);
  _encstr_843D0C072977B3AE185873FFD308();
  level thread _encstr_9362139BB3A9324044E31E85BB60D47A4970F525A0();
  level thread _encstr_84481319D2B916138DB247B7EE2B9C6EA5CD3B0BE6();
}

_encstr_95260BA2BB02B8842D2202375C(var_0) {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_B4231A17E030CD5141186BE7FE6FCA8B7B48CBA790E93C996925F69D", var_0.team, 1);
  var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 1);
  var_2 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 2500, undefined, var_1);

  if(var_2.size > 0)
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_816D1C1E9F51639064379368A2A73B0A6561DBAE2D05D7F1F8829005C263", 1, var_2);
}

_encstr_B41517A8C28B71707FCD960EB30BF90F753A701B3A238388C3() {
  var_0 = [];

  switch (getDvar("_encstr_9570084B1793A090CDFF")) {
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
      break;
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      var_0[var_0.size] = [(3280, -4426.5, 1258), (3271, -4392, 1251), (0, 285, 0)];
      break;
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      var_0[var_0.size] = [(2048, -2649, 50.25), (2048, -2688, 0), (0, 0, 0)];
      break;
    case "_encstr_8D200EC21BB88FC238EB405D29B18AB6":
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
      var_0[var_0.size] = [(-2924.25, -10759, 584.75), (-2952.25, -10732, 533.75), (0, 45, 0)];
      var_0[var_0.size] = [(-802.75, -5367, 740), (-738.75, -5312.25, 769.25), (0, 45, 0)];
      var_0[var_0.size] = [(368.672, -2753.04, 2560.82), (368.5, -2680.25, 2641.75), (0, 0, 0)];
      var_0[var_0.size] = [(-3306, -3533.25, 1235.75), (-3157.25, -3529.25, 1511.75), (0, 93, 0)];
      var_0[var_0.size] = [(-1093.5, -36.5, 1812.75), (-1129.75, -37, 1754), (0, 91, 0)];
      var_0[var_0.size] = [(3445, -1815, 1058), (3419.5, -1820.25, 953.5), (0, 101, 0)];
      var_0[var_0.size] = [(1197.75, 8941.75, 1056), (1235.75, 8953, 1004.75), (0, 105, 0)];
      var_0[var_0.size] = [(-2678.75, 10770, 1195), (-2685.25, 10809.3, 1143.25), (0, 98, 0)];
      break;
  }

  return var_0;
}

_encstr_843D0C072977B3AE185873FFD308() {
  var_0 = 0;

  foreach(var_2 in level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._id_13671) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2[0]);
    var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_4 = easepower("_encstr_AFC50F4F1F096ACB49237D433918DF22D5", var_2[0]);
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2[1]);
    var_5.angles = var_2[2];
    var_5 setModel("_encstr_B6E516E6D050550380C19FC7DB3E099990599C6E8930EF4B");
    var_3.useprompt = scripts\mp\gameobjects::createhintobject(var_3.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_B40B33EB1D27D128479BBBC6A380DD98B13181B122FBD6BA353F61A217887561382F0859D929AF9159B5E38F22A15546407630BB2D", undefined, undefined, undefined, 0, 0, 65, 90);
    var_3.useprompt._encstr_B48D0A0A39B0E0AB305BBBA3 = scripts\mp\gameobjects::createhintobject(var_3.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_91FE34C4F899F36F3F4FC9514768859F5153584C40F7D53BA733F1D12758DD7FE849DEF86DC85F3EE4B7D9115BB73503516626F1F730", undefined, undefined, undefined, 0, 0, 65, 90);
    var_3.useprompt.inuse = 0;
    level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E[level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E.size] = var_3.useprompt;
    var_3.id = var_0;
    var_0++;
    var_3.useprompt sethintstringparams(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7);
    var_3.useprompt._encstr_B48D0A0A39B0E0AB305BBBA3 sethintstringparams(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7);
    var_3 thread _encstr_B60A1D7A9A30EECA30BD7F2B6FEDA3EB9F5A82ED0C531B274E8BE7E848B085(var_3.useprompt, var_4, var_5);
    var_3 thread _encstr_95471B78028DDBF1B75A9D053083B8BB723BC0E8EBE735C97764938836(var_3.useprompt._encstr_B48D0A0A39B0E0AB305BBBA3);
  }

  foreach(var_8 in level.players)
  var_8 thread _id_126E0();
}

_encstr_B60A1D7A9A30EECA30BD7F2B6FEDA3EB9F5A82ED0C531B274E8BE7E848B085(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  var_1 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_B2380A42CB5DBBB573C7EFE6");
  var_2 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_95BD0E96CD23D2362CD1F64EEBF666CC");
  var_3 = 15.0;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(var_0 _id_1392A(var_4)) {
      thread _encstr_BED1075FF0AF7A3198(var_4);
      level thread _encstr_95260BA2BB02B8842D2202375C(var_4);
      var_4 _encstr_969415B1BDB56BCD1DEDDD5939DC85DC2C1B97E8B4B16E(self.id);
      var_4 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A9F8180EA2C9FFD85D9FD9B8AF7F5115118E768DFCF343E33DD3");
      var_0.inuse = 1;
      _encstr_9B69169A6BAB493E235503A7B7A2EB98EA3A19697DB5DBF7(var_0);

      if(!_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2)) {
        var_5 = int(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7 / 100);
        var_4 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_4.plundercount - var_5);
      }

      var_1 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_A1A70B90D39B61602BC72894D6");
      var_2 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_AF4D0D4B7319D2D816D1ED937DB79B");
      wait(var_3);
      var_2 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_95BD0E96CD23D2362CD1F64EEBF666CC");
      wait(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D.usecooldown);
      var_1 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_B2380A42CB5DBBB573C7EFE6");
      var_0.inuse = 0;
      _encstr_960515599BB04CC6B247EDDD2B4E0E39F6B61C3AEACD95(var_0);
    }
  }
}

_encstr_95471B78028DDBF1B75A9D053083B8BB723BC0E8EBE735C97764938836(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self playsoundtoplayer("_encstr_BEB814C0FAB99719B3E535B8C73721779F21C0D8E248", var_1);
  }
}

_encstr_BED1075FF0AF7A3198(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    triggerportableradarpingteam(self.origin, var_0.team, level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_86320B0328F3B5E3092D7165BE, level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_A5E00E9EFE32FD736F8720802B994813);
    wait 3.0;
  }
}

_encstr_A1D511E8DEEECA4E38B76E47C1C65DCD462B27(var_0) {
  if(!_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2)) {
    if(_encstr_A6F214438ACFFB68A248E9C34E0F20C627E359E9F337(var_0))
      thread _id_126E0();
  }
}

_encstr_A6F214438ACFFB68A248E9C34E0F20C627E359E9F337(var_0) {
  var_1 = int(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7 / 100);

  if(!isDefined(var_0) || !isDefined(var_0.player))
    return 1;
  else if(var_0.player.plundercount >= var_1 && var_0.player.plundercount - var_0._id_127B4 >= var_1)
    return 0;
  else if(var_0.player.plundercount < var_1 && var_0.player.plundercount - var_0._id_127B4 < var_1)
    return 0;
  else
    return 1;
}

_id_126E0() {
  foreach(var_1 in level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E)
  _id_126DF(var_1);
}

_encstr_A36818A8E1F937972D58EBB388638B1F135512258EA3CF9A3B40() {
  foreach(var_1 in level.players)
  var_1 thread _id_126E0();
}

_encstr_9B69169A6BAB493E235503A7B7A2EB98EA3A19697DB5DBF7(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_0 disableplayeruse(var_2);
      var_0._encstr_B48D0A0A39B0E0AB305BBBA3 disableplayeruse(var_2);
    }
  }
}

_encstr_960515599BB04CC6B247EDDD2B4E0E39F6B61C3AEACD95(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2))
      var_2 _id_126DF(var_0);
  }
}

_id_126DF(var_0) {
  if(var_0.inuse) {
    return;
  }
  if(istrue(self.iszombie)) {
    var_0 disableplayeruse(self);
    var_0._encstr_B48D0A0A39B0E0AB305BBBA3 disableplayeruse(self);
  } else {
    var_1 = int(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7 / 100);

    if(isDefined(self.plundercount) && self.plundercount >= var_1 || _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2)) {
      var_0 enableplayeruse(self);
      var_0._encstr_B48D0A0A39B0E0AB305BBBA3 disableplayeruse(self);
      return;
    }

    if(!isDefined(self.plundercount) || self.plundercount < var_1) {
      var_0 disableplayeruse(self);
      var_0._encstr_B48D0A0A39B0E0AB305BBBA3 enableplayeruse(self);
    }
  }
}

_id_1392A(var_0) {
  if(_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2))
    return 1;

  var_1 = int(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7 / 100);

  if(var_0.plundercount < var_1)
    return 0;

  return 1;
}

_encstr_9362139BB3A9324044E31E85BB60D47A4970F525A0() {
  for(;;) {
    level waittill("_encstr_99DC1C70EB101DAFBEFE4A438137939968BB0AED7FA0A5474893533A0B65");

    foreach(var_1 in level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E)
    var_1 sethintstringparams(0);

    thread _encstr_A36818A8E1F937972D58EBB388638B1F135512258EA3CF9A3B40();
    level waittill("_encstr_AD111A71E516E8330F89D9A332E375B9AF41FDC38BBEB00DD7C2B0E9");

    foreach(var_1 in level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E)
    var_1 sethintstringparams(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_840811A26779CF18B375433F9353E98B9127E7);

    thread _encstr_A36818A8E1F937972D58EBB388638B1F135512258EA3CF9A3B40();
  }
}

_encstr_84481319D2B916138DB247B7EE2B9C6EA5CD3B0BE6() {
  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

    foreach(var_2 in level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E) {
      if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_2.origin)) {
        var_2 istacmapactive();
        var_2._encstr_B48D0A0A39B0E0AB305BBBA3 istacmapactive();
        level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E = scripts\engine\utility::array_remove(level._encstr_AC681070EA02B3EAC97F133AC62FC745DC4D._encstr_8FDB0C48B0D2ED7B4B30C8CFEB1E, var_2);
      }
    }
  }
}

_encstr_969415B1BDB56BCD1DEDDD5939DC85DC2C1B97E8B4B16E(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];
  var_3 = var_0;
  var_2[var_2.size] = "_encstr_AC0810770F6201209FDB203B879A68509A8B";
  var_2[var_2.size] = var_3;

  if(isDefined(level.br_circle)) {
    var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::relic_mythic_modifyplayerdamage();
    var_2[var_2.size] = "_encstr_A76C1A1BDBD6B6B9AF477BDD5627CD7D36A5C936D856BE5ADC91563C";
    var_2[var_2.size] = var_4;
  }

  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2[var_2.size] = "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1";
  var_2[var_2.size] = var_5;
  var_1 dlog_recordplayerevent("_encstr_A71E189C2180277FB5C342FAAB80B79D38BB03DF79D86B5FE69B", var_2);
}