/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_airdrop.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\alien\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_perk_utility;

DROP_TO_GROUND_UP_DIST = 32;
DROP_TO_GROUND_DOWN_DIST = -128;

init_escape() {
  if(!alien_mode_has("airdrop")) {
    return;
  }

  if(!flag_exist("hives_cleared")) {
    flag_init("hives_cleared");
  }

  if(!flag_exist("nuke_countdown")) {
    flag_init("nuke_countdown");
  }

  if(!flag_exist("escape_conditions_met")) {
    flag_init("escape_conditions_met");
  }

  flag_init("nuke_went_off");

  init_fx();
  init_chaos_airdrop();
}

init_fx() {
  level._effect["alien_heli_spotlight"] = loadfx("vfx/gameplay/alien/vfx_alien_spotlight_heli_model");
  level._effect["cockpit_blue_cargo01"] = loadfx("fx/misc/aircraft_light_cockpit_red");
  level._effect["cockpit_blue_cockpit01"] = loadfx("fx/misc/aircraft_light_cockpit_blue");
  level._effect["white_blink"] = loadfx("fx/misc/aircraft_light_white_blink");
  level._effect["white_blink_tail"] = loadfx("fx/misc/aircraft_light_red_blink");
  level._effect["wingtip_green"] = loadfx("fx/misc/aircraft_light_wingtip_green");
  level._effect["wingtip_red"] = loadfx("fx/misc/aircraft_light_wingtip_red");
  level._effect["spot"] = loadfx("fx/misc/aircraft_light_hindspot");
  level._effect["harrier_heavy_smoke"] = LoadFX("fx/smoke/smoke_trail_black_heli_emitter");
  level._effect["escape_zone_ring"] = LoadFx("vfx/gameplay/alien/vfx_alien_chopper_escape_ring");
}

CONST_NUKE_TIMER = 240;

escape() {
  level endon("game_ended");

  setup_special_spawn_trigs();

  maps\mp\alien\_spawnlogic::escape_choke_init();

  nuke_trig = spawn("script_model", (-4606.2, 3258.7, 307.7));
  nuke_trig setModel("tag_origin");
  nuke_trig MakeUsable();

  wait 0.05;

  icon = NewHudElem();
  icon SetShader("waypoint_bomb", 14, 14);
  icon.alpha = 1;
  icon.color = (1, 1, 1);
  icon SetWayPoint(true, true);
  icon.x = nuke_trig.origin[0];
  icon.y = nuke_trig.origin[1];
  icon.z = nuke_trig.origin[2];

  nuke_trig SetCursorHint("HINT_ACTIVATE");

  level thread players_use_nuke_monitor(nuke_trig);

  if(isDefined(level.players) && level.players.size > 1) {
    nuke_trig SetHintString(&"ALIEN_COLLECTIBLES_ACTIVATE_NUKE");
    IPrintLnBold(&"ALIEN_COLLECTIBLES_NUKE_ACTIVATE_USE");
  } else {
    nuke_trig SetHintString(&"ALIEN_COLLECTIBLES_ACTIVATE_NUKE_SOLO");
    IPrintLnBold(&"ALIEN_COLLECTIBLES_NUKE_ACTIVATE_USE_SOLO");
  }

  wait_for_all_player_use();

  level thread maps\mp\alien\_spawnlogic::escape_spawning(level.escape_cycle);

  level thread maps\mp\alien\_music_and_dialog::playVOForNukeArmed();

  escape_ent = getent("escape_zone", "targetname");
  if(isDefined(level.rescue_waypoint)) {
    level.rescue_waypoint destroy();
  }

  level.rescue_waypoint = NewHudElem();
  level.rescue_waypoint SetShader("waypoint_alien_beacon", 14, 14);
  level.rescue_waypoint.alpha = 0;
  level.rescue_waypoint.color = (1, 1, 1);
  level.rescue_waypoint SetWayPoint(true, true);
  level.rescue_waypoint.x = escape_ent.origin[0];
  level.rescue_waypoint.y = escape_ent.origin[1];
  level.rescue_waypoint.z = escape_ent.origin[2];

  flag_set("nuke_countdown");

  flag_clear("alien_music_playing");
  level thread maps\mp\alien\_music_and_dialog::Play_Nuke_Set_Music();

  icon destroy();
  nuke_trig MakeUnUsable();
  nuke_trig SetCursorHint("HINT_ACTIVATE");
  nuke_trig SetHintString("");
  nuke_trig delete();

  escape_start_time = getTime();

  level thread nuke_countdown();

  level thread rescue_think(escape_start_time);

  level thread infinite_mode_events();
}

players_use_nuke_monitor(nuke_trig) {
  level endon("all_players_using_nuke");

  foreach(player in level.players) {
    player thread watch_for_use_nuke_trigger(nuke_trig);
  }

  while(true) {
    level waittill("connected", player);
    player thread watch_for_use_nuke_trigger(nuke_trig);
  }
}

rescue_think(escape_start_time) {
  level endon("game_ended");

  escape_ent = getent("escape_zone", "targetname");
  chopper_struct = getstruct(escape_ent.target, "targetname");
  chopper_loc = chopper_struct.origin;
  chopper_angles = chopper_struct.angles;

  level.escape_loc = escape_ent.origin;

  thread call_in_rescue_heli(chopper_loc, chopper_angles, 10);

  while(!isDefined(level.rescue_heli)) {
    wait 0.05;
  }

  level.rescue_heli delaythread(5, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_comeon");

  level.rescue_heli thread heli_leave_on_nuke();
  level.rescue_heli thread fly_to_extraction_on_trigger();

  level.rescue_heli waittill_either_in_position_or_nuke();
  thread watch_player_escape(escape_ent, escape_start_time);
}

waittill_either_in_position_or_nuke() {
  level endon("nuke_went_off");
  self waittill("in_position");

  level.rescue_heli thread maps\mp\alien\_music_and_dialog::play_pilot_vo("so_alien_plt_exfil");
  level thread get_on_chopper_nag();
}

get_on_chopper_nag() {
  level endon("nuke_went_off");
  level endon("escape_conditions_met");

  nag_lines = ["so_alien_plt_getonchopper", "so_alien_plt_hurryup", "so_alien_plt_comeon"];

  while(1) {
    wait(randomintrange(10, 15));
    level.rescue_heli thread maps\mp\alien\_music_and_dialog::play_pilot_vo(random(nag_lines));
  }
}

heli_leave_on_nuke() {
  self endon("death");

  self waittill("rescue_chopper_exit");

  self setneargoalnotifydist(200);

  self.near_goal = true;

  start_node = self.exit_path[0];
  for(i = 0; i < self.exit_path.size; i++) {
    fly_to_node = self.exit_path[i];
    self heli_fly_to(fly_to_node.origin, int(min(35, 20 + i * 5)));
  }
}

fly_to_extraction_on_trigger() {
  level endon("nuke_went_off");
  self endon("death");

  fly_to_extraction_trigger = getent("fly_to_extraction_trig", "targetname");
  while(1) {
    fly_to_extraction_trigger waittill("trigger", owner);
    if(IsPlayer(owner)) {
      self notify("fly_to_extraction");
      return;
    }
    wait 0.05;
  }
}

watch_player_escape(escape_ent, escape_start_time) {
  level.rescue_heli endon("death");

  org = escape_ent.origin;
  rad = escape_ent.radius;
  height = 128;

  escape_ring_fx = spawnFx(level._effect["escape_zone_ring"], org);
  triggerFx(escape_ring_fx);

  escape_trig = spawn("trigger_radius", org, 0, rad, height);

  wait_for_escape_conditions_met(escape_trig);

  escape_ring_fx delete();

  flag_set("escape_conditions_met");

  if(isDefined(level.rescue_waypoint)) {
    level.rescue_waypoint destroy();
  }

  assertex(isDefined(level.rescue_heli), "Chopper became undefined while waiting to rescue");
  level.rescue_heli notify("extract");

  players_escaped = [];
  players_left = [];
  foreach(player in level.players) {
    if(player IsTouching(escape_trig) && isalive(player) && !(isDefined(player.laststand) && player.laststand)) {
      players_escaped[players_escaped.size] = player;

      if(!is_casual_mode()) {
        player maps\mp\alien\_persistence::set_player_escaped();
      }

      player.nuke_escaped = true;
    } else {
      players_left[players_left.size] = player;
      player.nuke_escaped = false;
    }
  }

  foreach(player in level.players) {
    if(true == player.nuke_escaped) {
      player maps\mp\alien\_persistence::award_completion_tokens();
    }
  }

  level.num_players_left = level.players.size - players_escaped.size;
  level.num_players_escaped = players_escaped.size;

  foreach(player in players_left) {
    player IPrintLnBold(&"ALIEN_COLLECTIBLES_YOU_DIDNT_MAKE_IT");
  }

  if(players_escaped.size == 0) {
    failed_msg = maps\mp\alien\_hud::get_end_game_string_index("fail_escape");
    level delaythread(15, maps\mp\gametypes\aliens::AlienEndGame, "axis", failed_msg);
    level.rescue_heli notify("rescue_chopper_exit");
    return;
  }

  escape_time_remains = get_escape_time_remains(escape_start_time);

  teleport_struct = getstruct("player_teleport_loc", "targetname");
  teleport_loc = teleport_struct.origin;

  foreach(player in players_escaped) {
    player thread player_blend_to_chopper();
  }

  wait 1.6;

  if(level.players.size == 1) {
    level.rescue_heli delaythread(2, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_itsjustyou");
  } else if(level.players.size > level.num_players_escaped) {
    level.rescue_heli delaythread(2, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_wherestherest");
  }

  level thread maps\mp\alien\_music_and_dialog::Play_Exfil_Music();
  thread sfx_rescue_heli_escape(level.rescue_heli);
  wait 0.5;
  level.rescue_heli notify("rescue_chopper_exit");
  wait 4;

  level notify("force_nuke_detonate");

  pilot_lines = ["so_alien_plt_sourceofinvasion", "so_alien_plt_squashmorebugs"];
  level.rescue_heli delaythread(2, maps\mp\alien\_music_and_dialog::play_pilot_vo, random(pilot_lines));

  level.rescue_heli thread play_nuke_rumble(4.5);

  maps\mp\alien\_alien_matchdata::set_escape_time_remaining(escape_time_remains);

  maps\mp\alien\_achievement::update_escape_achievements(players_escaped, escape_time_remains);

  maps\mp\alien\_gamescore::process_end_game_score_escaped(escape_time_remains, players_escaped);

  maps\mp\alien\_unlock::update_escape_item_unlock(players_escaped);

  maps\mp\alien\_persistence::update_LB_alienSession_escape(players_escaped, escape_time_remains);

  wait 2;

  if(players_escaped.size == level.players.size) {
    win_msg = maps\mp\alien\_hud::get_end_game_string_index("all_escape");
  } else {
    win_msg = maps\mp\alien\_hud::get_end_game_string_index("some_escape");
  }

  level delaythread(10, maps\mp\gametypes\aliens::AlienEndGame, "allies", win_msg);
}

player_blend_to_chopper() {
  self endon("death");
  self endon("disconnect");

  if(self IsUsingTurret() && isDefined(self.current_sentry)) {
    self.current_sentry notify("death");
    wait 0.5;
  }

  self notify("force_cancel_placement");

  self.playerLinkedToChopper = true;
  self notify("dpad_cancel");
  self DisableUsability();

  self fade_black_screen();
  self.escape_overlay FadeOverTime(0.5);
  self.escape_overlay.alpha = 1;

  wait 0.5;

  self PlayerHide();
  self freezeControlsWrapper(true);

  position = "TAG_ALIEN_P1";

  self PlayerLinkToBlend(level.rescue_heli, position, 0.6, 0.2, 0.2);

  wait 0.6;

  self PlayerLinkTo(level.rescue_heli, position, 1, 50, 50, 18, 30, false);

  self thread force_crouch(true);
  self allowJump(false);

  self.escape_overlay FadeOverTime(0.5);
  self.escape_overlay.alpha = 0;
  wait 0.5;
  self.escape_overlay destroy();
}

fade_black_screen() {
  self.escape_overlay = newClientHudElem(self);
  self.escape_overlay.x = 0;
  self.escape_overlay.y = 0;
  self.escape_overlay setshader("black", 640, 480);
  self.escape_overlay.alignX = "left";
  self.escape_overlay.alignY = "top";
  self.escape_overlay.sort = 1;
  self.escape_overlay.horzAlign = "fullscreen";
  self.escape_overlay.vertAlign = "fullscreen";
  self.escape_overlay.alpha = 0;
  self.escape_overlay.foreground = true;
}

play_nuke_rumble(delay) {
  wait delay;
  foreach(player in level.players) {
    Earthquake(0.33, 4, player.origin, 1000);
    player PlayRumbleOnEntity("heavy_3s");
  }
}

force_crouch(force_on) {
  self endon("death");
  self endon("remove_force_crouch");

  if(isDefined(force_on) && force_on == false) {
    self notify("remove_force_crouch");
  } else {
    while(1) {
      if(self GetStance() != "crouch") {
        self setstance("crouch");
      }
      wait 0.05;
    }
  }
}

wait_for_escape_conditions_met(trig) {
  level endon("nuke_went_off");

  if(flag("nuke_went_off")) {
    return;
  }
  while(1) {
    alive_players_inside = [];
    alive_players_outside = [];

    foreach(player in level.players) {
      if(!isalive(player) || (isDefined(player.laststand) && player.laststand)) {
        continue;
      }
      if(player IsTouching(trig)) {
        alive_players_inside[alive_players_inside.size] = player;
      } else {
        alive_players_outside[alive_players_outside.size] = player;
      }
    }

    if(alive_players_inside.size == 0) {
      wait 0.05;
      continue;
    } else {
      if(alive_players_outside.size == 0) {
        return;
      }
    }

    wait 0.05;
  }
}

wait_for_all_player_use() {
  level endon("game_ended");

  if(maps\mp\alien\_debug::startPointEnabled()) {
    while(level.players.size == 0) {
      wait(0.5);
    }
  }

  while(!are_all_players_using_nuke()) {
    wait 0.05;
  }

  level notify("all_players_using_nuke");
}

are_all_players_using_nuke() {
  result = true;
  foreach(player in level.players) {
    if(!isDefined(player.player_using_nuke) || !player.player_using_nuke) {
      result = false;
    }
  }

  return result;
}

watch_for_use_nuke_trigger(nuke_trig) {
  level endon("game_ended");
  level endon("all_players_using_nuke");

  self endon("disconnect");
  self notify("watch_for_use_nuke");
  self endon("watch_for_use_nuke");

  self.player_using_nuke = false;

  while(true) {
    if(self UseButtonPressed() && DistanceSquared(self.origin, nuke_trig.origin) < 130 * 130) {
      self.player_using_nuke = true;
      self notify("using_nuke");
      self thread reset_nuke_usage();
    }

    wait 0.05;
  }
}

reset_nuke_usage() {
  level endon("game_ended");
  level endon("all_players_using_nuke");

  self endon("death");
  self endon("disconnect");

  self endon("using_nuke");

  wait 0.5;
  self.player_using_nuke = false;
}

nuke_countdown() {
  nukeTimer = CONST_NUKE_TIMER;
  level.nukeLoc = (-9068, 5883, 600);
  level.nukeAngles = (0, -60, 90);

  setomnvar("ui_alien_nuke_timer", gettime() + (CONST_NUKE_TIMER * 1000));
  level thread hide_timer_on_game_end();

  wait_for_nuke_detonate(nukeTimer, "force_nuke_detonate");

  level.nukeTimer = 3.35;
  level.players[0] thread maps\mp\alien\_nuke::doNukeSimple();

  flag_clear("nuke_countdown");
  setomnvar("ui_alien_nuke_timer", 0);
  flag_set("nuke_went_off");

  survived_time = 0;
  level thread track_survived_time(survived_time);

  wait 2;
  level.fx_crater_plume Delete();
}

hide_timer_on_game_end() {
  level waittill("game_ended");
  setomnvar("ui_alien_nuke_timer", 0);
}

get_escape_time_remains(escape_start_time) {
  escape_time_passed = getTime() - escape_start_time;
  escape_time_remains = CONST_NUKE_TIMER * 1000 - escape_time_passed;
  escape_time_remains = max(0, escape_time_remains);

  return escape_time_remains;
}

wait_for_nuke_detonate(nuke_timer, override_msg) {
  level endon(override_msg);

  if(!isDefined(level.nuke_clockObject)) {
    level.nuke_clockObject = spawn("script_origin", (0, 0, 0));
    level.nuke_clockObject hide();
  }

  nuke_timer = int(nuke_timer);
  while(nuke_timer > 0) {
    if(nuke_timer == 10) {
      level thread maps\mp\alien\_music_and_dialog::playVOfor10Seconds();
    }

    if(nuke_timer == 30) {
      level thread maps\mp\alien\_music_and_dialog::playVoFor30Seconds();
    }
    if(nuke_timer == 120) {
      level thread maps\mp\alien\_music_and_dialog::playVOforGetToLz();
    }

    if(nuke_timer <= 30) {
      level.nuke_clockObject playSound("ui_mp_nukebomb_timer");

    }
    wait(1.0);
    nuke_timer--;
  }

  return true;
}

track_survived_time(survived_time) {
  start_time = gettime();
  level waittill("game_ended");
  end_time = gettime();

  level.survived_time = end_time - start_time;
}

infinite_mode_events() {
  level endon("game_ended");

  level notify("force_cycle_start");

  level.infinite_event_index = 1;
  level.infinite_event_interval = 60;

  while(true) {
    wait_for_special_spawn();

    notify_msg = "chaos_event_2";
    level notify(notify_msg);

    level.last_special_event_spawn_time = gettime();

    maps\mp\alien\_spawn_director::activate_spawn_event(notify_msg);

    level.infinite_event_index++;
  }
}

wait_for_special_spawn() {
  level endon("force_chaos_event");

  if(level.infinite_event_index == 1) {
    wait 5;
  } else {
    wait level.infinite_event_interval;
  }

  if(GetDvarInt("alien_debug_escape") > 0) {
    IPrintLnBold("^0[SPECIALS SPAWNED][^7TIMED^0]");
  }
}

setup_special_spawn_trigs() {
  level.special_spawn_trigs = getEntArray("force_special_spawn_trig", "targetname");

  foreach(trig in level.special_spawn_trigs) {
    trig thread watch_special_spawn_trig();
  }
}

watch_special_spawn_trig() {
  level endon("game_ended");
  level endon("nuke_went_off");

  self endon("death");

  if(!flag_exist("nuke_countdown")) {
    return;
  }
  if(!flag("nuke_countdown")) {
    flag_wait("nuke_countdown");
  }

  while(1) {
    self waittill("trigger", player);
    if(isDefined(player) && isplayer(player) && isalive(player)) {
      break;
    } else {
      wait 0.05;
      continue;
    }
  }

  if(isDefined(level.last_special_event_spawn_time)) {
    grace_period = 15;
    if((gettime() - level.last_special_event_spawn_time) / 1000 > grace_period) {
      level notify("force_chaos_event");

      if(GetDvarInt("alien_debug_escape") > 0) {
        IPrintLnBold("^0[SPECIALS SPAWNED][^7TRIGGERED^0]");
      }

    }
  } else {
    if(GetDvarInt("alien_debug_escape") > 0) {
      IPrintLnBold("^0[SPECIALS SPAWNED][^7TRIGGERED^0]");
    }

    level notify("force_chaos_event");
  }

  if(isDefined(level.special_spawn_trigs) && level.special_spawn_trigs.size) {
    level.special_spawn_trigs = array_remove(level.special_spawn_trigs, self);
  }

  self delete();
}

CONST_HELI_LOOP_RADIUS = 1200;
CONST_HELI_LOOP_RADIUS_SMALL = 800;
CONST_HELI_START_DIST = 8000;
CONST_HELI_FLY_HEIGHT = 1500;
CONST_HELI_FLY_HEIGHT_LOW = 1200;
CONST_HELI_FLY_HEIGHT_HIGH = 2200;

CONST_HELI_FLY_IN_SPEED = 60;
CONST_HELI_FLY_OUT_SPEED = 60;
CONST_HELI_LOOP_SPEED = 30;

CONST_HELI_TARGETING_RANGE = 2500;

call_in_rescue_heli(drop_loc, drop_angles, player_loops) {
  level endon("game_ended");
  level endon("nuke_went_off");

  level.heli_fly_height = CONST_HELI_FLY_HEIGHT_LOW;
  level.heli_loop_radius = CONST_HELI_LOOP_RADIUS;

  CoM = get_center_of_players();

  raised_CoM = CoM + (0, 0, level.heli_fly_height);
  raised_drop_loc = drop_loc + (0, 0, level.heli_fly_height);

  scaled_goal_vec = level.heli_loop_radius * (0, 1, 0);
  scaled_start_vec = CONST_HELI_START_DIST * (0, 1, 0);

  path_goal_pos = raised_CoM + scaled_goal_vec;
  path_start_pos = raised_CoM + scaled_start_vec;

  if(isDefined(level.attack_heli)) {
    level.attack_heli notify("convert_to_hive_heli");
    stopFXOnTag(level._effect["alien_heli_spotlight"], level.attack_heli, "tag_flash");

    wait 0.5;
    level.rescue_heli = level.attack_heli;
  } else {
    level.rescue_heli = heli_setup(level.players[0], path_start_pos, path_goal_pos);
    level.rescue_heli thread heli_fx_setup();
  }

  level.rescue_heli hide_doors();

  level.rescue_heli.drop_loc = drop_loc;
  level.rescue_heli.exit_path = [];

  cur_node = getstruct("heli_extraction_start", "targetname");
  level.rescue_heli.exit_path[0] = cur_node;
  while(isDefined(cur_node.target)) {
    cur_node = getstruct(cur_node.target, "targetname");
    level.rescue_heli.exit_path[level.rescue_heli.exit_path.size] = cur_node;
  }

  level.rescue_heli thread heli_turret_think();

  level.rescue_heli heli_fly_to(path_goal_pos, CONST_HELI_FLY_IN_SPEED);

  wait 1;

  level.rescue_heli notify("weapons_free");

  playFXOnTag(level._effect["alien_heli_spotlight"], level.rescue_heli, "tag_flash");

  level.rescue_heli heli_loop(player_loops, false, ::get_player_loop_center, "fly_to_extraction");

  level.rescue_heli thread maps\mp\alien\_music_and_dialog::play_pilot_vo("so_alien_plt_exfil");

  level.rescue_heli notify("stop_turret");

  stopFXOnTag(level._effect["alien_heli_spotlight"], level.rescue_heli, "tag_flash");

  level.rescue_heli heli_fly_to(raised_drop_loc, CONST_HELI_LOOP_SPEED);
  thread sfx_rescue_heli_flyin(level.rescue_heli);
  level.rescue_heli heli_fly_to(drop_loc, CONST_HELI_LOOP_SPEED);

  level.rescue_heli notify("in_position");
  level.rescue_heli setgoalyaw(drop_angles[1]);

  level.rescue_heli thread heli_turret_think();
  wait 0.05;
  level.rescue_heli notify("weapons_free");
  playFXOnTag(level._effect["alien_heli_spotlight"], level.rescue_heli, "tag_flash");
}

hide_doors() {
  self HidePart("door_l");
  self HidePart("door_l_handle");
  self HidePart("door_l_lock");
  self HidePart("door_r");
  self HidePart("door_r_handle");
  self HidePart("door_r_lock");
}

call_in_attack_heli(player_loops, reward_pool) {
  level endon("game_ended");

  level.heli_fly_height = CONST_HELI_FLY_HEIGHT_LOW;
  level.heli_loop_radius = CONST_HELI_LOOP_RADIUS;

  CoM = get_center_of_players();

  raised_CoM = CoM + (0, 0, level.heli_fly_height);
  scaled_goal_vec = level.heli_loop_radius * (0, 1, 0);
  scaled_start_vec = CONST_HELI_START_DIST * (0, 1, 0);

  path_goal_pos = raised_CoM + scaled_goal_vec;
  path_start_pos = raised_CoM + scaled_start_vec;

  level.attack_heli = heli_setup(level.players[0], path_start_pos, path_goal_pos);

  level.attack_heli endon("convert_to_hive_heli");

  level.attack_heli thread heli_turret_think();
  level.attack_heli thread heli_fx_setup();

  if(isDefined(reward_pool)) {
    level.attack_heli.reward_pool = reward_pool;
  }

  level.attack_heli heli_fly_to(path_goal_pos, CONST_HELI_FLY_IN_SPEED);
  level.attack_heli maps\mp\alien\_music_and_dialog::playVOforAttackChopperIncoming();

  wait 1;

  level.attack_heli notify("weapons_free");

  playFXOnTag(level._effect["alien_heli_spotlight"], level.attack_heli, "tag_flash");

  level.attack_heli heli_loop(player_loops, false, ::get_player_loop_center, undefined, 28);

  stopFXOnTag(level._effect["alien_heli_spotlight"], level.attack_heli, "tag_flash");

  level.attack_heli thread heli_exit(path_start_pos);
}

CONST_HIVE_HELI_HP_INVADE = 350;
CONST_HIVE_HELI_HP = 500;
CONST_HIVE_HELI_HP_HIGH = 1000;
CONST_HIVE_HELI_COLL_SPHERE_RADIUS = 192;

CHOPPER_STATE_AWAY = 0;
CHOPPER_STATE_EVADING = 1;
CHOPPER_STATE_ATTACKING = 2;
CHOPPER_STATE_INCOMING = 3;

call_in_hive_heli(primary_target) {
  level endon("game_ended");

  flag_init("evade");

  reward_drop_loc = primary_target.origin;

  level.heli_fly_height = CONST_HELI_FLY_HEIGHT_HIGH;
  level.heli_loop_radius = CONST_HELI_LOOP_RADIUS;

  CoM = get_center_of_players();

  raised_CoM = CoM + (0, 0, CONST_HELI_FLY_HEIGHT_LOW);
  scaled_goal_vec = level.heli_loop_radius * (0, 1, 0);
  scaled_start_vec = CONST_HELI_START_DIST * (0, 1, 0);

  path_goal_pos = raised_CoM + scaled_goal_vec;
  path_start_pos = raised_CoM + scaled_start_vec;
  fly_in_speed = CONST_HELI_FLY_IN_SPEED;

  if(isDefined(level.attack_heli)) {
    level.attack_heli notify("convert_to_hive_heli");
    stopFXOnTag(level._effect["alien_heli_spotlight"], level.attack_heli, "tag_flash");

    fly_in_speed = 40;

    wait 0.5;
    level.hive_heli = level.attack_heli;
  } else {
    level.hive_heli = heli_setup(level.players[0], path_start_pos, path_goal_pos);
    level.hive_heli MakeVehicleSolidSphere(CONST_HIVE_HELI_COLL_SPHERE_RADIUS);
    level.hive_heli thread heli_fx_setup();
  }

  if(level.hive_heli ent_flag_exist("assault_ready")) {
    level.hive_heli ent_flag_clear("assault_ready");
  } else {
    level.hive_heli ent_flag_init("assault_ready");
  }

  level.hive_heli SetHoverParams(60, 30, 20);
  level.hive_heli SetYawSpeed(50, 50);

  level.hive_heli.no_gas_cloud_attack = true;

  level.hive_heli.health = 5000000;
  level.hive_heli.maxhealth = 5000000;
  level.hive_heli.evasive_damage = CONST_HIVE_HELI_HP_INVADE;
  level.hive_heli setCanDamage(true);
  level.hive_heli thread heli_hp_monitor();

  level.hive_heli MakeEntitySentient("allies");
  level.hive_heli SetThreatBiasGroup("hive_heli");

  level.hive_heli.damageCallback = ::Callback_VehicleDamage;

  level.hive_heli thread maps\mp\alien\_hud::blocker_hive_chopper_hp_bar();
  attractor = Missile_CreateAttractorEnt(level.hive_heli, 1000, 8000);

  level.hive_heli heli_fly_to(path_goal_pos, fly_in_speed);

  playFXOnTag(level._effect["alien_heli_spotlight"], level.hive_heli, "tag_flash");

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    time = RandomFloatRange(2.5, 4);
    while(time >= 0 && isDefined(player) && isalive(player)) {
      level.hive_heli setTurretTargetVec(player.origin);
      time -= 0.05;
      wait 0.05;
    }
  }

  level.hive_heli ent_flag_set("assault_ready");

  level.hive_heli thread heli_turret_think(primary_target, 3);

  level.hive_heli notify("weapons_free");

  level.hive_heli thread face_hive(primary_target);

  level.hive_heli hive_heli_assault_loop();

  if(flag("evade")) {
    flag_clear("evade");

    playFXOnTag(level._effect["alien_heli_spotlight"], level.hive_heli, "tag_flash");
  }

  level.hive_heli clearLookAtEnt();

  if(level.hive_heli.health < 1) {} else {
    level.hive_heli maps\mp\alien\_music_and_dialog::playVOForBlockerHiveReward();
    level.hive_heli heli_fly_to(reward_drop_loc + (0, 0, 600), 20);
    thread spawn_hive_heli_reward(reward_drop_loc);
    level.hive_heli heli_fly_to(reward_drop_loc + (0, 0, 1200), 20);
  }

  level.hive_heli heli_loop(2, false, ::get_player_loop_center, "alien_cycle_started", 28);

  stopFXOnTag(level._effect["alien_heli_spotlight"], level.hive_heli, "tag_flash");

  level.hive_heli thread heli_exit(path_start_pos);

  wait(3);
  level.hive_heli maps\mp\alien\_music_and_dialog::PlayVOForAttackChopperLeaving();
}

hive_heli_assault_loop() {
  self endon("death");
  level endon("blocker_hive_destroyed");

  hover_nodes = [];
  hover_nodes = getstructarray("assault_hover_" + maps\mp\alien\_hive::get_blocker_hive_index(), "targetname");
  assert(isDefined(hover_nodes) && hover_nodes.size);

  assault_duration_per_node = 10;
  counter = 0;
  while(1) {
    SetThreatBias("hive_heli", "spitters", 10000);

    if(counter < 4) {
      counter++;
      random_hover_loc = hover_nodes[randomint(hover_nodes.size)].origin;
      self heli_fly_to(random_hover_loc, 20);
    } else {
      counter = 0;
      self heli_loop(1, false, ::get_assault_loop_loc, "blocker_hive_destroyed", 35);

      if(!flag("evade")) {
        continue;
      }
    }

    if(!flag("evade")) {
      self waittill_any_timeout(assault_duration_per_node, "evade");
    }

    if(flag("evade")) {
      SetIgnoreMeGroup("hive_heli", "spitters");

      stopFXOnTag(level._effect["alien_heli_spotlight"], level.hive_heli, "tag_flash");

      if(!is_hardcore_mode()) {
        self heli_loop(4, false, ::get_assault_loop_loc, "blocker_hive_destroyed", 35);
      } else {
        self heli_loop(6, false, ::get_assault_loop_loc, "blocker_hive_destroyed", 35);
      }

      flag_clear("evade");

      playFXOnTag(level._effect["alien_heli_spotlight"], level.hive_heli, "tag_flash");
    }

    wait 0.05;
  }
}

heli_hp_monitor() {
  level endon("blocker_hive_destroyed");
  self endon("death");
  level endon("game_ended");

  cur_hp = self.health;
  delta = 0;
  hit_count = 0;
  damage_vo_played = false;
  while(1) {
    delta += (cur_hp - self.health);

    if(self.health != cur_hp) {
      damage_taken = cur_hp - self.health;
      maps\mp\alien\_alien_matchdata::inc_drill_heli_damages(damage_taken);

      cur_hp = self.health;
      hit_count++;

      if(hit_count >= 4) {
        self maps\mp\alien\_music_and_dialog::playVOForChopperTakingDamage();
        hit_count = 0;
        self notify("evade");
        wait 2;
      }
    }

    if(delta >= self.evasive_damage) {
      self maps\mp\alien\_music_and_dialog::playVOForChopperTakingTooMuchDamage();

      delta = 0;
      flag_set("evade");
      self notify("evade");
      self notify("new_flight_path");
    }

    if(flag("evade")) {
      flag_waitopen("evade");
    }

    wait 0.5;
  }
}

face_hive(primary_target) {
  level endon("blocker_hive_destroyed");
  self endon("death");
  level endon("game_ended");

  wait 3;

  while(isDefined(primary_target) && isDefined(self)) {
    if(!flag("evade")) {
      face_vec = primary_target.origin - self.origin;
      face_angle = VectorToAngles(face_vec);

      self SetLookAtEnt(primary_target);

    } else {
      self clearLookAtEnt();
    }

    wait 1;
  }
}

get_assault_loop_loc() {
  assert(isDefined(level.cycle_count));

  loop_struct_name = "assault_loop_" + maps\mp\alien\_hive::get_blocker_hive_index();
  loop_struct = getstruct(loop_struct_name, "targetname");

  if(flag_exist("evade") && flag("evade")) {
    return loop_struct.origin + (0, 0, 600);
  } else {
    return loop_struct.origin;
  }
}

spawn_hive_heli_reward(loc) {
  level endon("game_ended");
  level endon("new_chaos_airdrop");

  loc = drop_to_ground(loc, DROP_TO_GROUND_UP_DIST, DROP_TO_GROUND_DOWN_DIST);

  if(maps\mp\alien\_hive::get_blocker_hive_index() == 1) {
    boxType = "deployable_currency";
    boxUpgrade = 1;
  } else {
    boxType = "deployable_currency";
    boxUpgrade = 2;
  }

  player = level.players[randomint(level.players.size)];
  player.team_currency_rank = boxUpgrade;

  box = maps\mp\alien\_deployablebox::createBoxForPlayer(boxType, loc, player);
  box.upgrade_rank = boxUpgrade;
  box.air_dropped = true;
  wait 0.05;

  box thread maps\mp\alien\_deployablebox::box_setActive(true);
}

face_players() {
  self endon("extract");
  level endon("game_ended");

  while(1) {
    CoM = get_center_of_players();
    face_vec = CoM - self.origin;
    face_angle = VectorToAngles(face_vec);

    self setgoalyaw(face_angle[1]);
    wait 1;
  }
}

heli_exit(exit_loc, no_delete) {
  self notify("new_flight_path");

  self notify("heli_exiting");
  self endon("heli_exiting");
  self endon("convert_to_hive_heli");

  wait 0.05;

  self notify("stop_turret");

  self heli_fly_to(exit_loc, CONST_HELI_FLY_OUT_SPEED);

  if(!isDefined(no_delete) || !no_delete) {
    self delete();
  }
}

heli_setup(owner, path_start_pos, path_goal_pos) {
  forward = vectorToAngles(path_goal_pos - path_start_pos);
  heli = SpawnHelicopter(owner, path_start_pos, forward, "nh90_alien", "vehicle_nh90_interior2");

  if(!isDefined(heli)) {
    return;
  }
  heli.health = 999999;
  heli.maxhealth = 500;
  heli.damageTaken = 0;
  heli.team = "allies";
  heli setCanDamage(false);
  heli SetYawSpeed(80, 60);
  heli SetMaxPitchRoll(30, 30);
  heli SetHoverParams(10, 10, 60);
  heli setVehWeapon("cobra_20mm_alien");
  heli.fire_time = weaponFireTime("cobra_20mm_alien");

  return heli;
}

heli_fx_setup() {
  playFXOnTag(level._effect["cockpit_blue_cargo01"], self, "tag_light_cargo01");
  playFXOnTag(level._effect["cockpit_blue_cockpit01"], self, "tag_light_cockpit01");

  wait 0.05;
  playFXOnTag(level._effect["white_blink"], self, "tag_light_belly");
  playFXOnTag(level._effect["white_blink_tail"], self, "tag_light_tail");

  wait 0.05;
  playFXOnTag(level._effect["wingtip_green"], self, "tag_light_L_wing");
  playFXOnTag(level._effect["wingtip_red"], self, "tag_light_R_wing");
}

heli_turret_think(favorite_target, favorite_target_bias) {
  level endon("game_ended");
  self endon("death");
  self endon("stop_turret");
  self endon("convert_to_hive_heli");

  self waittill("weapons_free");

  while(isDefined(self) && isalive(self)) {
    primary_target = self get_primary_target(favorite_target, favorite_target_bias);
    if(!isDefined(primary_target) || !isalive(primary_target)) {
      SetOmnvar("ui_alien_chopper_state", CHOPPER_STATE_AWAY);
      wait 1;
      continue;
    }

    if(flag_exist("evade") && flag("evade")) {
      SetOmnvar("ui_alien_chopper_state", CHOPPER_STATE_EVADING);
      wait 1;
      continue;
    }

    self setTurretTargetVec(primary_target.origin + (0, 0, 16));
    self waittill_notify_or_timeout("turret_on_target", 4);

    if(isDefined(primary_target) && isDefined(favorite_target) && primary_target == favorite_target) {
      SetOmnvar("ui_alien_chopper_state", CHOPPER_STATE_ATTACKING);
      SetOmnvar("ui_alien_boss_status", 2);
    }

    clip_size = 30 + (RandomIntRange(0, 20) - 5);
    for(i = 0; i < clip_size; i++) {
      if(!isDefined(primary_target) || !isalive(primary_target)) {
        break;
      }

      noise = (0, 0, 16);
      self setTurretTargetVec(primary_target.origin + noise);
      self fireWeapon("tag_flash", primary_target, (0, 0, 0));
      wait self.fire_time;
    }

    wait RandomFloatRange(1, 3.5);
  }
}

get_primary_target(favorite_target, favorite_target_bias) {
  targets = [];
  foreach(agent in level.agentArray) {
    if(!isDefined(agent.allowVehicleDamage)) {
      agent.allowVehicleDamage = true;
    }

    if(agent.team != "axis") {
      continue;
    }
    if(!isalive(agent)) {
      continue;
    }
    if(Distance(agent.origin, self.origin) > CONST_HELI_TARGETING_RANGE) {
      continue;
    }
    alive_time = gettime() - agent.birthtime;
    if(alive_time < 4000) {
      continue;
    }
    targets[targets.size] = agent;
  }

  if(targets.size > 0) {
    targets = SortByDistance(targets, self.origin);

    if(isDefined(favorite_target)) {
      assertex(isDefined(favorite_target_bias), "favorite target bias not defined when favorite target is");

      dist_to_alien = Distance(targets[0].origin, self.origin);
      dist_favorite_target = Distance(favorite_target.origin, self.origin);

      if(dist_to_alien >= dist_favorite_target / favorite_target_bias) {
        return favorite_target;
      }
    }

    return targets[0];
  } else {
    if(isDefined(favorite_target)) {
      return favorite_target;
    }

    return undefined;
  }
}

heli_fly_to(path_goal_pos, speed, endon_msg) {
  self notify("new_flight_path");
  self endon("new_flight_path");
  self endon("convert_to_hive_heli");

  if(isDefined(endon_msg)) {
    level endon(endon_msg);
  }

  self Vehicle_SetSpeed(speed, speed * 0.75, speed * 0.75);
  self setVehGoalPos(path_goal_pos, 1);

  debug_line(self.origin, path_goal_pos, (0, 0.5, 1), 200);

  if(isDefined(self.near_goal) && self.near_goal) {
    self waittill("near_goal");
  } else {
    self waittill("goal");
  }
}

heli_loop(loop_num, counter_clockwise, loop_center_func, self_endon_msg, loop_speed_override) {
  self notify("new_flight_path");
  self endon("new_flight_path");
  self endon("death");
  self endon("convert_to_hive_heli");

  if(isDefined(self_endon_msg)) {
    level endon(self_endon_msg);
    self endon(self_endon_msg);
  }

  angular_interval = 12;
  if(isDefined(counter_clockwise) && counter_clockwise) {
    angular_interval *= -1;
  }

  angular_shift = 0;
  radius_vec = (0, level.heli_loop_radius, 0);

  loop_speed = CONST_HELI_LOOP_SPEED;
  if(isDefined(loop_speed_override)) {
    loop_speed = loop_speed_override;
  }

  last_goal = self.origin;
  next_goal_pos = last_goal;
  loop_center = [[loop_center_func]]();
  while(loop_num > 0 && self.health > 0) {
    rotated_vec = RotateVector(radius_vec, (0, angular_shift, 0));
    angular_shift += angular_interval;
    if(angular_shift >= 360) {
      loop_center = [
        [loop_center_func]
      ]();
      angular_shift = 0;
      loop_num--;
    }

    last_goal = next_goal_pos;
    next_goal_pos = loop_center + rotated_vec;

    self Vehicle_SetSpeed(loop_speed, loop_speed, loop_speed);
    self setVehGoalPos(next_goal_pos, 0);

    debug_line(last_goal, next_goal_pos, (0, 0.5, 1), 100);

    next_goal_dist = abs(level.heli_loop_radius * sin(angular_interval));
    travel_time = get_travel_time(next_goal_dist, loop_speed);

    look_ahead_frac = 0.1;
    wait(travel_time * (1 - look_ahead_frac));
  }
}

get_drop_loop_center() {
  return self.drop_loc + (0, 0, level.heli_fly_height);
}

get_drop_loop_crater() {
  return (-10251, 6937, (level.heli_fly_height + 400));
}

get_player_loop_center() {
  CoM = get_center_of_players();
  return CoM + (0, 0, level.heli_fly_height);
}

get_travel_time(dist, speed) {
  speed_inch_per_sec = speed * 17.6;
  travel_time = dist / speed_inch_per_sec;

  return travel_time;
}

debug_line(from, to, color, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0 && !isDefined(frames)) {
    thread draw_line(from, to, color);
  } else if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(from, to, color, frames);
}

draw_line(from, to, color, frames) {
  if(isDefined(frames)) {
    for(i = 0; i < frames; i++) {
      line(from, to, color);
      wait 0.05;
    }
  } else {
    for(;;) {
      line(from, to, color);
      wait 0.05;
    }
  }
}

is_weight_a_less_than_b(loc_a, loc_b) {
  return (loc_a.weight < loc_b.weight);
}

get_center_of_players(height_offset) {
  if(!isDefined(height_offset)) {
    height_offset = 0;
  }

  x = 0;
  y = 0;
  z = 0;
  foreach(player in level.players) {
    x += player.origin[0];
    y += player.origin[1];
    z += player.origin[2] + height_offset;
  }

  player_count = max(1, level.players.size);
  CoM = (x / player_count, y / player_count, z / player_count);

  return CoM;
}

register_sub_item(item, upgrade_rank, drop_chance) {
  if(!isDefined(level.chaos_sub_items)) {
    level.chaos_sub_items = [];
  }

  if(!isDefined(drop_chance)) {
    drop_chance = 1;
  }

  for(i = 0; i < drop_chance; i++) {
    index = level.chaos_sub_items.size;
    level.chaos_sub_items[index] = [];
    level.chaos_sub_items[index][0] = item;
    level.chaos_sub_items[index][1] = upgrade_rank;
  }
}

get_random_airdrop_sub_item() {
  return level.chaos_sub_items[randomint(level.chaos_sub_items.size)];
}

Callback_VehicleDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  if(!isPlayer(attacker) && isDefined(attacker.owner) && isPlayer(attacker.owner)) {
    attacker = attacker.owner;
  }

  if((attacker == self || (isDefined(attacker.pers) && attacker.pers["team"] == self.team) && level.teamBased)) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.evasive_damage) && (self.health - damage) <= self.evasive_damage && (!isDefined(self.smoking) || !self.smoking)) {
    self thread playDamageEfx();
    self.smoking = true;
  }

  self Vehicle_FinishDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
}

playDamageEfx() {
  self endon("death");

  wait(0.15);

  playFXOnTag(level._effect["harrier_heavy_smoke"], self, "tag_engine_left");
}

airdrop_reward() {
  if(!isDefined(level.chaos_airdrop_locs) || level.chaos_airdrop_locs.size == 0) {
    return;
  }
  level notify("new_chaos_airdrop");
  airdrop_loc_struct = get_chaos_airdrop_loc();

  thread start_supply_drop_sequence(airdrop_loc_struct.sub_locs[0]);
  thread spawn_random_airdrop_sub_items(airdrop_loc_struct.sub_locs);

  airdrop_loc_struct.weight++;
}

set_chaos_airdrop_icon(loc, delete_delay) {
  level endon("game_ended");
  level endon("new_chaos_airdrop");

  if(isDefined(level.airdrop_icon)) {
    level.airdrop_icon destroy();
  }

  level.airdrop_icon = NewHudElem();

  level.airdrop_icon SetShader("waypoint_ammo", 14, 14);
  level.airdrop_icon.alpha = 1;
  level.airdrop_icon.color = (1, 1, 1);
  level.airdrop_icon SetWayPoint(true, true);
  level.airdrop_icon.x = loc[0];
  level.airdrop_icon.y = loc[1];
  level.airdrop_icon.z = loc[2];

  wait delete_delay;

  if(isDefined(level.airdrop_icon)) {
    level.airdrop_icon destroy();
  }
}

get_chaos_airdrop_loc() {
  min_dist = 3000;

  CoM = get_center_of_players();
  airdrop_locs = level.chaos_airdrop_locs;
  assertex(isDefined(airdrop_locs) && airdrop_locs.size > 0, "Did not find an airdrop loc...");

  airdrop_locs = SortByDistance(airdrop_locs, CoM);
  airdrop_locs_at_range = [];
  foreach(loc in airdrop_locs) {
    if(distance(loc.origin, CoM) > min_dist) {
      airdrop_locs_at_range[airdrop_locs_at_range.size] = loc;
    }
  }

  assertex(airdrop_locs_at_range.size, "Did not find an airdrop loc at range...");

  sample_loc_size = 4;
  airdrop_locs_clipped = [];
  for(i = 0; i < 4; i++) {
    if(!isDefined(airdrop_locs_at_range[i])) {
      break;
    }

    airdrop_locs_clipped[i] = airdrop_locs_at_range[i];
  }

  assertex(airdrop_locs_clipped.size, "Did not find airdrop locs at range clipped...");

  airdrop_locs_weighted = array_sort_with_func(airdrop_locs_clipped, ::is_weight_a_less_than_b);
  assertex(isDefined(airdrop_locs_weighted[0]), "Did not find a weighted airdrop loc...");

  return airdrop_locs_weighted[0];
}

start_supply_drop_sequence(loc) {
  level endon("game_ended");
  level endon("new_chaos_airdrop");

  call_in_airdrop_heli(loc, 3, 3);
  wait 2;

  level notify("chaos_airdrop_landed");
}

spawn_random_airdrop_sub_items(array_locs) {
  level endon("game_ended");
  level endon("new_chaos_airdrop");
  level waittill("chaos_airdrop_landed");

  counter = 0;
  foreach(loc in array_locs) {
    if(counter >= level.chaos_sub_items.size) {
      counter = 0;
    }

    boxType = level.chaos_sub_items[counter][0];
    boxUpgrade = level.chaos_sub_items[counter][1];

    player = level.players[randomint(level.players.size)];
    player.team_currency_rank = boxUpgrade;

    if(boxType == "deployable_currency") {
      loc += (0, 0, 16);
    }

    box = maps\mp\killstreaks\_deployablebox::createBoxForPlayer(boxType, loc, player);
    box.upgrade_rank = boxUpgrade;
    box.air_dropped = true;

    wait 0.05;

    box thread maps\mp\killstreaks\_deployablebox::box_setActive(true);

    counter++;
  }
}

call_in_airdrop_heli(drop_loc, player_loops, drop_loops) {
  level endon("game_ended");

  level.heli_fly_height = CONST_HELI_FLY_HEIGHT;
  level.heli_loop_radius = CONST_HELI_LOOP_RADIUS;

  CoM = get_center_of_players();

  raised_CoM = CoM + (0, 0, level.heli_fly_height);
  raised_drop_loc = drop_loc + (0, 0, level.heli_fly_height);

  scaled_goal_vec = level.heli_loop_radius * (0, 1, 0);
  scaled_start_vec = CONST_HELI_START_DIST * (0, 1, 0);

  path_goal_pos = raised_CoM + scaled_goal_vec;
  path_start_pos = raised_CoM + scaled_start_vec;

  level.airdrop_heli = heli_setup(level.players[0], path_start_pos, path_goal_pos);
  level.airdrop_heli thread heli_turret_think();
  level.airdrop_heli thread heli_fx_setup();

  level.airdrop_heli.drop_loc = drop_loc;

  level.airdrop_heli heli_fly_to(path_goal_pos, CONST_HELI_FLY_IN_SPEED);

  wait 1;

  level.airdrop_heli notify("weapons_free");

  level.airdrop_heli heli_loop(player_loops, false, ::get_player_loop_center);

  level.airdrop_heli heli_loop(drop_loops, false, ::get_drop_loop_center);

  level.airdrop_heli heli_fly_to(raised_drop_loc, CONST_HELI_LOOP_SPEED);

  lowered_drop_loc = drop_loc + (0, 0, 450);
  level.airdrop_heli heli_fly_to(lowered_drop_loc, CONST_HELI_LOOP_SPEED);

  level.airdrop_heli thread heli_exit(path_start_pos);
}

init_chaos_airdrop() {
  level.chaos_airdrop_locs = getstructarray("chaos_airdrop", "targetname");
  if(!isDefined(level.chaos_airdrop_locs) || level.chaos_airdrop_locs.size == 0) {
    return;
  }
  foreach(loc in level.chaos_airdrop_locs) {
    loc.sub_locs = [];
    loc.sub_locs[0] = loc.origin;
    sub_locs = getstructarray(loc.target, "targetname");
    foreach(sub_loc in sub_locs) {
      loc.sub_locs[loc.sub_locs.size] = sub_loc.origin;
    }

    loc.weight = 0;
  }

  register_airdrop_sub_items();

  /#	
  if(GetDvarInt("alien_supply_drop_debug") > 0) {
    thread test_supply_drop();
  }

  if(GetDvarInt("alien_heli_debug") > 0) {
    thread test_attack_heli();
  }

}

test_supply_drop() {
  level.heli_debug = true;

  wait 5;
  level thread airdrop_reward();
}

test_attack_heli() {
  level.heli_debug = true;

  wait 5;
  level thread call_in_attack_heli(10);
}

register_airdrop_sub_items() {
  register_sub_item("deployable_currency", 4, 1);
  register_sub_item("deployable_ammo", 4, 1);
}

sfx_rescue_heli_flyin(heli) {
  heli playSound("alien_heli_rescue_dz_flyin");

  wait 1;
  heli Vehicle_TurnEngineOff();
  wait 1.6;
  level.heli_lp = spawn("script_origin", heli.origin);
  level.heli_lp LinkTo(heli);
  level.heli_lp playLoopSound("alien_heli_rescue_dz_engine_lp");
}

sfx_rescue_heli_escape(heli) {
  level.player playSound("alien_heli_rescue_exfil_lr");
  wait 1;

  level.heli_lp StopLoopSound("alien_heli_rescue_dz_engine_lp");

  wait 5;
  level.heli_exfil_lp = spawn("script_origin", heli.origin);
  level.heli_exfil_lp LinkTo(heli);
  level.heli_exfil_lp playLoopSound("alien_heli_exfil_engine_lp");

  wait 18;
  level.heli_exfil_lp StopLoopSound("alien_heli_exfil_engine_lp");
}

inbound_chopper_text() {
  foreach(player in level.players) {
    player thread show_blocker_hive_hint_text(&"ALIENS_BLOCKER_HIVE_HINT");
    player thread show_drill_hint();
  }
}

show_blocker_hive_hint_text(hint) {
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.useBarText)) {
    wait(.1);
  }

  fontsize = 1.5;
  font = "objective";
  if(level.splitscreen) {
    fontsize = 1.2;
  }

  self.useBarText = self createPrimaryProgressBarText(0, -50, fontsize, font);
  self.useBarText SetText(hint);
  self.useBarText SetPulseFX(50, 5000, 800);

  wait(6);

  self.useBarText destroyElem();
  self.useBarText = undefined;
}

show_drill_hint() {
  self endon("disconnect");
  distance_check = 350 * 350;
  while(is_blocker_alive()) {
    if(isDefined(level.current_blocker_hive) && isDefined(level.drill_carrier) && level.drill_carrier == self) {
      if(DistanceSquared(self.origin, level.current_blocker_hive.origin) < distance_check && isDefined(level.drill_carrier) && level.drill_carrier == self) {
        self setLowerMessage("hive_drill_hint", &"ALIENS_BLOCKER_HIVE_DRILL_HINT");
      }

      while(is_blocker_alive() &&
        (DistanceSquared(self.origin, level.current_blocker_hive.origin) < distance_check && isDefined(level.drill_carrier) && level.drill_carrier == self)) {
        wait(.25);
      }
      self clearLowerMessage("hive_drill_hint");
    }
    wait .5;
  }
}

is_blocker_alive() {
  if(!flag_exist("blocker_hive_destroyed")) {
    return false;
  }

  return (!flag("blocker_hive_destroyed") && isDefined(level.current_blocker_hive));
}