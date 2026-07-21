/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\damage.gsc
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
  var_13 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_5, var_4, var_0, var_6, var_7, var_10, var_11, undefined, var_3, var_12);
  var_13.hitloc = var_8;
  var_13.timeoffset = var_9;
  callback_vehicledamage_internal(var_13);
}

callback_vehicledamage_internal(var_0) {
  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
    var_0.attacker = undefined;

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner))
      var_0.attacker = var_0.attacker.owner;
    else if(isDefined(var_0.inflictor)) {
      if(isPlayer(var_0.inflictor))
        var_0.attacker = var_0.inflictor;
      else if(isDefined(var_0.inflictor.owner))
        var_0.attacker = var_0.inflictor.owner;
    } else
      var_0.attacker = undefined;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(isDefined(var_0.attacker)) {
    if(isDefined(level.validateattacker))
      var_1 = [[level.validateattacker]](var_0.attacker);
    else
      var_1 = scripts\mp\utility\damage::_validateattacker(var_0.attacker);

    if(!isDefined(var_1))
      return;
  }

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    return;
  }
  if(var_0.damage <= 0) {
    return;
  }
  if(isDefined(self._id_13A32) && gettime() < self._id_13A32) {
    return;
  }
  if(should_filter_out_friendly_damage(var_0)) {
    if(filter_out_friendly_damage(self, var_0.attacker))
      return;
  }

  var_2 = scripts\engine\utility::isbulletdamage(var_0.meansofdeath);

  if(var_2) {
    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && (!isDefined(var_0.inflictor) || var_0.inflictor == var_0.attacker)) {
      var_3 = var_0.attacker scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_3) && var_3 == self)
        return;
    }
  }

  var_4 = var_0.damage;
  var_5 = self.vehiclename;

  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && isDefined(level._id_1425A) && isDefined(self._id_12970)) {
    if(self.center_node.size > 0) {
      if(self.center_node[self.center_node.size - 1] != var_0.attacker)
        self.center_node[self.center_node.size] = var_0.attacker;
    } else
      self.center_node[self.center_node.size] = var_0.attacker;
  }

  if(isDefined(var_5)) {
    var_6 = get_pre_mod_damage_callback(var_5);

    if(isDefined(var_6)) {
      var_7 = self[[var_6]](var_0);

      if(!istrue(var_7))
        return;
    }
  }

  if(scripts\mp\utility\damage::non_player_should_ignore_damage(var_0.attacker, var_0.objweapon, var_0.inflictor, var_0.meansofdeath)) {
    return;
  }
  if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    if(isDefined(var_5) && var_5 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {} else if(isDefined(var_0.attacker) && isPlayer(var_0.attacker))
      var_0.attacker scripts\cp_mp\pet_watch::_id_13C43(self);
  }

  if(isDefined(var_0.objweapon)) {
    if(isDefined(var_0.objweapon.basename)) {
      var_8 = var_0.victim scripts\cp_mp\vehicles\vehicle::isvehicle();
      var_9 = _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr();
      var_10 = var_0.damage;

      if(var_8 && !var_9) {
        if(var_0.objweapon.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
          var_0.damage = int(var_10 * level.pistolslide);
        else if(var_0.objweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
          var_0.damage = int(var_10 * level.findnewplunderextractsite);
      } else if(var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function()) {
        if(var_0.objweapon.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
          var_0.damage = int(var_10 * level.pingedenemies);
        else if(var_0.objweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
          var_0.damage = int(var_10 * level.findgunsmithattachments);
      } else if(var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
        if(var_0.objweapon.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
          var_0.damage = int(var_10 * level.ping_response_time);
        else if(var_0.objweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
          var_0.damage = int(var_10 * level.findfirstaliveplayer);
      }
    }
  }

  longgulagstream(var_0);

  if(isDefined(level._id_11CA1))
    var_0.damage = self[[level._id_11CA1]](var_0);

  if(var_0.damage <= 0) {
    return;
  }
  if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    if(isDefined(var_5) && var_5 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {} else {
      var_11 = 0;

      if(isDefined(level._id_11C66))
        var_11 = self[[level._id_11C66]](var_0);

      if(!var_11)
        var_0.damage = 0;
    }
  } else if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83") {
    if(isDefined(var_0.inflictor) && isai(var_0.inflictor) && isDefined(var_0.inflictor.unittype) && var_0.inflictor.unittype == "_encstr_BACB074025B01AAA28") {} else if(isDefined(var_5) && var_5 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" && scripts\mp\utility\weapon::isthrowingknife(var_0.objweapon)) {} else
      var_0.damage = 0;
  } else if(isexplosivedamagemod(var_0.meansofdeath) || var_0.meansofdeath == "_encstr_9B0D099AD3887D91252954") {
    if(isDefined(level._id_11C6B) && self[[level._id_11C6B]](var_0))
      var_0.damage = 0;
    else if(scripts\mp\utility\weapon::unset_relic_damage_from_above(var_0.objweapon))
      var_0.damage = scripts\cp\utility\cp_controlled_callbacks::_id_12EC3(var_0);
    else if(scripts\mp\damage::usefaillaststandmsg(var_0.objweapon))
      var_0.damage = 0;
    else if(isDefined(var_5))
      var_0.damage = get_hit_damage(var_0.damage, self, var_0.objweapon);
  } else if(var_2) {
    if(scripts\mp\damage::usetimeoverride(var_0.objweapon))
      var_0.damage = scripts\mp\damage::_id_13714(self, var_0.attacker, var_0.objweapon, var_0.damage, var_0.idflags);
    else if(scripts\mp\damage::uavworstid(var_0.objweapon)) {
      if(scripts\mp\damage::_id_132F0(var_0.objweapon))
        var_0.damage = 1;
      else
        var_0.damage = 0;
    } else if(scripts\mp\damage::vehicle_collision_getleveldataforvehicle(var_0.objweapon)) {
      if(!scripts\mp\damage::_id_1332D(var_0.objweapon))
        var_0.damage = 0;
    } else if(scripts\mp\damage::turn_on_laser_trap(var_0.objweapon, var_0.meansofdeath))
      var_0.damage = 0;
    else if(isDefined(var_5))
      var_0.damage = get_mod_damage(var_0.damage, self, var_0.objweapon, var_0.attacker);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_logevent(self, var_0);

  if(isDefined(var_5)) {
    var_12 = get_post_mod_damage_callback(var_5);

    if(isDefined(var_12)) {
      var_7 = self[[var_12]](var_0);

      if(!istrue(var_7))
        return;
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_1417E(var_0);
  scripts\cp_mp\vehicles\vehicle_damage::br_iseliminated(var_0);
  var_13 = scripts\cp_mp\vehicles\vehicle_damage::_id_1417D(var_0);

  if(!var_13) {
    var_14 = scripts\cp_mp\vehicles\vehicle_damage::_id_14152();

    if(isDefined(var_14) && var_14 == "_encstr_B846067B175AA56A") {
      var_15 = scripts\engine\utility::ter_op(isexplosivedamagemod(var_0.meansofdeath) || var_0.meansofdeath == "_encstr_9B0D099AD3887D91252954", 0.15, 0.25);
      var_0.damage = var_0.damage * var_15;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    scripts\cp_mp\vehicles\vehicle_damage::_id_14180(var_0, 1);
  else
    scripts\cp_mp\vehicles\vehicle_damage::_id_1417F(var_0, var_13, 1);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self, var_0);

  if(var_0.damage <= 0) {
    return;
  }
  if(istrue(level._id_14246))
    var_0.damage = 0;

  scripts\mp\utility\damage::non_player_log_attacker_data(var_0);
  var_16 = var_0.damage;
  var_17 = 1 - max(var_4 - var_16, 0) / var_4;
  var_18 = "_encstr_A2FB098A2035874AB0F358";
  var_19 = var_0.damage >= self.health;
  var_20 = istrue(var_0.use_aitype) || istrue(var_0.usedspawners);

  if(var_20 && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
        break;
      case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
      case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
        if(isDefined(var_0.meansofdeath) && var_0.meansofdeath != "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9")
          var_0.attacker thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_913518D84E4B3A5A3658D8BED9CA432DD863AC7D912CD685B32B");

        break;
      default:
        var_0.attacker thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_913518D84E4B3A5A3658D8BED9CA432DD863AC7D912CD685B32B");
        break;
    }
  }

  if(isDefined(var_0.attacker))
    var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A2FB098A2035874AB0F358", var_19, var_20, var_18, undefined, 1);

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatedamagefeedback(var_0);

  if(isDefined(level._id_120AB))
    self thread[[level._id_120AB]](var_0);

  if(var_19) {
    if(isDefined(self.deathcallback))
      self thread[[self.deathcallback]](var_0.inflictor, var_0.attacker, var_0.damage, var_0.idflags, var_0.meansofdeath, var_0.objweapon, var_0.point, var_0.dir, var_0.hitloc, var_0.timeoffset, var_0.modelindex, var_0.partname);
    else if(isDefined(level.vehicles) && isDefined(level.vehicles.deathcallback))
      self thread[[level.vehicles.deathcallback]](var_0);
    else
      self vehicle_finishdamage(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0.idflags, var_0.meansofdeath, var_0.objweapon, var_0.point, var_0.direction_vec, var_0.hitloc, var_0.timeoffset, var_0.modelname, var_0.partname);

    return;
  }

  var_21 = "_encstr_B40101";

  switch (var_0.partname) {
    case "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273":
      var_21 = "_encstr_A17D0CF82A351F5F3B54B3367DE2";
      break;
    case "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1":
      var_21 = "_encstr_A77D0CAAE8575BD7735D191AED73";
      break;
    case "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47":
      var_21 = "_encstr_A37D0C4B1908CBED3027FC02391A";
      break;
    case "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010":
      var_21 = "_encstr_937D0CC48DEDDD5507A85A93CA99";
      break;
  }

  if(self isscriptable() && self getscriptablehaspart(var_21) && self getscriptableparthasstate(var_21, "_encstr_839B07C41B7BEE571C"))
    self setscriptablepartstate(var_21, "_encstr_839B07C41B7BEE551C", 1);

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
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  scripts\mp\utility\damage::non_player_clear_attacker_data();
  scripts\mp\events::vehiclekilled(var_0);
}

filter_out_friendly_damage(var_0, var_1, var_2) {
  if((!isDefined(var_1) || !isPlayer(var_1)) && !isDefined(var_2))
    return 0;

  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isownerdamageenabled(var_0)) {
    if(isDefined(var_1) && isDefined(var_0.owner) && var_1 == var_0.owner)
      return 0;
  }

  var_3 = istrue(level.vehiclefriendlydamage) || 0;

  if(level.teambased) {
    if(!var_3) {
      if(isDefined(var_2) && !isDefined(var_1))
        return scripts\cp_mp\vehicles\vehicle::_id_141BA(var_0, var_2);
      else
        return scripts\cp_mp\vehicles\vehicle::_id_141B9(var_0, var_1);
    }

    return 0;
  } else {
    if(!var_3) {
      if(isDefined(var_1))
        return scripts\cp_mp\vehicles\vehicle::_id_141B9(var_0, var_1);

      return 0;
    }

    return 0;
  }
}

should_filter_out_friendly_damage(var_0) {
  if(isDefined(var_0.objweapon)) {
    var_1 = undefined;

    if(isstring(var_0.objweapon))
      var_1 = var_0.objweapon;
    else
      var_1 = var_0.objweapon.basename;

    if(var_1 == "_encstr_A29408E6D5D6CAAF5B1C")
      return 0;
  }

  return 1;
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
  return ceil(var_0 * var_4);
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
        var_16 = scripts\mp\utility\weapon::attachmentmap_tobase(var_16);
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

    if(var_1 _meth_87B6())
      var_4 = var_4 + 1;
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

longgulagstream(var_0) {
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
    var_5 thread _id_13342();
  }
}

_id_13342() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.arenapickupattachments = 1;
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_A1DE1825BA2F838B09D09B69B01322F2857377D70B634648E88F");
  wait 5;
  var_0.arenapickupattachments = undefined;
}