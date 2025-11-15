/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3108.gsc
***************************************/

func_965D() {
  if(isDefined(level.func_4AEC)) {
    return;
  }
  level.func_4AEC = 1;
  level.func_4AEE = [];
  var_00 = getcsplinecount();

  if(var_00 == 0) {
    return;
  }
  var_00 = var_00 + 1;

  for(var_01 = 1; var_01 < var_00; var_1++) {
    var_02 = _getcsplinepointcount(var_01);

    for(var_03 = 0; var_03 < var_02; var_3++) {
      var_04 = _getcsplinepointlabel(var_01, var_03);

      if(isDefined(var_04)) {
        if(!isDefined(level.func_4AEE[var_04]))
          level.func_4AEE[var_04] = 1;
      }
    }
  }

  if(level.func_4AEE.size == 0)
    return;
}

func_10A49() {
  self.func_10A47 = func_0BDC::func_A1EF;
  self endon("death");
  self endon("entitydeleted");
  self endon("terminate_ai_threads");
  self endon("enter_jackal");

  if(!isDefined(level.func_4AEE))
    level func_965D();

  childthread func_10A48();
}

func_9EC8() {
  return 1;
}

func_10A48() {
  self notify("notify_splinelablefunc");
  self endon("notify_splinelablefunc");

  for(;;) {
    self waittill("splinenode_label", var_00, var_01, var_02, var_03);
    var_04 = strtok(var_00, " ");

    foreach(var_06 in var_04) {
      switch (var_06) {
        case "deleteme":
          self delete();
          break;
        case "loop_path":
          self.func_10A43 = var_01;
          loop_or_delete();
          break;
        case "explode":
          func_0118();
          break;
        case "junction":
          thread func_A50D(var_03);
          break;
        case "continue":
          thread func_45A8(var_03);
          break;
        case "flag":
          thread func_6E48(var_03);
          break;
        case "playerjackal_state":
          thread func_D3B8(var_03);
          break;
        case "notify":
          func_C133(var_03, var_01, var_02);
          break;
        default:
          break;
      }
    }
  }
}

func_C133(var_00, var_01, var_02) {
  self notify(var_00, var_01, var_02);
}

loop_or_delete() {
  self _meth_847A();
  self _meth_8479(self.func_10A43);
  self _meth_847B(1.0);
  thread loop_path(self.func_10A43);
}

loop_path(var_00) {
  self waittill("near_goal");
  func_10A44(var_00);
}

func_10A44(var_00) {
  var_01 = _getcsplinepointcount(var_00) - 1;
  var_02 = _getcsplinepointlabel(var_00, var_01);

  if(isDefined(var_02) && var_02 != "") {
    var_03 = _getcsplinepointstring(var_00, var_01);

    if(isDefined(var_03) && var_02 != "")
      self notify("splinenode_label", var_02, var_00, var_01, var_03);
    else
      self notify("splinenode_label", var_02, var_00, var_01);
  }
}

func_0118() {
  self getrandomarmkillstreak(20000, self.origin);
  self notify("death");
}

func_A50D(var_00) {
  if(isDefined(self.var_1198) && !self.var_1198.animscriptedactive) {
    self notify("spline_junction");
    return;
  }

  if(scripts\engine\utility::cointoss())
    func_A4F9(0);
}

func_A4F9(var_00) {
  var_01 = func_0A0D::func_7E02(undefined, 1000);
  func_0BDC::func_A1EF(var_1["spline"], undefined, undefined, 1, 1.0);
  return;
}

func_45A8(var_00) {
  if(isDefined(self.var_1198) && !self.var_1198.animscriptedactive) {
    self notify("spline_junction", "continue");
    return;
  }

  func_A4F9(1);
}

func_6E48(var_00) {
  var_01 = strtok(var_00, " ");

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

func_D3B8(var_00) {
  func_0BDC::func_6B4C(var_00);
}

func_517E() {
  self endon("death");
  self endon("terminate_ai_threads");
  self waittill("end_spline");
  self delete();
}

func_10A46(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = 0.2;

  self _meth_8479(var_00);

  if(isDefined(var_02))
    self _meth_847B(var_01, var_02);
  else
    self _meth_847B(var_01);

  self.func_10A43 = var_00;
  self waittill("near_goal");
  self notify("end_spline");
  func_10A44(var_00);
}