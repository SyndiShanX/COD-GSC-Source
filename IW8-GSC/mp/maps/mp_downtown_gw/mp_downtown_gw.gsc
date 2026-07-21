/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_downtown_gw\mp_downtown_gw.gsc
*****************************************************/

main() {
  _setplayerteamrank::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  _encstr_A9883B58F25A1BC303AB48518046A8D3021B42205BB9497877AEED587F9BD697AB66D850010FE7B33BDC784C4E37994F19FBB870BAE63728CFBE74465B::main();
  _encstr_99373A6E1BC9B40E1D9BCBB6E097DA2CE06E97AD38FA8CBDBBE63AB7EE37BE3BDD977695DCE5DA1C7D327BDD73A3EDBBDCAF3BEE7D859C47E29DB9C6::main();
  _encstr_873335EBB1E647FA4817D76DE96A45AF0F2BA6B27B280B7578058467CF4881EF34481AEBE61DEFABE8298767E599576748D9C396496E87::main();
  _encstr_8C903B2646BB4B9BE447FA10B347F09343EAB0A11A012920CF1B2808872ECEC79B0519B7B90AF7EB8E6BE8D0FB47012F617D83B4CCE3A3F06F6AA0F8A7::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 6);

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
    thread _id_12E15();
    thread minarmordropondeath();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("_encstr_85AB1B40100DDBD64BD7974BB2FBB7F370E99BE7FF2B79CF4708B12450");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_8C6A0AAFE187993125FC3337", 1.0);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  level thread player_exfil_struct();
  level thread player_exit();
  thread setlowermessageomnvarref();
  thread _id_145F0();
  level thread _id_12F8E();
}

_id_12E15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (7298, -26583, -199);
  level.setallclientomnvarot[1] = (31947, 8236, -108);
  level.setallclientomnvarot[2] = (50746, 9531, 200);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (4457, 227, 84);
  level.setallclientomnvarot[7] = (53887, -33922, 1383);
  wait 15;
  thread _id_12E14();
  thread _id_12E13();
  thread _id_12E12();
}

_id_12E11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (9222, -19971, -202);
  level.weapons_that_can_stun[1] = (10809, -10631, 306);
  level.weapons_that_can_stun[2] = (40307, -9808, 477);
  level.weapons_that_can_stun[3] = (37474, -23592, -501);
  level.weapons_that_can_stun[4] = (16705, -36174, 398);
  level.weapons_that_can_stun[5] = (23886, 17882, 566);
  level.weapons_that_can_stun[6] = (6650, 7176, 176);

  for(;;) {
    var_0 = randomintrange(0, level.weapons_that_can_stun.size);
    var_1 = level.weapons_that_can_stun[var_0];
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.5;
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait(randomfloatrange(1.0, 2.0));
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.25;
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_12E14() {
  var_0 = [];
  var_0[0] = (35313, 5404, -641);
  var_0[1] = (4086, -24505, -100);
  var_0[2] = (2704, -1787, -63);
  var_0[3] = (48882, -12722, 90);

  foreach(var_2 in var_0)
  playFX(scripts\engine\utility::getfx("_encstr_9AE3129D5CC117C0FBB8E958874078EF965FE3EB"), var_2 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
}

_id_12E12() {
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (-7956, 8572, -308), (10, 316, 0));
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (57277, -44955, 1719), (12, 134, 0));
}

_id_12E13() {
  foreach(var_1 in level.setallclientomnvarot)
  playFX(scripts\engine\utility::getfx("_encstr_A30E1920DD888120AB6F1252DF50673178BB5BDA27D7CDAF40A2B3"), var_1, (0, 100, 0));
}

minarmordropondeath() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_978714215A1315A342F32F41F7ED91658FA2F009D2B3", 1);
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18612, -12854, -104));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18612, -12902, -104));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18612, -12948, -104));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18612, -12996, -104));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (23564, -13916, -224));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (23910, -18278, 456));
  var_11.angles = (270, 311.634, 93.3662);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (24000, -18368, 456));
  var_13.angles = (270, 311.634, 93.3662);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (24072, -18440, 456));
  var_15.angles = (270, 311.634, 93.3662);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17258.5, -17452.6, 752));
  var_17.angles = (0, 135, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_19 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17280.5, -17474.6, 752));
  var_19.angles = (0, 135, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_21 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -10656, 168));
  var_21.angles = (0, 0, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_23 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -10784, 168));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_25 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -10912, 168));
  var_25.angles = (0, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_27 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -11040, 168));
  var_27.angles = (0, 0, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_29 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -11168, 168));
  var_29.angles = (0, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_31 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -11296, 168));
  var_31.angles = (0, 0, 0);
  var_31 clonebrushmodeltoscriptmodel(var_30);
  var_32 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_33 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21960, -11424, 168));
  var_33.angles = (0, 0, 0);
  var_33 clonebrushmodeltoscriptmodel(var_32);
  var_34 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21952, -11592, 168));
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_36 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_37 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21952, -11728, 168));
  var_37.angles = (0, 0, 0);
  var_37 clonebrushmodeltoscriptmodel(var_36);
  var_38 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_39 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21952, -11864, 168));
  var_39.angles = (0, 0, 0);
  var_39 clonebrushmodeltoscriptmodel(var_38);
  var_40 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_41 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17800, -79828, 464));
  var_41.angles = (0, 45, 0);
  var_41 clonebrushmodeltoscriptmodel(var_40);
  var_42 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_43 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17800, -19828, 336));
  var_43.angles = (0, 45, 0);
  var_43 clonebrushmodeltoscriptmodel(var_42);
  var_44 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_45 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17800, -19828, 208));
  var_45.angles = (0, 45, 0);
  var_45 clonebrushmodeltoscriptmodel(var_44);
  var_46 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_47 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17800, -19828, 80));
  var_47.angles = (0, 45, 0);
  var_47 clonebrushmodeltoscriptmodel(var_46);
  var_48 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_49 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17870, -19848, 464));
  var_49.angles = (0, 45, 0);
  var_49 clonebrushmodeltoscriptmodel(var_48);
  var_50 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_51 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17870, -19848, 336));
  var_51.angles = (0, 45, 0);
  var_51 clonebrushmodeltoscriptmodel(var_50);
  var_52 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_53 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17870, -19848, 208));
  var_53.angles = (0, 45, 0);
  var_53 clonebrushmodeltoscriptmodel(var_52);
  var_54 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_55 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17870, -19848, 80));
  var_55.angles = (0, 45, 0);
  var_55 clonebrushmodeltoscriptmodel(var_54);
  var_56 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_57 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17936, -19828, 464));
  var_57.angles = (0, 45, 0);
  var_57 clonebrushmodeltoscriptmodel(var_56);
  var_58 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_59 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17936, -19828, 336));
  var_59.angles = (0, 45, 0);
  var_59 clonebrushmodeltoscriptmodel(var_58);
  var_60 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_61 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17936, -19828, 208));
  var_61.angles = (0, 45, 0);
  var_61 clonebrushmodeltoscriptmodel(var_60);
}

player_exit() {
  var_0 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (17936, -19828, 80));
  var_1.angles = (0, 45, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 8));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 72));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 136));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 200));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 296));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16512, -15392, 360));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (172876, -17567.8, -31.5));
  var_15.angles = (270, 37.6, -172.62);
  var_15 clonebrushmodeltoscriptmodel(var_14);
}

setlowermessageomnvarref() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (22824, -13160, -1360), 0, 15848, 715);
  var_0 thread _id_12E19();
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (21969, -10078, -190), 0, 160, 128);
  var_1 thread _id_12E19();
}

_id_12E19() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isPlayer(var_0))
      var_0 dodamage(10000, var_0.origin, self, self, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

_id_145F0() {
  var_0 = getdvarint("_encstr_B4640BD8718FB217D4B25B4756", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("_encstr_BD930C07A3F8B1A3DD59BAE2A1AE"), (21593, -13938, -89));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("_encstr_BA67084238D7F9B30926"), (21593, -13938, -89));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("_encstr_85380B276FDB40989DE728A34D"), (21593, -13938, -89));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("_encstr_AAB30A817AA7C8784537B783"), (21593, -13938, -89));
      break;
  }
}

_id_12F8E() {
  level.modifiedspawnpoints["_encstr_B8A20DD250E8B25F47BA06ABA312DB"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20822.7, -2227.94, -507.48), (0, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20854.7, -2363.94, -507.48), (0, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20718.7, -2347.94, -507.48), (0, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20678.7, -2219.94, -507.48), (0, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20277.5, -1956.21, -497.675), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20157.5, -1956.21, -497.675), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20093.5, -1868.21, -497.675), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (20013.5, -1956.21, -497.675), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (19590.3, -2330.46, -497.973), (0, 315, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (19590.3, -2202.46, -497.973), (0, 315, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (19718.3, -2218.46, -497.973), (0, 315, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (19702.3, -2106.46, -497.973), (0, 315, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (16050.7, -24097.9, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (16135.2, -24255.7, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (15984.7, -24243.3, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (16037.7, -24343.3, -200), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (15720, -24448, -200), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (15800, -24248, -200), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (15616, -24248, -200), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (15720, -24136, -200), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (17292.3, -24115.9, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (17388.3, -24019.9, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (17196.3, -24019.9, -204), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (17284.3, -23939.9, -204), (0, 90, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}