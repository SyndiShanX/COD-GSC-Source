/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\vehicles\damage.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\weapon;
#namespace damage;

function init() {
  level.vehicles = spawnStruct();
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
}

function init_damage_callback_data() {
  assertex(isDefined(level.vehicles), "<dev string:x1c>");
  level.vehicles.damagecallback = &callback_vehicledamage;
  level.vehicles.deathcallback = &callback_vehicledeath;
  data = spawnStruct();
  data.premoddamagecallbacks = [];
  data.postmoddamagecallbacks = [];
  data.deathcallbacks = [];
  data.var_5c1c1f2a6037c40a = [];
  level.vehicles.damagecallbacks = data;
}

function get_pre_mod_damage_callback(ref) {
  assertex(isDefined(level.vehicles), "<dev string:x69>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:xb3>");
  return level.vehicles.damagecallbacks.premoddamagecallbacks[ref];
}

function get_post_mod_damage_callback(ref) {
  assertex(isDefined(level.vehicles), "<dev string:x10d>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x158>");
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[ref];
}

function get_death_callback(ref) {
  assertex(isDefined(level.vehicles), "<dev string:x1b3>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x1f4>");
  return level.vehicles.damagecallbacks.deathcallbacks[ref];
}

function private function_5947a803f03ef1df(ref) {
  assertex(isDefined(level.vehicles), "<dev string:x245>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x292>");
  return level.vehicles.damagecallbacks.var_5c1c1f2a6037c40a[ref];
}

function set_pre_mod_damage_callback(ref, func) {
  assertex(isDefined(level.vehicles), "<dev string:x2ef>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x339>");
  level.vehicles.damagecallbacks.premoddamagecallbacks[ref] = func;
}

function set_post_mod_damage_callback(ref, func) {
  assertex(isDefined(level.vehicles), "<dev string:x393>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x3de>");
  level.vehicles.damagecallbacks.postmoddamagecallbacks[ref] = func;
}

function set_death_callback(ref, func) {
  assertex(isDefined(level.vehicles), "<dev string:x439>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x47a>");
  level.vehicles.damagecallbacks.deathcallbacks[ref] = func;
}

function function_21a469b6e2805cf1(ref, func) {
  assertex(isDefined(level.vehicles), "<dev string:x439>");
  assertex(isDefined(level.vehicles.damagecallbacks), "<dev string:x47a>");

  if(!isDefined(level.vehicles.damagecallbacks.var_5c1c1f2a6037c40a[ref])) {
    level.vehicles.damagecallbacks.var_5c1c1f2a6037c40a[ref] = [];
  }

  level.vehicles.damagecallbacks.var_5c1c1f2a6037c40a[ref] = function_6d6af8144a5131f1(level.vehicles.damagecallbacks.var_5c1c1f2a6037c40a[ref], func);
}

function callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  self endon("death");
  data = packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, attachtagname, partname, undefined, dflags, eventid);
  data.hitloc = hitloc;
  data.timeoffset = timeoffset;
  callback_vehicledamage_internal(data);
}

function callback_vehicledamage_internal(data) {
  if(isDefined(data.attacker) && isDefined(data.attacker.classname) && data.attacker.classname == "worldspawn") {
    data.attacker = undefined;
  }

  if(!isDefined(data.attacker) || !isPlayer(data.attacker)) {
    if(isDefined(data.attacker) && isDefined(data.attacker.owner)) {
      data.attacker = data.attacker.owner;
    } else if(isDefined(data.inflictor)) {
      if(isPlayer(data.inflictor)) {
        data.attacker = data.inflictor;
      } else {
        data.attacker = data.inflictor.owner;
      }
    } else {
      data.attacker = undefined;
    }
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  if(isDefined(data.attacker) && !isDefined(_validateattacker(data.attacker))) {
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
      scripts\cp_mp\vehicles\vehicle_damage::function_9b1b715feb24f29f(self, data);
      return;
    }
  }

  if(istrue(self.var_135a33623c519457)) {
    scripts\cp_mp\vehicles\vehicle_damage::function_152437480e61a8a2(self, data, data.damage);
    return;
  }

  bulletdamage = isbulletdamage(data.meansofdeath);

  if(bulletdamage) {
    if(isDefined(data.attacker) && isPlayer(data.attacker) && (!isDefined(data.inflictor) || data.inflictor == data.attacker || scripts\mp\utility\entity::isturret(data.inflictor))) {
      attackervehicle = data.attacker getvehicle();

      if(isDefined(data.attacker.externalvehicle)) {
        attackervehicle = data.attacker.externalvehicle;
      }

      if(!isDefined(level.var_514f6b203d914836)) {
        level.var_514f6b203d914836 = getdvarint(@ "hash_de6cc6ced551f5f7", 0);
      }

      if(isDefined(attackervehicle) && attackervehicle == self && (level.var_514f6b203d914836 || !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker))) {
        return;
      }
    }
  }

  if(isDefined(data.meansofdeath) && isexplosivedamagemod(data.meansofdeath)) {
    if(!scripts\cp_mp\vehicles\vehicle_damage::function_c5a55810ed63c87d(data)) {
      return;
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

  if(non_player_should_ignore_damage(data.attacker, data.objweapon, data.inflictor, data.meansofdeath)) {
    return;
  }

  if(data.meansofdeath == "MOD_MELEE") {
    if(isDefined(vehiclename) && vehiclename == "radar_drone_recon") {} else if(isDefined(data.attacker) && isPlayer(data.attacker)) {
      data.attacker scripts\cp_mp\pet_watch::trackcarpunches(self);
    }
  }

  if(isDefined(level.modifyvehicledamage)) {
    data.damage = self[[level.modifyvehicledamage]](data);
  }

  if(isarray(level.var_2d3abe16d5e2ffe6)) {
    modified_damage = data.damage;

    foreach(func in level.var_2d3abe16d5e2ffe6) {
      new_damage = self[[func]](data);

      if(new_damage != -1) {
        modified_damage = new_damage;
      }
    }

    data.damage = modified_damage;
  }

  if(data.damage <= 0) {
    return;
  }

  var_361832452c18b9b2 = scripts\cp_mp\vehicles\vehicle_damage::function_152437480e61a8a2(self, data, data.damage);
  data.damage = scripts\cp_mp\vehicles\vehicle_damage::function_b9d933a7b78a67ad(data);

  if(data.meansofdeath == "MOD_MELEE") {
    if(isDefined(vehiclename) && vehiclename == "radar_drone_recon") {} else {
      allowmeleedamage = 0;

      if(isDefined(level.modeallowmeleevehicledamage)) {
        allowmeleedamage = self[[level.modeallowmeleevehicledamage]](data);
      }

      if(!allowmeleedamage) {
        data.damage = 0;
      }
    }
  } else if(data.meansofdeath == "MOD_IMPACT") {
    if(isDefined(vehiclename) && (vehiclename == "radar_drone_recon" || vehiclename == "assault_drone")) {
      if(isthrowingknife(data.objweapon) || isthrowingstar(data.objweapon) || function_8dee2e8a9f97d5aa(data.objweapon)) {
        data.damage = self.maxhealth;
      } else {
        data.damage = 0;
      }
    } else if(isDefined(vehiclename) && function_8dee2e8a9f97d5aa(data.objweapon)) {
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
    } else {
      data.damage = 0;
    }
  } else if(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE") {
    if(isDefined(level.modeignorevehicleexplosivedamage) && self[[level.modeignorevehicleexplosivedamage]](data)) {
      data.damage = 0;
    } else if(issmallsplashdamage(data.objweapon) && !isDefined(self.streakinfo)) {
      data.damage = 0;
    } else if(data.meansofdeath == "MOD_EXPLOSIVE_BULLET" && isDefined(vehiclename)) {
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
    } else if(isDefined(vehiclename)) {
      data.damage = get_hit_damage(data.damage, self, data.objweapon);
    }
  } else if(bulletdamage) {
    if(isspreadweapon(data.objweapon)) {
      data.damage = spreadshotdamagemod(self, data.attacker, data.objweapon, data.damage, data.idflags);
    } else if(iscrossbowdamage(data.objweapon)) {
      if(isDefined(vehiclename) && (vehiclename == "radar_drone_recon" || vehiclename == "assault_drone")) {
        data.damage = self.maxhealth;
      } else if(shouldcrossbowhitmarker(self, data)) {
        data.damage = 1;
      } else {
        data.damage = 0;
      }
    } else if(isDefined(vehiclename)) {
      data.damage = get_mod_damage(data.damage, self, data.objweapon, data.attacker);
    }
  }

  if(data.damage != 0) {
    data.damage = max(1, data.damage * var_361832452c18b9b2);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_logevent(self, data);

  if(isDefined(vehiclename)) {
    postmoddamagecallback = get_post_mod_damage_callback(vehiclename);

    if(isDefined(postmoddamagecallback)) {
      shouldcontinue = self[[postmoddamagecallback]](data);

      if(!istrue(shouldcontinue)) {
        return;
      }
    }
  }

  vehicleref = scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

  if(isDefined(vehicleref) && !scripts\common\vehicle::isvehiclehusk()) {
    vehicledata = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(vehicleref);

    if(isDefined(vehicledata) && istrue(vehicledata.scrapassist)) {
      scripts\mp\killstreaks\killstreaks::updatescrapassistdata(data.attacker, data.damage);
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

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate(data, shouldskipburndown, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, data);
  thread scripts\cp_mp\vehicles\vehicle_interact::function_68cdb3d30284be07();

  if(data.damage <= 0) {
    return;
  }

  if(istrue(level.vehiclegod)) {
    data.damage = 0;
  }

  non_player_log_attacker_data(data);
  modifieddamage = data.damage;
  modifieddamageratio = 1 - max(unmodifieddamage - modifieddamage, 0) / unmodifieddamage;
  damageisfatal = data.damage >= self.health;
  iscriticaldamage = istrue(data.isrearcriticaldamage) || istrue(data.issidecriticaldamage);

  if(getdvarint(@ "hash_1db87c3b655b5645", 0) == 1) {
    if(damageisfatal) {
      hitmarkertype = "hitveharmorbreak";
    } else {
      hitmarkertype = "hitequip";
    }
  } else {
    hitmarkertype = "hitequip";
  }

  if(iscriticaldamage && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case #"hash_8c12df11df01f306":
        break;
      default:
        data.attacker thread scripts\mp\utility\points::givexpwithtext(#"hash_add42535de0b8b91");
        break;
    }
  }

  targetent = -1;

  if(getdvarint(@ "hash_1db87c3b655b5645", 0) == 1 && !scripts\common\vehicle::isvehiclehusk()) {
    if(damageisfatal) {
      deathpoint = spawn("script_model", self.origin);
      deathpoint setentityowner(data.attacker);
      deathpoint delaycall(3, &delete);
      targetent = deathpoint getentitynumber();
    } else {
      targetent = self getentitynumber();
    }
  }

  if(isDefined(data.attacker)) {
    data.attacker updatedamagefeedback(hitmarkertype, damageisfatal, iscriticaldamage, "hitequip", undefined, 1, targetent);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatedamagefeedback(data);

  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    level notify("post_veh_damaged", data.inflictor, data.attacker, self, int(data.damage), data.objweapon);
  }

  if(damageisfatal) {
    if(isDefined(data.attacker) && isPlayer(data.attacker)) {
      data.attacker scripts\cp_mp\pet_watch::checkcarpuncherprogress(self);
    }

    if(isDefined(self.deathcallback)) {
      self thread[[self.deathcallback]](data.inflictor, data.attacker, data.damage, data.idflags, data.meansofdeath, data.objweapon, data.point, data.dir, data.hitloc, data.timeoffset, data.modelindex, data.partname);
      return;
    }

    if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback)) {
      self thread[[level.vehicles.deathcallback]](data);
      return;
    }

    self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.idflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.partname);
    return;
  }

  self vehicle_finishdamage(data.inflictor, data.attacker, int(data.damage), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.attachtagname, data.partname);
}

function callback_vehicledeath(data) {
  if(!isDefined(data.attacker) && isDefined(self.var_9328ded553f15d2b)) {
    data.attacker = self.var_9328ded553f15d2b;
  }

  if((!isDefined(data.objweapon) || isnullweapon(data.objweapon)) && isDefined(self.var_3d917147266db534)) {
    data.objweapon = self.var_3d917147266db534;
  }

  vehiclename = self.vehiclename;

  if(isDefined(vehiclename)) {
    var_5c1c1f2a6037c40a = function_5947a803f03ef1df(vehiclename);

    if(isDefined(var_5c1c1f2a6037c40a)) {
      foreach(callback in var_5c1c1f2a6037c40a) {
        self thread[[callback]](data);
      }
    }

    deathcallback = get_death_callback(vehiclename);

    if(isDefined(deathcallback)) {
      deathtime = gettime();
      shouldcontinue = self[[deathcallback]](data);
      assert(deathtime == gettime());

      if(!istrue(shouldcontinue)) {
        if(isDefined(level.var_8decce720ed19f1a)) {
          [[level.var_8decce720ed19f1a]](vehiclename, data.victim.team, data.attacker);
        }

        return;
      }
    }
  }

  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  non_player_clear_attacker_data();
  scripts\mp\events::vehiclekilled(data);

  if(isDefined(level.var_8decce720ed19f1a)) {
    [[level.var_8decce720ed19f1a]](vehiclename, data.team, data.attacker);
  }
}

function filter_out_friendly_damage(vehicle, attacker, team) {
  if(!isDefined(attacker) && !isDefined(team)) {
    return 0;
  }

  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isownerdamageenabled(vehicle)) {
    if(isDefined(attacker) && isDefined(vehicle.owner) && attacker == vehicle.owner) {
      return 0;
    }
  }

  ffenabled = istrue(level.vehiclefriendlydamage) || false;

  if(level.teambased) {
    if(!ffenabled) {
      if(isDefined(team) && !isDefined(attacker)) {
        return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam(vehicle, team);
      } else {
        return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, attacker);
      }
    }

    return 0;
  }

  if(!ffenabled) {
    if(isDefined(attacker)) {
      return scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, attacker);
    }

    return 0;
  }

  return 0;
}

function should_filter_out_friendly_damage(data) {
  if(isDefined(data.objweapon)) {
    basename = undefined;

    if(isstring(data.objweapon)) {
      basename = data.objweapon;
    } else {
      basename = data.objweapon.basename;
    }

    if(basename == "nuke_mp") {
      return false;
    }
  }

  return true;
}

function init_mod_damage_data() {
  assertex(isDefined(level.vehicles), "<dev string:x4cb>");
  data = spawnStruct();
  level.vehicles.moddamage = data;
  data.vehicles = [];
  data.weaponclasses = [];
  data.perks = [];
  data.attachments = [];
}

function get_mod_damage(damage, vehicle, objweapon, attacker) {
  modifier = get_mod_damage_modifier(vehicle, objweapon, attacker);
  return ceil(damage * modifier);
}

function get_mod_damage_modifier(vehicle, objweapon, attacker) {
  assertex(vehicle scripts\cp_mp\vehicles\vehicle::isvehicle(), "<dev string:x513>");
  assertex(isDefined(objweapon), "<dev string:x550>");
  modifier = 0;
  var_8ad585800c7b3bc6 = 1;
  vehicleref = vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
  vehicledata = get_vehicle_mod_damage_data(vehicleref);

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
  assertex(isDefined(level.vehicles.moddamage), "<dev string:x58f>");
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
  assertex(isDefined(level.vehicles.moddamage), "<dev string:x5d6>");
  data = level.vehicles.moddamage.weaponclasses[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[ref] = data;
  }

  return data;
}

function get_perk_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "<dev string:x622>");
  data = level.vehicles.moddamage.perks[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[ref] = data;
  }

  return data;
}

function get_attachment_mod_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.moddamage), "<dev string:x666>");
  data = level.vehicles.moddamage.attachments[ref];

  if(!isDefined(data) && istrue(create)) {
    data = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[ref] = data;
  }

  return data;
}

function set_weapon_class_mod_damage_data(ref, mod, var_21e99fcec7e19345) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "<dev string:x6b0>");
  }

  data = get_weapon_class_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_weapon_class_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "<dev string:x6b0>");
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
    assertex(mod > 0, "<dev string:x6b0>");
  }

  data = get_perk_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_perk_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "<dev string:x6b0>");
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
    assertex(mod > 0, "<dev string:x6b0>");
  }

  data = get_attachment_mod_damage_data(ref, 1);
  data.modifier = mod;
  data.ismultiplicative = var_21e99fcec7e19345;
}

function set_attachment_mod_damage_data_for_vehicle(ref, mod, var_21e99fcec7e19345, vehicleref) {
  if(var_21e99fcec7e19345) {
    assertex(mod > 0, "<dev string:x6b0>");
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

function shouldcrossbowhitmarker(vehicle, data) {
  if(function_6065fce6cdcad(data.objweapon)) {
    return true;
  }

  tags = function_786c7ec25aad5005(vehicle, data);

  foreach(tagname in tags) {
    if(function_ee1ff9eed64d1e5d(vehicle, tagname, 0)) {
      return true;
    }
  }

  return false;
}

function init_hit_damage_data() {
  assertex(isDefined(level.vehicles), "<dev string:x6db>");
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

    if(hitstokill > 0 && hitsperattack > 0 && !istrue(vehicle.debugdamage)) {
      healthratio = hitsperattack / hitstokill;
      damage = int(ceil(healthratio * vehicle.maxhealth));
    }
  }

  return damage;
}

function get_vehicle_hit_damage_data(ref, create) {
  assertex(isDefined(level.vehicles.hitdamage), "<dev string:x723>");
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
  assertex(isDefined(level.vehicles.hitdamage), "<dev string:x76e>");
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
  assertex(hitstokill > 0, "<dev string:x7b8>");
  data = get_vehicle_hit_damage_data(ref, 1);
  data.hitstokill = hitstokill;
}

function set_vehicle_hit_damage_data_for_weapon(ref, hitstokill, weaponref) {
  assertex(hitstokill > 0, "<dev string:x7b8>");
  data = get_vehicle_hit_damage_data(ref, 1);
  weapondata = get_weapon_hit_damage_data(weaponref, 1);
  weapondata.vehiclehitstokill[ref] = hitstokill;
}

function set_weapon_hit_damage_data(ref, hitsperattack) {
  assertex(hitsperattack > 0, "<dev string:x7e2>");
  data = get_weapon_hit_damage_data(ref, 1);
  data.hitsperattack = hitsperattack;
}

function set_weapon_hit_damage_data_for_vehicle(ref, hitsperattack, vehicleref) {
  assertex(hitsperattack > 0, "<dev string:x7e2>");
  data = get_weapon_hit_damage_data(ref, 1);
  vehicledata = get_vehicle_hit_damage_data(vehicleref, 1);
  vehicledata.weaponhitsperattack[ref] = hitsperattack;
}