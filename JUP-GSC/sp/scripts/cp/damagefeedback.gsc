/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\damagefeedback.gsc
***********************************************/

#using scripts\cp\damage;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace damagefeedback;

function init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["hitequip"] = 30;
}

function gethitmarkerpriority(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}

function hudicontype(typehit) {
  nosound = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    nosound = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  switch (typehit) {
    case #"hash_1d28d8c7a5e03548":
    case #"hash_2ab98cab4066a74e":
    case #"hash_5c57b61aa79410db":
    case #"hash_b8d1ac6e6b8e3230":
    case #"hash_d6a7d182fd397b0a":
      if(!nosound) {
        self playlocalsound("scavenger_pack_pickup");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_d5a97a795c2da79a":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_1041aa27487b00f8":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
  }
}

function function_4e514dcd8e549d1(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, var_708152dedbc0117) {
  process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, undefined, undefined, shitloc, undefined, victim);
}

function process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  var_168973eaf883aea1 = isDefined(eattacker) && isDefined(eattacker.classname) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");
  damager = undefined;

  if(var_168973eaf883aea1 && isDefined(eattacker.gunner)) {
    damager = eattacker.gunner;
  } else if(isDefined(eattacker) && isDefined(eattacker.owner)) {
    damager = eattacker.owner;
  } else {
    damager = eattacker;
  }

  isbulletdamage = isbulletdamage(smeansofdeath);

  if(isDefined(sweapon)) {
    typehit = ter_op(isbulletdamage && isprimaryweapon(sweapon), "standardspread", "standard");
  } else {
    typehit = "standard";
  }

  var_59ad6a29257c9f49 = 0;

  if(isDefined(damager) && damager != victim && (!isDefined(shitloc) || shitloc != "shield")) {
    waskilled = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent(victim) && idamage >= victim.health;

    if(isDefined(victim.var_689d46e1e37cc5ad)) {
      waskilled = [[victim.var_689d46e1e37cc5ad]](idamage);
    }

    isspreadweapon = 0;

    if(isDefined(sweapon)) {
      weapclass = weaponclass(sweapon);
      isspreadweapon = weapclass == "spread";
    }

    headshot = !isspreadweapon && isheadshot(sweapon, shitloc, smeansofdeath, eattacker);

    if(istrue(victim scripts\cp\spawning::is_specified_unittype("juggernaut"))) {
      typehit = "hitarmorheavy";
    } else if(idflags & 16) {
      typehit = "stun";
    } else if(istacticaldamage(sweapon, smeansofdeath) && victim _hasperk("specialty_stun_resistance")) {
      typehit = "hittacresist";
    } else if(isexplosivedamagemod(smeansofdeath) && victim _hasperk("specialty_blastshield") && !damage_should_ignore_blast_shield(eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc)) {
      typehit = "hitblastshield";
    } else if(!var_59ad6a29257c9f49 && scripts\cp\spawning::is_armored()) {
      if(istrue(headshot)) {
        if(isDefined(self.helmethealth) && self.helmethealth > 0) {
          typehit = "hithelmetheavy";
        } else if(!istrue(self.helmet_broken) && isPlayer(damager)) {
          typehit = "hithelmetheavybreak";
          self.helmet_broken = 1;
        }
      } else if(isDefined(self.armorhealth) && self.armorhealth > 0) {
        typehit = "hitarmorheavy";
      } else if(!istrue(self.armor_broken) && isPlayer(damager)) {
        typehit = "hitarmorheavybreak";
        self.armor_broken = 1;
      }
    } else if(victim _hasperk("specialty_pistoldeath") && istrue(victim.inlaststand) && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      typehit = "hitlaststand";
    }

    if(isDefined(victim.focus_fire_attackers) && victim.focus_fire_attackers.size > 1) {
      typehit = "cp_relic_buff";
    }

    allowdamagefeedback = 1;
    suppressaudio = smeansofdeath == "MOD_MELEE";
    timestring = "" + gettime();

    if(!suppressaudio && isspreadweapon && isDefined(damager.pelletdmg) && isDefined(damager.pelletdmg[timestring]) && isDefined(damager.pelletdmg[timestring][victim.guid]) && damager.pelletdmg[timestring][victim.guid] > 1) {
      if(waskilled) {
        suppressaudio = 1;
      } else {
        allowdamagefeedback = 0;
      }
    }

    killingblow = undefined;

    if(victim.health <= idamage) {
      killingblow = 1;
    }

    headshot = isheadshot(sweapon, shitloc, smeansofdeath, eattacker);

    if(istrue(self.var_61bfafe53cf69323)) {
      allowdamagefeedback = 0;
    }

    if(allowdamagefeedback) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner)) {
          eattacker.owner thread updatedamagefeedback(typehit, killingblow, idamage, headshot, 0, eattacker, einflictor, eattacker, 0);
          return;
        }

        eattacker thread updatedamagefeedback(typehit, killingblow, idamage, headshot, 0, eattacker, einflictor, eattacker, 0);
      }
    }
  }
}

function updatedamagefeedback(hitmarkertype, killingblow, damage, headshot, armorhit, agent, inflictor, attacker, suppressaudio) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](agent, inflictor, attacker)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(hitmarkertype)) {
    hitmarkertype = "standard";
  }

  if(getdvarint(@ "hash_553350ce7343ff76", 0) == 1) {
    suppressaudio = 1;
  }

  if(!isDefined(suppressaudio)) {
    suppressaudio = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !suppressaudio) {
    if(!isDefined(self.hitmarkeraudioevents)) {
      self.hitmarkeraudioevents = 0;
    }

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  if(getdvarint(@ "scr_nohitmarker", 1) != 0 && hitmarkertype != "hittrophysystem" && hitmarkertype != "hitveharmor" && hitmarkertype != "hitvehstandard" && hitmarkertype != "hitveharmorbreak" && hitmarkertype != "hitarmorheavy" && hitmarkertype != "hitarmorheavybreak" && hitmarkertype != "hitarmorlightbreak" && hitmarkertype != "hithelmetlightbreak" && hitmarkertype != "hithelmetheavybreak" && hitmarkertype != "hitvehcritical" && hitmarkertype != "hitnobulletdamage" && hitmarkertype != "hitlaststand_stimpistol" && hitmarkertype != "hitjuggernaut" && hitmarkertype != "hitjuggernautrecon") {
    return;
  }

  switch (hitmarkertype) {
    case #"hash_db653a4972b3c13b":
      break;
    case #"hash_83eadc5c16357f57":
    case #"hash_856ee6fdc18a0b94":
      hitmarkertype = "standard";
      headshot = 1;
      break;
    case #"hash_61959c2fc4a90fd4":
      hitmarkertype = "standard";
      headshot = 0;
    case #"hash_18392ddb8b61cb4":
    case #"hash_21506e0eab793b6d":
    case #"hash_251e2c7ad46ab2a1":
    case #"hash_286b270eeb92acab":
    case #"hash_2fc100f2b74f0620":
    case #"hash_350f19f266bbb791":
    case #"hash_3c687341f7275bb2":
    case #"hash_3dfff68d08667b7e":
    case #"hash_4bdab969a8904cac":
    case #"hash_5b770c686e85a82a":
    case #"hash_6145e54d4160575d":
    case #"hash_635a3ba72a0e2577":
    case #"hash_645b9186bb9ba5b1":
    case #"hash_7bee0512ecd80819":
    case #"hash_93712eceeb1ff510":
    case #"hash_a1c8ae5eec4e0bc2":
    case #"hash_a54ca25c946c6e33":
    case #"hash_ab41a90fc8743bb8":
    case #"hash_c1715405ce8d27ea":
    case #"hash_c58cc85ba9fb86d4":
    case #"hash_cbc78f7c7ad72ad1":
    case #"hash_ee12fcbe8afdf751":
      if(!istrue(killingblow)) {
        self setclientomnvar("damage_feedback_icon", hitmarkertype);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      }

      break;
    default:
      break;
  }

  updatehitmarker(hitmarkertype, headshot, damage, armorhit, killingblow, 0);
}

function updatehitmarker(markertype, headshot, damage, armorhit, killingblow, nonplayer) {
  if(scripts\cp_mp\damagefeedback::function_fa167eb35ec0eeea()) {
    return;
  }

  if(!isDefined(markertype)) {
    return;
  }

  if(markertype == "") {
    markertype = "standard";
  }

  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(!isDefined(armorhit)) {
    armorhit = 0;
  }

  if(!isDefined(nonplayer)) {
    nonplayer = 0;
  }

  if(!isPlayer(self)) {
    if(isDefined(self.owner) && isPlayer(self.owner)) {
      return;
    }
  }

  priority = gethitmarkerpriority(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;
  self setclientomnvar("damage_feedback", markertype);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(killingblow) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(headshot) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(nonplayer) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function function_cb98b2b16c183664(vehicle, damagedata) {
  if(!isDefined(damagedata) || !isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }

  damagedata.attacker updatedamagefeedback("hitveharmor");
}

function function_974320dd370c5572(vehicle, damagedata) {
  if(!isDefined(damagedata) || !isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }

  if(isDefined(damagedata.attacker) && isPlayer(damagedata.attacker)) {
    damagedata.attacker thread updatedamagefeedback("hitveharmorbreak");
  }

  if(isDefined(self.aidriver)) {
    level notify("armorplate_broken", damagedata.attacker);
  }

  if(scripts\engine\utility::issharedfuncdefined("veh9_techo_rebel_armor", "launchArmorPlate")) {
    [[getsharedfunc("veh9_techo_rebel_armor", "launchArmorPlate")]](damagedata);
  }
}