/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_24fbedba9a7a1ef4.gsc
***********************************************/

callbacksoldieragentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self._id_A4738C70736D3A61))
    [[self._id_A4738C70736D3A61]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  else
    _id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_34672E1EE2E90CF8(objweapon, idamage) {
  if(!isDefined(objweapon))
    return idamage;

  class = weaponclass(objweapon);

  if(isDefined(class) && class == "spread") {
    _id_54F07FB8741B177D = getdvarint("dvar_877C52CAF0F9AA8C", 35);
    idamage = int(min(idamage, _id_54F07FB8741B177D));
  }

  return idamage;
}

_id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_E851FFA44B7E0D54 = self;
  _id_A95F61E7118777D1 = idamage;
  _id_64D2A3801BD9AD7E = 0;
  _id_9285B238A06E0C02 = 0;
  _id_5D59D8B177F36F36 = _id_B8C245105CC37F9E(objweapon);
  _id_69CFD14B4398C458 = idamage;

  if(_id_62213F6E7B9DA1E7(_id_E851FFA44B7E0D54, eattacker, einflictor, smeansofdeath)) {
    return;
  }
  if(!_id_84A1AEC445B03580(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
    return;
  }
  if(handleriotshielddamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
    return;
  }
  _id_379485F96865DB6D = isDefined(eattacker) && isPlayer(eattacker);
  _id_7543D4FE49C53684 = isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  _id_CCCD6F66C0CAF114 = isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  _id_FACFECFAC4909D65 = _id_CCCD6F66C0CAF114 && smeansofdeath == "MOD_CRUSH";

  if(isDefined(_id_E851FFA44B7E0D54.forcehitlocation)) {
    shitloc = _id_E851FFA44B7E0D54.forcehitlocation;
    _id_E851FFA44B7E0D54.forcehitlocation = undefined;
  }

  if(_id_FACFECFAC4909D65) {
    _id_448A418E975E9B01 = getdvarfloat("dvar_E58868D4F3626E25", 500);
    _id_6A01DAAB475B44AB = getdvarfloat("dvar_4CA14712D81D0747", 1500);

    if(isDefined(self.stealth)) {
      if(isDefined(self.stealth.override_damage_auto_range))
        _id_448A418E975E9B01 = self.stealth.override_damage_auto_range;
      else if(isDefined(level.stealth.override_damage_auto_range))
        _id_448A418E975E9B01 = level.stealth.override_damage_auto_range;

      if(isDefined(self.stealth.override_damage_sight_range))
        _id_6A01DAAB475B44AB = self.stealth.override_damage_sight_range;
      else if(isDefined(level.stealth.override_damage_sight_range))
        _id_6A01DAAB475B44AB = level.stealth.override_damage_sight_range;
    }

    if(idamage >= self.health)
      _func_AAD7A0EA8AC4CA23("ally_killed", self, eattacker.owner, _id_448A418E975E9B01, _id_6A01DAAB475B44AB);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagTrackPlayerBulletHitAI"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagTrackPlayerBulletHitAI")]](eattacker, idamage);

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isDefined(einflictor._id_746334C2AC85AACC))
    idamage = einflictor._id_746334C2AC85AACC;

  if(getdvarint("dvar_F40118CB927A0802", 0) == 1)
    idamage = _id_34672E1EE2E90CF8(objweapon, idamage);

  if(smeansofdeath == "MOD_MELEE") {
    _id_1E459A85AE0DD390 = 0;

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_me_buzzsaw_mp")
      _id_1E459A85AE0DD390 = 1;

    if(!_id_1E459A85AE0DD390)
      idamage = int(min(idamage, 135));
  } else if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(objweapon) && isDefined(objweapon.basename) && (objweapon.basename == "throwingknife_mp" || objweapon.basename == "shuriken_mp" || objweapon.basename == "throwstar_mp")) {
    _id_5D59D8B177F36F36 = istrue(self._id_685390C6753C2CC7);
    _id_66EFE6FF4098C684 = istrue(self._id_282D867559C07771);
    idamage = scripts\engine\utility::ter_op(_id_5D59D8B177F36F36, int(max(400, self.health + self.armorhealth)), 400);

    if(_id_66EFE6FF4098C684)
      idamage = scripts\engine\utility::ter_op(_id_66EFE6FF4098C684, int(max(400, self.health / 2 + self.armorhealth / 2)), 400);
  }

  headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);

  if(!headshot && isDefined(self.armorhealth) && self.armorhealth > 0 && smeansofdeath != "MOD_CRUSH" && (!isDefined(self._id_F8ECC64162438D76) || !scripts\engine\utility::array_contains(self._id_F8ECC64162438D76, einflictor))) {
    [idamage, _id_1DA1A66B5C6A06A7] = _id_07C40FA80892A721::_id_90CE8EB3DDAA4943(eattacker, einflictor, _id_E851FFA44B7E0D54, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_A95F61E7118777D1, _id_69CFD14B4398C458);
    _id_64D2A3801BD9AD7E = _id_1DA1A66B5C6A06A7;

    if(idamage <= 0) {
      idamage = 1;
      self.health = self.health + 1;
    }
  }

  if(headshot && smeansofdeath != "MOD_CRUSH" && !scripts\cp_mp\utility\damage_utility::_id_0CB9BA92488B23C5(objweapon)) {
    hashelmet = istrue(self.helmethealth) && self.helmethealth > 0;

    if(hashelmet) {
      if(istrue(self._id_895DAE193CFAAC3A)) {
        _id_9285B238A06E0C02 = idamage;
        _id_07C40FA80892A721::_id_E71F062243EA8827(idamage, 0, eattacker);
        idamage = 1;
        self.health = self.health + 1;
      } else {
        _id_9285B238A06E0C02 = 1;
        _id_798CA175BE748E74 = 0;

        if(!istrue(self._id_EF3BFD0243258E2F)) {
          if(scripts\common\utility::getdamagetype(smeansofdeath) == "splash")
            _id_798CA175BE748E74 = 1;

          if((sweapon.classname == "sniper" || sweapon.classname == "dmr") && idamage > 1000 || sweapon.classname == "turret") {
            if(self.helmethealth == 1)
              _id_798CA175BE748E74 = 1;

            _id_9285B238A06E0C02 = self.helmethealth;
          }
        }

        _id_07C40FA80892A721::_id_E71F062243EA8827(_id_9285B238A06E0C02, 0, eattacker);

        if(!istrue(_id_798CA175BE748E74)) {
          idamage = 1;
          self.health = self.health + 1;
        }
      }
    }
  }

  if(_id_64D2A3801BD9AD7E == 0 && _id_9285B238A06E0C02 == 0 && scripts\engine\utility::isbulletdamage(smeansofdeath) && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker) && !isDefined(_id_E851FFA44B7E0D54._id_8FD71E47F0BFAFC4))
    idamage = int(max(idamage, self.health));

  if(_id_5D59D8B177F36F36)
    idamage = self.health;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("relics", "modify_agent_damage"))
    idamage = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("relics", "modify_agent_damage")]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  _id_B2883531AFA6B83D = _id_64D2A3801BD9AD7E > 0;
  _id_C99801D3991FA429 = _id_9285B238A06E0C02 > 0;

  if(_id_B2883531AFA6B83D || _id_C99801D3991FA429)
    idflags = idflags | level.idflags_br_armor_hit;

  if(getdvarint("scr_agent_hitmarkers", 1) == 1) {
    _id_1DA1A66B5C6A06A7 = _id_64D2A3801BD9AD7E + _id_9285B238A06E0C02;
    _id_986B2E0350629522 = 0;
    iskillstreakweapon = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai_mp_controller", "handleDamageFeedback")) {
      _id_974FEFEA31F1FABE = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "handleDamageFeedback");
      [[_id_974FEFEA31F1FABE]](einflictor, eattacker, self, idamage, smeansofdeath, objweapon, shitloc, idflags, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, iskillstreakweapon);
    }
  }

  idamage = int(idamage);

  if(scripts\common\utility::getdamagetype(smeansofdeath) == "splash" || isDefined(sweapon.basename) && issubstr(sweapon.basename, "thermite_bolt"))
    idamage = idamage * 2;

  if(istrue(_id_E851FFA44B7E0D54._id_6C66AFBC7F2CE4B0)) {
    _id_2D776DDE0A657B53 = idamage + _id_64D2A3801BD9AD7E;
    self _meth_136D20776DF768D2(_id_2D776DDE0A657B53, eattacker, vdir, vpoint);

    if(isDefined(level._id_C0F958F7943F0CDE))
      _id_E851FFA44B7E0D54[[level._id_C0F958F7943F0CDE]](_id_2D776DDE0A657B53);
  }

  if(_id_379485F96865DB6D || _id_7543D4FE49C53684 || _id_FACFECFAC4909D65) {
    if(isDefined(objweapon)) {
      attacker = eattacker;

      if(_id_7543D4FE49C53684)
        attacker = eattacker.owner;

      attacker.pers["lastDamageTime"] = gettime();

      if(isDefined(level._id_238D7505B0146B84))
        [[level._id_238D7505B0146B84]](self, attacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "checkHit"))
        attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "checkHit")]](objweapon, _id_E851FFA44B7E0D54, shitloc, idamage);

      if(isPlayer(attacker)) {
        _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
        _id_BA9DC00E6D5896DC = int(min(idamage, self.health));

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weaponstats", "threadedSetWeaponStatByName"))
          attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("weaponstats", "threadedSetWeaponStatByName")]](_id_366B0ECC2F28AEAD, _id_BA9DC00E6D5896DC, "damage", self);
      }
    }
  }

  if(istrue(_id_E851FFA44B7E0D54.agentdamagefeedback)) {
    _id_22602300DECB102B = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
      _id_22602300DECB102B = isDefined(objweapon) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](objweapon.basename);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleDamageFeedback"))
        eattacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleDamageFeedback")]](einflictor, eattacker, _id_E851FFA44B7E0D54, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, _id_22602300DECB102B);
    }
  }

  if(isDefined(sweapon) && !sweapon issilenced())
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "lastNonSilencedDamageTime", gettime());

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "process_events_and_challenges_on_death"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "process_events_and_challenges_on_death")]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(isDefined(_id_E851FFA44B7E0D54.unittype) && isDefined(level.agent_funcs[_id_E851FFA44B7E0D54.unittype]) && isDefined(level.agent_funcs[_id_E851FFA44B7E0D54.unittype]["on_damaged_finished"]))
    _id_E851FFA44B7E0D54[[level.agent_funcs[_id_E851FFA44B7E0D54.unittype]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname, _id_B2883531AFA6B83D);
  else
    _id_E851FFA44B7E0D54[[level.agent_funcs[_id_E851FFA44B7E0D54.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname, _id_B2883531AFA6B83D);
}

_id_62213F6E7B9DA1E7(agent, attacker, inflictor, meansofdeath) {
  if(isDefined(attacker) && istrue(attacker._id_EB504FC7E1CFEB4C))
    return 0;

  if(isDefined(inflictor) && istrue(inflictor._id_EB504FC7E1CFEB4C))
    return 0;

  if(isDefined(attacker) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(attacker.team) && attacker.team == agent.team)
      return 1;

    if(isDefined(attacker.owner) && isDefined(attacker.owner.team) && attacker.owner.team == agent.team)
      return 1;

    if(isDefined(attacker.vehicle) && isDefined(attacker.vehicle.team) && attacker.vehicle.team == agent.team)
      return 1;
  }

  if(isDefined(inflictor) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(inflictor.team) && inflictor.team == agent.team)
      return 1;

    if(isDefined(inflictor.owner) && isDefined(inflictor.owner.team) && inflictor.owner.team == agent.team)
      return 1;

    if(isDefined(inflictor.vehicle) && isDefined(inflictor.vehicle.team) && inflictor.vehicle.team == agent.team)
      return 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("threat_bias", "customFriendlyCheck"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("threat_bias", "customFriendlyCheck")]](agent, attacker, inflictor, meansofdeath);

  return 0;
}

_id_84A1AEC445B03580(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_86C7C655AD6283D7 = isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isent(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(_id_86C7C655AD6283D7) {
    _id_1CBB59F0EDE148A4 = 3;

    if(istrue(self._id_0B222000B9E5E8CE) && isDefined(einflictor.owner))
      _id_1CBB59F0EDE148A4 = 0;

    _id_86C7C655AD6283D7 = scripts\cp_mp\vehicles\vehicle_collision::_id_6EB1FBA746B72F46(einflictor) <= _id_1CBB59F0EDE148A4;
  }

  _id_0663299B134FB78D = isDefined(self.origin) && isDefined(level._id_F0872E42DAF6D4D5) && distancesquared(level._id_F0872E42DAF6D4D5, self.origin) < 250000;
  _id_ABB16A8745308D16 = isPlayer(eattacker) && isDefined(sweapon.basename) && sweapon.basename == "iw9_pi_stimpistol_mp" && scripts\engine\utility::isbulletdamage(smeansofdeath);
  return !istrue(self.invulnerable) && !_id_86C7C655AD6283D7 && !_id_0663299B134FB78D && !_id_ABB16A8745308D16;
}

_id_7D0D24665D72F13C(agent, attacker) {
  _id_371B4C2AB5861E62::_id_1920867DDF76810C(agent, 0);
}

_id_59EA6B2F800CB082(agent, attacker) {
  _id_371B4C2AB5861E62::_id_1920867DDF76810C(agent, 0);

  if(agent.subclass == "tier2")
    fx = scripts\engine\utility::getfx("vfx_gameplay_tier2_helmet_pop");
  else
    fx = scripts\engine\utility::getfx("vfx_gameplay_tier3_helmet_pop");

  playFX(fx, agent gettagorigin("j_helmet"));

  if(!istrue(agent._id_668B72F41E87C75A)) {
    if(istrue(agent._id_895DAE193CFAAC3A) && !issubstr(agent.agent_type, "merc")) {
      agent setscriptablepartstate("helmet", "off");
      agent._id_250A0D62E13C6E73 = undefined;
      agent._id_3FE8AB9198171C21 = 1;
    } else if(isDefined(agent.hatmodel) && agent.hatmodel == "hat_russian_army_5_hide" && agent scripts\engine\utility::hastag(agent.hatmodel, "j_helmet_hide"))
      agent hidepart("j_helmet_hide", agent.hatmodel);
    else if(agent scripts\engine\utility::hastag(agent.headmodel, "j_helmet_hide"))
      agent hidepart("j_helmet_hide", agent.headmodel);
  }
}

_id_B8C245105CC37F9E(objweapon) {
  _id_5D59D8B177F36F36 = 0;
  _id_B7057B2BC6BB0B4B = getdvarint("dvar_A5EAC9A0F544C3CF", 1);

  if(istrue(_id_B7057B2BC6BB0B4B)) {
    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "tier");
      _id_88732A0A3C17BE02 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "category");

      if(isDefined(_id_88732A0A3C17BE02) && _id_88732A0A3C17BE02 != "bosses" && isDefined(_id_C7A4725D05BB7F22)) {
        switch (objweapon.basename) {
          case "toma_proj_mp":
            _id_5D59D8B177F36F36 = 1;
            break;
        }
      }
    }
  }

  return _id_5D59D8B177F36F36;
}

handleriotshielddamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!istrue(self.bhasriotshieldattached))
    return 0;

  if(isDefined(sweapon) && sweapon.basename == "super_laser_charge_mp") {
    self.forcehitlocation = "none";
    return 0;
  }

  _id_5C3F9357F11D2223 = objweapon.basename;
  _id_83A06097F54C024B = 0;

  if(isDefined(einflictor) && (issubstr(_id_5C3F9357F11D2223, "thermite") || isDefined(objweapon.magazine) && issubstr(objweapon.magazine, "boltfire") || isDefined(einflictor.weapon_name) && issubstr(einflictor.weapon_name, "incendiary"))) {
    _id_83A06097F54C024B = 1;
    _id_35AF7DAE0105A3E3 = shitloc == "shield";

    if(_id_35AF7DAE0105A3E3) {
      contents = scripts\engine\trace::create_character_contents();
      _id_759CADFD4D74BFFD = vectorNormalize(vdir);
      startpos = vpoint - _id_759CADFD4D74BFFD * 12;
      endpos = vpoint + _id_759CADFD4D74BFFD * 12;
      results = scripts\engine\trace::ray_trace_detail(startpos, endpos, undefined, contents);

      if(results["fraction"] > 0 && results["fraction"] < 1) {
        _id_1B4FD8D84CA96180 = vpoint - self.origin;
        _id_1B4FD8D84CA96180 = (_id_1B4FD8D84CA96180[0], _id_1B4FD8D84CA96180[1], 0);

        if(vectordot(_id_1B4FD8D84CA96180, results["normal"]) < 0)
          _id_35AF7DAE0105A3E3 = 0;
      } else
        _id_35AF7DAE0105A3E3 = 0;
    }

    if(_id_35AF7DAE0105A3E3) {
      parent = einflictor getlinkedparent();

      if(isDefined(parent) && parent == self) {
        self.bhasthermitestucktoshield = 1;
        self.thermitestuckpains = 0;
      }
    } else if(shitloc != "none") {
      self.bhasthermitestucktoshield = 0;
      self.thermitestuckpains = undefined;
    }
  } else if(isDefined(einflictor) && issubstr(_id_5C3F9357F11D2223, "bunkerbuster")) {
    if(shitloc == "shield") {
      einflictor._id_CE68DE48BC529CD2 = self;
      einflictor._id_16AC6FAC07EACBC3 = 1;
    }
  }

  if(shitloc == "shield") {
    if(_id_83A06097F54C024B)
      return 1;
  } else if(shitloc == "none" && isDefined(einflictor)) {
    _id_AFCDB89D9C3E8439 = einflictor getlinkedparent();

    if(self.bhasthermitestucktoshield && _id_83A06097F54C024B && isDefined(_id_AFCDB89D9C3E8439) && _id_AFCDB89D9C3E8439 == self) {
      if(!isDefined(self.thermitestucktoshield))
        self.thermitestucktoshield = [einflictor];
      else if(!scripts\engine\utility::array_contains(self.thermitestucktoshield, einflictor))
        self.thermitestucktoshield[self.thermitestucktoshield.size] = einflictor;

      self.thermitestuckpains++;
      return 1;
    } else if(issubstr(_id_5C3F9357F11D2223, "molotov")) {
      _id_289CB9FCBD6AA7C8 = einflictor.origin - self.origin;
      _id_8B5B7D7C1E6793DE = vectorNormalize((_id_289CB9FCBD6AA7C8[0], _id_289CB9FCBD6AA7C8[1], 0));
      _id_289CB9FCBD6AA7C8 = vectorNormalize(_id_289CB9FCBD6AA7C8);

      if(vectordot(anglesToForward(self.angles), _id_8B5B7D7C1E6793DE) > 0.5 && -0.98 < _id_289CB9FCBD6AA7C8[2] && _id_289CB9FCBD6AA7C8[2] < 0.98)
        return 1;
    }
  }

  if(smeansofdeath == "MOD_MELEE") {
    if(isDefined(eattacker))
      _id_392A20AB0D4853FB = vectorNormalize(eattacker.origin - self.origin);
    else
      _id_392A20AB0D4853FB = vectorNormalize(vpoint - self.origin);

    _id_C4182E9C211FF588 = anglesToForward(self.angles);

    if(vectordot(_id_C4182E9C211FF588, _id_392A20AB0D4853FB) > 0.5)
      return 1;
  }

  return 0;
}