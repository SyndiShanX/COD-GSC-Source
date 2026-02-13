/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2507.gsc
*************************************************/

_magicbullet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_0143(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_5) && isDefined(var_3)) {
    var_5 setotherent(var_3);
  }

  return var_5;
}

_id_8916(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(_func_0121(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = var_0.basename;
  }

  switch (var_2) {
    case "iw8_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeoks_mp":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
  }

  return var_1;
}

_id_10E5(var_0, var_1) {
  if(!isDefined(var_0._id_8914)) {
    var_0._id_8914 = 0;
    var_0._id_1DE0 = [];
  }

  if(var_0._id_8914 == 0) {
    if(isDefined(var_0._id_96F6)) {
      var_0 thread[[var_0._id_96F6]]();
    }
  }

  if(isDefined(var_1)) {
    var_1._id_550E = var_0;
    var_0._id_1DE0[var_1 getentitynumber()] = var_1;
  }

  var_0._id_8914++;
}

_id_C4E1(var_0, var_1) {
  if(!isDefined(var_0._id_8914)) {
    return;
  }
  if(var_0._id_8914 == 1) {
    if(isDefined(var_0._id_96F7)) {
      var_0 thread[[var_0._id_96F7]]();
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_550E) && var_1._id_550E == var_0) {
      var_1._id_550E = undefined;
    }

    var_0._id_1DE0[var_1 getentitynumber()] = undefined;
  }

  var_0._id_8914--;
}

_id_D5E7(var_0, var_1) {
  var_0._id_96F6 = var_1;
}

_id_D5E8(var_0, var_1) {
  var_0._id_96F7 = var_1;
}

_id_3954(var_0) {
  var_0 notify("clearLockedOn");

  if(_id_8915(var_0)) {
    if(isDefined(var_0._id_96F7)) {
      var_0 thread[[var_0._id_96F7]]();
    }

    foreach(var_3, var_2 in var_0._id_1DE0) {
      if(isDefined(var_2)) {
        if(isDefined(var_2._id_550E) && var_2._id_550E == var_0) {
          var_2._id_550E = undefined;
        }
      }
    }
  }

  var_0._id_8914 = undefined;
  var_0._id_1DE0 = undefined;
  var_0._id_96F6 = undefined;
  var_0._id_96F7 = undefined;

  if(_id_7575(var_0)) {
    if(isDefined(var_0._id_7DAA)) {
      var_0 thread[[var_0._id_7DAA]]();
    }
  }

  var_0._id_7575 = undefined;
  var_0._id_7DA3 = undefined;
  var_0._id_7DAA = undefined;
}

_id_3955(var_0) {
  if(isDefined(self._id_550E)) {
    _id_C4E1(self._id_550E, self);
  }

  self._id_550E = undefined;
}

_id_8915(var_0) {
  return isDefined(var_0._id_8914) && var_0._id_8914 > 0;
}

_id_10BE(var_0) {
  if(!isDefined(var_0._id_7575)) {
    var_0._id_7575 = 0;
  }

  if(var_0._id_7575 == 0) {
    if(isDefined(var_0._id_7DA3)) {
      var_0 thread[[var_0._id_7DA3]]();
    }
  }

  var_0._id_7575++;
}

_id_C4D3(var_0) {
  if(!isDefined(var_0._id_7575)) {
    return;
  }
  if(var_0._id_7575 == 1) {
    if(isDefined(var_0._id_7DAA)) {
      var_0 thread[[var_0._id_7DAA]]();
    }
  }

  var_0._id_7575--;
}

_id_D5B5(var_0, var_1) {
  var_0._id_7DA3 = var_1;
}

_id_D5B6(var_0, var_1) {
  var_0._id_7DAA = var_1;
}

_id_7575(var_0) {
  return isDefined(var_0._id_7575) && var_0._id_7575 > 0;
}

_id_10C14(var_0, var_1) {
  var_0 endon("clearLockedOn");
  _id_10E5(var_0);
  _id_10BE(var_0);
  var_1 scripts\engine\utility::waittill_any_2("death", "clearTargetLockedOntoByProjectile");

  if(isDefined(var_0)) {
    _id_C4E1(var_0);
    _id_C4D3(var_0);
  }
}

_id_3971(var_0) {
  var_0 notify("clearTargetLockedOntoByProjectile");
}

_id_5076(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_3 = randomfloatrange(150, 350);
  var_4 = randomfloatrange(150, 250);

  if(scripts\engine\utility::cointoss()) {
    var_4 = var_4 * -1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_5 = scripts\engine\math::_id_A5C5(0, 200, var_1);
  var_6 = scripts\engine\math::_id_5898(950, 1300, var_5);
  var_7 = var_0 _meth_8491();

  if(isDefined(var_7)) {
    var_7 = var_7["unscaled"];
  } else {
    var_7 = var_0.origin;
  }

  var_8 = (0, 0, 0);
  var_8 = var_8 + anglesToForward(var_2) * var_3;
  var_8 = var_8 + anglestoright(var_2) * var_4;
  var_8 = var_8 + anglestoup(var_2) * var_6;
  var_9 = var_0 gettagangles("tag_flash", 1);

  if(!isDefined(var_9)) {
    var_9 = var_0.angles;
  }

  var_10 = scripts\engine\math::_id_5898(-7.0, -5.0, var_5);
  var_11 = scripts\engine\math::_id_5898(0.75, 1.1, var_5);

  if(scripts\engine\utility::cointoss()) {
    var_11 = var_11 * -1;
  }

  var_12 = var_7;
  var_12 = var_12 + anglesToForward(var_9) * var_10;
  var_12 = var_12 + anglestoright(var_9) * var_11;
  var_0 _meth_8256(var_12, var_8);
}