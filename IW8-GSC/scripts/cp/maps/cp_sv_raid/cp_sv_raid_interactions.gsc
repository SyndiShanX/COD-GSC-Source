/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_raid\cp_sv_raid_interactions.gsc
******************************************************************/

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
  var0 = 0;

  if(isDefined(level.cp_weapontable)) {
    var1 = level.cp_weapontable;
    goto LOC_00000020;
  }

  for(var1 = "cp/cp_weapontable.csv";; var1++) {
    var2 = tablelookupbyrow(var1, var1, 0);

    if(var2 == "") {
      break;
    }

    var3 = tablelookupbyrow(var1, var1, 2);

    if(issubstr(var3, "wall")) {
      var4 = tablelookupbyrow(var1, var1, 1);
      var5 = int(tablelookupbyrow(var1, var1, 3));
      level.interaction_hintstrings[var4] = &"CP_ZMB_INTERACTIONS/BUY_WEAPON";
      scripts\cp\cp_interaction::register_interaction(var4, "wall_buy", undefined, &scripts\cp\cp_wall_buys::get_wall_buy_hint_func, &scripts\cp\cp_wall_buys::interaction_purchase_weapon, var5);
    }
  }
}

function level_specific_wait_for_interaction_triggered(var0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    self.interaction_trigger waittill("trigger", var1);

    if(!scripts\cp\cp_interaction::interaction_is_valid(var0, var1)) {
      wait 0.1;
      continue;
    }

    var0.triggered = 1;
    var0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    var2 = level.interactions[var0.script_noteworthy].cost;

    if(!isDefined(level.interactions[var0.script_noteworthy].spend_type)) {
      level.interactions[var0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var0.script_noteworthy].can_use_override_func]](var0, var1)) {
        wait 0.1;
        continue;
      }
    } else if(var0.script_noteworthy == "lost_and_found") {
      if(!istrue(self.have_things_in_lost_and_found)) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var0) {
        wait 0.1;
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || istrue(level.only_one_player)) {
        var2 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var0)) {
      if(scripts\cp\utility::is_codxp()) {
        wait 0.1;
        continue;
      }

      var3 = var1 getcurrentweapon();
      level.prevweapon = var1 getcurrentweapon();
      var4 = scripts\cp\cp_weapon::get_weapon_level(var3);

      if(istrue(var1.has_zis_soul_key) || istrue(level.placed_alien_fuses)) {
        if(var4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/UPGRADE_MAXED");
          wait 0.1;
          continue;
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
          wait 0.1;
          continue;
        }
      } else if(var4 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/UPGRADE_MAXED");
        wait 0.1;
        continue;
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait 0.1;
        continue;
      }

      var5 = var1 getcurrentweapon();
      var6 = scripts\cp\utility::getbaseweaponname(var5);

      if(scripts\cp\cp_weapon::has_weapon_variation(var0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_GAME_PLAY/AMMO_MAX");
          wait 0.1;
          continue;
        } else {
          var7 = scripts\cp\utility::getrawbaseweaponname(var0.script_noteworthy);
          var4 = scripts\cp\cp_weapon::get_weapon_level(var7);

          if(var4 > 1) {
            var2 = 4500;
          } else {
            var2 *= 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var0)) {
      if(!var1 scripts\cp\cp_interaction::can_use_perk(var0)) {
        var2 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var0.perk_type == "perk_machine_revive" && var1.self_revives_purchased <= var1.max_self_revive_machine_use) {
        var2 = 500;
        var1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_perk_revive_solo", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      } else {
        var2 = scripts\cp\cp_interaction::get_perk_machine_cost(var0);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_crafting_station(var0)) {
      if(!isDefined(var1.current_crafting_struct) && var0.available_ingredient_slots > 0) {
        level notify("interaction", "purchase_denied", level.interactions[var0.script_noteworthy], self);
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var0)) {
      if(var1.card_refills == 2) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/NO_MORE_CARDS_OWNED");
        wait 0.1;
        continue;
      }

      if(self.card_refills == 1) {
        var2 = level.fortune_visit_cost_2;
      } else {
        var2 = level.fortune_visit_cost_1;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var0, var2, level.interactions[var0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var0.script_noteworthy], self);

      if(var0.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"CP_ZMB_INTERACTIONS/NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var0) && var0.perk_type == "perk_machine_revive" && var1.self_revives_purchased >= var1.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/NEED_MONEY");
      }

      wait 0.1;
      continue;
    }

    if(var0.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var0, &"COOP_INTERACTIONS/NEED_MONEY");
          wait 0.1;
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var0);

    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var0)) {
      level notify("interaction", var0.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level.interactions[var0.script_noteworthy], self);
    }

    var8 = level.interactions[var0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var2, var8);
    level thread[[level.interactions[var0.script_noteworthy].activation_func]](var0, self);
    scripts\cp\cp_interaction::interaction_post_activate_update(var0);
    var0.triggered = undefined;
    return;
  }
}

function level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var0 = 5184;
  var1 = 9216;
  var2 = 2304;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    var4 = undefined;
    var5 = sortbydistance(level.current_interaction_structs, self.origin);

    foreach(var7 in self.disabled_interactions) {
      var5 = scripts\engine\utility::array_remove(var5, var7);
    }

    if(var5.size == 0) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    if(istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    var9 = var5[0];

    if(!isDefined(var9)) {
      self notify("starting_interaction_search");
      wait 0.05;
      continue;
    }

    if(!isDefined(var4) && distancesquared(var9.origin, self.origin) <= var0) {
      var4 = var9;
    }

    if(!isDefined(var4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var9.origin, self.origin) <= var1) {
        var4 = var9;
      }

      if(isDefined(var4) && ![[level.should_allow_far_search_dist_func]](var4)) {
        var4 = undefined;
      }
    } else if(!isDefined(var4) && isDefined(var9.custom_search_dist)) {
      if(distance(var9.origin, self.origin) <= var9.custom_search_dist) {
        var4 = var9;
      }
    }

    if(!isDefined(var4) || !scripts\engine\utility::array_contains(level.current_interaction_structs, var4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!isDefined(self.last_interaction_point) || self.last_interaction_point == var4 && scripts\cp\cp_interaction::interaction_is_button_mash(var4) || self.last_interaction_point != var4) {
      scripts\cp\cp_interaction::set_interaction_point(var4);
    } else if(self.last_interaction_point == var4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var4) && !istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var4, 0);
    }

    wait 0.05;
  }
}