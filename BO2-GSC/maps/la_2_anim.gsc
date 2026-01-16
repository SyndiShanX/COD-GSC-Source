/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_anim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_scene;
#include maps\_dialog;
#include maps\_anim;
#include maps\la_utility;
#include maps\voice\voice_la_2;
#include maps\createart\la_2_art;
#include maps\la_2_player_f35;
#include maps\la_2_drones_ambient;
#include maps\la_2_fly;
#include maps\la_2_ground;
#include maps\la_2_anim;

main() {
  harper_wakeup();
  anderson_f35_exit();
  pilot_drag_setup();
  pilot_drag_van_setup();
  pilot_drag();
  pilot_drag_van_idle();
  f35_get_in();
  f35_startup();
  ai_anims();
  harper_fires_from_van();
  f35_mode_switch();
  f35_eject();
  f35_eject_manual();
  midair_collision();
  f35_outro();
  precache_assets();
  maps\voice\voice_la_2::init_voice();
  init_vo();
  init_drone_anims();
}

#using_animtree("fakeshooters");

init_drone_anims() {
  level.drones.anims["throw_molotov"] = % stand_grenade_throw;
}

#using_animtree("generic_human");

harper_wakeup() {
  add_scene("harper_wakes_up", "anim_align_stadium_intersection");
  add_actor_anim("harper", % ch_la_08_01_standup_harper);
}

#using_animtree("vehicles");

anderson_f35_exit() {
  add_scene("anderson_f35_exit", "anim_align_stadium_intersection");
  add_actor_anim("f35_pilot", % ch_la_08_01_save_anderson_anderson_fall, 1, 0, 0, 0);
  add_vehicle_anim("f35", % v_la_08_01_save_anderson_f35);
}

#using_animtree("generic_human");

pilot_drag_setup() {
  add_scene("pilot_drag_setup", "anim_align_stadium_intersection", 0, 0, 1);
  add_actor_anim("f35_pilot", % ch_la_08_01_save_anderson_anderson_loop, 1, 0, 0, 0);
}

#using_animtree("vehicles");

pilot_drag_van_setup() {
  str_scene_name = "pilot_drag_van_setup";
  str_align_targetname = "anim_align_stadium_intersection";
  b_do_reach = 0;
  b_do_generic = 0;
  b_do_loop = 1;
  b_do_not_align = 0;
  add_scene(str_scene_name, str_align_targetname, b_do_reach, b_do_generic, b_do_loop, b_do_not_align);
  add_vehicle_anim("convoy_van", % v_la_08_01_save_anderson_ambulance);
}

#using_animtree("generic_human");
#using_animtree("vehicles");

pilot_drag() {
  add_scene("pilot_drag_harper", "anim_align_stadium_intersection", 1);
  add_actor_anim("harper", % ch_la_08_01_save_anderson_harper);
  add_scene("pilot_drag_harper_idle", "anim_align_stadium_intersection", 0, 0, 1);
  add_actor_anim("harper", % ch_la_08_01_save_anderson_harper_loop);
  add_scene("pilot_drag", "anim_align_stadium_intersection");
  add_actor_anim("f35_pilot", % ch_la_08_01_save_anderson_anderson, 1, 0, 0, 0);
  add_actor_anim("intro_medic_1", % ch_la_08_01_save_anderson_driver1, 1, 0, 0, 0);
  add_actor_anim("intro_medic_2", % ch_la_08_01_save_anderson_driver2, 1, 0, 0, 0);
  add_vehicle_anim("convoy_van", % v_la_08_01_save_anderson_ambulance);
}

pilot_drag_van_idle() {
  str_scene_name = "pilot_drag_van_idle";
  str_align_targetname = "anim_align_stadium_intersection";
  b_do_reach = 0;
  b_do_generic = 0;
  b_do_loop = 1;
  b_do_not_align = 0;
  b_hide_weapon = 0;
  b_giveback_weapon = 1;
  b_do_delete = 0;
  b_no_death = 1;
  str_tag = undefined;
  b_hide_weapon = 0;
  b_giveback_weapon = 1;
  b_do_delete = 0;
  b_no_death = 1;
  str_tag = undefined;
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("vehicles");

f35_get_in() {
  add_scene("F35_get_in", "F35");
  b_do_delete = 0;
  n_player_number = 0;
  str_tag = "tag_driver";
  b_do_delta = 0;
  n_view_fraction = 100;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 30;
  n_bottom_arc = 30;
  b_use_tag_angles = 1;
  b_center_camera = 1;
  add_player_anim("player_body", % ch_la_08_02_f35enter_player, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles, b_center_camera);
  add_notetrack_custom_function("player_body", "helmet_on", ::player_puts_on_helmet);
  add_notetrack_custom_function("player_body", "dof_players_hand", maps\createart\la_2_art::enter_jet_players_hand);
  add_notetrack_custom_function("player_body", "dof_cockpit", maps\createart\la_2_art::enter_jet_cockpit);
  add_notetrack_custom_function("player_body", "dof_hud", maps\createart\la_2_art::enter_jet_hud);
  str_model = "p6_anim_f35_helmet";
  b_do_delete = 1;
  b_is_simple_prop = 0;
  a_parts = undefined;
  str_tag = "tag_origin";
  add_prop_anim("F35_helmet", % o_la_08_02_f35enter_helmet, str_model, b_do_delete, b_is_simple_prop, a_parts, str_tag);
  add_scene("F35_get_in_vehicle", "anim_intro_jet_struct");
  add_vehicle_anim("F35", % v_la_08_02_f35enter_f35, undefined, undefined, undefined, 1);
}

player_puts_on_helmet(e_player_body) {
  clientnotify("player_put_on_helmet");
  level.player visionsetnaked("helmet_f35_low", 0.5);
  level thread f35_hide_outer_model_parts(1, 0.25);
  screen_fade_out(0.25);
  luinotifyevent(&"hud_update_vehicle_custom", 2, 1, & "plane_f35_player_vtol");
  stop_exploder(102);
  exploder(103);
  screen_fade_in(0.25);
}

sndcanopyclose(guy) {
  level clientnotify("start_f35_snap");
}

f35_hide_outer_model_parts(hide, delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  str_parts = [];
  str_parts[str_parts.size] = "tag_exterior";
  str_parts[str_parts.size] = "tag_engine_base_left";
  str_parts[str_parts.size] = "tag_engine_base_right";
  str_parts[str_parts.size] = "tag_engine_outer_cover_right";
  str_parts[str_parts.size] = "tag_engine_inner_cover_right";
  str_parts[str_parts.size] = "tag_engine_outer_cover_left";
  str_parts[str_parts.size] = "tag_engine_inner_cover_left";
  str_parts[str_parts.size] = "tag_side_vent_right";
  str_parts[str_parts.size] = "tag_side_vent_left";
  str_parts[str_parts.size] = "tag_landing_gear_doors";
  str_parts[str_parts.size] = "tag_landing_gear_down";
  str_parts[str_parts.size] = "tag_ladder";

  for(i = 0; i < str_parts.size; i++) {
    if(hide) {
      level.f35 hidepart(str_parts[i], level.f35.model);
      continue;
    }

    level.f35 showpart(str_parts[i], level.f35.model);
  }
}

#using_animtree("player");
#using_animtree("vehicles");

f35_startup() {
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = "tag_driver";
  b_do_delta = 0;
  n_view_fraction = 100;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 30;
  n_bottom_arc = 30;
  b_use_tag_angles = 1;
  b_auto_center = 1;
  add_scene("F35_startup", "F35");
  add_player_anim("player_body", % ch_la_08_02_f35enter_startup_player, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles, b_auto_center);
  add_notetrack_custom_function("player_body", "touch_hud", maps\la_2_player_f35::f35_startup_console);
  add_notetrack_custom_function("player_body", "sndCanopyClose", ::sndcanopyclose);
  add_scene("F35_startup_vehicle", "anim_intro_jet_struct");
  add_vehicle_anim("F35", % v_la_08_02_f35enter_startup_f35, undefined, undefined, undefined, 1);
}

#using_animtree("generic_human");

harper_fires_from_van() {
  level.scr_anim["harper"]["harper_fires_out_window"][0] = % ch_la_09_01_harpershooting_harper;
}

#using_animtree("player");

f35_mode_switch() {
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = "tag_driver";
  b_do_delta = 0;
  n_view_fraction = 100;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 30;
  n_bottom_arc = 30;
  b_use_tag_angles = 1;
  b_auto_center = 1;
  add_scene("F35_mode_switch", "F35");
  add_player_anim("player_body", % ch_la_09_05_flightmode_switch_player, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles, b_auto_center);
  level.scr_model["player_body"] = level.player_interactive_model;
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["F35_mode_switch"] = % ch_la_09_05_flightmode_switch_player;
  addnotetrack_customfunction("player_body", "touch_hud", ::notify_mode_switch, "F35_mode_switch");
}

notify_mode_switch(e_guy) {
  wait 0.5;
  level.f35 notify("f35_switch_modes_now");
}

#using_animtree("vehicles");

f35_eject() {
  add_scene("f35_eject_drone_intro");
  add_vehicle_anim("eject_sequence_drone", % v_la_10_01_f35eject_drone_intro);
  add_scene("F35_eject");
  add_vehicle_anim("eject_sequence_drone", % v_la_10_01_f35eject_start_drone);
}

#using_animtree("player");

f35_eject_manual() {
  level.scr_model["player_body"] = level.player_interactive_model;
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["f35_eject_start"] = % ch_la_10_01_f35eject_start_player;
}

#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("vehicles");

midair_collision() {
  add_scene("midair_collision", "anim_end_struct");
  b_do_delete = 0;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 0;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 30;
  n_bottom_arc = 30;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % ch_la_10_01_f35eject_player, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_notetrack_custom_function("player_body", "eject", ::f35_eject_notetrack_eject);
  add_notetrack_custom_function("player_body", "eject", ::f35_eject_notify_start);
  add_notetrack_custom_function("player_body", "explosion", ::f35_eject_notetrack_explosion);
  add_notetrack_custom_function("player_body", "chute", ::f35_eject_notetrack_chute_opens);
  add_notetrack_custom_function("player_body", "hit_building", ::f35_eject_notetrack_hit_building);
  add_notetrack_custom_function("player_body", "hit_ground", ::f35_eject_notetrack_hit_ground);
  add_notetrack_custom_function("player_body", "start_jets_animation", ::f35_eject_notetrack_start_jets);
  add_notetrack_custom_function("player_body", "body_impact", ::f35_eject_notetrack_body_impact);
  add_vehicle_anim("F35", % v_la_10_01_f35eject_f35, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0);
  add_notetrack_custom_function("F35", "collide", ::midair_collision_notetrack);
  add_notetrack_custom_function("player_body", "dof_eject", maps\createart\la_2_art::crash_eject);
  add_notetrack_custom_function("player_body", "dof_chute", maps\createart\la_2_art::crash_chute);
  add_notetrack_custom_function("player_body", "dof_city", maps\createart\la_2_art::crash_city);
  add_notetrack_custom_function("player_body", "dof_hit_building", maps\createart\la_2_art::crash_hit_building);
  add_notetrack_custom_function("player_body", "dof_land", maps\createart\la_2_art::crash_land);
  str_model = undefined;
  b_do_delete = 1;
  b_is_simple_prop = 0;
  a_parts = undefined;
  str_tag = undefined;
  add_prop_anim("f35_eject_parachute", % o_la_10_01_f35eject_parachute, str_model, b_do_delete, b_is_simple_prop, a_parts, str_tag);
  add_scene("midair_collision_amb_jets", "anim_end_struct");
  add_vehicle_anim("f35_2", % v_la_10_01_f35_2, 1, undefined, undefined, undefined, "plane_f35_player_vtol");
  add_vehicle_anim("f35_3", % v_la_10_01_f35_3, 1, undefined, undefined, undefined, "plane_f35_player_vtol");
  add_vehicle_anim("f35_4", % v_la_10_01_f35_4, 1, undefined, undefined, undefined, "plane_f35_player_vtol");
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");

f35_outro() {
  add_scene("outro_hero", "anim_end_struct");
  add_actor_anim("harper", % ch_la_10_02_promnight_harper, 1, 0, 0, 1);
  add_player_anim("player_body", % ch_la_10_02_promnight_player, 0, 0, undefined, 0, 0, 30, 30, 30, 30, 1);
  add_notetrack_custom_function("player_body", "start_fadeout", ::level_end);
  add_notetrack_custom_function("player_body", "dof_convoy", maps\createart\la_2_art::outro_convoy);
  add_notetrack_custom_function("player_body", "dof_president", maps\createart\la_2_art::outro_harper);
  add_notetrack_custom_function("player_body", "dof_president", maps\createart\la_2_art::outro_president);
  add_notetrack_custom_function("player_body", "dof_door", maps\createart\la_2_art::outro_door);
  add_vehicle_anim("convoy_potus_cougar", % v_la_10_02_promnight_cougar);
  add_prop_anim("convoy_van_prop", % v_la_10_02_promnight_van, "veh_iw_civ_ambulance");
  add_scene("outro_g20_1", "anim_end_struct");
  add_vehicle_anim("convoy_g20_1", % v_la_10_02_promnight_cougar02);
  add_scene("outro_g20_2", "anim_end_struct");
  add_vehicle_anim("convoy_g20_2", % v_la_10_02_promnight_cougar03);
  add_scene("outro_hero_noharper", "anim_end_struct");
  add_actor_anim("sam", % ch_la_10_02_promnightsam_sam, 1, 0, 0, 1);
  add_player_anim("player_body", % ch_la_10_02_promnightsam_player, 0, 0, undefined, 0, 0, 30, 30, 30, 30, 1);
  add_notetrack_custom_function("player_body", "start_fadeout", ::level_end);
  add_notetrack_custom_function("player_body", "dof_convoy", maps\createart\la_2_art::outro_convoy);
  add_notetrack_custom_function("player_body", "dof_president", maps\createart\la_2_art::outro_harper);
  add_notetrack_custom_function("player_body", "dof_president", maps\createart\la_2_art::outro_president);
  add_notetrack_custom_function("player_body", "dof_door", maps\createart\la_2_art::outro_door);
  add_vehicle_anim("convoy_potus_cougar", % v_la_10_02_promnightsam_cougar);
  add_scene("outro_g20_1_noharper", "anim_end_struct");
  add_vehicle_anim("convoy_g20_1", % v_la_10_02_promnightsam_cougar02);
  add_scene("outro_g20_2_noharper", "anim_end_struct");
  add_vehicle_anim("convoy_g20_2", % v_la_10_02_promnightsam_cougar03);
}

#using_animtree("generic_human");

ai_anims() {
  level.scr_anim["intro_guy"]["intro_death_1"] = % ch_la_08_01_longdeath_ter1;
  level.scr_anim["intro_guy"]["intro_death_2"] = % ch_la_08_01_longdeath_ter2;
  level.scr_anim["intro_guy"]["intro_death_3"] = % ch_la_08_01_longdeath_ter3;
  level.scr_anim["intro_guy"]["intro_death_4"] = % ch_la_08_01_longdeath_ter4;
  level.scr_anim["intro_guy"]["intro_death_5"] = % ch_la_08_01_longdeath_ter5;
  level.scr_anim["intro_guy"]["intro_death_6"] = % ch_la_08_01_longdeath_ter6;
}

#using_animtree("player");

player_anims() {
  level.scr_model["player_body"] = level.player_interactive_model;
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["f35_get_in"] = % ch_la_08_02_f35enter_player;
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_animtree["f35"] = #animtree;
  level.scr_anim["f35"]["f35_get_in"] = % v_la_08_02_f35enter_f35;
}

#using_animtree("animated_props");

object_anims() {
  level.scr_animtree["f35_helmet"] = #animtree;
  level.scr_model["f35_helmet"] = "tag_origin_animate";
  level.scr_anim["f35_helmet"]["f35_get_in"] = % o_la_08_02_f35enter_helmet;
}

level_end(guy) {
  nextmission();
}

midair_collision_notetrack(guy) {
}

f35_eject_notify_start(e_player_body) {
  clientnotify("stop_f35_snap");
}

f35_eject_notetrack_eject(e_player_body) {
  level thread f35_hide_outer_model_parts(0, undefined);
  maps\la_2_player_f35::f35_remove_visor();
  vh_drone = get_ent("eject_sequence_drone", "targetname", 1);
  vh_drone setmodel("veh_t6_drone_avenger");
  flag_set("ejection_start");
  level thread f35_start_flybys();
  n_earthquake_magnitude = 0.3;
  n_earthquake_duration = 0.6;
  str_rumble = "damage_heavy";
  n_rumble_count = 3;
  n_loop_time = 0.2;
  earthquake(n_earthquake_magnitude, n_earthquake_duration, level.player.origin, 512, level.player);
  level.player thread rumble_loop(n_rumble_count, n_loop_time, str_rumble);
}

f35_start_flybys() {
  wait 0.05;
  level maps\la_2_drones_ambient::cleanup_ambient_drones(75, 1, 1.1);
  vehicles = getvehiclearray();

  for(i = 0; i < vehicles.size; i++) {
    if(vehicles[i].vehicleclass == "plane" && (vehicles[i].vehicletype == "drone_pegasus_low_la2" || vehicles[i].vehicletype == "plane_f35_low" || vehicles[i].vehicletype == "civ_police_la2" || vehicles[i].vehicletype == "plane_f35_fast_la2"))
      vehicles[i] delete();
  }

  wait 0.05;
  trigger_use("trig_eject_parachute_flyby_1");
  trigger_use("trig_eject_parachute_flyby_2");
  trigger_use("trig_eject_parachute_flyby_3");
  trigger_use("trig_eject_parachute_flyby_4");
  level thread f35_end_flybys();
}

f35_end_flybys() {
  wait 5;
  trigger_use("trig_kill_parachute_flyby_3");
  trigger_use("trig_kill_parachute_flyby_4");
}

f35_eject_notetrack_explosion(e_player_body) {
  n_earthquake_magnitude = 0.3;
  n_earthquake_duration = 1;
  str_rumble = "damage_heavy";
  n_rumble_count = 4;
  n_loop_time = 0.25;
  vh_drone = get_ent("eject_sequence_drone", "targetname", 1);
  level.f35 notify("midair_collision");
  playfx(level._effect["midair_collision_explosion"], level.f35.origin, anglestoforward(level.f35.angles));
  earthquake(n_earthquake_magnitude, n_earthquake_duration, level.player.origin, 512, level.player);
  level.player thread rumble_loop(n_rumble_count, n_loop_time, str_rumble);
  wait 0.1;
  level.f35.delete_on_death = 1;
  level.f35 notify("death");

  if(!isalive(level.f35))
    level.f35 delete();

  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

f35_eject_notetrack_hit_ground(e_player_body) {
  str_rumble = "damage_heavy";
  n_rumble_count = 5;
  n_loop_time = 0.2;
  level.player thread rumble_loop(n_rumble_count, n_loop_time, str_rumble);
  playfxontag(level._effect["eject_hit_ground"], e_player_body, "J_SpineLower");
  wait 1;
  level thread maps\la_2_fly::spawn_convoy_f35_allies("start_eject_landed_flyby", 4, 1, 1, 0);
}

f35_eject_notetrack_start_jets(e_player_body) {
  level thread run_scene("midair_collision_amb_jets");
  wait 1;
}

f35_eject_notetrack_chute_opens(e_player_body) {
  str_rumble = "damage_heavy";
  n_rumble_count = 3;
  n_loop_time = 0.2;
  level.player thread rumble_loop(n_rumble_count, n_loop_time, str_rumble);
}

f35_eject_notetrack_hit_building(e_player_body) {
  playfxontag(level._effect["eject_building_hit"], e_player_body, "tag_origin");
  str_rumble = "damage_heavy";
  n_rumble_count = 5;
  n_loop_time = 0.2;
  level.player thread rumble_loop(n_rumble_count, n_loop_time, str_rumble);
}

f35_eject_notetrack_body_impact(e_player_body) {
}

init_vo() {
  add_dialog("convoy_death", "We lost a vehicle! What are you doing, Mason?!");
  add_dialog("protect_convoy_nag_1", "Mason, the convoy is under fire! Get to our position!");
  add_dialog("protect_convoy_nag_2", "Mason, where are you? Cover us!");
  add_dialog("convoy_damage_nag_1", "The convoy is taking fire!");
  add_dialog("convoy_damage_nag_2", "Mason, support! We're under fire!");
  add_dialog("convoy_damage_nag_3", "Convoy needs support!");
  add_dialog("convoy_damage_nag_4", "Protect the convoy!");
  add_dialog("convoy_damage_nag_5", "Defend the Cougars, Mason!");
  add_dialog("convoy_damage_nag_6", "Convoy is taking heavy fire! Support NOW!");
  add_dialog("meet_convoy", "Alright Mason, fly out of the debris and meet up with the convoy");
  add_dialog("convoy_sitrep", "The Presidential convoy has been under fire. We need to get them to Prom Night.");
  add_dialog("F35_dogfight_distance_warning", "Warning: leaving combat area.");
}

vo_rooftops() {
  level endon("convoy_at_dogfight");
  vh_van = level.convoy.vh_van;
  e_player = level.player;
  level waittill("enemy_trucks_crash_through_barrier");
  wait 4;
  e_player thread say_dialog("shit_enemy_trucks_020");
  e_player thread say_dialog("keep_moving_go_021", 3.5);

  if(!flag("harper_dead"))
    vh_van thread say_dialog("bastards_are_every_009", 8);
  else
    vh_van thread say_dialog("samu_you_gotta_keep_them_0", 8);

  flag_wait("convoy_at_apartment_building");
  wait 12;

  if(!flag("harper_dead")) {
    e_player thread say_dialog("helicopter_above_t_009");
    e_player thread say_dialog("fuck__those_big_r_011", 3.5);
    e_player thread say_dialog("get_off_8th_h_turn_007", 6.0);
    e_player thread say_dialog("harp_dammit_section_it_0", 8.0);
    e_player thread say_dialog("were_taking_fire_058", 11.5);
  } else {
    e_player thread say_dialog("samu_enemy_big_rigs_end_0", 3.5);
    e_player thread say_dialog("get_off_8th_h_turn_007", 6.0);
    e_player thread say_dialog("samu_we_re_taking_fire_fr_0", 9.5);
  }
}

vo_truck_group_1_dead() {
  level endon("enemy_trucks_crash_through_barrier");
  flag_wait("hotel_street_truck_group_1_spawned");
  a_trucks = get_ent_array("hotel_street_truck_group_1", "targetname");
  array_wait(a_trucks, "death");
  e_harper = level.convoy.vh_van;
  e_player = level.player;

  if(!flag("harper_dead"))
    e_harper thread say_dialog("harp_nice_work_section_1", 2);
}

vo_after_parking_structure() {
  e_harper = level.convoy.vh_van;
  e_player = level.player;
  e_hillary = level.convoy.vh_potus;
  kill_all_pending_dialog(e_harper);
  kill_all_pending_dialog(e_player);
  e_player thread say_dialog("we_got_enemy_gunsh_012");
  e_player thread say_dialog("keep_moving_013", 2);
  e_player thread say_dialog("its_too_hot_h_tur_017", 5);
  wait 3;
  level.f35 say_dialog("thruster_repair_co_061");
}

vo_ground_air_transition() {
  e_player = level.player;
  e_hillary = level.convoy.vh_potus;
  e_harper = level.convoy.vh_van;
  level thread maps\la_2_ground::pip_start("la_pip_seq_4");
  e_hillary say_dialog("samu_section_we_re_trac_0", 1);
  level.player say_dialog("sect_i_ll_handle_the_dron_0");
  level.player say_dialog("sect_put_anderson_on_comm_0");

  if(flag("F35_pilot_saved")) {
    level.player say_dialog("sect_anderson_i_need_to_0", 2);
    e_harper say_dialog("ande_okay_uploading_th_0");
    level.player say_dialog("f38c_sky_buster_online_0");
  } else {
    e_harper say_dialog("samu_i_m_sorry_section_0");
    level.player say_dialog("damn_050");
    level.player say_dialog("f38c_sky_buster_offline_0");
  }
}

vo_dogfight_f35() {
  flag_wait("dogfights_story_done");
}

vo_roadblock() {
  e_harper = level.convoy.vh_van;
  e_player = level.player;
  wait 7;
  e_harper thread say_dialog("septic_h_the_presi_039");
  wait 5;
  add_vo_to_nag_group("roadblock_nag", e_harper, "get_some_fire_on_t_040");
  add_vo_to_nag_group("roadblock_nag", e_harper, "come_on_septic_041");
  add_vo_to_nag_group("roadblock_nag", e_harper, "tear_?em_up_042");
  level thread start_vo_nag_group_flag("roadblock_nag", "ground_targets_done", 6);
  flag_wait("ground_targets_done");
  delete_vo_nag_group("roadblock_nag");
  e_harper thread say_dialog("harper__roads_cl_044");
}

vo_convoy_damage_nag() {
  self notify("_convoy_nag_end");
  self endon("_convoy_nag_end");
  n_nag_line_frequency = 5;
  e_harper = level.convoy.vh_van;

  while(true) {
    self waittill("damage");
    n_index = randomintrange(1, 6);
    e_harper thread say_dialog("convoy_damage_nag_" + n_index);
    wait(n_nag_line_frequency);
  }
}

vo_pip_pacing() {
  vh_potus = level.convoy.vh_potus;
  e_mason = level.player;
  vh_van = level.convoy.vh_van;
  vh_potus say_dialog("samu_the_pmcs_are_floodin_0");
  level.player thread say_dialog("sect_samuels_i_ve_secur_0");
  level.player thread say_dialog("sect_i_m_tracking_your_lo_0", 4);
  flag_waitopen("pip_playing");
  flag_set("pip_intro_done");

  if(!flag("harper_dead"))
    vh_van say_dialog("shit_its_a_fuc_018", 1);
  else
    vh_van say_dialog("samu_the_attack_devastate_0", 1);

  flag_wait("convoy_can_move");
  wait 1;

  if(!flag("harper_dead")) {
    e_mason say_dialog("harper_h_make_a_le_016");
    vh_van say_dialog("got_it_017", 1.5);
    vh_van say_dialog("harp_mercs_moving_in_0", 2);
    wait 2;
    vh_van thread say_dialog("harp_the_helicopter_sect_0");
  } else {
    e_mason say_dialog("left__go_left_053");
    vh_van say_dialog("samu_roger_that_0", 1.5);
  }

  delay_thread(6, ::vo_truck_group_1_dead);
}

vo_pacing() {
  vh_van = level.convoy.vh_van;
  e_player = level.player;
  wait 3;

  if(!flag("harper_dead")) {
    vh_van thread say_dialog("harp_looks_like_more_trou_0");
    vh_van thread say_dialog("which_way__which_052", 2);
    e_player thread say_dialog("left__go_left_053", 5);
  } else {
    vh_van thread say_dialog("samu_we_got_enemies_dead_0");
    vh_van thread say_dialog("samu_which_way_section_0", 2);
    e_player thread say_dialog("left__go_left_053", 5);
  }
}

vo_convoy_distance_check_nag() {
  level endon("death");
  level notify("vo_convoy_distance_check_nag_stop");
  level endon("vo_convoy_distance_check_nag_stop");
  wait 15;
  e_player = level.player;
  vh_van = level.convoy.vh_van;

  while(true) {
    flag_waitopen("player_in_range_of_convoy");
    array_notify(level.convoy.vehicles, "convoy_stop");
    n_line_choice = randomint(2);

    if(!flag("convoy_nag_override")) {
      if(!flag("harper_dead")) {
        if(n_line_choice == 0)
          vh_van thread say_dialog("take_the_heat_off_009");
        else
          vh_van thread say_dialog("harp_where_are_you_secti_0");
      } else if(n_line_choice == 0)
        vh_van thread say_dialog("samu_dammit_we_re_under_0");
      else
        vh_van thread say_dialog("samu_where_are_you_secti_0");
    }

    wait 15;
  }
}

vo_f35_startup() {
  if(!flag("harper_dead")) {
    vh_f35 = level.f35;
    e_harper = level.convoy.vh_van;
    ai_harper = get_ent("harper_ai", "targetname");
    kill_all_pending_dialog(level.player);
    kill_all_pending_dialog(e_harper);

    if(isDefined(ai_harper)) {
      kill_all_pending_dialog(ai_harper);
      e_harper = ai_harper;
    }

    e_harper say_dialog("harp_ever_fly_one_of_thes_0");
    level.player say_dialog("no___012");
    e_harper say_dialog("harp_well_you_re_gonna_fl_0");
    e_harper say_dialog("the_flight_compute_013");
    e_harper say_dialog("harp_i_ll_take_the_ambula_0");
    e_harper say_dialog("harp_stay_on_me_and_we_ll_0");
    e_harper thread delete_harper();
  }

  level notify("harper_dialogue_complete");
  flag_wait("F35_startup_started");

  if(flag("harper_dead")) {
    level.player say_dialog("identify_h_mason_016");
    level.player say_dialog("authorization_acce_017");
    level.player say_dialog("controls_navigati_019");
  } else {
    level.player say_dialog("identify_h_mason_016");
    level.player say_dialog("authorization_acce_017");
  }

  if(flag("F35_pilot_saved")) {
  } else {
  }
}

delete_harper() {
  wait 5;
  self delete();
}

vo_f35_startup_player() {
  wait 2;
  self thread say_dialog("engines_on_027");
}

vo_f35_startup_harper() {
  e_harper = level.convoy.vh_van;
  e_player = level.player;
}

vo_f35_startup_f35() {
  e_player = level.player;
  vh_f35 = level.f35;
}

vo_f35_boarding() {
  level endon("player_flying");
  level endon("player_in_f35");
  wait 6;

  if(!flag("harper_dead")) {
    e_harper = get_ent("harper_ai", "targetname", 1);
    e_harper say_dialog("holy_shit_004");
    e_harper say_dialog("you_okay_005", 3);
    level.player say_dialog("yeah_006", 1);
    e_harper say_dialog("andersons_f/a38_007", 4);
    level.player say_dialog("sect_shit_anderson_s_0", 0.5);
    flag_wait("start_anderson_f35_exit");
    e_harper say_dialog("harp_least_she_s_still_in_0", 2);
    level.player say_dialog("sect_get_her_to_safety_0", 6);
  } else {
    wait 3;
    level.player say_dialog("sect_shit_anderson_s_0");
    trigger_wait("trig_harper_dead_vo");
    level.player say_dialog("anderson_008");
    trigger_wait("trig_harper_dead_vo_2");
    level.player say_dialog("sect_get_her_to_safety_0");
  }
}

vo_trenchruns() {
  e_harper = level.convoy.vh_van;
  e_player = level.player;
  vh_f35 = level.f35;
  e_harper thread say_dialog("were_not_out_of_t_068", 1);
  e_harper thread say_dialog("why_are_they_comin_069", 4);
  e_player thread say_dialog("fuck_theyre_th_070", 6);
  e_player thread say_dialog("shit_theyre_fast_072", 9);
  flag_wait("convoy_at_trenchrun_turn_2");
  e_player thread say_dialog("damn_that_was_to_073");
  flag_wait("convoy_at_trenchrun_turn_3");
  e_harper thread say_dialog("keep_them_off_us_074");
}

vo_no_guns() {
  vh_f35 = level.f35;
  vh_f35 say_dialog("ammunition_supplie_075");
  vh_f35 say_dialog("lock_acquired_plo_079");
  vh_f35 say_dialog("eject__eject__ej_080");
}

vo_eject() {
  e_player = level.player;
  vh_van = level.convoy.vh_van;
  level notify("player_ejected");
  level thread maps\la_2_anim::vo_no_guns();
  level.player say_dialog("shit_076");

  if(!flag("harper_dead"))
    vh_van say_dialog("harp_what_are_you_doing_0");
  else
    vh_van say_dialog("samu_section_what_are_y_0");

  level.player say_dialog("sect_i_m_gonna_hit_him_he_0");

  if(!flag("harper_dead"))
    vh_van say_dialog("harp_it_s_suicide_0");
  else
    vh_van say_dialog("samu_i_hope_you_re_sure_a_0");
}

vo_eject_collision() {
  e_player = level.player;
  e_harper = level.convoy.vh_van;
  e_player thread say_dialog("shiiiiiiiit_082");
}

vo_eject_f35() {
  e_harper = level.convoy.vh_van;
}

vo_hotel() {
  e_harper = level.convoy.vh_van;
  e_player = level.player;
  e_harper thread say_dialog("septic__those_dro_008");
  level.f35 thread say_dialog("missiles_offline_037", 2);

  if(flag("F35_pilot_saved"))
    level.f35 thread say_dialog("death_blossom_offl_035", 2);
}

vo_to_implement() {
}

vo_f38_target_lock_on_and_off() {
  level endon("dogfight_done");
  self endon("death");
  level waittill("dogfights_story_done");

  while(true) {
    level waittill("missile_turret_locked");
    self thread say_dialog("target_locked_034");
  }
}

vo_player_strafed() {
  level endon("dogfight_done");
  e_harper = level.convoy.vh_van;
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "shit__theyre_all_019";
  str_dialog_array[1] = "warning_h_incoming_026";
  str_dialog_array[2] = "warning_h_enemy_lo_029";
  str_dialog_array[3] = "evasive_action_req_033";
  str_dialog_array[4] = "damn_i_cant_shak_020";

  while(true) {
    level waittill("player_being_fired_on");
    e_harper say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size) {
      n_current = 0;
      str_dialog_array = array_randomize(str_dialog_array);
    }

    wait 5.0;
  }
}

vo_player_shot_down_drone() {
  level endon("dogfight_done");
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "come_on_you_basta_022";
  str_dialog_array[1] = "ive_got_you_now_023";
  str_dialog_array[2] = "got_him_024";
  str_dialog_array[3] = "thats_a_hit_025";

  while(true) {
    level waittill("player_shot_down_drone");
    level.player say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size)
      n_current = 0;

    wait 5.0;
  }
}

vo_f38_shot_down_drone() {
  level endon("dogfight_done");
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "target_destroyed_037";
  str_dialog_array[1] = "enemy_neutralized_038";
  str_dialog_array[2] = "air1_got_him_0";
  str_dialog_array[3] = "air2_target_eliminated_0";

  while(true) {
    level waittill("f38_shot_down_drone");
    level.player say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size)
      n_current = 0;

    wait 5.0;
  }
}

vo_lost_lock_on_drone() {
  level endon("dogfight_done");
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "target_destroyed_037";
  str_dialog_array[1] = "enemy_neutralized_038";

  while(true) {
    level waittill("f38_shot_down_drone");
    level.player say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size)
      n_current = 0;

    wait 5.0;
  }
}

vo_f38_fired_cannons() {
  level endon("dogfight_done");
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "air1_engaging_0";
  str_dialog_array[1] = "air1_nose_cannon_firing_0";
  str_dialog_array[2] = "air1_come_on_you_son_of_a_0";

  while(true) {
    level waittill("f38_firing_cannons");
    level.player say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size)
      n_current = 0;
  }
}

vo_f38_fired_missile() {
  level endon("dogfight_done");
  n_current = 0;
  str_dialog_array = [];
  str_dialog_array[0] = "air1_i_have_lock_0";
  str_dialog_array[1] = "air1_firing_missiles_0";

  while(true) {
    level waittill("f38_firing_missile");
    level.player say_dialog(str_dialog_array[n_current]);
    n_current++;

    if(n_current >= str_dialog_array.size)
      n_current = 0;
  }
}

vo_plane_very_damaged() {
  level.player say_dialog("warning__structur_044");
  level.player say_dialog("damage_warning__043");
  level.player say_dialog("warning__structur_044");
}