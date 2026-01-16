/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_drone_control.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\yemen_utility;
#include maps\_glasses;
#include maps\_vehicle;
#include maps\_fire_direction;
#include maps\_dialog;
#include maps\_quadrotor;
#include maps\_music;
#include maps\_fxanim;
#include maps\createart\yemen_art;
#include maps\yemen_capture;
#include maps\_turret;
#include maps\_cic_turret;
#include maps\_colors;
#include maps\yemen_hijacked;
#include maps\yemen_amb;

init_flags() {
  flag_init("drones_online");
  flag_init("drone_control_skip_setup");
  flag_init("drone_control_started");
  flag_init("drone_control_lost");
  flag_init("drone_control_alley_entered");
  flag_init("drone_control_alley_building_entered");
  flag_init("drone_control_alley_building_alley_triggered");
  flag_init("drone_control_guantlet_started");
  flag_init("drone_control_farmhouse_started");
  flag_init("drone_control_farmhouse_reached");
  flag_init("drone_control_farmhouse_cleanup");
  flag_init("drone_control_right_path_started");
  flag_init("drone_control_left_path_started");
  flag_init("hijacked_cliffside_firefight");
  flag_init("drone_control_player_override");
  flag_init("player_shot_terrorist");
}

init_spawn_funcs() {
  add_spawn_function_group("gauntlet_terrorist", "script_noteworthy", ::drone_control_terrorist_spawnfunc);
  add_spawn_function_group("farmhouse_terrorist", "script_noteworthy", ::drone_control_terrorist_spawnfunc);
  add_spawn_function_group("pathchoice_terrorist", "script_noteworthy", ::drone_control_terrorist_spawnfunc);
  add_spawn_function_group("crossover_terrorist", "script_noteworthy", ::drone_control_terrorist_spawnfunc);
  add_spawn_function_veh("allied_quadrotor", ::drone_control_allied_quadrotor_spawnfunc);
}

skipto_drone_control() {
  skipto_teleport("skipto_drone_control_player");
  init_hero_startstruct("sp_salazar", "skipto_drone_control_salazar");
  load_gump("yemen_gump_outskirts");
  exploder(30);
  switch_player_to_mason();
}

main() {
  iprintln("Drone Control");

  autosave_by_name("drone_control_start");
  flag_set("drone_control_started");
  flag_set("morals_rail_done");
  trigger_use("trig_drone_control_color_alley_start");
  level thread vo_drone_control();
  str_category = "gauntlet_cleanup_category";
  level thread gauntlet_upper_left_terrorists_trigger("gauntlet_upper_left_terrorists_cleanup", str_category);
  level thread maps\_fxanim::fxanim_reconstruct("fxanim_drone_control_canopies");
  level thread maps\_fxanim::fxanim_reconstruct("fxanim_seagulls_circling");
  level notify("start_drone_control_canopies");
  maps\createart\yemen_art::alleyway();
  level thread drone_control_ambient_fx();
  level.salazar = getent("sp_salazar_ai", "targetname");
  level.salazar thread handle_ai_hero_movement();
  level.salazar thread salazar_finish_level_color_trigger();
  level thread drone_control_morals_rail_vtol_go();
  drone_control_setup();
  drone_control_go();
}

drone_control_skipto_setup() {
  for(i = 0; i < 5; i++) {
    quad = maps\_vehicle::spawn_vehicle_from_targetname("allied_quadrotor");
    quad.goalradius = 450;
  }
}

_switch_node_think() {
  self endon("death");
  self waittill("reached_end_node");

  while(true) {
    self waittill("switch_node");
    switch_node_name = self.currentnode.script_string;
    self.switchnode = getvehiclenode(switch_node_name, "targetname");
    self setswitchnode(self.nextnode, self.switchnode);
  }
}

drone_control_setup() {
  level thread drone_control_cleanup();
  level thread maps\yemen_capture::outskirts_fall_death();
  drone_control_setup_threat_bias();
}

drone_control_setup_threat_bias() {
  createthreatbiasgroup("upper_terrorists");
  createthreatbiasgroup("lower_terrorists");
  createthreatbiasgroup("quadrotors");
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
}

change_threat_bias(n_qr_to_upper, n_qr_to_lower, n_upper_to_qr, n_lower_to_qr, n_upper_to_player, n_lower_to_player) {
  setthreatbias("upper_terrorists", "quadrotors", n_qr_to_upper);
  setthreatbias("lower_terrorists", "quadrotors", n_qr_to_lower);
  setthreatbias("quadrotors", "upper_terrorists", n_upper_to_qr);
  setthreatbias("quadrotors", "lower_terrorists", n_lower_to_qr);
  setthreatbias("player", "upper_terrorists", n_upper_to_player);
  setthreatbias("player", "lower_terrorists", n_lower_to_player);
}

drone_control_terrorist_spawnfunc() {
  self.overrideactordamage = ::terrorist_shot_callback;
  self setthreatbiasgroup("upper_terrorists");
}

drone_control_lower_spawnfunc() {
  self.overrideactordamage = ::terrorist_shot_callback;
  self setthreatbiasgroup("lower_terrorists");
}

drone_control_allied_quadrotor_spawnfunc() {
  self thread maps\_quadrotor::quadrotor_set_team("allies");
  self.takedamage = 1;

  if(!flag("drone_control_lost"))
    maps\_fire_direction::add_fire_direction_shooter(self);
}

quadrotor_reinforce(str_endon, str_spline_then_ai, str_goal_node_tn) {
  level notify("stop_ally_quadrotor_respawn");
  level endon("stop_ally_quadrotor_respawn");

  if(isDefined(str_endon))
    level endon(str_endon);

  if(isDefined(str_goal_node_tn))
    goal_node = getnode(str_goal_node_tn, "targetname");

  while(true) {
    a_vh_quads = getentarray("allied_quadrotor", "targetname");

    if(a_vh_quads.size < 5) {
      vh_quadrotor = maps\_vehicle::spawn_vehicle_from_targetname("allied_quadrotor");
      vh_quadrotor.origin = level.player.origin + vectorscale((0, 0, 1), 256.0);
      vh_quadrotor setthreatbiasgroup("quadrotors");

      if(isDefined(str_spline_then_ai))
        vh_quadrotor thread quadrotors_go_spline_then_ai(str_spline_then_ai);

      if(isDefined(goal_node)) {
        vh_quadrotor.goalpos = goal_node.origin;
        vh_quadrotor.goalradius = 1000;
      }
    }

    wait 1;
  }
}

drone_control_ambient_fx() {
  flag_wait("drone_control_gauntlet_started");
  stop_exploder(1030);
  exploder(1040);
  maps\createart\yemen_art::market_2();
  autosave_by_name("drone_control_gauntlet_started");
}

drone_control_threat_control_think() {
  level endon("drone_control_farmhouse_started");
  level.player endon("death");
  e_turret = spawn_vehicle_from_targetname("guantlet_turret");
  e_turret thread drone_control_turret_death_cleanup();
  e_turret thread drone_control_turret_kill();
  e_turret endon("death");
  t_street_trig = getent("trig_drone_control_street_exposed", "targetname");

  while(true) {
    t_street_trig trigger_wait();
    flag_set("drone_control_player_override");
    e_turret thread drone_control_turret_fire_think();

    while(level.player istouching(t_street_trig))
      wait 0.25;

    e_turret notify("stop_dc_turret_fire");
    e_turret maps\_turret::clear_turret_target(0);
    flag_clear("drone_control_player_override");
  }
}

drone_control_turret_kill() {
  level.player endon("death");
  flag_wait("drone_control_farmhouse_started");

  if(isDefined(self) && isalive(self))
    self notify("death");
}

drone_control_turret_death_cleanup() {
  self waittill("death");

  if(flag("drone_control_player_override"))
    flag_clear("drone_control_player_override");
}

drone_control_turret_fire_think() {
  level notify("drone_control_turret_think");
  level endon("drone_control_turret_think");
  self endon("death");
  self endon("stop_dc_turret_fire");
  level.player endon("death");
  wait 0.05;
  self maps\_cic_turret::cic_turret_start_scripted();
  self maps\_turret::set_turret_target(level.player, undefined, 0);

  while(true) {
    self maps\_turret::fire_turret_for_time(randomfloatrange(2, 3), 0);
    wait(randomfloatrange(0.1, 0.5));
  }
}

drone_control_player_damage_callback(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(flag("drone_control_player_override"))
    n_damage = int(n_damage * 2);

  if(isDefined(e_attacker.script_noteworthy) && e_attacker.script_noteworthy == "allied_quadrotor")
    n_damage = int(n_damage / 2);

  return n_damage;
}

terrorist_shot_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(isDefined(eattacker) && isplayer(eattacker)) {
    if(!flag("player_shot_terrorist"))
      flag_set("player_shot_terrorist");
  }

  return idamage;
}

gauntlet_upper_left_terrorists_trigger(str_level_endon, str_category) {
  level endon(str_level_endon);
  e_trigger = getent("gauntlet_upper_left_terrorists_trigger", "targetname");
  e_trigger waittill("trigger");
  a_spawners = getentarray("gauntlet_upper_left_terrorists_spawner", "targetname");
  simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);
}

drone_control_cleanup() {
  array_delete_veh_from_targetname("allied_quadrotor");
  flag_wait("drone_control_alley_entered");
  array_delete_veh_from_targetname("yemen_drone_control_vtol_spawner");
  array_delete_veh_from_targetname("yemen_morals_rail_vtol_spawner");
  flag_wait("drone_control_farmhouse_started");
  maps\createart\yemen_art::outdoors();
  spawn_manager_kill("trig_gauntlet_upper_terrorists");
  spawn_manager_kill("trig_gauntlet_upper_terrorists3");
  level notify("gauntlet_upper_left_terrorists_cleanup");
  cleanup_ents("gauntlet_cleanup_category");
  wait 0.2;
  array_delete_ai_from_noteworthy("gauntlet_terrorist", 1);
  flag_wait("drone_control_farmhouse_cleanup");
  spawn_manager_kill("farmhouse_terrorist_roof_trig");
  spawn_manager_kill("farmhouse_terrorist_trig");
  e_turret = getent("guantlet_turret", "targetname");
  flag_clear("drone_control_player_override");
  e_turret.delete_on_death = 1;
  e_turret notify("death");

  if(!isalive(e_turret))
    e_turret delete();

  wait 0.2;
  array_delete_ai_from_noteworthy("farmhouse_terrorist", 1);
  flag_wait("cleanup_pathchoice");
  spawn_manager_kill("pathchoice_terrorist_trig");
  wait 0.2;
  array_delete_ai_from_noteworthy("pathchoice_terrorist", 1);
}

array_delete_veh_from_targetname(targetname) {
  vehicles = getentarray(targetname, "targetname");

  foreach(veh in vehicles) {
    veh.delete_on_death = 1;
    veh notify("death");

    if(!isalive(veh))
      veh delete();
  }
}

drone_control_go() {
  flag_wait("drone_control_alley_entered");
  level activate_drone_control();
  level.player.overrideplayerdamage = ::drone_control_player_damage_callback;
  a_morals_actors = getentarray("morals_actor", "script_noteworthy");
  array_delete(a_morals_actors);
  setup_allied_quadrotors();
  level thread allied_quadrotor_control();
  drone_control_gauntlet_ambience();
  level clientnotify("snd_canyon_wind");
  flag_wait("drone_control_guantlet_started");
  level thread drone_control_quadrotor_sounds();
  level thread drone_control_threat_control_think();
  flag_wait("drone_control_farmhouse_started");
  level thread morals_rail_allies_cleanup();
  spawn_vtols_at_structs("s_dc_farmhouse_first_vtol_left");
  level thread drone_control_splitpath_cliffside_ambient();
  level thread drone_control_do_ambient_crossover();
}

morals_rail_allies_cleanup() {
  maps\_colors::kill_color_replacements();
  array_delete_ai_from_noteworthy("drone_control_allies");
}

handle_ai_hero_movement() {
  self endon("death");
  self change_movemode("run");
  self.radius = 128;
  flag_wait("drone_control_alley_entered");
  self set_force_color("c");
  flag_wait("drone_control_farmhouse_started");
  self set_force_color("b");
}

salazar_finish_level_color_trigger() {
  self endon("death");
  e_trigger = getent("set_salazar_finish_level_color_trigger", "targetname");
  e_trigger waittill("trigger");
  self set_force_color("r");
}

activate_drone_control() {
  spawn_quadrotors(5, "drone_control_quadrotors_enter_guantlet_spline", "allied_quadrotor");
  setmusicstate("YEMEN_MASON_KICKS_ASS");
  level clientnotify("mbs");
  level.player enable_drone_control();
  level thread drone_cam_pip_sounds();
  level thread play_bink_on_hud("yemen_drone_cam");
  level thread quadrotor_reinforce("drone_control_lost", "drone_control_transition_spline", undefined);
}

enable_drone_control() {
  assert(isplayer(self), "this must be called on the player");
  self endon("death");

  while(isDefined(self.empgrenaded) && self.empgrenaded)
    wait 0.05;

  self maps\_fire_direction::init_fire_direction();
  self thread watch_for_emp_grenaded();
}

watch_for_emp_grenaded() {
  assert(isplayer(self), "this must be called on the player");
  self endon("death");

  while(maps\_fire_direction::is_fire_direction_active()) {
    self waittill("emp_grenaded");

    if(maps\_fire_direction::is_fire_direction_active())
      self maps\_fire_direction::_fire_direction_disable();

    wait 0.05;

    while(isDefined(self.empgrenaded) && self.empgrenaded)
      wait 0.05;

    if(maps\_fire_direction::is_fire_direction_active())
      self maps\_fire_direction::_fire_direction_enable();
  }
}

drone_control_alley_qrotor_start() {
  play_bink_on_hud("yemen_drone_cam");
  level.player maps\_fire_direction::init_fire_direction();
}

drone_control_gauntlet_go() {
}

setup_allied_quadrotors() {
  a_vh_quads = getentarray("allied_quadrotor", "targetname");

  foreach(vh_quad in a_vh_quads)
  vh_quad setthreatbiasgroup("quadrotors");
}

drone_control_morals_rail_vtol_go() {
  veh_vtol = getent("yemen_morals_rail_vtol_spawner", "targetname");
  nd_vtol_start = getvehiclenode("nd_drone_control_vtol_start", "targetname");
}

drone_control_gauntlet_magic_rpgs() {
  flag_wait("drone_control_guantlet_started");
  level thread spawn_vtols_at_structs("s_dc_gauntlet_middle_vtol");
  drone_control_fire_magic_rpgs_at_target("s_drone_control_rpg_magicbullet_guy", "s_drone_control_rpg_magicbullet_guy_target");
  wait 1;
  level thread drone_control_fire_magic_rpgs_at_target("s_drone_control_rpg_magicbullet", "s_drone_control_rpg_magicbullet_target");
}

drone_control_gauntlet_ambience() {
  level thread drone_control_do_ambient_vtols("trig_look_dc_guantlet_right_first_vtol_spawn", "s_dc_gauntlet_right_vtol", undefined, "drone_control_farmhouse_started");
  level thread drone_control_do_ambient_vtols("trig_look_dc_guantlet_right_second_vtol_spawn", "s_dc_gauntlet_right_second_vtol", undefined, "drone_control_farmhouse_started");
  level thread drone_control_do_ambient_quadrotors();
}

drone_control_drones_offline() {
  screen_message_create(&"YEMEN_DRONES_OFFLINE");
  flag_clear("drones_online");
  flag_set("drone_control_lost");
  level.player maps\_fire_direction::_fire_direction_kill();
  level thread qr_drones_fly_away();
  level thread drone_cam_pip_sounds();
  screen_message_delete();
  autosave_by_name("drone_control_lost_drones");
}

spawn_quadrotors(n_count, str_nd_start, str_spawner) {
  path_start = getvehiclenode(str_nd_start, "targetname");

  for(i = 0; i < n_count; i++) {
    quad = maps\_vehicle::spawn_vehicle_from_targetname(str_spawner);
    quad setvehicleavoidance(0);
    quad.drivepath = 0;
    quad maps\_vehicle::getonpath(path_start);
    quad thread maps\_vehicle::gopath();
    quad thread maps\yemen_hijacked::activate_ai_on_end_path();
    wait(randomfloatrange(0.55, 0.75));
  }
}

quadrotors_go_spline_then_ai(str_nd_start) {
  path_start = getvehiclenode(str_nd_start, "targetname");
  self maps\_vehicle::getonpath(path_start);
  self.drivepath = 1;
  self.takedamage = 1;
  self thread maps\_vehicle::gopath();
  self thread maps\yemen_hijacked::activate_ai_on_end_path();
}

allied_quadrotor_control() {
  while(true) {
    v_movepoint = _get_player_look_position();
    a_qrotors = getentarray("allied_quadrotor", "script_noteworthy");

    foreach(veh_qrotor in a_qrotors) {
      if(!isDefined(veh_qrotor.quadrotor_doing_fire_direction))
        veh_qrotor.goalpos = v_movepoint;
    }

    wait 0.5;
  }
}

_get_player_look_position() {
  v_eye_pos = level.player geteye();
  v_player_eye = level.player getplayerangles();
  v_player_eye = vectornormalize(anglestoforward(v_player_eye));
  v_trace_to_point = v_eye_pos + v_player_eye * randomfloatrange(400, 900);
  a_trace = bullettrace(v_eye_pos, v_trace_to_point, 0, level.player);
  return a_trace["position"];
}

drone_control_fire_magic_rpgs_at_target(str_s_rpgs_name, str_s_rpg_target) {
  a_rpgs = getstructarray(str_s_rpgs_name, "targetname");
  s_target = getstruct(str_s_rpg_target, "targetname");

  foreach(s_rpg in a_rpgs) {
    magicbullet("usrpg_magic_bullet_sp", s_rpg.origin, s_target.origin);
    wait(randomfloatrange(0.5, 1));
  }
}

drone_control_do_ambient_vtols(str_trig_name, str_struct, str_nd_name, str_flag_name) {
  if(isDefined(str_flag_name)) {
    while(!flag(str_flag_name)) {
      trigger_wait(str_trig_name);
      spawn_vtols_at_structs(str_struct, str_nd_name);
    }
  } else {
    trigger_wait(str_trig_name);
    spawn_vtols_at_structs(str_struct, str_nd_name);
  }
}

drone_control_splitpath_cliffside_ambient() {
  level endon("fxanim_bridge_explode_start");
  s_gun1 = getstruct("s_hijacked_cliffside_magicbullet_gun1", "targetname");
  s_gun1_target = getstruct(s_gun1.target, "targetname");
  s_gun2 = getstruct("s_hijacked_cliffside_magicbullet_gun2", "targetname");
  s_gun2_target = getstruct(s_gun2.target, "targetname");
  s_gun3 = getstruct("s_hijacked_cliffside_magicbullet_gun3", "targetname");
  s_gun3_target = getstruct(s_gun3.target, "targetname");

  while(true) {
    for(i = 0; i < 60; i++) {
      magicbullet("mp7_sp", s_gun1.origin, s_gun1_target.origin);
      magicbullet("mp7_sp", s_gun2.origin, s_gun2_target.origin);
      magicbullet("mp7_sp", s_gun3.origin, s_gun3_target.origin);
      wait 0.1;
    }

    wait 0.5;
  }
}

drone_control_do_ambient_quadrotors() {
  level endon("drone_control_farmhouse_reached");

  while(!flag("drone_control_farmhouse_reached")) {
    level thread maps\yemen_capture::capture_spawn_fake_qrotors_at_structs_and_move("s_dc_gauntlet_right_fake_quadrotors_first", randomintrange(5, 6));
    wait(randomfloatrange(1, 3));
  }
}

drone_control_do_ambient_crossover() {
  level endon("drone_control_lost");
  level thread maps\yemen_capture::capture_spawn_fake_qrotors_at_structs_and_move("s_dc_gauntlet_right_pathchoice_crossover", randomintrange(1, 3));
}

vo_drone_control() {
  level.player thread say_dialog("sala_command_salazar_on_0");
  flag_wait("drone_control_alley_entered");
  level thread vo_drone_control_intro();
  flag_wait("drone_control_guantlet_started");
  wait 2;
  level.player thread say_dialog("sect_split_up_take_the_0", 1);
  level thread vo_killzone();
  level thread vo_choose_left_path();
  level thread vo_choose_right_path();
  level vo_outskirts();
}

vo_hint_standing_by_for_targets() {
  level endon("drone_control_lost");
  wait 5;

  while(true) {
    wait(randomintrange(10, 16));

    if(level.player hasweapon("quadrotor_glove_sp")) {
      if(flag("fire_direction_shader_on")) {
      }
    }
  }
}

vo_drone_control_intro() {
  level.player say_dialog("sect_command_we_need_th_0");
  level.player say_dialog("comm_sending_codes_to_you_0");
  level.player say_dialog("vtol_drone_targeting_cont_0");
  level thread vo_vtol_pilot_intro();
}

vo_vtol_pilot_intro() {
  level.player say_dialog("vtol_hud_relay_systems_en_0");
}

vo_killzone() {
  level endon("drone_control_farmhouse_started");
  level endon("drone_control_salazar_takes_right");
  level endon("drone_control_salazar_takes_left");
  flag_wait("drone_control_player_override");
  level.player say_dialog("sect_the_whole_street_s_a_0");
}

vo_choose_left_path() {
  level endon("drone_control_salazar_takes_left");
  flag_wait("drone_control_salazar_takes_right");
  level.player say_dialog("sect_take_the_right_i_v_0");
}

vo_choose_right_path() {
  level endon("drone_control_salazar_takes_right");
  flag_wait("drone_control_salazar_takes_left");
  level.player say_dialog("sect_you_take_the_left_0");
}

vo_magic_rpg_guys() {
  flag_wait("drone_control_farmhouse_started");
  wait 2;
  level.player say_dialog("sala_rpgs_on_the_rooftops_0");
}

vo_outskirts() {
  flag_wait("drone_control_farmhouse_started");
  level.player say_dialog("sect_kraken_we_believe_0");
  level.player say_dialog("sect_push_all_available_a_0", 0.2);
}

drone_nag() {
}

drone_kill_challenge(str_notify) {
  level waittill("drone_control_started");
  add_global_spawn_function("axis", ::challenge_qrkills_death_listener, str_notify);
}

challenge_qrkills_death_listener(str_notify) {
  self waittill("death", e_attacker, b_damage_from_underneath, str_weapon);

  if(isDefined(e_attacker) && isDefined(e_attacker.model) && e_attacker.model == "veh_t6_drone_quad_rotor_sp")
    level.player notify(str_notify);
}

drone_control_quadrotor_sounds() {
  level endon("hijacked_bridge_fell");
  level thread vo_hint_standing_by_for_targets();

  while(true) {
    flag_wait("fire_direction_shader_on");

    if(level.player attackbuttonpressed()) {
      level thread maps\yemen_amb::play_drone_control_tones_single();

      if(randomintrange(1, 3) > 2) {
        level.player say_dialog("vtol_confirm_0");
        wait(randomfloatrange(0.15, 0.25));
      }

      level.player thread say_dialog("vtol_firing_0");

      while(level.player attackbuttonpressed())
        wait 0.05;
    }

    wait 0.05;
  }
}

drone_cam_pip_sounds() {
  level.sound_pip_ent = spawn("script_origin", level.player.origin);
  level.player playsound("evt_pnp_on");
  level.sound_pip_ent playloopsound("evt_pnp_loop", 1);
  wait 6;
  level.player playsound("evt_pnp_off");
  level.sound_pip_ent stoploopsound();
  level.sound_pip_ent delete();
}