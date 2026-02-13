/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1889.gsc
*************************************************/

_id_3D22() {}

_id_8D96() {
  foreach(var_1 in level._id_E2A4) {
    var_1 dodamage(var_1.health + 990, var_1.origin, var_1, var_1, "MOD_SUICIDE");
  }
}

_id_6E4A(var_0) {
  var_1 = strtok(var_0._id_0398, "_");

  if(var_1.size < 2) {
    var_2 = var_1[0];
  } else if(scripts\engine\utility::string_starts_with(var_1[0], "pf")) {
    var_2 = var_1[1];

    for(var_3 = 2; var_3 < var_1.size; var_3++) {
      var_2 = var_2 + "_" + var_1[var_3];
    }
  } else
    var_2 = var_0._id_0398;

  return var_2;
}

_id_A221(var_0) {
  var_1 = _func_02AB(var_0.origin);
  self dontinterpolate();
  self setorigin(var_0.origin, 1);
  self _meth_82BE(var_0.origin);
  self._id_0229 = 0;
}

_id_628D(var_0, var_1) {
  var_2 = 50;
  var_3 = 50;
  var_4 = spawnStruct();
  var_4.angles = var_1;
  var_5 = var_4.origin;
  var_6 = 0;

  while(!var_6) {
    var_7 = randomintrange(var_2 * -1, var_2);
    var_8 = randomintrange(var_3 * -1, var_3);
    var_5 = _func_02AB((var_0[0] + var_7, var_0[1] + var_8, var_0[2]));
    var_6 = 1;

    foreach(var_10 in level.players) {
      if(_func_01A5(var_5)) {
        var_6 = 0;
      }
    }

    if(!var_6) {
      wait 0.1;
    }
  }

  var_4.origin = var_5 + (0, 0, 5);
  return var_4;
}