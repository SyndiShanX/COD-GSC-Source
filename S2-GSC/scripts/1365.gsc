/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1365.gsc
**************************************/

_id_531F() {}

_id_83DD(var_0, var_1, var_2, var_3) {
  var_4 = _func_1B1("mp/zombieNotificationTable.csv", 1, var_0);

  if(var_4 != -1) {
    var_5 = int(_func_1AE("mp/zombieNotificationTable.csv", var_4, 0));
    var_6 = -1;
    var_7 = int(_func_1AE("mp/zombieNotificationTable.csv", var_4, 11));

    if(isDefined(var_7) && var_7 == 1 && isPlayer(var_1))
      var_1.interactneedrelease = 1;

    if(isDefined(var_1)) {
      if(isPlayer(var_1))
        var_6 = var_1 getentitynumber();
      else if(_func_2A2(var_1))
        var_6 = var_1;
    }

    if(isDefined(var_3)) {
      _func_327(&"zm_player_notification", 4, var_5, var_6, var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      _func_327(&"zm_player_notification", 3, var_5, var_6, var_2);
      return;
    }

    _func_226(&"zm_player_notification", 2, var_5, var_6);
    return;
    return;
  } else {}
}