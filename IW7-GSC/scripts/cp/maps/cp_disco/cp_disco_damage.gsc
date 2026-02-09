/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_damage.gsc
********************************************************/

cp_disco_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  if(!isDefined(self.agent_type)) {
    return;
  }

  if(isDefined(var_5)) {
    switch (var_5) {
      case "iw7_shuriken_zm_crane":
      case "iw7_shuriken_zm_tiger":
      case "iw7_shuriken_zm_dragon":
      case "iw7_shuriken_zm_snake":
      case "iw7_shuriken_crane_proj":
      case "iw7_shuriken_snake_proj":
      case "iw7_shuriken_tiger_proj":
      case "iw7_shuriken_dragon_proj":
        self playSound("kungfu_shuriken_zombie_dmg");
        break;

      default:
        break;
    }
  }

  self.kung_fu_punched = undefined;
  if(var_4 != "MOD_SUICIDE") {
    if(!isDefined(var_1) || !scripts\engine\utility::istrue(var_1.battackzombies)) {
      if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_1)) {
        return;
      }

      if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_0)) {
        return;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_13 = scripts\cp\agents\gametype_zombie::should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_12);
  if(!var_13) {
    return;
  }

  var_14 = var_4 == "MOD_MELEE";
  var_15 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_10 = scripts\engine\utility::istrue(var_12.is_suicide_bomber);
  var_3 = var_3 | 4;
  var_11 = isDefined(var_1) && isPlayer(var_1);
  var_12 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_13 = var_12 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_14 = scripts\engine\utility::istrue(self.battleslid);
  var_15 = scripts\engine\utility::istrue(level.insta_kill) && !scripts\cp\utility::agentisinstakillimmune();
  var_16 = (var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_17 = !var_15 && var_13 && var_12 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_18 = var_14 && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_19 = var_14 && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  var_1A = scripts\cp\utility::isaltmodeweapon(var_5);
  var_1B = scripts\cp\utility::agentisfnfimmune();
  var_1C = scripts\cp\utility::agentisinstakillimmune();
  var_1D = getweaponbasename(var_5);
  var_1E = var_11 && var_5 == "iw7_nunchucks_zm";
  var_1F = var_11 && var_1D == "iw7_nunchucks_zm_pap1";
  var_20 = var_11 && var_1D == "iw7_nunchucks_zm_pap2";
  if(isDefined(var_5) && issubstr(var_5, "iw7_gauss_zml")) {
    var_21 = 250;
    if(scripts\cp\utility::weaponhasattachment(var_5, "pap1")) {
      var_21 = 470;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "pap2")) {
      var_21 = 734;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "doubletap")) {
      var_21 = 1.33 * var_21;
    }

    if(var_2 >= var_21) {
      self.hitbychargedshot = var_1;
    }
  }

  if(var_11) {
    if(var_1E || var_1F || var_20) {
      self.full_gib = 1;
      self.customdeath = 1;
      self.nocorpse = 1;
    }

    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_marked_target", var_1, var_2, var_4, var_5, self);
    }

    self.damaged_by_player = 1;
    if(scripts\engine\utility::istrue(var_1.stimulus_active)) {
      playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
      scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", self gettagorigin("j_spineupper"));
      foreach(var_23 in level.players) {
        if(var_23 == var_1) {
          if(distance2dsquared(var_23.origin, self.origin) <= 10000) {
            playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
            playFX(level._effect["stimulus_shield"], var_23 gettagorigin("tag_eye"), anglesToForward(var_23.angles), anglestoup(var_23.angles), var_23);
            if(var_2 >= self.health) {
              if(scripts\engine\utility::istrue(var_23.inlaststand)) {
                scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_23);
              }
            }

            if(var_23.health + var_2 / level.players.size + 1 >= var_23.maxhealth) {
              var_23.health = var_23.maxhealth;
            } else {
              var_23.health = int(var_23.health + var_2 / level.players.size + 1);
            }
          }

          continue;
        }

        if(distance2dsquared(var_23.origin, self.origin) <= 10000) {
          playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
          playFX(level._effect["stimulus_shield"], var_23 gettagorigin("tag_eye"));
          if(var_2 >= self.health) {
            if(scripts\engine\utility::istrue(var_23.inlaststand)) {
              scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_23);
            }
          }

          if(int(var_23.health + var_2 / level.players.size + 1) >= var_23.maxhealth) {
            var_23.health = var_23.maxhealth;
            continue;
          }

          var_23.health = int(var_23.health + var_2 / level.players.size + 1);
        }
      }
    }

    if(scripts\engine\utility::istrue(var_1.snake_super)) {
      var_1 playlocalsound("kungfu_snake_super_hit_zombie");
    }
  }

  if(isDefined(var_1.is_turned) && var_1.is_turned && var_4 != "MOD_SUICIDE") {
    var_2 = var_1.melee_damage_amt;
  }

  var_25 = 0;
  if(!var_14 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5) && var_11 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_25 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
  }

  var_26 = !var_1B && scripts\engine\utility::istrue(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";
  var_27 = !var_1C && var_14 || var_15 || var_19 || var_26 || var_17 || var_18 || var_25;
  var_28 = isDefined(self.isfrozen);
  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(var_5) && !var_1C) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(var_0.origin, var_6, var_7);
    return;
  } else if(var_27 && !var_1B) {
    if(var_25) {
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    if(var_1E) {
      self.nocorpse = 1;
      self.full_gib = 1;
    }

    if(var_1F) {
      self.nocorpse = 1;
      self.full_gib = 1;
      var_1 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(var_5, var_1, self, var_4, var_8);
    }

    if(var_20) {
      self.nocorpse = 1;
      self.full_gib = 1;
      self.dontmutilate = 1;
      var_1 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(var_5, var_1, self, var_4, var_8);
      var_1 thread scripts\cp\maps\cp_disco\cp_disco::nunchucks_recent_kills(self, var_5);
      if(scripts\engine\utility::istrue(var_1.isreaping)) {
        if(var_1.health + var_2 <= var_1.maxhealth) {
          var_1.health = var_1.health + var_2;
        } else {
          var_1.health = var_1.maxhealth;
        }
      }
    }

    var_2 = int(self.maxhealth);
    if(var_19) {
      if(isDefined(var_6)) {
        playFX(level._effect["shock_melee_impact"], var_6);
      }

      var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_19);
    }

    if(var_12) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    }
  } else if(!var_1B) {
    var_8 = scripts\cp\agents\gametype_zombie::shitloc_mods(var_1, var_4, var_5, var_8);
    var_29 = level.wave_num;
    var_2A = scripts\cp\agents\gametype_zombie::is_grenade(var_5, var_4);
    var_2B = scripts\engine\utility::istrue(self.is_burning) && !var_12;
    var_2C = var_13 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_2D = var_12 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_2E = var_12 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_2F = var_12 && isDefined(var_1.special_ammo_weapon) && var_1.special_ammo_weapon == var_5;
    var_30 = var_11 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_31 = var_11 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_32 = scripts\cp\agents\gametype_zombie::is_axe_weapon(var_5);
    var_33 = scripts\engine\utility::array_contains(level.melee_weapons, var_5);
    var_1D = getweaponbasename(var_5);
    var_34 = var_11 && var_5 == "iw7_katana_zm" || var_1D == "iw7_katana_zm_pap1" || var_1D == "iw7_katana_zm_pap2";
    var_35 = var_11 && issubstr(var_5, "shuriken");
    var_36 = weaponclass(var_5) == "spread" && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "smart");
    var_37 = weaponclass(var_5) == "spread" && !var_36 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "arkpink") || scripts\cp\cp_weapon::has_attachment(var_5, "arkyellow");
    var_38 = var_13 && var_12 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "highcal");
    if(var_1A && issubstr(var_5, "+gl")) {
      var_2 = scripts\cp\agents\gametype_zombie::scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(var_36) {
      var_2 = var_2 * 0.5;
    }

    if(isDefined(var_2) && isDefined(var_8) && !var_15 && var_12) {
      var_39 = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_12, var_1, var_2, var_8, var_7);
      if(var_39 <= 0) {
        return;
      }

      var_2 = var_39;
    }

    var_2 = scripts\cp\agents\gametype_zombie::initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);
    if(var_37) {
      var_2 = var_2 * 4;
    }

    if(var_11) {
      if(var_14) {
        if(var_1 scripts\cp\cp_weapon::has_attachment(var_5, "meleervn")) {
          var_2 = var_2 + int(1500 * var_1 scripts\cp\cp_weapon::get_weapon_level(var_5));
        }

        var_2 = int(var_2 * var_1 scripts\cp\perks\perk_utility::perk_getmeleescalar());
        if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
          if(is_kung_fu_punch(var_1, var_5)) {
            var_2 = 10000;
          }
        }

        if(isDefined(var_1.passive_melee_kill_damage)) {
          var_2 = var_2 + var_1.passive_melee_kill_damage;
        }

        if(var_31) {
          var_2 = var_2 + 1500;
        }

        var_3A = 0;
        if(var_2 >= self.health) {
          var_3A = 1;
        }

        if(isDefined(var_1.increased_melee_damage)) {
          var_2 = var_2 + var_1.increased_melee_damage;
        }

        if(var_1F) {
          var_1 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(var_5, var_1, self, var_4, var_8);
        }

        if(var_20) {
          var_1 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(var_5, var_1, self, var_4, var_8);
          var_1 thread scripts\cp\maps\cp_disco\cp_disco::nunchucks_recent_kills(self, var_5);
          if(scripts\engine\utility::istrue(var_1.isreaping)) {
            if(var_1.health + var_2 <= var_1.maxhealth) {
              var_1.health = var_1.health + var_2;
            } else {
              var_1.health = var_1.maxhealth;
            }
          }
        }

        if(var_34) {
          var_1 thread scripts\cp\utility::add_to_notify_queue("katana_melee_hit", var_5, self, var_2);
          if(var_12.agent_type != "skater" && var_12.agent_type != "karatemaster") {
            if(var_2 >= self.health) {
              level thread handlegoreeffect(self, var_1, var_5);
            }
          }
        }

        if(var_33 && var_3A) {
          var_1 thread scripts\cp\utility::add_to_notify_queue("melee_weapon_hit", var_5, self, var_2);
        }

        if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
          if(var_3A && !isDefined(self.launched)) {
            var_3B = 3500;
            self.kung_fu_punched = 1;
            self.ragdollhitloc = var_8;
            if(lengthsquared(var_7) < 1) {
              var_3C = self.origin - var_1.origin;
              var_3C = vectornormalize((var_3C[0], var_3C[1], 0));
              self.ragdollimpactvector = var_3C * var_3B;
            } else {
              self.ragdollimpactvector = var_7 * var_3B;
            }

            thread chi_hit(var_1, var_5, var_6);
            var_1 scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(50);
            var_3D = 1;
            thread kung_fu_damage_everyone_in_radius(self.origin, 96, var_1, var_3D);
          }
        } else if(var_32 || var_31) {
          if(var_32) {
            var_1 thread scripts\cp\utility::add_to_notify_queue("axe_melee_hit", var_5, self, var_2);
            if(var_3A && !isDefined(self.launched)) {
              thread scripts\cp\agents\gametype_zombie::launch_and_kill(var_1, var_5, var_31);
              return;
            }
          } else if(var_3A) {
            self.slappymelee = 1;
          }
        }
      }

      if(var_35) {
        var_2 = 100000000;
      }

      if(scripts\engine\utility::istrue(var_1.crane_super)) {
        var_3B = 3500;
        self.ragdollhitloc = var_8;
        if(lengthsquared(var_7) < 1) {
          var_3C = self.origin - var_1.origin;
          var_3C = vectornormalize((var_3C[0], var_3C[1], 0));
          self.ragdollimpactvector = var_3C * var_3B;
        } else {
          self.ragdollimpactvector = var_7 * var_3B;
        }

        var_3E = playfxontagforclients(level._effect["screen_blood"], var_1, "tag_eye", var_1);
      }

      if(var_2F) {
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, var_2, var_4, 128);
      }

      if(var_30 && var_16) {
        var_2 = int(var_2 * 2);
      }

      if(scripts\engine\utility::istrue(var_1.rave_mode)) {
        var_2 = int(var_2 * 2);
      }

      if(self.agent_type == "skater") {
        if(randomint(100) > 40) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_skater", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      }

      if(self.agent_type == "karatemaster") {
        if(randomint(100) > 40) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_kungfu", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      }
    }

    if(var_2C) {
      var_2 = var_2 * 3;
    }

    if(var_2D) {
      var_3F = int(var_1 getweaponammoclip(var_1 getcurrentweapon()) + 1);
      var_40 = weaponclipsize(var_1 getcurrentweapon());
      if(var_3F <= 4) {
        var_2 = var_2 * 2;
      }
    }

    if(var_12 && scripts\engine\utility::istrue(var_1.reload_damage_increase)) {
      var_2 = var_2 * 2;
    }

    if(var_2A) {
      var_2 = var_2 * min(2 + var_29 * 0.5, 10);
    }

    if(var_2E) {
      var_2 = int(var_2 * 2);
    }

    if(var_38) {
      var_2 = var_2 * 1.2;
    }
  }

  if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2 && var_12) {
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
  var_2 = scripts\cp\agents\gametype_zombie::fateandfortuneweaponscale(self, var_5, var_2, 0, 0, 0, 0);
  if(isDefined(level.onzombiedamage_func)) {
    var_2 = [[level.onzombiedamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(isDefined(var_1.special_zombie_damage) && scripts\cp\utility::agentisspecialzombie()) {
    var_2 = var_2 * var_1.special_zombie_damage;
  }

  if(isDefined(self.hitbychargedshot) && !self.health - var_2 < 1) {
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
  }

  if(var_11) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(var_5));
    if(var_12) {
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
  scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  if(var_11) {
    thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(var_1);
  }

  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

handlegoreeffect(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.katanadeath = 1;
  var_0.precacheleaderboards = 1;
  var_0 clearpath();
  var_0.scripted_mode = 1;
  var_3 = var_0 gettagorigin("j_neck");
  if(var_0.agent_type == "skater") {
    var_0 dodamage(var_0.health + 1000, var_0.origin, var_1, undefined, "MOD_EXPLOSIVE", "iw7_katana_zm");
    return;
  }

  var_0 setscriptablepartstate("katana_death", "active", 1);
  var_4 = ["left_arm", "right_arm"];
  var_4 = scripts\engine\utility::array_randomize(var_4);
  foreach(var_6 in level.players) {
    if(distance(var_6.origin, var_0.origin) <= 512) {
      var_6 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(!scripts\engine\utility::istrue(var_0.is_cop)) {
    var_3 = var_0 gettagorigin("j_spine4");
    playFX(level._effect["gore"], var_3, (1, 0, 0));
    if(issubstr(var_2, "katana")) {
      playsoundatpos(var_3, "gib_fullbody_katana");
    } else {
      playsoundatpos(var_3, "gib_fullbody");
    }

    var_0 setscriptablepartstate("head", "detached", 1);
    foreach(var_9 in var_4) {
      var_0 setscriptablepartstate(var_9, "detached", 1);
    }
  } else {
    foreach(var_9 in var_5) {
      var_0 setscriptablepartstate(var_9, "detached", 1);
    }
  }

  wait(2);
  var_4 = ["right_leg", "left_leg"];
  var_4 = scripts\engine\utility::array_randomize(var_4);
  foreach(var_9 in var_4) {
    var_0 setscriptablepartstate(var_9, "detached", 1);
  }

  var_0.full_gib = 1;
  var_0.katanadeath = 0;
  var_0.scripted_mode = 0;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_1, undefined, "MOD_EXPLOSIVE", "iw7_katana_zm");
}

cp_disco_onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.spawn_fx)) {
    self.spawn_fx delete();
  }

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(issubstr(var_4, "iw7_knife") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if((var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if(issubstr(var_4, "golf") || issubstr(var_4, "machete") || issubstr(var_4, "spiked_bat") || issubstr(var_4, "two_headed_axe")) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
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

  var_14 = 0;
  var_15 = 0;
  var_10 = 0;
  var_11 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(level.updaterecentkills_func) && isPlayer(var_1)) {
    var_1 thread[[level.updaterecentkills_func]](self, var_4);
  }

  if((scripts\engine\utility::isbulletdamage(var_3) && getweaponbasename(var_4) == "iw7_atomizer_mp" || scripts\engine\utility::istrue(self.atomize_me)) || var_3 == "MOD_UNKNOWN" && getweaponbasename(var_4) == "iw7_harpoon3_zm") {
    if(!var_11 && !var_14 && !var_15 && !var_10) {
      self playSound("bullet_atomizer_impact_npc");
      if(isDefined(self.body)) {
        self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self, self.origin, var_4, var_3);
  }

  if(isDefined(level.on_zombie_killed_quests_func)) {
    [[level.on_zombie_killed_quests_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(!scripts\cp\agents\gametype_zombie::isonhumanteam(self)) {
    scripts\cp\agents\gametype_zombie::enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    if(isDefined(level.onzombiekilledfunc)) {
      [[level.onzombiekilledfunc]](var_1, var_4);
    }
  }

  var_1 scripts\cp\zombies\zombies_consumables::headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
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

  if(isDefined(self.near_crystal) && !var_11) {
    if(isDefined(level.closest_crystal_func)) {
      var_12 = level[[level.closest_crystal_func]](self);
    } else {
      var_12 = undefined;
    }

    if(isDefined(var_12)) {
      if(isDefined(level.crystal_killed_notify)) {
        thread scripts\cp\agents\gametype_zombie::delayminiufocollection(self.origin, var_4, var_12);
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
  disco_process_kill_rewards(var_0, var_1, self, var_6, var_3, var_4);
  scripts\cp\agents\gametype_zombie::process_assist_rewards(var_1);
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
  if(isDefined(level.cp_rave_zombie_death_pos_record_func)) {
    [[level.cp_rave_zombie_death_pos_record_func]](self.origin);
  }

  level thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self.origin, var_4, var_3, var_1, self);
}

disco_process_kill_rewards(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\cp\agents\gametype_zombie::give_attacker_kill_rewards(var_0, var_1, var_3, var_4, var_5);
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
      if(issubstr(var_5, "heart")) {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_heart", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
      } else {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_headshot", "disco_comment_vo", "low", 10, 0, 0, 0, 10);
      }
    } else {
      if(scripts\engine\utility::istrue(var_7.kung_fu_mode)) {
        if(randomint(100) > 30) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_kungfumode", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
        } else {
          var_10 = 1;
          if(issubstr(var_5, "nunchucks")) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_nunchuck", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
          } else if(issubstr(var_5, "katana")) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_katana", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
          } else if(issubstr(var_5, "heart")) {
            var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_heart", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
          }
        }
      }

      if(var_10 != 1) {
        if(issubstr(var_5, "nunchucks")) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_nunchuck", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
        } else if(issubstr(var_5, "katana")) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_katana", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
        } else if(issubstr(var_5, "heart")) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_heart", "disco_comment_vo", "high", 10, 0, 0, 0, 10);
        }
      }
    }

    if(var_10 == 0) {
      if(var_2.agent_type == "skater") {
        if(randomint(100) > 60) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_skater", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      } else if(var_2.agent_type == "karatemaster") {
        if(randomint(100) > 60) {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_kungfumode", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      } else {
        var_7 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "disco_comment_vo", "low", 10, 0, 0, 0, 20);
      }
    }
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
      var_15 = isDefined(var_2.agent_type) && var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey";
      if(gettime() < level.last_drop_time + 5000) {
        return;
      }

      if(scripts\cp\utility::ent_is_near_equipment(self)) {
        return;
      }

      if(scripts\cp\utility::too_close_to_other_interactions(self.origin)) {
        return;
      }

      if(!var_9 && !var_15) {
        if(scripts\engine\utility::flag_exist("can_drop_coins") && scripts\engine\utility::flag("can_drop_coins") && isDefined(level.crafting_item_drop_func) && scripts\engine\utility::istrue([[level.crafting_item_drop_func]](var_6, self.origin, var_1))) {
          level.last_drop_time = gettime();
          return;
        }

        if(isDefined(level.loot_func) && scripts\engine\utility::flag_exist("zombie_drop_powerups") && scripts\engine\utility::flag("zombie_drop_powerups")) {
          [[level.loot_func]](var_6, self.origin, var_1);
          return;
        }

        return;
      }
    }
  }
}

play_rave_death_fx(var_0) {
  var_1 = ["j_spineupper", "j_spinelower"];
  if(!isDefined(var_0)) {
    var_2 = level._effect["atomize_body"];
  } else {
    var_2 = level._effect[var_1];
  }

  var_3 = spawnfx(var_2, self gettagorigin("j_spinelower"));
  foreach(var_5 in level.players) {
    if(!scripts\engine\utility::istrue(var_5.rave_mode)) {
      var_3 hidefromplayer(var_5);
      continue;
    }

    self hidefromplayer(var_5);
  }

  triggerfx(var_3);
  var_3 thread delete_death_fx(var_3);
}

delete_death_fx(var_0) {
  level endon("game_ended");
  wait(2.5);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

callback_discozombieplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
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
  var_10 = isDefined(var_5) && var_5 == "iw7_sasq_rock_mp";
  var_11 = scripts\cp\utility::is_hardcore_mode();
  var_12 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_13 = isDefined(var_1);
  var_14 = var_13 && isDefined(var_1.species) && var_1.species == "zombie";
  var_15 = var_13 && isDefined(var_1.species) && var_1.species == "zombie_grey";
  var_16 = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_brute";
  var_17 = var_13 && var_1 == self;
  var_18 = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_sasquatch";
  var_19 = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "slasher";
  var_1A = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "superslasher";
  var_1B = (var_17 || !var_13) && var_4 == "MOD_SUICIDE";
  if(var_13) {
    if(var_1 == self) {
      if(var_13) {
        var_1C = self getstance();
        if(var_12) {
          var_2 = 0;
        } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
          var_2 = 0;
        } else {
          var_2 = scripts\cp\zombies\zombie_damage::get_explosive_damage_on_player(var_0, var_1, var_2, var_3, var_4, var_5);
        }
      }

      switch (var_5) {
        case "iw7_shuriken_zm_crane":
        case "iw7_shuriken_zm_tiger":
        case "iw7_shuriken_zm_dragon":
        case "iw7_shuriken_zm_snake":
        case "iw7_shuriken_crane_proj":
        case "iw7_shuriken_snake_proj":
        case "iw7_shuriken_tiger_proj":
        case "iw7_shuriken_dragon_proj":
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
      if(var_11) {
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
    } else if(var_14) {
      if(scripts\engine\utility::istrue(self.kung_fu_shield)) {
        return;
      }

      if(var_4 != "MOD_EXPLOSIVE" && var_12 scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(var_1.is_burning)) {
          var_12 scripts\cp\utility::notify_used_consumable("burned_out");
          var_1 thread scripts\cp\utility::damage_over_time(var_1, var_12, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
          var_1.faf_burned_out = 1;
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

      if(isDefined(var_1.last_damage_time_on_player[self.vo_prefix])) {
        var_1F = var_1.last_damage_time_on_player[self.vo_prefix];
        if(var_1F + var_1E > gettime()) {
          var_2 = 0;
        } else {
          var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
        }
      } else {
        var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
      }
    }

    if(var_14) {
      var_1C = self getstance();
      if(var_12) {
        var_2 = 0;
      } else if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
        var_2 = 0;
      } else if(!var_11 || var_1 == self && var_8 == "none") {
        var_2 = 0;
      }
    }
  } else if(var_12 && var_4 == "MOD_SUICIDE") {
    if(var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm") {
      var_2 = 0;
    }
  } else {
    var_1C = self getstance();
    if(isDefined(self.has_fortified_passive) && self.has_fortified_passive && self issprintsliding() || (var_1C == "crouch" || var_1C == "prone") && self isonground()) {
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

  var_20 = 0;
  if(var_13 && var_1 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.linked_to_player)) {
    if(self.health - var_2 < 1) {
      var_2 = self.health - 1;
    }
  }

  if(var_14 || var_15 || var_16 || var_17 && !var_1B) {
    var_2 = int(var_2 * var_12 scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    var_2 = int(max(self.maxhealth / 2.75, var_2));
  }

  if(var_12 scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_1)) {
    var_21 = 0;
    if(isDefined(var_1.agent_type) && var_1.agent_type == "zombie_sasquatch" || var_1.agent_type == "slasher" || var_1.agent_type == "superslasher") {
      var_21 = 0;
    } else if(var_1 scripts\cp\utility::agentisfnfimmune()) {
      var_21 = 0;
    } else if(isPlayer(var_12) && isPlayer(var_1)) {
      var_21 = 0;
    } else {
      var_21 = 1;
    }

    if(var_21) {
      var_1 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_12);
      var_12 scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_2 = int(var_2);
  if(!var_15 || var_11) {
    scripts\cp\zombies\zombie_damage::finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_20, var_10, var_11);
    thread scripts\cp\utility::add_to_notify_queue("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_2);
  if(var_2 <= 0) {
    return;
  }

  if(var_10) {
    playfxontagforclients(level._effect["sasquatch_rock_hit"], self, "tag_eye", self);
  }

  thread scripts\cp\utility::player_pain_vo(var_1);
  thread scripts\cp\zombies\zombie_damage::play_pain_photo(self);
  if(isDefined(var_5) && var_5 == "iw7_ratking_shield_projectile") {
    self playlocalsound("rk_shield_throw_hit_plr");
  } else {
    self playlocalsound("zmb_player_impact_hit");
  }

  thread scripts\cp\utility::player_pain_breathing_sfx();
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

kung_fu_damage_everyone_in_radius(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::waitframe();
  var_4 = var_1 * var_1;
  foreach(var_6 in level.spawned_enemies) {
    if(scripts\engine\utility::istrue(var_6.kung_fu_punched)) {
      continue;
    }

    if(distancesquared(var_6.origin, var_0) < var_4) {
      var_7 = var_6.health + 1000;
      if(var_3) {
        var_7 = 1;
      }

      var_6 dodamage(var_7, var_2.origin, var_2, var_2, "MOD_MELEE", "iw7_fists_zm_base");
      scripts\engine\utility::waitframe();
    }
  }
}

chi_hit(var_0, var_1, var_2) {
  var_3 = 100;
  var_4 = 20;
  var_5 = vectornormalize(self.origin - var_0.origin) * var_3 + (0, 0, var_4);
  var_6 = self.origin + var_5;
  var_7 = level._effect["chi_ghost_hit_blue"];
  if(isDefined(var_0.kung_fu_progression.active_discipline)) {
    var_8 = var_0.kung_fu_progression.active_discipline;
    switch (var_8) {
      case "crane":
        var_0 thread play_scriptable_fx("crane_hit");
        var_7 = level._effect["chi_ghost_hit_blue"];
        break;

      case "dragon":
        var_0 thread play_scriptable_fx("dragon_hit");
        var_7 = level._effect["chi_ghost_hit_yellow"];
        break;

      case "snake":
        var_0 thread play_scriptable_fx("snake_hit");
        var_7 = level._effect["chi_ghost_hit_green"];
        break;

      case "tiger":
        var_0 thread play_scriptable_fx("tiger_hit");
        var_7 = level._effect["chi_ghost_hit_red"];
        break;

      default:
        break;
    }
  }
}

play_scriptable_fx(var_0) {
  self setscriptablepartstate("kung_fu_melee", var_0);
  wait(0.1);
  self setscriptablepartstate("kung_fu_melee", "off");
}