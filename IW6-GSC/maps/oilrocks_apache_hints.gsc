/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_hints.gsc
******************************************/

apache_hints_precache() {
  level.oilrocks_apache_hint_timers = [];
  maps\_utility::add_hint_string("hint_apache_move", &"OILROCKS_HINT_APACHE_MOVE", maps\oilrocks_apache_hints_code::apache_hints_move);
  maps\_utility::add_hint_string("hint_apache_ads", &"OILROCKS_HINT_APACHE_ADS", maps\oilrocks_apache_hints_code::apache_hints_break_ads);
  maps\_utility::add_hint_string("hint_apache_ads_hold", &"OILROCKS_HINT_ADS_HOLD", maps\oilrocks_apache_hints_code::apache_hints_break_ads);
  maps\_utility::add_hint_string("hint_apache_mg", &"OILROCKS_HINT_APACHE_MG", maps\oilrocks_apache_hints_code::apache_hints_break_mg);
  maps\_utility::add_hint_string("hint_apache_missile_straight", &"OILROCKS_HINT_APACHE_MISSILE_STRAIGHT", maps\oilrocks_apache_hints_code::apache_hints_break_missile_straight);
  maps\_utility::add_hint_string("hint_apache_flares", &"OILROCKS_HINT_APACHE_FLARES", maps\oilrocks_apache_hints_code::apache_hints_break_flares);
  maps\_utility::add_hint_string("hint_apache_missile_lockon", &"OILROCKS_HINT_APACHE_MISSILE_LOCKON", maps\oilrocks_apache_hints_code::apache_hints_break_missile_lockon);
  maps\_utility::add_hint_string("hint_apache_missile_lockon_release", &"OILROCKS_HINT_APACHE_MISSILE_LOCKON_RELEASE", maps\oilrocks_apache_hints_code::apache_hints_released_homing);
}

apache_hints_display_hint_timeout(var_0, var_1) {
  maps\_utility::display_hint_timeout_mintime(var_0, var_1, 1);
}

apache_hints_tutorial() {
  common_scripts\utility::flag_wait("introscreen_complete");
  common_scripts\utility::flag_wait_or_timeout("FLAG_apache_tut_fly_stop_auto_pilot", 3.5);

  if(!common_scripts\utility::flag("FLAG_apache_tut_fly_stop_auto_pilot")) {
    level.player apache_hints_display_hint_timeout("hint_apache_move", 5.0);
  }
}

apache_hints_factory() {
  wait 0.15;
  thread hint_missile_lock();
  var_0 = gettime();
  common_scripts\utility::flag_wait("FLAG_apache_factory_hint_mg");
  level.player apache_hints_display_hint_timeout("hint_apache_mg", 5.0);
  thread homing_hint();
  common_scripts\utility::flag_wait_or_timeout("FLAG_apache_factory_player_close", 3.0);
  common_scripts\utility::flag_wait_or_timeout("FLAG_apache_factory_hint_missiles", 3.0);
  level.player apache_hints_display_hint_timeout("hint_apache_missile_straight", 5.0);
}

homing_hint() {
  if(level.apache_difficulty.flares_auto) {
    return;
  }
  level waittill("homing_hint");
  level.player apache_hints_display_hint_timeout("hint_apache_flares", 5.0);
}

apache_hints_island() {
  common_scripts\utility::flag_wait("FLAG_apache_escort_allies_01");
  ads_hint();
}

ads_hint() {
  if(getkeybinding("+toggleads_throw")["count"] > 0) {
    level.player apache_hints_display_hint_timeout("hint_apache_ads", 5.0);
  }
  else {
    level.player apache_hints_display_hint_timeout("hint_apache_ads_hold", 5.0);
  }
}

apache_hints_chopper() {
  level endon("FLAG_apache_chopper_finished");
  common_scripts\utility::flag_wait("FLAG_apache_chopper_vo_take_it_done");
}

hint_missile_lock() {
  level notify("new_hint_missile_lock");
  level endon("new_hint_missile_lock");
  var_0 = "hint_apache_missile_lockon";
  var_1 = "hint_apache_missile_lockon_release";
  level.player apache_hints_display_hint_timeout(var_0, 5.0);

  while(!maps\_utility::check_hint_condition(var_0)) {
    wait 0.05;

    if(!isDefined(level.player.riding_heli)) {
      return;
    }
  }

  maps\_utility::display_hint_timeout_mintime(var_1, 5);
}