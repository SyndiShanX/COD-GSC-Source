/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1365.gsc
*********************************************/

lib_0555::func_531F() {}

lib_0555::func_83DD(param_00, param_01, param_02, param_03) {
  var_04 = tablelookuprownum("mp/zombieNotificationTable.csv", 1, param_00);
  if(var_04 != -1) {
    var_05 = int(tablelookupbyrow("mp/zombieNotificationTable.csv", var_04, 0));
    var_06 = -1;
    var_07 = int(tablelookupbyrow("mp/zombieNotificationTable.csv", var_04, 11));
    if(isDefined(var_07) && var_07 == 1 && isPlayer(param_01)) {
      param_01.interactneedrelease = 1;
    }

    if(isDefined(param_01)) {
      if(isPlayer(param_01)) {
        var_06 = param_01 getentitynumber();
      } else if(function_02A2(param_01)) {
        var_06 = param_01;
      }
    }

    if(isDefined(param_03)) {
      function_0327(&"zm_player_notification", 4, var_05, var_06, param_02, param_03);
      return;
    }

    if(isDefined(param_02)) {
      function_0327(&"zm_player_notification", 3, var_05, var_06, param_02);
      return;
    }

    function_0226(&"zm_player_notification", 2, var_05, var_06);
    return;
  }
}