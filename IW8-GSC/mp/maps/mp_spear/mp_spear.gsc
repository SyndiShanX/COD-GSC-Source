/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_spear\mp_spear.gsc
***********************************************/

main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_9A4F2FAB261D2FCB0BC3AE9F09FFDA5A9A5F6EE859177FD0871F38DA05BBB9035BB5B122FEBB58284783C6DBF0EE209669::main();
  _encstr_B1B82E6E0EF303C3BC0FC2D86B8F384B7BB2C8F922D9FF0B955F50D20F1D901FF21A487EBAD2A373477758A3C2374B3F::main();
  _encstr_832429687F82C009A3024079DA4E6B89E847026B9B175BC15AAEE650F593C73330B70870BFC6720542D256::main();
  _encstr_8C0E2F02B148B1D3F52F7E0F51304AF1831BAD0D4BC9530B4523030E4347913BA8A1B65246E801322B1177134F405A73C8::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_A91E15983FED73BB43B2C8E90E4BFF98586790787FB98B", "_encstr_ACD91F36BD916C169BA35927F536F66B07586E9BD7AD85E0AFADC17D6EC12B85E4");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\door::door_system_init("_encstr_8E9F15C9591D270B1B1DFA8CDBDE27AFE8E496ECD99593");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 40);
  setDvar("_encstr_853B0A41A7E94879A8EBAC67", 256);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 768);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  level thread managegate();
  thread watchplayerconnect();
  level thread spawnstaticvan();
  thread player_fired_gun_monitor();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_AA9508ADB7EA9BA3C61A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (137, 135, 247));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
  var_2 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-904, -76, 264));
  var_3.angles = (0, 270, 70);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
  var_4 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-904, 52, 264));
  var_5.angles = (0, 270, 70);
  var_5 clonebrushmodeltoscriptmodel(var_4, 1);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (574, 2183, 192));
  var_6 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_6.angles = (270, 0, -90);
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
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_91260B40A2EC2B91B36DA82E47"] = (-38.8918, 3264, -43);
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_AF260B886A249329FB35F7680F"] = (0, 90, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")]]("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", "_encstr_BDBB0616C6C186C2");
      break;
    }
  }
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

watchplayerconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 streamsetmaterialtouchuntilloaded("_encstr_A7B522AB01F3AF4BA039B787330813BB957BB16349401B4210179295AF981CAF45B149FF");
  }
}