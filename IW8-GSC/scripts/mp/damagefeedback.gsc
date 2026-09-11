/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\damagefeedback.gsc
***********************************************/

function init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["standardspreadarmor"] = 70;
  level.hitmarkerpriorities["standardarmor"] = 60;
  level.hitmarkerpriorities["hitequip"] = 30;
  level.hitmarkerpriorities["hitturretx2"] = 60;
  level.hitmarkerpriorities["hitturretx2break"] = 70;
  level.hitmarkerpriorities["hitheadx2"] = 70;
  level.hitmarkerpriorities["hitheadx2break"] = 80;
}

function updatedamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self) && !scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = "standard";
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var_4) {
    if(!isDefined(self.hitmarkeraudioevents)) {
      self.hitmarkeraudioevents = 0;
    }

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  switch (var_0) {
    case "none":
      break;
    case "hitadrenaline":
    case "hithelmetlight":
    case "hithelmetlightbreak":
    case "hitarmorlightbreak":
    case "hitserpentine":
    case "hitarmorreinforced":
    case "hitarmorreinforcedbreak":
    case "hitarmorlight":
    case "hitblastshield":
    case "hitarmorheavy":
    case "hitjuggernaut":
    case "hitspawnprotect":
    case "hitlaststand":
    case "hitzombieheadshot":
    case "hitghost":
    case "hitnooutline":
    case "hithelmetheavybreak":
    case "hithelmetheavy":
    case "hitarmorheavybreak":
    case "hitheadx2break":
    case "hitheadx2":
    case "hitturretx2break":
    case "hitturretx2":
    case "hittrophysystem":
    case "hittacresist":
    case "hitequip":
      updatehitmarker(var_3, var_1, var_2, var_5, var_0);
      break;
    default:
      updatehitmarker(var_3, var_1, var_2, var_5);
      break;
  }
}

function updatehitmarker(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = gethitmarkerpriority(var_0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var_5 <= self.lasthitmarkerpriority && !var_1) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var_5;

  if(isDefined(var_4) && !istrue(var_1)) {
    self setclientomnvar("damage_feedback_icon", var_4);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var_1) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_2) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(var_3) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function gethitmarkerpriority(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_0];
}

function hudicontype(var_0) {
  var_1 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_1 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(var_0 == "axe") {
    var_0 = "throwingknife";
  }

  switch (var_0) {
    case "crossbowbolt":
    case "ammobox":
    case "scavenger":
    case "throwingknife":
      if(!var_1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "throwingknife_fire":
      if(!var_1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "suppression":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "br_plunder":
    case "br_armor":
    case "br_ammo":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "tacinsert_destroyed":
      if(!var_1) {
        self playlocalsound("iw8_tactical_insert_smash");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "intel_folder":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "truckheal":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
  }
}