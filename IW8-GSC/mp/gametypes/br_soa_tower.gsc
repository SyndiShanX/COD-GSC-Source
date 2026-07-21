/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_soa_tower.gsc
***********************************************/

init() {
  level thread _id_13C04();
  waittillframeend;
  level thread _id_13C0A();
  level thread _id_13C01();
  level thread _id_13C03();
  level thread _id_13C0F();
}

_id_13C0A() {
  level.hostage_callout_saveme_time = ::_id_13468;
  var_0 = getEnt("_encstr_8EB6134A205B69D4481027733961B4B21D4F13C516", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0 scripts\engine\utility::get_linked_ents();
  var_0.choosegulagloadouttable = 0;

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);
    var_3.targetname = "_encstr_B8161853D0C9815B6F7B67FD8770EB7703D3D397D2069E2BD83A";
  }

  level._id_142FC = getEnt("_encstr_8A9A1A4ECF5E4173275BDD0BB07511E76B67A3CFD8B1639759E78F6D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_142FC enablelinkTo();
  level._id_142FC linkTo(var_0);
  level.getflagradarowner = ::trophy_watchtimeoutorgameended;
  level.getfirespoutlaunchvectors = ::trophy_watchtimeoutorgameended;
  var_5 = getEnt("_encstr_8A72215635FA576B8F07F858BFDD206BF3DE4DD0CAB1F7317A8FF8B817E29E816A87C5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 wp_loop();
  var_5._id_140B4 = var_5.origin;
  var_5._id_140B9 = scripts\engine\utility::getStruct("_encstr_AF7926605F49C083604F17E2B85064A2DE1883200A112283E8C7B1AF753818C12F985B8170E16FC0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_6 = getEnt("_encstr_BEF822471FB20808DF6B118B19BD805D9B8FF1F7F3B9EE78FA4939203D72E10EC2EF4159", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 wp_loop();
  var_6._id_140B4 = var_6.origin;
  var_6._id_140B9 = scripts\engine\utility::getStruct("_encstr_8252278E27473F3088975DFD613061D974415B6715C8EBFFB2AF1160E5D3AF5A433CFB8B192810F8F0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_7 = getEnt("_encstr_8EA925DF576EC9159753B15BF997C1C043B1296FD2594851EFCA6BE6C7A78DD85D1AF7F16D7F60", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 wp_loop();
  var_7._id_140B4 = var_7.origin;
  var_7._id_140B9 = scripts\engine\utility::getStruct("_encstr_A14C2A33AADFF8F0953F8BDD6F7F78BDDBE26B38E3CFACE8AD0FAD8F2B29C07017AB86C07A93DD3945089BF5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_8 = getEnt("_encstr_B6CB26E6EDC2AFD1DE772B27BEACB1959D0B3ADE9CF5CC36F67B27AF33FA467BDE9C7D9CA59D343A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 wp_loop();
  var_8._id_140B4 = var_8.origin;
  var_8._id_140B9 = scripts\engine\utility::getStruct("_encstr_85F52B26458A271BFF57A8E80F0DD09B236E1DA09A012D40D71F1889961FA9D71A52AFB6343AF98BBF071040FB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_9 = getEnt("_encstr_8B1A268730610F1387E43FF2D84B4AFD6BB8136F701E6EDAEFF0C2A116C931841060F3271831A6A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 wp_loop();
  var_9._id_140B4 = var_9.origin;
  var_9._id_140B9 = scripts\engine\utility::getStruct("_encstr_8BA12B77C0919F8317748F42483B3A6DDB28E3FFC08E1E4A7FB752316679C13480F063B788A15613C728DAB720", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_10 = getEnt("_encstr_97552793FF2F1743F510825B8005617DFBA304900ADF5479278A3D6E23F799E8DF15D3EFBA7AE0B193", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_10 wp_loop();
  var_10._id_140B4 = var_10.origin;
  var_10._id_140B9 = scripts\engine\utility::getStruct("_encstr_856D2CE6BD0BD7E8DEBBCA27AF2BD8563B858E7B4E7D338D7BEDE4EBCC81EB197BED27D739A5D90D1DF5DE38ACCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_11 = scripts\engine\utility::getStruct("_encstr_8D5A1B37ED58AF8EB7775993AFAC8DCA9D85A3ED93F53363F6F6E4FA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_12 = scripts\engine\utility::getStruct("_encstr_A1931CCBB799CFB37718CAB3714B6DFF93FF345F26E663FD0FC08379EA39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_13 = ((var_7._id_140B4[0] + var_8._id_140B4[0]) / 2, (var_7._id_140B4[1] + var_8._id_140B4[1]) / 2, (var_7._id_140B4[2] + var_8._id_140B4[2]) / 2);
  var_14 = ((var_9._id_140B4[0] + var_10._id_140B4[0]) / 2, (var_9._id_140B4[1] + var_10._id_140B4[1]) / 2, (var_9._id_140B4[2] + var_10._id_140B4[2]) / 2);
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_15 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_16 = (-17.756, 185.622, 3761.61);
  var_17 = (90, 270, 90);
  var_18 = (41, 184, 3625);
  var_19 = (0, 0, 0);
  var_20 = distance2d(var_16, var_18);
  var_21 = var_16[2] - var_18[2];
  var_22 = vectortoangles((var_16[0], var_16[1], 0) - (var_18[0], var_18[1], 0))[1];
  var_23 = var_17 - var_19;
  var_24 = scripts\engine\utility::getStruct("_encstr_A1931CCBB799CFB37718CAB3714B6DFF93FF345F26E663FD0FC08379EA39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles[1] + var_22;
  var_15.origin = var_11 + anglesToForward((0, var_24, 0)) * var_20;
  var_15.origin = var_15.origin + (0, 0, var_21);
  var_15.angles = scripts\engine\utility::getStruct("_encstr_8D5A1B37ED58AF8EB7775993AFAC8DCA9D85A3ED93F53363F6F6E4FA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles + var_23;
  var_15 linkTo(var_0);
  level._effect["_encstr_B6BA1283D728A9E59AF785CFCB123CD8DC61C3F3"] = loadfx("_encstr_B4102A46BA196E9C63DF193092722F2F6D8691035DD0701575B898BAA03BD3D7E1AB587BA3597F030E08B2EA");
  wait 10;

  foreach(var_26 in level.players)
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_B6BA1283D728A9E59AF785CFCB123CD8DC61C3F3"), var_15, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_26);

  var_0 thread _id_13C09();
  waitframe();

  for(;;) {
    var_0 thread _id_13C07();
    var_0 moveTo(var_12, 15, 3, 3);
    var_5 moveTo((var_5._id_140B4[0], var_5._id_140B4[1], var_12[2]), 15, 3, 3);
    var_6 moveTo((var_6._id_140B4[0], var_6._id_140B4[1], var_12[2]), 15, 3, 3);
    wait 12;
    wait 3;
    var_0 thread _id_13C08();
    wait 1;
    var_5 moveTo((var_5._id_140B9[0], var_5._id_140B9[1], var_0.origin[2]), 3, 1, 1);
    var_6 moveTo((var_6._id_140B9[0], var_6._id_140B9[1], var_0.origin[2]), 3, 1, 1);
    var_9 moveTo(var_9._id_140B9, 3, 1, 1);
    var_10 moveTo(var_10._id_140B9, 3, 1, 1);
    thread _id_13C06(var_14);
    wait 3;
    wait 8;
    var_5 moveTo((var_5._id_140B4[0], var_5._id_140B4[1], var_0.origin[2]), 3, 1, 1);
    var_6 moveTo((var_6._id_140B4[0], var_6._id_140B4[1], var_0.origin[2]), 3, 1, 1);
    var_9 moveTo(var_9._id_140B4, 3, 1, 1);
    var_10 moveTo(var_10._id_140B4, 3, 1, 1);
    thread _id_13C05(var_14);
    wait 3;
    wait 1;
    var_0 thread _id_13C07();
    var_0 moveTo(var_11, 15, 3, 3);
    var_5 moveTo((var_5._id_140B4[0], var_5._id_140B4[1], var_11[2]), 15, 3, 3);
    var_6 moveTo((var_6._id_140B4[0], var_6._id_140B4[1], var_11[2]), 15, 3, 3);
    wait 12;
    wait 3;
    var_0 thread _id_13C08();
    wait 1;
    var_5 moveTo((var_5._id_140B9[0], var_5._id_140B9[1], var_0.origin[2]), 3, 1, 1);
    var_6 moveTo((var_6._id_140B9[0], var_6._id_140B9[1], var_0.origin[2]), 3, 1, 1);
    var_7 moveTo(var_7._id_140B9, 3, 1, 1);
    var_8 moveTo(var_8._id_140B9, 3, 1, 1);
    thread _id_13C06(var_13);
    wait 3;
    wait 8;
    var_5 moveTo((var_5._id_140B4[0], var_5._id_140B4[1], var_0.origin[2]), 3, 1, 1);
    var_6 moveTo((var_6._id_140B4[0], var_6._id_140B4[1], var_0.origin[2]), 3, 1, 1);
    var_7 moveTo(var_7._id_140B4, 3, 1, 1);
    var_8 moveTo(var_8._id_140B4, 3, 1, 1);
    thread _id_13C05(var_13);
    wait 3;
    wait 1;
  }
}

_id_13C09() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A7E02492187196BBDFA3FD3D58F51483D5F2A83050D7FE78C85DA98FF1E7852D44C0DF71D3A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_B42A240725303899EF07707B412B82E5CB39B8AACAA7333F4F38AF6646E55F2A9818AF439BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self._id_14684 = var_0.origin[2] - self.origin[2];
  self._id_14686 = var_1.origin[2] - self.origin[2];
  self._id_14686 = self._id_14686 - 10;
  var_2 = (var_0.origin + var_1.origin) / 2;
  var_3 = var_0.angles[1];
  var_4 = distance2d(var_0.origin, var_1.origin);
  var_5 = vectortoangles(var_1.origin - var_0.origin)[1];
  var_6 = var_5 - var_3;
  var_1.origin = var_0.origin + var_4 * anglesToForward((0, var_6, 0));

  for(;;) {
    var_7 = scripts\mp\utility\player::getplayersinradius((var_2[0], var_2[1], self.origin[2]), 150);

    foreach(var_9 in var_7) {
      var_10 = distance2d(var_0.origin, var_9.origin);
      var_11 = vectortoangles(var_9.origin - var_0.origin)[1];
      var_12 = var_11 - var_3;
      var_13 = var_0.origin + var_10 * anglesToForward((0, var_12, 0));

      if(var_0.origin[0] < var_13[0] && var_13[0] < var_1.origin[0] && var_0.origin[1] < var_13[1] && var_13[1] < var_1.origin[1] && self.origin[2] + self._id_14684 < var_9.origin[2] && var_9.origin[2] < self.origin[2] + self._id_14686 && isalive(var_9)) {
        var_9 setclienttriggeraudiozone("_encstr_BE72186793080C0358D7AFE793E86A5C08DB5EEB08409F3AA069", 0.5);
        continue;
      }

      var_9 clearclienttriggeraudiozone(0.5);
    }

    waitframe();
  }
}

_id_13C07() {
  self playsoundonmovingent("_encstr_81661E83DA53487805B96F03ACEF182F43723B8EC2FB80B0DA956727DCD6E06D");
  self playLoopSound("_encstr_B1631B97FF92D8E0EFDE663985CDB30F8B670D47AFFA80E82B376E10AA");
  self.choosegulagloadouttable = 1;
}

_id_13C08() {
  self playsoundonmovingent("_encstr_B1241D0EDB0356271DDA29F022B71529C34F169039DB9E6342E23178BBCDD1");
  self stoploopsound();
  self.choosegulagloadouttable = 0;
}

_id_13C06(var_0) {
  playsoundatpos(var_0, "_encstr_B4A716D8FAB898DE0F56AFA23C9D603A08F2A331A2F965CE");
}

_id_13C05(var_0) {
  playsoundatpos(var_0, "_encstr_A3F8179F3BE5AFC8188E187A035F7BB1A3C7E8DF5330676EED");
}

trophy_watchtimeoutorgameended(var_0) {
  return !var_0 istouching(level._id_142FC);
}

triggeraddobjectivetext(var_0) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "_encstr_B8161853D0C9815B6F7B67FD8770EB7703D3D397D2069E2BD83A")
    return 1;

  return 0;
}

_id_13468(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, getEnt("_encstr_8EB6134A205B69D4481027733961B4B21D4F13C516", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin + (0, 0, 75)) < squared(200)) {
    var_0 kill();
    return 1;
  } else
    return 0;
}

_id_13C01() {
  _id_13C02("_encstr_8D1F09027BA68F8523E342", "_encstr_84160AFF4D690F2B28488BA7");
  _id_13C02("_encstr_8D1F09027BA68F8523E342", "_encstr_8F650BC05A690D4877BFEEF7D9");
  _id_13C02("_encstr_8D1F09027BA68F8523E342", "_encstr_84650B4710CEBB05C7682B377A");
  _id_13C02("_encstr_8D1F09027BA68F8523E342", "_encstr_84160AFF4D690F2B28488BA7");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_B2650B18785E63D0E8E00A2EBE");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_84160AFF4D690F2B28488BA7");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_84650B4710CEBB05C7682B377A");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_AD160ADBDCF533B1B7DB4E23");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_84650B4710CEBB05C7682B377A");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_85160A6290A10E789D38DDDE");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_845D08C0B56FA080CADB");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_A6650B9F2D096F4B48E82B275B");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_B2650B18785E63D0E8E00A2EBE");
  _id_13C02("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_84650B4710CEBB05C7682B377A");
}

_id_13C02(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in var_2) {
    if(var_4 getscriptablehaspart(var_0) && var_4 getscriptableparthasstate(var_0, var_1))
      var_4 setscriptablepartstate(var_0, var_1);
  }
}

_id_13C04() {
  var_0 = [];
  var_0[0] = (20820, -14380, 3766);
  var_0[1] = (20509, -14258, 3755);
  var_0[2] = (20282, -14245, 3740);

  foreach(var_2 in var_0) {
    var_3 = 500;
    _encstr_8EDD2B8782956F91793A38D0131E9C9BB88F43E04020974FC220B1066D7A904B3A58F75B61491F3C33D57CBE30::little_bird_mg_playercontrolmg(var_2, var_3);
  }
}

_id_13C03() {
  var_0 = (20644, -14275, 3700);
  var_1 = 375;
  var_2 = canceljoins(undefined, undefined, var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(var_4.origin[2] < 3650 || var_4.origin[2] > 3800) {
        continue;
      }
      if(var_4.type == "_encstr_B4D90E9636AFD277F08057BF3029380A" || var_4.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D")
        var_4 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_ADB405071B8AE8");
    }
  }
}

activatemusictrigger() {}

_id_13C0F() {
  level._id_12E2E = spawnStruct();
  level._id_12E2E.parachuteoverheadwarningtimeoutms = getdvarfloat("_encstr_88332936A973EF3B68EAAF72E36765A1B1C366BBF84DA1B0CF40FB79805771836B10FF5203AE47F9AABFCD", 15.0);
  level._id_12E2E.spotlight_turret_info = getdvarint("_encstr_A3B72902B14887E3780BBF2F5D157AE479BB3E0BC8907F3BCF2B47175B49F23B88E6F75240081BB1A93B33", 2);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level thread _id_13C10();
  level thread _id_13C11();
}

_id_13C10() {
  var_0 = (-196, 836, 3890);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D")
    var_0 = (20270, -14587, 3731);

  var_1 = scripts\mp\gameobjects::createhintobject(var_0, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A31722C86EAE2130976FE57FA988816834D0EBECA5AEFF3F1351D923F701F671F9603F0A", undefined, undefined, undefined, 350, 360, 200, 120);
  var_1 thread _id_13C0D();
}

_id_13C0D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = getEnt("_encstr_92DD0DFAC13BEF85C16DE8092717DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss()) {
      if(soundexists("_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51"))
        playsoundatpos(self.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");

      var_0 thread _id_13C0E(var_1);
      self delete();
    } else if(soundexists("_encstr_B63B0FC493FADACABC381619BE19ACB9F2"))
      playsoundatpos(self.origin, "_encstr_B63B0FC493FADACABC381619BE19ACB9F2");

    wait 0.25;
  }
}

_id_13C0E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = incrementpersistentstat(level.players, self.origin, 10000);

  foreach(var_3 in var_1)
  var_3 scripts\mp\hud_message::showsplash("_encstr_839B21C49CFAE6F658BE47F6EE56E47D959D59B9E8EB9D2CAB8DE8BEDE0759DC963776", undefined, var_0);

  var_5 = (-161, 752, 3972);
  var_6 = (-353, 873, 3970);
  var_7 = (-354, 644, 3970);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_5 = (20330, -14534, 3816);
    var_6 = (20218, -14734, 3816);
    var_7 = (20440, -14734, 3816);
  }

  playsoundatpos(var_5, "_encstr_8E5C12B6F0EB9BBD0BFA7BC859FA1DB7BEA6DB5E");
  playsoundatpos(var_6, "_encstr_8F731C0793F80763F88B3F87F995E964781E7C0DEA49C14AC785FF4F7967");
  playsoundatpos(var_7, "_encstr_91731CE5B84D59F3A7FF1FCF30936E40771F44703B29C3892BB027A0DF2D");
  self rotateYaw(-90, level._id_12E2E.parachuteoverheadwarningtimeoutms, 0.25, 0.25);
  playsoundatpos(self.origin, "_encstr_8DFD1A7F5863AFB227489AD92CE37B54CBA9DFB3A858F78B3957620B");
  wait 0.5;
  self playLoopSound("_encstr_88F31656D9A3BEE6BDB07D46DB7B4ED73B585D63E87D8D07");
  wait(level._id_12E2E.parachuteoverheadwarningtimeoutms - 0.5);
  playsoundatpos(self.origin, "_encstr_AB54198DA37B87B95F97B0E1CB695329A301708FFF723F032CFFA8");
  self stoploopsound();
}

_id_13C11() {
  var_0 = (-73, 449, 3895);
  var_1 = (-73, 337, 3895);
  var_2 = (-73, 233, 3895);
  var_3 = (0, 180, 0);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0 = (20675.3, -14460, 3726);
    var_1 = (20746.3, -14460, 3726);
    var_2 = (20882.5, -14460, 3726);
    var_3 = (0, 90, 0);
  }

  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_3;
  var_4.itemsdropped = 0;
  var_4._id_13904 = "_encstr_A7751EA710412F33A7C4DF12384DBACD48709F437879431A8F5BA90A1B076274";
  var_5 = scripts\mp\gameobjects::createhintobject(var_4.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AFA31F2DF7EFD7B996B9986B57C6213A1BC3576307C12ADF09AF4FD15B055A115A");
  var_5 thread _id_13C12("_encstr_A1E108317F1CBFDBEAF8", var_4);
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_3;
  var_6.itemsdropped = 0;
  var_6._id_13904 = "_encstr_93431F3350E749DBA00B5FBA17A3E3AB7B48C9C955104A7E7D0BA1D8735DF30289";
  var_7 = scripts\mp\gameobjects::createhintobject(var_6.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A9A31F2E426F7F874ED1018168D5F9B833392DB1FCC7A46BA0290931103F2D4E0A");
  var_7 thread _id_13C12("_encstr_8F310936D7BA63CBE9ABB8", var_6);
  var_8 = spawnStruct();
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_8.itemsdropped = 0;
  var_8._id_13904 = "_encstr_A5CC1D3B8D39A16592B7BB9DFFEB2708DCA3265035634816CAB3D7590FD2F5";
  var_9 = scripts\mp\gameobjects::createhintobject(var_8.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_8CA31F9089BE07C50FE0F95D15D1692F615FDB95F37167098BCDB577E357BDC1DE");
  var_9 thread _id_13C12("_encstr_91810AA76AAF739F3F7A3858", var_8);
}

_id_13C12(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_3 = 0;

    switch (var_0) {
      case "_encstr_A1E108317F1CBFDBEAF8":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_AAAF28214BDBD0184307938F236FB0A66F32D9AB92BF1CE09D14E7AD495390EDC75A90318A93401079B9");
        break;
      case "_encstr_8F310936D7BA63CBE9ABB8":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_96AF286AC692E00FF38E3B2337C0A2F0578BDA3A1C61AF88D235C60598A34293E861379E0F661F18F012");
        break;
      case "_encstr_91810AA76AAF739F3F7A3858":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132");
        break;
    }

    if(var_3) {
      if(soundexists("_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51"))
        playsoundatpos(self.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");

      var_4 = getEnt(var_1._id_13904, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      playsoundatpos(var_4.origin, "_encstr_8E0616854EEBD6899DBAC0A1A2B5BFE81BCF9310BF2359D5");
      var_4 rotateYaw(80, 1.5, 0.5, 0.5);
      wait 1.32;
      var_1 thread _id_13C14(var_0, var_2);
      var_2 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12BFC();
      self delete();
    } else if(soundexists("_encstr_ACA80FED33315369193F78E1B96C1575FB"))
      var_2 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");

    wait 0.25;
  }
}

_id_13C14(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_AB580A05672AE35D5FFF50B8");
  var_3 = _id_13C13(var_0, var_2);
  _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_3, 0);

  if(var_0 == "_encstr_91810AA76AAF739F3F7A3858") {
    var_4 = (15, 0, 0);

    if(level.mapname == "_encstr_8CD508CA98A70FAFC01D")
      var_4 = (0, 15, 0);

    var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_135DF("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", scripts\engine\utility::drop_to_ground(self.origin + var_4, 0, -200, (0, 0, 1)) + (0, 0, 25), 0);
    var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::risk_flagspawndebugobjicons();
    var_5 _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::controlslinked(var_6);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_5);
  }
}

_id_13C13(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "_encstr_A1E108317F1CBFDBEAF8":
      var_2[0] = "_encstr_8F561BAD4BD0CA7F535F8B2B432D33F71211E7FB582FAD7F0988E307A0";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_A2FF1CCAA3D94F2D58BF6A7FD1E8F687FD98238129AB7B22D8576C71FD60";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[4] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_3 = min(level._id_12E2E.spotlight_turret_info, var_1);

        for(var_4 = 0; var_4 < var_3; var_4++)
          var_2[var_2.size] = "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537";
      }

      break;
    case "_encstr_8F310936D7BA63CBE9ABB8":
      var_2[0] = "_encstr_AC85165B4058B72A094832ABC7C3337F01A8FFE7F831FF23";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[4] = "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[4] = "_encstr_8EED1705B2A5C0B76359C8B0523BC6D0FA3D8BEF774EA85F03";
      }

      break;
    case "_encstr_91810AA76AAF739F3F7A3858":
      var_2[0] = "_encstr_B48D190EDBF0FF7ABD3FB7A789ED73171881461793A0B492985F17";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
      }

      break;
  }

  return var_2;
}

_id_13C15(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(var_1, 0) + var_2;

  switch (var_0) {
    case "_encstr_A1E108317F1CBFDBEAF8":
      var_4 = easepower("_encstr_AAAF28214BDBD0184307938F236FB0A66F32D9AB92BF1CE09D14E7AD495390EDC75A90318A93401079B9", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
    case "_encstr_8F310936D7BA63CBE9ABB8":
      var_4 = easepower("_encstr_96AF286AC692E00FF38E3B2337C0A2F0578BDA3A1C61AF88D235C60598A34293E861379E0F661F18F012", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
    case "_encstr_91810AA76AAF739F3F7A3858":
      var_4 = easepower("_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
  }
}

wp_loop() {
  var_0 = scripts\engine\utility::get_linked_ents();

  foreach(var_2 in var_0)
  var_2 linkTo(self);
}