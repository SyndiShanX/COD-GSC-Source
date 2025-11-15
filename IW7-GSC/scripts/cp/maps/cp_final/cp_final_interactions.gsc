/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_interactions.gsc
**************************************************************/

register_interactions() {
  registerdoorinteractions();
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", undefined, ::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::weapon_upgrade_hint_func, ::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::weapon_upgrade, 5000, 1, ::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::init_weapon_upgrade);
  levelinteractionregistration(1, "pap_fusebox", undefined, undefined, ::blankhintfunc, ::pickupfuse, 0, 0, ::init_pap_fuses);
  register_afterlife_games();
  register_arcade_roms();
  register_pap_interactions();
  registeratminteractions();
  levelinteractionregistration(1, "fig_1", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig1);
  levelinteractionregistration(1, "fig_2", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig2);
  levelinteractionregistration(1, "fig_3", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig3);
  levelinteractionregistration(1, "fig_4", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func, 0, 0, ::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig4);
  levelinteractionregistration(1, "emp_console", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsolehint, ::scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsoleuse, 0, 0);
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
  foreach(var_01 in scripts\engine\utility::getstructarray("iw7_kbs_zm", "script_noteworthy")) {
    var_01.custom_search_dist = 96;
  }

  scripts\engine\utility::flag_set("interactions_initialized");
}

structhacks() {
  move_struct((3853.5, -4291.5, 93.5), (3845, -4252, 92), (326.979, 62.3168, -86.8204));
}

move_struct(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getclosest(param_00, level.struct, 500);
  var_03.origin = param_01;
  if(isDefined(param_02)) {
    var_03.angles = param_02;
  }
}

registerdoorinteractions() {
  level.interaction_hintstrings["debris_350"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["team_door_switch"] = & "CP_TOWN_INTERACTIONS_TEAM_DOOR_SWITCH";
  level.interaction_hintstrings["power_door_sliding"] = & "CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  level.interaction_hintstrings["power_door_sliding"] = & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  levelinteractionregistration(0, "debris_350", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 350, 0, undefined);
  levelinteractionregistration(0, "debris_1000", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1000, 0, undefined);
  levelinteractionregistration(0, "debris_1500", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1500, 0, undefined);
  levelinteractionregistration(0, "debris_2000", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2000, 0, undefined);
  levelinteractionregistration(0, "debris_2500", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2500, 0, undefined);
  levelinteractionregistration(0, "debris_1250", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1250, 0, undefined);
  levelinteractionregistration(0, "debris_750", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 750, 0, undefined);
  levelinteractionregistration(0, "team_door_switch", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::use_team_door_switch, 250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_750", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 750, 0, ::initslidingdoor);
  levelinteractionregistration(0, "facility_sliding_door_1000", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1000, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_1250", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_1500", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 1250, 0, undefined);
  levelinteractionregistration(0, "facility_sliding_door_2000", "door_buy", undefined, ::slidingdoorhint, ::openslidingdoor, 2000, 0, undefined);
  levelinteractionregistration(0, "power_door_sliding", "door_buy", undefined, undefined, undefined, 0, 1, ::scripts\cp\zombies\interaction_openareas::init_sliding_power_doors);
}

register_ritual_circle_interactions() {}

register_afterlife_games() {
  level.interaction_hintstrings["basketball_game_afterlife"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = & "COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, ::scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, ::scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, ::scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, ::scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, ::scripts\cp\zombies\interaction_racing::race_game_hint_logic, ::scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, ::scripts\cp\zombies\interaction_racing::init_all_race_games);
}

register_arcade_roms() {
  level.interaction_hintstrings["arcade_hero"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_icehock"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_seaques"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boxing"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_oink"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_keyston"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_plaque"] = & "COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_crackpo"] = & "COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_hero", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_icehock", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_seaques", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boxing", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_oink", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_keyston", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_plaque", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_crackpo", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
}

register_crafting_interactions() {
  scripts\cp\cp_interaction::register_interaction("pillage_item", undefined, undefined, ::scripts\cp\zombies\zombies_pillage::pillage_hint_func, ::scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
}

level_specific_wait_for_interaction_triggered(param_00) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");
  for(;;) {
    self.interaction_trigger waittill("trigger", var_01);
    if(var_01 isinphase()) {
      continue;
    }

    if(!scripts\cp\cp_interaction::interaction_is_valid(param_00, var_01)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(param_00.dontdelaytrigger)) {
      param_00.triggered = 1;
      param_00 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    }

    var_02 = level.interactions[param_00.script_noteworthy].cost;
    if(!isDefined(level.interactions[param_00.script_noteworthy].spend_type)) {
      level.interactions[param_00.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[param_00.script_noteworthy].can_use_override_func)) {
      if(![
          [level.interactions[param_00.script_noteworthy].can_use_override_func]
        ](param_00, var_01)) {
        continue;
      }
    } else if(param_00.script_noteworthy == "lost_and_found") {
      if(!scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != param_00) {
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        var_02 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(param_00)) {
      if(scripts\cp\utility::is_codxp()) {
        continue;
      }

      var_03 = var_01 getcurrentweapon();
      level.prevweapon = var_01 getcurrentweapon();
      var_04 = scripts\cp\cp_weapon::get_weapon_level(var_03);
      if(scripts\engine\utility::istrue(var_01.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_04 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_UPGRADE_MAXED");
          continue;
        } else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::can_upgrade(var_03, 1)) {
          if(var_04 == 1) {
            var_02 = 5000;
          } else if(var_04 == 2) {
            var_02 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
          continue;
        }
      } else if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
        var_02 = 0;
      } else if(var_04 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_UPGRADE_MAXED");
        continue;
      } else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::can_upgrade(var_03)) {
        if(var_04 == 1) {
          var_02 = 5000;
        } else if(var_04 == 2) {
          var_02 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(param_00)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        continue;
      }

      var_05 = var_01 getcurrentweapon();
      var_06 = scripts\cp\utility::getbaseweaponname(var_05);
      if(scripts\cp\cp_weapon::has_weapon_variation(param_00.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(param_00.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_GAME_PLAY_AMMO_MAX");
          continue;
        } else {
          var_07 = scripts\cp\utility::getrawbaseweaponname(param_00.script_noteworthy);
          var_04 = scripts\cp\cp_weapon::get_weapon_level(var_07);
          if(var_04 > 1) {
            var_02 = 4500;
          } else {
            var_02 = var_02 * 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(param_00)) {
      if(!var_01 scripts\cp\cp_interaction::can_use_perk(param_00)) {
        var_02 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && param_00.perk_type == "perk_machine_revive" && var_01.self_revives_purchased <= var_01.max_self_revive_machine_use) {
        var_02 = 500;
      } else {
        var_02 = scripts\cp\cp_interaction::get_perk_machine_cost(param_00);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(param_00)) {
      if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
        if(var_01.card_refills == 2) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
          continue;
        }
      }

      if(self.card_refills >= 1) {
        var_02 = level.fortune_visit_cost_2;
      } else {
        var_02 = level.fortune_visit_cost_1;
      }

      if(isDefined(level.fnf_cost)) {
        var_02 = level.fnf_cost;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_sliding_door(param_00)) {
      if(scripts\engine\utility::istrue(param_00.player_opened)) {
        var_02 = 0;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(param_00, var_02, level.interactions[param_00.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[param_00.script_noteworthy], self);
      if(param_00.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "CP_ZMB_INTERACTIONS_NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(param_00) && param_00.perk_type == "perk_machine_revive" && var_01.self_revives_purchased >= var_01.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_NEED_MONEY");
      }

      continue;
    }

    if(param_00.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_NEED_MONEY");
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(param_00);
    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(param_00)) {
      level notify("interaction", param_00.name, param_00, self);
    } else {
      level notify("interaction", "purchase", level.interactions[param_00.script_noteworthy], self);
    }

    var_08 = level.interactions[param_00.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_02, var_08);
    level thread[[level.interactions[param_00.script_noteworthy].activation_func]](param_00, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(param_00)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(param_00.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(param_00);
    param_00.triggered = undefined;
  }
}

level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_00 = 5184;
  var_01 = 9216;
  var_02 = 2304;
  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      wait(1);
      continue;
    }

    var_04 = undefined;
    level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
    var_05 = sortbydistance(level.current_interaction_structs, self.origin);
    foreach(var_07 in self.disabled_interactions) {
      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
    }

    if(var_05.size == 0) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_05[0]) && distancesquared(var_05[0].origin, self.origin) < var_02) {
      var_04 = var_05[0];
    }

    if(!isDefined(var_04) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_05[0]) && distancesquared(var_05[0].origin, self.origin) <= var_00) {
      var_04 = var_05[0];
    }

    if(isDefined(var_04) && scripts\cp\cp_interaction::interaction_is_door_buy(var_04) || scripts\cp\cp_interaction::interaction_is_chi_door(var_04) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_04)) {
      var_04 = undefined;
    }

    if(!isDefined(var_04) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_05[0].origin, self.origin) <= var_01) {
        var_04 = var_05[0];
      }

      if(isDefined(var_04) && ![
          [level.should_allow_far_search_dist_func]
        ](var_04)) {
        var_04 = undefined;
      }
    } else if(!isDefined(var_04) && isDefined(var_05[0].custom_search_dist)) {
      if(distance(var_05[0].origin, self.origin) <= var_05[0].custom_search_dist) {
        var_04 = var_05[0];
      }
    }

    if(!isDefined(var_04) || !scripts\engine\utility::array_contains(level.current_interaction_structs, var_04)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_04)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_04)) {
      var_09 = scripts\cp\utility::get_closest_entrance(var_04.origin);
      if(!isDefined(var_09)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_09)) {
        scripts\cp\cp_interaction::reset_interaction();
        if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
          if(!isDefined(var_04.has_trap)) {
            thread scripts\cp\cp_interaction::flash_inventory();
          }
        }

        self.last_interaction_point = var_04;
        continue;
      } else {
        self notify("stop_interaction_logic");
        self.last_interaction_point = undefined;
      }

      if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
        if(!isDefined(var_04.has_trap)) {
          thread scripts\cp\cp_interaction::flash_inventory();
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_perk(var_04) && self getstance() == "prone") {
      self.last_interaction_point = undefined;
      wait(0.05);
      continue;
    }

    if(!isDefined(self.last_interaction_point)) {
      scripts\cp\cp_interaction::set_interaction_point(var_04);
    } else if(self.last_interaction_point == var_04 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_04) && !scripts\engine\utility::istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_04, 0);
    } else if(self.last_interaction_point != var_04) {
      scripts\cp\cp_interaction::set_interaction_point(var_04);
    }

    wait(0.05);
  }
}

weaponinteractions() {
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    var_02 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_00, 2);
    if(!issubstr(var_02, "wall")) {
      var_00++;
      continue;
    }

    var_03 = int(tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_00, 4));
    var_04 = tablelookupbyrow("cp\zombies\cp_final_weapontable.csv", var_00, 1);
    level.interaction_hintstrings[var_04] = & "CP_TOWN_INTERACTIONS_BUY_WEAPON";
    levelinteractionregistration(0, var_04, "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_03);
    var_00++;
  }
}

registeratminteractions() {
  level.interaction_hintstrings["atm_deposit"] = & "CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = & "CP_TOWN_INTERACTIONS_ATM_WITHDRAWAL";
  levelinteractionregistration(0, "atm_deposit", "atm", undefined, ::scripts\cp\cp_interaction::atm_deposit_hint, ::atm_deposit, 1000, 0, undefined);
  levelinteractionregistration(0, "atm_withdrawal", "atm", undefined, ::atm_withdrawal_hint, ::atm_withdrawal, 0, 0, ::setup_atm_system);
}

levelinteractionregistration(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = spawnStruct();
  var_0A.name = param_01;
  var_0A.hint_func = param_04;
  var_0A.spend_type = param_02;
  var_0A.tutorial = param_03;
  var_0A.activation_func = param_05;
  var_0A.enabled = 1;
  var_0A.disable_guided_interactions = param_00;
  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  var_0A.cost = param_06;
  if(isDefined(param_07)) {
    var_0A.requires_power = param_07;
  } else {
    var_0A.requires_power = 0;
  }

  var_0A.init_func = param_08;
  var_0A.can_use_override_func = param_09;
  level.interactions[param_01] = var_0A;
}

blankusefunc(param_00, param_01) {}

blankhintfunc(param_00, param_01) {
  return "";
}

use_ritual_site(param_00, param_01) {}

setup_atm_system() {
  level.atm_transaction_amount = 1000;
  level.atm_amount_deposited = 0;
  var_00 = scripts\engine\utility::array_combine(scripts\engine\utility::getstructarray("atm_deposit", "script_noteworthy"), scripts\engine\utility::getstructarray("atm_withdrawal", "script_noteworthy"));
  foreach(var_02 in var_00) {
    var_02.requires_power = 0;
    var_02.powered_on = 1;
  }
}

atm_deposit(param_00, param_01) {
  param_01 notify("stop_interaction_logic");
  param_01.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(param_01, 1000);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, param_01);
  param_01 scripts\cp\cp_interaction::refresh_interaction();
  if(scripts\cp\cp_interaction::exceed_deposit_limit(param_01)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  }
}

atm_withdrawal(param_00, param_01) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  var_02 = 1000;
  param_01 scripts\cp\cp_persistence::give_player_currency(var_02, undefined, undefined, undefined, "atm");
  level.atm_amount_deposited = level.atm_amount_deposited - var_02;
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, param_01);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low");
  param_01 scripts\cp\cp_interaction::refresh_interaction();
}

atm_withdrawal_hint(param_00, param_01) {
  if(param_00.requires_power && !param_00.powered_on) {
    return & "CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return & "CP_TOWN_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

register_pap_interactions() {
  scripts\cp\cp_interaction::register_interaction("pap_portal", "fast_travel", undefined, ::pap_portal_hint, ::scripts\cp\maps\cp_final\cp_final_fast_travel::run_fast_travel_logic, 0, 1, ::init_pap_portal);
  levelinteractionregistration(1, "brute_interaction", undefined, undefined, ::blankhintfunc, ::use_brute_func, 0, 1, ::init_brute_func);
  levelinteractionregistration(1, "sasquatch_interaction", undefined, undefined, ::blankhintfunc, ::use_sasquatch_func, 0, 1, ::init_sasquatch_func);
  levelinteractionregistration(1, "reel_change", undefined, undefined, ::blankhintfunc, ::change_reel_func, 0, 1, ::init_reel_change_func);
  levelinteractionregistration(1, "zis_reel", undefined, undefined, ::blankhintfunc, ::pickup_zis_reel, 0, 1, ::init_zis_reel);
  levelinteractionregistration(1, "construct_bridge", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgehint, ::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeuse, 0, 1, ::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeinit);
}

init_pap_fuses() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("opened_fusebox");
  scripts\engine\utility::flag_init("picked_up_uncharged_fuses");
  scripts\engine\utility::flag_init("fuses_charged");
  level thread watch_for_open_fusebox();
}

watch_for_open_fusebox() {
  var_00 = getent("fuse_box_damage_trigger", "targetname");
  for(;;) {
    if(isDefined(var_00)) {
      var_00 waittill("damage", var_01, var_02);
      if(!isDefined(var_02)) {
        continue;
      }

      var_03 = getent("fuse_box_door_moveable", "script_noteworthy");
      var_04 = scripts\engine\utility::getstruct("fuse_box_door_open", "script_noteworthy");
      var_03 rotateto(var_04.angles, 0.3);
      scripts\engine\utility::flag_set("opened_fusebox");
      playsoundatpos(var_03.origin, "zmb_pap_fuse_box_open");
      var_00 delete();
      break;
    } else {
      level waittill("forever");
    }
  }
}

pickupfuse(param_00, param_01) {
  if(!scripts\engine\utility::flag("opened_fusebox")) {
    return;
  }

  var_02 = getEntArray("pap_fuses", "targetname");
  var_03 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_02, undefined, 2);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_fuse_uncharged", "zmb_comment_vo");
  scripts\engine\utility::flag_set("picked_up_uncharged_fuses");
  generic_pickup_gesture_and_fx(param_01, var_03[0].origin);
  foreach(var_05 in level.players) {
    var_05 setclientomnvar("zm_special_item", 5);
  }

  foreach(var_08 in var_03) {
    var_08 delete();
  }

  param_00 scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
}

init_pap_portal() {
  scripts\engine\utility::flag_init("disable_portals");
  scripts\engine\utility::flag_init("fuses_inserted");
  var_00 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  var_00.end_positions = scripts\engine\utility::getstructarray(var_00.target, "targetname");
}

pap_portal_hint(param_00, param_01) {
  if(scripts\engine\utility::flag("disable_portals") || !param_01 scripts\cp\utility::isteleportenabled()) {
    return "";
  }

  if(isDefined(param_00.cooling_down)) {
    return & "COOP_INTERACTIONS_COOLDOWN";
  }

  return & "CP_FINAL_ENTER_PAP_PORTAL";
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

use_sasquatch_func(param_00, param_01) {
  if(scripts\engine\utility::flag("fuses_charged") && !scripts\engine\utility::flag("picked_up_charged_fuses")) {
    scripts\engine\utility::flag_set("picked_up_charged_fuses");
    var_02 = getent("fuses_to_power", "targetname");
    generic_pickup_gesture_and_fx(param_01, var_02.origin);
    foreach(var_04 in level.players) {
      var_04 setclientomnvar("zm_special_item", 1);
    }

    var_02 delete();
    level.has_picked_up_fuses = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    return;
  }

  if(scripts\engine\utility::flag("picked_up_uncharged_fuses") && !scripts\engine\utility::flag("placed_uncharged_fuses")) {
    foreach(var_04 in level.players) {
      var_04 setclientomnvar("zm_special_item", 0);
    }

    scripts\engine\utility::flag_set("placed_uncharged_fuses");
    var_08 = scripts\engine\utility::getstruct(param_00.target, "targetname");
    var_09 = var_08.origin;
    generic_place_gesture_and_fx(param_01, var_09);
    var_0A = spawn("script_model", var_09);
    var_0A.var_336 = "fuses_to_power";
    var_0A.angles = var_08.angles;
    var_0A setModel("cp_final_alien_fuse_combined");
    level.fuse_in_hand = var_0A;
    check_for_charge_fuse_sequence(param_00, param_01);
  }
}

use_brute_func(param_00, param_01) {
  if(scripts\engine\utility::flag("obtained_brute_helmet") && !scripts\engine\utility::flag("placed_brute_helmet")) {
    scripts\engine\utility::flag_set("placed_brute_helmet");
    var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
    generic_place_gesture_and_fx(param_01, var_02);
    level.helmet_on_brute.origin = var_02.origin;
    level.helmet_on_brute.angles = var_02.angles;
    level.helmet_on_brute notify("end_entangler_funcs");
    level.helmet_on_brute show();
    scripts\cp\utility::set_quest_icon(1);
    check_for_charge_fuse_sequence(param_00, param_01);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  }
}

check_for_charge_fuse_sequence(param_00, param_01) {
  if(scripts\engine\utility::flag("placed_brute_helmet") && scripts\engine\utility::flag("placed_uncharged_fuses")) {
    var_02 = scripts\engine\utility::getstruct("helmet_shoot_point", "targetname");
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("tag_origin");
    thread playfusechargesounds(var_02, var_03);
    level thread playpapupgradevo(param_01);
    var_04 = playfxontagsbetweenclients(scripts\engine\utility::getfx("vfx_charge_fuse_beam"), var_03, "tag_origin", level.fuse_in_hand, "tag_origin");
    level thread charging_sequence_rumble(param_00);
    level thread changetochargedfuses();
    var_05 = getent("fuse_laser_trigger", "script_noteworthy");
    var_05 thread scripts\cp\maps\cp_final\cp_final_traps::damage_enemies_in_trigger(var_03, level.fuse_in_hand, var_05, 1);
    wait(6);
    var_04 delete();
    var_03 delete();
    var_05 notify("death");
    level notify("stop_charging_fuse");
    scripts\engine\utility::flag_set("fuses_charged");
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_fuse_charged", "zmb_comment_vo");
  }
}

changetochargedfuses() {
  level endon("game_ended");
  wait(0.1);
  level.fuse_in_hand setModel("cp_final_alien_fuse_combined_on");
  level.fuse_effect = playFXOnTag(level._effect["fuse_charged"], level.fuse_in_hand, "tag_origin");
}

playpapupgradevo(param_00) {
  if(isDefined(param_00.vo_prefix)) {
    switch (param_00.vo_prefix) {
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

playfusechargesounds(param_00, param_01) {
  level endon("game_ended");
  playsoundatpos(param_00.origin, "zmb_pap_brute_laser_start");
  wait(0.25);
  param_01 playLoopSound("zmb_pap_brute_laser_lp");
  wait(4.8);
  param_01 stoploopsound();
  playsoundatpos(param_00.origin, "zmb_pap_brute_laser_end");
}

charging_sequence_rumble(param_00) {
  level endon("stop_charging_fuse");
  for(;;) {
    wait(0.15);
    earthquake(0.18, 1, param_00.origin, 784);
    wait(0.05);
    playrumbleonposition("artillery_rumble", param_00.origin);
  }
}

init_reel_change_func() {
  scripts\engine\utility::flag_init("set_movie_spaceland");
}

change_reel_func(param_00, param_01) {
  if(scripts\engine\utility::flag("has_film_reel")) {
    playsoundatpos(param_00.origin, "zmb_pap_film_reel_placement");
    scripts\engine\utility::flag_set("set_movie_spaceland");
    generic_place_gesture_and_fx(param_01, param_00.origin + (-3, 0, 75));
    level.movie_playing = "cp_zmb_screen_640";
    playcinematicforalllooping(level.movie_playing);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  }
}

init_zis_reel() {
  scripts\engine\utility::flag_init("has_film_reel");
}

pickup_zis_reel(param_00, param_01) {
  scripts\engine\utility::flag_set("has_film_reel");
  scripts\cp\utility::set_quest_icon(3);
  var_02 = getent(param_00.target, "targetname");
  generic_pickup_gesture_and_fx(param_01, var_02.origin);
  var_02 hide();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
}

initslidingdoor() {
  var_00 = scripts\engine\utility::getstructarray("facility_sliding_door_750", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray("facility_sliding_door_1000", "script_noteworthy");
  var_02 = scripts\engine\utility::getstructarray("facility_sliding_door_1250", "script_noteworthy");
  var_03 = scripts\engine\utility::getstructarray("facility_sliding_door_1500", "script_noteworthy");
  var_04 = scripts\engine\utility::getstructarray("facility_sliding_door_2000", "script_noteworthy");
  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  var_00 = scripts\engine\utility::array_combine(var_00, var_02, var_03, var_04);
  var_00 = scripts\engine\utility::array_remove_duplicates(var_00);
  level.allslidingdoors = var_00;
  foreach(var_06 in var_00) {
    var_06.var_4284 = 1;
    var_06.power_area = scripts\cp\cp_interaction::get_area_for_power(var_06);
    var_06.doors = [];
    var_07 = getEntArray(var_06.target, "targetname");
    foreach(var_09 in var_07) {
      if(isDefined(var_09.classname) && var_09.classname == "script_brushmodel") {
        continue;
      }

      if(!isDefined(var_09.script_noteworthy)) {}

      var_09.ogorigin = var_09.origin;
      var_06.doors[var_06.doors.size] = var_09;
    }
  }
}

slidingdoorhint(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.requires_power)) {
    return & "CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
  }

  if(scripts\engine\utility::istrue(param_00.player_opened)) {
    param_01.interaction_trigger sethintstringparams(level.enter_area_hint);
    return & "CP_FINAL_INTERACTIONS_OPEN_AREA";
  }

  var_02 = int(level.interactions[param_00.script_noteworthy].cost);
  param_01.interaction_trigger sethintstringparams(level.enter_area_hint, var_02);
  return & "CP_TOWN_INTERACTIONS_PURCHASE_AREA";
}

openslidingdoor(param_00, param_01) {
  level endon("game_ended");
  if(scripts\engine\utility::istrue(param_00.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", param_00.power_area + " power_on");
    param_00.powered_on = 1;
  }

  var_02 = [];
  foreach(var_04 in level.allslidingdoors) {
    if(var_04.target == param_00.target) {
      var_02[var_02.size] = var_04;
    }
  }

  foreach(var_04 in var_02) {
    var_04.opened = 1;
    var_04.var_4284 = 0;
  }

  while(scripts\engine\utility::istrue(param_00.var_42AF)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_04 in var_02) {
    var_04.var_C62C = 1;
  }

  if(isDefined(param_01) && isplayer(param_01)) {
    if(!scripts\engine\utility::istrue(param_00.player_opened)) {
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        param_01 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      }

      param_01 notify("door_opened_notify");
      scripts\cp\cp_persistence::increment_player_career_doors_opened(param_01);
      level notify("door_opened_notify");
      foreach(var_04 in var_02) {
        if(var_04.target == param_00.target) {
          var_04.player_opened = 1;
        }
      }
    }
  }

  var_0C = getEntArray(param_00.target, "targetname");
  foreach(var_0E in var_0C) {
    if(isDefined(var_0E.classname) && var_0E.classname == "script_brushmodel") {
      continue;
    }

    var_0E setscriptablepartstate("door", "open");
  }

  foreach(var_04 in var_02) {
    if(var_04.target == param_00.target) {
      scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_04);
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
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(param_00);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(param_00.script_area);
  foreach(var_04 in var_02) {
    var_04.var_C62C = undefined;
  }
}

closeslidingdoor(param_00, param_01) {
  level endon("game_ended");
  var_02 = [];
  foreach(var_04 in level.allslidingdoors) {
    if(var_04.target == param_00.target) {
      var_02[var_02.size] = var_04;
    }
  }

  var_06 = undefined;
  foreach(var_04 in var_02) {
    if(var_04 != param_00 && var_04.target == param_00.target) {
      var_06 = var_04;
    }

    var_04.opened = undefined;
    var_04.var_4284 = 1;
  }

  while(scripts\engine\utility::istrue(param_00.var_C62C)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_04 in var_02) {
    var_04.var_42AF = 1;
  }

  var_0B = getEntArray(param_00.target, "targetname");
  foreach(var_0D in var_0B) {
    if(isDefined(var_0D.classname) && var_0D.classname == "script_brushmodel") {
      if(scripts\engine\utility::istrue(param_00.player_opened)) {
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
  if(isDefined(var_06)) {
    var_0F = vectornormalize(var_06.origin - param_00.origin);
    var_10 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.characters, undefined, undefined, 40, 0);
    var_11 = param_00.doors[0].origin;
    foreach(var_13 in var_10) {
      if(vectordot(vectornormalize(var_06.origin - param_00.origin), var_0F) > 0.75) {
        if(distance(param_00.origin, var_06.origin) > distance(var_13.origin, param_00.origin)) {
          if(distance(var_11, var_13.origin) <= 16) {
            var_14 = scripts\engine\utility::getclosest(var_13.origin, [var_06, param_00]);
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
            var_13 dodamage(var_13.maxhealth, var_06.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_zombieDoors_zm");
          }
        }
      }
    }
  }

  if(!scripts\engine\utility::istrue(param_00.nointeraction)) {
    scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  }

  wait(0.45);
  foreach(var_04 in var_02) {
    var_04.var_42AF = undefined;
  }
}

helmet_useable() {
  self makeusable();
  self sethintstring( & "CP_FINAL_INTERACTIONS_PICKUP_BRUTE_HELMET");
}

helmet_not_useable() {
  self physicsstopserver();
  self makeunusable();
}

pickup_helmet() {
  helmet_useable();
  for(;;) {
    self waittill("trigger", var_00);
    if(!isDefined(var_00.kicked_out)) {
      scripts\engine\utility::flag_set("obtained_brute_helmet");
      var_00 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_helmet", "zmb_comment_vo");
      scripts\cp\utility::set_quest_icon(1);
      generic_pickup_gesture_and_fx(var_00, self.origin);
      helmet_not_useable();
      self hide();
    }
  }
}

generic_pickup_gesture_and_fx(param_00, param_01) {
  param_00 endon("disconnect");
  if(isent(param_01) || !isvector(param_01)) {
    param_01 = param_01.origin;
  }

  param_00 thread scripts\cp\utility::usegrenadegesture(param_00, "iw7_swipegrab_zm");
  wait(0.28);
  playFX(level._effect["generic_pickup"], param_01);
  param_00 playlocalsound("part_pickup");
}

generic_place_gesture_and_fx(param_00, param_01) {
  param_00 endon("disconnect");
  if(isent(param_01) || !isvector(param_01)) {
    param_01 = param_01.origin;
  }

  param_00 thread scripts\cp\utility::usegrenadegesture(param_00, "iw7_placethrow_zm");
  wait(0.35);
  playFX(level._effect["generic_pickup"], param_01);
  param_00 playlocalsound("part_pickup");
}