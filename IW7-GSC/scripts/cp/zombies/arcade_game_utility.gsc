/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\arcade_game_utility.gsc
******************************************************/

update_player_tickets_earned(param_00) {
  if(param_00.tickets_earned > 0) {
    level thread player_ticket_queue(param_00);
  }
}

player_ticket_queue(param_00) {
  param_00 notify("ticket_queue");
  param_00 endon("ticket_queue");
  param_00 endon("disconnect");
  if(gettime() > param_00.time_to_give_next_tickets) {
    var_01 = param_00.tickets_earned;
    if(var_01 > 10) {
      var_01 = 10;
    }

    param_00.time_to_give_next_tickets = gettime() + var_01 / 1.5 * 1000 + 500;
    var_02 = param_00.tickets_earned;
    param_00.tickets_earned = 0;
    give_player_tickets(param_00, var_02);
    return;
  }

  while(gettime() < param_00.time_to_give_next_tickets && param_00.tickets_earned > 0) {
    wait(0.1);
  }

  if(param_00.tickets_earned > 0) {
    var_01 = param_00.tickets_earned;
    if(var_01 > 10) {
      var_01 = 10;
    }

    param_00.time_to_give_next_tickets = gettime() + var_01 / 1.5 * 1000 + 500;
    var_02 = param_00.tickets_earned;
    param_00.tickets_earned = 0;
    give_player_tickets(param_00, var_02);
  }
}

give_player_tickets(param_00, param_01, param_02, param_03) {
  if(isDefined(level.no_ticket_machine)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_00.double_money)) {
    param_01 = param_01 * 2;
  }

  if(!isDefined(param_00.num_tickets)) {
    param_00.num_tickets = 0;
  }

  if(param_01 < 0) {
    param_01 = max(param_00.num_tickets * -1, param_01);
  }

  param_00.num_tickets = param_00.num_tickets + param_01;
  if(param_00.num_tickets < 0) {
    param_00.num_tickets = 0;
  }

  param_01 = int(param_01);
  if(param_01 == 0) {
    return;
  }

  if(param_01 > 0 && !scripts\engine\utility::istrue(param_03)) {
    param_00 playlocalsound("zmb_ui_earn_tickets");
  }

  param_00 setclientomnvar("zombie_number_of_ticket", int(param_00.num_tickets));
  if(!scripts\engine\utility::istrue(param_03)) {
    param_00 thread show_ticket_machine(param_01);
  }

  param_00 scripts\cp\cp_persistence::eog_player_update_stat("tickettotal", int(param_00.num_tickets), 1);
  scripts\cp\zombies\zombies_gamescore::update_tickets_earned_performance(param_00, param_01);
}

arcade_game_hint_func(param_00, param_01) {
  if(param_00.requires_power && !param_00.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return & "COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(scripts\engine\utility::istrue(param_00.out_of_order)) {
    return & "CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

show_ticket_machine(param_00) {
  self endon("disconnect");
  if(param_00 < 0) {
    return;
  }

  self setclientomnvar("zm_tickets_dispersed", param_00);
  if(param_00 > 10) {
    param_00 = 10;
  }

  wait(2.5);
  self setclientomnvar("zm_tickets_dispersed", -1);
}

arcade_game_player_disconnect_or_death(param_00, param_01, param_02, param_03) {
  param_00 endon("arcade_game_over_for_player");
  var_04 = param_00 scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect", "last_stand", "spawned");
  if(var_04 == "disconnect") {
    param_01.active_player = undefined;
  } else {
    [[param_03]](param_01, param_00);
    param_00 takeweapon(param_02);
    param_00 scripts\engine\utility::allow_weapon_switch(1);
    if(!param_00 scripts\engine\utility::isusabilityallowed()) {
      param_00 scripts\engine\utility::allow_usability(1);
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
  param_00 notify("arcade_game_over_for_player");
}

arcade_game_player_gets_too_far_away(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 endon("arcade_game_over_for_player");
  param_00 endon("stop_too_far_check");
  param_00 endon("last_stand");
  param_00 endon("disconnect");
  param_00 endon("spawned");
  var_07 = 10000;
  if(isDefined(param_05)) {
    var_07 = param_05;
  }

  for(;;) {
    wait(0.1);
    if(distancesquared(param_00.origin, param_01.origin) > var_07 || param_00 getstance() == "prone") {
      param_00 playlocalsound("purchase_deny");
      wait(0.5);
      if(distancesquared(self.origin, param_01.origin) > var_07 || param_00 getstance() == "prone") {
        if(isDefined(param_01.basketball_game_music)) {
          if(isDefined(param_04)) {
            param_01.basketball_game_music scripts\engine\utility::delaycall(1, ::playsound, param_04);
          }

          param_01.basketball_game_music scripts\engine\utility::delaycall(1, ::stoploopsound);
        }

        if(isDefined(param_02)) {
          param_00 takeweapon(param_02);
        }

        [
          [param_03]
        ](param_01, param_00);
        param_01.active_player = undefined;
        scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
        param_00 scripts\engine\utility::allow_weapon_switch(1);
        if(!param_00 scripts\engine\utility::isusabilityallowed()) {
          param_00 scripts\engine\utility::allow_usability(1);
        }

        param_00 give_player_back_weapon(param_00);
        param_00 restore_player_grenades_post_game();
        if(param_00.arcade_game_award_type == "tickets") {
          if(isDefined(param_01.bball_game_score) && param_01.bball_game_score >= 1) {
            var_08 = param_01.bball_game_score * 15;
            param_00 give_player_tickets(param_00, param_01.bball_game_score * 15);
            if(param_01.bball_game_score * 15 > param_01.bball_game_hiscore) {
              playsoundatpos(param_01.music_ent.origin, "basketball_anc_highscore");
              setomnvar("zombie_bball_game_" + param_06 + "_hiscore", param_01.bball_game_score * 15);
              param_01.bball_game_hiscore = param_01.bball_game_score * 15;
            }
          }

          if(isDefined(param_01.var_10227) && param_01.var_10227 >= 1) {
            var_08 = param_01.var_10227 * 1;
            param_00 give_player_tickets(param_00, var_08);
          }

          if(isDefined(param_01.var_10227) && param_01.var_10227 >= 1) {
            var_08 = param_01.var_10227 * 1;
            param_00 give_player_tickets(param_00, var_08);
          }
        }

        param_00 notify("too_far_from_game");
        param_00 notify("arcade_game_over_for_player");
      }
    }
  }
}

turn_off_machine_after_uses(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 4;
  }

  if(!isDefined(param_01)) {
    param_01 = 7;
  }

  for(;;) {
    var_02 = 1;
    self.out_of_order = 0;
    var_03 = 0;
    var_04 = randomintrange(param_00, param_01 + 1);
    while(var_02) {
      self waittill("machine_used");
      var_03++;
      if(var_03 >= var_04) {
        self.out_of_order = 1;
        var_02 = 0;
        level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
      }

      foreach(var_06 in level.players) {
        if(isDefined(var_06.last_interaction_point) && var_06.last_interaction_point == self) {
          var_06 thread scripts\cp\cp_interaction::refresh_interaction();
        }
      }
    }
  }
}

saveplayerpregameweapon(param_00) {
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    return;
  }

  var_01 = param_00 getcurrentweapon();
  var_02 = 0;
  if(var_01 == "none") {
    var_02 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_01)) {
    var_02 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_01))) {
    var_02 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_01, 1)) {
    var_02 = 1;
  }

  if(var_02) {
    param_00.copy_fullweaponlist = param_00 getweaponslistall();
    var_01 = param_00 scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  param_00.copy_fullweaponlist = undefined;
  if(isDefined(var_01)) {
    return var_01;
  }

  return param_00 getcurrentweapon();
}

give_player_back_weapon(param_00) {
  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return;
  }

  if(isDefined(param_00.pre_arcade_game_weapon)) {
    if(param_00 hasweapon(param_00.pre_arcade_game_weapon)) {
      param_00 switchtoweapon(param_00.pre_arcade_game_weapon);
    }
  } else {
    var_01 = param_00 getweaponslistprimaries();
    if(isDefined(var_01[1])) {
      param_00 switchtoweapon(var_01[1]);
    }
  }

  param_00.pre_arcade_game_weapon_clip = undefined;
  param_00.pre_arcade_game_weapon_stock = undefined;
  param_00.pre_arcade_game_weapon = undefined;
}

take_player_grenades_pre_game() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return;
  }

  var_00 = scripts\cp\powers\coop_powers::what_power_is_in_slot("primary");
  var_01 = scripts\cp\powers\coop_powers::what_power_is_in_slot("secondary");
  self.pre_arcade_primary_power = var_00;
  self.pre_arcade_secondary_power = var_01;
  if(isDefined(var_00)) {
    self.pre_arcade_primary_power_charges = self.powers[self.pre_arcade_primary_power].charges;
    scripts\cp\powers\coop_powers::removepower(var_00);
  }

  if(isDefined(var_01)) {
    self.pre_arcade_secondary_power_charges = self.powers[self.pre_arcade_secondary_power].charges;
    scripts\cp\powers\coop_powers::removepower(var_01);
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
    var_00 = level.powers[self.pre_arcade_primary_power].defaultslot;
    scripts\cp\powers\coop_powers::func_4171(var_00);
    scripts\cp\powers\coop_powers::givepower(self.pre_arcade_primary_power, var_00, undefined, undefined, undefined, undefined, 1);
    scripts\cp\powers\coop_powers::power_adjustcharges(self.pre_arcade_primary_power_charges, var_00, 1);
  }

  if(isDefined(self.pre_arcade_secondary_power)) {
    var_00 = level.powers[self.pre_arcade_secondary_power].defaultslot;
    scripts\cp\powers\coop_powers::func_4171(var_00);
    scripts\cp\powers\coop_powers::givepower(self.pre_arcade_secondary_power, var_00, undefined, undefined, undefined, undefined, 0);
    scripts\cp\powers\coop_powers::power_adjustcharges(self.pre_arcade_secondary_power_charges, var_00, 1);
  }

  self.pre_arcade_primary_power = undefined;
  self.pre_arcade_primary_power_charges = undefined;
  self.pre_arcade_secondary_power = undefined;
  self.pre_arcade_secondary_power_charges = undefined;
}

set_arcade_game_award_type(param_00) {
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    param_00.arcade_game_award_type = "soul_power";
    return;
  }

  param_00.arcade_game_award_type = "tickets";
}

update_song_playing(param_00, param_01) {
  param_00.song_playing = 1;
  var_02 = lookupsoundlength(param_01);
  wait(var_02 / 1000);
  param_00.song_playing = 0;
}