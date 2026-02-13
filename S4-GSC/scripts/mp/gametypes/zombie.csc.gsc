/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\zombie\.csc.gsc
*************************************************/

main() {
  _func_00DF("#x3a5cc1f61008d141e", 1.2);
  _func_00DF("#x397617e5e9291ea7b", 120);
  scripts\common\omnvars_shared::registeromnvarcallback("portal_screen_distortion", ::portal_screen_distortion);
  scripts\common\omnvars_shared::registeromnvarcallback("exit_portal_screen", ::exit_portal_screen);
  scripts\common\omnvars_shared::registeromnvarcallback("reset_portal_screen", ::reset_portal_screen);
}

portal_screen_distortion(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = 0;
  var_7 = _func_00A6();
  var_8 = 0.5;
  var_9 = 0;
  var_10 = 0.5;
  var_11 = 0.5;
  var_12 = 0;
  var_13 = 0.5;
  var_14 = 0;
  var_15 = 0.05;
  var_16 = 0.5;
  var_17 = -1.0;
  var_18 = 1;
  var_19 = 0.5;
  _func_00DF("#x320c6aa95071ea85d", var_8);
  _func_00DF("#x31f9ba2c1834330ea", var_9);
  _func_00DF("#x329d798d8baa02cac", var_10);

  while(var_6 < 9775) {
    var_6 = _func_00A6() - var_7;
    var_20 = var_6 / 9775;
    _func_00DF("#x320c6aa95071ea85d", var_11 + (var_14 - var_11) * var_20);
    _func_00DF("#x31f9ba2c1834330ea", var_12 + (var_15 - var_12) * var_20);
    _func_00DF("#x329d798d8baa02cac", var_13 + (var_16 - var_13) * var_20);
    wait 0.01;
  }

  _func_00DF("#x320c6aa95071ea85d", var_14);
  _func_00DF("#x31f9ba2c1834330ea", var_15);
  _func_00DF("#x329d798d8baa02cac", var_16);
  var_7 = _func_00A6();
  var_6 = 0;

  while(var_6 < 300) {
    var_6 = _func_00A6() - var_7;
    var_20 = var_6 / 300;
    _func_00DF("#x320c6aa95071ea85d", var_14 + (var_17 - var_14) * var_20);
    _func_00DF("#x31f9ba2c1834330ea", var_15 + (var_18 - var_15) * var_20);
    _func_00DF("#x329d798d8baa02cac", var_16 + (var_19 - var_16) * var_20);
    wait 0.01;
  }

  _func_00DF("#x320c6aa95071ea85d", 0);
  _func_00DF("#x31f9ba2c1834330ea", 0);
  _func_00DF("#x329d798d8baa02cac", 0);
}

exit_portal_screen(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = 0;
  var_7 = _func_00A6();
  var_8 = -1.0;
  var_9 = 1;
  var_10 = 0.5;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0;
  _func_00DF("#x320c6aa95071ea85d", var_8);
  _func_00DF("#x31f9ba2c1834330ea", var_9);
  _func_00DF("#x329d798d8baa02cac", var_10);

  while(var_6 < 250) {
    var_6 = _func_00A6() - var_7;
    var_14 = var_6 / 250;
    _func_00DF("#x320c6aa95071ea85d", var_8 + (var_11 - var_8) * var_14);
    _func_00DF("#x31f9ba2c1834330ea", var_9 + (var_12 - var_9) * var_14);
    _func_00DF("#x329d798d8baa02cac", var_10 + (var_13 - var_10) * var_14);
    wait 0.01;
  }

  _func_00DF("#x320c6aa95071ea85d", 0);
  _func_00DF("#x31f9ba2c1834330ea", 0);
  _func_00DF("#x329d798d8baa02cac", 0);
}

reset_portal_screen(var_0, var_1, var_2, var_3, var_4, var_5) {
  _func_00DF("#x320c6aa95071ea85d", 0);
  _func_00DF("#x31f9ba2c1834330ea", 0);
  _func_00DF("#x329d798d8baa02cac", 0);
}