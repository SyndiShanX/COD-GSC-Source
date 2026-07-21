/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_port2_gw\mp_port2_gw.gsc
***********************************************/

main() {
  _start_spawn_modules::keypad_check_levelinput();
  _encstr_9AD93537C64EB4E03A37F2AD83E5D6B0389BE55B077D1CB74EA346EBECBBF26B07FAC1ED938E8CBECEBBEB3827CAB10B3643AC8BB3E61B::main();
  _encstr_A5A734DA378A8B97A37B5AD2E33653A708DAFF80714E80787A7B92CFE710568895258FC2B849799F5379DF694C1FC131B2FBEE52803A::main();
  _encstr_81C02FE61B4EA583D1B997ADE097AD851CCD975B07D71CBD9C1D8CBEB3BB97D60EEB83DE273A23FACEEEBE99F05C3B6E8D::main();
  _encstr_848135A2CE6512F8030826172850ADDA395E3D5D2F973B3F2BD85AD7F833D7C2D1E072559639D747D1D8F70390E9581B5B803F9DF49F9A::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 3);

    thread _id_12E15();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_BDB41830DA75D119F733E8F939A386A39A6120C8E3CB8D168F5F");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  thread runmisteffects();
  thread _id_145F0();
  thread player_fired_gun_monitor();
  thread setlowermessageomnvarref((38149, -15989, -710), 256, 32);
  thread setlowermessageomnvarref((33872, -30160, -1200), 7700, 480);
  thread setlowermessageomnvarref((36736, -17544, -1200), 7480, 480);
  thread _id_12F8E();
}

runmisteffects() {
  if(getdvarint("_encstr_9ABD114BFE5AD11DA2F7838DE30AC818E95213", 0) != 0) {
    return;
  }
  var_0 = [];
  var_0[0] = (33447, 18127, 340);
  var_0[1] = (47827, -16744, -40);
  var_0[2] = (70050, -4854, 1501);
  var_0[3] = (17964, -34000, 315);
  var_0[4] = (50908, -33808, 1100);
  var_0[5] = (12735, -23915, -320);
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
  var_0[0] = (15522, -28390, 19);
  var_0[1] = (56365, -14244, -418);
  var_0[2] = (50524, 40892, -1400);

  foreach(var_2 in var_0)
  playFX(scripts\engine\utility::getfx("_encstr_9AE3129D5CC117C0FBB8E958874078EF965FE3EB"), var_2 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
}

_id_12E12() {
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (26974, 8140, 40), (9, 286, 0));
}

_id_12E13() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (53880, -13100, -300);
  level.setallclientomnvarot[1] = (23702, -1605, -300);

  foreach(var_1 in level.setallclientomnvarot)
  playFX(scripts\engine\utility::getfx("_encstr_A30E1920DD888120AB6F1252DF50673178BB5BDA27D7CDAF40A2B3"), var_1, (0, 100, 0));
}

player_fired_gun_monitor() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (33380, -27608, -460));
  var_0 setModel("_encstr_88BC19F0993B7194C02340B9A11007BF6F3A0D5F9ADBF5E7D84A76");
  var_0.angles = (90, 40, -6);
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (35470, -28140.5, -509));
  var_0 setModel("_encstr_8BB7216067972B037AADAF1C4562419603B3F8604F46433B32971887CA99353A29325A");
  var_0.angles = (270, 358, -132);
}

_id_145F0() {
  var_0 = getdvarint("_encstr_B4640BD8718FB217D4B25B4756", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("_encstr_BD930C07A3F8B1A3DD59BAE2A1AE"), (35851, -24450, -471));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("_encstr_BA67084238D7F9B30926"), (35851, -24450, -471));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("_encstr_85380B276FDB40989DE728A34D"), (35851, -24450, -471));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("_encstr_AAB30A817AA7C8784537B783"), (35851, -24450, -471));
      break;
  }
}

setlowermessageomnvarref(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_1, var_2);

  for(;;) {
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(isPlayer(var_4))
      var_4 dodamage(10000, var_4.origin, var_3, var_3, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (30936, -35872, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31024, -35952, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (30864, -35952, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (30928, -36112, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31456, -35952, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31368, -35872, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31296, -35952, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31400, -36112, 566), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31808, -36112, -526), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31864, -35952, -526), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31704, -35952, -526), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (31776, -35872, -526), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37128, -14960, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37080, -14880, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37168, -14880, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37128, -14800, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (36752, -14960, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (36792, -14880, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (36704, -14880, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (36752, -14800, -562.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37496, -14960, -554.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37536, -14880, -554.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37448, -14880, -554.527), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (37496, -14800, -554.527), (0, 270, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}