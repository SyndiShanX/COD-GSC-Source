/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_scripted_agent_anim_util.gsc
****************************************************************/

_id_5159(var_0) {
  var_1 = "actiontables/" + var_0 + ".csv";
  var_2 = [];
  var_3 = _tablegetrowcount(var_1);

  for(var_4 = 0; var_4 < var_3; var_4++)
    var_2[var_2.size] = _id_5DE0(var_0, var_1, var_4);

  if(!isDefined(level._id_087B))
    level._id_087B = [];

  foreach(var_6 in var_2) {
    foreach(var_8 in var_6["actions"]) {
      if(!isDefined(level._id_087B[var_0]))
        level._id_087B[var_0] = [];

      if(!isDefined(level._id_087B[var_0][var_8]))
        level._id_087B[var_0][var_8] = [];

      level._id_087B[var_0][var_8][level._id_087B[var_0][var_8].size] = var_6;
    }
  }

  var_11 = [];

  foreach(var_6 in var_2) {
    foreach(var_14 in ["move_style", "anims", "actions"]) {
      var_15 = var_6[var_14];

      if(!_isarray(var_15))
        var_15 = [var_15];

      foreach(var_17 in var_15) {
        if(var_17 != "") {
          if(!isDefined(var_11[var_14]))
            var_11[var_14] = [];

          if(isDefined(var_11[var_14][var_17])) {
            var_11[var_14][var_17]++;
            continue;
          }

          var_11[var_14][var_17] = 1;
        }
      }
    }
  }

  level._id_087E[var_0] = var_11;
}

_id_5DE0(var_0, var_1, var_2) {
  var_3 = [];
  var_3["table"] = var_0;
  var_3["actions"] = strtok(_tablelookupbyrow(var_1, var_2, 0), " ");
  var_3["state"] = _tablelookupbyrow(var_1, var_2, 1);
  var_3["flags"] = strtok(_tablelookupbyrow(var_1, var_2, 2), " ");
  var_3["anims"] = strtok(_tablelookupbyrow(var_1, var_2, 3), " ");
  var_3["dismember_states"] = strtok(_tablelookupbyrow(var_1, var_2, 4), " ");
  var_3["zombie_subtypes"] = strtok(_tablelookupbyrow(var_1, var_2, 5), " ");
  var_3["source_project"] = _tablelookupbyrow(var_1, var_2, 6);
  var_3["script_var"] = _tablelookupbyrow(var_1, var_2, 7);
  var_3["move_style"] = _tablelookupbyrow(var_1, var_2, 8);
  var_3["move_speed"] = _tablelookupbyrow(var_1, var_2, 9);
  return var_3;
}

issplitscreenplayer(var_0, var_1) {
  var_2 = var_0["script_var"];

  if(_id_0547::_id_5816(var_2))
    return 1;

  var_3 = var_1["script_var"];

  if(_id_0547::_id_5816(var_3))
    return 1;

  return var_2 == var_3;
}

_id_087A(var_0, var_1) {
  var_2 = level._id_087B[var_1];

  if(!isDefined(var_2))
    return undefined;

  return var_2[var_0];
}

_id_087C(var_0, var_1, var_2) {
  var_3 = _id_087A(var_0, var_1["action_table"]);

  if(!isDefined(var_3))
    return undefined;

  foreach(var_5 in var_3) {
    if(isDefined(var_1["dismember_state"]) && !common_scripts\utility::_id_0F79(var_5["dismember_states"], var_1["dismember_state"])) {
      continue;
    }
    if(isDefined(var_1["zombie_subtype"]) && !common_scripts\utility::_id_0F79(var_5["zombie_subtypes"], var_1["zombie_subtype"])) {
      continue;
    }
    if(isDefined(var_1["source_project"]) && var_5["source_project"] != var_1["source_project"]) {
      continue;
    }
    if(!issplitscreenplayer(var_5, var_1)) {
      continue;
    }
    if(isDefined(var_1["move_speed"]) && !_id_0547::_id_5816(var_5["move_speed"]) && var_5["move_speed"] != var_1["move_speed"]) {
      continue;
    }
    if(isDefined(var_1["move_style"]) && var_5["move_style"] != var_1["move_style"]) {
      continue;
    }
    return var_5["state"];
  }

  if(isDefined(var_1["move_style"])) {
    var_7 = var_1;
    var_7["move_style"] = undefined;
    var_5 = _id_087C(var_0, var_7, var_2);

    if(isDefined(var_5))
      return var_5;
  }

  var_8 = _id_6E76(var_1["zombie_subtype"]);

  if(isDefined(var_8)) {
    var_7 = var_1;
    var_7["zombie_subtype"] = var_8;
    var_5 = _id_087C(var_0, var_7, var_2);

    if(isDefined(var_5))
      return var_5;
  }

  if(isDefined(var_1["source_project"])) {
    var_9 = common_scripts\utility::_id_0F7E(level._id_087D, var_1["source_project"]);
    var_10 = level._id_087D[var_9 + 1];
    var_7 = var_1;
    var_7["source_project"] = var_10;
    var_5 = _id_087C(var_0, var_7, var_2);

    if(isDefined(var_5))
      return var_5;
  }

  if(isDefined(var_1["move_speed"])) {
    var_7 = var_1;
    var_7["move_speed"] = undefined;
    var_5 = _id_087C(var_0, var_7, var_2);

    if(isDefined(var_5))
      return var_5;
  }

  return undefined;
}

_id_6E76(var_0) {
  var_1 = _id_0547::_id_0A51(var_0);
  var_2 = var_1.parenttype;
  return var_2;
}

_id_4081(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = _id_087A(var_0, var_1);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      foreach(var_8 in var_6["anims"]) {
        var_9 = _func_2CB(var_2, var_8);

        if(!common_scripts\utility::_id_0F79(var_3, var_9))
          var_3[var_3.size] = var_9;
      }
    }
  }

  return var_3;
}

_id_71FA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_0) && !common_scripts\utility::_id_562E(self.frozen)) {
    if(!isDefined(var_1))
      var_1 = 0;

    var_7 = self getanimentry(var_0, var_1);
    var_8 = _getanimlength(var_7);
    var_9 = var_8;

    if(isDefined(var_6)) {
      var_9 = var_8 - var_6;

      if(var_9 < 0)
        var_9 = 0;
    }

    var_9 = var_9 * (1.0 / var_2);
    childthread _id_678A(var_3, var_9, var_4);
  }

  _id_71F9(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  self notify("Notetrack_Timeout");
}

_id_71FD(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_71FA(var_0, var_1, 1.0, var_2, var_3, var_4, var_5);
}

_id_71F9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  isenemyaware(var_0, var_1, var_2, var_6);

  if(!isDefined(var_4))
    var_4 = "end";

  _id_A79E(var_3, var_4, var_0, var_1, var_5);
}

_id_A79F(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_2))
    childthread _id_678A(var_0, var_2, var_1);

  _id_A79E(var_0, var_1);
  self notify("Notetrack_Timeout");
}

_id_A79E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_2) && isDefined(var_3))
    var_7 = _getanimlength(self getanimentry(var_2, var_3));

  for(;;) {
    self waittill(var_0, var_8);

    if(isDefined(var_7))
      var_6 = (gettime() - var_5) * 0.001 / var_7;

    if(!isDefined(var_7) || var_6 > 0) {
      if(var_8 == var_1 || var_8 == "end" || var_8 == "anim_will_finish" || var_8 == "finish") {
        break;
      }
    }

    if(isDefined(var_4))
      [[var_4]](var_8, var_2, var_3, var_6);
  }
}

_id_678A(var_0, var_1, var_2) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var_1 = max(0.05, var_1);
  wait(var_1);

  if(isDefined(var_2))
    self notify(var_0, var_2);
  else
    self notify(var_0, "end");
}

_id_71F8(var_0, var_1, var_2, var_3) {
  isenemyaware(var_0, var_1, var_2);
  wait(var_3);
}

_id_5ED7(var_0, var_1, var_2) {
  for(;;) {
    var_3 = _id_7A35(var_0);
    isenemyaware(var_0, var_3, var_1);
    var_4 = _getanimlength(self getanimentry(var_0, var_3)) * (1.0 / var_1);
    _id_A79F(var_2, "end", var_4);
  }
}

_id_434D(var_0, var_1, var_2) {
  var_3 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();

  if(isDefined(var_1)) {
    foreach(var_6, var_5 in var_1)
    var_3[var_6] = var_5;
  }

  var_7 = 0;
  var_8 = _id_087C(var_0, var_3, var_7);
  return var_8;
}

_id_8410(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = _id_434D(var_0);
  isenemyaware(var_3, undefined, var_1, var_2);
}

_id_4156() {
  var_0 = self _meth_85A5();

  if(_isendstr(var_0, "_animclass"))
    var_0 = getsubstr(var_0, 0, var_0.size - 10);

  return var_0;
}

isenemyaware(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    self setanimstate(var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    self setanimstate(var_0, var_1, var_2);
  else if(isDefined(var_1))
    self setanimstate(var_0, var_1);
  else
    self setanimstate(var_0);

  var_4 = self getanimentryname();
  self._id_28ED = _id_43C9(var_4);
  _id_0378::_id_8D74("zombie_set_anim_state", var_0, var_4);

  if(isDefined(self._id_1142))
    self thread[[self._id_1142]](var_0, var_1, var_2, var_3);
}

_id_4416(var_0, var_1) {
  if(var_1 <= 1)
    return 0;

  var_3 = 360.0 / (var_1 - 1);
  var_4 = var_3 * 0.222222;

  if(var_0 < 0)
    return int(_ceil((180 + var_0 - var_4) / var_3));
  else
    return int(_floor((180 + var_0 + var_4) / var_3));
}

_id_441C(var_0, var_1, var_2) {
  var_3 = _length2d(var_0);
  var_4 = var_0[2];
  var_5 = _length2d(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;

  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectorNormalize(var_9);

    if(vectordot(var_10, var_0) < 0)
      var_7 = 0;
    else if(var_5 > 0)
      var_7 = var_3 / var_5;
  } else if(var_5 > 0)
    var_7 = var_3 / var_5;

  if(_abs(var_6) > 0.001 && var_4 != 0 && var_6 * var_4 > 0)
    var_8 = var_4 / var_6;

  var_11 = spawnStruct();
  var_11._id_AAE3 = var_7;
  var_11._id_01D9 = var_8;
  return var_11;
}

_id_6AFF(var_0, var_1) {
  self notify("killanimscript");

  if(isDefined(self._id_0EAD._id_6B2F[var_0]))
    self[[self._id_0EAD._id_6B2F[var_0]]]();

  _id_38ED(var_0);

  if(!isDefined(self._id_0EAD._id_6AFE[var_1])) {
    return;
  }
  if(var_0 == var_1 && var_1 != "traverse") {
    return;
  }
  self._id_0BA4 = var_1;
  _id_37B8(var_1);
  self[[self._id_0EAD._id_6AFE[var_1]]]();
}

_id_37B8(var_0) {
  self._id_0BA4 = var_0;

  switch (var_0) {
    case "idle":
      self._id_173C = 0;
      break;
    default:
      break;
  }
}

_id_38ED(var_0) {
  switch (var_0) {
    default:
      break;
  }
}

_id_57E2() {
  return self._id_018F;
}

_id_8732(var_0, var_1) {
  self._id_018F = var_0;
}

_id_43C9(var_0) {
  var_1 = strtok(var_0, "_");

  if(var_1.size > 1) {
    var_2 = var_1[var_1.size - 1];

    if(var_2.size > 0 && var_2[0] == "v") {
      var_3 = getsubstr(var_2, 1);
      var_4 = int(var_3);

      if(common_scripts\utility::_id_9AAD(var_4) == var_3)
        return var_4;
    }
  }

  return undefined;
}

_id_7A35(var_0) {
  var_1 = self getanimentrycount(var_0);

  if(isDefined(self._id_28ED)) {
    for(var_3 = 0; var_3 < var_1; var_3++) {
      var_4 = self getanimentryname(var_0, var_3);
      var_5 = _id_43C9(var_4);

      if(isDefined(var_5) && var_5 == self._id_28ED)
        return var_3;
    }
  }

  return randomint(var_1);
}

getnotetracktimeinsecs(var_0, var_1, var_2) {
  var_3 = _id_45B9(var_0, var_1, var_2);
  return var_3 * _getanimlength(var_0);
}

_id_45B9(var_0, var_1, var_2) {
  var_3 = _getnotetracktimes(var_0, var_1);

  if(isDefined(var_2) && var_3.size == 0)
    return var_2;

  return var_3[0];
}

_id_446A(var_0) {
  if(_animhasnotetrack(var_0, "code_move"))
    return _id_45B9(var_0, "code_move");

  return 1;
}