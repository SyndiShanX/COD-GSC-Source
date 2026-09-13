/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\damage.gsc
***********************************************/

callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1) {
  sweapon = getcompleteweaponname(objweapon);
  victim = self;
  _id_B219C83CBE91CB08 = isDefined(eattacker);
  _id_793E2524735293A1 = _id_B219C83CBE91CB08 && isPlayer(eattacker);
  _id_69CFD14B4398C458 = idamage;

  if(!_id_793E2524735293A1) {
    if(isDefined(eattacker)) {
      if(isDefined(eattacker.code_classname) && eattacker.code_classname == "misc_turret")
        einflictor = eattacker;

      if(isDefined(eattacker.owner) && (isPlayer(eattacker.owner) || isagent(eattacker.owner))) {
        eattacker = eattacker.owner;
        _id_793E2524735293A1 = 1;
        _id_B219C83CBE91CB08 = 1;
      }
    }

    if(!_id_793E2524735293A1) {
      if(isDefined(einflictor) && isDefined(einflictor.owner) && (isPlayer(einflictor.owner) || isagent(einflictor.owner))) {
        eattacker = einflictor.owner;
        _id_793E2524735293A1 = 1;
        _id_B219C83CBE91CB08 = 1;
      }
    }
  }

  if(!shouldtakedamage(idamage, eattacker, sweapon, idflags, _id_793E2524735293A1, smeansofdeath)) {
    return;
  }
  if(damageflag(1)) {}

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isDefined(victim scripts\cp_mp\utility\player_utility::getvehicle()) && victim scripts\cp_mp\utility\player_utility::getvehicle() == einflictor) {
    return;
  }
  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && istrue(einflictor.disable_player_collision_damage)) {
    return;
  }
  if(scripts\cp_mp\vehicles\vehicle::vehicle_playershouldignorecollisiondamage(einflictor, victim, smeansofdeath, objweapon)) {
    return;
  }
  if(smeansofdeath == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[sweapon]))
      level thread[[level.overcook_func[sweapon]]](victim, sweapon);
  } else
    idamage = _id_CCD2E56E1F9A5571(idamage, objweapon);

  idflags = idflags | 4;
  _id_93DDA441E5C43170 = isDefined(smeansofdeath) && (smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH");
  _id_E287831520AA308B = isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET";
  isfriendlyfire = isfriendlyfire(self, eattacker, einflictor);
  _id_09BDB151DF3ED008 = self.perk_data["friendly_explosive_damage_reduction"] != 1.0;
  _id_734F616279B551EE = _id_B219C83CBE91CB08 && eattacker == self;
  _id_47675538CEC2DBA8 = (_id_734F616279B551EE || !_id_B219C83CBE91CB08) && smeansofdeath == "MOD_SUICIDE";

  if(_id_B219C83CBE91CB08) {
    if(eattacker == self) {
      if(_id_93DDA441E5C43170) {
        if(scripts\cp\cp_relics::is_relic_active("relic_rocket_kill_ammo"))
          idamage = idamage * self.perk_data["friendly_explosive_damage_reduction"];
        else {
          vehicles = scripts\cp\utility::getvehiclearray();
          ents = eattacker getistouchingentities(vehicles);

          if(isDefined(ents) && ents.size > 0)
            idamage = idamage * self.perk_data["friendly_explosive_damage_reduction"];
        }
      }
    } else if(isfriendlyfire) {
      idamage = 0;

      if(isPlayer(victim) && isPlayer(eattacker) && _id_02D0FD85607E87A4(objweapon))
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(victim, "stat_2A23C8694884293E");
    }

    if(smeansofdeath == "MOD_EXPLOSIVE") {
      if(sweapon == "at_mine_ap_mp")
        idamage = self.maxhealth * 0.9;

      idamage = idamage * _id_6E09A830FAB9468F::get_perk("enemy_explosive_damage_reduction");

      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(victim)) {}

        idamage = idamage + idamage * level.explosivedamagemod;
      }
    } else if(smeansofdeath == "MOD_GRENADE_SPLASH") {
      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(victim)) {}

        idamage = idamage + idamage * level.explosivedamagemod;
      }
    }
  }

  if(smeansofdeath == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage"))
      idamage = 0;
    else {}
  }

  _id_CB96F01F01795373 = 0.0;

  if(_id_734F616279B551EE && !_id_47675538CEC2DBA8)
    idamage = int(idamage * victim scripts\cp\utility::getdamagemodifiertotal());

  if(_id_74502A9E0EF1F19C::isflashgrenadedamage(objweapon, smeansofdeath)) {
    result = _id_74502A9E0EF1F19C::applyflashfromdamage(victim, eattacker, vpoint, 0);

    if(!result)
      return;
  }

  _id_81846C5D601875EF = self getcurrentprimaryweapon();

  if(_id_81846C5D601875EF.type == "melee")
    idamage = int(idamage * self.perk_data["carrying_melee_damage_scalar"]);

  if(_id_81846C5D601875EF.basename == "iw9_me_riotshield_mp") {
    if(!shouldskipdeathshield(einflictor, eattacker, smeansofdeath)) {
      if(isDefined(shitloc) && shitloc == "shield") {
        if(isDefined(self.riot_shield_damage))
          self.riot_shield_damage = self.riot_shield_damage - idamage;
      }
    }
  }

  if(self issprinting())
    idamage = int(idamage * self.perk_data["sprint_damage_scalar"]);

  if(self.isreviving == 1)
    idamage = int(idamage * self.perk_data["revive_damage_scalar"]);

  if(isDefined(self.super_invulnerable)) {
    if(_id_793E2524735293A1)
      self shellshock("invul_hit", 0.25);

    idamage = 0;
  }

  if(isDefined(self.vehicle_riding_on)) {
    self.vehicle_riding_on dodamage(idamage, self.vehicle_riding_on.origin);
    idamage = int(clamp(idamage, 0, self.health - 1));
  }

  idamage = modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset);
  idamage = modifyfalldamage(victim, idamage, idflags, smeansofdeath);

  if(idamage <= 0) {
    return;
  }
  if(isPlayer(self) && isDefined(self.jugg_health)) {
    _id_82701521E08E1ABF = idamage;

    if(isDefined(self._id_AB0E6A7A6909FC4D))
      _id_82701521E08E1ABF = _id_82701521E08E1ABF * self._id_AB0E6A7A6909FC4D;

    self.jugg_health = self.jugg_health - _id_82701521E08E1ABF;

    if(self.jugg_health <= 0) {
      if(!istrue(self._id_1983AF7858AA2ABA)) {
        if(smeansofdeath != "MOD_FALLING")
          idamage = 0;
      }

      if(!istrue(self._id_892E1B08FB682295))
        self notify("juggernaut_end_damage");
    }

    self._id_1983AF7858AA2ABA = undefined;
    self._id_AB0E6A7A6909FC4D = undefined;
  }

  if(objweapon.basename == "claymore_radial_mp")
    self.shouldskipdeathsshield = 1;

  if(isDefined(eattacker) && istrue(eattacker._id_CEFCAFDECC575902))
    self.shouldskipdeathsshield = 1;

  if(_id_B219C83CBE91CB08 && idamage > 0) {
    if(!damageflag(1)) {
      if(getdvarint("dvar_CF0CA9B75C60DBEF", 20) != 20)
        _id_00D9ACBBE2CB0690 = getdvarint("dvar_CF0CA9B75C60DBEF") * level.framedurationseconds * 1000;
      else
        _id_00D9ACBBE2CB0690 = level.framedurationseconds * 1000 * 20;

      self.damageshieldexpiretime = gettime() + _id_00D9ACBBE2CB0690;
    }

    if(isai(eattacker) || isPlayer(eattacker) && eattacker != self) {
      _id_6F1E07CE9FF97D5F::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);

      if(!isDefined(eattacker.damagedplayers))
        eattacker.damagedplayers = [];

      timestamp = gettime();
      eattacker.damagedplayers[victim.guid] = timestamp;
    }
  }

  if(isPlayer(eattacker) && isDefined(eattacker.pers["participation"]))
    eattacker.pers["participation"]++;
  else if(isPlayer(eattacker))
    eattacker.pers["participation"] = 1;

  if(isPlayer(self) && isDefined(self.pers["participation"]))
    self.pers["participation"]++;
  else if(isPlayer(self))
    self.pers["participation"] = 1;

  _id_41AE4F5CA24216CB::sethasdonecombat(self, 1);

  if(isDefined(eattacker) && isai(eattacker)) {
    if(istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting()))
      idamage = 1;
  }

  _id_4156F93321FABC2C = 0;

  if(!isfriendlyfire) {
    if(_id_07C40FA80892A721::hasarmor() && _id_018C9036DC9A4081::armor_resistance_to_type(smeansofdeath, objweapon, einflictor, eattacker)) {
      if(isDefined(shitloc) && shitloc != "shield") {
        if(isDefined(self.jugg_health)) {
          self notify("jugg_damage");
          _id_1DA1A66B5C6A06A7 = 0;
          idamage = 0;
          [idamage, _id_1DA1A66B5C6A06A7] = _id_07C40FA80892A721::_id_90CE8EB3DDAA4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_BE4285B26ED99AB1, _id_69CFD14B4398C458);
        } else
          [idamage, _id_1DA1A66B5C6A06A7] = _id_07C40FA80892A721::_id_90CE8EB3DDAA4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_BE4285B26ED99AB1, _id_69CFD14B4398C458);

        _id_4156F93321FABC2C = 1;
      }
    }

    if(isDefined(level.updateondamagerelicsfunc))
      level thread[[level.updateondamagerelicsfunc]](eattacker, sweapon, self);

    if(idamage >= self.health && !shouldskipdeathshield(einflictor, eattacker, smeansofdeath)) {
      if(shouldactivatedeathshield(idamage)) {
        idamage = self.health - 1;
        childthread deathshieldinvulnerability(idamage, eattacker, vdir, vpoint, undefined, undefined, einflictor);
      }

      player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(player_vehicle))
        self.bhitbyvehicle = 1;
      else if(weapon_is_a_vehicle_weapon(objweapon))
        self.bhitbyvehicle = 1;
    }

    if(smeansofdeath == "MOD_CRUSH" && idamage >= self.health) {
      if(soundexists("vehicle_body_hit"))
        playsoundatpos(self.origin, "vehicle_body_hit");

      if(isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "script_vehicle")
        self.shouldskiplaststand = undefined;
      else
        self.shouldskiplaststand = 1;
    }

    idamage = int(idamage);

    if(_id_793E2524735293A1 && !isPlayer(self) && !_id_734F616279B551EE)
      eattacker thread _id_354C862768CFE202::updatedamagefeedback("standard");

    if(istrue(self.shouldskipdeathsshield) || smeansofdeath == "MOD_SUICIDE") {
      self.shouldskipdeathsshield = undefined;

      if(_id_07C40FA80892A721::hasarmor() && !(smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
        _id_07C40FA80892A721::_id_2BE3084F26829EAC(0);
        _id_07C40FA80892A721::_id_AC7803D45979135C(0);
      }
    }

    if(istrue(self._id_DADBA5BB000D27DC))
      self._id_DADBA5BB000D27DC = undefined;

    if(istrue(self.oob) && !istrue(level._id_E9F82B2A9789C174)) {
      self.shouldskiplaststand = 1;
      idamage = self.health + 100;
    }

    finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_CB96F01F01795373, modelindex, partname, _id_4156F93321FABC2C);
    level notify("playerdamaged", self);
    level notify("post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, undefined, vpoint, vdir, shitloc, undefined, modelindex, partname);
  }

  _id_1DA1A66B5C6A06A7 = 0;
  _id_986B2E0350629522 = 0;
  iskillstreakweapon = 0;
  _id_18525950B3CABA30(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7);
  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", idamage);

  if(idamage != 0)
    thread scripts\cp\cp_hud_util::player_damage_blood();

  if(_id_B219C83CBE91CB08) {
    if(isagent(eattacker)) {
      if(!isDefined(eattacker.damage_done))
        eattacker.damage_done = 0;
      else
        eattacker.damage_done = eattacker.damage_done + idamage;

      self.recent_attacker = eattacker;

      if(isDefined(level.current_challenge)) {
        if(isDefined(level.custom_playerdamage_challenge_func))
          self[[level.custom_playerdamage_challenge_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc);
      }
    }
  }

  if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    victim thread scripts\cp\cp_player_battlechatter::adddamagetaken(eattacker, objweapon, idamage);

    if(isDefined(victim) && victim scripts\cp_mp\utility\player_utility::_isalive() && victim.health < 30)
      victim thread scripts\cp\cp_player_battlechatter::hurtbadlywait();
  }

  if(isagent(eattacker) && isDefined(eattacker) && eattacker scripts\cp_mp\utility\player_utility::_isalive() && eattacker != victim)
    victim thread scripts\cp\cp_player_battlechatter::addrecentattacker(eattacker);

  if(isDefined(victim) && victim.health <= 1)
    victim scripts\cp\cp_player_battlechatter::onplayerkilled(einflictor, eattacker, idamage, smeansofdeath, objweapon);
}

_id_02D0FD85607E87A4(weapon) {
  switch (weapon.basename) {
    case "iw9_pi_stimpistol_mp":
      return 0;
  }

  return 1;
}

modifyfalldamage(victim, idamage, idflags, smeansofdeath) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    if(istrue(self.isjuggernaut) && !istrue(self._id_CA56839B2E00EDCE))
      _id_702BFC08FABD86CB = victim scripts\cp\cp_juggernaut::jugg_modifyfalldamage();
    else if(istrue(self.isjuggernaut) && istrue(self._id_CA56839B2E00EDCE))
      _id_702BFC08FABD86CB = victim scripts\cp\cp_juggernaut::_id_C186DD6DB0BE730D(idamage);
    else if(victim scripts\cp\cp_relics::_id_95ADB84C5CA51C36() || istrue(self._id_B6AA5954BF6A457A))
      _id_702BFC08FABD86CB = victim scripts\cp\cp_relics::_id_3A307FD8EB4F27EB();
    else if(idflags &level._id_81A140202A2F4D30 && _id_702BFC08FABD86CB >= victim.health)
      _id_702BFC08FABD86CB = victim.health - 1;
    else if(_id_702BFC08FABD86CB < 100 && !scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
      thread _id_6A5D3BF7A5B7064A::_id_2CA98396C7F5CC85(_id_702BFC08FABD86CB);

      if(istrue(self._id_808D06DDFC93A4E4))
        _id_702BFC08FABD86CB = 0;
      else if(_id_702BFC08FABD86CB >= victim.health)
        _id_702BFC08FABD86CB = victim.health - 1;
    }
  }

  return _id_702BFC08FABD86CB;
}

_id_18525950B3CABA30(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7) {
  _id_6A5D3BF7A5B7064A::damageeffects(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7);
}

isusingremotekillstreak() {
  if(scripts\cp\utility\player::isusingremote())
    return 1;

  return 0;
}

shouldskipdeathshield(einflictor, eattacker, smeansofdeath) {
  if(isDefined(eattacker) && eattacker == self)
    return 1;

  if(istrue(self.shouldskipdeathsshield))
    return 1;

  if(getdvarint("dvar_0874038F16B130C2", 0) != 0) {
    if(isDefined(einflictor)) {
      if(isDefined(einflictor.weapon_name)) {
        switch (einflictor.weapon_name) {
          case "gunship_25mm_mp":
          case "gunship_hellfire_mp":
          case "gunship_40mm_mp":
          case "gunship_105mm_mp":
            return 1;
        }
      }
    }
  }

  if(isDefined(einflictor) && is_inflictor_a_carepackage(einflictor)) {
    if(smeansofdeath == "MOD_CRUSH")
      return 1;
  }

  switch (smeansofdeath) {
    case "MOD_FALLING":
    case "MOD_TRIGGER_HURT":
    case "MOD_SUICIDE":
    case "MOD_EXECUTION":
      return 1;
  }

  return 0;
}

_id_CCD2E56E1F9A5571(idamage, objweapon) {
  if(!isDefined(objweapon))
    return idamage;

  if(!isDefined(objweapon.classname))
    return idamage;

  switch (objweapon.classname) {
    case "mg":
      return clamp(idamage, 35, 105);
    case "rifle":
      return clamp(idamage, 30, 90);
    case "smg":
      return clamp(idamage, 20, 50);
    default:
      return idamage;
  }

  return idamage;
}

is_inflictor_a_carepackage(einflictor) {
  if(!isDefined(einflictor))
    return 0;

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    if(level.cratedata.crates.size > 0) {
      if(scripts\engine\utility::array_contains(level.cratedata.crates, einflictor))
        return 1;
    }
  }

  return 0;
}

weapon_is_a_vehicle_weapon(objweapon) {
  switch (objweapon.basename) {
    case "hummer_mp":
    case "blima_mp":
    case "palfa_mp":
    case "pickup_2014_mp":
    case "cougar_mp":
    case "pwc_mp":
    case "sedan_hatchback_1985_hsk_mp":
    case "sedan_hatchback_1985_mp":
    case "chopped_pickup_mp":
    case "overland_2016_mp":
    case "suv_1996_mp":
    case "patrol_boat_wkd_mp":
    case "patrol_boat_mp":
    case "jltv_mg_hsk_mp":
    case "jltv_mg_mp":
    case "jltv_hsk_mp":
    case "jltv_mp":
    case "rhib_mp":
    case "lighttank_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "mrap_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
    case "suv_1996_wrecked_mp":
    case "iw9_mg_cougar_mp":
    case "iw9_tur_cougar_mp":
      return 1;
    default:
      return 0;
  }
}

isenemyinfrontofme(enemy, _id_3B37CA6EC4D56E75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(_id_3B37CA6EC4D56E75))
    return dot > 0;

  return dot > _id_3B37CA6EC4D56E75;
}

isoneshotdamage(damage, smeansofdeath) {
  if(smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN" || smeansofdeath == "MOD_SUICIDE")
    return 0;

  if(damage >= self.health)
    return 1;

  return 0;
}

delayed_stun_damage(attacker) {
  self endon("death");
  attacker endon("death");
  wait 0.05;
  self dodamage(2, self.origin, attacker, undefined, "MOD_MELEE");
}

stopusingremote() {
  self notify("stop_using_remote");
}

useinvulnerability(idamage) {
  self.health = idamage + 1;
  self.haveinvulnerabilityavailable = 0;
}

shouldtakedamage(damage, attacker, weapon, idflags, _id_793E2524735293A1, smeansofdeath) {
  if(isDefined(idflags) && (idflags == 256 || idflags == 258))
    return 0;

  if(istrue(self._id_6863ACEA0BD6BF64))
    return 0;

  if(damageflag(1) && !istrue(self.shouldskipdeathsshield))
    return 0;

  if(istrue(self.enteredcamera)) {
    childthread _id_7A79B89781452FF9();
    return 0;
  }

  if(isDefined(level.custom_shouldtakedamage) && isfunction(level.custom_shouldtakedamage)) {
    if(![[level.custom_shouldtakedamage]](self))
      return 0;
  }

  if(isusingremotekillstreak() && scripts\cp\utility::is_specops_gametype())
    return 0;

  if(isDefined(self.ability_invulnerable))
    return 0;

  if(isDefined(weapon) && weapon == "iw8_la_rpapa7_mp_friendly")
    return 0;

  if(isDefined(weapon) && weapon == "overwatch_missile_cp")
    return 0;

  if(isDefined(weapon) && weapon == "tur_gun_decho_cp")
    return 0;

  if(istrue(self.inchopper) || istrue(self._id_6D4D929E7C9D3E5C))
    return 0;

  return 1;
}

check_for_explosive_shotgun_damage(alien, idamage, eattacker, sweapon, smeansofdeath) {
  _id_21B0311D64CADFA2 = 500;

  if(!isDefined(alien) || !alien scripts\cp_mp\utility\player_utility::_isalive())
    return idamage;

  if(!isDefined(eattacker) || !isPlayer(eattacker) || smeansofdeath != "MOD_EXPLOSIVE_BULLET")
    return idamage;

  if(sweapon.classname == "weapon_shotgun") {
    dist = distance(eattacker.origin, alien.origin);
    scale = max(1, dist / _id_21B0311D64CADFA2);
    _id_326616B4920FD3DA = idamage * 8;
    _id_3F8DC47CC64DE3F5 = _id_326616B4920FD3DA * scale;

    if(dist > _id_21B0311D64CADFA2)
      return idamage;

    return int(_id_3F8DC47CC64DE3F5);
  }

  return idamage;
}

kill_trigger_event_was_processed() {
  return istrue(self.kill_trigger_event_processed);
}

set_kill_trigger_event_processed(player, value) {
  self.kill_trigger_event_processed = value;
}

scale_alien_damage_by_weapon_type(eattacker, idamage, smeansofdeath, sweapon, shitloc) {
  if(isDefined(shitloc) && shitloc != "none")
    idamage = check_for_explosive_shotgun_damage(self, idamage, eattacker, sweapon, smeansofdeath);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none") {
    if(sweapon.classname == "weapon_shotgun")
      idamage = idamage + int(idamage * level.shotgundamagemod);
    else
      idamage = idamage + int(idamage * level.exploimpactmod);
  }

  return idamage;
}

scale_alien_damage_by_perks(eattacker, idamage, smeansofdeath, sweapon) {}

scale_alien_damage_by_prestige(eattacker, idamage) {
  if(isPlayer(eattacker)) {
    _id_B5554BA9AAC5F886 = eattacker scripts\cp\perks\cp_prestige::prestige_getweapondamagescalar();
    idamage = idamage * _id_B5554BA9AAC5F886;
    idamage = int(idamage);
  }

  return idamage;
}

should_play_melee_blood_vfx(eattacker) {
  if(isDefined(level.should_play_melee_blood_vfx_func))
    return [[level.should_play_melee_blood_vfx_func]](eattacker);

  return 1;
}

check_for_special_damage(enemy, sweapon, smeansofdeath) {}

catch_alien_on_fire(player, _id_67732F7267D0E028, _id_48295D2521469737, _id_93DC9E18C3C1A7A8) {
  self endon("death");
  alien_fire_on();
  damage_alien_over_time(player, _id_67732F7267D0E028, _id_48295D2521469737, _id_93DC9E18C3C1A7A8);
  alien_fire_off();
}

alien_fire_on() {
  if(!isDefined(self.is_burning))
    self.is_burning = 0;

  self.is_burning++;

  if(self.is_burning == 1 && self.species == "alien") {
    if(isDefined(self.agent_type) && self.agent_type != "minion")
      self setscriptablepartstate("animpart", "burning");
  }
}

alien_fire_off() {
  self.is_burning--;

  if(self.is_burning > 0) {
    return;
  }
  self.is_burning = undefined;
  self notify("fire_off");

  if(self.species == "alien")
    self setscriptablepartstate("animpart", "normal");
}

damage_alien_over_time(player, _id_67732F7267D0E028, _id_48295D2521469737, _id_93DC9E18C3C1A7A8) {
  _id_A8B5325F7E15D42E = 150;
  _id_51AF0C38CB777F8B = 100;
  _id_A966AEAB380E9636 = 75;
  _id_A2B0540F10AF6C7E = 133;
  _id_CB2B259D44A79604 = 500;
  _id_656A1E711E1D8CC3 = 100;
  _id_B6E67F141DDCADCA = 3;
  _id_C9E637CB88B15F1F = 4;
  _id_E6478D4DC5157B2A = 3;
  _id_6901C1F8AC101812 = 4;
  _id_3291907D87CE18C0 = 4;
  _id_328F9810505A1E47 = 2;
  _id_14C6BA597F893D83 = 1.2;
  self endon("death");

  if(!isDefined(_id_67732F7267D0E028) && !isDefined(_id_48295D2521469737)) {
    agent = scripts\cp\cp_agent_utils::get_agent_type(self);

    switch (agent) {
      case "goon2":
      case "goon":
      case "goon4":
      case "goon3":
        _id_48295D2521469737 = _id_A966AEAB380E9636;
        _id_67732F7267D0E028 = _id_E6478D4DC5157B2A;
      case "brute4":
      case "brute3":
      case "brute2":
      case "brute":
        _id_48295D2521469737 = _id_51AF0C38CB777F8B;
        _id_67732F7267D0E028 = _id_C9E637CB88B15F1F;
      case "spitter":
        _id_48295D2521469737 = _id_A2B0540F10AF6C7E;
        _id_67732F7267D0E028 = _id_6901C1F8AC101812;
      case "elite_boss":
      case "elite":
        _id_48295D2521469737 = _id_CB2B259D44A79604;
        _id_67732F7267D0E028 = _id_3291907D87CE18C0;
      case "minion":
        _id_48295D2521469737 = _id_656A1E711E1D8CC3;
        _id_67732F7267D0E028 = _id_328F9810505A1E47;
      default:
        _id_48295D2521469737 = self.maxhealth * 0.5;
        _id_67732F7267D0E028 = _id_B6E67F141DDCADCA;
    }
  } else {
    if(!isDefined(_id_48295D2521469737))
      _id_48295D2521469737 = _id_A8B5325F7E15D42E;

    if(!isDefined(_id_67732F7267D0E028))
      _id_67732F7267D0E028 = _id_B6E67F141DDCADCA;
  }

  if(isDefined(player) && isDefined(_id_93DC9E18C3C1A7A8) && player scripts\cp\utility::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(_id_93DC9E18C3C1A7A8))
    _id_48295D2521469737 = _id_48295D2521469737 * _id_14C6BA597F893D83;

  _id_48295D2521469737 = _id_48295D2521469737 * level.alien_health_per_player_scalar[level.players.size];
  _id_6747992B3D918F29 = 0;
  _id_1FF426B6DE9CA538 = 6;
  _id_7F7CCFF7467A13B4 = _id_67732F7267D0E028 / _id_1FF426B6DE9CA538;
  _id_3985150C8F1E8E34 = _id_48295D2521469737 / _id_1FF426B6DE9CA538;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1FF426B6DE9CA538; _id_AC0E594AC96AA3A8++) {
    wait(_id_7F7CCFF7467A13B4);

    if(isalive(self))
      self dodamage(_id_3985150C8F1E8E34, self.origin, player, player, "MOD_UNKNOWN");
  }
}

friendlyfirecheck(owner, attacker, _id_361E36D990201511) {
  if(!isDefined(owner))
    return 1;

  if(!level.teambased)
    return 1;

  attackerteam = attacker.team;
  _id_EAF0A0E98E12BCD0 = level.friendlyfire;

  if(isDefined(_id_361E36D990201511))
    _id_EAF0A0E98E12BCD0 = _id_361E36D990201511;

  if(_id_EAF0A0E98E12BCD0 != 0)
    return 1;

  if(attacker == owner)
    return 0;

  if(!isDefined(attackerteam))
    return 1;

  if(attackerteam != owner.team)
    return 1;

  return 0;
}

update_damage_score(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset) {
  if(isDefined(eattacker) && isDefined(eattacker.owner))
    scripts\cp\cp_agent_utils::store_attacker_info(eattacker.owner, idamage * 0.75);
  else if(isDefined(eattacker) && isDefined(eattacker.pet) && eattacker.pet == 1)
    scripts\cp\cp_agent_utils::store_attacker_info(eattacker.owner, idamage);
  else
    scripts\cp\cp_agent_utils::store_attacker_info(eattacker, idamage);

  if(isDefined(eattacker) && isDefined(sweapon))
    level thread update_zombie_damage_challenge(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, self);

  update_alien_damage_performance(eattacker, idamage, smeansofdeath);
}

update_zombie_damage_challenge(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, alien) {
  if(istrue(self.died_poorly)) {
    return;
  }
  if(!isDefined(level.current_challenge)) {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker)) {
    _id_2DD5EE7241C5774D = self[[level.custom_damage_challenge_func]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, alien);

    if(!istrue(_id_2DD5EE7241C5774D))
      return;
  }
}

update_alien_damage_performance(eattacker, idamage, smeansofdeath) {
  if(isDefined(level.update_alien_damage_performance))
    [[level.update_alien_damage_performance]](eattacker, idamage, smeansofdeath);
  else
    update_performance_zombie_damage(eattacker, idamage, smeansofdeath);
}

update_performance_zombie_damage(eattacker, idamage, smeansofdeath) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(isDefined(eattacker.classname) && eattacker.classname == "script_vehicle") {
    return;
  }
  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    return;
  }
  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "damage_done_on_alien", idamage);

  if(isPlayer(eattacker))
    eattacker scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", idamage);
  else if(isDefined(eattacker.owner))
    eattacker.owner scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", idamage);
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflag = data.idflag;

  if(isDefined(idflag) && (idflag && level.idflags_ricochet))
    _id_702BFC08FABD86CB = 0.6 * damage;
  else
    _id_702BFC08FABD86CB = damage;

  _id_702BFC08FABD86CB = handleempdamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = handlegrenadedamage(objweapon, type, _id_702BFC08FABD86CB);
  return _id_702BFC08FABD86CB;
}

handlemissiledamage(objweapon, meansofdeath, damage) {
  _id_ADAD6640398C7B3A = damage;

  switch (objweapon.basename) {
    case "bomb_site_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "gunship_105mm_mp":
      self.largeprojectiledamage = 1;
      _id_ADAD6640398C7B3A = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      _id_ADAD6640398C7B3A = _id_ADAD6640398C7B3A * 2;
      break;
  }

  return _id_ADAD6640398C7B3A;
}

handlegrenadedamage(objweapon, _id_D95DA0355CF4CCB4, _id_702BFC08FABD86CB) {
  if(isexplosivedamagemod(_id_D95DA0355CF4CCB4)) {
    switch (objweapon.basename) {
      case "c4_mp":
        _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 3;
        break;
      case "bouncing_betty_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 4;
        break;
      default:
        if(objweapon.isalternate)
          _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 3;

        break;
    }
  }

  return _id_702BFC08FABD86CB;
}

handlemeleedamage(objweapon, meansofdeath, damage) {
  if(meansofdeath == "MOD_MELEE")
    return self.maxhealth + 1;

  return damage;
}

handleempdamage(objweapon, meansofdeath, damage) {
  return damage;
}

handleapdamage(objweapon, meansofdeath, damage, attacker) {
  modifier = 1.0;
  armorpiercingmod = level.armorpiercingmod - 1;

  if(scripts\cp\utility::isfmjdamage(objweapon, meansofdeath, attacker))
    modifier = modifier + armorpiercingmod;

  if(isDefined(level.armorpiercingmodks)) {
    armorpiercingmodks = level.armorpiercingmodks - 1;

    if(isDefined(attacker) && attacker scripts\cp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && _id_74502A9E0EF1F19C::isprimaryweapon(objweapon) && scripts\engine\utility::isbulletdamage(meansofdeath))
      modifier = modifier + armorpiercingmodks;
  }

  return damage * modifier;
}

handleshotgundamage(objweapon, meansofdeath, damage) {
  if(!isDefined(objweapon))
    return damage;

  if(objweapon.basename == "none")
    return damage;

  if(weaponclass(objweapon) != "spread")
    return damage;

  return int(min(150, damage));
}

armormitigation(vpoint, vdir, shitloc) {
  return 1.0;
}

_id_8AAF577E3D797E05(_id_19CD4FF88CDE876D, enemy, idamage, smeansofdeath, _id_FA0D4CCA2B2EC6BB, shockmelee, _id_C74157CAAAF53945) {
  if(isDefined(self.stun_struct))
    return 0;

  time = gettime();

  if(isDefined(self._id_055D7B72228D431A) && !isDefined(shockmelee)) {
    if(time < self._id_055D7B72228D431A)
      return;
  }

  self._id_055D7B72228D431A = time + 500;
  shocked = 0;
  _id_3B79136F23C59276 = 0;
  _id_41CC5FAB7E69635E = 4;

  if(!isDefined(_id_FA0D4CCA2B2EC6BB))
    _id_FA0D4CCA2B2EC6BB = 256;

  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_A4A7CBAACB7CC0CD = scripts\engine\utility::get_array_of_closest(enemy.origin, enemies, undefined, _id_41CC5FAB7E69635E, _id_FA0D4CCA2B2EC6BB, 1);

  if(scripts\engine\utility::array_contains(_id_A4A7CBAACB7CC0CD, enemy))
    _id_A4A7CBAACB7CC0CD = scripts\engine\utility::array_remove(_id_A4A7CBAACB7CC0CD, enemy);

  if(_id_A4A7CBAACB7CC0CD.size >= 1) {
    if(!isDefined(self.stun_struct))
      self.stun_struct = spawnStruct();

    if(istrue(shockmelee))
      idamage = int(idamage);
    else
      idamage = int(idamage * 0.5);

    origins = ["j_crotch", "j_hip_le", "j_hip_ri"];
    _id_19CD4FF88CDE876D = enemy gettagorigin(scripts\engine\utility::random(origins));

    foreach(guy in _id_A4A7CBAACB7CC0CD) {
      if(isDefined(guy) && guy != enemy && isalive(guy) && !istrue(guy.stunned)) {
        shocked = 1;

        if(istrue(shockmelee))
          guy.shockmelee = 1;

        guy _id_25ECC1EC5BB26160(self, idamage, smeansofdeath, _id_19CD4FF88CDE876D);
        _id_3B79136F23C59276++;

        if(_id_3B79136F23C59276 >= _id_41CC5FAB7E69635E) {
          break;
        }
      }
    }

    wait 0.05;
    self.stun_struct = undefined;
  }

  if(istrue(shockmelee)) {
    scripts\cp\utility::notify_used_consumable("shock_melee_upgrade");
    enemy.shockmelee = 1;
  }

  if(isDefined(_id_C74157CAAAF53945))
    self notify(_id_C74157CAAAF53945);

  return shocked;
}

_id_25ECC1EC5BB26160(player, idamage, smeansofdeath, _id_E98CAD4362274441) {
  self endon("death");
  waitframe();
  _id_9239D8BE6122BDC5 = undefined;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  origins = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  _id_9239D8BE6122BDC5 = self gettagorigin(scripts\engine\utility::random(origins));

  if(isDefined(_id_9239D8BE6122BDC5)) {
    playfxbetweenpoints(level._effect["blue_ark_beam"], _id_E98CAD4362274441, vectortoangles(_id_E98CAD4362274441 - _id_9239D8BE6122BDC5), _id_9239D8BE6122BDC5);
    wait 0.05;

    if(isDefined(self) && smeansofdeath == "MOD_MELEE")
      self playSound("zombie_fence_shock");

    wait 0.05;
    _id_C687C4D44C095FBF = int(idamage);
    scripts\common\fx::playfxnophase(level._effect["stun_shock"], _id_9239D8BE6122BDC5);

    if(isDefined(self))
      thread _id_EAA3CA00A2F2E3D7(player, smeansofdeath, _id_C687C4D44C095FBF, "stun_ammo_mp");
  }
}

_id_EAA3CA00A2F2E3D7(player, smeansofdeath, idamage, sweapon) {
  self endon("death");

  if(isDefined(idamage))
    dmg = idamage;
  else
    dmg = 100;

  if(isDefined(sweapon))
    weapon = sweapon;
  else
    weapon = "iw7_stunbolt_zm";

  thread _id_718CA73E28EAEDF9(1);

  if(isDefined(player))
    self dodamage(dmg, self.origin, player, player, smeansofdeath, weapon);
  else
    self dodamage(dmg, self.origin, undefined, undefined, smeansofdeath, weapon);
}

_id_718CA73E28EAEDF9(time) {
  self endon("death");
  wait(time);

  if(!scripts\cp\utility::should_be_affected_by_trap(self)) {
    return;
  }
  self.stunned = undefined;
}

isfriendlyfire(victim, eattacker, einflictor) {
  if(!isDefined(eattacker))
    return 0;

  if(!level.teambased)
    return 0;

  if(!isPlayer(eattacker) && !isDefined(eattacker.team))
    return 0;

  _id_DD1F54A7372524D6 = istrue(level._id_3904DE63DBC4B0AF) && isDefined(einflictor) && isDefined(einflictor.classname) && issubstr(einflictor.classname, "barrel");

  if(_id_DD1F54A7372524D6) {
    if(getdvarint("dvar_6DDFE1C2DCC14E61", 0))
      victim.shouldskipdeathsshield = 1;

    return 0;
  }

  if(victim.team != eattacker.team)
    return 0;

  if(isDefined(eattacker.owner) && isDefined(eattacker.owner.team) && eattacker.owner != eattacker) {
    if(eattacker.owner.team == victim.team)
      return 1;
  }

  if(victim == eattacker)
    return 0;

  return 1;
}

finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D) {
  if(!callback_killingblow(einflictor, eattacker, idamage - idamage * _id_CB96F01F01795373, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self)) {
    if(idamage >= self.health) {
      if(isDefined(level._id_248DBA4332A49AD3)) {
        if(self[[level._id_248DBA4332A49AD3]]()) {
          idamage = self.health + 100000;

          if(shitloc == "shield")
            shitloc = "torso_upper";
        }
      }

      if(!isDefined(self.recondronesuper) && isusingremotekillstreak()) {
        if(!isDefined(vdir))
          vdir = (0, 0, 0);

        if(!isDefined(eattacker))
          eattacker = self;

        if(!isDefined(einflictor))
          einflictor = eattacker;

        scripts\cp\utility::allow_player_ignore_me(1);
        deathanimduration = self playerforcedeathanim(einflictor, smeansofdeath, sweapon, shitloc, vdir);
        self.fauxdead = 1;
        self.shouldskiplaststand = 1;
        self notify("faux_dead");

        if(shoulduseexplosiveindicator(smeansofdeath))
          idflags = idflags | level.idflags_ricochet;

        if(!isDefined(self.nocorpse)) {
          if(isDefined(self.body)) {
            self.body delete();
            self.body = undefined;
          }

          self.body = self cloneplayer(deathanimduration, eattacker);
        }

        if(!isDefined(self.nocorpse) && isDefined(self.body)) {
          self.body.targetname = "player_corpse";
          scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
          self setsolid(0);
          thread _startragdoll(self.body, smeansofdeath, einflictor);
        }

        if(isusingremotekillstreak()) {
          thread poke_the_player_after_faux_death();
          self waittill("stopped_using_remote");
          idamage = self.health + 100000;

          if(shitloc == "shield")
            shitloc = "torso_upper";
        }

        if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
          if(!isDefined(eattacker._id_198B774C93C48891))
            eattacker._id_198B774C93C48891 = gettime();
        }

        if(!isDefined(self._id_9691E7D8CDE294F2))
          self._id_9691E7D8CDE294F2 = gettime();

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
        self setsolid(1);
        scripts\cp\utility::allow_player_ignore_me(0);
      } else if(isDefined(level.custom_death_func) && isfunction(level.custom_death_func)) {
        self.health = 1;
        idamage = 0;
        self[[level.custom_death_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
        idamage = self.health + 100000;

        if(shitloc == "shield")
          shitloc = "torso_upper";

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
      } else if(istrue(self.isjuggernaut)) {
        self waittill("juggernaut_end");

        if(istrue(self._id_CA56839B2E00EDCE))
          wait 0.05;

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
      } else if(isDefined(self.vehicle)) {
        scripts\engine\utility::waittill_any_timeout_2(2, "exited_vehicle", "vehicle_exit");
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
        self disableusability();
      } else
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
    } else
      self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname, _id_B2883531AFA6B83D);
  }

  damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker);
}

_startragdoll(corpse, meansofdeath, inflictor) {
  if(!isDefined(corpse)) {
    return;
  }
  corpse endon("death");
  deathanim = corpse getcorpseanim();
  _id_98125A9AD5CDA4F2 = undefined;
  animduration = getanimlength(deathanim);
  seatid = undefined;
  _id_4030C4AD220257F2 = animhasnotetrack(deathanim, "delete_corpse");
  _id_41736EBFC0D6434C = animhasnotetrack(deathanim, "delete_corpse_delayed");
  noragdoll = animhasnotetrack(deathanim, "no_ragdoll");
  _id_CE8BCDF49C43B6D0 = animhasnotetrack(deathanim, "start_ragdoll");
  _id_98125A9AD5CDA4F2 = 0;

  if(_id_CE8BCDF49C43B6D0) {
    _id_9296F7895C90C8ED = getnotetracktimes(deathanim, "start_ragdoll")[0];
    _id_98125A9AD5CDA4F2 = _id_9296F7895C90C8ED * animduration;
  }

  wait(_id_98125A9AD5CDA4F2);

  if(!isDefined(corpse)) {
    return;
  }
  if(!corpse isragdoll())
    corpse startragdoll();

  if(_id_4030C4AD220257F2 || _id_41736EBFC0D6434C) {
    deletedelay = animduration;

    if(_id_41736EBFC0D6434C)
      animduration = animduration + 3;

    if(isDefined(_id_98125A9AD5CDA4F2))
      deletedelay = deletedelay - _id_98125A9AD5CDA4F2;

    wait(deletedelay);
    corpse delete();
  } else
    corpse setplayercorpsedone();
}

callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && idamage >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\cp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

poke_the_player_after_faux_death() {
  self endon("disconnect");
  self endon("death");
  self endon("laststand");
  self waittill("stopped_using_remote");
  wait 0.1;

  if(!self.inlaststand)
    self suicide();
}

damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker) {
  thread onweapondamage(einflictor, sweapon, smeansofdeath, idamage, eattacker);

  if(!isai(self))
    self playRumbleOnEntity("damage_heavy");
}

onweapondamage(einflictor, sweapon, meansofdeath, damage, eattacker) {
  self endon("death");
  self endon("disconnect");

  switch (sweapon) {
    default:
      if(allowshellshockondamage(sweapon) && !isai(eattacker))
        _id_74502A9E0EF1F19C::shellshockondamage(meansofdeath, damage);

      break;
  }
}

allowshellshockondamage(sweapon) {
  if(isDefined(sweapon)) {
    switch (sweapon) {
      case "chopper_boss_minigun_cp":
      case "iw7_zapper_grey":
        return 0;
    }
  }

  return 1;
}

istacticaldamage(objweapon, smeansofdeath) {
  if(!isDefined(objweapon))
    return 0;

  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_IMPACT")
    return 0;

  switch (objweapon.basename) {
    case "cryo_mine_mp":
    case "blackout_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_cp":
    case "trophy_mp":
      return 0;
    default:
      return 0;
  }
}

damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, hitloc) {
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, undefined, objweapon, smeansofdeath, inflictor);

  if(smeansofdeath == "MOD_GRENADE")
    return 1;

  if(smeansofdeath == "MOD_PROJECTILE")
    return 1;

  if(isDefined(attacker) && attacker == victim)
    return 1;

  if(victim scripts\cp_mp\utility\damage_utility::isstuckdamage(data))
    return 1;

  if(weaponignoresblastshield(objweapon, hitloc))
    return 1;

  return 0;
}

weaponignoresblastshield(objweapon, shitloc) {
  _id_5C3F9357F11D2223 = objweapon.basename;

  if(scripts\cp\utility::issuperweapon(_id_5C3F9357F11D2223))
    return 1;

  switch (_id_5C3F9357F11D2223) {
    case "sentry_shock_mp":
    case "bradley_tow_proj_mp":
    case "snapshot_grenade_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "bomb_site_mp":
    case "thermite_ap_mp":
    case "thermite_av_mp":
    case "chopper_gunner_proj_mp":
    case "chopper_gunner_turret_mp":
    case "toma_proj_mp":
    case "cruise_proj_mp":
    case "artillery_mp":
    case "thermite_mp":
      return 1;
    default:
      return 0;
  }
}

modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && idamage != 1) {
    idamage = idamage * getdvarfloat("scr_explbulletmod");
    idamage = int(idamage);
  }

  if(isDefined(level.modifyplayerdamage_relics) && isarray(level.modifyplayerdamage_relics)) {
    foreach(func in level.modifyplayerdamage_relics)
    idamage = [[func]](victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc);
  }

  if(isDefined(level.modifyplayerdamage))
    idamage = [[level.modifyplayerdamage]](einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags);

  if(!isDefined(victim.donotmodifydamage))
    idamage = int(idamage * victim scripts\cp\utility::getdamagemodifiertotal(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc));

  if(scripts\cp\utility::is_specops_gametype())
    return idamage;

  if(isPlayer(self)) {
    if(isDefined(eattacker) && isagent(eattacker) && !isexplosivedamagemod(smeansofdeath) && !isenemyinfrontofme(eattacker) && !istrue(smeansofdeath == "MOD_MELEE"))
      idamage = idamage * 0.5;
  }

  return idamage;
}

damageinvulnerability(damage, attacker, direction, point, type, _id_7178D1AB6020C7C2, inflictor) {
  _id_22F1590673800ED7 = getinvultime();
  enabledamageinvulnerability();
  wait(_id_22F1590673800ED7);
  disabledamageinvulnerability();
}

shoulddodamageinvulnerabilty(damage) {
  if(scripts\engine\utility::ent_flag("player_zero_attacker_accuracy"))
    return 0;

  if(damageflag(1))
    return 0;

  return 1;
}

getinvultime() {
  return self.gs.invultime_ondamagemin;
}

enabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

disabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_clear("player_zero_attacker_accuracy");
  scripts\cp\cp_gameskill::update_player_attacker_accuracy();
}

deathshieldinvulnerability(damage, attacker, direction, point, type, _id_7178D1AB6020C7C2, inflictor) {
  _id_61CF390635798C6D = getdeathsshieldduration();
  _id_ACEAB7F4A1E5C8C3 = getdeathsdoorduration();

  if(!scripts\cp\utility::is_specops_gametype())
    _id_61CF390635798C6D = getdvarfloat("dvar_BCE38029084A7EB5", 1);

  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  _id_00D9ACBBE2CB0690 = level.framedurationseconds * 1000 * getdvarint("dvar_CD55457316748B46", 40);

  if(istrue(level.relic_vampire))
    _id_00D9ACBBE2CB0690 = level.framedurationseconds * 1000 * 10;

  self.damageshieldexpiretime = gettime() + _id_00D9ACBBE2CB0690;

  if(!istrue(self.adrenalinepoweractive))
    wait_for_time_or_notify(_id_61CF390635798C6D, "force_regeneration");

  setdamageflag(1, 0);
  disabledamageinvulnerability();

  if(!istrue(self.adrenalinepoweractive))
    wait_for_time_or_notify(_id_ACEAB7F4A1E5C8C3, "force_regeneration");

  disabledeathsdoor();
}

wait_for_time_or_notify(timer, _id_8A7825FD9827B018) {
  self endon(_id_8A7825FD9827B018);
  wait(timer);
}

getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

enabledeathsdoor() {
  setdamageflag(2, 1);
  _id_4AA7D06CC1A22953 = "damage_deathsdoor";
  _id_11F7633750EB7DD9 = "damage_deathsdoor_nvg";

  if(isDefined(level._id_3DC8BA65070D0F42))
    _id_4AA7D06CC1A22953 = level._id_3DC8BA65070D0F42;

  if(isDefined(level._id_40BA4DC45BA0EF63))
    _id_11F7633750EB7DD9 = level._id_40BA4DC45BA0EF63;

  if(self isnightvisionon())
    visionsetpain(_id_11F7633750EB7DD9);
  else
    visionsetpain(_id_4AA7D06CC1A22953);
}

deathsdooroverlaypulse(_id_A29C5118C5608DB6) {
  level endon("game_ended");
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("disconnect");
  self endon("death");
  _id_9E6A60AB5457B772 = 1;
  thread lerpdeathsdoorpulsenorm(_id_A29C5118C5608DB6);

  while(_id_9E6A60AB5457B772 > 0) {
    time = gettime();
    _id_CFC5BE6822858733 = time;
    _id_7AC5B3B3E8DF90D6 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(time < _id_CFC5BE6822858733 + _id_7AC5B3B3E8DF90D6) {
      time = gettime();
      _id_05DD15769B0C4106 = 0.1;
      _id_060027769B32B054 = 0.4;
      _id_22FD1081463A401F = (time - _id_CFC5BE6822858733) / _id_7AC5B3B3E8DF90D6;
      _id_5C46646210255EF0 = scripts\engine\math::normalized_cos_wave(_id_22FD1081463A401F);
      _id_9E6A60AB5457B772 = scripts\engine\math::factor_value(_id_05DD15769B0C4106, _id_060027769B32B054, _id_5C46646210255EF0);
      _id_9E6A60AB5457B772 = _id_9E6A60AB5457B772 * self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = _id_9E6A60AB5457B772;
      waitframe();
    }
  }
}

deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

bloodoverlay(alpha, holdtime, _id_F69BA8D7B96E8326) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }
  self endon("stopPainOverlays");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = alpha;
  wait_for_time_or_notify(holdtime, "force_regeneration");

  if(_id_F69BA8D7B96E8326 <= 0)
    _id_F69BA8D7B96E8326 = 1;

  self.damage.bloodoverlay fadeovertime(_id_F69BA8D7B96E8326);
  self.damage.bloodoverlay.alpha = 0;
}

updatedeathsdoorvisionset() {
  if(!damageflag(2))
    return 0;

  _id_4AA7D06CC1A22953 = "damage_deathsdoor";
  _id_11F7633750EB7DD9 = "damage_deathsdoor_nvg";

  if(isDefined(level._id_3DC8BA65070D0F42))
    _id_4AA7D06CC1A22953 = level._id_3DC8BA65070D0F42;

  if(isDefined(level._id_40BA4DC45BA0EF63))
    _id_11F7633750EB7DD9 = level._id_40BA4DC45BA0EF63;

  if(self isnightvisionon())
    visionsetpain(_id_11F7633750EB7DD9);
  else
    visionsetpain(_id_4AA7D06CC1A22953);
}

disabledeathsdoor(_id_5E0065A1DC2434B6) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(_id_5E0065A1DC2434B6))
    _id_5E0065A1DC2434B6 = 0;

  if(!_id_5E0065A1DC2434B6)
    _id_6A325AD88DFA8BA1 = gethealthregentime();
  else
    _id_6A325AD88DFA8BA1 = 0.0;

  _id_3B0606A6C467A8AA = getvisionlerprate(_id_6A325AD88DFA8BA1);
  setdamageflag(2, 0);
}

getvisionlerprate(_id_D75DFE2C8B34F282) {
  rate = 1 / max(0.01, _id_D75DFE2C8B34F282);
  return clamp(rate, 0, 30);
}

lerpdeathsdoorpulsenorm(_id_D75DFE2C8B34F282) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("disconnect");
  timer = _id_D75DFE2C8B34F282;
  self.deathsdoorpulsenorm = 1;

  while(timer > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, _id_D75DFE2C8B34F282, timer);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    timer = timer - 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

shouldactivatedeathshield(damage) {
  if(scripts\engine\utility::flag_exist("disable_death_shield") && scripts\engine\utility::flag("disable_death_shield"))
    return 0;

  if(damageflag(1))
    return 0;

  if(damageflag(2))
    return 0;

  return 1;
}

damageflag(flag) {
  return isDefined(self.damage.flags) && self.damage.flags &flag;
}

setdamageflag(flag, _id_B96D126FC701024B) {
  if(_id_B96D126FC701024B)
    self.damage.flags = self.damage.flags | flag;
  else
    self.damage.flags = self.damage.flags &~flag;
}

initplayerdamagefunctions() {
  initplayerentflags();
  initplayerdamage();
  self setclientomnvar("ui_gettocover_state", 0);
  self setclientomnvar("ui_gettocover_text", "game/get_to_cover");
}

initplayerentflags() {
  scripts\engine\utility::ent_flag_init("global_hint_in_use");
  scripts\engine\utility::ent_flag_init("player_zero_attacker_accuracy");
}

initplayerdamage() {
  self.damage = spawnStruct();
  self.damage.impactsfx = scripts\engine\utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
}

initdamageoverlay() {
  self.damage.overlay = newclienthudelem(self);
  self.damage.overlay.sort = 2;
  self.damage.overlay.x = 0;
  self.damage.overlay.y = 0;
  self.damage.overlay.alignx = "left";
  self.damage.overlay.aligny = "top";
  self.damage.overlay.foreground = 0;
  self.damage.overlay.horzalign = "fullscreen";
  self.damage.overlay.vertalign = "fullscreen";
  self.damage.overlay.alpha = 0;
  self.damage.overlay.enablehudlighting = 1;
  self.damage.overlay.lowresbackground = 1;
  self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
}

initfiredamageoverlay() {
  self.damage.firedamageoverlay = newclienthudelem(self);
  self.damage.firedamageoverlay.sort = -1;
  self.damage.firedamageoverlay.x = 0;
  self.damage.firedamageoverlay.y = 0;
  self.damage.firedamageoverlay.alignx = "left";
  self.damage.firedamageoverlay.aligny = "top";
  self.damage.firedamageoverlay.foreground = 0;
  self.damage.firedamageoverlay.horzalign = "fullscreen";
  self.damage.firedamageoverlay.vertalign = "fullscreen";
  self.damage.firedamageoverlay.alpha = 0;
  self.damage.firedamageoverlay.enablehudlighting = 1;
  self.damage.firedamageoverlay.lowresbackground = 1;
  self.damage.firedamageoverlay setshader("ui_player_pain_fire_overlay", 640, 480);
}

initfirepainoverlay() {
  self.damage.firepainoverlay = newclienthudelem(self);
  self.damage.firepainoverlay.sort = -2;
  self.damage.firepainoverlay.x = 0;
  self.damage.firepainoverlay.y = 0;
  self.damage.firepainoverlay.alignx = "left";
  self.damage.firepainoverlay.aligny = "top";
  self.damage.firepainoverlay.foreground = 0;
  self.damage.firepainoverlay.horzalign = "fullscreen";
  self.damage.firepainoverlay.vertalign = "fullscreen";
  self.damage.firepainoverlay.alpha = 0;
  self.damage.firepainoverlay.enablehudlighting = 1;
  self.damage.firepainoverlay.lowresbackground = 1;
  self.damage.firepainoverlay setshader("ui_player_pain_impact_overlay", 640, 480);
}

initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 0;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "left";
  self.damage.deathsdooroverlaypulse.aligny = "top";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

initbloodoverlay() {
  self.damage.bloodoverlay = newclienthudelem(self);
  self.damage.bloodoverlay.sort = 1;
  self.damage.bloodoverlay.x = 0;
  self.damage.bloodoverlay.y = 0;
  self.damage.bloodoverlay.alignx = "left";
  self.damage.bloodoverlay.aligny = "top";
  self.damage.bloodoverlay.foreground = 0;
  self.damage.bloodoverlay.horzalign = "fullscreen";
  self.damage.bloodoverlay.vertalign = "fullscreen";
  self.damage.bloodoverlay.alpha = 0;
  self.damage.bloodoverlay.enablehudlighting = 1;
  self.damage.bloodoverlay.lowresbackground = 1;
  self.damage.bloodoverlay setshader("ui_player_pain_blood_overlay", 640, 480);
}

damageui(damage, attacker, direction, point, type, _id_7178D1AB6020C7C2, inflictor) {
  childthread takecoverwarning(damage, attacker, direction, point, type);
}

takecoverwarning(damage, attacker, dir, point, type) {
  currenttime = gettime();

  if(shouldshowcoverwarning(currenttime)) {
    self setclientomnvar("ui_gettocover_state", 1);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 2);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 3);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 4);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 5);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 0);
  }
}

shouldshowcoverwarning(currenttime, damage) {
  level.shouldshowcoverwarning = 0;

  if(!level.shouldshowcoverwarning)
    return 0;

  if(isusingremotekillstreak())
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  if(!damageflag(1))
    return 0;

  if(damageflag(8))
    return 0;

  if(istrue(self.disabletakecoverwarning))
    return 0;

  return 1;
}

healthratio() {
  return self.health / self.maxhealth;
}

oldhealthregen(_id_D8A5120850E80915, healthratio) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self.selfdamaging) && self.selfdamaging)
    wait 0.2;

  if(scripts\cp\utility::ishealthregendisabled()) {
    return;
  }
  _id_7714B89C368A249E = spawnStruct();
  scripts\cp\utility::getregendata(_id_7714B89C368A249E);
  wait(_id_7714B89C368A249E.activatetime);
  time = gettime();

  for(;;) {
    _id_5E8799555F72FB99 = _id_0AFB7E332AEE4BF2::gethealthcap();
    _id_7714B89C368A249E = spawnStruct();
    scripts\cp\utility::getregendata(_id_7714B89C368A249E);
    healthratio = self.health / self.maxhealth;

    if(self.health < int(_id_5E8799555F72FB99)) {
      _id_EDF34A99C4635317 = int(self.health + _id_7714B89C368A249E.regenamount);

      if(_id_EDF34A99C4635317 > _id_5E8799555F72FB99)
        _id_EDF34A99C4635317 = _id_5E8799555F72FB99;

      self.health = _id_EDF34A99C4635317;
    } else
      break;

    scripts\engine\utility::waittill_any_timeout_1(_id_7714B89C368A249E.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level.playerinitinvulnerability))
    self[[level.playerinitinvulnerability]]();

  scripts\cp\utility::resetattackerlist();
}

core_health_regen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("faux_dead");
  level endon("game_ended");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("damage", "health_perk_upgrade", "force_regeneration", "relic_resume_health_regen");

    if(result == "force_regeneration") {
      regenerate_health();
      continue;
    }

    if(!scripts\cp\utility::canregenhealth()) {
      continue;
    }
    regen_delay();
    regenerate_health();
  }
}

regen_delay() {
  self endon("force_regeneration");
  _id_C9D3262A60835C51 = gethealthregendelay();
  wait(_id_C9D3262A60835C51);

  while(damageflag(2) || damageflag(32))
    waitframe();
}

regenerate_health() {
  _id_83C87E7E2846EDD5 = self.health;
  thread scripts\cp\utility::breathingmanager(gettime(), healthratio());

  while(self.health < self.maxhealth) {
    _id_024493F7B31ECFBD = gethealthregenpersecond();
    _id_C2DC95DA0D5F4AEB = _id_024493F7B31ECFBD * 0.05;
    _id_83C87E7E2846EDD5 = clamp(_id_83C87E7E2846EDD5 + _id_C2DC95DA0D5F4AEB, 0, self.maxhealth);
    set_normalhealth(_id_83C87E7E2846EDD5 / self.maxhealth);
    waitframe();
  }

  self notify("healed");
}

gethealthregenpersecond() {
  _id_B79930868F410231 = 1;

  if(istrue(self.adrenalinepoweractive))
    _id_B79930868F410231 = _id_B79930868F410231 * 10;
  else if(scripts\cp\utility::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    if(isDefined(self.consecutive_kills) && self.consecutive_kills > 2)
      _id_B79930868F410231 = _id_B79930868F410231 * 2;
  } else if(scripts\cp\utility::_hasperk("specialty_fast_health_regen"))
    _id_B79930868F410231 = _id_B79930868F410231 * 2;

  return _id_B79930868F410231 * self.gs.healthregenrate;
}

getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

gethealthregentime() {
  regenamount = self.maxhealth - self.health;
  _id_48C07CA96FBA732E = regenamount / gethealthregenpersecond();
  return _id_48C07CA96FBA732E;
}

gethealthregendelay() {
  return self.gs.healthregendelay;
}

set_normalhealth(_id_47237B9240451982) {
  self setnormalhealth(_id_47237B9240451982);
  self.lasthealth = self.health;
}

getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, amount, maxhealth, _id_CB15FA5174E71840, _id_BE7C04516C5D9CCD, _id_CA960A517459FE15, _id_8ACEB016BAAF67AF, _id_C14F0ED27327131A) {
  amount = handleshotgundamage(objweapon, meansofdeath, amount);
  amount = handleapdamage(objweapon, meansofdeath, amount, attacker);
  _id_C8DB68AF3CDD6DA3 = objweapon.isalternatemode;
  _id_D5E541FF0F6C2578 = 0;
  _id_F1563935AEEB5199 = undefined;

  if(meansofdeath != "MOD_MELEE") {
    switch (objweapon.basename) {
      case "cruise_proj_mp":
      case "nuke_mp":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        _id_F1563935AEEB5199 = 1;
        break;
      case "bradley_tow_proj_mp":
      case "bradley_tow_proj_ks_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_rpapa7_mp":
      case "at_mine_mp":
      case "emp_drone_non_player_mp":
      case "emp_drone_non_player_direct_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_juliet_mp":
      case "iw9_la_gromeo_mp":
      case "chopper_gunner_proj_mp":
      case "fuelstrike_proj_mp":
      case "gunship_hellfire_mp":
      case "hover_jet_proj_mp":
      case "gunship_105mm_mp":
        self.largeprojectiledamage = 1;
        _id_F1563935AEEB5199 = _id_CB15FA5174E71840;
        break;
      case "chopped_pickup_mp":
      case "overland_2016_mp":
      case "suv_1996_mp":
      case "patrol_boat_wkd_mp":
      case "patrol_boat_mp":
      case "jltv_mg_hsk_mp":
      case "jltv_mg_mp":
      case "jltv_hsk_mp":
      case "jltv_mp":
      case "rhib_mp":
      case "lighttank_mp":
      case "hoopty_truck_mp":
      case "van_mp":
      case "mrap_mp":
      case "cargo_truck_mg_mp":
      case "cargo_truck_mp":
      case "med_transport_mp":
      case "hoopty_mp":
      case "pickup_truck_mp":
      case "cop_car_mp":
      case "apc_rus_mp":
      case "large_transport_mp":
      case "atv_mp":
      case "tac_rover_mp":
      case "little_bird_mg_mp":
      case "little_bird_mp":
      case "technical_mp":
      case "white_phosphorus_proj_mp":
      case "suv_1996_wrecked_mp":
      case "emp_grenade_mp":
      case "iw9_tur_light_tank_mp":
      case "gunship_40mm_mp":
      case "toma_proj_mp":
        self.largeprojectiledamage = 1;
        _id_F1563935AEEB5199 = _id_BE7C04516C5D9CCD;
        break;
      case "semtex_mp":
      case "frag_grenade_mp":
      case "claymore_mp":
      case "at_mine_ap_mp":
      case "c4_mp":
      case "thermite_av_mp":
      case "gunship_25mm_mp":
      case "thermite_bolt_mp":
      case "pac_sentry_turret_mp":
      case "artillery_mp":
        self.largeprojectiledamage = 0;
        _id_F1563935AEEB5199 = _id_CA960A517459FE15;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    _id_F1563935AEEB5199 = _id_8ACEB016BAAF67AF;
  }

  if(isDefined(_id_C14F0ED27327131A))
    self.largeprojectiledamage = _id_C14F0ED27327131A;

  if(isDefined(_id_F1563935AEEB5199) && isDefined(meansofdeath) && (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_FIRE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_MELEE"))
    amount = ceil(maxhealth / _id_F1563935AEEB5199);

  _id_E688B198AA9A4B3F = 0;

  if(isDefined(attacker) && isDefined(self.owner) && !_id_E688B198AA9A4B3F) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;

    if(attacker == self.owner && !istrue(self.killoneshot))
      amount = ceil(amount / 2);
  }

  return int(amount);
}

packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags) {
  struct = spawnStruct();
  struct.attacker = attacker;
  struct.victim = victim;
  struct.damage = damage;
  struct.objweapon = objweapon;
  struct.meansofdeath = meansofdeath;
  struct.inflictor = inflictor;
  struct.point = point;
  struct.direction_vec = direction_vec;
  struct.modelname = modelname;
  struct.partname = partname;
  struct.hitloc = "none";
  struct.timeoffset = 150;
  struct.tagname = tagname;
  struct.idflags = idflags;
  struct.damageflags = idflags;
  struct._id_E49F474E00FA0BB4 = istrue(isDefined(victim) && isPlayer(victim));
  struct.attacker.assistedsuicide = 0;
  return struct;
}

shoulduseexplosiveindicator(smeansofdeath) {
  return smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_FIRE";
}

_id_7A79B89781452FF9() {
  self notify("snakecam_cleanupVarAfterFrame");
  self endon("snakecam_cleanupVarAfterFrame");

  if(istrue(self._id_C1617124D4EE7E97)) {
    return;
  }
  self._id_C1617124D4EE7E97 = 1;
  self waittill("player_left_cam");
  waittillframeend;
  self._id_C1617124D4EE7E97 = undefined;
}

playerkilled_internal(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  victim endon("spawned");
  victim endon("disconnect");
  level endon("game_ended");

  if(game["state"] == "postgame") {
    return;
  }
  _id_642470E1ABC1BBF9 = victim _id_0AFB7E332AEE4BF2::playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath);
  _id_0AFB7E332AEE4BF2::playerkilled_parameterfixup(_id_642470E1ABC1BBF9);
  _id_0AFB7E332AEE4BF2::playerkilled_precalc(_id_642470E1ABC1BBF9);
  playerkilled_sharedlogic_early(_id_642470E1ABC1BBF9);
  playerkilled_handledeathtype(_id_642470E1ABC1BBF9);
  playerkilled_sharedlogic_late(_id_642470E1ABC1BBF9);
  playerkilled_spawn(_id_642470E1ABC1BBF9);
}

playerkilled_sharedlogic_early(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  damage = _id_642470E1ABC1BBF9.damage;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  isfauxdeath = _id_642470E1ABC1BBF9.isfauxdeath;
  hitloc = _id_642470E1ABC1BBF9.hitloc;
  direction_vec = _id_642470E1ABC1BBF9.direction_vec;
  victim notify("killed_player");
  victim showuidamageflash();
  victim setblurforplayer(0, 0);
  scripts\cp\cp_outofbounds::clearoob(victim, 1);
  victim scripts\cp\powers\coop_molotov::molotov_clear_fx();
  scripts\cp\utility::printgameaction("death", victim);
  victim scripts\cp\utility::launchshield(damage, meansofdeath);

  if(isDefined(attacker.petwatch) && attacker != victim) {
    attacker scripts\cp_mp\pet_watch::addkillcharge();

    if(meansofdeath == "MOD_EXECUTION")
      attacker scripts\cp_mp\pet_watch::addexecutioncharge();
    else if(victim playerkilled_washitbyvehicle(meansofdeath, inflictor))
      attacker scripts\cp_mp\pet_watch::addvehicularmanslaughtercharge();
  }

  if(meansofdeath == "MOD_EXECUTION") {
    attacker _id_293BC33BD79CABD1::incpersstat("executionKills", 1);
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "flavor_execution", undefined, 1.0);
  }

  _id_647F0CEC5589B0CA = victim getcurrentweapon();

  if(!victim _id_2669878CF5A1B6BC::iskillstreakweapon(_id_647F0CEC5589B0CA)) {}

  if(istrue(level._id_2DCE4D6DCB6C3FB9)) {
    scripts\cp\utility::store_weapons_status(level._id_D5AB05B7947DE15A, 1);
    _id_1DB8D0E02A99C5E2::_id_7C70DC615DA72C51();
  }

  victim scripts\cp\equipment\nvg::savenvgstate();

  if(!isfauxdeath) {
    if(isDefined(victim.endgame))
      scripts\cp\utility\player::restorebasevisionset(2);
    else {
      scripts\cp\utility\player::restorebasevisionset(0);
      victim thermalvisionoff();
    }
  } else {
    victim.fauxdead = 1;
    victim sethidenameplate(1);
    self notify("death");
    self notify("death_or_disconnect");
  }

  if(meansofdeath != "MOD_HEAD_SHOT" && !_id_642470E1ABC1BBF9.isnukekill) {
    if(isDefined(level.custom_death_sound))
      [[level.custom_death_sound]](victim, meansofdeath, inflictor);
    else if(meansofdeath != "MOD_MELEE")
      victim scripts\cp\utility::playdeathsound();
  }

  if(isDefined(level.custom_death_effect))
    [[level.custom_death_effect]](victim, meansofdeath, inflictor);

  if(scripts\cp\utility::gameflag("prematch_done") && !istrue(victim.hvtnorevive) && istrue(victim.inlaststand))
    thread _id_0AFB7E332AEE4BF2::ondeath(_id_642470E1ABC1BBF9);

  if(scripts\cp\utility::gameflag("prematch_done")) {
    _id_85A40249B07BE68E = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(!_id_85A40249B07BE68E) {} else
      respawnitems = self.juggcontext;
  }

  if(!isfauxdeath)
    victim scripts\cp\utility::updatesessionstate("dead");

  _id_63C3344D9C1F9816 = istrue(victim.fauxdead) && istrue(victim.switching_teams);

  if(!_id_63C3344D9C1F9816) {
    if(!isDefined(level.modemayconsiderplayerdead) || [[level.modemayconsiderplayerdead]](victim)) {}
  }

  _id_4115733AAA384EEA = meansofdeath;

  if(isDefined(_id_642470E1ABC1BBF9.idflags) && _id_642470E1ABC1BBF9.idflags &level.idflags_penetration && !(_id_642470E1ABC1BBF9.idflags &level.idflags_penetration_player_only)) {
    if(isDefined(attacker.bulletkillsinaframecount) && attacker.bulletkillsinaframecount == 0)
      _id_4115733AAA384EEA = "MOD_PENETRATION";
  } else if(objweapon.basename == "semtex_xmike109_mp" && _id_642470E1ABC1BBF9.hitloc == "head" || _id_642470E1ABC1BBF9.hitloc == "helmet")
    _id_4115733AAA384EEA = "MOD_HEAD_SHOT";

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor.iswztrain))
    _id_4115733AAA384EEA = "MOD_CRUSH";

  victim scripts\cp\cp_player_battlechatter::onplayerkilled(inflictor, attacker, damage, meansofdeath, objweapon, _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, _id_642470E1ABC1BBF9.deathanimduration, _id_642470E1ABC1BBF9.lifeid);
  _id_D34B50843AA65C42 = (_id_642470E1ABC1BBF9.deathtime - victim.spawntime) / 1000;
}

playerkilled_washitbyvehicle(meansofdeath, inflictor) {
  if(meansofdeath != "MOD_CRUSH")
    return 0;

  if(!isDefined(inflictor))
    return 0;

  if(!inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  return 1;
}

showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

playerkilled_handledeathtype(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  _id_642470E1ABC1BBF9.deathtype = playerkilled_finddeathtype(_id_642470E1ABC1BBF9);
  level notify("player_death", victim, _id_642470E1ABC1BBF9.deathtype);

  switch (_id_642470E1ABC1BBF9.deathtype) {
    case "deathType_worldDeath":
      handleworlddeath(_id_642470E1ABC1BBF9, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.hitloc);
      break;
    case "deathType_suicide":
      handlesuicidedeath(_id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.hitloc);
      break;
    case "deathType_inLastStand":
      handleinlaststanddeath(_id_642470E1ABC1BBF9);
      break;
    case "deathType_normal":
      handlenormaldeath(_id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath, victim, _id_642470E1ABC1BBF9.iskillstreakweapon, _id_642470E1ABC1BBF9);
      break;
    default:
      break;
  }
}

playerkilled_finddeathtype(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;

  if(isDefined(meansofdeath) && meansofdeath == "MOD_TRIGGER_HURT" && !isPlayer(attacker))
    return "deathType_normal";
  else if(!isPlayer(attacker) || isPlayer(attacker) && meansofdeath == "MOD_FALLING")
    return "deathType_worldDeath";
  else if(attacker == victim)
    return "deathType_suicide";
  else if(_id_642470E1ABC1BBF9.isfriendlyfire && _id_642470E1ABC1BBF9.objweapon.basename != "bomb_site_mp" && !_id_642470E1ABC1BBF9.isnukekill)
    return "deathType_friendlyFire";
  else if(istrue(victim.inlaststand))
    return "deathType_inLastStand";
  else
    return "deathType_normal";
}

handleinlaststanddeath(_id_642470E1ABC1BBF9) {
  _id_498A2226E5AA47EE = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(!istrue(_id_642470E1ABC1BBF9.victim.disable_killcam)) {}

  if(!_id_642470E1ABC1BBF9.iskillstreakweapon)
    _id_642470E1ABC1BBF9.attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_04B2FAAEAB2B30DB", _id_642470E1ABC1BBF9.objweapon, undefined, undefined, _id_642470E1ABC1BBF9.victim);

  if(isDefined(self.laststandattacker) && _id_642470E1ABC1BBF9.attacker != self.laststandattacker) {
    thread scripts\cp_mp\challenges::onplayerkilled(self.laststandattacker, self.laststandattacker, 0, _id_642470E1ABC1BBF9.damageflags, self.laststandmeansofdeath, self.laststandweaponobj, _id_642470E1ABC1BBF9.hitloc, self.laststandattackermodifiers);
    self.laststandattacker thread _id_187A04151C40FB72::scoreeventpopup("stat_E24741BA71BBB56B");
  }

  handlenormaldeath(_id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath, self, _id_642470E1ABC1BBF9.iskillstreakweapon, _id_642470E1ABC1BBF9, 1);
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststandattackermodifiers = undefined;
}

handlenormaldeath(lifeid, attacker, einflictor, objweapon, smeansofdeath, victim, iskillstreakweapon, _id_642470E1ABC1BBF9, _id_C7944407E05A6F77) {
  if(smeansofdeath == "MOD_GRENADE" && einflictor == attacker)
    _id_6F1E07CE9FF97D5F::addattacker(victim, attacker, einflictor, objweapon, _id_642470E1ABC1BBF9.damage, (0, 0, 0), _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, smeansofdeath);

  _id_642470E1ABC1BBF9.dokillcam = 0;

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"]))
    _id_642470E1ABC1BBF9.dokillcam = victim[[level.bot_funcs["should_do_killcam"]]]();

  if(istrue(level.disable_killcam) || istrue(victim.disable_killcam))
    _id_642470E1ABC1BBF9.dokillcam = 0;

  if(isDefined(einflictor) && istrue(einflictor._id_26FB072855FD4772)) {
    return;
  }
  if(isPlayer(attacker))
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor);

  _id_D2DB6CB7F6D5D36D = attacker;

  if(isDefined(attacker.commanding_bot))
    _id_D2DB6CB7F6D5D36D = attacker.commanding_bot;

  if(isDefined(_id_D2DB6CB7F6D5D36D.pers) && !istrue(_id_D2DB6CB7F6D5D36D.pers["ignoreWeaponMatchBonus"]) && (_id_74502A9E0EF1F19C::iscacprimaryweapon(objweapon) || _id_74502A9E0EF1F19C::iscacsecondaryweapon(objweapon))) {
    if(!isDefined(_id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"]))
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] = 1;
    else
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"]++;

    if(_id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] > scripts\cp\cp_weaponrank::getgametypekillspermatchmaximum()) {
      _id_D2DB6CB7F6D5D36D.pers["ignoreWeaponMatchBonus"] = 1;
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] = undefined;
      _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"] = undefined;
    } else {
      if(!isDefined(_id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"]))
        _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"] = [];

      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_B590DD50C4FE1F77 = 0;

      foreach(_id_5DC27A5BF459C504, data in _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"]) {
        if(_id_5DC27A5BF459C504 == _id_AB501F397D3CD312) {
          data.killcount++;
          _id_B590DD50C4FE1F77 = 1;
          break;
        }
      }

      if(!_id_B590DD50C4FE1F77) {
        data = spawnStruct();
        data.killcount = 1;
        data.basename = objweapon.basename;
        data.orderindex = _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"].size;
        _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"][_id_AB501F397D3CD312] = data;
      }
    }
  }

  _id_90AB65120E5446C7 = undefined;

  if(isDefined(attacker.pers)) {
    _id_90AB65120E5446C7 = attacker.pers["cur_kill_streak"];
    attacker.pers["cur_death_streak"] = 0;
  }

  if(!iskillstreakweapon && !_id_293BC33BD79CABD1::iskillstreakvehicleinflictor(einflictor) || _id_41AE4F5CA24216CB::isforcekillstreakprogressweapon(objweapon)) {
    attacker thread _id_293BC33BD79CABD1::killeventtextpopup("stat_EF9582D72160F199", 0);
    _id_4D407FE4BF2C6305 = undefined;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done"))
      _id_4D407FE4BF2C6305 = 100;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("kill", objweapon, _id_4D407FE4BF2C6305, undefined, victim);
  }

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == attacker)
    level notify("ai_killed", self);

  attacker notify("killed_enemy");

  if(istrue(attacker.inlaststand))
    attacker thread _id_0AFB7E332AEE4BF2::onlaststandkillenemy(_id_642470E1ABC1BBF9);

  if(isDefined(level.onnormaldeath) && (isDefined(attacker.pers) && attacker.pers["team"] != "spectator") && !istrue(level.ignorescoring))
    self[[level.onnormaldeath]]();

  if(!attacker scripts\cp\utility::isusingremote()) {
    weaponlist = victim getweaponslistprimaries();
    _id_5D4277E0C084DE15 = 0;

    foreach(weapon in weaponlist) {
      if(weaponclass(weapon.basename) == "sniper") {
        _id_5D4277E0C084DE15 = 1;
        break;
      }
    }

    if(_id_5D4277E0C084DE15)
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "stat_2EE580BBE139941A", undefined, 0.75);
    else
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "stat_29C83D721F765AB4", undefined, 0.75);
  }

  _id_5A127424B8DF87B6 = undefined;

  if(isDefined(_id_5A127424B8DF87B6))
    level thread scripts\cp\cp_player_battlechatter::saytoself(attacker, _id_5A127424B8DF87B6, "plr_killfirm_generic", 0.75);
}

handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor) {
  _id_E08E0D086A79892B = 0;
  ent = victim;

  if(!isDefined(attacker.lastkillalertsoundtime)) {
    attacker.lastkillalertsoundtime = gettime();
    _id_E08E0D086A79892B = 1;
  } else if(gettime() > attacker.lastkillalertsoundtime + 700) {
    attacker.lastkillalertsoundtime = gettime();
    _id_E08E0D086A79892B = 1;
  }

  if(_id_80ADE967129C9845()) {} else if(isagent(attacker)) {
    if(!scripts\engine\utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {} else if(smeansofdeath == "MOD_HEAD_SHOT") {
      ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
      ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    } else
      ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
  } else if(!scripts\engine\utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {
    if(_id_E08E0D086A79892B && !scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      ent playsoundtoplayer("mp_kill_alert_quiet", attacker);
  } else if(smeansofdeath == "MOD_HEAD_SHOT") {
    ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
    ent playsoundtoplayer("bullet_impact_headshot", attacker);

    if(_id_E08E0D086A79892B)
      ent playsoundtoplayer("mp_headshot_alert", attacker);

    ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);

    if(_id_E08E0D086A79892B)
      ent playsoundtoplayer("mp_kill_alert", attacker);
  }

  if(isPlayer(victim)) {
    if(smeansofdeath != "MOD_EXECUTION")
      victim playlocalsound("deaths_door_death");

    victim clearsoundsubmix("deaths_door_mp", 2);
    victim.deathsdoor = 0;
  }
}

_id_80ADE967129C9845() {
  return istrue(level._id_57ECE26E490AD8C4);
}

playerkilled_sharedlogic_late(_id_642470E1ABC1BBF9) {
  playerkilled_handlecorpse(_id_642470E1ABC1BBF9);
  setdeathtimerlength(_id_642470E1ABC1BBF9);
  attacker = _id_642470E1ABC1BBF9.attacker;

  if(isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!isPlayer(attacker)) {
    _id_642470E1ABC1BBF9.dokillcam = 0;
    _id_642470E1ABC1BBF9.dofinalkillcam = 0;
  }

  thread scripts\cp_mp\challenges::ondeath(_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.damage, _id_642470E1ABC1BBF9.damageflags, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.attacker.modifiers);
}

playerkilled_handlecorpse(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  scripts\cp_mp\vehicles\vehicle::vehicle_playerkilledbycollision(_id_642470E1ABC1BBF9);

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse)) {
    if(isDefined(victim.body)) {
      victim.body delete();
      victim.body = undefined;
    }

    victim.body = victim cloneplayer(_id_642470E1ABC1BBF9.deathanimduration, attacker);
  }

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse) && isDefined(victim.body)) {
    victim.body.targetname = "player_corpse";

    if(_id_642470E1ABC1BBF9.isnukekill) {}

    enqueueweapononkillcorpsetablefuncs(attacker, victim, inflictor, objweapon, meansofdeath);
    victim thread callcorpsetablefuncs();

    if(_id_642470E1ABC1BBF9.isfauxdeath) {
      victim scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      victim setsolid(0);
    }

    if(!isDefined(victim.switching_teams)) {
      _id_E707F0032FA7B4BB = [];

      foreach(index, player in level.players) {
        if(isDefined(victim) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, victim)) && player scripts\cp\utility::_hasperk("specialty_kill_report"))
          _id_E707F0032FA7B4BB[index] = player;
      }

      if(_id_E707F0032FA7B4BB.size > 0) {}
    }

    victim thread _startragdoll(_id_642470E1ABC1BBF9.victim.body, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.inflictor);
  } else if(isDefined(victim.nocorpse) && !istrue(victim.skipcorpse)) {
    if(isDefined(victim.body)) {
      victim.body delete();
      victim.body = undefined;
    }

    victim.body = victim cloneplayer(_id_642470E1ABC1BBF9.deathanimduration);
    victim.body hide(1);
  }

  if(!istrue(game["isLaunchChunk"]))
    return;
}

enqueueweapononkillcorpsetablefuncs(attacker, victim, inflictor, objweapon, meansofdeath) {}

callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }
  _id_3741EA5B9FB53EC3 = self.body;

  foreach(func in self.corpsetablefuncs)
  self thread[[func]](_id_3741EA5B9FB53EC3);

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

setdeathtimerlength(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  _id_D8D2129EFF08B4B1 = 0;

  if(victim mayspawn()) {
    timeuntilspawn = timeuntilspawn(1);
    _id_906A882502DD814A = 2.25;
    _id_0B5C34C3BC6C7E65 = 1;
    timeuntilspawn = max(timeuntilspawn + _id_0B5C34C3BC6C7E65, _id_906A882502DD814A);
    _id_D8D2129EFF08B4B1 = timeuntilspawn + _id_642470E1ABC1BBF9.deathscenetimesec;
  }

  victim.death_timer_length = int(_id_D8D2129EFF08B4B1 * 10);
}

mayspawn() {
  if(istrue(level.nukeinfo._id_F30E30BC8F212949))
    return 0;

  if(getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1)
      return 1;

    if(istrue(level.disablespawning)) {
      if(!isdevelopmentspawningofbotclient(self))
        return 0;
    }

    if(istrue(self.pers["teamKillPunish"]))
      return 0;

    if(gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned)
        return 1;

      if(!level.ingraceperiod && !self.hasspawned && (isDefined(level.allowlatecomers) && !level.allowlatecomers)) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer)
          return 1;

        if(isdevelopmentspawningofbotclient(self))
          return 1;

        return 0;
      }
    }
  }

  if(isDefined(level.disablespawningforplayerfunc) && [[level.disablespawningforplayerfunc]](self))
    return 0;

  return 1;
}

getgametypenumlives() {
  return 1;
}

isdevelopmentspawningofbotclient(_id_2C6CA80E296FED3A) {
  return 0;
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted))
    return level.gamehasstarted;

  foreach(team in level.teamnamelist) {
    if(scripts\cp\cp_outline_utility::getteamdata(team, "hasSpawned"))
      return 1;
  }

  return 0;
}

timeuntilspawn(_id_E02F2CD6C285F5D1) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  respawndelay = 0;

  if(self.hasspawned) {
    if(isDefined(level.onrespawndelay)) {
      result = self[[level.onrespawndelay]]();

      if(isDefined(result))
        respawndelay = result;
      else
        respawndelay = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_playerrespawndelay"));
    } else
      respawndelay = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_playerrespawndelay"));

    if(isDefined(self.suicidespawndelay))
      respawndelay = respawndelay + getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_suicidespawndelay"));

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      _id_4B0EB3DD662207F4 = (gettime() - self.respawntimerstarttime) / 1000.0;
      respawndelay = respawndelay - _id_4B0EB3DD662207F4;

      if(respawndelay < 0)
        respawndelay = 0;
    }

    if(isDefined(self.setspawnpoint))
      respawndelay = respawndelay + level.tispawndelay;
  }

  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    respawndelay = 0;
  else if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 1)
    respawndelay = 999.0;

  if(!isDefined(self._id_DB03AE1B2B480308))
    self._id_DB03AE1B2B480308 = respawndelay;

  return respawndelay;
}

playerkilled_deathscene(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  victim endon("spawned");

  if(!_id_642470E1ABC1BBF9.isfauxdeath) {
    if(!isDefined(victim.respawntimerstarttime))
      victim.respawntimerstarttime = gettime() + _id_642470E1ABC1BBF9.deathscenetimems;

    wait(_id_642470E1ABC1BBF9.deathscenetimesec);

    if(_id_642470E1ABC1BBF9.dokillcam) {}

    victim notify("death_delay_finished");
  } else if(!isDefined(victim.respawntimerstarttime))
    victim.respawntimerstarttime = gettime();
}

playerkilled_spawn(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  victim endon("spawned");
  victim endon("disconnect");
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim resetplayervariables();
  victim resetplayeromnvarsonspawn();

  if(isDefined(level.modeplayerkilledspawn) && [[level.modeplayerkilledspawn]](_id_642470E1ABC1BBF9)) {
    return;
  }
  if(isDefined(attacker))
    victim.lastattacker = attacker;
  else
    victim.lastattacker = undefined;

  victim.wantsafespawn = 0;

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam)
      victim scripts\cp\utility::updatesessionstate("dead");

    return;
  }

  _id_0AFB7E332AEE4BF2::_id_0449348B412E6B21(victim, victim);
  _id_546519C4D54162CC = 3;

  if(isDefined(victim._id_EC2E7871FEB66A8E))
    _id_546519C4D54162CC = victim._id_EC2E7871FEB66A8E;

  victim thread _id_116171939929AF39::spawnplayer(undefined, _id_546519C4D54162CC);
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.inlaststand = 0;
  self.pers["cur_kill_streak"] = 0;
  self.killcountthislife = 0;
  detachusemodels();
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

resetplayeromnvarsonspawn() {
  resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode))
    [[level.resetuiomnvargamemode]]();

  self setclientomnvar("ui_objective_pinned_text_param", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_is_laststand", 0);
  self setclientomnvar("swim_breath_meter_critical", 0);
}

modifyteamdata(team, _id_8E9EF05D6E84968C, value) {
  level.teamdata[team][_id_8E9EF05D6E84968C] = level.teamdata[team][_id_8E9EF05D6E84968C] + value;
}

handleworlddeath(_id_642470E1ABC1BBF9, attacker, lifeid, smeansofdeath, shitloc) {
  victim = _id_642470E1ABC1BBF9.victim;
  victim.deathspectatepos = victim.origin;

  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(attacker.team) || attacker.team == "neutral") {
    handlesuicidedeath(smeansofdeath, shitloc, 1);
    return;
  }

  if(level.teambased && attacker.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(attacker) || isagent(attacker)) && attacker.team != "spectator" || isDefined(attacker._id_ACB55A437C3145C0)) {
      if(!level.gameended)
        self[[level.onnormaldeath]](attacker, lifeid, smeansofdeath);
    }
  }

  if(isagent(attacker))
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath);
}

handlesuicidedeath(smeansofdeath, shitloc, _id_11E39010477B79E4) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "handleSuicideDeath"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "handleSuicideDeath")]](_id_11E39010477B79E4);
  else {
    self.respawn_forcespawnorigin = self.origin;
    self.respawn_forcespawnangles = self getplayerangles(1);
    onsuicidedeath(self);
    self.suicidespawndelay = 1;

    if(isDefined(self.friendlydamage))
      self.friendlyfiredeath = 1;
  }
}

onsuicidedeath(victim) {
  if(!level.teambased) {
    _id_677AE66DF2125F53 = scripts\cp\utility::get_array_of_valid_players();
    victim.score = level.totalplayers - _id_677AE66DF2125F53.size;

    foreach(player in _id_677AE66DF2125F53)
    player.score = victim.score + 1;
  } else if(scripts\cp\utility::gameflag("prematch_done"))
    return;
}

gamemodemodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  if(isDefined(eattacker) && isPlayer(eattacker) && isalive(eattacker)) {
    if(istrue(level.matchrules_damagemultiplier))
      idamage = idamage * level.matchrules_damagemultiplier;

    if(istrue(level.matchrules_vampirism)) {
      eattacker.health = int(min(float(eattacker.maxhealth), min(eattacker.health + idamage, float(eattacker.health + 20))));
      eattacker notify("vampirism");
    }

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19() && !isspreadweapon(objweapon)) {
      switch (shitloc) {
        case "neck":
        case "head":
        case "helmet":
          idamage = victim.maxhealth;

          if(isDefined(victim._id_8790C077C95DB752))
            idamage = idamage + victim._id_8790C077C95DB752;

          break;
        default:
          break;
      }
    }
  }

  return idamage;
}

isspreadweapon(objweapon) {
  return isDefined(objweapon) && weaponclass(objweapon) == "spread";
}

_id_E20F17E2A9D0C792(meansofdeath) {
  if(isDefined(meansofdeath) && (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_FIRE" || meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_MELEE"))
    return 1;
  else
    return 0;
}