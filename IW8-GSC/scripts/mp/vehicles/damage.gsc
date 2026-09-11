/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\damage.gsc
***********************************************/

function init() {
  level.vehicles = spawnStruct();
  init_hit_damage_data();
  init_mod_damage_data();
  init_damage_callback_data();
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
  var13 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, self, var2, var5, var4, var0, var6, var7, var10, var11, undefined, var3, var12);
  var13.hitloc = var8;
  var13.timeoffset = var9;
  callback_vehicledamage_internal(var13);
}

function callback_vehicledamage_internal(var0) {
  if(isDefined(var0.attacker) && isDefined(var0.attacker.classname) && var0.attacker.classname == "worldspawn") {
    var0.attacker = undefined;
  }

  if(!isDefined(var0.attacker) || !isPlayer(var0.attacker)) {
    if(isDefined(var0.attacker) && isDefined(var0.attacker.owner)) {
      var0.attacker = var0.attacker.owner;
    } else if(isDefined(var0.inflictor)) {
      if(isPlayer(var0.inflictor)) {
        var0.attacker = var0.inflictor;
      } else if(isDefined(var0.inflictor.owner)) {
        var0.attacker = var0.inflictor.owner;
      }
    } else {
      var0.attacker = undefined;
    }
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  if(isDefined(var0.attacker)) {
    if(isDefined(level.validateattacker)) {
      var1 = [[level.validateattacker]](var0.attacker);
    } else {
      var1 = scripts\mp\utility\damage::_validateattacker(var1.attacker);
    }

    if(!isDefined(var1)) {
      return;
    }
  }

  if(game["state"] == "postgame") {
    return;
  }

  if(var1.damage <= 0) {
    return;
  }

  if(isDefined(self.ref_13a32) && gettime() < self.ref_13a32) {
    return;
  }

  if(should_filter_out_friendly_damage(var1)) {
    if(filter_out_friendly_damage(self, var1.attacker)) {
      return;
    }
  }

  var2 = scripts\engine\utility::isbulletdamage(var1.meansofdeath);

  if(var2) {
    if(isDefined(var1.attacker) && isPlayer(var1.attacker) && (!isDefined(var1.inflictor) || var1.inflictor == var1.attacker)) {
      var3 = var1.attacker scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var3) && var3 == self) {
        return;
      }
    }
  }

  var4 = var1.damage;
  var5 = self.vehiclename;

  if(isDefined(var1.attacker) && isPlayer(var1.attacker) && isDefined(level.ref_1425a) && isDefined(self.ref_12970)) {
    if(self.center_node.size > 0) {
      if(self.center_node[self.center_node.size - 1] != var1.attacker) {
        self.center_node[self.center_node.size] = var1.attacker;
      }
    } else {
      self.center_node[self.center_node.size] = var1.attacker;
    }
  }

  if(isDefined(var5)) {
    var6 = get_pre_mod_damage_callback(var5);

    if(isDefined(var6)) {
      var7 = self[[var6]](var1);

      if(!istrue(var7)) {
        return;
      }
    }
  }

  if(scripts\mp\utility\damage::non_player_should_ignore_damage(var1.attacker, var1.objweapon, var1.inflictor, var1.meansofdeath)) {
    return;
  }

  if(var1.meansofdeath == "MOD_MELEE") {
    if(isDefined(var5) && var5 == "radar_drone_recon") {} else if(isDefined(var1.attacker) && isPlayer(var1.attacker)) {
      var1.attacker scripts\cp_mp\pet_watch::ref_13c43(self);
    }
  }

  if(isDefined(var1.objweapon)) {
    if(isDefined(var1.objweapon.basename)) {
      var8 = var1.victim scripts\cp_mp\vehicles\vehicle::isvehicle();
      var9 = _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var1.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr();
      var10 = var1.damage;

      if(var8 && !var9) {
        if(var1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var1.damage = int(var10 * level.pistolslide);
        } else if(var1.objweapon.basename == "tur_gun_bt_mp") {
          var1.damage = int(var10 * level.findnewplunderextractsite);
        }
      } else if(var1.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function()) {
        if(var1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var1.damage = int(var10 * level.pingedenemies);
        } else if(var1.objweapon.basename == "tur_gun_bt_mp") {
          var1.damage = int(var10 * level.findgunsmithattachments);
        }
      } else if(var1.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
        if(var1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var1.damage = int(var10 * level.ping_response_time);
        } else if(var1.objweapon.basename == "tur_gun_bt_mp") {
          var1.damage = int(var10 * level.findfirstaliveplayer);
        }
      }
    }
  }

  longgulagstream(var1);

  if(isDefined(level.ref_11ca1)) {
    var1.damage = self[[level.ref_11ca1]](var1);
  }

  if(var1.damage <= 0) {
    return;
  }

  if(var1.meansofdeath == "MOD_MELEE") {
    if(isDefined(var5) && var5 == "radar_drone_recon") {} else {
      var11 = 0;

      if(isDefined(level.ref_11c66)) {
        var11 = self[[level.ref_11c66]](var1);
      }

      if(!var11) {
        var1.damage = 0;
      }
    }
  } else if(var1.meansofdeath == "MOD_IMPACT") {
    if(isDefined(var1.inflictor) && isai(var1.inflictor) && isDefined(var1.inflictor.unittype) && var1.inflictor.unittype == "zombie") {} else if(isDefined(var5) && var5 == "radar_drone_recon" && scripts\mp\utility\weapon::isthrowingknife(var1.objweapon)) {} else {
      var1.damage = 0;
    }
  } else if(isexplosivedamagemod(var1.meansofdeath) || var1.meansofdeath == "MOD_FIRE") {
    if(isDefined(level.ref_11c6b) && self[[level.ref_11c6b]](var1)) {
      var1.damage = 0;
    } else if(scripts\mp\utility\weapon::unset_relic_damage_from_above(var1.objweapon)) {
      var1.damage = scripts\cp\utility\cp_controlled_callbacks::ref_12ec3(var1);
    } else if(scripts\mp\damage::usefaillaststandmsg(var1.objweapon)) {
      var1.damage = 0;
    } else if(isDefined(var5)) {
      var1.damage = get_hit_damage(var1.damage, self, var1.objweapon);
    }
  } else if(var2) {
    if(scripts\mp\damage::usetimeoverride(var1.objweapon)) {
      var1.damage = scripts\mp\damage::ref_13714(self, var1.attacker, var1.objweapon, var1.damage, var1.idflags);
    } else if(scripts\mp\damage::uavworstid(var1.objweapon)) {
      if(scripts\mp\damage::ref_132f0(var1.objweapon)) {
        var1.damage = 1;
      } else {
        var1.damage = 0;
      }
    } else if(scripts\mp\damage::vehicle_collision_getleveldataforvehicle(var1.objweapon)) {
      if(!scripts\mp\damage::ref_1332d(var1.objweapon)) {
        var1.damage = 0;
      }
    } else if(scripts\mp\damage::turn_on_laser_trap(var1.objweapon, var1.meansofdeath)) {
      var1.damage = 0;
    } else if(isDefined(var5)) {
      var1.damage = get_mod_damage(var1.damage, self, var1.objweapon, var1.attacker);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_logevent(self, var1);

  if(isDefined(var5)) {
    var12 = get_post_mod_damage_callback(var5);

    if(isDefined(var12)) {
      var7 = self[[var12]](var1);

      if(!istrue(var7)) {
        return;
      }
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1417e(var1);
  scripts\cp_mp\vehicles\vehicle_damage::br_iseliminated(var1);
  var13 = scripts\cp_mp\vehicles\vehicle_damage::ref_1417d(var1);

  if(!var13) {
    var14 = scripts\cp_mp\vehicles\vehicle_damage::ref_14152();

    if(isDefined(var14) && var14 == "heavy") {
      var15 = scripts\engine\utility::ter_op(isexplosivedamagemod(var1.meansofdeath) || var1.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      var1.damage *= var15;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14180(var1, 1);
  } else {
    scripts\cp_mp\vehicles\vehicle_damage::ref_1417f(var1, var13, 1);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, var1);

  if(var1.damage <= 0) {
    return;
  }

  if(istrue(level.ref_14246)) {
    var1.damage = 0;
  }

  scripts\mp\utility\damage::non_player_log_attacker_data(var1);
  var16 = var1.damage;
  var17 = 1 - max(var4 - var16, 0) / var4;
  var18 = "hitequip";
  var19 = var1.damage >= self.health;
  var20 = istrue(var1.use_aitype) || istrue(var1.usedspawners);

  if(var20 && isDefined(var1.objweapon.basename)) {
    switch (var1.objweapon.basename) {
      case "pac_sentry_turret_mp":
        break;
      case "lighttank_tur_ks_mp":
      case "lighttank_tur_mp":
        if(isDefined(var1.meansofdeath) && var1.meansofdeath != "MOD_RIFLE_BULLET") {
          var1.attacker thread scripts\mp\utility\points::sec_sys_struct_1("critical_vehicle_damage");
        }

        break;
      default:
        var1.attacker thread scripts\mp\utility\points::sec_sys_struct_1("critical_vehicle_damage");
        break;
    }
  }

  if(isDefined(var1.attacker)) {
    var1.attacker scripts\mp\damagefeedback::updatedamagefeedback("hitequip", var19, var20, var18, undefined, 1);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatedamagefeedback(var1);

  if(isDefined(level.ref_120ab)) {
    self thread[[level.ref_120ab]](var1);
  }

  if(var19) {
    if(isDefined(self.deathcallback)) {
      self thread[[self.deathcallback]](var1.inflictor, var1.attacker, var1.damage, var1.idflags, var1.meansofdeath, var1.objweapon, var1.point, var1.dir, var1.hitloc, var1.timeoffset, var1.modelindex, var1.partname);
      return;
    }

    if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback)) {
      self thread[[level.vehicles.deathcallback]](var1);
      return;
    }

    self vehicle_finishdamage(var1.inflictor, var1.attacker, int(var1.damage), var1.idflags, var1.meansofdeath, var1.objweapon, var1.point, var1.direction_vec, var1.hitloc, var1.timeoffset, var1.modelname, var1.partname);
    return;
  }

  var21 = "";

  switch (var1.partname) {
    case "tag_wheel_center_front_left":
      var21 = "blowUpTire0";
      break;
    case "tag_wheel_center_front_right":
      var21 = "blowUpTire1";
      break;
    case "tag_wheel_center_back_left":
      var21 = "blowUpTire2";
      break;
    case "tag_wheel_center_back_right":
      var21 = "blowUpTire3";
      break;
  }

  if(self isscriptable() && self getscriptablehaspart(var21) && self getscriptableparthasstate(var21, "blowup")) {
    self setscriptablepartstate(var21, "blowUp", 1);
  }

  self vehicle_finishdamage(var1.inflictor, var1.attacker, int(var1.damage), var1.damageflags, var1.meansofdeath, var1.objweapon, var1.point, var1.direction_vec, var1.hitloc, var1.timeoffset, var1.modelname, var1.partname);
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
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  scripts\mp\utility\damage::non_player_clear_attacker_data();
  scripts\mp\events::vehiclekilled(var0);
}

function filter_out_friendly_damage(var0, var1, var2) {
  if((!isDefined(var1) || !isPlayer(var1)) && !isDefined(var2)) {
    return 0;
  }

  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isownerdamageenabled(var0)) {
    if(isDefined(var1) && isDefined(var0.owner) && var1 == var0.owner) {
      return 0;
    }
  }

  var3 = istrue(level.vehiclefriendlydamage) || false;

  if(level.teambased) {
    if(!var3) {
      if(isDefined(var2) && !isDefined(var1)) {
        return scripts\cp_mp\vehicles\vehicle::ref_141ba(var0, var2);
      } else {
        return scripts\cp_mp\vehicles\vehicle::ref_141b9(var0, var1);
      }
    }

    return 0;
  }

  if(!var3) {
    if(isDefined(var1)) {
      return scripts\cp_mp\vehicles\vehicle::ref_141b9(var0, var1);
    }

    return 0;
  }

  return 0;
}

function should_filter_out_friendly_damage(var0) {
  if(isDefined(var0.objweapon)) {
    var1 = undefined;

    if(isstring(var0.objweapon)) {
      var1 = var0.objweapon;
    } else {
      var1 = var0.objweapon.basename;
    }

    if(var1 == "nuke_mp") {
      return false;
    }
  }

  return true;
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
  return ceil(var0 * var4);
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
        var16 = scripts\mp\utility\weapon::attachmentmap_tobase(var16);
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

    if(var1 method_87b6()) {
      var4 += 1;
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

function longgulagstream(var0) {
  if(!isDefined(var0.attacker) || !isDefined(var0.victim) || !isDefined(var0.victim.team) || !isDefined(var0.attacker.team) || var0.attacker.team == var0.victim.team) {
    return;
  }

  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0.victim, 0);

  if(!isDefined(var1) || var1.size <= 0) {
    return;
  }

  var2 = var0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr();

  if(!istrue(var2)) {
    return;
  }

  var3 = isDefined(var0.objweapon) && scripts\mp\utility\weapon::unset_relic_damage_from_above(var0.objweapon);

  if(!istrue(var3)) {
    return;
  }

  foreach(var5 in var1) {
    if(isDefined(var5.arenapickupattachments)) {
      continue;
    }

    thread ref_13342();
  }
}

function ref_13342() {
  var0 = self;
  level endon("game_ended");
  var0 endon("disconnect");
  var0.arenapickupattachments = 1;
  var0 thread scripts\mp\hud_message::showsplash("br_fd_aa_turret_warning");
  wait 5;
  var0.arenapickupattachments = undefined;
}