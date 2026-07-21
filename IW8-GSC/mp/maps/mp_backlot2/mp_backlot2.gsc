/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_backlot2\mp_backlot2.gsc
***********************************************/

main() {
  _questtimerwait::keypad_check_levelinput();
  _encstr_B2C235485FA2E02983622019BA6E4BA908A72220FB7759C3DA0C891093570790507FF0C82FEBD0E7536268A7EA1AE7D9AB3B404A97ABC9::main();
  _encstr_BA13346BDE7A403753D77FF3F3CEF15810B2982082EFD067DAAFC1EF9B47E8A0DD4D10B82A07682FF247C9E7B3AF18E86223A8711263::main();
  _encstr_8C422FCDD8C92D071DDC79B683BCD616E0CDE5B61CBE130BD8B58DBD8E8CCBD607EB98858DAD1BED3A8CBE33E1C5D96E6C::main();
  _encstr_BE5B356E3352F4235BFF56D3415A79B2D0C7588068796259568A38D073EAB0082377B6675827D5B50BAA5FB1D8610D7D99B8FCB877DB7B::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_910818379FB568572FEB3E60D27BAFC88AD7BDAB3B9C50A8DBD7", "_encstr_921222B38F1170F21EA4525BE10332201B6F93EB013BDAE739C06956D9868EFF4A2A8B43");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 30);
  setDvar("_encstr_853B0A41A7E94879A8EBAC67", 256);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  var_0 = getEnt("_encstr_AD250E2A0AFC8FE53FCB32E028DF9752", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 connectpaths();
  }

  level thread managegate();
  level thread spawnstaticvan();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  level _id_12C23();
  level battle_tracks_vehicleoccupancyenter();
  level thread player_exfil_struct();
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
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_88950636C6DE9B59");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_88950636C6DE9B59");
  var_3[0] = "_encstr_84850667C1A57264";
  var_3[1] = "_encstr_B61007BECA31606B23";
  var_4 = randomint(2);

  if(var_4 > 1)
    var_4 = 1;

  if(var_3[var_4] == "_encstr_84850667C1A57264") {} else {}

  wait 1.0;
  var_2 show();
}

spawnstaticvan() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")) {
    return;
  }
  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    foreach(var_1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")]]()) {
      if(var_1.script_noteworthy != "_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2") {
        continue;
      }
      if(var_1.name != "_encstr_BDBB0616C6C186C2") {
        continue;
      }
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_91260B40A2EC2B91B36DA82E47"] = (-128, 2241, 60);
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_AF260B886A249329FB35F7680F"] = (0, 90, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")]]("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", "_encstr_BDBB0616C6C186C2");
      break;
    }
  }
}

_id_12C23() {
  level.modifiedspawnpoints["_encstr_BD8309E3C8F17ADFB71289"]["_encstr_8A550CA8037FCD9021830923AF55"]["_encstr_A353071677FAF7EB45"] = 1;
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_9707038CB6":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (-611, -2560, 73), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (1474, -2101, 64), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (456, -1486, 65), (0, 5, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (-488, -1336, 71), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (-1262, -746, 62.5), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (1910, -463, 64), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (1896, 672, 64), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (1274, 1640, 64), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (656, 1640, 64), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (77, 2498, 62), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (-753.431, 2209.12, 60.5), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", (-1207.5, 1071, 60.5), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8A550CA8037FCD9021830923AF55", (1897, 625, 96), (0, 180, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (289, 529, 309));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (289, 657, 309));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
}