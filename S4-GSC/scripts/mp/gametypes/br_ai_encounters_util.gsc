/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters_util.gsc
**********************************************************/

_id_6313() {
  if(isDefined(self._id_5274._id_7E9E.team)) {
    return self._id_5274._id_7E9E.team;
  }

  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_0[var_2] = 0;
  }

  foreach(var_5 in level.players) {
    var_2 = var_5.pers["team"];

    if(!isDefined(var_2) || var_2 == "spectator") {
      continue;
    }
    var_0[var_2]++;
  }

  foreach(var_2, var_8 in var_0) {
    if(var_8 == 0) {
      self._id_5274._id_7E9E.team = var_2;
      break;
    }
  }

  if(!isDefined(self._id_5274._id_7E9E.team)) {
    self._id_5274._id_7E9E.team = scripts\engine\utility::random(level._id_EF89);
  }

  return self._id_5274._id_7E9E.team;
}

_id_67B6() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_3 in var_1) {
      var_0[var_0.size] = var_3;
    }

    var_5 = getEntArray(self.target, "targetname");

    foreach(var_7 in var_5) {
      var_0[var_0.size] = var_7;
    }

    var_9 = _func_00B3(self.target, "targetname");

    foreach(var_11 in var_9) {
      var_0[var_0.size] = var_11;
    }
  }

  return var_0;
}

_id_6E35(var_0) {
  if(!isDefined(var_0)) {
    return "undefined";
  } else if(_func_03AC(var_0)) {
    return "function";
  } else if(_func_03AD(var_0)) {
    return "builtin function";
  } else if(_func_03AE(var_0)) {
    return "builtin method";
  } else if(_func_03AF(var_0)) {
    return "animation";
  } else if(_func_0107(var_0)) {
    return "array";
  } else if(_func_02DE(var_0)) {
    var_1 = "struct";
  } else if(isvector(var_0)) {
    var_1 = "vector";
  } else if(isent(var_0)) {
    var_1 = "entity";
  } else if(_func_02E1(var_0)) {
    var_1 = "node";
  } else if(isint(var_0)) {
    var_1 = "int";
  } else if(_func_0110(var_0)) {
    var_1 = "float";
  } else if(_func_0121(var_0)) {
    var_1 = "string";
  } else if(_func_0115(var_0)) {
    var_1 = "istring";
  } else {
    var_1 = "unknown";
  }

  return var_1;
}

_id_FFCB(var_0) {
  var_1 = _id_6E35(var_0);

  switch (var_1) {
    case "array":
      return _id_0B41(var_0);
    case "vector":
      return "(" + var_0[0] + "," + var_0[1] + "," + var_0[2] + ")";
    case "float":
    case "int":
      return "" + var_0;
    case "string":
      return var_0;
    case "entity":
      return "$e" + var_0 getentitynumber();
    default:
      return "<" + var_1 + ">";
  }
}

_id_0B41(var_0) {
  var_1 = "[ ";
  var_2 = 1;

  foreach(var_5, var_4 in var_0) {
    if(!var_2) {
      var_1 = var_1 + ",";
    } else {
      var_2 = 0;
    }

    var_1 = var_1 + _id_FFCB(var_4);
  }

  var_1 = var_1 + " ]";
  return var_1;
}

_id_527F(var_0) {
  _func_02B1(var_0);
  self notify("nav_obstacle_destroy_" + var_0);
}

_id_5281(var_0) {
  self endon("nav_obstacle_destroy_" + var_0);
  self waittill("encounter_end");
  _id_527F(var_0);
}

_id_5280(var_0, var_1) {
  self endon("nav_obstacle_destroy_" + var_0);
  self endon("encounter_end");
  wait(var_1);
  _id_527F(var_0);
}

_id_527D(var_0) {
  var_0 endon("death");
  self waittill("encounter_end");
  var_0 delete();
}

_id_4AE3(var_0) {
  foreach(var_2 in level.players) {
    var_0 _meth_86A8(var_2);
  }
}

_id_526A(var_0) {
  foreach(var_2 in level.players) {
    var_0 _meth_86A7(var_2);
  }
}

_id_108BD(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread _id_108C1(var_2);
  }

  var_10._id_011A = var_0.size;

  if(isDefined(var_1) && var_1 < var_10._id_011A) {
    var_10._id_011A = var_1;
  }

  scripts\engine\utility::_id_1BE2(var_0, ::_id_108C0, var_10);

  while(var_10._id_011A > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

_id_108BE(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5._id_022C) {
      var_3[var_3.size] = var_5;
    }
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread _id_108C1(var_2);
  }

  var_7._id_011A = var_0.size;

  if(isDefined(var_1) && var_1 < var_7._id_011A) {
    var_7._id_011A = var_1;
  }

  scripts\engine\utility::_id_1BE2(var_0, ::_id_108BF, var_7);

  while(var_7._id_011A > 0) {
    var_7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

_id_108F2(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

_id_6566(var_0, var_1) {
  var_2 = _id_6567(var_0, var_1);

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

_id_6567(var_0, var_1) {
  var_2 = _func_0073("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5._id_0481) && var_5._id_0481 == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_5._id_039B) && var_5._id_039B == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
      case "animname":
        if(isDefined(var_5._id_18AF) && var_5._id_18AF == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
    }
  }

  return var_3;
}

_id_108C0(var_0) {
  self waittill("death");
  var_0._id_011A--;
  var_0 notify("waittill_dead guy died");
}

_id_108BF(var_0) {
  scripts\engine\utility::_id_108C5("death", "long_death");
  var_0._id_011A--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

_id_108C1(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}