/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_piccadilly\mp_piccadilly.gsc
***************************************************/

main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "_encstr_BAFB08CA7376C616B932";
  _encstr_A7BD3983A855F46B2B26B7FDBF98C73EB9D0CEFA98B7EA47A106C1ECDBD88B405F88C35183B3E697D9FDC1EC61027FCA4D507A0AF069DFEAF15ED3::main();
  _encstr_B6B33807834290EF03FB2010B31629989A0B378338E1A0BB77D2E1390A335180E5773B0D9FD5E8E8E36AB9C192CB9B60CDD1C78B6AFBC2CC8722::main();
  _encstr_A58233AAC69DEAF00B102E2F2048D5D2316625A5379F332131680F33F0589C9B77F17A519F1BDA731978271BB0D2773271B807D28E::main();
  _encstr_8C653937C6275A388EB997D61CCB5B85839BCBADE0BE07D2C6360B8C5AC663F25E6BE07D0EB4C68D2CC8A51B1BE5EB8DD2B3348E96E69DC59D6E6C::main();
  scripts\cp_mp\utility\game_utility::_id_12B2C();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.outofboundstriggers[0].origin = level.outofboundstriggers[0].origin - (0, 0, 20);
  scripts\mp\compass::setupminimap("_encstr_95011AC6DED6E00B6E9BAFB50BE0AFDAE0EB0E4BD86C16325A6336BC", "_encstr_87162436E71BE1534ADB883841661778239146B67F8769B9B9521849CBBCC771BF3CC3A1D43F");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = level _id_12333();
  level.kill_border_triggers = scripts\engine\utility::array_combine(level.kill_border_triggers, var_0);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_82BC0B6CF3A5694AD1CB999527", 8192);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 10);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  setDvar("_encstr_819F1C4F2B5B460B5212B8CEBD989CC018C2C3B0839EA2614F807103E818", 1);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_8A65065739262C37";
  thread play_movie("_encstr_9B9513AD0EF5834B8DF5E68DC9952BCD6EAF060691");
  thread metal_detectors();
  thread laser_shut_down_button();
  thread _id_12F8E();
  thread _id_121F3();
  level thread _id_121F5();
  level thread spawnstaticvan();
  scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  wait 6.0;
  scripts\engine\utility::array_thread(getscriptablearray("_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180", "_encstr_AC110A7F14873B5B3D073009"), ::_id_141BD);
  scripts\engine\utility::array_thread(getscriptablearray("_encstr_8D852F4B568AC7833C179963322773C9782287199763D1E3487F6101374BF2591176EBA6FFA97BB86989F8F2B845B7E040", "_encstr_AC110A7F14873B5B3D073009"), ::_id_141BD);
  level thread _id_12F82();
  level.outofboundstime = 2;
}

play_movie(var_0) {
  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF") == 1) {
    return;
  }
  for(;;) {
    playcinematicforalllooping(var_0);
    wait 3;
  }
}

laser_shut_down_button() {
  var_0 = getEnt("_encstr_BEE90BBB78D9670B877E170F68", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0))
    var_0 delete();
}

metal_detectors() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEnt("_encstr_8D8F156837898F3DF9F5B7A871DB067CF2FB23360312B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0)) {
    for(;;) {
      var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
      playsoundatpos(var_1.origin + (0, 0, 80), "_encstr_B26B18E7E1539FD82734E3B3F7A1475DE158135D8349601558C8");
      wait 1.5;
    }
  }
}

_id_141BD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomfloat(2));

  if(self getscriptablehaspart("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93")) {
    if(self getscriptableparthasstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159"))
      self setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159");
  }

  self.wire_think = scripts\engine\utility::spawn_tag_origin();
  self.wire_think.origin = self gettagorigin("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think.angles = self gettagangles("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think show();
  self.wire_think linkTo(self, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  waitframe();

  if(self.classname == "_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180")
    playFXOnTag(scripts\engine\utility::getfx("_encstr_88931D6766F0FA1CA58D8DB0192D63D8CBAFE07BD8D21BACD7B14BB3348E6E"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  else if(self.classname == "_encstr_8D852F4B568AC7833C179963322773C9782287199763D1E3487F6101374BF2591176EBA6FFA97BB86989F8F2B845B7E040")
    playFXOnTag(scripts\engine\utility::getfx("_encstr_ABFF204B19108FCB73073737612B52E4B086061571807412D81F57D749C32A28806B"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  else
    return;

  for(;;) {
    self waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_0);

    if(var_0 == "_encstr_99220EEC59A15AD81B95EB91CA853AD0" || var_0 == "_encstr_AF790FF05D41D931214052FCA0E06102C6" || var_0 == "_encstr_8C0B1819A53025FF3582935A48161F1DA05F936FCBA02DDF65D9") {
      if(self.classname == "_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180")
        killfxontag(scripts\engine\utility::getfx("_encstr_88931D6766F0FA1CA58D8DB0192D63D8CBAFE07BD8D21BACD7B14BB3348E6E"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      else if(self.classname == "_encstr_8D852F4B568AC7833C179963322773C9782287199763D1E3487F6101374BF2591176EBA6FFA97BB86989F8F2B845B7E040")
        killfxontag(scripts\engine\utility::getfx("_encstr_ABFF204B19108FCB73073737612B52E4B086061571807412D81F57D749C32A28806B"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      self.wire_think delete();
      break;
    }
  }
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
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_91260B40A2EC2B91B36DA82E47"] = (1796.56, 883.661, 131.75);
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_AF260B886A249329FB35F7680F"] = (0, 35, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")]]("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", "_encstr_BDBB0616C6C186C2");
      break;
    }
  }
}

_id_12F82() {
  while(!istrue(level.doorsetupfinished))
    waitframe();

  wait 2.0;

  foreach(var_1 in level.doors) {
    var_1 notify("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
    var_2 = 0;
    var_3 = 90;

    if(distancesquared(var_1.origin, (214, 745, 132)) < 12)
      var_3 = -110;
    else if(distancesquared(var_1.origin, (854, 1254, 140)) < 12)
      var_3 = 110;
    else if(distancesquared(var_1.origin, (795, 1339, 140)) < 12)
      var_2 = 1;
    else if(distancesquared(var_1.origin, (-116, 1025, 128)) < 12)
      var_3 = 105;

    var_1.angles = (var_1.angles[0], var_1.angles[1] + var_3, var_1.angles[2]);
    var_1.useprompt makeunusable();

    if(isDefined(var_1.lockprompt))
      var_1.lockprompt makeunusable();

    if(var_2) {
      var_1.clipent delete();
      var_1 delete();
    }
  }
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_8E65062BD0CFB4EC":
    case "_encstr_8E9E088D9C58E65B2B19":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_85EF050CB150E7":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_959105B99040BD":
    case "_encstr_B41904BB8593":
    case "_encstr_9B0703CD93":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2783, 94, 208), (0, 8, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3100, -993, 132), (0, 1, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2440, -2584, 130), (0, 47, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2624, -3150, 88), (0, 41, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-615, -2249, 174), (0, 82, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1607, -992, 151), (0, 74, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (76, 837, 190), (0, 221, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-178, 1082, 186), (0, 216, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (382, 1002, 198), (0, 229, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (716, 1396, 198), (0, 218, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1073, 832, 196), (0, 259, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (883, -673, 161), (0, 186, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (17, 177, 179), (0, 239, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-813, 1169, 196), (0, 268, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (312, 1032, 148), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-40, 1168, 144), (0, 215, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-72, 960, 144), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (368, 480, 128), (0, 210, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (96, 376, 128), (0, 165, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1168, -192, 120), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1208, -280, 120), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (808, -336, 120), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (736, -464, 128), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (824, -880, 24), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-504, 584, 152), (0, 240, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1000, 976, 144), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1200, 912, 144), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2520, 888, 160), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2816, 72, 160), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2328, -152, 128), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2616, -904, 112), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2992, -896, 104), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2664, -1656, 88), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2392, -2200, 88), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2392, -2552, 88), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-472, -2560, 128), (0, 90, 0));
      level.modifiedspawnpoints["_encstr_B6920CE38A7B22332A76FB738F5A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_97D70CDEBBABD6FE46BAA3AA01C2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_92D70CC3AA5B0A940A561BD34FA2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1910C4BC8D8434D80B466CD8C63"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B20A0CAD66DBBA7B3102572FCA25"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_917E0C812ACA3B4D2EFEAA9A37C2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AD9F0C8222DB6383DE9D565CF3F7"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AD070C8E3ABFFAB86A38C2FBE08F"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A57B091DAE5F6482B94393"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BAA909337B4DFA6F9742FD"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9164094AC252CB3E09EF1A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AF5A099119D0B904898963"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_81440972DAF19252928359"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_82CB095AF114CFA80A5BFB"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_92F409C8D06E06809991C0"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BA6009A90B924286E5024F"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_ADD00A59C2D2C12A53B763D2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84680A126583A40EFFD1C67D"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_96B50A26B9466040890E1A1C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B6620A9E0923CBAF29AE65B2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2729, -3706, 16), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2736, -3600, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2736, -3520, 16), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2645, -3726, 16), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2504, -3736, 16), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2416, -3472, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2341, -3754, 16), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2200, -3480, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2526, 170, 152), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2450, 126, 144), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2345, 136, 144), (0, 106, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2247, 116, 128), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2181, 158, 128), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2074, 116, 128), (0, 79, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2470, 320, 133), (0, 123, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1984, 603, 144), (0, 158, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1568, 1768, 144), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1624, 1832, 152), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1720, 1848, 152), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1835, 1346, 147), (0, 240, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-831, 1079, 196), (0, 272, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-155, 1100, 186), (0, 214, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (84, 827, 190), (0, 216, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (387, 1000, 198), (0, 231, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (699, 1383, 198), (0, 218, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (312, 1032, 148), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-40, 1168, 144), (0, 215, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-72, 960, 144), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (368, 480, 128), (0, 210, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (96, 376, 128), (0, 165, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1168, -192, 120), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1208, -280, 120), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (808, -336, 120), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (736, -464, 128), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (824, -880, 24), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-504, 584, 152), (0, 240, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-1000, 976, 144), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-1200, 912, 144), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2520, 888, 160), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2816, 72, 160), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2328, -152, 128), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2616, -904, 112), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2992, -896, 104), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2664, -1656, 88), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2392, -2200, 88), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-2392, -2552, 88), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-472, -2560, 128), (0, 90, 0));
      level.modifiedspawnpoints["_encstr_ADD00A59C2D2C12A53B763D2"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84680A126583A40EFFD1C67D"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_96B50A26B9466040890E1A1C"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_92F409C8D06E06809991C0"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A57B091DAE5F6482B94393"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BAA909337B4DFA6F9742FD"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8639092D860F5552699223"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BDB009236443A901C40CC6"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_81440972DAF19252928359"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B42209521A5B95A6CB37BB"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AD9F0C8222DB6383DE9D565CF3F7"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B20A0CAD66DBBA7B3102572FCA25"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1910C4BC8D8434D80B466CD8C63"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B6920CE38A7B22332A76FB738F5A"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_97D70CDEBBABD6FE46BAA3AA01C2"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_92D70CC3AA5B0A940A561BD34FA2"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_917E0C812ACA3B4D2EFEAA9A37C2"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AD070C8E3ABFFAB86A38C2FBE08F"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1568, 1768, 152), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1624, 1832, 160), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1720, 1848, 160), (0, 285, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2470, 320, 152), (0, 123, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2526, 170, 152), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2450, 126, 152), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2344, 132, 136), (0, 106, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2245, 106, 136), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2181, 158, 136), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2065, 114, 136), (0, 85, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2341, -3754, 16), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2504, -3736, 16), (0, 50, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2645, -3726, 16), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2729, -3706, 16), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2736, -3600, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2736, -3520, 16), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2416, -3472, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2200, -3480, 24), (0, 0, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_121F3() {
  var_0 = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3248, -976, 0));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3248, -1488, 0));
  var_3.angles = (270, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6384, -9880, 776));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-86, -1430, 108));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1132, -52, 142));
  var_9.angles = (0, 60, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_1 disconnectPaths();
  var_3 disconnectPaths();
  waitframe();
  var_1 notsolid();
  var_3 notsolid();
}

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(859, 1989, 135)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 300, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}

_id_12333() {
  var_0 = [];
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-536, -1072, -108), 0, 24000, 125);
  var_0[var_0.size] = var_1;
  return var_0;
}