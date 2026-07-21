/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_farms2_gw\mp_farms2_gw.gsc
*************************************************/

main() {
  _encstr_A771379BD827B4383A3779B507F2B58507CDBCD6E0F5CC58E4B53719F5CEEEE5AD83AF3385C95BB9C8FAB3DDEB1C272B1B581B43598B9DCD8D::main();
  _encstr_99F8366E36C95A831DCD5ED61C5EADC238E6795B07FA332CE4AD9B237DCEDDF2EC569BF2DA07AF6658E4B6CD46EBEC77D70BC93A17EC9BC6::main();
  _encstr_9B48310F1FA87B72E05AB55BCFE68F21D117F258B151DE466B1DA33D89EA4B956B78C0DA997215C3D2F0DFD39188B3A6DA2238::main();
  _encstr_8CED373FBB4A98F71BF35818AB1E218062033F8B30F928B73B0AABEB61E7E43A7D785705C91A0886D201214B89E393C0D4D4A39D775590CECF::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 9);

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
    thread _id_12E15();
    thread perkpackage_giveoverridefieldupgrades();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("_encstr_934F1916C71FA3736A8B39A0C2C25758C34F2C9F32E70B1D59D2BB");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_8C6A0AAFE187993125FC3337", 1.0);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  thread runmisteffects();
  thread _id_136A5();
  thread player_fired_gun_monitor();
  thread _id_145F0();
  thread _id_12F8E();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (51682, -15944, -202));
  var_1.angles = (0, 0, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (51532, -15944, -202));
  var_3.angles = (0, 0, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (51404, -15944, -202));
  var_5.angles = (0, 0, -90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (51854, -15944, -202));
  var_7.angles = (0, 0, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

_id_136A5() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (46894.9, -8506.3, 343.159));
  var_0 setModel("_encstr_A6DF2D5659BEB2B156B147C9DEDC2D8DDCD7D195C6CA9DD2CDA5BD73AFEE58B11BAF5B7BBADCE8AC8CEB3616C9CECA");
  var_0.angles = (0, 5, 0);
}

runmisteffects() {
  if(getdvarint("_encstr_9ABD114BFE5AD11DA2F7838DE30AC818E95213", 0) != 0) {
    return;
  }
  var_0 = [];
  var_0[0] = (51013, 3186, 0);
  var_0[1] = (62213, -2887, 200);
  var_0[2] = (65119, -10586, 100);
  var_0[3] = (57430, -30024, -69);
  var_0[4] = (51073, -35213, 1300);
  var_0[5] = (27484, 8625, -383);
  var_0[6] = (36825, -18139, -350);
  wait 15;

  foreach(var_2 in var_0) {
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_2);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(0, 90));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(90, 180));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(180, 270));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(270, 359));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
  }
}

_id_12E15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (27210, -19254, 274);
  level.setallclientomnvarot[1] = (21201, -12856, -151);
  level.setallclientomnvarot[2] = (50746, 9531, 200);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (6003, -1300, 1139);
  level.setallclientomnvarot[7] = (53845, -36604, 400);
  wait 15;
  thread _id_12E14();
  thread _id_12E13();
  thread _id_12E12();
}

_id_12E11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (50804, 6322, 317);
  level.weapons_that_can_stun[1] = (50861, -32721, 1312);
  level.weapons_that_can_stun[2] = (30572, -14651, -285);
  level.weapons_that_can_stun[3] = (20039, -2025, -400);
  level.weapons_that_can_stun[4] = (38519, 9487, 194);
  level.weapons_that_can_stun[5] = (62592, -15849, 633);
  level.weapons_that_can_stun[6] = (21343, -11066, 1400);

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
    wait(randomfloatrange(0.5, 2.0));
  }
}

_id_12E14() {
  var_0 = [];
  var_0[0] = (53038, -38220, 15150);
  var_0[1] = (50278, -40361, 1515);
  var_0[2] = (20911, 5952, -480);
  var_0[3] = (19030, 28960, 1565);
  var_0[4] = (35506, 31620, 639);
  var_0[5] = (25230, -18677, -4);
  var_0[6] = (2704, -1787, -63);

  foreach(var_2 in var_0)
  playFX(scripts\engine\utility::getfx("_encstr_9AE3129D5CC117C0FBB8E958874078EF965FE3EB"), var_2 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
}

_id_12E12() {
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (9697, -10409, -170), (9, 0, 0));
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (65867, -30562, 1622), (14, 142, 0));
}

_id_12E13() {
  foreach(var_1 in level.setallclientomnvarot)
  playFX(scripts\engine\utility::getfx("_encstr_A30E1920DD888120AB6F1252DF50673178BB5BDA27D7CDAF40A2B3"), var_1, (0, 100, 0));
}

perkpackage_giveoverridefieldupgrades() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_ABBC1332BDE6AC47DCB6EB990B276BB991E22CB1C6", 1);
}

_id_145F0() {
  var_0 = getdvarint("_encstr_B4640BD8718FB217D4B25B4756", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("_encstr_BD930C07A3F8B1A3DD59BAE2A1AE"), (46720, -11343, 700));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("_encstr_BA67084238D7F9B30926"), (46720, -11343, 700));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("_encstr_85380B276FDB40989DE728A34D"), (46720, -11343, 700));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("_encstr_AAB30A817AA7C8784537B783"), (46720, -11343, 700));
      break;
  }
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48642.2, -23600.2, -396.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48730.2, -23688.2, -396.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48562.2, -23680.2, -396.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48642.2, -23768.2, -396.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (47594.2, -23600.2, -372.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (47682.2, -23688.2, -372.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (47514.2, -23680.2, -372.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (47594.2, -23768.2, -372.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48154.2, -23368.2, -388.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48242.2, -23288.2, -388.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48074.2, -23280.2, -388.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (48154.2, -23200.2, -388.069), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (48152.4, 57.1055, 19.9805), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (48080.4, 153.105, 27.9805), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (48280.4, 97.105, 27.9805), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (48152.4, 57.1055, 19.9805), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46897.3, 681.634, -20.0195), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46949.8, 568.2, -20.0195), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46771.1, 674.056, -20.0195), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46815.8, 562.692, -28.0195), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46272.6, 857.043, -12.0195), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46352.6, 761.043, -12.0195), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46152.6, 817.043, -12.0195), (0, 255, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (46224.6, 721.043, -20.0195), (0, 255, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}