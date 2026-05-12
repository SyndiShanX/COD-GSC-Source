/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_model_dismemberment.gsc
******************************************************/

func_2E43(param_00, param_01) {
  if(getdvarint("scr_dismemberment_style", 0) == 0) {}
}

func_5E60(param_00) {
  switch (param_00) {
    case "right_arm_lower":
    case "right_hand":
    case "right_arm_upper":
      return 1;

    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;

    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 4;

    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 8;

    case "neck":
    case "helmet":
    case "head":
      return 16;

    default:
      return 0;
  }
}

func_20AF(param_00) {
  if(isDefined(self.var_4B53) && param_00 != 16) {
    return 1;
  }

  switch (param_00) {
    case 1:
      return 0.45;

    case 2:
      return 0.45;

    case 4:
      return 0.5;

    case 8:
      return 0.5;

    case 16:
      if(common_scripts\utility::func_562E(self.var_4B6E) || common_scripts\utility::func_562E(self.var_4B5A)) {
        return 1;
      }
      return 0.65;

    default:
      return 1;
  }
}

func_4558(param_00, param_01) {
  var_02 = 40;
  switch (param_00) {
    case 2:
    case 1:
      return self.var_0116 + (0, 0, var_02);

    case 8:
    case 4:
      var_03 = self gettagorigin(param_01);
      return (self.var_0116[0], self.var_0116[1], var_03[2]);

    case 16:
      return self gettagorigin(var_02);
  }
}

func_4559(param_00, param_01) {
  if(isDefined(self.var_2FE3) && isDefined(self.var_2FE3[param_00])) {
    var_02 = self.var_2FE3[param_00][param_01];
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  var_03 = level.var_2FDE[param_00][param_01];
  return var_03;
}

func_52A9() {
  level.var_2FDD = [];
  level.var_66BF = 0;
  level.var_2FDE[1]["modelToSpawn"] = "zom_shared_r_arm_slice";
  level.var_2FDE[2]["modelToSpawn"] = "zom_shared_l_arm_slice";
  level.var_2FDE[4]["modelToSpawn"] = "zom_shared_r_leg_slice";
  level.var_2FDE[8]["modelToSpawn"] = "zom_shared_l_leg_slice";
  level.var_2FDE[1]["tagName"] = "J_Shoulder_RI";
  level.var_2FDE[2]["tagName"] = "J_Shoulder_LE";
  level.var_2FDE[4]["tagName"] = "J_Hip_RI";
  level.var_2FDE[8]["tagName"] = "J_Hip_LE";
  level.var_2FDE[16]["tagName"] = "J_Head";
  level.var_2FDE[1]["fxTagName"] = "J_Shoulder_RI";
  level.var_2FDE[2]["fxTagName"] = "J_Shoulder_LE";
  level.var_2FDE[4]["fxTagName"] = "J_Hip_RI";
  level.var_2FDE[8]["fxTagName"] = "J_Hip_LE";
  level.var_2FDE[16]["fxTagName"] = "J_Head";
  level.var_2FDE["full"]["fxTagName"] = "J_MainRoot";
  level.var_2FDE[1]["torsoFX"] = "torso_arm_loss_right";
  level.var_2FDE[2]["torsoFX"] = "torso_arm_loss_left";
  level.var_2FDE[4]["torsoFX"] = "torso_loss_right";
  level.var_2FDE[8]["torsoFX"] = "torso_loss_left";
  level.var_2FDE[16]["torsoFX"] = "torso_head_loss";
  level.var_2FDE[1]["limbFX"] = "arm_loss_right";
  level.var_2FDE[2]["limbFX"] = "arm_loss_left";
  level.var_2FDE[4]["limbFX"] = "limb_loss_right";
  level.var_2FDE[8]["limbFX"] = "limb_loss_left";
  level.var_2FDE[16]["gibFX"] = "head_gibs";
  level.var_2FDE[1]["dismemberSound"] = "zmb_dism_arm";
  level.var_2FDE[2]["dismemberSound"] = "zmb_dism_arm";
  level.var_2FDE[4]["dismemberSound"] = "zmb_dism_leg";
  level.var_2FDE[8]["dismemberSound"] = "zmb_dism_leg";
  level.var_2FDE[16]["dismemberSound"] = "zmb_dism_head";
  level.var_2FDE["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
  level.var_0611["torso_arm_loss_right"] = loadfx("vfx/blood/mp_torso_loss_arm_ri");
  level.var_0611["torso_loss_left"] = loadfx("vfx/blood/mp_torso_loss_impact_le");
  setdvarifuninitialized("scr_dismemberment_style", 0);
}

func_4AAB(param_00) {
  var_01 = "free";
  var_02 = [["mp_core_death_lingering_from_back_01", 301, 0, 1, "torso_loss_left", "J_Hip_RI"], ["mp_core_death_lingering_from_front_01", 303, 0, 1, "torso_loss_left", "J_Hip_LE"], ["mp_core_death_lingering_from_left_01", 302, 0, 1, "torso_arm_loss_right", "J_Elbow_RI"], ["mp_core_death_lingering_from_right_01", 300, 0, 1, "torso_arm_loss_right", "J_Elbow_LE"]];
  var_03 = undefined;
  var_04 = undefined;
  if(isDefined(param_00) && isstring(param_00)) {
    if(param_00 == "left_leg") {
      var_04 = var_02[0];
    } else if(param_00 == "right_leg") {
      var_04 = var_02[1];
    } else if(param_00 == "left_arm") {
      var_04 = var_02[2];
    } else if(param_00 == "right_arm") {
      var_04 = var_02[3];
    } else {}
  } else {
    var_05 = self.var_18A8 getcorpseanim();
    if(animhasnotetrack(var_05, "left_leg")) {
      var_04 = var_02[1];
      self.var_5D9F = 1;
    } else if(animhasnotetrack(var_05, "right_leg")) {
      var_04 = var_02[0];
      self.var_5D9F = 1;
    } else if(animhasnotetrack(var_05, "left_arm")) {
      var_04 = var_02[3];
      self.var_5D9F = 1;
    } else if(animhasnotetrack(var_05, "right_arm")) {
      var_04 = var_02[2];
      self.var_5D9F = 1;
    } else {
      var_04 = common_scripts\utility::func_7A33(var_02);
      var_03 = 0.5;
    }

    var_06 = randomfloat(1);
    if(!isDefined(var_03)) {
      var_03 = var_04[3];
    }

    if(!common_scripts\utility::func_562E(param_00) && var_03 < var_06) {
      return;
    }
  }

  var_07 = self.var_267E;
  if(self.var_003A == "script_model") {
    if(isDefined(self.var_01A7)) {
      var_02 = self.var_01A7;
    }
  }

  if(isbot(self)) {
    var_07[1] = 0;
  }

  var_07[2] = 0;
  var_07[3] = 0;
  var_07[var_05[2]] = var_05[1];
  self.var_65D2 = var_05[4];
  self.var_65D1 = var_05[5];
  self setcostumemodels(var_07, var_02, 1);
}