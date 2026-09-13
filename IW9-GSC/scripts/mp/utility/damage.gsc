/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\damage.gsc
***********************************************/

get_damageable_player(player, _id_1925D24D0AE333E6) {
  _id_0E14905A4CDF3B12 = spawnStruct();
  _id_0E14905A4CDF3B12.isplayer = 1;
  _id_0E14905A4CDF3B12.isadestructable = 0;
  _id_0E14905A4CDF3B12.entity = player;
  _id_0E14905A4CDF3B12.damagecenter = _id_1925D24D0AE333E6;
  return _id_0E14905A4CDF3B12;
}

get_damageable_sentry(sentry, _id_CFEE6503C350B4E4) {
  _id_0E14905A4CDF3B12 = spawnStruct();
  _id_0E14905A4CDF3B12.isplayer = 0;
  _id_0E14905A4CDF3B12.isadestructable = 0;
  _id_0E14905A4CDF3B12.issentry = 1;
  _id_0E14905A4CDF3B12.entity = sentry;
  _id_0E14905A4CDF3B12.damagecenter = _id_CFEE6503C350B4E4;
  return _id_0E14905A4CDF3B12;
}

get_damageable_grenade(grenade, _id_D3366E54CC41EA6C) {
  _id_0E14905A4CDF3B12 = spawnStruct();
  _id_0E14905A4CDF3B12.isplayer = 0;
  _id_0E14905A4CDF3B12.isadestructable = 0;
  _id_0E14905A4CDF3B12.entity = grenade;
  _id_0E14905A4CDF3B12.damagecenter = _id_D3366E54CC41EA6C;
  return _id_0E14905A4CDF3B12;
}

get_damageable_mine(mine, _id_D3366E54CC41EA6C) {
  _id_0E14905A4CDF3B12 = spawnStruct();
  _id_0E14905A4CDF3B12.isplayer = 0;
  _id_0E14905A4CDF3B12.isadestructable = 0;
  _id_0E14905A4CDF3B12.entity = mine;
  _id_0E14905A4CDF3B12.damagecenter = _id_D3366E54CC41EA6C;
  return _id_0E14905A4CDF3B12;
}

get_damageable_player_pos(player) {
  return player.origin + (0, 0, 32);
}

get_damageable_grenade_pos(grenade) {
  return grenade.origin;
}

istacticaldamage(objweapon, smeansofdeath) {
  if(!isDefined(objweapon))
    return 0;

  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_IMPACT")
    return 0;

  switch (objweapon.basename) {
    case "blackout_grenade_mp":
    case "cryo_mine_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_mp":
      return 0;
    default:
      return 0;
  }
}

_id_04766094B15B00A8(weapon, smeansofdeath, attacker) {
  _id_27E27C2E96F2389D = 0;

  if(scripts\cp_mp\utility\weapon_utility::isbulletweapon(weapon)) {
    if(isDefined(attacker) && attacker scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_incendiary"))
      _id_27E27C2E96F2389D = 1;

    if(isDefined(weapon) && scripts\cp_mp\dragonsbreath::_id_0CFD2E1E48EDAF93(weapon))
      _id_27E27C2E96F2389D = 1;
  }

  return _id_27E27C2E96F2389D;
}

_id_E287831520AA308B(weapon, attacker) {
  _id_A167B7E09AC43F5E = 0;

  if(scripts\cp_mp\utility\weapon_utility::isbulletweapon(weapon)) {
    if(isDefined(attacker) && attacker scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_explosivebullet"))
      _id_A167B7E09AC43F5E = 1;
  }

  return _id_A167B7E09AC43F5E;
}

isfmjdamage(weapon, smeansofdeath) {
  _id_5766EB92B7841776 = 0;

  if(isDefined(weapon) && isDefined(smeansofdeath) && scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    if(_func_F30A6D3194F97C09(weapon, "specialty_armorpiercing"))
      _id_5766EB92B7841776 = 1;
  }

  return _id_5766EB92B7841776;
}

_id_73D1D5D600A0CBC3(smeansofdeath, attacker) {
  if(!isDefined(attacker) || !isPlayer(attacker))
    return 0;

  return scripts\engine\utility::isbulletdamage(smeansofdeath) && attacker _id_4BEF961309209288::_id_1DA49FB6441F8AB2();
}

_id_3201A1BC3FF0E482(attacker, victim, smeansofdeath, idflags) {
  _id_30D384DA73217E13 = _id_73D1D5D600A0CBC3(smeansofdeath, attacker);

  if(istrue(_id_30D384DA73217E13)) {
    if(isPlayer(victim) || isagent(victim)) {
      if(_id_07C40FA80892A721::isbulletpenetration(idflags))
        return 1;

      if(isDefined(victim.vehicle))
        return 1;

      if(victim _id_07C40FA80892A721::hasarmor())
        return 1;

      if(istrue(victim.isjuggernaut))
        return 1;
    }
  }

  return 0;
}

islethalmeleeweapon(attacker, victim, objweapon, smeansofdeath) {
  if(smeansofdeath != "MOD_MELEE")
    return 0;

  if(!isDefined(victim) || !isPlayer(victim))
    return 0;

  if(victim scripts\mp\heavyarmor::hasheavyarmor())
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("one_hit_melee_victim"))
    return 0;

  if(scripts\mp\utility\weapon::isfistsonly(objweapon.basename))
    return 0;

  if(scripts\mp\utility\weapon::ismeleeoverrideweapon(objweapon))
    return 1;

  if(scripts\cp_mp\utility\weapon_utility::isknifeonly(objweapon.basename))
    return 1;

  if(scripts\mp\utility\weapon::isballweapon(objweapon))
    return 1;

  if(objweapon.basename == "iw8_defibrillator_mp")
    return 1;

  if(scripts\mp\utility\weapon::isaxeweapon(objweapon.basename) && attacker getweaponammoclip(objweapon) > 0)
    return 1;

  foreach(attachment in objweapon.attachments) {
    if(scripts\engine\utility::string_starts_with(attachment, "bayonet") || scripts\engine\utility::string_starts_with(attachment, "tacknife"))
      return 1;
  }

  return 0;
}

attackerishittingteam(victim, attacker) {
  if(isDefined(attacker) && isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!level.teambased)
    return 0;
  else if(!isDefined(attacker) || !isDefined(victim))
    return 0;
  else if(!isDefined(victim.team) || !isDefined(attacker.team))
    return 0;
  else if(victim == attacker)
    return 0;
  else if(scripts\mp\utility\game::getgametype() == "infect" && victim.pers["team"] == attacker.team && isDefined(attacker.teamchangedthisframe))
    return 0;
  else if(scripts\mp\utility\game::getgametype() == "infect" && victim.pers["team"] != attacker.team && isDefined(attacker.teamchangedthisframe))
    return 1;
  else if(isDefined(attacker.scrambled) && attacker.scrambled)
    return 0;
  else if(scripts\mp\utility\player::isplayerproxyagent(victim, attacker))
    return 0;
  else if(isagent(victim) && istrue(victim.skipfriendlyfire))
    return 0;
  else if(isagent(victim) && isDefined(victim.owner) && victim.owner == attacker)
    return 0;
  else if(_id_3583FF375AB3A91E::_id_C210E62F0B64CFB1(attacker, victim))
    return 0;
  else if(victim.team == attacker.team)
    return 1;
  else if(_id_3583FF375AB3A91E::_id_9EFAE38238E4DF66(attacker, victim))
    return 1;
  else if(_id_7CC9753F2F84E883(attacker, victim))
    return 1;
  else
    return 0;
}

_id_7CC9753F2F84E883(eattacker, victim) {
  return isDefined(eattacker) && isDefined(victim) && isPlayer(eattacker) && isPlayer(victim) && isDefined(eattacker._id_3E8AEB2A9E8D86D6) && isDefined(victim._id_3E8AEB2A9E8D86D6) && eattacker._id_3E8AEB2A9E8D86D6 == victim._id_3E8AEB2A9E8D86D6;
}

_validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive))
    return undefined;

  if(isagent(eattacker) && !isDefined(eattacker.classname))
    return undefined;

  return eattacker;
}

_validatevictim(victim) {
  if(!victim scripts\cp_mp\utility\player_utility::_isalive())
    return undefined;

  return victim;
}

damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, hitloc) {
  if(smeansofdeath == "MOD_GRENADE")
    return 1;

  if(smeansofdeath == "MOD_PROJECTILE")
    return 1;

  if((smeansofdeath == "MOD_FIRE" || isexplosivedamagemod(smeansofdeath)) == 0)
    return 1;

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && (!isDefined(hitloc) || hitloc != "none"))
    return 1;

  if(isDefined(attacker) && attacker == victim)
    return 1;

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, undefined, objweapon, smeansofdeath, inflictor);

  if(victim scripts\cp_mp\utility\damage_utility::isstuckdamage(data))
    return 1;

  if(scripts\mp\utility\weapon::weaponignoresblastshield(objweapon, hitloc))
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(victim) && istrue(victim.isjuggernaut) && isDefined(inflictor) && isDefined(inflictor.vehiclename))
    return 1;

  return 0;
}

_radiusdamage(origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon) {
  self radiusdamage(origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon);
}

radiusplayerdamage(origin, minradius, _id_5991EF3EA72A6543, mindamage, maxdamage, attacker, inflictor, meansofdeath, weaponname, _id_8E29956BE719CCEC) {
  if(!isDefined(_id_8E29956BE719CCEC))
    _id_8E29956BE719CCEC = 0;

  _id_F145A993614D298F = scripts\engine\trace::create_character_contents();
  castcontents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  ignorelist = [];

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(!isDefined(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(!_id_7DC3241E7F3C6B24 scripts\cp_mp\utility\player_utility::_isalive()) {
      ignorelist[ignorelist.size] = _id_7DC3241E7F3C6B24;
      continue;
    }

    if(_id_8E29956BE719CCEC && _id_7DC3241E7F3C6B24 == attacker) {
      ignorelist[ignorelist.size] = _id_7DC3241E7F3C6B24;
      continue;
    }

    if(level.teambased && _id_7DC3241E7F3C6B24.team == attacker.team)
      ignorelist[ignorelist.size] = _id_7DC3241E7F3C6B24;
  }

  _id_45724690F28D7899 = physics_querypoint(attacker.origin, _id_5991EF3EA72A6543, _id_F145A993614D298F, ignorelist, "physicsquery_all");

  if(isDefined(_id_45724690F28D7899) && _id_45724690F28D7899.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_45724690F28D7899.size; _id_AC0E594AC96AA3A8++) {
      ent = _id_45724690F28D7899[_id_AC0E594AC96AA3A8]["entity"];
      dist = _id_45724690F28D7899[_id_AC0E594AC96AA3A8]["distance"];
      point = _id_45724690F28D7899[_id_AC0E594AC96AA3A8]["position"];

      if(!isDefined(ent)) {
        continue;
      }
      _id_E021C2744CC7ED68 = physics_raycast(origin, point, castcontents, undefined, 0, "physicsquery_closest");

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        continue;
      }
      _id_AE3412F7B9B48D44 = max(dist, minradius) / _id_5991EF3EA72A6543;
      damage = mindamage + (maxdamage - mindamage) * _id_AE3412F7B9B48D44;
      ent dodamage(damage, origin, attacker, inflictor, meansofdeath, weaponname);
    }
  }
}

hashealthshield(player) {
  return isDefined(player) && isDefined(player.healthshield);
}

gethealthshielddamage(damage) {
  return int(damage * self.healthshieldmod);
}

sethealthshield(_id_5E2BB61A493095FD) {
  self.healthshield = 1;

  if(!isDefined(self.healthshieldmod))
    self.healthshieldmod = 1;

  _id_5E2BB61A493095FD = int(clamp(_id_5E2BB61A493095FD, 0, 100));
  _id_34985A43C94F1829 = (100 - _id_5E2BB61A493095FD) / 100;

  if(_id_34985A43C94F1829 < self.healthshieldmod)
    self.healthshieldmod = _id_34985A43C94F1829;
}

clearhealthshield() {
  self.healthshield = undefined;
  self.healthshieldmod = undefined;
}

_suicide(_id_4BFF266A15665FD9, _id_1044662D97E67562) {
  if(self.sessionstate != "playing") {
    return;
  }
  if(playershoulddofauxdeath(_id_4BFF266A15665FD9) && !isDefined(self.fauxdead))
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", nullweapon(), (0, 0, 0), "none", 0, 1116, 1);
  else if(!playershoulddofauxdeath(_id_4BFF266A15665FD9) && !isDefined(self.fauxdead) && (!isDefined(self.vehicle) || istrue(_id_1044662D97E67562)))
    self suicide();
}

suicide_on_end_remote() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  thread suicide_on_alive();
}

suicide_on_alive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("suicide_on_alive");
  self endon("suicide_on_alive");

  while(!scripts\mp\utility\player::isreallyalive(self) || self.sessionstate != "playing")
    waitframe();

  _suicide();
}

playershoulddofauxdeath(_id_4BFF266A15665FD9) {
  if(!isDefined(_id_4BFF266A15665FD9))
    _id_4BFF266A15665FD9 = 1;

  if(istrue(self.isusingcamera))
    return 0;

  if(istrue(_id_4BFF266A15665FD9) && scripts\mp\utility\player::isusingremote() && !scripts\mp\utility\game::islifelimited())
    return 1;

  if(isDefined(level.modeshoulddofauxdeathfunc) && self[[level.modeshoulddofauxdeathfunc]]())
    return 1;

  return 0;
}

isprojectiledamage(meansofdeath) {
  _id_7C02104B4AA99077 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(_id_7C02104B4AA99077, meansofdeath))
    return 1;

  return 0;
}

non_player_log_attacker_data(data, attacker) {
  if(data.damage == 0) {
    return;
  }
  if(!isDefined(attacker))
    attacker = data.attacker;

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    inflictor = data.inflictor;

    if(isDefined(inflictor)) {
      if(isPlayer(inflictor))
        attacker = inflictor;
      else
        attacker = inflictor.owner;
    } else
      attacker = undefined;
  }

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }
  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))
      return;
  } else if(level.teambased && isDefined(self.team) && self.team == attacker.team) {
    return;
  }
  non_player_add_attacker_data(data, attacker);
}

non_player_add_attacker_data(data, attacker) {
  if(!isDefined(attacker))
    attacker = data.attacker;

  firsttimedamaged = undefined;
  attackerdata = non_player_get_attacker_data(attacker);

  if(!isDefined(attackerdata)) {
    attackerdata = non_player_get_attacker_data(attacker, 1);
    firsttimedamaged = gettime();
  }

  attackerdata.damage = attackerdata.damage + data.damage;
  attackerdata.objweapon = data.objweapon;
  attackerdata.point = data.point;
  attackerdata.direction = data.direction_vec;
  attackerdata.partname = data.partname;
  attackerdata.meansofdeath = data.meansofdeath;
  attackerdata.firsttimedamaged = scripts\engine\utility::ter_op(isDefined(firsttimedamaged), firsttimedamaged, attackerdata.firsttimedamaged);
  attackerdata _id_6A5D3BF7A5B7064A::_id_F74C4C476C9489F6();
  attackerdata.lasttimedamaged = gettime();
}

non_player_get_attacker_data(attacker, create) {
  attackerdata = undefined;

  if(!isDefined(self.attackerdata) && istrue(create))
    self.attackerdata = [];

  if(isDefined(self.attackerdata)) {
    guid = attacker.guid;

    if(isDefined(guid)) {
      attackerdata = self.attackerdata[guid];

      if(isDefined(attackerdata)) {
        if(attackerdata.isvalid || level.teambased && attacker.team != attackerdata.team) {
          attackerdata = undefined;
          self.attackerdata[guid] = undefined;
        }
      }

      if(!isDefined(attackerdata) && istrue(create)) {
        attackerdata = spawnStruct();
        attackerdata.attacker = attacker;
        attackerdata.team = attacker.team;
        attackerdata.guid = guid;
        attackerdata.isvalid = 1;
        attackerdata.damage = 0;
        attackerdata.hitcount = 0;
        attackerdata.firsttimehit = gettime();
        self.attackerdata[guid] = attackerdata;
      }
    }
  }

  return attackerdata;
}

non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath) {
  if(non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath))
    return 1;

  if(isDefined(objweapon.basename)) {
    if(meansofdeath != "MOD_MELEE") {
      switch (objweapon.basename) {
        case "iw9_laser_large_ir_mp":
        case "iw9_spotter_scope_mp":
          return 1;
      }
    }

    if(meansofdeath == "MOD_IMPACT") {
      switch (objweapon.basename) {
        case "semtex_mp":
        case "claymore_mp":
        case "at_mine_mp":
        case "c4_mp":
        case "bunkerbuster_mp":
        case "thermite_mp":
          return 1;
      }
    } else {
      switch (objweapon.basename) {
        case "gas_grenade_mp":
        case "butcher_shout_mp":
        case "butcher_slam_mp":
        case "butcher_headbutt_mp":
        case "emp_drone_player_mp":
        case "snapshot_grenade_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
        case "thermite_ap_mp":
          return 1;
      }
    }
  }

  return 0;
}

non_player_add_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamageid))
    self.ignoredamageid = 0;

  if(!isDefined(self.ignoredamagesignatures))
    self.ignoredamagesignatures = [];

  id = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(objweapon) && isstring(objweapon))
    objweapon = makeweapon(objweapon);

  _id_9A967AA676F4B959 = spawnStruct();
  _id_9A967AA676F4B959.id = id;
  _id_9A967AA676F4B959.attacker = attacker;
  _id_9A967AA676F4B959.objweapon = objweapon;
  _id_9A967AA676F4B959.inflictor = inflictor;
  _id_9A967AA676F4B959.meansofdeath = meansofdeath;
  _id_9A967AA676F4B959.checkattacker = isDefined(attacker);
  _id_9A967AA676F4B959.checkobjweapon = isDefined(objweapon) && !isnullweapon(objweapon);
  _id_9A967AA676F4B959.checkinflictor = isDefined(inflictor);
  _id_9A967AA676F4B959.checkmeansofdeath = isDefined(meansofdeath);
  self.ignoredamagesignatures[id] = _id_9A967AA676F4B959;
  return id;
}

non_player_remove_ignore_damage_signature(id) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }
  self.ignoredamagesignatures[id] = undefined;
}

non_player_clear_ignore_damage_signatures() {
  self.ignoredamagesignatures = undefined;
}

non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamagesignatures))
    return 0;

  if(isDefined(objweapon) && isstring(objweapon))
    objweapon = makeweapon(objweapon);

  foreach(_id_9A967AA676F4B959 in self.ignoredamagesignatures) {
    if(!isDefined(_id_9A967AA676F4B959))
      return 0;

    if(_id_9A967AA676F4B959.checkattacker) {
      if(!isDefined(_id_9A967AA676F4B959.attacker)) {
        non_player_remove_ignore_damage_signature(_id_9A967AA676F4B959.id);
        continue;
      } else if(!isDefined(attacker))
        continue;
      else if(attacker != _id_9A967AA676F4B959.attacker)
        continue;
    }

    if(_id_9A967AA676F4B959.checkobjweapon) {
      if(!isDefined(objweapon) || isnullweapon(objweapon))
        continue;
      else if(objweapon.basename != _id_9A967AA676F4B959.objweapon.basename)
        continue;
    }

    if(_id_9A967AA676F4B959.checkinflictor) {
      if(!isDefined(_id_9A967AA676F4B959.inflictor)) {
        non_player_remove_ignore_damage_signature(_id_9A967AA676F4B959.id);
        continue;
      } else if(!isDefined(inflictor))
        continue;
      else if(inflictor != _id_9A967AA676F4B959.inflictor)
        continue;
    }

    if(_id_9A967AA676F4B959.checkmeansofdeath) {
      if(!isDefined(meansofdeath))
        continue;
      else if(meansofdeath != _id_9A967AA676F4B959.meansofdeath)
        continue;
    }

    return 1;
  }

  return 0;
}

islauncherdirectimpactdamage(objweapon, meansofdeath, _id_68D17572EF704FA8) {
  if(objweapon.type != "projectile")
    return 0;

  if(istrue(_id_68D17572EF704FA8) && objweapon.isalternate && isDefined(objweapon.underbarrel))
    return 0;

  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE";
}