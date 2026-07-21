/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_rust\mp_rust.gsc
***********************************************/

main() {
  _redbuttonused_internal::keypad_check_levelinput();
  _start_rooftop_raid_heli::keypad_check_levelinput();
  _encstr_8F9D2DC3E815B42B6B66F7BDFF5807FE79108EBAD8F7AAF763CDCFA5977EB303A780F1E3506BA6DF593B8DEE2403CF::main();
  _encstr_9A372CC7C6DB0A427BDA9639E83820D72083EEAD73A078E3930BD059A23B0502C0676EAB66E31FF90AAC0A2FDB90::main();
  _encstr_A66327833760AC3BC56BFEC213B08766C8BF4715696132176E63F6CA3BE0A3DB3829BF66D132BF471E::main();
  _encstr_92AA2D5776A2D798746BDD3DA0C53709231840695BF97B6873837E8B8B91481710995154F10F234B40F69758D71331::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_87EC142FD808D8BA570E699D7F39119DF3F1D3FFA0C3", "_encstr_81CD1E36BD8C8D856E8E959CAF1BB7AD0EB0E6377D5B0B837DADC1AF39D56E3A");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12B3B();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  level thread player_exfil_struct();
  level battle_tracks_vehicleoccupancyenter();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1394, 1382.5, -167.5));
  var_1.angles = (90, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1157, 1382.5, -167.5));
  var_3.angles = (90, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1707.5, 1623, -114.5));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1707.5, 1711, -114.5));
  var_7.angles = (0, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1669, 1656, -208.5));
  var_9.angles = (0, 270, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1727, 1674, -158.5));
  var_11.angles = (0, 0, 37);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1727, 1648, -156.5));
  var_13.angles = (0, 180, 33);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1779.5, 1623, -114.5));
  var_15.angles = (0, 0, 90);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1725, 1662, -50.5));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_19 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1669, 1595.5, -228.5));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_B60703EACA":
      level.modifiedspawnpoints["_encstr_AD850A4ACB76FB41429E9ED3"]["_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9A850ABF92BAE2C81AA20B3F"]["_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3", (1636, 1394, -208), (0, 180, 0));
    case "_encstr_B807035284":
      level.modifiedspawnpoints["_encstr_AD850A4ACB76FB41429E9ED3"]["_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9A850ABF92BAE2C81AA20B3F"]["_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (1636, 1394, -208), (0, 180, 0));
    case "_encstr_AF6A069265315388":
      level.modifiedspawnpoints["_encstr_AD850A4ACB76FB41429E9ED3"]["_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9A850ABF92BAE2C81AA20B3F"]["_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A971A41B3D1285307F9C1AEA6600B636D78F2934B73C78B69B7F3E5", (1636, 1394, -208), (0, 180, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}