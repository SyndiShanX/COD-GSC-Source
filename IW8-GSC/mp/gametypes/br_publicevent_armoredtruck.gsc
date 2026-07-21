/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_armoredtruck.gsc
********************************************************/

init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_8E621E3798D3A86EC321BB69513153BB97FA9D65A3A0BBA6B33763AD6F7AFA7B", 0);
  var_0._id_140CF = ::_id_140CF;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._id_14382 = ::_id_14382;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0._id_11B78 = getdvarint("_encstr_B186215780D3FF824DAFAAE76813FB85189087B3900B2D5A5738F59EE3475359E04047", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_AC540D92105BA5B3D95D1C12ED21EF", "_encstr_962128F267C186A8CB121A222213E0CEBB7DFE0E07693E70617A122A4ADBD8165357668637B1F6381BE2");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_AC540D92105BA5B3D95D1C12ED21EF");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(11, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A69F1D6845F7F112BFAF4E3F6B152333267057CA5A58650BD3E919C881705B"] = "_encstr_8CB21A6715EBE8BBB6815030DA0D49C3C7A9EE518CC3708FDD4A18A0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF3216C01D462F3A7BE0B3DAA091F2B739F2675B2D293BC3"] = "_encstr_B6E21A0385BEE89B5E1F2503E3A66BA8674AFA3D23E0AA76CDBFD6D7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5C0158365C162DB42278B23080B134B2BFAFE0F70066F"] = "_encstr_88D91C4017A2306B827915A4CF6A691B37DFD850FB6A684FCA1E9523E332";
}

_id_140CF() {
  return 1;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  var_0 = forest_combat();
  wait(var_0);
}

attackerswaittime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.callouts = [];
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_A3221C6E5AB9F3B81769ED5BDA0372F961AA03E69FA79B3D1EA7B3A71EC0");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A69F1D6845F7F112BFAF4E3F6B152333267057CA5A58650BD3E919C881705B");
  wait 3.5;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AF3216C01D462F3A7BE0B3DAA091F2B739F2675B2D293BC3");
  var_0 = getdvarfloat("_encstr_ADFE1D2B43AB484E0887286F38F203A5CF131D61135363716F5921B153B66B", 20.0);
  var_1 = getdvarfloat("_encstr_A2B8206E6C937D9827FAC12BAFC293B6BD9C2BC83A27EAD85BD719ABC90B1D4BED37", 10.0);
  var_2 = gettime() + var_0 * 1000;
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 7);
  setomnvar("_encstr_974F15AEB4D783BAC4B1A56C563B95B947BE1DB4D6CAC9", var_2);
  var_3 = run_post_module_actions();
  var_4 = run_spawnfuncs(var_3);
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_5 hide();

  if(var_0 > 5.0) {
    wait(var_0 - 5.0);

    for(var_6 = 0; var_6 < 5; var_6++) {
      var_5 playSound("_encstr_97D316BFD0B1F9B899E0E888AB198A9E8C176F7363585D5B");
      wait 1.0;
    }
  }

  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_givehcrdata();
  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_loadoutchangeremovehcr();
  level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DF8();

  foreach(var_8 in level.players)
  var_8 playsoundtoplayer("_encstr_A34A1B330AE72793D5E765B314B1F876970248FE127FE5802BC537A92A", var_8);

  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 0);
  var_5 delete();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A5C0158365C162DB42278B23080B134B2BFAFE0F70066F");
  wait 1.5;
  var_4 = scripts\engine\utility::array_randomize(var_4);
  thread _id_1360C(var_4);
}

run_post_module_actions() {
  var_0 = [];
  var_0[var_0.size] = createspawnlocation((-1424, 10054, 656), (0.0420106, 279.996, -0.133641));
  var_0[var_0.size] = createspawnlocation((889, 7451, 593), (0, 282, 0));
  var_0[var_0.size] = createspawnlocation((-4927, 867, 721), (360, 293, 0));
  var_0[var_0.size] = createspawnlocation((-2620, 4529, 706), (360, 270, 0));
  var_0[var_0.size] = createspawnlocation((2848, -66, 833.889), (359.885, 207.995, -0.0811529));
  var_0[var_0.size] = createspawnlocation((4115, -3919, 141), (0, 248, 0));
  var_0[var_0.size] = createspawnlocation((1645, -5835, 700), (0, 179, 0));
  var_0[var_0.size] = createspawnlocation((-956, -11298, 180), (0, 107.995, 0));
  var_0[var_0.size] = createspawnlocation((-2893, -5294, 700), (360, 315, 0));
  var_1 = [];
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();

  foreach(var_5 in var_0) {
    if(distance2d(var_5.origin, var_2) > var_3)
      var_0 = scripts\engine\utility::array_remove(var_0, var_5);
  }

  var_7 = randomintrange(2, 3);

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_9 = var_0[randomint(var_0.size)];
    var_1[var_1.size] = var_9;

    foreach(var_5 in var_0) {
      if(distance2d(var_9.origin, var_5.origin) < 7000)
        var_0 = scripts\engine\utility::array_remove(var_0, var_5);
    }

    if(var_0.size < 1) {
      break;
    }
  }

  return var_1;
}

createspawnlocation(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

forest_combat() {
  var_0 = getdvarfloat("_encstr_84FD2503B7E0A1F3466E8BC276177BE5B03D8D9CE18873CFE286B3DB99F63B1B689B05DF7B887D", 90);
  var_1 = getdvarfloat("_encstr_81FD253F57FB70F09A39FB51D1718891C28B9BA9A3A32DB0AB01838B464AF0551A1F0357BF3A73", 395);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

run_spawnfuncs(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_4 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_4 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_AB0703DBB9", 0);
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(11, 17, 2, var_3.origin);
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(1150);
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
    var_4.location = var_3;
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_1360C(var_0) {
  foreach(var_2 in var_0) {
    _id_1360B(var_2);
    wait 2.0;
  }

  level notify("_encstr_87A92278E31815B7A6F6724B99089B816895EDFF4598DF0BD6AB2A82A6DE43C6BB059D7C");
}

_id_1360B(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.location.origin + (0, 0, 5000);
  var_2 = _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_14263(var_1);

  if(isDefined(var_2)) {
    level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DE4(var_2, var_0.location.origin, var_0.location.angles, 1);
    level.callouts[level.callouts.size] = var_2;
  }

  thread _id_14235(var_2, var_0);
  thread _id_14248(var_0);
}

_id_14235(var_0, var_1) {
  var_0 waittill("_encstr_857C15BB4868015AA9C5A95D3445F2C256601B7BF08345");
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();
  var_1 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
  var_1 delete();
}

_id_14248(var_0) {
  while(isDefined(var_0)) {
    if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_0.location.origin)) {
      var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();
      break;
    }

    wait 1;
  }
}