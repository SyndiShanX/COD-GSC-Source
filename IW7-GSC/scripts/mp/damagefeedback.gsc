/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\damagefeedback.gsc
*********************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["low_damage"] = 25;
  level.hitmarkerpriorities["standard"] = 50;
  level.hitmarkerpriorities["standard_cp"] = 50;
  level.hitmarkerpriorities["high_damage"] = 75;
}

updatedamagefeedback(var_0, var_1, var_2, var_3, var_4) {
  if(!isplayer(self) && !scripts\mp\utility::func_9EF0(self)) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = "standard";
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var_4) {
    if(!isDefined(self.var_903F)) {
      self.var_903F = 0;
    }

    self.var_903F++;
    self setclientomnvar("ui_hitmarker_audio_events", self.var_903F % 16);
  }

  switch (var_0) {
    case "none":
      break;

    case "hitmotionsensor":
    case "hitbulletstorm":
    case "hiticontrophysystem":
    case "hiticonarmorup":
    case "hithealthshield":
    case "hiticonempimmune":
    case "hitspawnprotection":
    case "hitlowdamage":
    case "hitcritical":
    case "hitmorehealth":
    case "hitblastshield":
    case "hittacresist":
    case "thermobaric_debuff":
    case "hitjuggernaut":
    case "hitlightarmor":
    case "hitequip":
      self setclientomnvar("damage_feedback_icon", var_0);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(var_3, var_1, var_2);
      break;

    default:
      updatehitmarker(var_3, var_1, var_2);
      break;
  }
}

updatehitmarker(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  var_3 = gethitmarkerpriority(var_0);
  if(isDefined(self.var_A99E) && self.var_A99E == gettime() && var_3 <= self.var_A99D && !var_1) {
    return;
  }

  self.var_A99E = gettime();
  self.var_A99D = var_3;
  self setclientomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());
  if(var_1) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_2) {
    self setclientomnvar("damage_feedback_headshot", 1);
    return;
  }

  self setclientomnvar("damage_feedback_headshot", 0);
}

gethitmarkerpriority(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_0];
}

hudicontype(var_0) {
  var_1 = 0;
  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_1 = 1;
  }

  if(!isplayer(self)) {
    return;
  }

  switch (var_0) {
    case "throwingknife":
    case "scavenger":
      if(!var_1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }
      break;

    case "scavenger_eqp":
      if(!var_1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }
      break;

    case "boxofguns":
      if(!var_1) {
        self playlocalsound("mp_box_guns_ammo");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }
      break;

    case "eqp_ping":
      if(!var_1) {
        self playsoundtoplayer("mp_cranked_countdown", self);
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }
      break;
  }
}