/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\damagefeedback.gsc
***********************************************/

_id_6B5E33C2F005F4A6() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["standardspreadarmor"] = 70;
  level.hitmarkerpriorities["standardspreadarmorbreak"] = 71;
  level.hitmarkerpriorities["standardarmor"] = 60;
  level.hitmarkerpriorities["standardarmorbreak"] = 61;
  level.hitmarkerpriorities["threeplatearmorbreak"] = 1;
  level.hitmarkerpriorities["temperedarmorbreak"] = 1;
  level.hitmarkerpriorities["hitequip"] = 30;
}

_id_7BC7C3983CEF0956(marker, priority) {
  level.hitmarkerpriorities[marker] = priority;
}

updatedamagefeedback(_id_DC382B1157307F94, _id_D7198CEB7D51DB5B, headshot, _id_B98146816886D3C4, _id_62CF84636D4CEF2C, _id_C4F1516C772B1C2D, _id_1A3325FBF315EEE7, _id_F7EA2887B1E3535B) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(_id_B98146816886D3C4))
    _id_B98146816886D3C4 = "standard";

  if(!isDefined(_id_62CF84636D4CEF2C))
    _id_62CF84636D4CEF2C = 0;

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !_id_62CF84636D4CEF2C) {
    if(!isDefined(self.hitmarkeraudioevents))
      self.hitmarkeraudioevents = 0;

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  switch (_id_DC382B1157307F94) {
    case "none":
      break;
    case "hitequip":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "hasAPRRounds")) {
        if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "hasAPRRounds")]]()) {
          _id_7A8A48132995D0FC = "hitsuppression";
          updatehitmarker(_id_B98146816886D3C4, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_7A8A48132995D0FC, _id_1A3325FBF315EEE7);
          break;
        }
      }
    case "hitspawnprotect":
    case "hitarmorheavybreak":
    case "hitarmortemperedbreak":
    case "hitzombieshout":
    case "hitskydiveprotection":
    case "hitghost":
    case "hitarmormaxplatebreak":
    case "hitheadhunter":
    case "hithelmetheavybreak":
    case "reactivearmorexplosion":
    case "hithealth":
    case "hitsoundveil":
    case "hitarmorlighttempered":
    case "hitquickfix":
    case "hittrophysystem":
    case "hitarmorheavy":
    case "hithelmetlight":
    case "hitarmorlight":
    case "hitlaststand":
    case "hitadrenaline":
    case "hithelmetlightbreak":
    case "hitsuppression":
    case "hitblastshield":
    case "hithelmetheavy":
    case "hitnooutline":
    case "hitbattlerage":
    case "hitarmorlightmaxlevel":
    case "hitnobulletdamage":
    case "hitveharmorbreak":
    case "hittacresist":
    case "hitarmorlightbreak":
    case "hitjuggernaut":
      updatehitmarker(_id_B98146816886D3C4, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_DC382B1157307F94, _id_1A3325FBF315EEE7, _id_F7EA2887B1E3535B);
      break;
    default:
      updatehitmarker(_id_B98146816886D3C4, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, undefined, _id_1A3325FBF315EEE7, _id_F7EA2887B1E3535B);
      break;
  }
}

updatehitmarker(_id_E0EA2C8DF06F13EB, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_DC382B1157307F94, _id_1A3325FBF315EEE7, _id_F7EA2887B1E3535B) {
  if(_id_FA167EB35EC0EEEA()) {
    return;
  }
  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(!isDefined(_id_D7198CEB7D51DB5B))
    _id_D7198CEB7D51DB5B = 0;

  if(!isDefined(headshot))
    headshot = 0;

  if(!isDefined(_id_C4F1516C772B1C2D))
    _id_C4F1516C772B1C2D = 0;

  if(!isDefined(_id_1A3325FBF315EEE7))
    _id_1A3325FBF315EEE7 = -1;

  if(!isDefined(_id_F7EA2887B1E3535B))
    _id_F7EA2887B1E3535B = 0;

  if(getdvarint("dvar_1DB87C3B655B5645", 0) == 1) {
    _id_06EF23CE7743299E = spawnStruct();
    _id_06EF23CE7743299E._id_E0EA2C8DF06F13EB = _id_E0EA2C8DF06F13EB;
    _id_06EF23CE7743299E._id_D7198CEB7D51DB5B = _id_D7198CEB7D51DB5B;
    _id_06EF23CE7743299E.headshot = headshot;
    _id_06EF23CE7743299E._id_C4F1516C772B1C2D = _id_C4F1516C772B1C2D;
    _id_06EF23CE7743299E._id_DC382B1157307F94 = _id_DC382B1157307F94;
    _id_06EF23CE7743299E._id_1A3325FBF315EEE7 = _id_1A3325FBF315EEE7;
    _id_06EF23CE7743299E.timestamp = gettime();

    if(!isDefined(self._id_2E4039D7593EBF54))
      self._id_2E4039D7593EBF54 = [];

    self._id_2E4039D7593EBF54[self._id_2E4039D7593EBF54.size] = _id_06EF23CE7743299E;
    thread _id_6A07EF2910DEA0E5();
  } else {
    priority = gethitmarkerpriority(_id_E0EA2C8DF06F13EB);

    if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !_id_D7198CEB7D51DB5B) {
      return;
    }
    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = priority;

    if(isDefined(_id_DC382B1157307F94) && !istrue(_id_D7198CEB7D51DB5B)) {
      self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(isDefined(_id_DC382B1157307F94) && _id_DC382B1157307F94 == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(isDefined(_id_DC382B1157307F94) && _id_DC382B1157307F94 == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(!isDefined(_id_DC382B1157307F94) || _id_DC382B1157307F94 != "hitnobulletdamage") {
      self setclientomnvar("damage_feedback", _id_E0EA2C8DF06F13EB);
      self setclientomnvar("damage_feedback_notify", gettime());
    }

    if(_id_D7198CEB7D51DB5B)
      self setclientomnvar("damage_feedback_kill", 1);
    else
      self setclientomnvar("damage_feedback_kill", 0);

    if(headshot)
      self setclientomnvar("damage_feedback_headshot", 1);
    else
      self setclientomnvar("damage_feedback_headshot", 0);

    if(_id_C4F1516C772B1C2D)
      self setclientomnvar("damage_feedback_nonplayer", 1);
    else
      self setclientomnvar("damage_feedback_nonplayer", 0);

    self setclientomnvar("damage_feedback_armor", int(min(_id_F7EA2887B1E3535B, 3)));

    if(_id_1A3325FBF315EEE7 > -1) {
      self setclientomnvar("damage_feedback_entity", _id_1A3325FBF315EEE7);
      self setclientomnvar("damage_feedback_entity_notify", gettime());
    }
  }
}

gethitmarkerpriority(_id_B98146816886D3C4) {
  if(!isDefined(level.hitmarkerpriorities[_id_B98146816886D3C4]))
    return 0;

  return level.hitmarkerpriorities[_id_B98146816886D3C4];
}

hudicontype(_id_CDCEDB142F61B43E) {
  _id_B53415265B603895 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound)
    _id_B53415265B603895 = 1;

  if(!isPlayer(self)) {
    return;
  }
  switch (_id_CDCEDB142F61B43E) {
    case "ammofeeder":
    case "scavenger":
    case "crossbowbolt":
    case "ammobox":
    case "blastshield_box":
    case "xp_pickup":
      if(!_id_B53415265B603895)
        self playlocalsound("scavenger_pack_pickup");

      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "throwstar":
    case "throwingknife_fire":
    case "throwingknife":
      if(!_id_B53415265B603895)
        self playlocalsound("weap_pickup_knife_plr");

      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "suppression":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "geiger":
    case "flash":
    case "br_armor":
    case "br_ammo_rocket":
    case "br_ammo_50cal":
    case "br_ammo_12g":
    case "br_ammo_919":
    case "br_ammo_762":
    case "binoculars":
    case "at_mine":
    case "snapshot":
    case "bunker_buster":
    case "smoke":
    case "shockstick":
    case "iodine_pills":
    case "hb_sensor":
    case "c4":
    case "br_plunder":
    case "br_ammo":
    case "stun":
    case "stim":
    case "decoy":
    case "claymore":
    case "semtex":
    case "frag":
    case "thermite":
    case "molotov":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "tacinsert_destroyed":
      if(!_id_B53415265B603895)
        self playlocalsound("iw9_tactical_insert_smash");

      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "intel_folder":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "truckheal":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "quickfix":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
  }

  thread _id_7A129DCA534BE5F9();
}

_id_7A129DCA534BE5F9() {
  self notify("hitIconReset");
  self endon("disconnect");
  self endon("hitIconReset");
  waitframe();
  self setclientomnvar("damage_feedback_other", "standard");
}

_id_FA167EB35EC0EEEA() {
  return istrue(level._id_F4B090DBBD2B125B);
}

_id_6A07EF2910DEA0E5() {
  self notify("hitmarkerStack_singleton");
  self endon("hitmarkerStack_singleton");

  while(isDefined(self._id_2E4039D7593EBF54) && self._id_2E4039D7593EBF54.size != 0) {
    waitframe();

    if(!isDefined(self) || _func_96D228FA8E72A818(self)) {
      break;
    }

    if(!isDefined(self._id_2E4039D7593EBF54)) {
      continue;
    }
    _id_237EA2FB76BEA663 = self._id_2E4039D7593EBF54[0];
    self._id_2E4039D7593EBF54[0] = undefined;
    self._id_2E4039D7593EBF54 = scripts\engine\utility::array_removeundefined(self._id_2E4039D7593EBF54);

    if(!isDefined(_id_237EA2FB76BEA663)) {
      continue;
    }
    if(isDefined(_id_237EA2FB76BEA663._id_DC382B1157307F94) && !istrue(_id_237EA2FB76BEA663._id_D7198CEB7D51DB5B)) {
      self setclientomnvar("damage_feedback_icon", _id_237EA2FB76BEA663._id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", _id_237EA2FB76BEA663.timestamp);
    }

    if(isDefined(_id_237EA2FB76BEA663._id_DC382B1157307F94) && _id_237EA2FB76BEA663._id_DC382B1157307F94 == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", _id_237EA2FB76BEA663._id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", _id_237EA2FB76BEA663.timestamp);
    }

    if(isDefined(_id_237EA2FB76BEA663._id_DC382B1157307F94) && _id_237EA2FB76BEA663._id_DC382B1157307F94 == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", _id_237EA2FB76BEA663._id_DC382B1157307F94);
      self setclientomnvar("damage_feedback_icon_notify", _id_237EA2FB76BEA663.timestamp);
    }

    self setclientomnvar("damage_feedback", _id_237EA2FB76BEA663._id_E0EA2C8DF06F13EB);
    self setclientomnvar("damage_feedback_notify", _id_237EA2FB76BEA663.timestamp);

    if(_id_237EA2FB76BEA663._id_D7198CEB7D51DB5B)
      self setclientomnvar("damage_feedback_kill", 1);
    else
      self setclientomnvar("damage_feedback_kill", 0);

    if(_id_237EA2FB76BEA663.headshot)
      self setclientomnvar("damage_feedback_headshot", 1);
    else
      self setclientomnvar("damage_feedback_headshot", 0);

    if(_id_237EA2FB76BEA663._id_C4F1516C772B1C2D)
      self setclientomnvar("damage_feedback_nonplayer", 1);
    else
      self setclientomnvar("damage_feedback_nonplayer", 0);

    if(_id_237EA2FB76BEA663._id_1A3325FBF315EEE7 > -1) {
      self setclientomnvar("damage_feedback_entity", _id_237EA2FB76BEA663._id_1A3325FBF315EEE7);
      self setclientomnvar("damage_feedback_entity_notify", gettime());
    }
  }
}