/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\damage_cp.gsc
***********************************************/

init() {
  level.vehicles = spawnStruct();
  level.fn_damage_pack = scripts\cp_mp\utility\damage_utility::packdamagedata;
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
  init_emp_damage_data();
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

  if(isDefined(self._id_2C72DD1407C28DE0) && isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "rocketlauncher")
    damage = 0;

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, _id_799F234362ADB813, partname, undefined, _id_44E290FB31B85206, eventid);
  data.hitloc = hitloc;
  data.timeoffset = timeoffset;
  callback_vehicledamage_internal(data);
}

callback_vehicledamage_internal(data) {
  if(isDefined(data.attacker) && isDefined(data.attacker.classname) && data.attacker.classname == "worldspawn")
    data.attacker = undefined;

  if(!isDefined(data.attacker) || !isPlayer(data.attacker) && !isagent(data.attacker) && !isscriptedagent(data.attacker)) {
    if(isDefined(data.attacker) && isDefined(data.attacker.owner))
      data.attacker = data.attacker.owner;
    else if(isDefined(data.inflictor)) {
      if(isPlayer(data.inflictor) || isagent(data.inflictor) || isscriptedagent(data.inflictor))
        data.attacker = data.inflictor;
      else if(isDefined(data.inflictor.owner))
        data.attacker = data.inflictor.owner;
      else
        data.attacker = data.inflictor;
    } else
      data.attacker = undefined;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  if(istrue(self.invulnerable)) {
    return;
  }
  if(data.damage <= 0) {
    return;
  }
  if(isDefined(data.attacker)) {
    if(isDefined(self.teamfriendlyto) && isDefined(data.attacker.team) && data.attacker.team == self.teamfriendlyto) {
      scripts\cp_mp\vehicles\vehicle_damage::_id_9B1B715FEB24F29F(self, data);
      return;
    }

    if(isDefined(self.occupants) && self.occupants.size > 0) {
      if(scripts\engine\utility::array_contains(self.occupants, data.attacker)) {
        if(!isDefined(self.occupants["driver"]) || data.attacker != self.occupants["driver"]) {
          if(isDefined(data.attacker.team)) {
            if(isDefined(self.teamfriendlyto) && data.attacker.team == self.teamfriendlyto) {
              scripts\cp_mp\vehicles\vehicle_damage::_id_9B1B715FEB24F29F(self, data);
              return;
            }
          }
        }
      }
    }
  }

  if(isDefined(data.attacker) && isDefined(data.attacker.vehicle)) {
    if(!isDefined(data.attacker.team)) {
      if(isDefined(data.attacker.vehicle.team))
        data.attacker.team = data.attacker.vehicle.team;
    }
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

  _id_361832452C18B9B2 = scripts\cp_mp\vehicles\vehicle_damage::_id_152437480E61A8A2(self, data, _id_69CFD14B4398C458);

  if(isDefined(self._id_7A646FF827387AC0)) {
    if([[self._id_7A646FF827387AC0]](data.partname, data.meansofdeath, data.point, data.objweapon))
      data.damage = 0;
  }

  if(data.damage <= 0) {
    return;
  }
  if(data.meansofdeath == "MOD_MELEE")
    data.damage = 0;
  else if(data.meansofdeath == "MOD_IMPACT")
    data.damage = 0;
  else if(isexplosivedamagemod(data.meansofdeath)) {
    if(isDefined(vehiclename))
      data.damage = get_hit_damage(data.damage, self, data.objweapon);
  } else if(scripts\engine\utility::isbulletdamage(data.meansofdeath)) {
    if(maxspreadshotsperframe(self, data.attacker, data.objweapon) || istrue(self._id_F97A3D3FD021563B))
      data.damage = 0;
    else if(isDefined(vehiclename))
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
  }

  if(isDefined(self._id_2CE864BD06FB0385))
    [[self._id_2CE864BD06FB0385]](data);

  if(isDefined(vehiclename)) {
    _id_7DA88D9C69433487 = get_post_mod_damage_callback(vehiclename);

    if(isDefined(_id_7DA88D9C69433487)) {
      _id_35AB2DABE0210D0F = self[[_id_7DA88D9C69433487]](data);

      if(!istrue(_id_35AB2DABE0210D0F))
        return;
    }
  }

  _id_D6961EF4AB70843C = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_shouldskipburndown(data);

  if(!_id_D6961EF4AB70843C) {
    damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();

    if(isDefined(damagestate) && damagestate == "heavy") {
      damagemod = scripts\engine\utility::ter_op(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      data.damage = data.damage * damagemod;
    }
  }

  if(data.damage != 0)
    data.damage = max(1, data.damage * _id_361832452C18B9B2);

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate(data, _id_D6961EF4AB70843C, 1);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

  if(isDefined(occupants))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, data);

  if(data.damage <= 0) {
    return;
  }
  if(isDefined(self.vehiclename) && self.vehiclename == "light_tank")
    self notify("alerted", data);

  _id_702BFC08FABD86CB = data.damage;
  _id_B715CC72F047CBDE = 1 - max(_id_69CFD14B4398C458 - _id_702BFC08FABD86CB, 0) / _id_69CFD14B4398C458;
  _id_B98146816886D3C4 = "standard";

  if(isDefined(self._id_1AB6B61153087915))
    [[self._id_1AB6B61153087915]](data);

  _id_A711564324E5064E = data.damage >= self.health;

  if(isPlayer(data.attacker)) {
    data.attacker _id_354C862768CFE202::updatedamagefeedback("hitcritical", _id_A711564324E5064E, undefined, _id_B98146816886D3C4, undefined, 1);
    _id_6F1E07CE9FF97D5F::addattacker(self, data.attacker, data.inflictor, data.objweapon, data.damage, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.meansofdeath);
  }

  if(isDefined(self.occupants)) {
    _id_52616AAE7B55D981 = int(clamp((self.health - data.damage) / self.maxhealth * 100, 0, 100));

    foreach(_id_F85572CD5F6117C6 in self.occupants) {
      _id_F85572CD5F6117C6 setclientomnvar("ui_veh_health_percent", int(_id_52616AAE7B55D981));
      _id_F85572CD5F6117C6 setclientomnvar("ui_veh_show_health", 1);
    }
  }

  if(isPlayer(data.attacker)) {
    self._id_3BF58A51E3B6D782 = data.objweapon.basename;
    self._id_C55851BE7B6088F3 = data.attacker;
  }

  if(_id_A711564324E5064E) {
    if(isPlayer(data.attacker)) {
      if(isDefined(self.riders) && self.riders.size > 0)
        data.attacker thread _id_293BC33BD79CABD1::killedenemy(undefined, self, data.objweapon, data.meansofdeath, data.inflictor, 0);

      thread scripts\cp\cp_challenge::onplayerkilled(data.inflictor, data.attacker, int(data.damage), data.idflags, data.meansofdeath, data.objweapon, data.hitloc, data.attacker.modifiers);
    }

    if(isDefined(self.deathcallback))
      self thread[[self.deathcallback]](data.inflictor, data.attacker, data.damage, data.idflags, data.meansofdeath, data.objweapon, data.point, data.dir, data.hitloc, data.timeoffset, data.modelindex, data.partname);
    else if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback))
      self thread[[level.vehicles.deathcallback]](data);
    else
      self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data._id_799F234362ADB813, data.partname);

    return;
  }

  self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data._id_799F234362ADB813, data.partname);
}

_id_B08E7B7B01F8FB2B(data) {
  if(data.victim scripts\common\vehicle::ishelicopter() && data.victim.team == "axis") {
    if(isDefined(self._id_C55851BE7B6088F3) && isPlayer(self._id_C55851BE7B6088F3)) {
      if(data.inflictor.model == "ks_cruise_predator_mp")
        self._id_C55851BE7B6088F3 scripts\cp\challenges_cp::_id_FC52996338C115D1();

      if(isDefined(self._id_3BF58A51E3B6D782)) {
        if(self._id_3BF58A51E3B6D782 == "iw9_la_mike32_mp")
          self._id_C55851BE7B6088F3 scripts\cp\challenges_cp::_id_9EC128BA953AB4E0();
      }
    }
  }

  if(!isDefined(self._id_C55851BE7B6088F3) || !isPlayer(self._id_C55851BE7B6088F3))
    return;
  else if(data.victim.team != "allies")
    self._id_C55851BE7B6088F3 scripts\cp\challenges_cp::_id_5CCD46F74AF245D8();
}

callback_vehicledeath(data) {
  vehiclename = self.vehiclename;
  _id_B08E7B7B01F8FB2B(data);

  if(isDefined(vehiclename)) {
    deathcallback = get_death_callback(vehiclename);

    if(isDefined(deathcallback)) {
      deathtime = gettime();
      _id_35AB2DABE0210D0F = self[[deathcallback]](data);

      if(!istrue(_id_35AB2DABE0210D0F))
        return;
    }
  }

  self.health = 0;
  self setCanDamage(0);
  non_player_clear_attacker_data();
  self notify("death");
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
  return damage * modifier;
}

get_mod_damage_modifier(vehicle, objweapon, attacker) {
  modifier = 0;
  _id_8AD585800C7B3BC6 = 1;
  _id_7731ADEF63E19B0C = vehicle.vehiclename;
  vehicledata = get_vehicle_mod_damage_data(vehicle.vehiclename);

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

  if(scripts\cp\cp_relics::is_relic_active("relic_nobulletdamage") && isPlayer(attacker)) {
    modifier = 0;
    _id_8AD585800C7B3BC6 = 0;
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitnobulletdamage");
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

    if(hitstokill > 0 && hitsperattack > 0) {
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

init_emp_damage_data() {
  data = spawnStruct();
  level.vehicles.empdamage = data;
  data.callbacks = [];
}

emp_damage_callback(data) {
  victim = data.victim;
  victim endon("death");
  data.empdamageenabled = 1;
  victim thread callback_vehicledamage_internal(data);
  callback = get_emp_damage_callback(victim.vehiclename);

  if(isDefined(callback))
    thread[[callback]](data);
}

get_emp_damage_callback(ref) {
  if(!isDefined(level.vehicles))
    return undefined;
  else if(!isDefined(level.vehicles.empdamage))
    return undefined;

  return level.vehicles.empdamage.callbacks[ref];
}

set_emp_damage_callback(ref, func) {
  if(!isDefined(level.vehicles))
    return undefined;
  else if(!isDefined(level.vehicles.empdamage))
    return undefined;

  level.vehicles.empdamage.callbacks[ref] = func;
  return;
}

_validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive))
    return undefined;

  if(isagent(eattacker) && !isDefined(eattacker.classname))
    return undefined;

  return eattacker;
}

non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

maxspreadshotsperframe(victim, eattacker, objweapon) {
  result = 0;

  if(isDefined(eattacker) && isDefined(victim) && isDefined(objweapon)) {
    _id_48B7B944A7A02B2C = victim getentitynumber();
    isspreadweapon = weaponclass(objweapon) == "spread";

    if(!isspreadweapon)
      return result;

    time = "" + gettime();
    _id_2D7BA1A9567917A0 = undefined;

    if(eattacker isdualwielding())
      _id_2D7BA1A9567917A0 = 8;
    else
      _id_2D7BA1A9567917A0 = 4;

    if(!isDefined(eattacker.pelletdmg) || !isDefined(eattacker.pelletdmg[time])) {
      eattacker.pelletdmg = undefined;
      eattacker.pelletdmg[time] = [];
    }

    if(!isDefined(eattacker.pelletdmg[time][_id_48B7B944A7A02B2C]))
      eattacker.pelletdmg[time][_id_48B7B944A7A02B2C] = 1;
    else if(eattacker.pelletdmg[time][_id_48B7B944A7A02B2C] + 1 > _id_2D7BA1A9567917A0)
      result = 1;
    else
      eattacker.pelletdmg[time][_id_48B7B944A7A02B2C]++;
  }

  return result;
}

packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags) {
  struct = spawnStruct();

  if(isDefined(attacker) && isent(attacker))
    struct.attacker = attacker;

  struct.victim = victim;
  struct.damage = damage;
  struct.objweapon = objweapon;
  struct.meansofdeath = meansofdeath;
  struct.inflictor = inflictor;
  struct.point = point;
  struct.direction_vec = direction_vec;
  struct.modelname = int(modelname);
  struct.partname = partname;
  struct.hitloc = "none";
  struct.timeoffset = 150;
  struct.tagname = tagname;
  struct.idflags = idflags;
  struct.damageflags = idflags;
  struct.attacker.assistedsuicide = 0;
  return struct;
}