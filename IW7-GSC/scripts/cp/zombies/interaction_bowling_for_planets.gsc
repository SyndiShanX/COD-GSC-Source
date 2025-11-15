/******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_bowling_for_planets.gsc
******************************************************************/

init_bfp_game() {
  var_00 = scripts\engine\utility::getstructarray("bowling_for_planets", "script_noteworthy");
  var_01 = 2;
  var_02 = 4;
  foreach(var_04 in var_00) {
    var_04 thread func_F8CC();
    var_04 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_01, var_02);
    wait(0.05);
  }
}

init_bfp_afterlife_game() {
  var_00 = scripts\engine\utility::getstructarray("bowling_for_planets_afterlife", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_F8CC();
    wait(0.05);
  }
}

func_F8CC() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_01 = getEntArray(self.target, "targetname");
  self.var_EC20 = [];
  self.var_11806 = [];
  foreach(var_03 in var_01) {
    if(var_03.classname == "light_spot") {
      self.setminimap = var_03;
      continue;
    }

    if(var_03.classname == "trigger_multiple") {
      self.var_EC20[self.var_EC20.size] = var_03;
      continue;
    }

    if(var_03.classname == "script_brushmodel") {
      var_03 delete();
    }
  }

  var_05 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_03 in var_05) {
    if(!isDefined(var_03.script_noteworthy)) {
      continue;
    }

    switch (var_03.script_noteworthy) {
      case "plane":
        self.var_11806[self.var_11806.size] = var_03;
        break;

      case "fx":
        self.var_5AD9 = var_03;
        break;
    }
  }

  self.var_5AD7 = 0;
  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  for(;;) {
    var_08 = "power_on";
    if(var_00) {
      var_08 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    setomnvar("zombie_arcade_skeeball_power_" + self.script_location, 1);
    if(var_08 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_08 != "power_off") {
      self.powered_on = 1;
      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(5);
      }

      if(isDefined(self.var_2BAE)) {
        self.var_2BAE delete();
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

use_bfp_game(param_00, param_01) {
  param_01 endon("last_stand");
  param_01 endon("disconnect");
  param_01 endon("spawned");
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
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("bowling_for_planets", param_01);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("bowling_for_planets_afterlife", param_01);
  }

  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    param_00 notify("machine_used");
  }

  param_01 playlocalsound("arcade_insert_coin_01");
  if(!isDefined(param_00.var_10226)) {
    param_00.var_10226 = spawn("script_origin", param_00.origin);
  }

  if(!scripts\engine\utility::istrue(param_00.song_playing)) {
    param_00.var_10226 playSound("mus_arcade_skeeball_game_start");
    level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(param_00, "mus_arcade_skeeball_game_start");
  }

  param_00.var_5AD7 = 0;
  scripts\engine\utility::waitframe();
  param_00.var_10227 = 0;
  param_00.var_2802 = 3;
  param_00.var_2801 = 0;
  setomnvar("zombie_arcade_skeeball_score_" + param_00.script_location, 0);
  setomnvar("zombie_arcade_skeeball_balls_" + param_00.script_location, param_00.var_2802);
  param_01 setclientomnvar("zombie_arcade_game_time", 1);
  param_01 setclientomnvar("zombie_bfp_widget", 1);
  param_01 thread func_CE0F(param_00);
  param_01 thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_disconnect_or_death(param_01, param_00, "iw7_cpskeeball_mp", ::func_10228);
  param_01 thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_gets_too_far_away(param_01, param_00, "iw7_cpskeeball_mp", ::func_10228, "mus_arcade_skeeball_game_end", 4096);
}

func_10228(param_00, param_01) {
  param_01 setclientomnvar("zombie_arcade_game_time", -1);
  setomnvar("zombie_arcade_skeeball_balls_" + param_00.script_location, 0);
  param_01 setclientomnvar("ui_hide_weapon_info", 0);
  param_01 setclientomnvar("ui_securing_progress", 0);
  param_01 setclientomnvar("ui_securing", 0);
  param_01 setclientomnvar("zombie_bfp_widget", 0);
  param_01.playing_game = undefined;
  if(param_00.var_10227 >= 1) {
    var_02 = param_00.var_10227 * 1;
    if(param_01.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_01, level.wave_num_at_start_of_game, param_00.name, 1, var_02, param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets_afterlife"]);
      param_01 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_01, var_02);
      return;
    }

    scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_01, level.wave_num_at_start_of_game, param_00.name, 0, var_02, param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets"]);
    param_01 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_01, var_02);
  }
}

func_CE0F(param_00) {
  self notify("arcade_game_over_for_player");
  self endon("arcade_game_over_for_player");
  self endon("last_stand");
  self endon("spawned");
  self endon("disconnect");
  if(isDefined(level.start_bowling_for_planets_func)) {
    param_00 thread[[level.start_bowling_for_planets_func]](param_00, self);
  }

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
  scripts\engine\utility::allow_usability(0);
  scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  while(param_00.var_2802 > 0) {
    self giveweapon("iw7_cpskeeball_mp");
    self switchtoweapon("iw7_cpskeeball_mp");
    func_1397C(param_00);
    param_00.var_2802--;
    if(param_00.var_2802 < 0) {
      param_00.var_2802 = 0;
    }

    setomnvar("zombie_arcade_skeeball_balls_" + param_00.script_location, param_00.var_2802);
    wait(0.25);
  }

  self notify("stop_too_far_check");
  while(param_00.var_2801 != 3) {
    wait(1);
  }

  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_bfp_widget", 0);
  self.playing_game = undefined;
  self takeweapon("iw7_cpskeeball_mp");
  param_00.var_10226 playSound("mus_arcade_skeeball_game_end");
  scripts\engine\utility::allow_weapon_switch(1);
  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(self);
  scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  if(param_00.var_10227 >= 1) {
    var_01 = param_00.var_10227 * 1;
    if(self.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, param_00.name, 1, var_01, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets_afterlife"]);
      scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(self, var_01);
    } else {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, param_00.name, 0, var_01, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets"]);
      scripts\cp\zombies\arcade_game_utility::give_player_tickets(self, var_01);
    }
  }

  scripts\engine\utility::delaythread(2, ::scripts\cp\cp_interaction::add_to_current_interaction_list, param_00);
  self notify("arcade_game_over_for_player");
}

get_intro_message(param_00) {
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    return "Score 10 points per basket";
  }

  return "Win 1 ticket per 10!";
}

func_1397C(param_00) {
  self endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("grenade_pullback", var_01);
    if(var_01 != "iw7_cpskeeball_mp") {
      continue;
    }

    var_02 = spawn("script_model", param_00.origin);
    self.var_27BB = gettime();
    var_03 = param_00 scripts\cp\utility::player_lua_progressbar(self, 1000, 10000, 21, undefined, 1);
    self.var_278B = gettime();
    self waittill("grenade_fire", var_04, var_01);
    if(var_01 == "iw7_cpskeeball_mp") {
      thread func_11805(param_00, var_04, var_02);
      return;
    }
  }
}

func_11805(param_00, param_01, param_02, param_03, param_04, param_05) {
  self notify("throw_a_bowling_for_planet");
  var_06 = 0;
  param_03 = anglesToForward(self getplayerangles(1));
  param_04 = bulletTrace(self getEye(), self getEye() + param_03 * 64, 1, self, 0, 0, 1);
  param_05 = scripts\engine\utility::getclosest(param_04["position"], param_00.var_11806, 64);
  if(!isDefined(param_05)) {
    var_07 = self getEye();
    param_04["position"] = var_07 + param_03 * 20;
    param_04["position"] = (param_04["position"][0], param_04["position"][1], param_00.var_11806[0].origin[2]);
  } else {
    param_04["position"] = param_05.origin + (0, 0, 1);
  }

  param_02.origin = param_04["position"];
  param_02.angles = param_03;
  param_02 setModel("cp_game_ball");
  var_08 = 950;
  var_09 = 600;
  var_0A = self.var_278B - self.var_27BB;
  if(var_0A < 1000) {
    var_0B = var_0A / 1000;
    var_09 = var_09 * var_0B;
  }

  var_09 = var_08 + var_09;
  param_02 physicslaunchserver(param_04["position"] + (0, 0, 0.1), param_03 * var_09);
  param_02 playsoundonmovingent("arcade_skiball_ball_throw");
  param_02 thread func_1397B(param_00, self);
  scripts\engine\utility::waitframe();
  param_01 delete();
  wait(3);
  if(isDefined(param_02)) {
    if(!isDefined(param_02.var_46B3)) {
      param_00.var_2801++;
    }

    param_02 delete();
  }
}

func_1397B(param_00, param_01) {
  self endon("arcade_game_over_for_player");
  self endon("death");
  var_02 = undefined;
  for(;;) {
    foreach(var_04 in param_00.var_EC20) {
      if(self istouching(var_04)) {
        var_02 = var_04;
        break;
      }
    }

    if(isDefined(var_02)) {
      break;
    }

    wait(0.05);
  }

  param_00.var_10227 = param_00.var_10227 + int(var_02.script_noteworthy);
  param_00.var_5AD7 = 0;
  param_01 notify("score_in_bowling_for_planet", int(var_02.script_noteworthy));
  setomnvar("zombie_arcade_skeeball_score_" + param_00.script_location, param_00.var_10227);
  param_00.var_2801++;
  self.var_46B3 = 1;
}