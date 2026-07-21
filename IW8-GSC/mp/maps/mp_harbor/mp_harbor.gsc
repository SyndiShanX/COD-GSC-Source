/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_harbor\mp_harbor.gsc
***********************************************/

main() {
  _questtimerwait::keypad_check_levelinput();
  _encstr_852A31FB43FB614B2480E0B75A6E0D99239E3AB1511F88E9FB2AED68529868F7A187F6CA150DDEA8F3731FBF3ED0518687CBDE::main();
  _encstr_AF5C309BB1C94B0EA39BF2DA0E97B6B007DCE5B51C7D0D2C9C987B27CB76563797AD0EFA342C274CF69CAFB09C478BD937C6::main();
  _encstr_A2B72B6E6C93A51C479BBC6B385E6BB0C1DC79DA38F5D0589398DB93BC6B1CFA0DB0E498B727BECC3C71766EC6::main();
  _encstr_B2AA312AEFED936BA9D7A86920472D6858F387A7130F341142DA9F1B30E903FF5A1788264035393868A28CBBDF8EEFE8993B29::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_86FB168DBDD61C0BCD9BFAB5B01CBE6B07F543C2E489DBC9", "_encstr_AB2720E3C8F1F72E97C8327BA98FE5872BA77B8B487847B227E86BA178E39A632096");
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 30);
  setDvar("_encstr_853B0A41A7E94879A8EBAC67", 256);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 3);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 3);
  setDvar("_encstr_843D0BF7516E708C19BFBAF5D7", 0.5);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  thread _id_13229("_encstr_A9C30C13DE894C5AE6CE24BD581D");
  level thread player_exfil_struct();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1943, -2824, 477));
  var_1.angles = (0, 0, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2071, -2824, 477));
  var_3.angles = (0, 0, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2199, -2824, 477));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2327, -2824, 477));
  var_7.angles = (0, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2455, -2824, 477));
  var_9.angles = (0, 0, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
}

_id_13229(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3.startpos = var_3.origin;
    var_3.startang = var_3.angles;
    thread boatbob(var_3);
    thread boatwobble(var_3);
  }
}

boatbob(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = randomfloatrange(4, 7);
    var_0.goalpos = var_0.startpos + (randomintrange(-4, 4), randomintrange(-4, 4), randomintrange(-6, 6));
    var_0 moveTo(var_0.goalpos, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}

boatwobble(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = randomfloatrange(4, 6);
    var_0.goalang = var_0.startang + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
    var_0 rotateTo(var_0.goalang, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}