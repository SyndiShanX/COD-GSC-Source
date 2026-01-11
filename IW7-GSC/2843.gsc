/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2843.gsc
***************************************/

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
  if(isDefined(level.func_4D4D)) {
    return;
  }
  if(scripts\sp\utility::func_93A6()) {
    return;
  }
  scripts\sp\utility::func_16B7(::func_4D4C);
}

func_4D4C(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!getdvarint("scr_damagefeedback", 0)) {
    return;
  }
  if(!isDefined(var_01) || !isplayer(var_01) && !var_01 func_9EF8() || var_01 == self || var_00 <= 0) {
    return;
  }
  var_10 = "standard";
  var_11 = "standard";

  if(isDefined(var_09)) {
    if(var_00 <= _weapongetdamagemin(var_09)) {
      var_11 = "low_damage";
    }
    else if(var_00 >= _weapongetdamagemax(var_09)) {
      var_11 = "high_damage";
    }
  }

  var_12 = 0;
  var_13 = 0;

  if(isai(self)) {
    var_12 = !isalive(self);
    var_13 = isheadshot(var_07);
  }

  level.player thread updatedamagefeedback(var_10, var_12, var_13, var_11, self);
}

func_9EF8() {
  if(isDefined(self.unittype) && self.unittype == "seeker") {
    if(isDefined(self.owner) && self.owner == level.player) {
      return 1;
    }
  }

  return 0;
}

func_4D4B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isDefined(level.func_D127) || !isDefined(var_01) || var_01 != level.func_D127) {
    return;
  }
  func_4D4C(var_00, level.player, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
}

updatedamagefeedback(var_00, var_01, var_02, var_03, var_04) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_03)) {
    var_03 = "standard";
  }

  switch (var_00) {
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
      setomnvar("damage_feedback_icon", var_00);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(var_03, var_01, var_02);
      break;
    case "none":
      break;
    default:
      updatehitmarker(var_03, var_01, var_02, var_04);
      break;
  }
}

updatehitmarker(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  if(isDefined(var_03) && var_3.team == "allies") {
    return;
  }
  var_04 = gethitmarkerpriority(var_00);

  if(isDefined(self.func_A99E) && self.func_A99E == gettime() && var_04 <= self.func_A99D && !var_01) {
    return;
  }
  self.func_A99E = gettime();
  self.func_A99D = var_04;
  setomnvar("damage_feedback", var_00);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var_01) {
    setomnvar("damage_feedback_kill", 1);
  }
  else {
    setomnvar("damage_feedback_kill", 0);
  }

  if(var_02) {
    setomnvar("damage_feedback_headshot", 1);
  }
  else {
    setomnvar("damage_feedback_headshot", 0);
  }
}

gethitmarkerpriority(var_00) {
  if(!isDefined(level.hitmarkerpriorities[var_00])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_00];
}

isheadshot(var_00) {
  switch (var_00) {
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