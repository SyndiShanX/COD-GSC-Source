/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3371.gsc
***************************************/

update_player_tickets_earned(var_00) {
  if(var_0.tickets_earned > 0)
    level thread player_ticket_queue(var_00);
}

player_ticket_queue(var_00) {
  var_00 notify("ticket_queue");
  var_00 endon("ticket_queue");
  var_00 endon("disconnect");

  if(gettime() > var_0.time_to_give_next_tickets) {
    var_01 = var_0.tickets_earned;

    if(var_01 > 10)
      var_01 = 10;

    var_0.time_to_give_next_tickets = gettime() + var_01 / 1.5 * 1000 + 500;
    var_02 = var_0.tickets_earned;
    var_0.tickets_earned = 0;
    give_player_tickets(var_00, var_02);
  } else {
    while(gettime() < var_0.time_to_give_next_tickets && var_0.tickets_earned > 0)
      wait 0.1;

    if(var_0.tickets_earned > 0) {
      var_01 = var_0.tickets_earned;

      if(var_01 > 10)
        var_01 = 10;

      var_0.time_to_give_next_tickets = gettime() + var_01 / 1.5 * 1000 + 500;
      var_02 = var_0.tickets_earned;
      var_0.tickets_earned = 0;
      give_player_tickets(var_00, var_02);
    }
  }
}

give_player_tickets(var_00, var_01, var_02, var_03) {
  if(isDefined(level.no_ticket_machine)) {
    return;
  }
  if(scripts\engine\utility::is_true(var_0.double_money))
    var_01 = var_01 * 2;

  if(!isDefined(var_0.num_tickets))
    var_0.num_tickets = 0;

  if(var_01 < 0)
    var_01 = max(var_0.num_tickets * -1, var_01);

  var_0.num_tickets = var_0.num_tickets + var_01;

  if(var_0.num_tickets < 0)
    var_0.num_tickets = 0;

  var_01 = int(var_01);

  if(var_01 == 0) {
    return;
  }
  if(var_01 > 0 && !scripts\engine\utility::is_true(var_03))
    var_00 playlocalsound("zmb_ui_earn_tickets");

  var_00 setclientomnvar("zombie_number_of_ticket", int(var_0.num_tickets));

  if(!scripts\engine\utility::is_true(var_03))
    var_00 thread show_ticket_machine(var_01);

  var_00 scripts\cp\cp_persistence::eog_player_update_stat("tickettotal", int(var_0.num_tickets), 1);
  scripts\cp\zombies\zombies_gamescore::update_tickets_earned_performance(var_00, var_01);
}

arcade_game_hint_func(var_00, var_01) {
  if(var_0.requires_power && !var_0.powered_on)
    return & "COOP_INTERACTIONS_REQUIRES_POWER";

  if(scripts\engine\utility::is_true(var_0.out_of_order))
    return & "CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

show_ticket_machine(var_00) {
  self endon("disconnect");

  if(var_00 < 0) {
    return;
  }
  self setclientomnvar("zm_tickets_dispersed", var_00);

  if(var_00 > 10)
    var_00 = 10;

  wait 2.5;
  self setclientomnvar("zm_tickets_dispersed", -1);
}

arcade_game_player_disconnect_or_death(var_00, var_01, var_02, var_03) {
  var_00 endon("arcade_game_over_for_player");
  var_04 = var_00 scripts\engine\utility::waittill_any_return_no_endon_death("disconnect", "last_stand", "spawned");

  if(var_04 == "disconnect")
    var_1.active_player = undefined;
  else {
    [[var_03]](var_01, var_00);
    var_00 giveuponsuppressiontime(var_02);
    var_00 scripts\engine\utility::allow_weapon_switch(1);

    if(!var_00 scripts\engine\utility::isusabilityallowed())
      var_00 scripts\engine\utility::allow_usability(1);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  var_00 notify("arcade_game_over_for_player");
}

arcade_game_player_gets_too_far_away(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_00 endon("arcade_game_over_for_player");
  var_00 endon("stop_too_far_check");
  var_00 endon("last_stand");
  var_00 endon("disconnect");
  var_00 endon("spawned");
  var_07 = 10000;

  if(isDefined(var_05))
    var_07 = var_05;

  for(;;) {
    wait 0.1;

    if(distancesquared(var_0.origin, var_1.origin) > var_07 || var_00 getstance() == "prone") {
      var_00 playlocalsound("purchase_deny");
      wait 0.5;

      if(distancesquared(self.origin, var_1.origin) > var_07 || var_00 getstance() == "prone") {
        if(isDefined(var_1.basketball_game_music)) {
          if(isDefined(var_04))
            var_1.basketball_game_music scripts\engine\utility::delaycall(1.0, ::playsound, var_04);

          var_1.basketball_game_music scripts\engine\utility::delaycall(1.0, ::stoploopsound);
        }

        if(isDefined(var_02))
          var_00 giveuponsuppressiontime(var_02);

        [
          [var_03]
        ](var_01, var_00);
        var_1.active_player = undefined;
        scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
        var_00 scripts\engine\utility::allow_weapon_switch(1);

        if(!var_00 scripts\engine\utility::isusabilityallowed())
          var_00 scripts\engine\utility::allow_usability(1);

        var_00 give_player_back_weapon(var_00);
        var_00 restore_player_grenades_post_game();

        if(var_0.arcade_game_award_type == "tickets") {
          if(isDefined(var_1.bball_game_score) && var_1.bball_game_score >= 1) {
            var_08 = var_1.bball_game_score * 15;
            var_00 give_player_tickets(var_00, var_1.bball_game_score * 15);

            if(var_1.bball_game_score * 15 > var_1.bball_game_hiscore) {
              playLoopSound(var_1.music_ent.origin, "basketball_anc_highscore");
              setomnvar("zombie_bball_game_" + var_06 + "_hiscore", var_1.bball_game_score * 15);
              var_1.bball_game_hiscore = var_1.bball_game_score * 15;
            }
          }

          if(isDefined(var_1.func_10227) && var_1.func_10227 >= 1) {
            var_08 = var_1.func_10227 * 1;
            var_00 give_player_tickets(var_00, var_08);
          }

          if(isDefined(var_1.func_10227) && var_1.func_10227 >= 1) {
            var_08 = var_1.func_10227 * 1;
            var_00 give_player_tickets(var_00, var_08);
          }
        }

        var_00 notify("too_far_from_game");
        var_00 notify("arcade_game_over_for_player");
      }
    }
  }
}

turn_off_machine_after_uses(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 4;

  if(!isDefined(var_01))
    var_01 = 7;

  for(;;) {
    var_02 = 1;
    self.out_of_order = 0;
    var_03 = 0;
    var_04 = randomintrange(var_00, var_01 + 1);

    while(var_02) {
      self waittill("machine_used");
      var_3++;

      if(var_03 >= var_04) {
        self.out_of_order = 1;
        var_02 = 0;
        level scripts\engine\utility::waittill_any("regular_wave_starting", "event_wave_starting");
      }

      foreach(var_06 in level.players) {
        if(isDefined(var_6.last_interaction_point) && var_6.last_interaction_point == self)
          var_06 thread scripts\cp\cp_interaction::refresh_interaction();
      }
    }
  }
}

saveplayerpregameweapon(var_00) {
  if(scripts\engine\utility::is_true(var_0.in_afterlife_arcade)) {
    return;
  }
  var_01 = var_00 getcurrentweapon();
  var_02 = 0;

  if(var_01 == "none")
    var_02 = 1;
  else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_01))
    var_02 = 1;
  else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_01)))
    var_02 = 1;
  else if(scripts\cp\utility::is_melee_weapon(var_01, 1))
    var_02 = 1;

  if(var_02) {
    var_0.copy_fullweaponlist = var_00 getweaponslistall();
    var_01 = var_00 scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  var_0.copy_fullweaponlist = undefined;

  if(isDefined(var_01))
    return var_01;
  else
    return var_00 getcurrentweapon();
}

give_player_back_weapon(var_00) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_00)) {
    return;
  }
  if(isDefined(var_0.pre_arcade_game_weapon)) {
    if(var_00 hasweapon(var_0.pre_arcade_game_weapon))
      var_00 switchtoweapon(var_0.pre_arcade_game_weapon);
  } else {
    var_01 = var_00 getweaponslistprimaries();

    if(isDefined(var_1[1]))
      var_00 switchtoweapon(var_1[1]);
  }

  var_0.pre_arcade_game_weapon_clip = undefined;
  var_0.pre_arcade_game_weapon_stock = undefined;
  var_0.pre_arcade_game_weapon = undefined;
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
  self giveuponsuppressiontime("super_default_zm");
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

set_arcade_game_award_type(var_00) {
  if(scripts\engine\utility::is_true(var_0.in_afterlife_arcade))
    var_0.arcade_game_award_type = "soul_power";
  else
    var_0.arcade_game_award_type = "tickets";
}

update_song_playing(var_00, var_01) {
  var_0.song_playing = 1;
  var_02 = lookupsoundlength(var_01);
  wait(var_02 / 1000);
  var_0.song_playing = 0;
}