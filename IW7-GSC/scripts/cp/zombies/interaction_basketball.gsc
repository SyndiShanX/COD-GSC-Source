/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_basketball.gsc
*********************************************************/

init_basketball_game() {
  var_00 = scripts\engine\utility::getstructarray("basketball_game", "script_noteworthy");
  var_01 = 4;
  var_02 = 7;
  foreach(var_04 in var_00) {
    var_04 thread setup_basketball_game();
    var_04 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_01, var_02);
    wait(0.05);
  }
}

init_afterlife_basketball_game() {
  var_00 = scripts\engine\utility::getstructarray("basketball_game_afterlife", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread setup_basketball_game();
    wait(0.05);
  }
}

setup_basketball_game() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_01 = getEntArray(self.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.classname == "light_spot") {
      self.setminimap = var_03;
      break;
    }
  }

  var_05 = getEntArray(self.target, "targetname");
  foreach(var_03 in var_05) {
    if(!isDefined(var_03.script_noteworthy)) {
      continue;
    }

    switch (var_03.script_noteworthy) {
      case "hoop_trig":
        self.hoop_trig = var_03;
        break;

      case "hoop":
        self.hoop = var_03;
        break;

      case "hoop_clip":
        self.hoop_clip = var_03;
        break;

      case "rim":
        self.rim = var_03;
        break;

      case "bball_sound_ent":
        self.music_ent = var_03;
        break;
    }
  }

  self.hoop_trig enablelinkto();
  self.hoop_trig linkto(self.hoop);
  self.hoop_clip linkto(self.hoop);
  self.rim linkto(self.hoop);
  self.bball_game_hiscore = 0;
  self.hoop thread move_hoop(self, var_00);
  for(;;) {
    var_08 = "power_on";
    if(var_00) {
      var_08 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_08 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_08 != "power_off") {
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

    if(!var_00) {
      break;
    }
  }
}

move_hoop(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    level scripts\engine\utility::waittill_any_3("power_on", param_00.power_area + " power_on");
  }

  wait(randomintrange(1, 4));
  var_02 = self.origin;
  var_03 = scripts\engine\utility::getstructarray(self.target, "targetname");
  for(;;) {
    if(scripts\engine\utility::istrue(param_01) && param_00.powered_on == 0) {
      self moveto(var_02, 2);
      level scripts\engine\utility::waittill_any_3("power_on", param_00.power_area + " power_on");
    }

    self moveto(var_03[0].origin, 4);
    self waittill("movedone");
    self moveto(var_03[1].origin, 4);
    self waittill("movedone");
  }
}

use_basketball_game(param_00, param_01) {
  param_01 endon("disconnect");
  if(param_01 getstance() != "stand") {
    param_01 scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_MUST_BE_STANDING");
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  param_01 notify("cancel_sentry");
  param_01 notify("cancel_medusa");
  param_01 notify("cancel_trap");
  param_01 notify("cancel_boombox");
  param_01 notify("cancel_revocator");
  param_01 notify("cancel_ims");
  param_01 notify("cancel_gascan");
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(param_01);
  param_01.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00 notify("machine_used");
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("basketball_game", param_01);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("basketball_game_afterlife", param_01);
  }

  param_01 playlocalsound("arcade_insert_coin_01");
  playsoundatpos(param_00.music_ent.origin, "basketball_anc_activate");
  if(!isDefined(param_00.basketball_game_music)) {
    if(isDefined(param_00.music_ent)) {
      param_00.basketball_game_music = param_00.music_ent;
    } else {
      param_00.basketball_game_music = spawn("script_origin", param_00.origin);
    }
  }

  playsoundatpos(param_00.basketball_game_music.origin, "mus_arcade_basketball_charge");
  param_00.basketball_game_music scripts\engine\utility::delaycall(2, ::playloopsound, "mus_arcade_basketball_game_lp");
  var_02 = undefined;
  switch (param_00.script_location) {
    case "zombie_bball_game_1_is_active":
      var_02 = 1;
      break;

    case "zombie_bball_game_2_is_active":
      var_02 = 2;
      break;

    case "zombie_bball_game_3_is_active":
      var_02 = 3;
      break;
  }

  param_01 thread play_basketball_game(param_00, var_02);
}

basketball_reset_player_omnvar(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 setclientomnvar("zombie_arcade_game_time", -1);
  param_01 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  param_01 setclientomnvar("zombie_bball_widget", 0);
  param_01.playing_game = undefined;
  if(!param_01 scripts\cp\utility::areinteractionsenabled()) {
    param_01 scripts\cp\utility::allow_player_interactions(1);
  }
}

play_basketball_game(param_00, param_01) {
  self notify("arcade_game_over_for_player");
  self endon("arcade_game_over_for_player");
  self endon("spawned");
  self endon("disconnect");
  if(isDefined(level.start_rings_of_saturn_func)) {
    param_00 thread[[level.start_rings_of_saturn_func]](param_00, self);
  }

  param_00.bball_game_score = 0;
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
  self setclientomnvar("zombie_bball_game_" + param_01 + "_time", 15);
  self setclientomnvar("zombie_arcade_game_time", 1);
  self setclientomnvar("zombie_bball_widget", 1);
  scripts\cp\utility::allow_player_interactions(0);
  level thread basketball_game_timer(self, param_01);
  level thread func_28BA(self, param_00, param_01);
  thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_disconnect_or_death(self, param_00, "iw7_cpbasketball_mp", ::basketball_reset_player_omnvar);
  thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_gets_too_far_away(self, param_00, "iw7_cpbasketball_mp", ::basketball_reset_player_omnvar, "mus_arcade_basketball_game_end", undefined, param_01);
  for(;;) {
    self giveweapon("iw7_cpbasketball_mp");
    self switchtoweapon("iw7_cpbasketball_mp");
    watch_basketball_throw(param_00, param_01);
  }
}

get_intro_message(param_00) {
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    return "Score ^3 15 ^7 soul power per basket";
  }

  return "Win 15 tickets per basket!";
}

func_28BA(param_00, param_01, param_02) {
  param_00 notify("basketball_game");
  param_00 endon("basketball_game");
  param_00 endon("disconnect");
  param_00 endon("spawned");
  wait(1);
  param_00 setclientomnvar("zombie_bball_game_" + param_02 + "_score", 0);
  param_00 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  param_00 scripts\engine\utility::waittill_any_3("bball_timer_expired");
  param_01.basketball_game_music scripts\engine\utility::delaycall(1, ::stoploopsound);
  param_01.basketball_game_music scripts\engine\utility::delaycall(1, ::playsound, "mus_arcade_basketball_game_end");
  param_00 setclientomnvar("zombie_arcade_game_time", -1);
  param_00 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  param_00 setclientomnvar("zombie_bball_widget", 0);
  param_00.playing_game = undefined;
  param_01.timer_active = undefined;
  param_00 takeweapon("iw7_cpbasketball_mp");
  param_00 scripts\engine\utility::allow_weapon_switch(1);
  if(!param_00 scripts\engine\utility::isusabilityallowed()) {
    param_00 scripts\engine\utility::allow_usability(1);
  }

  param_00 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(param_00);
  param_00 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  param_00 notify("arcade_game_over_for_player");
  if(param_01.bball_game_score >= 1) {
    var_03 = param_01.bball_game_score * 15;
    if(param_00.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_00, level.wave_num_at_start_of_game, param_01.name, 1, var_03, param_00.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["basketball_game_afterlife"]);
    } else {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_00, level.wave_num_at_start_of_game, param_01.name, 0, var_03, param_00.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["basketball_game"]);
      param_00 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_00, param_01.bball_game_score * 15);
    }
  }

  if(param_01.bball_game_score * 15 > param_01.bball_game_hiscore) {
    playsoundatpos(param_01.music_ent.origin, "basketball_anc_highscore");
    setomnvar("zombie_bball_game_" + param_02 + "_hiscore", param_01.bball_game_score * 15);
    param_01.bball_game_hiscore = param_01.bball_game_score * 15;
  }

  wait(2);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
  if(!param_00 scripts\cp\utility::areinteractionsenabled()) {
    param_00 scripts\cp\utility::allow_player_interactions(1);
  }
}

basketball_game_timer(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("death");
  param_00 endon("arcade_game_over_for_player");
  for(var_02 = 15; var_02 > -1; var_02--) {
    wait(1);
    param_00 setclientomnvar("zombie_bball_game_" + param_01 + "_time", var_02);
  }

  param_00 notify("bball_timer_expired");
}

watch_basketball_throw(param_00, param_01) {
  self endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("grenade_pullback", var_02);
    if(var_02 != "iw7_cpbasketball_mp") {
      continue;
    }

    self notify("ready_to_throw_next_basketball");
    var_03 = anglesToForward(self getplayerangles());
    var_04["position"] = self getEye() + (0, 0, 5) + var_03 * 10;
    var_05 = spawn("script_model", var_04["position"]);
    var_05 hide();
    var_07 = gettime();
    self waittill("grenade_fire", var_08, var_02);
    var_08 delete();
    var_09 = gettime() - var_07 / 1000;
    if(var_09 < 0.2) {
      wait(0.2 - var_09);
    }

    thread throw_basketball(param_00, var_05, param_01);
    self takeweapon("iw7_cpbasketball_mp");
    wait(0.25);
  }
}

throw_basketball(param_00, param_01, param_02) {
  var_03 = anglesToForward(self getplayerangles());
  var_04 = self getEye() + (0, 0, 5) + var_03 * 10;
  param_01.origin = var_04;
  param_01 setModel("decor_basketball_zmb");
  param_01 show();
  var_05 = 450;
  var_06 = 0.75;
  param_01 physicslaunchserver(var_04, var_03 + (0, 0, var_06) * var_05);
  param_01 thread scripts\cp\utility::register_physics_collisions();
  param_01 physics_registerforcollisioncallback();
  scripts\cp\utility::register_physics_collision_func(param_01, ::basketball_impact_sounds);
  param_01 thread watch_basketball_landing(param_00, self, param_02);
  wait(5);
  if(isDefined(param_01)) {
    param_01 delete();
  }
}

watch_basketball_landing(param_00, param_01, param_02) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("death");
  self endon("death");
  param_01 notify("throw_a_basketball");
  for(;;) {
    if(self istouching(param_00.hoop_trig)) {
      break;
    }

    wait(0.05);
  }

  param_01 notify("score_a_basket");
  param_00.hoop_trig playSound("arcade_basketball_basket_point");
  param_00.bball_game_score++;
  playsoundatpos(param_00.music_ent.origin, "basketball_anc_quickshot");
  if(param_00.bball_game_score * 15 > level.var_28BF) {
    level.var_28BF = param_00.bball_game_score * 15;
  }

  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    param_01 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_01, 15);
  }

  param_01 setclientomnvar("zombie_arcade_game_ticket_earned", param_00.bball_game_score * 15);
  param_01 setclientomnvar("zombie_bball_game_" + param_02 + "_score", param_00.bball_game_score * 15);
  wait(3);
  self delete();
}

basketball_impact_sounds(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(param_00.playing_sound)) {
    return;
  }

  param_00 endon("death");
  param_00.playing_sound = 1;
  var_09 = "arcade_basketball_bounce";
  if(isDefined(param_08) && isDefined(param_08.script_noteworthy) && param_08.script_noteworthy == "rim") {
    var_09 = "arcade_basketball_rim";
  } else if(isDefined(param_08) && isDefined(param_08.script_noteworthy) && param_08.script_noteworthy == "hoop_clip") {
    var_09 = "arcade_basketball_backboard";
  }

  param_00 playSound(var_09);
  wait(lookupsoundlength(var_09) / 1000);
  param_00.playing_sound = undefined;
}