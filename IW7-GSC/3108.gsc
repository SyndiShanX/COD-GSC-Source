/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3108.gsc
**************************************/

func_965D() {
  if(isDefined(level.var_4AEC)) {
    return;
  }
  level.var_4AEC = 1;
  level.var_4AEE = [];
  var_0 = getcsplinecount();

  if(var_0 == 0) {
    return;
  }
  var_0 = var_0 + 1;

  for(var_1 = 1; var_1 < var_0; var_1++) {
    var_2 = _getcsplinepointcount(var_1);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = _getcsplinepointlabel(var_1, var_3);

      if(isDefined(var_4)) {
        if(!isDefined(level.var_4AEE[var_4])) {
          level.var_4AEE[var_4] = 1;
        }
      }
    }
  }

  if(level.var_4AEE.size == 0) {
    return;
  }
}

func_10A49() {
  self.var_10A47 = func_0BDC::func_A1EF;
  self endon("death");
  self endon("entitydeleted");
  self endon("terminate_ai_threads");
  self endon("enter_jackal");

  if(!isDefined(level.var_4AEE)) {
    level func_965D();
  }

  childthread func_10A48();
}

func_9EC8() {
  return 1;
}

func_10A48() {
  self notify("notify_splinelablefunc");
  self endon("notify_splinelablefunc");

  for(;;) {
    self waittill("splinenode_label", var_0, var_1, var_2, var_3);
    var_4 = strtok(var_0, " ");

    foreach(var_6 in var_4) {
      switch (var_6) {
        case "deleteme":
          self delete();
          break;
        case "loop_path":
          self.var_10A43 = var_1;
          loop_or_delete();
          break;
        case "explode":
          func_0118();
          break;
        case "junction":
          thread func_A50D(var_3);
          break;
        case "continue":
          thread func_45A8(var_3);
          break;
        case "flag":
          thread func_6E48(var_3);
          break;
        case "playerjackal_state":
          thread func_D3B8(var_3);
          break;
        case "notify":
          func_C133(var_3, var_1, var_2);
          break;
        default:
          break;
      }
    }
  }
}

func_C133(var_0, var_1, var_2) {
  self notify(var_0, var_1, var_2);
}

loop_or_delete() {
  self _meth_847A();
  self _meth_8479(self.var_10A43);
  self _meth_847B(1.0);
  thread loop_path(self.var_10A43);
}

loop_path(var_0) {
  self waittill("near_goal");
  func_10A44(var_0);
}

func_10A44(var_0) {
  var_1 = _getcsplinepointcount(var_0) - 1;
  var_2 = _getcsplinepointlabel(var_0, var_1);

  if(isDefined(var_2) && var_2 != "") {
    var_3 = _getcsplinepointstring(var_0, var_1);

    if(isDefined(var_3) && var_2 != "") {
      self notify("splinenode_label", var_2, var_0, var_1, var_3);
    } else {
      self notify("splinenode_label", var_2, var_0, var_1);
    }
  }
}

func_0118() {
  self getrandomarmkillstreak(20000, self.origin);
  self notify("death");
}

func_A50D(var_0) {
  if(isDefined(self._blackboard) && !self._blackboard.animscriptedactive) {
    self notify("spline_junction");
    return;
  }

  if(scripts\engine\utility::cointoss()) {
    func_A4F9(0);
  }
}

func_A4F9(var_0) {
  var_1 = func_0A0D::func_7E02(undefined, 1000);
  func_0BDC::func_A1EF(var_1["spline"], undefined, undefined, 1, 1.0);
  return;
}

func_45A8(var_0) {
  if(isDefined(self._blackboard) && !self._blackboard.animscriptedactive) {
    self notify("spline_junction", "continue");
    return;
  }

  func_A4F9(1);
}

func_6E48(var_0) {
  var_1 = strtok(var_0, " ");

  switch (tolower(var_1[0])) {
    case "flag_set":
      level scripts\engine\utility::flag_set(var_1[1]);
      return;
    case "ent_flag_set":
      scripts\sp\utility::func_65E1(var_1[1]);
      return;
    default:
      scripts\engine\utility::error("Spline with label FLAG is not setup correctly.");
      scripts\engine\utility::error("Set the splinenode_string as 'flag_set' or 'ent_flag_set' followed by the flag to set.");
      return;
  }
}

func_D3B8(var_0) {
  func_0BDC::func_6B4C(var_0);
}

func_517E() {
  self endon("death");
  self endon("terminate_ai_threads");
  self waittill("end_spline");
  self delete();
}

func_10A46(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  self _meth_8479(var_0);

  if(isDefined(var_2)) {
    self _meth_847B(var_1, var_2);
  } else {
    self _meth_847B(var_1);
  }

  self.var_10A43 = var_0;
  self waittill("near_goal");
  self notify("end_spline");
  func_10A44(var_0);
}