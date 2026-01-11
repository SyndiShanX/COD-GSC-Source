/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3157.gsc
***************************************/

chooseanimshoot(var_00, var_01, var_02) {
  var_03 = var_02;
  var_04 = self.var_1198.shootstate + "_" + var_03;

  if(isDefined(self.var_1198.shootstate) && scripts\asm\asm::asm_hasalias(var_01, var_04)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_04);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_02);
}

choosedemeanoranimwithoverride(var_00, var_01, var_02) {
  var_03 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_03, var_02)) {
    var_04 = scripts\asm\asm::asm_getdemeanoranimoverride(var_03, var_02);

    if(isarray(var_04)) {
      return var_4[randomint(var_4.size)];
    }

    return var_04;
  }

  if(!scripts\asm\asm::asm_hasalias(var_01, var_03)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_01, "default");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_03);
}

choosedemeanoranimwithoverridevariants(var_00, var_01, var_02) {
  var_03 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_03, var_02)) {
    var_04 = scripts\asm\asm::asm_getdemeanoranimoverride(var_03, var_02);

    if(isarray(var_04)) {
      return var_4[randomint(var_4.size)];
    }

    return var_04;
  }

  if(!scripts\asm\asm::asm_hasalias(var_01, var_03)) {
    var_05 = [];
    var_5[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_01, "trans_to_one_hand_run");
    var_5[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_01, "one_hand_run");
    var_5[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_01, "trans_to_two_hand_run");
    var_5[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_01, "two_hand_run");
    return var_05;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_03);
}

func_3EAA(var_00, var_01, var_02) {
  var_03 = weaponclass(self.weapon);

  if(!scripts\asm\asm::asm_hasalias(var_01, var_03)) {
    var_03 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_03);
}

func_3E9A(var_00, var_01, var_02) {
  var_03 = var_02;

  if(self.asm.shootparams.func_FF0B == 1) {
    var_04 = "single";
  } else {
    var_04 = var_03 + self.asm.shootparams.func_FF0B;
  }

  if(scripts\asm\asm::asm_hasalias(var_01, var_04)) {
    var_05 = scripts\asm\asm::asm_lookupanimfromalias(var_01, var_04);
  } else {
    var_05 = scripts\asm\asm::asm_lookupanimfromalias(var_01, "fire");
  }

  return var_05;
}

chooseanim_weaponswitch(var_00, var_01, var_02) {
  if(weaponclass(self.weapon) == "rocketlauncher" && scripts\asm\asm::asm_hasalias(var_01, "drop_rpg")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_01, "drop_rpg");
  }

  var_03 = scripts\asm\asm_bb::bb_getrequestedweapon();

  if(!scripts\asm\asm::asm_hasalias(var_01, var_03)) {
    var_03 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_03);
}

func_12668(var_00, var_01, var_02, var_03) {
  return 1;
}

func_2B58(var_00, var_01, var_02, var_03) {}

func_BD25(var_00, var_01, var_02, var_03) {
  return scripts\asm\asm::asm_getdemeanor() == var_03;
}

func_BD26(var_00, var_01, var_02, var_03) {
  return scripts\asm\asm::asm_getdemeanor() != var_03;
}

func_BD28(var_00, var_01, var_02, var_03) {
  var_04 = scripts\asm\asm::asm_getdemeanor();
  return var_04 != "frantic" && var_04 != "combat" && var_04 != "sprint";
}

movetypeisnotcasual(var_00, var_01, var_02, var_03) {
  var_04 = scripts\asm\asm::asm_getdemeanor();
  return var_04 != "casual" && var_04 != "casual_gun";
}

getnodeforwardyawnodetypelookupoverride(var_00, var_01) {
  switch (var_01) {
    case "stand":
    case "crouch":
    case "prone":
      break;
    default:
      return var_01;
  }

  switch (var_00) {
    case "Cover Left":
      if(var_01 == "crouch") {
        return "Cover Left Crouch";
      }

      break;
    case "Cover Right":
      if(var_01 == "crouch") {
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

getnodeyawfromoffsettable(var_00, var_01, var_02) {
  var_03 = self.a.pose;

  if(isDefined(var_02)) {
    var_03 = var_02;
  } else if(isnode(var_01) && !var_01 doesnodeallowstance(var_03)) {
    var_03 = var_01 gethighestnodestance();
  }

  var_04 = getnodeforwardyawnodetypelookupoverride(var_1.type, var_03);

  if(isDefined(var_04) && isDefined(var_0[var_04])) {
    return var_0[var_04];
  }

  if(isDefined(var_0[var_1.type])) {
    return var_0[var_1.type];
  }

  return undefined;
}

func_1C9C() {
  var_00 = scripts\engine\utility::weaponclass(self.weapon) == "mg";
  return var_00 || isDefined(self.var_1198.func_522F) && isDefined(self.node) && self.node == self.var_1198.func_522F;
}

getnodeyawoffset(var_00, var_01) {
  if(_isstruct(var_00) || !isDefined(var_0.type)) {
    return 0;
  }

  if(getdvarint("ai_iw7", 0) == 1) {
    if(isDefined(self.var_1198.func_98F4) && self.var_1198.func_98F4 || isDefined(self.asm.func_1310E) && self.asm.func_1310E) {
      return 0;
    }

    if(self.asm.func_7360 && isDefined(anim.func_7365) && isDefined(anim.func_7365[self.asmname])) {
      var_02 = getnodeyawfromoffsettable(anim.func_7365[self.asmname], var_00, var_01);

      if(isDefined(var_02)) {
        return var_02;
      }

      return 0;
    } else if(isDefined(anim.func_C05A) && isDefined(anim.func_C05A[self.asmname])) {
      var_02 = getnodeyawfromoffsettable(anim.func_C05A[self.asmname], var_00, var_01);

      if(isDefined(var_02)) {
        return var_02;
      }

      return 0;
    }
  }

  if(!isDefined(self.heat)) {
    if(scripts\engine\utility::isnodecoverleft(var_00)) {
      return 90;
    } else if(scripts\engine\utility::isnodecoverright(var_00)) {
      return -90;
    }
  }

  return 0;
}

_meth_812E(var_00, var_01) {
  if(!isDefined(var_0.angles)) {
    return 0;
  }

  var_02 = var_0.type;

  if(isnode(var_00) && !var_00 doesnodeallowstance("stand") && !isDefined(var_01)) {
    switch (var_02) {
      case "Cover Left":
        var_01 = "crouch";
        break;
      case "Cover Right":
        var_01 = "crouch";
        break;
    }
  }

  var_03 = getnodeyawoffset(var_00, var_01);

  if(var_0.type == "Cover Left") {
    if(self.asmname == "soldier") {
      var_03 = var_03 + 45;
    }
  }

  return var_03;
}

getnodeforwardyaw(var_00, var_01) {
  var_02 = getnodeyawoffset(var_00, var_01);
  return var_0.angles[1] + var_02;
}

gethighestnodestance(var_00, var_01) {
  var_02 = _meth_812E(var_00, var_01);
  return var_0.angles[1] + var_02;
}

getnodeforwardangles(var_00, var_01) {
  var_02 = getnodeyawoffset(var_00, var_01);
  return _combineangles(var_0.angles, (0, var_02, 0));
}

func_7FF1(var_00, var_01, var_02) {
  var_03 = undefined;

  if(var_02 == "exposed") {
    var_03 = anim.func_C046[var_00];
  } else if(var_02 == "lean" || var_02 == "leanover") {
    var_03 = anim.func_C04D[var_00];
  }

  if(isDefined(var_03)) {
    var_04 = getnodeyawfromoffsettable(var_03, var_01, undefined);

    if(isDefined(var_04)) {
      return var_04;
    }
  }

  return 0;
}

func_7FF2(var_00, var_01, var_02) {
  var_03 = undefined;

  if(self.asm.func_7360) {
    if(var_02 == "lean") {
      var_03 = anim.func_7364[var_00];
    } else if(var_02 == "A" || var_02 == "full" || var_02 == "right" || var_02 == "left") {
      var_03 = anim.func_7363[var_00];
    }
  } else if(var_02 == "lean")
    var_03 = anim.func_C04E[var_00];

  if(isDefined(var_03)) {
    var_04 = getnodeyawfromoffsettable(var_03, var_01, undefined);

    if(isDefined(var_04)) {
      return var_04;
    }
  }

  return 0;
}

func_C04B(var_00) {
  if(var_0.type == "Cover Stand 3D") {
    return !func_C04A(var_00);
  }

  return 0;
}

func_C04A(var_00) {
  if(var_0.type == "Cover Stand 3D") {
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "exposed") {
      return 1;
    }
  }

  return 0;
}

getnodetypename(var_00) {
  if(isDefined(var_00)) {
    if(func_C04A(var_00)) {
      return "Cover Exposed 3D";
    } else {
      return var_0.type;
    }
  }

  return "undefined";
}

choosestrongdamagedeath(var_00, var_01, var_02) {
  var_03 = undefined;

  if(abs(self.damageyaw) > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_03 = "legs";
    } else if(self.damagelocation == "torso_lower") {
      var_03 = "torso_lower";
    } else {
      var_03 = "default";
    }
  } else if(self.damageyaw < 0)
    var_03 = "right";
  else {
    var_03 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_01, var_03);
}

isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

func_93DE(var_00, var_01, var_02, var_03) {
  return !isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

func_C17A(var_00, var_01, var_02, var_03) {
  return !isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

setuseanimgoalweight(var_00, var_01) {
  self endon(var_00 + "_finished");
  self.useanimgoalweight = 1;
  thread setuseanimgoalweight_wait(var_00);

  if(var_01 > 0) {
    wait(var_01);
  }

  self.useanimgoalweight = 0;
  self notify("StopUseAnimGoalWeight");
}

setuseanimgoalweight_wait(var_00) {
  self notify("StopUseAnimGoalWeight");
  self endon("StopUseAnimGoalWeight");
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_00 + "_finished");
  self.useanimgoalweight = 0;
}

randomizepassthroughchildren(var_00, var_01, var_02, var_03) {
  var_04 = anim.asm[var_00].states[var_02];

  if(isDefined(var_4.transitions)) {
    if(var_4.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var_05 = var_4.transitions[0];
        var_4.transitions[0] = var_4.transitions[1];
        var_4.transitions[1] = var_05;
      }
    } else
      var_4.transitions = scripts\engine\utility::array_randomize(var_4.transitions);
  }

  return 1;
}