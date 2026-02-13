/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\ai_lookat.gsc
*************************************************/

_id_5258(var_0, var_1) {
  _id_5257(level.player, var_0, var_1);
}

_id_4AC8() {
  _id_4AC7(level.player);
}

_id_5257(var_0, var_1, var_2) {
  if(!isDefined(self._id_97ED)) {
    self._id_97ED = [];
  }

  if(!self._id_97ED.size) {
    self _meth_87EE(1);
  }

  self._id_97ED[self._id_97ED.size] = var_0;

  if(isDefined(var_1)) {
    self _meth_87ED(var_1);
  }

  if(isDefined(var_2)) {
    self _meth_87EC(var_2);
  }

  if(isPlayer(var_0)) {
    self _meth_882F(1);
  } else {
    self setlookatentity(var_0);
  }
}

_id_4AC7(var_0) {
  if(!isDefined(self._id_97ED) || !scripts\engine\utility::array_contains(self._id_97ED, var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::_id_1BAD(self._id_97ED) == var_0;
  self._id_97ED = scripts\engine\utility::_id_1BC8(self._id_97ED, var_0);

  if(var_1) {
    if(isPlayer(var_0)) {
      self _meth_882F(0);
    }

    if(self._id_97ED.size > 0) {
      var_2 = scripts\engine\utility::_id_1BAD(self._id_97ED);

      if(isPlayer(var_2)) {
        self _meth_882F(1);
      } else {
        self setlookatentity(var_2);
      }
    }
  }

  if(!self._id_97ED.size) {
    self _meth_87EE(0);
    self stoplookat();
  }
}

_id_7CCC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("death");
  self endon("stop_idle_lookat");
  var_12 = 1;
  var_13 = 2;
  var_14 = 2000;
  var_15 = 0;
  var_16 = 1;
  var_17 = 2;
  var_18 = 3;
  var_19 = 4;
  var_20 = 5;
  var_21 = 6;
  var_22 = 7;
  var_23 = 8;
  var_24 = 9;
  var_25 = var_15;
  var_26 = var_15;
  var_27 = 0;
  var_0 = int(var_0) * 1000;
  var_1 = int(var_1) * 1000;
  var_2 = int(var_2) * 1000;
  var_3 = int(var_3) * 1000;

  for(;;) {
    var_28 = distance(level.player.origin, self.origin);
    var_29 = var_13;

    if(var_28 > var_4) {
      var_29 = var_12;
    }

    var_30 = anglesToForward(self.angles);
    var_31 = anglesToForward(level.player.angles);
    var_32 = vectornormalize(level.player.origin - self.origin);
    var_33 = vectordot(var_30, var_32) > var_10 && var_28 < var_5;
    var_34 = vectordot(var_31, -1.0 * var_32) > var_11;

    if(var_25 == var_15) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_33) {
        var_26 = var_17;
      }
    } else if(var_25 == var_16) {
      if(var_33) {
        var_26 = var_17;
      }
    } else if(var_25 == var_17 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_18;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_21;
      } else if(var_29 == var_12) {
        var_26 = var_23;
      }
    } else if(var_25 == var_18) {
      if(var_29 != var_13 || !var_33 || !var_34) {
        var_26 = var_19;
      }
    } else if(var_25 == var_19 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_18;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_22;
      } else if(var_29 == var_12) {
        var_26 = var_24;
      }
    } else if(var_25 == var_20 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_18;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_22;
      } else if(var_29 == var_12) {
        var_26 = var_24;
      }
    } else if(var_25 == var_21 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_22;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_18;
      } else if(var_29 == var_12) {
        var_26 = var_24;
      }
    } else if(var_25 == var_22 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_20;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_21;
      } else if(var_29 == var_12) {
        var_26 = var_24;
      }
    } else if(var_25 == var_23 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_12) {
        var_26 = var_24;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_18;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_22;
      }
    } else if(var_25 == var_24 && var_27 < gettime()) {
      if(!var_33) {
        var_26 = var_16;
      } else if(var_29 == var_12) {
        var_26 = var_23;
      } else if(var_29 == var_13 && !var_34) {
        var_26 = var_22;
      } else if(var_29 == var_13 && var_34) {
        var_26 = var_20;
      }
    }

    if(var_25 != var_26) {
      if(var_25 == var_15) {
        if(var_26 == var_16) {
          _id_4AC8();
        } else if(var_26 == var_17) {
          var_27 = gettime() + var_14;
        }
      } else if(var_25 == var_16) {
        if(var_26 == var_17) {
          var_27 = gettime() + var_14;
        }
      } else if(var_25 == var_17) {
        if(var_26 == var_16) {
          _id_4AC8();
        } else if(var_26 == var_18) {
          _id_5258(var_6, var_8);
        } else if(var_26 == var_21) {
          _id_5258(var_6, var_8);
          var_27 = gettime() + var_0;
        } else if(var_26 == var_23) {
          _id_5258(var_7, var_9);
          var_27 = gettime() + var_1;
        }
      } else if(var_25 == var_18) {
        if(var_26 == var_19) {
          var_27 = gettime() + var_14;
        }
      } else if(var_25 == var_19) {
        if(var_26 == var_16) {
          _id_4AC8();
        } else if(var_26 == var_22) {
          _id_4AC8();
          var_27 = gettime() + var_0;
        } else if(var_26 == var_24) {
          _id_4AC8();
          var_27 = gettime() + var_0;
        }
      } else if(var_25 == var_20) {
        if(var_26 == var_18) {
          _id_5258(var_6, var_8);
        } else if(var_26 == var_22) {
          var_27 = gettime() + var_2;
        } else if(var_26 == var_24) {
          var_27 = gettime() + var_3;
        }
      } else if(var_25 == var_21) {
        if(var_26 == var_16) {
          _id_4AC8();
        } else if(var_26 == var_22) {
          _id_4AC8();
          var_27 = gettime() + var_2;
        } else if(var_26 == var_24) {
          _id_4AC8();
          var_27 = gettime() + var_3;
        }
      } else if(var_25 == var_22) {
        if(var_26 == var_20) {
          var_27 = gettime() + var_14;
        } else if(var_26 == var_21) {
          _id_5258(var_6, var_8);
          var_27 = gettime() + var_0;
        } else if(var_26 == var_24)
          var_27 = gettime() + var_3;
      } else if(var_25 == var_23) {
        if(var_26 == var_16) {
          _id_4AC8();
        } else if(var_26 == var_24) {
          _id_4AC8();
          var_27 = gettime() + var_3;
        } else if(var_26 == var_18) {} else if(var_26 == var_22) {
          _id_4AC8();
          var_27 = gettime() + var_2;
        }
      } else if(var_25 == var_24) {
        if(var_26 == var_23) {
          _id_5258(var_7, var_9);
          var_27 = gettime() + var_1;
        } else if(var_26 == var_22)
          var_27 = gettime() + var_2;
        else if(var_26 == var_20) {
          var_27 = gettime() + var_14;
        }
      }

      var_25 = var_26;
    }

    waitframe();
  }
}

_id_37BC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_idle_lookat");
  var_7 = 0;
  var_8 = 1;
  var_9 = 2;
  var_10 = 3;
  var_11 = 2000;
  var_12 = var_7;
  var_13 = var_7;
  var_14 = 0;
  var_0 = int(var_0) * 1000;
  var_1 = int(var_1) * 1000;

  for(;;) {
    var_15 = distance(level.player.origin, self.origin);
    var_16 = anglesToForward(self.angles);
    var_17 = anglesToForward(level.player.angles);
    var_18 = vectornormalize(level.player.origin - self.origin);
    var_19 = vectordot(var_16, var_18) > var_5 && var_15 < var_2;
    var_20 = vectordot(var_17, -1.0 * var_18) > var_6;
    var_19 = var_19 && var_20;

    if(var_12 == var_7) {
      if(var_19) {
        var_13 = var_8;
      }
    } else if(var_12 == var_8 && var_14 < gettime()) {
      if(var_19) {
        var_13 = var_9;
      } else {
        var_13 = var_7;
      }
    } else if(var_12 == var_9 && var_14 < gettime()) {
      if(var_19) {
        var_13 = var_10;
      } else {
        var_13 = var_7;
      }
    } else if(var_12 == var_10 && var_14 < gettime()) {
      if(var_19) {
        var_13 = var_9;
      } else {
        var_13 = var_7;
      }
    }

    if(var_12 != var_13) {
      if(var_12 == var_7) {
        if(var_13 == var_8) {
          var_14 = gettime() + var_11;
        }
      } else if(var_12 == var_8) {
        if(var_13 == var_9) {
          _id_5258(var_3, var_4);
          var_14 = gettime() + var_0;
        }
      } else if(var_12 == var_9) {
        if(var_13 == var_10) {
          _id_4AC8();
          var_14 = gettime() + var_1;
        } else if(var_13 == var_7)
          _id_4AC8();
      } else if(var_12 == var_10) {
        if(var_13 == var_9) {
          _id_5258(var_3, var_4);
          var_14 = gettime() + var_0;
        }
      }

      var_12 = var_13;
    }

    waitframe();
  }
}