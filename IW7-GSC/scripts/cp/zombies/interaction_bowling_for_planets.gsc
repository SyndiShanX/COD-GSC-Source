/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_bowling_for_planets.gsc
******************************************************************/

init_bfp_game() {
  var_0 = scripts\engine\utility::getstructarray("bowling_for_planets", "script_noteworthy");
  var_1 = 2;
  var_2 = 4;
  foreach(var_4 in var_0) {
    var_4 thread func_F8CC();
    var_4 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_1, var_2);
    wait(0.05);
  }
}

init_bfp_afterlife_game() {
  var_0 = scripts\engine\utility::getstructarray("bowling_for_planets_afterlife", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_F8CC();
    wait(0.05);
  }
}

func_F8CC() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_1 = getEntArray(self.target, "targetname");
  self.var_EC20 = [];
  self.var_11806 = [];
  foreach(var_3 in var_1) {
    if(var_3.classname == "light_spot") {
      self.setminimap = var_3;
      continue;
    }

    if(var_3.classname == "trigger_multiple") {
      self.var_EC20[self.var_EC20.size] = var_3;
      continue;
    }

    if(var_3.classname == "script_brushmodel") {
      var_3 delete();
    }
  }

  var_5 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_3 in var_5) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }

    switch (var_3.script_noteworthy) {
      case "plane":
        self.var_11806[self.var_11806.size] = var_3;
        break;

      case "fx":
        self.var_5AD9 = var_3;
        break;
    }
  }

  self.var_5AD7 = 0;
  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  for(;;) {
    var_8 = "power_on";
    if(var_0) {
      var_8 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    setomnvar("zombie_arcade_skeeball_power_" + self.script_location, 1);
    if(var_8 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_8 != "power_off") {
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

    if(!var_0) {
      break;
    }
  }
}

use_bfp_game(var_0, var_1) {
  var_1 endon("last_stand");
  var_1 endon("disconnect");
  var_1 endon("spawned");
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
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("bowling_for_planets", var_1);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("bowling_for_planets_afterlife", var_1);
  }

  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_0 notify("machine_used");
  }

  var_1 playlocalsound("arcade_insert_coin_01");
  if(!isDefined(var_0.var_10226)) {
    var_0.var_10226 = spawn("script_origin", var_0.origin);
  }

  if(!scripts\engine\utility::istrue(var_0.song_playing)) {
    var_0.var_10226 playSound("mus_arcade_skeeball_game_start");
    level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(var_0, "mus_arcade_skeeball_game_start");
  }

  var_0.var_5AD7 = 0;
  scripts\engine\utility::waitframe();
  var_0.var_10227 = 0;
  var_0.var_2802 = 3;
  var_0.var_2801 = 0;
  setomnvar("zombie_arcade_skeeball_score_" + var_0.script_location, 0);
  setomnvar("zombie_arcade_skeeball_balls_" + var_0.script_location, var_0.var_2802);
  var_1 setclientomnvar("zombie_arcade_game_time", 1);
  var_1 setclientomnvar("zombie_bfp_widget", 1);
  var_1 thread func_CE0F(var_0);
  var_1 thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_disconnect_or_death(var_1, var_0, "iw7_cpskeeball_mp", ::func_10228);
  var_1 thread scripts\cp\zombies\arcade_game_utility::arcade_game_player_gets_too_far_away(var_1, var_0, "iw7_cpskeeball_mp", ::func_10228, "mus_arcade_skeeball_game_end", 4096);
}

func_10228(var_0, var_1) {
  var_1 setclientomnvar("zombie_arcade_game_time", -1);
  setomnvar("zombie_arcade_skeeball_balls_" + var_0.script_location, 0);
  var_1 setclientomnvar("ui_hide_weapon_info", 0);
  var_1 setclientomnvar("ui_securing_progress", 0);
  var_1 setclientomnvar("ui_securing", 0);
  var_1 setclientomnvar("zombie_bfp_widget", 0);
  var_1.playing_game = undefined;
  if(var_0.var_10227 >= 1) {
    var_2 = var_0.var_10227 * 1;
    if(var_1.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, var_0.name, 1, var_2, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets_afterlife"]);
      var_1 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_1, var_2);
      return;
    }

    scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, var_0.name, 0, var_2, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets"]);
    var_1 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, var_2);
  }
}

func_CE0F(var_0) {
  self notify("arcade_game_over_for_player");
  self endon("arcade_game_over_for_player");
  self endon("last_stand");
  self endon("spawned");
  self endon("disconnect");
  if(isDefined(level.start_bowling_for_planets_func)) {
    var_0 thread[[level.start_bowling_for_planets_func]](var_0, self);
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
  while(var_0.var_2802 > 0) {
    self giveweapon("iw7_cpskeeball_mp");
    self switchtoweapon("iw7_cpskeeball_mp");
    func_1397C(var_0);
    var_0.var_2802--;
    if(var_0.var_2802 < 0) {
      var_0.var_2802 = 0;
    }

    setomnvar("zombie_arcade_skeeball_balls_" + var_0.script_location, var_0.var_2802);
    wait(0.25);
  }

  self notify("stop_too_far_check");
  while(var_0.var_2801 != 3) {
    wait(1);
  }

  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_bfp_widget", 0);
  self.playing_game = undefined;
  self takeweapon("iw7_cpskeeball_mp");
  var_0.var_10226 playSound("mus_arcade_skeeball_game_end");
  scripts\engine\utility::allow_weapon_switch(1);
  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(self);
  scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
  if(var_0.var_10227 >= 1) {
    var_1 = var_0.var_10227 * 1;
    if(self.arcade_game_award_type == "soul_power") {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, var_0.name, 1, var_1, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets_afterlife"]);
      scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(self, var_1);
    } else {
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, var_0.name, 0, var_1, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["bowling_for_planets"]);
      scripts\cp\zombies\arcade_game_utility::give_player_tickets(self, var_1);
    }
  }

  scripts\engine\utility::delaythread(2, scripts\cp\cp_interaction::add_to_current_interaction_list, var_0);
  self notify("arcade_game_over_for_player");
}

get_intro_message(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return "Score 10 points per basket";
  }

  return "Win 1 ticket per 10!";
}

func_1397C(var_0) {
  self endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("grenade_pullback", var_1);
    if(var_1 != "iw7_cpskeeball_mp") {
      continue;
    }

    var_2 = spawn("script_model", var_0.origin);
    self.var_27BB = gettime();
    var_3 = var_0 scripts\cp\utility::player_lua_progressbar(self, 1000, 10000, 21, undefined, 1);
    self.var_278B = gettime();
    self waittill("grenade_fire", var_4, var_1);
    if(var_1 == "iw7_cpskeeball_mp") {
      thread func_11805(var_0, var_4, var_2);
      return;
    }
  }
}

func_11805(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("throw_a_bowling_for_planet");
  var_6 = 0;
  var_3 = anglesToForward(self getplayerangles(1));
  var_4 = bulletTrace(self getEye(), self getEye() + var_3 * 64, 1, self, 0, 0, 1);
  var_5 = scripts\engine\utility::getclosest(var_4["position"], var_0.var_11806, 64);
  if(!isDefined(var_5)) {
    var_7 = self getEye();
    var_4["position"] = var_7 + var_3 * 20;
    var_4["position"] = (var_4["position"][0], var_4["position"][1], var_0.var_11806[0].origin[2]);
  } else {
    var_4["position"] = var_5.origin + (0, 0, 1);
  }

  var_2.origin = var_4["position"];
  var_2.angles = var_3;
  var_2 setModel("cp_game_ball");
  var_8 = 950;
  var_9 = 600;
  var_10 = self.var_278B - self.var_27BB;
  if(var_10 < 1000) {
    var_11 = var_10 / 1000;
    var_9 = var_9 * var_11;
  }

  var_9 = var_8 + var_9;
  var_2 physicslaunchserver(var_4["position"] + (0, 0, 0.1), var_3 * var_9);
  var_2 playsoundonmovingent("arcade_skiball_ball_throw");
  var_2 thread func_1397B(var_0, self);
  scripts\engine\utility::waitframe();
  var_1 delete();
  wait(3);
  if(isDefined(var_2)) {
    if(!isDefined(var_2.var_46B3)) {
      var_0.var_2801++;
    }

    var_2 delete();
  }
}

func_1397B(var_0, var_1) {
  self endon("arcade_game_over_for_player");
  self endon("death");
  var_2 = undefined;
  for(;;) {
    foreach(var_4 in var_0.var_EC20) {
      if(self istouching(var_4)) {
        var_2 = var_4;
        break;
      }
    }

    if(isDefined(var_2)) {
      break;
    }

    wait(0.05);
  }

  var_0.var_10227 = var_0.var_10227 + int(var_2.script_noteworthy);
  var_0.var_5AD7 = 0;
  var_1 notify("score_in_bowling_for_planet", int(var_2.script_noteworthy));
  setomnvar("zombie_arcade_skeeball_score_" + var_0.script_location, var_0.var_10227);
  var_0.var_2801++;
  self.var_46B3 = 1;
}