/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_aniyah\mp_aniyah.gsc
***********************************************/

main() {
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_B4A431D8FA3B835F63D2382220B8B83A283308A053A761CEEA8BAE1066D04317A2689BA369285E32E53B90410873A520F46F5F::main();
  _encstr_A78430CDD8C99607479B79B638E55B2C07375EB6E0AF0BDC5A5EC234E5B3CAE6CBB6837D85DC96BC2C1AFA2C9347173B6EC6::main();
  _encstr_A5882B937A8AAFFA40E25F3307387838F8268E884090398BE0D39F82572583977F60BC271970284DCBEE57BE37::main();
  _encstr_81F231AF6FAAE16B1B12B8D5F9D73236B0930810403F3F0258CBF948FE38CB89D730431A0E436FA4E427D2A948A069B8711896::main();
  scripts\mp\load::main();
  var_0 = scripts\mp\utility\game::getgametype();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163") {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 17);
  } else if(var_0 == "_encstr_8218041DF5FA")
    setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 0);

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("_encstr_BE6016278759CFD7A07B51EFEE9051B518A619E8D927D060", "_encstr_9B522053EF10EEBF86CB1A73B6D6CF25085BDBCB77B0B6C3B88043A959B80F98E8D1");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("_encstr_83920A488F414D730D6721C8", 3);
  setDvar("_encstr_A68D0B9894A50A9E699C69946A", 0);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  setDvar("_encstr_A5230B3794A4302F69C7377A1A", 0);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread incorrectswitch();
  thread deleteinfilclip();
  level thread player_exfil_struct();
  level thread _id_12F8E();
  level thread _id_136AD();
  level thread _id_121F5();
}

incorrectswitch() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6022.96, -1678.46, 260));
  var_0.angles = (0, 280.098, 0);
  var_0 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (5644.9, -1745.78, 260));
  var_1.angles = (0, 190.098, 0);
  var_1 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (5966.85, -1363.41, 260));
  var_2.angles = (0, 10.098, 0);
  var_2 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (5588.8, -1430.74, 260));
  var_3.angles = (0, 100.098, 0);
  var_3 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-605.51, 472.007, 314));
  var_4.angles = (0, 80.0989, 0);
  var_4 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-227.229, 405.979, 314));
  var_5.angles = (0, 350.099, 0);
  var_5 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-660.533, 156.772, 314));
  var_6.angles = (0, 170.099, 0);
  var_6 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-282.252, 90.7446, 314));
  var_7.angles = (0, 260.099, 0);
  var_7 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2146.45, 101.041, 328));
  var_8.angles = (0, 190.1, 0);
  var_8 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2051.81, -256.525, 338));
  var_9.angles = (0, 70.0987, 0);
  var_9 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1881.63, -726.52, 338));
  var_10.angles = (0, 250.099, 0);
  var_10 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1750.92, -365.452, 338));
  var_11.angles = (0, 340.099, 0);
  var_11 setModel("_encstr_9BDF2AFE7382708C299D2FDEEFC78C3B26F387D345E5EA698E6D6B771881FA49B1AB729B41C6FFFD8783AB88");
  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1353.8, 2143.24, 352));
  var_12.angles = (0, 285, 0);
  var_12 setModel("_encstr_A6482A6173595005AAFB87EF87725918D74E48FB5DBD785032E3939FDF79BF4ABFB25B3A89E3D8FCBADBD381");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3252.33, -1933.49, 284.5));
  var_13.angles = (0, 270, 0);
  var_13 setModel("_encstr_A6482A6173595005AAFB87EF87725918D74E48FB5DBD785032E3939FDF79BF4ABFB25B3A89E3D8FCBADBD381");
}

deleteinfilclip() {
  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  var_0 = getEnt("_encstr_A1A20BC8621F5B8DEFFBA913C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 moveTo(var_0.origin + (0, 0, -8), 30, 10, 10);
  wait 30;
  var_0 hide();
  var_0 notsolid();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2946, 854, 402));
  var_1.angles = (0, 325, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2955, 866, 401));
  var_3.angles = (0, 325, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (724, -815, 740));
  var_5.angles = (90, 270, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (716, 816, 748));
  var_7.angles = (90, 270, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_A2BD0EB1D8B438668C1ECC463C23D4C6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2658, -675, 188));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (10071, 1247, 102));
  var_11.angles = (270, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4738, -326, 364));
  var_13.angles = (270, 164, 176);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6412, -1156, 340));
  var_15.angles = (0, 25, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6472, -1128, 340));
  var_17.angles = (0, 25, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_19 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4367, -112, 347));
  var_19.angles = (0, 335, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_21 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1652, -706, 604));
  var_21.angles = (0, 0, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_23 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1918, 106, 626));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_25 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1670, -267, 458.5));
  var_25.angles = (270, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_27 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6350, -1276, 234));
  var_27.angles = (353, 344, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_29 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6416, -1296, 248));
  var_29.angles = (0, 344, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_31 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6482, -1320, 230));
  var_31.angles = (0, 342, 0);
  var_31 clonebrushmodeltoscriptmodel(var_30);
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_B81904B04E6B":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-940, 1828, 292), (0, 9.999, 0), "_encstr_998D16C8832135108B57170E7FE7198D17A960184AC47BAB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-647.569, 1606.59, 296), (0, 24.999, 0), "_encstr_998D16C8832135108B57170E7FE7198D17A960184AC47BAB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-852, 1220, 297.978), (0, 34.999, 0), "_encstr_998D16C8832135108B57170E7FE7198D17A960184AC47BAB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1951.16, 1587.07, 338), (0, 165, 0), "_encstr_8CBC14543B112D30BAAF4A52C7C38955DAA9DF63140B", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2376.06, 2046.75, 395.222), (0, 175, 0), "_encstr_8CBC14543B112D30BAAF4A52C7C38955DAA9DF63140B", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2519.16, 679.07, 426), (0, 150, 0), "_encstr_8CBC14543B112D30BAAF4A52C7C38955DAA9DF63140B", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2853.08, 1508.06, 393.357), (0, 22, 0), "_encstr_AFAC16774351CE52AE27525A3FCE7A0678AE6E3D984895EB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2412.81, 2991.28, 282.907), (0, 342, 0), "_encstr_AFAC16774351CE52AE27525A3FCE7A0678AE6E3D984895EB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2560.06, 3678.92, 269.357), (0, 297, 0), "_encstr_AFAC16774351CE52AE27525A3FCE7A0678AE6E3D984895EB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (4260, 2520, 488), (0, 242, 0), "_encstr_AFAC16774351CE52AE27525A3FCE7A0678AE6E3D984895EB", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (6207.48, 1780.58, 268.711), (0, 198, 0), "_encstr_A37D145F2F10DAD7A046AA937E10E112D5E7CFDBFBAE", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (5592.04, 1076.78, 268.711), (0, 97.9995, 0), "_encstr_A37D145F2F10DAD7A046AA937E10E112D5E7CFDBFBAE", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (5956.4, 452.78, 277.464), (0, 118, 0), "_encstr_A37D145F2F10DAD7A046AA937E10E112D5E7CFDBFBAE", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (4248, 2528, 488), (0, 243, 0), "_encstr_A37D145F2F10DAD7A046AA937E10E112D5E7CFDBFBAE", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (4641.39, 968.198, 404.317), (0, 245, 0), "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (5360, 384, 408), (0, 180, 0), "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (5392, -168, 412), (0, 180, 0), "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (4892, -608, 414.2), (0, 180, 0), "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (4244, -1092, 402.529), (0, 135, 0), "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3", "_encstr_AC9F0A2D80FF2A2CE9B19686");
      break;
    case "_encstr_B41904BB8593":
      level.modifiedspawnpoints["_encstr_AFE50B6933236A634091B9C9D8"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A9A40B9923CA73771607AA92AF"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_88400B521FB32F03CA614D445C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_9AEB0A551FE2F26297AA07FF"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B2DE0A6933C96AC6046EE46E"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A2E70AFEABB4FA3B3A1B7A66"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A2570A85428FF6320E4F02F3"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BE470B7DD6AB924801B2273F92"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A3C50A8386D88302C4A6180C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8321092AA5DF47E00A33A2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_853B099B3ABFF6F2CAB343"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3256, 2796, 264), (0, 19, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3637, 2049, 306), (0, 345, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2672, 1464, 342), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3328, 996, 322), (0, 356, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3956, 797, 276), (0, 358, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-4724, -26, 300), (0, 343, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-4092, 981, 305), (0, 343, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3768, 1116, 322), (0, 356, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (8468, 1500, 288), (0, 212, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (8608, 640, 318), (0, 212, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (9452, 252, 293), (0, 212, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_136AD() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-2010, 1930, 430), 0, 192, 100);
  var_0 thread _id_144FF();
}

_id_144FF() {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isDefined(self._id_126CE))
      self._id_126CE = [];

    if(scripts\engine\utility::array_contains(self._id_126CE, var_0.guid)) {
      continue;
    }
    self._id_126CE = scripts\engine\utility::array_add(self._id_126CE, var_0.guid);
    var_0 thread _id_14491(self);
  }
}

_id_14491(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-2271, 3199, 220);
  var_4.radius = 512;
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

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = (6426, -1140, 400);
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 100, 128);
  level.outofboundstriggers[level.outofboundstriggers.size] = var_1;
}