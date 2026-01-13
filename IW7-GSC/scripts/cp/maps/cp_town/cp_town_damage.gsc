/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_damage.gsc
******************************************************/

cp_town_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
  if(!isDefined(self.agent_type)) {
    return;
  }

  if(var_4 != "MOD_SUICIDE") {
    if(scripts\mp\mp_agent::is_friendly_damage(var_0C, var_1)) {
      return;
    }

    if(scripts\mp\mp_agent::is_friendly_damage(var_0C, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_0D = scripts\cp\agents\gametype_zombie::should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_0C);
  if(!var_0D) {
    return;
  }

  var_0E = scripts\engine\utility::istrue(var_0C.hit_by_dodging_player);
  var_0F = var_4 == "MOD_MELEE";
  var_10 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_11 = scripts\engine\utility::istrue(var_0C.is_suicide_bomber);
  var_3 = var_3 | 4;
  var_12 = isDefined(var_1) && isplayer(var_1);
  var_13 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_14 = var_13 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_15 = scripts\engine\utility::istrue(self.battleslid);
  var_16 = scripts\engine\utility::istrue(level.insta_kill) && !scripts\cp\utility::agentisinstakillimmune();
  var_17 = (var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_18 = !var_10 && var_14 && var_13 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_19 = var_0F && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_1A = var_0F && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  var_1B = scripts\cp\utility::isaltmodeweapon(var_5);
  var_1C = scripts\cp\utility::agentisfnfimmune();
  var_1D = scripts\cp\utility::agentisinstakillimmune();
  var_1E = var_12 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_change");
  var_1F = scripts\cp\utility::agentisspecialzombie();
  if(isDefined(var_5) && issubstr(var_5, "iw7_gauss_zml")) {
    var_20 = 250;
    if(scripts\cp\utility::weaponhasattachment(var_5, "pap1")) {
      var_20 = 470;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "pap2")) {
      var_20 = 734;
    }

    if(scripts\cp\utility::weaponhasattachment(var_5, "doubletap")) {
      var_20 = 1.33 * var_20;
    }

    if(var_2 >= var_20) {
      self.hitbychargedshot = var_1;
    }
  }

  if(var_12 && !var_1C) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_marked_target", var_1, var_2, var_4, var_5, self);
    }

    self.damaged_by_player = 1;
    if(scripts\engine\utility::istrue(var_1.stimulus_active)) {
      playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
      scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", self gettagorigin("j_spineupper"));
      foreach(var_22 in level.players) {
        if(var_22 == var_1) {
          if(distance2dsquared(var_22.origin, self.origin) <= 10000) {
            playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
            playFX(level._effect["stimulus_shield"], var_22 gettagorigin("tag_eye"), anglesToForward(var_22.angles), anglestoup(var_22.angles), var_22);
            if(var_2 >= self.health) {
              if(scripts\engine\utility::istrue(var_22.inlaststand)) {
                scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_22);
              }
            }

            if(var_22.health + var_2 / level.players.size + 1 >= var_22.maxhealth) {
              var_22.health = var_22.maxhealth;
            } else {
              var_22.health = int(var_22.health + var_2 / level.players.size + 1);
            }
          }

          continue;
        }

        if(distance2dsquared(var_22.origin, self.origin) <= 10000) {
          playFX(level._effect["stimulus_glow_burst"], self gettagorigin("j_spineupper"));
          playFX(level._effect["stimulus_shield"], var_22 gettagorigin("tag_eye"));
          if(var_2 >= self.health) {
            if(scripts\engine\utility::istrue(var_22.inlaststand)) {
              scripts\cp\zombies\zombies_consumables::revive_downed_entities(var_22);
            }
          }

          if(int(var_22.health + var_2 / level.players.size + 1) >= var_22.maxhealth) {
            var_22.health = var_22.maxhealth;
            continue;
          }

          var_22.health = int(var_22.health + var_2 / level.players.size + 1);
        }
      }
    }
  }

  if(isDefined(var_1.is_turned) && var_1.is_turned && var_4 != "MOD_SUICIDE") {
    var_2 = var_1.melee_damage_amt;
  }

  var_24 = 0;
  if(!var_0F && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5) && var_12 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_24 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
  }

  var_25 = !var_1C && scripts\engine\utility::istrue(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";
  var_26 = isDefined(var_5) && var_5 == "iw7_knife_zm_cleaver" && iscrog(self);
  if(isDefined(var_5) && var_5 == "iw7_knife_zm_cleaver" && !iscrog(self)) {
    scripts\cp\utility::add_to_notify_queue("cleaver_damage_zombie");
  }

  var_27 = !var_1D && var_15 || var_16 || var_26 || var_1A || var_25 || var_18 || var_19 || var_24;
  var_28 = scripts\engine\utility::istrue(self.isfrozen);
  var_29 = var_12 && var_0F && var_1.currentmeleeweapon == "iw7_knife_zm_cleaver";
  if(var_29) {
    if(scripts\engine\utility::istrue(self.glowing) && var_2 >= self.health) {
      level.death_by_cleaver = 1;
      level.death_by_cleaver_org = self.origin;
    }
  }

  if(var_27 && !var_1C) {
    if(var_24) {
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    var_2 = int(self.maxhealth);
    if(var_1A) {
      if(isDefined(var_6)) {
        playFX(level._effect["shock_melee_impact"], var_6);
      }

      var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_1A);
    }

    if(var_13) {
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    }
  } else {
    var_8 = scripts\cp\agents\gametype_zombie::shitloc_mods(var_1, var_4, var_5, var_8);
    var_2A = level.wave_num;
    var_2B = scripts\cp\agents\gametype_zombie::is_grenade(var_5, var_4);
    var_2C = scripts\engine\utility::istrue(self.is_burning) && !var_13;
    var_2D = var_14 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_2E = var_13 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_2F = var_13 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_30 = var_13 && isDefined(var_1.special_ammo_weapon) && var_1.special_ammo_weapon == var_5;
    var_31 = var_12 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_32 = var_12 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_33 = scripts\engine\utility::array_contains(level.melee_weapons, var_5);
    var_34 = weaponclass(var_5) == "spread" && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "smart");
    var_35 = weaponclass(var_5) == "spread" && !var_34 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "arkpink") || scripts\cp\cp_weapon::has_attachment(var_5, "arkyellow");
    var_36 = var_14 && var_13 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "highcal");
    if(issubstr(var_5, "cutie") && var_12) {
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

    if(var_1B && issubstr(var_5, "+gl")) {
      var_2 = scripts\cp\agents\gametype_zombie::scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    }

    if(var_34) {
      var_2 = var_2 * 0.5;
    }

    var_2 = scripts\cp\agents\gametype_zombie::initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);
    if(var_35) {
      var_2 = var_2 * 4;
    }

    if(var_12) {
      if(var_0F) {
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

      if(var_31 && var_17) {
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

    if(var_13 && scripts\engine\utility::istrue(var_1.reload_damage_increase)) {
      var_2 = var_2 * 2;
    }

    if(var_2B) {
      var_2 = var_2 * min(2 + var_2A * 0.5, 10);
    }

    if(var_2F && !var_1F) {
      var_2 = int(var_2 * 2);
    }

    if(var_36) {
      var_2 = var_2 * 1.2;
    }

    if(var_12 && var_0E && !var_1F) {
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

  if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2 && var_13) {
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

  var_2 = scripts\cp\agents\gametype_zombie::shouldapplycrotchdamagemultiplier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  var_2 = scripts\cp\agents\gametype_zombie::fateandfortuneweaponscale(self, var_5, var_2, 0, var_1F, 0, 0);
  if(isDefined(var_1.special_zombie_damage) && var_1F) {
    var_2 = var_2 * var_1.special_zombie_damage;
  }

  if(iscrog(self) && isDefined(level.special_zombie_damage_func) && isDefined(level.special_zombie_damage_func[self.agent_type])) {
    var_2 = self[[level.special_zombie_damage_func[self.agent_type]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  }

  if(isDefined(self.hitbychargedshot) && !self.health - var_2 < 1) {
    self.hitbychargedshot = undefined;
  }

  var_2 = int(min(var_2, self.health));
  if(isplayer(var_1) && scripts\cp\utility::is_melee_weapon(var_5, 1)) {
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - var_1.origin), anglestoup(self.angles), var_1);
  }

  if(self.health > 0 && self.health - var_2 <= 0) {
    if(self.died_poorly) {
      self.died_poorly_health = self.health;
    }

    if(isDefined(self.has_backpack)) {
      scripts\cp\zombies\zombies_pillage::pillageable_piece_lethal_monitor(self, self.has_backpack, var_1);
    }

    if(var_12 && var_1E) {
      if(isDefined(self.agent_type) && self.agent_type == "generic_zombie") {
        if(var_5 == "iw7_change_chews_zm") {
          self.nocorpse = 1;
          self.full_gib = 1;
        } else if(var_14) {
          var_3C = 50;
          if(randomint(100) < var_3C) {
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

    if(isDefined(self.agent_type) && self.agent_type == "crab_mini") {
      if(var_4 == "MOD_SUICIDE") {
        self.vignette_nocorpse = 1;
      } else {
        thread scripts\mp\agents\crab_mini\crab_mini_agent::create_sludge_pool(self.origin);
      }
    } else if(isDefined(self.agent_type) && self.agent_type == "crab_brute") {
      thread scripts\mp\agents\crab_brute\crab_brute_agent::create_brute_death_fx(self.origin);
    }
  }

  if(var_12) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(var_5));
    if(var_13) {
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
  scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  if(isDefined(self.agent_type) && isDefined(level.damage_feedback_overrride) && isDefined(level.damage_feedback_overrride[self.agent_type])) {
    [[level.damage_feedback_overrride[self.agent_type]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  } else {
    scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  }

  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  if(var_12) {
    thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(var_1);
  }

  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_0A, var_0B);
}

cp_town_onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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

  if(issubstr(var_4, "iw7_knife") && isplayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if((var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") && isplayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4)) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  } else if(issubstr(var_4, "golf") || issubstr(var_4, "machete") || issubstr(var_4, "spiked_bat") || issubstr(var_4, "two_headed_axe")) {
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  }

  if(isDefined(self.linked_to_boat)) {
    self.linked_to_boat.zombie = undefined;
    self.linked_to_boat = undefined;
  }

  if(!isplayer(var_1)) {
    if(isDefined(var_1.name)) {
      if(var_1.name == var_1.triggerportableradarping.itemtype) {
        if(isDefined(var_1.triggerportableradarping.killswithitem[var_1.triggerportableradarping.itemtype])) {
          var_1.triggerportableradarping.killswithitem[var_1.triggerportableradarping.itemtype]++;
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

  if(isplayer(var_1)) {
    if(scripts\engine\utility::istrue(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      var_1.marked_ents = scripts\engine\utility::array_remove(var_1.marked_ents, self);
      var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_marked_target", var_1, var_2, var_3, var_4, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
    }

    if(isDefined(var_1.weapon_passive_xp_multiplier) && var_1.weapon_passive_xp_multiplier > 1) {
      var_1.kill_with_extra_xp_passive = 1;
    }

    var_0A = (var_3 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_6) && var_6 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";
    if(var_0A) {
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
      foreach(var_0C in level.powers) {
        if(var_0C.weaponuse == var_4) {
          if(var_0C.weaponuse == var_1.itempicked) {
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
      var_0E = 100;
      var_0F = 3;
      var_10 = self.origin + (0, 0, 20);
      var_11 = (randomint(350), randomint(350), randomint(350));
      var_11 = vectornormalize(var_11) * var_0E;
      var_12 = self launchgrenade("frag_grenade_zm", var_10, var_11, var_0F);
    }
  }

  if(isDefined(var_1.team)) {
    if(var_1.team == "allies") {
      if(!isplayer(var_1)) {
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
      level thread[[level.drop_max_ammo_func]](self.origin, var_1, "ammo_max");
    }

    scripts\engine\utility::flag_clear("force_drop_max_ammo");
  }

  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(level.updaterecentkills_func) && isplayer(var_1)) {
    var_1 thread[[level.updaterecentkills_func]](self, var_4);
  }

  if(getweaponbasename(var_4) == "iw7_cutie_zm" || getweaponbasename(var_4) == "iw7_cutier_zm" && scripts\engine\utility::istrue(self.affectedbyfovdamage)) {
    self playSound("bullet_atomizer_impact_npc");
    if(isDefined(self.body)) {
      self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
      self.body hide(1);
    }

    self.affectedbyfovdamage = undefined;
  }

  if((scripts\engine\utility::isbulletdamage(var_3) && getweaponbasename(var_4) == "iw7_atomizer_mp" || scripts\engine\utility::istrue(self.atomize_me)) || var_3 == "MOD_UNKNOWN" && getweaponbasename(var_4) == "iw7_harpoon3_zm") {
    if(!var_16 && !var_13 && !var_14 && !var_15 && !scripts\cp\utility::agentisfnfimmune()) {
      self playSound("bullet_atomizer_impact_npc");
      if(isDefined(self.body)) {
        self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isplayer(var_1)) {
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

  if(isDefined(level.on_zombie_killed_quests_func)) {
    [[level.on_zombie_killed_quests_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(!scripts\cp\agents\gametype_zombie::isonhumanteam(self)) {
    scripts\cp\agents\gametype_zombie::enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    if(isDefined(level.onzombiekilledfunc)) {
      [
        [level.onzombiekilledfunc]
      ](var_1, var_4);
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

  if(isplayer(var_1) && isDefined(level.updateonkillpassivesfunc)) {
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
  scripts\cp\agents\gametype_zombie::process_kill_rewards(var_0, var_1, self, var_6, var_3, var_4);
  scripts\cp\agents\gametype_zombie::process_assist_rewards(var_1);
  scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(var_1, var_4, var_6, var_3, self.agent_type);
  if(isDefined(level.death_challenge_update_func)) {
    [[level.death_challenge_update_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  if(isDefined(var_1.triggerportableradarping)) {
    var_1.triggerportableradarping scripts\cp\utility::bufferednotify("kill_event_buffered", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, self.agent_type);
  } else if(isplayer(var_1)) {
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
      case "crab_brute":
      case "crab_mini":
      case "crab_boss":
        return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

callback_townzombieplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
  if(!scripts\cp\zombies\zombie_damage::shouldtakedamage(var_2, var_1, var_5, var_3)) {
    return;
  }

  if(damage_from_escort_vehicle(var_0, var_4)) {
    return;
  }

  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_5])) {
      level thread[[level.overcook_func[var_5]]](var_0C, var_5);
    }
  }

  var_0D = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_0E = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_0F = scripts\cp\zombies\zombie_damage::isfriendlyfire(self, var_1);
  var_10 = scripts\cp\utility::is_hardcore_mode();
  var_11 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_12 = scripts\cp\utility::has_zombie_perk("perk_machine_change");
  var_13 = isDefined(var_1);
  var_14 = var_13 && isDefined(var_1.agent_type) && var_1.agent_type == "generic_zombie";
  var_15 = var_13 && var_1 == self;
  var_16 = (var_15 || !var_13) && var_4 == "MOD_SUICIDE";
  if(var_13) {
    if(var_1 == self) {
      if(var_0D) {
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
    } else if(var_14) {
      if(var_4 != "MOD_EXPLOSIVE" && var_0C scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::istrue(var_1.is_burning)) {
          var_0C scripts\cp\utility::notify_used_consumable("burned_out");
          var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0C, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
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

    if(var_0E) {
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
    var_2 = int(var_2 * var_0C scripts\cp\utility::getdamagemodifiertotal());
  }

  if(isDefined(self.linked_to_coaster)) {
    var_2 = int(max(self.maxhealth / 2.75, var_2));
  }

  if(var_0C scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_1)) {
    var_1F = 0;
    if(isDefined(var_1.agent_type) && var_1.agent_type == "crab_mini" || var_1.agent_type == "crab_brute" || var_1 scripts\cp\utility::agentisfnfimmune()) {
      var_1F = 0;
    } else if(isplayer(var_0C) && isplayer(var_1)) {
      var_1F = 0;
    } else {
      var_1F = 1;
    }

    if(var_1F) {
      var_1 thread scripts\cp\zombies\craftables\_revocator::turn_zombie(var_0C);
      var_0C scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_2 = int(var_2);
  if(!var_0F || var_10) {
    scripts\cp\zombies\zombie_damage::finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_1E, var_0A, var_0B);
    thread scripts\cp\utility::add_to_notify_queue("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_2);
  if(var_2 <= 0) {
    return;
  }

  thread scripts\cp\utility::player_pain_vo();
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

flying_ghost_body(var_0, var_1, var_2) {
  var_3 = 100;
  var_4 = 20;
  var_5 = vectornormalize(self.origin - var_0.origin) * var_3 + (0, 0, var_4);
  var_6 = self.origin + var_5;
  var_7 = level._effect["chi_ghost_hit_blue"];
  if(isDefined(var_0.kung_fu_progression.active_discipline)) {
    var_8 = var_0.kung_fu_progression.active_discipline;
    switch (var_8) {
      case "crane":
        var_7 = level._effect["chi_ghost_hit_blue"];
        break;

      case "dragon":
        var_7 = level._effect["chi_ghost_hit_yellow"];
        break;

      case "snake":
        var_7 = level._effect["chi_ghost_hit_green"];
        break;

      case "tiger":
        var_7 = level._effect["chi_ghost_hit_red"];
        break;

      default:
        break;
    }
  }

  playFX(var_7, var_6);
}

crog_processdamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(!scripts\engine\utility::isbulletdamage(var_4)) {
    if(scripts\cp\utility::is_trap(var_0, var_5)) {
      return;
    }

    var_0B = gettime();
    if(isDefined(var_1.nexthittime) && var_1.nexthittime > var_0B) {
      return;
    } else {
      var_1.nexthittime = var_0B + 250;
    }
  }

  var_0C = "standard";
  var_0D = undefined;
  if(var_0A.health <= var_2) {
    var_0D = 1;
  }

  var_0E = scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  if(var_0E) {
    var_0C = "hitcritical";
  }

  var_0F = scripts\engine\utility::isbulletdamage(var_4);
  var_10 = var_0E && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
  var_11 = var_0F && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
  var_12 = var_0F && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
  var_13 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_14 = !var_13 && var_0E && var_0F && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_15 = !scripts\cp\utility::isreallyalive(var_0A) || isagent(var_0A) && var_2 >= var_0A.health;
  var_16 = var_4 == "MOD_EXPLOSIVE_BULLET" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_17 = var_4 == "MOD_MELEE";
  if(scripts\engine\utility::istrue(var_0A.armor_hit)) {
    var_0C = "hitalienarmor";
  } else if(var_10 || var_11 || var_12 || var_14) {
    var_0C = "card_boosted";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_16) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_17) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_0F) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && scripts\engine\utility::istrue(var_1.deadeye_charge) && var_0F) {
    var_0C = "special_weapon";
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.triggerportableradarping)) {
      var_1.triggerportableradarping thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, var_2, var_0A.riotblock);
    } else {
      var_1 thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, var_2, var_0A.riotblock);
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