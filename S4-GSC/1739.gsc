/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1739.gsc
*************************************************/

_id_2F23(var_0, var_1) {
  _id_0BC4(level, var_0, var_1);

  if(self != level) {
    _id_0BC4(self, var_0, var_1);
  }
}

_id_2F34(var_0, var_1) {
  var_2 = _func_0070();

  foreach(var_4 in var_2) {
    var_4 _id_0BC4(var_4, var_0, var_1);
  }
}

_id_2F35(var_0, var_1) {
  var_2 = level.players;

  foreach(var_4 in var_2) {
    var_4 _id_0BC4(level, var_0, var_1);
    var_4 _id_0BC4(var_4, var_0, var_1);
  }
}

_id_0BC4(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_0._id_0B78)) {
    var_3 = var_0._id_0B78[var_1];
  }

  if(isDefined(var_3)) {
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(!_func_0107(var_5)) {
        continue;
      }
      var_6 = var_5[0];

      if(!_func_03AC(var_6)) {
        return;
      }
      var_7 = var_5[1];
      var_8 = var_5[2];

      if(!isDefined(var_8)) {
        var_8 = [];
      }

      if(isDefined(var_7)) {
        if(isDefined(var_2)) {
          scripts\engine\utility::_id_DD5D(var_7, var_6, self, var_2, var_8);
        } else {
          scripts\engine\utility::_id_DD5C(var_7, var_6, self, var_8);
        }

        continue;
      }

      if(isDefined(var_2)) {
        scripts\engine\utility::_id_DD5C(self, var_6, var_2, var_8);
        continue;
      }

      scripts\engine\utility::_id_DD5B(self, var_6, var_8);
    }

    var_0._id_0B78[var_1] = _id_0CA5(var_3);
  }
}

_id_0FA4(var_0, var_1, var_2, var_3) {
  _id_0B1A(level, var_0, var_1, var_2, var_3);
}

_id_0FA5(var_0, var_1, var_2, var_3) {
  _id_0B1A(self, var_0, var_1, var_2, var_3);
}

_id_0B1A(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_func_03AC(var_2)) {
    return;
  }
  if(!isDefined(var_0._id_0B78) || !isDefined(var_0._id_0B78[var_1])) {
    var_0._id_0B78[var_1] = [];
  }

  foreach(var_6 in var_0._id_0B78[var_1]) {
    if(_func_0107(var_6) && var_6[0] == var_2) {
      if(!isDefined(var_3) || var_6[1] == var_3) {
        return;
      }
    }
  }

  var_0._id_0B78[var_1][var_0._id_0B78[var_1].size] = [var_2, var_3, var_4];

  if(isDefined(var_3)) {
    var_3 thread _id_C389(var_1, var_2);
  }
}

_id_0BFB(var_0, var_1) {
  return scripts\engine\utility::_id_EA52(var_0) + scripts\engine\utility::_id_EA52(var_1);
}

_id_C389(var_0, var_1) {
  self notify(_id_0BFB(var_0, var_1));
  self endon(_id_0BFB(var_0, var_1));
  scripts\engine\utility::waittill_any_2("death", "remove_callbacks");
  _id_C388(var_0, var_1, self);
}

_id_C388(var_0, var_1, var_2) {
  _id_0CB6(level, var_0, var_1, var_2);
}

_id_C38A(var_0, var_1, var_2, var_3) {
  _id_0CB6(self, var_0, var_1, var_2, var_3);
}

_id_0CB6(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0._id_0B78)) {
    return;
  }
  if(isDefined(var_2) && _func_0121(var_2) && var_2 == "all") {
    var_0._id_0B78[var_1] = [];
    return;
  }

  if(!isDefined(var_0._id_0B78[var_1])) {
    return;
  }
  if(istrue(var_4)) {
    var_0._id_0B78[var_1] = _id_0CA5(var_0._id_0B78[var_1]);
    return;
  }

  foreach(var_7, var_6 in var_0._id_0B78[var_1]) {
    if(_func_0107(var_6) && var_6[0] == var_2) {
      if(!isDefined(var_6[1]) && !isDefined(var_3) || isDefined(var_6[1]) && var_6[1] == var_3) {
        if(isDefined(var_3)) {
          var_3 notify(_id_0BFB(var_1, var_2));
        }

        var_0._id_0B78[var_1][var_7] = 0;
        break;
      }
    }
  }
}

_id_0CA5(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isint(var_3) && var_3 == 0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_AA4E(var_0, var_1) {
  _id_0FA4("on_player_connect", var_0, var_1);
}

_id_C41A(var_0, var_1) {
  _id_C388("on_player_connect", var_0, var_1);
}

_id_AA51(var_0, var_1) {
  _id_0FA4("on_player_disconnect", var_0, var_1);
}

_id_C41B(var_0, var_1) {
  _id_C388("on_player_disconnect", var_0, var_1);
}

_id_AA65(var_0, var_1) {
  _id_0FA4("on_player_spawned", var_0, var_1);
}

_id_C41D(var_0, var_1) {
  _id_C388("on_player_spawned", var_0, var_1);
}

on_ai_spawned(var_0, var_1) {
  _id_0FA4("on_ai_spawned", var_0, var_1);
}

remove_on_ai_spawned(var_0, var_1) {
  _id_C388("on_ai_spawned", var_0, var_1);
}

_id_AA4A(var_0, var_1) {
  _id_0FA4("on_ai_killed", var_0, var_1);
}

_id_C417(var_0, var_1) {
  _id_C388("on_ai_killed", var_0, var_1);
}

_id_AA49(var_0, var_1) {
  _id_0FA4("on_ai_damage", var_0, var_1);
}

_id_C416(var_0, var_1) {
  _id_C388("on_ai_damage", var_0, var_1);
}

_id_AA4C(var_0, var_1) {
  _id_0FA4("on_player_bleedout", var_0, var_1);
}

on_host_migration_end(var_0, var_1) {
  _id_0FA4("on_host_migration_end", var_0, var_1);
}