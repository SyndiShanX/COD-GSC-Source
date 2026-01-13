/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3119.gsc
*********************************************/

func_3359(var_0, var_1, var_2, var_3) {
  self.asm.var_51E8 = 1;
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.var_7360 = 0;
  scripts\asm\asm::func_237B(1);
  func_3377(var_0);
  func_3375();
  func_3374();
  scripts\anim\combat::func_F296();
  thread lib_0A1E::func_234F();
  self.var_71C8 = ::lib_0C60::func_33AA;
  self.meleechargedistreloadmultiplier = 1;
  self.var_C009 = 1;
  self.var_596E = 1;
  self.nodetoentitysighttest = 48;
}

func_3377(var_0) {
  if(!isDefined(level.var_C05A)) {
    anim.var_C05A = [];
  }

  if(isDefined(level.var_C05A[var_0])) {
    return;
  }

  var_1 = [];
  var_1["Cover Left"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Stand"] = 0;
  level.var_C05A[var_0] = var_1;
  var_1 = [];
  level.var_7365[var_0] = var_1;
  var_2 = [];
  level.var_C046[var_0] = var_2;
  var_1 = [];
  level.var_C04E[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  level.var_C04D[var_0] = var_2;
  var_1 = [];
  level.var_7364[var_0] = var_1;
  var_1 = [];
  level.var_7363[var_0] = var_1;
}

func_3375() {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
  }

  if(isDefined(level.var_85DF["c6"])) {
    return;
  }

  level.var_85DF["c6"] = [];
  level.var_85E1["c6"] = [];
  level.var_85DF["c6"]["exposed_throw_grenade"]["exposed_grenade"] = self[[self.var_7190]]("c6", "exposed_throw_grenade", "exposed_grenade");
  level.var_85E1["c6"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  level.var_85E1["c6"]["exposed_throw_grenade"]["exposed_grenade"][0] = (1.50443, 2.92001, 63.2739);
  level.var_85DF["c6"]["cover_stand_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_stand_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_stand_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_stand_grenade"]["grenade_exposed"][0] = (-5.60661, 0.535889, 63.2995);
  level.var_85DF["c6"]["cover_stand_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_stand_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_stand_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_stand_grenade"]["grenade_safe"][0] = (-5.60661, 0.535889, 63.2995);
  level.var_85DF["c6"]["cover_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_crouch_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_exposed"][0] = (-5.60582, 0.535736, 63.2997);
  level.var_85DF["c6"]["cover_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_crouch_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_safe"][0] = (-5.60582, 0.535736, 63.2997);
  level.var_85DF["c6"]["cover_right_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_right_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_right_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_right_grenade"]["grenade_exposed"][0] = (-7.74697, -36.7288, 63.2998);
  level.var_85DF["c6"]["cover_right_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_right_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_right_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_right_grenade"]["grenade_safe"][0] = (-7.74697, -36.7288, 63.2998);
  level.var_85DF["c6"]["cover_right_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_right_crouch_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (-10.7295, -39.4107, 63.0914);
  level.var_85DF["c6"]["cover_right_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_right_crouch_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (-10.7295, -39.4107, 63.0914);
  level.var_85DF["c6"]["cover_left_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_left_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_left_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_left_grenade"]["grenade_exposed"][0] = (-6.18673, 44.8321, 62.3899);
  level.var_85DF["c6"]["cover_left_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_left_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_left_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_left_grenade"]["grenade_safe"][0] = (-6.18673, 44.8321, 62.3899);
  level.var_85DF["c6"]["cover_left_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("c6", "cover_left_crouch_grenade", "grenade_exposed");
  level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (-10.9098, 39.5226, 63.2997);
  level.var_85DF["c6"]["cover_left_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("c6", "cover_left_crouch_grenade", "grenade_safe");
  level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (-10.9098, 39.5226, 63.2997);
}

func_3374() {
  var_0 = [];
  var_1 = [];
  var_0["exposed_crouch"] = var_1;
  var_1 = [];
  var_1["down"] = 15;
  var_0["cover_crouch_lean"] = var_1;
  var_1 = [];
  var_2["cover_crouch_aim"] = var_1;
  var_1 = [];
  var_0["cover_left_crouch_lean"] = var_1;
  var_1 = [];
  var_1["right"] = -15;
  var_0["cover_left_lean"] = var_1;
  var_1 = [];
  var_1["right"] = -15;
  var_0["cover_left_crouch_lean"] = var_1;
  var_1 = [];
  var_1["left"] = 15;
  var_0["cover_right_lean"] = var_1;
  var_1 = [];
  var_1["left"] = 15;
  var_0["cover_right_crouch_lean"] = var_1;
  if(!isDefined(level.var_43FE)) {
    level.var_43FE = [];
    level.var_7361 = [];
    level.var_1A43 = [];
  }

  level.var_43FE["c6"] = var_0;
  level.var_7361["c6"] = var_2;
  var_3 = [];
  var_3["cover_stand_exposed"] = "exposed_crouch";
  var_3["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
  var_3["cover_crouch_hide_to_right"] = "cover_crouch_aim";
  var_3["cover_crouch_hide_to_left"] = "cover_crouch_aim";
  var_3["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
  var_3["cover_crouch_aim"] = "cover_crouch_aim";
  var_3["cover_crouch_lean"] = "cover_crouch_lean";
  var_3["cover_crouch_exposed_left"] = "cover_crouch_aim";
  var_3["cover_crouch_exposed_right"] = "cover_crouch_aim";
  var_3["cover_crouch_to_exposed_crouch"] = "exposed_crouch";
  var_3["cover_right_lean"] = "cover_right_lean";
  var_3["cover_right_hide_to_lean"] = "cover_right_lean";
  var_3["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
  var_3["cover_right_crouch_lean"] = "cover_right_crouch_lean";
  var_3["cover_left_hide_to_lean"] = "cover_left_lean";
  var_3["cover_left_lean"] = "cover_left_lean";
  var_3["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
  var_3["cover_left_crouch_lean"] = "cover_left_crouch_lean";
  var_3["cover_left_crouch_to_exposed_crouch"] = "exposed_crouch";
  level.var_1A43["c6"] = var_3;
}

func_335E(var_0, var_1, var_2, var_3) {
  self.asm.crawlmelee = 1;
  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

func_33AD(var_0, var_1) {
  var_2 = undefined;
  switch (var_0) {
    case "shock_01":
      var_2 = "c6_emp_shock_reaction_01";
      break;

    case "shock_02":
      var_2 = "c6_emp_shock_reaction_02";
      break;

    case "shock_03":
      var_2 = "c6_emp_shock_reaction_03";
      break;
  }

  if(isDefined(var_2) && soundexists(var_2)) {
    self playSound(var_2);
  }
}

func_335C(var_0, var_1, var_2) {
  if(scripts\asm\asm_bb::func_293E()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "haywire");
  } else {
    var_3 = scripts\asm\asm::asm_getdemeanor();
    if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "idle")) {
      var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "idle");
      if(isarray(var_4)) {
        return var_4[randomint(var_4.size)];
      }

      return var_4;
    }
  }

  return lib_0F3D::func_3EAB(var_1, var_2, var_3);
}

func_335D(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm_bb::func_293E()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, scripts\asm\asm_bb::func_2922());
  } else if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
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

func_CEB9(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.angles[1];
  if(isDefined(self.objective_position) && distancesquared(self.origin, self.objective_position.origin) > 144) {
    var_4 = vectortoyaw(self.objective_position.origin - self.origin);
  }

  self orientmode("face angle", var_4);
  var_5 = self[[self.var_7191]](var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  thread lib_0A1E::func_231F(var_0, var_1);
  if(animhasnotetrack(var_5, "grenade_left")) {
    self waittillmatch("grenade_left", var_1);
  } else if(animhasnotetrack(var_5, "grenade_right")) {
    self waittillmatch("grenade_right", var_1);
  } else {
    wait(1);
  }

  if(isDefined(self.objective_position)) {
    self.objective_position delete();
    var_6 = randomfloatrange(1, 1.5);
    var_7 = magicgrenademanual("frag_c6hug", self gettagorigin("tag_accessory_left"), (0, 0, 0), var_6);
    self._meth_85C0 = var_7;
    var_7.angles = self gettagangles("tag_accessory_left");
    var_7 linkto(self, "tag_accessory_left");
  }

  scripts\anim\battlechatter_ai::func_67CF("frag");
}

func_CEB8(var_0, var_1, var_2, var_3) {
  var_4 = self[[self.var_7191]](var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
}

_meth_85C4(var_0, var_1, var_2, var_3) {
  return !isDefined(self._meth_85C0);
}

func_CEBA(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self[[self.var_7191]](var_0, var_1);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  self.bt.var_5615 = 1;
  var_5 = ["right_arm", "left_arm", "torso", "right_leg", "left_leg"];
  foreach(var_7 in var_5) {
    var_8 = self _meth_850C(var_7, "upper");
    var_9 = self _meth_850C(var_7, "lower");
    var_0A = max(var_8, var_9);
    if(var_8 > 0 && var_9 > 0) {
      self _meth_850B(int(var_0A), var_7, "upper");
      self _meth_850B(int(var_0A), var_7, "lower");
    }
  }

  lib_0A1E::func_231F(var_0, var_1);
  self.bt.var_5615 = undefined;
}

func_40FB(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("grenade response", "return throw complete");
}