/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\damagefeedback.gsc
***********************************************/

function init() {
  if(getdvarint("scr_damageFeedbackDisabled")) {
    return;
  }

  precacheshader("damage_feedback_thin");
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["low_damage"] = 35;
  level.hitmarkerpriorities["standard"] = 50;
  level.hitmarkerpriorities["standard_cp"] = 50;
  level.hitmarkerpriorities["high_damage"] = 85;
}

function damagefeedback_took_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(getdvarint("scr_damageFeedbackDisabled")) {
    return;
  }

  if(!isDefined(var1) || !isPlayer(var1) || var1 == self || var0 <= 0) {
    return;
  }

  var10 = "standard";
  var11 = "standard";

  if(isDefined(var9)) {
    if(var0 <= weapongetdamagemin(var9)) {
      var11 = "low_damage";
    } else if(var0 >= weapongetdamagemax(var9)) {
      var11 = "high_damage";
    }
  }

  var12 = 0;
  var13 = 0;

  if(isai(self)) {
    var12 = !isalive(self);
    var13 = isheadshot(var7);
  }

  thread updatedamagefeedback(level.player, var10, var12, var13, var11);
}

function updatedamagefeedback(var0, var1, var2, var3, var4) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = "standard";
  }

  switch (var0) {
    case "hithealthshield":
    case "hitspawnprotect":
    case "hitbulletstorm":
    case "hitcritical":
    case "hitmotionsensor":
    case "hitmorehealth":
    case "hitjuggernaut":
    case "hitlightarmor":
    case "hitblastshield":
    case "thermobaric_debuff":
      setomnvar("damage_feedback_icon", var0);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(var3, var1, var2);
      break;
    case "none":
      break;
    default:
      updatehitmarker(var3, var1, var2, var4);
      break;
  }
}

function updatehitmarker(var0, var1, var2, var3) {
  if(getdvarint("scr_no_hitmarker")) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isDefined(var3) && var3.team == "allies") {
    return;
  }

  var4 = gethitmarkerpriority(var0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var4 <= self.lasthitmarkerpriority && !var1) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var4;
  setomnvar("damage_feedback", var0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var1) {
    setomnvar("damage_feedback_kill", 1);
  } else {
    setomnvar("damage_feedback_kill", 0);
  }

  if(var2) {
    setomnvar("damage_feedback_headshot", 1);
    return;
  }

  setomnvar("damage_feedback_headshot", 0);
}

function gethitmarkerpriority(var0) {
  if(!isDefined(level.hitmarkerpriorities[var0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var0];
}

function isheadshot(var0) {
  switch (var0) {
    case "j_head_pv_z":
    case "j_head_pv_horizontal":
    case "j_head":
    case "j_neck":
      return true;
    default:
      return false;
  }

  return false;
}