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
  if(isDefined(level.var_4D4D)) {
    return;
  }
  if(scripts\sp\utility::func_93A6()) {
    return;
  }
  scripts\sp\utility::func_16B7(::func_4D4C);
}

func_4D4C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!getdvarint("scr_damagefeedback", 0)) {
    return;
  }
  if(!isDefined(var_1) || !isplayer(var_1) && !var_1 func_9EF8() || var_1 == self || var_0 <= 0) {
    return;
  }
  var_10 = "standard";
  var_11 = "standard";

  if(isDefined(var_9)) {
    if(var_0 <= _weapongetdamagemin(var_9)) {
      var_11 = "low_damage";
    } else if(var_0 >= _weapongetdamagemax(var_9)) {
      var_11 = "high_damage";
    }
  }

  var_12 = 0;
  var_13 = 0;

  if(isai(self)) {
    var_12 = !isalive(self);
    var_13 = isheadshot(var_7);
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

func_4D4B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.var_D127) || !isDefined(var_1) || var_1 != level.var_D127) {
    return;
  }
  func_4D4C(var_0, level.player, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

updatedamagefeedback(var_0, var_1, var_2, var_3, var_4) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = "standard";
  }

  switch (var_0) {
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
      setomnvar("damage_feedback_icon", var_0);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(var_3, var_1, var_2);
      break;
    case "none":
      break;
    default:
      updatehitmarker(var_3, var_1, var_2, var_4);
      break;
  }
}

updatehitmarker(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(var_3) && var_3.team == "allies") {
    return;
  }
  var_4 = gethitmarkerpriority(var_0);

  if(isDefined(self.var_A99E) && self.var_A99E == gettime() && var_4 <= self.var_A99D && !var_1) {
    return;
  }
  self.var_A99E = gettime();
  self.var_A99D = var_4;
  setomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var_1) {
    setomnvar("damage_feedback_kill", 1);
  } else {
    setomnvar("damage_feedback_kill", 0);
  }

  if(var_2) {
    setomnvar("damage_feedback_headshot", 1);
  } else {
    setomnvar("damage_feedback_headshot", 0);
  }
}

gethitmarkerpriority(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_0];
}

isheadshot(var_0) {
  switch (var_0) {
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