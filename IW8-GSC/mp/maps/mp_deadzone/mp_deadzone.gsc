/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_deadzone\mp_deadzone.gsc
***********************************************/

main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  _encstr_86B735AB1EBA80F79317BF33330EB11850F2D8E0422FA025BA532D2FB372A83008413979AE7CE8E8623F6F19EB1AC6A8B3E4819857B3E8::main();
  _encstr_872434E7EF1EB250B87BC55DF38A85CAF7270E1771D02A3D48A1882528E09FE2C58586AF1978F2F560C9802DCD88275A26197A0F879E::main();
  _encstr_B6FC2F6ED8C95A831D37CBB6E05EAD16E0B979B5C1F5325685C83DB77395BCAD83F58C56B0194FBDE62BAFCC8771CEDC36::main();
  _encstr_A5C935CF79D02F382397A05923AFA949301B5769B379B5E9963D821F3AE787559BA99AA5A82A32650825B14563474A655C205FBEA91F0E::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_A7DF1896187D73EFC3A2E00347E02793D9112860C83BF278104B", "_encstr_AC0C227F17932B19075370EB893E3FD1BA9962EF79752E5FE71BA1F09240BAC7D0C85B67");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 768);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_924D09EBE0478F23A1B0E4";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread scripts\mp\animation_suite::animationsuite();
  level thread player_exfil_struct();
  thread incorrectswitch();
  level battle_tracks_vehicleoccupancyenter();
  windmilllinkcol();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    brinit();

  var_0 = getnodesinradius((-130, 1850, 400), 200, 0, 200);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.animscript) && (var_2.animscript == "_encstr_A13D0B53EADA387D5783AFE0C0" || var_2.animscript == "_encstr_A7EE0DDB9BD96B3740B08BD5AEFA30"))
      destroynavlink(var_2);
  }
}

incorrectswitch() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-73.0545, -2981.88, 410.847));
  var_0.angles = (0, 0, 0);
  var_0 setModel("_encstr_B4E3224E7BDE33F5B9D04B9BD936959BD760C4D79195C2233DDBDCB2FAC6F69DAC9CBA07");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-73.0545, -2981.88, 410.847));
  var_1.angles = (0, 0, 0);
  var_1 setModel("_encstr_B444246DE507E56FCA104BF09F2AE588BF0AB76FA2B76F4C151A36FD112EE8680DC3AD30F9E8");
}

windmilllinkcol() {
  var_0 = getEnt("_encstr_BDF6055F93E8B3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = getEnt("_encstr_8F76098370283C62F891F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 linkTo(var_0);
}

brinit() {
  scripts\mp\door::door_system_init("_encstr_8E9F15C9591D270B1B1DFA8CDBDE27AFE8E496ECD99593");
  level.br_level = spawnStruct();
  level.br_level.copterpath = [(2202.03, -556.476, 1793.91), (2097.7, -138.627, 1793.91), (1838.1, 202.261, 1793.91), (1656.1, 681.495, 1793.91), (1292.53, 1214.28, 1793.91), (1095.45, 1794.95, 1793.91), (886.622, 2519.31, 1793.91), (307.793, 3026.63, 1793.91), (-415.485, 3126.58, 1793.91), (-860.034, 2672.91, 1793.91), (-1099.85, 2211.41, 1793.91), (-1611.58, 1827.99, 1793.91), (-1652.05, 1171.92, 1793.91), (-1620.95, 388.386, 1793.91), (-1685.17, -262.896, 1793.91), (-1709.18, -1018.64, 1793.91), (-1500.51, -1753.17, 1793.91), (-1488.46, -2271.66, 1793.91), (-861.884, -2868.1, 1793.91), (-240.021, -3248.69, 1793.91), (517.867, -2690.86, 1793.91), (960.791, -1925.54, 1793.91), (1142.82, -1727.82, 1793.91)];
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (801, 3472, 0);
  level.br_level.br_mapbounds[1] = (-2967, -3646, 0);
  level.br_level.br_guncount = 40;
  level.br_level.br_circleclosetimes = [20, 20, 15, 10];
  level.br_level.br_circledelaytimes = [90, 35, 20, 20];
  level.br_level.br_circleradii = [4800, 1500, 1020, 480, 0];
  level.br_level.br_circlestaticvfx = ["_encstr_B463154B18D9F1AB53B86A67C859970239C8F332883F62", "_encstr_9563159D330FEB8927EBA77B37B2BE37E8B0E896D8D7C4", "_encstr_A26315B46A5357AA83AFEBDD20931918B441C908CE0712", "_encstr_B163159DEBF3D868F251C27805CD49068B5F012B87E9B6"];
  level.br_level.br_circledynamicvfx = ["_encstr_922D1035BEC829FE0331F2584A37380AA941", "_encstr_9B2D105E142A5F86FDE9ABF2883B311E26A6", "_encstr_962D10B3660FBE26E4BE9EF6CD59FA8CAFCC", "_encstr_9B2D105E142A5F86FDE9ABF2883B311626A5"];
  level.br_level.br_circleinnervfx = ["_encstr_BEC61423778809C6DB7FDBCDA37216C1328DA8D951A8", "_encstr_92C614D9CC3CFA8939FAA5CD37CA27AFA7B73759FA89", "_encstr_82C6144B5DB379EA10962CF5A87022B10AF7A39F47FE"];
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_AA2B10691D61889737FAD14BFABF7BC255E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (54, 1702, 353));
  var_1.angles = (276, 90, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1828, 1564, 432));
  var_3.angles = (0, 315, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-636, 266, 442));
  var_5.angles = (0, 270, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-618, 276, 442));
  var_7.angles = (0, 270, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-618, 248, 442));
  var_9.angles = (0, 0, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-608, 266, 442));
  var_11.angles = (0, 0, 90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1920, -1367, 524));
  var_13.angles = (330.796, 277.762, 89.9931);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1926, -1412, 524));
  var_15.angles = (299.999, 277.769, 89.9912);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1551.5, -1029, 396));
  var_17.angles = (360, 7.99995, -90.0002);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_19 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1720, -232, 592));
  var_19.angles = (360, 3.00002, -89.9997);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_21 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1770, 270, 592));
  var_21.angles = (360, 4.2995, 89.9997);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_23 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1479, -1039, 396));
  var_23.angles = (360, 7.99995, -90.0002);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_25 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1551.5, -1029, 489));
  var_25.angles = (360, 7.99995, -90.0002);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_27 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1479, -1039, 489));
  var_27.angles = (360, 7.99995, -90.0002);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_29 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1476.5, 2738.5, 632));
  var_29.angles = (0, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
}

battle_tracks_vehicleoccupancyenter() {
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
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2424, 1568, 458.505), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2228, 424, 446.973), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2312, -1624, 366.505), (0, 69.9996, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1824, -376, 538.973), (0, 19.9996, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1064, -144, 538.2), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-944, -972, 512), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (344, -584, 460), (0, 89.9997, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (576, -936, 456), (0, 120, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (856, -912, 313.337), (0, 44.9998, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2380, -2176, 360.306), (0, 175, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (912, 432, 448), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (848, 1356, 324.327), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (576, 1512, 458.973), (0, 255, 0));
      level.modifiedspawnpoints["_encstr_BDCA0AF4602F29C054BEE2CA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8DB5094713C76ED32A8FC6"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5DE0BB12BA7411935C2CA823A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_95FB0CB4261AC10C024BA118A61B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B42A0C7EB2FA8B11A0B3C232C7BA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_936D0C5AC41B231840D2CC86E68D"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_860A0B5B38F23AE746DFE2DA57"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A2FF0AAF0BF672BD5A693D26"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_ACBE0AB8E43BFA3D19F2173F"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_88010B42CB8A3C06699F2A0A91"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (784, -4960, 72), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (96, -4936, 101), (0, 104, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-480, -4800, 89), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1480, -4056, 229), (0, 39, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1880, -3872, 228), (0, 14, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1620, -3476, 238), (0, 9, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-808, -3888, 201), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (472, -4456, 282), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (872, -4376, 272), (0, 119, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1604, -3688, 304), (0, 105, 0));
      level.modifiedspawnpoints["_encstr_8AB40AE2026D4191F49BE2E3"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B8DE0A988DE48D024399C868"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5720A210253D367BFC0111D"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_93300A6F5A67628E12FDA094"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A3820A62E6279108CC1A4D07"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_958D0AC48C641A08D0CD6806"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9206092993CB8A0B6B6277"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_81CB095872C2700FDE25EA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_96610A993E236A96FF520F07"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AAF30BDE2A625240902232EBAA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEF40B8D9273C818BA11E253CB"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AF1C0B9643831F20128BCAB3B3"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_88380BB873FA22FBD9723A7D45"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7A90B5A136ACC63088698D006"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5DA0BD24C0C130D011AC491D0"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87EB0A161AC39AAED92EB2CB"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_869B0ABD5342C0EEFD87160A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_952B0AC9D22F3551649AE2FA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A978097B979A525C9F0F77"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1859, 4715, 242), (0, 246, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1696, 4324, 203), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1896, 3912, 201), (0, 207, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1908, 3684, 195), (0, 177, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1792, 3458, 195), (0, 177, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1224, 4740, 223), (0, 272, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (892, 4324, 204), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1342, 3888, 188), (0, 257, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2038, 3698, 337), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1908, 4352, 351), (0, 289, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1780, 4256, 334), (0, 275, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1536, 4140, 328), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1014, 4124, 327), (0, 278, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-732, 4304, 341), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-560, 4336, 349), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-276, 4448, 272), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-90, 4392, 269), (0, 237, 0));
      level.modifiedspawnpoints["_encstr_92D10B9D335252C2179F597E12"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2042, 2857, 462), (0, -65, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2424, 1568, 458.505), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2228, 424, 446.973), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2312, -1624, 366.505), (0, 69.9996, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1824, -376, 538.973), (0, 19.9996, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1064, -144, 538.2), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-944, -972, 512), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (344, -584, 460), (0, 89.9997, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (576, -936, 456), (0, 120, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (856, -912, 313.337), (0, 44.9998, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (2380, -2176, 360.306), (0, 175, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (912, 432, 448), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (848, 1356, 324.327), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (576, 1512, 458.973), (0, 255, 0));
      level.modifiedspawnpoints["_encstr_BDCA0AF4602F29C054BEE2CA"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8DB5094713C76ED32A8FC6"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5DE0BB12BA7411935C2CA823A"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_95FB0CB4261AC10C024BA118A61B"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B42A0C7EB2FA8B11A0B3C232C7BA"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_936D0C5AC41B231840D2CC86E68D"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_860A0B5B38F23AE746DFE2DA57"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A2FF0AAF0BF672BD5A693D26"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_ACBE0AB8E43BFA3D19F2173F"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_88010B42CB8A3C06699F2A0A91"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (784, -4960, 72), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (96, -4936, 101), (0, 104, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-480, -4800, 89), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1480, -4056, 229), (0, 39, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1880, -3872, 228), (0, 14, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1620, -3476, 238), (0, 9, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-808, -3888, 201), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (472, -4456, 282), (0, 89, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (872, -4376, 272), (0, 119, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1604, -3688, 304), (0, 105, 0));
      level.modifiedspawnpoints["_encstr_8AB40AE2026D4191F49BE2E3"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B8DE0A988DE48D024399C868"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5720A210253D367BFC0111D"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_93300A6F5A67628E12FDA094"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A3820A62E6279108CC1A4D07"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_958D0AC48C641A08D0CD6806"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9206092993CB8A0B6B6277"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_81CB095872C2700FDE25EA"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_96610A993E236A96FF520F07"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AAF30BDE2A625240902232EBAA"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEF40B8D9273C818BA11E253CB"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AF1C0B9643831F20128BCAB3B3"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_88380BB873FA22FBD9723A7D45"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7A90B5A136ACC63088698D006"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5DA0BD24C0C130D011AC491D0"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87EB0A161AC39AAED92EB2CB"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_869B0ABD5342C0EEFD87160A"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_952B0AC9D22F3551649AE2FA"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A978097B979A525C9F0F77"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1859, 4715, 242), (0, 246, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1696, 4324, 203), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1896, 3912, 201), (0, 207, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1908, 3684, 195), (0, 177, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1792, 3458, 195), (0, 177, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1224, 4740, 223), (0, 272, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (892, 4324, 204), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1342, 3888, 188), (0, 257, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2038, 3698, 337), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1908, 4352, 351), (0, 289, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1780, 4256, 334), (0, 275, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1536, 4140, 328), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-1014, 4124, 327), (0, 278, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-732, 4304, 341), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-560, 4336, 349), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-276, 4448, 272), (0, 267, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-90, 4392, 269), (0, 237, 0));
      level.modifiedspawnpoints["_encstr_92D10B9D335252C2179F597E12"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-2042, 2857, 462), (0, -65, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}