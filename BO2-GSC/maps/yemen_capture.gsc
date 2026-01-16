/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_capture.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_objectives;
#include maps\yemen_utility;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\_music;
#include maps\_osprey;
#include maps\yemen_hijacked;
#include maps\createart\yemen_art;
#include maps\yemen_anim;

init_flags() {
  flag_init("capture_started");
  flag_init("menendez_surrenders");
  flag_init("obj_capture_sitrep");
  flag_init("obj_capture_menendez");
}

init_spawn_funcs() {
}

skipto_capture() {
  capture_skipto_setup();
  skipto_teleport("skipto_capture_player");
  switch_player_to_mason();
  exploder(30);
  level thread trigger_allie_sm();
}

skipto_outro_vtol() {
  load_gump("yemen_gump_outro");
  skipto_teleport("skipto_capture_player");
  switch_player_to_mason();
  exploder(30);
  flag_set("hijacked_bridge_fell");
  level thread skipto_outro_vtol_play_anim();
}

skipto_outro_vtol_play_anim() {
  while(true) {
    while(!level.player actionslotonebuttonpressed())
      wait 0.05;

    level thread run_scene("surrender_menendez");
    level thread run_scene("surrender_menendez_player");

    while(level.player actionslotonebuttonpressed())
      wait 0.05;
  }
}

main() {
  iprintln("Table for One");

  flag_wait("capture_started");
  clean_up_friendly_ai_quad();
  flag_set("obj_capture_sitrep");
  capture_setup();
  run_scene_first_frame("surrender_menendez_vtol");
  trigger_wait("mission_sucess_trigger");
  menendez_surrenders();
}

clean_up_friendly_ai_quad() {
  friendies = getaiarray("allies");

  foreach(friend in friendies) {
    if(friend == level.salazar) {
      continue;
    }
    if(!isDefined(friend.script_noteworthy) || friend.script_noteworthy != "capture_allies")
      friend thread ai_delete_when_offscreen();
  }
}

capture_skipto_setup() {
  flag_set("hijacked_bridge_fell");
  wait 1;
  flag_set("capture_started");
  flag_set("spawn_menendez_vtol");
  load_gump("yemen_gump_outskirts");
  level.salazar = init_hero_startstruct("sp_salazar", "skipto_capture_salazar");
  level thread outskirts_fall_death();
  level thread maps\yemen_hijacked::hijacked_bridge_swap();
}

capture_setup() {
  autosave_by_name("capture_start");
  stop_exploder(1040);
  exploder(1050);
  level.player set_ignoreme(0);
  maps\createart\yemen_art::end_start();
  level thread kill_friendly_quadrotors();
  level thread maps\yemen_anim::capture_anims();
}

kill_friendly_quadrotors() {
  level notify("stop_ally_quadrotor_respawn");
  a_vh_quads = get_alive_from_noteworthy("allied_quadrotor");
  enemies = getaiarray("axis");

  foreach(quad in a_vh_quads)
  quad notify("death", enemies[0]);

  wait(randomfloatrange(0.3, 0.5));
}

ally_quadrotors_fly_away() {
  level notify("stop_ally_quadrotor_respawn");
  a_vh_quads = get_alive_from_noteworthy("allied_quadrotor");
  goal_pos = getvehiclenode("ally_qrs_flyaway", "targetname");

  foreach(quad in a_vh_quads) {
    if(isDefined(quad))
      quad thread handle_quadrotor_flyaway(goal_pos);
  }
}

handle_quadrotor_flyaway(goal_pos) {
  self endon("death");
  self endon("delete");
  self clearturrettarget();
  self clearvehgoalpos();
  self set_goalradius(64);
  self qr_drones_move(goal_pos);
  self thread maps\yemen_hijacked::quadrotor_go_on_path("ally_qrs_flyaway");
}

waittill_goal_set_radius(radius) {
  self endon("death");
  self endon("delete");
  self waittill("goal");
  self set_goalradius(radius);
}

spawn_qdrotor_end_wave() {
  trigger_wait("end_battle_qdrotor_spawn");
  qdrotor_struct = getstruct("qdrotor_end_wave_radius", "targetname");

  for(i = 0; i < 2; i++) {
    qdrotor = spawn_vehicle_from_targetname("capture_battle_enemy_drone");
    qdrotor.goalpos = qdrotor_struct.origin;
    qdrotor.goalradius = 2000;
    wait 0.2;
  }
}

trigger_allie_sm() {
  trigger_wait("sm_capture_objective");
  spawn_manager_enable("capture_skipto_ally_sm");
}

outskirts_fall_death() {
  level endon("menendez_surrenders");
  trigger_wait("trig_outskirts_kill");
  fadehud = capture_get_fade_hud("white");
  fadehud capture_fadeout(1);
  level thread maps\_utility::missionfailedwrapper(&"YEMEN_FALL_DEATH");
}

capture_setup_animations() {
  level thread run_scene("carnage_b_wounded_01_loop_setup");
  wait 0.05;
  capture_start_animation_loops("a", 0, 4);
  capture_start_animation_loops("a", 5, 3);
  capture_start_animation_loops("b", 1, 1);
  capture_start_animation_loops("b", 3, 1);
  capture_start_animation_loops("b", 5, 5);
}

capture_start_animation_loops(char_group, n_start, n_count, b_has_gun) {
  for(i = 0; i < n_count; i++) {
    level thread run_scene("carnage_" + char_group + "_wounded_0" + string(n_start + i) + "_loop");
    wait 0.1;
  }
}

vtol_turret_attacks_target(e_target, n_delay, n_shoottime, v_target) {
  level endon("stop_vtol_turret");
  vh_vtol = getent("yemen_morals_rail_vtol_spawner", "targetname");

  if(isDefined(n_delay))
    wait(n_delay);

  vh_vtol _set_vtol_turret_target(e_target, v_target);
  vh_vtol _shoot_vtol_turret(n_shoottime);
  level notify("vtol_turret_done");
}

_set_vtol_turret_target(e_target, v_target) {
  self cleargunnertarget(0);

  if(isDefined(e_target))
    self setgunnertargetent(e_target, (0, 0, 0), 0);
  else
    self setgunnertargetvec(v_target, 0);
}

_shoot_vtol_turret(n_shoottime) {
  n_time = 0;
  n_firecount = 1;
  n_firetime = weaponfiretime("v78_player_minigun_gunner");

  while(n_time < n_shoottime) {
    self firegunnerweapon(0);
    n_firecount++;
    wait(n_firetime);
    n_time = n_time + n_firetime;
  }

  self cleargunnertarget(0);
}

waittill_radius(spot) {
  while(true) {
    n_dist = distance2d(level.player.origin, spot.origin);

    if(n_dist >= spot.radius) {
      break;
    }

    wait 0.05;
  }
}

player_phsych_thread() {
  level.player hide_hud();
  level thread capture_heartbeat_rumble();
}

menendez_surrenders() {
  flag_set("menendez_surrenders");
  setmusicstate("YEMEN_SNIPER");
  maps\createart\yemen_art::end_menendez();
  level.player notify("mission_finished");
  set_objective(level.obj_drone_control_bridge, undefined, "done");
  set_objective(level.obj_drone_control_bridge, undefined, "delete");
  level.salazar.animname = "end_salazar";
  run_scene_first_frame("surrender_menendez");
  run_scene_first_frame("surrender_menendez_player");
  level thread run_scene("surrender_menendez");
  level thread clean_up_left_over_ais_and_vehs();
  level thread run_scene("surrender_menendez_player");
  level thread run_scene("surrender_menendez_vtol");
  scene_wait("surrender_menendez_player");
  level thread run_scene("surrender_menendez_idle");
}

clean_up_left_over_ais_and_vehs() {
  spawn_manager_kill("end_battle");
  enemies = getaiarray("axis");

  foreach(enemy in enemies)
  enemy delete();

  enemy_veh = getvehiclearray("axis");

  foreach(veh in enemy_veh) {
    veh.delete_on_death = 1;
    veh notify("death");

    if(!isalive(veh))
      veh delete();
  }

  spawn_manager_enable("capture_end_ally_trigger");
  wait 1;
  friendlies = getaiarray("allies");
  menendez = get_model_or_models_from_scene("surrender_menendez", "capture_menendez");

  foreach(friend in friendlies)
  friend aim_at_target(menendez, 500);
}

capture_start_fadeout(unused_param) {
  fadehud = capture_get_fade_hud("black");
  fadehud capture_fadeout(0.25);
  wait 1;
  nextmission();
}

ready_weapon() {
  level.player showviewmodel();
  level.player enableweapons();
  level.player disableweaponfire();
  level.player setlowready(1);
}

give_me_a_gun(m_guy) {
  m_guy attach("t6_wpn_ar_xm8_world", "tag_weapon_right");
}

turret_attacks_runner(e_target) {
  vtol_turret_attacks_target(e_target, 3, 3);
}

capture_get_fade_hud(str_shader) {
  fadehud = newhudelem();
  fadehud.x = 0;
  fadehud.y = 0;
  fadehud.horzalign = "fullscreen";
  fadehud.vertalign = "fullscreen";
  fadehud.foreground = 0;
  fadehud setshader(str_shader, 640, 480);
  return fadehud;
}

capture_fadeout_and_in(n_alpha, n_fade) {
  self.alpha = 0;
  self fadeovertime(n_fade);
  self.alpha = n_alpha;
  self fadeovertime(n_fade);
  self.alpha = 0;
  self destroy();
}

capture_fadeout(n_fade) {
  self.alpha = 0;
  self fadeovertime(n_fade);
  self.alpha = 1;
}

capture_heartbeat_rumble() {
  level endon("menendez_surrenders");
  s_sniper_spot = getstruct("s_mendendez_spot", "targetname");

  while(true) {
    n_dot = capture_get_vector_dot(s_sniper_spot.origin);

    if(n_dot < 0.5) {
      level.player rumble_loop(1, 0.25, "heartbeat");
      fadehud = capture_get_fade_hud("white");
      fadehud thread capture_fadeout_and_in(0.5, 0.5);
      wait 1.4;
    } else {
      level.player rumble_loop(1, 0.25, "heartbeat_low");
      wait 2;
    }
  }
}

capture_get_vector_dot(v_pos) {
  n_dot = level.player get_dot_direction(v_pos, 1, 1, "backward", 1);
  return n_dot;
}

capture_spawn_fake_qrotors_at_structs_and_move(str_drone_pos, n_move_time) {
  a_drone_pos = getstructarray(str_drone_pos, "targetname");

  foreach(s_drone_pos in a_drone_pos) {
    m_drone = spawn("script_model", s_drone_pos.origin);
    m_drone setmodel("veh_t6_drone_quad_rotor_sp");
    s_drone_target = getstruct(s_drone_pos.target, "targetname");
    m_drone moveto(s_drone_target.origin, n_move_time);
    m_drone waittill("movedone");
    m_drone delete();
  }
}

vtol_firing_minigun() {
  trigger_wait("end_battle");
  wait 1;
  vtol = getent("yemen_morals_rail_vtol_spawner", "targetname");

  while(true) {
    vtol _set_vtol_turret_target(level.player);
    vtol _shoot_vtol_turret(5);
    wait(randomfloatrange(2, 4));
  }
}

debug_get_player_position() {
  while(true) {
    v_player_pos = level.player.origin;
    v_player_angles = level.player.angles;
    v_player_angles2 = level.player getplayerangles();
    v_player_eye = level.player geteye();
    wait 0.05;
  }
}

vo_capture() {
  level.player say_dialog("sala_section_he_ll_kill_0");
  level.player say_dialog("sala_all_units_confirm_ho_0");
}

vo_sitrep() {
  level notify("stop_vtol_turret");
}

vo_flashback() {
  level waittill("first_flashback");
  level.player say_dialog("mene_you_david_you_do_0");
  level waittill("second_flashback");
  level.player say_dialog("mene_like_woods_you_suff_0");
  level waittill("third_flashback");
}

capture_music() {
  setmusicstate("YEMEN_SNIPER");
  level waittill("menendez_surrenders");
  setmusicstate("YEMEN_SNIPER_END");
}

fearless_challenge(str_notify) {
  level endon("capture_not_fearless");
  flag_wait("capture_started");
  n_fearless_start = gettime();
  flag_wait("menendez_surrenders");

  if(gettime() < n_fearless_start + 25000)
    self notify(str_notify);
}