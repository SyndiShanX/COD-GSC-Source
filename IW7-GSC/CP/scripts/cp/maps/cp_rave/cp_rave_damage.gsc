/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_damage.gsc
******************************************************/

cp_rave_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(!isDefined(self.agent_type)) {
    return;
  }
  if(var_4 != "MOD_SUICIDE") {
    if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_1)) {
      return;
    }
    if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_0))
      return;
  }

  if(!isDefined(var_1))
    var_1 = self;

  var_13 = scripts\cp\agents\gametype_zombie::should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_12);

  if(!var_13) {
    return;
  }
  var_3 = var_3 | 4;
  var_14 = isDefined(var_12.agent_type) && var_12.agent_type == "zombie_brute";
  var_15 = isDefined(var_12.agent_type) && var_12.agent_type == "slasher";
  var_16 = isDefined(var_12.agent_type) && var_12.agent_type == "superslasher";
  var_17 = scripts\engine\utility::is_true(var_12.is_suicide_bomber);
  var_18 = var_4 == "MOD_MELEE";
  var_19 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_20 = isDefined(self.isfrozen) && isDefined(var_5) && (!scripts\cp\cp_weapon::isforgefreezeweapon(var_5) || var_4 == "MOD_MELEE");
  var_21 = scripts\cp\cp_weapon::isaltforgefreezeweapon(var_5);
  var_22 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_23 = isDefined(var_1) && isPlayer(var_1);
  var_24 = var_22 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_25 = scripts\engine\utility::is_true(self.battleslid);
  var_26 = scripts\engine\utility::is_true(level.insta_kill) && !var_14 && !var_16 &!var_15;
  var_27 = !var_19 && var_24 && var_22 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_28 = var_4 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_29 = var_18 && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_30 = scripts\engine\utility::is_true(self.immune_against_freeze);
  var_31 = scripts\cp\utility::isaltmodeweapon(var_5);
  var_32 = var_18 && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
  var_33 = scripts\engine\utility::is_true(var_1.rave_mode_od);
  var_34 = scripts\engine\utility::is_true(self.is_skeleton);

  if(var_23) {
    if(scripts\engine\utility::is_true(self.marked_shared_fate_fnf))
      var_1 notify("weapon_hit_marked_target", var_1, var_2, var_4, var_5, self);

    if(issubstr(var_5, "iw7_harpoon2_zm"))
      var_1 notify("zombie_hit_by_ben", var_6, self, self.maxhealth);

    self.damaged_by_player = 1;
  }

  if(isDefined(var_1.is_turned) && var_1.is_turned && var_4 != "MOD_SUICIDE") {
    if(var_14)
      var_2 = int(var_2 * 1.5);
    else
      var_2 = var_1.melee_damage_amt;
  }

  var_35 = 0;

  if(!var_18 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5) && var_23 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade"))
    var_35 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";

  var_36 = scripts\engine\utility::is_true(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";

  if(var_36 && (var_14 || var_15 || var_16)) {
    return;
  }
  var_37 = !var_14 && !var_15 && !var_16 && (var_25 || var_26 || var_32 || var_36 || var_20 || var_27 || var_29 || var_35 || var_33);
  var_38 = isDefined(self.isfrozen);

  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(var_5) && !var_14 && !var_16 && !var_15) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(var_0.origin, var_6, var_7);
    return;
  } else if(isDefined(var_5) && scripts\cp\cp_weapon::isforgefreezeweapon(var_5) && !var_18 && !var_21) {
    var_39 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_5);
    var_40 = scripts\cp\agents\gametype_zombie::getnumberoffrozenticksfromwave(self, var_39);

    if(!var_38 && !var_30 && !var_14 && !var_17 && !var_16 && !var_15) {
      var_41 = 10 * level.cash_scalar;

      if(var_1 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        var_1 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_41 = var_41 * 2;
      }

      var_1 scripts\cp\cp_persistence::give_player_currency(var_41, "large", var_8);
      var_1 notify("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);

      if(var_5 == "zfreeze_semtex_mp" || isDefined(self.frozentick) && self.frozentick >= var_40 || var_26) {
        self.frozentick = undefined;
        self.isfrozen = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
      } else if(isDefined(self.frozentick)) {
        self.frozentick++;

        if(var_40 > 15 && self.frozentick >= 8)
          self.allowpain = 1;

        if(self.frozentick / var_40 > 0.33)
          self.slowed = 1;

        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
      } else {
        self.frozentick = 1;
        thread scripts\cp\zombies\zombie_scriptable_states::removefrozentickontimeout(self);
        thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self, var_39);
      }
    } else if(var_17) {
      if(isDefined(self.frozentick))
        self.frozentick++;
      else
        self.frozentick = 1;

      if(self.frozentick <= var_40)
        return;
      else
        var_2 = self.maxhealth;
    } else
      return;
  } else if(!var_38 && var_21)
    return;
  else if(var_37 && !var_14 && !var_16 && !var_15) {
    if(var_35)
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");

    var_2 = int(self.maxhealth);

    if(var_32) {
      if(isDefined(var_6))
        playFX(level._effect["shock_melee_impact"], var_6);

      var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, self.maxhealth, "MOD_UNKNOWN", undefined, var_32);
    }

    if(var_22)
      var_1 notify("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
  } else if(!var_16 || !var_15) {
    var_8 = scripts\cp\agents\gametype_zombie::shitloc_mods(var_1, var_4, var_5, var_8);
    var_42 = level.wave_num;
    var_43 = scripts\cp\agents\gametype_zombie::is_grenade(var_5, var_4);
    var_44 = scripts\engine\utility::is_true(self.is_burning) && !var_22;
    var_45 = var_24 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_46 = var_22 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_47 = var_22 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_48 = var_22 && isDefined(var_1.special_ammo_weapon) && var_1.special_ammo_weapon == var_5;
    var_49 = var_23 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_50 = var_23 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_51 = scripts\cp\agents\gametype_zombie::is_axe_weapon(var_5);
    var_52 = scripts\engine\utility::array_contains(level.melee_weapons, var_5);
    var_53 = weaponclass(var_5) == "spread" && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "smart");
    var_54 = weaponclass(var_5) == "spread" && !var_53 && (var_1 scripts\cp\cp_weapon::has_attachment(var_5, "arkpink") || scripts\cp\cp_weapon::has_attachment(var_5, "arkyellow"));
    var_55 = var_24 && var_22 && var_1 scripts\cp\cp_weapon::has_attachment(var_5, "highcal");

    if(var_31 && issubstr(var_5, "+gl"))
      var_2 = scripts\cp\agents\gametype_zombie::scalegldamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_53)
      var_2 = var_2 * 0.5;

    if(isDefined(var_2) && isDefined(var_8) && !var_26 && var_22) {
      var_56 = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_12, var_1, var_2, var_8, var_7);

      if(var_56 <= 0) {
        return;
      }
      var_2 = var_56;
    }

    var_2 = scripts\cp\agents\gametype_zombie::initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);

    if(var_54)
      var_2 = var_2 * 4;

    if(var_23) {
      if(var_18) {
        if(var_1 scripts\cp\cp_weapon::has_attachment(var_5, "meleervn"))
          var_2 = var_2 + int(1500 * var_1 scripts\cp\cp_weapon::get_weapon_level(var_5));

        var_2 = int(var_2 * var_1 scripts\cp\perks\perk_utility::perk_getmeleescalar());

        if(isDefined(var_1.passive_melee_kill_damage))
          var_2 = var_2 + var_1.passive_melee_kill_damage;

        if(var_50)
          var_2 = var_2 + 1500;

        var_57 = 0;

        if(var_2 >= self.health)
          var_57 = 1;

        if(isDefined(var_1.increased_melee_damage))
          var_2 = var_2 + var_1.increased_melee_damage;

        if(var_52 && var_57)
          var_1 notify("melee_weapon_hit", var_5, self, var_2);

        if(var_51 || var_50) {
          if(var_51) {
            var_1 notify("axe_melee_hit", var_5, self, var_2);

            if(var_57 && !isDefined(self.launched)) {
              thread scripts\cp\agents\gametype_zombie::launch_and_kill(var_1, var_5, var_50);
              return;
            }
          } else if(var_57)
            self.slappymelee = 1;
        }
      }

      if(var_48)
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self getEye(), self, var_2, var_4, 128);

      if(var_49 && var_28)
        var_2 = int(var_2 * 2);

      if(scripts\engine\utility::is_true(var_1.rave_mode))
        var_2 = int(var_2 * 2);
    }

    if(var_45)
      var_2 = var_2 * 3.0;

    if(var_46) {
      var_58 = int(var_1 getweaponammoclip(var_1 getcurrentweapon()) + 1);
      var_59 = weaponclipsize(var_1 getcurrentweapon());

      if(var_58 <= 4)
        var_2 = var_2 * 2;
    }

    if(var_22 && scripts\engine\utility::is_true(var_1.reload_damage_increase))
      var_2 = var_2 * 2;

    if(var_43)
      var_2 = var_2 * min(2 + var_42 * 0.5, 10);

    if(var_47)
      var_2 = int(var_2 * 2);

    if(var_55)
      var_2 = var_2 * 1.2;
  }

  if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2.0 && var_22)
    var_2 = var_2 * 1.33;

  if(scripts\engine\utility::is_true(var_1.deadeye_charge))
    var_2 = var_2 * 1.25;

  if(isDefined(level.damage_per_second)) {
    if(!scripts\engine\utility::flag("start_tracking_dps"))
      scripts\engine\utility::flag_set("start_tracking_dps");

    if(isDefined(level.dpstime))
      level.dpstime = gettime();

    if(isDefined(var_1.total_damage))
      var_1.total_damage = var_1.total_damage + var_2;
  }

  var_2 = scripts\cp\agents\gametype_zombie::shouldapplycrotchdamagemultiplier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_2 = scripts\cp\agents\gametype_zombie::fateandfortuneweaponscale(self, var_5, var_2, 0, var_14, var_16, var_15);

  if(var_14) {
    if(isDefined(level.brute_damage_adjustment_func))
      var_2 = self[[level.brute_damage_adjustment_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(isDefined(var_5) && (issubstr(var_5, "arcane") || issubstr(var_5, "ark")))
    var_2 = var_2 * 1.2;

  if(isDefined(level.onzombiedamage_func))
    var_2 = [[level.onzombiedamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(isDefined(var_1.special_zombie_damage) && (var_14 || var_17 || var_16 || var_15))
    var_2 = var_2 * var_1.special_zombie_damage;

  var_2 = int(min(var_2, self.maxhealth));

  if(isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_5, 1))
    playFX(level._effect["melee_impact"], self gettagorigin("j_neck"), vectortoangles(self.origin - var_1.origin), anglestoup(self.angles), var_1);

  if(self.health > 0 && self.health - var_2 <= 0) {
    if(self.died_poorly)
      self.died_poorly_health = self.health;

    if(isDefined(self.has_backpack))
      scripts\cp\zombies\zombies_pillage::pillageable_piece_lethal_monitor(self, self.has_backpack, var_1);

    self emissiveblend(0, 0);
  }

  if(isPlayer(var_1)) {
    if(isDefined(level.updateondamagepassivesfunc))
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);

    var_1 thread scripts\cp\utility::add_to_notify_queue("weapon_hit_enemy", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(var_5));

    if(scripts\engine\utility::isbulletdamage(var_4)) {
      if(!isDefined(var_1.accuracy_shots_on_target))
        var_1.accuracy_shots_on_target = 1;
      else
        var_1.accuracy_shots_on_target++;

      scripts\cp\cp_persistence::increment_player_career_shots_on_target(var_1);
      scripts\cp\zombies\zombie_analytics::log_playershotsontarget(1, var_1, var_1.accuracy_shots_on_target);
    }

    if(!isDefined(var_1.shotsontargetwithweapon[getweaponbasename(var_5)]))
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)] = 1;
    else
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)]++;
  }

  if(var_24 && var_23 && var_38) {
    if(isDefined(self.freeze_struct))
      self.freeze_struct notify("headcutter_cryo_kill", var_1, self);
  }

  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(var_1, var_2, var_4);

  if(!var_14 && !var_15)
    scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);

  if(!var_14 && !(var_15 && (self isethereal() || scripts\engine\utility::is_true(var_1.rave_mode))))
    scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);

  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(var_23)
    thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(var_1);

  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

cp_rave_onslasherdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  var_13 = level.agent_funcs[self.agent_type]["gametype_on_damaged"];

  if(isDefined(var_13))
    [[var_13]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(scripts\mp\mp_agent::is_friendly_damage(var_12, var_0)) {
    return;
  }
  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

cp_rave_onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.spawn_fx))
    self.spawn_fx delete();

  if(isDefined(self.scrnfx)) {
    self.scrnfx delete();
    self.scrnfx = undefined;
  }

  if(issubstr(var_4, "iw7_knife") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4))
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  else if((var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") && isPlayer(var_1) && scripts\cp\utility::is_melee_weapon(var_4))
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);
  else if(issubstr(var_4, "golf") || issubstr(var_4, "machete") || issubstr(var_4, "spiked_bat") || issubstr(var_4, "two_headed_axe"))
    var_1 thread scripts\cp\agents\gametype_zombie::setandunsetmeleekill(var_1);

  if(isDefined(self.linked_to_boat)) {
    self.linked_to_boat.zombie = undefined;
    self.linked_to_boat = undefined;
  }

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.name)) {
      if(var_1.name == var_1.owner.itemtype) {
        if(isDefined(var_1.owner.killswithitem[var_1.owner.itemtype]))
          var_1.owner.killswithitem[var_1.owner.itemtype]++;
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
    if(issubstr(var_4, "harpoon1") || issubstr(var_4, "harpoon2") || issubstr(var_4, "harpoon3") || issubstr(var_4, "harpoon4"))
      var_1 scripts\cp\zombies\achievement::update_achievement("STICK_EM", 1);

    if(scripts\engine\utility::is_true(level.sniper_quest_on))
      level thread scripts\cp\utility::add_to_notify_queue("kill_near_bino_with_sniper", var_1, var_4, self);

    if(issubstr(var_4, "iw7_harpoon2_zm") || issubstr(var_4, "iw7_harpoon2_zm_stun")) {
      self.nocorpse = 1;
      self.full_gib = 1;

      if(isDefined(self.body)) {
        self.body hide(1);
        self.body thread playbodyfx_ww(var_4, self);
      }
    }

    if(issubstr(var_4, "iw7_harpoon1_zm") || issubstr(var_4, "iw7_acid_rain_projectile_zm")) {
      self.nocorpse = 1;
      self.full_gib = 1;

      if(isDefined(self.body)) {
        self.body hide(1);
        self.body thread playbodyfx_ww(var_4, self);
      }
    }

    if(scripts\engine\utility::is_true(self.marked_shared_fate_fnf)) {
      self.marked_shared_fate_fnf = 0;
      var_1.marked_ents = scripts\engine\utility::array_remove(var_1.marked_ents, self);
      var_1 notify("weapon_hit_marked_target", var_1, var_2, var_3, var_4, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
    }

    if(isDefined(var_1.weapon_passive_xp_multiplier) && var_1.weapon_passive_xp_multiplier > 1)
      var_1.kill_with_extra_xp_passive = 1;

    var_10 = var_3 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_6) && var_6 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";

    if(var_10) {
      if(!isDefined(var_1.explosive_kills))
        var_1.explosive_kills = 1;
      else
        var_1.explosive_kills++;

      scripts\cp\cp_persistence::increment_player_career_explosive_kills(var_1);
    }

    var_1.kills++;
    var_1.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_4);

    if(!isDefined(var_1.aggregateweaponkills[var_1.weapon_name_log]))
      var_1.aggregateweaponkills[var_1.weapon_name_log] = 1;
    else
      var_1.aggregateweaponkills[var_1.weapon_name_log]++;

    scripts\cp\zombies\zombie_analytics::log_zombiedeath(1, level.wave_num, var_1, var_4, self.agent_type, self.origin);

    if(scripts\engine\utility::isbulletdamage(var_3) && var_4 != "incendiary_ammo_mp" && var_4 != "slayer_ammo_mp") {
      if(isDefined(var_6) && scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1))
        self playsoundtoplayer("zmb_player_achieve_headshot", var_1);
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
    if(isDefined(level.drop_max_ammo_func))
      level thread[[level.drop_max_ammo_func]](self.origin, var_1, "ammo_max");

    scripts\engine\utility::flag_clear("force_drop_max_ammo");
  }

  var_14 = isDefined(self.agent_type) && self.agent_type == "zombie_brute";
  var_15 = isDefined(self.agent_type) && self.agent_type == "slasher";
  var_16 = isDefined(self.agent_type) && self.agent_type == "superslasher";
  var_17 = scripts\engine\utility::is_true(self.is_suicide_bomber);

  if(isDefined(level.updaterecentkills_func) && isPlayer(var_1))
    var_1 thread[[level.updaterecentkills_func]](self, var_4);

  if(scripts\engine\utility::isbulletdamage(var_3) && (getweaponbasename(var_4) == "iw7_atomizer_mp" || scripts\engine\utility::is_true(self.atomize_me)) || var_3 == "MOD_UNKNOWN" && getweaponbasename(var_4) == "iw7_harpoon3_zm") {
    if(!var_17 && !var_14 && !var_15 && !var_16) {
      self playSound("bullet_atomizer_impact_npc");

      if(isDefined(self.body)) {
        self.body thread scripts\cp\agents\gametype_zombie::playbodyfx();
        self.body hide(1);
      }
    }
  }

  if(isPlayer(var_1)) {
    if(scripts\engine\utility::is_true(var_1.rave_mode)) {
      if(!var_17 && !var_14 && !var_15 && !var_16) {
        self playSound("bullet_atomizer_impact_npc");

        if(isDefined(self.body))
          self.body thread play_rave_death_fx("rave_death_effects");
      }
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self, self.origin, var_4, var_3);
  }

  if(isDefined(level.on_zombie_killed_quests_func))
    [[level.on_zombie_killed_quests_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(!scripts\cp\agents\gametype_zombie::isonhumanteam(self)) {
    scripts\cp\agents\gametype_zombie::enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(level.onzombiekilledfunc))
      [[level.onzombiekilledfunc]](var_1, var_4);
  }

  var_1 scripts\cp\zombies\zombies_consumables::headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(level.spawnloopupdatefunc))
    [[level.spawnloopupdatefunc]](var_1, var_4);

  if(isDefined(self.near_medusa) && !isDefined(self.soul_claimed)) {
    self.soul_claimed = 1;

    if(isDefined(var_1.itemtype)) {
      if(var_1.itemtype == "crafted_medusa") {
        if(!isDefined(var_1.killswithitem[var_1.itemtype]))
          var_1.killswithitem[var_1.itemtype] = 1;
        else
          var_1.killswithitem[var_1.itemtype]++;
      }
    }

    level thread[[level.medusa_killed_func]](self.origin, self.near_medusa, scripts\engine\utility::is_true(self.dismember_crawl));
  }

  if(isDefined(self.near_crystal) && !var_17) {
    if(isDefined(level.closest_crystal_func))
      var_18 = level[[level.closest_crystal_func]](self);
    else
      var_18 = undefined;

    if(isDefined(var_18)) {
      if(isDefined(level.crystal_killed_notify))
        thread scripts\cp\agents\gametype_zombie::delayminiufocollection(self.origin, var_4, var_18);
    }
  }

  if(isDefined(level.quest_death_update_func))
    level thread[[level.quest_death_update_func]](self);

  if(isPlayer(var_1) && isDefined(level.updateonkillpassivesfunc))
    level thread[[level.updateonkillpassivesfunc]](var_4, var_1, self, var_3, var_6);

  self hudoutlinedisable();

  if(isDefined(self.anchor))
    self.anchor delete();

  if(isDefined(self.attack_spot))
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);

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

  if(isDefined(level.death_challenge_update_func))
    [[level.death_challenge_update_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else
    scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  scripts\cp\cp_agent_utils::deactivateagent();
  scripts\cp\zombies\zombie_armor::clean_up_zombie_armor(self);

  if(isDefined(level.cp_rave_zombie_death_pos_record_func))
    [[level.cp_rave_zombie_death_pos_record_func]](self.origin);

  level thread scripts\cp\utility::add_to_notify_queue("zombie_killed", self.origin, var_4, var_3, var_1);
}

play_rave_death_fx(var_0) {
  var_1 = ["j_spineupper", "j_spinelower"];

  if(!isDefined(var_0))
    var_2 = level._effect["atomize_body"];
  else
    var_2 = level._effect[var_0];

  var_3 = spawnfx(var_2, self gettagorigin("j_spinelower"));

  foreach(var_5 in level.players) {
    if(!scripts\engine\utility::is_true(var_5.rave_mode)) {
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
  wait 2.5;

  if(isDefined(var_0))
    var_0 delete();
}

callback_ravezombieplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(!scripts\cp\zombies\zombie_damage::shouldtakedamage(var_2, var_1, var_5, var_3)) {
    return;
  }
  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level.overcook_func[var_5]))
      level thread[[level.overcook_func[var_5]]](var_12, var_5);
  }

  var_13 = isDefined(var_4) && (var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH");
  var_14 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_15 = scripts\cp\zombies\zombie_damage::isfriendlyfire(self, var_1);
  var_16 = isDefined(var_5) && var_5 == "iw7_sasq_rock_mp";
  var_17 = scripts\cp\utility::is_hardcore_mode();
  var_18 = scripts\cp\utility::has_zombie_perk("perk_machine_boom");
  var_19 = isDefined(var_1);
  var_20 = var_19 && isDefined(var_1.species) && var_1.species == "zombie";
  var_21 = var_19 && isDefined(var_1.species) && var_1.species == "zombie_grey";
  var_22 = var_19 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_brute";
  var_23 = var_19 && var_1 == self;
  var_24 = var_19 && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_sasquatch";
  var_25 = var_19 && isDefined(var_1.agent_type) && var_1.agent_type == "slasher";
  var_26 = var_19 && isDefined(var_1.agent_type) && var_1.agent_type == "superslasher";
  var_27 = (var_23 || !var_19) && var_4 == "MOD_SUICIDE";

  if(var_19) {
    if(var_1 == self) {
      if(issubstr(var_5, "iw7_harpoon2_zm") || issubstr(var_5, "iw7_harpoon1_zm") || issubstr(var_5, "iw7_acid_rain_projectile_zm"))
        var_2 = 0;

      if(var_13) {
        if(var_18)
          var_2 = 0;
        else
          var_2 = scripts\cp\zombies\zombie_damage::get_explosive_damage_on_player(var_0, var_1, var_2, var_3, var_4, var_5);
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
      if(var_17) {
        if(scripts\cp\utility::is_ricochet_damage()) {
          if(isPlayer(var_1) && isDefined(var_8) && var_8 != "shield") {
            if(isDefined(var_0))
              var_1 dodamage(var_2, var_1.origin - (0, 0, 50), var_1, var_0, var_4);
            else
              var_1 dodamage(var_2, var_1.origin, var_1);
          }

          var_2 = 0;
        }
      } else
        var_2 = 0;
    } else if(var_25) {
      if(!scripts\engine\utility::is_true(self.rave_mode) && var_1 isethereal())
        return;
    } else if(var_20) {
      if(var_4 != "MOD_EXPLOSIVE" && var_12 scripts\cp\utility::is_consumable_active("burned_out")) {
        if(!scripts\engine\utility::is_true(var_1.is_burning)) {
          var_12 scripts\cp\utility::notify_used_consumable("burned_out");
          var_1 thread scripts\cp\utility::damage_over_time(var_1, var_12, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
          var_1.faf_burned_out = 1;
        }
      }

      var_28 = gettime();

      if(!isDefined(self.last_zombie_hit_time) || var_28 - self.last_zombie_hit_time > 20)
        self.last_zombie_hit_time = var_28;
      else
        return;

      var_29 = 500;

      if(getdvarint("zom_damage_shield_duration") != 0)
        var_29 = getdvarint("zom_damage_shield_duration");

      if(isDefined(var_1.last_damage_time_on_player[self.vo_prefix])) {
        var_30 = var_1.last_damage_time_on_player[self.vo_prefix];

        if(var_30 + var_29 > gettime())
          var_2 = 0;
        else
          var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
      } else
        var_1.last_damage_time_on_player[self.vo_prefix] = gettime();
    }

    if(var_14) {
      if(var_18)
        var_2 = 0;
      else if(!var_17 || var_1 == self && var_8 == "none")
        var_2 = 0;
    }
  } else if(var_18 && var_4 == "MOD_SUICIDE") {
    if(var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm")
      var_2 = 0;
  }

  if(var_4 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage"))
      var_2 = 0;
    else if(var_2 > 10) {
      if(var_2 > self.health * 0.15)
        var_2 = int(self.health * 0.15);
    } else
      var_2 = 0;
  }

  var_31 = 0.0;

  if(var_19 && var_1 scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::is_true(self.linked_to_player)) {
    if(self.health - var_2 < 1)
      var_2 = self.health - 1;
  }

  if(var_20 || var_21 || var_22 || var_23 && !var_27)
    var_2 = int(var_2 * var_12 scripts\cp\utility::getdamagemodifiertotal());

  if(isDefined(self.linked_to_coaster))
    var_2 = int(max(self.maxhealth / 2.75, var_2));

  if(var_12 scripts\cp\utility::is_consumable_active("secret_service") && isalive(var_1)) {
    var_32 = 0;

    if(isDefined(var_1.agent_type) && (var_1.agent_type == "zombie_sasquatch" || var_1.agent_type == "slasher" || var_1.agent_type == "superslasher" || scripts\engine\utility::is_true(var_1.is_skeleton)))
      var_32 = 0;
    else
      var_32 = 1;

    if(var_32) {
      var_1 thread scripts\cp\crafted_trap_revocator::turn_zombie(var_12);
      var_12 scripts\cp\utility::notify_used_consumable("secret_service");
    }
  }

  var_2 = int(var_2);

  if(!var_15 || var_17) {
    scripts\cp\zombies\zombie_damage::finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_31, var_10, var_11);
    self notify("player_damaged");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("personal", "damage_taken", var_2);

  if(var_2 <= 0) {
    return;
  }
  if(var_16)
    playfxontagforclients(level._effect["sasquatch_rock_hit"], self, "tag_eye", self);

  thread scripts\cp\utility::player_pain_vo();
  thread scripts\cp\zombies\zombie_damage::play_pain_photo(self);
  self playlocalsound("zmb_player_impact_hit");
  thread scripts\cp\utility::player_pain_breathing_sfx();

  if(isDefined(var_1)) {
    thread scripts\cp\cp_hud_util::zom_player_damage_flash();

    if(isagent(var_1)) {
      if(var_2 > self.health)
        var_1.killed_player = 1;

      if(!isDefined(var_1.damage_done))
        var_1.damage_done = 0;
      else
        var_1.damage_done = var_1.damage_done + var_2;

      self.recent_attacker = var_1;

      if(isDefined(level.current_challenge))
        self[[level.custom_playerdamage_challenge_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
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
  } else if(issubstr(var_0, "iw7_harpoon2_zm"))
    var_4 = level._effect["wrecked_by_ben"];
  else
    var_4 = level._effect["wrecked_cheap"];

  foreach(var_7 in var_3) {
    foreach(var_9 in var_7) {
      if((issubstr(var_0, "iw7_harpoon1_zm") || issubstr(var_0, "iw7_acid_rain_projectile_zm")) && !scripts\engine\utility::is_true(level.played_acid_rain_effect)) {
        level.played_acid_rain_effect = 1;

        if(isDefined(var_4))
          playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));

        scripts\engine\utility::waitframe();

        if(isDefined(var_5)) {
          playFX(var_5, var_9["org"]);
          scripts\engine\utility::waitframe();
        }

        continue;
      }

      if((issubstr(var_0, "iw7_harpoon2_zm") || issubstr(var_0, "iw7_harpoon2_zm_stun")) && !scripts\engine\utility::is_true(level.played_ben_franklin_effect)) {
        level.played_ben_franklin_effect = 1;

        if(isDefined(var_4))
          playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));

        scripts\engine\utility::waitframe();
        continue;
      }

      if(isDefined(var_4))
        playFX(var_4, var_9["org"], anglesToForward(var_9["angles"]));

      scripts\engine\utility::waitframe();
    }

    wait 0.01;
  }
}