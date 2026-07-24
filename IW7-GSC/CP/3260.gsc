/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3260.gsc
**************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  level thread _id_B982();

  if(!scripts\engine\utility::is_true(level.generic_zombie_agent_func_init_done)) {
    level.agent_funcs["generic_zombie"]["on_damaged"] = ::onzombiedamaged;
    level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
    level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::onzombiekilled;
    level.generic_zombie_agent_func_init_done = 1;
  }

  level.agent_funcs["zombie_brute"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["zombie_brute"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["zombie_brute"]["gametype_on_killed"] = ::onzombiekilled;
  level.callbackplayerimpaled = ::_id_3759;
  level.agent_funcs["c6"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["c6"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["c6"]["gametype_on_killed"] = ::onzombiekilled;
  level.agent_funcs["the_hoff"]["on_damaged"] = ::onhoffdamaged;
  level.agent_funcs["the_hoff"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["the_hoff"]["gametype_on_killed"] = ::onzombiekilled;
  level._id_768B = ::_id_777C;
  level.in_room_check_func = scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.fnzombieshouldenterplayspace = ::zombieshouldenterplayspace;
  level.movemodefunc["generic_zombie"] = ::run_if_last_zombie;

  if(!isDefined(level.eligable_for_reward_func)) {
    level.eligable_for_reward_func = ::base_eligable_for_reward_func;
  }

  if(!isDefined(level.should_do_damage_check_func)) {
    level.should_do_damage_check_func = ::base_should_do_damage_check;
  }

  level.last_drop_time = gettime();
  level.frozenzombiefunc = scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  level thread _id_97BA();
  level._id_7089 = ::get_closest_player_near_interaction_point;
  level.fn_get_closest_entrance = scripts\cp\utility::get_closest_entrance;
  level.no_pain_volume = getEnt("no_pain_volume", "targetname");
}

base_eligable_for_reward_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 1;
}

base_should_do_damage_check(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 1;
}

onhoffdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(!isDefined(self.agent_type)) {
    return;
  }
  if(var_4 != "MOD_SUICIDE") {
    if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_1)) {
      return;
    }
    if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_13 = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_12);

  if(!var_13) {
    return;
  }
  var_3 = var_3 | 4;
  var_14 = isDefined(var_12.agent_type) && var_12.agent_type == "zombie_brute";
  var_15 = isDefined(var_12.agent_type) && var_12.agent_type == "zombie_grey";
  var_16 = isDefined(var_12.agent_type) && var_12.agent_type == "slasher";
  var_17 = isDefined(var_12.agent_type) && var_12.agent_type == "superslasher";
  var_18 = scripts\engine\utility::is_true(var_12.is_suicide_bomber);
  var_19 = var_4 == "MOD_MELEE";
  var_20 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_21 = isDefined(self.isfrozen) && isDefined(var_5) && (!scripts\cp\cp_weapon::isforgefreezeweapon(var_5) || var_4 == "MOD_MELEE");
  var_22 = scripts\cp\cp_weapon::isaltforgefreezeweapon(var_5);
  var_23 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_24 = isDefined(var_1) && isPlayer(var_1);
  var_25 = var_23 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_26 = (var_1 scripts\cp\cp_weapon::has_attachment(var_5, "overclock") || var_1 scripts\cp\cp_weapon::has_attachment(var_5, "overclockcp")) && var_23;
  var_27 = scripts\engine\utility::is_true(self.battleslid);
  var_28 = scripts\engine\utility::is_true(level.insta_kill) && !var_14 && !var_15;
  var_29 = !var_20 && var_25 && var_23 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_30 = var_4 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_31 = var_19 && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_32 = scripts\engine\utility::is_true(self.immune_against_freeze);
  var_33 = scripts\cp\utility::isaltmodeweapon(var_5);
  var_34 = var_19 && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");

  if(isDefined(var_5) && issubstr(var_5, "iw7_gauss_zml")) {
    var_35 = 250;

    if(scripts\cp\utility::weaponhasattachment(var_5, "pap1")) {
      var_35 = 470;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "pap2")) {
      var_35 = 734;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "doubletap")) {
      var_35 = 1.33 * var_35;
    }

    if(var_2 >= var_35) {
      self.hitbychargedshot = var_1;
    }
  }

  if(isPlayer(var_1)) {
    if(scripts\engine\utility::is_true(self.marked_shared_fate_fnf)) {
      var_1 notify("weapon_hit_marked_target", var_1, var_2, var_4, var_5, self);
    }

    if(issubstr(var_5, "iw7_harpoon2_zm")) {
      var_1 notify("zombie_hit_by_ben", var_6, self, self.maxhealth);
    }
  }

  if(var_24) {
    self.damaged_by_player = 1;

    if(scripts\engine\utility::is_true(var_1.stimulus_active)) {
      playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
      scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", self gettagorigin("j_spineupper"));

      foreach(var_37 in level.players) {
        if(var_37 == var_1) {
          if(distance2dsquared(var_37.origin, self.origin) <= 10000) {
            playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
            playFX(level._effect["stimulus_shield"], var_37 gettagorigin("tag_eye"), anglesToForward(var_37.angles), anglestoup(var_37.angles), var_37);

            if(var_2 >= self.health) {
              if(scripts\engine\utility::is_true(var_37.inlaststand)) {
                scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_37);
              }
            }

            if(var_37.health + var_2 / (level.players.size + 1) >= var_37.maxhealth) {
              var_37.health = var_37.maxhealth;
            } else {
              var_37.health = int(var_37.health + var_2 / (level.players.size + 1));
            }
          }

          continue;
        }

        if(distance2dsquared(var_37.origin, self.origin) <= 10000) {
          playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
          playFX(level._effect["stimulus_shield"], var_37 gettagorigin("tag_eye"));

          if(var_2 >= self.health) {
            if(scripts\engine\utility::is_true(var_37.inlaststand)) {
              scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_37);
            }
          }

          if(int(var_37.health + var_2 / (level.players.size + 1)) >= var_37.maxhealth) {
            var_37.health = var_37.maxhealth;
            continue;
          }

          var_37.health = int(var_37.health + var_2 / (level.players.size + 1));
        }
      }
    }

    if(scripts\engine\utility::is_true(var_1.deadeye_charge)) {
      var_2 = var_2 * 1.25;
    }
  }

  if(isDefined(var_1.is_turned) && var_1.is_turned && var_4 != "MOD_SUICIDE") {
    if(var_14) {
      var_2 = int(var_2 * 1.5);
    } else {
      var_2 = var_1.melee_damage_amt;
    }
  }

  var_39 = 0;

  if(!var_19 && checkaltmodestatus(var_5) && var_24 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_39 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
  }

  var_40 = scripts\engine\utility::is_true(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";

  if(var_40 && (var_15 || var_14)) {
    return;
  }
  var_41 = !var_14 && !var_15 && (var_27 || var_28 || var_34 || var_40 || var_21 || var_26 || var_29 || var_31 || var_39);
  var_42 = isDefined(self.isfrozen);

  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(var_5) && !var_14 && !var_15) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(var_0.origin, var_6, var_7);
    return;
  } else if(isDefined(var_5) && scripts\cp\cp_weapon::isforgefreezeweapon(var_5) && !var_19 && !var_22) {
    var_43 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_5);
    var_44 = getnumberoffrozenticksfromwave(self, var_43);

    if(!var_42 && !var_32 && !var_14 && !var_18) {
      var_45 = 10 * level.cash_scalar;

      if(var_1 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        var_1 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_45 = var_45 * 2;
      }

      var_1 scripts\cp\cp_persistence::give_player_currency(var_45, "large", var_8);
      var_1 notify("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);

      if(var_5 == "zfreeze_semtex_mp" || isDefined(self.frozentick) && self.frozentick >= var_44 || var_28) {
        self.frozentick = undefined;
        self.isfrozen = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
      } else if(isDefined(self.frozentick)) {
        self.frozentick++;

        if(var_44 > 15 && self.frozentick >= 8) {
          self.allowpain = 1;
        }

        if(self.frozentick / var_44 > 0.33) {
          self.slowed = 1;
        }

        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
      } else {
        self.frozentick = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self, var_43);
      }
    } else if(var_18) {
      if(isDefined(self.frozentick)) {
        self.frozentick++;
      } else {
        self.frozentick = 1;
      }

      if(self.frozentick <= var_44) {
        return;
      } else {
        var_2 = self.maxhealth;
      }
    } else
      return;
  } else if(!var_42 && var_22)
    return;
  else if(var_41 && !var_14 && !var_15) {
    if(var_39) {
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    var_2 = int(self.maxhealth);

    if(var_34) {
      if(isDefined(var_6)) {
        playFX(level._effect["shock_melee_impact"], var_6);
      }

      var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_34);
    }

    if(var_23) {
      var_1 notify("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    }
  } else if(!var_15) {
    var_8 = shitloc_mods(var_1, var_4, var_5, var_8);
    var_46 = level.wave_num;
    var_47 = is_grenade(var_5, var_4);
    var_48 = scripts\engine\utility::is_true(self.is_burning) && !var_23;
    var_49 = var_25 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_50 = var_23 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_51 = var_23 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_52 = var_23 && isDefined(var_1.special_ammo_weapon) && var_1.special_ammo_weapon == var_5;
    var_53 = var_24 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_54 = var_24 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_55 = is_axe_weapon(var_5);
    var_56 = weaponclass(var_5) == "spread" && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "smart");
    var_57 = weaponclass(var_5) == "spread" && !var_56 && (var_1 scripts\cp\cp_weapon::has_attachment(var_5, "arkpink") || scripts\cp\cp_weapon::has_attachment(var_5, "arkyellow"));
    var_58 = var_25 && var_23 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "highcal");

    if(var_33 && issubstr(var_5, "+gl")) {
      var_2 = scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(var_56) {
      var_2 = var_2 * 0.5;
    }

    if(isDefined(var_2) && isDefined(var_8) && !var_28 && var_23) {
      var_59 = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_12, var_1, var_2, var_8, var_7);

      if(var_59 <= 0) {
        return;
      }
      var_2 = var_59;
    }

    var_2 = initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);

    if(var_57) {
      var_2 = var_2 * 4;
    }

    if(var_24) {
      if(var_19) {
        if(var_1 scripts\cp\cp_weapon::has_attachment(var_5, "meleervn")) {
          var_2 = var_2 + int(1500 * var_1 scripts\cp\cp_weapon::get_weapon_level(var_5));
        }

        var_2 = int(var_2 * var_1 scripts\cp\perks\perk_utility::perk_getmeleescalar());

        if(isDefined(var_1.passive_melee_kill_damage)) {
          var_2 = var_2 + var_1.passive_melee_kill_damage;
        }

        if(var_54) {
          var_2 = var_2 + 1500;
        }

        var_60 = 0;

        if(var_2 >= self.health) {
          var_60 = 1;
        }

        if(isDefined(var_1.increased_melee_damage)) {
          var_2 = var_2 + var_1.increased_melee_damage;
        }

        if(var_55 || var_54) {
          if(var_55) {
            var_1 notify("axe_melee_hit", var_5, self, var_2);

            if(var_60 && !isDefined(self.launched)) {
              thread launch_and_kill(var_1, var_5, var_54);
              return;
            }
          } else if(var_60)
            self.slappymelee = 1;
        } else if(var_60 && var_1.vo_prefix == "p1_")
          thread _id_107E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      }

      if(var_52) {
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, var_2, var_4, 128);
      }

      if(var_53 && var_30) {
        var_2 = int(var_2 * 2);
      }
    }

    if(var_49) {
      var_2 = var_2 * 3.0;
    }

    if(var_50) {
      var_61 = int(var_1 getweaponammoclip(var_1 getcurrentweapon()) + 1);
      var_62 = weaponclipsize(var_1 getcurrentweapon());

      if(var_61 <= 4) {
        var_2 = var_2 * 2;
      }
    }

    if(var_23 && scripts\engine\utility::is_true(var_1.reload_damage_increase)) {
      var_2 = var_2 * 2;
    }

    if(var_47) {
      var_2 = var_2 * min(2 + var_46 * 0.5, 10);
    }

    if(var_51) {
      var_2 = int(var_2 * 2);
    }

    if(var_58) {
      var_2 = var_2 * 1.2;
    }
  }

  if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2.0 && var_23) {
    var_2 = var_2 * 1.33;
  }

  if(isDefined(level.damage_per_second)) {
    if(!scripts\engine\utility::flag("start_tracking_dps")) {
      scripts\engine\utility::flag_set("start_tracking_dps");
    }

    if(isDefined(level.dpstime)) {
      level.dpstime = gettime();
    }

    if(isDefined(var_1.total_damage)) {
      var_1.total_damage = var_1.total_damage + var_2;
    }
  }

  var_2 = shouldapplycrotchdamagemultiplier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_2 = fateandfortuneweaponscale(self, var_5, var_2, var_15, var_14, var_17, var_16);

  if(var_14) {
    if(isDefined(level.brute_damage_adjustment_func)) {
      var_2 = self[[level.brute_damage_adjustment_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }

  if(isDefined(var_5) && (issubstr(var_5, "arcane") || issubstr(var_5, "ark"))) {
    var_2 = var_2 * 1.2;
  }

  if(isDefined(level.onzombiedamage_func)) {
    var_2 = [[level.onzombiedamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(isDefined(var_1.special_zombie_damage) && (var_14 || var_15 || var_18)) {
    var_2 = var_2 * var_1.special_zombie_damage;
  }

  if(isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_5, 1)) {
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - var_1.origin), anglestoup(self.angles), var_1);
  }

  if(isDefined(self.hitbychargedshot) && !(self.health - var_2 < 1)) {
    self.hitbychargedshot = undefined;
  }

  var_2 = int(min(var_2, self.maxhealth));

  if(self.health > 0 && self.health - var_2 <= 0) {
    if(self.died_poorly) {
      self.died_poorly_health = self.health;
    }

    if(isDefined(self.has_backpack)) {
      scripts\cp\zombies\zombies_pillage::pillageable_piece_lethal_monitor(self, self.has_backpack, var_1);
    }

    self emissiveblend(0, 0);
  }

  if(isPlayer(var_1)) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);
    }

    var_1 notify("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread updatemaghits(getweaponbasename(var_5));

    if(scripts\engine\utility::isbulletdamage(var_4)) {
      if(!isDefined(var_1.accuracy_shots_on_target)) {
        var_1.accuracy_shots_on_target = 1;
      } else {
        var_1.accuracy_shots_on_target++;
      }

      scripts\cp\cp_persistence::increment_player_career_shots_on_target(var_1);
      scripts\cp\zombies\zombie_analytics::log_playershotsontarget(1, var_1, var_1.accuracy_shots_on_target);
    }

    if(!isDefined(var_1.shotsontargetwithweapon[getweaponbasename(var_5)])) {
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)] = 1;
    } else {
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)]++;
    }
  }

  if(var_25 && var_24 && var_42) {
    if(isDefined(self.freeze_struct)) {
      self.freeze_struct notify("headcutter_cryo_kill", var_1, self);
    }
  }

  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(var_1, var_2, var_4);

  if(!var_14) {
    scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  }

  if(!var_14) {
    scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  }

  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(var_24) {
    thread new_enemy_damage_check(var_1);
  }

  if(var_15) {
    var_2 = greywordamageadjust(var_2, var_5);
  }

  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

greywordamageadjust(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getweaponbasename(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "iw7_headcutter_zm_pap1" || var_2 == "iw7_dischord_zm_pap1" || var_2 == "iw7_facemelter_zm_pap1" || var_2 == "iw7_shredder_zm_pap1") {
        var_0 = var_0 * 1.2;
        var_0 = min(var_0, 20000);
      }
    }
  }

  return int(var_0);
}

scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_5);
  var_13 = var_2 / 110;

  if(!isDefined(var_12)) {
    return var_2;
  }

  if(var_4 != "MOD_GRENADE_SPLASH") {
    return var_2;
  }

  switch (var_12) {
    case 1:
      return 1000 * var_13;
    case 2:
      return 1500 * var_13;
    case 3:
      return 2000 * var_13;
  }

  return var_2;
}

updatemaghits(var_0) {
  waittillframeend;
  self notify("updateMagShots_" + var_0);
}

getnumberoffrozenticksfromwave(var_0, var_1) {
  return min(int(var_0.maxhealth / 400 / var_1), 10);
}

shouldapplycrotchdamagemultiplier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1._id_4A9A)) {
    var_12 = "j_crotch";

    if(isDefined(var_12)) {
      var_13 = self gettagorigin(var_12);
      var_14 = distance(var_13, var_6);
      var_15 = 10;

      if(var_14 <= var_15) {
        var_2 = var_2 * var_1._id_4A9A;
      }
    }
  }

  return var_2;
}

should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return 0;
  }

  if(isPlayer(var_0) && var_0 isinphase()) {
    return 0;
  }

  if(is_axe_weapon(var_3) && var_1 < 10) {
    return 0;
  }

  if(![[level.should_do_damage_check_func]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return 0;
  }

  return 1;
}

is_grenade(var_0, var_1) {
  var_2 = var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD````_GRENADE";
  return var_2 && var_0 == "throwingknifec4_mp";
}

exploding_touch_fx(var_0) {
  level endon("game_ended");
  triggerfx(self.fx);
  wait 0.5;

  if(isDefined(self.fx)) {
    self.fx delete();
  }
}

onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.spawn_fx)) {
    self.spawn_fx delete();
  }

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(isPlayer(var_1) && var_1 scripts\cp\utility::is_consumable_active("explosive_touch")) {
    self.nocorpse = 1;
    self.full_gib = 1;

    if(isDefined(self.body)) {
      self.death_by_exp_touch = 1;
    }
  }

  if(issubstr(var_4, "iw7_knife") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread setandunsetmeleekill(var_1);
  } else if((var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread setandunsetmeleekill(var_1);
  }

  if(isDefined(self.linked_to_boat)) {
    self.linked_to_boat.zombie = undefined;
    self.linked_to_boat = undefined;
  }

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.name)) {
      if(var_1.name == var_1.owner.itemtype) {
        if(isDefined(var_1.owner.killswithitem[var_1.owner.itemtype])) {
          var_1.owner.killswithitem[var_1.owner.itemtype]++;
        }
      }
    }
  }

  if(var_4 == "zmb_imsprojectile_mp") {
    for(var_9 = 0; var_9 < level.gascanownercount; var_9++) {
      if(isDefined(level.gascanowner[var_9])) {
        if(level.gascanowner[var_9].itemtype == "crafted_gascan") {
          if(!isDefined(level.gascankills[level.gascanowner[var_9].name])) {
            level.gascankills[level.gascanowner[var_9].name] = 1;
            continue;
          }

          level.gascankills[level.gascanowner[var_9].name]++;
        }
      }
    }
  }

  if(issubstr(var_4, "venomx")) {
    if(scripts\engine\utility::is_true(self.dot_triggered)) {
      self.dot_triggered = undefined;
    }
  }

  if(isPlayer(var_1)) {
    if(!scripts\engine\utility::is_true(level.completed_venomx_pap1_challenges)) {
      if(isDefined(level.cryptidkillswithvenomx)) {
        if(level.splchosenagent == "cryptids" && (self.agent_type == "alien_goon" || self.agent_type == "alien_phantom")) {
          if(issubstr(var_4, "venomx")) {
            level thread scripts\cp\utility::add_to_notify_queue("venomx_kill", self, self.origin, var_4, var_3);
            level.cryptidkillswithvenomx++;
          }
        }
      }
    } else if(isDefined(level.cryptidkillswithvenomxpap2)) {
      if(level.splchosenagentpap2 == "special.zombies" && (self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "zombie_clown" || self.agent_type == "karatemaster")) {
        if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2) {
          level.cryptidkillswithvenomxpap2 = level.chosen_number_for_morse_code_pap2;
        } else if(issubstr(var_4, "venomx")) {
          level thread scripts\cp\utility::add_to_notify_queue("venomx_pap1_kill", self, self.origin, var_4, var_3);
          level.cryptidkillswithvenomxpap2++;
        }
      }
    }

    if(scripts\engine\utility::is_true(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      var_1.marked_ents = scripts\engine\utility::array_remove(var_1.marked_ents, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
      var_1 notify("weapon_hit_marked_target", var_1, var_2, var_3, var_4, self);
    }

    if(scripts\engine\utility::is_true(level.sniper_quest_on)) {
      level notify("kill_near_bino_with_sniper", var_1, var_4, self);
    }

    if(isDefined(var_1.weapon_passive_xp_multiplier) && var_1.weapon_passive_xp_multiplier > 1) {
      var_1.kill_with_extra_xp_passive = 1;
    }

    var_10 = var_3 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_6) && var_6 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";

    if(var_10) {
      if(!isDefined(var_1.explosive_kills)) {
        var_1.explosive_kills = 1;
      } else {
        var_1.explosive_kills++;
      }

      scripts\cp\cp_persistence::increment_player_career_explosive_kills(var_1);
    }

    var_1.kills++;
    var_1.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_4);

    if(!isDefined(var_1.aggregateweaponkills[var_1.weapon_name_log])) {
      var_1.aggregateweaponkills[var_1.weapon_name_log] = 1;
    } else {
      var_1.aggregateweaponkills[var_1.weapon_name_log]++;
    }

    scripts\cp\zombies\zombie_analytics::log_zombiedeath(1, level.wave_num, var_1, var_4, self.agent_type, self.origin);

    if(scripts\engine\utility::isbulletdamage(var_3) && var_4 != "incendiary_ammo_mp" && var_4 != "slayer_ammo_mp") {
      if(isDefined(var_6) && scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1)) {
        self playsoundtoplayer("zmb_player_achieve_headshot", var_1);
      }
    }

    if(isDefined(var_1.itempicked)) {
      foreach(var_12 in level.powers) {
        if(var_12.weaponuse == var_4) {
          if(var_12.weaponuse == var_1.itempicked) {
            if(isDefined(var_1.itemkills[var_1.itempicked])) {
              var_1.itemkills[var_1.itempicked]++;
              continue;
            }

            var_1.itemkills[var_1.itempicked] = 1;
          }
        }
      }
    }
  }

  if(isDefined(var_1.team)) {
    if(var_1.team == "allies") {
      if(!isPlayer(var_1)) {
        for(var_9 = 0; var_9 < level.revocatorownercount; var_9++) {
          if(!isDefined(level.revocatorkills[level.revocatorkills[var_9].name])) {
            level.revocatorkills[level.revocatorkills[var_9].name] = 1;
            continue;
          }

          level.revocatorkills[level.revocatorkills[var_9].name]++;
        }
      }
    }
  }

  scripts\cp\zombies\zombie_scriptable_states::turn_off_states_on_death(self);

  if(scripts\engine\utility::flag_exist("force_drop_max_ammo") && scripts\engine\utility::flag("force_drop_max_ammo") && var_3 != "MOD_SUICIDE") {
    if(isDefined(level.drop_max_ammo_func)) {
      level thread[[level.drop_max_ammo_func]](self.origin, var_1, "ammo_max");
    }

    scripts\engine\utility::flag_clear("force_drop_max_ammo");
  }

  var_14 = isDefined(self.agent_type) && self.agent_type == "zombie_brute";
  var_15 = isDefined(self.agent_type) && self.agent_type == "zombie_grey";
  var_16 = scripts\engine\utility::is_true(self.is_suicide_bomber);

  if(isDefined(level.updaterecentkills_func) && isPlayer(var_1)) {
    var_1 thread[[level.updaterecentkills_func]](self, var_4);
  }

  if(scripts\engine\utility::isbulletdamage(var_3) && (getweaponbasename(var_4) == "iw7_atomizer_mp" || scripts\engine\utility::is_true(self.atomize_me))) {
    if(!var_16 && !var_15 && !var_14) {
      self playSound("bullet_atomizer_impact_npc");

      if(isDefined(self.body)) {
        self.body thread playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 notify("zombie_killed", self, self.origin, var_4, var_3);
  }

  if(!isonhumanteam(self)) {
    enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(level.onzombiekilledfunc)) {
      [[level.onzombiekilledfunc]](var_1, var_4);
    }
  }

  var_1 scripts\cp\zombies\zombies_consumables::headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, self);

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](var_1, var_4);
  }

  if(isDefined(self.near_medusa) && !isDefined(self.soul_claimed)) {
    self.soul_claimed = 1;

    if(isDefined(var_1.itemtype)) {
      if(var_1.itemtype == "crafted_medusa") {
        if(!isDefined(var_1.killswithitem[var_1.itemtype])) {
          var_1.killswithitem[var_1.itemtype] = 1;
        } else {
          var_1.killswithitem[var_1.itemtype]++;
        }
      }
    }

    level thread[[level.medusa_killed_func]](self.origin, self.near_medusa, scripts\engine\utility::is_true(self.dismember_crawl));
  }

  if(isDefined(self.near_crystal) && !var_16) {
    if(isDefined(level.closest_crystal_func)) {
      var_17 = level[[level.closest_crystal_func]](self);
    } else {
      var_17 = undefined;
    }

    if(isDefined(var_17)) {
      if(isDefined(level.crystal_killed_notify)) {
        thread delayminiufocollection(self.origin, var_4, var_17);
      }
    }
  }

  if(isDefined(level.quest_death_update_func)) {
    level thread[[level.quest_death_update_func]](self);
  }

  if(isPlayer(var_1) && isDefined(level.updateonkillpassivesfunc)) {
    level thread[[level.updateonkillpassivesfunc]](var_4, var_1, self, var_3, var_6);
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
  process_kill_rewards(var_0, var_1, self, var_6, var_3, var_4);
  process_assist_rewards(var_1);
  scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(var_1, var_4, var_6, var_3, self.agent_type);

  if(isDefined(level.death_challenge_update_func)) {
    [[level.death_challenge_update_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_1 scripts\cp\utility::bufferednotify("kill_event_buffered", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, self.agent_type);
  scripts\cp\cp_agent_utils::deactivateagent();
  scripts\cp\zombies\zombie_armor::clean_up_zombie_armor(self);
  level notify("zombie_killed", self.origin, var_4, var_3);
}

delayminiufocollection(var_0, var_1, var_2) {
  if(!isDefined(var_2.expected_souls)) {
    return;
  }
  var_2.expected_souls++;

  if(var_2.expected_souls > 1) {
    wait(0.05 * var_2.expected_souls);
  }

  level notify(level.crystal_killed_notify, var_0, var_1, var_2);
}

setandunsetmeleekill(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.meleekill = 1;
  waittillframeend;
  var_0.meleekill = 0;
}

_id_107E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_8 != "neck" && var_8 != "head" && var_8 != "torso_upper") {
    wait 0.35;
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
  } else {
    if(randomint(100) > 30) {
      wait 0.35;
      playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
      return;
    }

    if(scripts\asm\zombie\melee::isenemyinfrontofme(var_1, self.meleedot)) {
      if(isDefined(self.agent_type) && (self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey" && self.agent_type != "zombie_clown")) {
        self._id_10A57 = 1;
        self setscriptablepartstate("spoon", "active", 1);
        return;
      }

      return;
    }

    wait 0.35;
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
  }
}

playbodyfx() {
  var_0[0][0]["org"] = self gettagorigin("j_spineupper");
  var_0[0][0]["angles"] = self gettagangles("j_spineupper");
  var_0[0][1]["org"] = self gettagorigin("j_spinelower");
  var_0[0][1]["angles"] = self gettagangles("j_spinelower");
  var_1 = level._effect["atomize_body"];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3) {
      playFX(var_1, var_5["org"], anglesToForward(var_5["angles"]));
    }

    wait 0.01;
  }
}

_id_FFAB(var_0) {
  switch (var_0.species) {
    case "zombie_grey":
      return 0;
    default:
      return 1;
  }
}

process_kill_rewards(var_0, var_1, var_2, var_3, var_4, var_5) {
  give_attacker_kill_rewards(var_0, var_1, var_3, var_4, var_5);
  var_6 = scripts\cp\cp_agent_utils::get_agent_type(var_2);
  var_7 = scripts\cp\utility::get_attacker_as_player(var_1);
  var_8 = 0;
  var_9 = isDefined(self.has_backpack);

  if(!isDefined(var_6)) {
    return;
  }
  if(isDefined(var_7)) {
    var_10 = 0;
    var_11 = scripts\cp\utility::isheadshot(var_5, var_3, var_4, var_1);

    if(var_11) {
      var_10 = 1;

      if(!isDefined(var_7.headshots[scripts\cp\utility::getbaseweaponname(var_5)])) {
        var_7.headshots[scripts\cp\utility::getbaseweaponname(var_5)] = 1;
        var_7 scripts\cp\cp_persistence::eog_player_update_stat("headShots", 1);
      } else {
        var_7.headshots[scripts\cp\utility::getbaseweaponname(var_5)]++;
        var_7 scripts\cp\cp_persistence::eog_player_update_stat("headShots", 1);
      }

      var_7.total_match_headshots++;

      if(issubstr(var_5, "dischord")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_dischord", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5, "facemelter")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_melter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5, "shredder")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_shredder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5, "headcutter")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cutter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5, "harpoon")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_wonder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(!scripts\cp\utility::is_trap(var_0, var_5, self)) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_headshot", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      }
    } else if(var_5 == "iw7_forgefreeze_zm+forgefreezealtfire" || var_5 == "iw7_forgefreeze_zm" || var_5 == "alt_iw7_forgefreeze_zm+forgefreezealtfire") {
      var_10 = 1;
      var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_freeze", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
    } else if(scripts\cp\utility::getbaseweaponname(var_5) == "iw7_cutie") {
      if(issubstr(var_5, "cutiecrank") ^ issubstr(var_5, "cutiegrip")) {
        if(var_7.vo_prefix == "p5_" || var_7.vo_prefix == "p6_") {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        } else {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        }
      } else if(issubstr(var_5, "cutiegrip") && issubstr(var_5, "cutiecrank")) {
        if(var_7.vo_prefix == "p5_") {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("ww_2", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        } else {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_2", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
        }
      } else if(var_7.vo_prefix == "p5_" || var_7.vo_prefix == "p6_")
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      else {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_1", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      }
    }

    if(var_10 == 0) {
      if(randomint(100) > 50) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
      } else {
        if(isDefined(var_2.voprefix)) {
          if(var_2.voprefix == "zmb_vo_clown_") {
            level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_2, "death", 1);
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_clown", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        }

        if(var_2.agent_type == "zombie_cop") {
          if(randomint(100) > 60) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cop", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(var_2.agent_type == "alien_goon") {
          if(randomint(100) > 60) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_cryptid", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(var_2.agent_type == "zombie_sasquatch") {
          if(randomint(100) > 60) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_sasquatch", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(var_2.agent_type == "lumberjack") {
          if(randomint(100) > 60) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_lumberjack", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          }
        } else if(var_2.agent_type == "zombie_brute")
          level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_2, "death", 1);
        else if(var_2.agent_type == "crab_mini") {
          if(randomint(100) > 60) {
            if(var_7.vo_prefix == "p2_") {
              if(!scripts\engine\utility::is_true(var_7.played_vo_goon)) {
                var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon_first", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
                var_7.played_vo_goon = 1;
              } else
                var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
            } else
              var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_crabgoon", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
          } else
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        } else if(var_2.agent_type == "crab_brute") {
          if(randomint(100) > 60) {
            if(var_7.vo_prefix == "p2_") {
              if(!scripts\engine\utility::is_true(var_7.played_vo_boss)) {
                var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_radactivecrab_first", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
                var_7.played_vo_boss = 1;
              } else
                var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_radactivecrab", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
            } else
              var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
          } else
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      }
    }
  }

  if(isDefined(self.is_coaster_zombie)) {
    return;
  }
  if(isDefined(var_7)) {
    scripts\cp\cp_persistence::record_player_kills(var_5, var_3, var_4, var_7);
  }

  if(isDefined(level.zombie_killed_loot_func)) {
    if([[level.zombie_killed_loot_func]](var_6, self.origin, var_1)) {
      return;
    }
  }

  if(isDefined(var_7)) {
    if(self isonground()) {
      var_14 = isDefined(var_2.agent_type) && (var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey");

      if(gettime() < level.last_drop_time + 5000) {
        return;
      }
      if(scripts\cp\utility::ent_is_near_equipment(self)) {
        return;
      }
      if(scripts\cp\utility::too_close_to_other_interactions(self.origin)) {
        return;
      }
      if(!var_9 && !var_14) {
        if(scripts\engine\utility::flag_exist("can_drop_coins") && scripts\engine\utility::flag("can_drop_coins") && isDefined(level.crafting_item_drop_func) && scripts\engine\utility::is_true([[level.crafting_item_drop_func]](var_6, self.origin, var_1))) {
          level.last_drop_time = gettime();
          return;
        } else if(isDefined(level.loot_func) && scripts\engine\utility::flag_exist("zombie_drop_powerups") && scripts\engine\utility::flag("zombie_drop_powerups"))
          [[level.loot_func]](var_6, self.origin, var_1);
      }
    }
  }
}

process_assist_rewards(var_0) {
  if(!isDefined(self.attacker_damage)) {
    return;
  }
  foreach(var_2 in self.attacker_damage) {
    if(isDefined(var_2.player)) {
      if(var_2.player == var_0) {
        continue;
      } else {
        var_2.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
      }
    }
  }
}

give_attacker_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_1.team) && self.team == var_1.team) {
    return;
  }
  var_5 = scripts\mp\mp_agent::get_agent_type(self);
  var_6 = level.agent_definition[var_5]["reward"];
  var_7 = level.agent_definition[var_5]["xp"];
  var_8 = 0;
  var_9 = scripts\engine\utility::is_true(self.is_suicide_bomber);
  var_10 = isDefined(var_4) && (var_4 == "incendiary_ammo_mp" || var_4 == "slayer_ammo_mp");

  if(var_1.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar)) {
      var_11 = var_6 * (level.cash_scalar + level.consumable_cash_scalar);
    } else {
      var_11 = var_6 * level.cash_scalar;
    }

    foreach(var_13 in level.players) {
      if(!var_13 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(isDefined(level.zombie_xp)) {
        var_13 scripts\cp\cp_persistence::give_player_xp(int(var_7));
      }

      if(scripts\engine\utility::is_true(level.special_event)) {
        continue;
      }
      var_14 = "large";
      var_2 = "none";

      if(var_5 == "alien_rhino" || scripts\engine\utility::is_true(self.mammoth)) {
        foreach(var_16 in level.players) {
          var_16 scripts\cp\cp_persistence::give_player_currency(var_11, var_14, var_2, 1, "crafted");
        }

        continue;
      }

      var_13 scripts\cp\cp_persistence::give_player_currency(var_11, var_14, var_2, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
    return;
  }
  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
    var_8 = 1;
  }

  if(!var_10 && (var_5 == "generic_zombie" || var_5 == "fast_zombie" || var_5 == "zombie_cop")) {
    if(scripts\cp\utility::isheadshot(var_4, var_2, var_3, var_1) && !var_8 && scripts\engine\utility::isbulletdamage(var_3) && !var_9) {
      var_6 = int(100);
      var_7 = int(75);
    }

    if(isDefined(var_3) && var_3 == "MOD_MELEE" && !issubstr(var_4, "axe")) {
      var_6 = int(130);
      var_7 = int(100);
    }
  }

  if(isPlayer(var_1)) {
    var_19 = scripts\cp\utility::get_weapon_variant_id(var_1, var_4);

    if(scripts\cp\utility::ismark2weapon(var_19)) {
      var_7 = var_7 * 1.15;
    }
  }

  if(isDefined(level.kill_reward_func)) {
    var_6 = [[level.kill_reward_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }

  givekillreward(var_0, var_1, var_6, var_7, "large", var_2, var_4, var_3, self);
}

checkaltmodestatus(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = scripts\cp\utility::getbaseweaponname(var_0);

  switch (var_1) {
    case "iw7_m8":
    case "iw7_longshot":
      if(scripts\cp\utility::isaltmodeweapon(var_0)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

givekillreward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.consumable_cash_scalar)) {
    var_2 = var_2 * (level.cash_scalar + level.consumable_cash_scalar);
  } else {
    var_2 = var_2 * level.cash_scalar;
  }

  var_1 thread giveplayerbonuscash(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(self.shared_damage_points) || _id_13C20(var_6)) {
    foreach(var_10 in level.players) {
      if(!var_10 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(scripts\engine\utility::is_true(level.special_event)) {
        continue;
      }
      var_10 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1, "crafted");
    }
  } else if(should_get_currency_from_kill(var_0, var_1, var_6, var_8)) {
    if(self.agent_type == "alien_rhino" || scripts\engine\utility::is_true(self.mammoth)) {
      foreach(var_13 in level.players) {
        var_13 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1, "crafted");
      }
    } else
      var_1 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1);
  }

  if(isDefined(level.zombie_xp)) {
    var_1 scripts\cp\cp_persistence::give_player_xp(int(var_3));
  }
}

giveplayerbonuscash(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(should_get_currency_from_kill(var_0, var_1, var_6, var_8)) {
    if(var_1 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(var_7) && var_1 scripts\cp\utility::coop_getweaponclass(var_6) == "weapon_sniper" && checkaltmodestatus(var_6)) {
      var_9 = 300;

      if(var_6 == "iw7_shared_fate_weapon") {
        var_1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
      } else {
        var_1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
        var_1 thread delaygivecurrency(var_9, var_4, var_5, "bonus", 0.15);
      }
    }

    if(isPlayer(var_1) && isDefined(var_1.cash_scalar)) {
      if(isDefined(var_1.cash_scalar_weapon) && var_1.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(var_6)) {
        var_10 = int(var_2 * var_1.cash_scalar - var_2);
        var_1 thread delaygivecurrency(var_10, var_4, var_5, "bonus", 0.25);
      }

      if(isDefined(var_1.cash_scalar_alt_weapon) && var_1.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(var_6) && scripts\cp\utility::isstrstart(var_6, "alt") && scripts\engine\utility::is_true(var_1.alt_mode_passive)) {
        var_10 = int(var_2 * var_1.cash_scalar - var_2);
        var_1 thread delaygivecurrency(var_10, var_4, var_5, "bonus", 0.25);
      }
    }
  }
}

delaygivecurrency(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  wait(var_4);
  scripts\cp\cp_persistence::give_player_currency(var_0, var_1, var_2, 1, var_3);
}

should_get_currency_from_kill(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_1) && scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    return 0;
  }

  if(scripts\cp\utility::is_trap(var_0, var_2, var_3)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(level.special_event)) {
    return 0;
  }

  return 1;
}

_id_13C20(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "alien_sentry_minigun_4_mp" || var_0 == "zmb_imsprojectile_mp";
}

enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.lastenemydeathpos = self.origin;

  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, self.origin);
  }
}

isonhumanteam(var_0) {
  if(isDefined(var_0.team)) {
    return var_0.team == level.playerteam;
  }

  return 0;
}

shitloc_mods(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade") && scripts\cp\utility::coop_getweaponclass(var_2) == "weapon_sniper") {
    return "head";
  }

  if(isDefined(var_0) && isPlayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::is_consumable_active("increased_limb_damage") && is_limb(var_2, var_3, var_1, var_0)) {
    return "torso_upper";
  }

  return var_3;
}

shotgun_scaling(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && weaponclass(var_2) == "spread") {
    var_3 = "" + gettime();

    if(!isDefined(var_0.pelletdmg) || !isDefined(var_0.pelletdmg[var_3])) {
      var_0.pelletdmg = undefined;
      var_0.pelletdmg[var_3] = [];
    }

    if(!isDefined(var_0.pelletdmg[var_3][var_1.guid])) {
      var_0.pelletdmg[var_3][var_1.guid] = 1;
      scripts\engine\utility::waitframe();

      if(var_1.health > 1) {
        return 1;
      } else {
        return 0;
      }
    } else
      return 0;
  }

  return 0;
}

initial_weapon_scale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(level.initial_weapon_scale_func)) {
    var_2 = [[level.initial_weapon_scale_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    return var_2;
  }

  if(!can_scale_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    return var_2;
  }

  var_12 = isDefined(self.agent_type) && (self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey");

  if(isDefined(var_5)) {
    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      if(isDefined(level.melee_weapons) && scripts\engine\utility::array_contains(level.melee_weapons, getweaponbasename(var_5))) {
        return var_2;
      } else if(issubstr(getweaponbasename(var_5), "rvn")) {
        var_2 = min(self.maxhealth, var_2);
        return var_2;
      }

      if(!is_axe_weapon(var_5) && !is_wyler_dagger(var_5)) {
        var_2 = 150;
      }

      return var_2;
    } else if(var_5 == "alien_sentry_minigun_4_mp") {
      if(var_12) {
        var_2 = min(int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25)), 2500);
      } else {
        var_2 = int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25));
      }
    }

    return var_2;
  }

  return var_2;
}

fateandfortuneweaponscale(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1)) {
    return var_2;
  }

  var_7 = getweaponbasename(var_1);

  if(isDefined(var_7)) {
    switch (var_7) {
      case "iw7_steeldragon_mp":
      case "iw7_claw_mp":
        if(var_3 || var_5 || var_6 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        } else if(var_4) {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        } else {
          var_2 = min(max(var_0.maxhealth, 700), 1000);
        }

        break;
      case "iw7_blackholegun_mp":
        if(var_5 || var_6 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        } else {
          var_2 = min(var_2 * 10, 2000);
        }

        break;
      case "iw7_atomizer_mp":
      case "iw7_penetrationrail_mp":
        if(var_3 || var_5 || var_6 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = 2500;
        } else if(var_4) {
          var_2 = var_0.maxhealth / 10;
        } else {
          var_2 = var_0.maxhealth;
        }

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

is_wyler_dagger(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "iw7_wylerdagger_zm";
}

is_axe_weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  switch (var_1) {
    case "iw6_cphcmelee_mp":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

scale_ww_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(is_non_standard_zombie()) {
    return var_2;
  }

  var_12 = scripts\cp\utility::getrawbaseweaponname(var_5);

  switch (var_12) {
    case "shredder":
    case "dischord":
    case "headcutter":
    case "facemelter":
      var_2 = 2000;
  }

  return var_2;
}

_id_DDE4(var_0) {
  if(!isDefined(self.recordingenabledcount)) {
    self.recordingenabledcount = 1;
    var_1 = self.health;
    wait(var_0);
    var_2 = self.health;
    var_3 = var_1 - var_2;
    iprintln("damage: " + var_3);
    self.recordingenabledcount = undefined;
  }
}

can_scale_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_1.inlaststand)) {
    return 0;
  }

  if(isPlayer(var_1) && !isDefined(var_1.pap)) {
    return 0;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  if(var_4 == "MOD_SUICIDE") {
    return 0;
  }

  if(var_4 == "MOD_UNKNOWN") {
    return 0;
  }

  return 1;
}

set_damage_by_weapon_type(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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

eligible_for_reward(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(scripts\cp\cp_laststand::player_in_laststand(var_0))) {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_5 < 1) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_4.is_suicide_bomber)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(level.infinite_ammo) && scripts\engine\utility::isbulletdamage(var_2)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(level.special_event)) {
    return 0;
  }

  if(isDefined(var_4.agent_type)) {
    if(var_4.agent_type == "zombie_brute") {
      return 0;
    }

    if(var_4.agent_type == "alien_rhino") {
      return 0;
    }
  }

  if(isDefined(var_4.agent_type) && var_4.agent_type == "zombie_brute") {
    return 0;
  }

  if(scripts\cp\utility::is_trap(var_1, var_3, var_4)) {
    return 0;
  }

  if(weaponclass(var_3) == "spread") {
    if(!shotgun_scaling(var_0, var_4, var_3)) {
      return 0;
    }
  }

  if(var_3 == "incendiary_ammo_mp" || var_3 == "slayer_ammo_mp" || var_3 == "iw7_facemelterdummy_zm" || var_3 == "iw7_scrambler_zm" || var_3 == "iw7_entangler2_zm") {
    return 0;
  }

  if(![[level.eligable_for_reward_func]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return 0;
  }

  switch (var_2) {
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      if(var_3 == "gas_grenade_mp" || var_3 == "splash_grenade_zm" || var_3 == "iw7_venomx_zm") {
        if(isDefined(var_4.flame_damage_time)) {
          if(gettime() > var_4.flame_damage_time) {
            return 1;
          } else {
            return 0;
          }
        }
      }

      return 1;
    case "MOD_UNKNOWN":
      if(scripts\engine\utility::is_true(var_4.is_burning) && isDefined(var_4.flame_damage_time)) {
        if(gettime() > var_4.flame_damage_time) {
          return 1;
        }
      }

      return 0;
    default:
      break;
  }

  if(!scripts\engine\utility::is_true(var_4.is_burning)) {
    return 1;
  }

  if(!scripts\engine\utility::is_true(var_4.marked_for_death)) {
    return 1;
  }

  return 0;
}

onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = scripts\cp\utility::is_trap(var_0, var_5, self);

  if(isDefined(var_1) && isDefined(var_4) && (scripts\engine\utility::isbulletdamage(var_4) || scripts\cp\utility::player_has_special_ammo(var_1, "combined_ammo") && var_4 == "MOD_EXPLOSIVE_BULLET") || var_5 == "poison_ammo_mp") {
    if(isPlayer(var_1) || isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      if(!var_13) {
        var_1 check_for_special_damage(self, var_0, var_3, var_5, var_4);
      }
    }
  }

  if(isDefined(level.consumable_cash_scalar)) {
    var_14 = 10 * (level.cash_scalar + level.consumable_cash_scalar);
  } else {
    var_14 = 10 * level.cash_scalar;
  }

  if(isDefined(var_1)) {
    if(eligible_for_reward(var_1, var_0, var_4, var_5, self, var_2)) {
      var_15 = gettime();

      if(var_15 > var_1._id_BF74 && (level.cash_scalar > 1 || var_1 scripts\cp\utility::is_consumable_active("hit_reward_upgrade") || isDefined(level.consumable_cash_scalar))) {
        playfxontagforclients(level._effect["extra_cash_kill"], self, "j_spineupper", var_1);
        var_1._id_BF74 = var_15 + 1000;
      }

      if(var_1 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        var_1 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_16 = int(var_14 * 2 - var_14);
        var_1 thread delaygivecurrency(var_16, "large", var_8, "bonus", 0.2);
      }

      var_1 scripts\cp\cp_persistence::give_player_currency(var_14, "large", var_8);
    }
  }
}

check_for_special_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 scripts\cp\utility::is_trap(var_1, var_3, var_0);
  var_6 = var_0 should_do_stun_damage(var_3, var_4, self);
  var_7 = scripts\engine\utility::is_true(var_0._id_9343);

  if(!isDefined(var_0.is_afflicted) && isalive(var_0)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "combined_ammo") || var_3 == "slayer_ammo_mp") {
      var_8 = min(int(var_0.maxhealth * 0.2), 1500);
      var_0 thread scripts\cp\utility::damage_over_time(var_0, self, 5, var_8, var_4, "slayer_ammo_mp", undefined, "combinedArcane");
    }
  }

  if(!isDefined(var_0.is_afflicted) && !isDefined(var_0.is_burning) && isalive(var_0)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || var_3 == "incendiary_ammo_mp") {
      var_8 = min(var_0.maxhealth * 0.1, 1000);
      var_0 thread scripts\cp\utility::damage_over_time(var_0, self, 5, var_8, var_4, "incendiary_ammo_mp", undefined, "burning");
    }
  }

  if(var_6 && !var_5 && !var_7) {
    var_0.stunned = 1;
    var_0 thread fx_stun_damage();
    var_0 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(var_0);
    var_2 = var_2 | level.idflags_stun;
  }
}

fx_stun_damage() {
  self endon("death");
  wait 1;
  self.stunned = undefined;
}

ispendingdeath(var_0) {
  return isDefined(self.pendingdeath) && self.pendingdeath;
}

should_do_stun_damage(var_0, var_1, var_2) {
  if(ispendingdeath()) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "elite_boss") {
    return 0;
  }

  if(scripts\engine\utility::is_true(self.is_burning)) {
    return 0;
  }

  if(isDefined(var_2) && isDefined(var_2.category) && var_2.category == "lightning_tower") {
    return 1;
  }

  if(isDefined(var_2) && isPlayer(var_2) && var_1 != "MOD_MELEE") {
    var_3 = isDefined(var_0) && var_0 == var_2 getcurrentprimaryweapon();
    return var_3 && var_2 scripts\cp\utility::has_stun_ammo();
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
    wait 0.1;
  }

  return self.closest_entrance;
}

_id_777C() {
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
  self._id_BC4B = undefined;
  self._id_2BE9 = undefined;
  self._id_FFCF = undefined;
  self.marked_for_challenge = undefined;
  self.damaged_players = [];
  self.rocket_feet = undefined;
  self._id_E5D0 = undefined;
  self._id_2BF9 = undefined;
  self.dont_scriptkill = undefined;
  self.soul_claimed = undefined;
  self._id_BF2F = undefined;
  self.has_backpack = undefined;
  self.launched = undefined;
  self.slappymelee = undefined;
  self._id_9B6E = undefined;
  self._id_7387 = undefined;
  self.killedby = undefined;
  self.atomize_me = undefined;
  self.shared_damage_points = undefined;

  if(isDefined(self._id_4D7D)) {
    self._id_4D7D.occupied = 0;
  }

  self._id_4D7D = undefined;
  thread _id_117BE();
}

should_attack_nearby_player() {
  var_0 = 50;
  self.closest_player_near_interaction_point = get_closest_player_near_interaction_point(self);

  if(!isDefined(self.closest_player_near_interaction_point)) {
    return 0;
  }

  if(randomint(100) > var_0) {
    return 0;
  }

  return 1;
}

sight_trace_succeed() {
  var_0 = 55;
  var_1 = self.origin + (0, 0, var_0);
  var_2 = self.closest_player_near_interaction_point.origin + (0, 0, var_0);
  return sighttracepassed(var_1, var_2, 0, self);
}

get_closest_player_near_interaction_point(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players)[0];
  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.current_interaction_structs);

  if(!is_player_near_interaction_point(var_1, var_2)) {
    var_1 = undefined;
  }

  return var_1;
}

is_player_near_interaction_point(var_0, var_1) {
  var_2 = 2304;
  return distancesquared(var_0.origin, var_1.origin) < var_2;
}

attack_nearby_player() {
  if(!isDefined(self.attack_spot)) {
    return;
  }
  self._id_FFCF = 1;

  if(isDefined(self.attack_spot.angles)) {
    self._id_2BE9 = self.attack_spot.angles;
  } else {
    self._id_2BE9 = (0, 0, 0);
  }

  for(;;) {
    self waittill("boardbreak", var_0);

    if(var_0[0] == "hit") {
      break;
    }
  }

  self._id_FFCF = 0;
  self._id_2BE9 = undefined;
  var_1 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);

  if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_1)) {
    scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, scripts\asm\zombie\melee::get_melee_damage_dealt(), "MOD_IMPACT");
  }
}

break_barrier_from_entrance(var_0) {
  if(isDefined(self.attack_spot)) {
    if(isDefined(self.attack_spot.angles)) {
      self._id_2BE9 = self.attack_spot.angles;
    } else {
      self._id_2BE9 = (0, 0, 0);
    }
  }

  self._id_FFCF = 1;

  for(;;) {
    self waittill("boardbreak", var_1);

    if(var_1[0] == "hit") {
      break;
    }
  }

  scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(var_0);

  if(!scripts\cp\zombies\zombie_entrances::entrance_has_barriers(var_0)) {
    self._id_FFCF = 0;
    self.curmeleetarget = undefined;
    self.ignoreall = 0;
    self.ignoreme = 0;
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
    self.attack_spot = undefined;
  }
}

_id_231C() {
  self endon("death");
  self notify("asmDebug");
  self endon("asmDebug");
  var_0 = (0, 0, 72);
  var_1 = (0, 0, -8);

  for(;;) {
    if(isDefined(self._id_164D)) {
      var_2 = 0;

      foreach(var_6, var_4 in self._id_164D) {
        var_5 = var_0 + var_2 * var_1;
        var_2++;
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

  var_0 = 0;
  var_1 = self.origin;
  wait(randomintrange(5, 8));

  while(!scripts\engine\utility::is_true(self.entered_playspace)) {
    var_2 = var_1;
    var_1 = self.origin;
    var_3 = 0;

    if(distance2dsquared(var_2, var_1) < 100) {
      foreach(var_5 in level.players) {
        if(distancesquared(var_5.origin, self.origin) < 4000000) {
          if(scripts\engine\utility::within_fov(var_5.origin, var_5.angles, self.origin, level.cosine["60"])) {
            var_6 = var_5 getEye();

            if(scripts\common\trace::ray_trace_passed(var_6, self.origin + (0, 0, 40), self)) {
              var_3 = 1;
            }
          }
        }
      }

      if(var_3) {
        wait 2;
        continue;
      }

      var_0 = 1;
      break;
    } else
      wait 2;
  }

  if(!var_0) {
    return;
  }
  self.died_poorly = 1;

  if(scripts\engine\utility::is_true(self.marked_for_challenge) && isDefined(level.num_zombies_marked)) {
    level.num_zombies_marked--;
  }

  self dodamage(self.health + 1000, self.origin, self, self, "MOD_SUICIDE");
}

is_limb(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle") {
        return 0;
      }

      if(var_3.code_classname == "misc_turret") {
        return 0;
      }

      if(var_3.code_classname == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien") {
        return 0;
      }
    }
  }

  return var_1 == "left_leg_upper" || var_1 == "right_foot" || var_1 == "left_leg_lower" || var_1 == "right_leg_lower" || var_1 == "left_foot" || var_1 == "right_leg_upper" || var_1 == "right_arm_lower" || var_1 == "left_arm_lower" || var_1 == "right_hand" || var_1 == "left_hand";
}

run_if_last_zombie(var_0) {
  if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths == 1) {
    if(!isDefined(self._id_E821)) {
      if(level.wave_num < 4) {
        self._id_E821 = gettime() + 80000;
      } else {
        self._id_E821 = gettime() - 1;
      }
    }

    if(self._id_E821 < gettime() && isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != "sprint") {
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
  var_0 = 0;

  foreach(var_2 in level.spawned_enemies) {
    if(isDefined(var_2.asm) && isDefined(var_2.asm.cur_move_mode) && var_2.asm.cur_move_mode == "walk") {
      var_0++;
    }
  }

  return var_0;
}

is_non_standard_zombie() {
  return isDefined(self.agent_type) && (self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey");
}

_id_97BA() {
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

_id_93EC(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  if(issentient(var_1)) {
    var_2 = var_1 getthreatbiasgroup();

    if(threatbiasgroupexists(var_2 + "_enemy")) {
      var_0 setthreatbiasgroup(var_2 + "_enemy");
    }

    wait 5;
    var_0 setthreatbiasgroup();
  }
}

_id_117BE() {
  self endon("death");
  var_0 = 100;
  var_1 = 200;
  var_2 = 200;
  var_3 = var_2 * var_2;
  self._id_11366 = 0;
  self._id_A8A1 = 0;
  self._id_BF04 = undefined;

  for(;;) {
    if(isDefined(self.enemy)) {
      var_4 = distancesquared(self.origin, self.enemy.origin);

      if(isDefined(self._id_BF04)) {
        if(self._id_11366 >= var_1) {
          self._id_11366 = 0;
          _id_93EC(self, self._id_BF04);
          wait 0.25;
          continue;
        } else {
          var_5 = distancesquared(self.origin, self._id_BF04.origin);

          if(var_5 < var_3 && var_5 < var_4) {
            self._id_11366 = self._id_11366 + var_0;
            wait 0.25;
            continue;
          } else {
            self._id_11366 = 0;
            var_6 = scripts\engine\utility::array_remove(level.players, self.enemy);

            if(var_6.size > 0) {
              var_6 = scripts\engine\utility::array_remove(var_6, self._id_BF04);
            }

            self._id_BF04 = undefined;
            _id_3D90(var_4, var_6);
            wait 0.25;
            continue;
          }
        }
      } else {
        self._id_11366 = 0;
        var_6 = scripts\engine\utility::array_remove(level.players, self.enemy);
        _id_3D90(var_4, var_6);
        wait 0.25;
        continue;
      }
    }

    wait 0.25;
  }
}

_id_3D90(var_0, var_1) {
  var_2 = 200;
  var_3 = var_2 * var_2;

  if(var_1.size > 0) {
    foreach(var_5 in var_1) {
      var_6 = distancesquared(self.origin, var_5.origin);

      if(var_6 < var_3 && var_6 < var_0) {
        self._id_BF04 = var_5;
      }
    }
  }
}

new_enemy_damage_check(var_0) {
  if(!isDefined(self._id_A8A1)) {
    self._id_A8A1 = 0;
  }

  var_1 = 100;

  if(isDefined(self.enemy)) {
    if(var_0 == self.enemy) {
      self._id_A8A1 = gettime();
    } else {
      var_2 = gettime();

      if(var_2 - self._id_A8A1 > 5000) {
        if(isDefined(self._id_BF04)) {
          if(var_0 == self._id_BF04) {
            self._id_11366 = self._id_11366 + var_1;
          }
        } else {
          self._id_BF04 = var_0;
          self._id_11366 = 0;
        }
      }
    }
  }
}

_id_3759(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.harpoon_impale_additional_func)) {
    [[level.harpoon_impale_additional_func]](var_2, var_0, var_1, var_4, var_5, var_6, var_7, var_8);
  } else {
    var_1 startragdoll();
    var_9 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
    var_10 = var_4 + var_5 * 4096;
    var_11 = scripts\common\trace::ray_trace_detail(var_4, var_10, undefined, var_9, undefined, 1);
    var_10 = var_11["position"] - var_5 * 12;
    var_12 = length(var_10 - var_4);
    var_13 = var_12 / 1250;
    var_13 = clamp(var_13, 0.05, 1);
    wait 0.05;
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = vectorcross(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_14, var_16, var_15));
    var_17 moveTo(var_10, var_13);
    var_18 = spawnragdollconstraint(var_1, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkTo(var_17);
    thread impale_cleanup(var_1, var_17, var_13 + 0.05, var_18);
  }
}

impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::waittill_any_timeout(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

launch_and_kill(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("disconnect");
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  self.launched = 1;

  if(randomint(100) > 50 && !isDefined(self.is_suicide_bomber)) {
    self.nocorpse = undefined;
    var_3 = 50;
    var_4 = 50;

    if(var_2) {
      var_3 = 300;
      var_4 = 150;
    }

    self setvelocity(vectorNormalize(self.origin - var_0.origin) * var_3 + (0, 0, var_4));
    wait 0.1;
  } else {
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self dodamage(self.health + 1000, var_0.origin, var_0, var_0, "MOD_MELEE");
}

_id_B982() {
  scripts\engine\utility::flag_init("player_count_determined");
  var_0 = getDvar("party_partyPlayerCountNum");

  if(var_0 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}