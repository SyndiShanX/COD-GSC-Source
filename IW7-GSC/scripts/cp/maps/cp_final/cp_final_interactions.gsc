/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_interactions.gsc
**************************************************************/

register_interactions() {
  registerdoorinteractions();
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", undefined, scripts\cp\maps\cp_final\cp_final_weapon_upgrade::weapon_upgrade_hint_func, scripts\cp\maps\cp_final\cp_final_weapon_upgrade::weapon_upgrade, 5000, 1, scripts\cp\maps\cp_final\cp_final_weapon_upgrade::init_weapon_upgrade);
  levelinteractionregistration(1, "pap_fusebox", undefined, undefined, ::blankhintfunc, ::pickupfuse, 0, 0, ::init_pap_fuses);
  register_afterlife_games();
  register_arcade_roms();
  register_pap_interactions();
  registeratminteractions();
  levelinteractionregistration(1, "fig_1", undefined, undefined, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig1);
  levelinteractionregistration(1, "fig_2", undefined, undefined, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig2);
  levelinteractionregistration(1, "fig_3", undefined, undefined, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig3);
  levelinteractionregistration(1, "fig_4", undefined, undefined, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig4);
  levelinteractionregistration(1, "emp_console", undefined, undefined, scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsolehint, scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsoleuse, 0, 0);
  scripts\cp\maps\cp_final\cp_final_fast_travel::register_portal_interactions();
  scripts\cp\maps\cp_final\cp_final_mpq::registermpqinteractions();
  scripts\cp\maps\cp_final\cp_final_venomx_quest::init_venomx_models_interactions();
  weaponinteractions();
  scripts\cp\maps\cp_final\cp_final_traps::register_traps();
  register_crafting_interactions();
  if(isDefined(level.escape_interaction_registration_func)) {
    [[level.escape_interaction_registration_func]]();
  }

  register_ritual_circle_interactions();
  foreach(var_1 in scripts\engine\utility::getstructarray("iw7_kbs_zm", "script_noteworthy")) {
    var_1.custom_search_dist = 96;
  }

  scripts\engine\utility::flag_set("interactions_initialized");
}

structhacks() {
  move_struct((3853.5, -4291.5, 93.5), (3845, -4252, 92), (326.979, 62.3168, -86.8204));
}

move_struct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_0, level.struct, 500);
  var_3.origin = var_1;
  if(isDefined(var_2)) {
    var_3.angles = var_2;
  }
}

registerdoorinteractions() {
  level.interaction_hintstrings["debris_350"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["team_door_switch"] = &"CP_TOWN_INTERACTIONS_TEAM_DOOR_SWITCH";
  level.interaction_hintstrings["power_door_sliding"] = &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  level.interaction_hintstrings["power_door_sliding"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  levelinteractionregistration(0, "debris_350", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 350, 0, undefined);
  levelinteractionregistration(0, "debris_1000", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1000, 0, undefined);
  levelinteractionregistration(0, "debris_1500", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1500, 0, undefined);
  levelinteractionregistration(0, "debris_2000", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 2000, 0, undefined);
  levelinteractionregistration(0, "debris_2500", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 2500, 0, undefined);
  levelinteractionregistration(0, "debris_1250", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1250, 0, undefined);
  levelinteractionregistration(0, "debris_750", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 750, 0, undefined);
  levelinteractionregistration(0, "team_door_switch", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::use_team_door_switch, 250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_750", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 750, 0, ::initslidingdoor);
  levelinteractionregistration(0, "facility_sliding_door_1000", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1000, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_1250", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_1500", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_2000", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 2000, 0, undefined);
  levelinteractionregistration(0, "power_door_sliding", "door_buy", undefined, undefined, undefined, 0, 1, scripts\cp\zombies\interaction_openareas::init_sliding_power_doors);
}

register_ritual_circle_interactions() {}

register_afterlife_games() {
  level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, scripts\cp\zombies\interaction_racing::race_game_hint_logic, scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, scripts\cp\zombies\interaction_racing::init_all_race_games);
}

register_arcade_roms() {
  level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_hero", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_icehock", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_seaques", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boxing", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_oink", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_keyston", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_plaque", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_crackpo", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
}

register_crafting_interactions() {
  scripts\cp\cp_interaction::register_interaction("pillage_item", undefined, undefined, scripts\cp\zombies\zombies_pillage::pillage_hint_func, scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
}

level_specific_wait_for_interaction_triggered(var_0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");
  for(;;) {
    self.interaction_trigger waittill("trigger", var_1);
    if(var_1 isinphase()) {
      continue;
    }

    if(!scripts\cp\cp_interaction::interaction_is_valid(var_0, var_1)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_0.dontdelaytrigger)) {
      var_0.triggered = 1;
      var_0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    }

    var_2 = level.interactions[var_0.script_noteworthy].cost;
    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
      level.interactions[var_0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
        continue;
      }
    } else if(var_0.script_noteworthy == "lost_and_found") {
      if(!scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var_0) {
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        var_2 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var_0)) {
      if(scripts\cp\utility::is_codxp()) {
        continue;
      }

      var_3 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
      if(scripts\engine\utility::istrue(var_1.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
          continue;
        } else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::can_upgrade(var_3, 1)) {
          if(var_4 == 1) {
            var_2 = 5000;
          } else if(var_4 == 2) {
            var_2 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
          continue;
        }
      } else if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
        var_2 = 0;
      } else if(var_4 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
        continue;
      } else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::can_upgrade(var_3)) {
        if(var_4 == 1) {
          var_2 = 5000;
        } else if(var_4 == 2) {
          var_2 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::getbaseweaponname(var_5);
      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY_AMMO_MAX");
          continue;
        } else {
          var_7 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_4 = scripts\cp\cp_weapon::get_weapon_level(var_7);
          if(var_4 > 1) {
            var_2 = 4500;
          } else {
            var_2 = var_2 * 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var_0)) {
      if(!var_1 scripts\cp\cp_interaction::can_use_perk(var_0)) {
        var_2 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased <= var_1.max_self_revive_machine_use) {
        var_2 = 500;
      } else {
        var_2 = scripts\cp\cp_interaction::get_perk_machine_cost(var_0);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var_0)) {
      if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
        if(var_1.card_refills == 2) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
          continue;
        }
      }

      if(self.card_refills >= 1) {
        var_2 = level.fortune_visit_cost_2;
      } else {
        var_2 = level.fortune_visit_cost_1;
      }

      if(isDefined(level.fnf_cost)) {
        var_2 = level.fnf_cost;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_sliding_door(var_0)) {
      if(scripts\engine\utility::istrue(var_0.player_opened)) {
        var_2 = 0;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
      if(var_0.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
      }

      continue;
    }

    if(var_0.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var_0);
    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      level notify("interaction", var_0.name, var_0, self);
    } else {
      level notify("interaction", "purchase", level.interactions[var_0.script_noteworthy], self);
    }

    var_8 = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_8);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(var_0)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(var_0.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    var_0.triggered = undefined;
  }
}

level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;
  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      wait(1);
      continue;
    }

    var_4 = undefined;
    level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
    var_5 = sortbydistance(level.current_interaction_structs, self.origin);
    foreach(var_7 in self.disabled_interactions) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    if(var_5.size == 0) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) < var_2) {
      var_4 = var_5[0];
    }

    if(!isDefined(var_4) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) <= var_0) {
      var_4 = var_5[0];
    }

    if(isDefined(var_4) && scripts\cp\cp_interaction::interaction_is_door_buy(var_4) || scripts\cp\cp_interaction::interaction_is_chi_door(var_4) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_4)) {
      var_4 = undefined;
    }

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_5[0].origin, self.origin) <= var_1) {
        var_4 = var_5[0];
      }

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_5[0].custom_search_dist)) {
      if(distance(var_5[0].origin, self.origin) <= var_5[0].custom_search_dist) {
        var_4 = var_5[0];
      }
    }

    if(!isDefined(var_4) || !scripts\engine\utility::array_contains(level.current_interaction_structs, var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_4)) {
      var_9 = scripts\cp\utility::get_closest_entrance(var_4.origin);
      if(!isDefined(var_9)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_9)) {
        scripts\cp\cp_interaction::reset_interaction();
        if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
          if(!isDefined(var_4.has_trap)) {
            thread scripts\cp\cp_interaction::flash_inventory();
          }
        }

        self.last_interaction_point = var_4;
        continue;
      } else {
        self notify("stop_interaction_logic");
        self.last_interaction_point = undefined;
      }

      if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
        if(!isDefined(var_4.has_trap)) {
          thread scripts\cp\cp_interaction::flash_inventory();
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_perk(var_4) && self getstance() == "prone") {
      self.last_interaction_point = undefined;
      wait(0.05);
      continue;
    }

    if(!isDefined(self.last_interaction_point)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    } else if(self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_4) && !scripts\engine\utility::istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4, 0);
    } else if(self.last_interaction_point != var_4) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    }

    wait(0.05);
  }
}

weaponinteractions() {
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_0, 2);
    if(!issubstr(var_2, "wall")) {
      var_0++;
      continue;
    }

    var_3 = int(tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_0, 4));
    var_4 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_0, 1);
    level.interaction_hintstrings[var_4] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
    levelinteractionregistration(0, var_4, "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_3);
    var_0++;
  }
}

registeratminteractions() {
  level.interaction_hintstrings["atm_deposit"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = &"CP_TOWN_INTERACTIONS_ATM_WITHDRAWAL";
  levelinteractionregistration(0, "atm_deposit", "atm", undefined, scripts\cp\cp_interaction::atm_deposit_hint, ::atm_deposit, 1000, 0, undefined);
  levelinteractionregistration(0, "atm_withdrawal", "atm", undefined, ::atm_withdrawal_hint, ::atm_withdrawal, 0, 0, ::setup_atm_system);
}

levelinteractionregistration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = spawnStruct();
  var_0A.name = var_1;
  var_0A.hint_func = var_4;
  var_0A.spend_type = var_2;
  var_0A.tutorial = var_3;
  var_0A.activation_func = var_5;
  var_0A.enabled = 1;
  var_0A.disable_guided_interactions = var_0;
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_0A.cost = var_6;
  if(isDefined(var_7)) {
    var_0A.requires_power = var_7;
  } else {
    var_0A.requires_power = 0;
  }

  var_0A.init_func = var_8;
  var_0A.can_use_override_func = var_9;
  level.interactions[var_1] = var_0A;
}

blankusefunc(var_0, var_1) {}

blankhintfunc(var_0, var_1) {
  return "";
}

use_ritual_site(var_0, var_1) {}

setup_atm_system() {
  level.atm_transaction_amount = 1000;
  level.atm_amount_deposited = 0;
  var_0 = scripts\engine\utility::array_combine(scripts\engine\utility::getstructarray("atm_deposit", "script_noteworthy"), scripts\engine\utility::getstructarray("atm_withdrawal", "script_noteworthy"));
  foreach(var_2 in var_0) {
    var_2.requires_power = 0;
    var_2.powered_on = 1;
  }
}

atm_deposit(var_0, var_1) {
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(var_1, 1000);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  if(scripts\cp\cp_interaction::exceed_deposit_limit(var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }
}

atm_withdrawal(var_0, var_1) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  var_2 = 1000;
  var_1 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, undefined, "atm");
  level.atm_amount_deposited = level.atm_amount_deposited - var_2;
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low");
  var_1 scripts\cp\cp_interaction::refresh_interaction();
}

atm_withdrawal_hint(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    return &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_TOWN_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

register_pap_interactions() {
  scripts\cp\cp_interaction::register_interaction("pap_portal", "fast_travel", undefined, ::pap_portal_hint, scripts\cp\maps\cp_final\cp_final_fast_travel::run_fast_travel_logic, 0, 1, ::init_pap_portal);
  levelinteractionregistration(1, "brute_interaction", undefined, undefined, ::blankhintfunc, ::use_brute_func, 0, 1, ::init_brute_func);
  levelinteractionregistration(1, "sasquatch_interaction", undefined, undefined, ::blankhintfunc, ::use_sasquatch_func, 0, 1, ::init_sasquatch_func);
  levelinteractionregistration(1, "reel_change", undefined, undefined, ::blankhintfunc, ::change_reel_func, 0, 1, ::init_reel_change_func);
  levelinteractionregistration(1, "zis_reel", undefined, undefined, ::blankhintfunc, ::pickup_zis_reel, 0, 1, ::init_zis_reel);
  levelinteractionregistration(1, "construct_bridge", undefined, undefined, scripts\cp\maps\cp_final\cp_final_mpq::constructbridgehint, scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeuse, 0, 1, scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeinit);
}

init_pap_fuses() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("opened_fusebox");
  scripts\engine\utility::flag_init("picked_up_uncharged_fuses");
  scripts\engine\utility::flag_init("fuses_charged");
  level thread watch_for_open_fusebox();
}

watch_for_open_fusebox() {
  var_0 = getent("fuse_box_damage_trigger", "targetname");
  for(;;) {
    if(isDefined(var_0)) {
      var_0 waittill("damage", var_1, var_2);
      if(!isDefined(var_2)) {
        continue;
      }

      var_3 = getent("fuse_box_door_moveable", "script_noteworthy");
      var_4 = scripts\engine\utility::getstruct("fuse_box_door_open", "script_noteworthy");
      var_3 rotateto(var_4.angles, 0.3);
      scripts\engine\utility::flag_set("opened_fusebox");
      playsoundatpos(var_3.origin, "zmb_pap_fuse_box_open");
      var_0 delete();
      break;
    } else {
      level waittill("forever");
    }
  }
}

pickupfuse(var_0, var_1) {
  if(!scripts\engine\utility::flag("opened_fusebox")) {
    return;
  }

  var_2 = getEntArray("pap_fuses", "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 2);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_fuse_uncharged", "zmb_comment_vo");
  scripts\engine\utility::flag_set("picked_up_uncharged_fuses");
  generic_pickup_gesture_and_fx(var_1, var_3[0].origin);
  foreach(var_5 in level.players) {
    var_5 setclientomnvar("zm_special_item", 5);
  }

  foreach(var_8 in var_3) {
    var_8 delete();
  }

  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

init_pap_portal() {
  scripts\engine\utility::flag_init("disable_portals");
  scripts\engine\utility::flag_init("fuses_inserted");
  var_0 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  var_0.end_positions = scripts\engine\utility::getstructarray(var_0.target, "targetname");
}

pap_portal_hint(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals") || !var_1 scripts\cp\utility::isteleportenabled()) {
    return "";
  }

  if(isDefined(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  return &"CP_FINAL_ENTER_PAP_PORTAL";
}

init_brute_func() {
  scripts\engine\utility::flag_init("pulled_out_helmet");
  scripts\engine\utility::flag_init("obtained_brute_helmet");
  scripts\engine\utility::flag_init("placed_brute_helmet");
}

init_sasquatch_func() {
  scripts\engine\utility::flag_init("placed_uncharged_fuses");
  scripts\engine\utility::flag_init("picked_up_charged_fuses");
}

use_sasquatch_func(var_0, var_1) {
  if(scripts\engine\utility::flag("fuses_charged") && !scripts\engine\utility::flag("picked_up_charged_fuses")) {
    scripts\engine\utility::flag_set("picked_up_charged_fuses");
    var_2 = getent("fuses_to_power", "targetname");
    generic_pickup_gesture_and_fx(var_1, var_2.origin);
    foreach(var_4 in level.players) {
      var_4 setclientomnvar("zm_special_item", 1);
    }

    var_2 delete();
    level.has_picked_up_fuses = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }

  if(scripts\engine\utility::flag("picked_up_uncharged_fuses") && !scripts\engine\utility::flag("placed_uncharged_fuses")) {
    foreach(var_4 in level.players) {
      var_4 setclientomnvar("zm_special_item", 0);
    }

    scripts\engine\utility::flag_set("placed_uncharged_fuses");
    var_8 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_9 = var_8.origin;
    generic_place_gesture_and_fx(var_1, var_9);
    var_0A = spawn("script_model", var_9);
    var_0A.var_336 = "fuses_to_power";
    var_0A.angles = var_8.angles;
    var_0A setModel("cp_final_alien_fuse_combined");
    level.fuse_in_hand = var_0A;
    check_for_charge_fuse_sequence(var_0, var_1);
  }
}

use_brute_func(var_0, var_1) {
  if(scripts\engine\utility::flag("obtained_brute_helmet") && !scripts\engine\utility::flag("placed_brute_helmet")) {
    scripts\engine\utility::flag_set("placed_brute_helmet");
    var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    generic_place_gesture_and_fx(var_1, var_2);
    level.helmet_on_brute.origin = var_2.origin;
    level.helmet_on_brute.angles = var_2.angles;
    level.helmet_on_brute notify("end_entangler_funcs");
    level.helmet_on_brute show();
    scripts\cp\utility::set_quest_icon(1);
    check_for_charge_fuse_sequence(var_0, var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  }
}

check_for_charge_fuse_sequence(var_0, var_1) {
  if(scripts\engine\utility::flag("placed_brute_helmet") && scripts\engine\utility::flag("placed_uncharged_fuses")) {
    var_2 = scripts\engine\utility::getstruct("helmet_shoot_point", "targetname");
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("tag_origin");
    thread playfusechargesounds(var_2, var_3);
    level thread playpapupgradevo(var_1);
    var_4 = playfxontagsbetweenclients(scripts\engine\utility::getfx("vfx_charge_fuse_beam"), var_3, "tag_origin", level.fuse_in_hand, "tag_origin");
    level thread charging_sequence_rumble(var_0);
    level thread changetochargedfuses();
    var_5 = getent("fuse_laser_trigger", "script_noteworthy");
    var_5 thread scripts\cp\maps\cp_final\cp_final_traps::damage_enemies_in_trigger(var_3, level.fuse_in_hand, var_5, 1);
    wait(6);
    var_4 delete();
    var_3 delete();
    var_5 notify("death");
    level notify("stop_charging_fuse");
    scripts\engine\utility::flag_set("fuses_charged");
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_fuse_charged", "zmb_comment_vo");
  }
}

changetochargedfuses() {
  level endon("game_ended");
  wait(0.1);
  level.fuse_in_hand setModel("cp_final_alien_fuse_combined_on");
  level.fuse_effect = playFXOnTag(level._effect["fuse_charged"], level.fuse_in_hand, "tag_origin");
}

playpapupgradevo(var_0) {
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        if(!isDefined(level.completed_dialogues["conv_pap_upgrade_sally_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_upgrade_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_upgrade_sally_1_1"] = 1;
        }
        break;

      case "p2_":
        if(!isDefined(level.completed_dialogues["conv_pap_upgrade_pdex_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_upgrade_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_upgrade_pdex_1_1"] = 1;
        }
        break;

      case "p3_":
        if(!isDefined(level.completed_dialogues["conv_pap_upgrade_andre_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_upgrade_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_upgrade_andre_1_1"] = 1;
        }
        break;

      case "p4_":
        if(!isDefined(level.completed_dialogues["conv_pap_upgrade_aj_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_upgrade_aj_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_upgrade_aj_1_1"] = 1;
        }
        break;
    }
  }
}

playfusechargesounds(var_0, var_1) {
  level endon("game_ended");
  playsoundatpos(var_0.origin, "zmb_pap_brute_laser_start");
  wait(0.25);
  var_1 playLoopSound("zmb_pap_brute_laser_lp");
  wait(4.8);
  var_1 stoploopsound();
  playsoundatpos(var_0.origin, "zmb_pap_brute_laser_end");
}

charging_sequence_rumble(var_0) {
  level endon("stop_charging_fuse");
  for(;;) {
    wait(0.15);
    earthquake(0.18, 1, var_0.origin, 784);
    wait(0.05);
    playrumbleonposition("artillery_rumble", var_0.origin);
  }
}

init_reel_change_func() {
  scripts\engine\utility::flag_init("set_movie_spaceland");
}

change_reel_func(var_0, var_1) {
  if(scripts\engine\utility::flag("has_film_reel")) {
    playsoundatpos(var_0.origin, "zmb_pap_film_reel_placement");
    scripts\engine\utility::flag_set("set_movie_spaceland");
    generic_place_gesture_and_fx(var_1, var_0.origin + (-3, 0, 75));
    level.movie_playing = "cp_zmb_screen_640";
    playcinematicforalllooping(level.movie_playing);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  }
}

init_zis_reel() {
  scripts\engine\utility::flag_init("has_film_reel");
}

pickup_zis_reel(var_0, var_1) {
  scripts\engine\utility::flag_set("has_film_reel");
  scripts\cp\utility::set_quest_icon(3);
  var_2 = getent(var_0.target, "targetname");
  generic_pickup_gesture_and_fx(var_1, var_2.origin);
  var_2 hide();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

initslidingdoor() {
  var_0 = scripts\engine\utility::getstructarray("facility_sliding_door_750", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray("facility_sliding_door_1000", "script_noteworthy");
  var_2 = scripts\engine\utility::getstructarray("facility_sliding_door_1250", "script_noteworthy");
  var_3 = scripts\engine\utility::getstructarray("facility_sliding_door_1500", "script_noteworthy");
  var_4 = scripts\engine\utility::getstructarray("facility_sliding_door_2000", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_0 = scripts\engine\utility::array_combine(var_0, var_2, var_3, var_4);
  var_0 = scripts\engine\utility::array_remove_duplicates(var_0);
  level.allslidingdoors = var_0;
  foreach(var_6 in var_0) {
    var_6.var_4284 = 1;
    var_6.power_area = scripts\cp\cp_interaction::get_area_for_power(var_6);
    var_6.doors = [];
    var_7 = getEntArray(var_6.target, "targetname");
    foreach(var_9 in var_7) {
      if(isDefined(var_9.classname) && var_9.classname == "script_brushmodel") {
        continue;
      }

      if(!isDefined(var_9.script_noteworthy)) {}

      var_9.ogorigin = var_9.origin;
      var_6.doors[var_6.doors.size] = var_9;
    }
  }
}

slidingdoorhint(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.requires_power)) {
    return &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  }

  if(scripts\engine\utility::istrue(var_0.player_opened)) {
    var_1.interaction_trigger sethintstringparams(level.enter_area_hint);
    return &"CP_FINAL_INTERACTIONS_OPEN_AREA";
  }

  var_2 = int(level.interactions[var_0.script_noteworthy].cost);
  var_1.interaction_trigger sethintstringparams(level.enter_area_hint, var_2);
  return &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
}

openslidingdoor(var_0, var_1) {
  level endon("game_ended");
  if(scripts\engine\utility::istrue(var_0.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", var_0.power_area + " power_on");
    var_0.powered_on = 1;
  }

  var_2 = [];
  foreach(var_4 in level.allslidingdoors) {
    if(var_4.target == var_0.target) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_2) {
    var_4.opened = 1;
    var_4.var_4284 = 0;
  }

  while(scripts\engine\utility::istrue(var_0.var_42AF)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_4 in var_2) {
    var_4.var_C62C = 1;
  }

  if(isDefined(var_1) && isplayer(var_1)) {
    if(!scripts\engine\utility::istrue(var_0.player_opened)) {
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        var_1 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      }

      var_1 notify("door_opened_notify");
      scripts\cp\cp_persistence::increment_player_career_doors_opened(var_1);
      level notify("door_opened_notify");
      foreach(var_4 in var_2) {
        if(var_4.target == var_0.target) {
          var_4.player_opened = 1;
        }
      }
    }
  }

  var_0C = getEntArray(var_0.target, "targetname");
  foreach(var_0E in var_0C) {
    if(isDefined(var_0E.classname) && var_0E.classname == "script_brushmodel") {
      continue;
    }

    var_0E setscriptablepartstate("door", "open");
  }

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target) {
      scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_4);
    }
  }

  wait(0.4);
  foreach(var_0E in var_0C) {
    if(isDefined(var_0E.classname) && var_0E.classname == "script_brushmodel") {
      var_0E connectpaths();
      var_0E notsolid();
    }
  }

  wait(1.1);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_0);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  foreach(var_4 in var_2) {
    var_4.var_C62C = undefined;
  }
}

closeslidingdoor(var_0, var_1) {
  level endon("game_ended");
  var_2 = [];
  foreach(var_4 in level.allslidingdoors) {
    if(var_4.target == var_0.target) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = undefined;
  foreach(var_4 in var_2) {
    if(var_4 != var_0 && var_4.target == var_0.target) {
      var_6 = var_4;
    }

    var_4.opened = undefined;
    var_4.var_4284 = 1;
  }

  while(scripts\engine\utility::istrue(var_0.var_C62C)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_4 in var_2) {
    var_4.var_42AF = 1;
  }

  var_0B = getEntArray(var_0.target, "targetname");
  foreach(var_0D in var_0B) {
    if(isDefined(var_0D.classname) && var_0D.classname == "script_brushmodel") {
      if(scripts\engine\utility::istrue(var_0.player_opened)) {
        var_0D connectpaths();
      } else {
        var_0D disconnectpaths();
      }

      var_0D solid();
      continue;
    }

    var_0D setscriptablepartstate("door", "close");
  }

  wait(0.3);
  if(isDefined(var_6)) {
    var_0F = vectornormalize(var_6.origin - var_0.origin);
    var_10 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.characters, undefined, undefined, 40, 0);
    var_11 = var_0.doors[0].origin;
    foreach(var_13 in var_10) {
      if(vectordot(vectornormalize(var_6.origin - var_0.origin), var_0F) > 0.75) {
        if(distance(var_0.origin, var_6.origin) > distance(var_13.origin, var_0.origin)) {
          if(distance(var_11, var_13.origin) <= 16) {
            var_14 = scripts\engine\utility::getclosest(var_13.origin, [var_6, var_0]);
            if(isplayer(var_13)) {
              if(!var_13 scripts\cp\utility::is_valid_player()) {
                var_13 setvelocity(var_14.origin);
                continue;
              }
            } else if(var_13 scripts\cp\utility::agentisinstakillimmune()) {
              continue;
            } else {
              var_13.died_poorly = 1;
              var_13.died_poorly_health = var_13.health;
            }

            var_13 setvelocity(var_14.origin);
            var_13 dodamage(var_13.maxhealth, var_6.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_zombieDoors_zm");
          }
        }
      }
    }
  }

  if(!scripts\engine\utility::istrue(var_0.nointeraction)) {
    scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  }

  wait(0.45);
  foreach(var_4 in var_2) {
    var_4.var_42AF = undefined;
  }
}

helmet_useable() {
  self makeusable();
  self sethintstring(&"CP_FINAL_INTERACTIONS_PICKUP_BRUTE_HELMET");
}

helmet_not_useable() {
  self physicsstopserver();
  self makeunusable();
}

pickup_helmet() {
  helmet_useable();
  for(;;) {
    self waittill("trigger", var_0);
    if(!isDefined(var_0.kicked_out)) {
      scripts\engine\utility::flag_set("obtained_brute_helmet");
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_helmet", "zmb_comment_vo");
      scripts\cp\utility::set_quest_icon(1);
      generic_pickup_gesture_and_fx(var_0, self.origin);
      helmet_not_useable();
      self hide();
    }
  }
}

generic_pickup_gesture_and_fx(var_0, var_1) {
  var_0 endon("disconnect");
  if(isent(var_1) || !isvector(var_1)) {
    var_1 = var_1.origin;
  }

  var_0 thread scripts\cp\utility::usegrenadegesture(var_0, "iw7_swipegrab_zm");
  wait(0.28);
  playFX(level._effect["generic_pickup"], var_1);
  var_0 playlocalsound("part_pickup");
}

generic_place_gesture_and_fx(var_0, var_1) {
  var_0 endon("disconnect");
  if(isent(var_1) || !isvector(var_1)) {
    var_1 = var_1.origin;
  }

  var_0 thread scripts\cp\utility::usegrenadegesture(var_0, "iw7_placethrow_zm");
  wait(0.35);
  playFX(level._effect["generic_pickup"], var_1);
  var_0 playlocalsound("part_pickup");
}