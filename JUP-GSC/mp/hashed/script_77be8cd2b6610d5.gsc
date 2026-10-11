/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_77be8cd2b6610d5.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_554830d27078277d;
#using script_58682e6578ce0515;
#using script_5a4a5d9ba343ff8f;
#using script_686729055b66c6e4;
#using script_73926eaf280b0b75;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\dragonsbreath;
#using scripts\engine\utility;
#namespace zombie_damage;

function autoexec init() {
  utility::registersharedfunc("zombie_damage", "buildDamageStruct", &function_4361b33933cb779d);
  utility::registersharedfunc("zombie_damage", "shouldSkipDamage", &function_b8fd1823ea584538);
  utility::registersharedfunc("zombie_damage", "checkDamagedArmor", &function_6b8e5b333b2b3e43);
  utility::registersharedfunc("zombie_damage", "checkArmorHitmarker", &function_5c8a92a87ae9751b);
  utility::registersharedfunc("zombie_damage", "checkArmorBreakHitmarker", &function_45500125495e46a6);
  utility::registersharedfunc("zombie_damage", "adjustDamageExposedHead", &function_63e1cb89f73d0ad8);
  utility::registersharedfunc("zombie_damage", "adjustDamageArmor", &function_10a52a9d2dcaf262);
  utility::registersharedfunc("zombie_damage", "adjustDamageUnderbarrel", &function_942afcb4f4e24091);
  utility::registersharedfunc("zombie_damage", "adjustDamageRarity", &function_89cc24cfc33e2693);
  utility::registersharedfunc("zombie_damage", "adjustDamageSpecific", &function_ba2823ac0204930c);
  utility::registersharedfunc("zombie_damage", "adjustDamageMercs", &function_f9c444fcf6bb992b);
  utility::registersharedfunc("zombie_damage", "adjustDamageKillCallbacks", &function_4948d7eacb9f12be);
  utility::registersharedfunc("zombie_damage", "damageMetabone", &function_71a411d4b5466318);
}

function function_4361b33933cb779d(params) {
  return function_34e78cbd2dfff6df(params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.sweapon, params.vpoint, params.vdir, params.shitloc, params.timeoffset, params.modelindex, params.partname, params.objweapon);
}

function function_34e78cbd2dfff6df(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  dmg_struct = spawnStruct();
  dmg_struct.einflictor = einflictor;
  dmg_struct.eattacker = eattacker;
  dmg_struct.idamage = idamage;
  dmg_struct.idflags = idflags;
  dmg_struct.smeansofdeath = smeansofdeath;
  dmg_struct.sweapon = sweapon;
  dmg_struct.vpoint = vpoint;
  dmg_struct.vdir = vdir;
  dmg_struct.shitloc = shitloc;
  dmg_struct.timeoffset = timeoffset;
  dmg_struct.modelindex = modelindex;
  dmg_struct.partname = partname;
  dmg_struct.objweapon = objweapon;
  dmg_struct.biscritical = 0;
  dmg_struct.var_feef4b237a6beb07 = 0;
  dmg_struct.damagemaxhealthcap = 1;

  if(function_df9189c2ea1a100d()) {
    dmg_struct.metabonename = function_e3bec440b7001e99(dmg_struct);
  } else {
    dmg_struct.metabonename = function_ae12b32b13b42c5e(shitloc, vdir);

    if(!isDefined(dmg_struct.metabonename)) {
      dmg_struct.metabonename = function_b8f2b0917b1d3c98(vpoint, vdir);
    }
  }

  return dmg_struct;
}

function function_b8fd1823ea584538(eattacker, objweapon, smeansofdeath) {
  if(isPlayer(eattacker) && is_equal(self.team, eattacker.team)) {
    return true;
  }

  if(is_equal(eattacker, self) && namespace_c56b0b75fd51eab1::function_8ce7894f1a52fb77("charm")) {
    return true;
  }

  var_225a577cbeda65c2 = getweaponrootstring(objweapon);

  if(ent_flag("deadwire_stunned") && smeansofdeath == "MOD_ELEMENTAL_ELEC") {
    hasammomod = istrue(level.var_bfa98c9dd6edb929) && eattacker function_2e380dedfcfc7972(objweapon);

    if(istrue(hasammomod) && eattacker function_87b7af080857567f(objweapon) == "deadwire") {
      return false;
    }
  } else if(ent_flag("deadwire_stunned") && isDefined(self.aicategory) && self.aicategory == "normal") {
    return true;
  }

  if(istrue(self.var_7878d9a79c788c74)) {
    if(isDefined(eattacker)) {
      eattacker updatedamagefeedback_sharedfunc("hitimmune");
    }

    return true;
  }

  return false;
}

function function_6a3d1a2884883a23(dmg_struct) {
  weaponelementtype = get_element(dmg_struct.objweapon, dmg_struct.eattacker, dmg_struct.smeansofdeath);
  statuseffecttype = function_81366c086142dab6(dmg_struct.objweapon);
  statuseffectonimpact = function_f05759f95f2503d1(dmg_struct.objweapon);
  meansofdeath = dmg_struct.smeansofdeath;

  if(meansofdeath == "MOD_IMPACT" && !statuseffectonimpact) {
    return weaponelementtype;
  }

  if(isDefined(statuseffecttype) && statuseffecttype != "none") {
    duration = function_a4facc27c3c73647(dmg_struct.objweapon);
    damage_percent = function_7ee15220af294a5c(dmg_struct.objweapon);
    tick = function_32b17fc3eff81e0a(dmg_struct.objweapon);

    switch (statuseffecttype) {
      case #"hash_23f2c68a2fc41281":
        stun_ai(duration);
        break;
      case #"hash_e8f0758a10ec7618":
        slow("weapon", tick, duration, dmg_struct.eattacker);
        break;
      case #"hash_185c93a22da79530":
        charm(duration, dmg_struct.eattacker);
        break;
      case #"hash_ab2e692ee80521f8":
        if(isDefined(dmg_struct.objweapon) && scripts\cp_mp\dragonsbreath::isdragonsbreathweapon(dmg_struct.objweapon) && getdvarint(@ "hash_666ee7d4e70b4c1c", 0) && meansofdeath != "MOD_UNKNOWN") {
          duration = getdvarint(@ "hash_e43390f73e10b90c", 0);
          damage_percent = 0.2;
          tick = getdvarint(@ "hash_6236ca9688ad6f2a", 0);

          if(isPlayer(dmg_struct.eattacker)) {
            incendiary_rounds = 1;
            rarity = dmg_struct.eattacker get_rarity(dmg_struct.objweapon);
            weaponraritydamagemult = function_d64f648b8a57d3d8(dmg_struct.objweapon, dmg_struct.smeansofdeath, rarity);
            idamage = dmg_struct.idamage * weaponraritydamagemult;
            weaponpackdamagemult = function_b64d15c2d1631d7d(dmg_struct.objweapon, dmg_struct.smeansofdeath, dmg_struct.eattacker);
            idamage *= weaponpackdamagemult;
          }
        }

        burn(duration, damage_percent, tick, dmg_struct.eattacker, undefined, undefined, dmg_struct.einflictor, incendiary_rounds, idamage);
        break;
    }
  }

  return weaponelementtype;
}

function get_element(objweapon, eattacker, smeansofdeath) {
  element = "none";
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;

  if(isPlayer(eattacker) && istrue(level.var_bfa98c9dd6edb929) && eattacker function_2e380dedfcfc7972(objweapon)) {
    ammomod_name = eattacker function_87b7af080857567f(objweapon);

    if(isDefined(level.ammo_mods[ammomod_name].element)) {
      element = level.ammo_mods[ammomod_name].element;
    }
  } else {
    weaponbundle = undefined;

    if(isDefined(level.weaponmetadata)) {
      weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
    }

    if(isDefined(weaponbundle) && isDefined(weaponbundle.elementdamagetype)) {
      element = weaponbundle.elementdamagetype;
    }
  }

  if(isDefined(smeansofdeath)) {
    if(smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_ELEMENTAL_FIRE") {
      element = "fire";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_ELEC") {
      element = "electrical";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_COLD") {
      element = "cold";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_TOXIC") {
      element = "toxic";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_DARK") {
      element = "dark";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_LIGHT") {
      element = "light";
    }

    if(getdvarint(@ "hash_666ee7d4e70b4c1c", 0) && (isDefined(objweapon.modifier) && (issubstr(objweapon.modifier, "_db_") || isendstr(objweapon.modifier, "_db")) || isDefined(objweapon.underbarrel) && issubstr(objweapon.underbarrel, "ub_flame") && istrue(objweapon.isalternate)) && smeansofdeath != "MOD_UNKNOWN") {
      element = "fire";
    }
  }

  return element;
}

function function_f05759f95f2503d1(objweapon) {
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  weaponbundle = undefined;

  if(isDefined(level.weaponmetadata)) {
    weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
  }

  if(isDefined(weaponbundle) && istrue(weaponbundle.statuseffectonimpact)) {
    return true;
  }

  return false;
}

function function_81366c086142dab6(objweapon) {
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  weaponbundle = undefined;

  if(isDefined(level.weaponmetadata)) {
    weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
  }

  effect = "none";

  if(isDefined(weaponbundle) && isDefined(weaponbundle.statuseffecttype)) {
    effect = weaponbundle.statuseffecttype;
  }

  if(getdvarint(@ "hash_666ee7d4e70b4c1c", 0) && isDefined(objweapon.modifier) && (issubstr(objweapon.modifier, "_db_") || isendstr(objweapon.modifier, "_db")) || isDefined(objweapon.underbarrel) && issubstr(objweapon.underbarrel, "ub_flame") && istrue(objweapon.isalternate)) {
    effect = "burn";
  }

  return effect;
}

function function_a4facc27c3c73647(objweapon) {
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
  duration = 0;

  if(isDefined(weaponbundle) && isDefined(weaponbundle.statuseffectduration)) {
    duration = weaponbundle.statuseffectduration;
  }

  return duration;
}

function function_7ee15220af294a5c(objweapon) {
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
  damage_percent = 0;

  if(isDefined(weaponbundle) && isDefined(weaponbundle.statuseffectdamage)) {
    damage_percent = weaponbundle.statuseffectdamage;
  }

  return damage_percent;
}

function function_32b17fc3eff81e0a(objweapon) {
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
  tick = 0;

  if(isDefined(weaponbundle) && isDefined(weaponbundle.statuseffecttick)) {
    tick = weaponbundle.statuseffecttick;
  }

  return tick;
}

function function_b5af5dd435f7f00a(dmg_struct) {
  if(isDefined(dmg_struct.eattacker) && isDefined(dmg_struct.eattacker.var_dec41e66d2f7fffd)) {
    return dmg_struct.eattacker.var_dec41e66d2f7fffd;
  }

  return dmg_struct.idamage;
}

function function_73d296636c5ca3c6(dmg_struct) {
  if(isDefined(self.elementalweakness) && isarray(self.elementalweakness) && istrue(self.elementalweakness[dmg_struct.weaponelementtype])) {
    return (dmg_struct.idamage * 1.5);
  }

  return dmg_struct.idamage;
}

function function_f9c444fcf6bb992b(dmg_struct) {
  agent = dmg_struct.eattacker;
  isheadshot = dmg_struct.smeansofdeath == "MOD_HEAD_SHOT";

  if(isDefined(agent) && isagent(agent) && agent.type == "human") {
    if(isheadshot && isDefined(agent.var_e7b2da70a1256fb1)) {
      dmg_struct.idamage *= agent.var_e7b2da70a1256fb1;
    } else if(!isheadshot && isDefined(agent.tozombiedamagemult)) {
      dmg_struct.idamage *= agent.tozombiedamagemult;
    }

    if(isDefined(agent.var_46f376c7b944859b) && dmg_struct.smeansofdeath == "MOD_MELEE" && issubstr(agent.agent_type, "shielded")) {
      dmg_struct.idamage *= agent.var_46f376c7b944859b;
    } else if(isDefined(agent.var_fc8b605280dd80b0) && dmg_struct.smeansofdeath == "MOD_MELEE" && (istrue(agent.var_69b049cf4b18c73b) || issubstr(agent.agent_type, "schematic_soldier_buddy"))) {
      dmg_struct.idamage *= agent.var_fc8b605280dd80b0;
    }
  }

  return dmg_struct.idamage;
}

function function_4948d7eacb9f12be(dmg_struct) {
  adjusteddamage = dmg_struct.idamage;
  assert(isDefined(adjusteddamage));

  if(isarray(level.var_36cfc021447f6d92)) {
    for(func_index = 0; func_index < level.var_36cfc021447f6d92.size; func_index++) {
      func = level.var_36cfc021447f6d92[func_index];
      new_damage = self[[func]](dmg_struct);
      assert(isDefined(new_damage));

      if(isDefined(new_damage) && new_damage != -1) {
        dmg_struct.idamage = new_damage;
        adjusteddamage = new_damage;
      }
    }
  }

  if(isarray(self.var_36cfc021447f6d92)) {
    for(func_index = 0; func_index < self.var_36cfc021447f6d92.size; func_index++) {
      func = self.var_36cfc021447f6d92[func_index];
      new_damage = self[[func]](dmg_struct);
      assert(isDefined(new_damage));

      if(isDefined(new_damage) && new_damage != -1) {
        dmg_struct.idamage = new_damage;
        adjusteddamage = new_damage;
      }
    }
  }

  if(isDefined(dmg_struct.sweapon)) {
    weapon_basename = dmg_struct.sweapon.basename;

    if(isarray(level.var_ccb94c2ea5886365)) {
      func = level.var_ccb94c2ea5886365[weapon_basename];

      if(isDefined(func)) {
        new_damage = self[[func]](dmg_struct);

        if(new_damage != -1) {
          dmg_struct.idamage = new_damage;
          adjusteddamage = new_damage;
        }
      }
    }

    if(isarray(self.var_ccb94c2ea5886365)) {
      func = self.var_ccb94c2ea5886365[weapon_basename];

      if(isDefined(func)) {
        new_damage = self[[func]](dmg_struct);

        if(new_damage != -1) {
          dmg_struct.idamage = new_damage;
          adjusteddamage = new_damage;
        }
      }
    }
  }

  if(dmg_struct.damagemaxhealthcap >= 0 && dmg_struct.damagemaxhealthcap < 1 && isDefined(self.maxhealth)) {
    adjusteddamage = min(adjusteddamage, dmg_struct.damagemaxhealthcap * self.maxhealth);
  }

  return adjusteddamage;
}

function function_71a411d4b5466318(dmg_struct) {
  if(isDefined(dmg_struct.metabonename)) {
    b_destroyed = damage_metabone(dmg_struct.metabonename, dmg_struct.idamage, dmg_struct.eattacker, dmg_struct.einflictor);

    if(istrue(dmg_struct.var_feef4b237a6beb07) && isDefined(self.modifiedidflags)) {
      self.modifiedidflags |= 512;

      if(b_destroyed) {
        self.modifiedidflags |= 1024;
      }
    }
  }
}

function function_89cc24cfc33e2693(dmg_struct) {
  if(dmg_struct.idflags != 65536) {
    if(isPlayer(dmg_struct.eattacker)) {
      rarity = dmg_struct.eattacker get_rarity(dmg_struct.objweapon);
      weaponraritydamagemult = function_d64f648b8a57d3d8(dmg_struct.objweapon, dmg_struct.smeansofdeath, rarity);
      dmg_struct.idamage *= weaponraritydamagemult;
    }

    weaponpackdamagemult = function_b64d15c2d1631d7d(dmg_struct.objweapon, dmg_struct.smeansofdeath, dmg_struct.eattacker);
    dmg_struct.idamage *= weaponpackdamagemult;
    dmg_struct.idamage = function_afc5ebe1299256f5(dmg_struct);
  }

  return dmg_struct.idamage;
}

function get_rarity(objweapon) {
  returnrarity = "white";
  rarity_weapon = getplayerweaponraritysharedfunc(objweapon);

  if(isDefined(rarity_weapon)) {
    switch (rarity_weapon) {
      case 0:
        returnrarity = "white";
        break;
      case 1:
        returnrarity = "green";
        break;
      case 2:
        returnrarity = "blue";
        break;
      case 3:
        returnrarity = "purple";
        break;
      case 4:
        returnrarity = "orange";
        break;
    }
  }

  return returnrarity;
}

function function_d64f648b8a57d3d8(objweapon, smeansofdeath, rarity) {
  if(is_equal(smeansofdeath, "MOD_MELEE") && !istrue(objweapon.ismelee) && objweapon.basename != "jup_jp23_me_spear_mp") {
    return 1;
  }

  damagemult = 1;

  if(isDefined(level.weaponmetadata)) {
    switch (rarity) {
      case #"hash_1393412d7401c646":
      default:
        damagemult = default_to(level.weaponmetadata["rarity_settings"].var_64962e0b6ed91567, 1);
        break;
      case #"hash_883ff07272b4f9c":
        damagemult = default_to(level.weaponmetadata["rarity_settings"].var_3fc24ec0bc2de11d, 1.25);
        break;
      case #"hash_778bb52ecd08072d":
        damagemult = default_to(level.weaponmetadata["rarity_settings"].var_52dff081b694390, 1.5);
        break;
      case #"hash_598a30e44f53045f":
        damagemult = default_to(level.weaponmetadata["rarity_settings"].var_2f4f5451344c144a, 1.75);
        break;
      case #"hash_35bb3bd014c77f4b":
        damagemult = default_to(level.weaponmetadata["rarity_settings"].var_827b0c41035f0386, 2);
        break;
    }
  }

  return damagemult;
}

function function_171e93b007d03bb(n_pap_level) {
  var_92e4946901e59d8b = 1;

  if(isDefined(n_pap_level)) {
    switch (n_pap_level) {
      case 1:
        var_92e4946901e59d8b = default_to(level.weaponmetadata["pap_settings"].var_e007ac5715f424ab, 2);
        break;
      case 2:
        var_92e4946901e59d8b = default_to(level.weaponmetadata["pap_settings"].var_ac1ba74bafe62262, 2.5);
        break;
      case 3:
        var_92e4946901e59d8b = default_to(level.weaponmetadata["pap_settings"].var_a887a8da61532b15, 3);
        break;
    }
  }

  return var_92e4946901e59d8b;
}

function function_677bbb1eccf8453e(objweapon, n_pap_level) {
  str_weapon_name = objweapon.var_9d7facbe889e667c;
  var_23c59677f17fdaee = undefined;

  if(isDefined(level.weaponmetadata) && isDefined(level.weaponmetadata[str_weapon_name])) {
    switch (n_pap_level) {
      case 1:
        var_23c59677f17fdaee = level.weaponmetadata[str_weapon_name].var_f963f9dc56b73e5f;
        break;
      case 2:
        var_23c59677f17fdaee = level.weaponmetadata[str_weapon_name].var_281e913b539232ce;
        break;
      case 3:
        var_23c59677f17fdaee = level.weaponmetadata[str_weapon_name].var_7b6d8829dc9c7ed;
        break;
    }
  }

  return var_23c59677f17fdaee;
}

function function_b64d15c2d1631d7d(objweapon, smeansofdeath, player) {
  if(!isPlayer(player)) {
    return 1;
  }

  if(is_equal(smeansofdeath, "MOD_MELEE") && !istrue(objweapon.ismelee) && objweapon.basename != "jup_jp23_me_spear_mp") {
    return 1;
  }

  var_882887bafd21e4e = 1;
  n_pap_level = undefined;

  if(issharedfuncdefined("zombie", "get_pap_level")) {
    n_pap_level = player function_af5127390d3221e9(objweapon);
  }

  var_c54733cd1868d127 = function_677bbb1eccf8453e(objweapon, n_pap_level);
  var_d202cc37087c21f2 = function_171e93b007d03bb(n_pap_level);

  if(isDefined(n_pap_level)) {
    if(isDefined(var_c54733cd1868d127)) {
      var_882887bafd21e4e = var_c54733cd1868d127;
    } else {
      var_882887bafd21e4e = var_d202cc37087c21f2;
    }
  }

  return var_882887bafd21e4e;
}

function private function_e825787a429abdb3(weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }

  var_768d659419360f70 = weapon.var_9d7facbe889e667c;

  if(!isDefined(var_768d659419360f70)) {
    return 0;
  }

  if(isDefined(level.weaponmetadata)) {
    metadata = level.weaponmetadata[var_768d659419360f70];

    if(isDefined(metadata) && isDefined(metadata.var_16740eb88c3c21fa)) {
      return metadata.var_16740eb88c3c21fa;
    }
  }

  return 0;
}

function private function_afc5ebe1299256f5(dmg_struct) {
  if(!isPlayer(dmg_struct.eattacker) || dmg_struct.smeansofdeath == "MOD_MELEE" || function_e825787a429abdb3(dmg_struct.objweapon)) {
    return dmg_struct.idamage;
  }

  if(isDefined(dmg_struct.metabonename)) {
    weakspot_data = function_4b44008810022d21(dmg_struct.metabonename, "Types_Weakspot");

    if(isDefined(weakspot_data)) {
      if(!getdvarint(@ "hash_2cbf00f3fb539237", 1)) {
        iprintln("<dev string:x1c>" + dmg_struct.metabonename);
      }

      dmg_struct.biscritical = 1;
      additional_dmg = 0;
      var_4017a57c0bba213e = function_59957d924fbc58e0(dmg_struct.objweapon, "head", 0);

      if(isDefined(var_4017a57c0bba213e)) {
        additional_dmg += dmg_struct.idamage * (var_4017a57c0bba213e - 1);
      }

      additional_dmg += dmg_struct.idamage * default_to(weakspot_data.additionaldamagemod, 0);
      final_dmg = dmg_struct.idamage + additional_dmg;

      if(isDefined(dmg_struct.eattacker.var_ae9b30f13abd35fc)) {
        final_dmg *= dmg_struct.eattacker.var_ae9b30f13abd35fc;
      }

      return final_dmg;
    }
  }

  return dmg_struct.idamage;
}

function function_6b8e5b333b2b3e43(dmg_struct) {
  if(isPlayer(dmg_struct.eattacker) && isDefined(dmg_struct.metabonename)) {
    armor_data = function_4b44008810022d21(dmg_struct.metabonename, "Types_Armor");

    if(isDefined(armor_data)) {
      dmg_struct.var_feef4b237a6beb07 = 1;
      dmg_struct.damagearmormod = armor_data.damagemod;
    }
  }

  return dmg_struct.var_feef4b237a6beb07;
}

function function_10a52a9d2dcaf262(dmg_struct) {
  if(istrue(dmg_struct.var_feef4b237a6beb07)) {
    dmg_struct.idamage *= dmg_struct.damagearmormod;
    dmgmodifier = function_59957d924fbc58e0(dmg_struct.objweapon, dmg_struct.shitloc, 0);

    if(isDefined(dmgmodifier) && dmgmodifier != 0) {
      dmg_struct.idamage /= dmgmodifier;
    }
  }

  return dmg_struct.idamage;
}

function function_63e1cb89f73d0ad8(dmg_struct) {
  if(!istrue(dmg_struct.var_feef4b237a6beb07) && (dmg_struct.shitloc == "head" || dmg_struct.shitloc == "neck" || dmg_struct.shitloc == "helmet") && dmg_struct.smeansofdeath != "MOD_MELEE") {
    dmgmodifier = function_59957d924fbc58e0(dmg_struct.objweapon, dmg_struct.shitloc, 0);

    if(isDefined(dmgmodifier) && dmgmodifier != 0) {
      dmg_struct.idamage /= dmgmodifier;
    }
  }

  return dmg_struct.idamage;
}

function function_5c8a92a87ae9751b(eattacker, var_feef4b237a6beb07, metabonename, armor_hitmarker) {
  if(!isDefined(armor_hitmarker)) {
    armor_hitmarker = "hitarmor";
  }

  self endon("death");
  self endon("metabone_destroyed");
  msg = waittill_any_timeout_1(0.5, "metabone_damaged_not_destroyed");

  if(msg == "timeout") {
    return;
  }

  if(isPlayer(eattacker) && istrue(var_feef4b237a6beb07) && isDefined(metabonename)) {
    eattacker updatedamagefeedback_sharedfunc(armor_hitmarker);
  }
}

function function_45500125495e46a6(eattacker, var_feef4b237a6beb07, metabonename, armorbreak_hitmarker) {
  if(!isDefined(armorbreak_hitmarker)) {
    armorbreak_hitmarker = "hitarmorbreak";
  }

  self endon("death");
  msg = waittill_any_timeout_1(0.5, "metabone_destroyed");

  if(msg == "timeout") {
    return;
  }

  if(isPlayer(eattacker) && istrue(var_feef4b237a6beb07) && isDefined(metabonename)) {
    eattacker updatedamagefeedback_sharedfunc(armorbreak_hitmarker);
  }
}

function function_ba2823ac0204930c(dmg_struct) {
  if(isDefined(level.var_99a0ddbdeb40f977) && isDefined(dmg_struct.objweapon) && isDefined(dmg_struct.objweapon.basename) && isDefined(level.var_99a0ddbdeb40f977[dmg_struct.objweapon.basename])) {
    return [[level.var_99a0ddbdeb40f977[dmg_struct.objweapon.basename]]](dmg_struct);
  }

  return dmg_struct.idamage;
}

function function_bc7da5341862e4e0(dmg_struct) {
  attackent = undefined;

  if(isDefined(dmg_struct.eattacker)) {
    attackent = dmg_struct.eattacker;
  } else {
    attackent = dmg_struct.einflictor;
  }

  if(isDefined(dmg_struct.smeansofdeath)) {
    if(dmg_struct.smeansofdeath == "MOD_CRUSH") {
      if(isDefined(attackent) && attackent scripts\common\vehicle::isvehicle()) {
        if(attackent vehicle_getspeed() > 5) {
          if(self.aicategory == "normal") {
            return self.health;
          } else if(getdvarint(@ "hash_52daf1fb76b3dd86", 0) != 1) {
            regiondifficulty = "difficulty_easy";
            var_c40c7a14462edbe6 = dmg_struct.idamage * getdvarfloat(@ "hash_c0702b410287faf1", 1);

            if(isfunction(level.var_8241e0d86017df29)) {
              regiondifficulty = [[level.var_8241e0d86017df29]](attackent.origin);
            }

            switch (regiondifficulty) {
              case #"hash_af83e47edfa8900a":
                var_c40c7a14462edbe6 *= getdvarfloat(@ "hash_c07028410287f458", 2);
                break;
              case #"hash_5343b465e56ec9a4":
                var_c40c7a14462edbe6 *= getdvarfloat(@ "hash_c07029410287f68b", 5);
                break;
              case #"hash_651f76c0ad6741ec":
                var_c40c7a14462edbe6 *= getdvarfloat(@ "hash_c0702e410288018a", 10);
                break;
            }

            return var_c40c7a14462edbe6;
          }
        }
      }
    }
  }

  return dmg_struct.idamage;
}

function function_942afcb4f4e24091(dmg_struct) {
  if(!isDefined(dmg_struct.objweapon) || !dmg_struct.objweapon.isalternate) {
    return dmg_struct.idamage;
  }

  if(issharedfuncdefined("zombie", "scale_underbarrel_damage")) {
    dmg_struct.idamage = function_1ae8c41da6a042c3(dmg_struct);
  }

  return dmg_struct.idamage;
}

function function_61d03b99e3e21bc2(dmg_struct) {
  if(isDefined(self.var_2c94b75746ceabe2) && istrue(self.var_2c94b75746ceabe2)) {
    var_547fbb568b6afa7f = getdvarfloat(@ "hash_cf76ed10d29218fb", 0.002);
    var_5e9608550b282387 = self.maxhealth * var_547fbb568b6afa7f;
    var_57caea3ae479ed41 = getdvarfloat(@ "hash_a8f1209da2a64e4d", 0.6);

    if(dmg_struct.idamage > var_5e9608550b282387) {
      dmg_struct.idamage = (dmg_struct.idamage - var_5e9608550b282387) * var_57caea3ae479ed41 + var_5e9608550b282387;
    }
  }

  return dmg_struct.idamage;
}