/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\arcade_game_utility.gsc
******************************************************/

update_player_tickets_earned(var_0) {
  if(var_0.tickets_earned > 0) {
    level thread player_ticket_queue(var_0);
  }
}

player_ticket_queue(var_0) {
  var_0 notify("ticket_queue");
  var_0 endon("ticket_queue");
  var_0 endon("disconnect");
  if(gettime() > var_0.time_to_give_next_tickets) {
    var_1 = var_0.tickets_earned;
    if(var_1 > 10) {
      var_1 = 10;
    }

    var_0.time_to_give_next_tickets = gettime() + var_1 / 1.5 * 1000 + 500;
    var_2 = var_0.tickets_earned;
    var_0.tickets_earned = 0;
    give_player_tickets(var_0, var_2);
    return;
  }

  while(gettime() < var_0.time_to_give_next_tickets && var_0.tickets_earned > 0) {
    wait(0.1);
  }

  if(var_0.tickets_earned > 0) {
    var_1 = var_0.tickets_earned;
    if(var_1 > 10) {
      var_1 = 10;
    }

    var_0.time_to_give_next_tickets = gettime() + var_1 / 1.5 * 1000 + 500;
    var_2 = var_0.tickets_earned;
    var_0.tickets_earned = 0;
    give_player_tickets(var_0, var_2);
  }
}

give_player_tickets(var_0, var_1, var_2, var_3) {
  if(isDefined(level.no_ticket_machine)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.double_money)) {
    var_1 = var_1 * 2;
  }

  if(!isDefined(var_0.num_tickets)) {
    var_0.num_tickets = 0;
  }

  if(var_1 < 0) {
    var_1 = max(var_0.num_tickets * -1, var_1);
  }

  var_0.num_tickets = var_0.num_tickets + var_1;
  if(var_0.num_tickets < 0) {
    var_0.num_tickets = 0;
  }

  var_1 = int(var_1);
  if(var_1 == 0) {
    return;
  }

  if(var_1 > 0 && !scripts\engine\utility::istrue(var_3)) {
    var_0 playlocalsound("zmb_ui_earn_tickets");
  }

  var_0 setclientomnvar("zombie_number_of_ticket", int(var_0.num_tickets));
  if(!scripts\engine\utility::istrue(var_3)) {
    var_0 thread show_ticket_machine(var_1);
  }

  var_0 scripts\cp\cp_persistence::eog_player_update_stat("tickettotal", int(var_0.num_tickets), 1);
  scripts\cp\zombies\zombies_gamescore::update_tickets_earned_performance(var_0, var_1);
}

arcade_game_hint_func(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(scripts\engine\utility::istrue(var_0.out_of_order)) {
    return &"CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

show_ticket_machine(var_0) {
  self endon("disconnect");
  if(var_0 < 0) {
    return;
  }

  self setclientomnvar("zm_tickets_dispersed", var_0);
  if(var_0 > 10) {
    var_0 = 10;
  }

  wait(2.5);
  self setclientomnvar("zm_tickets_dispersed", -1);
}

arcade_game_player_disconnect_or_death(var_0, var_1, var_2, var_3) {
  var_0 endon("arcade_game_over_for_player");
  var_4 = var_0 scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect", "last_stand", "spawned");
  if(var_4 == "disconnect") {
    var_1.active_player = undefined;
  } else {
    [[var_3]](var_1, var_0);
    var_0 takeweapon(var_2);
    var_0 scripts\engine\utility::allow_weapon_switch(1);
    if(!var_0 scripts\engine\utility::isusabilityallowed()) {
      var_0 scripts\engine\utility::allow_usability(1);
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0 notify("arcade_game_over_for_player");
}

arcade_game_player_gets_too_far_away(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("arcade_game_over_for_player");
  var_0 endon("stop_too_far_check");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_0 endon("spawned");
  var_7 = 10000;
  if(isDefined(var_5)) {
    var_7 = var_5;
  }

  for(;;) {
    wait(0.1);
    if(distancesquared(var_0.origin, var_1.origin) > var_7 || var_0 getstance() == "prone") {
      var_0 playlocalsound("purchase_deny");
      wait(0.5);
      if(distancesquared(self.origin, var_1.origin) > var_7 || var_0 getstance() == "prone") {
        if(isDefined(var_1.basketball_game_music)) {
          if(isDefined(var_4)) {
            var_1.basketball_game_music scripts\engine\utility::delaycall(1, ::playsound, var_4);
          }

          var_1.basketball_game_music scripts\engine\utility::delaycall(1, ::stoploopsound);
        }

        if(isDefined(var_2)) {
          var_0 takeweapon(var_2);
        }

        [[var_3]](var_1, var_0);
        var_1.active_player = undefined;
        scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
        var_0 scripts\engine\utility::allow_weapon_switch(1);
        if(!var_0 scripts\engine\utility::isusabilityallowed()) {
          var_0 scripts\engine\utility::allow_usability(1);
        }

        var_0 give_player_back_weapon(var_0);
        var_0 restore_player_grenades_post_game();
        if(var_0.arcade_game_award_type == "tickets") {
          if(isDefined(var_1.bball_game_score) && var_1.bball_game_score >= 1) {
            var_8 = var_1.bball_game_score * 15;
            var_0 give_player_tickets(var_0, var_1.bball_game_score * 15);
            if(var_1.bball_game_score * 15 > var_1.bball_game_hiscore) {
              playsoundatpos(var_1.music_ent.origin, "basketball_anc_highscore");
              setomnvar("zombie_bball_game_" + var_6 + "_hiscore", var_1.bball_game_score * 15);
              var_1.bball_game_hiscore = var_1.bball_game_score * 15;
            }
          }

          if(isDefined(var_1.var_10227) && var_1.var_10227 >= 1) {
            var_8 = var_1.var_10227 * 1;
            var_0 give_player_tickets(var_0, var_8);
          }

          if(isDefined(var_1.var_10227) && var_1.var_10227 >= 1) {
            var_8 = var_1.var_10227 * 1;
            var_0 give_player_tickets(var_0, var_8);
          }
        }

        var_0 notify("too_far_from_game");
        var_0 notify("arcade_game_over_for_player");
      }
    }
  }
}

turn_off_machine_after_uses(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 7;
  }

  for(;;) {
    var_2 = 1;
    self.out_of_order = 0;
    var_3 = 0;
    var_4 = randomintrange(var_0, var_1 + 1);
    while(var_2) {
      self waittill("machine_used");
      var_3++;
      if(var_3 >= var_4) {
        self.out_of_order = 1;
        var_2 = 0;
        level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
      }

      foreach(var_6 in level.players) {
        if(isDefined(var_6.last_interaction_point) && var_6.last_interaction_point == self) {
          var_6 thread scripts\cp\cp_interaction::refresh_interaction();
        }
      }
    }
  }
}

saveplayerpregameweapon(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return;
  }

  var_1 = var_0 getcurrentweapon();
  var_2 = 0;
  if(var_1 == "none") {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_1)) {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_1))) {
    var_2 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_1, 1)) {
    var_2 = 1;
  }

  if(var_2) {
    var_0.copy_fullweaponlist = var_0 getweaponslistall();
    var_1 = var_0 scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  var_0.copy_fullweaponlist = undefined;
  if(isDefined(var_1)) {
    return var_1;
  }

  return var_0 getcurrentweapon();
}

give_player_back_weapon(var_0) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return;
  }

  if(isDefined(var_0.pre_arcade_game_weapon)) {
    if(var_0 hasweapon(var_0.pre_arcade_game_weapon)) {
      var_0 switchtoweapon(var_0.pre_arcade_game_weapon);
    }
  } else {
    var_1 = var_0 getweaponslistprimaries();
    if(isDefined(var_1[1])) {
      var_0 switchtoweapon(var_1[1]);
    }
  }

  var_0.pre_arcade_game_weapon_clip = undefined;
  var_0.pre_arcade_game_weapon_stock = undefined;
  var_0.pre_arcade_game_weapon = undefined;
}

take_player_grenades_pre_game() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return;
  }

  var_0 = scripts\cp\powers\coop_powers::what_power_is_in_slot("primary");
  var_1 = scripts\cp\powers\coop_powers::what_power_is_in_slot("secondary");
  self.pre_arcade_primary_power = var_0;
  self.pre_arcade_secondary_power = var_1;
  if(isDefined(var_0)) {
    self.pre_arcade_primary_power_charges = self.powers[self.pre_arcade_primary_power].charges;
    scripts\cp\powers\coop_powers::removepower(var_0);
  }

  if(isDefined(var_1)) {
    self.pre_arcade_secondary_power_charges = self.powers[self.pre_arcade_secondary_power].charges;
    scripts\cp\powers\coop_powers::removepower(var_1);
  }
}

take_player_super_pre_game() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return;
  }

  self clearoffhandspecial();
  self takeweapon("super_default_zm");
}

restore_player_grenades_post_game() {
  scripts\cp\utility::restore_super_weapon();
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return;
  }

  if(isDefined(self.pre_arcade_primary_power)) {
    var_0 = level.powers[self.pre_arcade_primary_power].defaultslot;
    scripts\cp\powers\coop_powers::func_4171(var_0);
    scripts\cp\powers\coop_powers::givepower(self.pre_arcade_primary_power, var_0, undefined, undefined, undefined, undefined, 1);
    scripts\cp\powers\coop_powers::power_adjustcharges(self.pre_arcade_primary_power_charges, var_0, 1);
  }

  if(isDefined(self.pre_arcade_secondary_power)) {
    var_0 = level.powers[self.pre_arcade_secondary_power].defaultslot;
    scripts\cp\powers\coop_powers::func_4171(var_0);
    scripts\cp\powers\coop_powers::givepower(self.pre_arcade_secondary_power, var_0, undefined, undefined, undefined, undefined, 0);
    scripts\cp\powers\coop_powers::power_adjustcharges(self.pre_arcade_secondary_power_charges, var_0, 1);
  }

  self.pre_arcade_primary_power = undefined;
  self.pre_arcade_primary_power_charges = undefined;
  self.pre_arcade_secondary_power = undefined;
  self.pre_arcade_secondary_power_charges = undefined;
}

set_arcade_game_award_type(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    var_0.arcade_game_award_type = "soul_power";
    return;
  }

  var_0.arcade_game_award_type = "tickets";
}

update_song_playing(var_0, var_1) {
  var_0.song_playing = 1;
  var_2 = lookupsoundlength(var_1);
  wait(var_2 / 1000);
  var_0.song_playing = 0;
}