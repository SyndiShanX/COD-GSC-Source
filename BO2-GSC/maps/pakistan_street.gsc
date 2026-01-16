/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_street.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\pakistan_util;
#include maps\_music;
#include maps\_dialog;
#include maps\_vehicle;
#include maps\_scene;
#include maps\pakistan_market;
#include maps\pakistan;
#include maps\pakistan_anim;
#include maps\_fire_direction;
#include maps\createart\pakistan_art;
#include maps\_anim;

skipto_frogger() {
  skipto_teleport("skipto_frogger", init_hero("harper"));
  m_car = get_ent("car_smash_car", "targetname", 1);
  m_car delete();
  m_bus = get_ent("car_smash_bus", "targetname", 1);
  m_bus delete();
  exploder(240);
  spawn_vehicles_from_targetname_and_drive("street_debris_follow_market_bus");
  level thread maps\pakistan_util::skipto_bus_dam_deconstruct_ents();
  delay_thread(1, ::run_scene, "car_corner_crash_loop");
}

skipto_frogger_claw_support() {
  init_heroes(array("harper", "claw_1", "claw_2"));
  maps\pakistan_market::enable_claw_fire_direction_feature(0);
  level thread maps\pakistan_util::skipto_bus_dam_deconstruct_ents();
  flag_set("brute_force_unlock_done");
  flag_set("intro_anim_claw_done");
  exploder(240);
  clientnotify("cleanup_market_dynents");
  skipto_frogger();
}

skipto_bus_street() {
  skipto_teleport("skipto_bus_street", init_hero("harper"));
  flag_set("intro_anim_done");
  flag_set("frogger_done");
  clientnotify("cleanup_market_dynents");
  level.player thread maps\pakistan_util::frogger_corpse_control();
  level thread watch_player_rain_water_sheeting();
  level thread maps\pakistan_util::skipto_bus_dam_deconstruct_ents();
  level.harper thread follow_path(getnode("bus_street_follow_node", "targetname"));
  level thread maps\pakistan::pakistan_objectives();
  flag_set("intro_anim_done");
  flag_set("frogger_started");
  flag_set("frogger_done");
}

skipto_bus_dam() {
  flag_set("frogger_done");
  flag_set("approach_bus_dam");
  clientnotify("cleanup_market_dynents");
  level.player thread maps\pakistan_util::frogger_corpse_control();
  level thread watch_player_rain_water_sheeting();
  skipto_teleport("skipto_bus_dam", init_hero("harper"));
  level thread maps\pakistan_util::skipto_bus_dam_deconstruct_ents();
}

skipto_alley() {
  skipto_teleport("skipto_alley", init_hero("harper"));
  clientnotify("cleanup_market_dynents");
  clientnotify("cleanup_market_pillars");
  clientnotify("start_stealth_dynents");
  flag_set("frogger_started");
  flag_set("frogger_done");
  flag_set("bus_dam_idle_started");
  flag_set("bus_dam_gate_push_test_done");
  flag_set("bus_dam_gate_success_harper_done");
  flag_set("bus_dam_gate_success_done");
  level thread watch_player_rain_water_sheeting();
  level thread maps\pakistan_util::skipto_stealth_deconstruct_ents();
  flag_set("zone_stealth_restored");
}

frogger() {
  spawn_vehicles_from_targetname("street_debris");
  debug_print_line("frogger started");
  flag_set("frogger_started");
  level.player setwaterdrops(25);
  exploder(240);
  level thread turn_off_claw_firing();
  level thread vo_frogger_enemy();
  level thread vo_archway_enemy();
  level thread vo_bus_dam_enemy();
  level thread frogger_setup_ai();
  level thread frogger_setup_environment();
  level thread watch_player_rain_water_sheeting();
  flag_wait("frogger_combat_started");
  level thread maps\pakistan_anim::vo_frogger();
  setmusicstate("PAK_RIVER_FIGHT");
  trigger_wait("frogger_spawn_manager_start_trigger");
  level thread cleanup_market();
  autosave_by_name("pakistan_frogger_mid");
  level thread _balcony_collapse_internal();
  debug_print_line("SM enable: frogger_street");
  flag_wait("frogger_done");
  debug_print_line("frogger done");
  level thread cleanup_frogger_guys();
}

cleanup_frogger_guys() {
  spawn_manager_kill("frogger_third_wave_spawn_trigger");
  spawn_manager_kill("frogger_perk_spawn_trigger");
  a_ai_frogger = get_ai_array("frogger_perk_extra_guys", "targetname");

  foreach(ai_frogger in a_ai_frogger)
  ai_frogger die();

  a_ai_frogger = get_ai_array("frogger_third_wave_guys", "targetname");

  foreach(ai_frogger in a_ai_frogger)
  ai_frogger die();

  a_ai_frogger = get_ai_array("frogger_second_wave_guys", "targetname");

  foreach(ai_frogger in a_ai_frogger)
  ai_frogger die();
}

turn_off_claw_firing() {
  claws_toggle_firing(0);
  wait_network_frame();
}

cleanup_market() {
  a_e_market_ents = getentarray("market_ent", "script_noteworthy");
  a_s_structs = getstructarray("market_struct", "script_noteworthy");
  array_delete(a_e_market_ents);

  foreach(s_struct in a_s_structs)
  s_struct structdelete();

  flag_wait("approach_bus_dam");
  delete_scene_all("bus_smash_damage_ai", 1, 0, 1);
  a_t_market_triggers = getentarray("market_trigger", "script_noteworthy");
  array_delete(a_t_market_triggers);
}

claws_toggle_firing(b_shouldfire) {
  ai_claw_1 = getent("claw_1_ai", "targetname");
  ai_claw_2 = getent("claw_2_ai", "targetname");

  if(isDefined(ai_claw_1))
    ai_claw_1 maps\pakistan_market::claw_toggle_firing(b_shouldfire);

  if(isDefined(ai_claw_2))
    ai_claw_2 maps\pakistan_market::claw_toggle_firing(b_shouldfire);
}

vo_frogger_enemy() {
  level endon("vo_bus_dam");
  flag_wait("vo_street_start");
  clientnotify("cleanup_market_dynents");
  queue_dialog_enemy("isi4_here_they_come_0", 0);
  queue_dialog_enemy("isi3_they_re_in_the_kill_0", 1);
  flag_wait("vo_street_killzone");
  queue_dialog_enemy("isi1_they_re_fighting_the_0", 0);
  queue_dialog_enemy("isi2_shoot_and_move_0", 1);
  flag_wait("vo_street_reinforce");
  queue_dialog_enemy("isi3_radio_command_tell_0", 0);
  queue_dialog_enemy("isi4_get_more_men_on_the_0", 0.5);
  queue_dialog_enemy("isi1_we_need_reinforcemen_0", 1);
  flag_wait("vo_street_moveup");
  queue_dialog_enemy("isi2_they_re_moving_up_0", 0);
  queue_dialog_enemy("isi4_spread_out_cover_t_0", 0.5);
  queue_dialog_enemy("isi1_cover_the_street_0", 0.5);
}

vo_archway_enemy() {
  level endon("vo_bus_dam");
  flag_wait("frogger_done");
  queue_dialog_enemy("isi3_there_by_the_archw_0", 0);
  queue_dialog_enemy("isi2_hold_this_position_0", 1);
  queue_dialog_enemy("isi1_we_need_reinforcemen_1", 2);
  queue_dialog_enemy("isi2_call_in_drone_suppor_0", 2);
}

vo_bus_dam_enemy() {
  flag_wait("vo_bus_dam");
  queue_dialog_enemy("isi3_look_out_0", 0);
  queue_dialog_enemy("isi4_get_off_the_street_0", 1);
}

vo_claw_streets_enemy() {
  queue_dialog_enemy("isi2_opposite_rooftops_t_0", 1);
  queue_dialog_enemy("isi3_they_re_targeting_th_0", 1);
  queue_dialog_enemy("isi4_we_can_t_fight_those_0", 1);
}

frogger_setup_environment() {
  level thread frogger_start_spawning_dyn_ents();
  level.player thread maps\pakistan_util::frogger_corpse_control();

  if(!isDefined(level.water_level_raised))
    raise_water_level();

  level thread frogger_set_dvars();
  nd_fall = getnode("frogger_balcony_connect_fall", "targetname");
  nd_balcony = getnode("frogger_balcony_connect_balcony", "targetname");

  if(isDefined(nd_fall) && isDefined(nd_balcony)) {
    linknodes(nd_balcony, nd_fall);
    linknodes(nd_fall, nd_balcony);
  }
}

frogger_setup_ai() {
  add_spawn_function_ai_group("frogger_balcony_guys", ::shoot_at_players_feet);
  level thread move_breakoff_group_to_roof();
  level thread frogger_harper_movement();
}

_balcony_collapse_internal() {
  level waittill("fxanim_balcony_collapse_start");
  level.player thread balcony_collapse_rumble();
  a_n_nodes = getnodearray("balcony_collapse_nodes", "script_noteworthy");

  foreach(n_node in a_n_nodes)
  setenablenode(n_node, 0);

  bm_clip = get_ent("balcony_collapse_clip", "targetname");
  bm_clip delete();
  t_balcony = get_ent("balcony_collapse_kill_volume", "targetname");
  a_guys = get_ai_touching_volume("axis", undefined, t_balcony);
  array_thread(a_guys, ::kill_me);
  wait_network_frame();
  t_balcony delete();
}

shoot_at_players_feet() {
  self endon("death");
  v_offset = (0, 0, 0);

  if(!isDefined(level.player.water_impact_origin)) {
    level.player.water_impact_origin = spawn("script_origin", level.player.origin + v_offset);
    level.player.water_impact_origin.targetname = "player_water_impact_origin";
    level.player.water_impact_origin.health = 100;
    level.player.water_impact_origin linkto(level.player);
  }

  self thread shoot_at_target(level.player.water_impact_origin, undefined, undefined, -1);
}

raise_water_level() {
  level.water_level_raised = 1;
  str_val = getdvar(#"r_waterWaveBase");

  if(isDefined(str_val) && str_val != "")
    level thread lerp_dvar("r_waterWaveBase", 10, 2);

  e_market_volume = get_ent("market_water_volume", "targetname", 1);
  setwaterbrush(e_market_volume);
  e_market_volume movez(10, 2);
  exploder(100);
}

lower_water_level() {
  if(isDefined(level.water_level_raised) && level.water_level_raised) {
    str_val = getdvar(#"r_waterWaveBase");

    if(isDefined(str_val) && str_val != "")
      level thread lerp_dvar("r_waterWaveBase", 2, 2);
  }

  stop_exploder(100);
}

#using_animtree("generic_human");

frogger_harper_movement() {
  level.harper pakistan_move_mode("cqb_run");
  level.harper disable_pain();
  level.harper disable_react();
  level.harper disable_ai_color();
  level.harper set_cqb_run_anim( % ai_cqb_walk_f_water_light, % ai_cqb_walk_f_water_light, % ai_cqb_walk_f_water_light);
  nd_path = getnode("harper_frogger_start", "targetname");
  level.harper setgoalnode(nd_path);
  ai_crosby = getent("crosby_ai", "targetname");

  if(!isDefined(ai_crosby))
    ai_crosby = init_hero("crosby");

  ai_crosby thread frogger_crosby_movement();
  level waittill("fxanim_car_corner_crash_start");
  wait 2;
  level.harper follow_path(nd_path);
  flag_wait("frogger_done");
  level.harper clear_cqb_run_anim();
}

frogger_crosby_movement() {
  nd_path = getnode("crosby_frogger_start", "targetname");
  self setgoalnode(nd_path);
}

delete_ent_if_defined(str_key, str_value) {
  if(!isDefined(str_value))
    str_value = "targetname";

  e_temp = get_ent(str_key, str_value);

  if(isDefined(e_temp)) {
    if(e_temp is_hero())
      e_temp unmake_hero();

    if(isDefined(e_temp.classname) && e_temp.classname == "script_vehicle") {
      e_temp.delete_on_death = 1;
      e_temp notify("death");

      if(!isalive(e_temp))
        e_temp delete();
    } else
      e_temp delete();
  }
}

move_breakoff_group_to_roof() {
  if(maps\_fire_direction::is_fire_direction_active())
    level.player maps\_fire_direction::_fire_direction_disable();

  level endon("brute_force_bypassed");
  flag_wait("brute_force_unlock_done");
  wait 3;
  flag_set("frogger_perk_active");
  s_warp_claw_1 = get_struct("claw_1_warp_to_roof_struct", "targetname", 1);
  s_warp_claw_2 = get_struct("claw_2_warp_to_roof_struct", "targetname", 1);
  ai_claw_1 = get_ent("claw_1_ai", "targetname", 1);
  ai_claw_2 = get_ent("claw_2_ai", "targetname", 1);
  ai_salazar = get_ent("salazar_ai", "targetname", 1);
  ai_salazar delete();
  ai_claw_1 forceteleport(s_warp_claw_1.origin, s_warp_claw_1.angles);
  ai_claw_2 forceteleport(s_warp_claw_2.origin, s_warp_claw_2.angles);
  ai_claw_1 clear_force_color();
  ai_claw_2 clear_force_color();
  ai_claw_1 setgoalpos(ai_claw_1.origin);
  ai_claw_2 setgoalpos(ai_claw_2.origin);
  flag_wait("frogger_combat_started");
  wait 6;
  level thread vo_claw_streets_enemy();
  spawn_manager_enable("frogger_perk_spawn_trigger");

  if(maps\_fire_direction::is_fire_direction_active())
    level.player maps\_fire_direction::_fire_direction_enable(1);
  else
    maps\pakistan_market::enable_claw_fire_direction_feature(0);

  claws_toggle_firing(1);
  level thread maps\pakistan_anim::vo_frogger_support();
  flag_wait("frogger_done");
  level thread maps\pakistan_anim::vo_claws_leaving();
  claws_toggle_firing(0);
  level.player maps\_fire_direction::_fire_direction_kill();
}

kill_me() {
  if(isDefined(self))
    self dodamage(self.health, self.origin, self);
}

bus_street() {
  spawn_vehicles_from_targetname("bus_dam_wave_push_debris");
  spawn_vehicles_from_targetname_and_drive("bus_street_cover");
  autosave_by_name("pakistan_bus_street");
  add_spawn_function_group("bus_street_spawn_manager_guys", "script_noteworthy", ::pacifist_to_goal);
  lower_water_level();
}

pacifist_to_goal() {
  self endon("death");
  self set_pacifist(1);
  self waittill("goal");
  self set_pacifist(0);
}

start_bus(e_bus) {
  level thread bus_street_decrease_enemy_accuracy();
  level thread bus_wave_starts();
  bus_event_setup();
  clientnotify("bus_wave_initial_start");
  level thread run_scene("bus_dam_start");
  level.player thread bus_dam_rumble();
  flag_wait("bus_dam_start_done");
  debug_print_line("bus stuck on environment...");
  level thread run_scene("bus_dam_idle");
}

water_dvar_lerp(str_dvar, n_time, n_amp_1, n_amp_2, n_amp_3, n_amp_4) {
  str_water_values = getdvar(str_dvar);
  a_tokens = strtok(str_water_values, " ");
  a_values = [];

  for(i = 0; i < 4; i++)
    a_values[a_values.size] = float(a_tokens[i]);

  n_frames = n_time * 20;
  a_change_per_frame = [];
  a_change_per_frame[0] = abs(n_amp_1 - a_values[0]) / n_frames;
  a_change_per_frame[1] = abs(n_amp_2 - a_values[1]) / n_frames;
  a_change_per_frame[2] = abs(n_amp_3 - a_values[2]) / n_frames;
  a_change_per_frame[3] = abs(n_amp_4 - a_values[3]) / n_frames;

  for(j = 0; j < n_frames; j++) {
    str_frame_amplitudes = "";

    for(k = 0; k < a_tokens.size; k++) {
      n_change_this_frame = a_values[k] - a_change_per_frame[k] * j;
      str_frame_amplitudes = str_frame_amplitudes + (n_change_this_frame + " ");
    }

    setdvar(str_dvar, str_frame_amplitudes);
    wait 0.05;
  }

  str_final_amp = "" + n_amp_1 + " " + n_amp_2 + " " + n_amp_3 + " " + n_amp_4;
  setdvar(str_dvar, str_final_amp);
}

bus_street_decrease_enemy_accuracy() {
  a_enemies = getaiarray("axis");
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  s_escape = get_struct("bus_escape_struct", "targetname", 1);
  e_ignore = get_ent("player_bus_safe_zone_volume", "targetname", 1);

  foreach(enemy in a_enemies)
  enemy thread _run_from_bus(m_bus, s_escape, e_ignore);

  level delay_notify("stop_running_from_bus", 5);
}

_run_from_bus(m_bus, s_escape, e_ignore) {
  level endon("stop_running_from_bus");
  self endon("death");

  while(distance2d(m_bus.origin, self.origin) > 512)
    wait 0.05;

  wait(randomfloatrange(0.15, 1.0));

  if(!self istouching(e_ignore)) {
    self.ignoreall = 1;
    self.goalradius = 32;
    self setgoalpos(s_escape.origin);
    self pakistan_move_mode("run");
    self.moveplaybackrate = 0.6;
    self set_ignoreme(1);
  }
}

bus_wave_starts() {
  t_wave = get_ent("bus_street_wave_trigger", "targetname", 1);
  e_temp = spawn("script_origin", t_wave.origin);
  t_wave enablelinkto();
  t_wave linkto(e_temp);
  s_target = get_struct("bus_dam_temp_wave_struct", "targetname", 1);
  e_temp moveto(s_target.origin, 10);
  t_wave thread _wave_hits_player();
  t_wave thread _wave_hits_ai();
  t_wave thread _wave_hits_debris();
  e_temp waittill("movedone");
  t_wave unlink();
  e_temp delete();
}

_wave_hits_debris() {
  while(true) {
    self waittill("trigger", e_triggered);

    if(!isDefined(e_triggered.targetname) && !isDefined("bus_dam_wave_push_debris") || isDefined(e_triggered.targetname) && isDefined("bus_dam_wave_push_debris") && e_triggered.targetname == "bus_dam_wave_push_debris")
      e_triggered thread gopath();
  }
}

_wave_hits_ai() {
  v_launch_offset = vectorscale((0, 0, 1), 50.0);
  b_toggle = 0;

  while(true) {
    self waittill("trigger", e_triggered);
    b_is_ai = isai(e_triggered);
    b_is_enemy = isDefined(e_triggered.targetname) && issubstr(e_triggered.targetname, "bus_street");
    b_first_time = !isDefined(e_triggered.hit_by_wave);

    if(b_is_ai && b_is_enemy && b_first_time) {
      b_toggle = !b_toggle;
      e_triggered.hit_by_wave = 1;
      v_launch = vectornormalize(e_triggered.origin - self.origin) * 55 + v_launch_offset;
      e_triggered.animname = "generic";

      if(b_toggle)
        str_deathanim = "bus_wave_death_1";
      else
        str_deathanim = "bus_wave_death_2";

      e_triggered set_deathanim(str_deathanim);
      e_triggered dodamage(e_triggered.health + 1, e_triggered.origin, self);
    }
  }
}

copy_orientation(e_target) {
  self.origin = e_target.origin;

  if(isDefined(e_target.angles))
    self.angles = e_target.angles;
}

precache_dyn_ent_debris() {
  level.floating_dyn_ents = [];
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "com_junktire";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "afr_mort_walltable1_d";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p6_gas_container";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p6_street_vendor_water_jug";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p_glo_pot01";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p_jun_bowl_bucket";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p6_industrial_metal_can";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "dub_lounge_sofa_02";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "berlin_com_pallet";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p6_chair_wood_hotel";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "paris_tree_plane_small_branch1";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "afr_branch_fallen_01";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p_jun_foliage_pacific_branch_set1";
  level.floating_dyn_ents[level.floating_dyn_ents.size] = "p_jun_foliage_pacific_branch_set2";

  foreach(str_model in level.floating_dyn_ents)
  precachemodel(str_model);
}

harper_run_to_gate() {
  level endon("player_at_bus_gate");
  level.harper.scale_speed_in_water = 0;
  level.harper.moveplaybackrate = 1.0;
  level.harper pakistan_move_mode("cqb_sprint");
  level.harper set_cqb_run_anim( % ch_pakistan_3_3_hand_signals_run_harper, % ch_pakistan_3_3_hand_signals_run_harper, % ch_pakistan_3_3_hand_signals_run_harper);
  run_scene("bus_dam_harper_arrival");
  level thread maps\pakistan_anim::vo_call_to_gate();
  run_scene("bus_dam_harper_gate_idle");
  level.harper clear_cqb_run_anim();
}

_wave_hits_player() {
  level endon("bus_dam_gate_push_setup_started");
  self trigger_wait(undefined, undefined, level.player);
  level notify("bus_wave_hits_player");
  level thread clientnotify_delay("bus_wave_start", 0.65);
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  v_look = vectortoangles(vectornormalize(m_bus.origin - level.player.origin));
  t_anim_trigger = get_ent("player_escaped_bus_trigger", "targetname", 1);
  b_should_play_anim = 0;
  level notify("bus_dam_wave_at_player");

  if(b_should_play_anim) {
    level.player playsound("evt_wave_hit");
    level.player look_at(m_bus, 0.15, 1);
    level thread run_scene("bus_dam_wave_push_player");
    level.harper thread _bus_dam_warp_harper_in_front_of_player();
  }

  level.player setwaterdrops(50);
  wait 10;
  level.player setwaterdrops(0);
}

_bus_dam_warp_harper_in_front_of_player() {
  wait 0.5;
  s_warp = get_struct("bus_wave_harper_cheat_struct", "targetname", 1);
  self forceteleport(s_warp.origin, s_warp.angles);
}

bus_event_setup() {
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  t_bus_kill = get_ent("bus_dam_damage_trigger", "targetname", 1);
  t_bus_kill thread maps\pakistan_market::trigger_kill_ai_on_contact("bus_dam_start_done", m_bus);
  return m_bus;
}

bus_event_failure() {
  debug_print_line("fail path started");
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  t_bus_kill = get_ent("bus_dam_damage_trigger", "targetname", 1);
  t_bus_kill thread maps\pakistan_market::trigger_kill_ai_on_contact("bus_dam_done");
  setdvar("ui_deadquote", & "PAKISTAN_SHARED_BUS_FAIL");
  level thread bus_death_hud(level.player, 5.3);
  level thread run_scene("bus_dam_exit");
  wait 5.1;
  missionfailed();
  wait 100;
}

bus_event_success() {
  debug_print_line("bus dam success");
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  t_bus_kill = get_ent("bus_dam_damage_trigger", "targetname", 1);
  t_bus_kill thread maps\pakistan_market::trigger_kill_ai_on_contact("bus_dam_done");
  level.player maps\pakistan_market::set_player_invulerability(1);
  delay_thread(0.3, ::spawn_vehicles_from_targetname_and_drive, "bus_dam_success_debris");
  level thread run_scene("bus_dam_exit");
  level thread run_scene("bus_dam_gate_success_harper");
  run_scene("bus_dam_gate_success");
  wait 0.05;
  level.player setlowready(1);
  level notify("fxanim_rat_alley01_start");
  level.player maps\pakistan_market::set_player_invulerability(0);
  flag_set("bus_dam_done");
  autosave_by_name("pakistan_alley");
}

street_cleanup() {
  delete_exploder(240);
  clientnotify("cleanup_market_pillars");
  flag_wait("bus_dam_gate_push_setup_started");
  a_ai_enemies = getaiarray("axis");

  foreach(ai_enemy in a_ai_enemies)
  ai_enemy die();

  cleanupspawneddynents();
  clearallcorpses();
  maps\pakistan_util::delete_structs("frogger_dyn_ent_spawn_point", "targetname");
  maps\pakistan_util::delete_structs("frogger_debris_trigger_1", "script_noteworthy");
  maps\pakistan_util::delete_structs("frogger_debris_trigger_2", "script_noteworthy");
  cleanup_claws();
  flag_wait("bus_dam_gate_success_done");
  delete_scene_all("bus_dam_runners", 1, 0);
  delete_scene_all("bus_dam_idle", 1);
  delete_scene_all("bus_dam_wave_push_player", 1);
  maps\pakistan_util::delete_ents_inside_trigger("market_fxanim_cleanup_trig");
  maps\pakistan_util::delete_ents_inside_trigger("frogger_fxanim_cleanup_trig");
  vol_touching = getent("zone_intro", "targetname");
  vol_touching delete_fxanims_touching();
  vol_touching delete_ents_touching("script_model");
  vol_touching delete_ents_touching("trigger_box");
  vol_touching delete();
  a_s_market_exit = getstructarray("market_exit_struct", "script_noteworthy");

  foreach(s_exit in a_s_market_exit)
  s_exit structdelete();
}

cleanup_claws() {
  ai_claw_1 = getent("claw_1_ai", "targetname");
  ai_claw_2 = getent("claw_2_ai", "targetname");

  if(isDefined(ai_claw_1))
    ai_claw_1 stop_magic_bullet_shield();

  if(isDefined(ai_claw_2))
    ai_claw_2 stop_magic_bullet_shield();

  if(maps\pakistan_util::is_claw_flamethrower_unlocked() && isDefined(ai_claw_2) && isDefined(ai_claw_2.turret_flamethrower))
    ai_claw_2.turret_flamethrower delete();

  wait_network_frame();
  delete_ent_if_defined("claw_1_ai");
  delete_ent_if_defined("claw_2_ai");
}

ambient_alley_scenes() {
  flag_wait("zone_stealth_restored");
  run_scene_first_frame("slum_alley_dog_growl");
  level thread run_scene("alley_civilian_1");
  level thread run_scene("alley_civilian_2");
  level thread run_scene("alley_civilian_3");
  t_civilian_react = get_ent("alley_ambient_1", "targetname", 1);
  add_trigger_function(t_civilian_react, ::_ambient_civilian_group_1_react);
  trigger_wait("alley_ambient_start_trigger");
  level thread bad_dog();
  level thread run_scene("slum_alley_initial");
  trigger_wait("alley_ambient_corner_trigger");
  level thread run_scene("slum_alley_corner");
}

bad_dog() {
  level endon("corpse_alley_player_started");
  m_dog = get_model_or_models_from_scene("slum_alley_dog_growl", "alley_dog_2");
  m_dog.angles = vectorscale((0, 1, 0), 150.0);

  while(!flag("corpse_alley_player_started")) {
    level thread run_scene("slum_alley_dog_growl_loop");
    wait(randomintrange(4, 7));
    end_scene("slum_alley_dog_growl_loop");
    level thread run_scene("slum_alley_dog_bark_loop");
    wait(randomintrange(3, 4));
    end_scene("slum_alley_dog_bark_loop");
  }
}

_ambient_civilian_group_1_react() {
  level thread run_scene("alley_civilian_1_react");
  level thread run_scene("alley_civilian_2_react");
  level thread alley_civ_1_react_then_idle();
  level thread alley_civ_2_react_then_idle();
}

alley_civ_1_react_then_idle(ai_civilian) {
  level endon("alley_clean_up");
  debug_print_line("civ 1 reacts");
  scene_wait("alley_civilian_1_react");
  run_scene("alley_civilian_1");
}

alley_civ_2_react_then_idle(ai_civilian) {
  level endon("alley_clean_up");
  debug_print_line("civ 2 reacts");
  scene_wait("alley_civilian_2_react");
  run_scene("alley_civilian_2");
}

bus_dam() {
  level thread maps\pakistan_anim::vo_bus_dam();
  trigger_wait("bus_dam_start");
  m_bus_model = make_dam_bus();
  level.harper notify("stop_follow_path");
  level.harper pakistan_move_mode("cqb_sprint");
  level thread run_scene("bus_dam_runners");
  level thread harper_run_to_gate();
  m_bus_model thread monitor_bus_kill_player();
  flag_wait_any("bus_dam_start_done", "player_at_bus_gate");
  level thread street_cleanup();
  bus_dam_timeout = get_time_required_to_avoid_bus();
  m_bus_model thread play_audio_one_shot(bus_dam_timeout);
  flag_wait_or_timeout("player_at_bus_gate", bus_dam_timeout);
  level notify("fxanim_break_wall_crumble_start");
  level thread wall_crumble_timeout();

  if(!flag("player_at_bus_gate"))
    bus_event_failure();
  else {
    level.player playsound("evt_bus_gate_extra");

    if(bus_dam_strength_test()) {
      level thread load_gump("pakistan_gump_alley");
      level thread bus_event_success();
    } else
      bus_event_gate_failure();
  }
}

wall_crumble_timeout() {
  wait 5;
  level notify("fxanim_break_wall_crumble_start");
}

monitor_bus_kill_player() {
  level endon("player_at_bus_gate");

  while(true) {
    if(distance2d(level.player.origin, self.origin) < 128 || level.player istouching(self)) {
      setdvar("ui_deadquote", & "PAKISTAN_SHARED_BUS_FAIL");
      level thread bus_death_hud(level.player, 0.5);
      wait 0.2;
      missionfailed();
    }

    wait 0.1;
  }
}

make_dam_bus() {
  s_bus_spot = getstruct("bus_spawn_struct", "targetname");
  m_bus_model = spawn("script_model", s_bus_spot.origin);
  m_bus_model.angles = s_bus_spot.angles;
  m_bus_model.script_animname = "dam_bus";
  m_bus_model.targetname = "bus_dam_bus";
  m_bus_model setmodel("veh_t6_civ_bus_pakistan_sp");
  m_bus_model playsound("evt_bus_distant");
  m_bus_model hidepart("tag_window_side_11");
  m_bus_model hidepart("tag_window_side_9");
  s_bus_spot structdelete();
  return m_bus_model;
}

play_audio_one_shot(delay) {
  self playloopsound("evt_bus_idle_loop", 0.5);
  self thread bus_audio_watcher(delay);
  flag_wait("player_at_bus_gate");
  self notify("stop_bus_wait");
  level waittill("bus_sound_oneshot");
  self playsound("evt_bus_idle_build", "sounddone");
  self waittill("sounddone");
  self stoploopsound(1);
  wait 10;
  self delete();
}

bus_audio_watcher(delay) {
  self endon("stop_bus_wait");
  delay = delay - 4.1;

  if(delay > 0)
    wait(delay);

  self playsound("evt_bus_idle_build", "sounddone");
  self waittill("sounddone");
  self stoploopsound(1);
}

bus_event_gate_failure() {
  level thread run_scene("bus_dam_exit");
  level thread run_scene("bus_dam_gate_failure");
  level thread mission_fail(&"PAKISTAN_SHARED_GATE_PUSH_FAIL");
  level thread bus_death_hud(level.player, 0.5);
  wait 1.5;
  screen_fade_out(0.5);
}

bus_dam_strength_test() {
  level.player startcameratween(1);
  level thread run_scene("bus_dam_gate_push_setup");
  flag_wait("harper_to_gate");
  level.harper setgoalpos(level.harper.origin);
  level.harper waittill("goal");
  end_scene("bus_dam_harper_arrival");
  end_scene("bus_dam_harper_gate_idle");
  level thread run_scene("bus_dam_gate_push_setup_harper");
  flag_wait("bus_dam_gate_push_setup_done");
  level notify("bus_sound_oneshot");
  level thread _hack_screen_message();
  level thread bus_dam_button_mash();
  run_scene("bus_dam_gate_push_test");
  level notify("button_mash_done");
  screen_message_delete();
  return flag("player_survives_bus");
}

bus_dam_button_mash() {
  level endon("button_mash_done");
  flag_init("player_survives_bus");
  n_state_current = 0;
  n_state_last = 0;
  n_push_count = 0;

  while(true) {
    b_button_pressed_this_frame = _bus_dam_button_push_poll();

    if(b_button_pressed_this_frame) {
      if(n_state_last == 1 || n_state_last == 2)
        n_state = 2;
      else {
        n_state = 1;
        n_push_count++;
        debug_print_line("push count = " + n_push_count + " of " + 10);
      }
    } else
      n_state = 0;

    n_state_last = n_state;

    if(n_push_count >= 10) {
      flag_set("player_survives_bus");
      debug_print_line("success!");
      level notify("button_mash_done");
    }

    wait 0.05;
  }
}

_bus_dam_button_push_poll() {
  return level.player usebuttonpressed();
}

_hack_screen_message() {
  screen_message_create(&"PAKISTAN_SHARED_BUS_PUSH_F");
  level waittill("bus_dam_gate_push_test_done");
  screen_message_delete();
}

get_time_required_to_avoid_bus() {
  t_success = getent("player_escaped_bus_trigger", "targetname");
  n_distance_to_bus = 0;

  if(isDefined(t_success))
    n_distance_to_bus = distance(t_success.origin, level.player.origin);

  n_sprint_speed_units_per_sec = 120;
  n_bus_event_success_wait_max = n_distance_to_bus / (n_sprint_speed_units_per_sec * level.move_speed_scale);
  debug_print_line(n_bus_event_success_wait_max + " to get to alley");
  return n_bus_event_success_wait_max;
}

alley() {
  maps\createart\pakistan_art::alley();
  set_water_dvars_drone();
  level.player setlowready(1);
  level.harper pakistan_move_mode("cqb_walk");
  level.harper enable_ai_color();
  level thread ambient_alley_scenes();
  flag_wait("bus_dam_gate_success_harper_done");
  level.player setwaterdrops(10);
  level thread run_scene("alley_harper");
  level thread harper_colortrigger_alley();
  flag_wait("harper_to_sandbags");
  wait 0.5;
  trigger_use("trig_colors_to_sandbags");
  level thread harper_catchup_alley();
  level thread harper_lookat_player();
}

harper_colortrigger_alley() {
  level endon("harper_to_sandbags");
  scene_wait("alley_harper");
  trigger_use("trig_colors_after_bus");
}

harper_lookat_player() {
  flag_wait("harper_to_sandbags");
  wait 5;

  while(!flag("corpse_alley_player_started")) {
    level.harper lookatentity(level.player);
    wait(randomfloatrange(2.0, 4.0));
    level.harper lookatentity();
    wait(randomfloatrange(2.0, 4.0));
  }
}

harper_catchup_alley() {
  level endon("corpse_alley_player_started");
  flag_wait("harper_to_sandbags");

  if(!flag("alley_harper_done")) {
    level.harper maps\_anim::anim_set_blend_out_time(0.2);
    end_scene("alley_harper");
  }
}

alley_clean_up_civilians() {
  level notify("alley_clean_up");
  a_civs = get_ai_group_ai("alley_civilians");
  array_delete(a_civs);
}

corpse_alley_scene_setup() {
  level endon("corpse_alley_player_done");
  m_car = get_ent("corpse_alley_car", "targetname", 1);
}

corpse_alley_drone_fires_at_civ(vh_drone) {
  debug_print_line("drone fires at civ");
  level notify("drone_done_firing_at_civ");
}

make_floating_body(s_float_point) {
  self forceteleport(s_float_point.origin, s_float_point.angles);
  wait 0.1;
  self dodamage(self.health + 1, self.origin, self);
  self forcebuoyancy();
  self floatlonger();
}

frogger_start_spawning_dyn_ents() {
  level endon("frogger_done");
  a_s_spawn_points = getstructarray("frogger_dyn_ent_spawn_point", "targetname");

  while(true) {
    a_s_spawn_points safely_spawn_dynent();
    wait(randomintrange(8, 10));
  }
}

safely_spawn_dynent(v_force) {
  level endon("frogger_done");

  for(i = 0; i < self.size; i++) {
    if(level.player get_dot_direction(self[i].origin) >= 0.6 && distance2d(level.player.origin, self[i].origin) >= 512 && !level.player is_looking_at(self[i].origin, 0.99)) {
      self[i] launch_dynent(random(level.floating_dyn_ents), vectorscale((0, 0, 1), 0.1));
      break;
    }

    i++;
  }
}

launch_dynent(str_model, v_force) {
  if(str_model == "dub_lounge_sofa_02") {
    if(randomintrange(1, 5) > 1)
      str_model = random(level.floating_dyn_ents);
  }

  createdynentandlaunch(str_model, self.origin, self.angles, self.origin, v_force);
}

debris_vehicle() {
  self.takedamage = 0;
  nd_start = getvehiclenode(self.target, "targetname");
  str_model = find_debris_model(nd_start);
  assert(isDefined(str_model), "Debris vehicle path without a model.");
  m_debris = spawn_model(str_model, self.origin, self.angles, 1);
  m_debris linkto(self, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  m_debris thread _frogger_fx_play_on_object();
  m_debris thread debris_collision(self);

  if(!(!isDefined(self.script_noteworthy) && !isDefined("nofloat") || isDefined(self.script_noteworthy) && isDefined("nofloat") && self.script_noteworthy == "nofloat"))
    self thread toggle_float_anim();

  if(!(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths))
    self thread disconnect_debris_paths(m_debris);

  self waittill("death");

  if(!isDefined(self))
    m_debris delete();
}

disconnect_debris_paths(m_debris) {
  self endon("death");
  m_debris disconnectpaths();
  self waittill("start_vehiclepath");
  m_debris connectpaths();
  self waittill("reached_end_node");
  m_debris disconnectpaths();
}

#using_animtree("animated_props");

toggle_float_anim() {
  self useanimtree(#animtree);
  self.float_anim_rate = 0;

  while(true) {
    self thread debris_float();
    self waittill("settle");
    self thread debris_settle();
    self waittill("float");
  }
}

debris_float() {
  self endon("settle");
  n_delta = 0;
  n_start_rate = self.float_anim_rate;

  while(self.float_anim_rate < 1) {
    wait 0.05;
    n_delta = n_delta + 0.05;
    self.float_anim_rate = clamp(lerpfloat(n_start_rate, 1, n_delta / 2), 0, 1);
    self setanim( % o_pakistan_3_1_floating_debris, 1, 0, self.float_anim_rate);
  }
}

debris_settle() {
  self endon("float");
  n_delta = 0;
  n_start_rate = self.float_anim_rate;

  while(self.float_anim_rate > 0) {
    wait 0.05;
    n_delta = n_delta + 0.05;
    self.float_anim_rate = clamp(lerpfloat(n_start_rate, 0, n_delta / 2), 0, 1);
    self setanim( % o_pakistan_3_1_floating_debris, 1, 0, self.float_anim_rate);
  }
}

find_debris_model(node) {
  while(isDefined(node) && !isDefined(node.model)) {
    if(isDefined(node.target))
      node = getvehiclenode(node.target, "targetname");
    else
      break;
  }

  if(isDefined(node))
    return node.model;
}

_frogger_fx_play_on_object() {
  self setclientflag(3);

  if(self.model == "veh_iw_civ_car_hatch") {
    self play_fx("frogger_car_interior_light", undefined, undefined, undefined, 1, "origin_animate_jnt");
    self playloopsound("amb_debris_car_radio_loop");
  } else
    self playloopsound("amb_debris_car_loop");
}

_find_float_angles_offset(b_should_flip) {
  v_offset = (randomintrange(-8, 8), randomintrange(-8, 8), 0);

  if(b_should_flip)
    v_offset = v_offset + vectorscale((0, 0, 1), 180.0);

  return v_offset;
}

is_player_using_thumbstick() {
  b_using_thumbstick = 1;
  v_thumbstick = self getnormalizedmovement();

  if(length(v_thumbstick) < 0.3)
    b_using_thumbstick = 0;

  return b_using_thumbstick;
}

delete_at_spline_end() {
  self waittill("reached_end_node");

  if(isDefined(self.m_temp)) {
    self.m_temp clearclientflag(3);
    wait 0.1;

    if(isDefined(self.m_anim))
      self.m_anim delete();

    if(isDefined(self.m_temp))
      self.m_temp delete();
  }

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

debris_collision(vh_ent) {
  self endon("death");
  vh_ent endon("death");

  while(true) {
    self waittill("touch", e_touched);
    n_speed = vh_ent getspeedmph();
    b_should_damage = n_speed > 4;

    if(b_should_damage) {
      if(level.player istouching(self)) {
        debug_print_line("player_hit_by_frogger_debris");
        self setmovingplatformenabled(1);
        self frogger_debris_audio();

        if(!isDefined(level.player._last_collision_time))
          level.player._last_collision_time = 0;

        n_current_time_ms = gettime();

        if(n_current_time_ms - level.player._last_collision_time > 1000) {
          if(level.player.health < 20)
            setdvar("ui_deadquote", & "PAKISTAN_SHARED_FROGGER_FAIL");

          level.player dodamage(20, self.origin, self);
          level.player._last_collision_time = n_current_time_ms;
          flag_set_for_time(3, "player_hit_by_frogger_debris");
          level.player thread frogger_debris_collision_rumble(self);
        }
      } else if(isai(e_touched)) {
        if(e_touched is_hero()) {
          if(isDefined(e_touched.playing_custom_pain) && e_touched.playing_custom_pain) {
            e_touched animcustom(::frogger_debris_pain_react);
            self frogger_debris_audio();
          }
        } else
          e_touched ragdoll_death();
      }
    }
  }
}

frogger_debris_audio() {
  if(self.model == "p_glo_crate02" || self.model == "ch_crate48x64" || self.model == "furniture_cabinet_console_b")
    self playsound("fly_bump_wood");
  else if(self.model == "veh_iw_civ_car_hatch")
    self playsound("fly_bump_veh");
  else if(self.model == "furniture_couch_leather2_dust" || self.model == "dub_lounge_sofa_02")
    self playsound("fly_bump_couch");
  else if(self.model == "p6_chair_damaged_panama" || self.model == "berlin_furniture_chair1_dusty")
    self playsound("fly_bump_chair");
  else if(self.model == "me_refrigerator_d" || self.model == "machinery_washer_blue")
    self playsound("fly_bump_fridge");
  else
    self playsound("fly_bump_plr");
}

#using_animtree("generic_human");

frogger_debris_pain_react() {
  if(!isDefined(self.playing_custom_pain))
    self.playing_custom_pain = 0;

  if(!self.playing_custom_pain) {
    self.playing_custom_pain = 1;
    b_pain_enabled = self.allowpain;
    self disable_pain();
    self.takedamage = 0;
    anim_pain = self _get_best_frogger_pain_anim();
    e_temp = spawn("script_origin", self.origin);
    self linkto(e_temp);
    self setflaggedanimknoballrestart("pain_anim", anim_pain, % body, 1, 0.2, 1);
    self waittillmatch("pain_anim", "end");

    if(b_pain_enabled)
      self enable_pain();

    self.takedamage = 1;
    self unlink();
    e_temp delete();
    self.playing_custom_pain = undefined;
  }
}

_get_best_frogger_pain_anim() {
  anim_best = % exposed_pain_leg;
  return anim_best;
}

car_corner_crash_think(m_car) {
  m_car thread car_crash_corner_rumble();
  wait 3;
  m_corner_collision = getentarray("car_corner_crash_collision", "targetname");
  array_delete(m_corner_collision);
}

car_crash_corner_rumble() {
  wait 1;
  n_dist = distance2d(level.player.origin, self.origin);

  if(n_dist <= 768 / 2) {
    earthquake(randomfloatrange(0.13, 0.16), 1.5, self.origin, 768, level.player);
    level.player rumble_loop(3, 1.5 / 3, "damage_heavy");
  }

  if(n_dist > 768 / 2 && n_dist <= 768) {
    earthquake(randomfloatrange(0.06, 0.07), 1.5, self.origin, 768, level.player);
    level.player rumble_loop(3, 1.5 / 3, "damage_light");
  }
}

frogger_debris_collision_rumble(e_debris) {
  while(self istouching(e_debris)) {
    level.player viewkick(40, self.origin);
    level.player playrumbleonentity("damage_heavy");
    earthquake(0.3, 1, e_debris.origin, 1024, e_debris);
    self playrumbleonentity("damage_light");
    earthquake(0.1, 0.5, e_debris.origin, 1024, e_debris);
    wait 0.5;
  }
}

balcony_collapse_rumble() {
  wait 0.2;
  earthquake(0.07, 1, self.origin, 1000, self);
  self rumble_loop(3, 1 / 3, "damage_light");
  self rumble_loop(2, 0.5, "reload_clipout");
}

bus_dam_rumble() {
  level endon("bus_dam_exit_done");
  flag_wait("bus_dam_start_started");
  m_bus = get_ent("bus_dam_bus", "targetname", 1);
  self playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, self.origin, 1000, self);
  wait 1;
  self playrumbleonentity("damage_light");
  earthquake(0.05, 1, self.origin, 1000, self);
  earthquake(0.07, 11 / 2, self.origin, 1000, self);
  self rumble_loop(11 / 2, 0.5, "damage_light");
  wait 1;
  earthquake(0.1, 11 / 2, self.origin, 1000, self);
  self rumble_loop(11 / 2, 0.5, "damage_light");
  earthquake(0.12, 11 / 2, self.origin, 1000, self);
  self rumble_loop(2, 0.5, "damage_heavy");
  wait 1.1;
  earthquake(0.26, 11 / 2, self.origin, 1000, self);
  self rumble_loop(2, 0.5, "artillery_rumble");
  earthquake(0.19, 1, self.origin, 1000, self);
  self rumble_loop(3, 0.5, "damage_heavy");
  flag_wait("bus_dam_idle_started");
  self bus_dam_idle_rumble(0.5, m_bus);
  wait 1;
  self playrumbleonentity("artillery_rumble");
  earthquake(0.28, 1, self.origin, 1024, self);
  wait 1;
  self playrumbleonentity("artillery_rumble");
  earthquake(0.24, 1, self.origin, 1024, self);
  self playrumbleonentity("damage_heavy");
  earthquake(0.27, 1, self.origin, 1024, self);
  self playrumbleonentity("damage_heavy");
  earthquake(0.15, 1, self.origin, 1024, self);
  wait 1.5;
  self playrumbleonentity("damage_heavy");
  earthquake(0.2, 1, self.origin, 1024, self);
  wait 2;
  self playrumbleonentity("damage_heavy");
  earthquake(0.1, 1, m_bus.origin, 1024, self);
  wait 5.2;
  self playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, m_bus.origin, 1024, self);
  wait 0.25;
  self playrumbleonentity("damage_light");
  earthquake(0.05, 1, m_bus.origin, 1024, self);
  wait 0.1;
  self playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, m_bus.origin, 1024, self);
  wait 1;
  self playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, self.origin, 1024, self);
}

bus_dam_idle_rumble(n_waittime, e_origin) {
  level endon("bus_dam_exit_started");
  level endon("bus_dam_gate_success_started");

  while(true) {
    self playrumbleonentity("damage_light");

    if(isDefined(e_origin))
      earthquake(0.05, n_waittime / 2, e_origin.origin, 1024, self);

    wait(n_waittime / 2);
  }
}

bus_death_hud(player, n_delay) {
  wait(n_delay);
  overlay = newclienthudelem(player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("hud_pak_bus", 90, 60);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}