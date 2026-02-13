/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2077.gsc
*************************************************/

_id_CA52() {
  var_0 = 0;
  var_1 = [];

  for(;;) {
    if(getdvarint("#x333a090a2525203e7", 0) == 1) {
      var_2 = level.players[0] _id_6CE4();
      var_1[var_1.size] = var_2;
      var_0 = _id_6DF3(var_1);
      iprintlnbold("Total Distance: " + var_0);
      setDvar("#x333a090a2525203e7", 0);
    }

    if(var_1.size > 0) {
      for(var_3 = 0; var_3 < var_1.size - 1; var_3++) {
        var_4 = var_1[var_3];
        var_5 = var_1[var_3 + 1];
        thread scripts\mp\utility\debug::_id_4F43(var_4, var_5, level._id_5F3A, (1, 0, 0));
        var_6 = (var_4 + var_5) / 2;
      }
    }

    waitframe();
  }
}

_id_6CE4() {
  var_0 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 0, 0);
  var_1 = anglesToForward(self getplayerangles());
  var_2 = self getEye() + var_1 * 90000;
  var_3 = _func_02C1(self getEye(), var_2, var_0, undefined, 0, "physicsquery_closest", 0);
  var_4 = isDefined(var_3) && var_3.size > 0;

  if(var_4) {
    var_5 = var_3[0]["position"];
    thread scripts\mp\utility\debug::_id_4F43(self getEye(), var_5, 5, (0, 1, 0));
    return var_5;
  }

  return (0, 0, 0);
}

_id_6DF3(var_0) {
  if(isDefined(var_0)) {
    if(var_0.size > 1) {
      var_1 = 0;

      for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
        var_1 = var_1 + distance(var_0[var_2], var_0[var_2 + 1]);
      }

      return var_1;
    } else if(var_0.size > 0)
      return 0;
  }

  return 0;
}