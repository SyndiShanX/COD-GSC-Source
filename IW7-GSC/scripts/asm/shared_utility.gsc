/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\shared_utility.gsc
*********************************************/

chooseanimshoot(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = self._blackboard.shootstate + "_" + var_3;
  if(isDefined(self._blackboard.shootstate) && scripts\asm\asm::asm_hasalias(var_1, var_4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

choosedemeanoranimwithoverride(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);
    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_2, "default");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
}

choosedemeanoranimwithoverridevariants(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);
    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    var_5 = [];
    var_5[0] = scripts\asm\asm::asm_lookupanimfromalias(var_2, "trans_to_one_hand_run");
    var_5[1] = scripts\asm\asm::asm_lookupanimfromalias(var_2, "one_hand_run");
    var_5[2] = scripts\asm\asm::asm_lookupanimfromalias(var_2, "trans_to_two_hand_run");
    var_5[3] = scripts\asm\asm::asm_lookupanimfromalias(var_2, "two_hand_run");
    return var_5;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_3, var_5);
}

func_3EAA(var_0, var_1, var_2) {
  var_3 = weaponclass(self.var_394);
  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3E9A(var_0, var_1, var_2) {
  var_3 = var_2;
  if(self.asm.shootparams.var_FF0B == 1) {
    var_4 = "single";
  } else {
    var_4 = var_4 + self.asm.shootparams.var_FF0B;
  }

  if(scripts\asm\asm::asm_hasalias(var_1, var_4)) {
    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  } else {
    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "fire");
  }

  return var_5;
}

chooseanim_weaponswitch(var_0, var_1, var_2) {
  if(weaponclass(self.var_394) == "rocketlauncher" && scripts\asm\asm::asm_hasalias(var_1, "drop_rpg")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "drop_rpg");
  }

  var_3 = scripts\asm\asm_bb::bb_getrequestedweapon();
  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_12668(var_0, var_1, var_2, var_3) {
  return 1;
}

func_2B58(var_0, var_1, var_2, var_3) {}

func_BD25(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_getdemeanor() == var_3;
}

func_BD26(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_getdemeanor() != var_3;
}

func_BD28(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  return var_4 != "frantic" && var_4 != "combat" && var_4 != "sprint";
}

movetypeisnotcasual(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  return var_4 != "casual" && var_4 != "casual_gun";
}

getnodeforwardyawnodetypelookupoverride(var_0, var_1) {
  switch (var_1) {
    case "stand":
    case "crouch":
    case "prone":
      break;

    default:
      return var_1;
  }

  switch (var_0) {
    case "Cover Left":
      if(var_1 == "crouch") {
        return "Cover Left Crouch";
      }
      break;

    case "Cover Right":
      if(var_1 == "crouch") {
        return "Cover Right Crouch";
      }
      break;

    case "Conceal Crouch":
    case "Cover Crouch Window":
      return "Cover Crouch";

    case "Conceal Stand":
      return "Cover Stand";
  }

  return undefined;
}

getnodeyawfromoffsettable(var_0, var_1, var_2) {
  var_3 = self.a.pose;
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isnode(var_1) && !var_1 getrandomattachments(var_3)) {
    var_3 = var_1 gethighestnodestance();
  }

  var_4 = getnodeforwardyawnodetypelookupoverride(var_1.type, var_3);
  if(isDefined(var_4) && isDefined(var_0[var_4])) {
    return var_0[var_4];
  }

  if(isDefined(var_0[var_1.type])) {
    return var_0[var_1.type];
  }

  return undefined;
}

func_1C9C() {
  var_0 = scripts\engine\utility::weaponclass(self.var_394) == "mg";
  return var_0 || isDefined(self._blackboard.var_522F) && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget == self._blackboard.var_522F;
}

getnodeyawoffset(var_0, var_1) {
  if(isstruct(var_0) || !isDefined(var_0.type)) {
    return 0;
  }

  if(getdvarint("ai_iw7", 0) == 1) {
    if((isDefined(self._blackboard.var_98F4) && self._blackboard.var_98F4) || isDefined(self.asm.var_1310E) && self.asm.var_1310E) {
      return 0;
    }

    if(self.asm.var_7360 && isDefined(level.var_7365) && isDefined(level.var_7365[self.asmname])) {
      var_2 = getnodeyawfromoffsettable(level.var_7365[self.asmname], var_0, var_1);
      if(isDefined(var_2)) {
        return var_2;
      }

      return 0;
    } else if(isDefined(level.var_C05A) && isDefined(level.var_C05A[self.asmname])) {
      var_2 = getnodeyawfromoffsettable(level.var_C05A[self.asmname], var_1, var_2);
      if(isDefined(var_2)) {
        return var_2;
      }

      return 0;
    }
  }

  if(!isDefined(self.heat)) {
    if(scripts\engine\utility::isnodecoverleft(var_1)) {
      return 90;
    } else if(scripts\engine\utility::isnodecoverright(var_1)) {
      return -90;
    }
  }

  return 0;
}

func_812E(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    return 0;
  }

  var_2 = var_0.type;
  if(isnode(var_0) && !var_0 getrandomattachments("stand") && !isDefined(var_1)) {
    switch (var_2) {
      case "Cover Left":
        var_1 = "crouch";
        break;

      case "Cover Right":
        var_1 = "crouch";
        break;
    }
  }

  var_3 = getnodeyawoffset(var_0, var_1);
  if(var_0.type == "Cover Left") {
    if(self.asmname == "soldier") {
      var_3 = var_3 + 45;
    }
  }

  return var_3;
}

getnodeforwardyaw(var_0, var_1) {
  var_2 = getnodeyawoffset(var_0, var_1);
  return var_0.angles[1] + var_2;
}

gethighestnodestance(var_0, var_1) {
  var_2 = func_812E(var_0, var_1);
  return var_0.angles[1] + var_2;
}

getnodeforwardangles(var_0, var_1) {
  var_2 = getnodeyawoffset(var_0, var_1);
  return combineangles(var_0.angles, (0, var_2, 0));
}

func_7FF1(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_2 == "exposed") {
    var_3 = level.var_C046[var_0];
  } else if(var_2 == "lean" || var_2 == "leanover") {
    var_3 = level.var_C04D[var_0];
  }

  if(isDefined(var_3)) {
    var_4 = getnodeyawfromoffsettable(var_3, var_1, undefined);
    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return 0;
}

func_7FF2(var_0, var_1, var_2) {
  var_3 = undefined;
  if(self.asm.var_7360) {
    if(var_2 == "lean") {
      var_3 = level.var_7364[var_0];
    } else if(var_2 == "A" || var_2 == "full" || var_2 == "right" || var_2 == "left") {
      var_3 = level.var_7363[var_0];
    }
  } else if(var_2 == "lean") {
    var_3 = level.var_C04E[var_0];
  }

  if(isDefined(var_3)) {
    var_4 = getnodeyawfromoffsettable(var_3, var_1, undefined);
    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return 0;
}

func_C04B(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    return !func_C04A(var_0);
  }

  return 0;
}

func_C04A(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "exposed") {
      return 1;
    }
  }

  return 0;
}

getnodetypename(var_0) {
  if(isDefined(var_0)) {
    if(func_C04A(var_0)) {
      return "Cover Exposed 3D";
    } else {
      return var_0.type;
    }
  }

  return "undefined";
}

choosestrongdamagedeath(var_0, var_1, var_2) {
  var_3 = undefined;
  if(abs(self.var_E3) > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_3 = "legs";
    } else if(self.var_DD == "torso_lower") {
      var_3 = "torso_lower";
    } else {
      var_3 = "default";
    }
  } else if(self.var_E3 < 0) {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

func_93DE(var_0, var_1, var_2, var_3) {
  return !isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

func_C17A(var_0, var_1, var_2, var_3) {
  return !isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

setuseanimgoalweight(var_0, var_1) {
  self endon(var_0 + "_finished");
  self.var_36A = 1;
  thread setuseanimgoalweight_wait(var_0);
  if(var_1 > 0) {
    wait(var_1);
  }

  self.var_36A = 0;
  self notify("StopUseAnimGoalWeight");
}

setuseanimgoalweight_wait(var_0) {
  self notify("StopUseAnimGoalWeight");
  self endon("StopUseAnimGoalWeight");
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0 + "_finished");
  self.var_36A = 0;
}

randomizepassthroughchildren(var_0, var_1, var_2, var_3) {
  var_4 = level.asm[var_0].states[var_2];
  if(isDefined(var_4.transitions)) {
    if(var_4.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var_5 = var_4.transitions[0];
        var_4.transitions[0] = var_4.transitions[1];
        var_4.transitions[1] = var_5;
      }
    } else {
      var_4.transitions = scripts\engine\utility::array_randomize(var_4.transitions);
    }
  }

  return 1;
}