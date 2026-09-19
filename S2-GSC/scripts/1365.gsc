/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1365.gsc
**************************************/

_id_531F() {}

issprinting(var_0, var_1, var_2, var_3) {
  var_4 = _tablelookuprownum("mp/zombieNotificationTable.csv", 1, var_0);

  if(var_4 != -1) {
    var_5 = int(_tablelookupbyrow("mp/zombieNotificationTable.csv", var_4, 0));
    var_6 = -1;
    var_7 = int(_tablelookupbyrow("mp/zombieNotificationTable.csv", var_4, 11));

    if(isDefined(var_7) && var_7 == 1 && isPlayer(var_1))
      var_1.interactneedrelease = 1;

    if(isDefined(var_1)) {
      if(isPlayer(var_1))
        var_6 = var_1 getentitynumber();
      else if(_isnumber(var_1))
        var_6 = var_1;
    }

    if(isDefined(var_3)) {
      _luinotifyeventextra(&"zm_player_notification", 4, var_5, var_6, var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      _luinotifyeventextra(&"zm_player_notification", 3, var_5, var_6, var_2);
      return;
    }

    _luinotifyevent(&"zm_player_notification", 2, var_5, var_6);
    return;
    return;
  } else {}
}