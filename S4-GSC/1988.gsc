/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1988.gsc
*************************************************/

init() {
  level._id_79B1 = [];
  level._id_79B1["standard"] = 40;
  level._id_79B1["standardspread"] = 50;
  level._id_79B1["standardspreadarmor"] = 70;
  level._id_79B1["standardarmor"] = 60;
  level._id_79B1["hitequip"] = 30;
}

_id_FC47(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self) && !scripts\mp\utility\killstreak::_id_8992(self)) {
    return;
  }
  if(_id_0A8B::_id_FF20()) {
    if(!isDefined(var_3)) {
      var_3 = "none";
    }
  } else if(!isDefined(var_3))
    var_3 = "standard";

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if((!isDefined(level._id_4301) || !level._id_4301) && !var_4) {
    if(!isDefined(self._id_79B0)) {
      self._id_79B0 = 0;
    }

    self._id_79B0++;
    self setclientomnvar("ui_hitmarker_audio_events", self._id_79B0 % 16);
  }

  switch (var_0) {
    case "none":
      break;
    case "hitghost":
    case "hithelmetheavybreak":
    case "hittrophysystem":
    case "hitarmorheavybreak":
    case "hitmechanic":
    case "hitspawnprotect":
    case "hitadrenaline":
    case "hithelmetlight":
    case "hithelmetlightbreak":
    case "hitarmorlightbreak":
    case "hitarmorlight":
    case "hitblastshield":
    case "hitarmorheavy":
    case "hitjuggernaut":
    case "hitlaststand":
    case "hithelmetheavy":
    case "hitnooutline":
    case "hitzombieheadshot":
    case "hittacresist":
    case "hitequip":
      _id_FC86(var_3, var_1, var_2, var_5, var_0, var_6);
      break;
    default:
      _id_FC86(var_3, var_1, var_2, var_5, undefined, var_6);
      break;
  }
}

_id_FC86(var_0, var_1, var_2, var_3, var_4, var_5) {
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

  var_6 = isDefined(self._id_8FF0) && self._id_8FF0 == gettime();
  var_7 = 0;

  if(var_6) {
    var_7 = self _meth_876E("damage_feedback_shots_hit");
  }

  if(isDefined(var_5) && var_5 > 0) {
    self setclientomnvar("damage_feedback_shots_hit", var_7 + var_5);
  }

  var_8 = _id_6AA5(var_0);

  if(var_6 && var_8 <= self._id_8FEF && !var_1) {
    return;
  }
  self._id_8FF0 = gettime();
  self._id_8FEF = var_8;

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
  } else {
    self setclientomnvar("damage_feedback_nonplayer", 0);
  }
}

_id_6AA5(var_0) {
  if(!isDefined(level._id_79B1[var_0])) {
    return 0;
  }

  return level._id_79B1[var_0];
}

setaxefeedbackicon(var_0, var_1) {
  if(level._id_74C4) {
    return;
  }
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = _func_0222("mp/throwableMeleePickupFeedback.csv", 0, var_1.basename, 1);
  }

  if(!isDefined(var_2) || var_2 == "") {
    var_2 = var_0;
  }

  self setclientomnvar("damage_feedback_other", var_2);
}

_id_7B6B(var_0, var_1) {
  var_2 = 0;

  if(isDefined(level._id_4301) && level._id_4301) {
    var_2 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }
  switch (var_0) {
    case "axe":
      setaxefeedbackicon(var_0, var_1);
      break;
    case "throwingknife":
    case "deaddrop":
    case "ammobox":
    case "crossbowbolt":
    case "scavenger":
    case "scout":
      if(!level._id_74C4) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "suppression":
      if(!level._id_74C4) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "br_ammo":
    case "br_plunder":
    case "br_armor":
      if(!level._id_74C4) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "tacinsert_destroyed":
      if(!level._id_74C4) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
  }
}