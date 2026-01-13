/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_racing.gsc
*****************************************************/

init_all_race_games() {
  scripts\engine\utility::flag_init("arcade_race_pregame");
  scripts\engine\utility::flag_init("afterlife_race_pregame");
  var_0 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_1 = 2;
  var_2 = 3;
  foreach(var_4 in var_0) {
    var_4 thread func_9701(var_0);
  }

  level thread func_5555(var_1, var_2);
  level.var_DBB4 = ["iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green"];
}

func_9701(var_0) {
  var_1 = getEntArray(self.target, "targetname");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "horse") {
      self.horse = var_3;
      continue;
    }

    if(var_3.classname == "script_model") {
      self.var_870F = var_3;
      continue;
    }

    if(var_3.classname == "trigger_damage") {
      self.var_325F = var_3;
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var_3.classname, "scriptable")) {
      self.fx = var_3;
    }
  }

  self.horse.og_origin = self.horse.origin;
  self.var_870F.og_origin = self.var_870F.origin;
  self.var_870F.og_angles = self.var_870F.angles;
  if(scripts\cp\cp_interaction::func_9A3A(self) && !isDefined(level.var_DBB8)) {
    thread func_DBB7(var_0);
  }
}

func_DBB7(var_0) {
  level.var_DBB8 = 1;
  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    if(var_1 != "power_off") {
      setomnvar("zombie_arcade_race_power", 1);
      foreach(var_3 in var_0) {
        var_3.powered_on = 1;
      }

      var_5 = getent("arcade_zz_neon_light", "targetname");
      var_5 setModel("zmb_theater_sign_05");
      continue;
    }

    setomnvar("zombie_arcade_race_power", 0);
    foreach(var_3 in var_0) {
      var_3.powered_on = 0;
    }
  }
}

use_race_game(var_0, var_1) {
  if(var_1 getstance() != "stand") {
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_MUST_BE_STANDING");
    return;
  }

  var_1 notify("cancel_sentry");
  var_1 notify("cancel_medusa");
  var_1 notify("cancel_trap");
  var_1 notify("cancel_boombox");
  var_1 notify("cancel_revocator");
  var_1 notify("cancel_ims");
  var_1 notify("cancel_gascan");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    while(var_1 getcurrentprimaryweapon() == "none" || var_1 isswitchingweapon()) {
      wait(0.1);
    }
  }

  var_1 notify("cancel_sentry");
  var_1 notify("cancel_medusa");
  var_1 notify("cancel_trap");
  var_1 notify("cancel_boombox");
  var_1 notify("cancel_revocator");
  var_1 notify("cancel_ims");
  var_1 notify("cancel_gascan");
  level.wave_num_at_start_of_game = level.wave_num;
  var_1 playlocalsound("arcade_insert_coin_02");
  scripts\engine\utility::delaythread(0.2, scripts\engine\utility::play_sound_in_space, "arcade_horserace_gunshot", var_1.origin);
  if(var_0.script_location == "arcade") {
    if(!scripts\engine\utility::flag("arcade_race_pregame")) {
      scripts\engine\utility::flag_set("arcade_race_pregame");
      level notify("race_used");
      level thread func_DBB2("arcade", var_0);
    }

    level thread func_D24B(var_1, var_0, "arcade");
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("game_race", var_1);
    return;
  }

  if(var_0.script_location == "afterlife") {
    if(!scripts\engine\utility::flag("afterlife_race_pregame")) {
      scripts\engine\utility::flag_set("afterlife_race_pregame");
      level thread func_DBB2("afterlife", var_0);
    }

    level thread func_D24B(var_1, var_0, "afterlife");
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("game_race", var_1);
  }
}

func_E1F4(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_3 = [];
  foreach(var_5 in var_2) {
    if(var_5.script_location == var_0) {
      var_3[var_3.size] = var_5;
    }
  }

  foreach(var_5 in var_3) {
    if(var_0 == "afterlife") {
      var_5.horse moveto(var_5.horse.og_origin + (-0.25, 0, 0), 1);
      continue;
    }

    var_5.horse moveto(var_5.horse.og_origin + (0, 0.25, 0), 1);
  }

  if(var_1.origin != var_1.og_origin) {
    thread scripts\engine\utility::play_sound_in_space("arcade_horserace_reset", var_1.origin);
  }

  var_1 moveto(var_1.og_origin, 1);
}

func_DBB2(var_0, var_1) {
  var_2 = getEntArray("pace_horse", "script_noteworthy");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, var_2, 500);
  if(!isDefined(var_3.og_origin)) {
    var_3.og_origin = var_3.origin;
  }

  level thread func_E1F4(var_0, var_3);
  wait(1);
  level thread func_E1EE(var_0);
  for(var_4 = 3; var_4 > 0; var_4--) {
    setomnvar("zombie_" + var_0 + "_race_countdown", var_4);
    wait(1);
  }

  setomnvar("zombie_" + var_0 + "_race_countdown", -1);
  var_5 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  foreach(var_7 in var_5) {
    if(var_7.script_location != var_0) {
      continue;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_7);
  }

  thread func_FBEB(var_1);
  level notify(var_0 + "race_starting");
  switch (var_3.script_parameters) {
    case "x":
      var_3 movex(120, 10);
      break;

    case "-x":
      var_3 movex(-120, 10);
      break;

    case "y":
      var_3 movey(120, 10);
      break;

    case "-y":
      var_3 movey(-120, 10);
      break;
  }

  wait(1);
  setomnvar("zombie_" + var_0 + "_race_countdown", 0);
  wait(9.1);
  level notify(var_0 + "_pace_horse_finished");
  scripts\engine\utility::flag_clear(var_0 + "_race_pregame");
  thread func_FBEA(var_1);
  wait(3);
  var_5 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  foreach(var_7 in var_5) {
    if(var_7.script_location != var_0) {
      continue;
    }

    var_7.var_870F show();
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_7);
  }
}

func_E1EE(var_0) {
  var_1 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_2 = [];
  foreach(var_4 in var_1) {
    if(var_4.script_location == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_2) {
    var_4.fx setscriptablepartstate("game_light", "off");
    var_4.fx setscriptablepartstate("light_fx", "off");
    scripts\engine\utility::waitframe();
  }
}

func_D24B(var_0, var_1, var_2) {
  var_3 = undefined;
  var_0.pre_arcade_game_weapon = var_0 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(var_0);
  var_0 setclientomnvar("zombie_arcade_game_time", 1);
  var_0 setclientomnvar("zombie_zz_widget", 1);
  scripts\engine\utility::waitframe();
  var_1.destroynavrepulsor = 0;
  var_1.var_870F hide();
  var_4 = strtok(var_1.var_870F.model, "_");
  var_5 = var_4[var_4.size - 1];
  foreach(var_7 in level.var_DBB4) {
    var_8 = strtok(var_7, "_");
    if(var_8[var_8.size - 1] == var_5) {
      var_3 = var_7;
      break;
    }
  }

  var_0 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  var_0 giveweapon(var_3);
  var_0 switchtoweapon(var_3);
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_0 scripts\engine\utility::allow_usability(0);
  var_0 thread func_DBB5(var_0, var_1, var_3, ::func_E219);
  var_0 thread func_DBB6(var_0, var_1, var_3, ::func_E219);
  var_0 scripts\cp\utility::allow_player_interactions(0);
  var_0 thread func_DBB1(var_1, var_0, var_2, var_3);
  var_0 thread func_D2D9(var_1, var_2, var_3);
  var_0 thread func_D047(var_1, var_2, var_3);
}

func_D2D9(var_0, var_1, var_2) {
  self endon("too_far_from_game");
  level waittill(var_1 + "race_starting");
  var_0.var_325F setCanDamage(1);
  var_0.var_325F.health = 999999;
  var_3 = gettime();
  self.var_4B87 = var_0;
  level endon(var_1 + "_pace_horse_finished");
  if(isDefined(level.start_zombie_zoom_func)) {
    var_0 thread[[level.start_zombie_zoom_func]](var_0, self);
  }

  for(;;) {
    var_0.var_325F waittill("damage", var_4, var_5);
    var_0.var_325F.health = 999999;
    if(var_5 != self) {
      continue;
    }

    var_6 = var_5 getcurrentweapon();
    if(var_6 != var_2) {
      continue;
    }

    switch (var_0.horse.script_parameters) {
      case "x":
        var_0.horse movex(2.2, 0.1);
        break;

      case "-x":
        var_0.horse movex(-2.2, 0.1);
        break;

      case "y":
        var_0.horse movey(2.2, 0.1);
        break;

      case "-y":
        var_0.horse movey(-2.2, 0.1);
        break;
    }

    if(distance2d(var_0.horse.og_origin, var_0.horse.origin) + 2 >= 120) {
      var_0.fx setscriptablepartstate("game_light", "on");
      var_0.fx setscriptablepartstate("light_fx", "on");
      var_7 = var_1 == "afterlife";
      if(!var_7) {
        level notify("update_arcade_game_performance", "zombie_zoom", gettime() - var_3);
      }

      setmlgspectator(self, var_7, 100);
      return;
    }
  }
}

func_D047(var_0, var_1, var_2) {
  self endon("arcade_game_over_for_player");
  self endon("last_stand");
  self endon("spawned");
  self endon("disconnect");
  level waittill(var_1 + "_pace_horse_finished");
  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
  }

  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_zz_widget", 0);
  self takeweapon(var_2);
  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  scripts\engine\utility::allow_weapon_switch(1);
  scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(self);
  scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  self notify("arcade_game_over_for_player");
}

func_DBB1(var_0, var_1, var_2, var_3) {
  level endon(var_2 + "_pace_horse_finished");
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("disconnect");
  for(;;) {
    var_1 setweaponammoclip(var_3, 10);
    wait(0.1);
  }
}

func_E219(var_0, var_1) {
  var_1 setclientomnvar("zombie_arcade_game_time", -1);
  var_1 setclientomnvar("zombie_zz_widget", 0);
  wait(3);
  if(!var_1 scripts\cp\utility::areinteractionsenabled()) {
    var_1 scripts\cp\utility::allow_player_interactions(1);
  }
}

func_FF2B(var_0, var_1) {
  if(var_1 && !scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 0;
  }

  return 1;
}

setmlgspectator(var_0, var_1, var_2) {
  if(var_1) {
    if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_0, level.wave_num_at_start_of_game, self.var_4B87.name, 1, var_2, var_0.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][self.var_4B87.name]);
      var_0 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_0, var_2);
      return;
    }

    return;
  }

  scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_0, level.wave_num_at_start_of_game, self.var_4B87.name, 0, var_2, var_0.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][self.var_4B87.name]);
  var_0 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_0, var_2);
}

get_intro_message(var_0) {
  return "Shoot the center of the target!";
}

race_game_hint_logic(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(var_0.script_location == "afterlife") {
    var_0.cost = 0;
    return &"COOP_INTERACTIONS_PLAY_GAME";
  }

  if(scripts\engine\utility::istrue(var_0.out_of_order)) {
    return &"CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

func_FBEB(var_0) {
  var_1 = scripts\engine\utility::getstructarray("zombiezoom_sound", "targetname");
  if(var_1.size > 0) {
    var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1);
    if(var_0.script_location == "arcade" && !isDefined(level.var_2118)) {
      level.var_2118 = spawn("script_origin", var_2.origin);
    } else if(var_0.script_location != "arcade" && !isDefined(level.var_18E6)) {
      level.var_18E6 = spawn("script_origin", var_2.origin);
    }

    playsoundatpos(var_2.origin, "arcade_horserace_bell_start");
    wait(0.2);
    playsoundatpos(var_2.origin, "mus_arcade_horserace_bugle");
    wait(0.1);
  }

  if(var_0.script_location == "arcade") {
    level.var_2118 playLoopSound("arcade_horserace_crowd_lp");
    return;
  }

  level.var_18E6 playLoopSound("arcade_horserace_crowd_lp");
}

func_FBEA(var_0) {
  if(var_0.script_location == "arcade") {
    level.var_2118 stoploopsound();
  } else {
    level.var_18E6 stoploopsound();
  }

  thread scripts\engine\utility::play_sound_in_space("arcade_horserace_bell_end", var_0.origin);
}

func_DBB5(var_0, var_1, var_2, var_3) {
  var_0 endon("arcade_game_over_for_player");
  var_4 = var_0 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "spawned");
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

  var_0 notify("arcade_game_over_for_player");
}

func_DBB6(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("arcade_game_over_for_player");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_0 endon("spawned");
  var_5 = 576;
  for(;;) {
    wait(0.1);
    if(distancesquared(var_0.origin, var_1.origin) > var_5) {
      var_0 playlocalsound("purchase_deny");
      wait(1);
      if(distancesquared(var_0.origin, var_1.origin) > var_5) {
        if(isDefined(var_2)) {
          var_0 takeweapon(var_2);
        }

        [[var_3]](var_1, var_0);
        var_1.active_player = undefined;
        var_0 scripts\engine\utility::allow_weapon_switch(1);
        if(!var_0 scripts\engine\utility::isusabilityallowed()) {
          var_0 scripts\engine\utility::allow_usability(1);
        }

        var_0 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_0);
        var_0 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
        var_0 notify("too_far_from_game");
        var_0 notify("arcade_game_over_for_player");
      }
    }
  }
}

func_5555(var_0, var_1) {
  level.var_2119 = 0;
  var_2 = randomintrange(var_0, var_1);
  for(;;) {
    level waittill("race_used");
    level.var_2119++;
    if(level.var_2119 == var_2) {
      var_2 = randomintrange(var_0, var_1);
      var_3 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
      foreach(var_5 in var_3) {
        if(var_5.script_location != "arcade") {
          continue;
        }

        var_5.out_of_order = 1;
      }

      level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
      level.var_2119 = 0;
      foreach(var_5 in var_3) {
        if(var_5.script_location != "arcade") {
          continue;
        }

        foreach(var_9 in level.players) {
          if(isDefined(var_9.last_interaction_point) && var_9.last_interaction_point == var_5) {
            var_9 thread scripts\cp\cp_interaction::refresh_interaction();
          }
        }

        var_5.out_of_order = 0;
      }
    }
  }
}