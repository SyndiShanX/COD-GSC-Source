/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\damage_cp.gsc
***********************************************/

function init() {
  level.vehicles = spawnStruct();
  level.player_xp = &packdamagedata;
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
  init_emp_damage_data();
}

function init_damage_callback_data() {
  level.vehicles.damagecallback = &callback_vehicledamage;
  level.vehicles.deathcallback = &callback_vehicledeath;
  var0 = spawnStruct();
  var0.premoddamagecallbacks = [];
  var0.postmoddamagecallbacks = [];
  var0.deathcallbacks = [];
  level.vehicles.damagecallbacks = var0;
}

function get_pre_mod_damage_callback(var0) {
  return level.vehicles.damagecallbacks.premoddamagecallbacks[var0];
}

function get_post_mod_damage_callback(var0) {
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[var0];
}

function get_death_callback(var0) {
  return level.vehicles.damagecallbacks.deathcallbacks[var0];
}

function set_pre_mod_damage_callback(var0, var1) {
  level.vehicles.damagecallbacks.premoddamagecallbacks[var0] = var1;
}

function set_post_mod_damage_callback(var0, var1) {
  level.vehicles.damagecallbacks.postmoddamagecallbacks[var0] = var1;
}

function set_death_callback(var0, var1) {
  level.vehicles.damagecallbacks.deathcallbacks[var0] = var1;
}

function callback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  self endon("death");
  var13 = packdamagedata(var1, self, var2, var5, var4, var0, var6, var7, var10, var11, undefined, var3);
  var13.hitloc = var8;
  var13.timeoffset = var9;
  callback_vehicledamage_internal(var13);
}

function callback_vehicledamage_internal(var0) {
  if(isDefined(var0.attacker) && isDefined(var0.attacker.classname) && var0.attacker.classname == "worldspawn") {
    var0.attacker = undefined;
  }

  if(!isDefined(var0.attacker) || !isPlayer(var0.attacker) && !isagent(var0.attacker) && !isscriptedagent(var0.attacker)) {
    if(isDefined(var0.attacker) && isDefined(var0.attacker.owner)) {
      var0.attacker = var0.attacker.owner;
    } else if(isDefined(var0.inflictor)) {
      if(isPlayer(var0.inflictor) || isagent(var0.inflictor) || isscriptedagent(var0.inflictor)) {
        var0.attacker = var0.inflictor;
      } else if(isDefined(var0.inflictor.owner)) {
        var0.attacker = var0.inflictor.owner;
      } else {
        var0.attacker = var0.inflictor;
      }
    } else {
      var0.attacker = undefined;
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

  if(var0.damage <= 0) {
    return;
  }

  if(isDefined(var0.attacker)) {
    if(isDefined(self.occupants) && self.occupants.size > 0) {
      if(scripts\engine\utility::array_contains(self.occupants, var0.attacker)) {
        if(isDefined(var0.attacker.team)) {
          if(isDefined(self.ref_13aad) && var0.attacker.team == self.ref_13aad) {
            return;
          }
        }
      }
    }
  }

  if(isDefined(var0.attacker) && isDefined(var0.attacker.vehicle)) {
    if(!isDefined(var0.attacker.team)) {
      if(isDefined(var0.attacker.vehicle.team)) {
        var0.attacker.team = var0.attacker.vehicle.team;
      }
    }
  }

  var1 = var0.damage;
  var2 = self.vehiclename;

  if(isDefined(var2)) {
    var3 = get_pre_mod_damage_callback(var2);

    if(isDefined(var3)) {
      var4 = self[[var3]](var0);

      if(!istrue(var4)) {
        return;
      }
    }
  }

  if(var0.damage <= 0) {
    return;
  }

  if(var0.meansofdeath == "MOD_MELEE") {
    var0.damage = 0;
  } else if(var0.meansofdeath == "MOD_IMPACT") {
    var0.damage = 0;
  } else if(isexplosivedamagemod(var0.meansofdeath)) {
    if(isDefined(var2)) {
      var0.damage = get_hit_damage(var0.damage, self, var0.objweapon);
    }
  } else if(scripts\engine\utility::isbulletdamage(var0.meansofdeath)) {
    if(maxspreadshotsperframe(self, var0.attacker, var0.objweapon)) {
      var0.damage = 0;
    } else if(isDefined(var2)) {
      var0.damage = get_mod_damage(var0.damage, self, var0.objweapon, var0.attacker);
    }
  }

  if(isDefined(var2)) {
    var5 = get_post_mod_damage_callback(var2);

    if(isDefined(var5)) {
      var4 = self[[var5]](var0);

      if(!istrue(var4)) {
        return;
      }
    }
  }

  var6 = scripts\cp_mp\vehicles\vehicle_damage::ref_1417d(var0);

  if(!var6) {
    var7 = scripts\cp_mp\vehicles\vehicle_damage::ref_14152();

    if(isDefined(var7) && var7 == "heavy") {
      var8 = scripts\engine\utility::ter_op(isexplosivedamagemod(var0.meansofdeath) || var0.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      var0.damage *= var8;
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14180(var0, 1);
  var9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

  if(isDefined(var9)) {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, var0);
  }

  if(var0.damage <= 0) {
    return;
  }

  if(isDefined(self.vehiclename) && self.vehiclename == "light_tank") {
    self notify("alerted", var0);
  }

  var10 = var0.damage;
  var11 = 1 - max(var1 - var10, 0) / var1;
  var12 = "standard";
  var13 = var0.damage >= self.health;

  if(isPlayer(var0.attacker)) {
    var0.attacker scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", var13, undefined, var12, undefined, 1);
    scripts\cp\cp_agent_damage::addattacker(self, var0.attacker, var0.inflictor, var0.objweapon, var0.damage, var0.point, var0.direction_vec, var0.hitloc, var0.timeoffset, var0.meansofdeath);
  }

  if(isDefined(self.occupants)) {
    var14 = int(clamp((self.health - var0.damage) / self.maxhealth * 100, 0, 100));

    foreach(var16 in self.occupants) {
      var16 setclientomnvar("ui_veh_health_percent", int(var14));
      var16 setclientomnvar("ui_veh_show_health", 1);
    }
  }

  if(var13) {
    if(isPlayer(var0.attacker)) {
      if(isDefined(self.riders) && self.riders.size > 0) {
        var0.attacker thread scripts\mp\mp_agent_damage::vip_playerdied(undefined, self, var0.objweapon, var0.meansofdeath, var0.inflictor, 0);
      }

      thread scripts\mp\ammorestock::onplayerkilled(var0.inflictor, var0.attacker, int(var0.damage), var0.idflags, var0.meansofdeath, var0.objweapon, var0.hitloc, var0.attacker.modifiers);
    }

    if(isDefined(self.deathcallback)) {
      self thread[[self.deathcallback]](var0.inflictor, var0.attacker, var0.damage, var0.idflags, var0.meansofdeath, var0.objweapon, var0.point, var0.dir, var0.hitloc, var0.timeoffset, var0.modelindex, var0.partname);
      return;
    }

    if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback)) {
      self thread[[level.vehicles.deathcallback]](var0);
      return;
    }

    self vehicle_finishdamage(var0.inflictor, var0.attacker, int(var0.damage), var0.idflags, var0.meansofdeath, var0.objweapon, var0.point, var0.direction_vec, var0.hitloc, var0.timeoffset, var0.modelname, var0.partname);
    return;
  }

  self vehicle_finishdamage(var0.inflictor, var0.attacker, int(var0.damage), var0.damageflags, var0.meansofdeath, var0.objweapon, var0.point, var0.direction_vec, var0.hitloc, var0.timeoffset, var0.modelname, var0.partname);
}

function callback_vehicledeath(var0) {
  var1 = self.vehiclename;

  if(isDefined(var1)) {
    var2 = get_death_callback(var1);

    if(isDefined(var2)) {
      var3 = gettime();
      var4 = self[[var2]](var0);

      if(!istrue(var4)) {
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
  var0 = spawnStruct();
  level.vehicles.moddamage = var0;
  var0.vehicles = [];
  var0.weaponclasses = [];
  var0.perks = [];
  var0.attachments = [];
}

function get_mod_damage(var0, var1, var2, var3) {
  var4 = get_mod_damage_modifier(var1, var2, var3);
  return var0 * var4;
}

function get_mod_damage_modifier(var0, var1, var2) {
  var3 = 0;
  var4 = 1;
  var5 = var0.vehiclename;
  var6 = get_vehicle_mod_damage_data(var0.vehiclename);

  if(isDefined(var6)) {
    var7 = var1.classname;
    var8 = get_weapon_class_mod_damage_data(var7);

    if(isDefined(var8)) {
      var9 = var6.weaponclassdata[var7];

      if(isDefined(var9)) {
        var8 = var9;
      }

      if(var8.modifier != 0) {
        if(var8.ismultiplicative) {
          var4 *= var8.modifier;
        } else {
          var3 += var8.modifier;
        }
      }
    }

    if(isDefined(var2) && isDefined(var2.perks)) {
      foreach(var11 in var2.perks) {
        var12 = get_perk_mod_damage_data(var14);

        if(isDefined(var12)) {
          var13 = var6.perkdata[var14];

          if(isDefined(var13)) {
            var12 = var13;
          }

          if(var12.modifier != 0) {
            if(var12.ismultiplicative) {
              var4 *= var12.modifier;
            } else {
              var3 += var12.modifier;
            }
          }
        }
      }
    }

    if(isDefined(var1.attachments)) {
      foreach(var16 in var1.attachments) {
        var16 = scripts\cp\utility::attachmentmap_tobase(var16);
        var17 = get_attachment_mod_damage_data(var16);

        if(isDefined(var17)) {
          var18 = var6.attachmentdata[var16];

          if(isDefined(var18)) {
            var17 = var18;
          }

          if(var17.modifier != 0) {
            if(var17.ismultiplicative) {
              var4 *= var17.modifier;
            } else {
              var3 += var17.modifier;
            }
          }
        }
      }
    }
  }

  return var3 + var4;
}

function get_vehicle_mod_damage_data(var0, var1) {
  var2 = level.vehicles.moddamage.vehicles[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = spawnStruct();
    var2.weaponclassdata = [];
    var2.perkdata = [];
    var2.attachmentdata = [];
    level.vehicles.moddamage.vehicles[var0] = var2;
  }

  return var2;
}

function get_weapon_class_mod_damage_data(var0, var1) {
  var2 = level.vehicles.moddamage.weaponclasses[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[var0] = var2;
  }

  return var2;
}

function get_perk_mod_damage_data(var0, var1) {
  var2 = level.vehicles.moddamage.perks[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[var0] = var2;
  }

  return var2;
}

function get_attachment_mod_damage_data(var0, var1) {
  var2 = level.vehicles.moddamage.attachments[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[var0] = var2;
  }

  return var2;
}

function set_weapon_class_mod_damage_data(var0, var1, var2) {
  if(var2) {}

  var3 = get_weapon_class_mod_damage_data(var0, 1);
  var3.modifier = var1;
  var3.ismultiplicative = var2;
}

function set_weapon_class_mod_damage_data_for_vehicle(var0, var1, var2, var3) {
  if(var2) {}

  var4 = get_vehicle_mod_damage_data(var3, 1);
  get_weapon_class_mod_damage_data(var0, 1);
  var5 = var4.weaponclassdata[var0];

  if(!isDefined(var5)) {
    var5 = create_mod_damage_data_empty();
  }

  var5.modifier = var1;
  var5.ismultiplicative = var2;
  var4.weaponclassdata[var0] = var5;
}

function set_perk_mod_damage_data(var0, var1, var2) {
  if(var2) {}

  var3 = get_perk_mod_damage_data(var0, 1);
  var3.modifier = var1;
  var3.ismultiplicative = var2;
}

function set_perk_mod_damage_data_for_vehicle(var0, var1, var2, var3) {
  if(var2) {}

  var4 = get_vehicle_mod_damage_data(var3, 1);
  get_perk_mod_damage_data(var0, 1);
  var5 = var4.perkdata[var0];

  if(!isDefined(var5)) {
    var5 = create_mod_damage_data_empty();
  }

  var5.modifier = var1;
  var5.ismultiplicative = var2;
  var4.perkdata[var0] = var5;
}

function set_attachment_mod_damage_data(var0, var1, var2) {
  if(var2) {}

  var3 = get_attachment_mod_damage_data(var0, 1);
  var3.modifier = var1;
  var3.ismultiplicative = var2;
}

function set_attachment_mod_damage_data_for_vehicle(var0, var1, var2, var3) {
  if(var2) {}

  var4 = get_vehicle_mod_damage_data(var3, 1);
  get_attachment_mod_damage_data(var0, 1);
  var5 = var4.attachmentdata[var0];

  if(!isDefined(var5)) {
    var5 = create_mod_damage_data_empty();
  }

  var5.modifier = var1;
  var5.ismultiplicative = var2;
  var4.attachmentdata[var0] = var5;
}

function create_mod_damage_data_empty() {
  var0 = spawnStruct();
  var0.modifier = 0;
  var0.ismultiplicative = 0;
  return var0;
}

function init_hit_damage_data() {
  var0 = spawnStruct();
  level.vehicles.hitdamage = var0;
  var0.vehicles = [];
  var0.weapons = [];
}

function get_hit_damage(var0, var1, var2) {
  var3 = var1.vehiclename;
  var4 = var2.basename;
  var5 = get_vehicle_hit_damage_data(var3);
  var6 = get_weapon_hit_damage_data(var4);

  if(isDefined(var5) && isDefined(var6)) {
    var7 = var6.vehiclehitstokill[var3];

    if(!isDefined(var7) || var7 == 0) {
      var7 = var5.hitstokill;
    }

    var8 = var5.weaponhitsperattack[var4];

    if(!isDefined(var8) || var8 == 0) {
      var8 = var6.hitsperattack;
    }

    if(var7 > 0 && var8 > 0) {
      var9 = var8 / var7;
      var0 = int(ceil(var9 * var1.maxhealth));
    }
  }

  return var0;
}

function get_vehicle_hit_damage_data(var0, var1) {
  var2 = level.vehicles.hitdamage.vehicles[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = spawnStruct();
    var2.ref = var0;
    var2.hitstokill = 0;
    var2.weaponhitsperattack = [];
    level.vehicles.hitdamage.vehicles[var0] = var2;
  }

  return var2;
}

function get_weapon_hit_damage_data(var0, var1) {
  var2 = level.vehicles.hitdamage.weapons[var0];

  if(!isDefined(var2) && istrue(var1)) {
    var2 = spawnStruct();
    var2.ref = var0;
    var2.hitsperattack = 0;
    var2.vehiclehitstokill = [];
    level.vehicles.hitdamage.weapons[var0] = var2;
  }

  return var2;
}

function set_vehicle_hit_damage_data(var0, var1) {
  var2 = get_vehicle_hit_damage_data(var0, 1);
  var2.hitstokill = var1;
}

function set_vehicle_hit_damage_data_for_weapon(var0, var1, var2) {
  var3 = get_vehicle_hit_damage_data(var0, 1);
  var4 = get_weapon_hit_damage_data(var2, 1);
  var4.vehiclehitstokill[var0] = var1;
}

function set_weapon_hit_damage_data(var0, var1) {
  var2 = get_weapon_hit_damage_data(var0, 1);
  var2.hitsperattack = var1;
}

function set_weapon_hit_damage_data_for_vehicle(var0, var1, var2) {
  var3 = get_weapon_hit_damage_data(var0, 1);
  var4 = get_vehicle_hit_damage_data(var2, 1);
  var4.weaponhitsperattack[var0] = var1;
}

function init_emp_damage_data() {
  var0 = spawnStruct();
  level.vehicles.empdamage = var0;
  var0.callbacks = [];
}

function emp_damage_callback(var0) {
  var1 = var0.victim;
  var1 endon("death");
  var0.empdamageenabled = 1;
  thread callback_vehicledamage_internal(var1);
  var2 = get_emp_damage_callback(var1.vehiclename);

  if(isDefined(var2)) {
    GscBinSkip1(0x74, var2, var0, var0);
  }
}

function get_emp_damage_callback(var0) {
  if(!isDefined(level.vehicles)) {
    return undefined;
  } else if(!isDefined(level.vehicles.empdamage)) {
    return undefined;
  }

  return level.vehicles.empdamage.callbacks[var0];
}

function set_emp_damage_callback(var0, var1) {
  if(!isDefined(level.vehicles)) {
    return undefined;
  } else if(!isDefined(level.vehicles.empdamage)) {
    return undefined;
  }

  level.vehicles.empdamage.callbacks[var0] = var1;
}

function _validateattacker(var0) {
  if(isagent(var0) && (!isDefined(var0.isactive) || !var0.isactive)) {
    return undefined;
  }

  if(isagent(var0) && !isDefined(var0.classname)) {
    return undefined;
  }

  return var0;
}

function non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

function maxspreadshotsperframe(var0, var1, var2) {
  var3 = 0;

  if(isDefined(var1) && isDefined(var0) && isDefined(var2)) {
    var4 = var0 getentitynumber();
    var5 = weaponclass(var2) == "spread";

    if(!var5) {
      return var3;
    }

    var6 = "" + gettime();
    var7 = undefined;

    if(var1 isdualwielding()) {
      var7 = 8;
    } else {
      var7 = 4;
    }

    if(!isDefined(var1.pelletdmg) || !isDefined(var1.pelletdmg[var6])) {
      var1.pelletdmg = undefined;
      var1.pelletdmg[var6] = [];
    }

    if(!isDefined(var1.pelletdmg[var6][var4])) {
      var1.pelletdmg[var6][var4] = 1;
    } else if(var1.pelletdmg[var6][var4] + 1 > var7) {
      var3 = 1;
    } else {
      var1.pelletdmg[var6][var4]++;
    }
  }

  return var3;
}

function packdamagedata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = spawnStruct();

  if(isDefined(var0) && isent(var0)) {
    var12.attacker = var0;
  }

  var12.victim = var1;
  var12.damage = var2;
  var12.objweapon = var3;
  var12.meansofdeath = var4;
  var12.inflictor = var5;
  var12.point = var6;
  var12.direction_vec = var7;
  var12.modelname = int(var8);
  var12.partname = var9;
  var12.hitloc = "none";
  var12.timeoffset = 150;
  var12.tagname = var10;
  var12.idflags = var11;
  var12.damageflags = var11;
  var12.attacker.assistedsuicide = 0;
  return var12;
}