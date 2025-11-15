/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\damagefeedback.gsc
*****************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["low_damage"] = 25;
  level.hitmarkerpriorities["standard"] = 50;
  level.hitmarkerpriorities["standard_cp"] = 50;
  level.hitmarkerpriorities["high_damage"] = 75;
}

updatedamagefeedback(param_00, param_01, param_02, param_03, param_04) {
  if(!isplayer(self) && !scripts\mp\utility::func_9EF0(self)) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = "standard";
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !param_04) {
    if(!isDefined(self.var_903F)) {
      self.var_903F = 0;
    }

    self.var_903F++;
    self setclientomnvar("ui_hitmarker_audio_events", self.var_903F % 16);
  }

  switch (param_00) {
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
      self setclientomnvar("damage_feedback_icon", param_00);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(param_03, param_01, param_02);
      break;

    default:
      updatehitmarker(param_03, param_01, param_02);
      break;
  }
}

updatehitmarker(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  param_02 = 0;
  var_03 = gethitmarkerpriority(param_00);
  if(isDefined(self.var_A99E) && self.var_A99E == gettime() && var_03 <= self.var_A99D && !param_01) {
    return;
  }

  self.var_A99E = gettime();
  self.var_A99D = var_03;
  self setclientomnvar("damage_feedback", param_00);
  self setclientomnvar("damage_feedback_notify", gettime());
  if(param_01) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(param_02) {
    self setclientomnvar("damage_feedback_headshot", 1);
    return;
  }

  self setclientomnvar("damage_feedback_headshot", 0);
}

gethitmarkerpriority(param_00) {
  if(!isDefined(level.hitmarkerpriorities[param_00])) {
    return 0;
  }

  return level.hitmarkerpriorities[param_00];
}

hudicontype(param_00) {
  var_01 = 0;
  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_01 = 1;
  }

  if(!isplayer(self)) {
    return;
  }

  switch (param_00) {
    case "throwingknife":
    case "scavenger":
      if(!var_01) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", param_00);
      }
      break;

    case "scavenger_eqp":
      if(!var_01) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", param_00);
      }
      break;

    case "boxofguns":
      if(!var_01) {
        self playlocalsound("mp_box_guns_ammo");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", param_00);
      }
      break;

    case "eqp_ping":
      if(!var_01) {
        self playsoundtoplayer("mp_cranked_countdown", self);
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", param_00);
      }
      break;
  }
}