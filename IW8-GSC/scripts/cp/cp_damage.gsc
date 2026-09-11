/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_damage.gsc
***********************************************/

function callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = createheadicon(var_5);
  var_15 = self;
  var_16 = isDefined(var_1);
  var_17 = var_16 && isPlayer(var_1);

  if(!var_17) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.code_classname) && var_1.code_classname == "misc_turret") {
        var_0 = var_1;
      }

      if(isDefined(var_1.owner) && (isPlayer(var_1.owner) || isagent(var_1.owner))) {
        var_1 = var_1.owner;
        var_17 = 1;
        var_16 = 1;
      }
    }

    if(!var_17) {
      if(isDefined(var_0) && isDefined(var_0.owner) && (isPlayer(var_0.owner) || isagent(var_0.owner))) {
        var_1 = var_0.owner;
        var_17 = 1;
        var_16 = 1;
      }
    }
  }

  if(!shouldtakedamage(var_2, var_1, var_14, var_3, var_17)) {
    return;
  }

  if(damageflag(1)) {}

  if(var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_15 scripts\cp_mp\utility\player_utility::getvehicle()) && var_15 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }

  if(var_4 == "MOD_CRUSH" && isDefined(var_0) && istrue(var_0.little_bird_mg_enterend)) {
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::ref_14201(var_0, var_15, var_4, var_5)) {
    return;
  }

  if(istrue(var_15.inlaststand)) {
    return;
  }

  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_14])) {
      level thread[[level.overcook_func[var_14]]](var_15, var_14);
    }

    if(scripts\cp\cp_relics::try_start_fake_infil_chopper("relic_amped") && istrue(var_15.ref_12a7e)) {
      var_2 = var_13;
    }
  }

  var_3 |= 4;
  var_18 = isDefined(var_4) && (var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH");
  var_19 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_20 = isfriendlyfire(self, var_1);
  var_21 = self.perk_data["friendly_explosive_damage_reduction"] != 1;
  var_22 = var_16 && var_1 == self;
  var_23 = (var_22 || !var_16) && var_4 == "MOD_SUICIDE";

  if(var_16) {
    if(var_1 == self) {
      if(var_18) {
        var_2 *= self.perk_data["friendly_explosive_damage_reduction"];
      }
    } else if(var_20) {
      var_2 = 0;

      if(isPlayer(var_15) && isPlayer(var_1)) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_15, "check_fire_ally");
      }
    }

    if(var_4 == "MOD_EXPLOSIVE") {
      if(var_14 == "at_mine_ap_mp") {
        var_2 = self.maxhealth * 0.9;
      }

      var_2 *= scripts\cp\perks\cp_perks::get_perk("enemy_explosive_damage_reduction");

      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var_15)) {}

        var_2 += var_2 * level.explosivedamagemod;
      }
    } else if(var_4 == "MOD_GRENADE_SPLASH") {
      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var_15)) {}

        var_2 += var_2 * level.explosivedamagemod;
      }
    }
  }

  if(var_4 == "MOD_FALLING" && !scripts\cp\utility::turn_off_sniper_laser()) {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var_2 = 0;
    } else {
      if(getdvarint("scr_old_cp_fall_damage", 0) <= 0) {
        var_2 = self.maxhealth + self.armor;
      }

      physicsexplosionsphere(self.origin, 64, 64, 1);
    }
  }

  var_24 = 0;

  if(var_22 && !var_23) {
    var_2 = int(var_2 * var_15 scripts\cp\utility::getdamagemodifiertotal());
  }

  if(scripts\cp\cp_weapon::isflashgrenadedamage(var_5, var_4)) {
    var_25 = scripts\cp\cp_weapon::applyflashfromdamage(var_15, var_1, var_6, 0);

    if(!var_25) {
      return;
    }
  }

  var_26 = self getcurrentprimaryweapon();

  if(var_26.type == "melee") {
    var_2 = int(var_2 * self.perk_data["carrying_melee_damage_scalar"]);
  }

  if(var_26.basename == "iw8_me_riotshield_mp") {
    if(!shouldskipdeathshield(var_0, var_1, var_4)) {
      if(isDefined(var_8) && var_8 == "shield") {
        if(isDefined(self.riot_shield_damage)) {
          self.riot_shield_damage -= var_2;
        }
      }
    }
  }

  if(self issprinting()) {
    var_2 = int(var_2 * self.perk_data["sprint_damage_scalar"]);
  }

  if(self.isreviving == 1) {
    var_2 = int(var_2 * self.perk_data["revive_damage_scalar"]);
  }

  if(isDefined(self.super_invulnerable)) {
    if(var_17) {
      self shellshock("invul_hit", 0.25);
    }

    var_2 = 0;
  }

  if(isDefined(self.vehicle_riding_on)) {
    self.vehicle_riding_on dodamage(var_2, self.vehicle_riding_on.origin);
    var_2 = int(clamp(var_2, 0, self.health - 1));
  }

  var_2 = modifydamagegeneral(var_0, var_1, var_15, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_2 <= 0) {
    return;
  }

  if(isPlayer(self) && isDefined(self.jugg_health)) {
    self.jugg_health -= var_2;

    if(self.jugg_health <= 0) {
      if(var_4 != "MOD_FALLING") {
        var_2 = 0;
      }

      self notify("juggernaut_end_damage");
    }
  }

  if(var_16 && var_2 > 0) {
    if(!damageflag(1)) {
      if(getdvarint("scr_dmg_frame_skip", 20) != 20) {
        var_27 = getdvarint("scr_dmg_frame_skip") * level.framedurationseconds * 1000;
      } else {
        var_27 = level.framedurationseconds * 1000 * 20;
      }

      self.damageshieldexpiretime = gettime() + var_27;
    }

    if(isai(var_2) || isPlayer(var_2) && var_2 != self) {
      scripts\cp\cp_agent_damage::addattacker(self, var_2, var_1, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

      if(!isDefined(var_2.damagedplayers)) {
        var_2.damagedplayers = [];
      }

      var_28 = gettime();
      var_2.damagedplayers[var_16.guid] = var_28;
    }
  }

  if(isPlayer(var_2) && isDefined(var_2.pers["participation"])) {
    var_2.pers["participation"]++;
  } else if(isPlayer(var_2)) {
    var_2.pers["participation"] = 1;
  }

  if(isPlayer(self) && isDefined(self.pers["participation"])) {
    self.pers["participation"]++;
  } else if(isPlayer(self)) {
    self.pers["participation"] = 1;
  }

  scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(self, 1);
  var_29 = 0;

  if(isDefined(var_2) && isai(var_2)) {
    if(istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting())) {
      var_3 = 1;
    }
  }

  if(!var_21) {
    if(scripts\cp\cp_armor::has_armor(self) && scripts\cp\cp_armor::armor_resistance_to_type(var_5, var_6, var_1, var_2)) {
      if(isDefined(var_9) && var_9 != "shield") {
        var_3 = scripts\cp\cp_armor::damage_armored_player(self, var_1, var_2, var_3, var_4, var_5, var_15, var_7, var_8, var_9, var_10, var_26, var_11, var_12);
        var_29 = 1;
      }
    }

    if(isDefined(level.updateondamagerelicsfunc)) {
      level thread[[level.updateondamagerelicsfunc]](var_2, var_15, self);
    }

    if(var_3 >= self.health && !shouldskipdeathshield(var_1, var_2, var_5)) {
      if(shouldactivatedeathshield(var_3)) {
        var_3 = self.health - 1;
        GscBinSkip4(0x35, var_3, var_2, var_8, var_7, undefined, undefined, var_1);
      }

      GscBinSkip4(0x35, var_3, var_2, var_8, var_7, undefined, undefined, var_1);
    }

    if(var_5 == "MOD_CRUSH" && var_3 >= self.health) {
      self.shouldskiplaststand = 1;
    }

    var_3 = int(var_3);

    if(var_18 && !isPlayer(self) && !var_23) {
      var_2 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }

    if(istrue(self.shouldskipdeathsshield)) {
      self.shouldskipdeathsshield = undefined;
    }

    if(istrue(self.oob)) {
      self.shouldskiplaststand = 1;
      var_3 = self.health + 100;
    }

    finishplayerdamagewrapper(var_1, var_2, var_3, var_4, var_5, var_15, var_7, var_8, var_9, var_10, var_26, var_11, var_12, var_29);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_3);

  if(var_3 != 0) {
    thread scripts\cp\cp_hud_util::ref_12480();
  }

  if(var_17) {
    if(isagent(var_2)) {
      if(!isDefined(var_2.damage_done)) {
        var_2.damage_done = 0;
      } else {
        var_2.damage_done += var_3;
      }

      self.recent_attacker = var_2;

      if(isDefined(level.current_challenge)) {
        if(isDefined(level.custom_playerdamage_challenge_func)) {
          self[[level.custom_playerdamage_challenge_func]](var_1, var_2, var_3, var_4, var_5, var_15, var_7, var_8, var_9);
        }
      }
    }
  }

  if(scripts\engine\utility::isbulletdamage(var_5)) {
    var_16 thread scripts\cp\cp_player_battlechatter::adddamagetaken(var_2, var_6, var_3);
  }

  if(isagent(var_2) && isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && var_2 != var_16) {
    var_16 thread scripts\cp\cp_player_battlechatter::addrecentattacker(var_2);
  }

  if(isDefined(var_16) && var_16 scripts\cp_mp\utility\player_utility::_isalive() && var_16.health < 30) {
    var_16 thread scripts\cp\cp_player_battlechatter::hurtbadlywait();
  }

  if(isDefined(var_16) && var_16 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_2) && var_2 != var_16 && weaponclass(var_6) == "rocketlauncher") {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_16, "survive_rpg", undefined, 1);
  }

  if(isDefined(var_16) && var_16.health <= 1) {
    var_16 scripts\cp\cp_player_battlechatter::onplayerkilled(var_1, var_2, var_3, var_5, var_6);
    return;
  }
}

function van_initdamage() {
  if(scripts\cp\utility\player::isusingremote()) {
    return true;
  }

  return false;
}

function shouldskipdeathshield(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 == self) {
    return true;
  }

  if(istrue(self.shouldskipdeathsshield)) {
    return true;
  }

  if(getdvarint("scr_dfa_force_skip_ds", 0) != 0) {
    if(isDefined(var_0)) {
      if(isDefined(var_0.weapon_name)) {
        switch (var_0.weapon_name) {
          case "ac130_105mm_mp":
          case "ac130_40mm_mp":
          case "ac130_25mm_mp":
            return true;
        }
      }
    }
  }

  if(isDefined(var_0) && triggersafearea(var_0)) {
    if(var_2 == "MOD_CRUSH") {
      return true;
    }
  }

  switch (var_2) {
    case "MOD_SUICIDE":
    case "MOD_FALLING":
    case "MOD_TRIGGER_HURT":
    case "MOD_EXECUTION":
      return true;
  }

  return false;
}

function triggersafearea(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    if(level.cratedata.crates.size > 0) {
      if(scripts\engine\utility::array_contains(level.cratedata.crates, var_0)) {
        return true;
      }
    }
  }

  return false;
}

function weapon_is_a_vehicle_weapon(var_0) {
  switch (var_0.basename) {
    case "lighttank_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
      return 1;
    default:
      return 0;
  }
}

function isenemyinfrontofme(var_0, var_1) {
  var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);

  if(!isDefined(var_1)) {
    return (var_4 > 0);
  }

  return var_4 > var_1;
}

function isoneshotdamage(var_0, var_1) {
  if(var_1 == "MOD_TRIGGER_HURT" || var_1 == "MOD_UNKNOWN" || var_1 == "MOD_SUICIDE") {
    return false;
  }

  if(var_0 >= self.health) {
    return true;
  }

  return false;
}

function delayed_stun_damage(var_0) {
  self endon("death");
  var_0 endon("death");
  wait 0.05;
  self dodamage(2, self.origin, var_0, undefined, "MOD_MELEE");
}

function stopusingremote() {
  self notify("stop_using_remote");
}

function useinvulnerability(var_0) {
  self.health = var_0 + 1;
  self.haveinvulnerabilityavailable = 0;
}

function shouldtakedamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && (var_3 == 256 || var_3 == 258)) {
    return false;
  }

  if(isDefined(self.inlaststand) && self.inlaststand) {
    return false;
  }

  if(damageflag(1)) {
    return false;
  }

  if(isDefined(level.intro_heli) && isbuiltinfunction(level.intro_heli)) {
    if(![[level.intro_heli]](self)) {
      return false;
    }
  }

  if(van_initdamage() && scripts\cp\utility::tryingtoleave()) {
    return false;
  }

  if(isDefined(self.ability_invulnerable)) {
    return false;
  }

  if(isDefined(var_2) && var_2 == "iw8_la_rpapa7_mp_friendly") {
    return false;
  }

  if(isDefined(var_2) && var_2 == "overwatch_missile_cp") {
    return false;
  }

  if(isDefined(var_2) && var_2 == "tur_gun_decho_cp") {
    return false;
  }

  if(istrue(self.inchopper)) {
    return false;
  }

  return true;
}

function check_for_explosive_shotgun_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 500;

  if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return var_1;
  }

  if(!isDefined(var_2) || !isPlayer(var_2) || var_4 != "MOD_EXPLOSIVE_BULLET") {
    return var_1;
  }

  if(var_3.classname == "weapon_shotgun") {
    var_6 = distance(var_2.origin, var_0.origin);
    var_7 = max(1, var_6 / var_5);
    var_8 = var_1 * 8;
    var_9 = var_8 * var_7;

    if(var_6 > var_5) {
      return var_1;
    }

    return int(var_9);
  }

  return var_5;
}

function kill_trigger_event_was_processed() {
  return istrue(self.kill_trigger_event_processed);
}

function set_kill_trigger_event_processed(var_0, var_1) {
  self.kill_trigger_event_processed = var_1;
}

function scale_alien_damage_by_weapon_type(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4 != "none") {
    var_1 = check_for_explosive_shotgun_damage(self, var_1, var_0, var_3, var_2);
  }

  if(isDefined(var_2) && var_2 == "MOD_EXPLOSIVE_BULLET" && var_4 != "none") {
    if(var_3.classname == "weapon_shotgun") {
      var_1 += int(var_1 * level.shotgundamagemod);
    } else {
      var_1 += int(var_1 * level.exploimpactmod);
    }
  }

  return var_1;
}

function scale_alien_damage_by_perks(var_0, var_1, var_2, var_3) {}

function scale_alien_damage_by_prestige(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_2 = var_0 scripts\cp\perks\cp_prestige::prestige_getweapondamagescalar();
    var_1 *= var_2;
    var_1 = int(var_1);
  }

  return var_1;
}

function should_play_melee_blood_vfx(var_0) {
  if(isDefined(level.should_play_melee_blood_vfx_func)) {
    return [[level.should_play_melee_blood_vfx_func]](var_0);
  }

  return 1;
}

function check_for_special_damage(var_0, var_1, var_2) {}

function catch_alien_on_fire(var_0, var_1, var_2, var_3) {
  self endon("death");
  alien_fire_on();
  damage_alien_over_time(var_0, var_1, var_2, var_3);
  alien_fire_off();
}

function alien_fire_on() {
  if(!isDefined(self.is_burning)) {
    self.is_burning = 0;
  }

  self.is_burning++;

  if(self.is_burning == 1 && self.species == "alien") {
    if(isDefined(self.agent_type) && self.agent_type != "minion") {
      self setscriptablepartstate("animpart", "burning");
      return;
    }

    return;
  }
}

function alien_fire_off() {
  self.is_burning--;

  if(self.is_burning > 0) {
    return;
  }

  self.is_burning = undefined;
  self notify("fire_off");

  if(self.species == "alien") {
    self setscriptablepartstate("animpart", "normal");
    return;
  }
}

function damage_alien_over_time(var_0, var_1, var_2, var_3) {
  var_4 = 150;
  var_5 = 100;
  var_6 = 75;
  var_7 = 133;
  var_8 = 500;
  var_9 = 100;
  var_10 = 3;
  var_11 = 4;
  var_12 = 3;
  var_13 = 4;
  var_14 = 4;
  var_15 = 2;
  var_16 = 1.2;
  self endon("death");

  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_17 = scripts\cp\cp_agent_utils::get_agent_type(self);

    switch (var_17) {
      case "goon4":
      case "goon3":
      case "goon2":
      case "goon":
        var_2 = var_6;
        var_1 = var_12;
      case "brute4":
      case "brute3":
      case "brute2":
      case "brute":
        var_2 = var_5;
        var_1 = var_11;
      case "spitter":
        var_2 = var_7;
        var_1 = var_13;
      case "elite_boss":
      case "elite":
        var_2 = var_8;
        var_1 = var_14;
      case "minion":
        var_2 = var_9;
        var_1 = var_15;
      default:
        var_2 = self.maxhealth * 0.5;
        var_1 = var_10;
        break;
    }
  } else {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    }

    if(!isDefined(var_1)) {
      var_1 = var_10;
    }
  }

  if(isDefined(var_0) && isDefined(var_3) && var_0 scripts\cp\utility::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(var_3)) {
    var_2 *= var_16;
  }

  var_2 *= level.alien_health_per_player_scalar[level.players.size];
  var_18 = 0;
  var_19 = 6;
  var_20 = var_1 / var_19;
  var_21 = var_2 / var_19;

  for(var_22 = 0; var_22 < var_19; var_22++) {
    wait var_20;

    if(isalive(self)) {
      self dodamage(var_21, self.origin, var_0, var_0, "MOD_UNKNOWN");
    }
  }
}

function friendlyfirecheck(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  var_3 = var_1.team;
  var_4 = level.friendlyfire;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return true;
  }

  if(var_1 == var_0) {
    return false;
  }

  if(!isDefined(var_3)) {
    return true;
  }

  if(var_3 != var_0.team) {
    return true;
  }

  return false;
}

function update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isDefined(var_1.owner)) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_2 * 0.75);
  } else if(isDefined(var_1) && isDefined(var_1.pet) && var_1.pet == 1) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_2);
  } else {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_5)) {
    thread update_zombie_damage_challenge(level, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  update_alien_damage_performance(var_1, var_2, var_4);
}

function update_zombie_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(self.died_poorly)) {
    return;
  }

  if(!isDefined(level.current_challenge)) {
    return;
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = self[[level.custom_damage_challenge_func]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10);

    if(!istrue(var_11)) {
      return;
    }

    return;
  }
}

function update_alien_damage_performance(var_0, var_1, var_2) {
  if(isDefined(level.update_alien_damage_performance)) {
    [[level.update_alien_damage_performance]](var_0, var_1, var_2);
    return;
  }

  update_performance_zombie_damage(var_0, var_1, var_2);
}

function update_performance_zombie_damage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }

  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }

  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "damage_done_on_alien", var_1);

  if(isPlayer(var_0)) {
    var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_1);
    return;
  }

  if(isDefined(var_0.owner)) {
    var_0.owner scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_1);
    return;
  }
}

function modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflag;

  if(isDefined(var_5) && var_5 && level.idflags_ricochet) {
    var_6 = 0.6 * var_4;
  } else {
    var_6 = var_5;
  }

  var_6 = handleempdamage(var_3, var_4, var_6);
  var_6 = handlemissiledamage(var_3, var_4, var_6);
  var_6 = handlegrenadedamage(var_3, var_4, var_6);
  return var_6;
}

function handlemissiledamage(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "bomb_site_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var_3 *= 2;
      break;
  }

  return var_3;
}

function handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0.basename) {
      case "c4_mp_p":
        var_2 *= 3;
        break;
      case "bouncing_betty_mp":
      case "frag_grenade_mp":
      case "semtex_mp":
        var_2 *= 4;
        break;
      default:
        if(var_0.isalternate) {
          var_2 *= 3;
        }

        break;
    }
  }

  return var_2;
}

function handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return (self.maxhealth + 1);
  }

  return var_2;
}

function handleempdamage(var_0, var_1, var_2) {
  return var_2;
}

function handleapdamage(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = 1;

  if(isDefined(var_3) && isDefined(var_3.class) && var_3.class == "engineer" && isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_4 += var_5;
  } else {
    var_6 = level.armorpiercingmod - 1;

    if(scripts\cp\utility::isfmjdamage(var_0, var_1, var_3)) {
      var_4 += var_6;
    }

    if(isDefined(level.armorpiercingmodks)) {
      var_7 = level.armorpiercingmodks - 1;

      if(isDefined(var_3) && var_3 scripts\cp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\cp\cp_weapon::isprimaryweapon(var_0) && scripts\engine\utility::isbulletdamage(var_1)) {
        var_4 += var_7;
      }
    }
  }

  return var_2 * var_4;
}

function handleshotgundamage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return var_2;
  }

  if(var_0.basename == "none") {
    return var_2;
  }

  if(weaponclass(var_0) != "spread") {
    return var_2;
  }

  return int(min(150, var_2));
}

function armormitigation(var_0, var_1, var_2) {
  return true;
}

function isfriendlyfire(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
    if(level.givematchplacementchallenge == var_1) {
      return false;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var_1)) {
      return false;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var_1)) {
      return false;
    }
  }

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return false;
  }

  if(var_0.team != var_1.team) {
    return false;
  }

  if(var_0 == var_1) {
    return false;
  }

  return true;
}

function finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!callback_killingblow(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isPlayer(self)) {
    if(var_2 >= self.health) {
      if(van_initdamage()) {
        if(!isDefined(var_7)) {
          var_7 = (0, 0, 0);
        }

        if(!isDefined(var_1)) {
          var_1 = self;
        }

        if(!isDefined(var_0)) {
          var_0 = var_1;
        }

        scripts\cp\utility::allow_player_ignore_me(1);
        var_14 = self playerforcedeathanim(var_0, var_4, var_5, var_8, var_7);
        self.fauxdead = 1;
        self.shouldskiplaststand = 1;
        self notify("faux_dead");

        if(!isDefined(self.nocorpse)) {
          self.body = self cloneplayer(var_14, var_1);
        }

        if(!isDefined(self.nocorpse) && isDefined(self.body)) {
          self.body.targetname = "player_corpse";
          self playerhide();
          self setsolid(0);
          thread _startragdoll(self.body, var_4, var_0);
        }

        if(van_initdamage()) {
          thread ref_127e1();
          self waittill("stopped_using_remote");
          var_2 = self.health + 100000;

          if(var_8 == "shield") {
            var_8 = "torso_upper";
          }
        }

        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        self setsolid(1);
        scripts\cp\utility::allow_player_ignore_me(0);
      } else if(isDefined(level.interiordoor) && isbuiltinfunction(level.interiordoor)) {
        self.health = 1;
        var_2 = 0;
        self[[level.interiordoor]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        var_2 = self.health + 100000;

        if(var_8 == "shield") {
          var_8 = "torso_upper";
        }

        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(istrue(self.isjuggernaut)) {
        self waittill("juggernaut_end");
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(isDefined(self.vehicle)) {
        scripts\engine\utility::ref_143ba(2, "exited_vehicle", "vehicle_exit");
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        self disableusability();
      } else {
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      }
    } else {
      self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    }
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

function _startragdoll(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 endon("death");
  var_3 = var_0 getcorpseanim();
  var_4 = undefined;
  var_5 = getanimlength(var_3);
  var_6 = undefined;
  var_7 = animhasnotetrack(var_3, "delete_corpse");
  var_8 = animhasnotetrack(var_3, "delete_corpse_delayed");
  var_9 = animhasnotetrack(var_3, "no_ragdoll");
  var_10 = animhasnotetrack(var_3, "start_ragdoll");
  var_4 = 0;

  if(var_10) {
    var_11 = getnotetracktimes(var_3, "start_ragdoll")[0];
    var_4 = var_11 * var_5;
  }

  wait var_4;

  if(!isDefined(var_0)) {
    return;
  }

  if(!var_0 isragdoll()) {
    var_0 startragdoll();
  }

  if(var_7 || var_8) {
    var_12 = var_5;

    if(var_8) {
      var_5 += 3;
    }

    if(isDefined(var_4)) {
      var_12 -= var_4;
    }

    wait var_12;
    var_0 delete();
    return;
  }

  var_0 setplayercorpsedone();
}

function callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_2 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\cp\utility::giveperk("specialty_endgame");
    return false;
  }

  return true;
}

function ref_127e1() {
  self endon("disconnect");
  self endon("death");
  self endon("laststand");
  self waittill("stopped_using_remote");
  wait 0.1;

  if(!self.inlaststand) {
    self suicide();
    return;
  }
}

function damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread onweapondamage(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self)) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }
}

function onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");

  switch (var_1) {
    default:
      if(allowshellshockondamage(var_1) && !isai(var_4)) {
        scripts\cp\cp_weapon::shellshockondamage(var_2, var_3);
      }

      break;
  }
}

function allowshellshockondamage(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "iw7_zapper_grey":
      case "chopper_boss_minigun_cp":
        return false;
    }
  }

  return true;
}

function istacticaldamage(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var_0.basename) {
    case "cryo_mine_mp":
    case "blackout_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_mp":
      return 0;
    default:
      return 0;
  }
}

function damage_should_ignore_blast_shield(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_0, var_1, undefined, var_2, var_3, var_4);

  if(var_3 == "MOD_GRENADE") {
    return true;
  }

  if(var_3 == "MOD_PROJECTILE") {
    return true;
  }

  if(isDefined(var_0) && var_0 == var_1) {
    return true;
  }

  if(var_1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_6)) {
    return true;
  }

  if(weaponignoresblastshield(var_2, var_5)) {
    return true;
  }

  return false;
}

function weaponignoresblastshield(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\cp\utility::issuperweapon(var_2)) {
    return 1;
  }

  switch (var_2) {
    case "sentry_shock_mp":
    case "apache_turret_mp":
    case "artillery_mp":
    case "cruise_proj_mp":
    case "toma_proj_mp":
    case "apache_proj_mp":
    case "bomb_site_mp":
    case "bradley_tow_proj_mp":
    case "thermite_ap_mp":
    case "thermite_av_mp":
    case "snapshot_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "thermite_mp":
      return 1;
    default:
      return 0;
  }
}

function modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 *= getdvarfloat("scr_explBulletMod");
    var_3 = int(var_3);
  }

  if(isDefined(level.modifyplayerdamage_relics) && isarray(level.modifyplayerdamage_relics)) {
    foreach(var_12 in level.modifyplayerdamage_relics) {
      var_3 = [[var_12]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_3 = [[level.modifyplayerdamage]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
  }

  if(!isDefined(var_2.donotmodifydamage)) {
    var_3 = int(var_3 * var_2 scripts\cp\utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_5, var_6, var_9));
  }

  if(scripts\cp\utility::tryingtoleave()) {
    return var_3;
  }

  if(isPlayer(self)) {
    if(isDefined(var_1) && isagent(var_1) && !isexplosivedamagemod(var_5) && !isenemyinfrontofme(var_1) && !istrue(var_5 == "MOD_MELEE")) {
      var_3 *= 0.5;
    }
  }

  return var_3;
}

function damageinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getinvultime();
  enabledamageinvulnerability();
  wait var_7;
  disabledamageinvulnerability();
}

function shoulddodamageinvulnerabilty(var_0) {
  if(scripts\engine\utility::ent_flag("player_zero_attacker_accuracy")) {
    return false;
  }

  if(damageflag(1)) {
    return false;
  }

  return true;
}

function getinvultime() {
  return self.gs.invultime_ondamagemin;
}

function enabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

function disabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_clear("player_zero_attacker_accuracy");
  scripts\cp\cp_gameskill::update_player_attacker_accuracy();
}

function deathshieldinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getdeathsshieldduration();
  var_8 = getdeathsdoorduration();

  if(!scripts\cp\utility::tryingtoleave()) {
    var_7 = getdvarint("scr_dd_time", 1);
  }

  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  var_9 = level.framedurationseconds * 1000 * 40;

  if(istrue(level.ref_12bac)) {
    var_9 = level.framedurationseconds * 1000 * 10;
  }

  self.damageshieldexpiretime = gettime() + var_9;

  if(!istrue(self.adrenalinepoweractive)) {
    ref_1433e(var_7, "force_regeneration");
  }

  setdamageflag(1, 0);
  disabledamageinvulnerability();

  if(!istrue(self.adrenalinepoweractive)) {
    ref_1433e(var_8, "force_regeneration");
  }

  disabledeathsdoor();
}

function ref_1433e(var_0, var_1) {
  self endon(var_1);
  wait var_0;
}

function getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

function getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

function enabledeathsdoor() {
  setdamageflag(2, 1);

  if(!scripts\cp_mp\utility\player_utility::ref_12510()) {
    var_0 = 0.5;
    var_1 = 2 + getdeathsdoorduration() + gethealthregentime() - var_0;
    thread deathsdooroverlaypulse(var_1);
    var_2 = 0.5;
    var_3 = var_1 - var_2;
    thread bloodoverlay(1, var_3, var_2);
    updatedeathsdoorvisionset();
    self painvisionon();
    return;
  }
}

function deathsdooroverlaypulse(var_0) {
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("disconnect");
  var_1 = 1;
  thread lerpdeathsdoorpulsenorm(var_0);

  while(var_1 > 0) {
    var_2 = gettime();
    var_3 = var_2;
    var_4 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(var_2 < var_3 + var_4) {
      var_2 = gettime();
      var_5 = 0.1;
      var_6 = 0.4;
      var_7 = (var_2 - var_3) / var_4;
      var_8 = scripts\engine\math::normalized_cos_wave(var_7);
      var_1 = scripts\engine\math::factor_value(var_5, var_6, var_8);
      var_1 *= self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = var_1;
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

function bloodoverlay(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  self endon("stopPainOverlays");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = var_0;
  ref_1433e(var_1, "force_regeneration");

  if(var_2 <= 0) {
    var_2 = 1;
  }

  self.damage.bloodoverlay fadeovertime(var_2);
  self.damage.bloodoverlay.alpha = 0;
}

function updatedeathsdoorvisionset() {
  if(!damageflag(2)) {
    return 0;
  }

  if(self isnightvisionon() || scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_nvg"), 0);
    return;
  }

  visionsetpain("pain_mp");
}

function disabledeathsdoor(var_0) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    var_1 = gethealthregentime();
  } else {
    var_1 = 0;
  }

  var_2 = getvisionlerprate(var_1);
  setdamageflag(2, 0);
}

function getvisionlerprate(var_0) {
  var_1 = 1 / max(0.01, var_0);
  return clamp(var_1, 0, 30);
}

function lerpdeathsdoorpulsenorm(var_0) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("disconnect");
  var_1 = var_0;
  self.deathsdoorpulsenorm = 1;

  while(var_1 > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, var_0, var_1);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    var_1 -= 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

function shouldactivatedeathshield(var_0) {
  if(scripts\engine\utility::flag_exist("disable_death_shield") && scripts\engine\utility::flag("disable_death_shield")) {
    return false;
  }

  if(damageflag(1)) {
    return false;
  }

  if(damageflag(2)) {
    return false;
  }

  return true;
}

function damageflag(var_0) {
  return self.damage.flags &var_0;
}

function setdamageflag(var_0, var_1) {
  if(var_1) {
    self.damage.flags |= var_0;
    return;
  }

  self.damage.flags &= ~var_0;
}

function initplayerdamagefunctions() {
  initplayerentflags();
  initplayerdamage();
  self setclientomnvar("ui_gettocover_state", 0);
  self setclientomnvar("ui_gettocover_text", "game/get_to_cover");
}

function initplayerentflags() {
  scripts\engine\utility::ent_flag_init("global_hint_in_use");
  scripts\engine\utility::ent_flag_init("player_zero_attacker_accuracy");
}

function initplayerdamage() {
  self.damage = spawnStruct();
  self.damage.impactsfx = scripts\engine\utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
  initdeathsdooroverlaypulse();
  initbloodoverlay();
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

function damageui(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  GscBinSkip4(0x35, var_0, var_1, var_2, var_3, var_4);
}

function takecoverwarning(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();

  if(shouldshowcoverwarning(var_5)) {
    self setclientomnvar("ui_gettocover_state", 1);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 2);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 3);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 4);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 5);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 0);
    return;
  }
}

function shouldshowcoverwarning(var_0, var_1) {
  if(van_initdamage()) {
    return false;
  }

  if(self islinked()) {
    return false;
  }

  if(self.ignoreme) {
    return false;
  }

  if(isDefined(self.vehicle)) {
    return false;
  }

  if(!damageflag(1)) {
    return false;
  }

  if(damageflag(8)) {
    return false;
  }

  if(istrue(self.disabletakecoverwarning)) {
    return false;
  }

  return true;
}

function damageeffects(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1) || van_initdamage()) {
    return;
  }

  var_7 = [ &damagerumble, &damagebloodoverlay, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damageshock];
  var_8 = damageratio(var_0);

  foreach(var_10 in var_7) {
    self childthread[[var_10]](var_1.origin, var_8, var_4);
  }
}

function damageratio(var_0) {
  return scripts\engine\math::normalize_value(40, 160, var_0 / self.damagemultiplier);
}

function damagesfx(var_0, var_1, var_2) {
  self endon("damageDefault");

  if(!scripts\cp\cp_armor::player_have_armor(self)) {
    var_3 = "plr_proto_bullet_impact";
    var_4 = "plr_breath_pain_init";
  } else {
    var_3 = "plr_proto_bullet_impact_armor";
    var_4 = "plr_proto_yell_armor";
  }

  self.damage.impactsfx playSound(var_3);
  wait 0.25;

  if(!damageflag(4)) {
    var_5 = scripts\engine\math::factor_value(0.75, 1.75, var_3);
    self.damage.impactsfx playSound(var_4);
    setdamageflag(4, 1);
    scripts\engine\utility::delaythread(3, &setdamageflag, 4, 0);
    return;
  }
}

function damagerumble(var_0, var_1, var_2) {
  if(var_1 > 0.4) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }

  self playRumbleOnEntity("damage_light");
}

function damageradialdistortion(var_0, var_1, var_2) {
  self endon("stopPainOverlays");

  if(damageflag(32)) {
    return;
  }

  var_3 = scripts\engine\math::factor_value(0.045, 0.045, var_1);
  var_4 = scripts\engine\math::factor_value(0.09, 0.09, var_1);
  var_5 = scripts\engine\math::factor_value(0.2, 0.2, var_1);
  radial_distortion(var_3, var_4, var_5, var_0);
}

function radial_distortion(var_0, var_1, var_2, var_3, var_4) {
  self notify("radialDistortion");
  self endon("radialDistortion");
  self setclientdvar("MLTTMLTKOR", var_0);
  self setclientdvar("NKTRSSTMRQ", -1);
  self setclientdvar("LSOPQMRPNR", var_1);

  if(isDefined(var_3)) {
    self setclientdvar("NSSPMPLRQL", 1);
    self setclientdvar("MKRSSOQLML", var_3);
  }

  if(isDefined(var_4)) {
    if(isstring(var_4)) {
      self endon(var_4);
      thread removeradialdistortion_notify(var_4);
    } else if(isarray(var_4)) {
      foreach(var_6 in var_4) {
        self endon(var_6);
        thread removeradialdistortion_notify(var_6);
      }
    }
  }

  if(isDefined(var_2)) {
    removeradialdistortion(var_2);
    return;
  }
}

function lerp_saveddvar(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  self notify(var_0 + "_lerp_savedDvar");
  self endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    var_7 = var_4 / var_6;

    while(var_6) {
      var_3 += var_7;
      self setclientdvar(var_0, var_3);
      wait var_5;
      var_6--;
    }
  }

  self setclientdvar(var_0, var_1);
}

function removeradialdistortion(var_0) {
  GscBinSkip4(0x35, "MLTTMLTKOR", 0, var_0);
}

function removeradialdistortion_notify(var_0) {
  self waittill(var_0);
  self setclientdvar("MLTTMLTKOR", 0);
  self setclientdvar("NKTRSSTMRQ", 0);
  self setclientdvar("LSOPQMRPNR", 0);
  self setclientdvar("NSSPMPLRQL", 0);
}

function damagepainvision(var_0, var_1, var_2) {
  self endon("damageDefault");

  if(!shoulddopainvision()) {
    return 0;
  }

  if(!scripts\cp\cp_armor::has_armor(self)) {
    if(self isnightvisionon() || scripts\cp_mp\utility\game_utility::isnightmap()) {
      visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_nvg"), 0);
    } else {
      visionsetpain("pain_mp");
    }

    var_3 = scripts\engine\math::factor_value(0, 0, var_1);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_1);
  } else {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_armor"), 0);
    var_3 = scripts\engine\math::factor_value(0, 0, var_4);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_4);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_4);
  }

  self painvisionon();
  wait var_5;
  self painvisionoff();
}

function shoulddopainvision() {
  if(damageflag(2)) {
    return false;
  }

  if(self.health == 1) {
    return false;
  }

  return true;
}

function damagescreenshake(var_0, var_1, var_2) {
  var_3 = scripts\engine\math::factor_value(0.82, 1.2, var_1);
  var_4 = scripts\engine\math::factor_value(0.65, 0.8, var_1);
  var_5 = scripts\engine\math::factor_value(0.68, 1.25, var_1);
  var_6 = scripts\engine\math::factor_value(1.12, 1.85, var_1);
  var_7 = scripts\engine\math::factor_value(0.1, 0.32, var_1);
  var_8 = var_6 - var_7 - 0.05;

  if(isexplosivedamagemod(var_2)) {
    var_3 *= 5;
    var_4 *= 5;
    var_5 *= 5;
    return;
  }
}

function updatedamageoverlay(var_0, var_1, var_2) {
  self endon("damageDefault");
  self endon("stopPainOverlays");

  if(scripts\cp_mp\utility\player_utility::ref_12510()) {
    return;
  }

  if(!scripts\cp\cp_armor::has_armor(self)) {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var_3 = 0.8;
  } else {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var_3 = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, var_3);
  wait 0.05;
  var_4 = scripts\engine\math::factor_value(0.2, 0.2, var_2);
  self.damage.overlay fadeovertime(var_4);
  self.damage.overlay.alpha = 0;
}

function damagebloodoverlay(var_0, var_1, var_2) {
  damagebloodoverlayfullscreen(var_0, var_1, var_2);
}

function damagebloodoverlaydirectional(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var_3 = gettime();

  if(var_3 - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = var_3;
  }

  var_4 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH"];
  var_5 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  var_6 = getplayersidesfromposition(var_0);
  var_7 = "";

  if(scripts\engine\utility::array_contains(var_4, var_1)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var_5, var_1)) {
    var_8 = "fullscreen_dirt_";
  } else if(!scripts\cp\cp_armor::has_armor(self)) {
    var_8 = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      var_8 = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    var_8 = "fullscreen_armor_";
  }

  if(!isDefined(var_4)) {
    var_4 = 2;
  }

  foreach(var_13, var_3 in var_8) {
    var_10 = var_8 + var_13;
    var_11 = var_10 + "_splash";
    var_10 += var_8;
    var_12 = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffect(var_13, var_10, 0.15, var_4, var_12, 1);
    createscreeneffect(var_13, var_11, 0.15, 0.15, var_12, 0);
  }
}

function damagebloodoverlayfullscreen(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\player_utility::ref_12510()) {
    return;
  }

  if(damageflag(2)) {
    return;
  }

  if(istrue(self.isjuggernaut)) {
    return;
  }

  var_3 = scripts\engine\math::factor_value(0.6, 0.3, healthratio());
  var_4 = gethealthregendelay();
  var_5 = gethealthregentime();
  thread bloodoverlay(var_3, var_4, var_5);
}

function damageshock(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_2)) {
    var_3 = scripts\engine\math::factor_value(2, 3, var_1);
    self shellshock("explosion_nosound", var_3);
    return;
  }
}

function healthratio() {
  return self.health / self.maxhealth;
}

function createscreeneffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 3;
  var_6.foreground = 0;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = 0;
  var_6.enablehudlighting = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::factor_value(0.9, 1, var_4["scale"]);

  switch (var_0) {
    case "left":
      var_6.aligny = "top";
      var_6.alignx = "left";
      var_7 = -640;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(-55, 0, var_4["x"]);
      break;
    case "right":
      var_6.aligny = "top";
      var_6.alignx = "right";
      var_7 = 1280;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(0, 55, var_4["x"]) + 640;
      break;
    case "bottom":
      var_6.aligny = "bottom";
      var_6.alignx = "left";
      var_8 = 960;
      var_7 = scripts\engine\math::factor_value(-50, 50, var_4["x"]);
      var_10 = scripts\engine\math::factor_value(0, 50, var_4["y"]);
      var_10 += 480;
      var_9 = var_7;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1);
  thread screeneffectcleanup(var_6);
}

function animatescreeneffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("destroySreenEffectOverlay");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait var_1;
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait var_2 + 0.05;
  var_0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var_0) {
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_add(self.damage.activescreeneffectoverlays, var_0);
  var_0 waittill("destroySreenEffectOverlay");
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_remove(self.damage.activescreeneffectoverlays, var_0);
  var_0 destroy();
}

function createscreeneffectoffsets(var_0, var_1, var_2) {
  var_3 = [];
  GscBinSkip0(0x2e, "x", var_0);
}

function getplayersidesfromposition(var_0) {
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];

  if(abs(var_4) > 0.819152) {
    GscBinSkip0(0x2e, "bottom", 1);
  }

  if(var_5 > 0) {
    GscBinSkip0(0x2e, "right", 1);
  }

  GscBinSkip0(0x2e, "left", 1);
}

function oldhealthregen(var_0, var_1) {
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

  if(scripts\cp\utility::ishealthregendisabled()) {
    return;
  }

  var_2 = spawnStruct();
  scripts\cp\utility::getregendata(var_2);
  wait var_2.activatetime;
  var_3 = gettime();

  for(;;) {
    var_4 = scripts\cp\cp_laststand::gethealthcap();
    var_2 = spawnStruct();
    scripts\cp\utility::getregendata(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2.regenamount);

      if(var_5 > var_4) {
        var_5 = var_4;
      }

      self.health = var_5;
    } else {
      break;
    }

    scripts\engine\utility::ref_143b9(var_2.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level.playerinitinvulnerability)) {
    self[[level.playerinitinvulnerability]]();
  }

  scripts\cp\utility::resetattackerlist();
}

function core_health_regen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("faux_dead");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143af("damage", "health_perk_upgrade", "force_regeneration", "relic_resume_health_regen");

    if(var_0 == "force_regeneration") {
      regenerate_health();
      continue;
    }

    if(!scripts\cp\utility::canregenhealth()) {
      continue;
    }

    ref_12ace();
    regenerate_health();
  }
}

function ref_12ace() {
  self endon("force_regeneration");
  var_0 = gethealthregendelay();
  wait var_0;

  while(damageflag(2) || damageflag(32)) {
    waitframe();
  }
}

function regenerate_health() {
  var_0 = self.health;
  thread scripts\cp\utility::breathingmanager(gettime(), healthratio());

  while(self.health < self.maxhealth) {
    var_1 = gethealthregenpersecond();
    var_2 = var_1 * 0.05;
    var_0 = clamp(var_0 + var_2, 0, self.maxhealth);
    set_normalhealth(var_0 / self.maxhealth);
    waitframe();
  }

  self notify("healed");
}

function gethealthregenpersecond() {
  var_0 = 1;

  if(istrue(self.adrenalinepoweractive)) {
    var_0 *= 10;
  } else if(scripts\cp\utility::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > 2) {
      var_0 *= 2;
    }
  }

  return var_0 * self.gs.healthregenrate;
}

function getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

function getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

function gethealthregentime() {
  var_0 = self.maxhealth - self.health;
  var_1 = var_0 / gethealthregenpersecond();
  return var_1;
}

function gethealthregendelay() {
  return self.gs.healthregendelay;
}

function set_normalhealth(var_0) {
  self setnormalhealth(var_0);
  self.lasthealth = self.health;
}

function getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_3 = handleshotgundamage(var_1, var_2, var_3);
  var_3 = handleapdamage(var_1, var_2, var_3, var_0);
  var_11 = var_1.isalternatemode;
  var_12 = 0;

  if(istrue(var_11)) {
    var_13 = scripts\cp\utility::getweaponattachmentsbasenames(var_1);

    foreach(var_15 in var_13) {
      if(var_15 == "gl") {
        var_12 = 1;
        break;
      }
    }
  }

  var_17 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "cruise_proj_mp":
      case "nuke_mp":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        var_17 = 1;
        break;
      case "bradley_tow_proj_ks_mp":
      case "emp_drone_non_player_direct_mp":
      case "hover_jet_proj_mp":
      case "iw8_la_rpapa7_mp":
      case "fuelstrike_proj_mp":
      case "iw8_la_kgolf_mp":
      case "apache_proj_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
      case "bradley_tow_proj_mp":
      case "ac130_105mm_mp":
      case "at_mine_mp":
      case "emp_drone_non_player_mp":
        self.largeprojectiledamage = 1;
        var_17 = var_5;
        break;
      case "white_phosphorus_proj_mp":
      case "apc_rus_mp":
      case "toma_proj_mp":
      case "large_transport_mp":
      case "emp_grenade_mp":
      case "lighttank_tur_ks_mp":
      case "lighttank_mp":
      case "lighttank_tur_mp":
      case "hoopty_truck_mp":
      case "van_mp":
      case "cargo_truck_mg_mp":
      case "cargo_truck_mp":
      case "med_transport_mp":
      case "hoopty_mp":
      case "pickup_truck_mp":
      case "big_bird_mp":
      case "cop_car_mp":
      case "atv_mp":
      case "tac_rover_mp":
      case "little_bird_mg_mp":
      case "little_bird_mp":
      case "technical_mp":
      case "ac130_40mm_mp":
        self.largeprojectiledamage = 1;
        var_17 = var_6;
        break;
      case "artillery_mp":
      case "thermite_bolt_mp":
      case "at_mine_ap_mp":
      case "pac_sentry_turret_mp":
      case "thermite_av_mp":
      case "claymore_mp":
      case "c4_mp_p":
      case "frag_grenade_mp":
      case "semtex_mp":
      case "ac130_25mm_mp":
        self.largeprojectiledamage = 0;
        var_17 = var_7;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    var_17 = var_8;
  }

  if(isDefined(var_10)) {
    self.largeprojectiledamage = var_10;
  }

  if(isDefined(var_17) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_FIRE" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_MELEE")) {
    var_3 = ceil(var_4 / var_17);
  }

  var_18 = 0;

  if(isDefined(var_0) && isDefined(self.owner) && !var_18) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner && !istrue(self.killoneshot)) {
      var_3 = ceil(var_3 / 2);
    }
  }

  return int(var_3);
}