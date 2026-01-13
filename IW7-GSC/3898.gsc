/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3898.gsc
***********************************************/

func_FFE6() {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self.enemy) && scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  return 1;
}

func_C186(var_0, var_1, var_2, var_3) {
  return !func_1008A(var_0, var_1, var_3);
}

func_7F95(var_0) {
  return 256.0;
}

func_1008A(var_0, var_1, var_2, var_3) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(isDefined(self.node) && (self.node.type == "Cover Prone" || self.node.type == "Conceal Prone")) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_4 = var_3;
    } else if(var_3.size < 1) {
      var_4 = "Exposed";
    } else {
      var_4 = var_3[0];
    }
  } else
    var_4 = "Exposed";

  if(!func_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = 0;

  if(isDefined(var_3) && isarray(var_3) && var_3.size >= 2 && var_3[1]) {
    var_5 = 1;
  }

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(var_0, var_2, var_4, var_5);

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_FFD4(var_0, var_1, var_2, var_3) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(isDefined(self.node) && (self.node.type == "Cover Prone" || self.node.type == "Conceal Prone")) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  return 1;
}

func_10093(var_0, var_1, var_2, var_3) {
  return func_1008A(var_0, var_1, var_2, var_3);
}

func_10095(var_0, var_1, var_2, var_3) {
  return func_1008A(var_0, var_1, var_2, var_3);
}

func_10091(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  return func_1008A(var_0, var_1, var_2, var_3);
}

func_9D4C(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(isDefined(self.asm.var_4C86.var_22F1)) {
    return var_4 == "Custom";
  }

  if(!isDefined(self.node)) {
    return var_4 == "Exposed";
  }

  switch (var_4) {
    case "Exposed":
      return (self.node.type == "Path" || self.node.type == "Exposed") && self.node doesnodeallowstance("stand");
    case "Exposed Crouch":
      if(scripts\asm\asm_bb::func_292C() != "crouch") {
        return 0;
      }

      return (self.node.type == "Path" || self.node.type == "Exposed") && self.node doesnodeallowstance("crouch");
    case "Cover Crouch":
      return self.node.type == "Cover Crouch" || self.node.type == "Conceal Crouch";
    case "Cover Stand":
      return self.node.type == "Cover Stand" || self.node.type == "Conceal Stand";
    case "Cover Prone":
      return self.node.type == "Cover Prone" || self.node.type == "Conceal Prone";
    case "Cover Left":
      return self.node.type == "Cover Left" && self.node doesnodeallowstance("stand");
    case "Cover Left Crouch":
      return self.node.type == "Cover Left" && self.node doesnodeallowstance("crouch");
    case "Cover Right":
      return self.node.type == "Cover Right" && self.node doesnodeallowstance("stand");
    case "Cover Right Crouch":
      return self.node.type == "Cover Right" && self.node doesnodeallowstance("crouch");
  }

  return var_4 == self.node.type;
}

func_3E97(var_0, var_1, var_2) {
  return self.asm.var_11068;
}

func_3721(var_0, var_1, var_2, var_3) {
  var_4 = func_7DD6();

  if(isDefined(var_4)) {
    var_5 = var_4.origin;
  } else {
    var_5 = self.pathgoalpos;
  }

  var_6 = func_7E54();
  var_7 = self.var_20EE;
  var_8 = vectortoangles(var_7);

  if(isDefined(var_6)) {
    var_9 = angleclamp180(var_6[1] - var_8[1]);
  } else if(isDefined(var_4) && var_4.type != "Path") {
    var_9 = angleclamp180(var_4.angles[1] - var_8[1]);
  } else {
    var_10 = var_5 - self.origin;
    var_11 = vectortoangles(var_10);
    var_9 = angleclamp180(var_11[1] - var_8[1]);
  }

  var_12 = getangleindex(var_9, 22.5);
  var_13 = var_1;

  if(var_2 == "Custom") {
    var_14 = func_8174(self.asm.var_4C86.var_22F1, undefined, self.asm.var_4C86.var_22F6);
    var_13 = self.asm.var_4C86.var_22F1;
  } else
    var_14 = func_8174(var_1, undefined, var_3);

  var_15 = getweaponslistprimaries();
  var_16 = var_5 - self.origin;
  var_17 = lengthsquared(var_16);
  var_18 = var_14[var_12];

  if(!isDefined(var_18)) {
    return undefined;
  }

  var_19 = self getanimentry(var_13, var_18);
  var_20 = getmovedelta(var_19);
  var_21 = getangledelta(var_19);
  var_22 = length(self getvelocity());
  var_23 = var_22 * 0.053;
  var_24 = length(var_16);
  var_25 = length(var_20);

  if(abs(var_24 - var_25) > var_23) {
    return undefined;
  }

  if(var_17 < lengthsquared(var_20)) {
    return undefined;
  }

  var_26 = func_36D9(var_15.pos, var_15.var_0130[1], var_20, var_21);
  var_27 = getclosestpointonnavmesh(var_15.pos, self);
  var_28 = func_36D9(var_27, var_15.var_0130[1], var_20, var_21);
  var_29 = self func_84AC();
  var_30 = var_2 == "Cover Left" || var_2 == "Cover Right" || var_2 == "Cover Left Crouch" || var_2 == "Cover Right Crouch";

  if(var_30 && (var_12 == 0 || var_12 == 8 || var_12 == 7 || var_12 == 1)) {
    var_31 = undefined;
    var_32 = undefined;
    var_33 = getnotetracktimes(var_19, "corner");

    if(var_33.size > 0) {
      var_31 = getmovedelta(var_19, 0, var_33[0]);
      var_32 = var_33[0];
    } else {
      var_34 = undefined;
      var_35 = undefined;

      if(var_2 == "Cover Left" || var_2 == "Cover Left Crouch") {
        var_34 = "left";

        if(var_12 == 7) {
          var_35 = "7";
        } else if(var_12 == 0 || var_12 == 8) {
          var_35 = "8";
        }
      } else if(var_2 == "Cover Right" || var_2 == "Cover Right Crouch") {
        var_34 = "right";

        if(var_12 == 0 || var_12 == 8) {
          var_35 = "8";
        } else if(var_12 == 1) {
          var_35 = "9";
        }
      }

      if(isDefined(var_34) && isDefined(var_35)) {
        var_31 = lerpviewangleclamp(var_0, var_1, var_35, var_3);
        var_32 = getnormalizedmovement(var_0, var_1, var_35, var_3);
      }
    }

    if(isDefined(var_31)) {
      var_31 = rotatevector(var_31, (0, var_15.var_0130[1] - var_21, 0));
      var_31 = var_28 + var_31;
      var_36 = navtrace(var_29, var_31, self, 1);

      if(var_36["fraction"] >= 0.9 || _func_2AC(var_29, var_31, self)) {
        var_37 = spawnStruct();
        var_37.var_11060 = var_18;
        var_37.angleindex = var_12;
        var_37.startpos = var_26;
        var_37.angledelta = var_21;
        var_37.angles = var_15.angles;
        var_37.var_0130 = var_15.var_0130;
        var_37.var_01F3 = var_20;
        var_37.var_0357 = var_31;
        var_37.var_02BD = var_32;
        return var_37;
      }
    }
  } else {
    var_36 = navtrace(var_29, var_27, self, 1);
    var_38 = var_36["fraction"] >= 0.9 || _func_2AC(var_29, var_27, self);

    if(!var_38) {
      var_39 = self pathdisttogoal();
      var_38 = var_39 < distance(var_29, var_27) + 8.0;
    }

    if(var_38) {
      var_37 = spawnStruct();
      var_37.var_11060 = var_18;
      var_37.angleindex = var_12;
      var_37.startpos = var_26;
      var_37.angledelta = var_21;
      var_37.angles = var_15.angles;
      var_37.var_0130 = var_15.var_0130;
      var_37.var_11069 = var_20;
      var_37.var_22ED = var_5;
      return var_37;
    }
  }

  return undefined;
}

func_CECA(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  var_2 = self.goalpos;

  for(;;) {
    self waittill("path_set");
    var_3 = self.goalpos;

    if(!self.goingtoruntopos) {
      break;
    }

    if(distancesquared(var_2, var_3) > 1) {
      break;
    }

    var_2 = var_3;
  }

  scripts\asm\asm::asm_fireevent(var_1, "abort");
}

func_CEC9(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");

  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  scripts\asm\asm::asm_fireevent(var_1, "abort");
}

func_136F5(var_0) {
  self endon(var_0 + "_finished");
  self endon("waypoint_reached");
  self endon("waypoint_aborted");
  wait 2;
}

func_CEAA(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = func_7DD6();
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);

  if(!isDefined(var_5)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort", undefined);
    return;
  }

  var_6 = scripts\asm\asm::asm_getmoveplaybackrate();

  if(!isDefined(var_6)) {
    var_6 = 1.0;
  }

  var_7 = var_5.var_0130;
  var_8 = var_5.angleindex;
  var_9 = (0, var_7[1] - var_5.angledelta, 0);
  var_10 = self getanimentry(var_1, var_5.var_11060);
  var_11 = getanimlength(var_10);
  var_11 = var_11 * (1 / var_6);
  self func_8396(var_5.startpos, var_9[1], var_11);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5.var_11060, var_6);
}

func_22EA() {
  self endon("killanimscript");
  self waittill(self.var_22E5 + "_finished");
}

func_7DD6() {
  if(isDefined(self.scriptedarrivalent)) {
    return self.scriptedarrivalent;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36) {
    return self.prevnode;
  }

  return undefined;
}

func_7E54() {
  if(isDefined(self.asm.var_4C86.var_22E3)) {
    return self.asm.var_4C86.var_22E3;
  }

  return undefined;
}

getweaponslistprimaries() {
  var_0 = spawnStruct();
  var_1 = func_7DD6();

  if(isDefined(var_1) && var_1.type != "Path") {
    var_0.pos = var_1.origin;
    var_0.angles = var_1.angles;
    var_0.var_0130 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var_1), 0);
  } else {
    var_0.pos = self.pathgoalpos;
    var_2 = self getvelocity();
    var_3 = self getlookaheaddir();

    if(lengthsquared(var_2) > 1) {
      var_0.angles = vectortoangles(var_0.pos - self.origin);
    } else {
      var_0.angles = vectortoangles(var_3);
    }

    var_0.var_0130 = var_0.angles;
  }

  var_4 = func_7E54();

  if(isDefined(var_4)) {
    var_0.angles = var_4;
    var_0.var_0130 = var_0.angles;
  }

  return var_0;
}

func_36D9(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

func_8174(var_0, var_1, var_2) {
  var_3 = [];
  var_3[5] = scripts\asm\asm::func_235C(1, var_0, var_2);
  var_3[4] = scripts\asm\asm::func_235C(2, var_0, var_2);
  var_3[3] = scripts\asm\asm::func_235C(3, var_0, var_2);
  var_3[6] = scripts\asm\asm::func_235C(4, var_0, var_2);
  var_3[2] = scripts\asm\asm::func_235C(6, var_0, var_2);
  var_3[7] = scripts\asm\asm::func_235C(7, var_0, var_2);
  var_3[0] = scripts\asm\asm::func_235C(8, var_0, var_2);
  var_3[1] = scripts\asm\asm::func_235C(9, var_0, var_2);
  var_3[8] = var_3[0];
  return var_3;
}

getnormalizedmovement(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["cover_left_arrival"]["7"] = 0.369369;
  var_4["cover_left_crouch_arrival"]["7"] = 0.321321;
  var_4["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
  var_4["cqb_cover_left_arrival"]["7"] = 0.275275;
  var_4["cover_left_arrival"]["8"] = 0.525526;
  var_4["cover_left_crouch_arrival"]["8"] = 0.448448;
  var_4["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
  var_4["cqb_cover_left_arrival"]["8"] = 0.335335;
  var_4["cover_right_arrival"]["8"] = 0.472472;
  var_4["cover_right_crouch_arrival"]["8"] = 0.248248;
  var_4["cqb_cover_right_arrival"]["8"] = 0.345345;
  var_4["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
  var_4["cover_right_arrival"]["9"] = 0.551552;
  var_4["cover_right_crouch_arrival"]["9"] = 0.2002;
  var_4["cqb_cover_right_arrival"]["9"] = 0.3003;
  var_4["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
  return var_4[var_1][var_2];
}

lerpviewangleclamp(var_0, var_1, var_2, var_3) {
  return undefined;
}

func_1008F(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  var_4 = undefined;

  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_4 = var_3;
    } else if(var_3.size < 1) {
      var_4 = "Exposed";
    } else {
      var_4 = var_3[0];
    }
  } else
    var_4 = "Exposed";

  if(!func_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = distance(self.origin, self.pathgoalpos);
  var_6 = func_7F95(var_4);

  if(var_5 > var_6) {
    return 0;
  }

  var_7 = 0;

  if(isDefined(var_3) && var_3.size >= 2) {
    var_7 = 1;
  }

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(var_0, var_2, var_4, var_7);

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}