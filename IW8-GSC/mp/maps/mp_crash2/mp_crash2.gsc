/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_crash2\mp_crash2.gsc
***********************************************/

main() {
  _redbuttonused_internal::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_8EDB318782956F91793A38D0131E999B500A2E4040F1D7F5C1287C2E404A483F7ECEA79A60F5C738B6077EB73073F19EEF63CA::main();
  _encstr_95B93047FA45986BD52AF7CDC7DF303810706FF271AFE9F8909B41CA22278B02561833674FC369A778AEC8AF06F07AAF87F0::main();
  _encstr_A19E2B523E7502E8133816073820BDCA094ECD4D1F877A1259100372AA4078D1876626428B85F14E4202070FF0::main();
  _encstr_A6413153E632087F0B9F07BBAB86C980E87A5068CAB7E03632F7810D3E4A8F299392012374A249E16ABF99993F225C6A2FAAC9::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_B23216932F98EA7F466BF9C2311F4F65C8E70B0A4B9BB40A", "_encstr_8A642036B7466CB0B9A356C9D736F65B1C0B9B37D7AD850EAF6B38EB36275837D023");
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 3);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 0.5);
  setDvar("_encstr_843D0BF7516E708C19BFBAF5D7", 0.5);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  setDvar("_encstr_83920A488F414D730D6721C8", 3.5);
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "_encstr_B807035284") {
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_8E8405EA382B2A";
  } else {
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  }

  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  level thread spawnstaticvan();
  level thread _id_13664();
  level thread player_fired_gun_monitor();
  level thread _id_121F5();
  level thread battle_tracks_vehicleoccupancyenter();
}

spawnstaticvan() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")) {
    return;
  }
  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    foreach(var_1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")]]()) {
      if(var_1.script_noteworthy != "_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2") {
        continue;
      }
      if(var_1.name != "_encstr_BDBB0616C6C186C2") {
        continue;
      }
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_91260B40A2EC2B91B36DA82E47"] = (1250, -2338, 65);
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_AF260B886A249329FB35F7680F"] = (0, 270, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")]]("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", "_encstr_BDBB0616C6C186C2");
      var_2 = getentarrayinradius("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009", (1250, -2150, 75), 300);

      if(isDefined(var_2))
        var_2[0].origin = var_2[0].origin + anglesToForward((0, 90, 0)) * -50;

      break;
    }
  }
}

_id_13664() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-340, 655, 240), 0, 192, 100);
  var_0 thread _id_144FF("_encstr_8BBB069F5C8399CB");
}

_id_144FF(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isDefined(self._id_126CE))
      self._id_126CE = [];

    if(scripts\engine\utility::array_contains(self._id_126CE, var_1.guid)) {
      continue;
    }
    self._id_126CE = scripts\engine\utility::array_add(self._id_126CE, var_1.guid);

    switch (var_0) {
      case "_encstr_8BBB069F5C8399CB":
        var_1 thread _id_14486(self);
        break;
    }
  }
}

_id_14486(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-370, -320, 100);
  var_4.radius = 330;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-370, -700, 100);
  var_4.radius = 330;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-370, -1000, 100);
  var_4.radius = 330;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-400, -1700, 60);
  var_4.radius = 550;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 200, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-912, 2072, 520));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(-912, 2072, 530)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_8E65062BD0CFB4EC":
    case "_encstr_85EF050CB150E7":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_8E9E088D9C58E65B2B19":
    case "_encstr_959105B99040BD":
    case "_encstr_B41904BB8593":
      level.modifiedspawnpoints["_encstr_816A0BCBFF0AFDE295E9A1AFF2"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8FAD0B915A33E29A55B698726A"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AF440B338E1AFA5AEEF218CB73"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_911F0BD2024EBB894E2A0F499F"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1440B329F32A9C17EE14BC4D8"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AB1F0B8625247F185A0B689313"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (1347, -2185, 80), (0, 100, 0));
      break;
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
      level.modifiedspawnpoints["_encstr_A75D0B0FAA56FBE1EDBF723AC7"]["_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4440BEBB27241915D49E93A21"]["_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8C1F0B0A5E250F70F0D2828AB2"]["_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4C90BE34AA79E8ABDDABA0322"]["_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8AF70B6732DA43494507D28A0F"]["_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (1347, -2185, 80), (0, 100, 0));
      break;
    case "_encstr_8E07030349":
    case "_encstr_BDD705AD7BD143":
      level.modifiedspawnpoints["_encstr_83AD0BF7CE6B0F302ABEE0D25F"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4440BEBB27241915D49E93A21"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8C1F0B0A5E250F70F0D2828AB2"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8A440BEA5E9A1C9E6911F23A22"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9A1F0B98C81B4301A598E4A623"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B", (1347, -2185, 80), (0, 100, 0));
      break;
    case "_encstr_8E1904B3F501":
      level.modifiedspawnpoints["_encstr_8FAD0B915A33E29A55B698726A"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AF440B338E1AFA5AEEF218CB73"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_911F0BD2024EBB894E2A0F499F"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1440B329F32A9C17EE14BC4D8"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AB1F0B8625247F185A0B689313"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511", (1347, -2185, 80), (0, 100, 0));
      break;
    case "_encstr_AF6A069265315388":
      level.modifiedspawnpoints["_encstr_83AD0BF7CE6B0F302ABEE0D25F"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4440BEBB27241915D49E93A21"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8C1F0B0A5E250F70F0D2828AB2"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8A440BEA5E9A1C9E6911F23A22"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9A1F0B98C81B4301A598E4A623"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A", (1347, -2185, 80), (0, 100, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-155, 2200, 230), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-210, 2200, 230), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-265, 2200, 230), (0, 260, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-360, 2200, 240), (0, 260, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-160, 2300, 230), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-207, 2300, 230), (0, 265, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-248, 2300, 230), (0, 265, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-289, 2280, 230), (0, 265, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-383, 2235, 238), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (-445, 2224, 243), (0, 276, 0));
      break;
    case "_encstr_ACF906B79752C5E8":
      level.modifiedspawnpoints["_encstr_AF440B338E1AFA5AEEF218CB73"]["_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_911F0BD2024EBB894E2A0F499F"]["_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1440B329F32A9C17EE14BC4D8"]["_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AB1F0B8625247F185A0B689313"]["_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1109, -1911, 80), (0, 22, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1115, -1966, 80), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1121, -2035, 80), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1349, -2069, 80), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1347, -2127, 80), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E", (1347, -2185, 80), (0, 100, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}