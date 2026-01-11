/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2715.gsc
***************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["low_damage"] = 25;
  level.hitmarkerpriorities["standard"] = 50;
  level.hitmarkerpriorities["standard_cp"] = 50;
  level.hitmarkerpriorities["high_damage"] = 75;
}

updatedamagefeedback(var_00, var_01, var_02, var_03, var_04) {
  if(!isplayer(self) && !scripts\mp\utility\game::func_9EF0(self)) {
    return;
  }
  if(!isDefined(var_03)) {
    var_03 = "standard";
  }

  if(!isDefined(var_04)) {
    var_04 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var_04) {
    if(!isDefined(self.func_903F)) {
      self.func_903F = 0;
    }

    self.func_903F++;
    self setclientomnvar("ui_hitmarker_audio_events", self.func_903F % 16);
  }

  switch (var_00) {
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
      self setclientomnvar("damage_feedback_icon", var_00);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      updatehitmarker(var_03, var_01, var_02);
      break;
    default:
      updatehitmarker(var_03, var_01, var_02);
      break;
  }
}

updatehitmarker(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_02 = 0;
  var_03 = gethitmarkerpriority(var_00);

  if(isDefined(self.func_A99E) && self.func_A99E == gettime() && var_03 <= self.func_A99D && !var_01) {
    return;
  }
  self.func_A99E = gettime();
  self.func_A99D = var_03;
  self setclientomnvar("damage_feedback", var_00);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var_01) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_02) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }
}

gethitmarkerpriority(var_00) {
  if(!isDefined(level.hitmarkerpriorities[var_00])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_00];
}

hudicontype(var_00) {
  var_01 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_01 = 1;
  }

  if(!isplayer(self)) {
    return;
  }
  switch (var_00) {
    case "throwingknife":
    case "scavenger":
      if(!var_01) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
    case "scavenger_eqp":
      if(!var_01) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
    case "boxofguns":
      if(!var_01) {
        self playlocalsound("mp_box_guns_ammo");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
    case "eqp_ping":
      if(!var_01) {
        self playsoundtoplayer("mp_cranked_countdown", self);
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
  }
}