/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58297.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_83AD0559672E3A"] = ::init;
}

init() {
  build_vehicle_drop_off_list();
  precachemodel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  precachemodel("_encstr_AAB9203456588CAFE4EADC6EB416CD7D58C96BF2F5EC856EADC2375BEB62BE851BE8");
  precachemodel("_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B");
  precachemodel("_encstr_99271388FF0E28DF92EB3F67276917109F95F020A7");
  level._id_14538 = loadfx("_encstr_86DB413BCCF0F24B77707DB6C15E3A9C4BC2D8E69799D8FA8356A339EDECE42C46BCD9331EAF8EE42D2C8DDCD76C43B2D9BE5AE6C2B1A3969DB2BECEE4AC5E17D9331E");
  level._id_14534 = loadfx("_encstr_8114412346D83FD73F3A1798B38AA3DB504E73F26EC7DC6E437B2390777A4A6F22408B2503CE149BAAD1A18809C6503F250613BBCB6853479F1B5D7871F0074DDBD27A");
  level._id_14535 = loadfx("_encstr_81CB42CB99907FDAFC314787C988537AB0C1C5125898F471579393E3CF44FBA18060FBDF2AF9949B23B3FBEF477E221DF8F6366520D844A28543C36725913B55827BEF28");
  level._id_14536 = loadfx("_encstr_AC39379DCCF0BC967783FA5B1C5EA39CB40B63CDBC998DBE0756D1E4EDD99CC2325EEC33E17DD1C9B48563CDFACCD8169DC4C29BCA713BCC87");
  level.plunder_initrepositories = loadfx("_encstr_9A7C3CCECCC3CB96EEE0FA5B835E3A394B2C1BB9CBCCB1F5E0561D27BDD9E48519979D660F7D8EE4B4C236CDAFB3B037BE53CA3ABEDC1D1639A371EC3387");
  level.plunder_registerrepositoryinstance = loadfx("_encstr_9A4C42360C32866CDFEAD1CA9057E33BC867A4CB305933B9B9686B33802F5A2F01F8265633061B3A5350F23B1977D6AFDEB6B4C7CDC96FC57B734A52582F4D8718A40658");
  level.plunder_removeanchoredwidgetfromrepositoryinstance = loadfx("_encstr_97FD33EC330FF2D2EE079763AC67B21BE58D58381DA5CECA976733C3AFB1071DF53B58DCD736B1F65D8CEB63D2DCCE569C8B9DCC1E");
  level._id_11C15 = loadfx("_encstr_AD6E2C3B99877936DEE495972BE25DB407B556B9D1793B330FBE2CA3AF5BA59BACEBD8D2CE34D1AF593717CECC87");
  level._id_11C14 = loadfx("_encstr_B4242C1DBC1E2DF333237F0919C607D2A7F998BAC7B0096E535E88714B2BE8B5305078961528ED107EA9DAED4C08");
  level._id_11C12 = loadfx("_encstr_8CA92FB358625FE2976351D5AFFFFAC96B98234728D85CCE977DB50B9C391167B14827F73A568583C9E06FC3F5AD7B2E7A");
  level._id_11C13 = loadfx("_encstr_937E2EFCAE2B28030B5F1980F335C33BF75907F905CB0BC7F552A8D8FEBB8D5207F98D7895BFF0AB51FA1078C6D3B5AA");

  if(!isDefined(game["_encstr_8CA606F38878410D"]))
    game["_encstr_8CA606F38878410D"] = [];

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]))
    game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] = level.trial["_encstr_A67009D77B23ABF02883D0"];

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"]))
    game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = 0;

  level.set_force_aitype_suicidebomber = [];
  level._id_1453F = 0;
  level._id_13B67 = 0;
  level.timeelapsed = 0;
  level.totaltime = 0;
  level._id_11F8E = 0;
  level._id_11B77 = 59999900;
  level.battlechatterenabled = 0;
  level scripts\engine\utility::flag_init("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  level scripts\engine\utility::flag_init("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  level scripts\engine\utility::flag_init("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level scripts\engine\utility::flag_init("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
  level scripts\engine\utility::flag_init("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");

  if(!isDefined(level.node_is_valid))
    level.node_is_valid = getEntArray("_encstr_8F1B0ECD900917C027088B92C0AD3F93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.node_is_valid.size != 0)
    scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");

  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "_encstr_AAB9203456588CAFE4EADC6EB416CD7D58C96BF2F5EC856EADC2375BEB62BE851BE8";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B";
  waitframe();

  if(isDefined(level._id_13D57)) {
    while(level._id_13D57 == 0)
      waitframe();
  }

  thread trial_start_init();
  thread player_init();
  thread hud_init();
  thread dialog_init();
  thread enemies_init();
  var_0 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getnodearray("_encstr_B8C809C3F5BF6B6D9093AF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = getnode(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_6 = scripts\engine\utility::array_combine(var_1, var_2);

  if(isDefined(var_0)) {
    foreach(var_8 in var_6) {
      if(isDefined(var_8.origin)) {
        var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8.origin);
        var_9 clonebrushmodeltoscriptmodel(var_0);
        var_9 disconnectPaths();
        var_8 disconnectnode();
        var_9 notsolid();
      }
    }
  }

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  level.nosuspensemusic = 1;
}

trial_start_init() {
  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  _id_1453C();

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == 3)
    wait 3.5;

  _tablethide::_id_13D88();
  _tablethide::_id_13D89(0);
  wait 7.5;
  level scripts\engine\utility::flag_set("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  thread player_set_weapon();

  switch (level.trial["_encstr_B6A208B3C2275AC2B9E8"]) {
    case "_encstr_BD78059C33C543":
      level.dogtags = scripts\engine\utility::getStructArray("_encstr_A73A148E9C4BB08DFADD2CCB077BD237E8AF999CCA2B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      thread _id_1453D();
      break;
    default:
      thread _id_1453E();
      break;
  }

  thread player_monitor_death();
  thread set_ending_pack();
  var_0 = getEnt("_encstr_AD1E168EC92D0BD8AFD14EEAB1B6F546DBBD4EF536CACCE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_83AD1755EE313A7CB9ABAA836A5BF94D3865BBD780126F2A41", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 playsoundonmovingent("_encstr_99C61AE8392DB036EB6E66E1AF197BBD9CBEE89CEAB1D6BEB1AC33D1");
  var_1 playsoundonmovingent("_encstr_95D41B63465392E4660803435139AF3A3D48EB9AADEF8A0F2B300F0B60");
  var_2 linkTo(var_0);
  var_3 linkTo(var_1);

  if(!isDefined(level._id_13D83))
    level._id_13D83 = 150;

  var_1 rotateYaw(level._id_13D83, 2);
  var_0 rotateYaw(level._id_13D83 * -1, 2);
}

_id_1453C() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = level.trial["_encstr_B6A208B3C2275AC2B9E8"];

  if(!isDefined(level._id_14540))
    level._id_14540 = scripts\engine\utility::getStructArray("_encstr_8F3110B5121A4B08DFA778A0A337609D73F1" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  level._id_1453B = [];

  foreach(var_2 in level._id_14540) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_3.angles = var_2.angles;
    var_3.targetname = "_encstr_B429153DB9C53DC5B486190F15FF8953F7E9989AF7B009";

    if(isDefined(var_2.script_index))
      var_3.script_index = var_2.script_index;
    else if(isDefined(var_2.script_noteworthy))
      var_3.script_index = var_2.script_noteworthy;

    var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    if(isDefined(var_2.script_noteworthy))
      var_3.script_noteworthy = var_2.script_noteworthy;

    level._id_1453B[int(var_3.script_index)] = var_3;
  }
}

_id_1453D() {
  level scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  var_0 = 0;

  foreach(var_2 in level.dogtags) {
    var_2 thread _id_13533(var_2, level.player, var_0);
    var_2 thread _id_135A8();
    var_0++;
  }

  while(level._id_1453F < level._id_1453B.size)
    wait 0.05;

  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
}

_id_1453E() {
  level scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  var_0 = _id_13563();
  var_1 = undefined;
  waitframe();

  for(var_2 = 0; var_2 < level._id_1453B.size; var_2++) {
    waitframe();

    if(var_2 + 1 == level._id_1453B.size) {
      var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_1453B[var_2].origin);
      var_3.angles = (level._id_1453B[var_2].angles[0] - 90, level._id_1453B[var_2].angles[1], level._id_1453B[var_2].angles[2]);
      var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      waitframe();
      playFXOnTag(level._id_14536, var_3, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    }

    if(isDefined(level._id_1453B[var_2 + 1]))
      playFXOnTag(level._id_14538, level._id_1453B[var_2 + 1], "_encstr_A2B40B8A283A7DD3254A1D4A27");

    waitframe();
    killfxontag(level._id_14538, level._id_1453B[var_2], "_encstr_A2B40B8A283A7DD3254A1D4A27");
    playFXOnTag(level._id_14534, level._id_1453B[var_2], "_encstr_A2B40B8A283A7DD3254A1D4A27");
    level._id_1453B[var_2] thread _id_135A8();
    waitframe();
    var_0 moveTo((level._id_1453B[var_2].origin[0], level._id_1453B[var_2].origin[1], level._id_1453B[var_2].origin[2] + 30), 1, 0.1, 0.3);
    level._id_1453B[var_2] _id_14539();

    if(var_2 == 0)
      killfxontag(level._id_14536, level._id_1453B[0], "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }

  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  setheadiconimage(level._id_14537);
}

_id_14539() {
  for(;;) {
    var_0 = distance(self.origin, level.player.origin);
    var_1 = abs(self.origin[2] - level.player.origin[2]);

    if(var_0 < 80 && var_1 < 24) {
      break;
    } else
      wait 0.05;
  }

  if(!scripts\engine\utility::flag("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6"))
    level scripts\engine\utility::flag_set("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");

  level._id_1453F++;
  killfxontag(level._id_14534, self, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  playFXOnTag(level._id_14535, self, "_encstr_A2B40B8A283A7DD3254A1D4A27");

  if(level._id_1453F < level._id_1453B.size)
    level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");

  self notify("_encstr_84DD08530D6A3A8AE528");
  thread spawn_soldiers_in_convoy_truck();
  var_2 = isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_96130C8BB30F1F5D311BB6853338";
  var_3 = isDefined(self.script_index);

  if(var_2 || var_3) {
    foreach(var_5 in level.node_is_valid) {
      if(int(var_5.script_index) == int(self.script_index))
        var_5 notify("_encstr_8F5C086405E70FBA4B4A");
    }
  }

  level.player setclientomnvar("_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 0);
}

_id_13533(var_0, var_1, var_2) {
  var_3 = 14;
  var_4 = (0, 0, 0);
  var_5 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_5 = var_0 getworldupreferenceangles();
    var_4 = anglestoup(var_5);

    if(var_4[2] < 0)
      var_3 = -14;
  }

  var_6[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_6[0] setModel("_encstr_8CFD1ADD63D0EC6B0F8B5B2151506FE30BD75B679BE060FFA620938A");
  var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(var_4[2] < 0)
      var_6[0].angles = var_5;
  }

  var_8 = "_encstr_9A19040BCDBC";
  var_9 = scripts\mp\gameobjects::createuseobject(level.player.team, var_7, var_6, (0, 0, 16));
  var_9.victim = var_0;
  var_9.victimteam = level.player.team;
  var_10 = var_0.origin + (0, 0, var_3);
  var_9.trigger.origin = var_10;
  var_9.visuals[0].origin = var_10;
  var_9.attacker = var_1;
  var_9.attackerteam = var_1.team;
  var_9.ownerteam = scripts\engine\utility::get_enemy_team(level.player.team);
  var_9.visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6", undefined, var_2);
  scripts\mp\utility\outline::outlineenableforplayer(var_6[0], level.player, "_encstr_82A716507B33E9188325E8752AC741A151F388F0520E3151", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_7 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_9 notify("_encstr_85DE0B77B48D8D23591B95E895");

  if(!scripts\engine\utility::flag("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6"))
    level scripts\engine\utility::flag_set("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");

  level._id_1453F++;

  if(level._id_1453F < level._id_1453B.size)
    level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");

  self notify("_encstr_84DD08530D6A3A8AE528");
  thread spawn_soldiers_in_convoy_truck();
  var_11 = isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_96130C8BB30F1F5D311BB6853338";
  var_12 = isDefined(self.script_index);

  if(var_11 || var_12) {
    foreach(var_14 in level.node_is_valid) {
      if(int(var_14.script_index) == int(self.script_index))
        var_14 notify("_encstr_8F5C086405E70FBA4B4A");
    }
  }

  level.player setclientomnvar("_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 0);
  level.player playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
  var_9 thread scripts\mp\gameobjects::deleteuseobject();

  for(var_16 = 0; var_16 < var_9.visuals.size; var_16++)
    var_9.visuals[var_16] delete();
}

_id_135A8() {
  var_0 = undefined;

  switch (level.trial["_encstr_B6A208B3C2275AC2B9E8"]) {
    case "_encstr_BD78059C33C543":
      var_0 = "_encstr_973E1461B6E8BB2923B80A72B013DAC72128F7F4DFB1";
      break;
    default:
      var_0 = "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9";
      break;
  }

  var_1 = level._id_11F8E;
  level._id_11F8E++;
  objective_state(var_1, "_encstr_930B07BB1B6B3854FF");
  objective_position(var_1, self.origin);
  objective_setplayintro(var_1, 0);
  objective_icon(var_1, var_0);
  objective_setbackground(var_1, 1);
  objective_setfadedisabled(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setminimapiconsize(var_1, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_setshowdistance(var_1, 0);
  objective_ping(var_1);
  self waittill("_encstr_84DD08530D6A3A8AE528");
  objective_delete(var_1);
}

_id_13563() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level._id_14537 = deleteheadicon(var_0);
  setheadiconfriendlyimage(level._id_14537, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  setheadiconzoffset(level._id_14537, 1);
  setheadiconsnaptoedges(level._id_14537, 0);
  setheadicondrawthroughgeo(level._id_14537, 1);
  return var_0;
}

set_ending_pack() {
  level scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  level.player endon("_encstr_AD75063D571AE108");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.player.origin);
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 setentityowner(level.player);
  var_0 setotherent(level.player);
  level.set_force_aitype_suicidebomber = getEntArray("_encstr_AF9F125BFE293FA22B2BE85F68619FCB5FCF95D7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_1 = 0;
    var_2 = updatematchstatushintonhasflag();

    if(var_2 == 1) {
      if(!scripts\engine\utility::flag("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6"))
        level scripts\engine\utility::flag_set("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");

      var_3 = gettime();
      level.player playSound("_encstr_9B2017BDC63A5785BED74D9A778A753260F5CBEF2BF1D2F81B");
      thread set_force_aitype_riotshield();
      var_4 = 0;

      while(var_2 == 1) {
        if(var_4 == 0) {
          level.player dodamage(22, level.player.origin, level.player, var_0, "_encstr_9B0D099AD3887D91252954");
          level.player playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
        }

        wait 0.05;
        var_2 = updatematchstatushintonhasflag();
        var_4++;

        if(var_4 >= 15) {
          var_4 = 0;
          level.player notify("_encstr_8FDD0F68C033617F1FBE73CC2A14F7B67F");
        }
      }

      level.player thread scripts\mp\equipment\gas_grenade::gas_removeblur();
      var_5 = gettime();
      var_1 = var_5 - var_3;
      level._id_13B67 = level._id_13B67 + var_1;
    }

    waitframe();
  }
}

set_force_aitype_riotshield() {
  level.player playsoundtoplayer("_encstr_AC1F11299EBB31F7125F13233B09B66855F730", level.player, level.player);
  level.player scripts\common\utility::allow_jump(0);
  level.player thread scripts\mp\equipment\gas_grenade::gas_applyblur();
  level.player thread scripts\mp\equipment\gas_grenade::gas_applycough();
  wait 1.25;
  level.player scripts\common\utility::allow_jump(1);
  level.player thread scripts\mp\equipment\gas_grenade::gas_removecough(0);
}

updatematchstatushintonhasflag() {
  var_0 = 0;

  foreach(var_2 in level.set_force_aitype_suicidebomber) {
    if(level.player istouching(var_2))
      var_0 = 1;
  }

  if(var_0 && level.player isonground())
    var_4 = 1;
  else
    var_4 = 0;

  return var_4;
}

player_set_weapon() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_861D13A3C9B48536BEECCCF0AFCE0BCDFA56B64BE8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::getStructArray("_encstr_9BDA158E93A516D8F5B3CC87BE9D0BB9F58DD2B9CEAC4E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\engine\utility::getStructArray("_encstr_9BCF18A3272DB0B1F5ECCC3CFAD9586EFA365ADC3B954EEB36B3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = getEntArray("_encstr_861D13A3C9B48536BEECCCF0AFCE0BCDFA56B64BE8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = getEntArray("_encstr_9BDA158E93A516D8F5B3CC87BE9D0BB9F58DD2B9CEAC4E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = getEntArray("_encstr_9BCF18A3272DB0B1F5ECCC3CFAD9586EFA365ADC3B954EEB36B3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_6 = scripts\engine\utility::array_combine(var_0, var_3);
  var_7 = scripts\engine\utility::array_combine(var_1, var_4);
  var_8 = scripts\engine\utility::array_combine(var_2, var_5);

  foreach(var_10 in var_7) {
    var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (var_10.origin[0], var_10.origin[1], var_10.origin[2] + 8));
    var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.05;
    thread plundercountdownupdatetime(level.plunder_removeanchoredwidgetfromrepositoryinstance, var_11, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }

  foreach(var_10 in var_8) {
    var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
    var_11.angles = var_10.angles;
    var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.05;
    thread plundercountdownupdatetime(level.plunder_registerrepositoryinstance, var_11, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }

  foreach(var_10 in var_6) {
    var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
    var_11.angles = var_10.angles;
    var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.05;
    scripts\engine\utility::play_loopsound_in_space("_encstr_AD8C13BCAB18EEDC30878AF8C74F869307ABB8BF5B", var_11.origin);
    thread plundercountdownupdatetime(level.plunder_initrepositories, var_11, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }
}

plundercountdownupdatetime(var_0, var_1, var_2) {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  for(;;) {
    while(distance2d(var_1.origin, level.player.origin) > 800)
      wait 0.25;

    playFXOnTag(var_0, var_1, var_2);

    while(distance2d(var_1.origin, level.player.origin) < 1000)
      wait 0.25;

    stopFXOnTag(var_0, var_1, var_2);
  }
}

player_init() {
  if(istrue(level._id_13D93))
    var_0 = undefined;
  else {
    switch (level.trial["_encstr_B6A208B3C2275AC2B9E8"]) {
      case "_encstr_A59306426009CA07":
        var_0 = "_encstr_87610AB4EE83FAD6374B3395";
        break;
      case "_encstr_A32D07CFD14BAA94D0":
        var_0 = "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F";
        break;
      case "_encstr_8D940738966ED1DB8D":
        var_0 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case "_encstr_BD78059C33C543":
        var_0 = "_encstr_87610AB4EE83FAD6374B3395";
        break;
      default:
        var_0 = undefined;
        break;
    }

    level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_0;
  }

  while(!isDefined(level.player))
    waitframe();

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);

  while(!isalive(level.player))
    waitframe();

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  thread hud_fade_to_black(4.1, 1);
  waitframe();
  level.player freezecontrols(1);

  if(istrue(level._id_125CA)) {
    level.player scripts\mp\equipment::giveequipment("_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381", "_encstr_BA7F0830B3A7859B60B0");
    level.player scripts\mp\equipment::incrementequipmentslotammo("_encstr_BA7F0830B3A7859B60B0", 1);
  }

  if(istrue(level._id_125CB)) {
    level.player scripts\mp\equipment::giveequipment("_encstr_92620B68531B9B432F2AE8D61B", "_encstr_BA7F0830B3A7859B60B0");
    level.player scripts\mp\equipment::incrementequipmentslotammo("_encstr_BA7F0830B3A7859B60B0", 1);
  }

  level.player.maxhealth = 250;
  level.player.health = 250;
  waitframe();

  if(isDefined(level._id_126A5)) {
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_126A5.origin);
    var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_1.angles = level._id_126A5.angles;
    wait 0.5;
    level.player playerlinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0);

    if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] >= 3)
      wait 8;
    else
      wait 0.5;

    level.player unlink();
  }

  level.player freezecontrols(1);
  level scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  wait 0.25;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.player.ignoreriotshieldxp = 1;
  level scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  while(!level.player isonground())
    wait 0.05;

  level.player freezelookcontrols(1);
  level.player freezecontrols(1);
}

player_monitor_death() {
  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 6.2);
  setdynamicdvar("_encstr_929A1D37B139AF8EC996581BF5C1C658E5B2C92756E6C185EECD23ACC6C297", 0);
  level.player waittill("_encstr_AD75063D571AE108");
  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 1.75);
  level.player setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");
  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level.player waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread hud_fade_to_black(4, 1);

  if(isDefined(level._id_126A5)) {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_126A5.origin);
    var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0.angles = level._id_126A5.angles;
    wait 0.5;
    level.player playerlinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0);

    if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] >= 3)
      wait 8;
    else
      wait 0.5;

    level.player unlink();
    level.player takeallweapons(0, 1);
    level.player giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  }
}

enemies_init() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  foreach(var_1 in level.node_is_valid)
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  if(level.player.team == "_encstr_8E8405EA382B2A")
    level.enemyteam = "_encstr_9A8507BA4040188D08";
  else
    level.enemyteam = "_encstr_8E8405EA382B2A";

  level.agent_definition["_encstr_A3DA1916B18EDEE4F5CACDACD6F2FA6B387DA393D20BC6D733B463"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;

  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  foreach(var_4 in level.node_is_valid) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy != "_encstr_96130C8BB30F1F5D311BB6853338")
      var_4.script_index = int(var_4.script_noteworthy);
  }

  thread no_aerial_munitions();
  scripts\engine\utility::array_thread(level.node_is_valid, ::enemy_individual_spawn);
}

enemy_individual_spawn() {
  self waittill("_encstr_8F5C086405E70FBA4B4A");
  var_0 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_A3DA1916B18EDEE4F5CACDACD6F2FA6B387DA393D20BC6D733B463", self.origin, self.angles);

  while(!isDefined(var_0))
    wait 0.05;

  var_0.grenadeammo = 0;
  var_0.a.disablelongdeath = 1;
  var_0 agentsetfavoriteenemy(level.player);
  var_0 thread nextbombplanttime();
  var_0 thread enemy_monitor_death();
  var_0 thread no_enemy_weapon_drops();
  var_0 thread no_jugg_early_exit();
  var_1 = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  var_2 = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(var_0.headmodel))
    var_0 detach(var_0.headmodel);

  var_0 setModel(var_2);
  var_0 attach(var_1, "_encstr_B40101", 1);
  var_0.headmodel = var_1;
  var_0 waittill("_encstr_938C091AC8B8AFFB036D37");
  level notify("_encstr_AF0D0F35E61F206341ABE0D042A31B187F");
}

nextbombplanttime() {
  while(isalive(self)) {
    wait 0.05;
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    scripts\engine\utility::array_contains(level.players, var_1);
    self kill();
    level.player thread _tablethide::_id_13D4B(self, 1, 0, 1);
  }
}

enemy_monitor_death() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  if(isalive(self)) {
    self waittill("_encstr_AD75063D571AE108", var_3, var_0, var_1, var_2);

    if(isalive(level.player))
      var_3 = scripts\engine\utility::array_contains(level.players, var_0);
    else
      var_3 = 0;
  } else
    var_3 = 0;

  if(var_3)
    level.player thread _tablethide::_id_13D4B(self, 1, 0, 1);

  level.player notify("_encstr_85980DA238454FA0F9DF7974F92B2F");
}

no_enemy_weapon_drops() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  while(isalive(self)) {
    self.dontevershoot = 0;
    self.bulletsinclip = 20;
    self.accuracy = 0.2;

    while(self.bulletsinclip > 12)
      wait 0.05;

    self.accuracy = 0.5;

    while(self.bulletsinclip > 3)
      wait 0.05;

    self.dontevershoot = 1;
    wait 0.5;

    if(isDefined(self))
      self playsoundonmovingent("_encstr_84FC1C0495382ECBD0EBEA1376150BE7A02B9A9DD16076D3E3A0F2691B76");

    wait 3.5;
  }
}

no_jugg_early_exit() {
  self endon("_encstr_AD75063D571AE108");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19"))
    wait 0.5;

  self.dontevershoot = 1;
  wait 5;

  if(isalive(self))
    self despawnagent();
}

no_aerial_munitions() {
  scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");
  var_0 = getEntArray("_encstr_970C0B4B3BD23140CFCDB068F7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2 setModel("_encstr_99271388FF0E28DF92EB3F67276917109F95F020A7");
    var_2 setCanDamage(1);
    var_2 thread ninetypercent_music();
    var_2 thread nexttrackindex();
  }

  scripts\engine\utility::flag_wait("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      playFXOnTag(level._id_11C15, var_2, "_encstr_998607A9D726BD6B4C");
  }
}

ninetypercent_music() {
  self endon("_encstr_9566112B571245016E5FA39B8249508BEBCFA1");

  for(;;) {
    var_0 = distance2d(self.origin, level.player.origin);
    var_1 = abs(self.origin[2] - level.player.origin[2]);

    if(var_0 < 140 && var_1 < 50) {
      break;
    } else
      waitframe();
  }

  var_2 = self.origin + (0, 0, 55);
  var_3 = 1;
  var_4 = magicgrenademanual("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", var_2, (0, 0, 0), var_3);
  killfxontag(level._id_11C15, self, "_encstr_998607A9D726BD6B4C");
  playFXOnTag(level._id_11C14, self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self moveTo(var_2, var_3 / 2, 0, var_3 / 3);
  self rotateby((0, 1080, 0), var_3);
  self playsoundonmovingent("_encstr_BACD11C3718D38A08352737B7B9F66A8E4D377");
  wait(var_3);

  if(level.player getstance() != "_encstr_922406F1A6FD5E05") {
    var_5 = 140 * level.player.maxhealth / 100;
    var_6 = 70 * level.player.maxhealth / 100;
    var_7 = 175;
    radiusdamage(var_2, var_7, var_5, var_6, self, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421");
  }

  playFX(level._id_11C13, var_2);
  level.player playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  self notify("_encstr_88610F9A4B951F3F910B4044A87BAF252D");
  self setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 1;
  self delete();
}

nexttrackindex() {
  self endon("_encstr_88610F9A4B951F3F910B4044A87BAF252D");
  self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  level.player scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
  killfxontag(level._id_11C15, self, "_encstr_998607A9D726BD6B4C");
  playFX(level._id_11C12, self.origin);
  self playsoundonmovingent("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");
  self notify("_encstr_9566112B571245016E5FA39B8249508BEBCFA1");
  waitframe();
  self delete();
}

hud_init() {
  level.score = [];
  _tablethide::trial_ui_set_reward_tier(game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  level.player setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
}

hud_objectives() {
  while(!isDefined(level._id_1453B))
    waitframe();

  _tablethide::trial_ui_set_objective_icon_index(0);
  _tablethide::trial_ui_set_objective_progress(level._id_1453F, level._id_1453B.size);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_BD8C0B47E93F129A06505FB720", 0, 0);

  while(!isDefined(level.player))
    wait 0.05;

  _tablethide::trial_ui_set_objective_progress(level._id_1453F, level._id_1453B.size);
  scripts\engine\utility::flag_wait("_encstr_97A40F4739960B637D074EB2B9D10BE43A");

  while(level._id_1453F < level._id_1453B.size) {
    spawn_soldiers_in_convoy_truck();
    wait 0.05;
  }

  spawn_soldiers_in_convoy_truck();
  level notify("_encstr_8F730B82D32028A1759BF7AFD5");
  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level notify("_encstr_B8D80D131723B292AB2759B2975BA0");
}

spawn_soldiers_in_convoy_truck() {
  _tablethide::trial_ui_set_objective_progress(level._id_1453F, level._id_1453B.size);
  var_0 = scripts\mp\utility\script::limitdecimalplaces(level._id_13B67 / 1000, 1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_BD8C0B47E93F129A06505FB720", level._id_13B67, var_0);
}

spawn_spawners_multi() {
  _tablethide::trial_ui_set_main_time(level.totaltime);
  _tablethide::trial_ui_set_subtime(level.timeelapsed);
}

hud_timer() {
  spawn_spawners_multi();
  level scripts\engine\utility::flag_wait("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  var_0 = gettime();

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_1 = gettime() - var_0;
    level.timeelapsed = int(var_1);
    spawn_spawners_multi();
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    level.timeelapsed = scripts\engine\math::round_float(level.timeelapsed / 1000, 1, 0) * 1000;
    level._id_13B67 = scripts\engine\math::round_float(level._id_13B67 / 1000, 1, 0) * 1000;
    level.totaltime = level.timeelapsed + level._id_13B67;
    spawn_spawners_multi();

    if(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] <= 0 || level.totaltime < game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"]) {
      game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] = level.totaltime;
      hud_besttime_update();
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_995E0F132B3747BE99D8DB7BC9D12DAD95"] = level._id_13B67;
    }
  } else {
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
    level.totaltime = -1;
  }

  if(istrue(level._id_13D6C)) {
    level.score["_encstr_BE7D0633C08849E2"] = level.totaltime;

    if(level.score["_encstr_BE7D0633C08849E2"] < level.trial["_encstr_816C069599555DA7"])
      wait 4;
  }

  level scripts\engine\utility::flag_set("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
}

hud_reward_tiers_tracking() {
  self endon("_encstr_8F730B82D32028A1759BF7AFD5");
  _tablethide::trial_ui_set_reward_tier_preview(3);
  self waittill("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  var_0 = [];
  var_0[0] = undefined;
  var_0[1] = level.trial["_encstr_816C069599555DA7"];
  var_0[2] = level.trial["_encstr_876C06B1FF0A66F2"];
  var_0[3] = level.trial["_encstr_966C066BF011B2F7"];

  for(var_1 = 3; var_1 >= 0; var_1--) {
    level.attempttier = var_1;
    _tablethide::trial_ui_set_reward_tier_preview(var_1);

    if(isDefined(var_0[var_1])) {
      while(level.timeelapsed < var_0[var_1] - 5000)
        wait 0.05;

      for(var_2 = 5; var_2 > 0; var_2--) {
        level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
        wait 1;
      }

      level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
    }
  }
}

hud_fade_to_black(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_2.alignx = "_encstr_A5AD056A019C63";
  var_2.aligny = "_encstr_AC190479FF92";
  var_2.sort = 1;
  var_2.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.foreground = 0;

  if(istrue(var_1)) {
    var_2.alpha = 1;
    var_2 fadeovertime(var_0);
    var_2.alpha = 0;
  } else {
    var_2.alpha = 0;
    var_2 fadeovertime(var_0);
    var_2.alpha = 1;
  }
}

hud_attempt_over() {
  level scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 1.75);

  while(!level.player isonground())
    wait 0.05;

  level.player freezecontrols(1);

  while(level.totaltime == 0)
    waitframe();

  var_0 = _tablethide::recentc4vehiclekillcount();

  if(!scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    var_1 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];

    if(var_0 > var_1) {
      game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = var_0;
      _tablethide::trial_ui_set_reward_tier(var_0);
      var_2 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_3 = randomint(var_2);
      level.player clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_3]);
    }

    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 0);
  } else if(scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 1);
    var_2 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_3 = randomint(var_2);
    level.player clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_3]);
    var_4 = 1.25;
    thread hud_fade_to_black(var_4);
    wait(var_4);
  }

  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 1);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 0);
  level scripts\engine\utility::flag_wait("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
  var_5 = scripts\mp\utility\script::limitdecimalplaces(level._id_13B67 / 1000, 1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_BD8C0B47E93F129A06505FB720", level._id_13B67, var_5);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_BD8C0B47E93F129A06505FB720", level._id_13B67, level._id_13B67);
  thread _tablethide::trial_ui_open_results_screen();
  level.player freezecontrols(1);
  level._id_13D60 = 1;
  _tablethide::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  var_6 = game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"];

  if(var_6 > 0) {
    setDvar("_encstr_BA7B0E75997A910B1F9FA8B8B76C43F3", "_encstr_AAEF05B83B43EB");
    level notify("_encstr_8F3F0DCF1F807A39380175B16B930B");
    level notify("_encstr_92DF0B127AF74B41D63488E317");
    level notify("_encstr_AAC30CB5E0384E6BD74B5D8BBBF8");
    game["_encstr_A1AD062E09D98338"] = "_encstr_877508C1D8C22F2DDC3B";
    _tablethide::_id_13D5E();
  } else {}
}

hud_besttime_update() {
  var_0 = game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"];
  var_1 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];
  _tablethide::trial_ui_set_best_time(var_0);
  _tablethide::trial_ui_set_reward_tier(var_1);
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_B8C313BA9B7F2389A31350A7FBAA5F47B8C85BE3EA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_A3F619A328A980787B4AB75A7B4F5A76E4C6D86B5FA917E3E8E0F9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_AC271743E841103D5BA390994BE765B1675EE9AF303278777B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962A15A3272DC2C6BECA9B46EB1D4B59397DC0F5C2B1E8"] = "_encstr_821C169932D9C98954D36830CB99615F225E82080F92A3D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_A501176B07BE8395D193ED769385197DB2DC23EBC4CDA3B039";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_BD7317A52931D247ED93129ABB4F9BC108ED240F05E89B1F96";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_878E175F0948E385789B151FF3B8CC693D5DE31F37866B7990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_8F2D16B6E0D71C563A39B73BE4C2C8AF67B7F539B2474EBC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88940A6696D8FADCD185C93A"] = "_encstr_875D1BD8730F57407B12879F3A661088A72AB0063A4F0459520CA3AD44";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEA50D33975CC6F973822EB3D1AB11"] = "_encstr_91F81BB6C17D83B24793BD3B4E0B19AFF64C35F5CDB03BBE0DEAE49CF2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_925E115278E9F9E728AB7D7C35163BBE0B50EA"] = "_encstr_92AE18EDAF99C289CD024F37704B2371C0603C4F03303A6B21A7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F8610335AD8AFB90D2DAC1B8CF5DC1DBDEE"] = "_encstr_91D915ADC1FAC1B21D4EED3B932C91BEB3DB7DD88DBA95";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_918916332D36AFBBC2A5E8AF95CDCAB5BC7D39CA63DB0B32"] = "_encstr_81EA16B5077D83951D9CBD7627588CBECEEDBEC6B1BAB2C8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96BE1209527310A0ADD97365C71688C6C7A9E333"] = "_encstr_8C601BD6E0F51CB28E39B7769C58197D7B139AEBDCC276BED2E63B2CDC";
  scripts\engine\utility::flag_wait("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_88940A6696D8FADCD185C93A");
  thread lgsplittransients();
  thread lgvadaptive();
  thread lgvmergesufix();
  thread lgwperifvfx_explosions();
  thread lgnoshadow();
}

lgsplittransients() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  var_0 = 0;
  var_1 = 0;

  if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_BD78059C33C543")
    var_2 = 14;
  else
    var_2 = 8;

  for(;;) {
    if(level._id_1453F == var_1)
      var_0++;
    else
      var_0 = 0;

    if(var_0 > var_2) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_BEA50D33975CC6F973822EB3D1AB11");
      var_0 = 0;
    }

    var_1 = level._id_1453F;
    wait 1;
  }
}

lgvadaptive() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  for(;;) {
    level waittill("_encstr_AF0D0F35E61F206341ABE0D042A31B187F");
    wait 0.5;
    var_0 = level.player getcurrentweapon();

    if(var_0.basename != "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1")
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_925E115278E9F9E728AB7D7C35163BBE0B50EA");
  }
}

lgvmergesufix() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  if(istrue(level._id_125CA)) {
    return;
  }
  for(;;) {
    level.player waittill("_encstr_85980DA238454FA0F9DF7974F92B2F");
    light_switch();
  }
}

light_switch() {
  level endon("_encstr_AF0D0F35E61F206341ABE0D042A31B187F");
  wait 1.5;
  var_0 = level.player getcurrentweapon();

  if(var_0.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1")
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8F8610335AD8AFB90D2DAC1B8CF5DC1DBDEE");
}

lgwperifvfx_explosions() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  var_0 = undefined;
  var_1 = level.player getweaponslistall();

  foreach(var_3 in var_1) {
    if(var_3.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1")
      var_0 = var_3;
  }

  if(isDefined(var_0)) {
    while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
      level.player waittill("_encstr_829B0FCF9CF8BF38D0CF8D3830E7B8F9A3");
      wait 0.3;
      var_5 = level.player getcurrentweapon();

      if(var_5.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1") {
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_918916332D36AFBBC2A5E8AF95CDCAB5BC7D39CA63DB0B32");
        wait 41;
      }
    }
  }
}

lgnoshadow() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    level.player waittill("_encstr_8FDD0F68C033617F1FBE73CC2A14F7B67F");
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_96BE1209527310A0ADD97365C71688C6C7A9E333");
    wait 4;
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D36;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_995E0F132B3747BE99D8DB7BC9D12DAD95"] = 0;
  }
}

_id_13D36() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_995E0F132B3747BE99D8DB7BC9D12DAD95"]);
  level.player dlog_recordplayerevent("_encstr_B4761F49ECA540D8E70BC990133705A07C79D1478B0DA8972BD2E3F9C993B75896", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_84EF055338A18F", var_2, "_encstr_8C6C0A97907FE7250B57B93D", var_3]);
}