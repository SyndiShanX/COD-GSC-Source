/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\ratking_damage.gsc
*******************************************************/

cp_ratking_callbacks() {
  level.agent_funcs["ratking"]["on_damaged"] = ::onratkingdamaged;
  level.agent_funcs["ratking"]["on_damage_finished"] = ::onratkingdamagefinished;
  level.agent_funcs["ratking"]["on_killed"] = ::onratkingkilled;
}

onratkingdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  if(!isDefined(self.agent_type)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isplayer(var_1)) {
    if(!isDefined(var_1.owner) || isDefined(var_1.owner) && !isplayer(var_1.owner)) {
      return;
    }
  }

  var_13 = gettime();
  var_2 = 4 - level.players.size - 1;
  var_2 = weapondamageadjustments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_2 = fnfdamageadjustments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  if(scripts\engine\utility::istrue(level.rat_king.disabledamage)) {
    self.fake_damage = var_2;
    var_2 = 0;
  }

  if(isDefined(level.rat_king.shouldteleportthreshold)) {
    if(isDefined(self.next_forced_teleport_time) && var_13 >= self.next_forced_teleport_time) {
      level.rat_king.shouldteleportthreshold++;
      if(level.rat_king.shouldteleportthreshold >= 1) {
        self.next_forced_teleport_time = var_13 + 10000;
        level.rat_king.shouldteleportthreshold = 0;
        scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
      }
    }
  }

  if(isDefined(self.next_pain_time) && var_13 >= self.next_pain_time) {
    self.next_pain_time = var_13 + 1250;
    self notify("pain");
  }

  if(scripts\aitypes\ratking\behaviors::rkisblocking()) {
    if(isDefined(self.next_block_fx_time) && isDefined(var_6) && isDefined(var_7) && var_13 >= self.next_block_fx_time) {
      self.next_block_fx_time = var_13 + 250;
      playFX(level._effect["rk_blocking"], var_6 + var_7 * -50, var_7 * -150);
    }

    if(!scripts\engine\utility::array_contains(level.kungfu_weapons[1], getweaponbasename(var_5))) {
      var_2 = 0;
    }
  }

  var_2 = int(min(var_2, self.health));
  if(isplayer(var_1)) {
    if(isDefined(level.updateondamagepassivesfunc)) {
      level thread[[level.updateondamagepassivesfunc]](var_1, var_5, self);
    }

    var_1 thread scripts\cp\utility::add_to_notify_queue("rat_king_damaged", self, var_1, var_5, var_2, var_8, var_4);
    var_1 thread scripts\cp\agents\gametype_zombie::updatemaghits(getweaponbasename(var_5));
    if(!isDefined(var_1.shotsontargetwithweapon[getweaponbasename(var_5)])) {
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)] = 1;
    } else {
      var_1.shotsontargetwithweapon[getweaponbasename(var_5)]++;
    }
  }

  level thread scripts\cp\utility::add_to_notify_queue("rat_king_damaged", self, var_1, var_5, var_2, var_8, var_4);
  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(var_1, var_2, var_4);
  scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  rkprocessdamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  thread scripts\cp\agents\gametype_zombie::new_enemy_damage_check(var_1);
  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

rkprocessdamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\engine\utility::istrue(var_10.outofplayspace)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_10.disabledamage)) {
    if(scripts\engine\utility::flag_exist("relic_active")) {
      if(!scripts\engine\utility::flag("relic_active")) {
        return;
      }
    } else {
      return;
    }
  }

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
  if(var_10 scripts\aitypes\ratking\behaviors::rkisblocking()) {
    var_12 = "hitalienarmor";
  } else if(var_10 || var_11 || var_12 || var_14) {
    var_12 = "card_boosted";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_16) {
    var_12 = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_17) {
    var_12 = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_15) {
    var_12 = "high_damage";
  } else if(isplayer(var_1) && scripts\engine\utility::istrue(var_1.deadeye_charge) && var_15) {
    var_12 = "special_weapon";
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1.owner thread rkupdatedamagefeedback(var_12, var_13, var_2, var_10.riotblock);
      return;
    }

    var_1 thread rkupdatedamagefeedback(var_12, var_13, var_2, var_10.riotblock);
  }
}

rkupdatedamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](var_4, var_5, var_6)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  var_7 = "standard_cp";
  var_8 = undefined;
  if(isDefined(var_1) && var_1) {
    self playlocalsound("cp_hit_alert_strong");
  } else if(scripts\engine\utility::istrue(self.deadeye_charge)) {
    self playlocalsound("cp_hit_alert_perk");
  } else {
    self playlocalsound("cp_hit_alert");
  }

  switch (var_0) {
    case "hitalienarmor":
      self setclientomnvar("damage_feedback_icon", var_0);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      var_3 = 1;
      break;

    case "hitcritical":
    case "hitaliensoft":
      var_8 = 1;
      break;

    case "stun":
    case "meleestun":
      if(!isDefined(self.meleestun)) {
        self playlocalsound("crate_impact");
        self.meleestun = 1;
      }

      self setclientomnvar("damage_feedback_icon", "hitcritical");
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      wait(0.2);
      self.meleestun = undefined;
      break;

    case "high_damage":
      var_7 = "high_damage_cp";
      break;

    case "special_weapon":
      var_7 = "wor_weapon_cp";
      break;

    case "card_boosted":
      var_7 = "fnf_card_damage_cp";
      break;

    case "red_arcane_cp":
      var_7 = "red_arcane_cp";
      break;

    case "blue_arcane_cp":
      var_7 = "blue_arcane_cp";
      break;

    case "yellow_arcane_cp":
      var_7 = "yellow_arcane_cp";
      break;

    case "green_arcane_cp":
      var_7 = "green_arcane_cp";
      break;

    case "pink_arcane_cp":
      var_7 = "pink_arcane_cp";
      break;

    case "none":
      break;

    default:
      break;
  }

  rkupdatehitmarker(var_7, var_8, var_2, var_3, var_1);
}

rkupdatehitmarker(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self setclientomnvar("damage_scale_type", "standard");
  if(var_4) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_3) {
    self setclientomnvar("damage_scale_type", "hitalienarmor");
  }

  if(var_1) {
    self setclientomnvar("damage_scale_type", "hitaliensoft");
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(isDefined(var_2)) {
    self setclientomnvar("ui_damage_amount", int(var_2));
  }

  self setclientomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());
}

adjustrkcooldowns() {
  var_0 = gettime();
  if(scripts\engine\utility::istrue(scripts\aitypes\ratking\behaviors::rk_shouldbeonplatform())) {
    scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
  }
}

onratkingdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(scripts\aitypes\ratking\behaviors::rkisblocking()) {
    var_2 = var_2 * 0.1;
    var_2 = int(var_2);
  }

  scripts\mp\agents\ratking\ratking_agent::accumulatedamage(var_2, var_7);
  scripts\mp\agents\ratking\ratking_agent::ratking_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_11, var_12);
}

onratkingkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\cp\agents\gametype_zombie::process_kill_rewards(var_0, var_1, self, var_6, var_3, var_4);
  scripts\cp\agents\gametype_zombie::process_assist_rewards(var_1);
  scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(var_1, var_4, var_6, var_3, self.agent_type);
  if(isDefined(level.death_challenge_update_func)) {
    [[level.death_challenge_update_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  scripts\cp\cp_agent_utils::deactivateagent();
  level.rat_king = undefined;
  level notify("zombie_killed", self.origin, var_4, var_3);
  level notify("rat_king_killed", self.origin);
  if(isplayer(var_1)) {
    if(var_1.vo_prefix == "p5_") {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_death", "rave_ww_vo", "highest", 70, 0, 0, 1);
      return;
    }

    var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_death_p5", "rave_ww_vo", "highest", 70, 0, 0, 1);
  }
}

weapondamageadjustments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = 0;
  if(isplayer(var_1)) {
    var_13 = scripts\cp\utility::getweaponclass(var_5);
    var_14 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
    var_15 = var_4 == "MOD_MELEE";
    if(!var_15) {
      switch (var_13) {
        case "weapon_assault":
          break;

        case "weapon_smg":
          break;

        case "weapon_lmg":
          break;

        case "weapon_shotgun":
          break;

        case "weapon_pistol":
          break;

        case "other":
          break;
      }
    }

    var_10 = var_14 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
    var_11 = isexplosivedamage(var_4, var_8);
    var_12 = !scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5) && var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
    var_13 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_5);
    var_2 = var_2 * var_13;
    if(var_12) {
      var_12 = var_12 + 5;
    }

    if(var_10) {
      var_12 = var_12 + 5;
    }

    var_12 = returnkungfuweaponadjustments(var_5, var_12);
  }

  return var_2 + var_12;
}

returnkungfuweaponadjustments(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level.kungfu_weapons[0], getweaponbasename(var_0))) {
    var_1 = var_1 + 5;
  } else if(scripts\engine\utility::array_contains(level.kungfu_weapons[2], getweaponbasename(var_0))) {
    var_1 = var_1 + 20;
    scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
  } else if(scripts\engine\utility::array_contains(level.kungfu_weapons[1], getweaponbasename(var_0))) {
    var_1 = var_1 + 10;
    var_2 = scripts\asm\asm::asm_getcurrentstate("ratking");
    if(isDefined(var_2) && var_2 == "staff_stomp" || var_2 == "staff_projectile") {
      thread scripts\aitypes\ratking\behaviors::retrievestaffaftertime();
    } else if(scripts\aitypes\ratking\behaviors::rkissummoning()) {
      if(scripts\engine\utility::flag("relic_active")) {
        thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime(5);
      } else {
        thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime();
      }
    } else if(scripts\aitypes\ratking\behaviors::rkisblocking()) {
      if(scripts\engine\utility::flag("relic_active")) {
        thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime(5);
      } else {
        thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime();
      }
    }
  }

  return var_1;
}

isexplosivedamage(var_0, var_1) {
  if((var_0 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_1) && var_1 == "none") || var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    return 1;
  }

  return 0;
}

fnfdamageadjustments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isplayer(var_1)) {}

  return var_2;
}