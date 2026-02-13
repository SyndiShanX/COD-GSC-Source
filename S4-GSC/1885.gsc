/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1885.gsc
*************************************************/

_id_DE2F(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self._id_7BDD = 1;
  self._id_A50F = 1;
  self._id_0201 = 64;
  self._id_0206 = 255;
  self._id_CD57 = 1;
  self._id_7179 = 200;

  for(;;) {
    if(!isDefined(self._id_0192)) {
      wait 0.5;
      self._id_7BDD = 0;
      continue;
    }

    self._id_7BDD = 1;
    self._id_CD57 = 1;
    var_2 = scripts\engine\utility::ter_op(randomint(2) > 0, "left", "right");
    var_3 = _id_6A46(self._id_0192, var_2);

    if(_func_02E1(var_3)) {
      var_4 = var_3.origin;
    } else {
      var_4 = var_3;
    }

    self _meth_8326(var_4);
    var_5 = scripts\engine\utility::_id_10897("goal_reached", "goal");
    _id_10B0E();
  }
}

_id_4F3E(var_0) {
  level endon("game_ended");
  self endon("change_flanking_pos");

  for(;;) {
    waitframe();
  }
}

_id_6A47(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2) && var_2 == "left") {
    var_3 = _func_02AB(scripts\cp\utility::_id_66AD(var_0, (0, var_1, 0)));
  } else {
    var_3 = _func_02AB(scripts\cp\utility::_id_66AD(var_0, (0, var_1 * -1, 0)));
  }

  var_4 = _func_00B3("flanking_node", "targetname");

  if(var_4.size > 0) {
    var_4 = _func_0204(var_4, var_3);
    var_5 = var_4[0];

    if(distance(var_5.origin, var_3) <= 1024) {
      return var_5;
    }
  }

  return var_3;
}

_id_6B4F(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::_id_6C61(var_0);

  foreach(var_4 in var_2) {
    var_1 = var_1 + var_4.origin;
  }

  var_1 = var_1 / var_2.size;
  var_1 = scripts\engine\utility::_id_5000(var_1);
  return var_1;
}

_id_68EE(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::_id_6C61(var_0);

  foreach(var_4 in var_2) {
    var_5 = anglesToForward(var_4.angles);
    var_1 = var_1 + var_5;
  }

  var_1 = var_1 - (0, 0, var_1[2]);
  return var_1;
}

_id_6B5D(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6C61(var_0);
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_6 = distance(var_1, var_5.origin);

    if(var_6 > var_3 && var_6 <= 1024) {
      var_3 = var_6;
    }
  }

  return var_3;
}

_id_6A46(var_0, var_1) {
  var_2 = undefined;
  var_3 = _id_6B4F(var_0.team);
  var_4 = _id_6B5D(var_0.team, var_3);

  if(isDefined(var_1) && var_1 == "left") {
    var_2 = _func_02AB(scripts\cp\utility::_id_66AD(var_0, (0, var_4, 0)));
  } else {
    var_2 = _func_02AB(scripts\cp\utility::_id_66AD(var_0, (0, var_4 * -1, 0)));
  }

  var_5 = _func_00B3("flanking_node", "targetname");

  if(var_5.size > 0) {
    var_5 = _func_0204(var_5, var_2);
    var_6 = var_5[0];

    if(distance(var_6.origin, var_2) <= 1024) {
      return var_6;
    }
  }

  var_7 = _func_00B4(var_3, 1024, 512);

  if(var_7.size > 0) {
    foreach(var_9 in var_7) {
      if(istrue(var_9._id_895B)) {
        var_7 = scripts\engine\utility::array_remove(var_7, var_9);
      }
    }

    var_7 = _func_0204(var_7, var_3);
    var_6 = var_7[0];

    if(distance(var_6.origin, var_2) <= 1024) {
      return var_6;
    }
  }

  return var_2;
}

_id_10B0E() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isDefined(self._id_0192)) {
      if(distance(self.origin, self._id_0192.origin) > 512) {
        self notify("change_flanking_pos");
        return;
      }
    }

    wait 3;
  }
}