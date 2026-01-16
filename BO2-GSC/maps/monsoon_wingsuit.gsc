/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_wingsuit.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_dialog;
#include maps\_music;
#include maps\monsoon_intro;
#include maps\_glasses;
#include maps\createart\monsoon_art;
#include maps\_audio;

skipto_suit_fly() {
  exploder(33);
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  level.harper thread maps\monsoon_intro::wingsuit_ai_setup("c_usa_seal6_ass_sqrl_haper_fb", level.harper.model);
  level.salazar thread maps\monsoon_intro::wingsuit_ai_setup("c_usa_seal6_ass_sqrl_salazar_fb", level.salazar.model);
  level.crosby thread maps\monsoon_intro::wingsuit_ai_setup("c_usa_seal6_assault_squirrel_fb", level.crosby.model);
  skipto_teleport_players("wingsuit_start_spot");
}

skipto_camo_intro() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport_players("player_skipto_camo_intro");
}

init_wingsuit_flags() {
  flag_init("player_flying_wingsuit");
  flag_init("jet_stream_launch_started");
  flag_init("wingsuit_landing_started");
  flag_init("wingsuit_player_landed");
  flag_init("predator_intro_started");
  flag_init("predator_ai_suit_on");
  flag_init("predator_intro_scene_done");
  flag_init("player_chute_deployed");
  flag_init("chute_window_passed");
  flag_init("jet_stream_launch_obj");
  flag_init("jet_stream_launch_obj_complete");
  flag_init("jet_stream_launch_complete");
  flag_init("input_lstick_detected");
  flag_init("input_trigs_detected");
}

wingsuit_main() {
  array_thread(getentarray("trigger_water_sheeting", "targetname"), ::trigger_water_sheeting_think);
  array_thread(getentarray("trigger_tree_top", "targetname"), ::trigger_tree_top_think);
  array_thread(getentarray("trigger_off_course", "targetname"), ::trigger_off_course_think);
  level.weather_wind_shake = 0;
  flag_set("player_flying_wingsuit");
  level.player setclientflag(7);
  level.player clearclientflag(6);
  level thread lerp_dvar("r_skyTransition", 1, 30, 1);
  jet_stream_launch();
  stop_exploder(33);
  level.player clearclientflag(7);
  level.player setclientflag(6);
  flag_clear("player_flying_wingsuit");
  level.weather_wind_shake = 1;
  array_delete(getentarray("wingsuit_ambient_trigger", "script_noteworthy"));
}

wingsuit_breadcrumb_objective() {
  level.player setclientdvar("cg_objectiveIndicatorFarFadeDist", 80000);
  s_crumb_pos = getstruct("squirrel_breadcrumb_start", "targetname");

  while(true) {
    n_radius = int(s_crumb_pos.script_noteworthy);
    set_objective(level.obj_wingsuit_land, s_crumb_pos.origin, "breadcrumb");
    luinotifyevent(&"hud_update_distance_obj", 3, int(s_crumb_pos.origin[0]), int(s_crumb_pos.origin[1]), int(s_crumb_pos.origin[2]));

    while(distance2d(level.player.origin, s_crumb_pos.origin) > n_radius)
      wait 0.05;

    if(isDefined(s_crumb_pos.target))
      s_crumb_pos = getstruct(s_crumb_pos.target, "targetname");
    else
      break;
  }

  if(flag("chute_window_passed"))
    set_objective(level.obj_wingsuit_land, undefined, "remove");
  else
    set_objective(level.obj_wingsuit_land, undefined, "done");
}

trigger_water_sheeting_think() {
  level endon("final_approach_started");

  while(true) {
    if(level.player istouching(self)) {
      level.player setwatersheeting(1, 2);
      return;
    }

    wait 0.05;
  }
}

trigger_tree_top_think() {
  level endon("final_approach_started");
  n_vo_index = 0;
  crash_vo[0] = "harp_easy_does_it_1";
  crash_vo[1] = "harp_watch_the_trees_1";
  crash_vo[2] = "harp_dammit_man_1";
  crash_vo[3] = "harp_i_ve_seen_thanksgivi_1";

  while(true) {
    self waittill("trigger");
    earthquake(2.0, 0.75, level.player.origin, 500, level.player);
    level.player playrumbleonentity("damage_heavy");
    level.player startfadingblur(3, 1);
    level.player playsound("fly_bump_foliage");
    wait(randomfloatrange(0.5, 0.8));

    if(n_vo_index < crash_vo.size) {
      level.harper thread say_dialog(crash_vo[n_vo_index]);
      n_vo_index++;
    }
  }
}

trigger_off_course_think() {
  level endon("wingsuit_player_landed");
  self waittill("trigger");
  level.harper thread say_dialog("harp_you_re_drifting_off_1");
  wait 0.4;
  missionfailedwrapper(&"MONSOON_FLIGHT_PATH");
}

jet_stream_launch() {
  level clientnotify("wng_st");
  playsoundatposition("evt_wingsuit_swoop", (0, 0, 0));
  flag_set("jet_stream_launch_obj_complete");
  level.player thread do_fall_feedback();
  level.player startcameratween(2);
  v_player_angles = level.player getplayerangles();
  level.player setplayerangles((70, 153, 0));
  level.player setplayerviewratescale(3);
  level thread wingsuit_squad_jump();
  wait 2.0;
  maps\_glasses::perform_visor_wipe(1);
  wait 0.5;
  level.player.vh_wingsuit notify("jet_stream_launch_start");
  flag_set("jet_stream_launch_complete");
  level.player resetplayerviewratescale();
  level.player.vh_wingsuit thread start_wingsuit("path_wingsuit_player_intro");
  level.player.vh_wingsuit thread wingsuit_fx();
  level thread wingsuit_breadcrumb_objective();
  wait_network_frame();
  level thread wingsuit_breadcrumb_objective();
  luinotifyevent(&"hud_update_vehicle_entity", 1, level.player.vh_wingsuit getentitynumber());
  flag_wait("wingsuit_landing_started");
  m_cliff_clip = getent("landing_clip", "targetname");
  m_cliff_clip notsolid();
  wait 0.3;
  level.harper thread say_dialog("harp_deploying_chute_0");
  level.player.vh_wingsuit setspeed(150, 10, 10);
  level.player wingsuit_deploy_chute();

  if(flag("chute_window_passed"))
    flag_waitopen("chute_window_passed");

  level.player.vh_wingsuit setspeed(50, 10, 10);
  trigger_wait("player_reached_cliff");
  level notify("player_started_landing");
  remove_visor_text("MONSOON_CHUTE_DEPLOYED");
  level.player.vh_wingsuit thread land_wingsuit("wingsuit_final_approach_start");
  m_cliff_clip solid();
}

wingsuit_squad_jump() {
  wait 0.2;
  run_scene("squad_dive");
  level.salazar thread spawn_wingsuit_and_drive_on_path("path_wingsuit_ai", 700, 400, (300, 50, 20));
  wait 0.05;
  level.harper thread spawn_wingsuit_and_drive_on_path("path_wingsuit_ai", 900, 400, (400, -50, 35));
}

wingsuit_deploy_chute() {
  level endon("chute_window_passed");
  screen_message_create(&"MONSOON_CHUTE_DEPLOY");
  self thread wingsuit_deploy_chute_fail();
  self waittill_use_button_pressed();
  screen_message_delete();
  level thread run_scene("deploy_chute");
  self notify("chute_deployed");
  flag_set("player_chute_deployed");
  self thread say_dialog("sect_deploying_chute_0");
  wait 0.5;
  add_visor_text("MONSOON_CHUTE_DEPLOYED", 0, "orange", "bright", 1);
  self playsound("evt_chute_deploy");
  self playrumbleonentity("artillery_rumble");
  earthquake(1, 0.5, self.origin, 500, self);
  self thread do_chute_feedback();
  chute_ent = spawn("script_origin", self.origin);
  chute_ent playloopsound("evt_chute_open");
  chute_ent thread delete_chute_ent();
}

delete_chute_ent() {
  level waittill("cut_chute");
  self delete();
}

wingsuit_deploy_chute_fail() {
  self endon("chute_deployed");
  wait 2;
  flag_set("chute_window_passed");
  screen_message_delete();
}

wingsuit_fx() {
  self endon("death");

  while(true) {
    playfxontag(level._effect["fx_water_wingsuit"], self, "tag_origin");
    wait 0.2;
  }
}

start_wingsuit(str_node) {
  v_player_vel = level.player getvelocity();
  self setvehvelocity(v_player_vel);
  v_player_angles = level.player getplayerangles();
  self setphysangles(v_player_angles);
  setheliheightpatchenabled("player_wingsuit_height_lock", 1);
  self setheliheightlock(1);
  self usevehicle(level.player, 0);
  level.player thread player_wingsuit_tutorial();
  setsaveddvar("vehPlaneConventionalFlight", "1");
  setsaveddvar("vehPlanePlayerAvoidance", "0");
  self setspeed(200, 1000, 1000);
  wait 0.05;
  level.player thread do_flight_feedback();
  wait 0.5;
  self thread wingsuit_collision_check();
  level thread cliff_clean_up();
}

cliff_clean_up() {
  veh_spawner = get_vehicle_spawner("vh_wingsuit_spawner");
  a_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_fxanim in a_fxanims) {
    if(distance2d(m_fxanim.origin, veh_spawner.origin) < 5000) {
      m_fxanim notify("fxanim_delete");
      m_fxanim delete();
    }
  }
}

land_wingsuit(str_node) {
  level notify("final_approach_started");
  level notify("cut_chute");
  level clientnotify("wg_st_dn");
  level.player freezecontrols(1);
  wait 0.05;
  level.player unlink();
  level.player setplayerangles(level.player.vh_wingsuit.angles);
  anchor = spawn("script_origin", level.player.origin);
  anchor.angles = (0, level.player.angles[1], level.player.angles[2]);
  anchor.targetname = "land_suit";
  self playsound("evt_chute_landing");
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.7, 0.5, level.player.origin, 245, level.player);
  run_scene("player_land_suit");
  level.player freezecontrols(0);
  trace_start = level.player.origin + vectorscale((0, 0, 1), 100.0);
  trace_end = level.player.origin + vectorscale((0, 0, -1), 100.0);
  player_trace = bullettrace(trace_start, trace_end, 0, level.player);
  level.player startcameratween(0.2);
  level.player setorigin(player_trace["position"]);
  level thread maps\createart\monsoon_art::exterior_vision();
  flag_set("wingsuit_player_landed");
  self delete();
  a_m_grass = getentarray("parachute_grass", "targetname");

  foreach(m_grass in a_m_grass)
  m_grass delete();

  m_chute = getent("fxanim_parachute", "targetname");
  m_chute show();
  setcellinvisibleatpos((15464, -36008, 22000));
}

player_wingsuit_tutorial() {
  self endon("death");
  stick_layout = getlocalprofileint("gpad_sticksConfig");
  force_legacy_message = 0;

  if(level.wiiu) {
    controller_type = level.player getcontrollertype();

    if(controller_type == "remote")
      force_legacy_message = 1;
  }

  if(stick_layout == 2 || stick_layout == 3 || force_legacy_message)
    screen_message_create(&"MONSOON_TUTORIAL_WINGSUIT_LEGACY");
  else
    screen_message_create(&"MONSOON_TUTORIAL_WINGSUIT");

  wait 5;
  screen_message_delete();

  if(!level.console && !self gamepadusedlast()) {
    screen_message_create(&"MONSOON_TUTORIAL_WINGSUIT_PC");
    wait 5;
    screen_message_delete();
  }
}

spawn_wingsuit_and_drive_on_path(str_node, n_ideal, n_min, v_offset) {
  self.vh_wingsuit = spawn_vehicle_from_targetname("vh_wingsuit_spawner");
  self.vh_wingsuit hide();
  self linkto(self.vh_wingsuit, "tag_driver");
  self thread do_flight_anims("fwd_idle");
  restore_ik_headtracking_limits();
  self.lookat_set_in_anim = 0;
  self lookatentity();
  self.vh_wingsuit thread ai_wingsuit_think(v_offset, 500, 250, vectorscale((1, 1, 1), 35.0), randomfloatrange(1.5, 2));

  if(self == level.harper)
    self.vh_wingsuit thread _wingsuit_ally_direct_vo();
}

_wingsuit_ally_direct_vo() {
  wait 23;
  level.harper say_dialog("harp_right_man_1");
  wait 6;
  level.harper say_dialog("harp_there_the_gap_in_t_1");
  wait 2;
  level.crosby thread say_dialog("cros_deploying_chute_0");
}

camo_intro_main() {
  set_rain_level(5);
  battlechatter_off("axis");
  ignore_squad(1);
  array_thread(get_heroes(), ::change_movemode, "cqb");
  level.harper hide();
  delay_thread(0.2, ::camo_intro_harper);
  flag_wait("wingsuit_player_landed");
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
  wait_network_frame();
  level.player player_enable_weapons();
  level.player setlowready(1);
  level thread camo_intro_squad();
  level thread camo_intro_landing_vo();
  delay_thread(5, ::autosave_by_name, "player_landed");
  getent("lz_patroller_2", "targetname") add_spawn_function(::camo_intro_camo_ai);
  trigger_wait("trigger_start_camo_intro");
  level thread camo_intro_threaded();
  trigger_use("camo_intro_squad_color");
  array_thread(get_heroes(), ::reset_movemode);
  t_lookat = getent("lookat_other_landing", "targetname");
  t_lookat delete();
  a_vh_wingsuits = getentarray("vh_wingsuit_spawner", "targetname");
  array_delete(a_vh_wingsuits);
}

camo_intro_landing_vo() {
  level endon("predator_intro_started");
  level.harper say_dialog("harp_you_good_1");
  wait 0.8;
  level.player say_dialog("sect_i_m_good_1");
  wait 0.5;
  level.player say_dialog("sect_salazar_crosby_y_1");
  wait 1;
  level.salazar say_dialog("sala_covered_ready_on_y_1");
}

camo_intro_squad() {
  level endon("predator_intro_started");
  nd_pos = getnode("crosby_landing", "targetname");
  level.crosby unlink();
  end_scene("crosby_fwd_idle");
  level.crosby forceteleport(nd_pos.origin, nd_pos.angles);
  level.crosby setgoalnode(nd_pos);
  level.crosby show();
  nd_pos = getnode("salazar_landing", "targetname");
  level.salazar unlink();
  end_scene("salazar_fwd_idle");
  level.salazar forceteleport(nd_pos.origin, nd_pos.angles);
  level.salazar setgoalnode(nd_pos);
  trigger_wait("lookat_other_landing");
  level.salazar setgoalnode(getnode("salazar_landing_goal", "targetname"));
  wait 2;
  level.crosby setgoalnode(getnode("crosby_landing_goal", "targetname"));
}

camo_intro_harper() {
  level endon("wingsuit_landing_done");
  level.harper unlink();
  s_pos = getstruct("harper_land_position", "targetname");
  level.harper unlink();
  end_scene("harper_fwd_idle");
  level.harper forceteleport(s_pos.origin, s_pos.angles);
  level.player thread player_walk_speed_adjustment(level.harper, "harper_in_position", 128, 256, 0.35, 0.65);
  level.player allowjump(0);
  level.harper show();
  level.harper force_goal(getnode("harper_landing_wait", "targetname"), 32);
  level notify("harper_in_position");
  level.harper lookatentity(level.player);
  set_objective(level.obj_reach_lab, getent("trigger_start_camo_intro", "targetname"), "breadcrumb");
}

camo_intro_camo_ai() {
  self toggle_camo_suit(1, 0);
  flag_wait("predator_ai_suit_on");
  self toggle_camo_suit(0);
}

camo_intro_threaded() {
  level notify("wingsuit_landing_done");
  setmusicstate("MONSOON_STEALTH");
  level.harper lookatentity();
  level.player allowjump(1);
  level thread run_scene("camo_intro_player");
  flag_wait("camo_intro_player_started");
  level thread run_scene("camo_intro_enemy_1");
  level thread run_scene("camo_intro_enemy_2");
  level thread run_scene("camo_intro_enemy_3");
  level thread run_scene("camo_intro_squad");
  wait 0.05;
  flag_set("predator_intro_started");
  wait 5;
  level.player setstance("prone");
  level thread maps\_audio::playsoundatposition_wait("mus_camo_stg", (0, 0, 0), 22);
  scene_wait("camo_intro_player");
  flag_set("predator_intro_scene_done");
  level.player allowstand(0);
  level.player allowcrouch(0);
  level.player setlowready(0);
  wait 0.5;
  level.player allowstand(1);
  level.player allowcrouch(1);
}

camo_intro_narrow_view(m_player_body) {
  level.player startcameratween(0.3);
  level.player playerlinktodelta(getent("player_body", "targetname"), "tag_player", 1, 0, 20, 30, 0);
}

ignore_squad(b_ignore) {
  level.harper set_ignoreall(b_ignore);
  level.salazar set_ignoreall(b_ignore);
  level.crosby set_ignoreall(b_ignore);
  level.harper set_ignoreme(b_ignore);
  level.salazar set_ignoreme(b_ignore);
  level.crosby set_ignoreme(b_ignore);
}

init_driveable_wingsuit() {
  vh_wingsuit = spawn_vehicle_from_targetname("vh_wingsuit_spawner", 0);
  vh_wingsuit.targetname = "player_wingsuit";
  vh_wingsuit hide();
  vh_wingsuit thread wingsuit_follow_player();
  return vh_wingsuit;
}

wingsuit_follow_player() {
  self endon("death");
  self endon("jet_stream_launch_start");

  while(true) {
    self.origin = level.player.origin + level.player getvelocity() * 0.1;
    self setphysangles((70, 153, 0));
    wait 0.05;
  }
}

wait_for_player_falling() {
  self endon("death");

  while(true) {
    if(self getvelocity()[2] < 0)
      return true;

    wait 0.05;
  }

  return false;
}

do_flight_anims(str_animtype) {
  self.vh_wingsuit.curr_flight_state = str_animtype;
  self.vh_wingsuit.next_flight_state = undefined;
  self thread run_scene(self.script_animname + "_" + self.vh_wingsuit.curr_flight_state);
  self._anim_blend_in_time = randomfloatrange(0.75, 1);

  while(!flag("wingsuit_landing_started")) {
    if(isDefined(self.vh_wingsuit.next_flight_state) && self.vh_wingsuit.curr_flight_state != self.vh_wingsuit.next_flight_state) {
      self.vh_wingsuit.curr_flight_state = self.vh_wingsuit.next_flight_state;
      self thread run_scene(self.script_animname + "_" + self.vh_wingsuit.curr_flight_state);
    }

    wait 0.1;
  }
}

wingsuit_collision_check() {
  level endon("player_chute_deployed");
  soundplayed = 0;

  while(!flag("wingsuit_landing_started")) {
    if(self getspeedmph() < 190) {
      level.player dodamage(1000, level.player.origin);

      if(soundplayed == 0) {
        playsoundatposition("evt_wingsuit_death", (0, 0, 0));
        soundplayed = 1;
      }

      screen_fade_out(0);
      missionfailedwrapper();
    }

    wait 0.05;
  }

  flag_wait("chute_window_passed");

  while(true) {
    if(self getspeedmph() < 140) {
      level.player dodamage(1000, level.player.origin);

      if(soundplayed == 0) {
        playsoundatposition("evt_wingsuit_death", (0, 0, 0));
        soundplayed = 1;
      }

      screen_fade_out(0);
      missionfailedwrapper();
    }

    wait 0.05;
  }
}

do_flight_feedback() {
  level endon("missionfailed");
  level endon("player_chute_deployed");
  self endon("death");
  rumble = 0.05;

  while(true) {
    rumble = rumble + 0.0075;

    if(rumble > 0.3)
      rumble = 0.3;

    self playrumbleonentity("tank_rumble");
    earthquake(0.15, 0.05, self.origin, 1000, self);
    wait 0.05;
  }
}

do_fall_feedback() {
  level endon("missionfailed");
  self endon("death");
  self endon("enter_vehicle");
  rumble = 0.05;

  while(true) {
    rumble = rumble + 0.0075;

    if(rumble > 0.3)
      rumble = 0.3;

    self playrumbleonentity("tank_rumble");
    earthquake(0.15, 0.05, self.origin, 1000, self);
    wait 0.05;
  }
}

do_chute_feedback() {
  level endon("missionfailed");
  level endon("player_started_landing");
  self endon("death");
  wait 0.3;
  rumble = 0.05;

  while(true) {
    rumble = rumble + 0.0075;

    if(rumble > 0.3)
      rumble = 0.3;

    self playrumbleonentity("damage_heavy");
    earthquake(0.25, 0.05, self.origin, 1000, self);
    wait 0.05;
  }
}

ai_wingsuit_think(v_offset, n_speed, n_acceleration, v_variable_offset, n_variable_offset_time) {
  self endon("death");
  self endon("mid_flight_restore");
  current_roll = 0;
  roll_track = randomfloatrange(3, 6);
  variable_offset_time = 0;
  last_variable_offset = (0, 0, 0);
  current_variable_offset = (0, 0, 0);
  target_variable_offset = (randomfloatrange(v_variable_offset[0] * -1, v_variable_offset[0]), randomfloatrange(v_variable_offset[1] * -1, v_variable_offset[1]), randomfloatrange(v_variable_offset[2] * -1, v_variable_offset[2]));
  v_angles = level.player.vh_wingsuit.angles;
  v_angles = (v_angles[0], v_angles[1], 0);
  v_fwd = anglestoforward(v_angles);
  v_right = anglestoright(v_angles);
  v_up = anglestoup(v_angles);
  v_desired_pos = level.player.vh_wingsuit.origin + (v_fwd * -250 + v_right * v_offset[1] + v_up * v_offset[2]);
  self.origin = v_desired_pos;
  wait 0.05;

  while(!flag("wingsuit_landing_started")) {
    v_angles = level.player.vh_wingsuit.angles;
    v_angles = (v_angles[0], v_angles[1], 0);
    v_fwd = anglestoforward(v_angles);
    v_right = anglestoright(v_angles);
    v_up = anglestoup(v_angles);
    v_desired_pos = level.player.vh_wingsuit.origin + (v_fwd * v_offset[0] + v_right * v_offset[1] + v_up * v_offset[2]);
    t = variable_offset_time / n_variable_offset_time;
    smooth_frac = 0.5 * (cos(3.14159 * t - 3.14159) + 1.0);
    current_variable_offset = lerpvector(last_variable_offset, target_variable_offset, t);
    variable_offset_time = variable_offset_time + 0.05;

    if(variable_offset_time > n_variable_offset_time) {
      variable_offset_time = 0;
      last_variable_offset = target_variable_offset;
      target_variable_offset = (randomfloatrange(v_variable_offset[0] * -1, v_variable_offset[0]), randomfloatrange(v_variable_offset[1] * -1, v_variable_offset[1]), randomfloatrange(v_variable_offset[2] * -1, v_variable_offset[2]));
    }

    v_desired_pos = v_desired_pos + (v_fwd * current_variable_offset[0] + v_right * current_variable_offset[1] + v_up * current_variable_offset[2]);
    v_delta = v_desired_pos - self.origin;
    v_desired_vel = v_delta / 0.05;
    desired_fwd_vel = vectordot(v_desired_vel, v_fwd);
    desired_right_vel = vectordot(v_desired_vel, v_right);
    desired_up_vel = vectordot(v_desired_vel, v_up);
    v_vel = self.velocity;
    curr_fwd_vel = vectordot(v_vel, v_fwd) / 17.6;
    curr_right_vel = vectordot(v_vel, v_right);
    curr_up_vel = vectordot(v_vel, v_up);
    a = desired_fwd_vel / 17.6;
    b = curr_right_vel / 17.6;
    c = curr_up_vel / 17.6;

    if(a > 207)
      a = 207;

    curr_fwd_vel = curr_fwd_vel + 100.0;

    if(curr_fwd_vel > a)
      curr_fwd_vel = a;

    x = curr_fwd_vel * 17.6;
    y = difftrack(desired_right_vel, curr_right_vel, 2, 0.05);
    z = difftrack(desired_up_vel, curr_up_vel, 25, 0.05);

    if(y > 10)
      self.next_flight_state = "turnleft_idle";
    else if(y < -10)
      self.next_flight_state = "turnright_idle";
    else
      self.next_flight_state = "fwd_idle";

    v_desired_vel = x * v_fwd + y * v_right + z * v_up;
    v = vectornormalize(v_desired_vel);
    d = vectordot(v, (0, 0, 1));

    if(d != 0 && abs(d) < 0.9)
      n_yaw = vectoangles(v_desired_vel);
    else
      n_yaw = v_angles[1];

    n_yaw_vel = (n_yaw - self.angles[1]) / 0.05;
    n_roll = n_yaw_vel / 25 * 75;
    n_roll = clamp(n_roll, -75, 75);
    current_roll = difftrackangle(n_roll * -1, current_roll, roll_track, 0.05);
    self setvehvelocity(v_desired_vel);
    self setphysangles((-5, n_yaw, current_roll));
    wait 0.05;
  }

  speed = length(self.velocity);

  while(speed > 0) {
    v_vel = self.velocity * 0.95;
    self setvehvelocity(v_vel);
    wait 0.05;
  }
}