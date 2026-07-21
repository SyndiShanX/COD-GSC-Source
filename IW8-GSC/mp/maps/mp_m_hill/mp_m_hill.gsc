/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_hill\mp_m_hill.gsc
***********************************************/

main() {
  _encstr_849A31967E029238ADCA06E86F9E38EF028E17A07FB11051311483FD5D4B732E6819E3AFAB68E09BA01720BABFEBD53547D067::main();
  _encstr_AD513060D6C2F99259808AE7A0BEB9B0830AAE2B3B672899BAA3C178F75A4F268E9DBA87D1E701B433B959821EA8FA6F6BE0::main();
  _encstr_ACB32BAFE752C7F8CD738845DFDF2DB02AB328730B777A5ED86380F54FD538097D607B98E06BB6A72072BF9656::main();
  _encstr_88B531B9D84E2D078ECDCBAD07E5AD16839BBC6BC1AFADAF1A961B635EB51CD7ADEB0DB43663EB63B4CED08EB4B9CEC5EC378D::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8A1E161B7BD60E0BB9B9FA5BB007D7D60E7DDAD7A14B8D63", "_encstr_93C3206EB7718AA1AB684713198197D2F1AFF2E2E0BB62F876D80B9F90FE58DAB1B1");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 3);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 3);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_924D09EBE0478F23A1B0E4";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread player_exfil_struct();
  level thread show_hint_after_delay();
}

player_exfil_struct() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1016, -1233, 45));
  var_0 setModel("_encstr_8C942229C7695F78FE4720E8A70BD383B2AD882F1DE23DA0E72B1838CB2789B7FA193714");
  var_0.angles = (0, 0, 0);
  var_1 = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1178, -1004, -88));
  var_2.angles = (90, 0, 0);
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = getEnt("_encstr_96DF0E4EC202196F2F82B0DA8BFF4822", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1056, -908, 40));
  var_4.angles = (0, 0, -90);
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_5 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-952, -1368, 12));
  var_6.angles = (22, 15, 0);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = getEnt("_encstr_830B1105709BF1E2BB614AAE1D5B7F65F23A28", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1060, -892, 48));
  var_8.angles = (0, 0, -90);
  var_8 clonebrushmodeltoscriptmodel(var_7);
  var_9 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (868, -892, 160));
  var_10.angles = (0, 0, -90);
  var_10 clonebrushmodeltoscriptmodel(var_9);
  var_11 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-405, -1725, 35));
  var_12.angles = (0, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-956, 1408, 28));
  var_14.angles = (3, 345, 22);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_16 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-516, -948, -40));
  var_16.angles = (0, 320, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_18 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-168, -900, -30));
  var_18.angles = (347, 297, 31);
  var_18 clonebrushmodeltoscriptmodel(var_17);
}

show_hint_after_delay() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2337.07, 647.259, 158.378));
  var_0 setModel("_encstr_B11E1E0CA7F1E94289208B9F68A63703BB4652C4920B218DD188FBD7C8D9F7DA");
  var_0.angles = (295.692, 75.6707, 96.2589);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1158.6, -1321.99, 69.144));
  var_1 setModel("_encstr_B11E1E0CA7F1E94289208B9F68A63703BB4652C4920B218DD188FBD7C8D9F7DA");
  var_1.angles = (276.6, 207.401, 62.2173);
}