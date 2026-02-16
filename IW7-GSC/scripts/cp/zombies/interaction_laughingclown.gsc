/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_laughingclown.gsc
************************************************************/

laughing_clown(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_0 notify("machine_used");
  }

  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("laughingclown", var_1);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("laughingclown_afterlife", var_1);
  }

  if(isDefined(level.start_black_hole_func)) {
    var_0 thread[[level.start_black_hole_func]](var_0, var_1);
  }

  var_2 = getEntArray(var_0.target, "targetname");
  var_3 = scripts\engine\utility::istrue(var_1.in_afterlife_arcade);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  foreach(var_9 in var_2) {
    if(var_9.script_noteworthy == "clown_head") {
      var_4 = var_9;
      continue;
    }

    if(var_9.script_noteworthy == "ball_chute") {
      var_5 = var_9;
      continue;
    }

    if(var_9.script_noteworthy == "ball_chute_dir") {
      var_6 = var_9;
    }
  }

  var_11 = randomfloatrange(1, 2);
  var_12 = 1;
  var_13 = 0;
  var_14 = var_6.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_6.angles), 2);
  var_15 = spawn("script_model", var_14);
  scripts\engine\utility::waitframe();
  var_15 playSound("arcade_blackhole_ball_release");
  var_14 = var_6.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_6.angles), 2);
  var_15 setModel("zmb_arcade_game_ball_small");
  var_15.origin = var_6.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_6.angles), 1) + (0, 0, 0.1);
  if(var_3) {
    var_15.origin = var_6.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_6.angles), 3) + (0, 0, 0.2);
  }

  var_15 physicslaunchserver(var_14, vectornormalize(anglesToForward(var_6.angles)) * 65);
  var_10 = undefined;
  var_11 = 0;
  for(;;) {
    var_12 = var_15.origin;
    wait(0.5);
    var_13 = scripts\engine\utility::getStructArray(var_6.target, "targetname");
    var_10 = scripts\engine\utility::getclosest(var_15.origin, var_13, 3);
    if(isDefined(var_10)) {
      break;
    }

    if(distancesquared(var_12, var_15.origin) < 0.05) {
      var_15 physicslaunchserver(var_15.origin + (randomintrange(20, 35), randomintrange(20, 35), 0), vectornormalize(anglesToForward(var_6.angles)) * 5);
    }

    var_11++;
    if(var_11 >= 5) {
      var_15 delete();
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    }
  }

  wait(0.5);
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_1 playlocalsound("mp_slot_machine_coins");
  }

  if(var_3) {
    switch (var_10.script_noteworthy) {
      case "slot0":
        wait(0.25);
        var_1 playlocalsound("mp_slot_machine_coins");
        wait(0.25);
        var_1 playlocalsound("mp_slot_machine_coins");
        wait(0.5);
        func_1285F(var_1, 50);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown_afterlife", 1, 50, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown_afterlife"]);
        break;

      case "slot1":
        wait(0.5);
        func_1285F(var_1, 10);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown_afterlife", 1, 10, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown_afterlife"]);
        break;

      case "slot2":
        wait(0.5);
        func_1285F(var_1, 5);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown_afterlife", 1, 5, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown_afterlife"]);
        break;

      case "slot3":
        wait(0.5);
        func_1285F(var_1, 1);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown_afterlife", 1, 1, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown_afterlife"]);
        break;
    }
  } else if(var_1 scripts\cp\utility::is_valid_player()) {
    switch (var_10.script_noteworthy) {
      case "slot0":
        var_1 notify("hit_black_hole", 50);
        wait(0.25);
        var_1 playlocalsound("mp_slot_machine_coins");
        wait(0.25);
        var_1 playlocalsound("mp_slot_machine_coins");
        wait(0.5);
        level notify("update_arcade_game_performance", "black_hole", 50);
        scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, 50);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown", 0, 50, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown"]);
        break;

      case "slot1":
        var_1 notify("hit_black_hole", 10);
        wait(0.5);
        scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, 10);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown", 0, 10, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown"]);
        break;

      case "slot2":
        var_1 notify("hit_black_hole", 5);
        wait(0.5);
        scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, 5);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown", 0, 5, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown"]);
        break;

      case "slot3":
        var_1 notify("hit_black_hole", 1);
        wait(0.5);
        scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, 1);
        scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "laughingclown", 0, 1, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["laughingclown"]);
        break;
    }
  }

  wait(1);
  var_15 delete();
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

func_1285F(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    var_0 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_0, var_1);
  }
}

func_FF2B(var_0, var_1) {
  if(var_1 && !scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 0;
  }

  return 1;
}

init_all_laughing_clowns() {
  var_0 = scripts\engine\utility::getStructArray("laughingclown", "script_noteworthy");
  var_1 = 4;
  var_2 = 7;
  foreach(var_4 in var_0) {
    var_4 thread func_9655();
    var_4 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_1, var_2);
  }
}

init_all_afterlife_laughing_clowns() {
  var_0 = scripts\engine\utility::getStructArray("laughingclown_afterlife", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9655();
  }
}

func_9655() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = getEntArray(self.target, "targetname");
  self.var_D63E = spawn("script_origin", self.origin + (0, 0, 40));
  foreach(var_7 in var_5) {
    if(var_7.script_noteworthy == "clown_head") {
      var_1 = var_7;
      continue;
    }

    if(var_7.script_noteworthy == "ball_chute") {
      var_2 = var_7;
      continue;
    }

    if(var_7.script_noteworthy == "ball_chute_dir") {
      var_3 = var_7;
      continue;
    }

    if(var_7.classname == "light_spot") {
      var_4 = var_7;
    }
  }

  var_3 linkto(var_2);
  var_2 linkto(var_1);
  if(isDefined(var_1)) {
    var_1 thread func_42D6(self, var_0);
  }

  if(!var_0) {
    return;
  }

  for(;;) {
    var_9 = "power_on";
    if(var_0) {
      var_9 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_9 != "power_off") {
        self.powered_on = 1;
        continue;
      }

      self.powered_on = 0;
      var_4 setlightintensity(0);
    }
  }
}

func_42D6(var_0, var_1) {
  self endon("stop_laughingclown");
  if(scripts\engine\utility::istrue(var_1)) {
    level scripts\engine\utility::waittill_any("power_on", var_0.power_area + " power_on");
  }

  self rotateyaw(-30, 0.75);
  for(;;) {
    var_2 = randomfloatrange(0.5, 1.25);
    var_3 = randomfloat(var_2);
    var_4 = var_2 - var_3;
    self playSound("arcade_blackhole_mvmt");
    if(scripts\engine\utility::istrue(var_1) && var_0.powered_on == 0) {
      level scripts\engine\utility::waittill_any("power_on", var_0.power_area + " power_on");
    } else {
      self waittill("rotatedone");
    }

    wait(randomfloatrange(0.1, 0.25));
    self playSound("arcade_blackhole_mvmt");
    self rotateyaw(60, var_2, var_3, var_4);
    self waittill("rotatedone");
    wait(randomfloatrange(0.1, 0.25));
    self rotateyaw(-60, var_2, var_3, var_4);
  }
}