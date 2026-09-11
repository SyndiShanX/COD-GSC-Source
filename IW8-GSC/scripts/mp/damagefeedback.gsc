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

function updatedamagefeedback(var0, var1, var2, var3, var4, var5) {
  if(!isPlayer(self) && !scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = "standard";
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var4) {
    if(!isDefined(self.hitmarkeraudioevents)) {
      self.hitmarkeraudioevents = 0;
    }

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  switch (var0) {
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
      updatehitmarker(var3, var1, var2, var5, var0);
      break;
    default:
      updatehitmarker(var3, var1, var2, var5);
      break;
  }
}

function updatehitmarker(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var5 = gethitmarkerpriority(var0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var5 <= self.lasthitmarkerpriority && !var1) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var5;

  if(isDefined(var4) && !istrue(var1)) {
    self setclientomnvar("damage_feedback_icon", var4);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", var0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var1) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var2) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(var3) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function gethitmarkerpriority(var0) {
  if(!isDefined(level.hitmarkerpriorities[var0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var0];
}

function hudicontype(var0) {
  var1 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var1 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(var0 == "axe") {
    var0 = "throwingknife";
  }

  switch (var0) {
    case "crossbowbolt":
    case "ammobox":
    case "scavenger":
    case "throwingknife":
      if(!var1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "throwingknife_fire":
      if(!var1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "suppression":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "br_plunder":
    case "br_armor":
    case "br_ammo":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "tacinsert_destroyed":
      if(!var1) {
        self playlocalsound("iw8_tactical_insert_smash");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "intel_folder":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "truckheal":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
  }
}