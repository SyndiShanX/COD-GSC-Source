/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_callouts.gsc
*************************************************/

init() {
  level._id_2F7C._id_A3CF = [];

  if(!_func_0221(level._id_2F7C._id_2FCD)) {
    return;
  }
  var_0 = level._id_9AB1[0].origin[0];
  var_1 = level._id_9AB1[1].origin[0];
  var_2 = var_1 - var_0;
  var_3 = level._id_9AB1[0].origin[1];
  var_4 = level._id_9AB1[1].origin[1];
  var_5 = var_4 - var_3;
  var_6 = 0;

  for(;;) {
    var_7 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_6, 5);

    if(!isDefined(var_7) || var_7 == "") {
      break;
    }

    if(var_7 != "1") {} else {
      var_8 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_6, 6);
      var_8 = float(var_8);
      var_8 = var_8 * var_2 + var_0;
      var_9 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_6, 7);
      var_9 = float(var_9);
      var_9 = var_9 * var_5 + var_3;
      var_10 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_6, 8);
      var_10 = float(var_10);
      var_11 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_6, 1);
      var_12 = spawnStruct();
      var_12.origin = (var_8, var_9, 0);
      var_12._id_0359 = var_10;
      level._id_2F7C._id_A3CF[var_11] = var_12;
    }

    var_6++;
  }
}

_id_6B1D(var_0) {
  var_1 = "";

  foreach(var_4, var_3 in level._id_2F7C._id_A3CF) {
    if(distance2dsquared(var_0, var_3.origin) <= var_3._id_0359 * var_3._id_0359) {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}