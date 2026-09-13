/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\damage.gsc
***********************************************/

init() {
  level.vehicles = spawnStruct();
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
}

init_damage_callback_data() {
  level.vehicles.damagecallback = ::callback_vehicledamage;
  level.vehicles.deathcallback = ::callback_vehicledeath;
  data = spawnStruct();
  data.premoddamagecallbacks = [];
  data.postmoddamagecallbacks = [];
  data.deathcallbacks = [];
  level.vehicles.damagecallbacks = data;
}

get_pre_mod_damage_callback(ref) {
  return level.vehicles.damagecallbacks.premoddamagecallbacks[ref];
}

get_post_mod_damage_callback(ref) {
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[ref];
}

get_death_callback(ref) {
  return level.vehicles.damagecallbacks.deathcallbacks[ref];
}

set_pre_mod_damage_callback(ref, func) {
  level.vehicles.damagecallbacks.premoddamagecallbacks[ref] = func;
}

set_post_mod_damage_callback(ref, func) {
  level.vehicles.damagecallbacks.postmoddamagecallbacks[ref] = func;
}

set_death_callback(ref, func) {
  level.vehicles.damagecallbacks.deathcallbacks[ref] = func;
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  self endon("death");
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, _id_799F234362ADB813, partname, undefined, _id_44E290FB31B85206, eventid);
  data.hitloc = hitloc;
  data.timeoffset = timeoffset;
  callback_vehicledamage_internal(data);
}

callback_vehicledamage_internal(data) {
  if(isDefined(data.attacker) && isDefined(data.attacker.classname) && data.attacker.classname == "worldspawn")
    data.attacker = undefined;

  if(!isDefined(data.attacker) || !isPlayer(data.attacker)) {
    if(isDefined(data.attacker) && isDefined(data.attacker.owner))
      data.attacker = data.attacker.owner;
    else if(isDefined(data.inflictor)) {
      if(isPlayer(data.inflictor))
        data.attacker = data.inflictor;
      else
        data.attacker = data.inflictor.owner;
    } else
      data.attacker = undefined;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(isDefined(data.attacker) && !isDefined(scripts\mp\utility\damage::_validateattacker(data.attacker))) {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  if(data.damage <= 0) {
    return;
  }
  if(istrue(self.godmode)) {
    return;
  }
  if(should_filter_out_friendly_damage(data)) {
    if(filter_out_friendly_damage(self, data.attacker)) {
      scripts\cp_mp\vehicles\vehicle_damage::_id_9B1B715FEB24F29F(self, data);
      return;
    }
  }

  if(istrue(self._id_135A33623C519457)) {
    scripts\cp_mp\vehicles\vehicle_damage::_id_152437480E61A8A2(self, data, data.damage);
    return;
  }

  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(data.meansofdeath);

  if(_id_A3192D2F80ED4FF8) {
    if(isDefined(data.attacker) && isPlayer(data.attacker) && (!isDefined(data.inflictor) || data.inflictor == data.attacker || scripts\mp\utility\entity::isturret(data.inflictor))) {
      _id_4866E2C44A0B5B1E = data.attacker scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(data.attacker._id_ABD157413AC4E022))
        _id_4866E2C44A0B5B1E = data.attacker._id_ABD157413AC4E022;

      if(!isDefined(level._id_514F6B203D914836))
        level._id_514F6B203D914836 = getdvarint("dvar_DE6CC6CED551F5F7", 0);

      if(isDefined(_id_4866E2C44A0B5B1E) && _id_4866E2C44A0B5B1E == self && (level._id_514F6B203D914836 || !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker)))
        return;
    }
  }

  if(isDefined(data.meansofdeath) && isexplosivedamagemod(data.meansofdeath)) {
    if(!scripts\cp_mp\vehicles\vehicle_damage::_id_C5A55810ED63C87D(data))
      return;
  }

  _id_69CFD14B4398C458 = data.damage;
  vehiclename = self.vehiclename;

  if(isDefined(vehiclename)) {
    _id_BACC6DD14316758C = get_pre_mod_damage_callback(vehiclename);

    if(isDefined(_id_BACC6DD14316758C)) {
      _id_35AB2DABE0210D0F = self[[_id_BACC6DD14316758C]](data);

      if(!istrue(_id_35AB2DABE0210D0F))
        return;
    }
  }

  if(scripts\mp\utility\damage::non_player_should_ignore_damage(data.attacker, data.objweapon, data.inflictor, data.meansofdeath)) {
    return;
  }
  if(data.meansofdeath == "MOD_MELEE") {
    if(isDefined(vehiclename) && vehiclename == "radar_drone_recon") {} else if(isDefined(data.attacker) && isPlayer(data.attacker))
      data.attacker scripts\cp_mp\pet_watch::trackcarpunches(self);
  }

  if(isDefined(level.modifyvehicledamage))
    data.damage = self[[level.modifyvehicledamage]](data);

  if(data.damage <= 0) {
    return;
  }
  _id_361832452C18B9B2 = scripts\cp_mp\vehicles\vehicle_damage::_id_152437480E61A8A2(self, data, data.damage);
  data.damage = scripts\cp_mp\vehicles\vehicle_damage::_id_B9D933A7B78A67AD(data);

  if(data.meansofdeath == "MOD_MELEE") {
    if(isDefined(vehiclename) && vehiclename == "radar_drone_recon") {} else {
      allowmeleedamage = 0;

      if(isDefined(level.modeallowmeleevehicledamage))
        allowmeleedamage = self[[level.modeallowmeleevehicledamage]](data);

      if(!allowmeleedamage)
        data.damage = 0;
    }
  } else if(data.meansofdeath == "MOD_IMPACT") {
    if(isDefined(vehiclename) && (vehiclename == "radar_drone_recon" || vehiclename == "assault_drone")) {
      if(scripts\mp\utility\weapon::isthrowingknife(data.objweapon) || scripts\mp\utility\weapon::_id_160A992C78BDF589(data.objweapon))
        data.damage = self.maxhealth;
      else
        data.damage = 0;
    } else if(isDefined(level._id_1FA2A6B50267656A)) {
      _id_6DB01DD6407B85BD = self[[level._id_1FA2A6B50267656A]](data);

      if(!istrue(_id_6DB01DD6407B85BD))
        data.damage = 0;
    } else
      data.damage = 0;
  } else if(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE") {
    if(isDefined(level.modeignorevehicleexplosivedamage) && self[[level.modeignorevehicleexplosivedamage]](data))
      data.damage = 0;
    else if(scripts\mp\damage::issmallsplashdamage(data.objweapon) && !isDefined(self.streakinfo))
      data.damage = 0;
    else if(data.meansofdeath == "MOD_EXPLOSIVE_BULLET" && isDefined(vehiclename))
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
    else if(isDefined(vehiclename))
      data.damage = get_hit_damage(data.damage, self, data.objweapon);
  } else if(_id_A3192D2F80ED4FF8) {
    if(_id_2669878CF5A1B6BC::isspreadweapon(data.objweapon))
      data.damage = scripts\mp\damage::spreadshotdamagemod(self, data.attacker, data.objweapon, data.damage, data.idflags);
    else if(scripts\cp_mp\utility\damage_utility::iscrossbowdamage(data.objweapon)) {
      if(isDefined(vehiclename) && (vehiclename == "radar_drone_recon" || vehiclename == "assault_drone"))
        data.damage = self.maxhealth;
      else if(shouldcrossbowhitmarker(self, data))
        data.damage = 1;
      else
        data.damage = 0;
    } else if(isDefined(vehiclename))
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
  }

  if(data.damage != 0)
    data.damage = max(1, data.damage * _id_361832452C18B9B2);

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_logevent(self, data);

  if(isDefined(vehiclename)) {
    _id_7DA88D9C69433487 = get_post_mod_damage_callback(vehiclename);

    if(isDefined(_id_7DA88D9C69433487)) {
      _id_35AB2DABE0210D0F = self[[_id_7DA88D9C69433487]](data);

      if(!istrue(_id_35AB2DABE0210D0F))
        return;
    }
  }

  _id_7731ADEF63E19B0C = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(isDefined(_id_7731ADEF63E19B0C) && !scripts\common\vehicle::_id_B7148A3BFC4DEFB2()) {
    vehicledata = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);

    if(isDefined(vehicledata) && istrue(vehicledata._id_45C7E4F315C93C29))
      scripts\mp\killstreaks\killstreaks::updatescrapassistdata(data.attacker, data.damage);
  }

  _id_D6961EF4AB70843C = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_shouldskipburndown(data);

  if(!_id_D6961EF4AB70843C) {
    damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();

    if(isDefined(damagestate) && damagestate == "heavy") {
      damagemod = scripts\engine\utility::ter_op(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      data.damage = data.damage * damagemod;
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate(data, _id_D6961EF4AB70843C, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, data);
  thread scripts\cp_mp\vehicles\vehicle_interact::_id_68CDB3D30284BE07();

  if(data.damage <= 0) {
    return;
  }
  if(istrue(level.vehiclegod))
    data.damage = 0;

  scripts\mp\utility\damage::non_player_log_attacker_data(data);
  _id_702BFC08FABD86CB = data.damage;
  _id_B715CC72F047CBDE = 1 - max(_id_69CFD14B4398C458 - _id_702BFC08FABD86CB, 0) / _id_69CFD14B4398C458;
  _id_A711564324E5064E = data.damage >= self.health;
  iscriticaldamage = istrue(data.isrearcriticaldamage) || istrue(data.issidecriticaldamage);

  if(getdvarint("dvar_1DB87C3B655B5645", 0) == 1) {
    if(_id_A711564324E5064E)
      _id_B98146816886D3C4 = "hitveharmorbreak";
    else
      _id_B98146816886D3C4 = "hitequip";
  } else
    _id_B98146816886D3C4 = "hitequip";

  if(iscriticaldamage && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case "pac_sentry_turret_mp":
        break;
      default:
        data.attacker thread scripts\mp\utility\points::givexpwithtext("stat_ADD42535DE0B8B91");
        break;
    }
  }

  targetent = -1;

  if(getdvarint("dvar_1DB87C3B655B5645", 0) == 1 && !scripts\common\vehicle::_id_B7148A3BFC4DEFB2()) {
    if(_id_A711564324E5064E) {
      _id_2C43FCF1AF7E1BA5 = spawn("script_model", self.origin);
      _id_2C43FCF1AF7E1BA5 setentityowner(data.attacker);
      _id_2C43FCF1AF7E1BA5 scripts\engine\utility::delaycall(3, ::delete);
      targetent = _id_2C43FCF1AF7E1BA5 getentitynumber();
    } else
      targetent = self getentitynumber();
  }

  if(isDefined(data.attacker))
    data.attacker _id_5762AC2F22202BA2::updatedamagefeedback(_id_B98146816886D3C4, _id_A711564324E5064E, iscriticaldamage, "hitequip", undefined, 1, targetent);

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatedamagefeedback(data);

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    level notify("post_veh_damaged", data.inflictor, data.attacker, self, int(data.damage), data.objweapon);

  if(_id_A711564324E5064E) {
    if(isDefined(data.attacker) && isPlayer(data.attacker))
      data.attacker scripts\cp_mp\pet_watch::checkcarpuncherprogress(self);

    if(isDefined(self.deathcallback))
      self thread[[self.deathcallback]](data.inflictor, data.attacker, data.damage, data.idflags, data.meansofdeath, data.objweapon, data.point, data.dir, data.hitloc, data.timeoffset, data.modelindex, data.partname);
    else if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback))
      self thread[[level.vehicles.deathcallback]](data);
    else
      self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.idflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.partname);

    return;
  }

  self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data._id_799F234362ADB813, data.partname);
}

callback_vehicledeath(data) {
  if(!isDefined(data.attacker) && isDefined(self._id_9328DED553F15D2B))
    data.attacker = self._id_9328DED553F15D2B;

  if((!isDefined(data.objweapon) || isnullweapon(data.objweapon)) && isDefined(self._id_3D917147266DB534))
    data.objweapon = self._id_3D917147266DB534;

  vehiclename = self.vehiclename;

  if(isDefined(vehiclename)) {
    deathcallback = get_death_callback(vehiclename);

    if(isDefined(deathcallback)) {
      deathtime = gettime();
      _id_35AB2DABE0210D0F = self[[deathcallback]](data);

      if(!istrue(_id_35AB2DABE0210D0F)) {
        if(isDefined(level._id_8DECCE720ED19F1A))
          [[level._id_8DECCE720ED19F1A]](vehiclename, data.victim.team, data.attacker);

        return;
      }
    }
  }

  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  scripts\mp\utility\damage::non_player_clear_attacker_data();
  scripts\mp\events::vehiclekilled(data);

  if(isDefined(level._id_8DECCE720ED19F1A))
    [[level._id_8DECCE720ED19F1A]](vehiclename, data.team, data.attacker);
}

filter_out_friendly_damage(vehicle, attacker, team) {
  if(!isDefined(attacker) && !isDefined(team))
    return 0;

  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isownerdamageenabled(vehicle)) {
    if(isDefined(attacker) && isDefined(vehicle.owner) && attacker == vehicle.owner)
      return 0;
  }

  _id_5B6C77C6825D63C2 = istrue(level.vehiclefriendlydamage) || 0;

  if(level.teambased) {
    if(!_id_5B6C77C6825D63C2) {
      if(isDefined(team) && !isDefined(attacker))
        return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam(vehicle, team);
      else
        return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, attacker);
    }

    return 0;
  } else {
    if(!_id_5B6C77C6825D63C2) {
      if(isDefined(attacker))
        return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, attacker);

      return 0;
    }

    return 0;
  }
}

should_filter_out_friendly_damage(data) {
  if(isDefined(data.objweapon)) {
    basename = undefined;

    if(isstring(data.objweapon))
      basename = data.objweapon;
    else
      basename = data.objweapon.basename;

    if(basename == "nuke_mp")
      return 0;
  }

  return 1;
}

init_mod_damage_data() {
  data = spawnStruct();
  level.vehicles.moddamage = data;
  data.vehicles = [];
  data.weaponclasses = [];
  data.perks = [];
  data.attachments = [];
}

get_mod_damage(damage, vehicle, objweapon, attacker) {
  modifier = get_mod_damage_modifier(vehicle, objweapon, attacker);
  return ceil(damage * modifier);
}

get_mod_damage_modifier(vehicle, objweapon, attacker) {
  modifier = 0;
  _id_8AD585800C7B3BC6 = 1;
  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  vehicledata = get_vehicle_mod_damage_data(_id_7731ADEF63E19B0C);

  if(isDefined(vehicledata)) {
    _id_647150A820D29168 = objweapon.classname;
    weaponclassdata = get_weapon_class_mod_damage_data(_id_647150A820D29168);

    if(isDefined(weaponclassdata)) {
      _id_6150A2A43BF62F15 = vehicledata.weaponclassdata[_id_647150A820D29168];

      if(isDefined(_id_6150A2A43BF62F15))
        weaponclassdata = _id_6150A2A43BF62F15;

      if(weaponclassdata.modifier != 0) {
        if(weaponclassdata.ismultiplicative)
          _id_8AD585800C7B3BC6 = _id_8AD585800C7B3BC6 * weaponclassdata.modifier;
        else
          modifier = modifier + weaponclassdata.modifier;
      }
    }

    if(isDefined(attacker) && isDefined(attacker.perks)) {
      foreach(perkref, _id_62468C8830E8093A in attacker.perks) {
        perkdata = get_perk_mod_damage_data(perkref);

        if(isDefined(perkdata)) {
          _id_9120DEED01DFD363 = vehicledata.perkdata[perkref];

          if(isDefined(_id_9120DEED01DFD363))
            perkdata = _id_9120DEED01DFD363;

          if(perkdata.modifier != 0) {
            if(perkdata.ismultiplicative)
              _id_8AD585800C7B3BC6 = _id_8AD585800C7B3BC6 * perkdata.modifier;
            else
              modifier = modifier + perkdata.modifier;
          }
        }
      }
    }

    if(isDefined(objweapon.attachments)) {
      foreach(attachmentref in objweapon.attachments) {
        attachmentref = attachmentref;
        attachmentdata = get_attachment_mod_damage_data(attachmentref);

        if(isDefined(attachmentdata)) {
          _id_DEDD9AD59151C25E = vehicledata.attachmentdata[attachmentref];

          if(isDefined(_id_DEDD9AD59151C25E))
            attachmentdata = _id_DEDD9AD59151C25E;

          if(attachmentdata.modifier != 0) {
            if(attachmentdata.ismultiplicative)
              _id_8AD585800C7B3BC6 = _id_8AD585800C7B3BC6 * attachmentdata.modifier;
            else
              modifier = modifier + attachmentdata.modifier;
          }
        }
      }
    }
  }

  return modifier + _id_8AD585800C7B3BC6;
}

get_vehicle_mod_damage_data(ref, create) {
  data = level.vehicles.moddamage.vehicles[ref];

  if(!isDefined(data) && istrue(create)) {
    data = spawnStruct();
    data.weaponclassdata = [];
    data.perkdata = [];
    data.attachmentdata = [];
    level.vehicles.moddamage.vehicles[ref] = data;
  }

  return data;
}

get_weapon_class_mod_damage_data(ref, create) {
  data = level.vehicles.moddamage.weaponclasses[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[ref] = data;
  }

  return data;
}

get_perk_mod_damage_data(ref, create) {
  data = level.vehicles.moddamage.perks[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[ref] = data;
  }

  return data;
}

get_attachment_mod_damage_data(ref, create) {
  data = level.vehicles.moddamage.attachments[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[ref] = data;
  }

  return data;
}

set_weapon_class_mod_damage_data(ref, mod, _id_21E99FCEC7E19345) {
  if(_id_21E99FCEC7E19345) {}

  data = get_weapon_class_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
}

set_weapon_class_mod_damage_data_for_vehicle(ref, mod, _id_21E99FCEC7E19345, _id_7731ADEF63E19B0C) {
  if(_id_21E99FCEC7E19345) {}

  vehicledata = get_vehicle_mod_damage_data(_id_7731ADEF63E19B0C, 1);
  get_weapon_class_mod_damage_data(ref, 1);
  data = vehicledata.weaponclassdata[ref];

  if(!isDefined(data))
    data = create_mod_damage_data_empty();

  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
  vehicledata.weaponclassdata[ref] = data;
}

set_perk_mod_damage_data(ref, mod, _id_21E99FCEC7E19345) {
  if(_id_21E99FCEC7E19345) {}

  data = get_perk_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
}

set_perk_mod_damage_data_for_vehicle(ref, mod, _id_21E99FCEC7E19345, _id_7731ADEF63E19B0C) {
  if(_id_21E99FCEC7E19345) {}

  vehicledata = get_vehicle_mod_damage_data(_id_7731ADEF63E19B0C, 1);
  get_perk_mod_damage_data(ref, 1);
  data = vehicledata.perkdata[ref];

  if(!isDefined(data))
    data = create_mod_damage_data_empty();

  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
  vehicledata.perkdata[ref] = data;
}

set_attachment_mod_damage_data(ref, mod, _id_21E99FCEC7E19345) {
  if(_id_21E99FCEC7E19345) {}

  data = get_attachment_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
}

set_attachment_mod_damage_data_for_vehicle(ref, mod, _id_21E99FCEC7E19345, _id_7731ADEF63E19B0C) {
  if(_id_21E99FCEC7E19345) {}

  vehicledata = get_vehicle_mod_damage_data(_id_7731ADEF63E19B0C, 1);
  get_attachment_mod_damage_data(ref, 1);
  data = vehicledata.attachmentdata[ref];

  if(!isDefined(data))
    data = create_mod_damage_data_empty();

  data.modifier = mod;
  data.ismultiplicative = _id_21E99FCEC7E19345;
  vehicledata.attachmentdata[ref] = data;
}

create_mod_damage_data_empty() {
  data = spawnStruct();
  data.modifier = 0;
  data.ismultiplicative = 0;
  return data;
}

shouldcrossbowhitmarker(vehicle, data) {
  if(scripts\cp_mp\utility\damage_utility::_id_0006065FCE6CDCAD(data.objweapon))
    return 1;

  tags = scripts\cp_mp\vehicles\vehicle_damage::_id_786C7EC25AAD5005(vehicle, data);

  foreach(tagname in tags) {
    if(scripts\cp_mp\vehicles\vehicle_damage::_id_EE1FF9EED64D1E5D(vehicle, tagname, 0))
      return 1;
  }

  return 0;
}

init_hit_damage_data() {
  data = spawnStruct();
  level.vehicles.hitdamage = data;
  data.vehicles = [];
  data.weapons = [];
}

get_hit_damage(damage, vehicle, objweapon) {
  _id_7731ADEF63E19B0C = vehicle.vehiclename;
  weaponref = objweapon.basename;
  vehicledata = get_vehicle_hit_damage_data(_id_7731ADEF63E19B0C);
  _id_BAE77D8848F4D84D = get_weapon_hit_damage_data(weaponref);

  if(isDefined(vehicledata) && isDefined(_id_BAE77D8848F4D84D)) {
    hitstokill = _id_BAE77D8848F4D84D.vehiclehitstokill[_id_7731ADEF63E19B0C];

    if(!isDefined(hitstokill) || hitstokill == 0)
      hitstokill = vehicledata.hitstokill;

    hitsperattack = vehicledata.weaponhitsperattack[weaponref];

    if(!isDefined(hitsperattack) || hitsperattack == 0)
      hitsperattack = _id_BAE77D8848F4D84D.hitsperattack;

    if(hitstokill > 0 && hitsperattack > 0 && !istrue(vehicle._id_1FAA3D3DEC8D49BD)) {
      healthratio = hitsperattack / hitstokill;
      damage = int(ceil(healthratio * vehicle.maxhealth));
    }
  }

  return damage;
}

get_vehicle_hit_damage_data(ref, create) {
  data = level.vehicles.hitdamage.vehicles[ref];

  if(!isDefined(data) && istrue(create)) {
    data = spawnStruct();
    data.ref = ref;
    data.hitstokill = 0;
    data.weaponhitsperattack = [];
    level.vehicles.hitdamage.vehicles[ref] = data;
  }

  return data;
}

get_weapon_hit_damage_data(ref, create) {
  data = level.vehicles.hitdamage.weapons[ref];

  if(!isDefined(data) && istrue(create)) {
    data = spawnStruct();
    data.ref = ref;
    data.hitsperattack = 0;
    data.vehiclehitstokill = [];
    level.vehicles.hitdamage.weapons[ref] = data;
  }

  return data;
}

set_vehicle_hit_damage_data(ref, hitstokill) {
  data = get_vehicle_hit_damage_data(ref, 1);
  data.hitstokill = hitstokill;
}

set_vehicle_hit_damage_data_for_weapon(ref, hitstokill, weaponref) {
  data = get_vehicle_hit_damage_data(ref, 1);
  _id_BAE77D8848F4D84D = get_weapon_hit_damage_data(weaponref, 1);
  _id_BAE77D8848F4D84D.vehiclehitstokill[ref] = hitstokill;
}

set_weapon_hit_damage_data(ref, hitsperattack) {
  data = get_weapon_hit_damage_data(ref, 1);
  data.hitsperattack = hitsperattack;
}

set_weapon_hit_damage_data_for_vehicle(ref, hitsperattack, _id_7731ADEF63E19B0C) {
  data = get_weapon_hit_damage_data(ref, 1);
  vehicledata = get_vehicle_hit_damage_data(_id_7731ADEF63E19B0C, 1);
  vehicledata.weaponhitsperattack[ref] = hitsperattack;
}