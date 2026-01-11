/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_racing.gsc
*****************************************************/

init_all_race_games() {
  scripts\engine\utility::flag_init("arcade_race_pregame");
  scripts\engine\utility::flag_init("afterlife_race_pregame");
  var_00 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_01 = 2;
  var_02 = 3;
  foreach(var_04 in var_00) {
    var_04 thread func_9701(var_00);
  }

  level thread func_5555(var_01, var_02);
  level.var_DBB4 = ["iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green"];
}

func_9701(param_00) {
  var_01 = getEntArray(self.target, "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "horse") {
      self.horse = var_03;
      continue;
    }

    if(var_03.classname == "script_model") {
      self.var_870F = var_03;
      continue;
    }

    if(var_03.classname == "trigger_damage") {
      self.var_325F = var_03;
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var_03.classname, "scriptable")) {
      self.fx = var_03;
    }
  }

  self.horse.og_origin = self.horse.origin;
  self.var_870F.og_origin = self.var_870F.origin;
  self.var_870F.og_angles = self.var_870F.angles;
  if(scripts\cp\cp_interaction::func_9A3A(self) && !isDefined(level.var_DBB8)) {
    thread func_DBB7(param_00);
  }
}

func_DBB7(param_00) {
  level.var_DBB8 = 1;
  for(;;) {
    var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    if(var_01 != "power_off") {
      setomnvar("zombie_arcade_race_power", 1);
      foreach(var_03 in param_00) {
        var_03.powered_on = 1;
      }

      var_05 = getent("arcade_zz_neon_light", "targetname");
      var_05 setModel("zmb_theater_sign_05");
      continue;
    }

    setomnvar("zombie_arcade_race_power", 0);
    foreach(var_03 in param_00) {
      var_03.powered_on = 0;
    }
  }
}

use_race_game(param_00, param_01) {
  if(param_01 getstance() != "stand") {
    param_01 scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_MUST_BE_STANDING");
    return;
  }

  param_01 notify("cancel_sentry");
  param_01 notify("cancel_medusa");
  param_01 notify("cancel_trap");
  param_01 notify("cancel_boombox");
  param_01 notify("cancel_revocator");
  param_01 notify("cancel_ims");
  param_01 notify("cancel_gascan");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    while(param_01 getcurrentprimaryweapon() == "none" || param_01 isswitchingweapon()) {
      wait(0.1);
    }
  }

  param_01 notify("cancel_sentry");
  param_01 notify("cancel_medusa");
  param_01 notify("cancel_trap");
  param_01 notify("cancel_boombox");
  param_01 notify("cancel_revocator");
  param_01 notify("cancel_ims");
  param_01 notify("cancel_gascan");
  level.wave_num_at_start_of_game = level.wave_num;
  param_01 playlocalsound("arcade_insert_coin_02");
  scripts\engine\utility::delaythread(0.2, ::scripts\engine\utility::play_sound_in_space, "arcade_horserace_gunshot", param_01.origin);
  if(param_00.script_location == "arcade") {
    if(!scripts\engine\utility::flag("arcade_race_pregame")) {
      scripts\engine\utility::flag_set("arcade_race_pregame");
      level notify("race_used");
      level thread func_DBB2("arcade", param_00);
    }

    level thread func_D24B(param_01, param_00, "arcade");
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("game_race", param_01);
    return;
  }

  if(param_00.script_location == "afterlife") {
    if(!scripts\engine\utility::flag("afterlife_race_pregame")) {
      scripts\engine\utility::flag_set("afterlife_race_pregame");
      level thread func_DBB2("afterlife", param_00);
    }

    level thread func_D24B(param_01, param_00, "afterlife");
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("game_race", param_01);
  }
}

func_E1F4(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(var_05.script_location == param_00) {
      var_03[var_03.size] = var_05;
    }
  }

  foreach(var_05 in var_03) {
    if(param_00 == "afterlife") {
      var_05.horse moveto(var_05.horse.og_origin + (-0.25, 0, 0), 1);
      continue;
    }

    var_05.horse moveto(var_05.horse.og_origin + (0, 0.25, 0), 1);
  }

  if(param_01.origin != param_01.og_origin) {
    thread scripts\engine\utility::play_sound_in_space("arcade_horserace_reset", param_01.origin);
  }

  param_01 moveto(param_01.og_origin, 1);
}

func_DBB2(param_00, param_01) {
  var_02 = getEntArray("pace_horse", "script_noteworthy");
  var_03 = scripts\engine\utility::getclosest(param_01.origin, var_02, 500);
  if(!isDefined(var_03.og_origin)) {
    var_03.og_origin = var_03.origin;
  }

  level thread func_E1F4(param_00, var_03);
  wait(1);
  level thread func_E1EE(param_00);
  for(var_04 = 3; var_04 > 0; var_04--) {
    setomnvar("zombie_" + param_00 + "_race_countdown", var_04);
    wait(1);
  }

  setomnvar("zombie_" + param_00 + "_race_countdown", -1);
  var_05 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  foreach(var_07 in var_05) {
    if(var_07.script_location != param_00) {
      continue;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_07);
  }

  thread func_FBEB(param_01);
  level notify(param_00 + "race_starting");
  switch (var_03.script_parameters) {
    case "x":
      var_03 movex(120, 10);
      break;

    case "-x":
      var_03 movex(-120, 10);
      break;

    case "y":
      var_03 movey(120, 10);
      break;

    case "-y":
      var_03 movey(-120, 10);
      break;
  }

  wait(1);
  setomnvar("zombie_" + param_00 + "_race_countdown", 0);
  wait(9.1);
  level notify(param_00 + "_pace_horse_finished");
  scripts\engine\utility::flag_clear(param_00 + "_race_pregame");
  thread func_FBEA(param_01);
  wait(3);
  var_05 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  foreach(var_07 in var_05) {
    if(var_07.script_location != param_00) {
      continue;
    }

    var_07.var_870F show();
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_07);
  }
}

func_E1EE(param_00) {
  var_01 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
  var_02 = [];
  foreach(var_04 in var_01) {
    if(var_04.script_location == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  foreach(var_04 in var_02) {
    var_04.fx setscriptablepartstate("game_light", "off");
    var_04.fx setscriptablepartstate("light_fx", "off");
    scripts\engine\utility::waitframe();
  }
}

func_D24B(param_00, param_01, param_02) {
  var_03 = undefined;
  param_00.pre_arcade_game_weapon = param_00 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(param_00);
  param_00 setclientomnvar("zombie_arcade_game_time", 1);
  param_00 setclientomnvar("zombie_zz_widget", 1);
  scripts\engine\utility::waitframe();
  param_01.destroynavrepulsor = 0;
  param_01.var_870F hide();
  var_04 = strtok(param_01.var_870F.model, "_");
  var_05 = var_04[var_04.size - 1];
  foreach(var_07 in level.var_DBB4) {
    var_08 = strtok(var_07, "_");
    if(var_08[var_08.size - 1] == var_05) {
      var_03 = var_07;
      break;
    }
  }

  param_00 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  param_00 giveweapon(var_03);
  param_00 switchtoweapon(var_03);
  param_00 scripts\engine\utility::allow_weapon_switch(0);
  param_00 scripts\engine\utility::allow_usability(0);
  param_00 thread func_DBB5(param_00, param_01, var_03, ::func_E219);
  param_00 thread func_DBB6(param_00, param_01, var_03, ::func_E219);
  param_00 scripts\cp\utility::allow_player_interactions(0);
  param_00 thread func_DBB1(param_01, param_00, param_02, var_03);
  param_00 thread func_D2D9(param_01, param_02, var_03);
  param_00 thread func_D047(param_01, param_02, var_03);
}

func_D2D9(param_00, param_01, param_02) {
  self endon("too_far_from_game");
  level waittill(param_01 + "race_starting");
  param_00.var_325F setCanDamage(1);
  param_00.var_325F.health = 999999;
  var_03 = gettime();
  self.var_4B87 = param_00;
  level endon(param_01 + "_pace_horse_finished");
  if(isDefined(level.start_zombie_zoom_func)) {
    param_00 thread[[level.start_zombie_zoom_func]](param_00, self);
  }

  for(;;) {
    param_00.var_325F waittill("damage", var_04, var_05);
    param_00.var_325F.health = 999999;
    if(var_05 != self) {
      continue;
    }

    var_06 = var_05 getcurrentweapon();
    if(var_06 != param_02) {
      continue;
    }

    switch (param_00.horse.script_parameters) {
      case "x":
        param_00.horse movex(2.2, 0.1);
        break;

      case "-x":
        param_00.horse movex(-2.2, 0.1);
        break;

      case "y":
        param_00.horse movey(2.2, 0.1);
        break;

      case "-y":
        param_00.horse movey(-2.2, 0.1);
        break;
    }

    if(distance2d(param_00.horse.og_origin, param_00.horse.origin) + 2 >= 120) {
      param_00.fx setscriptablepartstate("game_light", "on");
      param_00.fx setscriptablepartstate("light_fx", "on");
      var_07 = param_01 == "afterlife";
      if(!var_07) {
        level notify("update_arcade_game_performance", "zombie_zoom", gettime() - var_03);
      }

      setmlgspectator(self, var_07, 100);
      return;
    }
  }
}

func_D047(param_00, param_01, param_02) {
  self endon("arcade_game_over_for_player");
  self endon("last_stand");
  self endon("spawned");
  self endon("disconnect");
  level waittill(param_01 + "_pace_horse_finished");
  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
  }

  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_zz_widget", 0);
  self takeweapon(param_02);
  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  scripts\engine\utility::allow_weapon_switch(1);
  scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(self);
  scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  self notify("arcade_game_over_for_player");
}

func_DBB1(param_00, param_01, param_02, param_03) {
  level endon(param_02 + "_pace_horse_finished");
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("disconnect");
  for(;;) {
    param_01 setweaponammoclip(param_03, 10);
    wait(0.1);
  }
}

func_E219(param_00, param_01) {
  param_01 setclientomnvar("zombie_arcade_game_time", -1);
  param_01 setclientomnvar("zombie_zz_widget", 0);
  wait(3);
  if(!param_01 scripts\cp\utility::areinteractionsenabled()) {
    param_01 scripts\cp\utility::allow_player_interactions(1);
  }
}

func_FF2B(param_00, param_01) {
  if(param_01 && !scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    return 0;
  }

  return 1;
}

setmlgspectator(param_00, param_01, param_02) {
  if(param_01) {
    if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_00, level.wave_num_at_start_of_game, self.var_4B87.name, 1, param_02, param_00.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][self.var_4B87.name]);
      param_00 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_00, param_02);
      return;
    }

    return;
  }

  scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_00, level.wave_num_at_start_of_game, self.var_4B87.name, 0, param_02, param_00.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][self.var_4B87.name]);
  param_00 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_00, param_02);
}

get_intro_message(param_00) {
  return "Shoot the center of the target!";
}

race_game_hint_logic(param_00, param_01) {
  if(param_00.requires_power && !param_00.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(param_00.script_location == "afterlife") {
    param_00.cost = 0;
    return &"COOP_INTERACTIONS_PLAY_GAME";
  }

  if(scripts\engine\utility::istrue(param_00.out_of_order)) {
    return &"CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

func_FBEB(param_00) {
  var_01 = scripts\engine\utility::getstructarray("zombiezoom_sound", "targetname");
  if(var_01.size > 0) {
    var_02 = scripts\engine\utility::getclosest(param_00.origin, var_01);
    if(param_00.script_location == "arcade" && !isDefined(level.var_2118)) {
      level.var_2118 = spawn("script_origin", var_02.origin);
    } else if(param_00.script_location != "arcade" && !isDefined(level.var_18E6)) {
      level.var_18E6 = spawn("script_origin", var_02.origin);
    }

    playsoundatpos(var_02.origin, "arcade_horserace_bell_start");
    wait(0.2);
    playsoundatpos(var_02.origin, "mus_arcade_horserace_bugle");
    wait(0.1);
  }

  if(param_00.script_location == "arcade") {
    level.var_2118 playLoopSound("arcade_horserace_crowd_lp");
    return;
  }

  level.var_18E6 playLoopSound("arcade_horserace_crowd_lp");
}

func_FBEA(param_00) {
  if(param_00.script_location == "arcade") {
    level.var_2118 stoploopsound();
  } else {
    level.var_18E6 stoploopsound();
  }

  thread scripts\engine\utility::play_sound_in_space("arcade_horserace_bell_end", param_00.origin);
}

func_DBB5(param_00, param_01, param_02, param_03) {
  param_00 endon("arcade_game_over_for_player");
  var_04 = param_00 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "spawned");
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

  param_00 notify("arcade_game_over_for_player");
}

func_DBB6(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("arcade_game_over_for_player");
  param_00 endon("last_stand");
  param_00 endon("disconnect");
  param_00 endon("spawned");
  var_05 = 576;
  for(;;) {
    wait(0.1);
    if(distancesquared(param_00.origin, param_01.origin) > var_05) {
      param_00 playlocalsound("purchase_deny");
      wait(1);
      if(distancesquared(param_00.origin, param_01.origin) > var_05) {
        if(isDefined(param_02)) {
          param_00 takeweapon(param_02);
        }

        [[param_03]](param_01, param_00);
        param_01.active_player = undefined;
        param_00 scripts\engine\utility::allow_weapon_switch(1);
        if(!param_00 scripts\engine\utility::isusabilityallowed()) {
          param_00 scripts\engine\utility::allow_usability(1);
        }

        param_00 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(param_00);
        param_00 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
        param_00 notify("too_far_from_game");
        param_00 notify("arcade_game_over_for_player");
      }
    }
  }
}

func_5555(param_00, param_01) {
  level.var_2119 = 0;
  var_02 = randomintrange(param_00, param_01);
  for(;;) {
    level waittill("race_used");
    level.var_2119++;
    if(level.var_2119 == var_02) {
      var_02 = randomintrange(param_00, param_01);
      var_03 = scripts\engine\utility::getstructarray("game_race", "script_noteworthy");
      foreach(var_05 in var_03) {
        if(var_05.script_location != "arcade") {
          continue;
        }

        var_05.out_of_order = 1;
      }

      level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
      level.var_2119 = 0;
      foreach(var_05 in var_03) {
        if(var_05.script_location != "arcade") {
          continue;
        }

        foreach(var_09 in level.players) {
          if(isDefined(var_09.last_interaction_point) && var_09.last_interaction_point == var_05) {
            var_09 thread scripts\cp\cp_interaction::refresh_interaction();
          }
        }

        var_05.out_of_order = 0;
      }
    }
  }
}