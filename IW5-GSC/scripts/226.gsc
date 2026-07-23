/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\226.gsc
**************************************/

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
  level.color_cool_green = (0.8, 2, 0.8);
  level.color_cool_green_glow = (0.3, 0.6, 0.3);
  arcademode_init_kill_streak_colors();
  level.arcademode_checkpoint_dvars = [];
  level.arcademode_checkpoint_max = 10;
  level.arcademode_kills_hud = [];
  level.arcademode_kill_streak_ends = 0;
  level.arcademode_last_streak_time = 0;
  level.arcademode_ramping_score = 0;
  level.arcademode_new_kill_streak_allowed = 1;
  common_scripts\utility::flag_init("arcadeMode_multiplier_maxed");
  setDvar("arcademode_lives_changed", 0);
  level.arcademode_kill_streak_current_multiplier = 1;
  level.arcademode_kill_streak_multiplier_count = 3;
  arcademode_reset_kill_streak();

  for(var_0 = 0; var_0 < level.arcademode_checkpoint_max; var_0++) {
    setDvar("arcademode_checkpoint_" + var_0, "");
  }
  level.arcademode_last_multi_kill_sound = 0;
  level.arcademode_success = 0;
  arcademode_define_damage_multipliers();
  common_scripts\utility::flag_init("arcademode_complete");
  common_scripts\utility::flag_init("arcademode_ending_complete");
  waittillframeend;
  level.global_kill_func = ::player_kill;
  level.global_damage_func_ads = ::player_damage_ads;
  level.global_damage_func = ::player_damage;
  level.arcademode_hud_sort = 50;
  level.arcademode_maxlives = 10;
  level.arcademode_rewarded_lives = 0;

  if(getDvar("arcademode_lives") == "" || getDvar("arcademode_full") != "1" || level.script == "cargoship") {
    setDvar("arcademode_lives", 2);
    level.arcademode_rewarded_lives = 2;
  }

  if(getDvar("arcademode_full") == "1" && level.script == "cargoship") {
    setDvar("arcademode_lives", 5);
    level.arcademode_rewarded_lives = 5;
  }

  var_1 = getdvarint("arcadeMode_lives");
  setDvar("arcademode_earned_lives", var_1);
  level.arcademode_playthrough = getdvarint("arcademode_playthrough_count");
  level.arcademode_playthrough++;
  setDvar("arcademode_playthrough_count", level.arcademode_playthrough);
  setDvar("arcademode_died", 0);
  setDvar("arcademode_score", 0);

  if(getDvar("arcademode_combined_score") == "" || getDvar("arcademode_full") == "1" && level.script == "cargoship") {
    setDvar("arcademode_combined_score", 0);
  }
  var_2 = arcademode_get_level_time();
  var_2 = var_2 * 60;
  level.arcdemode_starttime = gettime();
  level.arcademode_time = var_2;
  level.arcademode_killbase = 50;
  level.arcademode_damagebase = 5;
  level.arcademode_multikills = [];
  var_3 = getarraykeys(level.arcademode_weaponmultiplier);

  for(var_0 = 0; var_0 < var_3.size; var_0++) {
    level.arcademode_multikills[var_3[var_0]] = [];
  }
  var_4 = level.arcademode_multikills;
  thread arcademode_update_lives();
  thread arcademode_update_score();
  thread arcademode_update_timer();
  thread arcademode_death_detection();
  arcademode_redraw_lives(var_1);

  for(;;) {
    wait 0.05;
    waittillframeend;
    waittillframeend;
    var_3 = getarraykeys(level.arcademode_multikills);
    common_scripts\utility::array_levelthread(var_3, ::arcademode_add_points_for_mod);
    level.arcademode_multikills = var_4;
  }
}

arcademode_complete() {
  if(getDvar("arcademode") != "1") {
    return 0;
  }
  return common_scripts\utility::flag("arcademode_complete");
}

arcademode_get_level_time() {
  var_0 = 20;
  var_1 = [];
  var_2 = 1;

  if(isDefined(var_1[level.script])) {
    var_0 = var_1[level.script];
  }
  level.arcademode_difficultytimerscale = var_2;
  return var_0;
}

arcademode_death_detection() {
  level endon("arcademode_complete");
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, "missionfailed");
  level.player maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::do_wait_any();
  setDvar("arcademode_died", 1);
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1) {
    var_0 = var_1;
  }
  var_0 = var_0 - 1;
  setDvar("arcademode_lives", var_0);
  setDvar("arcademode_lives_changed", -1);
  arcademode_redraw_lives(var_0 + 1);
  level.arcademode_redraw_score = 1;
  updatescoreelemsonce();

  if(var_0 < 0) {
    wait 1.5;
    level.arcademode_failurestring = &"SCRIPT_GAME_OVER";
    thread arcademode_ends();
    return;
  }

  if(isalive(level.player)) {
    missionfailed();
  }
}

arcademode_update_timer() {
  level.player endon("death");
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.x = 0;
  var_0.y = 60;
  var_0.sort = level.arcademode_hud_sort;
  var_0.fontscale = 3;
  var_0.color = (0.8, 1, 0.8);
  var_0.font = "objective";
  var_0.glowcolor = (0.3, 0.6, 0.3);
  var_0.glowalpha = 1;
  var_0.hidewheninmenu = 1;
  level.arcademode_hud_timer = var_0;
  level endon("arcadeMode_remove_timer");
  var_1 = level.arcademode_time;
  var_0 settimer(var_1 - 0.1);
  wait(var_1);
  level.arcademode_failurestring = &"SCRIPT_TIME_UP";
  thread arcademode_ends();
}

arcademode_update_lives() {
  level.player endon("death");
  level endon("missionfailed");
  level.arcademode_lives_hud = [];

  for(var_0 = 0; var_0 < level.arcademode_maxlives; var_0++) {
    arcademode_add_life(var_0, 16, 78, -18, 64, level.arcademode_hud_sort);
  }
  for(;;) {
    var_1 = getdvarint("arcademode_lives_changed");

    if(var_1 != 0) {
      var_2 = getdvarint("arcademode_lives");

      if(var_2 < 0) {
        level.arcademode_failurestring = &"SCRIPT_GAME_OVER";
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
        setDvar("arcademode_earned_lives", var_3);
        setDvar("arcademode_lives", var_3);
      }

      arcademode_redraw_lives(var_2);
      level.arcademode_redraw_score = 1;
      setDvar("arcademode_lives_changed", 0);
    }

    wait 0.05;
  }
}

arcademode_convert_extra_lives() {
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1) {
    thread extra_lives_display(var_0 - var_1);
  }
  setDvar("arcademode_earned_lives", var_0);
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
  level.player thread common_scripts\utility::play_sound_in_space("arcademode_checkpoint", level.player getEye());
  thread draw_checkpoint(var_0, var_1, 1);
  thread draw_checkpoint(var_0, var_1, -1);
}

arcademode_redraw_life(var_0, var_1) {
  if(var_0 >= var_1) {
    self setshader("arcademode_life", 64, 64);
  } else {
    self setshader("stance_stand", 64, 64);
  }
  self fadeovertime(1);
  self.alpha = 1;
  self.glowalpha = 1;
  self.color = level.color_cool_green;
}

arcademode_remove_life(var_0) {
  if(self.alpha <= 0) {
    return;
  }
  self fadeovertime(1);
  self.alpha = 0;
  self.color = (1, 0, 0);
  self.glowalpha = 0;
}

arcademode_redraw_lives(var_0) {
  if(var_0 > 10) {
    var_0 = 10;
  }
  var_1 = getdvarint("arcademode_earned_lives");

  for(var_2 = 0; var_2 < var_0; var_2++) {
    level.arcademode_lives_hud[var_2] arcademode_redraw_life(var_2, var_1);
  }
  for(var_2 = var_0; var_2 < level.arcademode_maxlives; var_2++) {
    if(var_2 < 0) {
      continue;
    }
    if(var_2 >= 10) {
      continue;
    }
    level.arcademode_lives_hud[var_2] arcademode_remove_life(var_2);
  }
}

arcademode_update_streak_progress() {
  for(;;) {
    level common_scripts\utility::waittill_either("arcademode_decrement_kill_streak", "arcademode_new_kill");
    waittillframeend;
    arcademode_redraw_streak_progress();
  }
}

arcademode_redraw_streak_progress() {
  for(var_0 = 0; var_0 < level.arcademode_kill_streak_current_count; var_0++) {
    if(var_0 >= level.arcademode_kills_hud.size) {
      return;
    }
    level.arcademode_kills_hud[var_0].color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
    level.arcademode_kills_hud[var_0].glowcolor = level.arcademode_streak_glow[level.arcademode_kill_streak_current_multiplier - 1];
  }

  var_1 = 0;

  for(;;) {
    var_2 = level.arcademode_kill_streak_current_multiplier + var_1;

    if(var_2 >= level.arcademode_streak_color.size) {
      var_2 = level.arcademode_streak_color.size - 1;
    }
    for(var_0 = level.arcademode_kill_streak_current_count + var_1 * level.arcademode_kill_streak_multiplier_count; var_0 < level.arcademode_kill_streak_current_count + (var_1 + 1) * level.arcademode_kill_streak_multiplier_count; var_0++) {
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

  if(level.arcademode_kills_hud.size == 0) {
    level.arcademode_kill_zero_x_location = var_6.x;
  }
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
  } else {
    var_6.alpha = 1;
  }
  for(;;) {
    if(var_6.x == level.arcademode_kill_zero_x_location) {
      var_8 = 4;

      if(level.arcademode_kills_hud.size == 1) {
        wait 3;
      }
      var_6 fadeovertime(var_8);
      var_6.color = (1, 0, 0);
      var_6.alpha = 0;
      wait(var_8);
      level notify("arcademode_decrement_kill_streak");
      var_6 destroy();

      for(var_9 = 0; var_9 < level.arcademode_kills_hud.size - 1; var_9++) {
        level.arcademode_kills_hud[var_9] = level.arcademode_kills_hud[var_9 + 1];
      }
      level.arcademode_kills_hud[level.arcademode_kills_hud.size - 1] = undefined;

      if(!level.arcademode_kills_hud.size) {
        thread arcademode_reset_kill_streak();
      }
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

  if(level.arcademode_kill_streak_ends < gettime()) {
    level.arcademode_kill_streak_ends = gettime() + var_0 * 1000;
  } else {
    level.arcademode_kill_streak_ends = level.arcademode_kill_streak_ends + var_0 * 1000;
  }
  waittillframeend;

  if(isDefined(level.arcademode_hud_streak)) {
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

  if(var_6 > var_3) {
    var_6 = var_3;
  }
  var_6 = var_6 * var_2;
  var_6 = int(var_6);

  if(var_6 > 980) {
    var_6 = 980;
  }
  if(!isDefined(var_4)) {
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

  for(;;) {
    var_6 = level.arcademode_kill_streak_ends - gettime();
    var_6 = var_6 * 0.001;
    var_8 = var_6;

    if(isDefined(level.arcademode_hud_streak)) {
      level.arcademode_hud_streak fadeovertime(1);
      level.arcademode_hud_streak.alpha = (var_8 - 1) / 5;
    }

    var_6 = var_6 * var_2;
    var_6 = int(var_6);

    if(var_6 <= 0) {
      var_6 = 1;
    }
    if(var_6 > 980) {
      var_6 = 980;
    }
    var_4 scaleovertime(1, var_6, var_1);
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
      level.player playSound("arcademode_" + level.arcademode_kill_streak_current_multiplier + "x");
      thread arcademode_draw_multiplier();
    }

    level.arcademode_kill_streak_current_count = level.arcademode_kill_streak_multiplier_count;
  }

  level notify("arcademode_new_kill");

  for(;;) {
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

  for(;;) {
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
  maps\_utility::add_wait(maps\_utility::_wait, var_0 + 1);
  level maps\_utility::add_wait(maps\_utility::waittill_msg, "lost_streak");
  maps\_utility::do_wait_any();
  thread arcademode_reset_kill_streak();
  musicstop();

  if(isDefined(level.last_song)) {
    wait 0.05;
    musicplay(level.last_song);
  }
}

get_hud_score() {
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.x = 0;
  var_0.y = 10;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.score = 0;
  var_0.font = "objective";
  var_0.fontscale = 5;
  var_0.sort = level.arcademode_hud_sort;
  var_0.glowcolor = level.color_cool_green_glow;
  var_0.glowalpha = 1;
  var_0.hidewheninmenu = 1;
  return var_0;
}

arcademode_update_score() {
  level.player endon("death");
  level.arcademode_hud_digits = 10;
  level.arcademode_hud_scores = [];

  for(var_0 = 0; var_0 < level.arcademode_hud_digits; var_0++) {
    level.arcademode_hud_scores[level.arcademode_hud_scores.size] = get_hud_score();
    level.arcademode_hud_scores[level.arcademode_hud_scores.size - 1].x = var_0 * -30;
  }

  if(getdvarint("arcademode_full")) {
    var_1 = getdvarint("arcademode_combined_score");
  } else {
    var_1 = getdvarint("arcademode_score");
  }
  hud_draw_score(var_1);
  level.arcademode_redraw_score = 0;

  for(;;) {
    wait 0.05;
    updatescoreelemsonce();

    if(level.arcademode_redraw_score) {
      level.arcademode_redraw_score = 0;
    }
  }
}

updatescoreelemsonce() {
  if(getdvarint("arcademode_full")) {
    hud_update_score("arcadeMode_combined_score");
  } else {
    hud_update_score("arcademode_score");
  }
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

  if(var_2 <= 15) {
    var_3 = 1;
  }
  level.arcademode_ramping_score = level.arcademode_ramping_score + var_3;

  if(level.arcademode_ramping_score > var_1) {
    level.arcademode_ramping_score = var_1;
  }
  hud_draw_score(int(level.arcademode_ramping_score));
}

get_digits_from_score(var_0) {
  var_1 = [];
  var_0 = int(var_0);

  for(;;) {
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

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 >= var_1.size - 1) {
      break;
    }

    var_1[var_3] setvalue(var_2[var_3]);
    var_1[var_3].alpha = 1;
  }

  for(var_3 = var_2.size; var_3 < var_1.size; var_3++) {
    var_1[var_3].alpha = 0;
  }
  if(var_0 == 0) {
    var_1[0].alpha = 1;
    var_1[0] setvalue(0);
  }
}

arcademode_add_life(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newhudelem();
  var_6.foreground = 1;
  var_6.x = var_1 + var_0 * var_3;
  var_6.y = var_2;
  var_6 setshader("stance_stand", var_4, var_4);
  var_6.alignx = "right";
  var_6.aligny = "top";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.sort = var_5;
  var_6.color = level.color_cool_green;
  var_6.glowcolor = level.color_cool_green_glow;
  var_6.glowalpha = 0;
  var_6.alpha = 0;
  var_6.hidewheninmenu = 1;
  level.arcademode_lives_hud[level.arcademode_lives_hud.size] = var_6;
}

arcademode_define_damage_multipliers() {
  var_0[0] = 40;
  var_0[1] = 30;
  var_0[2] = 25;
  var_0[3] = 20;
  level.arcademode_kills_until_next_extra_life = 10;
  level.arcademode_extra_lives_range = var_0;
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_1[var_2] = var_0[var_2] * 0.15;
  }
  level.arcademode_extra_lives_base = var_1;
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

  if(getDvar("widescreen") == "1") {
    var_4.fontscale = 5;
  }
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "objective";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(var_1);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.sort = level.arcademode_hud_sort + 10;
  return var_4;
}

extra_lives_display(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    thread extra_lives_sizzle();
  }
  var_2 = new_ending_hud("center", 0.2, 0, -100);
  var_2.label = &"SCRIPT_EXTRA_LIFE";
  var_2 setvalue(var_0);
  var_2 setpulsefx(5, 3000, 1000);
  wait 5;
  var_2 destroy();
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

  for(;;) {
    var_4 = randomfloatrange(0.1, 0.2);
    var_0 moveovertime(var_4);
    var_0.x = var_1 + randomfloatrange(var_3 * -1, var_3);
    var_0.y = var_2 + randomfloatrange(var_3 * -1, var_3);
    wait(var_4);
  }
}

round_up_to_five(var_0) {
  var_1 = var_0 - var_0 % 5;

  if(var_1 < var_0) {
    var_1 = var_1 + 5;
  }
  return var_1;
}

arcademode_add_points(var_0, var_1, var_2, var_3) {
  if(var_3 <= 0) {
    return;
  }
  if(isDefined(level.arcademode_deathtypes[var_2])) {
    var_2 = level.arcademode_deathtypes[var_2];
  }
  var_3 = int(var_3);
  var_3 = round_up_to_five(var_3);
  var_3 = var_3 * level.arcademode_kill_streak_current_multiplier;
  var_4 = getdvarint("arcademode_score");
  var_4 = var_4 + var_3;
  var_5 = getdvarint("arcademode_combined_score");
  var_5 = var_5 + var_3;
  setDvar("arcademode_combined_score", var_5);
  setDvar("arcademode_score", var_4);
  var_6 = 60;
  var_7 = 1.5;
  var_8 = 0.9 + (var_3 - 10) * 0.01;

  if(var_8 > 1.4) {
    var_8 = 1.4;
  }
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

  if(var_0 >= level.arcademode_maxlives) {
    var_0 = level.arcademode_maxlives;
  } else {
    setDvar("arcademode_lives", var_0);
    setDvar("arcademode_lives_changed", 1);
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

      if(var_2) {
        var_1 = 45;
      } else {
        var_1 = 135;
      }
    } else if(level.player.pointpulseindex == 2) {
      var_2 = level.player.thirdpointpulseside;

      if(var_2) {
        var_1 = 45;
      } else {
        var_1 = 135;
      }
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
  if(!isDefined(level.player.pointpulsecount)) {
    level.player.pointpulsecount = 0;
    level.player.pointpulseindex = 0;
  }

  var_1 = newhudelem();
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1 arcademode_set_origin_in_radius();
  var_1.font = "objective";
  var_1.fontscale = 2.5;
  var_1.archived = 0;
  var_1.color = (0.5, 0.5, 0.5);
  var_1.sort = 4;
  var_2 = level.arcademode_kill_streak_current_multiplier;
  level.player.pointpulsecount++;
  level.player.pointpulseindex++;
  wait 0.05;

  if(var_0 <= 0) {
    var_1.label = &"";
    var_1.color = (1, 0, 0);
    var_1.glowcolor = (0, 0, 0);
    var_1.glowalpha = 0;
  } else {
    var_1.label = &"SCRIPT_PLUS";
    var_1.color = (1, 1, 1);
    var_1.glowcolor = level.color_cool_green_glow;
    var_1.glowalpha = 1;
  }

  var_1 setvalue(var_0);
  var_1.alpha = 1;
  var_1 changefontscaleovertime(0.15);
  var_1.fontscale = 3.5;
  wait 0.15;
  var_1 moveovertime(1.75);
  var_1.y = var_1.y - 40;
  var_1 changefontscaleovertime(0.25);
  var_1.fontscale = 2.5;
  wait 0.25;
  wait 0.5;
  var_1 fadeovertime(1.0);
  var_1.alpha = 0;
  wait 0.5;
  level.player.pointpulsecount--;

  if(level.player.pointpulsecount == 0) {
    level.player.pointpulseindex = 0;
  }
  var_1 destroy();
}

set_circular_origin() {
  var_0 = 50;

  for(;;) {
    var_1 = randomint(var_0);
    var_2 = randomint(var_0);

    if(distance((0, 0, 0), (var_1, var_2, 0)) < var_0) {
      break;
    }
  }

  if(common_scripts\utility::cointoss()) {
    var_1 = var_1 * -1;
  }
  if(common_scripts\utility::cointoss()) {
    var_2 = var_2 * -1;
  }
  self.x = var_1;
  self.y = var_2;
}

arcademode_add_points_for_mod(var_0) {
  for(var_1 = 0; var_1 < level.arcademode_multikills[var_0].size; var_1++) {
    arcademode_add_points_for_individual_kill(level.arcademode_multikills[var_0][var_1], var_0, level.arcademode_multikills[var_0].size);
  }
}

arcademode_add_points_for_individual_kill(var_0, var_1, var_2) {
  if(var_0["type"] != "melee") {
    var_3 = level.arcademode_killbase + level.arcademode_locationkillbonus[var_0["damage_location"]] + level.arcademode_weaponbonus[var_0["type"]];
  } else {
    var_3 = level.arcademode_killbase + level.arcademode_weaponbonus[var_0["type"]];
  }
  thread arcademode_add_points(var_0["origin"], 1, var_1, var_3);
}

player_kill(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }
  var_3 = level.arcademode_deathtypes[var_0];

  if(!isDefined(var_3)) {
    var_4 = level.arcademode_killbase;
    thread arcademode_add_points(var_2, 1, "melee", var_4);
    return;
  }

  var_5["damage_location"] = var_1;
  var_5["type"] = var_3;
  var_5["origin"] = var_2;

  if(var_3 == "explosive") {
    var_5["origin"] = self.origin;
  }
  level.arcademode_multikills[var_3][level.arcademode_multikills[var_3].size] = var_5;
}

player_damage(var_0, var_1, var_2) {
  thread arcademode_add_points(var_2, 0, var_0, level.arcademode_damagebase);
}

player_damage_ads(var_0, var_1, var_2) {
  thread arcademode_add_points(var_2, 0, var_0, level.arcademode_damagebase * 1.25);
}

end_mission() {
  setsaveddvar("ui_nextMission", "0");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.maxhealth = 0;
    var_1.health = 1;
  }

  missionsuccess("killhouse");
}

create_total_score_hud(var_0, var_1) {
  level.arcademode_hud_total_scores = [];

  for(var_2 = 0; var_2 < level.arcademode_hud_digits; var_2++) {
    var_3 = get_hud_score();
    level.arcademode_hud_total_scores[level.arcademode_hud_total_scores.size] = var_3;
    var_3.x = var_2 * -30 + -150 + var_0;
    var_3.y = var_1;
    var_3.alignx = "right";
    var_3.aligny = "middle";
    var_3.horzalign = "right";
    var_3.vertalign = "middle";
    var_3.alpha = 0;
    var_3.sort = level.arcademode_hud_sort + 10;
  }
}

set_total_score_hud(var_0) {
  hud_draw_score_for_elements(var_0, level.arcademode_hud_total_scores);
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
    if(arcademode_convert_extra_lives()) {
      wait 2;
    }
  }

  var_0 = 0;

  if(isDefined(level.arcademode_stoptime)) {
    var_0 = gettime() - level.arcademode_stoptime;
    var_0 = var_0 * 0.001;
  }

  var_1 = gettime() - level.arcdemode_starttime;
  var_1 = var_1 * 0.001;
  var_1 = var_1 - var_0;
  var_2 = level.arcademode_time - var_1;
  var_2 = int(var_2);

  if(var_2 == 0) {
    var_2++;
  }
  var_3 = 0.5;
  level.mission_failed_disabled = 1;
  thread player_invul_forever();
  thread black_background(var_3);
  wait(var_3 + 0.25);
  level.player freezecontrols(1);
  var_4 = 1;
  var_5 = -140;
  var_6 = -80;
  var_7 = -20;
  var_8 = 40;
  var_9 = 100;
  var_10 = 300;
  var_11 = new_ending_hud("center", var_4, 0, var_5);

  if(level.arcademode_success) {
    var_11.color = (1, 1, 1);
    var_11 settext(&"SCRIPT_MISSION_COMPLETE");
  } else {
    var_11.color = (1, 0.4, 0.2);
    var_11.glowcolor = (0.75, 0.3, 0.3);
    var_11 settext(level.arcademode_failurestring);
  }

  wait 1.0;

  for(var_12 = 0; var_12 < level.arcademode_maxlives; var_12++) {
    level.arcademode_lives_hud[var_12] destroy();
  }
  var_13 = 130;
  level.arcademode_lives_hud = [];

  for(var_12 = 0; var_12 < level.arcademode_maxlives; var_12++) {
    arcademode_add_life(var_12, -135 + var_13, var_10, -30, 96, level.arcademode_hud_sort + 10);
  }
  var_14 = getdvarint("arcademode_lives");
  var_15 = level.arcademode_rewarded_lives;

  if(var_14 > var_15) {
    var_14 = var_15;
  }
  arcademode_redraw_lives(var_14);
  var_16 = 0;
  var_17 = undefined;

  if(getDvar("arcademode_full") == "1") {
    var_17 = new_ending_hud("left", var_4, 20, var_6);
    var_17 settext(&"SCRIPT_TOTAL_SCORE");
    create_total_score_hud(var_13, var_6);
    var_16 = getdvarint("arcademode_combined_score");
    set_total_score_hud(var_16);
  }

  var_18 = new_ending_hud("left", var_4, 20, var_7);
  var_18 settext(&"SCRIPT_MISSION_SCORE");

  for(var_12 = 0; var_12 < level.arcademode_hud_digits; var_12++) {
    var_19 = level.arcademode_hud_scores[var_12];
    var_19.x = var_12 * -30 + -150 + var_13;
    var_19.y = var_7;
    var_19.sort = level.arcademode_hud_sort + 10;
    var_19.alignx = "right";
    var_19.aligny = "middle";
    var_19.horzalign = "right";
    var_19.vertalign = "middle";
  }

  hud_draw_score(0);
  var_20 = 0;

  for(var_21 = 0; var_2 >= 60; var_2 = var_2 - 60) {
    var_20++;
  }
  var_21 = var_2;
  var_22 = new_ending_hud("left", var_4, 20, var_8);
  var_22 settext(&"SCRIPT_TIME_REMAINING");
  level.arcademode_hud_timer_minutes_tens = new_ending_hud("right", var_4, -265 + var_13, var_8);
  level.arcademode_hud_timer_minutes_ones = new_ending_hud("right", var_4, -235 + var_13, var_8);
  var_23 = new_ending_hud("right", var_4, -215 + var_13, var_8 - 5);
  var_23 settext(&"SCRIPT_COLON");
  level.arcademode_hud_timer_seconds_tens = new_ending_hud("right", var_4, -180 + var_13, var_8);
  level.arcademode_hud_timer_seconds_ones = new_ending_hud("right", var_4, -150 + var_13, var_8);
  ending_set_time(var_20, var_21);
  wait(var_4);
  wait 1;
  var_24 = getdvarint("arcadeMode_score");
  var_25 = 0;
  var_26 = var_16;
  var_27 = 0;

  for(;;) {
    var_28 = var_24 - var_25;
    var_29 = var_28 * 0.2 + 1;

    if(var_28 <= 15) {
      var_29 = 1;
    }
    var_29 = int(var_29);
    var_25 = var_25 + var_29;

    if(var_25 > var_24) {
      var_25 = var_24;
    }
    hud_draw_score(var_25);

    if(var_25 == var_24) {
      break;
    }

    var_27--;

    if(var_27 <= 0) {
      level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_dirt", level.player getEye());
      var_27 = 3;
    }

    wait 0.05;
  }

  wait 1;
  var_30 = 0;
  var_31 = undefined;

  if(level.arcademode_success) {
    var_32 = 5;
    var_33 = var_20 * 60 + var_21;
    var_34 = ceil(var_33 / 15);
    var_35 = ceil(var_33 * var_32);
    var_36 = ceil(var_35 / level.arcademode_difficultytimerscale);
    var_37 = var_25;
    var_38 = var_25 + var_36;
    var_39 = var_16;
    var_40 = var_16 + var_36;

    for(var_12 = 1; var_12 <= var_34; var_12++) {
      var_41 = var_12 * 1.0 / var_34;

      if(var_12 == var_34) {
        var_41 = 1;
      }
      var_25 = int(var_37 * (1 - var_41) + var_38 * var_41);

      if(getDvar("arcademode_full") == "1") {
        var_16 = int(var_39 * (1 - var_41) + var_40 * var_41);
        set_total_score_hud(var_16);
      }

      hud_draw_score(var_25);
      var_42 = int(var_33 * (1 - var_41));
      ending_set_time(floor(var_42 / 60), var_42 % 60);
      var_27--;

      if(var_27 <= 0) {
        level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_metal", level.player getEye());
        var_27 = 3;
      }

      wait 0.05;
    }

    ending_set_time(0, 0);
    wait 1;

    for(;;) {
      var_43 = 1;

      if(var_14 > 10) {
        var_44 = var_14 % 10;

        if(var_14 - var_44 >= 10) {
          var_43 = 10;
        } else {
          var_43 = var_44;
        }
        if(var_14 < 20) {
          var_43 = var_44;
        }
      }

      var_14 = var_14 - var_43;

      if(var_14 < 0) {
        break;
      }

      var_45 = 1000;
      var_45 = var_45 * var_43;
      var_29 = int(var_45);

      if(getDvar("arcademode_full") == "1") {
        var_16 = var_16 + var_29;
        set_total_score_hud(var_16);
      }

      var_25 = var_25 + var_29;
      level.player thread common_scripts\utility::play_sound_in_space("mortar_explosion", level.player getEye());
      hud_draw_score(int(var_25));
      arcademode_redraw_lives(var_14);
      wait 0.6;
    }

    wait 1;

    if(getdvarint("arcademode_died") != 1 && level.gameskill >= 2) {
      var_29 = int(var_25);
      arcademode_end_boost(var_25, var_16, var_29, &"SCRIPT_ZERO_DEATHS", "bullet_ap_bark", var_9, var_4);
      var_25 = var_25 + var_29;
      var_16 = var_16 + var_29;
    }
  } else {
    level.arcademode_hud_timer_seconds_ones setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_seconds_tens setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_minutes_ones setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_minutes_tens setpulsefx(0, 0, 1000);
    var_23 setpulsefx(0, 0, 1000);
    var_22 setpulsefx(0, 0, 1000);
    arcademode_redraw_lives(0);
    wait 2;
  }

  var_46 = level.arcademode_skillmultiplier[level.gameskill];

  if(var_46 > 1) {
    if(var_46 == 1.5) {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF";
    } else if(var_46 == 3) {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_THREE";
    } else {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_FOUR";
    }
    var_29 = int(ceil(var_25 * var_46) - var_25);
    arcademode_end_boost(var_25, var_16, var_29, var_47, "bullet_ap_glass", var_9, var_4);
    var_25 = var_25 + var_29;
    var_16 = var_16 + var_29;
  }

  var_48 = 0;

  if(getDvar("arcademode_full") == "1") {
    var_49 = "s18";
    var_50 = getdvarint(var_49);

    if(var_16 > var_50) {
      var_51 = get_digits_from_score(var_16);
      var_52 = get_score_string_from_digits(var_51);
      setDvar(var_49, var_52);
      var_53 = 0;

      if(!level.arcademode_success) {
        var_53 = 1;
      }
      if(level.script == "airplane") {
        var_53 = 1;
      }
      if(var_53) {
        var_48 = 1;
      }
    }

    level.player uploadscore("LB_FULL", getdvarint(var_49));
  } else {
    var_54 = [];
  }
  if(var_48) {
    if(!level.arcademode_success) {
      updategamerprofile();
    }
    wait 1;
    var_55 = new_ending_hud("center", var_4, 0, var_9);
    var_55 settext(&"SCRIPT_NEW_HIGH_SCORE");
    var_55.alpha = 1;
    var_55 fadeovertime(0.05);
    var_55 setpulsefx(30, 3000, 1000);
    wait 3.5;
  }

  wait 2;
  var_11 setpulsefx(0, 0, 1000);
  wait 0.5;
  var_18 setpulsefx(0, 0, 1000);

  for(var_12 = 0; var_12 < level.arcademode_hud_digits; var_12++) {
    var_19 = level.arcademode_hud_scores[var_12];
    var_19 setpulsefx(0, 0, 1000);
  }

  if(getDvar("arcademode_full") == "1") {
    var_17 setpulsefx(0, 0, 1000);

    for(var_12 = 0; var_12 < level.arcademode_hud_digits; var_12++) {
      var_19 = level.arcademode_hud_total_scores[var_12];
      var_19 setpulsefx(0, 0, 1000);
    }
  }

  if(level.arcademode_success) {
    wait 0.5;
    level.arcademode_hud_timer_seconds_ones setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_seconds_tens setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_minutes_ones setpulsefx(0, 0, 1000);
    level.arcademode_hud_timer_minutes_tens setpulsefx(0, 0, 1000);
    var_23 setpulsefx(0, 0, 1000);
    var_22 setpulsefx(0, 0, 1000);
  }

  wait 1;

  if(getDvar("arcademode_full") == "1") {
    logstring("ArcadeMode Score: " + var_25 + ", mission: " + level.script + ", gameskill: " + level.gameskill + ", total: " + var_16);
  } else {
    logstring("ArcadeMode Score: " + var_25 + ", mission: " + level.script + ", gameskill: " + level.gameskill);
  }
  setDvar("arcademode_combined_score", var_16);

  if(!level.arcademode_success) {
    setDvar("ui_arcade_lost", 1);
    end_mission();
  } else {
    setDvar("ui_arcade_lost", 0);
  }
  common_scripts\utility::flag_set("arcademode_ending_complete");
}

arcademode_end_boost(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = new_ending_hud("center", var_6, 0, var_5);
  var_7 settext(var_3);
  var_7.alpha = 1;
  var_7 fadeovertime(0.05);
  wait 0.05;
  wait 1.0;
  var_8 = 0;
  var_9 = var_0 + var_2;
  var_10 = var_1 + var_2;

  for(;;) {
    var_11 = var_9 - var_0;
    var_2 = var_11 * 0.2 + 1;

    if(var_11 <= 15) {
      var_2 = 1;
    }
    var_2 = int(var_2);
    var_0 = var_0 + var_2;

    if(var_0 > var_9) {
      var_0 = var_9;
    }
    hud_draw_score(var_0);

    if(getDvar("arcademode_full") == "1") {
      var_1 = var_1 + var_2;

      if(var_1 > var_10) {
        var_1 = var_10;
      }
      set_total_score_hud(var_1);
    }

    if(var_0 == var_9) {
      break;
    }

    var_8--;

    if(var_8 <= 0) {
      level.player thread common_scripts\utility::play_sound_in_space(var_4, level.player getEye());
      var_8 = 3;
    }

    wait 0.05;
  }

  wait 0.5;
  var_7 setpulsefx(0, 0, 1000);
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

  if(var_0 > 0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 1;
}

player_invul_forever() {
  for(;;) {
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

  for(var_3 = 0; var_0 >= 10; var_0 = var_0 - 10) {
    var_2++;
  }
  while(var_1 >= 10) {
    var_3++;
    var_1 = var_1 - 10;
  }

  level.arcademode_hud_timer_seconds_ones setvalue(var_1);
  level.arcademode_hud_timer_seconds_tens setvalue(var_3);
  level.arcademode_hud_timer_minutes_ones setvalue(var_0);
  level.arcademode_hud_timer_minutes_tens setvalue(var_2);
}

draw_checkpoint(var_0, var_1, var_2) {
  var_0 = var_0 * var_2;
  var_3 = new_ending_hud("center", 0.1, var_0, 90);
  var_3 settext(&"SCRIPT_CHECKPOINT");
  var_3 moveovertime(var_1);
  var_3.x = 0;
  wait(var_1);
  wait 0.5;
  var_3 moveovertime(var_1);
  var_3.x = var_0 * -1;
  wait(var_1);
  var_3 destroy();
}

arcademode_checkpoint_getid(var_0) {
  for(var_1 = 0; var_1 < level.arcademode_checkpoint_dvars.size; var_1++) {
    if(level.arcademode_checkpoint_dvars[var_1] == var_0) {
      return var_1;
    }
  }

  return undefined;
}

arcademode_init_kill_streak_colors() {
  level.arcademode_streak_color = [];
  level.arcademode_streak_glow = [];
  level.arcademode_streak_color[level.arcademode_streak_color.size] = level.color_cool_green;
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.8, 0.8, 2);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (2, 0.8, 0);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.5, 2, 2);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (2, 0.5, 2);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.3, 0.3, 2);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (2, 2, 0.5);
  level.arcademode_streak_color[level.arcademode_streak_color.size] = (2, 2, 2);

  for(var_0 = 0; var_0 < level.arcademode_streak_color.size; var_0++) {
    level.arcademode_streak_glow[var_0] = (level.arcademode_streak_color[var_0][0] * 0.35, level.arcademode_streak_color[var_0][1] * 0.35, level.arcademode_streak_color[var_0][2] * 0.35);
  }
  level.arcademode_streak_color[0] = level.color_cool_green_glow;
}

arcademode_killstreak_complete_display() {
  if(level.arcademode_kill_streak_current_multiplier == 1) {
    return;
  }
  if(common_scripts\utility::flag("arcademode_complete")) {
    return;
  }
  var_0 = new_ending_hud("right", 0.2, -10, -57);
  var_0 setpulsefx(5, 3000, 1000);
  var_0.fontscale = 2;

  if(level.arcademode_kill_streak_current_multiplier >= 8) {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_won", level.player getEye());
    var_0 settext(&"SCRIPT_STREAK_COMPLETE");
  } else {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_lost", level.player getEye());
    var_0 settext(&"SCRIPT_STREAK_BONUS_LOST");
  }

  wait 5;
  var_0 destroy();
}

arcademode_reset_kill_streak_art() {
  if(isDefined(level.arcademode_streak_hud)) {
    level.arcademode_streak_hud destroy();
    level.arcademode_streak_hud = undefined;
    level.arcademode_streak_hud_shadow destroy();
  }

  level notify("arcademode_stop_kill_streak_art");

  for(var_0 = 0; var_0 < level.arcademode_kills_hud.size; var_0++) {
    level.arcademode_kills_hud[var_0] destroy();
  }
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
  var_0 = newhudelem();
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0 thread arcademode_draw_multiplier_kill();
  var_0.x = 0;
  var_0.y = 126;
  var_0.font = "objective";
  var_0.fontscale = 0.1;
  var_0.archived = 0;
  var_0.foreground = 1;
  var_0.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
  var_0.glowcolor = level.arcademode_streak_glow[level.arcademode_kill_streak_current_multiplier - 1];
  var_0.sort = level.arcademode_hud_sort;
  var_0.label = &"SCRIPT_X";
  var_0 setvalue(level.arcademode_kill_streak_current_multiplier);
  var_0 changefontscaleovertime(0.5);
  var_0.fontscale = 3;
  var_0.alpha = 0;
  var_0 fadeovertime(0.5);
  var_0.alpha = 1.0;
  return var_0;
}

arcademode_draw_multiplier() {
  for(var_0 = 0; var_0 < 40; var_0++) {
    var_1 = get_hud_multi();
    var_1 thread arcademode_draw_mult_sizzle();
  }

  level endon("arcademode_new_kill_streak");
  var_2 = get_hud_multi();
  level.arcademode_hud_streak = var_2;
  level waittill("arcademode_stop_kill_streak");
  var_2 setpulsefx(0, 0, 1000);
  wait 1;
  var_2 destroy();
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

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2] + var_1;
  }
  return var_1;
}