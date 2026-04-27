/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_specialops.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_specialops_code;

specialops_init() {
  if(!isDefined(level.so_override))
    level.so_override = [];

  if(!isDefined(level.friendlyfire_warnings)) {
    level.friendlyfire_warnings = true;
  }

  level.no_friendly_fire_penalty = true;

  precachemenu("sp_eog_summary");
  precachemenu("coop_eog_summary");
  precachemenu("coop_eog_summary2");

  PrecacheShellshock("so_finished");

  precacheShader("hud_show_timer");

  so_precache_strings();

  foreach(player in level.players) {
    player.so_hud_show_time = gettime() + (so_standard_wait() * 1000);
    player ent_flag_init("so_hud_can_toggle");
  }

  level.challenge_time_nudge = 30;
  level.challenge_time_hurry = 10;

  level.func_destructible_crush_player = ::so_crush_player;

  setsaveddvar("g_friendlyfireDamageScale", 2);

  if(isDefined(level.so_compass_zoom)) {
    compass_dist = 0;
    switch (level.so_compass_zoom) {
      case "close":
        compass_dist = 1500;
        break;
      case "far":
        compass_dist = 6000;
        break;
      default:
        compass_dist = 3000;
        break;
    }
    if(!issplitscreen())
      compass_dist += (compass_dist * 0.1);
    setsaveddvar("compassmaxrange", compass_dist);
  }

  flag_init("challenge_timer_passed");
  flag_init("challenge_timer_expired");
  flag_init("special_op_succeeded");
  flag_init("special_op_failed");
  flag_init("special_op_terminated");
  flag_init("special_op_p1ready");
  flag_init("special_op_p2ready");
  flag_init("special_op_no_unlink");

  thread disable_saving();
  thread specialops_detect_death();

  specialops_dialog_init();
  if(is_coop())
    maps\_specialops_battlechatter::init();

  if(!is_coop())
    set_custom_gameskill_func(maps\_gameskill::solo_player_in_special_ops);

  level.so_deadquotes_chance = 0.5;
  setDvar("ui_deadquote", "");
  thread so_special_failure_hint();

  setDvar("ui_skip_level_select", "1");

  pick_starting_location_so();
  level thread setSoUniqueSavedDvars();
}

setSoUniqueSavedDvars() {
  setsaveddvar("hud_fade_ammodisplay", 30);
  setsaveddvar("hud_fade_stance", 30);
  setsaveddvar("hud_fade_offhand", 30);
  setsaveddvar("hud_fade_compass", 30);
}

so_precache_strings() {
  PrecacheString(&"SPECIAL_OPS_TIME_NULL");
  PrecacheString(&"SPECIAL_OPS_TIME");
  PrecacheString(&"SPECIAL_OPS_WAITING_P1");
  PrecacheString(&"SPECIAL_OPS_WAITING_P2");
  PrecacheString(&"SPECIAL_OPS_REVIVE_NAG_HINT");
  PrecacheString(&"SPECIAL_OPS_CHALLENGE_SUCCESS");
  PrecacheString(&"SPECIAL_OPS_CHALLENGE_FAILURE");
  PrecacheString(&"SPECIAL_OPS_FAILURE_HINT_TIME");
  PrecacheString(&"SPECIAL_OPS_ESCAPE_WARNING");
  PrecacheString(&"SPECIAL_OPS_ESCAPE_SPLASH");
  PrecacheString(&"SPECIAL_OPS_WAITING_OTHER_PLAYER");
  PrecacheString(&"SPECIAL_OPS_STARTING_IN");
  PrecacheString(&"SPECIAL_OPS_UI_TIME");
  PrecacheString(&"SPECIAL_OPS_UI_KILLS");
  PrecacheString(&"SPECIAL_OPS_UI_DIFFICULTY");
  PrecacheString(&"SPECIAL_OPS_UI_PLAY_AGAIN");
  PrecacheString(&"SPECIAL_OPS_DASHDASH");
  PrecacheString(&"SPECIAL_OPS_HOSTILES");
  PrecacheString(&"SPECIAL_OPS_INTERMISSION_WAVENUM");
  PrecacheString(&"SPECIAL_OPS_INTERMISSION_WAVEFINAL");
  PrecacheString(&"SPECIAL_OPS_WAVENUM");
  PrecacheString(&"SPECIAL_OPS_WAVEFINAL");
  PrecacheString(&"SPECIAL_OPS_PRESS_TO_CANCEL");
  PrecacheString(&"SPECIAL_OPS_PLAYER_IS_READY");
  PrecacheString(&"SPECIAL_OPS_PRESS_TO_START");
  PrecacheString(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  PrecacheString(&"SPECIAL_OPS_EMPTY");
}
so_standard_wait() {
  return 4;
}

specialops_remove_unused() {
  entarray = getEntArray();
  if(!isDefined(entarray)) {
    return;
  }
  special_op_state = is_specialop();
  foreach(ent in entarray) {
    if(ent specialops_remove_entity_check(special_op_state))
      ent Delete();
  }

  so_special_failure_hint_reset_dvars();
}

enable_triggered_start(challenge_id_start) {
  level endon("challenge_timer_expired");

  trigger_ent = getent(challenge_id_start, "script_noteworthy");
  AssertEx(isDefined(trigger_ent), "challenge_id (" + challenge_id_start + ") was unable to match with a valid trigger.");

  trigger_ent waittill("trigger");
  flag_set(challenge_id_start);
}

enable_triggered_complete(challenge_id, challenge_id_complete, touch_style) {
  level endon("challenge_timer_expired");

  flag_set(challenge_id);

  if(!isDefined(touch_style))
    touch_style = "freeze";

  trigger_ent = getent(challenge_id, "script_noteworthy");
  AssertEx(isDefined(trigger_ent), "challenge_id (" + challenge_id + ") was unable to match with a valid trigger.");
  thread disable_mission_end_trigger(trigger_ent);

  switch (touch_style) {
    case "all":
      wait_all_players_are_touching(trigger_ent);
      break;
    case "any":
      wait_all_players_have_touched(trigger_ent, touch_style);
      break;
    case "freeze":
      wait_all_players_have_touched(trigger_ent, touch_style);
      break;
  }

  level.challenge_end_time = gettime();
  flag_set(challenge_id_complete);
}

fade_challenge_in(wait_time, doDialogue) {
  if(!isDefined(wait_time))
    wait_time = 0.5;

  alpha = 1;
  if(isDefined(level.so_waiting_for_players_alpha))
    alpha = level.so_waiting_for_players_alpha;
  screen_fade = create_client_overlay("black", alpha);

  wait wait_time;

  screen_fade thread fade_over_time(0, 1);
  wait 0.75;

  if(!isDefined(doDialogue) || (isDefined(doDialogue) && doDialogue)) {
    thread so_dialog_ready_up();
  }
}

fade_challenge_out(challenge_id, skipDialog) {
  if(!isDefined(skipDialog))
    skipDialog = false;

  if(isDefined(challenge_id))
    flag_wait(challenge_id);

  if(!skipDialog)
    thread so_dialog_mission_success();

  specialops_mission_over_setup(true);

  setDvar("ui_mission_success", 1);
  maps\_endmission::coop_eog_summary();

  specialops_summary_player_choice();
}

enable_countdown_timer(time_wait, set_start_time, message, timer_draw_delay) {
  level endon("special_op_terminated");

  if(!isDefined(message))
    message = &"SPECIAL_OPS_STARTING_IN";

  hudelem = so_create_hud_item(0, so_hud_ypos(), message);
  hudelem SetPulseFX(50, time_wait * 1000, 500);

  hudelem_timer = so_create_hud_item(0, so_hud_ypos());
  hudelem_timer thread show_countdown_timer_time(time_wait, timer_draw_delay);

  wait time_wait;
  level.player playSound("arcademode_zerodeaths");

  if(isDefined(set_start_time) && set_start_time)
    level.challenge_start_time = gettime();

  thread destroy_countdown_timer(hudelem, hudelem_timer);
}

destroy_countdown_timer(hudelem, hudelem_timer) {
  wait 1;
  hudelem Destroy();
  hudelem_timer Destroy();
}

show_countdown_timer_time(time_wait, delay) {
  self.alignX = "left";
  self settenthstimer(time_wait);
  self.alpha = 0;

  if(!isDefined(delay))
    delay = 0.625;
  wait delay;
  time_wait = int((time_wait - delay) * 1000);

  self SetPulseFX(50, time_wait, 500);
  self.alpha = 1;
}

enable_challenge_timer(start_flag, passed_flag, message) {
  assertex(isDefined(passed_flag), "display_challenge_timer_down() needs a valid passed_flag.");

  if(isDefined(start_flag)) {
    if(!flag_exist(start_flag))
      flag_init(start_flag);
    level.start_flag = start_flag;
  }

  if(isDefined(passed_flag)) {
    if(!flag_exist(passed_flag))
      flag_init(passed_flag);
    level.passed_flag = passed_flag;
  }

  if(!isDefined(message))
    message = &"SPECIAL_OPS_TIME";

  if(!isDefined(level.challenge_time_beep_start))
    level.challenge_time_beep_start = level.challenge_time_hurry;
  level.so_challenge_time_beep = level.challenge_time_beep_start + 1;

  foreach(player in level.players)
  player thread challenge_timer_player_setup(start_flag, passed_flag, message);
}

so_wait_for_players_ready() {
  if(!isDefined(level.so_enable_wait_for_players)) {
    return;
  }
  if(!is_coop() || issplitscreen()) {
    return;
  }
  level.so_waiting_for_players = true;
  level.so_waiting_for_players_alpha = 0.85;

  level.player thread so_wait_for_player_ready("special_op_p1ready", 2);
  level.player2 thread so_wait_for_player_ready("special_op_p2ready", 3.25);

  screen_hold = create_client_overlay("black", 1);
  screen_hold fade_over_time(level.so_waiting_for_players_alpha, 1);

  while(!flag("special_op_p1ready") || !flag("special_op_p2ready"))
    wait 0.05;

  hold_time = 1;

  level.player thread so_wait_for_player_ready_cleanup(hold_time);
  level.player2 thread so_wait_for_player_ready_cleanup(hold_time);

  wait hold_time;

  screen_hold Destroy();
  level.so_waiting_for_players = undefined;
}

so_wait_for_player_ready(my_flag, y_line) {
  self endon("stop_waiting_start");

  self freezecontrols(true);
  self disableweapons();

  self.waiting_to_start_hud = so_create_hud_item(0, 0, &"SPECIAL_OPS_PRESS_TO_START", self, true);
  self.waiting_to_start_hud.alignx = "center";
  self.waiting_to_start_hud.horzAlign = "center";

  self.ready_indication_hud = so_create_hud_item(y_line, 0, &"SPECIAL_OPS_PLAYER_IS_NOT_READY", undefined, true);
  self.ready_indication_hud.alignx = "center";
  self.ready_indication_hud.horzAlign = "center";
  self.ready_indication_hud settext(self.playername);
  self.ready_indication_hud set_hud_yellow();

  wait 0.05;
  self setBlurForPlayer(6, 0);

  NotifyOnCommand(self.unique_id + "_is_ready", "+gostand");
  NotifyOnCommand(self.unique_id + "_is_not_ready", "+stance");

  while(1) {
    self waittill(self.unique_id + "_is_ready");
    flag_set(my_flag);
    self playSound("so_player_is_ready");
    self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_CANCEL";
    self.ready_indication_hud so_hud_pulse_success(&"SPECIAL_OPS_PLAYER_IS_READY");

    self waittill(self.unique_id + "_is_not_ready");
    flag_clear(my_flag);
    self playSound("so_player_not_ready");
    self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_START";
    self.ready_indication_hud so_hud_pulse_warning(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  }
}

so_wait_for_player_ready_cleanup(hold_time) {
  self notify("stop_waiting_start");
  self.waiting_to_start_hud thread so_remove_hud_item(true);

  wait hold_time;

  self.ready_indication_hud thread so_remove_hud_item(false, true);
  self freezecontrols(false);
  self enableweapons();
  self setBlurForPlayer(0, 0.5);
}

attacker_is_p1(attacker) {
  if(!isDefined(attacker))
    return false;

  return attacker == level.player;
}

attacker_is_p2(attacker) {
  if(!is_coop())
    return false;

  if(!isDefined(attacker))
    return false;

  return attacker == level.player2;
}

enable_escape_warning() {
  level endon("special_op_terminated");

  level.escape_warning_triggers = getEntArray("player_trying_to_escape", "script_noteworthy");
  assertex(level.escape_warning_triggers.size > 0, "enable_escape_warning() requires at least one trigger with script_noteworthy = player_trying_to_escape");

  add_hint_string("player_escape_warning", &"SPECIAL_OPS_EMPTY", ::disable_escape_warning);
  while(true) {
    wait 0.05;
    foreach(trigger in level.escape_warning_triggers) {
      foreach(player in level.players) {
        if(!isDefined(player.escape_hint_active)) {
          if(player istouching(trigger)) {
            player.escape_hint_active = true;
            player thread ping_escape_warning();
            player display_hint_timeout("player_escape_warning");
          }
        } else {
          if(!isDefined(player.ping_escape_splash))
            player thread ping_escape_warning();
        }
      }
    }
  }
}

enable_escape_failure() {
  level endon("special_op_terminated");

  flag_wait("player_has_escaped");

  level.challenge_end_time = gettime();

  so_force_deadquote("@DEADQUOTE_SO_LEFT_PLAY_AREA");
  maps\_utility::missionFailedWrapper();
}

so_delete_all_by_type(type1_def_func, type2_def_func, type3_def_func, type4_def_func, type5_def_func) {
  all_ents = getEntArray();
  foreach(ent in all_ents) {
    if(!isDefined(ent.code_classname)) {
      continue;
    }
    isSpecialOpEnt = (isDefined(ent.script_specialops) && ent.script_specialops == 1);
    if(isSpecialOpEnt) {
      continue;
    }
    isIntelItem = (isDefined(ent.targetname) && ent.targetname == "intelligence_item");
    if(isIntelItem) {
      continue;
    }
    if(ent[[type1_def_func]]())
      ent delete();

    if(isDefined(type2_def_func) && ent[[type2_def_func]]())
      ent delete();

    if(isDefined(type3_def_func) && ent[[type3_def_func]]())
      ent delete();

    if(isDefined(type4_def_func) && ent[[type4_def_func]]())
      ent delete();

    if(isDefined(type5_def_func) && ent[[type5_def_func]]())
      ent delete();
  }
}
type_spawners() {
  if(!isDefined(self.code_classname))
    return false;

  return isSubStr(self.code_classname, "actor_");
}

type_vehicle() {
  if(!isDefined(self.code_classname))
    return false;

  return isSubStr(self.code_classname, "script_vehicle");
}

type_spawn_trigger() {
  if(!isDefined(self.classname))
    return false;

  if(self.classname == "trigger_multiple_spawn")
    return true;

  if(self.classname == "trigger_multiple_spawn_reinforcement")
    return true;

  if(self.classname == "trigger_multiple_friendly_respawn")
    return true;

  if(isDefined(self.targetname) && self.targetname == "flood_spawner")
    return true;

  if(isDefined(self.targetname) && self.targetname == "friendly_respawn_trigger")
    return true;

  if(isDefined(self.spawnflags) && self.spawnflags & 32)
    return true;

  return false;
}

type_trigger() {
  if(!isDefined(self.code_classname))
    return false;

  array = [];
  array["trigger_multiple"] = 1;
  array["trigger_once"] = 1;
  array["trigger_use"] = 1;
  array["trigger_radius"] = 1;
  array["trigger_lookat"] = 1;
  array["trigger_disk"] = 1;
  array["trigger_damage"] = 1;

  return isDefined(array[self.code_classname]);
}

type_flag_trigger() {
  if(!isDefined(self.classname)) {
    return false;
  }

  array = [];
  array["trigger_multiple_flag_set"] = 1;
  array["trigger_multiple_flag_set_touching"] = 1;
  array["trigger_multiple_flag_clear"] = 1;
  array["trigger_multiple_flag_looking"] = 1;
  array["trigger_multiple_flag_lookat"] = 1;

  return isDefined(array[self.classname]);
}

type_killspawner_trigger() {
  if(!self type_trigger()) {
    return false;
  }

  if(isDefined(self.script_killspawner)) {
    return true;
  }

  return false;
}

type_goalvolume() {
  if(!isDefined(self.classname)) {
    return false;
  }

  if(self.classname == "info_volume" && isDefined(self.script_goalvolume)) {
    return true;
  }

  return false;
}

so_delete_all_spawntriggers() {
  so_delete_all_by_type(::type_spawn_trigger);
}

so_delete_all_triggers() {
  so_delete_all_by_type(::type_trigger);
}

so_delete_all_vehicles() {
  so_delete_all_by_type(::type_vehicle);
}

so_delete_all_spawners() {
  so_delete_all_by_type(::type_spawners);
}

so_delete_breach_ents() {
  breach_solids = getEntArray("breach_solid", "targetname");
  foreach(ent in breach_solids) {
    ent connectPaths();
    ent delete();
  }
}

so_force_deadquote(quote, icon_dvar) {
  assertex(isDefined(quote), "so_force_deadquote() requires a valid quote to be passed in.");

  level.so_deadquotes = [];
  level.so_deadquotes[0] = quote;
  level.so_deadquotes_chance = 1.0;

  so_special_failure_hint_reset_dvars(icon_dvar);
}

so_force_deadquote_array(quotes, icon_dvar) {
  assertex(isDefined(quotes), "so_force_deadquote_array() requires a valid quote array to be passed in.");

  level.so_deadquotes = quotes;
  level.so_deadquotes_chance = 1.0;

  so_special_failure_hint_reset_dvars(icon_dvar);
}

so_include_deadquote_array(quotes) {
  assertex(isDefined(quotes), "so_include_deadquote_array() requires a valid quote array to be passed in.");

  if(!isDefined(level.so_deadquotes))
    level.so_deadquotes = [];
  level.so_deadquotes = array_merge(level.so_deadquotes, quotes);
}

so_create_hud_item(yLine, xOffset, message, player, always_draw) {
  if(isDefined(player))
    assertex(isPlayer(player), "so_create_hud_item() received a value for player that did not pass the isPlayer() check.");

  if(!isDefined(yLine))
    yLine = 0;
  if(!isDefined(xOffset))
    xOffset = 0;

  yLine += 2;

  hudelem = undefined;
  if(isDefined(player))
    hudelem = newClientHudElem(player);
  else
    hudelem = newHudElem();
  hudelem.alignX = "right";
  hudelem.alignY = "middle";
  hudelem.horzAlign = "right";
  hudelem.vertAlign = "middle";
  hudelem.x = xOffset;
  hudelem.y = -100 + (15 * yLine);
  hudelem.font = "hudsmall";
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = true;
  hudelem.hidewhendead = true;
  hudelem.sort = 2;
  hudelem set_hud_white();

  if(isDefined(message))
    hudelem.label = message;

  if(!isDefined(always_draw) || !always_draw) {
    if(isDefined(player)) {
      if(!player so_hud_can_show())
        player thread so_create_hud_item_delay_draw(hudelem);
    }
  }

  return hudelem;
}

so_hud_pulse_create(new_value) {
  if(!so_hud_pulse_init()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(new_value))
    self.label = new_value;

  if(isDefined(self.pulse_sound))
    level.player playSound(self.pulse_sound);

  if(isDefined(self.pulse_loop) && self.pulse_loop)
    so_hud_pulse_loop();
  else
    so_hud_pulse_single(self.pulse_scale_big, self.pulse_scale_normal, self.pulse_time);
}

so_hud_pulse_stop(new_value) {
  if(!so_hud_pulse_init()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(new_value))
    self.label = new_value;

  self.pulse_loop = false;
  so_hud_pulse_single(self.fontscale, self.pulse_scale_normal, self.pulse_time);
}

so_hud_pulse_default(new_value) {
  set_hud_white();

  self.pulse_loop = false;
  so_hud_pulse_create(new_value);
}

so_hud_pulse_close(new_value) {
  set_hud_green();

  self.pulse_loop = true;
  so_hud_pulse_create(new_value);
}

so_hud_pulse_success(new_value) {
  set_hud_green();

  self.pulse_loop = false;
  so_hud_pulse_create(new_value);
}

so_hud_pulse_warning(new_value) {
  set_hud_yellow();

  self.pulse_loop = false;
  so_hud_pulse_create(new_value);
}

so_hud_pulse_alarm(new_value) {
  set_hud_red();

  self.pulse_loop = true;
  so_hud_pulse_create(new_value);
}

so_hud_pulse_failure(new_value) {
  set_hud_red();

  self.pulse_loop = false;
  so_hud_pulse_create(new_value);
}

so_hud_ypos() {
  return -72;
}

so_remove_hud_item(destroy_immediately, decay_immediately) {
  if(isDefined(destroy_immediately) && destroy_immediately) {
    self notify("destroying");
    self Destroy();
    return;
  }

  self thread so_hud_pulse_stop();

  if(isDefined(decay_immediately) && decay_immediately) {
    self SetPulseFX(0, 0, 500);
    wait(0.5);
  } else {
    self SetPulseFX(0, 1500, 500);
    wait(2);
  }

  self notify("destroying");
  self Destroy();
}

set_hud_white(new_alpha) {
  if(isDefined(new_alpha)) {
    self.alpha = new_alpha;
    self.glowAlpha = new_alpha;
  }

  self.color = (1, 1, 1);
  self.glowcolor = (0.6, 0.6, 0.6);
}

set_hud_blue(new_alpha) {
  if(isDefined(new_alpha)) {
    self.alpha = new_alpha;
    self.glowAlpha = new_alpha;
  }

  self.color = (0.8, 0.8, 1);
  self.glowcolor = (0.301961, 0.301961, 0.6);
}

set_hud_green(new_alpha) {
  if(isDefined(new_alpha)) {
    self.alpha = new_alpha;
    self.glowAlpha = new_alpha;
  }

  self.color = (0.8, 1, 0.8);
  self.glowcolor = (0.301961, 0.6, 0.301961);
}

set_hud_yellow(new_alpha) {
  if(isDefined(new_alpha)) {
    self.alpha = new_alpha;
    self.glowAlpha = new_alpha;
  }

  self.color = (1, 1, 0.5);
  self.glowcolor = (0.7, 0.7, 0.2);
}

set_hud_red(new_alpha) {
  if(isDefined(new_alpha)) {
    self.alpha = new_alpha;
    self.glowAlpha = new_alpha;
  }

  self.color = (1, 0.4, 0.4);
  self.glowcolor = (0.7, 0.2, 0.2);
}

info_hud_wait_for_player(endon_notify) {
  assertex(isPlayer(self), "info_hud_wait_for_player() must be called on a player.");

  if(isDefined(self.so_infohud_toggle_state)) {
    return;
  }
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");
  if(isDefined(endon_notify))
    level endon(endon_notify);

  self setWeaponHudIconOverride("actionslot1", "hud_show_timer");
  notifyoncommand("toggle_challenge_timer", "+actionslot 1");
  self.so_infohud_toggle_state = info_hud_start_state();

  if(!so_hud_can_show()) {
    thread info_hud_wait_force_on();
    self ent_flag_wait("so_hud_can_toggle");
  }

  self notify("so_hud_toggle_available");
  while(1) {
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

  if(isDefined(level.challenge_time_limit))
    return "on";

  if(isDefined(level.challenge_time_force_on) && level.challenge_time_force_on)
    return "on";

  return "off";
}

info_hud_handle_fade(hudelem, endon_notify) {
  assertex(isPlayer(self), "info_hud_handle_fade() must be called on a player.");
  assertex(isDefined(hudelem), "info_hud_handle_fade() requires a valid hudelem to be passed in.");

  level endon("new_challenge_timer");
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");
  if(isDefined(endon_notify))
    level endon(endon_notify);

  hudelem.so_can_toggle = true;

  self ent_flag_wait("so_hud_can_toggle");
  info_hud_update_alpha(hudelem);

  while(1) {
    self waittill("update_challenge_timer");
    hudelem FadeOverTime(0.25);
    info_hud_update_alpha(hudelem);
  }
}

info_hud_update_alpha(hudelem) {
  switch (self.so_infohud_toggle_state) {
    case "on":
      hudelem.alpha = 1;
      break;
    case "off":
      hudelem.alpha = 0;
      break;
  }
}

info_hud_decrement_timer(time) {
  if(!isDefined(level.challenge_time_limit)) {
    return;
  }

  if(flag("challenge_timer_expired") || flag("challenge_timer_passed")) {
    return;
  }

  level.so_challenge_time_left -= time;

  if(level.so_challenge_time_left < 0) {
    level.so_challenge_time_left = 0.01;
  }

  red = (0.6, 0.2, 0.2);
  red_glow = (0.4, 0.1, 0.1);
  foreach(player in level.players) {
    player.hud_so_timer_time SetTenthsTimer(level.so_challenge_time_left);
  }

  thread challenge_timer_thread();
}

is_dvar_character_switcher(dvar) {
  val = getDvar(dvar);
  return val == "so_char_client" || val == "so_char_host";
}
best_time_name = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);
if(best_time_name == "")
  return false;

foreach(player in level.players) {
  current_best_time = player GetLocalPlayerProfileData(best_time_name);

  if(!isDefined(current_best_time)) {
    continue;
  }
  if(current_best_time != 0)
    return true;
}

return false;
}

is_best_time(time_start, time_current, time_frac) {
  if(!isDefined(time_start)) {
    if(isDefined(level.challenge_start_time))
      time_start = level.challenge_start_time;
    else
      time_start = 300;
  }

  if(!isDefined(time_current))
    time_current = gettime();

  if(!isDefined(time_frac))
    time_frac = 0.0;

  m_seconds = (time_current - time_start);
  m_seconds = int(min(m_seconds, 86400000));
  best_time_name = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);
  if(best_time_name == "")
    return false;

  foreach(player in level.players) {
    current_best_time = player GetLocalPlayerProfileData(best_time_name);

    if(!isDefined(current_best_time)) {
      continue;
    }
    never_played = (current_best_time == 0);
    if(never_played) {
      continue;
    }
    current_best_time -= (current_best_time * time_frac);
    if(m_seconds < current_best_time)
      return true;
  }

  return false;
}

is_poor_time(time_start, time_current, time_frac) {
  if(!isDefined(time_start)) {
    if(isDefined(level.challenge_start_time))
      time_start = level.challenge_start_time;
    else
      time_start = 300;
  }

  if(!isDefined(time_current))
    time_current = gettime();

  if(!isDefined(time_frac))
    time_frac = 0.0;

  m_seconds = (time_current - time_start);
  m_time_limit = (level.challenge_time_limit * 1000);
  m_time_limit -= (m_time_limit * time_frac);

  return (m_seconds > m_time_limit);
}

so_dialog_ready_up() {
  so_dialog_play("so_tf_1_plyr_prep", 0, true);
}

so_dialog_mission_success() {
  if(is_best_time(level.challenge_start_time, level.challenge_end_time)) {
    thread so_dialog_play("so_tf_1_success_best", 0.5, true);
    return;
  }

  do_sarcasm = false;
  if(level.gameSkill >= 3) {
    if(has_been_played())
      do_sarcasm = cointoss();
  }

  if(do_sarcasm)
    so_dialog_play("so_tf_1_success_jerk", 0.5, true);
  else
    so_dialog_play("so_tf_1_success_generic", 0.5, true);
}

so_dialog_mission_failed(sound_alias) {
  assertex(isDefined(sound_alias), "so_dialog_mission_failed() requires a valid sound_alias.");
  if(isDefined(level.failed_dialog_played) && level.failed_dialog_played) {
    return;
  }
  level.failed_dialog_played = true;
  so_dialog_play(sound_alias, 0.5, true);
}

so_dialog_mission_failed_generic() {
  if((level.gameskill <= 2) || cointoss())
    so_dialog_mission_failed("so_tf_1_fail_generic");
  else
    so_dialog_mission_failed("so_tf_1_fail_generic_jerk");
}

so_dialog_mission_failed_time() {
  so_dialog_mission_failed("so_tf_1_fail_time");
}

so_dialog_mission_failed_bleedout() {
  so_dialog_mission_failed("so_tf_1_fail_bleedout");
}

so_dialog_time_low_normal() {
  so_dialog_play("so_tf_1_time_generic");
}

so_dialog_time_low_hurry() {
  so_dialog_play("so_tf_1_time_hurry");
}

so_dialog_killing_civilians() {
  if(!isDefined(level.civilian_warning_time)) {
    level.civilian_warning_time = gettime();
    if(!isDefined(level.civilian_warning_throttle))
      level.civilian_warning_throttle = 5000;
  } else {
    if((gettime() - level.civilian_warning_time) < level.civilian_warning_throttle)
      return;
  }

  wait_time = 0.5;
  level.civilian_warning_time = gettime() + (wait_time * 1000);
  so_dialog_play("so_tf_1_civ_kill_warning", 0.5);
}
so_dialog_progress_update(current_value, current_goal) {
  if(!isDefined(current_value)) {
    return;
  }
  if(!isDefined(current_goal)) {
    return;
  }
  if(!isDefined(level.so_progress_goal_status))
    level.so_progress_goal_status = "none";

  time_frac = undefined;
  switch (level.so_progress_goal_status) {
    case "none":
      time_frac = 0.75;
      break;
    case "3quarter":
      time_frac = 0.5;
      break;
    case "half":
      time_frac = 0.25;
      break;
    default:
      return;
  }

  test_goal = current_goal * time_frac;
  if(current_value > test_goal) {
    return;
  }
  time_dialog = undefined;
  switch (level.so_progress_goal_status) {
    case "none":
      level.so_progress_goal_status = "3quarter";
      time_dialog = "so_tf_1_progress_3quarter";
      break;
    case "3quarter":
      level.so_progress_goal_status = "half";
      time_dialog = "so_tf_1_progress_half";
      break;
    case "half":
      level.so_progress_goal_status = "quarter";
      time_dialog = "so_tf_1_progress_quarter";
      break;
  }

  so_dialog_play(time_dialog, 0.5);
}

so_dialog_progress_update_time_quality(time_frac) {
  if(isDefined(level.challenge_time_limit)) {
    if(is_poor_time(level.challenge_start_time, gettime(), time_frac)) {
      so_dialog_play("so_tf_1_time_status_late", 0.2);
      return;
    }
  }

  if(is_best_time(level.challenge_start_time, gettime(), time_frac))
    so_dialog_play("so_tf_1_time_status_good", 0.2);
}

so_dialog_counter_update(current_count, current_goal, countdown_divide) {
  if(!isDefined(level.so_counter_dialog_time))
    level.so_counter_dialog_time = 0;
  if(gettime() < level.so_counter_dialog_time) {
    return;
  }
  if(!isDefined(current_count)) {
    return;
  }
  if(!isDefined(countdown_divide))
    countdown_divide = 1;
  adjusted_count = int(current_count / countdown_divide);

  if(adjusted_count > 5) {
    if(!isDefined(level.challenge_progress_manual_update) || !level.challenge_progress_manual_update) {
      thread so_dialog_progress_update(current_count, current_goal);
      level.so_counter_dialog_time = gettime() + 800;
    }
    return;
  }

  switch (adjusted_count) {
    case 5:
      thread so_dialog_play("so_tf_1_progress_5more", 0.5);
      break;
    case 4:
      thread so_dialog_play("so_tf_1_progress_4more", 0.5);
      break;
    case 3:
      thread so_dialog_play("so_tf_1_progress_3more", 0.5);
      break;
    case 2:
      thread so_dialog_play("so_tf_1_progress_2more", 0.5);
      break;
    case 1:
      thread so_dialog_play("so_tf_1_progress_1more", 0.5);
      break;
  }
  level.so_counter_dialog_time = gettime() + 800;
}
assert(isDefined(self));
assert(isDefined(player));

if(!isDefined(player.coop_death_reason)) {
  player.coop_death_reason = [];
}

if(!isDefined(mod)) {
  mod = "MOD_EXPLOSIVE";
}

player.coop_death_reason["attacker"] = self;
player.coop_death_reason["cause"] = mod;
player.coop_death_reason["weapon_name"] = "none";

player kill_wrapper();
}