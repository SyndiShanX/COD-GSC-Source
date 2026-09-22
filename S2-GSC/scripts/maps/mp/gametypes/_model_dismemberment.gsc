/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_model_dismemberment.gsc
**************************************************************/

_id_2E43(var_0, var_1) {
  if(getdvarint("scr_dismemberment_style", 0) == 0) {
    return;
  }
}

_id_5E60(var_0) {
  switch (var_0) {
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

_id_20AF(var_0) {
  if(isDefined(self._id_4B53) && var_0 != 16) {
    return 1;
  }

  switch (var_0) {
    case 1:
      return 0.45;
    case 2:
      return 0.45;
    case 4:
      return 0.5;
    case 8:
      return 0.5;
    case 16:
      if(common_scripts\utility::_id_562E(self._id_4B6E) || common_scripts\utility::_id_562E(self._id_4B5A)) {
        return 1;
      }

      return 0.65;
    default:
      return 1;
  }
}

_id_4558(var_0, var_1) {
  var_2 = 40;

  switch (var_0) {
    case 2:
    case 1:
      return self.origin + (0, 0, var_2);
    case 8:
    case 4:
      var_3 = self gettagorigin(var_1);
      return (self.origin[0], self.origin[1], var_3[2]);
    case 16:
      return self gettagorigin(var_1);
  }
}

_id_4559(var_0, var_1) {
  if(isDefined(self._id_2FE3) && isDefined(self._id_2FE3[var_0])) {
    var_2 = self._id_2FE3[var_0][var_1];

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  var_3 = level._id_2FDE[var_0][var_1];
  return var_3;
}

_id_52A9() {
  level._id_2FDD = [];
  level._id_66BF = 0;
  level._id_2FDE[1]["modelToSpawn"] = "zom_shared_r_arm_slice";
  level._id_2FDE[2]["modelToSpawn"] = "zom_shared_l_arm_slice";
  level._id_2FDE[4]["modelToSpawn"] = "zom_shared_r_leg_slice";
  level._id_2FDE[8]["modelToSpawn"] = "zom_shared_l_leg_slice";
  level._id_2FDE[1]["tagName"] = "J_Shoulder_RI";
  level._id_2FDE[2]["tagName"] = "J_Shoulder_LE";
  level._id_2FDE[4]["tagName"] = "J_Hip_RI";
  level._id_2FDE[8]["tagName"] = "J_Hip_LE";
  level._id_2FDE[16]["tagName"] = "J_Head";
  level._id_2FDE[1]["fxTagName"] = "J_Shoulder_RI";
  level._id_2FDE[2]["fxTagName"] = "J_Shoulder_LE";
  level._id_2FDE[4]["fxTagName"] = "J_Hip_RI";
  level._id_2FDE[8]["fxTagName"] = "J_Hip_LE";
  level._id_2FDE[16]["fxTagName"] = "J_Head";
  level._id_2FDE["full"]["fxTagName"] = "J_MainRoot";
  level._id_2FDE[1]["torsoFX"] = "torso_arm_loss_right";
  level._id_2FDE[2]["torsoFX"] = "torso_arm_loss_left";
  level._id_2FDE[4]["torsoFX"] = "torso_loss_right";
  level._id_2FDE[8]["torsoFX"] = "torso_loss_left";
  level._id_2FDE[16]["torsoFX"] = "torso_head_loss";
  level._id_2FDE[1]["limbFX"] = "arm_loss_right";
  level._id_2FDE[2]["limbFX"] = "arm_loss_left";
  level._id_2FDE[4]["limbFX"] = "limb_loss_right";
  level._id_2FDE[8]["limbFX"] = "limb_loss_left";
  level._id_2FDE[16]["gibFX"] = "head_gibs";
  level._id_2FDE[1]["dismemberSound"] = "zmb_dism_arm";
  level._id_2FDE[2]["dismemberSound"] = "zmb_dism_arm";
  level._id_2FDE[4]["dismemberSound"] = "zmb_dism_leg";
  level._id_2FDE[8]["dismemberSound"] = "zmb_dism_leg";
  level._id_2FDE[16]["dismemberSound"] = "zmb_dism_head";
  level._id_2FDE["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
  level._effect["torso_arm_loss_right"] = loadfx("vfx/blood/mp_torso_loss_arm_ri");
  level._effect["torso_loss_left"] = loadfx("vfx/blood/mp_torso_loss_impact_le");
  setdvarifuninitialized("scr_dismemberment_style", 0);
}

_id_4AAB(var_0) {
  var_1 = "free";
  var_2 = [["mp_core_death_lingering_from_back_01", 301, 0, 1.0, "torso_loss_left", "J_Hip_RI"], ["mp_core_death_lingering_from_front_01", 303, 0, 1.0, "torso_loss_left", "J_Hip_LE"], ["mp_core_death_lingering_from_left_01", 302, 0, 1.0, "torso_arm_loss_right", "J_Elbow_RI"], ["mp_core_death_lingering_from_right_01", 300, 0, 1.0, "torso_arm_loss_right", "J_Elbow_LE"]];
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_0) && _isstring(var_0)) {
    if(var_0 == "left_leg") {
      var_4 = var_2[0];
    } else if(var_0 == "right_leg") {
      var_4 = var_2[1];
    } else if(var_0 == "left_arm") {
      var_4 = var_2[2];
    } else if(var_0 == "right_arm") {
      var_4 = var_2[3];
    } else {}
  } else {
    var_5 = self._id_18A8 getcorpseanim();

    if(_animhasnotetrack(var_5, "left_leg")) {
      var_4 = var_2[1];
      self._id_5D9F = 1;
    } else if(_animhasnotetrack(var_5, "right_leg")) {
      var_4 = var_2[0];
      self._id_5D9F = 1;
    } else if(_animhasnotetrack(var_5, "left_arm")) {
      var_4 = var_2[3];
      self._id_5D9F = 1;
    } else if(_animhasnotetrack(var_5, "right_arm")) {
      var_4 = var_2[2];
      self._id_5D9F = 1;
    } else {
      var_4 = common_scripts\utility::random(var_2);
      var_3 = 0.5;
    }

    var_6 = _randomfloat(1.0);

    if(!isDefined(var_3)) {
      var_3 = var_4[3];
    }

    if(!common_scripts\utility::_id_562E(var_0) && var_3 < var_6) {
      return;
    }
  }

  var_7 = self._id_267E;

  if(self.classname == "script_model") {
    if(isDefined(self.team)) {
      var_1 = self.team;
    }
  }

  if(isbot(self)) {
    var_7[1] = 0;
  }

  var_7[2] = 0;
  var_7[3] = 0;
  var_7[var_4[2]] = var_4[1];
  self._id_65D2 = var_4[4];
  self._id_65D1 = var_4[5];
  self _meth_84C7(var_7, var_1, 1);
}