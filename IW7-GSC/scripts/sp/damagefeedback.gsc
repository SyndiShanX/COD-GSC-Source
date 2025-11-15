/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\damagefeedback.gsc
*****************************************/

init() {
  precacheshader("damage_feedback_thin");
  setdvar("scr_damagefeedback", "1");
  if(getdvar("scr_damagefeedback") == "") {
    setdvar("scr_damagefeedback", "0");
  }

  if(!getdvarint("scr_damagefeedback", 0)) {
    return;
  }

  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["low_damage"] = 35;
  level.hitmarkerpriorities["standard"] = 50;
  level.hitmarkerpriorities["standard_cp"] = 50;
  level.hitmarkerpriorities["high_damage"] = 85;
}

monitordamage() {
  if(!getdvarint("scr_damagefeedback", 0)) {
    return;
  }

  if(isDefined(level.var_4D4D)) {
    return;
  }

  if(scripts\sp\utility::func_93A6()) {
    return;
  }

  scripts\sp\utility::func_16B7(::func_4D4C);
}

func_4D4C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!getdvarint("scr_damagefeedback", 0)) {
    return;
  }

  if(!isDefined(param_01) || !isplayer(param_01) && !param_01 func_9EF8() || param_01 == self || param_00 <= 0) {
    return;
  }

  var_0A = "standard";
  var_0B = "standard";
  if(isDefined(param_09)) {
    if(param_00 <= weapongetdamagemin(param_09)) {
      var_0B = "low_damage";
    } else if(param_00 >= weapongetdamagemax(param_09)) {
      var_0B = "high_damage";
    }
  }

  var_0C = 0;
  var_0D = 0;
  if(isai(self)) {
    var_0C = !isalive(self);
    var_0D = isheadshot(param_07);
  }

  level.player thread updatedamagefeedback(var_0A, var_0C, var_0D, var_0B, self);
}

func_9EF8() {
  if(isDefined(self.unittype) && self.unittype == "seeker") {
    if(isDefined(self.triggerportableradarping) && self.triggerportableradarping == level.player) {
      return 1;
    }
  }

  return 0;
}

func_4D4B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(level.var_D127) || !isDefined(param_01) || param_01 != level.var_D127) {
    return;
  }

  func_4D4C(param_00, level.player, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

updatedamagefeedback(param_00, param_01, param_02, param_03, param_04) {
  if(!isplayer(self)) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = "standard";
  }

  switch (param_00) {
    case "hithealthshield":
    case "hitlifelink":
    case "hitbulletstorm":
    case "hitcritical":
    case "hitmotionsensor":
    case "hitmorehealth":
    case "hitjuggernaut":
    case "hitlightarmor":
    case "hitblastshield":
    case "thermobaric_debuff":
      setomnvar("damage_feedback_icon", param_00);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(param_03, param_01, param_02);
      break;

    case "none":
      break;

    default:
      updatehitmarker(param_03, param_01, param_02, param_04);
      break;
  }
}

updatehitmarker(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(isDefined(param_03) && param_03.team == "allies") {
    return;
  }

  var_04 = gethitmarkerpriority(param_00);
  if(isDefined(self.var_A99E) && self.var_A99E == gettime() && var_04 <= self.var_A99D && !param_01) {
    return;
  }

  self.var_A99E = gettime();
  self.var_A99D = var_04;
  setomnvar("damage_feedback", param_00);
  self setclientomnvar("damage_feedback_notify", gettime());
  if(param_01) {
    setomnvar("damage_feedback_kill", 1);
  } else {
    setomnvar("damage_feedback_kill", 0);
  }

  if(param_02) {
    setomnvar("damage_feedback_headshot", 1);
    return;
  }

  setomnvar("damage_feedback_headshot", 0);
}

gethitmarkerpriority(param_00) {
  if(!isDefined(level.hitmarkerpriorities[param_00])) {
    return 0;
  }

  return level.hitmarkerpriorities[param_00];
}

isheadshot(param_00) {
  switch (param_00) {
    case "j_head_pv_horizontal":
    case "j_head_pv_z":
    case "j_head":
    case "j_neck":
      return 1;

    default:
      return 0;
  }

  return 0;
}