/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gxp_safe_zones.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_A7A41ACDC69CD74C4EFAE60B992BEB4F7BB9B2E6FA95B985C4639532", 0)) {
    return;
  }
  tank_x1();
  level._id_12E76 = spawnStruct();
  level._id_12E76._id_1472A = [];
  level._id_12E76.zones = [];
  level._id_12E76._id_12E62 = [];
  level thread _id_11FF3();
}

_id_11FF3() {
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 5;
  _id_135C5();
  level thread _id_12E78();
}

truckdoorleft(var_0) {
  if(level.disable_super_in_turret._id_12E6B != 1)
    return 0;

  if(!isDefined(level._id_12E76))
    return 0;

  if(!isarray(level._id_12E76.zones))
    return 0;

  return scripts\engine\utility::array_contains(level._id_12E76._id_12E62, var_0);
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

badpathnodes(var_0, var_1, var_2, var_3, var_4) {
  var_3 = _id_140C6(var_3);

  if(!var_3) {
    return;
  }
  var_5 = spawnStruct();
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.radius = var_3;
  var_5.height = var_4;
  var_6 = level._id_12E76._id_1472A.size;
  var_5.id = "_encstr_93FA0B9B5899AC7D4FDB37ACAF" + var_2;
  level._id_12E76._id_1472A[var_6] = var_5;
}

_id_131FB() {
  badpathnodes((-250, -4000, 0), (0, 0, 0), 0, 400, 512);
  badpathnodes((-1500, -4000, 0), (0, 180, 0), 1, 800, 256);
  badpathnodes((-3350, -4000, 0), (0, 210, 0), 2, 1000, 128);
}

_id_131FC() {
  badpathnodes((38394, -26884, -564), (0, 0, 0), 0, 600, 128);
  badpathnodes((22180, -32193, -440), (0, 0, 0), 1, 600, 128);
  badpathnodes((27591, 8805, -475), (0, 0, 0), 2, 400, 200);
  badpathnodes((27915, 37519, 714), (0, 0, 0), 3, 700, 250);
  badpathnodes((4470, 49274, 1036), (0, 0, 0), 4, 700, 128);
  badpathnodes((6754, 17467, -681), (0, 0, 0), 6, 600, 350);
  badpathnodes((30407, -8705, -412), (0, 0, 0), 7, 800, 400);
  badpathnodes((-20524, 22013, -448), (0, 0, 0), 8, 800, 600);
  badpathnodes((-26038, -10377, -38), (0, 0, 0), 11, 800, 250);
  badpathnodes((-7972, -11756, 348), (0, 0, 0), 12, 800, 150);
  badpathnodes((-20746, -28231, -145), (0, 0, 0), 13, 700, 300);
  badpathnodes((9247, -23349, -224), (0, 0, 0), 14, 700, 250);
  badpathnodes((50830, 3161, 31), (0, 0, 0), 15, 700, 128);
  badpathnodes((51432, -17940, -392), (0, 0, 0), 16, 400, 128);
  badpathnodes((-4093, -30507, 318), (0, 0, 0), 17, 1000, 128);
  badpathnodes((-20758, 7765, -226), (0, 0, 0), 18, 600, 250);
}

_id_135C5() {
  var_0 = put_players_out_of_black_screen();

  if(isDefined(var_0))
    level thread[[var_0]]();

  foreach(var_2 in level._id_12E76._id_1472A) {
    var_3 = _id_135C4(var_2.origin, var_2.angles, var_2.radius, var_2.height);
    var_3.id = var_2.id;
    level._id_12E76.zones[level._id_12E76.zones.size] = var_3;
  }
}

tank_x1() {
  level.disable_super_in_turret._id_12E6D = [400, 500, 600, 700, 750, 800, 900, 1000];
  level._effect["_encstr_BE5E126428D279131ED5F2B75558F8F2FFDAD76A"] = loadfx("_encstr_A1E6378504D20A49A06A978BCAE5E7F980E52BF5E7C878FB652B8F033796FA2168D2EA210FDB550651E1C62F62C18F78158F8BE21F5F0932A2");
  level._effect["_encstr_88A51A9FEB9BF7D25A8CF108551F3A8749F2A25839374A97F5E3BA58"] = loadfx("_encstr_AF8D46BBEF7802CBF36A2F5D6B5E04C8BD87E37056594A732BE7437D7226D43850910BA93FAD1132C2E34B170BAA1E70E135B360E913E8EE3AF3B30F2E27471A870FF9FBCB6A2023");
  level._effect["_encstr_B4CC19CEE183BE6E16CC95AFD3DBCDACBE0D60C07DBD2785CDEC59"] = loadfx("_encstr_87AB457EC5C8C5B7AC1AD10A7BA8D70E08BBF0FC63780D7B54A94AD20BF05B0778678B79F570A94B702042C9AB3D73FF189D03CB6F186CA32E585AB15BAF322291779A49B590B7");
  level._effect["_encstr_A57519770AC189CE1B1745C745A0226BCF3132B16823729B50884B"] = loadfx("_encstr_9B62459E252825574CFAF12A5B88B76E289B101C43586D1B7449AAF26BD0BBE75807AB99D510896B10CDA2E98BDD53DFF8FD23EB0FF84C83CE38BAD17B8F1202B17BAD6491F013");
  level._effect["_encstr_835E1279481389AFD242C7B7C318A0E706425F21"] = loadfx("_encstr_A1E6378504D20A49A06A978BCAE5E7F980E52BF5E7C878FB652B8F033796FA2168D2EA210FDB550651E1C62F62C18F78158F8BE21F5F0932A2");
  level._effect["_encstr_88CC1A3F7BA917E38BEEA5C812AA05C9CF350AAA4104B39F8C1DFFEB"] = loadfx("_encstr_AF8D46BBEF7802CBF36A2F5D6B5E04C8BD87E37056594A732BE7437D7226D43850910BA93FAD1132C2E34B170BAA1E70E135B360E913E8EE3AF3B30F2E27471A870FF9FBCB6A2023");
  level._effect["_encstr_959519391B4FCF075AD4ADA182DFF5BFC117A851C05A454BB2816F"] = loadfx("_encstr_87AB457EC5C8C5B7AC1AD10A7BA8D70E08BBF0FC63780D7B54A94AD20BF05B0778678B79F570A94B702042C9AB3D73FF189D03CB6F186CA32E585AB15BAF322291779A49B590B7");
  level._effect["_encstr_93A9199D0FE0EB37C233B2EBD3F6CDB2EBA6C0C0FACB598D8DF6DD"] = loadfx("_encstr_9B62459E252825574CFAF12A5B88B76E289B101C43586D1B7449AAF26BD0BBE75807AB99D510896B10CDA2E98BDD53DFF8FD23EB0FF84C83CE38BAD17B8F1202B17BAD6491F013");
  level._effect["_encstr_A55E12C873EA4793876EBDB85A97F88B993FEAFA"] = loadfx("_encstr_A7E63730503006623428872D5E8850594197FFC0077897FBB6C33913A8F9EB1103F880EF3163593EB93A45EBFAB77EB4A30848733E776AB17A");
  level._effect["_encstr_BD951A0791E0B1A7DFB92A71C2201BF741A5E8D8472847FF7D13821B"] = loadfx("_encstr_A1D246ECCC0F5E2DBB1CEB26C9F2D92CD62B0736582F79A1BB2B56CD6497EC66E1AFCD0B332BF5A77BE62BEBCECAC93258B9CDADD78D5AE41BC6CAFAC46403C0F546B26EA3C9B7BC");
  level._effect["_encstr_A769199D0F1CAF6EC26695D7E97B9BACFA631881F5F64E0B73B3AC"] = loadfx("_encstr_9B9445CECC87794BDD83BE89C9BC3B2CADB20E8D0B97E51A77AC2B378CF2CE990F7D6E2CCC95BE9EED732BEBD9B2C91916E6CD6D7DC64BC9368D95AFC4641881F57B93C2B9EC59");
  level._effect["_encstr_A5B5197953D908E7027EB880BA074820495720917F6F216AC1F567"] = loadfx("_encstr_82FC4573D92BA64498596F5AA5328FE7D9D18B5A81036EFC40DB4D2E3D0A1333FB0E333289D5F730A82545179DB05A63AF804B1A36BEE7EAB0397D0FEB52F2FAD89AA2F2F8B727");
  level._effect["_encstr_B25E12809A6B614AF306CF69D21FE8CFAF0AE8D3"] = loadfx("_encstr_97E63713F8C2FF4237C33176CE5F7A79881883E3685AA7FB7DFB092ABFE5123F32E0034F01D32543411F4D2292EF4AC19B1883F769E3CC2F01");
  level._effect["_encstr_82E11A729B82D94EDF9FEB4F901DF85B11C433C8F9202B2AA358BF77"] = loadfx("_encstr_88F7463355AB9A7FEBC110EA660FBF0BF339B975B7185EB1DB8ACD63C2F6E3A6812793B99791375BA02D71F08DAF03E7779637A360184AD2B8E932E7035292572139D75F7B7A3D2B");
  level._effect["_encstr_91D819ECE1837DB958CCACFAD3EDB9CAFACDC00CEBB7C916B9762B"] = loadfx("_encstr_AA6245CE66E1794BDD0EBE899CCBCE0B6BAC83360BF2BC34BB59CA9B465EEC333CEB9B0B33B2F5A7DBCD59D7D9CAE43258B9B9B6EBC6D2E41B1BACFA9886060C7DBDE416B97659");
  level._effect["_encstr_B80619579890F1600677F5B1D817FDDFA7E7D80AF9E07F72DDB854"] = loadfx("_encstr_862745C3AF7397674BCAB13952808A4F614F52A3CF3BCF4073F267283E0605930BAFBB4387306F331022E96893DFDE8F3FB088DCA9E0805301B05159090F2A301780ABA1930FFB");
  level._effect["_encstr_915E1228930AA773A74E9D983AF798ABB90F221A"] = loadfx("_encstr_8BE6373D4B53409097E806B9622728AFFAAFA981EFEB1810DED00E934E5660C8231F1D2B7F43F5F8F4EE106BF407981BFB87E1A3E7DF65B258");
  level._effect["_encstr_8D491A9DE11CF5371633B2BE9EDB37ACAFE6D40CEB32CA9B8E27BDCB"] = loadfx("_encstr_8BE6373D4B53409097E806B9622728AFFAAFA981EFEB1810DED00E934E5660C8231F1D2B7F43F5F8F4EE106BF407981BFB87E1A3E7DF65B258");
  level._effect["_encstr_92B1196FAB6B094B47166747305750D2C6CAEB2086378B632567EF"] = loadfx("_encstr_8BE6373D4B53409097E806B9622728AFFAAFA981EFEB1810DED00E934E5660C8231F1D2B7F43F5F8F4EE106BF407981BFB87E1A3E7DF65B258");
  level._effect["_encstr_B8761944E8F34F83897BF02923AF78636943E57789DBF3A87C4758"] = loadfx("_encstr_8BE6373D4B53409097E806B9622728AFFAAFA981EFEB1810DED00E934E5660C8231F1D2B7F43F5F8F4EE106BF407981BFB87E1A3E7DF65B258");
  level._effect["_encstr_815E12775BBB1058A9577936789F88B5E1C25121"] = loadfx("_encstr_AAE63710C2B8F7806F8010F6A2660933A55A98482A103FBB13D81876899BB187C882E098216BD373F3E9986E6B57395332EA681099D2BD03FA");
  level._effect["_encstr_848D1A0F99E8B9BFC7B1D279DA2813EF39A1D0C0BF307FF7752B8A03"] = loadfx("_encstr_831946D5A36BD6B3B3405EC383F04C76010D78043969B58010EBF118659784CCD04812573CE219B0CFDEFF080D833BB9F9E88702BEF68178FEF555774B2B2709A962402BCC7DD0EA");
  level._effect["_encstr_AA3219EF505A3758E86A6359521778894E3847D74F881352BD0450"] = loadfx("_encstr_8F7745C3919877C2F4393FB3D5B06A716859FACDE9788F0ACCABDF8B7D6883AE6866B216E120B76328A5C757ED658BE458E82A1C7E7859DB7649CF5F8BB477080150E26630801D");
  level._effect["_encstr_871C193BC3C1F5B92C33ACD7A77B37CAD770810CF5CBB21BD8DBEE"] = loadfx("_encstr_ADA345B3CC3C79967707BE319C97D9855B95E0D885F2F2D0DD5695DC235E3B993CEBB90BCCACEBD3BD732BEBD9AC9319B0DC37B6AF8DA5936C8DCAF5C4D80303D7F2CA36C6F6DD");
  level._effect["_encstr_935E123B1E07D76E5833B2EB4FDBB9CA7D9C1881"] = loadfx("_encstr_85E637A30A8BF0288360EF8D32FD10AFA752FB68C22738281F08E7A74997D878536AB0F1C9C34540B7E9BDDF7B31A03BAB02887951B6238ADA");
  level._effect["_encstr_ACC31A417A8107A30B3DCFBF022DB05FC1D2313A3044E587FBD56740"] = loadfx("_encstr_814346360F716218032297EB0A40A1CA0AFFB7D1F743DFAB1F0D7525FFCF04F568A770890A77F11A98FB4157EBCD5261C90BDB223F72E15ECB886ABF3A700BCF70B13007133377DA");
  level._effect["_encstr_841019ECF038BE9B0B99CABE9EBDDCCAAF720CC0FAB7E4B09BCEAC"] = loadfx("_encstr_81C745CB99907FDAFC3147BBCD8862699041C2D59160B702D493D7937560BBA6606EBA1EE928BF1B20ADDF5F157D831C40D03264664041D30E51C76783BB6F300958EA6E388815");
  level._effect["_encstr_8FD619AF28DB8770A113D586D8A03E754FC73232B9634D60B10D5B"] = loadfx("_encstr_8163457B2920CF4A6CA1B74B5D38D2F9E0D1724561F0079244234703C5100B36F0FE2A8E79B82FEB90DD4FCF65ED136CD060A294F6F0D1A3FEC177D7132BFFF0796A5FDD083877");
  level._effect["_encstr_86B41329D8B83176C2432B571B0A30387F623B4B52"] = loadfx("_encstr_A9DD379B34F9FE79FBDA5FA3A0D82F42BBDD62952F4336AE21C067FF40A9E5694D606D4F98B52AD249E0ABF73866DB72F58E75C7606537589B");
  level._effect["_encstr_B69B1B9DF007F5370BCCB2F5D3BDB956BE1303C0607D46ACDC1DE4DE2F"] = loadfx("_encstr_8EC1464B5DB37EE1387AA1F62B22375281E3DBBB3B5B26A8103927FD0B4A6E9AE37F6F07AD8DE982A860DF89FB2092F23785E7577726F242E048D7815B62986F803927BFD9D65A11");
  level._effect["_encstr_95971ACE1E07BEDCB0CC56EBF4BDB9CAAFC4181806F5B7278537D956"] = loadfx("_encstr_9A94459BC9C02F6A4C81976B3D58B2D9C0319265419067B2A4C36763A530EB1690DECAAE1998CFCBF0FD6FAF45CD734CF0CD42B4D610B183DEE197B7F54F1FD05988BABE685845");
  level._effect["_encstr_8D9C1A9D1E077DCDC23356BEE9ED7395FA62180660BEF2B21B1BDE77"] = loadfx("_encstr_851645F394D347D89BD2879B72772966F97BCB34B6673620F73B8A26F5029DAD587756DA01BDFF88B022CD77FBC8C3A01F33B647991B347B531AE0E08A71625A17084F38713FFF");
  level._effect["_encstr_862719E12853E70F2A38609E5A881A4D780A5597C30392A6523367"] = loadfx("_encstr_BD8D3443EC1116810332878B98F0473AE3F54A7DC77B6ED82BF067B3B2D82E1261AF17F0378F631951E827D33009F549898FCDEB9429");
}

register_module_pause_unpause_funcs(var_0, var_1) {
  var_2 = "_encstr_A7B10FF7DB3B90D829D7F9B6F81F083561" + var_0;

  if(isDefined(var_1))
    var_2 = var_2 + "_encstr_BA4C02DF" + var_1;

  return var_2;
}

_id_140C6(var_0) {
  if(!scripts\engine\utility::array_contains(level.disable_super_in_turret._id_12E6D, var_0)) {
    var_1 = 0;
    var_2 = var_0;

    foreach(var_4 in level.disable_super_in_turret._id_12E6D) {
      var_5 = abs(var_0 - var_4);

      if(var_5 < var_2) {
        var_2 = var_5;
        var_1 = var_4;
      }
    }

    return var_1;
  }

  return var_0;
}

dangercircletick(var_0, var_1) {
  if(level.disable_super_in_turret._id_12E6B != 1) {
    return;
  }
  if(level.disable_super_in_turret._id_12E69 != 1) {
    return;
  }
  if(!isDefined(level._id_12E76.zones)) {
    return;
  }
  foreach(var_3 in level._id_12E76.zones) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_1 - var_3.radius + level.disable_super_in_turret._id_12E6A;
    var_5 = var_4 * var_4;

    if(isDefined(var_3) && distance2dsquared(var_3.origin, var_0) >= var_5)
      var_3 lb_impulse_dmg_threshold_mid();
  }
}

_id_135C4(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_2, var_3);
  var_4.angles = var_1;
  var_4.radius = var_2;
  var_4.height = var_3;
  var_4.health = level.disable_super_in_turret._id_12E73;
  var_5 = register_module_pause_unpause_funcs(var_2);
  var_4._id_14725 = spawnfx(scripts\engine\utility::getfx(var_5), var_0, (1, 0, 0), (0, 0, 1));
  triggerfx(var_4._id_14725);
  var_6 = (0, 0, 50);
  var_7 = scripts\engine\trace::ray_trace(var_0 + var_6, var_0 - var_6);
  var_4.cleanupexplosionleftovers = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7["_encstr_BD260953AA97E3F014279D"]);
  var_4.cleanupexplosionleftovers setModel("_encstr_9B5B1497E0594509D2E708F0331C40AB739184954E23");
  var_4.cleanupexplosionleftovers.angles = (var_7["_encstr_820E07FAE8780B3A4C"][0], var_1[1], var_7["_encstr_820E07FAE8780B3A4C"][2]);
  var_4.objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(var_4.objid, "_encstr_930B07BB1B6B3854FF", var_0);
  getbnetigrbattlepassxpmultiplier(var_4.objid, 4500, 5000);
  objective_setbackground(var_4.objid, 1);
  objective_icon(var_4.objid, "_encstr_9ACF29F31B0F62C856D003AFB0C9802AC3207BE171931AE55888BF17F8615A12A9CC026565DD621781507B");
  _func_421(var_4.objid, 1);
  scripts\mp\utility\trigger::makeenterexittrigger(var_4, ::_id_1254C, ::_id_12554);

  if(level.disable_super_in_turret.scavengerlootcacheused)
    var_4 thread _id_11CE0();

  return var_4;
}

_id_11CE0() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      _id_13ADA(var_0);
      sat_play_unfolding_sounds(var_0);

      if(self.health <= 0)
        lb_impulse_dmg_threshold_mid();
    }
  }
}

sat_play_unfolding_sounds(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_11E83) && self._id_11E83 > var_1) {
    return;
  }
  var_0 dodamage(level.disable_super_in_turret._id_12E6E, self.origin, var_0);
  self.health = self.health - level.disable_super_in_turret._id_12E70;
  self._id_11E83 = gettime() + level.disable_super_in_turret._id_12E6F * 1000;
  var_2 = undefined;

  if(self.health <= level.disable_super_in_turret._id_12E73 * level.disable_super_in_turret._id_12E75)
    var_2 = "_encstr_957407BAC223B9F05B";

  if(self.health <= level.disable_super_in_turret._id_12E73 * level.disable_super_in_turret._id_12E74)
    var_2 = "_encstr_B8BC07D01BBF370877";

  if(isDefined(var_2)) {
    if(!isDefined(self.is_station_track_available) || isDefined(self.is_station_track_available) && self.is_station_track_available != var_2) {
      if(var_2 == "_encstr_957407BAC223B9F05B")
        playsoundatpos(self.origin, "_encstr_B8F22040738197B0BB37D6C7E61FFB41F68AE021AB62D3E8F7395DCBF70B2631DD53");
      else if(var_2 == "_encstr_B8BC07D01BBF370877")
        playsoundatpos(self.origin, "_encstr_96F220A6EAE7717F3B5928B0A2973FEB7763BDB0448B79B5A20208882A6DAF80DF0C");

      if(isDefined(self._id_14725)) {
        self._id_14725 delete();
        self._id_14725 = undefined;
      }

      self.is_station_track_available = var_2;
      var_3 = register_module_pause_unpause_funcs(self.radius, var_2);
      self._id_14725 = spawnfx(scripts\engine\utility::getfx(var_3), self.origin, (1, 0, 0), (0, 0, 1));
      triggerfx(self._id_14725);
    }
  }
}

lb_impulse_dmg_threshold_mid() {
  if(isDefined(self._id_14725)) {
    self._id_14725 delete();
    self._id_14725 = undefined;
  }

  objective_delete(self.objid);

  if(isDefined(self.cleanupexplosionleftovers))
    self.cleanupexplosionleftovers delete();

  var_0 = getarraykeys(self.triggerenterents);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = self.triggerenterents[var_2];
    _id_12554(var_3, self);
  }

  var_4 = register_module_pause_unpause_funcs(self.radius, "_encstr_AFCB082AC1D6A3EA7B73");
  playFX(scripts\engine\utility::getfx(var_4), self.origin, (1, 0, 0), (0, 0, 1));
  playsoundatpos(self.origin, "_encstr_9272153280AFD7B7CB508B91D4711FDA7BB0CA7950994A");
  self delete();
}

_id_13ADA(var_0) {
  if(level.disable_super_in_turret.scavengerlootcacheused) {
    playsoundatpos(var_0.origin, "_encstr_8B721579AA673B882337B79BFB3ACE83F1460156D78DC8");
    var_1 = var_0.origin - self.origin;
    var_2 = self.radius + 400 - length2d(var_1);
    var_1 = vectorNormalize((var_1[0], var_1[1], 0));
    var_3 = var_1 * var_2;
    var_4 = var_0 getEye();
    var_5 = var_4 + var_3;
    var_6 = var_5;
    var_7 = var_0 _encstr_85332FC8DF2260A903E2A0993AEEDF29957F78CB7BCDFBDF4ACA909456221333D94348B9BF78D307E274F0A6EB2E6F1B2B::chase_hvt_vo(var_5, var_4, var_1, undefined, undefined, 1);

    if(isDefined(var_7)) {
      var_8 = getrandomextractunlockablelootid(var_7);

      if(!var_8)
        var_7 = undefined;
    }

    if(isDefined(var_7)) {
      return;
    }
    var_9 = 45;
    var_10 = 1;
    var_11 = vectortoangles(var_1);

    for(var_12 = 1; !isDefined(var_7) && var_12 <= level.disable_super_in_turret._id_12E68; var_12++) {
      var_11 = (var_11[0], var_11[1] + var_9 * var_10, 0);
      var_13 = anglesToForward(var_11);
      var_5 = var_4 + var_13 * var_2;
      var_7 = var_0 _encstr_85332FC8DF2260A903E2A0993AEEDF29957F78CB7BCDFBDF4ACA909456221333D94348B9BF78D307E274F0A6EB2E6F1B2B::chase_hvt_vo(var_5, var_4, var_13, undefined, undefined, 1);

      if(isDefined(var_7)) {
        var_8 = getrandomextractunlockablelootid(var_7);

        if(!var_8)
          var_7 = undefined;
      }

      var_9 = var_9 + 45;
      var_10 = var_10 * -1;
    }

    if(isDefined(var_7)) {
      return;
    }
    var_12 = 1;
    var_3 = (0, 0, 1000);

    for(var_4 = var_0 getEye(); !isDefined(var_7) && var_12 < level.disable_super_in_turret._id_12E68; var_12++) {
      var_5 = var_5 + var_3;
      var_1 = vectorNormalize(var_5 - var_4);
      var_7 = var_0 _encstr_85332FC8DF2260A903E2A0993AEEDF29957F78CB7BCDFBDF4ACA909456221333D94348B9BF78D307E274F0A6EB2E6F1B2B::chase_hvt_vo(var_5, var_4, var_1, undefined, undefined, 1);
    }
  }
}

getrandomextractunlockablelootid(var_0) {
  var_1 = 40;
  var_2 = length2dsquared(var_0 - self.origin);
  var_3 = (self.radius + var_1) * (self.radius + var_1);
  return var_2 > var_3;
}

_id_1254C(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(!var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    level._id_12E76._id_12E62 = scripts\engine\utility::array_add(level._id_12E76._id_12E62, var_0);
    var_0 visionsetnakedforplayer("_encstr_A1C411915857C1C12AC9D84032078F7B07F32D", 0.2);
    playfxontagforclients(scripts\engine\utility::getfx("_encstr_862719E12853E70F2A38609E5A881A4D780A5597C30392A6523367"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
    var_0.setcheckliststateforteam = isDefined(level.disable_super_in_turret._id_12E72) && level.disable_super_in_turret._id_12E72 <= 0;
    _encstr_9A1F34B98D3996838EB9BCAD07793B85DAB2D15E1CAC9B7913E4AFEC0BADB2D12F1C2BF59DE11CAF36860B1B3695379DB2CD8B9D37B1::_id_11FEE(var_0, var_1);
    var_0 playsoundtoplayer("_encstr_A2F117ADA399DC080EA9EBA10FC5308FD25F2B4F97F21D1022", var_0);

    if(isDefined(var_0._id_12E66)) {
      var_0._id_12E66 stoploopsound();
      var_0._id_12E66 delete();
    }

    var_0._id_12E66 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    var_0._id_12E66 linkTo(var_0);
    var_0._id_12E66 hide();
    var_0._id_12E66 showtoplayer(var_0);
    var_0._id_12E66 playLoopSound("_encstr_ADD714E2CD197F802DB108974CB96FFF6E93C3670CB3");
  } else {
    var_2 = gettime();

    if(!isDefined(var_0._id_12E71) || var_0._id_12E71 < var_2) {
      var_3 = getdvarint("_encstr_87A81F7BCF98D99B2EF6133AF98D37C818ADE5E31F88DC67568BE953A0C837C4C8", 45);
      var_4 = getdvarint("_encstr_8BA81F731E7AB161E3198669F1BBB720673B4706B1E7112AB35CDE1D4A3820D7F2", 60);
      var_5 = var_3 * 1000;
      var_6 = var_4 * 1000;
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_9BA013575BA4C2CF5868E52F865830BA86D95FCBDF", var_0);
      var_0._id_12E71 = var_2 + randomintrange(var_5, var_6);
    }
  }
}

_id_12555(var_0) {
  stopfxontagforclients(scripts\engine\utility::getfx("_encstr_862719E12853E70F2A38609E5A881A4D780A5597C30392A6523367"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
  wait 0.5;

  if(isDefined(var_0))
    stopfxontagforclients(scripts\engine\utility::getfx("_encstr_862719E12853E70F2A38609E5A881A4D780A5597C30392A6523367"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
}

_id_12554(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(!var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() || isDefined(var_0._id_12E66)) {
    var_0 visionsetnakedforplayer("_encstr_B40101", 0.2);
    var_0 thread _id_12555(var_0);
    var_0.setcheckliststateforteam = 0;
    level._id_12E76._id_12E62 = scripts\engine\utility::array_remove(level._id_12E76._id_12E62, var_0);
    var_0 playsoundtoplayer("_encstr_ABCE169827D776F6CEAF9BC23395CD38586CCABE95872D8E", var_0);

    if(isDefined(var_0._id_12E66)) {
      var_0._id_12E66 stoploopsound();
      var_0._id_12E66 delete();
      var_0._id_12E66 = undefined;
    }
  }
}

_id_12E78() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_96DE1F4632B3476A5B277240E1CA812B9766E5CBE93088481EC5AFF36FCEB5802D", 45);
  var_1 = getdvarint("_encstr_8EDE1FB9C64EEB4CC9EBB90B3356D73DEDCDAC37FAA15DB6B0CDBE3BDEBEB685E1", 60);
  var_2 = var_0 * 1000;
  var_3 = var_1 * 1000;

  for(;;) {
    var_4 = gettime();
    var_5 = [];

    foreach(var_7 in level._id_12E76._id_12E62) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(!isalive(var_7)) {
        continue;
      }
      if(var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
        continue;
      }
      if(!isDefined(var_7._id_12E79) || var_7._id_12E79 < var_4) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A65213DF59AF1880C3D2D0B9F9A34D8086BE7F5DCF", var_7);
        var_7._id_12E79 = var_4 + randomintrange(var_2, var_3);
      }

      var_5[var_5.size] = var_7;
    }

    level._id_12E76._id_12E62 = var_5;
    waitframe();
  }
}