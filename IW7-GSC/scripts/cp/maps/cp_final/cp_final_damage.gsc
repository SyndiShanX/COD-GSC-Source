/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_damage.gsc
********************************************************/

cp_final_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_5) && var_5 == "iw7_entangler_zm") {
    return;
  }

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

  var_13 = scripts\cp\agents\gametype_zombie::should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_12);
  if(!var_13) {
    return;
  }

  var_14 = level.wave_num;
  var_15 = scripts\engine\utility::istrue(var_12.hit_by_dodging_player);
  var_10 = var_4 == "MOD_MELEE";
  var_11 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_12 = scripts\engine\utility::istrue(var_12.is_suicide_bomber);
  var_3 = var_3 | 4;
  var_13 = isDefined(var_1) && isPlayer(var_1);
  var_14 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_15 = var_14 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_16 = scripts\engine\utility::istrue(self.battleslid);
  var_17 = scripts\engine\utility::istrue(level.insta_kill) && !scripts\cp\utility::agentisinstakillimmune();
  var_18 = (var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_19 = !var_11 && var_15 && var_14 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_1A = var_10 && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_1B = var_10 && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  var_1C = scripts\cp\utility::isaltmodeweapon(var_5);
  var_1D = scripts\cp\utility::agentisfnfimmune();
  var_1E = scripts\cp\utility::agentisinstakillimmune();
  var_1F = var_13 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_change");
  var_20 = scripts\cp\utility::agentisspecialzombie();
  var_21 = isDefined(self.agent_type) && self.agent_type == "alien_rhino";
  if(isDefined(var_5) && issubstr(var_5, "iw7_gauss_zml")) {
    var_22 = 250;
    if(scripts\cp\utility::weaponhasattachment(var_5, "pap1")) {
      var_22 = 470;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "pap2")) {
      var_22 = 734;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "doubletap")) {
      var_22 = 1.33 * var_22;
    }

    if(var_2 >= var_22) {
      self.hitbychargedshot = var_1;
    }
  }

  if(var_13 && !var_1D) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_marked_target", var_1, var_2, var_4, var_5, self);
    }

    self.damaged_by_player = 1;
    if(scripts\engine\utility::istrue(var_1.stimulus_active)) {
      playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
      scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", self gettagorigin("j_spineupper"));
      foreach(var_24 in level.players) {
        if(var_24 == var_1) {
          if(distance2dsquared(var_24.origin, self.origin) <= 10000) {
            playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
            playFX(level._effect["stimulus_shield"], var_24 gettagorigin("tag_eye"), anglesToForward(var_24.angles), anglestoup(var_24.angles), var_24);
            if(var_2 >= self.health) {
              if(scripts\engine\utility::istrue(var_24.inlaststand)) {
                scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_24);
              }
            }

            if(var_24.health + var_2 / level.players.size + 1 >= var_24.maxhealth) {
              var_24.health = var_24.maxhealth;
            } else {
              var_24.health = int(var_24.health + var_2 / level.players.size + 1);
            }
          }

          continue;
        }

        if(distance2dsquared(var_24.origin, self.origin) <= 10000) {
          playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
          playFX(level._effect["stimulus_shield"], var_24 gettagorigin("tag_eye"));
          if(var_2 >= self.health) {
            if(scripts\engine\utility::istrue(var_24.inlaststand)) {
              scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_24);
            }
          }

          if(int(var_24.health + var_2 / level.players.size + 1) >= var_24.maxhealth) {
            var_24.health = var_24.maxhealth;
            continue;
          }

          var_24.health = int(var_24.health + var_2 / level.players.size + 1);
        }
      }
    }
  }

  if(isDefined(var_1.is_turned) && var_1.is_turned && var_4 != "MOD_SUICIDE") {
    var_2 = var_1.melee_damage_amt;
  }

  var_26 = 0;
  if(!var_10 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5) && var_13 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_26 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
  }

  var_27 = !var_1D && scripts\engine\utility::istrue(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";
  var_28 = isDefined(var_5) && var_5 == "iw7_entangler2_zm";
  var_29 = !var_1E && var_16 || var_17 || var_1B || var_27 || var_19 || var_1A || var_26;
  var_2A = scripts\engine\utility::istrue(self.isfrozen);
  if(var_29 && !var_1D) {
    if(var_26) {
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    var_2 = int(self.maxhealth);
    if(var_1B) {
      if(isDefined(var_6)) {
        playFX(level._effect["shock_melee_impact"], var_6);
      }

      var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_1B);
    }

    if(var_14) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    }
  } else {
    var_8 = scripts\cp\agents\gametype_zombie::shitloc_mods(var_1, var_4, var_5, var_8);
    var_2B = scripts\cp\agents\gametype_zombie::is_grenade(var_5, var_4);
    var_2C = scripts\engine\utility::istrue(self.is_burning) && !var_14;
    var_2D = var_15 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_2E = var_14 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_2F = var_14 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_30 = var_14 && isDefined(var_1.special_ammo_weapon) && var_1.special_ammo_weapon == var_5;
    var_31 = var_13 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_32 = var_13 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_33 = scripts\engine\utility::array_contains(level.melee_weapons, var_5);
    var_34 = weaponclass(var_5) == "spread" && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "smart");
    var_35 = weaponclass(var_5) == "spread" && !var_34 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "arkpink") || scripts\cp\cp_weapon::has_attachment(var_5, "arkyellow");
    var_36 = var_15 && var_14 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "highcal");
    if(issubstr(var_5, "cutie") && var_13) {
      var_37 = 7000;
      self.ragdollhitloc = var_8;
      if(!isDefined(var_7)) {
        var_7 = vectornormalize(self.origin - var_1.origin);
      }

      if(lengthsquared(var_7) < 1) {
        var_38 = self.origin - var_1.origin;
        var_38 = vectornormalize((var_38[0], var_38[1], var_38[2]));
        self.ragdollimpactvector = var_38 * var_37;
      } else {
        self.ragdollimpactvector = var_7 * var_37;
      }
    }

    if(var_1C && issubstr(var_5, "+gl")) {
      var_2 = scripts\cp\agents\gametype_zombie::scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(var_34) {
      var_2 = var_2 * 0.5;
    }

    var_2 = scripts\cp\agents\gametype_zombie::initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);
    if(var_35) {
      var_2 = var_2 * 4;
    }

    if(var_13) {
      if(var_10) {
        var_2 = int(var_2 * var_1 scripts\cp\perks\perk_utility::perk_getmeleescalar());
        if(isDefined(var_1.passive_melee_kill_damage)) {
          var_2 = var_2 + var_1.passive_melee_kill_damage;
        }

        if(var_32) {
          var_2 = var_2 + 1500;
        }

        var_39 = 0;
        if(var_2 >= self.health) {
          var_39 = 1;
        }

        if(isDefined(var_1.increased_melee_damage)) {
          var_2 = var_2 + var_1.increased_melee_damage;
        }

        if(var_33 && var_39) {
          var_1 thread scripts\cp\utility::add_to_notify_queue("melee_weapon_hit", var_5, self, var_2);
        }

        if(var_32) {
          if(var_39) {
            self.slappymelee = 1;
          }
        }
      }

      if(var_30) {
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, var_2, var_4, 128);
      }

      if(var_31 && var_18) {
        var_2 = int(var_2 * 2);
      }

      if(isDefined(var_1.stimulus_damage_buff)) {
        var_2 = int(var_2 * 4);
      }
    }

    if(var_2D) {
      var_2 = var_2 * 3;
    }

    if(var_2E) {
      var_3A = int(var_1 getweaponammoclip(var_1 getcurrentweapon()) + 1);
      var_3B = weaponclipsize(var_1 getcurrentweapon());
      if(var_3A <= 4) {
        var_2 = var_2 * 2;
      }
    }

    if(var_14 && scripts\engine\utility::istrue(var_1.reload_damage_increase) && !var_21) {
      var_2 = var_2 * 2;
    }

    if(var_2B) {
      var_2 = var_2 * min(2 + var_14 * 0.5, 10);
    }

    if(var_2F) {
      if(self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "karatemaster" || !var_20) {
        var_2 = int(var_2 * 2);
      }
    }

    if(var_36) {
      var_2 = var_2 * 1.2;
    }

    if(var_13 && var_15 && !var_20) {
      if(!isDefined(self.launched)) {
        var_37 = 7000;
        self.kung_fu_punched = 1;
        self.ragdollhitloc = var_8;
        if(!isDefined(var_7)) {
          var_7 = vectornormalize(self.origin - var_1.origin);
        }

        if(lengthsquared(var_7) < 1) {
          var_38 = self.origin - var_1.origin;
          var_38 = vectornormalize((var_38[0], var_38[1], var_38[2]));
          self.ragdollimpactvector = var_38 * var_37;
        } else {
          self.ragdollimpactvector = var_7 * var_37;
        }

        var_2 = 100000000;
      }
    }
  }

  var_3C = isDefined(var_5) && var_5 == "ghost_grenade_launcher";
  if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2 && var_14) {
    var_2 = var_2 * 1.33;
  }

  if(scripts\engine\utility::istrue(var_1.deadeye_charge)) {
    var_2 = var_2 * 1.25;
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

  var_2 = scripts\cp\agents\gametype_zombie::shouldapplycrotchdamagemultiplier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_21 = isDefined(self.agent_type) && self.agent_type == "alien_rhino";
  var_2 = finalfateandfortuneweaponscale(self, var_5, var_2, 0, var_20, var_21, 0);
  if(isDefined(var_1.special_zombie_damage) && var_20) {
    var_2 = var_2 * var_1.special_zombie_damage;
  }

  if(var_3C) {
    var_2 = ghostgrenadescaler(self, var_2);
  }

  if(var_28) {
    self.flame_damage_time = gettime() + 500;
    if(isDefined(level.wave_num_override)) {
      var_3D = level.wave_num_override;
    } else {
      var_3D = var_15;
    }

    var_3E = int(clamp(var_3D / 5, 1, 4));
    if(var_20) {
      var_2 = 1;
    } else {
      if(var_3E > 1) {
        var_2 = self.maxhealth * 0.1 / var_3E;
      } else {
        var_2 = self.maxhealth * 0.1;
      }

      if(isfataldamage(self, var_2)) {
        self.entangled = 1;
      }
    }
  }

  if(isDefined(self.hitbychargedshot) && !isfataldamage(self, var_2)) {
    self.hitbychargedshot = undefined;
  }

  var_2 = int(min(var_2, self.health));
  if(isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_5, 1)) {
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - var_1.origin), anglestoup(self.angles), var_1);
  }

  if(self.health > 0 && self.health - var_2 <= 0) {
    if(self.died_poorly) {
      self.died_poorly_health = self.health;
    }

    if(isDefined(self.has_backpack)) {
      scripts\cp\zombies\zombies_pillage::pillageable_piece_lethal_monitor(self, self.has_backpack, var_1);
    }

    if(var_28 && scripts\engine\utility::istrue(self.entangled)) {
      self.nocorpse = 1;
    }

    if(var_13 && var_1F) {
      if(isDefined(self.agent_type) && self.agent_type == "generic_zombie") {
        if(issubstr(var_5, "entangler")) {} else if(var_5 == "iw7_change_chews_zm") {
          self.nocorpse = 1;
          self.full_gib = 1;
        } else if(var_15) {
          var_3F = 50;
          if(randomint(100) < var_3F) {
            switch (var_1.sub_perks["perk_machine_change"]) {
              case "perk_machine_change1":
                playFX(level._effect["cc_head_nuke"], var_6);
                playsoundatpos(var_6, "change_chew_nuke_explo");
                var_1 thread change_chews_damage_over_time(self, var_1, 96, "explode");
                break;

              case "perk_machine_change2":
                playFX(level._effect["cc_zap_burst"], var_6);
                playsoundatpos(var_6, "change_chew_electric_explo");
                var_1 thread change_chews_damage_over_time(self, var_1, 196, "shocked");
                break;

              case "perk_machine_change3":
                playFX(level._effect["cc_fire_burst"], var_6);
                playsoundatpos(var_6, "change_chew_fire_explo");
                var_1 thread change_chews_damage_over_time(self, var_1, 128, "burning");
                break;

              case "perk_machine_change4":
                playFX(level._effect["cc_ice_burst"], var_6);
                var_1 thread change_chews_damage_over_time(self, var_1, 128, "frozen");
                break;

              default:
                break;
            }
          }
        }
      }
    }

    if(isDefined(self.agent_type) && self.agent_type == "alien_goon") {
      if(var_4 == "MOD_SUICIDE") {
        self.vignette_nocorpse = 1;
      } else {
        self.var_CE65 = 0.05;
      }
    } else if(isDefined(self.agent_type) && self.agent_type == "alien_phantom") {
      self.var_CE65 = 0.05;
    }
  }

  if(var_13) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(var_5));
    if(var_14) {
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

  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(var_1, var_2, var_4);
  scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  if(isDefined(self.agent_type) && isDefined(level.damage_feedback_overrride) && isDefined(level.damage_feedback_overrride[self.agent_type])) {
    [[level.damage_feedback_overrride[self.agent_type]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  } else {
    scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  }

  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  if(var_13) {
    thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(var_1);
  }

  if(isDefined(self.is_mammoth) && self.is_mammoth) {
    if(self.health - var_2 < self.maxhealth * self.mammoth_health_threshold) {
      self notify("mammoth_hit", self);
    }
  }

  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

isfataldamage(var_0, var_1) {
  return var_0.health - var_1 < 1;
}

finalfateandfortuneweaponscale(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1)) {
    return var_2;
  }

  var_7 = getweaponbasename(var_1);
  if(isDefined(var_7)) {
    switch (var_7) {
      case "iw7_steeldragon_mp":
      case "iw7_claw_mp":
        if(var_5) {
          var_2 = min(max(var_0.maxhealth * 0.05, 100), 150);
        } else if(var_3 || var_6 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = min(max(var_0.maxhealth * 0.05, 300), 5);
        } else {
          var_2 = min(max(var_0.maxhealth, 300), 1000);
        }
        break;

      case "iw7_blackholegun_mp":
        if(var_5 || var_6 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = min(max(var_0.maxhealth * 0.15, 300), 1000);
        } else if(var_4 && var_0.agent_type != "alien_goon" && var_0.agent_type != "karatemaster") {
          var_2 = min(var_2 * 10, 2000);
        } else {
          var_2 = var_2 * 10;
        }
        break;

      case "iw7_atomizer_mp":
      case "iw7_penetrationrail_mp":
        if(var_3 || var_6 || var_5 || var_0 scripts\cp\utility::agentisinstakillimmune()) {
          var_2 = min(max(var_0.maxhealth * 0.15, 300), 1000);
        } else if(var_4 && var_0.agent_type != "alien_goon" && var_0.agent_type != "karatemaster") {
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

cp_final_initial_weapon_scale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!scripts\cp\agents\gametype_zombie::can_scale_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    return var_2;
  }

  var_12 = isDefined(self.agent_type) && self.agent_type == "alien_rhino";
  if(isDefined(var_5)) {
    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      if(isDefined(level.melee_weapons) && scripts\engine\utility::array_contains(level.melee_weapons, getweaponbasename(var_5))) {
        return var_2;
      } else if(issubstr(getweaponbasename(var_5), "rvn")) {
        var_2 = min(self.maxhealth, var_2);
        return var_2;
      }

      if(!scripts\cp\agents\gametype_zombie::is_axe_weapon(var_5)) {
        var_2 = 150;
      }

      return var_2;
    } else if(var_5 == "alien_sentry_minigun_4_mp") {
      if(scripts\engine\utility::istrue(self.is_mammoth)) {
        var_2 = min(int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25)), 100);
      } else if(var_12) {
        var_2 = min(int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25)), 250);
      } else {
        var_2 = int(self.maxhealth / 2 * randomfloatrange(0.75, 1.25));
      }
    }

    return var_2;
  }

  return var_2;
}

ghostgrenadescaler(var_0, var_1) {
  var_1 = var_1 * 1.25 / 150;
  var_1 = var_1 * var_0.maxhealth;
  return var_1;
}

entanglezombie(var_0, var_1) {
  level endon("game_ended");
  var_1.hasghostentangled = 1;
  playFX(level._effect["chi_ghost_death"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel("zmb_zombie_ghost_green");
  if(var_1 scripts\cp\utility::isweaponfireenabled()) {
    var_1 scripts\engine\utility::allow_fire(0);
  }

  if(var_1 scripts\cp\utility::issprintenabled()) {
    var_1 scripts\engine\utility::allow_sprint(0);
  }

  var_1 notifyonplayercommand("item_released", "-attack");
  var_1 setscriptablepartstate("entangler", "active");
  var_3 = playfxontagsbetweenclients(level._effect["entangler_beam"], var_1, "tag_flash", var_2, "j_chest");
  var_2 thread moveghosttowardsplayer(var_2, var_1);
  ghostidleloop(var_2, var_1);
  var_1 notify("end_move_towards_player");
  var_1 setscriptablepartstate("entangler", "fired");
  if(isDefined(var_1) && !var_1 scripts\cp\utility::isweaponfireenabled()) {
    var_1 scripts\engine\utility::allow_fire(1);
  }

  if(isDefined(var_1) && !var_1 scripts\cp\utility::issprintenabled()) {
    var_1 scripts\engine\utility::allow_sprint(1);
  }

  var_3 delete();
  launchfakeghost(var_2.origin, var_2.angles, undefined, var_1, var_2);
  if(isDefined(var_1)) {
    var_1.hasghostentangled = undefined;
  }
}

delaykillghost(var_0, var_1) {
  level endon("game_ended");
  var_1 waittill("death");
  var_2 = var_1.origin;
  scripts\cp\utility::playsoundatpos_safe(var_2, "ghosts_ghosts_8bit_target_explo");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

ghostidleloop(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("end_Ghost_Idle_Loop");
  var_1 endon("entangler_removed");
  var_1 endon("item_released");
  level endon("entangler_removed_" + var_1.name);
  for(;;) {
    var_0 scriptmodelplayanim("IW7_cp_zom_ghost_trapped_idle", 1);
    var_2 = getanimlength(%iw7_cp_zom_ghost_trapped_idle);
    wait(var_2);
  }
}

moveghosttowardsplayer(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("end_Ghost_Idle_Loop");
  var_0 endon("death");
  var_1 endon("item_released");
  wait(0.1);
  var_2 = 1250;
  var_3 = 0;
  var_4 = 96;
  var_5 = 0;
  var_6 = var_0;
  var_7 = 1;
  var_8 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  var_9 = scripts\common\trace::create_contents(1, 1, 1, 1, 1, 0, 0);
  var_10 = scripts\cp\crafted_entangler::getcapsulefrommodel(var_6);
  var_6 endon("end_entangle_move_to_logic");
  var_6 endon("item_released");
  var_6.lasteffecttime = 0;
  if(isDefined(var_6.script_parameters) && var_6.script_parameters == "heavy_helmet") {
    var_4 = 100;
    var_2 = 250;
    var_7 = 0;
  }

  playFXOnTag(level._effect["vfx_item_entagled"], var_6, "j_chest");
  thread scripts\cp\crafted_entangler::delaykillfx(var_6, "j_chest", var_1);
  thread monitorplayerviewangles(var_1, var_0);
  for(var_11 = 0; var_1 getcurrentweapon() == "iw7_entangler2_zm"; var_11++) {
    var_12 = gettime();
    if(var_6.lasteffecttime + 250 <= var_12) {
      var_6.lasteffecttime = var_12;
    }

    var_4 = 96;
    var_13 = var_1 getvelocity();
    var_14 = vectordot(var_13, var_1.angles);
    if(var_14 >= 1) {
      var_15 = length(var_13);
      if(var_15 >= 250) {
        var_4 = var_4 + 60;
      } else if(var_15 >= 185) {
        var_4 = var_4 + 36;
      } else if(var_15 >= 100) {
        var_4 = var_4 + 24;
      }
    }

    var_10 = var_11 >= 5;
    var_11 = [var_6];
    var_12 = var_1 getEye();
    var_13 = var_1.origin + (0, 0, 56);
    var_14 = (0, var_4, 0);
    var_15 = var_1 getplayerangles();
    var_16 = anglesToForward(var_15);
    var_17 = anglestoup(var_15);
    var_18 = anglestoright(var_15);
    var_19 = var_5;
    var_13 = var_13 + var_14[0] * var_18;
    var_13 = var_13 + var_14[1] * var_16;
    var_13 = var_13 + var_14[2] * var_17;
    var_1A = rotatepointaroundvector(anglestoup(var_15), anglesToForward(var_15), var_19);
    var_1B = var_13 + var_1A;
    var_1C = var_1B[2];
    var_1D = scripts\engine\utility::drop_to_ground(var_12, 12, -100)[2];
    var_1E = min(var_12[2], var_1D + 12);
    var_1C = clamp(var_1B[2], var_1D, var_1E);
    var_1B = (var_1B[0], var_1B[1], var_1C);
    var_1F = vectortoangles(var_1.origin - var_6.origin);
    var_6.angles = (var_1F[0], var_1F[1], var_1F[2]);
    if(var_10) {
      var_20 = var_6.origin + anglesToForward(vectortoangles(var_1.origin - var_6.origin)) * 12;
      var_21 = scripts\common\trace::capsule_trace(var_20, var_1B, var_10[0], var_10[1], undefined, var_11, var_8, 1);
      var_1B = var_21["shape_position"] - (0, 0, var_21["shape_position"][2]) + (0, 0, var_1C);
    }

    var_22 = distance(var_6.origin, var_1B);
    var_3 = var_22 / var_2;
    if(var_3 < 0.05) {
      var_3 = 0.05;
    }

    if(scripts\engine\utility::istrue(var_1.is_off_grid) || scripts\engine\utility::istrue(var_1.isfasttravelling)) {
      var_6 dontinterpolate();
      var_10 = 0;
      var_11 = 0;
      var_6.origin = var_1B;
    } else if(var_22 <= 64) {
      var_6.origin = var_1B;
    } else {
      var_6 moveto(var_1B, var_3);
      var_1 scripts\engine\utility::waittill_any_timeout(var_3, "update_ghost_pos");
    }

    if(var_10) {
      var_20 = var_6.origin + anglesToForward(var_6.angles) * 18;
      var_11 = scripts\engine\utility::array_combine(level.players, [var_6]);
      var_23 = scripts\common\trace::ray_trace(var_12, var_20 + (0, 0, 16), var_11, var_9);
      if(var_23["hittype"] != "hittype_none") {
        var_6.forcerelease = 1;
        if(isDefined(var_1)) {
          var_1 notify("end_Ghost_Idle_Loop");
          var_1 notify("item_released");
        }

        var_6 notify("item_released");
      }
    }

    scripts\engine\utility::waitframe();
  }

  var_1 notify("end_Ghost_Idle_Loop");
}

monitorplayerviewangles(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_0 endon("end_Ghost_Idle_Loop");
  for(;;) {
    var_2 = var_0 gettagorigin("tag_flash") - (0, 0, 16);
    var_3 = vectornormalize(anglesToForward(var_0.angles)) * 56;
    var_4 = var_2 + var_3;
    if(distance(var_1.origin, var_4) >= 5) {
      var_0 notify("update_ghost_pos");
    }

    scripts\engine\utility::waitframe();
  }
}

watchforattackButtonPressed(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_0 endon("end_Ghost_Idle_Loop");
  var_0 notifyonplayercommand("fire_released", "-attack");
  var_0 notifyonplayercommand("fire_released", "-attack_akimbo_accessible");
  var_0 waittill("fire_released");
  var_0 notify("end_Ghost_Idle_Loop");
}

launchfakeghost(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_3 endon("disconnect");
  var_5 = var_3 getEye();
  var_6 = var_4.origin;
  var_7 = (0, 10000, 0);
  var_8 = var_3 getplayerangles();
  var_9 = 2;
  var_6 = var_6 + var_7[0] * anglestoright(var_8);
  var_6 = var_6 + var_7[1] * anglesToForward(var_8);
  var_6 = var_6 + var_7[2] * anglestoup(var_8);
  var_10 = rotatepointaroundvector(anglestoup(var_8), anglesToForward(var_8), var_9);
  var_11 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 0);
  var_12 = scripts\common\trace::capsule_trace(var_5, var_6 + var_10, 16, 32, undefined, [var_3, var_4], var_11, 24);
  var_13 = var_12["shape_position"];
  var_14 = magicbullet("ghost_grenade_launcher", var_4.origin, var_13, var_3);
  var_4 linkto(var_14, "tag_origin");
  var_14.owner = var_3;
  var_14.team = var_3.team;
  var_14 setscriptablepartstate("animation", "on");
  thread delaykillghost(var_4, var_14);
}

printgrenadedeath(var_0) {
  level endon("game_ended");
  var_0 waittill("death", var_1, var_2, var_3);
}

get_fake_ghost_color(var_0) {
  return var_0;
}

get_fake_ghost_model(var_0) {
  if(isDefined(level.get_fake_ghost_model_func)) {
    return [[level.get_fake_ghost_model_func]](var_0);
  }

  return "fake_zombie_ghost_" + var_0;
}

physics_callback_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  fake_ghost_explode(var_0, var_1, getghostimpactexplosionrange());
}

getghostimpactexplosionrange() {
  return 7225;
}

fake_ghost_explode(var_0, var_1, var_2) {
  var_0 setscriptablepartstate("animation", "off");
  var_0 delete();
}

cp_final_onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.spawn_fx)) {
    self.spawn_fx delete();
  }

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(scripts\engine\utility::istrue(self.activated_slomo_sphere)) {
    self.activated_slomo_sphere = undefined;
  }

  if(issubstr(var_4, "iw7_knife") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if((var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if(issubstr(var_4, "golf") || issubstr(var_4, "machete") || issubstr(var_4, "spiked_bat") || issubstr(var_4, "two_headed_axe")) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  }

  if(isDefined(var_1) && isPlayer(var_1) && scripts\engine\utility::istrue(self.entangled) && !scripts\engine\utility::istrue(var_1.hasghostentangled)) {
    thread entanglezombie(self, var_1);
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
    if(scripts\engine\utility::istrue(self.dot_triggered)) {
      self.dot_triggered = undefined;
    }
  }

  if(isPlayer(var_1)) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      var_1.marked_ents = scripts\engine\utility::array_remove(var_1.marked_ents, self);
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_marked_target", var_1, var_2, var_3, var_4, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
    }

    if(isDefined(var_1.weapon_passive_xp_multiplier) && var_1.weapon_passive_xp_multiplier > 1) {
      var_1.kill_with_extra_xp_passive = 1;
    }

    var_10 = (var_3 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_6) && var_6 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";
    if(var_10) {
      if(!isDefined(var_1.explosive_kills)) {
        var_1.explosive_kills = 1;
      } else {
        var_1.explosive_kills++;
      }

      scripts\cp\cp_persistence::increment_player_career_explosive_kills(var_1);
    }

    var_1.setculldist++;
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

    if(isDefined(self.soldier)) {
      var_14 = 100;
      var_15 = 3;
      var_10 = self.origin + (0, 0, 20);
      var_11 = (randomint(350), randomint(350), randomint(350));
      var_11 = vectornormalize(var_11) * var_14;
      var_12 = self launchgrenade("frag_grenade_zm", var_10, var_11, var_15);
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

  if(should_reset_scriptable_states_on_death()) {
    scripts\cp\zombies\zombie_scriptable_states::turn_off_states_on_death(self);
  }

  if(scripts\engine\utility::flag_exist("force_drop_max_ammo") && scripts\engine\utility::flag("force_drop_max_ammo") && var_3 != "MOD_SUICIDE") {
    if(isDefined(level.drop_max_ammo_func)) {
      level thread[[level.drop_max_ammo_func]](self.origin, var_1, "ammo_max", undefined, undefined, 1);
    }

    scripts\engine\utility::flag_clear("force_drop_max_ammo");
  }

  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(level.updaterecentkills_func) && isPlayer(var_1)) {
    var_1 thread[[level.updaterecentkills_func]](self, var_4);
  }

  if(getweaponbasename(var_4) == "iw7_cutie_zm" && scripts\engine\utility::istrue(self.affectedbyfovdamage)) {
    self playSound("bullet_atomizer_impact_npc");
    if(isDefined(self.body)) {
      self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
      self.body hide(1);
    }

    self.affectedbyfovdamage = undefined;
  }

  if((scripts\engine\utility::isbulletdamage(var_3) && getweaponbasename(var_4) == "iw7_atomizer_mp" || scripts\engine\utility::istrue(self.atomize_me)) || var_3 == "MOD_UNKNOWN" && getweaponbasename(var_4) == "iw7_harpoon3_zm" || var_3 == "MOD_UNKNOWN" && getweaponbasename(var_4) == "iw7_lasertrap_zm") {
    if(!var_16 && !var_13 && !var_14 && !var_15 && !scripts\cp\utility::agentisfnfimmune()) {
      self playSound("bullet_atomizer_impact_npc");
      if(isDefined(self.body)) {
        self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isPlayer(var_1)) {
    if(isDefined(level.on_zombie_killed_quests_func)) {
      [[level.on_zombie_killed_quests_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    if(isDefined(var_4) && var_4 == "iw7_knife_zm_cleaver") {
      if(iscrog(self)) {
        if(isDefined(level.crogs_cleaved)) {
          level.crogs_cleaved++;
        }

        level thread scripts\cp\utility::add_to_notify_queue("cleaver_kill", self, self.origin, var_4, var_3);
      } else {
        level thread scripts\cp\utility::add_to_notify_queue("cleaver_kill_zombie");
      }
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self, self.origin, var_4, var_3);
  }

  if(!scripts\cp\agents\gametype_zombie::isonhumanteam(self)) {
    scripts\cp\agents\gametype_zombie::enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
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

    level thread[[level.medusa_killed_func]](self.origin, self.near_medusa, scripts\engine\utility::istrue(self.dismember_crawl));
  }

  if(isDefined(self.near_crystal) && !var_16) {
    if(isDefined(level.closest_crystal_func)) {
      var_17 = level[[level.closest_crystal_func]](self);
    } else {
      var_17 = undefined;
    }

    if(isDefined(var_17)) {
      if(isDefined(level.crystal_killed_notify)) {
        thread scripts\cp\agents\gametype_zombie::delayminiufocollection(self.origin, var_4, var_17);
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
  if(isPlayer(var_1)) {
    if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
      if(isDefined(level.cryptidkillswithvenomx)) {
        if(level.splchosenagent == "cryptids" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom") {
          if(issubstr(var_4, "venomx")) {
            level thread scripts\cp\utility::add_to_notify_queue("venomx_kill", self, self.origin, var_4, var_3);
            level.cryptidkillswithvenomx++;
          }
        }
      }
    } else if(isDefined(level.cryptidkillswithvenomxpap2)) {
      if(level.splchosenagentpap2 == "special.zombies" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "zombie_clown" || self.agent_type == "karatemaster") {
        if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2) {
          level.cryptidkillswithvenomxpap2 = level.chosen_number_for_morse_code_pap2;
        } else if(issubstr(var_4, "venomx")) {
          level thread scripts\cp\utility::add_to_notify_queue("venomx_pap1_kill", self, self.origin, var_4, var_3);
          level.cryptidkillswithvenomxpap2++;
        }
      }
    }
  }

  if(self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "alien_rhino") {
    if(getDvar("scr_easy_egg_drop", "") != "") {
      level thread scripts\cp\maps\cp_final\cp_final_venomx_quest::spawn_egg_interaction_for_players(self.origin);
    } else if(randomint(100) > 90) {
      var_18 = 0;
      if(isPlayer(var_1)) {
        var_19 = var_1 getweaponslistall();
        foreach(var_1B in var_19) {
          if(issubstr(var_1B, "venomx")) {
            var_18 = 1;
            break;
          }
        }
      }

      if((scripts\engine\utility::flag("completepuzzles_step4") && scripts\engine\utility::istrue(var_18)) || scripts\engine\utility::istrue(level.directors_cut_is_activated) || scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        level thread scripts\cp\maps\cp_final\cp_final_venomx_quest::spawn_egg_interaction_for_players(self.origin);
      }
    }
  }

  scripts\cp\agents\gametype_zombie::process_kill_rewards(var_0, var_1, self, var_6, var_3, var_4);
  scripts\cp\agents\gametype_zombie::process_assist_rewards(var_1);
  scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(var_1, var_4, var_6, var_3, self.agent_type);
  if(isDefined(level.death_challenge_update_func)) {
    [[level.death_challenge_update_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  if(isDefined(var_1.owner)) {
    var_1.owner scripts\cp\utility::bufferednotify("kill_event_buffered", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, self.agent_type);
  } else if(isPlayer(var_1)) {
    var_1 scripts\cp\utility::bufferednotify("kill_event_buffered", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, self.agent_type);
  }

  scripts\cp\cp_agent_utils::deactivateagent();
  if(isDefined(level.cp_rave_zombie_death_pos_record_func)) {
    [[level.cp_rave_zombie_death_pos_record_func]](self.origin);
  }

  level thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self.origin, var_4, var_3, var_1);
}

should_reset_scriptable_states_on_death() {
  if(isDefined(self.agent_type)) {
    switch (self.agent_type) {
      case "generic_zombie":
        return 1;
    }
  }

  return 0;
}

callback_finalzombieplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  if(!scripts\cp\zombies\zombie_damage::shouldtakedamage(var_2, var_1, var_5, var_3)) {
    return;
  }

  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_5])) {
      level thread[[level.overcook_func[var_5]]](var_12, var_5);
    }
  }

  var_13 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_14 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_15 = scripts\cp\zombies\zombie_damage::isfriendlyfire(self, var_1);
  var_10 = scripts\cp\utility::is_hardcore_mode();
  var_11 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_12 = scripts\cp\utility::has_zombie_perk("perk_machine_change");
  var_13 = isDefined(var_1);
  var_14 = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "generic_zombie" || var_1.agent_type == "skeleton";
  var_15 = var_13 && var_1 == self;
  var_16 = (var_15 || !var_13) && var_4 == "MOD_SUICIDE";
  if(var_13) {
    if(var_1 == self) {
      if(var_13) {
        var_17 = self getstance();
        if(var_11) {
          var_2 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_17 == "crouch" || var_17 == "prone") && self isonground()) {
          var_2 = 0;
        } else {
          var_2 = scripts\cp\zombies\zombie_damage::get_explosive_damage_on_player(var_0, var_1, var_2, var_3, var_4, var_5);
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
    } else if(var_15) {
      if(var_10) {
        if(scripts\cp\utility::is_ricochet_damage()) {
          if(isPlayer(var_1) && isDefined(var_8) && var_8 != "shield") {
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
    } else if(var_14 || isDefined(var_1.agent_type) && var_1.agent_type == "alien_goon") {
      if(var_4 != "MOD_EXPLOSIVE" && var_12 scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(var_1.is_burning)) {
          var_12 scripts\cp\utility::notify_used_consumable("burned_out");
          var_1 thread scripts\cp\utility::damage_over_time(var_1, var_12, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
          var_1.faf_burned_out = 1;
        }
      }

      var_18 = gettime();
      if(!isDefined(self.last_zombie_hit_time) || var_18 - self.last_zombie_hit_time > 20) {
        self.last_zombie_hit_time = var_18;
      } else {
        return;
      }

      if(scripts\engine\utility::istrue(self.back_shield)) {
        var_19 = (0, 0, 0);
        if(isDefined(var_7)) {
          var_19 = var_7;
          var_1A = anglesToForward(self.angles) * -1;
          var_1B = vectordot(var_1A, var_19);
          if(var_1B < -0.25) {
            return;
          }
        }
      }

      var_1C = 500;
      if(getdvarint("zom_damage_shield_duration") != 0) {
        var_1C = getdvarint("zom_damage_shield_duration");
      }

      if(isDefined(var_1.last_damage_time_on_player[self.vo_prefix])) {
        var_1D = var_1.last_damage_time_on_player[self.vo_prefix];
        if(var_1D + var_1C > gettime()) {
          var_2 = 0;
        } else {
          var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else {
        var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
      }
    }

    if(var_14) {
      var_17 = self getstance();
      if(var_11) {
        var_2 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_17 == "crouch" || var_17 == "prone") && self isonground()) {
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
    var_17 = self getstance();
    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_17 == "crouch" || var_17 == "prone") && self isonground()) {
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

  var_1E = 0;
  if(var_13 && var_1 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.linked_to_player)) {
    if(self.health - var_2 < 1) {
      var_2 = self.health - 1;
    }
  }

  if(var_14 || var_15 && !var_16) {
    var_2 = int(var_2 * var_12 scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    var_2 = int(max(self.maxhealth / 2.75, var_2));
  }

  if(var_12 scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_1)) {
    var_1F = 0;
    if(isDefined(var_1.agent_type) && var_1.agent_type == "crab_mini" || var_1.agent_type == "crab_brute" || var_1 scripts\cp\utility::agentisfnfimmune() || var_1.agent_type == "alien_goon") {
      var_1F = 0;
    } else if(isPlayer(var_12) && isPlayer(var_1)) {
      var_1F = 0;
    } else {
      var_1F = 1;
    }

    if(var_1F) {
      var_1 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_12);
      var_12 scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_2 = int(var_2);
  if(!var_15 || var_10) {
    scripts\cp\zombies\zombie_damage::finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_1E, var_10, var_11);
    thread scripts\cp\utility::add_to_notify_queue("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_2);
  if(var_2 <= 0) {
    return;
  }

  thread scripts\cp\utility::player_pain_vo(var_1);
  thread scripts\cp\zombies\zombie_damage::play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();
  if(var_12) {
    self notify("change_chews_damage", var_2, self.health);
  }

  if(isDefined(var_1)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();
    if(isagent(var_1)) {
      if(var_2 > self.health) {
        var_1.killed_player = 1;
      }

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

damage_from_escort_vehicle(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.var_336) && var_0.var_336 == "bomb_vehicle" && isDefined(var_1) && var_1 == "MOD_CRUSH") {
    return 1;
  }

  return 0;
}

playbodyfx_ww(var_0, var_1, var_2) {
  var_3[0][1]["org"] = self gettagorigin("j_spinelower");
  var_3[0][1]["angles"] = self gettagangles("j_spinelower");
  var_4 = undefined;
  var_5 = undefined;
  if(issubstr(var_0, "iw7_harpoon1_zm") || issubstr(var_0, "iw7_acid_rain_projectile_zm")) {
    self hide(0);
    var_1.nocorpse = 0;
    var_1.full_gib = 0;
    var_3[0][0]["org"] = self gettagorigin("j_spineupper");
    var_3[0][0]["angles"] = self gettagangles("j_spineupper");
    var_4 = level._effect["wrecked_cheap"];
    var_5 = level._effect["acid_rain_death"];
  } else if(issubstr(var_0, "iw7_harpoon2_zm")) {
    var_4 = level._effect["wrecked_by_ben"];
  } else {
    var_4 = level._effect["wrecked_cheap"];
  }

  foreach(var_7 in var_3) {
    foreach(var_9 in var_7) {
      if((issubstr(var_0, "iw7_harpoon1_zm") || issubstr(var_0, "iw7_acid_rain_projectile_zm")) && !scripts\engine\utility::istrue(level.played_acid_rain_effect)) {
        level.played_acid_rain_effect = 1;
        if(isDefined(var_4)) {
          playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));
        }

        scripts\engine\utility::waitframe();
        if(isDefined(var_5)) {
          playFX(var_5, var_9["org"]);
          scripts\engine\utility::waitframe();
        }

        continue;
      }

      if((issubstr(var_0, "iw7_harpoon2_zm") || issubstr(var_0, "iw7_harpoon2_zm_stun")) && !scripts\engine\utility::istrue(level.played_ben_franklin_effect)) {
        level.played_ben_franklin_effect = 1;
        if(isDefined(var_4)) {
          playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));
        }

        scripts\engine\utility::waitframe();
        continue;
      }

      if(isDefined(var_4)) {
        playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));
      }

      scripts\engine\utility::waitframe();
    }

    wait(0.01);
  }
}

is_kung_fu_punch(var_0, var_1) {
  switch (var_1) {
    case "iw7_fists_zm_tiger":
    case "iw7_fists_zm_snake":
    case "iw7_fists_zm_dragon":
    case "iw7_fists_zm_crane":
      return 1;

    default:
      break;
  }

  return 0;
}

slasher_processdamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!scripts\engine\utility::isbulletdamage(var_4)) {
    if(scripts\cp\utility::is_trap(var_0, var_5)) {
      return;
    }

    var_11 = gettime();
    if(isDefined(var_1.nexthittime) && var_1.nexthittime > var_11) {
      return;
    } else {
      var_1.nexthittime = var_11 + 250;
    }
  }

  if(scripts\asm\asm::asm_isinstate("block_loop")) {
    return;
  }

  var_12 = "standard";
  var_13 = undefined;
  if(var_10.health <= var_2) {
    var_13 = 1;
  }

  var_14 = scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  if(var_14) {
    var_12 = "hitcritical";
  }

  var_15 = scripts\engine\utility::isbulletdamage(var_4);
  var_10 = var_14 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
  var_11 = var_15 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
  var_12 = var_15 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
  var_13 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_14 = !var_13 && var_14 && var_15 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_15 = !scripts\cp\utility::isreallyalive(var_10) || isagent(var_10) && var_2 >= var_10.health;
  var_16 = var_4 == "MOD_EXPLOSIVE_BULLET" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_17 = var_4 == "MOD_MELEE";
  if(scripts\engine\utility::istrue(var_10.armor_hit)) {
    var_12 = "hitalienarmor";
  } else if(var_10 || var_11 || var_12 || var_14) {
    var_12 = "card_boosted";
  } else if(isPlayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_16) {
    var_12 = "high_damage";
  } else if(isPlayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_17) {
    var_12 = "high_damage";
  } else if(isPlayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_15) {
    var_12 = "high_damage";
  } else if(isPlayer(var_1) && scripts\engine\utility::istrue(var_1.deadeye_charge) && var_15) {
    var_12 = "special_weapon";
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1.owner thread scripts\cp\cp_damage::updatedamagefeedback(var_12, var_13, var_2, var_10.riotblock);
    } else {
      var_1 thread scripts\cp\cp_damage::updatedamagefeedback(var_12, var_13, var_2, var_10.riotblock);
    }
  }

  if(scripts\engine\utility::istrue(self.armor_hit)) {
    self.armor_hit = 0;
  }
}

change_chews_damage_over_time(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * var_2;
  var_5 = var_0.origin;
  var_6 = sortbydistance(level.spawned_enemies, var_1.origin);
  var_7 = 0;
  foreach(var_9 in var_6) {
    if(var_9 == var_0) {
      continue;
    }

    if(isDefined(var_9.chew_effect_time) && var_9.chew_effect_time == gettime()) {
      continue;
    }

    if(isDefined(var_9.agent_type) && var_9.agent_type != "generic_zombie") {
      continue;
    }

    if(distancesquared(var_5, var_9.origin) < var_4) {
      var_9.chew_effect_time = gettime();
      var_7++;
      switch (var_3) {
        case "frozen":
          var_9 thread change_chews_frozen_damage(var_1, var_5);
          if(var_7 >= 6) {
            return;
          }
          break;

        case "burning":
          var_9 thread change_chews_fire_damage(var_1, var_5);
          if(var_7 >= 8) {
            return;
          }
          break;

        case "shocked":
          var_9 thread change_chews_shock_damage(var_1, var_5);
          if(var_7 >= 10) {
            return;
          }
          break;

        case "explode":
          var_9 thread change_chews_explosive_damage(var_1, var_5);
          if(var_7 >= 5) {
            return;
          }
          break;

        default:
          break;
      }

      wait(0.1);
      continue;
    }

    wait(0.1);
  }
}

change_chews_frozen_damage(var_0, var_1) {
  self endon("death");
  self.isfrozen = 1;
  var_2 = self.health;
  self.health = 1;
  wait(10);
  self.isfrozen = undefined;
  if(var_2 > 0) {
    self.health = var_2;
  }
}

change_chews_fire_damage(var_0, var_1) {
  self endon("death");
  if(isalive(self) && !scripts\engine\utility::istrue(self.marked_for_death)) {
    self.marked_for_death = 1;
    thread scripts\cp\utility::damage_over_time(self, var_0, 5, 1900, undefined, "iw7_fwoosh_zm", 0, "burning", "fwoosh_kill");
  }
}

change_chews_shock_damage(var_0, var_1) {
  self endon("death");
  thread scripts\cp\zombies\zombies_perk_machines::zap_over_time(2, var_0);
}

change_chews_explosive_damage(var_0, var_1) {
  self dodamage(self.health + 1000, var_1, var_0, var_0, "MOD_EXPLOSIVE", "iw7_change_chews_zm");
}

iscrog(var_0) {
  return isDefined(var_0.agent_type) && var_0.agent_type == "crab_brute" || var_0.agent_type == "crab_mini";
}