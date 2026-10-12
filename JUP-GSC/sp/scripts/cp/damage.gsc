/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\damage.gsc
***********************************************/



#using scripts\common\damage_effects;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\armor;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_gamescore;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment;
#using scripts\cp\equipment\nvg;
#using scripts\cp\events;
#using scripts\cp\globallogic;
#using scripts\cp\killcam;
#using scripts\cp\laststand;
#using scripts\cp\perks;
#using scripts\cp\perks\cp_prestige;
#using scripts\cp\points;
#using scripts\cp\powers\coop_molotov;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace damage;

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  sweapon = getcompleteweaponname(objweapon);
  victim = self;
  victim.lastweaponused = victim getcurrentweapon();
  var_b219c83cbe91cb08 = isDefined(eattacker);
  attacker_is_player = var_b219c83cbe91cb08 && isPlayer(eattacker);
  unmodifieddamage = idamage;

  if(!attacker_is_player) {
    if(isDefined(eattacker)) {
      if(isDefined(eattacker.code_classname) && eattacker.code_classname == "misc_turret") {
        einflictor = eattacker;
      }

      if(isDefined(eattacker.owner) && (isPlayer(eattacker.owner) || isagent(eattacker.owner))) {
        eattacker = eattacker.owner;
        attacker_is_player = 1;
        var_b219c83cbe91cb08 = 1;
      }
    }

    if(!attacker_is_player) {
      if(isDefined(einflictor) && isDefined(einflictor.owner) && (isPlayer(einflictor.owner) || isagent(einflictor.owner))) {
        eattacker = einflictor.owner;
        attacker_is_player = 1;
        var_b219c83cbe91cb08 = 1;
      }
    }
  }

  if(!shouldtakedamage(idamage, eattacker, sweapon, idflags, attacker_is_player, smeansofdeath)) {
    childthread utility::takecoverwarning();
    return;
  }

  if(utility::damageflag(1)) {
    iprintln("<dev string:x1c>" + self.name + "<dev string:x43>");
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor)) {
    if(isDefined(victim player_utility::getvehicle()) && victim player_utility::getvehicle() == einflictor) {
      return;
    }

    if(istrue(einflictor.disable_player_collision_damage)) {
      return;
    }
  }

  if(vehicle::vehicle_playershouldignorecollisiondamage(einflictor, victim, smeansofdeath, objweapon)) {
    return;
  }

  if(vehicle::vehicle_isrubbingagainstvehicle(einflictor, victim, smeansofdeath)) {
    return;
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[sweapon])) {
      level thread[[level.overcook_func[sweapon]]](victim, sweapon);
    }
  } else {
    idamage = function_ccd2e56e1f9a5571(idamage, objweapon);
  }

  idflags |= 4;
  isexplosive = isDefined(smeansofdeath) && (smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH");
  var_e287831520aa308b = isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET";
  isfriendlyfire = isfriendlyfire(self, eattacker, einflictor);
  var_9bdb151df3ed008 = self.perk_data["friendly_explosive_damage_reduction"] != 1;
  var_734f616279b551ee = var_b219c83cbe91cb08 && eattacker == self;
  var_47675538cec2dba8 = (var_734f616279b551ee || !var_b219c83cbe91cb08) && smeansofdeath == "MOD_SUICIDE";

  if(var_b219c83cbe91cb08) {
    if(eattacker == self) {
      if(isexplosive) {
        vehicles = utility::getvehiclearray();
        ents = eattacker getistouchingentities(vehicles);

        if(isDefined(ents) && ents.size > 0) {
          idamage *= self.perk_data["friendly_explosive_damage_reduction"];
        }
      }
    } else if(isfriendlyfire) {
      idamage = 0;

      if(isPlayer(victim) && isPlayer(eattacker) && function_2d0fd85607e87a4(objweapon)) {
        level thread cp_player_battlechatter::trysaylocalsound(victim, #"bc_combat_inform_check_fire_ally");
      }
    }

    if(smeansofdeath == "MOD_EXPLOSIVE") {
      if(sweapon == "at_mine_ap_mp") {
        idamage = self.maxhealth * 0.9;
      }

      idamage *= perks::get_perk("enemy_explosive_damage_reduction");

      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(victim)) {
          victim iprintln("<dev string:x6d>" + level.explosivedamagemod + 1);
        }

        idamage += idamage * level.explosivedamagemod;
      }
    } else if(smeansofdeath == "MOD_GRENADE_SPLASH") {
      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(victim)) {
          victim iprintln("<dev string:x6d>" + level.explosivedamagemod + 1);
        }

        idamage += idamage * level.explosivedamagemod;
      }
    }

    idamage = handleexplosivedamage(idamage, smeansofdeath, objweapon);
  }

  if(smeansofdeath == "MOD_FALLING") {
    if(utility::_hasperk("specialty_falldamage")) {
      idamage = 0;
    }
  }

  var_cb96f01f01795373 = 0;

  if(var_734f616279b551ee && !var_47675538cec2dba8) {
    idamage = int(idamage * victim damage_utility::getdamagemodifiertotal(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc));
  }

  if(weapon::isflashgrenadedamage(objweapon, smeansofdeath)) {
    result = weapon::applyflashfromdamage(victim, eattacker, vpoint, 0);

    if(!result) {
      return;
    }
  }

  cur_weap = self getcurrentprimaryweapon();

  if(cur_weap.type == "melee") {
    idamage = int(idamage * self.perk_data["carrying_melee_damage_scalar"]);
  }

  if(cur_weap.basename == "iw9_me_riotshield_mp") {
    if(!shouldskipdeathshield(einflictor, eattacker, smeansofdeath)) {
      if(isDefined(shitloc) && shitloc == "shield") {
        if(isDefined(self.riot_shield_damage)) {
          self.riot_shield_damage -= idamage;
        }
      }
    }
  }

  if(self issprinting()) {
    idamage = int(idamage * self.perk_data["sprint_damage_scalar"]);
  }

  if(self.isreviving == 1) {
    idamage = int(idamage * self.perk_data["revive_damage_scalar"]);
  }

  if(isDefined(self.super_invulnerable)) {
    if(attacker_is_player) {
      self shellshock("invul_hit", 0.25);
    }

    idamage = 0;
  }

  if(isDefined(self.vehicle_riding_on)) {
    self.vehicle_riding_on dodamage(idamage, self.vehicle_riding_on.origin);
    idamage = int(clamp(idamage, 0, self.health - 1));
  }

  idamage = modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset);
  idamage = modifyfalldamage(victim, idamage, idflags, smeansofdeath);

  if(idamage <= 0) {
    return;
  }

  if(isPlayer(self) && isDefined(self.jugg_health)) {
    var_82701521e08e1abf = idamage;

    if(isDefined(self.var_ab0e6a7a6909fc4d)) {
      var_82701521e08e1abf *= self.var_ab0e6a7a6909fc4d;
    }

    self.jugg_health -= var_82701521e08e1abf;

    if(self.jugg_health <= 0) {
      if(!istrue(self.var_1983af7858aa2aba)) {
        if(smeansofdeath != "MOD_FALLING") {
          idamage = 0;
        }
      }

      if(!istrue(self.var_892e1b08fb682295)) {
        self notify("juggernaut_end_damage");
      }
    }

    self.var_1983af7858aa2aba = undefined;
    self.var_ab0e6a7a6909fc4d = undefined;
  }

  if(objweapon.basename == "claymore_radial_mp") {
    self.shouldskipdeathsshield = 1;

    if(!isDefined(einflictor) && var_b219c83cbe91cb08) {
      idamage = cp_claymore::claymore_modifieddamage(victim, objweapon, eattacker, smeansofdeath, idamage);
    }
  }

  if(isDefined(eattacker) && istrue(eattacker.var_cefcafdecc575902)) {
    self.shouldskipdeathsshield = 1;
  }

  if(var_b219c83cbe91cb08 && idamage > 0) {
    if(!utility::damageflag(1)) {
      if(getdvarint(@ "hash_cf0ca9b75c60dbef", 20) != 20) {
        var_d9acbbe2cb0690 = getdvarint(@ "hash_cf0ca9b75c60dbef") * level.framedurationseconds * 1000;
      } else {
        var_d9acbbe2cb0690 = level.framedurationseconds * 1000 * 20;
      }

      self.damageshieldexpiretime = gettime() + var_d9acbbe2cb0690;
    }

    if(isai(eattacker) || isPlayer(eattacker) && eattacker != self) {
      agent_damage::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);

      if(!isDefined(eattacker.damagedplayers)) {
        eattacker.damagedplayers = [];
      }

      timestamp = gettime();
      eattacker.damagedplayers[victim.guid] = timestamp;
    }
  }

  if(isPlayer(eattacker) && isDefined(eattacker.pers["participation"])) {
    eattacker.pers["participation"]++;
  } else if(isPlayer(eattacker)) {
    eattacker.pers["participation"] = 1;
  }

  if(isPlayer(self) && isDefined(self.pers["participation"])) {
    self.pers["participation"]++;
  } else if(isPlayer(self)) {
    self.pers["participation"] = 1;
  }

  points::sethasdonecombat(self, 1);

  if(isDefined(eattacker) && isai(eattacker)) {
    if(istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting())) {
      idamage = 1;
    }
  }

  var_4156f93321fabc2c = 0;

  if(!isfriendlyfire) {
    if(armor::hasarmor() && armor::armor_resistance_to_type(smeansofdeath, objweapon, einflictor, eattacker)) {
      if(!function_d366c45977d13d86() && isDefined(shitloc) && shitloc != "shield") {
        if(isDefined(self.jugg_health)) {
          self notify("jugg_damage");
          lightarmordamage = 0;
          idamage = 0;
          [idamage, lightarmordamage] = armor::function_90ce8eb3ddaa4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_be4285b26ed99ab1, unmodifieddamage);
        } else {
          [idamage, lightarmordamage] = armor::function_90ce8eb3ddaa4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_be4285b26ed99ab1, unmodifieddamage);
        }

        var_4156f93321fabc2c = 1;
      }
    }

    if(isDefined(level.updateondamagerelicsfunc)) {
      level thread[[level.updateondamagerelicsfunc]](eattacker, sweapon, self);
    }

    if(idamage >= self.health && !shouldskipdeathshield(einflictor, eattacker, smeansofdeath)) {
      if(shouldactivatedeathshield(idamage)) {
        idamage = self.health - 1;
        childthread deathshieldinvulnerability(idamage, eattacker, vdir, vpoint, undefined, undefined, einflictor);
      }

      player_vehicle = player_utility::getvehicle();

      if(isDefined(player_vehicle)) {
        self.bhitbyvehicle = 1;
      } else if(weapon_is_a_vehicle_weapon(objweapon)) {
        self.bhitbyvehicle = 1;
      }
    }

    if(smeansofdeath == "MOD_CRUSH" && idamage >= self.health) {
      if(soundexists("vehicle_body_hit")) {
        playsoundatpos(self.origin, "vehicle_body_hit");
      }

      if(isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "script_vehicle") {
        self.shouldskiplaststand = undefined;
      } else {
        self.shouldskiplaststand = 1;
      }
    }

    idamage = int(idamage);

    if(attacker_is_player && !isPlayer(self) && !var_734f616279b551ee) {
      eattacker thread damagefeedback::updatedamagefeedback("standard");
    }

    if(istrue(self.shouldskipdeathsshield) && var_4156f93321fabc2c == 0 || smeansofdeath == "MOD_SUICIDE") {
      self.shouldskipdeathsshield = undefined;

      if(armor::hasarmor() && !(smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
        armor::function_2be3084f26829eac(0);
        armor::setarmorhealth(0);
      }
    }

    if(istrue(self.var_dadba5bb000d27dc)) {
      self.var_dadba5bb000d27dc = undefined;
    }

    finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, var_cb96f01f01795373, modelindex, partname, var_4156f93321fabc2c);
    level notify("playerdamaged", self);
    level notify("post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, undefined, vpoint, vdir, shitloc, undefined, modelindex, partname);
    childthread utility::takecoverwarning();
  }

  lightarmordamage = 0;
  heavyarmordamage = 0;
  iskillstreakweapon = 0;
  handledamageeffects(idamage, eattacker, smeansofdeath, vpoint, lightarmordamage, shitloc);
  cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", idamage);

  if(idamage != 0) {
    thread cp_hud_util::player_damage_blood();
  }

  if(var_b219c83cbe91cb08) {
    if(isagent(eattacker)) {
      if(!isDefined(eattacker.damage_done)) {
        eattacker.damage_done = 0;
      } else {
        eattacker.damage_done += idamage;
      }

      self.recent_attacker = eattacker;

      if(isDefined(level.current_challenge)) {
        if(isDefined(level.custom_playerdamage_challenge_func)) {
          self[[level.custom_playerdamage_challenge_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc);
        }
      }
    }
  }

  if(utility::isbulletdamage(smeansofdeath)) {
    victim thread cp_player_battlechatter::adddamagetaken(eattacker, objweapon, idamage);

    if(isDefined(victim) && victim player_utility::_isalive() && victim.health < 30) {
      victim thread cp_player_battlechatter::hurtbadlywait();
    }
  }

  if(isDefined(eattacker) && isagent(eattacker) && eattacker player_utility::_isalive() && eattacker != victim) {
    victim thread cp_player_battlechatter::addrecentattacker(eattacker);

    if(utility::isbulletdamage(smeansofdeath)) {
      addbattlechatternotify(eattacker, undefined, "shot_at_target", "target_wounded");
    }
  }

  if(isDefined(victim) && victim.health <= 1) {
    victim cp_player_battlechatter::onplayerkilled(einflictor, eattacker, idamage, smeansofdeath, objweapon);
  }
}

function handleexplosivedamage(damage, type, objweapon) {
  if(!isexplosivedamage(type)) {
    return damage;
  }

  if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "jup_flash_grenade_cp") {
    return 0;
  }

  if(isDefined(self.gs.damagemultiplierexplosive)) {
    return (damage * self.gs.damagemultiplierexplosive);
  }

  return damage;
}

function isexplosivedamage(type) {
  explosivetypes = ["MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  return utility::array_contains(explosivetypes, type);
}

function function_2d0fd85607e87a4(weapon) {
  switch (weapon.basename) {
    case #"hash_b742b20d3ace6197":
      return false;
  }

  return true;
}

function modifyfalldamage(victim, idamage, idflags, smeansofdeath) {
  modifieddamage = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    if(istrue(self.isjuggernaut) && !istrue(self.var_ca56839b2e00edce)) {
      modifieddamage = victim cp_juggernaut::jugg_modifyfalldamage();
    } else if(idflags & 32768 && modifieddamage >= victim.health) {
      modifieddamage = victim.health - 1;
    } else if(modifieddamage < 100 && !game_utility::function_b2c4b42f9236924()) {
      thread damage_effects::falldamageeffects(modifieddamage);

      if(istrue(self.var_808d06ddfc93a4e4)) {
        modifieddamage = 0;
      } else if(modifieddamage >= victim.health) {
        modifieddamage = victim.health - 1;
      }
    }
  }

  return modifieddamage;
}

function handledamageeffects(idamage, eattacker, smeansofdeath, vpoint, lightarmordamage, shitloc) {
  damage_effects::damageeffects(idamage, eattacker, smeansofdeath, vpoint, lightarmordamage, undefined, shitloc);
}

function isusingremotekillstreak() {
  return utility::isusingremote();
}

function function_10e564b87c807ff(smeansofdeath) {
  switch (smeansofdeath) {
    case #"hash_b15027ffbdc0ecb":
    case #"hash_61e42661ac27b9f2":
    case #"hash_8fdafd3a15f78cf8":
    case #"hash_f20a45acf43bdb30":
      return true;
  }

  return false;
}

function shouldskipdeathshield(einflictor, eattacker, smeansofdeath) {
  if(isDefined(eattacker) && eattacker == self) {
    return true;
  }

  if(istrue(self.shouldskipdeathsshield)) {
    return true;
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    return true;
  }

  if(getdvarint(@ "hash_874038f16b130c2", 0) != 0) {
    if(isDefined(einflictor)) {
      if(isDefined(einflictor.weapon_name)) {
        switch (einflictor.weapon_name) {
          case #"hash_1e6ad4ef0904a0f1":
          case #"hash_1ee2bbd1bc80ea9a":
          case #"hash_4f9064f9a7a4b7d1":
          case #"hash_fe08358bc8f9a34a":
            return true;
        }
      }
    }
  }

  if(isDefined(einflictor) && is_inflictor_a_carepackage(einflictor)) {
    if(smeansofdeath == "MOD_CRUSH") {
      return true;
    }
  }

  if(isDefined(einflictor) && isDefined(einflictor.var_47a068b6e4f69d26)) {
    if(smeansofdeath == "MOD_CRUSH" && einflictor.var_47a068b6e4f69d26) {
      return true;
    }
  }

  return function_10e564b87c807ff(smeansofdeath);
}

function function_ccd2e56e1f9a5571(idamage, objweapon) {
  if(!isDefined(objweapon)) {
    return idamage;
  }

  if(!isDefined(objweapon.classname)) {
    return idamage;
  }

  switch (objweapon.classname) {
    case #"hash_fa24dff6bd60a12d":
      return clamp(idamage, 35, 105);
    case #"hash_8cdaf2e4ecfe5b51":
      return clamp(idamage, 30, 90);
    case #"hash_900cb96c552c5e8e":
      return clamp(idamage, 20, 50);
    default:
      return idamage;
  }

  return idamage;
}

function is_inflictor_a_carepackage(einflictor) {
  if(!isDefined(einflictor)) {
    return false;
  }

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    if(level.cratedata.crates.size > 0) {
      if(utility::array_contains(level.cratedata.crates, einflictor)) {
        return true;
      }
    }
  }

  return false;
}

function weapon_is_a_vehicle_weapon(objweapon) {
  switch (objweapon.basename) {
    case #"hash_79ee9dd492804fa":
    case #"hash_996455d7b14b362":
    case #"hash_12a2863ecf2eeecd":
    case #"hash_1ba6982534c8d1d6":
    case #"hash_1cb3f2dbe85b8540":
    case #"hash_254b6e155434f84d":
    case #"hash_259ae6e25d936c3e":
    case #"hash_25fc06d658620968":
    case #"hash_3226ebed78234b14":
    case #"hash_33aef56fb95396fd":
    case #"hash_359ac460bda5f9b8":
    case #"hash_3f2944fd91792508":
    case #"hash_4e213f6d3f76b400":
    case #"hash_4fd5d83c1a7f06a7":
    case #"hash_51f4f5345b01f136":
    case #"hash_62a9688b69906271":
    case #"hash_6ac8f418ee829465":
    case #"hash_708fb6e22f87a3a4":
    case #"hash_73b4956c8f4b5217":
    case #"hash_80ae90d284543935":
    case #"hash_82a5b9368f3f35ae":
    case #"hash_892911bfe6164871":
    case #"hash_9386cafe3d8d6d59":
    case #"hash_a0bfc30978e56904":
    case #"hash_a9e5050965551dca":
    case #"hash_acaf314732f4c8e4":
    case #"hash_aef479d2af969a2d":
    case #"hash_af540b603005b109":
    case #"hash_b1d4d0d68c2b0c0f":
    case #"hash_bac656916e53b91c":
    case #"hash_badacfdae124cc01":
    case #"hash_cd6b1f03c24c25ff":
    case #"hash_cf8515f17748a7d2":
    case #"hash_d1ffad9819388638":
    case #"hash_d30fa952a74e1642":
    case #"hash_d4532f8e0fa86548":
    case #"hash_d6d8360ddf1f4d6b":
    case #"hash_d7f368cf53337cfd":
    case #"hash_e9ee40174ddfa406":
    case #"hash_ec580a77ee20c7bd":
    case #"hash_edf51f8e5118b630":
    case #"hash_f003a3dc14dbdf3f":
    case #"hash_f816d2efb1dcbed0":
    case #"hash_fbca161190fca27d":
    case #"hash_fc4c0a8ee31549bb":
    case #"hash_fd79e0693da4a728":
      return 1;
    default:
      return 0;
  }
}

function isenemyinfrontofme(enemy, var_3b37ca6ec4d56e75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(var_3b37ca6ec4d56e75)) {
    return (dot > 0);
  }

  return dot > var_3b37ca6ec4d56e75;
}

function isoneshotdamage(damage, smeansofdeath) {
  if(smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN" || smeansofdeath == "MOD_SUICIDE") {
    return false;
  }

  if(damage >= self.health) {
    return true;
  }

  return false;
}

function delayed_stun_damage(attacker) {
  self endon("death");
  attacker endon("death");
  wait 0.05;
  self dodamage(2, self.origin, attacker, undefined, "MOD_MELEE");
}

function stopusingremote() {
  self notify("stop_using_remote");
}

function useinvulnerability(idamage) {
  self.health = idamage + 1;
  self.haveinvulnerabilityavailable = 0;
}

function shouldtakedamage(damage, attacker, weapon, idflags, attacker_is_player, smeansofdeath) {
  if(isDefined(idflags) && (idflags == 256 || idflags == 258)) {
    return false;
  }

  if(istrue(self.var_6863acea0bd6bf64)) {
    return false;
  }

  if(utility::damageflag(1)) {
    if(!utility::function_240f7f4e57340e8f()) {
      return false;
    }

    if(!function_10e564b87c807ff(smeansofdeath)) {
      if(smeansofdeath != "MOD_CRUSH" && damage < self.maxhealth) {
        return false;
      }
    }
  }

  if(istrue(self.enteredcamera)) {
    childthread snakecam_cleanupvarafterframe();
    return false;
  }

  if(isDefined(level.custom_shouldtakedamage) && isfunction(level.custom_shouldtakedamage)) {
    if(![[level.custom_shouldtakedamage]](self)) {
      return false;
    }
  }

  if(isusingremotekillstreak() && utility::is_specops_gametype()) {
    return false;
  }

  if(isDefined(self.ability_invulnerable)) {
    return false;
  }

  if(isDefined(weapon) && weapon == "iw8_la_rpapa7_mp_friendly") {
    return false;
  }

  if(isDefined(weapon) && weapon == "overwatch_missile_cp") {
    return false;
  }

  if(isDefined(weapon) && weapon == "tur_gun_decho_cp") {
    return false;
  }

  if(istrue(self.inchopper) || istrue(self.isdrivingvehicle)) {
    return false;
  }

  return true;
}

function function_d366c45977d13d86() {
  if(isDefined(level.var_ad82a0aaa9cb47e0) && isfunction(level.var_ad82a0aaa9cb47e0)) {
    return [[level.var_ad82a0aaa9cb47e0]]();
  }

  return 0;
}

function check_for_explosive_shotgun_damage(alien, idamage, eattacker, sweapon, smeansofdeath) {
  max_dist = 500;

  if(!isDefined(alien) || !alien player_utility::_isalive()) {
    return idamage;
  }

  if(!isDefined(eattacker) || !isPlayer(eattacker) || smeansofdeath != "MOD_EXPLOSIVE_BULLET") {
    return idamage;
  }

  if(sweapon.classname == "weapon_shotgun") {
    dist = distance(eattacker.origin, alien.origin);
    scale = max(1, dist / max_dist);
    max_dmg = idamage * 8;
    scaled_damage = max_dmg * scale;

    if(dist > max_dist) {
      return idamage;
    }

    return int(scaled_damage);
  }

  return idamage;
}

function kill_trigger_event_was_processed() {
  return istrue(self.kill_trigger_event_processed);
}

function set_kill_trigger_event_processed(player, value) {
  self.kill_trigger_event_processed = value;
}

function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule) {
  if(!isDefined(owner)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  attackerteam = attacker.team;
  friendlyfirerule = level.friendlyfire;

  if(isDefined(forcedfriendlyfirerule)) {
    friendlyfirerule = forcedfriendlyfirerule;
  }

  if(friendlyfirerule != 0) {
    return true;
  }

  if(attacker == owner || isDefined(attacker.owner) && attacker.owner == owner) {
    return true;
  }

  if(!isDefined(attackerteam)) {
    return true;
  }

  if(attackerteam != owner.team) {
    return true;
  }

  return false;
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflag = data.idflag;

  if(isDefined(idflag) && idflag && true) {
    modifieddamage = 0.6 * damage;
  } else {
    modifieddamage = damage;
  }

  modifieddamage = handleempdamage(objweapon, type, modifieddamage);
  modifieddamage = handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = handlegrenadedamage(objweapon, type, modifieddamage);
  modifieddamage = handleapdamage(objweapon, type, modifieddamage);
  return modifieddamage;
}

function handlemissiledamage(objweapon, meansofdeath, damage) {
  actualdamage = damage;

  switch (objweapon.basename) {
    case #"hash_1ed1da8a2c218aa7":
    case #"hash_1ee2bbd1bc80ea9a":
    case #"hash_3e782fd775b72022":
    case #"hash_4f9064f9a7a4b7d1":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_6b9700922cc910a9":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_e704ecf8710c6f57":
    case #"hash_f55c20924061bd15":
    case #"hash_fe08358bc8f9a34a":
      self.largeprojectiledamage = 1;
      actualdamage = self.maxhealth + 1;
      break;
    case #"hash_8d402b4aee106399":
      self.largeprojectiledamage = 0;
      actualdamage *= 2;
      break;
  }

  return actualdamage;
}

function handlegrenadedamage(objweapon, damagetype, modifieddamage) {
  if(isexplosivedamagemod(damagetype)) {
    switch (objweapon.basename) {
      case #"hash_56ee829cc162271a":
        modifieddamage *= 3;
        break;
      case #"hash_4b87af60037f526f":
      case #"hash_5e4ccaa178cac19c":
      case #"hash_d9cbc629e947d1b7":
        modifieddamage *= 4;
        break;
      default:
        if(objweapon.isalternate) {
          modifieddamage *= 3;
        }

        break;
    }
  }

  return modifieddamage;
}

function handleempdamage(objweapon, meansofdeath, damage) {
  return damage;
}

function handleapdamage(objweapon, meansofdeath, damage, attacker, victim) {
  modifier = 1;
  armorpiercingmod = level.armorpiercingmod - 1;

  if(utility::isfmjdamage(objweapon, meansofdeath, attacker)) {
    if(!isDefined(victim) || !isPlayer(victim)) {
      modifier += armorpiercingmod;
    }
  }

  if(isDefined(level.armorpiercingmodks)) {
    armorpiercingmodks = level.armorpiercingmodks - 1;

    if(isDefined(attacker) && attacker utility::_hasperk("specialty_armorpiercingks") && weapon::isprimaryweapon(objweapon) && utility::isbulletdamage(meansofdeath)) {
      modifier += armorpiercingmodks;
    }
  }

  return damage * modifier;
}

function handleshotgundamage(objweapon, meansofdeath, damage) {
  if(!isDefined(objweapon)) {
    return damage;
  }

  if(objweapon.basename == "none") {
    return damage;
  }

  if(weaponclass(objweapon) != "spread") {
    return damage;
  }

  return int(min(150, damage));
}

function armormitigation(vpoint, vdir, shitloc) {
  return true;
}

function stun_zap(current_origin, enemy, idamage, smeansofdeath, var_fa0d4cca2b2ec6bb, shockmelee, strnotify) {
  if(isDefined(self.stun_struct)) {
    return 0;
  }

  time = gettime();

  if(isDefined(self.var_55d7b72228d431a) && !isDefined(shockmelee)) {
    if(time < self.var_55d7b72228d431a) {
      return;
    }
  }

  self.var_55d7b72228d431a = time + 500;
  shocked = 0;
  bolt_count = 0;
  var_41cc5fab7e69635e = 4;

  if(!isDefined(var_fa0d4cca2b2ec6bb)) {
    var_fa0d4cca2b2ec6bb = 256;
  }

  enemies = cp_agent_utils::getaliveagentsofteam("axis");
  enemy_array = utility::get_array_of_closest(enemy.origin, enemies, undefined, var_41cc5fab7e69635e, var_fa0d4cca2b2ec6bb, 1);

  if(utility::array_contains(enemy_array, enemy)) {
    enemy_array = utility::array_remove(enemy_array, enemy);
  }

  if(enemy_array.size >= 1) {
    if(!isDefined(self.stun_struct)) {
      self.stun_struct = spawnStruct();
    }

    if(istrue(shockmelee)) {
      idamage = int(idamage);
    } else {
      idamage = int(idamage * 0.5);
    }

    origins = ["j_crotch", "j_hip_le", "j_hip_ri"];
    current_origin = enemy gettagorigin(utility::random(origins));

    foreach(guy in enemy_array) {
      if(isDefined(guy) && guy != enemy && isalive(guy) && !istrue(guy.stunned)) {
        shocked = 1;

        if(istrue(shockmelee)) {
          guy.shockmelee = 1;
        }

        guy function_25ecc1ec5bb26160(self, idamage, smeansofdeath, current_origin);
        bolt_count++;

        if(bolt_count >= var_41cc5fab7e69635e) {
          break;
        }
      }
    }

    wait 0.05;
    self.stun_struct = undefined;
  }

  if(istrue(shockmelee)) {
    utility::notify_used_consumable("shock_melee_upgrade");
    enemy.shockmelee = 1;
  }

  if(isDefined(strnotify)) {
    self notify(strnotify);
  }

  return shocked;
}

function function_25ecc1ec5bb26160(player, idamage, smeansofdeath, bolt_origin) {
  self endon("death");
  waitframe();
  move_spot = undefined;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  origins = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  move_spot = self gettagorigin(utility::random(origins));

  if(isDefined(move_spot)) {
    playfxbetweenpoints(level._effect["blue_ark_beam"], bolt_origin, vectortoangles(bolt_origin - move_spot), move_spot);
    wait 0.05;

    if(isDefined(self) && smeansofdeath == "MOD_MELEE") {
      self playSound("zombie_fence_shock");
    }

    wait 0.05;
    var_c687c4d44c095fbf = int(idamage);
    fx::playfxnophase(level._effect["stun_shock"], move_spot);

    if(isDefined(self)) {
      thread function_eaa3ca00a2f2e3d7(player, smeansofdeath, var_c687c4d44c095fbf, "stun_ammo_mp");
    }
  }
}

function function_eaa3ca00a2f2e3d7(player, smeansofdeath, idamage, sweapon) {
  self endon("death");

  if(isDefined(idamage)) {
    dmg = idamage;
  } else {
    dmg = 100;
  }

  if(isDefined(sweapon)) {
    weapon = sweapon;
  } else {
    weapon = "iw7_stunbolt_zm";
  }

  thread function_718ca73e28eaedf9(1);

  if(isDefined(player)) {
    self dodamage(dmg, self.origin, player, player, smeansofdeath, weapon);
    return;
  }

  self dodamage(dmg, self.origin, undefined, undefined, smeansofdeath, weapon);
}

function function_718ca73e28eaedf9(time) {
  self endon("death");
  wait time;

  if(!utility::should_be_affected_by_trap(self)) {
    return;
  }

  self.stunned = undefined;
}

function isfriendlyfire(victim, eattacker, einflictor) {
  if(!isDefined(eattacker)) {
    return false;
  }

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(eattacker) && !isDefined(eattacker.team)) {
    return false;
  }

  var_dd1f54a7372524d6 = istrue(level.var_3904de63dbc4b0af) && isDefined(einflictor) && isDefined(einflictor.classname) && issubstr(einflictor.classname, "barrel");

  if(var_dd1f54a7372524d6) {
    if(getdvarint(@ "hash_6ddfe1c2dcc14e61", 0)) {
      victim.shouldskipdeathsshield = 1;
    }

    return false;
  }

  if(victim.team != eattacker.team) {
    return false;
  }

  if(isDefined(eattacker.owner) && isDefined(eattacker.owner.team) && eattacker.owner != eattacker) {
    if(eattacker.owner.team == victim.team) {
      return true;
    }
  }

  if(victim == eattacker) {
    return false;
  }

  return true;
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit) {
  if(!callback_killingblow(einflictor, eattacker, idamage - idamage * var_cb96f01f01795373, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isPlayer(self) && !function_d366c45977d13d86()) {
    if(idamage >= self.health) {
      if(isDefined(level.var_248dba4332a49ad3)) {
        if(self[[level.var_248dba4332a49ad3]]()) {
          idamage = self.health + 100000;

          if(shitloc == "shield") {
            shitloc = "torso_upper";
          }
        }
      }

      if(!isDefined(self.recondronesuper) && isusingremotekillstreak()) {
        if(!isDefined(vdir)) {
          vdir = (0, 0, 0);
        }

        if(!isDefined(eattacker)) {
          eattacker = self;
        }

        if(!isDefined(einflictor)) {
          einflictor = eattacker;
        }

        utility::allow_player_ignore_me(1);
        deathanimduration = self playerforcedeathanim(einflictor, smeansofdeath, sweapon, shitloc, vdir);
        self.fauxdead = 1;
        self.shouldskiplaststand = 1;
        self notify("faux_dead");

        if(shoulduseexplosiveindicator(smeansofdeath)) {
          idflags |= 256;
        }

        if(!isDefined(self.nocorpse)) {
          if(isDefined(self.body)) {
            self.body delete();
            self.body = undefined;
          }

          self.body = self cloneplayer(deathanimduration, eattacker);
        }

        if(!isDefined(self.nocorpse) && isDefined(self.body)) {
          self.body.targetname = "player_corpse";
          scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
          self setsolid(0);
          thread _startragdoll(self.body, smeansofdeath, einflictor);
        }

        if(isusingremotekillstreak()) {
          thread poke_the_player_after_faux_death();
          self waittill("stopped_using_remote");
          idamage = self.health + 100000;

          if(shitloc == "shield") {
            shitloc = "torso_upper";
          }
        }

        if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
          if(!isDefined(eattacker.var_198b774c93c48891)) {
            eattacker.var_198b774c93c48891 = gettime();
          }
        }

        if(!isDefined(self.var_9691e7d8cde294f2)) {
          self.var_9691e7d8cde294f2 = gettime();
        }

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
        self setsolid(1);
        utility::allow_player_ignore_me(0);
      } else if(isDefined(level.custom_death_func) && isfunction(level.custom_death_func)) {
        self.health = 1;
        idamage = 0;
        self[[level.custom_death_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
        idamage = self.health + 100000;

        if(shitloc == "shield") {
          shitloc = "torso_upper";
        }

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
      } else if(istrue(self.isjuggernaut)) {
        self waittill("juggernaut_end");

        if(istrue(self.var_ca56839b2e00edce)) {
          wait 0.05;
        }

        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
      } else if(isDefined(self.vehicle)) {
        utility::waittill_any_timeout_2(2, "exited_vehicle", "vehicle_exit");
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
        self disableusability();
      } else {
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
      }
    } else {
      self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_cb96f01f01795373, modelindex, partname, armorhit);
    }
  }

  damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker);
}

function _startragdoll(corpse, meansofdeath, inflictor) {
  if(!isDefined(corpse)) {
    return;
  }

  corpse endon("death");
  deathanim = corpse getcorpseanim();
  startdelay = undefined;
  animduration = 0;

  if(animisleaf(deathanim)) {
    animduration = getanimlength(deathanim);
  } else {
    animduration = 0.75;
  }

  seatid = undefined;
  deletecorpse = animhasnotetrack(deathanim, "delete_corpse");
  deletecorpsedelayed = animhasnotetrack(deathanim, "delete_corpse_delayed");
  noragdoll = animhasnotetrack(deathanim, "no_ragdoll");
  hasstartdelay = animhasnotetrack(deathanim, "start_ragdoll");
  startdelay = 0;

  if(hasstartdelay) {
    startfraction = getnotetracktimes(deathanim, "start_ragdoll")[0];
    startdelay = startfraction * animduration;
  }

  wait startdelay;

  if(!isDefined(corpse)) {
    return;
  }

  if(!corpse isragdoll()) {
    corpse startragdoll();
  }

  if(deletecorpse || deletecorpsedelayed) {
    deletedelay = animduration;

    if(deletecorpsedelayed) {
      animduration += 3;
    }

    if(isDefined(startdelay)) {
      deletedelay -= startdelay;
    }

    wait deletedelay;
    corpse delete();
    return;
  }

  corpse setplayercorpsedone();
}

function callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && idamage >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    utility::giveperk("specialty_endgame");
    return false;
  }

  return true;
}

function poke_the_player_after_faux_death() {
  self endon("disconnect");
  self endon("death");
  self endon("laststand");
  self waittill("stopped_using_remote");
  wait 0.1;

  if(!self.inlaststand) {
    self suicide();
  }
}

function damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker) {
  thread onweapondamage(einflictor, sweapon, smeansofdeath, idamage, eattacker);

  if(!isai(self)) {
    self playRumbleOnEntity("damage_heavy");
  }
}

function onweapondamage(einflictor, sweapon, meansofdeath, damage, eattacker) {
  self endon("death");
  self endon("disconnect");

  if(allowshellshockondamage(sweapon) && !isai(eattacker)) {
    weapon::shellshockondamage(meansofdeath, damage);
  }
}

function allowshellshockondamage(sweapon) {
  if(isDefined(sweapon)) {
    switch (sweapon) {
      case #"hash_8fb87b322f8d11ba":
      case #"hash_ebb0757b85088761":
        return false;
    }
  }

  return true;
}

function istacticaldamage(objweapon, smeansofdeath) {
  if(!isDefined(objweapon)) {
    return 0;
  }

  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_IMPACT") {
    return 0;
  }

  switch (objweapon.basename) {
    case #"hash_34e7a4cd11aed6bc":
    case #"hash_8d8f8ed9825eca03":
    case #"hash_d059dcc3a7f1308a":
    case #"hash_e3575fdd14663ca9":
      return 1;
    case #"hash_36d0be2b0f1c99e":
    case #"hash_5e1fa926a475190b":
    case #"hash_5e3fa526a48eaaa5":
      return 0;
    default:
      return 0;
  }
}

function damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, hitloc) {
  data = damage_utility::packdamagedata(attacker, victim, undefined, objweapon, smeansofdeath, inflictor);

  if(smeansofdeath == "MOD_GRENADE") {
    return true;
  }

  if(smeansofdeath == "MOD_PROJECTILE") {
    return true;
  }

  if(isDefined(attacker) && attacker == victim) {
    return true;
  }

  if(victim damage_utility::isstuckdamage(data)) {
    return true;
  }

  if(weaponignoresblastshield(objweapon, hitloc)) {
    return true;
  }

  return false;
}

function weaponignoresblastshield(objweapon, shitloc) {
  weaponbasename = objweapon.basename;

  if(utility::issuperweapon(weaponbasename)) {
    return 1;
  }

  switch (weaponbasename) {
    case #"hash_1eb643f396ea8577":
    case #"hash_1ed1da8a2c218aa7":
    case #"hash_1fa9e128f4c7b140":
    case #"hash_24936ab5bf8a0e20":
    case #"hash_2571a312cf984bcd":
    case #"hash_2f1a9d8e2f127205":
    case #"hash_34e7a4cd11aed6bc":
    case #"hash_4c7de5619284e175":
    case #"hash_85ea99fcbe4116a4":
    case #"hash_8fd6158eb96a1f15":
    case #"hash_91a48ebfd2d03a40":
    case #"hash_996849dc6e47c18f":
    case #"hash_aec9c140fca96664":
    case #"hash_b2a8e1829f433bd7":
    case #"hash_c5c19fe9ae40cd0c":
    case #"hash_d072a0adddda0068":
      return 1;
    default:
      return 0;
  }
}

function modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && idamage != 1) {
    idamage *= getdvarfloat(@ "hash_a881f1ebdab09002");
    idamage = int(idamage);
  }

  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    idamage = int(idamage * 2);
  }

  if(!isPlayer(eattacker) && !(idflags & 1) && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_SUICIDE") {
    idamage = int(idamage * self.damagemultiplier);
  }

  if(isDefined(level.modifyplayerdamage_relics) && isarray(level.modifyplayerdamage_relics)) {
    foreach(func in level.modifyplayerdamage_relics) {
      idamage = [[func]](victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc);
    }
  }

  if(isDefined(level.modifyplayerdamage)) {
    idamage = [[level.modifyplayerdamage]](einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags);
  }

  if(!isDefined(victim.donotmodifydamage)) {
    idamage = int(idamage * victim damage_utility::getdamagemodifiertotal(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc));
  }

  if(utility::is_specops_gametype()) {
    return idamage;
  }

  if(isPlayer(self)) {
    if(isDefined(eattacker) && isagent(eattacker) && !isexplosivedamagemod(smeansofdeath) && !isenemyinfrontofme(eattacker) && !istrue(smeansofdeath == "MOD_MELEE")) {
      idamage *= 0.5;
    }
  }

  return idamage;
}

function shoulddodamageinvulnerabilty(damage) {
  if(utility::ent_flag("player_zero_attacker_accuracy")) {
    return false;
  }

  if(utility::damageflag(1)) {
    return false;
  }

  return true;
}

function getinvultime() {
  return self.gs.invultime_ondamagemin;
}

function enabledamageinvulnerability() {
  utility::ent_flag_set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

function disabledamageinvulnerability() {
  utility::ent_flag_clear("player_zero_attacker_accuracy");
  cp_gameskill::update_player_attacker_accuracy();
}

function deathshieldinvulnerability(damage, attacker, direction, point, type, overkilldamage, inflictor) {
  deathshieldtime = playerhealth::getdeathsshieldduration();
  deathsdoortime = playerhealth::getdeathsdoorduration();

  if(!utility::is_specops_gametype() && !utility::function_240f7f4e57340e8f()) {
    deathshieldtime = getdvarfloat(@ "hash_bce38029084a7eb5", 1);
  }

  if(getdvarint(@ "hash_b900e23baf589695")) {
    deathsdoortime = 0;
  }

  utility::setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  self.damageshieldexpiretime = gettime() + deathshieldtime;

  if(!istrue(self.adrenalinepoweractive)) {
    wait_for_time_or_notify(deathshieldtime, "force_regeneration");
  }

  while(getdvarint(@ "hash_b900e23baf589695")) {
    waitframe();
  }

  utility::setdamageflag(1, 0);

  disabledamageinvulnerability();

  if(!istrue(self.adrenalinepoweractive)) {
    wait_for_time_or_notify(deathsdoortime, "force_regeneration");
  }

  disabledeathsdoor();
}

function wait_for_time_or_notify(timer, notify_string) {
  self endon(notify_string);
  wait timer;
}

function enabledeathsdoor() {
  utility::setdamageflag(2, 1);
  var_4aa7d06cc1a22953 = "damage_deathsdoor";
  var_11f7633750eb7dd9 = "damage_deathsdoor_nvg";

  if(isDefined(level.var_3dc8ba65070d0f42)) {
    var_4aa7d06cc1a22953 = level.var_3dc8ba65070d0f42;
  }

  if(isDefined(level.var_40ba4dc45ba0ef63)) {
    var_11f7633750eb7dd9 = level.var_40ba4dc45ba0ef63;
  }

  if(self isnightvisionon()) {
    visionsetpain(var_11f7633750eb7dd9);
  } else {
    visionsetpain(var_4aa7d06cc1a22953);
  }

  thread function_fe06ae011bc725a9(var_4aa7d06cc1a22953, var_11f7633750eb7dd9);
}

function function_fe06ae011bc725a9(var_4aa7d06cc1a22953, var_11f7633750eb7dd9) {
  self endon("death_or_disconnect");
  self endon("healed");
  self notify("watchingPainVision");
  self endon("watchingPainVision");

  while(true) {
    result = waittill_any_return_3("night_vision_on", "night_vision_off", "nvg_removed");

    if(result == "nvg_removed") {
      visionsetpain(var_4aa7d06cc1a22953);
      break;
    }

    if(result == "night_vision_on") {
      visionsetpain(var_11f7633750eb7dd9, 0);
      continue;
    }

    visionsetpain(var_4aa7d06cc1a22953, 0);
  }
}

function deathsdooroverlaypulse(overlaytime) {
  level endon("game_ended");
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("disconnect");
  self endon("death");
  pulsealpha = 1;
  thread lerpdeathsdoorpulsenorm(overlaytime);

  while(pulsealpha > 0) {
    time = gettime();
    pulsestarttime = time;
    pulseduration = math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(time < pulsestarttime + pulseduration) {
      time = gettime();
      pulsealphamin = 0.1;
      pulsealphamax = 0.4;
      pulsenormalized = (time - pulsestarttime) / pulseduration;
      pulsefraction = math::normalized_cos_wave(pulsenormalized);
      pulsealpha = math::factor_value(pulsealphamin, pulsealphamax, pulsefraction);
      pulsealpha *= self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
      waitframe();
    }
  }
}

function deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

function bloodoverlay(alpha, holdtime, fadetime) {
  if(utility::iswegameplatform()) {
    return;
  }

  self endon("stopPainOverlays");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = alpha;
  wait_for_time_or_notify(holdtime, "force_regeneration");

  if(fadetime <= 0) {
    fadetime = 1;
  }

  self.damage.bloodoverlay fadeovertime(fadetime);
  self.damage.bloodoverlay.alpha = 0;
}

function updatedeathsdoorvisionset() {
  if(!utility::damageflag(2)) {
    return 0;
  }

  var_4aa7d06cc1a22953 = "damage_deathsdoor";
  var_11f7633750eb7dd9 = "damage_deathsdoor_nvg";

  if(isDefined(level.var_3dc8ba65070d0f42)) {
    var_4aa7d06cc1a22953 = level.var_3dc8ba65070d0f42;
  }

  if(isDefined(level.var_40ba4dc45ba0ef63)) {
    var_11f7633750eb7dd9 = level.var_40ba4dc45ba0ef63;
  }

  if(self isnightvisionon()) {
    visionsetpain(var_11f7633750eb7dd9);
    return;
  }

  visionsetpain(var_4aa7d06cc1a22953);
}

function disabledeathsdoor(instant) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(instant)) {
    instant = 0;
  }

  if(!instant) {
    lerpouttime = gethealthregentime();
  } else {
    lerpouttime = 0;
  }

  lerpoutrate = getvisionlerprate(lerpouttime);
  utility::setdamageflag(2, 0);
}

function getvisionlerprate(outtime) {
  rate = 1 / max(0.01, outtime);
  return clamp(rate, 0, 30);
}

function lerpdeathsdoorpulsenorm(outtime) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("disconnect");
  timer = outtime;
  self.deathsdoorpulsenorm = 1;

  while(timer > 0) {
    self.deathsdoorpulsenorm = math::normalize_value(0, outtime, timer);
    self.deathsdoorpulsenorm = math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    timer -= 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

function shouldactivatedeathshield(damage) {
  if(utility::flag_exist("disable_death_shield") && utility::flag("disable_death_shield")) {
    return false;
  }

  if(getdvarint(@ "hash_b900e23baf589695") && !istrue(level.audio.in_deathsdoor)) {
    return true;
  }

  if(utility::damageflag(1)) {
    return false;
  }

  if(utility::damageflag(2)) {
    return false;
  }

  return true;
}

function initplayerdamagefunctions() {
  initplayerentflags();
  initplayerdamage();
  self setclientomnvar("ui_gettocover_state", 0);
  utility::registersharedfunc("player", "isUsingRemoteKillstreak", &isusingremotekillstreak);
  utility::registersharedfunc("player", "getTakeCoverWarnings", &gettakecoverwarnings);
  utility::registersharedfunc("player", "setTakeCoverWarnings", &settakecoverwarnings);
  utility::setcoverwarningcount();
}

function initplayerentflags() {
  utility::ent_flag_init("global_hint_in_use");
  utility::ent_flag_init("player_zero_attacker_accuracy");
}

function initplayerdamage() {
  self.damage = spawnStruct();
  self.damage.impactsfx = utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
}

function initdamageoverlay() {
  self.damage.overlay = newclienthudelem(self);
  self.damage.overlay.sort = 2;
  self.damage.overlay.x = 0;
  self.damage.overlay.y = 0;
  self.damage.overlay.alignx = "left";
  self.damage.overlay.aligny = "top";
  self.damage.overlay.foreground = 0;
  self.damage.overlay.horzalign = "fullscreen";
  self.damage.overlay.vertalign = "fullscreen";
  self.damage.overlay.alpha = 0;
  self.damage.overlay.enablehudlighting = 1;
  self.damage.overlay.lowresbackground = 1;
  self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
}

function initfiredamageoverlay() {
  self.damage.firedamageoverlay = newclienthudelem(self);
  self.damage.firedamageoverlay.sort = -1;
  self.damage.firedamageoverlay.x = 0;
  self.damage.firedamageoverlay.y = 0;
  self.damage.firedamageoverlay.alignx = "left";
  self.damage.firedamageoverlay.aligny = "top";
  self.damage.firedamageoverlay.foreground = 0;
  self.damage.firedamageoverlay.horzalign = "fullscreen";
  self.damage.firedamageoverlay.vertalign = "fullscreen";
  self.damage.firedamageoverlay.alpha = 0;
  self.damage.firedamageoverlay.enablehudlighting = 1;
  self.damage.firedamageoverlay.lowresbackground = 1;
  self.damage.firedamageoverlay setshader("ui_player_pain_fire_overlay", 640, 480);
}

function initfirepainoverlay() {
  self.damage.firepainoverlay = newclienthudelem(self);
  self.damage.firepainoverlay.sort = -2;
  self.damage.firepainoverlay.x = 0;
  self.damage.firepainoverlay.y = 0;
  self.damage.firepainoverlay.alignx = "left";
  self.damage.firepainoverlay.aligny = "top";
  self.damage.firepainoverlay.foreground = 0;
  self.damage.firepainoverlay.horzalign = "fullscreen";
  self.damage.firepainoverlay.vertalign = "fullscreen";
  self.damage.firepainoverlay.alpha = 0;
  self.damage.firepainoverlay.enablehudlighting = 1;
  self.damage.firepainoverlay.lowresbackground = 1;
  self.damage.firepainoverlay setshader("ui_player_pain_impact_overlay", 640, 480);
}

function initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 0;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "left";
  self.damage.deathsdooroverlaypulse.aligny = "top";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

function initbloodoverlay() {
  self.damage.bloodoverlay = newclienthudelem(self);
  self.damage.bloodoverlay.sort = 1;
  self.damage.bloodoverlay.x = 0;
  self.damage.bloodoverlay.y = 0;
  self.damage.bloodoverlay.alignx = "left";
  self.damage.bloodoverlay.aligny = "top";
  self.damage.bloodoverlay.foreground = 0;
  self.damage.bloodoverlay.horzalign = "fullscreen";
  self.damage.bloodoverlay.vertalign = "fullscreen";
  self.damage.bloodoverlay.alpha = 0;
  self.damage.bloodoverlay.enablehudlighting = 1;
  self.damage.bloodoverlay.lowresbackground = 1;
  self.damage.bloodoverlay setshader("ui_player_pain_blood_overlay", 640, 480);
}

function gettakecoverwarnings() {
  takecoverwarnings = 0;

  if(getprojectname() == "JUP") {
    takecoverwarnings = self getprogressiondata("spData", "takeCoverWarnings");
  } else if(isDefined(level.player.pers["takeCoverWarnings"])) {
    takecoverwarnings = level.player.pers["takeCoverWarnings"];
  }

  return takecoverwarnings;
}

function settakecoverwarnings(count) {
  if(getprojectname() == "JUP") {
    self setprogressiondata("spData", "takeCoverWarnings", count);
    return;
  }

  level.player.pers["takeCoverWarnings"] = count;
}

function healthratio() {
  return self.health / self.maxhealth;
}

function oldhealthregen(hurttime, healthratio) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self.selfdamaging) && self.selfdamaging) {
    wait 0.2;
  }

  if(utility::ishealthregendisabled()) {
    return;
  }

  regendata = spawnStruct();
  utility::getregendata(regendata);
  wait regendata.activatetime;
  time = gettime();

  while(true) {
    healthcap = laststand::gethealthcap();
    regendata = spawnStruct();
    utility::getregendata(regendata);
    healthratio = self.health / self.maxhealth;

    if(self.health < int(healthcap)) {
      newhealth = int(self.health + regendata.regenamount);

      if(newhealth > healthcap) {
        newhealth = healthcap;
      }

      self.health = newhealth;
    } else {
      break;
    }

    utility::waittill_any_timeout_1(regendata.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level.playerinitinvulnerability)) {
    self[[level.playerinitinvulnerability]]();
  }

  utility::resetattackerlist();
}

function core_health_regen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("faux_dead");
  level endon("game_ended");
  self.health = self.maxhealth;

  while(true) {
    result = utility::waittill_any_return_4("damage", "health_perk_upgrade", "force_regeneration", "relic_resume_health_regen");

    if(result == "force_regeneration") {
      regenerate_health();
      continue;
    }

    if(!utility::canregenhealth()) {
      continue;
    }

    thread function_36e8fea5b5be8448();
  }
}

function function_36e8fea5b5be8448() {
  playerhealth::function_19b9bb9cef6a2d3();
  regen_delay();
  regenerate_health();
}

function regen_delay() {
  self endon("force_regeneration");
  regendelay = gethealthregendelay();
  self.currentregendelay = regendelay;
  wait regendelay;

  while(utility::damageflag(2) || utility::damageflag(32)) {
    waitframe();
  }

  self.currentregendelay = undefined;
}

function regenerate_health() {
  finalhealth = self.health;
  thread utility::breathingmanager(gettime(), healthratio());

  while(self.health < self.maxhealth) {
    var_24493f7b31ecfbd = gethealthregenpersecond();
    frameregen = var_24493f7b31ecfbd * 0.05;
    finalhealth = clamp(finalhealth + frameregen, 0, self.maxhealth);
    set_normalhealth(finalhealth / self.maxhealth);
    waitframe();
  }

  self notify("healed");
}

function gethealthregenpersecond() {
  scalar = 1;

  if(istrue(self.adrenalinepoweractive)) {
    scalar *= 10;
  } else if(utility::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    if(isDefined(self.consecutive_kills) && self.consecutive_kills > 2) {
      scalar *= 2;
    }
  } else if(utility::_hasperk("specialty_fast_health_regen")) {
    scalar *= 2;
  }

  return scalar * self.gs.healthregenrate;
}

function getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

function getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

function gethealthregentime() {
  regenamount = self.maxhealth - self.health;
  var_48c07ca96fba732e = regenamount / gethealthregenpersecond();
  return var_48c07ca96fba732e;
}

function gethealthregendelay() {
  return self.gs.healthregendelay;
}

function set_normalhealth(normalamount) {
  self setnormalhealth(normalamount);
  self.lasthealth = self.health;
}

function getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, explodeoverride) {
  amount = handleshotgundamage(objweapon, meansofdeath, amount);
  amount = handleapdamage(objweapon, meansofdeath, amount, attacker);

  if(isDefined(objweapon)) {
    altmodeweapon = objweapon.isalternatemode;
  }

  var_d5e541ff0f6c2578 = 0;
  divisor = undefined;

  if(meansofdeath != "MOD_MELEE" && isDefined(objweapon)) {
    switch (objweapon.basename) {
      case #"hash_85ea99fcbe4116a4":
      case #"hash_aae52fc2913829d0":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        divisor = 1;
        break;
      case #"hash_7de9687a97e62d93":
      case #"hash_4f9064f9a7a4b7d1":
      case #"hash_c124ad09158500e9":
      case #"hash_6b9700922cc910a9":
      case #"hash_1fa9e128f4c7b140":
      case #"hash_24936ab5bf8a0e20":
      case #"hash_72843fb4c039e5b6":
      case #"hash_a54e19ae2e8d865c":
      case #"hash_fe08358bc8f9a34a":
      case #"hash_5cbb3a1a84d47f1d":
      case #"hash_2f1a9d8e2f127205":
      case #"hash_7917bb9ef2886e20":
      case #"hash_5e8f81314553dd36":
      case #"hash_3e782fd775b72022":
      case #"hash_e704ecf8710c6f57":
      case #"hash_a9e31b8ffd42a67b":
      case #"hash_c5c19fe9ae40cd0c":
      case #"hash_f55c20924061bd15":
        self.largeprojectiledamage = 1;
        divisor = divisorlrg;
        break;
      case #"hash_1ee2bbd1bc80ea9a":
      case #"hash_254b6e155434f84d":
      case #"hash_259ae6e25d936c3e":
      case #"hash_2654d1bcc59b62b6":
      case #"hash_3226ebed78234b14":
      case #"hash_359ac460bda5f9b8":
      case #"hash_3f2944fd91792508":
      case #"hash_4e213f6d3f76b400":
      case #"hash_4fd5d83c1a7f06a7":
      case #"hash_51f4f5345b01f136":
      case #"hash_80ae90d284543935":
      case #"hash_6ac8f418ee829465":
      case #"hash_25fc06d658620968":
      case #"hash_91a48ebfd2d03a40":
      case #"hash_9386cafe3d8d6d59":
      case #"hash_9f73f49d822d9acc":
      case #"hash_a622e958420b92a0":
      case #"hash_a9e5050965551dca":
      case #"hash_acaf314732f4c8e4":
      case #"hash_bac656916e53b91c":
      case #"hash_996455d7b14b362":
      case #"hash_cf8515f17748a7d2":
      case #"hash_d1ffad9819388638":
      case #"hash_d30fa952a74e1642":
      case #"hash_d7f368cf53337cfd":
      case #"hash_e9ee40174ddfa406":
      case #"hash_ec580a77ee20c7bd":
      case #"hash_f003a3dc14dbdf3f":
      case #"hash_12a2863ecf2eeecd":
      case #"hash_f816d2efb1dcbed0":
      case #"hash_fbca161190fca27d":
      case #"hash_fc4c0a8ee31549bb":
      case #"hash_badacfdae124cc01":
        self.largeprojectiledamage = 1;
        divisor = divisormed;
        break;
      case #"hash_6a2e4f9c54756dc7":
      case #"hash_4b87af60037f526f":
      case #"hash_8c12df11df01f306":
      case #"hash_5e4ccaa178cac19c":
      case #"hash_435258fc47768fa7":
      case #"hash_996849dc6e47c18f":
      case #"hash_8fd6158eb96a1f15":
      case #"hash_432644fc4753dde9":
      case #"hash_1e6ad4ef0904a0f1":
      case #"hash_a49fac234083ff01":
      case #"hash_cce14c95e4764532":
      case #"hash_56ee829cc162271a":
        self.largeprojectiledamage = 0;
        divisor = divisorlow;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    divisor = divisormelee;
  }

  if(isDefined(explodeoverride)) {
    self.largeprojectiledamage = explodeoverride;
  }

  if(isDefined(divisor) && isDefined(meansofdeath) && (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_FIRE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_MELEE")) {
    amount = ceil(maxhealth / divisor);
  }

  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(isDefined(attacker) && isDefined(self.owner) && !var_e688b198aa9a4b3f) {
    if(isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(attacker == self.owner && !istrue(self.killoneshot)) {
      amount = ceil(amount / 2);
    }
  }

  return int(amount);
}

function packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags) {
  struct = spawnStruct();
  struct.attacker = attacker;
  struct.victim = victim;
  struct.damage = damage;
  struct.objweapon = objweapon;
  struct.meansofdeath = meansofdeath;
  struct.inflictor = inflictor;
  struct.point = point;
  struct.direction_vec = direction_vec;
  struct.modelname = modelname;
  struct.partname = partname;
  struct.hitloc = "none";
  struct.timeoffset = 150;
  struct.tagname = tagname;
  struct.idflags = idflags;
  struct.damageflags = idflags;
  struct.var_e49f474e00fa0bb4 = istrue(isDefined(victim) && isPlayer(victim));
  struct.attacker.assistedsuicide = 0;
  return struct;
}

function shoulduseexplosiveindicator(smeansofdeath) {
  return smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_FIRE";
}

function snakecam_cleanupvarafterframe() {
  self notify("snakecam_cleanupVarAfterFrame");
  self endon("snakecam_cleanupVarAfterFrame");

  if(istrue(self.var_c1617124d4ee7e97)) {
    return;
  }

  self.var_c1617124d4ee7e97 = 1;
  self waittill("player_left_cam");
  waittillframeend();
  self.var_c1617124d4ee7e97 = undefined;
}

function playerkilled_internal(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  victim endon("spawned");
  victim endon("disconnect");
  level endon("game_ended");

  if(game["state"] == "postgame") {
    return;
  }

  deathdata = victim laststand::playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath);
  laststand::playerkilled_parameterfixup(deathdata);
  laststand::playerkilled_precalc(deathdata);
  playerkilled_sharedlogic_early(deathdata);
  playerkilled_handledeathtype(deathdata);
  playerkilled_sharedlogic_late(deathdata);
  deathdata.dokillcam = utility::function_240f7f4e57340e8f();

  if(killcam::function_3f8b7ecacb8eb472(deathdata)) {
    playerkilled_deathscene(deathdata);
  }

  deathdata.attackerentnum = deathdata.attacker getentitynumber();
  time = gettime() - 10000;
  deathdata.attacker.lastspawntime = utility::ter_op(time > attacker.birthtime, time, attacker.birthtime);
  level.var_51c1068f1991312e = deathdata;
  playerkilled_spawn(deathdata);
}

function playerkilled_sharedlogic_early(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  damage = deathdata.damage;
  meansofdeath = deathdata.meansofdeath;
  isfauxdeath = deathdata.isfauxdeath;
  hitloc = deathdata.hitloc;
  direction_vec = deathdata.direction_vec;
  victim notify("killed_player");
  victim showuidamageflash();
  victim setblurforplayer(0, 0);
  cp_outofbounds::clearoob(victim, 1);
  victim coop_molotov::molotov_clear_fx();
  utility::printgameaction("death", victim);
  victim utility::launchshield(damage, meansofdeath);

  if(isDefined(attacker.petwatch) && attacker != victim) {
    attacker pet_watch::addkillcharge();

    if(meansofdeath == "MOD_EXECUTION") {
      attacker pet_watch::addexecutioncharge();
    } else if(victim playerkilled_washitbyvehicle(meansofdeath, inflictor)) {
      attacker pet_watch::addvehicularmanslaughtercharge();
    }
  }

  if(meansofdeath == "MOD_EXECUTION") {
    attacker events::incpersstat("executionKills", 1);
    level thread cp_player_battlechatter::trysaylocalsound(attacker, "flavor_execution", undefined, 1);
  }

  victimheldweapon = victim getcurrentweapon();

  if(victim weapon::iskillstreakweapon(victimheldweapon)) {}

  if(istrue(level.var_2dce4d6dcb6c3fb9)) {
    victim utility::store_weapons_status(level.var_d5ab05b7947de15a, 1);
    victim equipment::store_equipment();
  }

  victim nvg::savenvgstate();

  if(!isfauxdeath) {
    if(isDefined(victim.endgame)) {
      victim player::restorebasevisionset(2);
    } else {
      victim player::restorebasevisionset(0);
      victim thermalvisionoff();
    }
  } else {
    victim.fauxdead = 1;
    victim sethidenameplate(1);
    victim notify("death");
    victim notify("death_or_disconnect");
  }

  if(meansofdeath != "MOD_HEAD_SHOT" && !deathdata.isnukekill) {
    if(isDefined(level.custom_death_sound)) {
      [[level.custom_death_sound]](victim, meansofdeath, inflictor);
    } else if(meansofdeath != "MOD_MELEE") {
      victim utility::playdeathsound();
    }
  }

  if(isDefined(level.custom_death_effect)) {
    [[level.custom_death_effect]](victim, meansofdeath, inflictor);
  }

  if(utility::gameflag("prematch_done") && !istrue(victim.hvtnorevive) && istrue(victim.inlaststand)) {
    thread laststand::ondeath(deathdata);
  }

  if(utility::gameflag("prematch_done")) {
    var_85a40249b07be68e = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(!var_85a40249b07be68e) {} else {
      respawnitems = self.juggcontext;
    }
  }

  if(!isfauxdeath) {
    victim utility::updatesessionstate("dead");
  }

  var_63c3344d9c1f9816 = istrue(victim.fauxdead) && istrue(victim.switching_teams);

  if(!var_63c3344d9c1f9816) {
    if(!isDefined(level.modemayconsiderplayerdead) || [[level.modemayconsiderplayerdead]](victim)) {}
  }

  obitmeansofdeath = meansofdeath;

  if(isDefined(deathdata.idflags) && deathdata.idflags & 8 && !(deathdata.idflags & 16384)) {
    if(isDefined(attacker.bulletkillsinaframecount) && attacker.bulletkillsinaframecount == 0) {
      obitmeansofdeath = "MOD_PENETRATION";
    }
  } else if(objweapon.basename == "semtex_xmike109_mp" && deathdata.hitloc == "head" || deathdata.hitloc == "helmet") {
    obitmeansofdeath = "MOD_HEAD_SHOT";
  }

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.iswztrain)) {
    obitmeansofdeath = "MOD_CRUSH";
  }

  victim cp_player_battlechatter::onplayerkilled(inflictor, attacker, damage, meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid);
  victimlifetime = (deathdata.deathtime - victim.spawntime) / 1000;
}

function playerkilled_washitbyvehicle(meansofdeath, inflictor) {
  if(meansofdeath != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(inflictor)) {
    return false;
  }

  if(!inflictor vehicle::isvehicle()) {
    return false;
  }

  return true;
}

function showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

function playerkilled_handledeathtype(deathdata) {
  victim = deathdata.victim;
  deathdata.deathtype = playerkilled_finddeathtype(deathdata);
  level notify("player_death", victim, deathdata.deathtype);

  if(getdvarint(@ "hash_4d0a8a446d22b1e1")) {
    iprintlnbold(deathdata.deathtype);
  }

  switch (deathdata.deathtype) {
    case #"hash_1184b43822fe56f0":
      handleworlddeath(deathdata, deathdata.attacker, deathdata.lifeid, deathdata.meansofdeath, deathdata.hitloc);
      break;
    case #"hash_c03eabf71149f406":
      handlesuicidedeath(deathdata.meansofdeath, deathdata.hitloc);
      break;
    case #"hash_ce250de499ae9603":
      handleinlaststanddeath(deathdata);
      break;
    case #"hash_a9f265ec10b615d":
      handlenormaldeath(deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, victim, deathdata.iskillstreakweapon, deathdata);
      break;
    default:
      assertmsg("Unhandled DeathType \"" + deathdata.deathtype + "\"");
      break;
  }

  laststand::function_f9249bb06eb48092(deathdata);

  laststand::function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_finddeathtype(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;

  if(isDefined(meansofdeath) && meansofdeath == "MOD_TRIGGER_HURT" && !isPlayer(attacker)) {
    return "deathType_normal";
  }

  if(!isPlayer(attacker) || isPlayer(attacker) && meansofdeath == "MOD_FALLING") {
    return "deathType_worldDeath";
  }

  if(attacker == victim) {
    return "deathType_suicide";
  }

  if(deathdata.isfriendlyfire && deathdata.objweapon.basename != "bomb_site_mp" && !deathdata.isnukekill) {
    return "deathType_friendlyFire";
  }

  if(istrue(victim.inlaststand)) {
    return "deathType_inLastStand";
  }

  return "deathType_normal";
}

function handleinlaststanddeath(deathdata) {
  var_498a2226e5aa47ee = game_utility::isbrstylegametype();

  if(isbot(deathdata.victim) && getdvarint(@ "hash_e125675f281d4f47", 0) == 1) {
    deathdata.dokillcam = 0;
    return;
  }

  if(istrue(deathdata.victim.disable_killcam)) {}

  if(!deathdata.iskillstreakweapon) {
    deathdata.attacker thread points::doscoreevent(#"hash_4b2faaeab2b30db", deathdata.objweapon, undefined, undefined, deathdata.victim);
  }

  if(isDefined(self.laststandattacker) && deathdata.attacker != self.laststandattacker) {
    thread challenges::onplayerkilled(self.laststandattacker, self.laststandattacker, 0, deathdata.damageflags, self.laststandmeansofdeath, self.laststandweaponobj, deathdata.hitloc, self.laststandattackermodifiers);
    self.laststandattacker thread rank::scoreeventpopup(#"kill_confirmed");
  }

  handlenormaldeath(deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, self, deathdata.iskillstreakweapon, deathdata, 1);
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststandattackermodifiers = undefined;
}

function handlenormaldeath(lifeid, attacker, einflictor, objweapon, smeansofdeath, victim, iskillstreakweapon, deathdata, var_c7944407e05a6f77) {
  if(smeansofdeath == "MOD_GRENADE" && einflictor == attacker) {
    agent_damage::addattacker(victim, attacker, einflictor, objweapon, deathdata.damage, (0, 0, 0), deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, smeansofdeath);
  }

  deathdata.dokillcam = 0;

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
    deathdata.dokillcam = victim[[level.bot_funcs["should_do_killcam"]]]();
  }

  if(istrue(level.disable_killcam) || istrue(victim.disable_killcam)) {
    deathdata.dokillcam = 0;
  }

  if(isDefined(einflictor) && istrue(einflictor.var_26fb072855fd4772)) {
    return;
  }

  if(isPlayer(attacker)) {
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor);
  }

  var_d2db6cb7f6d5d36d = attacker;

  if(isDefined(attacker.commanding_bot)) {
    var_d2db6cb7f6d5d36d = attacker.commanding_bot;
  }

  if(isDefined(var_d2db6cb7f6d5d36d.pers) && !istrue(var_d2db6cb7f6d5d36d.pers["ignoreWeaponMatchBonus"]) && (weapon::iscacprimaryweapon(objweapon) || weapon::iscacsecondaryweapon(objweapon))) {
    if(!isDefined(var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"])) {
      var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] = 1;
    } else {
      var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"]++;
    }

    if(!function_ccf98e6391dd38b9()) {
      if(var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] > cp_weaponrank::getgametypekillspermatchmaximum()) {
        var_d2db6cb7f6d5d36d.pers["ignoreWeaponMatchBonus"] = 1;
        var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] = undefined;
        var_d2db6cb7f6d5d36d.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(var_d2db6cb7f6d5d36d.pers["killsPerWeapon"])) {
          var_d2db6cb7f6d5d36d.pers["killsPerWeapon"] = [];
        }

        rootname = weapon::getweaponrootname(objweapon);
        weaponfound = 0;

        foreach(data in var_d2db6cb7f6d5d36d.pers["killsPerWeapon"]) {
          if(weaponkey == rootname) {
            data.killcount++;
            weaponfound = 1;
            break;
          }
        }

        if(!weaponfound) {
          data = spawnStruct();
          data.killcount = 1;
          data.basename = objweapon.basename;
          data.orderindex = var_d2db6cb7f6d5d36d.pers["killsPerWeapon"].size;
          var_d2db6cb7f6d5d36d.pers["killsPerWeapon"][rootname] = data;
        }
      }
    }
  }

  lastkillstreak = undefined;

  if(isDefined(attacker.pers)) {
    lastkillstreak = attacker.pers["cur_kill_streak"];
    attacker.pers["cur_death_streak"] = 0;
  }

  if(!iskillstreakweapon && !events::iskillstreakvehicleinflictor(einflictor) || points::isforcekillstreakprogressweapon(objweapon)) {
    attacker thread events::killeventtextpopup(#"kill", 0);
    pointoverride = undefined;

    if(game_utility::isbrstylegametype() && !flags::gameflag("prematch_done")) {
      pointoverride = 100;
    }

    if(utility::issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[utility::getsharedfunc("player", "doScoreEvent")]]("kill", objweapon, pointoverride, undefined, victim);
    }
  }

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == attacker) {
    level notify("ai_killed", self);
  }

  attacker notify("killed_enemy");

  if(istrue(attacker.inlaststand)) {
    attacker thread laststand::onlaststandkillenemy(deathdata);
  }

  if(isDefined(level.onnormaldeath) && isDefined(attacker.pers) && attacker.pers["team"] != "spectator" && !istrue(level.ignorescoring)) {
    self[[level.onnormaldeath]]();
  }

  if(!attacker utility::isusingremote()) {
    weaponlist = victim getweaponslistprimaries();
    wassniper = 0;

    foreach(weapon in weaponlist) {
      if(weaponclass(weapon.basename) == "sniper") {
        wassniper = 1;
        break;
      }
    }

    if(wassniper) {
      level thread cp_player_battlechatter::trysaylocalsound(attacker, #"bc_combat_killfirm_sniper", undefined, 0.75);
    } else {
      level thread cp_player_battlechatter::trysaylocalsound(attacker, #"bc_combat_killfirm_infantry", undefined, 0.75);
    }
  }

  vocallout = undefined;

  if(isDefined(vocallout)) {
    level thread cp_player_battlechatter::saytoself(attacker, vocallout, "plr_killfirm_generic", 0.75);
  }
}

function handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor) {
  var_e08e0d086a79892b = 0;
  ent = victim;

  if(!isDefined(attacker.lastkillalertsoundtime)) {
    attacker.lastkillalertsoundtime = gettime();
    var_e08e0d086a79892b = 1;
  } else if(gettime() > attacker.lastkillalertsoundtime + 700) {
    attacker.lastkillalertsoundtime = gettime();
    var_e08e0d086a79892b = 1;
  }

  if(function_80ade967129c9845()) {} else if(isagent(attacker)) {
    if(!utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {} else if(smeansofdeath == "MOD_HEAD_SHOT") {
      ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
      ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    } else {
      ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    }
  } else if(!utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {
    if(var_e08e0d086a79892b && !game_utility::function_b2c4b42f9236924()) {
      ent playsoundtoplayer("mp_kill_alert_quiet", attacker);
    }
  } else if(smeansofdeath == "MOD_HEAD_SHOT") {
    ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
    ent playsoundtoplayer("bullet_impact_headshot", attacker);

    if(var_e08e0d086a79892b) {
      ent playsoundtoplayer("mp_headshot_alert", attacker);
    }

    ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);

    if(var_e08e0d086a79892b) {
      ent playsoundtoplayer("mp_kill_alert", attacker);
    }
  }

  if(isPlayer(victim)) {
    if(smeansofdeath != "MOD_EXECUTION") {
      victim playlocalsound("deaths_door_death");
    }

    victim scripts\common\damage_effects::function_a2b4e6088394bade();
    victim.deathsdoor = 0;
  }
}

function function_80ade967129c9845() {
  return istrue(level.var_57ece26e490ad8c4);
}

function playerkilled_sharedlogic_late(deathdata) {
  playerkilled_handlecorpse(deathdata);
  setdeathtimerlength(deathdata);
  attacker = deathdata.attacker;

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(!isPlayer(attacker)) {
    deathdata.dokillcam = 0;
    deathdata.dofinalkillcam = 0;
  }

  thread challenges::ondeath(deathdata.inflictor, deathdata.attacker, deathdata.damage, deathdata.damageflags, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.attacker.modifiers);

  laststand::function_f9249bb06eb48092(deathdata);

  laststand::function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_killcam(deathdata) {
  if(istrue(self.liveragdoll)) {
    return;
  }

  deathtime = deathdata.victim.deathtime;
  deathdata.victim endon("spawned");
  victim = deathdata.victim;
  attacker = deathdata.attacker;
  postdeathdelay = (gettime() - deathtime) / 1000;

  if(!istrue(victim.cancelkillcam) && killcam::function_3f8b7ecacb8eb472(deathdata) && !victim utility::isusingremote()) {
    timeuntilspawn = timeuntilspawn(1);
    attackerperks = [];

    if(!deathdata.laststandkill) {
      level waittill("deathScene_over");
    }

    victim killcam::killcam(deathdata.inflictor, utility::ter_op(isDefined(deathdata.inflictoragentinfo), deathdata.inflictoragentinfo, deathdata.victim), 0, deathdata.killcamentityindex, deathdata.killcamentitystarttime, undefined, deathdata.killcamentstickstovictim, deathdata.objweapon, postdeathdelay, deathdata.psoffsettime, timeuntilspawn, 12, attacker, victim, deathdata.meansofdeath, attackerperks, 1);

    if(isDefined(level.onpostkillcamcallback)) {
      [[level.onpostkillcamcallback]](deathdata);
    }
  }
}

function playerkilled_killcamsetup(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;
  objweapon = deathdata.objweapon;
  executionref = deathdata.executionref;

  if(isDefined(inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    deathdata.dokillcam = 1;
  }

  if(isDefined(attacker) && istrue(attacker.assistedsuicide) || level.teambased && isDefined(attacker) && utility::is_equal(attacker.team, victim.team) || istrue(level.var_c2111af4e4ece485)) {
    deathdata.dokillcam = 0;
    deathdata.dofinalkillcam = 0;
  }

  if(getdvarint(@ "scr_forcekillcam") != 0) {
    deathdata.dokillcam = 1;
  }

  if(!isDefined(deathdata.killcamentity)) {
    deathdata.killcamentity = victim killcam::getkillcamentity(attacker, inflictor, objweapon, meansofdeath);
  }

  if(isDefined(deathdata.killcamentity)) {
    deathdata.killcamentityindex = deathdata.killcamentity getentitynumber();
    deathdata.killcamentitystarttime = deathdata.killcamentity.birthtime;

    if(!isDefined(deathdata.killcamentitystarttime)) {
      deathdata.killcamentitystarttime = 0;
    }
  }

  if(killcam::function_3f8b7ecacb8eb472(deathdata)) {
    if(isDefined(inflictor) && isagent(inflictor)) {
      deathdata.inflictoragentinfo = spawnStruct();
      deathdata.inflictoragentinfo.agent_type = inflictor.agent_type;
      deathdata.inflictoragentinfo.lastspawntime = inflictor.lastspawntime;
    }
  }

  deathdata.killcamentstickstovictim = meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_HEAD_SHOT" && isDefined(inflictor) || meansofdeath == "MOD_GRENADE" || isDefined(victim) && isDefined(victim.stuckbygrenade) && isDefined(inflictor) && victim.stuckbygrenade == inflictor || objweapon.basename == "throwingknifec4_mp";

  if(!deathdata.iskillstreakweapon) {
    killcam::setkillcamnormalweaponomnvars(objweapon, meansofdeath, inflictor, executionref, attacker);
  }

  laststand::function_f9249bb06eb48092(deathdata);

  laststand::function_af3ebb9d1ecd18e7(deathdata);
}

function function_e4a54b8991b813bf(deathdata) {
  victim = deathdata.victim;
  victim utility::updatesessionstate("dead");
  level notify("player_killcam_over");
}

function playerkilled_handlecorpse(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;
  objweapon = deathdata.objweapon;
  victim.skipcorpse = 1;
  vehicle::vehicle_playerkilledbycollision(deathdata);

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse)) {
    if(isDefined(victim.body)) {
      victim.body delete();
      victim.body = undefined;
    }

    victim.body = victim cloneplayer(deathdata.deathanimduration, attacker);
  }

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse) && isDefined(victim.body)) {
    victim.body.targetname = "player_corpse";

    if(deathdata.isnukekill) {}

    enqueueweapononkillcorpsetablefuncs(attacker, victim, inflictor, objweapon, meansofdeath);
    victim thread callcorpsetablefuncs();

    if(deathdata.isfauxdeath) {
      victim scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
      victim setsolid(0);
    }

    if(!isDefined(victim.switching_teams)) {
      var_e707f0032fa7b4bb = [];

      foreach(player in level.players) {
        if(isDefined(victim) && istrue(player_utility::playersareenemies(player, victim)) && player utility::_hasperk("specialty_kill_report")) {
          var_e707f0032fa7b4bb[index] = player;
        }
      }

      if(var_e707f0032fa7b4bb.size > 0) {}
    }

    victim thread _startragdoll(deathdata.victim.body, deathdata.meansofdeath, deathdata.inflictor);
  } else if(isDefined(victim.nocorpse) && !istrue(victim.skipcorpse)) {
    if(isDefined(victim.body)) {
      victim.body delete();
      victim.body = undefined;
    }

    victim.body = victim cloneplayer(deathdata.deathanimduration);
    victim.body hide(1);
  }

  if(istrue(game["isLaunchChunk"])) {}
}

function enqueueweapononkillcorpsetablefuncs(attacker, victim, inflictor, objweapon, meansofdeath) {}

function callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  corpsetable = self.body;

  foreach(func in self.corpsetablefuncs) {
    self thread[[func]](corpsetable);
  }

  thread clearcorpsetablefuncs();
}

function clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

function setdeathtimerlength(deathdata) {
  victim = deathdata.victim;
  actualtimeuntilspawn = 0;

  if(victim mayspawn()) {
    timeuntilspawn = timeuntilspawn(1);
    minimumtime = 2.25;
    var_b5c34c3bc6c7e65 = 1;
    timeuntilspawn = max(timeuntilspawn + var_b5c34c3bc6c7e65, minimumtime);
    actualtimeuntilspawn = timeuntilspawn + deathdata.deathscenetimesec;
  }

  victim.death_timer_length = int(actualtimeuntilspawn * 10);
}

function mayspawn() {
  if(istrue(level.nukeinfo.gameover)) {
    return false;
  }

  if(getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1) {
      return true;
    }

    if(istrue(level.disablespawning)) {
      if(!istestclient(self)) {
        return false;
      }
    }

    if(istrue(self.pers["teamKillPunish"])) {
      return false;
    }

    if(gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned) {
        return true;
      }

      if(!level.ingraceperiod && !self.hasspawned && isDefined(level.allowlatecomers) && !level.allowlatecomers) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer) {
          return true;
        }

        if(istestclient(self)) {
          return true;
        }

        return false;
      }
    }
  }

  if(isDefined(level.disablespawningforplayerfunc) && [[level.disablespawningforplayerfunc]](self)) {
    return false;
  }

  return true;
}

function getgametypenumlives() {
  return true;
}

function gamehasstarted() {
  if(isDefined(level.gamehasstarted)) {
    return level.gamehasstarted;
  }

  foreach(team in level.teamnamelist) {
    if(cp_outline_utility::getteamdata(team, "hasSpawned")) {
      return 1;
    }
  }

  return 0;
}

function timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    return 0;
  }

  respawndelay = 0;

  if(self.hasspawned) {
    if(isDefined(level.onrespawndelay)) {
      result = self[[level.onrespawndelay]]();

      if(isDefined(result)) {
        respawndelay = result;
      } else {
        respawndelay = getdvarfloat(hashcat(@ "scr_", utility::getgametype(), "_playerrespawndelay"));
      }
    } else {
      respawndelay = getdvarfloat(hashcat(@ "scr_", utility::getgametype(), "_playerrespawndelay"));
    }

    if(isDefined(self.suicidespawndelay)) {
      respawndelay += getdvarfloat(hashcat(@ "scr_", utility::getgametype(), "_suicidespawndelay"));
    }

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      timealreadypassed = (gettime() - self.respawntimerstarttime) / 1000;
      respawndelay -= timealreadypassed;

      if(respawndelay < 0) {
        respawndelay = 0;
      }
    }

    if(isDefined(self.setspawnpoint)) {
      respawndelay += level.tispawndelay;
    }
  }

  wavebased = getdvarint(hashcat(@ "scr_", utility::getgametype(), "_waverespawndelay")) > 0;

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    respawndelay = 0;
  } else if(getdvarint(@ "hash_4ac8d16ce8dd74fd", 0) == 1) {
    respawndelay = 999;
  }

  if(!isDefined(self.initialrespawndelay)) {
    self.initialrespawndelay = respawndelay;
  }

  return respawndelay;
}

function playerkilled_deathscene(deathdata) {
  victim = deathdata.victim;
  victim endon("spawned");

  if(!deathdata.isfauxdeath) {
    if(!isDefined(victim.respawntimerstarttime)) {
      victim.respawntimerstarttime = gettime() + deathdata.deathscenetimems;
    }

    wait deathdata.deathscenetimesec;
    victim notify("death_delay_finished");
  } else if(!isDefined(victim.respawntimerstarttime)) {
    victim.respawntimerstarttime = gettime();
  }

  level notify("deathScene_over");

  laststand::function_f9249bb06eb48092(deathdata);
}

function playerkilled_spawn(deathdata) {
  victim = deathdata.victim;
  victim endon("spawned");
  victim endon("disconnect");
  attacker = deathdata.attacker;
  victim resetplayervariables();
  victim resetplayeromnvarsonspawn();

  if(isDefined(level.modeplayerkilledspawn) && [[level.modeplayerkilledspawn]](deathdata)) {
    return;
  }

  if(isDefined(attacker)) {
    victim.lastattacker = attacker;
  } else {
    victim.lastattacker = undefined;
  }

  victim.wantsafespawn = 0;

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      victim utility::updatesessionstate("dead");
    }

    return;
  }

  laststand::function_449348b412e6b21(victim, victim);
  spawn_delay = 3;

  if(isDefined(victim.var_ec2e7871feb66a8e)) {
    spawn_delay = victim.var_ec2e7871feb66a8e;
  }

  victim thread globallogic::spawnplayer(undefined, spawn_delay);
}

function resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.inlaststand = 0;
  self.pers["cur_kill_streak"] = 0;
  self.killcountthislife = 0;
  detachusemodels();
}

function detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

function resetplayeromnvarsonspawn() {
  resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

function resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode)) {
    [[level.resetuiomnvargamemode]]();
  }

  self setclientomnvar("ui_objective_pinned_text_param", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_is_laststand", 0);
  self setclientomnvar("swim_breath_meter_critical", 0);
}

function modifyteamdata(team, property, value) {
  assertex(isDefined(level.teamdata[team]), "UNDEFINED level.teamData[" + team + "]");
  assertex(isDefined(level.teamdata[team][property]), "UNDEFINED level.teamData[" + team + "][" + property + "]");
  assertex(isDefined(value), "modifyTeamCount() undefined value");
  level.teamdata[team][property] += value;
}

function handleworlddeath(deathdata, attacker, lifeid, smeansofdeath, shitloc) {
  victim = deathdata.victim;
  victim.deathspectatepos = victim.origin;

  if(!isDefined(attacker)) {
    return;
  }

  if(!isDefined(attacker.team) || attacker.team == "neutral") {
    handlesuicidedeath(smeansofdeath, shitloc);
    return;
  }

  assert(isagent(attacker) || utility::isgameplayteam(attacker.team));

  if(level.teambased && attacker.team != victim.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(attacker) || isagent(attacker)) && attacker.team != "spectator" || isDefined(attacker.damagetrigger)) {
      if(!level.gameended) {
        victim[[level.onnormaldeath]](attacker, lifeid, smeansofdeath);
      }
    }
  }

  if(isagent(attacker)) {
    deathdata.dokillcam = 1;
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath);
  }
}

function handlesuicidedeath(smeansofdeath, shitloc) {
  if(scripts\engine\utility::issharedfuncdefined("player", "handleSuicideDeath")) {
    self[[scripts\engine\utility::getsharedfunc("player", "handleSuicideDeath")]]();
    return;
  }

  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);
  onsuicidedeath(self);
  self.suicidespawndelay = 1;

  if(isDefined(self.friendlydamage)) {
    self.friendlyfiredeath = 1;
  }
}

function onsuicidedeath(victim) {
  if(!level.teambased) {
    liveplayers = utility::get_array_of_valid_players();
    victim.score = level.totalplayers - liveplayers.size;

    foreach(player in liveplayers) {
      player.score = victim.score + 1;
    }

    return;
  }

  if(utility::gameflag("prematch_done")) {}
}

function gamemodemodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  if(isDefined(eattacker) && isPlayer(eattacker) && isalive(eattacker)) {
    if(istrue(level.matchrules_damagemultiplier)) {
      idamage *= level.matchrules_damagemultiplier;
    }

    if(istrue(level.matchrules_vampirism)) {
      eattacker.health = int(min(float(eattacker.maxhealth), min(eattacker.health + idamage, float(eattacker.health + 20))));
      eattacker notify("vampirism");
    }

    if(game_utility::function_21322da268e71c19() && !isspreadweapon(objweapon)) {
      switch (shitloc) {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
          idamage = victim.maxhealth;

          if(isDefined(victim.maxarmorhealth)) {
            idamage += victim.maxarmorhealth;
          }

          break;
        default:
          break;
      }
    }
  }

  return idamage;
}

function isspreadweapon(objweapon) {
  return isDefined(objweapon) && weaponclass(objweapon) == "spread";
}