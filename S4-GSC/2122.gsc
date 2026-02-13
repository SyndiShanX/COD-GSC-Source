/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2122.gsc
*************************************************/

_id_94E7(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_7B95(var_0) {
  var_1 = 480 / var_0;
  return var_1;
}

_id_CC87(var_0, var_1) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, _id_0850::_id_6E43());
  var_2 = _id_7B95(var_1[1]);
  var_3 = var_0[0] * var_2;
  var_4 = var_0[1] * var_2;
  return [int(var_3), int(var_4)];
}

_id_CC6D(var_0, var_1) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, _id_0850::_id_6E43());
  var_2 = _id_7B95(var_1[1]);
  var_3 = var_0[0] * var_2;
  var_4 = var_0[1] * var_2;
  var_5 = var_1[0] / var_1[1];
  var_6 = var_5 * 480;
  var_7 = -0.5 * (var_6 - 640);
  var_3 = var_3 + var_7;
  return [var_3, var_4];
}

_id_0D51() {
  if(isDefined(level._id_0B52) == 1) {
    return;
  }
  level._id_0B52 = thisthread;

  while(isDefined(level._id_0B51) == 1) {
    var_0 = gettime();
    var_1 = [];

    foreach(var_3 in level._id_0B51) {
      if(var_3._id_5090 > 0) {
        var_1[var_1.size] = var_3;

        if(var_3._id_F1E8 == var_0) {
          continue;
        }
        var_3._id_5090 = var_3._id_5090 - 1;

        if(var_3._id_F21D <= var_0) {
          var_3.alpha = 0.0;
          var_3 settext("");
        }

        continue;
      }

      var_3 destroy();
    }

    level._id_0B51 = var_1;
    waitframe();
  }
}

_id_0D50(var_0) {
  var_1 = undefined;
  var_2 = gettime();
  var_3 = var_0 * 50;
  return var_1;
}

_id_0D4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 640;
  var_8 = 480;
  var_9 = var_7 / var_8;
  var_10 = _id_0850::_id_6E43();
  var_11 = var_10[0];
  var_12 = var_10[1];
  var_13 = var_11 / var_12;
  var_14 = -0.5 * (var_8 * var_13 - var_7);
  var_15 = var_0 / var_11 * var_7 + (1.0 - var_0 / (var_11 * 0.5)) * var_14;
  var_16 = var_1 / var_12 * var_8;

  if(isDefined(level._id_0B51) == 0) {
    level._id_0B51 = [];
  }

  level thread _id_0D51();
  var_17 = _id_0D50(var_6);
  var_17.x = var_15;
  var_17.y = var_16;
  var_17 settext(var_2);
  var_17.color = var_3;
  var_17.alpha = var_4;
  var_17.fontscale = var_5 * 0.5;
  var_17.font = "smallfixed";
  var_17.alignx = "left";
  var_17.aligny = "bottom";
  var_17._id_7A33 = "fullscreen";
  var_17.vertalign = "fullscreen";
  var_17.xoffset = 0;
  var_17.yoffset = 0;
  var_17._id_10FD6 = 0;
  var_17._id_10FF9 = 0;
}