/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3257.gsc
*********************************************/

main() {
  scripts\mp\agents\zombie\zmb_zombie_agent::registerscriptedagent();
  scripts\mp\agents\zombie_brute\zombie_brute_agent::registerscriptedagent();
  scripts\mp\agents\zombie_ghost\zombie_ghost_agent::registerscriptedagent();
  level.agent_funcs["generic_zombie"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::onzombiekilled;
  level.in_room_check_func = scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.fnzombieshouldenterplayspace = ::zombieshouldenterplayspace;
  level.fnzombieenterplayspace = ::zombieenterplayspace;
  level.movemodefunc["generic_zombie"] = ::run_if_last_zombie;
  level.zombies_spawn_score_func = ::escape_spawn_score_func;
  level.current_room_index = 0;
  level.fn_get_closest_entrance = scripts\cp\utility::get_closest_entrance;
}

escape_spawn_score_func() {
  var_0 = 4096;
  var_1 = [];
  foreach(var_3 in level.active_spawners) {
    var_4 = 0;
    if(positionwouldtelefrag(var_3.origin)) {
      continue;
    }

    foreach(var_6 in level.players) {
      if(scripts\engine\utility::within_fov(var_6.origin, var_6.angles, var_3.origin, level.cosine["90"])) {
        var_4 = 1;
      }
    }

    if(!var_4) {
      continue;
    } else {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    var_1 = level.active_spawners;
  }

  return scripts\engine\utility::random(var_1);
}

onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
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

  var_0D = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_0C);
  if(!var_0D) {
    return;
  }

  var_0E = var_4 == "MOD_MELEE";
  var_0F = isDefined(self.isfrozen) && isDefined(var_5) && !scripts\cp\cp_weapon::isforgefreezeweapon(var_5) || var_4 == "MOD_MELEE";
  var_10 = scripts\engine\utility::isbulletdamage(var_4);
  var_11 = isDefined(var_1) && isplayer(var_1);
  var_12 = scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  var_13 = (var_1 scripts\cp\cp_weapon::has_attachment(var_5, "overclock") || var_1 scripts\cp\cp_weapon::has_attachment(var_5, "overclockcp")) && var_10;
  var_14 = scripts\engine\utility::istrue(self.battleslid);
  var_15 = scripts\engine\utility::istrue(level.insta_kill);
  var_16 = var_12 && var_10 && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_17 = var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH";
  var_18 = var_0E && var_1 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_19 = 0;
  if(!var_0E && var_11 && !isDefined(var_1.linked_to_coaster) && var_1 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_19 = var_1 scripts\cp\utility::coop_getweaponclass(var_5) == "weapon_sniper";
  }

  var_1A = scripts\engine\utility::istrue(level.explosive_touch) && isDefined(var_4) && var_4 == "MOD_UNKNOWN";
  var_1B = var_14 || var_15 || var_1A || var_0F || var_13 || var_16 || var_18 || var_19;
  if(var_10) {
    var_1 notify("weapon_hit_enemy", self, var_1);
  }

  var_1C = isDefined(self.isfrozen);
  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(var_5)) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(var_0.origin, var_6, var_7);
    return;
  } else if(isDefined(var_5) && scripts\cp\cp_weapon::isforgefreezeweapon(var_5) && !var_0E) {
    if(!var_1C) {
      self.isfrozen = 1;
      thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    }

    return;
  } else if(var_1B) {
    if(var_19) {
      var_1 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    var_2 = int(self.maxhealth);
  } else {
    var_8 = shitloc_mods(var_1, var_4, var_5, var_8);
    var_1D = level.wave_num;
    var_1E = is_grenade(var_5, var_4);
    var_1F = scripts\engine\utility::istrue(self.is_burning) && !var_10;
    var_20 = var_0E && var_1 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
    var_21 = var_12 && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_22 = var_10 && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_23 = var_10 && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_24 = var_10 && isDefined(var_1.special_ammo_type) && var_1.special_ammo_type == "stun_ammo" || var_1.special_ammo_type == "combined_ammo";
    var_25 = var_11 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_26 = var_11 && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_27 = is_axe_weapon(var_5);
    if(isDefined(var_2) && isDefined(var_8) && !var_15 && var_10) {
      var_28 = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_0C, var_1, var_2, var_8, var_7);
      if(var_28 <= 0) {
        return;
      }

      var_2 = var_28;
    }

    var_2 = initial_weapon_scale(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);
    shotgun_scaling(var_1, var_0C, var_5);
    if(var_11) {
      if(var_0E) {
        var_2 = int(var_2 * var_1 scripts\cp\perks\perk_utility::perk_getmeleescalar());
        if(var_26) {
          var_2 = var_2 + 1500;
        }

        if(var_27) {
          if(var_2 >= self.health) {
            var_29 = anglesToForward(var_1.angles);
            var_2A = vectornormalize(var_29) * -100;
            self setvelocity(vectornormalize(self.origin - var_1.origin + var_2A) * 400 + (0, 0, 10));
            self.do_immediate_ragdoll = 1;
            self.customdeath = 1;
          }
        }
      }

      if(var_24) {
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self.origin, self, var_2, var_4);
      }

      if(var_20 && weapontype(var_5) != "riotshield") {
        var_1 thread scripts\cp\zombies\zombie_damage::stun_zap(self.origin, self, var_2, "MOD_UNKNOWN", undefined, var_20);
      }

      if(var_25 && var_17) {
        var_2 = int(var_2 * 2);
      }
    }

    if(var_21) {
      var_2 = var_2 * 3;
    }

    if(var_22) {
      var_2B = int(var_1 getweaponammoclip(var_1 getcurrentweapon()) + 1);
      var_2C = weaponclipsize(var_1 getcurrentweapon());
      if(var_2B <= 4) {
        var_2 = var_2 * 4;
      }
    }

    if(scripts\engine\utility::istrue(var_1.reload_damage_increase)) {
      var_2 = var_2 * 5;
    }

    if(var_1E) {
      var_2 = var_2 * min(2 + var_1D * 0.5, 10);
    }

    if(var_23) {
      var_2 = int(var_2 * 2);
    }
  }

  var_2 = int(min(var_2, self.maxhealth));
  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(var_1, var_2, var_4);
  scripts\cp\cp_agent_utils::process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_0A, var_0B);
}

should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return 0;
  }

  if(var_3 == "iw7_armageddonmeteor_mp") {
    return 0;
  }

  if(is_axe_weapon(var_3) && var_1 < 10) {
    return 0;
  }

  return 1;
}

is_grenade(var_0, var_1) {
  var_2 = var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_GRENADE";
  return var_2 && var_0 == "frag_grenade_zm" || var_0 == "frag_grenade_mp" || var_0 == "throwingknifec4_mp" || var_0 == "gas_grenade_mp" || var_0 == "semtex_mp" || var_0 == "semtex_zm" || var_0 == "c4_mp" || var_0 == "c4_zm" || var_0 == "cluster_grenade_zm";
}

onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\cp\zombies\zombie_scriptable_states::turn_off_states_on_death(self);
  if(isplayer(var_1)) {
    var_1 notify("zombie_killed", self, self.origin, var_4, var_3, var_6);
  }

  if(!isonhumanteam(self)) {
    enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
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

  if(isDefined(self.near_medusa)) {
    level thread[[level.medusa_killed_func]](self.origin);
  }

  if(isDefined(self.near_crystal)) {
    if(isDefined(level.closest_crystal_func)) {
      var_9 = level[[level.closest_crystal_func]](self);
    } else {
      var_9 = undefined;
    }

    if(isDefined(level.crystal_killed_notify)) {
      level notify(level.crystal_killed_notify, self.origin, var_4, var_9);
    }
  }

  self hudoutlinedisable();
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self.closest_entrance = undefined;
  self.attack_spot = undefined;
  self.reached_entrance_goal = undefined;
  self.head_is_exploding = undefined;
  self.near_medusa = undefined;
  process_kill_rewards(var_1, self, var_6, var_3, var_4);
  process_assist_rewards(var_1);
  scripts\cp\cp_challenge::update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  scripts\cp\cp_agent_utils::deactivateagent();
  scripts\cp\zombies\zombie_armor::clean_up_zombie_armor(self);
}

process_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  give_attacker_kill_rewards(var_0, var_2, var_3, var_4);
  var_5 = scripts\cp\cp_agent_utils::get_agent_type(var_1);
  var_6 = scripts\cp\utility::get_attacker_as_player(var_0);
  if(!isDefined(var_5)) {
    return;
  }

  if(isDefined(var_6)) {
    scripts\cp\cp_persistence::record_player_kills(var_6);
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
    if(gettime() < level.last_drop_time + 5000) {
      return;
    }

    if(scripts\cp\utility::coop_mode_has("pillage") && scripts\engine\utility::istrue([
        [level.pillage_item_drop_func]
      ](var_5, self.origin, var_0))) {
      level.last_drop_time = gettime();
      return;
    }

    if(scripts\cp\utility::coop_mode_has("loot") && isDefined(level.loot_func)) {
      [
        [level.loot_func]
      ](var_5, self.origin, var_0);
      return;
    }
  }
}

zombie_near_equipment(var_0) {
  var_1 = 16384;
  var_2 = 0;
  if(level.placedims.size) {
    foreach(var_4 in level.placedims) {
      if(distance2dsquared(var_4.origin, self.origin) < var_1) {
        var_2 = 1;
      }
    }

    if(var_2) {
      return 1;
    }
  }

  if(level.turrets.size) {
    foreach(var_7 in level.turrets) {
      if(distance2dsquared(var_7.origin, self.origin) < var_1) {
        var_2 = 1;
      }
    }

    if(var_2) {
      return 1;
    }
  }

  return 0;
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

give_attacker_kill_rewards(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.team) && self.team == var_0.team) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isplayer(var_0) && !isDefined(var_0.triggerportableradarping) || !isplayer(var_0.triggerportableradarping)) {
    return;
  }

  var_4 = level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    var_4 = 130;
  }

  var_5 = 0;
  if(isDefined(var_0.triggerportableradarping)) {
    var_0 = var_0.triggerportableradarping;
    var_5 = 1;
  }

  if(scripts\cp\utility::isheadshot(var_3, var_1, var_2, var_0) && !var_5 && scripts\engine\utility::isbulletdamage(var_2)) {
    var_4 = int(100);
  }

  givekillreward(var_0, var_4, "large", var_1, var_3, var_2);
}

givekillreward(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = var_1 * level.cash_scalar;
  if(var_0 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(var_5) && var_0 scripts\cp\utility::coop_getweaponclass(var_4) == "weapon_sniper") {
    var_1 = var_1 + 300;
    var_0 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
  }

  if(should_get_currency_from_kill(var_0)) {
    var_0 scripts\cp\cp_persistence::give_player_currency(var_1, var_2, var_3);
  }

  if(weapon_is_crafted_turret(var_4)) {
    foreach(var_7 in level.players) {
      if(var_7 == var_0) {
        continue;
      }

      if(!var_7 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var_7 scripts\cp\cp_persistence::give_player_currency(var_1, var_2, var_3);
    }
  }

  if(isDefined(level.zombie_xp)) {
    var_0 scripts\cp\cp_persistence::give_player_xp(int(var_1));
  }
}

should_get_currency_from_kill(var_0) {
  if(isplayer(var_0) && scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 0;
  }

  return 1;
}

weapon_is_crafted_turret(var_0) {
  return isDefined(var_0) && var_0 == "alien_sentry_minigun_4_mp";
}

enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.lastenemydeathpos = self.origin;
  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

isonhumanteam(var_0) {
  if(isDefined(var_0.team)) {
    return var_0.team == level.playerteam;
  }

  return 0;
}

shitloc_mods(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isplayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade") && scripts\cp\utility::coop_getweaponclass(var_2) == "weapon_sniper") {
    return "head";
  }

  if(isDefined(var_0) && isplayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::is_consumable_active("increased_limb_damage") && is_limb(var_2, var_3, var_1, var_0)) {
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
      return;
    }

    if(var_0.pelletdmg[var_3][var_1.guid] + 1 > 2) {
      return;
    }

    var_0.pelletdmg[var_3][var_1.guid]++;
    return;
  }
}

initial_weapon_scale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(!can_scale_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B)) {
    return var_2;
  }

  var_2 = scale_ww_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  if(isDefined(var_4) && var_4 == "MOD_MELEE") {
    if(!is_axe_weapon(var_5)) {
      var_2 = 150;
    }

    return var_2;
  }

  return var_2;
}

is_axe_weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw6_cphcmelee_mp":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

scale_ww_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = scripts\cp\utility::getrawbaseweaponname(var_5);
  switch (var_0C) {
    case "shredder":
    case "headcutter":
    case "facemelter":
    case "dischord":
      var_2 = max(7500, self.maxhealth / 2);
      break;
  }

  return var_2;
}

can_scale_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_1.inlaststand)) {
    return 0;
  }

  if(!isDefined(var_1.pap)) {
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

eligible_for_reward(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(scripts\cp\cp_laststand::player_in_laststand(var_0))) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  switch (var_1) {
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      if(var_2 == "gas_grenade_mp" || var_2 == "splash_grenade_zm") {
        if(isDefined(var_3.flame_damage_time)) {
          if(gettime() > var_3.flame_damage_time) {
            return 1;
          } else {
            return 0;
          }
        }
      }
      return 1;

    case "MOD_UNKNOWN":
      if(scripts\engine\utility::istrue(var_3.is_burning) && isDefined(var_3.flame_damage_time)) {
        if(gettime() > var_3.flame_damage_time) {
          return 1;
        }
      }
      return 0;

    default:
      break;
  }

  if(!scripts\engine\utility::istrue(var_3.is_burning)) {
    return 1;
  }

  if(!scripts\engine\utility::istrue(var_3.marked_for_death)) {
    return 1;
  }

  return 0;
}

onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  var_0D = scripts\cp\utility::is_trap(var_0);
  if((isDefined(var_1) && isDefined(var_4) && scripts\engine\utility::isbulletdamage(var_4) || scripts\cp\utility::player_has_special_ammo(var_1, "combined_ammo") && var_4 == "MOD_EXPLOSIVE_BULLET") || var_5 == "poison_ammo_mp") {
    if(isplayer(var_1) || isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
      if(!var_0D) {
        var_1 check_for_special_damage(self, var_0, var_3, var_5, var_4);
      }
    }
  }

  var_0E = 10 * level.cash_scalar;
  if(isDefined(var_1)) {
    if(isDefined(var_1.perk_data) && var_1.perk_data["damagemod"].bullet_damage_scalar == 2) {
      var_0E = var_0E * 2;
    }

    if(eligible_for_reward(var_1, var_4, var_5, self)) {
      if(var_1 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        var_1 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_0E = var_0E * 5;
      }

      var_1 scripts\cp\cp_persistence::give_player_currency(var_0E, "large", var_8);
    }
  }

  if(isDefined(var_8) && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1)) {
    if(var_1 scripts\cp\utility::is_consumable_active("armor_after_headshot")) {
      var_0F = 25;
      if(isDefined(var_1.bodyarmorhp)) {
        var_0F = int(var_1.bodyarmorhp + 25);
      }

      var_1 notify("enable_armor");
    }
  }
}

check_for_special_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 scripts\cp\utility::is_trap(var_1);
  var_6 = var_0 should_do_stun_damage(var_3, var_4, self);
  if(!isDefined(var_0.is_afflicted) && isalive(var_0)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "combined_ammo") || var_3 == "slayer_ammo_mp") {
      var_7 = int(var_0.maxhealth);
      var_0 thread scripts\cp\utility::damage_over_time(var_0, self, 20, var_7, var_4, "slayer_ammo_mp", undefined, "combinedArcane");
    }
  }

  if(!isDefined(var_0.is_afflicted) && !isDefined(var_0.is_burning) && isalive(var_0)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || var_3 == "incendiary_ammo_mp") {
      var_7 = min(var_0.maxhealth * 0.66, 1000);
      var_0 thread scripts\cp\utility::damage_over_time(var_0, self, 5, var_7, var_4, "incendiary_ammo_mp", undefined, "burning");
    }
  }

  if(var_6 && !var_5) {
    self.stunned = 1;
    var_0 thread fx_stun_damage();
    var_0 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(var_0);
    var_2 = var_2 | level.idflags_stun;
  }
}

fx_stun_damage() {
  self endon("death");
  wait(1);
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

  if(scripts\engine\utility::istrue(self.is_burning)) {
    return 0;
  }

  if(isDefined(var_2) && isDefined(var_2.category) && var_2.category == "lightning_tower") {
    return 1;
  }

  if(isDefined(var_2) && isplayer(var_2) && var_1 != "MOD_MELEE") {
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

  var_0 = getclosestentrance();
  if(!isDefined(var_0)) {
    iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
    return 0;
  }

  return 1;
}

getclosestentrance() {
  if(isDefined(self.closest_entrance)) {
    return self.closest_entrance;
  }

  self.closest_entrance = scripts\cp\utility::get_closest_entrance(self.origin);
  return self.closest_entrance;
}

zombieenterplayspace() {
  self endon("death");
  var_0 = getclosestentrance();
  if(!isDefined(var_0)) {
    iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.reached_entrance_goal)) {
    if(!isDefined(self.attack_spot)) {
      var_1 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(var_0);
      if(!var_1.occupied) {
        var_1.occupied = 1;
      }

      self.attack_spot = var_1;
    }

    self.precacheleaderboards = 1;
    self ghostskulls_total_waves(32);
    self ghostskulls_complete_status(self.attack_spot.origin);
    self waittill("goal_reached");
    self.reached_entrance_goal = 1;
  }

  while(scripts\cp\zombies\zombie_entrances::entrance_has_barriers(var_0)) {
    if(!isDefined(self.attack_spot)) {
      var_1 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(var_0);
      if(!var_1.occupied) {
        var_1.occupied = 1;
      }

      self.attack_spot = var_1;
    }

    self ghostskulls_total_waves(16);
    self ghostskulls_complete_status(self.attack_spot.origin);
    self waittill("goal_reached");
    if(!isDefined(var_0.window_attack_ent)) {
      if(isDefined(var_0.attack_position)) {
        var_0.window_attack_ent = spawn("script_origin", var_0.attack_position.origin);
      } else {
        var_0.window_attack_ent = spawn("script_origin", var_0.origin + (0, 0, 20));
      }

      var_0.window_attack_ent setCanDamage(1);
      var_0.window_attack_ent.health = 100000;
      var_0.window_attack_ent.team = "allies";
    }

    if(should_attack_nearby_player()) {
      attack_nearby_player();
      continue;
    }

    break_barrier_from_entrance(var_0);
  }

  self.precacheleaderboards = 0;
  return 0;
}

should_attack_nearby_player() {
  var_0 = 100;
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
  if(!level.current_interaction_structs.size) {
    return undefined;
  }

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
  self.curmeleetarget = self.closest_player_near_interaction_point;
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  var_0 = scripts\engine\utility::waittill_any_return("attack_hit", "attack_miss");
  var_1 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);
  if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_1)) {
    scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, scripts\asm\zombie\melee::get_melee_damage_dealt(), "MOD_IMPACT");
  }
}

break_barrier_from_entrance(var_0) {
  self.curmeleetarget = var_0.window_attack_ent;
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\engine\utility::waittill_any_3("attack_hit", "attack_miss");
  scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(var_0);
  if(!scripts\cp\zombies\zombie_entrances::entrance_has_barriers(var_0)) {
    if(isDefined(var_0.window_attack_ent)) {
      var_0.window_attack_ent delete();
    }

    scripts\asm\asm_bb::bb_clearmeleerequest();
    self.curmeleetarget = undefined;
    self.precacheleaderboards = 0;
    self.ignoreme = 0;
    self.attack_spot = undefined;
    thread kill_me_if_stuck();
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
  while(!scripts\engine\utility::istrue(self.entered_playspace)) {
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
        wait(2);
        continue;
      }

      var_0 = 1;
      break;
    } else {
      wait(2);
    }
  }

  if(!var_0) {
    return;
  }

  self.died_poorly = 1;
  if(scripts\engine\utility::istrue(self.marked_for_challenge) && isDefined(level.num_zombies_marked)) {
    level.num_zombies_marked--;
  }

  self dodamage(self.health + 1000, self.origin, self, self, "MOD_SUICIDE");
}

zombies_should_mutilate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_4)) {
    switch (var_4) {
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_EXPLOSIVE":
        return 1;

      case "MOD_MELEE":
        if(isDefined(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack")) {
          return 1;
        } else {
          return 0;
        }

        break;

      default:
        break;
    }
  }

  if(isDefined(var_5)) {
    var_9 = weaponclass(var_5);
    if(isDefined(var_9) && var_9 == "spread") {
      return 1;
    }

    var_0A = getweaponbasename(var_5);
    if(isDefined(var_0A)) {
      switch (var_0A) {
        case "iw7_m8_zm":
        case "iw7_kbs_zm":
        case "iw7_chargeshot_zm":
        case "iw7_shredder_zm":
          return 1;

        default:
          break;
      }
    }
  }

  return 0;
}

is_limb(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.triggerportableradarping)) {
      if(var_3.var_9F == "script_vehicle") {
        return 0;
      }

      if(var_3.var_9F == "misc_turret") {
        return 0;
      }

      if(var_3.var_9F == "script_model") {
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
  var_1 = scripts\mp\agents\zombie\zmb_zombie_agent::calulatezombiemovemode(var_0);
  if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths == 1) {
    if(var_1 != "sprint") {
      return "run";
    }
  }

  return var_1;
}