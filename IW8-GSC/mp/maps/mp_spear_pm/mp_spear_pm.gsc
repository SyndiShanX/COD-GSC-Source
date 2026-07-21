/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_spear_pm\mp_spear_pm.gsc
***********************************************/

main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_8877353B8FD814936D3396BA7BE83FCE2057EFBD0109DADB9D697B8183117E8578A74B28B390229F3F80A17BEB7D777E4851D5CEDFD8AE::main();
  _encstr_ADA13470679AC8019B0A5871A24673B1E04F0A08931F43F952B6EE10BA5A2FB95DA382B07BC71BB17A5EE61892B287219263F268EF93::main();
  _encstr_AB392F92FEB5C228D3F8D6C7F860FD8A490E0D8DDF473B509940AB0710ADE732E1B0E242CD63E3B70358271B6810671B9F::main();
  _encstr_B444356FE673FB310B0BC790B11EE1189007B80BE35F66582BFA2AC7DAADEAB01811AB3028F02279BBF327F4E21CD0144F93D7584F87AB::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("_encstr_AF8D15B8EB1F814E92475B2717AB1858A087C1B3D95058");
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_B82E180E656A5999C36759F017F896AB6381FE0F7F02E506A877", "_encstr_934822B1F6C81BC2B93AAC9CFA1BF65B83166EE6EBB5C238BE6BE0F59B0E592C27D71CAD");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_A608184B8659D7AF3869CFE24B80FF03779922A28FACBF66088F", 1);
  setDvar("_encstr_BDCA1556B9AABB89088B69D8E75C04FD535FC05E8C8343", 1.33);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 768);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 40);
  setDvar("_encstr_853B0A41A7E94879A8EBAC67", 256);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  thread scripts\mp\motiondetectors::init();
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  level thread managegate();
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
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")]]();

    foreach(var_2 in var_0) {
      if(var_2.script_noteworthy != "_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2") {
        continue;
      }
      if(var_2.name != "_encstr_BDBB0616C6C186C2") {
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