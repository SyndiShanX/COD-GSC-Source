/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_basketball.gsc
*********************************************************/

init_basketball_game() {
  var_0 = scripts\engine\utility::getstructarray("basketball_game", "script_noteworthy");
  var_1 = 4;
  var_2 = 7;
  foreach(var_4 in var_0) {
    var_4 thread setup_basketball_game();
    var_4 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_1, var_2);
    wait(0.05);
  }
}

init_afterlife_basketball_game() {
  var_0 = scripts\engine\utility::getstructarray("basketball_game_afterlife", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread setup_basketball_game();
    wait(0.05);
  }
}

setup_basketball_game() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_1 = getEntArray(self.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.classname == "light_spot") {
      self.setminimap = var_3;
      break;
    }
  }

  var_5 = getEntArray(self.target, "targetname");
  foreach(var_3 in var_5) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }

    switch (var_3.script_noteworthy) {
      case "hoop_trig":
        self.hoop_trig = var_3;
        break;

      case "hoop":
        self.hoop = var_3;
        break;

      case "hoop_clip":
        self.hoop_clip = var_3;
        break;

      case "rim":
        self.rim = var_3;
        break;

      case "bball_sound_ent":
        self.music_ent = var_3;
        break;
    }
  }

  self.hoop_trig enablelinkto();
  self.hoop_trig linkto(self.hoop);
  self.hoop_clip linkto(self.hoop);
  self.rim linkto(self.hoop);
  self.bball_game_hiscore = 0;
  self.hoop thread move_hoop(self, var_0);
  for(;;) {
    var_8 = "power_on";
    if(var_0) {
      var_8 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_8 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_8 != "power_off") {
      self.powered_on = 1;
      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(100);
      }
    } else {
      self.powered_on = 0;
      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(0);
      }
    }

    if(!var_0) {
      break;
    }
  }
}

move_hoop(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    level scripts\engine\utility::waittill_any("power_on", var_0.power_area + " power_on");
  }

  wait(randomintrange(1, 4));
  var_2 = self.origin;
  var_3 = scripts\engine\utility::getstructarray(self.target, "targetname");
  for(;;) {
    if(scripts\engine\utility::istrue(var_1) && var_0.powered_on == 0) {
      self moveto(var_2, 2);
      level scripts\engine\utility::waittill_any("power_on", var_0.power_area + " power_on");
    }

    self moveto(var_3[0].origin, 4);
    self waittill("movedone");
    self moveto(var_3[1].origin, 4);
    self waittill("movedone");
  }
}

use_basketball_game(var_0, var_1) {
  var_1 endon("disconnect");
  if(var_1 getstance() != "stand") {
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_MUST_BE_STANDING");
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_1 notify("cancel_sentry");
  var_1 notify("cancel_medusa");
  var_1 notify("cancel_trap");
  var_1 notify("cancel_boombox");
  var_1 notify("cancel_revocator");
  var_1 notify("cancel_ims");
  var_1 notify("cancel_gascan");
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(var_1);
  var_1.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0 notify("machine_used");
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("basketball_game", var_1);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("basketball_game_afterlife", var_1);
  }

  var_1 playlocalsound("arcade_insert_coin_01");
  playsoundatpos(var_0.music_ent.origin, "basketball_anc_activate");
  if(!isDefined(var_0.basketball_game_music)) {
    if(isDefined(var_0.music_ent)) {
      var_0.basketball_game_music = var_0.music_ent;
    } else {
      var_0.basketball_game_music = spawn("script_origin", var_0.origin);
    }
  }

  playsoundatpos(var_0.basketball_game_music.origin, "mus_arcade_basketball_charge");
  var_0.basketball_game_music scripts\engine\utility::delaycall(2, ::playloopsound, "mus_arcade_basketball_game_lp");
  var_2 = undefined;
  switch (var_0.script_location) {
    case "zombie_bball_game_1_is_active":
      var_2 = 1;
      break;

    case "zombie_bball_game_2_is_active":
      var_2 = 2;
      break;

    case "zombie_bball_game_3_is_active":
      var_2 = 3;
      break;
  }

  var_1 thread play_basketball_game(var_0, var_2);
}

basketball_reset_player_omnvar(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 setclientomnvar("zombie_arcade_game_time", -1);
  var_1 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  var_1 setclientomnvar("zombie_bball_widget", 0);
  var_1.playing_game = undefined;
  if(!var_1 scripts\cp\utility::areinteractionsenabled()) {
    var_1 scripts\cp\utility::allow_player_interactions(1);
  }
}

play_basketball_game(var_0, var_1) {
  self notify("arcade_game_over_for_player");
  self endon("arcade_game_over_for_player");
  self endon("spawned");
  self endon("disconnect");
  if(isDefined(level.start_rings_of_saturn_func)) {
    var_0 thread[[level.start_rings_of_saturn_func]](var_0, self);
  }

  var_0.bball_game_score = 0;
  if(!scripts\engine\utility::istrue(self.in_afterlife_arcade)) {
    while(self getcurrentprimaryweapon() == "none" || self isswitchingweapon()) {
      wait(0.1);
    }
  }

  self notify("cancel_sentry");
  self notify("cancel_medusa");
  self notify("cancel_trap");
  self notify("cancel_boombox");
  self notify("cancel_revocator");
  self notify("cancel_ims");
  self notify("cancel_gascan");
  self.pre_arcade_game_weapon = scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(self);
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
  scripts\engine\utility::allow_usability(0);
  self setclientomnvar("zombie_bball_game_" + var_1 + "_time", 15);
  self setclientomnvar("zombie_arcade_game_time", 1);
  self setclientomnvar("zombie_bball_widget", 1);
  scripts\cp\utility::allow_player_interactions(0);
  level thread basketball_game_timer(self, var_1);
  level thread func_28BA(self, var_0, var_1);
  thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_disconnect_or_death(self, var_0, "iw7_cpbasketball_mp", ::basketball_reset_player_omnvar);
  thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_gets_too_far_away(self, var_0, "iw7_cpbasketball_mp", ::basketball_reset_player_omnvar, "mus_arcade_basketball_game_end", undefined, var_1);
  for(;;) {
    self giveweapon("iw7_cpbasketball_mp");
    self switchtoweapon("iw7_cpbasketball_mp");
    watch_basketball_throw(var_0, var_1);
  }
}

get_intro_message(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return "Score ^3 15 ^7 soul power per basket";
  }

  return "Win 15 tickets per basket!";
}

func_28BA(var_0, var_1, var_2) {
  var_0 notify("basketball_game");
  var_0 endon("basketball_game");
  var_0 endon("disconnect");
  var_0 endon("spawned");
  wait(1);
  var_0 setclientomnvar("zombie_bball_game_" + var_2 + "_score", 0);
  var_0 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  var_0 scripts\engine\utility::waittill_any("bball_timer_expired");
  var_1.basketball_game_music scripts\engine\utility::delaycall(1, ::stoploopsound);
  var_1.basketball_game_music scripts\engine\utility::delaycall(1, ::playsound, "mus_arcade_basketball_game_end");
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  var_0 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  var_0 setclientomnvar("zombie_bball_widget", 0);
  var_0.playing_game = undefined;
  var_1.timer_active = undefined;
  var_0 takeweapon("iw7_cpbasketball_mp");
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  if(!var_0 scripts\engine\utility::isusabilityallowed()) {
    var_0 scripts\engine\utility::allow_usability(1);
  }

  var_0 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_0);
  var_0 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  var_0 notify("arcade_game_over_for_player");
  if(var_1.bball_game_score >= 1) {
    var_3 = var_1.bball_game_score * 15;
    if(var_0.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_0, level.wave_num_at_start_of_game, var_1.name, 1, var_3, var_0.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["basketball_game_afterlife"]);
    } else {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_0, level.wave_num_at_start_of_game, var_1.name, 0, var_3, var_0.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["basketball_game"]);
      var_0 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_0, var_1.bball_game_score * 15);
    }
  }

  if(var_1.bball_game_score * 15 > var_1.bball_game_hiscore) {
    playsoundatpos(var_1.music_ent.origin, "basketball_anc_highscore");
    setomnvar("zombie_bball_game_" + var_2 + "_hiscore", var_1.bball_game_score * 15);
    var_1.bball_game_hiscore = var_1.bball_game_score * 15;
  }

  wait(2);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
    var_0 scripts\cp\utility::allow_player_interactions(1);
  }
}

basketball_game_timer(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("arcade_game_over_for_player");
  for(var_2 = 15; var_2 > -1; var_2--) {
    wait(1);
    var_0 setclientomnvar("zombie_bball_game_" + var_1 + "_time", var_2);
  }

  var_0 notify("bball_timer_expired");
}

watch_basketball_throw(var_0, var_1) {
  self endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("grenade_pullback", var_2);
    if(var_2 != "iw7_cpbasketball_mp") {
      continue;
    }

    self notify("ready_to_throw_next_basketball");
    var_3 = anglesToForward(self getplayerangles());
    var_4["position"] = self getEye() + (0, 0, 5) + var_3 * 10;
    var_5 = spawn("script_model", var_4["position"]);
    var_5 hide();
    var_7 = gettime();
    self waittill("grenade_fire", var_8, var_2);
    var_8 delete();
    var_9 = gettime() - var_7 / 1000;
    if(var_9 < 0.2) {
      wait(0.2 - var_9);
    }

    thread throw_basketball(var_0, var_5, var_1);
    self takeweapon("iw7_cpbasketball_mp");
    wait(0.25);
  }
}

throw_basketball(var_0, var_1, var_2) {
  var_3 = anglesToForward(self getplayerangles());
  var_4 = self getEye() + (0, 0, 5) + var_3 * 10;
  var_1.origin = var_4;
  var_1 setModel("decor_basketball_zmb");
  var_1 show();
  var_5 = 450;
  var_6 = 0.75;
  var_1 physicslaunchserver(var_4, var_3 + (0, 0, var_6) * var_5);
  var_1 thread scripts\cp\utility::register_physics_collisions();
  var_1 physics_registerforcollisioncallback();
  scripts\cp\utility::register_physics_collision_func(var_1, ::basketball_impact_sounds);
  var_1 thread watch_basketball_landing(var_0, self, var_2);
  wait(5);
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

watch_basketball_landing(var_0, var_1, var_2) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("death");
  self endon("death");
  var_1 notify("throw_a_basketball");
  for(;;) {
    if(self istouching(var_0.hoop_trig)) {
      break;
    }

    wait(0.05);
  }

  var_1 notify("score_a_basket");
  var_0.hoop_trig playSound("arcade_basketball_basket_point");
  var_0.bball_game_score++;
  playsoundatpos(var_0.music_ent.origin, "basketball_anc_quickshot");
  if(var_0.bball_game_score * 15 > level.var_28BF) {
    level.var_28BF = var_0.bball_game_score * 15;
  }

  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_1 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_1, 15);
  }

  var_1 setclientomnvar("zombie_arcade_game_ticket_earned", var_0.bball_game_score * 15);
  var_1 setclientomnvar("zombie_bball_game_" + var_2 + "_score", var_0.bball_game_score * 15);
  wait(3);
  self delete();
}

basketball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_0.playing_sound)) {
    return;
  }

  var_0 endon("death");
  var_0.playing_sound = 1;
  var_9 = "arcade_basketball_bounce";
  if(isDefined(var_8) && isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "rim") {
    var_9 = "arcade_basketball_rim";
  } else if(isDefined(var_8) && isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "hoop_clip") {
    var_9 = "arcade_basketball_backboard";
  }

  var_0 playSound(var_9);
  wait(lookupsoundlength(var_9) / 1000);
  var_0.playing_sound = undefined;
}