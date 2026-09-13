/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_damagefeedback.gsc
***********************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["hitequip"] = 30;
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
    case "throwingknife":
    case "crossbowbolt":
    case "scavenger":
    case "br_ammo":
    case "ammobox":
      if(!_id_B53415265B603895)
        self playlocalsound("scavenger_pack_pickup");

      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "eqp_ping":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
    case "suppression":
      self setclientomnvar("damage_feedback_other", _id_CDCEDB142F61B43E);
      break;
  }
}

process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  _id_168973EAF883AEA1 = isDefined(eattacker) && isDefined(eattacker.classname) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");
  _id_91EBB035A259E76A = undefined;

  if(_id_168973EAF883AEA1 && isDefined(eattacker.gunner))
    _id_91EBB035A259E76A = eattacker.gunner;
  else if(isDefined(eattacker) && isDefined(eattacker.owner))
    _id_91EBB035A259E76A = eattacker.owner;
  else
    _id_91EBB035A259E76A = eattacker;

  isbulletdamage = scripts\engine\utility::isbulletdamage(smeansofdeath);

  if(isDefined(sweapon))
    _id_CDCEDB142F61B43E = scripts\engine\utility::ter_op(isbulletdamage && _id_74502A9E0EF1F19C::isprimaryweapon(sweapon), "standardspread", "standard");
  else
    _id_CDCEDB142F61B43E = "standard";

  _id_59AD6A29257C9F49 = 0;

  if(isDefined(eattacker) && isDefined(eattacker.class) && eattacker.class == "engineer") {
    if(isDefined(smeansofdeath) && scripts\engine\utility::isbulletdamage(smeansofdeath))
      _id_59AD6A29257C9F49 = 1;
  }

  if(isDefined(_id_91EBB035A259E76A) && _id_91EBB035A259E76A != victim && idamage > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    _id_4FFE32F42D51A763 = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent(victim) && idamage >= victim.health;

    if(isDefined(victim._id_689D46E1E37CC5AD))
      _id_4FFE32F42D51A763 = [[victim._id_689D46E1E37CC5AD]](idamage);

    if(istrue(victim _id_18A73A64992DD07D::is_specified_unittype("juggernaut")))
      _id_CDCEDB142F61B43E = "hitjuggernaut";
    else if(idflags &level.idflags_stun)
      _id_CDCEDB142F61B43E = "stun";
    else if(_id_25845ACA699D038D::istacticaldamage(sweapon, smeansofdeath) && victim scripts\cp\utility::_hasperk("specialty_stun_resistance"))
      _id_CDCEDB142F61B43E = "hittacresist";
    else if(isexplosivedamagemod(smeansofdeath) && victim scripts\cp\utility::_hasperk("specialty_blastshield") && !_id_25845ACA699D038D::damage_should_ignore_blast_shield(eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc))
      _id_CDCEDB142F61B43E = "hitblastshield";
    else if(!_id_59AD6A29257C9F49 && _id_18A73A64992DD07D::is_armored()) {
      if(isDefined(self._id_B5218CF00DAD94EF) && self._id_B5218CF00DAD94EF > 0)
        _id_CDCEDB142F61B43E = "hitarmorheavy";
      else if(!istrue(self._id_E6684EA936B29680) && isPlayer(_id_91EBB035A259E76A)) {
        _id_CDCEDB142F61B43E = "hitarmorheavybreak";
        self._id_E6684EA936B29680 = 1;
        _id_91EBB035A259E76A playsoundtoplayer("hit_marker_armor_break_plr", _id_91EBB035A259E76A);
      }
    } else if(victim scripts\cp\utility::_hasperk("specialty_pistoldeath") && isDefined(victim.inlaststand) && victim.inlaststand == 1 && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      _id_CDCEDB142F61B43E = "hitlaststand";
    }

    if(isDefined(victim.focus_fire_attackers) && victim.focus_fire_attackers.size > 1)
      _id_CDCEDB142F61B43E = "cp_relic_buff";

    _id_B98146816886D3C4 = "standard";
    isspreadweapon = 0;

    if(isDefined(sweapon)) {
      _id_0DD6BF5F9DBA888C = weaponclass(sweapon);
      isspreadweapon = _id_0DD6BF5F9DBA888C == "spread";
    }

    headshot = !isspreadweapon && scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, eattacker);
    _id_14B8F2EEBA6A3E78 = 1;
    _id_62CF84636D4CEF2C = smeansofdeath == "MOD_MELEE";
    _id_748DFD5F88E890D1 = "" + gettime();

    if(!_id_62CF84636D4CEF2C && isspreadweapon && isDefined(_id_91EBB035A259E76A.pelletdmg) && isDefined(_id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1]) && isDefined(_id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1][victim.guid]) && _id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1][victim.guid] > 1) {
      if(_id_4FFE32F42D51A763)
        _id_62CF84636D4CEF2C = 1;
      else
        _id_14B8F2EEBA6A3E78 = 0;
    }

    _id_D7198CEB7D51DB5B = undefined;

    if(victim.health <= idamage)
      _id_D7198CEB7D51DB5B = 1;

    headshot = scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, eattacker);

    if(_id_14B8F2EEBA6A3E78) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner))
          eattacker.owner thread updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, idamage, headshot, 0, eattacker, einflictor, eattacker, 0);
        else
          eattacker thread updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, idamage, headshot, 0, eattacker, einflictor, eattacker, 0);
      }
    }
  }
}

updatedamagefeedback(_id_B98146816886D3C4, _id_D7198CEB7D51DB5B, damage, headshot, _id_B2883531AFA6B83D, agent, inflictor, attacker, _id_62CF84636D4CEF2C) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](agent, inflictor, attacker)) {
    return;
  }
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

  if(getdvarint("scr_nohitmarker", 1) != 0 && _id_B98146816886D3C4 != "hittrophysystem" && _id_B98146816886D3C4 != "hitveharmor" && _id_B98146816886D3C4 != "hitveharmorbreak") {
    return;
  }
  switch (_id_B98146816886D3C4) {
    case "none":
      break;
    case "hitcritical":
      _id_B98146816886D3C4 = "standard";
      headshot = 1;
      break;
    case "hitveharmor":
    case "hithelmetlight":
    case "hithelmetlightbreak":
    case "hitjuggernaut":
    case "hithelmetheavy":
    case "hitspawnprotect":
    case "hitarmorlight":
    case "hitnooutline":
    case "hitlaststand":
    case "hitarmorlightbreak":
    case "hitarmorheavybreak":
    case "hitequip":
    case "hittrophysystem":
    case "hitblastshield":
    case "hitadrenaline":
    case "hitarmorheavy":
    case "hitveharmorbreak":
    case "hittacresist":
    case "hithelmetheavybreak":
      if(!istrue(_id_D7198CEB7D51DB5B)) {
        self setclientomnvar("damage_feedback_icon", _id_B98146816886D3C4);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      }

      break;
    default:
      break;
  }

  updatehitmarker(_id_B98146816886D3C4, headshot, damage, _id_B2883531AFA6B83D, _id_D7198CEB7D51DB5B, 0);
}

updatehitmarker(_id_E0EA2C8DF06F13EB, headshot, damage, _id_B2883531AFA6B83D, _id_D7198CEB7D51DB5B, _id_C4F1516C772B1C2D) {
  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(_id_E0EA2C8DF06F13EB == "")
    _id_E0EA2C8DF06F13EB = "standard";

  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(!isDefined(_id_D7198CEB7D51DB5B))
    _id_D7198CEB7D51DB5B = 0;

  if(!isDefined(headshot))
    headshot = 0;

  if(!isDefined(_id_B2883531AFA6B83D))
    _id_B2883531AFA6B83D = 0;

  if(!isDefined(_id_C4F1516C772B1C2D))
    _id_C4F1516C772B1C2D = 0;

  if(!isPlayer(self)) {
    if(isDefined(self.owner) && isPlayer(self.owner))
      return;
  }

  priority = gethitmarkerpriority(_id_E0EA2C8DF06F13EB);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !_id_D7198CEB7D51DB5B) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;
  self setclientomnvar("damage_feedback", _id_E0EA2C8DF06F13EB);
  self setclientomnvar("damage_feedback_notify", gettime());

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
}

_id_CB98B2B16C183664(vehicle, damagedata) {
  if(!isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }
  damagedata.attacker updatedamagefeedback("hitveharmor");
}

_id_974320DD370C5572(vehicle, damagedata) {
  if(!isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }
  if(isDefined(damagedata.attacker) && isPlayer(damagedata.attacker))
    damagedata.attacker thread updatedamagefeedback("hitveharmorbreak");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "launchArmorPlate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "launchArmorPlate")]](damagedata);
}