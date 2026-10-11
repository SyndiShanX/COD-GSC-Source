/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\vehicles\damage_cp.gsc
************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\agent_damage;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_challenge;
#using scripts\cp\damagefeedback;
#using scripts\cp\events;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace damage_cp;

function init() {
  level.vehicles = spawnStruct();
  level.fn_damage_pack = &scripts\cp_mp\utility\damage_utility::packdamagedata;
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
  init_emp_damage_data();
}

function init_damage_callback_data() {
  assertex(isDefined(level.vehicles), "init_damage_callback_data() called before level.vehicles was initialized.");
  level.vehicles.damagecallback = &callback_vehicledamage;
  level.vehicles.deathcallback = &callback_vehicledeath;
  data = spawnStruct();
  data.premoddamagecallbacks = [];
  data.postmoddamagecallbacks = [];
  data.deathcallbacks = [];
  level.vehicles.damagecallbacks = data;
}

function get_pre_mod_damage_callback(ref) {
  assertex(isDefined(level.vehicles), "get_pre_mod_damage_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "get_pre_mod_damage_callback() called before vehicle damage callbacks were initialized.");
  return level.vehicles.damagecallbacks.premoddamagecallbacks[ref];
}

function get_post_mod_damage_callback(ref) {
  assertex(isDefined(level.vehicles), "get_post_mod_damage_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "get_post_mod_damage_callback() called before vehicle damage callbacks were initialized.");
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[ref];
}

function get_death_callback(ref) {
  assertex(isDefined(level.vehicles), "get_death_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "get_death_callback() called before vehicle damage callbacks were initialized.");
  return level.vehicles.damagecallbacks.deathcallbacks[ref];
}

function set_pre_mod_damage_callback(ref, func) {
  assertex(isDefined(level.vehicles), "set_pre_mod_damage_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "set_pre_mod_damage_callback() called before vehicle damage callbacks were initialized.");
  level.vehicles.damagecallbacks.premoddamagecallbacks[ref] = func;
}

function set_post_mod_damage_callback(ref, func) {
  assertex(isDefined(level.vehicles), "set_post_mod_damage_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "set_post_mod_damage_callback() called before vehicle damage callbacks were initialized.");
  level.vehicles.damagecallbacks.postmoddamagecallbacks[ref] = func;
}

function set_death_callback(ref, func) {
  assertex(isDefined(level.vehicles), "set_death_callback() called before vehicles were initialized.");
  assertex(isDefined(level.vehicles.damagecallbacks), "set_death_callback() called before vehicle damage callbacks were initialized.");
  level.vehicles.damagecallbacks.deathcallbacks[ref] = func;
}

function callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  self endon("death");

  if(isDefined(self.var_2c72dd1407c28de0) && isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "rocketlauncher") {
    damage = 0;
  }

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, attachtagname, partname, undefined, dflags, eventid);
  data.hitloc = hitloc;
  data.timeoffset = timeoffset;
  callback_vehicledamage_internal(data);
}

function callback_vehicledamage_internal(data) {
  if(isDefined(data.attacker) && isDefined(data.attacker.classname) && data.attacker.classname == "worldspawn") {
    data.attacker = undefined;
  }

  if(!isDefined(data.attacker) || !isPlayer(data.attacker) && !isagent(data.attacker) && !isscriptedagent(data.attacker)) {
    if(isDefined(data.attacker) && isDefined(data.attacker.owner)) {
      data.attacker = data.attacker.owner;
    } else if(isDefined(data.inflictor)) {
      if(isPlayer(data.inflictor) || isagent(data.inflictor) || isscriptedagent(data.inflictor)) {
        data.attacker = data.inflictor;
      } else if(isDefined(data.inflictor.owner)) {
        data.attacker = data.inflictor.owner;
      } else {
        data.attacker = data.inflictor;
      }
    } else {
      data.attacker = undefined;
    }
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
    if(isDefined(self.teamfriendlyto) && isDefined(data.attacker.team) && data.attacker.team == self.teamfriendlyto && !function_19a177cd542e9316(data)) {
      scripts\cp_mp\vehicles\vehicle_damage::function_9b1b715feb24f29f(self, data);
      return;
    }

    if(isDefined(self.occupants) && self.occupants.size > 0) {
      if(array_contains(self.occupants, data.attacker)) {
        if(!isDefined(self.occupants["driver"]) || data.attacker != self.occupants["driver"]) {
          if(isDefined(data.attacker.team)) {
            if(isDefined(self.teamfriendlyto) && data.attacker.team == self.teamfriendlyto && !function_19a177cd542e9316(data)) {
              scripts\cp_mp\vehicles\vehicle_damage::function_9b1b715feb24f29f(self, data);
              return;
            }
          }
        }
      }
    }
  }

  if(isDefined(data.attacker) && isDefined(data.attacker.vehicle)) {
    if(!isDefined(data.attacker.team)) {
      if(isDefined(data.attacker.vehicle.team)) {
        data.attacker.team = data.attacker.vehicle.team;
      }
    }
  }

  unmodifieddamage = data.damage;
  vehiclename = self.vehiclename;

  if(isDefined(vehiclename)) {
    premoddamagecallback = get_pre_mod_damage_callback(vehiclename);

    if(isDefined(premoddamagecallback)) {
      shouldcontinue = self[[premoddamagecallback]](data);

      if(!istrue(shouldcontinue)) {
        return;
      }
    }
  }

  var_361832452c18b9b2 = scripts\cp_mp\vehicles\vehicle_damage::function_152437480e61a8a2(self, data, unmodifieddamage);

  if(isDefined(self.var_7a646ff827387ac0)) {
    if([[self.var_7a646ff827387ac0]](data.partname, data.meansofdeath, data.point, data.objweapon)) {
      data.damage = 0;
    }
  }

  if(data.damage <= 0) {
    return;
  }

  if(data.meansofdeath == "MOD_MELEE") {
    data.damage = 0;
  } else if(data.meansofdeath == "MOD_IMPACT") {
    data.damage = 0;
  } else if(isexplosivedamagemod(data.meansofdeath)) {
    if(isDefined(vehiclename)) {
      data.damage = get_hit_damage(data.damage, self, data.objweapon);
    }
  } else if(isbulletdamage(data.meansofdeath)) {
    if(maxspreadshotsperframe(self, data.attacker, data.objweapon) || istrue(self.var_f97a3d3fd021563b)) {
      data.damage = 0;
    } else if(isDefined(vehiclename)) {
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
    }
  }

  if(isDefined(self.var_2ce864bd06fb0385)) {
    [[self.var_2ce864bd06fb0385]](data);
  }

  if(isDefined(vehiclename)) {
    postmoddamagecallback = get_post_mod_damage_callback(vehiclename);

    if(isDefined(postmoddamagecallback)) {
      shouldcontinue = self[[postmoddamagecallback]](data);

      if(!istrue(shouldcontinue)) {
        return;
      }
    }
  }

  shouldskipburndown = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_shouldskipburndown(data);

  if(!shouldskipburndown) {
    damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();

    if(isDefined(damagestate) && damagestate == "heavy") {
      damagemod = ter_op(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      data.damage *= damagemod;
    }
  }

  if(data.damage != 0) {
    data.damage = max(1, data.damage * var_361832452c18b9b2);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate(data, shouldskipburndown, 1);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

  if(isDefined(occupants)) {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, data);
  }

  if(data.damage <= 0) {
    return;
  }

  if(isDefined(self.vehiclename) && self.vehiclename == "light_tank") {
    self notify("alerted", data);
  }

  modifieddamage = data.damage;
  modifieddamageratio = 1 - max(unmodifieddamage - modifieddamage, 0) / unmodifieddamage;
  hitmarkertype = "standard";

  if(isDefined(self.var_1ab6b61153087915)) {
    [[self.var_1ab6b61153087915]](data);
  }

  damageisfatal = data.damage >= self.health;

  if(isPlayer(data.attacker)) {
    data.attacker scripts\cp\damagefeedback::updatedamagefeedback("hitcritical", damageisfatal, undefined, hitmarkertype, undefined, 1);
    scripts\cp\agent_damage::addattacker(self, data.attacker, data.inflictor, data.objweapon, data.damage, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.meansofdeath);
  }

  if(isDefined(self.occupants)) {
    healthpercentvalue = int(clamp((self.health - data.damage) / self.maxhealth * 100, 0, 100));

    foreach(occupant in self.occupants) {
      occupant setclientomnvar("ui_veh_health_percent", int(healthpercentvalue));
      occupant setclientomnvar("ui_veh_show_health", 1);
    }
  }

  if(isPlayer(data.attacker)) {
    self.var_3bf58a51e3b6d782 = data.objweapon.basename;
    self.last_player_attacker = data.attacker;
  }

  if(damageisfatal) {
    if(isPlayer(data.attacker)) {
      if(isDefined(self.riders) && self.riders.size > 0) {
        data.attacker thread scripts\cp\events::killedenemy(undefined, self, data.objweapon, data.meansofdeath, data.inflictor, 0);
      }

      thread scripts\cp\cp_challenge::onplayerkilled(data.inflictor, data.attacker, int(data.damage), data.idflags, data.meansofdeath, data.objweapon, data.hitloc, data.attacker.modifiers);
    }

    if(isDefined(self.deathcallback)) {
      self thread[[self.deathcallback]](data.inflictor, data.attacker, data.damage, data.idflags, data.meansofdeath, data.objweapon, data.point, data.dir, data.hitloc, data.timeoffset, data.modelindex, data.partname);
      return;
    }

    if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback)) {
      self thread[[level.vehicles.deathcallback]](data);
      return;
    }

    self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.attachtagname, data.partname);
    return;
  }

  self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.attachtagname, data.partname);
}

function function_b08e7b7b01f8fb2b(data) {
  if(data.victim scripts\common\vehicle::ishelicopter() && data.victim.team == "axis") {
    if(isDefined(self.last_player_attacker) && isPlayer(self.last_player_attacker)) {
      if(data.inflictor.model == "ks_cruise_predator_mp") {
        self.last_player_attacker scripts\cp\challenges_cp::function_fc52996338c115d1();
      }

      if(isDefined(self.var_3bf58a51e3b6d782)) {
        if(self.var_3bf58a51e3b6d782 == "iw9_la_mike32_mp") {
          self.last_player_attacker scripts\cp\challenges_cp::function_9ec128ba953ab4e0();
        }
      }
    }
  }

  if(!isDefined(self.last_player_attacker) || !isPlayer(self.last_player_attacker)) {
    return;
  }

  if(data.victim.team != "allies") {
    self.last_player_attacker scripts\cp\challenges_cp::destroyvehicles();
  }
}

function callback_vehicledeath(data) {
  vehiclename = self.vehiclename;
  function_b08e7b7b01f8fb2b(data);

  if(isDefined(vehiclename)) {
    deathcallback = get_death_callback(vehiclename);

    if(isDefined(deathcallback)) {
      deathtime = gettime();
      shouldcontinue = self[[deathcallback]](data);
      assert(deathtime == gettime());

      if(!istrue(shouldcontinue)) {
        return;
      }
    }
  }

  self.health = 0;
  self setCanDamage(0);
  non_player_clear_attacker_data();
  self notify("death");
}

function init_mod_damage_data() {
  assertex(isDefined(level.vehicles), "init_mod_damage_data() called before level.vehicles was initialized.");
  data = spawnStruct();
  level.vehicles.moddamage = data;
  data.vehicles = [];
  data.weaponclasses = [];
  data.perks = [];
  data.attachments = [];
}

function get_mod_damage(damage, vehicle, objweapon, attacker) {
  modifier = get_mod_damage_modifier(vehicle, objweapon, attacker);
  return damage * modifier;
}

function get_mod_damage_modifier(vehicle, objweapon, attacker) {
  assertex(vehicle scripts\cp_mp\vehicles\vehicle::isvehicle(), "get_mod_damage_modifier() called with an invalid vehicle.");
  assertex(isDefined(objweapon), "get_mod_damage_modifier() called with an invalid objWeapon.");
  modifier = 0;
  var_8ad585800c7b3bc6 = 1;
  vehicleref = vehicle.vehiclename;
  vehicledata = get_vehicle_mod_damage_data(vehicle.vehiclename);

  if(isDefined(vehicledata)) {
    weaponclassref = objweapon.classname;
    weaponclassdata = get_weapon_class_mod_damage_data(weaponclassref);

    if(isDefined(weaponclassdata)) {
      var_6150a2a43bf62f15 = vehicledata.weaponclassdata[weaponclassref];

      if(isDefined(var_6150a2a43bf62f15)) {
        weaponclassdata = var_6150a2a43bf62f15;
      }

      if(weaponclassdata.modifier != 0) {
        if(weaponclassdata.ismultiplicative) {
          var_8ad585800c7b3bc6 *= weaponclassdata.modifier;
        } else {
          modifier += weaponclassdata.modifier;
        }
      }
    }

    if(isDefined(attacker) && isDefined(attacker.perks)) {
      foreach(perkref, stackcount in attacker.perks) {
        perkdata = get_perk_mod_damage_data(perkref);

        if(isDefined(perkdata)) {
          var_9120deed01dfd363 = vehicledata.perkdata[perkref];

          if(isDefined(var_9120deed01dfd363)) {
            perkdata = var_9120deed01dfd363;
          }

          if(perkdata.modifier != 0) {
            if(perkdata.ismultiplicative) {
              var_8ad585800c7b3bc6 *= perkdata.modifier;
              continue;
            }

            modifier += perkdata.modifier;
          }
        }
      }
    }

    if(isDefined(objweapon.attachments)) {
      foreach(attachmentref in objweapon.attachments) {
        attachmentref = attachmentref;
        attachmentdata = get_attachment_mod_damage_data(attachmentref);

        if(isDefined(attachmentdata)) {
          var_dedd9ad59151c25e = vehicledata.attachmentdata[attachmentref];

          if(isDefined(var_dedd9ad59151c25e)) {
            attachmentdata = var_dedd9ad59151c25e;
          }

          if(attachmentdata.modifier != 0) {
            if(attachmentdata.ismultiplicative) {
              var_8ad585800c7b3bc6 *= attachmentdata.modifier;
              continue;
            }

            modifier += attachmentdata.modifier;
          }
        }
      }
    }
  }

  return modifier + var_8ad585800c7b3bc6;
}

function get_vehicle_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "get_vehicle_damage_mod_data() called before init_mod_damage_data().");
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

function get_weapon_class_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "get_weapon_class_mod_damage_data() called before init_mod_damage_data().");
  data = level.vehicles.moddamage.weaponclasses[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[ref] = data;
  }

  return data;
}

function get_perk_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "get_perk_mod_damage_data() called before init_mod_damage_data().");
  data = level.vehicles.moddamage.perks[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[ref] = data;
  }

  return data;
}

function get_attachment_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "get_attachment_mod_damage_data() called before init_mod_damage_data().");
  data = level.vehicles.moddamage.attachments[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[ref] = data;
  }

  return data;
}

function set_weapon_class_mod_damage_data(ref, mod, var_21e99fcec7e19345) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  data = get_weapon_class_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_weapon_class_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  vehicledata = get_vehicle_mod_damage_data(vehicleref, 1);
  get_weapon_class_mod_damage_data(ref, 1);
  data = vehicledata.weaponclassdata[ref];

  if(!isDefined(data)) {
    data = create_mod_damage_data_empty();
  }

  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
  vehicledata.weaponclassdata[ref] = data;
}

function set_perk_mod_damage_data(ref, mod, var_21e99fcec7e19345) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  data = get_perk_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_perk_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  vehicledata = get_vehicle_mod_damage_data(vehicleref, 1);
  get_perk_mod_damage_data(ref, 1);
  data = vehicledata.perkdata[ref];

  if(!isDefined(data)) {
    data = create_mod_damage_data_empty();
  }

  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
  vehicledata.perkdata[ref] = data;
}

function set_attachment_mod_damage_data(ref, mod, var_21e99fcec7e19345) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  data = get_attachment_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_attachment_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "mod must be > 0 when modIsMult is true.");
  }

  vehicledata = get_vehicle_mod_damage_data(vehicleref, 1);
  get_attachment_mod_damage_data(ref, 1);
  data = vehicledata.attachmentdata[ref];

  if(!isDefined(data)) {
    data = create_mod_damage_data_empty();
  }

  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
  vehicledata.attachmentdata[ref] = data;
}

function create_mod_damage_data_empty() {
  data = spawnStruct();
  data.modifier = 0;
  data.ismultiplicative = 0;
  return data;
}

function init_hit_damage_data() {
  assertex(isDefined(level.vehicles), "init_hit_damage_data() called before level.vehicles was initialized.");
  data = spawnStruct();
  level.vehicles.hitdamage = data;
  data.vehicles = [];
  data.weapons = [];
}

function get_hit_damage(damage, vehicle, objweapon) {
  vehicleref = vehicle.vehiclename;
  weaponref = objweapon.basename;
  vehicledata = get_vehicle_hit_damage_data(vehicleref);
  weapondata = get_weapon_hit_damage_data(weaponref);

  if(isDefined(vehicledata) && isDefined(weapondata)) {
    hitstokill = weapondata.vehiclehitstokill[vehicleref];

    if(!isDefined(hitstokill) || hitstokill == 0) {
      hitstokill = vehicledata.hitstokill;
    }

    hitsperattack = vehicledata.weaponhitsperattack[weaponref];

    if(!isDefined(hitsperattack) || hitsperattack == 0) {
      hitsperattack = weapondata.hitsperattack;
    }

    if(hitstokill > 0 && hitsperattack > 0) {
      healthratio = hitsperattack / hitstokill;
      damage = int(ceil(healthratio * vehicle.maxhealth));
    }
  }

  return damage;
}

function get_vehicle_hit_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.hitdamage), "get_vehicle_hit_damage_data() called before init_vehicle_damage_data().");
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

function get_weapon_hit_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.hitdamage), "get_weapon_hit_damage_data() called before init_vehicle_damage_data().");
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

function set_vehicle_hit_damage_data(ref, hitstokill) {
  assertex(hitstokill > 0, "hitsToKill cannot be a negative value.");
  data = get_vehicle_hit_damage_data(ref, 1);
  data.hitstokill = hitstokill;
}

function set_vehicle_hit_damage_data_for_weapon(ref, hitstokill, weaponref) {
  assertex(hitstokill > 0, "hitsToKill cannot be a negative value.");
  data = get_vehicle_hit_damage_data(ref, 1);
  weapondata = get_weapon_hit_damage_data(weaponref, 1);
  weapondata.vehiclehitstokill[ref] = hitstokill;
}

function set_weapon_hit_damage_data(ref, hitsperattack) {
  assertex(hitsperattack > 0, "hitsPerAttack cannot be a negative value.");
  data = get_weapon_hit_damage_data(ref, 1);
  data.hitsperattack = hitsperattack;
}

function set_weapon_hit_damage_data_for_vehicle(ref, hitsperattack, vehicleref) {
  assertex(hitsperattack > 0, "hitsPerAttack cannot be a negative value.");
  data = get_weapon_hit_damage_data(ref, 1);
  vehicledata = get_vehicle_hit_damage_data(vehicleref, 1);
  vehicledata.weaponhitsperattack[ref] = hitsperattack;
}

function function_d508766fa2962e37(weap_name) {
  assertex(isDefined(level.vehicles), "set_weapon_allow_friendly_fire_damage_on_vehicles() called before level.vehicles was initialized.");

  if(!isDefined(level.vehicles.var_39e472cc91e9a780)) {
    level.vehicles.var_39e472cc91e9a780 = [];
  }

  level.vehicles.var_39e472cc91e9a780 = array_add(level.vehicles.var_39e472cc91e9a780, weap_name);
}

function function_19a177cd542e9316(data) {
  if(!isDefined(data) || !isDefined(level.vehicles.var_39e472cc91e9a780)) {
    return false;
  }

  weap_name = undefined;

  if(isDefined(data.objweapon) && isDefined(data.objweapon.basename) && !(data.objweapon.basename == "none")) {
    weap_name = data.objweapon.basename;
  } else if(isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name)) {
    weap_name = data.inflictor.weapon_name;
  }

  if(!isDefined(weap_name)) {
    return false;
  }

  if(array_contains(level.vehicles.var_39e472cc91e9a780, weap_name)) {
    return true;
  }

  return false;
}

function init_emp_damage_data() {
  assertex(isDefined(level.vehicles), "init_emp_damage_data() called before level.vehicles was initialized.");
  data = spawnStruct();
  level.vehicles.empdamage = data;
  data.callbacks = [];
}

function emp_damage_callback(data) {
  victim = data.victim;
  victim endon("death");
  data.empdamageenabled = 1;
  victim thread callback_vehicledamage_internal(data);
  callback = get_emp_damage_callback(victim.vehiclename);

  if(isDefined(callback)) {
    thread[[callback]](data);
  }
}

function get_emp_damage_callback(ref) {
  if(!isDefined(level.vehicles)) {
    assertmsg("get_emp_damage_callback() called before level.vehicles was initialized.");
    return undefined;
  } else if(!isDefined(level.vehicles.empdamage)) {
    assertmsg("get_emp_damage_callback() called before init_emp_damage_data().");
    return undefined;
  }

  return level.vehicles.empdamage.callbacks[ref];
}

function set_emp_damage_callback(ref, func) {
  if(!isDefined(level.vehicles)) {
    assertmsg("get_emp_damage_callback() called before level.vehicles was initialized.");
    return undefined;
  } else if(!isDefined(level.vehicles.empdamage)) {
    assertmsg("get_emp_damage_callback() called before init_emp_damage_data().");
    return undefined;
  }

  level.vehicles.empdamage.callbacks[ref] = func;
}

function _validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive)) {
    return undefined;
  }

  if(isagent(eattacker) && !isDefined(eattacker.classname)) {
    return undefined;
  }

  return eattacker;
}

function non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

function maxspreadshotsperframe(victim, eattacker, objweapon) {
  result = 0;

  if(isDefined(eattacker) && isDefined(victim) && isDefined(objweapon)) {
    victimid = victim getentitynumber();
    isspreadweapon = weaponclass(objweapon) == "spread";

    if(!isspreadweapon) {
      return result;
    }

    time = "" + gettime();
    pellets = undefined;

    if(eattacker isdualwielding()) {
      pellets = 8;
    } else {
      pellets = 4;
    }

    if(!isDefined(eattacker.pelletdmg) || !isDefined(eattacker.pelletdmg[time])) {
      eattacker.pelletdmg = undefined;
      eattacker.pelletdmg[time] = [];
    }

    if(!isDefined(eattacker.pelletdmg[time][victimid])) {
      eattacker.pelletdmg[time][victimid] = 1;
    } else if(eattacker.pelletdmg[time][victimid] + 1 > pellets) {
      result = 1;
    } else {
      eattacker.pelletdmg[time][victimid]++;
    }
  }

  return result;
}

function packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags) {
  struct = spawnStruct();

  if(isDefined(attacker) && isent(attacker)) {
    struct.attacker = attacker;
  }

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