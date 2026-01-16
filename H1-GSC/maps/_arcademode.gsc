/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_arcademode.gsc
********************************/

main() {
  precachestring(&"SCRIPT_COLON");
  precachestring(&"SCRIPT_TIME_REMAINING");
  precachestring(&"SCRIPT_TOTAL_SCORE");
  precachestring(&"SCRIPT_EXTRA_LIFE");
  precachestring(&"SCRIPT_CHECKPOINT");
  precachestring(&"SCRIPT_MISSION_SCORE");
  precachestring(&"SCRIPT_ZERO_DEATHS");
  precachestring(&"SCRIPT_PLUS");
  precachestring(&"SCRIPT_TIME_UP");
  precachestring(&"SCRIPT_1UP");
  precachestring(&"SCRIPT_GAME_OVER");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_THREE");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_FOUR");
  precachestring(&"SCRIPT_MISSION_COMPLETE");
  precachestring(&"SCRIPT_NEW_HIGH_SCORE");
  precachestring(&"SCRIPT_STREAK_BONUS_LOST");
  precachestring(&"SCRIPT_STREAK_COMPLETE");
  precachestring(&"SCRIPT_X");
  precacheshader("arcademode_life");
  precacheshader("arcademode_life_empty");
  precacheshader("h1_arcademode_scanelines_border");
  precacheshader("h1_arcademode_scanelines_border_cap");
  precacheshader("h1_arcademode_scanelines_border_end_title");
  precacheshader("h1_arcademode_numberstreak_circles");
  precacheshader("h1_arcademode_numberstreak_glow");
  precacheshader("h1_arcademode_livesmessage_border");
  precacheshader("h1_arcademode_checkpoint_flare");
  precacheshader("h1_arcademode_lives_earned_flare");
  precacheshader("h1_arcademode_lives_message_flare");
  precacheshader("h1_arcademode_number_streak_flare");
  level.color_cool_green = (0.8, 2, 0.8);
  level.color_cool_green_glow = (0.3, 0.6, 0.3);
  level.arcademode_ending_hud = [];
  arcademode_init_kill_streak_colors();
  level.arcademode_checkpoint_dvars = [];
  level.arcademode_checkpoint_max = 10;
  level.arcademode_kills_hud = [];
  level.arcademode_kill_streak_ends = 0;
  level.arcademode_last_streak_time = 0;
  level.arcademode_ramping_score = 0;
  level.arcademode_new_kill_streak_allowed = 1;
  common_scripts\utility::flag_init("arcadeMode_multiplier_maxed");
  setdvar("arcademode_lives_changed", 0);
  level.arcademode_kill_streak_current_multiplier = 1;
  level.arcademode_kill_streak_multiplier_count = 3;
  arcademode_reset_kill_streak();

  for (var_0 = 0; var_0 < level.arcademode_checkpoint_max; var_0++)
    setdvar("arcademode_checkpoint_" + var_0, "");

  level.arcademode_last_multi_kill_sound = 0;
  level.arcademode_success = 0;
  arcademode_define_damage_multipliers();
  common_scripts\utility::flag_init("arcademode_complete");
  common_scripts\utility::flag_init("arcademode_ending_complete");
  waittillframeend;

  if(getdvar("arcademode_full") == "1")
    precacheleaderboards("LB_AM_FULLCHALLENGE");
  else
    precacheleaderboards("LB_AM_" + level.script);

  level.global_kill_func = ::player_kill;
  level.global_damage_func_ads = ::player_damage_ads;
  level.global_damage_func = ::player_damage;
  level.arcademode_hud_sort = 50;
  level.arcademode_maxlives = 10;
  level.arcademode_rewarded_lives = 0;

  if(getdvar("arcademode_lives") == "" || getdvar("arcademode_full") != "1" || level.script == "cargoship") {
    setdvar("arcademode_lives", 2);
    level.arcademode_rewarded_lives = 2;
  }

  if(getdvar("arcademode_full") == "1" && level.script == "cargoship") {
    setdvar("arcademode_lives", 5);
    level.arcademode_rewarded_lives = 5;
  }

  var_1 = getdvarint("arcademode_lives");
  setdvar("arcademode_earned_lives", var_1);
  level.arcademode_playthrough = getdvarint("arcademode_playthrough_count");
  level.arcademode_playthrough++;
  setdvar("arcademode_playthrough_count", level.arcademode_playthrough);
  setdvar("arcademode_died", 0);
  setdvar("arcademode_score", 0);

  if(getdvar("arcademode_combined_score") == "" || getdvar("arcademode_full") == "1" && level.script == "cargoship")
    setdvar("arcademode_combined_score", 0);

  var_2 = arcademode_get_level_time();
  var_2 = var_2 * 60;
  level.arcdemode_starttime = gettime();
  level.arcademode_time = var_2;
  level.arcademode_killbase = 50;
  level.arcademode_damagebase = 5;
  level.arcademode_multikills = [];
  var_3 = getarraykeys(level.arcademode_weaponmultiplier);

  for (var_0 = 0; var_0 < var_3.size; var_0++)
    level.arcademode_multikills[var_3[var_0]] = [];

  var_4 = level.arcademode_multikills;
  thread arcademode_update_lives();
  thread arcademode_update_score();
  thread arcademode_update_timer();
  thread arcademode_death_detection();
  arcademode_redraw_lives(var_1);

  for (;;) {
    wait 0.05;
    waittillframeend;
    waittillframeend;
    var_3 = getarraykeys(level.arcademode_multikills);
    common_scripts\utility::array_levelthread(var_3, ::arcademode_add_points_for_mod);
    level.arcademode_multikills = var_4;
  }
}

arcademode_complete() {
  if(getdvar("arcademode") != "1")
    return 0;

  return common_scripts\utility::flag("arcademode_complete");
}

arcademode_get_level_time() {
  var_0 = 20;
  var_1 = [];
  var_1["cargoship"] = 11;
  var_1["armada"] = 15;
  var_1["bog_a"] = 13;
  var_1["hunted"] = 17;
  var_1["ac130"] = 13;
  var_1["bog_b"] = 15;
  var_1["airlift"] = 14;
  var_1["village_assault"] = 17;
  var_1["scoutsniper"] = 18;
  var_1["ambush"] = 12;
  var_1["sniperescape"] = 20;
  var_1["village_defend"] = 15;
  var_1["icbm"] = 16;
  var_1["launchfacility_a"] = 11;
  var_1["launchfacility_b"] = 14;
  var_1["jeepride"] = 9;
  var_1["airplane"] = 4;
  var_2 = 1;

  if(isdefined(var_1[level.script]))
    var_0 = var_1[level.script];

  level.arcademode_difficultytimerscale = var_2;
  return var_0;
}

arcademode_death_detection() {
  level endon("arcademode_complete");
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, "missionfailed");
  level.player maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::do_wait_any();
  setdvar("arcademode_died", 1);
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1)
    var_0 = var_1;

  var_0 = var_0 - 1;
  setdvar("arcademode_lives", var_0);
  setdvar("arcademode_lives_changed", -1);
  arcademode_redraw_lives(var_0 + 1);
  level.arcademode_redraw_score = 1;
  updatescoreelemsonce();

  if(var_0 < 0) {
    wait 1.5;
    level.arcademode_failurestring = & "SCRIPT_GAME_OVER";
    thread arcademode_ends();
    return;
  }

  if(isalive(level.player))
    missionfailed();
}

arcademode_update_timer() {
  level.player endon("death");
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.x = -21.6667;
  var_0.y = 38.9778;
  var_0.sort = level.arcademode_hud_sort;
  var_0.fontscale = 1.5;
  var_0.color = (1, 1, 1);
  var_0.font = "objective";
  var_0 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_0.hidewheninmenu = 1;
  level.arcademode_hud_timer = var_0;
  level endon("arcadeMode_remove_timer");
  var_1 = level.arcademode_time;
  var_0 settimer(var_1 - 0.1);
  wait(var_1);
  level.arcademode_failurestring = & "SCRIPT_TIME_UP";
  thread arcademode_ends();
  soundscripts\_snd::snd_message("player_death");
}

arcademode_update_lives() {
  level.player endon("death");
  level endon("missionfailed");
  level.arcademode_lives_hud = [];

  for (var_0 = 0; var_0 < level.arcademode_maxlives; var_0++)
    arcademode_add_life(var_0, -28.6667, 68.6667, -14, 64, level.arcademode_hud_sort);

  for (;;) {
    var_1 = getdvarint("arcademode_lives_changed");

    if(var_1 != 0) {
      var_2 = getdvarint("arcademode_lives");

      if(var_2 < 0) {
        level.arcademode_failurestring = & "SCRIPT_GAME_OVER";
        thread arcademode_ends();
        return;
      }

      if(var_1 == -1) {
        level notify("lost_streak");
        level.arcademode_kill_streak_ends = gettime();
        thread arcademode_add_kill_streak_time(0);
        level.arcademode_new_kill_streak_allowed = 0;
        var_3 = getdvarint("arcademode_earned_lives");
        var_3--;
        var_2 = var_3;
        setdvar("arcademode_earned_lives", var_3);
        setdvar("arcademode_lives", var_3);
        level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_life_lost", level.player geteye());
      }

      arcademode_redraw_lives(var_2);
      level.arcademode_redraw_score = 1;
      setdvar("arcademode_lives_changed", 0);
    }

    wait 0.05;
  }
}

arcademode_convert_extra_lives() {
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1)
    thread extra_lives_display(var_0 - var_1);

  setdvar("arcademode_earned_lives", var_0);
  thread arcademode_redraw_lives(var_0);
  return var_0 > var_1;
}

arcademode_checkpoint_print() {
  if(!maps\_utility::arcademode()) {
    return;
  }
  arcademode_convert_extra_lives();
  var_0 = 800;
  var_1 = 0.8;
  level.player thread common_scripts\utility::play_sound_in_space("arcademode_checkpoint", level.player geteye());
  thread draw_checkpoint(0, var_1, 1);
  thread draw_checkpoint_scanlines(0, var_1, 1);
  thread draw_checkpoint_flare();
}

draw_lives_earned_flare(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.foreground = 1;
  var_4.x = var_1 + var_0 * var_3 - 10;
  var_4.y = var_2 + 10;
  var_4 setshader("h1_arcademode_lives_earned_flare", 26, 26);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "right";
  var_4.vertalign = "top";
  var_4.sort = level.arcademode_hud_sort + 10 - 1;
  var_4.alpha = 0;
  var_4.hidewheninmenu = 1;
  var_4 fadeovertime(0.05);
  var_4.alpha = 0.4;
  wait 0.05;
  var_4 scaleovertime(0.15, 52, 52);
  wait 0.15;
  var_4 destroy();
}

arcademode_redraw_life(var_0, var_1) {
  if(var_0 >= var_1) {
    self setshader("arcademode_life_empty", 20, 20);
    self.empty = 1;
  } else {
    if(isdefined(self.empty) && self.empty)
      thread draw_lives_earned_flare(var_0, -18.6667, 58.6667, -14);

    self setshader("arcademode_life", 20, 20);
    self.empty = 0;
  }

  self fadeovertime(1);
  self.alpha = 1;
  self.color = (1, 1, 1);
}

arcademode_remove_life(var_0) {
  if(self.alpha <= 0) {
    return;
  }
  self fadeovertime(1);
  self.alpha = 0;
  self.color = (1, 0, 0);
  self.glowalpha = 0;
  self.empty = 0;
}

arcademode_remove_life_ending(var_0) {
  if(self.alpha <= 0) {
    return;
  }
  self fadeovertime(0.15);
  self.alpha = 0;
  self scaleovertime(0.15, 40, 40);
}

arcademode_redraw_lives(var_0) {
  if(var_0 > 10)
    var_0 = 10;

  var_1 = getdvarint("arcademode_earned_lives");

  for (var_2 = 0; var_2 < var_0; var_2++)
    level.arcademode_lives_hud[var_2] arcademode_redraw_life(var_2, var_1);

  for (var_2 = var_0; var_2 < level.arcademode_maxlives; var_2++) {
    if(var_2 < 0) {
      continue;
    }
    if(var_2 >= 10) {
      continue;
    }
    if(level.arcademode_success) {
      level.arcademode_lives_hud[var_2] arcademode_remove_life_ending(var_2);
      continue;
    }

    level.arcademode_lives_hud[var_2] arcademode_remove_life(var_2);
  }
}

arcademode_update_streak_progress() {
  for (;;) {
    level common_scripts\utility::waittill_either("arcademode_decrement_kill_streak", "arcademode_new_kill");
    waittillframeend;
    arcademode_redraw_streak_progress();
  }
}

arcademode_redraw_streak_progress() {
  for (var_0 = 0; var_0 < level.arcademode_kill_streak_current_count; var_0++) {
    if(var_0 >= level.arcademode_kills_hud.size) {
      return;
    }
    level.arcademode_kills_hud[var_0].color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
    level.arcademode_kills_hud[var_0].glowcolor = level.arcademode_streak_glow[level.arcademode_kill_streak_current_multiplier - 1];
  }

  var_1 = 0;

  for (;;) {
    var_2 = level.arcademode_kill_streak_current_multiplier + var_1;

    if(var_2 >= level.arcademode_streak_color.size)
      var_2 = level.arcademode_streak_color.size - 1;

    for (var_0 = level.arcademode_kill_streak_current_count + var_1 * level.arcademode_kill_streak_multiplier_count; var_0 < level.arcademode_kill_streak_current_count + (var_1 + 1) * level.arcademode_kill_streak_multiplier_count; var_0++) {
      if(var_0 >= level.arcademode_kills_hud.size) {
        return;
      }
      level.arcademode_kills_hud[var_0].color = level.arcademode_streak_color[var_2];
      level.arcademode_kills_hud[var_0].glowcolor = level.arcademode_streak_glow[var_2];
    }

    var_1++;
  }
}

arcademode_add_kill(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("arcademode_stop_kill_streak_art");
  var_6 = newhudelem();
  var_6.foreground = 1;
  var_6.x = var_1 + var_0 * var_3;

  if(level.arcademode_kills_hud.size == 0)
    level.arcademode_kill_zero_x_location = var_6.x;

  var_6.y = var_2;
  var_6 setshader("arcademode_kill", var_4, var_4);
  var_6.alignx = "right";
  var_6.aligny = "top";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.sort = var_5;
  var_6.color = level.color_cool_green;
  var_6.glowcolor = level.color_cool_green_glow;
  var_6.glowalpha = 1;
  var_6.hidewheninmenu = 1;
  var_7 = 0;
  level.arcademode_kills_hud[level.arcademode_kills_hud.size] = var_6;

  if(level.arcademode_kills_hud.size == 10) {
    var_7 = 1;
    var_6.alpha = 0;
  } else
    var_6.alpha = 1;

  for (;;) {
    if(var_6.x == level.arcademode_kill_zero_x_location) {
      var_8 = 4;

      if(level.arcademode_kills_hud.size == 1)
        wait 3;

      var_6 fadeovertime(var_8);
      var_6.color = (1, 0, 0);
      var_6.alpha = 0;
      wait(var_8);
      level notify("arcademode_decrement_kill_streak");
      var_6 destroy();

      for (var_9 = 0; var_9 < level.arcademode_kills_hud.size - 1; var_9++)
        level.arcademode_kills_hud[var_9] = level.arcademode_kills_hud[var_9 + 1];

      level.arcademode_kills_hud[level.arcademode_kills_hud.size - 1] = undefined;

      if(!level.arcademode_kills_hud.size)
        thread arcademode_reset_kill_streak();

      return;
    }

    level waittill("arcademode_decrement_kill_streak");
    wait 0.05;
    var_6 moveovertime(0.5);
    var_6.x = var_6.x - var_3;

    if(var_7) {
      var_6 fadeovertime(0.5);
      var_6.alpha = 1;
      var_7 = 0;
    }
  }
}

get_streak_hud(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.foreground = 1;
  var_4.x = var_0 + -4;
  var_4.y = var_1 + 14;
  var_4.alignx = "right";
  var_4.aligny = "top";
  var_4.horzalign = "right";
  var_4.vertalign = "top";
  var_4.color = level.color_cool_green;
  var_4.sort = level.arcademode_hud_sort - 1;
  var_4.alpha = 0;
  var_4.glowcolor = level.color_cool_green_glow;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4 setshader("white", var_2, var_3);
  return var_4;
}

arcademode_add_kill_streak_time(var_0) {
  if(!level.arcademode_new_kill_streak_allowed) {
    return;
  }
  level notify("arcademode_new_kill_streak_time");
  level endon("arcademode_new_kill_streak_time");

  if(level.arcademode_kill_streak_ends < gettime())
    level.arcademode_kill_streak_ends = gettime() + var_0 * 1000;
  else
    level.arcademode_kill_streak_ends = level.arcademode_kill_streak_ends + var_0 * 1000;

  waittillframeend;

  if(isdefined(level.arcademode_hud_streak)) {
    level.arcademode_hud_streak fadeovertime(0.05);
    level.arcademode_hud_streak.alpha = 1;
  }

  var_1 = 26;
  var_2 = 12;
  var_3 = 90;
  var_4 = level.arcademode_streak_hud;
  var_5 = level.arcademode_streak_hud_shadow;
  var_6 = level.arcademode_kill_streak_ends - gettime();
  var_6 = var_6 * 0.001;

  if(var_6 > var_3)
    var_6 = var_3;

  var_6 = var_6 * var_2;
  var_6 = int(var_6);

  if(var_6 > 980)
    var_6 = 980;

  if(!isdefined(var_4)) {
    var_4 = get_streak_hud(0, 0, var_6, var_1);
    var_5 = get_streak_hud(3, 3, var_6, var_1);
    var_5.sort = var_5.sort - 1;
    var_5.alpha = 0.0;
    var_5.color = (0, 0, 0);
  } else {
    var_4 scaleovertime(1, var_6, var_1);
    var_5 scaleovertime(1, var_6, var_1);
    wait 1;
  }

  level.arcademode_streak_hud = var_4;
  level.arcademode_streak_hud_shadow = var_5;
  var_4 endon("death");
  var_0 = level.arcademode_kill_streak_ends - gettime();
  var_0 = var_0 * 0.001;
  var_7 = int(var_0);

  if(var_7 > var_3) {
    var_7 = var_3;
    wait(var_0 - var_7);
  }

  for (;;) {
    var_6 = level.arcademode_kill_streak_ends - gettime();
    var_6 = var_6 * 0.001;
    var_8 = var_6;

    if(isdefined(level.arcademode_hud_streak)) {
      level.arcademode_hud_streak fadeovertime(1);
      level.arcademode_hud_streak.alpha = (var_8 - 1) / 5;
    }

    var_6 = var_6 * var_2;
    var_6 = int(var_6);

    if(var_6 <= 0)
      var_6 = 1;

    if(var_6 > 980)
      var_6 = 980;

    if(isdefined(var_4))
      var_4 scaleovertime(1, var_6, var_1);

    if(isdefined(var_5))
      var_5 scaleovertime(1, var_6, var_1);

    wait 1;

    if(var_6 == 1) {
      break;
    }
  }

  thread arcademode_reset_kill_streak();
}

arcademode_add_kill_streak() {
  if(common_scripts\utility::flag("arcadeMode_multiplier_maxed")) {
    return;
  }
  level endon("arcadeMode_multiplier_maxed");
  level endon("arcademode_stop_kill_streak");
  level.arcademode_kill_streak_current_count--;
  var_0 = gettime();

  if(level.arcademode_kill_streak_current_count <= 0 && var_0 > level.arcademode_last_streak_time) {
    level.arcademode_last_streak_time = var_0;
    var_1 = level.arcademode_kill_streak_current_multiplier;
    level.arcademode_kill_streak_current_multiplier++;

    if(level.arcademode_kill_streak_current_multiplier >= level.arcademode_streak_color.size) {
      level.arcademode_kill_streak_current_multiplier = level.arcademode_streak_color.size;
      thread arcademode_multiplier_maxed();
    }

    if(var_1 != level.arcademode_kill_streak_current_multiplier) {
      level notify("arcademode_new_kill_streak");
      level.player playsound("arcademode_" + level.arcademode_kill_streak_current_multiplier + "x");
      thread arcademode_draw_multiplier();
    }

    level.arcademode_kill_streak_current_count = level.arcademode_kill_streak_multiplier_count;
  }

  level notify("arcademode_new_kill");

  for (;;) {
    if(level.arcademode_kills_hud.size < 10) {
      arcademode_add_kill_streak_time(5);
      return;
    }

    level waittill("arcademode_decrement_kill_streak");
  }
}

streak_timer_color_pulse() {
  waittillframeend;
  waittillframeend;
  level.arcademode_streak_hud endon("death");

  for (;;) {
    var_0 = randomfloatrange(0.1, 1.0);
    level.arcademode_streak_hud fadeovertime(var_0);
    level.arcademode_streak_hud.color = (randomfloat(1), randomfloat(1), randomfloat(1));
    wait(var_0);
  }
}

arcademode_multiplier_maxed() {
  waittillframeend;

  if(common_scripts\utility::flag("arcadeMode_multiplier_maxed")) {
    return;
  }
  common_scripts\utility::flag_set("arcadeMode_multiplier_maxed");
  var_0 = 20;
  level.arcademode_kill_streak_ends = gettime() + var_0 * 1000;
  thread arcademode_add_kill_streak_time(0);
  thread streak_timer_color_pulse();
  musicstop();
  wait 0.05;
  musicplay("airplane_alt_maximum_music");
  level maps\_utility::add_wait(maps\_utility::_wait, var_0 + 1);
  level maps\_utility::add_wait(maps\_utility::waittill_msg, "lost_streak");
  maps\_utility::do_wait_any();
  thread arcademode_reset_kill_streak();
  musicstop();

  if(isdefined(level.last_song)) {
    wait 0.05;
    musicplay(level.last_song);
  }
}

get_score_backer(var_0, var_1, var_2) {
  var_3 = new_ending_hud("right", 0.1, -5.16667, 3.22222);
  var_3 setshader("h1_arcademode_scanelines_border", 50, 50);
  var_3.alignx = "right";
  var_3.aligny = "top";
  var_3.horzalign = "right";
  var_3.vertalign = "top";
  var_3.sort = -100;
  var_3.alpha = 1.0;
  return var_3;
}

get_hud_score() {
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.x = 0;
  var_0.y = 10.2222;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.score = 0;
  var_0.font = "objective";
  var_0.fontscale = 2.8;
  var_0.sort = level.arcademode_hud_sort;
  var_0 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_0.hidewheninmenu = 1;
  return var_0;
}

arcademode_update_score() {
  level.player endon("death");
  level.arcademode_hud_digits = 10;
  level.arcademode_hud_scores = [];

  for (var_0 = 0; var_0 < level.arcademode_hud_digits; var_0++) {
    level.arcademode_hud_scores[level.arcademode_hud_scores.size] = get_hud_score();
    level.arcademode_hud_scores[level.arcademode_hud_scores.size - 1].x = var_0 * -17 + -21.6667;
  }

  level.arcademode_hud_score_backer = get_score_backer();

  if(getdvarint("arcademode_full"))
    var_1 = getdvarint("arcademode_combined_score");
  else
    var_1 = getdvarint("arcademode_score");

  hud_draw_score(var_1);
  level.arcademode_redraw_score = 0;

  for (;;) {
    wait 0.05;
    updatescoreelemsonce();

    if(level.arcademode_redraw_score)
      level.arcademode_redraw_score = 0;
  }
}

updatescoreelemsonce() {
  if(getdvarint("arcademode_full"))
    hud_update_score("arcadeMode_combined_score");
  else
    hud_update_score("arcademode_score");
}

hud_update_score(var_0) {
  var_1 = getdvarint(var_0);

  if(level.arcademode_redraw_score) {
    level.arcademode_ramping_score = var_1;
    hud_draw_score(var_1);
    return;
  }

  if(level.arcademode_ramping_score >= var_1) {
    return;
  }
  var_2 = var_1 - level.arcademode_ramping_score;
  var_3 = var_2 * 0.2 + 1;

  if(var_2 <= 15)
    var_3 = 1;

  level.arcademode_ramping_score = level.arcademode_ramping_score + var_3;

  if(level.arcademode_ramping_score > var_1)
    level.arcademode_ramping_score = var_1;

  hud_draw_score(int(level.arcademode_ramping_score));
}

get_digits_from_score(var_0) {
  var_1 = [];
  var_0 = int(var_0);

  for (;;) {
    var_1[var_1.size] = var_0 % 10;
    var_0 = int(var_0 * 0.1);

    if(var_0 <= 0) {
      break;
    }
  }

  return var_1;
}

hud_draw_score(var_0) {
  hud_draw_score_for_elements(var_0, level.arcademode_hud_scores);
}

hud_draw_score_for_elements(var_0, var_1) {
  var_2 = get_digits_from_score(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 >= var_1.size - 1) {
      break;
    }

    var_1[var_3] setvalue(var_2[var_3]);
    var_1[var_3].alpha = 1;
  }

  for (var_3 = var_2.size; var_3 < var_1.size; var_3++)
    var_1[var_3].alpha = 0;

  if(var_0 == 0) {
    var_1[0].alpha = 1;
    var_1[0] setvalue(0);
  }

  level.arcademode_hud_score_backer setshader("h1_arcademode_scanelines_border", 50 + (var_2.size - 1) * 22, 50);
  level.arcademode_hud_score_backer.x = -5.16667 + (var_2.size - 1) * 2.4;

  if(!common_scripts\utility::flag("arcademode_complete"))
    level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_add_counter_pt", level.player geteye());
}

hud_draw_score_for_elements_align_left(var_0, var_1) {
  var_2 = get_digits_from_score(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 >= var_1.size - 1) {
      break;
    }

    var_1[var_1.size - var_2.size + var_3] setvalue(var_2[var_3]);
    var_1[var_1.size - var_2.size + var_3].alpha = 1;
  }

  for (var_3 = var_1.size - var_2.size - 1; var_3 >= 0; var_3--)
    var_1[var_3].alpha = 0;

  if(var_0 == 0) {
    var_1[var_1.size - 1].alpha = 1;
    var_1[var_1.size - 1] setvalue(0);
  }
}

arcademode_add_life(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newhudelem();
  var_6.foreground = 1;
  var_6.x = var_1 + var_0 * var_3;
  var_6.y = var_2;
  var_6 setshader("arcademode_life", var_4, var_4);
  var_6.alignx = "center";
  var_6.aligny = "middle";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.sort = var_5;
  var_6.color = (1, 1, 1);
  var_6.glowalpha = 0;
  var_6.alpha = 0;
  var_6.hidewheninmenu = 1;
  level.arcademode_lives_hud[level.arcademode_lives_hud.size] = var_6;
}

arcademode_define_damage_multipliers() {
  var_0["MOD_MELEE"] = 20;
  var_0["MOD_PISTOL_BULLET"] = 20;
  var_0["MOD_RIFLE_BULLET"] = 10;
  var_0["MOD_PROJECTILE"] = 2;
  var_0["MOD_PROJECTILE_SPLASH"] = 2;
  var_0["MOD_EXPLOSIVE"] = 2;
  var_0["MOD_GRENADE"] = 2;
  var_0["MOD_GRENADE_SPLASH"] = 2;
  var_0 = [];
  var_0["melee"] = 1;
  var_0["pistol"] = 1;
  var_0["rifle"] = 0.5;
  var_0["explosive"] = 0.3;
  level.arcademode_weaponmultiplier = var_0;
  var_1 = [];
  var_1["melee"] = 80;
  var_1["pistol"] = 0;
  var_1["rifle"] = 0;
  var_1["explosive"] = 0;
  level.arcademode_weaponbonus = var_1;
  var_2 = [];
  var_2["MOD_MELEE"] = "melee";
  var_2["MOD_PISTOL_BULLET"] = "pistol";
  var_2["MOD_RIFLE_BULLET"] = "rifle";
  var_2["MOD_PROJECTILE"] = "explosive";
  var_2["MOD_PROJECTILE_SPLASH"] = "explosive";
  var_2["MOD_EXPLOSIVE"] = "explosive";
  var_2["MOD_GRENADE"] = "explosive";
  var_2["MOD_GRENADE_SPLASH"] = "explosive";
  level.arcademode_deathtypes = var_2;
  var_3 = [];
  var_3["melee"] = (1, 0, 1);
  var_3["pistol"] = (0, 1, 0);
  var_3["rifle"] = (1, 1, 0);
  var_3["explosive"] = (0, 1, 1);
  level.arcademode_killcolors = var_3;
  var_4 = [];
  var_4["head"] = 50;
  var_4["helmet"] = 50;
  var_4["neck"] = 20;
  var_4["torso_upper"] = 10;
  var_4["torso_lower"] = 10;
  var_4["right_arm_upper"] = 0;
  var_4["left_arm_lower"] = 0;
  var_4["right_leg_lower"] = 0;
  var_4["left_leg_upper"] = 0;
  var_4["right_leg_upper"] = 0;
  var_4["left_leg_lower"] = 0;
  var_4["left_foot"] = 0;
  var_4["right_foot"] = 0;
  var_4["left_hand"] = 0;
  var_4["left_arm_upper"] = 0;
  var_4["right_hand"] = 0;
  var_4["right_arm_lower"] = 0;
  var_4["gun"] = 0;
  var_4["none"] = 0;
  level.arcademode_locationkillbonus = var_4;
  var_5 = [];
  var_5[0] = 1;
  var_5[1] = 1.5;
  var_5[2] = 3;
  var_5[3] = 4;
  level.arcademode_skillmultiplier = var_5;
  var_6 = [];
  var_6[0] = 9000;
  var_6[1] = 9000;
  var_6[2] = 7000;
  var_6[3] = 6000;
  var_6[0] = 40;
  var_6[1] = 30;
  var_6[2] = 25;
  var_6[3] = 20;
  level.arcademode_kills_until_next_extra_life = 10;
  level.arcademode_extra_lives_range = var_6;
  var_7 = [];

  for (var_8 = 0; var_8 < 4; var_8++)
    var_7[var_8] = var_6[var_8] * 0.15;

  level.arcademode_extra_lives_base = var_7;
}

set_next_extra_life(var_0) {}

new_ending_hud(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.foreground = 1;
  var_4.x = var_2;
  var_4.y = var_3;
  var_4.alignx = var_0;
  var_4.aligny = "middle";
  var_4.horzalign = var_0;
  var_4.vertalign = "middle";
  var_4.fontscale = 3;

  if(getdvar("widescreen") == "1")
    var_4.fontscale = 5;

  var_4.color = (0.8, 1, 0.8);
  var_4.font = "objective";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(var_1);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.sort = level.arcademode_hud_sort + 10;
  level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_4;
  return var_4;
}

extra_lives_display_border() {
  var_0 = new_ending_hud("center", 0.001, 0, 97.7778);
  var_0 setshader("h1_arcademode_livesmessage_border", 210, 112);
  var_0.sort = level.arcademode_hud_sort + 10 - 1;
  var_0.vertalign = "top_adjustable";
  var_0.alpha = 0;
  var_0 fadeovertime(0.15);
  var_0.alpha = 1;
  wait 0.15;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
  wait 0.1;
  var_0 fadeovertime(0.1);
  var_0.alpha = 1;
  wait 0.1;
  wait 1.2;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
  wait 0.1;
  var_0 destroy();
}

extra_lives_display_flare() {
  var_0 = new_ending_hud("center", 0.001, 0, 97.7778);
  var_0 setshader("h1_arcademode_lives_message_flare", 145, 26);
  var_0.sort = level.arcademode_hud_sort + 10 + 1;
  var_0.vertalign = "top_adjustable";
  var_0.alpha = 0;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 0;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 0;
  wait 0.05;
  wait 0.1;
  var_0 fadeovertime(0.15);
  var_0.alpha = 1;
  wait 0.15;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
  wait 0.1;
  wait 2.1;
  var_0 destroy();
}

extra_lives_display(var_0) {
  wait 0.5;
  level.player thread common_scripts\utility::play_sound_in_space("arcademode_extralife", level.player geteye());
  var_1 = new_ending_hud("center", 0.001, 0, 97.7778);
  var_1.fontscale = 1.7;
  var_1.vertalign = "top_adjustable";
  var_1 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.5, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_1.label = & "SCRIPT_EXTRA_LIFE";
  var_1 setvalue(var_0);
  thread extra_lives_display_border();
  thread extra_lives_display_flare();
  var_1.alpha = 0;
  wait 0.4;
  var_1 fadeovertime(0.15);
  var_1.alpha = 1;
  wait 0.15;
  wait 1.0;
  var_1 fadeovertime(0.1);
  var_1.alpha = 0;
  wait 0.1;
  var_1 destroy();
}

fade_out(var_0) {
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

extra_lives_sizzle() {
  var_0 = new_ending_hud("center", 0.2, 0, -100);
  var_0.alpha = randomfloatrange(0.1, 0.45);
  var_0.sort = var_0.sort - 1;
  var_0 settext(&"SCRIPT_EXTRA_LIFE");
  var_0 maps\_utility::delaythread(3, ::fade_out, 1);
  var_0 endon("death");
  var_1 = var_0.x;
  var_2 = var_0.y;
  var_3 = 20;

  for (;;) {
    var_4 = randomfloatrange(0.1, 0.2);
    var_0 moveovertime(var_4);
    var_0.x = var_1 + randomfloatrange(var_3 * -1, var_3);
    var_0.y = var_2 + randomfloatrange(var_3 * -1, var_3);
    wait(var_4);
  }
}

round_up_to_five(var_0) {
  var_1 = var_0 - var_0 % 5;

  if(var_1 < var_0)
    var_1 = var_1 + 5;

  return var_1;
}

arcademode_add_points(var_0, var_1, var_2, var_3) {
  if(var_3 <= 0) {
    return;
  }
  if(isdefined(level.arcademode_deathtypes[var_2]))
    var_2 = level.arcademode_deathtypes[var_2];

  var_3 = int(var_3);
  var_3 = round_up_to_five(var_3);
  var_3 = var_3 * level.arcademode_kill_streak_current_multiplier;
  var_4 = getdvarint("arcademode_score");
  var_4 = var_4 + var_3;
  var_5 = getdvarint("arcademode_combined_score");
  var_5 = var_5 + var_3;
  setdvar("arcademode_combined_score", var_5);
  setdvar("arcademode_score", var_4);
  var_6 = 60;
  var_7 = 1.5;
  var_8 = 0.9 + (var_3 - 10) * 0.01;

  if(var_8 > 1.4)
    var_8 = 1.4;

  var_9 = (0.75, 0, 0);

  if(var_1) {
    thread arcademode_add_kill_streak();
    thread arcademode_add_point_towards_extra_life();
    var_9 = level.arcademode_killcolors[var_2];
  }

  level.player pointpulse(var_3);
}

arcademode_add_point_towards_extra_life() {
  level.arcademode_kills_until_next_extra_life = level.arcademode_kills_until_next_extra_life - 1;

  if(level.arcademode_kills_until_next_extra_life > 0) {
    return;
  }
  level.arcademode_rewarded_lives++;
  var_0 = getdvarint("arcademode_lives");
  var_0++;

  if(var_0 >= level.arcademode_maxlives)
    var_0 = level.arcademode_maxlives;
  else {
    setdvar("arcademode_lives", var_0);
    setdvar("arcademode_lives_changed", 1);
  }

  level.arcademode_kills_until_next_extra_life = level.arcademode_extra_lives_range[level.gameskill];
}

arcademode_set_origin_in_radius() {
  var_0 = 60;
  var_1 = 90;

  if(level.player.pointpulseindex > 0) {
    if(level.player.pointpulseindex == 1) {
      var_2 = randomint(1);
      level.player.thirdpointpulseside = 1 - var_2;

      if(var_2)
        var_1 = 45;
      else
        var_1 = 135;
    } else if(level.player.pointpulseindex == 2) {
      var_2 = level.player.thirdpointpulseside;

      if(var_2)
        var_1 = 45;
      else
        var_1 = 135;
    } else if(level.player.pointpulseindex <= 4) {
      var_1 = randomfloatrange(0, 180);
      var_0 = randomfloatrange(60, 120);
    } else if(level.player.pointpulseindex <= 8) {
      var_1 = randomfloatrange(0, 180);
      var_0 = randomfloatrange(60, 160);
    } else {
      var_1 = randomfloatrange(-30, 210);
      var_0 = randomfloatrange(60, 200);
    }
  }

  self.x = var_0 * cos(var_1);
  self.y = 0 - var_0 * sin(var_1);
}

pointpulse(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(!isdefined(level.player.pointpulsecount)) {
    level.player.pointpulsecount = 0;
    level.player.pointpulseindex = 0;
  }

  if(!common_scripts\utility::flag("arcademode_complete"))
    level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_pulse_score", level.player geteye());

  var_1 = newhudelem();
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1 arcademode_set_origin_in_radius();
  var_1.font = "objective";
  var_1.fontscale = 1.5;
  var_1.archived = 0;
  var_1.color = (1, 1, 1);
  var_1.sort = 4;
  var_2 = level.arcademode_kill_streak_current_multiplier;
  level.player.pointpulsecount++;
  level.player.pointpulseindex++;
  wait 0.05;

  if(var_0 <= 0) {
    var_1.label = & "";
    var_1.color = (1, 0, 0);
    var_1.glowcolor = (0, 0, 0);
    var_1.glowalpha = 0;
  } else {
    var_1.label = & "SCRIPT_PLUS";
    var_1.color = (1, 1, 1);
    var_1 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  }

  var_1 setvalue(var_0);
  var_1.alpha = 1;
  var_3 = 4.0;
  var_4 = 0.025;
  var_5 = 1.5;
  var_6 = 0.2;
  var_1 changefontscaleovertime(var_4);
  var_1.fontscale = var_3;
  wait 0.05;
  var_1 moveovertime(1.75);
  var_1.y = var_1.y - 20;
  var_1 changefontscaleovertime(var_6);
  var_1.fontscale = var_5;
  wait(var_6);
  var_1 fadeovertime(1.0);
  var_1.alpha = 0;
  wait 1.0;
  level.player.pointpulsecount--;

  if(level.player.pointpulsecount == 0)
    level.player.pointpulseindex = 0;

  var_1 destroy();
}

set_circular_origin() {
  var_0 = 50;

  for (;;) {
    var_1 = randomint(var_0);
    var_2 = randomint(var_0);

    if(distance((0, 0, 0), (var_1, var_2, 0)) < var_0) {
      break;
    }
  }

  if(common_scripts\utility::cointoss())
    var_1 = var_1 * -1;

  if(common_scripts\utility::cointoss())
    var_2 = var_2 * -1;

  self.x = var_1;
  self.y = var_2;
}

arcademode_add_points_for_mod(var_0) {
  for (var_1 = 0; var_1 < level.arcademode_multikills[var_0].size; var_1++)
    arcademode_add_points_for_individual_kill(level.arcademode_multikills[var_0][var_1], var_0, level.arcademode_multikills[var_0].size);
}

arcademode_add_points_for_individual_kill(var_0, var_1, var_2) {
  if(var_0["type"] != "melee")
    var_3 = level.arcademode_killbase + level.arcademode_locationkillbonus[var_0["damage_location"]] + level.arcademode_weaponbonus[var_0["type"]];
  else
    var_3 = level.arcademode_killbase + level.arcademode_weaponbonus[var_0["type"]];

  thread arcademode_add_points(var_0["origin"], 1, var_1, var_3);
}

player_kill(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "none";

  var_3 = level.arcademode_deathtypes[var_0];

  if(!isdefined(var_3)) {
    var_4 = level.arcademode_killbase;
    thread arcademode_add_points(var_2, 1, "melee", var_4);
    return;
  }

  var_5["damage_location"] = var_1;
  var_5["type"] = var_3;
  var_5["origin"] = var_2;

  if(var_3 == "explosive")
    var_5["origin"] = self.origin;

  level.arcademode_multikills[var_3][level.arcademode_multikills[var_3].size] = var_5;
}

player_damage(var_0, var_1, var_2) {
  thread arcademode_add_points(var_2, 0, var_0, level.arcademode_damagebase);
}

player_damage_ads(var_0, var_1, var_2) {
  thread arcademode_add_points(var_2, 0, var_0, level.arcademode_damagebase * 1.25);
}

ending_screen_mission_complete_flourish(var_0) {
  var_1 = new_ending_hud("center", 0.05, 0, var_0);
  var_1.fontscale = 3;
  var_1.color = (1, 1, 1);
  var_1 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_1 settext(&"SCRIPT_MISSION_COMPLETE");
  var_2 = new_ending_hud("center", 0.15, 0, var_0);
  var_2.fontscale = 4.5;
  var_2.color = (1, 1, 1);
  var_2 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_2 settext(&"SCRIPT_MISSION_COMPLETE");
  var_1 changefontscaleovertime(0.15);
  var_1.fontscale = 4.5;
  var_2 changefontscaleovertime(0.15);
  var_2.fontscale = 3;
  wait 0.05;
  var_1 fadeovertime(0.15);
  var_1.alpha = 0;
  wait 0.15;
  var_1 destroy();
  var_2 destroy();
}

end_mission() {
  setsaveddvar("ui_nextMission", "0");

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.maxhealth = 0;
    var_1.health = 1;
  }

  changelevel("");
}

create_total_score_hud(var_0, var_1) {
  level.arcademode_hud_total_scores = [];

  for (var_2 = 0; var_2 < level.arcademode_hud_digits; var_2++) {
    var_3 = get_hud_score();
    level.arcademode_hud_total_scores[level.arcademode_hud_total_scores.size] = var_3;
    level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_3;
    var_3.x = 0;
    var_3.y = var_1;
    var_3.sort = level.arcademode_hud_sort + 10;
    var_3.alignx = "left";
    var_3.aligny = "middle";
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "middle";
    var_3.fontscale = 1.875;
    var_3.alpha = 0;
    var_3 fadeovertime(1.0);
    var_3.alpha = 1;
  }
}

set_total_score_hud(var_0) {
  hud_draw_score_for_elements_align_left(var_0, level.arcademode_hud_total_scores);
}

rescale_ending_huds_thread(var_0, var_1, var_2, var_3, var_4, var_5) {
  for (;;) {
    var_6 = getscreenwidth();
    var_7 = getscreenheight();

    if(var_6 != level.screen_width || var_7 != level.screen_height) {
      level.screen_width = var_6;
      level.screen_height = var_7;

      if(level.screen_height == 0)
        level.screen_height = 1;

      if(level.screen_width == 0)
        level.screen_width = 1;

      rescale_ending_huds(var_0, var_1, var_2, var_3, var_4, var_5);
    }

    wait 0.1;
  }
}

rescale_ending_huds(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1920.0 / level.screen_width * level.screen_height / 1080.0;
  var_7 = 37 * var_6;
  var_8 = 11.6667 + 9 * var_6 * 9 + var_7;

  for (var_9 = 0; var_9 < level.arcademode_hud_digits; var_9++) {
    level.arcademode_hud_mission_scores[var_9].x = 320 + var_9 * (-9 * var_6) + var_8;

    if(isdefined(level.arcademode_hud_total_scores))
      level.arcademode_hud_total_scores[var_9].x = 320 + var_9 * (-9 * var_6) + var_8;
  }

  var_10 = 11.6667 + var_7;
  level.arcademode_hud_timer[0].x = 320 + var_10 + 0 * var_6;
  level.arcademode_hud_timer[1].x = 320 + var_10 + 8.3 * var_6;
  level.arcademode_hud_timer[2].x = 320 + var_10 + 16.6 * var_6;
  level.arcademode_hud_timer[3].x = 320 + var_10 + 21 * var_6;
  level.arcademode_hud_timer[4].x = 320 + var_10 + 29.6 * var_6;
  var_11 = 58.5;
  var_12 = var_11 - (10 - var_3) * 13 * 0.5;

  for (var_9 = 0; var_9 < level.arcademode_maxlives; var_9++)
    level.arcademode_lives_hud[var_9].x = (var_9 * -13 + var_12) * var_6;

  if(isdefined(var_0))
    var_0.x = 320 + var_7;

  var_1.x = 320 + var_7;
  var_2.x = 320 + var_7;

  if(level.arcademode_success)
    var_4 setshader("h1_arcademode_scanelines_border", int(344 * var_6), 65);
  else
    var_4 setshader("h1_arcademode_scanelines_border", int(216 * var_6), 65);

  var_5 setshader("h1_arcademode_scanelines_border_end_title", int(291 * var_6), 4);
}

arcademode_ends() {
  if(common_scripts\utility::flag("arcademode_complete")) {
    return;
  }
  common_scripts\utility::flag_set("arcademode_complete");
  maps\_utility::slowmo_setlerptime_out(0.05);
  maps\_utility::slowmo_lerp_out();
  maps\_utility::slowmo_end();

  if(level.arcademode_success) {
    if(arcademode_convert_extra_lives())
      wait 2;
  }

  var_0 = 0;

  if(isdefined(level.arcademode_stoptime)) {
    var_0 = gettime() - level.arcademode_stoptime;
    var_0 = var_0 * 0.001;
  }

  var_1 = gettime() - level.arcdemode_starttime;
  var_1 = var_1 * 0.001;
  var_1 = var_1 - var_0;
  var_2 = level.arcademode_time - var_1;
  var_2 = int(var_2);

  if(level.arcademode_success) {
    if(var_2 == 0)
      var_2++;
  }

  var_3 = 0.5;
  level.mission_failed_disabled = 1;
  thread player_invul_forever();
  thread black_background(var_3);
  wait(var_3 + 0.25);
  level.player freezecontrols(1);
  var_4 = 1;
  var_5 = 0;

  if(getdvar("arcademode_full") == "1")
    var_5 = 27.5556;

  var_6 = -111.111;
  var_7 = -72.0;
  var_8 = var_7;
  var_9 = -72.0 + var_5;
  var_10 = var_9;
  var_11 = -44.4444 + var_5;
  var_12 = var_11;
  var_13 = 35.5556 + var_5;
  var_14 = -20.4444 + var_5;
  var_15 = new_ending_hud("center", 0.1, 0, var_6);
  var_15.fontscale = 3;
  var_16 = new_ending_hud("center", 0.1, 320, var_6 + 5);
  var_16.horzalign = "fullscreen";
  var_16.sort = var_15.sort - 1;
  var_16.alpha = 1;
  level.screen_width = getscreenwidth();
  level.screen_height = getscreenheight();
  var_17 = 1920.0 / level.screen_width * level.screen_height / 1080.0;

  if(level.arcademode_success) {
    var_15.color = (1, 1, 1);
    var_15 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
    var_16 setshader("h1_arcademode_scanelines_border", int(344 * var_17), 65);
    var_15 settext(&"SCRIPT_MISSION_COMPLETE");
    level.player playsound("h1_arcademode_mission_success");
    thread ending_screen_mission_complete_flourish(var_6);
  } else {
    var_15.color = (1, 0.15, 0.16);
    var_15 _meth_8347(-0.6, 0, 0, 0, (0.5, 0.1, 0.1), 0.3, 0, 0, (0, 0, 0), 0);
    var_15 settext(level.arcademode_failurestring);
    var_16 setshader("h1_arcademode_scanelines_border", int(216 * var_17), 65);
    var_16.color = (1, 0.15, 0.16);
    level.player playsound("h1_arcademode_mission_fail");
  }

  var_18 = new_ending_hud("center", 0.1, 0, var_6 + 20);
  var_18 setshader("h1_arcademode_scanelines_border_end_title", int(291 * var_17), 4);
  var_18.sort = var_15.sort - 1;
  var_18.alpha = 1;
  wait 1.0;
  var_19 = getdvarint("arcademode_lives");
  var_20 = level.arcademode_rewarded_lives;

  if(var_19 > var_20)
    var_19 = var_20;

  for (var_21 = 0; var_21 < level.arcademode_maxlives; var_21++)
    level.arcademode_lives_hud[var_21] destroy();

  level.arcademode_lives_hud = [];

  for (var_21 = 0; var_21 < level.arcademode_maxlives; var_21++) {
    arcademode_add_life(var_21, 0, var_14, 0, 64, level.arcademode_hud_sort + 10);
    level.arcademode_lives_hud[var_21].horzalign = "center";
    level.arcademode_lives_hud[var_21].vertalign = "middle";
  }

  arcademode_redraw_lives(var_19);
  var_22 = 0;
  var_23 = undefined;

  if(getdvar("arcademode_full") == "1") {
    var_23 = new_ending_hud("center", var_4, 0, var_7);
    var_23.alignx = "right";
    var_23.horzalign = "fullscreen";
    var_23.fontscale = 1.875;
    var_23.color = (1, 1, 1);
    var_23 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
    var_23 settext(&"SCRIPT_TOTAL_SCORE");
    create_total_score_hud(0, var_8);
    var_22 = getdvarint("arcademode_combined_score");
    set_total_score_hud(var_22);
  }

  var_24 = new_ending_hud("center", var_4, 0, var_9);
  var_24.alignx = "right";
  var_24.horzalign = "fullscreen";
  var_24.fontscale = 1.875;
  var_24.color = (1, 1, 1);
  var_24 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_24 settext(&"SCRIPT_MISSION_SCORE");
  level.arcademode_hud_mission_scores = [];

  for (var_21 = 0; var_21 < level.arcademode_hud_digits; var_21++) {
    var_25 = get_hud_score();
    level.arcademode_hud_mission_scores[level.arcademode_hud_mission_scores.size] = var_25;
    level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_25;
    var_25.x = 0;
    var_25.y = var_10;
    var_25.sort = level.arcademode_hud_sort + 10;
    var_25.alignx = "left";
    var_25.aligny = "middle";
    var_25.horzalign = "fullscreen";
    var_25.vertalign = "middle";
    var_25.fontscale = 1.875;
    var_25.alpha = 0;
    var_25 fadeovertime(var_4);
    var_25.alpha = 1;
  }

  hud_draw_score_for_elements_align_left(0, level.arcademode_hud_mission_scores);
  var_26 = 0;

  for (var_27 = 0; var_2 >= 60; var_2 = var_2 - 60)
    var_26++;

  var_27 = var_2;
  var_28 = new_ending_hud("center", var_4, 0, var_12);
  var_28.alignx = "right";
  var_28.horzalign = "fullscreen";
  var_28.fontscale = 1.7;
  var_28.color = (1, 1, 1);
  var_28 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_28 settext(&"SCRIPT_TIME_REMAINING");
  level.arcademode_hud_timer = [];
  level.arcademode_hud_timer[0] = new_ending_hud("center", var_4, 0, var_11);
  level.arcademode_hud_timer[1] = new_ending_hud("center", var_4, 0, var_11);
  level.arcademode_hud_timer[2] = new_ending_hud("center", var_4, 0, var_11);
  level.arcademode_hud_timer[2] settext(&"SCRIPT_COLON");
  level.arcademode_hud_timer[3] = new_ending_hud("center", var_4, 0, var_11);
  level.arcademode_hud_timer[4] = new_ending_hud("center", var_4, 0, var_11);

  for (var_21 = 0; var_21 < 5; var_21++) {
    level.arcademode_hud_timer[var_21].alignx = "left";
    level.arcademode_hud_timer[var_21].horzalign = "fullscreen";
    level.arcademode_hud_timer[var_21].vertalign = "middle";
    level.arcademode_hud_timer[var_21].fontscale = 1.7;
    level.arcademode_hud_timer[var_21].fontscale = 1.7;
    level.arcademode_hud_timer[var_21].color = (1, 1, 1);
    level.arcademode_hud_timer[var_21] _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.3, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  }

  ending_set_time(var_26, var_27);
  level.screen_width = getscreenwidth();
  level.screen_height = getscreenheight();
  var_17 = 1920.0 / level.screen_width * level.screen_height / 1080.0;
  rescale_ending_huds(var_23, var_24, var_28, var_19, var_16, var_18);
  thread rescale_ending_huds_thread(var_23, var_24, var_28, var_19, var_16, var_18);
  wait(var_4);
  wait 1;
  var_29 = getdvarint("arcadeMode_score");
  var_30 = 0;
  var_31 = var_22;
  var_32 = 0;

  for (;;) {
    var_33 = var_29 - var_30;
    var_34 = var_33 * 0.2 + 1;

    if(var_33 <= 15)
      var_34 = 1;

    var_34 = int(var_34);
    var_30 = var_30 + var_34;

    if(var_30 > var_29)
      var_30 = var_29;

    hud_draw_score_for_elements_align_left(var_30, level.arcademode_hud_mission_scores);

    if(var_30 == var_29) {
      break;
    }

    var_32--;

    if(var_32 <= 0) {
      level.player playsound("h1_arcademode_ending_mission_pts");
      var_32 = 3;
    }

    wait 0.05;
  }

  wait 1;
  var_35 = 0;
  var_36 = undefined;

  if(level.arcademode_success) {
    var_37 = 5;
    var_38 = var_26 * 60 + var_27;
    var_39 = ceil(var_38 / 15);
    var_40 = ceil(var_38 * var_37);
    var_41 = ceil(var_40 / level.arcademode_difficultytimerscale);
    var_42 = var_30;
    var_43 = var_30 + var_41;
    var_44 = var_22;
    var_45 = var_22 + var_41;

    for (var_21 = 1; var_21 <= var_39; var_21++) {
      var_46 = var_21 * 1.0 / var_39;

      if(var_21 == var_39)
        var_46 = 1;

      var_30 = int(var_42 * (1 - var_46) + var_43 * var_46);

      if(getdvar("arcademode_full") == "1") {
        var_22 = int(var_44 * (1 - var_46) + var_45 * var_46);
        set_total_score_hud(var_22);
      }

      hud_draw_score_for_elements_align_left(var_30, level.arcademode_hud_mission_scores);
      var_47 = int(var_38 * (1 - var_46));
      ending_set_time(floor(var_47 / 60), var_47 % 60);
      var_32--;

      if(var_32 <= 0) {
        level.player playsound("h1_arcademode_ending_time_pts");
        var_32 = 3;
      }

      wait 0.05;
    }

    ending_set_time(0, 0);
    wait 1;

    for (;;) {
      var_48 = 1;

      if(var_19 > 10) {
        var_49 = var_19 % 10;

        if(var_19 - var_49 >= 10)
          var_48 = 10;
        else
          var_48 = var_49;

        if(var_19 < 20)
          var_48 = var_49;
      }

      var_19 = var_19 - var_48;

      if(var_19 < 0) {
        break;
      }

      var_50 = 1000;
      var_50 = var_50 * var_48;
      var_34 = int(var_50);

      if(getdvar("arcademode_full") == "1") {
        var_22 = var_22 + var_34;
        set_total_score_hud(var_22);
      }

      var_30 = var_30 + var_34;
      level.player playsound("h1_arcademode_ending_lives_pts");
      hud_draw_score_for_elements_align_left(int(var_30), level.arcademode_hud_mission_scores);
      arcademode_redraw_lives(var_19);
      wait 0.6;
    }

    wait 1;

    if(getdvarint("arcademode_died") != 1 && level.gameskill >= 2) {
      var_34 = int(var_30);
      arcademode_end_boost(var_30, var_22, var_34, & "SCRIPT_ZERO_DEATHS", "arcademode_zerodeaths", var_13, var_4, var_17);
      var_30 = var_30 + var_34;
      var_22 = var_22 + var_34;
    }
  } else {
    for (var_21 = 0; var_21 < 5; var_21++)
      level.arcademode_hud_timer[var_21] setpulsefx(0, 0, 1000);

    var_28 setpulsefx(0, 0, 1000);
    arcademode_redraw_lives(0);
    wait 2;
  }

  var_51 = level.arcademode_skillmultiplier[level.gameskill];

  if(var_51 > 1) {
    if(var_51 == 1.5)
      var_52 = & "SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF";
    else if(var_51 == 3)
      var_52 = & "SCRIPT_DIFFICULTY_BONUS_THREE";
    else
      var_52 = & "SCRIPT_DIFFICULTY_BONUS_FOUR";

    var_34 = int(ceil(var_30 * var_51) - var_30);
    arcademode_end_boost(var_30, var_22, var_34, var_52, "h1_arcademode_ending_diff_pts", var_13, var_4, var_17);
    var_30 = var_30 + var_34;
    var_22 = var_22 + var_34;
  }

  var_53 = 0;

  if(getdvar("arcademode_full") == "1") {
    var_54 = "s18";
    var_55 = getdvarint(var_54);

    if(var_22 > var_55) {
      var_56 = get_digits_from_score(var_22);
      var_57 = get_score_string_from_digits(var_56);
      setdvar(var_54, var_57);
      var_58 = 0;

      if(!level.arcademode_success)
        var_58 = 1;

      if(level.script == "airplane")
        var_58 = 1;

      if(var_58)
        var_53 = 1;
    }

    var_59 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "fullChallengeScore");

    if(var_22 > var_59)
      level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "fullChallengeScore", var_22);

    level.player uploadscore("LB_AM_FULLCHALLENGE", getdvarint(var_54));
  } else {
    var_60 = [];
    var_60["cargoship"] = 0;
    var_60["blackout"] = 1;
    var_60["armada"] = 2;
    var_60["bog_a"] = 3;
    var_60["hunted"] = 4;
    var_60["ac130"] = 5;
    var_60["bog_b"] = 6;
    var_60["airlift"] = 7;
    var_60["village_assault"] = 8;
    var_60["scoutsniper"] = 9;
    var_60["sniperescape"] = 10;
    var_60["village_defend"] = 11;
    var_60["ambush"] = 12;
    var_60["icbm"] = 13;
    var_60["launchfacility_a"] = 14;
    var_60["launchfacility_b"] = 15;
    var_60["jeepride"] = 16;
    var_60["airplane"] = 17;
    var_61 = var_60[level.script];

    if(isdefined(var_61)) {
      var_59 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "arcadeScore", level.script);

      if(var_30 > var_59) {
        var_53 = 1;
        level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "arcadeScore", level.script, var_30);
      }

      level.player uploadscore("LB_AM_" + level.script, var_30);
    }
  }

  if(var_53) {
    if(!level.arcademode_success)
      updategamerprofile();

    wait 1;
    var_62 = new_ending_hud("center", var_4, 0, var_13);
    var_62.fontscale = 2.25;
    var_62 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.5, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
    var_62 settext(&"SCRIPT_NEW_HIGH_SCORE");
    var_62 fadeovertime(0.05);
    var_62.alpha = 1;
    var_62 setpulsefx(30, 3000, 1000);
    var_63 = new_ending_hud("center", var_4, 0, var_13 + 0.5);
    var_63 setshader("h1_arcademode_livesmessage_border", int(313 * var_17), 135);
    var_63.sort = var_62.sort - 1;
    var_63 fadeovertime(0.05);
    var_63.alpha = 1;
    wait 3.0;
    var_63 fadeovertime(1.0);
    var_63.alpha = 0;
    wait 0.5;
  }

  wait 2;
  var_15 setpulsefx(0, 0, 1000);
  wait 0.5;
  var_24 setpulsefx(0, 0, 1000);

  for (var_21 = 0; var_21 < level.arcademode_hud_digits; var_21++) {
    var_25 = level.arcademode_hud_mission_scores[var_21];
    var_25 setpulsefx(0, 0, 1000);
  }

  if(getdvar("arcademode_full") == "1") {
    var_23 setpulsefx(0, 0, 1000);

    for (var_21 = 0; var_21 < level.arcademode_hud_digits; var_21++) {
      var_25 = level.arcademode_hud_total_scores[var_21];
      var_25 setpulsefx(0, 0, 1000);
    }
  }

  if(level.arcademode_success) {
    wait 0.5;

    for (var_21 = 0; var_21 < 5; var_21++)
      level.arcademode_hud_timer[var_21] setpulsefx(0, 0, 1000);

    var_28 setpulsefx(0, 0, 1000);
  }

  wait 1;

  if(getdvar("arcademode_full") == "1")
    logstring("ArcadeMode Score: " + var_30 + ", mission: " + level.script + ", gameskill: " + level.gameskill + ", total: " + var_22);
  else
    logstring("ArcadeMode Score: " + var_30 + ", mission: " + level.script + ", gameskill: " + level.gameskill);

  setdvar("arcademode_combined_score", var_22);

  if(var_22 >= 400000)
    maps\_utility::giveachievement_wrapper("ARCADE_ADDICT");

  if(!level.arcademode_success) {
    setdvar("ui_arcade_lost", 1);
    end_mission();
  } else
    setdvar("ui_arcade_lost", 0);

  for (var_21 = 0; var_21 < level.arcademode_ending_hud.size; var_21++) {
    if(isdefined(level.arcademode_ending_hud[var_21]))
      level.arcademode_ending_hud[var_21].alpha = 0;
  }

  common_scripts\utility::flag_set("arcademode_ending_complete");
}

arcademode_end_boost(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = new_ending_hud("center", var_6, 0, var_5);
  var_8.fontscale = 2.25;
  var_8 _meth_8347(-0.6, 0, 0, 0, (0.247, 0.439, 0.094), 0.5, -0.1, 0, (0.302, 0.588, 0.047), 0.75);
  var_8 settext(var_3);
  var_8 fadeovertime(0.05);
  var_8.alpha = 1;
  var_8 setpulsefx(30, 10000, 1000);
  var_9 = new_ending_hud("center", 0.15, 320, var_5 + 0.5);
  var_9 setshader("h1_arcademode_livesmessage_border", int(330 * var_7), 135);
  var_9.horzalign = "fullscreen";
  var_9.sort = var_8.sort - 1;
  var_9 fadeovertime(0.05);
  var_9.alpha = 1;
  wait 0.05;
  wait 1.0;
  var_10 = 0;
  var_11 = var_0 + var_2;
  var_12 = var_1 + var_2;

  for (;;) {
    var_13 = var_11 - var_0;
    var_2 = var_13 * 0.2 + 1;

    if(var_13 <= 15)
      var_2 = 1;

    var_2 = int(var_2);
    var_0 = var_0 + var_2;

    if(var_0 > var_11)
      var_0 = var_11;

    hud_draw_score_for_elements_align_left(var_0, level.arcademode_hud_mission_scores);

    if(getdvar("arcademode_full") == "1") {
      var_1 = var_1 + var_2;

      if(var_1 > var_12)
        var_1 = var_12;

      set_total_score_hud(var_1);
    }

    if(var_0 == var_11) {
      break;
    }

    var_10--;

    if(var_10 <= 0) {
      level.player playsound(var_4);
      var_10 = 3;
    }

    wait 0.05;
  }

  wait 0.5;
  var_8 setpulsefx(0, 10, 1000);
  var_9 fadeovertime(1.0);
  var_9.alpha = 0;
  wait 1.0;
}

black_background(var_0) {
  var_1 = newhudelem();
  var_1.foreground = 1;
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.sort = level.arcademode_hud_sort + 5;
  var_1.alpha = 0;

  if(var_0 > 0)
    var_1 fadeovertime(var_0);

  var_1.alpha = 1;
}

player_invul_forever() {
  for (;;) {
    level.player enableinvulnerability();
    level.player.deathinvulnerabletime = 70000;
    level.player.ignoreme = 1;
    var_0 = getaispeciesarray("all", "all");
    common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreme, 1);
    wait 0.05;
  }
}

ending_set_time(var_0, var_1) {
  var_2 = 0;

  for (var_3 = 0; var_0 >= 10; var_0 = var_0 - 10)
    var_2++;

  while (var_1 >= 10) {
    var_3++;
    var_1 = var_1 - 10;
  }

  level.arcademode_hud_timer[4] setvalue(var_1);
  level.arcademode_hud_timer[3] setvalue(var_3);
  level.arcademode_hud_timer[1] setvalue(var_0);
  level.arcademode_hud_timer[0] setvalue(var_2);
}

draw_checkpoint(var_0, var_1, var_2) {
  var_0 = var_0 * var_2;
  var_3 = new_ending_hud("center", 0.001, var_0, 73.3333);
  var_3.vertalign = "top_adjustable";
  var_3.fontscale = 2.5;
  var_3.color = (1, 1, 1);
  var_3.font = "objective";
  var_3 _meth_8347(-0.1, 0, 0, -0.001, (0, 0, 0), 0.2, -0.1, 0, (0, 0, 0), 0.5);
  var_3 settext(&"SCRIPT_CHECKPOINT");
  var_3.alpha = 0;
  wait 0.15;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3.fontscale = 3.5;
  wait 0.05;
  var_3.fontscale = 2.5;
  wait 0.05;
  wait 1.0;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 destroy();
}

draw_checkpoint_scanlines(var_0, var_1, var_2) {
  var_0 = var_0 * var_2;
  var_3 = new_ending_hud("center", 0.1, var_0, 73.3333);
  var_3.vertalign = "top_adjustable";
  var_3 setshader("h1_arcademode_scanelines_border", 384, 48);
  var_3.sort = var_3.sort - 2;
  var_3.alpha = 0.25;
  var_3.alpha = 0;
  wait 0.15;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  wait 0.05;
  wait 0.05;
  wait 1.0;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 1;
  wait 0.05;
  var_3 fadeovertime(0.05);
  var_3.alpha = 0;
  wait 0.05;
  var_3 destroy();
}

draw_checkpoint_flare() {
  var_0 = new_ending_hud("center", 0.001, 0, 73.3333);
  var_0.vertalign = "top_adjustable";
  var_0 setshader("h1_arcademode_checkpoint_flare", 326, 23);
  var_0.sort = level.arcademode_hud_sort + 10 - 1;
  var_0.alpha = 0;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 0;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 0;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 fadeovertime(0.05);
  var_0.alpha = 0;
  wait 0.05;
  var_0 destroy();
}

arcademode_checkpoint_getid(var_0) {
  for (var_1 = 0; var_1 < level.arcademode_checkpoint_dvars.size; var_1++) {
    if(level.arcademode_checkpoint_dvars[var_1] == var_0)
      return var_1;
  }

  return undefined;
}

arcademode_init_kill_streak_colors() {
  level.arcademode_streak_color = [];
  level.arcademode_streak_glow = [];
  level.arcademode_streak_color[level.arcademode_streak_color.size] = level.color_cool_green;
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.678431, 0.976471, 0.768627);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.658824, 0.964706, 0.619608);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (1, 0.976471, 0.317647);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.988235, 0.866667, 0.301961);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.988235, 0.831373, 0.376471);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.988235, 0.792157, 0.223529);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.984314, 0.72549, 0.152941);

  for (var_0 = 0; var_0 < level.arcademode_streak_color.size; var_0++)
    level.arcademode_streak_glow[var_0] = (level.arcademode_streak_color[var_0][0] * 0.35, level.arcademode_streak_color[var_0][1] * 0.35, level.arcademode_streak_color[var_0][2] * 0.35);

  level.arcademode_streak_color[0] = level.color_cool_green_glow;
}

arcademode_killstreak_complete_display() {
  if(level.arcademode_kill_streak_current_multiplier == 1) {
    return;
  }
  if(common_scripts\utility::flag("arcademode_complete")) {
    return;
  }
  var_0 = new_ending_hud("right", 0.2, -21.6667, 80.0);
  var_0.aligny = "top";
  var_0.vertalign = "top";
  var_0.glowalpha = 0;
  var_0 setpulsefx(5, 3000, 1000);
  var_0.fontscale = 0.75;
  var_1 = level.arcademode_kill_streak_current_multiplier - 1;
  var_1 = int(clamp(var_1, 1, 7));
  var_0.color = level.arcademode_streak_color[var_1];

  if(level.arcademode_kill_streak_current_multiplier >= 8) {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_won", level.player geteye());
    var_0 settext(&"SCRIPT_STREAK_COMPLETE");
  } else {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_lost", level.player geteye());
    var_0 settext(&"SCRIPT_STREAK_BONUS_LOST");
  }

  wait 5;
  var_0 destroy();
}

arcademode_reset_kill_streak_art() {
  if(isdefined(level.arcademode_streak_hud)) {
    level.arcademode_streak_hud destroy();
    level.arcademode_streak_hud = undefined;
    level.arcademode_streak_hud_shadow destroy();
  }

  level notify("arcademode_stop_kill_streak_art");

  for (var_0 = 0; var_0 < level.arcademode_kills_hud.size; var_0++)
    level.arcademode_kills_hud[var_0] destroy();

  level.arcademode_kills_hud = [];
}

arcademode_reset_kill_streak() {
  level.arcademode_new_kill_streak_allowed = 1;
  thread arcademode_killstreak_complete_display();
  level notify("arcademode_stop_kill_streak");
  arcademode_reset_kill_streak_art();
  common_scripts\utility::flag_clear("arcadeMode_multiplier_maxed");
  level.arcademode_kill_streak_current_count = level.arcademode_kill_streak_multiplier_count;
  level.arcademode_kill_streak_current_multiplier = 1;
}

get_hud_multi() {
  var_0 = 0.1;
  var_1 = newhudelem();
  var_1.alignx = "right";
  var_1.aligny = "top";
  var_1.horzalign = "right";
  var_1.vertalign = "top";
  var_1 thread arcademode_draw_multiplier_kill();
  var_1.x = 0;
  var_1.y = 76.3333;
  var_1.font = "objective";
  var_1.fontscale = 2.25;
  var_1.archived = 0;
  var_1.foreground = 1;
  var_1.hidewheninmenu = 1;
  var_1.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
  var_1 _meth_8347(-0.1, 0, 0, -0.001, (0, 0, 0), 0.5, -0.1, 0, (0, 0, 0), 0.75);
  var_1.sort = level.arcademode_hud_sort;
  var_1.label = & "SCRIPT_X";
  var_1 setvalue(level.arcademode_kill_streak_current_multiplier);
  var_1 moveovertime(var_0);
  var_1.x = -21.6667;
  var_1.alpha = 0.25;
  var_1 fadeovertime(var_0);
  var_1.alpha = 1.0;
  return var_1;
}

get_hud_multi_emphasis() {
  var_0 = newhudelem();
  var_0.alignx = "right";
  var_0.aligny = "middle";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.x = -21.6667;
  var_0.y = 89.3333;
  var_0.font = "objective";
  var_0.fontscale = 2.25;
  var_0.archived = 0;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;
  var_0.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
  var_0 _meth_8347(-0.6, 0, 0, 0, (0, 0, 0), 0.0, -0.6, 0, var_0.color, 1.0);
  var_0.sort = level.arcademode_hud_sort;
  var_0.label = & "SCRIPT_X";
  var_0 setvalue(level.arcademode_kill_streak_current_multiplier);
  var_0.alpha = 0.0;
  var_1 = 2;
  var_2 = newhudelem();
  var_2.alignx = "right";
  var_2.aligny = "top";
  var_2.horzalign = "right";
  var_2.vertalign = "top";
  var_2 thread arcademode_draw_multiplier_kill();
  var_2 setshader("h1_arcademode_numberstreak_circles", 22 * var_1, 27 * var_1);
  var_2.x = 38;
  var_2.y = 72.3333;
  var_2.archived = 0;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
  var_2.sort = level.arcademode_hud_sort - 1;
  var_3 = newhudelem();
  var_3.alignx = "right";
  var_3.aligny = "top";
  var_3.horzalign = "right";
  var_3.vertalign = "top";
  var_3 thread arcademode_draw_multiplier_kill();
  var_3 setshader("h1_arcademode_numberstreak_glow", 64, 64);
  var_3.x = 0.833332;
  var_3.y = 60.3333;
  var_3.archived = 0;
  var_3.foreground = 1;
  var_3.hidewheninmenu = 1;
  var_3.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
  var_3.sort = level.arcademode_hud_sort - 1;
  var_4 = 0.2;
  var_2.alpha = 1;
  var_2 scaleovertime(0.4, 27 * var_1, 27 * var_1);
  var_3.alpha = 0;
  var_3 fadeovertime(0.4);
  var_5 = 0.1;
  var_2 moveovertime(var_5);
  var_2.x = -20.6667;
  wait(var_5);

  if(isdefined(var_0)) {
    var_6 = 0.4;
    var_7 = 10.0;
    var_0 changefontscaleovertime(var_6);
    var_0.fontscale = var_7;
    wait 0.05;
    var_8 = 0.35;
    var_0.alpha = var_8;
    wait 0.05;
    var_0 fadeovertime(var_6);
    var_0.alpha = 0;
  }

  if(isdefined(var_2)) {
    var_2 fadeovertime(0.2);
    var_2.alpha = 0;
    var_9 = 0.15;
    wait(var_9);
    var_2 scaleovertime(0.2, 32 * var_1, 27 * var_1);
    wait(0.35 - var_9);
  }

  if(isdefined(var_3)) {
    var_3 fadeovertime(0.2);
    var_3.alpha = 0;
  }

  wait 0.4;

  if(isdefined(var_0))
    var_0 destroy();

  if(isdefined(var_2))
    var_2 destroy();

  if(isdefined(var_3))
    var_3 destroy();
}

arcademode_draw_multiplier() {
  level endon("arcademode_new_kill_streak");
  var_0 = get_hud_multi();
  thread get_hud_multi_emphasis();
  level.arcademode_hud_streak = var_0;
  level waittill("arcademode_stop_kill_streak");
  var_0 setpulsefx(0, 0, 1000);
  wait 1;
  var_0 destroy();
  level.arcademode_hud_streak = undefined;
}

arcademode_draw_mult_sizzle() {
  level endon("arcademode_new_kill_streak");
  wait 0.05;
  var_0 = 500;
  self moveovertime(2);
  self.x = self.x + randomintrange(var_0 * -1, var_0);
  self.y = self.y + randomintrange(var_0 * -1, var_0);
  wait 0.5;
  self fadeovertime(1);
  self.alpha = 0;
  wait 1;
  self destroy();
}

arcademode_draw_multiplier_kill() {
  self endon("death");
  level waittill("arcademode_new_kill_streak");
  self destroy();
}

get_score_string_from_digits(var_0) {
  var_1 = "";

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = var_0[var_2] + var_1;

  return var_1;
}