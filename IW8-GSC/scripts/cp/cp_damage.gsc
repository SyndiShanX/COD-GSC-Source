/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_damage.gsc
***********************************************/

function callback_playerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = createheadicon(var5);
  var15 = self;
  var16 = isDefined(var1);
  var17 = var16 && isPlayer(var1);

  if(!var17) {
    if(isDefined(var1)) {
      if(isDefined(var1.code_classname) && var1.code_classname == "misc_turret") {
        var0 = var1;
      }

      if(isDefined(var1.owner) && (isPlayer(var1.owner) || isagent(var1.owner))) {
        var1 = var1.owner;
        var17 = 1;
        var16 = 1;
      }
    }

    if(!var17) {
      if(isDefined(var0) && isDefined(var0.owner) && (isPlayer(var0.owner) || isagent(var0.owner))) {
        var1 = var0.owner;
        var17 = 1;
        var16 = 1;
      }
    }
  }

  if(!shouldtakedamage(var2, var1, var14, var3, var17)) {
    return;
  }

  if(damageflag(1)) {}

  if(var4 == "MOD_CRUSH" && isDefined(var0) && isDefined(var15 scripts\cp_mp\utility\player_utility::getvehicle()) && var15 scripts\cp_mp\utility\player_utility::getvehicle() == var0) {
    return;
  }

  if(var4 == "MOD_CRUSH" && isDefined(var0) && istrue(var0.little_bird_mg_enterend)) {
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::ref_14201(var0, var15, var4, var5)) {
    return;
  }

  if(istrue(var15.inlaststand)) {
    return;
  }

  if(var4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var14])) {
      level thread[[level.overcook_func[var14]]](var15, var14);
    }

    if(scripts\cp\cp_relics::try_start_fake_infil_chopper("relic_amped") && istrue(var15.ref_12a7e)) {
      var2 = var13;
    }
  }

  var3 |= 4;
  var18 = isDefined(var4) && (var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE_SPLASH");
  var19 = isDefined(var4) && var4 == "MOD_EXPLOSIVE_BULLET";
  var20 = isfriendlyfire(self, var1);
  var21 = self.perk_data["friendly_explosive_damage_reduction"] != 1;
  var22 = var16 && var1 == self;
  var23 = (var22 || !var16) && var4 == "MOD_SUICIDE";

  if(var16) {
    if(var1 == self) {
      if(var18) {
        var2 *= self.perk_data["friendly_explosive_damage_reduction"];
      }
    } else if(var20) {
      var2 = 0;

      if(isPlayer(var15) && isPlayer(var1)) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var15, "check_fire_ally");
      }
    }

    if(var4 == "MOD_EXPLOSIVE") {
      if(var14 == "at_mine_ap_mp") {
        var2 = self.maxhealth * 0.9;
      }

      var2 *= scripts\cp\perks\cp_perks::get_perk("enemy_explosive_damage_reduction");

      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var15)) {}

        var2 += var2 * level.explosivedamagemod;
      }
    } else if(var4 == "MOD_GRENADE_SPLASH") {
      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var15)) {}

        var2 += var2 * level.explosivedamagemod;
      }
    }
  }

  if(var4 == "MOD_FALLING" && !scripts\cp\utility::turn_off_sniper_laser()) {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var2 = 0;
    } else {
      if(getdvarint("scr_old_cp_fall_damage", 0) <= 0) {
        var2 = self.maxhealth + self.armor;
      }

      physicsexplosionsphere(self.origin, 64, 64, 1);
    }
  }

  var24 = 0;

  if(var22 && !var23) {
    var2 = int(var2 * var15 scripts\cp\utility::getdamagemodifiertotal());
  }

  if(scripts\cp\cp_weapon::isflashgrenadedamage(var5, var4)) {
    var25 = scripts\cp\cp_weapon::applyflashfromdamage(var15, var1, var6, 0);

    if(!var25) {
      return;
    }
  }

  var26 = self getcurrentprimaryweapon();

  if(var26.type == "melee") {
    var2 = int(var2 * self.perk_data["carrying_melee_damage_scalar"]);
  }

  if(var26.basename == "iw8_me_riotshield_mp") {
    if(!shouldskipdeathshield(var0, var1, var4)) {
      if(isDefined(var8) && var8 == "shield") {
        if(isDefined(self.riot_shield_damage)) {
          self.riot_shield_damage -= var2;
        }
      }
    }
  }

  if(self issprinting()) {
    var2 = int(var2 * self.perk_data["sprint_damage_scalar"]);
  }

  if(self.isreviving == 1) {
    var2 = int(var2 * self.perk_data["revive_damage_scalar"]);
  }

  if(isDefined(self.super_invulnerable)) {
    if(var17) {
      self shellshock("invul_hit", 0.25);
    }

    var2 = 0;
  }

  if(isDefined(self.vehicle_riding_on)) {
    self.vehicle_riding_on dodamage(var2, self.vehicle_riding_on.origin);
    var2 = int(clamp(var2, 0, self.health - 1));
  }

  var2 = modifydamagegeneral(var0, var1, var15, var2, var3, var4, var5, var6, var7, var8, var9);

  if(var2 <= 0) {
    return;
  }

  if(isPlayer(self) && isDefined(self.jugg_health)) {
    self.jugg_health -= var2;

    if(self.jugg_health <= 0) {
      if(var4 != "MOD_FALLING") {
        var2 = 0;
      }

      self notify("juggernaut_end_damage");
    }
  }

  if(var16 && var2 > 0) {
    if(!damageflag(1)) {
      if(getdvarint("scr_dmg_frame_skip", 20) != 20) {
        var27 = getdvarint("scr_dmg_frame_skip") * level.framedurationseconds * 1000;
      } else {
        var27 = level.framedurationseconds * 1000 * 20;
      }

      self.damageshieldexpiretime = gettime() + var27;
    }

    if(isai(var2) || isPlayer(var2) && var2 != self) {
      scripts\cp\cp_agent_damage::addattacker(self, var2, var1, var6, var3, var7, var8, var9, var10, var5);

      if(!isDefined(var2.damagedplayers)) {
        var2.damagedplayers = [];
      }

      var28 = gettime();
      var2.damagedplayers[var16.guid] = var28;
    }
  }

  if(isPlayer(var2) && isDefined(var2.pers["participation"])) {
    var2.pers["participation"]++;
  } else if(isPlayer(var2)) {
    var2.pers["participation"] = 1;
  }

  if(isPlayer(self) && isDefined(self.pers["participation"])) {
    self.pers["participation"]++;
  } else if(isPlayer(self)) {
    self.pers["participation"] = 1;
  }

  scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(self, 1);
  var29 = 0;

  if(isDefined(var2) && isai(var2)) {
    if(istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting())) {
      var3 = 1;
    }
  }

  if(!var21) {
    if(scripts\cp\cp_armor::has_armor(self) && scripts\cp\cp_armor::armor_resistance_to_type(var5, var6, var1, var2)) {
      if(isDefined(var9) && var9 != "shield") {
        var3 = scripts\cp\cp_armor::damage_armored_player(self, var1, var2, var3, var4, var5, var15, var7, var8, var9, var10, var26, var11, var12);
        var29 = 1;
      }
    }

    if(isDefined(level.updateondamagerelicsfunc)) {
      level thread[[level.updateondamagerelicsfunc]](var2, var15, self);
    }

    if(var3 >= self.health && !shouldskipdeathshield(var1, var2, var5)) {
      if(shouldactivatedeathshield(var3)) {
        var3 = self.health - 1;
        GscBinSkip4(0x35, var3, var2, var8, var7, undefined, undefined, var1);
      }

      GscBinSkip4(0x35, var3, var2, var8, var7, undefined, undefined, var1);
    }

    if(var5 == "MOD_CRUSH" && var3 >= self.health) {
      self.shouldskiplaststand = 1;
    }

    var3 = int(var3);

    if(var18 && !isPlayer(self) && !var23) {
      var2 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }

    if(istrue(self.shouldskipdeathsshield)) {
      self.shouldskipdeathsshield = undefined;
    }

    if(istrue(self.oob)) {
      self.shouldskiplaststand = 1;
      var3 = self.health + 100;
    }

    finishplayerdamagewrapper(var1, var2, var3, var4, var5, var15, var7, var8, var9, var10, var26, var11, var12, var29);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var3);

  if(var3 != 0) {
    thread scripts\cp\cp_hud_util::ref_12480();
  }

  if(var17) {
    if(isagent(var2)) {
      if(!isDefined(var2.damage_done)) {
        var2.damage_done = 0;
      } else {
        var2.damage_done += var3;
      }

      self.recent_attacker = var2;

      if(isDefined(level.current_challenge)) {
        if(isDefined(level.custom_playerdamage_challenge_func)) {
          self[[level.custom_playerdamage_challenge_func]](var1, var2, var3, var4, var5, var15, var7, var8, var9);
        }
      }
    }
  }

  if(scripts\engine\utility::isbulletdamage(var5)) {
    var16 thread scripts\cp\cp_player_battlechatter::adddamagetaken(var2, var6, var3);
  }

  if(isagent(var2) && isDefined(var2) && var2 scripts\cp_mp\utility\player_utility::_isalive() && var2 != var16) {
    var16 thread scripts\cp\cp_player_battlechatter::addrecentattacker(var2);
  }

  if(isDefined(var16) && var16 scripts\cp_mp\utility\player_utility::_isalive() && var16.health < 30) {
    var16 thread scripts\cp\cp_player_battlechatter::hurtbadlywait();
  }

  if(isDefined(var16) && var16 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var2) && var2 != var16 && weaponclass(var6) == "rocketlauncher") {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var16, "survive_rpg", undefined, 1);
  }

  if(isDefined(var16) && var16.health <= 1) {
    var16 scripts\cp\cp_player_battlechatter::onplayerkilled(var1, var2, var3, var5, var6);
    return;
  }
}

function van_initdamage() {
  if(scripts\cp\utility\player::isusingremote()) {
    return true;
  }

  return false;
}

function shouldskipdeathshield(var0, var1, var2) {
  if(isDefined(var1) && var1 == self) {
    return true;
  }

  if(istrue(self.shouldskipdeathsshield)) {
    return true;
  }

  if(getdvarint("scr_dfa_force_skip_ds", 0) != 0) {
    if(isDefined(var0)) {
      if(isDefined(var0.weapon_name)) {
        switch (var0.weapon_name) {
          case "ac130_105mm_mp":
          case "ac130_40mm_mp":
          case "ac130_25mm_mp":
            return true;
        }
      }
    }
  }

  if(isDefined(var0) && triggersafearea(var0)) {
    if(var2 == "MOD_CRUSH") {
      return true;
    }
  }

  switch (var2) {
    case "MOD_SUICIDE":
    case "MOD_FALLING":
    case "MOD_TRIGGER_HURT":
    case "MOD_EXECUTION":
      return true;
  }

  return false;
}

function triggersafearea(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    if(level.cratedata.crates.size > 0) {
      if(scripts\engine\utility::array_contains(level.cratedata.crates, var0)) {
        return true;
      }
    }
  }

  return false;
}

function weapon_is_a_vehicle_weapon(var0) {
  switch (var0.basename) {
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

function isenemyinfrontofme(var0, var1) {
  var2 = vectorNormalize((var0.origin - self.origin) * (1, 1, 0));
  var3 = anglesToForward(self.angles);
  var4 = vectordot(var2, var3);

  if(!isDefined(var1)) {
    return (var4 > 0);
  }

  return var4 > var1;
}

function isoneshotdamage(var0, var1) {
  if(var1 == "MOD_TRIGGER_HURT" || var1 == "MOD_UNKNOWN" || var1 == "MOD_SUICIDE") {
    return false;
  }

  if(var0 >= self.health) {
    return true;
  }

  return false;
}

function delayed_stun_damage(var0) {
  self endon("death");
  var0 endon("death");
  wait 0.05;
  self dodamage(2, self.origin, var0, undefined, "MOD_MELEE");
}

function stopusingremote() {
  self notify("stop_using_remote");
}

function useinvulnerability(var0) {
  self.health = var0 + 1;
  self.haveinvulnerabilityavailable = 0;
}

function shouldtakedamage(var0, var1, var2, var3, var4) {
  if(isDefined(var3) && (var3 == 256 || var3 == 258)) {
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

  if(isDefined(var2) && var2 == "iw8_la_rpapa7_mp_friendly") {
    return false;
  }

  if(isDefined(var2) && var2 == "overwatch_missile_cp") {
    return false;
  }

  if(isDefined(var2) && var2 == "tur_gun_decho_cp") {
    return false;
  }

  if(istrue(self.inchopper)) {
    return false;
  }

  return true;
}

function check_for_explosive_shotgun_damage(var0, var1, var2, var3, var4) {
  var5 = 500;

  if(!isDefined(var0) || !var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return var1;
  }

  if(!isDefined(var2) || !isPlayer(var2) || var4 != "MOD_EXPLOSIVE_BULLET") {
    return var1;
  }

  if(var3.classname == "weapon_shotgun") {
    var6 = distance(var2.origin, var0.origin);
    var7 = max(1, var6 / var5);
    var8 = var1 * 8;
    var9 = var8 * var7;

    if(var6 > var5) {
      return var1;
    }

    return int(var9);
  }

  return var5;
}

function kill_trigger_event_was_processed() {
  return istrue(self.kill_trigger_event_processed);
}

function set_kill_trigger_event_processed(var0, var1) {
  self.kill_trigger_event_processed = var1;
}

function scale_alien_damage_by_weapon_type(var0, var1, var2, var3, var4) {
  if(isDefined(var4) && var4 != "none") {
    var1 = check_for_explosive_shotgun_damage(self, var1, var0, var3, var2);
  }

  if(isDefined(var2) && var2 == "MOD_EXPLOSIVE_BULLET" && var4 != "none") {
    if(var3.classname == "weapon_shotgun") {
      var1 += int(var1 * level.shotgundamagemod);
    } else {
      var1 += int(var1 * level.exploimpactmod);
    }
  }

  return var1;
}

function scale_alien_damage_by_perks(var0, var1, var2, var3) {}

function scale_alien_damage_by_prestige(var0, var1) {
  if(isPlayer(var0)) {
    var2 = var0 scripts\cp\perks\cp_prestige::prestige_getweapondamagescalar();
    var1 *= var2;
    var1 = int(var1);
  }

  return var1;
}

function should_play_melee_blood_vfx(var0) {
  if(isDefined(level.should_play_melee_blood_vfx_func)) {
    return [[level.should_play_melee_blood_vfx_func]](var0);
  }

  return 1;
}

function check_for_special_damage(var0, var1, var2) {}

function catch_alien_on_fire(var0, var1, var2, var3) {
  self endon("death");
  alien_fire_on();
  damage_alien_over_time(var0, var1, var2, var3);
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

function damage_alien_over_time(var0, var1, var2, var3) {
  var4 = 150;
  var5 = 100;
  var6 = 75;
  var7 = 133;
  var8 = 500;
  var9 = 100;
  var10 = 3;
  var11 = 4;
  var12 = 3;
  var13 = 4;
  var14 = 4;
  var15 = 2;
  var16 = 1.2;
  self endon("death");

  if(!isDefined(var1) && !isDefined(var2)) {
    var17 = scripts\cp\cp_agent_utils::get_agent_type(self);

    switch (var17) {
      case "goon4":
      case "goon3":
      case "goon2":
      case "goon":
        var2 = var6;
        var1 = var12;
      case "brute4":
      case "brute3":
      case "brute2":
      case "brute":
        var2 = var5;
        var1 = var11;
      case "spitter":
        var2 = var7;
        var1 = var13;
      case "elite_boss":
      case "elite":
        var2 = var8;
        var1 = var14;
      case "minion":
        var2 = var9;
        var1 = var15;
      default:
        var2 = self.maxhealth * 0.5;
        var1 = var10;
        break;
    }
  } else {
    if(!isDefined(var2)) {
      var2 = var4;
    }

    if(!isDefined(var1)) {
      var1 = var10;
    }
  }

  if(isDefined(var0) && isDefined(var3) && var0 scripts\cp\utility::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(var3)) {
    var2 *= var16;
  }

  var2 *= level.alien_health_per_player_scalar[level.players.size];
  var18 = 0;
  var19 = 6;
  var20 = var1 / var19;
  var21 = var2 / var19;

  for(var22 = 0; var22 < var19; var22++) {
    wait var20;

    if(isalive(self)) {
      self dodamage(var21, self.origin, var0, var0, "MOD_UNKNOWN");
    }
  }
}

function friendlyfirecheck(var0, var1, var2) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  var3 = var1.team;
  var4 = level.friendlyfire;

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(var4 != 0) {
    return true;
  }

  if(var1 == var0) {
    return false;
  }

  if(!isDefined(var3)) {
    return true;
  }

  if(var3 != var0.team) {
    return true;
  }

  return false;
}

function update_damage_score(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && isDefined(var1.owner)) {
    scripts\cp\cp_agent_utils::store_attacker_info(var1.owner, var2 * 0.75);
  } else if(isDefined(var1) && isDefined(var1.pet) && var1.pet == 1) {
    scripts\cp\cp_agent_utils::store_attacker_info(var1.owner, var2);
  } else {
    scripts\cp\cp_agent_utils::store_attacker_info(var1, var2);
  }

  if(isDefined(var1) && isDefined(var5)) {
    thread update_zombie_damage_challenge(level, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }

  update_alien_damage_performance(var1, var2, var4);
}

function update_zombie_damage_challenge(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(istrue(self.died_poorly)) {
    return;
  }

  if(!isDefined(level.current_challenge)) {
    return;
  }

  if(isDefined(var1) && isPlayer(var1)) {
    var11 = self[[level.custom_damage_challenge_func]](var0, var1, var2, var4, var5, var7, var8, var9, var10);

    if(!istrue(var11)) {
      return;
    }

    return;
  }
}

function update_alien_damage_performance(var0, var1, var2) {
  if(isDefined(level.update_alien_damage_performance)) {
    [[level.update_alien_damage_performance]](var0, var1, var2);
    return;
  }

  update_performance_zombie_damage(var0, var1, var2);
}

function update_performance_zombie_damage(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
    return;
  }

  if(var2 == "MOD_TRIGGER_HURT") {
    return;
  }

  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "damage_done_on_alien", var1);

  if(isPlayer(var0)) {
    var0 scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var1);
    return;
  }

  if(isDefined(var0.owner)) {
    var0.owner scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var1);
    return;
  }
}

function modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflag;

  if(isDefined(var5) && var5 && level.idflags_ricochet) {
    var6 = 0.6 * var4;
  } else {
    var6 = var5;
  }

  var6 = handleempdamage(var3, var4, var6);
  var6 = handlemissiledamage(var3, var4, var6);
  var6 = handlegrenadedamage(var3, var4, var6);
  return var6;
}

function handlemissiledamage(var0, var1, var2) {
  var3 = var2;

  switch (var0.basename) {
    case "bomb_site_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
      self.largeprojectiledamage = 1;
      var3 = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var3 *= 2;
      break;
  }

  return var3;
}

function handlegrenadedamage(var0, var1, var2) {
  if(isexplosivedamagemod(var1)) {
    switch (var0.basename) {
      case "c4_mp_p":
        var2 *= 3;
        break;
      case "bouncing_betty_mp":
      case "frag_grenade_mp":
      case "semtex_mp":
        var2 *= 4;
        break;
      default:
        if(var0.isalternate) {
          var2 *= 3;
        }

        break;
    }
  }

  return var2;
}

function handlemeleedamage(var0, var1, var2) {
  if(var1 == "MOD_MELEE") {
    return (self.maxhealth + 1);
  }

  return var2;
}

function handleempdamage(var0, var1, var2) {
  return var2;
}

function handleapdamage(var0, var1, var2, var3) {
  var4 = 1;
  var5 = 1;

  if(isDefined(var3) && isDefined(var3.class) && var3.class == "engineer" && isDefined(var1) && scripts\engine\utility::isbulletdamage(var1)) {
    var4 += var5;
  } else {
    var6 = level.armorpiercingmod - 1;

    if(scripts\cp\utility::isfmjdamage(var0, var1, var3)) {
      var4 += var6;
    }

    if(isDefined(level.armorpiercingmodks)) {
      var7 = level.armorpiercingmodks - 1;

      if(isDefined(var3) && var3 scripts\cp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\cp\cp_weapon::isprimaryweapon(var0) && scripts\engine\utility::isbulletdamage(var1)) {
        var4 += var7;
      }
    }
  }

  return var2 * var4;
}

function handleshotgundamage(var0, var1, var2) {
  if(!isDefined(var0)) {
    return var2;
  }

  if(var0.basename == "none") {
    return var2;
  }

  if(weaponclass(var0) != "spread") {
    return var2;
  }

  return int(min(150, var2));
}

function armormitigation(var0, var1, var2) {
  return true;
}

function isfriendlyfire(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
    if(level.givematchplacementchallenge == var1) {
      return false;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var1)) {
      return false;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var1)) {
      return false;
    }
  }

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var1) && !isDefined(var1.team)) {
    return false;
  }

  if(var0.team != var1.team) {
    return false;
  }

  if(var0 == var1) {
    return false;
  }

  return true;
}

function finishplayerdamagewrapper(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(!callback_killingblow(var0, var1, var2 - var2 * var10, var3, var4, var5, var6, var7, var8, var9)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isPlayer(self)) {
    if(var2 >= self.health) {
      if(van_initdamage()) {
        if(!isDefined(var7)) {
          var7 = (0, 0, 0);
        }

        if(!isDefined(var1)) {
          var1 = self;
        }

        if(!isDefined(var0)) {
          var0 = var1;
        }

        scripts\cp\utility::allow_player_ignore_me(1);
        var14 = self playerforcedeathanim(var0, var4, var5, var8, var7);
        self.fauxdead = 1;
        self.shouldskiplaststand = 1;
        self notify("faux_dead");

        if(!isDefined(self.nocorpse)) {
          self.body = self cloneplayer(var14, var1);
        }

        if(!isDefined(self.nocorpse) && isDefined(self.body)) {
          self.body.targetname = "player_corpse";
          self playerhide();
          self setsolid(0);
          thread _startragdoll(self.body, var4, var0);
        }

        if(van_initdamage()) {
          thread ref_127e1();
          self waittill("stopped_using_remote");
          var2 = self.health + 100000;

          if(var8 == "shield") {
            var8 = "torso_upper";
          }
        }

        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
        self setsolid(1);
        scripts\cp\utility::allow_player_ignore_me(0);
      } else if(isDefined(level.interiordoor) && isbuiltinfunction(level.interiordoor)) {
        self.health = 1;
        var2 = 0;
        self[[level.interiordoor]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
        var2 = self.health + 100000;

        if(var8 == "shield") {
          var8 = "torso_upper";
        }

        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      } else if(istrue(self.isjuggernaut)) {
        self waittill("juggernaut_end");
        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      } else if(isDefined(self.vehicle)) {
        scripts\engine\utility::ref_143ba(2, "exited_vehicle", "vehicle_exit");
        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
        self disableusability();
      } else {
        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      }
    } else {
      self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    }
  }

  damageshellshockandrumble(var0, var5, var4, var2, var3, var1);
}

function _startragdoll(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  var0 endon("death");
  var3 = var0 getcorpseanim();
  var4 = undefined;
  var5 = getanimlength(var3);
  var6 = undefined;
  var7 = animhasnotetrack(var3, "delete_corpse");
  var8 = animhasnotetrack(var3, "delete_corpse_delayed");
  var9 = animhasnotetrack(var3, "no_ragdoll");
  var10 = animhasnotetrack(var3, "start_ragdoll");
  var4 = 0;

  if(var10) {
    var11 = getnotetracktimes(var3, "start_ragdoll")[0];
    var4 = var11 * var5;
  }

  wait var4;

  if(!isDefined(var0)) {
    return;
  }

  if(!var0 isragdoll()) {
    var0 startragdoll();
  }

  if(var7 || var8) {
    var12 = var5;

    if(var8) {
      var5 += 3;
    }

    if(isDefined(var4)) {
      var12 -= var4;
    }

    wait var12;
    var0 delete();
    return;
  }

  var0 setplayercorpsedone();
}

function callback_killingblow(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var2 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
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

function damageshellshockandrumble(var0, var1, var2, var3, var4, var5) {
  thread onweapondamage(var0, var1, var2, var3, var5);

  if(!isai(self)) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }
}

function onweapondamage(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("disconnect");

  switch (var1) {
    default:
      if(allowshellshockondamage(var1) && !isai(var4)) {
        scripts\cp\cp_weapon::shellshockondamage(var2, var3);
      }

      break;
  }
}

function allowshellshockondamage(var0) {
  if(isDefined(var0)) {
    switch (var0) {
      case "iw7_zapper_grey":
      case "chopper_boss_minigun_cp":
        return false;
    }
  }

  return true;
}

function istacticaldamage(var0, var1) {
  if(!isDefined(var0)) {
    return 0;
  }

  if(!isDefined(var1) || var1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var0.basename) {
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

function damage_should_ignore_blast_shield(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var0, var1, undefined, var2, var3, var4);

  if(var3 == "MOD_GRENADE") {
    return true;
  }

  if(var3 == "MOD_PROJECTILE") {
    return true;
  }

  if(isDefined(var0) && var0 == var1) {
    return true;
  }

  if(var1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var6)) {
    return true;
  }

  if(weaponignoresblastshield(var2, var5)) {
    return true;
  }

  return false;
}

function weaponignoresblastshield(var0, var1) {
  var2 = var0.basename;

  if(scripts\cp\utility::issuperweapon(var2)) {
    return 1;
  }

  switch (var2) {
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

function modifydamagegeneral(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(var5 == "MOD_EXPLOSIVE_BULLET" && var3 != 1) {
    var3 *= getdvarfloat("scr_explBulletMod");
    var3 = int(var3);
  }

  if(isDefined(level.modifyplayerdamage_relics) && isarray(level.modifyplayerdamage_relics)) {
    foreach(var12 in level.modifyplayerdamage_relics) {
      var3 = [[var12]](var2, var1, var3, var5, var6, var7, var8, var9);
    }
  }

  if(isDefined(level.modifyplayerdamage)) {
    var3 = [[level.modifyplayerdamage]](var2, var1, var3, var5, var6, var7, var8, var9);
  }

  if(!isDefined(var2.donotmodifydamage)) {
    var3 = int(var3 * var2 scripts\cp\utility::getdamagemodifiertotal(var0, var1, var2, var3, var5, var6, var9));
  }

  if(scripts\cp\utility::tryingtoleave()) {
    return var3;
  }

  if(isPlayer(self)) {
    if(isDefined(var1) && isagent(var1) && !isexplosivedamagemod(var5) && !isenemyinfrontofme(var1) && !istrue(var5 == "MOD_MELEE")) {
      var3 *= 0.5;
    }
  }

  return var3;
}

function damageinvulnerability(var0, var1, var2, var3, var4, var5, var6) {
  var7 = getinvultime();
  enabledamageinvulnerability();
  wait var7;
  disabledamageinvulnerability();
}

function shoulddodamageinvulnerabilty(var0) {
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

function deathshieldinvulnerability(var0, var1, var2, var3, var4, var5, var6) {
  var7 = getdeathsshieldduration();
  var8 = getdeathsdoorduration();

  if(!scripts\cp\utility::tryingtoleave()) {
    var7 = getdvarint("scr_dd_time", 1);
  }

  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  var9 = level.framedurationseconds * 1000 * 40;

  if(istrue(level.ref_12bac)) {
    var9 = level.framedurationseconds * 1000 * 10;
  }

  self.damageshieldexpiretime = gettime() + var9;

  if(!istrue(self.adrenalinepoweractive)) {
    ref_1433e(var7, "force_regeneration");
  }

  setdamageflag(1, 0);
  disabledamageinvulnerability();

  if(!istrue(self.adrenalinepoweractive)) {
    ref_1433e(var8, "force_regeneration");
  }

  disabledeathsdoor();
}

function ref_1433e(var0, var1) {
  self endon(var1);
  wait var0;
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
    var0 = 0.5;
    var1 = 2 + getdeathsdoorduration() + gethealthregentime() - var0;
    thread deathsdooroverlaypulse(var1);
    var2 = 0.5;
    var3 = var1 - var2;
    thread bloodoverlay(1, var3, var2);
    updatedeathsdoorvisionset();
    self painvisionon();
    return;
  }
}

function deathsdooroverlaypulse(var0) {
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("disconnect");
  var1 = 1;
  thread lerpdeathsdoorpulsenorm(var0);

  while(var1 > 0) {
    var2 = gettime();
    var3 = var2;
    var4 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(var2 < var3 + var4) {
      var2 = gettime();
      var5 = 0.1;
      var6 = 0.4;
      var7 = (var2 - var3) / var4;
      var8 = scripts\engine\math::normalized_cos_wave(var7);
      var1 = scripts\engine\math::factor_value(var5, var6, var8);
      var1 *= self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = var1;
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

function bloodoverlay(var0, var1, var2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  self endon("stopPainOverlays");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = var0;
  ref_1433e(var1, "force_regeneration");

  if(var2 <= 0) {
    var2 = 1;
  }

  self.damage.bloodoverlay fadeovertime(var2);
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

function disabledeathsdoor(var0) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!var0) {
    var1 = gethealthregentime();
  } else {
    var1 = 0;
  }

  var2 = getvisionlerprate(var1);
  setdamageflag(2, 0);
}

function getvisionlerprate(var0) {
  var1 = 1 / max(0.01, var0);
  return clamp(var1, 0, 30);
}

function lerpdeathsdoorpulsenorm(var0) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("disconnect");
  var1 = var0;
  self.deathsdoorpulsenorm = 1;

  while(var1 > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, var0, var1);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    var1 -= 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

function shouldactivatedeathshield(var0) {
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

function damageflag(var0) {
  return self.damage.flags &var0;
}

function setdamageflag(var0, var1) {
  if(var1) {
    self.damage.flags |= var0;
    return;
  }

  self.damage.flags &= ~var0;
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

function damageui(var0, var1, var2, var3, var4, var5, var6) {
  GscBinSkip4(0x35, var0, var1, var2, var3, var4);
}

function takecoverwarning(var0, var1, var2, var3, var4) {
  var5 = gettime();

  if(shouldshowcoverwarning(var5)) {
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

function shouldshowcoverwarning(var0, var1) {
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

function damageeffects(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var1) || van_initdamage()) {
    return;
  }

  var7 = [ &damagerumble, &damagebloodoverlay, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damageshock];
  var8 = damageratio(var0);

  foreach(var10 in var7) {
    self childthread[[var10]](var1.origin, var8, var4);
  }
}

function damageratio(var0) {
  return scripts\engine\math::normalize_value(40, 160, var0 / self.damagemultiplier);
}

function damagesfx(var0, var1, var2) {
  self endon("damageDefault");

  if(!scripts\cp\cp_armor::player_have_armor(self)) {
    var3 = "plr_proto_bullet_impact";
    var4 = "plr_breath_pain_init";
  } else {
    var3 = "plr_proto_bullet_impact_armor";
    var4 = "plr_proto_yell_armor";
  }

  self.damage.impactsfx playSound(var3);
  wait 0.25;

  if(!damageflag(4)) {
    var5 = scripts\engine\math::factor_value(0.75, 1.75, var3);
    self.damage.impactsfx playSound(var4);
    setdamageflag(4, 1);
    scripts\engine\utility::delaythread(3, &setdamageflag, 4, 0);
    return;
  }
}

function damagerumble(var0, var1, var2) {
  if(var1 > 0.4) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }

  self playRumbleOnEntity("damage_light");
}

function damageradialdistortion(var0, var1, var2) {
  self endon("stopPainOverlays");

  if(damageflag(32)) {
    return;
  }

  var3 = scripts\engine\math::factor_value(0.045, 0.045, var1);
  var4 = scripts\engine\math::factor_value(0.09, 0.09, var1);
  var5 = scripts\engine\math::factor_value(0.2, 0.2, var1);
  radial_distortion(var3, var4, var5, var0);
}

function radial_distortion(var0, var1, var2, var3, var4) {
  self notify("radialDistortion");
  self endon("radialDistortion");
  self setclientdvar("MLTTMLTKOR", var0);
  self setclientdvar("NKTRSSTMRQ", -1);
  self setclientdvar("LSOPQMRPNR", var1);

  if(isDefined(var3)) {
    self setclientdvar("NSSPMPLRQL", 1);
    self setclientdvar("MKRSSOQLML", var3);
  }

  if(isDefined(var4)) {
    if(isstring(var4)) {
      self endon(var4);
      thread removeradialdistortion_notify(var4);
    } else if(isarray(var4)) {
      foreach(var6 in var4) {
        self endon(var6);
        thread removeradialdistortion_notify(var6);
      }
    }
  }

  if(isDefined(var2)) {
    removeradialdistortion(var2);
    return;
  }
}

function lerp_saveddvar(var0, var1, var2) {
  var3 = getdvarfloat(var0);
  self notify(var0 + "_lerp_savedDvar");
  self endon(var0 + "_lerp_savedDvar");
  var4 = var1 - var3;
  var5 = 0.05;
  var6 = int(var2 / var5);

  if(var6 > 0) {
    var7 = var4 / var6;

    while(var6) {
      var3 += var7;
      self setclientdvar(var0, var3);
      wait var5;
      var6--;
    }
  }

  self setclientdvar(var0, var1);
}

function removeradialdistortion(var0) {
  GscBinSkip4(0x35, "MLTTMLTKOR", 0, var0);
}

function removeradialdistortion_notify(var0) {
  self waittill(var0);
  self setclientdvar("MLTTMLTKOR", 0);
  self setclientdvar("NKTRSSTMRQ", 0);
  self setclientdvar("LSOPQMRPNR", 0);
  self setclientdvar("NSSPMPLRQL", 0);
}

function damagepainvision(var0, var1, var2) {
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

    var3 = scripts\engine\math::factor_value(0, 0, var1);
    var4 = scripts\engine\math::factor_value(1.9, 1.9, var1);
    var5 = scripts\engine\math::factor_value(0.05, 0.05, var1);
  } else {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_armor"), 0);
    var3 = scripts\engine\math::factor_value(0, 0, var4);
    var4 = scripts\engine\math::factor_value(1.9, 1.9, var4);
    var5 = scripts\engine\math::factor_value(0.05, 0.05, var4);
  }

  self painvisionon();
  wait var5;
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

function damagescreenshake(var0, var1, var2) {
  var3 = scripts\engine\math::factor_value(0.82, 1.2, var1);
  var4 = scripts\engine\math::factor_value(0.65, 0.8, var1);
  var5 = scripts\engine\math::factor_value(0.68, 1.25, var1);
  var6 = scripts\engine\math::factor_value(1.12, 1.85, var1);
  var7 = scripts\engine\math::factor_value(0.1, 0.32, var1);
  var8 = var6 - var7 - 0.05;

  if(isexplosivedamagemod(var2)) {
    var3 *= 5;
    var4 *= 5;
    var5 *= 5;
    return;
  }
}

function updatedamageoverlay(var0, var1, var2) {
  self endon("damageDefault");
  self endon("stopPainOverlays");

  if(scripts\cp_mp\utility\player_utility::ref_12510()) {
    return;
  }

  if(!scripts\cp\cp_armor::has_armor(self)) {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var3 = 0.8;
  } else {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var3 = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, var3);
  wait 0.05;
  var4 = scripts\engine\math::factor_value(0.2, 0.2, var2);
  self.damage.overlay fadeovertime(var4);
  self.damage.overlay.alpha = 0;
}

function damagebloodoverlay(var0, var1, var2) {
  damagebloodoverlayfullscreen(var0, var1, var2);
}

function damagebloodoverlaydirectional(var0, var1, var2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var3 = gettime();

  if(var3 - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = var3;
  }

  var4 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH"];
  var5 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  var6 = getplayersidesfromposition(var0);
  var7 = "";

  if(scripts\engine\utility::array_contains(var4, var1)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var5, var1)) {
    var8 = "fullscreen_dirt_";
  } else if(!scripts\cp\cp_armor::has_armor(self)) {
    var8 = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      var8 = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    var8 = "fullscreen_armor_";
  }

  if(!isDefined(var4)) {
    var4 = 2;
  }

  foreach(var13, var3 in var8) {
    var10 = var8 + var13;
    var11 = var10 + "_splash";
    var10 += var8;
    var12 = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffect(var13, var10, 0.15, var4, var12, 1);
    createscreeneffect(var13, var11, 0.15, 0.15, var12, 0);
  }
}

function damagebloodoverlayfullscreen(var0, var1, var2) {
  if(scripts\cp_mp\utility\player_utility::ref_12510()) {
    return;
  }

  if(damageflag(2)) {
    return;
  }

  if(istrue(self.isjuggernaut)) {
    return;
  }

  var3 = scripts\engine\math::factor_value(0.6, 0.3, healthratio());
  var4 = gethealthregendelay();
  var5 = gethealthregentime();
  thread bloodoverlay(var3, var4, var5);
}

function damageshock(var0, var1, var2) {
  if(isexplosivedamagemod(var2)) {
    var3 = scripts\engine\math::factor_value(2, 3, var1);
    self shellshock("explosion_nosound", var3);
    return;
  }
}

function healthratio() {
  return self.health / self.maxhealth;
}

function createscreeneffect(var0, var1, var2, var3, var4, var5) {
  var6 = newclienthudelem(self);
  var6.sort = 3;
  var6.foreground = 0;
  var6.horzalign = "fullscreen";
  var6.vertalign = "fullscreen";
  var6.alpha = 0;
  var6.enablehudlighting = 1;
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = scripts\engine\math::factor_value(0.9, 1, var4["scale"]);

  switch (var0) {
    case "left":
      var6.aligny = "top";
      var6.alignx = "left";
      var7 = -640;
      var8 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var10 = var8;
      var9 = scripts\engine\math::factor_value(-55, 0, var4["x"]);
      break;
    case "right":
      var6.aligny = "top";
      var6.alignx = "right";
      var7 = 1280;
      var8 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var10 = var8;
      var9 = scripts\engine\math::factor_value(0, 55, var4["x"]) + 640;
      break;
    case "bottom":
      var6.aligny = "bottom";
      var6.alignx = "left";
      var8 = 960;
      var7 = scripts\engine\math::factor_value(-50, 50, var4["x"]);
      var10 = scripts\engine\math::factor_value(0, 50, var4["y"]);
      var10 += 480;
      var9 = var7;
      break;
  }

  var6.x = var7;
  var6.y = var8;
  var6 setshader(var1);
  thread screeneffectcleanup(var6);
}

function animatescreeneffect(var0, var1, var2, var3, var4, var5, var6) {
  var0 endon("destroySreenEffectOverlay");

  if(!var6) {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0 moveovertime(var1);
    var0.x = var3;
    var0.y = var4;
    var1 = 0.05;
    var0.alpha = 1;
    wait 0.05;
  } else {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0.x = var3;
    var0.y = var4;
    wait 0.15;
    var0 fadeovertime(var1);
    var0.alpha = 1;
    wait var1;
  }

  var0 fadeovertime(var2);
  var0.alpha = 0;
  wait var2 + 0.05;
  var0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var0) {
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_add(self.damage.activescreeneffectoverlays, var0);
  var0 waittill("destroySreenEffectOverlay");
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_remove(self.damage.activescreeneffectoverlays, var0);
  var0 destroy();
}

function createscreeneffectoffsets(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, "x", var0);
}

function getplayersidesfromposition(var0) {
  var1 = vectorNormalize(anglesToForward(self.angles));
  var2 = vectorNormalize(anglestoright(self.angles));
  var3 = vectorNormalize(var0 - self.origin);
  var4 = vectordot(var3, var1);
  var5 = vectordot(var3, var2);
  var6 = [];

  if(abs(var4) > 0.819152) {
    GscBinSkip0(0x2e, "bottom", 1);
  }

  if(var5 > 0) {
    GscBinSkip0(0x2e, "right", 1);
  }

  GscBinSkip0(0x2e, "left", 1);
}

function oldhealthregen(var0, var1) {
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

  var2 = spawnStruct();
  scripts\cp\utility::getregendata(var2);
  wait var2.activatetime;
  var3 = gettime();

  for(;;) {
    var4 = scripts\cp\cp_laststand::gethealthcap();
    var2 = spawnStruct();
    scripts\cp\utility::getregendata(var2);
    var1 = self.health / self.maxhealth;

    if(self.health < int(var4)) {
      var5 = int(self.health + var2.regenamount);

      if(var5 > var4) {
        var5 = var4;
      }

      self.health = var5;
    } else {
      break;
    }

    scripts\engine\utility::ref_143b9(var2.waittimebetweenregen, "force_regeneration");
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
    var0 = scripts\engine\utility::ref_143af("damage", "health_perk_upgrade", "force_regeneration", "relic_resume_health_regen");

    if(var0 == "force_regeneration") {
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
  var0 = gethealthregendelay();
  wait var0;

  while(damageflag(2) || damageflag(32)) {
    waitframe();
  }
}

function regenerate_health() {
  var0 = self.health;
  thread scripts\cp\utility::breathingmanager(gettime(), healthratio());

  while(self.health < self.maxhealth) {
    var1 = gethealthregenpersecond();
    var2 = var1 * 0.05;
    var0 = clamp(var0 + var2, 0, self.maxhealth);
    set_normalhealth(var0 / self.maxhealth);
    waitframe();
  }

  self notify("healed");
}

function gethealthregenpersecond() {
  var0 = 1;

  if(istrue(self.adrenalinepoweractive)) {
    var0 *= 10;
  } else if(scripts\cp\utility::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > 2) {
      var0 *= 2;
    }
  }

  return var0 * self.gs.healthregenrate;
}

function getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

function getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

function gethealthregentime() {
  var0 = self.maxhealth - self.health;
  var1 = var0 / gethealthregenpersecond();
  return var1;
}

function gethealthregendelay() {
  return self.gs.healthregendelay;
}

function set_normalhealth(var0) {
  self setnormalhealth(var0);
  self.lasthealth = self.health;
}

function getmodifiedantikillstreakdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var3 = handleshotgundamage(var1, var2, var3);
  var3 = handleapdamage(var1, var2, var3, var0);
  var11 = var1.isalternatemode;
  var12 = 0;

  if(istrue(var11)) {
    var13 = scripts\cp\utility::getweaponattachmentsbasenames(var1);

    foreach(var15 in var13) {
      if(var15 == "gl") {
        var12 = 1;
        break;
      }
    }
  }

  var17 = undefined;

  if(var2 != "MOD_MELEE") {
    switch (var1.basename) {
      case "cruise_proj_mp":
      case "nuke_mp":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        var17 = 1;
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
        var17 = var5;
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
        var17 = var6;
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
        var17 = var7;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    var17 = var8;
  }

  if(isDefined(var10)) {
    self.largeprojectiledamage = var10;
  }

  if(isDefined(var17) && isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_EXPLOSIVE_BULLET" || var2 == "MOD_FIRE" || var2 == "MOD_PROJECTILE" || var2 == "MOD_PROJECTILE_SPLASH" || var2 == "MOD_GRENADE" || var2 == "MOD_GRENADE_SPLASH" || var2 == "MOD_MELEE")) {
    var3 = ceil(var4 / var17);
  }

  var18 = 0;

  if(isDefined(var0) && isDefined(self.owner) && !var18) {
    if(isDefined(var0.owner)) {
      var0 = var0.owner;
    }

    if(var0 == self.owner && !istrue(self.killoneshot)) {
      var3 = ceil(var3 / 2);
    }
  }

  return int(var3);
}