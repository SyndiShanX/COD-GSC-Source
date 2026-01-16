/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_hijacked.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\yemen_utility;
#include maps\_glasses;
#include maps\_vehicle;
#include maps\_osprey;
#include maps\_dialog;
#include maps\_music;
#include maps\yemen_capture;
#include maps\yemen_drone_control;
#include maps\_quadrotor;
#include maps\_fire_direction;
#include maps\_turret;

init_flags() {
  flag_init("obj_hijacked_sitrep");
  flag_init("hijacked_start");
  flag_init("hijacked_stairs_collapse");
  flag_init("hijacked_cliffside_building_destroyed");
  flag_init("hijacked_rpg_fired");
  flag_init("hijacked_bridge_fell");
  flag_init("hijacked_environmental");
  flag_init("menendez_hijack_vtol_active");
}

init_spawn_funcs() {
  add_spawn_function_group("hijacked_ally", "script_noteworthy", ::hijacked_allied_spawnfunc);
  add_spawn_function_veh("hijacked_robot", "script_noteworthy", ::hijacked_hostile_quadrotor_spawnfunc);
  add_spawn_function_veh("hijacked_bridge_robot", "script_noteworthy", ::hijacked_hostile_quadrotor_spawnfunc);
}

skipto_hijacked() {
  load_gump("yemen_gump_outskirts");
  skipto_teleport("s_hijacked_skipto_left_player");
  switch_player_to_mason();
  drone_control_setup();
  exploder(30);
  setmusicstate("YEMEN_MASON_KICKS_ASS");
  level.salazar = init_hero_startstruct("sp_salazar", "s_hijacked_skipto_left_salazar");
  level.salazar thread salazar_finish_level_color_trigger();
  level thread hijacked_skipto_setup();
}

skipto_hijacked_bridge() {
  skipto_teleport("skipto_capture_player");
  switch_player_to_mason();
  drone_control_setup();
  level.salazar = init_hero_startstruct("sp_salazar", "skipto_capture_salazar");
  exploder(30);
  load_gump("yemen_gump_outskirts");
  level thread maps\yemen_capture::outskirts_fall_death();
  flag_set("menendez_hijack_vtol_active");
}

skipto_hijacked_menendez() {
}

main() {
  iprintln("Event Name");

  flag_set("hijacked_start");
  flag_set("cleanup_farmhouse");
  menendez_hijack_scene_check();
  autosave_by_name("hijacked_start");
  hijacked_setup();
  level thread quadrotor_start_rockslide();
  level thread quadrotor_right_foreshadow();
  level thread quadrotor_left_foreshadow();
  level thread vo_hijacked();
  level thread quadrotor_enemies();
  level thread hijacked_bridge_event();
  level thread hijacked_drone_control_lost();
  level thread quadrotors_guard_bridge();
  level thread maps\yemen_drone_control::quadrotor_reinforce("menendez_surrenders", undefined, "nd_hijacked_drone_hit");
  level thread hijacked_bridge_approach_save();
  level waittill("swap_quadrotors");
  level thread stairs_shoot_stairs_building();
  level thread stairs_building_damage_listener();
  level thread cleanup_bridge_sm();
}

hijacked_setup() {
  level thread hijacked_crash_drone_near_player();
  hijacked_destructibles_setup();
  level thread hijacked_cleanup();
}

hijacked_hostile_quadrotor_spawnfunc() {
  self thread maps\_quadrotor::quadrotor_set_team("axis");
  self setthreatbiasgroup("quadrotors");
  self.goalradius = 450;
}

hijacked_hostile_player_quadrotor_spawnfunc() {
  self hijacked_hostile_quadrotor_spawnfunc();
}

hijacked_allied_spawnfunc() {
  self setthreatbiasgroup("allies");
  self magic_bullet_shield();
  flag_wait("drone_control_lost");
  self stop_magic_bullet_shield();
}

hijacked_threat_bias_control() {
  level endon("capture_started");
  salazar = getent("sp_salazar_ai", "targetname");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("player");
  createthreatbiasgroup("quadrotors");
  createthreatbiasgroup("axis");
  setthreatbias("allies", "quadrotors", 10000);
  setthreatbias("quadrotors", "allies", 10000);
  setthreatbias("player", "quadrotors", 10000);
  setthreatbias("player", "axis", 10000);
  level.player setthreatbiasgroup("player");
  salazar setthreatbiasgroup("player");
  level waittill("swap_quadrotors");
  setthreatbias("allies", "quadrotors", 10000);
  setthreatbias("quadrotors", "allies", 10000);
  setthreatbias("player", "quadrotors", -10000);
  setthreatbias("player", "axis", -10000);
}

hijacked_skipto_setup() {
  level.player maps\_fire_direction::init_fire_direction();
  hijacked_skipto_quadrotors_init();
  hijacked_skipto_salazar_init();
  level thread maps\yemen_drone_control::allied_quadrotor_control();
  level thread maps\yemen_drone_control::drone_control_quadrotor_sounds();
  level thread maps\yemen_capture::outskirts_fall_death();
}

hijacked_skipto_quadrotors_init() {
  maps\yemen_drone_control::drone_control_skipto_setup();
  maps\yemen_drone_control::setup_allied_quadrotors();
  a_vh_quadrotors = getentarray("allied_quadrotor", "targetname");

  foreach(vh_quadrotor in a_vh_quadrotors)
  vh_quadrotor.origin = level.player.origin + (randomintrange(34, 128), randomintrange(34, 128), randomintrange(34, 128));
}

hijacked_skipto_salazar_init() {
  ai_salazar = getent("sp_salazar_ai", "targetname");
  a_nd_salazar = getnodearray("nd_hijacked_start_colors", "targetname");
  nd_start = random(a_nd_salazar);
  ai_salazar thread force_goal(nd_start, 32, 0, undefined, 1);
}

allied_quadrotors_move_ahead_and_delete() {
  s_goal = getstruct("s_hijacked_hostile_qrotor_goal1");
  a_quadrotors = getentarray("allied_quadrotor", "targetname");

  foreach(vh_quadrotor in a_quadrotors)
  vh_quadrotor.goalpos = s_goal.origin;

  wait 15;
  array_delete(a_quadrotors);
}

hijacked_destructibles_setup() {
  a_m_bridge_destroyed_parts = getentarray("bridge_destroyed", "targetname");
  a_m_building_destroyed = getentarray("bridge_building_destroyed", "targetname");

  foreach(m_bridge_destroyed in a_m_bridge_destroyed_parts)
  m_bridge_destroyed hide();

  foreach(m_building_destroyed in a_m_building_destroyed)
  m_building_destroyed hide();
}

hijacked_setup_trees() {
  a_t_crash_trigs = getentarray("quadrotor_tree_crash_trig", "targetname");
  array_thread(a_t_crash_trigs, ::quadrotor_crash_tree_think);
}

hijacked_ambient_guys() {
  a_ambient_spawners = getentarray("ambient_guys_ai", "script_noteworthy");
  array_thread(a_ambient_spawners, ::hijacked_ambient_spawnfunc);
}

hijacked_bridge_guys() {
  a_ambient_spawners = getentarray("sp_hijacked_ally_capture", "targetname");
  array_thread(a_ambient_spawners, ::hijacked_ambient_spawnfunc);
}

hijacked_ambient_spawnfunc() {
  self magic_bullet_shield();
  self set_ignoreme(1);
}

hijacked_crash_drone_near_player() {
  v_qrotor = spawn_vehicle_from_targetname("yemen_quadrotor_spawner");
  wait 1;
  v_trace_to_point = level.player geteye() + vectornormalize(anglestoforward(level.player getplayerangles())) * 350;
  v_qrotor.origin = v_trace_to_point + vectorscale((0, 0, 1), 256.0);
  v_qrotor.goalpos = v_trace_to_point + vectorscale((0, 0, 1), 256.0);
  radiusdamage(v_qrotor.origin + vectorscale((0, 0, 1), 10.0), 32, v_qrotor.health + 10, v_qrotor.health + 10);
}

spawn_menendez_vtol() {
  flag_wait("spawn_menendez_vtol");
  veh_vtol = spawn_vehicle_from_targetname("yemen_morals_rail_vtol_spawner");
  nd_path = getvehiclenode("nd_capture_vtol_land_start", "targetname");
  veh_vtol setspeed(10);
  veh_vtol sethoverparams(1);
  veh_vtol veh_toggle_tread_fx(0);
  veh_vtol go_path(nd_path);
  wait 3.0;
  turn_off_vehicle_exhaust(veh_vtol);
  turn_off_vehicle_tread_fx(veh_vtol);
  veh_vtol hide();
}

setup_vtol_turret() {
  self.turret = maps\_turret::create_turret(self.origin, self.angles, "axis", "v78_player_minigun_gunner", "veh_t6_air_v78_vtol_side_gun");
  self.turret maketurretunusable();
  self.turret maps\_turret::pause_turret(0);
  self setontargetangle(2);

  recordent(self.turret);

  self.turret linkto(self, "tag_gunner1", (0, 0, 0), (0, 0, 0));
}

menendez_hijack_scene_check() {
  if(flag("menendez_hijack_vtol_active")) {
    switch_player_to_mason();
    wait 1;
    level thread run_scene("menendez_hack");
    level thread run_scene("pilot_hack");
    give_models_guns("menendez_hack", "t6_wpn_pistol_judge_world");
  }
}

give_models_guns(str_scene, str_gun) {
  a_models = get_model_or_models_from_scene(str_scene);

  foreach(m_guy in a_models)
  m_guy attach(str_gun, "tag_weapon_right");
}

hijacked_cleanup() {
  flag_wait("hijacked_bridge_fell");
  spawn_manager_kill("quadrotor_tree_crash_trig");
  spawn_manager_kill("hijacked_terrorists_trig");
  wait 0.2;
  array_delete_ai_from_noteworthy("hijacked_terrorists", 1);
  array_delete_ai_from_noteworthy("crossover_terrorist", 1);
  level waittill("swap_quadrotors");
  a_vh_hijacked_robots = getentarray("hijacked_robot", "script_noteworthy");
  kill_units(a_vh_hijacked_robots, 1);
  level waittill("bridge_crossing");
  a_vh_bridge_robots = getentarray("hijacked_bridge_robot", "script_noteworthy");
  kill_units(a_vh_bridge_robots, 1);
  a_vh_bridge_player_quad_spawners = getentarray("hijacked_player_only_quad", "script_noteworthy");
  kill_units(a_vh_bridge_player_quad_spawners);
}

cleanup_bridge_sm() {
  trigger_wait("sm_capture_objective");
  spawn_manager_kill("bridge_guards");
}

kill_units(a_e_units, b_stagger) {
  foreach(e_unit in a_e_units) {
    if(isDefined(e_unit)) {
      if(e_unit.health > 0)
        radiusdamage(e_unit.origin + vectorscale((0, 0, 1), 10.0), 32, e_unit.health + 10, e_unit.health + 10);

      if(isDefined(b_stagger) && b_stagger == 1)
        wait(randomfloatrange(0.45, 0.65));
    }
  }
}

quadrotor_start_rockslide() {
  level endon("hijacked_building_battle_started");
  level endon("hijacked_left_foreshadow");
  level endon("hijacked_right_foreshadow");
  level waittill("fxanim_falling_rocks_start_kickoff");
  spawn_quadrotor_and_drive_path("yemen_hijacked_quadrotor_rockslide", "hijacked_rockslide_spline", 1, 0);
  level notify("fxanim_falling_rocks_start");
}

quadrotor_right_foreshadow() {
  level endon("hijacked_building_battle_started");
  level endon("hijacked_left_foreshadow");
  level waittill("hijacked_right_foreshadow");
  spawn_quadrotor_and_drive_path("yemen_hijacked_quadrotor_right_eratic", "hijacked_right_path_eratic_spline", 1, 0);
}

quadrotor_left_foreshadow() {
  level endon("hijacked_building_battle_started");
  level endon("hijacked_right_foreshadow");
  level waittill("hijacked_left_foreshadow");
  spawn_quadrotor_and_drive_path("yemen_hijacked_quadrotor_left_eratic", "hijacked_left_path_eratic_spline", 1, 0);
}

hijacked_drone_control_lost() {
  flag_wait("drone_control_lost");
  spawn_quadrotor_and_drive_path("yemen_hijacked_quadrotor_window", "nd_hijacked_buildign_window_quadrotor", 1, 0);
  spawn_quadrotor_and_drive_path("yemen_hijacked_quadrotor_roof", "hijacked_roof_spline", 1, 0);
  screen_message_create(&"YEMEN_DRONES_OFFLINE");
  flag_clear("drones_online");
  level.player maps\_fire_direction::_fire_direction_kill();
  screen_message_delete();
  autosave_by_name("drone_control_lost_drones");
}

qr_drones_fly_away() {
  a_qrotors = getentarray("allied_quadrotor", "targetname");
  s_goal_spot = getstruct("s_qr_drones_fly_away", "targetname");
  e_target = getent("qr_drones_dummy_target", "targetname");

  foreach(veh_qrotor in a_qrotors) {
    veh_qrotor.radius = 128;
    veh_qrotor thread qr_drones_move(s_goal_spot, e_target);
    veh_qrotor thread maps\_quadrotor::quadrotor_set_team("axis");
    veh_qrotor clearturrettarget();
  }
}

qr_drones_move(s_goal, e_target) {
  self endon("death");
  self endon("delete");

  if(isDefined(e_target))
    self setturrettargetent(e_target);

  self.goalpos = s_goal.origin;

  while(distance2dsquared(self.origin, s_goal.origin) > 262144)
    wait 0.1;

  self veh_magic_bullet_shield(0);
  self.takedamage = 1;
}

quadrotors_guard_metalstorm() {
  wait 5;
  vh_metalstorm = getent("hijacked_first_metalstorm", "targetname");
  a_vh_quadrotors = getentarray("hijacked_first_metalstorm_guard1", "targetname");
  a_vh_quadrotors2 = getentarray("yemen_hijacked_quadrotor_hostile_formation", "targetname");
  array_thread(a_vh_quadrotors, ::set_quadrotor_guard_position, vh_metalstorm);
  array_thread(a_vh_quadrotors2, ::set_quadrotor_guard_position, vh_metalstorm);
  level thread hijacked_miniboss_clear_listener();
}

hijacked_miniboss_clear_listener() {
  while(true) {
    a_vh_quadrotors = getentarray("hijacked_first_metalstorm_guard1", "targetname");
    a_vh_quadrotors2 = getentarray("yemen_hijacked_quadrotor_hostile_formation", "targetname");
    n_squad_size = a_vh_quadrotors.size + a_vh_quadrotors2.size;

    if(n_squad_size == 0) {
      level notify("hijacked_miniboss_done");
      break;
    }

    wait 1;
  }
}

quadrotor_enemies() {
  flag_wait("drone_control_lost");
  createthreatbiasgroup("quadrotors_enemy");
  setthreatbias("quadrotors", "quadrotors_enemy", 15000);
  setthreatbias("quadrotors_enemy", "quadrotors", 15000);
  spawn_quadrotor_formation(5, "hijacked_hostile_formation_bridge_spline", "yemen_hijacked_quadrotor_hostile_bridge_formation", undefined, "quadrotors_enemy");
}

hijacked_bridge_event() {
  trigger_wait("trigs_hijacked_bridge_drop");
  hijacked_bridge_enemies_clear();
  level thread bridge_groan_sound_loop();
  wait 3;
  hijacked_bridge_explode();
}

hijacked_bridge_drone_crash() {
  spawn_quadrotor_and_drive_path("veh_quadrotor_yemen_hijacked_suicide", "hijacked_bridge_suicide_spline", 1, 0);
  autosave_by_name("hijacked_bridge");
}

hijacked_bridge_explode() {
  exploder(750);
  playsoundatposition("fxa_bridge_explo", (-9350, -13638, 9280));
  level notify("fxanim_bridge_explode_start");
  hijacked_bridge_swap();
  flag_wait("hijacked_bridge_fell");
  flag_set("obj_capture_sitrep");
  level thread hijacked_bridge_ledge_delete_collision_clip();
  wait 6;
  level thread hijacked_bridge_ledge_crumble();
}

capture_fake_battle() {
  s_shoot_spot = getstruct("capture_bridge_battle_shoot_spot", "targetname");
  a_ai_seals = get_ai_array("hijacked_ally", "script_noteworthy");
  a_ai_seals_b = get_ai_array("hijacked_ally_bridge", "script_noteworthy");
  o_target = spawn("script_origin", s_shoot_spot.origin);

  foreach(ai_seal in a_ai_seals)
  ai_seal shoot_at_target_untill_dead(o_target);

  foreach(ai_seal in a_ai_seals_b)
  ai_seal shoot_at_target_untill_dead(o_target);

  level waittill("first_flashback");
  o_target delete();
}

set_quadrotor_guard_position(vh_guard_this) {
  self endon("death");
  self endon("delete");
}

quadrotors_guard_bridge() {
  trigger_wait("trigs_hijacked_bridge_drop");
  wait 3;
  a_vh_quads = getentarray("hijacked_bridge_robot", "script_noteworthy");
  nd_goal = getvehiclenode("hijacked_hostile_formation_bridge_spline_end", "targetname");

  foreach(vh_quad in a_vh_quads)
  vh_quad.goalpos = nd_goal.origin;
}

spawn_quadrotor_and_drive_path(str_veh_spawner, str_nd, b_crash, b_trig) {
  if(!isDefined(b_trig) || b_trig == 1)
    self trigger_wait();

  if(!isDefined(str_veh_spawner))
    str_veh_spawner = self.script_noteworthy;

  veh_qrotor = spawn_vehicle_from_targetname(str_veh_spawner);
  veh_qrotor quadrotor_go_on_path(str_nd, b_crash);
}

quadrotor_go_on_path(str_nd, b_crash) {
  self maps\_quadrotor::quadrotor_start_scripted();

  if(!isDefined(str_nd))
    str_nd = self.target;

  nd_goal = getvehiclenode(str_nd, "targetname");
  self go_path(nd_goal);

  if(isDefined(b_crash)) {
    self thread play_fx("quadrotor_crash", self.origin, self.angles, 2);
    radiusdamage(self.origin + vectorscale((0, 0, 1), 10.0), 128, self.health + 10, self.health + 10);
  } else {
    self maps\_quadrotor::quadrotor_start_ai();
    self.goalpos = self.origin + vectorscale((1, 0, 0), 64.0);
  }
}

spawn_quadrotor_formation(n_count, str_nd_start, str_spawner, str_team, threatgroup) {
  path_start = getvehiclenode(str_nd_start, "targetname");
  offset = vectorscale((0, 1, 0), 70.0);

  for(i = 0; i < n_count; i++) {
    if(!isDefined(str_team))
      str_team = "axis";

    quad = maps\_vehicle::spawn_vehicle_from_targetname(str_spawner);
    quad thread maps\_quadrotor::quadrotor_set_team(str_team);
    quad maps\_quadrotor::quadrotor_start_scripted();
    wait 0.1;
    quad setvehicleavoidance(0);
    quad maps\_vehicle::getonpath(path_start);
    quad.drivepath = 1;
    offset_scale = get_offset_scale(i);
    quad pathfixedoffset(offset * offset_scale);
    quad pathvariableoffset(vectorscale((1, 1, 1), 100.0), randomintrange(1, 3));
    quad thread maps\_vehicle::gopath();
    quad thread activate_ai_on_end_path();

    if(isDefined(threatgroup))
      quad setthreatbiasgroup(threatgroup);

    wait(randomfloatrange(0.3, 0.8));
  }
}

activate_ai_on_end_path() {
  self endon("death");
  trigger = getent("trigs_hijacked_bridge_drop", "targetname");
  self waittill("reached_end_node");
  level notify("awake_axis_quads");
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  self maps\_quadrotor::quadrotor_start_ai();
  self setvehicleavoidance(1);
  self.goalpos = trigger.origin;
  self.goalradius = 1000;
}

hijacked_bridge_approach_save() {
  e_trigger = getent("trigger_hijacked_bridge_approach_save", "targetname");
  e_trigger waittill("trigger");
  autosave_by_name("trigger_hijacked_bridge_approach_save");
}

hijacked_bridge_ledge_crumble() {
  level notify("fxanim_bridge_drop_start");
  wait 2;
}

hijacked_bridge_ledge_delete_collision_clip() {
  a_m_collision = getentarray("m_hijacked_bridge_fall_clip", "targetname");
  array_delete(a_m_collision);
}

hijacked_bridge_guys_move_up() {
  a_bridge_guys = getentarray("sp_hijacked_soldier_rpg_ai", "targetname");

  foreach(ai_guy in a_bridge_guys) {
    nd_goal = getnode(self.script_noteworthy, "targetname");
    ai_guy set_goalradius(64);
    ai_guy setgoalnode(nd_goal);
  }
}

hijacked_magicbullet_shoot(str_gun) {
  s_rpg = getstruct(str_gun, "targetname");
  s_target = getstruct(s_rpg.target, "targetname");

  if(isDefined(s_rpg)) {
    level notify("magic_rgp_fired");
    magicbullet("usrpg_magic_bullet_sp", s_rpg.origin, s_target.origin);
  }
}

hijacked_bridge_enemies_clear() {
  volume = getent("bridge_enemy_volume", "targetname");
  bridge_axis = get_axis_in_volume(volume);
  goal_pos = getstruct("bridge_enemies_goal_org", "targetname");

  foreach(bridge_enemy in bridge_axis) {
    bridge_enemy set_goalradius(64);
    bridge_enemy set_goal_pos(goal_pos.origin);
  }
}

hijacked_bridge_swap() {
  a_m_bridge_whole_parts = getentarray("bridge_whole", "targetname");
  a_m_bridge_destroyed_parts = getentarray("bridge_destroyed", "targetname");

  foreach(m_bridge_destroyed in a_m_bridge_destroyed_parts)
  m_bridge_destroyed show();

  foreach(m_bridge_whole in a_m_bridge_whole_parts)
  m_bridge_whole delete();
}

hijacked_bridge_building_swap() {
  a_m_building_whole = getentarray("bridge_building_whole", "targetname");
  a_m_building_destroyed = getentarray("bridge_building_destroyed", "targetname");

  foreach(m_building_destroyed in a_m_building_destroyed)
  m_building_destroyed show();

  foreach(m_building_whole in a_m_building_whole)
  m_building_whole delete();
}

quadrotor_crash_tree_think() {
  level endon("capture_started");
  str_id = self.script_noteworthy;
  str_node = self.script_string;
  self waittill("trigger");
  spawn_quadrotor_and_drive_path(str_id, str_node, 1, 0);
}

stairs_building_damage_listener() {
  trigger_wait("trig_dmg_hijacked_stairs");
  exploder(760);
  level notify("fxanim_rock_slide_start");
  hijacked_bridge_building_swap();
  flag_set("hijacked_stairs_collapse");
}

stairs_shoot_stairs_building() {
  flag_wait("hijacked_blow_up_building");
  s_rpg = getstruct("s_hijacked_cliffside_magicbullet_rpg_building_collapse", "targetname");
  s_target = getstruct(s_rpg.target, "targetname");
  magicbullet("usrpg_magic_bullet_sp", s_rpg.origin, s_target.origin);
  wait 3;
  level notify("magic_rgp_fired");
}

environmental_challenge(str_notify) {
  level endon("capture_sniper_active");
  flag_wait("drone_control_farmhouse_started");
  a_dmg_trigs = getentarray("hijacked_environmental", "script_noteworthy");
  n_min = a_dmg_trigs.size * 0.5;
  n_destroyed = 0;

  while(true) {
    flag_wait("hijacked_environmental");
    n_destroyed++;

    if(n_destroyed >= n_min) {
      break;
    }

    flag_clear("hijacked_environmental");
    wait 1;
  }

  self notify(str_notify);
}

lumberjack_challenge(str_notify) {
  level endon("capture_sniper_active");
  flag_wait("drone_control_farmhouse_started");
  a_dmg_trigs = getentarray("hijacked_lumberjack", "script_noteworthy");
  n_min = a_dmg_trigs.size * 0.5;
  n_destroyed = 0;

  while(true) {
    flag_wait("hijacked_lumberjack");
    n_destroyed++;

    if(n_destroyed >= n_min) {
      break;
    }

    flag_clear("hijacked_lumberjack");
    wait 1;
  }

  self notify(str_notify);
}

clutz_challenge(str_notify) {
  level endon("menendez_surrenders");
  flag_wait("clutz");
  self notify(str_notify);
}

bridge_groan_sound_loop() {
  o_groan_location = spawn("script_origin", (-9303, -13775, 828));
  o_groan_location playloopsound("amb_bridge_failing");
  level waittill("fxanim_bridge_drop_start");
  playsoundatposition("fxa_bridge_give_way", o_groan_location.origin);
  o_groan_location stoploopsound(2);
  wait 5;
  o_groan_location delete();
}

vo_hijacked() {
  wait 10;
  level.player say_dialog("sect_blocking_positions_0");
  level.player say_dialog("reds_sir_enemy_forces_ha_0", 1);
  level.player say_dialog("reds_sir_no_activity_hv_0", 0.5);
  level.player say_dialog("sect_maintain_eyes_on_but_0", 1);
  flag_wait("drone_control_lost");
  level.player say_dialog("vtol_enemy_has_quad_drone_0");
  level.player say_dialog("vtol_we_are_re_tasking_yo_0");
  wait 2;
  level.player say_dialog("sect_kraken_without_the_d_0");
  level.player say_dialog("vtol_we_are_chopping_you_0");
  level.player say_dialog("vtol_they_will_fast_rope_0");
  level.player say_dialog("sect_understood_section_1");
  flag_wait("hijacked_bridge_fell");
  level.player say_dialog("sala_containment_team_is_0");
  trigger_wait("end_battle");
  level.player say_dialog("us0_sir_5_man_team_to_c_0");
  level.player say_dialog("us1_we_will_pick_up_rear_0");
  level.player say_dialog("us0_once_you_locate_mene_0");
  level.player thread say_dialog("us1_moving_0", 6);
  level.player say_dialog("us0_surround_the_vtol_w_0");
}