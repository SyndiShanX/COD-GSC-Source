/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 15.gsc
*************************************************/

_id_990C(var_0, var_1) {
  if(!isDefined(level._id_990B)) {
    level._id_990B = [];
  }

  if(!isDefined(level._id_990B[var_0]) || !scripts\engine\utility::array_contains(level._id_990B[var_0], var_1)) {
    level._id_990B[var_0] = ::scripts\engine\utility::_id_1B8D(level._id_990B[var_0], var_1);
  }
}

_id_0289(var_0, var_1, var_2) {
  if(isDefined(self)) {
    if(isDefined(level._id_990B) && isDefined(level._id_990B[var_0])) {
      foreach(var_4 in level._id_990B[var_0]) {
        if(isDefined(var_2)) {
          self thread[[var_4]](var_1, var_2);
          continue;
        }

        self thread[[var_4]](var_1);
      }
    }

    if(isDefined(var_2)) {
      self notify("luinotifyserver", var_0, var_1, var_2);
    } else {
      self notify("luinotifyserver", var_0, var_1);
    }
  }
}