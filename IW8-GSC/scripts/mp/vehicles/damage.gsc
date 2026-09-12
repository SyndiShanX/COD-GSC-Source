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
  var_0 = spawnStruct();
  var_0.premoddamagecallbacks = [];
  var_0.postmoddamagecallbacks = [];
  var_0.deathcallbacks = [];
  level.vehicles.damagecallbacks = var_0;
}

function get_pre_mod_damage_callback(var_0) {
  return level.vehicles.damagecallbacks.premoddamagecallbacks[var_0];
}

function get_post_mod_damage_callback(var_0) {
  return level.vehicles.damagecallbacks.postmoddamagecallbacks[var_0];
}

function get_death_callback(var_0) {
  return level.vehicles.damagecallbacks.deathcallbacks[var_0];
}

function set_pre_mod_damage_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.premoddamagecallbacks[var_0] = var_1;
}

function set_post_mod_damage_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.postmoddamagecallbacks[var_0] = var_1;
}

function set_death_callback(var_0, var_1) {
  level.vehicles.damagecallbacks.deathcallbacks[var_0] = var_1;
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self endon("death");
  var_13 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_5, var_4, var_0, var_6, var_7, var_10, var_11, undefined, var_3, var_12);
  var_13.hitloc = var_8;
  var_13.timeoffset = var_9;
  callback_vehicledamage_internal(var_13);
}

function callback_vehicledamage_internal(var_0) {
  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "worldspawn") {
    var_0.attacker = undefined;
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;
    } else if(isDefined(var_0.inflictor)) {
      if(isPlayer(var_0.inflictor)) {
        var_0.attacker = var_0.inflictor;
      } else if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      }
    } else {
      var_0.attacker = undefined;
    }
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  if(isDefined(var_0.attacker)) {
    if(isDefined(level.validateattacker)) {
      var_1 = [[level.validateattacker]](var_0.attacker);
    } else {
      var_1 = scripts\mp\utility\damage::_validateattacker(var_1.attacker);
    }

    if(!isDefined(var_1)) {
      return;
    }
  }

  if(game["state"] == "postgame") {
    return;
  }

  if(var_1.damage <= 0) {
    return;
  }

  if(isDefined(self.ref_13A32) && gettime() < self.ref_13A32) {
    return;
  }

  if(should_filter_out_friendly_damage(var_1)) {
    if(filter_out_friendly_damage(self, var_1.attacker)) {
      return;
    }
  }

  var_2 = scripts\engine\utility::isbulletdamage(var_1.meansofdeath);

  if(var_2) {
    if(isDefined(var_1.attacker) && isPlayer(var_1.attacker) && (!isDefined(var_1.inflictor) || var_1.inflictor == var_1.attacker)) {
      var_3 = var_1.attacker scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_3) && var_3 == self) {
        return;
      }
    }
  }

  var_4 = var_1.damage;
  var_5 = self.vehiclename;

  if(isDefined(var_1.attacker) && isPlayer(var_1.attacker) && isDefined(level.ref_1425A) && isDefined(self.ref_12970)) {
    if(self.center_node.size > 0) {
      if(self.center_node[self.center_node.size - 1] != var_1.attacker) {
        self.center_node[self.center_node.size] = var_1.attacker;
      }
    } else {
      self.center_node[self.center_node.size] = var_1.attacker;
    }
  }

  if(isDefined(var_5)) {
    var_6 = get_pre_mod_damage_callback(var_5);

    if(isDefined(var_6)) {
      var_7 = self[[var_6]](var_1);

      if(!istrue(var_7)) {
        return;
      }
    }
  }

  if(scripts\mp\utility\damage::non_player_should_ignore_damage(var_1.attacker, var_1.objweapon, var_1.inflictor, var_1.meansofdeath)) {
    return;
  }

  if(var_1.meansofdeath == "MOD_MELEE") {
    if(isDefined(var_5) && var_5 == "radar_drone_recon") {} else if(isDefined(var_1.attacker) && isPlayer(var_1.attacker)) {
      var_1.attacker scripts\cp_mp\pet_watch::ref_13C43(self);
    }
  }

  if(isDefined(var_1.objweapon)) {
    if(isDefined(var_1.objweapon.basename)) {
      var_8 = var_1.victim scripts\cp_mp\vehicles\vehicle::isvehicle();
      var_9 = _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_1.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr();
      var_10 = var_1.damage;

      if(var_8 && !var_9) {
        if(var_1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var_1.damage = int(var_10 * level.pistolslide);
        } else if(var_1.objweapon.basename == "tur_gun_bt_mp") {
          var_1.damage = int(var_10 * level.findnewplunderextractsite);
        }
      } else if(var_1.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function()) {
        if(var_1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var_1.damage = int(var_10 * level.pingedenemies);
        } else if(var_1.objweapon.basename == "tur_gun_bt_mp") {
          var_1.damage = int(var_10 * level.findgunsmithattachments);
        }
      } else if(var_1.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
        if(var_1.objweapon.basename == "tur_gun_fd_mp_seeking") {
          var_1.damage = int(var_10 * level.ping_response_time);
        } else if(var_1.objweapon.basename == "tur_gun_bt_mp") {
          var_1.damage = int(var_10 * level.findfirstaliveplayer);
        }
      }
    }
  }

  longgulagstream(var_1);

  if(isDefined(level.ref_11CA1)) {
    var_1.damage = self[[level.ref_11CA1]](var_1);
  }

  if(var_1.damage <= 0) {
    return;
  }

  if(var_1.meansofdeath == "MOD_MELEE") {
    if(isDefined(var_5) && var_5 == "radar_drone_recon") {} else {
      var_11 = 0;

      if(isDefined(level.ref_11C66)) {
        var_11 = self[[level.ref_11C66]](var_1);
      }

      if(!var_11) {
        var_1.damage = 0;
      }
    }
  } else if(var_1.meansofdeath == "MOD_IMPACT") {
    if(isDefined(var_1.inflictor) && isai(var_1.inflictor) && isDefined(var_1.inflictor.unittype) && var_1.inflictor.unittype == "zombie") {} else if(isDefined(var_5) && var_5 == "radar_drone_recon" && scripts\mp\utility\weapon::isthrowingknife(var_1.objweapon)) {} else {
      var_1.damage = 0;
    }
  } else if(isexplosivedamagemod(var_1.meansofdeath) || var_1.meansofdeath == "MOD_FIRE") {
    if(isDefined(level.ref_11C6B) && self[[level.ref_11C6B]](var_1)) {
      var_1.damage = 0;
    } else if(scripts\mp\utility\weapon::unset_relic_damage_from_above(var_1.objweapon)) {
      var_1.damage = scripts\cp\utility\cp_controlled_callbacks::ref_12EC3(var_1);
    } else if(scripts\mp\damage::usefaillaststandmsg(var_1.objweapon)) {
      var_1.damage = 0;
    } else if(isDefined(var_5)) {
      var_1.damage = get_hit_damage(var_1.damage, self, var_1.objweapon);
    }
  } else if(var_2) {
    if(scripts\mp\damage::usetimeoverride(var_1.objweapon)) {
      var_1.damage = scripts\mp\damage::ref_13714(self, var_1.attacker, var_1.objweapon, var_1.damage, var_1.idflags);
    } else if(scripts\mp\damage::uavworstid(var_1.objweapon)) {
      if(scripts\mp\damage::ref_132F0(var_1.objweapon)) {
        var_1.damage = 1;
      } else {
        var_1.damage = 0;
      }
    } else if(scripts\mp\damage::vehicle_collision_getleveldataforvehicle(var_1.objweapon)) {
      if(!scripts\mp\damage::ref_1332D(var_1.objweapon)) {
        var_1.damage = 0;
      }
    } else if(scripts\mp\damage::turn_on_laser_trap(var_1.objweapon, var_1.meansofdeath)) {
      var_1.damage = 0;
    } else if(isDefined(var_5)) {
      var_1.damage = get_mod_damage(var_1.damage, self, var_1.objweapon, var_1.attacker);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_logevent(self, var_1);

  if(isDefined(var_5)) {
    var_12 = get_post_mod_damage_callback(var_5);

    if(isDefined(var_12)) {
      var_7 = self[[var_12]](var_1);

      if(!istrue(var_7)) {
        return;
      }
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1417E(var_1);
  scripts\cp_mp\vehicles\vehicle_damage::br_iseliminated(var_1);
  var_13 = scripts\cp_mp\vehicles\vehicle_damage::ref_1417D(var_1);

  if(!var_13) {
    var_14 = scripts\cp_mp\vehicles\vehicle_damage::ref_14152();

    if(isDefined(var_14) && var_14 == "heavy") {
      var_15 = scripts\engine\utility::ter_op(isexplosivedamagemod(var_1.meansofdeath) || var_1.meansofdeath == "MOD_FIRE", 0.15, 0.25);
      var_1.damage *= var_15;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14180(var_1, 1);
  } else {
    scripts\cp_mp\vehicles\vehicle_damage::ref_1417F(var_1, var_13, 1);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, var_1);

  if(var_1.damage <= 0) {
    return;
  }

  if(istrue(level.ref_14246)) {
    var_1.damage = 0;
  }

  scripts\mp\utility\damage::non_player_log_attacker_data(var_1);
  var_16 = var_1.damage;
  var_17 = 1 - max(var_4 - var_16, 0) / var_4;
  var_18 = "hitequip";
  var_19 = var_1.damage >= self.health;
  var_20 = istrue(var_1.use_aitype) || istrue(var_1.usedspawners);

  if(var_20 && isDefined(var_1.objweapon.basename)) {
    switch (var_1.objweapon.basename) {
      case "pac_sentry_turret_mp":
        break;
      case "lighttank_tur_ks_mp":
      case "lighttank_tur_mp":
        if(isDefined(var_1.meansofdeath) && var_1.meansofdeath != "MOD_RIFLE_BULLET") {
          var_1.attacker thread scripts\mp\utility\points::sec_sys_struct_1("critical_vehicle_damage");
        }

        break;
      default:
        var_1.attacker thread scripts\mp\utility\points::sec_sys_struct_1("critical_vehicle_damage");
        break;
    }
  }

  if(isDefined(var_1.attacker)) {
    var_1.attacker scripts\mp\damagefeedback::updatedamagefeedback("hitequip", var_19, var_20, var_18, undefined, 1);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatedamagefeedback(var_1);

  if(isDefined(level.ref_120AB)) {
    self thread[[level.ref_120AB]](var_1);
  }

  if(var_19) {
    if(isDefined(self.deathcallback)) {
      self thread[[self.deathcallback]](var_1.inflictor, var_1.attacker, var_1.damage, var_1.idflags, var_1.meansofdeath, var_1.objweapon, var_1.point, var_1.dir, var_1.hitloc, var_1.timeoffset, var_1.modelindex, var_1.partname);
      return;
    }

    if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback)) {
      self thread[[level.vehicles.deathcallback]](var_1);
      return;
    }

    self vehicle_finishdamage(var_1.inflictor, var_1.attacker, int(var_1.damage), var_1.idflags, var_1.meansofdeath, var_1.objweapon, var_1.point, var_1.direction_vec, var_1.hitloc, var_1.timeoffset, var_1.modelname, var_1.partname);
    return;
  }

  var_21 = "";

  switch (var_1.partname) {
    case "tag_wheel_center_front_left":
      var_21 = "blowUpTire0";
      break;
    case "tag_wheel_center_front_right":
      var_21 = "blowUpTire1";
      break;
    case "tag_wheel_center_back_left":
      var_21 = "blowUpTire2";
      break;
    case "tag_wheel_center_back_right":
      var_21 = "blowUpTire3";
      break;
  }

  if(self isscriptable() && self getscriptablehaspart(var_21) && self getscriptableparthasstate(var_21, "blowup")) {
    self setscriptablepartstate(var_21, "blowUp", 1);
  }

  self vehicle_finishdamage(var_1.inflictor, var_1.attacker, int(var_1.damage), var_1.damageflags, var_1.meansofdeath, var_1.objweapon, var_1.point, var_1.direction_vec, var_1.hitloc, var_1.timeoffset, var_1.modelname, var_1.partname);
}

function callback_vehicledeath(var_0) {
  var_1 = self.vehiclename;

  if(isDefined(var_1)) {
    var_2 = get_death_callback(var_1);

    if(isDefined(var_2)) {
      var_3 = gettime();
      var_4 = self[[var_2]](var_0);

      if(!istrue(var_4)) {
        return;
      }
    }
  }

  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  scripts\mp\utility\damage::non_player_clear_attacker_data();
  scripts\mp\events::vehiclekilled(var_0);
}

function filter_out_friendly_damage(var_0, var_1, var_2) {
  if((!isDefined(var_1) || !isPlayer(var_1)) && !isDefined(var_2)) {
    return 0;
  }

  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isownerdamageenabled(var_0)) {
    if(isDefined(var_1) && isDefined(var_0.owner) && var_1 == var_0.owner) {
      return 0;
    }
  }

  var_3 = istrue(level.vehiclefriendlydamage) || false;

  if(level.teambased) {
    if(!var_3) {
      if(isDefined(var_2) && !isDefined(var_1)) {
        return scripts\cp_mp\vehicles\vehicle::ref_141BA(var_0, var_2);
      } else {
        return scripts\cp_mp\vehicles\vehicle::ref_141B9(var_0, var_1);
      }
    }

    return 0;
  }

  if(!var_3) {
    if(isDefined(var_1)) {
      return scripts\cp_mp\vehicles\vehicle::ref_141B9(var_0, var_1);
    }

    return 0;
  }

  return 0;
}

function should_filter_out_friendly_damage(var_0) {
  if(isDefined(var_0.objweapon)) {
    var_1 = undefined;

    if(isstring(var_0.objweapon)) {
      var_1 = var_0.objweapon;
    } else {
      var_1 = var_0.objweapon.basename;
    }

    if(var_1 == "nuke_mp") {
      return false;
    }
  }

  return true;
}

function init_mod_damage_data() {
  var_0 = spawnStruct();
  level.vehicles.moddamage = var_0;
  var_0.vehicles = [];
  var_0.weaponclasses = [];
  var_0.perks = [];
  var_0.attachments = [];
}

function get_mod_damage(var_0, var_1, var_2, var_3) {
  var_4 = get_mod_damage_modifier(var_1, var_2, var_3);
  return ceil(var_0 * var_4);
}

function get_mod_damage_modifier(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;
  var_5 = var_0.vehiclename;
  var_6 = get_vehicle_mod_damage_data(var_0.vehiclename);

  if(isDefined(var_6)) {
    var_7 = var_1.classname;
    var_8 = get_weapon_class_mod_damage_data(var_7);

    if(isDefined(var_8)) {
      var_9 = var_6.weaponclassdata[var_7];

      if(isDefined(var_9)) {
        var_8 = var_9;
      }

      if(var_8.modifier != 0) {
        if(var_8.ismultiplicative) {
          var_4 *= var_8.modifier;
        } else {
          var_3 += var_8.modifier;
        }
      }
    }

    if(isDefined(var_2) && isDefined(var_2.perks)) {
      foreach(var_11 in var_2.perks) {
        var_12 = get_perk_mod_damage_data(var_14);

        if(isDefined(var_12)) {
          var_13 = var_6.perkdata[var_14];

          if(isDefined(var_13)) {
            var_12 = var_13;
          }

          if(var_12.modifier != 0) {
            if(var_12.ismultiplicative) {
              var_4 *= var_12.modifier;
            } else {
              var_3 += var_12.modifier;
            }
          }
        }
      }
    }

    if(isDefined(var_1.attachments)) {
      foreach(var_16 in var_1.attachments) {
        var_16 = scripts\mp\utility\weapon::attachmentmap_tobase(var_16);
        var_17 = get_attachment_mod_damage_data(var_16);

        if(isDefined(var_17)) {
          var_18 = var_6.attachmentdata[var_16];

          if(isDefined(var_18)) {
            var_17 = var_18;
          }

          if(var_17.modifier != 0) {
            if(var_17.ismultiplicative) {
              var_4 *= var_17.modifier;
            } else {
              var_3 += var_17.modifier;
            }
          }
        }
      }
    }

    if(var_1 method_87b6()) {
      var_4 += 1;
    }
  }

  return var_3 + var_4;
}

function get_vehicle_mod_damage_data(var_0, var_1) {
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

function get_weapon_class_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.weaponclasses[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.weaponclasses[var_0] = var_2;
  }

  return var_2;
}

function get_perk_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.perks[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.perks[var_0] = var_2;
  }

  return var_2;
}

function get_attachment_mod_damage_data(var_0, var_1) {
  var_2 = level.vehicles.moddamage.attachments[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = create_mod_damage_data_empty();
    level.vehicles.moddamage.attachments[var_0] = var_2;
  }

  return var_2;
}

function set_weapon_class_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_weapon_class_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

function set_weapon_class_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_weapon_class_mod_damage_data(var_0, 1);
  var_5 = var_4.weaponclassdata[var_0];

  if(!isDefined(var_5)) {
    var_5 = create_mod_damage_data_empty();
  }

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.weaponclassdata[var_0] = var_5;
}

function set_perk_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_perk_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

function set_perk_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_perk_mod_damage_data(var_0, 1);
  var_5 = var_4.perkdata[var_0];

  if(!isDefined(var_5)) {
    var_5 = create_mod_damage_data_empty();
  }

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.perkdata[var_0] = var_5;
}

function set_attachment_mod_damage_data(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = get_attachment_mod_damage_data(var_0, 1);
  var_3.modifier = var_1;
  var_3.ismultiplicative = var_2;
}

function set_attachment_mod_damage_data_for_vehicle(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = get_vehicle_mod_damage_data(var_3, 1);
  get_attachment_mod_damage_data(var_0, 1);
  var_5 = var_4.attachmentdata[var_0];

  if(!isDefined(var_5)) {
    var_5 = create_mod_damage_data_empty();
  }

  var_5.modifier = var_1;
  var_5.ismultiplicative = var_2;
  var_4.attachmentdata[var_0] = var_5;
}

function create_mod_damage_data_empty() {
  var_0 = spawnStruct();
  var_0.modifier = 0;
  var_0.ismultiplicative = 0;
  return var_0;
}

function init_hit_damage_data() {
  var_0 = spawnStruct();
  level.vehicles.hitdamage = var_0;
  var_0.vehicles = [];
  var_0.weapons = [];
}

function get_hit_damage(var_0, var_1, var_2) {
  var_3 = var_1.vehiclename;
  var_4 = var_2.basename;
  var_5 = get_vehicle_hit_damage_data(var_3);
  var_6 = get_weapon_hit_damage_data(var_4);

  if(isDefined(var_5) && isDefined(var_6)) {
    var_7 = var_6.vehiclehitstokill[var_3];

    if(!isDefined(var_7) || var_7 == 0) {
      var_7 = var_5.hitstokill;
    }

    var_8 = var_5.weaponhitsperattack[var_4];

    if(!isDefined(var_8) || var_8 == 0) {
      var_8 = var_6.hitsperattack;
    }

    if(var_7 > 0 && var_8 > 0) {
      var_9 = var_8 / var_7;
      var_0 = int(ceil(var_9 * var_1.maxhealth));
    }
  }

  return var_0;
}

function get_vehicle_hit_damage_data(var_0, var_1) {
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

function get_weapon_hit_damage_data(var_0, var_1) {
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

function set_vehicle_hit_damage_data(var_0, var_1) {
  var_2 = get_vehicle_hit_damage_data(var_0, 1);
  var_2.hitstokill = var_1;
}

function set_vehicle_hit_damage_data_for_weapon(var_0, var_1, var_2) {
  var_3 = get_vehicle_hit_damage_data(var_0, 1);
  var_4 = get_weapon_hit_damage_data(var_2, 1);
  var_4.vehiclehitstokill[var_0] = var_1;
}

function set_weapon_hit_damage_data(var_0, var_1) {
  var_2 = get_weapon_hit_damage_data(var_0, 1);
  var_2.hitsperattack = var_1;
}

function set_weapon_hit_damage_data_for_vehicle(var_0, var_1, var_2) {
  var_3 = get_weapon_hit_damage_data(var_0, 1);
  var_4 = get_vehicle_hit_damage_data(var_2, 1);
  var_4.weaponhitsperattack[var_0] = var_1;
}

function longgulagstream(var_0) {
  if(!isDefined(var_0.attacker) || !isDefined(var_0.victim) || !isDefined(var_0.victim.team) || !isDefined(var_0.attacker.team) || var_0.attacker.team == var_0.victim.team) {
    return;
  }

  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0.victim, 0);

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }

  var_2 = var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr();

  if(!istrue(var_2)) {
    return;
  }

  var_3 = isDefined(var_0.objweapon) && scripts\mp\utility\weapon::unset_relic_damage_from_above(var_0.objweapon);

  if(!istrue(var_3)) {
    return;
  }

  foreach(var_5 in var_1) {
    if(isDefined(var_5.arenapickupattachments)) {
      continue;
    }

    thread ref_13342();
  }
}

function ref_13342() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.arenapickupattachments = 1;
  var_0 thread scripts\mp\hud_message::showsplash("br_fd_aa_turret_warning");
  wait 5;
  var_0.arenapickupattachments = undefined;
}