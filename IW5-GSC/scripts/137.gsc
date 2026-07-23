/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\137.gsc
**************************************/

specialops_init() {
  foreach(var_1 in level.players) {}
  var_1 thread roundstat_init();

  if(maps\_utility::is_coop()) {
    maps\_gameskill::setglobaldifficulty();

    foreach(var_4, var_1 in level.players) {}
    var_1 maps\_gameskill::setdifficulty();
  }

  if(!isDefined(level.so_override)) {
    level.so_override = [];
  }
  if(!isDefined(level.friendlyfire_warnings)) {
    level.friendlyfire_warnings = 1;
  }
  level.no_friendly_fire_penalty = 1;
  precacheminimapsentrycodeassets();
  precachemenu("sp_eog_summary");
  precachemenu("coop_eog_summary");
  precachemenu("coop_eog_summary2");
  precachemenu("surHUD_display");
  precacheshellshock("so_finished");
  precacheshader("hud_show_timer");
  precacheshader("specops_ui_equipmentstore");
  precacheshader("specops_ui_weaponstore");
  precacheshader("specops_ui_airsupport");
  so_precache_strings();

  foreach(var_1 in level.players) {
    var_1.so_hud_show_time = gettime() + so_standard_wait() * 1000;
    var_1 maps\_utility::ent_flag_init("so_hud_can_toggle");
  }

  level.challenge_time_nudge = 30;
  level.challenge_time_hurry = 10;
  level.func_destructible_crush_player = ::so_crush_player;
  setsaveddvar("g_friendlyfireDamageScale", 2);
  setsaveddvar("turretSentryRestrictUsageToOwner", 0);

  if(isDefined(level.so_compass_zoom)) {
    var_7 = 0;

    switch (level.so_compass_zoom) {
      case "close":
        var_7 = 1500;
        break;
      case "far":
        var_7 = 6000;
        break;
      default:
        var_7 = 3000;
        break;
    }

    if(!issplitscreen()) {
      var_7 = var_7 + var_7 * 0.1;
    }
    setsaveddvar("compassmaxrange", var_7);
  }

  common_scripts\utility::flag_init("challenge_timer_passed");
  common_scripts\utility::flag_init("challenge_timer_expired");
  common_scripts\utility::flag_init("special_op_succeeded");
  common_scripts\utility::flag_init("special_op_failed");
  common_scripts\utility::flag_init("special_op_terminated");
  common_scripts\utility::flag_init("special_op_p1ready");
  common_scripts\utility::flag_init("special_op_p2ready");
  common_scripts\utility::flag_init("special_op_no_unlink");
  common_scripts\utility::flag_init("special_op_final_xp_given");
  thread maps\_specialops_code::disable_saving();
  thread maps\_specialops_code::specialops_detect_death();
  maps\_specialops_code::specialops_dialog_init();

  if(maps\_utility::is_coop()) {
    maps\_specialops_battlechatter::init();
  }
  if(!isDefined(level.so_dialog_func_override)) {
    level.so_dialog_func_override = [];
  }
  if(!maps\_utility::is_coop()) {
    maps\_utility::set_custom_gameskill_func(maps\_gameskill::solo_player_in_special_ops);
  } else if(maps\_utility::is_survival()) {
    maps\_utility::set_custom_gameskill_func(maps\_gameskill::coop_player_in_special_ops_survival);
  }
  common_scripts\utility::array_thread(getEntArray("trigger_multiple_SO_escapewarning", "classname"), maps\_specialops_code::enable_escape_warning_auto);
  common_scripts\utility::array_thread(getEntArray("trigger_multiple_SO_escapefailure", "classname"), maps\_specialops_code::enable_escape_failure_auto);
  level.so_deadquotes_chance = 0.5;
  setDvar("ui_deadquote", "");
  thread maps\_specialops_code::so_special_failure_hint();
  setDvar("ui_skip_level_select", "1");
  setDvar("ui_opensummary", 0);
  var_8 = "LB_" + level.script;
  var_9 = "";

  if(maps\_utility::is_coop()) {
    var_8 = var_8 + "_TEAM";
  }
  if(maps\_utility::is_survival()) {
    var_9 = " LB_EXT_" + level.script;

    if(maps\_utility::is_coop()) {
      var_9 = var_9 + "_TEAM";
    }
  }

  precacheleaderboards(var_8 + var_9);
  maps\_specialops_code::pick_starting_location_so();
  level thread setsouniquesaveddvars();
  maps\_audio::aud_set_spec_ops();
  maps\_specialops_code::register_level_unlock("so_mw3_mission_2", "mission");
  maps\_specialops_code::register_level_unlock("so_mw3_mission_3", "mission");
  maps\_specialops_code::register_level_unlock("so_mw3_mission_4", "mission");
  maps\_specialops_code::register_survival_unlock();
  maps\_rank::init();
  maps\_missions::init();
  maps\_utility::enable_damagefeedback();
  maps\_utility::add_global_spawn_function("axis", maps\_specialops_code::so_ai_flashed_damage_feedback);
  thread maps\_specialops_code::setup_xp();
  thread unlock_hint();
  thread so_achievement_init();
}

roundstat_init() {
  wait 0.05;
  self setplayerdata("round", "kills", 0);
  self setplayerdata("round", "killStreak", 0);
  self setplayerdata("round", "deaths", 0);
  self setplayerdata("round", "difficulty", 0);
  self setplayerdata("round", "score", 0);
  self setplayerdata("round", "timePlayed", 0);
  self setplayerdata("round", "wave", 0);
  self setplayerdata("round", "xuidTeammate", "0");
  self setplayerdata("round", "totalXp", 0);
  self setplayerdata("round", "scoreXp", 0);
  self setplayerdata("round", "challengeXp", 0);
}

setsouniquesaveddvars() {
  setsaveddvar("hud_fade_ammodisplay", 30);
  setsaveddvar("hud_fade_stance", 30);
  setsaveddvar("hud_fade_offhand", 30);
  setsaveddvar("hud_fade_compass", 0);
}

so_precache_strings() {
  precachestring(&"SPECIAL_OPS_TIME_NULL");
  precachestring(&"SPECIAL_OPS_TIME");
  precachestring(&"SPECIAL_OPS_WAITING_P1");
  precachestring(&"SPECIAL_OPS_WAITING_P2");
  precachestring(&"SPECIAL_OPS_REVIVE_NAG_HINT");
  precachestring(&"SPECIAL_OPS_CHALLENGE_SUCCESS");
  precachestring(&"SPECIAL_OPS_CHALLENGE_FAILURE");
  precachestring(&"SPECIAL_OPS_FAILURE_HINT_TIME");
  precachestring(&"SPECIAL_OPS_ESCAPE_WARNING");
  precachestring(&"SPECIAL_OPS_ESCAPE_SPLASH");
  precachestring(&"SPECIAL_OPS_WAITING_OTHER_PLAYER");
  precachestring(&"SPECIAL_OPS_STARTING_IN");
  precachestring(&"SPECIAL_OPS_UI_TIME");
  precachestring(&"SPECIAL_OPS_UI_KILLS");
  precachestring(&"SPECIAL_OPS_UI_DIFFICULTY");
  precachestring(&"SPECIAL_OPS_UI_PLAY_AGAIN");
  precachestring(&"SPECIAL_OPS_DASHDASH");
  precachestring(&"SPECIAL_OPS_HOSTILES");
  precachestring(&"SPECIAL_OPS_INTERMISSION_WAVENUM");
  precachestring(&"SPECIAL_OPS_INTERMISSION_WAVEFINAL");
  precachestring(&"SPECIAL_OPS_WAVENUM");
  precachestring(&"SPECIAL_OPS_WAVEFINAL");
  precachestring(&"SPECIAL_OPS_PRESS_TO_CANCEL");
  precachestring(&"SPECIAL_OPS_PLAYER_IS_READY");
  precachestring(&"SPECIAL_OPS_PRESS_TO_START");
  precachestring(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  precachestring(&"SPECIAL_OPS_EMPTY");
}

so_standard_wait() {
  return 4;
}

specialops_remove_unused() {
  var_0 = getEntArray();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\_utility::is_specialop();

  foreach(var_3 in var_0) {
    if(var_3 maps\_specialops_code::specialops_remove_entity_check(var_1)) {
      var_3 delete();
    }
  }

  maps\_specialops_code::so_special_failure_hint_reset_dvars();
}

enable_triggered_start(var_0) {
  level endon("challenge_timer_expired");
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

enable_triggered_complete(var_0, var_1, var_2) {
  level endon("challenge_timer_expired");
  common_scripts\utility::flag_set(var_0);

  if(!isDefined(var_2)) {
    var_2 = "freeze";
  }
  var_3 = getEnt(var_0, "script_noteworthy");
  thread maps\_specialops_code::disable_mission_end_trigger(var_3);

  switch (var_2) {
    case "all":
      maps\_specialops_code::wait_all_players_are_touching(var_3);
      break;
    case "any":
      maps\_specialops_code::wait_all_players_have_touched(var_3, var_2);
      break;
    case "freeze":
      maps\_specialops_code::wait_all_players_have_touched(var_3, var_2);
      break;
  }

  level.challenge_end_time = gettime();
  common_scripts\utility::flag_set(var_1);
}

fade_challenge_in(var_0, var_1) {
  if(!maps\_utility::is_survival()) {
    foreach(var_3 in level.players) {}
    var_3 thread enable_kill_counter();
  }

  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }
  var_5 = 1;

  if(isDefined(level.so_waiting_for_players_alpha)) {
    var_5 = level.so_waiting_for_players_alpha;
  }
  var_6 = maps\_hud_util::create_client_overlay("black", var_5);
  wait(var_0);
  level notify("challenge_fading_in");
  var_7 = 1;
  var_6 thread maps\_hud_util::fade_over_time(0, var_7);
  level thread maps\_utility::notify_delay("challenge_fadein_complete", var_7);

  if(common_scripts\utility::flag_exist("slamzoom_finished")) {
    common_scripts\utility::flag_wait("slamzoom_finished");
  }
  wait 0.75;

  if(!isDefined(var_1) || var_1) {
    thread so_dialog_ready_up();
  }
}

fade_challenge_out(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }
  var_2 = undefined;

  if(maps\_utility::is_survival()) {
    var_2 = 1;

    if(!var_1) {
      var_1 = level.current_wave < level.congrat_min_wave;
    }
  }

  if(!var_1) {
    thread so_dialog_mission_success(var_2);
  }
  maps\_endmission::so_eog_summary_calculate(1);
  maps\_specialops_code::specialops_mission_over_setup(1);
  maps\_specialops_code::so_mission_complete_achivements();

  if(maps\_utility::is_survival()) {
    level notify("so_generate_deathquote");
  }
  maps\_endmission::so_eog_summary_display();
}

override_summary_time(var_0) {
  self.so_eog_summary_data["time"] = maps\_utility::round_millisec_on_sec(var_0, 1, 0);
}

override_summary_kills(var_0) {
  self.so_eog_summary_data["kills"] = var_0;
}

override_summary_score(var_0) {
  self.so_eog_summary_data["score"] = var_0;
}

enable_countdown_timer(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_STARTING_IN";
  }
  var_4 = so_create_hud_item(0, so_hud_ypos(), var_2);
  var_4 setpulsefx(50, var_0 * 1000, 500);
  var_5 = so_create_hud_item(0, so_hud_ypos());
  var_5 thread show_countdown_timer_time(var_0, var_3);
  wait(var_0);
  level.player playSound("arcademode_zerodeaths");

  if(isDefined(var_1) && var_1) {
    level.challenge_start_time = gettime();
  }
  thread destroy_countdown_timer(var_4, var_5);
}

destroy_countdown_timer(var_0, var_1) {
  wait 1;
  var_0 destroy();
  var_1 destroy();
}

show_countdown_timer_time(var_0, var_1) {
  self.alignx = "left";
  self settenthstimer(var_0);
  self.alpha = 0;

  if(!isDefined(var_1)) {
    var_1 = 0.625;
  }
  wait(var_1);
  var_0 = int((var_0 - var_1) * 1000);
  self setpulsefx(50, var_0, 500);
  self.alpha = 1;
}

enable_challenge_timer(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    if(!common_scripts\utility::flag_exist(var_0)) {
      common_scripts\utility::flag_init(var_0);
    }
    level.start_flag = var_0;
  }

  if(isDefined(var_1)) {
    if(!common_scripts\utility::flag_exist(var_1)) {
      common_scripts\utility::flag_init(var_1);
    }
    level.passed_flag = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_TIME";
  }
  if(!isDefined(level.challenge_time_beep_start)) {
    level.challenge_time_beep_start = level.challenge_time_hurry;
  }
  level.so_challenge_time_beep = level.challenge_time_beep_start + 1;

  foreach(var_5 in level.players) {}
  var_5 thread maps\_specialops_code::challenge_timer_player_setup(var_0, var_1, var_2, var_3);
}

enable_challenge_counter(var_0, var_1, var_2) {
  if(!isDefined(self.hud_so_counter_messages)) {
    self.hud_so_counter_messages = [];
  }
  if(!isDefined(self.hud_so_counter_values)) {
    self.hud_so_counter_values = [];
  }
  thread enable_challenge_counter_think(var_0, var_1, var_2);
}

enable_challenge_counter_think(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  disable_challenge_counter(var_0);
  self endon(challenge_counter_get_disable_notify(var_0));
  var_3 = so_hud_ypos();
  self.hud_so_counter_messages[var_0] = so_create_hud_item(var_0, var_3, var_1, self);
  self.hud_so_counter_values[var_0] = so_create_hud_item(var_0, var_3, undefined, self);
  self.hud_so_counter_values[var_0] settext(0);
  self.hud_so_counter_values[var_0].alignx = "left";
  childthread info_hud_handle_fade(self.hud_so_counter_messages[var_0]);
  childthread info_hud_handle_fade(self.hud_so_counter_values[var_0]);

  if(!isDefined(level.challenge_counter_start_immediately) || !level.challenge_counter_start_immediately) {
    common_scripts\utility::flag_wait(level.start_flag);
  }
  for(;;) {
    self waittill(var_2, var_4);
    self.hud_so_counter_values[var_0] settext(var_4);
  }
}

disable_challenge_counter(var_0) {
  var_0 = int(var_0);
  self notify(challenge_counter_get_disable_notify(var_0));

  if(isDefined(self.hud_so_counter_messages[var_0])) {
    self.hud_so_counter_messages[var_0] destroy();
  }
  if(isDefined(self.hud_so_counter_values[var_0])) {
    self.hud_so_counter_values[var_0] destroy();
  }
}

disable_challenge_counter_all() {
  if(isDefined(self.hud_so_counter_messages)) {
    foreach(var_2, var_1 in self.hud_so_counter_messages) {}
    disable_challenge_counter(var_2);

    self.hud_so_counter_messages = [];
    self.hud_so_counter_values = [];
  }
}

challenge_counter_get_disable_notify(var_0) {
  var_0 = int(var_0);
  return "challenge_counter_disable" + var_0;
}

enable_kill_counter() {
  level.kill_counter_line_index = 2;
  level endon("special_op_terminated");
  self notify("enabling_kill_counter");
  self endon("enabling_kill_counter");
  thread enable_challenge_counter(level.kill_counter_line_index, &"SPECIAL_OPS_KILL_COUNT", "ui_kill_count");
  thread enable_kill_counter_think(level.kill_counter_line_index);
}

enable_kill_counter_think(var_0) {
  level endon("special_op_terminated");
  self endon(challenge_counter_get_disable_notify(var_0));

  for(;;) {
    level waittill("specops_player_kill", var_1, var_2);

    if(self == var_1) {
      self notify("ui_kill_count", var_1.stats["kills"]);
    }
  }
}

disable_kill_counter() {
  if(!isDefined(level.kill_counter_line_index)) {
    return;
  }
  disable_challenge_counter(level.kill_counter_line_index);
}

disable_challenge_timer() {
  level notify("stop_challenge_timer_thread");
}

so_get_difficulty_menu_string(var_0) {
  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, level.specops_reward_gameskill);
  var_1 = "";

  switch (int(var_0)) {
    case 0:
      var_1 = "@MENU_RECRUIT";
      break;
    case 1:
      var_1 = "@MENU_REGULAR";
      break;
    case 2:
      var_1 = "@MENU_HARDENED";
      break;
    case 3:
      var_1 = "@MENU_VETERAN";
      break;
    default:
      var_1 = "@MENU_REGULAR";
      break;
  }

  return var_1;
}

so_wait_for_players_ready() {
  if(!isDefined(level.so_enable_wait_for_players)) {
    return;
  }
  if(!maps\_utility::is_coop() || issplitscreen()) {
    return;
  }
  level.so_waiting_for_players = 1;
  level.so_waiting_for_players_alpha = 0.85;
  level.player thread so_wait_for_player_ready("special_op_p1ready", 2);
  level.player2 thread so_wait_for_player_ready("special_op_p2ready", 3.25);
  var_0 = maps\_hud_util::create_client_overlay("black", 1);
  var_0 maps\_hud_util::fade_over_time(level.so_waiting_for_players_alpha, 1);

  while(!common_scripts\utility::flag("special_op_p1ready") || !common_scripts\utility::flag("special_op_p2ready")) {
    wait 0.05;
  }
  var_1 = 1;
  level.player thread so_wait_for_player_ready_cleanup(var_1);
  level.player2 thread so_wait_for_player_ready_cleanup(var_1);
  wait(var_1);
  var_0 destroy();
  level.so_waiting_for_players = undefined;
}

so_wait_for_player_ready(var_0, var_1) {
  self endon("stop_waiting_start");
  self freezecontrols(1);
  self disableweapons();
  self.waiting_to_start_hud = so_create_hud_item(0, 0, &"SPECIAL_OPS_PRESS_TO_START", self, 1);
  self.waiting_to_start_hud.alignx = "center";
  self.waiting_to_start_hud.horzalign = "center";
  self.ready_indication_hud = so_create_hud_item(var_1, 0, &"SPECIAL_OPS_PLAYER_IS_NOT_READY", undefined, 1);
  self.ready_indication_hud.alignx = "center";
  self.ready_indication_hud.horzalign = "center";
  self.ready_indication_hud settext(self.playername);
  self.ready_indication_hud set_hud_yellow();
  wait 0.05;
  self setblurforplayer(6, 0);
  notifyoncommand(self.unique_id + "_is_ready", "+gostand");
  notifyoncommand(self.unique_id + "_is_not_ready", "+stance");

  for(;;) {
    self waittill(self.unique_id + "_is_ready");
    common_scripts\utility::flag_set(var_0);
    self playSound("so_player_is_ready");
    self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_CANCEL";
    self.ready_indication_hud so_hud_pulse_success(&"SPECIAL_OPS_PLAYER_IS_READY");
    self waittill(self.unique_id + "_is_not_ready");
    common_scripts\utility::flag_clear(var_0);
    self playSound("so_player_not_ready");
    self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_START";
    self.ready_indication_hud so_hud_pulse_warning(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  }
}

so_wait_for_player_ready_cleanup(var_0) {
  self notify("stop_waiting_start");
  self.waiting_to_start_hud thread so_remove_hud_item(1);
  wait(var_0);
  self.ready_indication_hud thread so_remove_hud_item(0, 1);
  self freezecontrols(0);
  self enableweapons();
  self setblurforplayer(0, 0.5);
}

attacker_is_p1(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  return var_0 == level.player;
}

attacker_is_p2(var_0) {
  if(!maps\_utility::is_coop()) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  return var_0 == level.player2;
}

enable_escape_warning() {
  level endon("special_op_terminated");
  level.escape_warning_triggers = getEntArray("player_trying_to_escape", "script_noteworthy");
  maps\_utility::add_hint_string("player_escape_warning", &"SPECIAL_OPS_EMPTY", maps\_specialops_code::disable_escape_warning);

  for(;;) {
    wait 0.05;

    foreach(var_1 in level.escape_warning_triggers) {
      foreach(var_3 in level.players) {
        if(!isDefined(var_3.escape_hint_active)) {
          if(var_3 istouching(var_1)) {
            var_3.escape_hint_active = 1;
            var_3 thread maps\_specialops_code::ping_escape_warning();
            var_3 maps\_utility::display_hint_timeout("player_escape_warning");
          }

          continue;
        }

        if(!isDefined(var_3.ping_escape_splash)) {
          var_3 thread maps\_specialops_code::ping_escape_warning();
        }
      }
    }
  }
}

enable_escape_failure() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("player_has_escaped");
  level.challenge_end_time = gettime();
  so_force_deadquote("@DEADQUOTE_SO_LEFT_PLAY_AREA");
  maps\_utility::missionfailedwrapper();
}

so_delete_all_by_type(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }
  var_6 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = common_scripts\utility::array_removeundefined(var_6);
  var_7 = getEntArray();

  foreach(var_9 in var_7) {
    if(!isDefined(var_9.code_classname)) {
      continue;
    }
    var_10 = isDefined(var_9.script_specialops) && var_9.script_specialops == 1;

    if(var_10) {
      continue;
    }
    var_11 = isDefined(var_9.targetname) && var_9.targetname == "intelligence_item";

    if(var_11) {
      continue;
    }
    foreach(var_13 in var_6) {
      if(var_9[[var_13]]()) {
        if(var_5) {
          var_9 notify("delete");
        }
        var_9 delete();
      }
    }
  }
}

type_spawners() {
  if(!isDefined(self.code_classname)) {
    return 0;
  }
  return issubstr(self.code_classname, "actor_");
}

type_vehicle() {
  if(!isDefined(self.code_classname)) {
    return 0;
  }
  if(self.code_classname == "script_vehicle_collmap") {
    return 0;
  }
  return issubstr(self.code_classname, "script_vehicle");
}

type_spawn_trigger() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  if(self.classname == "trigger_multiple_spawn") {
    return 1;
  }
  if(self.classname == "trigger_multiple_spawn_reinforcement") {
    return 1;
  }
  if(self.classname == "trigger_multiple_friendly_respawn") {
    return 1;
  }
  if(isDefined(self.targetname) && self.targetname == "flood_spawner") {
    return 1;
  }
  if(isDefined(self.targetname) && self.targetname == "friendly_respawn_trigger") {
    return 1;
  }
  if(isDefined(self.spawnflags) && self.spawnflags & 32) {
    return 1;
  }
  return 0;
}

type_trigger() {
  if(!isDefined(self.code_classname)) {
    return 0;
  }
  var_0 = [];
  var_0["trigger_multiple"] = 1;
  var_0["trigger_once"] = 1;
  var_0["trigger_use"] = 1;
  var_0["trigger_radius"] = 1;
  var_0["trigger_lookat"] = 1;
  var_0["trigger_disk"] = 1;
  var_0["trigger_damage"] = 1;
  return isDefined(var_0[self.code_classname]);
}

type_flag_trigger() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  var_0 = [];
  var_0["trigger_multiple_flag_set"] = 1;
  var_0["trigger_multiple_flag_set_touching"] = 1;
  var_0["trigger_multiple_flag_clear"] = 1;
  var_0["trigger_multiple_flag_looking"] = 1;
  var_0["trigger_multiple_flag_lookat"] = 1;
  return isDefined(var_0[self.classname]);
}

type_killspawner_trigger() {
  if(!type_trigger()) {
    return 0;
  }
  if(isDefined(self.script_killspawner)) {
    return 1;
  }
  return 0;
}

type_goalvolume() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  if(self.classname == "info_volume" && isDefined(self.script_goalvolume)) {
    return 1;
  }
  return 0;
}

type_infovolume() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  return self.classname == "info_volume";
}

type_turret() {
  if(!isDefined(self.classname)) {
    return 0;
  }
  return self.classname == "misc_turret";
}

type_weapon_placed() {
  if(!isDefined(self.classname) || !isDefined(self.model)) {
    return 0;
  }
  if(strtok(self.classname, "_")[0] == "weapon") {
    return 1;
  }
  return 0;
}

so_delete_all_spawntriggers() {
  so_delete_all_by_type(::type_spawn_trigger);
}

so_delete_all_triggers() {
  so_delete_all_by_type(::type_trigger, ::type_spawn_trigger, ::type_flag_trigger, ::type_killspawner_trigger);
  animscripts\battlechatter::update_bcs_locations();
}

so_delete_all_vehicles() {
  so_delete_all_by_type(::type_vehicle, undefined, undefined, undefined, undefined, 1);
}

so_delete_all_spawners() {
  so_delete_all_by_type(::type_spawners);
}

so_make_specialops_ent(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  so_array_make_specialops(var_3, var_2);
}

so_make_bcslocations_specialops_ent() {
  so_array_make_specialops(anim.bcs_locations);
}

so_array_make_specialops(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  level.so_traversed_list = [];
  so_make_specialops_ent_internal(var_0, var_1);
  level.so_traversed_list = undefined;
}

so_make_specialops_ent_internal(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(maps\_utility::array_contains(level.so_traversed_list, var_3)) {
      continue;
    }
    level.so_traversed_list[level.so_traversed_list.size] = var_3;
    var_3.script_specialops = 1;

    if(var_1) {
      if(isDefined(var_3.target)) {
        var_4 = getEntArray(var_3.target, "targetname");
        so_make_specialops_ent_internal(var_4, var_1);
      }

      if(isDefined(var_3.linkto)) {
        var_4 = var_3 common_scripts\utility::get_linked_ents();
        so_make_specialops_ent_internal(var_4, var_1);
      }
    }
  }
}

so_delete_breach_ents() {
  var_0 = getEntArray("breach_solid", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 delete();
  }
}

so_force_deadquote(var_0, var_1) {
  level.so_deadquotes = [];
  level.so_deadquotes[0] = var_0;
  level.so_deadquotes_chance = 1.0;
  maps\_specialops_code::so_special_failure_hint_reset_dvars(var_1);
}

so_force_deadquote_array(var_0, var_1) {
  level.so_deadquotes = var_0;
  level.so_deadquotes_chance = 1.0;
  maps\_specialops_code::so_special_failure_hint_reset_dvars(var_1);
}

so_include_deadquote_array(var_0) {
  if(!isDefined(level.so_deadquotes)) {
    level.so_deadquotes = [];
  }
  level.so_deadquotes = maps\_utility::array_merge(level.so_deadquotes, var_0);
}

so_create_hud_item(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {}

  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_0 = var_0 + 2;
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = newclienthudelem(var_3);
  } else {
    var_5 = newhudelem();
  }
  var_5.alignx = "right";
  var_5.aligny = "middle";
  var_5.horzalign = "right";
  var_5.vertalign = "middle";
  var_5.x = var_1;
  var_5.y = -100 + 15 * var_0;
  var_5.font = "hudsmall";
  var_5.foreground = 1;
  var_5.hidewheninmenu = 1;
  var_5.hidewhendead = 1;
  var_5.sort = 2;
  var_5 set_hud_white();

  if(isDefined(var_2)) {
    var_5.label = var_2;
  }
  if(!isDefined(var_4) || !var_4) {
    if(isDefined(var_3)) {
      if(!var_3 maps\_specialops_code::so_hud_can_show()) {
        var_3 thread maps\_specialops_code::so_create_hud_item_delay_draw(var_5);
      } else if(!maps\_utility::ent_flag("so_hud_can_toggle")) {
        maps\_utility::ent_flag_set("so_hud_can_toggle");
      }
    }
  }

  return var_5;
}

so_create_hud_item_data(var_0, var_1, var_2, var_3, var_4) {
  var_5 = so_create_hud_item(var_0, var_1, var_2, var_3, var_4);
  var_5.alignx = "left";
  return var_5;
}

so_create_hud_item_debug(var_0, var_1, var_2, var_3, var_4) {
  var_5 = so_create_hud_item(var_0, var_1, var_2, var_3, var_4);
  var_5.alignx = "left";
  var_5.horzalign = "left";
  return var_5;
}

so_hud_pulse_create(var_0) {
  if(!maps\_specialops_code::so_hud_pulse_init()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(var_0)) {
    self.label = var_0;
  }
  if(isDefined(self.pulse_sound)) {
    level.player playSound(self.pulse_sound);
  }
  if(isDefined(self.pulse_loop) && self.pulse_loop) {
    maps\_specialops_code::so_hud_pulse_loop();
  } else {
    maps\_specialops_code::so_hud_pulse_single(self.pulse_scale_big, self.pulse_scale_normal, self.pulse_time);
  }
}

so_hud_pulse_stop(var_0) {
  if(!maps\_specialops_code::so_hud_pulse_init()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(var_0)) {
    self.label = var_0;
  }
  self.pulse_loop = 0;
  maps\_specialops_code::so_hud_pulse_single(self.fontscale, self.pulse_scale_normal, self.pulse_time);
}

so_hud_pulse_default(var_0) {
  set_hud_white();
  self.pulse_loop = 0;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_close(var_0) {
  set_hud_green();
  self.pulse_loop = 1;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_success(var_0) {
  set_hud_green();
  self.pulse_loop = 0;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_warning(var_0) {
  set_hud_yellow();
  self.pulse_loop = 0;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_alarm(var_0) {
  set_hud_red();
  self.pulse_loop = 1;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_failure(var_0) {
  set_hud_red();
  self.pulse_loop = 0;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_disabled(var_0) {
  set_hud_grey();
  self.pulse_loop = 0;
  so_hud_pulse_create(var_0);
}

so_hud_pulse_smart(var_0, var_1) {
  if(!isDefined(self.pulse_bounds)) {
    so_hud_pulse_default(var_1);
    return;
  }

  foreach(var_4, var_3 in self.pulse_bounds) {
    if(var_0 <= var_3) {
      switch (var_4) {
        case "pulse_disabled":
          so_hud_pulse_disabled(var_1);
          return;
        case "pulse_failure":
          so_hud_pulse_failure(var_1);
          return;
        case "pulse_alarm":
          so_hud_pulse_alarm(var_1);
          return;
        case "pulse_warning":
          so_hud_pulse_warning(var_1);
          return;
        case "pulse_default":
          so_hud_pulse_default(var_1);
          return;
        case "pulse_close":
          so_hud_pulse_close(var_1);
          return;
        case "pulse_success":
          so_hud_pulse_success(var_1);
          return;
      }
    }
  }

  so_hud_pulse_default(var_1);
}

so_hud_ypos() {
  return -72;
}

so_remove_hud_item(var_0, var_1) {
  if(isDefined(var_0) && var_0) {
    self notify("destroying");
    self destroy();
    return;
  }

  thread so_hud_pulse_stop();

  if(isDefined(var_1) && var_1) {
    self setpulsefx(0, 0, 500);
    wait 0.5;
  } else {
    self setpulsefx(0, 1500, 500);
    wait 2;
  }

  self notify("destroying");
  self destroy();
}

set_hud_white(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 1, 1);
  self.glowcolor = (0.6, 0.6, 0.6);
}

set_hud_blue(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.8, 0.8, 1);
  self.glowcolor = (0.301961, 0.301961, 0.6);
}

set_hud_green(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.8, 1, 0.8);
  self.glowcolor = (0.301961, 0.6, 0.301961);
}

set_hud_yellow(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 1, 0.5);
  self.glowcolor = (0.7, 0.7, 0.2);
}

set_hud_red(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 0.4, 0.4);
  self.glowcolor = (0.7, 0.2, 0.2);
}

set_hud_grey(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.4, 0.4, 0.4);
  self.glowcolor = (0.2, 0.2, 0.2);
}

info_hud_wait_for_player(var_0) {
  if(isDefined(self.so_infohud_toggle_state)) {
    return;
  }
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(var_0)) {
    level endon(var_0);
  }
  self setweaponhudiconoverride("actionslot1", "hud_show_timer");
  notifyoncommand("toggle_challenge_timer", "+actionslot 1");
  self.so_infohud_toggle_state = info_hud_start_state();

  if(!maps\_specialops_code::so_hud_can_show()) {
    thread info_hud_wait_force_on();
    maps\_utility::ent_flag_wait("so_hud_can_toggle");
  }

  self notify("so_hud_toggle_available");

  for(;;) {
    self waittill("toggle_challenge_timer");

    switch (self.so_infohud_toggle_state) {
      case "on":
        self.so_infohud_toggle_state = "off";
        setDvar("so_ophud_" + self.unique_id, "0");
        break;
      case "off":
        self.so_infohud_toggle_state = "on";
        setDvar("so_ophud_" + self.unique_id, "1");
        break;
    }

    self notify("update_challenge_timer");
  }
}

info_hud_wait_force_on() {
  self endon("so_hud_toggle_available");
  notifyoncommand("force_challenge_timer", "+actionslot 1");
  self waittill("force_challenge_timer");
  self.so_hud_show_time = gettime();
  self.so_infohud_toggle_state = "on";
  setDvar("so_ophud_" + self.unique_id, "1");
}

info_hud_start_state() {
  if(getdvarint("so_ophud_" + self.unique_id) == 1) {
    self.so_hud_show_time = gettime() + 1000;
    return "on";
  }

  if(isDefined(level.challenge_time_limit)) {
    return "on";
  }
  if(isDefined(level.challenge_time_force_on) && level.challenge_time_force_on) {
    return "on";
  }
  return "off";
}

info_hud_handle_fade(var_0, var_1) {
  level endon("new_challenge_timer");
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(var_1)) {
    level endon(var_1);
  }
  var_0.so_can_toggle = 1;
  maps\_utility::ent_flag_wait("so_hud_can_toggle");
  info_hud_update_alpha(var_0);

  for(;;) {
    self waittill("update_challenge_timer");
    var_0 fadeovertime(0.25);
    info_hud_update_alpha(var_0);
  }
}

info_hud_update_alpha(var_0) {
  switch (self.so_infohud_toggle_state) {
    case "on":
      var_0.alpha = 1;
      break;
    case "off":
      var_0.alpha = 0;
      break;
  }
}

info_hud_decrement_timer(var_0) {
  if(!isDefined(level.challenge_time_limit)) {
    return;
  }
  if(common_scripts\utility::flag("challenge_timer_expired") || common_scripts\utility::flag("challenge_timer_passed")) {
    return;
  }
  level.so_challenge_time_left = level.so_challenge_time_left - var_0;

  if(level.so_challenge_time_left < 0) {
    level.so_challenge_time_left = 0.01;
  }
  var_1 = (0.6, 0.2, 0.2);
  var_2 = (0.4, 0.1, 0.1);

  foreach(var_4 in level.players) {}
  var_4.hud_so_timer_time settenthstimer(level.so_challenge_time_left);

  thread maps\_specialops_code::challenge_timer_thread();
}

is_dvar_character_switcher(var_0) {
  var_1 = getDvar(var_0);
  return var_1 == "so_char_client" || var_1 == "so_char_host";
}

has_been_played() {
  var_0 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(var_0 == "") {
    return 0;
  }
  foreach(var_2 in level.players) {
    var_3 = var_2 getlocalplayerprofiledata(var_0);

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != 0) {
      return 1;
    }
  }

  return 0;
}

is_best_wave(var_0) {
  return 0;
}

is_best_time(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(isDefined(level.challenge_start_time)) {
      var_0 = level.challenge_start_time;
    } else {
      var_0 = 300;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = gettime();
  }
  if(!isDefined(var_2)) {
    var_2 = 0.0;
  }
  var_3 = var_1 - var_0;
  var_3 = int(min(var_3, 86400000));
  var_4 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(var_4 == "") {
    return 0;
  }
  foreach(var_6 in level.players) {
    var_7 = var_6 getlocalplayerprofiledata(var_4);

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = var_7 == 0;

    if(var_8) {
      continue;
    }
    var_7 = var_7 - var_7 * var_2;

    if(var_3 < var_7) {
      return 1;
    }
  }

  return 0;
}

is_poor_time(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(isDefined(level.challenge_start_time)) {
      var_0 = level.challenge_start_time;
    } else {
      var_0 = 300;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = gettime();
  }
  if(!isDefined(var_2)) {
    var_2 = 0.0;
  }
  var_3 = var_1 - var_0;
  var_4 = level.challenge_time_limit * 1000;
  var_4 = var_4 - var_4 * var_2;
  return var_3 > var_4;
}

so_dialog_ready_up() {
  if(isDefined(level.so_dialog_func_override["ready_up"])) {
    [[level.so_dialog_func_override["ready_up"]]]();
    return;
  }

  maps\_specialops_code::so_dialog_play("so_tf_1_plyr_prep", 0, 1);
}

so_dialog_mission_success(var_0) {
  if(!maps\_utility::is_survival() && is_best_time(level.challenge_start_time, level.challenge_end_time)) {
    if(isDefined(level.so_dialog_func_override["success_best"])) {
      thread[[level.so_dialog_func_override["success_best"]]]();
      return;
    }

    thread maps\_specialops_code::so_dialog_play("so_tf_1_success_best", 0.5, 1);
  } else {
    if(!isDefined(var_0)) {
      var_0 = 0;

      if(level.gameskill >= 3) {
        if(has_been_played()) {
          var_0 = common_scripts\utility::cointoss();
        }
      }
    }

    if(isDefined(level.so_dialog_func_override["success_generic"])) {
      [[level.so_dialog_func_override["success_generic"]]](var_0);
      return;
    }

    if(var_0) {
      maps\_specialops_code::so_dialog_play("so_tf_1_success_jerk", 0.5, 1);
      return;
    }

    maps\_specialops_code::so_dialog_play("so_tf_1_success_generic", 0.5, 1);
  }
}

so_dialog_mission_failed(var_0) {
  if(isDefined(level.failed_dialog_played) && level.failed_dialog_played) {
    return;
  }
  level.failed_dialog_played = 1;
  maps\_specialops_code::so_dialog_play(var_0, 0.5, 1);
}

so_dialog_mission_failed_generic() {
  if(isDefined(level.so_dialog_func_override["failed_generic"])) {
    [[level.so_dialog_func_override["failed_generic"]]]();
  } else {
    if(level.gameskill <= 2 || common_scripts\utility::cointoss()) {
      so_dialog_mission_failed("so_tf_1_fail_generic");
      return;
    }

    so_dialog_mission_failed("so_tf_1_fail_generic_jerk");
  }
}

so_dialog_mission_failed_time() {
  if(isDefined(level.so_dialog_func_override["failed_time"])) {
    [[level.so_dialog_func_override["failed_time"]]]();
    return;
  }

  so_dialog_mission_failed("so_tf_1_fail_time");
}

so_dialog_mission_failed_bleedout() {
  if(isDefined(level.so_dialog_func_override["failed_bleedout"])) {
    [[level.so_dialog_func_override["failed_bleedout"]]]();
    return;
  }

  so_dialog_mission_failed("so_tf_1_fail_bleedout");
}

so_dialog_time_low_normal() {
  if(isDefined(level.so_dialog_func_override["time_low_normal"])) {
    [[level.so_dialog_func_override["time_low_normal"]]]();
    return;
  }

  maps\_specialops_code::so_dialog_play("so_tf_1_time_generic");
}

so_dialog_time_low_hurry() {
  if(isDefined(level.so_dialog_func_override["time_low_hurry"])) {
    [[level.so_dialog_func_override["time_low_hurry"]]]();
    return;
  }

  maps\_specialops_code::so_dialog_play("so_tf_1_time_hurry");
}

so_dialog_killing_civilians() {
  if(!isDefined(level.civilian_warning_time)) {
    level.civilian_warning_time = gettime();

    if(!isDefined(level.civilian_warning_throttle)) {
      level.civilian_warning_throttle = 5000;
    }
  } else if(gettime() - level.civilian_warning_time < level.civilian_warning_throttle) {
    return;
  }
  var_0 = 0.5;
  level.civilian_warning_time = gettime() + var_0 * 1000;

  if(isDefined(level.so_dialog_func_override["killing_civilians"])) {
    [[level.so_dialog_func_override["killing_civilians"]]]();
    return;
  }

  maps\_specialops_code::so_dialog_play("so_tf_1_civ_kill_warning", 0.5);
}

so_dialog_progress_update(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.so_progress_goal_status)) {
    level.so_progress_goal_status = "none";
  }
  var_2 = undefined;

  switch (level.so_progress_goal_status) {
    case "none":
      var_2 = 0.75;
      break;
    case "3quarter":
      var_2 = 0.5;
      break;
    case "half":
      var_2 = 0.25;
      break;
    default:
      return;
  }

  var_3 = var_1 * var_2;

  if(var_0 > var_3) {
    return;
  }
  var_4 = undefined;

  switch (level.so_progress_goal_status) {
    case "none":
      level.so_progress_goal_status = "3quarter";
      var_4 = "so_tf_1_progress_3quarter";
      break;
    case "3quarter":
      level.so_progress_goal_status = "half";
      var_4 = "so_tf_1_progress_half";
      break;
    case "half":
      level.so_progress_goal_status = "quarter";
      var_4 = "so_tf_1_progress_quarter";
      break;
  }

  if(isDefined(level.so_dialog_func_override["progress_goal_status"])) {
    [[level.so_dialog_func_override["progress_goal_status"]]]();
    return;
  }

  maps\_specialops_code::so_dialog_play(var_4, 0.5);
}

so_dialog_progress_update_time_quality(var_0) {
  if(isDefined(level.challenge_time_limit)) {
    if(is_poor_time(level.challenge_start_time, gettime(), var_0)) {
      if(isDefined(level.so_dialog_func_override["time_status_late"])) {
        [[level.so_dialog_func_override["time_status_late"]]]();
        return;
      }

      maps\_specialops_code::so_dialog_play("so_tf_1_time_status_late", 0.2);
      return;
    }
  }

  if(is_best_time(level.challenge_start_time, gettime(), var_0)) {
    if(isDefined(level.so_dialog_func_override["time_status_good"])) {
      [[level.so_dialog_func_override["time_status_good"]]]();
      return;
    }

    maps\_specialops_code::so_dialog_play("so_tf_1_time_status_good", 0.2);
  }
}

so_dialog_counter_update(var_0, var_1, var_2) {
  if(!isDefined(level.so_counter_dialog_time)) {
    level.so_counter_dialog_time = 0;
  }
  if(gettime() < level.so_counter_dialog_time) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_3 = int(var_0 / var_2);

  if(var_3 > 5) {
    if(!isDefined(level.challenge_progress_manual_update) || !level.challenge_progress_manual_update) {
      thread so_dialog_progress_update(var_0, var_1);
      level.so_counter_dialog_time = gettime() + 800;
    }

    return;
  }

  if(isDefined(level.so_dialog_func_override["progress"])) {
    thread[[level.so_dialog_func_override["progress"]]](var_3);
  } else {
    switch (var_3) {
      case 5:
        thread maps\_specialops_code::so_dialog_play("so_tf_1_progress_5more", 0.5);
        break;
      case 4:
        thread maps\_specialops_code::so_dialog_play("so_tf_1_progress_4more", 0.5);
        break;
      case 3:
        thread maps\_specialops_code::so_dialog_play("so_tf_1_progress_3more", 0.5);
        break;
      case 2:
        thread maps\_specialops_code::so_dialog_play("so_tf_1_progress_2more", 0.5);
        break;
      case 1:
        thread maps\_specialops_code::so_dialog_play("so_tf_1_progress_1more", 0.5);
        break;
    }
  }

  level.so_counter_dialog_time = gettime() + 800;
}

so_crush_player(var_0, var_1) {
  if(!isDefined(var_0.coop_death_reason)) {
    var_0.coop_death_reason = [];
  }
  if(!isDefined(var_1)) {
    var_1 = "MOD_EXPLOSIVE";
  }
  var_0.coop_death_reason["attacker"] = self;
  var_0.coop_death_reason["cause"] = var_1;
  var_0.coop_death_reason["weapon_name"] = "none";
  var_0 maps\_utility::kill_wrapper();
}

get_previously_completed_difficulty() {
  var_0 = level.specopssettings maps\_endmission::getlevelindex(level.script);
  var_1 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_0]);
  var_1 = int(max(0, var_1));
  return var_1;
}

so_hud_stars_precache() {
  precacheshader("difficulty_star");
}

so_hud_stars_init(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.race_times = [];
  level.race_times["regular"] = var_2;
  level.race_times["hardened"] = var_3;
  level.race_times["veteran"] = var_4;
  var_5 = common_scripts\utility::ter_op(isDefined(var_5), var_5, 4);
  self.stars_removed = [];
  thread so_hud_stars_single_think(var_0, var_1, 0, level.race_times["regular"], "regular", var_5);
  thread so_hud_stars_single_think(var_0, var_1, 1, level.race_times["hardened"], "hardened", var_5);
  thread so_hud_stars_single_think(var_0, var_1, 2, level.race_times["veteran"], "veteran", var_5);
}

so_hud_stars_single_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("special_op_terminated");
  level endon(var_1);

  if(!isDefined(self.so_hud_star_count)) {
    self.so_hud_star_count = 0;
  }
  self.so_hud_star_count++;
  var_6 = 25;
  var_7 = so_hud_ypos();
  var_8 = so_create_hud_item(var_5, var_7, undefined, self);
  var_8.x = var_8.x - (var_2 * var_6 - 30);
  var_8.y = var_8.y + 5;
  var_8 setshader("difficulty_star", 25, 25);
  common_scripts\utility::flag_wait(var_0);
  thread so_hud_stars_single_force_alpha_end(var_8, var_1);

  if(var_3 < 0) {
    return;
  }
  thread so_hud_stars_sound_and_flash(var_8, var_3, var_1);
  level common_scripts\utility::waittill_any_timeout(var_3, "star_hud_remove_" + var_4);
  waittillframeend;

  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  self.so_hud_star_count--;
  var_8 destroy();
}

so_hud_stars_remove(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_0)) {
      if(!isDefined(var_2.stars_removed["veteran"])) {
        var_0 = "veteran";
      } else if(!isDefined(var_2.stars_removed["hardened"])) {
        var_0 = "hardened";
      } else if(!isDefined(var_2.stars_removed["regular"])) {
        var_0 = "regular";
      }
    }

    if(isDefined(var_2.stars_removed[var_0])) {
      return;
    }
    if(var_0 == "hardened" && !isDefined(var_2.stars_removed["veteran"])) {
      return;
    } else if(var_0 == "regular" && (!isDefined(var_2.stars_removed["veteran"]) || !isDefined(var_2.stars_removed["hardened"]))) {
      return;
    }
    var_2.stars_removed[var_0] = 1;
    level notify("star_hud_remove_" + var_0);
  }
}

so_hud_stars_validate_difficulty(var_0) {
  switch (var_0) {
    case "regular":
    case "veteran":
    case "hardened":
      break;
    default:
      break;
  }
}

so_hud_stars_sound_and_flash(var_0, var_1, var_2) {
  var_0 endon("death");
  level endon(var_2);
  level endon("special_op_terminated");
  var_3 = 5;
  var_4 = var_1 - var_3;
  wait(var_4);

  for(var_5 = 0; var_5 < var_3; var_5++) {
    self playlocalsound("star_tick");
    var_0.alpha = 1;
    wait 0.5;
    var_0.alpha = 0.3;
    wait 0.5;
  }

  self playlocalsound("star_lost");
}

so_hud_stars_single_force_alpha_end(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::flag_wait(var_1);
  waittillframeend;
  var_0.alpha = 1;
}

unlock_hint() {
  wait 0.05;

  foreach(var_1 in level.players) {}
  var_1 thread unlock_hint_think();
}

unlock_hint_think() {
  surhud_disable("unlock");

  for(var_0 = 0; var_0 < 3; var_0++) {
    unlock_hint_reset(var_0);
  }
  for(;;) {
    self waittill("update_rank");
    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    var_1 = maps\_rank::getrank();
    var_2 = level.unlock_array[var_1];

    if(isDefined(var_2)) {
      for(var_0 = 0; var_0 < 3; var_0++) {
        var_3 = var_2[var_0];

        if(isDefined(var_3)) {
          register_recent_unlock(var_3);
          _setplayerdata_array("surHUD_unlock_hint_" + var_0, "name", var_3.name);
          _setplayerdata_array("surHUD_unlock_hint_" + var_0, "icon", var_3.icon);
          _setplayerdata_array("surHUD_unlock_hint_" + var_0, "mode", var_3.mode);
          continue;
        }

        unlock_hint_reset(var_0);
      }

      surhud_animate("unlock");
    }
  }
}

register_recent_unlock(var_0) {
  if(!var_0.feature) {
    var_1 = tablelookup("sp/survival_armories.csv", 1, var_0.ref, 2);
    var_2 = int(1 + (var_1 == "weapon"));
    var_3 = tablelookup("sp/survival_armories.csv", 1, var_0.ref, 6);
    var_4 = var_0.desc;
    pass_recent_item_unlock("recent_item_2", "recent_item_3");
    pass_recent_item_unlock("recent_item_1", "recent_item_2");
    _setplayerdata_array("recent_item_1", "name", var_0.name);
    _setplayerdata_array("recent_item_1", "icon", var_3);
    _setplayerdata_array("recent_item_1", "desc", var_4);
    _setplayerdata_array("recent_item_1", "icon_width_ratio", var_2);
  } else {
    var_5 = self getplayerdata("recent_feature_1", "name");
    _setplayerdata_array("recent_feature_2", "name", var_5);
    _setplayerdata_array("recent_feature_1", "name", var_0.name);
  }
}

pass_recent_item_unlock(var_0, var_1) {
  var_2 = self getplayerdata(var_0, "name");
  var_3 = self getplayerdata(var_0, "desc");
  var_4 = self getplayerdata(var_0, "icon");
  var_5 = self getplayerdata(var_0, "icon_width_ratio");
  _setplayerdata_array(var_1, "name", var_2);
  _setplayerdata_array(var_1, "desc", var_3);
  _setplayerdata_array(var_1, "icon", var_4);
  _setplayerdata_array(var_1, "icon_width_ratio", var_5);
}

unlock_hint_reset(var_0) {
  _setplayerdata_array("surHUD_unlock_hint_" + var_0, "name", "");
  _setplayerdata_array("surHUD_unlock_hint_" + var_0, "icon", "");
  _setplayerdata_array("surHUD_unlock_hint_" + var_0, "mode", "");
}

surhud_animate(var_0) {
  level endon("special_op_terminated");
  self endon("stop_animate_" + var_0);
  thread surhud_animate_endon_clear("stop_animate_" + var_0);

  if(!isDefined(self.surhud_busy)) {
    self.surhud_busy = 0;
  }
  while(self.surhud_busy) {
    wait 0.05;
  }
  self.surhud_busy = 1;

  if(!surhud_is_enabled(var_0)) {
    surhud_enable(var_0);
  }
  _setplayerdata_single("surHUD_set_animate", var_0);
  wait 0.05;
  self openmenu("surHUD_display");
  wait 0.05;
  self.surhud_busy = 0;
  self notify("surHUD_free");
}

surhud_animate_endon_clear(var_0) {
  self endon("surHUD_free");
  self waittill(var_0);
  self.surhud_busy = 0;
}

surhud_challenge_label(var_0, var_1) {
  if(isDefined(self)) {
    _setplayerdata_array("surHUD_challenge_label", "slot_" + var_0, var_1);
  }
}

surhud_challenge_progress(var_0, var_1) {
  if(isDefined(self)) {
    _setplayerdata_array("surHUD_challenge_progress", "slot_" + var_0, var_1);
  }
}

surhud_challenge_reward(var_0, var_1) {
  if(isDefined(self)) {
    _setplayerdata_array("surHUD_challenge_reward", "slot_" + var_0, var_1);
  }
}

surhud_is_enabled(var_0) {
  if(isDefined(self) && self getplayerdata("surHUD", var_0)) {
    return 1;
  }
  return 0;
}

surhud_enable(var_0) {
  if(isDefined(self)) {
    _setplayerdata_array("surHUD", var_0, 1);
  }
}

surhud_disable(var_0) {
  if(isDefined(self)) {
    _setplayerdata_array("surHUD", var_0, 0);
  }
}

_setplayerdata_single(var_0, var_1) {
  self setplayerdata(var_0, var_1);
}

_setplayerdata_array(var_0, var_1, var_2) {
  self setplayerdata(var_0, var_1, var_2);
}

so_achievement_init() {
  wait 0.05;

  foreach(var_1 in level.players) {}
  var_1 thread so_achievement_reset();
}

so_achievement_reset() {
  if(!isDefined(self.achievement_completed)) {
    self.achievement_completed = [];
  }
  self.achievement_completed["ARMS_DEALER"] = 0;
  self.achievement_completed["DANGER_ZONE"] = 0;
  self.achievement_completed["DEFENSE_SPENDING"] = 0;
  self.achievement_completed["SURVIVOR"] = 0;
  self.achievement_completed["UNSTOPPABLE"] = 0;
}

so_achievement_update(var_0, var_1) {
  if(maps\_utility::is_survival()) {
    switch (var_0) {
      case "DEFENSE_SPENDING":
      case "DANGER_ZONE":
      case "ARMS_DEALER":
        thread so_achievement_item_collection(var_0, var_1);
        return;
      case "SURVIVOR":
        thread so_achievement_wave_count(var_0, 9);
        return;
      case "UNSTOPPABLE":
        thread so_achievement_wave_count(var_0, 14);
        return;
      case "GET_RICH_OR_DIE_TRYING":
      case "I_LIVE":
        thread maps\_utility::player_giveachievement_wrapper(var_0);
        return;
    }
  } else {
    switch (var_0) {
      case "BRAG_RAGS":
        thread maps\_utility::player_giveachievement_wrapper(var_0);
        return;
      case "TACTICIAN":
        thread so_achievement_star_count(var_0, 1);
        return;
      case "OVERACHIEVER":
        thread so_achievement_star_count(var_0, 3);
        return;
    }
  }
}

so_achievement_item_collection(var_0, var_1) {
  if(self.achievement_completed[var_0]) {
    return;
  }
  var_2 = level.armory_all_items[var_1].type;

  if(self getplayerdata(var_2 + "_purchased", var_1) == 0) {
    self setplayerdata(var_2 + "_purchased", var_1, 1);
  } else {
    return;
  }
  var_3 = 0;

  if(var_2 == "weapon" || var_2 == "weaponupgrade") {
    var_3 = is_purchase_collection_complete("weapon", "weapon_purchased") && is_purchase_collection_complete("weaponupgrade", "weaponupgrade_purchased");
  } else {
    var_3 = is_purchase_collection_complete(var_2, var_2 + "_purchased");
  }
  if(var_3) {
    maps\_utility::player_giveachievement_wrapper(var_0);
    self.achievement_completed[var_0] = 1;
  }
}

is_purchase_collection_complete(var_0, var_1) {
  foreach(var_3 in level.armory[var_0]) {
    if(self getplayerdata(var_1, var_3.ref) == 0) {
      return 0;
    }
  }

  return 1;
}

so_achievement_wave_count(var_0, var_1) {
  if(self.achievement_completed[var_0]) {
    return;
  }
  for(var_2 = 0; var_2 < 16; var_2++) {
    var_3 = level.specopssettings.levels[var_2].name;
    var_4 = tablelookup("sp/specOpsTable.csv", 1, var_3, 9);
    var_5 = int(self getlocalplayerprofiledata(var_4) / 1000);

    if(var_3 == level.script) {
      var_5 = level.current_wave;
    }
    if(var_5 < var_1) {
      return;
    }
  }

  maps\_utility::player_giveachievement_wrapper(var_0);
  self.achievement_completed[var_0] = 1;

  if(var_0 == "UNSTOPPABLE") {
    self setplayerdata("challengeState", "ch_unstoppable", 2);
  }
}

so_achievement_star_count(var_0, var_1) {
  for(var_2 = 16; var_2 < 32; var_2++) {
    var_3 = level.specopssettings.levels[var_2].name;
    var_4 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_2]);
    var_4 = int(max(0, var_4)) - 1;

    if(var_4 < var_1) {
      return;
    }
  }

  maps\_utility::player_giveachievement_wrapper(var_0);

  if(var_0 == "OVERACHIEVER") {
    self setplayerdata("challengeState", "ch_overachiever", 2);
  }
}