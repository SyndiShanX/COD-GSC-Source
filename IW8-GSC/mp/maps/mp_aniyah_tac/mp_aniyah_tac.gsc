/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_aniyah_tac\mp_aniyah_tac.gsc
***************************************************/

main() {
  _encstr_A34A39F3AA53231093FBDFA370AD30FF8303C0B8038F6FB8ECD94BA1072328B6561AA3667AF393C886D02F8121CE11875B325929E203DD4ADFA35F::main();
  _encstr_B6AE3807834290EF03FB2010B31629989A0B378338E128385F73E1B86953D750E5773B0D9FD5E8E8A71AF88292FB80A08ECBC78B6AFBC2CC8722::main();
  _encstr_88D13317F6AD2183A1FB80D118AEC549911676FDB33FBBEB910BE3FA89D1DFF0501D4319F71270301FB3BF8981C3A86A9A580F5B29::main();
  _encstr_AC3A39DC6CE4A5074737795B1C5E6B58389B79B5C17D2CDC969785D0EB1D58C697DAE0FA85B9A5E5B0A1FAD10BC6BEC6A5CED0A3D273B3C5769B8D::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8D4B1A8DBD5B0716379BAFDA581CAFAD38EB859B2DBCC243EB47851B", "_encstr_8CF2248027FCF953BB9BCD4EB95287E030B7B8887F9DF12941C5BFC00EDAF32A896B5128EF2B");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  level thread battle_tracks_vehicleoccupancyenter();
  level thread player_exfil_struct();
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_B41904BB8593":
    case "_encstr_8E65062BD0CFB4EC":
    case "_encstr_85EF050CB150E7":
    case "_encstr_9B0703CD93":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_8E9E088D9C58E65B2B19":
    case "_encstr_959105B99040BD":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB", (5934, -82, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB", (5946, 20, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB", (5974, -36, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB", (5971, -267, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (-38, 880, 264), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (-38, 944, 264), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (34, 862, 264), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0", (34, 920, 264), (0, 0, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B", (5934, -82, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B", (5946, 20, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B", (5974, -36, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B", (5971, -267, 262), (0, 206, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (-26, 843, 260), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (-90, 875, 260), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (-90, 943, 260), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B", (-26, 911, 260), (0, 360, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1652, -706, 604));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1918, 106, 626));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1670, -267, 458.5));
  var_5.angles = (270, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (2268, -1961, 360), 0, 800, 800);
  var_6.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}