/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_raid\mp_raid.gsc
***********************************************/

main() {
  _start_spawn_modules::keypad_check_levelinput();
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  _encstr_931A2DC2730377D3DBABF85F8A0ABF2641B685470B6F9317F0A05E82C3F732FB6380A83F1AFB78612F1BC1BDB1A380::main();
  _encstr_B26B2C62E693F37B63337FB7A9C867D743D878DD8B49E01738DC06D769E0555150C9DA5648A206E725636E1787AB::main();
  _encstr_839827E6D893D2071DE6F2D6E0F2DA85C1DCCBB5E0EB9C2C4B8C5EDAE0F59CC29632F5661E719DE6D8::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.3);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000);
  setDvar("_encstr_846619C2B76BE35FC67FE9F90BD89B0797F07225731F6381C9E8DF", 1);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 768);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8AEC14367BDA07859BB9BEB62C1CFADA387D270B2D91", "_encstr_BDCE1EB1BDC8C62CDC472B39D71BB76B83B0CDCDF56B58387DDAE0F54E584B91");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_924D09EBE0478F23A1B0E4";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  game["_encstr_9A8507BA4040188D08"] = "_encstr_81190407A676";
  game["_encstr_8E8405EA382B2A"] = "_encstr_921F052955D419";
  level thread managegate();
  level thread player_exfil_struct();
  level thread _id_12F8E();
}

managegate() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_0 = getEntArray("_encstr_B6070E3A6A70EC7AE1B6636A33DBF7EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 hide();

  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  wait 4.0;

  foreach(var_2 in var_0)
  var_2 show();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2958, 224, 292));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2958, 256, 292));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_AA2B10691D61889737FAD14BFABF7BC255E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-732.75, 1859.25, 268.25));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2133, 1986, 400.5));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2974, 2202, 304));
  var_9.angles = (270, 358, -66);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-448, 940, 480));
  var_11.angles = (90, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-448, 1048, 480));
  var_13.angles = (90, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1320, 4035, 400));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1320, 3971, 400));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
}

_id_12F8E() {
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((-2075, 512, 272), 100, 0, 100);
  var_0 = getnodesinradius((-2226, 1811, 272), 32, 0, 100);

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  var_4 = [];
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3392.8, -126.1, 300), (0, 360, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-558.1, 516.8, 300), (0, 90, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-665.9, 647.2, 300), (0, 270, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3172.8, 229.9, 300), (0, 360, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-2487.2, -789.9, 300), (0, 180, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1010.1, -795.2, 300), (0, 270, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-749.9, 3263.2, 300), (0, 45, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-313.9, 3291.2, 340), (0, 90, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (370.1, 3247.2, 344), (0, 40, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-734.1, 2444.8, 356), (0, 270, 0));
  var_4[var_4.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-570.1, 2260.8, 332), (0, 270, 0));

  if(var_4.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_4);
}