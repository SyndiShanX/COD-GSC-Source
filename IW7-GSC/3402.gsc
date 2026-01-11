/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3402.gsc
***************************************/

callback_zombieplayerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self;

  if(!shouldtakedamage(var_02, var_01, var_05, var_03)) {
    return;
  }
  if(var_04 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_05])) {
      level thread[[level.overcook_func[var_05]]](var_12, var_05);
    }
  }

  var_13 = isDefined(var_04) && (var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE_SPLASH");
  var_14 = isDefined(var_04) && var_04 == "MOD_EXPLOSIVE_BULLET";
  var_15 = isfriendlyfire(self, var_01);
  var_16 = scripts\cp\utility::is_hardcore_mode();
  var_17 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_18 = isDefined(var_01);
  var_19 = var_18 && isDefined(var_1.species) && var_1.species == "zombie";
  var_20 = var_18 && isDefined(var_1.species) && var_1.species == "zombie_grey";
  var_21 = var_18 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_brute";
  var_22 = var_18 && var_01 == self;
  var_23 = (var_22 || !var_18) && var_04 == "MOD_SUICIDE";

  if(var_18) {
    if(var_01 == self) {
      if(issubstr(var_05, "iw7_harpoon2_zm") || issubstr(var_05, "iw7_harpoon1_zm") || issubstr(var_05, "iw7_acid_rain_projectile_zm")) {
        var_02 = 0;
      }

      if(var_13) {
        var_24 = self getstance();

        if(var_17) {
          var_02 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && (self issprintsliding() || (var_24 == "crouch" || var_24 == "prone") && self isonground())) {
          var_02 = 0;
        } else {
          var_02 = get_explosive_damage_on_player(var_00, var_01, var_02, var_03, var_04, var_05);
        }
      }

      switch (var_05) {
        case "zmb_fireworksprojectile_mp":
        case "zmb_imsprojectile_mp":
        case "iw7_armageddonmeteor_mp":
          var_02 = 0;
          break;
        case "iw7_stunbolt_zm":
        case "iw7_bluebolts_zm":
        case "blackhole_grenade_zm":
        case "blackhole_grenade_mp":
          var_02 = 25;
          break;
        default:
          break;
      }
    } else if(var_15) {
      if(var_16) {
        if(scripts\cp\utility::is_ricochet_damage()) {
          if(isplayer(var_01) && isDefined(var_08) && var_08 != "shield") {
            if(isDefined(var_00)) {
              var_01 getrandomarmkillstreak(var_02, var_1.origin - (0, 0, 50), var_01, var_00, var_04);
            } else {
              var_01 getrandomarmkillstreak(var_02, var_1.origin, var_01);
            }
          }

          var_02 = 0;
        }
      } else
        var_02 = 0;
    } else if(var_19) {
      if(var_04 != "MOD_EXPLOSIVE" && var_12 scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::is_true(var_1.is_burning)) {
          var_12 scripts\cp\utility::notify_used_consumable("burned_out");
          var_01 thread scripts\cp\utility::damage_over_time(var_01, var_12, 3, int(var_1.maxhealth + 1000), var_04, "incendiary_ammo_mp", undefined, "burning");
          var_1.faf_burned_out = 1;
        }
      }

      var_25 = gettime();

      if(!isDefined(self.last_zombie_hit_time) || var_25 - self.last_zombie_hit_time > 20) {
        self.last_zombie_hit_time = var_25;
      } else {
        return;
      }

      var_26 = 500;

      if(getdvarint("zom_damage_shield_duration") != 0) {
        var_26 = getdvarint("zom_damage_shield_duration");
      }

      if(isDefined(var_1.last_damage_time_on_player[self.vo_prefix])) {
        var_27 = var_1.last_damage_time_on_player[self.vo_prefix];

        if(var_27 + var_26 > gettime()) {
          var_02 = 0;
        } else {
          var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else
        var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
    } else if(var_20)
      var_02 = func_791A(var_00, var_01, var_02, var_03, var_04, var_05);

    if(var_14) {
      var_24 = self getstance();

      if(var_17) {
        var_02 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && (self issprintsliding() || (var_24 == "crouch" || var_24 == "prone") && self isonground())) {
        var_02 = 0;
      } else if(!var_16 || var_01 == self && var_08 == "none") {
        var_02 = 0;
      }
    }
  } else if(var_17 && var_04 == "MOD_SUICIDE") {
    if(var_05 == "frag_grenade_zm" || var_05 == "cluster_grenade_zm") {
      var_02 = 0;
    }
  } else {
    var_24 = self getstance();

    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && (self issprintsliding() || (var_24 == "crouch" || var_24 == "prone") && self isonground())) {
      if(var_05 == "frag_grenade_zm" || var_05 == "cluster_grenade_zm") {
        var_02 = 0;
      }
    }
  }

  if(var_04 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var_02 = 0;
    } else if(var_02 > 10) {
      if(var_02 > self.health * 0.15) {
        var_02 = int(self.health * 0.15);
      }
    } else
      var_02 = 0;
  }

  var_28 = 0.0;

  if(var_18 && var_01 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::is_true(self.linked_to_player)) {
    if(self.health - var_02 < 1) {
      var_02 = self.health - 1;
    }
  }

  if(var_19 || var_20 || var_21 || var_22 && !var_23) {
    var_02 = int(var_02 * var_12 scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    var_02 = int(max(self.maxhealth / 2.75, var_02));
  }

  if(var_12 scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_01)) {
    var_29 = !isDefined(var_1.agent_type) || var_19 || !var_20 || !var_21 || scripts\engine\utility::is_true(var_1.is_suicide_bomber) || !scripts\engine\utility::is_true(var_1.entered_playspace);
    var_30 = isDefined(var_1.agent_type) && (var_19 && (!var_20 || !var_21 || scripts\engine\utility::is_true(var_1.is_suicide_bomber) || !scripts\engine\utility::is_true(var_1.entered_playspace)));
    var_30 = 0;

    if(isDefined(var_1.agent_type) && (var_1.agent_type == "karatemaster" || var_20 || var_21 || scripts\engine\utility::is_true(var_1.is_suicide_bomber) || !scripts\engine\utility::is_true(var_1.entered_playspace))) {
      var_30 = 0;
    } else if(var_01 scripts\cp\utility::agentisfnfimmune()) {
      var_30 = 0;
    } else {
      var_30 = 1;
    }

    if(var_30) {
      var_01 thread scripts\cp\crafted_trap_revocator::turn_zombie(var_12);
      var_12 scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_02 = int(var_02);

  if(!var_15 || var_16) {
    finishplayerdamagewrapper(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_28, var_10, var_11);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_02);

  if(var_02 <= 0) {
    return;
  }
  thread scripts\cp\utility::player_pain_vo(var_01);
  thread play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();

  if(isDefined(var_01)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();

    if(isagent(var_01)) {
      if(!isDefined(var_1.damage_done)) {
        var_1.damage_done = 0;
      } else {
        var_1.damage_done = var_1.damage_done + var_02;
      }

      self.recent_attacker = var_01;

      if(isDefined(level.current_challenge)) {
        self[[level.custom_playerdamage_challenge_func]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
      }
    }
  }
}

play_pain_photo(var_00) {
  var_00 notify("play_pain_photo");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("play_pain_photo");

  if(scripts\cp\cp_laststand::player_in_laststand(var_00)) {
    return;
  }
  scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_00, "damaged");
  wait 4;
  scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_00, "healthy");
}

func_50F9(var_00) {
  self endon("death");
  var_00 endon("death");
  wait 0.05;
  self getrandomarmkillstreak(2, self.origin, var_00, undefined, "MOD_MELEE");
}

get_explosive_damage_on_player(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_05)) {
    return var_02;
  }

  var_06 = getweaponbasename(var_05);

  if(!isDefined(var_06)) {
    return var_02;
  }

  switch (var_06) {
    case "iw7_chargeshot_zm":
    case "throwingknifec4_mp":
    case "semtex_zm":
    case "frag_grenade_zm":
      var_07 = var_02 / 1200;
      var_02 = var_07 * 100;
      break;
    case "iw7_blackholegun_mp":
    case "c4_zm":
      var_07 = var_02 / 2000;
      var_02 = var_07 * 100;
      break;
    case "iw7_glprox_zm":
    case "cluster_grenade_zm":
      var_07 = var_02 / 800;
      var_02 = var_07 * 100;
      break;
    case "iw7_g18_zml":
    case "iw7_g18_zmr":
    case "iw7_g18_zm":
      if(scripts\cp\cp_weapon::get_weapon_level(var_06) <= 2) {
        var_07 = var_02 / 1800;
        var_02 = var_07 * 100;
        break;
      } else
        var_02 = 0;

      break;
    case "iw7_armageddonmeteor_mp":
      var_02 = 0;
      break;
    case "iw7_stunbolt_zm":
    case "iw7_bluebolts_zm":
      var_02 = var_02 * 0.33;
      var_02 = min(80, var_02);
      break;
    case "iw7_shredderdummy_zm":
    case "iw7_facemelterdummy_zm":
    case "iw7_dischorddummy_zm":
    case "iw7_headcutterdummy_zm":
    case "iw7_headcutter3_zm":
    case "iw7_headcutter2_zm":
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      var_02 = 0;
      break;
    case "iw7_headcuttershards_mp":
      var_02 = 0;
      break;
    case "splash_grenade_zm":
    case "splash_grenade_mp":
      var_02 = min(10, var_02);
      break;
    default:
      break;
  }

  return min(80, var_02);
}

func_791A(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_04)) {
    switch (var_04) {
      case "MOD_EXPLOSIVE":
        return var_02;
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        return min(80, var_02);
      case "MOD_UNKNOWN":
        return var_02;
      default:
        return var_02;
    }
  }

  return var_02;
}

func_100B8(var_00) {
  var_01 = 20;

  if(var_00 == 0) {
    return 0;
  } else {
    return self.haveinvulnerabilityavailable && var_00 > self.health && var_00 < self.health + var_01;
  }
}

usingremoteandwillbelowhealth(var_00) {
  var_01 = 0.2;
  var_02 = self.maxhealth * var_01;
  return scripts\cp\utility::isusingremote() && (var_00 > self.health || self.health - var_00 <= var_02);
}

stopusingremote() {
  self notify("stop_using_remote");
}

useinvulnerability(var_00) {
  self.health = var_00 + 1;
  self.haveinvulnerabilityavailable = 0;
}

shouldtakedamage(var_00, var_01, var_02, var_03) {
  if(isDefined(var_02) && (var_02 == "zmb_imsprojectile_mp" || var_02 == "zmb_fireworksprojectile_mp") || var_02 == "zmb_robotprojectile_mp") {
    return 0;
  }

  if(isDefined(var_02) && var_02 == "bolasprayprojhome_mp") {
    return 0;
  }

  if(isDefined(var_03) && (var_03 == 256 || var_03 == 258)) {
    return 0;
  }

  if(isDefined(self.inlaststand) && self.inlaststand) {
    return 0;
  }

  if(gettime() < self.damageshieldexpiretime) {
    return 0;
  }

  if(isDefined(self.ability_invulnerable)) {
    return 0;
  }

  if(isDefined(var_01) && isDefined(var_1.is_neil)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(self.is_off_grid)) {
    return 0;
  }

  if(isDefined(self.is_fast_traveling)) {
    return 0;
  }

  if(isDefined(self.linked_to_boat)) {
    return 0;
  }

  return 1;
}

func_F29B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(var_01)) {
    if(var_01 == "xm25_mp" && var_00 == "MOD_IMPACT") {
      var_02 = 95;
    }

    if(var_01 == "spider_beam_mp") {
      var_02 = var_02 * 15;
    }

    if(var_01 == "alienthrowingknife_mp" && var_00 == "MOD_IMPACT") {
      if(scripts\cp\cp_damage::can_hypno(var_03, 0, var_04, var_00, var_01, var_05, var_06, var_07, var_08, var_09)) {
        var_02 = 20000;
      } else if(scripts\cp\cp_agent_utils::get_agent_type(self) != "elite") {
        var_02 = 500;
      }
    }
  }

  return var_02;
}

update_damage_score(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(var_01) && isDefined(var_1.owner)) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_02 * 0.75);
  } else if(isDefined(var_01) && isDefined(var_1.pet) && var_1.pet == 1) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_02);
  } else {
    scripts\cp\cp_agent_utils::store_attacker_info(var_01, var_02);
  }

  if(isDefined(var_01) && isDefined(var_05)) {
    level thread update_zombie_damage_challenge(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, self);
  }

  update_zombie_damage_challenge(var_01, var_02, var_04);
}

update_zombie_damage_challenge(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(scripts\engine\utility::is_true(self.died_poorly)) {
    return;
  }
  if(!isDefined(level.current_challenge)) {
    return;
  }
  if(isDefined(var_01) && isplayer(var_01)) {
    var_11 = self[[level.func_4C44]](var_00, var_01, var_02, var_04, var_05, var_07, var_08, var_09, var_10);

    if(!scripts\engine\utility::is_true(var_11)) {
      return;
    }
  }
}

update_zombie_damage_challenge(var_00, var_01, var_02) {
  if(isDefined(level.update_zombie_damage_challenge)) {
    [[level.update_zombie_damage_challenge]](var_00, var_01, var_02);
  } else {
    update_performance_zombie_damage(var_00, var_01, var_02);
  }
}

update_performance_zombie_damage(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }
  if(var_02 == "MOD_TRIGGER_HURT") {
    return;
  }
  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "damage_done_on_alien", var_01);

  if(isplayer(var_00)) {
    var_00 scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_01);
  } else if(isDefined(var_0.owner)) {
    var_0.owner scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_01);
  }
}

func_2189(var_00, var_01, var_02) {
  return 1.0;
}

stun_zap(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(self.stun_struct)) {
    return 0;
  }

  var_07 = gettime();

  if(isDefined(self.func_A918) && !isDefined(var_05)) {
    if(var_07 < self.func_A918) {
      return;
    }
  }

  self.func_A918 = var_07 + 500;
  var_08 = 0;
  var_09 = 0;
  var_10 = 4;

  if(!isDefined(var_04)) {
    var_04 = 256;
  }

  var_11 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_12 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_11, undefined, var_10, var_04, 1);

  if(scripts\engine\utility::array_contains(var_12, var_01)) {
    var_12 = scripts\engine\utility::array_remove(var_12, var_01);
  }

  if(var_12.size >= 1) {
    if(!isDefined(self.stun_struct)) {
      self.stun_struct = spawnStruct();
    }

    if(scripts\engine\utility::is_true(var_05)) {
      var_02 = int(var_02);
    } else {
      var_02 = int(var_02 * 0.5);
    }

    var_13 = ["j_crotch", "j_hip_le", "j_hip_ri"];
    var_00 = var_01 gettagorigin(scripts\engine\utility::random(var_13));

    foreach(var_15 in var_12) {
      if(isDefined(var_15) && var_15 != var_01 && isalive(var_15) && !scripts\engine\utility::is_true(var_15.stunned)) {
        var_08 = 1;

        if(scripts\engine\utility::is_true(var_05)) {
          var_15.shockmelee = 1;
        }

        var_15 func_1118C(self, var_02, var_03, var_00);
        var_9++;

        if(var_09 >= var_10) {
          break;
        }
      }
    }

    wait 0.05;
    self.stun_struct = undefined;
  }

  if(scripts\engine\utility::is_true(var_05)) {
    scripts\cp\utility::notify_used_consumable("shock_melee_upgrade");
    var_1.shockmelee = 1;
  }

  if(isDefined(var_06)) {
    self notify(var_06);
  }

  return var_08;
}

func_1118C(var_00, var_01, var_02, var_03) {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_04 = undefined;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_05 = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  var_04 = self gettagorigin(scripts\engine\utility::random(var_05));

  if(isDefined(var_04)) {
    playfxbetweenpoints(level._effect["blue_ark_beam"], var_03, vectortoangles(var_03 - var_04), var_04);
    wait 0.05;

    if(isDefined(self) && var_02 == "MOD_MELEE") {
      self playSound("zombie_fence_shock");
    }

    wait 0.05;
    var_06 = int(var_01);
    scripts\common\fx::playfxnophase(level._effect["stun_shock"], var_04);

    if(isDefined(self)) {
      thread func_1118E(var_00, var_02, var_06, "stun_ammo_mp");
    }
  }
}

func_1118E(var_00, var_01, var_02, var_03) {
  self endon("death");

  if(isDefined(var_02)) {
    var_04 = var_02;
  } else {
    var_04 = 100;
  }

  if(isDefined(var_03)) {
    var_05 = var_03;
  } else {
    var_05 = "iw7_stunbolt_zm";
  }

  if(!scripts\asm\zombie\zombie::func_9F87()) {
    self.stunned = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    self.stun_hit_time = gettime() + 1500;
  }

  thread func_E093(1);

  if(isDefined(var_00)) {
    self getrandomarmkillstreak(var_04, self.origin, var_00, var_00, var_01, var_05);
  } else {
    self getrandomarmkillstreak(var_04, self.origin, undefined, undefined, var_01, var_05);
  }
}

func_E093(var_00) {
  self endon("death");
  wait(var_00);

  if(!scripts\cp\utility::should_be_affected_by_trap(self)) {
    return;
  }
  self.stunned = undefined;
}

monitordamage(var_00, var_01, var_02, var_03, var_04, var_05) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = var_00;
  self.damagetaken = 0;

  if(!isDefined(var_04)) {
    var_04 = 0;
  }

  for(var_06 = 1; var_06; var_06 = monitordamageoneshot(var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_01, var_02, var_03, var_04)) {
    self waittill("damage", var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(var_05) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_17 = "";

      if(isDefined(var_08) && isplayer(var_08)) {
        var_17 = var_08 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_17])) {
        self.attackers[var_17] = self.attackers[var_17] + var_07;
      } else {
        self.attackers[var_17] = var_07;
      }
    }
  }
}

monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_01) && !scripts\cp\utility::isgameparticipant(var_01) && !isDefined(var_1.allowmonitoreddamage)) {
    return 1;
  }

  return 1;
}

isfriendlyfire(var_00, var_01) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  if(!isplayer(var_01) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_00 == var_01) {
    return 0;
  }

  return 1;
}

finishplayerdamagewrapper(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  if(!callback_killingblow(var_00, var_01, var_02 - var_02 * var_10, var_03, var_04, var_05, var_06, var_07, var_08, var_09)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isplayer(self)) {
    self finishplayerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);
  }

  damageshellshockandrumble(var_00, var_05, var_04, var_02, var_03, var_01);
}

callback_killingblow(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_02 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\cp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

damageshellshockandrumble(var_00, var_01, var_02, var_03, var_04, var_05) {
  thread onweapondamage(var_00, var_01, var_02, var_03, var_05);

  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

onweapondamage(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  self endon("disconnect");

  switch (var_01) {
    default:
      if(allowshellshockondamage(var_01) && !isai(var_04)) {
        scripts\cp\cp_weapon::shellshockondamage(var_02, var_03);
      }

      break;
  }
}

allowshellshockondamage(var_00) {
  if(isDefined(var_00)) {
    switch (var_00) {
      case "iw7_zapper_grey":
        return 0;
    }
  }

  return 1;
}