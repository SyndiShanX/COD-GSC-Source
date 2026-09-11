/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_interactions.gsc
****************************************************************************/

function register_interactions() {
  if(isDefined(level.escape_interaction_registration_func)) {
    [[level.escape_interaction_registration_func]]();
  }

  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_set("interactions_initialized");
    return;
  }
}

function wallbuyinteractions() {
  var_0 = 0;

  if(isDefined(level.cp_weapontable)) {
    var_1 = level.cp_weapontable;
    goto LOC_00000020;
  }

  for(var_1 = "cp/cp_weapontable.csv";; var_1++) {
    var_2 = tablelookupbyrow(var_1, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_1, 2);

    if(issubstr(var_3, "wall")) {
      var_4 = tablelookupbyrow(var_1, var_1, 1);
      var_5 = int(tablelookupbyrow(var_1, var_1, 3));
      level.interaction_hintstrings[var_4] = &"CP_ZMB_INTERACTIONS/BUY_WEAPON";
      scripts\cp\cp_interaction::register_interaction(var_4, "wall_buy", undefined, &scripts\cp\cp_wall_buys::get_wall_buy_hint_func, &scripts\cp\cp_wall_buys::interaction_purchase_weapon, var_5);
    }
  }
}

function level_specific_wait_for_interaction_triggered(var_0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    self.interaction_trigger waittill("trigger", var_1);

    if(!scripts\cp\cp_interaction::interaction_is_valid(var_0, var_1)) {
      wait 0.1;
      continue;
    }

    var_0.triggered = 1;
    var_0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    var_2 = level.interactions[var_0.script_noteworthy].cost;

    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
      level.interactions[var_0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
        wait 0.1;
        continue;
      }
    } else if(var_0.script_noteworthy == "lost_and_found") {
      if(!istrue(self.have_things_in_lost_and_found)) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var_0) {
        wait 0.1;
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || istrue(level.only_one_player)) {
        var_2 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var_0)) {
      if(scripts\cp\utility::is_codxp()) {
        wait 0.1;
        continue;
      }

      var_3 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);

      if(istrue(var_1.has_zis_soul_key) || istrue(level.placed_alien_fuses)) {
        if(var_4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/UPGRADE_MAXED");
          wait 0.1;
          continue;
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
          wait 0.1;
          continue;
        }
      } else if(var_4 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/UPGRADE_MAXED");
        wait 0.1;
        continue;
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait 0.1;
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::getbaseweaponname(var_5);

      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY/AMMO_MAX");
          wait 0.1;
          continue;
        } else {
          var_7 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_4 = scripts\cp\cp_weapon::get_weapon_level(var_7);

          if(var_4 > 1) {
            var_2 = 4500;
          } else {
            var_2 *= 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var_0)) {
      if(!var_1 scripts\cp\cp_interaction::can_use_perk(var_0)) {
        var_2 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased <= var_1.max_self_revive_machine_use) {
        var_2 = 500;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_perk_revive_solo", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      } else {
        var_2 = scripts\cp\cp_interaction::get_perk_machine_cost(var_0);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_crafting_station(var_0)) {
      if(!isDefined(var_1.current_crafting_struct) && var_0.available_ingredient_slots > 0) {
        level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var_0)) {
      if(var_1.card_refills == 2) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/NO_MORE_CARDS_OWNED");
        wait 0.1;
        continue;
      }

      if(self.card_refills == 1) {
        var_2 = level.fortune_visit_cost_2;
      } else {
        var_2 = level.fortune_visit_cost_1;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);

      if(var_0.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS/NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/NEED_MONEY");
      }

      wait 0.1;
      continue;
    }

    if(var_0.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS/NEED_MONEY");
          wait 0.1;
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var_0);

    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      level notify("interaction", var_0.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level.interactions[var_0.script_noteworthy], self);
    }

    var_8 = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_8);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    var_0.triggered = undefined;
    return;
  }
}

function level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    var_4 = undefined;
    var_5 = sortbydistance(level.current_interaction_structs, self.origin);

    foreach(var_7 in self.disabled_interactions) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    if(var_5.size == 0) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    if(istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    var_9 = var_5[0];

    if(!isDefined(var_9)) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    if(!isDefined(var_4) && distancesquared(var_9.origin, self.origin) <= var_0) {
      var_4 = var_9;
    }

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_9.origin, self.origin) <= var_1) {
        var_4 = var_9;
      }

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_9.custom_search_dist)) {
      if(distance(var_9.origin, self.origin) <= var_9.custom_search_dist) {
        var_4 = var_9;
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

    if(!isDefined(self.last_interaction_point) || self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_button_mash(var_4) || self.last_interaction_point != var_4) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    } else if(self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_4) && !istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4, 0);
    }

    wait 0.05;
  }
}