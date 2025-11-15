/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3257.gsc
************************/

main() {
  scripts\mp\agents\zombie\zmb_zombie_agent::registerscriptedagent();
  scripts\mp\agents\zombie_brute\zombie_brute_agent::registerscriptedagent();
  scripts\mp\agents\zombie_ghost\zombie_ghost_agent::registerscriptedagent();
  level.agent_funcs["generic_zombie"]["on_damaged"] = ::onzombiedamaged;
  level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::onzombiekilled;
  level.in_room_check_func = ::scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.fnzombieshouldenterplayspace = ::zombieshouldenterplayspace;
  level.fnzombieenterplayspace = ::zombieenterplayspace;
  level.movemodefunc["generic_zombie"] = ::run_if_last_zombie;
  level.zombies_spawn_score_func = ::escape_spawn_score_func;
  level.current_room_index = 0;
  level.fn_get_closest_entrance = ::scripts\cp\utility::get_closest_entrance;
}

escape_spawn_score_func() {
  var_00 = 4096;
  var_01 = [];
  foreach(var_03 in level.active_spawners) {
    var_04 = 0;
    if(positionwouldtelefrag(var_03.origin)) {
      continue;
    }

    foreach(var_06 in level.players) {
      if(scripts\engine\utility::within_fov(var_06.origin, var_06.angles, var_03.origin, level.cosine["90"])) {
        var_04 = 1;
      }
    }

    if(!var_04) {
      continue;
    } else {
      var_01[var_01.size] = var_03;
    }
  }

  if(var_01.size == 0) {
    var_01 = level.active_spawners;
  }

  return scripts\engine\utility::random(var_01);
}

onzombiedamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
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

  var_0E = param_04 == "MOD_MELEE";
  var_0F = isDefined(self.isfrozen) && isDefined(param_05) && !scripts\cp\cp_weapon::isforgefreezeweapon(param_05) || param_04 == "MOD_MELEE";
  var_10 = scripts\engine\utility::isbulletdamage(param_04);
  var_11 = isDefined(param_01) && isplayer(param_01);
  var_12 = scripts\cp\utility::isheadshot(param_05, param_08, param_04, param_01);
  var_13 = (param_01 scripts\cp\cp_weapon::has_attachment(param_05, "overclock") || param_01 scripts\cp\cp_weapon::has_attachment(param_05, "overclockcp")) && var_10;
  var_14 = scripts\engine\utility::istrue(self.battleslid);
  var_15 = scripts\engine\utility::istrue(level.insta_kill);
  var_16 = var_12 && var_10 && param_01 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_17 = param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH";
  var_18 = var_0E && param_01 scripts\cp\utility::is_consumable_active("increased_melee_damage");
  var_19 = 0;
  if(!var_0E && var_11 && !isDefined(param_01.linked_to_coaster) && param_01 scripts\cp\utility::is_consumable_active("sniper_soft_upgrade")) {
    var_19 = param_01 scripts\cp\utility::coop_getweaponclass(param_05) == "weapon_sniper";
  }

  var_1A = scripts\engine\utility::istrue(level.explosive_touch) && isDefined(param_04) && param_04 == "MOD_UNKNOWN";
  var_1B = var_14 || var_15 || var_1A || var_0F || var_13 || var_16 || var_18 || var_19;
  if(var_10) {
    param_01 notify("weapon_hit_enemy", self, param_01);
  }

  var_1C = isDefined(self.isfrozen);
  if(scripts\cp\powers\coop_armageddon::isfirstarmageddonmeteorhit(param_05)) {
    thread scripts\cp\powers\coop_armageddon::fling_zombie_from_meteor(param_00.origin, param_06, param_07);
    return;
  } else if(isDefined(param_05) && scripts\cp\cp_weapon::isforgefreezeweapon(param_05) && !var_0E) {
    if(!var_1C) {
      self.isfrozen = 1;
      thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    }

    return;
  } else if(var_1B) {
    if(var_19) {
      param_01 scripts\cp\utility::notify_used_consumable("sniper_soft_upgrade");
    }

    param_02 = int(self.maxhealth);
  } else {
    param_08 = shitloc_mods(param_01, param_04, param_05, param_08);
    var_1D = level.wave_num;
    var_1E = is_grenade(param_05, param_04);
    var_1F = scripts\engine\utility::istrue(self.is_burning) && !var_10;
    var_20 = var_0E && param_01 scripts\cp\utility::is_consumable_active("shock_melee_upgrade");
    var_21 = var_12 && param_01 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
    var_22 = var_10 && param_01 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
    var_23 = var_10 && param_01 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
    var_24 = var_10 && isDefined(param_01.special_ammo_type) && param_01.special_ammo_type == "stun_ammo" || param_01.special_ammo_type == "combined_ammo";
    var_25 = var_11 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_boom");
    var_26 = var_11 && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack");
    var_27 = is_axe_weapon(param_05);
    if(isDefined(param_02) && isDefined(param_08) && !var_15 && var_10) {
      var_28 = scripts\cp\zombies\zombie_armor::process_damage_to_armor(var_0C, param_01, param_02, param_08, param_07);
      if(var_28 <= 0) {
        return;
      }

      param_02 = var_28;
    }

    param_02 = initial_weapon_scale(undefined, param_01, param_02, undefined, param_04, param_05, undefined, undefined, param_08, undefined, undefined, undefined);
    shotgun_scaling(param_01, var_0C, param_05);
    if(var_11) {
      if(var_0E) {
        param_02 = int(param_02 * param_01 scripts\cp\perks\perk_utility::perk_getmeleescalar());
        if(var_26) {
          param_02 = param_02 + 1500;
        }

        if(var_27) {
          if(param_02 >= self.health) {
            var_29 = anglesToForward(param_01.angles);
            var_2A = vectornormalize(var_29) * -100;
            self setvelocity(vectornormalize(self.origin - param_01.origin + var_2A) * 400 + (0, 0, 10));
            self.do_immediate_ragdoll = 1;
            self.customdeath = 1;
          }
        }
      }

      if(var_24) {
        param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self.origin, self, param_02, param_04);
      }

      if(var_20 && weapontype(param_05) != "riotshield") {
        param_01 thread scripts\cp\zombies\zombie_damage::stun_zap(self.origin, self, param_02, "MOD_UNKNOWN", undefined, var_20);
      }

      if(var_25 && var_17) {
        param_02 = int(param_02 * 2);
      }
    }

    if(var_21) {
      param_02 = param_02 * 3;
    }

    if(var_22) {
      var_2B = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
      var_2C = weaponclipsize(param_01 getcurrentweapon());
      if(var_2B <= 4) {
        param_02 = param_02 * 4;
      }
    }

    if(scripts\engine\utility::istrue(param_01.reload_damage_increase)) {
      param_02 = param_02 * 5;
    }

    if(var_1E) {
      param_02 = param_02 * min(2 + var_1D * 0.5, 10);
    }

    if(var_23) {
      param_02 = int(param_02 * 2);
    }
  }

  param_02 = int(min(param_02, self.maxhealth));
  scripts\cp\zombies\zombies_gamescore::update_agent_damage_performance(param_01, param_02, param_04);
  scripts\cp\cp_agent_utils::process_damage_rewards(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  scripts\cp\cp_agent_utils::process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  scripts\cp\cp_agent_utils::store_attacker_info(param_01, param_02);
  scripts\cp\zombies\zombies_weapons::special_weapon_logic(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
}

should_do_damage_checks(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_03)) {
    return 0;
  }

  if(param_03 == "iw7_armageddonmeteor_mp") {
    return 0;
  }

  if(is_axe_weapon(param_03) && param_01 < 10) {
    return 0;
  }

  return 1;
}

is_grenade(param_00, param_01) {
  var_02 = param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD_GRENADE";
  return var_02 && param_00 == "frag_grenade_zm" || param_00 == "frag_grenade_mp" || param_00 == "throwingknifec4_mp" || param_00 == "gas_grenade_mp" || param_00 == "semtex_mp" || param_00 == "semtex_zm" || param_00 == "c4_mp" || param_00 == "c4_zm" || param_00 == "cluster_grenade_zm";
}

onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  scripts\cp\zombies\zombie_scriptable_states::turn_off_states_on_death(self);
  if(isplayer(param_01)) {
    param_01 notify("zombie_killed", self, self.origin, param_04, param_03, param_06);
  }

  if(!isonhumanteam(self)) {
    enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
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

  if(isDefined(self.near_medusa)) {
    level thread[[level.medusa_killed_func]](self.origin);
  }

  if(isDefined(self.near_crystal)) {
    if(isDefined(level.closest_crystal_func)) {
      var_09 = level[[level.closest_crystal_func]](self);
    } else {
      var_09 = undefined;
    }

    if(isDefined(level.crystal_killed_notify)) {
      level notify(level.crystal_killed_notify, self.origin, param_04, var_09);
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
  process_kill_rewards(param_01, self, param_06, param_03, param_04);
  process_assist_rewards(param_01);
  scripts\cp\cp_challenge::update_death_challenges(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  scripts\cp\cp_merits::process_agent_on_killed_merits(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  scripts\cp\cp_agent_utils::deactivateagent();
  scripts\cp\zombies\zombie_armor::clean_up_zombie_armor(self);
}

process_kill_rewards(param_00, param_01, param_02, param_03, param_04) {
  give_attacker_kill_rewards(param_00, param_02, param_03, param_04);
  var_05 = scripts\cp\cp_agent_utils::get_agent_type(param_01);
  var_06 = scripts\cp\utility::get_attacker_as_player(param_00);
  if(!isDefined(var_05)) {
    return;
  }

  if(isDefined(var_06)) {
    scripts\cp\cp_persistence::record_player_kills(var_06);
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
    if(gettime() < level.last_drop_time + 5000) {
      return;
    }

    if(scripts\cp\utility::coop_mode_has("pillage") && scripts\engine\utility::istrue([
        [level.pillage_item_drop_func]
      ](var_05, self.origin, param_00))) {
      level.last_drop_time = gettime();
      return;
    }

    if(scripts\cp\utility::coop_mode_has("loot") && isDefined(level.loot_func)) {
      [
        [level.loot_func]
      ](var_05, self.origin, param_00);
      return;
    }
  }
}

zombie_near_equipment(param_00) {
  var_01 = 16384;
  var_02 = 0;
  if(level.placedims.size) {
    foreach(var_04 in level.placedims) {
      if(distance2dsquared(var_04.origin, self.origin) < var_01) {
        var_02 = 1;
      }
    }

    if(var_02) {
      return 1;
    }
  }

  if(level.turrets.size) {
    foreach(var_07 in level.turrets) {
      if(distance2dsquared(var_07.origin, self.origin) < var_01) {
        var_02 = 1;
      }
    }

    if(var_02) {
      return 1;
    }
  }

  return 0;
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

give_attacker_kill_rewards(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00.team) && self.team == param_00.team) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(!isplayer(param_00) && !isDefined(param_00.triggerportableradarping) || !isplayer(param_00.triggerportableradarping)) {
    return;
  }

  var_04 = level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
  if(isDefined(param_02) && param_02 == "MOD_MELEE") {
    var_04 = 130;
  }

  var_05 = 0;
  if(isDefined(param_00.triggerportableradarping)) {
    param_00 = param_00.triggerportableradarping;
    var_05 = 1;
  }

  if(scripts\cp\utility::isheadshot(param_03, param_01, param_02, param_00) && !var_05 && scripts\engine\utility::isbulletdamage(param_02)) {
    var_04 = int(100);
  }

  givekillreward(param_00, var_04, "large", param_01, param_03, param_02);
}

givekillreward(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01 = param_01 * level.cash_scalar;
  if(param_00 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(param_05) && param_00 scripts\cp\utility::coop_getweaponclass(param_04) == "weapon_sniper") {
    param_01 = param_01 + 300;
    param_00 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
  }

  if(should_get_currency_from_kill(param_00)) {
    param_00 scripts\cp\cp_persistence::give_player_currency(param_01, param_02, param_03);
  }

  if(weapon_is_crafted_turret(param_04)) {
    foreach(var_07 in level.players) {
      if(var_07 == param_00) {
        continue;
      }

      if(!var_07 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var_07 scripts\cp\cp_persistence::give_player_currency(param_01, param_02, param_03);
    }
  }

  if(isDefined(level.zombie_xp)) {
    param_00 scripts\cp\cp_persistence::give_player_xp(int(param_01));
  }
}

should_get_currency_from_kill(param_00) {
  if(isplayer(param_00) && scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 0;
  }

  return 1;
}

weapon_is_crafted_turret(param_00) {
  return isDefined(param_00) && param_00 == "alien_sentry_minigun_4_mp";
}

enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level.lastenemydeathpos = self.origin;
  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
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
      return;
    }

    if(param_00.pelletdmg[var_03][param_01.guid] + 1 > 2) {
      return;
    }

    param_00.pelletdmg[var_03][param_01.guid]++;
    return;
  }
}

initial_weapon_scale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!can_scale_weapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B)) {
    return param_02;
  }

  param_02 = scale_ww_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  if(isDefined(param_04) && param_04 == "MOD_MELEE") {
    if(!is_axe_weapon(param_05)) {
      param_02 = 150;
    }

    return param_02;
  }

  return param_02;
}

is_axe_weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "iw6_cphcmelee_mp":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

scale_ww_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = scripts\cp\utility::getrawbaseweaponname(param_05);
  switch (var_0C) {
    case "shredder":
    case "headcutter":
    case "facemelter":
    case "dischord":
      param_02 = max(7500, self.maxhealth / 2);
      break;
  }

  return param_02;
}

can_scale_weapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_01.inlaststand)) {
    return 0;
  }

  if(!isDefined(param_01.pap)) {
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

eligible_for_reward(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(scripts\cp\cp_laststand::player_in_laststand(param_00))) {
    return 0;
  }

  if(!isDefined(param_01)) {
    return 0;
  }

  switch (param_01) {
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      if(param_02 == "gas_grenade_mp" || param_02 == "splash_grenade_zm") {
        if(isDefined(param_03.flame_damage_time)) {
          if(gettime() > param_03.flame_damage_time) {
            return 1;
          } else {
            return 0;
          }
        }
      }
      return 1;

    case "MOD_UNKNOWN":
      if(scripts\engine\utility::istrue(param_03.is_burning) && isDefined(param_03.flame_damage_time)) {
        if(gettime() > param_03.flame_damage_time) {
          return 1;
        }
      }
      return 0;

    default:
      break;
  }

  if(!scripts\engine\utility::istrue(param_03.is_burning)) {
    return 1;
  }

  if(!scripts\engine\utility::istrue(param_03.marked_for_death)) {
    return 1;
  }

  return 0;
}

onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  var_0D = scripts\cp\utility::is_trap(param_00);
  if((isDefined(param_01) && isDefined(param_04) && scripts\engine\utility::isbulletdamage(param_04) || scripts\cp\utility::player_has_special_ammo(param_01, "combined_ammo") && param_04 == "MOD_EXPLOSIVE_BULLET") || param_05 == "poison_ammo_mp") {
    if(isplayer(param_01) || isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      if(!var_0D) {
        param_01 check_for_special_damage(self, param_00, param_03, param_05, param_04);
      }
    }
  }

  var_0E = 10 * level.cash_scalar;
  if(isDefined(param_01)) {
    if(isDefined(param_01.perk_data) && param_01.perk_data["damagemod"].bullet_damage_scalar == 2) {
      var_0E = var_0E * 2;
    }

    if(eligible_for_reward(param_01, param_04, param_05, self)) {
      if(param_01 scripts\cp\utility::is_consumable_active("hit_reward_upgrade")) {
        param_01 scripts\cp\utility::notify_used_consumable("hit_reward_upgrade");
        var_0E = var_0E * 5;
      }

      param_01 scripts\cp\cp_persistence::give_player_currency(var_0E, "large", param_08);
    }
  }

  if(isDefined(param_08) && scripts\cp\utility::isheadshot(param_05, param_08, param_04, param_01)) {
    if(param_01 scripts\cp\utility::is_consumable_active("armor_after_headshot")) {
      var_0F = 25;
      if(isDefined(param_01.bodyarmorhp)) {
        var_0F = int(param_01.bodyarmorhp + 25);
      }

      param_01 notify("enable_armor");
    }
  }
}

check_for_special_damage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00 scripts\cp\utility::is_trap(param_01);
  var_06 = param_00 should_do_stun_damage(param_03, param_04, self);
  if(!isDefined(param_00.is_afflicted) && isalive(param_00)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "combined_ammo") || param_03 == "slayer_ammo_mp") {
      var_07 = int(param_00.maxhealth);
      param_00 thread scripts\cp\utility::damage_over_time(param_00, self, 20, var_07, param_04, "slayer_ammo_mp", undefined, "combinedArcane");
    }
  }

  if(!isDefined(param_00.is_afflicted) && !isDefined(param_00.is_burning) && isalive(param_00)) {
    if(scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || param_03 == "incendiary_ammo_mp") {
      var_07 = min(param_00.maxhealth * 0.66, 1000);
      param_00 thread scripts\cp\utility::damage_over_time(param_00, self, 5, var_07, param_04, "incendiary_ammo_mp", undefined, "burning");
    }
  }

  if(var_06 && !var_05) {
    self.stunned = 1;
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

  var_00 = getclosestentrance();
  if(!isDefined(var_00)) {
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
  var_00 = getclosestentrance();
  if(!isDefined(var_00)) {
    iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.reached_entrance_goal)) {
    if(!isDefined(self.attack_spot)) {
      var_01 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(var_00);
      if(!var_01.occupied) {
        var_01.occupied = 1;
      }

      self.attack_spot = var_01;
    }

    self.precacheleaderboards = 1;
    self ghostskulls_total_waves(32);
    self ghostskulls_complete_status(self.attack_spot.origin);
    self waittill("goal_reached");
    self.reached_entrance_goal = 1;
  }

  while(scripts\cp\zombies\zombie_entrances::entrance_has_barriers(var_00)) {
    if(!isDefined(self.attack_spot)) {
      var_01 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(var_00);
      if(!var_01.occupied) {
        var_01.occupied = 1;
      }

      self.attack_spot = var_01;
    }

    self ghostskulls_total_waves(16);
    self ghostskulls_complete_status(self.attack_spot.origin);
    self waittill("goal_reached");
    if(!isDefined(var_00.window_attack_ent)) {
      if(isDefined(var_00.attack_position)) {
        var_00.window_attack_ent = spawn("script_origin", var_00.attack_position.origin);
      } else {
        var_00.window_attack_ent = spawn("script_origin", var_00.origin + (0, 0, 20));
      }

      var_00.window_attack_ent setCanDamage(1);
      var_00.window_attack_ent.health = 100000;
      var_00.window_attack_ent.team = "allies";
    }

    if(should_attack_nearby_player()) {
      attack_nearby_player();
      continue;
    }

    break_barrier_from_entrance(var_00);
  }

  self.precacheleaderboards = 0;
  return 0;
}

should_attack_nearby_player() {
  var_00 = 100;
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
  if(!level.current_interaction_structs.size) {
    return undefined;
  }

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
  self.curmeleetarget = self.closest_player_near_interaction_point;
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  var_00 = scripts\engine\utility::waittill_any_return("attack_hit", "attack_miss");
  var_01 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);
  if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_01)) {
    scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, scripts\asm\zombie\melee::get_melee_damage_dealt(), "MOD_IMPACT");
  }
}

break_barrier_from_entrance(param_00) {
  self.curmeleetarget = param_00.window_attack_ent;
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\engine\utility::waittill_any_3("attack_hit", "attack_miss");
  scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(param_00);
  if(!scripts\cp\zombies\zombie_entrances::entrance_has_barriers(param_00)) {
    if(isDefined(param_00.window_attack_ent)) {
      param_00.window_attack_ent delete();
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

zombies_should_mutilate(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(param_04)) {
    switch (param_04) {
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_EXPLOSIVE":
        return 1;

      case "MOD_MELEE":
        if(isDefined(param_01) && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack")) {
          return 1;
        } else {
          return 0;
        }

        break;

      default:
        break;
    }
  }

  if(isDefined(param_05)) {
    var_09 = weaponclass(param_05);
    if(isDefined(var_09) && var_09 == "spread") {
      return 1;
    }

    var_0A = getweaponbasename(param_05);
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
  var_01 = scripts\mp\agents\zombie\zmb_zombie_agent::calulatezombiemovemode(param_00);
  if(level.desired_enemy_deaths_this_wave - level.current_enemy_deaths == 1) {
    if(var_01 != "sprint") {
      return "run";
    }
  }

  return var_01;
}