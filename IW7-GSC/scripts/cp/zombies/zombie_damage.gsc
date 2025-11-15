/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_damage.gsc
************************************************/

callback_zombieplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(!shouldtakedamage(param_02, param_01, param_05, param_03)) {
    return;
  }

  if(param_04 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[param_05])) {
      level thread[[level.overcook_func[param_05]]](var_0C, param_05);
    }
  }

  var_0D = isDefined(param_04) && param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE_SPLASH";
  var_0E = isDefined(param_04) && param_04 == "MOD_EXPLOSIVE_BULLET";
  var_0F = isfriendlyfire(self, param_01);
  var_10 = scripts\cp\utility::is_hardcore_mode();
  var_11 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_12 = isDefined(param_01);
  var_13 = var_12 && isDefined(param_01.species) && param_01.species == "zombie";
  var_14 = var_12 && isDefined(param_01.species) && param_01.species == "zombie_grey";
  var_15 = var_12 && isDefined(param_01.agent_type) && param_01.agent_type == "zombie_brute";
  var_16 = var_12 && param_01 == self;
  var_17 = (var_16 || !var_12) && param_04 == "MOD_SUICIDE";
  if(var_12) {
    if(param_01 == self) {
      if(issubstr(param_05, "iw7_harpoon2_zm") || issubstr(param_05, "iw7_harpoon1_zm") || issubstr(param_05, "iw7_acid_rain_projectile_zm")) {
        param_02 = 0;
      }

      if(issubstr(param_05, "venomx")) {
        param_02 = 0;
      }

      if(var_0D) {
        var_18 = self getstance();
        if(var_11) {
          param_02 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
          param_02 = 0;
        } else {
          param_02 = get_explosive_damage_on_player(param_00, param_01, param_02, param_03, param_04, param_05);
        }
      }

      switch (param_05) {
        case "zmb_fireworksprojectile_mp":
        case "zmb_imsprojectile_mp":
        case "iw7_armageddonmeteor_mp":
          param_02 = 0;
          break;

        case "iw7_stunbolt_zm":
        case "iw7_bluebolts_zm":
        case "blackhole_grenade_zm":
        case "blackhole_grenade_mp":
          param_02 = 25;
          break;

        default:
          break;
      }
    } else if(var_0F) {
      if(var_10) {
        if(scripts\cp\utility::is_ricochet_damage()) {
          if(isplayer(param_01) && isDefined(param_08) && param_08 != "shield") {
            if(isDefined(param_00)) {
              param_01 dodamage(param_02, param_01.origin - (0, 0, 50), param_01, param_00, param_04);
            } else {
              param_01 dodamage(param_02, param_01.origin, param_01);
            }
          }

          param_02 = 0;
        }
      } else {
        param_02 = 0;
      }
    } else if(var_13) {
      if(param_04 != "MOD_EXPLOSIVE" && var_0C scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(param_01.is_burning)) {
          var_0C scripts\cp\utility::notify_used_consumable("burned_out");
          param_01 thread scripts\cp\utility::damage_over_time(param_01, var_0C, 3, int(param_01.maxhealth + 1000), param_04, "incendiary_ammo_mp", undefined, "burning");
          param_01.faf_burned_out = 1;
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

      if(isDefined(param_01.last_damage_time_on_player[self.vo_prefix])) {
        var_1B = param_01.last_damage_time_on_player[self.vo_prefix];
        if(var_1B + var_1A > gettime()) {
          param_02 = 0;
        } else {
          param_01.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else {
        param_01.last_damage_time_on_player[self.vo_prefix] = gettime();
      }
    } else if(var_14) {
      param_02 = func_791A(param_00, param_01, param_02, param_03, param_04, param_05);
    }

    if(var_0E) {
      var_18 = self getstance();
      if(var_11) {
        param_02 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
        param_02 = 0;
      } else if(!var_10 || param_01 == self && param_08 == "none") {
        param_02 = 0;
      }
    }
  } else if(var_11 && param_04 == "MOD_SUICIDE") {
    if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm") {
      param_02 = 0;
    }
  } else {
    var_18 = self getstance();
    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_18 == "crouch" || var_18 == "prone") && self isonground()) {
      if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm") {
        param_02 = 0;
      }
    }
  }

  if(param_04 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      param_02 = 0;
    } else if(param_02 > 10) {
      if(param_02 > self.health * 0.15) {
        param_02 = int(self.health * 0.15);
      }
    } else {
      param_02 = 0;
    }
  }

  var_1C = 0;
  if(var_12 && param_01 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.linked_to_player)) {
    if(self.health - param_02 < 1) {
      param_02 = self.health - 1;
    }
  }

  if(var_13 || var_14 || var_15 || var_16 && !var_17) {
    param_02 = int(param_02 * var_0C scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    param_02 = int(max(self.maxhealth / 2.75, param_02));
  }

  if(var_0C scripts\cp\utility::is_consumable_active("secret_service") && isalive(param_01)) {
    var_1D = !isDefined(param_01.agent_type) || var_13 || !var_14 || !var_15 || scripts\engine\utility::istrue(param_01.is_suicide_bomber) || !scripts\engine\utility::istrue(param_01.entered_playspace);
    var_1E = isDefined(param_01.agent_type) && var_13 && !var_14 || !var_15 || scripts\engine\utility::istrue(param_01.is_suicide_bomber) || !scripts\engine\utility::istrue(param_01.entered_playspace);
    var_1E = 0;
    if(isDefined(param_01.agent_type) && param_01.agent_type != "generic_zombie" || !scripts\engine\utility::istrue(param_01.entered_playspace)) {
      var_1E = 0;
    } else if(param_01 scripts\cp\utility::agentisfnfimmune()) {
      var_1E = 0;
    } else if(isplayer(var_0C) && isplayer(param_01)) {
      var_1E = 0;
    } else {
      var_1E = 1;
    }

    if(var_1E) {
      param_01 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_0C);
      var_0C scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  param_02 = int(param_02);
  if(!var_0F || var_10) {
    finishplayerdamagewrapper(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_1C, param_0A, param_0B);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", param_02);
  if(param_02 <= 0) {
    return;
  }

  thread scripts\cp\utility::player_pain_vo(param_01);
  thread play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();
  if(isDefined(param_01)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();
    if(isagent(param_01)) {
      if(!isDefined(param_01.damage_done)) {
        param_01.damage_done = 0;
      } else {
        param_01.damage_done = param_01.damage_done + param_02;
      }

      self.recent_attacker = param_01;
      if(isDefined(level.current_challenge)) {
        self[[level.custom_playerdamage_challenge_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
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

play_pain_photo(param_00) {
  param_00 notify("play_pain_photo");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("play_pain_photo");
  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return;
  }

  scripts\cp\zombies\zombies_loadout::set_player_photo_status(param_00, "damaged");
  wait(4);
  scripts\cp\zombies\zombies_loadout::set_player_photo_status(param_00, "healthy");
}

func_50F9(param_00) {
  self endon("death");
  param_00 endon("death");
  wait(0.05);
  self dodamage(2, self.origin, param_00, undefined, "MOD_MELEE");
}

get_explosive_damage_on_player(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    return param_02;
  }

  var_06 = getweaponbasename(param_05);
  if(!isDefined(var_06)) {
    return param_02;
  }

  switch (var_06) {
    case "iw7_chargeshot_zm":
    case "throwingknifec4_mp":
    case "semtex_zm":
    case "frag_grenade_zm":
      var_07 = param_02 / 1200;
      param_02 = var_07 * 100;
      break;

    case "iw7_blackholegun_mp":
    case "c4_zm":
      var_07 = param_02 / 2000;
      param_02 = var_07 * 100;
      break;

    case "iw7_glprox_zm":
    case "cluster_grenade_zm":
      var_07 = param_02 / 800;
      param_02 = var_07 * 100;
      break;

    case "iw7_g18_zml":
    case "iw7_g18_zm":
    case "iw7_g18_zmr":
      if(scripts\cp\cp_weapon::get_weapon_level(var_06) <= 2) {
        var_07 = param_02 / 1800;
        param_02 = var_07 * 100;
        break;
      } else {
        param_02 = 0;
      }
      break;

    case "iw7_armageddonmeteor_mp":
      param_02 = 0;
      break;

    case "iw7_stunbolt_zm":
    case "iw7_bluebolts_zm":
      param_02 = param_02 * 0.33;
      param_02 = min(80, param_02);
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
      param_02 = 0;
      break;

    case "iw7_headcuttershards_mp":
      param_02 = 0;
      break;

    case "splash_grenade_zm":
    case "splash_grenade_mp":
      param_02 = min(10, param_02);
      break;

    default:
      break;
  }

  return min(80, param_02);
}

func_791A(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_04)) {
    switch (param_04) {
      case "MOD_EXPLOSIVE":
        return param_02;

      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        return min(80, param_02);

      case "MOD_UNKNOWN":
        return param_02;

      default:
        return param_02;
    }
  }

  return param_02;
}

func_100B8(param_00) {
  var_01 = 20;
  if(param_00 == 0) {
    return 0;
  }

  return self.haveinvulnerabilityavailable && param_00 > self.health && param_00 < self.health + var_01;
}

usingremoteandwillbelowhealth(param_00) {
  var_01 = 0.2;
  var_02 = self.maxhealth * var_01;
  return scripts\cp\utility::isusingremote() && param_00 > self.health || self.health - param_00 <= var_02;
}

stopusingremote() {
  self notify("stop_using_remote");
}

useinvulnerability(param_00) {
  self.health = param_00 + 1;
  self.haveinvulnerabilityavailable = 0;
}

shouldtakedamage(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(level.disableplayerdamage)) {
    return 0;
  }

  if((isDefined(param_02) && issubstr(param_02, "venomx") || param_02 == "zmb_imsprojectile_mp" || param_02 == "zmb_fireworksprojectile_mp") || param_02 == "sentry_minigun_mp" || param_02 == "zmb_robotprojectile_mp" || param_02 == "iw7_electrictrap_zm") {
    return 0;
  }

  if(isDefined(param_02) && param_02 == "bolasprayprojhome_mp") {
    return 0;
  }

  if(isDefined(param_03) && param_03 == 256 || param_03 == 258) {
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

  if(isDefined(param_01) && isDefined(param_01.is_neil)) {
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

func_F29B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01)) {
    if(param_01 == "xm25_mp" && param_00 == "MOD_IMPACT") {
      param_02 = 95;
    }

    if(param_01 == "spider_beam_mp") {
      param_02 = param_02 * 15;
    }

    if(param_01 == "alienthrowingknife_mp" && param_00 == "MOD_IMPACT") {
      if(scripts\cp\cp_damage::can_hypno(param_03, 0, param_04, param_00, param_01, param_05, param_06, param_07, param_08, param_09)) {
        param_02 = 20000;
      } else if(scripts\cp\cp_agent_utils::get_agent_type(self) != "elite") {
        param_02 = 500;
      }
    }
  }

  return param_02;
}

update_damage_score(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01) && isDefined(param_01.triggerportableradarping)) {
    scripts\cp\cp_agent_utils::store_attacker_info(param_01.triggerportableradarping, param_02 * 0.75);
  } else if(isDefined(param_01) && isDefined(param_01.pet) && param_01.pet == 1) {
    scripts\cp\cp_agent_utils::store_attacker_info(param_01.triggerportableradarping, param_02);
  } else {
    scripts\cp\cp_agent_utils::store_attacker_info(param_01, param_02);
  }

  if(isDefined(param_01) && isDefined(param_05)) {
    level thread update_zombie_damage_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, self);
  }

  update_zombie_damage_challenge(param_01, param_02, param_04);
}

update_zombie_damage_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return;
  }

  if(!isDefined(level.current_challenge)) {
    return;
  }

  if(isDefined(param_01) && isplayer(param_01)) {
    var_0B = self[[level.var_4C44]](param_00, param_01, param_02, param_04, param_05, param_07, param_08, param_09, param_0A);
    if(!scripts\engine\utility::istrue(var_0B)) {
      return;
    }
  }
}

update_zombie_damage_challenge(param_00, param_01, param_02) {
  if(isDefined(level.update_zombie_damage_challenge)) {
    [[level.update_zombie_damage_challenge]](param_00, param_01, param_02);
    return;
  }

  update_performance_zombie_damage(param_00, param_01, param_02);
}

update_performance_zombie_damage(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_00.classname) && param_00.classname == "script_vehicle") {
    return;
  }

  if(param_02 == "MOD_TRIGGER_HURT") {
    return;
  }

  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "damage_done_on_alien", param_01);
  if(isplayer(param_00)) {
    param_00 scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", param_01);
    return;
  }

  if(isDefined(param_00.triggerportableradarping)) {
    param_00.triggerportableradarping scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_done_on_alien", param_01);
  }
}

func_2189(param_00, param_01, param_02) {
  return 1;
}

stun_zap(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(self.stun_struct)) {
    return 0;
  }

  var_07 = gettime();
  if(isDefined(self.var_A918) && !isDefined(param_05)) {
    if(var_07 < self.var_A918) {
      return;
    }
  }

  self.var_A918 = var_07 + 500;
  var_08 = 0;
  var_09 = 0;
  var_0A = 4;
  if(!isDefined(param_04)) {
    param_04 = 256;
  }

  var_0B = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_0C = scripts\engine\utility::get_array_of_closest(param_01.origin, var_0B, undefined, var_0A, param_04, 1);
  if(scripts\engine\utility::array_contains(var_0C, param_01)) {
    var_0C = scripts\engine\utility::array_remove(var_0C, param_01);
  }

  if(var_0C.size >= 1) {
    if(!isDefined(self.stun_struct)) {
      self.stun_struct = spawnStruct();
    }

    if(scripts\engine\utility::istrue(param_05)) {
      param_02 = int(param_02);
    } else {
      param_02 = int(param_02 * 0.5);
    }

    var_0D = ["j_crotch", "j_hip_le", "j_hip_ri"];
    if(issubstr(param_01.agent_type, "alien")) {
      param_00 = param_01 gettagorigin("j_spine4");
    } else {
      param_00 = param_01 gettagorigin(scripts\engine\utility::random(var_0D));
    }

    foreach(var_0F in var_0C) {
      if(isDefined(var_0F) && var_0F != param_01 && isalive(var_0F) && !scripts\engine\utility::istrue(var_0F.stunned)) {
        var_08 = 1;
        if(scripts\engine\utility::istrue(param_05)) {
          var_0F.shockmelee = 1;
        }

        var_0F func_1118C(self, param_02, param_03, param_00);
        var_09++;
        if(var_09 >= var_0A) {
          break;
        }
      }
    }

    wait(0.05);
    self.stun_struct = undefined;
  }

  if(scripts\engine\utility::istrue(param_05)) {
    scripts\cp\utility::notify_used_consumable("shock_melee_upgrade");
    param_01.shockmelee = 1;
  }

  if(isDefined(param_06)) {
    self notify(param_06);
  }

  return var_08;
}

func_1118C(param_00, param_01, param_02, param_03) {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_04 = undefined;
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  var_05 = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  if(issubstr(self.agent_type, "alien")) {
    var_04 = self gettagorigin("j_spine4");
  } else {
    var_04 = self gettagorigin(scripts\engine\utility::random(var_05));
  }

  if(isDefined(var_04)) {
    playfxbetweenpoints(level._effect["blue_ark_beam"], param_03, vectortoangles(param_03 - var_04), var_04);
    wait(0.05);
    if(isDefined(self) && param_02 == "MOD_MELEE") {
      self playSound("zombie_fence_shock");
    }

    wait(0.05);
    var_06 = int(param_01);
    scripts\common\fx::playfxnophase(level._effect["stun_shock"], var_04);
    if(isDefined(self)) {
      thread func_1118E(param_00, param_02, var_06, "stun_ammo_mp");
    }
  }
}

func_1118E(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(isDefined(param_02)) {
    var_04 = param_02;
  } else {
    var_04 = 100;
  }

  if(isDefined(param_03)) {
    var_05 = param_03;
  } else {
    var_05 = "iw7_stunbolt_zm";
  }

  if(!scripts\asm\zombie\zombie::func_9F87()) {
    self.stunned = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    self.stun_hit_time = gettime() + 1500;
  }

  thread func_E093(1);
  if(isDefined(param_00)) {
    self dodamage(var_04, self.origin, param_00, param_00, param_01, var_05);
    return;
  }

  self dodamage(var_04, self.origin, undefined, undefined, param_01, var_05);
}

func_E093(param_00) {
  self endon("death");
  wait(param_00);
  if(!scripts\cp\utility::should_be_affected_by_trap(self)) {
    return;
  }

  self.stunned = undefined;
}

monitordamage(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = param_00;
  self.var_E1 = 0;
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  for(var_06 = 1; var_06; var_06 = monitordamageoneshot(var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, param_01, param_02, param_03, param_04)) {
    self waittill("damage", var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    if(param_05) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_11 = "";
      if(isDefined(var_08) && isplayer(var_08)) {
        var_11 = var_08 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_11])) {
        self.attackers[var_11] = self.attackers[var_11] + var_07;
      } else {
        self.attackers[var_11] = var_07;
      }
    }
  }
}

monitordamageoneshot(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(param_01) && !scripts\cp\utility::isgameparticipant(param_01) && !isDefined(param_01.allowmonitoreddamage)) {
    return 1;
  }

  return 1;
}

isfriendlyfire(param_00, param_01) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(param_01)) {
    return 0;
  }

  if(!isplayer(param_01) && !isDefined(param_01.team)) {
    return 0;
  }

  if(param_00.team != param_01.team) {
    return 0;
  }

  if(param_00 == param_01) {
    return 0;
  }

  return 1;
}

finishplayerdamagewrapper(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  if(!callback_killingblow(param_00, param_01, param_02 - param_02 * param_0A, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isplayer(self)) {
    self finishplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
  }

  damageshellshockandrumble(param_00, param_05, param_04, param_02, param_03, param_01);
}

callback_killingblow(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && param_02 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\cp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

damageshellshockandrumble(param_00, param_01, param_02, param_03, param_04, param_05) {
  thread onweapondamage(param_00, param_01, param_02, param_03, param_05);
  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

onweapondamage(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  switch (param_01) {
    default:
      if(allowshellshockondamage(param_01) && !isai(param_04)) {
        scripts\cp\cp_weapon::shellshockondamage(param_02, param_03);
      }
      break;
  }
}

allowshellshockondamage(param_00) {
  if(isDefined(param_00)) {
    switch (param_00) {
      case "iw7_zapper_grey":
        return 0;
    }
  }

  return 1;
}