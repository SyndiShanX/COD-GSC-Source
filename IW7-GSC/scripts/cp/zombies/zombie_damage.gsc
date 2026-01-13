/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_damage.gsc
************************************************/

callback_zombieplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
  if(!shouldtakedamage(var_2, var_1, var_5, var_3)) {
    return;
  }

  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_5])) {
      level thread[[level.overcook_func[var_5]]](var_0C, var_5);
    }
  }

  var_0D = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_0E = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_0F = isfriendlyfire(self, var_1);
  var_10 = scripts\cp\utility::is_hardcore_mode();
  var_11 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_12 = isDefined(var_1);
  var_13 = var_12 && isDefined(var_1.species) && var_1.species == "zombie";
  var_14 = var_12 && isDefined(var_1.species) && var_1.species == "zombie_grey";
  var_15 = var_12 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_brute";
  var_16 = var_12 && var_1 == self;
  var_17 = (var_16 || !var_12) && var_4 == "MOD_SUICIDE";
  if(var_12) {
    if(var_1 == self) {
      if(issubstr(var_5, "iw7_harpoon2_zm") || issubstr(var_5, "iw7_harpoon1_zm") || issubstr(var_5, "iw7_acid_rain_projectile_zm")) {
        var_2 = 0;
      }

      if(issubstr(var_5, "venomx")) {
        var_2 = 0;
      }

      if(var_0D) {
        var_18 = self getstance();
        if(var_11) {
          var_2 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
          var_2 = 0;
        } else {
          var_2 = get_explosive_damage_on_player(var_0, var_1, var_2, var_3, var_4, var_5);
        }
      }

      switch (var_5) {
        case "zmb_fireworksprojectile_mp":
        case "zmb_imsprojectile_mp":
        case "iw7_armageddonmeteor_mp":
          var_2 = 0;
          break;

        case "iw7_stunbolt_zm":
        case "iw7_bluebolts_zm":
        case "blackhole_grenade_zm":
        case "blackhole_grenade_mp":
          var_2 = 25;
          break;

        default:
          break;
      }
    } else if(var_0F) {
      if(var_10) {
        if(scripts\cp\utility::is_ricochet_damage()) {
          if(isplayer(var_1) && isDefined(var_8) && var_8 != "shield") {
            if(isDefined(var_0)) {
              var_1 dodamage(var_2, var_1.origin - (0, 0, 50), var_1, var_0, var_4);
            } else {
              var_1 dodamage(var_2, var_1.origin, var_1);
            }
          }

          var_2 = 0;
        }
      } else {
        var_2 = 0;
      }
    } else if(var_13) {
      if(var_4 != "MOD_EXPLOSIVE" && var_0C scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(var_1.is_burning)) {
          var_0C scripts\cp\utility::notify_used_consumable("burned_out");
          var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0C, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
          var_1.faf_burned_out = 1;
        }
      }

      var_19 = gettime();
      if(!isDefined(self.last_zombie_hit_time) || var_19 - self.last_zombie_hit_time > 20) {
        self.last_zombie_hit_time = var_19;
      } else {
        return;
      }

      var_1A = 500;
      if(getdvarint("zom_damage_shield_duration") != 0) {
        var_1A = getdvarint("zom_damage_shield_duration");
      }

      if(isDefined(var_1.last_damage_time_on_player[self.vo_prefix])) {
        var_1B = var_1.last_damage_time_on_player[self.vo_prefix];
        if(var_1B + var_1A > gettime()) {
          var_2 = 0;
        } else {
          var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else {
        var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
      }
    } else if(var_14) {
      var_2 = func_791A(var_0, var_1, var_2, var_3, var_4, var_5);
    }

    if(var_0E) {
      var_18 = self getstance();
      if(var_11) {
        var_2 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
        var_2 = 0;
      } else if(!var_10 || var_1 == self && var_8 == "none") {
        var_2 = 0;
      }
    }
  } else if(var_11 && var_4 == "MOD_SUICIDE") {
    if(var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm") {
      var_2 = 0;
    }
  } else {
    var_18 = self getstance();
    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
      if(var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm") {
        var_2 = 0;
      }
    }
  }

  if(var_4 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var_2 = 0;
    } else if(var_2 > 10) {
      if(var_2 > self.health * 0.15) {
        var_2 = int(self.health * 0.15);
      }
    } else {
      var_2 = 0;
    }
  }

  var_1C = 0;
  if(var_12 && var_1 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.linked_to_player)) {
    if(self.health - var_2 < 1) {
      var_2 = self.health - 1;
    }
  }

  if(var_13 || var_14 || var_15 || var_16 && !var_17) {
    var_2 = int(var_2 * var_0C scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    var_2 = int(max(self.maxhealth / 2.75, var_2));
  }

  if(var_0C scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_1)) {
    var_1D = !isDefined(var_1.agent_type) || var_13 || !var_14 || !var_15 || scripts\engine\utility::istrue(var_1.is_suicide_bomber) || !scripts\engine\utility::istrue(var_1.entered_playspace);
    var_1E = isDefined(var_1.agent_type) && var_13 && !var_14 || !var_15 || scripts\engine\utility::istrue(var_1.is_suicide_bomber) || !scripts\engine\utility::istrue(var_1.entered_playspace);
    var_1E = 0;
    if(isDefined(var_1.agent_type) && var_1.agent_type != "generic_zombie" || !scripts\engine\utility::istrue(var_1.entered_playspace)) {
      var_1E = 0;
    } else if(var_1 scripts\cp\utility::agentisfnfimmune()) {
      var_1E = 0;
    } else if(isplayer(var_0C) && isplayer(var_1)) {
      var_1E = 0;
    } else {
      var_1E = 1;
    }

    if(var_1E) {
      var_1 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_0C);
      var_0C scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_2 = int(var_2);
  if(!var_0F || var_10) {
    finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_1C, var_0A, var_0B);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_2);
  if(var_2 <= 0) {
    return;
  }

  thread scripts\cp\utility::player_pain_vo(var_1);
  thread play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();
  if(isDefined(var_1)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();
    if(isagent(var_1)) {
      if(!isDefined(var_1.damage_done)) {
        var_1.damage_done = 0;
      } else {
        var_1.damage_done = var_1.damage_done + var_2;
      }

      self.recent_attacker = var_1;
      if(isDefined(level.current_challenge)) {
        self[[level.custom_playerdamage_challenge_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
        return;
      }
    }
  }
}

delete_entities_on_death() {
  self notify("one_deletethread_instance_" + self.name);
  self endon("one_deletethread_instance_" + self.name);
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  if(isDefined(self)) {
    if(isDefined(self.scrnfx_obj)) {
      self.scrnfx_obj delete();
    }
  }
}

play_pain_photo(var_0) {
  var_0 notify("play_pain_photo");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("play_pain_photo");
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return;
  }

  scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "damaged");
  wait(4);
  scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "healthy");
}

func_50F9(var_0) {
  self endon("death");
  var_0 endon("death");
  wait(0.05);
  self dodamage(2, self.origin, var_0, undefined, "MOD_MELEE");
}

get_explosive_damage_on_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    return var_2;
  }

  var_6 = getweaponbasename(var_5);
  if(!isDefined(var_6)) {
    return var_2;
  }

  switch (var_6) {
    case "iw7_chargeshot_zm":
    case "throwingknifec4_mp":
    case "semtex_zm":
    case "frag_grenade_zm":
      var_7 = var_2 / 1200;
      var_2 = var_7 * 100;
      break;

    case "iw7_blackholegun_mp":
    case "c4_zm":
      var_7 = var_2 / 2000;
      var_2 = var_7 * 100;
      break;

    case "iw7_glprox_zm":
    case "cluster_grenade_zm":
      var_7 = var_2 / 800;
      var_2 = var_7 * 100;
      break;

    case "iw7_g18_zml":
    case "iw7_g18_zm":
    case "iw7_g18_zmr":
      if(scripts\cp\cp_weapon::get_weapon_level(var_6) <= 2) {
        var_7 = var_2 / 1800;
        var_2 = var_7 * 100;
        break;
      } else {
        var_2 = 0;
      }
      break;

    case "iw7_armageddonmeteor_mp":
      var_2 = 0;
      break;

    case "iw7_stunbolt_zm":
    case "iw7_bluebolts_zm":
      var_2 = var_2 * 0.33;
      var_2 = min(80, var_2);
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
      var_2 = 0;
      break;

    case "iw7_headcuttershards_mp":
      var_2 = 0;
      break;

    case "splash_grenade_zm":
    case "splash_grenade_mp":
      var_2 = min(10, var_2);
      break;

    default:
      break;
  }

  return min(80, var_2);
}

func_791A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4)) {
    switch (var_4) {
      case "MOD_EXPLOSIVE":
        return var_2;

      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        return min(80, var_2);

      case "MOD_UNKNOWN":
        return var_2;

      default:
        return var_2;
    }
  }

  return var_2;
}

func_100B8(var_0) {
  var_1 = 20;
  if(var_0 == 0) {
    return 0;
  }

  return self.haveinvulnerabilityavailable && var_0 > self.health && var_0 < self.health + var_1;
}

usingremoteandwillbelowhealth(var_0) {
  var_1 = 0.2;
  var_2 = self.maxhealth * var_1;
  return scripts\cp\utility::isusingremote() && var_0 > self.health || self.health - var_0 <= var_2;
}

stopusingremote() {
  self notify("stop_using_remote");
}

useinvulnerability(var_0) {
  self.health = var_0 + 1;
  self.haveinvulnerabilityavailable = 0;
}

shouldtakedamage(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(level.disableplayerdamage)) {
    return 0;
  }

  if((isDefined(var_2) && issubstr(var_2, "venomx") || var_2 == "zmb_imsprojectile_mp" || var_2 == "zmb_fireworksprojectile_mp") || var_2 == "sentry_minigun_mp" || var_2 == "zmb_robotprojectile_mp" || var_2 == "iw7_electrictrap_zm") {
    return 0;
  }

  if(isDefined(var_2) && var_2 == "bolasprayprojhome_mp") {
    return 0;
  }

  if(isDefined(var_3) && var_3 == 256 || var_3 == 258) {
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

  if(isDefined(var_1) && isDefined(var_1.is_neil)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.is_off_grid)) {
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

func_F29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(var_1 == "xm25_mp" && var_0 == "MOD_IMPACT") {
      var_2 = 95;
    }

    if(var_1 == "spider_beam_mp") {
      var_2 = var_2 * 15;
    }

    if(var_1 == "alienthrowingknife_mp" && var_0 == "MOD_IMPACT") {
      if(scripts\cp\cp_damage::can_hypno(var_3, 0, var_4, var_0, var_1, var_5, var_6, var_7, var_8, var_9)) {
        var_2 = 20000;
      } else if(scripts\cp\cp_agent_utils::get_agent_type(self) != "elite") {
        var_2 = 500;
      }
    }
  }

  return var_2;
}

update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isDefined(var_1.triggerportableradarping)) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.triggerportableradarping, var_2 * 0.75);
  } else if(isDefined(var_1) && isDefined(var_1.pet) && var_1.pet == 1) {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.triggerportableradarping, var_2);
  } else {
    scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_5)) {
    level thread update_zombie_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
  }

  update_zombie_damage_challenge(var_1, var_2, var_4);
}

update_zombie_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return;
  }

  if(!isDefined(level.current_challenge)) {
    return;
  }

  if(isDefined(var_1) && isplayer(var_1)) {
    var_0B = self[[level.var_4C44]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_0A);
    if(!scripts\engine\utility::istrue(var_0B)) {
      return;
    }
  }
}

update_zombie_damage_challenge(var_0, var_1, var_2) {
  if(isDefined(level.update_zombie_damage_challenge)) {
    [[level.update_zombie_damage_challenge]](var_0, var_1, var_2);
    return;
  }

  update_performance_zombie_damage(var_0, var_1, var_2);
}

update_performance_zombie_damage(var_0, var_1, var_2) {
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
  if(isplayer(var_0)) {
    var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_1);
    return;
  }

  if(isDefined(var_0.triggerportableradarping)) {
    var_0.triggerportableradarping scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", var_1);
  }
}

func_2189(var_0, var_1, var_2) {
  return 1;
}

stun_zap(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(self.stun_struct)) {
    return 0;
  }

  var_7 = gettime();
  if(isDefined(self.var_A918) && !isDefined(var_5)) {
    if(var_7 < self.var_A918) {
      return;
    }
  }

  self.var_A918 = var_7 + 500;
  var_8 = 0;
  var_9 = 0;
  var_0A = 4;
  if(!isDefined(var_4)) {
    var_4 = 256;
  }

  var_0B = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_0C = scripts\engine\utility::get_array_of_closest(var_1.origin, var_0B, undefined, var_0A, var_4, 1);
  if(scripts\engine\utility::array_contains(var_0C, var_1)) {
    var_0C = scripts\engine\utility::array_remove(var_0C, var_1);
  }

  if(var_0C.size >= 1) {
    if(!isDefined(self.stun_struct)) {
      self.stun_struct = spawnStruct();
    }

    if(scripts\engine\utility::istrue(var_5)) {
      var_2 = int(var_2);
    } else {
      var_2 = int(var_2 * 0.5);
    }

    var_0D = ["j_crotch", "j_hip_le", "j_hip_ri"];
    if(issubstr(var_1.agent_type, "alien")) {
      var_0 = var_1 gettagorigin("j_spine4");
    } else {
      var_0 = var_1 gettagorigin(scripts\engine\utility::random(var_0D));
    }

    foreach(var_0F in var_0C) {
      if(isDefined(var_0F) && var_0F != var_1 && isalive(var_0F) && !scripts\engine\utility::istrue(var_0F.stunned)) {
        var_8 = 1;
        if(scripts\engine\utility::istrue(var_5)) {
          var_0F.shockmelee = 1;
        }

        var_0F func_1118C(self, var_2, var_3, var_0);
        var_9++;
        if(var_9 >= var_0A) {
          break;
        }
      }
    }

    wait(0.05);
    self.stun_struct = undefined;
  }

  if(scripts\engine\utility::istrue(var_5)) {
    scripts\cp\utility::notify_used_consumable("shock_melee_upgrade");
    var_1.shockmelee = 1;
  }

  if(isDefined(var_6)) {
    self notify(var_6);
  }

  return var_8;
}

func_1118C(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_4 = undefined;
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  var_5 = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  if(issubstr(self.agent_type, "alien")) {
    var_4 = self gettagorigin("j_spine4");
  } else {
    var_4 = self gettagorigin(scripts\engine\utility::random(var_5));
  }

  if(isDefined(var_4)) {
    playfxbetweenpoints(level._effect["blue_ark_beam"], var_3, vectortoangles(var_3 - var_4), var_4);
    wait(0.05);
    if(isDefined(self) && var_2 == "MOD_MELEE") {
      self playSound("zombie_fence_shock");
    }

    wait(0.05);
    var_6 = int(var_1);
    scripts\common\fx::playfxnophase(level._effect["stun_shock"], var_4);
    if(isDefined(self)) {
      thread func_1118E(var_0, var_2, var_6, "stun_ammo_mp");
    }
  }
}

func_1118E(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = 100;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  } else {
    var_5 = "iw7_stunbolt_zm";
  }

  if(!scripts\asm\zombie\zombie::func_9F87()) {
    self.stunned = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    self.stun_hit_time = gettime() + 1500;
  }

  thread func_E093(1);
  if(isDefined(var_0)) {
    self dodamage(var_4, self.origin, var_0, var_0, var_1, var_5);
    return;
  }

  self dodamage(var_4, self.origin, undefined, undefined, var_1, var_5);
}

func_E093(var_0) {
  self endon("death");
  wait(var_0);
  if(!scripts\cp\utility::should_be_affected_by_trap(self)) {
    return;
  }

  self.stunned = undefined;
}

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = var_0;
  self.var_E1 = 0;
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_6 = 1; var_6; var_6 = monitordamageoneshot(var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    if(var_5) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_11 = "";
      if(isDefined(var_8) && isplayer(var_8)) {
        var_11 = var_8 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_11])) {
        self.attackers[var_11] = self.attackers[var_11] + var_7;
      } else {
        self.attackers[var_11] = var_7;
      }
    }
  }
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_1) && !scripts\cp\utility::isgameparticipant(var_1) && !isDefined(var_1.allowmonitoreddamage)) {
    return 1;
  }

  return 1;
}

isfriendlyfire(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isplayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  if(!callback_killingblow(var_0, var_1, var_2 - var_2 * var_0A, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isplayer(self)) {
    self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_2 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\cp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread onweapondamage(var_0, var_1, var_2, var_3, var_5);
  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
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

allowshellshockondamage(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "iw7_zapper_grey":
        return 0;
    }
  }

  return 1;
}