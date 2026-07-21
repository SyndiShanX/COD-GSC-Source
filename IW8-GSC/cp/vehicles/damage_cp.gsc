/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\damage_cp.gsc
***********************************************/

init() {
  level.vehicles = spawnStruct();
  level.player_xp = ::packdamagedata;
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
  init_emp_damage_data();
}

init_damage_callback_data() {
  level.vehicles.damagecallback = ::callback_vehicledamage;
  level.vehicles.deathcallback = ::callback_vehicledeath;
  var_0 = spawnStruct();
  var_0.premoddamagecallbacks = [];
  var_0.postmoddamagecallbacks = [];
  var_0.deathcallbacks = [];
  level.vehicles.damagecallbacks = var_0;
}

get_pre_mod_damage_callback(var_0) {
  return level.vehicles.damagecallbacks.premoddamagecallbacks[var_0];
}

get_post_mod_damage_callback(var_0) {
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[var_0];
}

get_death_callback(var_0) {
  return level.vehicles.damagecallbacks.deathcallbacks[var_0];
}

set_pre_mod_damage_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.premoddamagecallbacks[var_0] = var_1;
}

set_post_mod_damage_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.postmoddamagecallbacks[var_0] = var_1;
}

set_death_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.deathcallbacks[var_0] = var_1;
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self endon("_encstr_AD75063D571AE108");
  var_13 = packdamagedata(var_1, self, var_2, var_5, var_4, var_0, var_6, var_7, var_10, var_11, undefined, var_3);
  var_13.hitloc = var_8;
  var_13.timeoffset = var_9;
  callback_vehicledamage_internal(var_13);
}

callback_vehicledamage_internal(var_0) {
  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
    var_0.attacker = undefined;

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) && !isagent(var_0.attacker) && !isscriptedagent(var_0.attacker)) {
    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner))
      var_0.attacker = var_0.attacker.owner;
    else if(isDefined(var_0.inflictor)) {
      if(isPlayer(var_0.inflictor) || isagent(var_0.inflictor) || isscriptedagent(var_0.inflictor))
        var_0.attacker = var_0.inflictor;
      else if(isDefined(var_0.inflictor.owner))
        var_0.attacker = var_0.inflictor.owner;
      else
        var_0.attacker = var_0.inflictor;
    } else
      var_0.attacker = undefined;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    return;
  }
  if(istrue(self.invulnerable)) {
    return;
  }
  if(var_0.damage <= 0) {
    return;
  }
  if(isDefined(var_0.attacker)) {
    if(isDefined(self.occupants) && self.occupants.size > 0) {
      if(scripts\engine\utility::array_contains(self.occupants, var_0.attacker)) {
        if(isDefined(var_0.attacker.team)) {
          if(isDefined(self._id_13AAD) && var_0.attacker.team == self._id_13AAD)
            return;
        }
      }
    }
  }

  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.vehicle)) {
    if(!isDefined(var_0.attacker.team)) {
      if(isDefined(var_0.attacker.vehicle.team))
        var_0.attacker.team = var_0.attacker.vehicle.team;
    }
  }

  var_1 = var_0.damage;
  var_2 = self.vehiclename;

  if(isDefined(var_2)) {
    var_3 = get_pre_mod_damage_callback(var_2);

    if(isDefined(var_3)) {
      var_4 = self[[var_3]](var_0);

      if(!istrue(var_4))
        return;
    }
  }

  if(var_0.damage <= 0) {
    return;
  }
  if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
    var_0.damage = 0;
  else if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    var_0.damage = 0;
  else if(isexplosivedamagemod(var_0.meansofdeath)) {
    if(isDefined(var_2))
      var_0.damage = get_hit_damage(var_0.damage, self, var_0.objweapon);
  } else if(scripts\engine\utility::isbulletdamage(var_0.meansofdeath)) {
    if(maxspreadshotsperframe(self, var_0.attacker, var_0.objweapon))
      var_0.damage = 0;
    else if(isDefined(var_2))
      var_0.damage = get_mod_damage(var_0.damage, self, var_0.objweapon, var_0.attacker);
  }

  if(isDefined(var_2)) {
    var_5 = get_post_mod_damage_callback(var_2);

    if(isDefined(var_5)) {
      var_4 = self[[var_5]](var_0);

      if(!istrue(var_4))
        return;
    }
  }

  var_6 = scripts\cp_mp\vehicles\vehicle_damage::_id_1417D(var_0);

  if(!var_6) {
    var_7 = scripts\cp_mp\vehicles\vehicle_damage::_id_14152();

    if(isDefined(var_7) && var_7 == "_encstr_B846067B175AA56A") {
      var_8 = scripts\engine\utility::ter_op(isexplosivedamagemod(var_0.meansofdeath) || var_0.meansofdeath == "_encstr_9B0D099AD3887D91252954", 0.15, 0.25);
      var_0.damage = var_0.damage * var_8;
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14180(var_0, 1);
  var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

  if(isDefined(var_9))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, var_0);

  if(var_0.damage <= 0) {
    return;
  }
  if(isDefined(self.vehiclename) && self.vehiclename == "_encstr_AF390B295782C3585F1B21D8C4")
    self notify("_encstr_BA22087EA808525BA5D9", var_0);

  var_10 = var_0.damage;
  var_11 = 1 - max(var_1 - var_10, 0) / var_1;
  var_12 = "_encstr_A5AE098ADB583E0AF7A5AB";
  var_13 = var_0.damage >= self.health;

  if(isPlayer(var_0.attacker)) {
    var_0.attacker scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", var_13, undefined, var_12, undefined, 1);
    scripts\cp\cp_agent_damage::addattacker(self, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.damage, var_0.point, var_0.direction_vec, var_0.hitloc, var_0.timeoffset, var_0.meansofdeath);
  }

  if(isDefined(self.occupants)) {
    var_14 = int(clamp((self.health - var_0.damage) / self.maxhealth * 100, 0, 100));

    foreach(var_16 in self.occupants) {
      var_16 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", int(var_14));
      var_16 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 1);
    }
  }

  if(var_13) {
    if(isPlayer(var_0.attacker)) {
      if(isDefined(self.riders) && self.riders.size > 0)
        var_0.attacker thread scripts\mp\mp_agent_damage::vip_playerdied(undefined, self, var_0.objweapon, var_0.meansofdeath, var_0.inflictor, 0);

      thread scripts\mp\ammorestock::onplayerkilled(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0.idflags, var_0.meansofdeath, var_0.objweapon, var_0.hitloc, var_0.attacker.modifiers);
    }

    if(isDefined(self.deathcallback))
      self thread[[self.deathcallback]](var_0.inflictor, var_0.attacker, var_0.damage, var_0.idflags, var_0.meansofdeath, var_0.objweapon, var_0.point, var_0.dir, var_0.hitloc, var_0.timeoffset, var_0.modelindex, var_0.partname);
    else if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback))
      self thread[[level.vehicles.deathcallback]](var_0);
    else
      self vehicle_finishdamage(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0.idflags, var_0.meansofdeath, var_0.objweapon, var_0.point, var_0.direction_vec, var_0.hitloc, var_0.timeoffset, var_0.modelname, var_0.partname);

    return;
  }

  self vehicle_finishdamage(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0.damageflags, var_0.meansofdeath, var_0.objweapon, var_0.point, var_0.direction_vec, var_0.hitloc, var_0.timeoffset, var_0.modelname, var_0.partname);
}

callback_vehicledeath(var_0) {
  var_1 = self.vehiclename;

  if(isDefined(var_1)) {
    var_2 = get_death_callback(var_1);

    if(isDefined(var_2)) {
      var_3 = gettime();
      var_4 = self[[var_2]](var_0);

      if(!istrue(var_4))
        return;
    }
  }

  self.health = 0;
  self setCanDamage(0);
  non_player_clear_attacker_data();
  self notify("_encstr_AD75063D571AE108");
}

init_mod_damage_data() {
  var_0 = spawnStruct();
  level.vehicles.moddamage = var_0;
  var_0.vehicles = [];
  var_0.weaponclasses = [];
  var_0.perks = [];
  var_0.attachments = [];
}

get_mod_damage(var_0, var_1, var_2, var_3) {
  var_4 = get_mod_damage_modifier(var_1, var_2, var_3);
  return var_0 * var_4;
}

get_mod_damage_modifier(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;
  var_5 = var_0.vehiclename;
  var_6 = get_vehicle_mod_damage_data(var_0.vehiclename);

  if(isDefined(var_6)) {
    var_7 = var_1.classname;
    var_8 = get_weapon_class_mod_damage_data(var_7);

    if(isDefined(var_8)) {
      var_9 = var_6.weaponclassdata[var_7];

      if(isDefined(var_9))
        var_8 = var_9;

      if(var_8.modifier != 0) {
        if(var_8.ismultiplicative)
          var_4 = var_4 * var_8.modifier;
        else
          var_3 = var_3 + var_8.modifier;
      }
    }

    if(isDefined(var_2) && isDefined(var_2.perks)) {
      foreach(var_14, var_11 in var_2.perks) {
        var_12 = get_perk_mod_damage_data(var_14);

        if(isDefined(var_12)) {
          var_13 = var_6.perkdata[var_14];

          if(isDefined(var_13))
            var_12 = var_13;

          if(var_12.modifier != 0) {
            if(var_12.ismultiplicative)
              var_4 = var_4 * var_12.modifier;
            else
              var_3 = var_3 + var_12.modifier;
          }
        }
      }
    }

    if(isDefined(var_1.attachments)) {
      foreach(var_16 in var_1.attachments) {
        var_16 = scripts\cp\utility::attachmentmap_tobase(var_16);
        var_17 = get_attachment_mod_damage_data(var_16);

        if(isDefined(var_17)) {
          var_18 = var_6.attachmentdata[var_16];

          if(isDefined(var_18))
            var_17 = var_18;

          if(var_17.modifier != 0) {
            if(var_17.ismultiplicative)
              var_4 = var_4 * var_17.modifier;
            else
              var_3 = var_3 + var_17.modifier;
          }
        }
      }
    }
  }

  return var_3 + var_4;
}

get_vehicle_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.vehicles[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2.weaponclassdata = [];
    var_2.perkdata = [];
    var_2.attachmentdata = [];
    level.vehicles.moddamage.vehicles[var_0] = var_2;
  }

  return var_2;
}

get_weapon_class_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.weaponclasses[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[var_0] = var_2;
  }

  return var_2;
}

get_perk_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.perks[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[var_0] = var_2;
  }

  return var_2;
}

get_attachment_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.attachments[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[var_0] = var_2;
  }

  return var_2;
}

set_weapon_class_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_weapon_class_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

set_weapon_class_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_weapon_class_mod_damage_data(var_0, 1);
  var_5 = var_4.weaponclassdata[var_0];

  if(!isDefined(var_5))
    var_5 = create_mod_damage_data_empty();

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.weaponclassdata[var_0] = var_5;
}

set_perk_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_perk_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

set_perk_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_perk_mod_damage_data(var_0, 1);
  var_5 = var_4.perkdata[var_0];

  if(!isDefined(var_5))
    var_5 = create_mod_damage_data_empty();

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.perkdata[var_0] = var_5;
}

set_attachment_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_attachment_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

set_attachment_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_attachment_mod_damage_data(var_0, 1);
  var_5 = var_4.attachmentdata[var_0];

  if(!isDefined(var_5))
    var_5 = create_mod_damage_data_empty();

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.attachmentdata[var_0] = var_5;
}

create_mod_damage_data_empty() {
  var_0 = spawnStruct();
  var_0.modifier = 0;
  var_0.ismultiplicative = 0;
  return var_0;
}

init_hit_damage_data() {
  var_0 = spawnStruct();
  level.vehicles.hitdamage = var_0;
  var_0.vehicles = [];
  var_0.weapons = [];
}

get_hit_damage(var_0, var_1, var_2) {
  var_3 = var_1.vehiclename;
  var_4 = var_2.basename;
  var_5 = get_vehicle_hit_damage_data(var_3);
  var_6 = get_weapon_hit_damage_data(var_4);

  if(isDefined(var_5) && isDefined(var_6)) {
    var_7 = var_6.vehiclehitstokill[var_3];

    if(!isDefined(var_7) || var_7 == 0)
      var_7 = var_5.hitstokill;

    var_8 = var_5.weaponhitsperattack[var_4];

    if(!isDefined(var_8) || var_8 == 0)
      var_8 = var_6.hitsperattack;

    if(var_7 > 0 && var_8 > 0) {
      var_9 = var_8 / var_7;
      var_0 = int(ceil(var_9 * var_1.maxhealth));
    }
  }

  return var_0;
}

get_vehicle_hit_damage_data(var_0, var_1) {
  var_2 = level.vehicles.hitdamage.vehicles[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2.ref = var_0;
    var_2.hitstokill = 0;
    var_2.weaponhitsperattack = [];
    level.vehicles.hitdamage.vehicles[var_0] = var_2;
  }

  return var_2;
}

get_weapon_hit_damage_data(var_0, var_1) {
  var_2 = level.vehicles.hitdamage.weapons[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2.ref = var_0;
    var_2.hitsperattack = 0;
    var_2.vehiclehitstokill = [];
    level.vehicles.hitdamage.weapons[var_0] = var_2;
  }

  return var_2;
}

set_vehicle_hit_damage_data(var_0, var_1) {
  var_2 = get_vehicle_hit_damage_data(var_0, 1);
  var_2.hitstokill = var_1;
}

set_vehicle_hit_damage_data_for_weapon(var_0, var_1, var_2) {
  var_3 = get_vehicle_hit_damage_data(var_0, 1);
  var_4 = get_weapon_hit_damage_data(var_2, 1);
  var_4.vehiclehitstokill[var_0] = var_1;
}

set_weapon_hit_damage_data(var_0, var_1) {
  var_2 = get_weapon_hit_damage_data(var_0, 1);
  var_2.hitsperattack = var_1;
}

set_weapon_hit_damage_data_for_vehicle(var_0, var_1, var_2) {
  var_3 = get_weapon_hit_damage_data(var_0, 1);
  var_4 = get_vehicle_hit_damage_data(var_2, 1);
  var_4.weaponhitsperattack[var_0] = var_1;
}

init_emp_damage_data() {
  var_0 = spawnStruct();
  level.vehicles.empdamage = var_0;
  var_0.callbacks = [];
}

emp_damage_callback(var_0) {
  var_1 = var_0.victim;
  var_1 endon("_encstr_AD75063D571AE108");
  var_0.empdamageenabled = 1;
  var_1 thread callback_vehicledamage_internal(var_0);
  var_2 = get_emp_damage_callback(var_1.vehiclename);

  if(isDefined(var_2))
    thread[[var_2]](var_0);
}

get_emp_damage_callback(var_0) {
  if(!isDefined(level.vehicles))
    return undefined;
  else if(!isDefined(level.vehicles.empdamage))
    return undefined;

  return level.vehicles.empdamage.callbacks[var_0];
}

set_emp_damage_callback(var_0, var_1) {
  if(!isDefined(level.vehicles))
    return undefined;
  else if(!isDefined(level.vehicles.empdamage))
    return undefined;

  level.vehicles.empdamage.callbacks[var_0] = var_1;
  return;
}

_validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_0) && !isDefined(var_0.classname))
    return undefined;

  return var_0;
}

non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

maxspreadshotsperframe(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_0) && isDefined(var_2)) {
    var_4 = var_0 getentitynumber();
    var_5 = weaponclass(var_2) == "_encstr_A1100738A33A638123";

    if(!var_5)
      return var_3;

    var_6 = "_encstr_B40101" + gettime();
    var_7 = undefined;

    if(var_1 isdualwielding())
      var_7 = 8;
    else
      var_7 = 4;

    if(!isDefined(var_1.pelletdmg) || !isDefined(var_1.pelletdmg[var_6])) {
      var_1.pelletdmg = undefined;
      var_1.pelletdmg[var_6] = [];
    }

    if(!isDefined(var_1.pelletdmg[var_6][var_4]))
      var_1.pelletdmg[var_6][var_4] = 1;
    else if(var_1.pelletdmg[var_6][var_4] + 1 > var_7)
      var_3 = 1;
    else
      var_1.pelletdmg[var_6][var_4]++;
  }

  return var_3;
}

packdamagedata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = spawnStruct();

  if(isDefined(var_0) && isent(var_0))
    var_12.attacker = var_0;

  var_12.victim = var_1;
  var_12.damage = var_2;
  var_12.objweapon = var_3;
  var_12.meansofdeath = var_4;
  var_12.inflictor = var_5;
  var_12.point = var_6;
  var_12.direction_vec = var_7;
  var_12.modelname = int(var_8);
  var_12.partname = var_9;
  var_12.hitloc = "_encstr_8BBA05185F8B99";
  var_12.timeoffset = 150;
  var_12.tagname = var_10;
  var_12.idflags = var_11;
  var_12.damageflags = var_11;
  var_12.attacker.assistedsuicide = 0;
  return var_12;
}