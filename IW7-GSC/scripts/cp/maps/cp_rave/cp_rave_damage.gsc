/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_damage.gsc
******************************************************/

cp_rave_onzombiedamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
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

  var_0D = scripts\cp\agents\gametype_zombie::should_do_damage_checks(param_01, param_02, param_04, param_05, param_08, var_0C);
  if(!var_0D) {
    return;
  }

  param_03 = param_03 | 4;
  var_0E = isDefined(var_0C.agent_type) && var_0C.agent_type == "zombie_brute";
  var_0F = isDefined(var_0C.agent_type) && var_0C.agent_type == "slasher";
  var_10 = isDefined(var_0C.agent_type) && var_0C.agent_type == "superslasher";
  var_11 = scripts\engine\utility::istrue(var_0C.is_suicide_bomber);
  var_12 = param_04 == "MOD_MELEE";
  var_13 = scripts\engine\utility::istrue(param_01.inlaststand);
  var_14 = isDefined(self.isfrozen) && isDefined(param_05) && !scripts\cp\cp_weapon::isforgefreezeweapon(param_05) || param_04 == "MOD_MELEE";
  var_15 = scripts\cp\cp_weapon::isaltforgefreezeweapon(param_05);
  var_16 = scripts\engine\utility::isbulletdamage(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
  var_17 = isDefined(param_01) && isplayer(param_01);
  var_18 = var_16 && scripts\cp\utility::isheadshot(param_05, param_08, param_04, param_01);
  var_19 = scripts\engine\utility::istrue(self.battleslid);
  var_1A = scripts\engine\utility::istrue(level.insta_kill) && !var_0E && !var_10 & !var_0F;
  var_1B = !var_13 && var_18 && var_16 && param_01 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_1C = (param_04 == "MOD_EXPLOSIVE_BULLET" && isDefined(param_08) && param_08 == "none") || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
  var_1D = var_12 && param_01 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_1E = scripts\engine\utility::istrue(self.immune_against_freeze);
  var_1F = scripts\cp\utility::isaltmodeweapon(param_05);
  var_20 = var_12 && param_01 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  var_21 = scripts\engine\utility::istrue(param_01.rave_mode_od);
  var_22 = scripts\engine\utility::istrue(self.is_skeleton);
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

  if(var_17) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      param_01 notify("weapon_hit_marked_target", param_01, param_02, param_04, param_05, self);
    }

    if(issubstr(param_05, "iw7_harpoon2_zm")) {
      param_01 notify("zombie_hit_by_ben", param_06, self, self.maxhealth);
    }

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
  }

  if(isDefined(param_01.is_turned) && param_01.is_turned && param_04 != "MOD_SUICIDE") {
    if(var_0E) {
      param_02 = int(param_02 * 1.5);
    } else {
      param_02 = param_01.melee_damage_amt;
    }
  }

  var_27 = 0;
  if(!var_12 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(param_05) && var_17 && !isDefined(param_01.linked_to_coaster) && param_01 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_27 = param_01 scripts\cp\utility::coop_getweaponclass(param_05) == "weapon_sniper";
  }

  var_28 = scripts\engine\utility::istrue(level.explosive_touch) && isDefined(param_04) && param_04 == "MOD_UNKNOWN";
  if(var_28 && var_0E || var_0F || var_10) {
    return;
  }

  var_29 = !var_0E && !var_0F && !var_10 && var_19 || var_1A || var_20 || var_28 || var_14 || var_1B || var_1D || var_27 || var_21;
  var_2A = isDefined(self.isfrozen);
  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(param_05) && !var_0E && !var_10 && !var_0F) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(param_00.origin, param_06, param_07);
    return;
  } else if(isDefined(param_05) && scripts\cp\cp_weapon::isforgefreezeweapon(param_05) && !var_12 && !var_15) {
    var_2B = param_01 scripts\cp\cp_weapon::get_weapon_level(param_05);
    var_2C = scripts\cp\agents\gametype_zombie::getnumberoffrozenticksfromwave(self, var_2B);
    if(!var_2A && !var_1E && !var_0E && !var_11 && !var_10 && !var_0F) {
      var_2D = 10 * level.cash_scalar;
      if(param_01 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        param_01 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_2D = var_2D * 2;
      }

      param_01 scripts\cp\cp_persistence::give_player_currency(var_2D, "large", param_08);
      param_01 notify("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
      if(param_05 == "zfreeze_semtex_mp" || isDefined(self.frozentick) && self.frozentick >= var_2C || var_1A) {
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
    } else if(var_11) {
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
  } else if(!var_2A && var_15) {
    return;
  } else if(var_29 && !var_0E && !var_10 && !var_0F) {
    if(var_27) {
      param_01 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    param_02 = int(self.maxhealth);
    if(var_20) {
      if(isDefined(param_06)) {
        playFX(level._effect["shock_melee_impact"], param_06);
      }

      param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_20);
    }

    if(var_16) {
      param_01 notify("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
    }
  } else if(!var_10 || !var_0F) {
    param_08 = scripts\cp\agents\gametype_zombie::shitloc_mods(param_01, param_04, param_05, param_08);
    var_2E = level.wave_num;
    var_2F = scripts\cp\agents\gametype_zombie::is_grenade(param_05, param_04);
    var_30 = scripts\engine\utility::istrue(self.is_burning) && !var_16;
    var_31 = var_18 && param_01 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_32 = var_16 && param_01 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_33 = var_16 && param_01 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_34 = var_16 && isDefined(param_01.special_ammo_weapon) && param_01.special_ammo_weapon == param_05;
    var_35 = var_17 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_36 = var_17 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_37 = scripts\cp\agents\gametype_zombie::is_axe_weapon(param_05);
    var_38 = scripts\engine\utility::array_contains(level.melee_weapons, param_05);
    var_39 = weaponclass(param_05) == "spread" && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "smart");
    var_3A = weaponclass(param_05) == "spread" && !var_39 && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "arkpink") || scripts\cp\cp_weapon::has_attachment(param_05, "arkyellow");
    var_3B = var_18 && var_16 && param_01 scripts\cp\cp_weapon::has_attachment(param_05, "highcal");
    if(var_1F && issubstr(param_05, "+gl")) {
      param_02 = scripts\cp\agents\gametype_zombie::scalegldamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    }

    if(var_39) {
      param_02 = param_02 * 0.5;
    }

    if(isDefined(param_02) && isDefined(param_08) && !var_1A && var_16) {
      var_3C = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_0C, param_01, param_02, param_08, param_07);
      if(var_3C <= 0) {
        return;
      }

      param_02 = var_3C;
    }

    param_02 = scripts\cp\agents\gametype_zombie::initial_weapon_scale(undefined, param_01, param_02, undefined, param_04, param_05, undefined, undefined, param_08, undefined, undefined, undefined);
    if(var_3A) {
      param_02 = param_02 * 4;
    }

    if(var_17) {
      if(var_12) {
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

        var_3D = 0;
        if(param_02 >= self.health) {
          var_3D = 1;
        }

        if(isDefined(param_01.increased_melee_damage)) {
          param_02 = param_02 + param_01.increased_melee_damage;
        }

        if(var_38 && var_3D) {
          param_01 notify("melee_weapon_hit", param_05, self, param_02);
        }

        if(var_37 || var_36) {
          if(var_37) {
            param_01 notify("axe_melee_hit", param_05, self, param_02);
            if(var_3D && !isDefined(self.launched)) {
              thread scripts\cp\agents\gametype_zombie::launch_and_kill(param_01, param_05, var_36);
              return;
            }
          } else if(var_3D) {
            self.slappymelee = 1;
          }
        }
      }

      if(var_34) {
        param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, param_02, param_04, 128);
      }

      if(var_35 && var_1C) {
        param_02 = int(param_02 * 2);
      }

      if(scripts\engine\utility::istrue(param_01.rave_mode)) {
        param_02 = int(param_02 * 2);
      }
    }

    if(var_31) {
      param_02 = param_02 * 3;
    }

    if(var_32) {
      var_3E = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
      var_3F = weaponclipsize(param_01 getcurrentweapon());
      if(var_3E <= 4) {
        param_02 = param_02 * 2;
      }
    }

    if(var_16 && scripts\engine\utility::istrue(param_01.reload_damage_increase)) {
      param_02 = param_02 * 2;
    }

    if(var_2F) {
      param_02 = param_02 * min(2 + var_2E * 0.5, 10);
    }

    if(var_33) {
      param_02 = int(param_02 * 2);
    }

    if(var_3B) {
      param_02 = param_02 * 1.2;
    }
  }

  if(isDefined(param_01.perk_data) && param_01.perk_data["damagemod"].bullet_damage_scalar == 2 && var_16) {
    param_02 = param_02 * 1.33;
  }

  if(scripts\engine\utility::istrue(param_01.deadeye_charge)) {
    param_02 = param_02 * 1.25;
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

  param_02 = scripts\cp\agents\gametype_zombie::shouldapplycrotchdamagemultiplier(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  param_02 = scripts\cp\agents\gametype_zombie::fateandfortuneweaponscale(self, param_05, param_02, 0, var_0E, var_10, var_0F);
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

  if(isDefined(param_01.special_zombie_damage) && var_0E || var_11 || var_10 || var_0F) {
    param_02 = param_02 * param_01.special_zombie_damage;
  }

  if(isDefined(self.hitbychargedshot) && !self.health - param_02 < 1) {
    self.hitbychargedshot = undefined;
  }

  param_02 = int(min(param_02, self.maxhealth));
  if(isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_05, 1)) {
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - param_01.origin), anglestoup(self.angles), param_01);
  }

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

    param_01 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, param_01, param_05, param_02, param_08, param_04);
    param_01 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(param_05));
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

  if(var_18 && var_17 && var_2A) {
    if(isDefined(self.freeze_struct)) {
      self.freeze_struct notify("headcutter_cryo_kill", param_01, self);
    }
  }

  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(param_01, param_02, param_04);
  if(!var_0E && !var_0F) {
    scripts\cp\cp_agent_utils::process_damage_rewards(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  }

  if(!var_0E && !var_0F && self isethereal() || scripts\engine\utility::istrue(param_01.rave_mode)) {
    scripts\cp\cp_agent_utils::process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  }

  scripts\cp\cp_agent_utils::store_attacker_info(param_01, param_02);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  if(var_17) {
    thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(param_01);
  }

  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
}

cp_rave_onslasherdamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  var_0D = level.agent_funcs[self.agent_type]["gametype_on_damaged"];
  if(isDefined(var_0D)) {
    [[var_0D]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }

  if(scripts\mp\mp_agent::is_friendly_damage(var_0C, param_00)) {
    return;
  }

  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
}

cp_rave_onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.spawn_fx)) {
    self.spawn_fx delete();
  }

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(issubstr(param_04, "iw7_knife") && isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_04)) {
    param_01 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(param_01);
  } else if((param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") && isplayer(param_01) && scripts\cp\utility::is_melee_weapon(param_04)) {
    param_01 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(param_01);
  } else if(issubstr(param_04, "golf") || issubstr(param_04, "machete") || issubstr(param_04, "spiked_bat") || issubstr(param_04, "two_headed_axe")) {
    param_01 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(param_01);
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

  if(isplayer(param_01)) {
    if(issubstr(param_04, "harpoon1") || issubstr(param_04, "harpoon2") || issubstr(param_04, "harpoon3") || issubstr(param_04, "harpoon4")) {
      param_01 scripts\cp\zombies\achievement::update_achievement("STICK_EM", 1);
    }

    if(scripts\engine\utility::istrue(level.sniper_quest_on)) {
      level thread scripts\cp\utility::add_to_notify_queue("kill_near_bino_with_sniper", param_01, param_04, self);
    }

    if(issubstr(param_04, "iw7_harpoon2_zm") || issubstr(param_04, "iw7_harpoon2_zm_stun")) {
      self.nocorpse = 1;
      self.full_gib = 1;
      if(isDefined(self.body)) {
        self.body hide(1);
        self.body thread playbodyfx_ww(param_04, self);
      }
    }

    if(issubstr(param_04, "iw7_harpoon1_zm") || issubstr(param_04, "iw7_acid_rain_projectile_zm")) {
      self.nocorpse = 1;
      self.full_gib = 1;
      if(isDefined(self.body)) {
        self.body hide(1);
        self.body thread playbodyfx_ww(param_04, self);
      }
    }

    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      param_01.marked_ents = scripts\engine\utility::array_remove(param_01.marked_ents, self);
      param_01 notify("weapon_hit_marked_target", param_01, param_02, param_03, param_04, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
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
  var_0F = isDefined(self.agent_type) && self.agent_type == "slasher";
  var_10 = isDefined(self.agent_type) && self.agent_type == "superslasher";
  var_11 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(level.updaterecentkills_func) && isplayer(param_01)) {
    param_01 thread[[level.updaterecentkills_func]](self, param_04);
  }

  if((scripts\engine\utility::isbulletdamage(param_03) && getweaponbasename(param_04) == "iw7_atomizer_mp" || scripts\engine\utility::istrue(self.atomize_me)) || param_03 == "MOD_UNKNOWN" && getweaponbasename(param_04) == "iw7_harpoon3_zm") {
    if(!var_11 && !var_0E && !var_0F && !var_10) {
      self playSound("bullet_atomizer_impact_npc");
      if(isDefined(self.body)) {
        self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isplayer(param_01)) {
    if(scripts\engine\utility::istrue(param_01.rave_mode)) {
      if(!var_11 && !var_0E && !var_0F && !var_10) {
        self playSound("bullet_atomizer_impact_npc");
        if(isDefined(self.body)) {
          self.body thread play_rave_death_fx("rave_death_effects");
        }
      }
    }

    param_01 thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self, self.origin, param_04, param_03);
  }

  if(isDefined(level.on_zombie_killed_quests_func)) {
    [[level.on_zombie_killed_quests_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  if(!scripts\cp\agents\gametype_zombie::isonhumanteam(self)) {
    scripts\cp\agents\gametype_zombie::enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    if(isDefined(level.onzombiekilledfunc)) {
      [
        [level.onzombiekilledfunc]
      ](param_01, param_04);
    }
  }

  param_01 scripts\cp\zombies\zombies_consumables::headshot_reload_check(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
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

  if(isDefined(self.near_crystal) && !var_11) {
    if(isDefined(level.closest_crystal_func)) {
      var_12 = level[[level.closest_crystal_func]](self);
    } else {
      var_12 = undefined;
    }

    if(isDefined(var_12)) {
      if(isDefined(level.crystal_killed_notify)) {
        thread scripts\cp\agents\gametype_zombie::delayminiufocollection(self.origin, param_04, var_12);
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
  scripts\cp\agents\gametype_zombie::process_kill_rewards(param_00, param_01, self, param_06, param_03, param_04);
  scripts\cp\agents\gametype_zombie::process_assist_rewards(param_01);
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
  if(isDefined(level.cp_rave_zombie_death_pos_record_func)) {
    [[level.cp_rave_zombie_death_pos_record_func]](self.origin);
  }

  level thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self.origin, param_04, param_03, param_01);
}

play_rave_death_fx(param_00) {
  var_01 = ["j_spineupper", "j_spinelower"];
  if(!isDefined(param_00)) {
    var_02 = level._effect["atomize_body"];
  } else {
    var_02 = level._effect[var_01];
  }

  var_03 = spawnfx(var_02, self gettagorigin("j_spinelower"));
  foreach(var_05 in level.players) {
    if(!scripts\engine\utility::istrue(var_05.rave_mode)) {
      var_03 hidefromplayer(var_05);
      continue;
    }

    self hidefromplayer(var_05);
  }

  triggerfx(var_03);
  var_03 thread delete_death_fx(var_03);
}

delete_death_fx(param_00) {
  level endon("game_ended");
  wait(2.5);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

callback_ravezombieplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(!scripts\cp\zombies\zombie_damage::shouldtakedamage(param_02, param_01, param_05, param_03)) {
    return;
  }

  if(param_04 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[param_05])) {
      level thread[[level.overcook_func[param_05]]](var_0C, param_05);
    }
  }

  var_0D = isDefined(param_04) && param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE_SPLASH";
  var_0E = isDefined(param_04) && param_04 == "MOD_EXPLOSIVE_BULLET";
  var_0F = scripts\cp\zombies\zombie_damage::isfriendlyfire(self, param_01);
  var_10 = isDefined(param_05) && param_05 == "iw7_sasq_rock_mp";
  var_11 = scripts\cp\utility::is_hardcore_mode();
  var_12 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_13 = isDefined(param_01);
  var_14 = var_13 && isDefined(param_01.species) && param_01.species == "zombie";
  var_15 = var_13 && isDefined(param_01.species) && param_01.species == "zombie_grey";
  var_16 = var_13 && isDefined(param_01.agent_type) && param_01.agent_type == "zombie_brute";
  var_17 = var_13 && param_01 == self;
  var_18 = var_13 && isDefined(param_01.agent_type) && param_01.agent_type == "zombie_sasquatch";
  var_19 = var_13 && isDefined(param_01.agent_type) && param_01.agent_type == "slasher";
  var_1A = var_13 && isDefined(param_01.agent_type) && param_01.agent_type == "superslasher";
  var_1B = (var_17 || !var_13) && param_04 == "MOD_SUICIDE";
  if(var_13) {
    if(param_01 == self) {
      if(issubstr(param_05, "iw7_harpoon2_zm") || issubstr(param_05, "iw7_harpoon1_zm") || issubstr(param_05, "iw7_acid_rain_projectile_zm")) {
        param_02 = 0;
      }

      if(var_0D) {
        var_1C = self getstance();
        if(var_12) {
          param_02 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
          param_02 = 0;
        } else {
          param_02 = scripts\cp\zombies\zombie_damage::get_explosive_damage_on_player(param_00, param_01, param_02, param_03, param_04, param_05);
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
      if(var_11) {
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
    } else if(var_19) {
      if(!scripts\engine\utility::istrue(self.rave_mode) && param_01 isethereal()) {
        return;
      }
    } else if(var_14) {
      if(param_04 != "MOD_EXPLOSIVE" && var_0C scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(param_01.is_burning)) {
          var_0C scripts\cp\utility::notify_used_consumable("burned_out");
          param_01 thread scripts\cp\utility::damage_over_time(param_01, var_0C, 3, int(param_01.maxhealth + 1000), param_04, "incendiary_ammo_mp", undefined, "burning");
          param_01.faf_burned_out = 1;
        }
      }

      var_1D = gettime();
      if(!isDefined(self.last_zombie_hit_time) || var_1D - self.last_zombie_hit_time > 20) {
        self.last_zombie_hit_time = var_1D;
      } else {
        return;
      }

      var_1E = 500;
      if(getdvarint("zom_damage_shield_duration") != 0) {
        var_1E = getdvarint("zom_damage_shield_duration");
      }

      if(isDefined(param_01.last_damage_time_on_player[self.vo_prefix])) {
        var_1F = param_01.last_damage_time_on_player[self.vo_prefix];
        if(var_1F + var_1E > gettime()) {
          param_02 = 0;
        } else {
          param_01.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else {
        param_01.last_damage_time_on_player[self.vo_prefix] = gettime();
      }
    }

    if(var_0E) {
      var_1C = self getstance();
      if(var_12) {
        param_02 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
        param_02 = 0;
      } else if(!var_11 || param_01 == self && param_08 == "none") {
        param_02 = 0;
      }
    }
  } else if(var_12 && param_04 == "MOD_SUICIDE") {
    if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm") {
      param_02 = 0;
    }
  } else {
    var_1C = self getstance();
    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
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

  var_20 = 0;
  if(var_13 && param_01 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.linked_to_player)) {
    if(self.health - param_02 < 1) {
      param_02 = self.health - 1;
    }
  }

  if(var_14 || var_15 || var_16 || var_17 && !var_1B) {
    param_02 = int(param_02 * var_0C scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    param_02 = int(max(self.maxhealth / 2.75, param_02));
  }

  if(var_0C scripts\cp\utility::is_consumable_active("secret_service") && isalive(param_01)) {
    var_21 = 0;
    if(isDefined(param_01.agent_type) && param_01.agent_type == "zombie_sasquatch" || param_01.agent_type == "slasher" || param_01.agent_type == "superslasher" || scripts\engine\utility::istrue(param_01.is_skeleton)) {
      var_21 = 0;
    } else if(isplayer(var_0C) && isplayer(param_01)) {
      var_21 = 0;
    } else {
      var_21 = 1;
    }

    if(var_21) {
      param_01 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_0C);
      var_0C scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  param_02 = int(param_02);
  if(!var_0F || var_11) {
    scripts\cp\zombies\zombie_damage::finishplayerdamagewrapper(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_20, param_0A, param_0B);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", param_02);
  if(param_02 <= 0) {
    return;
  }

  if(var_10) {
    playfxontagforclients(level._effect["sasquatch_rock_hit"], self, "tag_eye", self);
  }

  thread scripts\cp\utility::player_pain_vo();
  thread scripts\cp\zombies\zombie_damage::play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();
  if(isDefined(param_01)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();
    if(isagent(param_01)) {
      if(param_02 > self.health) {
        param_01.killed_player = 1;
      }

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

playbodyfx_ww(param_00, param_01, param_02) {
  var_03[0][1]["org"] = self gettagorigin("j_spinelower");
  var_03[0][1]["angles"] = self gettagangles("j_spinelower");
  var_04 = undefined;
  var_05 = undefined;
  if(issubstr(param_00, "iw7_harpoon1_zm") || issubstr(param_00, "iw7_acid_rain_projectile_zm")) {
    self hide(0);
    param_01.nocorpse = 0;
    param_01.full_gib = 0;
    var_03[0][0]["org"] = self gettagorigin("j_spineupper");
    var_03[0][0]["angles"] = self gettagangles("j_spineupper");
    var_04 = level._effect["wrecked_cheap"];
    var_05 = level._effect["acid_rain_death"];
  } else if(issubstr(param_00, "iw7_harpoon2_zm")) {
    var_04 = level._effect["wrecked_by_ben"];
  } else {
    var_04 = level._effect["wrecked_cheap"];
  }

  foreach(var_07 in var_03) {
    foreach(var_09 in var_07) {
      if((issubstr(param_00, "iw7_harpoon1_zm") || issubstr(param_00, "iw7_acid_rain_projectile_zm")) && !scripts\engine\utility::istrue(level.played_acid_rain_effect)) {
        level.played_acid_rain_effect = 1;
        if(isDefined(var_04)) {
          playFX(var_04, var_09["org"], anglesToForward(var_09["angles"]));
        }

        scripts\engine\utility::waitframe();
        if(isDefined(var_05)) {
          playFX(var_05, var_09["org"]);
          scripts\engine\utility::waitframe();
        }

        continue;
      }

      if((issubstr(param_00, "iw7_harpoon2_zm") || issubstr(param_00, "iw7_harpoon2_zm_stun")) && !scripts\engine\utility::istrue(level.played_ben_franklin_effect)) {
        level.played_ben_franklin_effect = 1;
        if(isDefined(var_04)) {
          playFX(var_04, var_09["org"], anglesToForward(var_09["angles"]));
        }

        scripts\engine\utility::waitframe();
        continue;
      }

      if(isDefined(var_04)) {
        playFX(var_04, var_09["org"], anglesToForward(var_09["angles"]));
      }

      scripts\engine\utility::waitframe();
    }

    wait(0.01);
  }
}