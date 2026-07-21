/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_runner_pm\mp_runner_pm.gsc
*************************************************/

main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  _encstr_9A3837C7C6DB0A427BDA9639E83820D72083EEAD73A078E330AAF5FB01439526DDDBF8A565652E790A87F8ADF708923A1B07EFD8C27E9F9770::main();
  _encstr_957A36339F73E41B989ADEB8C3A678EEF848867090B7566DD563A9ABB9772AF088CBF3AABF4F81DBC3C056BDE3869B6570EFABC50E2FCBD7::main();
  _encstr_861F31BFAF2D50E0839B9EF12B2282EF1152AF2D4B5ECBE0804EFBFB665805C098D009BD67F8C0D5C6696B321966A820BA8B4F::main();
  _encstr_8DFE3727F0A399F31146CD552F7FFA594BC8DEC7837EDAEB0DD0A78A80A9B2AF3038A733B0F00ED24D60EA45E8A90AAFF880F73B88207F7B47::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("_encstr_A39E16782BDF418ED2071B6757EB58906585E091D23FF031");
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_879D191620A0B8D2065FCF1F63AF79EDF08ECA1BF85075DB48310F", "_encstr_97F9238DB78C1B0BE6A3CA937DB1DBD61C5837B9D7B60B83AFDA07AFC9573773599CF51CAD");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1500);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_924D09EBE0478F23A1B0E4";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread scripts\mp\motiondetectors::init();
  thread scripts\mp\animation_suite::animationsuite();
  game["_encstr_9A8507BA4040188D08"] = "_encstr_81190407A676";
  game["_encstr_8E8405EA382B2A"] = "_encstr_921F052955D419";
  thread scripts\mp\secrethunt::secrethunt("_encstr_99490C0A2BEBBA5F10A3746C4D38");
  level thread managegate();
  level thread _id_12F8E();
  level thread player_exfil_struct();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-8, 248, 440));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

managegate() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  level.scr_animtree["_encstr_A3460A8C2193E9F7550268C0"] = #animtree;
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = % _encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E1338401D89927B3C1;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = "_encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E133A401D89927B3C1";
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = % _encstr_BD0A18933891E006BFA2E00A0ADB35013781390BDC49F04FF7AA;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = "_encstr_BD0A18933891E006BFA2E00A0ADB35013781390BFC49F04FF7AA";
  level.scr_animtree["_encstr_AAA60B178003F5617D2B7FB48D"] = #animtree;
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = % _encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4E7DC6637B6EAC;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = "_encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4A7DC6637B6EAC";
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = % _encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350503F07E3D9B8;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = "_encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350513F07E3D9B8";
  var_0 = getEnt("_encstr_AA3B1041F518748398B1B2BA1BF0DB2FB079", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_ADC31109BD503CDBC0F98A72C3386BF48019AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_9AE61160934E08F9E90FB8B062012FD0B167C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.animname = "_encstr_A3460A8C2193E9F7550268C0";
  var_0 scripts\common\anim::setanimtree();
  var_1.animname = "_encstr_AAA60B178003F5617D2B7FB48D";
  var_1 scripts\common\anim::setanimtree();
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_ADB405071B8AE8");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_ADB405071B8AE8");
  var_2 hide();
  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  wait 4.0;
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_88950636C6DE9B59");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_88950636C6DE9B59");
  var_3[0] = "_encstr_84850667C1A57264";
  var_3[1] = "_encstr_B61007BECA31606B23";
  var_4 = randomint(2);

  if(var_4 > 1)
    var_4 = 1;

  var_0 playSound("_encstr_AB2615ED4796B32BAD18327BA98766E389B86B9450BB57" + var_3[var_4]);

  if(var_3[var_4] == "_encstr_84850667C1A57264")
    var_1 playSound("_encstr_B1931B5BC17D275DB9B9CA9CD77685D159AF36B1DBCD95AF27A5CE1AE8");
  else
    var_1 playSound("_encstr_93401ABAE8D7FAB79060353A90D9AF03DBF9C222A827F7E708DD3E34");

  wait 1.0;
  var_2 show();
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
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (203, -1478, 272), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (483, -1350, 272), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-29, -1542, 272), (0, 95, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-357, -1526, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-525, -1522, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-845, -1518, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-689, -538, 196), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-309, -522, 268), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (435, -518, 26), (0, 105, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (719, -310, 268), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (687, -418, 26), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (826, -265, 148), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (961, -54, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (961, 138, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-29, -1542, 272), (0, 95, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1001, 1602, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (989, -1114, 272), (0, 91, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-469, -190, 196), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (342, 1513, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (362, 1143, 268), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (286, 745, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (319, 230, 268), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-190, 895, 292), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-370, 537, 292), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (435, -518, 268), (0, 105, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-525, -1522, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (826, -265, 148), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (719, -310, 268), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-357, -1526, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-845, -1518, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (319, 230, 268), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (687, -418, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (961, -54, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-309, -522, 268), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (961, 138, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (342, 1513, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (989, -1114, 272), (0, 91, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-469, -190, 196), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1001, 1602, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (286, 745, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-689, -538, 196), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-370, 537, 292), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (483, -1350, 272), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (203, -1478, 272), (0, 110, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (203, -1478, 272), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (483, -1350, 272), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-29, -1542, 272), (0, 95, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-357, -1526, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-525, -1522, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-845, -1518, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-689, -538, 196), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-309, -522, 268), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (435, -518, 26), (0, 105, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (719, -310, 268), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (687, -418, 26), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (826, -265, 148), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (961, -54, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (961, 138, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-29, -1542, 272), (0, 95, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1001, 1602, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (989, -1114, 272), (0, 91, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-469, -190, 196), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (342, 1513, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (286, 745, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (319, 230, 268), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-370, 537, 292), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (435, -518, 268), (0, 105, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-525, -1522, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (826, -265, 148), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (719, -310, 268), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-357, -1526, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-845, -1518, 272), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (319, 230, 268), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (687, -418, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (961, -54, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-309, -522, 268), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (961, 138, 180), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (342, 1513, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (989, -1114, 272), (0, 91, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-469, -190, 196), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1001, 1602, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (286, 745, 268), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-751, 1330, 268), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-689, -538, 196), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-370, 537, 292), (0, 15, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (483, -1350, 272), (0, 125, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (203, -1478, 272), (0, 110, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}