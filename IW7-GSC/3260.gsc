/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3260.gsc
************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  level thread func_B982();
  if(!scripts\engine\utility::istrue(level.generic_zombie_agent_func_init_done)) {
    level.agent_funcs["generic_zombie"]["on_damaged"] = ::onzombiedamaged;
    level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
    level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::onzombiekilled;
    level.generic_zombie_agent_func_init_done = 1;
  }

  level.agent_funcs["zombie_brute"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["zombie_brute"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["zombie_brute"]["gametype_on_killed"] = ::onzombiekilled;
  level.callbackplayerimpaled = ::func_3759;
  level.agent_funcs["c6"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["c6"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["c6"]["gametype_on_killed"] = ::onzombiekilled;
  level.agent_funcs["the_hoff"]["on_damaged"] = ::onhoffdamaged;
  level.agent_funcs["the_hoff"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["the_hoff"]["gametype_on_killed"] = ::onzombiekilled;
  level.var_768B = ::func_777C;
  level.in_room_check_func = ::scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.fnzombieshouldenterplayspace = ::zombieshouldenterplayspace;
  level.movemodefunc["generic_zombie"] = ::run_if_last_zombie;
  if(!isDefined(level.eligable_for_reward_func)) {
    level.eligable_for_reward_func = ::base_eligable_for_reward_func;
  }

  if(!isDefined(level.should_do_damage_check_func)) {
    level.should_do_damage_check_func = ::base_should_do_damage_check;
  }

  level.last_drop_time = gettime();
  level.frozenzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  level thread func_97BA();
  level.var_7089 = ::get_closest_player_near_interaction_point;
  level.fn_get_closest_entrance = ::scripts\cp\utility::get_closest_entrance;
  level.no_pain_volume = getent("no_pain_volume", "targetname");
}

base_eligable_for_reward_func(param_00, param_01, param_02, param_03, param_04, param_05) {
  return 1;
}

base_should_do_damage_check(param_00, param_01, param_02, param_03, param_04, param_05) {
  return 1;
}

onhoffdamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {}

onzombiedamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(!isDefined(self.agent_type)) {
    return;
  }

  if(param_04 != "MOD_SUICIDE") {
    if(scripts\mp\mp_agent::is_friendly_damage(var_0C, param_01)) {
      return;
    }

    if(scripts\mp\mp_agent::is_friendly_damage(var_0C, param_00)) {
      return;
    }
  }

  if(!isDefined(param_01)) {
    param_01 = self;
  }

  var_0D = should_do_damage_checks(param_01, param_02, param_04, param_05, param_08, var_0C);
  if(!var_0D) {
    return;
  }

  param_03 = param_03 | 4;
  var_0E = isDefined(var_0C.agent_type) && var_0C.agent_type == "zombie_brute";
  var_0F = isDefined(var_0C.agent_type) && var_0C.agent_type == "zombie_grey";
  var_10 = isDefined(var_0C.agent_type) && var_0C.agent_type == "slasher";
  var_11 = isDefined(var_0C.agent_type) && var_0C.agent_type == "superslasher";
  var_12 = scripts\engine\utility::istrue(var_0C.is_suicide_bomber);
  var_13 = param_04 == "MOD_MELEE";
  var_14 = scripts\engine\utility::istrue(param_01.inlaststand);
  var_15 = isDefined(self.isfrozen) && isDefined(param_05) && !scripts\cp\cp_weapon::isforgefreezeweapon(param_05) || param_04 == "MOD_MELEE";
  var_16 = scripts\cp\cp_weapon::isaltforgefreezeweapon(param_05);
  var_17 = scripts\engine\utility::isbulletdamage(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
  var_18 = isDefined(param_01) && isplayer(param_01);
  var_19 = var_17 && scripts\cp\utility::isheadshot(param_05, param_08, param_04, param_01);
  var_1A = (param_01 scripts\cp\cp_weapon::has_attachment(param_05, "overclock") || param_01 scripts\cp\cp_weapon::has_attachment(param_05, "overclockcp")) && var_17;
  var_1B = scripts\engine\utility::istrue(self.battleslid);
  var_1C = scripts\engine\utility::istrue(level.insta_kill) && !var_0E && !var_0F;
  var_1D = !var_14 && var_19 && var_17 && param_01 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_1E = (param_04 == "MOD_EXPLOSIVE_BULLET" && isDefined(param_08) && param_08 == "none") || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
  var_1F = var_13 && param_01 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_20 = scripts\engine\utility::istrue(self.immune_against_freeze);
  var_21 = scripts\cp\utility::isaltmodeweapon(param_05);
  var_22 = var_13 && param_01 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  if(isDefined(param_05) && issubstr(param_05, "iw7_gauss_zml")) {
    var_23 = 250;
    if(scripts\cp\utility::weaponhasattachment(param_05, "pap1")) {
      var_23 = 470;
    }

    if(scripts\cp\utility::weaponhasattachment(param_05, "pap2")) {
      var_23 = 734;
    }

    if(scripts\cp\utility::weaponhasattachment(param_05, "doubletap")) {
      var_23 = 1.33 * var_23;
    }

    if(param_02 >= var_23) {
      self.hitbychargedshot = param_01;
    }
  }

  if(isplayer(param_01)) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      param_01 notify("weapon_hit_marked_target", param_01, param_02, param_04, param_05, self);
    }

    if(issubstr(param_05, "iw7_harpoon2_zm")) {
      param_01 notify("zombie_hit_by_ben", param_06, self, self.maxhealth);
    }
  }

  if(var_18) {
    self.damaged_by_player = 1;
    if(scripts\engine\utility::istrue(param_01.stimulus_active)) {
      playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
      scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", self gettagorigin("j_spineupper"));
      foreach(var_25 in level.players) {
        if(var_25 == param_01) {
          if(distance2dsquared(var_25.origin, self.origin) <= 10000) {
            playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
            playFX(level._effect["stimulus_shield"], var_25 gettagorigin("tag_eye"), anglesToForward(var_25.angles), anglestoup(var_25.angles), var_25);
            if(param_02 >= self.health) {
              if(scripts\engine\utility::istrue(var_25.inlaststand)) {
                scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_25);
              }
            }

            if(var_25.health + param_02 / level.players.size + 1 >= var_25.maxhealth) {
              var_25.health = var_25.maxhealth;
            } else {
              var_25.health = int(var_25.health + param_02 / level.players.size + 1);
            }
          }

          continue;
        }

        if(distance2dsquared(var_25.origin, self.origin) <= 10000) {
          playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
          playFX(level._effect["stimulus_shield"], var_25 gettagorigin("tag_eye"));
          if(param_02 >= self.health) {
            if(scripts\engine\utility::istrue(var_25.inlaststand)) {
              scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_25);
            }
          }

          if(int(var_25.health + param_02 / level.players.size + 1) >= var_25.maxhealth) {
            var_25.health = var_25.maxhealth;
            continue;
          }

          var_25.health = int(var_25.health + param_02 / level.players.size + 1);
        }
      }
    }

    if(scripts\engine\utility::istrue(param_01.deadeye_charge)) {
      param_02 = param_02 * 1.25;
    }
  }

  if(isDefined(param_01.is_turned) && param_01.is_turned && param_04 != "MOD_SUICIDE") {
    if(var_0E) {
      param_02 = int(param_02 * 1.5);
    } else {
      param_02 = param_01.melee_damage_amt;
    }
  }

  var_27 = 0;
  if(!var_13 && checkaltmodestatus(param_05) && var_18 && !isDefined(param_01.linked_to_coaster) && param_01 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_27 = param_01 scripts\cp\utility::coop_getweaponclass(param_05) == "weapon_sniper";
  }

  var_28 = scripts\engine\utility::istrue(level.explosive_touch) && isDefined(param_04) && param_04 == "MOD_UNKNOWN";
  if(var_28 && var_0F || var_0E) {
    return;
  }

  var_29 = !var_0E && !var_0F && var_1B || var_1C || var_22 || var_28 || var_15 || var_1A || var_1D || var_1F || var_27;
  var_2A = isDefined(self.isfrozen);
  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(param_05) && !var_0E && !var_0F) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(param_00.origin, param_06, param_07);
    return;
  } else if(isDefined(param_05) && scripts\cp\cp_weapon::isforgefreezeweapon(param_05) && !var_13 && !var_16) {
    var_2B = param_01 scripts\cp\cp_weapon::get_weapon_level(param_05);
    var_2C = getnumberoffrozenticksfromwave(self, var_2B);
    if(!var_2A && !var_20 && !var_0E && !var_12) {
      var_2D = 10 * level.cash_scalar;
      if(param_01 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        param_01 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_2D = var_2D * 2;
      }

      param_01 scripts\cp\cp_persistence::give_player_currency(var_2D, "large", param_08);
      param_01 notify("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
      if(param_05 == "zfreeze_semtex_mp" || isDefined(self.frozentick) && self.frozentick >= var_2C || var_1C) {
        self.frozentick = undefined;
        self.isfrozen = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
      } else if(isDefined(self.frozentick)) {
        self.frozentick++;
        if(var_2C > 15 && self.frozentick >= 8) {
          self.allowpain = 1;
        }

        if(self.frozentick / var_2C > 0.33) {
          self.slowed = 1;
        }

        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
      } else {
        self.frozentick = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self, var_2B);
      }
    } else if(var_12) {
      if(isDefined(self.frozentick)) {
        self.frozentick++;
      } else {
        self.frozentick = 1;
      }

      if(self.frozentick <= var_2C) {
        return;
      } else {
        param_02 = self.maxhealth;
      }
    } else {
      return;
    }
  } else if(!var_2A && var_16) {
    return;
  } else if(var_29 && !var_0E && !var_0F) {
    if(var_27) {
      param_01 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    param_02 = int(self.maxhealth);
    if(var_22) {
      if(isDefined(param_06)) {
        playFX(level._effect["shock_melee_impact"], param_06);
      }

      param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_22);
    }

    if(var_17) {
      param_01 notify("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
    }
  } else if(!var_0F) {
    param_08 = shitloc_mods(param_01, param_04, param_05, param_08);
    var_2E = level.wave_num;
    var_2F = is_grenade(param_05, param_04);
    var_30 = scripts\engine\utility::istrue(self.is_burning) && !var_17;
    var_31 = var_19 && param_01 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_32 = var_17 && param_01 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_33 = var_17 && param_01 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_34 = var_17 && isDefined(param_01.special_ammo_weapon) && param_01.special_ammo_weapon == param_05;
    var_35 = var_18 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_36 = var_18 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_37 = is_axe_weapon(param_05);
    var_38 = weaponclass(param_05) == "spread" && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "smart");
    var_39 = weaponclass(param_05) == "spread" && !var_38 && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "arkpink") || scripts\cp\cp_weapon::has_attachment(param_05, "arkyellow");
    var_3A = var_19 && var_17 && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "highcal");
    if(var_21 && issubstr(param_05, "+gl")) {
      param_02 = scalegldamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    }

    if(var_38) {
      param_02 = param_02 * 0.5;
    }

    if(isDefined(param_02) && isDefined(param_08) && !var_1C && var_17) {
      var_3B = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_0C, param_01, param_02, param_08, param_07);
      if(var_3B <= 0) {
        return;
      }

      param_02 = var_3B;
    }

    param_02 = initial_weapon_scale(undefined, param_01, param_02, undefined, param_04, param_05, undefined, undefined, param_08, undefined, undefined, undefined);
    if(var_39) {
      param_02 = param_02 * 4;
    }

    if(var_18) {
      if(var_13) {
        if(param_01 scripts\cp\cp_weapon::has_attachment(param_05, "meleervn")) {
          param_02 = param_02 + int(1500 * param_01 scripts\cp\cp_weapon::get_weapon_level(param_05));
        }

        param_02 = int(param_02 * param_01 scripts\cp\perks\perk_utility::perk_getmeleescalar());
        if(isDefined(param_01.passive_melee_kill_damage)) {
          param_02 = param_02 + param_01.passive_melee_kill_damage;
        }

        if(var_36) {
          param_02 = param_02 + 1500;
        }

        var_3C = 0;
        if(param_02 >= self.health) {
          var_3C = 1;
        }

        if(isDefined(param_01.increased_melee_damage)) {
          param_02 = param_02 + param_01.increased_melee_damage;
        }

        if(var_37 || var_36) {
          if(var_37) {
            param_01 notify("axe_melee_hit", param_05, self, param_02);
            if(var_3C && !isDefined(self.launched)) {
              thread launch_and_kill(param_01, param_05, var_36);
              return;
            }
          } else if(var_3C) {
            self.slappymelee = 1;
          }
        } else if(var_3C && param_01.vo_prefix == "p1_") {
          thread func_107E1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
        }
      }

      if(var_34) {
        param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, param_02, param_04, 128);
      }

      if(var_35 && var_1E) {
        param_02 = int(param_02 * 2);
      }
    }

    if(var_31) {
      param_02 = param_02 * 3;
    }

    if(var_32) {
      var_3D = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
      var_3E = weaponclipsize(param_01 getcurrentweapon());
      if(var_3D <= 4) {
        param_02 = param_02 * 2;
      }
    }

    if(var_17 && scripts\engine\utility::istrue(param_01.reload_damage_increase)) {
      param_02 = param_02 * 2;
    }

    if(var_2F) {
      param_02 = param_02 * min(2 + var_2E * 0.5, 10);
    }

    if(var_33) {
      param_02 = int(param_02 * 2);
    }

    if(var_3A) {
      param_02 = param_02 * 1.2;
    }
  }

  if(isDefined(param_01.perk_data) && param_01.perk_data["damagemod"].bullet_damage_scalar == 2 && var_17) {
    param_02 = param_02 * 1.33;
  }

  if(isDefined(level.damage_per_second)) {
    if(!scripts\engine\utility::flag("start_tracking_dps")) {
      scripts\engine\utility::flag_set("start_tracking_dps");
    }

    if(isDefined(level.dpstime)) {
      level.dpstime = gettime();
    }

    if(isDefined(param_01.total_damage)) {
      param_01.total_damage = param_01.total_damage + param_02;
    }
  }

  param_02 = shouldapplycrotchdamagemultiplier(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  param_02 = fateandfortuneweaponscale(self, param_05, param_02, var_0F, var_0E, var_11, var_10);
  if(var_0E) {
    if(isDefined(level.brute_damage_adjustment_func)) {
      param_02 = self[[level.brute_damage_adjustment_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    }
  }

  if(isDefined(param_05) && issubstr(param_05, "arcane") || issubstr(param_05, "ark")) {
    param_02 = param_02 * 1.2;
  }

  if(isDefined(level.onzombiedamage_func)) {
    param_02 = [[level.onzombiedamage_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }

  if(isDefined(param_01.special_zombie_damage) && var_0E || var_0F || var_12) {
    param_02 = param_02 * param_01.special_zombie_damage;
  }

  if(isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_05, 1)) {
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - param_01.origin), anglestoup(self.angles), param_01);
  }

  if(isDefined(self.hitbychargedshot) && !self.health - param_02 < 1) {
    self.hitbychargedshot = undefined;
  }

  param_02 = int(min(param_02, self.maxhealth));
  if(self.health > 0 && self.health - param_02 <= 0) {
    if(self.died_poorly) {
      self.died_poorly_health = self.health;
    }

    if(isDefined(self.has_backpack)) {
      scripts\cp\zombies\zombies_pillage::pillageable_piece_lethal_monitor(self, self.has_backpack, param_01);
    }

    self getrandomhovernodesaroundtargetpos(0, 0);
  }

  if(isplayer(param_01)) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](param_01, param_05, self);
    }

    param_01 notify("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
    param_01 thread updatemaghits(getweaponbasename(param_05));
    if(scripts\engine\utility::isbulletdamage(param_04)) {
      if(!isDefined(param_01.accuracy_shots_on_target)) {
        param_01.accuracy_shots_on_target = 1;
      } else {
        param_01.accuracy_shots_on_target++;
      }

      scripts\cp\cp_persistence::increment_player_career_shots_on_target(param_01);
      scripts\cp\zombies\zombie_analytics::log_playershotsontarget(1, param_01, param_01.accuracy_shots_on_target);
    }

    if(!isDefined(param_01.shotsontargetwithweapon[getweaponbasename(param_05)])) {
      param_01.shotsontargetwithweapon[getweaponbasename(param_05)] = 1;
    } else {
      param_01.shotsontargetwithweapon[getweaponbasename(param_05)]++;
    }
  }

  if(var_19 && var_18 && var_2A) {
    if(isDefined(self.freeze_struct)) {
      self.freeze_struct notify("headcutter_cryo_kill", param_01, self);
    }
  }

  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(param_01, param_02, param_04);
  if(!var_0E) {
    scripts\cp\cp_agent_utils::process_damage_rewards(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  }

  if(!var_0E) {
    scripts\cp\cp_agent_utils::process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  }

  scripts\cp\cp_agent_utils::store_attacker_info(param_01, param_02);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  if(var_18) {
    thread new_enemy_damage_check(param_01);
  }

  if(var_0F) {
    param_02 = greywordamageadjust(param_02, param_05);
  }

  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
}

greywordamageadjust(param_00, param_01) {
  if(isDefined(param_00) && isDefined(param_01)) {
    var_02 = getweaponbasename(param_01);
    if(isDefined(var_02)) {
      if(var_02 == "iw7_headcutter_zm_pap1" || var_02 == "iw7_dischord_zm_pap1" || var_02 == "iw7_facemelter_zm_pap1" || var_02 == "iw7_shredder_zm_pap1") {
        param_00 = param_00 * 1.2;
        param_00 = min(param_00, 20000);
      }
    }
  }

  return int(param_00);
}

scalegldamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = param_01 scripts\cp\cp_weapon::get_weapon_level(param_05);
  var_0D = param_02 / 110;
  if(!isDefined(var_0C)) {
    return param_02;
  }

  if(param_04 != "MOD_GRENADE_SPLASH") {
    return param_02;
  }

  switch (var_0C) {
    case 1:
      return 1000 * var_0D;

    case 2:
      return 1500 * var_0D;

    case 3:
      return 2000 * var_0D;
  }

  return param_02;
}

updatemaghits(param_00) {
  waittillframeend;
  self notify("updateMagShots_" + param_00);
}

getnumberoffrozenticksfromwave(param_00, param_01) {
  return min(int(param_00.maxhealth / 400 / param_01), 10);
}

shouldapplycrotchdamagemultiplier(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(param_01.var_4A9A)) {
    var_0C = "j_crotch";
    if(isDefined(var_0C)) {
      var_0D = self gettagorigin(var_0C);
      var_0E = distance(var_0D, param_06);
      var_0F = 10;
      if(var_0E <= var_0F) {
        param_02 = param_02 * param_01.var_4A9A;
      }
    }
  }

  return param_02;
}

should_do_damage_checks(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_03)) {
    return 0;
  }

  if(isplayer(param_00) && param_00 isinphase()) {
    return 0;
  }

  if(is_axe_weapon(param_03) && param_01 < 10) {
    return 0;
  }

  if(![[level.should_do_damage_check_func]](param_00, param_01, param_02, param_03, param_04, param_05)) {
    return 0;
  }

  return 1;
}

is_grenade(param_00, param_01) {
  var_02 = param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD````_GRENADE";
  return var_02 && param_00 == "throwingknifec4_mp";
}

exploding_touch_fx(param_00) {
  level endon("game_ended");
  triggerfx(self.fx);
  wait(0.5);
  if(isDefined(self.fx)) {
    self.fx delete();
  }
}

onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.spawn_fx)) {
    self.spawn_fx delete();
  }

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(isplayer(param_01) && param_01 scripts\cp\utility::is_consumable_active("explosive_touch")) {
    self.nocorpse = 1;
    self.full_gib = 1;
    if(isDefined(self.body)) {
      self.death_by_exp_touch = 1;
    }
  }

  if(issubstr(param_04, "iw7_knife") && isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_04)) {
    param_01 thread setandunsetmeleekill(param_01);
  } else if((param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") && isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_04)) {
    param_01 thread setandunsetmeleekill(param_01);
  }

  if(isDefined(self.linked_to_boat)) {
    self.linked_to_boat.zombie = undefined;
    self.linked_to_boat = undefined;
  }

  if(!isplayer(param_01)) {
    if(isDefined(param_01.name)) {
      if(param_01.name == param_01.triggerportableradarping.itemtype) {
        if(isDefined(param_01.triggerportableradarping.killswithitem[param_01.triggerportableradarping.itemtype])) {
          param_01.triggerportableradarping.killswithitem[param_01.triggerportableradarping.itemtype]++;
        }
      }
    }
  }

  if(param_04 == "zmb_imsprojectile_mp") {
    for(var_09 = 0; var_09 < level.gascanownercount; var_09++) {
      if(isDefined(level.gascanowner[var_09])) {
        if(level.gascanowner[var_09].itemtype == "crafted_gascan") {
          if(!isDefined(level.gascankills[level.gascanowner[var_09].name])) {
            level.gascankills[level.gascanowner[var_09].name] = 1;
            continue;
          }

          level.gascankills[level.gascanowner[var_09].name]++;
        }
      }
    }
  }

  if(issubstr(param_04, "venomx")) {
    if(scripts\engine\utility::istrue(self.dot_triggered)) {
      self.dot_triggered = undefined;
    }
  }

  if(isplayer(param_01)) {
    if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
      if(isDefined(level.cryptidkillswithvenomx)) {
        if(level.splchosenagent == "cryptids" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom") {
          if(issubstr(param_04, "venomx")) {
            level thread scripts\cp\utility::add_to_notify_queue("venomx_kill", self, self.origin, param_04, param_03);
            level.cryptidkillswithvenomx++;
          }
        }
      }
    } else if(isDefined(level.cryptidkillswithvenomxpap2)) {
      if(level.splchosenagentpap2 == "special.zombies" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "zombie_clown" || self.agent_type == "karatemaster") {
        if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2) {
          level.cryptidkillswithvenomxpap2 = level.chosen_number_for_morse_code_pap2;
        } else if(issubstr(param_04, "venomx")) {
          level thread scripts\cp\utility::add_to_notify_queue("venomx_pap1_kill", self, self.origin, param_04, param_03);
          level.cryptidkillswithvenomxpap2++;
        }
      }
    }

    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      param_01.marked_ents = scripts\engine\utility::array_remove(param_01.marked_ents, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
      param_01 notify("weapon_hit_marked_target", param_01, param_02, param_03, param_04, self);
    }

    if(scripts\engine\utility::istrue(level.sniper_quest_on)) {
      level notify("kill_near_bino_with_sniper", param_01, param_04, self);
    }

    if(isDefined(param_01.weapon_passive_xp_multiplier) && param_01.weapon_passive_xp_multiplier > 1) {
      param_01.kill_with_extra_xp_passive = 1;
    }

    var_0A = (param_03 == "MOD_EXPLOSIVE_BULLET" && isDefined(param_06) && param_06 == "none") || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH";
    if(var_0A) {
      if(!isDefined(param_01.explosive_kills)) {
        param_01.explosive_kills = 1;
      } else {
        param_01.explosive_kills++;
      }

      scripts\cp\cp_persistence::increment_player_career_explosive_kills(param_01);
    }

    param_01.setculldist++;
    param_01.weapon_name_log = scripts\cp\utility::getbaseweaponname(param_04);
    if(!isDefined(param_01.aggregateweaponkills[param_01.weapon_name_log])) {
      param_01.aggregateweaponkills[param_01.weapon_name_log] = 1;
    } else {
      param_01.aggregateweaponkills[param_01.weapon_name_log]++;
    }

    scripts\cp\zombies\zombie_analytics::log_zombiedeath(1, level.wave_num, param_01, param_04, self.agent_type, self.origin);
    if(scripts\engine\utility::isbulletdamage(param_03) && param_04 != "incendiary_ammo_mp" && param_04 != "slayer_ammo_mp") {
      if(isDefined(param_06) && scripts\cp\utility::isheadshot(param_04, param_06, param_03, param_01)) {
        self playsoundtoplayer("zmb_player_achieve_headshot", param_01);
      }
    }

    if(isDefined(param_01.itempicked)) {
      foreach(var_0C in level.powers) {
        if(var_0C.weaponuse == param_04) {
          if(var_0C.weaponuse == param_01.itempicked) {
            if(isDefined(param_01.itemkills[param_01.itempicked])) {
              param_01.itemkills[param_01.itempicked]++;
              continue;
            }

            param_01.itemkills[param_01.itempicked] = 1;
          }
        }
      }
    }
  }

  if(isDefined(param_01.team)) {
    if(param_01.team == "allies") {
      if(!isplayer(param_01)) {
        for(var_09 = 0; var_09 < level.revocatorownercount; var_09++) {
          if(!isDefined(level.revocatorkills[level.revocatorkills[var_09].name])) {
            level.revocatorkills[level.revocatorkills[var_09].name] = 1;
            continue;
          }

          level.revocatorkills[level.revocatorkills[var_09].name]++;
        }
      }
    }
  }

  scripts\cp\zombies\zombie_scriptable_states::turn_off_states_on_death(self);
  if(scripts\engine\utility::flag_exist("force_drop_max_ammo") && scripts\engine\utility::flag("force_drop_max_ammo") && param_03 != "MOD_SUICIDE") {
    if(isDefined(level.drop_max_ammo_func)) {
      level thread[[level.drop_max_ammo_func]](self.origin, param_01, "ammo_max");
    }

    scripts\engine\utility::flag_clear("force_drop_max_ammo");
  }

  var_0E = isDefined(self.agent_type) && self.agent_type == "zombie_brute";
  var_0F = isDefined(self.agent_type) && self.agent_type == "zombie_grey";
  var_10 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(level.updaterecentkills_func) && isplayer(param_01)) {
    param_01 thread[[level.updaterecentkills_func]](self, param_04);
  }

  if(scripts\engine\utility::isbulletdamage(param_03) && getweaponbasename(param_04) == "iw7_atomizer_mp" || scripts\engine\utility::istrue(self.atomize_me)) {
    if(!var_10 && !var_0F && !var_0E) {
      self playSound("bullet_atomizer_impact_npc");
      if(isDefined(self.body)) {
        self.body thread playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isplayer(param_01)) {
    param_01 notify("zombie_killed", self, self.origin, param_04, param_03);
  }

  if(!isonhumanteam(self)) {
    enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    if(isDefined(level.onzombiekilledfunc)) {
      [
        [level.onzombiekilledfunc]
      ](param_01, param_04);
    }
  }

  param_01 scripts\cp\zombies\zombies_consumables::headshot_reload_check(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, self);
  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](param_01, param_04);
  }

  if(isDefined(self.near_medusa) && !isDefined(self.soul_claimed)) {
    self.soul_claimed = 1;
    if(isDefined(param_01.itemtype)) {
      if(param_01.itemtype == "crafted_medusa") {
        if(!isDefined(param_01.killswithitem[param_01.itemtype])) {
          param_01.killswithitem[param_01.itemtype] = 1;
        } else {
          param_01.killswithitem[param_01.itemtype]++;
        }
      }
    }

    level thread[[level.medusa_killed_func]](self.origin, self.near_medusa, scripts\engine\utility::istrue(self.dismember_crawl));
  }

  if(isDefined(self.near_crystal) && !var_10) {
    if(isDefined(level.closest_crystal_func)) {
      var_11 = level[[level.closest_crystal_func]](self);
    } else {
      var_11 = undefined;
    }

    if(isDefined(var_11)) {
      if(isDefined(level.crystal_killed_notify)) {
        thread delayminiufocollection(self.origin, param_04, var_11);
      }
    }
  }

  if(isDefined(level.quest_death_update_func)) {
    level thread[[level.quest_death_update_func]](self);
  }

  if(isplayer(param_01) && isDefined(level.updateonkillpassivesfunc)) {
    level thread[[level.updateonkillpassivesfunc]](param_04, param_01, self, param_03, param_06);
  }

  self hudoutlinedisable();
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  if(isDefined(self.attack_spot)) {
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
  }

  self.closest_entrance = undefined;
  self.attack_spot = undefined;
  self.reached_entrance_goal = undefined;
  self.head_is_exploding = undefined;
  self.rocket_feet = undefined;
  self.dischord_spin = undefined;
  self.upgraded_dischord_spin = undefined;
  self.shredder_death = undefined;
  self.near_medusa = undefined;
  process_kill_rewards(param_00, param_01, self, param_06, param_03, param_04);
  process_assist_rewards(param_01);
  scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(param_01, param_04, param_06, param_03, self.agent_type);
  if(isDefined(level.death_challenge_update_func)) {
    [[level.death_challenge_update_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  } else {
    scripts\cp\cp_challenge::update_death_challenges(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  scripts\cp\cp_merits::process_agent_on_killed_merits(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  param_01 scripts\cp\utility::bufferednotify("kill_event_buffered", param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, self.agent_type);
  scripts\cp\cp_agent_utils::deactivateagent();
  scripts\cp\zombies\zombie_armor::clean_up_zombie_armor(self);
  level notify("zombie_killed", self.origin, param_04, param_03);
}

delayminiufocollection(param_00, param_01, param_02) {
  if(!isDefined(param_02.expected_souls)) {
    return;
  }

  param_02.expected_souls++;
  if(param_02.expected_souls > 1) {
    wait(0.05 * param_02.expected_souls);
  }

  level notify(level.crystal_killed_notify, param_00, param_01, param_02);
}

setandunsetmeleekill(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00.meleekill = 1;
  waittillframeend;
  param_00.meleekill = 0;
}

func_107E1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(param_08 != "neck" && param_08 != "head" && param_08 != "torso_upper") {
    wait(0.35);
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
    return;
  }

  if(randomint(100) > 30) {
    wait(0.35);
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
    return;
  }

  if(scripts\asm\zombie\melee::isenemyinfrontofme(param_01, self.meleedot)) {
    if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey" && self.agent_type != "zombie_clown") {
      self.var_10A57 = 1;
      self setscriptablepartstate("spoon", "active", 1);
      return;
    }

    return;
  }

  wait(0.35);
  playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
}

playbodyfx() {
  var_00[0][0]["org"] = self gettagorigin("j_spineupper");
  var_00[0][0]["angles"] = self gettagangles("j_spineupper");
  var_00[0][1]["org"] = self gettagorigin("j_spinelower");
  var_00[0][1]["angles"] = self gettagangles("j_spinelower");
  var_01 = level._effect["atomize_body"];
  foreach(var_03 in var_00) {
    foreach(var_05 in var_03) {
      playFX(var_01, var_05["org"], anglesToForward(var_05["angles"]));
    }

    wait(0.01);
  }
}

func_FFAB(param_00) {
  switch (param_00.species) {
    case "zombie_grey":
      return 0;

    default:
      return 1;
  }
}

process_kill_rewards(param_00, param_01, param_02, param_03, param_04, param_05) {
  give_attacker_kill_rewards(param_00, param_01, param_03, param_04, param_05);
  var_06 = scripts\cp\cp_agent_utils::get_agent_type(param_02);
  var_07 = scripts\cp\utility::get_attacker_as_player(param_01);
  var_08 = 0;
  var_09 = isDefined(self.has_backpack);
  if(!isDefined(var_06)) {
    return;
  }

  if(isDefined(var_07)) {
    var_0A = 0;
    var_0B = scripts\cp\utility::isheadshot(param_05, param_03, param_04, param_01);
    if(var_0B) {
      var_0A = 1;
      if(!isDefined(var_07.headshots[scripts\cp\utility::getbaseweaponname(param_05)])) {
        var_07.headshots[scripts\cp\utility::getbaseweaponname(param_05)] = 1;
        var_07 scripts\cp\cp_persistence::eog_player_update_stat("headShots", 1);
      } else {
        var_07.headshots[scripts\cp\utility::getbaseweaponname(param_05)]++;
        var_07 scripts\cp\cp_persistence::eog_player_update_stat("headShots", 1);
      }

      var_07.total_match_headshots++;
      if(issubstr(param_05, "dischord")) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_dischord", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(param_05, "facemelter")) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_melter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(param_05, "shredder")) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_shredder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(param_05, "headcutter")) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cutter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(param_05, "harpoon")) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_wonder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(!scripts\cp\utility::is_trap(param_00, param_05, self)) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_headshot", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      }
    } else if(param_05 == "iw7_forgefreeze_zm+forgefreezealtfire" || param_05 == "iw7_forgefreeze_zm" || param_05 == "alt_iw7_forgefreeze_zm+forgefreezealtfire") {
      var_0A = 1;
      var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_freeze", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
    } else if(scripts\cp\utility::getbaseweaponname(param_05) == "iw7_cutie") {
      if(issubstr(param_05, "cutiecrank") ^ issubstr(param_05, "cutiegrip")) {
        if(var_07.vo_prefix == "p5_" || var_07.vo_prefix == "p6_") {
          var_07 thread scripts\cp\cp_vo::try_to_play_vo("ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        } else {
          var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        }
      } else if(issubstr(param_05, "cutiegrip") && issubstr(param_05, "cutiecrank")) {
        if(var_07.vo_prefix == "p5_") {
          var_07 thread scripts\cp\cp_vo::try_to_play_vo("ww_2", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        } else {
          var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_2", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        }
      } else if(var_07.vo_prefix == "p5_" || var_07.vo_prefix == "p6_") {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      }
    }

    if(var_0A == 0) {
      if(randomint(100) > 50) {
        var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
      } else {
        if(isDefined(param_02.voprefix)) {
          if(param_02.voprefix == "zmb_vo_clown_") {
            level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(param_02, "death", 1);
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_clown", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        }

        if(param_02.agent_type == "zombie_cop") {
          if(randomint(100) > 60) {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cop", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(param_02.agent_type == "alien_goon") {
          if(randomint(100) > 60) {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cryptid", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(param_02.agent_type == "zombie_sasquatch") {
          if(randomint(100) > 60) {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_sasquatch", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(param_02.agent_type == "lumberjack") {
          if(randomint(100) > 60) {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_lumberjack", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(param_02.agent_type == "zombie_brute") {
          level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(param_02, "death", 1);
        } else if(param_02.agent_type == "crab_mini") {
          if(randomint(100) > 60) {
            if(var_07.vo_prefix == "p2_") {
              if(!scripts\engine\utility::istrue(var_07.played_vo_goon)) {
                var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon_first", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
                var_07.played_vo_goon = 1;
              } else {
                var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
              }
            } else {
              var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
            }
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(param_02.agent_type == "crab_brute") {
          if(randomint(100) > 60) {
            if(var_07.vo_prefix == "p2_") {
              if(!scripts\engine\utility::istrue(var_07.played_vo_boss)) {
                var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_radactivecrab_first", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
                var_07.played_vo_boss = 1;
              } else {
                var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_radactivecrab", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
              }
            } else {
              var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
            }
          } else {
            var_07 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        }
      }
    }
  }

  if(isDefined(self.is_coaster_zombie)) {
    return;
  }

  if(isDefined(var_07)) {
    scripts\cp\cp_persistence::record_player_kills(param_05, param_03, param_04, var_07);
  }

  if(isDefined(level.zombie_killed_loot_func)) {
    if([
        [level.zombie_killed_loot_func]
      ](var_06, self.origin, param_01)) {
      return;
    }
  }

  if(isDefined(var_07)) {
    if(self isonground()) {
      var_0E = isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey";
      if(gettime() < level.last_drop_time + 5000) {
        return;
      }

      if(scripts\cp\utility::ent_is_near_equipment(self)) {
        return;
      }

      if(scripts\cp\utility::too_close_to_other_interactions(self.origin)) {
        return;
      }

      if(!var_09 && !var_0E) {
        if(scripts\engine\utility::flag_exist("can_drop_coins") && scripts\engine\utility::flag("can_drop_coins") && isDefined(level.crafting_item_drop_func) && scripts\engine\utility::istrue([
            [level.crafting_item_drop_func]
          ](var_06, self.origin, param_01))) {
          level.last_drop_time = gettime();
          return;
        }

        if(isDefined(level.loot_func) && scripts\engine\utility::flag_exist("zombie_drop_powerups") && scripts\engine\utility::flag("zombie_drop_powerups")) {
          [
            [level.loot_func]
          ](var_06, self.origin, param_01);
          return;
        }

        return;
      }
    }
  }
}

process_assist_rewards(param_00) {
  if(!isDefined(self.attacker_damage)) {
    return;
  }

  foreach(var_02 in self.attacker_damage) {
    if(isDefined(var_02.player)) {
      if(var_02.player == param_00) {
        continue;
      } else {
        var_02.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
      }
    }
  }
}

give_attacker_kill_rewards(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    return;
  }

  if(isDefined(param_01.team) && self.team == param_01.team) {
    return;
  }

  var_05 = scripts\mp\mp_agent::get_agent_type(self);
  var_06 = level.agent_definition[var_05]["reward"];
  var_07 = level.agent_definition[var_05]["xp"];
  var_08 = 0;
  var_09 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  var_0A = isDefined(param_04) && param_04 == "incendiary_ammo_mp" || param_04 == "slayer_ammo_mp";
  if(param_01.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar)) {
      var_0B = var_06 * level.cash_scalar + level.consumable_cash_scalar;
    } else {
      var_0B = var_07 * level.cash_scalar;
    }

    foreach(var_0D in level.players) {
      if(!var_0D scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(isDefined(level.zombie_xp)) {
        var_0D scripts\cp\cp_persistence::give_player_xp(int(var_07));
      }

      if(scripts\engine\utility::istrue(level.special_event)) {
        continue;
      }

      var_0E = "large";
      param_02 = "none";
      if(var_05 == "alien_rhino" || scripts\engine\utility::istrue(self.mammoth)) {
        foreach(var_10 in level.players) {
          var_10 scripts\cp\cp_persistence::give_player_currency(var_0B, var_0E, param_02, 1, "crafted");
        }

        continue;
      }

      var_0D scripts\cp\cp_persistence::give_player_currency(var_0B, var_0E, param_02, 1, "crafted");
    }

    return;
  }

  if(!isplayer(var_06) && !isDefined(var_06.triggerportableradarping) || !isplayer(var_06.triggerportableradarping)) {
    return;
  }

  if(isDefined(var_06.triggerportableradarping)) {
    var_06 = var_06.triggerportableradarping;
    var_0D = 1;
  }

  if(!var_12 && var_0A == "generic_zombie" || var_0A == "fast_zombie" || var_0A == "zombie_cop") {
    if(scripts\cp\utility::isheadshot(var_09, var_07, var_08, var_06) && !var_0D && scripts\engine\utility::isbulletdamage(var_08) && !var_0E) {
      var_0B = int(100);
      var_0C = int(75);
    }

    if(isDefined(var_08) && var_08 == "MOD_MELEE" && !issubstr(var_09, "axe")) {
      var_0B = int(130);
      var_0C = int(100);
    }
  }

  if(isplayer(var_06)) {
    var_13 = scripts\cp\utility::get_weapon_variant_id(var_06, var_09);
    if(scripts\cp\utility::ismark2weapon(var_13)) {
      var_0C = var_0C * 1.15;
    }
  }

  if(isDefined(level.kill_reward_func)) {
    var_0B = [[level.kill_reward_func]](var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
  }

  givekillreward(var_05, var_06, var_0B, var_0C, "large", var_07, var_09, var_08, self);
}

checkaltmodestatus(param_00) {
  if(!isDefined(param_00) || param_00 == "none") {
    return 0;
  }

  var_01 = scripts\cp\utility::getbaseweaponname(param_00);
  switch (var_01) {
    case "iw7_m8":
    case "iw7_longshot":
      if(scripts\cp\utility::isaltmodeweapon(param_00)) {
        return 0;
      } else {
        return 1;
      }

      break;

    default:
      return 1;
  }
}

givekillreward(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(level.consumable_cash_scalar)) {
    param_02 = param_02 * level.cash_scalar + level.consumable_cash_scalar;
  } else {
    param_02 = param_02 * level.cash_scalar;
  }

  param_01 thread giveplayerbonuscash(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  if(isDefined(self.shared_damage_points) || func_13C20(param_06)) {
    foreach(var_0A in level.players) {
      if(!var_0A scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(scripts\engine\utility::istrue(level.special_event)) {
        continue;
      }

      var_0A scripts\cp\cp_persistence::give_player_currency(param_02, param_04, param_05, 1, "crafted");
    }
  } else if(should_get_currency_from_kill(param_00, param_01, param_06, param_08)) {
    if(self.agent_type == "alien_rhino" || scripts\engine\utility::istrue(self.mammoth)) {
      foreach(var_0D in level.players) {
        var_0D scripts\cp\cp_persistence::give_player_currency(param_02, param_04, param_05, 1, "crafted");
      }
    } else {
      param_01 scripts\cp\cp_persistence::give_player_currency(param_02, param_04, param_05, 1);
    }
  }

  if(isDefined(level.zombie_xp)) {
    param_01 scripts\cp\cp_persistence::give_player_xp(int(param_03));
  }
}

giveplayerbonuscash(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(should_get_currency_from_kill(param_00, param_01, param_06, param_08)) {
    if(param_01 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(param_07) && param_01 scripts\cp\utility::coop_getweaponclass(param_06) == "weapon_sniper" && checkaltmodestatus(param_06)) {
      var_09 = 300;
      if(param_06 == "iw7_shared_fate_weapon") {
        param_01 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
      } else {
        param_01 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
        param_01 thread delaygivecurrency(var_09, param_04, param_05, "bonus", 0.15);
      }
    }

    if(isplayer(param_01) && isDefined(param_01.cash_scalar)) {
      if(isDefined(param_01.cash_scalar_weapon) && param_01.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(param_06)) {
        var_0A = int(param_02 * param_01.cash_scalar - param_02);
        param_01 thread delaygivecurrency(var_0A, param_04, param_05, "bonus", 0.25);
      }

      if(isDefined(param_01.cash_scalar_alt_weapon) && param_01.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(param_06) && scripts\cp\utility::isstrstart(param_06, "alt") && scripts\engine\utility::istrue(param_01.alt_mode_passive)) {
        var_0A = int(param_02 * param_01.cash_scalar - param_02);
        param_01 thread delaygivecurrency(var_0A, param_04, param_05, "bonus", 0.25);
        return;
      }
    }
  }
}

delaygivecurrency(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  wait(param_04);
  scripts\cp\cp_persistence::give_player_currency(param_00, param_01, param_02, 1, param_03);
}

should_get_currency_from_kill(param_00, param_01, param_02, param_03) {
  if(isplayer(param_01) && scripts\cp\cp_laststand::player_in_laststand(param_01)) {
    return 0;
  }

  if(scripts\cp\utility::is_trap(param_00, param_02, param_03)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.special_event)) {
    return 0;
  }

  return 1;
}

func_13C20(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return param_00 == "alien_sentry_minigun_4_mp" || param_00 == "zmb_imsprojectile_mp";
}

enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level.lastenemydeathpos = self.origin;
  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, self.origin);
  }
}

isonhumanteam(param_00) {
  if(isDefined(param_00.team)) {
    return param_00.team == level.playerteam;
  }

  return 0;
}

shitloc_mods(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00) && isplayer(param_00) && param_01 != "MOD_MELEE" && param_00 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade") && scripts\cp\utility::coop_getweaponclass(param_02) == "weapon_sniper") {
    return "head";
  }

  if(isDefined(param_00) && isplayer(param_00) && param_01 != "MOD_MELEE" && param_00 scripts\cp\utility::is_consumable_active("increased_limb_damage") && is_limb(param_02, param_03, param_01, param_00)) {
    return "torso_upper";
  }

  return param_03;
}

shotgun_scaling(param_00, param_01, param_02) {
  if(isDefined(param_00) && isDefined(param_01) && isDefined(param_02) && weaponclass(param_02) == "spread") {
    var_03 = "" + gettime();
    if(!isDefined(param_00.pelletdmg) || !isDefined(param_00.pelletdmg[var_03])) {
      param_00.pelletdmg = undefined;
      param_00.pelletdmg[var_03] = [];
    }

    if(!isDefined(param_00.pelletdmg[var_03][param_01.guid])) {
      param_00.pelletdmg[var_03][param_01.guid] = 1;
      scripts\engine\utility::waitframe();
      if(param_01.health > 1) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  return 0;
}

initial_weapon_scale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(level.initial_weapon_scale_func)) {
    param_02 = [[level.initial_weapon_scale_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    return param_02;
  }

  if(!can_scale_weapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B)) {
    return param_02;
  }

  var_0C = isDefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey";
  if(isDefined(param_05)) {
    if(isDefined(param_04) && param_04 == "MOD_MELEE") {
      if(isDefined(level.melee_weapons) && scripts\engine\utility::array_contains(level.melee_weapons, getweaponbasename(param_05))) {
        return param_02;
      } else if(issubstr(getweaponbasename(param_05), "rvn")) {
        param_02 = min(self.maxhealth, param_02);
        return param_02;
      }

      if(!is_axe_weapon(param_05) && !is_wyler_dagger(param_05)) {
        param_02 = 150;
      }

      return param_02;
    } else if(param_05 == "alien_sentry_minigun_4_mp") {
      if(var_0C) {
        param_02 = min(int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25)), 2500);
      } else {
        param_02 = int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25));
      }
    }

    return param_02;
  }

  return param_02;
}

fateandfortuneweaponscale(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_01)) {
    return param_02;
  }

  var_07 = getweaponbasename(param_01);
  if(isDefined(var_07)) {
    switch (var_07) {
      case "iw7_steeldragon_mp":
      case "iw7_claw_mp":
        if(param_03 || param_05 || param_06 || param_00 scripts\cp\utility::agentisinstakillimmune()) {
          param_02 = min(max(param_00.maxhealth * 0.34, 300), 1000);
        } else if(param_04) {
          param_02 = min(max(param_00.maxhealth * 0.34, 300), 1000);
        } else {
          param_02 = min(max(param_00.maxhealth, 700), 1000);
        }
        break;

      case "iw7_blackholegun_mp":
        if(param_05 || param_06 || param_00 scripts\cp\utility::agentisinstakillimmune()) {
          param_02 = min(max(param_00.maxhealth * 0.34, 300), 1000);
        } else {
          param_02 = min(param_02 * 10, 2000);
        }
        break;

      case "iw7_atomizer_mp":
      case "iw7_penetrationrail_mp":
        if(param_03 || param_05 || param_06 || param_00 scripts\cp\utility::agentisinstakillimmune()) {
          param_02 = 2500;
        } else if(param_04) {
          param_02 = param_00.maxhealth / 10;
        } else {
          param_02 = param_00.maxhealth;
        }
        break;

      default:
        return param_02;
    }
  }

  return param_02;
}

is_wyler_dagger(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return param_00 == "iw7_wylerdagger_zm";
}

is_axe_weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = getweaponbasename(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  switch (var_01) {
    case "iw6_cphcmelee_mp":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

scale_ww_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(is_non_standard_zombie()) {
    return param_02;
  }

  var_0C = scripts\cp\utility::getrawbaseweaponname(param_05);
  switch (var_0C) {
    case "shredder":
    case "headcutter":
    case "facemelter":
    case "dischord":
      param_02 = 2000;
      break;
  }

  return param_02;
}

func_DDE4(param_00) {
  if(!isDefined(self.recordingenabledcount)) {
    self.recordingenabledcount = 1;
    var_01 = self.health;
    wait(param_00);
    var_02 = self.health;
    var_03 = var_01 - var_02;
    iprintln("damage: " + var_03);
    self.recordingenabledcount = undefined;
  }
}

can_scale_weapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_01.inlaststand)) {
    return 0;
  }

  if(isplayer(param_01) && !isDefined(param_01.pap)) {
    return 0;
  }

  if(!isDefined(param_04)) {
    return 0;
  }

  if(param_04 == "MOD_SUICIDE") {
    return 0;
  }

  if(param_04 == "MOD_UNKNOWN") {
    return 0;
  }

  return 1;
}

set_damage_by_weapon_type(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
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

eligible_for_reward(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isplayer(param_00)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(scripts\cp\cp_laststand::player_in_laststand(param_00))) {
    return 0;
  }

  if(!isDefined(param_02)) {
    return 0;
  }

  if(param_05 < 1) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_04.is_suicide_bomber)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.infinite_ammo) && scripts\engine\utility::isbulletdamage(param_02)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.special_event)) {
    return 0;
  }

  if(isDefined(param_04.agent_type)) {
    if(param_04.agent_type == "zombie_brute") {
      return 0;
    }

    if(param_04.agent_type == "alien_rhino") {
      return 0;
    }
  }

  if(isDefined(param_04.agent_type) && param_04.agent_type == "zombie_brute") {
    return 0;
  }

  if(scripts\cp\utility::is_trap(param_01, param_03, param_04)) {
    return 0;
  }

  if(weaponclass(param_03) == "spread") {
    if(!shotgun_scaling(param_00, param_04, param_03)) {
      return 0;
    }
  }

  if(param_03 == "incendiary_ammo_mp" || param_03 == "slayer_ammo_mp" || param_03 == "iw7_facemelterdummy_zm" || param_03 == "iw7_scrambler_zm" || param_03 == "iw7_entangler2_zm") {
    return 0;
  }

  if(![[level.eligable_for_reward_func]](param_00, param_01, param_02, param_03, param_04, param_05)) {
    return 0;
  }

  switch (param_02) {
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      if(param_03 == "gas_grenade_mp" || param_03 == "splash_grenade_zm" || param_03 == "iw7_venomx_zm") {
        if(isDefined(param_04.flame_damage_time)) {
          if(gettime() > param_04.flame_damage_time) {
            return 1;
          } else {
            return 0;
          }
        }
      }
      return 1;

    case "MOD_UNKNOWN":
      if(scripts\engine\utility::istrue(param_04.is_burning) && isDefined(param_04.flame_damage_time)) {
        if(gettime() > param_04.flame_damage_time) {
          return 1;
        }
      }
      return 0;

    default:
      break;
  }

  if(!scripts\engine\utility::istrue(param_04.is_burning)) {
    return 1;
  }

  if(!scripts\engine\utility::istrue(param_04.marked_for_death)) {
    return 1;
  }

  return 0;
}

onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  var_0D = scripts\cp\utility::is_trap(param_00, param_05, self);
  if((isDefined(param_01) && isDefined(param_04) && scripts\engine\utility::isbulletdamage(param_04) || scripts\cp\utility::player_has_special_ammo(param_01, "combined_ammo") && param_04 == "MOD_EXPLOSIVE_BULLET") || param_05 == "poison_ammo_mp") {
    if(isplayer(param_01) || isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      if(!var_0D) {
        param_01 check_for_special_damage(self, param_00, param_03, param_05, param_04);
      }
    }
  }

  if(isDefined(level.consumable_cash_scalar)) {
    var_0E = 10 * level.cash_scalar + level.consumable_cash_scalar;
  } else {
    var_0E = 10 * level.cash_scalar;
  }

  if(isDefined(param_01)) {
    if(eligible_for_reward(param_01, param_00, param_04, param_05, self, param_02)) {
      var_0F = gettime();
      if(var_0F > param_01.var_BF74 && level.cash_scalar > 1 || param_01 scripts\cp\utility::is_consumable_active("hit_reward_upgrade") || isDefined(level.consumable_cash_scalar)) {
        playfxontagforclients(level._effect["extra_cash_kill"], self, "j_spineupper", param_01);
        param_01.var_BF74 = var_0F + 1000;
      }

      if(param_01 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        param_01 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_10 = int(var_0E * 2 - var_0E);
        param_01 thread delaygivecurrency(var_10, "large", param_08, "bonus", 0.2);
      }

      param_01 scripts\cp\cp_persistence::give_player_currency(var_0E, "large", param_08);
    }
  }
}

check_for_special_damage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00 scripts\cp\utility::is_trap(param_01, param_03, param_00);
  var_06 = param_00 should_do_stun_damage(param_03, param_04, self);
  var_07 = scripts\engine\utility::istrue(param_00.var_9343);
  if(!isDefined(param_00.is_afflicted) && isalive(param_00)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "combined_ammo") || param_03 == "slayer_ammo_mp") {
      var_08 = min(int(param_00.maxhealth * 0.2), 1500);
      param_00 thread scripts\cp\utility::damage_over_time(param_00, self, 5, var_08, param_04, "slayer_ammo_mp", undefined, "combinedArcane");
    }
  }

  if(!isDefined(param_00.is_afflicted) && !isDefined(param_00.is_burning) && isalive(param_00)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || param_03 == "incendiary_ammo_mp") {
      var_08 = min(param_00.maxhealth * 0.1, 1000);
      param_00 thread scripts\cp\utility::damage_over_time(param_00, self, 5, var_08, param_04, "incendiary_ammo_mp", undefined, "burning");
    }
  }

  if(var_06 && !var_05 && !var_07) {
    param_00.stunned = 1;
    param_00 thread fx_stun_damage();
    param_00 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(param_00);
    param_02 = param_02 | level.idflags_stun;
  }
}

fx_stun_damage() {
  self endon("death");
  wait(1);
  self.stunned = undefined;
}

ispendingdeath(param_00) {
  return isDefined(self.pendingdeath) && self.pendingdeath;
}

should_do_stun_damage(param_00, param_01, param_02) {
  if(ispendingdeath()) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "elite_boss") {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.is_burning)) {
    return 0;
  }

  if(isDefined(param_02) && isDefined(param_02.category) && param_02.category == "lightning_tower") {
    return 1;
  }

  if(isDefined(param_02) && isplayer(param_02) && param_01 != "MOD_MELEE") {
    var_03 = isDefined(param_00) && param_00 == param_02 getcurrentprimaryweapon();
    return var_03 && param_02 scripts\cp\utility::has_stun_ammo();
  }

  return 0;
}

zombieshouldenterplayspace() {
  if(self.entered_playspace) {
    return 0;
  }

  if(self.hastraversed || isDefined(self.traversalvector)) {
    return 0;
  }

  if(!isDefined(level.window_entrances)) {
    return 0;
  }

  return 1;
}

getclosestentrance() {
  while(!isDefined(self.closest_entrance)) {
    wait(0.1);
  }

  return self.closest_entrance;
}

func_777C() {
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.entered_playspace = 0;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.battleslid = undefined;
  self.should_play_transformation_anim = undefined;
  self.is_suicide_bomber = undefined;
  self.is_reserved = undefined;
  self.is_coaster_zombie = undefined;
  self.scripted_mode = 0;
  self.is_dancing = 0;
  self.about_to_dance = 0;
  self.is_turned = 0;
  self.melee_damage_amt = undefined;
  self.var_BC4B = undefined;
  self.var_2BE9 = undefined;
  self.var_FFCF = undefined;
  self.marked_for_challenge = undefined;
  self.damaged_players = [];
  self.rocket_feet = undefined;
  self.var_E5D0 = undefined;
  self.var_2BF9 = undefined;
  self.dont_scriptkill = undefined;
  self.soul_claimed = undefined;
  self.var_BF2F = undefined;
  self.has_backpack = undefined;
  self.launched = undefined;
  self.slappymelee = undefined;
  self.var_9B6E = undefined;
  self.var_7387 = undefined;
  self.killedby = undefined;
  self.atomize_me = undefined;
  self.shared_damage_points = undefined;
  if(isDefined(self.var_4D7D)) {
    self.var_4D7D.occupied = 0;
  }

  self.var_4D7D = undefined;
  thread func_117BE();
}

should_attack_nearby_player() {
  var_00 = 50;
  self.closest_player_near_interaction_point = get_closest_player_near_interaction_point(self);
  if(!isDefined(self.closest_player_near_interaction_point)) {
    return 0;
  }

  if(randomint(100) > var_00) {
    return 0;
  }

  return 1;
}

sight_trace_succeed() {
  var_00 = 55;
  var_01 = self.origin + (0, 0, var_00);
  var_02 = self.closest_player_near_interaction_point.origin + (0, 0, var_00);
  return sighttracepassed(var_01, var_02, 0, self);
}

get_closest_player_near_interaction_point(param_00) {
  var_01 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.players)[0];
  var_02 = scripts\engine\utility::getclosest(param_00.origin, level.current_interaction_structs);
  if(!is_player_near_interaction_point(var_01, var_02)) {
    var_01 = undefined;
  }

  return var_01;
}

is_player_near_interaction_point(param_00, param_01) {
  var_02 = 2304;
  return distancesquared(param_00.origin, param_01.origin) < var_02;
}

attack_nearby_player() {
  if(!isDefined(self.attack_spot)) {
    return;
  }

  self.var_FFCF = 1;
  if(isDefined(self.attack_spot.angles)) {
    self.var_2BE9 = self.attack_spot.angles;
  } else {
    self.var_2BE9 = (0, 0, 0);
  }

  for(;;) {
    self waittill("boardbreak", var_00);
    if(var_00[0] == "hit") {
      break;
    }
  }

  self.var_FFCF = 0;
  self.var_2BE9 = undefined;
  var_01 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);
  if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_01)) {
    scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, scripts\asm\zombie\melee::get_melee_damage_dealt(), "MOD_IMPACT");
  }
}

break_barrier_from_entrance(param_00) {
  if(isDefined(self.attack_spot)) {
    if(isDefined(self.attack_spot.angles)) {
      self.var_2BE9 = self.attack_spot.angles;
    } else {
      self.var_2BE9 = (0, 0, 0);
    }
  }

  self.var_FFCF = 1;
  for(;;) {
    self waittill("boardbreak", var_01);
    if(var_01[0] == "hit") {
      break;
    }
  }

  scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(param_00);
  if(!scripts\cp\zombies\zombie_entrances::entrance_has_barriers(param_00)) {
    self.var_FFCF = 0;
    self.curmeleetarget = undefined;
    self.precacheleaderboards = 0;
    self.ignoreme = 0;
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
    self.attack_spot = undefined;
  }
}

func_231C() {
  self endon("death");
  self notify("asmDebug");
  self endon("asmDebug");
  var_00 = (0, 0, 72);
  var_01 = (0, 0, -8);
  for(;;) {
    if(isDefined(self.var_164D)) {
      var_02 = 0;
      foreach(var_04 in self.var_164D) {
        var_05 = var_00 + var_02 * var_01;
        var_02++;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

kill_me_if_stuck() {
  self endon("death");
  if(!isDefined(level.cosine)) {
    level.cosine = [];
  }

  if(!isDefined(level.cosine["60"])) {
    level.cosine["60"] = cos(60);
  }

  var_00 = 0;
  var_01 = self.origin;
  wait(randomintrange(5, 8));
  while(!scripts\engine\utility::istrue(self.entered_playspace)) {
    var_02 = var_01;
    var_01 = self.origin;
    var_03 = 0;
    if(distance2dsquared(var_02, var_01) < 100) {
      foreach(var_05 in level.players) {
        if(distancesquared(var_05.origin, self.origin) < 4000000) {
          if(scripts\engine\utility::within_fov(var_05.origin, var_05.angles, self.origin, level.cosine["60"])) {
            var_06 = var_05 getEye();
            if(scripts\common\trace::ray_trace_passed(var_06, self.origin + (0, 0, 40), self)) {
              var_03 = 1;
            }
          }
        }
      }

      if(var_03) {
        wait(2);
        continue;
      }

      var_00 = 1;
      break;
    } else {
      wait(2);
    }
  }

  if(!var_00) {
    return;
  }

  self.died_poorly = 1;
  if(scripts\engine\utility::istrue(self.marked_for_challenge) && isDefined(level.num_zombies_marked)) {
    level.num_zombies_marked--;
  }

  self dodamage(self.health + 1000, self.origin, self, self, "MOD_SUICIDE");
}

is_limb(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    if(isDefined(param_03.triggerportableradarping)) {
      if(param_03.var_9F == "script_vehicle") {
        return 0;
      }

      if(param_03.var_9F == "misc_turret") {
        return 0;
      }

      if(param_03.var_9F == "script_model") {
        return 0;
      }
    }

    if(isDefined(param_03.agent_type)) {
      if(param_03.agent_type == "dog" || param_03.agent_type == "alien") {
        return 0;
      }
    }
  }

  return param_01 == "left_leg_upper" || param_01 == "right_foot" || param_01 == "left_leg_lower" || param_01 == "right_leg_lower" || param_01 == "left_foot" || param_01 == "right_leg_upper" || param_01 == "right_arm_lower" || param_01 == "left_arm_lower" || param_01 == "right_hand" || param_01 == "left_hand";
}

run_if_last_zombie(param_00) {
  if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths == 1) {
    if(!isDefined(self.var_E821)) {
      if(level.wave_num < 4) {
        self.var_E821 = gettime() + 80000;
      } else {
        self.var_E821 = gettime() - 1;
      }
    }

    if(self.var_E821 < gettime() && isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != "sprint") {
      return "run";
    }
  } else if(level.wave_num > 19 && isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode == "sprint") {
    if(randomint(100) < 5) {
      if(num_fake_walkers() < 3) {
        return "walk";
      }
    }
  }

  return undefined;
}

num_fake_walkers() {
  var_00 = 0;
  foreach(var_02 in level.spawned_enemies) {
    if(isDefined(var_02.asm) && isDefined(var_02.asm.cur_move_mode) && var_02.asm.cur_move_mode == "walk") {
      var_00++;
    }
  }

  return var_00;
}

is_non_standard_zombie() {
  return isDefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey";
}

func_97BA() {
  createthreatbiasgroup("player1");
  createthreatbiasgroup("player2");
  createthreatbiasgroup("player3");
  createthreatbiasgroup("player4");
  createthreatbiasgroup("player1_enemy");
  createthreatbiasgroup("player2_enemy");
  createthreatbiasgroup("player3_enemy");
  createthreatbiasgroup("player4_enemy");
  setthreatbias("player1", "player1_enemy", 10000);
  setthreatbias("player2", "player2_enemy", 10000);
  setthreatbias("player3", "player3_enemy", 10000);
  setthreatbias("player4", "player4_enemy", 10000);
}

func_93EC(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  if(issentient(param_01)) {
    var_02 = param_01 getthreatbiasgroup();
    if(threatbiasgroupexists(var_02 + "_enemy")) {
      param_00 give_zombies_perk(var_02 + "_enemy");
    }

    wait(5);
    param_00 give_zombies_perk();
  }
}

func_117BE() {
  self endon("death");
  var_00 = 100;
  var_01 = 200;
  var_02 = 200;
  var_03 = var_02 * var_02;
  self.var_11366 = 0;
  self.var_A8A1 = 0;
  self.var_BF04 = undefined;
  for(;;) {
    if(isDefined(self.isnodeoccupied)) {
      var_04 = distancesquared(self.origin, self.isnodeoccupied.origin);
      if(isDefined(self.var_BF04)) {
        if(self.var_11366 >= var_01) {
          self.var_11366 = 0;
          func_93EC(self, self.var_BF04);
          wait(0.25);
          continue;
        } else {
          var_05 = distancesquared(self.origin, self.var_BF04.origin);
          if(var_05 < var_03 && var_05 < var_04) {
            self.var_11366 = self.var_11366 + var_00;
            wait(0.25);
            continue;
          } else {
            self.var_11366 = 0;
            var_06 = scripts\engine\utility::array_remove(level.players, self.isnodeoccupied);
            if(var_06.size > 0) {
              var_06 = scripts\engine\utility::array_remove(var_06, self.var_BF04);
            }

            self.var_BF04 = undefined;
            func_3D90(var_04, var_06);
            wait(0.25);
            continue;
          }
        }
      } else {
        self.var_11366 = 0;
        var_06 = scripts\engine\utility::array_remove(level.players, self.isnodeoccupied);
        func_3D90(var_04, var_06);
        wait(0.25);
        continue;
      }
    }

    wait(0.25);
  }
}

func_3D90(param_00, param_01) {
  var_02 = 200;
  var_03 = var_02 * var_02;
  if(param_01.size > 0) {
    foreach(var_05 in param_01) {
      var_06 = distancesquared(self.origin, var_05.origin);
      if(var_06 < var_03 && var_06 < param_00) {
        self.var_BF04 = var_05;
      }
    }
  }
}

new_enemy_damage_check(param_00) {
  if(!isDefined(self.var_A8A1)) {
    self.var_A8A1 = 0;
  }

  var_01 = 100;
  if(isDefined(self.isnodeoccupied)) {
    if(param_00 == self.isnodeoccupied) {
      self.var_A8A1 = gettime();
      return;
    }

    var_02 = gettime();
    if(var_02 - self.var_A8A1 > 5000) {
      if(isDefined(self.var_BF04)) {
        if(param_00 == self.var_BF04) {
          self.var_11366 = self.var_11366 + var_01;
          return;
        }

        return;
      }

      self.var_BF04 = param_00;
      self.var_11366 = 0;
      return;
    }
  }
}

func_3759(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  thread impale(param_00, self, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

impale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(level.harpoon_impale_additional_func)) {
    [[level.harpoon_impale_additional_func]](param_02, param_00, param_01, param_04, param_05, param_06, param_07, param_08);
    return;
  }

  param_01 giverankxp();
  var_09 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_0A = param_04 + param_05 * 4096;
  var_0B = scripts\common\trace::ray_trace_detail(param_04, var_0A, undefined, var_09, undefined, 1);
  var_0A = var_0B["position"] - param_05 * 12;
  var_0C = length(var_0A - param_04);
  var_0D = var_0C / 1250;
  var_0D = clamp(var_0D, 0.05, 1);
  wait(0.05);
  var_0E = param_05;
  var_0F = anglestoup(param_00.angles);
  var_10 = vectorcross(var_0E, var_0F);
  var_11 = scripts\engine\utility::spawn_tag_origin(param_04, axistoangles(var_0E, var_10, var_0F));
  var_11 moveto(var_0A, var_0D);
  var_12 = spawnragdollconstraint(param_01, param_06, param_07, param_08);
  var_12.origin = var_11.origin;
  var_12.angles = var_11.angles;
  var_12 linkto(var_11);
  thread impale_cleanup(param_01, var_11, var_0D + 0.05, var_12);
}

impale_cleanup(param_00, param_01, param_02, param_03) {
  param_00 scripts\engine\utility::waittill_any_timeout_1(param_02, "death", "disconnect");
  param_03 delete();
  param_01 delete();
}

launch_and_kill(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("disconnect");
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  self.launched = 1;
  if(randomint(100) > 50 && !isDefined(self.is_suicide_bomber)) {
    self.nocorpse = undefined;
    var_03 = 50;
    var_04 = 50;
    if(param_02) {
      var_03 = 300;
      var_04 = 150;
    }

    self setvelocity(vectornormalize(self.origin - param_00.origin) * var_03 + (0, 0, var_04));
    wait(0.1);
  } else {
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self dodamage(self.health + 1000, param_00.origin, param_00, param_00, "MOD_MELEE");
}

func_B982() {
  scripts\engine\utility::flag_init("player_count_determined");
  var_00 = getdvar("party_partyPlayerCountNum");
  if(var_00 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait(1);
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}